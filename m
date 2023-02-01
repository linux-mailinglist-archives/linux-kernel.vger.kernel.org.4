Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E28686168
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjBAIPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjBAIPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:15:39 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668085D93C;
        Wed,  1 Feb 2023 00:15:32 -0800 (PST)
X-UUID: 9762d258a20811eda06fc9ecc4dadd91-20230201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JPaJ3P+ncRKjN7SpFVVTY3POtI2rQ7cw46ztybfDrVA=;
        b=RPR2hpDTg4aUTtGLP7QoflCQcMNjdJU6+cNilCD/WVO0Tf/SNEXftnMP/0MYHRj3wfsH9LMgnhBaolm3MYmAluogjHrbJlvDsVbya4u7ovqFzFvZFiSHJHjJ3Xnjr9Myukbg7afLYomhEeygDIGLnt1i2seTi0diiszJ2jxPkOk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:e3c4e315-cf96-4f4a-9443-9b85c0c90bb5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:3d85f655-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 9762d258a20811eda06fc9ecc4dadd91-20230201
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1704078279; Wed, 01 Feb 2023 16:15:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 1 Feb 2023 16:15:29 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 1 Feb 2023 16:15:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tekedd+YT9MkRYa9D7ymfkKNYd0NWL/J253Auqy8poovfKo6mEPNCs2z2QFMQ6GS4CVZ9SDEEtck2Zyg/Za9o9T5IqGSDULmxeUV5EqK7Yt0eLRJgOHEBF4QqYFyDXTlirTOJ+tBm9Xukx8SakT9j/geqs4j5WUvGB+VqMy89nQMCgV5Bh4xwZCQK0GmicGv78S4xs40HaoZWBZpF6qH2oaDptZExK/Yy+KgrdUuYBt/j3jTIlQo2DBISxDLfPpaQQIcGKHqxQemyp4n461H73n4KHwIzdIg+XIYzroijhmuxnCDaZ3iH1TsACiGpw4kP8vstb2gtWyP0C1n9Y3RUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPaJ3P+ncRKjN7SpFVVTY3POtI2rQ7cw46ztybfDrVA=;
 b=To1t2p9quNOcvg3iIRxrK3PVCdWxZGjJcZz6oswt6YmyXVP2b3B6axz4bQQb9nfFTrX4VFvhb31xock/xP3ek9ORc3LFOpixftynCLPN1z3ymf9TcMxz2CWOXfwPYyVGZkNQ4FckjGbvjQTmGarbNGEGuCuR+L82+V/cZBgynnNJ871fwuxhWdBAHz9q3W3cM1rYL1EDscG2oPIeWuc3vykefhHmVCZtMy0vO0I/M7enxQGqqD2My2oL4kBE+KMOUUr+OS8/C+n7rBaljvKpQb34gjH4kpMXkJHDGtgEQmPokR0A15zsfixeW+K5MdqLYueVPt7hHsB8azKIsp0z5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPaJ3P+ncRKjN7SpFVVTY3POtI2rQ7cw46ztybfDrVA=;
 b=B5rX0eHWC/LRUV3RAvne0GPfqBC/QF0/qhpdGZT6vcwaaE5385iv/2/E4pynRVfDb78SRs1CO6xr/FivYikHK1oD2qzFFSyR/AmQ9JdVcd/j4lbm8VEDdz+CE5fJf04DJENCXJrQreUd/+D6mQWwCmzmAYKjGXsK4i/LrNvqLA8=
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com (2603:1096:4:26::14) by
 PSAPR03MB6396.apcprd03.prod.outlook.com (2603:1096:301:a3::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36; Wed, 1 Feb 2023 08:15:27 +0000
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::42eb:28a2:4d2e:d051]) by SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::42eb:28a2:4d2e:d051%5]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 08:15:27 +0000
From:   =?utf-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>
To:     "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "drinkcat@google.com" <drinkcat@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKQ==?= 
        <Jia-wei.Chang@mediatek.com>,
        =?utf-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>
