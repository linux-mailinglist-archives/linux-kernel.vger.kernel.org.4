Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B08268F807
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjBHT31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBHT3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:29:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBFB5279
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:29:21 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 01A3F1EC06BD;
        Wed,  8 Feb 2023 20:29:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675884560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nLM4qtX0yCjmERrHtMiR446ydlKOCyVFC14dlTvVrwc=;
        b=ItILcJ5PicfnLvT4pD/oKioHrnZA8FhB0CYBSfeE5UqJy1uaElJDmaL5h6UzT9MBxbv6H5
        nzQ0rAUiJ65247g+wTtelzGLqGm5S4FVYCkSlceMO6rMqUUw+A8g2PZieCvu7q3uVbjPaa
        PwB5SNFNZJMpwhpGG0t+PKsHtwBKixM=
Date:   Wed, 8 Feb 2023 20:29:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
Subject: Re: [PATCH v13 1/4] virt/coco/sev-guest: Add throttling awareness
Message-ID: <Y+P4C4jtMWu2PanS@zn.tnic>
References: <20230124211455.2563674-1-dionnaglaze@google.com>
 <20230124211455.2563674-2-dionnaglaze@google.com>
 <Y9emVjoTBrM2+Y5P@zn.tnic>
 <e0d52194-d478-b33e-851b-d5067f4a7669@amd.com>
 <CAAH4kHbXKnWyO5hS19q74jDQjvAvj6rUw_Q06Of1+Fmng50-7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAH4kHbXKnWyO5hS19q74jDQjvAvj6rUw_Q06Of1+Fmng50-7Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:24:46AM -0800, Dionna Amalie Glaze wrote:
> Hi y'all, checking in on this thread. Are we waiting for the new GHCB
> spec to be published before merging this fix?

Not really - I'm waiting for you to remove the potential endless loop:

https://lore.kernel.org/r/Y9emVjoTBrM2%2BY5P@zn.tnic

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
