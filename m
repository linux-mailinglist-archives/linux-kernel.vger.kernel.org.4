Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42ADF674824
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 01:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjATAkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 19:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjATAkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:40:45 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F0F75A20
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:40:44 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so2599054wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0LbFRhRMJlf2xLsMF4AlTp/MwlgXERmEivcTfgD+8E=;
        b=w9eWg93ljKC9J7bK2XikwmcxzfLw+hGrl+cQye6joYldqeUVHjbSv7j6cGG8KD1Qkr
         fqnDqhZKvSwCn9/Dp50CAL01eltnfoqIy2TdEue85hW9mJd50jW3svmdbi7UabiD283H
         9Rk+8SeBu4U2U+07PZd6sU7K0pYtGouUcux9hPb72brQKMaCW4JxmFOdP1nUBI81kYl6
         1lXW70z8Y4hSJAiZNccgGY/xmIjORMOI80A5q45GCsHu9s54XOqmNlaiXEZ1TxU5L7cs
         Sm6Llp58VR3uptmaOj/c559AfTd7WzoyrKNFC2bSDETNvoP9eyP0OUP2zCY4+au3rtwT
         PJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0LbFRhRMJlf2xLsMF4AlTp/MwlgXERmEivcTfgD+8E=;
        b=yTpc6HwDy25EMdhGOIIvYvCQEl6naZyU4vJ4RJaqkICc63ZPAKyhXO7wO6bv3PlfNW
         tmN8lpWsK9W2fE7GQIWy+S9c4CegY7JDDE/volRgm3enmRGkgggdz9tPZ4vzSNaQYsQ3
         IvRS+HZWJ8dJ6Cia20JNTuOY4PflXzHhhgfDIKy0gNvY4BfE80YAEAGhH7NQcaUangyr
         upSwBfMJlUWM0gF2Q5xohAvWFaJppTx3iLOiCS/nNE1bESLX1Hg7cO+FDtoFP8qYznwv
         DakO1uLo6PQnhBvG6VDmB1xLCFDUsen+8huOKAoTOm1P7Jd7CEWkF3CJNcQ8N37MdOtu
         k33Q==
X-Gm-Message-State: AFqh2kpJ3YKfZjnEdsvtd+vAXCYgMRoLx2j1irx89Rpd8buLR6O01PZt
        9Jp1PfAaJ4IraXSwnwcCR2GX2l/VALFYfmPG
X-Google-Smtp-Source: AMrXdXuRmE0MCgYi1FX7tRZC3Jgv2ITsgSSIof3yrkeiJdFLtMzp6Lvblw8faG9vGbqQVeWdtXOL3g==
X-Received: by 2002:a7b:c5cb:0:b0:3d3:4f99:bb32 with SMTP id n11-20020a7bc5cb000000b003d34f99bb32mr11658568wmk.36.1674175243130;
        Thu, 19 Jan 2023 16:40:43 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b003c70191f267sm666499wmq.39.2023.01.19.16.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 16:40:42 -0800 (PST)
Message-ID: <58ec79b0-1b58-48c8-6eea-d6675f34192d@linaro.org>
Date:   Fri, 20 Jan 2023 00:40:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-6-bryan.odonoghue@linaro.org>
 <20230117205800.cqexxwxmtupapy7e@builder.lan>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230117205800.cqexxwxmtupapy7e@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 20:58, Bjorn Andersson wrote:
> Once the remote pulls the "handover" interrupt, it signals that it has
> cast the necessary votes and need no more hand-holding.
> 
> So it's unlikely that _AO is the right choice here.

For the record here's the downstream _AO is what it says

pronto: wcnss@a204000 {
         compatible = "qcom,pronto-v2-pd-pil", "qcom,pronto";
         reg = <0x0a204000 0x2000>, <0x0a202000 0x1000>, <0x0a21b000 
0x3000>;

         power-domains = <&rpmpd MSM8939_VDDCX>,
                         <&rpmpd MSM8939_VDDMX_AO>;
         power-domain-names = "vddcx", "vddmx";
};

---
bod
