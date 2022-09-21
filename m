Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9E85BFAE1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiIUJ0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiIUJ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:26:05 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766E6895D0;
        Wed, 21 Sep 2022 02:26:02 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oavzT-0004S6-RL; Wed, 21 Sep 2022 11:25:59 +0200
Message-ID: <6a3660b2-fa7d-14a2-6977-f50926ad369c@leemhuis.info>
Date:   Wed, 21 Sep 2022 11:25:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Content-Language: en-US, de-DE
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Dusty Mabe <dusty@dustymabe.com>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
 <YxBZ4BBjxvAkvI2A@T590> <20220907073324.GB23826@lst.de>
 <Yxr4SD4d0rZ9TZik@T590> <20220912071618.GA4971@lst.de>
 <Yx/jLTknQm9VeHi4@T590> <95cbd47d-46ed-850e-7d4f-851b35d03069@dustymabe.com>
 <f2c28043-59e6-0aee-b8bf-df38525ee899@leemhuis.info>
 <d39e9149-fcb6-1f7c-4c19-234e74f286f8@kernel.dk>
 <20220920141217.GA12560@lst.de>
 <9594af4b-eb16-0a51-9a4a-e21bbce3317d@kernel.dk>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <9594af4b-eb16-0a51-9a4a-e21bbce3317d@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1663752362;c546a042;
X-HE-SMSGID: 1oavzT-0004S6-RL
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.22 16:14, Jens Axboe wrote:
> On 9/20/22 8:12 AM, Christoph Hellwig wrote:
>> On Tue, Sep 20, 2022 at 08:05:06AM -0600, Jens Axboe wrote:
>>> Christoph and I discussed this one last week, and he has a plan to try
>>> a flag approach. Christoph, did you get a chance to bang that out? Would
>>> be nice to get this one wrapped up.
>>
>> I gave up on that as it will be far too much change so late in
>> the cycle and sent you the revert yesterday.
> 
> Gotcha, haven't made it all the way through the emails of the morning yet.
> I'll queue it up.

Thx to both of you for taking care of this.

Nitpicking: that patch is missing a "CC: stable@..." tag to ensure
automatic and quick backporting to 5.19.y. Or is the block layer among
the subsystems that prefer to handle such things manually?

Ohh, and a fixes tag might have been good as well; a "Link:" tag
pointing to the report, too. If either would have been there, regzbot
would have noticed Christoph's patch posting and I wouldn't have
bothered you yesterday. :-) But whatever, not that important.

#regzbot fixed-by: 4c66a326b5ab784cddd72d

Ciao, Thorsten
