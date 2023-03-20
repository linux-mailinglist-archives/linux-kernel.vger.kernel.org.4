Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90A76C0CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjCTJHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjCTJHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:07:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D84F749
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:07:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t5so6968116edd.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679303225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I48ZALEeuyq+5nq4S7WyEKtOnaJxJTCOPAHy1zR7+cA=;
        b=b1yya70mMnKfuymKGpD4u7cacCo6VDcwoDsWql+gacONY7SMbcuszHiX/kPPpJtnoL
         tv62CMqTPC2HHvyzGIZdKmZcFdXtneY8NxaD9whBwPZPP+0CsKGjmv4hI0V2WQBLgweF
         fexKOal9AHNEQVixmsHto8Na7yTwiwFlJmhg3a49KfbQ95UmD+O8CnVAPXBHRN09fKNE
         NLFtPwtbieJjeS6naO6guWLas8w4KBJIpnhu3Oz9nLwneVAsWzslmgAFYeaaxXt+eigu
         Fx+/Hp2QgCSyBuAQPtkO6kO25P+vZxI8XEVHuljyqRnBHWLXNxrf35nSvbRIDgYt1ZE5
         s0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679303225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I48ZALEeuyq+5nq4S7WyEKtOnaJxJTCOPAHy1zR7+cA=;
        b=xO6IV4K+hCFDI8QjVT+DcNTBKSGRInOs1hy3pLURxJnxPQ5PX2aFAHisnivxSfIwSs
         bLwJuEnkKyM/VxwUasARbu/bPCzqSYcjb90D4MB1AcmbKtke+m7tA7EpU2Ww7D3rNTWo
         pbG0P4PTc7fmESJAwnWC1klp5/xqjwiCo3Bl3nV14ZpIorJR7TrrM4crcCP4gJ0dy+DO
         s341ZeUQAWODKGWJAOh1EFuTwZ2YdVL6aEd85/e2JrtMZCc9tmqtUg587WZMLSsyjFyF
         B3MPAFp5px8IyZ7fBOlbTtq4m1PHYHjBXBUCQ/asI79/krC0T4R7A0zaOMXAyf0Z7haq
         f9bA==
X-Gm-Message-State: AO0yUKUP16y1ze2FwGnuIUyqHw4dNCwi9ab/Rg/7vNTBVybeFZWczsae
        jik6TWudDayvS/R4eB0n01ZNpA==
X-Google-Smtp-Source: AK7set9VYk5vwIViq9reJb8Y0C3jTXgNZOOwFW7E0tuFon//jhh0RCKuy5Ff+HuteVXJ+1hE301E9A==
X-Received: by 2002:a17:906:c193:b0:932:1af9:7386 with SMTP id g19-20020a170906c19300b009321af97386mr7539672ejz.27.1679303224873;
        Mon, 20 Mar 2023 02:07:04 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709064e1500b00930de1da701sm4229334eju.10.2023.03.20.02.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 02:07:04 -0700 (PDT)
Message-ID: <065e79b3-f562-0ffa-2904-a3660b2c038c@tessares.net>
Date:   Mon, 20 Mar 2023 10:07:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] docs: process: allow Closes tags with links
Content-Language: en-GB
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v1-1-1b83072e9a9a@tessares.net>
 <4822168e-85a5-e507-9429-21d9a222406c@gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <4822168e-85a5-e507-9429-21d9a222406c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

On 17/03/2023 09:00, Bagas Sanjaya wrote:
> On 3/16/23 00:44, Matthieu Baerts wrote:
>> +In the same category as linking web pages, a special tag is also used to close
>> +issues but only when the mentioned ticketing system can do this operation
>> +automatically::
>> +
>> +        Closes: https://example.com/issues/1234
>> +
>> +Please use this 'Closes:' tag only if it helps managing issues thanks to
>> +automations. If not, pick the 'Link:' one.
>> +
> 
> What about:
> 
> ```
> Similarly, there is also "Closes:" tag that can be used to close issues when
> the underlying tracker can do this operation automatically. For example::
> 
>     Closes: <issue link>
> 
> For other trackers keep using "Link:" tag instead.
> ```
> ?

Thank you for your feedback! This suggestion looks better to me.

I might just have to mention "public bug tracker" to also address Jon's
comment: we don't want links to internal bug trackers.

Please note that it is still unclear to me if such exception for the
"Closes:" tag can be accepted: please see the discussions[1] on the
cover letter for more details about that.

Cheers,
Matt

[1]
https://lore.kernel.org/linux-doc/20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net/T/
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
