Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBFB6D0DF1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjC3Sk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjC3SkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:40:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA495B47F;
        Thu, 30 Mar 2023 11:40:00 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-046-114-214-160.46.114.pool.telefonica.de [46.114.214.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 72A721EC0691;
        Thu, 30 Mar 2023 20:39:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680201592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8jtW7KDarWhIMVdL7PQou8uaSWKERsvcswoP5qV/aBw=;
        b=q+TX0CaXxsGHd0sHE2PsvD5ggkhl+PitCglUBq2sZcSld8M0tfYmAzDCj+RLUQhbjQnh82
        mdJxbSbzwC9DUjklXhoq7WrX7F9B2F/kl8s+qq+DGlbDQRbKwiAmN1kuIATE1EfXI3zeTr
        rmB+Wc5n8hhF+R10XP1k9S/e2GGHRQk=
Date:   Thu, 30 Mar 2023 20:39:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>, x86@kernel.org
CC:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/ACPI/boot=3A_Use_FADT_ver?= =?US-ASCII?Q?sion_to_check_support_for_online_capable?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJZ5v0i-ypLb9oPO8RqdQ6Vm3yD1ohP1sFei_BPNgiHZibdoQg@mail.gmail.com>
References: <20230329174536.6931-1-mario.limonciello@amd.com> <CAJZ5v0i-ypLb9oPO8RqdQ6Vm3yD1ohP1sFei_BPNgiHZibdoQg@mail.gmail.com>
Message-ID: <D72D9855-2264-466C-8705-B8E8BF398B10@alien8.de>
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

On March 30, 2023 8:23:38 PM GMT+02:00, "Rafael J=2E Wysocki" <rafael@kerne=
l=2Eorg> wrote:
>s/Petkob/Petkov/ I suppose?

Fixed=2E

>Would have been nice to CC this to linux-acpi (done now)=2E

Sorry about that=2E

>Anyway, x86 guys, are you going to handle this or do you want me to do th=
at?

Yeah, all queued into tip:x86/urgent=2E  Holler if something's still missi=
ng=2E The whole situation got on my nerves so I queued both fixes and am ho=
ping all is fixed now=2E Ufff=2E

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 
