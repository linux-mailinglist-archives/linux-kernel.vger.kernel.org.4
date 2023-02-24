Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04056A1546
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 04:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjBXDWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 22:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXDWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:22:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034D03E626;
        Thu, 23 Feb 2023 19:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677208940; x=1708744940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+8F5yTmKWmInfd/il/M/MNaIUnFZNEVivV8N+ED8MK0=;
  b=LHc1ArvOZqSBk+LukLEDiWz3ajT7lBvv46wnbCh3ua4+Vkno5QA7bpKv
   ycNFu75EFyvY1Ueny6CqxXME1+wtWMpE7ii02tRf6fM8NK4eaV3fUwbWg
   iZzQFIH0Sy9uqEhDyRUBaXfnj9bW5unT+YvgFJW4RQTObUhlGFaS2ks6l
   U6tGXKADMQnKQc32h8X+qMLttxT7axSn07wsbEleO3VgWZ1aJtLJtYzJe
   bznVNKUZSKqCX9r/eCFWVYVvvHropEKmRrVMvhKOIpOs7R2JMBrdtiGXJ
   qqMMHGizJKLBiH+M51TadzIsvLMWTQAL/Q2Y2Dbi9apIt9yBxKYve6EIi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="331119176"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="331119176"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 19:22:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="703046431"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="703046431"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 23 Feb 2023 19:22:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 19:22:18 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 19:22:18 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 19:22:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdnVTCd8dKSiH9YE+gw/6+lfvrWGX6/Xvscol7XyMdT6Aty/oos1tXGjmK6K8C988nAwuhA6VaSfT+Uqsmc1QSZIh/bf9etQnYPLh5pV3wsXicbsNseaLJBSQ7rHBHFeIJ9lPEnbikpcPEGJwT6Iuz7m2G8PR3DpyrNOPK0x2b+j0/HxIh8z3yJGxEPirXX8aNqIq1hGtEXGRm1odj/2uIMYeqTqx2/6H5K1yxeX0cOdy8umqlI9c99BGSre8y74MWGcRYRIVET5pedJsKeXrVF7uhzJz1ubAlFY0GjBvrx7rPH/R1Qtfu94zN9mGKShbUGSkJyQWZjG5aaGRZCBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8F5yTmKWmInfd/il/M/MNaIUnFZNEVivV8N+ED8MK0=;
 b=Hd6gyXZBXa+YANjxt2FBJa8jB+8l4iCLHleykxKuVilcHy6OL7+wdmJ96njnfYVqlzTlhBgPF8AMhFCTjkgDf0wtTDT1zywBi2JEJgpJTmKJA44iX+j08h/pqUJVZaR4Bq+k1sPLJwdDetTfBn6N/HrPOcHzgFPFhKc97gSi/Q/Y5LcZOk7RA2N8ZUoRheBIKKfYa4oZCLi7TfcydrMqvxseDEqWzToWjrIs7A56f8LWU8/cpw9jGxJnqnuLzpmKlK6UHBLFRYDe0hUcQzsDyUptDp0zaiq1Bh2CM88MqqYIOL2c1AzVwf7PJh/FKdxKeOMTylIECy/HYntbwg13EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DS0PR11MB8183.namprd11.prod.outlook.com (2603:10b6:8:161::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Fri, 24 Feb
 2023 03:22:16 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%4]) with mapi id 15.20.6111.018; Fri, 24 Feb 2023
 03:22:16 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
 call_rcu_tasks_generic()
Thread-Topic: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
 call_rcu_tasks_generic()
Thread-Index: AQHZR0+ogcttGObez02wrCHslcltHq7cNR4AgAAAcHCAAH5tAIAAi3SAgAAgZICAAALLgIAAAHkAgAADrTCAAAYMAIAAAOsQ
Date:   Fri, 24 Feb 2023 03:22:16 +0000
Message-ID: <PH0PR11MB58805DC495967F99AC133440DAA89@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230223063022.2592212-1-qiang1.zhang@intel.com>
 <IA1PR11MB6171F5F6B525B6C599024C9D89AB9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <PH0PR11MB588084641FFB675A102BA503DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Y/eP4h/chB8J0rAj@google.com>
 <PH0PR11MB58801B94B0374865394E9F8FDAA89@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Y/ggCdoMEhMO8vs+@google.com>
 <CAEXW_YRTOYu5ZR6aX7AaTGyCQJwjB2aEmuPMYExYD4A2csRP1w@mail.gmail.com>
 <CAEXW_YRH2amT0K3f9c4tEzXZ46GsKHwGkjaznPrH5EOL4ay+dg@mail.gmail.com>
 <PH0PR11MB588021890119CA76AA5BB848DAA89@PH0PR11MB5880.namprd11.prod.outlook.com>
 <CAEXW_YSbUzqBCQXHPF0zF67B8+mwTNojC38K6rx3=0+Jzurjzg@mail.gmail.com>
