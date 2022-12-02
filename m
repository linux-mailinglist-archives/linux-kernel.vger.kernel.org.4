Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC306640E28
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiLBTDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbiLBTCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:02:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0E763176
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:02:49 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670007767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wiinZLQsMm7cPQ4OHfu86VbHWO1wwyyMv4soIt0lx/g=;
        b=Ts4+587P8pW+Tf7vvDwy0bmSAepoh/90fwwjZtZT34AG1uyt/ZhxmR7YV8UKyPWm7vpi+o
        w2dV2bRTHq4JhZx1E2DifaT734ASBoMMinc17Xtc5JOjXK1os2xmLdFRG3ymq6haT0iyj2
        KWzCQAf9WEEmis6LbsmgUfDKhMtusXV/V9KQ2KUJyJ7l1YGPFDmLWt23PtgAKTyStAdMf6
        UqUY7g1mJsCmWcEsn0RD28wPEoTjcpihYMC4lK4QVzu6TOuZoIiX4I81PJZtP3EPsMlDCN
        0P0W/VDNXuMZBd9RL3dUkLaNIjk+5s/QaTk1vWRCvYsY/1jSSIKN1rRCU3aoDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670007767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wiinZLQsMm7cPQ4OHfu86VbHWO1wwyyMv4soIt0lx/g=;
        b=bt2q6A8Z8xzCTRLP84+fnHsDIPu/Mwk91vnE9aT1ftyXVTSzwuUqqJ/smilkbxyprSlJBh
        JB5bQ/lyZ/UAiHAQ==
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: Re: [Patch V1 3/7] x86/microcode/core: Move microcode_check() to
 cpu/microcode/core.c
In-Reply-To: <20221129210832.107850-4-ashok.raj@intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-4-ashok.raj@intel.com>
Date:   Fri, 02 Dec 2022 20:02:47 +0100
Message-ID: <877cz9pr1k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29 2022 at 13:08, Ashok Raj wrote:

> microcode_check() is only called from microcode/core.c. Move it and make
> it static to prepare for upcoming fix of false negative when checking CPU
> features after a microcode update. Also move get_cpu_cap() to processor.h
> for general use outside of kernel/cpu.h
>
> No functional change.
>
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
