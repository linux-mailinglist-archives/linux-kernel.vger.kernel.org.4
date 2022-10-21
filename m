Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7681607407
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJUJ2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJUJ2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:28:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE9818E2A9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:28:16 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e769329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e769:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 578451EC0731;
        Fri, 21 Oct 2022 11:28:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666344491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BSBbLmDiHwfDe3P/3k+TpQfT8qF0FedX0oof9Wcog5U=;
        b=iLyfW0N9PmAZzZgX9Ir9EQhQ6aUAxTuEpNVD22T+bMA+2jMr/0lSY8OY48+x03jQ3xf7BA
        o0vVSzF3FJpZ2vz9CBYppg+m8yxaCnP4sJ6CO1B1ohbvsdNHCWdFbShzS7OUg/YpDXTTgc
        sOzAGI6KpbznYwhlt/I4bsOP/GV7jzI=
Date:   Fri, 21 Oct 2022 11:28:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] x86/microcode: Simplify init path even more
Message-ID: <Y1Jl0tojpBzY2y/8@zn.tnic>
References: <Y1A5YHzmzab8LrYD@zn.tnic>
 <20221019175426.31025-1-bp@alien8.de>
 <20221019175426.31025-2-bp@alien8.de>
 <Y1BOkbXsQxCZK3U7@a4bf019067fa.jf.intel.com>
 <Y1BSF8ck0RD9UpLd@zn.tnic>
 <Y1EEObR7keIDJtVJ@zn.tnic>
 <Y1FjlfVQupDc7q1r@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1FjlfVQupDc7q1r@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 08:04:53AM -0700, Ashok Raj wrote:
> - BIOS had version X
> - Early applied Y > X
> - I copied a new version Z > Y.

When exactly do you copy a new version?

Please write down the exact steps you're doing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
