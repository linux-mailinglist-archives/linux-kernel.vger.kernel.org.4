Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803B967771E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjAWJME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjAWJMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:12:03 -0500
X-Greylist: delayed 507 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 01:12:01 PST
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050:0:465::103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3521E2AE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:12:01 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4P0kfR2wxZz9sQb;
        Mon, 23 Jan 2023 10:03:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=espindo.la; s=MBO0001;
        t=1674464607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4q4UFMTfQGpIvSn7vHth/9oUEvpl/rgd9o5hNjpWU8=;
        b=RZfGOlMtyqabGNKLLRw6HjpmMB1GotTnBYqF+D5eUOFFP0V/9T33x/NrsLoQyA6SP3v6aZ
        EigaZM5rAAJwBqHzodp+7zGrnO1KJAR+ONqn8MB68dQuvkakk58f59/Vfw5QQYPf5g2f7n
        D+0mXsNJT7rKrjfTZBqx2br64wYKqqzppWsCzzP1/an3/YAXDLK0zNWL7avxndA1sQ8AQm
        +M59VlKembQoeiK5uP1nBXZfI9uLAFFkkXtg+ktCYEkn2OgtU+jBCUh8F5N0lESLWVM65o
        IqyxKx0PIBkc0dqygYQVjEj5xo/FghbheTmVVJ862EtICbXKVd6Hf7BdgZb01Q==
From:   Rafael =?utf-8?Q?=C3=81vila?= de =?utf-8?Q?Esp=C3=ADndola?= 
        <rafael@espindo.la>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: amdgpu: suspend-to-idle on a 4350G desktop
In-Reply-To: <MN0PR12MB6101F62407FB383609B2FB30E2CA9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <87edrnu9mk.fsf@espindo.la>
 <MN0PR12MB6101F62407FB383609B2FB30E2CA9@MN0PR12MB6101.namprd12.prod.outlook.com>
Date:   Mon, 23 Jan 2023 08:03:24 -0100
Message-ID: <87bkmptyg3.fsf@espindo.la>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4P0kfR2wxZz9sQb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will do.

Thanks,
Rafael

"Limonciello, Mario" <Mario.Limonciello@amd.com> writes:

> [AMD Official Use Only - General]
>
> Rafael,
>
> Can you please open a bug report here
> https://gitlab.freedesktop.org/drm/amd/-/issues
>
> And attach the log from:
> https://gitlab.freedesktop.org/drm/amd/-/blob/master/scripts/amd_s2idle.py
>
> If it fails prerequisites please also include a full dmesg including a su=
spend cycle.
>
> Thanks,
> ________________________________
> From: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>
> Sent: Saturday, January 21, 2023 10:37:23 AM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Subject: amdgpu: suspend-to-idle on a 4350G desktop
>
> Hi,
>
> I have a desktop that doubles as a NAS, and would like to suspend it
> when not in use. It works, but when it comes back it is using about 7W
> more than before going to sleep.
>
> It looks like a6ed2035878e5ad2e43ed175d8812ac9399d6c40 is the
> culprit. The system doesn't even support S3:
>
> % cat /sys/power/mem_sleep
> [s2idle]
>
> And looks like the vendor decided that they should not define
> ACPI_FADT_LOW_POWER_S0. The MB is a Gigabyte B550I AORUS PRO AX with
> bios version F16e.
>
> Which systems had crashes when ACPI_FADT_LOW_POWER_S0 was not defined?
> Would it be possible to limit the check only to those systems or at
> least only to systems that have S3?
>
> I can build the amdgpu module without that check and see if the problem
> goes away if that would help.
>
> Thanks,
> Rafael
