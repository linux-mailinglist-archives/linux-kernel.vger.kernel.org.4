Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FA462221E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 03:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKICrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 21:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKICrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 21:47:21 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995C712AF2;
        Tue,  8 Nov 2022 18:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667962040; x=1699498040;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pu/BlM3HUzRXza7V1Yky5JmlEMVkkAQ/36kliDBhP2o=;
  b=aG3Con6umDxPXtnFGAIMpE6U+I+Z7VX4iyI68L1OedSRSsWmAO4yrczU
   snuRUVxBs5AU9BB3xHb7T+nj1yMoi6W7DvT/s884jV5+MG46u1bytU+4Z
   q/8mktxghGKqMl61/IwMMLafqiDaNemQjoX68Czh5OAbEeeqP90jlEhE5
   gzWRrQ/iSI8Z+2UomXeneUoUmoLADAGkN/DZW1TgfRDi7n2dig26RgeiU
   XD6wAYhso/MBe4TqfAUE2YxPGLMhI4cfD0XUzbJ0sDDew0aDfrzkgycOm
   961bIS3Z1Byq2lPK2TsSiOtlEz4zLgFlKgEHOcLab7CJ8i7u+FuyG1Mwy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="298390181"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="298390181"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 18:47:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="881752938"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="881752938"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 08 Nov 2022 18:47:19 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 18:47:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 18:47:18 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 18:47:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3wuGwZ8/WnjQd7Gi62YE4jgFqkZt5KKcbOafxR9kWHau9Wc6LY1ESnR5+zBUVInuLkqYsRzKPSNFxqDAEUksik0QWMGF3blt266PKFd04RN6Seci/oKLmSyBazRPFEUwOj48YGOWQ5+Guxip9eZc2qV74SdTvL18Yu/vCSyNiPnESpf3TF9qBROHubZ7Ij7Tj+XPMRA+2v6ZYyg2l6hy3zKu5Kvayb3W4VnRU49y1PlpFVhCpieEf5VhR/vCjWJ3WeXGByQCvNVeLVYTDn/L96xJuItFOBzdRReyZr2tK0QxXqkV0FmrDNA3buB3vU6jwTTdM93dyarYp6xwh+3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJwis1WiGqZ0KQtSY5a6tbhRqRveGtxvgJ6PTQyYhS0=;
 b=OSP/mZixRxT/fYXSomIYoNTHKY4xYAQk9BL2TOg8VXy7mHGxIp/hYhR5vV2fDtJPWT9c8/3ylQ+LRiBlNf/CIo6ML1/hQvCMAaktRcCts6k8++zrr+pw9lb1XDJI58mVSS+uPdRuqodbrHCqRSQlQhioOdCkRBJEXvUQRE4SBDrZsOuMFPfAe+QMbgePOJLi76x0iP9/GQyG1GofQUwffc1mVzru9U9hMLciSxWH3dv4AqbTStFiqYaJWroV/7U+Y3XNd/qsMxah+mfs99+k+rJDvR5sWq+lWzndsx4mdTIqaZ+NbcaEAO0Pfbiydw3hn05IZjQal9IFAGnsgjKe9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CH0PR11MB5380.namprd11.prod.outlook.com (2603:10b6:610:bb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Wed, 9 Nov
 2022 02:47:16 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 02:47:16 +0000
Message-ID: <9087e6be-733e-8f35-3ff8-a4c7f53ec4ce@intel.com>
Date:   Tue, 8 Nov 2022 18:47:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 05/14] x86/microcode/intel: Use appropriate type in
 microcode_sanity_check()
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
 <20221107225323.2733518-6-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221107225323.2733518-6-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::22) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CH0PR11MB5380:EE_
