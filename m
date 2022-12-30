Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BCD6595FE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 08:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiL3HzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 02:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiL3Hy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 02:54:59 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D51183B5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:54:57 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id p36so30767492lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7y9/9dqJRPgZvL3rwpxNc7byREOsvmcfrCiAJsoPaaY=;
        b=mOLozdir8QpzzKqdRCjek6mwVKVeE1bQZlxTVvBwFq7laAT8Doge7fy5R+Du/JuyAP
         s2JdpA60y3e7KAOo9kiMQZGCTENqjt8a4LzODcj/bPFQi8qetYOrF6jOSqI9DxGTvTLj
         /mibjuxy57lmczyGuNMucB4a/KviIreDtJKXYqikMAnUYSw9mGl2usI9TYk2PsAyeS+S
         Ne7DfQzn4caFqyINKmdziskFK1ozhLl/ux6CK3IzQ/bt4PmpORJ0bUj+y7fDpyu49cwW
         u/W+v/vhgr+976SDapmNwsn+lg79fzulRBVuqDVb+gPW0BkE26vhn/ucTMcxziPAS4kI
         nSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7y9/9dqJRPgZvL3rwpxNc7byREOsvmcfrCiAJsoPaaY=;
        b=AprNkHta2DW9ggf1rOHuFrV4KF0Q8bBcRJaQi/dE5KSfWAI+sZkTWboKuJD52D9k8c
         qhgysUlMdDvtiUXXF+JaU4P00YXZJzgOdhsnxR3Q81cJxFhhkoCjE3lo1srmbvTSqFGP
         95XdwQwejs3PKk06SlfHPhmdoMbuzFqMGMxNYv95L7AtZyW7SikvykMBADFqylBvv7X9
         j32o/cF56Acl54OqfZWEAVRGv1FM6jkFT4a5cILbtf6u+xjDfZ1I3+YFiPLIoeBcHkUl
         PIFzkOAv36nbaEe/QG+ferO1mN2n0MYBNFUXH5ksGRgpSrnuJ7z4hDHWZQkm7vn/ym4V
         2mRA==
X-Gm-Message-State: AFqh2kqegDBay2e83AnhtOwtKB64HM/qgvsk6GUcJMzAmU2U+OtaTvUT
        g7RerkXJ//8TSU2TJ+Dr6s+RhQ==
X-Google-Smtp-Source: AMrXdXt2Xdw3MQFjEugmriAxPXpE2ODwiNibR/Qgt36bOws4pf3FJ9f+luPYT6LlzaLrqbnk5JNTsg==
X-Received: by 2002:a05:6512:3601:b0:4b7:13b:259d with SMTP id f1-20020a056512360100b004b7013b259dmr7853811lfs.48.1672386896122;
        Thu, 29 Dec 2022 23:54:56 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i22-20020a056512319600b004947984b385sm3353055lfe.87.2022.12.29.23.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 23:54:55 -0800 (PST)
Message-ID: <f04570e1-b8aa-be21-b0d6-9f56440c4158@linaro.org>
Date:   Fri, 30 Dec 2022 08:54:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/3] dt-bindings: ufs: qcom: Fix sm8450 bindings
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20221209-dt-binding-ufs-v2-0-dc7a04699579@fairphone.com>
 <20221209-dt-binding-ufs-v2-3-dc7a04699579@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221209-dt-binding-ufs-v2-3-dc7a04699579@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2022 08:42, Luca Weiss wrote:
> SM8450 actually supports ICE (Inline Crypto Engine) so adjust the
> bindings and the example to match.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

