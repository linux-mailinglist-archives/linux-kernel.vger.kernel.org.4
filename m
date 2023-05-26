Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C25B712A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbjEZQS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEZQS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:18:56 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169C2A4;
        Fri, 26 May 2023 09:18:55 -0700 (PDT)
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D33FC3F26C;
        Fri, 26 May 2023 16:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685117930;
        bh=g9Hovuhx9kPE+UCnZ1N7tefI4DJS8ixf28LJsTdyAKI=;
        h=From:Subject:Date:Message-ID:To;
        b=igxNfjLY8SkWlYrB+zxq8U5SAYR2XQR2MqqHYO3t/fs0IQd46ANsQPIuplmFVvQjB
         zgUCn5yyaojK3ov8NSXHQLiQiQbsbi4tOElpL4AdqedjV++5ttXyK0nb2AK3uoktnE
         T583qea2Zv3GskUGd+E28rBYI7JsNkuce3PNTIFtyiIF7DaF1I2vNtdJ5bsjUmZLnc
         d2v53n0IgfrDlbQh0YQPnMN6sHKgCU3DF8B0W7l/NoQ/4TuNKtK+b2tuOWL1+xE0Oe
         37iU6xViUlRAITSRHjTgbakUaiv9Fh1uj4i8gL2sQfsIEh06XuwIxDf1jilC7p/a/T
         5UbGHJ0vrn7QA==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.113-rt64
Date:   Fri, 26 May 2023 16:11:29 -0000
Message-ID: <168511748992.700190.150767189449225263@jupiter.home.arpa>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.113-rt64 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 05e341da63646400e230c505fc07c6b1cd0194ec

Or to build 5.15.113-rt64 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.113.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.113-rt64.patch.xz


Enjoy!
Joseph Salisbury
