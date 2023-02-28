Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7086A5CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjB1QJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjB1QJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:09:17 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E978031E3D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:09:14 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bi9so13917318lfb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677600553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D0+3nGDlzKl6NDJH2dnTvIOkydjScaumH71LuWc5apI=;
        b=l/qVc0FrdhdY0OG56NcsD5kTjXzcVFnr/yuCw1O+LCKv4MUDkCoa7/xc5QwV5KlER7
         jHizgzEEufODsOJdX5k6740FZnQKP4Tz+xN8tuFFFibHnQJ9jfpI39Dk8RtDCMORMV05
         1rusGXxsN6tBHUVtfdXVBFGlBFRrIJEsXzUJRIvkXIGy6EodNeIya9voP3yRFPR5ebTH
         NY14XRFSleQ1AIv2FP6ulTDuxEXw95iYrZds0pkRIl2z4VrSkVsJOnnfGxXQMHWPyLMM
         pOuW4E6HD9LJ1RxkRlMPBd5rXnYtUm6vdtmeKSdZvD40Io+FyPtiv7z8oOdPTQggUYbB
         r9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677600553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0+3nGDlzKl6NDJH2dnTvIOkydjScaumH71LuWc5apI=;
        b=lSlx9JXxm1g2wVv7zdNfTOCmnX0/UsQ7LtoKhkUzwolcCPxYWBifyqbLD0dG4aFNfN
         movFtiAWYXr12d3VGnVGLcGvku6A/Hmr8foSQbMNM6hvzbiGO5glLYkVCWpXjBcCx0wF
         3ZySKhPMJj3wWEO2jOWi7HGfN0UI5IEzVPeSxsj5HnHqbshk5bvRA8GtcHmMhWqhMY9U
         Qy8/PftfHnokVMZTxPS6UYQuUusAOMNkQlcaaazarHpJXUJQCV07QlqyYCxijJONMf9S
         5dAJxQgvR1bpSUFJrsZ4Jia4+rqpsaIjnPUPYl/QRLgFAx0UxbZWV6km/aGfWZ2aotQs
         zKvw==
X-Gm-Message-State: AO0yUKXzZfU/WKfzSQ+KPwbA/rndOMe4i39EqXQktw5JqLV7kWYjqMB9
        UtyJOjwvnbE8abRjH/PymIgPdw==
X-Google-Smtp-Source: AK7set+Gb0M9AGyGXjayBOpZrDBMDp6k0sEctbXOpgRSOch7gFIIPiLkccZcGREIN+w3kPq+Nf0SnQ==
X-Received: by 2002:ac2:43aa:0:b0:4b9:a91c:b0c9 with SMTP id t10-20020ac243aa000000b004b9a91cb0c9mr832345lfl.7.1677600553182;
        Tue, 28 Feb 2023 08:09:13 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id l29-20020ac24a9d000000b004d8729d4150sm1388138lfp.145.2023.02.28.08.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 08:09:12 -0800 (PST)
Message-ID: <c795a7e0-3237-c100-986b-88faf35fa3de@linaro.org>
Date:   Tue, 28 Feb 2023 17:09:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 17/18] media: venus: Use newly-introduced
 hfi_buffer_requirements accessors
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
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
 <6a520b4f-f46e-72d9-44df-1faa9fa7fa0a@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <6a520b4f-f46e-72d9-44df-1faa9fa7fa0a@linaro.org>
Content-Type: text/plain; charset=UTF-8
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



On 28.02.2023 16:56, Bryan O'Donoghue wrote:
> On 28/02/2023 15:24, Konrad Dybcio wrote:
>> Now that we have a way to HFI-ver-independently set the correct
>> fields in hfi_buffer_requirements, use it!
> 
> "Now that we have a way which is independent of the HFI version"
Right, I've been inventing words a lot lately..

Konrad
> 
> ---
> bod
