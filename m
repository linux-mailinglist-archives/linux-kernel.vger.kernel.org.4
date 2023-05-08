Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06BE6FB5FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjEHRe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEHRez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:34:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995AE5BBA;
        Mon,  8 May 2023 10:34:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D7D461EB2;
        Mon,  8 May 2023 17:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FB4C433D2;
        Mon,  8 May 2023 17:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683567293;
        bh=qihO2vZPSWwKhKsG3TjRVrRpD5os+x4CtOB23qfQsGs=;
        h=Subject:From:To:Date:From;
        b=pmxQueRUuo76pKAIbj+ovStw/KsJUZeGgJxpG1Aphl+H8A8xNtBZgZbWk1YnAUml4
         nCIXbAL68Dj32FMEgrPLb5yYYKNPBx9jP4ztse41PiJbbeskMLj/cq+RN6EV3V1DlT
         7eQV2DF7AYzEHz7vJMDRf1sG+bD6annXYX/miGCE1NouLZqhDLEFU63KxtTxLb+n0T
         /yuFdeGTHlQwmlD4MFMvlwKoBMUljS4JHfjPSlinu4OQVsBzIVlXXO0RUW6E5skPI0
         qQi38wPKsr9SzhtLnNFL0ISyaC6C8uijuSyFcZlasqU1aaLezL0OJs1X/VI4i8wCyN
         +Jq4/iB3WEaMg==
Message-ID: <b3019873cbb55ed384127f123d9f597b43fe457b.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.242-rt81
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
Date:   Mon, 08 May 2023 12:34:50 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.242-rt81 stable release.

This release is just an update to the new stable 5.4.242
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 4a0638626d58e1334f70a086191e3d5e25f2c738

Or to build 5.4.242-rt81 directly, the following patches should be
applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.242.xz

=20
https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.242-rt81.=
patch.xz


Enjoy!

   Tom

