Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC37D7172E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjEaBO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjEaBOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:14:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05723C9;
        Tue, 30 May 2023 18:14:42 -0700 (PDT)
X-UUID: 82aece16ff5011edb20a276fd37b9834-20230531
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=yzPAvBgeytGBZZ2t6lqvtj6izd7/tWdBOt6O5AJd7tE=;
        b=HZ+mT19fSgeyUh8ub50pDpTdLHpe/GHKgv7Q25KSmku5hfYNLJOlXRb5H6LxbiOY05/dmSFXs6plfhcWjfq/8hrkSlQPGwegrs2v7gG6QI/FjGT4Tqts8nCLEmpR/ger1eoRA+yeSK9hkPMmTW7yYp/3hViz19fAkvh1qKvP6bM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:717098d3-b6c6-4228-8d85-47ec6f542d78,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.25,REQID:717098d3-b6c6-4228-8d85-47ec6f542d78,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:d5b0ae3,CLOUDID:9ebb0d3d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230530104955TACCHNKG,BulkQuantity:22,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 82aece16ff5011edb20a276fd37b9834-20230531
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 975524583; Wed, 31 May 2023 09:14:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 31 May 2023 09:14:36 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 31 May 2023 09:14:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIGwhE8isdERER/NSd/E6XKeclTw2qI1LETLBQ+OgZbkK7IvjAsUBTOpvWGWTHEJjA/uUUAJ6QiT+/hTPfHtQOV6tfXCps416rpqs6o1rSDFQIZt4OpbSXY/5rtcQZIE+syE4Wku/iZ+CYNmykGLR4xufE/CBVpncnQSsD8JdNwpGowrGqFCbD7GOwmtVxXIt1H4RiMfZtRW5zfRum5TgIKzp2Ci5nxm1CHwvmRkk40w7EBGQrXjPdt5UsI8lLEJEPaeQyp1o1AZ1kMxyhMe+L0acNYg+iGWtgX1J8OFUe2kuqlq1yy8wVqbbL/X0oIwZ5XPWHE8KGwDQesI+cEa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzPAvBgeytGBZZ2t6lqvtj6izd7/tWdBOt6O5AJd7tE=;
 b=adUj8/IIWp+bIMYKP299ovjJ+EaTx83QjoqZRLHscbISOLwp9iruW3RAXeuEci0O5UGtI96vd9KE9VWJLjBQMuGXl1MzkargfgCqlBT2NK52KtJZJ0BLHzny1+toSDkcuWoy8PndltePbwx7dqzcZWQ2yQJLpBaBXINVoA2iVg+EptzIeyZ8rG5czJ7C57gboFuL4bstfTO8BJpN11+sG6enDMoPGkUThTwI51vc+WrlqO2l1OwoMdajKh7ATvU91z4zRNI5bC7P7RYbokBbSEVWULHJsl2KmsXEA9IL4UJU61rENwgDxJW6CnVfnQq9X7NokK3btUVIZ1WAYitxPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzPAvBgeytGBZZ2t6lqvtj6izd7/tWdBOt6O5AJd7tE=;
 b=VXLMB/LXDGKAP25Y5NYAGuE5ipAdIdmLCK0AGeW0ftVwORYwWNo8z1zjPr0NZA8yi+h6ALVn0WX1VBDE3UjM83BrxOksYVSNS4nP5B673glbBMLUiQ12OOk0uy5p8JNidLWEEqVfW1h6zQRb+8tj5yB3R4sBjTHGuZ1tgTycfSM=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 TYZPR03MB6472.apcprd03.prod.outlook.com (2603:1096:400:1c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Wed, 31 May
 2023 01:14:34 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d274:3164:e829:3131]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d274:3164:e829:3131%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 01:14:33 +0000
From:   =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>
CC:     =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        =?utf-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 1/1] nvme: complete directly for hctx with only one ctx
 mapping
Thread-Topic: [PATCH v1 1/1] nvme: complete directly for hctx with only one
 ctx mapping
Thread-Index: AQHZkqA7C2fPkjryy0KrxZht1ncDgq9zF+OAgAB9YIA=
Date:   Wed, 31 May 2023 01:14:33 +0000
Message-ID: <67c4bc7b462565bb33ff97736e0d24bb432831c5.camel@mediatek.com>
References: <20230530024120.17196-1-powen.kao@mediatek.com>
         <ZHY2TUrKVBj2xGE2@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZHY2TUrKVBj2xGE2@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|TYZPR03MB6472:EE_
