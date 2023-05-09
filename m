Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89576FBCD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjEICDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjEICDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:03:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DA0F5
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 19:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683597820; x=1715133820;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HhkF6tbwbPNeSthSeKFA5ds9uR/wdw0nXEcdL8a3hsE=;
  b=CKgG+KQOfV7c5wzYOgdLRj46cXXIjYGE8h2JShdPQtBgsiof5dIVF97a
   JAPtnQ9XwnXLG0Hir5iqnY9WrkQXLcmQCsFtrrhx5lWl8Dnpwvyt1xbh2
   3IqnjPbICPsPNsdHegWTjNsUdutHYEMS1k9h31a78Pf9BF7GEcQySopXe
   HfTCwrHI2CcNHZoEY4wSuCcK5eS9edKvPFr5c0/Ba41Oph2cTa3TiAyOB
   PQxPkvIW2HlzDQ6c9NR5+n0g8YWRKbrZs7BrHeAej2ExdoY2WUvOBCK/r
   QT5N3BqQdMhboX6gyxViRQf6p3iV7Mtjyhss8Bv12GHIVMbFnGcDSOTIp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="330152311"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="330152311"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 19:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="731508140"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="731508140"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 08 May 2023 19:03:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 19:03:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 19:03:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 19:03:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnL40ux6OECH+RMFcpY8/OQSEcunH4r1Ne+97IFkgPfI8CA31Wh/sPMC7QbTKkihZDFJD5aFwmmLhnqtX7Fax9HZ3HEqGyBjdFVOqCWSwsujcYMXQdVJB5lYZxgGUOYOoURR2kIV2CTn7X+yJb3SMkyRmjofB28K5mvi40rlS7UjMBFp/3+xswQuOMWb+CldcqUA7LovHYKvSk8Cf1kchYHJz9JrDj7MFNnrlni2oy/FpRYGzy0J9bb4htiY977lcVuHVYn0ZTlPrbxZ3ZQo78U9Fj/+g0KK5KYPDKEE8bbMYm4wlhtXfF89JRqq1Ksweg1KxY2q7cflISxhMh+T4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhkF6tbwbPNeSthSeKFA5ds9uR/wdw0nXEcdL8a3hsE=;
 b=giwTD/eyqsIVttJYIA5HVDirvE6uCmP4EujxmrSPUh3rkC8QiOBUPNzmp+SKjtJEoYS06JRP0+PSxbMxzaBIaZSEV07/KRcJDJSZYpQ0jxwLX9eb9qMMLztl7qqzVkGCFluhXBglVw5QzzVCl92luD0bPV2RmKwlmwVIapG9B7octg6x70DUs4Lbui1gz/1FeFrDQA3Bn4Ye6qSLSoNL2+0+MSECTE8maesSth0V6/PdugkbKOriqCKbDUgM/qp73TDN3n3LBwLsQotEvO1dHWAy2xGMgsymua2xXvt5abhQ4W7OEkAPN0VeXNF7uONKVWfNHD1hrecS7eQ3Hqo6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by BN9PR11MB5385.namprd11.prod.outlook.com (2603:10b6:408:11a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 02:03:37 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 02:03:37 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
CC:     Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] locking/qspinlock: Fix state-transition changes in
 comments
Thread-Topic: [PATCH 1/1] locking/qspinlock: Fix state-transition changes in
 comments
Thread-Index: AQHZf+Q5H6HapMWcmkmbbiivYiqfDK9Qg9kAgACiV3A=
Date:   Tue, 9 May 2023 02:03:37 +0000
Message-ID: <IA1PR11MB617110DB70F92AFC0D40D26089769@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230506062934.69652-1-qiuxu.zhuo@intel.com>
 <10d3a11a-8591-e49d-e010-867a05078ff0@redhat.com>
