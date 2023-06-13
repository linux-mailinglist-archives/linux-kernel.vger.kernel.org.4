Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF65072EDA5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239642AbjFMVJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbjFMVI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:08:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2522E19B7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686690537; x=1718226537;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=IL+6wd9UiwTs0hMTs2WG6H2e1qjTI5NK7D/vx14hLdc=;
  b=Znh/9Zxb4Uh40QQOgn1di142kPEJHWIDRl0+ctOj0J1yOGdXW9wxMYE4
   89hEGwSE1apKNiJweV5qa3VFYeBU90FBBi/PUwbprGpi6i6dSXksY3SyL
   RhmaqlAa0Oz6/HhflShc7UkGhSVQ8Ux1YXhcaULXSAJKf10BHBH6FAc97
   MsiFm9jHJwOs0H65aFeZ+aMYVAKLGxLJYJ813LFpZ/M8yG7GVWrgNuuvl
   C5ULr405cIuUVhurAbbOFrbFd+zQ8XktQ0Cin3Kdenk5YZQGaBCV5KyZN
   4FArWrjs6k1ZQy1OIcdHIRs1vyxfO2LfOa8k21zGq0dHkqtu4Ae37T5tA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="424334126"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="424334126"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 14:08:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="856253807"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="856253807"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2023 14:08:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 14:08:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 14:08:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 14:08:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwLL4D9VLcoGLgTV29usrvXFLXbJuHjr6hyEew3Mr0Eqc56EJPfGAg/LeLEoAtcHc3NfsXFbgzYCBo1g/yivGzLlDCa/jJVtxSiGUyi/Hc5sIR6JFL9C2+Wup9L+oSWie+SDrKrIYpb3OUY3BRL0hOLiVrSADITjNQE9VgWtVUf6mPVYqQH9NdSW1LX+NG9Uag+TBFHII0j9tl/GzgEjgWk/aPC8VL2GegkPc8Zjm2eNPogSHQSEDwL28D26LpP7Xmtdeh671vLP2qp4Tjk29sydG9ZA82hPznVQGNFRit+ibTyY0HBwPlkrQ2vHY5ACqU7tUkO5e+MIHEpqNLNDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nx4eM3nhdRgXJVUPd4sNSY0HrIHMZPYGuPO/Qx+Ed7s=;
 b=kTjIYoeXq2Yuwjpdc9316mYscq3V3DWp6p2kZpnFRhYg2PduJvS+ctWnkndZYNfII7F66tDWiOK/hv3sC2yUh/TqXTAxbrMhSOUP9M8/VAMTHgfHtpx4iY4n7h/hu1rfR48f3agGUHzMjEC1DWmfSDr9D7rSLeu+JkM79czmr5VsnnjMtTwePyOtct3AcgwotT7bU29AiqaPoGkI24Nwr7IXwKJgH6x7giBnO9mvTWDFlwur0HSb0XSebrzSuJHV8FKcnraF+j4KrruuWsGezlYhT81A9BxoLd/Kjr43uzVFaCZ3g2IBr5T8jmAY0RU8FYC1fxNuyJ13+xAwX1AQBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5689.namprd11.prod.outlook.com (2603:10b6:610:ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 21:08:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%6]) with mapi id 15.20.6455.037; Tue, 13 Jun 2023
 21:08:54 +0000
Date:   Tue, 13 Jun 2023 14:08:47 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Sumitra Sharma <sumitraartsy@gmail.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Ira Weiny <ira.weiny@intel.com>, Fabio <fmdefrancesco@gmail.com>,
        "Deepak R Varma" <drv@mailo.com>
