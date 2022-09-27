Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1E95ED04C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 00:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiI0Wcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 18:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiI0Wcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 18:32:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301D51E8035;
        Tue, 27 Sep 2022 15:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664317950; x=1695853950;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nnvZ9bvFllboDECaEYNE8R/zoBnoRGUHF/4x+LaD3rY=;
  b=n8l6/1tgpqZ//navBEQKlAtWnulYPTexqkdX4GftGqmKRsYB8NyBo1hv
   1IqWVUy93AgbMJJ4gm5QSighr6JPt+YOeohJpLTJ6s1GUUJyjF2RFPnbn
   8LpgmfnbsPGzndxJQaN+vj+WJsVgA9MwOD0CCkZsb9UTAapANJ/1m5y2C
   MXPjujci1sa8F9wPxw84hKRsFAGTJOS500fnZr6Pza58005AMUryDCBBE
   WLjbbFTgY9ce5BrE6aQULFBr2eZdRwx1zQ1+BtFu9esk2wpnc8gE6U42I
   ZLObOm5WBEcoJ+EDLVwcfIXr2L1hl7wr3UedwUQKMdHbQhF3Je5nz/dFV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="387732233"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="387732233"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 15:32:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="654890571"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="654890571"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 27 Sep 2022 15:32:29 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 15:32:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 27 Sep 2022 15:32:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 27 Sep 2022 15:32:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TN0gxCjPPCSqIJ5s05c3GEDil2slTaXotm58GtI9CI2LSCOwTWpePl6L1xY0twtYijAZ3sIzmidtcnjzXTeA4n9c9aSJmQkBNO+vLt0veGKUHCk6tvqWzYpBA7gJ5G/wg9Vmz7nHWIkn4PKY1//8/a4B6U682WxA7AuzABOpRsKGssWe198C20V2jmg9d4Pd+hKrX4rE+bDyA4jUh65pKWUVIkzITqZsg4i1jTCK7SqYqBNa1v1dqbMLu22kQUC72RSg3m1BhB2Cw6/F/Z58Fmm57afVQiNyFX+QvdfRC1M/4bdJ4budzpFfOAPNlIS4A65ngr6eyHY4Y7HnrxWwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnvZ9bvFllboDECaEYNE8R/zoBnoRGUHF/4x+LaD3rY=;
 b=loFwtGqu1LYDSnrdFGbdkMEcQOOKffxcOH5EHPQr8qUFZpM2UHvzKW+WVvpgfMdzxGw+VtlfdpgMbVcT4EqobLBWW15s6xM85x+zhjR/jNd03qHFpB1MqLJUMj+emETDmWI0IR/bqxe+gzN5eI1YtdlFiBijov9GcO0ZZ0oGig7sR0qiFROobSczd6TpC7YnTU3wWu+1Vwrib032YuZPEWZ7bZVTZV3jej4N5gtoeDokrdJ8L0clKgnbYWz9JnYnEc9M2JQD53ILiA8pphVNQvPo7pYizf98WW0BymyhSW0Z2Mil2PinyN6a+ArSNUh2B4MxWnbHvG9QYsGvV/hmlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CO1PR11MB5169.namprd11.prod.outlook.com (2603:10b6:303:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 27 Sep
 2022 22:32:19 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::d145:9195:77f:8911]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::d145:9195:77f:8911%7]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 22:32:18 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Babu Moger <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: RE: [PATCH v5 09/12] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes event configuration
