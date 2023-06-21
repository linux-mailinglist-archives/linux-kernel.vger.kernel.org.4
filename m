Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B9D7384F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjFUN1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjFUN1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:27:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D74C198D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:27:37 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51bdca52424so767180a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687354055; x=1689946055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=967DLvqkZucBWYuQQC7ZvvfSLYp3m3iK1g1tSsAsumo=;
        b=b0O4xEb9ZgvBDfAGPENTwzAsvbIfPfAXPyywF1IvFaK7E4iAFAOsT2rVj59NMabncB
         RYlmwz8b04PN+WED8HMqotadj13ih5Ho5ynizGWLKuMo3klYbYiIEwprcLLKmDi2jA7F
         qZlO8XOO/CSBDsQeIni4i23JZIDiLXzH+kvPykMnj9g9p8NaGhUBUN2RL0LYRoHvQWi6
         MtRaq3EgXDLB3cj+OWIYtHp2TGvwHxrgq/6TStVM3mfuY7Cd0Krb1G7OXkdLvCSel85k
         NihN7lEvlw0uh3LJTly0wKnOWFudJ7N9hv07OJ+TnIeN4/0VWSoCbSC7OFqUSCu6Nh1E
         hl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687354055; x=1689946055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=967DLvqkZucBWYuQQC7ZvvfSLYp3m3iK1g1tSsAsumo=;
        b=Mpa3O0aqFkq8vDgAC9qH9niOTjKkX/4QCy3tBBwC85E9mcwhpToOGuvaHjjFD5tzbs
         XcI5SB5N8vOZJrj2+Wyshw+CS5GXZhYS96+Synds+XqRiCQF3+FiGJjQ5ahvSTYiVNjo
         K7DpBDzo9Z642PWgZ0H0iUL+Jg/u80OVv2RMAb851HKgluq0mNtGELMJ23xww1md/sKs
         oxDdsfA4JOUQCKrK0Dufayikca3rk7ChKatO73LzxcsCLe3NwpcYes9SHTh2ySzYjblX
         DGp+Mgt9ev8EfWRX/xTjxdgAZFHVt5AOWUu0netE4Fyu78GmaFOoFV3fM2DQPhDMiCZH
         b4rw==
X-Gm-Message-State: AC+VfDwrEv4R1cJoBsJeWqj+2LMxtH+2AwVt4u810szDfPyWBhwmWCmL
        w0M7jKZwpZFAwLnKxnJZPO6Pyg==
X-Google-Smtp-Source: ACHHUZ79KyX8mAuWiGAGoUg3ClcvXNY78P0aSXypVeZrGzKCSfDscpmx6uPTblSOyPq98SOb0CnADQ==
X-Received: by 2002:a05:6402:6d8:b0:514:9e2c:90c6 with SMTP id n24-20020a05640206d800b005149e2c90c6mr10332144edy.38.1687354055724;
        Wed, 21 Jun 2023 06:27:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id w1-20020aa7da41000000b005163c11700csm2621598eds.74.2023.06.21.06.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 06:27:35 -0700 (PDT)
Message-ID: <dfcc114f-56f1-e4ab-7b36-f9a4ce3e8c8c@linaro.org>
Date:   Wed, 21 Jun 2023 15:27:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Content-Language: en-US
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <CAFX2Jfmz7QqZBEdzbPUhPs0yctnXVaVF68tX1c57YX=6ki=0TA@mail.gmail.com>
 <4fe39d77-eb7c-a578-aefa-45b76e2247c2@linaro.org>
 <CAFX2JfmdRMsHPTySiw4vm7BwJfRZj3s0V3_v7NJ+XwMxBBSo9A@mail.gmail.com>
 <a3683dd3-3f30-bb4c-539d-d1519de6e5bf@linaro.org>
 <CAFX2JfnS9GVc4NaxKhr9E4y10NNv6SPgcv1yoeHTfEw5NvZgMg@mail.gmail.com>
 <86d8e252-975f-5d48-4567-0911d5ef9a44@linaro.org>
 <CAFX2Jfn_DSs38WQYsRs2ifLi5w+T3BhZfSU2W80T6dK48_Bb5g@mail.gmail.com>
 <e8d31e48-df6a-fde4-4c6b-c4ccf1664ded@linaro.org>
 <c8d454b0-d355-f599-f720-b7e64374fb56@linaro.org>
 <CAFX2JfmvMZ7DzD9znWeOHXywgPbUKDS1irMjUerEuborjRBpcg@mail.gmail.com>
 <CAFX2JfnhOz+HiOd4vBwBK+5d19Kb8wfBNQhxRZHQoP8S2qiwFw@mail.gmail.com>
 <CAFX2Jf=5WV=dY9J4-7tp5NB85fDOkwiv8rxQqHziqG+ED1cUJw@mail.gmail.com>
 <CAFX2Jf=TxojviigtdQ=F_8FcHFFC4RNdfkoS=157jnXQCQSq5g@mail.gmail.com>
 <85851031-cf43-07d2-8ec7-b40c8c00be91@linaro.org>
 <CAFX2JfnH_rOFxn+uT4e1Eutea5En4_z26a-u_qCwOsnr5EowRw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAFX2JfnH_rOFxn+uT4e1Eutea5En4_z26a-u_qCwOsnr5EowRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 14:49, Anna Schumaker wrote:
