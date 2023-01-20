Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A914A67482A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 01:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjATAmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 19:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjATAmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:42:08 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933F77E4B8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:42:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b5so3540923wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=weljRA7BwO6FXmcpTYUo9jyIREoLOwef98aMlzObdfs=;
        b=MlegrDNSv7+cGm1r+ndiOYQNt94mHEk8jy/ywxEj+Ditl22/oIBgk5egjgCDpQqSFR
         41L//fY6PrDFnu4eL6fei0zHwRLxJa6/P5Yv+VpxyuK8NUJJ7Gu+TgMTTAhumoGJHGeD
         FMVFQA2zfwJDLxhi+wYJx5Y7wMuRjXqN+zdiNCQP5FmiC0Dr75KsEW/2KpocvOE88L20
         v9NSsg9h+MstptICc2Nricqv7ognjjlR5zzCrvzmIgty6Pj8NAQx45bDgFneZL7PQVY8
         aVuLQIURSn19zoNlq/+g8Xr3dvezhC5ngv3Gt1GSQa0jz5Dhy0UXxiGyNx49tN8LN6z0
         K0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weljRA7BwO6FXmcpTYUo9jyIREoLOwef98aMlzObdfs=;
        b=aBgpMdpLdEAHtNMgeUNWr+ZkZkMTt5BjsfdU3v55h9rbpl+LonvDgUufSwCxFWx3P4
         L60Vmx9bQkeLlW4RH8bi1BrAG3VaKXbYbc5H6AvVVNFjAhKZaGPXmsV3mMFssVzco0Ec
         iGitUtpzMLoRg/dicgad1A7XdMw+EMTOrLVLGud6VxtVhgg5no8TbzSZHHe0uWKd1bkT
         HK5+ntu4+xb8z9KX/l0ToKAna7E6mVMgNMeUm8Pmp/RpPDGq3Xzhtp8u5VQQWKoChrih
         XVbnONlwu3OuSOffOJ1SREy712hdfU5ChPGJzXWZqTVX7KaEmdMqkj8MSeDcFXL9pmbn
         s/JA==
X-Gm-Message-State: AFqh2kpDpW6AlZPjwSI/xX4NRQKomayJVFL2Tohw5kR7EGQQMgeE8YBJ
        cBTEtlAE4xHtgcYUtT0UyMRM5g==
X-Google-Smtp-Source: AMrXdXsS0WNlrFfYfTOegkpyna6zRye3TTLep1NMgpHygm8ESwh6HXyQ4zIZrJ/K7+WYQhgGFjTXFg==
X-Received: by 2002:adf:fa88:0:b0:2bd:feb5:fb7b with SMTP id h8-20020adffa88000000b002bdfeb5fb7bmr10175838wrr.33.1674175324069;
        Thu, 19 Jan 2023 16:42:04 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b0027323b19ecesm34517945wrt.16.2023.01.19.16.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 16:42:03 -0800 (PST)
Message-ID: <ab1c316e-b018-9fa6-0ebf-5c0b47c397a4@linaro.org>
Date:   Fri, 20 Jan 2023 00:42:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
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
 <58ec79b0-1b58-48c8-6eea-d6675f34192d@linaro.org>
In-Reply-To: <58ec79b0-1b58-48c8-6eea-d6675f34192d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 00:40, Bryan O'Donoghue wrote:
> 
> pronto: wcnss@a204000 {
>          compatible = "qcom,pronto-v2-pd-pil", "qcom,pronto";
>          reg = <0x0a204000 0x2000>, <0x0a202000 0x1000>, <0x0a21b000 
> 0x3000>;
> 
>          power-domains = <&rpmpd MSM8939_VDDCX>,
>                          <&rpmpd MSM8939_VDDMX_AO>;
>          power-domain-names = "vddcx", "vddmx";
> };
> 
> ---
> bod

Doh.

I opened the 4.19 kernel ... not 3.18

*facepalm*
