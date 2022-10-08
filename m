Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D835F8572
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 15:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJHNWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 09:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJHNWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 09:22:02 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1214C356C4
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 06:21:58 -0700 (PDT)
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2989h9QN027439;
        Sat, 8 Oct 2022 13:21:49 GMT
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3k32k58q6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Oct 2022 13:21:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9+QBfVhD+7J/FssQFg/sq7W9OwULWjtTX5vW7PRWTS4uzEfCe80oGx0b+0huKgDWgeCCMIsdBxd2QbMC0N7CLbXXnKK1aJmhgyBkE97lrzpDtxCFJ/BXQFrXiybIjipr9xkbkpiRR/LECV/cklE5WF9mZFF2jt1MAYe4T57XSmQOHzqAzVl9e41p0dDRFcOLLz10mxWEkSWiwy7x0vt8jdus4vmTDcZis1pow+9rFuej3wnSZC9xNuqo16loHYlwujBBhfNGlNmkTMl6DPWeUt9AVaD2ENS90vRkBJWEjLyB4AoTlX+DichO5Sl60huV/7dj7HH4LJVs9578Gegzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/klni/RAQWHxR2tnxUhtEL4A/iXWkUQqH1vnYdMMXU=;
 b=C7GGcx4BDK30tJgUVtPR1x4Pn/YFRczh6MnuzwMfcNDrVgxocWwVZmGhmTtCTJAB+4rgoN0iCmNK4OnpCC7Vr8DlthoUJeJRmWLXS2OQpC+oe6qlC7LPrKWhF09KIzHbavb6qc1KOiI8ifjfNEuqaYE6UzNZ88yF3fsresAmjGoNI4HsctyLrd9dNRlxfiEQAvbCEudZ1BDcN0qWIWhc8IbEN983r0oNznyWO9awowXO7JxOsbNv8AMePnReOdPkmn2hFIT75tW578Lb2ZowHR0vJsZ1SPUIYnUZ3AWKQJds0EJrqJAKBJiZcssvaMazvQAPCazOSOwCAVjLSQq/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/klni/RAQWHxR2tnxUhtEL4A/iXWkUQqH1vnYdMMXU=;
 b=THF75VJtNCKFsYGc6Jmes5Mpkhkho4moGK+dOdBQ5zDQq79IEZGDntEOMWYkYNGtnwyRRYoCv3vMqLpNND415YBroswjK4ueVzSIpalAoR1SIjxwnWsbEIKcOTVVWQg5WEfkkfrDeTdyi0+AFcBEc9YLikgC+vlrWKPcCybfgfj3OVk3J4HwmTYcvRHbpDBLvb8OBngTtJHH+6um0147oU6XC1bbJFj5e+uEH5J9kEXxGQblcE/liGgMeU4kL8fpugREml54UemEl80S4hslGt/Tq42gjXTc3IZNkC25I4pOTN+mwHoz0U8XCvhqE+KSmGHK/gE1TwO5Ofz/HWK/zQ==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AS1PR03MB8192.eurprd03.prod.outlook.com (2603:10a6:20b:483::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sat, 8 Oct
 2022 13:21:44 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::93be:22b1:654c:e4bc]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::93be:22b1:654c:e4bc%5]) with mapi id 15.20.5676.038; Sat, 8 Oct 2022
 13:21:44 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Xenia Ragiadakou <burzalodowa@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: Re: [PATCH] xen/virtio: Handle cases when page offset > PAGE_SIZE
 properly
Thread-Topic: [PATCH] xen/virtio: Handle cases when page offset > PAGE_SIZE
 properly
Thread-Index: AQHY2lCewf5wqMeDhkqfFwKHpttMBq4EV/CAgAAc7QCAAAIqgIAABikA
Date:   Sat, 8 Oct 2022 13:21:44 +0000
Message-ID: <e5cbc60c-a3df-87b2-0e7c-a1f69269a06d@epam.com>
References: <20221007132736.2275574-1-olekstysh@gmail.com>
 <6e33b687-8862-d208-a707-77a95c61525e@gmail.com>
 <d6ec5092-8d93-22c2-7b6e-944ad88ad582@epam.com>
 <cb6e650f-d8ad-037d-8c35-8a786650b02f@gmail.com>
