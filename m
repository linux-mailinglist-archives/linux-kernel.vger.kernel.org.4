Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595CE5BCAEE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiISLkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiISLkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:40:22 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FA01098
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:40:21 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id l12so33496633ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LOhOQBZzBFQxvVFlg60w9WSNTSMawzLUJ3lhh9nsRd8=;
        b=oMDrNnn7PEzlmS/TtiTBujBv+2cvR52V5cwZqrcQvn0yEXxAHFP9XUBasumZsWhL/s
         xXfnxFXa/ujRDAgOMothex/hDTOMFz3I9GxhCV0RPMsdnvWvu1MrFHUmAVJJRRkwX1CV
         btra/q/r/DHfmEg8PuB/kadmHGMfEeddYYU0l9rn8hUSoJugQCQa8CclEI+xUWjokXUe
         076SDXyM+lq0DsOTjgT7DKR2CGfViMFhNpD76L5hFosFOhFu8J1HArLo5J97u3XcqzVW
         7wVys14ir3kTRRAL8BEGpyt4HchglXmWjwYXH0li3WnE79lRj1P91SlfzTmCAU1Ol59k
         HHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LOhOQBZzBFQxvVFlg60w9WSNTSMawzLUJ3lhh9nsRd8=;
        b=2LNy0ombWw/BZjMnRz5YK7hNgAW0Ptn6IWhe2BfKZbHNbA9MQbSx561Ux5HLy1IxVQ
         13Qmq8mWFiSLnUFT4WeoQ1k+ZvDLVhYmXSkTvN3Sthu5elElgVdo16dxVVVDYiwzNUI+
         dfWtCgWCfYExvUlAnC5YPrccQ3o9bF24RcvxovCWDSa6iUSnnpZQ9nR7DXpe0Cth4RJb
         I29q0Wwq1ty6momId/F0Dp8Bk7/UizxvBEw4oLAOZpFGdFJqnd8y45kSO3QvAN2W5KXV
         h6NYuZSwSAO3Oqe/a4H1ELBQcL6Goq3EpndnN+2n6kkngyfAWh5Wp37L1WuXA+KpHw4T
         xPrg==
X-Gm-Message-State: ACrzQf2ryaDMDDr35Bg19PP4Njsmq4yMeYiwmuR22JubPc3zMH9d8ipM
        tunyLeCqfwuFbngYyD9VNJXpTg==
X-Google-Smtp-Source: AMsMyM5yplmebqCLGegjUI9kshg0AL7BDvu6dLs+pjcv0D8b3BXK/yLoY6F6mjlxgpoY47vxzvCTEg==
X-Received: by 2002:a2e:9d98:0:b0:26c:565f:6cda with SMTP id c24-20020a2e9d98000000b0026c565f6cdamr111304ljj.514.1663587619638;
        Mon, 19 Sep 2022 04:40:19 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f3-20020a05651c02c300b00268335eaa8asm4887241ljo.51.2022.09.19.04.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:40:19 -0700 (PDT)
Message-ID: <ab9154fd-26e9-2d8e-c638-860e716ca8e8@linaro.org>
Date:   Mon, 19 Sep 2022 13:40:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] dt-bindings: firmware: imx: sync with SCFW kit v1.13.0
Content-Language: en-US
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220919113715.243910-1-viorel.suman@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919113715.243910-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 13:37, Viorel Suman (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> Sync defines with the latest available SCFW kit version 1.13.0,
> may be found at the URL below:
> 
> https://www.nxp.com/webapp/Download?colCode=L5.15.32_2.0.0_SCFWKIT-1.13.0&appType=license
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8qm-rsrc.c       |   4 +-
>  include/dt-bindings/firmware/imx/rsrc.h | 292 ++++++++++++++++--------

Bindings cannot be squashed with driver change.

>  2 files changed, 198 insertions(+), 98 deletions(-)
> 
> Changes since v1:
> 	Two patches squashed into one in order to keep changes bissectable
> 	and compilable as suggested by Alexander Stein.

That's not the solution. Solution is to make driver behaving correctly,
not squash patches which must not be together.

This is proof of an ABI break, so NAK unless described why it is OK to
break the ABI/users/boards.

Best regards,
Krzysztof
