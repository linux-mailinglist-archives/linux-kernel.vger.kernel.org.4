Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59D87129ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244125AbjEZPtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244197AbjEZPtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:49:10 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0397F2;
        Fri, 26 May 2023 08:49:08 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34QFn5bs039034;
        Fri, 26 May 2023 10:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685116145;
        bh=CyHyVhdJ0Xn9yLkdKHaMRzxyxnhfJae78IYY5BzekWQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=i5FATZuMAe9vnllP0ewv37jyvKO9hu6Uz2MQ8OnKXy8O/ExuW9eFZpUcHyWg/x8zs
         tAe7nFT6E7hkNVJ3XV9bT5Szw8JDFVDqBo93kEJ/FB9pWpIxzWVsCqY/gsmLEC7KHm
         M48CIekwK3pphi7WxATPqtSUtxrYvs7vb5wjc3zo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34QFn5j1007667
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 May 2023 10:49:05 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 May 2023 10:49:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 May 2023 10:49:04 -0500
Received: from [10.250.148.24] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34QFn14g026460;
        Fri, 26 May 2023 10:49:02 -0500
Message-ID: <0b8940fb-5988-9fb0-b588-04773b46608a@ti.com>
Date:   Fri, 26 May 2023 21:19:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] cpufreq: ti-cpufreq: Enable AM62A7 CPUFreq
Content-Language: en-US
To:     Vibhore Vardhan <vibhore@ti.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>
References: <20230526144354.38478-1-vibhore@ti.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230526144354.38478-1-vibhore@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 26/05/23 20:13, Vibhore Vardhan wrote:
> Hi,
>
> This series adds cpufreq support for TI AM62A7 SoC.
>
> AM62A7 has the same A53 and efuse configuration as AM625. Thus, soc_data
> from AM625 is reused. This series adds compatible string for AM62A7 to
> ti-cpufreq and cpufreq-dt-platdev drivers respectively.
>
> Tested on am62a-sk board using manual frequency changes and then reading
> back frequency with k3conf, and this shows matching frequency to what
> was set. 
>
> Link to the complete series including the DT patches:
> https://github.com/DhruvaG2000/v-linux/commits/am62a_cpufreq_2023
>
> Based on patch series for AM625 by Dave Gerlach.
>
> Regards,
> Vibhore
>
> Vibhore Vardhan (2):
>   cpufreq: ti-cpufreq: Add support for AM62A7
>   cpufreq: dt-platdev: Blacklist ti,am62a7 SoC
>
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/ti-cpufreq.c         | 1 +
>  2 files changed, 2 insertions(+)
LGTM,

Reviewed-by: Dhruva Gole <d-gole@ti.com>
>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

