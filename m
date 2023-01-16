Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBAB66BB8C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjAPKTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjAPKTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:19:14 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679D25592
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:19:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y19so6484927edc.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qpFaSguiiG5sSHfQpXcgWAbjptbT0uDYsnZiuy0reew=;
        b=Fkm4AffZNk48McGdW+1Y8+1FGAHhY1hGahKH/oAorEqzl7rgGtEe2ea0jeZBUxnDow
         hF53GMkNMxVz8g5R3IywO3S/ZgYqxOalrADzSEh+3pK3mKWX6ma1Z8jihu1dlEry3JYB
         YU7HXiHYmgQL9DhHJDpZXi5fqz3Lj6tJr7CFqnW+YbK0j552jjhbwFSjV9P/Sav87zeN
         r6N7upl+wYglr6gCQ/GS9/lfucTz4FLi+BhCdcj0LYpQAS+pGLOfFvZn8z82Q4kmOu+8
         WKMLiC2xytUGg+2yQROFHv/Cd4jyxpC3U+QRV2bMT3sNQPFrqSte0HpwXezWPkegpAUs
         kAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpFaSguiiG5sSHfQpXcgWAbjptbT0uDYsnZiuy0reew=;
        b=x9LxHu1p0RskPOmYmvFtbDbGXxFBlNxFOqde1J0LfBq4ZarlzPNx7dDNMn0jlbtzua
         zfutUxxESz+Xt9BLZCf3KXHlQaTcuo3ZAZXhIPqcl4ipWvDsopKDLT+NfppwjYK6s4Le
         ATQjDz4HFfb1DOIumdPP7NsFqTcUoAKBq85icsp8TiTLXWBlBkme9rRpdB9IYw/hUrzQ
         7fsa4tv/6o0H26LiT3F1RB0zmYI1EhI1nDcqxTBlTea3nJx9b0EtZKtjWnQbnR+tw9/p
         23SSqiOQhfRTaXs95YtgoScaeHlkcjkaq7YvQnswpE2n62JX+JyO/t00YTtgxVlx4FwF
         BhEA==
X-Gm-Message-State: AFqh2kqyUObxxZ2RF57m8mlsFTdUkeUlHIb0kU3PgwfCE1/x1WxejSUb
        1cxm84r1UQyiaArZnoMLkuJPTTZ2OOFlOF3DkPVgPg==
X-Google-Smtp-Source: AMrXdXs8lFkjin3Xc38VxLUZ1H0RxVFbJcO8t+nYz/ev+BVDBbRsh9NWNIrb/degGGcyXJc5Q1LYxjrVid8GoTL+Seo=
X-Received: by 2002:a05:6402:f29:b0:499:b3b2:cfbf with SMTP id
 i41-20020a0564020f2900b00499b3b2cfbfmr263340eda.145.1673864352024; Mon, 16
 Jan 2023 02:19:12 -0800 (PST)
MIME-Version: 1.0
References: <60a52348-7d50-1056-a596-e154f87c99d2@amd.com> <Yyt5LSxSz+6QeWF1@zn.tnic>
 <YywvmueFj/ibyZdf@smile.fi.intel.com> <YywwEvkZK1R9mJfE@smile.fi.intel.com>
 <c0c8bdce-26a0-ad3f-749b-7585d947608b@redhat.com> <YyxrdpUyc+kp48kX@zn.tnic>
 <33d5cc27-474b-fdec-a6b0-84ac16f7d386@redhat.com> <CAOtMz3M=BTZUTRMHWGULwMDWmGdOzHKo=UcZeg3sP8_ndVYk2g@mail.gmail.com>
 <YzG657ZFeEvLd6hm@zn.tnic> <CAOtMz3MWnmdMbw_CKxBKVt=TJpLNJuZUzpxvnDi+QnigaLozLA@mail.gmail.com>
 <Y7v2j92Ol6dL3FLE@zn.tnic>
In-Reply-To: <Y7v2j92Ol6dL3FLE@zn.tnic>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Mon, 16 Jan 2023 11:19:00 +0100
Message-ID: <CAOtMz3PG4nku-O7dh+1U_DA05HAmQboTqwUQkCkrXQLV9bFjPw@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] i2c: designware: Switch from using MMIO access
 to SMN access
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        jarkko.nikula@linux.intel.com, wsa@kernel.org,
        rrangel@chromium.org, upstream@semihalf.com,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

> Make init_amd_nbs() arch_initcall_sync() so that it executes after PCI init.

I described earlier in this thread why such option is not working -
let me quote myself:

It's not enough for running init_amd_nbs() to have only
pci_arch_init() done. We need the pci bus to be created and registered
with all devices found on the bus. We are traversing through them and
trying to find northbridge VID/DID. Due to the above, we need to run
init_amd_nbs() only after acpi_scan_init() that is invoked from
acpi_init() which is registered as subsys_initcall. That's why the
trick with switching init_amd_nbs() to arch_initcall_sync will not
work.

We have a kind of chicken-and-egg problem here. Or is there something I missed?

I wonder if there is upstreamable option to control order of the
drivers' init by forcing link order?

Best Regards,
Jan
