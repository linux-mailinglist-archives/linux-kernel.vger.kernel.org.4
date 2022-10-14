Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2685FECC9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 12:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJNK4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 06:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJNKz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 06:55:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A36B1BF224;
        Fri, 14 Oct 2022 03:55:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 899DE13D5;
        Fri, 14 Oct 2022 03:56:02 -0700 (PDT)
Received: from bogus (unknown [10.57.35.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DD4B3F792;
        Fri, 14 Oct 2022 03:55:53 -0700 (PDT)
Date:   Fri, 14 Oct 2022 11:55:50 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Besar Wicaksono <bwicaksono@nvidia.com>, lorenzo.pieralisi@arm.com,
        lenb@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        guohanjun@huawei.com, linux-tegra@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ACPI: ARM Performance Monitoring Unit Table (APMT)
 initial support
Message-ID: <20221014105550.zf7ufboxid3jryrz@bogus>
References: <20220929002834.32664-1-bwicaksono@nvidia.com>
 <CAJZ5v0iBZRZmV_oU+VurqxnVMbFN_ttqrL=cLh0sUH+=u0PYsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iBZRZmV_oU+VurqxnVMbFN_ttqrL=cLh0sUH+=u0PYsw@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 07:46:08PM +0200, Rafael J. Wysocki wrote:
> On Thu, Sep 29, 2022 at 2:29 AM Besar Wicaksono <bwicaksono@nvidia.com> wrote:
> >
> > ARM Performance Monitoring Unit Table describes the properties of PMU
> > support in ARM-based system. The APMT table contains a list of nodes,
> > each represents a PMU in the system that conforms to ARM CoreSight PMU
> > architecture. The properties of each node include information required
> > to access the PMU (e.g. MMIO base address, interrupt number) and also
> > identification. For more detailed information, please refer to the
> > specification below:
> >  * APMT: https://developer.arm.com/documentation/den0117/latest
> >  * ARM Coresight PMU:
> >         https://developer.arm.com/documentation/ihi0091/latest
> >
> > The initial support adds the detection of APMT table and generic
> > infrastructure to create platform devices for ARM CoreSight PMUs.
> > Similar to IORT the root pointer of APMT is preserved during runtime
> > and each PMU platform device is given a pointer to the corresponding
> > APMT node.
> >
> > Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> for the change in bus.c, but as a side note, it would be good to move
> all of the ARM-specific initialization into one place, so it is not
> necessary to touch bus.c every time a new piece of it is added.
>

Agreed, I will look into that and move them all under single acpi_arm_init()
or something.

-- 
Regards,
Sudeep
