Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ABA68B8EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjBFJsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjBFJsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:48:35 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E58E1CADB;
        Mon,  6 Feb 2023 01:48:34 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D899A1EC0644;
        Mon,  6 Feb 2023 10:48:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675676912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y6Wwgj0YQwUC9Lhf7cph/BhE4W+1skWBO4ABwc0Insc=;
        b=KDs7gi684yFJmJ7YiJX9cfBmQBudPAeXm/qUUgelf2d3Xxhu04LwxjBLTESOiKMKvrmMNw
        Fp08vZjFbU7jTVJanOktTVoitMNvRqeYko7r3jGok+nL5AMbG6xeHbJv/MSXqqYLt1y2rP
        cvj23pJvgq6n+4Zah5n6NCqb3x0Q4pY=
Date:   Mon, 6 Feb 2023 10:48:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     silviazhaooc <silviazhao-oc@zhaoxin.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        cobechen@zhaoxin.com, louisqi@zhaoxin.com, silviazhao@zhaoxin.com,
        tonywwang@zhaoxin.com, kevinbrace@gmx.com,
        8vvbbqzo567a@nospam.xutrox.com
Subject: Re: [PATCH] x86/perf/zhaoxin: Add stepping check for ZX-C
Message-ID: <Y+DM8BZUi6a10hXY@zn.tnic>
References: <20230202091738.5947-1-silviazhao-oc@zhaoxin.com>
 <Y95hWVFyw7TM1WSB@zn.tnic>
 <51ab21ee-403b-f4ce-9a7e-2580ab7e8118@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51ab21ee-403b-f4ce-9a7e-2580ab7e8118@zhaoxin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 04:26:25PM +0800, silviazhaooc wrote:
> Due to our company’s email policy, email address with oc suffix is used for
> sending email without confidentiality statement at the end of the mail body.
> 
> I will remove –oc from my name later.

Yes, please. The email address is fine but the name doesn't have to have
that funky "-oc" thing.

> But due to some unknown historical reasons, the FMS of Nano and ZXC are only
> different in stepping.
> 
> I have considered about using the “Model name string” to distinguish them,
> but it doesn't seem to be a common way in Linux kernel.

I don't mind you using steppings to differentiate the two as long as
this is not going to change all of a sudden and that differentiation is
unambiguous.

If not, you will have to use name strings as you don't have any other
choice.

Whatever you do, pls define a new X86_BUG_ flag, set it only on Nano and
then test it in the PMU init code.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
