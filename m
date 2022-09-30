Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211F35F0FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiI3QUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiI3QUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:20:36 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7A514000;
        Fri, 30 Sep 2022 09:20:31 -0700 (PDT)
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UFWfBm000942;
        Fri, 30 Sep 2022 16:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=dRU5VBXbxmttKDxEDNOcyBYd2LNfxtYqpRQX/zzjhLM=;
 b=lB36wIW4SSL5qR02F42g+p6O1hHI82T55iNLE9rl/bIQWk3K+jITSD5h2M8Poo5Tlvp0
 Q1EsANj5GM06tMM9MpfU1ANhL0FxwY70sIzZz3RlQQXDZ38T1+rc0fAkjSOVqZhrfr03
 vgS8Fzy58TRanDFIhiwbiwRl4KoGwUAidwB89d6w6NhKNYWuwqHbS9HK/9dYoMHmK1e+
 HST3b1JbmM2rwPfDWn6mD4Dtt82hfSl5zbAwcOd8w79U/BVaEMf+o8euDuxoYm5ULSiA
 B9reuquZYvaOcB6/iaw/3GYZ+NTfckl6i/3N/YAc3bgmkTmWUW+2cloSxHg2b3KiYJkL Xw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3jst1jq4tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 16:20:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih+ttU2iLLhdWo9HtwAU1oBASC0VUAx/DbISH6MnFLFv3m1R+s3gR86dNo4PNdciC+OoiRV6z6OWiMwYmbTsXM3a3IEOAD3upbsMWVM6FFjOk8rLvVjBwEC502ED0Jf9epb/7wlnDTwVQl2CqcertipwIQdDKh0Mf4op/B/4gQPLnbF1F4nVyiXNV1taWx4OWWTIHN7jHicHUdst3vNpyz8RAU2qjtTBA1dFqKTVilRlHmbGHSPmwl0CZS4GBWTKlThA6DvFEjhcLuleEG2yKXWA6r+vvQJijcdcFMqW6HYBPhtSD5h34Q4DE30ztoU5avks8EbicrxgR7hQR5nnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRU5VBXbxmttKDxEDNOcyBYd2LNfxtYqpRQX/zzjhLM=;
 b=aS6EOhpDt23frhTfsPsDADSub2cTJpLPmUJ2QFw/qyZa5Z7xU9HCZbGK7UMVZIAFl/HL5llUsQUx9Pg2OoEdVNoQ1Vv9ooC5fe3uTlyU+4PUwyABNbg021lsO4cp8J3F4wejaGfqQS0uALJEzSZDVe2cUbB8M/X1ymYpOg7D91F9GR+zqRl+tJ3DSsASNkrhwFkOQouPBU3jG9sOc8dHM39kxGfzsSrIprO04IxC0GOEHkk+mRwx0w6MVe4O9XZMQZwnBj1djuoAtVvGaOB922l0Y15k3e7IgRSh5aiWe80ypIptwIUi+InFVxgPNC7qUZ9R4JOBVExkcC+eyC/TEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by SN4PR13MB5792.namprd13.prod.outlook.com (2603:10b6:806:21b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.14; Fri, 30 Sep
 2022 16:19:56 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::41c:5c3b:bff:666f]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::41c:5c3b:bff:666f%2]) with mapi id 15.20.5676.015; Fri, 30 Sep 2022
 16:19:56 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thorsten Leemhuis <linux@leemhuis.info>
CC:     Slade Watkins <srw@sladewatkins.net>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Subject: RE: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Thread-Topic: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Thread-Index: AQHY0/dmGxXfZ/3UJUWIh6R5VakqUK32VGCAgAALnwCAAAe5gIAABgmAgAAf8oyAAA87AIABGwgAgAA/qYCAADAi0A==
Date:   Fri, 30 Sep 2022 16:19:56 +0000
Message-ID: <BYAPR13MB250377AAFCC43AC34E244795FD569@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
 <20220929130410.hxtmwmoogzkwcey7@meerkat.local>
 <7b427b41-9446-063d-3161-e43eb2e353f9@gmx.com>
 <20220929135325.4riz4ijva2vc7q5p@meerkat.local>
 <95c3384b-53d0-fd6c-6ec5-a7e03fdeddfc@gmx.com>
 <F300ED64-5E8E-4060-89DC-C98BC5FF08E6@sladewatkins.net>
 <YzXK6Px+BrNuuMZH@pendragon.ideasonboard.com>
 <a86adc6d-05db-ec2e-c5de-d280aad9fb8a@leemhuis.info>
 <Yzbtuz6L1jlDCf9/@pendragon.ideasonboard.com>
