Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2ED646984
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 08:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLHHBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 02:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLHHBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 02:01:33 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFA06F0F9;
        Wed,  7 Dec 2022 23:01:32 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p3AuO-0001K9-4N; Thu, 08 Dec 2022 08:01:28 +0100
Message-ID: <1377cc24-62c8-0c96-9ea4-3d08e513fb20@leemhuis.info>
Date:   Thu, 8 Dec 2022 08:01:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1 0/2] HID: Revert catchall handling of Bluetooth device
 in hid-logitech-hidpp
Content-Language: en-US, de-DE
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bastien Nocera <hadess@hadess.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221207142433.1158329-1-benjamin.tissoires@redhat.com>
 <nycvar.YFH.7.76.2212071757220.6045@cbobk.fhfr.pm>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <nycvar.YFH.7.76.2212071757220.6045@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1670482892;371f793d;
X-HE-SMSGID: 1p3AuO-0001K9-4N
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.12.22 17:57, Jiri Kosina wrote:
> On Wed, 7 Dec 2022, Benjamin Tissoires wrote:
> 
>> We are basically too late in the 6.1 cycle to be able to do anything
>> else. Let's revert these 2 patches as we are in a situation where we
>> would break too many users.
>>
>> We will reintroduce them during the next cycle with proper fixes in the
>> driver.
> 
> it would be nice to get
> 
> 	Reported-by:

Nitpicking: and as for nearly every Reported-by it would be nice to have
an accompanying Link: tag pointing to the report, which makes my
regression tracking life a whole lot easier *and* is nice for future
code archaeologist, as it makes it easier to find Rafael's great
analysis of the cause -- which is why Linus want to see these tags, too
[1] (and why our docs tell people to add them[2]).

Ciao, Thorsten

[1] for details, see:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

[2] see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)
