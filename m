Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7CA709455
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjESKAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjESKAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:00:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB406A1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 503F060AC4
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2443FC433EF;
        Fri, 19 May 2023 10:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684490412;
        bh=Jt01WD+DZmPb38Aqq42Rz3mA4MlJJbpR42M5xl7K4i4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TzlhkBy5dnAiIM8pLXlz+m8/mnihKMtxHPywRC1Fz7daHbSQBBwK10FfbwahvZpPt
         yUj41D0Uno3Lv5IwLf86/foBhzXkEPQitms1aHwvVgHruZ3cRnb8OUHE6uuS+bTXJ6
         x20K502TQC78Mup61yqOWb0aRDYsyQeD7FPddWSafQrplRZK6X95DdgXpr3lCLA87b
         fL/v5p5U93VpKT8jvGtu6tP7fKAHmRZx88GE8BFmyG9MBC0dJoveapFFjEG5eo2HTr
         H5FGJmZJ2U/JCPq/xkgJWmsFYEjKCy2bbr8WUJ15tdB5DZXUIXWD0OfLTXvV5yTy4c
         NxldSBw8ciAkw==
From:   Christian Brauner <brauner@kernel.org>
To:     anton@tuxera.com, Deming Wang <wangdeming@inspur.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: Correct spelling
Date:   Fri, 19 May 2023 12:00:06 +0200
Message-Id: <20230519-buchmacher-daten-1b5e5ce7d61f@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206091815.1687-1-wangdeming@inspur.com>
References: <20230206091815.1687-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=681; i=brauner@kernel.org; h=from:subject:message-id; bh=Jt01WD+DZmPb38Aqq42Rz3mA4MlJJbpR42M5xl7K4i4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSkeywu2a+St+P9CX7VnmgT87Or1ye/uRux9AWbtMj6zQv7 7/1Y1VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRun6GP7xiTFdmtVw5cyzOhGXGI9 P/k+UPvtaI82Nl/uGn8N84qYiR4bPYi8CPL8pY1XnVOloak3ttdp6d+Tj8erR7ooZImuJ3dgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Feb 2023 04:18:15 -0500, Deming Wang wrote:
> We should use this replace thie.
> 
> 

Applied to the fs.ntfs branch of the vfs/vfs.git tree.
Patches in the fs.ntfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: fs.ntfs

[1/1] ntfs: Correct spelling
      https://git.kernel.org/vfs/vfs/c/253f3137ebfd
