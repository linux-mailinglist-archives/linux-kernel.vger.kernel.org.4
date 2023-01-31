Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6C2682EED
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjAaOMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjAaOMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:12:10 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9942D3C292;
        Tue, 31 Jan 2023 06:12:09 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso7875972wms.4;
        Tue, 31 Jan 2023 06:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/R4cNaGlsB+JAENN+lFknhdQtCKoTDGDjvYT5VqFYM=;
        b=KLWU9qDvFpDnQ3fhhLOgoPPyYREmXlA74zy09RxeXiR2Ge4lmO0vhaqLzO6KUYX/vY
         h7YgZ8ntYzT9r/kbVJIxVUa2hBR1gcqdbHHiQ4bKec3smBEd54Iaq0m657ScJcmU7r3m
         7MaL70yh1SGq6tMtwBkTHPgjpYZc8Smn0yL0qsObaWrK0qlFLWUQSGvpwrqaQzjP7TEL
         rVfR/OoZBqHgkTNlvJBO1FPFBoHixmYgXC8EFze2ZZmRihv6Np4pL+u0N/OK5cJspZWE
         99wM68rUuHjc65mlUNDk3E+PParN5SAzB9n7qDhWm2fL+FuAYgqR+KXoy8HyidR7w4i9
         kElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/R4cNaGlsB+JAENN+lFknhdQtCKoTDGDjvYT5VqFYM=;
        b=ZtVmJdfJ+pv42QfsD6QZUHWv+f2e+SCkYw2Wmjug/Cu36k+CHG1xwmZ/St9jyXyDM1
         KAFBOy45h0tsudl/D72qcyxLVamjtJ/sAK17SMzl9XOa4q4QcQ48FYNz7lGQ6Z2ZAbrg
         UXI/TsrGzqOBrXdXhYW88p+hV9DDVkmmGirWyj6fs5gAsnL8ukuEDQxPZl6zmuGFJi+7
         WwxOger9wBGY/xR89qMBb+1skq+Do3ItFAEWre5baAbUtKvrgdX5yubna5Rjs2lMfX+T
         z3RtdI6kMSgThTiGl5P31/RzkRttDPBC6TftFmKsU/9q/kXRWkXZOmErx0J0l1QEj60t
         12Dg==
X-Gm-Message-State: AO0yUKWhyR8s+OohsMSG4sf3ofJcyMrDkKw1RkZNg5Rwr56WMCj2BFbR
        ndF+9RSBciNUhqNSELXReRE=
X-Google-Smtp-Source: AK7set9EwXOA8F4oRABxg4bp5mFoTsnuoS5+0J4enHwxIm9aAhElvXdHee6OetPeRiI3kJ+ONMmJ4A==
X-Received: by 2002:a1c:f014:0:b0:3dc:4318:d00d with SMTP id a20-20020a1cf014000000b003dc4318d00dmr15157427wmb.11.1675174328167;
        Tue, 31 Jan 2023 06:12:08 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d4c45000000b002be4ff0c917sm14711874wrt.84.2023.01.31.06.12.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jan 2023 06:12:07 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] media: rc: add keymap for Beelink Mini MXIII remote
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <Y9khL5lKbSG61pWI@gofer.mess.org>
Date:   Tue, 31 Jan 2023 18:11:57 +0400
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <38FDB059-5B8B-4885-AF4B-133F12995641@gmail.com>
References: <20230128034117.3983105-1-christianshewitt@gmail.com>
 <Y9khL5lKbSG61pWI@gofer.mess.org>
