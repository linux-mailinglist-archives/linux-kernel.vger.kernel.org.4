Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC153631CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiKUJ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiKUJ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:26:10 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C8B29808
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:26:08 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id d20so13773277ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+MJByTnMwqFDNsOJRywbEHJTVxdXc1FODFlnndoQvM=;
        b=OxL3YBYDuy0EKfPqMOP4P43SDMPvBZAAOgA+tlpImLe+0+c7n1WozE9ntjOAeBStEu
         wbozdVwjaytS2yec1yIVEg0GPeLCc7f7aNctY70s8Vodq7hvT+EWyrLNWA+bJBPXugd2
         hz6e/qAHx7WypMIzFqKgBLdhm3qIIU4xug8hS4lwyNESeSAx+1lfKE+IMkammShLlWhg
         q1+zVsCWWoR+s7KIOIZE61VTtXp6ObCQSxVLZJZRSAIC16uajnUU/8/QLg2+TBDkw0kP
         9DpLKUb445hvZuCTuKQa+N+N0bzPMBN4+cMfoOxCdcjpN0ojhWlCpZCiDW/tuJJMAw0/
         8eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+MJByTnMwqFDNsOJRywbEHJTVxdXc1FODFlnndoQvM=;
        b=MrbkYM3AI3n70XNNWDNU18a2B1L2HwDMm/fHYlXCWEOcbJRirrKqxqUOoGLCr7jVgx
         RG+09xZo0UWlGtYlQ/hlKemp9fNwdOrGUdGJXmSkWVKd0qHcBO2NvKhX/l1RMmdikY8p
         gcOWFLN+ntqGzJS8EnEAPL26uSWbnoBV5SPB6sA5NDJtKp3KA5pFwM+IP4dXO/doOGAp
         6CuGvXDqejlU5uHvaa+MGsiIim/pbP4cAe5y5bSuaoFdiA6pJeImbdGj/qU7VXmQX8Aw
         awHrG6FqaLlS99h6p0RioOqwW0x0b1U7R1M/dj2JtMQjlkvdW2M7luOtR3daDn486Dys
         P7QQ==
X-Gm-Message-State: ANoB5pkf/faxQvVOCkbISI+SPgPhBwb4wxa0cSNSeyOKMCfOXGhLw44E
        7gtzj09BR1P/WlYPCQndQa5KFg==
X-Google-Smtp-Source: AA0mqf5wQX8hvFkeNYT45DwWSz6ZWYKEg4bBeL4gOkFFC0kNxTIOOxM27t4Gt1b4igzcLgwKK7x+Cg==
X-Received: by 2002:a05:651c:2002:b0:278:a1bc:ad26 with SMTP id s2-20020a05651c200200b00278a1bcad26mr331171ljo.235.1669022766439;
        Mon, 21 Nov 2022 01:26:06 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id x19-20020a0565123f9300b004a2cd6d5ad6sm1943333lfa.19.2022.11.21.01.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:26:06 -0800 (PST)
Message-ID: <07554703-94f6-6ab0-c74c-8145c6720eec@linaro.org>
Date:   Mon, 21 Nov 2022 10:26:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/5] arm64: defconfig: enable FSD MIPI CSI2 Rx controller
 driver
Content-Language: en-US
To:     Sathyakam M <sathya@samsung.com>, catalin.marinas@arm.com,
        will@kernel.org, andersson@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, marcel.ziswiler@toradex.com, vkoul@kernel.org,
        dmitry.baryshkov@linaro.org, broonie@kernel.org,
        pankaj.dubey@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1668963790.git.sathya@samsung.com>
 <CGME20221121045301epcas5p1d6195b5dc6cafebfb429044b41d0d123@epcas5p1.samsung.com>
 <3e5e21930e6da6e6d8046fc2e89945dd7449de49.1668963790.git.sathya@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3e5e21930e6da6e6d8046fc2e89945dd7449de49.1668963790.git.sathya@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 05:58, Sathyakam M wrote:
> Add build rule for FSD MIPI CSI2 Rx controller driver support
> 
> This enables CSI2 compatible Camera streaming
> with D-PHY as 1600Mbps default data rate.
> 
> D-PHY interface can be configured for data rate of 800, 1000,1500,
> 1600, 2100 Mbps. The corresponding PHY parameters are set accordin

You need to answer in commit msg to: why? E.g. by describe where it is used.

Best regards,
Krzysztof

