Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00DF61DB06
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiKEOkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEOkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:40:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A15DFBB;
        Sat,  5 Nov 2022 07:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8208CB8016A;
        Sat,  5 Nov 2022 14:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961DEC433D6;
        Sat,  5 Nov 2022 14:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667659220;
        bh=29M2448cgOHYMEKXGsRwTgE8lDNz4UjpIrZVsELUkhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bflqU6waEXJqA6CNM09mtvnNt/MZZikccFuzmCnxFLkmYKiXy63JrPY+t+MzZ1oYb
         OtC6+GcrwZxIoxEp0Ki+TTNKl/0CV/GJuC4ybq2IO08Q9JNNMTUprs3GgwAS3gEfEL
         wRR8wkvsro/j4Tw00v1LhsZhbU3wvYmSzzipipcbOnL4kxLQ6cvWBfEiuGlcrD3ufY
         SVtxrSpCKYnLNW3rerKUzP9hk4Kqrla9CB2eKcPuBXstLq+E7bffk55hgDD5ciAf4h
         H2yRtkqw8GxU0j+v9IjCoQC4QF0FR6HVRmJwHUmgCYvtnWBsRtKMQq/VYCOaq/DHSH
         m8pnSqQCFUjtQ==
Date:   Sat, 5 Nov 2022 20:10:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wayne Chang <waynec@nvidia.com>
Subject: Re: [PATCH] phy: tegra: xusb: Remove usb3 supply
Message-ID: <Y2Z10EDPOwj5X2yX@matsya>
References: <20221005084031.2154251-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005084031.2154251-1-haotienh@nvidia.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-10-22, 16:40, Haotien Hsu wrote:
> From: Wayne Chang <waynec@nvidia.com>
> 
> Remove redundant codes for getting the vbus supply of usb3 ports because
> we get and control the vbus supply by the companion usb2 ports

Applied, thanks

-- 
~Vinod
