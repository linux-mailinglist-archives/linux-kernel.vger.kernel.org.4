Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF1A647629
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLHTZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHTZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:25:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5208460B5E;
        Thu,  8 Dec 2022 11:25:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81E1662040;
        Thu,  8 Dec 2022 19:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F24CC433D2;
        Thu,  8 Dec 2022 19:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670527500;
        bh=BBTAhUw2RvKZdchFoZ87jLjuy60S8Cxau2TjZ8ywoN4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=n2w8CI7zCKC7EHtznLxuPvTPKc82xeekDHjZHsir+BuSb421nLGbcY3Aft0/Qomn3
         lfdjcEIqFCzbhiM2SMGVSwLMVWS4vYl+m2kKYpJ849crSW7Pbw81kqBFWUGY7BfTpT
         G5rMKBHHIHGN0lznDAEfrrgaWGGV6ZThWYKpd0Yxfyjahsxaang0uFjyiFlfvzXTlB
         dZI+r8l8nogjTgTdBbRF42wqq161zY0v3xSsY6GlNLZRNdarK4+VFDgdoFl5V3Wn11
         ukp7sxfe6G1o85wVoal5HPK16t+sKAk/s5Ewnel5I95Cx2gn33A/UXMIDxWhh9PDpC
         T9BKpuKRZPUIQ==
Date:   Thu, 8 Dec 2022 20:24:53 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bastien Nocera <hadess@hadess.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] HID: Revert catchall handling of Bluetooth device
 in hid-logitech-hidpp
In-Reply-To: <20221207142433.1158329-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.2212082019370.9000@cbobk.fhfr.pm>
References: <20221207142433.1158329-1-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2022, Benjamin Tissoires wrote:

> We are basically too late in the 6.1 cycle to be able to do anything
> else. Let's revert these 2 patches as we are in a situation where we
> would break too many users.
> 
> We will reintroduce them during the next cycle with proper fixes in the
> driver.

I have now queued this in for-6.1/upstream-fixes and will urgently send it 
to Linus so that we don't have the regression in 6.1 final.

-- 
Jiri Kosina
SUSE Labs

