Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028815EF93C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbiI2Pkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbiI2PkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:40:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB9F4AD7B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664465893; x=1696001893;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hCeUoRGANAPb6NTHsyPZj4mpFqxT7pGgYj9pI+O5q6o=;
  b=D+z6G2Upv/WQ2iRI/JmVLokC4M9NowmZpebpcRXKP5ZnldTcLtMnO+Ai
   rt+119cUZoUYmWZlLJfoShCFYUbTSglQWH0fmP7J7hj9kGlhruagitsW1
   rO+FoHwDvBJSkeUA8hCVsbdO8iPpHMJ8hnTTrTypgEHMTn8Xpe1zr3dhw
   cb7S4Pjfwdc7TySSH5/fb7NpH2EzGD3cEmljgIix4tYRCWSu7mHowfe0v
   kKOX5CPgY8tamTao8QGMoGMJzQPVHbMQL+UgQaHILr7yBwhxJUH9g1SHp
   +hW9D+ZN9hfK6rHE73fdZPNelfQlSs6EivbM9sqlFfjNEAChAbiFlVD/l
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="388210970"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="388210970"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 08:38:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="951179001"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="951179001"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 29 Sep 2022 08:37:59 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 08:37:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 29 Sep 2022 08:37:59 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 29 Sep 2022 08:37:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKda5q6jGLrEdDWvZk1mKt6CRom/YXPdY/Mtok99luaSxS+zZmDxY6SGCmVbx3Vj05zsxMVjSvjv2Gwsm94IKTFjRM/duIS9eGavQTTiWkMuDo00isStrzSokoH/sS4EalCO4NNIPllHBjCWHWjYRGmh+9+RwK54cDlKbhOalj7ZM2JT31yQhEwERsaZzUK86sPfP9vDOv8uGaDh8G9MzigOeX3jTxNFNHJsKoRui3a83C/ALKxLgFDkDxlU1Wtlb6NcniD+pvz5SMkbH4DBv9qWRCpv2UQbCKRJEXVGikpxAUYecRxwmH3YvVv2e2C4V9E7Bv4DKl0tqviBLZWxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCeUoRGANAPb6NTHsyPZj4mpFqxT7pGgYj9pI+O5q6o=;
 b=B4bI9tdCjPJwJKrxMKcXQxkUJhIFvEeVM3QaTs99uKA2SHlh4uw8/7aKXl7Df/I6lHZGsnK6KF9palEoliwyY4kKsWCPhfd4Ds4UOam6C4al1zBHSklizipxhmlRFzm/yjmb36mihxTH+eCl221iu0pen7MSaJdBUhxO5RDOgYn34UNz55GVrXVLz0UrzxnBmL9xnLFhnH7ayW5JhN6twLjeqYPmPaH5DEEO/SsBiUsjOj/9h9rkItXB1/ZiN7oi603ehbWNrS9B+TKvMBgjWHX4llchN5dr/ol9KWASrT/uUQzn9o32tg6utkSNlPL+qXowYrb+9EZeuj54F3On1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB6470.namprd11.prod.outlook.com (2603:10b6:8:c2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.20; Thu, 29 Sep 2022 15:37:55 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%5]) with mapi id 15.20.5612.022; Thu, 29 Sep 2022
 15:37:55 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        "Melissa Wen" <mwen@igalia.com>
Subject: RE: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to
 avoid userspace regression
Thread-Topic: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to
 avoid userspace regression
Thread-Index: AQHY00XBSghclGVOu0aBjgkf6Dcm5a31YfgAgAEfAoCAAAWNgIAAA3Rw
Date:   Thu, 29 Sep 2022 15:37:55 +0000
Message-ID: <SJ1PR11MB60839A08E01742321F8446BCFC579@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220928142109.150263-1-gpiccoli@igalia.com>
 <24f31510-5b33-ada5-9f0e-117420403e8c@intel.com>
 <1c742ae1-98cb-a5c1-ba3f-5e79b8861f0b@igalia.com>
 <cc8d0101-73b9-b286-a7a7-e9305cdc1bd9@intel.com>
