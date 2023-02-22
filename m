Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B14969FCC2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjBVUKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBVUKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:10:23 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DB928228;
        Wed, 22 Feb 2023 12:10:21 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B92A71BF208;
        Wed, 22 Feb 2023 20:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677096620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vq+pTTILgv2/zfRW0a3Zsa75HyWqDc3SyopiCsnzOcE=;
        b=EceKbULuqXgA+ACPlCdGh2hAQIzp41WNfDC7rHBXamHaF8HEkRyZgQJa+OM8bZdv8JnapC
        dHzJ2kTywO//zhUWs+5ThJwPYx4KArcFrYlSHXLkBezUIL4Ofqi3asDOKAKTn2s/fMvIxv
        3kiYA8EeSib+TAF6f0hNuiXYonChLellWzWqUtFRE3Tpfr1WueqAChMJyqSV6ZIhBNN04F
        oK7B+HG4ScZK5+wXKX0h7oj9cUJ66lgWQH81PBvTdznr6DbL3qjFk9qn68h+9tRV3vjryn
        g5fy/Oqg6xccVqvBi8E47ulLMQpc89WIwmSqHreZGzn3FZ1iALfzUvsODFWcAg==
Date:   Wed, 22 Feb 2023 21:10:17 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 0/5] rtc: isl12022: Clean up and simplify the driver
Message-ID: <167709656542.70897.14233242746464193107.b4-ty@bootlin.com>
References: <20230110140806.87432-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110140806.87432-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Jan 2023 16:08:01 +0200, Andy Shevchenko wrote:
> While looking for something else I noticed that this driver is dusted
> a bit. Clean up and simplify it using available kernel types and APIs.
> 
> Changelog v2:
> - added tags to patches 1,2,4,5 (Rasmus)
> 
> Andy Shevchenko (5):
>   rtc: isl12022: Get rid of unneeded private struct isl12022
>   rtc: isl12022: Explicitly use __le16 type for ISL12022_REG_TEMP_L
>   rtc: isl12022: Drop unneeded OF guards and of_match_ptr()
>   rtc: isl12022: Join string literals back
>   rtc: isl12022: sort header inclusion alphabetically
> 
> [...]

Applied, thanks!

[1/5] rtc: isl12022: Get rid of unneeded private struct isl12022
      commit: f525b210e9d4dcefb88594d50e426068e62840f4
[2/5] rtc: isl12022: Explicitly use __le16 type for ISL12022_REG_TEMP_L
      commit: 93219a4fb8bdf279f749b5eef40bef1bbe805fc3
[3/5] rtc: isl12022: Drop unneeded OF guards and of_match_ptr()
      commit: c8ae2735cb3d28892fd734804b60e5abf1f6fa91
[4/5] rtc: isl12022: Join string literals back
      commit: 9bb1e189d7d2c3838938efcc497333803b946081
[5/5] rtc: isl12022: sort header inclusion alphabetically
      commit: 303eac653a181be59674920725142cfbdd5ba4cd

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
