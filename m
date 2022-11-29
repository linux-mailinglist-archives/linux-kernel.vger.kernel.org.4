Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE4163BBB6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiK2Idw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiK2IdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:33:14 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D66959FFA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:32:22 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 816371EC04AD;
        Tue, 29 Nov 2022 09:32:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669710741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0nLTXwaK1HblUplTljGmVEVIKtDAFHIUusQIO4fyuJA=;
        b=i76OReNvp1WKlzeL8kh7azDYAOwoZOsYwB3oHGPlH2e5RGy4bpWZVrqJLqtiL24rJsZaPm
        HJxP4diz2epaRh3fr5h/xAZW+jAsUwyBFMCmx/mPjVgDVqkRDVY7GOXh68wTzPGVdMDmbW
        z+kuXlo0BHalzaHdWAWKOLaAC9i2LD4=
Date:   Tue, 29 Nov 2022 09:32:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/boot: Remove x86_32 PIC using ebx workaround
Message-ID: <Y4XDlWc+2OvmW7kS@zn.tnic>
References: <20221104124546.196077-1-ubizjak@gmail.com>
 <Y4U0GwlLgAuxu3WF@zn.tnic>
 <CAMzpN2jY+m5amE-6JB_eYswG2tx1aT6U3EBdYEtc-KdXSHec0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMzpN2jY+m5amE-6JB_eYswG2tx1aT6U3EBdYEtc-KdXSHec0A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:41:11PM -0500, Brian Gerst wrote:
> x86-64 uses a PIC register for the medium and large PIC code models,
> where offsets can be larger than +/- 2GB.

Right but 64-bit is built with -mcmodel=kernel which obviously generates
rip-relative.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
