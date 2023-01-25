Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2C167B107
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbjAYLVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbjAYLUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:20:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B387626A7;
        Wed, 25 Jan 2023 03:20:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 484FA4B3;
        Wed, 25 Jan 2023 03:20:44 -0800 (PST)
Received: from bogus (unknown [10.57.77.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F4883F71E;
        Wed, 25 Jan 2023 03:20:00 -0800 (PST)
Date:   Wed, 25 Jan 2023 11:19:57 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3] cpuidle: psci: Do not suspend topology CPUs on
 PREEMPT_RT
Message-ID: <20230125111957.uzf2hli5md2pm43n@bogus>
References: <20230119184228.683892-1-krzysztof.kozlowski@linaro.org>
 <20230124153411.nwkbjgoqgkua2icm@bogus>
 <c247710b-369a-67d0-0637-b32192d25e4d@linaro.org>
 <CAPDyKFrS6OER2h3XmHMfbjBA09HT8LYN9A90TPjd0RPim3jMaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrS6OER2h3XmHMfbjBA09HT8LYN9A90TPjd0RPim3jMaw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 11:08:04AM +0100, Ulf Hansson wrote:
> On Wed, 25 Jan 2023 at 08:43, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 24/01/2023 16:34, Sudeep Holla wrote:

[...]

> > > Any particular reason for even compiling this file in or allowing the
> > > ARM_PSCI_CPUIDLE when PREEMPT_RT=y ? If we can't enter idle states, we
> > > can as well compile this file out ?
> >
> > It's the power domain sued for other devices, so we need it. Otherwise
> > other devices will keep waiting for this missing power domain provider.
> 
> Yes.
> 
> And we are still able to use those idle states that are solely per
> CPU, which is probably nice to have. No?
> 

Makes sense, thanks for the explanation. Also the other discussions clears
probably questions I had.

-- 
Regards,
Sudeep
