Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579F574AC58
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjGGH5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjGGH5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:57:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C02E70
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688716655; x=1720252655;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NIubBoNQLmskfndYuaN/zvwWUhVgoX4PVA+BlpzHEbg=;
  b=fEAKSkGLTs283oncXlcOgLf2Drjqj+iqtC3FB74Vlk4CimN3RXs5gk53
   Io4OQQ3DtlPmpnnvufZDrsy8H55wBTXraY64cnm0lCV0cU+NfLYx96sfk
   dmP7jQzOFc3K2SfIsKAlRtdqEAeqTZmOrMuUOlLJp+8LfMAEZs6oKpcuU
   VsNxpf1S7uI6bmhsWIezy4Hidva3ZBfYvP/m00CRyGIYrLLS1FkWX4y68
   G+FudC1k0mzMhFcNlqrLcX7DRtRNiaFjcmkZ3coSc5SwbACdTT0wupKgU
   uvXDJ0ODXRiifE5RlxKyxSp30+KGAUBq8QxKqrk2N8v+iJfDHYKxu2gPL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="366416124"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="366416124"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 00:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="749459968"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="749459968"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 07 Jul 2023 00:57:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 00:57:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 00:57:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 00:57:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oecq+4VV7zKUZDHTmY1tM1L6O1rnoBwwHEbIOA0JgEcyW+50Fm3gL1jSNeTr/MlYgjzcRRSR8xohFBwD54OzEBANoF5L5BnHS6yk/HUTu0dN31qpBsR6UuiaBrmotmpDeO5sN76fuWF2QR7YsfvXvdUZ90Re0oXRBznC53oFx5aeTegrvCN8lnjVBscY/JR6iIVhA3zmvWPRkm8BbGeEVsecqtZotFKHVjA7OtcI4nmonCwM89QVk1z1/8Ghkaoa1FErBpYmlp8UOhPGuYdeCHpB+Bz+3ycQ8N+qH/m3eGnbbC+k51pxMxNGXQvmz79fkG0k6KoRHgnd6x3EtvQdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIubBoNQLmskfndYuaN/zvwWUhVgoX4PVA+BlpzHEbg=;
 b=GSjdG91UwW3XU8hp1LBBqngmYnmrnRLsV80awO+2dzfnv4uOFhiYcLZjz9NfEXcEFPS5krcCp9tVBrV3lAtVMXPwSei3AmVE/VsQdC4SwUf9XCtKIHz2edaIULiXsUF+fakalJkITiuFSQ360xJj5kkJrGH7IceDPwWSjg04ObbraBDFkAeTfGLhb75CwhGEfAUTeEHiFyBkqoNKP2YaF8/CzIV31cjudiqOlpZ5uG/F049HajP4T+w32+VATpWO9gln59pOjo1PxHLW1rrRURp4asi+6kiV2jKFFRX1cCtD//c33RbK6vxAEhlFc6y3tA3LqMY302P6XXirqBti0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by DS7PR11MB6223.namprd11.prod.outlook.com (2603:10b6:8:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 07:57:32 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::315d:c14:7bbb:710e]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::315d:c14:7bbb:710e%3]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 07:57:32 +0000
From:   "Lee, Kah Jing" <kah.jing.lee@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ang, Tien Sung" <tien.sung.ang@intel.com>,
        "wen.ping.teh@intel.com" <wen.ping.teh@intel.com>
Subject: RE: [PATCH 1/2] firmware: stratix10-svc: Generic Mailbox Command
Thread-Topic: [PATCH 1/2] firmware: stratix10-svc: Generic Mailbox Command
Thread-Index: AQHYwyd4lLrweNFYhkW5Cy5sZHfqVK+pOyKAgAV0oYCAARsqsA==
Date:   Fri, 7 Jul 2023 07:57:32 +0000
Message-ID: <PH0PR11MB5673F1ABF27DE49E58F3CD16CB2DA@PH0PR11MB5673.namprd11.prod.outlook.com>
References: <20220908020350.2745506-1-kah.jing.lee@intel.com>
 <20230703034449.1334571-1-kah.jing.lee@intel.com>
 <1a74c6c8-d921-6a43-c6ec-4e42760d1523@kernel.org>
