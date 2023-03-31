Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8526D22BF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjCaOgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjCaOgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:36:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD15D2112;
        Fri, 31 Mar 2023 07:36:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A8C82F4;
        Fri, 31 Mar 2023 07:28:12 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74E493F663;
        Fri, 31 Mar 2023 07:27:26 -0700 (PDT)
Date:   Fri, 31 Mar 2023 15:27:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Wing Li <wingers@google.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>, andersson@kernel.org,
        dianders@chromium.org, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, jwerner@chromium.org,
        quic_lsrao@quicinc.com, quic_rjendra@quicinc.com
Subject: Re: [PATCH v2 1/2] cpuidle: psci: Move enabling OSI mode after power
 domains creation
Message-ID: <20230331142724.ogvruad7txfe7ji2@bogus>
References: <20230330084250.32600-1-quic_mkshah@quicinc.com>
 <20230330084250.32600-2-quic_mkshah@quicinc.com>
 <20230330093431.xn5wwiwqbne5owf7@bogus>
 <CAPDyKFpUmkF=pOwXNrva1k2R+RFBB39-Y4kA0Fve+-3NGbtDag@mail.gmail.com>
 <20230330131334.idb25zf4tdf3zqn3@bogus>
 <CADut4F3UmMXCYHeE6sXfoJtgEp36Fv65Poe1Z0JKT0DETyaowQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADut4F3UmMXCYHeE6sXfoJtgEp36Fv65Poe1Z0JKT0DETyaowQ@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 06:40:03PM -0700, Wing Li wrote:
> Adding some clarifications.
> 
> On Thu, Mar 30, 2023 at 6:13 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
> > On Thu, Mar 30, 2023 at 02:06:19PM +0200, Ulf Hansson wrote:
> > > On Thu, 30 Mar 2023 at 11:34, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Thu, Mar 30, 2023 at 02:12:49PM +0530, Maulik Shah wrote:
> > > > > A switch from OSI to PC mode is only possible if all CPUs other than
> > the
> > > > > calling one are OFF, either through a call to CPU_OFF or not yet
> > booted.
> > > > >
> > > >
> > > > As per the spec, all cores are in one of the following states:
> > > >  - Running
> > > >  - OFF, either through a call to CPU_OFF or not yet booted
> > > >  - Suspended, through a call to CPU_DEFAULT_SUSPEND
> > > >
> > > > Better to provide full information.
> >
> 
> The spec quoted above only applies when switching from platform-coordinated
> mode to OS-initiated mode.
> 
> For switching from OS-initiated to platform-coordinated, which is the case
> Maulik is referring to, section 5.20.2 of the spec specifies:
> "A switch from OS-initiated mode to platform-coordinated mode is only
> possible if all cores other than the calling one are OFF, either through a
> call to CPU_OFF or not yet booted."
> 
>

My bad, I read/imagined it as PC->OSI mode couple of times even though it
is pretty explicit. Sorry for that. And thanks a lot for pointing that out.

-- 
Regards,
Sudeep
