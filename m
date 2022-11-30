Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9371A63D1CA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiK3J0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiK3JZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:25:59 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9922C2A967;
        Wed, 30 Nov 2022 01:25:58 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id n205so18140623oib.1;
        Wed, 30 Nov 2022 01:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zbHI1uW0B/bUDnJ0AXXSb3CdFb68rbl4AKwLYqiwj+I=;
        b=dRrlLbN0dLYqYxMdXq7PcZcM4pdcMPyjUPM2N9Qjrli6oFHMVq7YxmOxGIpd8dSRvH
         NBF2HhAlED9O8eMR7sNTiEwORU2jjLUjMflfhp5R+zrL8I3/Dt4pTfx2EVgeElo51j+H
         JPUaZZrF11poDygHcDSfMJWwGFntVzLAxxu2Qoym+YtgtAHUBKbvBuHd+9W1OX3svlwU
         3jKitxJ8Ib6CzUMJFed9mwvjXPMZ6pj05dpWGgCBYZpuGOLjfm+dFSKNwBzoxafGuBXs
         iD8OFthAgUF7AW/eBkzmVKY/7tfIXBybf6g+waWeF67esSNNhYTU1w3XgLBX3Som0iS2
         Md5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbHI1uW0B/bUDnJ0AXXSb3CdFb68rbl4AKwLYqiwj+I=;
        b=6EN8JWyWW66NU+yU/rVwRfiaWFdXT+5CibREpjqJcDlfyJBdQ7I5oLebBvd+HNFhwX
         vFu/Cted8ASUkWG9QQv0v6ywCQEjoQtMe0018fcVq7lipuh/X3InZxy4op3OfhERlWSo
         GyAkrw143yHVBiVkdo6+eR0ndNQvewwbiXHUqrhZJGZSEKrnnRSlBRIDq+P4gScQ6B9c
         Qy6so8OYMm0PIgpScYzfsi/QUm6E88TR0liLyf4tedwC6ZfTecvf1t3f99BBN8uyq9n8
         fzbiNwiKeu2wxYuTl0DSoiSMYz/j1y8BULRJvFmiCxUfEzbUXTn6ENSJKfOQD2R9/als
         602g==
X-Gm-Message-State: ANoB5pkwkUH1Zv2uI7oQ0hu/3zL5jazHv964o75yjI6fwz6NWAghE0Rf
        +Y0qyuWkae6mCML3+3iBSBCifNZ5MfjdTIqL2uJ5C/Yow6OhUw==
X-Google-Smtp-Source: AA0mqf7CAQ+AKTVLm+ECt9KESEXsJKRM65EWepkH0WhXm5liXbwWk0ortUwnZID/hBWY29xEamAr2C+iGy1fsdT7A1w=
X-Received: by 2002:a05:6808:2ca:b0:359:ca42:419 with SMTP id
 a10-20020a05680802ca00b00359ca420419mr30927505oid.98.1669800357956; Wed, 30
 Nov 2022 01:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20221129140955.137361-1-gch981213@gmail.com> <20221129140955.137361-3-gch981213@gmail.com>
 <98b72494-3188-76d5-2e24-9dc127a8b31a@linaro.org> <CAJsYDVJknDWKMW1tH0M=85tJOPG-HngxhhMzvJpk5qn_Q9mzAg@mail.gmail.com>
 <7b3f97f9-34af-413c-aaad-9108b4f36c51@linaro.org>
In-Reply-To: <7b3f97f9-34af-413c-aaad-9108b4f36c51@linaro.org>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Wed, 30 Nov 2022 17:25:46 +0800
Message-ID: <CAJsYDVKXvJZaqCBx7RSsfVZkKTGdbp78GHA4mvmUdQwyEyGkBQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: leds: add dt schema for worldsemi,ws2812b-spi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Nov 30, 2022 at 5:08 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> And that's exactly what I said - the compatibles should not include bus
> information. The bus information comes from... the bus!

Oh. I thought there will be a conflict if there is a SPI driver and
, say, an I2C driver with the same compatible string.

> [...]
> >>
> >> Why unit address is optional?
> >
> > It isn't. I copy-pasted it from led-class-multicolor.yaml and
> > didn't check the exact regex.
> > I'll fix it in the next version.
>
> Make it required and matching your case.

Got it.

> [...]
> >>> +      default-intensity:
> >>> +        description: |
> >>> +          An array of 3 integer specifying the default intensity of each color
> >>> +          components in this LED. <255 255 255> if unspecified.
> >>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> >>> +        minItems: 3
> [...]
> So this is brightness of each color...

I don't think so.
See the kernel doc for multicolor LED:
https://docs.kernel.org/leds/leds-class-multicolor.html
This property sets the sysfs file multi_intensity while the
actual LED brightness is controlled with another sysfs
file called 'brightness'.
Setting multi_intensity alone doesn't change the LED
brightness at all.

-- 
Regards,
Chuanhong Guo
