Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1127674E69F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjGKF5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGKF5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:57:49 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031FB195;
        Mon, 10 Jul 2023 22:57:47 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qJ6Nb-0004qx-QV; Tue, 11 Jul 2023 07:57:43 +0200
Message-ID: <67299d09-46dd-d96d-8c4f-b8b72af7c63b@leemhuis.info>
Date:   Tue, 11 Jul 2023 07:57:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US, de-DE
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1689008220.git.linux@leemhuis.info>
 <29fb398b-a81c-70f9-f67c-21daaa42e4f7@leemhuis.info>
 <2023071026-wired-erasure-6443@gregkh>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 0/3] docs: stable-kernel-rules: add delayed
 backporting option and a few tweaks
In-Reply-To: <2023071026-wired-erasure-6443@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1689055068;23723fed;
X-HE-SMSGID: 1qJ6Nb-0004qx-QV
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.07.23 21:50, Greg KH wrote:
> On Mon, Jul 10, 2023 at 07:18:43PM +0200, Thorsten Leemhuis wrote:
>> On 10.07.23 19:10, Thorsten Leemhuis wrote:

>>>  - It must either fix a real bug that bothers people or just add a device ID.
>>>    To elaborate on the former:
>>>
>>>    - It fixes a problem like an oops, a hang, data corruption, a real security
>>>      issue, a hardware quirk, a build error (but not for things marked
>>>      CONFIG_BROKEN), or some "oh, that's not good" issue. In short, something
>>>      critical.
>>
>> s/ In short, something critical.//
>>
>> Contradicts the "real bug that bothers people" somewhat and IMHO does
>> not add anything. But maybe that's just me.
> 
> Agreed, it can be dropped.

Thx for your feedback. I'll merge this bit into the second patch and
will send a v2 with just patch 1 or 2; and then will try to find a way
to handle all the other bits with a series that make it easier to see
what's changing.

Ciao, Thorsten
