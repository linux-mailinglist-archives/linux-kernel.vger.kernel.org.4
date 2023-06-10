Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C9472A881
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjFJCiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjFJCiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:38:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA9D2139;
        Fri,  9 Jun 2023 19:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686364696; x=1717900696;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kO7MprUdBmBPV54QqKZkgIEM9Ck4wCxVNH7iE+YpJFs=;
  b=Kip20lfqjIhUvkmajDnNc+GKkmHK9jKPFZz00iAKIKFkctkdYL8U/4SB
   27BB25yVm68SAOmNTCrwiTYskUaCaBQaI0mcx+dKSrdBFwYQdTQORZKKz
   MKLy/Ao4ruZibYGXDrRL+7Y3YdsfoDcJIME6DSf80b9xpMAANWliP5pLs
   2dAvrbZwhd1WkP9EUvratfdsewzH3hejX91LgHPq0h94D9R00N54Fv7hB
   mt0eJSoqrfo6aAgfL+XCvmMsu4ix+pt+Va1E+tUI82BY002SDl2I+Fi5k
   I0MKY9/II3kc1ylXUEHpjJg1XsGZk+qMHxDi7J7Qx1NbP4jaZvrzmaWEh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="347369316"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="347369316"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 19:38:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="1040672366"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="1040672366"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jun 2023 19:38:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 19:38:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 19:38:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 19:38:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJabLyyfG3Gyf7MpwpsWzUqRJmuLtaFh0narCrGC0TaNRzBfYJVUYdg6kc3l2NwFcMLZ/uC/SS6zIn7bSo+Ze5Mf3mksPlnxOrtaHhj+UXfOXakcvgeGrpXJyQVewcl+hqsS3WimbGiekPyF8zY98caTnUAx3VaPDacYEWLK5ODTNHe55RYgYQak32qqxKgnVxLDHF8wGcJGbpWCDGZ7Pjc8oVBmVWFrIlSlVdUA6DKuF+10xWUB0c6lbD3SywsFVkZDJOYUkhi41f0X+y0Jt9Gt+EfMFeERx773qnxcxhO71PUKaSdGphuqA7+E7ETThDtVzVWhEnCSexBySuWvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDrwMAo5GunfqWKRsi8TRzNI2cZHC8TwUsVDiNlRzqs=;
 b=GoynIEFk0Pcb461MedYk9zPZbXzzu1lY90ftXRHJ7Vlk7l3iSWW0md4j6OHAqNxQ6SZXs7HdtUxNChqC+3IRBQMKQHKKPW0MDXWxGo0eCySMCgj4ZVwRhJGAXsjgy0pRyid2Zc8n+EF4/RKePc4b7gVh0XDT/2pT2MS6fOekL/8bv/AVESI0Ltm4MVqs2/Lr3uU0S/uPrPOIugxUtTmua6HjmCZeKnULstrF5oeATC470KyaR8ictaogBzk1aILqLAdxL3s9GcKd1JkFttj983+AdpDDb5svbQazAQgW9sCTwsLvLXszVBOdQ2q7HqxsM0n9+YpXs23wFPygDtgwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7245.namprd11.prod.outlook.com (2603:10b6:208:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Sat, 10 Jun
 2023 02:38:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 02:38:08 +0000
Date:   Fri, 9 Jun 2023 19:38:04 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 18/26] cxl/pci: Remove Component Register base address
 from struct cxl_dev_state