Subject: Re: [PATCH v4 12/14] soc: mediatek: mtk-svs: use svs get efuse common
 function
Thread-Topic: [PATCH v4 12/14] soc: mediatek: mtk-svs: use svs get efuse
 common function
Thread-Index: AQHZJZDJdny6TvCZ4kekHUk8NqCxKK64pzcAgAE4UgA=
Date:   Wed, 1 Feb 2023 08:15:27 +0000
Message-ID: <6ff7569fcb9a7aed233b265199e7fbc73c905bff.camel@mediatek.com>
References: <20230111074528.29354-1-roger.lu@mediatek.com>
         <20230111074528.29354-13-roger.lu@mediatek.com>
         <2995be5e-88e9-f00d-7bce-2f7c9eb5724d@gmail.com>
In-Reply-To: <2995be5e-88e9-f00d-7bce-2f7c9eb5724d@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3434:EE_|PSAPR03MB6396:EE_
x-ms-office365-filtering-correlation-id: 25ff316f-fc63-426e-5121-08db042c79c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x7pFekDsxhZCx8LcmPUIqklqF7tAsPyEW67KGfO3zPH8Ohck8BX3iCVgQXYwFercaV3hJdFzoYSJ0/nsJ9SUT3xPLjfJHjPziRY8nuYaWsI0BgHllxhiEDQTEEhPFT8pkC2m9jtS5/SHsJPQ6e9PEbH4bQeLiMuM3tk6s8IDtZzAbk0oLg+nqa5em0jpW8VaQ1auVcOI5J5oyKnzSmhTCJh5tqcMMjYkxaf9tfwIhrZdE6T7Nnn84h2e5vE3t2aZK09b5dPEAT6RFKIDC5/cgFFxs3k8VACuS6dZ5xt3cMc7BW41is8NjWhJ3YutJgYGQS+5UvsxHL4syaM5l7PH2+dBAchwjbg+GT1yOarSkhYRVah1ZVJccaIClDjPV1ERKtv6zFQa7AJ1pAjjPTHyOle0GOOAFNRan7Ez44gU7Bu3evQFfSq8XieGgbnSGqzR3E4c8yiQdJKftQQLtZHb7Ufk9qPGbXIdcYMArY6umSl5aUUXiDGRNxuSl427ynK/WNQKrtvdpGQpKnpL7mPQ5CGVTxm5Iv8L7DPg28zgh6I398DHH4aqNYHNbkUf4NqiS3IfvGetg1xTGWCjMjEGPqRjjqru7N/xi+jMgFLQ7lRmx5MfpLdZuZIGIcKY3i3LjIsIgr+cYQJpBzrMpV+T1zDLwMVzUcIzzy7zYZX4OQoZ/fUY6cyzMb6tusvKqLFrxDO+/Jb8mVerlQevENAzYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3434.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(41300700001)(54906003)(66946007)(316002)(110136005)(86362001)(36756003)(2906002)(4744005)(8936002)(85182001)(38070700005)(122000001)(76116006)(66556008)(38100700002)(66446008)(8676002)(5660300002)(4326008)(64756008)(66476007)(2616005)(6486002)(186003)(71200400001)(107886003)(6506007)(6512007)(478600001)(53546011)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3E2NzVWb3h4RHdKY2JheHZ4TEExQ04vaVZnNmcrWWpUUElTUWdOUTBZY2gv?=
 =?utf-8?B?bUZRT0VoU09Mb2N4UG5iOEhXV2JXeTMyMHcxUEF2a2VPNmt0Rk9vdzdEeW1H?=
 =?utf-8?B?cnJlMzZLM2JFeFZ2UFRTWmJiN3g0WEcxV2F4Um5jeitTWW9nbDZoU29XZGZS?=
 =?utf-8?B?NWN1U25Xa1JBZ2pGKzR3SkE0UjlNSnNVdmpDRFJCQlMwS0FOK243UkFJQ0tr?=
 =?utf-8?B?czRpSDN1Nno5bnJ6bVdUWmo0enYvYWNRWGxPTE1iL2x2SGhqWDFwdzRaQ0JM?=
 =?utf-8?B?TDJGK2c4QUYvanN2TnhuRzZ0bjY5Nnh4MWgvV0V1SFl6dzRRb2ZUR1EycUVT?=
 =?utf-8?B?OWJ5aWZjTEJ4QzdzNzJuUUtpSkMrOExLSUQwWWlLcC9PVGRSdERGUjduSTIw?=
 =?utf-8?B?MGM3S1p1MDFkMXMxNHAvUFdHdGhNVVdyUzNtZ0pCN0kvRytoelRBWllrMTYx?=
 =?utf-8?B?eDhGbDRub1Q5TExGaUp4VHVHdnlRNEx4M2ZteERRMkg4a0VHeUd0aS9vOThU?=
 =?utf-8?B?bnBldENmRkIwQ2lCdVBCbk9KYUV4d0o5Q3NCeS91eDQxSHlhMVdMTWdNQ3Fp?=
 =?utf-8?B?eE1UVkpwK2E1TWwxT0V5NktkZHZodHFiTXFzM0owZkNUVEc4bnJGQ0lhZmhv?=
 =?utf-8?B?RCtNbHZiVjhCRitzakZpU3hGZ2s0czBSQUV0VTdqbittZFV4Q1JtSGlXREdL?=
 =?utf-8?B?U3BoMTdwUndqeCt5TzVQN2R1bUxGVWFlOGRHNEhhNFc1QmQwQmxydCt2dCsy?=
 =?utf-8?B?Qmk5amRPeTlGNGhXOCtsbkZnb3VOZGQ4cmphYUJDT0x0Y2JKc2EvOEYrU2Nl?=
 =?utf-8?B?Q1c1cTQwKzNoSy9nak13Zk5EdzdHa1dadUhZenhxQzVsaVJzSVcxWG94NEps?=
 =?utf-8?B?UDMwdUUrVE9GUFRwcGZoNWh0RjBZWTJhcDdreHRtMnlGRTZYdFdSSGlUK01q?=
 =?utf-8?B?UVVoeHVtRW9xWndiV1dFUmN6dGxYY3dGQjZJdW51WitTck9ZaThpWVJOWGhv?=
 =?utf-8?B?UDZ6Um1zOXNDK2hLckpZME1tUHVxc2FpTVpOdW0zemVXbmJVcE9nRnc4aXBw?=
 =?utf-8?B?bTBHNW8zajlKSE9jYUNLSFdXdDRvUGRPRnVsL3JXamF2ODA3NlNQYTZUQnFZ?=
 =?utf-8?B?eVE4YTMzQXJQYjc3bGcvQWM3cUpaQXFVRWZncnFObU1BK01LdUxjWndpYjVV?=
 =?utf-8?B?V0Vqcm9Pc1dZcUpIQzA2bVBSakVVREE1c2lnSjNqOS9qK3ArZ21YZFBLV0d6?=
 =?utf-8?B?UmtlOENKUitxbGNNQlpzN1JsYUZsR2lIamhhZzEvZlVZN1VwVHRRcW1TcElk?=
 =?utf-8?B?eHF6NDJqVC9KUEVBbXdneWx2UUdaMDFBVWIyRkgwOGhIclJHUU01b09YUXVZ?=
 =?utf-8?B?SVVVZmNzalpUUGJ6Um8vTGVUcjBScm1EYlRKYUtDanhZVnZjTWRCb1ZKSlZI?=
 =?utf-8?B?bDEvNVVaTlFGMzJHT2dGSEVtc2dmYURyaVRlSVVSRUk4eGNSU0RIWFBkU1k4?=
 =?utf-8?B?YmtFd1dmaVZJQjlsUW5PKzVFYmdlOG5lWFlUK0Z3VmdyaFUyeEFudC9mTzE5?=
 =?utf-8?B?Z2lCaEYvQU5ROHd6RnErWUhYSEJqdGNsTlZBMUhOK2FMRUVYeDJZeWJWRDR1?=
 =?utf-8?B?Wm9zWjJnaUVBQ0lRS2VnUXFMa2NqQmxMYSt6K2M2Zk9pcEpHQ1EzS2pibEhX?=
 =?utf-8?B?YW0vVGxnQ1lscnB0WmMwUlJFbW8zTyszRGxSOEdiTThaSEdoOVZKUlpjM2lP?=
 =?utf-8?B?YnNSYlZwREF6YXRGYVZBV3oyTWJmYXpLeSsySStTVVkrMjJYbm51Y0t4dUpQ?=
 =?utf-8?B?RElFMG5xOTRNUVVzbEZ2Z2luUlpuOE1vSllIVklDUDQrM2hvR2N0SHNiWnhh?=
 =?utf-8?B?QnBpYW5EOVFsdUxtVjA0MHFUUFVYMjYvbmRKQnJYY1RUNlphV0NhWUQ5Tnky?=
 =?utf-8?B?c1VwRTZQeGkxWWxrSzc5b2JlNkpNeXU2SUFXb09majM0NlVjQU8vR2dRc1E5?=
 =?utf-8?B?M1JyTnlaYUgwOWRKcnkxVWlXSjRDeDllcUtXT245RHk4dUhHRG92RStOQ3Z0?=
 =?utf-8?B?cFdvSFdhcS8rS1FVRW9BSnY0MUR1SmVHeUJQU0owVVBkMzR6RmduRDFuM2p4?=
 =?utf-8?B?YXE1eUNpUC9sRExUandOSE42QXdIRXJpTjl0UDhZNWpDWlJUNVNJQXdLWGdB?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <228432519DB15946A6003FEA052CE945@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3434.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ff316f-fc63-426e-5121-08db042c79c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 08:15:27.0372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: keOF2kPH5lXQKV7XVyXiilGtrR7iFVyB2Bty3Y7F9ShQWmTdgTTn3WzV60sn7Srp3IvF/Gqrajd8Lkwy+2ZVVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMgU2lyLA0KDQpPbiBUdWUsIDIwMjMtMDEtMzEgYXQgMTQ6MzcgKzAxMDAsIE1h
dHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+IA0KPiBPbiAxMS8wMS8yMDIzIDA4OjQ1LCBSb2dlciBM
dSB3cm90ZToNCj4gPiBTVlMgbWlnaHQgbmVlZCB0byByZWFkIGJvdGggc3ZzIGVmdXNlIGFuZCB0
aGVybWFsIGVmdXNlIG9uIHRoZSBwcm9iZSBmbG93Lg0KPiA+IFRoZXJlZm9yZSwgYWRkIGEgY29t
bW9uIGVmdXNlIHJlYWQgZnVuY3Rpb24gdG8gcmVtb3ZlIHRoZSBzdXBlcmZsdW91cw0KPiA+IGNv
ZGVzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFJvZ2VyIEx1IDxyb2dlci5sdUBtZWRpYXRl
ay5jb20+DQo+IA0KPiBMb29rcyBnb29kIHRvIG1lLCBjb3VsZCB5b3UgcGxlYXNlIHJlYmFzZS4N
Cg0KTm8gUHJvYmxlbSwgSSdsbCByZWJhc2UgYW5kIHJlc2VuZCBpdC4gVGhhbmtzLg0KDQo+IA0K
PiBSZXZpZXdlZC1ieTogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4N
Cg0KLi4uIFtzbmlwXSAuLi4NCg==
