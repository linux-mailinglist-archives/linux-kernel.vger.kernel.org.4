Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4052771F81D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjFBBl4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 21:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjFBBlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:41:55 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA1E97
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:41:52 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:52334)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q4tna-004fqV-3x; Thu, 01 Jun 2023 19:41:50 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:56980 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q4tnY-0034gx-SS; Thu, 01 Jun 2023 19:41:49 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "~akihirosuda" <suda.kyoto@gmail.com>,
        linux-kernel@vger.kernel.org, containers@lists.linux.dev,
        serge@hallyn.com, brauner@kernel.org, akihiro.suda.cz@hco.ntt.co.jp
References: <168547265011.24337.4306067683997517082-0@git.sr.ht>
        <CAHC9VhQhBBPyZE24LM6KvYrET2huW-W_YYsyPndpNkn70Mu3Ug@mail.gmail.com>
        <87fs7abu0f.fsf@email.froward.int.ebiederm.org>
        <CAHC9VhRk3WhXh-GTDSKFW3PujXiQCDy3xk4Xb9_Lo4szgQ5G6Q@mail.gmail.com>
Date:   Thu, 01 Jun 2023 20:41:42 -0500
In-Reply-To: <CAHC9VhRk3WhXh-GTDSKFW3PujXiQCDy3xk4Xb9_Lo4szgQ5G6Q@mail.gmail.com>
        (Paul Moore's message of "Thu, 1 Jun 2023 21:01:55 -0400")
Message-ID: <87ilc67i95.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1q4tnY-0034gx-SS;;;mid=<87ilc67i95.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19VrZxVOemsucyaabfl73Cwk/oBg1+agj4=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Paul Moore <paul@paul-moore.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 661 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 13 (2.0%), b_tie_ro: 11 (1.7%), parse: 1.45
        (0.2%), extract_message_metadata: 24 (3.6%), get_uri_detail_list: 1.70
        (0.3%), tests_pri_-2000: 22 (3.3%), tests_pri_-1000: 3.2 (0.5%),
        tests_pri_-950: 1.66 (0.3%), tests_pri_-900: 1.31 (0.2%),
        tests_pri_-200: 1.03 (0.2%), tests_pri_-100: 4.4 (0.7%),
        tests_pri_-90: 155 (23.4%), check_bayes: 123 (18.6%), b_tokenize: 7
        (1.0%), b_tok_get_all: 7 (1.0%), b_comp_prob: 2.5 (0.4%),
        b_tok_touch_all: 103 (15.6%), b_finish: 1.18 (0.2%), tests_pri_0: 413
        (62.5%), check_dkim_signature: 0.98 (0.1%), check_dkim_adsp: 4.7
        (0.7%), poll_dns_idle: 0.57 (0.1%), tests_pri_10: 2.3 (0.3%),
        tests_pri_500: 14 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH linux 0/3] [PATCH] userns: add sysctl
 "kernel.userns_group_range"
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> On Thu, Jun 1, 2023 at 8:14 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Paul Moore <paul@paul-moore.com> writes:
>> >
>> > Given the challenges around adding access controls to userns
>> > operations, have you considered using the LSM support that was added
>> > upstream last year?  The relevant LSM hook can be found in commit
>> > 7cd4c5c2101c ("security, lsm: Introduce security_create_user_ns()"),
>>
>> Paul how have you handled the real world regression I reported against
>> chromium?
>
> I don't track chromium development.

You have chosen to be the maintainer and I reported it to you.

>> Paul are you aware that the LSM hook can not be used to achieve the
>> objective of this patchset?
>
> /me shrugs
>

[snip parts about performing a group id check]

The LSM hook you added does not have the technical capability to reduce
the attack surface to mitigate bugs in the kernel.  It is the
ineffectiveness of the hook not the permission check that I was
referring to.

Eric
