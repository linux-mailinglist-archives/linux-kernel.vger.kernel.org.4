Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181B373E4E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjFZQXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjFZQXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:23:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BB43AAA;
        Mon, 26 Jun 2023 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687796466; x=1719332466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZFrWQM1yydlOxSLIwXRqtCTmms6eovZUeHNHiUkZf8I=;
  b=E4z7o+3ZFkunLddVpwPavXqO82/gIuQyDabxCnzuUui0GFbBXF/18RBT
   MB3i9JSgVYf3rQLZcC/SIASy8BTIRjl3UexYI+RjQGGndnsy/s2z+LfVX
   w1IkD6EdRJc48StbmMMW+kv6PNM2cSEwa+xpDV6QOgLOQNMZjQE+gG9Ih
   Ud48zucfxABMwrioMZ/3s7Mf7dhJiCoNfZWLjCmUZNtPrftEZVF3nyUG8
   fi+oB4a1cQVoA753i0Rv2VoYJdM0jb72KsbHliXe8xK3m/TPeKyUG8y+o
   PIygLRF/i8UsS6JAdkCz5A9wrqiFAWuDiDyihz21dKJTfkAODXPcYkCdy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="351093425"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="351093425"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 09:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="962811318"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="962811318"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2023 09:20:23 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 09:20:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 09:20:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 09:20:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWoXuuxklzbDJ45MAe3A1xhBb4RLBRL5/KNJ3CK3gZhjT4TVq6ZbDjnkJHxoO1kY12MoajgAEVJwEexcdMSi82GJJHPGIjhWdn58sNgTmLpaSTgX/dnC/N5fhCmEUM3FU/UGzbO7x4K9ETwhCTxGlaMVBNWBLC/3HzXLyUhmuKVYkKAR61bFu7DFPbipFncXfHNWrjfq1OORQCMFaAeq4qcPpycdV5xCTN3gQnENcP10yu2rlaWkxi7julsK9mpswyWFTAO7KWFF7YyAsrA83h6F6P2z708AvoiArevATsoWmTq64LfILtCZ9HhcW+GJ+81g8QLF3OBqy9/gmGMbcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFrWQM1yydlOxSLIwXRqtCTmms6eovZUeHNHiUkZf8I=;
 b=Z6KyIrBq+F5kEKjo8+kBqBYA/7bF9pzygYpV4Y/qjxo5T7RB0X5om+W6oDFJf5Npi0JybAifDvICmDdvd8R9C5DRHCtczmx6cPPNk25qeUOQPHBb/EbaXmBAmoQaROKlkxU4ZzU0mgKszfJ36BgXNyb3YdUV6evmu1j0pSGY3p4UaA3YYD2omn9Raozjx0GLtxjaqb9NoYwpHbt4ClXgj5ICi91uB+zM1iNyUqeo7O2r6X1cwpXv9uoesLTyam7D/DAIqjup0/PKOuj7TFojfC6rj6ALI2K/oZgiPZEaPrPooasVbV+cQ0hD26udN4Readf0MQtCxIkf7JSkyBLSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 16:20:20 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 16:20:20 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Newman <peternewman@google.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Thread-Topic: [PATCH v2 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Thread-Index: AQHZpGd48oRuL5v3EUiLea9/WFe4Sq+dD/cAgAAxwVCAAAj1IA==
Date:   Mon, 26 Jun 2023 16:20:20 +0000
Message-ID: <SJ1PR11MB6083E459733A60D1A8C02A53FC26A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230621174006.42533-1-tony.luck@intel.com>
 <20230621174006.42533-8-tony.luck@intel.com>
 <CALPaoCi+A5TxoReh=HRMsRKYDWb4eQ-NOB75Lj9674L6aV0T=Q@mail.gmail.com>
 <SJ1PR11MB608334F6555F9CEF3F740DE8FC26A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608334F6555F9CEF3F740DE8FC26A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY8PR11MB7747:EE_
x-ms-office365-filtering-correlation-id: 0511b1db-8e9b-481b-df35-08db76613cb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1hFRkochHYADVEzlI5wnxB0oc85Y4qk5DNsw49DetzT9QWCmct8OtH73vEk9M/O3tz+9+7zfHpmUZO/TgQlqbyR7QU6oCdS9o0Lph/tPt6DVbRZh0x16QoJemukF2F5485eQb8te0A2eUYBlkUfGrxPpFlAb7XUMtQObw0iuLoTK7Tk3zD5iT+0aix8vXNQ+AVeqg12vcMO2Rgzi7MZ15SFgMUBzxaRP+S/PZYk/ZieP2/aCl/Oova+s7vTUac8ZvM479IWwuDii2cK1aQ/oNQG1RVbgupvhdbQJf1z/WQ+QZiDi25Zs8RlH8SUFooEhdkgp8fvQ3doPE8Dbwt5qAf2OwSnTygRySeMH6gvZDfTpBohefiLpDfVFv9UF/F/Ug/xoU2xBp+nDf08MiHPQNtcvOADS/t66k13oioGz2GZmtwvLcqPLSXZciw9h6WDSdJ+0JtcvWbnUjN4QUV1VxCGHBNtjBIAF9FtMbPs229DMBKwJqHisg2w1rgCrBCcqeMyRAyOLtmOp5IWnaq31huBy2w1qThE2bwMePuyKBsaquWh2Fzw59O/erHXG4Gs2c0qLRfz4hWfyH2iXtvTFwAAUyujYL/6scnjrARmlCq0JIbRUaBqPBS8IPv83s7Ef
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199021)(186003)(26005)(2906002)(4744005)(5660300002)(55016003)(38070700005)(82960400001)(33656002)(8676002)(7416002)(6916009)(316002)(7696005)(54906003)(86362001)(478600001)(4326008)(122000001)(71200400001)(38100700002)(83380400001)(52536014)(41300700001)(8936002)(76116006)(64756008)(66476007)(66556008)(66446008)(66946007)(9686003)(2940100002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmczVlcwb1RCOTNHWjFnOHlZd1orY1MwMjB2Y1RJZ1ZSZmQya2dlWm8rOE81?=
 =?utf-8?B?aEIyYmF3K1VkZzk3emt0UURBTTNHRmRDOVA4cm5WTTlKRzFzVzMvTkpDZmlv?=
 =?utf-8?B?ajJ2bGJmU3p5dnQzQnQ0VGdwUGRPckRic3ZIcWpEc0J5Vy83Q1dzaTlNVk8y?=
 =?utf-8?B?VWdIOCs2SGZTVER2N2VhWWJXbnFTTmVrVjZ0YURCVjRzcU5MZmhkM2I0MWhx?=
 =?utf-8?B?U0M2TTQ1aExvRVhsTjZzQmVtWHRYUkJRM1U3S29oZG1QRGxCMFNFeHVTRWhK?=
 =?utf-8?B?OXFsQzlmVWhPcjE5TUhUZTJpRVhwbVZoTkYrYUVwSlYrOUl6Uk1OZkVmQ0R5?=
 =?utf-8?B?TlZmaHpyTCtHdkZIRHZXcFpWb1JKdnVzSTVNRXl1QUxMMG4rOHhuZG9LTFh3?=
 =?utf-8?B?Q09LSnp3RnQzalk0OENKcEZYYjBkd3JLSkVZa3VDOFAzT2pJUlJvamo1TEJS?=
 =?utf-8?B?bldVUFlZMXltQ3Q0b2twY1NQQTRWUUFqZldYZWJZZWZKcElJYmwwT0pDa2RN?=
 =?utf-8?B?R2JLeFVCTFpMQmkwSmhDSFFNU2dFeWFENTdiajRXN0lRT1locG1FRUpZc1F5?=
 =?utf-8?B?NWpPYi85SGlCajNWajRXbUI5bDdNRzYyUHlOQk5PR1hPdlhST1hKVXFDYUUr?=
 =?utf-8?B?cDVTdXZtck1pOTNXTUtWTmdRZ2tqK29KSVcwc012bUlPa2pPbTdGN3JLSDQ3?=
 =?utf-8?B?eFdiZldSNG9CcDJQdkpRMStvKzU1ZVFvQmY1aTV0alp1YUl5QWIyTVY4R2ps?=
 =?utf-8?B?YUthQm1iTCt4WFc2SzhRWkZpQWl1YmZIemdGWi9sQTlPMldZa2FnaURVZS8v?=
 =?utf-8?B?OUFRN3o1RmpNaUJ3cFpzUklhUjVPUEVlOSt2UERsR3ZYZUYwclgxOHRrUXdG?=
 =?utf-8?B?d1pORUlOYWxVdXEzWFVabEY5c1IvYzEzZFpCQWEvd004bEFQWGxRancyK3cr?=
 =?utf-8?B?ck8vL1duRmtLTkw4R1dwQWRaeFhWWW1RUENiUi9rT0tsclpsL2NqSXRvY1Bu?=
 =?utf-8?B?MGJiS3BpRXlNSThqZEtFenUydkRrbkVySDdvdExFWWw4cGZZcVNNNzR3azZY?=
 =?utf-8?B?STBTSTdqVmRzMGlaWU9RSi9zSlY2eGpQNjhwL0pMQ3J6UXh6Mm9sa25ZdHVw?=
 =?utf-8?B?UTNrbHpUZTcxYUFOeGV0Nk1YTURkOWRDRmplNHNReVdGVzZPVWtOdW5DUFZn?=
 =?utf-8?B?RERqS0lKRExlZnBEajlKWWNlRkk1OTVVUmhkbTFaNk9ISE5raEFPeVJIemdT?=
 =?utf-8?B?RHBJdkVIaW1VbzdYTHFlYWdGUjlYM01aZjJTMU4yaEMvRHF2V08ySG9pM1lY?=
 =?utf-8?B?bWZxK0FzTU9ua1dabUxzSVFyemNTOFJtcEVLSjVSdXltSy9LRzk0eTBBNXVJ?=
 =?utf-8?B?a2RISyt4OENUQlNsRitaLy8zUlJFUVAwRXYyWW5MMWoxdzI4SHdhRVRLL1BE?=
 =?utf-8?B?WThwZUxuUEhHS2hpVWtFR1Fobnhpb0xIR0k2ZjVXendUR1ZnaGt4Z1pldWx2?=
 =?utf-8?B?M05PbXZSWktMMUJKWUtsMzUwdnRaNnl0LzBSdnF2dHI0RWlNN3RMT3N2NDBk?=
 =?utf-8?B?eVQ3a0p1bll3L0MzaFZaelpCcHBpK2JKbGY5WXR5dHpPVVgrVEZlUGRkN1Qv?=
 =?utf-8?B?K01QNWwxTmo3SEdrTXI4S3JIeXJIb01laXk1djFxUkVpaHhaWjg4d1RKTUdW?=
 =?utf-8?B?NytiL0oya05nL2dLWUN3SjRLa05makdDbEExd0JxdDZQNTUvLzl4K2thQ0FZ?=
 =?utf-8?B?YjhUTCswdXZ1SlROZ0pRWTB0eVJ6UXluWTlBUjNaRXFyZ1JqOVNRc3JNMlBw?=
 =?utf-8?B?RkJMZXVCTnZKOFVCT0RYTEJtdnJmcjVSMlcveXBkREQxa0FFTmsrZEd4VG5p?=
 =?utf-8?B?aE01VTUraFUyM2MvczM1eW9jeklMSTdtSU1aS2EwR0haQnJaeG93aXFwQ0Q1?=
 =?utf-8?B?RG00L2pMclVtNGRpT0N5MHkrSUhNQW9yYU5KTlN0M0pyM0g1OFJmKzhES1Jx?=
 =?utf-8?B?cTZTclJOb2Q2c1MzWC9ISEZ6QzE4bHpKRzBVK1lqTjdjZ01YYkFlbUFpUW1H?=
 =?utf-8?B?Wm9lRWRaNnVxYXM0clBVdTZsbG8wUGFkYzczcVNuZCtDVUNPMkE3SGoxLzBL?=
 =?utf-8?Q?ruKc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0511b1db-8e9b-481b-df35-08db76613cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 16:20:20.4867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9dYAAsJN4FIRG3lAIE0SEHzPeyIxgt96rygSjsm6I97Qfh54QqopxG4bErbNFHOP5KWUTAtzs0uj26qrxOJzCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7747
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJJ2xsIHRha2UgYSBsb29rIHRvIHNlZSBpZiBhbGwgdGhlIFNOQyBkZXRlY3Rpb24gY29kZSBj
YW4gbW92ZSBpbnRvDQo+IG1vbml0b3IuYy4gVGhlbiBybWlkX29mZnNldCBjb3VsZCBiZSBzdGF0
aWMgaW4gdGhhdCBmaWxlLiBCdXQgaWYgdGhhdCBnZXRzDQo+IGNvbXBsaWNhdGVkIEkgbWF5IGxl
YXZlIGl0IGFsb25lICh3aXRoIHJtaWRfb2Zmc2V0IHNldCBpbiBjb3JlLmMgYW5kIHVzZWQNCj4g
aW4gbW9uaXRvci5jKS4NCg0KSG1tLiBTZXR0aW5nIHJtaWRfb2Zmc2V0IGlzIGRlZXBseSB0YW5n
bGVkIGludG8gdGhlIGNwdS9kb21haW4NCmhvdHBsdWcgY29kZSBwYXRoLiBTbyBJJ20gZ29pbmcg
dG8gbGVhdmUgdGhhdCBpbiBjb3JlLmMNCg0KLVRvbnkNCg==
