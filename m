Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BAB6E0F80
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjDMOCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjDMOCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:02:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F79113
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C94863EA4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 14:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D31C433EF;
        Thu, 13 Apr 2023 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681394564;
        bh=toUJAtCrtg8LEJy9Yrb0cmiaJy1wTLCM49brD95V6HA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VSKEM3cqD8z8wYXLcbj567Z2lKWJgtfVQQZqIUM3sbydPQ4AmsoMPnQ2GK+UV8djQ
         NNicdq3ZXJNFOm4gZCg8+0rV3MryNpENJYHUyVmLv0ciY7DOb2TXovz8Hx7wYJOx0z
         +/QfP1HaF08QMeeXEKdw9o05MB5v5ggM4Rl8O8ee+3J0VpxM4/uGDUVEWENnKNxoYc
         xlwY+iKNypf8PxGqXI5vlOmwF8HeRX2uNXYLsnipSbA2mnB08aBDT/4L1YrCduBNea
         J2RQpy4lv/L/ZcIDZzApX7Bu/FsUv3wLfimbam4yXhtfNbm0zJUJG6L/5QxeW9lhen
         qCDgt+TvT581A==
Date:   Thu, 13 Apr 2023 07:02:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
Message-ID: <20230413070243.4fa2fd6a@kernel.org>
In-Reply-To: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
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

On Thu, 13 Apr 2023 14:40:25 +0100 Robin Murphy wrote:
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Tested-by: Jakub Kicinski <kuba@kernel.org>
