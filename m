Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7176B6D7DBB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbjDENaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbjDEN36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:29:58 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C290730F3;
        Wed,  5 Apr 2023 06:29:57 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pk3Cy-0006DQ-5p; Wed, 05 Apr 2023 15:29:52 +0200
Message-ID: <065a556a-a4a1-cb94-7996-7c4eee373b2c@leemhuis.info>
Date:   Wed, 5 Apr 2023 15:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: scsi: Recent kernels drop into emergency shell
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, hare@suse.de, hch@lst.de, ming.lei@redhat.com,
        sumanesh.samanta@broadcom.com, michael.christie@oracle.com,
        john.garry@huawei.com, johannes.thumshirn@wdc.com, axboe@kernel.dk,
        osandov@fb.com, kashyap.desai@broadcom.com,
        gregkh@linuxfoundation.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <20230220061559.GJ159593@linux.vnet.ibm.com>
 <8489afbb-2391-c22f-41fc-21726f09e444@leemhuis.info>
In-Reply-To: <8489afbb-2391-c22f-41fc-21726f09e444@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1680701397;c77d0f59;
X-HE-SMSGID: 1pk3Cy-0006DQ-5p
X-Spam-Status: No, score=-1.4 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 20.02.23 08:40, Linux regression tracking (Thorsten Leemhuis) wrote:

> On 20.02.23 07:15, Srikar Dronamraju wrote:
>> On a freshly installed system, booting latest upstream kernels causes the
>> system to drop into emergency shell. The reason for dropping into emergency
>> shell is system is unable to mount /home partition.
>
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced c92a6b5d63359dd
> #regzbot title scsi: storage not properly detected
> #regzbot ignore-activity

I had missed that a fix for this was applied, as it didn't contain a
link to the reports for this issue, hence I have to specify it manually
to resolve this:

#regzbot fix: 4b1a2c2a8e0ddcb89c
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


