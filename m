Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012845FC86A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJLPay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJLPau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:30:50 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B70D8263D;
        Wed, 12 Oct 2022 08:30:49 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f193so15883418pgc.0;
        Wed, 12 Oct 2022 08:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jgmSGKWiIJIpmvQ8q/p+qHWdSAvJyDT4YhTIosvbO2U=;
        b=lqsttROg2cCrxJ2Bl9FcBPLiU2PO77JZxmRbQppEIbCw40JE4Hma4eaNUJqJWvDFef
         biMxcw/yw2mQRgVWJmG6KxiT2VHCyW9lGM1aIbvpGRRiM3VXkE9a5WiIHcmKBmLoGt9c
         JFofXzrbgVTrOf5WuGZ8hR1Ns6Il9XhkEpqojHHVfFroxh+wWOyfQKTW/c7y4cLQrqM5
         h4he8xr48itJH2jTAcB9z1IVynBEV43U81JlyfbC5L6DD+xMq8LSKYu8SlhqlbM4CD9c
         cbSs1zJ+tP/qPabTWWo8xNUYYI3rh5zzNwOmqGNxXx47PNMZlV6EBm65mtCMXxEDSAU+
         kCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgmSGKWiIJIpmvQ8q/p+qHWdSAvJyDT4YhTIosvbO2U=;
        b=upAhsZvrcHnvgC1VSNeXXILVfOOcMOGpMii7hzP1QtilNl6go0NAdcgqDBwELHzHso
         WkInX151zb7RRSivIs07lO+LGpcY6FOLIFmYfBXGHNnFcSplG1+P3YgeQ5Gs/wnVwAHT
         W0Z8CZfmeqUuwGhe7/rdwPfHe4GMyS330XJRp5DjoJWsDgNxPPR+Nr1XRIKU6q3guLDy
         Jp+buEsQsIRz4CMuQjUINy49v05MoW4QMJ0paA6j73NXSHRX+q3tfZpG2b/IXnbz0p38
         oiNkBz060BDeTeTDZYeDMRi1csWla4IMjbzULXlJRyV/+LIKNlkHN56mXWpdB3oeyah6
         bu4w==
X-Gm-Message-State: ACrzQf2kGChsmbU1qL2OQtuY2ADODg+v9neTNueO2stDjSDxBKl2/YYW
        d6ZiHIhEJTG2aeQE4pp21ns=
X-Google-Smtp-Source: AMsMyM4Rme9GP63iTEYp6GDtI8cANT8/bRXLd6LmA4Ak4TfcpODAEz3uYTWmpmRdtSuWInqPN4hvmQ==
X-Received: by 2002:a63:2c6:0:b0:43c:1f18:a475 with SMTP id 189-20020a6302c6000000b0043c1f18a475mr25922948pgc.186.1665588648509;
        Wed, 12 Oct 2022 08:30:48 -0700 (PDT)
Received: from ?IPv6:::1? ([2607:fb90:370a:3fc:ad3:2951:4f00:9866])
        by smtp.gmail.com with ESMTPSA id a67-20020a621a46000000b0055f98a2c64bsm11804430pfa.142.2022.10.12.08.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 08:30:47 -0700 (PDT)
Date:   Wed, 12 Oct 2022 08:30:45 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_6/7=5D_gpiolib=3A_of=3A_factor_o?= =?US-ASCII?Q?ut_code_overriding_gpio_line_polarity?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Y0agrWGm5CR3Rk5e@smile.fi.intel.com>
References: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com> <20221011-gpiolib-quirks-v1-6-e01d9d3e7b29@gmail.com> <Y0agrWGm5CR3Rk5e@smile.fi.intel.com>
Message-ID: <6D279EC4-6124-45C2-BCBB-D6CBB3385024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 12, 2022 4:10:37 AM PDT, Andy Shevchenko <andriy=2Eshevchenko@li=
nux=2Eintel=2Ecom> wrote:
>On Tue, Oct 11, 2022 at 03:19:34PM -0700, Dmitry Torokhov wrote:
>> There are several instances where we use a separate property to
>> override polarity specified in gpio property=2E Factor it out into
>> a separate function=2E
>
>=2E=2E=2E
>
>>  static void of_gpio_flags_quirks(const struct device_node *np,
>>  				 const char *propname,
>>  				 enum of_gpio_flags *flags,
>> @@ -145,7 +167,7 @@ static void of_gpio_flags_quirks(const struct devic=
e_node *np,
>>  	     (!(strcmp(propname, "enable-gpio") &&
>>  		strcmp(propname, "enable-gpios")) &&
>>  	      of_device_is_compatible(np, "regulator-gpio")))) {
>> -		bool active_low =3D !of_property_read_bool(np,
>> +		bool active_high =3D of_property_read_bool(np,
>
>Defining
>
>	bool active_high;
>
>at the top of the function will save you a few ugly indented code lines h=
ere
>and in the next patch=2E
>

Indeed, but I think the idea was to keep the quirks as independent as poss=
ible=2E
I guess I could split it further into separate functions, like the other q=
uirk handling=2E=20

Bartosz, Linus, any preference here?=20

Thanks=2E=20

--=20
Dmitry