In-Reply-To: <Yzbtuz6L1jlDCf9/@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2503:EE_|SN4PR13MB5792:EE_
x-ms-office365-filtering-correlation-id: f71d3f5b-265a-49e6-7156-08daa2ff9cfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CqEK7W2wPvPNNBcZ98r/uGOu1aIHKAtBZA77Lk79zs+wtdESifz8+umvml2sN9CIk6LvzHkvsYf3iIY2qtTTyRyzxNhgXRxqESruIcm/YquM2k60m+Q3yuywbhoT4WimV2rU0LR/zP6AWSBkAOHkPov7BvQitxGLd4DkCV8/pbdL982vcuRR2FmRjFbTYiw9ofqGWinGfMac+EPZAmoKmZkKf1Ke77XKZ7NibeMp7Gb8Q4t8BtY9sU7IGWEN7K74wqbSF9jDcb3nGcR9tClrFsWS6EWBPEkkLJKjkxSVJM5TE8w3Xd8HReUl/H/Y/IqRMYaXR0Tgido9EPXZuVskx6xiF0UJs8NCaEPujpfwVyscqPfEkuK7kKscx93CGgkONSDPKWaTUufQIEH2DqOGRnQbR6rs8YoxPVJTyktdNOuXFLfCw2YL+RE4F98F5KNSK33cXuPuVVdRI7/h01gTynLOFYzjzarxsQbSDucJ+vNdR0l04ju7StN18UlUcaVdEg8hYisHX04IS7CKF+qADGH3/jOSdYp2PVPfl8n6BVueYC8xhs8LsJXv5dPBDlx2WEzFr8UjqbjwHY9rrGbhkVrnetcG0ncLAWifjjEhluBwK4kpCB87Jk6x30zHaFtb4YSURWwi/XAR0YZev2hTNRHUihfXcmKWPOb3fDYcayeRMt0OOJXRWGIYHzuI+qL/algaH2kN8+2Zqh8Qce7M3V7NTkoCP4SsQVlMdf0JgHbBOGeHyJTpm1AOf1NQNof1Ito4U0SheMsIclEccVMczdy60fK8QrbyTjUvMpY3cQqYBn8wFZgnf+mTR6T/h2HMQgNtmTccLG2wZWGxdOxeew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(122000001)(4326008)(38100700002)(86362001)(33656002)(82960400001)(38070700005)(5660300002)(7416002)(7696005)(186003)(55016003)(26005)(41300700001)(53546011)(478600001)(6506007)(71200400001)(966005)(316002)(9686003)(8936002)(66446008)(66946007)(54906003)(110136005)(64756008)(83380400001)(52536014)(2906002)(76116006)(66556008)(66476007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlUrNGVRRThXZitKUng3WFAvcGNIajJaODdhYjM4NHJnNmNzODlIUFA4a2k0?=
 =?utf-8?B?TjFEUXNram9Ob2Z5ZE0wMFNiRFBJSDVHUEhkUDNTWnNYZG16KzlmVHd0blJm?=
 =?utf-8?B?b3dtRTBpZzFNdStLck1acmNRb3F4TUVNV0dsbWRZajVYNHdmRGFXaTQydE9H?=
 =?utf-8?B?YWFia2U4YUtRMVVEM0VPblBkTDZ2WW53MklPZ0lRSkhDNy9JWHZQemVRb05m?=
 =?utf-8?B?L3F3SWZ2UFpqTkhFTllhaVFyb1NBb0Y5SnU5WHIyb0xWbmpmRkxsZUJnUTRj?=
 =?utf-8?B?MTRDVEZGWUhDK3hPK1hhRkZ3RVJxQzVkMSttdHRkaWxxRkpsK21sbXcvNlRR?=
 =?utf-8?B?bzJvUERQQ0JLdWlHcU5XM3NpNkJGRWhNLzlNWGJKT1JmcWQrRndTd2pWZXFD?=
 =?utf-8?B?RHE1anBaV0ZFMEdsS0psL1RMaFBtQ1pxazVZdTZZdGU3V0pHNEI5RHlTcExP?=
 =?utf-8?B?c2tVdVgvai9RUy90K1AvOHh1UHdVVU96MytUTTEyYW1lZUFkQlUyeTNzT3lZ?=
 =?utf-8?B?V0YySEhQUS8vSWxMaWVBN3lmRWJhQ0NERlFCVTJEajRXTzdkd21wN3BkUTNT?=
 =?utf-8?B?VTBqZ1lPZVVrRFZxWmNzbGxxY2VVUXpmYkNNWWhNNVdUUVFwT2VXR0JnL3NS?=
 =?utf-8?B?WDRxanRkckFhTXNUa0JqMVI1MldyZW52VEtVUlJBcE5VV0F5VDZJWTgvdUF1?=
 =?utf-8?B?OHBrWFp5cEh0TENhSjl0L2pFTkI2ZUtxVEJVODd3V0p3S20wNW5ITzVYMUtl?=
 =?utf-8?B?RExEU3pjTjBRazRkeFpqT3M0NmdUWitCN2hkbjV5WXl5dk9Xd3poQUtBbTFO?=
 =?utf-8?B?Z1BBZXdhZ21LWHdmY1N2YUFTblFGRlpqYzFrSk5IUm4zcTcralBBVzFFSk83?=
 =?utf-8?B?bjJYSGlCczdjUVNPbHQvRnJOZGxZZUtHa1NXVnJRckpXM25FTnFNTnRhVmlD?=
 =?utf-8?B?ckRZZStiZ0h6U2hFaldUQkRUWFJtUFJ4RngrTktsSGV3M1VQdFNCSnRZcDhh?=
 =?utf-8?B?dTNXcXNoc0tjWWMzQnptYjhNTE9MMzlNNFVBazdTb1VKSm9tT1FRR1poTjgr?=
 =?utf-8?B?MlpnVFluSWFrSkdlUUlFYTgzZGNFS2FBMUJSd0dPdkRycU5iVFdMcXp3NFUx?=
 =?utf-8?B?bVJyLzRKZENGSFhkdW90cURzcGp6dGhsUWZNNGNnUE9FQVRRL3k1Zktyd0k0?=
 =?utf-8?B?RlBXbEJVUDh4dm5LMGlpN1RsOVpSemFMSStSS0dDdnJyMFludWFjRGJ2N0R4?=
 =?utf-8?B?SWFJMWJoeG9zMTMxRWx3UENVRXc1K2p3SXJEUU95L1pVckRseG5PTG1KRFFW?=
 =?utf-8?B?N1NvZ3lQaEJWc05ScEFiaVlNNWNERDNUZG1SbkpFcE1nVk92dGhmUitBN1hX?=
 =?utf-8?B?Nyt1V3JOQXpvRm9vUksrWlFkUWV2WTNhQmlmZGJubVlxR0JoWHFwZ29GOEpJ?=
 =?utf-8?B?WDI5Tmt5TzdaWUlDUE9lRlpmM3JKQ0tmL1YvMTFoMGJaVUwyK0RpOHhnM1E2?=
 =?utf-8?B?NW10UnljOXZkblBWZUlrQlBKYmZic0x6MVk0Yko5YjZwdUlGL3pWQlU3L1Vh?=
 =?utf-8?B?cHdEeEJSTlVWVHlteG5WOTAwR1ZZc3NjOG1KK3FwVTQvM1Rkenp2SjNHT0tm?=
 =?utf-8?B?N3lkOVlBMWxybUJlKzF0V1NVdXJIWG0zaHZ6MDB2ME8zZEdvcEthdDBvcFpZ?=
 =?utf-8?B?NktvbHJubGQ5aCthYmdhSmdSdzNjZG84QmU0dEs3eFJudjdUVWRWV2NCMnRP?=
 =?utf-8?B?RjVlVS8yS2J2ZEZSQ3ZDRDdqVHBvdmZ6SEE5dC80YVRYaGNxU0hiYTRLV0dx?=
 =?utf-8?B?anNteWZWVElBZmMyR3JhTmJNSkFyTUJRZldjVzFBTnpMSUFUNmYzMFlaODRQ?=
 =?utf-8?B?ZUVtTDFwOUtaejlESnFoTTZpSmtVSzNhejc3aFM0ZTh2cDUvdlRiejlYS2dE?=
 =?utf-8?B?MDh3ZXg1TDhFZ2lOTjd4NWYyOUJpTWxYeUg0Ung0bXcybHdhM0FlOW1VaTZD?=
 =?utf-8?B?SlJGckI3Y0VCWlQyZWZPZXRVOWdZUzk0ZkFmWUwxN040UE5VYVpFdDA0VCtM?=
 =?utf-8?B?dGdnNEVNakxzNFZTZXJYTW9Tam5GKytxeWFtaHFnYmVpSjZFVGd3cXFId056?=
 =?utf-8?Q?xp2HNa+fCjwxwTkGpl2xlAjXr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71d3f5b-265a-49e6-7156-08daa2ff9cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 16:19:56.0340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yi0VxHjqEHFzRuyY23Ftz6cyzFaJg/Yv6RZTWjg6ClXDCuPxpKDmSGSpC2t08v2xXPwsHkhXVyjrfnTM99WsvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5792
X-Proofpoint-GUID: 81NQxBDdKnCTzHqw0eiGYJvnQh2bLq_l
X-Proofpoint-ORIG-GUID: 81NQxBDdKnCTzHqw0eiGYJvnQh2bLq_l
X-Sony-Outbound-GUID: 81NQxBDdKnCTzHqw0eiGYJvnQh2bLq_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXVyZW50IFBpbmNoYXJ0IDxs
YXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+DQo+IA0KPiBIaSBUaG9yc3RlbiwNCj4g
DQo+IE9uIEZyaSwgU2VwIDMwLCAyMDIyIGF0IDExOjM1OjE2QU0gKzAyMDAsIFRob3JzdGVuIExl
ZW1odWlzIHdyb3RlOg0KPiA+IE9uIDI5LjA5LjIyIDE4OjQyLCBMYXVyZW50IFBpbmNoYXJ0IHdy
b3RlOg0KPiA+ID4gT24gVGh1LCBTZXAgMjksIDIwMjIgYXQgMTA6NTQ6MTdBTSAtMDQwMCwgU2xh
ZGUgV2F0a2lucyB3cm90ZToNCj4gPiA+Pj4gT24gU2VwIDI5LCAyMDIyLCBhdCAxMDoyMiBBTSwg
QXJ0ZW0gUy4gVGFzaGtpbm92IDxhcm9zQGdteC5jb20+IHdyb3RlOg0KPiA+ID4+Pg0KPiA+ID4+
PiBJJ3ZlIG1lbnRpb25lZCBzZXZlcmFsIHRpbWVzIGFscmVhZHkgdGhhdCBtYWlsaW5nIGxpc3Rz
IGFyZSBfZXZlbiB3b3JzZV8NCj4gPiA+Pj4gaW4gdGVybXMgb2YgcmVwb3J0aW5nIGlzc3Vlcy4g
RGV2ZWxvcGVycyBnZXQgZW1haWxzIGFuZCBzaW1wbHkgaWdub3JlDQo+ID4gPj4+IHRoZW0gKGZv
ciBhIG11bHRpdHVkZSBvZiByZWFzb25zKS4NCj4gPiA+Pg0KPiA+ID4+IEl04oCZcyAxMDAlIHRy
dWUgdGhhdCBlbWFpbHMgZ2V0IF9idXJpZWRfIGFzIHdhdmVzIG9mIHRoZW0gY29tZSBpbiAoTEtN
TA0KPiA+ID4+IGl0c2VsZiBnZXRzIGh1bmRyZWRzIHVwb24gaHVuZHJlZHMgYSBkYXksIGFzIEni
gJltIHN1cmUgYWxsIG9mIHlvdSBrbm93KQ0KPiA+ID4+IGFuZCBpdCBqdXN0IGlzbuKAmXQgc29t
ZXRoaW5nIEkgcGVyc29uYWxseSBzZWUgYXMgdmlhYmxlLCBlc3BlY2lhbGx5IGZvcg0KPiA+ID4+
IGlzc3VlcyB0aGF0IG1heSBvciBtYXkgbm90IGJlIGhpZ2ggcHJpb3JpdHkuDQo+ID4gPg0KPiA+
ID4gRS1tYWlscyBhcmUgbm90IHRoYXQgYmFkIHRvIHJlcG9ydCBpc3N1ZXMsIGJ1dCB0aGV5IGNh
bid0IHByb3ZpZGUgdGhlDQo+ID4gPiBjb3JlIGZlYXR1cmUgdGhhdCBhbnkgYnVnIHRyYWNrZXIg
b3VnaHRzIHRvIGhhdmU6IHRyYWNraW5nLiBUaGVyZSdzIG5vDQo+ID4gPiB3YXksIHdpdGggdGhl
IHRvb2xzIHdlIGhhdmUgYXQgdGhlIG1vbWVudCAoaW5jbHVkaW5nIHB1YmxpYy1pbmJveCwgYjQN
Cj4gPiA+IGFuZCBsZWkpLCB0byB0cmFjayB0aGUgc3RhdHVzIG9mIGJ1ZyByZXBvcnRzIGFuZCBm
aXhlcy4NCj4gPg0KPiA+IFdlbGwsIEknZCBkaXNhZ3JlZSBwYXJ0aWFsbHkgd2l0aCB0aGF0LCBh
cyBteSByZWdyZXNzaW9uIHRyYWNraW5nIGJvdA0KPiA+ICJyZWd6Ym90Ig0KPiA+IChodHRwczov
L3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRsYWIuY29tL2tudXJkNDIvcmVnemJvdC8t
DQo+IC9ibG9iL21haW4vZG9jcy9nZXR0aW5nX3N0YXJ0ZWQubWRfXzshIUptb1ppWkdCdjNSdktS
U3ghN2Y4TzJRYUd5V2d4QVN3ZzFfYnhzVjUzdVdQSU56ekJhX01MTVpNb29hNnFMNmpkazhaQlZZ
ckJfDQo+IG15cGp3MEgzeXY1SVBkTkoycVFUaHpNTEtick9VUU1GTU8xeDJWMiQNCj4gPiA7IGh0
dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xpbnV4LQ0KPiByZWd0cmFja2luZy5s
ZWVtaHVpcy5pbmZvL3JlZ3pib3QvbWFpbmxpbmUvX187ISFKbW9aaVpHQnYzUnZLUlN4ITdmOE8y
UWFHeVdneEFTd2cxX2J4c1Y1M3VXUElOenpCYV9NTE1aTW9vYTZxTDZqZGs4Wg0KPiBCVllyQl9t
eXBqdzBIM3l2NUlQZE5KMnFRVGh6TUxLYnJPVVFNRktST3pTSlkkICApIGRvZXMNCj4gPiBleGFj
dGx5IGRvZXMgdGhhdDogdHJhY2tpbmcsIGJ5IGNvbm5lY3QgdGhlIGRvdHMgKGUuZy4gbW9uaXRv
cmluZw0KPiA+IHJlcGxpZXMgdG8gYSByZXBvcnQgYXMgd2VsbCByZWNvcmRpbmcgd2hlbiBwYXRj
aGVzIGFyZSBwb3N0ZWQgb3INCj4gPiBjb21taXR0ZWQgdGhhdCBsaW5rIHRvIHRoZSByZXBvcnQg
dXNpbmcgTGluazogdGFncyksIHdoaWxlIG1ha2luZyBzdXJlDQo+ID4gbm90aGluZyBpbXBvcnRh
bnQgaXMgZm9yZ290dGVuLiBCdXQgc3VyZSwgaXQncyBzdGlsbCB2ZXJ5IHJvdWdoIGFuZA0KPiA+
IGRlZmluaXRlbHkgbm90IGEgZnVsbCBidWctdHJhY2tlciAobXkgZ29hbCBpcy93YXMgdG8gbm90
IGNyZWF0ZSB5ZXQNCj4gPiBhbm90aGVyIG9uZSkgYW5kIG5lZWRzIHF1aXRlIGEgYml0IG9mIGhh
bmQgaG9sZGluZyBmcm9tIG15IHNpZGUuIEFuZCBJDQo+ID4gb25seSB1c2UgaXQgZm9yIHJlZ3Jl
c3Npb25zIGFuZCBub3QgZm9yIGJ1Z3MgKG9uIHB1cnBvc2UpLg0KPiANCj4gUGF0Y2h3b3JrIGRv
ZXMgc29tZXRoaW5nIHNpbWlsYXIgZm9yIHBhdGNoZXMsIGFuZCBJIGFncmVlIHRoYXQgaXQgd291
bGQNCj4gYmUgcG9zc2libGUgdG8gdXNlIGUtbWFpbCB0byBtYW5hZ2UgYW5kIHRyYWNrIGJ1ZyBy
ZXBvcnRzIHdpdGggdG9vbHMgb24NCj4gdG9wIChhbmQgZG9uJ3Qgd29ycnksIEknbSBub3QgYXNr
aW5nIGZvciByZWd6Ym90IHRvIGJlIHR1cm5lZCBpbnRvIGEgYnVnDQo+IHRyYWNrZXIgOi0pKS4g
SXQgaG93ZXZlciBoYXMgdG8gcmVseSBvbiBsb3RzIG9mIGhldXJpc3RpY3MgYXQgdGhlDQo+IG1v
bWVudCwgYXMgdGhlIGRhdGEgd2UgZXhjaGFuZ2Ugb3ZlciBlLW1haWwgaXMgZnJlZS1mb3JtZWQg
YW5kIGxhY2tzDQo+IHN0cnVjdHVyZS4gSSd2ZSBiZWVuIGRyZWFtaW5nIG9mIHN1cHBvcnQgZm9y
IHN0cnVjdHVyZWQgZGF0YSBpbiBlLW1haWxzLA0KPiBidXQgdGhhdCdzIGEgcGlwZSBkcmVhbSBy
ZWFsbHkuDQoNCkUtbWFpbHMgc2VudCBmcm9tIGEgd2ViIGludGVyZmFjZSBjb3VsZCBoYXZlIGFz
IG11Y2ggc3RydWN0dXJlIGFzIHlvdSdkIGxpa2UuDQpTbyBvbmUgYXZlbnVlIHdvdWxkIGJlIHRv
IHNldCB1cCBhIG5pY2UgaW50ZXJmYWNlIGZvciBidWcgcmVwb3J0aW5nLCB0aGF0IGp1c3QNCmRl
bGl2ZXJlZCB0aGUgZm9ybSBkYXRhIGluIGUtbWFpbCBmb3JtYXQgdG8gdGhlIHByb3Bvc2VkIGJ1
Zy1yZWNlaXZpbmcgbWFpbCBsaXN0Lg0KDQpBbHNvLCBpZiBhbiBlLW1haWwgcmVjZWl2ZXIgKHNv
bWV0aGluZyBhdXRvbWF0ZWQpIGdhdmUgYSBxdWljayByZXNwb25zZSBvbiBtaXNzaW5nIGZpZWxk
cywgSSB0aGluaw0KeW91IGNvdWxkIHF1aWNrbHkgdHJhaW4gdXNlcnMgKGV2ZW4gZmlyc3QtdGlt
ZSBidWcgc3VibWl0dGVycykgdG8gcHJvdmlkZSByZXF1aXJlZA0KZGF0YSwgZXZlbiBpZiB0aGV5
J3JlIHNlbmRpbmcgZnJvbSBhIGZyZWUtZm9ybSBlLW1haWwgY2xpZW50Lg0KDQpKdXN0IG15IDIg
Y2VudHMuDQoNCiAtLSBUaW0NCg==
