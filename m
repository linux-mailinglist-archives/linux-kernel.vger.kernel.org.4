Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF4F6F16EA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243551AbjD1LjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjD1LjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:39:19 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B678D524D;
        Fri, 28 Apr 2023 04:39:18 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33S9uA0W020350;
        Fri, 28 Apr 2023 04:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682675770;
        bh=MHMcfySl+AYUW0CLqFI3f3yyTIT9XDcRwfhuHJWUxoI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=vNoiH0p4DEvURenwt/IerE9zoClq9JXXsj+g0hE8xD8Vb5rw5b54cNHZWFChP1L7O
         MuQbWbXmDkWjvY44zQjtf7U6FW2Gx3k2WJDSdID1HKb4Y4AAHBt6DfDzNDTNcO9INk
         ZYFJXve4jX/cDRXYp3y65Occ2xSCiyC/NRVIep8I=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33S9uAgq052874
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Apr 2023 04:56:10 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Apr 2023 04:56:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Apr 2023 04:56:10 -0500
Received: from [10.24.69.26] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33S9u8n1002775;
        Fri, 28 Apr 2023 04:56:08 -0500
Message-ID: <aa8386f8-6dce-0caf-a09f-a14347abf391@ti.com>
Date:   Fri, 28 Apr 2023 15:26:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] cpufreq: create cooling device based on ACPI
Content-Language: en-US
To:     <wangyouwan@126.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230428070314.225560-1-wangyouwan@126.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230428070314.225560-1-wangyouwan@126.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/04/23 12:33, wangyouwan@126.com wrote:
> From: youwan Wang <wangyouwan@126.com>
> 
> When using the "scpi_cpufreq" driver, an error

Pardon, do you mean drivers/cpufreq/acpi-cpufreq.c ?

> occurs:cpufreq_cooling: OF node not available for cpu*.


If this is fixing some errors/ bugs, maybe add an appropriate fixes
tag?

> The current computer motherboard is using ACPI firmware.
> Go to see that the error is caused by calling the
> "of_cpufreq_cooling_register" interface.
> comment:create cpufreq cooling device based on DT.
> 
> Signed-off-by: youwan Wang <wangyouwan@126.com>
> ---
>   drivers/cpufreq/cpufreq.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
[...]
>   

-- 
Thanks and Regards,
Dhruva Gole
