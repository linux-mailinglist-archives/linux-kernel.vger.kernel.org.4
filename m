Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790DD72EB0C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbjFMSeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjFMSeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:34:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2A8AC;
        Tue, 13 Jun 2023 11:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686681254; x=1718217254;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1Ttil8a6VVFNRSdw9GaibSoEb/CwWOU4m4bYSTl+i+8=;
  b=VRpLbAJq4w7+ycJ80gFvX9heRjqmFzYgRkpf+E6zywqnStjtCfNwqnvm
   9sQC9S8EIuJv7TFIlrXYNEEgVvdXJHDYrNeG9ht6zphqO+4RytA+edtWl
   6taxf13nxXdR8v5o2RUsax1hPJuypL4vbpU5AUjalqCe/4IjiXcS+j9JJ
   3FGgqf/IhPePmlDHXK3i/au2N2tGVkI0afbGoesfrZjs3djV+vPG5tWV4
   vCTXKhlOw0xPeTTyR1eM79dAjwmoZCI3gV2yOfastdb1h4X8xG2/okLx0
   FGaFO/o3pSlBlZIJDMzF5j9PTWrkv1PRyyHz/Vp+TvxbSjvtjTQu8BDtl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="422018712"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="422018712"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 11:34:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="958497705"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="958497705"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2023 11:34:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 11:34:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 11:34:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 11:34:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jf6Bbu7ZUVySFDJZRGRql0DD5NyTw+4GChByss6VkUCsS5gOYbS5kxorScatYMFS0KeOMcWsx01ilCT8FZRvH8xVI7Xu1eD4bxiw6gNxZWr6stfEydQStrE2HKm8zaU5gyXBQ3AZZRh6HL0t0WsnzYZ2aFB+uZi9H5rU1vnGhaEgtza9owmSLEOmEA13RNwR7BiYnQNaoEd4Wle2dT46CCXVlTegId02+/ch0jw5XdsH4x9vG3xdCVNoG1pcQAgLPAoogLnW98sabEiwcxCKVdtDkEdEjC/fU0Q1gv4rMmk6fVzUw+RiVBPVHKrn0FoTz+nKioO/l5kLL1ol+nQs+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jokI1o0JDedKO7PZUobkq6fRwjcnIRuynz8w15fOwKE=;
 b=QkvfC27X+rPqQW0f2+iwjIwEmxLIldUhelaC+0VVPqtsiqY/ZfN6qtj/3srnzAlvYXWplKR5W+WGHzNKmjg/9kj1H+BYWkiiFkbO2u8MDiXnEAykas6G3y4i2+Pq0sbMjbWyKfAL066EQPBrlko3fj3rP3iYA+bXS9QrEHSFuKMUJETvgLoUl/g4YbFp7VC5zl0xpo2gP2DwbXsqznqI+iybbZg1Uy29liNgZNKEpqOruL9NP1y69zmKEgNRUz2P4S5sX5ZGmRnwf6BWkyA27Hc1D+vnqw9lFFhUsGa1TKgBWO/TeZYuxqZPgu/+FGG0PzU/VwH/MJ/qUleJbDM7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 18:34:10 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 18:34:10 +0000
