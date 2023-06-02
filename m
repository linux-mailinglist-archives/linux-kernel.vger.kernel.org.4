Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BD871FFD1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjFBKz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbjFBKzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:55:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AB98C0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:55:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A951F1063;
        Fri,  2 Jun 2023 03:56:36 -0700 (PDT)
Received: from [10.57.22.125] (unknown [10.57.22.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DDB73F7BD;
        Fri,  2 Jun 2023 03:55:50 -0700 (PDT)
Message-ID: <bdb24a64-6cdd-2ffb-da57-a237936b8524@arm.com>
Date:   Fri, 2 Jun 2023 11:55:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH 4/4] perf/arm_cspmu: Decouple APMT dependency
To:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org
Cc:     mark.rutland@arm.com, bwicaksono@nvidia.com,
        ilkka@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1685619571.git.robin.murphy@arm.com>
 <3509b299b19b8bf89700c77c2bb695c740926ae7.1685619571.git.robin.murphy@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <3509b299b19b8bf89700c77c2bb695c740926ae7.1685619571.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 12:59, Robin Murphy wrote:
> The functional paths of the driver need not care about ACPI, so abstract
> the property of atomic doubleword access as its own flag (repacking the
> structure for a better fit). We also do not need to go poking directly
> at the APMT for standard resources which the ACPI layer has already
> dealt with, so deal with the optional MMIO page and interrupt in the
> normal firmware-agnostic manner. The few remaining portions of probing
> that *are* APMT-specific can still easily retrieve the APMT pointer as
> needed without us having to carry a duplicate copy around everywhere.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


