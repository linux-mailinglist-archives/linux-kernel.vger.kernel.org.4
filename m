Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D6F6BE62B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCQKFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCQKFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:05:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4F960AAA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 03:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679047503; x=1710583503;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tecGkS9lXObG4EC8NihC6Wq5ESdUZLN5oLDHnieY/tc=;
  b=RQrIJxrurJP8y8Fp7eVdxr9IrMHigoQfVH2b5VblMGqTMzcMv62nEdeb
   qt6VcKEdl2Hd0efNNmYE+5j93hJ1338Efuh96hup778qa7HEogxWeVqQy
   +fL01gLTfOLJ0Hkl8Sc4GYqLl5otj0k+r3ANlJQp3MHYh2bH9Mak1PvNE
   BijcscNoqj312pVWi9BM6s7kVwaB+xKdFahL7FBwKGsCIT5JmMmLcYytE
   KVc1e2EvDT/cZ3QPiioh0L7kK19VGJupgsS/6Kn5QGLGMgmSo36wh9E38
   PYzQXuSg4ywnBfaSmlQddDMgEv3nklnPj1ERRMKRFkM96LRt1UQxmxqCF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339767740"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="339767740"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 03:05:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="657510915"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="657510915"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2023 03:05:01 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 03:05:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 03:05:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 03:05:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cn0iEyHbN4w9XLvXCtWVoKSNMiRtQQ3YdraiekgoDeQn8xvuijHQGiniOueIPEqLEFDPLxKTvC68ymZnnTM21VfiV3zjzsdBomb+vN492bSKbQiwbG/H0g7WoREqK4Eh2fsiMf4cREtIT4kN3puTPX9hH7pMa35llQ4a8b3LZgCgbimjbWzdD8j+DtrQA3tDiSZGMkzEiVUCfrhVrLyE1GowUHcpYjdp+MxURUsACFKdQiW9GKUcU59O+1pIHNYT+ojJ9Ddb5lECT4ydSmAtGUtMyimnLdLZ8KqHBXZr84etI/w3OF2Xtlkh+qk5nnv/xKdbAWB7+SBNJ91Aj4yBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tecGkS9lXObG4EC8NihC6Wq5ESdUZLN5oLDHnieY/tc=;
 b=aEbiRkw/ub5R5AGr/7mwQO2tsHHORPFkYkgnZHXtbbN5Iq9Z1if4DqpujOxn28YMX3yI4+VJu0PiqmHhQ7zv3GYaf3dIQQ692HodloJdr/hOk6hyKWtSAC534xfUCM7zjAea755v0QjEXK8fr5oeG+QMrzte7NxJCpjClHfuAqt60SgWZUb7x1JFFIHCvDnWies6VOxOFNVawQL/EdYfsvPhUhNfFQRtUgyn7vCMfap3KxA6pWT9qLrDy5I8zdJ9GAJbfvsVwqchV3VOyIfYWe3pMsYO9buj/oI7gz/eW2j2Jc9NmpVa1DHFltad55H3xiA+PA7al3wItXRJ/Oc8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY5PR11MB6185.namprd11.prod.outlook.com (2603:10b6:930:27::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 10:04:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 10:04:59 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v1 02/14] iommufd: Add nesting related data structures for
 ARM SMMUv3
Thread-Topic: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Thread-Index: AQHZUnWUiZWK9pEL2E+1+XYbwxtqR67ydQKAgAASmACAADzzgIAAKxqAgAErXACAAAkLAIAACQyAgAqcaAA=
Date:   Fri, 17 Mar 2023 10:04:59 +0000
Message-ID: <BN9PR11MB5276B843A5E24B8CF5F4449E8CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica> <ZAnx0lUkw02cVTi+@nvidia.com>
 <20230309182659.GA1710571@myrica> <ZApJGwPjHhlDwTDV@nvidia.com>
 <82f5b94b-01fe-5c99-608c-f7d124247b7c@arm.com> <ZAtL0Dx0QRbXOTfZ@nvidia.com>
 <029bb2f5-78d5-a3f2-1ae7-97fc7147611d@arm.com>
