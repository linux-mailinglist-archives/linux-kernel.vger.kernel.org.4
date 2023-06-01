Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C2671F338
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjFATwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFATwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:52:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB95A18F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 12:52:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6016560C3F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 19:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3053C433EF;
        Thu,  1 Jun 2023 19:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685649164;
        bh=4tilUvTgBjM29OIuZO83iumRSgCl/pt+Bufh787UBrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNj2MAbcvqc6nlP6wQ8nUP9aH8oaWGV8dnw6qRKVMs0fUFghMSpFljYfNLEum6S/y
         ZpOEsnO/KPcnZnJtEm4nmgny7BYK6JqHJ4l0wV3KSqzrgWjnKFmHzCy+tmkbwUuEo2
         z6mqn1a+3ld84M8N9cmyjelLFBTngfC3vhFKB8LUOkhC78xUPTlUFnx5oBbx2+sAOj
         SffLG7TA0GK8f0OOjBPKbVVIJ384R1nh2KhWbCq1Q1i86J16w87jO9OBxQaw6MjOsf
         dk/t9gDDpBiROOR4csEZoG82Ki3vQKzT15jA5oUOs1BhVutKg4yk/Zq90IzR+UXN96
         HEi/7Pdm9yQhw==
Date:   Thu, 1 Jun 2023 20:52:39 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Mark Brown <broonie@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD and Regulator due for the
 v6.5 merge window
Message-ID: <20230601195239.GM449117@google.com>
References: <20230524000012.15028-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524000012.15028-1-andre.przywara@arm.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To whom it may concern :)

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-regulator-v6.5

for you to fetch changes up to 75c8cb2f4cb218aaf4ea68cab08d6dbc96eeae15:

  mfd: axp20x: Add support for AXP313a PMIC (2023-05-25 12:35:57 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Regulator due for the v6.5 merge window

----------------------------------------------------------------
Martin Botka (1):
      mfd: axp20x: Add support for AXP313a PMIC

 drivers/mfd/axp20x-i2c.c   |  2 ++
 drivers/mfd/axp20x.c       | 78 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/axp20x.h | 32 +++++++++++++++++++
 3 files changed, 111 insertions(+), 1 deletion(-)

-- 
Lee Jones [李琼斯]
