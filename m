Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAA867565C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjATOKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjATOKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:10:01 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A8BCE22;
        Fri, 20 Jan 2023 06:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674223795; x=1705759795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EjPFsP+GAOeQOyS8WBZFf4bAzsJP5xnkF6QOpQS6a8M=;
  b=edZTKdnnPheSddfbADYjjF0Cfp392G5CSkMXEMKx0DunGgG+3ZCLijyD
   mQ2926SVLl3gZI9X5HX+4qHm9If/tMJMZh+xj2LLkvnIksSt0Br8JG9e+
   70PwCO317JRx9CnIvEgizhD2ZEsksqs0zJ6mZn6W4vWfsIJzIz3lMxAA7
   DS5nS1qsGjlPeWr1XBq2ubkHN7VDEFGLRrUVE31q2DvHlXNx5pLcq8Gy4
   u2m1uDUCUGw5FlozkEXgV8QtZiqCckLhfJAV0+wuHLBj/tyfW99E2MnFP
   av7Fe93n+amUHAHDD0e41nsfp319l2GrGqmUqNJHB1bWqe7ZDF3RVGEnO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="313470963"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="313470963"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 06:09:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="610492333"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="610492333"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 20 Jan 2023 06:09:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 06:09:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 06:09:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 20 Jan 2023 06:09:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ckbv0N1hA1I+VqTGxX0zQR4mClVogfZJgNF0vRpbqlt14YqC5Beqt0OX2pk8VQdJuhcK5OdybaYtxRPWR5mstCIGZVzYOx67vi/5FTNgdUbYdubGOAeGbvddinnxfRIVyrPjljSuElBaCL+PsKWbSWuJOTUy8n7YB9qY9I4UzoaT1sRgSGqhA3CRKERxp+KMgE/UkA746HdvmbLKeKMlJn5IGsnjUkF568cxFuJ5b37N53ecqnKEHYdpUeQ1X5JIJfMhqnwIUDl1gBYKoI+/OsAXKL9J18QYmk38tE66HXi9i/7zqOoRwOFV/BAayUoZwVdEniwlo+8MEYYYA5AbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjPFsP+GAOeQOyS8WBZFf4bAzsJP5xnkF6QOpQS6a8M=;
 b=XpVw0e2I0oF1Mx9nGOdEArhwsk20mtyWFZjRuTiZLONf9U0Gr4kXOrdV9G1FRa1SkbbcQCnXVj//4AkldePXDrN95BE87Vx+2+aBeAPxNA3RV4qAhRc4oyrgF0gXvw8LEwm6a3+CdKQAz7n41OmXvnFtBUjN2FmBTTEkvIHsXD9YujXxmvMpFqS1a2Tm4ii8hE8p9cJ1D5BdCDl3T+8xnsDxGK4j4gpWZwLTHad9Qg5VAZC6h9HnqCqFxeMvIv4/CGKT1QshQcfU8NHA3UMx/uyaTW5woGQjiIHH8fImdkhX2WJHwq1cTkxFEs7zwjTGVD//JseqTCjKYVjKDm0SFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SA1PR11MB5947.namprd11.prod.outlook.com (2603:10b6:806:23b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Fri, 20 Jan
 2023 14:09:36 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%5]) with mapi id 15.20.5986.023; Fri, 20 Jan 2023
 14:09:36 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
Subject: Re: [PATCH 3/5] thermal/core: Remove unneeded mutex_destroy()
Thread-Topic: [PATCH 3/5] thermal/core: Remove unneeded mutex_destroy()
Thread-Index: AQHZK4F2zxpcXOgVoEO8JnggFxWh3a6lW9qAgAAeg4CAACzogIAACj4AgAAKNwCAAA2/AIAADluAgAAaXICAAAuZAIABXNkA
Date:   Fri, 20 Jan 2023 14:09:36 +0000
Message-ID: <356516181c0f7a6ed1e4e97aabe12d50c7a51bc4.camel@intel.com>
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
         <CAJZ5v0icp3nH+3-timEh2o8kxXpe4O2uMdJ8pSwe8fmY_OW4zA@mail.gmail.com>
         <54674d67-7be3-0abc-4252-e7f4158f56f2@linaro.org>
         <12134920.O9o76ZdvQC@kreacher>
