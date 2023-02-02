Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1710688B2E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjBBXzY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Feb 2023 18:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjBBXzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:55:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9B6B00D;
        Thu,  2 Feb 2023 15:55:21 -0800 (PST)
Received: from [4.28.11.157] ([4.28.11.157]) by web-mail.gmx.net
 (3c-app-mailcom-bs03.server.lan [172.19.170.169]) (via HTTP); Fri, 3 Feb
 2023 00:53:57 +0100
MIME-Version: 1.0
Message-ID: <trinity-6c33de04-f4d5-475e-a3f7-dd4e858fc187-1675382037529@3c-app-mailcom-bs03>
From:   Kevin Brace <kevinbrace@gmx.com>
To:     silviazhao-oc <silviazhao-oc@zhaoxin.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, cobechen@zhaoxin.com,
        louisqi@zhaoxin.com, silviazhao@zhaoxin.com, tonywwang@zhaoxin.com,
        8vvbbqzo567a@nospam.xutrox.com
Subject: Re: [PATCH] x86/perf/zhaoxin: Add stepping check for ZX-C
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 3 Feb 2023 00:53:57 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20230202091738.5947-1-silviazhao-oc@zhaoxin.com>
References: <20230202091738.5947-1-silviazhao-oc@zhaoxin.com>
Content-Transfer-Encoding: 8BIT
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:780EN+21gp1v8HyZyJROry3Ku8WfAMUoZlWychq2CyvMqidHgZSE6SSwcBO1X0/J4ta4G
 CJZy5Wu4JE9XqcBHZUM5K8JTwl4ydlXDYT3q4vAQByS9rg5Id2nnyC/NnsSipWewgmYCuiDTM4Qn
 tgVVbZWHQFaxI2Db2rZsN125yBpwnUL2WKDemquFCxywCBXkNCk/5kJ2Et3P/s/RepfhpB6wM7Zb
 +8tZnQv3vvDVUW3GqU48v2foqG1/GIW3wW+UOQ99OF+LuEpsx/CrqtYrIQT/ju6EaUwhOj/ndPAp
 zQ=
UI-OutboundReport: notjunk:1;M01:P0:mwym8BMLxm4=;5TRV+4FXBmC5SwskyGSDlyJiR7G
 U9NSY7TsX9f1HLZ+uXw2u8lGfqEvQlNLhFCuuB12v0Sa3/tKlcT1oJQPOgvQghkY9hpY5meJu
 4FEVNT0vmrnAeeYHZWfWwk2NS4rK9KhbprH+wawOR/jVsXwoh/77e70ys4aTN54fCK8F7X1mw
 wLpf2AZB+hm4INVvrnMm4LPzhwQ6JswkfKRb9vGXFVEQjrOCpiL6icIIoMe6C71exl5wTQtkJ
 wJYtJxf7zdyxL4jlPjOJc9FKHaEv17GMr90naX5WRZyyPoEUSxxZYtfXxM3ug7R7fbRDOOBEp
 aLNYDmfGc6kyBNS5Mi75g6VQ4pwgv9fyJ2lunGE0syCaysiC+bRVvYFb41gVzVmMaw40OClLc
 2D0iii4rTZECdmUdi0Y8VNhoS8TJGRd/amudMdGehfcgXZdO1oTFJEhGcy4LBEni78JcVhdsB
 lsW3+7OU+IChrE7UAH3iKnADR76xdkv15gNKvlCidluGJg9NbxrE4OWukacUIh5wykyIHK9aN
 YOXjM1Ly8FmzyQ2MZAID3NfSLldEb/yoWRrptvfwwgPJdNPC2A8kDgMdTdetSwokCIdoM79IS
 NcsV3ENR2JqXEGYFts6GHcJfVsjzSGUmUO9/BYDvEvn9Gqz0pKTX3oFEmhkAcRPkTPM/Z42Fw
 xdwXWrlGnNmPQQ8U1MAZvwn7/njRH6OmNox2/4p6plPGfzQxTt1VA3LfDrd6M3Bpzrtb5Ua3N
 8x+8vXxtmRRBdrxrjCt+NzNjV2O1+1bfHzYTSBJt7VmPinhmnlGk47WDQwNTlrXRAq5N5YdTs
 +2cKY7YymfvcK5pVpIbLoo9A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Silvia,

