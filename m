Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5905D729514
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbjFIJ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbjFIJ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:28:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39BA3C17;
        Fri,  9 Jun 2023 02:22:56 -0700 (PDT)
X-UUID: 164e0f1c06a711eeb20a276fd37b9834-20230609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PpRG0DuPPTfMaFuT6/MgExFGFrvtIjMZNpvljxIitso=;
        b=g0wvdF+BPvgd7gXVZPyfUqpCESFKHapO6xyS3EO+Rb0OGnepeAU1vmDLBZoagDyfVjMuKJ7axhiue2eLCq1luOcQLI2FCJBQVAeh+nW+efk7smzlpMmjMN1aKDgGFx+78ilTfClZW1HAK2i4viwdT6Mf/1SPhv9SmvGc87BvK6g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:3aab7992-1e23-4477-96e3-d9d843ee3f41,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:c8da1c3e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 164e0f1c06a711eeb20a276fd37b9834-20230609
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 319915259; Fri, 09 Jun 2023 17:21:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 9 Jun 2023 17:21:58 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 9 Jun 2023 17:21:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YepbS7Y8/EKBFLh+w/laR8OQvLIt+J1Sn0956xywC/SLoVM25a2cICQQMGMRobgns1OK+rQO7hjcJwzj//4FQ57Vo5xI/y52BAMddMhwdXEcZT97Sxm/9ZJaWq3ox+NkYiqopuj9/Z4vWUSKGUauB2+9A1niDtP5sPAH8nvQWS6BTNqfZL1XQNuiPTbe1GkVzNQGJWCN1EWGip59KdacDoom2xPY8q4KkvdJu3GxgqJA5FddDMqnv6f5KONHX5YAqu2IAK3nJY2kHGmQv6Azh47JdRsl1wxdmHFB3EjaDbbKnVMtXfU9I3aRW5YOWjDVsiOgIxU0uAWurtSz38El4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpRG0DuPPTfMaFuT6/MgExFGFrvtIjMZNpvljxIitso=;
 b=MZdjlYTBLGwYbtY1VgSQQMSMre8q86lLr2DtLrslwLXRp26VE8dPQm1AYX/XT+k8iEwSMsb1KnM3tvRHnBryDcwX6GjuSuk28vLDQ6SLiGpKZToRTDWLHcM5ru7S7V18tffXUPZQq4Mw+TwDoo/3Q8e/KAwJyZ62hQvV/24s58z3lxxbphF7MkvJearOhmPt5ymCoaAdzXJ617G1DhXx7YlF5GpiBqVSsWeD9UFXXR1CBvx4OEU/KeEgJP0AHWuD9cvc1+54rCixd60amjIJI8XgAfXfMIdZktDTLjCp3RRVyUOnFYDY7uv+u0QCyZELM9i+8nRXSoa2DMb66QPooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpRG0DuPPTfMaFuT6/MgExFGFrvtIjMZNpvljxIitso=;
 b=RZIIlJxETq97B9oRHKFe//nNhfMwuqGXN184fBQFVdEOyopfwZDeUqDOJqc63hBb9Gxk5EFp2qzkhb57uuM+mgTLyvfvPpfIfrOdOaFiPA5pYLCGtTAFS/UkeTALSM1QhVdqmd5lU7cjnSkm/hu+GApm3WiuBS5bFGuTmnKAykk=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by KL1PR0302MB5361.apcprd03.prod.outlook.com (2603:1096:820:48::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 09:21:56 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147%9]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 09:21:56 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] mmc: mtk-sd: include bitfield header and fix incompatible
 pointer types
Thread-Topic: [PATCH] mmc: mtk-sd: include bitfield header and fix
 incompatible pointer types
Thread-Index: AQHZmqbSy437Do6gk0+F95RwOJMqy6+CL6mAgAACs4A=
Date:   Fri, 9 Jun 2023 09:21:56 +0000
Message-ID: <2d0cbc227050ffb49bf56c1edf69307ba431f8b7.camel@mediatek.com>
References: <20230609074840.4520-1-wenbin.mei@mediatek.com>
         <c68b7198-9e1e-41cf-44bd-42205fdb7cea@intel.com>
