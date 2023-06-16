Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE9573350C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345787AbjFPPjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjFPPjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:39:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABF2930D1;
        Fri, 16 Jun 2023 08:39:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 447E11FB;
        Fri, 16 Jun 2023 08:40:13 -0700 (PDT)
Received: from bogus (unknown [10.57.96.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 905A23F71E;
        Fri, 16 Jun 2023 08:39:26 -0700 (PDT)
Date:   Fri, 16 Jun 2023 16:39:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Tushar Nimkar <quic_tnimkar@quicinc.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_lsrao@quicinc.com, quic_mkshah@quicinc.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: idle-states: Add
 idle-state-disabled property
Message-ID: <20230616153924.2wtvgr7lvjcul6to@bogus>
References: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
 <20230608085544.16211-2-quic_tnimkar@quicinc.com>
 <20230615085629.b2aaumhq7yqhs5lf@bogus>
 <5820345a-4207-3b12-87eb-098bac4ef4e8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5820345a-4207-3b12-87eb-098bac4ef4e8@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:26:18AM +0530, Tushar Nimkar wrote:
> 
> Thanks for review Sundeep,
> 
> On 6/15/2023 2:26 PM, Sudeep Holla wrote:
> > On Thu, Jun 08, 2023 at 02:25:42PM +0530, Tushar Nimkar wrote:
> > > +      idle-state-disabled:
> > > +        description: |
> > > +          If present the idle state stays disabled. It can be enabled back from
> > > +          shell using below command.
> > > +          echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable
> > > +        type: boolean
> > > +
> > 
> > This is clearly a policy and not a hardware or firmware feature to expose
> > in the device tree. So NACK, why can't you load it modules if you don't want
> > idle states in the boot.
> > 
> Attempt of making cpuidle governors to modular was rejected in past [2]
>

OK try command line approach to disable all states(you can't get partial
on/off in that case). I don't think the build config is of any use as we
end up enabling it which will affect other platforms.

> [2] https://lore.kernel.org/lkml/1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com/#t
> 
> > It is same as choosing any default governor or performance states, will you
> > add those next ? It is simply policy not a feature/property to be exposed
> > in the device tree.
> > 

The above still holds, so still NACK. It is a policy and not a
hardware/firmware property or feature.

-- 
Regards,
Sudeep
