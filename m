Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7EC6AFC7F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCHBlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCHBlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:41:42 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBEBA2C14;
        Tue,  7 Mar 2023 17:41:40 -0800 (PST)
X-UUID: 5b8c3b38bd5211eda06fc9ecc4dadd91-20230308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=O8TV+n0E86mIpsHsR/NE+P7Dh5kJI0yOuXwyOmrcTy4=;
        b=GVMGuiYQKD1QS5YyOFPxsV9qhHgN05KbF/iRfPssAFWnPwoRlTw8Xg8ukUgKVFqiE5QRBle7jLZ42SEtdWaZjrqxV7sHHlq19W2Gh4xR6O9vcCi3PDZ4gZpg4JXlM5wbrEdRWFgrKGT9j0bKxSBEFMpQbYO47aaGsffJDvTM/hk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:e4e2e5bc-a1b7-4680-8253-166f230757b4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.20,REQID:e4e2e5bc-a1b7-4680-8253-166f230757b4,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:25b5999,CLOUDID:1e0a88b2-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230307172758IQBBNO8X,BulkQuantity:34,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:1,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:
        0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 5b8c3b38bd5211eda06fc9ecc4dadd91-20230308
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <kyrie.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 371908054; Wed, 08 Mar 2023 09:41:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 8 Mar 2023 09:41:32 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 8 Mar 2023 09:41:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coIOCTxM0FLhe+mt33dx0PBwabIeeMkw1U806ng7ch0eye9EJs0sG65+dGr1rvkmkzH9tha1+b327GhTsTZxGJU/C/VOdneuJvpVlp1XowzoCMS3YGjw0plFF93PLYxJMWMHi6K0v54zam5+HDjVrHa2MLzTrw4/VYL/Vf6uaKIAlm4zH293q+HmTKuFzttmlMaJLTq93GftUOpiaTZ8Az6YCSW7NhIaPRKzuBcCwEJMNP+1cxjca3TopQGz1wmSSsibhbxTErwI6slt/u2PjoOykTbbW4bO3I4LGFOy4yHDw78ttBK2quuFYyua7ycC0qEL49QYG5/7yUGKb1E1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8TV+n0E86mIpsHsR/NE+P7Dh5kJI0yOuXwyOmrcTy4=;
 b=OVG4tBfuq0HRAW94GGQeqan9OgtWtBZyZ8oO6mjLi4GPBn+W9SmPjiVNxALvM/lLbJsgN+spxhhZ2Evh+ghH6E2IykH7N7vo3lRzA6KBwK9dELwmALbe822YG4kG+e9XzcpfvscnraqyMWone7rtdELqC83xg9h3iEPTgCGYJmHIoL4YG9L23og/cOcaW5he6aAR2VInZDlJ1O9pBdgBIVdPXjI4TDtU0AK+juygoQDpeINlXegg6EHO7zhIBw17rbkJA1E4i+TTUzHJSFgvvXcU/alv799uu49CYiC//uFpvqvmzX9JiRDEC/Aw3VPYZona9h4cJwjUwKyRpd6BGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8TV+n0E86mIpsHsR/NE+P7Dh5kJI0yOuXwyOmrcTy4=;
 b=GdDUPjQ8GuFXpKf0Bbp51IdZBSJkJ1xKNZDRp4iaerO8tbGv/ku/0ujtYr5oJJyljE53cv98NOTyUh/qxswF+8BKTF/A2sk9IiPkgqmvUgExS/ors3ezCp0/m1VnufwoxwUv+neR2jtXNT+eSDLixBV/nfqhXcaoNBx/HCrPdaE=
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com (2603:1096:301:b9::5)
 by KL1PR03MB5634.apcprd03.prod.outlook.com (2603:1096:820:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 01:41:30 +0000
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::804e:d33a:c275:6d52]) by PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::804e:d33a:c275:6d52%8]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 01:41:30 +0000
From:   =?utf-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>
To:     =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "hackerzheng666@gmail.com" <hackerzheng666@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "zyytlz.wz@163.com" <zyytlz.wz@163.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>,
        =?utf-8?B?QmluIExpdSAo5YiY5b2sKQ==?= <bin.liu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>
