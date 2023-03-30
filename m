Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8656CF8DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjC3Bvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjC3Bvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:51:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78FE4EEF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680141101; x=1711677101;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mm+u8d8e5MtP2s5LQy7cOJHnTqOYv6E9J6A9rwfZd1M=;
  b=WIQ3kHJ29Mo27VY/8d0SATMzgW3MzSuLl/2FCU7EsPYiStfTnokr+Yts
   xc8Yt53Q6ACnWS70xn4opwDruJCVJrFaBuR3ycisKRG15W5r0/eyZuOR9
   jAkXojnsem9PYEPGv2XAOto13Ru80Zoi4qYQuGViwZBGvYjqSAdToh5Az
   3NX7m1rKrLNVqoBdpEbeuO9REq4vplj4GDFInbJZUCcppJGMxi/QjgxGc
   NjCO5tRd7DQCVARiTldp2T2uByNtJyu1B+H5mvZe49f2jnD4UKKmJvwv5
   yKiD5LfMt3V9tOvOaNyxnKxxRLAQ/LpXqGPjC6CDeCOcOAf0gLVJvbszt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="338546131"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="338546131"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 18:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="753809526"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="753809526"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 29 Mar 2023 18:51:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 18:51:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 18:51:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 18:51:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx3wV0DdEJv0UBcQjwxbQ20po6qWk30gHfyTZeuin/NOtQh4g6o/NJ1BWPsnyYBncBlv8vZgqnbEF7QCL7TkLxYdIN7A/kzAzAi0/VBXUKWcSHsioRruXe8Qy2UKED7Jak5+v14WYb2iE2PznG3OYUNbPBHCh18pkZIa3ILXyw1MqSw2mcgNvspfvFlVUt5k9rU9qZwHVv9Oa49lhkRPmJLBlz/olapH+z5+R8SfL908h4nogCd17oxscH78fGG46SH9d0dyhk7zXlQLAqG/eLUI6cReUy4ZjjkI4PNbKoq81sD8Ub8+kF03znF13B/OewSOYt0wrN9cU78cqQy68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RH5KWTau+2bxa4QWvIABcRFVjXI6pIN9Akt2yliHiao=;
 b=hVSBDJtQkLeZop38+9ub8mKeCJEPzDMTN88TpcUX8jTI9bZfRKF7K4Qlz27Lf99sLJOt3vQ4RYa2EuBrp71MOP2rkh+UDr2RKBG+6l86lYyUNC2ifX9TgpFjGStptWTtVuDn82aYZSUiYuTU2DOW2i0uJB+r2SjMcGCTRdkdcNWVJ1QoyI2WFrNnNaA7M7EpP64G7wgu4ASwY1UWADlfSO3kbL6Ru6ez94+8S2XXvr6RMrAT+pOU+Yjzv3DdPNCcKaxWNMBb+THTlqxtgJgqvzPFdrE76nfSSk525KpkaRN1hr182kc4j1+PLRFp1BNlPChsNpVDZ26F3KjRzr7JXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Thu, 30 Mar
 2023 01:51:34 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6178.038; Thu, 30 Mar 2023
 01:51:34 +0000
Date:   Thu, 30 Mar 2023 09:51:19 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Chris Hyser <chris.hyser@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <dietmar.eggemann@arm.com>,
        <peterz@infradead.org>, <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/numa: Fix divide by zero for
 sysctl_numa_balancing_scan_size.
