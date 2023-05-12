Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3CE6FFF35
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 05:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbjELDU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 23:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbjELDUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 23:20:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD3D4C3E;
        Thu, 11 May 2023 20:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683861624; x=1715397624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I5h9cHVOSeSFlrvqinGOrXfIqPGTlCkc74kg//xXTeM=;
  b=OIiWJir/VKU1mWIQyDJcU4hdP366H5N4EdUjKRBwvjT7vDumq0My77+q
   Y3nJBH8ty6B5iG23TpepavfIQzt9aIcMaAdmfDNgWHf5cB+MOZ+afEfEu
   tn3JMJ6WO2wZ9q7OVcR7C/4RSFvYsfr8X5iJCu/WNSn3X5l7NplIVRaYr
   rLeI9sJDZFpil+8p5FGPYOdH1gbjcm7VMQgdolMu8scoNqPQyIPpycbFz
   3neBcBrVaflWXCmzXIrrUNUwWL2fewmnchNhQ+W4fWCxhVUFci/Y4t2Dy
   /ovUC+3lbSs3k5ZG6QFHWK/KM2AFvX3fe4raECDEeVfrQR7Wimp46l9D+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="416318788"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="416318788"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 20:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730645616"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="730645616"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2023 20:20:23 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 20:20:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 20:20:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 20:20:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mINN/KA3lSuv1006MgDo3xw6C7QrHGP1tbo+5J+K/pz3hPAjkJDzp/Jwj6cds1i2ZicDc1asyuhHKXr64Y2M7sIFWA4oN4Jbo5OS2nj+8DqaD5OriWtdV2Tmzb+YFUQjK2ewWq011aZwrsq8NurUU+XHEl0x4WhSsViYrJ9UyFq/z6BlOJQzaxvyUukfH7bXb4dUfxFnZwpR7atLUwWzX8hqXv6bBObSpmanvLwFrb8hTHcbF9+z7/dDC8WXBJFLO5vxGFYoqntcAt/wJ+BdgNpWpgcmerX1KOZpk/IYHyTZ47XfFEPSIknilO4lr+AUkdLg8MazTdhCr4q/nJXCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5h9cHVOSeSFlrvqinGOrXfIqPGTlCkc74kg//xXTeM=;
 b=I1PWIhsVTiFYl95g1a1jX+bJKjx56RTBpMTIR6As/wjfS3tnoVRvsQak5Zmuh+xNXDOBxYoJGOKYm0ZpRzp/kFRxv32x/DfUvqFqvTimXfUO5mBOmlrhKSt/xuGDae3XPG8R27dXgJPZ7im09yYKmad7Z402FyZ6/T2/BR/9N0Lh1Y/LuxMOwuyxQTRWNNnFG65ywigM9Uhggj4Hu54ADcFfvlurkbMa2eC2s+49FwJQcuSw9dc6M3DXrCBUpjAV8QKh3Ke+I6pzjdO63/39BzSe/nIpBvoF6sltzRR/OtOVEDZUEkhh1kvO+gJ5oKvGijSTVgrVXpaw5XMeZfOuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by SA1PR11MB6893.namprd11.prod.outlook.com (2603:10b6:806:2b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 03:20:21 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982%2]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 03:20:21 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: RE: [PATCH rcu 3/6] rcu/rcuscale: Move rcu_scale_*() after
 kfree_scale_cleanup()
Thread-Topic: [PATCH rcu 3/6] rcu/rcuscale: Move rcu_scale_*() after
 kfree_scale_cleanup()
Thread-Index: AQHZg2KlduYd6z/enEeC6gWcmPig2q9Uip+AgAATm4CAAHvjAIAA2thg
Date:   Fri, 12 May 2023 03:20:20 +0000
Message-ID: <IA1PR11MB6171B1AD7716B95B0B2C683889759@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
 <20230510171238.2189921-3-paulmck@kernel.org>
 <CAEXW_YTHNbzdSn3RpJwnwKZOJX=rGdMabfsCw0ZuMZhsXZMjQA@mail.gmail.com>
 <IA1PR11MB6171FA965F8FF915621482E789749@IA1PR11MB6171.namprd11.prod.outlook.com>
 <7a91a10d-3518-4452-b9ca-51240f00d29f@paulmck-laptop>
