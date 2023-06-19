Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55494735FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 00:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjFSWSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 18:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFSWSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 18:18:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B391A4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 15:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D81360EBD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801BBC433C0;
        Mon, 19 Jun 2023 22:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687213079;
        bh=H5NDu+AmTBnWcgLqVCNdhh/pEZmVkM0IPucdqWcEgvY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BumbZoccChhT58HZpmpgNhHqd3b1RIX7MlcIsVWdsiulBUaXLWLOTeDv3pBj4ekbu
         o7E5cII6nlBdglJZvIfJN+3jWJuS3/K3PE5dkF9hXH1tDY38Q8wT+TZoblH8dq3wd8
         sb95pN0zA9hvRl6qUUUy6xZskWJRu4sZfNUjxMq0y+IJtigf8UthOT48CJnUpOq+DM
         FkD2+LzBhirAaDMTC84TGIScAEY/6esjcXndyA0fuTJQOjn8zUGGL1z10PLovuVBzD
         nqjHPv+a8PmIASSUQBZtus7srKVPsmFIYi4xpMFesWMbjAs6qbliwdJOJMtjUbxFZF
         JH2m7Q4z9Jn+w==
From:   Mark Brown <broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230617-regmap-kunit-read-writeonly-flat-v1-1-efd3ed66dec6@kernel.org>
References: <20230617-regmap-kunit-read-writeonly-flat-v1-1-efd3ed66dec6@kernel.org>
Subject: Re: [PATCH] regmap: Allow reads from write only registers with the
 flat cache
Message-Id: <168721307824.198217.338527482386390554.b4-ty@kernel.org>
Date:   Mon, 19 Jun 2023 23:17:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2023 21:11:07 +0100, Mark Brown wrote:
> The flat cache is intended for devices that need the lowest overhead so
> doesn't track any sparseness.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Allow reads from write only registers with the flat cache
      commit: d0c99ffe212679b338d12fe283964e6e43ce1501

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

