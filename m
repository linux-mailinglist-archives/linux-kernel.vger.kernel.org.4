Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979247365C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjFTIJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjFTIJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:09:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4401D10D4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:09:31 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E11F1EC03C0;
        Tue, 20 Jun 2023 10:09:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687248569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2BsLbLBKCKD11yVfF9a6aqGZpwTBqw419MBlZgLt84o=;
        b=cXvDQGRhxymodi9LYew/kMSqZM+b7D4dBh+xdrqmocNHIrm0RhKk5DTlHUnz7s3bAhmk+9
        ibOtecitvUyCC+ma/Fn8ZokBfU6QY2KG7CC8H3wIuxP+5PuIlbHov2OuBD6RWHCYvoyzgk
        FprlJbz7dVQsfGRgiOiwmDHnei9MSWQ=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UopwDzRJabpM; Tue, 20 Jun 2023 08:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687248567; bh=2BsLbLBKCKD11yVfF9a6aqGZpwTBqw419MBlZgLt84o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KD9QTeD0SpuS9FnseMNmpOMndaztHqYhGixNYthjFCljVk9SpESy2TlvhDWZCiXQa
         IyJXIPQEudVGrGfj3Ai325HDkT//eSlyQEBPMMH4fVKFmK+uajctbmIrN0BTU1dpv7
         0uEJTundN0k5rgAo6PJshpQkRicKdi72XmAIbsgCxlVOnc10zKLSb1k8xK95+Yk9oK
         ETMuZOFS41oyE9uj4lXViCFOYc8M5tKzyGGrb0GRWWdMkiei7Pnivq+j4PLF5TZqHg
         /G437GcdQtpJAKmK0yM1daJxw3aIiK/SCEwrOCbQhmqpl9gwiyXRpz3vRnrpFTbmKV
         3q96klKloPFWuhuR+wX2oT8RGvnvIk+fC5w0D4iPl3UxmMvJu+Ugx2Pg3Kr5/n38r7
         tRsqBXdh31ZqlTrdTtZ/0BB1N2wReM/Mp228+6Dg4c7Hc9tZEMmV8KTHHf2KylvR25
         oRmyNylQtWhmncthw+XTVD2eNeBFvILtzypXwYRvBSK+nvbF/zu19lXYTII+ntTopn
         UoxwThmwzhCUb+Jef1OoZgQ4bR3JVdDwMEnmKTkAxuuHZDZebxzZuHqbaolDmdyqBf
         YjQvgKonOgv14UtM31ClPr4keZcdZpYbsaQcTpGZhFAwMGZRrs0oHWBY88eZGwY6Vg
         FWfXyFJSUgLkmg7Yk+LuLO0E=
Received: from zn.tnic (p200300EA971dC5b2329C23FffEa6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5b2:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E2DA640E0034;
        Tue, 20 Jun 2023 08:09:15 +0000 (UTC)
Date:   Tue, 20 Jun 2023 10:09:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [patch v3 1/7] x86/smp: Make stop_other_cpus() more robust
Message-ID: <20230620080909.GSZJFepTsycfJeWtWf@fat_crate.local>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.263684884@linutronix.de>
 <ZIvByEFqiJZOyau2@a4bf019067fa.jf.intel.com>
 <87mt0z7si2.ffs@tglx>
 <ZIxt9Er5nJRjCUXh@a4bf019067fa.jf.intel.com>
 <87h6r770bv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6r770bv.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 08:01:56PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> Subject: x86/smp: Make stop_other_cpus() more robust
> Date: Wed, 26 Apr 2023 18:37:00 +0200
> 
> Tony reported intermittent lockups on poweroff. His analysis identified the
> wbinvd() in stop_this_cpu() as the culprit. This was added to ensure that
> on SME enabled machines a kexec() does not leave any stale data in the
> caches when switching from encrypted to non-encrypted mode or vice versa.
> 
> That wbindv() is conditional on the SME feature bit which is read directly

wbinvd()

Otherwise:

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
