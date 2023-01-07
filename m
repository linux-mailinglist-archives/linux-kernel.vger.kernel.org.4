Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D06611D2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 22:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjAGVjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 16:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjAGVjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 16:39:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B967360FC;
        Sat,  7 Jan 2023 13:39:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CB05B80816;
        Sat,  7 Jan 2023 21:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BE7C433D2;
        Sat,  7 Jan 2023 21:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673127565;
        bh=X45kMdlDNxaqxDxmSIkrPks0CTIZ+F9IiqElqXlNkEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVePZD/GGkp09FGcBjE1NDWMv0pNyzK3d0MA4TnFTl85q4MLclJ4aZM6sdpLpayur
         gbPSXPw55S+HjgSatCXDMKV5ebKPDLW9wC5ZWygjxSFz5wrZKXse0Ayy8b9nFG5zX0
         AOEYNKrjKa0Z8m/AmQ5vKLqh5TnAKBQbYk1hf7qOnMjWynNcrQrbU7b9QqtKkmEJd2
         v4InyJS8ni0GMmbHUTAEZdCrocK2ROI2APJKdoqPXtoPuFKJrdfCCxKLGTZWY+5gdT
         7HIIVQA+FNDmuYbRiUPCvsd9AV0GroQZ0EIrwfJkZLl8Glf278A/JnZeVyDoteNu5p
         CJp393eQrydbA==
Date:   Sat, 7 Jan 2023 22:39:22 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check
Message-ID: <Y7nmihQ126cjqEss@lothringen>
References: <20221220141625.3612085-1-qiang1.zhang@intel.com>
 <20221221201634.GH4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221201634.GH4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 12:16:34PM -0800, Paul E. McKenney wrote:
> On Tue, Dec 20, 2022 at 10:16:25PM +0800, Zqiang wrote:
> > This commit add TICK_DEP_MASK_RCU_EXP dependency check in
> > check_tick_dependency(), fix commit df1e849ae4559 ("rcu: Enable
> > tick for nohz_full CPUs slow to provide expedited QS").
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> 
> Again, good eyes, thank you!!!
> 
> I have queued this for further review and testing, given that it affects
> pretty much only RCU.  However, if someone else would rather take it:
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>


Thanks for picking it up! Please also add the following tags:

Fixes: df1e849ae455 ("rcu: Enable tick for nohz_full CPUs slow to provide expedited QS")
Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
