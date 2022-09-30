Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D635F0B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiI3MGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiI3MGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:06:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44D315AB7B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:06:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a2so6559078lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/Hh3w8b6d9P9uyOgmgV/Rx9H7p7C6KLrvLHtxihZXHE=;
        b=zCEnWtF9CeAcAmKrS2oKa7epm8QDPNoPOYsJNhgn3hN5GysNTeZDZRwEjruIRtF4GZ
         0Nx7t+u4hn48rjUlb8StcZJ4h0E5mPV5j0u7iSNHDcCvWZcIgFuAC17RBwb/z5U+5FWJ
         WBh2pfouO9hYd1uNeitXMlwfU37hS6Jqa+QVjMWGmxrZrWCPDntNmDJt5mLob4clk/oM
         8mjfh3cG25cUX3m8AWp8d+AYTwqZL8/u7LsTQ1rtrGaLL0swc0beVvrLjHeBL5frTFqf
         egEXv5yBbCDNxOexCEiVmGLANncgTmER8zKprVApZKT9wGr5DLG8ExHx00xndcHZhN2g
         xQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/Hh3w8b6d9P9uyOgmgV/Rx9H7p7C6KLrvLHtxihZXHE=;
        b=bafYcXx7OCpkZK2gUmxluBBcz/yB/9/3gf+70z+cmFky4A+J2nPEr5nhp9/oZhJ91f
         dD5kSdd4BgzE/mPpuZb9a23SO8GB/lmSbExssGUDJFOp6rkLqNryTDvjRFJUOHbqv+Gk
         vAPojuGZmPqVJtHtpW6/7b1heYIV/ThoAizTghoAd117/lskmVBtq86rsxTOuiJ5bkOG
         RtTk+ry4Ze9pLukBRY/pDNWJS28AaIdq1RW8RogRfZKe2pydBaD5lkmUwZ0Co/B/us4M
         VmIRCG/HAC8caUnn5J+phK8sx6WXV7etHzIsipQzzeZHlmHW7Ib528SLSAoua30VGerj
         scPA==
X-Gm-Message-State: ACrzQf1jmthjq7GMwqwIWplsyJkk95ob/exGa3FOE6QhcHukBzUL+8F5
        y/PeOE142xWdKPdCXFEb+sxz6Q==
X-Google-Smtp-Source: AMsMyM5Au9/HOnkusXJEyg25z9G0ILNwGEWN2ewb7840+VsT7ezLolNuYLdeVYIW8M8jmfWpp1v/TA==
X-Received: by 2002:a05:6512:1152:b0:4a0:5555:15ee with SMTP id m18-20020a056512115200b004a0555515eemr3553626lfg.38.1664539589099;
        Fri, 30 Sep 2022 05:06:29 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g22-20020a05651222d600b00485caa0f5dfsm278908lfu.44.2022.09.30.05.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 05:06:28 -0700 (PDT)
Message-ID: <1e9a21a3-d6c3-3f76-18dc-ff14e8609846@linaro.org>
Date:   Fri, 30 Sep 2022 14:06:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: linux-next: manual merge of the mfd tree with the qcom tree
To:     broonie@kernel.org, Lee Jones <lee@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220930115816.128513-1-broonie@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930115816.128513-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 13:58, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the mfd tree got a conflict in:
> 
>   Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> 

Thanks Mark.

> between commit:
> 
>   4f2e28b2cc2e0 ("dt-bindings: mfd: qcom,tcsr: add several devices")

It seems this commit was picked by both Bjorn/qcom and Lee/MFD.

> 
> from the qcom tree and commits:
> 
>   f8c1940165bea ("dt-bindings: mfd: qcom,tcsr: Add several devices")
>   a328ae8504dbc ("dt-bindings: mfd: qcom,tcsr: Drop simple-mfd from IPQ6018")

This commit depends on the duplicated one (on "Add several devices"), so
I think all set can stay in MFD and instead Bjorn could drop his copy of
the commit.

If not, please propagate the merge conflict resolution, but not the one
from Mark.

Instead result should look like a328ae8504dbc (from MFD tree).


> 
> from the mfd tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> index d3c25daa995e4,b12809b5cc22e..0000000000000
> --- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> @@@ -15,31 -15,27 +15,27 @@@ description
>   
>   properties:
>     compatible:
>  -    items:
>  -      - enum:
>  -          - qcom,msm8998-tcsr
>  -          - qcom,qcs404-tcsr
>  -          - qcom,sc7180-tcsr
>  -          - qcom,sc7280-tcsr
>  -          - qcom,sdm630-tcsr
>  -          - qcom,sdm845-tcsr
>  -          - qcom,sm8150-tcsr
>  -          - qcom,tcsr-apq8064
>  -          - qcom,tcsr-apq8084
>  -          - qcom,tcsr-ipq6018
>  -          - qcom,tcsr-ipq8064
>  -          - qcom,tcsr-mdm9615
>  -          - qcom,tcsr-msm8660
>  -          - qcom,tcsr-msm8916
>  -          - qcom,tcsr-msm8953
>  -          - qcom,tcsr-msm8960
>  -          - qcom,tcsr-msm8974
>  -          - qcom,tcsr-msm8996
>  -      - const: syscon
>  +    oneOf:
>  +      - items:
>  +          - enum:
>  +              - qcom,msm8998-tcsr
>  +              - qcom,qcs404-tcsr
>  +              - qcom,sc7180-tcsr
>  +              - qcom,sc7280-tcsr
>  +              - qcom,sdm630-tcsr
>  +              - qcom,sdm845-tcsr
>  +              - qcom,sm8150-tcsr
>  +              - qcom,tcsr-apq8064
>  +              - qcom,tcsr-apq8084

This misses ipq6018. Please chose solely the MFD branch/side.

>  +              - qcom,tcsr-ipq8064

Best regards,
Krzysztof

