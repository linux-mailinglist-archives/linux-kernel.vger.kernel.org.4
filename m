Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888756F6D0B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjEDNly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjEDNlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:41:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913F5768B;
        Thu,  4 May 2023 06:41:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E91C633EA;
        Thu,  4 May 2023 13:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312F5C433EF;
        Thu,  4 May 2023 13:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683207710;
        bh=DJDo6blJUyZ26jvRtQx9meMVm9Jm3+X/4QmZCdg0Ekg=;
        h=From:To:Cc:Subject:Date:From;
        b=Exl+J+Ig2oThnjhMbmVk+ai7bDV2T+mfWcPcfgu08ST3bSqf1UFBeIbIxZ+LE6JLN
         jPyVQbkzU5GuiqI8c6ePQbDRWphDyRY1s4B5DcTix367JzPAxNfN5cJmTh1MxCO9ax
         0K6vIzf2wSTyPpp5djPE/YtvcjnbLITk02cUIVnzjRhquMcP+sRViH7vz7r8t2pXrG
         0QuBIGy9Pt/T7D5g5/rVvsPWRRTClv1GHjbuP+KmTHTxZw83rKF5MV8ndgnS0Dgdo4
         AKti65oXK/XDYUgeKfgjyOMjtFsZr7d0VSSGaO/GN7yqKr04Kq6glq08DBdETN4YDx
         wv2kp9FR12QPg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the pinctrl tree with the origin tree
Date:   Thu,  4 May 2023 22:41:40 +0900
Message-Id: <20230504134140.186048-1-broonie@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the pinctrl tree got a conflict in:

  drivers/pinctrl/pinctrl-at91-pio4.c

between commit:

  348551ddaf311 ("Merge tag 'pinctrl-v6.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl")

from the origin tree and commit:

  b7badd752de05 ("pinctrl-bcm2835.c: fix race condition when setting gpio dir")

from the pinctrl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/pinctrl/pinctrl-at91-pio4.c
index 2fe40acb6a3e5,e40487be20386..0000000000000
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