Thread-Topic: [PATCH v5 09/12] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes event configuration
Thread-Index: AQHY0q96nFKX1Z/fS0iuDCz8lBf3QK3z28Zw
Date:   Tue, 27 Sep 2022 22:32:18 +0000
Message-ID: <IA1PR11MB6097F93E6975B4FAAE3BA1599B559@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431039972.373387.17483031820875867626.stgit@bmoger-ubuntu>
In-Reply-To: <166431039972.373387.17483031820875867626.stgit@bmoger-ubuntu>
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
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|CO1PR11MB5169:EE_
x-ms-office365-filtering-correlation-id: 6e150eac-b1ba-4c86-8d69-08daa0d82319
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RHp8rS+W+e9dptjrmHbA07cujc9MqhIl1oLI0D4RDtfsEc4fxMQYQ1eHyKnPM71ZGzHjZ6WZfnK65sCpb84b+OVH6QNhwoE19AArEdEbqdeB3AZddC+0OA78Eln9TWi+/IRUjLDThf87+1gj+Wr8lHfhbHD8nq6Eapep5gO898w39Ou5G21X5Ul7X0XBKNtGziopWEjO4NuEqnnw39aOp1l9VqV2Nz0z6hgw7D2vN34fkIGGC190IS7HqUBeJco/uSQC+Aj/+0+Ft6KlscMygabdq8bi52jiWqmsxrQFtd5OXkXK86FW3OwRhooGTAssDzrtKzm4Zrn0bCW/SfBdghs8pUtqu3V1qQ4jOH212bgJWkzpw3GkkBV+iIm6eLdaz1F2joDNR0+ZSjD11T2aWd5jqIOWBo4/e834J3Kq7si5WMhATyoSUuGfB6DOrb2f7ocLRKf8RtAZiIEExBe7wI4MlBxFNoZKkK/gGQiecIBNZhl3YBDjY/YqS3f6MGhQAUwkvq+0HnVn7wt6buH2VEn+CdmxmYE4Prygt4rwdKS0H/Nh43nVxXiTgbSXUKriPjs0oK15pocLxD/EzNOOWNlqq8l4N7o89nCaFE5AZIzMCWzuyZFTXjuojyXZFj4JTSt8i3SET2GbhpBDewrfGq/DErPbymC6V3pawxlYAT8Rg9KLflEzO3BIHtBA1RZ7yfbV8d7vvaZoG6A+cZJYR8gRZ/kt3UATzRvg2R8xbmQa4QQJdLFxBdWDaZSfMLwPp64cHJswZTdaZ9Kq9whdMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(5660300002)(66946007)(8936002)(122000001)(83380400001)(38100700002)(2906002)(110136005)(71200400001)(316002)(82960400001)(54906003)(33656002)(26005)(86362001)(38070700005)(7696005)(9686003)(4326008)(55016003)(186003)(52536014)(6506007)(41300700001)(66556008)(7416002)(64756008)(66446008)(478600001)(8676002)(66476007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXhyc0hwSDdQUGtOKzZmbld5L3FGKzBMZ1VFRVZPdUE1TWVMaExxbUg1YWl0?=
 =?utf-8?B?YWs3OVB2UU92QkZnc3gxVDlBbXdvQ09nUmVia1ZkRnhXSVZXTlVXMk1NNlhT?=
 =?utf-8?B?SWRYd2FlTE1YczFmM2V1Sml1ZmpMbHNYNTVML21TZnpNQ1JMY3B6WjZiMUVu?=
 =?utf-8?B?d3lvRkxldE5jTWI5YTdENDcrZ2xSSi9XdW1kTFRlS0hMTFVGWkJ5OHMxb2NY?=
 =?utf-8?B?RWhvcTBZUlhlRDIxSHF3YUVqYW5xK093T1VzTVJYajVZVm1UWk9uOWMvVVNt?=
 =?utf-8?B?R2ZaYlB1UHpXdkZMYm5FbzV0dmFiTXpLSHc1WXVYSHRmcS93bi8wZUF2LzFL?=
 =?utf-8?B?TUdZMTNKODBtTE5zclQrRVdWbm1DMWFvaytSdUk2K1IvdWtBWWxHUmZhVVRB?=
 =?utf-8?B?cGdoTUJvNFZ4aTdKTGVCU3ZsTlUvQjM1ZVRxd0ZicUhXUHNHNy9qdTgrQXFn?=
 =?utf-8?B?NUFyVHNMcDFCdU1HVEF0U1NuL2J2aDFGZExLUUx0NStmU1FWWjNiczBMbXhZ?=
 =?utf-8?B?UXhYbno5UzczaWhTTGJnajEwb0xtTkJ2c0VBWE1QNWsxbjMxOFg5dGY0NjVT?=
 =?utf-8?B?VGMvM3ptdVZvbXRUNzZaMlJnTTcxUThkYlZjYUhXT3ZpOTJDOEhrOHNHWXJ5?=
 =?utf-8?B?RlhPN0ZvOG9GU0tqRXZoN2MrbnJ4QTFJZVQ5c1FuSHUzWkk1TDBvTFVUMTl4?=
 =?utf-8?B?ci8zWlVwMUtvdnh5NkJpQ0V6MVhhcGFIdWNCRUpVdlZkZTlkUUxiNmU1dGNq?=
 =?utf-8?B?OGZXNTcxYUxwRzZ4K3NUS3NWUHg1ZG5lVWkzVUh0MENQcGRzMTZkOXh6WmIy?=
 =?utf-8?B?NWdnZFEzc3NkNXVSanl3ajZUZzFpYUVLa2l4MzB0L0YvVmc2TEhRTVJUbWtt?=
 =?utf-8?B?dCsxNCswSkxDMDJWRmRBZjdUbml1U2sra1drTnUyZlpGM1dmZXl6ZjYzWFNM?=
 =?utf-8?B?VHVzTkw0c0hEMUptdjUwTDlJbDNtU3k1T3ZWTXM5UTBFd1B0UlRtZStYYnRk?=
 =?utf-8?B?NGN0WHNMNmM1YVRrclNBVmFxTCt3cjBqTk9JbEZNaGxMM2FPNkhQdHpZYWJM?=
 =?utf-8?B?MlVZRXRhZUE4cWpCT3JVNElwOEEzdWJUZ1hyc2QrZElDU1c1WGlpNkdzazFY?=
 =?utf-8?B?ZEZuSnN3Tkh3Q21DQzdGMVp3M0FxdXBJOVJEeHlGbmRJOGtvY1paZHJ3emM0?=
 =?utf-8?B?a0syZlZuQWFQaHNmWmtpczNyMm9SdlAvUWNnOW9FNXo0TldZS1Z1MnNNdFU5?=
 =?utf-8?B?KzM3dE5OUUoycFp6NEY5eWZpMFBuVzQ4cXFidDJ5VnFicUJkdFA3UVk2UFNq?=
 =?utf-8?B?TWhyV3lhZytzZ3pWZkt5VFNqVlFXRDVFQVV6S3ZkV2JVYzJwNVM2WUF4OEhl?=
 =?utf-8?B?cFdjOHFsdUdtNE5rK3ZUVEdqcW5KaVluMnloNzh3b3pLNGRFK2licVovQmRn?=
 =?utf-8?B?cGpOQWtsaC9FcWEzSFFjayt1b1dvdWtkcVB1VUllMk12NjdBVnBiYzk3MW5q?=
 =?utf-8?B?amZIMWtFMkJiUW9JMm9PT2VtU1l5UlZpRG8raFc0Tm1LQmJ3dlRlS2pCTitj?=
 =?utf-8?B?d0t1NkI5Y3pVcWNHZlA4S2VtMTNVWjltVE1nWlBSMEF4VmVxYlQzb2lUUTdY?=
 =?utf-8?B?QmtPWkhpUEorcVJ1K1FBM2QrUE00bjBjbXVmeTdKSXJQOTB4TlJhemFNUTFz?=
 =?utf-8?B?ZUsxQ1A5d3dtQ0pXTGtJNXlVK1NyM2x1ck9OZUpOaWN3endvZzNSZXZJRGpq?=
 =?utf-8?B?UnNxMVJ3c0MwOUh2Tk5iRVNXSnBVUXdCM2F5Wng5M2lDclhKTjJua1QwSFZs?=
 =?utf-8?B?VVlObGMxRWRySmlweUhEcFQzek1Fb0NrM29uM05TbWhsRGRCMnQxMVpYL2Fy?=
 =?utf-8?B?eVBKcjRRdHZyKzZQTFNkQmRIYjNHMHZmbm1YNXJDaEZqYXZEYkFMcmkyU2dH?=
 =?utf-8?B?bUkwRzZRNVVFNUR1T1NaQnVFcnBHa2lRcHNCaXVuZWtlaUJ1STZzV1NXdm5N?=
 =?utf-8?B?R3U5SUxjckZIbzN1VUIyNnpIT09ESEZ5QXVzZVNpRDV4TXVFbU1tMkR4RkVX?=
 =?utf-8?B?UnpROENEampZbElBVS9oRkRkRXlOWTQ2cCtqZmg2ckQ0eGEzR3lONWtBNWJZ?=
 =?utf-8?Q?EXtnMKugEmOCdVKJnVCrzzzbv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e150eac-b1ba-4c86-8d69-08daa0d82319
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 22:32:18.8135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4sEClD213ZkrsJ9dOBhiHaJq5YphQhemWt3Mum7PLmjsdnHBrzqhkpsOIx6qgg71UOY+k7OhvmcFhQ70d3aowQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5169
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJhYnUsDQoNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9y
ZHRncm91cC5jDQo+IGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMNCj4g
aW5kZXggMjdiZjZhZGUwZGJmLi5jMWQ0M2QwMzg0NmEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2
L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9j
cHUvcmVzY3RybC9yZHRncm91cC5jDQo+IEBAIC0xNDkxLDYgKzE0OTEsMTQ0IEBAIHN0YXRpYyBp
bnQgbWJtX2xvY2FsX2NvbmZpZ19zaG93KHN0cnVjdA0KPiBrZXJuZnNfb3Blbl9maWxlICpvZiwN
Cj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICt2b2lkIG1vbl9ldmVudF9jb25maWdfd3JpdGUo
dm9pZCAqaW5mbykgew0KDQpTaG91bGQgdGhpcyBmdW5jdGlvbiBiZSBzdGF0aWM/DQoNCj4gKwlz
dHJ1Y3QgbW9uX2NvbmZpZ19pbmZvICptb25faW5mbyA9IGluZm87DQo+ICsJdTMyIG1zcl9pbmRl
eDsNCj4gKw0KPiArCXN3aXRjaCAobW9uX2luZm8tPmV2dGlkKSB7DQo+ICsJY2FzZSBRT1NfTDNf
TUJNX1RPVEFMX0VWRU5UX0lEOg0KPiArCQltc3JfaW5kZXggPSAwOw0KPiArCQlicmVhazsNCj4g
KwljYXNlIFFPU19MM19NQk1fTE9DQUxfRVZFTlRfSUQ6DQo+ICsJCW1zcl9pbmRleCA9IDE7DQo+
ICsJCWJyZWFrOw0KPiArCWRlZmF1bHQ6DQo+ICsJCS8qIE5vdCBleHBlY3RlZCB0byBjb21lIGhl
cmUgKi8NCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gKw0KPiArCXdybXNyKE1TUl9JQTMyX0VWVF9D
RkdfQkFTRSArIG1zcl9pbmRleCwgbW9uX2luZm8tPm1vbl9jb25maWcsDQo+IDApOyB9DQo+ICsN
Cj4gK2ludCBtYm1fY29uZmlnX3dyaXRlKHN0cnVjdCByZHRfcmVzb3VyY2UgKnIsIHN0cnVjdCBy
ZHRfZG9tYWluICpkLA0KPiArCQkgICAgIHUzMiBldnRpZCwgdTMyIHZhbCkNCj4gK3sNCj4gKwlz
dHJ1Y3QgbW9uX2NvbmZpZ19pbmZvIG1vbl9pbmZvID0gezB9Ow0KPiArCWNwdW1hc2tfdmFyX3Qg
Y3B1X21hc2s7DQo+ICsJaW50IHJldCA9IDAsIGNwdTsNCj4gKw0KPiArCXJkdF9sYXN0X2NtZF9j
bGVhcigpOw0KPiArDQo+ICsJLyogbW9uX2NvbmZpZyBjYW5ub3QgYmUgbW9yZSB0aGFuIHRoZSBz
dXBwb3J0ZWQgc2V0IG9mIGV2ZW50cyAqLw0KPiArCWlmICh2YWwgPiBNQVhfRVZUX0NPTkZJR19C
SVRTKSB7DQo+ICsJCXJkdF9sYXN0X2NtZF9wdXRzKCJJbnZhbGlkIGV2ZW50IGNvbmZpZ3VyYXRp
b25cbiIpOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsNCj4gKwljcHVzX3JlYWRf
bG9jaygpOw0KPiArDQo+ICsJaWYgKCF6YWxsb2NfY3B1bWFza192YXIoJmNwdV9tYXNrLCBHRlBf
S0VSTkVMKSkgew0KPiArCQlyZHRfbGFzdF9jbWRfcHV0cygiY3B1X21hc2sgYWxsb2NhdGlvbiBm
YWlsZWRcbiIpOw0KPiArCQlyZXQgPSAtRU5PTUVNOw0KPiArCQlnb3RvIGVfdW5sb2NrOw0KPiAr
CX0NCj4gKw0KPiArCS8qDQo+ICsJICogUmVhZCB0aGUgY3VycmVudCBjb25maWcgdmFsdWUgZmly
c3QuIElmIGJvdGggYXJlIHNhbWUgdGhlbg0KPiArCSAqIHdlIGRvbnQgbmVlZCB0byB3cml0ZSBp
dCBhZ2Fpbi4NCj4gKwkgKi8NCj4gKwltb25faW5mby5ldnRpZCA9IGV2dGlkOw0KPiArCW1vbmRh
dGFfY29uZmlnX3JlYWQoZCwgJm1vbl9pbmZvKTsNCj4gKwlpZiAobW9uX2luZm8ubW9uX2NvbmZp
ZyA9PSB2YWwpDQo+ICsJCWdvdG8gZV9jcHVtYXNrOw0KPiArDQo+ICsJbW9uX2luZm8ubW9uX2Nv
bmZpZyA9IHZhbDsNCj4gKw0KPiArCS8qIFBpY2sgYWxsIHRoZSBDUFVzIGluIHRoZSBkb21haW4g
aW5zdGFuY2UgKi8NCj4gKwlmb3JfZWFjaF9jcHUoY3B1LCAmZC0+Y3B1X21hc2spDQo+ICsJCWNw
dW1hc2tfc2V0X2NwdShjcHUsIGNwdV9tYXNrKTsNCj4gKw0KPiArCS8qIFVwZGF0ZSBNU1JfSUEz
Ml9FVlRfQ0ZHX0JBU0UgTVNSIG9uIGFsbCB0aGUgQ1BVcyBpbiBjcHVfbWFzaw0KPiAqLw0KPiAr
CW9uX2VhY2hfY3B1X21hc2soY3B1X21hc2ssIG1vbl9ldmVudF9jb25maWdfd3JpdGUsICZtb25f
aW5mbywNCj4gMSk7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFdoZW4gYW4gRXZlbnQgQ29uZmlndXJh
dGlvbiBpcyBjaGFuZ2VkLCB0aGUgYmFuZHdpZHRoIGNvdW50ZXJzDQo+ICsJICogZm9yIGFsbCBS
TUlEcyBhbmQgRXZlbnRzIHdpbGwgYmUgY2xlYXJlZCBieSB0aGUgaGFyZHdhcmUuIFRoZQ0KPiAr
CSAqIGhhcmR3YXJlIGFsc28gc2V0cyBNU1JfSUEzMl9RTV9DVFIuVW5hdmFpbGFibGUgKGJpdCA2
MikgZm9yDQo+ICsJICogZXZlcnkgUk1JRCBvbiB0aGUgbmV4dCByZWFkIHRvIGFueSBldmVudCBm
b3IgZXZlcnkgUk1JRC4NCj4gKwkgKiBTdWJzZXF1ZW50IHJlYWRzIHdpbGwgaGF2ZSBNU1JfSUEz
Ml9RTV9DVFIuVW5hdmFpbGFibGUgKGJpdCA2MikNCj4gKwkgKiBjbGVhcmVkIHdoaWxlIGl0IGlz
IHRyYWNrZWQgYnkgdGhlIGhhcmR3YXJlLiBDbGVhciB0aGUNCj4gKwkgKiBtYm1fbG9jYWwgYW5k
IG1ibV90b3RhbCBjb3VudHMgZm9yIGFsbCB0aGUgUk1JRHMuDQo+ICsJICovDQo+ICsJbWVtc2V0
KGQtPm1ibV9sb2NhbCwgMCwgc2l6ZW9mKHN0cnVjdCBtYm1fc3RhdGUpICogci0+bnVtX3JtaWQp
Ow0KPiArCW1lbXNldChkLT5tYm1fdG90YWwsIDAsIHNpemVvZihzdHJ1Y3QgbWJtX3N0YXRlKSAq
IHItPm51bV9ybWlkKTsNCj4gKw0KPiArZV9jcHVtYXNrOg0KPiArCWZyZWVfY3B1bWFza192YXIo
Y3B1X21hc2spOw0KPiArDQo+ICtlX3VubG9jazoNCj4gKwljcHVzX3JlYWRfdW5sb2NrKCk7DQo+
ICsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICt1bnNpZ25lZCBpbnQgbW9uX2NvbmZp
Z19wYXJzZShzdHJ1Y3QgcmR0X3Jlc291cmNlICpyLCBjaGFyICp0b2ssIHUzMg0KPiArZXZ0aWQp
IHsNCg0KU2hvdWxkIHRoaXMgZnVuY3Rpb24gYmUgc3RhdGljPw0KDQo+ICsJY2hhciAqZG9tX3N0
ciA9IE5VTEwsICppZF9zdHI7DQo+ICsJc3RydWN0IHJkdF9kb21haW4gKmQ7DQo+ICsJdW5zaWdu
ZWQgbG9uZyBkb21faWQsIHZhbDsNCj4gKwlpbnQgcmV0ID0gMDsNCj4gKw0KPiArbmV4dDoNCj4g
KwlpZiAoIXRvayB8fCB0b2tbMF0gPT0gJ1wwJykNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwkv
KiBTdGFydCBwcm9jZXNzaW5nIHRoZSBzdHJpbmdzIGZvciBlYWNoIGRvbWFpbiAqLw0KPiArCWRv
bV9zdHIgPSBzdHJpbShzdHJzZXAoJnRvaywgIjsiKSk7DQo+ICsJaWRfc3RyID0gc3Ryc2VwKCZk
b21fc3RyLCAiPSIpOw0KPiArDQo+ICsJaWYgKCFkb21fc3RyIHx8IGtzdHJ0b3VsKGlkX3N0ciwg
MTAsICZkb21faWQpKSB7DQo+ICsJCXJkdF9sYXN0X2NtZF9wdXRzKCJNaXNzaW5nICc9JyBvciBu
b24tbnVtZXJpYyBkb21haW4gaWRcbiIpOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+
ICsNCj4gKwlpZiAoIWRvbV9zdHIgfHwga3N0cnRvdWwoZG9tX3N0ciwgMTYsICZ2YWwpKSB7DQo+
ICsJCXJkdF9sYXN0X2NtZF9wdXRzKCJNaXNzaW5nICc9JyBvciBub24tbnVtZXJpYyBldmVudA0K
PiBjb25maWd1cmF0aW9uIHZhbHVlXG4iKTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0K
PiArDQo+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeShkLCAmci0+ZG9tYWlucywgbGlzdCkgew0KPiAr
CQlpZiAoZC0+aWQgPT0gZG9tX2lkKSB7DQo+ICsJCQlyZXQgPSBtYm1fY29uZmlnX3dyaXRlKHIs
IGQsIGV2dGlkLCB2YWwpOw0KPiArCQkJaWYgKHJldCkNCj4gKwkJCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gKwkJCWdvdG8gbmV4dDsNCj4gKwkJfQ0KPiArCX0NCj4gKw0KPiArCXJldHVybiAtRUlOVkFM
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgc3NpemVfdCBtYm1fdG90YWxfY29uZmlnX3dyaXRlKHN0
cnVjdCBrZXJuZnNfb3Blbl9maWxlICpvZiwNCj4gKwkJCQkgICAgICBjaGFyICpidWYsIHNpemVf
dCBuYnl0ZXMsIGxvZmZfdCBvZmYpIHsNCj4gKwlzdHJ1Y3QgcmR0X3Jlc291cmNlICpyID0gb2Yt
PmtuLT5wYXJlbnQtPnByaXY7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCS8qIFZhbGlkIGlucHV0
IHJlcXVpcmVzIGEgdHJhaWxpbmcgbmV3bGluZSAqLw0KPiArCWlmIChuYnl0ZXMgPT0gMCB8fCBi
dWZbbmJ5dGVzIC0gMV0gIT0gJ1xuJykNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKwly
ZHRfbGFzdF9jbWRfY2xlYXIoKTsNCj4gKw0KPiArCWJ1ZltuYnl0ZXMgLSAxXSA9ICdcMCc7DQo+
ICsNCj4gKwlyZXQgPSBtb25fY29uZmlnX3BhcnNlKHIsIGJ1ZiwgUU9TX0wzX01CTV9UT1RBTF9F
VkVOVF9JRCk7DQo+ICsNCj4gKwlyZXR1cm4gcmV0ID86IG5ieXRlczsNCj4gK30NCj4gKw0KPiAg
LyogcmR0Z3JvdXAgaW5mb3JtYXRpb24gZmlsZXMgZm9yIG9uZSBjYWNoZSByZXNvdXJjZS4gKi8g
IHN0YXRpYyBzdHJ1Y3QgcmZ0eXBlDQo+IHJlc19jb21tb25fZmlsZXNbXSA9IHsNCj4gIAl7DQo+
IEBAIC0xNTk0LDYgKzE3MzIsNyBAQCBzdGF0aWMgc3RydWN0IHJmdHlwZSByZXNfY29tbW9uX2Zp
bGVzW10gPSB7DQo+ICAJCS5tb2RlCQk9IDA2NDQsDQo+ICAJCS5rZl9vcHMJCT0gJnJkdGdyb3Vw
X2tmX3NpbmdsZV9vcHMsDQo+ICAJCS5zZXFfc2hvdwk9IG1ibV90b3RhbF9jb25maWdfc2hvdywN
Cj4gKwkJLndyaXRlCQk9IG1ibV90b3RhbF9jb25maWdfd3JpdGUsDQo+ICAJfSwNCj4gIAl7DQo+
ICAJCS5uYW1lCQk9ICJtYm1fbG9jYWxfY29uZmlnIiwNCj4gDQoNClRoYW5rcy4NCg0KLUZlbmdo
dWENCg==
