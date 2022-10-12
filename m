Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC555FCBC4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJLUA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJLUAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:00:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F50A7548F;
        Wed, 12 Oct 2022 13:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A4B5B81B7D;
        Wed, 12 Oct 2022 20:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95CDCC43470;
        Wed, 12 Oct 2022 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665604815;
        bh=PNhGS93jS7BHbP2yfrlMWR2649CNyUFWZyOJ1/GmZRs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LfdsDPhvOSNPNJiDASA/bOsUl+k3UUP4kLlBVIcI3PgVKBaPcJTuSz+Aws5md2SvY
         xEewLvnI18absC7DPnYAC4uJ0bRg/JGMY3b7D0KXYNEfahnr+DXWUnMWApHkhVgdL7
         QILFLOD64uBA+jvBo/gyPT8yBB79Y5nYiSfJ97ERvs7odjrgEAj0edax8LgKg/jh3+
         6GunsX+QDM7seIB5hPJOX66PH+VZX5iZsL4IGs3S30bMCW0GnW/OaTqG8eRFBhxGT6
         iya44c1mAsCtWeAA5mjZWjuyksT/J8fOx9nXB6jrqN3N5l+XqqF02yyQ8hvOnY5V+G
         VVKZTEfKW7mgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B62FE4D00C;
        Wed, 12 Oct 2022 20:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 RESEND] Bluetooth: virtio_bt: Use skb_put to set length
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166560481549.27468.13272780946907639506.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Oct 2022 20:00:15 +0000
References: <20221012074507.8157-1-soenke.huster@eknoes.de>
In-Reply-To: <20221012074507.8157-1-soenke.huster@eknoes.de>
To:     Soenke Huster <soenke.huster@eknoes.de>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Oct 2022 09:45:06 +0200 you wrote:
> By using skb_put we ensure that skb->tail is set
> correctly. Currently, skb->tail is always zero, which
> leads to errors, such as the following page fault in
> rfcomm_recv_frame:
> 
>     BUG: unable to handle page fault for address: ffffed1021de29ff
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     RIP: 0010:rfcomm_run+0x831/0x4040 (net/bluetooth/rfcomm/core.c:1751)
> 
> [...]

Here is the summary with links:
  - [v2,RESEND] Bluetooth: virtio_bt: Use skb_put to set length
    https://git.kernel.org/bluetooth/bluetooth-next/c/6ab8872f1976

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