Subject: Re: [PATCH v2] lib: Replace kmap() with kmap_local_page()
Message-ID: <6488dadf965f5_1afb9929434@iweiny-mobl.notmuch>
References: <20230610175712.GA348514@sumitra.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230610175712.GA348514@sumitra.com>
X-ClientProxiedBy: SJ0PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:a03:333::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: e487233a-47c9-4209-c496-08db6c5264a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9rvb4ObGSGcy2yDTKs21BpilNbxGT5ZtIyshFZnxlL+Cx0zlQMLi02N9khw3Nm70CMvv/FfTxVo7YtrE/WKqFyEpA8I67pKIz+AG3B5ZQr8u4q8C9m/udlxTU+RKtA5Sd3nJLnbf6Yli+bYVWZcymvfNyYyjwUIKLC1Ie9kTGeYHMP0bHD2DSaALIccY9sS+ADgCxl6nCn4onjgKTzIZYq70f8Qe4YbdKtx9yjykyeUkk8WF/uehDpySBCKmZt6UpQjWDwsmiTMU09cPWgQqkMjj5tITLU+4PGs1UdGDONk1V/uEBpZIL70tn0hs+y38ur2KXgSlXMv6WwA1DjeNPVCkt672S7+159osx27F0zJ6LAFLcsspXdwAML96mvLN+NXOMu9wwIijmJdce/13dPV7Lq6C1ha33U4Nntsb3ACq5vNjPcVvP6tXTE8u5AdlMqOsBHR1SfXUTVVuXbs1l+iftYa1uVAlkSJ1qZ7SvrTj/fwMuEG6T7FVoMQ+tGeVJw2GvgQk7MF/OaLVAWaAjxZArUCZtKp49rjMS2Xnohp/MXU4kHF3aUXZ+LvCARj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(82960400001)(6666004)(6486002)(478600001)(9686003)(83380400001)(186003)(26005)(6506007)(6512007)(86362001)(38100700002)(66476007)(4326008)(66946007)(66556008)(316002)(44832011)(8936002)(8676002)(5660300002)(41300700001)(4744005)(2906002)(110136005)(54906003)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU9MZVlnMExDbUJwSW5kZW5SWFRXckJnM2JvNVJSeEpuNFMyUE9EYUdySUR5?=
 =?utf-8?B?VC9taTNESHFsWGFMeWJ4dDNudzg2VXlFRHdSWjdHQ3RCVmtMcFVoN3hJTmg1?=
 =?utf-8?B?NFpJR1RjQUIxNnFabUlleXhGS1hPRlkyam5vVGk2U2ZRSVBHV1dyU1ZQeXpV?=
 =?utf-8?B?VWcwZUNxTUdTYnIvbWk5blZqQ3FicjNIU3lQMWhuS1BjeGFESVZjUUxWeUR3?=
 =?utf-8?B?RDY5L2kvc3ZZd3ZhUzhZNTFNbWV0cTZjZHJ1UENNQkc3QS8vUEtVVmVDdGRz?=
 =?utf-8?B?RVNsQ1ZFRVhNZVJGM3JlSjR6dDFseGtIaFAwcmVHcVJ6ZDVqS2NlamEvT3RI?=
 =?utf-8?B?KzAwa2FrM2pwSEIzVW5RYTUxMUdNRXZETWdaelV4WEJCZXFJOWtwbmRXY3li?=
 =?utf-8?B?N2M4K0s2SGUvTEZnWlVpM1pyWXo1dFpRajMrenVJc2E3NXlCVEZ0OVNqN2d0?=
 =?utf-8?B?dWMvUUZ5dy9BVnlrR2ZHbDNvMDVobzFHVkhiOVo1YzdxdmMzWkIvVUtNVGxy?=
 =?utf-8?B?anZHOGM4VEhyYk90aTVqYkcwaTNwUjNOWUljSkNmSWVqeVJqUnphVEhmSnVi?=
 =?utf-8?B?c1ozTkhaS0ttT2tkWno5SnUzd3pVMjQ4TEdiVEZOM0FFdHpMUjd2Qk8yeTFo?=
 =?utf-8?B?SVgxRzd1UndxV1hCd0x6NllJSUpBRjBVVTNJaTQyQlU4Y3BJc2hhQXI0QWw4?=
 =?utf-8?B?Ti8vQWE3QU9wRWRiR1FnMzBZcmZ3THpUeUJxWnJvcEV1YlRuaTlpcEFraHNV?=
 =?utf-8?B?eWtNaFJ4aTFWVllZSUpVcGRJRG1ZMndvMm13b0piMTFTUGtTVkg5eDhLNEpj?=
 =?utf-8?B?L1cyOHk4ZmpYSk5ub0pDVWIzMEhpR3lheFVTcVRKbmJzd2dSSGU0aUprVUE0?=
 =?utf-8?B?ek1ta3VTWWJiQ1R1YmZraXVJQnJpOUczbzNnaElkVkw5elh2NGVxNWpqU0dL?=
 =?utf-8?B?K0F2WlgxZVJnQXdzWVlSMHRNdWhyZ29abUF4MitHU1R1cHM2aklnWjRtVWhR?=
 =?utf-8?B?bFU3QnZ2eE9wRDVvajRWQUNhTnZXdVdEa0IxUlFYdEtqWU4zR1Nham1OTmFt?=
 =?utf-8?B?QzIrQUMyK1ppUXJZRGZBZkgyODI0VDlyaUFHKzhBTTFkSUh6MzczWFFVYk5S?=
 =?utf-8?B?RCtIS3p1M29HRWpkZ2wvREw0QlRJclFXTUpMRFZmeVNOOU9yazFrTHJOTG9L?=
 =?utf-8?B?ZFJjVy9WR0tnU3JGenVXcEtxRmcyOHE2ZDUrUUdvVnRlUFpGa01BNUNxdEw0?=
 =?utf-8?B?RmFLdXAwd0Q0YTZObG1UcGczdXkwekZVd2hXNzFFRHpsWm96N0ZuRkpqbVhN?=
 =?utf-8?B?RVM0NzZxeTM1TWF1aElMbkxQYWhJczNscFQwZnJTU1BSMVBrc3VUMFo4eWxr?=
 =?utf-8?B?aWdvRXNuNkNxU3U4TmRhdkxZbVlyc2MxQTlEVlJ3R3MyMno5d0NNL3FmR1Rv?=
 =?utf-8?B?cTlkdHZEU2I2akpDdkQvYkIxYWI2NzB1R04weUU0dGRLZG5GRDV6ZVI4ekxM?=
 =?utf-8?B?RnUwTUp0czZRTUV4WXhNaTFXeWwvS3ZTcDhKWndJLzRHdzZDQjhBZHdBQVVv?=
 =?utf-8?B?OThaYUkwbUxMSVRUa0dFWmE5L1kvRzhyMGRrZ0tqY3Z1RjBFWkVPcTNxYmE0?=
 =?utf-8?B?VUkvQW53NFlEWkx3VWI2VS9pdk5US2RGVTZjYklzc3ZCSm9TbTBoMmpJT2xO?=
 =?utf-8?B?bkMwUVhDTjRVS2lIaUhBa1pGckFremJ0S0c4NVNxZGF6UkMxYnF3T1NLUkNl?=
 =?utf-8?B?QXNPYzFqSmc2T0hQZG50U1JZVUVYUC9wVUFTVTFqeUR2NklSbXNyUHFMVHp1?=
 =?utf-8?B?VmRaTGZMMWpYMyt1U0NBZHpJNnpHb2czS1JTejhIZWtlcEJpUjNpOUE0cFhy?=
 =?utf-8?B?K0lmRWhpS0g5SXpyZXhtZXArd3RibVRqL3FvZlZRTzJzaWJ5TVJSbUZKRC9I?=
 =?utf-8?B?S21neUpZOGRRVnoyOXloUk5LVm1BQUo2c0hySFlsc1Y5K3ljVm8vOEltTTFY?=
 =?utf-8?B?WlYzeHM4YTJUMWp3bnZ4L2lPMXVNaW5ZMXVsR3N2eEErN2V0YzQrWXdxOUk2?=
 =?utf-8?B?bmlCUGVtZmZta3pxeWpHcWMvc1psWjVId0VYb3pBK1BxMU43aDR1QWdIaWNF?=
 =?utf-8?Q?8WtYBe3mRpf2EV1Kms68oqNHI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e487233a-47c9-4209-c496-08db6c5264a7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 21:08:53.9140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S18RonqVb+nNZqThuEIJMFcVvWyyYKozGHlUtjtEyZkSd5NlNrf12xYHDxc6wLYr64gRVfThOnU7PIQRorOuxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5689
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sumitra Sharma wrote:
> kmap() has been deprecated in favor of the kmap_local_page()
> due to high cost, restricted mapping space, the overhead of
> a global lock for synchronization, and making the process
> sleep in the absence of free slots.
> 
> kmap_local_page() is faster than kmap() and offers thread-local
> and CPU-local mappings, take pagefaults in a local kmap region
> and preserves preemption by saving the mappings of outgoing
> tasks and restoring those of the incoming one during a context
> switch.
> 
> The mappings are kept thread local in the functions
> “dmirror_do_read” and “dmirror_do_write” in test_hmm.c
> 
> Therefore, replace kmap() with kmap_local_page() and use
> mempcy_from/to_page() to avoid open coding kmap_local_page()
> + memcpy() + kunmap_local().
> 
> Remove the unused variable “tmp”.
> 
> 
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>

LGTM

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
