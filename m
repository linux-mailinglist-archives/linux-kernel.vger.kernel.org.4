Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB090719653
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjFAJEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjFAJEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:04:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF0AE4A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:03:35 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d3491609fso372726b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 02:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685610207; x=1688202207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUWrPdzK1S2MpP3NTfTcecbk91WZd1N8lyxQ0bkEwUI=;
        b=dbuOyxq5c4Q8w2wawPzwrk6/ma79vcj3SdcEjmerG61ig2bqy5Tn+AeK7NYupbPRWy
         74iYDoKQkkne9Tw0HjMifNwEJ8O20miYo7uHdOXEEh7dLZv9fJ0Ckg/ye7XMZDcwn1sE
         9/v4nHQ70Eg1hsqCnfEwqlOHrpqlABkBo1Cf183RWU/9yreEty7yXRPmPbsJ5HqTKQNI
         9w5FPCRkCDwZQFmF1SzmZmSTQ+FeZuFGz7C8nCBmqnuF96yapMbMR5913/2SBeiwe7C3
         9hS9pf3lZ2Zjd5mTVZDnNCLHiZhFRhKBFs2dKRXAP7vhmvZGVDzhEynPzhyxdlTBhJ74
         a6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685610207; x=1688202207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUWrPdzK1S2MpP3NTfTcecbk91WZd1N8lyxQ0bkEwUI=;
        b=D8I4bVLm3RrF4rGVmstplqhXFHeh7Jk1mwnb4rrxPE41v6gO64dWNfAYZFCUTziH6b
         7ls5laJbaw1m5c29eknfz/FFfPgpRRTmVikJg3mj2P2pWUFty3c66AtI5/00yS3/ETjd
         Q+QUCyPlGDlyAD5WyFbXyMAc4uEONbNw50DtQSsLe5CcKGXbtzgtxxO5bu3M5GFoBI78
         Kh3poEWoDXiulfzshgF+z4HCZsjohn6Txa7m1pZruGGkvda0HPh9rlkWCD0Y0/hgtwSM
         hQdtiVdRfChfTZpHYei1GApQIMZmQn2rXHcqL/YT28wBLdbTVLW3uS2D8vtNId6Mz4zy
         SUDg==
X-Gm-Message-State: AC+VfDwxeer72df0jVRaV8cMZT2dGMxp8xRSFEp2Ly53NNOZWV8K4lkT
        dOWascEaDvqbtZkaFGSqpds=
X-Google-Smtp-Source: ACHHUZ5B0w485bHAGhy9TjzNgXQswCsG3AkGbPW0ka0IgPEQEDtaoBnMF7spdxXEJFdrEx7mJbvtwQ==
X-Received: by 2002:a05:6a20:2588:b0:10b:dca5:74e5 with SMTP id k8-20020a056a20258800b0010bdca574e5mr7418039pzd.0.1685610207038;
        Thu, 01 Jun 2023 02:03:27 -0700 (PDT)
Received: from [192.168.0.105] ([49.207.240.61])
        by smtp.gmail.com with ESMTPSA id e10-20020a62ee0a000000b0064d5b82f987sm4726664pfi.140.2023.06.01.02.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 02:03:26 -0700 (PDT)
Message-ID: <730c8712-1553-63e5-ffa1-d75a922f4a42@gmail.com>
Date:   Thu, 1 Jun 2023 14:33:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v6 0/7] refactor file signing program
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
References: <20230321193341.87997-1-sshedi@vmware.com>
 <0ae37bcc-4398-644b-a295-1245d73e5450@gmail.com>
 <2023053135-bubbling-commodore-3a7b@gregkh>
 <cefc1a42-725a-8afa-c222-f4df085ba6a2@gmail.com>
 <2023053148-ahead-overbite-863d@gregkh>
Content-Language: en-US
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <2023053148-ahead-overbite-863d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31-May-2023 22:20, Greg KH wrote:
> On Wed, May 31, 2023 at 09:01:24PM +0530, Shreenidhi Shedi wrote:
>> On Wed, 31-May-2023 20:08, Greg KH wrote:
>>> On Tue, Apr 25, 2023 at 04:14:49PM +0530, Shreenidhi Shedi wrote:
>>>> On Wed, 22-Mar-2023 01:03, Shreenidhi Shedi wrote:
>>>> Can you please review the latest patch series? I think I have addressed your
>>>> concerns. Thanks.
>>>
>>> The big question is, "who is going to use these new features"?  This
>>> tool is only used by the in-kernel build scripts, and if they do not
>>> take advantage of these new options you have added, why are they needed?
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Hi Greg,
>>
>> Thanks for the response.
>>
>> We use it in VMware Photon OS. Following is the link for the same.
>> https://github.com/vmware/photon/blob/master/SPECS/linux/spec_install_post.inc#L4
>>
>> If this change goes in, it will give a slight push to our build performance.
> 
> What exactly do you mean by "slight push"?

Instead of invoking the signing tool binary for each module, we can pass 
modules in bulk and it will reduce the build time by couple of seconds.

> 
>> Can you please take these changes?
> 
> Why would we take changes for something that will not benifit us at all?

There were no remarks regarding this change being useful to all in the 
earlier review comments so I thought this will make things better.

And it is humanly impossible to create something which will benefit 
everyone. And I think this applies for lot of things that are already 
present in kernel and being maintained.

> You are asking us to maintain code that only benifits your out-of-tree
> usecase, which is not how kernel development works (and you don't want
> it to work that way...)

No problem, feel free to discard this PR.
Thanks for your time and inputs. Have a nice time ahead.

> thanks,
> 
> greg k-h

-- 
Shedi

