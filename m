Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DB26F6D0E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjEDNmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjEDNmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D98E768B;
        Thu,  4 May 2023 06:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43FC2633EA;
        Thu,  4 May 2023 13:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD42C433EF;
        Thu,  4 May 2023 13:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683207728;
        bh=DJDo6blJUyZ26jvRtQx9meMVm9Jm3+X/4QmZCdg0Ekg=;
        h=From:To:Cc:Subject:Date:From;
        b=K7WCZbk05LdBU7Mm8SvHu9/VME46qPKNTwgovgONGZSUIAPjcohAxAF1ddbyQ/wnF
         QQ26ZGWF6i5GWVVi+VB98mI/XoEpD2uDAeGlzKrVLyaop8T0slwn6cU9RPR0chFLZC
         W6eI+a1BubMO+EJeU1JtOOj9rxceBWFDXLXmbLvIYr8cnkFkJwQtk1iYyOyPfga40d
         1XZHsx9SLa87I7ACime5MCUcNvc+QYXfPEs5QNIZC8CncpzUBCq0BPce/nDB9E37D8
         H1yK7zLQhjvJYV5ISwWza4Y817iugdx2ULX6mhbyAUwrGY+KAex013x6/9Fawm5aQn
         zMSioXc/9cYGQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the pinctrl tree with the origin tree
Date:   Thu,  4 May 2023 22:42:04 +0900
Message-Id: <20230504134204.186076-1-broonie@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
