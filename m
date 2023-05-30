Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCA0715AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjE3KEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjE3KEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:04:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27239C;
        Tue, 30 May 2023 03:04:32 -0700 (PDT)
X-UUID: 5bdeff1afed111edb20a276fd37b9834-20230530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MNOuYWCQ9QIcECy4+wxOBIQWHLUAOrDzaTmAgklbxdY=;
        b=Dira3OJFReFIQz964DnKCiS3OgxP5vOdllwGGn+8S7Q2cZFCXrnIgUVLKr9UXJWjMFNjkxiurWegOFwuA52ReAofnU9UvoVl9WNG09Oj1hzKh1Xu/Ty+8CVVsWHCFRL5Vl1jrUBvW9V+6XROSd+fVYFBJrDIenL9dmBcydO79hs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:bd29e5ca-b6c7-4dfa-b996-91504cdb8b2f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.25,REQID:bd29e5ca-b6c7-4dfa-b996-91504cdb8b2f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:d5b0ae3,CLOUDID:a6cfce3c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230530152421FEEOTTTB,BulkQuantity:9,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 5bdeff1afed111edb20a276fd37b9834-20230530
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2016935714; Tue, 30 May 2023 18:04:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 May 2023 18:04:24 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 May 2023 18:04:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj0h/NPPxjGW3P4zZ3KZzyOs5i84ir8SLZI2Bx+QjJNqKiv92GJTPQIJaPhHH6LRuVjNsGOeRWKtPoxJcknwxlybBfue8tqmSmWl2TQQV/yH9LKa3M72CUomKd8Gat8fDJL+WQc6803GHBU6FWTXsPijNMb9cy6Zo+sX2hgPBuq09cvcRgSywykt3nqyonwxokQ9mPoYZorRPlVlR1ZYbEAnb/w0AEcmRE/23/44HRVznUh3sH0U+o1zEjuIHEVWa8GTxvmGBaxt/E5PpT33ij4OxS1Hko82jFnlX7zNxg5fM30YJSn9oQ1i+duJK5d2BaZZxZVyEnYyui10cb0+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNOuYWCQ9QIcECy4+wxOBIQWHLUAOrDzaTmAgklbxdY=;
 b=AaSFLxDYAz3V/0KrLR8sJSyEaHMTGaL9DtxiExXRn7gFSnc56az8F6dCOBxnHtO4O7HHaeKgXwp5GnlSsn0SzgfuA5XExaYz3HXF5wrve/7ySx49x5JJz77kwH0b9f87WSUOh314DRjDvomdmGaOvHu93/1R5gMpfy/Dc39glwRB9I/zRfwnY/qVOIeJu3WZDZZxFFCXJEhDP2a9R0QXuD9UZWUs0Cyu4ShGpjK4IJzftvQQUYsdloC0jq87Bn2mXuqUaL1Z5lkrw0eZaBEsJ0TxykuJ2ltyAwViisLR9kX1i/qr0N9GZODyRH9Z/2+GaZ5Jq7Pc/dck9NrWcMncmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNOuYWCQ9QIcECy4+wxOBIQWHLUAOrDzaTmAgklbxdY=;
 b=loHq9gCXftkcBu/jJzJYTqVnHuPvcASgjfb8FsXF/MaaHgbc9pZoEx/7VccLOZPx2/Oj+F9E7rJJgoaXtVHzXWgizB5LbvGfZB84+Yp7RoPTQTw6LmMOduORKu722QX32WoC7QjbIcpUgwWvo//ob2YHNCAG+/OuPvwhogbMtAU=
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com (2603:1096:400:120::13)
 by KL1PR0302MB5427.apcprd03.prod.outlook.com (2603:1096:820:47::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 10:04:22 +0000
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::f0ea:f00a:e800:a382]) by TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::f0ea:f00a:e800:a382%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 10:04:21 +0000
From:   =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        =?utf-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?utf-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>
Subject: Re: [PATCH v2 1/1] scsi: ufs: core: Make UFS_MCQ_NUM_DEV_CMD_QUEUES a
 module parameter
