Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA37B63656C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238861AbiKWQJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiKWQJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:09:43 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A715169DCA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:09:42 -0800 (PST)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANG4l11009488;
        Wed, 23 Nov 2022 16:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=303nRVbZ4c/ZNRtgm7dV516/HiaHudXDaoF6OEflHbI=;
 b=Ym7+jsmq7Y/VLpxG4netJpo43CV8CictESs4IyjLKPxa75ewwU+NFaHMSqlweFU9agw2
 BpFKxhBCFApPb1MqdxlWYy29HFCIeNXsnNHXEvxSMOZQoHKB7LxWgXfI6BJ/WEmLs2n0
 lyd/RbYqUN5C1cQgi4JVioqnGaHfj99xE5p+CEDSoNpSGBeI7H1k8K3jraXD6qrvr/rp
 krV6Mw9M48zeMas8G3TNWktJ5aKIyCj3NFe54I2GJz7nlbpPdDGNb5ptEqBpCXQVuGYs
 FVUxQFW7sIUTpgA2EfK0uslq15ZOTfnMeir1h0JFuSQWgWKXItHZPk8C9eiYStECOJ0X tA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3m1pqg81mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:09:19 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id A5EC1310C0;
        Wed, 23 Nov 2022 16:08:25 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Nov 2022 04:08:04 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 23 Nov 2022 04:08:04 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Nov 2022 04:08:04 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFWR6P4OS7bgf7YRaQw2x7rj06N8btja3a6SYajCo9ZdhH5YiY75fiHeP6ne9T+iU+DhQW5Z0LV32K9qcoM0D1C28NMsWnN3VfJHo0LQK26vDHt97NWIs0CqHwLxJUrktBCIz9Gcdv2RT3xt/SIQ6uepb63dsLrgTGO0Ex6aQNjR39v3EOSauJaiVeMbJwu/iKSb2LaZ4PxsaG9CHnXJY7BTYyk9SNXUdnvbFWPXE/ejJoaXndQ9MUVKAnLoWXj2s7IDhbJ8V/BYtKAkwpMf9lqH7CB5JywdP0vQwy6zgp7qodyKCXlsSELHRBzqVzCQ2+hTwYxrceS12pa3CzNdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=303nRVbZ4c/ZNRtgm7dV516/HiaHudXDaoF6OEflHbI=;
 b=U+JVZrNXO9WBk0rgpM6zTqAEdbaL9HGesVBesKwjfQwMY2GjKGm26aSqRPU/nKHY1yQSRvwN3dbytQpibMZG5kp4dtzwgnoVruuzmyepWL0hleLDSyBXM/aEMQYbHxidp55YY1eHAanfkLP19tafYn3Ys+5K7aZQPaOTToF0FeEW5mVZlrgFLFikgrYNjg3IpEag0uYOnNkMBOO0uOplXRkcFlns6d4HgQ7alDWsX0hxQ39ih1FeZ7yBZednadZ6uvv0GxGGAM3eMCN9vUqZCE/8TniHJUVwQ67/D8RlxeuKMChABVBEOGE3b2xYOEvdRs5xJ3guu2KH/9YTqEJjSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW5PR84MB1771.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Wed, 23 Nov
 2022 16:08:03 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816%9]) with mapi id 15.20.5834.011; Wed, 23 Nov 2022
 16:08:03 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