In-Reply-To: <CAEXW_YSbUzqBCQXHPF0zF67B8+mwTNojC38K6rx3=0+Jzurjzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DS0PR11MB8183:EE_
x-ms-office365-filtering-correlation-id: c1f0ded0-1c69-4997-5219-08db16165474
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nBi2SR4H9JCgvyxoAtrz1u0MeAoS+v8xcUpGDJgSy6ojAd5Av+35kUf7QsbulXmbQdPPMDz0J+F+gualBw1McPnJDrcOFWCmd1qK3qqWvk8XXoh0MsIEYJhAY445zjddfvc842WhazRt33tW6RqZLQts7usqhPTlru48OdEcq4odA/GdqDaxzqNW6E6Ya+cOqaU+DPA15oIlpsdsqgdGb48rhHtiMnXJDvIQ2sj/YQEpDflFtkvcZcAHp+BlviVgr7jyYMqEH7WdmFpQXndAST12uajftwcAR7pgFXVynmPTBWs2ZSE+gHn0/ml3gt9xDEx5N5KHeacc41L2/t9P19necEwO0ysnW4jrMB0nDPcaNMasNzMP2SWOrbWBh5Ms2GkGUDCIoNUpfYqeQxUY23KoFp3466gqGR9W2ub+rHau7O5spC3shQEI4J9tfXRf8FIP10oGLYh6QFA0V9WB3r2zgBmvUjhrlCgkQAx9VHhvE8ABmvVWS9sbY3xdsxzk9KyhipewVsBL3VBpV9wUTZfv66dkH9F/vECFAQtPNseDnKXyzYbw8NnYCQia+32FdwikpUXkdxRMGGpR9WfYq9Afxm4jmjlsN8IFhiKPjLIa+KIEf0YGmVw4RN8Ifm7BxJST0Tji6FXSr7IVXXQgXRgCDK0h2U9xcIZhWXBHqqQs1jylvzx7BQA0d2VdziQxxFAU0z4eRvJXaxZSBLRSWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199018)(122000001)(966005)(7696005)(86362001)(316002)(66946007)(54906003)(71200400001)(26005)(66476007)(64756008)(186003)(66556008)(66446008)(8676002)(6506007)(478600001)(33656002)(6916009)(4326008)(76116006)(9686003)(55016003)(53546011)(38070700005)(52536014)(8936002)(5660300002)(41300700001)(82960400001)(38100700002)(83380400001)(2906002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXJQQ09IUk5RczQvQU50YXZNWjFrSnJGYnNZUUFHZ1lvT1l4R2U2K3dxWkts?=
 =?utf-8?B?b0FzOEdBNmpnQW5ZeWo2Q0d3N2RpSzhwREN4UDQ0MDNuNjg2R0ZFTStFZWhl?=
 =?utf-8?B?RkdBSGJHdVFKand5cUs2OHhBUGZ1VGtvQ2k0UGNqbTBxSUxEc2l1WDBoUGw4?=
 =?utf-8?B?VVlFSnRzNVFLUnNDbVdWQU41dWJvNnU4S0JjSkE4L3RlQWFKckNKU1hTWnQ2?=
 =?utf-8?B?WmV0cFhKS1h2SEd5VDI3blVWRnZXcURtSUJKVGxMWEVpdTFlM0pDK24rRS81?=
 =?utf-8?B?aU85c2xxaktad2RUbmV3dlRSN2plUVFXV25IYjQ3UWgzaU5xRndyL3RzN0tQ?=
 =?utf-8?B?Z1FIbCtQWjBiMnBrRnd5NGZOVlludDZOcFR6WkRWVWp5NmtVbVJmTnMvcFJE?=
 =?utf-8?B?c0RRRjRoSFpIQ2FjdXdDVWZVaU9NVDN6K09PdDNTWXc4b0ZIOHlXbXFBamFT?=
 =?utf-8?B?dDZKZUJmZWlMYXdaRU9xdzNXcjlrVTdpdytGQVhkRTZmckxMNkRZUU9kT0Uy?=
 =?utf-8?B?anRFVnhRSnkrYzVXZ3FuQWhyY05HRWZBRTR2ejNnWkVsREFiNHFoSm9YSHZD?=
 =?utf-8?B?VjR1dS9jUjJBa1ZLcWd1ZHdnWjUvSDJ6K055MmFsb014bEVENmtKWXgvem1O?=
 =?utf-8?B?L3lrNnZqSFQ0OG5talQ3K3FuNklsMTZCdXVXK3A3dW9XTXhxZjJmWUhmMkNY?=
 =?utf-8?B?NDFySXhJc3F5aEIyVVRnUnpMYzBoQzFONUd0TlUvVlhTL3pBUzQ4Y2pvRXpu?=
 =?utf-8?B?VDVkdkpjMGpmWU9IQVVRaTBEZXk3S1RqRml3ZEY2UkZLY2V0TUtqbXRidXhq?=
 =?utf-8?B?Y2dadUZnZUJmbTdwMk5rN1hNeThGbzhaTERjR3FLRUtBRkVrWUxDY05yV1Rm?=
 =?utf-8?B?RUVBRGJzT1JGbFpnRVlieDVJdVJTckl3TjUvK3pPaDBOS1VnaG9MOUhXdHZj?=
 =?utf-8?B?WnF0SzlZZHYwemJUVUl2MlNuNUdqdG5PZG9MbUsrRjNTeDdSRlFHdjI2VDZE?=
 =?utf-8?B?Z1FuS3I0THJYa3BYMEI2bmtBbk1reThxM2IxU3FzdDlPVlgybFdRcXh1ckpj?=
 =?utf-8?B?aE45ZERRd1ExZXhJSXd5c3V2SEZjbk5zK3dMWWpaM1czcDArQi9uNWlIdis4?=
 =?utf-8?B?aC9CVjlhMjRqSmlwYkFHL0Z1dUVCNWdZVVkvQkFPOGFyMGNTcm9mNDY2YTBG?=
 =?utf-8?B?bmtxL05ud3dnenp0KzJsZzlGT1oyYW1JcSttSDNDUnEwa1RGM2krcmxwQjhZ?=
 =?utf-8?B?aDlsZ3RwK3RQdVhIRFRKMFlJK3dUZVpEZVFSZ1RrelJtYURGTWNWVmNwS0Rx?=
 =?utf-8?B?Y0VvQzVhSkxlSkVrVWNWN0k2Mjl1eHpFR25wVFpUTVkzcDRtV1Y3ZW9PT3Za?=
 =?utf-8?B?T3BzMU5tYTM0MzFJODltandMTHpTYnlSRHBWdHhKRjk0WHBKSGs1aG9QNG5O?=
 =?utf-8?B?N0kxcisvcXRBMlpId2pBN2htY0RPbWo5SHpmSFZGb01mYXJJcnZDZ2hUWG9a?=
 =?utf-8?B?SkhrR0s5NlFZbi91cU0yY2IwV1RsYnRjU0RGWlRNSlJhTHpNV3JuVFFrQUZi?=
 =?utf-8?B?a1BPNnlzbmU4VHBBVFRoRXVvUTA1aGxBaS8yNXpFdzN0d1JUaklwQ0V5bWtK?=
 =?utf-8?B?OFhYMVVDY1c2UFZWYVM4SUlpeVE2S3BqZHgydmVRNTFEK0RCYWRBU1J3MnFp?=
 =?utf-8?B?WEJpa1BQanVnVmJ1MkwvdElsajFGY0NtY0tScFFrNzVRci94NTUyeGlZcU83?=
 =?utf-8?B?S01XdGx2Tk5XTkJ5ODJ6aC8wYk9CME1DMFFkbHJhZnQ2ZzhiSlNydHE2dmx3?=
 =?utf-8?B?WDZVejVZcjA0ejVRSDBORTNnYWN2SVRRcG5oRXdJcDdkTzRUVUF6YXlmenpC?=
 =?utf-8?B?VGlQZnNUVXQyTVlWMWdKc0t6c01wa2JOVjEvcGZIeklsQ3lOMnhwOWVjc05q?=
 =?utf-8?B?blNwNXNpay9kT2daMFo4V1J2cXJnNjc1VHRrSHZvTTh6NzUwV0RRTHZTTmNG?=
 =?utf-8?B?OUo2aFR2SEQzSkJWZW94NWltSlNRTGlINno5SzVOaGs2Ri9icmdEcldHWHpP?=
 =?utf-8?B?WW41cFhVbWxCSm5WdjlwejRJblVkc1AxUjF1ZzIzR2ZudmcvYkhOOWIwTFVN?=
 =?utf-8?Q?TnS8h5b/dWavQ1LgLLRS3atWd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f0ded0-1c69-4997-5219-08db16165474
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 03:22:16.4745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x59N/uQJLmIjAelSPtia+OntyixR7f2m/zrLks3RmNyYmI6EfEUgqVEatDppspAeEjTqwvz4zAqp+5A21Mbryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8183
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLACK autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBGZWIgMjMsIDIwMjMgYXQgMTA6MDUgUE0gWmhhbmcsIFFpYW5nMSA8cWlhbmcxLnpo
YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+DQo+IE9uIFRodSwgRmViIDIzLCAyMDIzIGF0IDk6MzUg
UE0gSm9lbCBGZXJuYW5kZXMgPGpvZWxAam9lbGZlcm5hbmRlcy5vcmc+IHdyb3RlOg0KPiA+DQo+
ID4gT24gVGh1LCBGZWIgMjMsIDIwMjMgYXQgOToyNSBQTSBKb2VsIEZlcm5hbmRlcyA8am9lbEBq
b2VsZmVybmFuZGVzLm9yZz4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gT24gRnJpLCBGZWIgMjQsIDIw
MjMgYXQgMTI6MzY6MDVBTSArMDAwMCwgWmhhbmcsIFFpYW5nMSB3cm90ZToNCj4gPiA+ID4gT24g
VGh1LCBGZWIgMjMsIDIwMjMgYXQgMDg6NDM6MDVBTSArMDAwMCwgWmhhbmcsIFFpYW5nMSB3cm90
ZToNCj4gPiA+ID4gPiA+IEZyb206IFpxaWFuZyA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCj4g
PiA+ID4gPiA+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAyMywgMjAyMyAyOjMwIFBNDQo+ID4g
PiA+ID4gPiBUbzogcGF1bG1ja0BrZXJuZWwub3JnOyBmcmVkZXJpY0BrZXJuZWwub3JnOyBxdWlj
X25lZXJhanVAcXVpY2luYy5jb207DQo+ID4gPiA+ID4gPiBqb2VsQGpvZWxmZXJuYW5kZXMub3Jn
DQo+ID4gPiA+ID4gPiBDYzogcmN1QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiA+ID4gPiA+ID4gU3ViamVjdDogW1BBVENIXSByY3UtdGFza3M6IERpcmVj
dGx5IGludm9rZSByY3V3YWl0X3dha2VfdXAoKSBpbg0KPiA+ID4gPiA+ID4gY2FsbF9yY3VfdGFz
a3NfZ2VuZXJpYygpDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQWNjb3JkaW5nIHRvIGNvbW1p
dCAnMzA2M2IzM2EzNDdjICgiQXZvaWQgcmF3LXNwaW5sb2NrZWQgd2FrZXVwcyBmcm9tDQo+ID4g
PiA+ID4gPiBjYWxsX3JjdV90YXNrc19nZW5lcmljKCkiKScsIHRoZSBncmFjZS1wZXJpb2Qga3Ro
cmVhZCBpcyBkZWxheWVkIHRvIHdha2V1cA0KPiA+ID4gPiA+ID4gdXNpbmcgaXJxX3dvcmtfcXVl
dWUoKSBpcyBiZWNhdXNlIGlmIHRoZSBjYWxsZXIgb2YNCj4gPiA+ID4gPiA+IGNhbGxfcmN1X3Rh
c2tzX2dlbmVyaWMoKSBob2xkcyBhIHJhdyBzcGlubG9jaywgd2hlbiB0aGUga2VybmVsIGlzIGJ1
aWx0IHdpdGgNCj4gPiA+ID4gPiA+IENPTkZJR19QUk9WRV9SQVdfTE9DS19ORVNUSU5HPXksIGR1
ZSB0byBhIHNwaW5sb2NrIHdpbGwgYmUgaG9sZCBpbg0KPiA+ID4gPiA+ID4gd2FrZV91cCgpLCBz
byB0aGUgbG9ja2RlcCBzcGxhdHMgd2lsbCBoYXBwZW4uIGJ1dCBub3cgdXNpbmcNCj4gPiA+ID4g
PiA+IHJjdXdhaXRfd2FrZV91cCgpIHRvIHdha2V1cCBncmFjZS1wZXJpb2Qga3RocmVhZCBpbnN0
ZWFkIG9mIHdha2VfdXAoKSwgaW4NCj4gPiA+ID4gPiA+IHJjdXdhaXRfd2FrZV91cCgpIG5vIHNw
aW5sb2NrIHdpbGwgYmUgYWNxdWlyZWQsIHNvIHRoaXMgY29tbWl0IHJlbW92ZSB1c2luZw0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+VGhlcmUgYXJlIHN0aWxsIHNwaW5sb2NrLWFjcXVpc2l0aW9u
IGFuZCBzcGlubG9jay1yZWxlYXNlIGludm9jYXRpb25zIHdpdGhpbiB0aGUgY2FsbCBwYXRoIGZy
b20gcmN1d2FpdF93YWtlX3VwKCkuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID5yY3V3YWl0X3dh
a2VfdXAoKSAtPiB3YWtlX3VwX3Byb2Nlc3MoKSAtPiB0cnlfdG9fd2FrZV91cCgpLCB0aGVuOg0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAgIHJhd19zcGluX2xvY2tfaXJxc2F2ZSgpDQo+ID4g
PiA+ID4gPiAgICAuLi4NCj4gPiA+ID4gPiA+ICAgIHJhd19zcGluX3VubG9ja19pcnFyZXN0b3Jl
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBZZXMsIGJ1dCB0aGlzIGlzIHJhd19zcGlubG9jayBhY3F1
aXNpdGlvbiBhbmQgcmVsZWFzZShub3RlOiBzcGlubG9jayB3aWxsIGNvbnZlcnQgdG8NCj4gPiA+
ID4gPiBzbGVlcGFibGUgbG9jayBpbiBQcmVlbXB0LVJUIGtlcm5lbCwgYnV0IHJhdyBzcGlubG9j
ayBpcyBub3QgY2hhbmdlKS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGFjcXVpcmUgcmF3X3NwaW5s
b2NrIC0+IGFjcXVpcmUgc3BpbmxvY2sgIHdpbGwgdHJpZ2dlciBsb2NrZGVwIHdhcm5pbmcuDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPklzIHRoaXMgcmVhbGx5IHNhZmUgaW4gdGhlIGxvbmcgcnVuIHRo
b3VnaD8gSSBzZWVtIHRvIHJlbWVtYmVyIHRoZXJlIGFyZQ0KPiA+ID4gPiA+d2VpcmQgbG9ja2lu
ZyBkZXBlbmRlbmNpZXMgaWYgUkNVIGlzIHVzZWQgZnJvbSB3aXRoaW4gdGhlIHNjaGVkdWxlciBb
MV0uDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gSSBoYXZlICBiZWVuIHJ1
bm5pbmcgcmN1dG9ydHVyZSB3aXRoIHJjdXRvcnR1cmUudHlwZSA9IHRhc2tzLXRyYWNpbmcsDQo+
ID4gPiA+IHNvIGZhciBubyBwcm9ibGVtcyBoYXZlIGJlZW4gZm91bmQuDQo+ID4gPiA+DQo+ID4g
PiA+DQo+ID4gPiA+ID5JIHByZWZlciB0byBrZWVwIGl0IGFzIGlycV93b3JrX3F1ZXVlKCkgdW5s
ZXNzIHlvdSBhcmUgc2VlaW5nIHNvbWUgYmVuZWZpdC4NCj4gPiA+ID4gPkdlbmVyYWxseSwgdGhl
cmUgaGFzIHRvIGJlIGEgJ3dpbicgb3Igb3RoZXIganVzdGlmaWNhdGlvbiBmb3IgYWRkaW5nIG1v
cmUNCj4gPiA+ID4gPnJpc2suDQo+ID4gPiA+ID4NCj4gPiA+ID4gPnRoYW5rcywNCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+LSBKb2VsDQo+ID4gPiA+ID5bMV0gaHR0cDovL3d3dy5qb2VsZmVybmFuZGVz
Lm9yZy9yY3Uvc2NoZWR1bGVyL2xvY2tpbmcvMjAxOS8wOS8wMi9yY3Utc2NoZWRsb2Nrcy5odG1s
DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBwcm9ibGVtIGluIHRoaXMgbGluaywgIGlu
IGFuIGVhcmxpZXIgUkNVIHZlcnNpb24sIHJjdV9yZWFkX3VubG9ja19zcGVjaWFsKCkNCj4gPiA+
ID4gSW52b2tlIHdha2V1cCBhbmQgZW50ZXIgc2NoZWR1bGVyIGNhbiBsZWFkIHRvIGRlYWRsb2Nr
LCBidXQgbXkgbW9kaWZpY2F0aW9uIGlzIGZvcg0KPiA+ID4gPiBjYWxsX3JjdV90YXNrc19nZW5l
cmljKCksIGV2ZW4gaWYgdGhlcmUgaXMgYSBsb2NrIGRlcGVuZGVuY3kgcHJvYmxlbSwgd2Ugc2hv
dWxkIHBheQ0KPiA+ID4gPiBtb3JlIGF0dGVudGlvbiB0byByY3VfcmVhZF91bmxvY2tfdHJhY2Vf
c3BlY2lhbCgpDQo+ID4gPg0KPiA+ID4gQ29uc2lkZXIgQUJCQSBkZWFkbG9ja3MgYXMgd2VsbCwg
bm90IGp1c3Qgc2VsZi1kZWFkbG9ja3MgKHdoaWNoIElJUkMgaXMgd2hhdA0KPiA+ID4gdGhlIHN0
cmFpZ2h0LVJDVSByY3VfcmVhZF91bmxvY2soKSBpc3N1ZXMgd2VyZSBhYm91dCkuDQo+ID4gPg0K
PiA+ID4gV2hhdCBwcmV2ZW50cyB0aGUgZm9sbG93aW5nIHNjZW5hcmlvPw0KPiA+ID4NCj4gPiA+
IEluIHRoZSBzY2hlZHVsZXIgeW91IGhhdmUgY29kZSBsaWtlIHRoaXM6DQo+ID4gPiAgICAgICAg
ICAgICAgICAgcnEgPSB0YXNrX3JxX2xvY2socCwgJnJmKTsNCj4gPiA+ICAgICAgICAgICAgICAg
ICB0cmFjZV9zY2hlZF93YWl0X3Rhc2socCk7DQo+ID4gPg0KPiA+ID4gU29tZW9uZSBjYW4gaG9v
ayB1cCBhIEJQRiBwcm9ncmFtIHRvIHRoYXQgdHJhY2Vwb2ludCB0aGF0IHRoZW4gY2FsbHMNCj4g
PiA+IHJjdV9yZWFkX3VubG9ja190cmFjZSgpIC0+IHJjdV9yZWFkX3VubG9ja190cmFjZV9zcGVj
aWFsKCkuIEFsbCBvZg0KPiA+ID4gdGhpcyB3aGlsZSBob2xkaW5nIHRoZSBycSBhbmQgcGkgc2No
ZWR1bGVyIGxvY2tzLg0KPiA+ID4NCj4gPiA+IFRoYXQncyBBIChycSBsb2NrKSAtPiBCIChydHBj
cCBsb2NrKS4NCj4NCj4gSW4gcmN1X3JlYWRfdW5sb2NrX3RyYWNlX3NwZWNpYWwoKSwgdGhlIHBy
ZW1pc2Ugb2YgYWNxdWlyaW5nIHRoZSBydHBjcCBsb2NrIGlzIHRoYXQNCj4gYmVmb3JlIHRoYXQs
IHdlIGhhdmUgdGFzayBzd2l0Y2ggaW4gdGhlIHJjdV9yZWFkX2xvY2tfdHJhY2UvdW5sb2NrX3Ry
YWNlIGNyaXRpY2FsIHNlY3Rpb24uDQo+IGJ1dCBhZnRlciB3ZSBhbHJlYWR5IGhvbGQgdGhlIHJx
IGxvY2ssIG5vIHRhc2sgc3dpdGNoIGlzIGdlbmVyYXRlZCBpbiB0aGUNCj4gcmN1X3JlYWRfbG9j
a190cmFjZS91bmxvY2tfdHJhY2UgIGNyaXRpY2FsIHNlY3Rpb24uDQo+DQo+IFBsZWFzZSBjb3Jy
ZWN0IG1lIGlmIG15IHVuZGVyc3RhbmRpbmcgaXMgd3JvbmcuDQo+DQo+WWVzLCBidXQgaW4gdGhl
IG5leHQgcmVwbHkgSSBjb3JyZWN0ZWQgbXlzZWxmIGFuZCBJIGFtIHN0aWxsIGNvbmNlcm5lZA0K
PmFib3V0IEFCQkEuIFRoZXJlIGlzIG9idmlvdXNseSAqc29tZSBsb2NrKiB0aGF0IGlzIGhlbGQg
YnkgdGhlIGNhbGxlcnMNCj5vZiBjYWxsX3JjdV90YXNrcyooKS4gU28gdGhlcmUgaXMgYSBkZXBl
bmRlbmN5IHRoYXQgZ2V0cyBjcmVhdGVkDQo+YmV0d2VlbiBfdGhhdF8gbG9jayBhbmQgdGhlIHJx
IGxvY2ssIGlmIHlvdSBkbyBhIHdha2V1cCBoZXJlLiAgQW5kIEkNCj5hbSBub3Qgc3VyZSB3aGV0
aGVyIHRoYXQgbG9jayBpcyBhbHNvIGFjcXVpcmVkIHdoZW4gdGhlIEJQRiBwcm9ncmFtDQo+cnVu
cy4gSWYgaXQgaXMsIHRoZW4gdGhlIEJQRiBwcm9ncmFtcyBtYXkgaGFuZy4gSXQgaXMgcHJvYmFi
bHkgd29ydGgNCj5jaGVja2luZyB3aXRoIHRoZSBCUEYgZ3V5cy4NCj4NCj5Nb3JlIGltcG9ydGFu
dGx5LCBkbyB5b3Ugc2VlIGEgYmVuZWZpdCB3aXRoIHRoaXMgY2hhbmdlIGluIHRlcm1zIG9mDQo+
YW55dGhpbmcgbW9yZSB0aGFuIGRlbGV0aW5nIGEgZmV3IGxpbmVzIG9mIGNvZGU/IFBhdWwgdHlw
aWNhbGx5IGZhdm9ycw0KPnJvYnVzdG5lc3MgYW5kIGd1YXJkIHJhaWxzIChhcyBkbyBJKSwgdW5s
ZXNzIHRoZXJlIGlzIHNpZ25pZmljYW50DQo+YmVuZWZpdCBpbiBwZXJmb3JtYW5jZSwgcG93ZXIg
b3IgYm90aC4NCg0KYmVjYXVzZSBJIGZvdW5kIHRoYXQgdGhlIHB1cnBvc2Ugb2YgdXNpbmcgaXJx
X3dvcmtfcXVldWUoKSBlYXJseSBpcyB0byBzb2x2ZSB0aGUgcHJvYmxlbSBvZiBsb2NrZXAgc3Bs
YXQsDQpteSBtb2RpZmllZCBqdW5pb3IgaXMgYWxzbyB0byBhdm9pZCB1bm5lY2Vzc2FyeSBJUEku
ICBidXQgbGlrZSB5b3Ugc2FpZCwgaW5kZWVkIHdlIGFyZSBub3QgY29tcGxldGVseSBzdXJlDQp3
aGV0aGVyIHRoZXJlIGlzIGEgcG90ZW50aWFsIGxvY2sgZGVwZW5kZW5jeSBwcm9ibGVtLCBzbyBJ
IGFncmVlIHlvdXIgb3Bpbmlvbi4NCg0KVGhhbmtzDQpacWlhbmcNCg0KPg0KPlRoYW5rcywNCj4N
Cj4gLSBKb2VsDQo=
