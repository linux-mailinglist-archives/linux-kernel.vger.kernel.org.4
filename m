Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABEF732FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345641AbjFPLV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345601AbjFPLV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:21:57 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585241FE2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:21:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so746217e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686914514; x=1689506514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x9AFVVJUU2a3J7rX52GO0yuu+o/Wphy8iDgj8w8iCy8=;
        b=SiLajHKV5PPKHPTZm8F4oSx5a4TEXFkLrSC0uSd/QkIS0MeNqDJeYRANUWmVGYUilF
         FqsFN/3eNcbU4QIl3Iktjnyg9zVAO2t/14TLlqYrqunBx/X7Vv8yfIBF6wnyXB3Uovfp
         qNdjdDcFG99jCcyFq7bVX43Z0XGAbNfZ4jgOxAWXEu2xFWgTNi9j8H58h1IipG6//qf6
         93MECTyMrFJnwNw9tjOJ+Ad74ukC4XiDLVh+dOw+q6N6kHLvNsbc9X5PGSdfp2g7CvhZ
         AnDglJhVw2yMbxLIx3XqG2FKnnsYR6kxCZdSPTEOoU5v0nTmXMuy/d7zU67iGiwZlwrE
         CMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686914514; x=1689506514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9AFVVJUU2a3J7rX52GO0yuu+o/Wphy8iDgj8w8iCy8=;
        b=C4zBbpjp6ozTs+Dua+5tA7E1dT1KmPVzUGgcqzsy67Kvg2oXXMjMvOhcmM4WcTKkTv
         puT5BiKCQ4EBGkeBTLGyWVgvne7fVu1OhmZhb0UY6dihjuE4UwSGAe9TiuUgJuyRjY2i
         0n/+lviH9qsmtjenrQAqO2lOht43RWUGlek+5AJX2Nxl/+FvGEFUWNnY3i1RSCoINHEi
         Zz0bjRBEkOiP1giO+9V9il+ZTyJhaNyvEVtZ9GqkGOsMX26Z3YRXljoJCydKF105J6iZ
         xbZzKYXAEV+GyA4M633k/d+g+pU7vYx8mMXNB3HIbfgFbxpwSt4AsDRzmyLI57DBOSLu
         PwNA==
X-Gm-Message-State: AC+VfDwKZTz2SuISJkHLpdym0BLcPLPn/RARFhZtWMox+YpriPWj+Qfy
        SNVnOnke36FWWmPazRhV5IzDPw==
X-Google-Smtp-Source: ACHHUZ4Syw3oZM4YNS/8pjaSvesmeoSok7WWaFguhjpSYchWZo4nDZT1eQR15fus3VyVGiBgGnXKEQ==
X-Received: by 2002:a19:5055:0:b0:4f6:14d1:596d with SMTP id z21-20020a195055000000b004f614d1596dmr1045011lfj.61.1686914514506;
        Fri, 16 Jun 2023 04:21:54 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m7-20020a195207000000b004f60a2429d4sm2990923lfb.78.2023.06.16.04.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 04:21:54 -0700 (PDT)
Message-ID: <c963cc67-5c8d-4503-af0e-082ee0be8688@linaro.org>
Date:   Fri, 16 Jun 2023 13:21:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 0/2] Update GCC clocks for QDU1000 and QRU1000 SoCs
Content-Language: en-US
To:     Imran Shaik <quic_imrashai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Melody Olvera <quic_molvera@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230616104941.921555-1-quic_imrashai@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230616104941.921555-1-quic_imrashai@quicinc.com>
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

On 16.06.2023 12:49, Imran Shaik wrote:
> Update GCC clocks and add support for GDSCs for QDU1000 and QRU1000 SoCs.
> Also, add support for v2 variant as well.
Does that imply the first submission concerned v1/pre-mass-production chips?

We usually don't support these upstream, as they are rather short-lived and
never (officially, anyway) escape Qualcomm internal..

Konrad
> 
> Imran Shaik (2):
>   dt-bindings: clock: Update GCC clocks for QDU1000 and QRU1000 SoCs
>   clk: qcom: gcc-qdu1000: Update GCC clocks and add support for GDSCs
> 
>  .../bindings/clock/qcom,qdu1000-gcc.yaml      |   6 +-
>  drivers/clk/qcom/gcc-qdu1000.c                | 162 ++++++++++++------
>  include/dt-bindings/clock/qcom,qdu1000-gcc.h  |   4 +-
>  3 files changed, 118 insertions(+), 54 deletions(-)
> 
