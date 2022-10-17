Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB75E601334
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiJQQLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiJQQLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:11:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7EC6CF69
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666023068; x=1697559068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NRcJICLgMWoilnoACvZuQ0ZUzOd3Rj6Wga0f5g390AI=;
  b=bsfldBRD4LrQLyTvQsPw2GSomxnYK38MZtfYYEAJeozBIWCEOXlY8x3l
   aWjzBB7RCbdNnrNmT7RV9t3cSTQDoT249k15H9A2JJkP9OrMt+y921CNW
   1Wn4cCO5bY1gYe56M+AMK/petloXqEaDE6qccrNm81vOBBjCssWOdqyrC
   bB3dpHEYm3uhA9JcpbqVoXBCSg0JV6I9ItApFf7uikcLddwI2fCAc4S9X
   JgFlwHOM5/kLcILeROTkJ/2zt6BEbnv0ATZPRzSCEIgnA8hM/qMve85M9
   3o8ABvDrSH3/v9xq5JXdGxeddl1IPLrK9R17gX0Ur0vmGFO0W/kmlvbjo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="289138696"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="289138696"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 09:09:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="957392845"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="957392845"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 17 Oct 2022 09:09:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 09:09:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 17 Oct 2022 09:09:26 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 17 Oct 2022 09:09:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+BYp660h5CYTq9qw9M5KyEFbI4/7M7wr7x7duTDkjE+8+NzelNbtSMs2eU1e9U2t6vBS3a5flH6KoBjsxeuvktAfpGd5OK9KtKKgZy3X79KjXONw1C0Ov1Hiy/b0ax9c27bQL5TeKsK06ewpL0JQjZHtK8zWfR4kI1vfyFGU+1StyaXpQZiReQtDeePVCcr4GrZUGBHxzUxI6RJaiIHJEXuftFv6G2m6qZjTcBvg99xS/dMF3V/pU88qqNhD1xmvOorpksGOSEpxvzqxcYEwwm5m3/7ohHenYKbiaHglB1imeGwk3CJBLx+3dy9n5Sw35FS/jLosywotxKddx2mKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRcJICLgMWoilnoACvZuQ0ZUzOd3Rj6Wga0f5g390AI=;
 b=ZZshCxASktouGHPi+VLN+Jvy9S3cpWhh09ecEl+o4tIa0z8m4VALnvch5Tx2RNmWNgjHz/UJrgFK3rPNho+a0SWNisgSDeexLGYirTOfxG4vHATx0nME0d1vifK9AL4YWpsXAGrKl+AmTpxddAbBRCyYbKeHmeIlpz8HqaOpwgEFaihYsxV2VnZOI7159ZNqhEajscLbUqxJuuBw4WxeNMGHBH7IJ/zR/8V6vsra7rmvxJVAt+71ySaMVk05qhrRd/cxKXjAhr/WmZzrsitKnE1rWHJQcyCRitfmwa+ADYBNGHtctm3Re7HYFwBWzZZeobB9AHJlppZsnVa4DRq69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB5328.namprd11.prod.outlook.com (2603:10b6:5:393::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 16:09:23 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%6]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 16:09:23 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] RAS: Fix the trace_show() function to output
 trace_count
Thread-Topic: [PATCH v2] RAS: Fix the trace_show() function to output
 trace_count
Thread-Index: AQHY2PM6AmYOaHxNDkqKd6ET2h/8964SdqsAgABbLtA=
Date:   Mon, 17 Oct 2022 16:09:23 +0000
Message-ID: <SJ1PR11MB60835DDCB1F3EBC8B6DFA2F7FC299@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <Yz3KI5qY70rvJV63@zn.tnic>
 <20221005194644.311204-1-tony.luck@intel.com> <Y00wIFEN9h9YPGe1@zn.tnic>
