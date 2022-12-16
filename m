Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9375564F17A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiLPTLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiLPTL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:11:26 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF52E17594;
        Fri, 16 Dec 2022 11:11:23 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id r11so2724582oie.13;
        Fri, 16 Dec 2022 11:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iICHxs+fVPGU44NzU0jFKB0wNXIsk0IGg9J6YieQbNc=;
        b=3RwJP7szG7sqBa7YIe5UlidZCw4pDL/U1tv86C6kwH53o4OWgPB6mpobit0OoLFVM7
         iYi+C5DlQZ3kwOScuB/+fJ+TBxOJ35SqncrncDbigYfy6ivNzUWgrYIuK6uakH9SPmlY
         gNO8lhXs2miYeDn5DsFqU9IZsZYKHhCdnivXnw7zaJQFrVgruQMlLj4ri3eRIPUSF1ca
         BPnTgiyKV84ZqjZfa0F2HdUXgbLEiN8Tium8p/vC4WakSNmKAIadVfM//jF+dA9FqLg1
         KdMwK+yGboP/iYHPr0bguwU8+0fibo0AwTk7m4QN9x4M+OHa+FQv4wG5N4YKQaKiXtwE
         qStw==
X-Gm-Message-State: ANoB5pm5OxyQW3d8dwMY5hwaaDOvfNt4pLEk4AwQo3KJtjqRCG2cnd4G
        Gv4NZFJ5cgx10RCTyNPUyxew0FsTMw==
X-Google-Smtp-Source: AA0mqf55+U2fyE3OPrwBSS8rTTBYCgKegHzm54AsFVB4oQAfpItuG0ho04zIobJB5bcnReSGZ6WLJQ==
X-Received: by 2002:a54:438d:0:b0:35a:97dd:ba55 with SMTP id u13-20020a54438d000000b0035a97ddba55mr13508024oiv.39.1671217883020;
        Fri, 16 Dec 2022 11:11:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id be4-20020a056808218400b0035418324b78sm1099330oib.11.2022.12.16.11.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 11:11:22 -0800 (PST)
Received: (nullmailer pid 3359747 invoked by uid 1000);
        Fri, 16 Dec 2022 19:11:22 -0000
Date:   Fri, 16 Dec 2022 13:11:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 0/9] dt-bindings: cleanup titles
Message-ID: <20221216191122.GA3358487-robh@kernel.org>
References: <20221216163815.522628-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216163815.522628-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 05:38:06PM +0100, Krzysztof Kozlowski wrote:
> Possible conflicts
> ==================
> 1. CONFLICT (content), choose this patchset:
>    Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> 
> 2. CONFLICT (modify/delete) - files not present in robh/linux.git:
>    Documentation/devicetree/bindings/net/bluetooth/bluetooth-controller.yaml
>    Documentation/devicetree/bindings/power/reset/restart-handler.yaml
>    Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
>    Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml
>    Documentation/devicetree/bindings/media/i2c/st,st-vgxy61.yaml
>    Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
>    Documentation/devicetree/bindings/mips/cpus.yaml
>    Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
>    Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
> 
> Changes since v2
> ================
> 1. trailling => trailing.
> 2. Add tags.
> 3. Rebase on Linus' tree, mid-merge window: v6.1-12782-g71a7507afbc3
> 4. Drop change to power/reset/restart-handler.yaml because it is not yet there.
> 
> Changes since v1
> ================
> 1. "common parts" -> "Common Properties".
> 2. Capitalize titles in other patches doing manual fixups.
> 3. Drop change of quotes in common DMA bindings.
> 4. Drop also "schema" from titles in few files.
> 5. Add tags.
> 
> Merging
> =======
> Intention is to regenerate the commits with commands at the end of merge
> window.  This should go then via Rob's tree.
> 
> Description
> ===========
> The Devicetree bindings document does not have to say in the title that it is a
> "Devicetree binding" or "schema', but instead just describe the hardware.  We
> have several of such patterns, so when people copy existing bindings into new
> ones, they make similar mistake.
> 
> Goal is to get rid of cases:
>   git grep -h 'title: .*[bB]inding' Documentation/devicetree/bindings/
>   git grep -h 'title: .*[sS]chema' Documentation/devicetree/bindings/
> 
> Clean this stuff with:
> 1. Automated find+sed commands.
> 
> Krzysztof Kozlowski (9):
>   dt-bindings: drop redundant part of title of shared bindings
>   dt-bindings: memory-controllers: ti,gpmc-child: drop redundant part of
>     title
>   dt-bindings: clock: st,stm32mp1-rcc: add proper title
>   dt-bindings: drop redundant part of title (end)
>   dt-bindings: drop redundant part of title (end, part two)
>   dt-bindings: drop redundant part of title (end, part three)
>   dt-bindings: drop redundant part of title (beginning)
>   dt-bindings: clock: drop redundant part of title
>   dt-bindings: drop redundant part of title (manual)

Series applied.

Rob
