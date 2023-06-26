Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861E573EC94
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjFZVGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjFZVG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:06:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700B51702
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 14:06:23 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7FF941EC05F5;
        Mon, 26 Jun 2023 23:06:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687813581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=H8dhR+wQ8ZURtazPgaPGq+sYEkXBO7joIGGGtlKT1Fo=;
        b=XY7Ak1+hy3O7LoP1uvehgsbKsZfMnNLrpnkZfub3VFTc2vr7ZD56j9qvuwwAUaQTfd7Oez
        UypapoV8K0NwlGu5EFKSVH65gQqxiuarrAq0d/jRGHJXub7rDPZCTTcGfK3sd871dm1OvD
        Y+w8T9ehuZpa6uTOJoM1DVx3Ewtdeq8=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HvkGc9CPflG2; Mon, 26 Jun 2023 21:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687813577; bh=H8dhR+wQ8ZURtazPgaPGq+sYEkXBO7joIGGGtlKT1Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dr6eLBXS5H8fuerdFqJhhjFIQQYgROfLbk61EY9Re5N1eUAW6KP3MKrEgvKg9ZjCj
         P8MUWyhvyD6NAHOIjP/e34KYNexdU7/0CJ1GDysNTtyAVgrcOp94o9121G59P8ep19
         DwJCuqfAofjrKWOKe2Kn6x9KF37ev8kJ4c1As2JFBzpQ8zBGsbj6oxreWbbr1PsfkA
         ENxGWCmEs/2PpwF5AH3WIzFtP/qX7sieMwfao8pr8Zt9X77+BZvxNwPhjoHrnM17+j
         KUBHpDSojWN3rzzJoteJl1dTql7pwgB5ugBmNpFYU251xUPgu7vWHC7YMhaT4PnQ01
         bQxbKg8/dBEG1frP+eJ3P1Ud0YjCD57+us9mwLw2s3Lwy3bm3mG8FjXDkLlbUJ98Ku
         DKX/paKROxbNGGx5XEpHNK76HY6hyLAvEu3yAZ0nJ/qtnU0BF9dOpcnfOccujgjC6l
         DHJZ7+Xa9slAVZfm4ln5jBbYk+fZ/t0DZR/R0NUGX1mz+ebRC4Sx4SR9RT+bPqXlLm
         bpaiqu508UcY5EWn1FP0HMOwaLJ0F4wLf18bD7Pdwx0vjs0NoZfn2PBzWcyrFgyXdf
         2mEiATndwy90J4apWjUqAo8lXhbJQglC3G9Os+a0TK9WZXKBagtI54Q0vCviydeCcy
         SrgdGXdC8EAikF/KQ55q+RKs=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5F3B40E01E1;
        Mon, 26 Jun 2023 21:06:11 +0000 (UTC)
Date:   Mon, 26 Jun 2023 23:06:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Sumpf <Sebastian.Sumpf@genode-labs.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Bug report] __arch_hweight32/64 x86
Message-ID: <20230626210604.GLZJn9vA3gcMAuy/eP@fat_crate.local>
References: <cb18590f-686e-cc53-7781-1a36e91faade@genode-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb18590f-686e-cc53-7781-1a36e91faade@genode-labs.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jun 26, 2023 at 10:49:44PM +0200, Sebastian Sumpf wrote:
> The 'ALTERNATIVE' macro checks for the popcnt feature. In case this fails
> the '__sw_hweight' C-function is called from inline assembly with rax and
> rdi as intput/output operands. However, the code does not contain a clobber
> list of any callee safe registers that might be touched by the
> '__sw_height64' C-function.

Which registers are those? Can you be more specific?

> Therefore, these registers will not be restored
> upon function return by the compiler. This leads to varying
> exceptions/bad behavior caused by the thus corrupted registers later
> on.

How do I reproduce what you're observing so that I can take a look?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