CC:     Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        "phillip.lougher@gmail.com" <phillip.lougher@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: RE: BUG: BISECTED: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
Thread-Topic: BUG: BISECTED: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
Thread-Index: AQHY/PfIWZHIbqps10CHvEbxuCmGXa5IFygAgAAM4ICAAAy2AIAAkg8AgAFxogCAAgmCgIAAXD2AgAAMf2A=
Date:   Wed, 23 Nov 2022 16:08:03 +0000
Message-ID: <MW5PR84MB1842135518BD1D119E26EDCDAB0C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <eac8af79-8936-f845-c8dd-c63ebf0d5e81@alu.unizg.hr>
 <02877aee-8c05-6534-8a91-94ba366d0276@squashfs.org.uk>
 <20221118155534.GJ4001@paulmck-ThinkPad-P17-Gen-1>
 <dd430080-774b-1cba-1758-2bf92cb1acac@alu.unizg.hr>
 <20221120175016.GC4001@paulmck-ThinkPad-P17-Gen-1>
 <8e62a31f-3ef8-71ec-6181-2afa56eeb5db@alu.unizg.hr>
 <20221120192150.GE4001@paulmck-ThinkPad-P17-Gen-1>
 <8c9eb87b-5623-730a-5cf6-72d831ef797a@alu.unizg.hr>
 <20221122020734.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <e8f5b9b3-383a-c267-9ee3-f1e0da5466fc@alu.unizg.hr>
 <20221123144415.GX4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221123144415.GX4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|MW5PR84MB1771:EE_
