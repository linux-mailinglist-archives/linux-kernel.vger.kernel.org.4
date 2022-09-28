Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295155EDD0E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiI1Mmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiI1Mmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:42:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC0682E691;
        Wed, 28 Sep 2022 05:42:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4428A1063;
        Wed, 28 Sep 2022 05:42:41 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.66.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 214A63F73D;
        Wed, 28 Sep 2022 05:42:32 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:42:22 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] cpuidle: teo: Introduce optional util-awareness
Message-ID: <YzRBLiHByw5xPaU3@e126311.manchester.arm.com>
References: <20220915164411.2496380-1-kajetan.puchalski@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915164411.2496380-1-kajetan.puchalski@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Just a gentle ping here. Could you please take a look at this
discussion?
I'd like to address some comments I received, especially on the subject
of making it reduce the state by one as opposed to going all the way to
0 to account for different hardware and how we can accomodate different
architectures in the implementation of that mechanism.

Before I send a v2 it'd be great to know your opinions on this and
whether I should still send it as a TEO patch or fork it into a separate
governor and make the changes there as both Doug and I seem to prefer.

Thank you in advance for you time,
Kajetan

On Thu, Sep 15, 2022 at 05:44:10PM +0100, Kajetan Puchalski wrote:
> At the very least this approach seems promising so I wanted to discuss it in RFC form first.
> Thank you for taking your time to read this!
> 
> [1] https://github.com/mrkajetanp/lisa-notebooks/blob/a2361a5b647629bfbfc676b942c8e6498fb9bd03/idle_util_aware.pdf
> 
> Kajetan Puchalski (1):
>   cpuidle: teo: Introduce optional util-awareness
> 
>  drivers/cpuidle/Kconfig         | 12 +++++
>  drivers/cpuidle/governors/teo.c | 86 +++++++++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+)
> 
> -- 
> 2.37.1
> 