Thank you very much for resending the VIA / Zhaoxin PMU patch and for keeping me in the loop.
I observed this bug on ECS (Elitegroup Computer Systems) VX900-I mainboard.
The mainboard contains one VIA Nano L2007 processor (1.6 GHz) soldered on the PCB.
Although I have not independently verified it, CPUID steppings for VIA Nano 1000 / 2000 series (Centaur Technology code name: CNA) are supposedly 2 and 3.
CPUID stepppings for VIA Nano 3000 series (Centaur Technology code name: CNB) is 8.
CPUID stepppings for VIA Nano x2 (Centaur Technology code name: CNC) is 10.

https://www.reddit.com/r/VIA/comments/dy71bn/via_centaurs_new_cpu_is_a_8core_x86_cpu_with_an/

I have not checked the actual CPUID steppings, but I have confirmed that the current code without the fix works okay with Nano 3000 series and Nano x2, but definitely not Nano 2000 series.
For Nano 3000 series test, I used VIA Embedded EPIA M830 mainboard.
For Nano x2 test, I used HP T510 thin client.
Based on my observations, it appears that Centaur CNA contains a bug reading some performance counters, so not to cause inconveniences with users of Nano 1000 / 2000 series processors, the patch should limit / prevent reading performance counters on these processors.
I think the code for the fix should reflect this the following way.

_______________________________________________________________
 	switch (boot_cpu_data.x86) {
 	case 0x06:
-		if (boot_cpu_data.x86_model == 0x0f || boot_cpu_data.x86_model == 0x19) {
+		if ((boot_cpu_data.x86_model == 0x0f && boot_cpu_data.x86_stepping >= 0x08) ||
+			boot_cpu_data.x86_model == 0x19) {

 			x86_pmu.max_period = x86_pmu.cntval_mask >> 1;

_______________________________________________________________

The above code should exclude Nano 1000 / 2000 series processors properly.
I lost easy access to ECS VX900-I mainboard for now (I need to look around for it. I do own another copy of it.), so I cannot confirm if the fix is properly working.
I still have easy access to EPIA M830 mainboard.
    I welcome anyone's feedback on this issue.
This fix should go into the current kernel in development since it is a show stopper for users of Nano 1000 / 2000 series processors.
If the fix is adopted, please backport it to previous releases of the kernel.
I wasted about 2 weeks on this issue, and this fix should have never been ignored for such a long time.

Regards,

Kevin Brace
Brace Computer Laboratory blog
https://bracecomputerlab.com


> Sent: Thursday, February 02, 2023 at 3:17 AM
> From: "silviazhao-oc" <silviazhao-oc@zhaoxin.com>
> To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
> Cc: cobechen@zhaoxin.com, louisqi@zhaoxin.com, silviazhao@zhaoxin.com, tonywwang@zhaoxin.com, kevinbrace@gmx.com, 8vvbbqzo567a@nospam.xutrox.com
> Subject: [PATCH] x86/perf/zhaoxin: Add stepping check for ZX-C
>
> Nano processor may not fully support rdpmc instruction, it works well
> for reading general pmc counter, but will lead GP(general protection)
> when accessing fixed pmc counter. Furthermore, family/mode information
> is same between Nano processor and ZX-C processor, it leads to zhaoxin
> pmu driver is wrongly loaded for Nano processor, which resulting boot
> kernal fail.
> 
> To solve this problem, stepping information will be checked to distinguish
> between Nano processor and ZX-C processor.
> 
> Fixes: 3a4ac121c2ca (“x86/perf: Add hardware performance events support for Zhaoxin CPU”)
> Reported-by: Arjan <8vvbbqzo567a@nospam.xutrox.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=212389
> Reported-by: Kevin Brace <kevinbrace@gmx.com>
> 
> Signed-off-by: silviazhao-oc <silviazhao-oc@zhaoxin.com>
> ---
>  arch/x86/events/zhaoxin/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
> index 949d845c922b..cef1de251613 100644
> --- a/arch/x86/events/zhaoxin/core.c
> +++ b/arch/x86/events/zhaoxin/core.c
> @@ -541,7 +541,8 @@ __init int zhaoxin_pmu_init(void)
>  
>  	switch (boot_cpu_data.x86) {
>  	case 0x06:
> -		if (boot_cpu_data.x86_model == 0x0f || boot_cpu_data.x86_model == 0x19) {
> +		if ((boot_cpu_data.x86_model == 0x0f && boot_cpu_data.x86_stepping >= 0x0e) ||
> +			boot_cpu_data.x86_model == 0x19) {
>  
>  			x86_pmu.max_period = x86_pmu.cntval_mask >> 1;
>  
> -- 
> 2.17.1
> 
>
