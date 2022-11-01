Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA94614FB2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiKAQtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiKAQtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:49:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9058186D0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667321342; x=1698857342;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y8Hlm3HfWLwB3wmtFzcCoLJ2cYZdbztbypW+16xVkq4=;
  b=Swd3vlSZDmyDekAAH3H8KPZqfGdeJA9qQshB3eIDsBgm1TGnAPePhOQK
   IQEGtRnVJ7Mft6IeuSxIIq6ep/C4COwdwcGo1sQjZ3l0rCCNC3JwTpqWU
   mO8g3DW6KQKSbA1TiuTVF2MBbJY2Kd0+Zd02KHVVAqz/JCOdiqX8yWLcs
   Ap1NviCn3mJUNcmEdLxyNMK/3gbDrUwJEqjX+HXqNILNQnVG3Vud6EFkL
   iElodULf3Fz2SAHgTXuD6e5l7767NSCbrre6R50U9w0yuyPhgJHyzWhxb
   gsZjsVlmnQuQDugS/9d9aAVFvYsS+qRcVUY7iv6oL8Vug3iHucmVpEbtA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="289573219"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="289573219"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 09:49:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="759236148"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="759236148"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 01 Nov 2022 09:49:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 09:49:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 09:49:01 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 09:49:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9+wl5FblDuwIVFfDNgTuXXTG/mFzSn/pNRuzf/1sdfMrlESw0c9PcS5d+4XoqZdJlsVoLpTa/NSGDU8Del/TSK/dx/astA4duev/eXBkoXQgLp/o2g72IOqKa4Jqc0FlSTLRfGyebgVyeaFMuiLD5BHj80Ygn/7KYpz14E65/3KMA980x12yvsQlITEr1l13B3oB+DbgnIk7D7IMFrxl6UVj6dgCf6doT+w/5JVDeSJhGvsHJxi2wmXj6zA/+S0KEBPKtoHRUGsTGw84e821/pUlgDQ94n53F4yVzGb0oOB7EnWEi6jcjy9DGWyMCwf0XhCaYBBLVFFOzvQ0soQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8Hlm3HfWLwB3wmtFzcCoLJ2cYZdbztbypW+16xVkq4=;
 b=Gz9Wy08NoiI+2JjWeCuCoFTHndayiRiJmi26pf2tPRN2LgqJlZ7ME8DU2pdnJ3uEFrdknqa0bHFfswcwnOB74i/hy4jW6S6+Fgf1vBty1REnosD+DqGwOfNViB+hwXhfDq93EqSnm+GEXKSd9CRDZpxIBjvNq8sVWAf3kmS6GT7BJf6yfNHWPDnJkjWlyc5B8bFUqWBjHyQ0jBLPbSOQ7lG9tJ+Ue7TOMFmRq83hNb1WyvPz328FTq1/uXdjlBk2AMAe5lWcflU9UobDTLFq6aOgYgM2RP7Sy6sBGq2U4I42XmpLMxqxSjD1695tqlWNJA3b8tSQc3ItCpgyIjitDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH0PR11MB5708.namprd11.prod.outlook.com (2603:10b6:610:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 16:48:59 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 16:48:59 +0000
Message-ID: <d3c06fa3-83a4-7ade-6b08-3a7259aa6c4b@intel.com>
Date:   Tue, 1 Nov 2022 09:48:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
To:     Peter Newman <peternewman@google.com>
CC:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Babu Moger <Babu.Moger@amd.com>,
        "Gaurang Upasani" <gupasani@google.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
 <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com>
 <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
 <CALPaoCgiwtvxZMJ6f-BOTNMPXDbMB8QM42HyCAvYRi4grPiphQ@mail.gmail.com>
 <CALPaoCg2-9ARbK+MEgdvdcjJtSy_2H6YeRkLrT97zgy8Aro3Vg@mail.gmail.com>
 <715e4123-fdb3-a71e-4069-91d16a56a308@arm.com>
 <CALPaoCjUk31HvhaqWKfkLNLyZJzbDLJOnEqTsqn882CToLCGcw@mail.gmail.com>
 <317b4a96-f28d-aab5-57cc-f0222b7e4901@intel.com>
 <CALPaoChNAaoJ7uzuxFFDn-f5nvUCXyJ4jkbETHXNdDpXNnh9pQ@mail.gmail.com>
 <08c0e91a-a17a-5dad-0638-800a4db5034f@intel.com>
 <CALPaoCj8bVo3Z1r9_Ag=6KvGuR2wzQesArwZKEDvudGPYbbwaA@mail.gmail.com>
 <CALPaoCikWKz8VLf5QdeYm5k58tePTpb3nTKMGJ+qeGmevjvMpg@mail.gmail.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCikWKz8VLf5QdeYm5k58tePTpb3nTKMGJ+qeGmevjvMpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:a03:114::14) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH0PR11MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: c1235ed1-6159-4d95-f703-08dabc28f918
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YftLgWEIJrZtEIfyc6lOEgXIoxhhqUVvcliz0wloFL0Hr1Qlx5YhMtfGsesU+MsZywoXPeNkLP5BlSGcrqoKHLZwPBNahahtut0Qg8NiibfUjdrd5PdvUiTufv9F7TC/k3U2Buunb4sN2iKpNPF1gDa48x19wMH/5HzRpvxPJXvXZICMCtbjOmKkjETRTf4baPMfkMPsYu8YC4ZnTyAT8jhtGms8C9e+yozjdBVqPWfc4IryBL81ddHRLtEa+sd3H3II7GNNfMNy5aIfYZKfHvM6dtA/fmZNeQ24EiFbnDgzntrktEKWVyRTPIVHow5Ux0kOHhIe+3lWPasIH5awFYSCzy4pHXlgPdVPYV3B1TKrP17/rJBVTscFg3lSmhdJdU8SP56j+4acHsBG2v7J4klC8X6Odeqsxe51/OirqxdBqEs3/FTOKa5p2pEq2ztrnyCG/agO8J9lky22M3ktqrgE3Xr3XV2k3Dn/QIzSAeLcOnngiiy5aBqo/Kcdv8PhntHH2jilLF1wyy748V6EwoWFSrzXmbSS/eOIuCI6N2xtgw8a1af/LFaeS6EWJsmEg5xQWptnvdVVpQdcTGCCfEJ4Ff8EVlkizZcdsSwgeFmExhkEkEa05w60bofSbf4YVjtMFDLvL07VtQYT35ZPGW+ZkOyARKtm+lIN36oGJkgUJ7L4OdoxrsxWpjeb4BisO5RXU12VW76r5ARfz3aHuujGwN+OaxqJlurFirALADhXFVPv+sFkFVlNW8yDh1GHSwxrDbEwNtv3CrlLBG37tmd1hu2+oCFW/VpWnlD/dos=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199015)(82960400001)(36756003)(31696002)(44832011)(38100700002)(86362001)(2906002)(6486002)(6666004)(8936002)(54906003)(316002)(66556008)(66946007)(66476007)(478600001)(8676002)(5660300002)(4326008)(6506007)(41300700001)(6916009)(2616005)(186003)(53546011)(6512007)(26005)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2FPS2JGUU5ITUpRUXMyaXl5N1VmeVRLemdDY1RyaDFVNkhpNDVTUklCYkt1?=
 =?utf-8?B?Q1JYYjVYSW5pZGV4ZnI2SC9IRjZKNFA0V1JOK1cvc1pJa250RWhDUktJUWFV?=
 =?utf-8?B?TDNKNU9OcUhwUC9VakY3TWRXd0h6SUpFU05BWWYwNnVaUDRLcXhyeGs5ZHlq?=
 =?utf-8?B?NGV5QlQ0QVNRVUtVMUVDUzgxazZZaE1laWhmUm0vZ1lvYVRlTkVPN05zNkdG?=
 =?utf-8?B?V3UyZVJlZXhTeXJxNlBGYlFNUjkxc1pBZStKdWRreE1GWFRDb2Q2QWFhSFhR?=
 =?utf-8?B?N2FuaVIxQ2NxQVpQd2xRUVNXM3A2N3VSOXhQTTN2QmlZaC8xOHY3OWwyeTk0?=
 =?utf-8?B?QS9kKzJKNnlGVjc0d05VMFhFQlNGa29tZ21kYy9zTVJ2dzFuZTFKWFJaYVZ5?=
 =?utf-8?B?SDJPZGdtS2swKytPMnljN3p2SXQyMExiU3A4Ylp6YWxaTTVsd2k4SncrUG1N?=
 =?utf-8?B?TFpJa2FSMW9oeFFvZFdIWkxDdmJ2Y1IvSUUxM3dqRlZ1NlNVUkNCVWFHTXNm?=
 =?utf-8?B?RmJzOHp4cnArak9QTy92d2huK2pRcmNMcjRrUWIvWUd6WkU2UjNyUHpldUdi?=
 =?utf-8?B?RUk0aHVhaFlmbU1oTEFaT1pYNTQrVHlYN3NHYWdtMVc2dEVHM3N2OEJyODJD?=
 =?utf-8?B?STZQOGFMdGdXUEp5bUhCVjhWOG5xc2hrdmphV2ZObzhGK01TVkg3YWZCN05H?=
 =?utf-8?B?K2hnVkRhM1lRNzlSZk9KRkxmOG5kelZWNDZ2dkpyVEhLenFFbERYZVd5Tndz?=
 =?utf-8?B?RkhsUGNkT3ErWjN2Znk2end1RnM3bVd0TFNVNC9OYlFXR1JMVFkxMWx6NjFB?=
 =?utf-8?B?L3RvdzdjbXBEcXEwNGRiWjlqVVIrRW1tK2pwOXZXNWxDTEVDMWdqbXdPZ2tX?=
 =?utf-8?B?bXBHaVJrUnQvdGZac2p4S1V5bUFnZE1qbkFON09VMmtrM29kMHI3RW1KNnZi?=
 =?utf-8?B?anNYRitkdHdiZGEra2psSVFMRnRUOUpIUTRYNFBoUk1TcnZCTjF4a01PR2ZH?=
 =?utf-8?B?ZWlEUzZVN1dFQk1nU3g1NGhhRnNUeFFEMlR1c0N1YmttRC9vZzN4N3Zwbjlk?=
 =?utf-8?B?VlRvVlc5WEVBV3lrQ0xUNS9YSUpaTmYzSmNhZEh4Qy9yeTM5OUlYUVhKVmpz?=
 =?utf-8?B?STYrQ0FzV1hSR1NJZFY5UmpvYkRmMjNyZ0FTdE43VWl1cmpzNytNT1I1aTRn?=
 =?utf-8?B?WmdvZU5UL1JYQ01wcVJBTTVNZ3M1c1F5b1diWktySFJOM1NVd0VjZEJyZ3Jh?=
 =?utf-8?B?WGdDSmpVNzU0bjJEcHhqYng0aklZMlM5cktyRjNVQTNGcVBVWVM0a2dnbFZr?=
 =?utf-8?B?azRFblNiMnUyZlhtOE1RMUNSWEovK3F4ZVdaMlFPN2sva3VDMStNUFMzeDJp?=
 =?utf-8?B?Q3pmS3hEc242ZEpISlB3TUIxMjZmTERzbnUwaFhTYWtQRVgzbEpqSUMyNzZY?=
 =?utf-8?B?QkIxWFpLcmdxM3FVQ3BZUlBrbXUxZGttNXp4NlFwdWxUSHllaVpZY3VWWjlT?=
 =?utf-8?B?UTdiZE9YRHR3MERiaHM5WCt1NUd3aENSNlc1Y1ViOExDSE5TRXplRDZwZ2tH?=
 =?utf-8?B?OHdVUHMxL1NsNk9BSkNIanh1UEsyM2trQm8wVS9wTDBxRGFXWGJjTnlHVHZM?=
 =?utf-8?B?RWF5Kys5anFFUW1BT3dheWZzTjRvV2JWdDllaEViNERFRmpZRnExYWZ6c3c3?=
 =?utf-8?B?eFc5Mzl5a0NHSk04L3Z5MGZVM2ErYTlrbDZzdklmOGRmSitQbGxIdzF3dHVB?=
 =?utf-8?B?ZU15alI4VGxIcDRHTUJRdm1qV0c5TXY0SEg2cDkwMUNHVXZJbHV0SFV1T1dE?=
 =?utf-8?B?cDNHMkVkZzYvV2k3SEQrMDlrSTk0M1BPTTlmQXpXbStCMzJBWUw0dDYrUzJo?=
 =?utf-8?B?TFdyeW54SHNGamtoZHhqWkpqY2FlNStEMzVTOWk4TnJ1blRkT3JraGhqU3Vv?=
 =?utf-8?B?Q2VyM0xOVWgxWnc0Sk1DMGxoQ0tMS1ZsWmVtNlhlQUlQYURyNTR0V3dITFpq?=
 =?utf-8?B?aHFCam5HZmI3SkhUYkluc293MmZZOWNGeUVnVDRpZm9razhDY3l3eS96aHBF?=
 =?utf-8?B?dHF3WUtILzlndXUwcW1vVFgzOXlRY3RxV0s3VEFpcjMvczB1MXRmdHErN01V?=
 =?utf-8?B?cXF5UTFmN3NrYU9GUEFyVjRkSFpGMVRSVkVQUkdsVE5HbXZ0OERvWjAybUI5?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1235ed1-6159-4d95-f703-08dabc28f918
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 16:48:59.1785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6pJlrcjK7+bQAsjCwuuIxFsxc+OtrAAGevLJp+BbXoeszQy8wRtkxh0fJXM9PYlzDGFChrztvfjhXV/UB40iqnnGM9ETY0C903RyrMZr3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5708
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 11/1/2022 8:53 AM, Peter Newman wrote:
> On Tue, Nov 1, 2022 at 4:23 PM Peter Newman <peternewman@google.com> wrote:
>> Yes it looks like the task's rq_lock would provide the necessary
>> ordering. It's not feasible to ensure the IPI arrives before the target
>> task migrates away, but the task would need to obtain the same lock in
>> order to migrate off of its current CPU, so that alone would ensure the
>> next migration would observe the updates.
>>
>> The difficulty is this lock is private to sched/, so I'd have to propose
>> some API.

I thought that we could do something similar to cgroup_move_task(). Instead
of new API it seems that the custom is for subsystems to move their scheduler
related code to kernel/sched/. For example, a new
kernel/sched/resctrl.c that implements the task moving code that benefits
from the private sched/ APIs.

But ...

> Actually it looks like I can just use task_call_func() to lock down the
> task while we do our updates and decide if or where to send IPIs. That
> seems easy enough.

Indeed, this does look promising. Thanks for finding that.

If you do pursue something like this I assume that you have some
challenging environments in which to try it out? I am curious about the
user space visible impact of the additional locking on a task move when
the number of tasks being moved is high.

Reinette
