Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BE16A5E90
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjB1SEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjB1SEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:04:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2248130B39;
        Tue, 28 Feb 2023 10:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677607449; x=1709143449;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w0pkHlgimmldpi6Ypsba41/dIXIk31tROSrNzfT6Dcw=;
  b=IUTSWWsjf95cWtGYDMQy8C7CaTARIMbty8CGQplftX7nbak4m9Sti3O1
   SDTQuFffi3MkFhrEIHc619gKIRE4kBMsN96UhRMNn1wUvX2s65Z3vzmFE
   1SQdosw47hgOJLLd+ZF/Z/kZdLo1IeqxgVxIXziBfh60vQd6WVxGDvuX2
   V2zUFjmmJhsuCuMzHLrb5k2xA5opO3yVI10DoPHGW+mHN51DwZX4beGcd
   y7qUIYKbFkBFs9Oq5D7ReZPGNe2ogFHOy/LjenM4mEckX380SadQV8dnt
   9lDbpOStRET1g8L7T1+R3FMtIOXSaq7YHVnNWPL640LzJ3wrejcOQSgq5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="335697915"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="335697915"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 10:04:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="651687203"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="651687203"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 28 Feb 2023 10:04:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 10:04:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Feb 2023 10:04:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 10:04:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4xQOfDWGZqwh0WkCOXPOyD8Mvay/Y/iO2QAFu/cTlq3BQMbQd2YgX+fXn9KpSMB2OT5ULGiCXGJPi1emBWgyzEn0+wHWKQ1YeBeuDy3wMQV3TM2kLwFzs4qC2gOM7+atSsOmf4/rkotf9QkqX6wqgN9CbJhCDPIDv49Nz4GEMlu4aQ9Z5LktNZ6fwiaNwxrOng4xwMaTsJ8i8JSDz6s/waPZ6G1p+zdYnQ/14vNxi9WfGk2B6fkUdh5iScUI0/stDfFE9AY4qMc7YPXPmkh8C07z7oVsiSMql5HfEDmKT4QZFtZwSNge4nNhhmZ4J/eBYUDox0o8vo8uG/JbV09Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0pkHlgimmldpi6Ypsba41/dIXIk31tROSrNzfT6Dcw=;
 b=JoAjhGsBsDJV/h0pYl40kuNFO2M9Av9uGvML8dcsgAiF24eXYxtGdtLRe6RKwDKFrF+F46ZOZY4g048lyd5X1tv6y48g9g76zVQdxf/ijyMWTFEqvEhqn46UjnD4UL+Cbn7Fx6cQslwJ/MRS6XN6ibXjOAgaFu4/diwlTYqxh5mxK4FtqZBgdFH3uN5MENNIeiPXbI9x3QufdUM8ofCUuEngsXyKp+lZKdEmSARcyM4PVpCSx3vsscD0QGN9SV1hTxSwuPKccmUTblqAzlPg7pdcchKizMzDU0Nrh8LUhO/i2Rj+HRoC3qoYzYgGnRZU26hKUTvmSPbh9XNcf6PD0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB8059.namprd11.prod.outlook.com (2603:10b6:510:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 18:04:04 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%9]) with mapi id 15.20.6134.026; Tue, 28 Feb 2023
 18:04:04 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     James Morse <james.morse@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH 0/7] x86/resctrl: Add support for Sub-NUMA cluster (SNC)
 systems
Thread-Topic: [PATCH 0/7] x86/resctrl: Add support for Sub-NUMA cluster (SNC)
 systems
Thread-Index: AQHZMbXn+R9Nb39BGUGnOenVu7f7e67kzDmAgAAJGAA=
Date:   Tue, 28 Feb 2023 18:04:04 +0000
Message-ID: <SJ1PR11MB6083D2481D47104FE67354A3FCAC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230126184157.27626-1-tony.luck@intel.com>
 <ed707884-aa1f-fa28-63bf-ad5d87230893@arm.com>
