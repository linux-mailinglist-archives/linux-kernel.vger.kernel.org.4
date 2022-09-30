Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844E45F1645
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiI3WnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiI3WnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:43:08 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1214C2CE2C;
        Fri, 30 Sep 2022 15:43:07 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UKjoUP016139;
        Fri, 30 Sep 2022 22:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=n/M38caFgshzjGDwuj3vhLGto20KPnE0AhzZax2M+kk=;
 b=aJS0Op+RYSLPcRuUxE85tchOOmw0l/dAyY4maqVy6WIJBaOEZJEybCigJlfc9CnSgc2s
 xAWTiJeBCzXQVwODpsjlpAHI1sm9kqUyG5fozcr9WUrD2Zo1Yhd3Ja5hCTvAvCBw003E
 0TQ8SVJfxAKyLBJXXT+WIe6+AxDb5QqhNQR04ZFUsvvPk6WMqyd7NO+cRYXaY4l2aq0n
 MnmDK10j3FN3mpB8tuukvFq7q3pHnPve+JOZVXr2B0/rjIpqiMyS2cVWFJ+etEOWBRou
 h53p+2qG/hI93rsjS8YJsdP5nw/vI2OdA1yOxyQZG87R5jSQibbBuGuqTMWXQ82pTPDz GA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3jx6dr13jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 22:43:00 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 22607D2AE;
        Fri, 30 Sep 2022 22:42:59 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 30 Sep 2022 10:42:58 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 30 Sep 2022 10:42:58 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 30 Sep 2022 22:42:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHZKEK2Ho0FQ03/unKRg/6jaw+QPI99D+q3apY+T+r+N5cyym++6yRZVg5MoGPAMVN6Mo3D2Fgms8WWjZy8GEb8B1kMHXPcXeugNvb4DLyHGE1PW6Ah9RXGc4OoXqStEsi98nkHZ9hMSyPatoDb9DGX/tdk8fV2jjWeg/jXs3EVOICcOTFp8GnQJw/b+I4PXaABqOpbzsoTFswLG0QSlryImSiXsn6Br8DLRNerVpkRDezrhBrlYo3PinRsAstvhVwJ6mrUDaoG2rtDtqQ8LmBhMVV7xEUAEBTsA7Vze/ICCkGr4G0K3FDrL60k3UZTAyquooQWjjA46X++EEFSw7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/M38caFgshzjGDwuj3vhLGto20KPnE0AhzZax2M+kk=;
 b=OA4cuYtHJyroUNtPi0CCV8LN8bRXBFYQPjK+hC2oLg7djNxi/n/qOqX+uTFzYBeM5Ay8jT7NIKglgPmnHeZ1oSLnaOd7sJkDIV3A+MJ2K27WxSNkTwHjfEwC7FldT/OtOPCqvffirq3GWCalnVhlV1vHF9hiJ8kc4lKPFvf3PENBLUEcLOLCYwAovFePWpWcqmUHYTTv/dBgneft5YabeSV+cCQ42dPdmoe+y6btsRcDE8ukKy0vE9srnxr49slfR02+KVDs+P2wHkGuQiQi+TSZcOtEZ2Dagq6MQTr7PIXC9fpJiKBJWuM8SRDuV5khr/QQK75CBztWE68YmV/w2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW5PR84MB1666.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 22:42:51 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c593:2fa7:f3bb:2ba]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c593:2fa7:f3bb:2ba%5]) with mapi id 15.20.5676.019; Fri, 30 Sep 2022
 22:42:44 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jarod@redhat.com" <jarod@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] crypto: tcrypt - fix return value for multiple subtests
Thread-Topic: [PATCH] crypto: tcrypt - fix return value for multiple subtests
Thread-Index: AQHY1RVrYCgruMeZZ0yKrbn1aJbnIK34iHkAgAAAUVA=
Date:   Fri, 30 Sep 2022 22:42:44 +0000
Message-ID: <MW5PR84MB18425977F8BD6260B5347586AB569@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220930214014.37194-1-elliott@hpe.com>
 <ab0d9840-07e3-ec49-a9b3-c4b65d7d61bc@intel.com>
