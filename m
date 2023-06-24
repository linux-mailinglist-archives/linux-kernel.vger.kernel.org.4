Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B783773CBDE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 18:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjFXQWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 12:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjFXQWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 12:22:44 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29FC1BCA;
        Sat, 24 Jun 2023 09:22:42 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1b012c3ce43so529861fac.3;
        Sat, 24 Jun 2023 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687623762; x=1690215762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FjHHI1yyw4klDYWSKFxXJcGrhONifvdrICJXqeUvzdw=;
        b=bP/VGAbkC17gDmTxtsnJAko2y/yhEvMlQVN5eoz7QMfxc362wPWeadqBp2hcD7lO9L
         xifRNjsE/TEgoYQMSMXvQlo+ivbIMaODIr5nWuGCS6XU1ufPBX7/YPJ5nIXErYYNCMF/
         l8LrAAPY7CXfWNQLAOH0ooDdpAWCMgUBcoto91nPxwibj1zNKEsbvxQyNjHI5+wIFHfn
         Oxcxk+K4uFVBXxroWkfFigwdTuvnC0/zTjlqnnhXnt1Fb2v1x148T4/XfBrwoYDeEHAw
         rzt2BbePEDNojBa7uWwQ91wqTAIheOv7pt9Q4lROTs62FYBlt9bmZgBePoxVJRQetrUk
         6r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687623762; x=1690215762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjHHI1yyw4klDYWSKFxXJcGrhONifvdrICJXqeUvzdw=;
        b=LFaKRx/UX+RbJvduW/ZaxO3fZNPeA2pjPEl3zm6FZUJI0fMwanPO94B/cDCSNOt03F
         sp2xe35orrbxmgup4RicZgPsHqO59VUWQXIz/iyybZTGRENwwTvM700i5705jn+EDTpB
         0N45dt5fqvHzjsSg+/KHPCXweIeTq2ztkktzUhkB3wlxXW3Ck9Ac4Q7Mhbe2dTMxiQla
         jDNYf29jvtQaY3WjEAXdBirF3MncEfeX9MSHKRQau/OxBNJj+kVH0eDCn6ZVLASnWkWJ
         iN8t7uqiJCP497P2RlP5OE+DoJCqLlCeMXva5nPd9Tz1PU8UkbX5Bztsc/s6JL9pDFfn
         rmIA==
X-Gm-Message-State: AC+VfDxczeyFwcT4gGK3xu5d52rV/TPGm5xL5ghvC0CzexvfvCv2+XSf
        xVnAT4By3yRoU+oFVfY/bDfLhLLs3Cb/nw==
X-Google-Smtp-Source: ACHHUZ4FedgPHxWTt/Zi2yB72fXZBNoDybnymIynQCusCaHJNo1mIZ9Pu7DLsHt3Rp1527oPOlN89Q==
X-Received: by 2002:a05:6870:4415:b0:1a9:fe25:2e80 with SMTP id u21-20020a056870441500b001a9fe252e80mr20212466oah.18.1687623761790;
        Sat, 24 Jun 2023 09:22:41 -0700 (PDT)
Received: from [192.168.1.128] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id q17-20020a05687101d100b001a6ad211bf3sm1346883oad.1.2023.06.24.09.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 09:22:41 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <18f4cb13-9b7d-e202-333e-43c76d8c7290@lwfinger.net>
Date:   Sat, 24 Jun 2023 11:22:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: After kernel 6.3.7 or 6.3.8 b43 driver fails
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>, sardonimous@hotmail.com
References: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
 <20230624105023.146d99e0@barney>
 <d33a248c-c7ac-43d3-b602-3c801d697922@app.fastmail.com>
 <08ea34c8-7194-eafb-98f4-1e0b52ca7e81@leemhuis.info>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <08ea34c8-7194-eafb-98f4-1e0b52ca7e81@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/23 09:00, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 24.06.23 11:29, Arnd Bergmann wrote:
>> On Sat, Jun 24, 2023, at 10:50, Michael Büsch wrote:
>>> On Sat, 24 Jun 2023 08:44:15 +0700
>>> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>>>> I suspect change introduced when addressing a compiler warning
>>>>> cased the error.
>>>>>
>>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20230516183442.536589-1-arnd%40kernel.org/
>>>
>>> I doubt it.
>>> This patch affects the device initialization code. But the crash is in
>>> the transmit path.
>>> Can you please double check by manually reverting the patch?
>>
>> I'm travelling at the moment and can't easily check it, but I would
>> expect that my patch has no effect on the generated object code [...]
> 
> Michael, Arnd, thx for the replies. To you and everyone else that looked
> into this: sorry for the trouble this caused.
> 
> The reporter's guess was wrong, as the reporter meanwhile confirmed in
> the bugzilla ticket that the problem started to happen earlier.
> 
> Bagas, please be a bit more careful and don't blame a specific commit
> unless it's was found by bisection, a revert through a lucky guess, a
> statement from a developer, or something like that. In cases like this
> it would have been better to sent the developers of said commit a quick
> mail along the lines of "could you imagine that this change could lead
> to the problem the reporter described". But even that might be too much
> in a case like this, as too many of such false alarms and inquiries will
> make developers start hating or ignoring regression tracking in general
> or mails from you or me – and that is something that must be avoided, as
> without help from developers regression tracking becomes a lot harder or
> impossible.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> P.S.: Updating regzbot status, while at it:

The OP definitely needs to bisect this problem. The only system that I have that 
runs b43 is a PowerBook G4 with a ppc32 CPU. That box has successfully run b43 
for every release up to 6.4.0-rc7. I have seen no problems in recent kernels.

Larry