In-Reply-To: <ed707884-aa1f-fa28-63bf-ad5d87230893@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB8059:EE_
x-ms-office365-filtering-correlation-id: 437988b1-61ab-41e8-5640-08db19b62db2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oFcVJA/rp/bZvYKH8eylGkPwkV9y3nDJPYSsjAzPYbH3HxEqjCPUARhaCVXx3DzmTs80wUfgfDCxT9Go1ZvwJqNhjzHKS0fYOUAtDLG8dZK6ALnD4JdYhb/4xqpchU8Ichr5ok/5gDM6jpsXXKr2Wfsh7PMz8rAnal6V73RtQpuiF/PadCP6IjP9DAYCvF2UBQo90uoOaDJ5u4Y/JJaexoW53bENp5DsExxjIHirOwLyGH6GMfax1MymWWEOT1QrSVBqqH/mJ0NWq+c5oWkl7kC9DDlq6IcJrGePgbmsHo0rqmqyLf/YtHh8D5h0QdZK2Rese9aS1SBMBV/Lu48TAYkkBb87ISWRKtZDwdNOHtG2iEJNHMjV9bJsE5t2HlLDfN8qXc67DFpTsmkxcdi63zmk6pZobL0nbkZAs1o7ZzeiBFEa0CiWwtOD2g7e52fxV6qVO1tGqGba+jiheheWDo7rhD/3q2rq2uQoA2eOeOz1SbrtwLpt9YSRwMSARbgMTxZSFoq+cjF820Nv81wo5r06fWSmAQZOWzo+GllYUqoFaviI++EC5uDGTFHJP1SoyMQYUwEPcwRMuyxAy5zz5zSDEJ6VLKt5K4VFmiFYtLfBquXNupbRCd0oniAyaAOoV6s7eTtgsVS9rpCX0tvmuQN6ZIFpYMofNZAeEcjcarczI6rV5UKlit4I/RW8YgW59TM6sq8pDNbtG45sqLdjcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199018)(122000001)(38100700002)(86362001)(33656002)(316002)(7416002)(76116006)(55016003)(66946007)(64756008)(83380400001)(8676002)(66476007)(66446008)(66556008)(41300700001)(5660300002)(52536014)(8936002)(2906002)(4326008)(110136005)(54906003)(82960400001)(38070700005)(71200400001)(6506007)(9686003)(478600001)(7696005)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXo3RlBTWXVSNkdHWkhOUUsyVjBacG9VUmpCWjllV21taUhWc0xsZFE5MW52?=
 =?utf-8?B?M3ZDM0x3WjJoMlI0M1B6N1NrZnVLVlY5dWtPS2hPTUlvdk03U2tNZkJsWEhX?=
 =?utf-8?B?aXVjT2MvWUUzRDdTS254THZxbXJpTjc5bnozU3djK01qdlM0VEFQcEsxNHps?=
 =?utf-8?B?T1p4eVpYWTRtUCtEUDRoRGRRdk42SVpXcE9ZK0VEWWxISlFTTyt1d29kd0J5?=
 =?utf-8?B?bENSYVhEOW1OMTREYWpHMXVkL0RBN3V0TkdyeXRwM3BOMm0rdFdQaHR2MGF5?=
 =?utf-8?B?QmhQbC9HZVU5M0VraS9ML1N6KzVqeUV4UDhVWU4vcSt3UUJqUGxwSzV6Nzgw?=
 =?utf-8?B?cmkrWHNDZy9ZWWgrRXpUSjVnL1RlcGpjd0prNmRsVCs0cytjbnhJUHc4Y3JP?=
 =?utf-8?B?SVM0eDRldGZoU2VWUFA5RTgrR3ZRMmhHZHhtUXNHNE5BRmhoVHNuVWtjQUcw?=
 =?utf-8?B?c1FCci93WTBGM3dvUGR3RXE1WUsyelF5bDhaQ2FpVG9jS3NsSU8vY1FtS2FU?=
 =?utf-8?B?c1prMTd3Z0xrZ1Urd0tlUVVxQ21OZGtpNDMwK1pOVlloaHRVbWVWWVUvTklC?=
 =?utf-8?B?bUNOT2NPMFhCYkEyMXFoSGFYZ0NOYkF1OERvMlhlbUFGZEp2QldKUXVXVGNs?=
 =?utf-8?B?TkNUbDRMR09UYWMyaXZSU284c0NSVytQQUZTL3hYbmgvd29nWnVmT0VVMDB6?=
 =?utf-8?B?Z0N1QVVDemdYY3Noa1JzQ1BUR2FjR0l6MTBQWkI1dFJTVTB1cE5hOW9hQ1A1?=
 =?utf-8?B?T3F6c0NTeDNGNG5XWDhjR3YyUXlwQ1FEcWkyWDMwbUtxUE5OdEprWngwK0RZ?=
 =?utf-8?B?QVZwMzhKajJEbjZwTzEzS1d6NUtRUXh6cHMrWVdYanBDYnM5bjNIRWpkbXhh?=
 =?utf-8?B?anJuNnVxekhBMzE4K0toMkRNQ0RYNDJiemloeVhRU3JnQjlOaExQTUlpb3k3?=
 =?utf-8?B?NHI3OE9FZkVDR0V4dk9QVFl3Z01VcHpsT0QydlRwanlXcU0vMmp2aE5HTTQx?=
 =?utf-8?B?cmFXVHRRaFRDYTBNWVVtTHlsU2VhMk1sODB3aW81UE5DelNCRk9GeGVGbjJ6?=
 =?utf-8?B?UkNZRFNTVkdNRXM3MXdhMmJNN0FueGVpYXduTmMweGNsWTdMREtiL05NU0Yv?=
 =?utf-8?B?Y0FGNmhrdjRUK3FHVzlPNzZQTnV4cEpwdC8rZFVocjFOeG9rdjh6YVhPYXFC?=
 =?utf-8?B?dExnLzhZWG8xNjZndGhlR2R4L2FQRWpKbnVvMEZBV01BTkFzSXdLVmJ6SCtK?=
 =?utf-8?B?MkhVMmV0RlE2TFVubUV0aHdaR0g5dHVNTXJMK1pRQkxWSS8zWjdkNnRIRlov?=
 =?utf-8?B?RCt0K25POVcvNlpYQ2t0bUxlS09EYlUvY29OUWlUSXZuYnVRbXZYUXpKenZM?=
 =?utf-8?B?RnUreFNvZU96YWdXMFRGN3MvTkdjNlFCb042MW13S0hKV0JHdGdtc2t4Nldz?=
 =?utf-8?B?Vkk3QThCR3A1QktzRFVzck13bjRnSEVzSGZDVzhtTUc1VnVxajByZUJMZ0ov?=
 =?utf-8?B?Z2ZoRk1aZDh3ZkxUQlN0VXpaWUZiSU83L0pSdldiYkMvZDAwMGpkaVZncnNB?=
 =?utf-8?B?bnBHNi9XY2RqRzJ5NUtSeWNaeUFRNkhwSEdlZkEwRkQ1N2ZxMXVLZ0ZjYXlV?=
 =?utf-8?B?czB6OVhCQitJTnQ0d1BmckR1c2dFcG1XU0t5WWprUXNZblhkbDl0UTh4dEJ1?=
 =?utf-8?B?ck9CZ2hKT2JoNmszSk5tQTAzcFFaT1lMd05JdW9LdnVRUTdhcWhZaWdtem5X?=
 =?utf-8?B?dXhnME9oNVo5YVhIM3VMK01icGhiUXNNZ012S3dXT2p6NGdPRnpEdG04d2gy?=
 =?utf-8?B?OUNXbE1TbkZkdSsvRStLazNMQ3B1VXk2UkxOVHNQMHgyMTRvcVJlKzJRY2J2?=
 =?utf-8?B?QmhFVFZ1RDJLOXJwbVFxbEYzMDhTUUl2elpoZUlEYlBxdmdlOG5URVY4amRr?=
 =?utf-8?B?Ymd0SVVCRTFYRWV6RUFYSEFMWmIrd0F4RHpERXdya01xVWhmQ2lpMHJNVFFJ?=
 =?utf-8?B?SEtieDNjOHM4ZWdUanBRbnNtODBwTFhTK0pqODFHT2ViajM2eTFrNHV6UlEw?=
 =?utf-8?B?ME1OZm9wSXJNdlRtNlNqYlgwSDg1VnpDQ1VnK0trUHByd3FqeitCVzk5bzFT?=
 =?utf-8?Q?mNrJyaMOSnkKI0zF6dAk1E7+5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437988b1-61ab-41e8-5640-08db19b62db2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 18:04:04.4305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5rceYT9WEnL+nMacPfbGw2fMFNB/Pc1Wcks9RgaMbFCx/TC9KzgYmNcqR4dMd6tUr4ygLQBMcefNQb2Za6Mxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8059
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