Message-ID: <6483e20c66cf_e067a294f7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-19-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-19-terry.bowman@amd.com>
X-ClientProxiedBy: BY3PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:a03:255::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: eefe458c-a974-484e-4b8e-08db695bb9fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QMk/KHqb1HnB/HI+zh4fBQ/CXSmgq2bsFAN139s5Ye56/7SEBE44jqoK90wfmtMul6NJ9H6TUxze8aAoWqr9Jhrgb2aUBDzm0E9aB+earuxmsMYJZ/KZKZWuJWYpiVwyUjkNXr7YTOk/7NccHjTLtdGDuEUgwaHBy4yY5pa2ijcs1+Uu3E55jUd5QeysPwSoCmG9LVG2ZEPMGAf8Bcoym3CxhB6d/kMfTf1SNvIhFQdHJN5OBcuOE/hKiYed5Gzcs5kH8Z0DT7vcjOP6ByAGRvrm3746MOBZ+rxgJKJXy4fKQwo/lRLQoPybw5ou/l7HpZ1YAf+VeXpx7czr/riA/LaTVTFIH14fFd34BQUBPre8PDG6XnqKSkyr7u2wPLBoaSN3GrlDjz16XKWj/ENg98eA3OZPv2OaqlNNdbeHHe8NR+30/clURQkx1PM/0LJofEqlG0tNtPgo9A2gE633ddDvtiSU0COZjwUUybF6e5PbsE4ck8VTspm+FDvt55AU4kxmq9V/trpEy5FhPEdgpV2v/xUHQ+dsLrO7VW3HIGFbJYriXNJ6m7BTTTnr1SmR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199021)(478600001)(82960400001)(8676002)(8936002)(4326008)(316002)(38100700002)(66556008)(66476007)(66946007)(41300700001)(186003)(6512007)(6666004)(6486002)(6506007)(9686003)(26005)(86362001)(5660300002)(4744005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wv7C4S3NYwOmSrQSJekKfbGh6xHOciPfI3v1yRxjGPJlWmbexhD9FhnLn5Ot?=
 =?us-ascii?Q?xtHGch973Q24Gbv/nyhTSFxd4Vkg1NI4L72JeG4nd9gNetUxhzdT5FmAn58N?=
 =?us-ascii?Q?elSTEPeNijDT+zPVTfZujCFRZ5dmR/8DwCRCxUccnfiCa+Okebek7NT53Bcm?=
 =?us-ascii?Q?DkmEOmr0Id3l/LBj+GhszyGFIXDCza6dWqrWNtBWeuHopFWJ0Kqhby2sNJoD?=
 =?us-ascii?Q?UUDCwEoMsjz9lA0rj5RC3xraGUdBtp5PD6W6gElt6IsWqzr1wndNjxIYiTLD?=
 =?us-ascii?Q?00GmtxaMKeSYvd44Sisl6poGhUiGosdzeqKqWoDCm6pTEU477ARb4iUqXhNr?=
 =?us-ascii?Q?gryhqwNboHfsh5RvvXyWMGvPr9eRwqfaeSqTxTdtDgzB+5J5irFrNuAAmdkv?=
 =?us-ascii?Q?Tf55ZWUdGUpPLGRyfEKi16Zh9uWkbqXrPwmIWR1O0mRURkx/CDOHxE86nfGl?=
 =?us-ascii?Q?B07jwd7yJPetXJlPbf558y+TcQRwOudzXsiZWeP+UvreoafvV2pmeU8syhjo?=
 =?us-ascii?Q?JfmxNgLnmNCqjfJXEjt/bD8CV0etsJqx3fVOpgyX+qs7i6G/0ahv4B1ax0Ot?=
 =?us-ascii?Q?4GCZtMjBctgXuFCfFAeYhAMp30HLMMVSejAhVBkG69XwGdS/pMIvEHEM367E?=
 =?us-ascii?Q?X/JJFPKRJv5XOBr9seqLvvsPTg08yLTQKJNoYQGJpC0G1H1KzsLfDldZOvT3?=
 =?us-ascii?Q?ZfN9gMH6lLumKJm9QLsaHRmPm07jwnO5wgyIjvQkXDEm1qSNCK1YJhqMfQhF?=
 =?us-ascii?Q?280wTfSJrKoX5Lw8CxVNbwwrLeIIRdZuqVbNkS1RyIGHz1rNL1NfFnomz+AC?=
 =?us-ascii?Q?39JtS9LwZP9WUIiOdkgHdRHV3eoYGU3hrMJeMCYRgSdcWw8iWblP1o/ZfViw?=
 =?us-ascii?Q?/nGZtX0P9emnkhWjh/FNfyy8ETntBERCYJCkV4VVAFhC1H9139Hzu1C6gYQJ?=
 =?us-ascii?Q?VwOF1FMaJjJDG3GLFOx7Qg6GbwMVmBu2IHAoEsi6UHa9dyFOmycw1eB9CdXy?=
 =?us-ascii?Q?B/XJ0zn224lCyNZWFfR2hRuwV8zpzzcvDANBRLdky873qt0p4yn8KYEkGi2D?=
 =?us-ascii?Q?3uUleRQUYwyMXcxnI+EMZSYo9n8EpUWiMYZ4oyola6wnpNfrbRam5u89ConE?=
 =?us-ascii?Q?S438qZLpHCCXxU20G7cU9gkalTwO0zoQWp2UQMpaRXSNNDofSgxEZK+Kaod7?=
 =?us-ascii?Q?5KQRePyrIC1Dw3YPuix5CXf95+lmQ0SL8OwuJyIJBueLCz1+Whh54AKkm6du?=
 =?us-ascii?Q?yPHgE2iKTG15G+Q37irLOk+b1xx6ooFdKzBBZYb+BY1W+yjckYJfpIk2z9UI?=
 =?us-ascii?Q?JhW0UdKsQczyVVLrmTXDFSJAbwbQR1j6FIjaV8uIbhzzMr3zqYHQitAaGl7h?=
 =?us-ascii?Q?XlwZ9poaGLHwK/Tjfhqs9UZ7m2A30AIuvbxlngVfWmfLdMj6rqPVW0mrQ9DD?=
 =?us-ascii?Q?AP9vuF12broz9aNRZSJdny0VCqLCjZIGwIiAG2YCBz9H4sCb0JNrrH56HtzV?=
 =?us-ascii?Q?cuoNMb411gxeAJzsPq9HnAbLNdLdSXApQpPKxCggmojkdf/XIElklb5cDExs?=
 =?us-ascii?Q?GrWZcRABXAAKj6UnTqemjhH/GnajKxLHY3JKDnlgmJV9ZRskQREAgeo3cdZG?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eefe458c-a974-484e-4b8e-08db695bb9fb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 02:38:08.7498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wIYRUMdSpMKdKeOpK60R0iNA3aDIAD+fS2HmhyIrLs6XdkiKiHMxkHSx2dw+P1X+37yLA97UIA3hVEEV4YyGUdts0sTNOZG/UmH1TDIIEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7245
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> The Component Register base address @component_reg_phys is no longer
> used after the rework of the Component Register setup which now uses
> struct member @comp_map instead. Remove the base address.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Looks good, if possible fold it in with the introduction of
cxlds->comp_map.
