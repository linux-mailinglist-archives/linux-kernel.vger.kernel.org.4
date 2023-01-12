Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3307566732B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjALN2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjALN2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:28:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3F338C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:28:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33C86B81E4C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF8DC433D2;
        Thu, 12 Jan 2023 13:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673530110;
        bh=16fVlm5BEAXD2CaeGyhk5GUo/dMIEWz6Tu0bVYGVjX4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Q94/u+zsIoRkMd+xoxUb25mks//iSKp3tt80MbmErAsiQAVksVIELpzMsnCQltIxu
         j0eCBiQNs2v1G9glvQlPFWj+yareBn3YdDd5Q1cAdhHu6afGWsPhbq97gzGpQ5pJKh
         ajquGxrW78RPx+Bfc3lhiW2oNMDRsQfNFS9OiJUNyeXpfErHW8luOgu7cMg5kbvJOh
         Jbl67UWH0fY7X8KGAOp0FwqKsXDim6CP/BhxEUiiSW2PBzH5XCItQDxnRZln4/pnKy
         EwBM3XvqojU6FJS1TQM2amiI2FcTPxgz3qp1ZC3wUxPCAbMKryTGoYbm2afWcFrB9K
         hePRIRAlt+prQ==
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20230112112356.67643-1-andriy.shevchenko@linux.intel.com>
References: <20230112112356.67643-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] ASoC: amd: acp-es8336: Drop reference count of
 ACPI device after use
Message-Id: <167353010930.1918645.13522071123192979685.b4-ty@kernel.org>
Date:   Thu, 12 Jan 2023 13:28:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 13:23:56 +0200, Andy Shevchenko wrote:
> Theoretically the device might gone if its reference count drops to 0.
> This might be the case when we try to find the first physical node of
> the ACPI device. We need to keep reference to it until we get a result
> of the above mentioned call. Refactor the code to drop the reference
> count at the correct place.
> 
> While at it, move to acpi_dev_put() as symmetrical call to the
> acpi_dev_get_first_match_dev().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp-es8336: Drop reference count of ACPI device after use
      commit: d784fc8be6814b31854f7b529919ca4506ff8066

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