x-ms-office365-filtering-correlation-id: 288f2b34-fae1-4682-381e-08db617464d1
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0N5rkrx7cAFA2sGv2us1ktOC7Si34IuEY0oXEfTJygIWzEL/U+7SRwS5dxjLmYrNCHjB2GTtaZoBV75ubGbvDVJAaJwB26MQmghZtK/UWL9XJgwBt0ynBWAmePUp6f0u6G1qMWqTdfrWLh46JyOJlmUMAhE+ZutEqapaRROZa/fgteI/8k96ledx3YZzMn7SuS829/FEFJiP0pMKRm1HH7yGrG47EO0+NXPFzAuCC2koIEDOz110itHdZKVBOFFmp1HgGtGKXWpGjz7zM4u/c5BD8hSSIN7Vl84DIY3Rdhq0pBw4B6Am3lFiFqMZqfFQzLCe9b1JPLf8oL1VQxgSPdgEW6DS2VBxRe7X6m/ZeVGuRB+vNrMnAVn83l3q6mYCAD8bqdolnuhqUTFHycOt8PB1hrJMnC1U6hN8nyFPm+BQ9MsoyZz7RGaj+wArosBq2y3qrZ5vmK5b+4wQ3rZaDjtnnEKuoTrhayC7W5dy1nQ8LSDo3I80jWPmNfNexudUTcPGcBReoBcgURYexLB9b/jtsPhOBXdPObFr5z9q8p+JU/DjrXyE/qNI1OxVcq9nA+69I6xbIDF4n2pghLrZ+pvVw07hWo3J94t6OjIU7L+CD39filaiJcGB7ENDrg6MvxNPFaRFq7UBC1EvFZhwVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(64756008)(4326008)(66556008)(66946007)(2906002)(66446008)(66476007)(5660300002)(7416002)(6636002)(41300700001)(316002)(91956017)(110136005)(54906003)(8936002)(76116006)(8676002)(478600001)(71200400001)(966005)(186003)(26005)(2616005)(36756003)(6486002)(85182001)(83380400001)(6506007)(38070700005)(86362001)(6512007)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmxEUWRDTnYzK20vcmpQWGlRczBQQTNQNmNSdjRJNjVDZjc3VHorZXoyalR1?=
 =?utf-8?B?V2kycGgvNExhSUczMXp5bkt2dUMvRS9OK09NM2kxcmJFQjFFczNPNUVrNENq?=
 =?utf-8?B?YzJaTG43dm1hTnJDT2VHUlc3WWhWVXljS1lHcFlCRjlZNlBqSmpBd25oNmZR?=
 =?utf-8?B?OENDWDkwZ0tYOUxpdUMzQTJxQVM0Q0JpZUErWHA1WS9zeVFha0pUZUc0a2Yy?=
 =?utf-8?B?NUY4bXZ3Rmc2aW1hakZOMlcrdmQ3ZnAzOWhmQVE4T2lhWG9FcjdRaEltODNa?=
 =?utf-8?B?OUlaWlF0MVIxVzRMQWZPZFM5d3Uzc0R4cFJILzl2R2t2T1IyN0FyZlE0Tysr?=
 =?utf-8?B?dUJ6eW5pckJuQkFoZGwyeUpqVnBhK3drNDdWTWI0c2IxcHU0ZzhLTVBwdE5T?=
 =?utf-8?B?Z3BqVW5TNnQ4ejlJWEhDcjc4VUxCWndETUNnYzZLN1JlOGhrYXhEUnVveTFG?=
 =?utf-8?B?QndIWjJrcE1lOHdFUUlBVEhsejRjcHR1Z2N6b0NpUTVpQWRVakFGNzJTeFN0?=
 =?utf-8?B?d252TTQ0bzF5UHpNNFNBbnk2RVJESGJrTXlPS01GTWxDSFEzM00xeGVyMG5M?=
 =?utf-8?B?dUk0dkpILzlnRlBOS20wRmNHM3RVaS9NWUFpcUhlU0tRbTgrbEVMbkh0Qy9M?=
 =?utf-8?B?UEU3UEdiVkxhMGczYlVKN0s1ejFCRDV5MndZakpQaFpQZUhaeWtiN016R2FB?=
 =?utf-8?B?MUhTYi9oTHlpdWV4SjRtdmgrcUc5bzVnZFU3RFFtN3gzTHVWVkJHR3JFZEg4?=
 =?utf-8?B?aUxvcFR5ekhUR0tGdDVIMWNrcTN3WnovNnp5OGRNekVUaHJrbXo1TVhtY1g3?=
 =?utf-8?B?dWZYUVdmNTkxR3pLV3MrV1JFRVVOdDMwa2lmcVRsRzFKNVFleWMwUFJ6U09S?=
 =?utf-8?B?ZmsrcFh3VGtDcHBCSTlCWWZ1UHpXcHRzTHgwelFKVlJnZjI2cThQQjQ1c3VH?=
 =?utf-8?B?cWMvdnY5bjIxdEowcUEwekpFQkpqWjQ5cEIzbGdFRXhtZ2wzNXpEMDJpOWMz?=
 =?utf-8?B?bUgwR1NNV001QTY1eWY4RXNiZzNldVVlT3pNS3EvQkVMYmRoMTNOOWxxK2Nr?=
 =?utf-8?B?eXpwMHZ3UE1KcEZOZTZjQlRsMUlOdmtQYTROQm1ZZWg5R2pOVy9jVUZTc0JG?=
 =?utf-8?B?UVRVSGl5ajBkZFZHNDlnOS82OUMyYUVpeUxsK2laNm9hOXU1R2c4bmNJZkFQ?=
 =?utf-8?B?ZkdaTmZuUEJ6VGVWd3BpRFMyVmkvdVIvNEZqdEFjS2JGalZXeVVteTl5Mms0?=
 =?utf-8?B?TEdldk5vNDZ1MTFFd3BvOTJiUHdCRjU0TVYzejFIbmhNdWlxZ1VaRitrR2JN?=
 =?utf-8?B?V2M1enB2SG1wbWZlRjZjQ0gwNE1Sc0x2MFVRbDFkNHZkZWhaT1lXenhVMStr?=
 =?utf-8?B?V0pla05abTJNOVM0dFlGQ0Z2eWpOYnhoU3kxSlp1cHhibkFubFNGYzQvVlJy?=
 =?utf-8?B?dlRTdEZIRDJJWVZDWHd5S2RpSEpFT0lRK0dBNzRYMmtLUzZtRWpMWEsxRHBo?=
 =?utf-8?B?YllvL04xYUsraVBCOTJIZlMrSzN3ekVwMXg0ZEtHZDZ3VVN0MDNhSzV1eTFU?=
 =?utf-8?B?MWlMMzQ3LzVQRGU1N0lsMDYxd0JPNmRTSjhhRHlPWk5sYmxiMUZ4M1pvc0Ez?=
 =?utf-8?B?ZThsVGpvYTVSTzlMUXpHSDh1TGlTYktZNzZXYUNYVTNNRE51VzZGaTUvZFpW?=
 =?utf-8?B?NGl5TmRrQ3pCOGs0bm1SSUdPeU1LTHJBdjFrWEVhbThPUDE5YWN3T2JMem90?=
 =?utf-8?B?RG9hYmFLeXM1TTJ0N0ZZRmJkbzhLSDhsOXJZMGhWSXFPcFFZcy9yWXQ4Vi9D?=
 =?utf-8?B?QVZXd2M5RkRwVmp0bUJzVFpyR3FVNEpab3VSQmQxNmNOdGcwWUNTZzU4OWhl?=
 =?utf-8?B?M3ZRZkhEYk82azdxNE8zMStxS0g5T1I0cGUzZE5HQW9MU2Z6NVlDaWhqeWpz?=
 =?utf-8?B?QzM1Qm04SzJTTkc1Q2RkcGpaYUNqUXJzTTFaVVR4WEVrRk1RVW4rQXBSY3Vq?=
 =?utf-8?B?TC9IWU95a0J3V3lmTzVISmVIdSsyeVJJK3ZPa09tWEVrVjFSeTN3VEVEQjVT?=
 =?utf-8?B?ZDg2eXpiVld4R0FjOHpKbU96VVBqa2FPZDdEWmRpZ09acTRrb3REZGVVaW1y?=
 =?utf-8?Q?CxeRU4rRraVeO3DgVSXerqJeg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C8A014A8E4D664D841B0351B3ADAFAD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288f2b34-fae1-4682-381e-08db617464d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 01:14:33.8235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gWdC2lp6nfX+EIpRfLWi6kI2lcshwcFN++4guwJBUpuQVfbPh/CJlyhUOE+beCI2SwwkJK48khb7YzzDL2xXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6472
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTMwIGF0IDExOjQ1IC0wNjAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiBUdWUsIE1heSAzMCwgMjAyMyBhdCAxMDo0MToxOUFNICswODAwLCBQ
by1XZW4gS2FvIHdyb3RlOg0KPiA+IC0tLQ0KPiA+ICBibG9jay9ibGstbXEuYyAgICAgICAgICAg
fCA4ICsrKy0tLS0tDQo+ID4gIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCB8IDQgKysrKw0KPiA+
ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLW1xLmMgYi9ibG9jay9ibGstbXEuYw0KPiA+IGlu
ZGV4IDE3NDlmNTg5MDYwNi4uYjYwYzc4ZjVhZDQ2IDEwMDY0NA0KPiA+IC0tLSBhL2Jsb2NrL2Js
ay1tcS5jDQo+ID4gKysrIGIvYmxvY2svYmxrLW1xLmMNCj4gPiBAQCAtMTE4MSwxMiArMTE4MSwx
MCBAQCBib29sIGJsa19tcV9jb21wbGV0ZV9yZXF1ZXN0X3JlbW90ZShzdHJ1Y3QNCj4gcmVxdWVz
dCAqcnEpDQo+ID4gIFdSSVRFX09OQ0UocnEtPnN0YXRlLCBNUV9SUV9DT01QTEVURSk7DQo+ID4g
IA0KPiA+ICAvKg0KPiA+IC0gKiBGb3IgcmVxdWVzdCB3aGljaCBoY3R4IGhhcyBvbmx5IG9uZSBj
dHggbWFwcGluZywNCj4gPiAtICogb3IgYSBwb2xsZWQgcmVxdWVzdCwgYWx3YXlzIGNvbXBsZXRl
IGxvY2FsbHksDQo+ID4gLSAqIGl0J3MgcG9pbnRsZXNzIHRvIHJlZGlyZWN0IHRoZSBjb21wbGV0
aW9uLg0KPiA+ICsgKiBGb3IgYSBwb2xsZWQgcmVxdWVzdCwgYWx3YXlzIGNvbXBsZXRlIGxvY2Fs
bHksIGl0J3MgcG9pbnRsZXNzDQo+ID4gKyAqIHRvIHJlZGlyZWN0IHRoZSBjb21wbGV0aW9uLg0K
PiA+ICAgKi8NCj4gPiAtaWYgKHJxLT5tcV9oY3R4LT5ucl9jdHggPT0gMSB8fA0KPiA+IC1ycS0+
Y21kX2ZsYWdzICYgUkVRX1BPTExFRCkNCj4gPiAraWYgKHJxLT5jbWRfZmxhZ3MgJiBSRVFfUE9M
TEVEKQ0KPiA+ICByZXR1cm4gZmFsc2U7DQo+ID4gIA0KPiA+ICBpZiAoYmxrX21xX2NvbXBsZXRl
X25lZWRfaXBpKHJxKSkgew0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1l
LmggYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgNCj4gPiBpbmRleCA3Y2Y4ZTQ0ZDEzNWUuLmFj
YzliMWNlMDcxZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgNCj4g
PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgNCj4gPiBAQCAtNzAyLDYgKzcwMiwxMCBA
QCBzdGF0aWMgaW5saW5lIGJvb2wNCj4gbnZtZV90cnlfY29tcGxldGVfcmVxKHN0cnVjdCByZXF1
ZXN0ICpyZXEsIF9fbGUxNiBzdGF0dXMsDQo+ID4gIG52bWVfc2hvdWxkX2ZhaWwocmVxKTsNCj4g
PiAgaWYgKHVubGlrZWx5KGJsa19zaG91bGRfZmFrZV90aW1lb3V0KHJlcS0+cSkpKQ0KPiA+ICBy
ZXR1cm4gdHJ1ZTsNCj4gPiAraWYgKGxpa2VseShyZXEtPm1xX2hjdHgtPm5yX2N0eCA9PSAxKSkg
ew0KPiA+ICtXUklURV9PTkNFKHJlcS0+c3RhdGUsIE1RX1JRX0NPTVBMRVRFKTsNCj4gPiArcmV0
dXJuIGZhbHNlOw0KPiA+ICt9DQo+IA0KPiBJIGRvbid0IHRoaW5rIHdlIHdhbnQgbG93IGxldmVs
IGRyaXZlcnMgZGlyZWN0bHkgbWVzc2luZyB3aXRoIGJsay1tcQ0KPiByZXF1ZXN0IHN0YXRlLg0K
PiANCj4gSXMgdGhlIGVhcmx5IG5yX2N0eCBjaGVjayBvcHRpbWlzYXRpb24gcmVhbGx5IHdvcnRo
IGl0PyBXb3VsZCB0aGUNCj4gZm9sbG93aW5nIHdvcmsgZm9yIHlvdXIgdXNlIGNhc2U/DQoNClJl
ZiB0byBvcmlnaW5hbCBkaXNjdXNzaW9uOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
LzE2NjM0MzI4NTgtOTk3NDMtMS1naXQtc2VuZC1lbWFpbC1saXVzb25nQGxpbnV4LmFsaWJhYmEu
Y29tLw0KDQpTZWVtcyBpdCBpcyB3aGF0IG52bWUgaG9wZXMgdG8gb3B0aW1pemUsIHNvIEkgcHV0
IGl0IGJhY2sgdG8gbnZtZS4NCk90aGVyd2lzZSwgd2UgY2FuIGp1c3QgcmVtb3ZlIHRoZSBucl9j
dHggY2hlY2sgZnJvbSBibG9jaywgYmVjYXVzZSB0aGUNCnN1Ym1pc3Npb24gYW5kIGNvbXBsZXRp
b24gcXVldWVzIGNhbiBiZSBhc3ltbWV0cmljIGluIGxvdyBsZXZlbCBkcml2ZXIuDQo=
