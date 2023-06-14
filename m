Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E560672F410
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242439AbjFNFRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjFNFRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:17:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF4F170E;
        Tue, 13 Jun 2023 22:17:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE6DA63D9F;
        Wed, 14 Jun 2023 05:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252B6C433C8;
        Wed, 14 Jun 2023 05:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686719832;
        bh=ZjUr/40wF1lo2d8KRn3eSCbrDSo2QgKdPZMPSyeFtHc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JiLHFSmZbupfNHithnXlFYpijNdFBBZYfZLmNESYuxMcX/+oUeet/Ozgg8x4q8oJc
         ISwyrBs+6NNIjgSSHbgA7ymDj1nma1Ul8J9JNL9eF7UJLmCStLSwqMXzIkweEsdpUJ
         RcXnD6sHyrm34ORA7QN9GlWjwH4Htb83YzfDdWqKQdnk3ueB8UXgVyZc/oLPA2OzLu
         zhFE7xoBt13sbNm95XZvl9vPlWPyl5e9LL+5kzeaj6GSwh7rj2I8PtTKAS/ywtvB0L
         nCAx2j0Om8oCAjL1SB4XYqOE1ktH5ALq7JVPyc/kn/izw9HoZkRHem47x5M7i1+ZfY
         yNMaMW8ze26pQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     baomingtong001@208suo.com
Cc:     toke@toke.dk, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath: Remove unneeded variable
References: <20230613093757.5380-1-luojianhong@cdjrlc.com>
        <b41c50989125dec782e1fbd2793d0ecf@208suo.com>
        <209fbe59213d89c3e7e3a5fe6030e19e@208suo.com>
Date:   Wed, 14 Jun 2023 08:17:08 +0300
In-Reply-To: <209fbe59213d89c3e7e3a5fe6030e19e@208suo.com> (baomingtong's
        message of "Wed, 14 Jun 2023 11:09:07 +0800")
Message-ID: <87legmd3mz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

baomingtong001@208suo.com writes:

> Fix the following coccicheck warning:
>
> drivers/net/wireless/ath/ath9k/gpio.c:501:5-8: Unneeded variable: "len".
>
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> ---
>  drivers/net/wireless/ath/ath9k/gpio.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

The "wifi: ath9k:" prefix is missing from the title. And also try to
make titles unique so something like this:

"wifi: ath9k: remove unneeded variable from ath9k_dump_legacy_btcoex()"

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
