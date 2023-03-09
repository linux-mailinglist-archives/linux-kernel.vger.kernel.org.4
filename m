Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60F76B1881
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCIBIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCIBIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:08:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0321369229;
        Wed,  8 Mar 2023 17:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678324111; x=1709860111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uthU2UR7yGVBNr8szNuxlMb5NKwR2ifj6OmUSKFvU9I=;
  b=J5iETuVzAtft+puzWwg+YBke2jSkPDmTtDcfYBqNXpCvZuSkToSiT8DY
   p1sOxBpPMP7IjQtHskKwVxen9oHf+S85PN6zqCeR0HlVjFpgwYpq1vWBV
   4LR9C+ITOsnTPffklmBfl4Mq3OJlmTrru24bX2BkQU9u9pmFZ4EeKBdUW
   Jy/lADMmQMtaSQLqnD+eFyRrZ6Owygq7JjmTKrFACl+qnMhrW4sh8Nrck
   4FgcHH23LP/Ns5YB/13DnZ+oksm3e/9zvvpBVIk/o1HZu8qHbWeEKEHqO
   6U/BPJ8ji+Wa+5N7YWqVHz7dh+8It0uQXsfOdUuenwBaKz37daPSWySkz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="338657647"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="338657647"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 17:08:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="627171143"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="627171143"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2023 17:08:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 17:08:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 8 Mar 2023 17:08:30 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 8 Mar 2023 17:08:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNf89tQPG/VyKR41MdREt3eG1HsilPFIuLW8BvWSK0pwZJegPjguQU32B+FoC2tC005GNn3oTyZliFOPO2gtfLK7DEZU0yckEeOV4QIZrUKDGljnfqB5XcERnjTrGGJI3Wt0uyJRTlFZALp0sw5Q67WXVNTZp7UT9N4pB1+QSMX1lo2A1sAFrGyuvzZvdb5F4QiBdWeFnDV+gfVZpFPO2cTc812z/AJONaY1LlNMIt/zvqGmc1mqlp+BhuCkEeUzKotGSsllftXYsMdiDh/90eBYMa1uS0wG56aqS8OS9EDfeiJAugl98GETtWA0wW0EfFUGDhKmOq8NxsM4F4l35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uthU2UR7yGVBNr8szNuxlMb5NKwR2ifj6OmUSKFvU9I=;
 b=YVfZqbuXGNxlLK1/TgOsJMy2epOOuDSvPC2qdtO5HHV9e74w3m9KSbEtVakhVl9j159yN/yu4oKO9eTh5mGfzxbqFnGjSaRtzyYuU86Uk3pW1HFev5ZXuBnH7uDujnJTSDWN9KeLOycWATavwbOigMBTTv+0WVLrmerE0SJGlmDzcev31hwhNUVve1jo7NMVzw7IbOBu/gvO7mnfQ2ABnD1VTKwDJNDIyxU7H33OBBSOOstZ8jN6m5F8L9T1cHGOF8FrA9x9iALK993FRkFOjQLqcK9qryEwtoxRyHKs/y9+MVhWmnc/isUsPY/W1f39oYLjLTlKAH2eBdE6CmLoQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by SA2PR11MB5100.namprd11.prod.outlook.com (2603:10b6:806:119::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Thu, 9 Mar
 2023 01:08:28 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6%4]) with mapi id 15.20.6156.028; Thu, 9 Mar 2023
 01:08:28 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Thread-Topic: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Thread-Index: AQHZP1HlDdnw2M/ymEOJ6dDL3JcZGa7l1BmAgAACFoCACULV0IAABnKAgAABmnCAAAmBAIAClEUg
Date:   Thu, 9 Mar 2023 01:08:28 +0000
Message-ID: <DM6PR11MB43166ADFA7D0775BA2C223C78DB59@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <Y/8qJzScTfFucpP9@kekkonen.localdomain>
 <ae28faf8-c8a4-3f75-08d0-8e5233f2fa5d@redhat.com>
 <DM6PR11MB4316F4B72F98ADBF577412378DB79@DM6PR11MB4316.namprd11.prod.outlook.com>
 <ZAb2G7kqsEvrBhpG@kekkonen.localdomain>
 <DM6PR11MB4316B4F865472CA998E696FC8DB79@DM6PR11MB4316.namprd11.prod.outlook.com>
 <4c3ba301-6241-f2f4-f139-b4f4a0cd6223@redhat.com>
