Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D05623EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiKJJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiKJJcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:32:50 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948A3DEB8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:32:49 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id d6so2050525lfs.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DLrGG9afZTRSq/VDs9kPoqEhvBwGphXAIRIsk/T03ro=;
        b=q7EarRQldf8WBLHDdiSgrCFp0QRzCPuKTS33Qm5FyZoaCOJkYu8/Fdg/GjgeV3m0ku
         k1jcAhFH1foaHlBzwo91kz9LXNQ5W9ySh3pWbCEMC4A/h1AXmQ+/kslHQStyby3gEsrx
         BCExCT0zOpfMy2oZCkJiUD/wtgYjndrt0GyX37OzfrgE0ryJHDjy++GZqfGBy6/ad4cP
         2kyE2TK5R3zRTLpXPJgxoGmX+Rjz9Jr+o7eNBhh5/7f2ZF+ZYXFKJXRxn5G1k/VMjq0B
         n2Sk790N0pbz31ddPVTzdHkTXoC11yawP2yI0kv3X2NX37teF/LqaqJGdrEXMkRVw2Od
         qPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLrGG9afZTRSq/VDs9kPoqEhvBwGphXAIRIsk/T03ro=;
        b=oWSgmVmhGaFaVH0RUOvJQvCSCOfQvlknwNKkYda+2Ffwgw98AshFN4NBSad5fXlW7V
         JjAeit44ipSTPbp5G2PD5r+6MhAj9tDbV/g4q60aCjZgiNd600Nrk38hKJzyZqKO/cCI
         aAmBC3vwNb9Ne4G1bWSFjAM5XdiILuJsfs+bugWBaJnIbEUuoCQGH/2LXaBpEn2pbGub
         uf4BuCbJrL6m7jSx1rww1zrJgjPMS1DLh/1FNJ6EicT2ML3pxRySKRf5z7HWkypRea/l
         Kgjx8xB2cvn8WZ3UQ4bwEjyDQqV1PhXwUJFrTQQSIsbmrhxg+J30rd3MayyRIl/j86B4
         tojA==
X-Gm-Message-State: ACrzQf3IJnszLy6M8+Oh/KCcqQ5mF+qNCe9yVWtTdHy6OOetrXF55BQ9
        lmt0SuensVsCkF15P/lPiDor8g==
X-Google-Smtp-Source: AMsMyM7JWZHzAntJ2SR05J8xHKjMaMhEk0eTyeVRZ5R76RAGSWOpQX0URiu6j77VxJEuKPVp3JsPsw==
X-Received: by 2002:a05:6512:33cb:b0:4a2:9a62:bdd1 with SMTP id d11-20020a05651233cb00b004a29a62bdd1mr20566929lfg.105.1668072767918;
        Thu, 10 Nov 2022 01:32:47 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id d23-20020a2e3317000000b0026df5232c7fsm2577263ljc.42.2022.11.10.01.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 01:32:47 -0800 (PST)
Message-ID: <be450f51-6e1c-a3c1-904f-1f915f0dba5e@linaro.org>
Date:   Thu, 10 Nov 2022 10:32:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: qcom,adsp: Add SM6375 ADSP
 and CDSP
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221109170822.58281-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109170822.58281-1-konrad.dybcio@linaro.org>
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

On 09/11/2022 18:08, Konrad Dybcio wrote:
> Add entries for SM6375 ADSP and CDSP. They are effectively the same
> as SM6350 ADSP and SM8150 CDSP respectively.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,adsp.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

