Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30136D1449
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCaApP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjCaApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:45:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9AB1024E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:45:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id q16so26855371lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680223511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQN05jrEVGv/j8FBoYsJo/sMOQRm3hC/TiIil0FkSPY=;
        b=p+U9foyRKNjz8v3ZYpA5h45OiCM29i0K3hLQe5vPDrnIFyBg+TxenLQG+io4GeM5O2
         zEnxWx1ke6LcDhnwhflRoiF24I8f3DDY5BKL1p9r/6XySmvNCUY48rmsgu5my61uCq0e
         AGQDchPAXk9DrjEKB6Sbm4EM4Bzi3nax8QD4iRh2wEx5IdPCu9Ok4BkExACUC50EWFNf
         L46b+foIP/1oJmaAdhHPL3oTHULxzVJ1HhcAtPW2Ttxyra8glmpIZX75nECAAmaAajwW
         jcB2NIdEoapFo1n90wcP+JMAM0CrGt4CLht+71ZWsu++/1FkfMIwXckbrqiTcAosCYGq
         FR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680223511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQN05jrEVGv/j8FBoYsJo/sMOQRm3hC/TiIil0FkSPY=;
        b=gJv5pZCv2YOqLcCXTxIhVVPpxvl2zQN6+sRIaM/uqcb4J21OMGzVDQZipxoO7fVJ5K
         /HchIWdR8GJDFz91yg52AlDtKvRjOd3A33wLJZhCavRQZWAIyutVaDyDhkGeTNdYbjEg
         ERROzq0FaEu80cnkj3YOnBnOYKVIirUBP42gl8U+7Jb4stQnaOJNFUuBr9RWrZDRWLUV
         Cvkief9UURaqk/Jjt9vCkKtH4cA8aVsGHcdaLOTtE09YbMWWGNJg4rA50L5uJ+btWsL8
         anixmn5kn1PMDmFqXIg95QjyRE4r2+brxzvP8CGrwnXvuypOQ56fW0gnj3LPtSuy8k5w
         k+YQ==
X-Gm-Message-State: AAQBX9fRmDaj/ufoOFH3UlEufzfU9QuiRg3hnhLrzA6/GhNYZ/ZQ/6/f
        7PRBgLEaB8svPAj3IR2C/gG+qA==
X-Google-Smtp-Source: AKy350acBLGbZSIry0XSZpEV2vCkgyurthY7kpkA7LVsLiCkoePFW24xiBBht0ImUuQgt8Dvk+JPwQ==
X-Received: by 2002:a19:7419:0:b0:4cb:280b:33c9 with SMTP id v25-20020a197419000000b004cb280b33c9mr7507157lfe.24.1680223510824;
        Thu, 30 Mar 2023 17:45:10 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id z9-20020ac25de9000000b004eb2dab8a61sm149678lfq.44.2023.03.30.17.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 17:45:10 -0700 (PDT)
Message-ID: <87263b92-0bb5-a12e-c94b-58eb91672dc3@linaro.org>
Date:   Fri, 31 Mar 2023 03:45:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: sm8150: Add GPU speedbin support
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230120172233.1905761-1-konrad.dybcio@linaro.org>
 <20230120172233.1905761-5-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230120172233.1905761-5-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 19:22, Konrad Dybcio wrote:
> SM8150 has (at least) two GPU speed bins. With the support added on the
> driver side, wire up bin detection in the DTS to restrict lower-quality
> SKUs from running at frequencies they were not validated at.
> 
> Tested-by: Marijn Suijten <marijn.suijten@somainline.org> # On Sony Xperia 5 (speed bin 0x3)
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8150.dtsi | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

