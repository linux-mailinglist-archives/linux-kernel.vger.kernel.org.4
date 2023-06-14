Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D382D72FA42
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbjFNKUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjFNKUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:20:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C49DE5;
        Wed, 14 Jun 2023 03:20:10 -0700 (PDT)
X-UUID: 8fc8550a0a9411ee9cb5633481061a41-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=bMNyFQlBXJvvGIcK04soGbuF1RUaamcN0ge9kpdSx1E=;
        b=EVd4EV/Q6slaZFMuEykCTEL/DHTXblZCU9dvtbm+Nga6C/8rPmPEN9Wh5e6rPa1MwspfBqfUF3ao3whcxbxXxIlcbWcUD6cDd3EvbfLaexpOj37JsHJBHkGftANDa5BOJNSBhuoNTvuQa8OZVOUWV7uCW3ez/Rx3uaFw1ElYIeM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:47db475f-98e7-40f2-9a53-702e0ac157be,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:43f5963e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8fc8550a0a9411ee9cb5633481061a41-20230614
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 318422139; Wed, 14 Jun 2023 17:19:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 17:19:26 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 17:19:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcvPyMVvtAdjezp6/iCmMD6HolnFc/PQlk5prUDL63qMOFsZl4X1Elh6s/aQq3hEbe1GV8JzQuzsQjyzRvXHqj+hUJ++gL8I8VNrWVHcd82/urNz7BhxDUG5czTyn88dEXWm2MTmTrmPHqaGQQd6bkh8Z7SlYZmrOEHHwv2g7/nc2cX/w8hB+QMy8/CdRd7EvbPWq1+O5GHLXtvdFub96hx7aNDjua88hw1Ay+DqjRYb1SOvm7yaSb9t39fP/gquiiA5Z3qAn2vOksMj1Y9WqaWIVSsf83kJ2MetSwIr8RLb7Z1PyZcNZKh/Ztc5iSliDtZJpMTRPdUnh9kD0sgsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMNyFQlBXJvvGIcK04soGbuF1RUaamcN0ge9kpdSx1E=;
 b=M/n47db7PYL1mbvHe+ezKoT8jbHRWoGbSfkKIJ0DhBvUEcgE8yIaKleYTpII3kZjRqNwI7oAkFrMSkQYvLVvxd22wnqhIAger3pJ4eOqNjNsqkJwx5YbSJztgsTm2SJ0GKd7DsVzrx5T042uB0YP5kXfnrujsyLQs6Q6lNt/2UFzq2Uzp7bdtDb/YLniSiMXW1Hg+P6g80krs1wPByCTSKr42RrKsb7KRlz5F5tDEAawO24oVCMlGmld925KRR8aKMZZ17a1itrZ59Oka+azHPG6y3De4//lZTE1AADShzECxI0We9oEzDU6SWkMk9/Ig0A2ULl7WKWCGc4/GcsEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMNyFQlBXJvvGIcK04soGbuF1RUaamcN0ge9kpdSx1E=;
 b=ZaVc688DxW6HbuDNGCRqtTfqJkycCDu+scaoo02Qcq7vG9J2uOJwugeF40+sNJ4nHoUlhZQIBd2gI35EMjEttYSAMERgnTMBtd1Ei5XObloxeLrjjnvEIWRqqefUIbYfRJAQtweRPsYkS30JSy2O+7EWSfIRhb+JfbOBknqva9M=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by JH0PR03MB7935.apcprd03.prod.outlook.com (2603:1096:990:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 09:19:24 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::cf4d:1ca0:d375:a32d]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::cf4d:1ca0:d375:a32d%3]) with mapi id 15.20.6455.043; Wed, 14 Jun 2023
 09:19:24 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "perex@perex.cz" <perex@perex.cz>,
        =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt79xx-afe: add audio afe
 document
Thread-Topic: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt79xx-afe: add audio
 afe document
