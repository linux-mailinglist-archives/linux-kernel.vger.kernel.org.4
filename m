Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD746CAB9D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjC0RMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjC0RMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:12:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5670D268B;
        Mon, 27 Mar 2023 10:12:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 177D9B8109B;
        Mon, 27 Mar 2023 17:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E84FC433EF;
        Mon, 27 Mar 2023 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679937131;
        bh=/fkXqbvEz458bP8DZWcuJn+D7WQRsmI1RDlpr7SMO2E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=D/fBxbp53rYnOv6c8w4Qvq4Ed+VnhALr+D8DwFDMuxGrjTV1sDK06wy9SPPfRa6NM
         x3CSZB1cMD0h9PQxfMRrZP0ojOkXuihTH3hqGddD7+8oWVdDvl1iZvz8UfZDWZAklF
         q5FcBB9eS+L54T/MyaJYmILY2Gb0klCClI3qKeABgyTZi9LZweUqDx+TZIdkcH6Mn+
         /PvfnYORZVW0mfqX4g/GdGbNsctFUSzDJV3zIi4qMHsLudfK/hR8KnyRlBZoRwfRiv
         F/GAC0vklwCCsnwASVe1EvqpjjWXsvhMbpbP3f9o7FVAHxu419A94RiILXcF0Jtgte
         O35bW0r3AMzaA==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230327055346.76625-1-yang.lee@linux.alibaba.com>
References: <20230327055346.76625-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next 1/3] spi: omap2-mcspi: Use
 devm_platform_get_and_ioremap_resource()
Message-Id: <167993713015.3172134.12238753210466816048.b4-ty@kernel.org>
Date:   Mon, 27 Mar 2023 18:12:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 13:53:44 +0800, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/3] spi: omap2-mcspi: Use devm_platform_get_and_ioremap_resource()
      commit: 5e72620125dfa6b876ea3fe3ad25e4c11b70615a
[2/3] spi: orion: Use devm_platform_get_and_ioremap_resource()
      commit: 36b49126afa22b7f9fe3b16360ef2ab3da6bc376
[3/3] spi: pic32: Use devm_platform_get_and_ioremap_resource()
      commit: d10c878213b0bd2df18639f62af28e93a36d437d

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