x-ms-office365-filtering-correlation-id: 51425208-6160-4031-033b-08dacd6ce659
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YrgvnYBSVFILapc5SHhBcES9VdKI8Gb413MV6HQWdLJOVhy9nQxRwhkx3R94k8BrGCWXURAaW7mySPAnDKnAKj0w5yvBmaLvaNrrkzCHn0R5eRXO+jcRGk/I96O3fHoxea0DK8+HYGuHIq6hbC4eZZUVUfuWbp/FXNGORwlVoyDa51YJa8/vbq+1R3WWatFm6c3CmfUMcouXQ7g1gUCUYdxq0vA+TfJHR6lQ0Y3fx8JbBx91bOBLdesEIsH+9XmoJksMZy+7EKszg7s1V+0sPxeyNZm7A8ZPCw0xuhZTmMU4sItcx/WQLv8UPSwWB8EdL2symwoPKw2WQVLb63NLjCSHC1Xb17W53bYtIAbo/5iGmoT2+8tuEp49mdXsFr0YKOQxl4ejtT9wWyGvNR1RrTxAT00i991HkOeDquQyoOXZtUBe3T5+qamH6bJNpGBK0Fk0yF/7JtdsQ216FtkbXlQqd/nz0EIl7mu+1B3B2/696P0W2Z25jOyNaIrtJvpOhrDhh68iNAgiOLQg8L58I5VmlqdHvVPHb3OnT5fFOOFkD7QgZQ7sxjq2Nt5zhb2k4CWYuv26+3jP5a9uywTM2Mo18R6zvcfs4oeonFDUWhlAFRGNnW3r6sCW8Vw6D/mXGNwDnl52gyDKXp2LbNJCMscLPE7R6gKGuEhgrYRPl1UHZ1Ozv477fRnP8G9PUO5MFczaFecWjd+8tQYXqR/P8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(2906002)(8936002)(41300700001)(5660300002)(52536014)(83380400001)(86362001)(316002)(53546011)(7696005)(6506007)(8676002)(4326008)(9686003)(33656002)(64756008)(110136005)(54906003)(66946007)(66556008)(76116006)(66446008)(66476007)(122000001)(38100700002)(55016003)(26005)(38070700005)(186003)(478600001)(82960400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVZEdHpqc0hOZ3hNRWM0ck9UMG5UbG9FNFFqMGtWb0NQUlZFdVpwNjFFYzBl?=
 =?utf-8?B?TEFPSER1b002QXlWbmtRK3E1NDJYQXNKUGZ1a0MwMUJqU2txcjJYNVJGV2JF?=
 =?utf-8?B?ZXZwKzJ2SExYbENNbUNJeGFYVTFZTzRuMC9OeWV1RjZyenVLeFkrbUVGR1NN?=
 =?utf-8?B?djd6ejJuWWdndlhHNWpkNm9aQWpJZVg3VkQza1RBRVV1YmpSMTE3Ync5VFJ2?=
 =?utf-8?B?U25zV0d1TXJWMjB0YTI5YTN1bTN6ejM5OWVORmNCQjM1QkY3ZU1hZTAremJ0?=
 =?utf-8?B?MjhmQnpvWUp3TUJCU2lCeFpBWEJ2MHhuc3FFT1ZzeWJ3c1RxRk5GeS96Y0p1?=
 =?utf-8?B?cCtSSVlsRlNYMG1YRExlNzBZNURFMm9NeXI1dnpNUUkyclJFRHN4MUlIUEpO?=
 =?utf-8?B?cWZlMXZaNk11NUtlUWRXdTI2ZVhzaGlNR1hHVHlvVHhWbFRXV1NTanJDcDJN?=
 =?utf-8?B?MFBGVFB1cjR2MnJNNEM5K2lDcDBNd2xjOWRVYytGTUxpcnpmcVJTY0pnREhy?=
 =?utf-8?B?SGwwYVBxc0phWkIvbTgya1ptSllKZEE1cXpUZVFTS0x1aDJuMGdqY1VsQ3hX?=
 =?utf-8?B?Y1dubWRCNnNMaldUbXpOa09nd1RNUzJ4a2RYU2MyRFcvNUk1ZGlocGlMUFM4?=
 =?utf-8?B?RnZGSkd3cU1qLzNHOW4wUjVrT1IyNzRmaWsrUnMxSjhjcitKQWZQUGRzQTdz?=
 =?utf-8?B?S1FSTitnWko0SGZnYU1sUEZqd3FUQ0t5M3NyTU9YWUxyQkwydVlnRzRWc0Q5?=
 =?utf-8?B?bURzQXA0b3BjUEZDRGxyYlNLL3JYM0FYV1Y5dmt0Y05nS0xvQXVPeXE0N1VD?=
 =?utf-8?B?TW9Sa01UdlgwTW95WTJMN1BIMWE4UGJ2WkhRdlFPQ2FBR0tYaVFhVm1GNUhS?=
 =?utf-8?B?RFU2Szh0U2wydmptT0VQbkQ5VUN1ekt5ZDJuZE5kQTVmNTJNVG1KUytaYTBh?=
 =?utf-8?B?TEFzSXNNeG5zbWdsdGpoZVZCRDNEYk5tYmhGNlFXZzEybDA3SmxPU0owcVJN?=
 =?utf-8?B?bjZ4dzNTZHZsZnBkMkFoNzhuWkxpRjRBMGNrQTk2N3ZyWUhkUTlueXl3OENw?=
 =?utf-8?B?QnpFT3pEYktXWGd1ajZYV1F2dGVVNkRXQ0pxK3lXTnZ0OEo4N2g1Z25vM1Z2?=
 =?utf-8?B?Umlwck1wdzk1TUJ6cHNFN3RXb0Vpa09iTzRYb0huUk1BMCsxWGd1dm1WMlR4?=
 =?utf-8?B?VmJjOENQTjlRZ1pHbXNRZWt4dEpDdkhRM2U1N1doR1c3RGF0QzhmeDQ4YlVt?=
 =?utf-8?B?TGlCaEwxdHFIcFM3eVFBcXRUeFJIVjVnSURKckl0VVR2eXFpNlZBV2NGa2Fu?=
 =?utf-8?B?YmI4SGJ6VjlERjIzQXZJMG5RdXIzVXhFbzJCL3RSZTZYT3BmQUlwLzYzQUJO?=
 =?utf-8?B?a3dwanFhbGh4eEpCUER5YlVnMmYxZVBoSU4rVk9haUlmc2ZmTjVVbFIxcUhp?=
 =?utf-8?B?SS9ZNmtnNXNzQVFhdU1iYmtSeVBGV3pTRUtBekVFQjZMcS81Tmh6b3YyL2dk?=
 =?utf-8?B?NHZKTEZ2Q2JBR1A2OFpnYlozN3psT24wMmRjdDkyY0EraHBpTWN0RmRsdjI4?=
 =?utf-8?B?bkNOVVJWNUJnY25uYUpic2FadU8rbXlSdGE5dEJEZ2VwZDZpdmZLT3pmTE5N?=
 =?utf-8?B?OXBBeHhGWURQSUp5VGFtVThmeG9IcWJYV0d2OW9IYzB6V2NIUnJxTlJCWFBS?=
 =?utf-8?B?Q2lNeElUV3pWYUV0OWhrakNJSG9xZ3ZwV0Z6VTREWURSNmVjMjNZb1NES014?=
 =?utf-8?B?QVdZbUZoODNqdGt2UmhoUHhCdDQ1Z2xvYm5vV1JpbER3aGZOcmF5YnNYdFJT?=
 =?utf-8?B?bnRYUHg1VnlvUzJBQVJJUStJQVZ0OEVkeVhrTXRpOXQ4aHlzRlJJMEdXRGJs?=
 =?utf-8?B?elRnODhxbm1scU9uR0Q4RVRyRnZ2UFgxR0RBdFRkM2ZXekNRNE1GNWpEREV0?=
 =?utf-8?B?eXNVbGVTTmhrclAyVjhtQ3ZIM09zc08wbll2c2I1dTdOMWFGMlBsZFhGOEhP?=
 =?utf-8?B?NUpzZ2IzSHpuSW92OG9JSUVZSnNhTW5RVEVDc0FaMDk5am9lQm1JWmw0cGVi?=
 =?utf-8?B?c0tUdGtjYUkrN0RrWTBxRVR0UTU2Y2NNZC9Xb2l6NWpjd0YrOHkyck9ZU1RT?=
 =?utf-8?Q?qceI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 51425208-6160-4031-033b-08dacd6ce659
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 16:08:03.0464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o9vpdue0kKsMD2rgQqN1DmSOOyykiPMB3BYrCBY3/KnbGXZbRQ83gEMsNgFZIf2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1771
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 9lI7lIAw6X7JVttK0E6vqfQNKTvS-icp
X-Proofpoint-ORIG-GUID: 9lI7lIAw6X7JVttK0E6vqfQNKTvS-icp
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_09,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230119
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBFLiBNY0tlbm5l
eSA8cGF1bG1ja0BrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDIzLCAy
MDIyIDg6NDQgQU0NCj4gU3ViamVjdDogUmU6IEJVRzogQklTRUNURUQ6IGluIHNxdWFzaGZzX3h6
X3VuY29tcHJlc3MoKSAoV2FzOiBSQ1Ugc3RhbGxzDQo+IGluIHNxdWFzaGZzX3JlYWRhaGVhZCgp
KQ0KPiANCj4gT24gV2VkLCBOb3YgMjMsIDIwMjIgYXQgMTA6MTQ6MDdBTSArMDEwMCwgTWlyc2Fk
IEdvcmFuIFRvZG9yb3ZhYyB3cm90ZToNCi4uLg0KDQo+ID4gY29tbWl0IDEwNDVhMDY3MjRmMzIy
ZWQ2MWYxZmZiOTk0NDI3YzdiZGJlNjQ2NDcNCj4gPiBBdXRob3I6IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPg0KPiA+IERhdGU6ICAgV2VkIEp1biAyOSAxNzowMTowMiAyMDIyICswMjAw
DQo+ID4NCj4gPiAgICAgcmVtb3ZlIENPTkZJR19BTkRST0lEDQo+IA0KPiBCdXQgeW91ciBDT05G
SUdfUkNVX0VYUF9DUFVfU1RBTExfVElNRU9VVCBzZWVtcyB0byBiZSBhYm91dCAyMC4NCj4gQXMg
aW4gMjAgbWlsbGlzZWNvbmRzLg0KPiANCj4gSXMgdGhhdCBpbnRlbnRpb25hbD8NCi4uLg0KPiA+
ID4gQW5kIG9uZSBhcHByb2FjaCBpcyB0byB0YWtlIGEgbGVzcyBhZ2dyZXNzaXZlIFJDVSBDUFUg
c3RhbGwgdGltZW91dCwNCj4gPiA+IHNheSByZWR1Y2luZyBmcm9tIDIxIHNlY29uZHMgdG8gKHNh
eSkgMTUgc2Vjb25kcyBpbnN0ZWFkIG9mIGFsbCB0aGUNCj4gPiA+IHdheSBkb3duIHRvIDIwIG1p
bGxpc2Vjb25kcy4gIFRoaXMgY291bGQgYWxsb3cgeW91IHRvIGVhc2UgaW50byB0aGUNCj4gPiA+
IGxhdGVuY3ktcmVkdWN0aW9uIHdvcmsuDQo+ID4gPg0KPiA+ID4gQWx0ZXJuYXRpdmVseSwgY29u
c2lkZXIgdGhhdCByZXNwb25zZSB0aW1lIGlzIGEgcHJvcGVydHkgb2YgdGhlDQo+ID4gPiBlbnRp
cmUgc3lzdGVtIHBsdXMgdGhlIGVudmlyb25tZW50IHRoYXQgaXQgcnVucyBpbi4gIFNvIEkgc3Vz
cGVjdCB0aGF0DQo+ID4gPiB0aGUgQW5kcm9pZCBmb2xrcyBhcmUgYWNjb21wYW55aW5nIHRoYXQg
MjAtbWlsbGlzZWNvbmQgdGltZW91dCB3aXRoDQo+ID4gPiBzb21lIHJlc3RyaWN0aW9ucyBvbiB3
aGF0IHRoZSBvbi1waG9uZSB3b3JrbG9hZHMgYXJlIHBlcm1pdHRlZCB0byBkby4NCj4gPiA+IE1h
eWJlIGFzayB0aGUgQW5kcm9pZCBndXlzIHdoYXQgdGhvc2UgcmVzdHJpY3Rpb25zIGFyZSBhbmQg
bG9vc2VuIHRoZW0NCj4gPiA+IHNsaWdodGx5LCBhZ2FpbiBhbGxvd2luZyB5b3UgdG8gZWFzZSBp
bnRvIHRoZSBsYXRlbmN5LXJlZHVjdGlvbiB3b3JrLg0KDQpTaW5jZSB0aGVyZSBpcyBubyBsb25n
ZXIgYSBrZXJuZWwgZGVmYXVsdCBvZiAyMCBtcyBmb3IgQW5kcm9pZCBzaW5jZQ0KY29tbWl0IDEw
NDVhMDY3MjRmMyAoInJlbW92ZSBDT05GSUdfQU5EUk9JRCIpLCBpdCBtaWdodCBiZSBhcHByb3By
aWF0ZQ0KdG8gZHJvcCB0aGF0IGZyb20gc3RhbGx3YXJuLnJzdC4gU29tZXRoaW5nIGxpa2U6DQoN
CmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL1JDVS9zdGFsbHdhcm4ucnN0IGIvRG9jdW1lbnRh
dGlvbi9SQ1Uvc3RhbGx3YXJuLnJzdA0KaW5kZXggZTM4YzU4NzA2N2ZjLi5kODZhOGI0NzUwNGYg
MTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL1JDVS9zdGFsbHdhcm4ucnN0DQorKysgYi9Eb2N1
bWVudGF0aW9uL1JDVS9zdGFsbHdhcm4ucnN0DQpAQCAtMTY4LDEwICsxNjgsMTEgQEAgQ09ORklH
X1JDVV9FWFBfQ1BVX1NUQUxMX1RJTUVPVVQNCiAgICAgICAgU2FtZSBhcyB0aGUgQ09ORklHX1JD
VV9DUFVfU1RBTExfVElNRU9VVCBwYXJhbWV0ZXIgYnV0IG9ubHkgZm9yDQogICAgICAgIHRoZSBl
eHBlZGl0ZWQgZ3JhY2UgcGVyaW9kLiBUaGlzIHBhcmFtZXRlciBkZWZpbmVzIHRoZSBwZXJpb2QN
CiAgICAgICAgb2YgdGltZSB0aGF0IFJDVSB3aWxsIHdhaXQgZnJvbSB0aGUgYmVnaW5uaW5nIG9m
IGFuIGV4cGVkaXRlZA0KLSAgICAgICBncmFjZSBwZXJpb2QgdW50aWwgaXQgaXNzdWVzIGFuIFJD
VSBDUFUgc3RhbGwgd2FybmluZy4gVGhpcyB0aW1lDQotICAgICAgIHBlcmlvZCBpcyBub3JtYWxs
eSAyMCBtaWxsaXNlY29uZHMgb24gQW5kcm9pZCBkZXZpY2VzLiAgQSB6ZXJvDQotICAgICAgIHZh
bHVlIGNhdXNlcyB0aGUgQ09ORklHX1JDVV9DUFVfU1RBTExfVElNRU9VVCB2YWx1ZSB0byBiZSB1
c2VkLA0KLSAgICAgICBhZnRlciBjb252ZXJzaW9uIHRvIG1pbGxpc2Vjb25kcy4NCisgICAgICAg
Z3JhY2UgcGVyaW9kIHVudGlsIGl0IGlzc3VlcyBhbiBSQ1UgQ1BVIHN0YWxsIHdhcm5pbmcuDQor
DQorICAgICAgIEEgemVybyB2YWx1ZSBjYXVzZXMgdGhlIENPTkZJR19SQ1VfQ1BVX1NUQUxMX1RJ
TUVPVVQgdmFsdWUgdG8gYmUNCisgICAgICAgIHVzZWQsIGFmdGVyIGNvbnZlcnNpb24gdG8gbWls
bGlzZWNvbmRzLCBsaW1pdGVkIHRvIGEgbWF4aW11bSBvZg0KKyAgICAgICAgMjEgc2Vjb25kcy4N
Cg0KICAgICAgICBUaGlzIGNvbmZpZ3VyYXRpb24gcGFyYW1ldGVyIG1heSBiZSBjaGFuZ2VkIGF0
IHJ1bnRpbWUgdmlhIHRoZQ0KICAgICAgICAvc3lzL21vZHVsZS9yY3VwZGF0ZS9wYXJhbWV0ZXJz
L3JjdV9leHBfY3B1X3N0YWxsX3RpbWVvdXQsIGhvd2V2ZXINCmRpZmYgLS1naXQgYS9rZXJuZWwv
cmN1L0tjb25maWcuZGVidWcgYi9rZXJuZWwvcmN1L0tjb25maWcuZGVidWcNCmluZGV4IDFiMGM0
MWQ0OTBmMC4uNDQ3N2VlYjhhNTRmIDEwMDY0NA0KLS0tIGEva2VybmVsL3JjdS9LY29uZmlnLmRl
YnVnDQorKysgYi9rZXJuZWwvcmN1L0tjb25maWcuZGVidWcNCkBAIC05Myw3ICs5Myw3IEBAIGNv
bmZpZyBSQ1VfRVhQX0NQVV9TVEFMTF9USU1FT1VUDQogICAgICAgICAgSWYgdGhlIFJDVSBncmFj
ZSBwZXJpb2QgcGVyc2lzdHMsIGFkZGl0aW9uYWwgQ1BVIHN0YWxsIHdhcm5pbmdzDQogICAgICAg
ICAgYXJlIHByaW50ZWQgYXQgbW9yZSB3aWRlbHkgc3BhY2VkIGludGVydmFscy4gIEEgdmFsdWUg
b2YgemVybw0KICAgICAgICAgIHNheXMgdG8gdXNlIHRoZSBSQ1VfQ1BVX1NUQUxMX1RJTUVPVVQg
dmFsdWUgY29udmVydGVkIGZyb20NCi0gICAgICAgICBzZWNvbmRzIHRvIG1pbGxpc2Vjb25kcy4N
CisgICAgICAgICBzZWNvbmRzIHRvIG1pbGxpc2Vjb25kcywgbGltaXRlZCB0byBhIG1heGltdW0g
b2YgMjEgc2Vjb25kcy4NCg0KPiA+ID4gQnV0IHBsZWFzZSBrZWVwIGluIG1pbmQgdGhhdCBjb25k
X3Jlc2NoZWQoKSBoZWxwcyBvbmx5IGluIGtlcm5lbHMNCj4gPiA+IGJ1aWx0IHdpdGggQ09ORklH
X1BSRUVNUFRJT049bi4NCg0KSSB0aGluayB0aGV5IGFsc28gaGVscCB3aXRoDQoJQ09ORklHX1BS
RUVNUFRfVk9MVU5UQVJZPXkNCndoaWNoIGlzIHVzZWQgYnkgRmVkb3JhIGFuZCBSSEVMLiBGb3Ig
ZXhhbXBsZSwgYWRkaW5nIG1vcmUgb2YgdGhvc2UgaW4NCnRoZSBjcnlwdG8gdGNyeXB0IHRlc3Qg
bW9kdWxlIGVsaW1pbmF0ZWQgc29tZSBSQ1Ugc3RhbGxzIHdoZW4gcnVubmluZw0Kc3BlZWQgdGVz
dHMgKHRoYXQgc2VuZCBsb3RzIG9mIGRhdGEgdGhyb3VnaCB0aGUgYWxnb3JpdGhtcykuDQoNCj4g
PiBJIGhhdmUgYmFkIG5ld3MgdGhhdCA2LjEtcjYgaXMgc3RpbGwgYWZmZWN0ZWQgd2l0aA0KPiA+
IHNxdWFzaGZzX3h6X3VuY29tcHJlc3MgYnVnLCBkZXNwaXRlIGhhdmluZyBib3RoIG9mIHlvdXIg
Zml4ZXMNCj4gPiAoYXMgdmlzaWJsZSBpbiBhYm92ZSBjb21tYW5kJ3Mgb3V0cHV0IC0tIGRvdWJs
ZSBjaGVja2VkKToNCj4gPg0KPiA+IFsgICA5MS4wNjU2NTldIHJjdTogSU5GTzogcmN1X3ByZWVt
cHQgZGV0ZWN0ZWQgZXhwZWRpdGVkIHN0YWxscyBvbiBDUFVzL3Rhc2tzOiB7IDMtLi4uLiB9IDYg
amlmZmllcyBzOiA2MjEgcm9vdDogMHg4Ly4NCj4gDQo+IElmIHlvdSBidWlsZCB3aXRoIChzYXkp
IENPTkZJR19SQ1VfRVhQX0NQVV9TVEFMTF9USU1FT1VUPTIwMCwgZG9lcw0KPiB0aGlzIHN0aWxs
IGhhcHBlbj8NCg0KQlRXLCB5b3UgZG9uJ3QgbmVlZCB0byByZWJ1aWxkIHRoZSBrZXJuZWwgdG8g
Y2hhbmdlIHRob3NlIHBhcmFtZXRlcnM7IHRoZXkncmUNCm1vZHVsZSBwYXJhbWV0ZXJzLCBzbyBj
YW4gYmUgbW9kaWZpZWQgb24gdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUgKGlmIG5lZWRlZA0KZHVy
aW5nIGJvb3QpIGFuZCBzeXNmcyAoaWYgb25seSBuZWVkZWQgYWZ0ZXIgYm9vdCkuDQoNCkZvciBz
eXNmcyB0aGUgc3ludGF4IGlzOg0KIyEvYmluL2Jhc2gNCiMgc2V0IHJjdSB0aW1lb3V0cyB0byBz
cGVjaWZpZWQgdmFsdWVzDQplY2hvIDYwID4gL3N5cy9tb2R1bGUvcmN1cGRhdGUvcGFyYW1ldGVy
cy9yY3VfY3B1X3N0YWxsX3RpbWVvdXQNCmVjaG8gMjEwMDAgPiAvc3lzL21vZHVsZS9yY3VwZGF0
ZS9wYXJhbWV0ZXJzL3JjdV9leHBfY3B1X3N0YWxsX3RpbWVvdXQNCmVjaG8gNjAwMDAwID4gL3N5
cy9tb2R1bGUvcmN1cGRhdGUvcGFyYW1ldGVycy9yY3VfdGFza19zdGFsbF90aW1lb3V0DQpncmVw
IC1IcyAuIC9zeXMvbW9kdWxlL3JjdXBkYXRlL3BhcmFtZXRlcnMvcmN1XypfdGltZW91dA0KDQoN
Cg==