In-Reply-To: <12134920.O9o76ZdvQC@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SA1PR11MB5947:EE_
x-ms-office365-filtering-correlation-id: b26024dd-19fc-4327-9952-08dafaeff63f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k5PXWxPRkBa0cytUQQgWNPHPWUT0seF5pVdnlPGNpEWermHOinKHdyKo52BggICfrI/wjYoaIlTZzK/4sYGbIqV7Yi1KaOHQ7kk7FmaF/8Fg49irLDhusOhxgO5oDfpPB0x8bVJpY87yxjlH9WzFGZLTPv2kKNCFTKIfm1OKHVCSqcBgzUkwhDrLV/xA2+d7JFEWDMiXL7gPGEd6FIOkIhd5NuAvidIRxRyjRw6Cy0Zi++gPSVFZb87hx9I9sQWYbN7CegZmWmM/SRTdVHZT4vILU0iRgN81GVm8t1KlSd6zMcTTn2xnNFt2r8ZZ831ekOe8b1TY7Hfh7c8UJPyr5XtxUlWspe2g4SRsqs+fWnUPqOH9fjtAZ5P06UTPrAkPxdJRi3+q+j1+OuKnq4y6Mzk92lefUCNZnyAQYEaILfnzt5qP3mq2VM0/+h8JD3iwkmonZyHg7X/hpyEgXrDG9L6ZqAeqjqDcl0ugYcu9LIDTmra02uhJmmGSXz2w8ioyNSEP8ceao6weXQgJx8IEUFkxW4nyG5iTlBOgmyrJylfA6xqbvVBxUgs519GHPVLI5EQK+kODhAByXapllLwB3PDhetPlr9f0j700iYeHbodNKEGiQ0D51K/SdP3d5VuX4pcE60SLd5pmLCXsl59vSrVP5jmSgL+SMRr8Hq8H7c4jj4FsnMyp1gQcpJXtBbd4ynCDNdvm+wDQ+3La/IVz8xovd3rai1Uxg2pTd6CX/h5DcJPQ2XExGFh2H4blP2MxGU0PTLLd7cN9X3S2nDd8V9FSMGD5Fc4gwJkUNpp0wpU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(38070700005)(6486002)(478600001)(6506007)(53546011)(71200400001)(2906002)(86362001)(84970400001)(54906003)(5660300002)(316002)(4326008)(82960400001)(122000001)(110136005)(2616005)(8936002)(64756008)(66556008)(66946007)(66476007)(91956017)(83380400001)(76116006)(66446008)(38100700002)(41300700001)(8676002)(6512007)(26005)(36756003)(186003)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEpTWTVkT0g5dU11VnVVVlJJYXVVWkRJZTBTTWNJR1JTdWxLbTg0K0JGSGR4?=
 =?utf-8?B?YWdtaW5vejdCRm5HMVRBUFF5cnhjT1NZT3BuKzNBS2lDT3p4b01raWJSWGVo?=
 =?utf-8?B?MkNhZGtKcVdzcFlIV3ludDhVYjA2RVkzOFA0dmFBY3hUQm5qeENIVmhQR0J3?=
 =?utf-8?B?UzJRQXRIQmNPdXNtWmR4MGJIc1hUdU9QelhGRGNiTUVJekZ1Rkd4SUxjRTZI?=
 =?utf-8?B?amJlSm0rTU54NGNtVEtjd0Jja1dkOFZ2SkVGdVArZi8xNTRoS243cU8zN3RF?=
 =?utf-8?B?emMyN3ZEUFVUZjBvdXlyNHVTUTV6OElOdTlwUEozRmdqaFpmTUJiTkdGTWM2?=
 =?utf-8?B?MEZXN3ladDNocmI1eFBjTUVGTlpOZ2t2Q1Z5cFVKUjJQcURaUWhZMEVDRE9j?=
 =?utf-8?B?SU9kMzVoSERwQ2lEKzNUbTlFYkNDSXZLZkY4R3BBUEdudjY1TnowY3J2ZURv?=
 =?utf-8?B?cXllekdwMTF6c3FnQm9zcmQ4K3VuSm05TitDbmZLY2ZSczNManpqaFFiNVpi?=
 =?utf-8?B?QVg4RlErdjZEenNqUkk1bnB0MVRQZGdySndYZjJzVCtNMXl0a04zMVY5SmxD?=
 =?utf-8?B?YWp5WERYaWdRUENHN3lEODhvYktSeWR6bWtCVkEvZVoxREZiZWF2YUxwZ2Uz?=
 =?utf-8?B?M2lvVW05UHg2aGRuazdUeGpSTERtblR5K0tDbWd1cnE1dFM4QjUyUW9JeWJO?=
 =?utf-8?B?ZmdnUnlSUCs3SUtFMnEzVHhGblhzeHNhaXZoTklUUHlJcGh0MVN0NWFWNzVt?=
 =?utf-8?B?eXliYm5sYVk1TzdJUTRoUWwvdlJ2VDR4VEdUYzVnaU9VejZhcnR3b0cvbTh0?=
 =?utf-8?B?UTNyU2VQOTVuMVRHSWdBc2ZHaGl1WGN0OVVDeGlqRXdvZWl4NWVnTFNMaFpY?=
 =?utf-8?B?ZUdYcFl5OUpCdDBxajl4akloUXN1dmZ5TmNtc0FUbWRzeWQ5bXFPTjZSVHpm?=
 =?utf-8?B?REdjQ3hTTWpldTVMbGdxWlIvamhKK0hUK2pmVTlUdHhuR25iNXhyc1FMeVRo?=
 =?utf-8?B?K3JTblZ4RkRDZ2owaE1yby9PbGw4L1UvS0NzM1kxNmtjcDJuT0dVdDdFc1hR?=
 =?utf-8?B?ejVHZVM4a203cXVESG12eC9LVk1Xa1g2cS9LeUd6Rlh5Qlo2QnRJTEk0dWxT?=
 =?utf-8?B?SUl0NlZXcXp5VDRCWGJ6TEZaUlJMNnVuMnBhQ2hyOUVvVWxFSWs3dGtUQmV5?=
 =?utf-8?B?QVRiZmhKb3RkdGhUdGJmalFYTENGTXpncWc2UGVkaHFZNEJLZzM0bGRpMDBs?=
 =?utf-8?B?ZFRJaXB1RmRPTG1OUVVDSUdGWC9GOXo3dExqVThvSklrYlZPdFMwNmtsUWFM?=
 =?utf-8?B?ZXFIbmdNcEdnOHJ6bnBRajRDa2JPK2prREtKVE9ValJSMm41dVJPNHo3ZDJi?=
 =?utf-8?B?ZzROUFdPUUhkSTN5ZFJTRjNLY25jRnN4cEN4a2J3dm90bUUvelhXUkdGRHN0?=
 =?utf-8?B?QzZhMzBKLzNWNDZoWTBtbVIyMGZDZlhGdE40YlNYaXRVYm94S1ZBTjA3dG9k?=
 =?utf-8?B?Ky9yanRjYmw1aHI1VFkwTnlEZnprS0srZjBNTFVyTDRBWjg1SkRodUY4eCty?=
 =?utf-8?B?NzlKaEUrc0FYMlBldlp3dzZGMzFxL3pwb2tqaGxTbEZnY2E2U3JpNzRNRC9O?=
 =?utf-8?B?b1VzbHltM2ppbCtPT3YxcUFTWTlFM09UT1NRakE0cC9BKzc0bGg0YnNXc0N2?=
 =?utf-8?B?RS9GblRyOVJCZ1Y3MzZvWDYrcy8xTndIUUREc3FSWTkzTmVzcjhMcWYyd3B4?=
 =?utf-8?B?bFdCalREYXZDRUc5eFF5aEZOYnpiTjRxbzNCOWdzc1FsMS9veXozV3l3elds?=
 =?utf-8?B?Q0xXVmJYUHRpbDhENFU5ejQ2ZnA2YXQ5aSttOHUxK2FrUWZ6WmpMUmhaVGVP?=
 =?utf-8?B?QzQzRVNhRGhvaUl5OFczVGVNcStjUlVyNkE4a0dzVUxHcWMyOEg0RDRhaG14?=
 =?utf-8?B?VjJZV1owdWF4VUYwM3NIMlZHNWJZaXh0blBSVXM2V0lLc1hTRFkybmJlVDg5?=
 =?utf-8?B?c1JJVWNYWlEvZEtGSzgza3NGSzUrcnEwaE1jL2dIWmlKczg4ZjBaUTlLbEt2?=
 =?utf-8?B?Qjhya0REQ1IrN0E0MGhYSHlZSUZYUy9PbDNBUkhTOGdVRjVjc1ExMmgxVEpr?=
 =?utf-8?B?TnhwWGtrMnpCODN1bDZDN2d2UXRCTmpPT0V3TXl5bkthZ3NtaUlzYzVVUHBv?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA5F932D464EA14C83DABE59B4A34DB0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26024dd-19fc-4327-9952-08dafaeff63f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 14:09:36.1525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erNQ1MeAZAkFk1PyeA95yZM6rKYS41YjCBOpPQycG+eW0SeACINZA3vXJ/WdF2TkTA7EDCJpvwKH/kS86LQAXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5947
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAxLTE5IGF0IDE4OjIxICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVGh1cnNkYXksIEphbnVhcnkgMTksIDIwMjMgNTozOToyOSBQTSBDRVQgRGFuaWVs
IExlemNhbm8gd3JvdGU6DQo+ID4gT24gMTkvMDEvMjAyMyAxNjowNSwgUmFmYWVsIEouIFd5c29j
a2kgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIEphbiAxOSwgMjAyMyBhdCAzOjEzIFBNIERhbmllbCBM
ZXpjYW5vDQo+ID4gPiA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4gd3JvdGU6DQo+ID4gPiA+
IE9uIDE5LzAxLzIwMjMgMTQ6MjQsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiA+ID4gPiA+
IE9uIFRodSwgSmFuIDE5LCAyMDIzIGF0IDE6NDggUE0gRGFuaWVsIExlemNhbm8NCj4gPiA+ID4g
PiA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4gd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiAxOS8w
MS8yMDIzIDEzOjExLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gT24g
VGh1LCBKYW4gMTksIDIwMjMgYXQgMTA6MzAgQU0gRGFuaWVsIExlemNhbm8NCj4gPiA+ID4gPiA+
ID4gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IE9u
IDE5LzAxLzIwMjMgMDg6NDEsIFpoYW5nLCBSdWkgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiBP
biBXZWQsIDIwMjMtMDEtMTggYXQgMjI6MTEgKzAxMDAsIERhbmllbCBMZXpjYW5vDQo+ID4gPiA+
ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gSWYgdGhlIHRoZXJtYWwgZnJh
bWV3b3JrIGZhaWxzIHRvIGluaXRpYWxpemUsIHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiBtdXRl
eCBjYW4gYmUgdXNlZA0KPiA+ID4gPiA+ID4gPiA+ID4gPiBieQ0KPiA+ID4gPiA+ID4gPiA+ID4g
PiB0aGUgZGlmZmVyZW50IGZ1bmN0aW9ucyByZWdpc3RlcmluZyBhIHRoZXJtYWwgem9uZQ0KPiA+
ID4gPiA+ID4gPiA+ID4gPiBhbnl3YXkuDQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
ID4gPiA+IEhtbSwgZXZlbiB3aXRoIG5vIGdvdmVybm9ycyBhbmQgdW5yZWdpc3RlcmVkIHRoZXJt
YWwNCj4gPiA+ID4gPiA+ID4gPiA+IHN5c2ZzIGNsYXNzPw0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiA+ID4gPiBJTU8sIHRoZXJtYWwgQVBJcyBmb3IgcmVnaXN0ZXJpbmcgYQ0KPiA+
ID4gPiA+ID4gPiA+ID4gdGhlcm1hbF96b25lL2Nvb2xpbmdfZGV2aWNlIHNob3VsZA0KPiA+ID4g
PiA+ID4gPiA+ID4geWllbGQgZWFybHkgaWYgdGhlcm1hbF9pbml0IGZhaWxzLg0KPiA+ID4gPiA+
ID4gPiA+ID4gRm9yIG90aGVyIEFQSXMgdGhhdCByZWxpZXMgb24gYSB2YWxpZA0KPiA+ID4gPiA+
ID4gPiA+ID4gdGhlcm1hbF96b25lX2RldmljZS90aGVybWFsX2Nvb2xpbmdfZGV2aWNlIHBvaW50
ZXIsDQo+ID4gPiA+ID4gPiA+ID4gPiBub3RoaW5nIG5lZWRzIHRvDQo+ID4gPiA+ID4gPiA+ID4g
PiBiZSBjaGFuZ2VkLg0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiB3aGF0
IGRvIHlvdSB0aGluaz8NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBJIHRoaW5r
IHlvdSBhcmUgcmlnaHQuDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gSXQgd291
bGQgYmUgbmljZSBpZiB3ZSBjYW4gY2hlY2sgaWYgdGhlIHRoZXJtYWwgY2xhc3MNCj4gPiA+ID4g
PiA+ID4gPiBpcyByZWdpc3RlcmVkIGFuZA0KPiA+ID4gPiA+ID4gPiA+IGJhaWwgb3V0IGlmIG5v
dC4gQnV0IHRoZXJlIGlzIG5vIGZ1bmN0aW9uIHRvIGNoZWNrIHRoYXQNCj4gPiA+ID4gPiA+ID4g
PiBBRkFJQ1MuDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gQWx0ZXJuYXRpdmVs
eSB3ZSBjYW4gY29udmVydCB0aGUgdGhlcm1hbCBjbGFzcyBzdGF0aWMNCj4gPiA+ID4gPiA+ID4g
PiBzdHJ1Y3R1cmUgdG8gYQ0KPiA+ID4gPiA+ID4gPiA+IHBvaW50ZXIgYW5kIHNldCBpdCB0byBO
VUxMIGluIGNhc2Ugb2YgZXJyb3IgaW4NCj4gPiA+ID4gPiA+ID4gPiB0aGVybWFsX2luaXQoKSA/
DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBJdCBkb2Vzbid0IG1hdHRlciBpZiB0aGlz
IGlzIGEgTlVMTCBwb2ludGVyIG9yIGEgc3RhdGljDQo+ID4gPiA+ID4gPiA+IG9iamVjdCB0aGF0
J3MNCj4gPiA+ID4gPiA+ID4gY2xlYXJseSBtYXJrZWQgYXMgdW51c2VkLg0KPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiBXaXRob3V0IGludHJvZHVjaW5nIGFub3RoZXIgZ2xvYmFsIHZhcmlhYmxl
LCBpcyBpdCBwb3NzaWJsZQ0KPiA+ID4gPiA+ID4gdG8ga25vdyBpZg0KPiA+ID4gPiA+ID4gdGhl
IGNsYXNzIGlzIHVzZWQgb3Igbm90ID8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJZiB0aGVybWFs
X2NsYXNzLnAgaXMgY2xlYXJlZCB0byBOVUxMIG9uIGNsYXNzX3JlZ2lzdGVyKCkNCj4gPiA+ID4g
PiBmYWlsdXJlcyBpbg0KPiA+ID4gPiA+IHRoZXJtYWxfaW5pdCgpICh1bmZvcnR1bmF0ZWx5LCB0
aGUgZHJpdmVyIGNvcmUgZG9lc24ndCBkbw0KPiA+ID4gPiA+IHRoYXQsIGJ1dA0KPiA+ID4gPiA+
IG1heWJlIGl0IHNob3VsZCAtIGxldCBtZSBjdXQgYSBwYXRjaCBmb3IgdGhhdCksIHRoZW4gaXQg
Y2FuDQo+ID4gPiA+ID4gYmUgdXNlZA0KPiA+ID4gPiA+IGZvciB0aGF0Lg0KPiA+ID4gPiANCj4g
PiA+ID4gSXQgc2hvdWxkIGJlIGluIGNsYXNzX3VucmVnaXN0ZXIoKSB0b28sIHJpZ2h0ID8NCj4g
PiA+ID4gDQo+ID4gPiA+IEFuZCBpcyBpdCBwb3NzaWJsZSB0byBhZGQgYSBjbGFzc19pc19yZWdp
c3RlcmVkKCkgPyBpbiBvcmRlciB0bw0KPiA+ID4gPiBwcmV2ZW50DQo+ID4gPiA+IGFjY2Vzc2lu
ZyBjbGFzcyBzdHJ1Y3R1cmUgaW50ZXJuYWxzID8NCj4gPiA+IA0KPiA+ID4gSSBzdXBwb3NlIHNv
Lg0KPiA+ID4gDQo+ID4gPiBBbmQgd2UnZCBsaWtlIGl0IHRvIGJlIHVzZWQgc29tZSBwbGFjZXMg
bGlrZQ0KPiA+ID4gdGhlcm1hbF96b25lX2RldmljZV9yZWdpc3Rlcl93aXRoX3RyaXBzKCksIHdv
dWxkbid0IHdlPw0KPiA+IA0KPiA+IFllcywgaW4gdGhlcm1hbF96b25lX2RldmljZV9yZWdpc3Rl
cl93aXRoX3RyaXBzKCkgYW5kIA0KPiA+IHRoZXJtYWxfY29vbGluZ19kZXZpY2VfcmVnaXN0ZXIo
KS4NCj4gDQo+IFNvbWV0aGluZyBsaWtlIHRoZSBwYXRjaCBiZWxvdyBJIHRoaW5rLCBiZWNhdXNl
DQo+IHRoZXJtYWxfY29vbGluZ19kZXZpY2VfcmVnaXN0ZXIoKQ0KPiBpcyBhIHdyYXBwZXIgYXJv
dW5kIHRoZXJtYWxfem9uZV9kZXZpY2VfcmVnaXN0ZXJfd2l0aF90cmlwcygpLg0KPiANCg0KdGhl
cm1hbF96b25lX2RldmljZV9yZWdpc3RlcigpIGlzIGEgd3JhcHBlciBhcm91bmQNCnRoZXJtYWxf
em9uZV9kZXZpY2VfcmVnaXN0ZXJfd2l0aF90cmlwcygpLCBidXQNCnRoZXJtYWxfY29vbGluZ19k
ZXZpY2VfcmVnaXN0ZXIoKSBpcyBub3QuIDopDQoNCnRoZXJtYWxfY29vbGluZ19kZXZpY2VfcmVn
aXN0ZXIoKSByZWdpc3RlcnMgYSBjb29saW5nIGRldmljZSB0byB0aGVybWFsDQpjbGFzcyBzbyB0
aGUgY2xhc3NfaXNfcmVnaXN0ZXJlZCgpIGNoZWNrIGlzIHN0aWxsIG5lZWRlZC4NCg0KdGhhbmtz
LA0KcnVpDQoNCj4gSXQgbmVlZHMgdG8gYmUgc3BsaXQgaW50byAyIGluZGl2aWR1YWwgcGF0Y2hl
cy4NCj4gDQo+IC0tLQ0KPiAgZHJpdmVycy9iYXNlL2NsYXNzLmMgICAgICAgICAgIHwgICAxNiAr
KysrKysrKysrKy0tLS0tDQo+ICBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgfCAgICAz
ICsrKw0KPiAgaW5jbHVkZS9saW51eC9kZXZpY2UvY2xhc3MuaCAgIHwgICAgNSArKysrKw0KPiAg
MyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4g
SW5kZXg6IGxpbnV4LXBtL2luY2x1ZGUvbGludXgvZGV2aWNlL2NsYXNzLmgNCj4gPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KPiAtLS0gbGludXgtcG0ub3JpZy9pbmNsdWRlL2xpbnV4L2RldmljZS9jbGFzcy5oDQo+ICsr
KyBsaW51eC1wbS9pbmNsdWRlL2xpbnV4L2RldmljZS9jbGFzcy5oDQo+IEBAIC04Miw2ICs4Miwx
MSBAQCBzdHJ1Y3QgY2xhc3NfZGV2X2l0ZXIgew0KPiAgCWNvbnN0IHN0cnVjdCBkZXZpY2VfdHlw
ZQkqdHlwZTsNCj4gIH07DQo+ICANCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBjbGFzc19pc19yZWdp
c3RlcmVkKHN0cnVjdCBjbGFzcyAqY2xhc3MpDQo+ICt7DQo+ICsJcmV0dXJuICEhY2xhc3MtPnA7
DQo+ICt9DQo+ICsNCj4gIGV4dGVybiBzdHJ1Y3Qga29iamVjdCAqc3lzZnNfZGV2X2Jsb2NrX2tv
Ymo7DQo+ICBleHRlcm4gc3RydWN0IGtvYmplY3QgKnN5c2ZzX2Rldl9jaGFyX2tvYmo7DQo+ICBl
eHRlcm4gaW50IF9fbXVzdF9jaGVjayBfX2NsYXNzX3JlZ2lzdGVyKHN0cnVjdCBjbGFzcyAqY2xh
c3MsDQo+IEluZGV4OiBsaW51eC1wbS9kcml2ZXJzL2Jhc2UvY2xhc3MuYw0KPiA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
DQo+IC0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvYmFzZS9jbGFzcy5jDQo+ICsrKyBsaW51eC1w
bS9kcml2ZXJzL2Jhc2UvY2xhc3MuYw0KPiBAQCAtNTMsNiArNTMsOCBAQCBzdGF0aWMgdm9pZCBj
bGFzc19yZWxlYXNlKHN0cnVjdCBrb2JqZWN0DQo+ICANCj4gIAlwcl9kZWJ1ZygiY2xhc3MgJyVz
JzogcmVsZWFzZS5cbiIsIGNsYXNzLT5uYW1lKTsNCj4gIA0KPiArCWNsYXNzLT5wID0gTlVMTDsN
Cj4gKw0KPiAgCWlmIChjbGFzcy0+Y2xhc3NfcmVsZWFzZSkNCj4gIAkJY2xhc3MtPmNsYXNzX3Jl
bGVhc2UoY2xhc3MpOw0KPiAgCWVsc2UNCj4gQEAgLTE4NiwxNyArMTg4LDIxIEBAIGludCBfX2Ns
YXNzX3JlZ2lzdGVyKHN0cnVjdCBjbGFzcyAqY2xzLA0KPiAgCWNscy0+cCA9IGNwOw0KPiAgDQo+
ICAJZXJyb3IgPSBrc2V0X3JlZ2lzdGVyKCZjcC0+c3Vic3lzKTsNCj4gLQlpZiAoZXJyb3IpIHsN
Cj4gLQkJa2ZyZWUoY3ApOw0KPiAtCQlyZXR1cm4gZXJyb3I7DQo+IC0JfQ0KPiArCWlmIChlcnJv
cikNCj4gKwkJZ290byBlcnJfb3V0Ow0KPiArDQo+ICAJZXJyb3IgPSBjbGFzc19hZGRfZ3JvdXBz
KGNsYXNzX2dldChjbHMpLCBjbHMtPmNsYXNzX2dyb3Vwcyk7DQo+ICAJY2xhc3NfcHV0KGNscyk7
DQo+ICAJaWYgKGVycm9yKSB7DQo+ICAJCWtvYmplY3RfZGVsKCZjcC0+c3Vic3lzLmtvYmopOw0K
PiAgCQlrZnJlZV9jb25zdChjcC0+c3Vic3lzLmtvYmoubmFtZSk7DQo+IC0JCWtmcmVlKGNwKTsN
Cj4gKwkJZ290byBlcnJfb3V0Ow0KPiAgCX0NCj4gKwlyZXR1cm4gMDsNCj4gKw0KPiArZXJyX291
dDoNCj4gKwljbHMtPnAgPSBOVUxMOw0KPiArCWtmcmVlKGNwKTsNCj4gIAlyZXR1cm4gZXJyb3I7
DQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MX0dQTChfX2NsYXNzX3JlZ2lzdGVyKTsNCj4gSW5kZXg6
IGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+
IC0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiArKysg
bGludXgtcG0vZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+IEBAIC0xMzQyLDYgKzEz
NDIsOSBAQCB0aGVybWFsX3pvbmVfZGV2aWNlX3JlZ2lzdGVyX3dpdGhfdHJpcHMoDQo+ICAJaWYg
KG51bV90cmlwcyA+IDAgJiYgKCFvcHMtPmdldF90cmlwX3R5cGUgfHwgIW9wcy0NCj4gPmdldF90
cmlwX3RlbXApICYmICF0cmlwcykNCj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ICAN
Cj4gKwlpZiAoIWNsYXNzX2lzX3JlZ2lzdGVyZWQoJnRoZXJtYWxfY2xhc3MpKQ0KPiArCQlyZXR1
cm4gRVJSX1BUUigtRU5PREVWKTsNCj4gKw0KPiAgCXR6ID0ga3phbGxvYyhzaXplb2YoKnR6KSwg
R0ZQX0tFUk5FTCk7DQo+ICAJaWYgKCF0eikNCj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7
DQo+IA0KPiANCj4gDQo=
