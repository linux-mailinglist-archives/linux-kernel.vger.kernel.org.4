Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C22645F61
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLGQ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiLGQ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:57:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C594B775;
        Wed,  7 Dec 2022 08:57:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85FB7B81B90;
        Wed,  7 Dec 2022 16:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C41C433D6;
        Wed,  7 Dec 2022 16:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670432268;
        bh=IGp2hmZyOcCMcEh2LddZyGh6DbOd/8iqx5oEvJCkAZU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nKBXPl7Q7HM4H5wyfBknQh+CEOoxlF9rmbwwCIW3iBA5uSIUBlUwxvGjUB0538Orh
         CsVX5T+1mQ5zxuwjsmd9+aBTyGzn6fjt9RE5Mv7gtKOPBM9MNad2okmzInig8h0ild
         xly170EcyaOeUCaUsli0q7134Ks8ZHkYsMgLyBQVXaYRUmX5+gIDOiVy8n0sZTFYB4
         b/bjPLcX/1s9zOgKYuZ/k5qSeaVZs1NxzGllFvkFays3mmfVwyyUFTmkcq3KK06+2p
         e/JBmU5aZHUk466ZvmFlOCeqk0+MjObo5CaEsLQzow5c76qErJOR1HCE5pvmJWVbBz
         VpR5UCBMqYreg==
Date:   Wed, 7 Dec 2022 17:57:47 +0100 (CET)
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
Message-ID: <nycvar.YFH.7.76.2212071757220.6045@cbobk.fhfr.pm>
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

Rafael,

it would be nice to get

	Reported-by:
	Tested-by:

for these reverts if possible.

Thanks!

-- 
Jiri Kosina
SUSE Labs

