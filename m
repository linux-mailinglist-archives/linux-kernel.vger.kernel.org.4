Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954E1675EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjATU0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjATU0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:26:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AB73FF07
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:26:38 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B8211EC01B5;
        Fri, 20 Jan 2023 21:26:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674246397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jZ8OaYf/GRQ2TxOV4jZT6AQpjda327cLvF6ttVfQQ4M=;
        b=hY3Ue4LBiep4MKn0VfEK59kgm/TZU3IId3CkHJzgOPb2oe1rF413+UpKZyQsIjVBZB2msy
        bWKdxt58uFQKPOrYTy9O9GkcwBi00bTrasWZhTAnS0a9/FEbZyn4txvKuaEno0yjdo0TBL
        bmOudVDBdGPkTzoyY1zvwnydDd/qamM=
Date:   Fri, 20 Jan 2023 21:26:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 3/7] x86/power: De-paravirt restore_processor_state()
Message-ID: <Y8r4+V4Y42Y09WMw@zn.tnic>
References: <20230116142533.905102512@infradead.org>
 <20230116143645.708895882@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230116143645.708895882@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 03:25:36PM +0100, Peter Zijlstra wrote:
> Since Xen PV doesn't use restore_processor_state(), and we're going to
> have to avoid CALL/RET until at least GS is restored,

Drop the "we":

"..., and CALL/RET cannot happen before GS has been restored, ..."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
