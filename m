Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757325FADB1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJKHrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJKHrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:47:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68775876A0;
        Tue, 11 Oct 2022 00:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665474438; x=1697010438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k4HAlAPwGwmXyFLhZwVBagJ/QQ0+JNhmhZNLXBjPrXA=;
  b=kSM2ia63eO4y0dgX3znXSB6Nf9BsM55h2vmjHxIpmrKQgKVb45Z4N1ei
   V1C//EDftyJrgdEJaHgzeQuW2QPf6lwguuUX/mSRqFtG5EnGXtJ39UCbJ
   t9sPSlYm5sVM2AALALoKT3R266qipnzmntgjLx3RXZzY0eR/WthF4bTEf
   mz7bMIDYFmiOV2QMPhGjnMiN035HCjC/0sg8p6DBo3MFsJcNZGO9ar7w5
   ZSqXkinPuyb+JcVHz17e0XHZzxzvYn7+Yt/8iA6hpkY7IjaqhIr1grqdJ
   oP6a+bRKUTxj0IflsjyRl2H3J12W42/9PytdMvL5s+6aQU2zRu0wOqC7P
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="368600731"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="368600731"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 00:47:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="768702791"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="768702791"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2022 00:47:17 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 00:47:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 11 Oct 2022 00:47:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 11 Oct 2022 00:47:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+dpbXi2FJ+e2jHZ9KQcSYBXdHqGugRPQ1I911lv0uN3G4mpNTfG0+eT5e+j0Ood57nZAg0Oyqaq6YiNpaLj/L0jN1XIT47uSP/PFTdBNnl7uQCeFdsEMdvyuuNnStHfc0uVzj7+gTiCVehpj74kfWZQbNGM86VqYK1PoELCZv7QoK69jfPhFy9xuGwNUK41YCYIXwthfghelC/1hA7eRhCU0rIZ+p+bWNvE81UEjMuwTM/54zdWi6kLUVs02FXQESiyvjqOZIIJLCYVc7qOp620LcYvNjd/vKAIV3TVX04zZWVUPnaF0kT+HFENVNtexigj6Ve65h2wYWZBXzUVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4HAlAPwGwmXyFLhZwVBagJ/QQ0+JNhmhZNLXBjPrXA=;
 b=dRn/3Q2+Mv8uiLs2ATHlE/5s45s8LiA53Pbx3sUNywjg9xrXq5pueBMrjXlX289ZsFczz+Ar/HBPDfHGR3VubwOD8yaUB5QX0HaPnZDqdN/SSXZ6Qw4Bj8+3jNQOh8GAZvbbK+TYpAvn+1PwYSsyzvnyr3B8euic618hnk33+esTS3JtA6/Of9lIGMpY+d2Szg9sC6fJX/nPffKC0O3ix4AExl1e6uufq+H4uSzBZp7k7Bomy+yegm9JRu2L/Ti+V6f6RSwoca/fOEnC7KcPP7aUbT0wBc511N8yBBMR7E+Q9lDvk4KmgR2kh5PxdCgK9HVLirVrUGR/dCXwmTmppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 11 Oct
 2022 07:47:14 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::9ee7:3ca:b4ab:59c0]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::9ee7:3ca:b4ab:59c0%6]) with mapi id 15.20.5676.032; Tue, 11 Oct 2022
 07:47:14 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "ihkose@gmail.com" <ihkose@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Change the I2C slave address for ds4422/4424 to its
 correct value
Thread-Topic: [PATCH] Change the I2C slave address for ds4422/4424 to its
 correct value
Thread-Index: AQHY3NWSW3/VPWQX8UCkuDNQdKp25a4H9T+AgADb+hA=
Date:   Tue, 11 Oct 2022 07:47:13 +0000
Message-ID: <CO1PR11MB4835C3D5E1BF5C572DDDC5B396239@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20221011182437.662719-1-rajat.khandelwal@linux.intel.com>
 <7a71aad9-9e4f-b314-9ae8-7f478aeae53d@linaro.org>
