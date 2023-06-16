Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E4A733355
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345427AbjFPOSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345416AbjFPOR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:17:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48AE30F4;
        Fri, 16 Jun 2023 07:17:51 -0700 (PDT)
X-UUID: 909658020c5011eeb20a276fd37b9834-20230616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vWEK/lbC6CIj0dHE7ta715/ZRV7EOAV+MWjGGZz4Ilg=;
        b=sCmxvHLjtXGOrCfbJoqtmRHapo0F53VUoJvjyzwVt8jRz4XS1qHRQrA3tgxdrfZ+4HGvl17bhkfVQxBsiBHm0kIJDP/wa458Fc6MEezV3FDejiVgU1eG8H8RGC1PJCqF8UjPuFFLoPmL3hnGJSpM+qqUU+Eok5W9sIWxeeABvxo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:b6854300-fdcc-41ef-ae0e-8f6a2e47e510,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:3dcfdb3e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 909658020c5011eeb20a276fd37b9834-20230616
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1351612000; Fri, 16 Jun 2023 22:17:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 22:17:44 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Jun 2023 22:17:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRCL/ezOvmgsM2Kb9NbpolagFrjcN68VF5J0gNPSjOA6Sxb8zZac1q5x72H8Tg/MuCbOD7bdOtygCEMHyNRpXieuyjUIq03wS27p+DxEBwiMvoxexuBQUnZ26g95G+GHwHMY5Ip6ylz0vpZViephOKjm+juQfTKR5ARkcUlvKxLXSCQVsSXGEcArDKsgTtMuepgYBO+ofj+rjx3Iv0S6SmfIuj+9xyYTghInOm2iQt8eOzmkg7evQYkJ+MZuXKPB4JKQDthI+Wbj0Oqf1Bk1OsLfNVRWU2NFvQqcNP42swkDza/BC8h1riLxU8fJ5S81Rj0QO3brJskGWYQ+18MHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWEK/lbC6CIj0dHE7ta715/ZRV7EOAV+MWjGGZz4Ilg=;
 b=dmkEp5MQYiWegTDGlbmLk/hFKl73pVU3pbrsCgC/69wEy8t6b4AO5zic3LLpIAQ8DOZmgMRMLvjlnfar+1N0cONd6IycpFh/JZuWKEr2aNIsyKdAnoSUqTm3vMxnMUGpZ+cvvE+gSVmkm3hUS4jwwMbBWaLX5rn1stzk56WF7xfOv//cRUMKmrEAeOFwrWZmb1Kbl6wADvu+4Irkj6+ENc3shUu/en3BcBwcEBc/hu06PH6Zd8u5ZYmR5rqNnnaadgOcy2GWOZIlWsrwBML/jZmAU/HgH6KG8moy/8yVVdJ/MN0Ibg89rtoTZKAGBknUU6+lv80q/7cmRHHw+JdQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWEK/lbC6CIj0dHE7ta715/ZRV7EOAV+MWjGGZz4Ilg=;
 b=eBdSyZztglJLtXe+Kqd676ybQnXzeuJBnrN0XDU9wqVacv7xQSdS5Cb4D99YbGj3IpNXnvNEhuP4+myR3fNSsEsTtNd3fBYiNSQ7myB2Pn08EdzaVc5LLr17E76gIcHelv+BCnmQqeW0VCxPCsxrlnQ+pKkfS/N+4t7P4iTlwMw=
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com (2603:1096:4:14e::9) by
 SG2PR03MB6455.apcprd03.prod.outlook.com (2603:1096:4:1c3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.29; Fri, 16 Jun 2023 14:17:42 +0000
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::284f:6d81:d91a:5b7]) by SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::284f:6d81:d91a:5b7%6]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 14:17:42 +0000
From:   =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
To:     "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>, "Sean Wang" <Sean.Wang@mediatek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: mt76: mt7921e: Perform FLR to recovery the device
Thread-Topic: [PATCH] wifi: mt76: mt7921e: Perform FLR to recovery the device
Thread-Index: AQHZnoo6X7xp66YYEkK0Hf6gQJ79Da+KJuYAgANWowA=
Date:   Fri, 16 Jun 2023 14:17:41 +0000
Message-ID: <10d7045eca2bdf40d7a69df7c2d7eafad2584d05.camel@mediatek.com>
References: <20230614063252.1650824-1-kai.heng.feng@canonical.com>
         <d9e3009b-1fd0-e81b-715e-d93c9343b55c@collabora.com>
