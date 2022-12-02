Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D541640E80
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiLBTbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbiLBTa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:30:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22DFF37C5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:30:55 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670009453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCKfAiGOM99kKkMFBlzwlE8YZKjEC+FyFVD7UYu0Jdc=;
        b=gbEgpEzqFJdwvq4YKLSb1Y/JYaSHAeakf6EnPEtiG72BxQVrG8uxxsjM3jvFtDa42OxTV1
        KX9iwy1lVtEIu8m8sE/3vbLF7TpJsqyhBulcw4HQOo4eS9837A1QyxaJb4BZ2FsIXN0zxj
        bQ/klIFEllQ0hfl/ojMpaZ01X44bk+vdY3/HPom1KMIq1dCKrha7l4LYeEEDduEnmG/zIK
        cWjwP9aRes7FK5fWkHib4z2tKPlm+boKCbK709FaeDWZWCCeu1885pV3IhqpTIBaqNHQMO
        Waix3mUIZ80u0e8mJYaYbp/aMDJy9YFM3AVsSz0KaeNwP5VEaWdbhR9AeLEYlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670009453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCKfAiGOM99kKkMFBlzwlE8YZKjEC+FyFVD7UYu0Jdc=;
        b=HUfWrZKzafF22KibTLFNa9fpZtXTyl9hSW3UMXGNXq4xdNw2jpsMaxoYkbM9yRyL+WQI0h
        CNN484eKe9W3ObAw==
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: Re: [Patch V1 7/7] x86/microcode/intel: Print when early microcode
 loading fails
In-Reply-To: <20221129210832.107850-8-ashok.raj@intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-8-ashok.raj@intel.com>
Date:   Fri, 02 Dec 2022 20:30:52 +0100
Message-ID: <87v8mtob6b.ffs@tglx>
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

> Currently when early microcode loading fails there is no way for user to

the user

> know that the update failed.
>
> Store the failed status and pass it to print_ucode_info() to let early
> loading failures to captured in console log.

so that early loading failures are captured in dmesg.

Hmm?