In-Reply-To: <7a71aad9-9e4f-b314-9ae8-7f478aeae53d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|BL3PR11MB6532:EE_
x-ms-office365-filtering-correlation-id: 8f63b3ed-2797-40a0-9d07-08daab5ccff1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: deDf2xddleLwkBya7CJXH7yNZtrrztKdLv5VIZGIMvw85P7HoNWrUjDB2xSQtliHEi+XcbqVSb8I0p+d9GcPA+M51m9OPWVnM7sy6q0pROY+TO5EJSVs32XRctj661RNAji9QF94XN5pIUaiHk70VmYTxEVzVc8rLe2BqlECP7QfgyRERtESwFa12aL1NtUmH6jrLvakPM4sfJEul2knp98WlCP0wLwbASxM08u8/vj7esg/hmJdubzLR9vP2bNkiNtKWj/7+c2swoe7U0YDnvDzchhCOVnThUCJzz91/eYVEnRjB0B/bLhFm7x1DCV+ocJJsdM5u/4IjkAimvZd7RtPE4T//crQPvnWEy1UP3m+Mrqm7jZ17jPTpgrhHZ0oH05fWub+XXVhbMhQz4pmA4ZY/QCEfLG7f2vPiHeiCZa2FMmPyYxBk9QhbcyS44Ur5n/MkzcTDfedN/DolAn92uH+S+XeNOUA1n2FfpGm8YhkHJzwz2G99CJkcWfkRsFEkfzKdHUJyqJVFBsgrnAvCT5ZM+vS3tprl6kaxCR0SCUmsxTTI7n9P824esRAE8F53xPybWvMVHTf9WS+oEqgpr3Qxq9BwgP1hdVjJb1H10hsHVkUg3J1LCe0kLkeyF3WABXiIyBc72x4qfsWDcRC759V/P8qPmOEw8ncim1mLCHoF5ReXfa1oNVmfw53CkHR7Q/HMNJ+8iGceTtEl1jECbkXGqE3Ub32MX2borGznTCtKbbbWrs6ViLabRufAopGqvuFcaWDN7DF34WSjH1hng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199015)(186003)(7696005)(9686003)(6506007)(26005)(71200400001)(53546011)(83380400001)(2906002)(55016003)(5660300002)(7416002)(8936002)(52536014)(478600001)(110136005)(64756008)(54906003)(8676002)(66446008)(76116006)(66556008)(66946007)(4326008)(41300700001)(66476007)(316002)(86362001)(38070700005)(33656002)(38100700002)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aElGNG9ndmY2empTWEdENjZUdHJqbXFsMGtIYXNmMXhTRm5pTzB6Myt4am5N?=
 =?utf-8?B?YzBya0ZIem8vTG15VHMzVExwSm4xTjU2ZFJ4WXlxaVlBeWlOOUpsMktTOXlD?=
 =?utf-8?B?YXRNWEIxL1dJNlBSdnd0clN5NnR5UzNqMU1DcWpoUE8xV0ZNTTBsVENEbm1F?=
 =?utf-8?B?NTNBWHBJMXdaVWt1cmpDemRKRWJqR285VnBTa2NpL0xhWnJ6K2QwSzFzd3Rs?=
 =?utf-8?B?UTFqOElndWdpWDF6b2N1SHk4TEo2TkVPZm1FYmk4RFdKRDdDQXRiaHA2dEEw?=
 =?utf-8?B?TFlNWlEvSi9qeVdwZTVCc2dZVzY1YlNIQkNydzF4REl4R0Z4UGxTK0Y0VzZ5?=
 =?utf-8?B?NmxoM2NkUGpRZXcrbUl5OUJCbHM3ME1FV3h3S3h6Ty9Oby9IR1RhS2NIcmRP?=
 =?utf-8?B?aS85REZUY3g5R09PZiszVXJycndsa2ZvVWloTTVCZHQyNmYwd1FHVDZvanVt?=
 =?utf-8?B?YlhHNzhTdVJTR2o1Z3cvNDBDSTZ6ZExnSXM5YUZlb2ZuV2I5TUpPTnp1cko5?=
 =?utf-8?B?REl1V0JNZXFLNU9Rck5NcW8ydDRyNzd5MDdIdzFCU1AydHRQT0F4dS83dTdJ?=
 =?utf-8?B?K1g2c3FEditBdytOc3hZSUxOV01TSDFxY1NPZUdwREt6ZkxOOStXSmk0S3po?=
 =?utf-8?B?NVltNGJ0TTlyUXIweTdPY2NjejRuNWgwT09vU1FQQkNLTHhWSWJUdmRCZjJP?=
 =?utf-8?B?MW5xeDF3djFZbVl6bWlvQklrMHVjaXJla0lTeEcyV3lSbzVHNU9lczc0S2tv?=
 =?utf-8?B?YnVJTmdaN2Vwc0VtakpUQm1Ic1ZCK3pVTDBMOFJEV2g1RVRkaVBBbUFjSnJa?=
 =?utf-8?B?WlNlUW5qNXJNTS9SZ3JVN0JTNVo1Mk5OU2pzcUhleVlXVFpDTU9zRS9lbGFV?=
 =?utf-8?B?UERoU1hVUnJBWllXUjFuZnpGL0dNeHNCZXJXMk5xVVgyUG1PeHQ2MllQU0pD?=
 =?utf-8?B?YXNKbGxDeUZsWEJwckdNUGRIUFpFZ1BrR1Z6dHRWNlVFWWZwUFp2L216NzBx?=
 =?utf-8?B?Q01xMTJpU282UGw3Y1Vua3ppTmlCZ1E0OUZxemM3R1czMGIxaXVuWk9ZWEJw?=
 =?utf-8?B?RFl6YXQ5elM5R3dRa0xlOGM1QWcwSDdpSVlDTUdQa1k0VmJNa1RWOUJvYVlp?=
 =?utf-8?B?Sm96eDF5WGRmTlZCNlR5THg2UTVtRG5kbm1GMjdmUld5QmlxMnMvTm5rcG41?=
 =?utf-8?B?YWdHWndRMEV2R0pWOWtVTGRnRWxZUkJPUS9FVXVQY1lrQWxRMElkU2tLY3Zl?=
 =?utf-8?B?K1l6ZHlPTjhvWE91V2hiOHM4T0ZmOWh1dGxCdGc1cVhtbmdjcmRWdXE0M1Ix?=
 =?utf-8?B?MzZIVTdFVFBXZEl5cUNuZHhBVmFZRkJWRTBBWHJhODRYYUJlaGhuMTEyelZj?=
 =?utf-8?B?MnJPZTZFdVZSUzA3QjltSHhFZUhDNk45UXNxSUpSc2FhMXFvZklkdTZNN09F?=
 =?utf-8?B?SFlXdTBZR3ZpaGRYKzZhMm1DYlltblo4UGVVTVFKNXFsQ1ZoM2xac0F4amwy?=
 =?utf-8?B?Z3JXbkQ1WHlCd2FGekxIeWNuN0ZwL01yVUVNWXpxSHFTOGxURFZwLzJaTVcw?=
 =?utf-8?B?OEYraGZ4MW1qakZMdS9TVzN6WjNBTmFIdmdyNUw5bWNkVTkvZ2Q2cEJJc0FB?=
 =?utf-8?B?NVBsVWdkOXB0MG9URFk3bUFYa1phZHhqZ282Ukx1WTRxbjBTbmV2VjdGOWxp?=
 =?utf-8?B?ZGVQMFJEYUthN09FYm5pM05tOTdxajBpcERaRzJnWStqV3Z3SVNZdENRM1VO?=
 =?utf-8?B?Ym14WWpId2VvOE1wMGttWGRyNG1rWm9xcElLRld2a0F3RVBhc0FzZnlTNVhY?=
 =?utf-8?B?OEE4VTNYWUR5VTV3RnRTKzVOald0MDVZd1htdmlWNUZUUFBnc2NSdlFYVUl3?=
 =?utf-8?B?dktBSUpsb3RWQ2NZcXRWZldxNXlpaC9LT2hxeXJkNk5hTUJJVVVSOVVuYzVO?=
 =?utf-8?B?QnJVN0Z3dk05dXpPYkx4cjZKTmVmTWlwQ25ZZ3R6M2JxYVdnUzdXYXVkOUt5?=
 =?utf-8?B?ZGtKbFJMVTY3d0xEWG01Tk5Xa09TOUo2dy9KUzVBeGl6RzE3VStKTEZUcEll?=
 =?utf-8?B?K1ZhU3VNL3UrWnJEMCt4NWFqQnVLNWlYUjY1R2w1R0lGY3RxWFBUSXZPVzk4?=
 =?utf-8?B?UVB1YzJwRDJKdEFTMDR3M2FTcHJ3d1cvczFBSjBsN3ZwNmVUejUvOElBZkMv?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f63b3ed-2797-40a0-9d07-08daab5ccff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 07:47:14.0093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zO5OKnghBehoJgsmYYmPJgb4xSY1xT1YJ6xGCfjFjdtUF2qE135Rq8yZXhGp6gWfgFObhmZscJ2FTPMM4SyQgsHRrG+WbbuWFEYJc4T9UfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6532
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQpJIGRvbid0IGtub3cgaG93IEkgbWlzc2VkIHN1YmplY3QgcHJlZml4ZXMsIHNvcnJ5IGZv
ciB0aGF0Lg0KVXBzdHJlYW1pbmcgcGF0Y2hlcyBmb3IgZHQgaXMgc29tZXRoaW5nIG5ldyBmb3Ig
bWUgc28gd2FzDQpza2VwdGljYWwgb24gZHQgdmFsaWRhdGlvbi4gSG93ZXZlciwgSSBoYXZlIHJ1
biBpdCBub3cgYW5kIGl0DQpwYXNzZXMgZm9yIG1lLg0KDQpIYXZlIHNlbnQgYSB2MiBmb3IgeW91
IHRvIHJldmlldy4NCg0KVGhhbmtzDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+IA0K
U2VudDogVHVlc2RheSwgT2N0b2JlciAxMSwgMjAyMiAxMjowOCBBTQ0KVG86IFJhamF0IEtoYW5k
ZWx3YWwgPHJhamF0LmtoYW5kZWx3YWxAbGludXguaW50ZWwuY29tPjsgamljMjNAa2VybmVsLm9y
ZzsgbGFyc0BtZXRhZm9vLmRlOyByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dz
a2krZHRAbGluYXJvLm9yZzsgaWhrb3NlQGdtYWlsLmNvbQ0KQ2M6IGxpbnV4LWlpb0B2Z2VyLmtl
cm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBLaGFuZGVsd2FsLCBSYWphdCA8cmFqYXQua2hhbmRlbHdhbEBpbnRlbC5jb20+
DQpTdWJqZWN0OiBSZTogW1BBVENIXSBDaGFuZ2UgdGhlIEkyQyBzbGF2ZSBhZGRyZXNzIGZvciBk
czQ0MjIvNDQyNCB0byBpdHMgY29ycmVjdCB2YWx1ZQ0KDQpPbiAxMS8xMC8yMDIyIDE0OjI0LCBS
YWphdCBLaGFuZGVsd2FsIHdyb3RlOg0KPiBUaGUgZGF0YXNoZWV0IHN0YXRlcyB0aGF0IHRoZSBz
bGF2ZSBhZGRyZXNzIGZvciB0aGUgZGV2aWNlIGlzIDB4MjAgDQo+IHdoZW4gdGhlIHBpbnMgQTAg
YW5kIEExIGFyZSBncm91bmQuIFRoZSBEVCBiaW5kaW5nIGhhcyBiZWVuIHVzaW5nDQo+IDB4MTAg
YXMgdGhlIHZhbHVlIGFuZCBJIHRoaW5rIGl0IHNob3VsZCBiZSAweDIwIGFzIHBlciBkYXRhc2hl
ZXQuDQoNClVzZSBzdWJqZWN0IHByZWZpeGVzIG1hdGNoaW5nIHRoZSBzdWJzeXN0ZW0gKGdpdCBs
b2cgLS1vbmVsaW5lIC0tIC4uLikuDQoNCg0KPiANCj4gTGV0IG1lIGtub3cgaWYgSSBhbSB3cm9u
ZyBhYm91dCB0aGlzLg0KDQpUaGlzIGRvZXMgbm90IGJlbG9uZyB0byB0aGUgY29tbWl0IG1zZy4N
Cg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFqYXQgS2hhbmRlbHdhbCA8cmFqYXQua2hhbmRlbHdh
bEBsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lpby9kYWMvbWF4aW0sZHM0NDI0LnlhbWwgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgDQo+IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9kYWMvbWF4aW0sZHM0NDI0Lnlh
bWwgDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9kYWMvbWF4aW0s
ZHM0NDI0LnlhbWwNCj4gaW5kZXggMjY0ZmE3YzVmZTNhLi4xOTU1YjFhOTdjZDYgMTAwNjQ0DQo+
IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZGFjL21heGltLGRz
NDQyNC55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8v
ZGFjL21heGltLGRzNDQyNC55YW1sDQo+IEBAIC0zOCw3ICszOCw3IEBAIGV4YW1wbGVzOg0KPiAg
DQo+ICAgICAgICAgIGRhY0AxMCB7DQo+ICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1heGlt
LGRzNDQyNCI7DQo+IC0gICAgICAgICAgICByZWcgPSA8MHgxMD47IC8qIFdoZW4gQTAsIEExIHBp
bnMgYXJlIGdyb3VuZCAqLw0KPiArICAgICAgICAgICAgcmVnID0gPDB4MjA+OyAvKiBXaGVuIEEw
LCBBMSBwaW5zIGFyZSBncm91bmQgKi8NCg0KRG9lcyBub3QgbG9vayBsaWtlIHlvdSB0ZXN0ZWQg
dGhlIGJpbmRpbmdzLiBQbGVhc2UgcnVuIGBtYWtlIGR0X2JpbmRpbmdfY2hlY2tgIChzZWUgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dyaXRpbmctc2NoZW1hLnJzdCBmb3IgaW5z
dHJ1Y3Rpb25zKS4NCg0KPiAgICAgICAgICAgICAgdmNjLXN1cHBseSA9IDwmdmNjXzN2Mz47DQo+
ICAgICAgICAgIH07DQo+ICAgICAgfTsNCg0KQmVzdCByZWdhcmRzLA0KS3J6eXN6dG9mDQoNCg==