In-Reply-To: <10d3a11a-8591-e49d-e010-867a05078ff0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|BN9PR11MB5385:EE_
x-ms-office365-filtering-correlation-id: bd6069fd-2c35-4aa9-f4c8-08db50319a1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ethlUTFBQVcEF9Jzm0Ran35lt28UZlCQWTrjZAuhh7fPkdcvDqfyTMOmySQ/HYee8Al1QaQPE6K6FVlcigaQbC6uaJziuwd43sFZwNl5Quoh/SAclPg5mZHezli6Gb/VHIJywgf/wKoTqVdewW1vp4mNUwpWuRZsoTFTY0DfC4BP3TgSwobSrU8xS840ngH/O5Higp7j4+nL57w1qmU0R5sUW03Rr1KgzEx8YRM1n6o5pkNiTlf3CFIQaZBwovA/ppDes74/wT4N5xKLrTG8nwcJ0hwclvStPFPAiMmKjTBolxSQpVTGvvGzMEhYEwFf5fH0ywqtYoJUR8hA+T+cBUtqADvJ6pGFHRTOZEu4ExOYFVONLGkK9l6WE72oWm6FVkOKzi8wm09IFO1YCZRpdgGcC6w3EwNSebG+BtHXP/HMEcsovNOU06/2OxRTtZODg4HpE578/GsmMWspyC6dsH5dsivcAen1p0nMJbEL2mp2glieZLSK/3aoOvSh5i50Qfkp8cYFC8G1mG9nPNJmDetE7Whw9Kj2zJy5SqnsRjKlKa5DRCJ83OFALj04pwBJuUDJvDZO4xEzc2FByewVuPwquY5u4iVELmLYow+fqzR/47LP7xflsHRYxyPWU+c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(38070700005)(2906002)(38100700002)(8936002)(5660300002)(52536014)(8676002)(86362001)(55016003)(33656002)(7696005)(71200400001)(110136005)(54906003)(478600001)(83380400001)(6506007)(26005)(186003)(53546011)(9686003)(66946007)(66556008)(76116006)(66446008)(82960400001)(64756008)(41300700001)(122000001)(316002)(4326008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STdHL3ZoVnVENW5uRWh2YThIMm1ncWtvdmZSYitqV1dlbVFYbUF4bUlSRjVp?=
 =?utf-8?B?ci9aemo1L3lpNlVHZ1ZjUFJtREtOcXFxaGpaN0ZubDhCSi9DRmVaUGJvNm51?=
 =?utf-8?B?QVBkd2JxWWxDODRnMzA4akpmZW5YVkkxd2FDdzVVRFRnNVFxbVNwOU1xdFdl?=
 =?utf-8?B?YkU4cW84QkltQzdsQWZXMitqWG93bGhLcWpnbXdVRkZPeTRuYm5maDRsWFo5?=
 =?utf-8?B?RzRKUTB6c0tJcmljNEQ1YmVwRkp5VDJSbU9KSnlNa3VGZ0xWVHFSaUtqWC83?=
 =?utf-8?B?b3hPWW0vSi9KR3RFRGNFQktpcFZkbnZ6SVJhbURkcnVjaEU1VGZHY1Y5V2NH?=
 =?utf-8?B?TUFNTnZCRnFmdTIzUWYxV042aWc2NmQydUthUHltRlBJV3JWZHhKaTNUdW9K?=
 =?utf-8?B?b3lLcjkyZWJIQUd0dFVGT0o0T1kwVk8zNmliTm1kN052dERrTkFxSW03NEo5?=
 =?utf-8?B?Z050aWxJVzdpVVk5cVlPNTE5OHpXZ3FRZjNQYkhtYWdRcDk0aUpBeEwzeXAy?=
 =?utf-8?B?cGI2d2pIZ2NrMmZocEFoa0VRSnVwSXE2Y0U1TVlobzZ2b2NDemIzYUxDOVdQ?=
 =?utf-8?B?dmhGK2pvMWR4c2ZqdUI5R1BzMVc4MVVIQ29LY1BhQUpNeHBnNVNjblRENkJL?=
 =?utf-8?B?MW8zSWdLR1ZZWnJwcGFWYnhOd2JpcUE4dVIrTXFwWjdMRHFpOUpoUDJucWZD?=
 =?utf-8?B?b3B3UWlBb0EydEVkVWVQT3AvOFJyU2NFQWwzbS9NZkpsVEZ4b3RQdzYyVGZR?=
 =?utf-8?B?T0dTMmJLNm5QNXVMUFEvTVZSRHRHU0RyTUVpTngwM3hGakd4Q0pTRys1ZFEy?=
 =?utf-8?B?WkwreUhFSWp6TmhwTm9ZVXROM1B5WDNITlhLdzhoUEFLL0xWRHpPL2JDNFRa?=
 =?utf-8?B?Y25JY3pnQTJMSFJtTjhIU2I4T0ZFNThsMFpQT2dwcVUvQTE2MzEzQU14ajRO?=
 =?utf-8?B?RDFyU2RNUnpSd2plRUsyRHZSWmYvMmxzZVdnMEJaSlZUWmJmdjRvMDdNRmMz?=
 =?utf-8?B?OHpwR2dDTTFQYTZVS0pOSG1YYS91SWZPc21QcnE5WlYwWkVvM05UZUMwa0hD?=
 =?utf-8?B?MHhpTUtzcXc3UTg1bCtoay9pN0wwSkdVMVU1ZTVIemhVRlFKb28wUzIvSllS?=
 =?utf-8?B?YUJGVFBJVEJydHBvZ1pSTE5rbVFXdkxwZ1UrOFhFTTBPKzRDM1ZocHVmUU1a?=
 =?utf-8?B?ZHBKa3plbnpxZTI2b3BZMVhFdUlOSXI3RlVKOVlqZTVDSUl0eFdWTWYzcTRm?=
 =?utf-8?B?Qm9CTi9wU2dDTEZVRVoyS1M4VHEyZG1GN0ZOaTFDTkdZeHdleHAyNm5rR095?=
 =?utf-8?B?bDIwUkMyNDZxUlRCRm0wNUx5Z0RybjJCRlhyT0hrb1lvYnhEWDVXZzRBNlVE?=
 =?utf-8?B?d1p3R3VQa053cnIrN0c0NFVxV21adkVMMmQ0YmhYWEtTeXNXempYVkY0VDUz?=
 =?utf-8?B?dGlWb1l4Y3NlTjNFTDY0QldGcjRzZHExemZCL094OHFpV0RXRXVjOS9tMDU1?=
 =?utf-8?B?bmpkenRBUk9WMEg1bFRnNDkyc0g4YWx6MThpenVrM1dicVV1ZFdxb1Bqamlx?=
 =?utf-8?B?b3R0eE4zY2QyQ2VnVlczcEZOQnF5cFdYYyt4cnhuM3A0ZVVyRFhnR3JpR3lO?=
 =?utf-8?B?OW01TUwzLzNsT3R5SlBVZ3p5dVpKeEhVdjBBZk90b2ovNDVnKzgwdG5oWlhy?=
 =?utf-8?B?WTdNNGpPTXd5NGs2UGNnRUhZeEhtNmZreHBPdjIxY2Jad3pCdkdWWFZwL2dl?=
 =?utf-8?B?STZQek9FcUlnUzM3d2JCenJCUVdIQmNwT2hacTFzeHBKY1ZkVVN3SUtDcGNF?=
 =?utf-8?B?ZTFoV2cvOEppWVJsV3RQaXJwdVdHTTBERExDRFNvcXhIa2t5enZuUEZnWUdD?=
 =?utf-8?B?YmxOMjZrbXNkcTlGYU1XWVZWSWpadDF5U21lUjE1VDlWVTZqWm8vK29icys3?=
 =?utf-8?B?cVM5cjJrOHc2RFk0Q2hFYXFpTUJlckVVMndOY1FKTlF1Z3pwdWdNS05qY3R4?=
 =?utf-8?B?dVl6Z3IyNmpqMlJZR25SVXJIalE4OVVvTFMwUVZhQ0hRYnhLbXJkSmhPMWRI?=
 =?utf-8?B?ZjNwSTlBeWZXMkRSYTI4d0lJcnowL0UwNW9aNlRvVWZjbWlXVjgrR1FIaHBs?=
 =?utf-8?Q?s/4gvlc9brcFWEwTRHZfWc/01?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6069fd-2c35-4aa9-f4c8-08db50319a1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 02:03:37.1869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Idww0kc9tJD5oCVu4ewoeeqHw2eN/JKl+kL7OidslF93OFu3vyRwTP8yyIrd5K11vgmyJXsFqtE2VzhGHn9BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5385
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2Fpbm1hbiwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4gUGxlYXNlIHNlZSB0aGUgY29t
bWVudHMgYmVsb3cuDQoNCj4gRnJvbTogV2FpbWFuIExvbmcgPGxvbmdtYW5AcmVkaGF0LmNvbT4N
Cj4gU2VudDogTW9uZGF5LCBNYXkgOCwgMjAyMyAxMToyOSBQTQ0KPiBUbzogWmh1bywgUWl1eHUg
PHFpdXh1LnpodW9AaW50ZWwuY29tPjsgUGV0ZXIgWmlqbHN0cmENCj4gPHBldGVyekBpbmZyYWRl
YWQub3JnPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBXaWxsIERlYWNvbg0KPiA8
d2lsbEBrZXJuZWwub3JnPg0KPiBDYzogQm9xdW4gRmVuZyA8Ym9xdW4uZmVuZ0BnbWFpbC5jb20+
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8x
XSBsb2NraW5nL3FzcGlubG9jazogRml4IHN0YXRlLXRyYW5zaXRpb24gY2hhbmdlcyBpbg0KPiBj
b21tZW50cw0KPiANCj4gDQo+IE9uIDUvNi8yMyAwMjoyOSwgUWl1eHUgWmh1byB3cm90ZToNCj4g
PiAxLiBUaGVyZSBtYXkgYmUgY29uY3VycmVudCBsb2NrZXIgQ1BVcyB0byBzZXQgdGhlIHFzcGlu
bG9jayBwZW5kaW5nIGJpdC4NCj4gPg0KPiA+ICAgICBUaGUgZmlyc3QgQ1BVIChjYWxsZWQgcGVu
ZGluZyBDUFUpIG9mIHRoZXNlIENQVXMgc2V0cyB0aGUgcGVuZGluZw0KPiA+ICAgICBiaXQgdG8g
bWFrZSB0aGUgc3RhdGUgdHJhbnNpdGlvbiAodGhlIHFzcGlubG9jayBwZW5kaW5nIGJpdCBpcyBz
ZXQpOg0KPiA+DQo+ID4gICAgICAgICAgIDAsMCwqIC0+IDAsMSwqDQo+ID4NCj4gPiAgICAgVGhl
IHJlc3Qgb2YgdGhlc2UgQ1BVcyBhcmUgcXVldWVkIHRvIHRoZSBNQ1MgcXVldWUgdG8gbWFrZSB0
aGUgc3RhdGUNCj4gPiAgICAgdHJhbnNpdGlvbiAodGhlIHFzcGlubG9jayB0YWlsIGlzIHVwZGF0
ZWQpOg0KPiA+DQo+ID4gICAgICAgICAgIDAsMSwqIC0+ICosMSwqDQo+ID4NCj4gPiAgICAgVGhl
IHBlbmRpbmcgQ1BVIHdhaXRzIHVudGlsIHRoZSBsb2NrZXIgb3duZXIgZ29lcyBhd2F5IHRvIG1h
a2UNCj4gPiAgICAgdGhlIHN0YXRlIHRyYW5zaXRpb24gKHRoZSBxc3BpbmxvY2sgbG9ja2VkIGZp
ZWxkIGlzIHNldCB0byB6ZXJvKToNCj4gPg0KPiA+ICAgICAgICAgICAqLDEsKiAtPiAqLDEsMA0K
PiA+DQo+ID4gICAgIFRoZSBwZW5kaW5nIENQVSB0YWtlcyB0aGUgb3duZXJzaGlwIGFuZCBjbGVh
cnMgdGhlIHBlbmRpbmcgYml0DQo+ID4gICAgIHRvIG1ha2UgdGhlIHN0YXRlIHRyYW5zaXRpb246
DQo+ID4NCj4gPiAgICAgICAgICAgKiwxLDAgLT4gKiwwLDENCj4gPg0KPiA+IDIuIFRoZSBoZWFk
ZXIgb2YgdGhlIE1DUyBxdWV1ZSB0YWtlcyB0aGUgb3duZXJzaGlwIGFuZCBjYWxscyBzZXRfbG9j
a2VkKCkNCj4gPiAgICAgdG8gbWFrZSB0aGUgc3RhdGUgdHJhbnNpdGlvbjoNCj4gPg0KPiA+ICAg
ICAgICAgICAqLCosMCAtPiAqLCosMQ0KPiANCj4gVGhhdCBpcyBub3QgdHJ1ZS4gVGhlIHBlbmRp
bmcgYml0IG93bmVyIGhhcyBwcmlvcml0eSBvdmVyIHRoZSBNQ1MgcXVldWUNCj4gaGVhZC4gU28g
dGhlIHBlbmRpbmcgYml0IG11c3QgYmUgMCBiZWZvcmUgdGhlIE1DUyBxdWV1ZSBoZWFkIGNhbiB0
YWtlIG92ZXINCj4gdGhlIGxvY2suIFNvDQo+IA0KPiAgwqDCoMKgICosMCwwIC0+ICosMCwxDQoN
ClllcywgdGhlIHBlbmRpbmcgYml0IG11c3QgYmUgMCBiZWZvcmUgdGhlIGhlYWRlciBjYW4gdGFr
ZSB0aGUgbG9jay4gDQpCdXQgYXMgdGhlIHN0YXRlbWVudCAiVGhlcmUgbWF5IGJlIGNvbmN1cnJl
bnQgbG9ja2VyIENQVXMgdG8gc2V0IHRoZSBxc3BpbmxvY2sgcGVuZGluZyBiaXQgIiBhdA0KdGhl
IGJlZ2lubmluZy4gU28ganVzdCBhZnRlciB0aGUgaGVhZGVyIHRha2VzIG92ZXIgdGhlIGxvY2ss
IHRoZXJlIGlzIGFsc28gYSBwb3NzaWJsZSBjb25jdXJyZW50IGxvY2tlciBDUFUNCnRvIHNldCB0
aGUgcGVuZGluZyBiaXQuIFRoYXQgbWVhbnMgYXQgdGhpcyB0aW1lIHBvaW50IGhlcmUsIHRoZSBw
ZW5kaW5nIGJpdCBjb3VsZCBiZSBlaXRoZXIgMCBvciAxLg0KDQo+ID4NCj4gPiBGaXggdGhlIHN0
YXRlLXRyYW5zaXRpb24gY2hhbmdlcyBhYm92ZSBpbiB0aGUgY29kZSBjb21tZW50cyBhY2NvcmRp
bmdseS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFFpdXh1IFpodW8gPHFpdXh1LnpodW9AaW50
ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAga2VybmVsL2xvY2tpbmcvcXNwaW5sb2NrLmMgfCAxMCAr
KysrKystLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9sb2NraW5nL3FzcGlubG9jay5j
IGIva2VybmVsL2xvY2tpbmcvcXNwaW5sb2NrLmMNCj4gPiBpbmRleCBlYmU2YjhlYzdjYjMuLmVm
ZWJiZjE5Zjg4NyAxMDA2NDQNCj4gPiAtLS0gYS9rZXJuZWwvbG9ja2luZy9xc3BpbmxvY2suYw0K
PiA+ICsrKyBiL2tlcm5lbC9sb2NraW5nL3FzcGlubG9jay5jDQo+ID4gQEAgLTI1Nyw3ICsyNTcs
NyBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHUzMg0KPiBxdWV1ZWRfZmV0Y2hfc2V0X3BlbmRp
bmdfYWNxdWlyZShzdHJ1Y3QgcXNwaW5sb2NrICpsbw0KPiA+ICAgICogc2V0X2xvY2tlZCAtIFNl
dCB0aGUgbG9jayBiaXQgYW5kIG93biB0aGUgbG9jaw0KPiA+ICAgICogQGxvY2s6IFBvaW50ZXIg
dG8gcXVldWVkIHNwaW5sb2NrIHN0cnVjdHVyZQ0KPiA+ICAgICoNCj4gPiAtICogKiwqLDAgLT4g
KiwwLDENCj4gPiArICogKiwqLDAgLT4gKiwqLDENCj4gc2V0X2xvY2tlZCgpIGNhbiBvbmx5IGJl
IGNhbGxlZCB3aGVuIGl0IGlzIHN1cmUgdGhhdCB0aGUgcGVuZGluZyBiaXQgaXNuJ3Qgc2V0Lg0K
PiA+ICAgICovDQo+ID4gICBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgc2V0X2xvY2tlZChz
dHJ1Y3QgcXNwaW5sb2NrICpsb2NrKQ0KPiA+ICAgew0KPiA+IEBAIC0zNDgsNyArMzQ4LDcgQEAg
dm9pZCBfX2xvY2tmdW5jIHF1ZXVlZF9zcGluX2xvY2tfc2xvd3BhdGgoc3RydWN0DQo+IHFzcGlu
bG9jayAqbG9jaywgdTMyIHZhbCkNCj4gPiAgIAkvKg0KPiA+ICAgCSAqIHRyeWxvY2sgfHwgcGVu
ZGluZw0KPiA+ICAgCSAqDQo+ID4gLQkgKiAwLDAsKiAtPiAwLDEsKiAtPiAwLDAsMSBwZW5kaW5n
LCB0cnlsb2NrDQo+ID4gKwkgKiAwLDAsKiAtPiAwLDEsKiAtPiAuLi4gLT4gKiwwLDEgcGVuZGlu
ZywgdHJ5bG9jaw0KPiANCj4gQnkgdGhlIHRpbWUgdHJ5bG9jayBpcyBkb25lLCB0aGVyZSBtYXkg
YmUgZW50cmllcyBpbiB0aGUgcXVldWUuIEhvd2V2ZXIsIEkNCj4gZG91YnQgaXQgaGVscHMgYnkg
YWRkaW5nICIuLi4iIGluIGJldHdlZW4gcG9zc2libGUgbXVsdGlwbGUgdHJhbnNpdGlvbnMuDQo+
IA0KDQpUaGUgYWRkZWQgIi4uLiIgbWVhbnMgdGhlcmUgY291bGQgYmUgZW50cmllcyBpbiB0aGUg
cXVldWUgYmVmb3JlIHRyeWxvY2sgZG9uZS4NClRoaXMgaXMganVzdCBmb3IgbWFraW5nIHRoZSBz
dGF0ZSB0cmFuc2l0aW9ucyBtb3JlIGNvbXBsZXRlIDstKS4gDQpJZiB5b3UgdGhpbmsgaXQgZG9l
c24ndCBoZWxwLCBJIGNhbiByZW1vdmUgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPiA+ICAg
CSAqLw0KPiA+ICAgCXZhbCA9IHF1ZXVlZF9mZXRjaF9zZXRfcGVuZGluZ19hY3F1aXJlKGxvY2sp
Ow0KPiA+DQo+ID4gQEAgLTM1OCw2ICszNTgsOCBAQCB2b2lkIF9fbG9ja2Z1bmMgcXVldWVkX3Nw
aW5fbG9ja19zbG93cGF0aChzdHJ1Y3QNCj4gcXNwaW5sb2NrICpsb2NrLCB1MzIgdmFsKQ0KPiA+
ICAgCSAqIFVuZG8gYW5kIHF1ZXVlOyBvdXIgc2V0dGluZyBvZiBQRU5ESU5HIG1pZ2h0IGhhdmUg
bWFkZSB0aGUNCj4gPiAgIAkgKiBuLDAsMCAtPiAwLDAsMCB0cmFuc2l0aW9uIGZhaWwgYW5kIGl0
IHdpbGwgbm93IGJlIHdhaXRpbmcNCj4gPiAgIAkgKiBvbiBAbmV4dCB0byBiZWNvbWUgIU5VTEwu
DQo+ID4gKwkgKg0KPiA+ICsJICogMCwxLCogLT4gKiwxLCoNCj4gVGhlcmUgaXMgYWxyZWFkeSBh
ICJuLDAsMCAtPiAwLDAsMCIgYWJvdmUsIGFkZGluZyBhIG5ldyBvbmUgbWF5IGp1c3QNCj4gY29u
ZnVzZSBwZW9wbGUuDQo+ID4gICAJICovDQo+ID4gICAJaWYgKHVubGlrZWx5KHZhbCAmIH5fUV9M
T0NLRURfTUFTSykpIHsNCj4gPg0KPiA+IEBAIC0zNzEsNyArMzczLDcgQEAgdm9pZCBfX2xvY2tm
dW5jIHF1ZXVlZF9zcGluX2xvY2tfc2xvd3BhdGgoc3RydWN0DQo+IHFzcGlubG9jayAqbG9jaywg
dTMyIHZhbCkNCj4gPiAgIAkvKg0KPiA+ICAgCSAqIFdlJ3JlIHBlbmRpbmcsIHdhaXQgZm9yIHRo
ZSBvd25lciB0byBnbyBhd2F5Lg0KPiA+ICAgCSAqDQo+ID4gLQkgKiAwLDEsMSAtPiAqLDEsMA0K
PiA+ICsJICogKiwxLCogLT4gKiwxLDANCj4gDQo+IFRoaXMgcmVmZXJzIHRvIHRoZSB3YWl0IGxv
b3AuIFdlIGRvbid0IG5lZWQgdG8gd2FpdCBpZiB0aGUgb3duZXIgaGFzIGdvbmUuDQoNCkJ1dCBq
dXN0IGJlZm9yZSB3ZSB3YWl0IGZvciB0aGUgbG9ja2VkIGZpZWxkLCB0aGUgbG9ja2VkIGZpZWxk
IGNvdWxkIGJlDQplaXRoZXIgMCAodGhlIGxvY2tlciBjYW4gcmVsZWFzZSB0aGUgbG9jayBhdCBh
bnkgdGltZSkgb3IgMS4NCg0KPiANCj4gPiAgIAkgKg0KPiA+ICAgCSAqIHRoaXMgd2FpdCBsb29w
IG11c3QgYmUgYSBsb2FkLWFjcXVpcmUgc3VjaCB0aGF0IHdlIG1hdGNoIHRoZQ0KPiA+ICAgCSAq
IHN0b3JlLXJlbGVhc2UgdGhhdCBjbGVhcnMgdGhlIGxvY2tlZCBiaXQgYW5kIGNyZWF0ZSBsb2Nr
DQo+ID4gQEAgLTM4NSw3ICszODcsNyBAQCB2b2lkIF9fbG9ja2Z1bmMgcXVldWVkX3NwaW5fbG9j
a19zbG93cGF0aChzdHJ1Y3QNCj4gcXNwaW5sb2NrICpsb2NrLCB1MzIgdmFsKQ0KPiA+ICAgCS8q
DQo+ID4gICAJICogdGFrZSBvd25lcnNoaXAgYW5kIGNsZWFyIHRoZSBwZW5kaW5nIGJpdC4NCj4g
PiAgIAkgKg0KPiA+IC0JICogMCwxLDAgLT4gMCwwLDENCj4gPiArCSAqICosMSwwIC0+ICosMCwx
DQo+IA0KPiBUaGF0IGlzIHRoZSBwYXJ0IHRoYXQgd2UgY2FuIG1ha2UgdGhlIGNoYW5nZSBpbiB0
aGUgdHJhbnNpdGlvbiBkaWFncmFtDQo+IGFzIG5vdGVkLg0KDQpTb3JyeSwgSSdtIG5vdCBjbGVh
ciBhYm91dCB5b3VyIHJlcXVlc3QuIA0KRGlkIHlvdSBtZWFuIGp1c3QgbWFrZSB0aGUgY2hhbmdl
ICIqLDEsMCAtPiAqLDAsMSIgYWJvdmUgaW4gdGhlIHRyYW5zaXRpb24gZGlhZ3JhbSBvcg0KYWxs
IHRoZSBjaGFuZ2VzIGFib3ZlIGluIHRoZSB0cmFuc2l0aW9uIGRpYWdyYW0/IA0KDQpUaGFua3Mh
DQotUWl1eHUNCg0KPiBDaGVlcnMsDQo+IExvbmdtYW4NCg0K
