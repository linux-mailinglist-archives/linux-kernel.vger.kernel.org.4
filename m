Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED90E61E6A8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 22:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiKFVpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 16:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiKFVpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:45:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36806BF70;
        Sun,  6 Nov 2022 13:45:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFE0D60DDA;
        Sun,  6 Nov 2022 21:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2E4C433C1;
        Sun,  6 Nov 2022 21:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667771149;
        bh=YLPSQwLHfaeoCgK19dKv5gYJV1PcqbtPt/rxzTGnmhg=;
        h=Subject:From:To:Date:From;
        b=O3K9tODvS85NLThT6eghrFteOPI+P4wUzZDqz7v05r1dGeQHqtIETkbARG35wg7jo
         EAIUjUcK6XgFKwWlvaBJYjsKZgl2F6kIiewjfuUy2S8tJQCaqorhBRCM7n62u9Ia1T
         xknrbenXKeSghFRWcLK6Z1+b+2BCkGFqzm4517iO6NQKtGWXJFqZieDG8KcXX+KI6l
         XFETrr29EtlmeQj1w1kcIrd3w+0mq5Q6M970/EXozEilBpYNJj1q3rjWVJ4dra//ew
         IoedRL9lCOoUP+f+IvOjUjKI0j1GZMOAUjEkDSXA3Az1Pt5/Pfdvgv2zbIi45h2UXc
         iuOo2LFeXioVw==
Message-ID: <6ffe3787fda7cb175dd32d728c1bd0cb9583e85b.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.221-rt79
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Sun, 06 Nov 2022 15:45:47 -0600
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.221-rt79 stable release.

This release is just an update to the new stable 5.4.221
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 898397eb311e8bc7023173874d89c47e443e533f

Or to build 5.4.221-rt79 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.221.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.221-rt7=
9.patch.xz


Enjoy!

   Tom

