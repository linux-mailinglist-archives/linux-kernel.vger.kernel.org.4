Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE6F5B5767
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiILJrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiILJrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:47:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189E833437;
        Mon, 12 Sep 2022 02:47:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D05B7B80CAC;
        Mon, 12 Sep 2022 09:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01499C43470;
        Mon, 12 Sep 2022 09:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662976029;
        bh=73e6jktn30rL4M3qmP6vMz0NvkYREdBKcFnFfXbAHg8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FlQXOwlXlyOmcKvqWfSFzV1aZ+1zJum6NXi/2kzzCXzF4M4OIiL+JQ8lKv/cgXKDj
         Tcyy54yozwXLjySkswm1hxndZAuZJxAl+LOBS4k9Bdg1cS1Qi2v6MCT1Hd4eTxs2/J
         ZgrTHc/x4kZuC9LpemlxeMIs4LsKGVU6jM5VTvT2zSmeKEszInJ85JDtdYdplVGp6h
         q46h6MWexga2prb4OePzhPbVQZtO74zvHthCUMmL2AdaEYsJ+t/7o8RvPC/zdMTH+7
         3Yxj3iJxVi/LlB9nefdfWvHuGp96bZJPaV8UM+u4bhQkaxwj5jPq12ViKO0Gt7ahzj
         WviYHg8xWMXkQ==
From:   Mark Brown <broonie@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        heiko@sntech.de
In-Reply-To: <12af4fe6-4d35-cb4a-f5f6-06e3aba990cb@gmail.com>
References: <12af4fe6-4d35-cb4a-f5f6-06e3aba990cb@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: spi: rockchip: add power-domains property
Message-Id: <166297602779.48440.1398773429375792864.b4-ty@kernel.org>
Date:   Mon, 12 Sep 2022 10:47:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sep 2022 19:58:39 +0200, Johan Jonker wrote:
> The Rockchip rk3399 TRM mentions that pd_sdioaudio includes
> sdio, spi, i2s and spdif. Add a power-domains property to
> to match reality with spi-rockchip.yaml.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: rockchip: add power-domains property
      commit: 83e5335bf58b090b1fc0b30cb1a1fedf07f0c217

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
