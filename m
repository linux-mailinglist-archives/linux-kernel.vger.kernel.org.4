Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C766CF6B1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjC2XMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjC2XMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:12:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EB53596
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680131517; x=1711667517;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tyi61kaAmwcGqHLDdj4oVqUFAihLNh0dIKqcvjF0n6s=;
  b=VJVo9GOYuqtD9JjPTQfHQy+OdfX4AD84iVuj8sdQXm7VaVN/dZRmgg65
   6qe4vqIVg9FIPF+1uHeifQd0U+UVwkaSkEb5FXls9gmX78aPZdQdDi8ST
   eVV0PrX4nY401a6Amcg4eSznyr3VQwIZ5D+rtkDd+RRTmhGg5xU/cvJTa
   um23VZnIjeUt1H/mRwt0WB6fKsKuCXJZMJ3rmX/+Oda4+dkF2lFEqmzAr
   38UbHsCozHpMau2vemgbG5OADElrz05EViDVKL0rdJwn7CWpEJcBDrsfz
   UR2QpRvGbGSKPUCj5aGTtjfZ2EIY1qqSc4naax5CQzZrepxF/qZ0i7whe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="341038839"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="341038839"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 16:11:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="795438922"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="795438922"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 29 Mar 2023 16:11:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 16:11:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 16:11:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 16:11:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2qRSyHbN3pT4mqoSj34n3gUGpT+HuqawxZhLV5R/LfrBaySE3nPw/8nyiKj8E8GSePYCE6dn93ki9E12rqwA30PzEZ92l/BEiQPySfOk12sHY3t7qkoT9EXBGZuRVibgB7TeBn8N1+g5StWuLyvhlay0cl0JdIbVyoQsbJckdiQmk8ycDY9XHF3T/+s14VeErGzt9lTTIWBWYKFpQcBjCxAyrOheVrDTiLJ+VI+Ng63uffyaxaJgQi3r3eFLjqNLj3mmst/iDbn9Si8FPwtV/uLYX553+CkVmtaQYDwmiP7GDCFu6oh02u8NuVaatPsjobXaoMktxqdJl2qowKp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyi61kaAmwcGqHLDdj4oVqUFAihLNh0dIKqcvjF0n6s=;
 b=Js4oo9Ms1jc6WbF6Si51cp58jVE7L30kpaC1Bz9p4oIrncUBCMJglijKIeUxAJXbXb1Ep91IwYtyPr3QANKFKNrsh/Np0K9TUiiZ94WnSTKV0FV+arxbJpXlbMlIMT5wgNQj43E4w51KlPbE87ra5MVIvTcvHCwBr+UtNUi9tEPpUZl/WncQFdzCHx7nh1FQywGLPhiInXECQb3oMp/DjCeJzcmzdEqIpz6akmUVr3bkvrdD9QSOVmArrGOgwCZq96DOe3TBlt0TnWW1Zt4E7JQwC3ClEHvmRaBE08GXgiggWcVa+uPcIcni9vX9leH13sGoXVuldMx58A14IhbxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by CH0PR11MB5539.namprd11.prod.outlook.com (2603:10b6:610:d6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 23:11:09 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::7576:1f4a:2a6c:72f7]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::7576:1f4a:2a6c:72f7%2]) with mapi id 15.20.6222.030; Wed, 29 Mar 2023
 23:11:09 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "Liu, Yujie" <yujie.liu@intel.com>,
        "Kang, Shan" <shan.kang@intel.com>
Subject: RE: [PATCH 1/1] x86/vdso: use the right GDT_ENTRY_CPUNODE for 32-bit
 getcpu() on 64-bit kernel
Thread-Topic: [PATCH 1/1] x86/vdso: use the right GDT_ENTRY_CPUNODE for 32-bit
 getcpu() on 64-bit kernel
Thread-Index: AQHZU/pnrQNA4Qs8TE+zA+Udtp/Txa74104AgAAkKCCAGIjwgIAA+Q0A
Date:   Wed, 29 Mar 2023 23:11:09 +0000
Message-ID: <SA1PR11MB673439BB3F5C1BE2CDEF91A1A8899@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230311084824.2340-1-xin3.li@intel.com>
 <5e84fd48-459d-8850-d26f-860c6d34a9ad@intel.com>
 <SA1PR11MB6734CF1607F263CB8389F5F2A8B99@SA1PR11MB6734.namprd11.prod.outlook.com>
 <SA1PR11MB6734735DD3637E302DC155FFA8899@SA1PR11MB6734.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB6734735DD3637E302DC155FFA8899@SA1PR11MB6734.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|CH0PR11MB5539:EE_
