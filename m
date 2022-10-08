Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529895F8540
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 14:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJHMwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 08:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJHMwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 08:52:15 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A8446DB8
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 05:52:13 -0700 (PDT)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 298911uO012561;
        Sat, 8 Oct 2022 12:52:04 GMT
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3k31j68qbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Oct 2022 12:52:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOaiaA7tLOwLS2SYknu2iPzAUN4E6tQORHyCSZRXw2RYvOHiwixqYaZPiGa4jYfgDosBKwB/uh77OsRAuZxLGbMZk6Y9f2/jWU4PElFjecN11sxTKpyo5prlF56wbk5KAypM+rH/J6Iq9LRNFIUt1pOKvo1o3ZwKgZFMcyxoEq7K1v2ai9b0b/v4aEPbkPEQPC/g7oqscxUVmJjGfoyZtPxj8t6heIBxfmAaYgnRktO2Vgf7NtVq90p+siN1huG61+JjaiWYIXIp/ZTILAMBrtsWGK4EGX7OHWFiHcPQqcYthXFu1PlIeABWpYJ96GInrrNRuDNDXn06ViTYdEpl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebOG11VqUSl46Rl8uhBp/KlV214XTtkqQQFSfMCps/g=;
 b=gHICtnPakGqiGvqG/BFg0jQlXJ6yMk5Az1me9NN6Tj6TJGcB4dCUzGiwfdg6pXTO6S1iWr/3TqBqChHPx3Bj8vzXdt6Tj2Sde1bxvMSF0HP692hVLfvO0NZjfWXpabdJEad4I966xnbTIk/QMpj4hKY1cVY1igcpzYgx89nCxg561cHfg7AQx72VpFkDKjygh26Dnkt445h5bGVVlYauqsGtNaKhzoHr2gsX0V762TfIwrpCo/WM6XVwnQo8F5AB5/+oEEOHQWrHgvE/gh/Lpx28ZInuBpr5Oex2dyEgMgZ9cdAjpJcn30J2JJdPMoJoYvu47IkUX1SoW5I+1TMgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebOG11VqUSl46Rl8uhBp/KlV214XTtkqQQFSfMCps/g=;
 b=qDcl3PRolhKQFLUqTg7bx1WoZvzGALNw8ManY+CkyJK/nu/Z0amwS17I2ngCaRYshpgAutX61v4N+Kx/WMIYwwEg3Sozjgp0K+ek8EvV5A36nfvcxprhh/+aMZGjMgrtQpMcH6ZEuIUsB/y8Unkh+tsS4uArgeNCAiFbO8iCJ3nQpvWzAZ8S1PlTP/FLlk6+TveLXwlOdpk5ukh0O4Csv9fRdpDFB2FGCSJUNETi1RmsIQ9HwvBG/RzPb/qWu1jmnCIhXIHy6m44ZvpfKCv3iq9Ms7+Oa6VAbfCmqDhihykmV2sIDZlQKziAj0Gq7WQ1PqZ8i2JlVl2WqKDC2YlAFw==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AM9PR03MB6866.eurprd03.prod.outlook.com (2603:10a6:20b:286::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sat, 8 Oct
 2022 12:52:02 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::93be:22b1:654c:e4bc]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::93be:22b1:654c:e4bc%5]) with mapi id 15.20.5676.038; Sat, 8 Oct 2022
 12:52:02 +0000
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
Thread-Index: AQHY2lCewf5wqMeDhkqfFwKHpttMBq4EV/CAgAAc7QA=
Date:   Sat, 8 Oct 2022 12:52:01 +0000
Message-ID: <d6ec5092-8d93-22c2-7b6e-944ad88ad582@epam.com>
References: <20221007132736.2275574-1-olekstysh@gmail.com>
 <6e33b687-8862-d208-a707-77a95c61525e@gmail.com>
