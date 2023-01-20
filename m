Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BD16751AB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjATJx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjATJxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:53:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FDEF78568
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:53:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E460B14BF;
        Fri, 20 Jan 2023 01:54:03 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8037D3F71A;
        Fri, 20 Jan 2023 01:53:20 -0800 (PST)
Date:   Fri, 20 Jan 2023 09:53:14 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, peter.hilber@opensynergy.com,
        nicola.mazzucato@arm.com, tarek.el-sherbiny@arm.com,
        quic_kshivnan@quicinc.com
Subject: Re: [PATCH v8 00/17] Introduce a unified API for SCMI Server testing
Message-ID: <Y8pkfJ11iaBiLCQh@e120937-lin>
References: <20230118121426.492864-1-cristian.marussi@arm.com>
 <e0a09ca8-2ad8-c519-c47e-4707bfb4fe93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0a09ca8-2ad8-c519-c47e-4707bfb4fe93@gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 01:47:04PM -0800, Florian Fainelli wrote:
> Hi Christian,
> 
Hi Florian,

> On 1/18/23 04:14, Cristian Marussi wrote:
> > Hi all,
> > 
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
> Took a while but finally:
> 
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> 

Thanks for giving it a go.

> Any idea when the raw_mode_support or the acs_raw_mode_support will hit your
> master branch in the scmi-tests repository?

I was holding off waiting for this series to be merged to be sure the
debugfs ABI was not changing anymore, so now, soon-ish, I'll move to request
merge the Raw support in the ACS too; the only further delay regarding this,
that I can think of, could be that I know QA is also adding v3.1 tests to the
ACS and they are too going for the MR in these days, so this could delay a bit
further the Raw support merge.

Thanks,
Cristian

