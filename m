Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AC561222A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 12:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJ2KIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 06:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJ2KIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 06:08:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584578276D;
        Sat, 29 Oct 2022 03:08:01 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e788329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e788:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DFC6B1EC066E;
        Sat, 29 Oct 2022 12:07:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667038079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LdgXe0XOFV6nR/ec3XDOyNjpHQv0Xc0RBQ1ofiWsYsM=;
        b=JSZHXpKgYBfRFHr+K7dnpKmjA2cPz7cQvMs71C8DZ/dRxK+r+UTK9ZoaErp/+dHmNZAR9i
        qVELRRJ32YUzlwf7noReAQg1OwXYOKlESljcI/3+Rtn61UstzLft77YFx2EjIQFBCOxcGq
        QQnHh6qfD4aBcEi/aHZPwW1lPFOUWSw=
Date:   Sat, 29 Oct 2022 12:07:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4 12/16] x86/mtrr: add a stop_machine() handler calling
 only cache_cpu_init()
Message-ID: <Y1z7emwUvMt71C/0@zn.tnic>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-13-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221004081023.32402-13-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:10:19AM +0200, Juergen Gross wrote:
> +void cache_ap_init(void)
> +{
> +	if (!memory_caching_control || cache_aps_delayed_init)
> +		return;
> +
> +	/*
> +	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
> +	 * changed, but this routine will be called in cpu boot time,

In all new text you're adding

s/mtrr/MTRR/g
s/cpu/CPU/g

so that it is all consistent.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
