Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B4F6A5C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjB1P5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjB1P5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:57:02 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F6B32531
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:56:17 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h14so10283170wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677599776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QC1O6sF2GSFpwZlOnrbrSTcI0D5NLDgbWDjuo86L60w=;
        b=KuldUDs8WpYuaVlGl0oSvDKdVJ2+YJoQLvyp8sSLhFyomiMpqpJbnj9ILZ/T3KMDEv
         SicFMS1Hce/10NhwdtynlL/noe7fiLBKKqgHWyLUmBLWtQuR8VfaA2IaL7nmQDJ736Sl
         4a4uM4/8KcSt+1Q7qOFAC+BI+AtsUIvb2NBr/8fnuYLoXK15SV6QA7W+j2syAWV1Jo6T
         TcNcKya7RPh3qQ0EXQFmQuIzv7WRefjaQPxiU7fTkKbI5C7S0WoggJAQH5L8841PfYqL
         MojwNcOnZOlcI8BI90CB0DTI/n+kjuaWGpa1Bmeq+tI93le9eJqfvREolmb9UCzQEDiH
         vqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677599776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QC1O6sF2GSFpwZlOnrbrSTcI0D5NLDgbWDjuo86L60w=;
        b=aH4ZWSmqJ8uauHgWWVubnO5zVMBE5Th5r11B6+5BjLBvZx7NVWsZSjbbjB6JF6sOg8
         EcZM9b0rWw4jy1iWR5dQOdwDx8yGydA+bu8bowbfJlqJoxdWgkoXPAVIU2T80krXGzSa
         SgsnIp2tuRoaIzkx4Vjq76t+l8HlyOe57XnG3PXItbDGIJIO1Ddi2nHWXtt46TFC7fPH
         rlwLTo8X1k8zQOeCCUfrWMakgaWKPkfLpXpBtEcFrirSEShjlZEK/2uOlhXpPvlspB2c
         YwApOHN/4PzIiKZbpSE9fHy+E9e3TWlvKtO+aenMKdVnQgN68AQJAPv+ad1dDX0GM4AH
         gcZg==
X-Gm-Message-State: AO0yUKWkwl3CaQ7Q2vDbndLjmApaqTpSBqVAB1mIaf4i+qCw1rLt4urO
        Z+wP+eR6A2Dlk6TRw21PeXtB3A==
X-Google-Smtp-Source: AK7set8cWQnxOgbU88fUevqV4ScrKfLluBllP/85eSqRiVv2WI/lbN1/nKnVm8J28IaiQq5VNWwrdQ==
X-Received: by 2002:adf:f503:0:b0:2c8:50bf:2137 with SMTP id q3-20020adff503000000b002c850bf2137mr2259209wro.46.1677599776124;
        Tue, 28 Feb 2023 07:56:16 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d4c47000000b002c5534db60bsm10058741wrt.71.2023.02.28.07.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:56:15 -0800 (PST)
Message-ID: <6a520b4f-f46e-72d9-44df-1faa9fa7fa0a@linaro.org>
Date:   Tue, 28 Feb 2023 15:56:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 17/18] media: venus: Use newly-introduced
 hfi_buffer_requirements accessors
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-17-58c2c88384e9@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230228-topic-venus-v1-17-58c2c88384e9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2023 15:24, Konrad Dybcio wrote:
> Now that we have a way to HFI-ver-independently set the correct
> fields in hfi_buffer_requirements, use it!

"Now that we have a way which is independent of the HFI version"

---
bod
