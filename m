Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EDE6D7347
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbjDEER1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDEERO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:17:14 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2784EFF;
        Tue,  4 Apr 2023 21:16:22 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3354GAWU025714;
        Tue, 4 Apr 2023 23:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680668170;
        bh=83jjpNGOMOIIiqNKc0ZogJ9UGHRqAmuLnriIBn5Y8Ro=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=fmkxfVRTddYJFjA8db84DHNQgs3fH/GB5RY6nUlIBDReB1pVy64eMtW2CusjWLTQ4
         Z9wPV6Zvy3w9SIjXtHhS94YzdxqZtu6alKlC8fU+PqBGx2F/nwMHsaoxD1Fuv0cN24
         yGGk5Xb8lZrfNeHE63WTitbfAGzNcjbUnwNzX4Q4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3354GAXh030420
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Apr 2023 23:16:10 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 4
 Apr 2023 23:16:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 4 Apr 2023 23:16:10 -0500
Received: from [10.24.69.26] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3354G7AG056029;
        Tue, 4 Apr 2023 23:16:08 -0500
Message-ID: <4b189f02-27b3-d885-aaf2-98eb2077d479@ti.com>
Date:   Wed, 5 Apr 2023 09:46:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] cpufreq: amd-pstate: set varaiable mode_state_machine
 storage-class-specifier to static
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, <ray.huang@amd.com>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230404003337.1912901-1-trix@redhat.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230404003337.1912901-1-trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/23 06:03, Tom Rix wrote:
> smatch reports
> drivers/cpufreq/amd-pstate.c:907:25: warning: symbol
>    'mode_state_machine' was not declared. Should it be static?
> 
> This variable is only used in one file so it should be static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

You might want to use the Fixes: commit ("")
tag? It will help people to pick the patch while
back-porting fixes to older kernels.'

For example:
https://lore.kernel.org/all/20230403072443.83810-2-d-gole@ti.com/

Fixes: 0651a730924b ("gpio: davinci: Add support for system 
suspend/resume PM")

Otherwise,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>   drivers/cpufreq/amd-pstate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6f4b8040d46c..5a3d4aa0f45a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -904,7 +904,7 @@ static int amd_pstate_change_driver_mode(int mode)
>   	return 0;
>   }
>   
> -cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
> +static cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
>   	[AMD_PSTATE_DISABLE]         = {
>   		[AMD_PSTATE_DISABLE]     = NULL,
>   		[AMD_PSTATE_PASSIVE]     = amd_pstate_register_driver,

-- 
Thanks and Regards,
Dhruva Gole
