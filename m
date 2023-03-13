Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8B6B6CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 02:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCMBBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 21:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMBBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 21:01:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9292A6DE
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 18:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678669269; x=1710205269;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=B244j7HIVBu10nigSkedsQ1pNJYK9MvC9cQr3X2nFT0=;
  b=Qm74ff3Hn4aePlVXtBXCejM1bv1xWA9HVxLTSt5TWPk0CeEmxSAREnV1
   +QpFeEdoYcE9tLJFOrpLisxEmIK9367ZL1YfWSXm6KCB2+kacNuqrfoZ6
   uS+2TfpMhhzuBsAnG5zLoQR3r4c9nnhbkCT2zb97gbUGKykfaNRN2oRV/
   7t4XDNHuIO0EKC7OfakMC3T8C+olZkBg8a7elpjPQmT2XW1KqhjwTqvy0
   BrHlwBASW1gkWXrkqBA4qkZdydoMHb4XrIXtymRq2lVixFDQrUIIJ58q8
   oc0Lg7Ec/LgGnNZK7oItDNNLoxBz6Pev0aLzsRJydL1rqtwgINjXziG2q
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="334508079"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="334508079"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 18:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="767519184"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="767519184"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Mar 2023 18:01:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 18:01:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 12 Mar 2023 18:01:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 12 Mar 2023 18:01:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqkJbMJZ7OHUP42IXPbjXdT5sMnIZqB43yG2M/6RzopN0+TnMn7SyunKt8hRJvGECek761Z4iieAX+1aXwo2XaUEA7JMNTPihn7YnL5fRlDRooxsRGYyRwpSS4BMdPSzbi++8Rm9ppdSZZBFnmlE5lxby6usKymRGRmOb1u3jvfCtZa41i4tbVnAQ4riCnFQK9QGE2WS5UGGlrkJ3Vht/sBeE2q0XNWoMwmP8jqTgIJJ/H9+Jyu6/ne/sNB/fsIg3sty4GKh5N2asJUkxn+LHZqifRS9qfN5mho+9A3C/oLb1RkGIEteYbm+ci5R98FrD7cuWRGMImutmh1puqki/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1D61WWpaUdShBzdtsbyt/aaLsTyCuIVIxdMtvkITiWg=;
 b=J6jwN01ncoGyaMidHb1ublVAo2/u2ORX04AIbEUXYR/iGL9WemsycC20OVG9uChcVyrkar23oZBuIywZPEQ2CpdiE7XTL4zVkjEMMyDpqAeQuSgMunt19ukQmfdB1ngADVeBB4sJ/wV5ALBm4GffCEOVGpZGCrwkDxzBgQTPoEwGJPGS4ONvP7pDlTWajPfc4qpffP7Sx4iACVDAe17zk8Yr2O2acGy/6stlEaqH9D4N/hU1gcLevPSNt4EsSuigPVsoZuwwzp6RaWgxb6xdD6Pir7IVaTmOkLKxVkTngH8atjKs2e2nDsf9Opxr4qwHBNbqZDOuS/q/GWvyXe2AMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4716.namprd11.prod.outlook.com (2603:10b6:303:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 01:01:06 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 01:01:06 +0000
Date:   Sun, 12 Mar 2023 18:01:03 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        <outreachy@lists.linux.dev>
CC:     Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <greybus-dev@lists.linaro.org>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] staging: greybus: remove tabs to fix line length and
 merge lines
