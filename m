Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D441666D6FF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjAQHel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbjAQHeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:34:22 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CAD3A9A;
        Mon, 16 Jan 2023 23:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673940854; x=1705476854;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dRAqi4LlWoS6YSiHrgYvyvhPFGECDNA06p1XO5zYVOY=;
  b=hIDwq4Ago8Qe8FIqi5A8+/mJ5GARd6T8RgQcYGDJZeuYUMqLGtvxnEYS
   +eCAm8qaBxjWZ/QJ8G8DRTKZk2wl42Xks/PcLDJ9nrX8k3mTCCX3evyU4
   DwbAhzqCbXOmpUHa9AKvYcC0M0P6qdmwjkTmoXHa16LWOp9d/sPO01Rtt
   mFWxc5gYSshJz9h7mx/irQeohutN7QbqDeJ0/mbQqDb46SjA+/CXPFbbd
   HYzQmZpLpdHym6Z2EVVOqTOfFEZfGsO//w9aoqvlFEyWssABMEAerDjGY
   s9OeEpOssjsCONnHuSw1eBCFlarYHzmbakGjsLf4BcsH8cxWIlOOP7xep
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="326698029"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="326698029"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 23:34:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="659291105"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="659291105"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 16 Jan 2023 23:34:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 16 Jan 2023 23:34:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 16 Jan 2023 23:34:12 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 16 Jan 2023 23:34:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZX9Sur59Xl0Hq5chMOVcHnchr9QrX1Lxpkz0u5AGPhuXYsTHbkVGuthbxbdiE95fRrz7/9oFO/CICEBoEpKNU9hv3lgAe2REVGoCWYrjWkhf29tOW5T4I0lKP5bcJF8cQ6q2+ydTKxy6embrWTK633aNHBSc2Al11+FlGI9dGAF9rnOCLjm7iVTR1L9WKJo1BST6O83AXRp8dY3X4Q/MhCADbPKryG9MZj4t2B3sYLsT08lDVZI9W6SKKJsYPhYAxF5oXJh3nhoZ6nCpQWsYpR4XBh0hJuhRBih35kJXfYk+1DkEF4it3LgtIi82sZ7E2M7YQxugjyK+83wSgiL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRAqi4LlWoS6YSiHrgYvyvhPFGECDNA06p1XO5zYVOY=;
 b=fk3w/DcpI4oYTSV8azohomEYBByuVpdXzQ0j3iAuawWqvAPL8PNM4PlKAPyh+QWNHe5nu9prZSHb+JTlPyfJ4i5ldModN6R0m0dbUxgpH7Qf3HOpJBzIoM7ukXkfjPCrGVVPQHlgHO1eS1RXcMSRt4/lEKenOqF5EfiZpxVi8B0Wqk62ijTs+Z1J5TXiSz1RcEnhse17CeErnse/h8U1LHAjuRkNMG3bOPsrvFiLSqu5wFse6LUKN+yxFWu9Z7To3OTl882keYB2on3pHDt7jsN32A5HfvULpdvZUtc/G45pyvCX+9WeMYG+yW1qonb8jMv+3oaj0jVogrEEPHwUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MN2PR11MB4550.namprd11.prod.outlook.com (2603:10b6:208:267::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 07:34:10 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 07:34:10 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Remove impossible wakeup rcu GP kthread action from
 rcu_report_qs_rdp()
Thread-Topic: [PATCH] rcu: Remove impossible wakeup rcu GP kthread action from
 rcu_report_qs_rdp()
Thread-Index: AQHZKhl/JwHnq+wFDkabPiRgfTY04K6iBU+AgAAyOqA=
Date:   Tue, 17 Jan 2023 07:34:10 +0000
Message-ID: <PH0PR11MB58800BCFE75CD1532F735024DAC69@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230117021955.1967316-1-qiang1.zhang@intel.com>
 <20230117043249.GE2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230117043249.GE2948950@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|MN2PR11MB4550:EE_
x-ms-office365-filtering-correlation-id: f076f8a9-801f-41ec-4e34-08daf85d399a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BhpzQSpS28RoNWF40mR86ZBahYhFniXiWs//+3tWrOE8QX19rBODWDr1RWMQDAX8tosA983SWfgwQaBTy01ZOhG/gxppJTptuGw9z3Pwwq2Lk7+8bGFVMyWU2ASL9NFd3IN4lic/c0bUtUag8jIPWcrtG+CernCEM9lu0ih081/vDs3w7U0A2Qv+Gv96rwfXij0R0RuKa/cgM7eJNFGwDEXs88o+tlGyPDkFHUo8SqOiQN41wvNsTza100h5PFIQi6IvKWkzq+jXIst2I0rlLhjsovVywXTgQ/r6/3B+1qGGu/B79bIerd0vB8JcIUjiHcn0MJx8HkTU6Wa3qR1JdPsu4RTF7JCSwGc/3E4tXvrdawpHJ/8hEWbrLKVGhOij1E/MTQgbjORIxLY7DKxAfUGbWxrL/YwzYb4j/BnhDWyhIh9S3YOKdPdA1zW4x3k5Ews1xJEMqFICg7pskgOps2w5Tal3QBsZeOioXSm7N7CgfLgflIun238hikiypnsxioEAholcfLKbEB00GBvgTAmvQLOoBUY4AUDXwJ8QLQuhdAoCqGy+QvelyEdgTlk6xsKmEw5j4XlANaEFORwMndbUB7QET9H/boC/ditO4xex43hUNx5GEhLRm4WRWvMdxfuG85JAZQ6ZIAZrGId0HtX4bRhWgxSsue78vdLH0rVd+GYjfZVMBFsT9haylU1CxupsMPyV0wFWA1t/of4GzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199015)(86362001)(33656002)(76116006)(26005)(8676002)(4326008)(6916009)(64756008)(186003)(66446008)(66946007)(66556008)(66476007)(9686003)(41300700001)(66574015)(6506007)(316002)(55016003)(71200400001)(38070700005)(54906003)(38100700002)(478600001)(7696005)(2906002)(122000001)(82960400001)(52536014)(83380400001)(5660300002)(8936002)(66899015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEZBd05jVmgxd0JDamlEeThvVDdueGhEWi9McVNCbm9FVWxuQzJEK0pyVTM3?=
 =?utf-8?B?TGhMVVc0cHBFVWszNTZmZ3pVVlpBSkVCclZpd1lReHBULzdjKzVOaUVGS1Zh?=
 =?utf-8?B?R3VyM2xhZWY4bzZpZTZZL3puS3JSQnJkTHRLdFYrSkZ2MFBINCtmUnVQZG1k?=
 =?utf-8?B?bWhYc1RJY2VxbmUxaW5ZY01pelZKMkh5aFI3MG1RdjgzNC9xZkdMcEJBSGVV?=
 =?utf-8?B?dkpOc0tDSTZPTWd1MkpPRWtUem9jaE5zNENuODJFZlZVUFZQUklUTDV5d0RK?=
 =?utf-8?B?c1dRa1VqSkY3U09IRHJqU1dQdTJrTmZTV3VsN0lqeWJHTlFxek1KdHROU0sr?=
 =?utf-8?B?RzU4RHAvY3RubFBwc0dJQnN1Z1VNOTJpODQ4clZEYm45Nk9rNWpmdmJCdy80?=
 =?utf-8?B?RVlWZGdGcDdBelZRTVZ3UWl1eDJYR1puQ1ZaMDVJYUZkUllsd0s5QzE3dXln?=
 =?utf-8?B?M09KOTU4ekgrTFF3aExFeW5UWlN6RnhmekxHSW1ncC96NDJsZHovOHNkazVM?=
 =?utf-8?B?M1YzaThtczhXbkRiSERKZlBEQ1JsNE9wNjd4ZnpBUndMelNqaFVmd1JEa1Fr?=
 =?utf-8?B?MFlOSWRDZXdkcFB2anpRclpHYWJYejRKUEU1MHp6bVEwNjMrd2ljaDdFdXBj?=
 =?utf-8?B?Y2cxNmRGcVN2QUhxOWZ2dDUwYXUvZUxEZTJoeEJmZVJlNnMzQXBDQ0ZDaGpG?=
 =?utf-8?B?VURXMlV0QXpNRFFJWmNUT2NZSUoyMTd0Smo4dkY2M0NxVVhIMGx3aGtKRXZZ?=
 =?utf-8?B?NHdENG1PWnMwR1hDTGFmaVorN1RiTFFXV3orWG1yRE9UWmh1RkF3Wm1EL2Mz?=
 =?utf-8?B?Q3JYa1cyNm1VTFNvVURQKzJ4dVFvc3pFYVR0cEF5UEVMYVZuVm1pZnFidWNs?=
 =?utf-8?B?Z2x3VFlXeHhrQTQ2MVI1cU8yNVJJMFo5cm1FU1Judlp4ZUsvTnRtVndwSkpG?=
 =?utf-8?B?VGY0V202dUhXd2Q5TmtYR2JFMnJONi9zYkpqNGFtb3oyd1V1aDF1ckRjaDVl?=
 =?utf-8?B?TS8zUXBDd01mYk8zeGMzL2tjeEFhVktFbk03T1RPYVdneENnbUd0N3dGYXRt?=
 =?utf-8?B?RCs1MExoblFmemJMRDBEQUpZbEp4UHRkZGFqckdIK2Z1UzhlcklwQWhiRE85?=
 =?utf-8?B?U2RnSTM3WmR4bU0vb3FCVWMxazZmVUZUSHdMcjdrVlZKR1hzY1hjUFYyS1R6?=
 =?utf-8?B?NzNsVlVkcUk4UnlabXkwdWpib3l2ZURrMFBNQXZFWW45WW1nTGFYVlQzN3VQ?=
 =?utf-8?B?V3UvZjJoOFE4Y1VXNW9XYmtRSzI4Si9oNWVZY1dKdjk5S2FTYU5xZFRjWXor?=
 =?utf-8?B?aldDL0Fjc2lsNmpZV2hpczl1alBmWXE3S2d2WjBralM4cEI2ZFBMNGFySmVI?=
 =?utf-8?B?UWEzUzQ3bXVjR0IrM0I4dUhhbXpiQ1JiemVlV00xU3lZZEZOUWtHU0srWEM1?=
 =?utf-8?B?K0FZTXM0ZHpDdSt6WmlNeDFkNnZMOVdxajNYV05YdkJWN1R2dVJ0bmt3YjR2?=
 =?utf-8?B?UlpmMWlBVjRTanVqcndReXIvVy8zWkZUWHJpd013bXZRZFlqcjNva2ZOaGJt?=
 =?utf-8?B?MWVINjZIVUp0VEFUL0g2UHNERHg5TGlBQ0N3bUJZbnQ4ZURwOFBOYVNwYU1K?=
 =?utf-8?B?RGp0dXVTN0I1L0UwVHVKdUlYc25LSld3Szg3TEM2dWc0ZUZwckdGTHJkTGRD?=
 =?utf-8?B?K2tZME9qZ3FhYlBvcks1aWV5TUZCbVJXcjdYWi9SZkFVQ3R3dU5NZHZlNktX?=
 =?utf-8?B?eU5PRlRzbVJwM3VhZWl0NVpZbGgyeXhOSW1COWZ1eTlwT05zRngraSs5K3N1?=
 =?utf-8?B?Z0VTYnVOMGkza0kydUN3empRclJ0NHlDK1hHYnJMaU50SG5WTS9jOXkwNGpx?=
 =?utf-8?B?dit1cHVWYmo2aGs2a3R0M0k3NXpFVXJDNkxZV2NCMEFCWk1RbWU5Y05ZcWpC?=
 =?utf-8?B?ejhhTktvdmVOcHRCbktPSTFuS3Ntb3FLdC93U0h5VFk2U2tOWHNWSEFxVG5D?=
 =?utf-8?B?bUd3VGkwMGhxWjhpOEp0Y3hhZ0o3b21rVzFRM1lxZHkrbkNhOGpHUW9oWS9q?=
 =?utf-8?B?c0IyOG5oYk9QZ1FGRXdqenAyZGtNZXFudEVFSDI4YnZxWmdQS0JLWVpncXlY?=
 =?utf-8?Q?Rdwz/eU2b+vOYZdQzLPYMryxC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f076f8a9-801f-41ec-4e34-08daf85d399a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 07:34:10.8095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmnsDeP4nqaYzWzYTx4y+ITqLwb2PouAslsTK1GmGiJtuC8nYNMOt4JisiP0elOjtzp/l4d0tunr9XomTmfpug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4550
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUdWUsIEphbiAxNywgMjAyMyBhdCAxMDoxOTo1NUFNICswODAwLCBacWlhbmcgd3JvdGU6
DQo+IFdoZW4gaW5vdmtlIHJjdV9yZXBvcnRfcXNfcmRwKCksIGlmIGN1cnJlbnQgQ1BVJ3MgcmN1
X2RhdGEgc3RydWN0dXJlJ3MgLT4NCj4gZ3JwbWFzayBoYXMgbm90IGJlZW4gY2xlYXJlZCBmcm9t
IHRoZSBjb3JyZXNwb25kaW5nIHJjdV9ub2RlIHN0cnVjdHVyZSdzDQo+IC0+cXNtYXNrLCBhZnRl
ciB0aGF0IHdpbGwgY2xlYXIgYW5kIHJlcG9ydCBxdWllc2NlbnQgc3RhdGUsIGJ1dCBpbiB0aGlz
DQo+IHRpbWUsIHRoaXMgYWxzbyBtZWFucyB0aGF0IGN1cnJlbnQgZ3JhY2UgcGVyaW9kIGlzIG5v
dCBlbmQsIHRoZSBjdXJyZW50DQo+IGdyYWNlIHBlcmlvZCBpcyBvbmdvaW5nLCBiZWNhdXNlIHRo
ZSByY3VfZ3BfaW5fcHJvZ3Jlc3MoKSBjdXJyZW50bHkgcmV0dXJuDQo+IHRydWUsIHNvIGZvciBu
b24tb2ZmbG9hZGVkIHJkcCwgaW52b2tlIHJjdV9hY2NlbGVyYXRlX2NicygpIGlzIGltcG9zc2li
bGUNCj4gdG8gcmV0dXJuIHRydWUuDQo+IA0KPiBUaGlzIGNvbW1pdCB0aGVyZWZvcmUgcmVtb3Zl
IGltcG9zc2libGUgcmN1X2dwX2t0aHJlYWRfd2FrZSgpIGNhbGxpbmcuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRlbC5jb20+DQo+IC0tLQ0KPiAga2VybmVs
L3JjdS90cmVlLmMgfCA1ICstLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90cmVlLmMgYi9r
ZXJuZWwvcmN1L3RyZWUuYw0KPiBpbmRleCBiMmMyMDQ1Mjk0NzguLjQ3N2ViMWEzNzRlNSAxMDA2
NDQNCj4gLS0tIGEva2VybmVsL3JjdS90cmVlLmMNCj4gKysrIGIva2VybmVsL3JjdS90cmVlLmMN
Cj4gQEAgLTE5NTYsNyArMTk1Niw2IEBAIHJjdV9yZXBvcnRfcXNfcmRwKHN0cnVjdCByY3VfZGF0
YSAqcmRwKQ0KPiAgew0KPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICAJdW5zaWduZWQgbG9u
ZyBtYXNrOw0KPiAtCWJvb2wgbmVlZHdha2UgPSBmYWxzZTsNCj4gIAlib29sIG5lZWRhY2MgPSBm
YWxzZTsNCj4gIAlzdHJ1Y3QgcmN1X25vZGUgKnJucDsNCj4gIA0KPiBAQCAtMTk4OCw3ICsxOTg3
LDcgQEAgcmN1X3JlcG9ydF9xc19yZHAoc3RydWN0IHJjdV9kYXRhICpyZHApDQo+ICAJCSAqIE5P
Q0Iga3RocmVhZHMgaGF2ZSB0aGVpciBvd24gd2F5IHRvIGRlYWwgd2l0aCB0aGF0Li4uDQo+ICAJ
CSAqLw0KPiAgCQlpZiAoIXJjdV9yZHBfaXNfb2ZmbG9hZGVkKHJkcCkpIHsNCj4gLQkJCW5lZWR3
YWtlID0gcmN1X2FjY2VsZXJhdGVfY2JzKHJucCwgcmRwKTsNCj4gKwkJCXJjdV9hY2NlbGVyYXRl
X2NicyhybnAsIHJkcCk7DQo+DQo+SWYgaXQgaXMgaW1wb3NzaWJsZSwgd2Ugc2hvdWxkIHVzZSBX
QVJOX09OX09OQ0UoKSBvciBzaW1pbGFyLiAgSnVzdA0KPmluIGNhc2UgdGhlIHN5c3RlbSBkaXNh
Z3JlZXMgb24gdGhlIGltcG9zc2liaWxpdHkuICA7LSkNCg0KVGhhbmtzIGZvciBzdWdnZXN0aW9u
LCBJIHdpbGwgcmVzZW5kIHYyIPCfmIouDQoNCj4NCj4JCQkJCQkJVGhhbngsIFBhdWwNCg0KPiAg
CQl9IGVsc2UgaWYgKCFyY3Vfc2VnY2JsaXN0X2NvbXBsZXRlbHlfb2ZmbG9hZGVkKCZyZHAtPmNi
bGlzdCkpIHsNCj4gIAkJCS8qDQo+ICAJCQkgKiAuLi5idXQgTk9DQiBrdGhyZWFkcyBtYXkgbWlz
cyBvciBkZWxheSBjYWxsYmFja3MgYWNjZWxlcmF0aW9uDQo+IEBAIC0yMDAwLDggKzE5OTksNiBA
QCByY3VfcmVwb3J0X3FzX3JkcChzdHJ1Y3QgcmN1X2RhdGEgKnJkcCkNCj4gIAkJcmN1X2Rpc2Fi
bGVfdXJnZW5jeV91cG9uX3FzKHJkcCk7DQo+ICAJCXJjdV9yZXBvcnRfcXNfcm5wKG1hc2ssIHJu
cCwgcm5wLT5ncF9zZXEsIGZsYWdzKTsNCj4gIAkJLyogXl5eIFJlbGVhc2VkIHJucC0+bG9jayAq
Lw0KPiAtCQlpZiAobmVlZHdha2UpDQo+IC0JCQlyY3VfZ3Bfa3RocmVhZF93YWtlKCk7DQo+ICAN
Cj4gIAkJaWYgKG5lZWRhY2MpIHsNCj4gIAkJCXJjdV9ub2NiX2xvY2tfaXJxc2F2ZShyZHAsIGZs
YWdzKTsNCj4gLS0gDQo+IDIuMjUuMQ0KPiANCg==
