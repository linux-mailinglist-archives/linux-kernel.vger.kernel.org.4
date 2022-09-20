Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F885BDD95
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiITGrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiITGrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:47:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D29A5F122
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:47:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 235CA62441
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA29C433B5;
        Tue, 20 Sep 2022 06:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663656422;
        bh=SvXI7Ba7eKmCawLmelygwSy8WdDRklUMauHJ8UCmQGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LFmRt2FQfMHGJdtALu4/WlD8sRwoSENvlyWtrUk+nHQQcy9/1T1A936ja4g5inMBZ
         YymRVL6yAr4PXEtv1+wUwpYOXJLq36mF8abOihxKgHVHMF6jqSyM5HmUtpNjRXkdFN
         uQc+7lFAfaHMtwckoKTcsaO+DQdY+6+2b7XDkhm18JZmtXilPhh+4jH+/5uAmY/1p1
         TvpglsTrPsZ4PWo2IjoGUCGAzZhpEmVOVFGDHR1kmf6XF09ufLPS0TWFAymQqJhJam
         n2fz1hfJPCBwNjAZZVp8R0YmIoO4x8Dcd6vvlGrdyRucJ7XaE/jSgQEzzQl1ORZEq4
         IIrCOM+SKhiGA==
Date:   Tue, 20 Sep 2022 12:16:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Matt Ranostay <mranostay@ti.com>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        rogerq@kernel.org, vigneshr@ti.com
Subject: Re: [PATCH] phy: ti: phy-j721e-wiz: stop name conflict if multiple
 serdes are initialized
Message-ID: <Yylh4oW21zD4jUQf@matsya>
References: <20220909200026.3422-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909200026.3422-1-mranostay@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-09-22, 13:00, Matt Ranostay wrote:
> When multiple serdes instances are initialized the first will succeed but
> additional will conflict over clocks names and probing fails.

Applied, thanks

-- 
~Vinod
