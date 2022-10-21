Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C3606C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 02:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJUAFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 20:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJUAE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 20:04:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DE54D171;
        Thu, 20 Oct 2022 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666310696; x=1697846696;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HuEo9QQqlsSLWtKyYt7+4ISnWEPT+5UeQQ49QwbNOm8=;
  b=L8I5X4d342jxeZmHrS7DM6dgKAgDZGob8HzQubgatLOgUFXk4HWhvfqM
   /x/uwSoUnBOfpFgWIMiyh9ASigZ1v0Es54WsDN3OmsTyIcUZgppbLmgB6
   aejduNyfMELG1NIAxGrZFecgwhaKdAaQJ0InLwDcyfjbZK1iuGr7yFkLU
   BIJRs/dAlvxr/imeK4yi244D83vLbIau5ZPIki+WFdSs0qngcq6ulKGTM
   Ygkauxn/RMKgwLWwwMsIn4elRIANBbFarVQeR+qXuqi6AcJmAkV9MtslT
   wAJfnDRcUZ4n5WKV/ph7t2lCwqM2zk+hUE7x+2DY98enQQ9LtJna7ILlb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="287270843"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="287270843"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 17:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="693335160"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="693335160"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 20 Oct 2022 17:02:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 17:02:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 17:02:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 17:02:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l57k70ehFLjvCB+RLbMCJfadH1bsXEH1H1fwaucfYDDKV6EPlb95NNp3HAs2qZqBeUSrbugKCiK0gGRUPWIl7UKX+x4bEj06iBx+dgZgQuVlZ5mFcUEaCrTMj040idR6M65DOW+/URHC+10HY4ue3pNkYD+MSS/lssugbFkXKC+GkqmyfdE8eIyE3PZH32Dtmfx/rvPH07gqxbFSSML7n4QxQQgePZSZ1o9qYqrfFGFpxuwf2JCTjsaeiDaJaW5Ag/PMm024kzf+gPZT141FIUO0aK5eYwji9NHjr1FhvovZhELme2Oj+hKYaY7U5GQhcL2wLJrfnPHaCW+TKxZsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79u23wLL+qTG+YTDK8SX3VEhuEi89JF6HcjFJQb9bSI=;
 b=nWTfEHbVUi1OCrH5YMBJz0RoU+CBl6Vlb1iMEOVVqogdiKLRny0c+Kze1QBTJZFl8rK2gGfH0wo4/e0NddqtEI/q94ouESNkvhZTK0NFGOpT/r6G/60tlPJeZSQnyVoYq3a+6fSJdQU5/kk467efuLMeAPfUxBym/13Ev8Gzij6Clsnsdv4lIpU0BIWSunCzhqWFWCPvIe6QpEcshU2zxz0EtEyl9+F8XFE3rzzrdslXFntr9MMVyGIFZm06ro8GrlTkfBMbpZHo87vRZanYZoAOeHSTHn17iVa0gCQBPiwhKSX+PMggp16OAZLp7Ux4xSbVmM+1C1qbCmQLR+Xpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB6601.namprd11.prod.outlook.com
 (2603:10b6:806:273::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Fri, 21 Oct
 2022 00:02:00 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.034; Fri, 21 Oct
 2022 00:02:00 +0000
Date:   Thu, 20 Oct 2022 17:01:57 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH v2 02/12] cxl/core: Check physical address before mapping
 it in devm_cxl_iomap_block()
