Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311EE68E174
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjBGTsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjBGTsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:48:32 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB8C12581;
        Tue,  7 Feb 2023 11:48:24 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id bx22so13197446pjb.3;
        Tue, 07 Feb 2023 11:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LiWVu1jgFnS1+P8PNhmhOYa+Kepk/2Rz7b7N9cflsAA=;
        b=ZYf0UmPAx9R+uq1Zz9jXf1Rm5fhptrN1VmgDJrPBlkbVz4ov63OJ8KC2cftVZ2MU2I
         y34Q5nwMxEkq0GGgkjFEt9mKVSwAZSFe+6oTRzPS7KC3aImEOAAAUV+TTB6SM4dJSCnD
         LhPNJr/YtDH7uhNRhDpt+WL7S9oZ1uduBF5cYCqGznaiYFqCzAm7VU9lNaNGkc1RRMdZ
         OW75NfLDzx+r5Llzz4HxwQObaOKrjb41+NemtsfIRqT+c/4ZJJBp3n4vo84tC4nAG2BQ
         MyOg/ab71HJPyNAFzUF9cjZsgJ+6zTabX1dG2ZA/VsFSxgLaJu8eQ0zoaCQdVJeCd3lr
         PS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiWVu1jgFnS1+P8PNhmhOYa+Kepk/2Rz7b7N9cflsAA=;
        b=o8bEbaAxzF5uu9QUNj7cw7+Y4r4xN/Hv0s2/Ib+LQuJdCCSESW5Ddrue0m/K0L8pxC
         9UGFBoBluOM04mOVBzrHl7h8lElcZQFrpcJkhn6jb4Es0YliTagaLCd4eNMMDzA0A6Qq
         EhCH4/tqplQ5zGJu5d8ciLxzaOPDsZZdBVJmUy04pPlMkI6ySOwhJcDcXFHnNPPk4oMz
         QFWxcj/21tiCUNJHFL1b8iZYF10LHyITBWLboy8bSru6ym8Sog2Fu0bU+8fkZZj1L9am
         gKrfrCFSIjJNGmpwc6oOJYVgwNQ32be3j7KX2m3ZTj1KGSkzBMrUdmzYncxuEo5+iA49
         iQqQ==
X-Gm-Message-State: AO0yUKXKb8FCPSEJ1WqEw6+B8buYp6R0btr1s5SFVpnVwWaW6hGwNtk9
        8osQATQIQHesstFZ1DBb2iE=
X-Google-Smtp-Source: AK7set+NvM8i3lT33CXtGrDWJAwfckpQzCOBvgqnvLW0qeIC5ORnJqLpqvc4+Sdb01dWUyPk2Yi6fQ==
X-Received: by 2002:a17:90b:4b4a:b0:22c:9782:e718 with SMTP id mi10-20020a17090b4b4a00b0022c9782e718mr5619830pjb.0.1675799304047;
        Tue, 07 Feb 2023 11:48:24 -0800 (PST)
Received: from kazuki-mac ([2400:4051:ea3:5910::19a])
        by smtp.gmail.com with ESMTPSA id z21-20020a17090a8b9500b00226156cf039sm11897519pjn.44.2023.02.07.11.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 11:48:23 -0800 (PST)
From:   Kazuki <kazukih0205@gmail.com>
X-Google-Original-From: Kazuki <kazuki@kazuki-mac>
Date:   Wed, 8 Feb 2023 04:48:18 +0900
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: s2idle breaks on machines without cpuidle support
Message-ID: <20230207194818.exskn3dhyzqwr32v@kazuki-mac>
References: <20230204152747.drte4uitljzngdt6@kazuki-mac>
 <20230206101239.dret3fv65cnzpken@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206101239.dret3fv65cnzpken@bogus>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 10:12:39AM +0000, Sudeep Holla wrote:
> Hi Kazaki,
> 
> On Sun, Feb 05, 2023 at 12:27:47AM +0900, Kazuki wrote:
> > 
> > Hi everyone,
> > 
> > s2idle is blocked on machines without proper cpuidle support here
> > in kernel/sched/idle.c:
> > 
> > > if (cpuidle_not_available(drv, dev)) {
> > > 	tick_nohz_idle_stop_tick();
> > 
> > > 	default_idle_call();
> > > 	goto exit_idle;
> > > }
> > 
> > > /*
> > >  * Suspend-to-idle ("s2idle") is a system state in which all user space
> > >  * has been frozen, all I/O devices have been suspended and the only
> > 
> > However, there are 2 problems with this approach:
> > 
> > 1. The suspend framework does not expect this, and continues to suspend the
> > machine, which causes machines without proper cpuidle support to break when
> > suspending
> 
> What do you mean by break ? More details on the observation would be helpful.
For example, CLOCK_MONOTONIC doesn't stop even after suspend since
these chain of commands don't get called.

call_cpuidle_s2idle->cpuidle_enter_s2idle->enter_s2idle_proper->tick_freeze->sched_clock_suspend (Function that pauses CLOCK_MONOTONIC)

Which in turn causes programs like systemd to crash since it doesn't
expect this.
> 
> > 2. Suspend actually works on ARM64 machines even without proper
> > cpuidle (PSCI cpuidle) since they support wfi, so the assumption here is wrong
> > on such machines
> >
> 
> Sorry I am bit confused here. Your point (2) contradicts the $subject.
drivers/cpuidle/cpuidle.c:

bool cpuidle_not_available(struct cpuidle_driver *drv,
			   struct cpuidle_device *dev)
{
	return off || !initialized || !drv || !dev || !dev->enabled;
}

The cpuidle framework reports ARM64 devices without PSCI cpuidle as
"cpuidle not available" even when they support wfi, which causes suspend
to fail, which shouldn't be happening since they do support idling.
> 
> > I'm not exactly sure how to figure this out, and my attempts have all led to an
> > unbootable kernel, so I've cc'ed the relevant people and hopefully we can find a
> > solution to this problem.
> >
> 
> Again, since s2idle is userspace driven, I don't understand what do you
> mean by unbootable kernel in the context of s2idle.
Sorry, I meant "attempts to fix this bug have all led to an unbootable
kernel."
> 
> -- 
> Regards,
> Sudeep
Thanks,
Kazuki
