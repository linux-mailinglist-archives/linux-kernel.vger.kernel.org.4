Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465AC623F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiKJKGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiKJKGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:06:08 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC496B227
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:06:05 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p8so2198234lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2AdJhsrJuCd17XVzv1AFyW3WiHJofroqL+A5YSWcKpQ=;
        b=jWMGKnqi1fFNAyt/pMgYYjqh8RhNCfwijW5IgNRMoMD13X3b8U7soTI9fWgq7ZDa+S
         RXsOYmosrKq3QJUzKhdINYzj1Pxf5iYI5U5EiQynoas7GT3xmg4vChtKBhC8VlVX1Jby
         Dy+XP/JA2wHT9QF9zOXYA9EM49B42YFR3TV4PQc76uqTfCJAFpXkzguMOSOTyqHHWh8R
         ADFZ1g6pNDaNILHQjEwL4I67+XbCazsYVLpZGHEQTcV/ORLGlDCSlYRZq0FoUOUqjweL
         xZ4pLz2uPD09z01rsq1kEBLohdYyUwjXaZTEunu0rshWY18W5WadoqsS+zcB6ZelvFGY
         GPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AdJhsrJuCd17XVzv1AFyW3WiHJofroqL+A5YSWcKpQ=;
        b=ynsn+HHuNiQ//Yq4SLPVwB3AQgeL5jgyranO7ljuiOpHjjxMdXKlMcTjjY732AvWJY
         jyP+5GEPhRTU1UgAC+FUY5CLRtuN3uHlJbvOK4W9S64Iqe4cyyn9zZs1AGoHkJ1yTjen
         FLlD/PXR9M7y8jgvwEvSKfU2xtvSsuuOnPWMo882iirgD2JAfJZSfDk4X8HNhcNsaEHE
         tr63DjWbrFtYAU71GhLwkiq+aHU7crjRKXUW37aVE1Z2pU8/TZYnvcXK/Hgkbhhw0khh
         K+7L9QHMXDYx3fRdui1BbPMaLfertoz4lkHdUliC16uVgU9fPIJwj2IcmbgTgi8J1RyM
         kU5w==
X-Gm-Message-State: ACrzQf3GC4e97wIGZ/q7bPefkOvHBU5fuvcgWsn7xSVAxiX01n1xFif3
        ylEtaz9y+qK538C/0RRUBn/BGg==
X-Google-Smtp-Source: AMsMyM5V9WA0E12dujf7GpL24pjVsXlRKKQ7/rvFQbDsd7A/5Zo4zoRLz724vZpWjXx6G06ZN+6P4w==
X-Received: by 2002:a05:6512:139c:b0:4aa:b25c:51f5 with SMTP id p28-20020a056512139c00b004aab25c51f5mr20701651lfa.120.1668074764143;
        Thu, 10 Nov 2022 02:06:04 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id c15-20020a056512074f00b0049476667228sm2694076lfs.65.2022.11.10.02.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 02:06:03 -0800 (PST)
Message-ID: <c16bf765-42b4-fa56-2cf8-5bcae2dda6f4@linaro.org>
Date:   Thu, 10 Nov 2022 11:06:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP
 OCM
Content-Language: en-US
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        saikrishna12468@gmail.com, git@amd.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
References: <20221102070655.247511-1-sai.krishna.potthuri@amd.com>
 <20221102070655.247511-2-sai.krishna.potthuri@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221102070655.247511-2-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2022 08:06, Sai Krishna Potthuri wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Add bindings for Xilinx ZynqMP OCM controller.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Use subject prefixes matching the subsystem (git log --oneline -- ...).

Subsystem is memory-controllers.

Drop redundant, second "bindings" (so "bindings for").

With changes above my tag can stay.

Best regards,
Krzysztof

