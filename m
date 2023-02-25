Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423A96A2996
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 13:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBYM2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 07:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYM2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 07:28:41 -0500
Received: from libero.it (smtp-34-i2.italiaonline.it [213.209.12.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302AAC174
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 04:28:37 -0800 (PST)
Received: from [192.168.1.176] ([87.6.129.129])
        by smtp-34.iol.local with ESMTPA
        id VtfFpbgaxVfPJVtfFpeMdE; Sat, 25 Feb 2023 13:28:33 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1677328113; bh=U9HWUilyb102/W7SXs8xa+6SFX9cXMnZgMbuTw+1Qno=;
        h=From;
        b=tPt9Ln6kppP1yDObs2G/aEDLd0Qt1NwLAiC8DKo5xszMhSg6B9tk4p3mh+Fist6Fs
         SW/LNcAFc48E7BhyDFfOaW4yFPL0M+9LWS870tD8hqk7/B56m7ombRfluNQ7daWEgq
         t4U13eIG7RLWVUMxCtYa9AZqS24mva3YjLyesr+n5k5iHV601D7VpeJsS+aTnT/PGv
         0bDAX8aythn9enM4BNzBw1P59iRv6cyeV+VNo8BsfJ/XHVrKpIdgG3UydBh8+6EaCX
         SfutNb/G9QlGIA0LP92Vuoq8Vvxqu+IawHhlZtJJXF/qH8N5EHRxUlaXX3u3v4aXvv
         X5vsSdf9mFttQ==
X-CNFS-Analysis: v=2.4 cv=EKfAkXVC c=1 sm=1 tr=0 ts=63f9fef1 cx=a_exe
 a=ZxqhrVAgG8YdQk3VCnDUFw==:117 a=ZxqhrVAgG8YdQk3VCnDUFw==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=-3SVmXKf8f390CqTknYA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <5fa13893-c26f-110a-d3db-220fcedd0c87@inwind.it>
Date:   Sat, 25 Feb 2023 13:28:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Kernel panic - not syncing: Attempted to kill init!
 exitcode=0x00007f00
To:     Slade Watkins <srw@sladewatkins.net>
Cc:     linux-kernel@vger.kernel.org
References: <87f7b3f4-8586-4c10-d4f4-643ff5f0cf62@inwind.it>
 <CA+pv=HOSysost0YYeq4pw9VKjhtQDH6MvERrYpWyisme19b7dA@mail.gmail.com>
From:   Valerio Vanni <valerio.vanni@inwind.it>
In-Reply-To: <CA+pv=HOSysost0YYeq4pw9VKjhtQDH6MvERrYpWyisme19b7dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: AVG (VPS 230225-0, 25/2/2023), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4xfPDZI4CDfUwJCr13uSPvpLNUfULXBXQDTzWTDC6m99aA31UW7HwyE3W5mRPSDZjsHxns7xVLtsssHfqi1FDo8r2JEwhbyWpOPIlxFwAnOdZG2BKkbnDe
 F02B6suKw3WPahgvI/esR6LeDIcmOOOz5P8U5jpOMYJAal68v2JYkPOMqQkkvvIyZ8qjKF2m2W+dMW8u4bok7W3+nU68ub0WBAB4Td3Tqwx3lcTFRuJ0lkfH
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/02/2023 19:06, Slade Watkins ha scritto:

>> https://bugzilla.kernel.org/show_bug.cgi?id=217083
>>
>> I got this error after upgrading a Debian machine (x86-64) from Stretch
>> to Buster. Upgrade is successful, but the next boot it crashes.
> 
> Thanks for the details. What was the last known good kernel version
> that did not exhibit this issue on your system?

There isn't a last known good version. As I said, the issue appeared 
after an OS upgrade, not after a kernel one.
4.20.17 on Stretch was [1] working. After upgrade to Buster, kernel 
panic came out and I decided to try with other kernel versions.

>> The machine is an Asus B360M-A with an Intel i7-8700 CPU and 16GB DDR4.
>> My kernel is 4.20.17 (from kernel.org, not a distribution kernel), but I
>> tried with 4.19.273 and 5.10.169 with the same .config.
> 
> Also just a quick note, since I noticed you mention it here: 4.20.y is
> not supported (see kernel.org for a list of supported releases).
> 4.19.y and 5.10.y, however, are.

I know, it's the reason why I downloaded and tried 4.19.273 and 5.10.169 
before opening the bug report. I wanted to report on a supported version.
Yesterday I tried also 6.2, with the same result.

[1] And *is* working in the original place. I always test OS upgrades on 
a cloned drive. I can restore from image the screwed copy, retry upgrade 
etc. Also dangerous things.

