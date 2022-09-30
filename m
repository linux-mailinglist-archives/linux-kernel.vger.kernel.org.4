Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBBD5F043B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiI3FeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiI3FeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:34:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1F927161
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 22:34:08 -0700 (PDT)
X-UUID: 1bf54e7bc19e43219efe923f6ea02063-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2qH3UgWbXo6yd5tdaIhbkOFgs1/baste4h5JiGtaTvE=;
        b=AoJyBwTeurz9NBr0qfCsZNovtm/3AO9N4Jl0Qf3Y7rzXfZvYFTUCzeCGkunW1TYusR3apohRS7aSaq6ZutWfpy72rca6MT2S2yIGryRoWziw8L/jXyZeUxE4WjQWU6zEP+tCqFGLJ4JHT6cyMQM1lmXyYvD1wWsEQSp3W838jvg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:361cd5f6-29e9-4e9e-b914-f04617858e8a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:759abde4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1bf54e7bc19e43219efe923f6ea02063-20220930
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 862616096; Fri, 30 Sep 2022 13:34:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 30 Sep 2022 13:34:04 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 30 Sep 2022 13:34:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWlzRopKOAMQD2R3oE4hHlwKHUu5S86Af2HMNjRH/Ch/jJ0SU061Kpk8Qw4ReMbE25VWlT1dkUvyyRPOOrQKIs2wrIuFFkJpMOvtSIR1lH8kNJ+PyWSVIj/i8BfM8ESBOn9NkueUturzoMeC/PoFBLI0cko4CokVxSe+2kHTxYI4d3OaHOBhcezL5VckOs38cHcxtXH+N86bVY8/MoMVjNcymtvCK3efo0MAj9jyqb6aiHe8+0wq13IGv50XKiBO+tAUORtDVnyaQwOfkuRqoPqWQHKbmICkikGchsaHU0QH9z2yc7qBr6AaXv0zTICQnxjjMeDD9+cvbdNtELKgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qH3UgWbXo6yd5tdaIhbkOFgs1/baste4h5JiGtaTvE=;
 b=AVI2nZBvb/JjCpr/mbFfxKAYnZilZm20FDPGcxzcg6Mw/v6TxNHSFN4EXCk68zTjLdza6C0O8hO1q6dolu8q5YBdHg2JPI9uS3sIt9PEkfM/VouuY6NaCLgP/3Qx0XCtXut0w+9QsS0v7r8iAE6nHNpQZD5tYWhV7p/luWbkhMnlNEinuLV+DPaqaew2iEisQ7cLwzW3y5pd3xOWas6a+E5cNot1ChynUkCbLYzhbXjezzFXRsmo+Yt4ukWLM8vabyXx7ooayp0bfw/O+tgyviw0grycjmUVtXD6O/MfRNpug73YfeH5ngyFbye9YTQ/3p7G2rIC8vmBITtAXaTJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qH3UgWbXo6yd5tdaIhbkOFgs1/baste4h5JiGtaTvE=;
 b=H9mGYdFC6xJv1i+oDmoxrl4JRK5zSFkMoAtZaQ/Iq8kWhnJmRFfgep1wgC5ld++oHEcyB732P/zTQIdNuRYzuSYi2HdZ40sE3d3kJyvYWIDrwxFidpaWv3oKzKMNg1Nc7Dr2aFN78TYGZn8iTkYLabe9QFtGfjSZSLY8VaYxy8w=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SG2PR03MB3338.apcprd03.prod.outlook.com (2603:1096:4:17::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12; Fri, 30 Sep
 2022 05:34:02 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b958:c9e0:9f6d:9ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b958:c9e0:9f6d:9ed%7]) with mapi id 15.20.5676.011; Fri, 30 Sep 2022
 05:34:02 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>
