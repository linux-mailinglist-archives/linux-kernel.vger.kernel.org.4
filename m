Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABFA6B5FEA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 19:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCKS54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 13:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCKS5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 13:57:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC0F32CC5;
        Sat, 11 Mar 2023 10:57:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE07F60D30;
        Sat, 11 Mar 2023 18:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1FAC4339C;
        Sat, 11 Mar 2023 18:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678561070;
        bh=xaHRhiudUrbS+WkqUe8mCCCOPn8t0yaOAzuTsE+qPwk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Pmhq+ipUicTMrtC7sWL3GgvGORYYsnb9be/+5LuGSHPh6uP36Fzlntpm58qIPpyQF
         xbxhc9UR6QsFRd1Db/SUcbfC1FhffD21PYNk3QaHaPKeHaPjMJxXKLC2XaIZAEHRy/
         fHSSdJJ8N3rrqH0b2wK7F/GlizK0DfAqGyNbjpuMeJ4dw6Iakh41v0cy0l78W9e0FX
         6D7bC5df2Aae9CIVxqbSXx9ZI5zsznL1tDoD5ZhSZ3sg/LF8pPT15oIe6wV7jYJ68y
         /AIEDxqIWsiq70c6ijs7ZhnajNgPgHfYKFo0rmihbdoQcK1o4jAZWkGunPP0eIJJTt
         ixLqtdSBHqSlg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
In-Reply-To: <20230310144722.1544843-1-robh@kernel.org>
References: <20230310144722.1544843-1-robh@kernel.org>
Subject: Re: [PATCH] regulator: Use of_property_read_bool() for boolean
 properties
Message-Id: <167856106679.960737.10591965547383927223.b4-ty@kernel.org>
Date:   Sat, 11 Mar 2023 18:57:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 08:47:22 -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
> 
> 

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: Use of_property_read_bool() for boolean properties
      commit: 5bd73a162bc881dbb98ff9909dd865286852ee2b

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