In-Reply-To: <6e33b687-8862-d208-a707-77a95c61525e@gmail.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|AM9PR03MB6866:EE_
x-ms-office365-filtering-correlation-id: 449b4b5a-6d44-48dd-f8e3-08daa92be533
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IYHIrF4EAk9BJno2t4meT1DuHODPQ8w3xQ6j1rqoIY82/i0xjeu0SHmguFW6Fd29cfUcPEmkIFeedyR5GiTN5fTAGX9IjpahejRw7hhhZPJ4kNGOEcgIeo2HVpvuefz8DaNfpTT1UCH5InTiQ63RtlCxI2Mi3Ey5NV3nzcIW6a51KtcM4HJ5+nvwPSLYCkFeDkzZ1Fo/43KiUAej9P0vjW8ihrr/fybfo5r9cIFDyvHXEAxmfr50VsCGKOU7PXlpKaw08uRGMnwFlZplIk3qOFTYo69cGBKGXQVyd6SsE0U1Ep2BRM7xpxYP3BjraHDeACsgmSg99VhH1OajG6Q+YXCTWJuy5RyT/4ZHGqmgiof8GKSNSP7lGL5StGvzL+NtUlVbJqPdITI+ANXRyF/g1c00COwZ2sTAx0OHC1kc7EPfF5KnCsH4suYwOIFBpVeGhG3+/jFfykDyKpbSVbi0GGIwlDiOq63HEAEbwS9mYe3IBmqgO6+W5cWNLB+IFujrkOObKglh9Zm8s5WdJhXLKrrZBSbXNiPcqiMltzj6W+eVBabZGlTPvfdgPx2aj9NDL0tFM2fyoMEbPs+moKEUJIQ9l48fANbDHD38B3+C0C2TiEhQqCNr2Bmtdq1erhbltnfIElErxeEVYvh0fnq/29lGmM/RmQncLNl0bBXmoZ7IzctRBHULbYYkNQSQRmfiGuwIJYQLMUtW0IsCgTkd04bX0dQBqUphA7pp1GFK0IFWBx4VQFgGe4UNub00uU76rQL8OAx5BklMkr+L/9KDnpmg4F+d5vPP/RsoZnxjL+40wFTvs1zR6MbO+9wv1zJt0cuY6MMESYcfeGiZlyapeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199015)(86362001)(31696002)(36756003)(38070700005)(38100700002)(122000001)(91956017)(8676002)(4326008)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(71200400001)(316002)(110136005)(54906003)(2906002)(41300700001)(8936002)(5660300002)(186003)(83380400001)(2616005)(6486002)(966005)(478600001)(6512007)(6506007)(26005)(55236004)(53546011)(66899015)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1g4Ulo0TjJvUW96RWF4ZHk0Nk5maXBvQktXSmQ1YjNYaXRIamhGOXg5UUJw?=
 =?utf-8?B?MU5mNHYrdzFaSERyaklucEh1c0pqVjk1Mi9pWkJCVGxUTWxpQ0htSUdIeDlw?=
 =?utf-8?B?TEprbE1ZNGloTmI1aCtWRjVmVUtaTVhqQ01ucllwQnovbXB0TTlta3dRZk9m?=
 =?utf-8?B?a0VVcEMzcE1LR3p5dUtrdmpUSXE1OEFNMS9JY1VJWGJweWpJUUFqbDM4b2pq?=
 =?utf-8?B?VDQyYkdaVVVuNUhkVUl2azZ0MncwZk1uSFdsb2RJem5STXE0VzlQb2hwRlJp?=
 =?utf-8?B?U1FNRXYxSmZlZUUyNWVVOXNHQlJWMk45YW51Z0ZJaURFY2pDcXZLWTVyYXZp?=
 =?utf-8?B?VE5XMHhUMkNSVzVzR1MyRHlIY3BSNERVd3VlYlBYaVN6NDNpUzZtNlhMUjZF?=
 =?utf-8?B?ekRLa1djQkJRNklxSUFOTDRkeDE5TGNSRE5lWXJwQ3dIME80SEJEbHFZZzVE?=
 =?utf-8?B?Q29oSGVLaUorYXNPanhtNW5lOFB0WGRRTit2cXkxQ0VVTld3SlNhK29qZXRh?=
 =?utf-8?B?MlNXZGF4OGhKeHBXTWloNGZvTzZtdGN5SXo5N00rWnc4a3EyU1Y5bHNPR2V5?=
 =?utf-8?B?NE5VL2xxb21Tc2N4czNxT0swY0NxU09iREt2OVh3b2QrMHVnRFVGYjdaSmVp?=
 =?utf-8?B?TlVyK3Vja1RMR1paK1NaUkFDV3BYT3k2Z1BMbmJGWGJYckhhdzJST2FxaXJF?=
 =?utf-8?B?dDRDSmNYQmZIS3RNUFBZUGFjQlFVNGNIMG4vdEl3dHRNWEt2MUdpQjY4d1cy?=
 =?utf-8?B?bHhTRDdpUXNDZkhrUkxXUE82T3ROaWFnc2FWQlhUdURzSmZrT0xoTUZxdThq?=
 =?utf-8?B?NmRSZHlCQlVKUkhnd2xScFZHNlBsYW9wUFMyYUtXSEpyaUJVcElHZ1VpcVpp?=
 =?utf-8?B?RkJtVWpVaS80VENTUmd0MGI1dGh2RFE4U25uZmJJSWo4bTltakxKNUU3dTBS?=
 =?utf-8?B?bktybkFhSG5ET2p1NXdzc2pFMFNIa09IN0E0UXA4WFpSd0VGNmZWdFFBUVlX?=
 =?utf-8?B?TnRMU1BmTXdVcjdSeTdsRVJNejBxMXEybEZ4MEtiaEQ1ZlNjajNRUkxDQk5W?=
 =?utf-8?B?ZlVmZEoreDMzb2Y5UGpyRWpVZVEzV0pIOHVrdW1zYkRqOEFlWTN1aWhFQTZI?=
 =?utf-8?B?aWVISUtKWWVGb0htdENCSVhtMzUzL1JoSmh6S2F6cnZITzhwdTZxaXlaRnZT?=
 =?utf-8?B?ZEdabUFTd3kraFR5VU5jS0VTS0J2SFZFMVBzTDFkdTRueCtGZlZBUnY3MW9p?=
 =?utf-8?B?RktuWEtVbFNrQjFvd2FYeXhmSy9oTWh5SzlWRnRLMXhOUmZxOVNoTEVCQTBS?=
 =?utf-8?B?UHpUOHpVM0htbEZHcEo5aFRyLzl5OG9wVTgyZk92eVYxdnVQSkRCdzV0UDhJ?=
 =?utf-8?B?T3Ftd0lNeks2WGtkOGlQZGE3YWFXUG94cGNCSCs4UzRFaE5vZG5abEVvNG8v?=
 =?utf-8?B?Um95cXRCbFdmOE1lRGpXemtnemN5VzhHRlFheXZFVmVhOER6RlFSTnF4RXN5?=
 =?utf-8?B?a2oyYWhWcDhQWnhETVNZQlZMMnRLVkRrUG1UQUdGUi94MXpLdURKRmxFKzJx?=
 =?utf-8?B?NWVDTEk4L1JYblRrM3RFWFpjRXJvSUNhV0xNMzZlY2lwSExaWEJuUlI1VC9p?=
 =?utf-8?B?T2pPUjVMN2hYQVVmL2Z3dzVWOFBROG5YSTZENDJMU1B5aWdJVnZRUTN2R1Zs?=
 =?utf-8?B?SjhkL2ZMdUV4UUQ2YytBUDU5dTlGQlBRY3lhV0RFWkNsUEZHUDVmYXQ1TXJC?=
 =?utf-8?B?bHpFaTN1WUdqbkdCeUJqTDlqWFlwZ0t6YnJBaUxVV0hVTGViRHNKSW1qelY4?=
 =?utf-8?B?U1EySGs0cktuQ1VwclNoQkdwcmNoTWJzS3U1Zis0K1gxNWg1WmE4SERKZ0xR?=
 =?utf-8?B?RzZlZXEvOU9kZkhTOHZhbXV1QkhhYUd3eGZBK0VvRlA0N1gvVlNZZEs0ZUxr?=
 =?utf-8?B?cnUwNXJ0TGtkVnRRV1E3c3Q0ZnRrL2QwTVFqQjJ4M0Ztd1JIVmJtRXlvSEdU?=
 =?utf-8?B?TGRUSy9TNkM0NXQ5OFI4Q2NJdGtEdGxNQk5pWnJST1RROGtjNE9xdStqMGxI?=
 =?utf-8?B?YzY4ekhYZXNWc3VqVWxHUGEyOGhkV3ZOVW50ek8vOFZKQnUxSVZ2Vy9yd0RK?=
 =?utf-8?B?ak94K3ZzOUg2eEV4L3RWc0FjaW1PdisrdTJkOE9za2JhMWxuTnMvVjBvZTY0?=
 =?utf-8?Q?jvYHWYZ/bFqlrv0IQhl85TQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81926CB25B1D1E49BF38265666E59273@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449b4b5a-6d44-48dd-f8e3-08daa92be533
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2022 12:52:01.9954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IXMZYSgfW8wvUpk0y86xUGCPcmJ5k87aq7y72DeZqXJzeefYBhjiQFRP7GN/f2wiUGKvaHA4Uia4u09TgiuaGDtBadlf2xu4UuhCnV1NDy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6866
X-Proofpoint-GUID: mpIPI5_NwG7Xx1NvbU1U1gva-l2aaEad
X-Proofpoint-ORIG-GUID: mpIPI5_NwG7Xx1NvbU1U1gva-l2aaEad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210080081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAwOC4xMC4yMiAxNDowOCwgWGVuaWEgUmFnaWFkYWtvdSB3cm90ZToNCg0KSGVsbG8gWGVu
aWENCg0KPg0KPiBPbiAxMC83LzIyIDE2OjI3LCBPbGVrc2FuZHIgVHlzaGNoZW5rbyB3cm90ZToN
Cj4NCj4gSGkgT2xla3NhbmRyDQo+DQo+PiBGcm9tOiBPbGVrc2FuZHIgVHlzaGNoZW5rbyA8b2xl
a3NhbmRyX3R5c2hjaGVua29AZXBhbS5jb20+DQo+Pg0KPj4gUGFzc2VkIHRvIHhlbl9ncmFudF9k
bWFfbWFwX3BhZ2UoKSBvZmZzZXQgaW4gdGhlIHBhZ2UNCj4+IGNhbiBiZSA+IFBBR0VfU0laRSBl
dmVuIGlmIHRoZSBndWVzdCB1c2VzIHRoZSBzYW1lIHBhZ2UgZ3JhbnVsYXJpdHkNCj4+IGFzIFhl
biAoNEtCKS4NCj4+DQo+PiBCZWZvcmUgY3VycmVudCBwYXRjaCwgaWYgc3VjaCBjYXNlIGhhcHBl
bmVkIHdlIGVuZGVkIHVwIHByb3ZpZGluZw0KPj4gZ3JhbnRzIGZvciB0aGUgd2hvbGUgcmVnaW9u
IGluIHhlbl9ncmFudF9kbWFfbWFwX3BhZ2UoKSB3aGljaA0KPj4gd2FzIHJlYWxseSB1bm5lY2Vz
c2FyeS4gVGhlIG1vcmUsIHdlIGVuZGVkIHVwIG5vdCByZWxlYXNpbmcgYWxsDQo+PiBncmFudHMg
d2hpY2ggcmVwcmVzZW50ZWQgdGhhdCByZWdpb24gaW4geGVuX2dyYW50X2RtYV91bm1hcF9wYWdl
KCkuDQo+Pg0KPj4gQ3VycmVudCBwYXRjaCB1cGRhdGVzIHRoZSBjb2RlIHRvIGJlIGFibGUgdG8g
ZGVhbCB3aXRoIHN1Y2ggY2FzZXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogT2xla3NhbmRyIFR5
c2hjaGVua28gPG9sZWtzYW5kcl90eXNoY2hlbmtvQGVwYW0uY29tPg0KPj4gLS0tDQo+PiBDYzog
SnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPj4gQ2M6IFhlbmlhIFJhZ2lhZGFrb3Ug
PGJ1cnphbG9kb3dhQGdtYWlsLmNvbT4NCj4+DQo+PiBEZXBlbnMgb246DQo+PiBodHRwczovL3Vy
bGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcveGVuLWRldmVsLzIwMjIx
MDA1MTc0ODIzLjE4MDA3NjEtMS1vbGVrc3R5c2hAZ21haWwuY29tL19fOyEhR0ZfMjlkYmNRSVVC
UEEheG5rTmFLcGZaNExzc1FKY0pzX0o5MUtFUlpLTVAyUmQteEVkQnFYTlhKOEd5Q1hKMGdrUmVy
MWVsVllmeE9XdHdOX0ZPbDl0VmllRFdsZk4tVVphSFFzeUxNaEEkIA0KPj4gW2xvcmVbLl1rZXJu
ZWxbLl1vcmddDQo+Pg0KPj4gU2hvdWxkIGdvIGluIG9ubHkgYWZ0ZXIgdGhhdCBzZXJpZXMuDQo+
PiAtLS0NCj4+IMKgIGRyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYyB8IDggKysrKystLS0NCj4+
IMKgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYyBiL2RyaXZlcnMveGVu
L2dyYW50LWRtYS1vcHMuYw0KPj4gaW5kZXggYzY2ZjU2ZDI0MDEzLi4xMzg1ZjBlNjg2ZmUgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMNCj4+ICsrKyBiL2RyaXZl
cnMveGVuL2dyYW50LWRtYS1vcHMuYw0KPj4gQEAgLTE2OCw3ICsxNjgsOSBAQCBzdGF0aWMgZG1h
X2FkZHJfdCB4ZW5fZ3JhbnRfZG1hX21hcF9wYWdlKHN0cnVjdCANCj4+IGRldmljZSAqZGV2LCBz
dHJ1Y3QgcGFnZSAqcGFnZSwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgYXR0cnMpDQo+PiDCoCB7DQo+PiDCoMKgwqDCoMKgIHN0
cnVjdCB4ZW5fZ3JhbnRfZG1hX2RhdGEgKmRhdGE7DQo+PiAtwqDCoMKgIHVuc2lnbmVkIGludCBp
LCBuX3BhZ2VzID0gUEZOX1VQKG9mZnNldCArIHNpemUpOw0KPj4gK8KgwqDCoCB1bnNpZ25lZCBs
b25nIGRtYV9vZmZzZXQgPSBvZmZzZXRfaW5fcGFnZShvZmZzZXQpLA0KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZ2ZuX29mZnNldCA9IFBGTl9ET1dOKG9mZnNldCk7DQo+PiArwqDCoMKgIHVu
c2lnbmVkIGludCBpLCBuX3BhZ2VzID0gUEZOX1VQKGRtYV9vZmZzZXQgKyBzaXplKTsNCj4NCj4g
SUlVQywgdGhlIGFib3ZlIHdpdGggYSBsYXRlciBwYXRjaCB3aWxsIGJlY29tZToNCj4NCj4gZG1h
X29mZnNldCA9IHhlbl9vZmZzZXRfaW5fcGFnZShvZmZzZXQpDQo+IGdmbl9vZmZzZXQgPSBYRU5f
UEZOX0RPV04ob2Zmc2V0KQ0KPiBuX3BhZ2VzID0gWEVOX1BGTl9VUChkbWFfb2Zmc2V0ICsgc2l6
ZSkNCg0KDQpJZiBzYXlpbmcgImxhdGVyIiBwYXRjaCB5b3UgbWVhbnQgInhlbi92aXJ0aW86IENv
bnZlcnQgDQpQQUdFX1NJWkUvUEFHRV9TSElGVC9QRk5fVVAgdG8gWGVuIGNvdW50ZXJwYXJ0cyIg
dGhlbiB5ZXMsIGV4YWN0bHkuDQoNCg0KPg0KPg0KPj4gwqDCoMKgwqDCoCBncmFudF9yZWZfdCBn
cmFudDsNCj4+IMKgwqDCoMKgwqAgZG1hX2FkZHJfdCBkbWFfaGFuZGxlOw0KPj4gwqAgQEAgLTE4
NywxMCArMTg5LDEwIEBAIHN0YXRpYyBkbWFfYWRkcl90IA0KPj4geGVuX2dyYW50X2RtYV9tYXBf
cGFnZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBwYWdlICpwYWdlLA0KPj4gwqAgwqDCoMKg
wqDCoCBmb3IgKGkgPSAwOyBpIDwgbl9wYWdlczsgaSsrKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgZ250dGFiX2dyYW50X2ZvcmVpZ25fYWNjZXNzX3JlZihncmFudCArIGksIA0KPj4gZGF0YS0+
YmFja2VuZF9kb21pZCwNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeGVuX3Bh
Z2VfdG9fZ2ZuKHBhZ2UpICsgaSwgZGlyID09IERNQV9UT19ERVZJQ0UpOw0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4ZW5fcGFnZV90b19nZm4ocGFnZSkgKyBpICsgZ2ZuX29m
ZnNldCwgZGlyID09IA0KPj4gRE1BX1RPX0RFVklDRSk7DQo+DQo+IEhlcmUsIHdoeSB0aGUgcGZu
IGlzIG5vdCBjYWxjdWxhdGVkIGJlZm9yZSBwYXNzaW5nIGl0IHRvIHBmbl90b19nZm4oKT8NCj4g
SSBtZWFuIHN0aCBsaWtlIHBmbl90b19nZm4ocGFnZV90b194ZW5fcGZuKHBhZ2UpICsgZ2ZuX29m
ZnNldCArIGkpDQoNClRoZSBnZm5fb2Zmc2V0IGlzIGp1c3QgYSBjb25zdCB2YWx1ZSBoZXJlLCB3
aGljaCBqdXN0IG1lYW5zIGhvdyBtYW55IA0KZ2ZucyB3ZSBzaG91bGQgc2tpcC4gQnV0IC4uLg0K
DQouLi4gSSB0aGluaywgSSBnZXQgeW91ciBwb2ludC4gU28sIGlmIHRoZSByZWdpb24gd2hpY2gg
aXMgY29udGlndW91cyBpbiANCnBmbiBtaWdodCBiZSBub24tY29udGlndW91cyBpbiBnZm4gKHdo
aWNoIHNlZW1zIHRvIGJlIHRoZSBjYXNlIGZvciB4ODYncyANClBWLCBidXQgSSBtYXkgbWlzdGFr
ZSkgd2Ugc2hvdWxkIGluZGVlZCB1c2Ugb3Blbi1jb2RlZA0KDQpjb25zdHJ1Y3Rpb24gInBmbl90
b19nZm4ocGFnZV90b194ZW5fcGZuKHBhZ2UpICsgZ2ZuX29mZnNldCArIGkpIi7CoCBBbmQgDQp0
aGUgZ2ZuX29mZnNldCBzaG91bGQgYmUgcmVuYW1lZCB0byBwZm5fb2Zmc2V0IHRoZW4uDQoNCg0K
Q29ycmVjdD8NCg0KDQpUaGFua3MuDQoNCg0KPg0KPj4gwqDCoMKgwqDCoCB9DQo+PiDCoCAtwqDC
oMKgIGRtYV9oYW5kbGUgPSBncmFudF90b19kbWEoZ3JhbnQpICsgb2Zmc2V0Ow0KPj4gK8KgwqDC
oCBkbWFfaGFuZGxlID0gZ3JhbnRfdG9fZG1hKGdyYW50KSArIGRtYV9vZmZzZXQ7DQo+PiDCoCDC
oMKgwqDCoMKgIHJldHVybiBkbWFfaGFuZGxlOw0KPj4gwqAgfQ0KPg0KLS0gDQpSZWdhcmRzLA0K
DQpPbGVrc2FuZHIgVHlzaGNoZW5rbw0K
