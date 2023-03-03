Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F326AA577
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 00:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjCCXRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 18:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCXRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:17:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEB464AB9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 15:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677885429; x=1709421429;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4FvzIP0ozdMn7MRVIVbNvPFzpWPVJf0tJemdv+zWECA=;
  b=FsLw0+l3nHVVs7eCa+CDm+3cdnwpG8abo8KTv1GYW+FoxX+gA9pMUg8L
   Q/svbYAUqCSAGhTaDdEBDgsPA4K1RYS0M1kGQqpZeHoztlr5VNEtke2SN
   +/4erxpzTyHM6xkYQs27q16ZGjAWo0kN8yAvSqBtVKvyGyJYkAZxlDCBJ
   W341kzLEWwUo+pjbK3JtQC5CpVpxKYOWrIRDcQb9rI9+6RE2x8WHCVTzO
   D3vh1OeIl6h42WupPz4KdxQjeWGqGpmZvGdk93NQHrSbHtZJH7rOx++4u
   UweWny/AgFIahM+WdqLq9cTNZPaHoNtrftTVszXeguXF5ssH8JYEtsN39
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="399997278"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="399997278"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 15:17:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="625519537"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="625519537"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 03 Mar 2023 15:17:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 15:17:08 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 3 Mar 2023 15:17:08 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 3 Mar 2023 15:17:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMYqC4h2x4Mm+c9My1WkUyYraUJK96ZYRxQ+O5OpJo+tv8Qbtrzd+GXwmysYH4rDO0J27TcTNqG1xbrInFkg0YiSrSITGgXfWTvA+RubztkNK8ny4RozqM2ssPVnPGL0PXKZMweDMuKOuMCVzfislL2jr90op9/vdGqFWmJt9satpCvMIWhqyrI2mAwrVkNB3Fc7kkOWfvhvv1nn2+3AQT40+NeHkOB5oHtfGdA3WyhQVSOXsRUYzVCUOF3cGn4nSArh3pqs91zzlXU6yJ7HHBUj1GIVouYJPYWkIOrWSXJSKwqUfpb4Gn3FtB990TbQNlD/MQ6J24tK5Xw7bN8ZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FvzIP0ozdMn7MRVIVbNvPFzpWPVJf0tJemdv+zWECA=;
 b=fp/V8Z+26fNYRSJ1g9EdQc8Pqz+mPFlnWzenafIabxURCbMgxaQy+pU38GEHvPBBuwEUwFRDYhNBd6UUd4F6dTwHZ7uhHDUdVt6XTjVXwOc0Bf6596lg94XomxN75ILKDBgAIbcNDbv9o8CmB24mVB24rs+8nbl5w2Xv9vX3/b8at7NxYOTv5nHL/0+20AcuHNZHi58DxU+UknhhTmks6oKN7Eq0VoPEACDeE5oK19m0qDjmG6HqsZimRxu8Rh51JMba86bM93ut/LW9883iTnboN0dgkfGzMf+lMOu+nak3abyVCUPEi5QS2ldAKOAwAtPw8Nl8IZo+XGsaU18tow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 23:17:06 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%8]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 23:17:05 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "bp@suse.de" <bp@suse.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>
Subject: RE: [PATCH] x86/resctrl: avoid compiler optimization in
 __resctrl_sched_in
Thread-Topic: [PATCH] x86/resctrl: avoid compiler optimization in
 __resctrl_sched_in
