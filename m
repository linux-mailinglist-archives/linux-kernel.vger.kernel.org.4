Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F5067ED5A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjA0SXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjA0SX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:23:29 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7552C18A98;
        Fri, 27 Jan 2023 10:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674843808; x=1706379808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DqPymyxn/Ja6vLC1joCUA9FXMKDQd84qqsYozpR0i7k=;
  b=T0RMaDFkCh+Hw/Y6mQYDTbOe0sSxkOmenfZTobJwMXesfrzto1+UoIem
   17De0eplQXPV1FB7kRAWXEoV7P0cVaA9I3EVy9lygxd8E1JUMqBR1zDMu
   4GWtCb/TimmcwLuX8sGdiG1zpfpgTAJ5U/ZXu3+ek3fFifaBelTy2wjdB
   jq2k+wb72uys/NlISvN97s32mhYctIXeaTF8K+/F5RFH1lLZ2R2XYL+HU
   M93p3Ki3WEFnBX47S959JyU1JpEbTnwg86wyAUD+EeXIAuzz2gKeOWm01
   sjFkgnPXgwcxwCC1SoUWhPpJz+Xm78NJtpI42Bb92SyOufi9HEJn2/QAz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="325823095"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="325823095"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 10:23:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="613275447"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="613275447"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2023 10:23:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 10:23:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 10:23:25 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 10:23:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4A8AYLg/M3Q490fj22uGsuM03xjid45nvi3HXJARJcuTzR/Ro+/2AzbY1tqe5Vp2oNtYUNZ8x+2WET79O/6CDUsFX0SUXPFIRUNRkwbcLpCJa15JqrZnzYfRf6Em0MOeDmELXV4osv7nl/oYmVoJt81mlgRlGXoOUMyvVbk2kfK/Hodbo+lXzFkd7ZYD2n3JcbGUB6grRNxcb+sj09NtjdZOAC8vM6z+SlOd45uCfm53jiA3+fRtvAVubm4Se0ODElTySZLTr8RE1Pyqzl0wnypq3lV8X3XbK61+p4GBdTu/hcUN47fnZ3GUIDLGiGvGguGfHAkRB1bWkUWiBleNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqPymyxn/Ja6vLC1joCUA9FXMKDQd84qqsYozpR0i7k=;
 b=eXOS8GFKryISXOSCMQl2XGDzkpYqkalq2yoE/NVgrKbMd5NYI0ZMZtRLLAWdTs3wPAlLEYDWvrX31wJ4RNoUhUP1FmsFeaGYr3RPG0/DuX5WzZoN8g9vdu0uFSNcRIn4fkbS7Go++diHjnyue1zm/uqvN2QqsSOU4P6RFjIJR2VUZLplvTWyEgARVS4/yitkW/gEb7tJ7zTcSFfqhZxR/SqDqBNS1TqI2AMVt34xxsJSSWfQeiivwJjs+R+VcGYmXYR/cJd5obDEGINur2oxh05EHmiKNdZfqqm/gIsU/+9T9pcYrE6DvcpzOmOTUhRhL9Py7Ezl6LwwXVl74ZHRmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH0PR11MB5412.namprd11.prod.outlook.com (2603:10b6:610:d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 18:23:20 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%7]) with mapi id 15.20.6043.021; Fri, 27 Jan 2023
 18:23:20 +0000
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
Thread-Index: AQHZMbXmEMfKBNwkSEml6dDHhSj5la6xu/MAgADWybA=
Date:   Fri, 27 Jan 2023 18:23:19 +0000
Message-ID: <SJ1PR11MB608302C99598570098E40102FCCC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-4-tony.luck@intel.com>
 <IA1PR11MB6097400A3056553FCC8E193C9BCC9@IA1PR11MB6097.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6097400A3056553FCC8E193C9BCC9@IA1PR11MB6097.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH0PR11MB5412:EE_