PiA+IEludGVsIHNlcnZlciBzeXN0ZW1zIHN0YXJ0aW5nIHdpdGggU2t5bGFrZSBzdXBwb3J0IGEg
bW9kZSB0aGF0IGxvZ2ljYWxseQ0KPiA+IHBhcnRpdGlvbnMgZWFjaCBzb2NrZXQuIEUuZy4gd2hl
biBwYXJ0aXRpb25lZCB0d28gd2F5cywgaGFsZiB0aGUgY29yZXMsDQo+ID4gTDMgY2FjaGUsIGFu
ZCBtZW1vcnkgY29udHJvbGxlcnMgYXJlIGFsbG9jYXRlZCB0byBlYWNoIG9mIHRoZSBwYXJ0aXRp
b25zLg0KPiA+IFRoaXMgbWF5IHJlZHVjZSBhdmVyYWdlIGxhdGVuY3kgdG8gYWNjZXNzIEwzIGNh
Y2hlIGFuZCBtZW1vcnksIHdpdGggdGhlDQo+ID4gdHJhZGVvZmYgdGhhdCBvbmx5IGhhbGYgdGhl
IEwzIGNhY2hlIGlzIGF2YWlsYWJsZSBmb3Igc3Vibm9kZS1sb2NhbCBtZW1vcnkNCj4gPiBhY2Nl
c3MuDQo+DQo+IEkgY291bGRuJ3QgZmluZCBhIGRlc2NyaXB0aW9uIG9mIHdoYXQgaGFwcGVucyB0
byB0aGUgQ0FUIGJpdG1hcHMgb3IgY291bnRlcnMuDQoNCk5vIGNoYW5nZXMgdG8gQ0FULiBUaGUg
Y2FjaGUgaXMgcGFydGl0aW9uZWQgYmV0d2VlbiBzdWItbnVtYSBub2RlcyBiYXNlZA0Kb24gdGhl
IGluZGV4LCBub3QgYnkgZGl2aWRpbmcgdGhlIHdheXMuIEUuZy4gYW4gOC13YXkgYXNzb2NpYXRp
dmUgMzJNQiBjYWNoZSBpcw0Kc3RpbGwgOC13YXkgYXNzb2NpYXRpdmUgaW4gZWFjaCBzdWItbm9k
ZSwgYnV0IHdpdGggMTZNQiBhdmFpbGFibGUgdG8gZWFjaCBub2RlLg0KDQpUaGlzIG1lYW5zIHVz
ZXJzIHdobyB3YW50IGEgc3BlY2lmaWMgYW1vdW50IG9mIGNhY2hlIHdpbGwgbmVlZCB0byBhbGxv
Y2F0ZQ0KbW9yZSBiaXRzIGluIHRoZSBjYWNoZSB3YXkgbWFzayAoYmVjYXVzZSBlYWNoIHdheSBp
cyBoYWxmIGFzIGJpZykuDQoNCj4gUHJlc3VtYWJseSB0aGUgQ0FUIGJpdG1hcHMgYXJlIGR1cGxp
Y2F0ZWQsIHNvIGVhY2ggY2x1c3RlciBoYXMgaXRzIG93biBzZXQsIGFuZA0KPiB0aGUgY291bnRl
cnMgYXJlbid0IC0gc28gc29mdHdhcmUgaGFzIHRvIGNvLW9yZGluYXRlIHRoZSB1c2Ugb2YgUk1J
RCBhY3Jvc3MgdGhlIENQVXM/DQoNCk5vcGUuIFN0aWxsIG9uZSBzZXQgb2YgQ0FUIGJpdCBtYXBz
IHBlciBzb2NrZXQuDQoNCldpdGggIk4iIFJNSURzIGF2YWlsYWJsZSBvbiBhIHN5c3RlbSB3aXRo
IFNOQyBkaXNhYmxlZCwgdGhlcmUgd2lsbCBiZSBOLzIgYXZhaWxhYmxlDQp3aGVuIHRoZXJlIGFy
ZSAyIFNOQyBub2RlcyBwZXIgc29ja2V0LiBQcm9jZXNzZXMgdXNlIHZhbHVlcyBbMCAuLiBOLzIp
Lg0KDQo+IEhvdyBjb21lIGNhY2hlaW5mbyBpc24ndCBtb2RpZmllZCB0byByZXBvcnQgdGhlIEwz
IHBhcnRpdGlvbnMgYXMgc2VwYXJhdGUgY2FjaGVzPw0KPiBPdGhlcndpc2UgdXNlci1zcGFjZSB3
b3VsZCBhc3N1bWUgdGhlIGZ1bGwgc2l6ZSBvZiB0aGUgY2FjaGUgaXMgYXZhaWxhYmxlIG9uIGFu
eSBvZiB0aG9zZQ0KPiBDUFVzLg0KDQpUaGUgc2l6ZSBvZiB0aGUgY2FjaGUgaXMgcGVyaGFwcyBw
b29ybHkgZGVmaW5lZCBpbiB0aGUgU05DIGVuYWJsZWQgY2FzZS4gQSB3ZWxsDQpiZWhhdmVkIE5V
TUEgYXBwbGljYXRpb24gdGhhdCBpcyBvbmx5IGFjY2Vzc2luZyBtZW1vcnkgZnJvbSBpdHMgbG9j
YWwgbm9kZSB3aWxsDQpzZWUgYW4gZWZmZWN0aXZlIGNhY2hlIGhhbGYgdGhlIHNpemUuIEJ1dCBp
ZiBhIHByb2Nlc3MgYWNjZXNzZXMgbWVtb3J5IGZyb20gdGhlDQpvdGhlciBTTkMgbm9kZSBvbiB0
aGUgc2FtZSBzb2NrZXQsIHRoZW4gaXQgd2lsbCBnZXQgYWxsb2NhdGlvbnMgaW4gdGhhdCBTTkMg
bm9kZXMNCmhhbGYgc2hhcmUgb2YgdGhlIGNhY2hlLiAgQWNjZXNzaW5nIG1lbW9yeSBhY3Jvc3Mg
aW50ZXItc29ja2V0IGxpbmtzIHdpbGwgZW5kIHVwDQphbGxvY2F0aW5nIGFjcm9zcyB0aGUgd2hv
bGUgY2FjaGUuDQoNCk1vcmFsOiBTTkMgbW9kZSBpcyBpbnRlbmRlZCBmb3IgYXBwbGljYXRpb25z
IHRoYXQgaGF2ZSB2ZXJ5IHdlbGwtYmVoYXZlZCBOVU1BDQpjaGFyYWN0ZXJpc3RpY3MuDQoNCi1U
b255DQo=
