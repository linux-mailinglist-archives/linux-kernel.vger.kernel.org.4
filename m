Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C811569B933
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 10:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBRJ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 04:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBRJ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 04:59:10 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F093668F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 01:59:09 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC3EC1EC0441;
        Sat, 18 Feb 2023 10:59:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676714346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZglzTESiS9A8XkNVXyyv8j8/CVxkduZKQYkUWsHE60o=;
        b=J1ATcOhjLCCqJyGrhXJq/SDnGgcaWHJxG7eYAR7mhCp8opiJjERZ/zzFBMnQQHlWOx15gD
        NPxhm+J4cH7FIdRCaTLKsiL5I27bBls/YLNfP1IlSGoAeajh/T745YBt9AVyv2/HM2t4is
        wMxVz3KOJw3DKebmkkLRmWt28e1oQr8=
Date:   Sat, 18 Feb 2023 10:59:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [tip: x86/urgent] x86/mtrr: Revert 90b926e68f50 ("x86/pat: Fix
 pat_x_mtrr_type() for MTRR disabled case")
Message-ID: <Y/ChZRB8F47xIgNl@zn.tnic>
References: <4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de>
 <167636735608.4906.4788207020350311572.tip-bot2@tip-bot2>
 <8a1fd8b7-9fe3-b2b5-406e-fa6f5e03e7c0@nerdbynature.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a1fd8b7-9fe3-b2b5-406e-fa6f5e03e7c0@nerdbynature.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 10:47:46AM +0100, Christian Kujau wrote:
> Sorry for being dense but I couldn't figure this out from the tip tree 
> handbook[0]: will this be included in 6.2 or has this ship sailed?

Yes, it will. Urgent branches go usually to Linus in the current
stabilization phase. If you wanna do a patch for the handbook to fix
that shortcoming, I'll take it.

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
