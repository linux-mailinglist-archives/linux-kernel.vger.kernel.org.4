Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACC8609043
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 00:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJVWRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 18:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJVWRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 18:17:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C8971984;
        Sat, 22 Oct 2022 15:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666477052; x=1698013052;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ITQuv+pcKbVUHKytts5Jjt8U5QZ9xAtZNV+D3aETB9Y=;
  b=eW3Gk7eZtyAFEugeq6itRVV10g5hiH0t1p5U+MGyYeL2JckrmQUA2ji4
   +W+oAGBDubhG9D+Hy2mnRpJeqXL2b4y4ZALk2v5W4ltwFaeq9su3jSOKo
   8Yx+sBoH4AJLyECKSdGKvrcVzt7+bYkyMNtD58645Y3abbLNvfoWf/1QL
   g4k/TUZjba1QRrTPisuB+FStOwWMCfHVQzvew1VxtwuihTa/HGACx2GE2
   r/q9N2Xmuz0dZV8cxGAQramz4Iey0DuWicbJXMyhMS6Rr2JWA1NOoM/BV
   u8BIBBIinR6QYYVIZ2H8hbGgAdt4DWNHbE56pNVQZoKj6ab5vEYk/aQbv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="287614615"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="287614615"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 15:17:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="699736673"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="699736673"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 22 Oct 2022 15:17:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 15:17:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 22 Oct 2022 15:17:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 22 Oct 2022 15:17:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GU7RvpnqdBDFtPf3CMWcvNHtvEW+CUkXbkHzOtv2EWWXH02iD2xWY3bhmmFx98yig/n3LISyyy7NOBNGtM+/TRXexIXpGT/1IBz7mlpcvSkeoeQcwmgDvoxtJr8wiRzr+N/BWxXWj6dk/IB9/zsidJKvJcy2c862jwZiTJy4uZ9LkD50jXmL/8preVcnVRD5nnbbgmFC9dIorT6R3113ix/vG1p11yMUeYrZcb2Bs0l0B0SkZCf/ocBEOwC31AjpoZVBZY2uyfQSN9s6Of39JNs5y80asDagvVMg3kKT7/78CyYzHiMJlEsEub51b89vLPzoiJqnOz+PJd2mge0OUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGtW2xDHbxeMH+fy4DazBf3wKwGok/Nl7eVnRgi/ojA=;
 b=FXnp1jyhuvO/EzlzgAHPXS/bYfswevazvhejq+PmVwIzNHDieia1D6/TrL/l17gTsOcKPIzm5WUqNqXuZEY2bqaIEPDRuMaqPo7u/S5J/V5WOputUvNr7F7T8F+zHNiRfEMNLHpU9QTrQJBDAqN1aIi6IAWw0cVACoTUAHawYwuMJC/uwfGGBheVYgS54UR7S1rxzkNdPj2vJkV6Kxv/cuefBQ3gF9t6A6xIYIsXv59syXgYmL5Q45mJ8Mjbf4cLmGTTFUyzaF6VDir1DKv427le4uq0iNq4tpzhoe/cYXeAOa2keZp3AIDwKhj5vrPjRol9PwC2A5Q1AE2RgJRnJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB7017.namprd11.prod.outlook.com
 (2603:10b6:806:2ac::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Sat, 22 Oct
 2022 22:17:29 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Sat, 22 Oct
 2022 22:17:29 +0000
Date:   Sat, 22 Oct 2022 15:17:26 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <bwidawsk@kernel.org>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <63546bf682ccf_14192944f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221018030010.20913-1-dave@stgolabs.net>
 <20221018030010.20913-2-dave@stgolabs.net>
 <20221018103619.00004c39@huawei.com>
 <20221018115227.00002a4c@huawei.com>
 <Y1IcpaodrrVrkEcL@iweiny-desk3>
 <20221021095818.00006ed1@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221021095818.00006ed1@huawei.com>
X-ClientProxiedBy: BY5PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:180::49) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: de2dc878-f8e0-4417-8bff-08dab47b350e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jl+ENeNjVv4CZiBeW0KWozw4RBe2JTvjm7uUQcBtPAdMDRI4qbQ4iffMGM9iu0HWOKN6M9qIXe696ErWTQXTJun9h6Qb2afI/Irih9lLPdyWQXMbZy0HJ+3IVf/AaY8odwv+tdSkHuV45e5ySLaELuUXMATnybJTU0wvNYvSBC+duE2LttyG2xNdAmx00qulRDEQnNDjafb2Dm3023fJP+6SQzgMQIWx3THZK3vmoM8SPBgoszxGGVXbz+0kZpM2412Bb6oOwRo5xdKJPbwuEW5vEIA1FEB+BDbLKoED0ssbHXsSJo43Zro7YqaapVtfEwB9xk2mPGat7N0INvH34HAlFuu32bguHWkoG0nlZWIbRWc56GA+T062OwQaXPn0krcze2AMnH51INJmRVkwosJKyKqSe7QqqYjt+hnk06MrgHC8csdYw6E2JtNK+EjHcJPHPsjxUNu+X7HerFuAvqiJvYBH5QzSy9U8lAmN835hMeY6NT55xOb5ne4Y0u4SgFKiairt1gUXkX1pNzjCflne8tnjETonqYOY95DS5K/LrnvSH+NPVV21tc28h/mx2SYgG7QemMy7bOlA7fbAlhp4YUqwI0WPL7G541RN7Eg4u4Hxb4BBNpQHUWcHRPgmA3I/szChzUASwbV6l2YboSBdm+mRiP+R+l3BqSvECGvULy8h+4DPwIc5FJBm4g8g3SN/9HadE4pcae02Dg+qlnZv66z6O4j4/E+3qBssyKkar4hAG7cTl380/eMw7Lzr9xPRnF3GyKjS7pgJcEaYVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199015)(478600001)(26005)(9686003)(8936002)(5660300002)(316002)(6512007)(6486002)(66946007)(66556008)(66476007)(2906002)(4326008)(6636002)(41300700001)(186003)(6666004)(110136005)(6506007)(86362001)(8676002)(82960400001)(38100700002)(83380400001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/WMETUtFw3Tpf08V/F176T5yvh0l8UfKRs3tlKSteUZdTfqTlzbhVyoEjq6v?=
 =?us-ascii?Q?Kv0XGGxGBuWV+s7mV5qHNMD2In+h5YKkDl3lbJqfM2SoIhdnG4oY3n26lc6G?=
 =?us-ascii?Q?FdNh0JMWxg03+mzLbOCWV5vU25c+DYjnERj0IzcknsKZMga/cXnIqXA7KJhM?=
 =?us-ascii?Q?+mygTp9oNie87uCq2TR4Xtf0gyLXryAA8S0WSI5R+wZimVxBFm8oeCa+/JsZ?=
 =?us-ascii?Q?aWfZ1eDRginovBFTj0oezxi4yhTu52ZkMS+YGSPCAbBmvN0YPfsRUh0ye0bu?=
 =?us-ascii?Q?JuzJMGzVrWYkU/VCxugcSwjeO/0OF26TACC8qybv3i4beGJQGMM/1VtWSmPm?=
 =?us-ascii?Q?CdcUDU9bmgGPX6MmPS1YAP4nwSQ6oLYxuVZnKN1u/tRN1FWPk3rA/sHyaxsU?=
 =?us-ascii?Q?GRPFPEHc1z16r3+mJ27KaDakKvowPxsSSf3jBmwreoivUxB2Fe8reCYWO1RY?=
 =?us-ascii?Q?BBxmqjsCZjEwZGwUtpT6cpfHE2h0GO0O6yoJYyGbP00//pA44MVfrqZwJbj8?=
 =?us-ascii?Q?SvIwfwgjvMlmlpLIvF6mbimXYvfiRLdKlxat5Muyzlt9YlF8FFT+0rtUzf/V?=
 =?us-ascii?Q?JfV3B2yjIpp/++qaxRfzsPZnz45P7+YZuBaECaYJilGI0uwB3ya9zTI1GYuI?=
 =?us-ascii?Q?4v0+S1lJL2g4HLRCRuULCFDPtthT8b5OfCvm3Yh48D/Cqyktw/e3HA4ehvDL?=
 =?us-ascii?Q?OUXTB/WHo/ufnYam8rEXgUZdyPkdDHJQ+6EYSIyd8GwTEJFqL6qPs4L/Xxgq?=
 =?us-ascii?Q?eTECmkod/7Ho/w8EoUE+j00pa7SziXq/0/U0h+E5zNAp5mydcAz4TezMv5ZZ?=
 =?us-ascii?Q?ky/a+mVuVM0o7vNJ7YO0Mmq+eSzTmz+0NZHZW/HSRyfib8sWqWj4ycKRY/Qz?=
 =?us-ascii?Q?LxWN+3bQhVDY1QeCwbzTRKrl8WKuc0sTvOb8uW97ptUVHeFA8u6HNGqjaxk7?=
 =?us-ascii?Q?gIpZVEgbXmz03FvlHmc1AHsBEx8AKnNdYWkEaedmFffZsJLkFpC7JYeDywr9?=
 =?us-ascii?Q?7Cu+FEe9P6Yyhx9HpNWHX+81qMu3KgeZWf7C57keefco0eqmKzikHrCWxtqX?=
 =?us-ascii?Q?59wbUwCni12T20MAFK8n6GROecPsd4tVHQbz1vZLzj7Clbo8SjrEMKK2UeqR?=
 =?us-ascii?Q?zx0fJTFB0kUSBWv58jr/jhRTbsezkU7SbDH9gCAkkmM4NhW3TJ308Tm5/p1c?=
 =?us-ascii?Q?K3RME+4YTJZCU/5ygbe0bqI7a2aYE+iJnonNMfnAJrwa632nbFp5jym3pKaW?=
 =?us-ascii?Q?/5AQqX8dmtqr2ZQmer781odhHNMO5ZTsdskyYu1CuJrHNrorFs0rW1dZEuG0?=
 =?us-ascii?Q?JQlEeE20fyL/htgPIK28pNpYSxPP1DUe3cfQZ84DW2WW5AMtO/FQg9oPVBKn?=
 =?us-ascii?Q?62KxDSA+CRkqrTFWEDD2NzxmsupKKRJTQDQh9tGiBiKTqyRoEmYCUygrG24X?=
 =?us-ascii?Q?px2zBR3Fkvq0oUNyc2PWoh1PiZmhD/oAXVb13IZQxbaRJXBbRlNMSzvt6chA?=
 =?us-ascii?Q?GEdCj4PqO57E4IgN1XwZa01O1XQTTMWe2Lq0P2bdqRew6ELBVQXst7oPhnFz?=
 =?us-ascii?Q?vwOUpvoj7tTZze3y6VksGX/Mgbap0SCOXm8t0xLqcEIrjuLMlX8bAXS7GTHR?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de2dc878-f8e0-4417-8bff-08dab47b350e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 22:17:29.1563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6H1WxNj5pXD9TFwRivR1PR5BfaGSzW+GUHIBPikav76J81P4TQII0XsJ8NHz7pnDs/z/MuD1HhLwn5STPCQcTZiiNq+OzdXY9mAnU/RiATY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7017
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 20 Oct 2022 21:14:29 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > On Tue, Oct 18, 2022 at 11:52:27AM +0100, Jonathan Cameron wrote:
> > > On Tue, 18 Oct 2022 10:36:19 +0100
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > >   
> > > > On Mon, 17 Oct 2022 20:00:09 -0700
> > > > Davidlohr Bueso <dave@stgolabs.net> wrote:
> > > >   
> > > > > Introduce a generic irq table for CXL components/features that can have
> > > > > standard irq support - DOE requires dynamic vector sizing and is not
> > > > > considered here. For now the table is empty.
> > > > > 
> > > > > Create an infrastructure to query the max vectors required for the CXL
> > > > > device. Upon successful allocation, users can plug in their respective isr
> > > > > at any point thereafter, which is supported by a new cxlds->has_irq flag,
> > > > > for example, if the irq setup is not done in the PCI driver, such as
> > > > > the case of the CXL-PMU.
> > > > > 
> > > > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > > > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>    
> > > > 
> > > > A few nitpicks inline.
> > > > 
> > > > With the comment one tidied up (other one optional)
> > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > 
> > > > I'll rebase my cpmu code on top of this shortly.  
> > > Hi Davidlohr,
> > > 
> > > Doing the CPMU rebase has shown up that using this generic infrastructure
> > > ends up rather ugly.
> > > 
> > > Previously I had a local array to manage the required register maps
> > > that was then freed.  Now I have to move that into the cxl device state
> > > just so I can get at it from the irq finding callback.
> > > 
> > > So I have an extra step to be able to use this generic framework.
> > > 
> > > 1. Query how many CPMU devices there are.  Stash that and register map
> > >    info in cxlds.  I could do this in the callback but that's really really
> > >    horrible layering issue as most of what is done has nothing to do
> > >    with finding the vector numbers.  
> > 
> > FWIW I did this for the event stuff and did not find it so distasteful...  :-/
> > 
> > However the information I am stashing in the cxlds is all interrupt
> > information.  So I think it is different from what I see in the CPMU stuff.
> 
> Right now I'm just stashing the max interrupt number to squirt into a callback
> a few lines later. That feels like a hack to get around parsing the structures
> 4 times.  If it's an acceptable hack then fair enough.
> 
> > 
> > > 2. The callback below to find those numbers 
> > > 3. Registration of the cpmu devices.
> > > 
> > > Reality is that it is cleaner to more or less ignore the infrastructure
> > > proposed in this patch.
> > > 
> > > 1. Query how many CPMU devices there are. Whilst there stash the maximim
> > >    cpmu vector number in the cxlds.
> > > 2. Run a stub in this infrastructure that does max(irq, cxlds->irq_num);
> > > 3. Carry on as before.
> > > 
> > > Thus destroying the point of this infrastructure for that usecase at least
> > > and leaving an extra bit of state in the cxl_dev_state that is just
> > > to squirt a value into the callback...  
> > 
> > I'm not sure I follow?  Do you mean this?
> > 
> > static int cxl_cpmu_get_max_msgnum(struct cxl_dev_state *cxlds)
> > {
> > 	return cxlds->cpmu_max_vector;
> > }
> 
> Yup. That state is no relevance to the cxl_dev_state outside of this tiny
> block of code.  Hence I really don't like putting it in there.

Yeah, I tend to agree. cxl_dev_state is the catch-all of last resort,
but if there is a more appropriate / less-abstract object to carry a
given property it should.
