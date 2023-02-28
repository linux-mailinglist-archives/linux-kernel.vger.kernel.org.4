Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EA06A5C75
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjB1PzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjB1Pyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:54:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A0431E0D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:54:47 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bv17so10276808wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677599686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eu4MWojdO7sm+1elVV25ao6H2vyCsaxlwZKP+d9Oj/s=;
        b=HnMCYPG5+h7duXHP1jWgge18cv3uQ/U6GLcamEu5ZB+13+lGxUApQh99ZuPvOIJldc
         YeIhMDXrP6QBkRf9E0ReywL55RB4gBROOuQ7M9EJuAD6JYIGp9js+rvU7YLxcdc0JhMC
         9kJrwrQacIctQRMoJFUTOrtwX52epwC1tfviQCV1c0yTn1KtusVwB+88mzdUphF3LUfv
         gKs2X2Xia0aLpb/oNJPQQwfFiFSvRsuKfv2lC87Hv5J5VWPRHDJlym9aRI6+yAyfCGHi
         eXozY7TOeyVcfOhvLpnOClHc7c9bPfFgKr1/cCt5ccOEOVI4jnOmbfuq6jjRiBvYPdYP
         YFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677599686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eu4MWojdO7sm+1elVV25ao6H2vyCsaxlwZKP+d9Oj/s=;
        b=3DSIhM6NR0ueTitS9u1KGXMQM6QaNpxk4ZCfwaeuQstVEpcRSsxDfOysd3YxQlZKVT
         hrvz9fBg3vPVvoYshVBVe+nCCIJ7QZs+BzUsSfHKHDhcgy41MGMqMTYSPqe4HhjcezTy
         nvaCCGHiPN3w93/rICs7uE+pm5UG60R3xER+j7d/4mgVBwjaiJjgixl+gwebwPhf8Gjw
         LIW9VOyroj7Sqz1vUQUp1HP55oszNeZBLsNHZzztVzEUmgR2M09bAoAsVmmPKSlVFXYa
         LvP+XlpA+ISa9tQd1vNCUIcDz0AmrxKTB4gtEehaioLczdnSADNtwCsy5TN9i5s8x2b+
         199g==
X-Gm-Message-State: AO0yUKUgzNOAowjTrfj7ARrb+M85J5V4yq56Z6XWmUCawJLl0pyKFdCS
        s9H9Mo4H+xJ2W6GGMMCsAApe4g==
X-Google-Smtp-Source: AK7set/zbKrJjzjQzkntIAvWaY6PZ1Tmf3t94wSehMWM8yFBuNy74HLCLexBljbd5kYM4uPBqvO8fg==
X-Received: by 2002:a5d:428e:0:b0:2c7:a3c:5b90 with SMTP id k14-20020a5d428e000000b002c70a3c5b90mr2292539wrq.9.1677599686429;
        Tue, 28 Feb 2023 07:54:46 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d6a82000000b002c53cc7504csm10453683wru.78.2023.02.28.07.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:54:45 -0800 (PST)
Message-ID: <db7850d0-d141-44ac-c9da-6ee31d003b55@linaro.org>
Date:   Tue, 28 Feb 2023 15:54:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 16/18] media: venus: Introduce accessors for remapped
 hfi_buffer_reqs members
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
 <20230228-topic-venus-v1-16-58c2c88384e9@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230228-topic-venus-v1-16-58c2c88384e9@linaro.org>
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
> Currently we have macros to access these, but they don't provide a
> way to override the remapped fields. Replace the macros with actual
> get/set pairs to fix that.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Nice

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

