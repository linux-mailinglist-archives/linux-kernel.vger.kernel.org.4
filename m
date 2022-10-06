Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FCD5F6C70
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJFRAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJFRAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:00:45 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F42186450
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:00:24 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ogUCt-0007k3-Pj; Thu, 06 Oct 2022 18:58:47 +0200
Message-ID: <6ba15505-1c04-df2b-237f-b3060f26d2e6@leemhuis.info>
Date:   Thu, 6 Oct 2022 18:58:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3 through
 6.0.0-rc7
Content-Language: en-US, de-DE
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-kernel@vger.kernel.org
Cc:     Marc Miltenberger <marcmiltenberger@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <5bb75cbc-a0db-537b-12d0-889230c865d8@leemhuis.info>
 <0fb2a9ff-df76-8af9-e54a-c2dc6bfd9478@leemhuis.info>
 <bdab45d3-c893-42ff-dbb9-5fa93d0dff55@alu.unizg.hr>
 <dd62210d-d095-f971-2b7b-0ec54fd189a9@leemhuis.info>
 <c05134cc-92fa-dac2-e738-cf6fae194521@alu.unizg.hr>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <c05134cc-92fa-dac2-e738-cf6fae194521@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1665075625;3f7dd9c3;
X-HE-SMSGID: 1ogUCt-0007k3-Pj
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.10.22 18:43, Mirsad Goran Todorovac wrote:
> Hey Thorsten,
> 
> On 06. 10. 2022. 15:23, Thorsten Leemhuis wrote:
>> On 06.10.22 14:43, Mirsad Todorovac wrote:
>>> On 10/6/22 14:25, Thorsten Leemhuis wrote:
>>>
>>>> One more question:
>>>>
>>>> On 06.10.22 14:00, Thorsten Leemhuis wrote:
>>>> Were those two vanilla kernels? I asked in #snappy on IRC and was told
>>>> that "snapd simply expects some ubuntu bit in patched into the kernel if
>>>> it detects that it runs on an official ubuntu install...". This was also
>>>> suggested "it probably makes sense to file a but in LP to make the
>>>> kernel team aware".
>>>>
>>> Yes, last time I tried it with git clone from linux_stable on kernel.org
>>> and
>>> config-6.0.0-060000-generic from the official Ubuntu mainline build
>> You don't want to do that. Better take the config used to build a
>> working kernel (say 5.19.y) and then build 6.0 with it (after running
>> "make olddefconfig"), because it might be a new kernel option (say for a
>> new security technique) that might cause the problem, as explained here:
>> https://docs.kernel.org/admin-guide/reporting-regressions.html
> If I understood well, that would mean building www.kernel.org git
> linux_stable
> source with Ubuntu's config-5.9.13-051903?

I meant "please download Linux 6.0 (ideally through git, that you have
everything to perform a bisection), add the config from a working kernel
(if config-5.9.13-051903 is one, yeah, then take that) as .config and
then run "make olddefconfig" before compiling and installing the kernel
to see if 6.0 fails with that config that was working.

Ciao, Thorsten
