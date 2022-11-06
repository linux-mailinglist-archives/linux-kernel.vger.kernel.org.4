Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3765561E5B9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 20:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiKFTu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 14:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKFTu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 14:50:26 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485151057A;
        Sun,  6 Nov 2022 11:50:22 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7a5329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7a5:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9DE4E1EC042F;
        Sun,  6 Nov 2022 20:50:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667764220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HkiLqOglx1HtZ009J9iwZELgVsDoHi4C6AUa2XEVz/8=;
        b=Eto7gtgiUEE0J6Zo+lWaWF/t2VSh2RKRZSnXHRnwSdDkEX+UEOIDf/ffI+Nm/O+20VbTc7
        aCcfsOte1J66cftBRWBUWXeT83PsMXZQy1cIaMFIHTMrzs4+JhhT7pYmg1uSxlmJima+zq
        jNMR/sxEabFRKQakEsnLPidkeI0hW6o=
Date:   Sun, 6 Nov 2022 20:50:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/tdx: Prepare for using "INFO" call for a
 second purpose
Message-ID: <Y2gP+AT1XdapImV4@zn.tnic>
References: <166734513630.7716.12952231613533508782.tip-bot2@tip-bot2>
 <Y2esXPWwulendusf@zn.tnic>
 <d4614b70-b37b-44b8-6a9c-54d59a6f9fec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4614b70-b37b-44b8-6a9c-54d59a6f9fec@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 09:02:27AM -0800, Dave Hansen wrote:
> It's fine for now, except that the naming on this:
> 
> -	tdx_parse_tdinfo(&cc_mask);
> +	cc_mask = tdx_parse_tdinfo();
> 
> is a bit funky since tdx_parse_tdinfo() is doing a couple of things

Yeah, that was the next thing that was bothering me.

> and will need to return a second item shortly.

Well, then rename this one back to get_cc_mask() and have a new function
return the second item?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
