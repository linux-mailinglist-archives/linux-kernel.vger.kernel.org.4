Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E0B66D0D0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 22:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjAPVR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 16:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjAPVRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:17:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B1C3A9D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 13:17:23 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D4D81EC0441;
        Mon, 16 Jan 2023 22:17:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673903841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PQ938W+6/tR4evQ10T93yFK2BtLD6rWC6N20aJDW2DA=;
        b=CeaWrDCr2rATBINlKGZT5nc1kIuIbhmD2ANfeaHw9kP2HdIc0cMt+EYhtc4tNkujc0Zoe7
        JS1AUvaPldcy40aHr3AwmYKJKD2RU/SIcIGfngJs4tQ/lnIlbKBfre2T7UNRcNYtEQU+sk
        mr+dhm85V+Q0v7+yeh/JkVVWGX5oT+U=
Date:   Mon, 16 Jan 2023 22:17:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Daniel Verkamp <dverkamp@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86: also disable FSRM if ERMS is disabled
Message-ID: <Y8W+22DNTylUTo25@zn.tnic>
References: <20220923005827.1533380-1-dverkamp@chromium.org>
 <Yy2U2BW6Tx0imGpK@zn.tnic>
 <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
 <Yy3yJfz213Lqo4KC@zn.tnic>
 <CABVzXAkO4pU+gpUcWOEWDw+W4id=1WEOgeP5+3tBG_LR6=oa=g@mail.gmail.com>
 <1b184587-128d-e5cc-67e9-1d27feb87213@kernel.org>
 <Y7VlZsaWz4/b6Phf@zn.tnic>
 <b0b18b83-0b6b-ea89-b701-0375b8302d1e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0b18b83-0b6b-ea89-b701-0375b8302d1e@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 06:26:50AM +0100, Jiri Slaby wrote:
> Just so you know (I see you progressed with Ingo to fix this) -- despite I
> asked the very same question, I received no answer quite yet. I suppose it
> will sound like usual "because we can".

Yah, tell them it is totally useless to disable ERMS on an AMD system. Just
leave the both settings on.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
