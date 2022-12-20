Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0721E651E96
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiLTKPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbiLTKP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:15:28 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D5F2653;
        Tue, 20 Dec 2022 02:15:23 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p7Zeb-0008Ua-WB; Tue, 20 Dec 2022 11:15:22 +0100
Message-ID: <343bc8a5-a426-8f6a-70b9-3877f53c003f@leemhuis.info>
Date:   Tue, 20 Dec 2022 11:15:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [git pull] Input updates for v6.1-rc5 #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <Y3gwySzRvhCwdSgW@google.com>
 <824effa5-8b9a-c28a-82bb-9b0ab24623e1@kernel.org>
 <95b6739b-6d8e-dc41-b637-e366ac883829@leemhuis.info>
In-Reply-To: <95b6739b-6d8e-dc41-b637-e366ac883829@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1671531323;f87be96b;
X-HE-SMSGID: 1p7Zeb-0008Ua-WB
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: this mail contains only information for Linux kernel regression
tracking. Mails like these contain '#forregzbot' in the subject to make
then easy to spot and filter out. The author also tried to remove most
or all individuals from the list of recipients to spare them the hassle.]

On 15.12.22 08:39, Thorsten Leemhuis wrote:

>> This was reported downstream as a regression between 6.0.10 and 6.0.12:
>> https://bugzilla.suse.com/show_bug.cgi?id=1206358
>>
>> Full dmesgs available there too.
>>
>>
>> 6.0.10 has this instead of the above:
>> psmouse serio1: synaptics: queried max coordinates: x [..5648], y [..4826]
>> psmouse serio1: synaptics: queried min coordinates: x [1292..], y [1026..]
>> psmouse serio1: synaptics: Your touchpad (PNP: SYN3286 PNP0f13) says it
>> can support a different bus. If i2c-hid and hid-rmi are not used, you
>> might want to try setting psmouse.synaptics_intertouch to 1 and report
>> this to linux-input@vger.kernel.org.
>> psmouse serio1: synaptics: Touchpad model: 1, fw: 8.16, id: 0x1e2b1,
>> caps: 0xf00323/0x840300/0x2e800/0x400000, board id: 3320, fw id: 2659795
> 
> P.P.S.: I for now assume that it's a problem that also is present in
> mainline and thus will track it as such.
> 
> #regzbot introduced ac5408991ea6
> https://bugzilla.suse.com/show_bug.cgi?id=1206358
> #regzbot title input: synaptics: keyboard broken on HP's 15-da1xxx
> #regzbot ignore-activity


#regzbot fix: Revert "Input: synaptics - switch touchpad on HP Laptop
15-da3001TU to RMI mode"
