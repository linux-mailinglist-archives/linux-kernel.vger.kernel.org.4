Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7544729DCD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbjFIPGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjFIPGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:06:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD74E2D6B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:06:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686323187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MosQMefhrKOUuw2s0mVZDUWakYUBZCBbY1BlwoG1YQI=;
        b=ZvGkZ8iqRvUtEmUevyclYg7iW/oDU9p4vN0AhUgeefL6N06/IchCRxNIaBsn7zNflKSMZV
        gyIezOp0p4+cwMS2vkWsfF0fUD+av99KVARbKM4Nj1Z9oU7N76u6kRTbep2BxHJ5mX3q1E
        BW44UR/BVzJg3f3YkzISNTjn85hs5sbbcyCe4bPepmkhqXkVXAFHMVWYNqhRSo/3+pdH6z
        sRuw4psFqQ+hXTtozFbFaexk1NQuMeerRKALm1Y140Brk7V25Sz2GQ/LvlkjrAXgGUVzSz
        oaXfY/B4tSTk/G80E6hqXD+qZcAgF2URIOKXrVXzVEyQ/sakP4Hph1JBhgq2Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686323187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MosQMefhrKOUuw2s0mVZDUWakYUBZCBbY1BlwoG1YQI=;
        b=PQF3QPawS1BMjtfTVgTOnSAmgH+h2eQ4gEn3BgPmooMSDND1h7uSwPWMMlevqLoq4FY97W
        NvkHTUmQ19WIbUDw==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH v2 1/4] x86: Introduce
 CONFIG_IA32_EMULATION_DEFAULT_DISABLED Kconfig option
In-Reply-To: <20230609111311.4110901-2-nik.borisov@suse.com>
References: <20230609111311.4110901-1-nik.borisov@suse.com>
 <20230609111311.4110901-2-nik.borisov@suse.com>
Date:   Fri, 09 Jun 2023 17:06:26 +0200
Message-ID: <87jzwcisjx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09 2023 at 14:13, Nikolay Borisov wrote:
> Distributions would like to reduce their attack surface as much as
> possible but at the same time they have to cater to a wide variety of
> legacy software. One such avenue where distros have to strike a balance
> is the support for 32bit syscalls on a 64bit kernel. Ideally
> distributions would have a way to set that policy in their kernel config
> files and at the same time users should also have the ability to
> override this decision. Introduce such mechanism in the face of
> CONFIG_IA32_EMULATION_DEFAULT_DISABLED compile time option, which
> defaults to 'N' i.e retains current behavio in case
> CONFIG_IA32_EMULATION is enabled. If, however, a distributor would like
> to change this policy they can do so via the newly introduced
> CONFIG_IA32_EMULATION_DEFAULT_DISABLED. As a final note allow users to
> override the decision via the ia32_mode boot time parameter.

Can you please stop rushing stuff out instead of sitting down first and
reading the documentation others have put together for reasons?

I gave you the pointers and I'm refusing to read and decode the
above. Here it is again:

 https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

It's not that hard, really.

Thanks,

        tglx
