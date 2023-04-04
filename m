Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9912B6D6D83
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbjDDUB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDDUB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:01:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9441F1BE2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 13:01:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BFAA637BE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 20:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88FA3C433EF;
        Tue,  4 Apr 2023 20:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680638485;
        bh=rCdo7Uzp26R9Y0y5u5Xtz/JGD2lAQBywE0PagiehKkU=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=PBZUuPbHfslB9ZYUrrd9ezrtMJW3GdsEZ3rcG1v5yVlgoweRFkLxuDUoMQrZgHsWD
         Vbe9XVNRgqFN3x45rfyF+ZVVdHLuCw2GZnhHMBoNByNhtCtzBCIG/2oRTm+bWVwIC3
         PcUuqIf7f8XYD/l8k89/L857o1TUqi1yD2UIMeEK+KELWr1NjJBrqscj3EPDbVw/OI
         WE7oRwriS9I9PaPRJzY+U0/zeXg0mGi2xPGj+eZElD2AFACEHuPWGVkUZE5rxRaxjC
         619J0ZoA8xoVA+jxNGrDnOwFdmHgvDBQ1UnybrPhokKr72el83Runim3KSkxzkIm5i
         KK5HHr5yZlrUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A4B4C395C5;
        Tue,  4 Apr 2023 20:01:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   "Kernel.org Bugbot" <bugbot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bugs@lists.linux.dev, linux-rockchip@lists.infradead.org,
        clabbe.montjoie@gmail.com, heiko@sntech.de
Message-ID: <20230404-b217298-17108437c21e@bugzilla.kernel.org>
In-Reply-To: <ZCx5eVJvXaE1dDvt@Red>
References: <ZCx5eVJvXaE1dDvt@Red>
Subject: Re: missing crypto power domain on rk3588 ?
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: peebz 0.1
Date:   Tue,  4 Apr 2023 20:01:25 +0000 (UTC)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This conversation is now tracked by Kernel.org Bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=217298

There is no need to do anything else, just keep talking.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (peebz 0.1)