x-ms-office365-filtering-correlation-id: 17d55414-33a6-4917-5f18-08db30aae1e1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aBNBAKOJXVKBRl9OjmghhGDRh/EBE8DOHDO6ZpqI9ttWAkFjK451u/+T/v45R3pGC2EJm/uyuxOUoNK9+rL/w/pI0uv3dJhjsbd+rsb/LC+V6foMg9NgV+YEAFe8YyzTCMdDTG7I6cXlLnF+tG9Y1WOYL6Xl2zGZ+fZDSh++72fGa10sm1JEwrfE7ybpsYB3/Cxu3r3eU/8NNvmmEXjDgM8frAA38pwVVHM4baWwpPFd40GureQnjK2dMnpHSRRfXdPlAjvwUYnyZjAid2MAl8V4Xxj9NSkX6J3+JuX2/bY8lhb123fAQvQQ8EDM1CCx1BaQVebTRVqjGenkRFS/h+HT+sNmZoLGFiC0YPpOCkc/uKAYGnrj2p0TWUnFX3aErALkmxdEYkqme6l3ieAhx5kApi9DTYLJK+4fZYcVcmQ9jAh/QZ1er+PeT1xLIcjZD9IV1S9gAEiWQHdBNmWuOTFxmJRGzz/XXrDR1dfuhotZ8R58ggcuX4q4H4eRczTt6l8uRb2jISnMO92IHjNQS9AW8EwdqsJi9mRFjqhY3JFE5w81lbtSBxDtKT5s4AMcXK/SrA7Eda9h9c2pKtVXbKL7kIrXNgVbJewCebqKF6+E7wN0/lUDNsu+I6eJecBS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(7696005)(71200400001)(6506007)(478600001)(110136005)(9686003)(54906003)(186003)(83380400001)(4326008)(5660300002)(41300700001)(52536014)(8936002)(2906002)(82960400001)(26005)(316002)(122000001)(33656002)(38100700002)(2940100002)(38070700005)(66946007)(66556008)(8676002)(76116006)(66476007)(66446008)(64756008)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0wxM1JDaXFVQ0tiMTZlbG1WakVrcFNKK09DbFFDTzA3aHdpYWtTRm85VEcz?=
 =?utf-8?B?Ulo1VXJwTis2bGtPbW1IZXowOEExZEZhNFhFa3RzMUp5U0gzTHpQK25NcURa?=
 =?utf-8?B?SUtiY2RyYWJaeXlkYm1teFFpRElYbklsUjZ5eTduTzIxcklOa1JnWUEzZ2h2?=
 =?utf-8?B?UmF2Ly9Cak1tdFh3OVlxTXdSTHYvS3diSC9ybVI4UHdQUkE1OC90MXN3U2lF?=
 =?utf-8?B?R2lqQXdjSnBsQmxNRll1Ri85ZDg0VStIdTlkSTl6TllqOVBMRWFaVG5Fa002?=
 =?utf-8?B?dWp1azlMR2xLalZ2R2ZUOWxCRlY4RVZCTFY2cFB5VHlFNzFaVXB0b2ljS044?=
 =?utf-8?B?SjNwL1J4eDR5WVcxZWhwTGpWUldiU2hsRm4xVGwrQk5rbmQ5WG9LUjlKRzdU?=
 =?utf-8?B?YUxjNE56M2x0Rk5qYVJjNVhSbHlYT245Skx5MFVFU0VhcFdYenRwNFJkdjZ1?=
 =?utf-8?B?bzZlbjU4ZWQzTDhQdTl4UGxCc1I0THkxTTNJTEVZMGpHWTR3cnpod3UzSndm?=
 =?utf-8?B?dXNDRjlDV25jZGxKWVNwQzViY1RvQUlwNGxDQndzWGNTKzJiWUl1RU9SdDRq?=
 =?utf-8?B?b09iM3UxaVRKcmZvTjh6ZXJyNitJd3JON1RxUWI4c1BJNkU3VFdjSitPcmlL?=
 =?utf-8?B?UFlhZ2hMQzZDU245UkUwcUYrdktFUGVUdXhDdENsZ1VHTTdicUlBMTBwbjBB?=
 =?utf-8?B?UzRTQytVSXZsNjZISmxQOXhlOVNIQmVXYWFHQnBGUTB6Q2hIb0ZpMWgvaS9B?=
 =?utf-8?B?aFZ5Y1o4MGNZU1JhSUdQaFRCNnd0eW1mYnFBeU1YZHR2MjRrYlhvOGl1a0Qv?=
 =?utf-8?B?ekhzQXZXMklGaFBtTk01QzJwY0tKNy9qbkFjYmtFWTBtWFVWcEZKZGhjNXVn?=
 =?utf-8?B?N2FLa2dJdkFSV1BNM3k0M3ZzN3dLSmtoZDBYcjVnRmljbGxkNVRMVXhUZHhy?=
 =?utf-8?B?SWFLemFtNDNYelMrQklFbnBSV1FYVXZ1RmtXRW1DVHdSenk2Y3lHNWFkVDhZ?=
 =?utf-8?B?OEhJcUZhdXdwak5GVGhNNGpwSWVldWtlOVdSc2VvemVNeVhESEVndzh4Um8y?=
 =?utf-8?B?Vk0vWFUwcUNVTFhEbGp2S0JCQkdCRmE3M0oyRmZKc2VPTzRnNlg0RkNDcEJ1?=
 =?utf-8?B?bUJWWlZaNUhobHBXamZUN2lsdzBlZTBsT1lpL3o5aDhCM2hsQVdQU3k1eWlI?=
 =?utf-8?B?WUQ3LzBwdkJIUTJJUzZEdlc3ZkRqWDJjcjcxSFhUeHJtb0Y1QWlMNzUzendI?=
 =?utf-8?B?b1g4aldsclFWY3h6K1lJLzk2K1RiRUlHQ1hIdkpaQXZ6Zk1qcHkvVHljQVlW?=
 =?utf-8?B?Y05WdnlodWJndWNneW1yUVdWcmhFL3ZtbWN2REFVcGpPa2x6ZnNwK2dBNlUy?=
 =?utf-8?B?dHVWdjJXS1NWYVZmNWxkVjd0WVZHdmdwZXplbkpYajR5dy9namswL3ZFT0Fx?=
 =?utf-8?B?Ymo0V1U2LytvQ1RwaWpSRlJMWGRyRXdPM1NBdHdaZForM3ZuZUJ2ODNuKytO?=
 =?utf-8?B?emQzeUFqSDMvUXdtYzJzUnRuNlI3M0h6NVNCTThyZ0pCMGQ5S3BESXZCT1VC?=
 =?utf-8?B?dVZhWEZxeURTeEoyenRyTDBoMDNsanlKUllIR0VQOStmVUM4SHowVVBCTkxN?=
 =?utf-8?B?YVBESjI3d0FRZEZzSGFWWFlUelh2M0JLZ0FQWkF0VTRTemlWbmZDTmJFc1Zn?=
 =?utf-8?B?R1U2UWdoVXh3SWNGa29vV2w2cG9Sby85Yk9HNnhjZlNnQVpLeTR5MEw3TkdN?=
 =?utf-8?B?UXczaWRyb3Z4Q0RqLzBSQVpGRnJjTGhNMUdTMnh5WHFmQW1VYndnYUNjRk9v?=
 =?utf-8?B?d0V3VmtqbmRnR0kxWkpFd0lpV1grbXZ5ZVh3ZHFWd3paaXVaR2h6T1NaV1FF?=
 =?utf-8?B?dTdsWWZVUjNVMXdzeXZrMEswV0lJNWRXMThFdmNjek81eVJnbHZKYXF1N2I5?=
 =?utf-8?B?bEpoeDU5WlpYSE1RN2RVT3pBK3JrcGFhN3V1RXk0NFhwRkN1OGt2bWppS2ox?=
 =?utf-8?B?RENBQUVIUjdMZjU0SnJVaUJEZHBPbkc0VHFmbUhvRjgwMkxxQUNFVGxaSWpP?=
 =?utf-8?B?Qm01RHpHUjVGZTNuV3dxQmdFazZhUW0vOFFOOHZYaW96M002UXVBM3NYZmF2?=
 =?utf-8?Q?v/hI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d55414-33a6-4917-5f18-08db30aae1e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 23:11:09.5060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWZFriXKcW+89IUgkoEMLLGdcJ8jBEEyZ1AmBWzDNAfbzVzeUpvslV37HajoOL2+VJOTY3pTLKoa08wDmrTlBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5539
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gPiArI2lmbmRlZiBCVUlMRF9WRFNPMzJfNjQNCj4gPiA+ID4gICNkZWZpbmUgR0RUX0VO
VFJZX0NQVU5PREUJCTI4DQo+ID4gPiA+ICsjZWxzZQ0KPiA+ID4gPiArI2RlZmluZSBHRFRfRU5U
UllfQ1BVTk9ERQkJMTUNCj4gPiA+ID4gKyNlbmRpZg0KPiA+ID4NCj4gPiA+IElzbid0IHRoaXMg
a2luZGEgYSBoYWNrPw0KPiA+ID4NCj4gPiA+IEZpcnN0LCBpdCBtZWFucyB0aGF0IHdlJ2xsIG5v
dyBoYXZlIHR3byBkdXBsaWNhdGUgdmVyc2lvbnMgb2YgdGhpczoNCj4gPiA+DQo+ID4gPiAJI2Rl
ZmluZSBHRFRfRU5UUllfQ1BVTk9ERQkJMTUNCj4gPiA+DQo+ID4gPiBpbiB0aGUgc2FtZSBmaWxl
Lg0KPiA+ID4NCj4gPiA+IFNlY29uZCwgaWYgYW55IG90aGVyIHVzZXJzIG9mIGZha2VfMzJiaXRf
YnVpbGQuaCBmb3IgdGhlIFZEU08gc2hvdw0KPiA+ID4gdXAsIHRoZXknbGwgbmVlZCBhIHNpbWls
YXIgI2lmZGVmLg0KPiA+ID4NCj4gPiA+IEkgdGhpbmsgSSdkIG11Y2ggcmF0aGVyIGlmIHdlIGRl
ZmluZSBhbGwgb2YgdGhlIEdEVF9FTlRSWV8qIG1hY3Jvcw0KPiA+ID4gaW4NCj4gPiA+ICpvbmUq
IHBsYWNlLCB0aGVuIG1ha2UgdGhhdCAqb25lKiBwbGFjZSBkZXBlbmQgb24gQlVJTERfVkRTTzMy
XzY0Lg0KPiA+DQo+ID4gU291bmRzIGEgYmV0dGVyIHdheSwgbGV0IG1lIHRyeS4NCj4gPg0KPiA+
ID4gQWxzbywgYWJvdXQgdGhlICpzaWxlbnQqIGZhaWx1cmUuLi4gIERvIHdlIG5vdCBoYXZlIGEg
c2VsZnRlc3QgZm9yIHRoaXMgc29tZXdoZXJlPw0KPiA+DQo+ID4gV2hlbiBsc2wgaXMgdXNlZCwg
d2Ugc2hvdWxkIGNoZWNrIFpGIHdoaWNoIGluZGljYXRlcyB3aGV0aGVyIHRoZQ0KPiA+IHNlZ21l
bnQgbGltaXQgaXMgbG9hZGVkIHN1Y2Nlc3NmdWxseS4gIFNlZW1zIHdlIG5lZWQgdG8gcmVmYWN0
b3INCj4gdmRzb19yZWFkX2NwdW5vZGUoKSBhIGJpdC4NCj4gDQo+IEhpIERhdmUsDQo+IA0KPiBI
b3cgYWJvdXQgdGhlIGZvbGxvd2luZyBwYXRjaCB0byBhZGRyZXNzIHRoZSBzaWxlbnQgZmFpbHVy
ZT8NCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZWdtZW50LmggYi9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9zZWdtZW50LmgNCj4gaW5kZXggNzk0ZjY5NjI1NzgwLi5kNzVj
ZTRhZmZmNWIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NlZ21lbnQuaA0K
PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZWdtZW50LmgNCj4gQEAgLTI1NCw3ICsyNTQs
MTAgQEAgc3RhdGljIGlubGluZSB2b2lkIHZkc29fcmVhZF9jcHVub2RlKHVuc2lnbmVkICpjcHUs
DQo+IHVuc2lnbmVkICpub2RlKQ0KPiAgICAgICAgICAqDQo+ICAgICAgICAgICogSWYgUkRQSUQg
aXMgYXZhaWxhYmxlLCB1c2UgaXQuDQo+ICAgICAgICAgICovDQo+IC0gICAgICAgYWx0ZXJuYXRp
dmVfaW8gKCJsc2wgJVtzZWddLCVbcF0iLA0KPiArICAgICAgIGFsdGVybmF0aXZlX2lvICgibHNs
ICVbc2VnXSwlW3BdXG4iDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICJqeiAxZlxuIg0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAibW92ICQtMSwlW3BdXG4iDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICIxOiIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICIuYnl0ZSAweGYzLDB4
MGYsMHhjNywweGY4IiwgLyogUkRQSUQgJWVheC9yYXggKi8NCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgWDg2X0ZFQVRVUkVfUkRQSUQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIFtwXSAi
PWEiIChwKSwgW3NlZ10gInIiIChfX0NQVU5PREVfU0VHKSk7DQo+IA0KPiANCj4gQW5kIHRoZSB0
ZXN0IHRoZW4gcmVwb3J0cyBDUFUgaWQgNDA5NSAobm90IGEgYmlnIGVub3VnaCAjKSwgd2hpY2gg
Y2FuIGJlIHVzZWQgdG8NCj4gaW5kaWNhdGUgYSBmYWlsdXJlIG9mIHRoZSBsc2wgaW5zdHJ1Y3Rp
b246DQoNCkhhdmluZyB0byBzYXksIGl0J3MgYSAqYmFkKiBpZGVhIHRvIHVzZSBhIHNwZWNpYWwg
IyB0byBpbmRpY2F0ZSBhbiBlcnJvci4NCkJ1dCB0aGVyZSBpcyBhbHNvIG5vIHJlYXNvbmFibGUg
ZXJybm8gZm9yIGdldGNwdSgpIHRvIHJldHVybiB0byBpdHMgY2FsbGVyLA0Kc2F5aW5nICJ3ZSBo
YWQgYSBwcm9ibGVtIGluIHRoZSBzeXNjYWxsJ3Mga2VybmVsIGltcGxlbWVudGF0aW9uIi4NCg0K
PiANCj4gfi9zZWxmdGVzdHMkIHN1ZG8gLi9ydW5fa3NlbGZ0ZXN0LnNoIC10IHg4Njp0ZXN0X3Zz
eXNjYWxsXzMyIFRBUCB2ZXJzaW9uIDEzDQo+IDEuLjENCj4gIyBzZWxmdGVzdHM6IHg4NjogdGVz
dF92c3lzY2FsbF8zMg0KPiAjIFtSVU5dIHRlc3QgZ2V0dGltZW9mZGF5KCkNCj4gIyAgICAgICB2
RFNPIHRpbWUgb2Zmc2V0czogMC4wMDAwMjggMC4wMDAwMDANCj4gIyBbT0tdICB2RFNPIGdldHRp
bWVvZmRheSgpJ3MgdGltZXZhbCB3YXMgb2theSAjIFtSVU5dIHRlc3QgdGltZSgpICMgW09LXSAg
dkRTTw0KPiB0aW1lKCkgaXMgb2theSAjIFtSVU5dIGdldGNwdSgpIG9uIENQVSAwDQo+ICMgW0ZB
SUxdICAgICAgICB2RFNPIHJlcG9ydGVkIENQVSA0MDk1IGJ1dCBzaG91bGQgYmUgMA0KPiAjIFtG
QUlMXSAgICAgICAgdkRTTyByZXBvcnRlZCBub2RlIDY1NTM1IGJ1dCBzaG91bGQgYmUgMA0KPiAj
IFtSVU5dIGdldGNwdSgpIG9uIENQVSAxDQo+ICMgW0ZBSUxdICAgICAgICB2RFNPIHJlcG9ydGVk
IENQVSA0MDk1IGJ1dCBzaG91bGQgYmUgMQ0KPiAjIFtGQUlMXSAgICAgICAgdkRTTyByZXBvcnRl
ZCBub2RlIDY1NTM1IGJ1dCBzaG91bGQgYmUgMA0KPiBub3Qgb2sgMSBzZWxmdGVzdHM6IHg4Njog
dGVzdF92c3lzY2FsbF8zMiAjIGV4aXQ9MQ0KPiANCj4gVGhhbmtzIQ0KPiAgIFhpbg0K
