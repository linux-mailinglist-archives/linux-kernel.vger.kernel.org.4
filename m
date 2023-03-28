Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0B96CBA7D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjC1JYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjC1JYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:24:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCB0F65BF;
        Tue, 28 Mar 2023 02:24:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F74FC14;
        Tue, 28 Mar 2023 02:25:15 -0700 (PDT)
Received: from [10.57.20.43] (unknown [10.57.20.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE29B3F73F;
        Tue, 28 Mar 2023 02:24:29 -0700 (PDT)
Message-ID: <890a8bf8-9564-2f8c-544c-615c26647e47@arm.com>
Date:   Tue, 28 Mar 2023 10:24:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] MAINTAINERS: adjust entry in THERMAL/POWER_ALLOCATOR
 after header movement
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
References: <20230328091737.6785-1-lukas.bulwahn@gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230328091737.6785-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On 3/28/23 10:17, Lukas Bulwahn wrote:
> Commit e97b6e04095a ("thermal/core: Relocate the traces definition in
> thermal directory") moves include/trace/events/thermal_power_allocator.h to
> drivers/thermal/thermal_trace_ipa.h, but misses to adjust the file entry
> for the THERMAL/POWER_ALLOCATOR section.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Adjust this file entry in THERMAL/POWER_ALLOCATOR.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Daniel, please apply this minor clean-up patch on top of the commit above. Thanks.

Thanks, I've missed that former patch set.

> 
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e61e3240758..3e0dbf8018d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20847,7 +20847,7 @@ L:	linux-pm@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/driver-api/thermal/power_allocator.rst
>   F:	drivers/thermal/gov_power_allocator.c
> -F:	include/trace/events/thermal_power_allocator.h
> +F:	drivers/thermal/thermal_trace_ipa.h
>   
>   THINKPAD ACPI EXTRAS DRIVER
>   M:	Henrique de Moraes Holschuh <hmh@hmh.eng.br>


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
