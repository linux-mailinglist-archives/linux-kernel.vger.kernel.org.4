Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1077122E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242891AbjEZJD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbjEZJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:03:24 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D5E18D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:03:22 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q2TLz-0000DY-03; Fri, 26 May 2023 11:03:19 +0200
Message-ID: <0405d1c8-43b2-e01f-6b85-f438cfe8b83a@leemhuis.info>
Date:   Fri, 26 May 2023 11:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <17726d05-91bb-55da-e2f9-a9ba5b8d2223@leemhuis.info>
In-Reply-To: <17726d05-91bb-55da-e2f9-a9ba5b8d2223@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1685091802;a9ccec5b;
X-HE-SMSGID: 1q2TLz-0000DY-03
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.23 16:06, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> On 05.05.23 15:40, Nicolas Dichtel wrote:
>> Le 03/02/2023 à 00:25, Mike Christie a écrit :
>>> For vhost workers we use the kthread API which inherit's its values from
>>> and checks against the kthreadd thread. This results in the wrong RLIMITs
>>> being checked, so while tools like libvirt try to control the number of
>>> threads based on the nproc rlimit setting we can end up creating more
>>> threads than the user wanted.
>>
>> I have a question about (a side effect of?) this patch. The output of the 'ps'
>> command has changed. Here is an example:
>> [...]
> 
> Thanks for the report. This is already dealt with, but to be sure the
> issue doesn't fall through the cracks unnoticed, I'm adding it to
> regzbot, the Linux kernel regression tracking bot:
> 
> #regzbot ^introduced 6e890c5d502
> #regzbot title vhost: ps output changed and suspend fails when VMs are
> running
> #regzbot ignore-activity

#regzbot monitor:
https://lore.kernel.org/all/20230522025124.5863-1-michael.christie@oracle.com/
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

