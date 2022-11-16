Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A554362B62E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbiKPJPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbiKPJPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:15:22 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE69D2F5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668590118; x=1700126118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p9CFxa8QM1dvY2FfUKlpjeuD6pg+B7yWD3FmX49BhAU=;
  b=lkrferjm4nim4aEjIxVh2Vm8xPJ6rh5rC/WBjEVrsEB8B4hH1Z8rmwL/
   KQ162n8AYs+Z5bk+RwEaWdpsRoQ4w2BKQLpjpjH9AoPgQvMCM2EMK36qm
   c0hheq3KDbgWGC4OqgpRHu/rEm0RjZpSa1tpKb73E8od+txsRsG3YFkTC
   KXakVkXoojy2tysdXwB5ll5iHv17jUz7yjPcLT8L15sSEqIUT2JzhHyOe
   EVoL6HPWo9kPI/QqblJ5jcAW/BZxDahuOLtVP+hGBI/rW0rwNUZNLDdM+
   dmuTtWWKu5N7XOC8IgGpd+oh4spQB9fz1RUFzk8scL31ppi7IoPr+D/KW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292201600"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292201600"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 01:15:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="884324787"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="884324787"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2022 01:15:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 01:15:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 01:15:17 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 01:15:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXvxa/FUn2t2a7X/tkNeB0hZ/+psPny+sNTvkspe16FSgYf0skR0WAArb5ZbrF3f3neKsMM4DM/qCqaZWxb/8NuzQTYbQwS21h9jJMBoNmnZxtX29qnlJ945c0bh7yVnUcsZ6DF3LRRVjcI2hPuhjynuhEsmUA2jbktQ+pldEEyqjdDd/gO0WLGMQw9K8W/8bzyKg86mOE5eeHi19vXwTTtRXu3sBh1DEU1/Sgfrk2BFUnuCniHmvx82TAsBQryv2etnZs7bSCjpvanwrcs18oev48rXuFiSTnZxj+inyhJ3iG/ZmTPGVCw7GbD19WmLOmklNwUWOHSinG6QDVB/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9CFxa8QM1dvY2FfUKlpjeuD6pg+B7yWD3FmX49BhAU=;
 b=FBi7rJxqKDya4CsWxAtRaOmOxc8+T+3kX7z2ykz2Q0YOLsuL5vLF4XPz0/xWh0pMCGfPXiWgztuoQf9pATJel7zACWM3ffVkaAK/WGrUn5/Tn8j2TY62gZERKIGik6SLb9ZppmiL/tM+7y35ZFFXWAhtWM1sg1ZbNMuXrl5CGSJICEWQtD8eJlVIN4PoLiK+g50hIHFtMFCJHn0ntznRKECTFMUILiA3BNmGT84Le8+dbnKZe2jOXHuHdauRD/SH8Z6FsoYCiHzMFjoRwOhSLp2ycEJ7hqP8sZwD+/AAMqwYHK8AnPt21SsEcGSkQjDPY0OVJhXAgcmlEHscqMGZ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5151.namprd11.prod.outlook.com (2603:10b6:a03:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 09:15:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489%4]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 09:15:15 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/7] iommu/vt-d: Fold dmar_remove_one_dev_info() into
 its caller
Thread-Topic: [PATCH v3 4/7] iommu/vt-d: Fold dmar_remove_one_dev_info() into
 its caller
Thread-Index: AQHY98siMKR1/esT2UmXGuRo20ktuq5A7buQgAAMpQCAAA4ucIAAK3sAgAATKUA=
Date:   Wed, 16 Nov 2022 09:15:15 +0000
Message-ID: <BN9PR11MB5276DEEEA205B267192FC01B8C079@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221114014049.3959-1-baolu.lu@linux.intel.com>
 <20221114014049.3959-5-baolu.lu@linux.intel.com>
 <BN9PR11MB527668E6C7666CAA5F0804428C079@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e7c686d7-bad9-b58b-3be4-50898e142230@linux.intel.com>
 <BL1PR11MB5271F0D4E91A3F6179216ADA8C079@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ebace32b-be36-5c9f-579b-211cad75df02@linux.intel.com>
