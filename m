Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0C07286B7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbjFHR5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjFHR5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:57:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0742D7F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:57:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AB0765006
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 17:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F97C433D2;
        Thu,  8 Jun 2023 17:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686247047;
        bh=YIiCW4z3PpE/Jz/FOGi0Q2PQGvY4remUjAECF1bRw7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2t6ngTF/qVXO9rVEx3HqJn+lp+2GgtUSwfXRvg9Tm3MKRBhy/Hr2PVvGzuFHM808
         QCOh/TxeeBbz9UhyAkQ8vNx/rHxhihBuo8nGTefJTQOcnXxR4h3p1AtvoBRcq/d32d
         tjd4lMK7Jw3wtEO/zaROIJ0hSawE7ximHqv1xssF24mvzazZGEx/UQRajXqb3X87PV
         +c9sOAdR/KoNCX+OVVkVCa9hEbiW9UW7TJwvlHn0/jb4yDvDpzgqyy7IngBXZ/MduK
         fjcBbqFoUX7OzBIVB24XgwrbAuDudkeSECvt2HANc41BYZmWymzF/nt+nTjbhMPDyw
         5jCtm0ot3yOgg==
Date:   Thu, 8 Jun 2023 18:57:23 +0100
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD and Regulator due for the
 v6.5 merge window
Message-ID: <20230608175723.GO3572061@google.com>
References: <20230427113046.3971425-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230427113046.3971425-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-regulator-max5970-v6.5

for you to fetch changes up to 49f661ba99324a3f7eef0befbdaa4f22dee02b97:

  mfd: max5970: Rename driver and remove wildcard (2023-06-02 09:09:45 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Regulator due for the v6.5 merge window

----------------------------------------------------------------
Naresh Solanki (1):
      mfd: max5970: Rename driver and remove wildcard

 drivers/mfd/Kconfig                        |  4 ++--
 drivers/mfd/simple-mfd-i2c.c               | 18 +++++++++---------
 include/linux/mfd/{max597x.h => max5970.h} | 16 ++++++++--------
 3 files changed, 19 insertions(+), 19 deletions(-)
 rename include/linux/mfd/{max597x.h => max5970.h} (92%)

-- 
Lee Jones [李琼斯]
