Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80E16CC1E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjC1OQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjC1OQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:16:31 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1A1C667;
        Tue, 28 Mar 2023 07:16:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eh3so50275559edb.11;
        Tue, 28 Mar 2023 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680012986;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o8BF/ehITJBHp3Ju3uwCdwMFMpGd+i7nMGTmDLnuUcI=;
        b=hnPE4C0Q7h9pxUBmBlrL7oDdySDwCyieYVRBR+zPXoe+EnhBlsUGmJ+Lo9m2V1Urme
         BsFyMcJdDhSXIHKtizp8DscRzIJX5ob0sk9TRziJMz7nOuqmSUL+v78U+dTlak+xOzOs
         3s6n1CVJ4/5J+Nz9QBQOP3I6D76p0zV354KnkuHUumz+RweDv7aB3V0qJHJZGQKqABrT
         egSq6hS4nf7lJUdLwfe0xVur05L58oagCe3pVXY7C0jHN3jCm2eALB2yi8dqe9r/UEwb
         ies3Z+shbXPoWjpFNDLGcNldcuYd4NBlmDh3t2FlmfOO63RfqnSa2HTWWkoVd2EC8gfY
         RS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012986;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8BF/ehITJBHp3Ju3uwCdwMFMpGd+i7nMGTmDLnuUcI=;
        b=I2AWDYR3rQ+WM0qs6UTXQBoupmRAdi1YlU4tkS8GNJiJyVRDyHnuPIU/m6fTneCuTU
         x5sEhunNZNkSgw5It5hwMQfzKgfPZaA31r8cZKXfTGZfXSiRrJbqT4r+knTCcusUmgJK
         0OLyIYeANdUdOcUuv+tWGXn63aAGT8lDfvI9gRVMtis77z43VqAX4+cfsLbWPkzGBt+N
         fCao8N1+b0MGpp9vzgCoxAgTuz5SUvYPTAULccWN4bj5JMzpVJlnPguU9L9V0iEKVf+t
         Yi/1hZOthDJXUqt5FtdAvfbvh48f/DOirkAzqyPVL+PHJvRJZnSZtfXZr4bu0aH8dQ3f
         sQLw==
X-Gm-Message-State: AAQBX9cpOIKZ5nUfisiHPLSyArKNB2FfZe21K4zXe1ZNV5kMuDsub4DU
        cuHaStRxOzlrnhJ+HKEll9U=
X-Google-Smtp-Source: AKy350aUbgxsVvLvkC0uqI0pB9Kdq2Lm2z5i6pe5hO+ehJ4J+6KSXoRcrVBESwc7JSsIgNRgUdlnkw==
X-Received: by 2002:a17:906:a11a:b0:878:54e3:e3e1 with SMTP id t26-20020a170906a11a00b0087854e3e3e1mr15619559ejy.73.1680012986464;
        Tue, 28 Mar 2023 07:16:26 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906c00800b008e1509dde19sm15205685ejz.205.2023.03.28.07.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:16:26 -0700 (PDT)
Message-ID: <fc07de9af0b691fbd3a5915c8293f0c7ad4c4e06.camel@gmail.com>
Subject: Re: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Sahin, Okan" <Okan.Sahin@analog.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date:   Tue, 28 Mar 2023 16:18:30 +0200
In-Reply-To: <d2bed74b-9eb9-45af-8f45-ad2c2889024a@sirena.org.uk>
References: <20230307112835.81886-1-okan.sahin@analog.com>
         <20230307112835.81886-6-okan.sahin@analog.com>
         <20230315175223.GI9667@google.com> <20230315175257.GJ9667@google.com>
         <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
         <ZCLi6MB/aHIf4lMr@smile.fi.intel.com>
         <cdd53e29ca3d8dbfdfa1a2520935e2bf9418313d.camel@gmail.com>
         <d2bed74b-9eb9-45af-8f45-ad2c2889024a@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-28 at 14:46 +0100, Mark Brown wrote:
> On Tue, Mar 28, 2023 at 03:26:44PM +0200, Nuno S=C3=A1 wrote:
>=20
> > IIRC, regmap_read() is not really reentrant and it is used in the
> > IIO
> > driver on the sysfs interface. So, yeah, I think you need the
> > regmap
> > lock and better just leave the config as is. Yes, the lock is opt-
> > out
> > so let's not disable it :)
>=20
> All the regmap operations are fully thread safe.

Even if 'config->disable_locking' is set? I think that is what's being
discussed in here...

- Nuno S=C3=A1
