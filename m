Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D97960FBDD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiJ0P1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiJ0P07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:26:59 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413FE172B6F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:26:56 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g16so1376676qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9LPbSDa+MBywOmjjYSQBrIxZtqwfqdklED3LdicRb30=;
        b=f1pJAPwVik75oeO3R9Cfh95P3uRLmnpTBaXmTyyd/nK6BAF40G2FI6QJQseH0ZpaMG
         o8NjePfWROUjrYN/H1rYKeLUwFQkzzMlrqHw5CHZuXIXpTQiDep23SYO8hpzqckGzVOu
         IJ38tor/aLMUvF9rtEfUHXoZrYNBli/Rk4gOxXN/r5qxiBk9JgB2tovGeHA0pG8ushbI
         eUQvauYPA9quKmhnbZhgksHvliu1Iy28aOmQWAq4ZppJJepsipSsNtdL+vXiPFLXR/wZ
         Ow3djaDWx0/1L85XReUGe10at7Z2g7e1P5rQHsuYAdIcRpUSEBlsB9kdjd6dqWQXgUic
         Yd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LPbSDa+MBywOmjjYSQBrIxZtqwfqdklED3LdicRb30=;
        b=ZUQBWNb+S+BrolkbVufJYAs8oh4HyZxtVZE6U31pjZNpsj5+nf5OKqPIgHNY784AVf
         VhDluDA2JZspko3pJOT3pWc39dBTXiUIud/DovHGJoYD1xFiShvDNVJwBD/h+tFs5GNO
         YbsUCzxvRL8QW/B0vwI+Sa01gjqz8T2Ife0d5Ah8HQwbwyLCK0BptV+pXZ0sJjjWv59U
         Kf+sL1bGlYZgUL6k7jb1CV3LP/ly0EhhYNq2ibTAn1Lr3u4IvGYlmmdzzP7X17tOtS1a
         HRF9xSntPQsLB7ShiZPQ8McOyj0avBrVa7Z9cfCD43cxbBUcX/TU35F55k1yVsgY49/I
         3gyA==
X-Gm-Message-State: ACrzQf33XfEc6ZZOLdVb+quXVjqthJ12iDf5hcLol/Wbka8Y0ZRN48Eg
        o6C3bpLtCYifnXZhp26QtgEbl1wNrn6D+w==
X-Google-Smtp-Source: AMsMyM4V1nmDJiKVYlT4rp0C1d+f84x0+W0srdAfp3Co9LNggnrL3zdamZcPPzCK4mwZ/oGlcxTqMw==
X-Received: by 2002:a05:622a:1313:b0:39c:ff31:21e0 with SMTP id v19-20020a05622a131300b0039cff3121e0mr9149632qtk.274.1666884415437;
        Thu, 27 Oct 2022 08:26:55 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id o24-20020a05620a229800b006ee7923c187sm1140355qkh.42.2022.10.27.08.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 08:26:54 -0700 (PDT)
Message-ID: <b999144e-5137-6363-9792-8e6cf67e6a82@linaro.org>
Date:   Thu, 27 Oct 2022 11:26:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/2] dt-bindings: arm-smmu: Add compatible bindings for
 QDU1000 and QRU1000
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221026190534.4004945-1-quic_molvera@quicinc.com>
 <20221026190534.4004945-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221026190534.4004945-2-quic_molvera@quicinc.com>
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

On 26/10/2022 15:05, Melody Olvera wrote:
> Add compatible bindings for Qualcomm QDU1000 and QRU1000 platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>

Drop second, redundant "bindings" from subject.

This applies to all your patches and all your patchsets which are for
the bindings subsystem.

Best regards,
Krzysztof

