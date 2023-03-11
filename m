Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40B96B5FE6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 19:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjCKS5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 13:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjCKS5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 13:57:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4534608D;
        Sat, 11 Mar 2023 10:57:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FE6D60D30;
        Sat, 11 Mar 2023 18:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A245BC433EF;
        Sat, 11 Mar 2023 18:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678561067;
        bh=Lqr4OX3chGWwRIC8mFZn6C+4F3L6FUhyrcaMkKNpyBE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Mxopg+hHvSl30fD9UUm4zdgn0fFEQHDLyNs3b0Jdpqduaqai1SiCON8e+VjmiPdCZ
         V8PmQtAc3J7iPhoVFiFi9QN5axzL6G1KFnn8PGLmF5UeLz4JAAzAgUtBcsD8XnZl43
         s/oRDxdvxpiKjh10Gl1R0kA68t94EYIKdklzR6KwiH1uGK+lUyaZTLiXwUSRvgOJ//
         U5/J+rHYecfOmp8nT1o+vJRb2AyKlp2XUQk3klnrfnF4caK7G7vl6/dQCtw7Afvx7A
         6bbSEYn5A0P4/uS2f+KYKYm6+W0k1EZNgSSsz7iG1fSVtfWS2M+Ei5Ab3aaPMqCcff
         zlFLOLTpw+97A==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230310144721.1544756-1-robh@kernel.org>
References: <20230310144721.1544756-1-robh@kernel.org>
Subject: Re: [PATCH] regulator: Use of_property_present() for testing DT
 property presence
Message-Id: <167856106498.960737.3108647307474639813.b4-ty@kernel.org>
Date:   Sat, 11 Mar 2023 18:57:44 +0000
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

On Fri, 10 Mar 2023 08:47:21 -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: Use of_property_present() for testing DT property presence
      commit: 7dda20c97fac52948b948e15e1173ee57c66ed35

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