Subject: Re: [RESEND PATCH] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
Thread-Topic: [RESEND PATCH] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
Thread-Index: AQHZUNol+KoTCb2NbEShoW8BcHTMZK7vGQcAgABRWYCAALIggA==
Date:   Wed, 8 Mar 2023 01:41:30 +0000
Message-ID: <cfa2f64d2d01ffc53a6afdc9a5b867bbcb07b5f6.camel@mediatek.com>
References: <20230306062633.200427-1-zyytlz.wz@163.com>
         <CAJedcCzeVwwi9SkkwouFXUAVhF-tKF4dkqsFqVQwszSwY1SJ0A@mail.gmail.com>
         <57c17bfd-83f3-fcce-0eab-e28469fb0ced@collabora.com>
         <11c2bce1e5286ad3a9a5be2ee59c2beac168f135.camel@mediatek.com>
         <CAJedcCx13sz5h=fWvJU38P_1W-zd6yZe=iSMpO28_E_kAqUGDA@mail.gmail.com>
In-Reply-To: <CAJedcCx13sz5h=fWvJU38P_1W-zd6yZe=iSMpO28_E_kAqUGDA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB6186:EE_|KL1PR03MB5634:EE_
x-ms-office365-filtering-correlation-id: 81086d13-0b46-4749-984c-08db1f763d9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6GuEIgr3YSXquOudEozXR1zqHeJsdhNT387jJgU0tLFdOE/XUhOSGP/hPG3GBv1G9M/l75RvZeERp/SrS/tmJZFfmDecdAvtpQNKXUyR6kkdXButRzbfsBUxIJURDstL9rxar0QkrrzNwhhaA1eGIst/+gkdoI6dhBHCinjfwd5LlnDpP+tn5N0u+D0zvZKtlT0RK5h1+XYlNjt1UDjAiCd0e500dDhevsOQ2oAOfc6BvNjhb1iUdv+uVX0h4t47ibb0cL0HYCEkocyPD+pHb1Nw4Y/1nr+zgr39EufDFMqZ3bQYJZZ7QhCVnWTC8/D1BJwTClY/+NqqYhTlNT1TKzBJVHHQ42Iz0lXTX2Iq8dx3BAKTkJiWlG7PkRlMFoBB1Jyvhdn7dkwqfm5Sld9g0N70OaXz+h/cgFQhGj8seul+pwrflsztwmhsci0M59UgGZI7+12CkaAQG1h2kKuxeIjWZ3n8xpCg8vfOTdSNGzR7fWmcyA+tu0crUpCRI0qlzCYZIY5yy5c+ojdjXNjkAy2iT7M06ZyyeKxaceGHm+DNKH9xBJVaTKYK4+9HI/sjY//F0d8FSGx4L5dW9asKBLdbsyEojP7Fn0xURRQTY/GN8bAmP9CPKqbfxNR8epu1O9WCsPSqVGeAtSt7FoDq8prvBvKUfWxZY0JQFUOCj7aVnQJXRRkCwLDhzsnoUp8ndRFrnG9bekK+GTEu6G43f+KQQvkhyb0WVn7Gzk3hJzPv8gDPTLGTMQOMrjUxY5QE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6186.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199018)(85182001)(36756003)(76116006)(66946007)(41300700001)(4326008)(66556008)(8676002)(2906002)(64756008)(66476007)(5660300002)(66446008)(7416002)(38070700005)(86362001)(122000001)(38100700002)(8936002)(6486002)(54906003)(71200400001)(316002)(478600001)(6506007)(110136005)(91956017)(6512007)(26005)(83380400001)(2616005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmErMG9VakZlZUdXYmVEMFdqTHp4Z0gyRWhpbFJjOFFlYVJjZWVNcWRNMnVw?=
 =?utf-8?B?dUhNTmY4MkNJZjYvb0Zic2pqcFRYMk5xaWpCY1cxeTNEVTQ4aFJ5ak9pRHlR?=
 =?utf-8?B?OUgrekxXRkE3NlJHanFDaDVZQmxpWjBzYnNEcnJUaWREaGY0SWR4MmYrNTd2?=
 =?utf-8?B?d0V5TUJuSm9Ma3V0bWZlU042aUZhTHJ4QlJrcXRsNUs2c0tJcDA2TGxqZm1x?=
 =?utf-8?B?S0Y5bjRBdGlKVWdPRzA3SENlejBLbHN6c21abWcxaXRIQXdldm8wcThvajR1?=
 =?utf-8?B?SlpscWlDeVlMcmZTekFzMmdFV2JtMUo5TVlhYVRlSEpHd1ZNb2F5VW9paFhC?=
 =?utf-8?B?SXJmZVkrczZXRjFrcjA2RjB6bWZJWVZrclNjUDJ3d1NsOXlsYklFRUJBK3oy?=
 =?utf-8?B?NkluNnJLSVA5cU4rcjh4elFSeFBvcHdmdmM3YWYzN0JoUlQwZ21JeVhCazNJ?=
 =?utf-8?B?WUFqZjZTVWd3N244OTNCeWdraXBidkxvUjFyVHJ4UG5tbGhmRkdRVTRyNWZq?=
 =?utf-8?B?RW90Z0gwZkcxMzhKakdLNVlEcEtMRmFpYkNOR3I2VStWdHdyYTU5TW1OU0Iv?=
 =?utf-8?B?UUUwY3dzZ1htS2VsTnB1TURHaStrOW15Qmw3V0Q2blJUQUFjM2xYU0FTNUor?=
 =?utf-8?B?WllacXprSGswRTJSS0NMbDNMS3lxU2RNU1Rxd1RBdTVjS3IxMjcwaFhQMmc5?=
 =?utf-8?B?SVM5V3FPRElIb1J4ajU1c0VDNWg3bGt1Y1hMa3VSamRyUjBlMzBSS1I0MXNw?=
 =?utf-8?B?aXhFM0hacFNVRnNpcE5hLytRWEtNOVh5dHBnVjUrVFFrVlJxRyt3WWZkNjJV?=
 =?utf-8?B?NnRMUHFJZGRNVFBEbkVWN3hHYTl0VEdlMTdiOGZGeWFlQXFMY2hEOWJ1OVhN?=
 =?utf-8?B?VGt6ZlFjZUZib2dvM0ZVUEtsR204eEFkMFRrMUNuY3IxamZKRWVCTDRkdDZF?=
 =?utf-8?B?ZW5uSHBQbXpMZ2RkU2dIdlFqS3B5VEJTYjRtV1NRZGJNbjJ0WFdSYTlKT0FW?=
 =?utf-8?B?d2gwWk0xRkQwekIzUFlkQTRHckVFWjlGZGpUWmhNS3cxeWc3d3A4OTNnS1Zs?=
 =?utf-8?B?L1dXNjBlajR4Uk51TWs1cTRXbE12VnhyWFBzZmYyMWxqSVVQWFo4Rmwxc1cw?=
 =?utf-8?B?RlFZbGoxbGNFRitrUlMyTDlSVng5SG91ZVRibUh6MnhQV1hKaDJNMlU5S0R3?=
 =?utf-8?B?YnFpRll6Sk1xLzZKYW8rUGlrZk91RmYxMmtnbDAvdlhZYnQ2S2N4WnRQMVda?=
 =?utf-8?B?aTFGSHJzSDdtZjMrblFaTXZKekhwdnNjYThIN3ozaE42MlgvbFlPbngyZVpJ?=
 =?utf-8?B?aHFYUkh4Y2JmOTA3N2tFbnJPVnk2bFpNb3phbVB5bUgvbzVpWGEzZkZxNVcx?=
 =?utf-8?B?Qzc1c2RUQktPR2lPdnlMT0NNWXREOWZQTFlBcVp1K0Q4S3kvLzhHK3NwaGxv?=
 =?utf-8?B?L1hCeit2ZXFTa1ArOUQ1dmx5ZHNOcmZJYk9iMFpkL3kvaUQyZ2syb0djbHBl?=
 =?utf-8?B?bVFPNy9tUEtYNWhWa2ZqTXN5b0lnb1RlekZyN2VQQVgvZk81cUlYclppTU4v?=
 =?utf-8?B?NU1yL2NzSmN5bGQ5WXJxam0wem5tODV5Yk0yQkdPVDZIOXU0QnJwSWROR2pD?=
 =?utf-8?B?NXl4TEtwS3RvbmphYngwWXIxR09RRVBPWW1icndNd2EyUExyNitoMUJUdVRL?=
 =?utf-8?B?ZjlGL1YxcWR6UDN6eTljU0hIaGFqNHNGTTVnb0JCVHlDUG5Ub09XaEJIVlJS?=
 =?utf-8?B?ajVzVndOQjNaNFF2amtXV25NYkJ2MytYczNldTZBbUZsdHZxNGJ2and6cHQ1?=
 =?utf-8?B?UHI4dmkvVys1bDZPRHcvZTJ6UmpkdFJCSHZwZlI4U1lRVlJ1U2dDTjhsVTFx?=
 =?utf-8?B?MG1IV3N3N082Y2FZZ0Y2UlVtQTB6eVp2MlFDaGdTcCtOVmtHY3JQTW5DY2dj?=
 =?utf-8?B?Tk95RmU1OHR2TWNVQ0pVY3hIc256clNIaERlRUNtZ0F2MlFTMnBkZ0dCZWZH?=
 =?utf-8?B?QTlFMzRpTVptT2R3SGgrVCtRT2lGNDdlcHc3dTVSaHd0VmRDV0NnTFk1QXhv?=
 =?utf-8?B?Z0dLNmtzcTJUc1pUNHJsME5aei9scEFnSDdJcE9RZW1SNlFPeUtkR1NOYy8z?=
 =?utf-8?B?cXBlcisvTVFuQlNPOWZuM3BiRFVwRWRHbHhUdEtpaHdMa01BVUMrWmJIUWpD?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <773DE71D44D90B498936501C7C10A78D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6186.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81086d13-0b46-4749-984c-08db1f763d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 01:41:30.3085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYTVzKk5MEizJyzdXhEBmPwG46WBBGPS5ZkNeLwkDNTW9XOfnycO2QbpjizpL6J3tXFdsVMhFW6cNtTDszNyfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAzLTA3IGF0IDIzOjAzICswODAwLCBaaGVuZyBIYWNrZXIgd3JvdGU6DQo+
