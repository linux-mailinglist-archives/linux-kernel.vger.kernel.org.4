Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B151F5E69EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiIVRve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIVRv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:51:29 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303A2FB30C;
        Thu, 22 Sep 2022 10:51:28 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MHH6s9009383;
        Thu, 22 Sep 2022 17:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : content-type : in-reply-to
 : mime-version; s=pps0720;
 bh=smw1462YN3LrGliNxAn9TigYSB/ChoFvoG0lOoq9cFw=;
 b=BFdhQXevSO69p93dkCVmYu6cLRjJpLDQZJ8FE02FqJr1wQS8tYoCoYLpOY7wnCN0mRpl
 iY/EEpgydI2vbb4VuyoMomm2LFqlLQZQsxRLC1u+m4p10EVJ5nnyCc4bPpMqYgWGpgfr
 FIiGiFaTM3tKC7z9rXi4hujg/FQL6UNjl7OBS/kLBCWuB7e4IojVFeEHCuFPk6yk7upV
 LgyJwJTX7JTQWsx7M0gGd5na5RmZ4RzAKN8tSx9SzKYSEfa4HtKX1HDnoYBIHfuW7/T0
 WT2V/sQRvr/aeW8w5XEFNZPucovxiUGfO0quwl/sROIWWDtJ+0kJaVTJIohzWY8ofolQ Yw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3jrru7tkxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 17:51:13 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 1785CD242;
        Thu, 22 Sep 2022 17:51:13 +0000 (UTC)
Received: from perchik (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 7F7E580A427;
        Thu, 22 Sep 2022 17:51:12 +0000 (UTC)
Date:   Thu, 22 Sep 2022 11:51:11 -0600
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Vladimir Panteleev <git@vladimir.panteleev.md>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: sp5100_tco: Add "action" module parameter
Message-ID: <20220922175110.GC960@perchik>
Reply-To: Jerry.Hoemann@hpe.com
References: <20220920092721.7686-1-git@vladimir.panteleev.md>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920092721.7686-1-git@vladimir.panteleev.md>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-GUID: lRjHXCPMFidZwGzAdh7gky0Td7-XxK9H
X-Proofpoint-ORIG-GUID: lRjHXCPMFidZwGzAdh7gky0Td7-XxK9H
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_12,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220118
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:27:21AM +0000, Vladimir Panteleev wrote:
> Allow configuring the "action" bit, as documented in [1].
> 
> Previously, the only action supported by this module was to reset the
> system (0).  It can now be configured to power off (1) instead.
> 
> [1]: https://www.amd.com/system/files/TechDocs/44413.pdf
> 
> Signed-off-by: Vladimir Panteleev <git@vladimir.panteleev.md>
> ---
> 
> Changes since v1:
>  - Drop the rename of the SP5100_WDT_ACTION_RESET define
>  - Make the new parameter not visible in sysfs for consistency
> 
>  drivers/watchdog/sp5100_tco.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index ae54dd33e233..fb426b7d81da 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -65,6 +65,12 @@ static struct pci_dev *sp5100_tco_pci;
>  
>  /* module parameters */
>  
> +#define WATCHDOG_ACTION 0
> +static bool action = WATCHDOG_ACTION;
> +module_param(action, bool, 0);
> +MODULE_PARM_DESC(action, "Action taken when watchdog expires, 0 to reset, 1 to poweroff (default="
> +		 __MODULE_STRING(WATCHDOG_ACTION) ")");
> +
>  #define WATCHDOG_HEARTBEAT 60	/* 60 sec default heartbeat. */
>  static int heartbeat = WATCHDOG_HEARTBEAT;  /* in seconds */
>  module_param(heartbeat, int, 0);
> @@ -297,8 +303,11 @@ static int sp5100_tco_timer_init(struct sp5100_tco *tco)
>  	if (val & SP5100_WDT_FIRED)
>  		wdd->bootstatus = WDIOF_CARDRESET;
>  
> -	/* Set watchdog action to reset the system */
> -	val &= ~SP5100_WDT_ACTION_RESET;
> +	/* Set watchdog action */
> +	if (action)
> +		val |= SP5100_WDT_ACTION_RESET;
> +	else
> +		val &= ~SP5100_WDT_ACTION_RESET;
>  	writel(val, SP5100_WDT_CONTROL(tco->tcobase));
>  
>  	/* Set a reasonable heartbeat before we stop the timer */
> -- 
> 2.37.3

Looking at other WDT,  I see at least three  that have an "action"
parameter.  These appear to have inconsistent semantics with each 
other and this patch.

Is there something we could to create more uniformity with module
level parameters like these?


Examples:

machzwd.c:
MODULE_PARM_DESC(action, "after watchdog resets, generate: "
                                "0 = RESET(*)  1 = SMI  2 = NMI  3 = SCI");

pseries-wdt.c
static const unsigned long pseries_wdt_action[] = {
        [0] = PSERIES_WDTF_ACTION_HARD_POWEROFF,
	[1] = PSERIES_WDTF_ACTION_HARD_RESTART,
	[2] = PSERIES_WDTF_ACTION_DUMP_RESTART,

sbsa_gwdt.c
MODULE_PARM_DESC(action, "after watchdog gets WS0 interrupt, do: "
                 "0 = skip(*)  1 = panic");


-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
