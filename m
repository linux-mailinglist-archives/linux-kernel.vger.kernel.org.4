Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5443663C3B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiK2P1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiK2P1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:27:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6738657B77
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:27:27 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A36411EC04AD;
        Tue, 29 Nov 2022 16:27:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669735645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=t+ZONMhaFZvSAYnqD1SJ+MXmlhVksM7tm5OKazFq+Pg=;
        b=Gu8Ro/6m8bwCpcOuIqQ4IA2KWwA7MnQkyWhuurtsmrh9FA3j1OG+yGAQpkWx6VZ0KBTkVq
        H6dHC83EGn9YufRooewcw9D2QZYQU/G01rS3sAHaoKrswYTxGNGjBUEem3+5zv6LgDIIT4
        1bqMKoYLZIwwUlXk7eiSe1zQqhHG2eQ=
Date:   Tue, 29 Nov 2022 16:27:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/boot: Remove x86_32 PIC using ebx workaround
Message-ID: <Y4Yk3bdLkwTlfTMm@zn.tnic>
References: <20221104124546.196077-1-ubizjak@gmail.com>
 <Y4U0GwlLgAuxu3WF@zn.tnic>
 <CAFULd4Yjp+sNqZrt9kq2orodNckQOWAGi84ZZeXRFPLyE65HPQ@mail.gmail.com>
 <Y4XDVbuYtFUYCrur@zn.tnic>
 <CAFULd4Yv9ZYu_mWwFBGheJ7_XsP6Ok1uCCPDr-ChDK4yzOK3qA@mail.gmail.com>
 <Y4YbQHKbl1BVZKMX@zn.tnic>
 <CAFULd4bkvBAELPLALrKFV=wX4pNzWPwCg9dQ_C_WJZ2H1cbPMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4bkvBAELPLALrKFV=wX4pNzWPwCg9dQ_C_WJZ2H1cbPMw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 03:56:37PM +0100, Uros Bizjak wrote:
> Please say gcc 5.1 here.

Done.

> Otherwise a really comprehensive and detailed explanation of the issue!

Thanks.

Lemme run it through the build tests just in case.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