Message-ID: <6351e175b24e9_4da32946e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-3-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018132341.76259-3-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::31) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: f3953655-bf2e-40a0-6acd-08dab2f77a5e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lijtQ8NsuOnV9Sk2CfgH9E3vKHk49iwwdy1bm+k66qnU5SCRvkCPTCV6JuB8+IiaxCTRW/YBLHGsfJv1fY0RBvGI83hZY78Plw+Ov2h+RXRroPdeQV9WK1QLlQC37xV74F0wtnAF5QwVc6Jbk/x9JQiVi3FdpCsFSF258se/pYpZA4XIB/SMmASR9y8bA9/s12hP/I2hfkyKGjfNZBzdHJAkzH2CRxXab3NMv8ixQqObTxqrXtKq1C+5z36hjtR9yJEP430dkLjcLNziw6Qz9rEXTgODu54PiRC89hisFsGCJJ8CeS+zic1+adWChvJLtVcbl8w1KnLFmf/O5nZBKhUylHNJYZpz+TpCkVsBnyCHQvl1393pc4XkA3z5qno1smtnXy+BiNrjLd89zMyR8RnEvTMst26AjEhJe5rZvXJ3NgQsLL3Qxfm0CLWGSe+tuj3pHGDMkOGlKKtXmqV6mtgprXvx05q7CoVLHXet+HWNEdld9oVjRyL2n7sj4atK2rjFreRjagZO7x7H/1R/cC/Q5IzkbPCw5hKXuy9ye278bRrikzm4u4IZ73L+RzZmGIG1AHrmXaICgOa9wChot04dHLtcMegGJK2urDrqrNDXKUbuZbhrQRYfAlGndIyBs+IC2WqkpUC5O7b40tAL3eamXu7SY2A6bzcNSPumkxabDItt/3bhVhI9rsNOJ8m4wgrblITSkiWhAD2BByzFWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199015)(41300700001)(8936002)(5660300002)(4744005)(66476007)(2906002)(66556008)(110136005)(8676002)(4326008)(6486002)(54906003)(86362001)(6512007)(26005)(478600001)(9686003)(6666004)(6506007)(82960400001)(316002)(66946007)(186003)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?upmZAZA8rr82PPWbfLw2myz9JdcMd3OHTuogiggmL3z6jGypE0goCmfd7DMX?=
 =?us-ascii?Q?FlWhQra5CL7NvKHLajQjGBEm6HrLYRlpIBk45DNwd4qlD1C//oX3jj0Hwdmv?=
 =?us-ascii?Q?IBB0bvyTxaY5BiJqr3TwZ2ZeWd9pnkxxjw3RVF8YIofDVQjcRDtsAHxXXfHQ?=
 =?us-ascii?Q?9tB3rwUvEtM/z5GhyWIjL6od+aE7KnmSbYuWZUSRtWSMw6qBrc9UB3dOmV2u?=
 =?us-ascii?Q?6kthCJXeD/o1I/kcoLsmsnxkTajV+shRJxkr8kqDTiuP83TBzLb4U4ibgnPd?=
 =?us-ascii?Q?QGdTQ6n3wVe0XA61l+ab+ATRndAMztwI8kQdE2BLETTZfPZXIp3e8IMgF+yB?=
 =?us-ascii?Q?/JbS4KwdOLB5/UkueCLyXwh+SeTPMbwXWhMxf2iYwwWt54ImJL0xQZEyA/tf?=
 =?us-ascii?Q?4n6IeFmqr/Hz9ZrUVF74N4NaV6z0okjyBrnK43JensyAVkAGxScah5sYMC5O?=
 =?us-ascii?Q?sVxV3AmAVnCcZJq/QscNmLRVZuNMPt8wtdz9SYYXHOiFyqZ8+UOsCJu6jTuX?=
 =?us-ascii?Q?AwuPG+wseegDPXQKfRU0CsVQZ2AKopcNO8G/9Jzj/n5WyCC/AKoTaNCA4Mt4?=
 =?us-ascii?Q?RsQwYU/95kLMsYENldniSitA+E/CY03ItPREr5UPBi6G5ij5dEIrvFsHYskL?=
 =?us-ascii?Q?CWXVStZfdmZyl0ZLVWgX4gHIhItDRNBIwcVTocU4OeDxYPgJ0z64QJ1ECbCB?=
 =?us-ascii?Q?GknqjorythObLrovmkbloifqJum7HofdEnVwjdeRv0FWUzO0vxIQTe6TkjLj?=
 =?us-ascii?Q?qitHJoFA8U3ZKR5zhA2bDe5FzVTgNnxQYtNe2vSeapZy2vQxBW7pdtipo3v+?=
 =?us-ascii?Q?TuxpbU9KGY07HiH6WztCNQCAhaemJJzrXy2QxxOv/XEsjigTBzqbAnJGYs3V?=
 =?us-ascii?Q?cV6znK2AOC2nVR42cCvdL7ZQBZOsQIi8ein9IF/WcxfVa6Kckbd10LCD5Sd7?=
 =?us-ascii?Q?aFqCtJfmNk8d2cr8AhZmWcYl8zwllUOox1NCw63jYgZ4dUCn/qoCjZvKFbdr?=
 =?us-ascii?Q?4JaBnIxqIMSMn1z6qmdh/voALFa4lfrFByCU+HCZA+W37TGmgQ3M9dx8JAy7?=
 =?us-ascii?Q?8k3K2WBNCHGGgxgbQkMOJU8Yjfh0e9fhGLjk+a7/VscfO/F9HlqdhNKjshNN?=
 =?us-ascii?Q?9zTtjIZ3C5m0Qhm+FadWhPuBaqbmZ8R26XTJnoxOL700se0IrmZDHmvmdCEs?=
 =?us-ascii?Q?XEzJWvEQXdqDOj29Qp+64/31NgI9kfiRiOgWsYKnsH5czj6IiPcpz32PvNZt?=
 =?us-ascii?Q?JyP4uKr8sjb5tbmB9KNNHP6TTwO1+oD1bdVHECXtA7XIjgSDbUpxkQKtNKEz?=
 =?us-ascii?Q?5LmlDK1u4ZkdtX67Un33VgmNd1T8kmIoaiYUu5ZWjXyXn/wssq+SFRp56NeJ?=
 =?us-ascii?Q?eBh12v1xGMImyijqWoanjXZp5C4PovPwcmO51KuxMc/VFggpgQL9yYxxTwxi?=
 =?us-ascii?Q?BiXVAJfbaN8LDaweOEVdhr25ZLzFBsYN5wyf4ypXaT0D7hhYkE83ZvUumW4t?=
 =?us-ascii?Q?C039azhgOVYhBWYzOQG7lgqr8Zc7NNy2r2gCuFKX3pyGNO//D122YiAwqjsq?=
 =?us-ascii?Q?zRiJUcGYNakArsjLDgMfMpyRjwv73r8yMfi2gC6Z6+B/XKSkjExS191FiZ2L?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3953655-bf2e-40a0-6acd-08dab2f77a5e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 00:02:00.7895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrXVp16bYg1nK00mcRWyeOrR4o2lnabauqmPbRLBsF3JT8reljOWBNlOj23UVouurMVbPDHvMmtyMDtWRNbupQjqY9HJhrUx46y9UYYk5ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6601
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> The physical base address of a CXL range can be invalid and is then
> set to CXL_RESOURCE_NONE. In general software shall prevent such
> situations, but it is hard to proof this may never happen. E.g. in
> add_port_attach_ep() there this the following:
> 
>       component_reg_phys = find_component_registers(uport_dev);
>       port = devm_cxl_add_port(&parent_port->dev, uport_dev,
>               component_reg_phys, parent_dport);
> 
> find_component_registers() and subsequent functions (e.g.
> cxl_regmap_to_base()) may return CXL_RESOURCE_NONE. But it is written
> to port without any further check in cxl_port_alloc():
> 
>       port->component_reg_phys = component_reg_phys;
> 
> It is then later directly used in devm_cxl_setup_hdm() to map io
> ranges with devm_cxl_iomap_block(). Just an example...
> 
> Check this condition. Also do not fail silently like an ioremap()
> failure, use a WARN_ON_ONCE() for it.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Looks good to me, applied for v6.2
