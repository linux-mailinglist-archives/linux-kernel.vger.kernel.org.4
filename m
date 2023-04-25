Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04216EE975
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 23:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbjDYVP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 17:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjDYVPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 17:15:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62530121
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 14:15:24 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F30DC1EC056D;
        Tue, 25 Apr 2023 23:15:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682457323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Z997+Yu9xcoWlnG0qNuclHIT8oE9bxXY58H5PNO3TlY=;
        b=iH3tHueq/J4Fe9gLdYLnbG8h4CGkrqj1Nr2DL3qCcEX8Pt3MYAVIB6/4NnkjVIR3i1pumG
        ZusJVpjs8WwlxTbTsywL5By5sqfFggpuMzyuiGijx/jO1jMzw93qsKM97sFVCeuDVP3s1a
        Pc14ymHbYA/2fg47wG29XJpI1nRAVfg=
Date:   Tue, 25 Apr 2023 23:15:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH] x86/CPU/AMD: Rename the spectral chicken
Message-ID: <20230425211522.GGZEhC6nkdsOapSxVL@fat_crate.local>
References: <20230425195024.17808-1-bp@alien8.de>
 <20230425205944.GB1350354@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230425205944.GB1350354@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 10:59:44PM +0200, Peter Zijlstra wrote:
> This gets to be the spectral chicken forever more as punishment. Next
> time AMD can try again, and if they manage to get their act together and
> publish something before I get to write the code and invent a name for a
> magical bit, they get to name it how they like.

It is unlikely that you'll have to do that again.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
