Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B466DFBB2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjDLQrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjDLQqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:46:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0996376AE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66E3962DBF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE18C433D2;
        Wed, 12 Apr 2023 16:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681317938;
        bh=FjHFIZWg445rI5vxTZnUyscl1U/orLLI2DzJhhetNyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EI549Dxs8cx7q3xbAHAnMrSdRyFxNwhozAl2zsqM9yRKziarOPfYaZLofjZAE/xYP
         GStsFJvSR9p6PYjbbXuM1RPNXRKNo0HxbwTJRcqzeghbNZWrVQM5LA9+ypN9lh80BG
         zdpYQANQgxn79ri68/vDcbxzdnc81WR+oQOPdqDEYyBCa6QAALhyi09fM5u56OK1F1
         sjRgYLm3p4yIsYeKQWkZzT6HDbzbCoShuhbudv8X1meWBxCRi3peoPXWuH7uI7lu3F
         iILuw8dQbtvVgC/FmR3T4fGcm6r+FJeFOQ8Vdtb6hUy1lEWuUDRlYVDdPe3EMm0gxJ
         ng+he2NJ8X7IA==
Date:   Wed, 12 Apr 2023 22:15:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     kishon@kernel.org, rogerq@kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH] phy: ti: j721e-wiz: Add SGMII support in WIZ driver for
 J721E
Message-ID: <ZDbgLpCuDYAdELJA@matsya>
References: <20230309092434.443550-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309092434.443550-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-03-23, 14:54, Siddharth Vadapalli wrote:
> Enable full rate divider configuration support for J721E_WIZ_16G for SGMII.

Applied, thanks

-- 
~Vinod
