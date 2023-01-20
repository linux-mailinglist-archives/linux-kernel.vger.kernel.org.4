Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057CB6755FE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjATNiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjATNir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:38:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6111AB2E66;
        Fri, 20 Jan 2023 05:38:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13DFCB81F57;
        Fri, 20 Jan 2023 13:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BBFC433EF;
        Fri, 20 Jan 2023 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674221923;
        bh=fArgNeWhoT2fBJVuU+kDkj/N4n0nAD98Plm5k3RHt7E=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=sQXmGWkMOOe5fpSb8TZ/qskOX9rAnODlCudp3vXI15l2i+z8QBPm4N74RIp8TIrJ0
         QZj6f5c8TW9UvOaW3c2C83IKfloiLi8To5iKhL/+zNOgrKg6BAx3f4hjVW8ViNH0JW
         sKPw1xTBzzmFub00lylImQGc6iyMtY1u0fQU9On6bjrCYiy+dDHs2iA0XmeHbqs06T
         Hsv7pN51/2kgVEVRkPNFmw/W+6J83njoQe3Pt/TUJNj72aXslrGZni7bGi370xHP1O
         8ZS9tyK4KVao61xZ5g9K2ArfJYEMG0kwx1xvsDwH0fEup9budas2LKKslx8qzC5DaN
         QwnSrwA45oF5Q==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120075651.153763-1-krzysztof.kozlowski@linaro.org>
References: <20230120075651.153763-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] spi: spidev: order compatibles alphabetically
Message-Id: <167422192258.1233344.8459489337894845300.b4-ty@kernel.org>
Date:   Fri, 20 Jan 2023 13:38:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-77e06
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 08:56:51 +0100, Krzysztof Kozlowski wrote:
> Bring some order to reduce possibilities of conflicts.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: spidev: order compatibles alphabetically
      commit: be5852457b7e85ad13b1bded9c97bed5ee1715a3

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

