Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8386D2BA5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 01:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjCaXUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 19:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjCaXU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:20:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB73BDCA
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 16:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680304827; x=1711840827;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mChbIgbeMjqr8BfyE6YcU78sX0aRoYon4ZEgNB6lng4=;
  b=Vyq1kJkRXSiohouRLTaOE+oOKIGz1Cz9I6xUtc/3AUbExea+KWOgo6nW
   9Uq+XHrHXTG4z5LfIDdbsoPbfGT8bM4r8IW1/UK8uC2bNlw3KTbPgZ4zI
   5MRXalxcVsLzQkDLlL6fEHxaPDqUkB5F11TyWvm+WTN2vsSmVoUrPZHIE
   E7hyuoL5VRitlJM4CjqTelAwALXPuU2/NBJlRpgxukhbZBEPouaM7T3V5
   kX+5eNLK0c1YDsOH9rJG4nxKZEyXZA3eJOvUag4XqXE5uz/oqrsiPaBT/
   cQGMq/gBslSVRXCh/qKjA0TBhM72tywoWLgtV+XvpegDBUJwyQPhAlTpi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="330123756"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="330123756"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 16:20:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="774524383"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="774524383"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Mar 2023 16:20:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 16:20:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 16:20:24 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 16:20:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYdtBk45l1ViMi4kAEyjSKsGFdaNpvlrym7Qwple8zM82Krb1MmHSZHLOKR4vMUy/qtNIZqjZc1OBQsAmJeZKhL/64OE9QkVUM1yVMgIYgs2RDpNOfLRSD+IA4NJX2etauKkm80jeZwYRzqc4S3MfaM+rjhRBihpDEBcuRQ1R+cpdEZCTJ/mgRFAvkS6boaIhOAlMlnRO1dXh2q3qFq45UZlg44qvl80iOoOWyaTJpjMN2wbXea8TAKwyFKi+i7l7huq5fgs/CWJVCSCXl6OOT0ESDcFCM3LSwDWzbvYOjgBhBkYiXJNKOsDLDtZDoSzbBHwqtbbsYPCyMaYYL373Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWPC4HWbbBSP0f7En/nLhLTjcfOBeOYnJIsC+WNBmU0=;
 b=kTMUKrKHtNn2ZWZ8hU1h83vuyFEI9kOZ76oBO4S4KGjBa8MWu8OwMRXYZQrty2ASIzL7pZZySSBjweynf0fWNfL91DfHglNRUZylIsc1FxOVHrDWUDHdGHFIp91wE1GadOiIHdJDUFA11BGDktf9SWd6zp5NChUZcWb0DG36DtQYytOPUIjGSQFiUOrwMwc4VRV54fqXBBmw+QmWFd2I5isFgIHzYLml0P5dgqu07TBkvIiN/LOjSxsWHe/aYfLe3tZ+EP3Jd8rNSS4iyjwod8o4zeVPV0wQzicx51QoUzMV3ep7MeZ+YstPPr5+zmtR3gXQBCR9zExeSB+wrb/1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA0PR11MB4701.namprd11.prod.outlook.com (2603:10b6:806:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 23:20:17 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6254.024; Fri, 31 Mar
 2023 23:20:17 +0000
Message-ID: <88f23096-0f0b-c9db-9ab1-671341dc2eed@intel.com>
Date:   Fri, 31 Mar 2023 16:20:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v3 03/19] x86/resctrl: Create helper for RMID allocation
 and mondata dir creation
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>
References: <20230320172620.18254-1-james.morse@arm.com>
 <20230320172620.18254-4-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230320172620.18254-4-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:a03:255::24) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA0PR11MB4701:EE_
