Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF77172F2E9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242219AbjFNDFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjFNDFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:05:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE0A10D8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A40361654
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16113C433C8;
        Wed, 14 Jun 2023 03:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686711909;
        bh=xoHQmnYmJ6KBtKA70fFzukdRNsmAvtvdjH+4lJYpfs8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H8AjZnOE3c4oFK069c25pRamwKCTAO3UFDBCBBfL8iGkIzl6+RSBevwcnMLPF5Zbb
         FY8iHS3XT+rAxvS0X1rQgVCdCGGY53I2vP0GpcIS9ckB8GfUGwr7y8O/Bbb1I+OpEA
         xtcLZ9nIGmTe4cI9F26keoIOSnVhGl7b1mC97WwJ3iXo6JgnP9Y24rW9HYfPw73kji
         7Bb0AnJC9apV2pILWcF6PUwyD8TRI1ln+Hfh8v0QJCT7bpOoiespzMBJJ8qaoYpwye
         sMFq+yxG4CD3/eQL/9+Dz8i8/WDfICKOuNoOwT9n7WQeFhYKWJgE4xZh+t0UCdx6R6
         YFfAro/NQYUrw==
Date:   Tue, 13 Jun 2023 20:05:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     baomingtong001@208suo.com
Cc:     rajur@chelsio.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: Remove unneeded variable
Message-ID: <20230613200423.5114ca53@kernel.org>
In-Reply-To: <da4db284f25d227586a0e45c910eb402@208suo.com>
References: <20230614014154.59776-1-luojianhong@cdjrlc.com>
        <da4db284f25d227586a0e45c910eb402@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 09:44:22 +0800 baomingtong001@208suo.com wrote:
> Fix the following coccicheck warning:
> 
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c:640:14-21: Unneeded 
> variable: "fw_caps".

Please don't send these kind of changes for any code under net/
or drivers/net, it's pointless noise.
