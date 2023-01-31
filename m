Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377D56827F2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjAaJCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjAaJCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:02:18 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619004C6D7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:58:44 -0800 (PST)
X-UUID: 4349d126a14511ed945fc101203acc17-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=03NB3XwxFVDkwxXEHEpqN1IyRgBbRI4WchaoDM4XCwM=;
        b=d4MTl5JRDuna3JlS+nENfRhzzp/YXyn5nfoTe4r8136HT+6e3yhdR3wLIym0p0DOX6cZZ5/g4Ka2ndsYkPljnrKi+QS8bGALg59wkNAX+NK5qavBrNuVnANS0pLsDLv/UHT5XqtT9fMW5zGGWvoxyJcCVYJhcVHHHFh0fPIfvSg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:6285850e-bea7-4b85-ab75-831206f04ad3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.18,REQID:6285850e-bea7-4b85-ab75-831206f04ad3,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:3ca2d6b,CLOUDID:59f602f7-ff42-4fb0-b929-626456a83c14,B
        ulkID:230131165717KT46WMH3,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 4349d126a14511ed945fc101203acc17-20230131
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 893081867; Tue, 31 Jan 2023 16:57:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 31 Jan 2023 16:57:15 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 31 Jan 2023 16:57:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIy9jpSrjI6A/LbFVHt8Oquh+Z2dodibl+dphN1FwNXz86S3Pu6uFzz6EsUW4jdzL1AVhzi0aBJL63mhVpEduC/q88jDJBUG3HDvXgGoOWABxadKae/FTTMPzQLy+3juGql1xyBigPOSzsjYiEnMsmk6sjCLYEAuLgcq2MJqqCEDElKvRE5Or7AgK9H8n8dbeojpnKQtDqWkPtxuW0RXttgLgAqQLoQ2zKnezQ6xPWMKik0DA55fP03We8uvFI8ln6QApyQWCB2+ph+UlYzgORyMLRev9R6S4DowouR0SniWKFb10NaQ2vmWOaiIzcO04RqAhmo5LMWgwh6yaEF+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03NB3XwxFVDkwxXEHEpqN1IyRgBbRI4WchaoDM4XCwM=;
 b=ie0YX7Wj6RYWn3CNjmbAWeTPDHISf9mXCpM7jqHQFd3Dhr7LlD0VM8TbK/75BdH2J9Dj08aFspLRA4XpMvs6Fvq73MPplTt+5E+3lK923Hw9AQQZT9cdrkBIKuSCdkQ+rkf9zGZprwV9fOF6P0S4y6b+61bNokKuGMWtU+3CLeGVkXJJyFoaQnqQEjTBhf8Ybt5Iw+IUq+1YU5Q3BrtdL7lpQUXqSnQDtXau9y5RECbyemdYCMALspyHitxZWb+HvzS0tgsX6QwJ6j1n0djc2Z3UxEr6rxr+955yuSvdhkiYHD6uzM5HuCMpr8QCq0Trdmgxm4+Gj+faEPrf4SxTew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03NB3XwxFVDkwxXEHEpqN1IyRgBbRI4WchaoDM4XCwM=;
 b=TMVAPrllXNlPZ2w9xCfhejJ7PSBPt1OBjHVGIkpBYGyCX8cUsy4aBdRUpuMPs/qp5fpmEy2eW3IFrvln+KoaNFWuGH5ZNWKIGXThmiVgCJPCwjtAoN47DRLP3gmNvkGGB4iOZ0cbilfKSt3aThabNYkMQphnsmMSQaefUtb2H8o=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by SEZPR03MB7035.apcprd03.prod.outlook.com (2603:1096:101:e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 08:57:12 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1%3]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 08:57:11 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "ndesaulniers@google.com" <ndesaulniers@google.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "trix@redhat.com" <trix@redhat.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v6 1/3] phy: mediatek: fix build warning caused by clang
Thread-Topic: [PATCH v6 1/3] phy: mediatek: fix build warning caused by clang
Thread-Index: AQHZIEA7g6q5Ep2afU2pWWp4HJGwLq6cu2OAgAQYvQA=
Date:   Tue, 31 Jan 2023 08:57:11 +0000
Message-ID: <11e2923015a01ed0aac2ca0cb31fbc8016644a0f.camel@mediatek.com>
References: <20230104132646.7100-1-chunfeng.yun@mediatek.com>
         <CAKwvOdnMF4LRhTnQ3Rg+q3hd7jm2tS0aTHmwU6isKJHL2u9Q-g@mail.gmail.com>
