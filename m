Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2924E68E249
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBGUyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjBGUxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:53:54 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBF43E63D;
        Tue,  7 Feb 2023 12:53:42 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id d21-20020a056830005500b0068bd2e0b25bso4631034otp.1;
        Tue, 07 Feb 2023 12:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAv9Jpi0KexB9Ih6OJ/eh7c8xwDqoQ2WcLRdyerdHjk=;
        b=TnTY3d9N9LF0DBOfIhBFID1fLTnMV7MtMdcpYpkpmBcliwUvrjPhYmtcUavi0wWqUx
         UK/KiFfUXyQA+3Rw0wIKKJGIJUleGb0rQfugVQBAePKLhPLRt8mQqP3giqHLY8sRTyAt
         3YMy7QTeGtIHSr8yE0A6PForgOitxR3o22mtCEBtr9DeyDyFBKwLGEP5XY1wgib+r7O6
         3tz4slC31B6KiMLwitwu6cDFdB9g6LbQcRAOWlqtyNeerG1oDPCcQZeqiaCDnTlZiZu7
         6Lk7it45TvH+vl23HshWMIm0zRdar0RKcZeeg9t2eiJwv/7bs8Ln+imx2dtICVAlTrgX
         SWPQ==
X-Gm-Message-State: AO0yUKUS8HWCqZjX5xWPhjSLnBDTVBm+AoJY6OgGKyTYjsUQ+zsKygof
        dcM0ISH6MuPSaLCUjHRgwQ==
X-Google-Smtp-Source: AK7set9ZVCI9niJuvxDniBrgzZraDMssmA+Px+EsRdlv5pz3TtkreXukjqhz0oB4qbZ7m8K/9d67Qg==
X-Received: by 2002:a05:6830:1b61:b0:68b:be3a:543c with SMTP id d1-20020a0568301b6100b0068bbe3a543cmr2583599ote.29.1675803221130;
        Tue, 07 Feb 2023 12:53:41 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w1-20020a9d70c1000000b006863c59f685sm7084705otj.28.2023.02.07.12.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 12:53:40 -0800 (PST)
Received: (nullmailer pid 4137152 invoked by uid 1000);
        Tue, 07 Feb 2023 20:53:39 -0000
Date:   Tue, 7 Feb 2023 14:53:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-serial@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Marek Vasut <marex@denx.de>, Lubomir Rintel <lkundrak@v3.sk>,
        Linus Walleij <linusw@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Halasa <khalasa@piap.pl>, linux-ide@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        - <devicetree@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v3 2/3] dt-bindings: reference MC peripheral properties
 in relevant devices
Message-ID: <167580321119.4136851.3959945880355770473.robh@kernel.org>
References: <20230206092624.22922-1-krzysztof.kozlowski@linaro.org>
 <20230206092624.22922-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206092624.22922-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Feb 2023 10:26:23 +0100, Krzysztof Kozlowski wrote:
> Several devices can be attached to memory controllers (or memory-mapped
> buses), thus they can come with additional controller-specific
> properties, e.g. devices wired under Intel IXP4XX bus: cfi-flash,
> intel,ixp4xx-compact-flash, NS8250 serial and MAX6369 watchdog.
> 
> Referencing Memory Controller or IXP4XX bus peripheral properties fixes
> few dtbs_check warnings like:
> 
>   intel-ixp42x-gateworks-gw2348.dtb: ide@1,0: Unevaluated properties are not allowed
>     ('intel,ixp4xx-eb-ahb-split-transfers', 'intel,ixp4xx-eb-byte-access', ... ' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml      | 1 +
>  Documentation/devicetree/bindings/mtd/mtd-physmap.yaml           | 1 +
>  Documentation/devicetree/bindings/serial/8250.yaml               | 1 +
>  Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml    | 1 +
>  4 files changed, 4 insertions(+)
> 

Applied, thanks!

