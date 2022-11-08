Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CA26218D8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiKHPxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbiKHPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:53:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3C6EB1;
        Tue,  8 Nov 2022 07:53:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C87B76162F;
        Tue,  8 Nov 2022 15:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF58C433D6;
        Tue,  8 Nov 2022 15:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667922805;
        bh=PRO30yRurUbHZpdLzN8x9Q3584RZSHnID9+jX8Obh+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IClHp78MU3nWMIP915AO6LG55lEQ0hHr0Ool07pB41BAPb2TPgPe3WrIpobyyw3qo
         uPC317aauYjXJzr4/Ag66h7TPrKHTT9B93oVZw5uAdmzgRdfcwXOUquQkbP+7BO/2t
         jeZWjTuBpbd1b8P3cUIsJzmoEFwMZ98BKSVLeehU=
Date:   Tue, 8 Nov 2022 16:53:21 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Larry Lai <larry.lai@yunjingtech.com>
Cc:     Lee Jones <lee@kernel.org>, chengwei <foxfly.lai.tw@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "GaryWang@aaeon.com.tw" <GaryWang@aaeon.com.tw>,
        Musa Lin <musa.lin@yunjingtech.com>,
        Jack Chang <jack.chang@yunjingtech.com>,
        Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>,
        Noah Hung <noah.hung@yunjingtech.com>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [PATCH 1/5] mfd: Add
 support for UP board CPLD/FPGA
Message-ID: <Y2p7cQXULoBp4k3f@kroah.com>
References: <20221019022450.16851-1-larry.lai@yunjingtech.com>
 <20221019022450.16851-2-larry.lai@yunjingtech.com>
 <Y1/ik4XGNWsOg5KH@google.com>
 <SG2PR06MB37422173908A6584B3D6D349F93F9@SG2PR06MB3742.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR06MB37422173908A6584B3D6D349F93F9@SG2PR06MB3742.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 03:45:45PM +0000, Larry Lai wrote:
> Dear Jones,
> 
>         Thank you for spending time to review this code, please check our response below your comment with yellow background.

html email will be rejected by the mailing lists.  Please resend in
plain-text format.

thanks,

greg k-h
