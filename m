Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA7C653029
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiLULYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiLULYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:24:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AB42BD2;
        Wed, 21 Dec 2022 03:23:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52C75B81B66;
        Wed, 21 Dec 2022 11:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4A9C433D2;
        Wed, 21 Dec 2022 11:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671621836;
        bh=T8Xb8G9ELcWeE5lE+j/qJ4xxUFRQY2J2nS7Ryz4oKCQ=;
        h=Date:From:To:Cc:Subject:From;
        b=gZNjKI8e7nX0mjrn1nYErLDWIdf7ye+urgjLYt6eQkw9zX8FH/nYihl/GjoDmobAE
         3xSVu41UTeIPZHG7tr7wwmghIbj9BaqsB5GnUVQ/cHvg+7bYknqEoyDY4vNHAgTNEn
         +h6UEzEC/3czppyf3FEO+I/7qGYaBo/HP2Is0/wBF5hNnT6MoiWK2UMKy+qxcV+OWt
         XykvnL6GwY/DdSv7BTWHbaizUgqYAXTx9du/SQbI7xk83mjmgdjaAdO/g4dDPr1lCP
         4NxZUU6mskSKHXVkVmYIdRKUlRep1JeFrv6eh6Skr/O19ZtwvU3rPfS5J6XzGH2jEw
         Z3aiB0UZj1vMg==
Date:   Wed, 21 Dec 2022 11:23:50 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.2-rc1] media fixes
Message-ID: <20221221112350.6b046362@sal.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.2-2

For:

- A regression at V4L2 core breaking string controls;
- Compilation warning fixes on sun6i drivers when building with clang.

Regards,
Mauro

The following changes since commit cdb9d3537711939e4d8fd0de2889c966f88346eb:

  Merge tag 'media/v6.2-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2022-12-13 11:36:58 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.2-2

for you to fetch changes up to 542d3c03fd895eb8370992293498332ea383a3b9:

  media: sun6i-isp: params: Unregister pending buffer on cleanup (2022-12-14 18:12:32 +0000)

----------------------------------------------------------------
media updates for v6.2-rc1

----------------------------------------------------------------
Hans Verkuil (1):
      media: v4l2-ctrls-api.c: add back dropped ctrl->is_new = 1

Paul Kocialkowski (10):
      media: sun6i-csi: bridge: Error out on invalid port to fix warning
      media: sun6i-csi: capture: Remove useless ret initialization
      media: sun6i-mipi-csi2: Clarify return code handling in stream off path
      media: sun8i-a83t-mipi-csi2: Clarify return code handling in stream off path
      media: sun6i-isp: proc: Fix return code handling in stream off path
      media: sun6i-isp: proc: Error out on invalid port to fix warning
      media: sun6i-isp: proc: Declare subdev ops as static
      media: sun6i-isp: capture: Fix uninitialized variable use
      media: sun6i-isp: params: Fix incorrect indentation
      media: sun6i-isp: params: Unregister pending buffer on cleanup

 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c         | 2 +-
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c        | 2 +-
 drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c    | 5 ++---
 .../platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c    | 5 ++---
 drivers/media/v4l2-core/v4l2-ctrls-api.c                          | 1 +
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c         | 4 ++--
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c          | 6 ++++--
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c            | 8 ++++----
 8 files changed, 17 insertions(+), 16 deletions(-)

