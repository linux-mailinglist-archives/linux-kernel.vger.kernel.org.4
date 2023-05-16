Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8D07046DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjEPHsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjEPHsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:48:36 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B540423C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:48:35 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso7407166a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684223314; x=1686815314;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4KXsitg53ABiIejn2qRyy6XsTMO/gNpUFQEkxjwXTL8=;
        b=jScC2f3+s5oc3GIlSAa2YdWcCe1Mr6NO4SYx8LSb2fWgnI+097+N+yjqyRUF9sGEB7
         eimkA6naWxyx5M6KYBIF7O+nligTQNWrLxYhtL3L+DK1xlrbQf3KQSC4lReDbx9C0dZN
         eppSIXtOvgUkUV5JLaf9BIOVMKtjiHF4gu2nqRs5itO0L3WH/0hiNBxbf1Mja4YblbyR
         34oHnrbVvP0n6STYfJjR+fbRzqrLFVulAXvGLefUjLenUbePvvsl3x58b5E7L2a7cEW7
         3lkuu/rbt2CxmlAGR4EV1NioLUDC48Vmnwhrpoo4B6Fv3jSiOsM/3TaQJp85LJuVG0tS
         A2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684223314; x=1686815314;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KXsitg53ABiIejn2qRyy6XsTMO/gNpUFQEkxjwXTL8=;
        b=IuYQLbwNsojsLqF6mJajVvMJJ0LENQPg0hYrJcBsDDp58ga781UfjWQJZAC/0vBOdY
         9vozXJtpMcLHSmfVYOkoKhnUTuNA01ATzik5BIgB/BT66TKo8K7xUvMQ6IKuouWi5MxT
         oYp3RrhCo7ULwCP5xDwlflhoU/dygf/Hkh3BCZ8C2GeplvcKj/Q2dkAd+i4RrVkPAuL7
         VWcsk39nkoExEvAJFmwxiAbMTa7y+lyXOjjmbVPbtofgDvDLzI5bYEYkm4LSl9KZ/3Pg
         m6wRw5YblpZlGDnsiMyx7HsYzSzoBTVnRUoDmvX59QgW7pIhjnWA4cqsvUbY9qZFWLD/
         1kEA==
X-Gm-Message-State: AC+VfDxf8876WwvfsSV0bJotM0hTTtTyeNANIBmEIxx+QfeleKeh2+hY
        cCvY+8c7dh3CyI8kNn6l4jWhkA==
X-Google-Smtp-Source: ACHHUZ41uITNS8Zi9afvlrN54ZAfebg6XIkZMITS0qfTaLps5snRYqoKvanGP6EFDauW8OLpcIoGvw==
X-Received: by 2002:a17:90a:d988:b0:24e:20d9:4e5b with SMTP id d8-20020a17090ad98800b0024e20d94e5bmr38295894pjv.9.1684223314579;
        Tue, 16 May 2023 00:48:34 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:6bed:62ca:2e52:e0c5:d0cb? ([2401:4900:1c60:6bed:62ca:2e52:e0c5:d0cb])
        by smtp.gmail.com with ESMTPSA id t23-20020a634457000000b0051afa49e07asm12920492pgk.50.2023.05.16.00.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:48:34 -0700 (PDT)
Message-ID: <17931edb-e6c9-cacb-f3a2-fef85c156080@linaro.org>
Date:   Tue, 16 May 2023 13:18:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 0/5] QTI RB2 features
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230515-topic-rb2-bits-v1-0-a52d154a639d@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230515-topic-rb2-bits-v1-0-a52d154a639d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/15/23 6:34 PM, Konrad Dybcio wrote:
> This short series brings a couple of fixes and features
> (such as display out) for the QTI RB2 board. Similar patches
> for the RB1 should be expected soon.
> 
> Depends on and based atop (in order):
> 
> 20230505075354.1634547-1-bhupesh.sharma@linaro.org
> 20230502053534.1240553-1-bhupesh.sharma@linaro.org
> 20230505064039.1630025-1-bhupesh.sharma@linaro.org
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (5):
>        arm64: dts: qcom: qrb4210-rb2: Describe fixed regulators
>        arm64: dts: qcom: qrb4210-rb2: Enable display out
>        arm64: dts: qcom: qrb4210-rb2: Add GPIO LEDs
>        arm64: dts: qcom: qrb4210-rb2: Enable load setting on SDHCI VQMMC
>        arm64: dts: qcom: qrb4210-rb2: Enable CAN bus controller
> 
>   arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 223 ++++++++++++++++++++++++++++++-
>   1 file changed, 220 insertions(+), 3 deletions(-)
> ---
> base-commit: c768c054f1a722d4b973ddab81ee580b7e24a891
> change-id: 20230515-topic-rb2-bits-22e685b4f48d
> 
> Best regards,

For the series:

Reviewed-and-Tested-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