In-Reply-To: <c68b7198-9e1e-41cf-44bd-42205fdb7cea@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|KL1PR0302MB5361:EE_
x-ms-office365-filtering-correlation-id: 6d48187d-a270-43ba-0783-08db68caf870
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gQpRUg1hzJc4fC0qPqdOxeQL/g5HdMiUHDVADYm+oIxx+hOhig9FnL61eOU2iQgFm4hrvPNs11rBhTEC62OwBZGi8I/eE5snQh02Z9jpi3DY1tCovLyjBCFv6KbXArBFTBDrvja18FX1OPqW9SqPR7tP9/RaiIhEiOcEo5LFvsWb1gSJEFFZfmdJuDtXz0yfqSJJENYdIqeg9cvF8awc0sAdcfcdPtNTwUTnk1OHCalqZZHizEiiiT75XNa8AbZZ/O1Rmzf5UZyLaUUqtHYzfeGm8h7xOkva7rQHz8x6tf35d5Xr+R8zT089p40sKkp/5gbsR9gGeB/LJHRffV924cmUSD2ScQ5Dp+o5H8fHK1s1529BxGoxGhL70Al6z2qPheQod27wAm2aJMP/iC38gBFO3GHXO7N90tBZQFzhb44NuqCNYV4lRjznU3wvJ8NBdMYkML+k6npuPd1feORlU7iEy3P16ErXJEvbR531H9KuH2eMOQmsoE/kiSwck7tF1BOG5fCz+OM2KJhiCJ2R1Ksj9v71GvPJz4V75RA2m+J8ypcM+E8oruAsMKm5cEnnHx2oPTTdVX2cCPEVeMCg0g+O43ukf61/WcLcd57XWoKAyeGq5PTrxjJbb5eIsZ18
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(54906003)(71200400001)(110136005)(66476007)(478600001)(8676002)(5660300002)(7416002)(36756003)(85182001)(86362001)(38070700005)(2906002)(8936002)(316002)(4326008)(64756008)(122000001)(66446008)(66556008)(66946007)(76116006)(38100700002)(83380400001)(41300700001)(6512007)(6506007)(26005)(2616005)(53546011)(186003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHFzeHo5ckJOK2g0THB4aFcxSGZTcjFza1pjandOOXRKVW5BVFRldDZieW9p?=
 =?utf-8?B?U1FVeHlSblBTb09rS1d5bUVHMnR3eXh3L0E5eHRYRzhFNWtoRVNwVW9oR0xV?=
 =?utf-8?B?SHZMTy9zM3lqcjFQbVI1RmFJQmd6eWNobzh2OHZoajlGMUFYSm10eVJEdXQw?=
 =?utf-8?B?dDRSQmxZOHIxaTNEZ1FEV1NnanpqczdyTzh5Q05ncFJsRXFrWlZPS1hiMzVF?=
 =?utf-8?B?Y2pVVFNUZTdESE9ja3EwZDIza0o0cjA5NEFCZS9aVkZDc3ZZY3V3TXhuL0RJ?=
 =?utf-8?B?WktuT1laQkpHYjRZM0QycGNDT2E1eVEvbU9MaDlubUphRlh4Y24vU3p4ZDBH?=
 =?utf-8?B?TDZMUTBrUzBib0EvYXVndnRWTjFWYnkzTFdSY1Q3NGpKVUt4SUYwOHFONG04?=
 =?utf-8?B?S1pNUldJbzNyaTJWU2R4azFXd3VBSzh5by82RW15dXNlV1RacjdKWERaVUFl?=
 =?utf-8?B?OGVoQ2RhbGFYYWFXNTFvTnZqRko3ZmZuL2ZYcHNuTXYzWmZlYVcvTGNPU3Nm?=
 =?utf-8?B?ejZJZXpwcDhseVBOWkhRMkN0ektWb3lWRFlxckVsTzFMejJVN2ZocjB1UTAy?=
 =?utf-8?B?YjkwMUo2azdHS3orc0tVVUw5TXozU05RRFZvRHBQUDFaQ2hRYmxzY2YwcE8x?=
 =?utf-8?B?dWwyY09HaXN0bEpNV3BkQ1BoV09JSFZZNnhKa3JDVVdQWnBjUmZ6bzRUWkxB?=
 =?utf-8?B?b3g1YlBVekdkTXFYaDlGVUpYelZpTklPQTd3QUNpY2YvS2VoVVlCbXBnOHZy?=
 =?utf-8?B?MjdERFM1aklXNnVka2NBbnFjUWt4SFprN2RSMkRMMEFUZFQ5N2U0Nm1WY3Vs?=
 =?utf-8?B?dldpamtEUzc2cHk3SThOR2R2QTRzM2Y2ZGtJdGdURFljL2krZjBGWHp4MSsv?=
 =?utf-8?B?ZGFaQmZOVC9Yc1Q3MXg2dU8rTHNJNWhYU0pQWjVUK2hjNHRydExOby9QeUxW?=
 =?utf-8?B?bXFJaEwrbjlGNHIzY05iVjM5RHQyWnA1Y2Z4ZCtLWXlPUjREOVp2NWlGQktV?=
 =?utf-8?B?Y25BRnNYak50QmIzTi9oWWFoaGIrbEVMbDZTOXMrTmMxRk82d1d0REdZd0Mx?=
 =?utf-8?B?K3U1dC9nYU03QTBOUEhreE9pNG5Zd1B6TnkrWERrVTRkWW5QVlZZNnluVzRn?=
 =?utf-8?B?REJUNFYxbGlncndFeEtjYmFjODhhTWEvRlZYaUNDY3lGL3puWC9JK1VXbjRF?=
 =?utf-8?B?UlhVVVZzY2oyV09heXFlTWJsaU4wMm9kYUd4VnhvMkRUSXM0cHZ1UVV1OEhm?=
 =?utf-8?B?MTFyY3ZYWUFCSlBrWkhnRmRMcmt3UGFGbzhTcG5jbTVQK05WSG42ZVNJOXFq?=
 =?utf-8?B?cXlXOWxaTWhET1dtWWhRNUZBVDB3NUhiK3NNa2Q0ZzFzU3gxNkYxWnV5d245?=
 =?utf-8?B?YWZqZWJ5SHlxeVBQSmNad3pGb2Vyd0VQays1L012K2VicHh5b1JCZHdaLzJz?=
 =?utf-8?B?azFkMGpMM3J4bGZZcEN4cys0WWh5UnAzN0QrSjBoNnExRjlManNpbXhTTEJZ?=
 =?utf-8?B?akFEaGtHQkZOUU5RZDBGR1lWU250eU9DZWtGNFV6ckpOblE2VE9sWmtmelhC?=
 =?utf-8?B?amxYM2Z4MVd6WHI2dTY1R2FKU2s1UHNBeE1HNi9oWnBZbi9qSmFmZUxQK1U3?=
 =?utf-8?B?TGUydU9FRWNtWGk0NTJ4M1pDMmZzZEcvUDF3SHEzSnlKZVYrZS84YXBOQUZs?=
 =?utf-8?B?R1dPa0kyMmdobUM3aTVHUXp0R2J6dEsvTjAwU203UmVlL0ZGZzlubUp1RGdn?=
 =?utf-8?B?WVJxdzhBeDlLRWxLWUExNWRSMlN4YWN4djBPR2Z6RW16REgxMFlzbGNQa21N?=
 =?utf-8?B?Z25OVDgzVUlVYUdwTmEzZjhCWmw1S09sSnI2K2NCellBRVpCVm1YLzNhcjNh?=
 =?utf-8?B?NkFiQWVBRmsreE44T1JuMnpZcitqWllLYTJ0NEVvZE94aVNrbERKT3pXb0tp?=
 =?utf-8?B?VVR1Q3VNdXVibTVwU2ZuWVRWYjlZQTErMTFON3lsUEtKZkp3ZTJGVSt2cHhx?=
 =?utf-8?B?VkpIUXZiV1dLeGRaV0J5Rm9teDFHMllrRlFFalNZQ29Tam9aT2lmdTJ1R2tp?=
 =?utf-8?B?Nmg5RThDUzI2aWsxUUJlRWU3K21IRngwb0diNWxoWG5ZYU1taEdRRFZnejMz?=
 =?utf-8?B?MmM0SXBXR2RBaHdKTmV6YXJTYTdySXhIYlRKbk5GekxOcEVFTFJxcjJUbDho?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8FAB49A6ACC77468D2664E15E2B4C60@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d48187d-a270-43ba-0783-08db68caf870
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 09:21:56.3376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axIX2bt3WmA9nZwDKD82f+d51Gm4q2IV+T9KSENgbjWK/AUOfZwW/y5we3XTWzUtYVzjpDJJxbsrxFBFjwNUrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5361
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTA5IGF0IDEyOjEyICswMzAwLCBBZHJpYW4gSHVudGVyIHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gIE9uIDkvMDYvMjMgMTA6NDgsIFdlbmJpbiBNZWkgd3JvdGU6DQo+ID4g
VGhlIGZvbGxvd2luZyBlcnJvciBhcHBlYXJlZCBkdWUgdG8gdGhlIHBhdGNoOg0KPiA+IDM2NGRh
ZTNlODBhNCAibW1jOiBtdGstc2Q6IHJlZHVjZSBDSVQgZm9yIGJldHRlciBwZXJmb3JtYW5jZSIN
Cj4gPiANCj4gPiBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jOiBJbiBmdW5jdGlvbiAnbXNkY19j
cWVfY2l0X2NhbCc6DQo+ID4gZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oOjI3OjQxOiBlcnJvcjog
aW1wbGljaXQgZGVjbGFyYXRpb24gb2YNCj4gZnVuY3Rpb24gJ0ZJRUxEX0dFVCcgWy1XZXJyb3I9
aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQo+ID4gDQo+ID4gZHJpdmVycy9tbWMvaG9z
dC9tdGstc2QuYzoyNDcxOjM6IGVycm9yOiBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlcw0KPiBw
YXNzaW5nICd1bnNpZ25lZCBsb25nIConIHRvIHBhcmFtZXRlciBvZiB0eXBlICd1aW50NjRfdCAq
JyAoYWthDQo+ICd1bnNpZ25lZCBsb25nIGxvbmcgKicpIFstV2Vycm9yLC1XaW5jb21wYXRpYmxl
LXBvaW50ZXItdHlwZXNdDQo+ID4gICAgIDI0NzEgfCAgICAgICAgICAgICAgICAgZG9fZGl2KGhj
bGtfZnJlcSwgMTAwMCk7DQo+ID4gICAgICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4NCj4gPiBpbmNsdWRlL2FzbS1nZW5lcmljL2RpdjY0Lmg6MjM4OjIyOiBu
b3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvDQo+ICdkb19kaXYnDQo+ID4gICAgICAyMzggfCAgICAg
ICAgICAgICAgICAgX19yZW0gPSBfX2RpdjY0XzMyKCYobiksDQo+IF9fYmFzZSk7ICAgICAgIFwN
Cj4gPiBpbmNsdWRlL2FzbS1nZW5lcmljL2RpdjY0Lmg6MjEzOjM4OiBub3RlOiBwYXNzaW5nIGFy
Z3VtZW50IHRvDQo+IHBhcmFtZXRlciAnZGl2aWRlbmQnIGhlcmUNCj4gPiAgICAgIDIxMyB8IGV4
dGVybiB1aW50MzJfdCBfX2RpdjY0XzMyKHVpbnQ2NF90ICpkaXZpZGVuZCwgdWludDMyX3QNCj4g
ZGl2aXNvcik7DQo+ID4gLi4uDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBjb3JyZWN0cyB0aGUgaXNz
dWUuDQo+IA0KPiBJdCBkb2Vzbid0IGxvb2sgbGlrZSBVbGYgaGFzIGRvbmUgYSBwdWxsIHJlcXVl
c3QgZm9yIHRoZSBvcmlnaW5hbA0KPiBwYXRjaCwgc28gaXQgbWlnaHQgYmUgYmV0dGVyIHRvIHN1
Ym1pdCBhIG5ldyB2ZXJzaW9uIG9mIHRoYXQuDQo+IA0KSWYgc28sIEkgd2lsbCBzdWJtaXQgYSBu
ZXcgdmVyc2lvbiBvZiB0aGF0Lg0KQW5kIEkgd2FpdCBmb3IgVWxmJ3MgcmVwbHksIHRoYW5rcw0K
DQpCZWdhcmRzLA0KV2VuYmluDQo+ID4gDQo+ID4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJv
Ym90IDxsa3BAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlbmJpbiBNZWkgPHdlbmJp
bi5tZWlAbWVkaWF0ZWsuY29tPg0KPiA+IEZpeGVzOiAzNjRkYWUzZTgwYTQgKCJtbWM6IG10ay1z
ZDogcmVkdWNlIENJVCBmb3IgYmV0dGVyDQo+IHBlcmZvcm1hbmNlIikNCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oICB8IDEgKw0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L210
ay1zZC5jIHwgNSArKy0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9j
cWhjaS5oIGIvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oDQo+ID4gaW5kZXggZTM1YzY1NWVkZWZj
Li4xYTEyZTQwYTAyZTYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5o
DQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oDQo+ID4gQEAgLTUsNiArNSw3IEBA
DQo+ID4gICNkZWZpbmUgTElOVVhfTU1DX0NRSENJX0gNCj4gPiAgDQo+ID4gICNpbmNsdWRlIDxs
aW51eC9jb21waWxlci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvYml0ZmllbGQuaD4NCj4gPiAg
I2luY2x1ZGUgPGxpbnV4L2JpdG9wcy5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvc3BpbmxvY2tf
dHlwZXMuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgYi9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jDQo+
ID4gaW5kZXggYjU4MmYxOWY4MmYyLi45OTMxN2ZkOWYwODQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNk
LmMNCj4gPiBAQCAtMjQ1NiwxNSArMjQ1NiwxNCBAQCBzdGF0aWMgdm9pZCBtc2RjX2NxZV9jaXRf
Y2FsKHN0cnVjdA0KPiBtc2RjX2hvc3QgKmhvc3QsIHU2NCB0aW1lcl9ucykNCj4gPiAgc3RydWN0
IG1tY19ob3N0ICptbWMgPSBtbWNfZnJvbV9wcml2KGhvc3QpOw0KPiA+ICBzdHJ1Y3QgY3FoY2lf
aG9zdCAqY3FfaG9zdCA9IG1tYy0+Y3FlX3ByaXZhdGU7DQo+ID4gIHU4IGl0Y2ZtdWw7DQo+ID4g
LXVuc2lnbmVkIGxvbmcgaGNsa19mcmVxOw0KPiA+IC11NjQgdmFsdWU7DQo+ID4gK3U2NCBoY2xr
X2ZyZXEsIHZhbHVlOw0KPiA+ICANCj4gPiAgLyoNCj4gPiAgICogT24gTWVkaWFUZWsgU29DcyB0
aGUgTVNEQyBjb250cm9sbGVyJ3MgQ1FFIHVzZXMgbXNkY19oY2xrIGFzDQo+IElUQ0ZWQUwNCj4g
PiAgICogc28gd2UgbXVsdGlwbHkvZGl2aWRlIHRoZSBIQ0xLIGZyZXF1ZW5jeSBieSBJVENGTVVM
IHRvDQo+IGNhbGN1bGF0ZSB0aGUNCj4gPiAgICogU2VuZCBTdGF0dXMgQ29tbWFuZCBJZGxlIFRp
bWVyIChDSVQpIHZhbHVlLg0KPiA+ICAgKi8NCj4gPiAtaGNsa19mcmVxID0gY2xrX2dldF9yYXRl
KGhvc3QtPmhfY2xrKTsNCj4gPiAraGNsa19mcmVxID0gKHU2NCljbGtfZ2V0X3JhdGUoaG9zdC0+
aF9jbGspOw0KPiA+ICBpdGNmbXVsID0gQ1FIQ0lfSVRDRk1VTChjcWhjaV9yZWFkbChjcV9ob3N0
LCBDUUhDSV9DQVApKTsNCj4gPiAgc3dpdGNoIChpdGNmbXVsKSB7DQo+ID4gIGNhc2UgMHgwOg0K
PiANCg==