In-Reply-To: <CAKwvOdnMF4LRhTnQ3Rg+q3hd7jm2tS0aTHmwU6isKJHL2u9Q-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|SEZPR03MB7035:EE_
x-ms-office365-filtering-correlation-id: 6ac85ad6-e0d3-4622-4a09-08db03692447
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xf5CcTQYk87ZJlsxtogsxDyIrGLXHZx8EoOC9bPC0TL1nhbpjBkjgu66nCD1LTgt8dUXr273+W98nahmc7hBzuejzjHtNjZKzInzMSKRfV5Y1xP2yBoEbI3/wql0pezS8j9kfDO3Quzch4EsvaTrDCB2aUzXYe20VrJBCJFHIBNBbkrNUJ2pMd8+DcFElIgBvBiJ+dM8p+mWNUbs3nvBFUlYzdvJE9qKjcSKp6QOZvT5zjoa7v5piud1dvLF5eSeyOWDfAWLNz6AmBlkj1YNwvamOSvf0X2bPo064rWVVP3+ZzJiC2bds8h4OhTG8uDwy9ka95WX3+CdLf9WKuLZiVbctcQc39h9C5MVImeYVgd9Fi2HhyNUSYkUL31m9AR24njTcsa9VLlVYPYirTsd3GhiLXYG0E7s2QhQm+zqjFW2Bp23KgZ9IPP0yxpW8huPN/tqUuHe+09LIl8XWXMh5QDxoSFzx337+IFg9b4oBlCPu0c6tFR8+2mrm1Cicp0xOB6e/DVKQjMpG3FA6XdaS2SaIYF0CdCHCCD/VCmgwb+PQAT4mpCHV5JC3TuhLcKW40gT+Q4J9oAJrPxCuP5cpQPJMGoT//3uJhDW8bu4HD/zJu+s9p/pWywvAYTTQoaFzBCY50uN/fm6hE3ftpZgCt255DtrkU0Ck9AIQTm5VwIKTCiag3FPE3a8TWOWepNEstvdkSqrhZqRsXiiE4rLxzyG7inKQxf/LShV+1xDrus=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199018)(85182001)(36756003)(26005)(6512007)(5660300002)(2616005)(122000001)(186003)(38100700002)(7416002)(2906002)(53546011)(71200400001)(38070700005)(6486002)(478600001)(6506007)(86362001)(6916009)(83380400001)(91956017)(76116006)(8676002)(4326008)(66946007)(54906003)(66446008)(66556008)(64756008)(316002)(41300700001)(66476007)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajF2QXROby9FVUxVdDI2Q3ZlRGxlbmlxVkR5TFpHT2d3ejh5OS8yMVduM0JP?=
 =?utf-8?B?ZU9sb0ppb25Pcm5RdHZPMHUyU3QrblRpUmpFMVlpRmxUQyt5blhEOHN4ZUVX?=
 =?utf-8?B?NEZ5RXdxdUd1VDBvODBGcmhjdlZIblNzMjZwTzFORG9sRy8rb2dyeitXNkFN?=
 =?utf-8?B?bzVVNVFTWGQvUkN2ems5M2hyUndhZ0RUL2NBckxrTzB0aUdWQVo5M3MzYlJ6?=
 =?utf-8?B?REpReDBHdjhaNUl2bEsrV2tTRStzeFQrSndQM0tsdURVSHY4RzZQbTA0WDB6?=
 =?utf-8?B?bnBaQlpJeVBPaFB2dWx0MkZ6QWI0alhoalV1Q25UbmhOTGlKRVI2WDNoa05p?=
 =?utf-8?B?L1ZacXNMdjkzeldDS0FnK3d1M2psNmxqMWN1L3hGZmpFOVczSTBIY2p6cURk?=
 =?utf-8?B?RVMwK3gzOFNKSHZqT2M2SlYvcVFCWWNqNDdJVm0zTzFOK0xnTFFQTHhyMC9V?=
 =?utf-8?B?UUwzeTlldkN6Y05icHplSXJXWXN4eTBjV0xnZEdrRkFndzI5MUJEdHZXUDFi?=
 =?utf-8?B?VlQvT0h3bUEwQUtLbzlsUlMvenNTc2dVUnN4aG9tN2k5TVd2d1U5V0FmdXor?=
 =?utf-8?B?N1ZlVnQyQ2pvZTN3eTdVeG1JeENCd0hxd1BiM2d6WGk5a0h0MU9sMVRRWUV6?=
 =?utf-8?B?MmZyc3IzeVdsWkIwNnpUbmpRbDNBcnZ1SlIzeTQvRHZzanA3RnYxa0hWeVRB?=
 =?utf-8?B?YWZBQk9lRkpLUzZRUm1xYjhoVkpjTjBTNjU3QjlwSnJMa0RHWDJrNUVMb2Np?=
 =?utf-8?B?N3JSaWY4eGVWYTZjQVh6TkczRENPS0QyWTE4R2xGZGlveU5tbDVwdFh0ekVu?=
 =?utf-8?B?NkRlaHhaRkVONDBIN3VpM2RaWVJmS01SaG9hYTNlMm9zZ0toU3NrdVhoUndm?=
 =?utf-8?B?UDRQdGpENTdDaTdCaFhVY1lPU2d4bldxenNsUS9wcy81R2tvcXdOc0hPWHEx?=
 =?utf-8?B?RHpybWtQeThQaUFPUXUrZEZGQ2h5QTVQeWVwdGpxN05vOFRCWVlvWmoyNzFL?=
 =?utf-8?B?SXVwVExFQVBreFRpYnpRcjlDNGh1SkptYVhMM1M4aDBYak1tdXkxTHVqeGh0?=
 =?utf-8?B?OUlvUnV4TFBWWUx0OTNaVWlSKzNTcytoNm1YMEM1Sk9wZG9OS1Vpckd5dXlD?=
 =?utf-8?B?S3E0NlJMMTJvSC9pQTJjOGZUVUNMZkNxUnltRjQyMHRzWUtteE1jcXFRa1Fq?=
 =?utf-8?B?bG9tOW5qeWZ2UkdVWm9wdUFhdlpxOFBxNTFhUk05V3pSTUQxUlAzRW9pckg3?=
 =?utf-8?B?QkhXK2haQWh3R2tDcC9oV3JhelRHaWc4cDBsMDdycm92OVFmMWQrQnBqOFFS?=
 =?utf-8?B?Q1FVTWU3ZC9IYXFpTERiQWpsR0lMck1MSUlhVjRmdENoMndIQ3AvZDVLVlJz?=
 =?utf-8?B?a2xqVjVpTEsyM25oL0Z1dFdIK2lIQ1BYTlBNZE5tRDZOeUVmZktWRGExWWpX?=
 =?utf-8?B?QnJVK2tiMXpxa0xDVmhLcGNaakJqbjhVWThQUkxNOXo3emF2K2VOK3ZSNzJK?=
 =?utf-8?B?aW1QenJZSHBaRDU5Sjh3Z1pWNnhjM2cya09Eb0EydnQrSGRqdGdCdDkrZllm?=
 =?utf-8?B?K2tjMTZWazdNTzVROEU2eXFzTXJOWVJ5YjNpdGdSYjNsM1VGalprcEV1bjFZ?=
 =?utf-8?B?RnFPQy84eTFmSVAvNzNpZUJER2p4RnZOVmJ2TGpoTm13YytBcVNpdVl4M0Ro?=
 =?utf-8?B?MVYzRVhMMjdCRGJ5Y2dudlNzb3VpYWx0c0E2UW10REFUVmJEOXJXbXBJOWNQ?=
 =?utf-8?B?NlRrdjE2S0lBbFdhM01mZkJxbE1vTk9Fa2gwVkNhcUJEQmk2Y1I0NDBySkpn?=
 =?utf-8?B?TDJEL2Nod3JJdzNYenJnWWJucDl2NUJXcXhDMlBRVWFPS0FleTZoZ01SRkRU?=
 =?utf-8?B?cnFvTVE4Y1A5UWtTS1MxZk5qSmd5cHlIcDhMRHpJbTdQMXMxMmtWa25CWjF0?=
 =?utf-8?B?eXQ0Z0ZiRGE4YVdjZmswU01DcHdHaWlDQWI5RjI2dkhSUzFxa1RnSzQyckVH?=
 =?utf-8?B?d0VWQmVWQUNNV0lCaTVjVWdVckF6QXJVR3l0RTErSDB1UzFRNFc1dEVSYWcv?=
 =?utf-8?B?Q1V4NWFQaVdJSDFCQWN3by92ZEZGWEg4cFo2MmhXQjF5NGFYdCs2Tk1MdDE1?=
 =?utf-8?B?R0M2Vk5jUHkzQXozd3pWMVNLSXUxMTNpMHQ4Ky9DNlZFYWJJL1lXUXdQaEdr?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E83A9B03C300D4882D87787092B947A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac85ad6-e0d3-4622-4a09-08db03692447
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 08:57:11.7533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9+i3GTUpNCkunBXkgzgOWX87I9IZroPYWdqIIyaXLtVkLr17zWxzebyBkwRkdSxLHYua++mEQd8yA4ZXoPZICM5ztVGMUcnFE/ooUbOlEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7035
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTEzIGF0IDEwOjM2IC0wODAwLCBOaWNrIERlc2F1bG5pZXJzIHdyb3Rl
Og0KPiBPbiBXZWQsIEphbiA0LCAyMDIzIGF0IDU6MjYgQU0gQ2h1bmZlbmcgWXVuIDwNCj4gY2h1
bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gUmVtb3ZlIHRoZSB0ZW1w
b3JhcnkgQG1hc2tfLCB0aGlzIG1heSBjYXVzZSBidWlsZCB3YXJuaW5nIHdoZW4gdXNlDQo+ID4g
Y2xhbmcNCj4gPiBjb21waWxlciBmb3IgcG93ZXJwYywgYnV0IGNhbid0IHJlcHJvZHVjZSBpdCB3
aGVuIGNvbXBpbGUgZm9yDQo+ID4gYXJtNjQuDQo+ID4gdGhlIGJ1aWxkIHdhcm5pbmcgaXMgLVd0
YXV0b2xvZ2ljYWwtY29uc3RhbnQtb3V0LW9mLXJhbmdlLWNvbXBhcmUsDQo+ID4gYW5kDQo+ID4g
Y2F1c2VkIGJ5DQo+ID4gIkJVSUxEX0JVR19PTl9NU0coX19iZl9jYXN0X3Vuc2lnbmVkKF9tYXNr
LCBfbWFzaykiDQo+IA0KPiBDYW4geW91IHBsZWFzZSBpbmNsdWRlIHRoZSB0ZXh0IG9mIHRoZSBv
YnNlcnZlZCB3YXJuaW5nPw0KPiANCj4gPiANCj4gPiBBZnRlciByZW1vdmluZyBAbWFza18sIHRo
ZXJlIGlzIGEgIkNIRUNLOk1BQ1JPX0FSR19SRVVTRSIgd2hlbiBydW4NCj4gPiBjaGVja3BhdGNo
LnBsLCBkdWUgdG8gQG1hc2sgaXMgY29uc3RhbnQsIG5vIHJldXNlIHByb2JsZW0gd2lsbA0KPiA+
IGhhcHBlbi4NCj4gPiANCj4gPiBGaXhlczogODQ1MTNlY2NkNjc4ICgicGh5OiBtZWRpYXRlazog
Zml4IGJ1aWxkIHdhcm5pbmcgb2YNCj4gPiBGSUVMRF9QUkVQKCkiKQ0KPiANCj4gVWgsIHdoeSB3
YXMgODQ1MTNlY2NkNjc4IHNlbnQvcmV2aWV3ZWQvbWVyZ2VkIGlmIGl0IGRpZG4ndCBmaXggdGhl
DQo+IGlzc3VlIGNvcnJlY3RseSBpbiB0aGUgZmlyc3QgcGxhY2U/DQo+IA0KPiBJcyB0aGUgaXNz
dWUgcGVyaGFwcyB0aGF0IHlvdXIgbWFzayBpc24ndCB3aWRlIGVub3VnaCBpbiB0aGUgZmlyc3QN
Cj4gcGxhY2UsIGFuZCBzaG91bGQgYmU/ICBTZWU6DQo+IGNvbW1pdCBjZmQ2ZmI0NWNmYWYgKCJj
cnlwdG86IGNjcmVlIC0gYXZvaWQgb3V0LW9mLXJhbmdlIHdhcm5pbmdzDQo+IGZyb20gY2xhbmci
KQ0KPiBmb3IgaW5zcGlyYXRpb24uDQpJIGxvb2sgYXQgdGhpcyBwYXRjaCwgaXQgc2FpZCB0aGF0
ICINClRoaXMgZG9lcyBub3QgaGFwcGVuIGluIG90aGVyIHBsYWNlcyB0aGF0IGp1c3QgcGFzcyBh
IGNvbnN0YW50IGhlcmUuDQoiDQpUaGF0J3MgaW5kZWVkIHRydWUsIG5vIHN1Y2ggd2FybmluZyBi
ZWZvcmUgdXNpbmcgRklFTERfUFJFUCgpIGR1ZSB0bw0KdGhlIG1hc2tzIGFyZSBhbHdheXMgY29u
c3RhbnQuDQoNClNvIHNlZW1zIHRoYXQgaXQgY2FuIGZpeCB0aGUgd2FyaW5nIGlmIGF2b2lkIHVz
aW5nIGEgdGVtcG9yYXJ5IHZhcmlhYmxlDQpAbWFza18uDQoNClRoYW5rcyBhIGxvdA0KDQo+IA0K
PiA+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gDQo+
IENhbiB5b3UgcGxlYXNlIGluY2x1ZGUgdGhlIExpbms6IHRhZyB0byB0aGUgbG9yZSBVUkwgb2Yg
dGhlIHJlcG9ydD8NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVu
Zy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IHY2OiBtb2RpZnkgdGhlIHRpdGxlDQo+
ID4gdjU6IG5vIGNoYW5nZXMNCj4gPiB2NCBuZXcgcGF0Y2gsIEknbSBub3Qgc3VyZSBpdCBjYW4g
Zml4IGJ1aWxkIHdhcm5pbmcsIGR1ZSB0byBJIGRvbid0DQo+ID4gY3Jvc3MgY29tcGlsZQ0KPiA+
ICAgICBpdCBmb3IgcG93ZXJwYyB1c2luZyBjbGFuZyBpbiBvZmZpY2UuDQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstaW8uaCB8IDQgKystLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLWlvLmgNCj4gPiBiL2RyaXZlcnMv
cGh5L21lZGlhdGVrL3BoeS1tdGstaW8uaA0KPiA+IGluZGV4IGQyMGFkNWU1YmU4MS4uNThmMDZk
YjgyMmNiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstaW8u
aA0KPiA+ICsrKyBiL2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstaW8uaA0KPiA+IEBAIC0z
OSw4ICszOSw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBtdGtfcGh5X3VwZGF0ZV9iaXRzKHZvaWQN
Cj4gPiBfX2lvbWVtICpyZWcsIHUzMiBtYXNrLCB1MzIgdmFsKQ0KPiA+ICAvKiBmaWVsZCBAbWFz
ayBzaGFsbCBiZSBjb25zdGFudCBhbmQgY29udGludW91cyAqLw0KPiA+ICAjZGVmaW5lIG10a19w
aHlfdXBkYXRlX2ZpZWxkKHJlZywgbWFzaywgdmFsKSBcDQo+ID4gICh7IFwNCj4gPiAtICAgICAg
IHR5cGVvZihtYXNrKSBtYXNrXyA9IChtYXNrKTsgICAgXA0KPiA+IC0gICAgICAgbXRrX3BoeV91
cGRhdGVfYml0cyhyZWcsIG1hc2tfLCBGSUVMRF9QUkVQKG1hc2tfLCB2YWwpKTsgXA0KPiA+ICsg
ICAgICAgQlVJTERfQlVHX09OX01TRyghX19idWlsdGluX2NvbnN0YW50X3AobWFzayksICJtYXNr
IGlzIG5vdA0KPiA+IGNvbnN0YW50Iik7IFwNCj4gPiArICAgICAgIG10a19waHlfdXBkYXRlX2Jp
dHMocmVnLCBtYXNrLCBGSUVMRF9QUkVQKG1hc2ssIHZhbCkpOyBcDQo+ID4gIH0pDQo+ID4gDQo+
ID4gICNlbmRpZg0KPiA+IC0tDQo+ID4gMi4xOC4wDQo+ID4gDQo+IA0KPiANCg==
