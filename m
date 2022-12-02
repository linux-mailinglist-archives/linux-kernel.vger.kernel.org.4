Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F7464072E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiLBMwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiLBMwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:52:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2300ADC879;
        Fri,  2 Dec 2022 04:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669985521; x=1701521521;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AsgfoTMYd+bf11MMROIsAXaDMlSTb2OEa43l+JSsN4c=;
  b=XvtYtmn1BKuAtoIUbOR4bfR2gHxs8HdayK0/wdL/0K+3PtrjsZVeehFd
   P9j/ydGWIPX7kt5fwWY7CBJEkipb6/gMq81o6eoug2olXzyfpIjnb/wIK
   izivKEUau92qhl8KEVzdLHxU10C/bmGBHQypctpic7Yj0P2fr7Jvga2ha
   MgkCelOfIOtpxVxjmJN6eM6YdKoYEaEWV0QC0XgFSxgBdc6KnqDm97Vlo
   XIcLVdWC+Uirn6S2Db9oqmcHCYqpYEu42cTXp8xB2fgBgYrywRbqO0BiF
   559hfx6j7pz8t2TWpCWMShLR44mwxWvXWOcsoXszt8DKSLt4vHaaXzKLj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="380235200"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="380235200"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 04:51:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="787277334"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="787277334"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 02 Dec 2022 04:51:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 04:51:58 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 04:51:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 04:51:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw6fQdb11NpanLfJX1J3cblW4Y0b7SAjWwijE5MSHM4HHBWqY46PpFBVpMF+6No3eCTLIlC2+0b96Bgc+jH60msf/62CQEbPTNw5yjiiQXk43uhqh7cEwiWUxqS4O6pYHC4zr6e5oQHIUBDLgG0K+NJHW2alby/zux+qi2NNpUxprH1WgY+Fbx4pxgZ3/W5Ei+iIXqH/dT0iR6MH4mm4kXVNqcPuQVefVfFfFsDydv8RnsUIxEBmRmnICeW4uvCO/Guc0VeyI3u9AZyK/iHfC38QVrsrwzs2sviV4bB4qkIx5VFk5YLEu3vtBd588SW2L0qi1Whz5jovkAmOC9uc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsgfoTMYd+bf11MMROIsAXaDMlSTb2OEa43l+JSsN4c=;
 b=Vf4uGX8iuKhlVKroB/lodKtl4BbAbIZl0DKTZx2q6HQs4INPEflvxbzuP5f6RCaKCKYbbkjOGxOtCNcaX3/c+bno5sZoerMIrhpX28r+K7liiaN75RlGYbH4JMMcJxKD2ipX8t1O9ATHa6021r41Uz6em07XCMlY4tqscsxrLh9iQaXuFLcdKBzbEDDo/adoZHWEWOqmkXmK8wZZs37XCGYvUTb+XWU9+SsIHI8jcs4Sx46/WbnSO1XMqF2s3LFlWfKU+bFegNt6D1oPGKNZpPOsNv/NqdXOfV0bcxONfkkXkIQa0D8+iH8Uf2BI0p8PiwmUHI6N5N2RK8uYqNa5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM4PR11MB5392.namprd11.prod.outlook.com (2603:10b6:5:397::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 12:51:57 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%4]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 12:51:57 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Topic: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Index: AQHZBRUNYM7gGe8KaECV+8uqpx3Q8a5YKTWAgAJj63A=
Date:   Fri, 2 Dec 2022 12:51:56 +0000
Message-ID: <PH0PR11MB58800E4DF4BF0B60FBFC71E2DA179@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221130234533.1983769-1-qiang1.zhang@intel.com>
 <20221201001307.GF4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221201001307.GF4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DM4PR11MB5392:EE_
