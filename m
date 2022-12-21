Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A05652FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiLUKma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiLUKmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:42:21 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9DD1C91A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:42:17 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id z26so22846314lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=joBpzBGxI+HyfZcJtjg2KwFF5Csh+tomJAl5bY5MM/0=;
        b=YCtGA4QUwsQcr/pfDJpk1/YgB5UFZZCTuJOonvoOP9/nOKsLXtxCG+Jjapj5V4G6oO
         BbBSad/3HEPw5CmVRwuliEm6+UuvbKX7XNjB00UITj9dW8CzYfdK/H4iC9TQe+0YVO7v
         8Zv2fnsPJmH40Il8gz00HVUvaadfK5X/7DvTy778nH4pLryxKNMt67zSfZLKYSzVXYT2
         R/wSVZXPFTHqttLf+IW/tMuM7J2piGsbe1soWMo1sqYZds2krLERWhB7RWg2edeA2ZVe
         WLNh/kgXPgoElzXfkz3dsK7wRY3PCe21qWFd5FbUN28n5xGlGfW9VeR1GacjqsT8Ozgf
         PcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=joBpzBGxI+HyfZcJtjg2KwFF5Csh+tomJAl5bY5MM/0=;
        b=pW3CW5MdCoYnTg1q4jpN8bZITwNfT42eNCobV9yK3Z0sSCK/oggm6Y3qnOSsWrVAqk
         85NC5H4L3R7wZ8vPUeKn1OJ0FjEGDj2db0yO6+48ZmDRlufxUdj+3sYKSKQl+xjjiojD
         OGxLRw3QYsacGpk5aCBzKUz6uRDm3JrDSuJid0PYn6/P7d5jpYYsXiOIyHMHNMs+fA/5
         fjAGba7sRl4KXrJ66Qg9nJ8Xcltdd8Wfx+b4nq405w854qllMsZxUDzs2DhdkHvY89c8
         G1atF4sA0AvUhkqbh7ICq4rp6zP3ovj3mqakAeWthWEyX83sU+ymxOyifIHIoNFJTUQy
         K2nw==
X-Gm-Message-State: AFqh2kquW2VGIDjYZJYXCa8eLVyMUFKdbTlk1ex+PTgt27gyNF5wVnAX
        kC3Us3QoQ7yoSXt2gQSN6iY1Lg==
X-Google-Smtp-Source: AMrXdXu+xB5HTj5RBdRsDtN7sG/YlSwjJgADrHJIQBLM28hLkg1l5j4Njp6WKim0xfjjt+vRw4NogA==
X-Received: by 2002:ac2:599d:0:b0:4b5:b8a9:b42c with SMTP id w29-20020ac2599d000000b004b5b8a9b42cmr405069lfn.17.1671619336061;
        Wed, 21 Dec 2022 02:42:16 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c15-20020a056512074f00b004b4f3c0d9f8sm1806792lfs.283.2022.12.21.02.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 02:42:15 -0800 (PST)
Message-ID: <f138f9de-4ecf-3126-97bd-668c96612913@linaro.org>
Date:   Wed, 21 Dec 2022 11:42:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] dt-bindings: clock: SC7280: Add resets for LPASS
 audio clock controller
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        swboyd@chromium.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, quic_plai@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com
References: <1671618061-6329-1-git-send-email-quic_srivasam@quicinc.com>
 <1671618061-6329-2-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1671618061-6329-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 11:21, Srinivasa Rao Mandadapu wrote:
> Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
> for audioreach based SC7280 platforms.

Use subject prefixes matching the subsystem (git log --oneline -- ...).
The final prefix should be "qcom,sc7280-lpasscc" and then the actual
subject should drop redundant pieces.

>  ...

Best regards,
Krzysztof