Message-ID: <ZCTrF/YtBLdLLdup@chenyu5-mobl1>
References: <20230329162610.4130188-1-chris.hyser@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230329162610.4130188-1-chris.hyser@oracle.com>
X-ClientProxiedBy: SGAP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::27)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DM8PR11MB5702:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ebf3048-d00c-4775-f7e6-08db30c14ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBs5Dt77kDJyrk128WsW7//tkFXxjp4SxpRIeoKc0r+tRJp0ARtq8QQ9zaLo5oTksm0Rstd27Ya3m9buIf4ZeqLp9u69IRuWpZar3e1Nppngjn1Ufm+VS85AGstBpd1tMrTsrvK1DcU2T/uOA5LNYvDu24Hb9oS3R8cxtvj49oZDZrZGSwSYScP0ejJqrp2gEm3AjqCvjd7nJsLL7T2OQ0KUv1Gws1xZp21dRUCiXBIvWgmSbks8AejUQNM3ousZmFY4ZD2xWco6loUc2BGrzz3GYeQb49wVsYAjylix3GNLMTs9T5BSV6V2vVF0fdubQwa4cmtRlV3ug4EbXGgeuYVQD2ORSJQpg6+4F+Z09ZgD+MqgIPN+yykVqyyCK70+j0s6Aedyf8qlY8jyYoTTh7vPZ3osmm5h7alq+4/El+SlXEVRSyo6P8MhfwT+haVisbmQZ0jCLOGpjW8ii833OitJT5UCMxYhtj0RQjnqynqryUgfMdIjUnqh9pL4pHGFdSeqR+S1fYuMhpNL9DEHiYe08g8z093sO2qCFBCu5yGoIxaB1cYz7BoJZmOTpmX9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199021)(83380400001)(186003)(53546011)(9686003)(26005)(6512007)(6506007)(6666004)(478600001)(6486002)(82960400001)(41300700001)(8676002)(66556008)(66476007)(4326008)(66946007)(6916009)(38100700002)(2906002)(5660300002)(86362001)(33716001)(8936002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/EHHujrElsgRptoxDDPD/nppSLW0FWv8McIu0wrOys5D+JWJL+BySl5saiZ7?=
 =?us-ascii?Q?BXwhOLTorvDtfh8RITDvsuSDbNLU61wghpY8jP/4BGZKUy1ygtNmJfbibvvi?=
 =?us-ascii?Q?kzvpy19ZQy4ROR/m9dKy/J4+Lq4vkeD/DjIkW1ixOKeF/Fb6vKJ7qbtzjorA?=
 =?us-ascii?Q?XOsWJ/laUyXW7AWzBK7MnJZeCCGyoLCuST3wWlgvG5bs2O0TsiJyUFjkNBuX?=
 =?us-ascii?Q?8vytRhcRn1s7d0Zsoroisi62GM4HywnBUcqkpQEQL4YJGI7nPTTWoDUUiqcO?=
 =?us-ascii?Q?wwZNzMt8dc8RoEqiTyxOL+KfRaNhnRjwta6uviISBAgnGAkKd49pa6SHww9/?=
 =?us-ascii?Q?eSxozmqB9FejHUWU0jTtzxBjQRXES3PXVaqs7brD4pabCfHCDlK6rybeaObF?=
 =?us-ascii?Q?aWjtdPOC2ky7/tzrajXOb2vHaOrFq3bQC7+w1TFGtoYZMDgcOeL79sJzOKM+?=
 =?us-ascii?Q?zXDpOCMRXTqjnjLZItDjH47HK+gx7LrveTiIZjLudC901O4Lvn+Hn6Rj8UlZ?=
 =?us-ascii?Q?xVmocBpjfgAtATGsG9hahgjrW9l5vQeGWj1scrkcteGZ5FMOCJrFNBCOkc6d?=
 =?us-ascii?Q?9n8tq9YBKlsilVrAWgzkylyi9qIlTcLwXiQQyj+fMT/OFer/c3pc1Kqi9E2z?=
 =?us-ascii?Q?SJj+Ejfj0OAk57mpj/a7H0W7nyZGVVw7OIkCyg5z/YtKHWKmbFYkDOGN1vU/?=
 =?us-ascii?Q?ajfpzK+gtEMtcRYCHQ/bdKmLCW/En9arY0yn09dnLTwnCVhcHINN8OHjbjDy?=
 =?us-ascii?Q?ToYq7/rcd6M8DDLl+3baXgfVL4ODMq2QO9xO8rYTUcXWHbqauEdGbvRjSLDu?=
 =?us-ascii?Q?CoYfO8fxF2Qurf0iD4zxmzFJhRpCG3pooTXRUxVNvHfj8evQFlWunP/hJEXo?=
 =?us-ascii?Q?2CiZGL/6B8xwVCVvBHsIHRVz0uBe3Cg7b0peb2u15O7349Jt9hS/w44OU61I?=
 =?us-ascii?Q?D5/bcF67IhJFpFJjSo8pdErkRfUfzQzzIwxlPtDvD9znOAySU5yTR8aPJQG+?=
 =?us-ascii?Q?OEEcy0f2zDsQZogQ+nQJJWsoXocr/EFJg5vFKjF4cH8gmMbgOJ5+/O7moHCS?=
 =?us-ascii?Q?LBEFYQUkkyRQTfvB9Afk4K8XharPH8i7Qs4XVYzmBDShOdHtkm4LzPeXSQee?=
 =?us-ascii?Q?cr5xhI0WCstB91UmGtiiSasbxL5zQJ55buY/WSeCgPMSuIVSgR5rLIImIy6o?=
 =?us-ascii?Q?2fUN0SHsMj7jVMcZ99t7qyW9kj/hE4oK7DE6zQmGq4osvhLvvrIBhkXRYroi?=
 =?us-ascii?Q?zIZ0Fes+QinWpp02oMZGSPk0kEVLICRPfmIUNDz8ar7TH/Z+SLeNfeHUQ3b8?=
 =?us-ascii?Q?hYfCsbaobBTsBubCL5yMTBXndM6mAq8OT+tPOfMKabhpdjX+CQ1+UvQToTGr?=
 =?us-ascii?Q?CvrxwIdWBtkDFUs2K09LaojWf4TZVzScciS00wEzhkWKh/bmCRvXQW5O/tJk?=
 =?us-ascii?Q?xaws/62FfbX4ffIGz/rgf59uCtDLpJMnpdp8zRkvN4j4Be7UanM4l+HS9UPy?=
 =?us-ascii?Q?6WlZjhKWZ31EOwKpMS4sF6yq0QokX8yIOPsTeZaENJlHMDfbYfktxCIvieKN?=
 =?us-ascii?Q?/l3xh7rSm5APPNqhCwMavw6/op4z0xXHBHNQLmwW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebf3048-d00c-4775-f7e6-08db30c14ae3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 01:51:34.8363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gmUJbp7HaWJCposiZ+LsS5bTR0mv6K2cGKJ1aOIupKN5BguvOUKDNgcez5KitEXTKgWaOJBvCctFmrVpKB1VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5702
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-29 at 12:26:10 -0400, Chris Hyser wrote:
> From: chris hyser <chris.hyser@oracle.com>
> 
> Commit 6419265899d9 ("sched/fair: Fix division by zero
> sysctl_numa_balancing_scan_size") prevented a divide by zero by using
> sysctl mechanisms to return EINVAL for a sysctl_numa_balancing_scan_size
> value of zero. When moved from a sysctl to a debugfs file, this checking
> was lost.
> 
> This patch puts zero checking back in place.
> 
> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
> ---
>  kernel/sched/debug.c | 50 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 1637b65ba07a..dfd0fe6123ec 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -278,6 +278,54 @@ static const struct file_operations sched_dynamic_fops = {
>  
>  #endif /* CONFIG_PREEMPT_DYNAMIC */
>  
> +#ifdef CONFIG_NUMA_BALANCING
> +
> +static ssize_t sched_numa_scan_write(struct file *filp, const char __user *ubuf,
> +				     size_t cnt, loff_t *ppos)
> +{
> +	char buf[16];
> +	unsigned int scan_size;
> +
> +	if (cnt > 15)
> +		cnt = 15;
> +
> +	if (copy_from_user(&buf, ubuf, cnt))
> +		return -EFAULT;
> +	buf[cnt] = '\0';
> +
> +	if (kstrtouint(buf, 10, &scan_size))
> +		return -EINVAL;
error code of kstrtouint() includes -ERANGE other than -EINVAL, how
about return the error code directly?

thanks,
Chenyu