Thread-Topic: [PATCH v2 1/1] scsi: ufs: core: Make UFS_MCQ_NUM_DEV_CMD_QUEUES
 a module parameter
Thread-Index: AQHZkp9qUHmLZjwbsUyUB6PID/14AK9yajaAgAAswIA=
Date:   Tue, 30 May 2023 10:04:21 +0000
Message-ID: <623ced08cabcb92763f75f13cd9a6c67d8b10fc6.camel@mediatek.com>
References: <20230530023518.16965-1-powen.kao@mediatek.com>
         <fc5b8f88-23ec-4f15-9b24-947f3cec4471@collabora.com>
In-Reply-To: <fc5b8f88-23ec-4f15-9b24-947f3cec4471@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5825:EE_|KL1PR0302MB5427:EE_
x-ms-office365-filtering-correlation-id: 6947cd0c-5421-4e42-ff34-08db60f53d7f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wiKMy0CElk7NcYXgB7Nm9C2CB7W1eQHrQ06ViBXgZNSGNJ0o6bbUTOQOpfs8Mng9Q+AZOmL6gKkw9Ds62c+BM5mj1ICBplryj6KOsXf0rQ09mB2enFa9df371WvDoQ/WyY0eKqlW4HJtqA5eOPq2MVi2db3chUV9oZfLne4iijNvLOkfQhtXNgGKDP/g1z9rpQgTYPBGPx2uhrgTLTCC8Xghl2xeO6TiuSj1M29T5d+439j6MMpAOHupWxd7Tj3wNvItQtHiULa8ahWlaSg8a0mJKKym4wvJaVPsmcmT0lIEhzJRagQ36usslhFzzb1ksNrXNkbcH+HWPzLvy5X1PQv4K3DZE5fNiMGJyr8i+mUhmyhealjmMF3W4hpzH/w59qLS4UTErsrh48703OQklTUKtUkXCqdgmSZG0093KKVVV40F/mttApC7s33BYy9EsPtZxuEilmyfX0c/mf2ZwLs9Lgb2iISQWFk4t0tMvfAf2LMCLwObXN/n36IXFag2EtIeldKq/AYfIUqwvHZX4cZuzqFdImE8qHBKFARg4ZAhHjnT2ue+MRi2t8ya+exAyyd+Ic272uhSYy88VAUHwwdlHII2o5Q5hmY/34Fx6mkgYHTAKLAkdQnZs8X9fikotxapsD97nF8PWQ+9nCvi6su5oBYQ+KdOI8FO1UHLXbE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5825.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(71200400001)(478600001)(110136005)(54906003)(8676002)(8936002)(7416002)(5660300002)(4744005)(85182001)(36756003)(38070700005)(2906002)(86362001)(66476007)(921005)(4326008)(122000001)(64756008)(66556008)(66446008)(76116006)(66946007)(316002)(38100700002)(41300700001)(2616005)(107886003)(186003)(6506007)(26005)(6512007)(6486002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGdCeFUzcDRodEUzTUJKNEphWHNXQk5lNENCblhNL0NkRzJHbTcwSXZoNWhH?=
 =?utf-8?B?aXk0Y1BmVXBFYTFoRUV2OXZZbHNNZE0rRHdNU0V0K29ORlZCS25OdGtSWm5O?=
 =?utf-8?B?UTFyaTd4MmFYcmZ1YUhIWC93eHRoaUpnQjFhMHhhYlozSmhydVREVGZGY3RB?=
 =?utf-8?B?a2VjT2p4djY5eEpQQm9QbGgxbVd5QUZLTUdMYk83MUFWOE00dnVvMW82U3Rn?=
 =?utf-8?B?eDQ0ZDZCUHBEK05XTDZhbUoxYmEyMDNQL3ZNZkJaSVVURzU4TlRHMzcxR1Mz?=
 =?utf-8?B?b0JVdmJmdTB3S0wzT0t0Z0xHT1BqQWhWZUhrcTh0SFFQUWhZeG5GMXdkZmtp?=
 =?utf-8?B?MWsvVy9sN05Oa0ZBRks3ak1oYzlFZXkxVDlUOGxpRFJBc1kvdjZkSkh2YlhH?=
 =?utf-8?B?WG1PaHNpUURJK1ZzbnpucEd5NGx4bVBuQnlyL3JFQkg3Z3Vxdko5THlQRnFC?=
 =?utf-8?B?ME9VQWpzbGpGTlc2Y1NEZmRkejBpdi9OSDhhN25WRktHS1hLbnZ6c2lLaVRz?=
 =?utf-8?B?RWsxdkF6dUdDT0JBTEhnZE9oWTZJMGlGWnVBWnlEMG1FSWs4WTlMM1Z6SWR5?=
 =?utf-8?B?SkpocjBRTjVSdzRKQVpsVmlxN1dxSlJoSmhyajVSNUc4OGh5MnFtdVJhYTZE?=
 =?utf-8?B?NW14K25IeHh2RHdob0tvMGZsVEY4ajMwcTQ2VTFtTlNnY3NHdlYxUlNBOStx?=
 =?utf-8?B?Zi90bytCUzVrcXJNZ1lDaVVuNW9yWGZHUmRFUGt3TG4zVVN4K2RBZlJYVkNz?=
 =?utf-8?B?Qjh0aVZwb3NrcXNVQVFmNWZDKzVveGM5NitHeVQybFVsblF0enRSZXJxL1dO?=
 =?utf-8?B?NmZ3R2xyTnI0L1ZFNU1KaVhxNTRoenlQcXhRUzFhYmpBVWpHRG4zRjBEZkZB?=
 =?utf-8?B?RkN1SnlIcXI2K09NMnd1QnJxREwxNjRpV3FGU2RIN1VMMThTNlFqWlhqQTk4?=
 =?utf-8?B?R0MxWitWcmlJUEw0bWdCYmd1T2F4ZWFWMnFpVU5RKzZyRG4vQlkyWWJicmNi?=
 =?utf-8?B?eGtRSlpVaVR0bzlFbkxGS05ZRmRTZGRYZ3dLMEEvc1FjVTJVcHdMVTF0b2N5?=
 =?utf-8?B?K2g5Zytnb0g2N1NhUXgrU3A5VkxFWDYva0UxZ25vc2hoMjViZEkxaEZlWlY3?=
 =?utf-8?B?K0h1dEZ5ZmVGZHIzYnVuZytsS2tjRHJNcENGZjduOXExWnVmMzhrWEtlQi9P?=
 =?utf-8?B?UUI0bXU4b1ZFVVdwMmdOYzVXcXU5OU1mZ2kwSTg1UTFrMkdmaEJBckFTYU9R?=
 =?utf-8?B?TlRlK3RqS2ltcFdaVGFPMTVIdmp6NTBrYmpRbGdEQmlFUmJ2QzZnaWhWY1RX?=
 =?utf-8?B?eENzQVJZUUVIL0VBYmVGdURDUkd5QkErVk8xdkV3RVlNYngzd2NGNEJrSkp2?=
 =?utf-8?B?K2FjYmRTalgrSFBXMmNEZDVWL1lKRzUzTEtndmFhVzgwOTd1WnppaWVhTzlI?=
 =?utf-8?B?OTNNbk5seWhjQ1krcThiZGhUclBHSHJESWYrZWhFMzRhOFloaTV1dWRlclhq?=
 =?utf-8?B?VDdBNk1peUZ4VTI3OE12WlBpVWt3eVpwdUZKbTErODRSRWNpekFJUHBvaDdT?=
 =?utf-8?B?Y1hoTEJyYk9ENGllVGlqZkJ5MHRFVTZVcmsrTVZwak1zTHNzQjIxOHBNdUdR?=
 =?utf-8?B?WWo0RUQ5MUNDWlJ1MTIyR0trNERGZkZTUUNqWC9SM05NODdtNk52VkRiUk5t?=
 =?utf-8?B?WEpPR3E3MUh0T1ptQjI4SWRDaUlTUnhCVnE1RndibzJWWFdhdDdnSVFNQ2FB?=
 =?utf-8?B?ejcrTGN2VklLeDQrdjVlS3BLc3hydDk0Y1owVUJUWitqdDErQkFYOHlwczlr?=
 =?utf-8?B?ckFBbFRFUFpDQVZtN0RMYVd1RW5CTnhEWitKTmUyL0RydDIvemxId1BPT00r?=
 =?utf-8?B?cXBKRk01RTN5aVA0b0Z3OTYrKytoKzgrc0p1ZWs0TnBpbWlOQzR0RHFCcndv?=
 =?utf-8?B?dTczRUFhRmIxdXJYbjUxeE9CeVNWY2srV1M5bUVidWx1MXdQL3laRE1DT0xI?=
 =?utf-8?B?UGtuWk9mMlp3ZGxCeTlCbU1jUUI0dnkzMFJVKzAvbnBiWmVhb05RQ1JFUVBZ?=
 =?utf-8?B?TjA1eXBwaW84TEh0NGxtVmhvNXlRcnNCWUlqR2xZMFl0SnE0SVFlM3h2ekNj?=
 =?utf-8?B?U0tFZjVTVGsybjdjeHFTMG1ZMTdIVGJkZys2b2M5NDZvcjVTamp4V3RGWVF4?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCB1ECA9C770D4418883C9C1422436E4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5825.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6947cd0c-5421-4e42-ff34-08db60f53d7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 10:04:21.7843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoFe2lGrVXKHh8VXM2IhjubnB0Zz5BuBuvzNyFWn+53WpgwDSRnbI7GTfwxsTuGoKgPT1sKD9MORyWG45OqlTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5427
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTMwIGF0IDA5OjI0ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gDQo+IEkgaW1hZ2luZSB0aGF0IE1lZGlhVGVrJ3MgVUZTIElQIGRvZXMg
bm90IHN1cHBvcnQgZGV2X2NtZF9xdWV1ZXM9MSwNCj4gZG9lcyBpdD8NCj4gDQo+IEluIHRoYXQg
Y2FzZSwgdGhpcyBzaG91bGQgbm90IGJlIGEgVUZTIG1vZHVsZSBwYXJhbWV0ZXIsIGJ1dCBhDQo+
IHNldHRpbmcgdGhhdA0KPiB5b3UgcHJvdmlkZSBmcm9tIHVmcy1tZWRpYXRlayBpbnN0ZWFkLg0K
PiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQoNCkhpIEFuZ2Vsbw0KDQpPdXIgSVAgZG8gd29yayB3
aXRoIGRldl9jbWRfcXVldWVzPTEsIGJ1dCBzYWNyaWZpY2Ugb25lIGh3cQ0Kc3BlY2lmaWNhbGx5
IGZvciBkZXYgY29tbWFuZHMgbGVhdmluZyAoTi0xKSBod3EgdG8gKE4pIENQVXMgZm9yDQpzdWJt
aXNzaW9uIGRvZXNuJ3QgbWFrZSBtdWNoIHNlbnNlLg0KDQpBY3R1YWxseSBJIHdvdWxkIHByZWZl
ciBtYWtpbmcgaXQgYSBkdHMgcHJvcGVydHkgdGhhbiBtb2R1bGUgcGFyYW1ldGVyLA0KaG93ZXZl
ciwgdG8gbWF0Y2ggY29udmVudGlvbiBsaWtlIGBwb2xsX3F1ZXVlc2AgbW9kdWxlIHBhcmFtZXRl
cnMgaXMNCmNob3Nlbi4NCg0KUG8tV2VuDQo=
