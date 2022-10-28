Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18136115C4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJ1PYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJ1PYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:24:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C8071E0980
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:24:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D84F71FB;
        Fri, 28 Oct 2022 08:24:06 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6CC93F534;
        Fri, 28 Oct 2022 08:23:58 -0700 (PDT)
Date:   Fri, 28 Oct 2022 16:23:48 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, peter.hilber@opensynergy.com,
        nicola.mazzucato@arm.com, tarek.el-sherbiny@arm.com,
        quic_kshivnan@quicinc.com
Subject: Re: [PATCH v4 0/11] Introduce a unified API for SCMI Server testing
Message-ID: <Y1vz6jpbCKDcXAPh@e120937-lin>
References: <20221019204626.3813043-1-cristian.marussi@arm.com>
 <645ffd03-b49d-9e6e-7541-21c11eab0aef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <645ffd03-b49d-9e6e-7541-21c11eab0aef@gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 07:44:32AM -0700, Florian Fainelli wrote:
> Hi Christian,
> 
> On 10/19/2022 1:46 PM, Cristian Marussi wrote:
> > Hi all,
> > 

Hi Florian,

> > This series aims to introduce a new SCMI unified userspace interface meant
> > to ease testing an SCMI Server implementation for compliance, fuzzing etc.,
> > from the perspective of the OSPM agent (non-secure world only ...)
> > 
> > It is proposed as a testing/development facility, it is NOT meant to be a
> > feature to use in production, but only enabled in Kconfig for test
> > deployments.
> > 
> > Currently an SCMI Compliance Suite like the one at [1] can only work by
> > injecting SCMI messages at the SCMI transport layer using the mailbox test
> > driver (CONFIG_MAILBOX_TEST) via its few debugfs entries and looking at
> > the related replies from the SCMI backend Server.
> 
> I plan on giving this a try on our systems later today and will let you know
> the outcome.

Great ! It would be much appreciated...

> This is very useful for making sure the SCMI implementation is
> both correct and properly hardened.

... that was the plan :P

Note that the upstream SCMI ACS suite that I am using for stressing/testing
this Raw thing is still WIP in term of supporting Raw mode injection
(i.e. functional but ALL still to be merged)..but if you need I can give
you pointers on how to use it....unless of course you have your suite or
you just want to test using the shell as in the cover-letter examples...

... on my side I tried to fuzz me with a brutal

	'dd bs=128 count=1 if=/dev/random of=<scmi_raw>/message'

as a poor man fuzzying tool :D ... so I was thinking if it was meaningful
to think about upstreaming some common tools for fuzzying or simply
pre-building bare payloads (in proper endianity) to be injected with this
SCMI raw thing... (I mean something useful that could live in tools/)

...any feedbacks/hints in these regards are welcome.

Thanks,
Cristian

