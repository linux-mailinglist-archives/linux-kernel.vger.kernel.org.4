Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B06E63866E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiKYJm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiKYJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:42:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0322188D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:42:39 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669369356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YRPnORy9ghMlm6bMW/HwcUwyjymDsPNQMAZfp8edSwQ=;
        b=hT2CbsJ0u5GL16fEd8V8rW7ltp3AXMsOFLB8T9ZKHakVcXdAvvosVYAWLj0C5UYmuR38YR
        ht6hU5p2r0h69ib0l9GEgVsteaYLQqEczue5VW6WsuxvUm87PV+b7zodOLIPEyQ9s+g0lq
        B3jsinaq4gbDwWc/qzrVfSJ1ULhB+8cz6dDK11ntUc8IjrPJoZxFXUK+/NIe95Hxcx7gK7
        nbqJHydA8/whdY1utSQzceMc5h8EFvv8voCM6By2Sp0/uNm4MCXZJjZxmliUhXZzp+J1zN
        tjeZDpWWHjnLRndr/KB9LOTIfyaTJcxEg99OoqXLa7/UYUFq4D+WWH5PKdfA9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669369356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YRPnORy9ghMlm6bMW/HwcUwyjymDsPNQMAZfp8edSwQ=;
        b=aOgtf8G3edUAW1Cck5MZRgQ59BPlTwOuv3ivk8Kpr+kxjGuNcNbctEdgLnkUFO/bZEFtB0
        E8HOzt8tIxDk2VAg==
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Roland Mainz <roland.mainz@nrubsig.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/3] x86: Provide a vdso for getcpu on x86-32.
Date:   Fri, 25 Nov 2022 10:42:13 +0100
Message-Id: <20221125094216.3663444-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This tiny series provides getcpu in vdso on x86-32. Due to the setup
RDTSCP now also returns CPU and node information like x86-64 does.

The usage of RDTSCP + vdso has been tested in a VM with 64bit kernel and
32bit binary and a 32bit kernel.

Sebastian


