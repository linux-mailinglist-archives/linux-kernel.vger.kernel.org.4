Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BAC738734
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjFUOhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjFUOhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:37:34 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E217419BF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:37:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f9002a1a39so43506385e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687358241; x=1689950241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E2nzgFJ0UcKKhFdBcJW4Qki5Cr7fODwtX2iLYSvqDVI=;
        b=ccwzO4T+YWCh07XgozjTsTDf6U+GyCB6iEINFXDkJru7rGYxyzEC83v6QXMbpJL4zb
         rjG2sP4D8l4afWsa3EDe7SahZUfGIFOljh9IREcgP8KD7orEyFnpwrsBwjpa3xrDseRC
         ulYIKU6IU7JF1Z8+5ohONTZ6y+/X/Nfq9snF3ryjM2sEHaOrUVc7o5lCA+nlTahwnKZ+
         QWrP8rJgbyObPYW8V73KMWdBu9PopvzORu8aKcxnsUVYu2kG4KE9IBZltppkhi67+imn
         xVLd5BJrRIfDhrkMhya0DYFnGGlnPzwlOmbs1kdXvLmZAfsj2iTnRStXH2yxKYtPPO3a
         gRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687358241; x=1689950241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2nzgFJ0UcKKhFdBcJW4Qki5Cr7fODwtX2iLYSvqDVI=;
        b=cObCgIURq2NfbusRJmv5QoM7dkwkYfZZQXq/d42YXTzxm0En8n1kH6+wCo0MXXVER3
         R+5O1/gB79/T0wGHTDt/pHUyeViJrWj09KAp4RUAhTPSBDri2SrPkfeJlIS52jaVnoQt
         D8DAYrj3IMi4g4ZMaDQqAmP9TYWRUfWFS2GJRU7ljCbAsXeV3FDNcrz/zzAn3ByNqSXl
         Uzb2Zjt9ZQmaPh1J5fI/aze14SN/DgbROXysTXT0tvOGd7dMriSmaGkL/q/LQhs46SHi
         5uD9y2hSrmiGmWS7/fr4VTdPjpq9izbWq4q9I888tPF6qh1ihmPKWWBqVqSEHnaV7GtU
         oPdw==
X-Gm-Message-State: AC+VfDxD3zh36WH3hslnxGThjFxFA713KuRKDTZ8elYWVU2gHvWgp9sp
        lZrzvinpLM87aWE5BLn7jA9xm9J4ulDfAV4hmIU=
X-Google-Smtp-Source: ACHHUZ5Vmh48i0hExJ+5VdjCgnuo8egMvW9ckVo9v1TF1zTT3rT8zTjlJPeKKjV/+tC426+MW5Wi8g==
X-Received: by 2002:a05:600c:22c6:b0:3f9:b1e7:8a4b with SMTP id 6-20020a05600c22c600b003f9b1e78a4bmr5652292wmg.21.1687358241393;
        Wed, 21 Jun 2023 07:37:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c285300b003f605566610sm16131212wmb.13.2023.06.21.07.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 07:37:20 -0700 (PDT)
Message-ID: <fce2d704-6801-afd9-ea9d-607c7ff8f46c@linaro.org>
Date:   Wed, 21 Jun 2023 16:37:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8350: fix BAM DMA crash and reboot
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20230621143627.189134-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621143627.189134-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 16:36, Krzysztof Kozlowski wrote:
> SM8350 HDK and MTP boards were silently dying and rebooting during BAM
> DMA probe:
> 
>   [    1.574304] vreg_bob: Setting 3008000-3960000uV
>   [    1.576918] bam-dFormat: Log Type - Time(microsec) - Message -
>   Optional Info
>   Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
>   S - QC_IMAGE_VERSION_STRING=BOOT.MXF.1.0-00637.1-LAHAINA-1
>   S - IMAGE_VARIANT_STRING=SocLahainaLAA
>   S - OEM_IMAGE_VERSION_STRING=crm-ubuntu77
>   S - Boot Interface: UFS
> 
> It seems that BAM DMA is locally controller (not by firmware) and
> requires proper initialization by the driver prior to use, at least on
> HDK8350 and MTP8350, but probably on all boards.
> 
> Fixes: f1040a7fe8f0 ("arm64: dts: qcom: sm8350: Add Crypto Engine support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

#regzbot fix: f1040a7fe8f069d2259ab3dab9190210005ceb33

Best regards,
Krzysztof

