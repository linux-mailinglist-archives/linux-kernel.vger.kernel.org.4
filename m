Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ADA60ECE1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 02:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiJ0ANi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 20:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiJ0ANc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 20:13:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D00D4A35
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 17:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666829611; x=1698365611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HomORYEVzZGl/pDo0HaRvfgSmwhwe1hGCcyhziP//G8=;
  b=RJxgIuvK0NQwDOIaNuRBBUa9bO13TKQae3aPA75W+UJQbLh4/MYxDk1Q
   PhKR9S/taAVXjoAZBvgXmOn3V8oMtpac2KyoewL27WDfFHwa0rUddanKc
   pjfFAQ6e6+6zZJs5gkMkFsjZmjHjTvN+ICJWsB+RiI2rKHfgrvgf/2nEt
   na4khmT+ak5xuMbbeNFWSNmjVbyicvSAHxO4WSOWX3Use5f+ZOzmfg6tU
   dj6n0Her39KAxBv8lMkolMFR8CTQ3edC/I68ox/5M/0x1cClG7sWwmSbx
   mpHPzcDeQungLHCC8+Ar++0YMXCJyQdaGqFfDtyQiReV9XvuyoItMvnDx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="309787800"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="309787800"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 17:13:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="695586966"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="695586966"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 26 Oct 2022 17:13:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 17:13:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 17:13:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 17:13:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfssxKxObwIxu4ZUWHgf/LPFRMHXqZQ3LJ6ck3hRUMUe+sqP2sMwcKgE0YrcN4MB2SSal2DYw8H0rgJH3I1VxOO1IvNYt6lk3cuxCw9MUDzVFYKmccMscJgS3JGLA8QukEPEnqxTBmHYeAvdmDPsj/77EPp9EkIR3x46WyCnhyLuqpOxF7bGVzT0g5fJYVVD/xGLtd+vddKxVeAjdfFrRywYOoU45pZKoV/lHcm9YC5G+GSHJV1UB/S7X+YEOxUt7tzAmwFVi+/5cR5TMzq62nDu3AFzwKA0I4AuZeqGz/YnAQPTaW8+XwLXJEBvIyDi7AR92s3JtaPC+TfXHElVzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HomORYEVzZGl/pDo0HaRvfgSmwhwe1hGCcyhziP//G8=;
 b=iA007jowrVl3nzBgRKAx7GqZzsyIHnYPphLIDRVISSZkaryaZiz9bktRG5nnfLzNwhIi50BzHLXbOI4rYYOpAn8V/z5m+tG+I/atAUjnACOv/MkZ7oFSWur3WMHe5kg34c0vSOSADe+gpuT5A4NmuQ8+jv/g1+DlQPpH3oix6XOP5O2d7jdw20iENjupsyYMjEdwsrGtTou/scXO3u2iLqPlgE0dhirEaMyvLr7kbpMQ63DaQduIpVHzS5tiMPtecZiI9blyPUHCVaBeGVA74fTQ+wyZQhd7ww8bNM9h8kOl4qTUaj3emYDDhdV3arFSHaQTQvJ7UEyi0x7ir9oKpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22)
 by PH7PR11MB6427.namprd11.prod.outlook.com (2603:10b6:510:1f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 00:13:28 +0000
Received: from CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::a351:42c7:fffd:fe88]) by CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::a351:42c7:fffd:fe88%7]) with mapi id 15.20.5746.027; Thu, 27 Oct 2022
 00:13:27 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "C, Balamurugan" <balamurugan.c@intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Chao Song <chao.song@linux.intel.com>,
        "Kai Vehmanen" <kai.vehmanen@linux.intel.com>,
        "Wang, Rander" <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        "Song, Gongjun" <gongjun.song@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Reddy, Muralidhar" <muralidhar.reddy@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Ajye Huang <ajye.huang@gmail.com>,
        "Peter Ujfalusi" <peter.ujfalusi@linux.intel.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>