In-Reply-To: <029bb2f5-78d5-a3f2-1ae7-97fc7147611d@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY5PR11MB6185:EE_
x-ms-office365-filtering-correlation-id: 1a256d3d-7e47-4361-b923-08db26cf1186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a1RcsEAlD/CFuh4R9vDxKHJcbFNWd2A6iPFxks0iFIvthhxG2G/mciTJly4PLMgFb/Lf8xKSjyjG+NwoSJrXqt6laOqsSTsWjdWBmlQ+wgqncBTrn9JyFamB3TIjdFFnuh5La+J/6iYDMf4jX5N6Uz/MBuGfnoMTz4fiLLH9VHzGLNRKa+T4Wr26sJeX3IEf1+/D35mSkyrYuOVVDS6AWg1y3AQCr2Cay/J2RdBSRlOFdrckC3oZZ3ZkpX7MafaaD3NwUmnErqSqTZEA8VtdFL00cNmjucKVr3lkDMfmhRPFOAGae/sIbeIBrwdjSQXx1a1nXhAxjp4ryI04aM10CLGGjZdTuXymLH3DFOtUhuLUBc8OGQTnng9bKRnDKXuoah7gDjnjZBf0qoBCrTqPalDytKZ350kTQsc3RAiS9VLl7whLrB7q+bdgNrg9N2wWz203WINdKkh1zhD+AYWDRxXg6j2NwIjuFt3BelH4W0YGjXPl/2AStAdnNC3SgQIJuwZEQLriZ7AGuCrJS0+1AuCVUD7oCjcK4Sbyy0XNJdr+LB15cvy1cVdJ9Z/4le8kYKZG2ngBmCIjD4R/skX4HMUypot5qHimck5pPBelGSUNHXdhcCb3eITLbJIbiAt41IG39YGih9CmMvVazWMBK1CSRBA6cq3m1xXQzh4GIi+JHQ7o2FRb6OmtCYju2b0cA0LQOxcvCJxk/8dxTHczwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199018)(71200400001)(86362001)(7696005)(186003)(9686003)(2906002)(82960400001)(8936002)(52536014)(7416002)(64756008)(66946007)(4326008)(8676002)(66446008)(66476007)(66556008)(76116006)(41300700001)(26005)(5660300002)(33656002)(6506007)(55016003)(54906003)(316002)(122000001)(38100700002)(478600001)(110136005)(38070700005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDlJL1lXM2wwZ1pvWXJCeFR1d3Rtb3NjNklvRDhuNW53OHYvcVJZWURORFFK?=
 =?utf-8?B?MGk2VWdRc3RZRzZqTzl5azJtalp1Tkw3RHpzTGY0MXRubHk2Z3pBcjAzTWdF?=
 =?utf-8?B?SUpQT2xUMEtOUUtpWGx6eTdyNXNOS0dPcGtLSDhDWXVxcHBoNnNYYWo0dVV1?=
 =?utf-8?B?NlZUYndDbkYwMktBWTBlcGdEY1F2K2FFdTFlcHpHS3VqWHpKczZ2MmJOTEJa?=
 =?utf-8?B?NnNIcW1LN2pYOEVtTWFONllZMlpVWGNXSWJCdlJhTTFraEVhYm1sWGh4cHBr?=
 =?utf-8?B?eXZ0K1M0Q1BvMXRHMUhZU2ZndXJsS1J1OFJ1bXFmSzgyOUh0UEFJRm4walI0?=
 =?utf-8?B?RUV2ZldWanV4WDhIVjNDbElwaEw2Y1FLbE9XM3pxZlNadXB0VjhhTFRtdlBY?=
 =?utf-8?B?dUlIZkdzN1FBT0tDOGZtYm1zNlA1MXZIbFlSQ0tnVkhVVXYvdm5MYXFKMzZP?=
 =?utf-8?B?OStrV1p4U1crbVBVaG1NWnJkL2NXV3VQd2dFQk9WWFk3czFyVHp3SmtFT29n?=
 =?utf-8?B?Qy80L0ZwWUtBYzE0S3RGK29SVU5DRjdZL21VeWlMUUJGdjZob1QyTHN0OHRQ?=
 =?utf-8?B?WWNoSTJhZTFBTzhVQ3VBemNSV29XVE1NWmdCVERZazB2RGIrNzFvVDhCeFdq?=
 =?utf-8?B?UnBSM3A3YjRrVFRIZTRKZ3B3QXV4azBJay9GZ1JSSWNOd0VKd1Y5NXQ0T2xC?=
 =?utf-8?B?THJsZ011UFUwclVoTXdSeWJHcG82SGRTU29PdmYvbVJ6ZVNSaTJWaURZcFZs?=
 =?utf-8?B?RzgxekpOci9kZ3pIelRqVlhqcmRpeVBoM283SEszWTFGcVYxZDd5dTRhZ3hP?=
 =?utf-8?B?SXkzOHdaYzVqS1NTV2wwcU1tdmViZ2I3Y1lMYzBXaHhNNGRTaFZNVHZIME4z?=
 =?utf-8?B?aGhMTldjSmR5N0VlMVN1SjFZTVBTb0VoMXFTZGs0TmpEWGp6cmNoOWtJbDQ4?=
 =?utf-8?B?UzNvd0RCWm1IVWxETis4ZXZIanRTbHhTdVBZUlVpZ1dCbEZrQnFWZzNMSVJu?=
 =?utf-8?B?TGtnNXVISHNObk1uNzgxRjhmUGZkRzg3WXNlMW80VFVDWGJmOTducm1CSmpi?=
 =?utf-8?B?MGpjbEpGYStNZ0NjOTQ4NlRUSWxLSW9kQW5KSjJRK3ZxZ2pWcHIwSDlid1RE?=
 =?utf-8?B?ZjlJdkp2Y1I4QmRvUlUrMkZERStDRzBKOXVDZ2RyS0VHM1V5Qm5xUzllNHda?=
 =?utf-8?B?SmJMZHZsUFE5cUE4TFo2VmR4NWg4NlNYQlNDdDduaHFvSE85NEY2dTJPYkhk?=
 =?utf-8?B?RjZPRzBuYmJrZFlUUzYyZmppNitYOW5zc2ZPZ0pMYTMzMjNSNklvNUJGWXhV?=
 =?utf-8?B?cjh4cFhzaFJmbkFsaDFicTNCLzJ0TkhESUIwRTI4SGFsQi9RR3dQSUNYTFF2?=
 =?utf-8?B?SkdkS093cFZhYzlSOVprVk5acThqaVpUaHdZOEh5a3B5dTRlYitOVmZ5dmNI?=
 =?utf-8?B?aVBHczRveGU0dEdlWGZmczMrZE4vZEVsL1pleHhsYlRra21YSGNNWjErSGdJ?=
 =?utf-8?B?bUpZdjViQWQyV2tpM3lQWnQvZ2hIN1EwWDQzbGJrN0h0K1hoWnRjdXdGT3pL?=
 =?utf-8?B?VSsxTmN5UXp0c3FGc1hINU93WjAzWVBOZVk1UFdXdEN5eEZqNVRrcFZvalZX?=
 =?utf-8?B?QWx1ZUc2S1dOakRObEtXaGhlVENmaEw5WnNYdXhmRjFiZWVZcWl2SDhXUVpI?=
 =?utf-8?B?R1ZRbDBaWW5UZDdZNVpFbmJ0b0dKanJKL1Nwd0NqVWhCYnU4OEtDMUpUTWNY?=
 =?utf-8?B?NHFaVzB2T25DMG8rS0IzbGNPMEw3OHBKTEdwZUZJdnQ1UHhFbXdqWmpCMmdx?=
 =?utf-8?B?RFZmUzVxY2FnUWJTTDNtRHRFN2lWL1YvaW1IQmRlSEUzZE1tYzVtZ3dTMkQ2?=
 =?utf-8?B?QmdLcWpZd2VpZHlxaHkrR21kenFZZ0ZLbVcyR1VPTTdHOEdIOXQycHhiQ2hI?=
 =?utf-8?B?bXhadlduL2FreVh6VnRzMjdOK2pDU1JQZG9rWEt4R2FqNGRxcDJiSkRFMFVO?=
 =?utf-8?B?eDhnZFc1Um8rSWowd1E4cEcza2JVVGo5Q3Y3R3RDOXNDbWhiaTVFNzlQVkk0?=
 =?utf-8?B?NGtNQlRmM2hiOTBXSzc3SWg0YXYyckltd3BHa1VsMDdTY05MKzJJT3M4cTh6?=
 =?utf-8?Q?blx8P79ddyE2kwvbHMXOCJuBH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a256d3d-7e47-4361-b923-08db26cf1186
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 10:04:59.6872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KotBbqj4pjfLetUDkaf4SqTFSJRTlUsX0gdcL0ZKuuvh7eSP581rRp++3asL9mK3LTVkgUqWl6/htukfLH3ZKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6185
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBGcmlk
YXksIE1hcmNoIDEwLCAyMDIzIDExOjU3IFBNDQo+IA0KPiA+DQo+ID4gSWYgaW9tbXVmZCBjb3Vs
ZCBwcm92aWRlIGEgZ2VuZXJhbCBjcm9zcy1kcml2ZXIgQVBJIHRvIHNldCBleGFjdGx5DQo+ID4g
dGhhdCBzY2VuYXJpbyB1cCB0aGVuIFZNTSBjb2RlIGNvdWxkIGFsc28gYmUgZ2VuZXJhbC4gVGhh
dCBzZWVtcw0KPiA+IHByZXR0dHkgaW50ZXJlc3RpbmcuDQo+IA0KPiBJbmRlZWQsIEkndmUgYWx3
YXlzIGFzc3VtZWQgdGhlIG5pY2hlIGZvciB2aXJ0aW8gd291bGQgYmUgdGhhdCBraW5kIG9mDQo+
IGluLWJldHdlZW4gdXNlLWNhc2UgdXNpbmcgbmVzdGluZyB0byBhY2NlbGVyYXRlIHNpbXBsZSB0
cmFuc2xhdGlvbiwNCj4gd2hlcmUgd2UgcGx1ZyBhIGd1ZXN0LW93bmVkIHBhZ2V0YWJsZSBpbnRv
IGEgaG9zdC1vd25lZCBjb250ZXh0LiBUaGF0DQo+IHdheSB0aGUgZ3Vlc3QgcmV0YWlucyB0aGUg
c2ltcGxlIHZpcnRpbyBpbnRlcmZhY2UgYW5kIG9ubHkgbmVlZHMgdG8NCj4gdW5kZXJzdGFuZCBh
IHBhZ2V0YWJsZSBmb3JtYXQgKG9yIGFzIHlvdSBzYXksIHNpbXBseSBzaGFyZSBhIENQVQ0KPiBw
YWdldGFibGUpIHdpdGhvdXQgaGF2aW5nIHRvIGNhcmUgYWJvdXQgdGhlIG5pdHR5LWdyaXR0eSBv
ZiBhbGwgdGhlDQo+IElPTU1VLXNwZWNpZmljIG1vdmluZyBwYXJ0cyBhcm91bmQgaXQuIEZvciBn
dWVzdHMgdGhhdCB3YW50IHRvIGdldCBpbnRvDQo+IG1vcmUgYWR2YW5jZWQgc3R1ZmYgbGlrZSBt
YW5hZ2luZyB0aGVpciBvd24gUEFTSUQgdGFibGVzLCBwdXNoaW5nIHRoZW0NCj4gdG93YXJkcyAi
bmF0aXZlIiBuZXN0aW5nIHByb2JhYmx5IGRvZXMgbWFrZSBtb3JlIHNlbnNlLg0KPiANCg0KSW50
ZXJlc3RpbmcgdGhpbmcgaXMgdGhhdCB3ZSBjYW5ub3QgZXhwb3NlIGJvdGggdmlydGlvLWlvbW11
IGFuZA0KZW11bGF0ZWQgdklPTU1VIHRvIG9uZSBndWVzdCB0byBjaG9vc2UuIHRoZW4gaWYgdGhl
IGd1ZXN0IGhhcw0KYmVlbiB1c2luZyB2aXJ0aW8taW9tbXUgZm9yIHdoYXRldmVyIHJlYXNvbiBu
YXR1cmFsbHkgaXQgbWF5DQp3YW50IG1vcmUgYWR2YW5jZWQgZmVhdHVyZXMgb24gaXQgdG9vLg0K
