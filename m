Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0732D70D275
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjEWDj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEWDjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:39:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2259491;
        Mon, 22 May 2023 20:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684813162; x=1716349162;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B/S32ugz0UIIHtmqLdEW3oVHgrnnqAm7ZeCJsxjY+yE=;
  b=JVwzmk/j4DG9+VLPwySJwodnns3R6/jWb2LWdGJzaOhUJLCj/bbILCqy
   B/5kLDy9oW49tb6Y8QqPydlk7+rEUm593iySOJygDy0DfpXVNHOXsGnR/
   mTaKdY6l4/peBHpRt4ubIAiH0ew7aBWuw5IsVMHMcsEZOt7BrwMaDUsgl
   Jjy/NARGT1eIJHi4GWfQxSjsfhdcaWR3NcmpfJROicF5HFXuWcbUg83BI
   WoG57jVssCkazdzo3jd16eyWu8/KV4vKHIVa6UwBh8df+Kqhoc2DsFaT5
   lom+95QM2sanlrQ3bPfCE6l8UFV4x2iUXAKIY+owVruonu2dsmMKnSHf0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="350626012"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="350626012"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 20:37:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="734596824"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="734596824"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 22 May 2023 20:37:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 20:37:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 20:37:07 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 20:21:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaE/rn5L41TEC+uoJ5cKOxCuGy4WN2iIWwLkda8xYz+Z2MCKlpW9vm4amfrWXi/UwHRHST0NRPlz2vxLz/60MPFRem/zfC3t8IBtmbatfNk+tmnUoH4sfI2QL6XZxvLP7hks4ESYWiGCMIfdcGraouzeOuARUYx9/IvY7Ae+XIoSDYTaXObkvAQyYZn1QGSeJtxs3cDrTFFmspWGW2F/0Lq3X6harVW4p3mqVgX0Wf08V9Kv8s7IJhFJeJMLaolyGIB8KN/KOmb8Nzyk5swBcxuLWg7ymzRlMXpzIt+3wWjIobzp15OhH52pBxhvd16t8WbYsgPIeEvguMR6CLhmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+4ji8K5WRc+wj/EbWAeaDz7vCllf39/cMvMf7gXd1s=;
 b=QjDwZCNFBLNd062z2cs+cL0shpku8Byx9dKaAbuNllQh94fRNw+3Fac9t/feyt5/0LBfl88yCrmkP7Cm/WMfZa6kLncrjrZSpe/P/Yxvk7hc8XkxnoRHVi9aECThHoqrkRm2TyKLjS6qpxs5t9nSJE8y2p0GOlIkIj5mrspuSAHNeL1NSs6LbRj3uZI5z7NyxZnL5opj/EfF8Qu/3LYE8ZGd+KFGKxpCgDi8tFlxiM4R2pWDKkBexvoCgfrlMKanb1/ErT8a+GtVeCy1XIKRYt4tgUUt4Y5Xw7mUT5fCpVt+Cb5LerR3LnZLgvcHGvaYcJjAkKU2zvrZEXzaoNd6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7875.namprd11.prod.outlook.com (2603:10b6:930:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 03:21:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 03:21:38 +0000
Date:   Mon, 22 May 2023 20:21:35 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Russ Weight <russell.h.weight@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>
Subject: RE: [PATCH 3/4] cxl: add a firmware update mechanism using the sysfs
 firmware loader
Message-ID: <646c313f20907_33fb329412@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
 <20230421-vv-fw_update-v1-3-22468747d72f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230421-vv-fw_update-v1-3-22468747d72f@intel.com>
X-ClientProxiedBy: BYAPR07CA0073.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: be5c6ba0-febd-4780-551e-08db5b3cd188
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cRHryFgY/h2GTAkcB25Mxt2GFd1pYl3onAY7EaH3on7vR4spkE15cNRQYeBkKYxVyW5GVswAgKv6qUNMie1sT7nTahIo87QbLZXOJd7e4xCFfww/j3maTzD443J6MO8vG2PYr5YQ1KIHp1C0bPn7BmUq386LFLeSj97rrO5XVAjvbEPW5U6ItFpiR0sWledwbFgdAID+zaJot3vFev25z3br+v9zFILXeEEg8ue7IdLjRFiJmEBPfTp0Iwco+IJKe4ES3RcrLjmtSwv03jN8ZHNOzcOo9eY0KEnD0pzlJrtjkW/6MM2GFOGyS+PS45gS2tczVphcqgxfoRfXuR2QqnwI6cFdfQIyyUIR4UFq0t4+J7V04Z0CC4sVX4GVCFiN2/zy+dxu7nv8fFbyaP/GCc/9Vq55O4w4kWEq0RHturWJU/FIg+WbqQ8ZrV7CbywJb993PR+MZw4RQOrM18+Y9ZjizwpGDv6mqOnV3qJ0L0l5vZzDqgo/I0Ank+QMO39U3tSuuZ0azFrWs+un+5HRH96DhwbkOIffS0xTEi4BnoeTbdHGG658/6KR8Zle+68m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199021)(6486002)(186003)(83380400001)(30864003)(2906002)(15650500001)(4326008)(66476007)(66946007)(41300700001)(66556008)(6666004)(316002)(54906003)(478600001)(110136005)(5660300002)(26005)(6512007)(6506007)(9686003)(107886003)(8676002)(8936002)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ruIvNyWG0j0ykRWZVcARJX+rJoXZ6IevvUqy5CDo6I6KnYWb44CyJzwmbxB7?=
 =?us-ascii?Q?wuz7tCwfbfvQP8pR5H09veYLnLyiDdwKkRYnpgOnzkaXNoFDxTbbG/sSMjSS?=
 =?us-ascii?Q?fgI3EoWwMpdZO6A6CtvUw8JbNVuJRIOqvY7wDzGv+SYjEoe7bFFsOV88oKh5?=
 =?us-ascii?Q?M4WSV0kVdXAexYsjeFlufg/bPlDVmpVCZorStbNJXoL5Uj2/1K99gwdNHav9?=
 =?us-ascii?Q?NZZo3vlG51zvHhOd6gAM5gVWecJd6oOy4Px0w9L+BcXR+4iFLYSqScHZCDSW?=
 =?us-ascii?Q?iSVlUc8wq2hX8oawXwfPMtNx6Eox7EPp1/zWYko4YsZLA3RWWKSWsSvjw1sT?=
 =?us-ascii?Q?/DsyGyLe7q9rsPu2eSlWZfsBF55Z9s6p1vd3jMJtA9LrFTQI9TIRp8UjgHOU?=
 =?us-ascii?Q?gezGK/sLx4DH8d4b9dvHvwpk+YG8uZFsmN2Anbt0afjzEPMCS8CCEXAfVA+c?=
 =?us-ascii?Q?IzhdFYI1Jf6hFysPkE0r4uTIqFZnolwkgoIxfHbQEzBRcugPhMP/Z8/uC2T8?=
 =?us-ascii?Q?m2inmEBKmIYC81QPQlm6ZK0daylYSBGA72feQZaTAr93DpJI+cNY1hisL72+?=
 =?us-ascii?Q?LXDNFBg8FPEvlfK1CnjYYAFI8y0V5z2Fq+ZL7rBG4RVZx23Zqfj0criWQ1eV?=
 =?us-ascii?Q?40NNTY1O97+pjd+IfaCXIGT1XJo3lMFOz5qaQ7zYVejGOiqzhD2AQ/C0QSFJ?=
 =?us-ascii?Q?0WgwGSlL6UtVObigmZeutqBjDF1hYnVX9lzYaf1XvnTMp7DaV4q9t3DIi6TX?=
 =?us-ascii?Q?lc0UZBfMLNcHZTz9CtMfPTsQV2LWfMQhHn0FJONT22ZeLUz7osWPjSJbWv61?=
 =?us-ascii?Q?uWnMJd2FGA/JpLfa4kepqRSeD2UmwyO6eCQ1Kj+lGr24/Wk2BZj1zfXg2TM2?=
 =?us-ascii?Q?kbpaWEeuRJ2nIyCtx62OflHbRs+beyaBGJ6vI6/XdBmIBGhLb3vpFdVcVFv9?=
 =?us-ascii?Q?63D7yZK0BlUB8/cNByDkg7HTTPEJJ+4NnU7XsOGtaoTMLudqYp908OiLONaw?=
 =?us-ascii?Q?UAZ3Nn2Hb7E1vcg4EKXI0MW8+gGHPEL7vav3dk2lnnkMKnhD25seVWBiTnkY?=
 =?us-ascii?Q?qMoozjgBnDzXSBNi8vuHqLMMbOCQxoppAYnYfoyAS8erMClnzl831ov7ptjC?=
 =?us-ascii?Q?8SSXVJvvWi77EA6qClLzF4OeEO/AZGdTXLJg0FuWoefVyo0+6Mn3kz5HLnEk?=
 =?us-ascii?Q?OSqTHoCs5+5q0zr5RJb5oeyi+g7teCuhgsMOE49OoUEdaR1PAJM0plhIM9Te?=
 =?us-ascii?Q?RRMr4lAQC4PDUAHt9z4WpwgDrMASF1Rqi1+jbCrC5jispvszmcO9oldH8BSU?=
 =?us-ascii?Q?cekKQSiHSgNundPT9D8CNod8LL+hipEC7l2A4od7ldrQl2nB3Qo0oc51XMsd?=
 =?us-ascii?Q?OtDWcUX7yYXNrTVNQYA8YZBSciqhfRDHDVeSTQvSX5JLAe+E2Zjt2slazfZS?=
 =?us-ascii?Q?JjSzknGK0xd9XsLUjHFHdcyXiW4yO3gwwzgGJBBE2lJnbGsz5SVFkGBJg3PJ?=
 =?us-ascii?Q?HS750uQjl1oWSPfZW8vWDhVh5pDl4U6WNkSNSj7dPrnX9i0GrLIt4XKUPhhb?=
 =?us-ascii?Q?1jSOTsou47Ac4Ll36+jZCcIqemQ+WR5VGtGzAhG7aFxOppD7gTMNuB47mQ3N?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be5c6ba0-febd-4780-551e-08db5b3cd188
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 03:21:37.7611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gI57Cvs/rQ4yHwYngYkqvfP1T5LCTKOZDHz0U3rr1I9f5OCrRygKJgGbUcoFFQ8h7lqDIcVe4cDh+KiTixHNIlN9rucg/Dx+Vl/v+8W1Vb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7875
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vishal Verma wrote:
> The sysfs based firmware loader mechanism was created to easily allow
> userspace to upload firmware images to FPGA cards. This also happens to
> be pretty suitable to create a user-initiated but kernel-controlled
> firmware update mechanism for CXL devices, using the CXL specified
> mailbox commands.
> 
> Since firmware update commands can be long-running, and can be processed
> in the background by the endpoint device, it is desirable to have the
> ability to chunk the firmware transfer down to smaller pieces, so that
> one operation does not monopolize the mailbox, locking out any other
> long running background commands entirely - e.g. security commands like
> 'sanitize' or poison scanning operations.
> 
> The firmware loader mechanism allows a natural way to perform this
> chunking, as after each mailbox command, that is restricted to the
> maximum mailbox payload size, the cxl memdev driver relinquishes control
> back to the fw_loader system and awaits the next chunk of data to
> transfer. This opens opportunities for other background commands to
> access the mailbox and send their own slices of background commands.
> 
> Add the necessary helpers and state tracking to be able to perform the
> 'Get FW Info', 'Transfer FW', and 'Activate FW' mailbox commands as
> described in the CXL spec. Wire these up to the firmware loader
> callbacks, and register with that system to create the memX/firmware/
> sysfs ABI.
> 
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/cxl/cxlmem.h                    |  79 ++++++++
>  drivers/cxl/core/mbox.c                 |   1 +
>  drivers/cxl/core/memdev.c               | 324 ++++++++++++++++++++++++++++++++
>  Documentation/ABI/testing/sysfs-bus-cxl |  11 ++
>  drivers/cxl/Kconfig                     |   1 +
>  5 files changed, 416 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8c3302fc7738..0ecee5b558f4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -48,6 +48,8 @@ struct cxl_memdev {
>  	struct work_struct detach_work;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_nvdimm *cxl_nvd;
> +	struct fw_upload *fwl;
> +	const char *fw_name;
>  	int id;
>  	int depth;
>  };
> @@ -220,6 +222,80 @@ struct cxl_event_state {
>  	struct mutex log_lock;
>  };
>  
> +/*
> + * Get Firmware Info
> + * CXL rev 3.0 section 8.2.9.3.1; Table 8-56
> + */
> +struct cxl_mbox_get_fw_info {
> +	u8 num_slots;
> +	u8 slot_info;
> +	u8 activation_cap;
> +	u8 reserved[13];
> +	char slot_1_revision[0x10];
> +	char slot_2_revision[0x10];
> +	char slot_3_revision[0x10];
> +	char slot_4_revision[0x10];
> +} __packed;
> +
> +#define CXL_FW_INFO_CUR_SLOT_MASK	GENMASK(2, 0)
> +#define CXL_FW_INFO_NEXT_SLOT_MASK	GENMASK(5, 3)
> +#define CXL_FW_INFO_NEXT_SLOT_SHIFT	3
> +#define CXL_FW_INFO_HAS_LIVE_ACTIVATE	BIT(0)
> +
> +/*
> + * Transfer Firmware Input Payload
> + * CXL rev 3.0 section 8.2.9.3.2; Table 8-57
> + */
> +struct cxl_mbox_transfer_fw {
> +	u8 action;
> +	u8 slot;
> +	u8 reserved[2];
> +	__le32 offset;
> +	u8 reserved2[0x78];
> +	u8 data[];
> +} __packed;
> +
> +#define CXL_FW_TRANSFER_ACTION_FULL	0x0
> +#define CXL_FW_TRANSFER_ACTION_START	0x1
> +#define CXL_FW_TRANSFER_ACTION_CONTINUE	0x2
> +#define CXL_FW_TRANSFER_ACTION_END	0x3
> +#define CXL_FW_TRANSFER_ACTION_ABORT	0x4
> +#define CXL_FW_TRANSFER_OFFSET_ALIGN	128
> +
> +/*
> + * Activate Firmware Input Payload
> + * CXL rev 3.0 section 8.2.9.3.3; Table 8-58
> + */
> +struct cxl_mbox_activate_fw {
> +	u8 action;
> +	u8 slot;
> +} __packed;
> +
> +#define CXL_FW_ACTIVATE_ONLINE		0x0
> +#define CXL_FW_ACTIVATE_OFFLINE		0x1
> +
> +/**
> + * struct cxl_fw_state - Firmware upload / activation state
> + *
> + * @fw_mutex: Mutex to serialize fw update requests
> + * @clear_to_send: Initial checks done, ready to start FW transfer
> + * @cancel: Cancel any in-progress FW upload
> + * @next_slot: Slot number for the new firmware
> + * @info: Get FW Info structure
> + * @activate: Activate FW structure
> + * @transfer: Transfer FW Info structure
> + */
> +struct cxl_fw_state {
> +	struct mutex fw_mutex;
> +	bool clear_to_send;
> +	bool oneshot;
> +	bool cancel;
> +	int next_slot;
> +	struct cxl_mbox_get_fw_info info;
> +	struct cxl_mbox_activate_fw activate;
> +	struct cxl_mbox_transfer_fw *transfer;
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -256,6 +332,7 @@ struct cxl_event_state {
>   * @serial: PCIe Device Serial Number
>   * @doe_mbs: PCI DOE mailbox array
>   * @event: event log driver state
> + * @fw: firmware upload / activation state
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -295,6 +372,7 @@ struct cxl_dev_state {
>  	struct xarray doe_mbs;
>  
>  	struct cxl_event_state event;
> +	struct cxl_fw_state fw;
>  
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
> @@ -307,6 +385,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
>  	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
> +	CXL_MBOX_OP_TRANSFER_FW		= 0x0201,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 4b0c7564d350..bdeb5495d1cc 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1120,6 +1120,7 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  
>  	mutex_init(&cxlds->mbox_mutex);
>  	mutex_init(&cxlds->event.log_lock);
> +	mutex_init(&cxlds->fw.fw_mutex);
>  	cxlds->dev = dev;
>  
>  	return cxlds;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 28a05f2fe32d..8f61b1e526ae 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. */
>  
> +#include <linux/firmware.h>
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/idr.h>
> @@ -214,6 +215,8 @@ static void cxl_memdev_unregister(void *_cxlmd)
>  	struct cxl_memdev *cxlmd = _cxlmd;
>  	struct device *dev = &cxlmd->dev;
>  
> +	firmware_upload_unregister(cxlmd->fwl);

I think this wants to be a separate devm_add_action_or_reset() callback
registered from the setup side.

> +	kfree(cxlmd->fw_name);

Not sure ->fw_name is needed, see below.

>  	cxl_memdev_shutdown(dev);
>  	cdev_device_del(&cxlmd->cdev, dev);
>  	put_device(dev);
> @@ -315,6 +318,320 @@ static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +/**
> + * cxl_mem_get_fw_info - Get Firmware info
> + * @cxlds: The device data for the operation
> + *
> + * Retrieve firmware info for the device specified.
> + *
> + * Return: 0 if no error: or the result of the mailbox command.
> + *
> + * See CXL-3.0 8.2.9.3.1 Get FW Info
> + */
> +static int cxl_mem_get_fw_info(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_mbox_get_fw_info *info = &cxlds->fw.info;
> +	struct cxl_mbox_cmd mbox_cmd;
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_FW_INFO,
> +		.size_out = sizeof(*info),
> +		.payload_out = info,
> +	};
> +
> +	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +}
> +
> +/**
> + * cxl_mem_activate_fw - Activate Firmware
> + * @cxlds: The device data for the operation
> + * @slot: slot number to activate
> + *
> + * Activate firmware in a given slot for the device specified.
> + *
> + * Return: 0 if no error: or the result of the mailbox command.
> + *
> + * See CXL-3.0 8.2.9.3.3 Activate FW
> + */
> +static int cxl_mem_activate_fw(struct cxl_dev_state *cxlds, int slot)
> +{
> +	struct cxl_mbox_activate_fw *activate = &cxlds->fw.activate;
> +	struct cxl_mbox_cmd mbox_cmd;
> +
> +	if (slot == 0 || slot > cxlds->fw.info.num_slots)
> +		return -EINVAL;
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_ACTIVATE_FW,
> +		.size_in = sizeof(*activate),
> +		.payload_in = activate,
> +	};
> +
> +	/* Only offline activation supported for now */
> +	activate->action = CXL_FW_ACTIVATE_OFFLINE;
> +	activate->slot = slot;
> +
> +	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +}
> +
> +/**
> + * cxl_mem_abort_fw_xfer - Abort an in-progress FW transfer
> + * @cxlds: The device data for the operation
> + *
> + * Abort an in-progress firmware transfer for the device specified.
> + *
> + * Return: 0 if no error: or the result of the mailbox command.
> + *
> + * See CXL-3.0 8.2.9.3.2 Transfer FW
> + */
> +static int cxl_mem_abort_fw_xfer(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_mbox_transfer_fw *transfer;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	transfer = kzalloc(sizeof(*transfer), GFP_KERNEL);
> +	if (!transfer)
> +		return -ENOMEM;
> +
> +	/* Set a 1s poll interval and a total wait time of 5 minutes */
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_TRANSFER_FW,
> +		.size_in = sizeof(*transfer),
> +		.payload_in = transfer,
> +		.poll_interval = 1000,
> +		.poll_count = 300,

Hung task timeouts start firing at 120 seconds
(CONFIG_DEFAULT_HUNG_TASK_TIMEOUT). The block layer gives up on disk I/O
by default at 30 seconds. Is 300 just an arbitrary choice and can we get
by with 30 for now?


> +	};
> +
> +	transfer->action = CXL_FW_TRANSFER_ACTION_ABORT;
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	kfree(transfer);
> +	return rc;
> +}
> +
> +static void cxl_fw_cleanup(struct fw_upload *fwl)
> +{
> +	struct cxl_memdev *cxlmd = fwl->dd_handle;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	cxlds->fw.clear_to_send = false;
> +	cxlds->fw.cancel = false;
> +	cxlds->fw.next_slot = 0;
> +}
> +
> +static enum fw_upload_err cxl_fw_prepare(struct fw_upload *fwl, const u8 *data,
> +					 u32 size)
> +{
> +	struct cxl_memdev *cxlmd = fwl->dd_handle;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	if (!size)
> +		return FW_UPLOAD_ERR_INVALID_SIZE;
> +
> +	if (size + sizeof(struct cxl_mbox_transfer_fw) < cxlds->payload_size)
> +		cxlds->fw.oneshot = true;
> +	else
> +		cxlds->fw.oneshot = false;
> +
> +	if (cxl_mem_get_fw_info(cxlds))
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +
> +	if (cxlds->fw.cancel) {
> +		cxl_fw_cleanup(fwl);
> +		return FW_UPLOAD_ERR_CANCELED;
> +	}
> +
> +	cxlds->fw.clear_to_send = true;
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
> +				       u32 offset, u32 size, u32 *written)
> +{
> +	struct cxl_memdev *cxlmd = fwl->dd_handle;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mbox_transfer_fw *transfer;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc, num_slots, cur_slot;
> +	u32 cur_size, remaining;
> +	size_t size_in;
> +
> +	*written = 0;
> +
> +	/* Offset has to be aligned to 128B (CXL-3.0 8.2.9.3.2 Table 8-57) */
> +	if (offset % CXL_FW_TRANSFER_OFFSET_ALIGN) {

Could use IS_ALIGNED() here to save open coding it.

> +		dev_err(&cxlmd->dev,
> +			"misaligned offset for FW transfer slice (%u)\n",
> +			offset);
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +	}
> +
> +	/* Pick transfer size based on cxlds->payload_size */
> +	cur_size = ALIGN_DOWN(min((size_t)size,
> +				  cxlds->payload_size - sizeof(*transfer)),

A few notes.

- min() in terms of given type is min_t() to save that open-coded cast

- what is the align for? I.e. @size must bw 128-byte aligned,
  ->payload_size is a power of 2 starting at 256 bytes, and
  sizeof(*transfer) is 128.

So I think this can just be:

	cur_size = min_t(size_t, size, cxlds->payload_size - sizeof(*transfer));




> +			      CXL_FW_TRANSFER_OFFSET_ALIGN);
> +	remaining = size - cur_size;
> +	size_in = cur_size + sizeof(*transfer);
> +
> +	mutex_lock(&cxlds->fw.fw_mutex);

What is this lock protecting? I.e. will the fw_loader really try to send
multiple overlapping firmware update attempts?

> +	if (!cxlds->fw.clear_to_send) {

I tend to prefer atomic bitops for state flags, especially if that lets
you get away without a lock.

> +		dev_err(&cxlmd->dev, "firmware_loader prep not done\n");
> +		rc = FW_UPLOAD_ERR_BUSY;
> +		goto out_unlock;
> +	}
> +
> +	if (cxlds->fw.cancel) {
> +		rc = cxl_mem_abort_fw_xfer(cxlds);
> +		if (rc < 0)
> +			dev_err(&cxlmd->dev, "Error aborting FW transfer: %d\n",
> +				rc);
> +		cxl_fw_cleanup(fwl);
> +		rc = FW_UPLOAD_ERR_CANCELED;
> +		goto out_unlock;
> +	}
> +
> +	/* Determine next slot from fw_info */
> +	num_slots = cxlds->fw.info.num_slots;
> +	cur_slot = FIELD_GET(CXL_FW_INFO_CUR_SLOT_MASK,
> +			     cxlds->fw.info.slot_info);
> +
> +	/*
> +	 * Slot numbers are 1-indexed
> +	 * cur_slot is the 0-indexed next_slot (i.e. 'cur_slot - 1 + 1')
> +	 * Check for rollover using modulo, and 1-index it by adding 1
> +	 */
> +	cxlds->fw.next_slot = (cur_slot % num_slots) + 1;
> +
> +	/* Do the transfer via mailbox cmd */
> +	transfer = kzalloc(size_in, GFP_KERNEL);
> +	if (!transfer) {
> +		rc = FW_UPLOAD_ERR_RW_ERROR;
> +		goto out_unlock;
> +	}
> +
> +	transfer->offset = cpu_to_le32(offset / CXL_FW_TRANSFER_OFFSET_ALIGN);
> +	memcpy(transfer->data, data + offset, cur_size);
> +	if (cxlds->fw.oneshot) {
> +		transfer->action = CXL_FW_TRANSFER_ACTION_FULL;
> +		transfer->slot = cxlds->fw.next_slot;
> +	} else {
> +		if (offset == 0) {
> +			transfer->action = CXL_FW_TRANSFER_ACTION_START;
> +		} else if (remaining == 0) {
> +			transfer->action = CXL_FW_TRANSFER_ACTION_END;
> +			transfer->slot = cxlds->fw.next_slot;
> +		} else {
> +			transfer->action = CXL_FW_TRANSFER_ACTION_CONTINUE;
> +		}
> +	}
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_TRANSFER_FW,
> +		.size_in = size_in,
> +		.payload_in = transfer,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	if (rc < 0) {
> +		kfree(transfer);
> +		rc = FW_UPLOAD_ERR_RW_ERROR;
> +		goto out_unlock;
> +	}
> +
> +	*written = cur_size;
> +
> +	/* Activate FW if oneshot or if the last slice was written */
> +	if (cxlds->fw.oneshot || remaining == 0) {
> +		dev_dbg(&cxlmd->dev, "Activating firmware slot: %d\n",
> +			cxlds->fw.next_slot);
> +		rc = cxl_mem_activate_fw(cxlds, cxlds->fw.next_slot);
> +		if (rc < 0) {
> +			dev_err(&cxlmd->dev, "Error activating firmware: %d\n",
> +				rc);
> +			rc = FW_UPLOAD_ERR_HW_ERROR;
> +			goto out_unlock;
> +		}
> +	}
> +
> +	rc = FW_UPLOAD_ERR_NONE;
> +
> +out_unlock:
> +	mutex_unlock(&cxlds->fw.fw_mutex);
> +	return rc;
> +}
> +
> +static enum fw_upload_err cxl_fw_poll_complete(struct fw_upload *fwl)
> +{
> +	struct cxl_memdev *cxlmd = fwl->dd_handle;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	int rc;
> +
> +	/*
> +	 * cxl_internal_send_cmd() handles background operations synchronously.
> +	 * No need to wait for completions here - any errors would've been
> +	 * reported and handled during the ->write() call(s).
> +	 * Just check if a cancel request was received, and return success.
> +	 */
> +	mutex_lock(&cxlds->fw.fw_mutex);
> +	if (cxlds->fw.cancel) {
> +		rc = cxl_mem_abort_fw_xfer(cxlds);
> +		if (rc < 0)
> +			dev_err(&cxlmd->dev, "Error aborting FW transfer: %d\n",
> +				rc);
> +		cxl_fw_cleanup(fwl);
> +		rc = FW_UPLOAD_ERR_CANCELED;
> +		goto out_unlock;
> +	}
> +
> +	rc = FW_UPLOAD_ERR_NONE;
> +
> +out_unlock:
> +	mutex_unlock(&cxlds->fw.fw_mutex);
> +	return rc;
> +}
> +
> +static void cxl_fw_cancel(struct fw_upload *fwl)
> +{
> +	struct cxl_memdev *cxlmd = fwl->dd_handle;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	mutex_lock(&cxlds->fw.fw_mutex);
> +	cxlds->fw.cancel = true;
> +	mutex_unlock(&cxlds->fw.fw_mutex);
> +}
> +
> +static const struct fw_upload_ops cxl_memdev_fw_ops = {
> +        .prepare = cxl_fw_prepare,
> +        .write = cxl_fw_write,
> +        .poll_complete = cxl_fw_poll_complete,
> +        .cancel = cxl_fw_cancel,
> +        .cleanup = cxl_fw_cleanup,
> +};
> +
> +static int cxl_memdev_setup_fw_upload(struct cxl_memdev *cxlmd)
> +{
> +	const char *fw_name, *truncate;
> +	struct fw_upload *fwl;
> +	unsigned int len;

I would have expected this to skip registering a firmware loader
interface if the device does not support the firmware update commands.
See how the poison code gated setup based on command availability.

> +
> +	fw_name = dev_name(&cxlmd->dev);
> +	truncate = strstr(fw_name, ".auto");
> +	len = (truncate) ? truncate - fw_name : strlen(fw_name);

What is this doing? The device name of a cxl_memdev will never have the
string ".auto", looks like unnecessary copy/pasta.

> +	cxlmd->fw_name = kmemdup_nul(fw_name, len, GFP_KERNEL);

Not sure this is needed either. AFAICS just pass dev_name(&cxlmd->dev)
and skip a separate string.

> +
> +	fwl = firmware_upload_register(THIS_MODULE, &cxlmd->dev, cxlmd->fw_name,
> +				       &cxl_memdev_fw_ops, cxlmd);
> +	if (IS_ERR(fwl)) {
> +		dev_err(&cxlmd->dev, "Failed to register firmware loader\n");
> +		kfree(cxlmd->fw_name);
> +		return PTR_ERR(fwl);
> +	}
> +
> +	cxlmd->fwl = fwl;
> +	return 0;
> +}
> +
>  static const struct file_operations cxl_memdev_fops = {
>  	.owner = THIS_MODULE,
>  	.unlocked_ioctl = cxl_memdev_ioctl,
> @@ -352,11 +669,18 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  	if (rc)
>  		goto err;
>  
> +	rc = cxl_memdev_setup_fw_upload(cxlmd);
> +	if (rc)
> +		goto err_fw;
> +
>  	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
>  	if (rc)
>  		return ERR_PTR(rc);
>  	return cxlmd;
>  
> +err_fw:
> +	firmware_upload_unregister(cxlmd->fwl);
> +	kfree(cxlmd->fw_name);
>  err:
>  	/*
>  	 * The cdev was briefly live, shutdown any ioctl operations that
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 3acf2f17a73f..e94237f5568d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -58,6 +58,17 @@ Description:
>  		affinity for this device.
>  
>  
> +What:		/sys/bus/cxl/devices/memX/firmware/
> +Date:		April, 2023
> +KernelVersion:	v6.5
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RW) Firmware uploader mechanism. The different files under
> +		this directory can be used to upload and activate new
> +		firmware for CXL devices. The interfaces under this are
> +		documented in sysfs-class-firmware.
> +
> +
>  What:		/sys/bus/cxl/devices/*/devtype
>  Date:		June, 2021
>  KernelVersion:	v5.14
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index ff4e78117b31..80d8e35fa049 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -82,6 +82,7 @@ config CXL_PMEM
>  config CXL_MEM
>  	tristate "CXL: Memory Expansion"
>  	depends on CXL_PCI
> +	select FW_UPLOAD
>  	default CXL_BUS
>  	help
>  	  The CXL.mem protocol allows a device to act as a provider of "System
> 
> -- 
> 2.40.0
> 