Message-ID: <640e75cfd8fc_229a89294a3@iweiny-mobl.notmuch>
References: <ZAusnKYVTGvO5zoi@khadija-virtual-machine>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZAusnKYVTGvO5zoi@khadija-virtual-machine>
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4716:EE_
X-MS-Office365-Filtering-Correlation-Id: b83f0385-de1f-4e83-1253-08db235e6cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJWoy6FuDGpS3Br6CS00/oTKxyrXzXC1u43eKB5qAo62u1EC0Bw+bjfgySHMu3VK5HmMFvISLx6nc/9lxxuYfM1yWjDwdZ7zx++tqizW4qz/tEaUYb3mHRjbktwNPFiT3PrR2/VYeC/pYXoYPV7pnVMgutEMaqmLIREIqYfGoOsni/7jC0gAksqLYL2wH6SUU2MylBjM6yYavNBqc45g6Fgxavt7jpZ3TWy76KXkDsnPJOAjKsNYaHq41yQAJMAjwM8eku0nUGrGGQQBv6dH4+uw/qTUPfc2TzrhJekoPi0IPdPlHQlUHvas968lEQ3X05Vf4zRxO77f0e/JzDhE6PKO1GJcVwiMvOTFwMx1EQqzETugYmts9SQ2nM27KimjferaMHZMIRHstJYZLjvCZoCcfnB5ScCG6Ye+OH2Gu67siHDnUxvp3YSC51a2MbwH/TGNzd2wh5P3x/UwJ4qcZgqsSPRp80YmVea52sTX4r+PjqtkItGcF9xaRedWpt0/vzJRUk8+HRbrIRFsrRahW1ordQHqq5cEYTvfZyV9K3UyJd8ExBegCQEDogSJRuNC+GBETCsiWi8Cxc3ETjW3D+NNli4CxXeZptkjqhQJoa+yGHAMrsrhKiNaAOWVXhR2enAyhmmO6Gy5Ldl8gU+DtxlwWJu8dltGlcZvOKt8hu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199018)(82960400001)(2906002)(83380400001)(44832011)(5660300002)(66556008)(66946007)(41300700001)(8936002)(4326008)(8676002)(66476007)(38100700002)(54906003)(86362001)(316002)(478600001)(186003)(9686003)(6506007)(26005)(6666004)(6512007)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE82aXlBeVQ3ODlpNTNRcExHN2ordlFVUStxSHJialhTS05Qc25QZnVXYXR1?=
 =?utf-8?B?UUdJYXJWamQ1SzhsZjlVYUlzQ1JFWWtiRUUvMnFyZ3BIVm1PY3gweHZLNGor?=
 =?utf-8?B?RTNzU3lIODhSMXdZSDRma0x1YXRQZWJCZ2JMVzZxM25INUw3SEdvYitadGN4?=
 =?utf-8?B?YTNPVFJ2enJMSU1Ia3hZRUJuV2Jkb0lZSldLT2NqR3FRSjFqVVF0dGpjeGdi?=
 =?utf-8?B?aThUNjBhRExyenNBVHFRYXVJb3pRMFpNWnZML0RhN1N4dFBXQTRZYXc0Z0s3?=
 =?utf-8?B?UFgrWW51bDM5RmVHY2RBK1VEMHNaVE1WMWZiS2dES3NiV3lwbGg1d2czUlZa?=
 =?utf-8?B?NmEwcmVyQkNTS2YvdDJ6dHMwRll2YUYrdGhoL1dVZ2pUUTd6Y1FFZmJrQ2Nu?=
 =?utf-8?B?aEM5NmUzVG5OWitmamM4WXRYQVFrVkhJU2hrVVZOeExudTkyVFdjdU56YTRs?=
 =?utf-8?B?RTJVSGJZMzM4Z1pxTnl1N0MzRmlBVUZvNVFIZjY3Uy8xWTU1Nk1SL2czeWN4?=
 =?utf-8?B?TTN3L0dVbjh4dEdRMGN2WDFocEdYTXlrelBhQVhERVhHZ0FGcVQ3Ykh2aTkx?=
 =?utf-8?B?aHFjcVdxcnkwaTZhNGNUT0NreHlNMzdzMklzMXlmN05oZEtGMjVNR29iOHBo?=
 =?utf-8?B?MFJDSE1FVXZyb0xSNlBUYW9CclhZQjNsSWVRUnNoSTdKV1NPOGlSWHQ3UTRu?=
 =?utf-8?B?dlFYaUowajBKTjdMV2VvSkVPZ0dDNGMva0RhRXNIaVJoRE1aVDNsWE44K1hJ?=
 =?utf-8?B?NEpLczhSL2g4b25QbWpRc3BqMGJYL2FyZzlERGdpQjNVeC9pL3lhakRrTFBP?=
 =?utf-8?B?L2pFYlZaY0t0azhxRUVjZGxDR2FVK2kzMFp2U2xHWXIvWGoxRFZTcThuK2R4?=
 =?utf-8?B?NW12akJKTHJXcmMrNWsrcUJJTXlNMHFCb1ltWS93OEZsc1RqWlM2cWo5S3ZC?=
 =?utf-8?B?VFdUbUFRUE8wOW9yVTA1SUJFMC9qbDZaNXR3SGxyUStvV2s1N1VnMWlLUUs1?=
 =?utf-8?B?RkVKWTcwVGpjb3VjaTY5TVZxNU9PM2s4Sk92U0V4TnJvektaZ3dKVkhKRDMv?=
 =?utf-8?B?Nk0wZmM4NHphK0lwZmQ1Z29wMXo0dVVySFJ4b2trSDl2Sm9VRUJ4L0c2OFIy?=
 =?utf-8?B?dVlYRmZ0a1RmWmpxWmxnNTVXL1pqQndMU1ZpVElRdXA5MGh2Qkd4bmEvRW0v?=
 =?utf-8?B?eGQ5eXYvcGROVGNESjZtSTdZUWFReFhyN1NYcytiZ042cnA1aTRnbnhlVHN2?=
 =?utf-8?B?MUxlUkhxcVVNNHU3YTFxSHJHSkVSQjhON0EyWDF2V0FvSVVzTDQzRlQ4YzhQ?=
 =?utf-8?B?ZEJZTmtPRUVFMzVJVnFRd0x2cUdJbTg0SzZsSFgyZDJKSUczWEY3M284Z0do?=
 =?utf-8?B?dkVJM2ZvSlZYWUtzN2txTDJyUzhURERsc1QxTlFUam9aMHdMMXpkdWdLVzFU?=
 =?utf-8?B?V0gxSVRReXRVdGROVjBZYk4zYVYwUWtnSlJySWdEM2RMUGo0RHVMQlBKcnFu?=
 =?utf-8?B?enA1SjVkVDJ3M1h6cVBianZJbmFJY3g1bmloU3hucTJpTzBwZEYrQUhkbWxE?=
 =?utf-8?B?NXJDR3h4RktHQXIyb2VCRHZmbDlQckNwVlptcjZtNkhCbzFwbnhtbm5vMUNK?=
 =?utf-8?B?RE1UU2g3RnNPWGFKSnFXaEpKWW5pQ3Q2dkU2S2tGMWhXUWVyYXlwSG9lbUhJ?=
 =?utf-8?B?MFVvQVRwaVRJajJtSmZiRW02WFA0aU9iRDBxZWJkZDdWL2h6UzBGTWZrby9F?=
 =?utf-8?B?WlBqQS9xL2pObGRQSVBPSWlCVXVaOU1VUmtHYTlkYUxUTVNIditVZTcvZ0hl?=
 =?utf-8?B?K29EejlDV0dCeTlwOXNodEN4V3ZNWVpVSnNIMVhEejJmMkJCbXUwVU93ZThN?=
 =?utf-8?B?bUJEZWE0M01YclpxUGtsU3NHU3BKOWcvc3k0enVIR203YW9HVXV3QTdxVjhs?=
 =?utf-8?B?dHFTbFRybm95TlEzSTN5SGgzY2tOMStJM0VsOTRGcVV4VnVzK1VaTEZvNFRr?=
 =?utf-8?B?bGFzenFFSlNScm4zRVlMLzE4K25YU3V3YmwrbGlaNUhLZDRsRjF3dENHbzZZ?=
 =?utf-8?B?MXh4NnlWTVlEY2NEeEdWK1ZJTXEyYWhVT29pR3RuY0cxNlJ0ZG5BN2N3R3dF?=
 =?utf-8?Q?3+DACBNe1k2Pj2ltBe18iSQmY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b83f0385-de1f-4e83-1253-08db235e6cce
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 01:01:06.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhifhUhpqJ01djh3+A+DCj1J6LiMWlT0oG8vRW9hw43X/QMy61lgCajCQ78kwObH6JebMYetcnq4X75KO4oHpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4716
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khadija Kamran wrote:
> In file drivers/staging/greybus/arche-platform.c,
> - Length of line 181 exceeds 100 columns, fix by removing tabs from the
>   line.
> - If condition and spin_unlock_...() call is split into two lines, join
> them to form a single line.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>

