Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54B5689C4E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjBCO4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjBCO4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:56:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C6E8B7E9;
        Fri,  3 Feb 2023 06:56:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39F6B61D94;
        Fri,  3 Feb 2023 14:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D1CC4339B;
        Fri,  3 Feb 2023 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675436163;
        bh=bHTwdQUfTMFSZm5VtpOoEQH5hZ/O5gwP6aGVUcpUMpI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=T2KVSpJUj9K690EgAN5EuTtJGGxDCTHELFkwiKcrgx8WIw8ACPr0OdzILjMcuGVHH
         w/nwhMDgvMyG5luAYTt/Atp0Fkwe02Dc2ezLQseA0dVRCUXnlpJ+9ea6glnCUfRbmh
         yKKRudgzhFJoKR2Z9gb8CWEql9vGIAS7FC1Z/ViFNF5dkvryXoelnQPi9nP9nc+sUK
         VUma/CzQzhj+1cbiU0aTddu23R3ZpzjCOmFiPUlxgrQDbNDzVXXRmic06VuWh7O0i8
         ezt45RNs1R4ZaOpniUVkHtYwS4gS/5/+mfY97oIpNvzPGJ8OGED9v6CjOuPbDIlOG1
         nARdhXFeG2IwQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230202183653.486216-1-jbrunet@baylibre.com>
References: <20230202183653.486216-1-jbrunet@baylibre.com>
Subject: Re: (subset) [PATCH 0/9] ASoC: dt-bindings: meson: covert axg
 audio to schema
Message-Id: <167543616131.928818.17902040818579023398.b4-ty@kernel.org>
Date:   Fri, 03 Feb 2023 14:56:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Feb 2023 19:36:44 +0100, Jerome Brunet wrote:
> Convert AXG audio dt-binding documentation to schema
> 
> Jerome Brunet (9):
>   ASoC: dt-bindings: create component common schema
>   ASoC: dt-bindings: meson: fix gx-card codec node regex
>   ASoC: dt-bindings: meson: convert axg tdm interface to schema
>   ASoC: dt-bindings: meson: convert axg tdm formatters to schema
>   ASoC: dt-bindings: meson: convert axg pdm to schema
>   ASoC: dt-bindings: meson: convert axg fifo to schema
>   ASoC: dt-bindings: meson: convert axg spdif input to schema
>   ASoC: dt-bindings: meson: convert axg spdif output to schema
>   ASoC: dt-bindings: meson: convert axg sound card control to schema
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: dt-bindings: create component common schema
      commit: e398bbb9834a2f6cbe27cbd72956159ecc92055f
[2/9] ASoC: dt-bindings: meson: fix gx-card codec node regex
      commit: 480b26226873c88e482575ceb0d0a38d76e1be57

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

