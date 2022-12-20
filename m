Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699816527A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiLTUOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbiLTUOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:14:03 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855C31EAF3;
        Tue, 20 Dec 2022 12:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671567242; x=1703103242;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aH/CFiYha+TPl8R8UMht75I+v+miWIIOex+WCczSdUQ=;
  b=X+m9Hy8joPSidLjxNHXW07ZXYjT9YoSA19fKvER3GjP5R9PIRtpPDPHP
   ew/LAYIb9H11HfETkAbVvO6o8/ePZNCHFNtHy8i2VVXLTy0UU9Q4/kdJ+
   wWeHNgCqnPEScR3LGoB9cyL8VFdIbQlH7LpZttiNbtpzbM6wHplQ2aJSt
   T+Cf+Ehq3ioYZlWfVaE8Mj4S1JtchhSAh5PDMtw4k4ciQdDqcSTNxs0xE
   Yy63wXNS0CM71CrYsQABs2Wi6WaIeIC53XInIyLZWTPerX2fn2g1Onv5d
   Xl4YvTjJY4V+o2TfPQjb7ArvLU/PKGnlvAMy+uQegl0PeYByIjDoiAPcg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="381936852"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="381936852"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 12:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="601234157"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="601234157"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 20 Dec 2022 12:14:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 12:14:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 12:14:01 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 12:13:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsjVNzYAdggOgZgk7prXV1oe5IW/v2bE2C5z+lk7R4sTVDUZHBgIR2chb1Ot5mdMdDGw/O1a6/+qgSbXDMt/TdhzpBDyMRv5NrlwZLu1Xapx7zFwjLKFVyaDFjB6dLklsaLCr9nSVhcxMPRz0mHNo1Z1sM4FCWA1WgfUJfJEW0kmilxmMR+Q5/rUjGgsV0/NmNzxlfESC4IfzUtNl07EzUgjfrIw6D68E252KA848pfR7fxSFZt1vYLQKx9K3JAPkCIe83/tMfEfVMkBE0Bq4lrxp7AO8urmaX/RmGV7PGdRAHM61ihIvxTHlpqex4JPQ4Dnt5uCZITP5FGelRJXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH/CFiYha+TPl8R8UMht75I+v+miWIIOex+WCczSdUQ=;
 b=fo4xwUXGJmIqTtK1Jl/2/Dn7QPyurKBN35oHuI+S+tUfNi1Duz4ZpYEQwVkXyBfKSJuHpNqsq6RBkVAv8UwKddOysjXupErydURYtpKGfg94NY7eVCHsMLNm7tsVKEt1Y4GcGqLH01h4ozqgtGLq3+5/T5LBrw0RvsRXDsrnVrA8psg5yDGm/fyDMVZ8u1HHm12d8zfbtPOUBRKD4iMdEKSGw3vYkAjBjVGX9FqN4gEuWS2FfCbgcNw0K6F+p33p0NEGUBgE6g82rCEhT7Dnd1SCi7l1i2ePBWPGjvOoD/Ra1jX4rxabuqva+OiOdKsQL3XH5QhcgiZwAdwa5G7vAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR1101MB2121.namprd11.prod.outlook.com (2603:10b6:4:50::19)
 by MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 20:13:43 +0000
Received: from DM5PR1101MB2121.namprd11.prod.outlook.com
 ([fe80::1583:8ae8:221e:fe00]) by DM5PR1101MB2121.namprd11.prod.outlook.com
 ([fe80::1583:8ae8:221e:fe00%11]) with mapi id 15.20.5924.016; Tue, 20 Dec
 2022 20:13:43 +0000
Date:   Tue, 20 Dec 2022 12:13:40 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
CC:     <dave@stgolabs.net>, <a.manzanares@samsung.com>,
        <mcgrof@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl_test: remove nvdimm requirement
