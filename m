Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4112D693EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBMHXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBMHXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:23:21 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66AE10E1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:23:20 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so16033519pjq.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=28rplcL4D/qDPmWP5rk6Z+mEUTNmDCqkcOMS7T2tEO8=;
        b=yggaRBvwQEynN+qw8PEhbFMx25K9uho58IDv63QptVNsQxcLpTwzn9vf14Y/oF8VW9
         9oLGvt6aH3k+OH2rWpQLqqc2z5W7Ste/PUTj7m9XFQ0CinC1ZQzJIAQH7jOfBWeMHc+X
         /egFqJLireBHpqH2ENmfZp+Ivu2mglivq7pDHJ42pcnOInRdFUeAYMIBQmXz43yFktjC
         yytLVAXL1pHd0iSga8zq51EXUSsQ+XrLrAU1j4Jzxh6WIf98J+bzJSqdfR6Biv5H0odu
         TkJLNvf0scuaNRkIhDpvn4sUD3HtAhpk0KEAupj+LmcbUf11MGwyGljbvZaGIw7KZFEC
         fDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28rplcL4D/qDPmWP5rk6Z+mEUTNmDCqkcOMS7T2tEO8=;
        b=gKpCl8bgZja7ZzNz/KvHrbkXNilB/SHqUY9Oi1aJHTbjRB6kYiowR3XXKBY47rpOzv
         RaGG2H9M2/y7C+goTLY14askTTZqykTa8p0KUE4Q1jj030d4Ec5SHnfJWWNES5h86Hdu
         0odIJfsfUfMJwnluaekTghBgi5PUQX18QEJ5HsmIXLJi+R7MXpJ63tRy8BsguD1REvV3
         ZTqGONC5AP/QFrRNJEPKkvEHSoe9cIIyQxHR9j6xxPjqVbqHCjgcOGYJIt+h9wiURNMh
         UaYT8FbiTMTdEBgPoskxRwaexss4sGpVKxjYZBR/9znn6VMWlL44lp4OKB3sNVogeFHY
         Ib6w==
X-Gm-Message-State: AO0yUKX+xunlQFy2Ry6A/XgENqQ0g8SSKUprkCg+zbYSroYkP4e+mNl6
        BUpGoL8mDT0wkX5dbqdAtROa
X-Google-Smtp-Source: AK7set9MfNTrMMkgBAI61iSDCPJH69eVWMRxjJs/L6IPDCjCYbfxzdtAOVWwWqDZe3fAi56VXOcLaA==
X-Received: by 2002:a05:6a20:3c92:b0:c0:be63:75e5 with SMTP id b18-20020a056a203c9200b000c0be6375e5mr27450255pzj.33.1676273000175;
        Sun, 12 Feb 2023 23:23:20 -0800 (PST)
Received: from thinkpad ([117.217.182.252])
        by smtp.gmail.com with ESMTPSA id y21-20020a634b15000000b004eca54eab50sm5763991pga.28.2023.02.12.23.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 23:23:19 -0800 (PST)
Date:   Mon, 13 Feb 2023 12:53:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, thunder.leizhen@huawei.com,
        festevam@gmail.com, lee@kernel.org
Subject: Re: [PATCH v5] dt-bindings: leds: Document commonly used LED triggers
Message-ID: <20230213072311.GC4375@thinkpad>
References: <20230213070827.5085-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230213070827.5085-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 12:38:27PM +0530, Manivannan Sadhasivam wrote:
> Document the commonly used LED triggers by the SoCs. Not all triggers
> are documented as some of them are very application specific. Most of the
> triggers documented here are currently used in devicetrees of many SoCs.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v5:
> 
> * Rebased on top of v6.2-rc1

Noticed that Lee is now maintaining LED subsystem after sending v5.
So rebased the patch on top of lee/for-leds-next branch and sent v6.

Thanks,
Mani

> 
> Changes in v4:
> 
> * Removed the sorting of triggers
> * Removed the "items" as they were not needed
> * Reworded the description
> * Dropped Zhen Lei's tested-by tag as the patch has changed
> * Added kbd-capslock trigger
> 
> Changes in v3:
> 
> * Rebased on top of v6.1-rc1
> * Added WLAN Rx trigger
> * Added tested tag from Zhen Lei
> 
> Changes in v2:
> 
> * Added more triggers, fixed the regex
> * Sorted triggers in ascending order
> 
>  .../devicetree/bindings/leds/common.yaml      | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
> index f5c57a580078..d01a52e9e982 100644
> --- a/Documentation/devicetree/bindings/leds/common.yaml
> +++ b/Documentation/devicetree/bindings/leds/common.yaml
> @@ -98,9 +98,44 @@ properties:
>              # LED alters the brightness for the specified duration with one software
>              # timer (requires "led-pattern" property)
>            - pattern
> +            # LED indicates mic mute state
> +          - audio-micmute
> +            # LED indicates audio mute state
> +          - audio-mute
> +            # LED indicates bluetooth power state
> +          - bluetooth-power
> +            # LED indicates activity of all CPUs
> +          - cpu
> +            # LED indicates disk read activity
> +          - disk-read
> +            # LED indicates disk write activity
> +          - disk-write
> +            # LED indicates camera flash state
> +          - flash
> +            # LED indicated keyboard capslock
> +          - kbd-capslock
> +            # LED indicates MTD memory activity
> +          - mtd
> +            # LED indicates NAND memory activity (deprecated),
> +            # in new implementations use "mtd"
> +          - nand-disk
> +            # No trigger assigned to the LED. This is the default mode
> +            # if trigger is absent
> +          - none
> +            # LED indicates camera torch state
> +          - torch
> +            # LED indicates USB gadget activity
> +          - usb-gadget
> +            # LED indicates USB host activity
> +          - usb-host
>          # LED is triggered by SD/MMC activity
>        - pattern: "^mmc[0-9]+$"
> +        # LED is triggered by CPU activity
>        - pattern: "^cpu[0-9]*$"
> +        # LED indicates power status of [N]th Bluetooth HCI device
> +      - pattern: "^hci[0-9]{1,2}-power$"
> +        # LED indicates [N]th WLAN Tx/Rx activity
> +      - pattern: "^phy[0-9]{1,2}(tx|rx)$"
>  
>    led-pattern:
>      description: |
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