x-ms-office365-filtering-correlation-id: 7882eff3-7624-414d-853c-08dad463fee8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VK4IY+p8H+En52oldM4AeF/5f8IF3myQjsDllI9cGRW8xwxugHLcrzSNFEhRRQFqTCyhXmLtrqbnxU1PxKVSqSok9G4tG1x1g5PnQS308703svRzXUsGK8By61+bjT0225cPRPTxq91NxSKnSwU5LS0Ixoe1gOwLpJ7CZm0mbIoK8dFF//CGpyZGVx/XzrL32OKNTPcWS/hRG1F49iKNJxYi8mm7KPSgDqA64D3s6RGZtR8M6jCQ6UKUOaW5fWvxxhyI7kqw5DprfkIBR0JJpQo9sMYdPzaoGiOZDZf44kSj/bsEUmTcCVSepKjJCUcOFULkCFNpiS4zCDVXwI9T9N0BONOjJzVX4kyR3/MRfEoOMdktbBG/qGCbMEHC2HmShuBWcNM8hlVX2UH9Wj8sIlLRHOf3/R3pxs2JdEpGf80xaRVoqFkyitByv9kby7MDrRQOrDl+hcQ2rE9s6QvDMa7uPtFzYKxxb1IwXVyueHxyMPDJS3hsDyCn5Z7Ekmdeghf44e79USAhvugzQtwfB7Wh5CGXGwCwgfXOVXMahOG2Wv8u6jHPn7SbGYlUDsd6D1t2FGuY1xpO3B4RZ3jBOKnwVQJwxY8sMdA/SyKHuI839wGc/cjeHEaMeRakQmr0RtwsfEFmldgWViX4KdIGEUpEWqctWE/Suu0OBLUZkkKEPUTRkcDwXwJLQGf2GH+d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(5660300002)(8936002)(66946007)(41300700001)(76116006)(55016003)(4326008)(52536014)(8676002)(64756008)(66446008)(66476007)(66556008)(2906002)(38070700005)(316002)(54906003)(6916009)(33656002)(186003)(83380400001)(478600001)(86362001)(71200400001)(9686003)(26005)(82960400001)(38100700002)(6506007)(7696005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0E5cituOEU1QVVyYnc5blBHRDVPQkpVWjhsblAyWVdVOHNOL2JScEtuOHJq?=
 =?utf-8?B?ZUJqY0ROVU8wYW81TGFTU1A2QTN6QVBSMFpzWG5YQ2xpemo0dzNEb1hSMHFM?=
 =?utf-8?B?MlloZ1BOUUNrL0VBSFNVdVNaOTd2T2JYT1lSSzg3b0FEVE9kcjRjanlkbGZj?=
 =?utf-8?B?cjFBTHlvczY2Y0VwVExHZS9xSHFmbUNOK0FSWjFtWVMrTFo4cmVvOUZSZ1Ix?=
 =?utf-8?B?M2Q1RWw1akNDem1kZEUvZ0IrQ2xLMzM4ODFaaDZCN01BNnEzaGtjQ3NJQXN0?=
 =?utf-8?B?cXEwbE03NlhNbU1wTlc2bTFTZm9aTHlJU1YzS1M5TjJuNEhKRkdmd01UWE1z?=
 =?utf-8?B?dmRyVlVTVG1FMUorUzZWV21XT2l2bFc5QUk5RXhuSnVXQlI2VEdkZ1hkNGQ0?=
 =?utf-8?B?Z2JsL2NodmtzdWVIOGJRb0JrOGlBNURPWkZzVWRHN3h4eFZDTkxZUmtGSklx?=
 =?utf-8?B?S3NQZTA5OHhIQ3pjNHRXQlZxVDRJaWt3ZE81emVpMHRLODIwSno4VkYrU0pj?=
 =?utf-8?B?L3hhMFpRdDJPNVFYN2tsVVljZ04vaEdzTnBoVGtTR202Tlp2dG9Hd1JndUhL?=
 =?utf-8?B?WW5tQ0dnVm5wYkpZUU44QTYzbkN0cURVUEZYb1M4b1RFUWNxK0tjYmI0Skw3?=
 =?utf-8?B?MXkyMjBnbFJkQ2hEMHN0NWJVNy9TUVh6dkJsSnY2NDdTRndzb293QVJXMlZM?=
 =?utf-8?B?WnA2bmc4cGhhS0pIb3dxcGlRVm5yNk5UdGQ5cVNIaERqZCtQYnU4U1JRZGtF?=
 =?utf-8?B?b0dSQVlZaGh4NEhXWFc5OGNCRmRqdDNkdFNpUXUyVHVCclpmRE9kWHh2WEJD?=
 =?utf-8?B?QTdqMEkyMXBicUxaUkQxRENZNlVKRHAwV1VyOWJtL25iQytsWWhtTFNNbEFB?=
 =?utf-8?B?UmRKZ2svWUY4MWhSSDEzWEo5dGVGbytZVUJ2d3V4c3dtRzUwK3JnYURVWHRW?=
 =?utf-8?B?aFNjNUlPb1ZWQzNiT3VzcmVKREo3QS9LMmxTM2Z2QWpKYk1OTXRMYUh4UzFE?=
 =?utf-8?B?VGhaQUZmd0EvKzB1cituaWN0ZEtlb3VNR3JhZ0U5K3g4ZEQ4dGE2aVRCV29O?=
 =?utf-8?B?RDNGNnJnUm54U1JFa2U1YmhNeDYyUFRwTURwVXYvVlZYTURrbjlRRlBjTk1n?=
 =?utf-8?B?SU9FelBjTDhmVEpKU2I5SktSTjlmN3pEbXRMUGxuLzdxSE9UM1JKT1ZiTEZQ?=
 =?utf-8?B?Z3BDUjFIU2kydTA5Z2VCdGxjV3hmNDV6UG1zeG5wT3lkQVFXUmQ4ZUNKSThM?=
 =?utf-8?B?L0tLamJyOHJYUm0xUmVnc0d2RUtrYWdqZXVueWMzY2NPOG81UmxNMjBqamF5?=
 =?utf-8?B?VlBLcFZ1M05VVHJPMEM2VTc0dzlsa2xIYW93cUQyT1ROcnVxVEVnb2h3VVhv?=
 =?utf-8?B?R3cvYStwOU00eW8wTGRGelVIWExBOHhTVUFnc1F1NG1MeWg2TEc2b3lOcUVT?=
 =?utf-8?B?cm9Galk0M2JQMmFrU0JKbndJbWxWQ3hvQzlSVjRSaVBCaWJyZm1mYTBOT3dY?=
 =?utf-8?B?K2FCNmNiTExBQTV2RGlBRTQyUzU2dkp3UTdVc3hrekpmNnRaZ3ZBUG9HT0Nt?=
 =?utf-8?B?VzdjUzEzUCtZYUd6T1IwTXBUdmkxUkxrUGZIa2lFczE3cEN0bDR1YUVJOHhP?=
 =?utf-8?B?T2JjM1prMXMwb0d6OVgyN2ZwaTU3blVaWHRkVkhHUUZvYk1pam00Mm1SRGNl?=
 =?utf-8?B?QWwxemNHQzlTQ1BzVmdEMHZWayt0Y1VSSmNmanNBRmd2U0JJZkRXc29oWWov?=
 =?utf-8?B?U1JGUVhNWFQ5d0lzc0RScXUrWWs2TXJ0MTlOTnFSQThTSlJYR0JNRW5iSlZM?=
 =?utf-8?B?dFk3ZWkxUVJLOGF1SDhhSzZSMjRPQjc1S3JBT2RDVHlDQk51NGU2SWk2MWRG?=
 =?utf-8?B?SitzT3NhVEZGQmR2TlBoWDNvSTZRbGVvQ0c3TGFQbFhRYVg5UmlOdXY3bzFJ?=
 =?utf-8?B?SDBkWHdnWWhMb1FBK1A2Q0NUaml1MVFYQ1BZMU1vQjZrK3NOYnRCMU5NWjRL?=
 =?utf-8?B?UFJuVDVuemlaOTZrM3dPK0Nqb3NsMDFwa2U0WU90bzJkMWRYaGhTdkJKZTJ2?=
 =?utf-8?B?V1o3bUp5ZFBLbUk5TXNmQm9UbFY3U3B0S2RjelhSbG9HYmtDMWpORXVXV0t1?=
 =?utf-8?Q?csKr8S8Zvgv33Rm1kNvc3DGBk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7882eff3-7624-414d-853c-08dad463fee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 12:51:56.9692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3z7xCtiiwHXlpikXblK0ROdSgGNsxL/Nn0cbLEBSIz9ThNKtGx2PCxw9BhbP12v5SrXQhBqIP45sp7lDOKo2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5392
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBEZWMgMDEsIDIwMjIgYXQgMDc6NDU6MzNBTSArMDgwMCwgWnFpYW5nIHdyb3RlOg0K
PiBDdXJyZW50bHksIGludm9rZSByY3VfdGFza3NfcnVkZV93YWl0X2dwKCkgdG8gd2FpdCBvbmUg
cnVkZQ0KPiBSQ1UtdGFza3MgZ3JhY2UgcGVyaW9kLCBpZiBfX251bV9vbmxpbmVfY3B1cyA9PSAx
LCB3aWxsIHJldHVybg0KPiBkaXJlY3RseSwgaW5kaWNhdGVzIHRoZSBlbmQgb2YgdGhlIHJ1ZGUg
UkNVLXRhc2sgZ3JhY2UgcGVyaW9kLg0KPiBzdXBwb3NlIHRoZSBzeXN0ZW0gaGFzIHR3byBjcHVz
LCBjb25zaWRlciB0aGUgZm9sbG93aW5nIHNjZW5hcmlvOg0KPiANCj4gICAgICAgICBDUFUwICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUxIChnb2luZyBvZmZsaW5lKQ0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtaWdyYXRpb24vMSB0YXNr
Og0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNwdV9zdG9wcGVyX3Ro
cmVhZA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtPiB0YWtlX2Nw
dV9kb3duDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0+IF9j
cHVfZGlzYWJsZQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KGRlYyBfX251bV9vbmxpbmVfY3B1cykNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLT5jcHVocF9pbnZva2VfY2FsbGJhY2sNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJlZW1wdF9kaXNhYmxlDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFjY2VzcyBvbGRfZGF0YTAN
Cj4gICAgICAgICAgICB0YXNrMQ0KPiAgZGVsIG9sZF9kYXRhMCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAuLi4uLg0KPiAgc3luY2hyb25pemVfcmN1X3Rhc2tzX3J1ZGUoKQ0KPiAg
dGFzazEgc2NoZWR1bGUgb3V0DQo+ICAuLi4uDQo+ICB0YXNrMiBzY2hlZHVsZSBpbg0KPiAgcmN1
X3Rhc2tzX3J1ZGVfd2FpdF9ncCgpDQo+ICAgICAgLT5fX251bV9vbmxpbmVfY3B1cyA9PSAxDQo+
ICAgICAgICAtPnJldHVybg0KPiAgLi4uLg0KPiAgdGFzazEgc2NoZWR1bGUgaW4NCj4gIC0+ZnJl
ZSBvbGRfZGF0YTANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcHJlZW1wdF9lbmFibGUNCj4gDQo+IHdoZW4gQ1BVMSBkZWMgX19udW1fb25saW5lX2Nw
dXMgYW5kIF9fbnVtX29ubGluZV9jcHVzIGlzIGVxdWFsIG9uZSwNCj4gdGhlIENQVTEgaGFzIG5v
dCBmaW5pc2hlZCBvZmZsaW5lLCBzdG9wX21hY2hpbmUgdGFzayhtaWdyYXRpb24vMSkNCj4gc3Rp
bGwgcnVubmluZyBvbiBDUFUxLCBtYXliZSBzdGlsbCBhY2Nlc3NpbmcgJ29sZF9kYXRhMCcsIGJ1
dCB0aGUNCj4gJ29sZF9kYXRhMCcgaGFzIGZyZWVkIG9uIENQVTAuDQo+IA0KPiBJbiBvcmRlciB0
byBwcmV2ZW50IHRoZSBhYm92ZSBzY2VuYXJpbyBmcm9tIGhhcHBlbmluZywgdGhpcyBjb21taXQN
Cj4gcmVtb3ZlIGNoZWNrIGZvciBfX251bV9vbmxpbmVfY3B1cyA9PSAwIGFuZCBhZGQgaGFuZGxp
bmcgb2YgY2FsbGluZw0KPiBzeW5jaHJvbml6ZV9yY3VfdGFza3NfZ2VuZXJpYygpIGR1cmluZyBl
YXJseSBib290KHdoZW4gdGhlDQo+IHJjdV9zY2hlZHVsZXJfYWN0aXZlIHZhcmlhYmxlIGlzIFJD
VV9TQ0hFRFVMRVJfSU5BQ1RJVkUsIHRoZSBzY2hlZHVsZXINCj4gbm90IHlldCBpbml0aWFsaXpl
ZCBhbmQgb25seSBvbmUgYm9vdC1DUFUgb25saW5lKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFpx
aWFuZyA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCg0KPlZlcnkgZ29vZCwgdGhhbmsgeW91ISAg
SSBkaWQgdGhlIHVzdWFsIHdvcmRzbWl0aGluZywgaW5jbHVkaW5nIHRvIHRoYXQNCj5lcnJvciBt
ZXNzYWdlLCBzbyBhcyB1c3VhbCBwbGVhc2UgY2hlY2sgdG8gbWFrZSBzdXJlIHRoYXQgSSBkaWRu
J3QgbWVzcw0KPnNvbWV0aGluZyB1cC4NCj4NCj4JCQkJCQkJVGhhbngsIFBhdWwNCj4NCj4tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4NCj5jb21taXQgMDMzZGRjNWQzMzc5ODRlMjBiOWQ0OWM4YWY0ZmFhNDY4
OTcyNzYyNg0KPkF1dGhvcjogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPkRhdGU6
ICAgVGh1IERlYyAxIDA3OjQ1OjMzIDIwMjIgKzA4MDANCj4NCj4gICAgcmN1LXRhc2tzOiBNYWtl
IHJ1ZGUgUkNVLVRhc2tzIHdvcmsgd2VsbCB3aXRoIENQVSBob3RwbHVnDQo+ICAgIA0KPiAgICBU
aGUgc3luY2hyb25pemVfcmN1X3Rhc2tzX3J1ZGUoKSBmdW5jdGlvbiBpbnZva2VzIHJjdV90YXNr
c19ydWRlX3dhaXRfZ3AoKQ0KPiAgICB0byB3YWl0IG9uZSBydWRlIFJDVS10YXNrcyBncmFjZSBw
ZXJpb2QuICBUaGUgcmN1X3Rhc2tzX3J1ZGVfd2FpdF9ncCgpDQo+ICAgIGZ1bmN0aW9uIGluIHR1
cm4gY2hlY2tzIGlmIHRoZXJlIGlzIG9ubHkgYSBzaW5nbGUgb25saW5lIENQVS4gIElmIHNvLCBp
dA0KPiAgICB3aWxsIGltbWVkaWF0ZWx5IHJldHVybiwgYmVjYXVzZSBhIGNhbGwgdG8gc3luY2hy
b25pemVfcmN1X3Rhc2tzX3J1ZGUoKQ0KPiAgICBpcyBieSBkZWZpbml0aW9uIGEgZ3JhY2UgcGVy
aW9kIG9uIGEgc2luZ2xlLUNQVSBzeXN0ZW0uICAoV2UgY291bGQNCj4gICAgaGF2ZSBibG9ja2Vk
ISkNCj4gICAgDQo+ICAgIFVuZm9ydHVuYXRlbHksIHRoaXMgY2hlY2sgdXNlcyBudW1fb25saW5l
X2NwdXMoKSB3aXRob3V0IHN5bmNocm9uaXphdGlvbiwNCj4gICAgd2hpY2ggY2FuIHJlc3VsdCBp
biB0b28tc2hvcnQgZ3JhY2UgcGVyaW9kcy4gIFRvIHNlZSB0aGlzLCBjb25zaWRlciB0aGUNCj4g
ICAgZm9sbG93aW5nIHNjZW5hcmlvOg0KPiAgICANCj4gICAgICAgICAgICBDUFUwICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUxIChnb2luZyBvZmZsaW5lKQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtaWdyYXRpb24vMSB0YXNrOg0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNwdV9zdG9wcGVyX3Ro
cmVhZA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtPiB0YWtl
X2NwdV9kb3duDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC0+IF9jcHVfZGlzYWJsZQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKGRlYyBfX251bV9vbmxpbmVfY3B1cykNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAtPmNwdWhwX2ludm9rZV9jYWxsYmFjaw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcmVlbXB0X2Rpc2Fi
bGUNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
YWNjZXNzIG9sZF9kYXRhMA0KPiAgICAgICAgICAgICAgIHRhc2sxDQo+ICAgICBkZWwgb2xkX2Rh
dGEwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLi4uDQo+ICAgICBzeW5jaHJv
bml6ZV9yY3VfdGFza3NfcnVkZSgpDQo+ICAgICB0YXNrMSBzY2hlZHVsZSBvdXQNCj4gICAgIC4u
Li4NCj4gICAgIHRhc2syIHNjaGVkdWxlIGluDQo+ICAgICByY3VfdGFza3NfcnVkZV93YWl0X2dw
KCkNCj4gICAgICAgICAtPl9fbnVtX29ubGluZV9jcHVzID09IDENCj4gICAgICAgICAgIC0+cmV0
dXJuDQo+ICAgICAuLi4uDQo+ICAgICB0YXNrMSBzY2hlZHVsZSBpbg0KPiAgICAgLT5mcmVlIG9s
ZF9kYXRhMA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBwcmVlbXB0X2VuYWJsZQ0KPiAgICANCj4gICAgV2hlbiBDUFUxIGRlY3JlbWVudHMgX19u
dW1fb25saW5lX2NwdXMsIGl0cyB2YWx1ZSBiZWNvbWVzIDEuICBIb3dldmVyLA0KPiAgICBDUFUx
IGhhcyBub3QgZmluaXNoZWQgZ29pbmcgb2ZmbGluZSwgYW5kIHdpbGwgdGFrZSBvbmUgbGFzdCB0
cmlwIHRocm91Z2gNCj4gICAgdGhlIHNjaGVkdWxlciBhbmQgdGhlIGlkbGUgbG9vcCBiZWZvcmUg
aXQgYWN0dWFsbHkgc3RvcHMgZXhlY3V0aW5nDQo+ICAgIGluc3RydWN0aW9ucy4gIEJlY2F1c2Ug
c3luY2hyb25pemVfcmN1X3Rhc2tzX3J1ZGUoKSBpcyBtb3N0bHkgdXNlZCBmb3INCj4gICAgdHJh
Y2luZywgYW5kIGJlY2F1c2UgYm90aCB0aGUgc2NoZWR1bGVyIGFuZCB0aGUgaWRsZSBsb29wIGNh
biBiZSB0cmFjZWQsDQo+ICAgIHRoaXMgbWVhbnMgdGhhdCBDUFUwJ3MgcHJlbWF0dXJlbHkgZW5k
ZWQgZ3JhY2UgcGVyaW9kIG1pZ2h0IGRpc3J1cHQgdGhlDQo+ICAgIHRyYWNpbmcgb24gQ1BVMS4g
IEdpdmVuIHRoYXQgdGhpcyBkaXNydXB0aW9uIG1pZ2h0IGluY2x1ZGUgQ1BVMSBleGVjdXRpbmcN
Cj4gICAgaW5zdHJ1Y3Rpb25zIGluIG1lbW9yeSB0aGF0IHdhcyBqdXN0IG5vdyBmcmVlZCAoYW5k
IG1heWJlIHJlYWxsb2NhdGVkKSwNCj4gICAgdGhpcyBpcyBhIG1hdHRlciBvZiBzb21lIGNvbmNl
cm4uDQo+ICAgIA0KPiAgICBUaGlzIGNvbW1pdCB0aGVyZWZvcmUgcmVtb3ZlcyB0aGF0IHByb2Js
ZW1hdGljIHNpbmdsZS1DUFUgY2hlY2sgZnJvbSB0aGUNCj4gICAgcmN1X3Rhc2tzX3J1ZGVfd2Fp
dF9ncCgpIGZ1bmN0aW9uLiAgVGhpcyBkaXNwZW5zZXMgd2l0aCB0aGUgc2luZ2xlLUNQVQ0KPiAg
ICBvcHRpbWl6YXRpb24sIGJ1dCB0aGVyZSBpcyBubyBldmlkZW5jZSBpbmRpY2F0aW5nIHRoYXQg
dGhpcyBvcHRpbWl6YXRpb24NCj4gICAgaXMgaW1wb3J0YW50LiAgSW4gYWRkaXRpb24sIHN5bmNo
cm9uaXplX3JjdV90YXNrc19nZW5lcmljKCkgY29udGFpbnMgYQ0KPiAgICBzaW1pbGFyIG9wdGlt
aXphdGlvbiAoYWxiZWl0IG9ubHkgZm9yIGVhcmx5IGJvb3QpLCB3aGljaCBhbHNvIHNwbGF0cy4N
Cj4gICAgKEFzIGluIGV4YWN0bHkgd2h5IGFyZSB5b3UgaW52b2tpbmcgc3luY2hyb25pemVfcmN1
X3Rhc2tzX3J1ZGUoKSBzbw0KPiAgICBlYXJseSBpbiBib290LCBhbnl3YXk/Pz8pDQo+ICAgIA0K
PiAgICBJdCBpcyBPSyBmb3IgdGhlIHN5bmNocm9uaXplX3JjdV90YXNrc19ydWRlKCkgZnVuY3Rp
b24ncyBjaGVjayB0byBiZQ0KPiAgICB1bnN5bmNocm9uaXplZCBiZWNhdXNlIHRoZSBvbmx5IHRp
bWVzIHRoYXQgdGhpcyBjaGVjayBjYW4gZXZhbHVhdGUgdG8NCj4gICAgdHJ1ZSBpcyB3aGVuIHRo
ZXJlIGlzIG9ubHkgYSBzaW5nbGUgQ1BVIHJ1bm5pbmcgd2l0aCBwcmVlbXB0aW9uDQo+ICAgIGRp
c2FibGVkLg0KPiAgICANCj4gICAgV2hpbGUgaW4gdGhlIGFyZWEsIHRoaXMgY29tbWl0IGFsc28g
Zml4ZXMgYSBtaW5vciBidWcgaW4gd2hpY2ggYQ0KPiAgICBjYWxsIHRvIHN5bmNocm9uaXplX3Jj
dV90YXNrc19ydWRlKCkgd291bGQgaW5zdGVhZCBiZSBhdHRyaWJ1dGVkIHRvDQo+ICAgIHN5bmNo
cm9uaXplX3JjdV90YXNrcygpLg0KPiAgICANCj4gICAgWyBwYXVsbWNrOiBBZGQgInN5bmNocm9u
aXplXyIgcHJlZml4IGFuZCAiKCkiIHN1ZmZpeC4gXQ0KPiAgICANCj4gICAgU2lnbmVkLW9mZi1i
eTogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPiAgICBTaWduZWQtb2ZmLWJ5OiBQ
YXVsIEUuIE1jS2VubmV5IDxwYXVsbWNrQGtlcm5lbC5vcmc+DQo+DQo+ZGlmZiAtLWdpdCBhL2tl
cm5lbC9yY3UvdGFza3MuaCBiL2tlcm5lbC9yY3UvdGFza3MuaA0KPmluZGV4IDRkZGE4ZTZlNTcw
N2YuLmQ4NDU3MjNjMWFmNDEgMTAwNjQ0DQo+LS0tIGEva2VybmVsL3JjdS90YXNrcy5oDQo+Kysr
IGIva2VybmVsL3JjdS90YXNrcy5oDQo+QEAgLTU2MCw4ICs1NjAsOSBAQCBzdGF0aWMgaW50IF9f
bm9yZXR1cm4gcmN1X3Rhc2tzX2t0aHJlYWQodm9pZCAqYXJnKQ0KPiBzdGF0aWMgdm9pZCBzeW5j
aHJvbml6ZV9yY3VfdGFza3NfZ2VuZXJpYyhzdHJ1Y3QgcmN1X3Rhc2tzICpydHApDQo+IHsNCj4g
CS8qIENvbXBsYWluIGlmIHRoZSBzY2hlZHVsZXIgaGFzIG5vdCBzdGFydGVkLiAgKi8NCj4tCVdB
Uk5fT05DRShyY3Vfc2NoZWR1bGVyX2FjdGl2ZSA9PSBSQ1VfU0NIRURVTEVSX0lOQUNUSVZFLA0K
Pi0JCQkgInN5bmNocm9uaXplX3JjdV90YXNrcyBjYWxsZWQgdG9vIHNvb24iKTsNCj4rCWlmIChX
QVJOX09OQ0UocmN1X3NjaGVkdWxlcl9hY3RpdmUgPT0gUkNVX1NDSEVEVUxFUl9JTkFDVElWRSwN
Cj4rCQkJICJzeW5jaHJvbml6ZV8lcygpIGNhbGxlZCB0b28gc29vbiIsIHJ0cC0+bmFtZSkpDQoN
ClRoYW5rcyBQYXVsLCAgZGV0YWlsZWQgZGVzY3JpcHRpb24gYW5kIG1vZGlmaWNhdGlvbiDwn5iK
Lg0KDQoNCj4rCQlyZXR1cm47DQo+IA0KPiAJLy8gSWYgdGhlIGdyYWNlLXBlcmlvZCBrdGhyZWFk
IGlzIHJ1bm5pbmcsIHVzZSBpdC4NCj4gCWlmIChSRUFEX09OQ0UocnRwLT5rdGhyZWFkX3B0cikp
IHsNCj5AQCAtMTA2NCw5ICsxMDY1LDYgQEAgc3RhdGljIHZvaWQgcmN1X3Rhc2tzX2JlX3J1ZGUo
c3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAvLyBXYWl0IGZvciBvbmUgcnVkZSBSQ1UtdGFz
a3MgZ3JhY2UgcGVyaW9kLg0KPiBzdGF0aWMgdm9pZCByY3VfdGFza3NfcnVkZV93YWl0X2dwKHN0
cnVjdCByY3VfdGFza3MgKnJ0cCkNCj4gew0KPi0JaWYgKG51bV9vbmxpbmVfY3B1cygpIDw9IDEp
DQo+LQkJcmV0dXJuOwkvLyBGYXN0cGF0aCBmb3Igb25seSBvbmUgQ1BVLg0KPi0NCj4gCXJ0cC0+
bl9pcGlzICs9IGNwdW1hc2tfd2VpZ2h0KGNwdV9vbmxpbmVfbWFzayk7DQo+IAlzY2hlZHVsZV9v
bl9lYWNoX2NwdShyY3VfdGFza3NfYmVfcnVkZSk7DQo+IH0NCg==
