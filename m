Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8F36D2FCC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 13:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjDALDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 07:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDALDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 07:03:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4853A527C;
        Sat,  1 Apr 2023 04:03:30 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC13F1EC058A;
        Sat,  1 Apr 2023 13:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680347008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bu3McgVP/d3Ju81gjVcESMOT0g3qbxvhWxkFxSUF5Ss=;
        b=f8P/ctORe1URi+fT+anKUsiELY4s+CJ6tblWx8Vdm9UfkzhIj48RtZjW/lCaEJZ/rI3UQw
        1Ucvll9iZE+1k266Rbk3xI9QV+KZHz5LNxYSaZqz5zQo4V6aG9Kt0et8PzPPoS7GPUFsaf
        FDjAeIDoab4MO5BhPQo05niVIh7CsiA=
Date:   Sat, 1 Apr 2023 13:03:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lyude Paul <lyude@redhat.com>
Cc:     linux-acpi@vger.kernel.org, Leo Duran <leo.duran@amd.com>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "x86/acpi/boot: Do not register processors that
 cannot be onlined for x2APIC"
Message-ID: <20230401110324.GAZCgPfG3Mk4Pp1VfP@fat_crate.local>
References: <20230331235328.4312-1-lyude@redhat.com>
 <c5e49ef29c50715f8fa5086fec999c0fa6d84dac.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5e49ef29c50715f8fa5086fec999c0fa6d84dac.camel@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 07:56:03PM -0400, Lyude Paul wrote:
> As well, hopefully it goes without saying but: I'm happy to try any kind of
> fixes

See if that branch fixes things for you:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/urgent

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
