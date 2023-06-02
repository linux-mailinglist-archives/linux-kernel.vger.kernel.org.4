Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2242871F704
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 02:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjFBAHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 20:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjFBAG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 20:06:58 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6773D1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 17:06:56 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:37446)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q4sJh-00Evgz-Q9; Thu, 01 Jun 2023 18:06:53 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:32956 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q4sJg-003GZB-ML; Thu, 01 Jun 2023 18:06:53 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     ~akihirosuda <akihirosuda@git.sr.ht>
Cc:     linux-kernel@vger.kernel.org, containers@lists.linux.dev,
        serge@hallyn.com, brauner@kernel.org, paul@paul-moore.com,
        ~akihirosuda <suda.kyoto@gmail.com>,
        akihiro.suda.cz@hco.ntt.co.jp
References: <168547265011.24337.4306067683997517082-0@git.sr.ht>
Date:   Thu, 01 Jun 2023 19:06:27 -0500
In-Reply-To: <168547265011.24337.4306067683997517082-0@git.sr.ht>
        (akihirosuda@git.sr.ht's message of "Tue, 30 May 2023 18:50:50 +0000")
Message-ID: <87v8g6bud8.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1q4sJg-003GZB-ML;;;mid=<87v8g6bud8.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19jCAD3VXiN6cfDqTILsJT4KFsn1CUFU9Y=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;~akihirosuda <akihirosuda@git.sr.ht>
X-Spam-Relay-Country: 
X-Spam-Timing: total 511 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 12 (2.3%), b_tie_ro: 10 (1.9%), parse: 1.61
        (0.3%), extract_message_metadata: 31 (6.0%), get_uri_detail_list: 2.5
        (0.5%), tests_pri_-2000: 18 (3.4%), tests_pri_-1000: 3.3 (0.6%),
        tests_pri_-950: 1.65 (0.3%), tests_pri_-900: 1.30 (0.3%),
        tests_pri_-200: 1.07 (0.2%), tests_pri_-100: 8 (1.5%), tests_pri_-90:
        92 (18.0%), check_bayes: 81 (15.8%), b_tokenize: 7 (1.4%),
        b_tok_get_all: 7 (1.3%), b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 60
        (11.8%), b_finish: 1.20 (0.2%), tests_pri_0: 225 (44.0%),
        check_dkim_signature: 0.70 (0.1%), check_dkim_adsp: 6 (1.3%),
        poll_dns_idle: 86 (16.9%), tests_pri_10: 4.0 (0.8%), tests_pri_500:
        108 (21.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH linux 0/3] [PATCH] userns: add sysctl
 "kernel.userns_group_range"
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

~akihirosuda <akihirosuda@git.sr.ht> writes:

> This sysctl limits groups who can create a new userns without
> CAP_SYS_ADMIN in the current userns, so as to mitigate potential kernel
> vulnerabilities around userns.
>
> The sysctl value format is same as "net.ipv4.ping_group_range".
>
> To disable creating new unprivileged userns, set the sysctl value to "1
> 0" in the initial userns.
>
> To allow everyone to create new userns, set the sysctl value to "0
> 4294967294". This is the default value.
>
> This sysctl replaces "kernel.unprivileged_userns_clone" that is found in
> Ubuntu [1] and Debian GNU/Linux.
>
> Link: https://git.launchpad.net/~ubuntu-
> kernel/ubuntu/+source/linux/+git/jammy/commit?id=3422764 [1]
>
> Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>

How does this functionally differ from what already exists
user.max_user_namespaces?

Given that setns exists I don't see limiting creation of user namespaces
by group being meaningful, if your goal is to reduce the attack surface
of the kernel to mitigate potential kernel vulnerabilities.

How does this functionality interact with the use of setgroups in a user
namespace?

What is the value of a group_range inside of a newly created user
namespace?  How does that work to maintain the policy you are trying to
implement?

Eric
