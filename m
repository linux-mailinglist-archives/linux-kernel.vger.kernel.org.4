Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FAD708E02
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 04:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjESCqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 22:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjESCqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 22:46:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68520E4E;
        Thu, 18 May 2023 19:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDAE8611E2;
        Fri, 19 May 2023 02:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2B0C433EF;
        Fri, 19 May 2023 02:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684464389;
        bh=HzVlejBquU/mmb9N9LGZsXPzxTgiTeUltfg3wkB5enM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JhsZps5y3teN7o2Ub3gAIL2XQCJvqlWWYqZ2xtzU5BJXtYcVL9XMJPOBN9lMJi9mU
         QUkFMTyPOSIBWgDONh14j0KxzOLvTiOkLCVPQtLwq1ySN4fTU5b8kw2CqIR3Lyzybt
         KgXdkF9rvq5usZ8xfj+vC5YeE6K5zFGofP6WDpTAZEhVOc0AuY67kxUB0ZiU1SpNP6
         SxeLTNagpcmrUxnDTdPVx52iqvEcgNEUgfV6/FUuGiZqKOoeS/elhLwtWRbqJ22mVj
         3cPiKKnIqxaPy9CvUbzmbvknoH2gmff0lVldsFohSwvdv6do4igJaCdGQ8LoHgu0WA
         kjkMU9yhd5hHQ==
Date:   Thu, 18 May 2023 19:46:27 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     yunchuan <yunchuan@nfschina.com>
Cc:     rmody@marvell.com, skalluru@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: bna: bnad: Remove unnecessary (void*)
 conversions
Message-ID: <20230518194627.4f9a6b04@kernel.org>
In-Reply-To: <f65fe4d6-7877-fd70-9e26-e94b4ebdde38@nfschina.com>
References: <20230517081801.508322e7@kernel.org>
        <f65fe4d6-7877-fd70-9e26-e94b4ebdde38@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 09:38:49 +0800 yunchuan wrote:
> >> website: https://kernelnewbies.org/KernelJanitors/Todo/VoidPointerConvs  
> > How many of such patches will it take to clean up all of net/ and drivers/net ?  
> 
> I have identified 48 areas that need to be modified using the script, 
> and have not yet confirmed whether all of them need to be modified.

Once you have worked thru all - please send the changes in series of 
10 patches at a time.