IFRoZSB0aW1lciBmdW5jdGlvbiB3YXMgc2V0IGluIG10a19qcGVnX3Byb2JlIHdpdGgNCj4gbXRr
X2pwZWdfam9iX3RpbWVvdXRfd29yayBmdW5jdGlvbi4NCj4gQW5kIHRoZSB3b3JrZXIgaXMgc3Rh
cnRlZCBpbiBtdGtfanBlZ19kZWNfZGV2aWNlX3J1bi4NCj4gVGhlcmUgYXJlIHR3byBmdW5jdGlv
bnMgKG10a19qcGVnX2VuY19pcnEgYW5kIG10a19qcGVnX2RlY19pcnEpIHdoaWNoDQo+IG1heSBj
YW5jZWwgdGhlIHdvcmtlci4NCj4gVGhleSBhcmUgdXNlZCBhcyBJUlEgaGFuZGxlciBmdW5jdGlv
biB3aGljaCBpcyBzYXZlZCBhcyBmdW5jdGlvbg0KPiBwb2ludGVyIGluIGEgdmFyaWFibGUuDQo+
IEluIG10a19qcGVnX3Byb2JlLCB0aGV5IGFyZSByZWdpc3RlcmVkIGJ5IGRldm1fcmVxdWVzdF9p
cnE6DQo+IA0KPiByZXQgPSBkZXZtX3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYsDQo+ICAgICAgICAg
ICAgICAgIGpwZWdfaXJxLA0KPiAgICAgICAgICAgICAgICBqcGVnLT52YXJpYW50LT5pcnFfaGFu
ZGxlciwNCj4gICAgICAgICAgICAgICAgMCwNCj4gICAgICAgICAgICAgICAgcGRldi0+bmFtZSwg
anBlZyk7DQo+ICAgICBpZiAocmV0KSB7DQo+ICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgIkZh
aWxlZCB0byByZXF1ZXN0IGpwZWdfaXJxICVkICglZClcbiIsDQo+ICAgICAgICAganBlZ19pcnEs
IHJldCk7DQo+ICAgICAgIHJldHVybiByZXQ7DQo+ICAgICB9DQo+IA0KPiBIb3dldmVyLCBpZiB3
ZSByZW1vdmUgdGhlIG1vZHVsZSB3aXRob3V0IHRyaWdnZXJpbmcgdGhlIGlycSwgdGhlDQo+IHdv
cmtlciB3aWxsIG5ldmVyIGJlIHJlbW92ZWQuDQo+IA0KPiBBcyBmb3IgdGhlIHNjaGVkdWxlLCBt
dGtfanBlZ19kZWNfZGV2aWNlX3J1biBhbmQNCj4gbXRrX2pwZWdfZW5jX2RldmljZV9ydW4gd2ls
bCBzdGFydCB0aGUgd29ya2VyLg0KPiBUaGUgc2NoZWR1bGUgaW52b2tpbmcgaXMgcXVpdGUgY29t
cGxpY2F0ZWQuIEFzIGZhciBhcyBJIGtub3csIHRoZQ0KPiBpbnZva2luZyBjaGFpbiBpcyBhcyBm
b2xsb3dzOg0KPiANCj4gdjRsMl9tMm1faW5pdC0+djRsMl9tMm1fZGV2aWNlX3J1bl93b3JrLT52
NGwyX20ybV90cnlfcnVuDQo+IA0KPiB0aGUgdjRsMl9tMm1fZGV2aWNlX3J1bl93b3JrIGZ1bmN0
aW9uIGlzIGFsc28gYSB3b3JrZXIgd2hpY2ggaXMgc2V0DQo+IGluDQo+IHY0bDJfbTJtX2luaXQg
YW5kIHN0YXJ0ZWQgaW4NCj4gdjRsMl9tMm1fc2NoZWR1bGVfbmV4dF9qb2IuDQo+IA0KPiBCZWZv
cmUgY2FsbGluZyByZW1vdmUgZnVuY3Rpb24sIHRoZSAgbXRrX2pwZWdfcmVsZWFzZSB3YXMgaW52
b2tlZCB0bw0KPiByZWxlYXNlIHRoZSByZWxhdGVkIHJlc291cmNlLg0KPiANCj4gdjRsMl9tMm1f
Y2FuY2VsX2pvYiB3aWxsIGNhbmNlbCB0aGUgam9iIGJ5IGNhbGxpbmcNCj4gbTJtX2Rldi0+bTJt
X29wcy0+am9iX2Fib3J0KG0ybV9jdHgtPnByaXYpLg0KPiANCj4gQnV0IHRoaXMgd2lsbCBvbmx5
IGNhbmNlbCB0aGUgY3VycmVudCBxdWV1ZSBieQ0KPiBsaXN0X2RlbCgmbTJtX2Rldi0+Y3Vycl9j
dHgtPnF1ZXVlKTsNCj4gDQo+IEkgdGhpbmsgdGhpcyBjYW4gbm90IGNhbmNlbCB0aGUgcG9zdGVk
IHRhc2sgbWVudGlvbmVkIGJlZm9yZS4gU28gSQ0KPiB0aGluayBpZiBtdGtfanBlZ19qb2JfdGlt
ZW91dF93b3JrDQo+IA0KPiBpcyB3b3JraW5nIG9uLCBhbmQgdXNpbmcganBlZy0+bTJtX2RldiBh
ZnRlciBmcmVlaW5nIGl0IGluDQo+IG10a19qcGVnX3JlbW92ZSwgaXQgd2lsbCBjYXVzZSBhIFVB
RiBidWcuDQo+IA0KPiBzdGF0aWMgaW50IG10a19qcGVnX3JlbGVhc2Uoc3RydWN0IGZpbGUgKmZp
bGUpDQo+IHsNCj4gICBzdHJ1Y3QgbXRrX2pwZWdfZGV2ICpqcGVnID0gdmlkZW9fZHJ2ZGF0YShm
aWxlKTsNCj4gICBzdHJ1Y3QgbXRrX2pwZWdfY3R4ICpjdHggPSBtdGtfanBlZ19maF90b19jdHgo
ZmlsZS0+cHJpdmF0ZV9kYXRhKTsNCj4gDQo+ICAgbXV0ZXhfbG9jaygmanBlZy0+bG9jayk7DQo+
ICAgdjRsMl9jdHJsX2hhbmRsZXJfZnJlZSgmY3R4LT5jdHJsX2hkbCk7DQo+ICAgWzFdIHY0bDJf
bTJtX2N0eF9yZWxlYXNlKGN0eC0+ZmgubTJtX2N0eCk7DQo+ICAgdjRsMl9maF9kZWwoJmN0eC0+
ZmgpOw0KPiAgIHY0bDJfZmhfZXhpdCgmY3R4LT5maCk7DQo+ICAga2ZyZWUoY3R4KTsNCj4gICBt
dXRleF91bmxvY2soJmpwZWctPmxvY2spOw0KPiAgIHJldHVybiAwOw0KPiB9DQo+IA0KPiB2b2lk
IHY0bDJfbTJtX2N0eF9yZWxlYXNlKHN0cnVjdCB2NGwyX20ybV9jdHggKm0ybV9jdHgpDQo+IHsN
Cj4gICAvKiB3YWl0IHVudGlsIHRoZSBjdXJyZW50IGNvbnRleHQgaXMgZGVxdWV1ZWQgZnJvbSBq
b2JfcXVldWUgKi8NCj4gICBbMl0gdjRsMl9tMm1fY2FuY2VsX2pvYihtMm1fY3R4KTsNCj4gDQo+
ICAgdmIyX3F1ZXVlX3JlbGVhc2UoJm0ybV9jdHgtPmNhcF9xX2N0eC5xKTsNCj4gICB2YjJfcXVl
dWVfcmVsZWFzZSgmbTJtX2N0eC0+b3V0X3FfY3R4LnEpOw0KPiANCj4gICBrZnJlZShtMm1fY3R4
KTsNCj4gfQ0KPiANCj4gTm90ZSB0aGF0IGFsbCBvZiB0aGlzIGlzIHN0YXRpYyBhbmFseXNpcywg
d2hpY2ggbWF5IGJlIGZhbHNlDQo+IHBvc2l0aXZlLg0KPiBGZWVsIGZyZWUgdG8gdGVsbCBtZSBp
ZiB0aGVyZSBpcyBzb21ldGhpbmcgSSd2ZSBtaXNzZWQuDQo+IA0KPiBSZWdhcmQsDQo+IFpoZW5n
DQoNCkRlYXIgWmhlbmcsDQoNCllvdSBzZXQgdXAgYW4gYXBwbGljYXRpb24gc2NlbmFyaW86DQpj
cHUxIGlzIHVzaW5nIHRoZSBtdGstanBlZyBkcml2ZXIgYW5kIHRpbWVvdXQgd29yayBoYXMgYmVl
biBzY2hlZHVsZWQuDQpBdCB0aGUgc2FtZSB0aW1lIGNwdTAgd2FudGVkIHRvIHJlbW92ZSB0aGUg
bXRrLWpwZWcgZHJpdmVyLCB3aGljaA0KY2F1c2VkIHRoZSBVQUYgYnVnLg0KSSB3b25kZXIgaWYg
c3VjaCBhbiBpcnJhdGlvbmFsIGFwcGxpY2F0aW9uIHNjZW5hcmlvIGNvdWxkIGV4aXN0LiBUaGlz
DQpzY2VuYXJpbywgYXMgeW91IGRlc2NyaWJlZCwgbm90IG9ubHkgbGVhZHMgdG8gdGhlIHByb2Js
ZW1zIHlvdQ0KbWVudGlvbmVkLCBidXQgYWxzbyB0byBvdXRwdXQmY2FwdHVyZSBtZW1vcnkgbGVh
a3MgYW5kIHVucmVsZWFzZWQNCnJlc291cmNlcywgc3VjaCBhcyBzcGlubG9jay4NClR5cGljYWxs
eSwgaWYgd2Ugd2FudCB0byByZW1vdmUgdGhlIGRyaXZlciwgd2UgZmlyc3RseSBkbyBzdG9wDQpz
dHJlYW1pbmcsIHdoaWNoIGVuc3VyZXMgdGhhdCB0aGUgd29ya2VyIGhhcyBiZWVuIGNhbmNlbGVk
Lg0KSSBhZ3JlZSB3aXRoIHlvdXIgY2hhbmdlcyBmcm9tIHRoZSBwZXJzcGVjdGl2ZSBvZiBzdHJl
bmd0aGVuaW5nIHRoZQ0Kcm9idXN0bmVzcyBvZiB0aGUgZHJpdmVyIGNvZGUuDQoNClJlZ2FyZHMs
DQpLeXJpZS4NCj4gDQo+IElydWkgV2FuZyAo546L55GeKSA8SXJ1aS5XYW5nQG1lZGlhdGVrLmNv
bT4g5LqOMjAyM+W5tDPmnIg35pel5ZGo5LqMIDE4OjIz5YaZ6YGT77yaDQo+ID4gDQo+ID4gRGVh
ciBBbmdlbG8gYW5kIFpoZW5nLA0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCBhbmQg
Y29tbWVudHMuDQo+ID4gDQo+ID4gRGVhciBLeXJpZSwNCj4gPiANCj4gPiBQbGVhc2UgaGVscCB0
byBjaGVjayB0aGlzLCB0aGFua3MuDQo+ID4gDQo+ID4gQmVzdCBSZWdhcmRzDQo+ID4gDQo+ID4g
T24gVHVlLCAyMDIzLTAzLTA3IGF0IDEwOjQ5ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubw0KPiA+IHdyb3RlOg0KPiA+ID4gSWwgMDcvMDMvMjMgMTA6MjcsIFpoZW5nIEhhY2tlciBo
YSBzY3JpdHRvOg0KPiA+ID4gPiBIaSwNCj4gPiA+ID4gDQo+ID4gPiA+IElzIHRoZXJlIGFueW9u
ZSB3aG8gY2FuIGhlbHAgd2l0aCB0aGlzPyBJIGNhbiBwcm92aWRlIG1vcmUNCj4gPiA+ID4gZGV0
YWlscw0KPiA+ID4gPiBsaWtlIGludm9raW5nIGNoYWluIGlmIG5lZWRlZC4NCj4gPiA+ID4gDQo+
ID4gPiANCj4gPiA+IFByb3ZpZGluZyBtb3JlIGRldGFpbHMgaXMgYWx3YXlzIGdvb2QuIFBsZWFz
ZSBkby4NCj4gPiA+IA0KPiA+ID4gTWVhbndoaWxlLCBhZGRpbmcgSXJ1aSBXYW5nIHRvIHRoZSBs
b29wOiBoZSdzIGRvaW5nIG10ay1qcGVnLg0KPiA+ID4gDQo+ID4gPiBSZWdhcmRzLA0KPiA+ID4g
QW5nZWxvDQo+ID4gPiANCj4gPiA+ID4gVGhhbmtzLA0KPiA+ID4gPiBaaGVuZw0KPiA+ID4gPiAN
Cj4gPiA+ID4gWmhlbmcgV2FuZyA8enl5dGx6Lnd6QDE2My5jb20+IOS6jjIwMjPlubQz5pyINuaX
peWRqOS4gCAxNDoyOOWGmemBk++8mg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEluIG10a19qcGVn
X3Byb2JlLCAmanBlZy0+am9iX3RpbWVvdXRfd29yayBpcyBib3VuZCB3aXRoDQo+ID4gPiA+ID4g
bXRrX2pwZWdfam9iX3RpbWVvdXRfd29yay4gVGhlbiBtdGtfanBlZ19kZWNfZGV2aWNlX3J1bg0K
PiA+ID4gPiA+IGFuZCBtdGtfanBlZ19lbmNfZGV2aWNlX3J1biBtYXkgYmUgY2FsbGVkIHRvIHN0
YXJ0IHRoZQ0KPiA+ID4gPiA+IHdvcmsuDQo+ID4gPiA+ID4gSWYgd2UgcmVtb3ZlIHRoZSBtb2R1
bGUgd2hpY2ggd2lsbCBjYWxsIG10a19qcGVnX3JlbW92ZQ0KPiA+ID4gPiA+IHRvIG1ha2UgY2xl
YW51cCwgdGhlcmUgbWF5IGJlIGEgdW5maW5pc2hlZCB3b3JrLiBUaGUNCj4gPiA+ID4gPiBwb3Nz
aWJsZSBzZXF1ZW5jZSBpcyBhcyBmb2xsb3dzLCB3aGljaCB3aWxsIGNhdXNlIGENCj4gPiA+ID4g
PiB0eXBpY2FsIFVBRiBidWcuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gRml4IGl0IGJ5IGNhbmNl
bGluZyB0aGUgd29yayBiZWZvcmUgY2xlYW51cCBpbiB0aGUNCj4gPiA+ID4gPiBtdGtfanBlZ19y
ZW1vdmUNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBDUFUwICAgICAgICAgICAgICAgICAgQ1BVMQ0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgIHxtdGtfanBlZ19qb2Jf
dGltZW91dF93b3JrDQo+ID4gPiA+ID4gbXRrX2pwZWdfcmVtb3ZlICAgICB8DQo+ID4gPiA+ID4g
ICAgdjRsMl9tMm1fcmVsZWFzZSAgfA0KPiA+ID4gPiA+ICAgICAga2ZyZWUobTJtX2Rldik7IHwN
Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgfCB2NGwyX20ybV9nZXRfY3Vycl9wcml2DQo+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgfCAgIG0ybV9kZXYtPmN1cnJfY3R4IC8vdXNlDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogWmhlbmcgV2FuZyA8enl5dGx6Lnd6QDE2My5jb20+DQo+ID4gPiA+
ID4gLS0tDQo+ID4gPiA+ID4gICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL2pwZWcv
bXRrX2pwZWdfY29yZS5jIHwgMiArLQ0KPiA+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdp
dA0KPiA+ID4gPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9qcGVnL210a19q
cGVnX2NvcmUuYw0KPiA+ID4gPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9q
cGVnL210a19qcGVnX2NvcmUuYw0KPiA+ID4gPiA+IGluZGV4IDk2OTUxNmE5NDBiYS4uMzY0NTEz
ZTc4OTdlIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVk
aWF0ZWsvanBlZy9tdGtfanBlZ19jb3JlLmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL21lZGlhdGVrL2pwZWcvbXRrX2pwZWdfY29yZS5jDQo+ID4gPiA+ID4gQEAgLTE3
OTMsNyArMTc5Myw3IEBAIHN0YXRpYyBpbnQgbXRrX2pwZWdfcHJvYmUoc3RydWN0DQo+ID4gPiA+
ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gPiA+ICAgc3RhdGljIGludCBtdGtfanBl
Z19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+ID4gPiAgIHsNCj4g
PiA+ID4gPiAgICAgICAgICBzdHJ1Y3QgbXRrX2pwZWdfZGV2ICpqcGVnID0NCj4gPiA+ID4gPiBw
bGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gPiA+ID4gPiAtDQo+ID4gPiA+ID4gKyAgICAg
ICBjYW5jZWxfZGVsYXllZF93b3JrKCZqcGVnLT5qb2JfdGltZW91dF93b3JrKTsNCj4gPiA+ID4g
PiAgICAgICAgICBwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQo+ID4gPiA+ID4gICAg
ICAgICAgdmlkZW9fdW5yZWdpc3Rlcl9kZXZpY2UoanBlZy0+dmRldik7DQo+ID4gPiA+ID4gICAg
ICAgICAgdjRsMl9tMm1fcmVsZWFzZShqcGVnLT5tMm1fZGV2KTsNCj4gPiA+ID4gPiAtLQ0KPiA+
ID4gPiA+IDIuMjUuMQ0KPiA+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IA0K