Message-ID: <63a21774a3e03_1bf2294bc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221219195620.351544-1-mcgrof@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221219195620.351544-1-mcgrof@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::7) To DM5PR1101MB2121.namprd11.prod.outlook.com
 (2603:10b6:4:50::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2121:EE_|MW4PR11MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: f229610f-c17b-4427-7001-08dae2c6b166
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9IXW+N0DAiS57tx+2/hIeH3cpjFxiTkJlBDZRuuehuF9wGJtQjxPuVAW0QFPmYeYbbr/5vDolXNx8R4OdFtoqDz5uxRvS3kItrgdDx86jlhOvWZGjxxYY88/irFHkIJYq9X3R7R601N5RV4sNcDAyGE4McetKY5rwWowl8AjVjcP4QHXWK7Mm7JPmTfdPof5fui2Fp74iuoJzrrA7hTvNsTOgf8T0yOngsyk7l/qyc/+J9+tGlbSSte+0SqvGg9Uf7UV9arcw3A8NDZwxGj2teDqQYkIGeLE3YudZYDUeZtlCEoriJ/KyCACfInHEUcYPG3tKZMgv9W5BnPS++GnfWxJiTTwhwrojBC2cOeTMd9xsLd5V4gpas1mwsxw6wAyQKTK0p6Ls8Z0UkQ2y49YBgV/DQbcr8zlQN70Lv9PNoFM9HsLiQCXU5me3TP2AVxq/P+OzLz+FHYBHsNwH7hTadIOodhv5fa8mvg95gxjPLxRTtF4wzDyuq+blXgtDjY1ETYNzMhWgAD54/FIKjN6oY2gxyB3dyTuqjxbrwdK1k5J73vsdvIKqSLNXU3ADndLKAbUV0HQHB/P5K+dxzE/YsRysdEU/X2vv0vKccgDtDFR2MXVl4Wg4Ir9TD9A0SfT8xfI6Lk7xnseNVIlGu8VQaET4FQLXGC80Nx4rtoLC7ZVgH24NTAzBLf15iUhwlvYtqVRC570g3rfkNlYwhgs867csDE4eVNlmmNihpOcE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1101MB2121.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199015)(8936002)(8676002)(4326008)(4744005)(2906002)(66476007)(66946007)(66556008)(316002)(41300700001)(82960400001)(83380400001)(6506007)(6512007)(186003)(5660300002)(9686003)(86362001)(26005)(966005)(38100700002)(6486002)(478600001)(15302535012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ESD1/GmvIBW5eNRdRclTCJ1KZLS2ytr64xP+KuYlr8AVVbudlhWEbUfBhjcS?=
 =?us-ascii?Q?wYp1/NSeFqSMSoPr1WZ2tZjPhur/lqZ7ZiH3cbI/SEP4FTfIlkwM08h8gkWK?=
 =?us-ascii?Q?TkS+43F1qtDvMNp/lkAOmlzwwgURa3DmimqO6jN2sa+rC/9EZ1A+ihh8nDON?=
 =?us-ascii?Q?8BauGhlbjd4BfeR0YysrIYrT4/VMuYVGrhxeoz5Yp0VUP2TipFLB2ODorLhM?=
 =?us-ascii?Q?EPpaDh1QBgiGpsKZMsiWTSjYgnRxJG0b0pa12aWEiHq1dRCc9t7yXx2oVKrL?=
 =?us-ascii?Q?9tVCZS5kPLdELKgahlLjJBHZCVdLFHPgfQK4TXzxwzZ9qE59CmfMmbSBTwTc?=
 =?us-ascii?Q?6ZIodWEnaJwwgWhfr/TAqa3PbslI5JI/QlRos2ibskhcmMs8ITqhY0btIMZH?=
 =?us-ascii?Q?JqzrVtuLUUVXrl0DphOChazdF7Jv2JM6n40f6TaIry2DgP35qwVgSU3k1s3V?=
 =?us-ascii?Q?RZ+TT37ibuch6GwwEFu+xq3wFRiPzmP15nKCsN2n5eHDEwI+MB/R1gCK7Z+L?=
 =?us-ascii?Q?LMMSwxoBACmPVnZtMGfQllGn/cDidK12z0NJojI0nt2ZdJXklK0Vj46Dbdb0?=
 =?us-ascii?Q?w4zHLilt3g5Bm+k/2U3IgnjKrFNxfOSIcNJCuQhnHaLIplUKkGmgbWdVabh/?=
 =?us-ascii?Q?glOCbz/RMxvOfYrgpl4OjxBrG1QypmBn9WX3B3PTIyLMMLFggC8f+H0X9l0x?=
 =?us-ascii?Q?Y758VTbAVCqIB1gMxpggBowUCqZMuI4chY6QOskyDJlGQvjRpn8XVUzqiWwg?=
 =?us-ascii?Q?8zLC2ekpck3pna3FcQatz5gVPwgJ5rPSKmnBvUDgH17Edyshu9w6e1BAm2em?=
 =?us-ascii?Q?gXqsCjG1nZo9IQ6xHoX8IttEqpZvGWOwE0re8RxTDtU64bRXJeBt1DbUbgS1?=
 =?us-ascii?Q?xEM1FX+DBCXHRklytruu88R4txIBRI4sD7hvx0UKxbgw5xPDfwMkfcJcsw2K?=
 =?us-ascii?Q?g8SNW7UFEmcrVgwFNATF+XHoGmuxd+UlhNnzHP+9It3SRhYfPhE7XAShIAFj?=
 =?us-ascii?Q?Cq10kHXH671liKc14iZKXH7ntvW8Hzis5bAZQareWtNZ5cocg/I+ef3MMqxn?=
 =?us-ascii?Q?cBmnPN+nGOJBUAPti1rA5JAwHHrSeiZZqAtOiaHTbdbTjBawctWlP9pbggPf?=
 =?us-ascii?Q?z45TaF87K7F/+HwVeAWq8grJXXMaLxKuCF0mk3TSP/QAI95zePqCtRVvag67?=
 =?us-ascii?Q?JVvz1IlVX054gl7U+vmdxzfW6aT1ym+I+T7yQ4LnynCbIqdcyqk24qma6ovE?=
 =?us-ascii?Q?T1kyq+G7amaCKE24vWSkR9olEA06AUVoCIrpfEuUFFuX7uhH+2mBG1c3SLt8?=
 =?us-ascii?Q?Vpo7c7Ew0uAKmQHzLJdhouHrQl7PeBt1FFEFcQinZoTgn2sPUNKrXaO6oVmp?=
 =?us-ascii?Q?TcjD8jox+94EnIJSyDEwhlCgArxC/PomVngJmURdPrd8DRxtFJWhI9iDxI9d?=
 =?us-ascii?Q?Q16s33vasv6vpxGiKB0W5zbnuccMemhB7BE+46SKWgNu23TTs0vl4deKWAGJ?=
 =?us-ascii?Q?ytAn/g4k5RTmO7N+q/RP/s6Zoj8KoQl5803GYY/RZHqngdel5Sy6+28ZnPF2?=
 =?us-ascii?Q?4IJXmT5wStilNRNYMY3RgHCe2XOiQ/HB/G1raE2TxbaCrJ8qR7kpSZqEqNuU?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f229610f-c17b-4427-7001-08dae2c6b166
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1101MB2121.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 20:13:43.6685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CJHmeoPAJoXt0ZnNP4gPXfxuNKLQVp78ZqGk757oc16CTt5AyzO5kjVagY0YC3cUjYHydoPuW/de+QW+RSvx42ywaRSMsDunYDXv7H7q7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7125
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain wrote:
> There is no need for NVDIMM to test CXL, so remove this
> requirement.

Are you perhaps running without the new nvdimm pmem security test?

http://lore.kernel.org/r/167105505204.3034751.8113387624258581781.stgit@djiang5-desk3.ch.intel.com/

...again these types of mismatches are expected in and around the merge
window when linux.git and ndctl.git get out of sync. I would skip
running cxl_test for regression purposes until around -rc2 timeframe
when all of the new code has settled in both repositories.
