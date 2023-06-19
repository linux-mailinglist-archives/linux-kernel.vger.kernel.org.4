Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C56734A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 04:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjFSCR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 22:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjFSCRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:17:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47204E4E
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 19:17:38 -0700 (PDT)
X-UUID: 73ed00900e4711ee9cb5633481061a41-20230619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QPNsvvRgB20v9AHwKzpbCtgEe4hDSLzxX2Td6EDUeZc=;
        b=PLgy+pEtcF+lHqORIX32ug47/D03lT/wLlqxQjuvbDK+kx5MEomZ/llre048aSUt9/1+OGy+TjldCfCGiBWV1lGf93K5O9c/3yGGnGn8Nr9JSJjI09aXstNMU08M5qZ+O5M5YQJ3jTDjxkfHZRwjV0UEBQTjJSUuj74KI4EW55E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:cce0fad0-e33e-4541-83b1-09d816967606,IP:0,U
        RL:0,TC:0,Content:15,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:66
X-CID-INFO: VERSION:1.1.26,REQID:cce0fad0-e33e-4541-83b1-09d816967606,IP:0,URL
        :0,TC:0,Content:15,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:66
X-CID-META: VersionHash:cb9a4e1,CLOUDID:6e1b073f-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:23061910173576E2G7GU,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:3,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-UUID: 73ed00900e4711ee9cb5633481061a41-20230619
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <walter.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 383998694; Mon, 19 Jun 2023 10:17:34 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 19 Jun 2023 10:17:34 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 19 Jun 2023 10:17:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chdaynRAR7yAqUVirVCO0TAg3npBccg8mEe+Ake49P9ErvWAoyvLVldM4srAi0GjB6jgRJDgw78pO9t24EHHaPF8JrxW5J/VyjCvV15bNpXWhMwQuVCQISmz8f4Ao+Eq3HjPKrSE7NuWe6UMIb6913sNONnxX5VDfA5K840Ni+XYEfsYnazylwW6Gi+NDwGqKL8CJDOhgHpaYGo88OfQTGaFS+NMOPOVFP158Yg331ZidAiBefBMr7OADuADPA/KmjlsTVJDNcMoC8HvnxLBkdWY7Ad0gpmDTujPhaxa9vJxItAbC3OMqNki+FYRgv0LdQrRRn70OHxFEnzPHldICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPNsvvRgB20v9AHwKzpbCtgEe4hDSLzxX2Td6EDUeZc=;
 b=OIRUfAKTlUrRMfAGxJpf3U+iijf6s91offju3dLvynZiGJB+uyCxex086Igx8A3iMv8/TEOLUp9xpkX6ICljODvfq/pbz1d5vOxXvIxvkinwDkonrQfLXQUl4PI0uDpsf1xYXYV+vtRxO5fWTqCIyBwIwo58fExRWJ4qBkRaFChzYGlC/8FcdoI+IU037RmGiI0KYHez3Z086u2syNa3Pp/m+NAvdGEmvUcBHy5ZP0yOOUwI6W9YWW2sKbMoh6PwzUhFitz2+hd9qiAdXWFqezSLwnZJr8WpmVVtBESgO/Fbss4Ok4ptEqokeFC0u4ojtTgt+ijI4DjXN7qdOxAF0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPNsvvRgB20v9AHwKzpbCtgEe4hDSLzxX2Td6EDUeZc=;
 b=REVUzu3OGjHb59guaUCvu0nKBN9eOXOBSRPb720F+kD3sD0yP9oNRUX1+o61vvCBUL4JVFUBj+nXg+VBhvjBmoxO80fTqaF5YHNuPw4XG8uwi5r8UMElhbDLQo2ZYM/qEIiJh5lkeqJazVpb8qQtYvCxXG7EiRcOATrplXxQwxk=
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com (2603:1096:820:64::14)
 by TYZPR03MB8034.apcprd03.prod.outlook.com (2603:1096:400:463::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Mon, 19 Jun
 2023 02:17:31 +0000
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::f5d3:d81c:730:2909]) by KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::f5d3:d81c:730:2909%6]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 02:17:31 +0000
From:   =?utf-8?B?V2FsdGVyIENoYW5nICjlvLXntq3lk7Ip?= 
        <Walter.Chang@mediatek.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "macro@orcam.me.uk" <macro@orcam.me.uk>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?utf-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?= 
        <Freddy.Hsin@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>
