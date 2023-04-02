Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FAF6D3775
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 12:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjDBK5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 06:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjDBK5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 06:57:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446891A974;
        Sun,  2 Apr 2023 03:57:32 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-046-114-210-195.46.114.pool.telefonica.de [46.114.210.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3CB341EC0531;
        Sun,  2 Apr 2023 12:57:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680433050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sjr/8YpBxpZu8XIgiov75FI9xlVapCwFazswEREcX9g=;
        b=jTzWHm2czG2w1cVgRl3fWAkOCMpWd2gBrkXvAOmMQHLZIYTEbiTBl6EE5NOuG9O9CEw1XH
        4x/KA/QaSH66bMGRkZjuf937YADfMBD96C8623hBFpfuTsy3zcjwZGcJJAIMaFMf0M1Gjj
        HWNxrZIgorni5+O6nc+ij+1Tz7XbwpI=
Date:   Sun, 02 Apr 2023 12:57:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Guy Durrieu <guy.durrieu@cegetel.net>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Santosh Shukla <santosh.shukla@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Borislav Petkov <bpetkov@amd.com>,
        Leo Duran <leo.duran@amd.com>, 1033732@bugs.debian.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_x86/acpi/boot=3A_Do_not_register?= =?US-ASCII?Q?_processors_that_cannot_be_onlined_for_x2apic?=
User-Agent: K-9 Mail for Android
In-Reply-To: <c02a2a2f-2b40-e13e-ac40-e5d19a66b5ba@cegetel.net>
References: <20230105041059.39366-1-kvijayab@amd.com> <c02a2a2f-2b40-e13e-ac40-e5d19a66b5ba@cegetel.net>
Message-ID: <D2229CD1-CD5F-49E9-A0F5-BAB3940B6BFB@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 2, 2023 12:41:46 PM GMT+02:00, Guy Durrieu <guy=2Edurrieu@cegetel=
=2Enet> wrote:
>My system worked fine with kernel 6=2E1=2E15, but stopped booting after
>upgrading to 6=2E1=2E20 and resulted in a kernel panic:

Does this fix it:

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/tip/tip=2Egit/log/?h=
=3Dx86/urgent

Thx=2E

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 
