Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD5E727036
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbjFGVFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbjFGVEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:04:37 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A2E273C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 14:04:18 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 38D9776180E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 21:04:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C0B8176178E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 21:04:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686171857; a=rsa-sha256;
        cv=none;
        b=tojnCjr/6+eYNyelAoOvvsiaJ2iocYsvtz1cRKZxsf45Yytrs6wUme9Nd4TYFGxlZtXGJy
        uRlgbMVt27Ugmuhdy2lzcpEVbQpHrxXNQTgCjRp8iuFFUZPBaoI5Ev29zOUyvqPfU2uKvU
        o5FqnvB0SHD2GSQttNha5CFR0Kz3pt+/0gAKyBLD1M0aIFh3yhDdIYmkR+akioQj5jomYx
        WssFXipg8Ljit42Y4WB0GpLQaKrEi7MBEVfaTiPQbJ457IjgfBRQEfApZYVkd9N9sczza/
        Se0eUkQkR7qvrqvAUo4maU/UEgqlcSHC8AaXU6dFF8M8fJ7oU5OxgRF/3r8IJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686171857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=5/ao13F8CNYp1ZMCVek/NrMErWLjCVRsd7llF9n1i+4=;
        b=Vpy+cBFWQm6PZwMY4YAdy2Kj0SE2wCpwUyUgb/YCxFGo24JnIAxghn3PNUHluvMCu0WOPX
        81p3u4Oizp9zA8ET6ata/E00xcEix735c0NNQHDtuyJDU3lRBfbqRBYO55Jq0sjjFLiEyn
        8OPco3Q/XhKF05N8+xME3SRdKHraGDYzCZ3Q9ebC2xlmml0usIpkbSWxS3jNHQjGpnuvWR
        82cN4OR2e9zLOtqKGjr0vxUJ800n9uPAH+FqWqAMrtBpxiKQWUhtvyJgk45854mdYgNGA2
        o5QuwA8KDvXyidv1kif2Yr+s7dp1Aqq3ZfcQbzj/V8iqMSKXFhr73hFHWxW5Og==
ARC-Authentication-Results: i=1;
        rspamd-6f5cfd578c-rzxxj;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Fumbling-Left: 5585d2700cbc40c5_1686171858014_3778734404
X-MC-Loop-Signature: 1686171858014:754482429
X-MC-Ingress-Time: 1686171858014
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.18 (trex/6.8.1);
        Wed, 07 Jun 2023 21:04:18 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4Qc0Fs1G5fzml
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 14:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686171857;
        bh=5/ao13F8CNYp1ZMCVek/NrMErWLjCVRsd7llF9n1i+4=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Ks06xLF7GgKn/OTiw8dmTQO8nej2Brz6p1ADLhr2dsBmEKI2DmGH2E2TYoyVG362f
         6xxKjIH2WwcZo10JQ1hxEzYhUGIXIcK3Dp6Nl+m4Alm0omgGG4c49q22t1Obk0kDx6
         B6Mik2b4H+v8QyYk1XKNohlCXlCbPSxsXri5V0PY=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e005f
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 07 Jun 2023 14:04:16 -0700
Date:   Wed, 7 Jun 2023 14:04:16 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH bpf v2 0/2] bpf: fix NULL dereference during extable search
Message-ID: <cover.1686166633.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Enclosed are a pair of patches for an oops that can occur if an exception is
generated while a bpf subprogram is running.  One of the bpf_prog_aux entries
for the subprograms are missing an extable.  This can lead to an exception that
would otherwise be handled turning into a NULL pointer bug.

The bulk of the change here is simply adding a pair of programs for the
selftest.  The proposed fix in this iteration is a 1-line change.

These changes were tested via the verifier and progs selftests and no
regressions were observed.

Changes from v1:

- Add a selftest (Feedback From Alexei Starovoitov)
- Move to a 1-line verifier change instead of searching multiple extables

Krister Johansen (2):
  Add a selftest for subprogram extables
  bpf: ensure main program has an extable

 kernel/bpf/verifier.c                         |  1 +
 .../bpf/prog_tests/subprogs_extable.c         | 35 +++++++++
 .../bpf/progs/test_subprogs_extable.c         | 71 +++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extable.c

-- 
2.25.1

