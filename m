Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725576DAB04
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjDGJj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbjDGJi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:38:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87219AD12
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:38:18 -0700 (PDT)
X-UUID: e9039bd6d52711edb6b9f13eb10bd0fe-20230407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GXCZGBYeiqjGvBNzo6mUnj9QhwcbZQcVbmJHZWurdsg=;
        b=ZyigQ2wXf3ZnoPmyhr7HQbNTXZORi1TocikjSQ78Tv9TaLQe7+oX8elWQx54fYS1f2SXVmerHfYxcI6W3PdDircxdjx6LPmX2qXsEZqvHOAZ6FDGy/nt7eyE9aQ5YBCAKmSFeNj7iKYLBb/Dh7fDGXuqvJA+T7HKClqGkhQlKWI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:51861294-f092-4834-bcaf-f147a8efe8e0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.22,REQID:51861294-f092-4834-bcaf-f147a8efe8e0,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:4a5011f8-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:230407173813APW34FC3,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: e9039bd6d52711edb6b9f13eb10bd0fe-20230407
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <bo.ye@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 940301205; Fri, 07 Apr 2023 17:38:10 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 7 Apr 2023 17:38:09 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 7 Apr 2023 17:38:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hps7eOy1pyexPbwANcB1ov2KFRvZElDGyWIEfyGi3Qp87/y/8Vb/j1rH8cDyVJCfRWNBixlpqTorcAl9hOszfL79nLN/5lhXk945iVcXYhaZerhKjZxnEgCPXrJ5Lw6VKUMGsWYe3LoDssacQxf9xA32V9xnPeAweM9JdQnYQFyN4+MpU+LJ5dKIvxovWyhpKyoZLXjtHSGn5ILd8R5is5h6RI4ncBpOSDKwhr2XmrZB8D5VEgkYKFGBP7a13VfTisODJj5+YEejplIL+ajoHJHaiDpqk9dM/Qd4h68sbWJBedXY085JDLrHCq+YzNzoklYlxsX4mJWurUZZy0OHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXCZGBYeiqjGvBNzo6mUnj9QhwcbZQcVbmJHZWurdsg=;
 b=cAKCl4nkH1tk3kyPsPo3asNrQq3bS+pA4+hNRQgaxsqvgi1v2EZXA2tKFur9V3MHMQkY4k5i2vIy9RsvPoAf+iFScrvf+TUwk//dteoBHfurFGCe9pOzwOCjtoMnEnc+Xky3a0w2POengP1nBuxwzuB1M0AHvkUTi+GYlvw2EEBAHO8vHAjMt18Ofef2yB2eEP/rCA32Xd6teTtcoChVb1fLZcHlc20TGFwgI8FoTzI4RfNBQ2WtZgQ88ZUnSZ2gSVA9GT78M2RnQvMD2oIycmhy1lq0UytP93zjRN7RFEJTy4nchwA9lKhWrh3+L0rtlB/pbuq/a47Nir1m6PVP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXCZGBYeiqjGvBNzo6mUnj9QhwcbZQcVbmJHZWurdsg=;
 b=PpGjG/dwhpodxNWEAWrP5l/y/JBK/zB9Ww9iR6FpPBu+bhcbR8ThsQT2kJOEW5Yk9NNJt5IICDxtQt75hg3+B+wqXt00M9NZyUx6RU9rFQsZD8ExWh49M4Yap7M0JxNSIcIRaeqwU/oyru2ACjh0pVCPGzKjAcWTba9wa1FN3A0=
Received: from TYZPR03MB5199.apcprd03.prod.outlook.com (2603:1096:400:32::11)
 by KL1PR03MB5861.apcprd03.prod.outlook.com (2603:1096:820:92::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 09:38:07 +0000
Received: from TYZPR03MB5199.apcprd03.prod.outlook.com
 ([fe80::5b7e:1aae:8ea4:22ff]) by TYZPR03MB5199.apcprd03.prod.outlook.com
 ([fe80::5b7e:1aae:8ea4:22ff%5]) with mapi id 15.20.6277.031; Fri, 7 Apr 2023
 09:38:07 +0000
From:   =?utf-8?B?Qm8gWWUgKOWPtuazoik=?= <Bo.Ye@mediatek.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "xiongping1@xiaomi.com" <xiongping1@xiaomi.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chao@kernel.org" <chao@kernel.org>,
        "qixiaoyu1@xiaomi.com" <qixiaoyu1@xiaomi.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?QnJvd3NlIFpoYW5nICjlvKDno4op?= 
        <Browse.Zhang@mediatek.com>,
        =?utf-8?B?UGVuZyBaaG91ICjlkajpuY8p?= <Peng.Zhou@mediatek.com>,
        =?utf-8?B?TGlnaHQgSHNpZWggKOisneaYjueHiCk=?= 
        <Light.Hsieh@mediatek.com>,
        =?utf-8?B?WW9uZ2RvbmcgWmhhbmcgKOW8oOawuOS4nCk=?= 
        <Yongdong.Zhang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?UWlsaW4gVGFuICjosK3pupLpup8p?= <Qilin.Tan@mediatek.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH 2/2] f2fs: add __pack attribute for extent_info
