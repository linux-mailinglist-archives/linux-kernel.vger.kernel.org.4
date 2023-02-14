Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CCA696F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjBNVSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjBNVSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:18:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF437AAB;
        Tue, 14 Feb 2023 13:18:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E3AAB81F19;
        Tue, 14 Feb 2023 21:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E99C433EF;
        Tue, 14 Feb 2023 21:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676409496;
        bh=XIoavVqXwjsCMtUtU7QDDhVmcTynXgHSU9Esc/DrcBk=;
        h=Subject:From:To:Date:From;
        b=matQGqNNxnQqx7smlTFQzVefexaEjVR2B4VSIWbbLqem1zEmM4Yhy4R4lYXvKdx6M
         UKZgat26AyqV9d07zzKdzftCaS+2pDZukQWSPheXQxrNhh0v8Bfn4T2fyMeF5kdl5r
         iPAtDxbgJB9m3KwTM5z2nHGSflDSmqO6G6kO8e3+DhCwZgTRg1H2rdGNO0ykKtAMGK
         Ij1c2sGVCwJb/hZTouHq0fBE9VWscGjxtfcGXfa0jvweZp8+mhvwKMoEpjO6tuXORc
         uuSga1NwtpFS/YRjRlmq55OA1lA1JV3Zw4X2Wul2ZaKcUKDQ/gU24lLvLlq//2zvwy
         DCvmex3yZDEpw==
Message-ID: <348dce99fff34dd8eb3fde665badf1627ebb19a6.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.230-rt80
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
Date:   Tue, 14 Feb 2023 15:18:12 -0600
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

I'm pleased to announce the 5.4.230-rt80 stable release.

This release is just an update to the new stable 5.4.230
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: d9cfce8c9787ac18e13853de09ac56fb4561ce9c

Or to build 5.4.230-rt80 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.230.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.230-rt8=
0.patch.xz


Enjoy!

   Tom


