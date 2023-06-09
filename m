Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAB372A149
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjFIRdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjFIRdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:33:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFCE359D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:33:51 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9BE2C1EC0373;
        Fri,  9 Jun 2023 19:33:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686332029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OdWJ+/Vr1fTAQRkbbOS3uzE6dIIYarROw6+NLdTQjLw=;
        b=pMNWRTdN1rEyrdPbTaVhOCNw4/RmiWEQsncCJ3u72Nq+pR+DXoiotjXac1hHSyeLS3EwfQ
        hnw5w3ozlljIA95EJJ+FdVHyvA/W2NZUhPzbtD494BmBrKi9bPo5G4W5J1+r8eOlEJF0EW
        gwVdSEewIitd9lg0WNsF6XmlP9yN6eg=
Date:   Fri, 9 Jun 2023 19:33:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Breno Leitao <leitao@debian.org>
Cc:     tglx@linutronix.de, pawan.kumar.gupta@linux.intel.com,
        paul@paul-moore.com, leit@meta.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Message-ID: <20230609173343.GDZINid4EgJGnkW7HK@fat_crate.local>
References: <20230203120615.1121272-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230203120615.1121272-1-leitao@debian.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 04:06:15AM -0800, Breno Leitao wrote:
> Right now it is not possible to disable CPU vulnerabilities mitigations
> at build time. Mitigation needs to be disabled passing kernel
> parameters, such as 'mitigations=off'.
> 
> Create a new config option (CONFIG_CPU_MITIGATIONS_DEFAULT_OFF) that
> sets the global variable `cpu_mitigations` to OFF, instead of AUTO. This
> allows the creation of kernel binaries that boots with the CPU
> mitigations turned off by default, and does not require dealing kernel
> parameters.

What's the real-life use case for this?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
