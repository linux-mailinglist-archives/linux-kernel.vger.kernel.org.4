Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355DC6A1113
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjBWUO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBWUO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:14:28 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC9B279B8;
        Thu, 23 Feb 2023 12:14:26 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ec43so46102447edb.8;
        Thu, 23 Feb 2023 12:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gXQwgZeL/74hBPgk1C6lmiCQBoirI87Yxu5xfVbpD0E=;
        b=kp4aGFtBZoyz9uLGKkaytsS+5gzhr8kJblMcm4O8bMhUdVveKduwcGDToWZdCu8C6U
         oHuVUSL9A3XeOwyooSkxHqEAPbVvTDZrtvm05NO4YYqWxlUeJ/uD44RPCyvOd/xrERnK
         M4DA2hTux8/h75fhMHSAq11A8Tw5KGpsHZx9dPnBe3rgW/DPuEGCSZZs9179fR+5eZYj
         k2XlixpKN4cSE0/eyVllpcVap3faX5SV1R+tN89zygSmUYBO+T6RxrnZT0BZwzgGWE2f
         9eFnYqn4BmHqgyZyFu/PVU2H0XkVAlF9aoUFmg6fE3JT28MBoX09iMoPkVjxyShzJDbb
         9vyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXQwgZeL/74hBPgk1C6lmiCQBoirI87Yxu5xfVbpD0E=;
        b=7n5zQoy+++aRZcgnN5dxLGna7UXS41nKUzPWvrQDsir2SnWgvewg3ExV0sH3SD8pG0
         XSshW7KADeKFW7kMiT2tSaVr1+4ok+uGHdmioGTLq1nSbLBA0EIPrWWHh2JvZRWruKST
         UkCLkRn7szNwpeCpj/lUpErNw9H7g7uNDcgUyQhVlSBp0+iJyGF24V0Z7wEP0Kj8Z/7i
         1Kuop+elAl8B/eDJb9pHysGaVYK7gjFIJkxm1c3WkCOKeHDkvvPpkeY2KwljAzRZRIhC
         b1flnPgozQ1p2baHlEs9DStIxMK7t8EEFEgpC679VFmBBFJ7YHsvD2uv5q33jlzcTzxt
         ezfg==
X-Gm-Message-State: AO0yUKVhSI8fkprilOeSbNk4C7xwn0dspz7FaM34nYTi6JKsDyE5E15J
        ExXogG4FQL9mWEUTfpDRX/D/RHcRwZszFtddglKchKEhUwE=
X-Google-Smtp-Source: AK7set+K+d19g2bT7E4AGeiww4cIACa6p2T/f4jZGdZ4GqaW13JJLwZ8A9ecbJyX+VWi4I3RE+Lg+gFmzolWCQyCzss=
X-Received: by 2002:a50:d544:0:b0:4ad:6e3e:7da6 with SMTP id
 f4-20020a50d544000000b004ad6e3e7da6mr6163318edj.6.1677183264974; Thu, 23 Feb
 2023 12:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20230222210425.626474-1-martin.blumenstingl@googlemail.com>
 <20230222210425.626474-2-martin.blumenstingl@googlemail.com> <319cb654-51f6-6241-802b-22ee0d5b0aab@linaro.org>
In-Reply-To: <319cb654-51f6-6241-802b-22ee0d5b0aab@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 23 Feb 2023 21:14:14 +0100
Message-ID: <CAFBinCCzXb2Ty3TaZatEKQyxJmYPhHDL7SeLfF5-3PsDKBznWw@mail.gmail.com>
Subject: Re: [PATCH v1 RFC 1/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for G12A
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On Thu, Feb 23, 2023 at 10:12 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/02/2023 22:04, Martin Blumenstingl wrote:
> > Amlogic G12A SoCs gained a new "divide XTAL by 2" bit. Everything else
> > (we know about) is identical to the UART IP on GX (GXBB/GXL/GXM) SoCs.
> > Add a new compatible string for this SoC so this new bit can be managed
> > accordingly.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> > Why am I sending this as RFC? The last change in this series means
> > that the resulting .dtbs are not compatible with old kernels anymore.
> > My understanding is that this is fine and only the opposite case (using
> > old .dtbs on new kernels) has to be supported (which is still the case
> > with this series). I'd like to get some confirmation for this.
>
> The other way around is also nice to have, because DTS is used in other
> projects. You fixed here Linux kernel, but what about all other
> out-of-tree kernels, BSDs, firmwares and bootloaders? Did you fix them
> as well?
Indeed, u-boot is of concern here (as mainline u-boot does have Meson
G12A SoC support).

> The question is whether the devices can be made compatible thus keeping
> DTS working on older kernel. This commit suggests they are. Your DTS
> commit is written in different tone - something was broken and is being
> fixed.
If we keep "amlogic,meson-gx-uart" as fallback compatible string then
old kernels (or other .dtb consumers - like u-boot) would still work.
Without the new "amlogic,meson-g12a-uart" compatible string we're
unable to make use of a newly added clock divider within the UART IP
block which allows baud rates such as 1500000 to work without (a lot
of) jitter. Old kernels - with the new .dtb - would still be able to
use serial (thanks to the "amlogic,meson-gx-uart" fallback compatible
string) albeit with limited divider support (so not all baud rates can
be used).
Is this a valid plan?


Best regards,
Martin