Fundamentally the problem with arche_platform_wd_irq() is that the
indentation is too great.

"... if you need more than 3 levels of indentation, you’re screwed anyway,
and should fix your program."

	-- https://www.kernel.org/doc/html/v4.10/process/coding-style.html#indentation

I think a better solution would be to refactor the entire function.  This
would make the logic of the function more clear as well IMHO.

Here is another tip to help:

https://www.kernel.org/doc/html/v4.10/process/coding-style.html#centralized-exiting-of-functions

Do you think you could try that?
Ira

> ---
> Changes in v2:
>  - Change the subject and log message
>  - Merge if condition and spin_unlock...() from two lines to one 
>  drivers/staging/greybus/arche-platform.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index fcbd5f71eff2..00ed5dfd7915 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -176,12 +176,10 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
>  				 * Check we are not in middle of irq thread
>  				 * already
>  				 */
> -				if (arche_pdata->wake_detect_state !=
> -						WD_STATE_COLDBOOT_START) {
> +				if (arche_pdata->wake_detect_state != WD_STATE_COLDBOOT_START) {
>  					arche_platform_set_wake_detect_state(arche_pdata,
> -									     WD_STATE_COLDBOOT_TRIG);
> -					spin_unlock_irqrestore(&arche_pdata->wake_lock,
> -							       flags);
> +						WD_STATE_COLDBOOT_TRIG);
> +					spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
>  					return IRQ_WAKE_THREAD;
>  				}
>  			}
> -- 
> 2.34.1
> 
> 