In-Reply-To: <ab0d9840-07e3-ec49-a9b3-c4b65d7d61bc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|MW5PR84MB1666:EE_
x-ms-office365-filtering-correlation-id: 94de0b9c-ac11-412e-a428-08daa335177e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w1vtuaScj/ouhDGf02DSGxEKNNuS/bq4EqMwWLw/yINwpwHDG/F6TCQKZyG37pAAGEgYoqi2h7ZvBX8YR1FXqkW4+3mt3s4Zt6h4EsoWBTHQf+H78BlRh2kl+Mzzo1WzVdJXZsv3TdROtIMrM81xjl2Ip68JYOiLWETUN3o8kRTL1nAKV5QOEzBr6q/mpOmikWW1srvZAmqxAIrhNoBcEprFqlvR3LVVYrTOw/uxyq78U+Z0IE6PmhmG9mp3U4E/qK6vTJFas4c/66VVXopAQeg2nymbd6RmR87U1DiRm6KncQY/iHDDmjMOXAqdNXq3au7QgUQLcVmBcK4E/8I3o85rnzjJoxdZnIgB3g+dfwCYgPGGftUnd/TL1By+4OFsWCokx8Ia/SiKLNrvxSFA15SdcY+dn74JsZMBsgxZUciEPcsTMK9aYcShghLGegtYZqBrzkVakZarI61UAWqnceiNhmPzIl1GHqrxLM5mj8vPcRaVoY+69jUg5qbupaFh1604z97/fl2lYQpFbteapBZdg+AoVPBr2gBdZ6NgH/uVAwBRc/NWD2OXfAEEl10MdGN0HPEcgQiwxR8iVwxPl1/MUkK0pj7hZQ6EzTarbzk99I/MAauV+yLFo7qzIIjk/6XIJDNTry+pTlq7YdzvblcW5fCLweHAnf1C1LvoOM2uiedhgLtwKNHNMm3IYY536B67OXeJZnC7J5flkIU4BlGbmGIDugRbEb4g6Ja73dcxhXN62cffk/V8Th4cHinn0ZK1VvlG3TizKgsFUVl4iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(2906002)(316002)(66446008)(66946007)(64756008)(8676002)(66556008)(8936002)(76116006)(66476007)(33656002)(478600001)(71200400001)(110136005)(41300700001)(52536014)(5660300002)(9686003)(53546011)(6506007)(83380400001)(7696005)(86362001)(26005)(82960400001)(38070700005)(55016003)(186003)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUpHS2FWR2ZwbXJjSFFVc0l6cEFSRjNHUDNGbEVVZEl0MHp0Z0dSeE1RMEhy?=
 =?utf-8?B?Uno1UmRJWWpTdjkvRmI2RWl0ME9hVkFFeW1XMDFBc2E4ZkpKNlN3Nk1VTEE1?=
 =?utf-8?B?K0YzMzhBOE0rRjhveXlqTDF3WkZ0SldzRUZkQVNTNnU1SWFlNm9sQjNobGdm?=
 =?utf-8?B?NGszUldGdDdidGdLQW5vWklhakgvZ0M3Y1UyTDZFbmZRT1Y5ZHpwSFI2VGl6?=
 =?utf-8?B?YnhlbHJtNDdVUWtIR25qaHRGMjRIYW94bkFWZzhGeWdEdmZtRTZrSktZNlQx?=
 =?utf-8?B?ZE5ueGxNeWRaZHIwQmJSNS9KenJPbUduVzhmTEJCMVFFTWRmSU9UN1dGaFlW?=
 =?utf-8?B?bFJodUN0aWdUbmFKWk9vWStGc3l4alVjTFB1bm9ZaE5LbmxLUTh5UUg3VHR6?=
 =?utf-8?B?ellJRWJSRW1YS094TWlqRUVIczVYeVJQMDFlV2Ixait1UDNTSnRCVjh3WW5V?=
 =?utf-8?B?b1JLVHNpSVRHRkhQWTUvTi84aGNBL3RPWGhBQ0hsaDk0Q0ZYc3dsSmtJQlVn?=
 =?utf-8?B?YlVIbiswVnpES0FkbkY2NFBnS1JlTkdvVmdkTnhHRXRwck0ydHFoaVNnWkxn?=
 =?utf-8?B?azNxTStYL1VLSWQvaDZpM3hIUE5yZnZ0YkI3cnJiTjFuUGJKc1Z4WERBZ0Jv?=
 =?utf-8?B?MXZQcUwzSW1lVC9pOTR6Wnl2Sm5jZndtUjB1YTJXQ05UYUl3RVdLT1Jva2JG?=
 =?utf-8?B?NGxzZnh2a1JIV2E2YmRxN3FnYVFYWEdFY1ZDVllvV0JDOVBvaGVxSVUxdFdn?=
 =?utf-8?B?aG1TZ2d1REZmUGl4VndmUWV4d2NqclVST3NFa1V4ZFRiSmNEbjVFS0FmT1dY?=
 =?utf-8?B?Q2RoSXN5Wmo5MDVrV3VWSVZtdCtBWndzK29wWEhaUkUzUEVqWFMwRzBybnFR?=
 =?utf-8?B?TnJ1T3hFa21YbloxQ0R6WENSYkllc1JkYVgrREFDNE5yN3VCNEV3Q2NGVi9T?=
 =?utf-8?B?N3RQRnpTaCtlb3c0ZUVhTGRZUHovQmJHcXhIcWdUN09Qajl2QVpPOFhJcExa?=
 =?utf-8?B?eWVKMksvbmpvNkFTZEZaME10cE5ubkhZK0g0bll0TytOc3dyYnNXTjk0dU1Q?=
 =?utf-8?B?clR3OXVENFdacytIbGdmdEp1UGMrYW1FRmd3VGtxd1pLdHU1ekczWFRNdUI5?=
 =?utf-8?B?RUZlZjRmQ2QzSW9MSmVaRzhsSmdOVGZKODA1eGlROXh0OTNiL2RvaVhlZVg2?=
 =?utf-8?B?T0JmcXZHenNwaUtqakNpTHJHNklXa0NGTGo4RDRJQzlJLzBKbGFIcVRBbTJZ?=
 =?utf-8?B?dkRPZE1wZFN6WDFieVBUcERNb3JidWZrdE01Vy80N0t6ZHdtdjdXQTM3blht?=
 =?utf-8?B?Z09jVDdGRUh2WkpBbUp4SWVuMFRJYStJQ2E1cG55bG9MeTc2bnBIK21vandI?=
 =?utf-8?B?eGo4OXQ0V1ZPRVhDaXVhZTdjUm9lcnAzdGUzakhxOGRpM3lRMnY3L28vRnVu?=
 =?utf-8?B?eERkNDU1ZGFrM2V5WWFibHV3TTkvckpOMlB4TExTSVN1RFpjeHlTcnJCRlp3?=
 =?utf-8?B?WVlpUTF1eXkrWDN3bllFNG53QzhseVIrbXRTWUFUZDJJNEVuZDQ0MzFiOVVM?=
 =?utf-8?B?YW9LSDFuQ1Z3UzQraHM5OHgvZ0J1dVFBWnVtT3p2ZDAvb29TSXVZVU84cVJx?=
 =?utf-8?B?K1FsU24vYmN1SW0vRkJRRkY0WEswTndYbHRLamZQL0NsUk1lMzdTVThuQWhj?=
 =?utf-8?B?ZkNQRHc3RFYwTXRHempxK003UXFPc0Z3NXR3ZWJFNlQrSUNuZEg3c0ZCaEdM?=
 =?utf-8?B?aFRFcUdNeXFnbWRwMkdMM0VVWGlZRU5JWEZ0RzlGVFNWcDlpZUFGOVdkZno1?=
 =?utf-8?B?blFkZGROUjBWd01WOHo2K3UxdFBZRjZpWm5ONlFKU2gxOGNJTW82bGcwSU9m?=
 =?utf-8?B?V0luUkNCNGVpbnJPTXdZZGNhdHFxRU9xRHpsRVBDWk01UUNBWlB6MFlqdysx?=
 =?utf-8?B?VUl1NmgrUVAvU2JhUDVrYWh3WmhXV2FLbW9teHdVcXUvenFXcDhvNFF0K2Rx?=
 =?utf-8?B?NmlVVUVheGd1ODRoMkQ1YkFiN1RQYWZjRW9EMFUvdE5kQ2FTZ1duTTgyWCtK?=
 =?utf-8?B?ZVVmTEVhQ1owL3d2b1Iyd2FBbGNEcEllYTQzQm1EUkJDT0pOVks4aXlUOTBD?=
 =?utf-8?Q?2Uig=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 94de0b9c-ac11-412e-a428-08daa335177e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 22:42:44.8647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: grK/imnoZQBw9RIRYmF7/imIqS2pCiL9WTo/cypITPNJjWzmCaVkPlOYGmW3rDvo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1666
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: YwzabqoPyVY8M6l5K19UqCD0-JIRxEPh
X-Proofpoint-GUID: YwzabqoPyVY8M6l5K19UqCD0-JIRxEPh
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300141
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5pcnVkaCBWZW5rYXRh
cmFtYW5hbiA8YW5pcnVkaC52ZW5rYXRhcmFtYW5hbkBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRh
eSwgU2VwdGVtYmVyIDMwLCAyMDIyIDU6MTAgUE0NCj4gVG86IEVsbGlvdHQsIFJvYmVydCAoU2Vy
dmVycykgPGVsbGlvdHRAaHBlLmNvbT47IGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdTsNCj4g
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgamFyb2RAcmVkaGF0LmNvbTsgbGludXgtY3J5cHRvQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gY3J5cHRvOiB0Y3J5cHQgLSBmaXggcmV0dXJuIHZhbHVlIGZvciBtdWx0aXBs
ZSBzdWJ0ZXN0cw0KPiANCj4gT24gOS8zMC8yMDIyIDI6NDAgUE0sIFJvYmVydCBFbGxpb3R0IHdy
b3RlOg0KPiA+IFdoZW4gYSB0ZXN0IG1vZGUgaW52b2tlcyBtdWx0aXBsZSB0ZXN0cyAoZS5nLiwg
bW9kZSAwIGludm9rZXMgbW9kZXMNCj4gPiAxIHRocm91Z2ggMTk5LCBhbmQgbW9kZSAzIHRlc3Rz
IHRocmVlIGJsb2NrIGNpcGhlciBtb2RlcyB3aXRoIGRlcyksDQo+ID4gZG9uJ3Qga2VlcCBhY2N1
bXVsYXRpbmcgdGhlIHJldHVybiB2YWx1ZXMgd2l0aCByZXQgKz0gdGNyeXB0X3Rlc3QoKSwNCj4g
PiB3aGljaCByZXN1bHRzIGluIGEgYm9ndXMgdmFsdWUgaWYgbW9yZSB0aGFuIG9uZSByZXBvcnQg
YSBub256ZXJvDQo+ID4gdmFsdWUgKGUuZy4sIHR3byByZXBvcnRpbmcgLTIgKC1FTk9FTlQpIGVu
ZCB1cCByZXBvcnRpbmcgLTQgKC1FSU5UUikpLg0KPiA+IEluc3RlYWQsIGtlZXAgdHJhY2sgb2Yg
dGhlIG1pbmltdW0gcmV0dXJuIHZhbHVlIHJlcG9ydGVkIGJ5IGFueQ0KPiA+IHN1YnRlc3QuDQo+
IA0KPiBJIGFtIGFzc3VtaW5nIHRoaXMgaXMgZm9yIHRoZSBjYXNlIHdoZW4gZmlwc19lbmFibGVk
IGlzIHRydWU/DQoNCkkgaGF2ZSBzb21lIG90aGVyIHVucG9zdGVkIHBhdGNoZXMgdGhhdCBwcmlu
dCBtb3JlIGluZm8gb24gdGhlDQp0ZXN0IHByb2dyZXNzIGluY2x1ZGluZyB0aGUgcmV0dXJuIHZh
bHVlcyBhdCB2YXJpb3VzIGxldmVscy4NClRoZSBGZWRvcmEgMzYgLmNvbmZpZyBvbiB4ODYgeWll
bGRzIDIzIC0yIChFTk9FTlQpIGVycm9ycywgc28NCnRoZSBvdmVyYWxsIHJlc3VsdCBpcyAtNDYg
KHdoaWNoIGlzIGRlZmluZWQgYXMgRVBGTk9TVVBQT1JUKS4NCg0KPiBJIGFncmVlIHRoYXQgcmV0
dXJuaW5nIHRoZSBjdW11bGF0aXZlIHN1bSBvciBlcnJvcnMgaXNuJ3QgcGFydGljdWxhcmx5DQo+
IHVzZWZ1bCwgYnV0IGhvdyBpcyByZXR1cm5pbmcgdGhlIG1pbmltdW0gZXJyb3IgdmFsdWUgdXNl
ZnVsPyBXb3VsZG4ndCBpdA0KPiBiZSBtb3JlIHVzZWZ1bCB0byByZXR1cm4gdGhlIGZpcnN0IGVy
cm9yIHJldHVybj8NCg0KVGhlIGZpcnN0IGVycm9yIHdvdWxkIGJlIG1vcmUgdXNlZnVsLCBidXQg
d291bGQgcmVxdWlyZSBtb3JlIGNvbXBsZXgNCmNoYW5nZXMuIElzIHRoZXJlIGFueSBrZXJuZWwg
bWFjcm8gdGhhdCB3b3VsZCBoYW5kbGUgdGhpcyBpbiBvbmUgbGluZT8NCg0KICB0bXAgPSB0Y3J5
cHRfdGVzdCgpOw0KICBpZiAodG1wICYmICFyZXQpDQogICAgcmV0ID0gdG1wOw0KDQpTaW5jZSBk
b190ZXN0KCkgYW5kIHRjcnlwdF90ZXN0KCkgYXJlIHN0YXRpYyBpbmxpbmUgZnVuY3Rpb25zDQpv
bmx5IHVzZWQgd2l0aGluIHRoaXMgZmlsZSwgYSBuZXcgYXJndW1lbnQgY29udGFpbmluZyBhIHBv
aW50ZXINCnRvIHRoZSByZXR1cm4gdmFsdWUgY291bGQgYmUgYWRkZWQgdGhhdCBsZXRzIHRoZW0g
aGFuZGxlDQp1cGRhdGluZyBpdCB3aGlsZSBrZWVwaW5nIHRoZSBjYWxsZXJzIHNpbXBsZS4NCg0K
ICAgcmV0ICs9IHRjcnlwdF90ZXN0KCJtZDUiKTsNCmNvdWxkIGJlY29tZQ0KICAgdGNyeXB0X3Rl
c3QoIm1kNSIsICZyZXQpOw0KDQoNCg==