Thread-Topic: [PATCH 2/2] f2fs: add __pack attribute for extent_info
Thread-Index: AQHZY7L8yeXLd57CwkGDoMOta5hkwq8Vo3GAgAn+d4A=
Date:   Fri, 7 Apr 2023 09:38:06 +0000
Message-ID: <e9afd9e1901b4ae7cff4cb4a14483125d05163c9.camel@mediatek.com>
References: <20230331092658.72386-1-bo.ye@mediatek.com>
         <20230331092658.72386-2-bo.ye@mediatek.com>
         <ec3f83d3-c00c-17d5-c967-2e3e7a4798c7@kernel.org>
In-Reply-To: <ec3f83d3-c00c-17d5-c967-2e3e7a4798c7@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5199:EE_|KL1PR03MB5861:EE_
x-ms-office365-filtering-correlation-id: 4415784c-26c4-4795-2ee3-08db374bcadb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DNiB4Qkp6HC6CEGWKzHa71Ax4xYyRoGdIdoXsb/tgHywXse1F22vYjfILdnTu+NHqQgKMTPykH7MIwqCxznwVv4a8w0vLfauTOG61eGr3DCkaljr9nKudouCHAXS1+ftUPW92HEP9SPvu0n7NIyb3gHjdIvM6KR7qXdzOJcUl1Q5lO+Ph3GEJ0HK1bKnytsLMu6ZGl/dp9PJGjON0vN+JdCwxoWz5OReuQlPlGIX7SMOgEPHS5JGri5GiQM6CxnRJMTvVh4CkCsQ5UgicVxEjTo8iTUiWzi50G7t+78hgPtlbOzZ4vpvHOYbjLH6YNZ6qUFM60Zs0gxMKJXLkfyleQ2UwFpkjfpkWWu55q7vvHgM23JKvvtjXpJaN4iUMy+0jgch3ZTMseNkqqUaZDOx+C0VvoDBBzJQ0Zwj3/p8zsz1ihc7Z5kWUQQjr+a9o3bg5oy8q6qIxFX9xxiG19CQhnNs9OPoTn9A7QGdfCStEHAW1G1rOI9cG8XtMIedVz3nHF0rBHvhwvu3gGi/2fK5v4rdA/y2ElwTUDf9wd7Vv11BvCPaCsDaTJbpCEK4qjsYra3P+VhjMAW1xp306+DQWCB7exsDSys3DvRx0PihXVA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5199.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199021)(85182001)(38100700002)(36756003)(5660300002)(7416002)(2906002)(38070700005)(86362001)(122000001)(8676002)(76116006)(4326008)(41300700001)(64756008)(66476007)(66446008)(66946007)(66556008)(8936002)(6486002)(966005)(2616005)(83380400001)(91956017)(186003)(53546011)(26005)(6512007)(6506007)(54906003)(110136005)(316002)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlBBQWdwTnpnMi9BclByLzV0Y0pEQWtTUzc0NUcrZXBlSktGdzZTNGdLUFNO?=
 =?utf-8?B?blB1cXBzck51UTNZMDZtb2J1Z1ZVdTlNUENZT2FDbjhmb3JiNGRnM2RPK0R6?=
 =?utf-8?B?MnRmc0FZV3Myc3BzN0FGcWpYbHNhMUpvWC90aUZsaHBMSXhyQ2NVL0xoLzhz?=
 =?utf-8?B?K1dvTmoybXMzMm5HNWxHd1lCMEIzOVJ0alJmQTNwLzVCdDB6dWdKOFF3eW1s?=
 =?utf-8?B?YVFPc2hLVzhxdkQzN2tBT3kycWJhK2JUelRVS0syVkgrZUxzbUszSzlXSkFH?=
 =?utf-8?B?SGQrZ0hKNlc5U2Z0SWtyUWZFU2hGWEF1dGdzd2dFamZqZjVpL1JPT2FXQjhN?=
 =?utf-8?B?WG1IOU9Va21GdEdMMjB3TjZwdVJkaUtzR1E3NmdhU1Z0VFRFWlh4aVIvQy9q?=
 =?utf-8?B?aEFIM01BSkZmVmozanh4cmp3cmtxOFBoYXJ4OVJlZlhxV0VxWk1odng1bTBZ?=
 =?utf-8?B?eXRCUjVLa3JjM1VaVkM4S3JyNm91azF2bEtBMHNGdEF5eGl1dFAzQ1BZN1JX?=
 =?utf-8?B?ZjRIUGg1ajIxcldKV3U5eUZ6R1FFSjVUYWxaTytLdjRVcjNZMkhyTkw0NGNE?=
 =?utf-8?B?K2NaMXhSNWxMK3orMGxIdy9oR0IxNFgwNUtGVFNjU0ZLVkNYc04wbmxqS2xF?=
 =?utf-8?B?UFNXdDMwVE9JM0oxeHRBS1NtcWZ4bHYvMTZ2amFuckJLUzV6ZjF6c3F2LzZE?=
 =?utf-8?B?SWI0a3hwL205QW50dEpwQ1Q5akNvRHBQN2x6dEtYZU5OZlJsejAzZ05BbDJX?=
 =?utf-8?B?V1dZcHF4ZTNxR1MxcWNmd2xyb2czeXVZUzZyV1FTTXY1OHVGRFQxV3h6aW1Q?=
 =?utf-8?B?aVZUQXBCT2FLZEFtNk9SaE4vMllCUmZmQTl6UHVGNUpoVzJZUk1pU2VmVnJN?=
 =?utf-8?B?K2Zaejg2QXNBQkx5NzZsQ2hjWElCSFZDK0xxSFFyNHIzRlY5QnhpSjlRYVNM?=
 =?utf-8?B?NlMrVGQzaTVqL1UrNmRNYml6NlJnbjI1SjNPUmlvc1NwWlQ4ckpxd1hwL0hv?=
 =?utf-8?B?T1QzTmRhZWV2WnA2bkQ4SHNEeUsyaGdEdDdMSXN6Y0crYlkxdWY3dXZxcHlO?=
 =?utf-8?B?bnMraXJDS0xjckttT1VPRzQwQ25NaEt2dWhiN2E0enhMRmxnZHhWQTFSUHRr?=
 =?utf-8?B?S1hJYlA2UTkvOU5tenV3ZHVyK3ZnYTkxWmxrYU8wVUJZWHJSemM1QWh0RGpR?=
 =?utf-8?B?ZGVXeUFPY2lETHhVNTI4YTB6UnZoU0dkUEtNU01EYTFTcFUvcXloMnFQYVhP?=
 =?utf-8?B?b21EZE9PNFJ3ejZkMFh1UHY1Y1g5RUxBZTRRR2Qra0lTV0Q1VkRkeXdFWmQx?=
 =?utf-8?B?TVVGT05RS0h6eStUS2NOWFgzMTRNeldaWlEraXRYV3ZoT3dBVElHdEFWUHBt?=
 =?utf-8?B?cnlVN1dmUTR4bGNmZWhqTGQwbjVzSXlkVDlnNlRoaVRhYVRjalBOOVR6dS81?=
 =?utf-8?B?d0c0NllQeHNsVVZ4SVc2TGxLa2phLzFWT2I2cFBkOUxEL1VqOXVKLzFRZ0hG?=
 =?utf-8?B?Ukk2SWNyRGFqU2NLNkVudWc5VUgxMkVncTJ1THFGUDM3bDJJWmQ5QzJlaWhS?=
 =?utf-8?B?OHdQRlM1cE9lZUxEZ3dRLyt1aHNhakJ6eWxid3U2YlNGSnA5b1FVUWVwa3lS?=
 =?utf-8?B?MzRwNlNtV2J0TE52QVd0T3lUZGx5YUJiK2JvNUY3elVZaGVPY2k4VXBQK1FW?=
 =?utf-8?B?SmRSTTlNR2ZIbG1DcHdidG44dWtRbDRpSGZLRkVqdXpXQ1RLcG9NQmF1b0k5?=
 =?utf-8?B?djZoRjVabEMzSkQxeVdSTy9ZaUVsWVBOaFZtajRQMEp3eC8rY3h3OWFvbDNu?=
 =?utf-8?B?QkdWK1ljeGtqVndGSmpKT2thNFVHa2cxSDBNSzdjSnd2Zm84V2xaOHRldk1H?=
 =?utf-8?B?eFp3bE9zYU5sWERHRGtxWGxKTyt6bGJ2OFFMbUFFcDZVY2RieGREWTZxNkJ3?=
 =?utf-8?B?OU1Eb3NVRDc0U1dZc2NvWENJemFiWnpsUDVOMjJZTDdvRnNSMHFsdDE1YVFR?=
 =?utf-8?B?Qm9jcWEreCtwZXA5ZFZHUXJ1MmQxS0dMNnpOK1luVEdmaHM4UTJ6ZFZWRmtJ?=
 =?utf-8?B?Y0lqVWF5S1d1eTVWalNQTVlDaWd0S2d5M3VPdzFwRU9RTkFYeUlFRlJuNUdC?=
 =?utf-8?Q?qBZFZCZ4SVadBQy15fxo8RmnE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39AEB4074898F04580EE74C86B74E71C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5199.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4415784c-26c4-4795-2ee3-08db374bcadb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 09:38:06.8254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwAfC9T18g0q0FhPGOcweLUfZxKr4T6jSVnFDR/38qnL1NBYluB9EtanVuwi3yptFIpzdPBsPQPT6uVX6COXmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5861
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA0LTAxIGF0IDA5OjAwICswODAwLCBDaGFvIFl1IHdyb3RlOg0KPiBFeHRl
cm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0K
PiANCj4gDQo+IE9uIDIwMjMvMy8zMSAxNzoyNiwgQm8gWWUgd3JvdGU6DQo+ID4gRnJvbTogUWls
aW4gVGFuIDxxaWxpbi50YW5AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IE5lZWQgYWRkIF9fcGFj
ayBmb3Igc3RydWN0IGV4dGVudF9pbmZvIHRvIGFsaWduIHRvIG1lbW9yeQ0KPiA+IGxheW91dCBv
ZiBzdHJ1Y3QgcmJfZW50cnkuDQo+IA0KPiBKYWVnZXVrIGhhcyBmaXhlZCB0aGlzIGJ1ZyB3LyBi
ZWxvdyBwYXRjaHNldCwgcGxlYXNlIGNoZWNrIGl0Og0KPiANCj4gDQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1mMmZzLWRldmVsLzIwMjMwMzEzMjAxMjE2LjkyNDIzNC0xLWphZWdldWtA
a2VybmVsLm9yZy8NCj4gDQo+IFRoYW5rcywNCj4gDQogIE9LLCB1bmRlciB2ZXJpZnlpbmcsIEkg
d2lsbCByZXBseSB3aXRoIHRlc3QgcmVzdWx0LiANCiAgVGhhbmtzIGEgbG90IQ0KPiA+IA0KPiA+
IHN0cnVjdCByYl9lbnRyeSB7DQo+ID4gICAgICBzdHJ1Y3QgcmJfbm9kZSByYl9ub2RlOyAgICAg
LyogcmIgbm9kZSBsb2NhdGVkIGluIHJiLXRyZWUgKi8NCj4gPiAgICAgIHVuaW9uIHsNCj4gPiAg
ICAgICAgICBzdHJ1Y3Qgew0KPiA+ICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgb2ZzOyAgIC8q
IHN0YXJ0IG9mZnNldCBvZiB0aGUgZW50cnkgKi8NCj4gPiAgICAgICAgICAgICAgdW5zaWduZWQg
aW50IGxlbjsgICAvKiBsZW5ndGggb2YgdGhlIGVudHJ5ICovDQo+ID4gICAgICAgICAgfTsNCj4g
PiAgICAgICAgICB1bnNpZ25lZCBsb25nIGxvbmcga2V5OyAgICAgLyogNjQtYml0cyBrZXkgKi8N
Cj4gPiAgICAgIH0gX19wYWNrZWQ7DQo+ID4gfTsNCj4gPiANCj4gPiBzdHJ1Y3QgZXh0ZW50X2lu
Zm8gew0KPiA+ICAgICAgdW5zaWduZWQgaW50IGZvZnM7ICAgICAgLyogc3RhcnQgb2Zmc2V0IGlu
IGEgZmlsZSAqLw0KPiA+ICAgICAgdW5zaWduZWQgaW50IGxlbjsgICAgICAgLyogbGVuZ3RoIG9m
IHRoZSBleHRlbnQgKi8NCj4gPiAgICAgIHVuaW9uIHsNCj4gPiAgICAgICAgICAuLi4NCj4gPiAg
ICAgICAgICAvKiBibG9jayBhZ2UgZXh0ZW50X2NhY2hlICovDQo+ID4gICAgICAgICAgc3RydWN0
IHsNCj4gPiAgICAgICAgICAgICAgLyogYmxvY2sgYWdlIG9mIHRoZSBleHRlbnQgKi8NCj4gPiAg
ICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBsb25nIGFnZTsNCj4gPiAgICAgICAgICAgICAgLyog
bGFzdCB0b3RhbCBibG9ja3MgYWxsb2NhdGVkICovDQo+ID4gICAgICAgICAgICAgIHVuc2lnbmVk
IGxvbmcgbG9uZyBsYXN0X2Jsb2NrczsNCj4gPiAgICAgICAgICB9Ow0KPiA+IH07DQo+ID4gDQo+
ID4gVGhlIG5ldyBmaWVsZHMoYWdlLCBsYXN0X2Jsb2NrcykgYXJlIHU2NCBpbiBjaGFuZ2UgNzE2
NDRkZmY0ODExLCBpdA0KPiA+IGNhdXNlIHRoZSBtZW1vcnkgYWxpZ25tZW50IGJhc2VkIG9uIDgg
Ynl0ZXMgaW4gc29tZSBjb21wbGllci4gU28NCj4gPiB0aGUNCj4gPiBmaWVsZCBmb2ZzIGFuZCBs
ZW4gYXJlIGFsbG9jZWQgd2l0aCA4IGJ5dGVzIGFuZCB1c2luZyB0aGUgbGFzdCA0DQo+ID4gYnl0
cy4NCj4gPiBJdHMgbWVtb3J5IGlzIG5vdCBhbGlnbmVkIHdpdGggc3RydWN0IHJiX2VudHJ5LiB0
aGUgb2ZzIG9mIHJiX2VudHJ5DQo+ID4gcG9pbnRlciB0byBhIGludmFsaWQgdmFsdWUgYW5kIGNh
dXNlIHdyaXRpbmcgZmlsZSBmYWlsZWQuDQo+ID4gDQo+ID4gc3RydWN0IGV4dGVudF9pbmZvJ3Mg
b2Zmc2V0IHNob3VsZCBiZSAxMiByYXRoZXIgdGhhbiAxNiBmcm9tIHRoZQ0KPiA+IGJlZ2lubmlu
ZyBvZiBzdHJ1Y3QgcmJfZW50cnkuDQo+ID4gDQo+ID4gVGhlIG9mZnNldCBkdW1wIGZvciB0aGUg
YmFkIGNhc2UgYXM6DQo+ID4ga3dvcmtlci91MTY6NjoNCj4gPiBbbmFtZTpmMmZzJl1mMmZzX2xv
b2t1cF9yYl90cmVlX2Zvcl9pbnNlcnQ6TVRLX0RFQlVHOiBpbm89MTYyOQ0KPiA+IHJlPTB4YzY3
NWRjMDggb2ZzPTAgcmUtPm9mcz0wLCByZS0+bGVuPTY4IGVpPTB4YzY3NWRjMTggZWkuZm9mcz02
OA0KPiA+IGVpLmxlbj0yNzcNCj4gPiANCj4gPiBGaXhlczogNzE2NDRkZmY0ODExICgiZjJmczog
YWRkIGJsb2NrX2FnZS1iYXNlZCBleHRlbnQgY2FjaGUiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEJv
IFllIDxiby55ZUBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUWlsaW4gVGFuIDxx
aWxpbi50YW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZnMvZjJmcy9mMmZzLmggfCAy
ICstDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9mMmZzLmggYi9mcy9mMmZzL2YyZnMuaA0K
PiA+IGluZGV4IGIwYWIyMDYyMDM4YS4uN2M2OTA2NjdhNDJmIDEwMDY0NA0KPiA+IC0tLSBhL2Zz
L2YyZnMvZjJmcy5oDQo+ID4gKysrIGIvZnMvZjJmcy9mMmZzLmgNCj4gPiBAQCAtNjYwLDcgKzY2
MCw3IEBAIHN0cnVjdCBleHRlbnRfaW5mbyB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHVu
c2lnbmVkIGxvbmcgbG9uZyBsYXN0X2Jsb2NrczsNCj4gPiAgICAgICAgICAgICAgIH07DQo+ID4g
ICAgICAgfTsNCj4gPiAtfTsNCj4gPiArfSBfX3BhY2tlZDsNCj4gPiANCj4gPiAgIHN0cnVjdCBl
eHRlbnRfbm9kZSB7DQo+ID4gICAgICAgc3RydWN0IHJiX25vZGUgcmJfbm9kZTsgICAgICAgICAv
KiByYiBub2RlIGxvY2F0ZWQgaW4gcmItdHJlZSANCj4gPiAqLw0K
