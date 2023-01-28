Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AAC67F2D0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 01:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjA1AMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 19:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA1AM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 19:12:27 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6BEE04F;
        Fri, 27 Jan 2023 16:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674864747; x=1706400747;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WNZhhLbjZzYUZottTU7gYrzhrP3W6rOfQ8u+3kC7JME=;
  b=l5BkslXI0n0R5SBzq7yCeD/zBkB1HDLvg8ArXeXoP3hPzkGcWTZnahMB
   1mJ24pPXEA8p3299YSk7/NtcOQWgLou14F3fkM7Cy7g4Ax7scxVvb9WtU
   a8lNzl5JVUBsQKGGW2DxdJx3ZDRIZBdljhOSqA2sbUz3SM5xBYYVh3azz
   vI0o5yzR0VYpel9SbH0wTwXoyuw/x4gYp9AAv3v2PjTiu0qg0WaCpLUn9
   l+eEd6zgNHrdCJhtIbkXNN960j1uAFXpEDXh2Msd2OpsmLJhiWGRm0ARS
   lm43GddfqPb8zEN07TMbfyKycMvvtaclS63dW2IyXTGWtuQT2WlKU1yj0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="329357542"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="329357542"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 16:12:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="693894341"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="693894341"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2023 16:12:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 16:12:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 16:12:26 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 16:12:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hD9/K8GK4aDxSAeXirP4S10bHrjxIIxdH47AGQni3W2yWlwtUiyoBOwLXgesLmGUCQQkq2MFcWlPX1rwlKRwut0rg9tkC6UcwOfvuUeOwFcYgffRmlEuBGbf5VXHDaaArwGE4uLYPgXcwzkfwtpAt1gKmyB14xwOGUraHsnzaAEO29SQs5CNQx4WyAGobjmJaZgYbedZREIA4Owu2Gyed0DjUHokkJsE1Hm/SbfvQ+wUAn48qhI+qJ81hrAGXfDz1GB69S9mAranFFipdKSg7/py+mCPcHnA7ufkRNLiDSu436Au4f13MDdtEHkE4b/Wa66rc2Zs0Jt7ZpoT0wXjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vj1k/lgYZtjAfWnMCFKEGG7504c1pxR8jWSp0wAIV7U=;
 b=m/lxGTJTxh+tQkFCGi+EYEbB79Fy8SaH72BMDbMyS+ENfKaQGZY/nqTr6buZJXlVuzaHl1QaAc4+JrdmjXCOMLyqISsMvOGY057pB7Nhg13Xd1Pms/AY3xBAfcEr2F4WGqWS4yxvpRetKNIujjCvGJ1yoFwhmEwf0U2RH06+QsmAOBHb+lFkiFfv2s5OnJ992Rod+qK97g+MnT44dAaHx5OBwPYhIKRdJFRFr6ALFJ+FAjjQxUXpLz8Wjd9t70GOsRGc8B/6YQrilhttiddF2tOeNKRlkTqVpbK2J1RReXIAvUy490u6oVDcZS5aHVmWszHwMLVpFUdmoE1CfEh/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB7859.namprd11.prod.outlook.com (2603:10b6:8:da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Sat, 28 Jan
 2023 00:12:23 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Sat, 28 Jan 2023
 00:12:23 +0000
Date:   Fri, 27 Jan 2023 16:12:19 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/mbox: Add debug messages for supported mailbox
 commands
Message-ID: <63d46863ad2db_80c3729457@iweiny-mobl.notmuch>
References: <20230119130450.107519-1-rrichter@amd.com>
 <Y84dleBbsQhE0Dic@aschofie-mobl2>
 <Y85+dwjO9JjtFtGa@rric.localdomain>
 <63d310851dc19_ea222294b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63d310851dc19_ea222294b@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BY3PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 68805124-442b-4a83-2197-08db00c453ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lm1xZEr/frq3NiMRM8Nsh47EtDk7Sj0AqfpjAKlos77cL19F3fRG7q2ERYo9HRGfz+czmrATlWG5FMXY5s/qU+FiSHlBryWaceetHLXwQTsVQFdbKLal3EZA3NrYkHwYwOe5YxrpdL2/LqxmY7Ddd8LrL0NtJsf4cRxPQRg6YdppaVAyn/z8bPCb5h1Kz/zNqPspvoyTMRi+rEMUDVYpowz+eBbLQW7+h+GKnK48ZybQsAiV1yjeQ06RjO8bwPxnfVFj1vX3/WhUXNcBEuhzUKOPIV8a8Wz59Ca4EgHY41KeA1DxVWpr1SIN6rjSxOFUwoVBAaoWotdYFLwclohmCcUWw87Nr1txAEBUVoEmalP8Z8Z9MS5tJEVbQCb5wNt38fiRIhSizKTDQ5aZi3sItyYI+LL4poOKGKIYmEBb5qO2tvYzbE0gaJf+9rxW+02BeN1Mg5CCTsHJtczk9jB4DHUEkBOIQ6ncG0k86/MhDpLVcP0YaC7EH+mDD4jc6nrPFSYrmj6EGBzZ0OGFqk6Ck0R+3jSh1eK4c3CkaQgM+SnrUOutJ0nVVuqYfnmlukrXD7phsn+EoIwTi688dCJLEgi+BjiFL7vlr5c8ffmGwEPpGBIt2w8HFE9wMrNL6tRpELmpbVrMmDBvJg93B79YAzae183ofJohUnIu45oY8oULR8vJSJbtYsnM9dZQkti4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199018)(41300700001)(5660300002)(8936002)(82960400001)(86362001)(83380400001)(6486002)(66556008)(8676002)(54906003)(110136005)(6636002)(38100700002)(66476007)(4326008)(316002)(66946007)(26005)(966005)(6512007)(9686003)(6666004)(6506007)(186003)(478600001)(44832011)(15650500001)(4744005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IDVjlIcdxNfG1TJMSlnMeBGJ5VGjDo63N2gDFVgVuRLeGtisKlP2XFZskb1u?=
 =?us-ascii?Q?qCU6yqFWeKI8veMy21cr4jlthf4xV7slYQUGddPCGxjPzj6PyRmQVU6Sluek?=
 =?us-ascii?Q?irEYWV4MRgCPA+tHjhzLd3yUATuuh/y3pcDgo083yeKRHSO4DU1JKr87iqCZ?=
 =?us-ascii?Q?/EqxMtV8To3llc2amA7KxGhH343pW8fpoXyuHnlbI1Wo7sVOierVqT5OC8Ss?=
 =?us-ascii?Q?3pQO6YyFHV/kLEfGyckgf8sKM25btnWFmUagycOYLydGA64VX98p6boudxiL?=
 =?us-ascii?Q?q3Ti2skNeL0OIs9FQWEZi1UO62XRDqO/XG9wV2X043POoH+jCNUihrQ0FSZJ?=
 =?us-ascii?Q?zv5dqKq1+7Il1WXMybFiVfetHASBB7YptDcf0nx97xH1//lLQEKGl1CFUags?=
 =?us-ascii?Q?NJ87sctYFK4eihcMpTL95lZEwQjFk1X+BIS1mDka0iQ9zOYO2EXZX7eXROuG?=
 =?us-ascii?Q?fOyBRys9urB2Q/8yzWN4OwAY51Y49SQ+NzSCy/pffefKA/JrPhvDNVms98qS?=
 =?us-ascii?Q?Qwsu9k6LzYc5t3eLWadDMx3jZvH0Qjrm9d7a8sK9zrm8RYZrCsAlbhkr1qJA?=
 =?us-ascii?Q?x571zRRhO0KoS9YfqGyi3orhd9c23HEFS0VqEwVvkutxY0mMt1OPQHK5KPp7?=
 =?us-ascii?Q?9Pfj9uAr4LmdNfoouECKC9lMpYnX2pdIrt3QSSg5imXrvSi/XhykzSIIuLr/?=
 =?us-ascii?Q?pXU2DOAyMb5iUHP7ggtOSfSji9e5v2YphEF3iNxVMFg1Vy0VsB/7NbH5rhM6?=
 =?us-ascii?Q?gQA+pTZxGyXCsTB4vBG7Aqchg4VgATDluDS9gP5L41gyi/xA/EE5YfZAs8mt?=
 =?us-ascii?Q?tPkkKzl2hHSOwJ63DkTOfDo+ShsK9xDGCG/LWTVKPGxJXdr/tLT7Alf4cLMn?=
 =?us-ascii?Q?+scen3+7WqubWvMl4D1aqvuRt/X5lf5AWMzaiG7wuZ/ZAyY79dn2Z/T+wFbK?=
 =?us-ascii?Q?Ar74gwtjXsfTOKDRTHI4TLMhoNBYH9XHuF6jm7a1RsTtlNQ0iefTp2+caHvE?=
 =?us-ascii?Q?bA8fbj1qHE940hYj7wXjYhePqu/DMSfvHJz3aI24X1enCXMtDFVYW9H22M+7?=
 =?us-ascii?Q?hXINLy8f9Syp01tRZVJQkmsniP+gY9w0BqFdaOwRc65roy/WLk0qOIISU9HJ?=
 =?us-ascii?Q?EIINHYwDPYHff8IrZ6/DfLy4nYqObiqbVz6E4t6expxvfDr+XutQzG7q9+yc?=
 =?us-ascii?Q?nPONdh3+JIgV7hquov6gBaDg5mQo8C7SRZfXbGrfUodMilbHjaqWq9Jnf0al?=
 =?us-ascii?Q?ezJ2CpXlDJn3/heYEAcHcHFFtXFUjioaSX21EgcdgGfUFdEWLhDuo5clNfWO?=
 =?us-ascii?Q?kJyhuOvt0v/Zq+5fjLB+TiQup2fFRHH8rs1Ucj0mBQ7GyYAzAzYXBW8poftt?=
 =?us-ascii?Q?B4gdKtkoLB9WhvxC/fcU+QpHPrr5ZgbH/8dMyLsTHfiKyXMGkvUcZeTTfo1v?=
 =?us-ascii?Q?2o50dwSsV/ZYe/dNNkqpooeqhnn2IYBmGcJ0PePikiNBTbsvo0R/6zrrKJHR?=
 =?us-ascii?Q?gktC/LgkaMT8MxIAot/0Xgdd22eD0LXtw55f3gSr7zUWsI8Op9itTi3dSK42?=
 =?us-ascii?Q?YOWjBA9vjLV1rv6dsN79Y/WSfS98WT6MKprg/vnk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68805124-442b-4a83-2197-08db00c453ce
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 00:12:22.5320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RrLGzl48B3unGMnS66dkJtOnlxQT7vqy58q7uEfzcI9N9LJBufYj0w5nELMU7uGeCks+/fJN/XK8lQtxaYd+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7859
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> Robert Richter wrote:

[snip]

> 
> The debug message looks ok to me, I will just note that there has been
> consideration for exporting the enabled commands list via
> CXL_MEM_QUERY_COMMANDS [1]. I wouldn't be opposed to someone enabling that
> as well, just need to be clear with userspace that not all kernels will
> populate that status.
> 
> [1]: http://lore.kernel.org/r/63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch


Sent as a v2 of 'CXL Misc fixes'

Ira
