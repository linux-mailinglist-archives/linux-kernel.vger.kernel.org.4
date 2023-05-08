Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043F06FADC9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbjEHLiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbjEHLhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B776340213
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93E86633A8
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 11:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520C8C4339B;
        Mon,  8 May 2023 11:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683545834;
        bh=giVqtQlww6mIBA418bV1pWOnhuUCVDv+i6YbGkwJtIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXiao1YhVL6eTh3MNaEKIUedEvyr3hatiBqBSKPEdYDvMUArWL2VdKM9wgqm3QZvz
         gEbLHPxT9//yAy4gfWizRssAn716qqVvCD2xf135V5FjzbnQbKMgfeA4h1x5O+ujST
         JsS9ptczlcAeH2dqW/IBgQCaYTqioQZC4ImuWr+nTIEx9XeB7ANfstiunpN2BdWKo0
         rbE1KKK1BvSYdnrkgvBLM1a/Yf96FWaFpPX5TgQIZEVkTgOTlsf3ICd5ZoGSACT6QV
         5nyqTkVxVAp+1D+N/7tFTrFGHNFfe5ktt3uqOGjG7F7/JYI52v+LtfQKlGxLh9EOVP
         ZLcvnAFsQmN1Q==
Date:   Mon, 8 May 2023 17:07:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        r-ravikumar@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH v3 0/4] PHY: Add multilink DP support in Cadence Torrent
 PHY driver
Message-ID: <ZFje5Qs2o8DgOzlR@matsya>
References: <20230418173157.25607-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418173157.25607-1-sjakhade@cadence.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-04-23, 19:31, Swapnil Jakhade wrote:
> This patch series adds support for multilink multiprotocol DisplayPort
> configurations in Cadence Torrent PHY driver. Following configurations
> are supported:
> (1) PCIe + DP
> (2) USB + DP

Applied, thanks

-- 
~Vinod
