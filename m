Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F59F63FA6E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiLAWUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiLAWUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:20:47 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C22BEC71;
        Thu,  1 Dec 2022 14:20:46 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id v13so3578248oie.3;
        Thu, 01 Dec 2022 14:20:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3j3bEeuDoIsUBAWa7/8QM9wLDVakFUwmm4Xl9cQM6M=;
        b=FbmRQBXDBj0otGs/RAwZ4LDGAE8S18ZQ/T2gBp/mEQcztDUrsHaJxBgAYsupLsHYHq
         U4yVNS6UAHMvuSCZTEYhuz8x+C9QMeUyYl//uPKJmiqg00BgkF/ezM+3oL0JxCg+GFha
         IgHCL7vLdiWZnvoMX7ltv6Jq7P+by1qNev3frjYaq8+cdvOoXECttBMzSY1rIKUwlA0S
         vwSCr0uH8B7rxrx7BcIwupXKJV6dtSpp46lDRrc/V2vq8Cn3XKjgRRpDJF7UxDXlSRMD
         ov+R90xecdtw/vRHyYgAFNnIJlgPYIjdIZr20HhXoG28wTKOZkBpEZ6Dfpte2/NGrBNe
         HCqA==
X-Gm-Message-State: ANoB5pkoUo5Jl+qweMWndDjzi52P/IJ3rEaHvkzHh4pAfmd8IyOaKJLV
        S7NGhPPaDBTtI4I1Hv75oA==
X-Google-Smtp-Source: AA0mqf42MMIFrtz92p86keOLNQSjuFkfAIltsaIbK6cM1FEYGtxgpTNkZpIBNJibSjHO9FIM35KyiA==
X-Received: by 2002:a05:6808:22a0:b0:35b:c6c4:7a33 with SMTP id bo32-20020a05680822a000b0035bc6c47a33mr6829339oib.266.1669933245777;
        Thu, 01 Dec 2022 14:20:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e2-20020a056870c0c200b0013b0b19100fsm3293131oad.32.2022.12.01.14.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 14:20:45 -0800 (PST)
Received: (nullmailer pid 1548625 invoked by uid 1000);
        Thu, 01 Dec 2022 22:20:44 -0000
Date:   Thu, 1 Dec 2022 16:20:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Nikita Travkin <nikitos.tr@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Andrew Davis <afd@ti.com>, Gene Chen <gene_chen@richtek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Luca Weiss <luca@z3ntu.xyz>, Neil Brown <neilb@suse.de>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 0/6] leds: dt-bindings: use
 unevaluatedProperties:false and few fixes
Message-ID: <20221201222044.GB1518960-robh@kernel.org>
References: <20221127204058.57111-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127204058.57111-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 09:40:52PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v1
> ================
> 1. New patch #3: dt-bindings: leds: lp55xx: switch to preferred 'gpios' suffix
>    (Fixing DTS in separate patches, see [1] [2] which superseded [3])
> 2. New patch #6: dt-bindings: leds: ti,tca6507: correct Neil's name
> 
> [1] https://lore.kernel.org/linux-devicetree/20221127203240.54955-1-krzysztof.kozlowski@linaro.org/T/#md1ccb03ee81f820e0c7b8043111d56b5ed0d1e2f
> [2] https://lore.kernel.org/linux-devicetree/20221127203034.54092-1-krzysztof.kozlowski@linaro.org/T/#m17f1d2f79a35fce43509edc351a84bc9dab980c1
> [3] https://lore.kernel.org/linux-devicetree/20221125173602.cnipos5oo4ncxsac@mercury.elektranox.org/
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (6):
>   dt-bindings: leds: use unevaluatedProperties for common.yaml
>   dt-bindings: leds: lp55xx: allow label
>   dt-bindings: leds: lp55xx: switch to preferred 'gpios' suffix
>   dt-bindings: leds: lp55xx: rework to match multi-led
>   dt-bindings: leds: mt6360: rework to match multi-led
>   dt-bindings: leds: ti,tca6507: correct Neil's name

I've applied patches 1-5. 6 should not be applied.

Rob