In-Reply-To: <d9e3009b-1fd0-e81b-715e-d93c9343b55c@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6194:EE_|SG2PR03MB6455:EE_
x-ms-office365-filtering-correlation-id: d2c9ea8f-29c6-4809-db63-08db6e747257
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cgtfFiZPyV86QOOtRKKE/cLsnH4jRmNHIYhjVZ1S95aFr+BreTG/V7Ikgm6GzbRkBVE9Lvy2Jl2vH7UJ28LREiNqx3/BdXv0niRdZ94oBWDszKSAXv1lZ/gWFqvgJm/oYx/Dw9VpP+3ttrG6Ud7vtijX3r3Hdcs2miWy2p/t/4RnZRVrNVRNkDM5MovTgEv7Tgg1ZvRVyb+H3LtvFppRFgCGi2/Vr6zHavVXHej3raauDO74eu/NmmJLCFJ6FwOq9pR/PmfcnRcQ004usCeE6Oy7X2sBHellTb9MCvYHQJF8Jlu1iAVswGLBtRAFcVcnE1dNKL9j+XwJLwkKgNK3ocjHXd4qaKi47YdZ8Md56Hbpw5bBIOA406FkF+zuyrtY5TzjWnJtuFgMPUuGGv24dwdd7XuXKQOGXZ/o/VjEqSVNwtS5oZOgkfiuLgCLU3x9uiWyEfshrI3UtsqYYbcXb6zcFEjEgRsKNVL/jq879L/PW8IgpWAMAMTIrVV5wFKuYcuMIbPT5CoZUeMDyUYvrUldb64lgWhWZHcfTulVrViOl3X8+A+d8qp1zDJwao7RJ7fJ7RE9r5EjRAuV9ceSv25krqHEJDNgccB/lbbLkbKwytKwOUJgaovESgRkrWW85B4Dup5YXUAokPvCrxPjjTtmqZEr2QPs6r5jiW4ZAIQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6194.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(8936002)(8676002)(122000001)(5660300002)(86362001)(83380400001)(38100700002)(7416002)(316002)(38070700005)(41300700001)(64756008)(66946007)(66556008)(66476007)(66446008)(6636002)(91956017)(76116006)(4326008)(110136005)(2616005)(54906003)(186003)(85182001)(478600001)(6506007)(6512007)(36756003)(26005)(71200400001)(2906002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXc0WFhRbmw3aXMya1hyYVZyT0lqZ3B2N0VneEUrdW1Vbkdwci84ZTFubHVa?=
 =?utf-8?B?U0c0ZVAvYllBclZVQVN4RnkxSzF1bjBXOUt2eEdYTy9HSDY0S2dXWGpCZlZq?=
 =?utf-8?B?d2U1RWFYbmxWSnR6ZnA4M3JrV2prREo1RzJTTXE2YXNYVXNYNFp2dVpzR3kz?=
 =?utf-8?B?VkRJSGp2OEtPTWs2WnJ3KzBMdnZJWWRQYzF3ajlpZjd1WklSelExaXBYMU9o?=
 =?utf-8?B?R09YK2QxYkRRZDk5a0owcmV6K1Azem9yMmVLS0V2QytIVllVRFo1cndIakh4?=
 =?utf-8?B?RDZSa0g1cys2c1ZFYlFBeE1TOFF0b3NHRzdaNm1pTDVrY3pnaEN0RVUrRXNP?=
 =?utf-8?B?dWMvS3pUSjAzYmhubTBWQzIwSlRDRFJpcWpjSm9FeW9xVXQwNkVMZ0lOQmNV?=
 =?utf-8?B?TzlnVTRZSWwwTnNWdzVkSHA3bWxrcWpsZzR2cFJXaE15dVhIQmRtZnZXTmxP?=
 =?utf-8?B?UzhsdUU5amhOS3hzaHRIam9NQXZ1RHZFN0xSbEtLUEsvY0I0cnpGd1gvdDVT?=
 =?utf-8?B?V3pEKzZMWGlYZ2xrUGVwd2lhb2YwWXhkQmgxMGJZYWY0d01uUTFsNU15cWs0?=
 =?utf-8?B?aFU0M3F4N2J0c00wNEQ1TVFxUHNPTDRsUkRVMWcxb2NtYlpZc1lJQ1czcjVo?=
 =?utf-8?B?U1RoTUNuSjk0VXJ5aW9RN2RScVovVUMrdTB0bWhwWFdPUFlOZlBlUG9kbnVI?=
 =?utf-8?B?OFVPSzJGWDNoSUxKYXJ4ZVBKOUc3eUtCZWJUenREcUpaMmpLZVhBL2VYQ3gv?=
 =?utf-8?B?RWIvcFZBZ1ZsQmxzMGxRWWYwcEpxdFA4R1drVnluRDc5MGNndSt0USt1WGty?=
 =?utf-8?B?dlZiSmljWFErU3VsN2JlQmg2VjNzMVdpTElDZ1d4MjhUYk1uaE40Tyt5ME15?=
 =?utf-8?B?TE92QWNYOVpZWUtNL0p2Q2xocGJ0bXZXQU8wbUxjTiswNERUV3Z3V1IyUFZo?=
 =?utf-8?B?K0FqRGJuYTRxWWlnekY3TytOdDZEWVA4ZEd5K000NzNlL1NqeUVRNkZMV1Zt?=
 =?utf-8?B?bEhVWlM0MWhYYmRLOVlmdUU3UDlyRkhmL0RONWpqQTBTQzllWjNmUVRBTjhO?=
 =?utf-8?B?SmJ2Qk5keE5tSkZ6dzFHTWhJcU9MSVVxQklhQ0RRY3NWMTh2cmIrZ1F3K3Uz?=
 =?utf-8?B?L0VvVHU1QUNoTUMzaFdjWisyangvM2wxSTE2TUJzd1p0WmNKRDJiaEJ6YTBr?=
 =?utf-8?B?ZE5WVnVhTmZDOTJveHVuZDR1MWJFOFByVEFZRXgvbUJtT0dkbkFZTkk3UENQ?=
 =?utf-8?B?T1g4RVN2N2UxdUVVZ0ZRYXlxYlB5TXZsUCtMdktuSS9hUDF3S0ZUK2ordWhq?=
 =?utf-8?B?TExmQi9kWEM5c0Q5OFc4SWN0VlNVMHRhc1BiWFhvMzdqRnU3ODVyQXd5Rnpp?=
 =?utf-8?B?Y25MSVhmSEx0dEpiZlZaSk5qWGgvWmUxeldMTDZ6OEYwbDlxTFI5VllvUWdT?=
 =?utf-8?B?UlI2cU82ZVMwMFZjN3V1ZXEzVFB2bDF5bThaekQ5Z3NzSHdGYmN2cmZkMWlU?=
 =?utf-8?B?QngzWFFMNlBmZ1RmTlI1ZkE5N0N0dkhjNnF1STRvRWczdVdiMnZiMGVIWVo3?=
 =?utf-8?B?T2RDa21mT1BWYUZOYUdyUHlsTlR0RFl5WHpvZ2xBZW5QaXVqVTNkQzR5V2FV?=
 =?utf-8?B?d2p2a01SV0xvTFN4Q0hyNjN3YlNLaTFVVGFBQ0dkTWVXRWpmMnA3eXQ0Vkxl?=
 =?utf-8?B?WTRvc3h5Rm03c2ZON1QvcEJCanZvWkdicnk2dVVxYVBUVVl5d0wybkRpM25m?=
 =?utf-8?B?Ymw3UE9KTW5GdmdhN05KTXQrTkw2YXBISUppNXZXUmUvRnVzanZ2Q3h0Wnpp?=
 =?utf-8?B?Z01reng4bFFDS2xjWTdYNjdOenZDSlpva0pLNWx0Z3hnbjBkeC80S3BoMmxU?=
 =?utf-8?B?bWs3bHA4R1l5RFQvUmt0UTNtQk94d3JRWWFsT0dvMHg0TWZ0UVl3RDVPS2hW?=
 =?utf-8?B?YU44cHJ5WEhDdXV4cmFkUmhrekZyRW53aHFKazB0NVI1c1B6QS9SRk1zMFlp?=
 =?utf-8?B?ZGkvM0VOY3gyelFaQzEycFN4Y0Fsb2Y2WDJLbTJOM3g0c2JvUzdKdEc4b0Nt?=
 =?utf-8?B?UkJORU04aTNrblpQdGZMa0JtMDl2L3h3NkozOUNVMjk0NUVENzc4dWFselI0?=
 =?utf-8?B?Z2ZPdjhhRkJnUHRBMzNiWmdxSFY4T0syTnlBVE83K3ZlMGxWd1hXbTNuZFVm?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0B0BBC54A18C44ABAD94E59C4094F0A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6194.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c9ea8f-29c6-4809-db63-08db6e747257
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 14:17:41.6168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2VXlYomLSiry7NoOAyV6junHPV9l2OWnDOZ+DdzhRxma1utpdyhbMspq19ywWP+Z5hj8EAUN2+R8xvZdcFzKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6455
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDEzOjE4ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbCAxNC8wNi8yMyAwODozMiwgS2FpLUhlbmcg
RmVuZyBoYSBzY3JpdHRvOg0KPiA+IFdoZW4gIlByZS1ib290IFdpRmkiIGlzIGVuYWJsZWQgaW4g
QklPUywgdGhlIG10NzkyMWUgZGV2aWNlIG1heSBub3QNCj4gPiB3b3JrOg0KPiA+IG10NzkyMWUg
MDAwMDowMjowMC4wOiBBU0lDIHJldmlzaW9uOiA3OTIyMDAxMA0KPiA+IG10NzkyMWUgMDAwMDow
MjowMC4wOiBNZXNzYWdlIDAwMDAwMDEwIChzZXEgMSkgdGltZW91dA0KPiA+IG10NzkyMWUgMDAw
MDowMjowMC4wOiBGYWlsZWQgdG8gZ2V0IHBhdGNoIHNlbWFwaG9yZQ0KPiA+IG10NzkyMWUgMDAw
MDowMjowMC4wOiBNZXNzYWdlIDAwMDAwMDEwIChzZXEgMikgdGltZW91dA0KPiA+IG10NzkyMWUg
MDAwMDowMjowMC4wOiBGYWlsZWQgdG8gZ2V0IHBhdGNoIHNlbWFwaG9yZQ0KPiA+IG10NzkyMWUg
MDAwMDowMjowMC4wOiBNZXNzYWdlIDAwMDAwMDEwIChzZXEgMykgdGltZW91dA0KPiA+IG10Nzky
MWUgMDAwMDowMjowMC4wOiBGYWlsZWQgdG8gZ2V0IHBhdGNoIHNlbWFwaG9yZQ0KPiA+IG10Nzky
MWUgMDAwMDowMjowMC4wOiBNZXNzYWdlIDAwMDAwMDEwIChzZXEgNCkgdGltZW91dA0KPiA+IG10
NzkyMWUgMDAwMDowMjowMC4wOiBGYWlsZWQgdG8gZ2V0IHBhdGNoIHNlbWFwaG9yZQ0KPiA+IG10
NzkyMWUgMDAwMDowMjowMC4wOiBNZXNzYWdlIDAwMDAwMDEwIChzZXEgNSkgdGltZW91dA0KPiA+
IG10NzkyMWUgMDAwMDowMjowMC4wOiBGYWlsZWQgdG8gZ2V0IHBhdGNoIHNlbWFwaG9yZQ0KPiA+
IG10NzkyMWUgMDAwMDowMjowMC4wOiBNZXNzYWdlIDAwMDAwMDEwIChzZXEgNikgdGltZW91dA0K
PiA+IG10NzkyMWUgMDAwMDowMjowMC4wOiBGYWlsZWQgdG8gZ2V0IHBhdGNoIHNlbWFwaG9yZQ0K
PiA+IG10NzkyMWUgMDAwMDowMjowMC4wOiBNZXNzYWdlIDAwMDAwMDEwIChzZXEgNykgdGltZW91
dA0KPiA+IG10NzkyMWUgMDAwMDowMjowMC4wOiBGYWlsZWQgdG8gZ2V0IHBhdGNoIHNlbWFwaG9y
ZQ0KPiA+IG10NzkyMWUgMDAwMDowMjowMC4wOiBNZXNzYWdlIDAwMDAwMDEwIChzZXEgOCkgdGlt
ZW91dA0KPiA+IG10NzkyMWUgMDAwMDowMjowMC4wOiBGYWlsZWQgdG8gZ2V0IHBhdGNoIHNlbWFw
aG9yZQ0KPiA+IG10NzkyMWUgMDAwMDowMjowMC4wOiBNZXNzYWdlIDAwMDAwMDEwIChzZXEgOSkg
dGltZW91dA0KPiA+IG10NzkyMWUgMDAwMDowMjowMC4wOiBGYWlsZWQgdG8gZ2V0IHBhdGNoIHNl
bWFwaG9yZQ0KPiA+IG10NzkyMWUgMDAwMDowMjowMC4wOiBNZXNzYWdlIDAwMDAwMDEwIChzZXEg
MTApIHRpbWVvdXQNCj4gPiBtdDc5MjFlIDAwMDA6MDI6MDAuMDogRmFpbGVkIHRvIGdldCBwYXRj
aCBzZW1hcGhvcmUNCj4gPiBtdDc5MjFlIDAwMDA6MDI6MDAuMDogaGFyZHdhcmUgaW5pdCBmYWls
ZWQNCj4gPiANCj4gPiBBZnRlciBzb21lIHRyaWFscyBhbmQgZXJyb3JzLCBpdCBzaG93cyB0aGF0
IFBDSSBmdW5jdGlvbiBsZXZlbA0KPiByZXNldCBjYW4NCj4gPiByZWNvdmVyIHRoZSBkZXZpY2Ug
YmFjayB0byBhIGZ1bmN0aW9uYWwgc3RhdGUuDQo+ID4gDQo+ID4gU28gcGVyZm9ybSBGTFIgYXQg
cHJvYmUgcm91dGluZSB0byB3b3JrYXJvdW5kIHRoZSBpc3N1ZS4NCj4gDQo+IElzIHRoZXJlIGFu
eSB3YXkgdG8gY2hlY2sgaWYgdGhlIGRldmljZSB3YXMgZW5hYmxlZCBiZWZvcmUgYm9vdGluZw0K
PiBMaW51eD8NCj4gDQo+IEknbSB0aGlua2luZyBvZiBzb21ldGhpbmcgbGlrZQ0KPiANCj4gaWYg
KGRldmljZV9pc19hbHJlYWR5X2VuYWJsZWQpDQo+IHJldCA9IHBjaV9yZXNldF9mdW5jdGlvbl9s
b2NrZWQoLi4uLikNCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KDQpIaSBLYWktSGVuZywNCg0K
VGhhbmtzIGZvciB0aGUgcGF0Y2guIEJ1dCB3ZSBmb3VuZCB0aGVyZSBhcmUgc29tZSBwcm9ibGVt
cyBvbiBkaWZmZXJlbnQNCnBsYXRmb3JtLiBXZSB3aWxsIHByb3ZpZGUgYW5vdGhlciBzb2x1dGlv
biBmb3IgdGhpcyBjYXNlLg0KDQoNCkhpIEFuZ2VsbywNCg0KQmVjYXVzZSB0aGUgcHJvYmxlbSBp
cyBjYXVzZWQgYnkgbXQ3OTEyZSBlbmFibGVkIGFuZCBzb21lIHN0YXR1cyB3YXMNCmNoYW5nZWQg
dG8gYW4gdW5wcmVkaXRhYmxlIHZhbHVlIGR1cmdpbiBib290IHByb2Nlc3MsIHdlIG1heSBoYXZl
IHRvDQpmb3JjZSByZXNldCBkZXZpY2VzIGluIHByb2JlKCkuIFdlIHN0aWxsIHRyeSB0byBmaW5k
IG91dCBhIGdvb2Qgd2F5IHRvDQpkbyBpdCBhbmQgd2lsbCBwb3N0IHRoZSBwYXRjaCBvbmNlIHRo
ZSB2ZXJpZmljYXRpb24gaXMgZG9uZS4NCg0KDQpSZWdhcmRzLA0KRGVyZW4NCg0KPiANCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBLYWktSGVuZyBGZW5nIDxrYWkuaGVuZy5mZW5nQGNhbm9uaWNh
bC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzkyMS9wY2kuYyB8IDQgKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L210NzkyMS9wY2kuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTIxL3BjaS5jDQo+ID4gaW5kZXggZGRiMWZhNGVlMDFkLi45NjcxZmJlMzVhOGUgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEv
cGNpLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzky
MS9wY2kuYw0KPiA+IEBAIC0yNjIsNiArMjYyLDEwIEBAIHN0YXRpYyBpbnQgbXQ3OTIxX3BjaV9w
cm9iZShzdHJ1Y3QgcGNpX2Rldg0KPiAqcGRldiwNCj4gPiAgIGludCByZXQ7DQo+ID4gICB1MTYg
Y21kOw0KPiA+ICAgDQo+ID4gK3JldCA9IHBjaV9yZXNldF9mdW5jdGlvbl9sb2NrZWQocGRldik7
DQo+ID4gK2lmIChyZXQpDQo+ID4gK3BjaV9pbmZvKHBkZXYsICJVbmFibGUgdG8gcGVyZm9ybSBG
TFJcbiIpOw0KPiA+ICsNCj4gPiAgIHJldCA9IHBjaW1fZW5hYmxlX2RldmljZShwZGV2KTsNCj4g
PiAgIGlmIChyZXQpDQo+ID4gICByZXR1cm4gcmV0Ow0KPiANCj4gDQo=
