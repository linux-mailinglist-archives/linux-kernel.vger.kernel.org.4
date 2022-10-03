Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CDD5F3824
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJCVyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiJCVyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:54:41 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41395DFC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:54:38 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:53480)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ofTOY-00ETq1-08; Mon, 03 Oct 2022 15:54:38 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:35598 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ofTOX-008ZYe-5k; Mon, 03 Oct 2022 15:54:37 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Alexey Gladkov <legion@kernel.org>
Date:   Mon, 03 Oct 2022 16:54:30 -0500
Message-ID: <87k05gwp2h.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ofTOX-008ZYe-5k;;;mid=<87k05gwp2h.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/IIj4l3a2vN7S8oIB97sQ4g8hqvLiyvDo=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ******;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 299 ms - load_scoreonly_sql: 0.17 (0.1%),
        signal_user_changed: 13 (4.2%), b_tie_ro: 10 (3.5%), parse: 0.97
        (0.3%), extract_message_metadata: 3.9 (1.3%), get_uri_detail_list:
        1.20 (0.4%), tests_pri_-1000: 6 (2.0%), tests_pri_-950: 1.70 (0.6%),
        tests_pri_-900: 1.48 (0.5%), tests_pri_-90: 51 (17.0%), check_bayes:
        49 (16.4%), b_tokenize: 5 (1.8%), b_tok_get_all: 6 (2.0%),
        b_comp_prob: 2.1 (0.7%), b_tok_touch_all: 32 (10.7%), b_finish: 1.00
        (0.3%), tests_pri_0: 196 (65.5%), check_dkim_signature: 1.17 (0.4%),
        check_dkim_adsp: 3.1 (1.0%), poll_dns_idle: 0.92 (0.3%), tests_pri_10:
        2.1 (0.7%), tests_pri_500: 13 (4.3%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] ucounts: Split rlimit and ucount values and max values
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull ucount-rlimits-cleanups-for-v5.19 from the git tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git refs/tags/ucount-rlimits-cleanups-for-v5.19
  HEAD: de399236e240743ad2dd10d719c37b97ddf31996 ucounts: Split rlimit and ucount values and max values

After the ucount rlimit code was merged a bunch of small but
siginificant bugs were found and fixed.  At the time it was realized
that part of the problem was that while the ucount rlimits were very
similar to the oridinary ucounts (in being nested counts with limits)
the semantics were slightly different and the code would be less error
prone if there was less sharing.  This is the long awaited cleanup
that should hopefully keep things more comprehensible and less error
prone for whoever needs to touch that code next.

Alexey Gladkov (1):
      ucounts: Split rlimit and ucount values and max values

 fs/exec.c                      |  2 +-
 fs/proc/array.c                |  2 +-
 include/linux/user_namespace.h | 35 ++++++++++++++++++++++-------------
 kernel/fork.c                  | 12 ++++++------
 kernel/sys.c                   |  2 +-
 kernel/ucount.c                | 34 +++++++++++++++-------------------
 kernel/user_namespace.c        | 10 +++++-----
 7 files changed, 51 insertions(+), 46 deletions(-)