> On Sat, Jun 17, 2023 at 6:09 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 15/06/2023 21:38, Anna Schumaker wrote:
>>> On Thu, Jun 15, 2023 at 1:16 PM Anna Schumaker <schumaker.anna@gmail.com> wrote:
>>>>
>>>> On Thu, Jun 15, 2023 at 1:04 PM Anna Schumaker <schumaker.anna@gmail.com> wrote:
>>>>>
>>>>> On Thu, Jun 15, 2023 at 9:01 AM Anna Schumaker <schumaker.anna@gmail.com> wrote:
>>>>>>
>>>>>> On Thu, Jun 15, 2023 at 4:55 AM Krzysztof Kozlowski
>>>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>>
>>>>>>> On 15/06/2023 10:52, Krzysztof Kozlowski wrote:
>>>>>>>> On 14/06/2023 22:55, Anna Schumaker wrote:
>>>>>>>>>>>> Still null ptr (built on 420b2d4 with your patch):
>>>>>>>>>>>
>>>>>>>>>>> We're through the merge window and at rc1 now, so I can spend more
>>>>>>>>>>> time scratching my head over your bug again. We've come up with a
>>>>>>>>>>> patch (attached) that adds a bunch of printks to show us what the
>>>>>>>>>>> kernel thinks is going on. Do you mind trying it out and letting us
>>>>>>>>>>> know what gets printed out? You'll need to make sure
>>>>>>>>>>> CONFIG_NFS_V4_2_READ_PLUS is enabled when compiling the kernel.
>>>>>>>>>>
>>>>>>>>>> The patch does not apply. I tried: v6.4-rc1, v6.4-rc5, next-20230609.
>>>>>>>>>
>>>>>>>>> Can you try the attached patch on top of my 3-patch series from the
>>>>>>>>> other day, and let me know what gets printed out? It adds a bunch of
>>>>>>>>> printk()s at strategic points to print out what is going on with the
>>>>>>>>> xdr scratch buffer since it's suddenly a bad memory address after
>>>>>>>>> working for a bit on your machine.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Here you have entire log - attached (113 kB, I hope goes past mailing
>>>>>>>> lists/spam filters).
>>>>>>>
>>>>>>> As expected this bounced from the mailing lists, but I hope you got it.
>>>>>>> If not, let me know.
>>>>>>
>>>>>> I did still receive it. Thanks!
>>>>>
>>>>> Can you swap out yesterday's patch with this patch? I've adjusted what
>>>>> gets printed out, and added printk()s to xdr_copy_to_scratch().  I'm
>>>>> starting to think that the xdr scratch buffer is fine, and that it's
>>>>> the other pointer passed to memcpy() in that function that's the
>>>>> problem, and the output from this patch will confirm for me.
>>>>
>>>> Oh, and can you add this one on top of the v2 patch as well?
>>>
>>> Sorry about the noise today. Can you use this patch instead of the two
>>> I attached earlier? I cleaned up the output and cut down on extra
>>> output..
>>>
>>
>> Here you have - attached.
> 
> This is good, thanks! I was finally able to figure out how to hit the
> bug using a 32bit x86 VM, so hopefully the next thing you hear from me
> is a patch fixing the bug!

QEMU also has 32-bit ARM and x86...

Best regards,
Krzysztof

