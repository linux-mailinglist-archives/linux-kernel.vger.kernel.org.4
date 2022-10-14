Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227C75FF2B3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJNRBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJNRB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:01:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6E419E037;
        Fri, 14 Oct 2022 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665766886; x=1697302886;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iLM0nOrdGUnTF0TFWkQPfz8gTVo5ovkV5QrovMyWDlo=;
  b=NgldLzoiKKHu/hHMKnVjLaN6FVxRAuJT+ueAwk2MOSBL+ls6XxxyvNrE
   fre3orNNyh1fS+VwDXKuTvUwR8yOA6hcwe//KdWFC58ZK4UkNASsiRC6F
   YSdwdTwDfO6TGVHuejVvGwyezAA4y9hg5h7kUCWfkbO8Sxk4UDsIYKk6W
   veZMaF/MvEDdehhmo0uQIMwFQGFOpgk10oUpIVfHqO4H0AIshjoplHM9Y
   xhfr/CSlOAiYx1o4jGql2wPWks8Xg204th2ogK/AC5xqkMlDzmSYaY/us
   0ysis3/yrryv7bcM5F+XG+9aDASZAnC1Nm3pf/3bV6tgPJMtZuUjZL4t7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="305411011"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="305411011"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:01:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="605434187"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="605434187"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 14 Oct 2022 10:01:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 10:01:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 10:01:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 10:01:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jq5JhLWw1FeX+/jYZpXFeF3m3Ym1rnOmQtQJaI5dhX/W3NqxtNZcDDkXif7o8lPgy0c72eIfgqOJxfpLQ9n3vvpDXl8T5Y9pDjl9pJSaLK91NsjWHW0rk969l2GZyqM6zKql4jo3S0zotnfZSpURnji04bIg7S8MbJfFFijTKW6Gj/F7+DwhMQmVKwaQqnvVrZWKNa6iaoLstfl9PzpSahsEJgtVGj9xJ3c1tYC8OJqMBgDdjlsXg7/9hoQtoQ2brosLZXczdt3Aqmv8RW+xkVTAjs2JHaBKQhv/W6V/4z3yixdlHETAtW1+YhSkovAEE4aYdDVbcZu7nwTFeuB4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYn2JOQzWbCUt8LiQpdZQ0SefdH3tk19CSUVxQqMy1U=;
 b=R67DOebXLmb2r57VOfPOKLWWXw4KAlQrWyrYXJ3+dJMA31h4HVH+5gozTet/aVmXjQ60bX4M0aHf6cE1Y2D/13f7Y73nczLuqnNXc6nNDkDaFPUWPMGnwUEg9wKav8xt/56gKokLohr0QLpDxJTcgDtAlY8CgGV4fVc3IjPazr+vAeZUKb7Q6ShWHvkBxV4ZeX1+SD4EnPovQRJXbVIN9r3Su3sffRodln4OAI1jWbK090Ca/e4evCXQjOj5H8qILrodmkXGfuvSV+ur7WWFS4I1FNiohJVO6mtemlZ3S6/yIHyUB20szL81oU5myEeWuXV1HF0efDd+UiUaIvVuGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6606.namprd11.prod.outlook.com (2603:10b6:510:1b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 17:01:01 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 17:01:01 +0000
Date:   Fri, 14 Oct 2022 10:00:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC V2 PATCH 01/11] cxl/mbox: Add debug of hardware error code
Message-ID: <Y0mVyQVx5t08IPaX@iweiny-mobl>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
 <20221010224131.1866246-2-ira.weiny@intel.com>
 <20221014162921.oth2ing7gv3ofuha@offworld>
 <20221014163149.6zwx6nrbzfbc5pps@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221014163149.6zwx6nrbzfbc5pps@offworld>
