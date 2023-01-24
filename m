Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADFD6790FD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjAXGc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjAXGcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:32:52 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6853D93B;
        Mon, 23 Jan 2023 22:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674541944; x=1706077944;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ec/EsGtrci3oQ/oociclVcuRKpvi0G3++PZZJFqUEIg=;
  b=Sl/oSDCccUJcS6AZYK1HN4bbPPvmJH1d6SF7WJ5QnvTVGDbQZLezBHQt
   N+V+Hl8fLaNGp0vRwSh20QqyNCmXRNdg7KMPK8ll0jCAg/t7hxlX0Av0H
   xfrlD9DiY+bOGx0UXkEWw96kZAVjJHjaBjNeZB2TX9atwtJ+cCpijDhUu
   c4BteCJ5IassHKp0OZbWmZbmvF/oM2bgecg14+QfUgWTotI9/wb2pfrf8
   D7CfTLkEwpMG8h72U/LoU3khtOXRS4XiAY0fixiWfRtSP19pgYeNOpBsN
   cMLVdwudjv4AfKj75a5BLhQpeNiRPYdq8d6zB2wIwDyMqccculz18CiA8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="323929116"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="323929116"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 22:32:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="990753258"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="990753258"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jan 2023 22:31:57 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 22:31:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 22:31:56 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 22:31:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S846rLbB057r6woKfetTtL911f82SADF3JCy0ifPCmi96rK76WuKMhAedlKMgMivRDf6XKc3aL1fcKq4jwdjgfd8lLdBL/MQ3bDteBoYe20e0YLA+nBlCaergaFw7TA66ctURWRvJys0E+Ydk6bNaVkb+o5A1+kN+jxk5Rrs6hzYQkHl7LvHhdFxN0Ekm86n1krnhFOklmq7UdIOJ8pnDsDOglqHYTfYLJufDyzmUasugkpkMn2QI9jVloLq0pHZOZ+AoLgpwekpg7S+Dfu5nT+47ODG41Sk8rrL46ej8q77IiOVbezWMpjGV0883bVFJx7ECUTs7CA2SZZ3MoDV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec/EsGtrci3oQ/oociclVcuRKpvi0G3++PZZJFqUEIg=;
 b=gaTT9ZTM/fNU6tr2qfioUEfIHVURcROYqBPxYxVGpYnyzoIfA9zmYMaH5v1parsHn22w4QUitqAxh9cN9qTaEtF5yhJWZfitPB8N48C8O2nekP1qAYxEF4H9XegoOWiZfvPMFWjoD+LW2mDwfd6iiZ0E096K6vKNLhb3ufzl66aR8YQ1k+fCD5jSlJOAxkUeS4ikWgGdDFEk6kWfrOjxVmrcaVqiuhbmrnARreE4ibVL7oCw0Uzn8G1PjJ2YLaLW1GhVxEQa2WT1qwVUS24eeiJL8KLRV36bUqaug8q9vZflgHjQkuyjp92h3OGWiZy8fZaIENJVyo4MhdvJk7g3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH7PR11MB7497.namprd11.prod.outlook.com (2603:10b6:510:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Tue, 24 Jan
 2023 06:31:54 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 06:31:54 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] thermal: Fail object registration if thermal class is
 not registered
Thread-Topic: [PATCH v2] thermal: Fail object registration if thermal class is
 not registered
