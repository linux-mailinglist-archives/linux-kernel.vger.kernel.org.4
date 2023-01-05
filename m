Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE4765F08C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjAEPvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbjAEPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:51:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC343201C;
        Thu,  5 Jan 2023 07:51:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68D6F61AF8;
        Thu,  5 Jan 2023 15:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34C9C433D2;
        Thu,  5 Jan 2023 15:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672933866;
        bh=pqruQOkYq+O0ZoZtIexmJem3EBjsqfOKE7sNKH0p2ME=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JPijei3viTGiT/tTvAsm0e10zWWgIobtJA1/BIbjXAQrVJ0RMW4eKJQb09URcEhMQ
         WrhYAJ8YOYU6fhRDDZGyeQeyIrprGBvGxAOXEN5exUsc2s/wbuZ5y0YxaVwvKjdFI8
         mRltvMp6B34GAd29Sjz4Rfg/Fr9OlLIMlMXmn+1tTNBJK3k3hnHVqZedefJcglSDpJ
         q5lYb5zfcq74s4OAg6OT9Q4E5r6XppwHlM+UtJ14JnkZVtes6iAOpcgP1KRyeWtHFp
         qroBAGrLmYIm7web9r7EIwflQHVj0S20OC5fAFawownnyE1D/sNXw0InnmuX+YQxXY
         yoXXOmkQ8XntQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6B44A5C029A; Thu,  5 Jan 2023 07:51:06 -0800 (PST)
Date:   Thu, 5 Jan 2023 07:51:06 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH rcu 10/27] drivers/cpufreq: Remove "select SRCU"
Message-ID: <20230105155106.GX4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-10-paulmck@kernel.org>
 <CAJZ5v0j4M3Xco7bSPNog9h-zDgEuHE+jqktWNoRZKyLZCVJeBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j4M3Xco7bSPNog9h-zDgEuHE+jqktWNoRZKyLZCVJeBA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 04:09:38PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 5, 2023 at 1:38 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: <linux-pm@vger.kernel.org>
> 
> Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>

Thank you, Rafael!  I will apply both on my next rebase.

							Thanx, Paul

> > ---
> >  drivers/cpufreq/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index 2a84fc63371e2..785541df59379 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -3,7 +3,6 @@ menu "CPU Frequency scaling"
> >
> >  config CPU_FREQ
> >         bool "CPU Frequency scaling"
> > -       select SRCU
> >         help
> >           CPU Frequency scaling allows you to change the clock speed of
> >           CPUs on the fly. This is a nice method to save power, because
> > --
> > 2.31.1.189.g2e36527f23
> >
