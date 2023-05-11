Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790136FF684
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbjEKPy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238440AbjEKPyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:54:49 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD716A7C;
        Thu, 11 May 2023 08:54:46 -0700 (PDT)
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9E9D34218A;
        Thu, 11 May 2023 15:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683820483;
        bh=9131OsjK4tvQX0ZOTvzsxE7ndhiybcAOfx0nYg/wlz0=;
        h=From:Subject:Date:Message-ID:To;
        b=NMJUnKvMlQa2o0gbL06CNq/mNbNlR7C1DRHbJea3J0MN33pZk8gcg3eMkGKykb1bv
         BPMjEAXQJZGnWjGH2McIpfjrhRMHCcNeTR/Rz8co4wPbqGaZJhkNLw8gNKcmU+jHkd
         pec3eWbL0y6twBCsFuAR2NyCJEBsNkd3QFkW9vvJD0ILS+pQXs/dqtVi0V9CqQLEaC
         Yn8Iu0w5EVqAgefYkdEx9uObhvyKesgXcXneVfzcviEVmkoZ7YVzxx5K73UmgodTXe
         kCF6DdqcvmYD2sIowE6XRyy7qrfBqkRS/zW3qs9kJJlGjTNR4V9M3YChCnHHPTdTZc
         +CW2DmATDMZoA==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.111-rt63
Date:   Thu, 11 May 2023 15:49:30 -0000
Message-ID: <168382017084.235454.8413979899849286593@jupiter.home.arpa>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.111-rt63 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 03aa894822a741d7a3c9659b7878f431f495514a

Or to build 5.15.111-rt63 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.111.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.111-rt63.patch.xz


Enjoy!
Joseph Salisbury