In-Reply-To: <4c3ba301-6241-f2f4-f139-b4f4a0cd6223@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|SA2PR11MB5100:EE_
x-ms-office365-filtering-correlation-id: b815b48f-26b0-4bcf-93e0-08db203aca8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pPZFP+51R7KBcUI5tnHUhCHR7LuLlnt28awk2IKWGGoeDhExJFJ6b479I7HMtTBmNo21NYT6MMeWvRFJxyTBIj7sS2ZlrYDRaM8N3H1r1AUkSZOgkeazCUUMl+5a1CaZunySQto0zgJb8UL3WuQF2Uy6oKigNbeBrFs8LjXqbtsd184Tqcz3eCOnoG3gFjN3xb5CxfN9M4305PmJgzra2cKQZqlP3i+aV4gHCzzibk4KsD+rxk/g2IYTgqNwvTDzsklMVMYNtR5fd3Nnyh9e+B7wRTZA0AIJgnvbslqD7/8YJ2WxhW0hMWVoVR7YfLguBz2RwI33fJmmNXyiy9zWOdM5DmMyhEAfWPlyO/1C6hW5EyJnmlpszmN6PJ3e2pxlXCo1TzAjzoQgJSugxFui4wK3wpbpuuhRAmYpz2BOWm5nIGft9yq4DSnMBzcz645b9IpYWwUEw1+ZzCKjNI1g6mLixfQAebJUFDJgOmkvd+GIOiDVUQiiiDS4BL1y4kCQuDk3VpQyHipwG5tnSAhoWay0zfrW28B4XIMV2kbqDtQSy8Fahe4A9w1wwGNRNnufSRw7cWMVErgeZgHFYL6ojlaxNMlRM9lSPMtsoX/0wwoY+u1Vjn/6DISsOTTVuoooMrmFZJe4ioRgyX+X/wlt+bcWtLbpMc7NWZXimE0BgsX/XVb+roYoP6QrdLk2xK51
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199018)(478600001)(76116006)(66946007)(41300700001)(82960400001)(122000001)(64756008)(52536014)(8936002)(66446008)(8676002)(66556008)(2906002)(66476007)(4326008)(38100700002)(316002)(54906003)(38070700005)(110136005)(7696005)(83380400001)(66899018)(71200400001)(966005)(86362001)(186003)(33656002)(9686003)(55016003)(5660300002)(6506007)(53546011)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3h6cG8xWWJ4eHNOMHlocS9DR2Y1T1hvNnd4ZGc4cFJoakpra0JsdGQvT0hW?=
 =?utf-8?B?MGVnVVQxaVFiUGo1bS9kQWxwM0RHOFBPVjRFSW9lYjlSSVJxcmF6ZFdBVDEx?=
 =?utf-8?B?RnF6ZnRHWW1INTRaN0tFeEhlOUplNzV4aEU1V2ZmcFE0ZVhQSFVVdzlDZkVV?=
 =?utf-8?B?ZzJwQ1picVlMc1JMaGx3M1BMSHdSZCt5aHZOOVdUWWE2OVdEM3JuWVFYcFRV?=
 =?utf-8?B?eTlKZGpFejZyV0o3VXdLTUVvYjdsWXRMQlBkaU1LVmJPdVd6Q1doTmpqa0pJ?=
 =?utf-8?B?STVmSXhUb2xpRnNXQ0poMUMxUG9HTlNiWWlxT2taN3Z1eSsxcVBTUGN4cHNj?=
 =?utf-8?B?dGFiMmpUWWxpb3RTUEg2cjRVc21sYVNINnpZNTFOTlQ3d1VxRXoxVkhNK05V?=
 =?utf-8?B?SUZyaW9XWXp2WXozWEdLaUVYa3dQSmc0a2JhYTAwN0xLZENBc2RPVHZtS1Bl?=
 =?utf-8?B?OTFURHg4SGIvazlwbVRqZUVtWFRFTEhGWjJvTm5BQlc4anM5d1ZDb05ZRjd5?=
 =?utf-8?B?U2ozdERTTjRiSjFNeXRHU2s1RFAyeVh1UUhwa0F3S2c4cFZhODducTZ6MHlh?=
 =?utf-8?B?YTF3MWJHUHNhZ1RJaGJsOWhxSThCRTE4MFlhRmxSemJjVlJ3SVN4dlJyQmwy?=
 =?utf-8?B?SGRhV0drWDVKWlRlVTQxd0FCcllBenUzVDhncWg2N2xKRHBPTW93RnA5dFU4?=
 =?utf-8?B?SjRvMkxPK2taQU9FdWhqQ01NZ240UXVWZnNocjBXS21RdEJyVlAxVERpMzE0?=
 =?utf-8?B?emk3SkRRb1QrV3c2UEhUWjRPSkU1V1M3N2UrYmVVRmJUM0ZTbmlYRnRUKzdX?=
 =?utf-8?B?TnVNWDIxWHY1TmIyYk1MQUlhMitncC9qdVlpZmlrUmpFQjRPczdrM2E3Wk9R?=
 =?utf-8?B?M3hDeEtoS3FuMjI2akpZOTJjV0x3MlpLeUlsUTZBcEpqOWt5ZURQdnI0T1pX?=
 =?utf-8?B?QnZnVnhYeFZEMW00RXJ3TnVKRlRBa1JsYlk5TnBGYzF1RkpxMkgyVFBLOTRX?=
 =?utf-8?B?OXByTDZuNUpNaFBaNlZQaHpDYnZvcFhNbVFNMVZKQzZRRC9vV3JFZWdJU0gz?=
 =?utf-8?B?dW1OME5XSkVZb3RaNlJuaUU4RFRjSjNJTUhWUWN3S0VMU3R6bVNSUUlOVVVP?=
 =?utf-8?B?Qkp0Sk1XTXNadDMzK2NPUFhua08wekRoS1NVUXYwT2ZFdFZ6VXJ1MWpETWxt?=
 =?utf-8?B?ODNrdHMzd1ovZ3ZLZ1A4RkFBRXhaTGJ4alh5UFZUb1cyN0F1dVE0YjBrTU5s?=
 =?utf-8?B?OXNubzFNOW4wYWJLeEMrVkFNUGU0SW9aV25MaGxOaWlvOXN4bU9RQWhQb2sx?=
 =?utf-8?B?cWw0U2JrUDUwSkNWYUtWYlVJMkRFSnhzbzIyNTNUdXI1ZTRXSWRYaXpsTTBL?=
 =?utf-8?B?MEh5bHJTdm8wcHd0M2laTXNCYzFKVFBKSlFtTHBxc1I1S21OZXArcHJNTHR0?=
 =?utf-8?B?R1RPT3gwamo1dHBQc1lORGl4b29MZ3RScGRPWXhpV3RwZUE5WGw2UWp2UVlD?=
 =?utf-8?B?dG9HQUhVL3ZOTkpiM2VkVWU1ZWprdXpSYjFFUlNvd0RGUXpLWStrK3Rvalpa?=
 =?utf-8?B?c084eGZzOWZsbDV2Y09LRTE2WENpYjV5bmZxSmxOMzcvL0pISWZjWHJyNnZh?=
 =?utf-8?B?SWJiOWJqdDc1bWhnaThlWXpYS3RYV3NpQVlidFZnWkFLcGNIcm9TbzZkbFJT?=
 =?utf-8?B?a2xtQnA2dlNWd3QzMkdxME4wY2xPNmltem5EaWJRWm1BeTBVQm9jdGVKa01m?=
 =?utf-8?B?Qmh3TUo5TXBvWGE1L3FCNWNuUGJxc3Z6d2hiWmNoWDRnK3FXVlpGTFZFemFR?=
 =?utf-8?B?Ly9ZVVY1Y0ludkhNQzNwMlo4cVZZOXlSaDVtdXd3UCsraElSM3MvR1FhRDRF?=
 =?utf-8?B?b0d6K1Q1T29zTmZXZjJ4Z1J1eVlNaHV4VVRsRlR4ck1oMjZoNjBzVVBVV2pN?=
 =?utf-8?B?U2pNbjAwSk9pSStIQkszOGx5diswQjhwTlpVYkFaWUVXOVFYRUd1eDdlVGsv?=
 =?utf-8?B?SUdLZVduTlQ0WVRVWDd6S1hobVA2d2EzL0hLdW9ZMUQ3WVQ1Z285dkcrK2F5?=
 =?utf-8?B?WGN2L0kxeU1LZmpmOWFaZVZzL0kwcnMzZmlkOFhhRlNsMjZjeHUrUXhRZGNI?=
 =?utf-8?Q?lmdy/loFU97rNK5iWBw/s3bwo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b815b48f-26b0-4bcf-93e0-08db203aca8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 01:08:28.1434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XGqmztYhDq9cEJq7c6QUvvNTu5yX+GkVBIE9er3DS1qi7t/Q0wShA617YGmM8LX29XPHYbrHA8U4D1CJextgDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5100
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFucyBkZSBHb2VkZSA8
aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggNywgMjAyMyA1OjEw
IFBNDQo+IA0KPiBIaSwNCj4gDQo+IE9uIDMvNy8yMyAwOTo0MCwgV3UsIFdlbnRvbmcgd3JvdGU6
DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBT
YWthcmkgQWlsdXMgPHNha2FyaS5haWx1c0BsaW51eC5pbnRlbC5jb20+DQo+ID4+IFNlbnQ6IFR1
ZXNkYXksIE1hcmNoIDcsIDIwMjMgNDozMCBQTQ0KPiA+Pg0KPiA+PiBIaSBXZW50b25nLA0KPiA+
Pg0KPiA+PiBPbiBUdWUsIE1hciAwNywgMjAyMyBhdCAwODoxNzowNEFNICswMDAwLCBXdSwgV2Vu
dG9uZyB3cm90ZToNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+Pj4gRnJvbTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4g
Pj4+PiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDEsIDIwMjMgNjo0MiBQTQ0KPiA+Pj4+DQo+ID4+
Pj4gSGksDQo+ID4+Pj4NCj4gPj4+PiBPbiAzLzEvMjMgMTE6MzQsIFNha2FyaSBBaWx1cyB3cm90
ZToNCj4gPj4+Pj4gSGkgV2VudG9uZywNCj4gPj4+Pj4NCj4gPj4+Pj4gT24gTW9uLCBGZWIgMTMs
IDIwMjMgYXQgMTA6MjM6NDRBTSArMDgwMCwgV2VudG9uZyBXdSB3cm90ZToNCj4gPj4+Pj4+IElu
dGVsIFZpc3VhbCBTZW5zaW5nIENvbnRyb2xsZXIgKElWU0MpLCBjb2RlbmFtZWQgIkNsb3ZlciBG
YWxscyIsDQo+ID4+Pj4+PiBpcyBhIGNvbXBhbmlvbiBjaGlwIGRlc2lnbmVkIHRvIHByb3ZpZGUg
c2VjdXJlIGFuZCBsb3cgcG93ZXINCj4gPj4+Pj4+IHZpc2lvbiBjYXBhYmlsaXR5IHRvIElBIHBs
YXRmb3Jtcy4gSVZTQyBpcyBhdmFpbGFibGUgaW4gZXhpc3RpbmcNCj4gPj4+Pj4+IGNvbW1lcmNp
YWwgcGxhdGZvcm1zIGZyb20gbXVsdGlwbGUgT0VNcy4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBUaGUg
cHJpbWFyeSB1c2UgY2FzZSBvZiBJVlNDIGlzIHRvIGJyaW5nIGluIGNvbnRleHQgYXdhcmVuZXNz
Lg0KPiA+Pj4+Pj4gSVZTQyBpbnRlcmZhY2VzIGRpcmVjdGx5IHdpdGggdGhlIHBsYXRmb3JtIG1h
aW4gY2FtZXJhIHNlbnNvciB2aWENCj4gPj4+Pj4+IGEgQ1NJLTIgbGluayBhbmQgcHJvY2Vzc2Vz
IHRoZSBpbWFnZSBkYXRhIHdpdGggdGhlIGVtYmVkZGVkIEFJDQo+ID4+Pj4+PiBlbmdpbmUuIFRo
ZSBkZXRlY3RlZCBldmVudHMgYXJlIHNlbnQgb3ZlciBJMkMgdG8gSVNIIChJbnRlbA0KPiA+Pj4+
Pj4gU2Vuc29yIEh1YikgZm9yIGFkZGl0aW9uYWwgZGF0YSBmdXNpb24gZnJvbSBtdWx0aXBsZSBz
ZW5zb3JzLiBUaGUNCj4gPj4+Pj4+IGZ1c2lvbiByZXN1bHRzIGFyZSB1c2VkIHRvIGltcGxlbWVu
dCBhZHZhbmNlZCB1c2UgY2FzZXMgbGlrZToNCj4gPj4+Pj4+ICAtIEZhY2UgZGV0ZWN0aW9uIHRv
IHVubG9jayBzY3JlZW4NCj4gPj4+Pj4+ICAtIERldGVjdCB1c2VyIHByZXNlbmNlIHRvIG1hbmFn
ZSBiYWNrbGlnaHQgc2V0dGluZyBvciB3YWtpbmcgdXANCj4gPj4+Pj4+IHN5c3RlbQ0KPiA+Pj4+
Pj4NCj4gPj4+Pj4+IFNpbmNlIHRoZSBJbWFnZSBQcm9jZXNzaW5nIFVuaXQoSVBVKSB1c2VkIG9u
IHRoZSBob3N0IHByb2Nlc3Nvcg0KPiA+Pj4+Pj4gbmVlZHMgdG8gY29uZmlndXJlIHRoZSBDU0kt
MiBsaW5rIGluIG5vcm1hbCBjYW1lcmEgdXNhZ2VzLCB0aGUNCj4gPj4+Pj4+IENTSS0yIGxpbmsg
YW5kIGNhbWVyYSBzZW5zb3IgY2FuIG9ubHkgYmUgdXNlZCBpbg0KPiA+Pj4+Pj4gbXV0dWFsbHkt
ZXhjbHVzaXZlIHdheXMgYnkgaG9zdCBJUFUgYW5kIElWU0MuIEJ5IGRlZmF1bHQgdGhlIElWU0MN
Cj4gPj4+Pj4+IG93bnMgdGhlIENTSS0yIGxpbmsgYW5kIGNhbWVyYSBzZW5zb3IuIFRoZSBJUFUg
ZHJpdmVyIGNhbiB0YWtlDQo+ID4+Pj4+PiBvd25lcnNoaXAgb2YgdGhlIENTSS0yIGxpbmsgYW5k
IGNhbWVyYSBzZW5zb3IgdXNpbmcgaW50ZXJmYWNlcw0KPiA+Pj4+Pj4gcHJvdmlkZWQNCj4gPj4g
YnkgdGhpcyBJVlNDIGRyaXZlci4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBTd2l0Y2hpbmcgb3duZXJz
aGlwIHJlcXVpcmVzIGFuIGludGVyZmFjZSB3aXRoIHR3byBkaWZmZXJlbnQNCj4gPj4+Pj4+IGhh
cmR3YXJlIG1vZHVsZXMgaW5zaWRlIElWU0MuIFRoZSBzb2Z0d2FyZSBpbnRlcmZhY2UgdG8gdGhl
c2UNCj4gPj4+Pj4+IG1vZHVsZXMgaXMgdmlhIEludGVsIE1FSSAoVGhlIEludGVsIE1hbmFnZW1l
bnQgRW5naW5lKSBjb21tYW5kcy4NCj4gPj4+Pj4+IFRoZXNlIHR3byBoYXJkd2FyZSBtb2R1bGVz
IGhhdmUgdHdvIGRpZmZlcmVudCBNRUkgVVVJRHMgdG8NCj4gPj4+Pj4+IGVudW1lcmF0ZS4gVGhl
c2UgaGFyZHdhcmUNCj4gPj4+PiBtb2R1bGVzIGFyZToNCj4gPj4+Pj4+ICAtIEFDRSAoQWxnb3Jp
dGhtIENvbnRleHQgRW5naW5lKTogVGhpcyBtb2R1bGUgaXMgZm9yIGFsZ29yaXRobQ0KPiA+Pj4+
Pj4gY29tcHV0aW5nIHdoZW4gSVZTQyBvd25zIGNhbWVyYSBzZW5zb3IuIEFsc28gQUNFIG1vZHVs
ZSBjb250cm9scw0KPiA+Pj4+Pj4gY2FtZXJhIHNlbnNvcidzIG93bmVyc2hpcC4gVGhpcyBoYXJk
d2FyZSBtb2R1bGUgaXMgdXNlZCB0byBzZXQNCj4gPj4+Pj4+IG93bmVyc2hpcA0KPiA+Pj4+IG9m
IGNhbWVyYSBzZW5zb3IuDQo+ID4+Pj4+PiAgLSBDU0kgKENhbWVyYSBTZXJpYWwgSW50ZXJmYWNl
KTogVGhpcyBtb2R1bGUgaXMgdXNlZCB0byByb3V0ZQ0KPiA+Pj4+Pj4gY2FtZXJhIHNlbnNvciBk
YXRhIGVpdGhlciB0byBJVlNDIG9yIHRvIGhvc3QgZm9yIElQVSBkcml2ZXIgYW5kDQo+ID4+IGFw
cGxpY2F0aW9uLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IElWU0MgYWxzbyBwcm92aWRlcyBhIHByaXZh
Y3kgbW9kZS4gV2hlbiBwcml2YWN5IG1vZGUgaXMgdHVybmVkDQo+ID4+Pj4+PiBvbiwgY2FtZXJh
IHNlbnNvciBjYW4ndCBiZSB1c2VkLiBUaGlzIG1lYW5zIHRoYXQgYm90aCBBQ0UgYW5kDQo+ID4+
Pj4+PiBob3N0IElQVSBjYW4ndCBnZXQgaW1hZ2UgZGF0YS4gQW5kIHdoZW4gdGhpcyBtb2RlIGlz
IHR1cm5lZCBvbiwNCj4gPj4+Pj4+IGhvc3QgSVBVIGRyaXZlciBpcyBpbmZvcm1lZCB2aWEgYSBy
ZWdpc3RlcmVkIGNhbGxiYWNrLCBzbyB0aGF0DQo+ID4+Pj4+PiB1c2VyIGNhbiBiZQ0KPiA+PiBu
b3RpZmllZC4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBJbiBzdW1tYXJ5LCB0byBhY3F1aXJlIG93bmVy
c2hpcCBvZiBjYW1lcmEgYnkgSVBVIGRyaXZlciwgZmlyc3QNCj4gPj4+Pj4+IEFDRSBtb2R1bGUg
bmVlZHMgdG8gYmUgaW5mb3JtZWQgb2Ygb3duZXJzaGlwIGFuZCB0aGVuIHRvIHNldHVwDQo+ID4+
Pj4+PiBNSVBJIENTSS0yIGxpbmsgZm9yIHRoZSBjYW1lcmEgc2Vuc29yIGFuZCBJUFUuDQo+ID4+
Pj4+DQo+ID4+Pj4+IEkgdGhvdWdodCB0aGlzIGZvciBhIHdoaWxlIGFuZCBkaWQgc29tZSByZXNl
YXJjaCwgYW5kIEkgY2FuDQo+ID4+Pj4+IHN1Z2dlc3QgdGhlDQo+ID4+Pj4+IGZvbGxvd2luZzoN
Cj4gPj4+Pj4NCj4gPj4+Pj4gLSBUaGUgSVZTQyBzdWItZGV2aWNlIGltcGxlbWVudHMgYSBjb250
cm9sIGZvciBwcml2YWN5DQo+IChWNEwyX0NJRF9QUklWQUNZDQo+ID4+Pj4+ICAgaXMgYSBnb29k
IGZpdCkuDQo+ID4+Pj4+DQo+ID4+Pj4+IC0gQ2FtZXJhIHNlbnNvciBhY2Nlc3MgbmVlZHMgdG8g
YmUgcmVxdWVzdGVkIGZyb20gSVZTQyBiZWZvcmUNCj4gPj4+Pj4gYWNjZXNzaW5nDQo+ID4+IHRo
ZQ0KPiA+Pj4+PiAgIHNlbnNvciB2aWEgScKyQy4gVGhlIElWU0Mgb3duZXJzaGlwIGNvbnRyb2wg
bmVlZHMgdG8gYmUgaW4gdGhlIHJpZ2h0DQo+ID4+Pj4+ICAgc2V0dGluZyBmb3IgdGhpcyB0byB3
b3JrLCBhbmQgZGV2aWNlIGxpbmtzIGNhbiBiZSB1c2VkIGZvciB0aGF0IHB1cnBvc2UNCj4gPj4+
Pj4gICAoc2VlIGRldmljZV9saW5rX2FkZCgpKS4gV2l0aCBETF9GTEFHX1BNX1JVTlRJTUUgYW5k
DQo+ID4+Pj4gRExfRkxBR19SUE1fQUNUSVZFLA0KPiA+Pj4+PiAgIHRoZSBzdXBwbGllciBkZXZp
Y2VzIHdpbGwgYmUgUE0gcnVudGltZSByZXN1bWVkIGJlZm9yZSB0aGUgY29uc3VtZXINCj4gPj4+
Pj4gICAoY2FtZXJhIHNlbnNvcikuIEFzIHRoZXNlIGRldmljZXMgYXJlIHB1cmVseSB2aXJ0dWFs
IG9uIGhvc3Qgc2lkZSBhbmQgaGFzDQo+ID4+Pj4+ICAgbm8gcG93ZXIgc3RhdGUgYXMgc3VjaCwg
eW91IGNhbiB1c2UgcnVudGltZSBQTSBjYWxsYmFja3MgdG8gdHJhbnNmZXINCj4gdGhlDQo+ID4+
Pj4+ICAgb3duZXJzaGlwLg0KPiA+Pj4+DQo+ID4+Pj4gSW50ZXJlc3RpbmcgcHJvcG9zYWwgdG8g
dXNlIGRldmljZS1saW5rcyArIHJ1bnRpbWUtcG0gZm9yIHRoaXMNCj4gPj4+PiBpbnN0ZWFkIG9m
IG1vZGVsbGluZyB0aGlzIGFzIGFuIGkyYy1tdXguIEZXSVcgSSdtIGZpbmUgd2l0aCBnb2luZw0K
PiA+Pj4+IHRoaXMgcm91dGUgaW5zdGVhZCBvZiB1c2luZyBhbiBpMmMtbXV4IGFwcHJvYWNoLg0K
PiA+Pj4+DQo+ID4+Pj4gSSBoYXZlIGJlZW4gdGhpbmtpbmcgYWJvdXQgdGhlIGkyYy1tdXggYXBw
cm9hY2ggYSBiaXQgYW5kIHRoZQ0KPiA+Pj4+IHByb2JsZW0gaXMgdGhhdCB3ZSBhcmUgbm90IHJl
YWxseSBtdXhpbmcgYnV0IHdhbnQgdG8gdHVybiBvbi9vZmYNCj4gPj4+PiBjb250cm9sIGFuZCBB
RkFJSyB0aGUgaTJjLW11eCBmcmFtZXdvcmsgc2ltcGx5IGxlYXZlcyB0aGUgbXV4IG11eGVkDQo+
ID4+Pj4gdG8gdGhlIGxhc3QgdXNlZCBpMmMtY2hhaW4sIHNvIGNvbnRyb2wgd2lsbCBuZXZlciBi
ZSByZWxlYXNlZCB3aGVuDQo+ID4+Pj4gdGhlIGkyYw0KPiA+PiB0cmFuc2ZlcnMgYXJlIGRvbmUu
DQo+ID4+Pj4NCj4gPj4+PiBBbmQgaWYgd2VyZSB0byBzb21laG93IG1vZGlmeSB0aGluZ3MgKG9y
IG1heWJlIHRoZXJlIGFscmVhZHkgaXMNCj4gPj4+PiBzb21lIHJlbGVhc2UNCj4gPj4+PiBjYWxs
YmFjaykgdGhlbiB0aGUgZG93bnNpZGUgYmVjb21lcyB0aGF0IHRoZSBpMmMtbXV4IGNvcmUgY29k
ZQ0KPiA+Pj4+IG9wZXJhdGVzIGF0IHRoZSBpMmMgdHJhbnNmZXIgbGV2ZWwuIFNvIGVhY2ggaTJj
IHJlYWQvd3JpdGUgd291bGQNCj4gPj4+PiB0aGVuIGVuYWJsZSArDQo+ID4+IGRpc2F2bGUgY29u
dHJvbC4NCj4gPj4+Pg0KPiA+Pj4+IE1vZGVsbGluZyB0aGlzIHVzaW5nIHNvbWV0aGluZyBsaWtl
IHJ1bnRpbWUgcG0gYXMgc3VjaCBpcyBhIG11Y2gNCj4gPj4+PiBiZXR0ZXIgZml0IGJlY2F1c2Ug
dGhlbiB3ZSByZXF1ZXN0IGNvbnRyb2wgb25jZSBvbiBwcm9iZSAvDQo+ID4+Pj4gc3RyZWFtLW9u
IGFuZCByZWxlYXNlIGl0IG9uY2Ugd2UgYXJlIGZ1bGx5IGRvbmUsIHJhdGhlciB0aGVuDQo+ID4+
Pj4gcmVxdWVzdGluZyArIHJlbGVhc2luZyBjb250cm9sIG9uY2UgcGVyIGkyYy0gdHJhbnNmZXIu
DQo+ID4+Pg0KPiA+Pj4gU2VlbXMgcnVudGltZSBwbSBjYW4ndCBmaXggdGhlIHByb2JsZW0gb2Yg
aW5pdGlhbCBpMmMgdHJhbnNmZXINCj4gPj4+IGR1cmluZyBzZW5zb3IgZHJpdmVyIHByb2JlLCBw
cm9iYWJseSB3ZSBoYXZlIHRvIHN3aXRjaCB0byBpMmMtbXV4IG1vZGVsaW5nDQo+IHdheS4NCj4g
Pj4NCj4gPj4gV2hhdCBkbyB5b3UgbWVhbj8gVGhlIHN1cHBsaWVyIGRldmljZXMgYXJlIHJlc3Vt
ZWQgYmVmb3JlIHRoZQ0KPiA+PiBkcml2ZXIncyBwcm9iZSBpcyBjYWxsZWQuDQo+ID4NCj4gPiBC
dXQgd2Ugc2V0dXAgdGhlIGxpbmsgd2l0aCBkZXZpY2VfbGlua19hZGQgZHVyaW5nIElWU0MgZHJp
dmVyJ3MgcHJvYmUsDQo+ID4gd2UgY2FuJ3QgZ3VhcmFudGVlIGRyaXZlciBwcm9iZSdzIHNlcXVl
bmNlLg0KPiANCj4gVGhlbiBtYXliZSB3ZSBuZWVkIHRvIGRvIHRoZSBkZXZpY2VfbGlua19hZGQg
c29tZXdoZXJlIGVsc2UuDQoNCnNlbnNvcidzIHBhcmVudCBpcyB0aGUgTEpDQSBJMkMgZGV2aWNl
IHdob3NlIGRyaXZlciBpcyBiZWluZyB1cHN0cmVhbSANCmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0
L2xpc3RzL2tlcm5lbC9tc2c0NzAyNTUyLmh0bWxhbmQgYW5kIHNlbnNvcidzDQpwb3dlciBpcyBj
b250cm9sbGVkIGJ5IElWU0MgaW5zdGVhZCBvZiBJTlQzNDcyIGlmIElWU0MgZW5hYmxlZC4NCg0K
c3RydWN0IGRldmljZV9saW5rICpkZXZpY2VfbGlua19hZGQoc3RydWN0IGRldmljZSAqY29uc3Vt
ZXIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlICpz
dXBwbGllciwgdTMyIGZsYWdzKQ0KDQpTbyBwcm9iYWJseSB3ZSBoYXZlIHRvIGFkZCBhYm92ZSBk
ZXZpY2VfbGlua19hZGQgaW4gTEpDQSBJMkMncyBkcml2ZXIsDQphbmQgd2UgY2FuIGZpbmQgdGhl
IGNvbnN1bWVyKGNhbWVyYSBzZW5zb3IpIHdpdGggQUNQSSBBUEksIGJ1dCB0aGUgDQpzdXBwbGll
ciwgbWVpX2FjZSwgaXMgbWVpIGNsaWVudCBkZXZpY2UgdW5kZXIgbWVpIGZyYW1ld29yayBhbmQg
aXQncw0KZHluYW1pY2FsbHkgYWxsb2NhdGVkIGRldmljZSBpbnN0ZWFkIG9mIEFDUEkgZGV2aWNl
LCBwcm9iYWJseSBJIGNhbiBmaW5kDQppdHMgcGFyZW50IHdpdGggc29tZSBBQ1BJIGxvb2t1cCBm
cm9tIHRoaXMgTEpDQSBJMkMgZGV2aWNlLCBidXQNCnVuZm9ydHVuYXRlbHkgbWVpIGZyYW1ld29y
ayBkb2Vzbid0IGV4cG9ydCB0aGUgQVBJIHRvIGZpbmQgbWVpIGNsaWVudA0KZGV2aWNlIHdpdGgg
aXRzIHBhcmVudCBidXMgZGV2aWNlKHN0cnVjdCBtZWlfZGV2aWNlKS4NCg0KSSdtIG5vdCBzdXJl
IGlmIG1vZGVsaW5nIHRoaXMgbWVpX2FjZSBhcyBMSkNBIEkyQydzIHJ1bnRpbWUgcG93ZXINCmNv
bnRyb2wgaXMgYWNjZXB0YWJsZSwgaWYgeWVzLCBwcm9iYWJseSB0aGlzIG1laV9hY2UgZHJpdmVy
IGhhdmUgdG8gZ28gd2l0aA0KTEpDQSBJMkMgZGV2aWNlIGRyaXZlci4NCg0KQlIsDQpXZW50b25n
DQoNCj4gDQo+IFRoZSBtYWlubGluZSBrZXJuZWwgZGVsYXlzIHByb2Jpbmcgb2YgY2FtZXJhIHNl
bnNvcnMgb24gSW50ZWwgcGxhdGZvcm1zIHVudGlsDQo+IHRoZSBJTlQzNDcyIGRyaXZlciBoYXMg
cHJvYmVkIHRoZSBJTlQzNDcyIGRldmljZSBvbiB3aGljaCB0aGUgc2Vuc29ycyBoYXZlIGFuDQo+
IEFDUEkgX0RFUC4NCj4gDQo+IFRoaXMgaXMgYWxyZWFkeSB1c2VkIHRvIG1ha2Ugc3VyZSB0aGF0
IGNsb2NrIGxvb2t1cHMgYW5kIHJlZ3VsYXRvciBpbmZvIGlzIGluIHBsYWNlDQo+IGJlZm9yZSB0
aGUgc2Vuc29yJ3MgcHJvYmUoKSBmdW5jdGlvbiBydW5zLg0KPiANCj4gU28gdGhhdCB3aGVuIHRo
ZSBkcml2ZXIgZG9lcyBjbGtfZ2V0KCkgaXQgc3VjY2VlZHMgYW5kIHNvIHRoYXQgcmVndWxhdG9y
X2dldCgpDQo+IGRvZXMgbm90IGVuZCB1cCByZXR1cm5pbmcgYSBkdW1teSByZWd1bGF0b3IuDQo+
IA0KPiBTbyBJIHRoaW5rIHRoZSBjb2RlIGFkZGluZyB0aGUgZGV2aWNlX2xpbmstcyBmb3IgdGhl
IElWU0Mgc2hvdWxkIGJlIGFkZGVkDQo+IHRvOiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9p
bnQzNDcyL2Rpc2NyZXRlLmMgYW5kIHRoZW4gdGhlIHJ1bnRpbWUtcmVzdW1lDQo+IHdpbGwgaGFw
cGVuIGJlZm9yZSB0aGUgc2Vuc29yJ3MgcHJvYmUoKSBmdW5jdGlvbiBydW5zLg0KPiANCj4gTGlr
ZXdpc2UgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvaW50MzQ3Mi9kaXNjcmV0ZS5jIHNob3Vs
ZCBhbHNvIGVuc3VyZSB0aGF0DQo+IHRoZSBpdnNjIGRyaXZlcidzIHByb2JlKCkgaGFzIHJ1biBi
ZWZvcmUgaXQgY2FsbHMgYWNwaV9kZXZfY2xlYXJfZGVwZW5kZW5jaWVzKCkuDQo+IA0KPiBUaGUg
YWNwaV9kZXZfY2xlYXJfZGVwZW5kZW5jaWVzKCkgY2FsbCBpbiBkaXNjcmV0ZS5jIHRlbGxzIHRo
ZSBBQ1BJIHN1YnN5c3RlbSB0bw0KPiBnbyBhaGVhZCBhbmQgY3JlYXRlIHRoZSBpMmMtY2xpZW50
cyBmb3IgdGhlIHNlbnNvcnMgYW5kIGFsbG93IHRoZSBzZW5zb3IgZHJpdmVycw0KPiB0byBnZXQg
bG9hZGVkIGFuZCBwcm9iZSB0aGUgc2Vuc29yLg0KPiANCj4gUmVnYXJkcywNCj4gDQo+IEhhbnMN
Cg0K