Subject: RE: [PATCH 2/2] ASoC: Intel: sof_rt5682: quirk auto detection
Thread-Topic: [PATCH 2/2] ASoC: Intel: sof_rt5682: quirk auto detection
Thread-Index: AQHY6Qr4dnRepLZ3yUme7FfMkNEtiK4hIrQAgAAxQoA=
Date:   Thu, 27 Oct 2022 00:13:27 +0000
Message-ID: <CY5PR11MB6257D168A60B712088BC7CF797339@CY5PR11MB6257.namprd11.prod.outlook.com>
References: <20221026071409.3235144-1-brent.lu@intel.com>
 <20221026071409.3235144-3-brent.lu@intel.com>
 <6916c126-c710-330a-ffcd-50dd3cdc47d3@linux.intel.com>
In-Reply-To: <6916c126-c710-330a-ffcd-50dd3cdc47d3@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6257:EE_|PH7PR11MB6427:EE_
x-ms-office365-filtering-correlation-id: c7b95f02-e7ec-42e6-9a16-08dab7b01278
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PLjPRAaLX1D0zsAuZoID++765nDxBfDv08AZFJYxB0jRm+DWzS1dXDIUYj6QmyKIscqlsDwG8MXeDsGJ/57lQPsMtcfZmJXAlMMHAFx/nXD/dQLGFBgZFvkMsBRn6pBmTtRxKLVR4Z/gf8qSlianH9UvHzjUxMLfNfiSTl8vSbXTvAOhIeoAIpdU1d/smDpO0lYagnUIrYLgFPsC5obFBBgOxQqSbhLj1ui3R4S9yu+zJeXPGnlU/qEKk/BIO9BSB8jWmlbWR8FTtaq8ZqUXFWpubOzML3Oa0oS6NRh2lBvp7PMeWg18z6J0w8AyPz97ARMQ7kjbCkknGi/9XMTP/h6KYvVEcs1jNU4z5E0/XiNtxzIg7b3yJJC1+Ki7I1E1eDVfsdctVganb1U1alJsNtUES7KmHKq0PXYj95NsgQI9yERcD+5Og3O4iRnIEDPT5wP5f9L93CYo7g4/iDxmP+woKjGxCIiDxjDwBjS4F/d4/XbKH1sD/TaMr7CsHy5XOfeO4A8hgY5fuiUdNaSgl80Wpz+I5OwOW0hI18zDPZdiOpUUG78reoYV7pyd2hllxrfO0KGl7XUPLvZHWaC2YDg4VD4FU3TeprnEdrVcSomyd5XTERhF5RBbSR9gC5+5diQQzCazv7mTdttAgbE7vEI/NTj0z0sI4+PY9gEimeLPxs5/18YggNnryJJ/UrpiY91wkWtISokRI/mpVKgTVEklkp0c9DbascpNzY/xY7PaZmWA3xPmhHWijgwLQZVAEAz6seRvJ+3QomtsTM4rO8rPO7ZRAC0uAaPpF+taBpQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6257.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(478600001)(7696005)(6506007)(54906003)(71200400001)(26005)(9686003)(38100700002)(122000001)(38070700005)(86362001)(33656002)(110136005)(82960400001)(186003)(83380400001)(66946007)(316002)(76116006)(4326008)(66446008)(64756008)(66556008)(66476007)(2906002)(52536014)(5660300002)(8936002)(55016003)(41300700001)(7416002)(8676002)(11716005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGw3THB5ZjZvMjZaTXBYUlU2QnJlZGcrd3UrNk1SaFJzSTFmUjJicWNraStr?=
 =?utf-8?B?b2tsd2R2NG5BMWpERG9qWWE1YlA1ZDdlckdnWUxvTEpianhBbDlzYlgzMW1H?=
 =?utf-8?B?WXJsdDc5a2YxRTVYNlJEZTVTRzdGdlczUVE0b0crakV6Sjh1dUVDekpPS2hr?=
 =?utf-8?B?S0w4cFVzc2FyYlE0ZG5MNVhuZVc4dnQrdDJRb0s4NmRORXdYbWJpMXJUb0Zr?=
 =?utf-8?B?dFc3RlJ5YkZUMTlCdmwwdnhXa3ZNMllmcGpqSE5DQVNid2puL1RKaHNpcjgz?=
 =?utf-8?B?emEwN1lvSWdaNU1lcGV6a1drVlg3S3BadjZ2NVN1V3dnOGFyU2U0SXJVc3BF?=
 =?utf-8?B?TWZteXhDOTAvVldwV1hZS2dLNk9ZVmRXSGRGU0hDYm5lczh2bWljL2FpTjY1?=
 =?utf-8?B?a1llMGdjcFp1Vk5zRGdsTWtKK1VCd3RqdDg3TCtLYng3VnR2b1hWMFlqWmVT?=
 =?utf-8?B?K1ZZODZCZXlYb29abjZJZUl5SERFOXpkWWM2SmVPVm5ic09vUDJFMmJUZGM5?=
 =?utf-8?B?eEpyOGpUSGVGQTVVWnFUN2VFU1pPYmxQMjc5c2Nrd3RHenVVM0RjOFJoRHFW?=
 =?utf-8?B?SUNkWUR5Sjd4ZHk4MEdhbHEzak1PRkliOEtmZTYyTmU0YjJ3clplbE9kS3Q5?=
 =?utf-8?B?OU0yYVp4YnNpRlNmcnByWTNJZW1DQ0lHT1V4czR4L1h4OTBJb1k0cmxScTg2?=
 =?utf-8?B?RHdUQ1J1RFYwZlpSdkdlSlMxSkt6aExJWVlYeXN1aHhMaVRxTS9MdHRFVnBq?=
 =?utf-8?B?YWt4ckZUQVZtbEI5TSs0b2dTa1dzU21jOGh6VDMwSXl1cVNNUHRPZVVCYmZF?=
 =?utf-8?B?RU5MVzFXM3FlVy9LZTM5blJoWC9rOHhHUDlqaEdnNkZtVmNtbXVJU1JodDUx?=
 =?utf-8?B?UFpBVEZVNzQ5Y0JVV0JvY016dXZRWXl0QXVJdlhyR2JVaTNuWHNHVXcwNXgx?=
 =?utf-8?B?RmY4TUFNREJxc05jaEhsRDZUOEZlME9YTkgyTHpHWEN1Vnp4VndCTStkbFZ4?=
 =?utf-8?B?M3ZSK09YWWF6Mk5RZzZPZHgvR2Q3dUU2U09zZ3NhQU11bnRKUW56R1NPd3VK?=
 =?utf-8?B?dUNMV0toQkRiNHlJeWk2MUhXTnVKY0VsNE1mOEU2VmFVOWZvOGVnZmE5M0dH?=
 =?utf-8?B?SlZBelNlaTdHVEJIVE9PK1lER0dyUFdBamM2Ym9UUVRNOXA0V0REVzliTHJn?=
 =?utf-8?B?TSs4bVV3SjAyS1M1K2FXTnByYnlaa0xCVld0NmxJN0tzdFhXcmp3ZVdaM2Jt?=
 =?utf-8?B?T2I1ZWsvNDEyYS9rTFlhaHhOZ2hNdXhpc3VWMTJtaGVqbEVsTUloanYvN3dD?=
 =?utf-8?B?Vk9xRlg3Q1Bmc2pHeEExYU15VTRIMTlYV2kvUTlkNmE5d1F2V3hxWWZPaTZZ?=
 =?utf-8?B?MmVGYy9jZGF0V2t1dXNmNFNjWWUyRHRLai9ob3FZTUpNUmtlSDZ2RnlqNDJN?=
 =?utf-8?B?Qy9rU0IxdStoVnFUeTBDTXpVUEp3SDI4YktxOFVhWFBQcFFscXVIWWpHUEd0?=
 =?utf-8?B?cVRINTFPdEllTzBTU1FCbyttdlpnYlh4RjZqYVh6NGhtY3ZCMDE1SVpEOTMv?=
 =?utf-8?B?VzNFdldYVTh2Mm9ZL01tQVRXRURia3RMdGRPTzdkYncvb2ZhQXBFNWxpWXgv?=
 =?utf-8?B?SGRNNmFKTWEwTDl6VzBvMXRqaEpLY3hUTEYrdk00MzhDSWozckZBTURNem8x?=
 =?utf-8?B?SjlOWW56RjFDb0NVbEZOaFRxMGt2M2R4aUk2YlJ6bzZaZVhxcEtqRDgyZnk2?=
 =?utf-8?B?a0pYdkFrTVJMT1BXSDRWdHUxQjh4NWxGd2JpZ0tFTzNDSkJ3MWorMHpzVk5T?=
 =?utf-8?B?TVdPeHZETjdhMmovbjlpUXVLMlNxbllJaFhYSnJlajZWWHZJUUp6SzZqSXBz?=
 =?utf-8?B?Ky9XQXYvM1FuNDBDamNxbEtMb1Q4bjBFTis4eGtoVG9yMEVMdHdnUGY0YzBM?=
 =?utf-8?B?aXExcHZPbmxXMXJvNk9vd204L21FZXZ6Mmp5OHUvRkpuWXVaU1ZhYWRkMDd5?=
 =?utf-8?B?ZkFaVm5sWVRCUGNvdjNQZGhpUHdNMW1LM2JEb3E4bE12NEplcWNRVHRBQUpz?=
 =?utf-8?B?cFZuMGJlbVpXTGI5SndpWks1SFZ3dFp5VHhGSTZTOXBQU21UMlNkTVEzelpK?=
 =?utf-8?Q?WMKwcD2ncAls+8ZRkZjJzCsj6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6257.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b95f02-e7ec-42e6-9a16-08dab7b01278
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 00:13:27.8211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RlCBBfruw8Q0juoJUswcH4oAA4zYirwgyWUzf3U4biJDTX1U/XrWvsaNYfXKE/ZfUUfZQ1Hin0E7nmH+QDcgEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6427
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gVGhpcyBpcyBhIGJpdCBjb25mdXNpbmc6IHRoaXMgcXVpcmsgZG9lcyBub3Qgd29yayBm
b3IgVm9sdGVlcg0KPiANCj4gCXsNCj4gCQkuY2FsbGJhY2sgPSBzb2ZfcnQ1NjgyX3F1aXJrX2Ni
LA0KPiAJCS5tYXRjaGVzID0gew0KPiAJCQlETUlfTUFUQ0goRE1JX1BST0RVQ1RfRkFNSUxZLA0K
PiAiR29vZ2xlX1ZvbHRlZXIiKSwNCj4gCQkJRE1JX01BVENIKERNSV9PRU1fU1RSSU5HLCAiQVVE
SU8tDQo+IE1BWDk4MzczX0FMQzU2ODJJX0kyU19VUDQiKSwNCj4gCQl9LA0KPiAJCS5kcml2ZXJf
ZGF0YSA9ICh2b2lkICopKFNPRl9SVDU2ODJfTUNMS19FTiB8DQo+IAkJCQkJU09GX1JUNTY4Ml9T
U1BfQ09ERUMoMCkgfA0KPiAJCQkJCVNPRl9TUEVBS0VSX0FNUF9QUkVTRU5UIHwNCj4gDQo+IAlT
T0ZfTUFYOTgzNzNfU1BFQUtFUl9BTVBfUFJFU0VOVCB8DQo+IAkJCQkJU09GX1JUNTY4Ml9TU1Bf
QU1QKDIpIHwNCj4gCQkJCQlTT0ZfUlQ1NjgyX05VTV9IRE1JREVWKDQpKSwNCj4gCX0sDQoNCkkg
Y2hlY2tlZCBWb2x0ZWVyIHJlZmVyZW5jZSBraXQsIGl0IHNob3VsZCB1c2UgU1NQMSBmb3IgYW1w
bGlmaWVyLiBJdCBzZWVtcyB0byBtZSANCnRoaXMgcXVpcmsgaXMgZm9yIHNvbWUgY3VzdG9tZXIg
dmFyaWFudHMgd2hpY2ggaW1wbGVtZW50cyBNQVg5ODM3MyBvbiBTU1AyLg0KDQo+IA0KPiBTYW1l
IGZvciBCcnlhIGFuZCBhbGwgdXNhZ2VzIG9mIFNTUF9BTVAoMikNCj4gDQo+IA0KDQpJdCdzIGEg
Y29tcHJvbWlzZSB0aGF0IEdvb2dsZSBpbXBsZW1lbnRzIGFtcGxpZmllcnMgb24gU1NQMiBvbiBC
cnlhIHNvIHRoZXkgY2FuIA0KY29ubmVjdCBTRFcgY29kZWMgdG8gU1NQMSBwaW5zLCBidXQgd2Ug
YXNrZWQgY3VzdG9tZXJzIHRvIGltcGxlbWVudCBhbXBsaWZpZXJzIA0Kb24gU1NQMSB0byByZXNl
cnZlIEJUIG9mZmxvYWQgY2FwYWJpbGl0eS4NCg0KPiA+IC0Jew0KPiA+IC0JCS5uYW1lID0gImFk
bF9ydDEwMTlfcnQ1NjgycyIsDQo+ID4gLQkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190
KShTT0ZfUlQ1NjgyX01DTEtfRU4gfA0KPiA+IC0JCQkJCVNPRl9SVDU2ODJfU1NQX0NPREVDKDAp
IHwNCj4gPiAtDQo+IAlTT0ZfUlQ1NjgyU19IRUFEUEhPTkVfQ09ERUNfUFJFU0VOVCB8DQo+IA0K
PiBhbmQgSEVBRFBIT05FX0NPREVDX1BSRVNFTlQgaXMgbm90IGhhbmRsZWQgZWl0aGVyLg0KPiAN
Cg0KSGVhZHBob25lIHR5cGUgd2lsbCBiZSBkZXRlY3RlZCBsYXRlciBpbiB0aGUgc29mX2F1ZGlv
X3Byb2JlKCkuDQoNCj4gPiAtCQkJCQlTT0ZfU1BFQUtFUl9BTVBfUFJFU0VOVCB8DQo+ID4gLQkJ
CQkJU09GX1JUMTAxOV9TUEVBS0VSX0FNUF9QUkVTRU5UDQo+IHwNCj4gPiAtCQkJCQlTT0ZfUlQ1
NjgyX1NTUF9BTVAoMSkgfA0KPiA+IC0JCQkJCVNPRl9SVDU2ODJfTlVNX0hETUlERVYoNCkpLA0K
PiA+IC0JfSwNCj4gDQo+IE92ZXJhbGwgSSBkb3VidCB0aGF0IHRoZSBTT0MgYWxvbmUgY2FuIHRl
bGwgeW91IHdoYXQgdGhlIHF1aXJrIGlzLg0KPiANCj4gTWF5YmUgaXQncyBhIGRlZmF1bHQgdG8g
YXZvaWQgcmVwZWF0cyBvZiB0aGUgc2FtZSBiYXNlbGluZSBjb25maWd1cmF0aW9uLCBidXQNCj4g
dGhlcmUncyBub3QgbXVjaCBlbHNlIHRoYXQgY2FuIGJlIGluZmVyIGZyb20gYW4gU09DIGRlZmlu
aXRpb24gaW4gbGlnaHQgb2YgdGhlDQo+IGNyZWF0aXZpdHkgb2Ygb3VyIGhhcmR3YXJlIGZyaWVu
ZHMgd2hvIHJvdXRpbmVseSBzd2FwIGludGVyZmFjZXMuDQoNCkknbSB0aGlua2luZyBhYm91dCB1
c2luZyBrZXJuZWwgbW9kdWxlIHBhcmFtZXRlcnMgZm9yIHRob3NlIGJvYXJkcyB3aGljaCBkbyBu
b3QNCnVzZSBkZWZhdWx0IFNTUCBwb3J0IGFsbG9jYXRpb24uIE5vdCBzdXJlIGl0J3MgZG9hYmxl
IGZvciBtYWNoaW5lIGRyaXZlciBtb2R1bGUuDQoNClJlZ2FyZHMsDQpCcmVudA0KDQoNCg0KDQo=
