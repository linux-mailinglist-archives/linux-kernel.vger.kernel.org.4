Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C576624A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjAILv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbjAILuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:50:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1181ADB2;
        Mon,  9 Jan 2023 03:50:03 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 04A401EC0681;
        Mon,  9 Jan 2023 12:50:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673265002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YIFTLOqg6/IeCDkwSQs6GtHXYPdUYB+ZWoStAzbZiTU=;
        b=D5G/bUYKgpjEd7bYtUSJJ8nTpW4p20dwoUQLVK/J7TI8/E+owyNzkizlMwRdkx/w5SZutE
        tx7YCtDYRpoIsHCLRK0pJ3fwQV1y9nqv6PyajJmiP31xsPqdT1kshQRl5g84wBliK2efbP
        D+IUEiZzsW3jfMuvQ2mPiQlIQTjYzf8=
Date:   Mon, 9 Jan 2023 12:49:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com,
        linux-toolchains ML <linux-toolchains@vger.kernel.org>,
        Michael Matz <matz@suse.de>
Subject: Re: [BUG Report] undefined reference to `convert_to_fxsr'
Message-ID: <Y7v/ZVTeQCw7Hv8g@zn.tnic>
References: <Y6w49Y1d3lpv3KFn@zn.tnic>
 <23e2907c-5188-5ac6-3db8-1c5a12120bf2@huawei.com>
 <Y62vbjBzHF4rmh1V@zn.tnic>
 <e041533c-4005-b9bc-3985-02224985aa28@huawei.com>
 <Y67IlthBqaX69RwN@zn.tnic>
 <64fe1be4-954f-fe6f-44f0-59b572548663@huawei.com>
 <Y7dZwWsiUfHKxN3S@zn.tnic>
 <d312c572-f232-a4e9-2ecc-023050528a29@huawei.com>
 <Y7lSZerjPghqllWp@zn.tnic>
 <08115444-73a3-b9b0-dbeb-2a0cf374290e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08115444-73a3-b9b0-dbeb-2a0cf374290e@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 09:48:50AM +0800, Miaohe Lin wrote:
> Oh, sorry, I miss-read that. My compiler is gcc-7.3.0 which contains many
> in-house codes from our company in it. That might matters. Thanks a lot for
> your guidance. :)

Yah, next time, before you report something like that, try to reproduce it with
an official compiler (gcc from the upstream repo, SUSE, Debian, RH-built etc).

If it doesn't reproduce, go complain to the folks who hack your in-house
compiler.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