In-Reply-To: <7a91a10d-3518-4452-b9ca-51240f00d29f@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|SA1PR11MB6893:EE_
x-ms-office365-filtering-correlation-id: bbb3d012-5988-489d-2016-08db5297d118
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bSQ9BuHBif6aStiD9beNFzMt4wZmimhJRJ3J6bNrTr35SM2OvROcirNr5qcVnzSaC1fQw3k1fjXp+/er9SrakDs+Num9lbpWDXLS+UCI8GSbZt42xfjqmADySBYeGUboB81D0CPcEDdyNf57QFqSGJs2UE8Yixz01yIKbdTeft4Y7q1TD4L+Gy7xdopbPFu1z8fB4OeWnuMsvcW2iwVdu1Nbs1O1P8vLfnrH3XNGY8WN9Yxxx/EXpTAvdVnm5HlkfL9c7Aep4k2Jmq1AIdGWMjhMFIZiWeU6HiM93icxlMUWWO2tevuJrS2xMumIKAuWGAfF7JESoUlYC8ilHd8TB8S+/U1T6RJd8wp/qHxsd+p6U1Xo1e3ggMfHZaGBAV68GkOIECLAD9XjwA26kdCC7jtowswJl7ikF+9nZPiciWyVwdQA9eR6YyN3FxJ96qM1kAmJrd+nqEt4irp2JwueMES2KSp3ZXegdVvICz9uQdXlqyNpy38rbKo8nAjOS9ghgOVsejdlL5ZYaoFY//U/BOuJDr4BAGAC8K2o0Q70yeb7Ne6nBg30dSk7oYWpSKJxFnj1LwjEloWlqXEAlgRX3qN46n0U2bRrNeZINVD01MJLiGreHwKiPU+7on2WHCQZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(83380400001)(66946007)(66476007)(66556008)(66446008)(5660300002)(26005)(64756008)(86362001)(76116006)(478600001)(54906003)(55016003)(71200400001)(7696005)(2906002)(186003)(52536014)(33656002)(316002)(8676002)(82960400001)(41300700001)(4326008)(122000001)(6916009)(38070700005)(38100700002)(8936002)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjI0V0pxNTYvMEh3d1lGNk01T3IrMmhIbnFlN3Q5TnMyYmJ2TUhkZVhqMk9P?=
 =?utf-8?B?akhNVnlqMFBiY0RBNnR1WFErdUVlYlBlbnpjK091VlZSemFFRGFrckhKbWxB?=
 =?utf-8?B?UHZVU2FVaG9vTnRCQTlQZ3VnSnhENnJkbDdhc2s2cWlnRUpFelowKzd0b1FS?=
 =?utf-8?B?SjZGQ0p0d1ZMckF5bnNrUW9hMTF3TTBObDNLMlNwYy9RbXBXeHVBSmJpc3hm?=
 =?utf-8?B?b0trWFRseHBydGpMeUc0MjFlQWcyTnhBZ29nSDZ4N1ZTRm1EZHdlWVo4Mllz?=
 =?utf-8?B?dXJuUDlFT2g2SFdCZzRSOExORDh2OUFId0loeFFQYytMbWFXTmZ4YWNOYjJR?=
 =?utf-8?B?RzB1MncyaDlpbnVjTW04NnJLaVlhSG92VUFCRlhKTzA0UVVVeTc1bFNOc0xp?=
 =?utf-8?B?TWVFWTZ4UHJNeGgxQnJnZk5zT0xSUUdWU04wV2dlK05qWmtkNzBNeTJOcGQx?=
 =?utf-8?B?bTVsYThCNUtkQ1pyd0kyLzFEN3JnUTdaMjh1NWR4QTBHQVhVNWl3OUFIZzNG?=
 =?utf-8?B?U3Q5UVB5Ry9FVVdHWkIveW1pU2dEZFgwbURFS3UrcGM4OGxINUtvWUV4Rkdt?=
 =?utf-8?B?YktjNVhzUS9FTmdMcU5YTVM3UlNKUlRvdStHNGl6cjlwU1FZR1d1elo2a0I2?=
 =?utf-8?B?bXBRUTl6NjlEME9ERno3RG04azVUUTR2eXJOQUU3ZE9uTnpMZHFES2xsa01T?=
 =?utf-8?B?UVZoUjVRSUtITFRYZytXTWt3SGFoNXRFSlJKWEtuaVFFeXBNTnVzSnpXTENE?=
 =?utf-8?B?YytybkJTalRlSEtwUVFXNzdGQTd1SlFXZVhBSHdadU91ZFIyMm1mUDJ5aHRq?=
 =?utf-8?B?YkV2eS8wbXlGWDNWUHNkNi9XdERJWitKQmNXWjBZQWRCbmlQemIrRUNQNnNB?=
 =?utf-8?B?b0F0M2Q2UXlIMDlBK0UzbTR6Tml3Yyt6N0xyUmJFSWlUcTM5QWczemliZHBz?=
 =?utf-8?B?MXJwaEFMS3JEdjkxZzZYbVlYRzBFc2h1cGhjTlFDZjlud2NMUnpYQk8vTmNQ?=
 =?utf-8?B?U1dTV1pORllGQmgvbk5rcWhxWGRrOElWUlpSZFZFQXl6K1JtRXpyZWQ0aFlG?=
 =?utf-8?B?eWd6cmtzaytsaTRLUzZyMXNyRzRkUUloZGJMVS9CL3FNc0xGd00rQnFmK0dW?=
 =?utf-8?B?bEEvWHpKWll6SFZBOStRUyt5MnYrVUMrdEtWc1lyWWNKeDdkN0pOcEN6dFN2?=
 =?utf-8?B?My80UnZ5WUxmTGNGTFVWeGs5SVA4RHY1WDdhTzZXNGFzc2xGRUFPSHVLenZ3?=
 =?utf-8?B?eUR3Q1o5K3JzSGVKSUUvQndXb0EydC9QZzJ1cDM3Q0RKUlF3a3Q0Q1dVWldQ?=
 =?utf-8?B?YUcxRWkvVm00YzNtWTZURGlpU1ZsbDlpVnpwbHhlbUsyWkJmOEZDcUUvUmZ4?=
 =?utf-8?B?WGlRWFZoYm9ack9PcmkzY2djWXFDV1JWNFE4NTI0em04bHJlRngxRjlyU0Nn?=
 =?utf-8?B?SS9Yb29XVURHK05va0owbkd0V2xuMEovdmpRM1BHWDZVcW5SNHRwTk4xcFYv?=
 =?utf-8?B?L0p1T3B1RXN2cDJkV1ZxYmE0QTdtNEpmZ1QwbVBpcmFwcUlNNUZwOGJHSCtn?=
 =?utf-8?B?MzRHY3VPZkx6QmRVaGlWdG4xMkVEWnk5WXdXOEhFY0Q4WFVyM2hhWERSNmJK?=
 =?utf-8?B?L3BJVlZVK3hYVmxmMkpZME95ZWdGVHhDd0w0UDFqWHZweGVCOTNZRTE0ajRI?=
 =?utf-8?B?Wit0dkVJcUx1VWkyOGdIWHNId0x0YnIzN0gwUCtEdzYzTGN5MXVmYVFWa2g5?=
 =?utf-8?B?QkVhR0tzakdnZVE5NldEZUdhRzZiV2RMdm9vbzFwL1NUcDVHOGJDYlEwN1lY?=
 =?utf-8?B?Vi9WMGp1T0hpTEttQkF6OUJqNlR6UFNaaHZIWWdIVXF0VlZJVHZtRFdBTG91?=
 =?utf-8?B?bDE1M0FYQVBVQ3pFM0g1R253cWY5ak9pbWNhTXlXUXUyZ25DUUZVMEhCK09N?=
 =?utf-8?B?QzRvTVg4eE1iY2t4aHFWeko0VXVTaklHbERmOTgyQWlySk4waTVlMWVRLy9J?=
 =?utf-8?B?S2I4Y01obDhZZUxBZVFWdkh6VytFVmlzZlNMTzJPUFV1NmY0ZDFrdldtMUNL?=
 =?utf-8?B?cEUrN0tDVnlldm5ROWRNVzBHM1JjWVpDL3NYQVlUbFBNZ0FCTEVWSGRkQmRC?=
 =?utf-8?Q?lxhxWaq7EGeSFT3gLHK+6NCM/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb3d012-5988-489d-2016-08db5297d118
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 03:20:20.4182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDst+JzMxw+5l11jT/E6HUJP7goKM30W0NCm+R1Zdu3zu/fqvaUgh1X8avyc1RmiCHv1i8kbxCskd3mUnFjjOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6893
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQYXVsIEUuIE1jS2VubmV5IDxwYXVsbWNrQGtlcm5lbC5vcmc+DQo+IC4uLg0KPiA+
ID4gSSB3aXNoIGRpZmYgd2FzIGJldHRlciBhdCBzaG93aW5nIHdoYXQgcmVhbGx5IGNoYW5nZWQu
IFRoZSBtZWxkIHRvb2wNCj4gPiA+IGNhbiBoZWxwIGJ1dCBpdHMgZ3VpLi4uDQo+ID4gPg0KPiA+
ID4gU2hvdWxkIEkgcnVuIG1lbGQgbGF0ZXIgKEknbSBvdXQgYXQgYSBjb25mZXJlbmNlIHNvIG5v
IGFjY2VzcyB0bw0KPiA+ID4gbWVsZC1jYXBhYmxlDQo+ID4gPiBtYWNoaW5lcykgb3IgYXJlIHdl
IHN1ZmZpY2llbnRseSBjb25maWRlbnQgdGhhdCB0aGUgbGluZXMgd2VyZSBtb3ZlZA0KPiA+ID4g
YXMtaXMgPyA6KQ0KPiA+ID4NCj4gPg0KPiA+IFRoYW5rIHlvdSwgSm9lbCBmb3IgdGhpcyBjb25j
ZXJuLiBHb29kIHRvIGtub3cgdGhlIG1lbGQgZGlmZiBHVUkgdG9vbC4NCj4gPiBJIGp1c3QgcnVu
IHRoZSBjb21tYW5kIGJlbG93IGFuZCBjb25maXJtZWQgdGhhdCB0aGUgbGluZXMgd2VyZSBtb3Zl
ZA0KPiA+IGFzLWlzOiByY3Vfc2NhbGVfe2NsZWFudXAsc2h1dGRvd259KCkgZm9sbG93cyBrZnJl
ZV9zY2FsZV9jbGVhbnVwKCkuDQo+ID4gWW91IG1heSBkb3VibGUgY2hlY2sgaXQgOy0pLg0KPiA+
DQo+ID4gICAgICAgbWVsZCAtLWRpZmYgLi9yY3VzY2FsZS5jLmJlZm9yZSAuL3JjdXNjYWxlLmMu
YWZ0ZXINCj4gDQo+IE5pY2UsIHRoYW5rIHlvdSBib3RoIQ0KPiANCj4gQW5vdGhlciBvcHRpb24g
aXMgdG8gY2hlY2sgb3V0IHRoZSBjb21taXQgY29ycmVzcG9uZGluZyB0byB0aGlzIHBhdGNoLCB0
aGVuDQo+IGRvICJnaXQgYmxhbWUgLU0ga2VybmVsL3JjdS9yY3VzY2FsZS5jIi4gIEdpdmVuIGEg
bW92ZS1vbmx5IGNvbW1pdCwgdGhlcmUNCj4gc2hvdWxkIGJlIG5vIGxpbmUgdGFnZ2VkIHdpdGgg
dGhpcyBjb21taXQncyBTSEEtMS4NCg0KSnVzdCBoYWQgYSBnb29kIGV4cGVyaW1lbnQgd2l0aCB0
aGUgImdpdCBibGFtZSAtTSIgb3B0aW9uOiANCi0gVXNlZCB0aGlzIG9wdGlvbiB0byBwcm92ZSBh
IG1vdmUtb25seSBjb21taXQgcXVpY2tseSAobm8gbGluZSB0YWdnZWQgd2l0aCB0aGF0IGNvbW1p
dCkgKHRoZSBmYXN0ZXN0IG1ldGhvZCB0byBtZSkuIA0KLSBUaGVuIGp1c3Qgb25seSBuZWVkZWQg
dG8gcXVpY2tseSBjaGVjayB0aGUgcG9zaXRpb25zIG9mIHRoZSBtb3ZlZCBjb2RlIGNodW5rIGJ5
IG15c2VsZiAoZWFzeSkuICANCg0KVGhhbmsgeW91LCBQYXVsIGZvciBzaGFyaW5nIHRoaXMuIEl0
J3MgdmVyeSB1c2VmdWwgdG8gbWUuIA0KDQo+IFRoZXkgc2F5IHRoYXQgYW5vdGhlciBvcHRpb24g
aXMgdG8gdXNlICJnaXQgZGlmZiAtLWNvbG9yLW1vdmVkIiwgd2hpY2ggY29sb3JzDQo+IHRoZSBj
aGFuZ2VzLiAgVGhhdCBpdCBkb2VzLCBidXQgSSBhbSBoYXJkLXByZXNzZWQgdG8gd29yayBvdXQg
ZXhhY3RseSB3aGF0DQo+IGRpc3Rpbmd1aXNoZXMgYSBtb3ZlZCBodW5rIGZyb20gYW4gYWRkZWQg
b3IgcmVtb3ZlZCBodW5rLg0KPiBGYWxsIGNvbG9ycyB2cy4gd2ludGVyIGNvbG9ycz8gIEV4dGVy
aW9yIHZzLiBpbnRlcmlvcj8gIEFueSBwYXJ0aWN1bGFyIGRlY2FkZSBpbg0KPiB0aGUgZW5kbGVz
cyBydXNoIG9mIGNoYW5nZXMgdG8gZmFzaGlvbj8gIFBlcmhhcHMgc29tZW9uZSB3aXRoIG5vcm1h
bCBjb2xvcg0KPiB2aXNpb24gKHRvIHNheSBub3RoaW5nIG9mIGJldHRlciBmYXNoaW9uIHNlbnNl
KSBjb3VsZCB0cnkgaXQuDQo+IA0KPiBPbiB0aGUgb3RoZXIgaGFuZDogImRlZmF1bHQ6IElzIGEg
c3lub255bSBmb3IgemVicmEuIFRoaXMgbWF5IGNoYW5nZSB0byBhDQo+IG1vcmUgc2Vuc2libGUg
bW9kZSBpbiB0aGUgZnV0dXJlLiIgIFNvIG1heWJlIGl0IGlzIG5vdCBqdXN0IG1lLiAgOy0pDQo+
IA0KPiBZb3UgY2FuIGFsc28gYXBwYXJlbnRseSBjaG9vc2UgY29sb3JzIHVzaW5nICJjb2xvci5k
aWZmLm5ld01vdmVkIiBhbmQNCj4gImNvbG9yLmRpZmYub2xkTW92ZWQiIHdoZW4gdXNpbmcgIi0t
Y29sb3ItbW92ZWQ9cGxhaW4iLg0KPiANCj4gQnV0ICJnaXQgZGlmZiAtLWNvbG9yLW1vdmVkPWRp
bW1lZC16ZWJyYSIgbWlnaHQgYmUgbW9yZSB0byB0aGUgcG9pbnQgZm9yDQo+IHNvbWVvbmUgbGlr
ZSBtZS4gIEkgd291bGQgbmVlZCB0byBleHBlcmltZW50IHdpdGggaXQgbW9yZSBpbiBvcmRlciB0
bw0KPiBjb25maXJtIG15IGh5cG90aGVzZXMgYWJvdXQgd2hhdCBpdCBpcyBkb2luZy4gIFRvIHNh
eSBub3RoaW5nIG9mIGJ1aWxkaW5nDQoNCll1cCwgdGhpcyBsb29rcyBhIGJpdCBwYWluZnVsIGZv
ciBtZSB0b28gKG5lZWQgZXhwZXJpbWVudHMgdG8gY29uZmlybSBoeXBvdGhlc2VzIC4uLikuIA0K
DQo+IHRydXN0IGluIGl0LiAgUGx1cyBJIGhhdmUgdG8gb3BlbiBhIGNvbG9yIHRlcm1pbmFsIHRv
IHVzZSBpdCBlZmZlY3RpdmVseS4NCj4gU28gbWF5YmUgImdpdCBibGFtZSAtTSIgY29udGludWVz
IHRvIGJlIHRoZSB0b29sIGZvciBtZT8NCj4gDQo+IAkJCQkJCQlUaGFueCwgUGF1bA0K
