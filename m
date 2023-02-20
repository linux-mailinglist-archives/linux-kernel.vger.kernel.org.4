Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D31569D407
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjBTTUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjBTTUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:20:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4411286B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:20:46 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 028471EC04DA;
        Mon, 20 Feb 2023 20:20:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676920845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5Q9htt2FScRK2Padeb0fDI2W5lo6XN2QsQTinSxh1I8=;
        b=ZmPYq/DDbgj4DMWYBXGJ5pXVpF40/pidorLOojp/Wchsp0KPtW+QH17EUV+D9NHW1AoZ/c
        X2AXk/OAKTe/8Zzj+KmqGoj++7sO5QCnCELsk7QzrRxPJyWHQhIc4+aCYv+Ql/6vWOt94y
        zz6uFVyaH8yTK1j3dbuD4UFlEugSpPE=
Date:   Mon, 20 Feb 2023 20:20:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        pjt@google.com, evn@google.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        =?utf-8?B?Sm9zw6k=?= Oliveira <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] x86/bugs: Allow STIBP with IBRS
Message-ID: <Y/PICc9IU5CWpfyQ@zn.tnic>
References: <20230220121350.aidsipw3kd4rsyss@treble>
 <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <20230220163442.7fmaeef3oqci4ee3@treble>
 <Y/Ox3MJZF1Yb7b6y@zn.tnic>
 <20230220175929.2laflfb2met6y3kc@treble>
 <CACYkzJ71xqzY6-wL+YShcL+d6ugzcdFHr6tbYWWE_ep52+RBZQ@mail.gmail.com>
 <20230220182717.uzrym2gtavlbjbxo@treble>
 <Y/O9U4KFtXE8Yoyt@zn.tnic>
 <20230220190908.gfd2c4tuzeb7cft6@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230220190908.gfd2c4tuzeb7cft6@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:09:08AM -0800, Josh Poimboeuf wrote:
> No it was supposed to be "no STIBP with *eIBRS*".

Ok, good.

> As far as I can tell, that document was never updated to describe
> spectre_v2=ibrs in the first place.  That would be a whole 'nother patch
> which I'm not volunteering for.  Nice try ;-)

What do you think the maintainers are for? To clean up after
people... ;-\

As a matter of fact, updating the documentation is already on my
ever-growing TODO list.

But for this patch I'd like to ask whoever of you does it, to add a one
or two sentences about why we need to allow STIBP selection with IBRS.

The rest of the documentation we'll flesh out in time.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