Thread-Index: AQHZnRwwFFXmmj8e60u4F1KEKx4v7q+IblCAgAE08ICAADcngIAAEWUAgAAMWQCAABA/gA==
Date:   Wed, 14 Jun 2023 09:19:24 +0000
Message-ID: <0977c72a4f63132104736b9de8aa8246abb34894.camel@mediatek.com>
References: <20230612105250.15441-1-maso.huang@mediatek.com>
         <20230612105250.15441-8-maso.huang@mediatek.com>
         <d9cd1ff3-b537-1481-9453-5b3683d30fed@kernel.org>
         <14913cbb87981eed6f8b72f9e659ed3e25958320.camel@mediatek.com>
         <d6289232-6276-a2d3-c059-1edcef6a1b6f@kernel.org>
         <a338bf978dfa0af84a6728ab66dc51e45a20c7c4.camel@mediatek.com>
         <4305b7f0-bbc8-f913-d9b1-d7b492df7ef4@kernel.org>
In-Reply-To: <4305b7f0-bbc8-f913-d9b1-d7b492df7ef4@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|JH0PR03MB7935:EE_
x-ms-office365-filtering-correlation-id: 5384d283-fa69-470d-34a3-08db6cb871ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wW/6Wrgr5Fh9TxI1ssTfWE1sE0EZi7pev9jW+JkCCrTEUD8RBGsztVZbasRFNK9lILdETwQQ1Ek6j/R7+AhRJSlC7ECZ3WYZOUAkJrqwTT8OyaR7zxtKAjjGLFo3ydch8I934jsOzqdpkY5ear3BAC2vESW59ne5tVSrTVX4iJbjowklRR73mbB6L5H5QjpBaKL3IFB8VDY2vhFqQYdsClZt7WhdxB3HX8zuLvDO1GvCKFKdgIWjVV6hxiDWSICM0O8Yf7Hg11fCvowPV7MZls5psSP568JqjKKTEpOcHJsMiQ0o2zOrWgZBoCpYKDe/+RskgNvJaEohYEH8L/n4bRngAVJnT6/uLp5KlnalDzqkpNRYd48wF6p7vjyTZfcdn7Q3E/sJp2VgITz5ip6XmMJ3R823dg6Wa7jZ2j1CDXCgXNj0GNmgWSDHRe88uZbITJkcZ2/U/Ag62Ds+YoIKqMI/2vza15T7IB/eWh2t44Z8cVfNQACEBadIktUB8mSxeA8R2v3AYTrJ9yj+XMy/drNUSNBQOSOuTEaG1JLX2r+hCPHzTx2zfoqYMkWFwDZ5EsfmDcnYvULT9jtvfoO+HC/r7JBiOQVrVekvd546vXNvbefnXS/giknBwp3AALtC4tD/KAZEQAvaYj0kYUY/oQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199021)(8676002)(66476007)(66946007)(66556008)(76116006)(478600001)(110136005)(91956017)(5660300002)(85182001)(36756003)(8936002)(6636002)(66446008)(64756008)(71200400001)(316002)(41300700001)(6486002)(38100700002)(921005)(83380400001)(186003)(6506007)(7416002)(86362001)(38070700005)(4744005)(26005)(53546011)(122000001)(2906002)(2616005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUF6YnBSczdrT2VQc1FkVC9iM3V5TUJmMWdVdDY2VXArTWNadWQzbU8yQUZa?=
 =?utf-8?B?VFZsT3MyK0tkb3lKTnBKd1JnQlNNVE5CTUJvRHdreEM4ZDc0VGNTb0lBL2lT?=
 =?utf-8?B?bGsrd2ZvNTVleEdsU1NWLzFqM1Zod2U5dllsbnZtNFd1NnR3dzJsMnk4bEdI?=
 =?utf-8?B?aFpvWWJMS2lyWUNDUW84K2sydld6Vk5mOHNmcTE4ZHdaOXY5Y1pjUlZzMUhP?=
 =?utf-8?B?eFk4ajBHNDBIbys5bDZrZFM4U3ZhNk94d2x0SjQrZGN5ZWxadExwbWZUaDhk?=
 =?utf-8?B?RUZEMFZFOWgzWkgvcG1GaU1zbjRFRUJrWlFmYThDa0h5M1I4YmJuMmRzSWdh?=
 =?utf-8?B?U1lvTXVKeGZKMlNRNzJhWWF0cytXTldIcWx3b3hLUVZaYlFVUzBWMFpMa2ZB?=
 =?utf-8?B?NDQ4M0Z4RExjN3NTVFQvQmwzOVUzMGFaT2Fpcm5DWk9udWF0VjVkSkdVbmRq?=
 =?utf-8?B?aEVMZ3psSUxMSGYwM1VVelM0QjlhRVNLZG1MUW1vRTJEWmtYcnJHNFBqaGZj?=
 =?utf-8?B?S0tHTSt2bkRUNy9nWXlSRC95Wi85V1hxTnFLU3FyV2pnSGVBVE5VTk9QV0Ni?=
 =?utf-8?B?aHhOZVBITGtvRTZHZHNmVnFNYjU0TW5uL3hIMktSd0JxZlMrQ1VWdCthL2FZ?=
 =?utf-8?B?YjRZdkxUZ3hENmI3UDNpczU0RVFQcCt6OUxHMjNIS2F1V29IZFA4UlZMTEpz?=
 =?utf-8?B?VWk4VndTdnh2eWRtc0JrU0tSRXlOYjFhd0c1aUNiKzdheW9EVGhLUkRJV0xZ?=
 =?utf-8?B?MUtmTS9xQ2ZIZHN3ZmxjL1JqNjNQeGJYeXo2YWdvNEp6UHU2a1ZiNW9XRW1i?=
 =?utf-8?B?bE0yUkd5MjhINWNucnQxZUZaYkQ3MDhVVEZnZEN4NW1nK2hEeHJVdlNIOU1M?=
 =?utf-8?B?Z0dqbEhxeXpoS0g0MDdDRFMrMDJqdXJxWTBaYzVFdU1mUThBSzc5TDRJdXpa?=
 =?utf-8?B?dmxHTllHSDRVNmNUazdIdFgyN2Y3bXZKTXRyNG15aVg5WDFXbTRLa3hzczZG?=
 =?utf-8?B?VGEwSnlaMzF0T3FkekF2c2FRRzQvQkc0UDQvYXMzb0sxWHdJMzAxN3VUK1lY?=
 =?utf-8?B?a0NROW0rVEw5bXg5aXp2eGI0bnRGb3VsTWw3WUU2QkZVa3YyZUg1VjQrTjVo?=
 =?utf-8?B?dEIvUVhLbU5RMFF6Ull1Qk10Q1Jaa3cvQjBmbzVrVHhVU1M0RUxkTmhSQ3NK?=
 =?utf-8?B?ZjlBVGtGaFRlSW13SHQzN0dhQzRLL2NQdG9GcllodHBva1lYcWpKNm42eVor?=
 =?utf-8?B?SkpGTFZrRUFVRnZ6VndLWjI5OHVOT1RUd1AwN25yUFlpZlBJK2dVYlhNWVN4?=
 =?utf-8?B?b1RlUXh1V01zVlprR2M0elMyNm5zUzV2RDQveG9jMVd3U3RSK215OHNUQ0Mx?=
 =?utf-8?B?a2xpaWgzRjg0eEx0bnlHNHNZVm9IZ1pDeEVTdzRjdVZqMmlSMjhzQWNyVUdP?=
 =?utf-8?B?cWpvVC9zWjFaVDY3UWcrbDR0ZnR1WUk4bWJhV29JdDMva21WOHFOMXhXVU5k?=
 =?utf-8?B?Mm5PdWNBYzlQQUlrakpWdUlSWU5BejY5V2ZwWUtqTk56NjZQcHRhTm1DQUJr?=
 =?utf-8?B?b0tPWTVteXZPcXpLWUxNeTNPOGVLaDlwK0F1K1F0RUZLbEt0Z2xIYzFEdm5y?=
 =?utf-8?B?aHdhamRibGJDYVI0V3BpZ1FHejdOcGZSblN3ZnpDdDh6RDdmZVdUWkdReFFo?=
 =?utf-8?B?VUdldjh6ZmwvR0V3NjVHUXRJak1sMnBDNzNmSUhXbVlJRjFxS3ZpSFR0RkR6?=
 =?utf-8?B?Ym9sSmxFM3hkTTh2dHJUMFBXbDVXNDFRWlFNVFpkTGtIQ0d1UmdxNXR1NHZB?=
 =?utf-8?B?SXdaNk1UeU9qTVdlaytnd1lHZ0RUY08rRW9nU0U4YzdPZENsbzdscnFSakN2?=
 =?utf-8?B?bUJVSzY0T0VubFJRc0VwTWxUSndXdkpnbUhBYjU2OWpYWE1vWlI2L0syRi84?=
 =?utf-8?B?MlVtQnN5UnJSekNLOTRaRkFDdVJHRGh1a0lSNE5mNkFGN2pFREE1SjI2ZGdH?=
 =?utf-8?B?U0xvQnpCOHNuZFNLOWE3ckdmMWxHYUV2cmVtaHl3bDc3aFZsbzlaWW1YQ0NC?=
 =?utf-8?B?d0ZYVEFqSVJnQzZxZ2UxSzA1OW4yWHhuMHBpU2x2dnpueU9jNUFoZkkwdEly?=
 =?utf-8?B?bGNQbStYZU5RK1UvbE5TeVlmN3lNK215V1MyQlFxeTRQSUlOWVB2Ti9PQytF?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FE85B3D638B9D43BBDB17E9191A4C65@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5384d283-fa69-470d-34a3-08db6cb871ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 09:19:24.3936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYso4CV3vnDB8JdXaY2dTrzgtTGE8Zdh8Ack5O6jKR4tEKu1EwllMR46euS69t25bEw/7OiwpGZFQE0iiZCkBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7935
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDEwOjIxICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDE0LzA2LzIwMjMgMDk6MzcsIE1hc28gSHVhbmcgKOm7
g+WKoOeruSkgd3JvdGU6DQo+ID4+Pj4gSSBhbHJlYWR5IHNhdyBBRkUsIHdoeSBpdCBjYW5ub3Qg
YmUgcGFydCBvZiBleGlzdGluZyBiaW5kaW5ncz8NCj4gPj4NCj4gPj4gQ2FuIHlvdSBhbnN3ZXIg
dGhpcz8NCj4gPj4NCj4gPiANCj4gPiBEaWQgeW91IG1lYW4gbXRrLWFmZS1wY20udHh0Pw0KPiA+
IElmIHllcywgSSdsbCBtb2RpZnkgbXRrLWFmZS1wY20udHh0IHRvIHlhbWwgZm9ybWF0LCBhbmQg
YWRkIG10Nzk4Ng0KPiB0bw0KPiA+IGl0cyBjb21wYXRpYmxlIGxpc3QuDQo+ID4gDQo+IA0KPiBO
bywgSSBtZWFudCBtZWRpYXRlayxtdDgxODgtYWZlLnlhbWwuDQo+IA0KPiBBcmVuJ3QgeW91IHdv
cmtpbmcgb24gc29tZSBvbGQgdHJlZT8gSWYgc28sIHBsZWFzZSBkb24ndC4uLg0KPiANCj4gQmVz
dCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCkhpIEtyenlzenRvZiwNCkFGRSBpcyBjb21t
b24gbmFtZSBmb3Igb3VyIGF1ZGlvIGhhcmR3YXJlLCBhbmQgdGhlIGRlc2lnbiBtaWdodCBiZQ0K
ZGlmZmVyZW50IGZvciBzb2MsIGxpa2UgY2xvY2suDQoNCkFuZCB0aGUgZGVzaWduIGlzIHRoZSBz
YW1lIGZvciBtdDc5ODEvbXQ3OTg2L210Nzk4OC4NCklzIGl0IGJldHRlciB0byBjcmVhdGUgYSBu
ZXcgZHRiaW5kaW5nIGZpbGUgbWVkaWF0ayxtdDc5ODYtYWZlLnlhbWw/DQoNCkJlc3QgcmVnYXJk
cywNCk1hc28NCg==
