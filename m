Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25082621E2C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiKHVAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKHVAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:00:38 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A7A5EFA1;
        Tue,  8 Nov 2022 13:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667941237; x=1699477237;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ndLCPpXzPd4WV6WyNiVP/7J8ezpbL0MkxG9lyCRzjjo=;
  b=kQ5LljN0ntV4BfRcOxQMfUP854j0bKSyUM0no0i3758eChKuoYTB0IMi
   EinsfctYLpqJUbtcyRPWcdXHmnYxc+nmh1NmrE9+axgucNwU9rHzFCFQb
   kBWlRg5gqY/geBkoNQUCKnc1BQELsg/nKmL5rrHL4RrOlyJd2Lewpm3Ba
   BGpnBaSnm80PTuhQn7QTZww8IEtXanO6c79v51XwFAXHHzxdlgmUp9Jvl
   kCswPeCTXQFx1benPpTh9Exji52dRtotwLChSEBiAG08uL6gyAHqO1ILg
   JzyIvvXF6RmBHVj23r8aO+U6VNg9wlBpNmDQ2IijOxLEhC9cNwJ4eX/Dp
   g==;
X-IronPort-AV: E=Sophos;i="5.96,148,1665417600"; 
   d="scan'208";a="216132470"
Received: from mail-dm3nam02lp2042.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.42])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2022 05:00:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M23lMVaVQgw2o8OsGMXF39jqOzQU06Yr26CiK0B2tLn/U294E3INYYc6igdUYT1/XJ4UJhyETkUsn5syKiaDBJjmI0XTPRrdJYmhYSHdeKy1ohIBn4RXp3prCZ5UDwA00wdu9iC5jdZ5r0/EE5vmjdvYGMVbz0pNSk6r/ztIkpubvypndCzOlIU8b7DNFogiRTCIjFhkieXNTrc3D4Tj3k8B7NThNg4/IMGWWTDlquLEktL6cxhEICLTh61JMQ+xmchi1jN0ENm9HcPwf73ls5CVg/4KckGNxa5lfoUXqzwfAOe/ZhxfryW1BG6SMrQengJ0vG/OS0sIv8vxLP/YkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndLCPpXzPd4WV6WyNiVP/7J8ezpbL0MkxG9lyCRzjjo=;
 b=gmbuOo5Gi+QdHh55RoZizQpYS9OnBu6VfY69VC1InifhRv60SZcyH0NM/4Ic9MFUmo3udnC7C/OQ9rbHEMun2rtowwyVj9vr12aDFjcYQ2OmmBJCInyfXVwHG+y9xfbOTyB4M062qW39OJgUM6v+SqDvC0CTFYs2/GuBBhWCQrPrzTv2kXtxRpM5AqGicHZWNLYftS3sY77AnGeo4yJ+bt/i+hi9bZGRwFUGYlLFA8SJbKINMKWtbIb/IEV2tkRKFN71OnVC+8MDXJq1ImDlc0nDlX0k/WWNN1m5qo4X5DhmyV1J8KvXweiLtc4ICCus7thM0PP4ciMJosuWd4gdXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndLCPpXzPd4WV6WyNiVP/7J8ezpbL0MkxG9lyCRzjjo=;
 b=b7Or0jnMKgWJKXpX4UAO7polJ9sFLAEy02ROZhtTWwGWJp3zt71fJunG7+hvlbsoFj7Y7j6IQnhflYyj0FqaCZYqJbE+p3c2vRvYYFikgAnuDXk9+JeZKJFVMsH9kTNJ5+oFzuU49cOW4LK7oKu0uRlGc7MmzgSbRdUdvbaiQBc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SN6PR04MB4431.namprd04.prod.outlook.com (2603:10b6:805:32::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Tue, 8 Nov 2022 21:00:31 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%4]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 21:00:31 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "hare@suse.de" <hare@suse.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v1 2/2] ufs: core: Add advanced RPMB support in
 ufs_bsg
