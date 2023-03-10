Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DEC6B4943
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjCJPK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjCJPKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:10:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F0312EAEF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:02:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60B41B8233D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1D1C433EF;
        Fri, 10 Mar 2023 15:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678460563;
        bh=rD7uHaTr84/DrLdgRVp00Y8+O40SUHVZfLkVyZSebx4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jKB4GRPB9kMli7vK5FWHPqXNier8azpYTpkazG74K7fRN7yYckay5BsmWrEX2ubqK
         SJ1BwLhQ0665GLeCdGZIWJzbmQoUBnojKOq7Z+B1Yt0j1HT9wVMOFHuDXBj9tiOK8P
         dh24wQK0nSbbJ3uHZCNNcpIp/u8Q+J3w8hKhSbgsDnKKun4PRt+ZUrRNZO7mEw8pt1
         alwCwMDcE+mAPEn4V62zuPhCY1oozhKJw6qMVsHgZXVcW/dabOtZTv1CqjAPbY66ww
         I5RFm2NGmQL3kJ9lya0Oi3sAAyiif+TGCh8F84QFBrE1QZNxgERECCnUPkC+s67eDT
         CC9zeSw/kp6RQ==
From:   Mark Brown <broonie@kernel.org>
To:     vkoul@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20230112171840.2098463-1-ckeepax@opensource.cirrus.com>
References: <20230112171840.2098463-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 0/2] Minor SoundWire Regmap Tweaks
Message-Id: <167846056128.924636.15059113415143446875.b4-ty@kernel.org>
Date:   Fri, 10 Mar 2023 15:02:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 17:18:38 +0000, Charles Keepax wrote:
> One minor correction to a comment and updating the allowed register
> sizes for the SoundWire register map, to allow support of additional
> hardware.
> 
> NOTE: The second patch requires the patch commit 62dc9f3f2fd0
> ("soundwire: bus: export sdw_nwrite_no_pm and sdw_nread_no_pm
> functions") from Vinod's SoundWire tree to build, so not sure if we want
> to push these patches through his tree or merge his tree across.
> 
> [...]

Applied to

   broonie/regmap.git for-next

Thanks!

[1/2] regmap: sdw: Update misleading comment
      commit: 6466b376e927d51ea3eadc1965714305d8c3c066
[2/2] regmap: sdw: Remove 8-bit value size restriction
      commit: 522272047dc631610dd180be0c3670043bcdf42e

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

