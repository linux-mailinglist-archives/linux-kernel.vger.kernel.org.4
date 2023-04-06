Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A506D9961
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbjDFOQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbjDFOP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB679902B;
        Thu,  6 Apr 2023 07:15:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F4F564402;
        Thu,  6 Apr 2023 14:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BF0C4339B;
        Thu,  6 Apr 2023 14:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680790544;
        bh=HgxWbRnUD+lznmN0YINmK/peGCL+3277qwit7hqBbJ0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cvGZPJ26d5TH8Sy+JmJOYCwXZO+8fBRYMzT+dPWYyPv9X7Qp0gRdbOJtAv40Mu3oh
         UuoDXasUh/28lTHBY9qVWiPrqHSFCx7j8mdm1XiiD3LrdtmEsGUKxmMbAYnVn6J7tq
         DcyCVp6HRiZxQehcfVfHDSOULOXZ+bTw1Py/LlfhyiHj5wYn9wvDunhVKlnI3XX7VN
         LCoYceZcz2U0ID9QPioMJNLSDDv9VeojgBF3wQjLYXzTZxzoufsM2rGCTTHfJExubY
         S0+4IHJuch2Yf4YaPwXs4acsOKOlapYMxg2NKK+EfDav+YIUY6W8jdNSOWecbiGip/
         Df+ScJg7kTFbw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4B1B215404B4; Thu,  6 Apr 2023 07:15:44 -0700 (PDT)
Date:   Thu, 6 Apr 2023 07:15:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the rcu tree
Message-ID: <d09b7183-98a4-417b-995a-57d7a218cc0a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230406144346.514455d4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144346.514455d4@canb.auug.org.au>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 02:43:46PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rcu tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> kernel/rcu/tree.c:2808: warning: Function parameter or member 'head_free_gp_snap' not described in 'kfree_rcu_cpu_work'
> 
> Introduced by commit
> 
>   07030d20c8ec ("rcu/kvfree: Add debug check for GP complete for kfree_rcu_cpu list")

Will fix, thank you!

							Thanx, Paul