In-Reply-To: <ebace32b-be36-5c9f-579b-211cad75df02@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5151:EE_
x-ms-office365-filtering-correlation-id: 75e987f8-278a-4e3f-4cda-08dac7b312d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ymqm29j4ql6zwpY1xWRKXPtN0b3KYZqvxm5Mp6GHCCx7FKm+JPIwj64Ay9J8zxW+bEQnTZeEZCxUUBxlZeTIUJvPxHpc1/MTanXxkvGEiidB34222QSX+REzwQIZVTBaNBxcO+DKaYGp5ojbS2EATGSGfkVzgc94bExyia/yq7fH/DAVaCBzgUrK3ZJK8Kva6ZTRC946xQPq90oFGoMNMtyR5CCAGfZv+ERCzcBel6ihDWFVjV1xLv11jFaq95mCHmZgt9rFYfg9lFV8E5fM/yU1kBbzxDcQ9dSdeW6W2zlX7O5HwZUQyrxmjG+O6BGisH/8YTvb2vFPq8i6x6c2HV83i+hj3lLSYqj/6cw6TPpaxACzNKmSdWvK1jF+o10LQayXOuhflZwcp9IxmhGa0nkv1sGbvUjPaSmFqI5Kd4ojFHR6zhTgs0OiKO/eZNQL+e8sBKdY01o0gngvYcqBhn8Zf9PLHyUT+fRDTodTuSas2XXlsbzfU1hd5fvB5228fTm9mSEygYacksKE0lMYB9PxS0fzuCl4+3Ma6NGJtZCO1cFJjdZNlIiDwY9D/OrLvQa6kIGOk/oFhwDpbcyGeCCKr6agSWi0VutAZaNalINDPcKG617LdB9Xz7b45aRtpXZx8Y4QQfy4tqV9oJp4Dno6PNsS8rRO28XdA7C0OmA5+SCF5WnyyNXxxgrRKL85BqNUP/reJyxs00+DRvAMHfaoeO4tiTg4WVsxfe3RwDLpj3Zn0x2IMCLVjl5iaccVILSiU647JXgkPQtgoxLh0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199015)(83380400001)(71200400001)(54906003)(110136005)(6506007)(55016003)(7696005)(316002)(478600001)(53546011)(38100700002)(9686003)(38070700005)(26005)(66946007)(64756008)(66556008)(66446008)(66476007)(4326008)(8676002)(76116006)(33656002)(122000001)(86362001)(82960400001)(41300700001)(2906002)(8936002)(52536014)(186003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEZ1MVFTa0ZyRUIzQm1OTFIzTFpUWjBReTlrdlZGUGRqY2Rpc096VmNNQm0r?=
 =?utf-8?B?dWx1eFE5M2JVNGRaREdPTnBoWlREQTFFbFJBdWtaS3VEMlU2emwzeEhrVlZl?=
 =?utf-8?B?dTdyajdsWkhMSUdrRm9nYmk5QWRTS3JPYmRJZVhRaEV4cGt3NDdJL1F3cWdG?=
 =?utf-8?B?dHlYdXF0WUVqWlB1K1I3cEtTNHl0YmdtWjI1UVEvYjJFTS9GMU9UdWN4cFpL?=
 =?utf-8?B?UG1pVGxTcDM1MUV3dGlzcm5NU2w5Uml0SWZwOXFBTUpsZlc3cEpUTmEzNzIr?=
 =?utf-8?B?L1UxNDcyMG5TM0Z1UXFueVJCWW9vem9MVDJVTFlWN1BXTDBKNmlOOTZCKyth?=
 =?utf-8?B?blJYcGxldDZMTE9oV0I0VDgxNjMyRkpNU01PcGUwQ1ZpUUJ3cWRBZStSNG5F?=
 =?utf-8?B?UlFQSUlueU0yWWRoRTU3cW9pV0x6T2RCZU9rWFVFV1ZxMHdjOEMwazNLa05S?=
 =?utf-8?B?bllOSk9sNkZROStjSEFCb1hvdU4zTEV4WVcwV3JVdGZvUzM5d1VPeDFlTDky?=
 =?utf-8?B?eU1ZTmEzTVI0ZFVPUEVzcWdLYkNiL1BaZk5mSSs3eWgzK1A4QmtDZ21oOFZB?=
 =?utf-8?B?dWQ5SW45WlZ6YkF0dmczOGttK0JxNlUyZXhaTUNWMDR0U0E4RG15NHNsUmZr?=
 =?utf-8?B?eEU1bzMrY3FYTW41ejN4NjYvSEZSalJTZk9ENHdyUmF2dUZoM3BNSk42dXFG?=
 =?utf-8?B?aUtOclZ5QXJBQXBRSnR0YytGblZacnkxbW4rTzMrS0xFTnB4SGo3dVlTTGZi?=
 =?utf-8?B?SzNZaHAxb0RhUEdCYUdvMTRaTkZwSVlFeDFZOWgrYzVUM0tkb0h6MUdaeVNt?=
 =?utf-8?B?KzQ1YU9oZTkyRDZXNE5CYm9nTDMwZmltMmwzYWswaHloT3JCRUpwYXJvNGlM?=
 =?utf-8?B?SlBKWS9FYTFhaGc5U2c0MFVvWTA3RDlQaHl5b0lsa3RoMnZ2aHpic0dORmI1?=
 =?utf-8?B?RzkwUEx3QnZPZEx2QXdhb3ljMnRWMVdWY2FBQkVsSUhFNGFWR0dOb2dlNk0z?=
 =?utf-8?B?T2dMZm82Qzh4TEFTVzE0bkVneXpoekkyTk9nMldvSHdIOE9HZ2dHd0R2YUZn?=
 =?utf-8?B?VUFaMUUzRDkzUHpWdE1JdSsrVnl1dVVEdFM1TWg3amxxSi9NdjZHWmFFenEy?=
 =?utf-8?B?WTMzQ2JMSDRHa1JHbmdzNFErdXJRc2loa3BjeGk4TiszRFZweXg1bVU5ek9U?=
 =?utf-8?B?bThSVWc1WUJZY2E2eEY4ckRucUpWQjlFQzBqeDE0WVdHTGpETkZMQjlDVERM?=
 =?utf-8?B?SElHQnNGRDVLbW81SUlmcTN6SGZHRTNsYmNKOWtUQ2FJZlgzV2IwM3pvL3Z0?=
 =?utf-8?B?ajlRUXBPdXBVZW9pN0FMc21kWExtOFV2eFI5c2Z2TTFjSmR1azJEb2RiVmNo?=
 =?utf-8?B?aGxTWWZnZ2xybWllaCtyK3FFekJmZEc3YXovUkdYeVM1dlRhcE51bDZseC85?=
 =?utf-8?B?Z0lkYWJMRkpVUEd2UG4wT1JCQ25hc1MvM2VLVlBJQ1J3b0FhaWNPRThaL2x5?=
 =?utf-8?B?LzcvZ0pGb1cwK0lsNm1YQkQxYSs3RktISm83MTFSL3FPbkU0NnN3K0d0S1BP?=
 =?utf-8?B?RENEMTBGalk1c3IvQXFiQUg4aHdlTi9uUTVnK1pOOG92WE9FWEZsQk9SNTg4?=
 =?utf-8?B?d0F4RVFKdC94YkMvU21BbzBNRHIwMGlvb2x1VnZBWHdXWldCeFcrMEJHR1VE?=
 =?utf-8?B?cHJCWXVUYzcrbmNmRDdVL1B1anhya0NYSXZpUC9TMGg4M09sN2VHTjluRWhY?=
 =?utf-8?B?MDVibFBPcHRtNUdjY3Z1SFFCd1pqWS8zK0FwU05iNytSS1pTWm4yMUZBMGxO?=
 =?utf-8?B?UGcwemFqbWcrbGxueWdRbkNrM1ZjVUtPak83NnlBRmdrU3FielFKQUZNSXNp?=
 =?utf-8?B?TG1RTmdnYnNIMGRVa2VXWHFlRURIQTIrNjFBbnNzdUpLa3NjT2Vmak5wb0RF?=
 =?utf-8?B?aFZvdThBNUxJcHZJb3d0ajNQVGFIUWF2d0loc2RtYXVPd1M1RWJTZjZGRDNn?=
 =?utf-8?B?QlNPMXdoZFIwL0dweldNNUE2dWZIbWl4VGFSdG1YNTB0TVJQK1ZTZGZYSFB4?=
 =?utf-8?B?eXNpNjJ6UXpUVzZDRERYZEVLalNWbGxOMFVuMmtxdEFiRXpWWGlkOS9LY3Nz?=
 =?utf-8?Q?fgfVLWWQe4FF6w3l8iv002CJz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e987f8-278a-4e3f-4cda-08dac7b312d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 09:15:15.5101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAXNT6ICJI8m70SYJfxvbDCXdrVkm0idLF9ufHscyYa6UAwqCjr9San1jt94vhOstgr7hHwAOWg2s2HXUaChiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5151
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE5vdmVtYmVyIDE2LCAyMDIyIDQ6MDMgUE0NCj4gDQo+IE9uIDIwMjIvMTEvMTYgMTM6
MzUsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBCYW9sdSBMdTxiYW9sdS5sdUBsaW51
eC5pbnRlbC5jb20+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTYsIDIwMjIgMTI6
MzYgUE0NCj4gPj4NCj4gPj4gT24gMTEvMTYvMjIgMTE6NTMgQU0sIFRpYW4sIEtldmluIHdyb3Rl
Og0KPiA+Pj4+IEZyb206IEx1IEJhb2x1PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gPj4+
PiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDE0LCAyMDIyIDk6NDEgQU0NCj4gPj4+PiBAQCAtNDU2
Miw3ICs0NTM4LDEwIEBAIHN0YXRpYyB2b2lkDQo+IGludGVsX2lvbW11X3JlbGVhc2VfZGV2aWNl
KHN0cnVjdA0KPiA+Pj4+IGRldmljZSAqZGV2KQ0KPiA+Pj4+ICAgIHsNCj4gPj4+PiAgICAJc3Ry
dWN0IGRldmljZV9kb21haW5faW5mbyAqaW5mbyA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOw0K
PiA+Pj4+DQo+ID4+Pj4gLQlkbWFyX3JlbW92ZV9vbmVfZGV2X2luZm8oZGV2KTsNCj4gPj4+PiAr
CWlvbW11X2Rpc2FibGVfcGNpX2NhcHMoaW5mbyk7DQo+ID4+Pj4gKwlkb21haW5fY29udGV4dF9j
bGVhcihpbmZvKTsNCj4gPj4+PiArCWRldmljZV9ibG9ja190cmFuc2xhdGlvbihkZXYpOw0KPiA+
Pj4gY2xlYXIgY29udGV4dCBhZnRlciBibG9ja2luZyB0cmFuc2xhdGlvbi4NCj4gPj4gVW5mb3J0
dW5hdGVseSBkb21haW5fY29udGV4dF9jbGVhcigpIG5lZWRzIHJlZmVyZW5jZSB0byBpbmZvLT5k
b21haW4NCj4gPj4gKGZvciBkb21haW4gaWQgd2hlbiBmbHVzaGluZyBjYWNoZSksIHdoaWNoIGlz
IGNsZWFyZWQgaW4NCj4gPj4gZGV2aWNlX2Jsb2NrX3RyYW5zbGF0aW9uKCkuDQo+ID4+DQo+ID4g
dGhpcyBzb3VuZHMgYW4gb3JkZXJpbmcgcHJvYmxlbS4gY2xlYXJpbmcgY29udGV4dCBzaG91bGQg
YmUgYWZ0ZXINCj4gPiBibG9ja2luZyB0cmFuc2xhdGlvbiBpbiBjb25jZXB0Lg0KPiANCj4gQXQg
cHJlc2VudCwgd2hlbiB0aGUgZGVmYXVsdCBkb21haW4gaXMgYXR0YWNoZWQgdG8gdGhlIGRldmlj
ZSwgd2UgZmlyc3QNCj4gcG9wdWxhdGUgdGhlIHBhc2lkIHRhYmxlIGVudHJ5LCBhbmQgdGhlbiBw
b3B1bGF0ZSB0aGUgZGV2aWNlIGNvbnRleHQNCj4gZW50cnkuIEFib3ZlIGNvZGUgaXMganVzdCB0
aGUgcmV2ZXJzZSBvcGVyYXRpb24uDQo+IA0KPiBDYW4geW91IHNlZSBhbnkgcHJhY3RpY2FsIHBy
b2JsZW1zIGNhdXNlZCBieSB0aGlzIHNlcXVlbmNlPyBJZiBzbywgaXQNCj4gc2VlbXMgdGhhdCB3
ZSBzaG91bGQgY2FyZWZ1bGx5IGNvbnNpZGVyIHdoZXRoZXIgc3VjaCBwcm9ibGVtcyBhbHJlYWR5
DQo+IGV4aXN0Lg0KPiANCg0KdGhlcmUgaXMgbm8gcHJvYmxlbSB3aXRoIGV4aXN0aW5nIGNvZGUu
IEp1c3QgYWZ0ZXIgdGhpcyBwYXRjaCB0aGUgb3JkZXINCmxvb2tzIHdlaXJkIGJhc2VkIG9uIHRo
ZSBsaXRlcmFsIG5hbWUgb2YgdGhvc2UgZnVuY3Rpb25zLg0KDQpkb21haW5fY29udGV4dF9jbGVh
cigpIGlzIGEgYmlnIGhhbW1lciB0byBkaXNhYmxlIHRoZSBjb250ZXh0IGVudHJ5LA0KaW1wbHlp
bmcgdHJhbnNsYXRpb24gbXVzdCBiZSBibG9ja2VkLiBUaGVuIGNhbGxpbmcgYW5vdGhlciBibG9j
aw0KdHJhbnNsYXRpb24gYWZ0ZXJ3YXJkcyBiZWNvbWVzIHVubmVjZXNzYXJ5Lg0KDQpQcm9iYWJs
eSBpdCBzaG91bGQgYmUgc3BsaXQgaW50byB0d28gZnVuY3Rpb25zIHdpdGggb25lIHJlcXVpcmlu
ZyANCmluZm8tPmRvbWFpbiBjYWxsZWQgYmVmb3JlIGJsb2NrIHRyYW5zbGF0aW9uIGFuZCB0aGUg
cmVzdCB3aGljaA0KYWN0dWFsbHkgY2xlYXJzIHRoZSBjb250ZXh0IGVudHJ5IGJlaW5nIHRoZSBs
YXN0IHN0ZXA/DQo=
