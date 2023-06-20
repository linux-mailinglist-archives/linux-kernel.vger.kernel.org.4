Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567DE737432
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjFTSac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjFTSa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9339710E6;
        Tue, 20 Jun 2023 11:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 308A061408;
        Tue, 20 Jun 2023 18:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 821DDC433CD;
        Tue, 20 Jun 2023 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687285824;
        bh=dmdXO9EOYaPTDvdSJBnvA6ZG2eBsDyhXoF36rRwzS3U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HX/7fMO/S4aAENDKMTbje1k9LH7K5j5D4cx3kzyNLELuzAASgOw8zVG/+74soZWn+
         e0kwt/26rZdhKJ3x0j2pCFXMN7Xpdf1ZOxy9UqO1Di3g4ICvzSs34qNvf6bKDNUeWk
         iHmbXi4meSkAlZvTZk25futRCTyvR597EtcjR8jrBQW0M3a0z7JaXrM6WweL5UHmVN
         MaMRZtj+M3wAHYQtRsTYHDbHtrwneVvEZr+FqGFZtvxQ8G6/9QJO7J61u+2DxB3J/2
         sofQnK4/b8QFpxKFtvXfWDvUuyju3J+tlanxjxDR0cusRQOyf23yKnpYXNKc8/7YV9
         40RKjgtoVi3Lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58C9CE301FA;
        Tue, 20 Jun 2023 18:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sysfs: make bt_class a static const structure
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168728582435.12887.8737547745115004930.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 18:30:24 +0000
References: <20230620144051.580683-2-gregkh@linuxfoundation.org>
In-Reply-To: <20230620144051.580683-2-gregkh@linuxfoundation.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        ivan.orlov0322@gmail.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 20 Jun 2023 16:40:52 +0200 you wrote:
> From: Ivan Orlov <ivan.orlov0322@gmail.com>
> 
> Now that the driver core allows for struct class to be in read-only
> memory, move the bt_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at load time.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sysfs: make bt_class a static const structure
    https://git.kernel.org/bluetooth/bluetooth-next/c/665baafde870

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