In-Reply-To: <cc8d0101-73b9-b286-a7a7-e9305cdc1bd9@intel.com>
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
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB6470:EE_
x-ms-office365-filtering-correlation-id: b1da400a-3036-4b61-f141-08daa230943f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L+z0R3/Uk9kY9h0s3SLUoMzDwC5VXVyCioIiDSgUBX1QuYY2jqs8y37fO5ESIDACGtxvzqPcXfP2L37UUSqCTvB2KpaTTV7pPeWtR7MA5zpIjIhDI/6KhisCXUFCHXG1hj617qqK6B7fgFqnV4DkNTw4lq5uX9OLD+ZNkHqfao1Qq0FXG1RXGE6r9Qaq6B7ttkLXzR9CZR5B73RJvHSe+1zFGcSnUDSIehy2bTVO4A4vK79IwXvg00cRP6jjSc/JlNyY4xp9ew8bmrofbiA8vYNiC1hErQ2fa9WcPWxZCDCaG46QEnlkvZMxwhUCwipNDkRcFFC62cVE3dR00DJl+wqehspftrHDnP0DWe7PfnmhzR8RTgZsHkBihxY7bf8HMix0RqLz5U2MnthudnC7tS6XbRVxTAV6ef3ubZwnyZlFNTb2eQRfX8gXd5A5p1m/X3mtCCvNn2COldKakgQcExtNefMryKHvHjdwr4tj2zoZQjK3wrLv4e+nP+/GwNMfw6FIVHY8IkUyY2yVoShVdEjScOuIW/S4ODh2kAk0KcHbMCF2ujK/WiUFshVtw7bmco7pyojShhLV9OASKJUpqaWD49ThDAPqwB73iRJHDmpFYFQCSIiegRS/2ltLBkYX+nHGjOA7D0Uh0xZ+YLNsUD9YiDCylEQkU4/Ol6UeVjnveJwgNohTBkvTlS5yGQfeLNsCwaY1ERqTX+qxJhljMjKnZUgcJIuclxFtQkTtAnlR61jfaZi3PHp4R1XbmiamvaMj31itNothbYVc/tWxhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199015)(26005)(9686003)(6506007)(38100700002)(122000001)(82960400001)(4326008)(71200400001)(54906003)(8676002)(110136005)(316002)(76116006)(86362001)(55016003)(38070700005)(33656002)(186003)(83380400001)(478600001)(7696005)(2906002)(5660300002)(7416002)(4744005)(52536014)(66946007)(66476007)(66446008)(66556008)(8936002)(41300700001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlNmLzVQb0c2dHYvQlVhU1UxZHBrVkgwYkJrOWZYT1JOd2JEdkJZbmR4QkdU?=
 =?utf-8?B?b3ppc3JtUVJQR1VOS0pBNEF2WUhzb0o3cWpkbTAzT1hnMVcxTFJlMmRHOGtZ?=
 =?utf-8?B?VE82Q2RKV1NFWEpWdFE0eVV0UFJBeUhnUElkWDRzaDc1TFhjcTNEbUdlMkgv?=
 =?utf-8?B?aTBzU1Q4MUZ5UFZZWU1OY0N1eGo3R2Mrc25hREV1TE42cHJBVm8wZG1mN3RB?=
 =?utf-8?B?UHZraWhVZkY3dUhWTUljR0JQK0VYV1M1Zk94ZWdlQTA1OEF3VXBRM0w1RVhs?=
 =?utf-8?B?L1ZFNlh0eWRaVGxFOC90ZzZ3elZmQnJGUjlFRHdMbFdTT3NZU2hiNFBaYzM1?=
 =?utf-8?B?YnhybSthc0FjN29Idm4rWUcwNytwS3hMT0tEYk10Q0syMUxoOVNRckdyL1lR?=
 =?utf-8?B?V0IzRm40MXYzOCtaKzkxVk50QlRGSExaeWJiUG55TWQ5NitTOUJmSmh0Q3Jr?=
 =?utf-8?B?aGNCdnpUR1doNmNDQm9DNTltOFhEd0pzaDNuQXk1eVFkODdFcEhCZ2hNYVlC?=
 =?utf-8?B?M0lSdlVxbDBENHJGbGhqUWtJUXBHcVRlcjFScXdISGNzU3FEbDkyTG9NcEth?=
 =?utf-8?B?bGpKMUJ1cVY5ZmNsQnpsNTZMUUdYajdDZVJhT3N5WnNpd0FiMGM2clZuM0VM?=
 =?utf-8?B?RWl2SnZLeHZ2T0lRd0U4TzJMTVhlTTcvaEh5Qkw3cG5VeVJ0L3JFMTdxYzJx?=
 =?utf-8?B?bGVLQW5LQStiZmM2Q1JGNGtDR2NXQlVjeHpoWEppQmNSUFJBU2d3dzJZV0hu?=
 =?utf-8?B?S1NwWDRtQngvMTRtUFJ1RmpVTytNaE5JejJOaEZTZzh1aTNxWm50disrVFZF?=
 =?utf-8?B?Q0V4bXRFSURjcE4zYUlEM1hYZ3NjY1hBTHM5OC8yR0ZXYS9YaW14aEwwRisy?=
 =?utf-8?B?QTNzOWJzR0dPQ25lWm1aUzBtL0didExoZms0bDJva05qeDRmV1lYWDN0ZXg4?=
 =?utf-8?B?YjRSdmxrRTZiT29IRHl0amVUWWJ6bnRZV1NpYWEwSWg0aUVpdTFPMWJmMXBk?=
 =?utf-8?B?c0cwOUlQZk5iaTFQSXNDd3d5YWNncEV1WU10dTFnSTdzZU5Fd0xyS2xVM1hS?=
 =?utf-8?B?dzFTeDhud21hWUVNanBjckE0VlNFTWlCSFhaV3dOak96SitNVVNlWEtvY0hY?=
 =?utf-8?B?S3REUXRmRFVVVHAwZHpkWGFBYmVCQU9iblZ6MzlSdTRwNVdpUEg5eTZ5TE9r?=
 =?utf-8?B?c0d4anRmcSthTmZqSE5LbHl3cE8rUkM0WUh0UW5GUTVQMlB2UVFIYzYweTE3?=
 =?utf-8?B?MkdXQXNPQ1RyUGZCelFBZWczME05NUxKeUlkNWJtenIyM24vbmtaQS9zSUhn?=
 =?utf-8?B?Vzl0Zmg5alNBT2Q5UUI1UERpMGpYRmlkSWhGRlZNajZoMFNhTHFGL2tnclZU?=
 =?utf-8?B?dDU1eU1hbUxobEJ0OGhVK2VlRE00UXI1SUdmNFpFcm9WUElBTDl4K1ZWSUY5?=
 =?utf-8?B?WjFpazF4VjFia0c3MDJpbTBIb1pJNEtZcFdtY1NoK2lCb1REaFNKVDZFVHNH?=
 =?utf-8?B?S0ExMzJpMzh2emdRYVVRMjVCc2RTWXNlQUs3dXRGWHRyV0IvR1BKZHk0ak8v?=
 =?utf-8?B?Yit6RzJscUdZS1VNaU5nbWp3SlVIQzJWeEhSZThMY0FKc3A1aDIxaHNrZkZQ?=
 =?utf-8?B?TW90aURDUjZBbjg1dE5sWnZta1dnRW1VNWlKT201b0EyMlhjdHlrZTI1bXI1?=
 =?utf-8?B?bC9hWVR2bXp0RDdxcEhvSWt5OW9laFBxb0ZMcTBXSmpSVmVscTVmN1liZXN5?=
 =?utf-8?B?cmNkdE5qZzdHRi9zRm84ckJ4c0xsY3Y3THZtaVhYTy9XcWE1UlMyTTV0RVp3?=
 =?utf-8?B?K010eVQvZjRTa2U3QlRjM1VKWXZwdCtnOHUwSWJDOHBBRE9wa3pDVU9rYURQ?=
 =?utf-8?B?VWNBMUIxZnYxSUlrNzg0ZUNNZndPWjdhaUpHcXB6YVhpNlpYeDhzcFFNNnpK?=
 =?utf-8?B?ODgzYTZVL0R3N3Nma21ncmxKUDRpYlA0TGRNYnBKWm5sdWNyd0VvVWdNOUZC?=
 =?utf-8?B?Lzd5aTRqb3c1bGliT3YvV2s0ZnlVd0FTYUE0VkN4NUtNWm5VQ2txeEo3RWgw?=
 =?utf-8?B?RlFENWV2eUY4YXl0UitiS0c0dFJPdm5nY1RFQzB5K253cUxnejdZOWFBSDho?=
 =?utf-8?Q?Iya7iWVFM8SzBTUGYj6dE+iEQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1da400a-3036-4b61-f141-08daa230943f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 15:37:55.5538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ut07zgpLMHNAaMiQQQRFWAqP9S6y2tBy7e4YCF6j8XaYE3ikerjBqlZN7HX4b8FUppvmzSzYq7htaoQyGH2tNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6470
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gSSBoYXZlIGEgcmV2ZXJ0IHJlbW92aW5nIHRoZSBtaXNlcnkgcmVhZHkgYW5kIHRlc3RlZCwg
bGV0IG1lIGtub3cgaWYgSQ0KPj4gc2hvdWxkIHN1Ym1pdCBpdC4NCj4NCj4gSSdtIGEgYml0IG9m
IGEgbGF0ZSBhcnJpdmFsIHRvIHRoZSBzcGxpdCBsb2NrIHBhcnR5LCBzbyBJJ20gYSBiaXQNCj4g
aGVzaXRhbnQgdG8gbWVyZ2UgYW55IGNoYW5nZXMgaW1tZWRpYXRlbHkuDQo+DQo+IEhvdyBhYm91
dCB3ZSBnaXZlIGl0IGEgZmV3IHdlZWtzIGFuZCBzZWUgaWYgdGhlIGN1cnJlbnQgYmVoYXZpb3Ig
aW1wYWN0cw0KPiBhbnlvbmUgZWxzZT8gIE1heWJlIHRoZSBiZXN0IHJvdXRlIHdpbGwgYmUgbW9y
ZSBjbGVhciB0aGVuLg0KDQpBcHBseWluZyAibWlzZXJ5IiB0byB0aGUgcHJvY2Vzc2VzIHRoYXQg
YXJlIGV4ZWN1dGluZyBzcGxpdC1sb2NrIGZsb3dzIHNhdmVzDQp0aGUgcmVzdCBvZiB0aGUgc3lz
dGVtIGZyb20gYSBkaWZmZXJlbnQgbGV2ZWwgb2YgbWlzZXJ5IChmb3IgdGhlIGR1cmF0aW9uIG9m
IHRoZQ0Kc3BsaXQgbG9jayBvdGhlciBsb2dpY2FsIENQVXMgYW5kIEkvTyBkZXZpY2VzIGhhdmUg
YWNjZXNzIHRvIG1lbW9yeSBibG9ja2VkKS4NCg0KU28gdGhlICJtaXNlcnkiIHNlcnZlcyBhIHZl
cnkgdXNlZnVsIHB1cnBvc2Ugb24gbXVsdGktdXNlciBzeXN0ZW1zLg0KDQpNYXliZSB0aGUgZGVj
aXNpb24gb2Ygd2hpY2ggbW9kZSB0byB1c2UgY291bGQgYmUgZHluYW1pYyBiYXNlZCBvbg0KbnVt
YmVyIG9mIG9ubGluZSBDUFVzPyBMYXB0b3BzL2Rlc2t0b3BzIHdpdGggbG93IGNvdW50cyAoPDUw
Pz8/KQ0KY291bGQganVzdCAid2FybiIsIHdoaWxlIHNlcnZlcnMgY291bGQgZGVmYXVsdCB0byB0
aGUgInNlcSIgbW9kZS4NCg0KT3IgcGVyaGFwcyB0aGVyZSBpcyBzb21lIG90aGVyIGhldXJpc3Rp
YyB0byBkaXN0aW5ndWlzaCBzaW5nbGUtdXNlcg0Kc3lzdGVtcyB3aGVyZSB0aGUgc3BsaXQtbG9j
a3MgYXJlIG5vdCBjYXVzaW5nIHBhaW4gdG8gb3RoZXIgdXNlcnM/DQoNCi1Ub255DQo=
