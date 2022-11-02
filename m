Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753476168AE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiKBQY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiKBQYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:24:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34BD2BC2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:19:36 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e741329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e741:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD8E31EC0430;
        Wed,  2 Nov 2022 17:19:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667405974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ctUPJdjla8y29oW3B4+64W0bgt4QgTUA8v3ryUYFh58=;
        b=raQPPbXwbL++XjPLIB8DJMN+f7mS8nnBI85D0ffQI+JnDLoc3LhNFhusdnLQtLteURbh4q
        L2AUcwrA4NOKA4drUUX6sy6gz9Uz/ix/h/NZbOLz6Ta9QDs7eDECN+oYcILOXu86Pjy3lI
        FfQWy+jf3LQ+qDBUpdP4y1zRasvoyVQ=
Date:   Wed, 2 Nov 2022 17:19:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v13 7/7] x86/crash: add x86 crash hotplug support
Message-ID: <Y2KYls/Ji5E+4kPP@zn.tnic>
References: <20221031193604.28779-1-eric.devolder@oracle.com>
 <20221031193604.28779-8-eric.devolder@oracle.com>
 <Y2A4TqyOaPYBu4Hk@zn.tnic>
 <1c11a429-b5a9-fb55-fbef-b49e760e2d1e@oracle.com>
 <Y2I3zQ9ZU+C9Kgf7@zn.tnic>
 <06ef6e4b-1f42-d50f-1328-4f82fb34dd4d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06ef6e4b-1f42-d50f-1328-4f82fb34dd4d@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:55:06AM -0500, Eric DeVolder wrote:
> > "But on a plain simple laptop or workstation which has CPU hotplug,
> > would it make sense for the crash ranges to get updated too when CPUs
> > are offlined?
> 
> Yes, it does.

Why?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
