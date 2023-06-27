Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6642473F967
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjF0J6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjF0J6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:58:17 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2074.outbound.protection.outlook.com [40.107.12.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B4230D3;
        Tue, 27 Jun 2023 02:56:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imZNaZpko6leO46cHnYLkKh5mb700qm7bxMIi+xh68pJcKlSmfYFrrR62gf0hUDuSMIIhJU8iQQ6iuJVrrMPVV8K58zv1syERLbeqOmg1Ac+ogt0QFsueruil95MlV5bc1Ec6R6Fiufk2gvCeAr+tbto8khfO2pSI/q+TacrFiOMhXaT5FS4ddz67LoZ07Ei1pZFsDDv100qjbr0MIru2vNCM9lIemfu+50WDxfWzmEzwQtM+eoloH40AllZDGINObUaPKkV7EHjEhQwEEHujyD8u9dbsVleez+RzqQUpBD5mjcWd1bYRjhZ2G+TyCpLakIpvkafaxniviV8kTFMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjkOAAnXH9nV5cREo0F7R+1xtJYzT4RRlfbm1vSwWDc=;
 b=Fibn/KM+Kwlon+fzBb3+Y1ActCaoN4emQPtWjd7McKY174fjrkPq2HEBXcvKx/Ok8gP3ne8fq27/XoXQkXivMZJzKlTRfwrwu8NlYlP8ra9zXxSVx1gqrszkVtkFQk/51kIIQZ0gLAbg8vuVz6OIX6dnsRna3yfttwwJRlm7sZECOV5OcZ0xyiFBwuV1pUL/tqUJc/VKDHmG4jeyGAV8xYwnTfDDaqWW4CtNqmqLzeOCYCYIDECd8IInEWUOCcWch5QKch/yxFM8Upl1OZiGabg0BvOLiAp6zEgLaUN4k6uERPp21MOqSDjvyQG9Iqb39L2RAwyN2G2M2B90cMir/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjkOAAnXH9nV5cREo0F7R+1xtJYzT4RRlfbm1vSwWDc=;
 b=LBg+pJE37dfHXc1UqRy1bfA/xBJUUA1yORTkMf0GkABkA/jE73xwNTsP19DbgPTNmlgUucvVb9h6F7Wm89rOp2Js43H8352J2trGUJZP8K2Kn2poJ91hHxj56tzLpJ+I/RegG7xm1D56v8fZsKXtFvu7XkmyFbFOg/aO3uXbznhwqwnEHECkhmhoiRwoeQvnlgfqdnFZQ4Tb1BkqBZjB1k8tuTOyEqT/rQy8mSGNO1CFDOfcClRYFBbhKQHOHoZrUmJMyY9qMAzfR+uAUiyjgVTXf2MrzU2gGN0ERvOpxvMTxOxumKk8J3toMwasVe/7pMNlZgA+u7JvXZJFblQ5KQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1628.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:56:42 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:56:40 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 06/13] iio: inkern: Fix headers inclusion order
Thread-Topic: [PATCH v6 06/13] iio: inkern: Fix headers inclusion order
Thread-Index: AQHZpbDvCz7WbguNN0Sr6cfBmnNqZK+eb/OA
Date:   Tue, 27 Jun 2023 09:56:40 +0000
Message-ID: <d7a70bf2-b848-db10-2de8-f030e3ab78c3@csgroup.eu>
References: <20230623085830.749991-1-herve.codina@bootlin.com>
 <20230623085830.749991-7-herve.codina@bootlin.com>
