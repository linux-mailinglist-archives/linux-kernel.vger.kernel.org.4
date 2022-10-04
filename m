Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF66B5F4584
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJDOcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJDOcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:32:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFA54F670
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:32:51 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e751329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e751:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B8081EC052A;
        Tue,  4 Oct 2022 16:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664893965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=N6NZl+IfsMzX/D4xjKp4HwnOGS6u7wWW8UFOVj5u44I=;
        b=fY/VXKhcbHsJB3rIHuo10TSAB/tYD10lTSW5OB5BG8UgLXv11luuWxdxvZ984QP1nonK5e
        G4n21yl9rLoHsyEOZRpLimBz18GrGUOfx5abJRwujoWOQsZ2/27MjvB9ywcjjKVlzsjtpT
        xovVxp1FwaKOQFRO/ixQosgteubbeJA=
Date:   Tue, 4 Oct 2022 16:32:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/paravirt for 6.1
Message-ID: <YzxEDcM+ggv1dtuJ@zn.tnic>
References: <Yzw/1M8lEiLriU57@zn.tnic>
 <9654aa58-2e1b-88b0-0165-fff39ba7b953@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9654aa58-2e1b-88b0-0165-fff39ba7b953@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 04:24:18PM +0200, Juergen Gross wrote:
> Hmm, any reason why
> 
> https://lore.kernel.org/lkml/20220903073706.3193746-1-keescook@chromium.org/
> 
> isn't part of that pull request?

It has gone under in the flood.

/me makes a note to queue it for the next one.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
