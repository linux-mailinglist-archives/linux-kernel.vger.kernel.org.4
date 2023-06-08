Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43F672864B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbjFHRZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbjFHRZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:25:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAA22729;
        Thu,  8 Jun 2023 10:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5881D64F82;
        Thu,  8 Jun 2023 17:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A1DC433D2;
        Thu,  8 Jun 2023 17:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686245145;
        bh=sKEE1Ha7Onv2/h4XglcashuT7Hsevk+zCcxzbAznYIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3intFhY6AW3soEmjHN+z/uRHcbHuuytfhyvrgmQ+ZZmte3qGf6yS5NcWlx2MZdOR
         KNgNpFarInlPWPlvBe9hFDILFw2qyohv9pCibWlfrPdTd+4sSzKvZDTJv7psvgReCC
         ZIW0yFy97ecYw/az2D5nZwCpc2KnOFg6A8hgyKeIHAtXfapysA2CBVSQoyu+9BCSEG
         n+0A4nwhzETT9g1SjHMJPAGlU0IHu0Xu49vu1MP2jWM0g6CKrku7k+DhhvPvz5x9O1
         R1fEql7U4sqKnohcsX9WhggIl2rpy7gey8oDADEomzPXHE+f2Iw5VRPwUg88XsaCv2
         G0Oy0DEHxxm+A==
Date:   Thu, 8 Jun 2023 18:25:40 +0100
From:   Lee Jones <lee@kernel.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 1/4] leds: simatic-ipc-leds-gpio: add terminating
 entries to gpio tables
Message-ID: <20230608172540.GH3572061@google.com>
References: <20230524124628.32295-1-henning.schild@siemens.com>
 <20230524124628.32295-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524124628.32295-2-henning.schild@siemens.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023, Henning Schild wrote:

> The entries do not seem to be stricly needed when the number of entries
> is given via the number of LEDs. But adding them is a safeguard should
> anyone ever iterate over the tables to their end, it also gets us in
> line with other drivers that register "leds-gpio" tables.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