x-ms-office365-filtering-correlation-id: cda7d4da-b4eb-489a-30ec-08db00939133
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cEAUdSFsgrIS1eNN7cuLjCu2dKf0IUK5Xqj2CYJyZ1oRO70DoTE9qs5LdVdEJhGB2vdc02RqMSoWgKDFqelx56bNZtQV0AO/rwmx62nrVfN6D/QNKwlOIpGru1wldiE5QyvAU9U0mPSpNJw1BrwGPKqR2hPTyFdg2W0r56f25SEkFqof4rlgSzfL6pTXnsZAUQIZ++KWqR9imTt/uGQTs5DW7lWHgldl5VqZuUqW944Tmpk2n8ElMl2WzsN2qW6htlzdtBtr5XV6y9CZ1CcC39e0MKSGg0Z9yr8khFN+4rnY8/YSvzFcIPXCshNeR2z8W8XGKtOWy71hh+d7ieL8cFFrMxU9a3TzExv2uyygo3LNKPn6CLkdehyVxmO3qZ/LEBrxOMYSxMOJASanGWgIKxRy2xktjRsov9V53HH4/ASvF1fCVfko5rfwq5Qr6B0+XBXtWt5VobMpsFxh8TvJs2bhSnvf4DoXSgpWfNo1EKw++EJe1YBOqaQiHzS0nSJ+tajwfCldrVhVYxAapn6eD9vcEC6vxoCULrmovIw71U6Kf/7cbRK3ezxnQDk860XB84DB2grcDCfYBP46wv9/rHLehDHHxwZF0sCN7ylw0YGbo2xSGk16nM/nodB7ZRRFQMejxKe4SQgIvnlkwIou89oErPOiD0YBlmCrdbQL9WqjwDxjr3cU5qjd9eMB6O5tWYdAv6LB09C2RLuxl/O+wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199018)(122000001)(38100700002)(2906002)(186003)(110136005)(71200400001)(52536014)(8676002)(86362001)(54906003)(7416002)(41300700001)(82960400001)(316002)(66946007)(66476007)(33656002)(64756008)(66446008)(83380400001)(66556008)(8936002)(5660300002)(55016003)(76116006)(38070700005)(4326008)(7696005)(9686003)(478600001)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajZNMlVlYkdUSE9jRFFjL0hLKzhTcCtCOWFmRmt0Q0Y1VlNRbDVtdUVnWDF3?=
 =?utf-8?B?V0VlREZ1QWJuNng2dTlQNFcvdlIyZHNPUXNYZUx6NDRoMnM3V2wvNkxNRVpo?=
 =?utf-8?B?OUVHNnBxSDhCU1dPTmJkUzhta3RlRzVKWEhGcnlhQ2lSRW9vZFZkUjd3WEhM?=
 =?utf-8?B?WEhWUkI1OW9CRk90SHM2bGJNemJRZ0FLWTRTUnFsZlNVQXduSXlNemJBMGdP?=
 =?utf-8?B?WnNVL0xVQmFPOFQ1WlZVeGtWVVZ6dFNMMm9pTkNSK2RqWDc0K00rT3plR1Z0?=
 =?utf-8?B?bkxxS2xMeTBaQ0VHWW1GTE1DcGs4R1FjM3NuaEQyU045N1B3dkt1Z3plcUg2?=
 =?utf-8?B?am9Bd1VmK3lZdG9qSko4QU1LYXY0dFhwakIxN3NwKzhaenZZUGNsa3g5UXZr?=
 =?utf-8?B?alVOT3BVMVl6SUhlVlV3cVRtRC9jV2VUdHJ4SDFpOVE4UTB5ZmovVCtLdE40?=
 =?utf-8?B?WktjNnpKTW1pclA2QjliOHAzdkdwVHdmNFg3N1dybTVEUDkyZkZBZEs1T0Z0?=
 =?utf-8?B?bnBuM0FQRVBTejgzaHdoV1dxSUhQSHBqeGs0OGhZRW95WisyWTdEMk1GaGtV?=
 =?utf-8?B?dW5iMjVsOTIxMTVhY2hTanV3Q0Fuakw0NGhFSGtPQVgwWi8rdnNQdnlnVzV4?=
 =?utf-8?B?MDk1ZWV2a3FiSTBSaElzSXBmVEVFKzhPaU9uQ0JxZ21yM21PemNMbXVrZUo5?=
 =?utf-8?B?M2VWU2VrcTQ2TFpMN0MwZ3JKdjE4ZWxyZGRtalRBSWgwUVQzTVlJVXRocEd5?=
 =?utf-8?B?WFhyMElrN2txcjdxS1d6WWVMVS9kMVZxbE1HRUFBQWNqbnlDYWw1aW4rVGYr?=
 =?utf-8?B?T29hWGUvQW9kY1kxQ0RzeURMdElFNGwxUUpWdGxHNS9aUTJDOG5HOStIZzds?=
 =?utf-8?B?UGI2WTRTWjg4b09LcHhSMkh2a2dRcHo5Um9iS3p6bDlJUEV6VFRibTZ6UGRl?=
 =?utf-8?B?UEhBNzdJK0FtVi9GRFdHQzN3SzI2clJ0dHl3WGV6b2U5YVJVTldVcEFvdmgw?=
 =?utf-8?B?TS9zOGN4bTNUWEk4NUNqT1NYWHVXcFUrQ3RzQzlpeHJ1Mm0vNG1VQWZlU1BI?=
 =?utf-8?B?M0pISXIxeGVKZHdmSXdWUUNkSit5aUpMcUxyaFpNc2FpclZzMVRyUjJNb2Vm?=
 =?utf-8?B?T0NEUithMjJrVE9aaGZqL2lFNnQ1RFR1SGtwWTlKMFB1R201UzVyVjEyUlZu?=
 =?utf-8?B?Qi81MTc1L29TWGs3N3A2U1J5YUppWkVBOGZ6YitNd01wb1FkQStSNWNZSng0?=
 =?utf-8?B?Y2RNTE1TNU84UDNWU1J2N0l0aldMVDlRaFNlZVByc2RxUHF2eERyancyNlJH?=
 =?utf-8?B?OWVvbU9ieDNZbHhvc3ZIWTRRVGVUbWlQa1djcmxiODNzd0VFV3lZZkl0VUw5?=
 =?utf-8?B?bHg2VTZGVlMxcVhmUnUzOERpdC8xUjMwbmtETzlEMkRteFdlU1ppdVJuVW8w?=
 =?utf-8?B?TjlZUHRpZDFpTURJdHA5WEZhOGJHakZNMWRURU1oa0dIeGROcCtibmNmMXBP?=
 =?utf-8?B?Y2QwTU0yajhHNkhXeU9iWU0rNzlsUGFRMFZndDBBdEZrTkNOZW5TNm90c1Q1?=
 =?utf-8?B?WlZlSmYrUlJFUmdISExRSUlxL3VabFhPSksrbnFsdzBZN2p1Nm9qdVFCcGdz?=
 =?utf-8?B?MXErTG0xUlJMRUtiRFRFVEduK2p1S2JpWFpQc1F2TVV2Sk9UQzF3V3pwOEZw?=
 =?utf-8?B?dUJ6QWticlRzbnRpZ3llR05kd1N1VjNXenc1VFZ6T2RYczJjRGQycVdacTJH?=
 =?utf-8?B?T2FKakNZT1UxbTQzdlBLQmtTd2YxSzNHRGFEWE1IMkN5L3pUTHlaL29vOVZ0?=
 =?utf-8?B?NnhvWUp0UDhtRG5KUno5MnFlSWN4c0h2ayt5d3ZTLzhzUDZMOTVvMkJEQUdW?=
 =?utf-8?B?UEhaMnh3cVFITWRKemFybFVwbVRkL3RpL3VMcTF3QkNYWlJvczFCWU1manFp?=
 =?utf-8?B?T0ZjNDltM1k3TkhhVC8rZXQ1b0Y3alp2YkVLMHhpOFhuQ04vMW5GK0lhZ0J1?=
 =?utf-8?B?RnVES0E2YUFBSDk0bm02T3l4UkZKdGhFamUzVTIxODJ0aDZsM3U3TUE3bXV1?=
 =?utf-8?B?STNCNmFjQzJBZ2hqSU9rcnRkSTcyRWhlaFpuWmJzV2w0RFd5enpPSUdHMVda?=
 =?utf-8?Q?m8SLHHDBxeA0N6OqT8qbEkqAb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda7d4da-b4eb-489a-30ec-08db00939133
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 18:23:19.8676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Xo4Ul+ph3euBMAlmAEi/L+QcKUQye+0xc0zD7N0985ArrzgF2c6u8yNjUcd3wGsCPnNBHi+ONr9RObtJcjk+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5412
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gKwlbUkRUX1JFU09VUkNFX05PREVdID0NCj4+ICsJew0KPj4gKwkJLnJfcmVzY3RybCA9IHsN
Cj4+ICsJCQkucmlkCQkJPSBSRFRfUkVTT1VSQ0VfTk9ERSwNCj4+ICsJCQkubmFtZQkJCT0gIkwz
IiwNCg0KPiAiTDMiIHdhcyBuYW1lZCBhcyBSRFRfUkVTT1VSQ0VfTDMgYWxyZWFkeS4gVGhlIGR1
cGxpY2F0ZSBuYW1lIGhlcmUgbWF5DQo+IGNhdXNlIGR1cGxpY2F0ZSBmaWxlIG5hbWVzIGluIGlu
Zm8gZGlyLiBNYXliZSByZW5hbWUgaXQgYXMgIkwzX05PREUiPw0KDQpJIHRob3VnaHQgdGhlIHNh
bWUsIGFuZCBteSBmaXJzdCBpbXBsZW1lbnRhdGlvbiB1c2VkIGEgZGlmZmVyZW50IHN0cmluZyBo
ZXJlIChJIHBpY2tlZA0KIk5PREUiIHJhdGhlciB0aGFuICJMM19OT0RFIikuDQoNCkJ1dCBteSB0
ZXN0ZXJzIGNvbXBsYWluZWQgdGhhdCB0aGlzIGJyb2tlIGFsbCB0aGVpciBleGlzdGluZyBpbmZy
YXN0cnVjdHVyZSB0aGF0IHJlYWRzDQpjYWNoZSBvY2N1cGFuY3kgYW5kIG1lbW9yeSBiYW5kd2lk
dGguIFRoaXMgc3RyaW5nIGlzIG5vdCBqdXN0IHVzZWQgaW4gdGhlIGluZm8vDQpkaXJlY3Rvcnks
IGl0IGlzIGFsc28gdGhlIGJhc2lzIGZvciB0aGUgZGlyZWN0b3J5IG5hbWVzIGluIG1vbl9kYXRh
Lw0KDQokIHRyZWUgL3N5cy9mcy9yZXNjdHJsL21vbl9kYXRhDQovc3lzL2ZzL3Jlc2N0cmwvbW9u
X2RhdGENCuKUnOKUgOKUgCBtb25fTDNfMDANCuKUgsKgwqAg4pSc4pSA4pSAIGxsY19vY2N1cGFu
Y3kNCuKUgsKgwqAg4pSc4pSA4pSAIG1ibV9sb2NhbF9ieXRlcw0K4pSCwqDCoCDilJTilIDilIAg
bWJtX3RvdGFsX2J5dGVzDQrilJzilIDilIAgbW9uX0wzXzAxDQrilILCoMKgIOKUnOKUgOKUgCBs
bGNfb2NjdXBhbmN5DQrilILCoMKgIOKUnOKUgOKUgCBtYm1fbG9jYWxfYnl0ZXMNCuKUgsKgwqAg
4pSU4pSA4pSAIG1ibV90b3RhbF9ieXRlcw0K4pSc4pSA4pSAIG1vbl9MM18wMg0K4pSCwqDCoCDi
lJzilIDilIAgbGxjX29jY3VwYW5jeQ0K4pSCwqDCoCDilJzilIDilIAgbWJtX2xvY2FsX2J5dGVz
DQrilILCoMKgIOKUlOKUgOKUgCBtYm1fdG90YWxfYnl0ZXMNCuKUlOKUgOKUgCBtb25fTDNfMDMN
CiAgICDilJzilIDilIAgbGxjX29jY3VwYW5jeQ0KICAgIOKUnOKUgOKUgCBtYm1fbG9jYWxfYnl0
ZXMNCiAgICDilJTilIDilIAgbWJtX3RvdGFsX2J5dGVzDQoNClRoZSBuYW1lIHVzaW5nICJMMyIg
aXMgc3RpbGwgYXBwcm9wcmlhdGUgYW5kIGFjY3VyYXRlLg0KDQpUaGVyZSBpc24ndCBhICJkdXBs
aWNhdGUgZmlsZSBuYW1lcyIgcHJvYmxlbSBpbiB0aGUgaW5mby8gZGlyZWN0b3J5IGJlY2F1c2Ug
YSBzeXN0ZW0NCmVpdGhlciBoYXMgU05DIGRpc2FibGVkLCBhbmQgdXNlcyB0aGUgTDMtc2NvcGVk
IHJlc291cmNlLCBvciBoYXMgU05DIGVuYWJsZWQgYW5kDQp1c2VzIHRoZSBub2RlLXNjb3BlZCBy
ZXNvdXJjZS4NCg0KLVRvbnkNCg0K
