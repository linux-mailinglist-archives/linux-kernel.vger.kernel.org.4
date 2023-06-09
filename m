Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC44A729403
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbjFIJBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241347AbjFIJAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:00:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEDD4B9;
        Fri,  9 Jun 2023 02:00:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDED5AB6;
        Fri,  9 Jun 2023 02:00:56 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.25.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0EC83F71E;
        Fri,  9 Jun 2023 02:00:09 -0700 (PDT)
Date:   Fri, 9 Jun 2023 10:00:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Junhao He <hejunhao3@huawei.com>
Cc:     will@kernel.org, jonathan.cameron@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linuxarm@huawei.com,
        yangyicong@huawei.com, shenyang39@huawei.com,
        prime.zeng@hisilicon.com
Subject: Re: [PATCH v4 3/3] docs: perf: Add new description for HiSilicon UC
 PMU
Message-ID: <ZILqF4F93sOCxLZh@FVFF77S0Q05N>
References: <20230609075608.36559-1-hejunhao3@huawei.com>
 <20230609075608.36559-4-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609075608.36559-4-hejunhao3@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 03:56:08PM +0800, Junhao He wrote:
> A new function is added on HiSilicon uncore UC PMU.
> 
> The UC PMU support to filter statistical information based on
> the specified tx request uring channel. Make user configuration
> through "uring_channel" parameter.
> Document them to provide guidance on how to use them.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonthan.Cameron@huawei.com>
> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  Documentation/admin-guide/perf/hisi-pmu.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/admin-guide/perf/hisi-pmu.rst b/Documentation/admin-guide/perf/hisi-pmu.rst
> index 546979360513..939a524fa1d6 100644
> --- a/Documentation/admin-guide/perf/hisi-pmu.rst
> +++ b/Documentation/admin-guide/perf/hisi-pmu.rst
> @@ -98,6 +98,14 @@ CCL/ICL-ID. For I/O die, the ICL-ID is followed by:
>  5'b00011: HAC_ICL;
>  5'b10000: PCIe_ICL;
>  
> +(e) uring_channel: UC PMU events 0x47~0x59 supports filtering by tx request
> +uring channel. It is 2 bits. Some important codes are as follows:
> +2'b11: count the events which sent to the uring_ext (MATA) channel;
> +2'b01: is the same as 2'b11;
> +2'b10: count the events which sent to the uring (non-MATA) channel;
> +2'b00: default value, count the events which sent to the both uring and
> +       uring_ext channel;
> +
>  Users could configure IDs to count data come from specific CCL/ICL, by setting
>  srcid_cmd & srcid_msk, and data desitined for specific CCL/ICL by setting
>  tgtid_cmd & tgtid_msk. A set bit in srcid_msk/tgtid_msk means the PMU will not
> -- 
> 2.33.0
> 
