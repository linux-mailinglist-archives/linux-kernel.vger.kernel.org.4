Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD546693B46
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 01:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBMAEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 19:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBMAEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 19:04:41 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFC6D525
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 16:04:39 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o18so10544916wrj.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 16:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HVhEdTvaa7PtbEvy7fisJWeELmJ/JE3AStlbnpFgGOE=;
        b=JHs3Qby5tHMYh3/6tkyxDL69ykExbeRfARD4ZN9+F/c0xhJKbJzmH7U6DkuEV5xaRO
         fTGWjkg9I76g5e+0Sze2v4xeg7qJ9LnAi5jQjVwq/x6qMk98lpt+S6KmSAVD7q6npzdM
         ZZHix7uMDLXkHF3iV7SGep8K3kZN1BqHyIfCZc4AQbfoLRinXy/7302TkU0vomtlBtd8
         mj+f7N0Hq4wA2sqfM1Fcrdr+50s90W7eM/UEYhgrkaXGUNOyAi998kDecTuu6yvusBeI
         9o2dXGW83rqId8v+TjkrOh7h+wc4OfTiA3Dpd560fymFWaJ5F3ef0tW2Zk5xFqFK00Bl
         h2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVhEdTvaa7PtbEvy7fisJWeELmJ/JE3AStlbnpFgGOE=;
        b=oxDypdHR6t0kxDeHdlzlrqa/QHg7795oZXo2JkxHlQ4kM/EWOrZUBTW1VDuj8F7z0M
         l/HE80e6xH/PuUYw7rDOK0Ld6j0vDAwR+OXwZLdr8FRMLIYEExSygbH6Cbz5cA3scAAc
         4jDejguvsmMmW9fqtVkEDzbh1JWcl+479F8TJ0KBF90bJUXUtC92fouvSr3X0fMnR4oG
         NRi+HzUAKObRZRp0/2nVRGpnbWwHU2L/1qdoItlRXSZ0E6rn2K0zXndRMSGs6RQ/4d7J
         9S1xia3W2uVJkOEDy+imwpkDh3ny3fL+mG7KEsQWRDsB4LVZYs4R5ykCnG9GFlwGrF3q
         f3Bw==
X-Gm-Message-State: AO0yUKXCXLYLKIIPCagkNIqt0wLT25EUDK8xh7PR6lY+xtIYt7Wf8gZs
        ZcdxeEIAwG9P3DOGeGccFalwwQ==
X-Google-Smtp-Source: AK7set+9Mf6alnE6bG3GJqK6wUQwxbwTgma8dZVM95w+TY7Ckjp6BgtPmbjLk4YSIfqZyFJ/M3UC4A==
X-Received: by 2002:a5d:44c6:0:b0:2c3:f534:67b3 with SMTP id z6-20020a5d44c6000000b002c3f53467b3mr19609495wrr.23.1676246678262;
        Sun, 12 Feb 2023 16:04:38 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b002c5493a17efsm7129408wrq.25.2023.02.12.16.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 16:04:37 -0800 (PST)
Message-ID: <b5f5cdbc-9b4b-3c86-86f6-c3944884cd1f@linaro.org>
Date:   Mon, 13 Feb 2023 00:04:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v5 2/5] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
References: <20230206012336.2130341-1-bryan.odonoghue@linaro.org>
 <20230206012336.2130341-3-bryan.odonoghue@linaro.org>
 <Y+T5cF4d667RhrJp@gerhold.net>
 <2b6bc14b-20df-b61e-6464-61ebb11f24f0@linaro.org>
 <Y+kfuHDMZCu1vKsA@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Y+kfuHDMZCu1vKsA@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2023 17:19, Stephan Gerhold wrote:
> Huh?
> 
> We had this discussion several times before and once you mentioned that
> Shawn fixed this in your production kernel at some point. You just keep
> forgetting to apply the same change to your upstream tree. 😉
> 
> You can either change the timer interrupt numbers or (more easily) just
> fix the address to point to the timer of the other cluster (which has
> the same interrupt numbers as on 8916):

I must be getting old(er) to have no memory of that.

But you're right, we do have that in the production tree.

commit 91a842b81a713ede9ba76f3957e6fdd9067b5493
Author: Shawn Guo <shawn.guo@linaro.org>
Date:   Thu May 28 11:03:40 2020 +0800

     arm64: dts: msm8939: fix base address of memory mapped timer

-               timer@b020000 {
+               timer@b120000 {

Which I guess explains why it works after all.

Cheers.

---
bod