Message-ID: <3f400c5b-8f5e-d80c-23bf-69dbb83217ff@intel.com>
Date:   Tue, 13 Jun 2023 11:34:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v3 1/4] cxl: add a firmware update mechanism using the
 sysfs firmware loader
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <20230602-vv-fw_update-v3-0-869f82069c95@intel.com>
 <20230602-vv-fw_update-v3-1-869f82069c95@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230602-vv-fw_update-v3-1-869f82069c95@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:a03:338::27) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY8PR11MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 52544059-32c6-4aaf-7bcf-08db6c3cc70f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Rf32eq7dpaJ6kKuy3v6yBRy5r281wBV62RMtjPBwZX9ZQkbw3a1tU5LQuICJ79OFZjmXP2Lnqkgq2EwowQaCclInUKaWQMw1+QthE+Tt2wXY7wc4B4EA6+WMBdEUmeBB5ZxAb09izTshBXbfgxT1QqlmLU5rSRebwmCIhJDCqsK6LEAnkM/cEZBcqna8rjGa7zp6kQ4qrTpVl5cRgxNaTOtJlgCg1SHIEL3l/Ayz59/hVk0mkSWi/+9kCxBygi/NQ5mlsndF/p1cYL1GYHmKyOUxE5L4nHn0nH6Qk4c3xzjY61Cy1fofq+J7edJDiJrJ0A/NPbct79x4DcGRKDOKH0vW9DniBXj6XxRvWUSxYVWddmg2KvmW8ziD9KzJ/U1EKdfk0zA4m6pExdk/MsnfSiKlkGzETrcGF9OZSZujpvXGVc23SGWPpuD3Eq2+HPS54UavO2tKKuzq7Er+TAcrEUb6mWgM4LtGLhx9l0mSSvSlzDgNzymz4s1whmTUYMQA3MCCLQbI6Cb7yB6Vbcq7vQYztCcoJEq1vkyTJlJdbFKdNFfkfXg6fuVLxQ8RFjzYw+XlZAkHntPORb8slBE1HS2Vxxl1sCLJJ69nbXk9M3AbMRaWfJhRpy45hk3Eh34o8aexKP5+r3hQ/Vh++Em0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(86362001)(31696002)(107886003)(6486002)(316002)(8676002)(41300700001)(26005)(82960400001)(5660300002)(83380400001)(6512007)(38100700002)(53546011)(6666004)(6506007)(8936002)(44832011)(66476007)(36756003)(66556008)(4326008)(66946007)(478600001)(6636002)(186003)(15650500001)(31686004)(30864003)(2906002)(54906003)(110136005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnYvTWpvSXNMYzFRbStTaURRTC9PUnllckpjbkN0TTZiZWREcndyazJ4SWJa?=
 =?utf-8?B?QU03VnVWSjdXQWRlTHhlMkZxZmJPUzkvUXdTaCtpU1ZRYjgyU0xXWUZNSEpY?=
 =?utf-8?B?K0JZb0xxYkJKN0ZkQlV3R2ZvSWgzNlhYVjhXanBKZHJua3BHOVJkSVpyVG11?=
 =?utf-8?B?d3Q3WjJjMUN0eGVwNWdZUDA0M3JJdEpvdTdaeWxqNlQzNC9KNm5FVXpySXNz?=
 =?utf-8?B?U2M3OERDM29wbHN4VlZLbmtQR1VRZnhrY2tsbUFyd3ZjNktBQmtjUS9JQjBm?=
 =?utf-8?B?MFN5NnhTdExkV1ZCYjRWY00rT0twTkFzUTUzOHFqZXBoUTRNZUNYYUZGUXhw?=
 =?utf-8?B?cDFzWEZKYVlvSktuSGNCZ1I0azYrdXZNU2E5ZjRVaTFSN0pqZUZBOVpobURV?=
 =?utf-8?B?ODFZcUMvRkdlcEtIamZPUkZVRGFsZXVad09jMzk3WjZnR3pqSjM0ZHdVd3hC?=
 =?utf-8?B?WUdvSExkVjREVEU2ZkUyZXZiUjhZdDgyMGxCUHhBa2JZYUdUM3JiNWIxdmVq?=
 =?utf-8?B?dG9Hbnhha3VTMWlUN2Q4MWRXRmVzQWo0M1pSaFliNFhWUXMvd0pvM1dtS3kz?=
 =?utf-8?B?RDM1MDV5eFhVaGEvYjJnaXV3R2tiS2hnQzJwbHVocTFNcFE2aDZzcXM5QkU0?=
 =?utf-8?B?SlU0dmxBZ3NhNzY3Y21nZzJVODJqUGt3aUxyYXArQXNkSjRsYW1iL011TVlM?=
 =?utf-8?B?azdaSkpzTUV5SzhnZnpBWjlSR2hERWN6RnpwN2ZQK2Y3S2xkQjJScERzSERq?=
 =?utf-8?B?WnNWS3V1TXlSbWMxd2ViSElWZEpUd1F0YThZUDJOTUw0ZVFpaHhLeU9DK2FR?=
 =?utf-8?B?bXBlRTI5a29ZNXRHbnpZQ1VibW9BaTh0ZDVBb3JqaXAxUi9DYU5ETHpoOFBT?=
 =?utf-8?B?UG5hTE05TFpJUGEvTkJmV2JjelBVQW9yMU1HWVU5TkVIVDN5a2pzNkpnOExZ?=
 =?utf-8?B?TCt1S0VPV2pMZ1VERjF0aUdUS0tLTDVhcGRRakt4MXZTQkhPNDVqU3hxT2ky?=
 =?utf-8?B?RjZCRmlqeTdOb1ROTzN5Mkc2cTJ1LzZQNFRSQXJJWE5aYTU1Q2sxaTAvY2hs?=
 =?utf-8?B?cGZBRDU1dGJ5TEpaOTFDYm8wYmo4QTRTODNYNElteFRoK1hibGU3QTk1R0U3?=
 =?utf-8?B?SG5zSTQrU2ZSV0lrNzFWa0ZrMnNpakhaQUNudXhPTzBDa1hFWFlkYlAxK3pG?=
 =?utf-8?B?dEtzOTVUb2dTQkxoR2pPd2NQaFBaSG94VFVOQUNhUTlYT3ZnSDIxbTEvYjJk?=
 =?utf-8?B?b2RpSVNDSzRFVk1PczhoV2VyMGQranpQbGpZcm1Rd1ZKNWVpWDM2dDI3QTVs?=
 =?utf-8?B?S1M2Uko0eEp5WlRLK21Wb2xOL3Fub1pJL2lZVjU5UWJsVlg0cEZ6ZTZrMkNv?=
 =?utf-8?B?V3FyK24zcUlteVdsZ0hMc0QwODNOcW9xMUNYMVVEWVg5TUMxYlJMZlBIWXVZ?=
 =?utf-8?B?eEM4K1pJK2liUnJJelFjQVlCL3RSbUN2T01RVktiUjBnK29KcjBFWEo0RXE1?=
 =?utf-8?B?R0hDMGNmREtqaS9XMWNzYjdqY01ucTlWdWlhQ0FiWE5JUGJINzBjaHM2VlFl?=
 =?utf-8?B?ZlhiQUhjVWVtbjFacmx0Y0xsbFZmbHpXQmRrOGhucFM5Qm9QczRhRlI0ODRp?=
 =?utf-8?B?ZVBTcjM5eGtkL3R6dk9ock5GcGUrMWlBNGVnR3Z5a0hFTEJ2MlJuYlVxcm5D?=
 =?utf-8?B?aXhOWVU5dmRKQm5YQ2pOakJWbXE2ajBXenJrT2ZXcXh0dUJHd1pQeWhSQW12?=
 =?utf-8?B?WlViUkQ0WTRQUTVMeUwzd0VzMXNqWjZGMi8rUUptaGU1U0RmQUZ4UHJPTDRH?=
 =?utf-8?B?ek9ValpMd2lwSDlMb0NmTk1tQ0ttU015MUpjYXN6bDAyb0RTRU5YTytoREVC?=
 =?utf-8?B?bkpXaDVmdWxLT09sc1ZWRFhBRk9MQ0ZwZXdJL1k0OHRoMXhzOW1UT3lDY1Iv?=
 =?utf-8?B?Y3ZkaVdQeWIzSjh4TW1wcTNrOFFrN3RodHdnSXpEd1hvenRKZEJEM08zMytm?=
 =?utf-8?B?cEl1bzluMXpaQjErZkpUdkcwT01vbDBQbEdnci9RUTJySk5SYUdDMU5KRFk0?=
 =?utf-8?B?VTFzT1YwVHYxMXBvdUhDcTNSU2tIdnY5VTEzamZQR3JNWUdpUDNJdm9Fb3Nq?=
 =?utf-8?Q?KCePGhld55/PJIUZbaxxQGvPB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52544059-32c6-4aaf-7bcf-08db6c3cc70f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 18:34:09.9299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdAtVtAmNfRNL4R0oYFgWxRx6wnR9VqQrqJSvdvWCqNn62MqZRcc1KG8WJr8+bvjGbfBiTecLL9OA1yjEmwS5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/11/23 23:55, Vishal Verma wrote:
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
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: Russ Weight <russell.h.weight@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>


Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/cxl/cxlmem.h                    |  82 +++++++++
>   drivers/cxl/core/memdev.c               | 310 ++++++++++++++++++++++++++++++++
>   drivers/cxl/pci.c                       |   4 +
>   Documentation/ABI/testing/sysfs-bus-cxl |  11 ++
>   drivers/cxl/Kconfig                     |   1 +
>   5 files changed, 408 insertions(+)
>
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 1d8e81c87c6a..ffc3c31ac5bd 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -83,6 +83,7 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>   }
>   
>   struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
> +int cxl_memdev_setup_fw_upload(struct cxl_dev_state *cxlds);
>   int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   			 resource_size_t base, resource_size_t len,
>   			 resource_size_t skipped);
> @@ -260,6 +261,84 @@ struct cxl_poison_state {
>   	struct mutex lock;  /* Protect reads of poison list */
>   };
>   
> +/*
> + * Get FW Info
> + * CXL rev 3.0 section 8.2.9.3.1; Table 8-56
> + */
> +struct cxl_mbox_get_fw_info {
> +	u8 num_slots;
> +	u8 slot_info;
> +	u8 activation_cap;
> +	u8 reserved[13];
> +	char slot_1_revision[16];
> +	char slot_2_revision[16];
> +	char slot_3_revision[16];
> +	char slot_4_revision[16];
> +} __packed;
> +
> +#define CXL_FW_INFO_SLOT_INFO_CUR_MASK			GENMASK(2, 0)
> +#define CXL_FW_INFO_SLOT_INFO_NEXT_MASK			GENMASK(5, 3)
> +#define CXL_FW_INFO_SLOT_INFO_NEXT_SHIFT		3
> +#define CXL_FW_INFO_ACTIVATION_CAP_HAS_LIVE_ACTIVATE	BIT(0)
> +
> +/*
> + * Transfer FW Input Payload
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
> +#define CXL_FW_TRANSFER_ACTION_INITIATE	0x1
> +#define CXL_FW_TRANSFER_ACTION_CONTINUE	0x2
> +#define CXL_FW_TRANSFER_ACTION_END	0x3
> +#define CXL_FW_TRANSFER_ACTION_ABORT	0x4
> +
> +/*
> + * CXL rev 3.0 section 8.2.9.3.2 mandates 128-byte alignment for FW packages
> + * and for each part transferred in a Transfer FW command.
> + */
> +#define CXL_FW_TRANSFER_ALIGNMENT	128
> +
> +/*
> + * Activate FW Input Payload
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
> +/* FW state bits */
> +#define CXL_FW_STATE_BITS		32
> +#define CXL_FW_CANCEL		BIT(0)
> +
> +/**
> + * struct cxl_fw_state - Firmware upload / activation state
> + *
> + * @state: fw_uploader state bitmask
> + * @oneshot: whether the fw upload fits in a single transfer
> + * @num_slots: Number of FW slots available
> + * @cur_slot: Slot number currently active
> + * @next_slot: Slot number for the new firmware
> + */
> +struct cxl_fw_state {
> +	DECLARE_BITMAP(state, CXL_FW_STATE_BITS);
> +	bool oneshot;
> +	int num_slots;
> +	int cur_slot;
> +	int next_slot;
> +};
> +
>   /**
>    * struct cxl_dev_state - The driver device state
>    *
> @@ -297,6 +376,7 @@ struct cxl_poison_state {
>    * @serial: PCIe Device Serial Number
>    * @event: event log driver state
>    * @poison: poison driver state info
> + * @fw: firmware upload / activation state
>    * @mbox_send: @dev specific transport for transmitting mailbox commands
>    *
>    * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -336,6 +416,7 @@ struct cxl_dev_state {
>   
>   	struct cxl_event_state event;
>   	struct cxl_poison_state poison;
> +	struct cxl_fw_state fw;
>   
>   	struct rcuwait mbox_wait;
>   	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> @@ -349,6 +430,7 @@ enum cxl_opcode {
>   	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
>   	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
>   	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
> +	CXL_MBOX_OP_TRANSFER_FW		= 0x0201,
>   	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>   	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
>   	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 057a43267290..3234885ad804 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright(c) 2020 Intel Corporation. */
>   
> +#include <linux/firmware.h>
>   #include <linux/device.h>
>   #include <linux/slab.h>
>   #include <linux/idr.h>
> @@ -542,6 +543,314 @@ static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>   	return 0;
>   }
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
> +	struct cxl_mbox_get_fw_info info;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_FW_INFO,
> +		.size_out = sizeof(info),
> +		.payload_out = &info,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	cxlds->fw.num_slots = info.num_slots;
> +	cxlds->fw.cur_slot = FIELD_GET(CXL_FW_INFO_SLOT_INFO_CUR_MASK,
> +				       info.slot_info);
> +
> +	return 0;
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
> +	struct cxl_mbox_activate_fw activate;
> +	struct cxl_mbox_cmd mbox_cmd;
> +
> +	if (slot == 0 || slot > cxlds->fw.num_slots)
> +		return -EINVAL;
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_ACTIVATE_FW,
> +		.size_in = sizeof(activate),
> +		.payload_in = &activate,
> +	};
> +
> +	/* Only offline activation supported for now */
> +	activate.action = CXL_FW_ACTIVATE_OFFLINE;
> +	activate.slot = slot;
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
> +	transfer = kzalloc(struct_size(transfer, data, 0), GFP_KERNEL);
> +	if (!transfer)
> +		return -ENOMEM;
> +
> +	/* Set a 1s poll interval and a total wait time of 30s */
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_TRANSFER_FW,
> +		.size_in = sizeof(*transfer),
> +		.payload_in = transfer,
> +		.poll_interval_ms = 1000,
> +		.poll_count = 30,
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
> +	struct cxl_dev_state *cxlds = fwl->dd_handle;
> +
> +	cxlds->fw.next_slot = 0;
> +}
> +
> +static int cxl_fw_do_cancel(struct fw_upload *fwl)
> +{
> +	struct cxl_dev_state *cxlds = fwl->dd_handle;
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	int rc;
> +
> +	rc = cxl_mem_abort_fw_xfer(cxlds);
> +	if (rc < 0)
> +		dev_err(&cxlmd->dev, "Error aborting FW transfer: %d\n", rc);
> +
> +	return FW_UPLOAD_ERR_CANCELED;
> +}
> +
> +static enum fw_upload_err cxl_fw_prepare(struct fw_upload *fwl, const u8 *data,
> +					 u32 size)
> +{
> +	struct cxl_dev_state *cxlds = fwl->dd_handle;
> +	struct cxl_mbox_transfer_fw *transfer;
> +
> +	if (!size)
> +		return FW_UPLOAD_ERR_INVALID_SIZE;
> +
> +	cxlds->fw.oneshot = struct_size(transfer, data, size) <
> +			    cxlds->payload_size;
> +
> +	if (cxl_mem_get_fw_info(cxlds))
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +
> +	/*
> +	 * So far no state has been changed, hence no other cleanup is
> +	 * necessary. Simply return the cancelled status.
> +	 */
> +	if (test_and_clear_bit(CXL_FW_CANCEL, cxlds->fw.state))
> +		return FW_UPLOAD_ERR_CANCELED;
> +
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
> +				       u32 offset, u32 size, u32 *written)
> +{
> +	struct cxl_dev_state *cxlds = fwl->dd_handle;
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct cxl_mbox_transfer_fw *transfer;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	u32 cur_size, remaining;
> +	size_t size_in;
> +	int rc;
> +
> +	*written = 0;
> +
> +	/* Offset has to be aligned to 128B (CXL-3.0 8.2.9.3.2 Table 8-57) */
> +	if (!IS_ALIGNED(offset, CXL_FW_TRANSFER_ALIGNMENT)) {
> +		dev_err(&cxlmd->dev,
> +			"misaligned offset for FW transfer slice (%u)\n",
> +			offset);
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +	}
> +
> +	/*
> +	 * Pick transfer size based on cxlds->payload_size
> +	 * @size must bw 128-byte aligned, ->payload_size is a power of 2
> +	 * starting at 256 bytes, and sizeof(*transfer) is 128.
> +	 * These constraints imply that @cur_size will always be 128b aligned.
> +	 */
> +	cur_size = min_t(size_t, size, cxlds->payload_size - sizeof(*transfer));
> +
> +	remaining = size - cur_size;
> +	size_in = struct_size(transfer, data, cur_size);
> +
> +	if (test_and_clear_bit(CXL_FW_CANCEL, cxlds->fw.state))
> +		return cxl_fw_do_cancel(fwl);
> +
> +	/*
> +	 * Slot numbers are 1-indexed
> +	 * cur_slot is the 0-indexed next_slot (i.e. 'cur_slot - 1 + 1')
> +	 * Check for rollover using modulo, and 1-index it by adding 1
> +	 */
> +	cxlds->fw.next_slot = (cxlds->fw.cur_slot % cxlds->fw.num_slots) + 1;
> +
> +	/* Do the transfer via mailbox cmd */
> +	transfer = kzalloc(size_in, GFP_KERNEL);
> +	if (!transfer)
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +
> +	transfer->offset = cpu_to_le32(offset / CXL_FW_TRANSFER_ALIGNMENT);
> +	memcpy(transfer->data, data + offset, cur_size);
> +	if (cxlds->fw.oneshot) {
> +		transfer->action = CXL_FW_TRANSFER_ACTION_FULL;
> +		transfer->slot = cxlds->fw.next_slot;
> +	} else {
> +		if (offset == 0) {
> +			transfer->action = CXL_FW_TRANSFER_ACTION_INITIATE;
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
> +		.poll_interval_ms = 1000,
> +		.poll_count = 30,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	if (rc < 0) {
> +		kfree(transfer);
> +		rc = FW_UPLOAD_ERR_RW_ERROR;
> +		goto out_free;
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
> +			goto out_free;
> +		}
> +	}
> +
> +	rc = FW_UPLOAD_ERR_NONE;
> +
> +out_free:
> +	kfree(transfer);
> +	return rc;
> +}
> +
> +static enum fw_upload_err cxl_fw_poll_complete(struct fw_upload *fwl)
> +{
> +	struct cxl_dev_state *cxlds = fwl->dd_handle;
> +
> +	/*
> +	 * cxl_internal_send_cmd() handles background operations synchronously.
> +	 * No need to wait for completions here - any errors would've been
> +	 * reported and handled during the ->write() call(s).
> +	 * Just check if a cancel request was received, and return success.
> +	 */
> +	if (test_and_clear_bit(CXL_FW_CANCEL, cxlds->fw.state))
> +		return cxl_fw_do_cancel(fwl);
> +
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +static void cxl_fw_cancel(struct fw_upload *fwl)
> +{
> +	struct cxl_dev_state *cxlds = fwl->dd_handle;
> +
> +	set_bit(CXL_FW_CANCEL, cxlds->fw.state);
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
> +static void devm_cxl_remove_fw_upload(void *fwl)
> +{
> +	firmware_upload_unregister(fwl);
> +}
> +
> +int cxl_memdev_setup_fw_upload(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = &cxlds->cxlmd->dev;
> +	struct fw_upload *fwl;
> +	int rc;
> +
> +	if (!test_bit(CXL_MEM_COMMAND_ID_GET_FW_INFO, cxlds->enabled_cmds))
> +		return 0;
> +
> +	fwl = firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
> +				       &cxl_memdev_fw_ops, cxlds);
> +	if (IS_ERR(fwl))
> +		return dev_err_probe(dev, PTR_ERR(fwl),
> +				     "Failed to register firmware loader\n");
> +
> +	rc = devm_add_action_or_reset(cxlds->dev, devm_cxl_remove_fw_upload,
> +				      fwl);
> +	if (rc)
> +		dev_err(dev,
> +			"Failed to add firmware loader remove action: %d\n",
> +			rc);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_setup_fw_upload, CXL);
> +
>   static const struct file_operations cxl_memdev_fops = {
>   	.owner = THIS_MODULE,
>   	.unlocked_ioctl = cxl_memdev_ioctl,
> @@ -582,6 +891,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>   	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
>   	if (rc)
>   		return ERR_PTR(rc);
> +
>   	return cxlmd;
>   
>   err:
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index a78e40e6d0e0..ef0b4821b312 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -842,6 +842,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
>   
> +	rc = cxl_memdev_setup_fw_upload(cxlds);
> +	if (rc)
> +		return rc;
> +
>   	rc = cxl_event_config(host_bridge, cxlds);
>   	if (rc)
>   		return rc;
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 48ac0d911801..06a7718d3fc3 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -58,6 +58,17 @@ Description:
>   		affinity for this device.
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
>   What:		/sys/bus/cxl/devices/*/devtype
>   Date:		June, 2021
>   KernelVersion:	v5.14
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index ff4e78117b31..80d8e35fa049 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -82,6 +82,7 @@ config CXL_PMEM
>   config CXL_MEM
>   	tristate "CXL: Memory Expansion"
>   	depends on CXL_PCI
> +	select FW_UPLOAD
>   	default CXL_BUS
>   	help
>   	  The CXL.mem protocol allows a device to act as a provider of "System
>
