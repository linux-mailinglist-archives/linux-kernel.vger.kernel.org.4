Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EC06A9ADD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjCCPmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCCPmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:42:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578B821A28;
        Fri,  3 Mar 2023 07:42:50 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PSsft5WWrz6J7Yr;
        Fri,  3 Mar 2023 23:42:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 3 Mar
 2023 15:42:46 +0000
Date:   Fri, 3 Mar 2023 15:42:45 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 3/6] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <20230303154245.00007b4b@Huawei.com>
In-Reply-To: <cba540061d48defc0008638bef0cc42cb1f6762e.1676685180.git.alison.schofield@intel.com>
References: <cover.1676685180.git.alison.schofield@intel.com>
        <cba540061d48defc0008638bef0cc42cb1f6762e.1676685180.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2023 18:18:51 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> When a boolean 'true' is written to this attribute the memdev driver
> retrieves the poison list from the device. The list consists of
> addresses that are poisoned, or would result in poison if accessed,
> and the source of the poison. This attribute is only visible for
> devices supporting the capability. The retrieved errors are logged
> as kernel trace events with the label 'cxl_poison'.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Hi Alison,

The dates and version in the docs need an update. Otherwise
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 14 +++++++
>  drivers/cxl/core/memdev.c               | 56 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  2 +-
>  3 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 3acf2f17a73f..d9421c965a3b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -415,3 +415,17 @@ Description:
>  		1), and checks that the hardware accepts the commit request.
>  		Reading this value indicates whether the region is committed or
>  		not.
> +
> +
> +What:		/sys/bus/cxl/devices/memX/trigger_poison_list
> +Date:		November, 2022
> +KernelVersion:	v6.2

Needs an update.

> +Contact:	linux-cxl@vger.kernel.org
> +Description:
