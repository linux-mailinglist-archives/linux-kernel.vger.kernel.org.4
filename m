Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5AF6819D2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbjA3TEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjA3TEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:04:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B7F3928A;
        Mon, 30 Jan 2023 11:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675105471; x=1706641471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e87e+2cmkfs3sUxWfrf+j6pV9I9QIZnUEi2Be2bo5DE=;
  b=JAsYPCwY8NchE1T0LFrRnPVcms8t7W7VHjODuGzjJ0+Q50eTAk/Z5z77
   VC9a3rEH4x8MRDTa4lJgvTn7jK1IYL6vdI3hBWqhYCpwNsVXoTgZdZMkl
   16RpLhGg+K9ptW3s+fIYdvHVUsmTJMghTgj2GYN5Ny7FLOo1uagoLZ2Jz
   kcxHiFjlUX72iCtg/Z+kAPsC0uAX+Vnufc4PBQqIMvXKHZ6ekfCwnmdSQ
   IDsdSnmzAhK1Lz54ALta0v2mkXT9T5ypSp6gLG72+MPqx1v8MsAYxichz
   Tz0YV1z6TROa24yBmfzpZJnf2P9DtIDnLfSlJnvJI/EA00aqMOIqN1NT2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="354966678"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="354966678"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 11:04:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="666185325"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="666185325"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jan 2023 11:04:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 11:04:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 11:04:30 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 11:04:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGSbLa5mxJqFFvcPmUukok5AmCIzns00ktxO3a/6LAKFzJnlyEdRdxIrKjp7fOXET4axAJrSD2Lv4qWJxEPBpfUohv2u64zMPu8k5RneZDOgvEBGV+UYi+d89+6kcBNUzCu6czu6fFOZ3s6u95w7uWPiI4dp/cnwaLYm4fTgwNkrnrG+3lpY7sTMcSo7SoeNNifj7wLHzNO+gzO0rVH4H7GYJ4JBqNSHuJq0AMjLfRzSVvEt2OA+uz3Y52FbMGggLZNw7Vql2n6cBnqyBoG/UhH0EAOV983xF3sQ/U8ZdIy+yVYrHt0IIMchesIYeVySFlJYENpT3TOMOc6PPLlvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e87e+2cmkfs3sUxWfrf+j6pV9I9QIZnUEi2Be2bo5DE=;
 b=a/3eqANTZqzX6i+WP25CVAWyHZD9icInmQ/wQWXCiRUEO3SthQV5WLIpcWAEb3KCPGupznhFgmWrNn+1hfXpLzq+Cbo3i0psoUJtzBxfAcv5KHmg2M5KxT6lxAlZZ2yshbOUOI9MkQVzAlkGQWoBT2Xf9tVuqspSyB2nVB6olNpA7haZEMACZFucIdmp+guOVu7xlpG+ruKeepkwnjwLBXb9+pa/mZyFEqaWFquYm6/iSeiUUCYu8KtQOOhe5lCLhoFLEbmttszIUAKDhCGskE7uxO0L9zWYUUdahCM/b2HQost90M0fsuoaKmI/rUg0QscT4pL2zYgj39fAUXzdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB5968.namprd11.prod.outlook.com (2603:10b6:8:73::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36; Mon, 30 Jan 2023 19:04:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%9]) with mapi id 15.20.6043.030; Mon, 30 Jan 2023
 19:04:28 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH 3/7] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Thread-Topic: [PATCH 3/7] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Thread-Index: AQHZMbXmEMfKBNwkSEml6dDHhSj5la6zHy0AgAQ4BoA=
Date:   Mon, 30 Jan 2023 19:04:28 +0000
Message-ID: <SJ1PR11MB608383393C4A35CBBDC967E9FCD39@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-4-tony.luck@intel.com>
 <IA1PR11MB6097E0EA2E2F71868C845B159BCD9@IA1PR11MB6097.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6097E0EA2E2F71868C845B159BCD9@IA1PR11MB6097.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB5968:EE_
x-ms-office365-filtering-correlation-id: 07ebb516-6518-4b3c-62c6-08db02f4cf99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HVua/oB9Cw+tRYDFROor10iFSFrm46QOUxJHky7xS3YFOaR4WFEtRbsoIt3AmrZuhvb9ZGBy3F2OM4QtsMCALcetqfz2dbf4Z2cWpq4oUkloUF0rLaln62/J6JeJCHOyq7xxLWqEZQZ1RIWA1qqKJwSicjr2b4pzUECpEXuKO3BF+1kbrBgsYaPnzSK6udaT/xj5Z3Af7lU61Lw1qYTd0hFcizmq5Yuopj9kQTj22dhTWGt2iKVBgjBsl6Q1Ju4rfP0qN+GMnZHHYO4vgFeJ1eSxJbk/djSXU/Xn8cqrfKuGeh5zDSj+Q4MKE/eHvAwUxyRe28d9x83/slRdpsSh+BLMf1XLMK7LRLrA01V/LhgRy5O1GqJLdqlBpTmC5gp71iWrnp52jYoAQkND3KXZalEFHyPYr7wgw6Gm7oJ3ZnnhybvTkH9tcxrrhNiClFdVg0DJGWbjtPfvqsw07S0cbFnn0wD2fTkZ2elIStM6uPjAkutWnTY4tTtARrQ7/UVyvRHiHNjbaHm1VA242+jLri5i0EbOH1DRhR1HNmbaYA6OxpvFbYoGUgfcU/GhWEtwMECAFqZQIxNOmGIfPMqx2YgY6iZPPcF3CF5MKRAjlLCxYNLQl5IEwNrJjfjT3zGTXH7IRU4Uy0rK5ZzOFt5Ac4Zp0G7cprF7PxWK8ie10wwmfL/6G8EDmSo9w9+zSlk3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199018)(33656002)(71200400001)(7696005)(8676002)(66446008)(64756008)(66476007)(66556008)(76116006)(4326008)(41300700001)(66946007)(8936002)(478600001)(86362001)(82960400001)(122000001)(316002)(2906002)(52536014)(38100700002)(55016003)(26005)(9686003)(38070700005)(6506007)(5660300002)(186003)(4744005)(7416002)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnRzTFh0bk0xRUxSQjQramVVaVYvYjA1dHBUcnNGNy9LaTNYV2s3S084OENT?=
 =?utf-8?B?Q2RZYmJPVU9nNDNndjNvUnZ4SnpvZWZQRTYwT0lOdld2MDltT251Q3dRazFN?=
 =?utf-8?B?Yzg4dHdJRjJiS09manR2dklObHFFODkvQm44WVVPTUlYMWVUZnhWMDYzSW1T?=
 =?utf-8?B?bjJpd2I5VkUrY2ZBdXZsMGRZRmEzT3RNcXdWWUlTak1taUcyU1djdTloTlJv?=
 =?utf-8?B?K2l3YUIwRkE3dnJJNTdWbTJGL01Uei9BcjN3N3FwRW9vMUlwcHRJOXRaS2Iv?=
 =?utf-8?B?RFlBbkVtY0lNMVpqdjgwSDNaT3g2b1JraFZRV0lCVXhDSnMwRVZRazRHcG51?=
 =?utf-8?B?REsyM3lKeW41dUpaUjdxM1YxbmNUcEJlOW9rVkdmZGJ6VFg0T0JtNzNteXpl?=
 =?utf-8?B?Y3pTMkxJVW9RMDdST3dmY0FwQWpmQVpzcW9lK3E0cDh1a1djU0NheXBqRjlM?=
 =?utf-8?B?WFVMWUR2ZkRXZXJVZkFWd2pWT3pXQVJDSUltTmxvWDZ0UEtIczQrSGJvU1cv?=
 =?utf-8?B?TjAxM015V25pcUdySm11UzNyR3BOVWw0Tis0ZEIvMERXMGpIdlRFbVJCQnU5?=
 =?utf-8?B?QVNWWDNGd2x3YjB5RzY0UGd4VjdrNmVnYmtiZWdJVmpyVG5RWGFMMXhRU0Nq?=
 =?utf-8?B?aFlFbVdxNVluMkFmaXN3V3lOdENBSVpFTzV2VWZ6dHQrOTNiYXJqc05KQ3pO?=
 =?utf-8?B?KzlYdjBxaTE3WGlVb1JSYUZDZTk4UHRubENpdXZtenkxaW5hbGxmUW1vMEJT?=
 =?utf-8?B?ZE1yQ0c5aVMyaTlpRk5qMUt4K0FTMFA0cGxHQUREM29HWEtVYkVFYkJ5VWhG?=
 =?utf-8?B?Rnl2K09LSERkU3NJbkI4Z0xiNE9mUjRTeCtKUVpZMXBlL1BUR01wMUgvREgx?=
 =?utf-8?B?VVVxVG5rb2Z2SERvVSs5MExRbFp5UG0vSVkrZDBuMTdxYzE3OEtZbTJrZkFB?=
 =?utf-8?B?SFJiZlNWdllpRDR5VFlnS1NqS0dBazBJZ3BqUkdVdHU4MFJBUTUvUXVwWVps?=
 =?utf-8?B?ZUxkUUIzVThtdnZieXc3dk9zVURsWThGMjRNZWpyRTdvUjVxREc5RjdwMEsz?=
 =?utf-8?B?UzJ5R2J0RUF6T0tKSndiZ1M4NG5zcWJBcG4zbTgrVmdQek52SWhIODdOQTRx?=
 =?utf-8?B?eE0rWnplTW41dkExTWRkOTlrWnczUEVpMytzNzFHYkpxazVRd1ZzdEpCYlkv?=
 =?utf-8?B?TmlaUjdCOXZOR3NlcTNIUFlXUVdjMUxuVFhjdlpZMjU3blBUOGdWQnpPNVda?=
 =?utf-8?B?Q0VDUS9SamszTFY4M1QvQVJSTEdsaDdBeHg2QzhWQTNjSm4vVG5jeGQxMmNE?=
 =?utf-8?B?a3JGS2ZQdTFlUnNYRGJMYlFLV1lWMG56NkEwb3J1Q1RuVVAyOGp3Vkx5Ri9H?=
 =?utf-8?B?aE1XOEc5Z1A0cjViOTk3VDE5a1QrUE9oZjFha0VaWW1EQzFqMkg2OEdXMm5z?=
 =?utf-8?B?ZFc0WFczYk5FVFZCajZvaDluOERBSkZQRGNGdnZWRVdFT1dTWUthODI5L0dF?=
 =?utf-8?B?c2l6YnNkc1lZaUFRZnJxSGdCZkNsbzVtVUtBaUtlUWhoNWlWNitKTXhQaHlw?=
 =?utf-8?B?dmkxZGdXR1A3aUNCTjFVYUk5U0tUWDdOc2RXUzhjT0NnMzRCYitja0RnWDNp?=
 =?utf-8?B?aXBwcGNDLzIrNzE2dHJ0VThzRjN5RGUrODhFUlpiaUQ5dTgzeVBqandWWXha?=
 =?utf-8?B?QlpxR0FxdlhEN2Mvd3dCRlltQzlHRU1JZFExVGNXYnlKM1QvdG1UekhOZVM1?=
 =?utf-8?B?N1dIWi9kOVlQSUM3TEpBenh5S29XN01kSWlxZmFkRFNacStRRlNvdTJVM1Nl?=
 =?utf-8?B?dFFjY0hNbjBtKy80dTl5R0dXSnBwc3dkWTJpSWJzWGFoanZzQWJjOGRJdzZv?=
 =?utf-8?B?cFlqV3IyMnYrdExGNlp2dGpxdTFuYXZRbW9vcjMyMm5Zb2JtSVpRbmxpbXVy?=
 =?utf-8?B?TFF2bzFmS3AzemZaSWhjV1lnUE5jNTdBNVk1ZU9KcHd1WW5IK2YvY0ZWekJz?=
 =?utf-8?B?ZHlVU3A2OWUxVkNwWHo4QUVRQ0lLTWo0czNzNFpvczJZWTh3NnBXSGhZYXFY?=
 =?utf-8?B?Mml1dWx5OVcwa0lmOHZzNzh2Z3dDaTUxN0dZemNiUkdFU1BOYUorYkpodzBX?=
 =?utf-8?Q?gALffhF+w5J9LTRo/9Zb8GDA3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ebb516-6518-4b3c-62c6-08db02f4cf99
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 19:04:28.1112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zV9UhkmS5bAerKkCALVA7TmE+ykKD+/Nif4T/LfWZH3gfraw1fdUplmxPCIK5gd8cqwj/DbGq5XWPdpelxQP4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5968
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

Pj4gKwkJCS5kb21haW5zCQk9IGRvbWFpbl9pbml0KFJEVF9SRVNPVVJDRV9OT0RFKSwNCj4+ICsJ
CQkuZmZsYWdzCQkJPSBSRlRZUEVfUkVTX01CLA0KDQo+IFJGVFlQRV9SRVNfTUIgaXMgZm9yIHRo
ZSByZXNvdXJjZSB0byBhZGQgc29tZSBmaWxlcyBpbiBpbmZvL01CLg0KPiBCdXQgdGhlIE5PREUg
cmVzb3VyY2UgZG9lc24ndCBoYXZlIGFueSBmaWxlcyB0byBzaG93IGluIGluZm8vTUIuDQo+DQo+
IE9ubHkgc2hvd24gZmlsZSBmb3IgdGhlIE5PREUgcmVzb3VyY2UgaXMgaW5mby9MM19NT04vc25j
X3dheXMuIEJ1dCB0aGlzIA0KPiBmaWxlIGRvZXNuJ3QgbmVlZCB0byBzZXQgZmZsYWdzLg0KPg0K
PiBTZWVtcyBubyBuZWVkIHRvIHNldCBmZmxhZ3Mgb3IgZmZsYWdzPTAgdG8gZWxpbWluYXRlIGNv
bmZ1c2lvbj8NCg0KSSBqdXN0IGN1dCAmIHBhc3RlZCBmcm9tIHRoZSBMMyAuLi4gb29wcy4gSSB0
aGluayB5b3UgbWF5IGJlIHJpZ2h0IHRoYXQNCmFuIGV4cGxpY2l0ICIuZmZsYWdzID0gMCIgd291
bGQgYmUgYmVzdCBoZXJlLg0KDQotVG9ueQ0K