Subject: Re: [PATCH v6] mailbox: mtk-cmdq: fix gce timeout issue
Thread-Topic: [PATCH v6] mailbox: mtk-cmdq: fix gce timeout issue
Thread-Index: AQHY0xKI77un3YsFmUmxPIS9MeR22q33dliA
Date:   Fri, 30 Sep 2022 05:34:02 +0000
Message-ID: <b0e6194b5ed557b43e35c13ac3f41ef33170dd7d.camel@mediatek.com>
References: <20220928081546.31950-1-yongqiang.niu@mediatek.com>
In-Reply-To: <20220928081546.31950-1-yongqiang.niu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SG2PR03MB3338:EE_
x-ms-office365-filtering-correlation-id: f88a1e78-71ad-49c1-ad4e-08daa2a561ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H3V6R1BfVDl9CPplbkXoOYv8bKjA4SasnVpG7GrP2Zlehbe1eQtTiPmDX4rNNIn1Fn3UNU0inPfbKlsS7KsF2k50aN4dmcScZnUfyoLCiF3YQecbeXtHQV77qFrMh1CNBNwR1VE7hzC9h2R00CogBE/TGLt/Zpyva/cyBj00JhzjI/9OIsd3rlVF5tfJfq9o6UxEgB5zPlJTjPLZlnkvV5M4ijMgCuQfkkgeA4sXLybheO1GaRhK0+qDDlHvoehbL0RUJ/mh3W+8h9jKsE4bzjCdIvSi2Bl7wQEXKmGzooJYKhzP3pT851mRFgiFt0uvhUW+xRb27eIsBKPPFN8vdazglyM+6I86GjQ+jiAwqS9MlHEQCrZfgenajDEdnd8+FMBybETz5svSc1Wg0PQkhmhanvtz9sUmb6myqJA8LFjnW4U0ln0q5kR8xGbxTiLp8RXCAcz9qCb+vktw+LNxdfzae9nyBzzh9/QiLxWChkhYCIZfsDytEpsoJbSm8qAkb92G2Vd0Nya0BM/ltroC4nP+nmsJCc20p2m6aTCGie9DWDW46j6sQCGSPTO99GLWm06xGKD8DmTGd/A+jjTVoX47LT+Ya+uYOm5SDi1ZcN+MgDv1o8yBu3orHW72PNzOJHKrImPYueCCDd9qvCHp22+TYZdWQxo70x9sKueJcQF219OkiWTREJsiQvpzwzcLpSNvs9xI2yaD9JYUy+TRKqBVxB5HkwnpayAndp7xJRisfIJUxsAANH9yTCZW5OmNcWpEC+TfwMARvV0ZAwEEnSUBoEmK38P+vX2bOIZcBRo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(15650500001)(122000001)(186003)(66446008)(83380400001)(2906002)(36756003)(85182001)(8676002)(91956017)(66946007)(64756008)(66476007)(2616005)(66556008)(38100700002)(76116006)(54906003)(8936002)(86362001)(316002)(38070700005)(26005)(478600001)(41300700001)(6486002)(6512007)(71200400001)(4326008)(6506007)(5660300002)(84970400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUNQR2s2M0dmTkpLbnFxZEQyaW8wM0ZNMTdwYS91R0RLOThGY01iUUZERXRp?=
 =?utf-8?B?VGJGV0xRZ2hJOWFoVXFKTm9ueHZlV3BUMGNUV3R2cWhrY2l2UHJ2SjdhaFMy?=
 =?utf-8?B?K1ljTE5VY0VLRng4MzAwMzh1S3ZDdnNCZnNjWGFGK25qRWJtVUFQOFdDTkJS?=
 =?utf-8?B?dWF4OW5peVZPbjRhOFI4bDhLRW92cXFtOG1lTzVvYkt5WUY1YUF2WmxNTzdn?=
 =?utf-8?B?NUtrR2lpa205SWNwNW9jdjRjNFNDdUJvY2tQVlgvLzhsdTNodUY0UUVoSnVu?=
 =?utf-8?B?dDA4RGVOckNQc2lJWFEvUzZubUlPbC9INi90Y0xsOWh3NUhnNTdVQXJWaWZU?=
 =?utf-8?B?RFBXR2JubEVYaklnUmRtdUwyeXNaeS94eVZZTlVVK3lBeW5LTDZnUWkyY05E?=
 =?utf-8?B?cnhjeU1zZXdpWEJiUmxkTVc3Z0lDZjJ4NHJhNnZERDVsUGFoVk1DQ0pDK0J4?=
 =?utf-8?B?NjR0L0p1Ky9nbGxoeEpXTWJiNGw0aVNLdndrbkFxam4rd2V0cGI5blpGQ095?=
 =?utf-8?B?bmhiVlVxbC91ZGJXY3gzRWo4VzVFOGFRSG9ST1FSekdnVmFxSUV6M0lZUit2?=
 =?utf-8?B?USt6NzFadTZ3N2diaDRJSWxPZmZRclQ5V09wRkdLcnJCRjl4OVZTckZEYWZO?=
 =?utf-8?B?UDBVdFBHTC9FS09IMFJyWkRnUGhuR21aODlRWnI2K2FJUFIyTHJYMWtrUVhN?=
 =?utf-8?B?WjlldUVoRVJ0M2FCc0luWndjUkRoSnJVUDhWREJUb0FiN2pGdVRkcFhqRERB?=
 =?utf-8?B?UE5NeDZjcFA1L3dWcEQycnhWNjVsTlhSeG9WYjc3Ly9LTHc4RXY5c1pwVHpF?=
 =?utf-8?B?MzUzZm9LakVidzM0TFlHSVNhSm1SZ09aNlcrb08xams2bW1GdGRpcWdEWUFa?=
 =?utf-8?B?bU5GazVzMUpQeTZVL3JRdS9NYmU2anhpakxLWmcxUy9LbUlqUWtJVmtES3pT?=
 =?utf-8?B?WmNsS3NsTXFxeEx3dXlPNWQ1MEkyYmJNOGIyOXF4WTNMSUNkV2c0ZzhFRGs3?=
 =?utf-8?B?MVl2MDFiOFRqaHp2YUxISUNyZlB2MDdqTTZDdExPRjlIVkwxTlVJT0V1cWtQ?=
 =?utf-8?B?SEhvZ2g3TERBaGowT0gvWVB3SzQvYlpZZjg4c0s0ZGVub0JvS3ozRUNXMmNh?=
 =?utf-8?B?OUQ3TmZwTjg2RFNzN05UK2VaUWtiYTBMVnNPbFZnS1dhQnhYSkxxazhOakdG?=
 =?utf-8?B?eHdxbjdUakxLWG9ieG9veGdIOFFUSExOaGM0enZOb2JIYmRXVmhKajRvR0h3?=
 =?utf-8?B?VllTUU9rY1JvSjcvZUwrTHVmYzhFakQrbWQ1NldLVkxtSkQ0Vm1qaVR2ZjlU?=
 =?utf-8?B?d3lWeGpPQndBVGd2L2t5RnN5cnFTVnlBc2YvbnRrNWxwR3Fhc1dnSTVFakw4?=
 =?utf-8?B?aERsQ3cvY2hXZUZWd28raitIUUdrZTBTRFZKUWQ3TFJOTENPb3d2N0o0Tit5?=
 =?utf-8?B?amFETUxZdW9nWW1JSDVNcUJMN2lHcjAvM3MzZVVqSUo1Z1VRVHRPeDM4OWxF?=
 =?utf-8?B?Qnhtd3FRRGgzLzY2d1B6bitqU3lNR25WLzBqU1NvaGltYVVaMlZHZTdXRjgr?=
 =?utf-8?B?R1VDb1pRVFZBK3oyOERzcFdkRDRxUTNpNDE5UzZjUkw3TWRQcGd3a0xBUHJu?=
 =?utf-8?B?UlpYT1pQN1BaRHptamlJQnI0SStLS001YnlOMHFVbmF2NHhzM0dUVHo1dlVL?=
 =?utf-8?B?ZWR5K3B3cWZPNWk1SVBZcWY0T2JJdDcrd3MyMVZUS2MzWjNuaUIwUkhDNmFi?=
 =?utf-8?B?VnlKYzBTSXNCdWRjTnFhRUxvd3lGa1BKbXpibkJmV1JvV3JoNEh0VDFnbVUy?=
 =?utf-8?B?aUFkRmR1Q1dPWGZiYWczSXg4UVBKcVBDRDQ3UUI3VGFmQXRNSzVBZzBGYVVN?=
 =?utf-8?B?Y0MxUVNEVzUzdHpkSG1rOWM0MkhBREw3ZmsvbmVHOHorcUxPOHJydEUvcE03?=
 =?utf-8?B?Y3dnVzM5ZVZqeTB1RFF0UXptMEdUamxOQ3BKWnd5UUcxdm5sTGtycXZGN2RL?=
 =?utf-8?B?aS9hV1FiLytVbnhPY2NVR3BpVzBQaExMUmdQSkIvRWU3SzhNZFJscFJxanJh?=
 =?utf-8?B?UHBOZ2Fna3RQMUtPQVMzRUxra1VUWmxLQnh0Uk5hY0hCYU53SDlWQkNEZFFi?=
 =?utf-8?B?MndtNkRMTWRma3NSS01SS29HRk9RbUVUaUNwYnEzTnZWVmxmMHY4WkcxWGhJ?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B7CC54C2D1A38428A1974D3DC810BA3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB3338
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gV2VkLCAyMDIyLTA5LTI4IGF0IDE2OjE1ICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiAxLiBlbmFibGUgZ2NlIGRkciBlbmFibGUoZ2NlIHJlaWdzdGVy
IG9mZnNldCAweDQ4LCBiaXQgMTYgdG8gMTgpIHdoZW4NCj4gZ2NlIHdvcmssDQo+IGFuZCBkaXNh
YmxlIGdjZSBkZHIgZW5hYmxlIHdoZW4gZ2NlIHdvcmsgam9iIGRvbmUNCj4gMi4gYWRkIGNtZHEg
ZGRyIGVuYWJsZS9kaXNhYmxlIGFwaSwgYW5kIGNvbnRyb2wgZ2NlIGRkcg0KPiBlbmFibGUvZGlz
YWJsZQ0KPiB0byBtYWtlIHN1cmUgaXQgY291bGQgcHJvdGVjdCB3aGVuIGNtZHEgaXMgbXVsdGlw
bGUgdXNlZCBieSBkaXNwbGF5DQo+IGFuZCBtZHANCj4gDQo+IHRoaXMgaXMgb25seSBmb3Igc29t
ZSBTT0Mgd2hpY2ggaGFzIGZsYWcgImdjZV9kZHJfZW4iLg0KPiBmb3IgdGhpcyBraW5kIG9mIGdj
ZSwgdGhlcmUgaXMgYSBoYW5kc2hha2UgZmxvdyBiZXR3ZWVuIGdjZSBhbmQgZGRyDQo+IGhhcmR3
YXJlLA0KPiBpZiBub3Qgc2V0IGRkciBlbmFibGUgZmxhZyBvZiBnY2UsIGRkciB3aWxsIGZhbGwg
aW50byBpZGxlIG1vZGUsDQo+IHRoZW4gZ2NlIGluc3RydWN0aW9ucyB3aWxsIG5vdCBwcm9jZXNz
IGRvbmUuDQo+IHdlIG5lZWQgc2V0IHRoaXMgZmxhZyBvZiBnY2UgdG8gdGVsbCBkZHIgd2hlbiBn
Y2UgaXMgaWRsZSBvciBidXN5DQo+IGNvbnRyb2xsZWQgYnkgc29mdHdhcmUgZmxvdy4NCj4gDQo+
IGRkciBwcm9ibGVtIGlzIGEgc3BlY2lhbCBjYXNlLg0KPiB3aGVuIHRlc3Qgc3VzcGVuZC9yZXN1
bWUgY2FzZSwgZ2NlIHNvbWV0aW1lcyB3aWxsIHB1bGwgZGRyLCBhbmQgZGRyDQo+IGNhbg0KPiBu
b3QgZ28gdG8gc3VzcGVuZC4NCj4gaWYgd2Ugc2V0IGdjZSByZWdpc3RlciAweDQ4IHRvIDB4Nywg
d2lsbCBmaXggdGhpcyBnY2UgcHVsbCBkZHIgaXNzdWUsDQo+IGFzIHlvdSBoYXZlIHJlZmVycmVk
IFsxXSBhbmQgWzJdICg4MTkyIGFuZCA4MTk1KQ0KPiBidXQgZm9yIG10ODE4NiwgdGhlIGdjZSBp
cyBtb3JlIHNwZWNpYWwsIGV4Y2VwdCBzZXR0aW5nIG9mIFsxXSBhbmQNCj4gWzJdLA0KPiB3ZSBu
ZWVkIGFkZCBtb3JlIHNldHRpbmcgc2V0IGdjZSByZWdpc3RlciAweDQ4IHRvICgweDcgPDwgMTYg
fCAweDcpDQo+IHdoZW4gZ2NlIHdvcmtpbmcgdG8gbWFrZSBzdXJlIGdjZSBjb3VsZCBwcm9jZXNz
IGFsbCBpbnN0cnVjdGlvbnMgb2suDQo+IHRoaXMgY2FzZSBqdXN0IG5lZWQgbm9ybWFsIGJvb3R1
cCwgaWYgd2Ugbm90IHNldCB0aGlzLCBkaXNwbGF5IGNtZHENCj4gdGFzayB3aWxsIHRpbWVvdXQs
IGFuZCBjaHJvbWUgaG9tZXNjcmVlbiB3aWxsIGFsd2F5cyBibGFjayBzY3JlZW4uDQoNCkkgdGhp
bmsgeW91IHNob3VsZCBicmVhayB0aGlzIHBhdGNoIGludG8gdGhyZWUgcGF0Y2hlczoNCg0KMS4g
QWRkIDB4NDggWzE4OjE2XSBzZXR0aW5nIHN1cHBvcnQgZm9yIGJvb3R1cCAoSSBkb24ndCBrbm93
IGhvdyB0byBzYXkNCnRoaXMpDQoyLiBBZGQgZ2NlIGRkciBlbmFibGUgc3VwcG9ydA0KMy4gQWRk
IG10ODE2OCBnY2Ugc3VwcG9ydA0KDQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4gYW5kIHdpdGggdGhp
cyBwYXRjaCwgd2UgaGF2ZSBkb25lIHRoZXNlIHRlc3Qgb24gbXQ4MTg2Og0KPiAxLnN1c3BlbmQv
cmVzdW1lDQo+IDIuYm9vdCB1cCB0byBob21lIHNjcmVlbg0KPiAzLnBsYXliYWNrIHZpZGVvIHdp
dGggeW91dHViZS4NCj4gDQo+IHN1c3BlbmQgaXNzdWUgaXMgc3BlY2lhbCBnY2UgaGFyZHdhcmUg
aXNzdWUsIGdjZSBjbGllbnQgIGRyaXZlcg0KPiBjb21tYW5kIGFscmVhZHkgcHJvY2VzcyBkb25l
LCBidXQgZ2NlIHN0aWxsIHB1bGwgZGRyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5n
IE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQo+IA0KPiAtLS0NCj4gY2hhbmdlIHNp
bmNlIHY1Og0KPiAxLiBhZGp1c3QgZ2NlIHNvZnR3YXJlIGNvbnRyb2wgYW5kIGRkciBlbmFibGUg
c2V0dGluZyByZXZpZXdlZCBpbiB2NQ0KPiAyLiBjb3JyZWN0IEdDRV9DVFJMX0JZX1NXIGRlZmlu
aXRhaW9uIHR5cGUgZXJyb3INCj4gLS0tDQo+IA0KPiAtLS0NCj4gIGRyaXZlcnMvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmMgfCA0Mg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBiL2Ry
aXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gaW5kZXggOTQ2NWY5MDgxNTE1Li5j
ZTNjNTk1MzUzZDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmMNCj4gKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBAQCAt
MzgsNiArMzgsOCBAQA0KPiAgI2RlZmluZSBDTURRX1RIUl9QUklPUklUWQkJMHg0MA0KPiAgDQo+
ICAjZGVmaW5lIEdDRV9HQ1RMX1ZBTFVFCQkJMHg0OA0KPiArI2RlZmluZSBHQ0VfQ1RSTF9CWV9T
VwkJCQlHRU5NQVNLKDIsIDApDQo+ICsjZGVmaW5lIEdDRV9ERFJfRU4JCQkJR0VOTUFTSygxOCwg
MTYpDQo+ICANCj4gICNkZWZpbmUgQ01EUV9USFJfQUNUSVZFX1NMT1RfQ1lDTEVTCTB4MzIwMA0K
PiAgI2RlZmluZSBDTURRX1RIUl9FTkFCTEVECQkweDENCj4gQEAgLTgwLDYgKzgyLDcgQEAgc3Ry
dWN0IGNtZHEgew0KPiAgCWJvb2wJCQlzdXNwZW5kZWQ7DQo+ICAJdTgJCQlzaGlmdF9wYTsNCj4g
IAlib29sCQkJY29udHJvbF9ieV9zdzsNCj4gKwlib29sCQkJc3dfZGRyX2VuOw0KPiAgCXUzMgkJ
CWdjZV9udW07DQo+ICB9Ow0KPiAgDQo+IEBAIC04Nyw5ICs5MCwyNSBAQCBzdHJ1Y3QgZ2NlX3Bs
YXQgew0KPiAgCXUzMiB0aHJlYWRfbnI7DQo+ICAJdTggc2hpZnQ7DQo+ICAJYm9vbCBjb250cm9s
X2J5X3N3Ow0KPiArCWJvb2wgc3dfZGRyX2VuOw0KPiAgCXUzMiBnY2VfbnVtOw0KPiAgfTsNCj4g
IA0KPiArc3RhdGljIHZvaWQgY21kcV9zd19kZHJfZW5hYmxlKHN0cnVjdCBjbWRxICpjbWRxLCBi
b29sIGVuYWJsZSkNCj4gK3sNCj4gKwlpZiAoIWNtZHEtPnN3X2Rkcl9lbikNCj4gKwkJcmV0dXJu
Ow0KPiArDQo+ICsJV0FSTl9PTihjbGtfYnVsa19lbmFibGUoY21kcS0+Z2NlX251bSwgY21kcS0+
Y2xvY2tzKSk7DQo+ICsNCj4gKwlpZiAoZW5hYmxlKQ0KPiArCQl3cml0ZWwoR0NFX0REUl9FTiB8
IEdDRV9DVFJMX0JZX1NXLCBjbWRxLT5iYXNlICsNCj4gR0NFX0dDVExfVkFMVUUpOw0KPiArCWVs
c2UNCj4gKwkJd3JpdGVsKEdDRV9DVFJMX0JZX1NXLCBjbWRxLT5iYXNlICsgR0NFX0dDVExfVkFM
VUUpOw0KPiArDQo+ICsJY2xrX2J1bGtfZGlzYWJsZShjbWRxLT5nY2VfbnVtLCBjbWRxLT5jbG9j
a3MpOw0KPiArfQ0KPiArDQo+ICB1OCBjbWRxX2dldF9zaGlmdF9wYShzdHJ1Y3QgbWJveF9jaGFu
ICpjaGFuKQ0KPiAgew0KPiAgCXN0cnVjdCBjbWRxICpjbWRxID0gY29udGFpbmVyX29mKGNoYW4t
Pm1ib3gsIHN0cnVjdCBjbWRxLA0KPiBtYm94KTsNCj4gQEAgLTEyOSw3ICsxNDgsMTEgQEAgc3Rh
dGljIHZvaWQgY21kcV9pbml0KHN0cnVjdCBjbWRxICpjbWRxKQ0KPiAgDQo+ICAJV0FSTl9PTihj
bGtfYnVsa19lbmFibGUoY21kcS0+Z2NlX251bSwgY21kcS0+Y2xvY2tzKSk7DQo+ICAJaWYgKGNt
ZHEtPmNvbnRyb2xfYnlfc3cpDQo+IC0JCXdyaXRlbCgweDcsIGNtZHEtPmJhc2UgKyBHQ0VfR0NU
TF9WQUxVRSk7DQo+ICsJCXdyaXRlbChHQ0VfQ1RSTF9CWV9TVywgY21kcS0+YmFzZSArIEdDRV9H
Q1RMX1ZBTFVFKTsNCj4gKw0KPiArCWlmIChjbWRxLT5zd19kZHJfZW4pDQo+ICsJCXdyaXRlbChH
Q0VfRERSX0VOIHwgR0NFX0NUUkxfQllfU1csIGNtZHEtPmJhc2UgKw0KPiBHQ0VfR0NUTF9WQUxV
RSk7DQo+ICsNCj4gIAl3cml0ZWwoQ01EUV9USFJfQUNUSVZFX1NMT1RfQ1lDTEVTLCBjbWRxLT5i
YXNlICsNCj4gQ01EUV9USFJfU0xPVF9DWUNMRVMpOw0KPiAgCWZvciAoaSA9IDA7IGkgPD0gQ01E
UV9NQVhfRVZFTlQ7IGkrKykNCj4gIAkJd3JpdGVsKGksIGNtZHEtPmJhc2UgKyBDTURRX1NZTkNf
VE9LRU5fVVBEQVRFKTsNCj4gQEAgLTMxMSw2ICszMzQsOCBAQCBzdGF0aWMgaW50IGNtZHFfc3Vz
cGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJaWYgKHRhc2tfcnVubmluZykNCj4gIAkJZGV2
X3dhcm4oZGV2LCAiZXhpc3QgcnVubmluZyB0YXNrKHMpIGluIHN1c3BlbmRcbiIpOw0KPiAgDQo+
ICsJY21kcV9zd19kZHJfZW5hYmxlKGNtZHEsIGZhbHNlKTsNCj4gKw0KPiAgCWNsa19idWxrX3Vu
cHJlcGFyZShjbWRxLT5nY2VfbnVtLCBjbWRxLT5jbG9ja3MpOw0KPiAgDQo+ICAJcmV0dXJuIDA7
DQo+IEBAIC0zMjIsNiArMzQ3LDkgQEAgc3RhdGljIGludCBjbWRxX3Jlc3VtZShzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ICANCj4gIAlXQVJOX09OKGNsa19idWxrX3ByZXBhcmUoY21kcS0+Z2NlX251
bSwgY21kcS0+Y2xvY2tzKSk7DQo+ICAJY21kcS0+c3VzcGVuZGVkID0gZmFsc2U7DQo+ICsNCj4g
KwljbWRxX3N3X2Rkcl9lbmFibGUoY21kcSwgdHJ1ZSk7DQo+ICsNCj4gIAlyZXR1cm4gMDsNCj4g
IH0NCj4gIA0KPiBAQCAtMzI5LDYgKzM1Nyw4IEBAIHN0YXRpYyBpbnQgY21kcV9yZW1vdmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgY21kcSAqY21k
cSA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiAgDQo+ICsJY21kcV9zd19kZHJfZW5h
YmxlKGNtZHEsIGZhbHNlKTsNCj4gKw0KPiAgCWNsa19idWxrX3VucHJlcGFyZShjbWRxLT5nY2Vf
bnVtLCBjbWRxLT5jbG9ja3MpOw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiBAQCAtNTQzLDYgKzU3
Myw3IEBAIHN0YXRpYyBpbnQgY21kcV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpw
ZGV2KQ0KPiAgCWNtZHEtPnRocmVhZF9uciA9IHBsYXRfZGF0YS0+dGhyZWFkX25yOw0KPiAgCWNt
ZHEtPnNoaWZ0X3BhID0gcGxhdF9kYXRhLT5zaGlmdDsNCj4gIAljbWRxLT5jb250cm9sX2J5X3N3
ID0gcGxhdF9kYXRhLT5jb250cm9sX2J5X3N3Ow0KPiArCWNtZHEtPnN3X2Rkcl9lbiA9IHBsYXRf
ZGF0YS0+c3dfZGRyX2VuOw0KPiAgCWNtZHEtPmdjZV9udW0gPSBwbGF0X2RhdGEtPmdjZV9udW07
DQo+ICAJY21kcS0+aXJxX21hc2sgPSBHRU5NQVNLKGNtZHEtPnRocmVhZF9uciAtIDEsIDApOw0K
PiAgCWVyciA9IGRldm1fcmVxdWVzdF9pcnEoZGV2LCBjbWRxLT5pcnEsIGNtZHFfaXJxX2hhbmRs
ZXIsDQo+IElSUUZfU0hBUkVELA0KPiBAQCAtNjYwLDkgKzY5MSwxOCBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGdjZV9wbGF0IGdjZV9wbGF0X3Y2ID0gew0KPiAgCS5nY2VfbnVtID0gMg0KPiAgfTsN
Cj4gIA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBnY2VfcGxhdCBnY2VfcGxhdF92NyA9IHsNCj4g
KwkudGhyZWFkX25yID0gMjQsDQo+ICsJLnNoaWZ0ID0gMywNCj4gKwkuY29udHJvbF9ieV9zdyA9
IHRydWUsDQo+ICsJLnN3X2Rkcl9lbiA9IHRydWUsDQo+ICsJLmdjZV9udW0gPSAxDQo+ICt9Ow0K
PiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBjbWRxX29mX2lkc1tdID0g
ew0KPiAgCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtZ2NlIiwgLmRhdGEgPSAodm9p
ZA0KPiAqKSZnY2VfcGxhdF92Mn0sDQo+ICAJey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4
My1nY2UiLCAuZGF0YSA9ICh2b2lkDQo+ICopJmdjZV9wbGF0X3YzfSwNCj4gKwl7LmNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ4MTg2LWdjZSIsIC5kYXRhID0gKHZvaWQNCj4gKikmZ2NlX3BsYXRf
djd9LA0KPiAgCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3NzktZ2NlIiwgLmRhdGEgPSAo
dm9pZA0KPiAqKSZnY2VfcGxhdF92NH0sDQo+ICAJey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODE5Mi1nY2UiLCAuZGF0YSA9ICh2b2lkDQo+ICopJmdjZV9wbGF0X3Y1fSwNCj4gIAl7LmNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LWdjZSIsIC5kYXRhID0gKHZvaWQNCj4gKikmZ2NlX3Bs
YXRfdjZ9LA0K