X-ClientProxiedBy: BY3PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:a03:255::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 1334bfc5-8482-4c33-6e5d-08daae05abdc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xlVeNXSAsdqFA1oEJPD/y1PLx6RnFso6ynwcaGz6OQsdtFW25no8A+KpavrpgRlhc4wZtskCZJ3vABL6hCiLYycFFYDLwWWqZogQgWofew0Hg4eUsCfBTewYsZXSE+cImQwPWbgY5FPXY3o9alEEePwURIYO81ca74QQ/zTxTHC1KE/UAVAB3UWFG+wo6jrNuYFWxJH6iQg7I+lPV6VbGcaeiPQ1J+OstxQn5zFqFkeVthTKueNjbyl7pB73Hrmap1I9ouylkoWsoP7xmXQslukawg1kG1mXvPxwrEK7yctnh1cOLxnMzOHISyUYR/2gOE03FSw7y7i9m6UBCkpbumJ8DqFW7XswcBwo89vs8wiG3CxJnqmz5VUN6iEZ4rINWEQ+5ra1yhwvzR51Dr/NIYsyxR/pntmL7ZUZI9OrzXYc75uG4RZe5TQ0j/943IYNrTuDe5fKvzDMWXoev3jYuC6MDsHarRUylNdAGxG4KobbONS2unQeGFi8QTOocJNmuCfD3f/uxYXareYZXB6jObP4Vt3QnW0VD/uPW/R1vgQeL8xww25XbSqY5dybJE+WcbED3zNPHkMjddLKWXAhHqTOrXqKvVyvt2y5dbuI6J64KwvRXbqle7YuIPENkr2vcRi8FGrr67T8KMml8TvdEYn7KSqoXrhVP9Aaq2Rz3VMzvt6e8/nt77DFvyjDM3DLed0LC36YEk5Ah19eg1CkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(366004)(396003)(376002)(39850400004)(451199015)(83380400001)(6916009)(54906003)(44832011)(4326008)(86362001)(6512007)(9686003)(26005)(4744005)(5660300002)(8676002)(66476007)(66946007)(6506007)(2906002)(66556008)(316002)(8936002)(6666004)(186003)(41300700001)(478600001)(82960400001)(33716001)(38100700002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HseGH4Tc41rn+694noL3V683GTr/1hlTllrXPHLctlsOqToZr9I0Dw56kxf8?=
 =?us-ascii?Q?vDGTaOcIMPwUb1wZAg8oQN3RZiFA5sejklU/iU/kGNYEHwe0ghZltapr4VGM?=
 =?us-ascii?Q?3lKT2L+q8cKMLQn5VROcJPsNn3AZx4Qyrxg5CS+rQvT4U64Ls18Kg+WziJc7?=
 =?us-ascii?Q?B/Bhj+Ih3kt78IHpUJ6Gd39zZ/imnwxusAzeSIL+cHMxu8wd7CmCo5067sdi?=
 =?us-ascii?Q?1z02NeldHO+Rm1z104+OCErt3G50f4aNxQnqP2B5VZps2vKp0Kc9jd7Qamw7?=
 =?us-ascii?Q?18S93k6Lupd7KQd5heo2Q0d/aibBv8qnBzyM5Re7Sx1iM/i07NNsbcXMO8yh?=
 =?us-ascii?Q?XHuWwx7LmtVgr83QOmu/SNfu0h0I5DNinImQ7xzqkRO6CYk1b2Ov+z7hmU4J?=
 =?us-ascii?Q?61D8FDul75dpUNXypBXQIXT8bvAP+2ICyMRiLTh/IT1dI0Z1Ax+8LhdWDVtP?=
 =?us-ascii?Q?djtKjOzBUtVRILz5zSPVCW5Bl/k7T44c0RX6wRvMfa0P5DtOnER/3Aph347k?=
 =?us-ascii?Q?wTnlA3DeuBRPYwZHSvMgSywUOrgnOoAzN+0WclFbMJqKdZta1AJOcmVr1BVF?=
 =?us-ascii?Q?coc0jZ1a1Lb8l8QUjjLgK1SxfBa2/Tw0mufGy/3S0Vp8EY9VfjCI9QIsUp5t?=
 =?us-ascii?Q?k58q1K1KBH63BcbS0ahaQuVruH479j0n7SKg3237wLMsIinBxCAwhLfYaJYM?=
 =?us-ascii?Q?FUeM1DF5zcKJm9hSk0/UvC+Vmq+b8CGXs9EyQOWQwrH/Jo8/q5nIkDYXGtsz?=
 =?us-ascii?Q?mGxFkvyk1l7/uF29MW1BOln2TUYAbts8l46JYFbDfB2umtUvxXuVlRFYcuHQ?=
 =?us-ascii?Q?Ceq42/jT2qOEpabxw0LTVoc/RR8mNBwXJwvZOyef4P2viN/HfVaYyOsJJDMv?=
 =?us-ascii?Q?bQXUWn+xZh/FXMv4EcSHQVgNOtJB2ZSffZvSHOQX5s5fbrkJFeBjcucT7/OO?=
 =?us-ascii?Q?fK3bM8Xy+nBSpgXphrkqxEHCaeHx5TvNO2/ELhniWxX1zlc6hoGuCAhsAkUj?=
 =?us-ascii?Q?U99miwXrlgJBrnJyOMi2sWr2KiJjg2bPxcih2KjngmZQKdH2ON9Sb2KxqcAk?=
 =?us-ascii?Q?MQGxkiPOdcSydnF78/uRsRsbWRXl1aLyT5LGgRT+dRWut28ByITbS6rl1CHC?=
 =?us-ascii?Q?sgssVgIbgsf8jrnSCuWuYn5tyirMO4QW82K7W/+G6QBt7M8FNT4JqjHTiGJ1?=
 =?us-ascii?Q?SmVLDujJwD3owpaye0lEvySGVwhJ6h3aMVrc7rI046kwI2pqBSIERjHND3bl?=
 =?us-ascii?Q?SGF59zISCU1a48NuejOi54IidIqub1vLytA9/bshcNsQsxNGTMePRX/GAbJN?=
 =?us-ascii?Q?tuuffqJ37ClREqaHfNJN6U6fV5VbxDUkfg2taXgM7PgaXPwUxXhX4sLuCn5F?=
 =?us-ascii?Q?buE4KCFopoJ3Q6Ss7eaIdtk1724RVaTUVHlrEjfkD416SDEtCI3OxYN1GIVx?=
 =?us-ascii?Q?YR1cqH35Y1srcTABzMEc6YBxYc5/gpEHTKcPCQKbR6oqp5l56XzJPerWGsnv?=
 =?us-ascii?Q?+I/nQ7ZHEmYKFvQL8j7W4MhfGMSavzYrk7RmUpW/J6BJ1XHGlt8ZhFC5iIuh?=
 =?us-ascii?Q?S7LcONhhExnBCQkUSWQrZEFkZUsWrZLhtPorJf25?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1334bfc5-8482-4c33-6e5d-08daae05abdc
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 17:01:00.9797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8AxdqdqXHWEFXxHRz4j15PlQscYbN1flPFFqLMCqYffQKfPAFxDjfiToVPYjARzskM3/DVgr8K3kX/XGxyoZJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6606
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 09:31:49AM -0700, Davidlohr Bueso wrote:
> On Fri, 14 Oct 2022, Davidlohr Bueso wrote:
> > > -	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
> > > +	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS) {
> > > +		dev_dbg(cxlds->dev, "MB error : %s\n",
> > 
> > Maybe s/MB/mbox?
> 
> Actually 'Mailbox' seems to be the standard:

Good point!  Changed.

Thanks!
Ira

> 
> core/regs.c:			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
> core/regs.c:			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
> pci.c:		dev_dbg(dev, "Mailbox operation had an error\n");
> pci.c:		dev_err(cxlds->dev, "Mailbox is too small (%zub)",
> pci.c:	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
