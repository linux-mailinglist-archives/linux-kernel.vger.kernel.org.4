Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1688D70C117
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjEVO3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjEVO3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:29:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D70F1;
        Mon, 22 May 2023 07:29:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8D8561941;
        Mon, 22 May 2023 14:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D752C433EF;
        Mon, 22 May 2023 14:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684765748;
        bh=zgCnm5TdeQsdNTt7uR7RGxg7lgqFPJstgSHr/HbAaXM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jDVHlnjF0rqQELoJVNmHIPqbgVZhfGBJ9NtExUdj0z1a7gYBtCFEZobwLoBmxUqvk
         bV+1EJHndfa69dIGZsSCIAmYu5ruYExSoh2mr2tmNuTCZnXtVxmLGOTsWCzqBLK94g
         L/wnNKPOWnE8nwGeHvAIqVeDdVWztybsTJD3u+Lts45mQD/ECxqDRYnhCcBr84fX/3
         msn1SEIiAIjr7uDb3rhEV3KbAzEysuFVVxLy+mFrhvgnJEMdOaSPOqaXP/aTFxWy6c
         ZqarZL/9bksysjb4ClL/p0C2beAZPmkzguLceysPOeqxY0PXGoriAsN2poekkRbDfF
         CZ4qlt1NMwQ8A==
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     srinivas.goud@amd.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20230518093927.711358-1-ckeepax@opensource.cirrus.com>
References: <20230518093927.711358-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] spi: spi-cadence: Interleave write of TX and
 read of RX FIFO
Message-Id: <168476574697.614040.7701862190333374068.b4-ty@kernel.org>
Date:   Mon, 22 May 2023 15:29:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 10:39:26 +0100, Charles Keepax wrote:
> When working in slave mode it seems the timing is exceedingly tight.
> The TX FIFO can never empty, because the master is driving the clock so
> zeros would be sent for those bytes where the FIFO is empty.
> 
> Return to interleaving the writing of the TX FIFO and the reading
> of the RX FIFO to try to ensure the data is available when required.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-cadence: Interleave write of TX and read of RX FIFO
      commit: 6afe2ae8dc48e643cb9f52e86494b96942440bc6

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

