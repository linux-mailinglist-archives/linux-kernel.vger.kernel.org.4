Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BF05F9BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiJJJV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiJJJVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:21:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE328422FA;
        Mon, 10 Oct 2022 02:21:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9BA91480;
        Mon, 10 Oct 2022 02:21:56 -0700 (PDT)
Received: from bogus (unknown [10.57.35.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0A6E3F792;
        Mon, 10 Oct 2022 02:21:46 -0700 (PDT)
Date:   Mon, 10 Oct 2022 10:21:44 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        dan.carpenter@oracle.com, lukasz.luba@arm.com
Subject: Re: [PATCH v2 1/3] powercap: arm_scmi: Add SCMI Powercap based driver
Message-ID: <20221010092144.fa2epc57vrjmtigx@bogus>
References: <20220906142337.1697569-1-cristian.marussi@arm.com>
 <20220906142337.1697569-2-cristian.marussi@arm.com>
 <CAJZ5v0gOA+VYYHwnz=6MRdQ9ZaPmU5GfB-8xADSazZH2AE57yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gOA+VYYHwnz=6MRdQ9ZaPmU5GfB-8xADSazZH2AE57yg@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 05:09:07PM +0200, Rafael J. Wysocki wrote:
> On Tue, Sep 6, 2022 at 4:24 PM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> >
> > Add a powercap driver that, using the ARM SCMI Protocol to query the SCMI
> > platform firmware for the list of existing Powercap domains, registers all
> > of such discovered domains under the new 'arm-scmi' powercap control type.
> >
> > A new simple powercap zone and constraint is registered for all the SCMI
> > powercap zones that are found.
> >
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> Can you please fold patches [2-3/3] in the series into the first one?
> You can add information that fixes from Dan Carpenter are included to
> the patch changelog.
> 
> Also I would like the SCMI people to look at this and tell me that it
> makes sense to them.
>

Sorry for that, I have taken a look at this driver in the past and I was
OK will it. Clearly I seem to have missed to officially ack it. I will do
once Cristian has v3.

-- 
Regards,
Sudeep
