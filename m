Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BF1623F36
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiKJJ7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKJJ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:59:23 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CC1BF;
        Thu, 10 Nov 2022 01:59:22 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7bc329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7bc:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A5CA1EC0426;
        Thu, 10 Nov 2022 10:59:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668074361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7rIKh7p9PZZg3u0p5aishDuUwX6ZR9+4RaiTJGTci/Q=;
        b=A0q3/uBP6rWEjN/SC+fxr6au1tqZmZkGxOYBXIj6rMgJJuTsD8ZuFkFgg6A3meBrkVzqms
        FOMhhTGsFf1jmA2HTlH1DLjSkF35+lZeG3GsLzCJNvC+F+mab3M5Ru/3MjA8UVcXvLm1ju
        OVIggDJMl9P1SgXcypjMCAMJyhJZFUU=
Date:   Thu, 10 Nov 2022 10:59:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, thiago.macieira@intel.com,
        athenas.jimenez.gonzalez@intel.com, sohil.mehta@intel.com
Subject: Re: [PATCH v2 00/14] IFS multi test image support and misc changes
Message-ID: <Y2zLYDmO1fkOmFgw@zn.tnic>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221107225323.2733518-1-jithu.joseph@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 02:53:09PM -0800, Jithu Joseph wrote:
> Changes in v2
>  - Rebased ontop of v6.1-rc4
>  Boris
>    - Moved exported functions (microcode_sanity_check(),
>       find_matching_signature ) from microcode/intel.c to cpu/intel.c 
>       (patch4,6)
>    - Removed microcode metadata specific code changes to
>       microcode_sanity_check() (patch6)
>    - Moved find_meta_data() from common to IFS driver (Patch 8)

What's the upstreaming plan here - I'm assuming I should take the
microcode patches through the tip tree?

Or should I take the whole thing through tip so that there's no
confusion and having to sync and share branches between trees?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
