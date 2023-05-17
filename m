Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF21D705DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjEQDRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjEQDRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:17:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7248D1BC3;
        Tue, 16 May 2023 20:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F07C36370E;
        Wed, 17 May 2023 03:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43F6C433D2;
        Wed, 17 May 2023 03:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684293461;
        bh=iFD+DYOWkfeczPPjNdnXp8SDy5OJDTWmunWJyEwuxQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EtrcOesYJl6GG6P4m3mD0bLmmE7MM71sTiX0A8JK6U1SGs2xbGUEIFhRNMl9O4TJ9
         5tHsCnjXVihnNg4m9DLHgIg9hZ6LKb7Y81TBFxthWJ+tx4Cylvtnn658y0Uxy+ZEh+
         FsIA8N1D0JghuMyjdaZb/r8ElJiR5ZL4dbEwKDAZfnFiOzhYXG7oBjWq8fM2QxVm2b
         dBXUUvGZLN+lxsVJT8E+P+kzn+AlTVfiyksrH1TnJ9eldsqLn1VDpIHMjk89XlPPuy
         v7h64xDRr0uJZ/fpprjCgCGDCwKWSoeeccAEb9N28NFQNEIpXfWyLNT6CnmttBCEJ1
         Lv7xQP1qFuYxA==
Date:   Tue, 16 May 2023 20:17:39 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     wuych <yunchuan@nfschina.com>
Cc:     rmody@marvell.com, skalluru@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: bna: bnad:  Remove unnecessary (void*)
 conversions
Message-ID: <20230516201739.21c37850@kernel.org>
In-Reply-To: <20230517022705.112448-1-yunchuan@nfschina.com>
References: <20230517022705.112448-1-yunchuan@nfschina.com>
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

On Wed, 17 May 2023 10:27:05 +0800 wuych wrote:
> Pointer variables of void * type do not require type cast.

What tool are you using to find these.
How many of such patches will it take to clean up the entire tree?
-- 
pw-bot: reject
