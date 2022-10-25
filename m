Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA96A60D746
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiJYWkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiJYWkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:40:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C68558DEE;
        Tue, 25 Oct 2022 15:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFC5DB81F5E;
        Tue, 25 Oct 2022 22:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80D19C433D7;
        Tue, 25 Oct 2022 22:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666737616;
        bh=v/gO7B5DNK3drVPpsCaD6Y1Q264IFu3D5vXNNxHMIWE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SX9tHiUaCAR43XAXShzfk3LwHh6/LYHK352WPmS33nhN2JsoS3qPm1p6bKC8mALC7
         3HNEB6zC6AS1Bg/rNeopUqxrAYnJUbQH553s4pP3TC7dwH8t+KY3+EN+vVMgMKrrIT
         gP7QTHQd5tkFG0dE11WxhWhwqZfoWC8WgZaUNkYXL5LEFuGjMGCDkyBsyhCtJm0IQV
         AWoAR6TtC0Epqc1wnw+7PPdP4/b7+Qf9V6mI7R3zGPK/i0zxqKTF0Gwteen5Uzwih7
         EvHbmwXEJmgVSnysSJG5CddnUcrbRPBxij1OtuMkUwT1gnkZG1glMngGe3CrWrvONz
         s/SYElMCrt+bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F8EFE29F32;
        Tue, 25 Oct 2022 22:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/1] virtio_bt: Fix alignment in configuration struct
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166673761638.12942.12923887540538153791.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Oct 2022 22:40:16 +0000
References: <20221024134033.30142-2-Igor.Skalkin@opensynergy.com>
In-Reply-To: <20221024134033.30142-2-Igor.Skalkin@opensynergy.com>
To:     Igor Skalkin <igor.skalkin@opensynergy.com>
Cc:     virtualization@lists.linux-foundation.org, luiz.dentz@gmail.com,
        mst@redhat.com, marcel@holtmann.org, johan.hedberg@gmail.com,
        jasowang@redhat.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Igor.Skalkin@opensynergy.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 24 Oct 2022 15:40:33 +0200 you wrote:
> The current version of the configuration structure has unaligned
> 16-bit fields, but according to the specification [1], access to
> the configuration space must be aligned.
> 
> Add a second, aligned  version of the configuration structure
> and a new feature bit indicating that this version is being used.
> 
> [...]

Here is the summary with links:
  - [v4,1/1] virtio_bt: Fix alignment in configuration struct
    https://git.kernel.org/bluetooth/bluetooth-next/c/57dc0d471d27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