In-Reply-To: <20230623085830.749991-7-herve.codina@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB1628:EE_
x-ms-office365-filtering-correlation-id: 238b0b33-330b-48d4-3656-08db76f4cde8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CbaCi5hxC52DIV6q+jK+FDAOpk2OQSzMyauU4bj1YEXAr/kLx4G2A3nwti0RoMq3X33Um58Uc3K1Fyoxh1Uvw3JgxcyBExfouKxS7sxKSrFwrEd8uVcMaV/gSY3B0bEduY4Enz1zc4zKlxDXl9jU2tFMG6JQTPEzPAij469Qv2qYoDjdKTdQcekYyQvbWRKyahNGYrVxJRsiESVuWuKyNUt9aXO60S1bt0/ixjVBP4vPsWc0BuER5Kz8JG4scA3jjFYWgJf3vEb6drF8x4Kf+9oCLuxKqSn8DPX8MwxuGGQrQW7xMKK9GIjs90rnrlag4xRzBtOCAnudJij5+kzSiWluJxOd1Vt4CqmWaZpH3cVCDtOq5cX/yU4U/Ig9yxfjvexxhMYNzsV1NkkojmTU5QJrNfi2uXlEnhthBtVRLH8MFKN/T3RjaRAg+Sk7NEnp0AyCd5LqjQ6q+ilV46LuimOOswCnxg2Rbic617iZb0ttzAudWYnmUUXk4t2pO7VsAzxF6G3uOfzg/pwr1oOtia6RUfsmGCw9cSzez7OS8r46gzjmgTthHxWQrwiYCcD4H8LygcV2NVWrYZ5oCIHO/shFvT2gq/jKEergvyn3pPMk03utiS/f7mAxVvZVgTvRtGW2R1Yg6DGBhzlkpkrl2W8hPq+8W6LUV5GdF3HL1/jbPu4Mrd96V7adrtccuVR1+a8BVzZKrX+fWez2qW1wgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(66556008)(66476007)(38070700005)(36756003)(6506007)(110136005)(54906003)(478600001)(2616005)(83380400001)(26005)(186003)(2906002)(71200400001)(6486002)(4744005)(5660300002)(44832011)(7416002)(921005)(122000001)(316002)(66946007)(31696002)(38100700002)(76116006)(91956017)(64756008)(8676002)(66574015)(86362001)(8936002)(41300700001)(4326008)(66446008)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHg3UkR0Q3cyMDBPT0QvbzlNYlJiYWpwb1Rkb3VBaXIySjI2ZTlzN0UvRzRh?=
 =?utf-8?B?UXY2ZVRsZjNuam5yeE9EVTFTa1lkSVlyQ0daZXpnczN2c1FXMjdZSm84Rm1T?=
 =?utf-8?B?QnAyWkhWQ1pNeEtDV0E3OWc0UDlWQSswdGRkcnpvYjlQazlRamk1TDhReUZj?=
 =?utf-8?B?MWcydXRMWWJpejVWZjZiMGNJcFlRM2pIcGNPTHRlQTNoNFA3bFEvMG82WTFC?=
 =?utf-8?B?Rlp2S2hqa1JPME1tUHdGQlhIZkF5QVJHSENJR2U3ME51SUp5OWs3TVFvSVRk?=
 =?utf-8?B?azkxZDBQMGQyZURONmxsY1BLRTIvWXZzMjMrVXI2UjZRUU0xNlVRRHJBYzBT?=
 =?utf-8?B?V2MzNllRQkx2TFNJS3hWT3FHcnUvbzFLL2NBcEVvQm1lbFZwb1NYM1RjQUtw?=
 =?utf-8?B?MTduRVQ3ajBFMkF2WHZVU0ZXRmFGVk5Yd2lUSXRUUHRKbWlmR295NzVLNGl1?=
 =?utf-8?B?V1dDNTA0RFNzcExBUHBrMUlubDhaWkVYclFDWXpJZmFYVnpGdXp2a3h6Mk1J?=
 =?utf-8?B?ZEIvbnlKd0FzUHhZQUpucWU1dGs2dmh5MjRWb2Q0MmY4TTIwM250OEE1K29E?=
 =?utf-8?B?aUR1ejE2K3Zpd0xzTkxFMjBCK2dhaERRV3F6WE5vQkd3a3ZqbFJ2aTZmUWFY?=
 =?utf-8?B?dlM1YUs2QzhuSnpqR2YvVmZmelZmMGNsVUtJQmgzZ0EvWUViY2tLKzRmS29F?=
 =?utf-8?B?UUs0SlRTNzlMdUVDZVg0UjFHb0owck10eWNKM0h6SHZaV0FneDk3bkFSb0RJ?=
 =?utf-8?B?V1REMFRMQkRCNmJYdTZhV01GcXZYbExqSDJZUGZoeW5Vd3pRNExrUVVCQWF4?=
 =?utf-8?B?OUNwTlRBOU84T1ZtTEovMTh1K2NTb0FqclZVT1dESjVsdmMzMXRmZ0FiZEl2?=
 =?utf-8?B?ZzI1bkZQWm9NTEtRb0tURmt6MTErcHN6T0FxbVhJZWNDWG15TWp1TlNUSEdv?=
 =?utf-8?B?cHNHSk5vQlBxMGlHekZROE0zVkt4aXBiUHg5ODRzeEg5VDlkRk5UUFpEZncv?=
 =?utf-8?B?SkJMN2QvL1R6dEE4U2pqNkZQRVZ6anQwRTFwWERUU2p0OGh1Qnp1UkZKdmMr?=
 =?utf-8?B?TkJ1NFN5RWl6cGZzNG93R2RXN0FITUxrRTF5K0tKTHo4M0NKQTJra2tlM2JP?=
 =?utf-8?B?THBpblZzejROWGJpdkNLZ1lKcXQvbWliOEVRdlUrL1A3YlN0T3VYWlBtaTNl?=
 =?utf-8?B?cC94dFFLaVdUM2JTTjRJSTFRak9iaWUyWGFpcmswMGl5Qng0Yjc1dG8yRG9m?=
 =?utf-8?B?clZHUG9MSTA0R1NGUjVrRjB2bXF3amJpTEp0WHA5VXF2OEE2dTNjeS93ejRW?=
 =?utf-8?B?Y1dyZmRTYlRtVkdNZFVaRGNtMG5WRXF5MEdqQklEL1pSTGlLWHBpdG5wYytn?=
 =?utf-8?B?V3ovZ1hweDdkWlBFdEdjNkQ0WmVpeW42NmFNNlV6bTB5RTYybE10MjQrUllB?=
 =?utf-8?B?U0MvbVIxdksySDQ5OGhxcSsrcEZDbTU1aE9LSW9acnd5S3g2RDNhTXZoa3dK?=
 =?utf-8?B?ZHordDk0Q3pDMk1SQUdEVHZXc1dLeHVDaERacjViWjZ6RkNNbjdDUlovYWVZ?=
 =?utf-8?B?U3YvczFVS09wbUdpSHdKV1BIWE5QTEJHRzRZdFZ3ZVA0N3RrS0lUV0t2aWNH?=
 =?utf-8?B?eFJiRjUxa1dubmxwd1NEV2lZeHdxbHltZEJpZUt0RitaTnFtbzZPK1VLRy9O?=
 =?utf-8?B?eUxrd1VDb0EyZEJMTTlGRkg3M21zZkxqZmhIdENTWFR5NjZRNVhKMnQ3RTZk?=
 =?utf-8?B?RjdEZlNpcUVvTUVkQ1pUcEFUNk9OcDBRbDkyZDZ6Z21yWjZDVVd4N3FVMFBn?=
 =?utf-8?B?dzRBamlMbC9QcnF3LzJEY2FDanZyL041MG40NjNXaTl6NG04cC94V05NL3hs?=
 =?utf-8?B?ZE9zeW5UcE05UTlWb1FNS1RuL2dhSDNXekoyaXQ1Y0Q3QjBrNnA0RFZQd29W?=
 =?utf-8?B?K1FUY1A4aHlCZlY4NXM5WjVOdUdrOVMvUmh1RkZxNlBRS0t6dGd5blBIeHQ4?=
 =?utf-8?B?RlBOdm1xaG92Q2tGQm5tTHpKR3VzNXNNdG9QSmFSWGtMcUtXbGIyMk9jbmlo?=
 =?utf-8?B?anlhR2NjeVh1d2pMR0RSMlB2eUdJMERIa3liWHVCa1Y1VXI2VWFCbUFFaGY2?=
 =?utf-8?Q?vLSPMwzx6L/SMUeN+PvWq1dX3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B5BADD258ED7A42B793B44A5B63B8DD@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 238b0b33-330b-48d4-3656-08db76f4cde8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 09:56:40.1678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0lm64HFlplGSDRltuOMDBH1ihoAKTSJL9pZmT+7bVwx2Ut3DRmUwGrYDdVNUdQEXtcpKPhF3XhbFhmEiXhRFsZ9cmzMVKsk3pTPAj0jApc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1628
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzA2LzIwMjMgw6AgMTA6NTgsIEhlcnZlIENvZGluYSBhIMOpY3JpdMKgOg0KPiBG
aXggdGhlIG11dGV4LmggaW5jbHVzaW9uIG9yZGVyIGFzIGl0IHNlZW1zIHRvIGJlIHRoZSBvbmx5
IG9uZQ0KPiBtaXNwbGFjZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIZXJ2ZSBDb2RpbmEgPGhl
cnZlLmNvZGluYUBib290bGluLmNvbT4NCj4gU3VnZ2VzdGVkLWJ5OiBBbmR5IFNoZXZjaGVua28g
PGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFJldmlld2VkLWJ5OiBBbmR5IFNoZXZjaGVu
a28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IEFja2VkLWJ5OiBKb25hdGhhbiBDYW1l
cm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQoNClJldmlld2VkLWJ5OiBDaHJpc3Rv
cGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQoNCj4gLS0tDQo+ICAgZHJp
dmVycy9paW8vaW5rZXJuLmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW5rZXJu
LmMgYi9kcml2ZXJzL2lpby9pbmtlcm4uYw0KPiBpbmRleCBjZTUzN2I0Y2E2Y2EuLjcxZDA0MjQz
ODNiNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vaW5rZXJuLmMNCj4gKysrIGIvZHJpdmVy
cy9paW8vaW5rZXJuLmMNCj4gQEAgLTUsOSArNSw5IEBADQo+ICAgICovDQo+ICAgI2luY2x1ZGUg
PGxpbnV4L2Vyci5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9leHBvcnQuaD4NCj4gKyNpbmNsdWRl
IDxsaW51eC9tdXRleC5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9wcm9wZXJ0eS5oPg0KPiAgICNp
bmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+IC0jaW5jbHVkZSA8bGludXgvbXV0ZXguaD4NCj4gICAN
Cj4gICAjaW5jbHVkZSA8bGludXgvaWlvL2lpby5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9paW8v
aWlvLW9wYXF1ZS5oPg0K