In-Reply-To: <1a74c6c8-d921-6a43-c6ec-4e42760d1523@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5673:EE_|DS7PR11MB6223:EE_
x-ms-office365-filtering-correlation-id: 583c3c05-905d-4a1a-7544-08db7ebfd17e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CIERcJTwBUsWtl/LEcHdue5b8NO+9Tu3qtzi27Bli8PmTXQVYtJDOnlw0mnSb7UJZr4AQi8dGBpLnqYghH/bnJr0e6u+6qk8PhbddACHIZ7AeIikfFXMPjnc/TDNM41SLaAVHGyH3iOO4hFbSPMOC8kALLNIjqHTLfx0A2x8+AE/FmVEhwXWmnNJ5YFXH/qUGMh1+DQlPDeRUj8DaSsmChFIUAWaL/2KzBkcoe38Z1MttqzH850TvSwWrFD2IY4ASM5wbefhClhzWEYV8eS+etx0vg007QRTHvqS7FO2xJbcXiA2sk+Q+rS6RkJy3hfqL9ON0mBZvuJDHFuuhqALZbgnvVGfgADAFeSJb3tgb/1CSQeRU+1QzGWfQrdK3YSMFPiHFA0yN9Nkpe+wKaNfXhFyU4nqWy4LcoJ3YHzGY/A/tAfHqu/MayPtqeu6C7QbaJRxuCPPKXdxbDkVkCLRcbcRqNCdHI5XzB3SYHqVgSWsdwbBFBaYtwhf8Cr0GxVDhk+9yPKR3pDqMtE+Gd1MBzfU8kytuCmTECC7oSwqSe6efHN3P2AecRaa+etS3tOkgoc4AD7FVlgcmF2JNPCugi6vV3Nm59qDR7+fIOHAXbB4gYPl/Ew8NQ3LV4U+Noyf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(55016003)(83380400001)(15650500001)(2906002)(4744005)(66476007)(66446008)(64756008)(66556008)(6916009)(4326008)(7696005)(66946007)(76116006)(316002)(54906003)(478600001)(71200400001)(52536014)(26005)(5660300002)(107886003)(6506007)(186003)(53546011)(9686003)(41300700001)(8936002)(8676002)(38100700002)(122000001)(82960400001)(86362001)(38070700005)(33656002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzRPcjhZMkVsK0Y2b0h4ZEorUTZWQkdRaEJlTmplMGNuU3A0aE1BbHVNQ2tx?=
 =?utf-8?B?THR3UUtNWkJLNFVqckVEanRMSzJER3JqVlRQQUVHRlNlRm12dE5XamhEN3Nt?=
 =?utf-8?B?RTdYSWw3bTBhbGlYUmFzZitnc1VyTmtxajRrcVZxblR5Nk44RmlZOTUvaHk4?=
 =?utf-8?B?NXJVSzY5UzM0ak5NZXZuL3MzaG5EaERhU0dxbHlSVGtxMWZ3WUxNcjhXRFF1?=
 =?utf-8?B?bXMvUXR5SFZsVDdvbVFtNWh6a0V6ZDV1Z3NBWU1NbUlvNDJHYXp4ZVJvNVpQ?=
 =?utf-8?B?OVJLd1RId2tOOEtRRVpPazNOb1RHMkpqRzdNS0g2eU5za2RUR2F6aElTZEdS?=
 =?utf-8?B?V3JhVHM3UXRlUnpzazd1c2tmWWtwYTRkLzlnK0Ivb0FJU1VsMXcyWUhvZGp2?=
 =?utf-8?B?Q0JmNjlvdEsrRGdUMVhrYk5XZks1QnA3bkhXR05XMFNIWkhleFppdnNLc3dv?=
 =?utf-8?B?WXlJUG8xSlpyU3A2M1JoMUdHZEZGTjJHeUlTdTVISHhYT1E1Z3ZPQ0VmN2Uz?=
 =?utf-8?B?T3BZYVJhSVl5ZUJEQi9TVStrVlJQWVcvd29BZ2lTaGJMZjdOb0pPZ2ozVTls?=
 =?utf-8?B?TDl2Qm1XYVBiNWNDRjFubzJVNnBCQS9xazY0dlpUdFJxdlFxRmh3Y2hNWWRo?=
 =?utf-8?B?RzdVUENGbVNrYWVzTEFrSXpoQVQ0VStlK1hQRjUxdytBYzdZVVZ6MEEyWmR3?=
 =?utf-8?B?ZjRCRTh2YU96b0NwY2Y1SG8rMkFlYjU4VzdzeUVwQnBIWjFrSkZxZm9xMkkz?=
 =?utf-8?B?NEVBSldYTlhnTVFWSXJlMHdJR0VGODdOaWh5NmVjbXUzQVdVeUozNXBiV3Zh?=
 =?utf-8?B?NmpON1NoOHBXTytLcEhjdzUwZDJpcnVUNDlXL1FWZGRTQmV2VlNPR1FSOEp1?=
 =?utf-8?B?TUFNYUZqSlpzZjBuemNEa1I0WE5uZFd2MXJXZUp6U2tjQTAzbks1TDZSZzhx?=
 =?utf-8?B?b3BpTmtXZWpSOHpiTW9jZ3NGaFN6VmFKRHdZOStHV2VnUkVDWmR5MWNpbUsy?=
 =?utf-8?B?aC8zSFc3clZub0t4bW9XYW1qS3dzK1k2UTlaZVYvNE1oN1RGTEtwakVGYmxE?=
 =?utf-8?B?d3FDNENzSFpyQ3VGSlN6YTRsKytxTTA5RlVDc05aUjZsL1crdkJHNThEd3Br?=
 =?utf-8?B?V0hEakk2RUtWMGliaXIzNUVvQ2tHd1lBVy9idVl4WTA2RzBpcnQxaDVrb2pi?=
 =?utf-8?B?TS9WaDhuUHNlTUhvVHVmdnFmWitDdDZTanQvME5DMzBQL3E2YmJlN0dmM3l1?=
 =?utf-8?B?WlVDV2k1cm5lR093OXRoaHZLbm1YaDBoU3Y4ZzBjd3pvZXh1OERETXE5S0F1?=
 =?utf-8?B?cGJJSXJkbnpsekJXTk1ramZtYytJQUlWSy9teEt0ZzdMZ3JwaGVJQ1BwMSt3?=
 =?utf-8?B?MEFybkdMYVdEYVB2SVRsWXUzTG81QTM4c1ZnaHdCdSsrVVdqUmlvdlpNSnlv?=
 =?utf-8?B?MG4xMlhHZjhwQUkzcUFNaGFrb2piUVVYbU1KbUNPakdQQnZXL3R0UEJYYjZS?=
 =?utf-8?B?b0dGZjBMa2NNTERLUC9EbkhkKy8weXRkWHA0ai9GMGlRbGVCNi83VjZSMDFl?=
 =?utf-8?B?SCtDeVNJTGEycmtTd0lLVVdqTXRFWmRSUFhXekRscXJxd2RQSU1EYTBydUpB?=
 =?utf-8?B?U3VCcDZhRFpWbENqRDZnMEdpNVFSSlRKOU5KQXZ1U0pLL2oydzc0cXZ2Zk11?=
 =?utf-8?B?L0hBZzJFeEtSYU1BREFqN2kxcGRDdUpMR1VSdW9xOVZDeVpnS1VFVGR1NkxI?=
 =?utf-8?B?V3FXYVA2QlNBVjhwVmxUWk9Vb2EwRjRwTG5rUlkvZTFDQ3Q0R3kySCtQbTMy?=
 =?utf-8?B?ZmpUN2hzUzhBK1F4RXRoVmNDeFl6cVovcG9JNVU5NHZLalNxWDRWeTdBWlFV?=
 =?utf-8?B?MlZLUWZiK1hxd0RYWWlscmdQb2dPOXlsUmFEQkhTa0NWeWQyUWpUSzRWN1dq?=
 =?utf-8?B?M0hsUVdWdVUwVmdDeitoOGh0WFpEUlFIWFhueHI0ZXdka1QrSnkzdVdETllQ?=
 =?utf-8?B?a2ViUDhIbjFnTThmenJ2RUgrRWY4STlscTlTSEsrOTdqck9BNW14eFRSTnBD?=
 =?utf-8?B?OVdWUlI4MHE5bWFNbEZjT0dtcW5IVXVsSGZkaFhQMTc1T001OTFYakhDR003?=
 =?utf-8?Q?bfCoBs8Z4LILf6X7j3j+AQe3w?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583c3c05-905d-4a1a-7544-08db7ebfd17e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 07:57:32.1129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: db1MlvSxkphPLjWrKgAXZ0+eMvtQi70Ikr4Im1wqg8zduG9uMzJznoU0y65O4t/z6sXt8T+m9pbsF8oCzPAhcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6223
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SXQgaGFzIGJlZW4gYXdoaWxlIGJhY2suIExldCBtZSByZXNlbmQuDQoNClRoYW5rcy4gDQoNClJl
Z2FyZHMsIA0KTGVlLCBLYWggSmluZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IERpbmggTmd1eWVuIDxkaW5ndXllbkBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2Rh
eSwgNiBKdWx5LCAyMDIzIDExOjA0IFBNDQo+IFRvOiBMZWUsIEthaCBKaW5nIDxrYWguamluZy5s
ZWVAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW5nLCBU
aWVuIFN1bmcgPHRpZW4uc3VuZy5hbmdAaW50ZWwuY29tPjsNCj4gd2VuLnBpbmcudGVoQGludGVs
LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZmlybXdhcmU6IHN0cmF0aXgxMC1zdmM6
IEdlbmVyaWMgTWFpbGJveCBDb21tYW5kDQo+IA0KPiANCj4gDQo+IE9uIDcvMi8yMyAyMjo0NCwg
a2FoLmppbmcubGVlQGludGVsLmNvbSB3cm90ZToNCj4gPiBIaSBEaW5oLA0KPiA+IEFueSBmZWVk
YmFjayBvbiB0aGlzIHBhdGNoPw0KPiA+DQo+IA0KPiBXaGF0IHBhdGNoPyBJIGRvbid0IHNlZSBh
bnl0aGluZyBoZXJlLiBQbGVhc2UgcmVzZW5kLg0KPiANCj4gRGluaA0K
