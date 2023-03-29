Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66896CEFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjC2QvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjC2QvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:51:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D60765BC;
        Wed, 29 Mar 2023 09:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AF8E61DC2;
        Wed, 29 Mar 2023 16:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABC0C433D2;
        Wed, 29 Mar 2023 16:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680108654;
        bh=1OdilLh0Oc9OKO4vhNIy08dltVZuEC7oAgkiWG2znno=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eZPnXKTLT7bxKCUFpBCvpFqysZdb3Ed8NgJv2WWo2LozEFhBfzOfHmXSIXDFE7UYq
         RfPoRVVaHR9TOxkEuqRMhxWaUky/eTlOjLlOXZhPZJGEWMEUOyeZONcCPdJ91C9eD4
         hdl6vRhojrmnkahYIBjKoFCuagF1QPDYoKH2XB7BJGD2I1+DjKwVGpKxK1IUIAaANH
         Tqm+hFHvm9+UbnwDqnGzsGeSGKM46XcfA2bEpwY1+pBLdQLlJ0q4T3yrJ15UP0X/pG
         +sxhzn2s+t7QJ6GUqSNbzm29gDNQeBRjc74UmnensEwf8IKitOpJcUTa0uQRjitIo2
         iWbTRE/JtHz8g==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        cy_huang@richtek.com
Cc:     lgirdwood@gmail.com, jeff_chang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <1680050606-461-1-git-send-email-cy_huang@richtek.com>
References: <1680050606-461-1-git-send-email-cy_huang@richtek.com>
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: Add Richtek RT4803
Message-Id: <168010865187.3244725.7745538103097035182.b4-ty@kernel.org>
Date:   Wed, 29 Mar 2023 17:50:51 +0100
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

On Wed, 29 Mar 2023 08:43:25 +0800, cy_huang@richtek.com wrote:
> Add the binding document for Richtek RT4803.
> 
> 

Applied to

   broonie/regulator.git for-6.4

Thanks!

[1/2] regulator: dt-bindings: Add Richtek RT4803
      commit: e126cdaad15c4206f27b450e5d87391d5066615c
[2/2] regulator: Add Richtek RT4803 boost regulator
      commit: 6928a3c082f19404bd41bf33beeae112915dc666

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

