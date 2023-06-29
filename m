Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04259742BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjF2SQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjF2SQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:16:15 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9DE2D50;
        Thu, 29 Jun 2023 11:16:14 -0700 (PDT)
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2B7C4414C5;
        Thu, 29 Jun 2023 18:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688062571;
        bh=kdUlI6qXXtcT0LP53F8x4iayz3UG3VFxio0LjzvxI2o=;
        h=From:Subject:Date:Message-ID:To;
        b=QSY7y049WxiN7PBPbj1QyIDeefcnHqDmH+VGhIZTQl8qX5/nXA/GYVkA/YxUYQt3y
         LUcKk43NhWs3i83PMXSQxJLT+rxmki3I35C4qg8BMs9WCFA4Z4fiRJKcENVqFD8wXv
         rcYzWJQy1lm55Tj/t1ctWfVVp2wyhxvuupkBsiUrOaYJq4alYYnnBIlODr20Nkpu4X
         ttaXmXm7xahrPJy2Lo7zfjo5pKX67p2abGvmT69q2TvdVUi75lWkrpZU8zQyJMJQ2l
         2fD3zS8kwxzHJqoZEE1FQhVpxFYu3Qx1grWpX/PC5QDTxhjMyNu29SkHCALbxvO+oI
         WhKb2FK94JSCA==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.119-rt65
Date:   Thu, 29 Jun 2023 18:15:24 -0000
Message-ID: <168806252410.91340.17223192962525233289@jupiter.home.arpa>
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

I'm pleased to announce the 5.15.119-rt65 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: b850a37ed7e1bbe756c67b97b5428e1868825a9f

Or to build 5.15.119-rt65 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.119.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.119-rt65.patch.xz


Enjoy!
Joseph Salisbury
