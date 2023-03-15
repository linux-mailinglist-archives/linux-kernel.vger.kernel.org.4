Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B496BC0BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjCOXTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjCOXT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:19:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BE19EF61;
        Wed, 15 Mar 2023 16:19:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2BD5B81F69;
        Wed, 15 Mar 2023 23:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F671C433EF;
        Wed, 15 Mar 2023 23:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678922362;
        bh=81awSetxC+QrtwX4EfU7acoeVof/2xDbxdsMUMHBWk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dS//3Mj0ALvxPCR9OCD67H+DMvkA5gVl2t1Y53GuNX4zFtLuqYt9oFeM+wYrbcAyT
         f9YQDtm/mrdVOiyvXHlXRTeO6C1t7JHZc+Yu4p90Uo3I9RTvCfHAw7sFShCTOTBKXi
         r3MWu58+CzO75FhrKNCEuc/V63JeGKQzXIwpy3YENLN+bPXUDFbTE1tv5sqEqNoDXu
         3zasRE/DwjiimdfN6Ievi5eAMFk/dVXnGuCv78+6HOpJZilK00FMvPVZ9Z2M1r4Wtc
         cvgMt9I0FlBXMuerjrNZIYa2x6f9cAy//EshdpIIv76QDoel5TK1d6yLXikDZ0aoMz
         8EV5xfmXa4Btw==
Date:   Thu, 16 Mar 2023 00:19:19 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 4/9] rcu: Register rcu-lazy shrinker only for
 CONFIG_RCU_LAZY=y kernels
Message-ID: <ZBJSd9tJ8RU7er1o@localhost.localdomain>
References: <20230315194349.10798-1-joel@joelfernandes.org>
 <20230315194349.10798-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230315194349.10798-4-joel@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Mar 15, 2023 at 07:43:44PM +0000, Joel Fernandes (Google) a écrit :
> From: Zqiang <qiang1.zhang@intel.com>
> 
> The lazy_rcu_shrink_count() shrinker function is registered even in
> kernels built with CONFIG_RCU_LAZY=n, in which case this function
> uselessly consumes cycles learning that no CPU has any lazy callbacks
> queued.
> 
> This commit therefore registers this shrinker function only in the kernels
> built with CONFIG_RCU_LAZY=y, where it might actually do something useful.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
