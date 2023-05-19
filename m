Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995AA70945C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjESKBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjESKBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:01:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14283101
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:01:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4ED5651D1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BAFC433EF;
        Fri, 19 May 2023 10:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684490508;
        bh=H8RMAZL7xHu9vWV/p6h3V7y8VIc6YcFhh9uGGULvGrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOMzZeTmosNPzqskREMLJdn09AQKqz/J2haccdORRUcpYfObqPXL/3SrGsph0/Bot
         vAVCPLJlALNeJtBLu+2EmjtPxF41flQW79LAzixck0ikdSeXNbUOXPmq5U2XQPiGDO
         a/9GlcSiYGNPkCkAoUKlLkmBLpX/lIW6fzmcXT1+UDZSmJnr1hXqBk5N8VJ/Oh+uU3
         F8EMl/cLmfiN69XqQzb/kSO4Lh68CrGaZjccpmaP4nzxk9tBoHLsfQwVKKE4pC2+TU
         gjK88t0317FuIVnPVaXtpkHVm+mUYcXPNSQ/wrFFi7+5tShApOoCsYhJGBVQyGRnHA
         hVwG75x5mhVyQ==
From:   Christian Brauner <brauner@kernel.org>
To:     anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] ntfs: Remove unneeded semicolon
Date:   Fri, 19 May 2023 12:01:39 +0200
Message-Id: <20230519-gebinde-piloten-ce29e4cdc4a8@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221105153135.5975-1-dengshaomin@cdjrlc.com>
References: <20221105153135.5975-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=708; i=brauner@kernel.org; h=from:subject:message-id; bh=H8RMAZL7xHu9vWV/p6h3V7y8VIc6YcFhh9uGGULvGrc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSke3z7fTNKOmHtQe8Vt7aYNHzkCUhRvsp1I61W2urgHJX7 P58adJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEoIqR4fy0v4/3l+3YWRu44ZP6Cv Hmn1k/lD5XTkyVrZ3yS2Nq2RtGhgnXOIVX6VvsnylaeFjK5Ff86gyDR3ef675fvodP/Ft5JSMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Nov 2022 11:31:35 -0400, Shaomin Deng wrote:
> Remove the unneeded semicolon after curly braces.
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

[1/1] ntfs: Remove unneeded semicolon
      https://git.kernel.org/vfs/vfs/c/6405fee9b0d0