Subject: Re: [PATCH v5 0/4] Support timer drivers as loadable modules
Thread-Topic: [PATCH v5 0/4] Support timer drivers as loadable modules
Thread-Index: AQHZiGcAlWtFKUKClEylT3CLdkSqYK+Rl5cA
Date:   Mon, 19 Jun 2023 02:17:31 +0000
Message-ID: <9be6328b0996f1d46301377340973d02aef5663f.camel@mediatek.com>
References: <20230517022557.24388-1-walter.chang@mediatek.com>
In-Reply-To: <20230517022557.24388-1-walter.chang@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5777:EE_|TYZPR03MB8034:EE_
x-ms-office365-filtering-correlation-id: bee1d547-8c1a-475d-d813-08db706b5652
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ysN5mebUYm2hE0MOYPVnt4n/RyLIItDOUZKjwHXMlZzYFT8XBHQ9cYIr0seQ5fe62RZ7JapfUEyNpwyCit6BRmjfAsQMDVmfaozAOKJ5ZnmbqGcG+m8/WQaXHBq/PCN6vqd8sUAH6f0mEdIRY0KH3eC/w2OAkaOvdpG99iBYjy1XGejMZRupdGI1TQWu3mn5LbKIXOFdVKGKFxoiAwzirDiDhXgX79rQ+F5bLwEUtWu2L3WWwKevHyv7tZnsWSDJRFQJrSxzMslO7LVZ+KA0J0N5QD37DNsHRKTD0H6x+J9sGVZklpMqgq0bP7BO9fzY+W9AsoLsW62L6htztDHiBRMgQ4mVdjhl40NavNvkLxPAywpNikfU0nh33AhDLRfTezxVVFKj8x86u4HlP3dKMLDP/XTVaSBoGiUuRs93ROQeKsMx2piFvkdKfvv8oK0UXeLrCIEGPAGm4GQYIgvM0Ojwe562+D0/ONIA3Psfow8UOsbcizgMTmyKLJDbhBkSvGdxKMD7drZKTkPzE6Gs6zNp0D4nHtZDh5tgwo6+5JzJfW7RwG99Xi0le5Gr1P8GtHRdgB25xy4E4q0znZ1c3NC4lNK7JTrx/J+PkSn30ct3n1McQmYJDYw6LJeS1waRSKhmUOGJD7/NquGHBWmoTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5777.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(396003)(39850400004)(451199021)(478600001)(54906003)(110136005)(6486002)(122000001)(966005)(5660300002)(8676002)(8936002)(2906002)(36756003)(41300700001)(85182001)(86362001)(38070700005)(38100700002)(64756008)(66446008)(66556008)(316002)(66476007)(66946007)(4326008)(76116006)(91956017)(6506007)(107886003)(26005)(186003)(6512007)(71200400001)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFBqWFRVY2xXUDFZcHBmV1I3WDZJbXVwNDF1RWtzZDFQa2xsUXV0VDl4YWhk?=
 =?utf-8?B?dHFXcEdVZkx5dFdHQ29DVGhEYktYN1ZwbHphczVQc2lRUFFHUUE1Rzl5SUYy?=
 =?utf-8?B?WXFqT1dZMGNBbTA1ZEw2NEtlcW8xMGt2SGF0NG9VdXFKQ0hHT3NWMzRQUysr?=
 =?utf-8?B?cUdCd1k4MnlDVlR1bXRHcjNyZlhmcHNwRWhLZ3B5YW9KRmVFRTZzSUZuUitv?=
 =?utf-8?B?emhjejBVM212M3c0T0RLbzI2eTQ0TjZQaWdub3o3MmVvSVNjcStvYTF2MnM2?=
 =?utf-8?B?MWNyc2lkNlNrQ2hNRkJoTnh4UHFCR016N29XT0NzcEVPUkNNbGVvTFVSbnpj?=
 =?utf-8?B?WHRrWUcwVFdUTlRwNVhvMlQ1aFUxa25oaXpBUDJCVU1UWGlscWdXQy9hSzIw?=
 =?utf-8?B?Qm54M1hzN0VIeEVmV3lFakt1bE5aeEI5ZVB3dE5GUTNrQ2xYMmE5TDhZVG8x?=
 =?utf-8?B?ZEhxS2FVVU9FZzVHZlMxY2pWNUYrUDBGYjBabWt0SWZGSFBpNjZ3TElCZGU3?=
 =?utf-8?B?YzRDOU93enBMenFRQk5IdGxONk5xRDZsTjJYODEzY01USVQ3VkdPWnc5bkVQ?=
 =?utf-8?B?NGQxdlVlZnZUZjRYY08wcWpZLytBcGYxWmwrWmFQLzkxQnZVNlNPQkFQdE5J?=
 =?utf-8?B?VnBEYWY0YS9NVWZTbEI5eUhrenRCU1hWY0QwbVNSTFVqaG43dmlXVUZmVWlJ?=
 =?utf-8?B?empzcFNwQ1NVT3RyeGg2dVpUQ2RFcDlKMVFpM216bG41Tm5lNlhrdkM0YVgx?=
 =?utf-8?B?c0dWeWJ2YkViRnlDU3IrM0kwcmt2TWV0T3o4Y2g2ZnpYaFY1TlZldzRkcVhy?=
 =?utf-8?B?WUJWVUZDckY2RmFybTBjMi8zdTBKakRaOVJvZ1NmQ1NWcndsN1JDN01pbjlm?=
 =?utf-8?B?R0R4enNLV2pER3p3Y1dsLzdKc0JWNjJDdlB4V1NuZUJIcjhQNlppUUx2Y3p0?=
 =?utf-8?B?VDZqYXBzeW4vVVRpdTFRV1J6VUhKZm9KUHl5cEJNMm5oNSthUmZXSW05NnlD?=
 =?utf-8?B?c2l2RHAzYXNMOG5RNW5GUEdRR3ZvRWNSaGtFOFl2NHhPSnBwWG9CbWJESU9P?=
 =?utf-8?B?a3NtM1luRC8yVWxnZ0oyOGVDaWs2eG1HaWZEejVJeWllaGg5NHBGNW1HQ0My?=
 =?utf-8?B?SWgzQ2NxbFhRUytSY295RDdvZmM4ekpqUlhubEM1ck9HQVEzL1dleXNhbXBx?=
 =?utf-8?B?eHpZU1B1aU9MR01mNTFyeHJsOXA5YzQ2N2RDUFc5anhpOXNDbVl2WFNXYzRx?=
 =?utf-8?B?Tit5OFVmNndBWDVubnl6Z0NTdWxzeDlPZk1OTnQydWFac1crNEgrL2ZUTW5C?=
 =?utf-8?B?ZG5iUFpVVlJPVnpTK1NuaEMyY25KZEIzaS8rMGdBQTJoaSt1QlV6bWw5Ky9C?=
 =?utf-8?B?YW1EaTh0cWZsSTVlbStMSVRUQkdtREhVcmVYRlVFVW1rZ1k5czhLMzhnMUN5?=
 =?utf-8?B?ZWp2L3NHZkpEaTFFUlFZTlhQdXBYK2RqcEJpWU9GLzRUYmVVaWc4LytwUVVU?=
 =?utf-8?B?RmVqK0VsT2VlYzF3TUFXOHNGZmEvMi9qQmRtWHB6VXNEUVhkWTN2UkZOSU9y?=
 =?utf-8?B?WUdYNHU1MEhNY0Rpa1dycHJZSFhBNkRLVGJRbVZOdXBmVEdHeDFzUU0yTldD?=
 =?utf-8?B?dE9jR1pzUWV3SHdXSU1vWEhUdHdxYTYzWHh4TjV0SGljWnJLcytGZHkydTFJ?=
 =?utf-8?B?ZWVtSldFYndJZ1g1SUttUytndDBqYjlZeWxtaEUzK0tzWmFUdTdIUWJqQ0cy?=
 =?utf-8?B?M0tOV0FMQmJST280TTlQSjdBNXFXbHV3L3dCZk42MjJBMlVXQm5hZW1rQlc0?=
 =?utf-8?B?UFZNN0ZTMk94ei92elZUNGxPSmJzanhzZ2xhR0hFTlYwcHA1c1R2aGZRSzZp?=
 =?utf-8?B?MzFjZ3NXTE5nekJBTS9mZ29XUmZGVjV0UjlObXlHeTNNYzlEa3RKRmp4dnJo?=
 =?utf-8?B?dEpRYXIwOXk5STNyQ0tqOXpFWi9HM2lrd212U1pWSmJmMlhIeE1Xcm9BUmdK?=
 =?utf-8?B?SFFJaXROZ081NGRIYkxpNmU5WmxGdTR0anlNd09VZXNPSzNpL3dITkhOMVMy?=
 =?utf-8?B?T2dhYjB4YUpDdVQvbnd6MnZRV1lpWlVyOU9lT3Y0MW9vWm5qVVBsUlNVOFBv?=
 =?utf-8?B?bTdocXFiOERweThpRUNCOVJPbjlaTGpxVllaUEY0dXlxcEZKdUNFb2x4V0Z2?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E077212041B381429753E17199978557@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5777.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee1d547-8c1a-475d-d813-08db706b5652
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 02:17:31.5046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EWIoj4Yh81VTLMvlAH9LAVCF0JmksEEXyq4ozs6ofVXLXtJ3TUi/Vt6/fzOJj5lc+TTsS1BLmQbTvb+UKcysjjHRBUGZFOE8i2AVdwKTfw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8034
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTE3IGF0IDEwOjI1ICswODAwLCB3YWx0ZXIuY2hhbmdAbWVkaWF0ZWsu
Y29tIHdyb3RlOg0KPiBGcm9tOiBXYWx0ZXIgQ2hhbmcgPHdhbHRlci5jaGFuZ0BtZWRpYXRlay5j
b20+DQo+IA0KPiBUaGlzIHNldCBvZiBwYXRjaGVzIGFpbXMgdG8gbWFrZSBTb0MgcmVsYXRlZCB0
aW1lciBkcml2ZXJzLCBzdWNoIGFzIA0KPiB0aW1lci1tZWRpYXRlay5jIGJlY29tZSBsb2FkYWJs
ZSBtb2R1bGVzIGZvciB0aGUgR2VuZXJpYyBLZXJuZWwgSW1hZ2UNCj4gKEdLSSkuDQo+IA0KPiBU
aGlzIGRyaXZlciByZWdpc3RlcnMgYW4gYWx3YXlzLW9uIHRpbWVyIGFzIHRpY2tfYnJvYWRjYXN0
X2RldmljZSBvbiANCj4gTWVkaWFUZWsgU29Dcy4gSWYgdGhlIHN5c3RlbSBkb2VzIG5vdCBsb2Fk
IHRoaXMgbW9kdWxlIGF0IHN0YXJ0dXAsIA0KPiBzeXN0ZW0gd2lsbCBhbHNvIGJvb3Qgbm9ybWFs
bHkgYnkgdXNpbmcgYnVpbHQtaW4gYGJjX2hydGltZXJgDQo+IGluc3RlYWQuDQo+IEJlc2lkZXMs
IHRoZSBwcmV2aW91cyBleHBlcmltZW50IFsxXSBpbmRpY2F0ZXMgdGhhdCB0aGUgU1lTVC9HUFQs
IGluIA0KPiBjb21iaW5hdGlvbiB3aXRoIGEgbG9hZGFibGUgbW9kdWxlLCBpcyBmdWxseSBvcGVy
YXRpb25hbC4NCj4gDQo+IFRoZSBmaXJzdCB0aHJlZSBwYXRjaGVzIGV4cG9ydCBmdW5jdGlvbnMg
YW5kIHJlbW92ZSBfX2luaXQgbWFya2luZ3MNCj4gdG8gDQo+IHN1cHBvcnQgbG9hZGFibGUgdGlt
ZXIgbW9kdWxlcy4NCj4gDQo+IFRoZSBmb3VydGggcGF0Y2ggbWFrZXMgdGltZXItbWVkaWF0ZWsu
YyBiZWNvbWUgbG9hZGFibGUgbW9kdWxlIGZvcg0KPiBHS0kuDQo+IA0KPiBbMV0NCj4gDQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMzI3Nzc0NTZmOGUwZjk4ZTRjZDViOTUwZjQyMWQyMWY3
MWIxNDljZi5jYW1lbEBtZWRpYXRlay5jb20vI3QNCj4gDQo+IFt2NV0NCj4gLSBBZGQgU2lnbmVk
LW9mZi1ieSB0YWdzIGluIGFsbCBwYXRjaGVzDQo+IC0gQWRkIEFja2VkLWJ5IHRhZ3MgYW5kIFJl
dmlld2VkLWJ5IHRhZ3MNCj4gDQo+IFt2NF0NCj4gLSBGaXggcmV2aWV3IGNvbW1lbnRzIHBvaW50
ZWQgYnkgQW5nZWxvDQo+IA0KPiBbdjNdDQo+IC0gUmViYXNlIG9uIGxpbnV4LW5leHQNCj4gDQo+
IFt2Ml0NCj4gLSBDb252ZXJ0IHRpbWVyLW1lZGlhdGVrLmMgZHJpdmVyIHRvIGxvYWRhYmxlIG1v
ZHVsZQ0KPiANCj4gQ2h1bi1IdW5nIFd1ICg0KToNCj4gICB0aW1lL3NjaGVkX2Nsb2NrOiBFeHBv
cnQgc2NoZWRfY2xvY2tfcmVnaXN0ZXIoKQ0KPiAgIGNsb2Nrc291cmNlL2RyaXZlcnMvbW1pbzog
RXhwb3J0IGNsb2Nrc291cmNlX21taW9faW5pdCgpDQo+ICAgY2xvY2tzb3VyY2UvZHJpdmVycy90
aW1lci1vZjogUmVtb3ZlIF9faW5pdCBtYXJraW5ncw0KPiAgIGNsb2Nrc291cmNlL2RyaXZlcnMv
dGltZXItbWVkaWF0ZWs6IE1ha2UgdGltZXItbWVkaWF0ZWsgYmVjb21lDQo+ICAgICBsb2FkYWJs
ZSBtb2R1bGUNCj4gDQo+ICBkcml2ZXJzL2Nsb2Nrc291cmNlL0tjb25maWcgICAgICAgICAgfCAg
MiArLQ0KPiAgZHJpdmVycy9jbG9ja3NvdXJjZS9tbWlvLmMgICAgICAgICAgIHwgIDggKysrKy0t
LQ0KPiAgZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1tZWRpYXRlay5jIHwgMzMNCj4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1vZi5j
ICAgICAgIHwgMjMgKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9jbG9ja3NvdXJjZS90
aW1lci1vZi5oICAgICAgIHwgIDYgKystLS0NCj4gIGtlcm5lbC90aW1lL3NjaGVkX2Nsb2NrLmMg
ICAgICAgICAgICB8ICA0ICsrLS0NCj4gIDYgZmlsZXMgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygr
KSwgMjAgZGVsZXRpb25zKC0pDQo+IA0KDQpHZW50bGUgcGluZyBmb3IgdGhpcyBzZXJpZXMuDQoN
ClRoYW5rcywNCldhbHRlciBDaGFuZw0K
