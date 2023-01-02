Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E749665AE51
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjABInD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjABImz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:42:55 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512912702
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:42:54 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g13so40719563lfv.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 00:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OWvF5+vr/Y64Ptz2w29CVGpnxPAEM00KyTudEWOCB+c=;
        b=ZT3+V6ElE+qywIVBNCUI5U9FbAVjRsbYf3C4VXBQupVxoDIGRh8vvjNIHHGVdr8It8
         xxC9iL49MPBhmU4+xqlEKkSXZ6QFqDvlgxqGqAToAxfJNqyfXbp0NUKGPQoAptXRNt1R
         CJ97hCqwb6kKE1UK7ECHKtTFCWIIwlV7vxLcFHGzFdbdZOot91ZxmX32B9fp3wiDG+fx
         0XrgA9lDEMYPdkvdr7mVupbNabQbvvC8nsX/9/wYCDfksIkWkfvUBhK5lzIuIJ/8auwm
         LUpeRk5xN/+EWYcfRawdXQMtn6T8rn+aZ/SwKixMMvgiqclRGQ9xP0ciSNci+4JPj8YR
         b/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWvF5+vr/Y64Ptz2w29CVGpnxPAEM00KyTudEWOCB+c=;
        b=SbpTgc3gf4Ir9VFXS5ULTy9vVHB55th5vMxWqBh2PmbnzkuoxkAUk7LAGagYTb5Zg2
         iM5vr8sEkUfrh1qycLOb7YeewrZmOqC66jRIeMX7lRvAo+zl3r97qjDZje1G2zDDP6wr
         Xm0Huvmtdq5wbe8g+9sk70ac8syi4uskpo/JIF97smBs5ASckxndiDYyiTyhWG85gkMJ
         YWjKcx8sKr4W4ru7kGvAQMPJf3605uYFeWLNdSAbBBqH+39FWiHfVYXqzBx7+1xuRgO1
         0OQzc4bs4KQb+vRD6d71ElO278Gfg8SK0uAn1G2VX4G8MlMWNcBDFHKVuKmQF/Du7JAX
         ZkUw==
X-Gm-Message-State: AFqh2kqaNK1XgPnAyc0CiifK0XcvzYIcT6loDuVHMAulq+ffYJipQbTx
        7lIENmubsuNq3JdOF6T15bx++w==
X-Google-Smtp-Source: AMrXdXsI4Ou649kbQ8+5XYPK7FkTEVxjQoPyOjEeO2mPSLjGXHq6vU8R37Zp83JxoSfEjInJjEMGUw==
X-Received: by 2002:a05:6512:3c88:b0:4b4:e4a1:2fc6 with SMTP id h8-20020a0565123c8800b004b4e4a12fc6mr13368192lfv.68.1672648972742;
        Mon, 02 Jan 2023 00:42:52 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bi2-20020a0565120e8200b004b543f38b7csm4428375lfb.21.2023.01.02.00.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 00:42:52 -0800 (PST)
Message-ID: <ddc1153f-6b73-4c37-8b36-891a84ace081@linaro.org>
Date:   Mon, 2 Jan 2023 09:42:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFT PATCH] arm64: dts: qcom: sc8280xp: remove GCC from CX power
 domain
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221230155502.115205-1-krzysztof.kozlowski@linaro.org>
 <20221230171619.om5mfvsp7gwatvu6@builder.lan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221230171619.om5mfvsp7gwatvu6@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2022 18:16, Bjorn Andersson wrote:
> On Fri, Dec 30, 2022 at 04:55:02PM +0100, Krzysztof Kozlowski wrote:
>> Bindings do not allow power-domain property in GCC clock controller and
>> documentation does not indicate that GCC is part of VDD_CX.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Maybe the bindings should be fixed? Maybe this was added as workaround?
>> Anyway looking at documentation I do not see such relation, except
>> downstream vdd_cx-supply (which is the same as in other SoCs and we do
>> not represent it in upstream).
> 
> The GCC itself is powered by CX and the GDSC power-domains exposed by
> GCC are powered by CX.
> 
> It's fairly recently that we started attempting to scale CX - and
> attempted to suspend things. But this is probably how it should be
> represented on all platforms.
> 
> 
> So let's fix the binding instead.

Sure.

Best regards,
Krzysztof