Thread-Topic: [RFC PATCH v1 2/2] ufs: core: Add advanced RPMB support in
 ufs_bsg
Thread-Index: AQHY8qptmsmbt7vqGEOmo5IvpfPIBq41YHnAgAAKwYCAABaRYA==
Date:   Tue, 8 Nov 2022 21:00:31 +0000
Message-ID: <DM6PR04MB657570B147A1D3B6FE5F8797FC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221107131038.201724-1-beanhuo@iokpp.de>
         <20221107131038.201724-3-beanhuo@iokpp.de>
         <DM6PR04MB657518129522996B2B5C9640FC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <fa3905bff8ba47b0ed45f9221dd1d033ca553179.camel@iokpp.de>
In-Reply-To: <fa3905bff8ba47b0ed45f9221dd1d033ca553179.camel@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SN6PR04MB4431:EE_
x-ms-office365-filtering-correlation-id: 8fc75e4c-38fd-4d61-d4d1-08dac1cc45bb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n3zPWIMcISHLONOGirrUZM+9dvBV1UFbfEWtauV+8DK0GlqUm+w75a/e5x+/tZcNen0WtJy8OsM3i6m7FacztQOx3IgDizi6SU5X+JD2Fm8OjJ87FFrWND2hFMr1VzivXY21CRQRDf5RdIuo4MflvyjUBAKJuzakrYLuKFHmsweXhPItOnlw9SmF+Z8B3xd16SLwpA5xEV6UBAV2ejTZveR/ow76qXd1BEGaRwo0EflZ5kGQktHzY0qbd2Hu27P7fk7xvRVroKlwNyji3dQ6qTTI96/n5jb7D0nW9+0FwxeUMYBFEdEN0MXhtVTjkuFGtZdCm5FacNGKpqH01J4o3Z8ZnTpygkJfGkqHuzwCf02Zg46QNtu0lGR0CgxkgkI18ws5WyVwNmF2FN9TYE+VH0xN/tAI0PaYlnv1IJq9CRtL5nyiy7e4T6KuJ+3XNGZLbHABgJM635ofR/BsuYEbj81JlOrVWUmdGGkoteaqrsRjk8Aki2PlwkYzculLmOUsAJZ8bmpyud1xNt2HRAAXzIQpXjRfCsdSrlhTs7oEMuUsnqi6NRChpxr3eRRDPMme+6sXanIz1ul0Mx09SgSK9bLEcT/3h2tmQzHGCAOPxn9okG8+uXhcDpo13VKo1qnrJwUovc0AcwDqgLBau41JoU+G995C0kvM9I++JyQIe5DV6zNOtppyFHPvm1i5ncHjusyZYgBjCp5GQTwARx/NXPUgtDhyFH21vph5OFGRGOZ1rws2ahXKrIKcwb5IBTWI4Vyc44qLekTir5J6AIpnMar14mWcgk4Q0gI3VWXlU/Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(26005)(9686003)(5660300002)(8676002)(7416002)(4326008)(41300700001)(8936002)(52536014)(6506007)(66446008)(66946007)(66476007)(7696005)(66556008)(186003)(64756008)(2906002)(76116006)(82960400001)(38100700002)(921005)(122000001)(38070700005)(86362001)(83380400001)(33656002)(478600001)(55016003)(54906003)(110136005)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0dsUFVGLzZvenlWM0YzeEZpOVhjcTc0elMyVEpUWXZKS3k4bksyR1JLUE1z?=
 =?utf-8?B?b25pNDNDeHVVVk11VVd4b3hFc0t5RWpMWG5BNmYvMS9kYkNIT1VxMGtaWHlj?=
 =?utf-8?B?K2hIemUvc3NKSHR3TEp4b09pa21sbUtoOWY5U3plQXliSCtKTnlWcHgzTmt2?=
 =?utf-8?B?RTlOS3BCcEQ3MzIxZks0SFdyRkpkOWIvV0FoVFRjRWRVa3JCK2JkWUVxWGx3?=
 =?utf-8?B?RU9NMDFJcGZOcmxVRTJac3EzZ0cvc3czR3pJL09UZTVXTUpQSW5QTGtmcW81?=
 =?utf-8?B?MkUvU2hIOUtyMDhTMHFFWjRSQ2pMaVBwTjJWYmpSRXQwRWpsWmZXcHJ4OWI0?=
 =?utf-8?B?Z25BWStzUllEaGo2TTVjNk04RVJSQjF1TTVsRXF5YlVncUM0VVNRbXJMMk9n?=
 =?utf-8?B?WUY2Zm1ObmxmemtoOG5wSzUxdGV1bnhKdUFUOUprSnJFcVVLMTJqdkd5S3Vj?=
 =?utf-8?B?N1BJRjZVdnc5blBmMnRUYnJvekRBeUhyRDI4UmVyaVliTzBLZk9zZEs3MWln?=
 =?utf-8?B?d0RWd21OT21Tb0lsdFBGaEFIK1l6bjJTOWFxNjV1bVRBU1FGYjIyaDQ5YVVi?=
 =?utf-8?B?WjdRazI5NVRPMG95UnNmSGtrdXBsUSt3bjNMWmFKL3RkeUZyVWJkMWJrTThK?=
 =?utf-8?B?ZEpJZTdjVWlWZ08rZWlQYUJvNlF0MGlzdVFqMVRMdU1BbjJCei9zeW8zeXFt?=
 =?utf-8?B?ajZKTXZkS0hnZUVSMjRvcEk2VEpOcFVjT2tPaFNvamRBU1F1OXBxRkVQK2tL?=
 =?utf-8?B?aUV4RXM3Vm1OZDdScXM1NUhKNld4THdZbXhxMjRwSStQSUI2aVBHbUp4dXJD?=
 =?utf-8?B?b0FXdnYvb1hsQ3Q0ZTVMaHBsbDdsMm1BWFRPdDZQWWo2TW5KUGI1UVJFS25O?=
 =?utf-8?B?MEFZdlo0VlpDeDg3Q2JHOGdJUnhBWDkzeHliN0JwT1diY1JJZExaaUtlVVp0?=
 =?utf-8?B?Y0xwZC9SUmpISE14Q3BrQUQvOWNEek1IZzhzUkdoUitWcDk3bzA0MDlMc2o5?=
 =?utf-8?B?dmdwSXBxNGtQODlBVG9qbWlSQk5GTmVXTjBuWjFxNHRzNGE2MUdjK3JsanJs?=
 =?utf-8?B?UkVjbVd1Z3F6b2NkM2JZU2FuZzVyK1o1em4rYXB2dHZJa2NuVXluL1ZJU1I3?=
 =?utf-8?B?UDRwbFFUVGNMV1lDWUJ3WFlTS2dKSFNVOG4yZnQ2bUFGc2JjcGQzRkxvNEMr?=
 =?utf-8?B?Mm14QzJRU0svT1Z5RVBsVnk4Yy92dnBqWlpoMnZpS0g3bTh1NXRxUWtOSjV6?=
 =?utf-8?B?TkdjS0hLQll3Q2Q4SzljeFVxVFJManpRQ1J2SDN2aVkwamtROGJPTE11ak5B?=
 =?utf-8?B?Z3hIRFlRb2lvRmdDQmVObGNML1JSWnV0akV3dmo1Q0FDcTV6d25RaTRkTXUz?=
 =?utf-8?B?Y0p5dVZhdVI5U2tHbklDcFg3cEZBcWxMc0RTK2RwUEJtSlhrdnlaSVgySkpL?=
 =?utf-8?B?MW1tUjM0MGNXUlk4ZWxVV2d3aVNFQ2gxTFlZZEoybndORGdEdzlVSGV2MEZC?=
 =?utf-8?B?bUlLL2MzZVhDSmQxNGxIb1lXZE1zZ3E1L0o1T09KVHpHTjRtb1dMenBvUThE?=
 =?utf-8?B?RWRWUHRZUml5L1hiUkRFZWxsZnZ5Y3IwRVpKR1hLV3JDTTROcE9UWkdtbkNM?=
 =?utf-8?B?OGY4Y3lsbmtmeCtiYVlFeGpHRzZETm03N0kxRk1DSStWbDBvYUd6a1dsUUho?=
 =?utf-8?B?aTlHYklyVFVxbDVRbUgvMkkzSlh6U3hGREJlSDZZZXJTejYxYldBeHBObFN6?=
 =?utf-8?B?NmFmdWRCUnFaMCtNdDQ0bXpsU0diek4zWkwvVXljai9pVFBad2JhMkVpb1Jk?=
 =?utf-8?B?MUJPZzZGUHliVGljY0hHNFZqSzQ2OWR3UU9XNXJRUDBTZ3k1NjVXSkpuZUxR?=
 =?utf-8?B?TCtPaGZISG9nYURpMnFXNkEyRm5SUjBhTGNhalNnd2NwdWIyVkdIM2Z5Wm1Q?=
 =?utf-8?B?UkhxK2xzNUo3YVh0RlA3dnRsSldJTDBFcEoyV25MYnJZRjZoNmlqZEpCdGpy?=
 =?utf-8?B?dG5xd1NDN0hwQ0ZMVE92T2FvNnd5VVQ1TmVxTlV3RS9jVWY4QUhEcHZNZ2JU?=
 =?utf-8?B?U2Rhbmk1NWI3TEt1VTM1UGd5ZDI1cVRMbFpWaTVaQ1lwazRieW5uMXhZcWpl?=
 =?utf-8?Q?Alq98Sqx4q67JB9/c1Zy+G7MT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc75e4c-38fd-4d61-d4d1-08dac1cc45bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 21:00:31.3617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhKG1HhKjrN8sO5g4qNXTsKlnHR3ZXjhdnn5kJXP4EYcS6IenZYxp9AzZC1ZLCA2L8YKRRnTSjTgKaR/hRBnPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4431
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBdnJpLA0KPiB0aGFua3MgZm9yIHlvdXIgY29tbWVudHMgYW5kIHJldmlldy4NCj4gDQo+IA0K
PiBPbiBUdWUsIDIwMjItMTEtMDggYXQgMTk6MDkgKzAwMDAsIEF2cmkgQWx0bWFuIHdyb3RlOg0K
PiA+ID4gQWRkIGFkdmFuY2VkIFJQTUIgc3VwcG9ydCBpbiB1ZnNfYnNnLiBGb3IgdGhlc2UgcmVh
c29ucywgd2UgdHJ5IHRvDQo+ID4gPiBpbXBsZW1lbnQgQWR2YW5jZWQgUlBNQiBpbiB1ZnNfYnNn
Og0KPiA+ID4gMS4gQWNjb3JkaW5nIHRvIHRoZSBVRlMgc3BlY2lmaWNhdGlvbiwgb25seSBvbmUg
UlBNQiBvcGVyYXRpb24gY2FuDQo+ID4gPiBiZSBwZXJmb3JtZWQgYXQgYW55IHRpbWUuIFdlIGNh
biBlbnN1cmUgdGhpcyBieSB1c2luZyByZXNlcnZlZCBzbG90DQo+ID4gPiBhbmQgaXRzIGRldl9j
bWQgc3luYyBvcGVyYXRpb24gcHJvdGVjdGlvbiBtZWNoYW5pc20uDQo+ID4NCj4gPiBSZWdhcmRs
ZXNzIG9mIGl0cyB0ZWNobmljYWwgY29udmVuaWVuY2UsIHRoaXMgYXBwcm9hY2ggdW5mb3J0dW5h
dGVseQ0KPiA+IGJyZWFrcyB0aGUgc3BlYy4NCj4gPg0KPiA+IFRoZSBzcGVjIHNheSAocGxlYXNl
IG5vdGUgdGhlIGxpbmUgbnVtYmVycyk6DQo+ID4NCj4gPiAiLi4uLi4NCj4gPg0KPiA+IDUxOTcg
MTIuNC41LjEgQWR2YW5jZWQgUlBNQiBNZXNzYWdlDQo+ID4NCj4gPiA1MTk4IEFuIEFkdmFuY2Vk
IFJQTUIgTWVzc2FnZSBpcyBjb21wb3NlZCBvZiBhbiBBZHZhbmNlZCBSUE1CDQo+IE1ldGENCj4g
PiBJbmZvcm1hdGlvbiBhbmQgYSBNQUMvS0VZIGluDQo+ID4NCj4gPiA1MTk5IHRoZSBFSFMgZmll
bGQgaW4gKkNPTU1BTkQgVVBJVSogYW5kICpSRVNQT05TRSBVUElVKi4gQWR2YW5jZWQNCj4gPiBS
UE1CIERhdGEgaXMgZGVsaXZlcmVkIHRocm91Z2gNCj4gPg0KPiA+IC4uLi4uIg0KPiANCj4gPiBN
b3Jlb3ZlciwgaW4gdGhlIGV4YW1wbGVzIHRoYXQgYXJlIHByb3ZpZGVkLCBpdCBpcyBzdGlsbCBl
eHBlY3RlZCB0bw0KPiA+IGJlIGNhcnJpZWQgdmlhIFNFQ1VSSVRZIFBST1RPQ09MIElOIGFuZCBT
RUNVUklUWSBQUk9UT0NPTCBPVVQsDQo+ID4NCj4gPiBTZWUgZS5nLiBGaWd1cmUgMTIuMTUg4oCU
IEF1dGhlbnRpY2F0ZWQgRGF0YSBXcml0ZSBGbG93IChpbiBBZHZhbmNlZA0KPiA+IFJQTUIgTW9k
ZSkuDQo+ID4NCj4gPg0KPiBub3QgcXVpdGUgZ2V0IHdoYXQgeW91IG1lYW50IGhlcmUuDQpJIG1l
YW50IHRoYXQgd2Ugc2hvdWxkIHN0aWxsIGJ1aWxkIHVwaXVzIHRoYXQgY29udGFpbnMgc2VjdXJp
dHkgcHJvdG9jb2wgY29tbWFuZHMuDQogDQo+ID4NCj4gDQo+ID4NCj4gPiBUaGVyZWZvcmUsIHdy
YXBwaW5nIHRoZSBycG1iIHBhY2tldHMgaW4gYSBxdWVyeS1yZXF1ZXN0IHVwaXUgYW5kDQo+ID4g
cXVlcnktcmVzcG9uc2UgdXBpdSBpcyBub3QgYWxsb3dlZC4NCj4gPg0KPiA+DQo+IA0KPiBubywg
SSBkaWRuJ3Qgd3JhcCBSUE1CIHBhY2tldCBpbiBxdWVyeS1yZXF1ZXN0L3Jlc3BvbnNlLCBpdCBp
cyBpbnVwaXVfcmVxDQo+IGFuZCB1cGl1X3JzcCwgaXQgaXMgdXBpdSBjb21tYW5kLg0KSSB3YXMg
dGhpbmtpbmcgeW91IGFyZSB1c2luZyBhIHF1ZXJ5IHJlcXVlc3QgdXBpdSBiZWNhdXNlIHlvdSBh
cmUgdXNpbmcgZGV2aWNlIG1hbmFnZW1lbnQgY29tbWFuZHMgZmxvdywNCkFuZCBzcGVjaWZpY2Fs
bHksIEkgZGlkbid0IHNlZSB3aGVyZSB5b3UgYXJlIHNldHRpbmcgdWNkX3JlcV9wdHItPnNjLmNk
YiwNCldoaWNoIHNob3VsZCBob2xkIHRoZSBzZWN1cml0eSBwcm90b2NvbCBjZGIuDQoNCj4gQmFz
ZWQgb24gQmFydCdzIHN1Z2dlc3Rpb24sIHdlIHNob3VsZG4ndA0KPiBjaGFuZ2UgdGhlIGN1cnJl
bnQgdWZzX2JzZyBzdHJ1Y3R1cmUuIEkgdGhpbmsgaGlzIGNvbmNlcm4gaXMgdGhhdCBpZiB3ZSBj
aGFuZ2UNCj4gdWZzX2JzZyBzdHJ1Y3R1cmUsIHRoZSB1c2VyIHNwYWNlIHRvb2wgYWxzbyBuZWVk
cyB0byBjaGFuZ2UgYXMgd2VsbC4NCkFkZGluZyBjb21tYW5kIHVwaXUgc3VwcG9ydCB3aWxsIG5v
dCBicmVhayBhbnkgdWZzLWJzZyB0b29scywgZS5nLiB1ZnMtdXRpbHMuDQpJdCB3b3VsZCBqdXN0
IGFkZCB0aGlzIGNhcGFiaWxpdHkuDQoNClRoYW5rcywNCkF2cmkNCg0KPiANCj4gPg0KPiA+IFN0
aWxsLCBJIGFncmVlIHRoYXQgdGhlIGFwcHJvYWNoIHlvdSBzdWdnZXN0ZWQsIG5hbWVseSB0byBy
ZWx5IG9uIHRoZQ0KPiA+IHVmcy1ic2cgZHJpdmVyLCBpcyB0aGUgY2xlYW5lc3Qgd2F5IHRvIGhh
bmRsZSB0aGUgYWR2YW5jZSBycG1iIGFjY2Vzcy4NCj4gPg0KPiA+IEhvd2V2ZXIsIElNSE8sIHlv
dSBuZWVkIHRvIGRvIGl0IGlzIGJ5IGFkZGluZyBjb21tYW5kIFVQSVUgdG8gdGhlDQo+ID4gdWZz
LWJzZyBkcml2ZXIuDQo+ID4NCj4gPg0KPiANCj4gWWVzLCBhZ3JlZSB3aXRoIHlvdSBvbiB0aGlz
IHBvaW50LiBCdXQgd2Ugc3RpbGwgbmVlZCB0byB1c2UgcmVzZXJ2ZWQgc2xvdHMgZm9yDQo+IFJQ
TUIgb3IgY29tbWFuZCBVUElVLCB3ZSBkb24ndCB3YW50IHRvIGFmZmVjdCBJTyByZXF1ZXN0cyBv
biB0aGUgbm9ybWFsDQo+IHBhdGguDQo+IA0KPiBPbmUgcHJvYmxlbSBpcyB0aGF0IHdlIGRpZG4n
dCBzcGxpdCB0aGUgZGV2X21hbmFnZSBjb21tYW5kIGFuZCB0aGUNCj4gUlBNQiBjb21tYW5kIGlu
IHRoZWlyIGNvbXBsZXRpb24gaGFuZGxlcnMuIEkgd291bGQgbGlrZSB0byBjaGFuZ2UNCj4gZGV2
X21hbiB0byBwYXNzdGhyb3VnaCBvciBzb21ldGhpbmcgZWxzZSwgYW5kIHRoZW4gc3BsaXQgZGV2
X21hbiBhbmQNCj4gUlBNQiwgb3RoZXJ3aXNlLCB0aGV5IHdvdWxkIGJlIG1peGVkIGluIG9uZSBk
ZXZfbWFuIGNvbXBsZXRpb24gaGFuZGxlci4NCj4gTm8gdGVjaG5pY2FsIGlzc3VlcyBoZXJlLCBq
dXN0IHdhbnQgdG8gbWFrZSBpdCBtb3JlIHJlYWRhYmxlIGFuZA0KPiBtYWludGFpbmFibGUuDQo+
IA0KPiANCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gQmVhbg0KPiANCj4gPg0KPiA+IFRoYW5rcywN
Cj4gPg0KPiA+IEF2cmkNCg0K
