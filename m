Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468F262A282
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiKOUIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiKOUIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:08:39 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FC41B1F8;
        Tue, 15 Nov 2022 12:08:38 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8057060002;
        Tue, 15 Nov 2022 20:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668542917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HjQraYDTkExeBghuLlBFKO9pE+ZpzPnsVNxMoXm0ze8=;
        b=L0gfLEBD249tGl3kF6sawTJ9LpxE34nj8OmQLU6348FzbmF+07N0AKuIX/MoTu46Q/gM1N
        phS6gCefT/yzPqHekzW9UzZH1tY1VBQAdD/A6nNgzZtctOi0k4xgkdWKNQkzdzgmFOg2bC
        kzAYjikioySEuEAp1tvlk6ayP0jWbH7ze2ajGtFeDY36KrldW1qg1dvgmpeuILeBpGKTkE
        PlO13ZH6nYM13bSOO/r6Lkvs35m8HhlL+9f82oV4pCw0klYExXndcXdWp9j5InOYaihflc
        UIGXlMbcaM+GeU2I1LvGMX0EbK5oDFb5JSEqEg/Bne4H/dkfMc6y8KJkk4NSTg==
Date:   Tue, 15 Nov 2022 21:08:36 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 0/5] rtc: rtc-cmos: Assorted ACPI-related cleanups and
 fixes
Message-ID: <166854285782.2307151.6934921348339117485.b4-ty@bootlin.com>
References: <5640233.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5640233.DvuYhMxLoT@kreacher>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Nov 2022 13:05:13 +0100, Rafael J. Wysocki wrote:
> This is a v2 of the series previously posted as
> 
> https://lore.kernel.org/linux-acpi/2276401.ElGaqSPkdT@kreacher/
> 
> The first three patches in the series have not changed since then (I have
> considered moving the last patch, which is a fix, to the front, but that turns
> out to be a bit cumbersome and not really worth the effort).
> 
> [...]

Applied, thanks!

[1/5] rtc: rtc-cmos: Call cmos_wake_setup() from cmos_do_probe()
      commit: 508ccdfb86b21da37ad091003a4d4567709d5dfb
[2/5] rtc: rtc-cmos: Call rtc_wake_setup() from cmos_do_probe()
      commit: 375bbba09692fe4c5218eddee8e312dd733fa846
[3/5] rtc: rtc-cmos: Eliminate forward declarations of some functions
      commit: dca4d3b71c8a09a16951add656711fbd6f5bfbb0
[4/5] rtc: rtc-cmos: Rename ACPI-related functions
      commit: d13e9ad9f5146f066a5c5a1cc993d09e4fb21ead
[5/5] rtc: rtc-cmos: Disable ACPI RTC event on removal
      commit: 83ebb7b3036d151ee39a4a752018665648fc3bd4

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
