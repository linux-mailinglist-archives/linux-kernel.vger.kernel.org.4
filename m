Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFBE6CD265
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjC2G7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC2G73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:59:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527EC213B;
        Tue, 28 Mar 2023 23:59:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w9so59298958edc.3;
        Tue, 28 Mar 2023 23:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680073167;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gKh61HV7ZVYfkPUeFh0z5LhhqycdLMzOgNFh+Ol0kxQ=;
        b=lpeVmmR0EPpW0ZAxv3DjLEVL/YaVkHvRlye2oXLbKgp6r/mZYErD+gPgqNAVh9ayda
         iZPjydr0jV8Tz4CdcDgpDWlrJEXMnjPMlwy51sqAdMmsFSPxzvIC49M5Hfo7afMlBvX0
         4/syYPxCt1FvlzwobrKgZB7lV4ttCUkWPI+xg6AhVFNM8EqaG5poM6kL5XbDzIY1AYlU
         a/63gNDX4+hloupulcaqUp944Jgw5fX2lZp40vcNUj5EfOcP1WT+hYFzU4ab63JBB618
         84iF3RwNXEG22y4lcwxOcjDcRBK3jQ9vfFvdcVb/HmUkXI2Dq2d5eIxsgmenq/2l6RXF
         zPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680073167;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKh61HV7ZVYfkPUeFh0z5LhhqycdLMzOgNFh+Ol0kxQ=;
        b=21gBXB5KVj9zgsim8asJJCN4uEPcqOf3bvOwCsN6WLWuQp3fBfFBhLhFmfE1XTcb8x
         J9BdQ/bYsQaaeHJsQinuM9DGWCPsYbswFsSWxyvyoqOLLaVDLMGbXiinP+C43kxhsXvQ
         /bnVaKYKm/4YPBM6hAhXtH0pXHe002h92hmkuK0VYO1gJSDARW9cT1fH0TTmbWWFuHTl
         EifDJwxtshEcAz1Ma6iZqsnO0mOMG9GW/bUSDzAippVs3fyywD1dCCNC7+GXD7Rsbw3A
         GohXFrxLFVFS5RFzITKFnz8twurjIVz9dsZnhw4vt9Sk7rokhXnzvp/1trqFYJ36KoN1
         ZLMQ==
X-Gm-Message-State: AAQBX9eN71BDvcTXihhZWw+qptFi3i7PUVMNQ5nCOjC/1yCANFGYn0jd
        Ataz3FiMmAuqiU9XoyAasFM=
X-Google-Smtp-Source: AKy350bYA3PBfYsT2LcUD/djbyPYHeT3YVY9Pbf3IHF9f+2hnCZlWCMJIpi8Gp3ILGgeJBCoF8fipw==
X-Received: by 2002:a17:906:6dd7:b0:931:c99c:480 with SMTP id j23-20020a1709066dd700b00931c99c0480mr19637141ejt.69.1680073166574;
        Tue, 28 Mar 2023 23:59:26 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id d14-20020a1709064c4e00b009336df45226sm13696666ejw.64.2023.03.28.23.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 23:59:26 -0700 (PDT)
Message-ID: <9ba3c559e2fb685c941b02fcfddaeb82aefed6f7.camel@gmail.com>
Subject: Re: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
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
Date:   Wed, 29 Mar 2023 09:01:30 +0200
In-Reply-To: <ZCMMHl5ENSuCstFV@smile.fi.intel.com>
References: <20230307112835.81886-6-okan.sahin@analog.com>
         <20230315175223.GI9667@google.com> <20230315175257.GJ9667@google.com>
         <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
         <ZCLi6MB/aHIf4lMr@smile.fi.intel.com>
         <cdd53e29ca3d8dbfdfa1a2520935e2bf9418313d.camel@gmail.com>
         <d2bed74b-9eb9-45af-8f45-ad2c2889024a@sirena.org.uk>
         <fc07de9af0b691fbd3a5915c8293f0c7ad4c4e06.camel@gmail.com>
         <ZCL7J5a7UZVayQVS@smile.fi.intel.com>
         <60bbad1b38b8e3c9c3efefb0fb7b8d3cad7fa98c.camel@gmail.com>
         <ZCMMHl5ENSuCstFV@smile.fi.intel.com>
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

On Tue, 2023-03-28 at 18:47 +0300, Andy Shevchenko wrote:
> On Tue, Mar 28, 2023 at 04:51:18PM +0200, Nuno S=C3=A1 wrote:
> > On Tue, 2023-03-28 at 17:35 +0300, Andy Shevchenko wrote:
> > > On Tue, Mar 28, 2023 at 04:18:30PM +0200, Nuno S=C3=A1 wrote:
> > > > On Tue, 2023-03-28 at 14:46 +0100, Mark Brown wrote:
> > > > > On Tue, Mar 28, 2023 at 03:26:44PM +0200, Nuno S=C3=A1 wrote:
> > > > >=20
> > > > > > IIRC, regmap_read() is not really reentrant and it is used
> > > > > > in
> > > > > > the
> > > > > > IIO
> > > > > > driver on the sysfs interface. So, yeah, I think you need
> > > > > > the
> > > > > > regmap
> > > > > > lock and better just leave the config as is. Yes, the lock
> > > > > > is
> > > > > > opt-
> > > > > > out
> > > > > > so let's not disable it :)
> > > > >=20
> > > > > All the regmap operations are fully thread safe.
> > > >=20
> > > > Even if 'config->disable_locking' is set? I think that is
> > > > what's
> > > > being
> > > > discussed in here...
> > >=20
> > > In case the driver has its own lock to serialize IO how on earth
> > > the
> > > regmap
> > > lock is needed. That's what I asked the author of the driver. He
> > > told
> > > the code
> >=20
> > Well, if the driver has it's own locking, then sure we do not need
> > regmap's lock...
> >=20
> > > doesn't require the regmap lock, and I tend to believe the
> > > author.
> > > So, why to
> > > keep it?
> >=20
> > However, if you look at the adc driver, I can see plain
> > regmap_read()
> > calls without any "outside" locking.
>=20
> Then author of the code should know what they are doing. Right?
>=20

In theory yes, but you know that's not always the case :)

- Nuno S=C3=A1
