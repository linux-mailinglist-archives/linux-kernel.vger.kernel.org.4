Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B46A60C062
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJYBEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiJYBD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:03:58 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257D096A08;
        Mon, 24 Oct 2022 17:04:13 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29P02HbB018420;
        Tue, 25 Oct 2022 00:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=ihKAJ3kl53xpbHrbQgggZBze5PlfYXA3QQ0gdDPoNOI=;
 b=K8lZKlFg5SCN8T9/7MxNWvcJwyQmnu6U9JC8faDfXtTZiTeB5cjTHazioU1aHQnTPTcS
 QVUW01uPU/Id4Vz+RUvslejjk4xL8G2E4bgJb4Wv+HnbTzg30GHs1yNfOBJXQlGFmJdF
 yHiHtpyzFzbh439mIHrP98SGf+AatP84/+hh9K2MNCgiqlq2TwGSg24NwvdE8lGJ9Opn
 mn7YZRNZ2s68c/Migc3d8HrPGHsh8SepkLrQqSHsLfEvowE/XAzhKglIpwBqcyOMDhYf
 Wxat6ymh4M+o1vpSdSNBdMxQS2lwNOA8pa29f+BzaK6k7xhG9VAaUj2awQoaBWvW8usW pA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ke30u8spd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 00:03:55 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 559CF8040D3;
        Tue, 25 Oct 2022 00:03:54 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 24 Oct 2022 12:03:43 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 24 Oct 2022 12:03:43 -1200
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 24 Oct 2022 12:03:42 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOS5D91gUsdvwAnIveU4NYQr/mmXDscNVK6P8zY2i3B2Er7RwkFMMA0lekgu9hyxKhmcbln+UUX1kY8WMVMHE/46LKtyL1tQVW1F+FmJeimgPCDfo3G52qR4rd3WYcbKA1O9gGHzg2Gy6nxf19z9tw7fknzKz25aQ7zM0ZIKtJ3kIG7NG6lFOCcLdpyY7lpplt5sKmXHViZstvnuRRG1mToEnkPCn3n7tSYdX66m1p/4kUjh0DF50KB68sahD7i2528FGsNJGnDgb+v6zBBUpgbchE8Fu2ANPpG3iX/Le2Y8YNadYqT5/1zNOp5FASq2elmC2IoqLTTQ0Wy6tmf5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihKAJ3kl53xpbHrbQgggZBze5PlfYXA3QQ0gdDPoNOI=;
 b=Ywq2X0S9CLEBVlZQucWf2kwkYel03UyP2sxOs1/ZGlHrtWdB+uLfJgmPJcO6QGjYqIbeL1hUdNsVv21JZFrU7OxKR41Ytb3tvpxUaZsq3wKRoegBUdZXVIAlVtUCqmlCpcTz9CNUjZkNFudCm7+XxgXJ3ZsM+WuR8oPZ9gkaaVl4dx9LCjQEM5+VMlXLnb5aiqE06DMRanFbYsqswR3lq7URizh7yXaLnuSVqZMd91/y+a+zVwsTY+WPXNnPVfqTh5RtSVdm/EFSfMGGE/QD74GTeOmK3EkeBy49rl3LqLqTlZmm/t97SrOzgGSLqK2MIYLihUp+1xjSt+jw/qZoug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 DM4PR84MB1709.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:48::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.26; Tue, 25 Oct 2022 00:03:36 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f4f4:4c43:9c7c:333c]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f4f4:4c43:9c7c:333c%8]) with mapi id 15.20.5723.033; Tue, 25 Oct 2022
 00:03:36 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: RE: [PATCH v1 2/5] dt-bindings: soc: hpe: Add hpe,gxp-plreg
Thread-Topic: [PATCH v1 2/5] dt-bindings: soc: hpe: Add hpe,gxp-plreg
Thread-Index: AQHY3aMniIVqm01b3kyrrbcxm5Jgf64JpGIAgAGGr3CAD3YZAIADo6MQ
Date:   Tue, 25 Oct 2022 00:03:36 +0000
Message-ID: <DM4PR84MB19275A47D7006BD5664E1AF488319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
 <20221011185525.94210-3-nick.hawkins@hpe.com>
 <CAL_Jsq+xb2Ltfne4mQMXQAde-eHS7TsO73YZ-vhE7nK1Z_M0gw@mail.gmail.com>
 <DM4PR84MB192795B45639710259E9B19D88229@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <820095a2-3722-5c3a-77fb-5a6b6b44e1c3@linaro.org>
