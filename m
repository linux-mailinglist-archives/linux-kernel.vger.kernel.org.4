Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474446C4C74
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjCVNxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjCVNxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:53:06 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFAA45D75C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:52:50 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 2B1EA242DBF;
        Wed, 22 Mar 2023 14:52:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1679493164;
        bh=9yWRBpoVvxeKLMGL+P9NNJ0mmKe60w5zWL+Wt/uaLqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hTLFyAZBp+DzV5r7u1zD+je2RjLjo5WyZ0ifGSwZyY3A/kL9c0vD1vzJRUq9pZTHd
         ORmhWcR9X1Rw1ppaxvQwg6cz6vsJWV+jC9TGHAcGju6dOCKa62wnbfgDCD5rVvnFOT
         y+uWm5S4TMP35cnf5AGaEKAHE77BjterHiw0EEC0kOC2SDxAUuvmh8fE33MlZhvtyz
         M/xW3MTFjjm79DSl9m6QYVoqTZwlBLl1VX4s0dQuGkg4H8LctXfBrZ5jpGsWwBXARz
         BMe05o4m4E/5R0YSu5jB01A1OsVawzddgzRLDk4xtcHnDpiesbURZClQvFRcKHQLFu
         VEtYIyU7FtCkA==
Date:   Wed, 22 Mar 2023 14:52:43 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Spelling s/cpmxchg64/cmpxchg64/
Message-ID: <ZBsIK9653BX9rgWD@8bytes.org>
References: <eab156858147249d44463662eb9192202c39ab9f.1678295792.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab156858147249d44463662eb9192202c39ab9f.1678295792.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 06:17:08PM +0100, Geert Uytterhoeven wrote:
>  drivers/iommu/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
