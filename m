Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BBC68DC6F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjBGPGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjBGPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:06:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5D415C93;
        Tue,  7 Feb 2023 07:06:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 615FE60CF2;
        Tue,  7 Feb 2023 15:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A4AC433EF;
        Tue,  7 Feb 2023 15:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675782365;
        bh=YqDF29yTDTzZofC0OrRusN/jw+sSqFWwWjB3YnAN8mA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=asZxJim1OThPT7N/ebQJty/PhYOPN7aFj6sKP/aVDIQUStFsecBWjYU/z1Fwo4eor
         6ElGV8nV1q4aW+V2wdnhw7ENQbNQqV5fVShFAZRy5vAFuFaU3miDJKqOQYnAE5mD/P
         vCvk5dFDVixQFm4zarCpiEraFsialIIpxdIHrAoBxmldRTYNwRxUNU+jHEQUqV8LBW
         MA8X0lf0/kfczCAOln2DWdu4hac1ib2WjoD1HploTeNTz+P8BxL3QqPjjRnjPY1kGN
         O06lj23OOqxzUp9BStpP+K+64A38HMwWIhbbrUnlNS938ik+nXlmz9H5vdQKG21cRO
         iTTTOoHtOR3nQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230206153449.596326-1-jbrunet@baylibre.com>
References: <20230206153449.596326-1-jbrunet@baylibre.com>
Subject: Re: (subset) [PATCH v2 0/7] ASoC: dt-bindings: meson: covert axg
 audio to schema
Message-Id: <167578236315.223502.6627129328138282057.b4-ty@kernel.org>
Date:   Tue, 07 Feb 2023 15:06:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Feb 2023 16:34:42 +0100, Jerome Brunet wrote:
> Convert AXG audio dt-binding documentation to schema
> 
> Changes since v1:
> * Drop 2 patches applied with v1
> * Drop node name patterns
> * Fix examples indentation
> * Yaml fixups requested by Krzysztof
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: dt-bindings: meson: convert axg tdm interface to schema
      commit: cdff91122de52f480bea730fee6665a7404d758c
[2/7] ASoC: dt-bindings: meson: convert axg tdm formatters to schema
      commit: c5536e7be70cf2ab55c674b3c2120565e9559c50
[3/7] ASoC: dt-bindings: meson: convert axg pdm to schema
      commit: 4d37c72ec42374c5ad416f851b572a9fb794e8ef
[4/7] ASoC: dt-bindings: meson: convert axg fifo to schema
      commit: 6b6f5ea7ab0062d152a3bc9192cee45c7fc31387
[5/7] ASoC: dt-bindings: meson: convert axg spdif input to schema
      commit: ede6aa4087abfac527267c4ac5bb6eebdfe958ba
[6/7] ASoC: dt-bindings: meson: convert axg spdif output to schema
      commit: 32f7b9102bfc48a210bf655e049145f6450b03a0

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

