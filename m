Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B72071F70A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 02:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjFBAOU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 20:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjFBAOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 20:14:18 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EB912C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 17:14:17 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:38966)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q4sQp-00Ew6R-PT; Thu, 01 Jun 2023 18:14:15 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:54766 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q4sQo-003HU4-La; Thu, 01 Jun 2023 18:14:15 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "~akihirosuda" <suda.kyoto@gmail.com>,
        linux-kernel@vger.kernel.org, containers@lists.linux.dev,
        serge@hallyn.com, brauner@kernel.org, akihiro.suda.cz@hco.ntt.co.jp
References: <168547265011.24337.4306067683997517082-0@git.sr.ht>
        <CAHC9VhQhBBPyZE24LM6KvYrET2huW-W_YYsyPndpNkn70Mu3Ug@mail.gmail.com>
Date:   Thu, 01 Jun 2023 19:14:08 -0500
In-Reply-To: <CAHC9VhQhBBPyZE24LM6KvYrET2huW-W_YYsyPndpNkn70Mu3Ug@mail.gmail.com>
        (Paul Moore's message of "Tue, 30 May 2023 17:58:48 -0400")
Message-ID: <87fs7abu0f.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1q4sQo-003HU4-La;;;mid=<87fs7abu0f.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19DIiVSRQ5BpipU+RbDjDyU5NgJlxnB9UQ=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Paul Moore <paul@paul-moore.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 541 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.1%), b_tie_ro: 10 (1.8%), parse: 0.96
        (0.2%), extract_message_metadata: 20 (3.7%), get_uri_detail_list: 1.60
        (0.3%), tests_pri_-2000: 19 (3.4%), tests_pri_-1000: 2.5 (0.5%),
        tests_pri_-950: 1.29 (0.2%), tests_pri_-900: 1.08 (0.2%),
        tests_pri_-200: 0.90 (0.2%), tests_pri_-100: 6 (1.1%), tests_pri_-90:
        68 (12.6%), check_bayes: 67 (12.3%), b_tokenize: 6 (1.2%),
        b_tok_get_all: 8 (1.5%), b_comp_prob: 2.4 (0.4%), b_tok_touch_all: 47
        (8.7%), b_finish: 0.93 (0.2%), tests_pri_0: 227 (42.0%),
        check_dkim_signature: 0.58 (0.1%), check_dkim_adsp: 2.5 (0.5%),
        poll_dns_idle: 164 (30.4%), tests_pri_10: 2.1 (0.4%), tests_pri_500:
        178 (32.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH linux 0/3] [PATCH] userns: add sysctl
 "kernel.userns_group_range"
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> On Tue, May 30, 2023 at 2:50 PM ~akihirosuda <akihirosuda@git.sr.ht> wrote:
>>
>> This sysctl limits groups who can create a new userns without
>> CAP_SYS_ADMIN in the current userns, so as to mitigate potential kernel
>> vulnerabilities around userns.
>>
>> The sysctl value format is same as "net.ipv4.ping_group_range".
>>
>> To disable creating new unprivileged userns, set the sysctl value to "1
>> 0" in the initial userns.
>>
>> To allow everyone to create new userns, set the sysctl value to "0
>> 4294967294". This is the default value.
>>
>> This sysctl replaces "kernel.unprivileged_userns_clone" that is found in
>> Ubuntu [1] and Debian GNU/Linux.
>>
>> Link: https://git.launchpad.net/~ubuntu-
>> kernel/ubuntu/+source/linux/+git/jammy/commit?id=3422764 [1]
>
> Given the challenges around adding access controls to userns
> operations, have you considered using the LSM support that was added
> upstream last year?  The relevant LSM hook can be found in commit
> 7cd4c5c2101c ("security, lsm: Introduce security_create_user_ns()"),


Paul how have you handled the real world regression I reported against
chromium?

Paul are you aware that the LSM hook can not be used to achieve the
objective of this patchset?

> and although only SELinux currently provides an access control
> implementation, there is no reason you couldn't add support for your
> favorite LSM, or even just a simple BPF LSM to enforce the group
> controls as you've described them here.

Is there a publicly available SELinux policy that uses that LSM hook?

Eric
