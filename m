Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E836CAFF7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjC0U01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjC0U0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:26:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D254695;
        Mon, 27 Mar 2023 13:25:52 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BAE821EC047F;
        Mon, 27 Mar 2023 22:25:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679948750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=03vRJu2Te4JV8IFmpe4rMtj2AeH8XydMEh3ymGIFquQ=;
        b=TLgBwQHeEAb1Bg6iQqEn9hjVC8VYS69bXSuV7dvCe1geUAz2TSFg2XGwqR3j5C9pxvrAmN
        5nD02OvNCSMgyb1vp/bsYQy9gi58FzKgbg2adkMZLdNh95GlMAHkcbi74AJwRPl+BAsj9x
        ByCkWctuKf14hJ+1DVWmd4Uc6YIUD+w=
Date:   Mon, 27 Mar 2023 22:25:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     mario.limonciello@amd.com, rafael@kernel.org, lenb@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvijayab@amd.com,
        miguel.luis@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH 1/1] x86/acpi: acpi_is_processor_usable() dropping
 possible cpus
Message-ID: <20230327202545.GEZCH7yUqcsddJx7Y5@fat_crate.local>
References: <20230327191026.3454-1-eric.devolder@oracle.com>
 <20230327191026.3454-2-eric.devolder@oracle.com>
 <20230327195737.GDZCH1MWNvFQrXdY9M@fat_crate.local>
 <a4efd5cd-cab1-b204-1395-670495bc33cd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4efd5cd-cab1-b204-1395-670495bc33cd@oracle.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 03:07:23PM -0500, Eric DeVolder wrote:
> https://ueif.org/sites/default/files/resources/ACPI_6_3_May16.pdf
> Section 5.2.12 MADT. Table 5-43 is the MADT Revision is numbered 5.
> However, ACPI 6.x specs got a little "sloppy" with Revision,

Yes, I've found what you're pointing out too. But exactly because of
this sloppiness I'd like to see this more explicitly. Because we're
basing functionality off of it and it is not some meaningless
paperweight anymore.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