To:     Sean Young <sean@mess.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 31 Jan 2023, at 6:09 pm, Sean Young <sean@mess.org> wrote:
>=20
> On Sat, Jan 28, 2023 at 03:41:17AM +0000, Christian Hewitt wrote:
>> Add a keymap and bindings for the simple IR (NEC) remote used with
>> the Beelink Mini MXIII Android STB device.
>>=20
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>> .../devicetree/bindings/media/rc.yaml         |  1 +
>> drivers/media/rc/keymaps/Makefile             |  1 +
>> drivers/media/rc/keymaps/rc-beelink-mxiii.c   | 54 =
+++++++++++++++++++
>> include/media/rc-map.h                        |  1 +
>> 4 files changed, 57 insertions(+)
>> create mode 100644 drivers/media/rc/keymaps/rc-beelink-mxiii.c
>>=20
>> diff --git a/Documentation/devicetree/bindings/media/rc.yaml =
b/Documentation/devicetree/bindings/media/rc.yaml
>> index 266f1d5cae51..f390a5d2c82d 100644
>> --- a/Documentation/devicetree/bindings/media/rc.yaml
>> +++ b/Documentation/devicetree/bindings/media/rc.yaml
>> @@ -39,6 +39,7 @@ properties:
>>       - rc-avertv-303
>>       - rc-azurewave-ad-tu700
>>       - rc-beelink-gs1
>> +      - rc-beelink-mxiii
>>       - rc-behold
>>       - rc-behold-columbus
>>       - rc-budget-ci-old
>> diff --git a/drivers/media/rc/keymaps/Makefile =
b/drivers/media/rc/keymaps/Makefile
>> index ec0361b0b758..03bc9a8d355e 100644
>> --- a/drivers/media/rc/keymaps/Makefile
>> +++ b/drivers/media/rc/keymaps/Makefile
>> @@ -22,6 +22,7 @@ obj-$(CONFIG_RC_MAP) +=3D \
>> 			rc-avertv-303.o \
>> 			rc-azurewave-ad-tu700.o \
>> 			rc-beelink-gs1.o \
>> +			rc-beelink-mxiii.o \
>> 			rc-behold-columbus.o \
>> 			rc-behold.o \
>> 			rc-budget-ci-old.o \
>> diff --git a/drivers/media/rc/keymaps/rc-beelink-mxiii.c =
b/drivers/media/rc/keymaps/rc-beelink-mxiii.c
>> new file mode 100644
>> index 000000000000..09b77295e0a3
>> --- /dev/null
>> +++ b/drivers/media/rc/keymaps/rc-beelink-mxiii.c
>> @@ -0,0 +1,54 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +//
>> +// Copyright (C) 2019 Christian Hewitt <christianshewitt@gmail.com>
>> +
>> +#include <media/rc-map.h>
>> +#include <linux/module.h>
>> +
>> +//
>> +// Keytable for the Beelink Mini MXIII remote control
>> +//
>> +
>> +static struct rc_map_table beelink_mxiii[] =3D {
>> +	{ 0xb2dc, KEY_POWER },
>> +
>> +	{ 0xb288, KEY_MUTE },
>=20
> I'm guessing this is the mouse button. It should say so in a comment, =
if it
> is.

It=E2=80=99s not (for once). It=E2=80=99s a rather minimal remote. =
Nothing
as fancy as mouse support :)

Christian

> Thanks,
> Sean
>=20
>> +	{ 0xb282, KEY_HOME },
>> +
>> +	{ 0xb2ca, KEY_UP },
>> +	{ 0xb299, KEY_LEFT },
>> +	{ 0xb2ce, KEY_OK },
>> +	{ 0xb2c1, KEY_RIGHT },
>> +	{ 0xb2d2, KEY_DOWN },
>> +
>> +	{ 0xb2c5, KEY_MENU },
>> +	{ 0xb29a, KEY_BACK },
>> +
>> +	{ 0xb281, KEY_VOLUMEDOWN },
>> +	{ 0xb280, KEY_VOLUMEUP },
>> +};
>> +
>> +static struct rc_map_list beelink_mxiii_map =3D {
>> +	.map =3D {
>> +		.scan     =3D beelink_mxiii,
>> +		.size     =3D ARRAY_SIZE(beelink_mxiii),
>> +		.rc_proto =3D RC_PROTO_NEC,
>> +		.name     =3D RC_MAP_BEELINK_MXIII,
>> +	}
>> +};
>> +
>> +static int __init init_rc_map_beelink_mxiii(void)
>> +{
>> +	return rc_map_register(&beelink_mxiii_map);
>> +}
>> +
>> +static void __exit exit_rc_map_beelink_mxiii(void)
>> +{
>> +	rc_map_unregister(&beelink_mxiii_map);
>> +}
>> +
>> +module_init(init_rc_map_beelink_mxiii)
>> +module_exit(exit_rc_map_beelink_mxiii)
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com");
>> diff --git a/include/media/rc-map.h b/include/media/rc-map.h
>> index 5178dcae5ff7..dadd4d27a760 100644
>> --- a/include/media/rc-map.h
>> +++ b/include/media/rc-map.h
>> @@ -225,6 +225,7 @@ struct rc_map *rc_map_get(const char *name);
>> #define RC_MAP_AVERTV_303                "rc-avertv-303"
>> #define RC_MAP_AZUREWAVE_AD_TU700        "rc-azurewave-ad-tu700"
>> #define RC_MAP_BEELINK_GS1               "rc-beelink-gs1"
>> +#define RC_MAP_BEELINK_MXIII             "rc-beelink-mxiii"
>> #define RC_MAP_BEHOLD                    "rc-behold"
>> #define RC_MAP_BEHOLD_COLUMBUS           "rc-behold-columbus"
>> #define RC_MAP_BUDGET_CI_OLD             "rc-budget-ci-old"
>> --=20
>> 2.34.1