In-Reply-To: <820095a2-3722-5c3a-77fb-5a6b6b44e1c3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|DM4PR84MB1709:EE_
x-ms-office365-filtering-correlation-id: fdab7052-042d-43fc-def6-08dab61c5d14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6/1NbnbJMyTafwqG4kgJUJ4oHtbk0RLL/0o8ifcgk1G4wDK8F/WSHVZZFsdpUgpROaaznR/GO03t6YyTguMPBQtzipdTsy1jw1R9lgjS+gTaQIE71TQnoGV5yATmHrd1o2SI5pJ/wfWx3ebp0hc7j018SjJSHZfNP2voY7VwuOxPRPJy9i0loIClcpkMtkFM2eVSuVlk1822O1q1X5EoiHCP59VrrtF5TmQ78lUYSKQ1VX6EKBnvUoLiTBiunCVI7KYOnb8Is9xBJlicSjd+JHodCGl27Vr2aUzhCwlF+kDajZs80U/YGdjBk6Qzq/PqvPWsVDJnIHpgfTWaTal5FdUkRYRZ+Y4p4VNtUifSgvyJU7GVTkBY/RxDs8C91T8jYLuXKqb1TaTxMbCjigVKxyJiRdvjuEzsUp4anv16maoR8G1ugQmUkFo7HloVNuoOYIzN0OtbSkHgz0OLZqDZQmKhdiBN1tQ6g1M6o73DGbRkFap+ZTuM1hfxBCYz5wKABMgOFzyE9RrVlcKfW4S5jp7KGL5MyYp6gjOx73gNx0qybuiVkaRRF9eQMRtXuuqwhk3D21fD6TQBZ7wpMOakafetxHf8C+hLY+g32cYvzdaAPuv9op0ITR3YwnpsEwIr+xNlGGZRUSWZ4vtOrbFaCM29uY1KOqC2vcaeO7Cx3XbkLtlEN9HIOnrtL1zNXRFVd1A7Qlvrp9nabBxi+98E8dNZiZc6g7lB5hMmVZVOY7LcuDoLinykWO12Z6g0iHr6ZLgX26O11fipfz0CZVORJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(122000001)(2906002)(4744005)(8936002)(38100700002)(5660300002)(186003)(38070700005)(86362001)(82960400001)(33656002)(316002)(26005)(55236004)(9686003)(478600001)(54906003)(76116006)(55016003)(4326008)(6916009)(66446008)(71200400001)(66476007)(64756008)(66946007)(8676002)(41300700001)(66556008)(52536014)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TCtXclJNYUhweHo4UmphaytSaW5LSG5GODVBazh5dS8weXo0OGplbUI3eVZP?=
 =?utf-8?B?bG1heFQ3bTF2ZEFVNmF4bDVQckYyRE01TDMwZSsyNkJ6WlBUc3hCWUlmcjZI?=
 =?utf-8?B?OTRJZ1lyVHFsVHA1Y1J6T25EODBaOTJhMUJsNzkyV0N4YVh1L214QjlSaGNo?=
 =?utf-8?B?VFJXNVJwdnp3eG5TQnBNcWFVeDFUQkJqRzY4VDF3cnp3Qk9BNXRRZXpLdXpY?=
 =?utf-8?B?ZnVTY1NIRDdpdGx4ZjVRSlRZNkVEdFpabzV6ZnB4aXNQcy9DaEVlZDQ1dHoz?=
 =?utf-8?B?UUpPQ29SY1FQMlduOVVGUy9ZUVIwTkZLLytWampCQmVyM2g0SHpGM0grRmly?=
 =?utf-8?B?MEZNVE9zckxEQUhUMG9lL2xqOG5lZkl6RXF4VDdlTVNEd0RtY09EVXlYWnBQ?=
 =?utf-8?B?L1hKNXErb2E2a0dRNmZSdHUxZUs5aGF0SE9JY0RLVFpGS3B0aFBZL05aaHpY?=
 =?utf-8?B?N1pkaXNHSHRWYmM5U2xlMkM4WnA1V3YxWlczSnpnNzIzTVh4eGZnRHJyUVR6?=
 =?utf-8?B?MjdacG1RSEV6K1ova2d4eDdPa1J4dVBQUVp1SWhHeG1CclVkRmQramhSRDd2?=
 =?utf-8?B?Z3VMVXJBWXlkN0xxN2R1ZUVRWmYvZWE5bS9wWkZQSVJCeTQyQjhnZEJZZm9i?=
 =?utf-8?B?K2VMemhsQ2JMcm9jV2h1WWRCQllIWmh1a2FaZlJ4eXdJWDNCZmpzaDUzMlhL?=
 =?utf-8?B?Ry9pWDIveEx3aENzcC82S05HdzFCazJLdGs0Mjh5WWlMNkgwMWc1eGJOd0ZO?=
 =?utf-8?B?NEhqLzFrVmViVjRNVTBGTW9NTUVHS0JJY21BU2tmbXFQdFQxd051cUhRTEZq?=
 =?utf-8?B?OUZISFRxZ0NWd1NGcjQrWW9heGhBZjdpbWdiOUgzNEdwMG1QSHVkQVdJS2hn?=
 =?utf-8?B?ZkFjeHE3UnFBODlCcHpvYmdFcFVuaEp5QXkzTzA0Smd6a0lwSlJvMzZ4UXNO?=
 =?utf-8?B?Tkl4cUdtWFdXUnJuOHVOT3pKOTFlNkJGbGVMSGt6NGNOTHVzbGZxSmZUK0FB?=
 =?utf-8?B?cGM0LzBYOFBCUGxRd3Nvb0VmdWhqOFdsOFpLYWliZzU0UUpPemdEQWxOWEkw?=
 =?utf-8?B?RGFFUFFrN1JVaTkxQllTb2VtWllHanZxeXkxV21ER3czL3piNEkycDJidkxu?=
 =?utf-8?B?R21VcDJzY3cyNjlXWGxzWFFOanY5TGNDL2dGOVA1VVpRVmF3SWJ1MUxxeHV0?=
 =?utf-8?B?cmVLOE12TlUwN2h5M0pWREx1UnJQcTlxRDVRZG9CanlHaG96RDlYK1luVW1j?=
 =?utf-8?B?KzBUcHBSSDY2N2YvRThmT0xaRUpITnpsRWxwRU1vNlB3cER2ZVRLTTJwS2RW?=
 =?utf-8?B?b2hYOXpkOWZwNmhTeXBtS3hqV2NWQngrNkU1MVVqdzlOb1c4WTZDblg2MFRU?=
 =?utf-8?B?ZGltZUVpWjhvQUxVYi9JYWlQYS85T2ZQdXpNRHBpeFVuSmRpTU8yUnNXdUlD?=
 =?utf-8?B?d005N2ZJdThqNWxBNEtPVjFFTGxrV21MTkdqRW1NcmN5ekp5N09VNE8zQWJm?=
 =?utf-8?B?QnFOZmJSMDFJRmJHWFRFRTh5KzVCYjJENm1SMmU4NmR5NHB0RjFuSDFGSXEw?=
 =?utf-8?B?TWplMHBQdXVpT01yTU50YUJ4T1FuS3VtM3RaOTZCQ0hkb2dOV1R3cFB1dHNh?=
 =?utf-8?B?S2NYSmF0cG12Z05yalFQUFZrZjUyby9GUExaWVIrSit5WHQxQjFraWZmdnU0?=
 =?utf-8?B?ZkFmZ1c2ZlVsL1hFRnVUMnBXOUsycHRlRERKZnBja1l3aFRwQ1VZMUZVUmJh?=
 =?utf-8?B?Nk5hKzNJQm9henVOaG9Ka205eEJTQStQSDFqbC9XWW5BM29zOER1alEyenNz?=
 =?utf-8?B?bXRHWVRhV21XMmRKVzE3Tk1sNGVVcnJMS0cyNVBLVnlkZVUrbFpSclRoVEZL?=
 =?utf-8?B?Z2t2UDc2cHNjcmhXS1FaaUt1M0hqRUlYZkR2NnQzeWhYSlp2TFBpTzcwcyta?=
 =?utf-8?B?b3dnUGd6bXFOQ2padzJUamVtYVZhdW5vZEFheXdEMTExSVhlK2JPZlZGdVIr?=
 =?utf-8?B?enJUbVVTTklrTmVpWk5GWml3dExiVW5kMSs5T0N6M2swVG1GR2FhT1pFL0Fl?=
 =?utf-8?B?eHNGbGZlTzZSbjVnU29kT1RvbDY5S3RyQW9qQ09WdVgwS25TS1FiUFgyQWpj?=
 =?utf-8?Q?HIst4G8W4iBIeH+28q6s+UHbC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fdab7052-042d-43fc-def6-08dab61c5d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 00:03:36.2866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5krY23Jdo6ri94W6hUtxVMzHrnRTITtubPcCcklVIZeuG7AgaN76l3d8wv8T5gZzji6WAKBqKNq3tkHK6lgdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1709
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: tnrmlRzHhfXMtA4lmtNZ_IZv_YKDyVc-
X-Proofpoint-GUID: tnrmlRzHhfXMtA4lmtNZ_IZv_YKDyVc-
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_08,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 mlxlogscore=662 clxscore=1011 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240144
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIGRvbid0IHRoaW5rIERUIHBsYWNlIGlzIHRvIGRlc2NyaWJlIHJlZ2lzdGVyIG9yIG1lbW9y
eSBsYXlvdXQsIHdpdGggc29tZSBleGNlcHRpb25zIGxpa2UgTVREIHBhcnRpdGlvbnMgb3IgbnZt
ZW0gY2VsbHMuIEJhc2ljYWxseSB5b3UgYXJlIHJlcHJlc2VudGluZyBoZXJlIGEgZGV2aWNlIHJl
Z2lzdGVyIG1hcCBpbnNpZGUgRFQsIGp1c3QgYmVjYXVzZSBpdCBpcyBhIENQTEQuDQoNCj4gRXZl
cnkgcmVndWxhciBtdWx0aS1mdW5jdGlvbmFsIGRldmljZSBoYW5kbGVzIGl0cyByZWdpc3RlciBt
YXAgaW4gdGhlIGRyaXZlciBpdHNlbGYgYW5kIHVzZXMgTGludXggZnJhbWV3b3JrIHRvIGV4cG9z
ZSB0aGUgaW50ZXJuYWxzLiBDUExEIHNob3VsZCBub3QgYmUgZGlmZmVyZW50LCBleGNlcHQgdGhh
dCBpcyBwcm9ncmFtbWFibGUuDQpIaSBLcnp5c3p0b2YsDQoNClRoYW5rIHlvdSBmb3IgeW91ciB0
aW1lIGFuZCBmZWVkYmFjay4gV2UgYXJlIGxvb2tpbmcgZm9yIGEgcGxhY2UgdG8gZGVzY3JpYmUg
ZGlmZmVyZW5jZXMgd2l0aGluIG91ciBDUExEIGltcGxlbWVudGF0aW9uIGR1ZSB0byBvdXIgbWVt
b3J5IG1hcHBpbmcgbm90IGJlaW5nIGNvbnNpc3RlbnQuIFRoZSBpZGVhIHdlIGFyZSBwdXJzdWlu
ZyBpcyB0byB1c2UgdGhlIGRldmljZSB0cmVlIHRvIHNlcnZlIGFzIGFuIGlucHV0IHRvIExpbnV4
IHRvIHByZXZlbnQgZHJpdmVyIGNvZGUgZnJhZ21lbnRhdGlvbiBmcm9tIG11bHRpcGxlIHBsYXRm
b3JtcyBuZWVkaW5nIHRoZWlyIG93biBzcGVjaWZpYyBvZmZzZXRzLiBJZiB0aGlzIGlzIG5vdCBh
Y2NlcHRhYmxlIHRvIGRvIHRocm91Z2ggdGhlIGRldmljZSB0cmVlLCBzaG91bGQgd2UgcmVseSBv
biBoYXZpbmcgYW4gaW5jbHVkZSBmaWxlIGZvciBlYWNoIHBsYXRmb3JtIGluc3RlYWQ/IA0KDQpU
aGFua3MsDQoNCi1OaWNrIEhhd2tpbnMNCg==