In-Reply-To: <cb6e650f-d8ad-037d-8c35-8a786650b02f@gmail.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|AS1PR03MB8192:EE_
x-ms-office365-filtering-correlation-id: d00cf335-9a42-43e6-c8b9-08daa9300bb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DzkPEnkN5obJ1ZCKlzzirDX04xEpgxAysw/69WzUadkoXLgsw+0vYxGO4lRv/3SxugCxy8Qrs/uXJUTLMuh4UH1hN4B49ftM7cdGrwDs0rtVIpH3ytRY41J5KM9s97rkaZzFA7k1C8LHMydmhuQ/7hzlo0fPMgq9YRFTN40F8iQIx/2yHWHA6Fh61xeghCY/WNMNtuDY5t7x7iJj/DNIdAJjE9UmiRLW4U/WMKeN2JvUgebt6Ty/qXlGTCnSGJYBQ9EXqsExEAmEvkuAllDKudHRiIsH/ibkbKdkkPelGZ2mxh3+AChw2Zb8ZUgJZPo9f3wDwGEkXcwrUmJ19zLwT+skgPRLY8JylcrP4yWy2iRU4hMq3iKmIFX8c1CmC7gdfm667+JC0HXts09l7IUWA5W4eqPGRjMYPFPXEEycAPKQJQxVc2AzY4IuXmz7dlvS9nI3XsY0aLyWBV9tHJ9waXQTI3YgcatYtSsdAlNZMuYDZgiYuNYB61B3DwAX0DWi42ooobGvNV7THqkqA+ADsvbMkmVq7pI2H6RUFlKCmHULLZFNt8BbtYpqNDYiX8mHkFXGQWPb/9XqcEg752UdbPdisZXuyCcYBKX/CqxpmuLjTXhtroDjNt1UXXgz1OgJMx2CcvdeFavNeLHON9CUXhJpMGMod41+aMrlMUjlBbbYlT2oQJyjsE3cQehqi8BHyX6aaTBShFpb/ppcssIhpR6RQV6RUM6zENZWzQZ9W1Cu+7VQ9Weiw8VHyBK3lZ+zUI0l2F9k3qmdsLnK5QZ5Liw1QHIK3/TLth2IBz1HHTUwzFaTc/Xf8wr8g4vechsDm+1mqubWdXJVLqdOMq1q/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199015)(31686004)(66899015)(83380400001)(36756003)(55236004)(53546011)(6512007)(6506007)(122000001)(2906002)(26005)(31696002)(110136005)(54906003)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(8676002)(8936002)(186003)(2616005)(41300700001)(478600001)(6486002)(966005)(86362001)(38070700005)(91956017)(316002)(5660300002)(71200400001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rmw3SjR5VFhaNFB4NTZmNEN6NDB3eUtEclYycnhCMFg4QzA3bndpM2s5S2dF?=
 =?utf-8?B?WGZoMkRJVnBldFRKckR2NThUeERmYVJKK2xFTG5ib2VlNzRUOHVWZDUzU2ND?=
 =?utf-8?B?NnBDb2QyYmRUR3ZEaWZHZFA1RlZpT3dnUTRRTTNGNWwyc3k2LzAwYkpPUEFT?=
 =?utf-8?B?YTVoRFJzV1hEOEJ0MmxNeURhTWg5VGFtR24xcUkvMDRjcHAxWjFPTEV0SUNX?=
 =?utf-8?B?RWcvSk11Z2lFS2NtYzFGV0QrWTA5cjFQZXA3b1dSNzFnL2gydVNIQVRvaEt0?=
 =?utf-8?B?aHE5eGlHcDl1V2VrcE1HMml1eUE1cllvSENnSzF2UUZMcXpBRlg1U1AwamdL?=
 =?utf-8?B?SjNoRDFFb2JQZnZrcGtka2lmbllUMHB0anVlVjFFS0pqK3RnQ1IveG4zOXVV?=
 =?utf-8?B?TjMwVG5hTFNLaVJpay9KVkd1N3Vxck9CeFQyUVBIVURmVkNwYmVVZWlIeUhM?=
 =?utf-8?B?THB2Q1BQYzY2RGV5SSs2SFllejFpMHRsbkRHdDQvS1QxdnlZMG9Md29MVkFO?=
 =?utf-8?B?NWpCSklaU0xqSVZ2WlYvOTdWdTBDc3NheDV5Zi92STZ0QzQrK01NMkdmaUhI?=
 =?utf-8?B?V1VZaTlnMEpsUm1sSW1sVFFRVTEzVXdOdXRFZVdyRkgyeHV2dWVLbDRQeU9j?=
 =?utf-8?B?VUdsRkZaa3NKK3BYOC94OHQweWZFNWd1NVdnZUJqK0Z2aWF6dDJicFd4aktG?=
 =?utf-8?B?cDhTVFNoZTRheFNzcmdCZnpoMkJqVVAxQnlBQ01UYjdqTFZXckwwY3ltVGZ0?=
 =?utf-8?B?VnBUb1lHWnJxSHFKSEplYU1XTzNWbWN6dnJJR2lpZE4vblZIcXhSNS93a2gr?=
 =?utf-8?B?N2tjTXo2ZmdkVC80ei9KbWZxakRvK1Z2di9OdmtwYkVUODY2aXVjRWQzQ0Zr?=
 =?utf-8?B?Z1g5eGh5eVBLQ1l4cyt0V3R4c2NpaU9vUGJta0h2eFozamY0R1VodUY5ajZU?=
 =?utf-8?B?elN6L3hFdEZCWktwVjZoUWhtM0xFcG1BNVJCQ0ROdS9wNFVSeFliSmpkWFZ3?=
 =?utf-8?B?VzVzVVFLRndjYmpaMm80djR1YXhlbjNjWXRMNXpMcTU0Z2ZvRkhyWmpFbGlC?=
 =?utf-8?B?eW1EM3U1a2lhc3FBQk1HS3NRaG1LNFE1TDJnTUdMc3lobGtWRThMVUFkR3pI?=
 =?utf-8?B?bWFEQmt0U3NGSVR0MmRtQXdrcURCWVBHSEJMTWsxS2pIazZGTDBFOUs4VnNl?=
 =?utf-8?B?bFk2VnpFOG9TRG45S2hRL2tab1ZXMGpUM3JBbTNsNFRpMFRBWGNDUWRoYml1?=
 =?utf-8?B?ODZySjZvWURoeXg1azhzZ0o2Ukd4OHIyQzZTSXhxeHdRckxibjNtdEEwMyt6?=
 =?utf-8?B?dGhsckd5V3NXTVhicXUzNVA2M3hwdWxXSmdiSXUyYW1BdzZUVVJDT01YWGow?=
 =?utf-8?B?NHN4TWVhVnBtOTJON0FVRC83a1RCdXZ6b2NsdUhzUG5QODJaTkthTktZNEhT?=
 =?utf-8?B?ZkNtLzdBYTF6SEpiMmNyMStDYmRCaW1MTFUzRmFhb1RVWmVZbWZwSFdzcEcx?=
 =?utf-8?B?QUxmNkhJNENPZ3lSTzBYcTVDcXNuaFYvRkRoZHlFcDBrZmJJS3RTUzR3QW10?=
 =?utf-8?B?aXc2dmdkQi9FMHlaUHAvaGF1VVlmSW11UEo5M2lqbTF3amc4aFdyK2pBR2tO?=
 =?utf-8?B?OVlrczROTUhOSTQxbUNicmpqN0I4alhRVzBZeW5oRk9LMnRkRWVITy9TYkhV?=
 =?utf-8?B?YndJSm5BV2ZmdUtpUmVRWC8vVWNTR0g2b09laUgzQ2V0b0xBVlFZMUFqRmNZ?=
 =?utf-8?B?Qm9zTnc5OE9ORm1uTUdQV2Fvd1hBeC9uYStySDJkUVYwOUxhcUVvTC8wRWR3?=
 =?utf-8?B?TU9UeGg3ZFA4K1NtbzlBVGtuRDFUQk96dlNiS24vcnIyZVVLUlE4cjBUbFdQ?=
 =?utf-8?B?M2c3bnAwd29IaWh4ZW1FWkp1Y0FqQ040R29GdG5SNnMyYjZZWndUOFQ5dHpR?=
 =?utf-8?B?dk81emVJMEg1WE03T0hMb1RsVEFBTXUyYWZ2dGtOV082bG5UTm5rSUhKQXNC?=
 =?utf-8?B?Q2J2Qm1MdzZXK2tMUENJZmpkcVU0MWM1cFZOOVB4M05pL0NVeFZ0U1VUdFFH?=
 =?utf-8?B?S3pUd0w2WTNzY0JhSXZnaHdNUE1DNDJsWFowSDhrUzlJaEZDV3kxQUpUcGtW?=
 =?utf-8?B?L3Y3OHRMUml4RlRKbXlIa2R5aXRVMkpaWXZsSG5pMnhOVDNKMTBFVk5vaEJs?=
 =?utf-8?Q?uFO8J+UAJWa5p26lw5Se9Ws=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47C1A15E5A2FEE459963495B6C3544E1@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00cf335-9a42-43e6-c8b9-08daa9300bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2022 13:21:44.5864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADZXUvNI3NG1395ZMnwf7AWMIFyUMUT/SfDuRA/wsAufiIVuxIBxAZNhZhFL+IfVMOBMrgkbCXptpUt2LUgZLJWRhqbDL9hL2MZZdcQEhLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR03MB8192
X-Proofpoint-ORIG-GUID: vbSfc4yvM6uA19YxpM870IBr80CaxRKI
X-Proofpoint-GUID: vbSfc4yvM6uA19YxpM870IBr80CaxRKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210080085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAwOC4xMC4yMiAxNTo1OSwgWGVuaWEgUmFnaWFkYWtvdSB3cm90ZToNCg0KSGVsbG8gWGVu
aWENCg0KPg0KPiBPbiAxMC84LzIyIDE1OjUyLCBPbGVrc2FuZHIgVHlzaGNoZW5rbyB3cm90ZToN
Cj4+DQo+PiBPbiAwOC4xMC4yMiAxNDowOCwgWGVuaWEgUmFnaWFkYWtvdSB3cm90ZToNCj4+DQo+
PiBIZWxsbyBYZW5pYQ0KPj4NCj4+Pg0KPj4+IE9uIDEwLzcvMjIgMTY6MjcsIE9sZWtzYW5kciBU
eXNoY2hlbmtvIHdyb3RlOg0KPj4+DQo+Pj4gSGkgT2xla3NhbmRyDQo+Pj4NCj4+Pj4gRnJvbTog
T2xla3NhbmRyIFR5c2hjaGVua28gPG9sZWtzYW5kcl90eXNoY2hlbmtvQGVwYW0uY29tPg0KPj4+
Pg0KPj4+PiBQYXNzZWQgdG8geGVuX2dyYW50X2RtYV9tYXBfcGFnZSgpIG9mZnNldCBpbiB0aGUg
cGFnZQ0KPj4+PiBjYW4gYmUgPiBQQUdFX1NJWkUgZXZlbiBpZiB0aGUgZ3Vlc3QgdXNlcyB0aGUg
c2FtZSBwYWdlIGdyYW51bGFyaXR5DQo+Pj4+IGFzIFhlbiAoNEtCKS4NCj4+Pj4NCj4+Pj4gQmVm
b3JlIGN1cnJlbnQgcGF0Y2gsIGlmIHN1Y2ggY2FzZSBoYXBwZW5lZCB3ZSBlbmRlZCB1cCBwcm92
aWRpbmcNCj4+Pj4gZ3JhbnRzIGZvciB0aGUgd2hvbGUgcmVnaW9uIGluIHhlbl9ncmFudF9kbWFf
bWFwX3BhZ2UoKSB3aGljaA0KPj4+PiB3YXMgcmVhbGx5IHVubmVjZXNzYXJ5LiBUaGUgbW9yZSwg
d2UgZW5kZWQgdXAgbm90IHJlbGVhc2luZyBhbGwNCj4+Pj4gZ3JhbnRzIHdoaWNoIHJlcHJlc2Vu
dGVkIHRoYXQgcmVnaW9uIGluIHhlbl9ncmFudF9kbWFfdW5tYXBfcGFnZSgpLg0KPj4+Pg0KPj4+
PiBDdXJyZW50IHBhdGNoIHVwZGF0ZXMgdGhlIGNvZGUgdG8gYmUgYWJsZSB0byBkZWFsIHdpdGgg
c3VjaCBjYXNlcy4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogT2xla3NhbmRyIFR5c2hjaGVu
a28gPG9sZWtzYW5kcl90eXNoY2hlbmtvQGVwYW0uY29tPg0KPj4+PiAtLS0NCj4+Pj4gQ2M6IEp1
ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+Pj4gQ2M6IFhlbmlhIFJhZ2lhZGFrb3Ug
PGJ1cnphbG9kb3dhQGdtYWlsLmNvbT4NCj4+Pj4NCj4+Pj4gRGVwZW5zIG9uOg0KPj4+PiBodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcveGVuLWRldmVs
LzIwMjIxMDA1MTc0ODIzLjE4MDA3NjEtMS1vbGVrc3R5c2hAZ21haWwuY29tL19fOyEhR0ZfMjlk
YmNRSVVCUEEheG5rTmFLcGZaNExzc1FKY0pzX0o5MUtFUlpLTVAyUmQteEVkQnFYTlhKOEd5Q1hK
MGdrUmVyMWVsVllmeE9XdHdOX0ZPbDl0VmllRFdsZk4tVVphSFFzeUxNaEEkIA0KPj4+Pg0KPj4+
PiBbbG9yZVsuXWtlcm5lbFsuXW9yZ10NCj4+Pj4NCj4+Pj4gU2hvdWxkIGdvIGluIG9ubHkgYWZ0
ZXIgdGhhdCBzZXJpZXMuDQo+Pj4+IC0tLQ0KPj4+PiDCoMKgIGRyaXZlcnMveGVuL2dyYW50LWRt
YS1vcHMuYyB8IDggKysrKystLS0NCj4+Pj4gwqDCoCAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94
ZW4vZ3JhbnQtZG1hLW9wcy5jIGIvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+Pj4+IGlu
ZGV4IGM2NmY1NmQyNDAxMy4uMTM4NWYwZTY4NmZlIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJz
L3hlbi9ncmFudC1kbWEtb3BzLmMNCj4+Pj4gKysrIGIvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9w
cy5jDQo+Pj4+IEBAIC0xNjgsNyArMTY4LDkgQEAgc3RhdGljIGRtYV9hZGRyX3QgeGVuX2dyYW50
X2RtYV9tYXBfcGFnZShzdHJ1Y3QNCj4+Pj4gZGV2aWNlICpkZXYsIHN0cnVjdCBwYWdlICpwYWdl
LA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVu
c2lnbmVkIGxvbmcgYXR0cnMpDQo+Pj4+IMKgwqAgew0KPj4+PiDCoMKgwqDCoMKgwqAgc3RydWN0
IHhlbl9ncmFudF9kbWFfZGF0YSAqZGF0YTsNCj4+Pj4gLcKgwqDCoCB1bnNpZ25lZCBpbnQgaSwg
bl9wYWdlcyA9IFBGTl9VUChvZmZzZXQgKyBzaXplKTsNCj4+Pj4gK8KgwqDCoCB1bnNpZ25lZCBs
b25nIGRtYV9vZmZzZXQgPSBvZmZzZXRfaW5fcGFnZShvZmZzZXQpLA0KPj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBnZm5fb2Zmc2V0ID0gUEZOX0RPV04ob2Zmc2V0KTsNCj4+Pj4gK8KgwqDC
oCB1bnNpZ25lZCBpbnQgaSwgbl9wYWdlcyA9IFBGTl9VUChkbWFfb2Zmc2V0ICsgc2l6ZSk7DQo+
Pj4NCj4+PiBJSVVDLCB0aGUgYWJvdmUgd2l0aCBhIGxhdGVyIHBhdGNoIHdpbGwgYmVjb21lOg0K
Pj4+DQo+Pj4gZG1hX29mZnNldCA9IHhlbl9vZmZzZXRfaW5fcGFnZShvZmZzZXQpDQo+Pj4gZ2Zu
X29mZnNldCA9IFhFTl9QRk5fRE9XTihvZmZzZXQpDQo+Pj4gbl9wYWdlcyA9IFhFTl9QRk5fVVAo
ZG1hX29mZnNldCArIHNpemUpDQo+Pg0KPj4NCj4+IElmIHNheWluZyAibGF0ZXIiIHBhdGNoIHlv
dSBtZWFudCAieGVuL3ZpcnRpbzogQ29udmVydA0KPj4gUEFHRV9TSVpFL1BBR0VfU0hJRlQvUEZO
X1VQIHRvIFhlbiBjb3VudGVycGFydHMiIHRoZW4geWVzLCBleGFjdGx5Lg0KPg0KPiBBaCBvaywg
SSBzZWUuDQo+DQo+Pj4NCj4+Pg0KPj4+PiDCoMKgwqDCoMKgwqAgZ3JhbnRfcmVmX3QgZ3JhbnQ7
DQo+Pj4+IMKgwqDCoMKgwqDCoCBkbWFfYWRkcl90IGRtYV9oYW5kbGU7DQo+Pj4+IMKgwqAgQEAg
LTE4NywxMCArMTg5LDEwIEBAIHN0YXRpYyBkbWFfYWRkcl90DQo+Pj4+IHhlbl9ncmFudF9kbWFf
bWFwX3BhZ2Uoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgcGFnZSAqcGFnZSwNCj4+Pj4gwqDC
oCDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBuX3BhZ2VzOyBpKyspIHsNCj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZ250dGFiX2dyYW50X2ZvcmVpZ25fYWNjZXNzX3JlZihncmFudCArIGks
DQo+Pj4+IGRhdGEtPmJhY2tlbmRfZG9taWQsDQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgeGVuX3BhZ2VfdG9fZ2ZuKHBhZ2UpICsgaSwgZGlyID09IERNQV9UT19ERVZJQ0Up
Ow0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHhlbl9wYWdlX3RvX2dmbihw
YWdlKSArIGkgKyBnZm5fb2Zmc2V0LCBkaXIgPT0NCj4+Pj4gRE1BX1RPX0RFVklDRSk7DQo+Pj4N
Cj4+PiBIZXJlLCB3aHkgdGhlIHBmbiBpcyBub3QgY2FsY3VsYXRlZCBiZWZvcmUgcGFzc2luZyBp
dCB0byBwZm5fdG9fZ2ZuKCk/DQo+Pj4gSSBtZWFuIHN0aCBsaWtlIHBmbl90b19nZm4ocGFnZV90
b194ZW5fcGZuKHBhZ2UpICsgZ2ZuX29mZnNldCArIGkpDQo+Pg0KPj4gVGhlIGdmbl9vZmZzZXQg
aXMganVzdCBhIGNvbnN0IHZhbHVlIGhlcmUsIHdoaWNoIGp1c3QgbWVhbnMgaG93IG1hbnkNCj4+
IGdmbnMgd2Ugc2hvdWxkIHNraXAuIEJ1dCAuLi4NCj4+DQo+PiAuLi4gSSB0aGluaywgSSBnZXQg
eW91ciBwb2ludC4gU28sIGlmIHRoZSByZWdpb24gd2hpY2ggaXMgY29udGlndW91cyBpbg0KPj4g
cGZuIG1pZ2h0IGJlIG5vbi1jb250aWd1b3VzIGluIGdmbiAod2hpY2ggc2VlbXMgdG8gYmUgdGhl
IGNhc2UgZm9yIHg4NidzDQo+PiBQViwgYnV0IEkgbWF5IG1pc3Rha2UpIHdlIHNob3VsZCBpbmRl
ZWQgdXNlIG9wZW4tY29kZWQNCj4+DQo+PiBjb25zdHJ1Y3Rpb24gInBmbl90b19nZm4ocGFnZV90
b194ZW5fcGZuKHBhZ2UpICsgZ2ZuX29mZnNldCArIGkpIi7CoCBBbmQNCj4+IHRoZSBnZm5fb2Zm
c2V0IHNob3VsZCBiZSByZW5hbWVkIHRvIHBmbl9vZmZzZXQgdGhlbi4NCj4+DQo+Pg0KPj4gQ29y
cmVjdD8NCj4NCj4gWWVzLCB0aGF0ICdzIHdoYXQgSSBoYWQgaW4gbWluZCB1bmxlc3MgSSAnbSBt
aXNzaW5nIHN0aC4NCg0KDQpvaywgdGhhbmtzIGZvciBjb25maXJtaW5nLiBTbyBJIHdpbGwgY3Jl
YXRlIFYyIHRoZW4uDQoNCg0KPg0KPj4+DQo+Pj4+IMKgwqDCoMKgwqDCoCB9DQo+Pj4+IMKgwqAg
LcKgwqDCoCBkbWFfaGFuZGxlID0gZ3JhbnRfdG9fZG1hKGdyYW50KSArIG9mZnNldDsNCj4+Pj4g
K8KgwqDCoCBkbWFfaGFuZGxlID0gZ3JhbnRfdG9fZG1hKGdyYW50KSArIGRtYV9vZmZzZXQ7DQo+
Pj4+IMKgwqAgwqDCoMKgwqDCoCByZXR1cm4gZG1hX2hhbmRsZTsNCj4+Pj4gwqDCoCB9DQo+Pj4N
Cj4NCi0tIA0KUmVnYXJkcywNCg0KT2xla3NhbmRyIFR5c2hjaGVua28NCg==
