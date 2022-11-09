Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA286222AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiKIDhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiKIDha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:37:30 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB0995A9;
        Tue,  8 Nov 2022 19:37:29 -0800 (PST)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A92W56K000862;
        Wed, 9 Nov 2022 03:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=uw6/wkJue/kpxCVWw++uaJQ5ABpgGNjsWM14+fUOPP8=;
 b=Yd5jvOM2HobXXm4G8oj3SyP6P1BoHvAAN+DVaksLh5zV5lFeP6N3Z9SXmBAmLB78XR/M
 hEy8XgKeXkkr22NEs7tqOyyzENdlxbusz7tw2XlU6s236MqrQt1W4CQBUSY7sa3zOsRu
 fBSMGh6zXb+S+8o4Ck93f3iSbP8jBwsCCvDfQHbHFU/Yqu/uZMg1BRkKV6EgrW1c3fpd
 gr4J3A7JIen1MkwtYCf9YTotn6cmnM3IFqUTxxCYcRCL6v4sSaAqQlZCtFyyE94TeON/
 EjNpfx0vruy5dEIWbJSjYPpHSCPbTDoHYNk/wh6lMBY7rXUY/TQW89toUR54KlSDY3Nq AA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kr1cu17bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 03:37:11 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 19EC180471E;
        Wed,  9 Nov 2022 03:37:08 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Nov 2022 15:37:08 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 8 Nov 2022 15:37:08 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Nov 2022 15:37:08 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6lXDh+SCzqq0UQa/A471f/25/pSpI6Bnn5cZX7wFSkz0yQfKuVk4kcSbHpn07Lg9SD4UgpK4k+bSSsjg3vThnS1Dv2W3revj1FJulqoSopZiiOo1kgPit4f/TXLN/ELgwD7BVWal8PMKmX1XCY7jtWULzZP4t/JyTMyMZZfXTn1aOqsIzX54QmJ3YQieLAfZx7UZEcq8fstceZNbz6KTH77kN+79mkfX1g/vaVuUAR+ptok8CXQ20QBqnrl2dQRmgd0ynhsRhkwYD3snpBfHz0AUjEZBVLojVQIUIm7pxXgF1/He/vim671ZKErep9VvVVo1GyqVAgpHemF02GnsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw6/wkJue/kpxCVWw++uaJQ5ABpgGNjsWM14+fUOPP8=;
 b=Gm3XxbT7DBf29ZG/LHIOcds99asj4Yr2kTCLRfiSi2gu4SIAgZMdsZD+cUR7wHetF2mZslDzV91tNvcmubqg5rpm7gl6SQBa1Eouw73d1OpxbGmW9XB7158+jhuzZb/iojgQxLXXmCMc/Q9ZTUlMydwJTeIYn84JVFXfgXRYswBURYMt0fnDvsb6oCzX4TeA4SQWmW2utvr04vsj0NN4Ab6QvwIAg7v9or7AFsJ+mCZ0Bcip0JuaZNOxD6ayoX5nMjWfmST7fn/1n9JhT68FLy52lum88GgZZYvFRLTUvLlqdjDtuDo67BQqYSCq90PjMxDi1yqSvw3UfAU7fHVIkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:434::14)
 by MW5PR84MB1641.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Wed, 9 Nov
 2022 03:37:01 +0000
Received: from SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5ffb:817b:2f19:b2b7]) by SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5ffb:817b:2f19:b2b7%4]) with mapi id 15.20.5791.024; Wed, 9 Nov 2022
 03:37:01 +0000
From:   "Yu, Richard" <richard.yu@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Chang, Clay" <clayc@hpe.com>
Subject: RE: [PATCH v1 2/7] dt-bindings: usb: hpe,gxp-udc: Add binding for gxp
 gadget
Thread-Topic: [PATCH v1 2/7] dt-bindings: usb: hpe,gxp-udc: Add binding for
 gxp gadget
