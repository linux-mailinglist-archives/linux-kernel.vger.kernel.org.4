Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE9F611BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJ1Umr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJ1Umo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:42:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D88239225
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:42:43 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e788329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e788:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1BBA61EC0754;
        Fri, 28 Oct 2022 22:42:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666989762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+RVEi1VYi+ffOLyo12+2h3C0BaSkYc0dax2gB/iWhUk=;
        b=djYUiE4OqoqJir9glxo5xBr4qz7pL6tUR3a7GZl/Dsi68IFHl887oACwcqdbpTpxOvhkIL
        RNC4GlnkN7ghy/BJMKIi50tGBHDwOGYvqhB7RQF110sA1bP37eDkps403Vt3wcfIGxphN/
        IUMayqWqdlQN93iw8mAICXtfkg9mXlA=
Date:   Fri, 28 Oct 2022 22:42:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] x86/microcode: Drop struct ucode_cpu_info.valid
Message-ID: <Y1w+vbjIlrKowVXG@zn.tnic>
References: <20221028142638.28498-1-bp@alien8.de>
 <20221028142638.28498-6-bp@alien8.de>
 <Y1wnZJyELDdeIZcZ@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1wnZJyELDdeIZcZ@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 12:03:00PM -0700, Ashok Raj wrote:
> Reviewed and Tested this series. Everything looks good.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
