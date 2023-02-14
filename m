Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AA0696779
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjBNO7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjBNO7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:59:02 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E9925964;
        Tue, 14 Feb 2023 06:59:01 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id c1so13995574edt.4;
        Tue, 14 Feb 2023 06:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5ERRhs7nNybC9hIQk0gh7wHgZ+DH1wdkeAx1FnJd7A=;
        b=nJNTU/UOumuKdQyV859J9L4RcoJ3mpUrBs4TrSa1haaYXwAf9JAoozxtQsjR/NdbGu
         Opn40i2KhqOY3nV1hYdKs8IwDObfNwv2deNG0mAAc2heiuvv+pYhmQIEdOR/JPTL7Vpk
         K53TVmmrUTCSrtkNB8DUgypaT4EcWVC62pEol66JKeLndWrBSIdtgG19SdegIsl35ziX
         qBhYhFR0sSL9Qk04+2cSQpQeTqakQ9+DqbCOL8wxamTWFva/8RN384ey2lotNUooOkdc
         ADIlmxCR829YYJjrE830D5ZPrCL+S4OSlYkgfp4eLMVM29dQ8v/xi2LqDcHfOYgByWj9
         0wIg==
X-Gm-Message-State: AO0yUKXZUWrwGoNt/VkouFgQx9xH15APLbjEYbhHJBeR1/Oy3mSfskVk
        jS7B80mfc7Lp3+hVR60dQ/bbEtmnWVakSakDnnw=
X-Google-Smtp-Source: AK7set+JEd2BvRluIpzqCuC0r+CVE5moiUumCYJVW6rR1dq2wAAn3fanAu6QWrYiisDPx6VNe1vhUVWz2vehonmvr4E=
X-Received: by 2002:a50:c01c:0:b0:4ac:c160:3010 with SMTP id
 r28-20020a50c01c000000b004acc1603010mr1349587edb.3.1676386740580; Tue, 14 Feb
 2023 06:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20230213213537.6121-1-mario.limonciello@amd.com>
 <20230213213537.6121-2-mario.limonciello@amd.com> <CAJZ5v0j0GYyrF33=7ginfhYMrNyD=EDUK0RuHHYkKJ2VZAQnsQ@mail.gmail.com>
 <MN0PR12MB61018CBDE5DBBAB7C65F9F4AE2A29@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB61018CBDE5DBBAB7C65F9F4AE2A29@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Feb 2023 15:58:49 +0100
Message-ID: <CAJZ5v0hD2evYkZFmxv+pwF34UUr4VV1HGBvcjbtW_RMD6a6vpg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: x86: Add more systems to quirk list for forcing StorageD3Enable
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dbilios@stdio.gr" <dbilios@stdio.gr>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 3:52 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Tuesday, February 14, 2023 08:49
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: rafael@kernel.org; linux-kernel@vger.kernel.org; dbilios@stdio.gr; Len
> > Brown <lenb@kernel.org>; linux-acpi@vger.kernel.org
> > Subject: Re: [PATCH 2/2] ACPI: x86: Add more systems to quirk list for forcing
> > StorageD3Enable
> >
> > On Mon, Feb 13, 2023 at 10:35 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > >
> > > commit 018d6711c26e4 ("ACPI: x86: Add a quirk for Dell Inspiron 14 2-in-1
> > > for StorageD3Enable") introduced a quirk to allow a system with ambiguous
> > > use of _ADR 0 to force StorageD3Enable.
> > >
> > > It is reported that Vostro 5626 suffers same symptoms. Add this other
> > > system to the list as well.
> > >
> > > Suggested-by: dbilios@stdio.gr
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217003
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Can you please combine these two patches into one?
> >
> > Or at least make the subjects differ?
>
> I left them split so that we could revert one if the BIOS is fixed on one
> in the future.  Happy to respin with separate subjects.
>
> But before I respin; something else I want to offer as an idea to avoid this list
> growing.
>
> They all use the same CPU.  So we could just add the CPU model that all of these
> use to the force StorageD3Enable list and take out the whole (growing) list.

Well, I'd rather do this, but in the next cycle.

> Which way would you prefer?

For this merge window, please respin the current patch series and make
the changes as per the above early after 6.3-rc1.

It may be still necessary to pull them into 6.3-rc later, if more
instances are reported or discovered, but we'll see.
