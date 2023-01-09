Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB248662248
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbjAIJ7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbjAIJ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:58:41 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9AF12A9F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:56:39 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bn26so7590741wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ucix0OBiv7pnws0HUkHG1wRxU3nrsuX1oLuRKY4B+x8=;
        b=fFIqJhysPZBQjF5Q2s2pLaF5ZnkjewDhWpS4zmigf8XPRMfjOu2MudpAHwc1R/ytuj
         yKxb0hofDuESI/zYMaxqmr2mIcCFNAfaACzAbUmV8qDnXgdV03ULerRB/4GS3rgahJc3
         EuWSBAUaNhh76M+nvmggvt809b0yYhyDXYsGJvXK5HUrSV9zOGk0MYx0Fmjmw9R67P5m
         FG2qgob40Vy5KbQS5PJY+LurkQBx6d1LXtFvFWLSOH2IVzejg1T2TZXeypZAvU/qZeBm
         rgTa9NInAkxDAZVkni9HCy38hMUIXFqAyxofuWX8eFFWCgTaO7SOHCxdz3k1e1gLiwEq
         0UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ucix0OBiv7pnws0HUkHG1wRxU3nrsuX1oLuRKY4B+x8=;
        b=xv+w7uQ98WTNknVtzN1SnaJ5xksQ/BHEYuFEzSYosVqlXB2OHl8rejnrDUvkEUoeGk
         VI5WP7LlH4UqU4zjnKHirJ+JJHiM2y9dln9a7gatczfcvkZz2t7CcTAuz/DcEMeZ2TEQ
         86rdWiZNNapCVxCU7hfnMjFAJR74AcUHbIFvObaC/riDJZ076GKMkHHmeAB606ny9fXy
         0npgZ55UAGvBEcznxwIdi40qx8vALVNeFlDHI8ICm/i8SDgX0KYSYDNJ53gHkNyhOunB
         FBYrHGdNbYUWzGrNJSeECZR6HZr0ngNUtF7zzvu6ivr0Qw6iN0kXrAzPoZ9fZozM5NNq
         BtaA==
X-Gm-Message-State: AFqh2koP85aAWJNPSD6g9TIDxvROikGlgHEQEpKA0zxqYdeqo7CBdLe3
        akFrM/ajkXsSQoI7rse7BFMU3A==
X-Google-Smtp-Source: AMrXdXsNcAUWJK52QwJi7qaNyyv/FChrpQExKc4D+1YAq9QLd9Nd5vrN1QV6/hyGYQ+76vm3eXFt3g==
X-Received: by 2002:adf:fc4a:0:b0:27e:315e:d279 with SMTP id e10-20020adffc4a000000b0027e315ed279mr30765596wrs.32.1673258197651;
        Mon, 09 Jan 2023 01:56:37 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l7-20020a5d6747000000b002b57bae7174sm8178050wrw.5.2023.01.09.01.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 01:56:37 -0800 (PST)
Message-ID: <e1404bf7-d793-7940-8d53-05023491991d@linaro.org>
Date:   Mon, 9 Jan 2023 10:56:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 3/3] dt-bindings: firmware: qcom: scm: Separate VMIDs
 from header to bindings
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Loic Poulain <loic.poulain@linaro.org>
References: <20230109093947.83394-1-konrad.dybcio@linaro.org>
 <20230109093947.83394-3-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230109093947.83394-3-konrad.dybcio@linaro.org>
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

On 09/01/2023 10:39, Konrad Dybcio wrote:
> With changes to the rmtfs binding, secure VMIDs will become useful to
> have in device trees. Separate them out and add to include/dt-bindings.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v2 -> v3:
> New patch
> 
>  include/dt-bindings/firmware/qcom/scm.h | 16 ++++++++++++++++

Ah, and filename matching bindings file or compatible, so "qcom,scm.yaml".

>  include/linux/qcom_scm.h                |  7 ++-----
>  2 files changed, 18 insertions(+), 5 deletions(-)
Best regards,
Krzysztof

