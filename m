Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9B566086B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbjAFUpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbjAFUpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:45:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE70669BD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 12:45:30 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D36811EC02F2;
        Fri,  6 Jan 2023 21:45:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673037928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eYV8zDhpGymcSl64VHc8NEHhSI4QfjSkII09GWz28kA=;
        b=Y9UTH6LD331tb/ZtXpZBzRV0p2J01HmX5B11P9yxRcWvqQL/RZ6oTqe/VAyOn2UnILGzkP
        ZPidtn8JSrTw602Ytn9zBNUzFHdXjDQvQyCG8YhxKwmkeSGGUefBPSD8CzEGJE1wttM+sV
        9watab/4LiVCPRrIvAa7OBRJqGuAh6I=
Date:   Fri, 6 Jan 2023 21:45:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 3/6] x86/microcode: Display revisions only when update
 is successful
Message-ID: <Y7iIZHa0fuJkHHjz@zn.tnic>
References: <20230103180212.333496-1-ashok.raj@intel.com>
 <20230103180212.333496-4-ashok.raj@intel.com>
 <Y7XMtWqSrs0uGkD7@zn.tnic>
 <Y7h5qD43kdPeEgQ7@a4bf019067fa.jf.intel.com>
 <Y7h8dpIQHnL93RdC@zn.tnic>
 <Y7iEjDrXLRlwoz0W@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7iEjDrXLRlwoz0W@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 12:29:00PM -0800, Ashok Raj wrote:
> Yes, that makes sense, Do you think we can add a note that the loading
> failed? since the old -> new, new is coming from new microcode rev.

It has failed when

old == new.

I.e.,

	"microcode revision: 0x1a -> 0x1a"

when the current revision on the CPU is 0x1a.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
