Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365E0629389
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbiKOIrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiKOIrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:47:01 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C1412745
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:46:55 -0800 (PST)
X-UUID: c479cba30632419b97a2e1c0943a9490-20221115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tvOB15PR8gn+yEVB8pMS4kPCsGQMbX2gymyqW9IUTW0=;
        b=gR/0rLJOW3Vn01guJo5nAj+d1e7/IabVjeWRaYb/XJlCseyNmXxQB160Tdui1+cDDmePXg2EWyxE9ZapVfGPd/0A1jA5n5CWw7AFsKCvh8bvx8ahFT4JhDlH9wSq6xeaZFg3QOA6OrfukLz4U0spL5mKeFHhoWN3CCiVF0gdtxo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:43803779-fd1f-4856-ac64-64690ec54855,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:51ffff29-8055-4e28-ab7d-2959ba08645e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c479cba30632419b97a2e1c0943a9490-20221115
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1165608284; Tue, 15 Nov 2022 16:46:48 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 15 Nov 2022 16:46:46 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 15 Nov 2022 16:46:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAhs9iNOCebEr/BkH/aHnc0RtdPXZwB229MnFRiPn/IVv161HkCozwe+11gx9DNOyS/2WJXunQUlBYEzlKV4wrM7pt3DMZ6+05EB3r3N6uR2dZRH1aWSVZOwGit+DQHTRk6WumB3JmrDG/j8Ma0J+ziv2P+p+jy0HXR5Owmz6lKVhmT6F9tDz2jbGqW3zxY6NqaxbbrvQdAMXTTGFjuURQ/3HK3wof/ClkyE8Cluhx62tXJpIL55k97zRVsP+0LnwrhSNnz6b2uxEYscJVi3VdEoNEItUkCt3cvFkGOMqP9cyNy86qoro0WKWAN0l5Q7yDhTkXldQ1FEldMnH6mbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvOB15PR8gn+yEVB8pMS4kPCsGQMbX2gymyqW9IUTW0=;
 b=Btjq5cz1n4GIVfw+8H8B7iUs/HzLaCpsz6VurI0CLzy6qEOZMVxFfwF/xehC8xAdfk9XWD9xq9tItrJQN0UIH5VsyPKP9C7Qpy/a+G9f8GChThdt9mbSL5g0BQbn62g1a4yHrODPOJx1fSYKJxYwUGNTd7cezGdxjh3kv1fwIqh4VeZm6lR6DxeNXBa4lhiBhnmD4mdUeL1GqHRfV4v27WCyMm5Bnzrif3XFT6JkX4DiWDabzoUiFbEg2P/B95bRgwe6f037xNTbwtdm2bIortAX9w2Y/NQQdjwYVIbbADSCCCRxsnvFYMCA97QsHxWxhUr2vCvkxRHtoaDCC2jAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvOB15PR8gn+yEVB8pMS4kPCsGQMbX2gymyqW9IUTW0=;
 b=TtPxN000PjNyrVo+8R4IGez4CBHWecuSV6lPnZLJYROrtPkhWZzGOcyNUWTydaLevTMwU9u8sj1kO12KrztIQBrIhW/eF69oPfnLEAw1uym4jSQ6UO76uPUrPFpqddkZcD35ZFMgCphOhkN3+QrtlAtUImUTXOerpaqDr8RNktA=
Received: from PSAPR03MB5336.apcprd03.prod.outlook.com (2603:1096:301:45::7)
 by TYZPR03MB5789.apcprd03.prod.outlook.com (2603:1096:400:74::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 08:46:45 +0000
Received: from PSAPR03MB5336.apcprd03.prod.outlook.com
 ([fe80::8c8a:93fb:1df9:9d1b]) by PSAPR03MB5336.apcprd03.prod.outlook.com
 ([fe80::8c8a:93fb:1df9:9d1b%3]) with mapi id 15.20.5791.022; Tue, 15 Nov 2022
 08:46:44 +0000
From:   =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v10, 4/4] mailbox: mtk-cmdq: add MT8186 support
Thread-Topic: [PATCH v10, 4/4] mailbox: mtk-cmdq: add MT8186 support
Thread-Index: AQHY3Jwd+nWpQwq4D0e3p3h6kyhKwa4TsnOAgCwx54A=
Date:   Tue, 15 Nov 2022 08:46:44 +0000
Message-ID: <8fe92d0f0b2c4c0946bf91bf2bc5341424400f3b.camel@mediatek.com>
References: <20221010085023.7621-1-yongqiang.niu@mediatek.com>
         <20221010085023.7621-5-yongqiang.niu@mediatek.com>
         <c1be7fa3351b8fe2d2f9c5c6654f701adc3147fb.camel@mediatek.com>
