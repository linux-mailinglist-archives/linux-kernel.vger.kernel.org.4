Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201AD65FBA9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 08:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjAFHDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 02:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjAFHDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 02:03:22 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5256ECAA;
        Thu,  5 Jan 2023 23:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672988600; x=1704524600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QPXVuak7adx/46T3l7Mj2JMd1TNuYCUW9lxliG4R4hE=;
  b=oDeOimmXANVrJ+wVIfxE5BE+Y6aaEiX5PTmE8z69mNtY/GOz9+5IZJJ2
   E0/pr97w12Gl282zTnZvbld4gfCpOwBswoYXGRIFNiHpah4Z0AYoTOlZo
   JXUlvfN6mglQZL6CVxCjAXi+dNuERIab/DNyn+vSd34jwSiAuBNWprpgX
   cax7StzdZufLSxX1Do0tJM27Pdq8MOJGiHeSGKl+Vv5dhtsjiHIjtmBQ9
   WSfFuPXUfIwqyqToIgyv9cBKEwMy0DD9DvfSEw9TTRRUD0Z1vd+Bb+GxF
   qOphQPVpQg56izX3TBcAOiZVT8av37pQPg+2cgtbl3qiYgCHlKC25vpQg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="384728210"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="384728210"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 23:03:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="984585508"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="984585508"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jan 2023 23:03:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 23:03:18 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 23:03:18 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 23:03:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9qtKtbOD26LjvxJYjfWf9bLihCGYLAKRGrMSF+o3BLdBwjdfiNdj83uMzdrlMRDWx6qUHvDMr5ozPicZaZ7aOkyq70k7A1cpdAgn5kIm4PD/UxnPkL2/gOX3LyCNmNdcf+oTtleBmJK30kMaxQqpZgE7v3g6oJNsPq8ZRemEpBbsK9YpQZ6xInQYOwlrHbQ12XDTYnebAkUKvNpQ0NHTIhX8XdFuopjKSVfLFAuVnHjp0hIZiFKLLofIxrpW6CuA/i96WUGJVoyBj5vi+pQBcN2gnZ32yppmXw/Q5QlzJJnocGajlbK1gF6tsDJw97QbsHkRtafzfBbbMgP81R7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPXVuak7adx/46T3l7Mj2JMd1TNuYCUW9lxliG4R4hE=;
 b=Y92mw9RZvx3QKuq7zoDgy/J7xzgrdEFjy1f6l/vpn2KhCXPo3M3Oc5ydTZNiUdL/hzf4186ZCrTxZ7ljsAi1l7WhRK9ehN9LLp11X1xUrWUpLAQiwkpK+UepSD7P9dm7CwKnWrClavNRGXom9XgCMGi8fIzpIDMI7JHgjbQ6Kgu3iYF7TF0upjmyE5Gf9ywLlk6fjmtXx3fD/1onTdJBPiy+KGKQ6WQYcE/UuI06rKF1epqoeTB594tI3oj/Ae8lYoZFxFCiSEP+UO2PKyXQgIHqL3LIFKMmRvIki2X3UgSEX9snE5iG5IiVoEfKT/HetvNMMTQFwFTA/HKqPkILbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB4912.namprd11.prod.outlook.com (2603:10b6:a03:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 07:03:16 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 07:03:15 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "yang.lee@linux.alibaba.com" <yang.lee@linux.alibaba.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "abaci@linux.alibaba.com" <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] thermal: Fix unsigned comparison with less than
 zero
Thread-Topic: [PATCH -next] thermal: Fix unsigned comparison with less than
 zero