X-MS-Office365-Filtering-Correlation-Id: 802eb679-f777-41a2-dbe4-08db323e7cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtHrreI6JtW9QaaCPw+e2+f8Z8tcGQZxI/th23R5+LbHb3HN73XkbuBR6zoZqLCFfok9M4EkDDyV1EcP1hlUJXKh5ZvvRilaHvqxvAweaAuQcBYGy1KrisPIHNVR8Kt7Vzhlk+y2acZ2fRgWAmkKhAUpgjDrrMYY2KnEvAppg64Jt3YEBjGYiOc0z4PZ6Uy3gWlpT5Z9T3vd4oq3G51QKAPqL2GPn+/QUt1k7b/POY0smPPtoCCPp885kaXzn1AhC2hpMDV1jkwaUdAXJThhJCrBH+Uun7dZxtO33y60td6DmHIn+qzfBbW/QxVFP9SOygbPPInENeducwXDTaA4Ws4v8a2+JPfNiGtNEwuC95cC2tuNooh05X5JTP6nhuTAtlWe3ZykPSlq/T0APiYLWj5bgNpVOSwH4zgAplEVStrer4GdsVRffc+Rezom47iGFhV50yQVCeQtqDb3cuoHwoaRexDedqaJKGNqdK8+9cgMBylidF4ZT/kNPgqpxNoYajkiNabm+NufqX5fx+iJyHzDe03k5zNHDkE43CAvPUIZHYiat62QiNxX+ABRibRXkP4jrG+FSrF83iYwuqXSaDDuEtvrTZW1/+VU8PeIuRBUuRbgONP7P0J/aDWnp6BFXp/3SXDSURh7/exqju2HDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(36756003)(31696002)(31686004)(6486002)(6666004)(41300700001)(26005)(82960400001)(38100700002)(2616005)(186003)(6506007)(44832011)(86362001)(316002)(66556008)(6512007)(53546011)(478600001)(8936002)(54906003)(4744005)(7416002)(4326008)(66946007)(66476007)(5660300002)(8676002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGRvWGJOVzRrKzV5WmttMTA5K0c3cERUaDBxQ08zNVl0VUFBMTFnSmp1bjB0?=
 =?utf-8?B?ZWZyZU5GYzYrN0J0N2hQamE0aGN4VUh1WEhqOFk0cHQxUjFMYjZRQ1JwbTBJ?=
 =?utf-8?B?VnFPVWwydytJZnZmN3RMWUU1a1VoVVFkbmsrVG43QVk0QWUrazZ5S2w3bnhj?=
 =?utf-8?B?Q3o5OXhkMDJ3UXJDbkp4ejVDV2xaYnBqREJucytxc0liTTVXRzY2SE91eUd3?=
 =?utf-8?B?YzBObEs0YnV4QXEwaDZyUUJ5YmxuT0t2UnhKQ1VOamNOMjRmWlBpZmREQVRN?=
 =?utf-8?B?YXgwV2s3YmNhY0thbVIrSThFM2JuSTJhV25lU1FZZCtyS09vaFdOMERYd3lM?=
 =?utf-8?B?bGFOYllTTDBBU1A4MjlFcG9lQ2dMWkpob3pjT3NMSllsRTAwdXQ2MEpKTGdw?=
 =?utf-8?B?K1N2cDgrRG95SW5Eb0lQSHlSdzNWQlp5dUdMZEdPTlAxMG1kU0wvc1lEdVMw?=
 =?utf-8?B?Y0FLdEVwK3djZTZjdmNIb3pXSmRLalhsT2hqYy91VGloYUh4bzJkdm9PbXFH?=
 =?utf-8?B?M0U5bnVhRGswRFJUdGNYWEhjRGZIVWJUVVp3VUc5azdoZWVPcEFXVjc5S0tE?=
 =?utf-8?B?Q2VlTjJxRkw2bmt0clR6N1l0amFvWTNEUklTeEZXZEt0YnIwWU9TU1ZGb2Jm?=
 =?utf-8?B?UGVNMkRQbHJJQlFKWkNWd2RyTlZoV2VYV0tmbkQvc3o2VGszdEJXdG92Z1Nh?=
 =?utf-8?B?aUxhMUNrQXpKTkNUa3F0NmY3TVpNMHpYK2laVDVqZ1dxTFVYUHdTMFFTbUlB?=
 =?utf-8?B?MkVZeGNubU9MRncyTHN3b0hPbncvQlNYeExWUy9ZV01yLzBZK0JPYkFWOGdE?=
 =?utf-8?B?Tm95N2J3WHRuaHFWTElSNXcwcGJMZi8rMUU3UUd5dUs0alJwMUZvMXNXdFpn?=
 =?utf-8?B?V3RvVytHREI5ZTJNd3pFanN2bTd3cDFUd2tqRTE3eWYwRWwzUWxlRXdFQmVK?=
 =?utf-8?B?NjhDdGYzRFVmQ3kxTU03UGduc08rVnpaNVhCeDRKN252S3RCL3g4cnNZUm53?=
 =?utf-8?B?eEpmbEw0QkJpaTVVWlhVcnhlekVybGoySWJmZWlsOEF5VENPQ2VNYVIxU1VO?=
 =?utf-8?B?NmQwRFIzK29yNDZ6Zkpuc1RZOWlHQkxNb2Y5QVRFYjRYOTdYYm1qQWF6VU5H?=
 =?utf-8?B?V1NEY1BGWStQNEFPQlZDK1V4THRFNklNSXpkUktNL09pakFDdjh5c2hJamZj?=
 =?utf-8?B?RWxEOTNYTTJFQ1NwZENrbDNrUEVpdEc1S1VBN29ab3FQc0J6WWZ2L0RlYVVN?=
 =?utf-8?B?cEl0ZVJTU3I0TFR3RU9JY2VtVG5nbXpadk1ocWtFRHVabWdGN2ZhNGZnc3Bk?=
 =?utf-8?B?V3BmNExFelA3MlpSWU5MVTVoeXQ4dzF2amFxMDhLWjk5eDBrdThaV3gwZnJZ?=
 =?utf-8?B?bjNxQ3ZJMXBsd01idzE2QmwrRk5wQXhEWXZaaXRlZDJXSUdzWE9maFczaStt?=
 =?utf-8?B?WGZ0a09ITWtKdGVvS0FtckE0cnpsb2hCUktvUUZoNjZHZThkclVwUFBlbzg1?=
 =?utf-8?B?bkh2OVA4NmFoS0RmM0k2aUdhTkhqK3RwZVlnV3hTQzl2M3pZYlFlYVV5Y0Fo?=
 =?utf-8?B?WWxuTTEwZjlVVWtGRHU2SVlVdFk0aDNVRWhJZmFjUE12bDFaaXlucXVXeVR2?=
 =?utf-8?B?RTFNV1owTnNjN0pWVXhoVy9OQVo1ZWRqUFRCQzRvMUU1d1RGSDBxN3BRZ21I?=
 =?utf-8?B?TGpUY3BjbnNUeXZGeCthNlFUMUJPSDBmeVZTcmU4WjhndFVlSEhJck5DMkRZ?=
 =?utf-8?B?ZURPSVo3K0hucDhkQmVzamZVZ2VuYVV5ajdvZ1krV1FCRmo0bTNpUloyR2ZG?=
 =?utf-8?B?VVNac1ZDVVl4NHZKT1dEUWphZ2JIZkQvWjdGV1k3U3RGbTVUcFBnNWI0TnF5?=
 =?utf-8?B?MWZhRzZyV3NMTG9zQTNQVFJqTDVYZHlSa1Z5c0IwejZsb0tNeXhseTZLRjNH?=
 =?utf-8?B?bXdheXdDcTFhZkZHUndtelJjQ3hEWnkxMytNNUxNc1dSV3V6aVNpWlgzaWNj?=
 =?utf-8?B?MHFocFlSakhLeHR3ekVMOVljU2t3a1BRdk1xR3hDcDE2Ry9jL0JnajFXMEI5?=
 =?utf-8?B?b3pQcnJ1TUZJZ1B3dDQ4VjM4NGUwWUVEY0pQNnIyT0NkZDhFdUlFUndsY2Ux?=
 =?utf-8?B?bUhUcnRRS285bEIrY1orRDUyU2x6RzVkaDBUS1lUWmNjckRNWTFqWTZRZER2?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 802eb679-f777-41a2-dbe4-08db323e7cd3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 23:20:16.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRwyOwfuj4ucmFKpv8GCVd5RDgolfUz7u9TS9rlkIbhxqkUA6I0YQP0Aw1IhHdg16MFfqB3KYKgQTyJDevqq6MgSO1fO13DRSsqmSNooViA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/20/2023 10:26 AM, James Morse wrote:
> RMID are allocated for each monitor or control group directory, because

control groups do not always get an RMID, only if they are capable of
monitoring. How about "RMID are allocated for each monitor group and 
control group that is also capable of monitoring". Please feel free to
improve.

Reinette
