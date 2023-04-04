Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF716D61B7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbjDDMz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbjDDMz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:55:56 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5D4212A;
        Tue,  4 Apr 2023 05:55:53 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pjgCV-00085a-KP; Tue, 04 Apr 2023 14:55:51 +0200
Message-ID: <fb31aa79-ad4a-0c2d-3f77-4eb84bedfd4f@leemhuis.info>
Date:   Tue, 4 Apr 2023 14:55:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US, de-DE
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     workflows@vger.kernel.org, aros@gmx.com,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        tools@linux.kernel.org
References: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q>
 <b38de7ff-3de1-cd4a-a532-66642aea587c@leemhuis.info>
 <20230404-bacteria-refinery-a97393@meerkat>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Introducing bugbot
In-Reply-To: <20230404-bacteria-refinery-a97393@meerkat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1680612953;b7f2feb0;
X-HE-SMSGID: 1pjgCV-00085a-KP
X-Spam-Status: No, score=-1.9 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.04.23 14:36, Konstantin Ryabitsev wrote:
> On Tue, Apr 04, 2023 at 07:58:40AM +0200, Thorsten Leemhuis wrote:
>> Would be great if bugbot could CC the regressions list for all bugs that
>> have the regressions flag set to "yes"
> I'll see if I can add this logic and make it configurable.

great, thx!

>> How does one make bugbot forward a bug to everyone in the signed-off-by
>> chain of a commit that caused a regression, which might or might not
>> have a bugzilla account?  When the reporter performed a bisection these
>> are the primary contacts that need to be reached out to, but the
>> maintainers and lists for the subsystem obviously should be CCed.
> 
> I can add a cf_bisected_commit field that can take a commit-id. When gathering
> recipients, we can check if we know that commit in one of the tracked
> repositories, and get the author field out of it. Would that be sufficient,

Nearly, as mentioned above: it should be everybody in the signed-off-by
chain (as explained in reporting-issues.rst), as that will catch
co-developers and the people that handled the change on the way.

> or do we need to run get_maintainer on it for a full picture?

The normal magic you described that bugbot applies to match reports to
subsystems is also needed, as otherwise lists and co-maintainer would
not be in the loop.

> Note, that you can also add addresses to Cc: on the thread -- they will be
> collected behind the scenes as each message is processed and any bugbot
> notifications originating from the bugzilla side will also include them.

That's good to know and likely will be handy sometimes, but well, for
regular use of the bugzilla->mailing list use-case it would be slightly
annoying if you'd first have to tell bugzilla to create a ml thread,
which you then need to find to write a reply to add people to the CC.

Ciao, Thorsten
