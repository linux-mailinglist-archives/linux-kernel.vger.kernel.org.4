Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A338711A6E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjEYXDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjEYXC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:02:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702F3D9;
        Thu, 25 May 2023 16:02:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3078d1c8828so27492f8f.3;
        Thu, 25 May 2023 16:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685055774; x=1687647774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Gc10kAlN/QCV1cJFBbv9jko2ynyNaEB/uj0JCnrH5I=;
        b=c8isuRLV4sUGQxkEZgx9B8qrZn66qEBY9Jpi3LvRuPe/3Cm3LShm3RLMHblOCHRfkW
         1VCFc3oodGqVaHDhsJ5BbKmOdRATShZiNimDyS+EumYzsvOX3bJJLVqw/jCW6V+JfPc8
         rufUIUiLCXb3mn2apMTKUHnSYj50/Wv58RDUgBa8oDhZ0tZ8aK2iZlr2Dbsz4al4HrX2
         FH2FiYhCEKmRBdkdIKCII3d2e9IiKJ8eKy0Ii1AI/QskI5Sw+EinxwxeDbblVH6jv90C
         cBcxRzJkTkfZXoFcPPFuhmIoWjMduGA7d4eati8ZBcxiFCLKDwKThpBScErLc9WJjiSK
         swDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685055774; x=1687647774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Gc10kAlN/QCV1cJFBbv9jko2ynyNaEB/uj0JCnrH5I=;
        b=jk1gIA6F/fUX9L3GXBo1kJGnIdZADROwSks7KFDZ8M7snbSU6HpB53/TFNH5cCIYbT
         UcgnnEYLdi5gUiHmg4wOW4WJ7P4x4AiF4RhPUii38eFzQbIsrWn4rSR64s4c3EhgR7lR
         933++ExsLkK5gc2QsaZrSYFvW5ixxRm8bTsMxRdIgq/iUzp5F7LwuskkC6mjfv+1woOR
         YjwC91aHcqo2UeE9jt5GL6xWcAauqH5xirPAwo51NVy9GlJcTokCbBnGH3K5CsVk5aR7
         2s0dcmElA65gXYFkhdGPNXzO+ldcqyJRRYspi+ithMgh6/BR0PwHXAMJ5F4mHh5riOYV
         /whw==
X-Gm-Message-State: AC+VfDwZZxRqB4ZSAggUUcx70wwIuBkoFhoSkG0tFLB1grd5Dd0NPqXp
        i+TKhHbyL83n44wQzj/Kros=
X-Google-Smtp-Source: ACHHUZ4veEnvpe4IyLnE9x+CCG0DZpuA+49XQBYwaEtmdyifQvawy/ESgvwUpwr21TZmjpB75Z8LYA==
X-Received: by 2002:a05:6000:88a:b0:2fe:851c:672f with SMTP id cs10-20020a056000088a00b002fe851c672fmr3872463wrb.8.1685055773774;
        Thu, 25 May 2023 16:02:53 -0700 (PDT)
Received: from [192.168.57.226] ([37.63.24.136])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b003f18b942338sm3386016wmc.3.2023.05.25.16.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 16:02:53 -0700 (PDT)
Message-ID: <5186d79b-7303-73f6-b29f-c83b3c9882d0@gmail.com>
Date:   Fri, 26 May 2023 02:02:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 00/17] Venus QoL / maintainability fixes
Content-Language: en-US, bg-BG
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        stable@vger.kernel.org
References: <20230228-topic-venus-v3-0-6092ae43b58f@linaro.org>
From:   Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
In-Reply-To: <20230228-topic-venus-v3-0-6092ae43b58f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Could you re-base the patchset on top of [1]?

regards,
Stan

[1] 
https://git.linuxtv.org/svarbanov/media_tree.git/log/?h=venus-for-next-v6.5
