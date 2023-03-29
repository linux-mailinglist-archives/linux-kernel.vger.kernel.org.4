Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A42E6CEFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjC2Qv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjC2QvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:51:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1325264;
        Wed, 29 Mar 2023 09:51:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D81561DC7;
        Wed, 29 Mar 2023 16:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9250EC433D2;
        Wed, 29 Mar 2023 16:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680108660;
        bh=gfR+Av/dK1tTf1rXGgKZU7TIYCGAdnShcte6WdNtArA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pOGp8cWzppB2no8EGLqn3n9hF3bsKQ1HCdG3RlGcKmcJiPtalMqY1Y+TD7BucRgOQ
         Ll6eM2U/LX/NxPeJVYw2aUahOGQA4fBfW84pukfz/LPUQY0buMdFAWMlvjNYWmph9T
         faiDfYVksxh6xsD6pF7fe29QlEBmvR68xHb7NVpYRUqUz2l3FhZU8PTw8MrzSRT9fi
         RH0oHqsSomDyuc7UOOnLrNCzDHUOJUlXpyyBNG9C+qc9xJ+l4NAlB+EXIhXWIaRGdR
         rRZhF07ZUS44pL++/vHx4pku7soDzVSJnZAyuXAlboQi1ki6VAc9nYB7/GMV73Wz2+
         6zlj7fDkrvW8w==
From:   Mark Brown <broonie@kernel.org>
To:     tudor.ambarus@linaro.org, Yang Li <yang.lee@linux.alibaba.com>
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230329062450.58924-1-yang.lee@linux.alibaba.com>
References: <20230329062450.58924-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next v2] spi: rockchip-sfc: Use
 devm_platform_ioremap_resource()
Message-Id: <168010865827.3244769.13335044779439529619.b4-ty@kernel.org>
Date:   Wed, 29 Mar 2023 17:50:58 +0100
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

On Wed, 29 Mar 2023 14:24:50 +0800, Yang Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_ioremap_resource(), as this is exactly what this
> function does.
> 
> 

Applied to

   broonie/spi.git for-6.4

Thanks!

[1/1] spi: rockchip-sfc: Use devm_platform_ioremap_resource()
      commit: 526c2966fca3337f01c513b1f0d85c839f8d8175

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

