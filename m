Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5854731080
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244145AbjFOHYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237848AbjFOHYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:24:12 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7E212E;
        Thu, 15 Jun 2023 00:24:10 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q9hKw-0007ow-FO; Thu, 15 Jun 2023 09:24:06 +0200
Message-ID: <53903462-2552-b707-3831-cad3ef873b0d@leemhuis.info>
Date:   Thu, 15 Jun 2023 09:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] HID: logitech-hidpp: Handle timeout differently from busy
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Mark Lord <mlord@pobox.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <20230531082428.21763-1-hadess@hadess.net>
 <nycvar.YFH.7.76.2305311606160.29760@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm>
 <15bb2507-a145-7f1b-8e84-58aeb02484b9@leemhuis.info>
 <nycvar.YFH.7.76.2306061527080.29760@cbobk.fhfr.pm>
 <42b6e582-f642-7521-135a-449140984211@leemhuis.info>
In-Reply-To: <42b6e582-f642-7521-135a-449140984211@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686813850;36874d03;
X-HE-SMSGID: 1q9hKw-0007ow-FO
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.06.23 20:18, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 06.06.23 15:27, Jiri Kosina wrote:
>> On Mon, 5 Jun 2023, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>>>> If an attempt at contacting a receiver or a device fails because the
>>>>>> receiver or device never responds, don't restart the communication, only
>>>>>> restart it if the receiver or device answers that it's busy, as originally
>>>>>> intended.
>>>>>> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> [...]  
>>>> Unfortunately it doesn't seem to cure the reported issue (while reverting 
>>>> 586e8fede79 does):
> [...]
>> This should now all be fixed by
>>
>>     https://git.kernel.org/linus/7c28afd5512e371773dbb2bf95a31ed5625651d9
> 
> Jiri, Benjamin, many many thx for working on this.

FWIW, it seems things work for many people, but something still is not
completely right:

```
https://bugzilla.kernel.org/show_bug.cgi?id=217412

--- Comment #47 from Mark Blakeney ---
@Juha, kernel 6.3.7 adds the 2 patches intended to fix this bug and the
startup delay is now gone. However, I have had 2 cases over the last 5
days in which I have been running 6.3.7 where my mouse fails to be
detected at all after startup. I have to pull the Logitech receiver
out/in to get the mouse working. Never seen this issue before so I
suspect the patches are not right.
```

Ciao, Thorsten
