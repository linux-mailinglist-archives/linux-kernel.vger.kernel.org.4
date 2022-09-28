Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2435EE1FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiI1Qjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiI1Qjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:39:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA436101E7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:39:35 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ee329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ee:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D4441EC058B;
        Wed, 28 Sep 2022 18:39:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664383174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=U0T8poAiUhpJC4gqL7M9xRcvJAMONfU1pvzFe2Yg4b8=;
        b=IaRofyiUD3AvVceqV3qQ+fznUI78NT4nzg25pR3wS2PP2oLISMEoeE8whqRsM0+Hj4Sour
        I7xVvHjDlxRnDCo/pJuBMB7KPsJWrm6c70nxqqGmGmmHzxLRcQ8cIh/ylZszMcG7XiyxZq
        2jZwzLJ8dPGSXJ1vr5MetVkLcL4TlvA=
Date:   Wed, 28 Sep 2022 18:39:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
Message-ID: <YzR4xvU+AQtPbLp2@zn.tnic>
References: <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com>
 <YzOEYsqM0UEsiFuS@zn.tnic>
 <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
 <24088a15-50a1-f818-8c3e-6010925bffbf@suse.com>
 <YzQmeh50ne8dyR2P@zn.tnic>
 <f8da6988-afa3-1e85-b47d-d91fc4113803@suse.com>
 <YzQui+rOGrM6otzp@zn.tnic>
 <c67d3887-498b-6e4d-857d-1cef7835421d@suse.com>
 <YzRyaLRqWd6YSgeJ@zn.tnic>
 <6d37c273-423c-fdce-c140-e5b90d723b9e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d37c273-423c-fdce-c140-e5b90d723b9e@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 06:32:20PM +0200, Juergen Gross wrote:
> I can do that.

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
