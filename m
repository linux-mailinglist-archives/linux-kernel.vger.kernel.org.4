Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56FA6AE565
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjCGPwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjCGPwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:52:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D2E8C83E;
        Tue,  7 Mar 2023 07:52:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4257D61489;
        Tue,  7 Mar 2023 15:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C1DC433D2;
        Tue,  7 Mar 2023 15:52:01 +0000 (UTC)
Date:   Tue, 7 Mar 2023 10:51:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list),
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH v1 01/11] thermal/core: Relocate the traces definition
 in thermal directory
Message-ID: <20230307105159.5d137b28@gandalf.local.home>
In-Reply-To: <20230307133735.90772-2-daniel.lezcano@linaro.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
        <20230307133735.90772-2-daniel.lezcano@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Mar 2023 14:37:25 +0100
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> The traces are exported but only local to the thermal core code. On
> the other side, the traces take the thermal zone device structure as
> argument, thus they have to rely on the exported thermal.h header
> file. As we want to move the structure to the private thermal core
> header, first we have to relocate those traces to the same place as
> many drivers do.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  drivers/thermal/Makefile                                    | 3 ++-
>  drivers/thermal/cpufreq_cooling.c                           | 2 +-
>  drivers/thermal/devfreq_cooling.c                           | 2 +-
>  drivers/thermal/gov_fair_share.c                            | 2 +-
>  drivers/thermal/gov_power_allocator.c                       | 2 +-
>  drivers/thermal/gov_step_wise.c                             | 2 +-
>  drivers/thermal/thermal_core.c                              | 2 +-
>  drivers/thermal/thermal_helpers.c                           | 3 +--
>  .../events/thermal.h => drivers/thermal/thermal_trace.h     | 6 ++++++
>  .../thermal/thermal_trace_ipa.h                             | 6 ++++++
>  10 files changed, 21 insertions(+), 9 deletions(-)
>  rename include/trace/events/thermal.h => drivers/thermal/thermal_trace.h (97%)
>  rename include/trace/events/thermal_power_allocator.h => drivers/thermal/thermal_trace_ipa.h (96%)

