Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A807C60F5F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiJ0LK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJ0LKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:10:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0753129C96;
        Thu, 27 Oct 2022 04:10:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E299323A;
        Thu, 27 Oct 2022 04:10:29 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38A5C3F445;
        Thu, 27 Oct 2022 04:10:22 -0700 (PDT)
Date:   Thu, 27 Oct 2022 12:10:19 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "lihuisong (C)" <lihuisong@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, rafael.j.wysocki@intel.com,
        wanghuiqiang@huawei.com, huangdaode@huawei.com,
        tanxiaofei@huawei.com, Loc Ho <lho@apm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, Hoan Tran <hotran@apm.com>
Subject: Re: [RFC] ACPI: PCC: Support shared interrupt for multiple subspaces
Message-ID: <20221027085457.q6ic3uae2w74xa3o@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <6d00d240-0c86-d593-6efe-44fec21421a8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d00d240-0c86-d593-6efe-44fec21421a8@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 02:10:13PM +0800, lihuisong (C) wrote:
> Kindly ping.
>

Sorry for the delay, I will take a look ASAP. I wanted to refer the spec
before I review this.

-- 
Regards,
Sudeep