Thread-Index: AQHZTiWcwVo9jaQOt0u1ztY/yRpe/a7pr+UQ
Date:   Fri, 3 Mar 2023 23:17:05 +0000
Message-ID: <SJ1PR11MB60837CEFBDEF107FD162724FFCB39@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230303231133.1486085-1-eranian@google.com>
In-Reply-To: <20230303231133.1486085-1-eranian@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB4769:EE_
x-ms-office365-filtering-correlation-id: 0549178d-05bc-4c01-a854-08db1c3d6769
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RGFAmk8AqtFs2MeheTmesBz/J6IcTicMifFoz3KQv9AmcjoJN3QDQNUjvLLesm9xE3wczb5pu3iluJqWgaLFZ0W/XesR2ccLglfiAPk5AUCw5lUEl4/sqCRpmuLlZzlTHAVnBvD3Asi+PELkbKJesxCub48DPzEGE9HcXHBFB8N6upi6yUNgRFfYw3xk4ByGrSqDttR7mjQsYlitSaRjHGOADiy1DhJoiamDE014UxjF4xfwKMsEjt/VOSbnKRW/Pkn240xUCFJfeq/EPJJz2W6KO//Ou7sph4ckysS8gmvtIzmRycyTMGhm14Kp7jXRBYw9mtHPG0iqJ08XirbUriBxs/9ABsvfuEyW+Fza8PNiOFVMlSYplM5Si/kxyPE5EIXqMAUVaeKFS9MT4pvuJ37Ez0fzWuQ5f+ngQwao5aJ8T0BOs+n9qHvpbx9hE7OgJ6oHz9jjty72K8MU1js1+XDeUVGcIm+csAdH6P5BjGh/qiWdE0g6G+cqYkvCHh99e0ou9xSsDv/OH+cN4kZbEziqbhlIH+8klXvWKtH9MwwktgnmHmFu1DBvt4ogpBWDbhI/2Wx9JxgUuwq06uxBTvUWWnH0CPe/LnxyqZO8nVN6LgfLonIKKrIYoDeFpKlK7XfYGoFTF17My6FB2rxknDfmx3kxSA+ts0dAIEAqM6b3mQGdbG/HD9wvz287A/oF6O+kJSBlWzyO9mqWT2oKtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199018)(2906002)(82960400001)(122000001)(4744005)(5660300002)(8936002)(52536014)(38070700005)(41300700001)(86362001)(66946007)(8676002)(4326008)(66476007)(66446008)(64756008)(66556008)(9686003)(186003)(38100700002)(6506007)(26005)(316002)(76116006)(110136005)(83380400001)(54906003)(33656002)(7696005)(478600001)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0NzQ1pzN3ZwWlh1T0xGNzV0bEYwRjgyZ3BaMkhTbUd4RFcydG13VmtmRlVt?=
 =?utf-8?B?VEZRYTBlOEREaEsybk1LSE9WL3BFZjJaNEY2V25NdWJxMk5BOHloWTYvYzlr?=
 =?utf-8?B?Ykc2S0tQMGZSNXZTeFB6V1FmUStJcS9iS1dSNy9oNk80VDhQcDhYM3REaWpz?=
 =?utf-8?B?L2F5dGJ5RGNPRnc2TjBDSUJlM3JoSFV4MXB2SXA5WVAwTkZBb0RzaXlxUE1G?=
 =?utf-8?B?SXI2ODdGanE3TkkvK2RSbjFPTCtQcHdGNlk3T0lPalNNclh2d05FZUNObkJN?=
 =?utf-8?B?c2lpQXFNWGk4dUNOQTNQOEtTTFRncFFHZUZNVFM1dU1RS21OQW5TYkJKZDh6?=
 =?utf-8?B?OEt2RkEvWUlMZlFrQjUwaUQ1L2RMQlJVYlRNWXZWdWVodTI4S3dCb2k1cXB6?=
 =?utf-8?B?R0JveFQ5OUR4Y2xkcVBXMU4zRW8zTlRsVFNsbzBSQ1pJSkdkZElNSDk4S1NQ?=
 =?utf-8?B?cEhuNTB4cGFWT0xFbUFxdkpKWE1ra0dmWXhuWCtTWklNWUEydXlzeWZGWlNm?=
 =?utf-8?B?cm0xcjdjWHlWQ2tFRFhWYnY1bkcra29YalA3aEdMWG81Q2ZmR1R6SE5RKzgv?=
 =?utf-8?B?M0hlWHJYakFNMXFyVmN2b0ZNeExQZUpkbktta2tua1RTSmEzODRROFZOSXUx?=
 =?utf-8?B?S3hUcEVkWTlJWHM2bEZXUnlhd25jY1g1SnRTVTAyc3JMWHhtZm1HcUZWUFdX?=
 =?utf-8?B?dXdvL1ZERmU5OHBDRHMzaURTTjNaQ2pOeDVGR2dacU1nWEJKeEpVSmdVdHNP?=
 =?utf-8?B?RTFpdENVaDJ3TE5TdDIvbWNLUlZHdSt3UmkxMW9YVk9Xa2hDOE1ZMUJkc2dk?=
 =?utf-8?B?b2tsY3dEZWhNY0xlT1Jub25mcm9DMlhKSzN4OG9FdURna280UlNRT3d3ejli?=
 =?utf-8?B?MkRWZ2Vibm5mMXA2M2RyVVdGNmlZYUZIT0VSOUptaGN0RStrQndUODZ5Y1Np?=
 =?utf-8?B?UHRKUWMvUHZISDI1QVFmaDI5b0pCZFRmWk82WEltNXdKejVKemdjdWgzQlYr?=
 =?utf-8?B?SGk3UmE1UFBDVCsrMGdvY2d6aURBenN5WFlwRmhVVXFuaU0yRHlYdmRaTTNv?=
 =?utf-8?B?T1JLbnRLTG5xdHFxYmkwK05YbmVoakJPRHc3eWZPbXVkQzM3ZkVSMnBXSWho?=
 =?utf-8?B?R3dGTHlvWUY3K1RSbUE2UTFKVXErMWpaY2QvZGMzNzZMSnBLTzdDbXpBaFRh?=
 =?utf-8?B?UmZkOVFoM3B0Vm8yVHJUamx0eGg1dVNxM2xXQ0MreENxTVk4YzBXTFhtSE5S?=
 =?utf-8?B?Qzc5Q0UrK2NyYklERjZaUlQ1UTdCdVRxY21ZTEhnbmwvbHNlOEI4cGZ0eGp3?=
 =?utf-8?B?SkxLYnhja1dJeGRBS21RY0dCcDd5cWRFa1l2bUtac1M0ekp6Q3QvSXlabTBV?=
 =?utf-8?B?SHhLSzhlQlZDTnpuWUNlMjNJNEZWSlJaY05mSnhsTGtPUklRWDAzSDBXUzNQ?=
 =?utf-8?B?Um5wSHRFcGFXTmRRSytFQmc2N3hkNHlFSEdkeTRNYitOK3FmMlRkTjBrL2Jq?=
 =?utf-8?B?RUVQSURhSjVGeDFGWGxEUStJQ0dqdVNwL1hEMktWR3NRQm9uWEkxWWNqY3pF?=
 =?utf-8?B?WkROcWpob252eC9YUzVtMGVkT1MvNTZqYnpFK3h0eHRCME5CREtRMHh5Zmdn?=
 =?utf-8?B?Y0NYNk8vNVY2YTZGMXBxQXVlL2pqdy96ZndJd3gyWStKaEsyWWJ5c0ZLYzRl?=
 =?utf-8?B?WVAxRzFxdHFLb1puL1dmUWZOR051WHRsWEhrMy8vbU0zZXhTYnI5bG5OVEQ0?=
 =?utf-8?B?QjJVU1ByWFZ2cFhWaUR4UExQQi9NcjJ2Nm1tdlpybEJ2R2ZyYkE0OEFGUndp?=
 =?utf-8?B?K1BnRHVZbU90VTdza2U4ZlgwZkwvaVZycm5Sbjc1b3RoRHFuM01NdEg2OURk?=
 =?utf-8?B?dkU2M1h3L1crTTBiRGpaZDllV2FwSlkwUHAvMkJEUUpOTkpTOEV4VFk2eVVa?=
 =?utf-8?B?aDhRcjltZy80K3J4eW1oZGJodDlmMHZ1cTRCZWRpU3pWVXFjcVU2WlloMXBa?=
 =?utf-8?B?SzhtZTFFdXJKSXpzMHNqMzRKaFFZTlprVjdGVXkzeGVqaHA2c1dZanRnK25u?=
 =?utf-8?B?bC9HeGVsakMyeUJPdmJHWmlSZmdUVTE4bDR5RmhhM2xhYmVHY01RL05JbnQ0?=
 =?utf-8?Q?awjg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0549178d-05bc-4c01-a854-08db1c3d6769
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 23:17:05.6461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bA1/uU/u7NMjXZ/Dc/0SMhJiHjvoRR++qIpcrOnVOPnuE+ZihoUN9MygxuCmmgi96eles1rta7+bW5S+3KeaDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4769
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIb3dldmVyIGluIHRoZSBfX3N3aXRjaF90bygpIHJvdXRpbmUsIHRoZSBjdXJyZW50IHBvaW50
IGlzIGNoYW5nZWQuICBJZiB0aGUNCj4gY29tcGlsZXIgb3B0aW1pemVzIGF3YXkgdGhlIHJlbG9h
ZCwgdGhlbiB0aGUgcmVzY3RybF9zY2hlZF9pbiB3aWxsIGxvb2sNCj4gYXQgdGhlIHByZXZpb3Vz
IHRhc2sgaW5zdGVhZCBvZiB0aGUgbmV3IGN1cnJlbnQgdGFzay4gVGhpcyBleHBsYWlucyB3aHkg
d2UNCj4gd2VyZSBub3Qgc2VlaW5nIHRoZSBsaW1pdCBlbmZvcmNlZCBvbiB0aGUgYmVuY2htYXJr
Lg0KDQpBcmUgdGhlcmUgYW55IG90aGVyIHVzZXMgb2YgImN1cnJlbnQiIGR1cmluZyBjb250ZXh0
IHN3aXRjaCB0aGF0IG1pZ2h0DQpiZSBhZmZlY3RlZCBieSB0aGlzPw0KDQotVG9ueQ0K
