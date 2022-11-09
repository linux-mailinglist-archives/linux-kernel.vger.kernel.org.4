Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2438B622267
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiKIDGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKIDGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:06:51 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE8623389;
        Tue,  8 Nov 2022 19:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667963210; x=1699499210;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zny7xKrjBNnHZFOL//LaFycTtE+gz8tIUDgMcMixXaE=;
  b=UZcC4+0R2sdYwVV+r6BMqdi+w4rWYAS2EPCCMx4RuPS5XZ4Re5AUQUud
   Jgf1bZ3Yr9AWdbtp5AfOllp7vilARteHEeqctMdobgdfMeWlr15wbzs2L
   QvYy9vZJ2nTMJxpg5XTJ6EfvwXlMamKfmSu4pwfvqKjYCqOm3zXkjl81i
   kZJkmEC+eOY24yKbRAPm3QEtzC5WCSgemf8QFuJITqQTwaLAw0bW/l2gD
   IDDdwVPSgY6SP/A+weAG4v+Vbv1GszoT3lc3Apo7JhGryuhc3p301JVY/
   YnpKvmsGY+zs3eyWBXjYLVC+NcXPzw241UiJBJGD+EeU+ls6uLlF/xXyI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="290591383"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="290591383"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 19:06:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669792340"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="669792340"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 08 Nov 2022 19:06:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 19:06:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 19:06:49 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 19:06:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8dUqkMdgvtFr02ksSq62+RaeGMralYS5VNme9ekn43q9I0rHzTpKxm+rZUPpcwtyWgsyq8lBmO7pZVqYjHSJBXpK4y+ybwgADzM4kOanKQTWci1leN0dsrrI+5lfCeWL0ODYrUQTJ5nH6AjIWebjA5bDFX1XYjpfT1b7T7aatar5IcMim+7wFc+xgs5L/ttPVG6E7+nDoUG9fsv/u763sKGLt6Ae7mf6SUzM7Mor/ceCyga0iKfC69E9qUrEuTb5u3vBpn38oXd61Zvbks5H0JedxBGOQUznn+lolK4PrdsAGuLAwvZkYyxAe7g+oXSJtc5gk+KxRBGM7f0sveykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhkKRXAUOppGYMz3AgP/shsYwBZVl9xgnyn4MVNNPw4=;
 b=Iy+y+Irpwps3AfW/FjvG/p6CsoejuQEXMa9ZNI4oobSpwN2TjAeiy1dXrYxboEK86s4UAJdsa8pgrwxBNJ03PDbcXJwfByJPlfw7I8C19fR6tNp/7t/o0wDzhWQFJifa0qP+BUawX4ChcbzhuMQK6BowDabC9DrM9s6FAjistGUIKvG981GK0psYBCFzLr/3X+roy3pIepGfkaJQT9if/CVAdikSS/5tuH8DcIsX+/dTMv7L2RUe0/Fw5z+04pcoFIVNTurdGBXBdPHFQqs8VjBGhyuBE33GCKt4tUDLmwhjMkQkVFc3Jn9KHyL2G1ik5F60Y2mlpiCpzuhJcp8GZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CO6PR11MB5665.namprd11.prod.outlook.com (2603:10b6:5:354::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 03:06:44 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 03:06:44 +0000
Message-ID: <445aea20-5626-6d95-db90-ff086283272a@intel.com>
Date:   Tue, 8 Nov 2022 19:06:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 07/14] x86/microcode/intel: Use a reserved field for
 metasize
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-8-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221107225323.2733518-8-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0080.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::21) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CO6PR11MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 345c72f5-e2fc-42e3-f381-08dac1ff6e58
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdH4KqIoN8w3LmAxD1/AzYd98OH/0opY+yKu7URsmsUHTo6X6K6eFz9XD3dk6tCJpDxk0iW27320IptRMYh078zj3y7OJiAVSK78zV04llq036XSXvGFLZpOu6hwR3Ma811uTUBdnrIiFKDsPdwXFjZ8P7dWNPqn5LHDQ9Xn2EvsA264f1Xx/SgsG+E6pPlzqlhyZ0Y7q+jwxlp/OYu27kr/hn7xVlw+cp0YcOUHZS6EtcmLAnn4bf25JHpbH5peFIo25LFLLuffTTs3HDk0UnyHGG0yT8elQsOt8PFLvyo+G7BwS2gZFaJlfAfphj/zJzFALtr/QZXudjgjFv/9LTtGCEGWvSGD80DW61kHY/qJVzEl3aBLZBISPJ64nFDCOTYCxiUqBh8kE08o/r2ggb+T0ODLNKwCNqJPLTbdvwH0DSaNZot9ISymlpfhzwbQzLVrkDW4qyTr7IdNRVPiPOO4zjn7wnaSX9uDgXVyDMHnmqBzWzVLQvhzAndithg8+tpkdkpbW/nklxr1F6LlTWvSJ3yth5JmWXx5YHlIiUMT6sLZNZerbnwNEuNCQQoNm6TR7kCCuxJnVt2u2C/xXcmkdtg436OgCZKhkZ/or41a5Gh5HD6I5PMUzDw/cMitQkU6Ow7lQ98ibNvjTlTCjgTTvGsxUjIdnfKTL5ol2YaRglEF0gAAGokNUHexsrgPfM15+iZHTOcwtbOBwNaRmLuEHtSeLa4xB+jW4Yx9LXhu8TNtrJ/taNdO/I5I3VzQvgntXiFeluFCty2wHLrdnxKHWYaddXIv3t7DxFaZMss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199015)(478600001)(6486002)(44832011)(6512007)(2616005)(186003)(2906002)(82960400001)(36756003)(26005)(6506007)(4326008)(38100700002)(53546011)(8676002)(31686004)(316002)(66556008)(66946007)(66476007)(86362001)(31696002)(41300700001)(5660300002)(7416002)(8936002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3NFRXljWjRPR2FWNWVpM3lhc2lXdVNVN2RoZnY4d09pNnRvSlFSSW9jZHRp?=
 =?utf-8?B?b0dPSmg5eUh6L2RSdUNPN3E4SHJlQWdmakI5SFNzbXNOZTFrbGJvd3hvK0ta?=
 =?utf-8?B?ZDJlck0yQVJDNUI4d0w4WncrR2VjWXowRXpJelBMak1CTFg0TERBVUFxQXNU?=
 =?utf-8?B?OVk4NFczeUlzYUptZFBIQVZodVBzM21HNFFSMkpPa2VxTVhQSHBkenNNQkVp?=
 =?utf-8?B?RkJZZjE1L0YrK2xvVFJjUnBZSWlYR2NIY3Z0V3JTc1Q0SnM5eWhpZTc0dEx0?=
 =?utf-8?B?RE5XUHJnNkRWUUhHeGkzWFdISW5vaXdIRTBCZ2FETmxveW5hNFJJanhOcDUv?=
 =?utf-8?B?L1NhSXRTdGtxTW5mWnl0b3lHSWFBMTJ2SG5XWlcranBjWFVrK2dwOXhtakQ5?=
 =?utf-8?B?dHRhVW9VNkhBS0MxODRtTi9HZkdNbTNXVmtoTnBDMmM2YmlBNTBSK05ESFBQ?=
 =?utf-8?B?SmZXK3JSelBLWEZFT3Fhc0Y0RmxzRUFhK0o5Rm5KdEUxQmgrLzdWMVJhNnMy?=
 =?utf-8?B?Unp0QVZVSnhSNCs1Y0h2RVIrTWsyai9NRDJ2ZHdHV0cvU0ZyRHRiMXVsM1V2?=
 =?utf-8?B?M3gxOXVWQXRtWUdmeklHcXZtelJZaWFTNnMvMEFia2FqeEppNEU2Y2twRFAz?=
 =?utf-8?B?aEw2UzFFVjFPUEo1Z2QraDZQMDZuRnNHWVdrRkIxNDFENWF6K3gxb0J4amMy?=
 =?utf-8?B?UVZNYnM3d3FQOUpCUC8zNFgzUXY3VXdQSnRQY1kzYmVhUXdMcWhGclluN3ZK?=
 =?utf-8?B?U3QzQkkwOXczaTkveUdPcFFXeDlmL3UyZmJiOS9EVlhTUmJKbStuWmdVSys3?=
 =?utf-8?B?SmxGdExuMytsRThBZlRxcG5XTFNqakFBQWgzaW01REdXVUR3WUliM0FtaS96?=
 =?utf-8?B?TWpmWEc2cmIzYzExMnhuODJpWVJsTWhHb0I5ZXROUEw1d2E3bTZZNm5Gb0pz?=
 =?utf-8?B?YVh6bXlJL1hEUHN5WkRJbFdRN2xsQmJhbTRiQUJka3R4alA4YW5IZ1pzZUxo?=
 =?utf-8?B?KzgxUHkydHdETTF4OG81L25majYybVdLK25SZ1R2ZFYvZnM5OHBxMjZaakNt?=
 =?utf-8?B?aWtEUFhiSXR4L0FIbHREcWtaRHBpZDBhZE5Md0Z5Tytjb2ZaQ1hIZllOVlJh?=
 =?utf-8?B?QjQ1RWZMa2NNUTJDYUZjR2RSb3NicU9INjkvREFweHBEaExQamhSbjVJL2NC?=
 =?utf-8?B?ekJ1SFg5alV4bG0ySUk4TUFPbkxKMm5zaXpSQnZ5V0FXenVyK01RK1hsTytz?=
 =?utf-8?B?aE1HbGtaYmZjVFpaNlVVZnpyTElXbXNuejBlYkx2dDUrVExHRllKM2RBdS8z?=
 =?utf-8?B?SHVJZEZOUmZzeVJvVVRTYUYwZDd0SlMrcE9JdTRUemtvREd5Q3p2bDlOb2I2?=
 =?utf-8?B?YysrNVpqNkJhTkRQcEZNLzZ0TmpMdm9GZTRFMWFvOUV2SVNDbytoNlpGU2RP?=
 =?utf-8?B?a3JGU1U1RFdLQ1Vkc0w2YXZFQWtSSzRvYmNUZEoxM0JWejFiMTBlTGxNV3Jv?=
 =?utf-8?B?ZnB3djJDNTRBbi9nTHlKQmVWV3NQd01ZRjRWcW5Xek9MZmhDd2FOOGNtdmpa?=
 =?utf-8?B?U0F4R2dBRldOaElFMitRbTdjamJpcE5MMkxyRmhOVGVuZWZoOGNLUThFQ2E3?=
 =?utf-8?B?VFEzUklzQmJHakIzQkRtT0RzRUtGZmlZeXpONi9VYlVPZ2NjRXVISWg2RE82?=
 =?utf-8?B?TEgzVldQeFRIcWVKMEgySTU4dGdaajB3aDliTHJ3ZjNmOXo5dTJUbFVERkpt?=
 =?utf-8?B?TzZuRlcweERCRUF1eGczWW4razcwRUlGdEZjVXIvSEFaeHlsWG94c29jOFI2?=
 =?utf-8?B?R2ZDc2Q0T21xWHVKOXlYNHNiUHgxWlZEbS9OLzJSZkM5VXNIYkkyWlNUNFJR?=
 =?utf-8?B?aHdyVi9xYUJoaE9rNGc3a2ZPVWJyeUdjVVRwbENva3ZNYmNkdFg4VnUvVDBy?=
 =?utf-8?B?enJFaUVXWnRhb3dhUGgyUTdhSEdzZ2pFTTdXejZYNWE5M0RiRGVZSkx3MG5P?=
 =?utf-8?B?WFNZdnlCT1loVkZ6T2dQajhvUFpnNXc3ZmF6L0dueThSSU1ueHplREdYSDcv?=
 =?utf-8?B?MVJ1TnRVU0RTbmswb242WEZuc1lBZzlRVXlBYzUweGJmZkZoWG4xL3JzbkJY?=
 =?utf-8?B?QjBkS3g0b0VmNVZTY2ZQZnNpdlhHS0wxZnBLTUJFT2VtZjl3RlFGa3lYckhH?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 345c72f5-e2fc-42e3-f381-08dac1ff6e58
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 03:06:44.6302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBdwwU78ZQ7uGpPUoabobZ8bHJECyW4GGXCWGS3XqDkkXF/68vCIT3V1s/J3IlwdLOmZqxj+Kco/Ufg9r8coFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5665
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 2:53 PM, Jithu Joseph wrote:
> Intel is using microcode file format for IFS test images too.
> 
> IFS test images use one of the existing reserved fields in microcode
> header to indicate the size of the region in the file allocated for
> metadata structures.
> 
> In prepration for this, rename first of the existing reserved fields
> in microcode header to metasize. In subsequent patches IFS specific

Nit:
s/In subsequent patches/Upcoming

> code will make use of this field while parsing IFS images.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
