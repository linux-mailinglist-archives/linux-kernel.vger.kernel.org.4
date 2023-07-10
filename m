Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9028074DA9F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjGJP5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjGJP5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:57:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DDFBDD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:57:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A36F2B;
        Mon, 10 Jul 2023 08:58:25 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4A4A3F740;
        Mon, 10 Jul 2023 08:57:41 -0700 (PDT)
Message-ID: <650a311c-333b-2407-eb1b-db53af8dc3fe@arm.com>
Date:   Mon, 10 Jul 2023 16:57:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] coresight: fix spelling in etm3x ABI documentation
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230710052315.32699-1-rdunlap@infradead.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230710052315.32699-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/2023 06:23, Randy Dunlap wrote:
> Correct spelling problems as identified by codespell.
> Correct one grammar error.
> 
> Fixes: 7a25ec8e481e ("coresight: Adding ABI documentation")
> Fixes: 7253e4c95616 ("coresight: etm3x: breaking down sysFS status interface")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x |   12 +++++-----
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Thanks for the fixes.

Reviewed-by: James Clark <james.clark@arm.com>

> diff -- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
> @@ -20,9 +20,9 @@ Date:		November 2014
>  KernelVersion:	3.19
>  Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
>  Description:	(RW) Used in conjunction with @addr_idx.  Specifies
> -		characteristics about the address comparator being configure,
> +		characteristics about the address comparator being configured,
>  		for example the access type, the kind of instruction to trace,
> -		processor contect ID to trigger on, etc.  Individual fields in
> +		processor context ID to trigger on, etc.  Individual fields in
>  		the access type register may vary on the version of the trace
>  		entity.
>  
> @@ -31,7 +31,7 @@ Date:		November 2014
>  KernelVersion:	3.19
>  Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
>  Description:	(RW) Used in conjunction with @addr_idx.  Specifies the range of
> -		addresses to trigger on.  Inclusion or exclusion is specificed
> +		addresses to trigger on.  Inclusion or exclusion is specified
>  		in the corresponding access type register.
>  
>  What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/addr_single
> @@ -304,19 +304,19 @@ What:		/sys/bus/coresight/devices/<memor
>  Date:		September 2015
>  KernelVersion:	4.4
>  Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
> -Description: 	(RO) Print the content of the ETM Trace Start/Stop Conrol
> +Description: 	(RO) Print the content of the ETM Trace Start/Stop Control
>  		register (0x018). The value is read directly from the HW.
>  
>  What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/mgmt/etmtecr1
>  Date:		September 2015
>  KernelVersion:	4.4
>  Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
> -Description: 	(RO) Print the content of the ETM Enable Conrol #1
> +Description: 	(RO) Print the content of the ETM Enable Control #1
>  		register (0x024). The value is read directly from the HW.
>  
>  What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/mgmt/etmtecr2
>  Date:		September 2015
>  KernelVersion:	4.4
>  Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
> -Description: 	(RO) Print the content of the ETM Enable Conrol #2
> +Description: 	(RO) Print the content of the ETM Enable Control #2
>  		register (0x01c). The value is read directly from the HW.
