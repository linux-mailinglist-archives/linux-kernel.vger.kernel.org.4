Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094356361F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbiKWOil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbiKWOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:38:38 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E0A23153
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:38:34 -0800 (PST)
Received: from zn.tnic (p200300ea9733e747329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e747:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 32F401EC042F;
        Wed, 23 Nov 2022 15:38:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669214313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FWy633/Out+wFobrK5ythjk56/89bduPUyX3iYNeueU=;
        b=sOrybi0HphDqYln5SN8rqI2hSG37+veXgMa2hMho5BoeUMocZhJNuplZou3kQxsfOo07et
        a873P1r5nW/a34CJlGsNXXr0gt8QFV8Vr3V8k/Lcv6jTDHJoRNzNhrQ/1B41JoHHdDqTzd
        XaqJQhYsPVj61nAl5eTgmjLblGNnz1Q=
Date:   Wed, 23 Nov 2022 15:38:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, nicolas@fjasle.eu, masahiroy@kernel.org,
        kirill.shutemov@linux.intel.com, tony.luck@intel.com,
        michael.roth@amd.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Avoid relocation information in final vmlinux
Message-ID: <Y34wZF2tute+pyKk@zn.tnic>
References: <20220927084632.14531-1-petr.pavlu@suse.com>
 <Y34SXeU6JEk+UGfV@zn.tnic>
 <Y34gw8tCCZgjBwUM@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y34gw8tCCZgjBwUM@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 08:31:47PM +0700, Bagas Sanjaya wrote:
> Why do you say "tautologically useless"?

Do you want a hint and think about it a bit or should I tell you
directly what this means?

> I think even Documentation/process/submitting-patches.rst doesn't
> describe why.

Execute the grep command above and read the text around the results.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
