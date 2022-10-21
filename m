Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF049607E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJUSKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJUSKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:10:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472FD11CB77
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 11:10:44 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e769329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e769:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A04A91EC072E;
        Fri, 21 Oct 2022 20:10:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666375842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ylHRyq5/4KpO5TnQHHmVNpCuI4uMbpwXOF0FuS2ZL3k=;
        b=JwZzVyWi9DyKBQlsbuUaPItTfuG9821j+6TbazbC2nuXR20ByNzTRIKOsNotRSUsYn6a5i
        J8MO3huAXv31xaLR7yRwQY7sg9cQmwVjwJro1EpzTiwLqP/yYHVNww59Dsn8hGoq1SPqgk
        AOhNnCiZHg9BmWbPnivRDVVEMCSBKbY=
Date:   Fri, 21 Oct 2022 20:10:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 03/16] x86/mtrr: replace use_intel() with a local flag
Message-ID: <Y1LgnTFwACS7x/Mp@zn.tnic>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-4-jgross@suse.com>
 <Y1LUm1Vdu4u2Tp1c@zn.tnic>
 <7af80d1e-d658-5dee-32b3-a9976e900dc7@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7af80d1e-d658-5dee-32b3-a9976e900dc7@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 08:05:39PM +0200, Juergen Gross wrote:
> Please have a look at patch 10 (I've put it after the rework of
> mtrr_bp_init() exactly in order to avoid the dance you had to do).

/me goes and looks.

Yeah,

	if (mtrr_enabled())

seems more readable to me than

	if (mtrr_if)

but ok, changing that is easy.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