In-Reply-To: <Y00wIFEN9h9YPGe1@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB5328:EE_
x-ms-office365-filtering-correlation-id: 3163da42-b573-4693-a951-08dab059f534
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SR04XQd+L/Pv+f46tXQAxqTp8ICAWOrirUfWapvUIjjT9A/n2YAhGeltqOMrguaqQ6SP8cl5iEkW5u7TQdTLWQf/KpOj6zxLAKcykL+p9eU1Fz+MSO+Y1DSvJiNhJ2sknFC1AREee7+8TdMcwJZLy+7dluU8S6r/bkti2PXI4rRjJ/IaxVhj4OHR4V68AvsiD3o8wu4+PIVicfIkeYQUOkW9MWli0eB4QourPq50JrI1f6gwZpa2AhvWn+y/0Ui+/wl9YB/wgtrsCqQiX8JrNtOpEcvkpEehN1LRmLk7GiaQKzfLC3gtvx7lUjJuv70tIM3Vln+hiOFLq9u4PFvSL4h64Db0AtuLelg/tMXBvH9ACFGlT2lxwA1bPnlIv+oFIgBW3psaMfJsi1KQYDslfYbW6dv9G+yxG4djXVxRIEKNNZIkR45OYNYDBTWR0VYsqjoLRIp9+sUT/x4TNYPFj1Cps0viJ4jnVE4NSGoRj+tYFFZ0EcDHyyuE8wH0nRyYvWWyN9ayzqUzGuahyBm9QtVro7Osr285fyOYO5NfmaV1c+NzWjDVn9ZnzbU29am3ZaLP80NiWX6GNPiQanFpuDlKjrFG9hEKKfXlhNkXx9IiWhTFDWZhV/U8A+/kMrf+HmTxtlGEmV5YPNglk+rhDjfIRqlQts3SRhCsj/QBuO/4C3URhyDPFDQs0Xxp6JXG6rzNxdpiXuyB9mC0mfefp0VysIUH0i4saaIDKMLJL6jBGZziOTRvmMdFKRA9kmMVlKT/CK0oqZBI92zZcnZlVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(54906003)(6916009)(316002)(186003)(7696005)(6506007)(4744005)(52536014)(8936002)(26005)(9686003)(41300700001)(5660300002)(66476007)(66446008)(64756008)(8676002)(4326008)(66556008)(66946007)(33656002)(76116006)(38100700002)(82960400001)(2906002)(38070700005)(71200400001)(86362001)(478600001)(55016003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QktqVWZDUTcrMkVISXJzY3lSbEpRdW4vemw0cnlpWGhHZDUzQjRXZjJJWjlK?=
 =?utf-8?B?akV0V1p5N3pteXV1eWMvTFdxK2tEQ2hueXZabzBsRkQ0U3BEL0lORWdMRjhx?=
 =?utf-8?B?UmpKdSt0dUtwOFoxb2toWUpWS0NMdVpMYWZFaVd5eUJFMXhISE9heGNQUUpZ?=
 =?utf-8?B?Q3kyeHV4NnRhdnNEYkc4bXpBOXBzUEVXcmY0NnBGNWxxUXBDTFh4KzZnTzhv?=
 =?utf-8?B?ZVZSSVIxTTNQeGMrZ0JFVmxZaTAzVmRvYlBGR1EzeCtxV2QveEtPeGNwM241?=
 =?utf-8?B?UUI3bjhQOElPQkxnMGJzRU9GU2g1d1NBRnhRaERqTEZpaERzc1BHa1oyMGxm?=
 =?utf-8?B?NEtXNzRiYVZCbm5rYnZ6dmJ5TlJqUVY5cVkwSWVOWTR6MktsQW8rVVU5SUdN?=
 =?utf-8?B?amNmTU1UWTBSUjRwRklCQVY1YUZCYTc0MlV1YnkyZThDZ1NFTHpDMGdETG42?=
 =?utf-8?B?VnA0b3pZQUJ2WUVhM2t6ek11SWJqVG9kYnI3S1I3YnE5Ni8wV1ZXdFBKSEVl?=
 =?utf-8?B?bDFDWkNQcmU1NjAwMDFIK1FFQzVOMDFyaFdySEcxZ3V4OHBodGkySkdld3Bo?=
 =?utf-8?B?SmhMbENlZWdQM3F5cUNZUEwvVFYxaStvUVJyZHpXdGxJN05TNFcrR2w1NDAr?=
 =?utf-8?B?dmtuazNBZVFWa3p0a3lvQjIwTzJZZkl0K1hBbCtWODZRMHFUc1prY1pFMEJy?=
 =?utf-8?B?OWw1SUovbDlobnZSdFZPQzkxdDJwQmVOM0VpKzJDSnkwL1J1c2pTcUxuZndi?=
 =?utf-8?B?QjNLc0w3L0I5cmlNODNBZnZueEUzdWQ2ak9aMnd4NFVyOHJ4bmI5djJZWjBi?=
 =?utf-8?B?ajlxN21MR3ZkV3pKNXNDT1o5RHhHRjliZS9sczJHSG03QjRGbzEyNXdHOHQ5?=
 =?utf-8?B?bG92dmpwNG4yVzN5TlpneStXVHpnWndvcjBGYlRqRDViak8rajZ0YVE4MjB3?=
 =?utf-8?B?dkM5TDRQektGTjlSVHp3MHJwaktWeFJ0VVRiQTVqMDZwRzIrZ1plRlNHMHBP?=
 =?utf-8?B?aHMvdVZwYlRhS1BUTjBwOHZwMGQzbjMyWW5QMVhSZmordUtuTkc0NUpJSkJU?=
 =?utf-8?B?NkZWMmpNZUg0cnQwNXQzRHJJUnhlRFVrdmlINnUzN01udk44QlZqdGI2RjBl?=
 =?utf-8?B?M1l3dE5iYUZ5UTc4NjNUMXNuaG83ekxlZWFZV0xxZTllaHdiVXFsUWsrbjZk?=
 =?utf-8?B?SzV1WWNSTlloVkxQOEhpMjFOcTdRWnFrc3B2WXZ2K2ZycUc1OGh3WXhZZ0pn?=
 =?utf-8?B?eGt1MXN3Yk5mSjRRa0hXdEY1RVhDMSs4c1hiUEQ3cE5JRSt3Qm5HWFdKRXdk?=
 =?utf-8?B?bkc5NUUxaXRCUGIzZzRBK2NpVENYZ29xOHZML29SZG9KVFd1R2QxcG4raVBI?=
 =?utf-8?B?TnNwRHJyV29mNjljMC91Lzh4MFhQSHRqenNRZno5WHVRVFhpQSs1Qmp4Tjhv?=
 =?utf-8?B?MU0vR2tDN09KeHlDVEhhb3orVjNCYXhIbDFNWkhva29Pek1xOUkweHR6NXdr?=
 =?utf-8?B?REY0ZS96cDF0L0daRnFmYjRwQUlZOEtLc1pJM1R6b244aUxUMlFpK3d3cDlo?=
 =?utf-8?B?eWI0dEZhb2NmS3ZQVTdHNVBRbERCT0puZDJ4bXVZR3YzUXlKOGF5c3RyQkJq?=
 =?utf-8?B?OURzVGhla0lybithVHR2ZWx3aGROUjE5WGFTRVN3QzlteUE3ZTUzQnAwSGhw?=
 =?utf-8?B?dFBaVGZmVWZtY3UybzdnRTNiazlka1NWaFBZbDJmN2RDRzhadC9VQXJtNG5K?=
 =?utf-8?B?Vm8xY0ZCZThMWFFTa2ozRjlFV09PdytDMGRKNVR1dkltYmlZNk9mNzdUN1B1?=
 =?utf-8?B?V3FITVI5QzRvRXhQNUMwSlNodXpzMStmTzVITXZ3V0xKRVE5Q0wxYkErbHJR?=
 =?utf-8?B?OWc0ajZsejRVdURIOHN4ZVU5NmUwZFlpbEw3YXk0VTFpQnhOMnpmR1d1Z2Ev?=
 =?utf-8?B?L2FxM0JEay9wNG16cVl5VlQxZk4yL0FUMkl1cCt1NFQwNEpRZGlyblF2ZGtO?=
 =?utf-8?B?MU0vbERSVlZId3BiTWVXeGRyYnEyMFFLZnN6VTkwSXQwcS9CdUJiT2NGOHIz?=
 =?utf-8?B?U0tBd25SMHRWNXBGaWV0c2hwZS9nUnQ1KzRMNHh1VGJoSTFER25MSjlsV25G?=
 =?utf-8?Q?Af4o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3163da42-b573-4693-a951-08dab059f534
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 16:09:23.8637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z421qcegjaUaR/Bfihp3cuVpwSnmNqPxYMSfX83y+VW0scUMe7XYUI+K5tcpYD4HvqMvInojopVdzQiJwQrWzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5328
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdGlsbCBtaXNsZWFkaW5nOg0KPg0KPiAkIGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9yYXMvZGFl
bW9uX2FjdGl2ZQ0KPiAxDQoNCkFncmVlZC4gSXQgbmVlZHMgdXNlciB0byBpbnRlcnByZXQgdGhl
IGFuc3dlci4gVGhlIGZpbGVuYW1lIHdvdWxkIGxlYWQNCnRoZW0gdG8gdGhpbmsgIjEiIG1lYW5z
IHRoZSBkYWVtb24gaXMgYWN0aXZlLCBidXQgaXRzIGFjdHVhbGx5IGp1c3QgYSBjb3VudA0Kb2Yg
aG93IG1hbnkgdGltZXMgdGhlIGZpbGUgaXMgY29uY3VycmVudGx5IG9wZW4gKHdoaWNoIGluY2x1
ZGVzIHRoZQ0KImNhdCIgcHJvY2VzcyByZWFkaW5nIHRoZSBmaWxlKS4NCg0KDQo+IEkgZG9uJ3Qg
a25vdywgbWF5YmUgd2Ugc2hvdWxkIHRlYWNoIFJBUyBkYWVtb25zIHRvIC0+d3JpdGUoKSBpbnRv
IHRoYXQNCj4gZmlsZSB0aGVpciBuYW1lIGFuZCBQSUQgc28gdGhhdCB0aGUgdHJhY2VfY291bnQg
Y291bnRzICpvbmx5KiB0aGUgUkFTDQo+IGRhZW1vbnMgbm90IGFueSByZWFkZXIuLi4NCg0KU2hv
dWxkIGhhdmUgdGhvdWdodCBvZiB0aGlzIGVhcmxpZXIgLi4uIGNoYW5naW5nIHVzZXIgc3BhY2Ug
c2VtYW50aWNzDQppcyBoYXJkLiBFdmVuIHdpdGggb25seSBvbmUgdXNlciwgdGhlcmUgaXMgYSBs
b25nIHRyYW5zaXRpb24gcGVyaW9kIHdoZXJlDQpuZXcga2VybmVscyBhcmUgcnVubmluZyB3aXRo
IG9sZCByYXNkYWVtb24gYW5kIHZpY2UgdmVyc2EuDQoNCkhvdyBhYm91dDoNCg0KCXNlcV9wcmlu
dGYobSwgIiVkXG4iLCBhdG9taWNfcmVhZCgmdHJhY2VfY291bnQpIC0gMSk7DQoNCndpdGggYSBj
b21tZW50IHRoYXQgdXNlcnMgcmVhZGluZyB0aGUgZmlsZSBvbmx5IHdhbnQgdG8ga25vdyBpZiBh
bnlvbmUNCmVsc2UgaGFzIGl0IG9wZW4/DQoNCi1Ub255DQoNCg0K