Thread-Index: AQHZIWo+Pnw57X5EWkWpsOIxe53dCK6Q9w8A
Date:   Fri, 6 Jan 2023 07:03:15 +0000
Message-ID: <057bd9fa05f1bfdf10858f23506856f6376c9f8f.camel@intel.com>
References: <20230106005951.100479-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230106005951.100479-1-yang.lee@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ0PR11MB4912:EE_
x-ms-office365-filtering-correlation-id: 0fd5e6df-4e2d-49da-e609-08daefb41574
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jtFIMVa02ktMLbD7B7/0C9I3+XdIYbcXAyQBC3NRAKdqqtPFoIqSwtqk6pvMjd+gp4ORXX796eQ8ObQr1QaWP/5SIvYeh7XIZSr1PWjXyHQBGwjD5kiRJ1JrkfxwnVjOnyYmiMe+lvb3QfrdY5+HVcb56BSnxxMe7juC/7jmtd537IAQ6pWNTtf+eO+aILFWa5SN5r19qKmwf1N8uqMQcLXHceUjsIovLaN5Vixy7J+1ZrslT9FOMcSRxISuQ60NDwVUh6OHWpQN5zeExE+eeXme9v6+9oFH01G+280K0YGiqlhEYvyV16WHtRVOH48A1lL/99IZIn0V6TUsrpPDUfjA65SzIKh37WHo7NQs1XNOfDh6eziQHrX56k0jUNLPeqvbHlIBMp2peIeCmesfh2JPFs14aN5JNdKwz7XSlzqKehXnkJhvEmqvSvaYs+qZ84vt47AoX5+2AJyDwSmdRGm7k7KAyuNbOjUG7K7k1oL79TD+KHbWf+P0YKqY5/k2r6fqDtvEYFfLJinv+t9PkRQ5KWDqKvsT6H1AD4s4D9wQG7JMb7KGRr6qJMXh77zwG2+VHtr+5vt+wZfmF6nDn8YEQw9P1Am3yxf2LytULKSWLIUUmiEUkH+eXrimVmPa4xl9ftPcdIlfNfnKIyXHZl2xnx8CVUfSwLHDf0m2hciLbuYCvjwlOUlXE+uXZFIA7YH1fkTt47LxSd+OQXSUo84sb39gDRSTduCnfK4NKOE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199015)(2616005)(83380400001)(86362001)(38070700005)(82960400001)(122000001)(38100700002)(36756003)(54906003)(316002)(2906002)(66446008)(41300700001)(91956017)(8936002)(76116006)(64756008)(66476007)(8676002)(66556008)(4326008)(5660300002)(26005)(186003)(66946007)(6512007)(6486002)(478600001)(966005)(110136005)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2g1WmorcDkyRkxLU2pNMS9lRExIaVo5eUpCcWo5ZUhIVDl2cG5FaFdpOUl4?=
 =?utf-8?B?dnJJeSthSE5oODhFK3Fkc3BldkJ3eXJoM1RFQWJ4aFVYS3pUQ0ZLZTh4NTdE?=
 =?utf-8?B?RGx6NHVoTkdCUHpSL0xoUnBwY1gwZTJ6b3pKQ1NHRFBSYXF2d1ZHWVBIWFBW?=
 =?utf-8?B?a1VST1plejVrK0ttdnVsVzVJSGhwUkk1MUVVaUVIbjVHTzBJTTBqaERaOVpu?=
 =?utf-8?B?NG5VVEFGWU1iQnpwZytoMVg3QUNrek5sWCtNeVg2VTdrQ2dsNlJLY2xIVjdY?=
 =?utf-8?B?WGM3NWxtMTVoQUZkM3E4M0lXMGRBbWthK1h6NDZZelVvU0o5aWtWOGJQdk1o?=
 =?utf-8?B?RVIyWGV0bkZCU29XSnVSdXFNMTA0WFpZRlNwd0pNbUZ6UC9Sa1lkdnZselQx?=
 =?utf-8?B?cGVjWUNvU283YjVVRjg4MFJrQkhZUGg2WEVCVlN6WHFtMU5yMnFSWWF2dWFp?=
 =?utf-8?B?TU9nR09jNEpHRFVlZ1YxNjB3VmE4aUl0eHA4clVWdW1aeldaUkQ3M2dWRmdV?=
 =?utf-8?B?MWoraDhMNTJvMHIxUjFBbVdSbHRHNVdBcUVDcFZhWGxIeE1xd3ZUUEo0Q3lJ?=
 =?utf-8?B?dytjWlo0WDlHRmJPMzJGWDBOckROTkliSWFrNXU1UGpiWmhhL2FqVWdPV0sx?=
 =?utf-8?B?ZzlJL0N1VllYdnB2blIxaVZzUEdiMEdLN0daaDljOE9lUUdqaWdnRUU4RGVM?=
 =?utf-8?B?V2RaUmlXVHV2cy9nRDZSV1o5dTFjaWZydGRyUEl1WmQ0d3E2UnpSVnNlbDJk?=
 =?utf-8?B?VXN5T3JsTmtRM2FSbksxenVSclJXck1QR01xY0c4NWdxbzltMXFHUGR4Q2gv?=
 =?utf-8?B?UHlRUnpIOFliZ1hiNnV0MjhyTjNpdmFCRXE3bEY0dm5JMi9aRE13dXdKN1hq?=
 =?utf-8?B?M3RlS0pYYnhQOCtiMVd3QmFYTG5pTkJWaDVUQUdZcUZRN2pXSzdLdzVDUTBj?=
 =?utf-8?B?eXVUMFJ5KzM0WUIvcDdmWmpPTVF6MHhaRXJrcWNsOVJMcGprSGtpaUVwTHpm?=
 =?utf-8?B?RENlL1ZTWk1tL1ltM1RZemFwVldsTXF1L0V1QlRNSXI5Nk52TkZ4dEZiZzB1?=
 =?utf-8?B?azFrVVJDejNwcXNGOUZqSFFBSlUrM1BndU1xRmw5NkVFZ1NqWUw3UU5qV3Uy?=
 =?utf-8?B?Wlh4V1NvSXJ0bVBaOVBXL3JiTmZSNGsxa0dQQjJyVCtndmQ4TmZ5VHRVcUdO?=
 =?utf-8?B?UHlMYlR4SitHQ0hubktLa0xRWHdmb3dTMmpNMENHUmdCeWRzUHhJOEVwZVhG?=
 =?utf-8?B?MHJYMnBZa1JoSlNhQk83OFdSMG1uZ0N3ZTNRWkxnek9jMkhJenZKTUYwTmR5?=
 =?utf-8?B?SmQyTkc0cHIweWZpT2dYVzBhTEo1dGhHMkFBQ1BWVDlyaGl4THlDZThYRm8r?=
 =?utf-8?B?VUt3Zm80ZjN0Wkx3N29QVlBXN2x1cTVad1NRWDl4ZnRqQUhmbmV0azhHYmd3?=
 =?utf-8?B?V0ZTKytTMjgwYURrU21wVEdxcmw2cGxDbzIxV1ZnL0tMTEFXNVRJdlgxNm9T?=
 =?utf-8?B?U2pjdGxSYllTaWZnTFBJeHlCWWFMS1Rha1FPTjBTT3I0YXE1Uk5TQVpyblhX?=
 =?utf-8?B?N3d3Sk82elVvcUpwdjZHMkJ0anNURjFFUHo0dWdaVEI1UWVBYUxSNUxHM01m?=
 =?utf-8?B?Q3F0bDJ4OG1Rek9pL3VReEZLY2Q3QVVkR1oxdktueldnR3ovSTBtVGFodWFK?=
 =?utf-8?B?dXMwOVVmT3p6SE83SDBXZWM3eWJack0zT3IxQzlibWZQMkdxa2JIRHBRTWtk?=
 =?utf-8?B?WVBVb21rY2F3TTlRSlNMQ0FZaTZ3eGxjOGt2S05wRUpBbTlMMzJwNTZWYkdZ?=
 =?utf-8?B?OUY4SFNWc1JnNEhLYWMvYlhEcjJGNlJnM0c0WEtVRUNaVU1wWGYzNHpCb0dB?=
 =?utf-8?B?T1dEb3pRd3ZKZTh5SmxQOENzVFQ5c0toN00rcWZoTk85YjRKWVhOaUJibUJD?=
 =?utf-8?B?VHlyS3NyTkVBTHFpTWJXYTNTZUxaT1FNcGFzVTNrRnpMbWdYMy9ZZ3FvZ2Uw?=
 =?utf-8?B?Z2F3RVhDQjVIN3ptcjFSTndteXB1WWxFTStuWXJ0VzczclBRT0FPVDhYYThw?=
 =?utf-8?B?SzJZSnkvTjFCS0VXL0p1NzludHBNb3pBMmpJVytRaVhZY2JDYk5xejNKdHUw?=
 =?utf-8?B?S1BPNm1sY3NkbUc1c21lRThNb0cyN0dNVlNtM0hWekF0NXc5WmFpeUFqampI?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1617943B5EA12F409A42EFCE2829E33F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd5e6df-4e2d-49da-e609-08daefb41574
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 07:03:15.9324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIanAfh3uv9k23CMiXYTXDdlLKWJC21Jeh3cV/edUO/EevGW1SZ24GpPFQ3GaLXDnadEo5K2zuqgS2YYI7PRug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4912
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTA2IGF0IDA4OjU5ICswODAwLCBZYW5nIExpIHdyb3RlOg0KPiBUaGUg
cmV0dXJuIHZhbHVlIGZyb20gdGhlIGNhbGwgdG8gaW50ZWxfdGNjX2dldF90am1heCgpIGlzIGlu
dCwgd2hpY2gNCj4gY2FuIA0KPiBiZSBhIG5lZ2F0aXZlIGVycm9yIGNvZGUuIEhvd2V2ZXIsIHRo
ZSByZXR1cm4gdmFsdWUgaXMgYmVpbmcgYXNzaWduZWQNCj4gdG8gDQo+IGFuIHUzMiB2YXJpYWJs
ZSAndGpfbWF4Jywgc28gbWFraW5nICd0al9tYXgnIGFuIGludC4NCj4gDQo+IEVsaW1pbmF0ZSB0
aGUgZm9sbG93aW5nIHdhcm5pbmc6DQo+IC4vZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3Nv
Y19kdHNfaW9zZi5jOjM5NDo1LTExOiBXQVJOSU5HOg0KPiBVbnNpZ25lZCBleHByZXNzaW9uIGNv
bXBhcmVkIHdpdGggemVybzogdGpfbWF4IDwgMA0KPiANCj4gTGluazogaHR0cHM6Ly9idWd6aWxs
YS5vcGVuYW5vbGlzLmNuL3Nob3dfYnVnLmNnaT9pZD0zNjM3DQo+IFJlcG9ydGVkLWJ5OiBBYmFj
aSBSb2JvdCA8YWJhY2lAbGludXguYWxpYmFiYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFlhbmcg
TGkgPHlhbmcubGVlQGxpbnV4LmFsaWJhYmEuY29tPg0KDQpUaGFua3MgZm9yIGNhdGNoaW5nIHRo
aXMgaXNzdWUuDQoNCkFja2VkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQoN
CnRoYW5rcywNCnJ1aQ0KDQo+IC0tLQ0KPiAgZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3Nv
Y19kdHNfaW9zZi5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL2ludGVsL2lu
dGVsX3NvY19kdHNfaW9zZi5jDQo+IGIvZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3NvY19k
dHNfaW9zZi5jDQo+IGluZGV4IDIxMzg2OTNkOGFmZC4uOGMyNmY3YjIzMTZiIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfc29jX2R0c19pb3NmLmMNCj4gKysrIGIv
ZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3NvY19kdHNfaW9zZi5jDQo+IEBAIC0zODAsNyAr
MzgwLDcgQEAgc3RydWN0IGludGVsX3NvY19kdHNfc2Vuc29ycw0KPiAqaW50ZWxfc29jX2R0c19p
b3NmX2luaXQoDQo+ICB7DQo+ICAJc3RydWN0IGludGVsX3NvY19kdHNfc2Vuc29ycyAqc2Vuc29y
czsNCj4gIAlib29sIG5vdGlmaWNhdGlvbjsNCj4gLQl1MzIgdGpfbWF4Ow0KPiArCWludCB0al9t
YXg7DQo+ICAJaW50IHJldDsNCj4gIAlpbnQgaTsNCj4gIA0K
