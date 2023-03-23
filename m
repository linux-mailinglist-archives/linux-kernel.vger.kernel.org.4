Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2656C6A86
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjCWOQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjCWOQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:16:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258BC26C32
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679580969; x=1711116969;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f/SaY/pxaXWOlIo+28khuzbBjLS9VJOnCI8Xt99FCY8=;
  b=U9v5cYnF0CR7AlOtY6LUBDvOIuPNy4ItkeR33w/hmpntgFn4i6lreCCa
   W/gM3p2rJY+NBvsVOIOdsAo8FkTvTQ6cURS29jWdg75qvbk9hZzy1sMOj
   6Fh1l600MLPdV8Y1UMSmMAMewobr/9qByG265XIMqI/LXXG0eb1YRnELb
   FwsTxsiUEpZwvobiXihiUbIzDR5qW+pTw7yivRAKILlDlHXGEilyvmPkc
   A47CrQbdao6L3xTAQ6APS7Vkco1ItKpFNXc6Cz2YuqLAXiFCbqf8PjhNF
   tanzWWgq12J5a4HDWcDdvWL0zzknIku54iUdOJ165pwifloqJYNF5c4aw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="339533274"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="339533274"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 07:15:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="928249579"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="928249579"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 23 Mar 2023 07:15:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 07:15:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 07:15:54 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 07:15:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V31mdXhOD53JqST9gMg3G9YDHPYGvV6asxqTvuhqqLuCuI9K850Lq8WWGmyWdavL54kcg1rlEDsb+iXTQfywnHp1QlL8o6QjiSIlQP9OxsVBKmEvzw7OcZltftbSTxTnYQQzBDKe4iflCKYvoDxCBaeRkx790uhbHW1pbvU5BPCI1/Wbv6WZpRRA8EDdkeNty97q1tIGKUFP89FuRS6RhjAKTIwMkMxX8PYcdN+DZ7zrm7WTGlxle5QfjzKc2/Mvf+0va7OZxpEdNbDK5K9Lp8vHA5e7qlLBASz2oYcnN6H7KRHXRUdFnScf0ZdO+CxBOLid104l11zc9nrlxBpLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/SaY/pxaXWOlIo+28khuzbBjLS9VJOnCI8Xt99FCY8=;
 b=e65XAoqsO+1Ok7iXw/Q/tq9VmwAlm8GIUzqYqubr9wNxdXsOgPyatooWyU8fIuNyvxACbd90tZ1WnxYR/GuARk0Zuf5nqdI4WRMuF26+kc7ap1IAAHtsDc03iGD7TJfdERlbmpvp0FRheaHmImlR6ZIczK8nrkwkzivf7SzbQrbGW83kBS0TT4bu5U3fKKVhFxEFmPZAjdj3URl8PmP6nuCf0QifZ9rRRbOo/sJZR3EJmpaUIVMQ5DCs/4coJsYDzUz/mM69zJ21fIJy0v05E+oTyeIwHMKFL8V+zmNTkuViKUa2bBZeD/cvBRnNEqB6AHBjegkLf+1OZ1dzLIPTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4074.namprd11.prod.outlook.com (2603:10b6:5:5::11) by
 SJ2PR11MB8372.namprd11.prod.outlook.com (2603:10b6:a03:539::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 14:15:51 +0000
Received: from DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::f82f:459:5631:aa91]) by DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::f82f:459:5631:aa91%5]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 14:15:51 +0000
From:   "Liao, Bard" <bard.liao@intel.com>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "vinod.koul@linaro.org" <vinod.koul@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "tiwai@suse.de" <tiwai@suse.de>
Subject: RE: [PATCH 00/20] ASoC/soundwire: add support for ACE2.x
Thread-Topic: [PATCH 00/20] ASoC/soundwire: add support for ACE2.x
Thread-Index: AQHZXUiBJ805Dv0wiEizwjc45wToza8IaMlA
Date:   Thu, 23 Mar 2023 14:15:51 +0000
Message-ID: <DM6PR11MB407447CB33FF414DC081AA2FFF879@DM6PR11MB4074.namprd11.prod.outlook.com>
References: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
In-Reply-To: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4074:EE_|SJ2PR11MB8372:EE_
x-ms-office365-filtering-correlation-id: ab38ba10-8460-4cc9-060b-08db2ba91b67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1hs7ePM7h19WV7doh/W61Q0ewMiclEz44N+x2VJs0bNTCa98Gl6GMl0zzq4wyhrnjV5GVTUzX+1QA7n89m4T7y0iJmXRkahMgt8urtAvj3XqBom6zxeoD8RHGof2ysxAeqnk/hWjU2zFhSOlGJvqZHbluHvUhxPXnxUzgIWeNFtEKxjrn8dSbElkB85hMjEs7zhL+xdsogFIGNK6yeoYQGNau3XtFa0cNuf4V6/zxyOl2RQ5zVktZWdzFM2dIffaMsTHo79yFpNQaZ+RwFxROzvW8Z+X2lja6kksx3FKP6zvFJR3nVe6Lluz84zIXGRbPOMekueBZAAxBnWA5nY02HIddW9s5/FpkF8ZL8aRuqN/gJqM3bhsmJka4b3g23P60tHcBlCHab6yOw+m/QE2N7iEjcesoh4BhKTyIVFYHgfD1FmFori89cJ0JYVIcy8HuCcsETSTWNoIjDVpkOMNBoQ033Q9Wgrbmvsmj/zG16sR2zcDeRiNCocxDs0guYUHLSZp0zMcYi7dNfVdm71u0fBqGpdWyskscQkkhxqwoRuwEGZgdLk/eE+wEUQXArambjhf5Y7EIOLh8+PNEcOE7VJvTicunXiO2YW83O2MzVVSTb+H9X6A0jI4fxHUC89mOwWArRYDjMD/zZiF6S29l6a7lRKcdX+LsuZevpoMoAWRp1r/pnhmo/94uXqpojYi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4074.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199018)(66899018)(33656002)(26005)(6506007)(53546011)(83380400001)(2906002)(86362001)(38070700005)(41300700001)(66946007)(66556008)(66476007)(316002)(110136005)(54906003)(66446008)(64756008)(4326008)(71200400001)(76116006)(8676002)(9686003)(186003)(55016003)(122000001)(38100700002)(82960400001)(478600001)(5660300002)(7696005)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmxPcjRVT2xpQVRwR256RXJTOCs0dWFHNVpHN0FIQW5PdjhkcFp2citmVTUv?=
 =?utf-8?B?c1NBZlpBSTlDellGNkZaTCtRaUZVN0xGdUczUHN5TEVLTGlvTC9KVHZPSzJ3?=
 =?utf-8?B?MFRmWFc0NGVqOFljRW9wZVU4TkRXbGdQUFUzdlJIQk81R3VQeWVMUkJsSS91?=
 =?utf-8?B?MU1YQi9PRkhOT29xNDRXMFVobFZva2k0K0tCYVhnWjIxajJ6VS82eVR6RXN0?=
 =?utf-8?B?dG5BQklNMzl4ejRmTVk4bmlWQ2o4ZFF6MEdCTVpRek9aS0o5OC9OZFpDMVd6?=
 =?utf-8?B?NmdoTWcyMmhpR1VVdEd0RVc5bU9IcU9PREVqY0ZFQWNJdWIzYkRGYVZaTWpR?=
 =?utf-8?B?R1lRejhBcERlOUpaRXpRMXVQMHMrMytCYmdWdkIyOW5Xd2pZbW9RZ2VhQkh2?=
 =?utf-8?B?T21ydGZMWDVnWFIvWk5jSUNyRW5kN1o4VWFxY2RzTCtMb0RmNW1McmdtYTll?=
 =?utf-8?B?ZmYvekM5ajRxM2RRR1FjM1BiaUtsR1ZIYjNnUE10Q2EzMEtuVkRJVDhsd1hG?=
 =?utf-8?B?cXJ4U1BIVFpFWWtYZWZJQTBmdktyNHVXcmhrZVNCTUpqZnRmTkRweC80Szlm?=
 =?utf-8?B?bjJmNWljSUdBVUhzY0VzaEZkVFhjbmtaWUZmeW9qWWhhUjZJZXgvVHNaTG9j?=
 =?utf-8?B?MGV0c2VFRGhIcmNvRlBDYndHK2VUbDJnRnhNa1lQMDlhTStBRmo1K1IvUkZI?=
 =?utf-8?B?aDVxMmtZbC91YVFNK0ZpTWZuNmlHU1RTdGpjeEcwT3VhaXRESlJmZ0FnUkE1?=
 =?utf-8?B?ZTRVK2tySHlNU1BBRlhwa1NVZXpMcWk4c0xWaXZpcmo0SmpzVmRvWXBuNkJQ?=
 =?utf-8?B?eUdyUXRBMXk5aFRhVWVNT0ZRZmRlS1ZXQzBDOEpUb0RCQi9ETTY4K2lOcXhY?=
 =?utf-8?B?aTk4cXM4WmhzRmVqZUQ5b3BvRUxOMld5MWRPKzlGK1h3QTBUSXRxZ2Yrenly?=
 =?utf-8?B?R3lKNnhxb0RFMms0Q0k0SllxOUhBNnFuaDR3amVpTWxDLzNDTnMzcUFHWEJj?=
 =?utf-8?B?NTk4RXNGaTFaQkNhR004RHpPcXc2OFFNbDVENDdKelFtdXNUVnZ5N2tzVHJw?=
 =?utf-8?B?SkU0MFpjUGpha0JuTzZQY2k2SDRDZENaVWN4SHpyUGYxUnZmcXpncGFGdWdu?=
 =?utf-8?B?R2NjR1ZWQjBrMTFPSXdvTmxnbG4yNHR2L09BRWI4VWh0dHNYaU5IS0QyMU1V?=
 =?utf-8?B?VnJ6QkM1STZZQnh3WmIxbzBSYi83WFdSb3l6bVpkSllmYUhqRXNrQ3I4NDk2?=
 =?utf-8?B?c1FtdWFQTjJoUHhjRXZzU0FHbVh5Qy9NWE5yS25Vc3gxMG1jblZCRUp2OEkv?=
 =?utf-8?B?UWxqLzNiREdZc25YYlNpUFl0OTJlRWthRFJZNXB2Rk1mb0F2VVd4S1kydmxI?=
 =?utf-8?B?RXRYZG56bGI0alFidVFFM0RCWGtkeEZQbDhBaXAxUVZGdWJPanRWSlJ4MlNK?=
 =?utf-8?B?NnBKQlB2S3pWb2hHUjF1bFVvek8rMStZWGRuVkFPbnhKb1FYbjBTS3hGUEdn?=
 =?utf-8?B?WWZEVVEzbm1ibUhva3NyRjF5UEJMVS9sT1g1MUJCa0pMSUhWczBNQ2ZIdTQx?=
 =?utf-8?B?QU1IUkoxN2dFSE5KWXRVY3RmQWpBelRFWkJaZHkrTW96dDFkUzU1SDZUUHhF?=
 =?utf-8?B?dTdqK0dNYlRzT3JIalNxRHl2bTZ5TkJ6ZytxNFJSOHRwVTN6WVVyRWh4VWZO?=
 =?utf-8?B?Vlc1VkZDUW1hbXJLK2U5S1JYenpXNXVVeTZUbVlTcFp1YXFSaUhkblRQdU1r?=
 =?utf-8?B?eUtyUExxVXVjU1VKOFpOTExmM05aNG5SRTFvMUU3U09wNTlINkNmRjRXQlY2?=
 =?utf-8?B?TVRrYUhrRnNseUt4WWQ1WHNuQ1pCM2pWdEVEUm5FWVBYVEg4dE5EbWtqWURs?=
 =?utf-8?B?U3haOHJQd09nMk94Uy9qUHFERFhRUkNqckplYXdvY0xieENhTENoSXVrRG85?=
 =?utf-8?B?MHUxZUNxTXdBOG1xN3RlMi9jS2ZkYmRKeWxmOWJuSTVDTzRRN1Y5OE5GTTZj?=
 =?utf-8?B?ZFVYMWNpNUxZaHFEdG5uYmxPWEdhV2NkWkF1K3BTV2IwbEtQYjE0czBWa1dN?=
 =?utf-8?B?elBIbWpnNDcxVTJqYWUwT3BkaHhWbmI5Q1JVaUtEQ21XTFk1Q2N6MTZoRno0?=
 =?utf-8?Q?iuFrF7hDPHqy6wC9G5MszrrDm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4074.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab38ba10-8460-4cc9-060b-08db2ba91b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 14:15:51.1792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNZH62SEN8VWt+KE2IIVMW8VY5RVI7xRWozpe7HZujdAz1yrJ4w5Eh5CqPczlLQrpZ4pXRcbK7IdabKCFxTZWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8372
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHBhdGNoZXMgd2lsbCBub3QgY29tcGlsZSBkdWUgdG8gbWlzc2VkIGRlcGVuZGVuY3kgYnV0
IHdlbGNvbWUgcmV2aWV3DQpvbiB0aGUgY29kZSBjaGFuZ2VzLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEJhcmQgTGlhbyA8eXVuZy1jaHVhbi5saWFvQGxpbnV4Lmlu
dGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDIzLCAyMDIzIDE6NDUgUE0NCj4gVG86
IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgdmtvdWxAa2VybmVsLm9yZzsgYnJvb25pZUBr
ZXJuZWwub3JnDQo+IENjOiB2aW5vZC5rb3VsQGxpbmFyby5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IHBpZXJyZS0NCj4gbG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5jb207IExp
YW8sIEJhcmQgPGJhcmQubGlhb0BpbnRlbC5jb20+Ow0KPiB0aXdhaUBzdXNlLmRlDQo+IFN1Ympl
Y3Q6IFtQQVRDSCAwMC8yMF0gQVNvQy9zb3VuZHdpcmU6IGFkZCBzdXBwb3J0IGZvciBBQ0UyLngN
Cj4gDQo+IFRoaXMgc2VyaWVzIHVzZXMgdGhlIGFic3RyYWN0aW9uIGFkZGVkIGluIHBhc3Qga2Vy
bmVsIGN5Y2xlcyB0byBwcm92aWRlDQo+IHN1cHBvcnQgZm9yIHRoZSBBQ0UyLnggaW50ZWdyYXRp
b24uIFRoZSBleGlzdGluZyBTSElNIGFuZCBDYWRlbmNlDQo+IHJlZ2lzdGVycyBhcmUgbm93IHNw
bGl0IGluIDMgKFNISU0sIElQLCBTSElNIHZlbmRvci1zcGVjaWZpYyksIHdpdGggc29tZQ0KPiBw
YXJ0cyBhbHNvIG1vdmVkIHRvIHRoZSBIRGF1ZGlvIEV4dGVuZGVkIE11bHRpIGxpbmsgc3RydWN0
dXJlcy4gTm90aGluZw0KPiBmdW5kYW1lbnRhbGx5IGRpZmZlcmVudCBleGNlcHQgZm9yIHRoZSBy
ZWdpc3RlciBtYXAuDQo+IA0KPiBUaGlzIHNlcmllcyBvbmx5IHByb3ZpZGVzIHRoZSBiYXNpYyBt
ZWNoYW5pc21zIHRvIGV4cG9zZSBTb3VuZFdpcmUtYmFzZWQNCj4gREFJcy4gVGhlIFBDSSBwYXJ0
cyBhbmQgRFNQIG1hbmFnZW1lbnQgd2lsbCBiZSBjb250cmlidXRlZCBsYXRlciwgYW5kIHRoZQ0K
PiBEQUkgb3BzIGFyZSBub3cgZW1wdHkgYXMgd2VsbC4NCj4gDQo+IFRoZSBjaGFuZ2UgaXMgbWFp
bmx5IG9uIFNvdW5kV2lyZS4gSXQgd291bGQgYmUgYmV0dGVyIHRvIGdvIHRocm91Z2gNCj4gU291
bmRXaXJlIHRyZWUuDQo+IA0KPiBQaWVycmUtTG91aXMgQm9zc2FydCAoMjApOg0KPiAgIEFTb0M6
IFNPRjogSW50ZWw6IHNoaW06IGFkZCBlbnVtIGZvciBBQ0UgMi4wIElQIHVzZWQgaW4gTHVuYXJM
YWtlDQo+ICAgc291bmR3aXJlOiBpbnRlbDogYWRkIEFDRTIueCBTSElNIGRlZmluaXRpb25zDQo+
ICAgc291bmR3aXJlOiBpbnRlbF9hY2UyeDogYWRkIGVtcHR5IG5ldyBvcHMgZm9yIEx1bmFyTGFr
ZQ0KPiAgIHNvdW5kd2lyZS9BU09DOiBJbnRlbDogdXBkYXRlIG9mZnNldHMgZm9yIEx1bmFyTGFr
ZQ0KPiAgIHNvdW5kd2lyZTogaW50ZWwvY2FkZW5jZTogc2V0IGlwX29mZnNldCBhdCBydW4tdGlt
ZQ0KPiAgIEFTb0Mvc291bmR3aXJlOiBpbnRlbDogcGFzcyBoZGFjX2J1cyBwb2ludGVyIGZvciBs
aW5rIG1hbmFnZW1lbnQNCj4gICBzb3VuZHdpcmU6IGludGVsOiBhZGQgZW1sX2xvY2sgaW4gdGhl
IGludGVyZmFjZSBmb3IgbmV3IHBsYXRmb3Jtcw0KPiAgIEFTb0M6IFNPRjogSW50ZWw6IGhkYTog
cmV0cmlldmUgU291bmRXaXJlIGVtbF9sb2NrIGFuZCBwYXNzIHBvaW50ZXINCj4gICBzb3VuZHdp
cmU6IGludGVsX2luaXQ6IHVzZSBlbWxfbG9jayBwYXJhbWV0ZXINCj4gICBzb3VuZHdpcmU6IGlu
dGVsX2FjZTJ4OiBhZGQgZGVidWdmcyBzdXBwb3J0DQo+ICAgc291bmR3aXJlOiBpbnRlbF9hY2Uy
eDogYWRkIGxpbmsgcG93ZXItdXAvZG93biBoZWxwZXJzDQo+ICAgc291bmR3aXJlOiBpbnRlbF9h
Y2UyeDogc2V0IFNZTkNQUkQgYmVmb3JlIHBvd2VyaW5nLXVwDQo+ICAgc291bmR3aXJlOiBpbnRl
bF9hY2UyeDogY29uZmlndXJlIGxpbmsgUEhZDQo+ICAgc291bmR3aXJlOiBpbnRlbF9hY2UyeDog
YWRkIERBSSByZWdpc3RyYXRpb24NCj4gICBzb3VuZHdpcmU6IGludGVsX2FjZTJ4OiBhZGQgc3lu
Y19hcm0vc3luY19nbyBoZWxwZXJzDQo+ICAgc291bmR3aXJlOiBpbnRlbF9hY2UyeDogdXNlIGNv
bW1vbiBoZWxwZXJzIGZvciBidXMgc3RhcnQvc3RvcA0KPiAgIHNvdW5kd2lyZTogaW50ZWxfYWNl
Mng6IGVuYWJsZSB3YWtlIHN1cHBvcnQNCj4gICBzb3VuZHdpcmU6IGludGVsX2FjZTJ4OiBhZGQg
Y2hlY2tfY21kc3luY191bmxvY2tlZCBoZWxwZXINCj4gICBzb3VuZHdpcmU6IGJ1czogYWRkIG5l
dyBtYW5hZ2VyIGNhbGxiYWNrIHRvIGRlYWwgd2l0aCBwZXJpcGhlcmFsDQo+ICAgICBlbnVtZXJh
dGlvbg0KPiAgIHNvdW5kd2lyZTogaW50ZWxfYWNlMng6IGFkZCBuZXdfcGVyaXBoZXJhbF9hc3Np
Z25lZCBjYWxsYmFjaw0KPiANCj4gIGRyaXZlcnMvc291bmR3aXJlL01ha2VmaWxlICAgICAgICAg
ICAgICB8ICAgMyArLQ0KPiAgZHJpdmVycy9zb3VuZHdpcmUvYnVzLmMgICAgICAgICAgICAgICAg
IHwgICAzICsNCj4gIGRyaXZlcnMvc291bmR3aXJlL2NhZGVuY2VfbWFzdGVyLmggICAgICB8ICAg
MiArDQo+ICBkcml2ZXJzL3NvdW5kd2lyZS9pbnRlbC5oICAgICAgICAgICAgICAgfCAgMTYgKw0K
PiAgZHJpdmVycy9zb3VuZHdpcmUvaW50ZWxfYWNlMnguYyAgICAgICAgIHwgMzkwICsrKysrKysr
KysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9zb3VuZHdpcmUvaW50ZWxfYWNlMnhfZGVidWdm
cy5jIHwgMTQ3ICsrKysrKysrKw0KPiAgZHJpdmVycy9zb3VuZHdpcmUvaW50ZWxfYXV4ZGV2aWNl
LmMgICAgIHwgIDE3ICsrDQo+ICBkcml2ZXJzL3NvdW5kd2lyZS9pbnRlbF9pbml0LmMgICAgICAg
ICAgfCAgMjEgKy0NCj4gIGluY2x1ZGUvbGludXgvc291bmR3aXJlL3Nkdy5oICAgICAgICAgICB8
ICAgMyArLQ0KPiAgaW5jbHVkZS9saW51eC9zb3VuZHdpcmUvc2R3X2ludGVsLmggICAgIHwgIDg4
ICsrKysrKw0KPiAgc291bmQvc29jL3NvZi9pbnRlbC9oZGEuYyAgICAgICAgICAgICAgIHwgIDMx
ICstDQo+ICBzb3VuZC9zb2Mvc29mL2ludGVsL3NoaW0uaCAgICAgICAgICAgICAgfCAgIDEgKw0K
PiAgMTIgZmlsZXMgY2hhbmdlZCwgNzExIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc291bmR3aXJlL2ludGVsX2FjZTJ4LmMNCj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvdW5kd2lyZS9pbnRlbF9hY2UyeF9kZWJ1Z2Zz
LmMNCj4gDQo+IC0tDQo+IDIuMjUuMQ0KDQo=