Thread-Index: AQHZL2t2935HJGquX0+Jto1eW/nOg66tHEAA
Date:   Tue, 24 Jan 2023 06:31:53 +0000
Message-ID: <1799f0dc1fd6403b035dbc307724b78f6e365ff4.camel@intel.com>
References: <5660360.DvuYhMxLoT@kreacher>
In-Reply-To: <5660360.DvuYhMxLoT@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH7PR11MB7497:EE_
x-ms-office365-filtering-correlation-id: f09267aa-badb-43d1-339f-08dafdd4aeef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: npm7U7OqSECJ5IQA/xBASRhTUwIDgOOtZvplNDLJZygiddqbH5CV5SxIJLS/5IqDlR01A9is4oOBlRqRflHdgY0pHIzAk2+E0rlKt+MbBUVojxdor3I9NjPy2XlSlXWVL5lp6lt92RI6WBEFi2hstFfesJlEXT/c9DFnHG4vesr8wpBMb5q4opg3w9DgV+zqsmBGY2hDuA+7DGzHnV9VH+yrd9Ro1qRMPcBRlXXrH+ST7KkIWJZGn+tfjpCvKl+vSEzLRSw8g8DBCRmhF0J6S7WFj0X0k/4h2dRznD5nbmfypDDeKdd2TlWxLoB6Gip1uY9IA5tb1u+hY9sTLK1kjwMDeqldmGWqD3lgIcjunB6fgQrpswnLJ/vjDmW8sEQ3njw7G3NHkcsxz58tgeXatzCm4UvjvCGH0KCh25jk+UHOnJEdwoJvePIQpW+aZHF/rjLw1Ehp65huXMtQ4OL2hHYzNCv2u91WI37yBrvw2uh/Kd/a39kyGh+f3Rm5gHVfHJdYAEyr0FZQeTVgHf2tLnsx/xgCLnFtKNRnSOkOwv8l0zZbusxv2TWEZidCccUqF1MENiE2hSx23I2LDjaiJ592nPSQ0o0Y/7MukyA2ZsE6qq+1fpvtPcf9x8Ls9o7L14y2vXKY2Z1zW2HHNkIvMN6kiRROJP6F+cbGB8YW45V1YL1THXlz24EwmulpTl4SwASp+zXjH7aTJ243g64JbN00UZuNGS/48g+mn5gmyl0TNvDPi1OqW77S3ws7dAo3+lga8majZ1+iiiJiuLYSNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(6512007)(26005)(186003)(86362001)(6506007)(478600001)(6486002)(966005)(84970400001)(71200400001)(36756003)(82960400001)(83380400001)(2906002)(110136005)(316002)(54906003)(38070700005)(2616005)(66946007)(38100700002)(8676002)(4326008)(66476007)(66446008)(76116006)(64756008)(66556008)(41300700001)(122000001)(91956017)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHNsbFlPZGdWT2JCazhwOG5Ra2E1WHZUamN4NVhUV0xDVzMrNklqaDhIOFFp?=
 =?utf-8?B?a3Y5V0NPdXhLUDg4V3EyaW8rNS9vaHh3d0xPSmZtQ0ZocU1uKzAvSXo0eTBJ?=
 =?utf-8?B?K29heW94NDRtTnVQQWpHRzdUZmRibmxpTUgvYWNZa0FQWDBYcXZKTE5sdVEy?=
 =?utf-8?B?Q1BubXlhYzhvOUNubUZLcjQ0Nit1ckVLVEFFMXpLeW8zLzFGNmtiSnF0RmZJ?=
 =?utf-8?B?QVg4ckJHbkxzM2pidnVrWERnL1ZXK0xPbDRoMWNPTzl0VDJjTEh4b3p6a3F5?=
 =?utf-8?B?ajVJV090dXdHclhSRWRyaXFwUUZ5UHZqc1dHVktIc3FiMExTT0tNYlczUU9p?=
 =?utf-8?B?VnpzUlF1OU5mRVB6Q25BWFlnWmhHaElWTllicUxpQXhBeUNNUHYycFNiTXJR?=
 =?utf-8?B?WnRUWFVEcDJzL0ZkYm9peHpCSG1QaEl1NndwaHhJVlhOVHhISUFWUTIxcUtN?=
 =?utf-8?B?Z0tpVG5aWVBDUnl4NUhOTjVLVm9BY2pUeUNTa3JuMFN6amEwQUUxenlIOUtN?=
 =?utf-8?B?bDBkT25SOS9seW5VUmxzVFcvdmFmTXdQN2EweEpqUUxRdGdVTVJyUGg3aE43?=
 =?utf-8?B?eHlUaU5zL0JqMnFLTlZhNGpsVnJPY015MnJSOXFNa2VDbXVlSkVsejZEWElR?=
 =?utf-8?B?UkJtbldMMmZBVzNTZVFaRnhOZDBYbEpMeUdtbUR2YUdqL1RZdi9kVm95SEtq?=
 =?utf-8?B?c3FmOEtVQjdhbUpIUEFKazkxUlpsb3QwcnNqOXo0MGVqWjYzUHF3NDRFQ1lv?=
 =?utf-8?B?RWFmR3NRQW55c0UzSnpZaGFTUWV1a3VCNzh1bEhvaXBkY2IvOFpGVU1BNUsw?=
 =?utf-8?B?V2FPcEtadUNoTkh6VDdwZTlxMmh6WThrNGxDNnozMWdPb3FSekk2aFZYYUJu?=
 =?utf-8?B?SUo5S05neW56NmlMR2oySFB4VktzK08xeVRWZHptcGMvY2FqekwwYWljUXZG?=
 =?utf-8?B?TjJaMUtLQWc4QXcxckNKZlpoVnNKcDFhOTY4dnoyQ0dnTEV3MlVjaGF2ei9j?=
 =?utf-8?B?bVhtQjliT1VYc0RCVFZxT3R1dUhVQjdlVFBIclh0SXdIclpCTE9WandjUkJh?=
 =?utf-8?B?M08zT0h5V3pod3RCLzJ2ekt2c29Ib29JYllBckNHdzZTeDZ0eFVGNkhPTE5C?=
 =?utf-8?B?WHdCd2FUVVlZbW16SHVpSldmMGQ3UTdXU1NuYmVrY1VhT1FUdW55MUZXYmRF?=
 =?utf-8?B?dVJqM2FITk1GRXhJbzJDamJrVkhNNDVCMEdnMVdUdVpnbGp5a0ZPQUlBcUxK?=
 =?utf-8?B?UFRHSHgxandsdlFYamQ1N1BVald6QmZ3cExKYUlSdmVwN1Z4VjRLUDYzeUZo?=
 =?utf-8?B?ejBzMXF2bEN1Z01yNjNNUStEZUJtQTA5YU0rWjA1dDN0UlFZdVdFTmFLVHBq?=
 =?utf-8?B?VjA3Q3JwL1VkRjFKMFcrYlE3bVlHa0dxWjVOVFJGQnVlMXoyVUg1eDQyeWxV?=
 =?utf-8?B?YnBZS1ZMOTBXdGlBckVZemNtQ3J6eWJFN2lWZ2lBbXVjUm1LWnJXSjlwOUhp?=
 =?utf-8?B?SjVsVzVqallTOGFGQjVkaDNMTzZ6Q3NrbExNUkYwc1liRUJlbXk5WjFKY2pL?=
 =?utf-8?B?blRKdXM0aU8rTG9MZHhpSkVod3hpSFlyeUE3M1JRZzhIWmFUcTBLUjFrN1JY?=
 =?utf-8?B?ZURiWDhSRVZvSkdtajFtSlhGS3YyT0FKMjdvdFhvbi9GS1ptVEVZc1hGYy8r?=
 =?utf-8?B?UFFCTG1FV3dZZGwvM0prVXFDSGE2akV1a3ZOR0VXVWhVdGpPY3RiN25URTNh?=
 =?utf-8?B?bU56emtXMnlZS2J0SkZqcU5ycG5zbkdrclF5MTZDOEpLaWY5QlIwRFFrY0Fr?=
 =?utf-8?B?R1lEM09vT0dZRlp6TDVFcHRpZXhma2NoSFRrejhEUUJtQnVJaUs5VnA5dGpp?=
 =?utf-8?B?cmJ3VDFtM0tUMmFjYjNadmFGZnBlUWQ3dlNMOU1Gc2w2NTExZExPSWQ5ZTJB?=
 =?utf-8?B?Mk9KRFR0aFpLOHRBeHVPaFBBd0FnTWlNVlJWRDkwVVhUTzNSNmpMbDBDMVFY?=
 =?utf-8?B?bXpUTFdtWmFNMVpCUDQ4M2ZvZkEybWp0OEcweVcxRXozUjBwZHMrbmdRV0hT?=
 =?utf-8?B?VHRDZk1yRzhJQ0ovRk5yUlRRUm5XNm5ERGN5T09EWlJ0eW1TZ29QVnJCcG5s?=
 =?utf-8?B?ejVqNTZyN08vLzZZM1Zwb2ZwYUVqUzUxMDczYzhIY1RVdStDejREOTl6eDU4?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74DA7C086066FF41A4F0AEA7E204887F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09267aa-badb-43d1-339f-08dafdd4aeef
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 06:31:53.5996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZz4PyiU31K9q4svfU8bikFqMvaQD/suGuMP8SFgRti1bFhx6Y+LrfK+gjKlrCKiszEPLObP3nMZ8lhuJSGu3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7497
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTIzIGF0IDIxOjQ0ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KPiANCj4gSWYgdGhlcm1hbF9jbGFzcyBpcyBub3QgcmVnaXN0ZXJlZCB3aXRoIHRoZSBkcml2
ZXIgY29yZSwgdGhlcmUgaXMgbm8NCj4gd2F5DQo+IHRvIGV4cG9zZSB0aGUgaW50ZXJmYWNlcyB1
c2VkIGJ5IHRoZSB0aGVybWFsIGNvbnRyb2wgZnJhbWV3b3JrLCBzbw0KPiBwcmV2ZW50IHRoZXJt
YWwgem9uZXMgYW5kIGNvb2xpbmcgZGV2aWNlcyBmcm9tIGJlaW5nIHJlZ2lzdGVyZWQgaW4NCj4g
dGhhdCBjYXNlIGJ5IHJldHVybmluZyBhbiBlcnJvciBmcm9tIG9iamVjdCByZWdpc3RyYXRpb24g
ZnVuY3Rpb25zLg0KPiANCj4gRm9yIHRoaXMgcHVycG9zZSwgdXNlIGEgdGhlcm1hbF9jbGFzcyBw
b2ludGVyIHRoYXQgd2lsbCBiZSBOVUxMIGlmDQo+IHRoZQ0KPiBjbGFzcyBpcyBub3QgcmVnaXN0
ZXJlZC4gIFRvIGF2b2lkIHdhc3RpbmcgbWVtb3J5IGluIHRoYXQgY2FzZSwNCj4gYWxsb2NhdGUN
Cj4gdGhlIHRoZXJtYWwgY2xhc3Mgb2JqZWN0IGR5bmFtaWNhbGx5IGFuZCBpZiBpdCBmYWlscyB0
byByZWdpc3RlciwNCj4gZnJlZQ0KPiBpdCBhbmQgY2xlYXIgdGhlIHRoZXJtYWxfY2xhc3MgcG9p
bnRlciB0byBOVUxMLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFmYWVsIEouIFd5c29ja2kgPHJh
ZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWku
emhhbmdAaW50ZWwuY29tPg0KDQp0aGFua3MsDQpydWkNCj4gLS0tDQo+IA0KPiAtPiB2MjogVGhp
cyByZXBsYWNlcyB0aGUgc2VyaWVzIGF0DQo+ICAgICAgICBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1wbS81OTA1NzE3LmxPVjRXeDViRlRAa3JlYWNoZXIvDQo+IA0KPiAtLS0NCj4gIGRy
aXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYyB8ICAgMzEgKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tDQo+IC0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQ0KPiANCj4gSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC90aGVybWFs
X2NvcmUuYw0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQo+IC0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvdGhlcm1h
bC90aGVybWFsX2NvcmUuYw0KPiArKysgbGludXgtcG0vZHJpdmVycy90aGVybWFsL3RoZXJtYWxf
Y29yZS5jDQo+IEBAIC03NzQsMTAgKzc3NCw3IEBAIHN0YXRpYyB2b2lkIHRoZXJtYWxfcmVsZWFz
ZShzdHJ1Y3QgZGV2aWMNCj4gIAl9DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBzdHJ1Y3QgY2xhc3Mg
dGhlcm1hbF9jbGFzcyA9IHsNCj4gLQkubmFtZSA9ICJ0aGVybWFsIiwNCj4gLQkuZGV2X3JlbGVh
c2UgPSB0aGVybWFsX3JlbGVhc2UsDQo+IC19Ow0KPiArc3RhdGljIHN0cnVjdCBjbGFzcyAqdGhl
cm1hbF9jbGFzczsNCj4gIA0KPiAgc3RhdGljIGlubGluZQ0KPiAgdm9pZCBwcmludF9iaW5kX2Vy
cl9tc2coc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6LA0KPiBAQCAtODgwLDYgKzg3Nyw5
IEBAIF9fdGhlcm1hbF9jb29saW5nX2RldmljZV9yZWdpc3RlcihzdHJ1Y3QNCj4gIAkgICAgIW9w
cy0+c2V0X2N1cl9zdGF0ZSkNCj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ICANCj4g
KwlpZiAoIXRoZXJtYWxfY2xhc3MpDQo+ICsJCXJldHVybiBFUlJfUFRSKC1FTk9ERVYpOw0KPiAr
DQo+ICAJY2RldiA9IGt6YWxsb2Moc2l6ZW9mKCpjZGV2KSwgR0ZQX0tFUk5FTCk7DQo+ICAJaWYg
KCFjZGV2KQ0KPiAgCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gQEAgLTkwMSw3ICs5MDEs
NyBAQCBfX3RoZXJtYWxfY29vbGluZ19kZXZpY2VfcmVnaXN0ZXIoc3RydWN0DQo+ICAJY2Rldi0+
bnAgPSBucDsNCj4gIAljZGV2LT5vcHMgPSBvcHM7DQo+ICAJY2Rldi0+dXBkYXRlZCA9IGZhbHNl
Ow0KPiAtCWNkZXYtPmRldmljZS5jbGFzcyA9ICZ0aGVybWFsX2NsYXNzOw0KPiArCWNkZXYtPmRl
dmljZS5jbGFzcyA9IHRoZXJtYWxfY2xhc3M7DQo+ICAJY2Rldi0+ZGV2ZGF0YSA9IGRldmRhdGE7
DQo+ICANCj4gIAlyZXQgPSBjZGV2LT5vcHMtPmdldF9tYXhfc3RhdGUoY2RldiwgJmNkZXYtPm1h
eF9zdGF0ZSk7DQo+IEBAIC0xMzQ5LDYgKzEzNDksOSBAQCB0aGVybWFsX3pvbmVfZGV2aWNlX3Jl
Z2lzdGVyX3dpdGhfdHJpcHMoDQo+ICAJaWYgKG51bV90cmlwcyA+IDAgJiYgKCFvcHMtPmdldF90
cmlwX3R5cGUgfHwgIW9wcy0NCj4gPmdldF90cmlwX3RlbXApICYmICF0cmlwcykNCj4gIAkJcmV0
dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ICANCj4gKwlpZiAoIXRoZXJtYWxfY2xhc3MpDQo+ICsJ
CXJldHVybiBFUlJfUFRSKC1FTk9ERVYpOw0KPiArDQo+ICAJdHogPSBremFsbG9jKHNpemVvZigq
dHopLCBHRlBfS0VSTkVMKTsNCj4gIAlpZiAoIXR6KQ0KPiAgCQlyZXR1cm4gRVJSX1BUUigtRU5P
TUVNKTsNCj4gQEAgLTEzNzAsNyArMTM3Myw3IEBAIHRoZXJtYWxfem9uZV9kZXZpY2VfcmVnaXN0
ZXJfd2l0aF90cmlwcygNCj4gIA0KPiAgCXR6LT5vcHMgPSBvcHM7DQo+ICAJdHotPnR6cCA9IHR6
cDsNCj4gLQl0ei0+ZGV2aWNlLmNsYXNzID0gJnRoZXJtYWxfY2xhc3M7DQo+ICsJdHotPmRldmlj
ZS5jbGFzcyA9IHRoZXJtYWxfY2xhc3M7DQo+ICAJdHotPmRldmRhdGEgPSBkZXZkYXRhOw0KPiAg
CXR6LT50cmlwcyA9IHRyaXBzOw0KPiAgCXR6LT5udW1fdHJpcHMgPSBudW1fdHJpcHM7DQo+IEBA
IC0xNjE1LDkgKzE2MTgsMjEgQEAgc3RhdGljIGludCBfX2luaXQgdGhlcm1hbF9pbml0KHZvaWQp
DQo+ICAJaWYgKHJlc3VsdCkNCj4gIAkJZ290byBlcnJvcjsNCj4gIA0KPiAtCXJlc3VsdCA9IGNs
YXNzX3JlZ2lzdGVyKCZ0aGVybWFsX2NsYXNzKTsNCj4gLQlpZiAocmVzdWx0KQ0KPiArCXRoZXJt
YWxfY2xhc3MgPSBremFsbG9jKHNpemVvZigqdGhlcm1hbF9jbGFzcyksIEdGUF9LRVJORUwpOw0K
PiArCWlmICghdGhlcm1hbF9jbGFzcykgew0KPiArCQlyZXN1bHQgPSAtRU5PTUVNOw0KPiArCQln
b3RvIHVucmVnaXN0ZXJfZ292ZXJub3JzOw0KPiArCX0NCj4gKw0KPiArCXRoZXJtYWxfY2xhc3Mt
Pm5hbWUgPSAidGhlcm1hbCI7DQo+ICsJdGhlcm1hbF9jbGFzcy0+ZGV2X3JlbGVhc2UgPSB0aGVy
bWFsX3JlbGVhc2U7DQo+ICsNCj4gKwlyZXN1bHQgPSBjbGFzc19yZWdpc3Rlcih0aGVybWFsX2Ns
YXNzKTsNCj4gKwlpZiAocmVzdWx0KSB7DQo+ICsJCWtmcmVlKHRoZXJtYWxfY2xhc3MpOw0KPiAr
CQl0aGVybWFsX2NsYXNzID0gTlVMTDsNCj4gIAkJZ290byB1bnJlZ2lzdGVyX2dvdmVybm9yczsN
Cj4gKwl9DQo+ICANCj4gIAlyZXN1bHQgPSByZWdpc3Rlcl9wbV9ub3RpZmllcigmdGhlcm1hbF9w
bV9uYik7DQo+ICAJaWYgKHJlc3VsdCkNCj4gDQo+IA0KPiANCg==
