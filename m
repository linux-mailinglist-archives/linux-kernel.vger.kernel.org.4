Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91D3620B52
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiKHIha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKHIh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:37:28 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFA65F89;
        Tue,  8 Nov 2022 00:37:27 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v17so21348660edc.8;
        Tue, 08 Nov 2022 00:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rBcpmwuR/ODR32oPZ7gdO9KQiR1ADfHBqKZSH0UVkho=;
        b=e4j1eCR1UhFtQybAXCXqziDfdLRUycEpk/7naGJdMUOu4pI6U8USOSWrdlRg1ua+IP
         tdDQIACKuwIaWYopM6cZNwvb378Q51l1yGftXacFsJWHJl2yJH8HqYiPENH29e/Zj7DB
         HxRA7azZ/7nXFkwC4DagnuOc82yl468l2fWKpJhluCtCpsC1TKbaL3T20lwM0ifFxqpU
         5jDRZRVAUhft1F4qoCW5byKCPthBsfo+/M7fgcig74nWZiI2B6ZiXG5Ur5A0HbsojhSK
         2lXaWU4y6slfgD3MyPf/xp65XNaCtXA7FISVcF+BDqPpXubeYeYqItufm1yu/RMEJyCP
         u2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBcpmwuR/ODR32oPZ7gdO9KQiR1ADfHBqKZSH0UVkho=;
        b=B+GJZKYzvZaRiuCVh0ocmCiRWI+54CGwls+kzl3pxKjhiCMBqURybJ4FxXyepKYwCf
         s15L6teVsdcctJy4Xk6HQZ4r0948ISuceNSTDSwmcmzk1HNmGefH5sT7ztdi/6m71LA6
         SJmdl0yi4/REpB37REtpSjR0ifeUt7kQoDAxv+guwSYhbRilhR+gB8GF4dshLUB2yUfA
         bgCX+uluXC4die9lfIVG2YGtBt+ZnCoWUJGk84x9psd+S0FJ8fLYaKHp2AQLhb5e2H26
         dZbn1aMVE7HFNemYxs9qvuAYMtwVDjw1e27GpXTwAPcPuG3O0SJYdoRbQxVa1cWtNAJZ
         DvTQ==
X-Gm-Message-State: ACrzQf2NaWkhL2SOTTWJZl+5ur0Cj34t7kS6VhT5LBTzagnLUdeSgPEW
        BEqdMKVlhTVJOUeQ65W0KLk=
X-Google-Smtp-Source: AMsMyM4EPEB/0Jafx+7+CGq+VrkQ04VdIij6KXFGXzOJRr7vzS9gA0A6MtNcCXd6mZfRmkj20o3Q7Q==
X-Received: by 2002:aa7:c9cf:0:b0:462:f136:d143 with SMTP id i15-20020aa7c9cf000000b00462f136d143mr899540edt.418.1667896645648;
        Tue, 08 Nov 2022 00:37:25 -0800 (PST)
Received: from [10.76.84.153] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ca12-20020a170906a3cc00b0079800b81709sm4399358ejb.219.2022.11.08.00.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 00:37:25 -0800 (PST)
Message-ID: <ba6b64f733aaee22ff85feba467ff01ccb220913.camel@gmail.com>
Subject: Re: [PATCH v4 11/13] dt-bindings: iio: temperature: ltc2983: use
 generic node name in example
From:   Cosmin Tanislav <demonsingur@gmail.com>
To:     Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Date:   Tue, 08 Nov 2022 10:37:23 +0200
In-Reply-To: <20221107181328.GA1354289-robh@kernel.org>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
         <20221103130041.2153295-12-demonsingur@gmail.com>
         <20221107181328.GA1354289-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-07 at 12:13 -0600, Rob Herring wrote:
> On Thu, Nov 03, 2022 at 03:00:39PM +0200, Cosmin Tanislav wrote:
> > From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> >=20
> > Examples should use the generic IIO node name. Fix it.
> >=20
> > Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > ---
> > =C2=A0.../devicetree/bindings/iio/temperature/adi,ltc2983.yaml=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > l
> > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > l
> > index 467e165e9b0b..bd357ff28e65 100644
> > ---
> > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > l
> > +++
> > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > l
> > @@ -420,7 +420,7 @@ examples:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>=
;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sensor_ltc2983: ltc2983@0 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 temp@0 {
>=20
> The DT spec defines 'temperature-sensor'.

Jonathan, could you maybe fix this (replace 'temp' with
'temperature-sensor') while picking it up? Thanks.

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,ltc2983";
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0>;
> > =C2=A0
> > --=20
> > 2.38.1
> >=20
> >=20