Thread-Index: AQHY755tsrsf1u+J3EmTaEhUe3W7664tY7+AgAaG7KCAAQEmgIABC2AA
Date:   Wed, 9 Nov 2022 03:37:01 +0000
Message-ID: <SJ0PR84MB20853F3B0FCCF2A9583524B48D3E9@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221103160625.15574-1-richard.yu@hpe.com>
 <20221103160625.15574-3-richard.yu@hpe.com>
 <b85230d4-8fce-ba49-0d6b-8c4d20132cda@linaro.org>
 <SJ0PR84MB2085E6B922DAF1070DC802EF8D3C9@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
 <c199600a-aad9-5639-ea57-a4d59d719ade@linaro.org>
In-Reply-To: <c199600a-aad9-5639-ea57-a4d59d719ade@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2085:EE_|MW5PR84MB1641:EE_
x-ms-office365-filtering-correlation-id: 2befeee7-dd1e-449a-756b-08dac203a9d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BloDjZSEhw61/JjpKkKXVOiZ06UTAx+RhwaVbCBmW/e2fWwRTwdsaZFgv4dL5uYW2Dz4AD85uDWb4x/9Xkk+D0FzitbDk5FGxCVEzomnc6ZL+CGRImMG4J+fK+H30XrcStLCvi4EzSt9A+ZISW7ZXpyJsECIWIL04sAh7RXDJe5AsbEQnxsAlC1BmT8PqfY/WUS6F6NLZ1cz1FarlJtu4UoGYSF9yyaoDA5jqQHh7fYEzLmoPwXaQCUsxCzfG9YOe5K/M3hkTFGeThwRIdcr1cS84jhrjKg0/YF55uoFOgxWSNHezd3xWUetUKC5+MF02lfVB9HUV6zpJWskMLEipRGuJLUmnC/WIlHUGb/ET5YEAqQmPTL1g+QB0Ey8FYBdJuEoi5aTVQ7n75EuVxKsdDXTtpL+Ug3/N84UG+4zV/7DiwLGtya+3ZKOaCwhmE+Eto4GUhWV1TUDiER5cWXz2SXbtWAEPoEwRGChBrJeKhgby71XC6Qk8yvNm98Y4PR6v+O1ocf4mP43SgVSsgzEaroGHdNfLVXmDfiPCasPnuQ/GkqIJOGsATHWA1J2JhSstLZEkn+pRlL0eCqtkvSHsPRm9WQiWi3rrxvmvWp13EK7XNFlVhWqArb+8+/4lb5x0dCv/Jep7e9rW2cmZX5CwGwSrhVMs7jNdc6/dWu6n1pS3woIh+B5YQ/gx4YDfux/tnBXGIj2ye0P/D1r19Ntq93NTBIXi17rNk8jBOU0/e9vqkUSkuI05WOsLcMvue9VCjv2Wfqb7lpfBVjGn7JMjltRPKNcIva+mpZrye3eKvY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199015)(8936002)(5660300002)(110136005)(71200400001)(921005)(66556008)(83380400001)(41300700001)(38070700005)(66946007)(2906002)(478600001)(8676002)(64756008)(6636002)(52536014)(76116006)(66446008)(33656002)(7416002)(66476007)(316002)(26005)(186003)(9686003)(82960400001)(55016003)(38100700002)(122000001)(86362001)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnZHZ0J5Z0I4S2FmbGkrRnJScXI2RlZjWklDSUdwUW53Z2hYWHA3QTFWODkv?=
 =?utf-8?B?YWVOdzhnRTkzeVFrTmErNXl5VmRmQXNFKzA1WW9nZ2hKZ2VUdDRGOFVxdm9X?=
 =?utf-8?B?SW5QV1F6MW0vNnMycHR4TmxRaEZBSHd3M05MOXBtd0FNNXVsSWowSmtzSEcw?=
 =?utf-8?B?WGExT0JISXk3eDZSUmhoUjdQS2RpeUxBaTdBVGdrRFJZTFNSZjZJN2xWUllq?=
 =?utf-8?B?N1c3bU5iOFYzaGJZUEUrUmlvTXVkdlF2TXVrRzJlV01MRmtVeXlzTnI3cUZZ?=
 =?utf-8?B?WHJ6bVF2R1pNTFlrZ3JCRTg0cmtUdFcrOUdWMVR0cFI4dCsrTGZRSHRkS1F2?=
 =?utf-8?B?NnZMSEc3bElWVktod1FUbS9VaE1tYVBpd2xtK0Z2UmVLYUxjNkM4ME44Mmtv?=
 =?utf-8?B?RjQxMjdhOHZDWTNONWtsdHo0c01rNCtyeG9pNGlSNHhVTHJkSVZhNUhRWnBE?=
 =?utf-8?B?OWlTK1lXa0NzaWtteExWUG5wQkdENVQzTkhJbDJHQktiU1RxMWl0WGkycHhn?=
 =?utf-8?B?bzZSd3h4ckt2N0R3TTV1WHU2aHBFVW1ZS2FnWk13QytHSTRINUdmd3VzWCtU?=
 =?utf-8?B?dFVZUDZnemVqMjF0Z3V2SnBHV3dmOFo4ekVUdXBKRE92TmRwclFXUThVWVZJ?=
 =?utf-8?B?Z2YrTFhRT0l5TDNoUEJYSmdIN3R3UVUyY3ZtbDVKbDlyY21xOHhDQ3pEeDEz?=
 =?utf-8?B?U0ZVUm80ditEYWFtcUpYTVAyYnk3UXN5NmpDdU9mQXJKeVFvazlCdHZGQkg5?=
 =?utf-8?B?djQ1OEFzZ1kvdnNUUWlKT2ltSEYyRmRNN3RoU3daNzJSdnhkZUhYVXdtdDFk?=
 =?utf-8?B?Nk1CT3lPYk5YRmxCeU83TFh2dGxQWEZiWEtqSXRiZHhlRXlaMk1xRCtzS2xK?=
 =?utf-8?B?SEJ5eVd2TWk1Ukx3ODl3Szg1M3R3WUNpdURBTnM5WWczYUNGMEtkMTVIU2lq?=
 =?utf-8?B?dTgzMzBTR1FXY1dIalFYY0plSmV6T3pLZ2FBYmhJbFJiaEVRei9xNlpGU0I5?=
 =?utf-8?B?OU13a0VDNWpBejNSdkZQdVZvWkNMbEk4QXVuY0tIVmtXK1B4Ukpjc25FZThK?=
 =?utf-8?B?aXZkREdrQTd5bXlRdnlCYmtVTWtMMXM2TGVYeXVPbFhBT3dJVDRnZ1gvZ3Jn?=
 =?utf-8?B?RXVlcnN1NXc1ZVEybENpdEFEY2hTSUo2TlZhZTZXZWhsa2JGUlRQUDJ4MDh5?=
 =?utf-8?B?T21nSGU0VWd3WXV4bVJ1MTViN3BaeE1qOEdGcERkMDdSQ3hNcjRQSXN5TTI5?=
 =?utf-8?B?T0pFSVd5Y1hWaGFNcCtjQnBlZC9ZUnlUVGo2MDhIQnYwdU1ORm81ZUNlbkF3?=
 =?utf-8?B?aXNPZnI4L2lNM2p4ZWJPTE0xblpTMG9jR0NkeWYrMFI5Z0xDTlY2OCtZOUhl?=
 =?utf-8?B?N1dZencrYzcrd0dxZ3RuUFhwaVVVdlNzVWZ4TnlPWlNCdG4yWFk3eWovSnd0?=
 =?utf-8?B?aU1FRGROMys3dVQ0TXB3UWpXdytVTDA4V1F3c0w2MlQ4a1FGRk5sSHhHOW5l?=
 =?utf-8?B?U1M2Unk2UzR5M1BLMUlkMjlHbVNQcklFRVNzVWRRTm40RGZjMlBVdmsreUZK?=
 =?utf-8?B?alRZSTkvdGN0NTMvWWgxMjI4QndTcVBrSWczVDYxUEVXV1FOVEw0SXRDRE9P?=
 =?utf-8?B?Q1czbmsvQWdjR1Q2UzF1NFNlYUUxb1I0VlNLT3E4dldmTnRVMmx2aXFrd1dy?=
 =?utf-8?B?dm5VaUtNaHJ1WGNhbTBqQTBRYzlnOG81SGtoWlJ4Z01SZGV4V0dEaU5ickpq?=
 =?utf-8?B?amNtaXRNS3VldTIxYkhvU1BVSENBbGVVMFhhQ1c2V2J5YVorc2ZBRmpDU3NJ?=
 =?utf-8?B?Rm1Yd3p5NHVwNWw0N0Z5SytvOGZ3SkFuM0gzY082czZSelVEWUQvK1hKYm84?=
 =?utf-8?B?NEFsQSswTWJUbHFhNHh1bTFUSGtuK0lFdE9XRnhPMnhScUNUOWNDZDgxUExD?=
 =?utf-8?B?RjAxQTZISmR4RGxuNzE3SjFjSWRXN0JHWW1jT2NnNStGYXFSV0Z5UnZTTmkr?=
 =?utf-8?B?NmlzREFWZnpNSkxGODJaaU1ILzFNdkM0TWt5WDNQams4VCt3aGRtK2VJOGpx?=
 =?utf-8?B?RGpoWTV6NlNmSU1HaEExZVMwOE5HVk10aFk1UDlzUE5odElIY3cwa0hlREtp?=
 =?utf-8?Q?QfEKUNkDEmmByewGKTLEl/7jf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2befeee7-dd1e-449a-756b-08dac203a9d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 03:37:01.6259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkDy3hBZ1tsGrnA4PZMxyIM2SKHG/MU1DIzCCel10VVJIifSQ2I2B1+1yuYH11D+BP9nyJz0Dm/poAq8xcQDcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1641
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: DF6wyTTLi9ozQPFcEUObczceGUDpY8Zl
X-Proofpoint-GUID: DF6wyTTLi9ozQPFcEUObczceGUDpY8Zl
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-08_06,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=401 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211090023
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTXIuIEtvemxvd3NraSwNCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgaW5wdXRzLg0KDQo+
Pj4+ICsNCj4+Pj4gKyAgdmRldm51bToNCj4+Pj4gKyAgICBkZXNjcmlwdGlvbjoNCj4+Pj4gKyAg
ICAgIHZpcnR1YWwgZGV2aWNlIG51bWJlci4NCj4gDQo+Pj4gVGhhdCdzIHVudXN1YWwgcHJvcGVy
dHkuLi4gV2h5IG51bWJlcmluZyBkZXZpY2VzIGlzIHBhcnQgb2YgRFQgKGhhcmR3YXJlIGRlc2Ny
aXB0aW9uKT8NCj4gDQo+PiAgSW4gSFBFIEdYUCB2aXJ0dWFsIEVIQ0kgY29udHJvbGxlciBjaGlw
c2V0LCBpdCBjYW4gc3VwcG9ydCB1cCB0byA4ICANCj4+IHZpcnR1YWwgZGV2aWNlcyhnYWRnZXRz
KS4gRWFjaCBkZXZpY2UvZ2FkZ2V0IHdpbGwgYmUgcmVwcmVzZW50ZWQgIGJ5IA0KPj4gYSBiaXQg
aW4gOCBiaXRzIHJlZ2lzdGVyLiBGb3IgZXhhbXBsZSwgdGhlIGludGVycnVwdCByZWdpc3RlciBi
aXQgMCAgDQo+PiBpbmRpY2F0ZXMgdGhlIGludGVycnVwdCBmcm9tIGRldmljZSAwLCBiaXQgMSBm
b3IgZGV2aWNlIDEgLi4uIHNvIG9uLg0KPj4gV2hlbiBhIHVzZXIgZGVmaW5lcyBhIGRldmljZS9n
YWRnZXQsIGhlL3NoZSBjYW4gZGVmaW5lIHRoZSBkZXZpY2UgDQo+PiBudW1iZXIgYXMgYmV0d2Vl
biAwIGFuZCA3LiBUaHVzLCB0aGUgZHJpdmVyIGNhbiBsb29rIHVwIHRvIHRoZSBiaXQgDQo+PiBw
b3NpdGlvbi4gVGhhdCBpcyB3aHkgd2UgaGF2ZSBudW1iZXJpbmcgZGV2aWNlcyBhcyBwYXJ0IG9m
IERULg0KDQo+IFdyYXAgeW91ciBsaW5lcyBwcm9wZXJseSwgaXQncyBpbXBvc3NpYmxlIHRvIHJl
cGx5IGluLWxpbmUgdG8gc3VjaCBtZXNzYWdlcy4NCg0KU29ycnkgZm9yIHRoZSBpbXByb3BlciB3
cmFwcGluZy4gSG9wZSB0aGUgYWJvdmUgZml4ZWQgdGhlIHByb2JsZW0uDQoNCj4gVGhlbiBob3cg
ZG8geW91IHNwZWNpZnkgdHdvIGRldmljZXM/IFlvdSBhbGxvdyBoZXJlIG9ubHkgb25lLCByaWdo
dD8NCg0KSW4gb3VyIGN1cnJlbnQgZGVzaWduLCB0byBzcGVjaWZ5IHR3byBkZXZpY2VzLCB3ZSBh
ZGRlZCB0aGUgZ2FkZ2V0IA0Kc3RydWN0dXJlIGludG8gdGhlIGRldmljZSB0cmVlLCBzdWNoIGFz
ICBnYWRnZXQwOnVkY0A4MDQwMTAwMHt9OyBnYWRnZXQxOnVkY0A4MDQwMjAwMHt9Oy4uLi4NCg0K
Tm8sIHdlIGNhbiBhbGxvdyB1cCB0byA4IGRldmljZXMgYnkgYWRkaW5nIHRoZSBnYWRnZXQgc3Ry
dWN0dXJlLA0Kc3VjaCBhcyBnYWRnZXQwOnVkY0A4MDQwMTAwMHt9OyBnYWRnZXQxOnVkY0A4MDQw
MjAwMHt9Oy4uLi5nYWRnZXQ4OnVkY0A4MDQwODAwMHt9Ow0KDQo+IFdoaWNoIGJpdCBpbiB3aGlj
aCByZWdpc3Rlcj8gWW91ciBkZXZpY2VzIGhhdmUgc2VwYXJhdGUgYWRkcmVzcyBzcGFjZSwgc28g
d2h5IHRoZXkgY2Fubm90IHBva2UgdGhlIHNhbWUgcmVnaXN0ZXIsIHJpZ2h0PyBUaGVuIGp1c3Qg
YWx3YXlzIHNldCBpdCB0byAwLi4uDQoNCkluIEhQRSBHWFAgdkVIQ0kgY29udHJvbGxlciwgdGhl
cmUgYXJlIHRocmVlIHJlZ2lzdGVyIGdyb3Vwczogc3RhbmRhcmQgVVNCIEVIQ0kgcmVnaXN0ZXJz
LCANCnZpcnR1YWwgZGV2aWNlIGdsb2JhbCByZWdpc3RlcnMsIGFuZCB2aXJ0dWFsIGRldmljZSBy
ZWdpc3RlcnMuDQoNClN0YW5kYXJkIFVTQiBFSENJIHJlZ2lzdGVycyAtLS0tIFdlIGRlZmluZWQg
YXMgImhwZSxneHAtdnVkYyIgaW4gdGhlIGRldmljZSB0cmVlICh2dWhjMCkgDQpWaXJ0dWFsIGRl
dmljZSBnbG9iYWwgcmVnaXN0ZXJzIC0tLSBXZSBkZWZpbmVkIGFzICJocGUsZ3hwLXVkY2ciIA0K
VmlydHVhbCBkZXZpY2UgcmVnaXN0ZXJzIC0tIFdlIGRlZmluZWQgYXMgImhwZSxneHAtdWRjIg0K
DQpFYWNoIHZpcnR1YWwgZGV2aWNlIHdpbGwgaGF2ZSBpdHMgb3duIHNlcGFyYXRlIGFkZHJlc3Mg
c3BhY2UuIA0KVGhlcmUgaXMgb25seSBzaW5nbGUgYWRkcmVzcyBzcGFjZSBmb3IgdGhlIHZpcnR1
YWwgZGV2aWNlIGdsb2JhbCByZWdpc3RlcnMuIA0KDQpUaGUgdmlydHVhbCBkZXZpY2UgZ2xvYmFs
IHJlZ2lzdGVycyBhcmUgaW5jbHVkaW5nIHZEZXZpY2UgR2xvYmFsIEludGVycnVwdCBTdGF0dXMg
cmVnaXN0ZXIoRVZHSVNUQVQpLCANCnZEZXZpY2UgR2xvYmFsIEludGVycnVwdCBFbmFibGUgcmVn
aXN0ZXIoRVZHSUVOKSwgdkVIQ0kgRmxleEVuZHBvaW50IE1hcHBpbmcgcmVnaXN0ZXIgKEVWRkVN
QVApIC4uLi4NCldlIG5lZWQgdGhlIHZkZXZudW0gZm9yIHRoZSBiaXQgcG9zaXRpb24gaW4gRVZH
SVNUQVQgYW5kIEVWR0lFTiBmb3IgZWFjaCBkZXZpY2UuICANCldlIHdyaXRlIHZkZXZudW0gaW50
byB0aGUgRVZGRU1BUCByZWdpc3RlciB0byBhc3NpZ24gYW4gRVAgdG8gYSBzcGVjaWZpYyBkZXZp
Y2UuIA0KDQo+IEkgbWlnaHQgbWlzcyBoZXJlIHNvbWV0aGluZyBidXQgc28gZmFyIGl0IGxvb2tz
IHRvIG1lIGxpa2Ugc29tZSBoYWNreSBkZXNjcmlwdGlvbiBtYXRjaGluZyB0aGUgZHJpdmVyLCBu
b3QgaGFyZHdhcmUsIG5vdCBleGlzdGluZyBiaW5kaW5ncy4NCg0KV2UgY3JlYXRlICJ2ZGV2bnVt
IiBhcyBkZXZpY2UgY29uZmlndXJhdGlvbiBwYXJhbWV0ZXIgZHVlIHRvIG91ciBoYXJkd2FyZSBu
ZWVkLg0KDQo+Pj4+ICsNCj4+Pj4gKyAgZmVwbnVtOg0KPj4+PiArICAgIGRlc2NyaXB0aW9uOg0K
Pj4+ID4rICAgICAgbnVtYmVyIG9mIHRoZSBmbGV4aWJsZSBlbmQtcG9pbnRzIHRoaXMgZGV2aWNl
IGlzIG5lZWRlZC4NCj4gPg0KPj4gPlNpbWlsYXIgcXVlc3Rpb24uDQo+ID4NCj4gPkluIEhQRSBH
WFAgdmlydHVhbCBFSENJIENvbnRyb2xsZXIgY2hpcHNldCwgdGhlcmUgaXMgYSBmbGV4aWJsZSBF
bmQtUG9pbnQoRVApIHBvb2wuIA0KPj5FYWNoIGZsZXhpYmxlIEVQIGhhcyBpdHMgb3duIG1hcHBp
bmcgcmVnaXN0ZXIuIFRoZSBtYXBwaW5nIHJlZ2lzdGVyIA0KPj5iaXQgMCB0byAzIGlzIGZvciBk
ZXZpY2UgbnVtYmVyICh2ZGV2bnVtKSBhbmQgYml0IDQgdG8gNyBpcyBmb3IgRVAgbnVtYmVyIGlu
c2lkZSB0aGUgZGV2aWNlLg0KPj5UaGUgZGV2aWNlIGRyaXZlciBjb25maWd1cmVzIHRoZSBtYXBw
aW5nIHJlZ2lzdGVyIHRvIGFzc2lnbiBhIGZsZXhpYmxlIA0KPj5FUCB0byBhIHNwZWNpZmljIGRl
dmljZS4gIEhlcmUsICJmZXBudW0iIGlzIHRoZSBpbnB1dCBsZXR0aW5nIHRoZSANCj4+ZHJpdmVy
IGtub3cgaG93IG1hbnkgRVBzIGFyZSBuZWVkZWQgZm9yIHRoaXMgZGV2aWNlL2dhZGdldC4NCg0K
Pk5vcGUuIFNvIHlvdSBjcmVhdGUgaGVyZSBzb21lIHdlaXJkIElEcyB0byBwb2tlIGludG8gc3lz
Y29uIHJlZ2lzdGVyLg0KPkZpcnN0LCBzeXNjb24gaGFzIG9mZnNldCBpZiB5b3UgbmVlZC4gWW91
IGNvdWxkIHRyZWF0IGl0IG1heWJlIGFzIGJpdHM/DQo+SSBkb24ndCBrbm93Li4uIGJ1dCBldmVu
IHRoZW4geW91ciBkZXNpZ24gaXMgcG9vciAtIHR3byBkZXZpY2VzIA0KPmNoYW5naW5nIHRoZSBz
YW1lIHJlZ2lzdGVyLiBFdmVuIHRob3VnaCBpdCBpcyBzdW5jaHJvbml6ZWQgYnkgcmVnbWFwLCBp
dCBpcyBjb25mbGljdGluZywgb2JmdXNjYXRlZCBhY2Nlc3MuDQoNClRoZSAiZmVwbnVtIiBpcyB0
aGUgaW5wdXQgcGFyYW1ldGVyIHRvIGRlZmluZSBob3cgbWFueSBlbmQtcG9pbnRzIChFUHMpIGlz
IG5lZWRlZA0KZm9yIHRoZSBkZXZpY2UuDQoNCllvdSBhcmUgY29ycmVjdCB0aGF0IGFsbCBkZXZp
Y2VzIG5lZWQgdG8gYWNjZXNzIHRoZSB2aXJ0dWFsIA0KZGV2aWNlIGdsb2JhbCByZWdpc3RlcnMg
ZHVyaW5nIHRoZSBydW50aW1lLiANClRodXMsIHdlIGNyZWF0ZSAiIGhwZSxzeXNjb24tcGhhbmRs
ZSA9IDwmdWRjX3N5c3RlbV9jb250cm9sbGVyPjsnDQpmb3IgdGhlIGRyaXZlciBnZXR0aW5nIHRo
ZSB2RGV2aWNlIEdsb2JhbCByZWdpc3RlcnMgYWRkcmVzcy4NCg0KSW4gb3VyIGN1cnJlbnQgY2hp
cCByZWdpc3RlcnMgbGF5b3V0IHdpdGggdGhlIHZEZXZpY2UgR2xvYmFsIHJlZ2lzdGVycywgSSBk
b27igJl0IHNlZQ0KYSB3YXkgdG8gYXZvaWQgInR3byBkZXZpY2VzIGNoYW5naW5nIHRoZSBzYW1l
IHJlZ2lzdGVyIi4NCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciB0aW1lLg0KDQpSaWNo
YXJkLg0K