In-Reply-To: <c1be7fa3351b8fe2d2f9c5c6654f701adc3147fb.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5336:EE_|TYZPR03MB5789:EE_
x-ms-office365-filtering-correlation-id: e1110b5a-f190-47b3-85b2-08dac6e5ecd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tliYIW6mYZuCHyMKc4ZpE7OxcBXGjjU1Lpa5L+IgxtL3TNyEWOjFGIqd6dAFlZnfDTyyQyU/+EseN0Eu6TxNoOYbh9TxiYWHbC98wMkcxXiwsCUifG/kSS1kR333PfPDDzdcWcyt2N74bb9ZdCcdB2qurHMLO1uZ3LMnfGbpJI7qJG+9PDC+ewNGRI9eT+x8BA1sMiOlSBy3XHMwd1qtePazWuATmPSRz/lMcOrs2esq51tIgaTOA892Qq1WF20u0UAbDWQb4ss9LTqe4sAhP+A3/b6u4jmcwlvmyN18wggiTXC2C/deWJ3XzmmuSyJCwww6nKz9dyOdJZfgPJlJVl6n2kXAq7D9m93Tx3ounhPvFocJQUtw6sSfMVP2cZgULfgGzOZviy5c7eP9yzN8RSzRd+ZWsdzCapEh6A4cXL8Oioo6tuLqju65tdaJB/krbsC8aCTNQJtXTYxPPyRn0vMAWLt5syr7BbeNk4a3sQcLWw/r1dtJXYRimqQx19WvhV7lZW5vkG3OzMJH7bbybU2+3FYMWvzOccO9AaotlBoC0DHLozZqclXplrRPtMctBbz4OsHlvB7fCXE1uk+fAZ4hpj7RSY7npzfQITU5/z2NvEqjtLPsuNcoZwWxRZESbUpNMsD4DM5tLDOPZWM0iV3roSnFvIC+2c5mVH69XBXYY/1JKTJbyFYGQlpdneRmydwbKrMMrsAFv9Nm3bjV8jfX57/+2idHyr7T7vFYtB8Q91z0rZtbO3Kv32nVsVtT2XZ7QneyzjyFFm9oBHzdYW+bdlwGuV4Dg5LLuUlnIM4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5336.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199015)(478600001)(186003)(85182001)(316002)(6486002)(54906003)(110136005)(36756003)(71200400001)(6506007)(122000001)(38070700005)(6512007)(38100700002)(2616005)(83380400001)(26005)(86362001)(5660300002)(15650500001)(4001150100001)(2906002)(8936002)(8676002)(64756008)(4326008)(66476007)(76116006)(66946007)(91956017)(66556008)(66446008)(41300700001)(579124003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkkrWFptZ3NsWksxRFdScGE3blN6U01uSGpiVHNUYS9OWmhqd3hkRVdYcXRk?=
 =?utf-8?B?QkNvdlNoMDZuVnNFUE0vcXZLRzdWcnBBanJkUEJQeEFtb1A0bE5jblNxQmhu?=
 =?utf-8?B?RzdhQ3VaU1h1ODBtZHJHTHhlSXpUdHBIeWNzdENkYnJqald3T01TOFBLNjJX?=
 =?utf-8?B?RGxpem9aQ093V0dYSlcrMGdCVXhzNE5IdE84Mkkzb3FVR0k1YzNqNDFDdTFF?=
 =?utf-8?B?T2IvWmlkQzJjTmZmOGhObGxUb3RwTERtYkVaZDdibDlzNDRRbENMbVRhaERI?=
 =?utf-8?B?T2ZxczB1cjgxcmJ0N0FqRVMxQnlpSWs1OFlxRW1qS1FiR1I0TS96S2l2MVo4?=
 =?utf-8?B?bkNLTS9mME1qbnpQdUJHdUNOOHkycVhIZ2xxWnQycVJOY050UFphSlY2NEhB?=
 =?utf-8?B?azV2ZkhUNTllZENJRmFrRHU3R1R2dkc0NDlHTkI1RjFwaDNtOXl2L3VPMXBU?=
 =?utf-8?B?dUZWVDNZcTFZUzNjbTNCZ1FZdkVQWk11aEI5UWJoVk45UzNEN0VndVppcUgw?=
 =?utf-8?B?UksrYmRuT3ZQYktHOExySDcvY0Y1Ym5yc2pBR0hBVWZIRnZsODVrUTNrc0hR?=
 =?utf-8?B?cDgrbjkvelFzYXlpV3pxd0lFYzVzbFRvbTBnT0RtSkdablRNWnU3emZ1aTBS?=
 =?utf-8?B?SVQ3NVhCRjBOSHFHcHZhSVVYd2xISTZ5MUNzak8vcTNCbXlyc2g5ejFJU0xY?=
 =?utf-8?B?dnJveWllWGVFaVhCUmd2cHZrRGZYMXFFblZscmM3SFpqRFoxUXhabGpvcVpU?=
 =?utf-8?B?ZURvdU0yQW9QZDZjRE42RzhyRzJUcGJ2eDF6b3ZUb2dVSnBNNmhEVnZXQXpp?=
 =?utf-8?B?a1JmZUhWMkNHd21FYnBFdGFmb0ZPbktha3REVU5jKzVZZzdBL0RON1BYMDl0?=
 =?utf-8?B?UmpLMHlERzEvdzZtanI0RGN1c0RVMVY4Tm5EQjJJUDBOamNkS2VmZ3JiaEU4?=
 =?utf-8?B?RVhtZnhnU2plbGtXODc3WDZiQkFBVUdQeDBEQnNRM1VqQ29qNEVlcFVxd29F?=
 =?utf-8?B?L1krdG5FQXROM05JczlLRk4vb2h1VVNmblRzWWlWQVdaVjg2YWFvRmhOOGdY?=
 =?utf-8?B?VmgyTFBrTXdJY1lCWjUvTjdiUlJFOEM4WnlobjNIK1JSdkZ1T3gxYmpiZVow?=
 =?utf-8?B?NXhiNnExSFB1dzJMdWZZYUJKRnVjQ3F3cEZTaWl4SDc2YStzK085NFErN2RR?=
 =?utf-8?B?OXE5Ymg5c3E3L0hHZ3FQUkJ1N2VpcTdpNURtNW41dktkTVJkend1S0tnSnB1?=
 =?utf-8?B?OWJjNFVReURaUVh5eDN3ZWVGeCtwditab0M3cEtMRjB4WjN3aUJLdDd4Rmgw?=
 =?utf-8?B?bDZUMVVaTGNEMGowdlNPaGhONmR4UUI0THJKL0tmMDQzL1ZxVGdvRVVmNi9z?=
 =?utf-8?B?WDlUMmo1VGQ1T0NldGxudS9MRkFKbzVkUjJOdXdoNGJ3T1Q5MVVLUCtkUGpM?=
 =?utf-8?B?T0xZNUpqL0xrVys5MmZodUVUMXFzWlUzUGxBZXJyTWhMN0lXR3dlQUx2NjhM?=
 =?utf-8?B?MDRPamh4L2hvM0dBVVRSb3JuZzZ0T1BWZ1RHTG03T0hPVE1xRG5IQ0hBY1di?=
 =?utf-8?B?VkZhd1RwQzdlamFYanFHWlNUZ2U0UnlwMVJ2TkQ1TjYyemJVOGQxcDdHUVpl?=
 =?utf-8?B?dUt6MDZJRDhFNFAySlJxcUEvN3VydmtISGpOTjUyVW9OUWtXdTlXL3hoR0Ru?=
 =?utf-8?B?VXljdThNS0Y3MzBWZTIraGViYmdidHQ4Q2JTbitvRFMxMys5RmI0UG5hVkpR?=
 =?utf-8?B?K3dYYlcyUXBNeUtFdENwdW9Gcno1RWN4WWM3QUpEUEZENGhPWVRlUy9aeXhK?=
 =?utf-8?B?dlN1WFBSc21uQmlraUk1LzRzeExIdmlqWE5IOW04TGR2aFBZNzNsenAvVkJG?=
 =?utf-8?B?eHBxZlMxSWcxTkFZVkRVRElyTHo3N2ZIVWhkT2dUSjFZREJnN3pXWmE0RFpT?=
 =?utf-8?B?U09Zd1BsOE02TWpDWVE4SHVOaDNlRHh4eE56ZXZrSVdKT09rVG1FbitaN3hR?=
 =?utf-8?B?MXVoVkw5L3MwMDdoSVp4Z1BQM2kvaEJ1ZnhlT0k4RkF2M3pER0RDZjlDekZY?=
 =?utf-8?B?NDJJbFpVTTJzRWdqK2lURWJMZDhmSU9CdldSMGVlaU1QMmt0ODhLVFBESisv?=
 =?utf-8?B?SmJCMk5pUUtQNm90T3hmMmt2cWJLdERxUDlTbWNVcG5mTjd3SVF0OXJEOEgw?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE6442960E4D2448AF96DDDA267B2B61@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5336.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1110b5a-f190-47b3-85b2-08dac6e5ecd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 08:46:44.9064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JPCAlWiOnDrTQPQCnHw174EFxaskWED6SBY5UypvxlebLoizym9ootaYRKIqtvokEhROT9JhUXWTMzxaQrBo5qzeRKxAHzqkZDP3Htwy+gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5789
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aGkgamFzc2kNCg0KZG8geW91IGhhdmUgYW55IGNvbW1lbnQgYWJvdXQgdGhpcyBzZXJpZXMgcGF0
Y2g/DQoNCg0KDQpPbiBUdWUsIDIwMjItMTAtMTggYXQgMDU6NTIgKzAwMDAsIENLIEh1ICjog6Hk
v4rlhYkpIHdyb3RlOg0KPiBIaSwgWW9uZ3FpYW5nOg0KPiANCj4gT24gTW9uLCAyMDIyLTEwLTEw
IGF0IDE2OjUwICswODAwLCBZb25ncWlhbmcgTml1IHdyb3RlOg0KPiA+IGFkZCBNVDgxODYgY21k
cSBzdXBwb3J0DQo+IA0KPiBSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4N
Cj4gDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5p
dUBtZWRpYXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJl
Z25vIDwNCj4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgfCA5ICsrKysrKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiBiL2RyaXZlcnMv
bWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiBpbmRleCA1MzkwNDUxMTU5OGQuLmM1MjI5
ZjM3N2M1ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5jDQo+ID4gKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+IEBA
IC02OTQsOSArNjk0LDE4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZ2NlX3BsYXQgZ2NlX3BsYXRf
djYgPSB7DQo+ID4gIAkuZ2NlX251bSA9IDINCj4gPiAgfTsNCj4gPiAgDQo+ID4gK3N0YXRpYyBj
b25zdCBzdHJ1Y3QgZ2NlX3BsYXQgZ2NlX3BsYXRfdjcgPSB7DQo+ID4gKwkudGhyZWFkX25yID0g
MjQsDQo+ID4gKwkuc2hpZnQgPSAzLA0KPiA+ICsJLmNvbnRyb2xfYnlfc3cgPSB0cnVlLA0KPiA+
ICsJLnN3X2Rkcl9lbiA9IHRydWUsDQo+ID4gKwkuZ2NlX251bSA9IDENCj4gPiArfTsNCj4gPiAr
DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGNtZHFfb2ZfaWRzW10gPSB7
DQo+ID4gIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWdjZSIsIC5kYXRhID0gKHZv
aWQNCj4gPiAqKSZnY2VfcGxhdF92Mn0sDQo+ID4gIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQ4MTgzLWdjZSIsIC5kYXRhID0gKHZvaWQNCj4gPiAqKSZnY2VfcGxhdF92M30sDQo+ID4gKwl7
LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg2LWdjZSIsIC5kYXRhID0gKHZvaWQNCj4gPiAq
KSZnY2VfcGxhdF92N30sDQo+ID4gIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzc5LWdj
ZSIsIC5kYXRhID0gKHZvaWQNCj4gPiAqKSZnY2VfcGxhdF92NH0sDQo+ID4gIAl7LmNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ4MTkyLWdjZSIsIC5kYXRhID0gKHZvaWQNCj4gPiAqKSZnY2VfcGxh
dF92NX0sDQo+ID4gIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LWdjZSIsIC5kYXRh
ID0gKHZvaWQNCj4gPiAqKSZnY2VfcGxhdF92Nn0sDQo=