X-MS-Office365-Filtering-Correlation-Id: 9000638b-775c-4e29-13b4-08dac1fcb66c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+QogUHg1ZNj2gYrAbyAYZxBoOsgVLdrkvgSLCjgEPmqFQNWFcidcy4CCPFTiWOXzcLI4XQOoMYPZL9uilVA4+CiZ4LdaxzfCppOF7pphQmB8hGXuy9fcb8V22RN7gVG8S+qbLnsRT9MwFPQ2u9H/O/bA4HwpL4ZJPY0czuF7RMV1+BvwZrELbZxXSqCLdoRvVp4yIE5iUJao5h5VCNwOv05J0qkco6ZTUcmo5gdtIKAsqR1vHGi302qn2wEH8cNtbOYDinaVsBAN6uZK5W5Kj12qSreCmqI2vVXHthTshRfmtmLFMmHdvqL54hy/fwlYy3FQ9FcURYFHa37/pIUVmyCsdw7vj1w8WJDDlRdsD9jvZRfTssMG9e2/TBiZ12JYU2PJos9ax36w8Zdm1hJSnfyu2hSwuW9apdQYjwKXLQPJOdBLq9FiSY6AMBMUckh/jfWknjPkOw3wpf6tEn1chhO94Ul8T68nlt52S39rxlab6zFJs4/aMUoqAF80HXlvj4tq2QTQN2zjwTvkocFiM2tA7q+xUq/SSOB7/tinxWpDivV+zvtxIvKIz0cS1PVaaDXVAL6G/vsxNhTSofM1l9qEdCb5hazHyMWoNGo6QR5h7GpVmmgZLsYtKXitFPdpiW9PFhf7rjmGmZ/3EKhwLkFxEjo4/ZyxLfUNuUCxLHbLJzmatMzI4ZCQZ4s4ohO47DPkb3agN47HBLTciKK8vE+8NHfqAvuQ2ip7p9NqphqsfZr70sqBJAaQ7khnyqgYQ5e+b4T8KnR5cUNpsl0oK5arRTtsdbSROwAw17OjMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199015)(31686004)(82960400001)(4744005)(44832011)(2906002)(478600001)(4326008)(7416002)(66476007)(66556008)(66946007)(38100700002)(5660300002)(316002)(6512007)(8676002)(36756003)(31696002)(41300700001)(86362001)(8936002)(2616005)(6506007)(186003)(26005)(53546011)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0JDYU95MHh2bGZyNUkrTlpuMGljb3JmZkQrOFlNMmpBemgrbVNZejJiU0Vn?=
 =?utf-8?B?QlM2ZWs3OXpEVzZNbld6cTFnQ3pYSi9yQ21GNk4yUGhTWnc5QnA3ZkFETXhB?=
 =?utf-8?B?QVp0MmFld0RJQmN0RDFrL2NrOTNJWWlLaFRQNmp2dHp4V0xOT3VOMHNQVjE0?=
 =?utf-8?B?d3JRa2Y0TkhPM3FoZis1L2s1TDdBckpWbnpSRVdIQnkzM1lXTDdjT1hwRFRS?=
 =?utf-8?B?RzJDUHBvMW1tUS9sUmVDZFF0NDR6T0Rzb2pTTmF3WHZNb1FHOGh3cWtIVWdp?=
 =?utf-8?B?dTlWWXE3MjREQ05WZDBHcGtVQ3ovK2N2QXp2VUlHM2RkNGdmZTJLaDlzQSt6?=
 =?utf-8?B?VklIR0NscEpqRllLUlphcDUzdEpUczNiNVU1UHRROW5SVHMrblI1alhhYVVt?=
 =?utf-8?B?NFhDaGdrVUViQnhPWCtuc0FqMElDb2hQbFpqN0FROUg1dzJDN1Q1SXhyZXFi?=
 =?utf-8?B?dFMwMmttZVhEWDg0WVRocnM0T0dFMWRmV2h2eEpoMEp3eS9QM2tGdXVySVhR?=
 =?utf-8?B?YmVpNGZTWW1zU3dNR2xleW1IS1U0QmFtQ3hZck9MUmdxUGNDNkw4RHg5eUpE?=
 =?utf-8?B?UWpKbGZxT2RlSXpQdkZPTVQ5TTVWelU4QXd5TE1vaERUelB2UWpwTU8ya0lX?=
 =?utf-8?B?YTVNbnY5eEw1RXB4NjljM0RCWU1BVFJtQS80dnpmNEU0OEhMWmRnb0ZENEJt?=
 =?utf-8?B?MXNIeWlNUm54K2M1Nkc5VjVuVzhPekdqaXMvM2h1V0lhMEY2OEhsMDRxSG90?=
 =?utf-8?B?TzAxZTFnelJvT3J2NTFlZFl2aDkxSTFzL1FXMmRwOFNXeE9ocWxIcDhpS2JF?=
 =?utf-8?B?TU5rTk9SYjBsN1hiTHJhWHdpTTNsNWhOSkpEZDNGWTRHdDFTcENHUU5WRFFp?=
 =?utf-8?B?eHdqWEVKdEQ3eTNsY1lLNFFiQUpDUUloUVNTc3RpMndkYXNZeWh4NnFwalk4?=
 =?utf-8?B?VlFsV01laGZOMHU0dC9KTVNHcFdJQUV1aEpwTlUxK25tVjhZMmdkOUQ5S3Jy?=
 =?utf-8?B?bDB4MEd0S1lUYkhjSnBBYjNualBBMUh5aXVxb0x5cUtyalE2bGxHeWo1ckJV?=
 =?utf-8?B?V29Ya2lFQnA3S3U1cXB6VTVBcCtWSmsrNWx1MDc4UHRmdnRvMjdMNnVSTm54?=
 =?utf-8?B?M2tLM3hDNXJ6R0NhSnFxdjhBUmtKMWdXQ3dDU240cHU2d05uS1VhZU1iZHI4?=
 =?utf-8?B?THFvZFR0SmtDUGRMc3pJaEw0UmlTYjNQZGk2L1pDRVRQay9YT0xFMjB1VjVY?=
 =?utf-8?B?U3BlWWRscUE2Y3FxZ3YwZnNsOUJrMkx0ajhURE5ZdEwvNHRzSEVDcEVyVUJv?=
 =?utf-8?B?a2R2aXVjMFRJVlg5a2tQWnh6L1BPTlFXaHVic1NIbXdWVm4xeEtoSy9qQXRu?=
 =?utf-8?B?MytVL2gvVmhINGJyR0ozTlVzamVZZzcxUHBld2VCVlhtbEE4amZpV2ZmenF1?=
 =?utf-8?B?REFyakJ0dlNuZVRtWFdJd1Q0eXh2S2VBcmVuNkM2TWFYbm4yRTVyZ3dodTNQ?=
 =?utf-8?B?bXNMWTVCMndwejU0UFVvY2lPbmVLUi9XaklNWldES0p1ait1M1ZXdGxPWm1q?=
 =?utf-8?B?OWVIVTlXMDdBZHZ5Qm1CNVJSOU1nakJBOU1ENHNJRGpwUUl5cXRYK0pSNElJ?=
 =?utf-8?B?ekJ4UlNJdEZyRnJmbXFSMmdMY3RrbHMzNkJML3I4a3NqeVFRdWJiM0xaSGp6?=
 =?utf-8?B?Y1hFOXovYVg5dVpwUmJUNnBQMHpSRnFnSTFybis2NGkxQjZnZlNscFVWaEtO?=
 =?utf-8?B?eVlWVzh5dUtMVmhja1FnWGxWT3VUTXBmMlk0ZGlCQjFYUGtCWjJzZ1R0SGhw?=
 =?utf-8?B?dkMwN3J6Rm13Q2NTNXZoL0ZqSHBOUlhNeWdYTE5CVmRKRGVScmdCRnEzdk94?=
 =?utf-8?B?U1ZTWVNKUW5SWWJ2RUJtM3NrRG9yZGIzNUZ1amxBNit5L2JpODdVaUNOclc0?=
 =?utf-8?B?OEJVemc3dkE1RG5uMWZ5OGg4N0drUXRoQlBCQTBjRnlLVzNzcTNIeWEyUGh5?=
 =?utf-8?B?QzVnVWtJeThIQzlLMU9uV3QyL0VMZDJUVis2aGFOeFlick9rbkFVWE9QMkR6?=
 =?utf-8?B?bnIvVFpYdXRWVXdZUk1pS3RyY1lhZE45RVhpM2NLWEZzQm9zdzAwVjFUSy9y?=
 =?utf-8?B?dVZHQjZiang1WUlEMktFWkZFR01PQUwrOUtaaG9zc25jSU11YVRldU9PU0Fs?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9000638b-775c-4e29-13b4-08dac1fcb66c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 02:47:16.4364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8o1MvOWhzsemS6zUbLicqO/SalL8FXBunE9+5kabNV0vtq6c3IQPwYDH8J3wlbJMq15A7vXwMdImutf8iWmLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5380
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 2:53 PM, Jithu Joseph wrote:
> The data type of print_err parameter used by microcode_sanity_check()
> is int. In prepration for exporting this function, to be used by
> the IFS driver, Convert it to a more appropriate bool type for readability.
> 
> No functional change intended.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
