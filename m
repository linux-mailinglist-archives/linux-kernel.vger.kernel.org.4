Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EF972A9E1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 09:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjFJH2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 03:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFJH2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 03:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0DD30E3;
        Sat, 10 Jun 2023 00:28:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50D7E61135;
        Sat, 10 Jun 2023 07:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61232C433EF;
        Sat, 10 Jun 2023 07:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686382112;
        bh=A9IISf+44oVN6lf+g6hfV1UzlUMGhIY+Uui3vWKpb6c=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=s9y+QooN8f4fyrHyF+NzF0qwS8S8r/avD15+aPDTrjEns1/967RVI2zJkfYwmzMlp
         M+HTU8heZS117L9Em2Nkz14ZavA+yx7XpnGLNxjuYm4D0n+s8edPK4fvpdiDoeO/mM
         AVuwtVYcA6BHnnOJdEboB0uB0MZ/E1PT8aMuf8tDkQVmUslwHf33timaXCGQB92GPU
         0E6ylgujBLWRV7tWudQCfK/Y0OZnoZMIsQsV7k9DJhiDTryjw5JiFVHAj6BM2bw8Hv
         D2i5cPLjAKQzGNjuTL+LepHITxk/JFI65nRBYr/LUgQQaw73OQ+OuAETGbHlNYkmhU
         Vn5TcsfR9WT+Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        dbnusr495 <dbnusr4950@proton.me>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: rtl8xxxu kernel module deauthenticate session from public open Wifi AP
References: <31ab2156-e93e-4e0d-73a7-313d9d24ee6b@gmail.com>
        <f969c91f-f7a1-bea8-ae72-67543bb3df83@gmail.com>
Date:   Sat, 10 Jun 2023 10:28:27 +0300
In-Reply-To: <f969c91f-f7a1-bea8-ae72-67543bb3df83@gmail.com> (Bagas Sanjaya's
        message of "Sat, 10 Jun 2023 13:35:30 +0700")
Message-ID: <877csbhj38.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 6/8/23 20:32, Bagas Sanjaya wrote:
>> Hi,
>> 
>
> (also changing reporter's email to the proper one).
>
>> I notice a bug report on Bugzilla [1]. Quoting from it:
>> 
>>> With Debian Sid, trying to use two different Realtek USB Wifi Adapters (with
>>> Antenna).
>>>
>>> Using kernels including various Liquorix 6.2.x, 6.3.x , and the most recent
>>>
>>>     linux-image-6.3.4-1-liquorix-amd64
>>>
>>> also, Debian experimental
>>>
>>>     Debian (experimental) linux-image-6.3.0-0-amd64-unsigned
>>> 6.3.5-1~exp1
>>>
>>>     Debian's linux-image-6.3.0-0-amd64 (Linux  6.3.0-0-amd64 #1 SMP
>>> PREEMPT_DYNAMIC Debian 6.3.2-1~exp1 (2023-05-15) x86_64 GNU/Linux)
>>>
>>> same problem.
>>>
>>> At local library's public open wifi, no password required.  Using either
>>>
>>>     0bda:0179 (rtl8188eu) USB Wifi adapter,
>>>
>>> or
>>>
>>>     0bda:f179 (rtl8188fu) USB Wifi adapter
>>>
>>> Both adapters are loading
>>>
>>>     rtl8xxxu kernel module
>>>
>>> Using ( manual Wifi connection ) script , the system was able to obtain DHCP IP
>>> address.  Normally, all HTTP(S) requests get redirected to a public usage
>>> policy web page, where users have to click on "I agree" to continue.  Which
>>> works fine with another USB adapter (mt7601 kernel module).
>>>
>>> However, with both Realtek adapters above, web browser will just time out, will
>>> NOT even get redirect to a "Public Use Notice" web page.
>>>
>>> The relevant error message from system log shows
>>>
>>>     2023-05-15T16:57:48.491567-04:00 usrhostname kernel: wlan1: deauthenticated
>>> from 7a:83:c2:8a:f1:13 (Reason: 6=CLASS2_FRAME_FROM_NONAUTH_STA)
>>>
>>> Apparently, the rtl8xxxu driver assumes an error condition, and immediately
>>> deauthenticates and drops the Wifi connection, will not complete the
>>> redirection to the "Public Use Notice" web page.
>>>
>>> Try to connect again, same problem, repeating itself, not allowing any
>>> additional wifi traffic at all.
>> 
>> See Bugzilla for the full thread.
>> 
>> The reporter said that this is known rtl8xxxu issue (unusable on public,
>> open WiFi access points [no WPA authentication?]). From his analysis:
>> 
>>> Let me know if I need to do anything else. I looek at the code
>>> briefly, I belive the rtl8xxxu called a function from 802.11 layer
>>> to handle the return code (Reason code 6), which promptly call a
>>> function to deauthenticate the session, thus disconnected the
>>> device from further wifi traffic.
>>>
>>> I believe the 802.11 level handling is too harsh for public open
>>> AP. However, i think the Realtek level code is too lazy. Realtek
>>> driver code should check for reasonable return codes for situations
>>> like this and allow paasing at least a few of these before
>>> considering these as hacking attempts, which require
>>> deauthenticating, or disconnecting. But then again, this would also
>>> be too strict for monitor mode handling of traffic.
>>>
>>> Don't know if 802.11 level specs even have considerations for
>>> situations like these at all, or they simply handle lower level
>>> logic and leave these things for the device drivers to cooperate
>>> with application layers to handle these.
>> 
>> Jes and Kalle, would you like to take a look on checking return codes
>> (as reporter demands)?
>> 
>
> FYI, from Bugzilla [1], the reporter posted (untested) fix. Would you
> like to review it?
>
> Thanks.
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217531#c8

I'm not seeing any fix from the reporter, where is it?

Also more information would be good to have to pinpoint where the actual
problem is. For example, it would be good to test different APs with
different encryption methods and make a list what works and what doesn't
on his device. There can be numerous reasons for the problem.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
