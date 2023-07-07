Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FE574A8E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjGGCVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjGGCVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:21:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472CA1FE5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 19:20:54 -0700 (PDT)
X-UUID: e32fb9381c6c11ee9cb5633481061a41-20230707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Qlbb+indKNi1ABGCCnWDQlwvgEqKHol3bhhR8a7NBtM=;
        b=k0gVgs9jwGVL2GbVRTUj6i+YPMy4OVhz/lFxTS+6HzVLfeDRIUZKQ471iJ1c025v1kSQlRIh2d0sbwLqTqaCNrpf9VZJVyYeYBlRxPWamyrR4+uzjAEUuC6TU9rXqgzQkZR799YklqvyWLxJF3WJRYpn1GKeFZkHNzdQUYGBrGY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:bb92ae04-8b06-446c-a348-766a219a157b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:8a92a80d-26a8-467f-b838-f99719a9c083,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e32fb9381c6c11ee9cb5633481061a41-20230707
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1247447522; Fri, 07 Jul 2023 10:20:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 7 Jul 2023 10:20:47 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 7 Jul 2023 10:20:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewkUINJOTUx/t8FnpNVKh2/tO5nfk+SsegtfrDrPFTsDaPRh732HV0S2zthlcHFm7CcvmMncv1LkXiRMMLBm39xydftzQ4FT2mq0dkYDXa25bk1EcHFy7jT/Jw2XsOHGhmhlIQhRkUGzCDs9T4kI9HVvFH+AQvtVxTH3TqieMcagKqCaIPD/t8JIgnL4LvuFQZvsYBZwUuf/NLJqFNhJFQOtCI4X6gtgojR4OzQfCwCaAy8bHKe/11knBt7ZikR6XoIeP9afqQerjsb2Bzzwd52kWU7FKYPy/iof4yolI6CG1QT2+ICUU3Z/5rbRd0fd2hrlbNlkRC2BRHuc9VM3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qlbb+indKNi1ABGCCnWDQlwvgEqKHol3bhhR8a7NBtM=;
 b=mCcD7FEcN5OkY/rAQon83BhTeI8iYCXAQfqiRNecLaF/bLLd2f/mvLRAatLJ+CtZTUBW5zQai1GQA9jsGl3y3hkyFWTMF5vHzL0XFew8a8MGQK7mPMb/+1mnca6BeoxifDLcN4++Lcl0OgEYyVgZRQmxzRVpZZOPiN6B9spDbTwzQ8rpYFOjUZxA8u6k5IzaLFNuHmtijmjTa1BGuq7pbeyiYwxg7VsiMkO9Qx94tdKHY95hDi+GPp8+HY35+PlrErEcq8EJeZhRdw8pwBsWAO+YMD+6hMrdQNd+NnQXT9gTYgUbnyEbtLk93BtnVkeiVLarDSXMTDme5DvL9gwpuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qlbb+indKNi1ABGCCnWDQlwvgEqKHol3bhhR8a7NBtM=;
 b=M8mHao4t4ORfRB8lSi36L9A+PSJlaGy5I1gGUPcgvLEuY/VhWZLybor3n/J0M6H7DNTa8wuxhjdedjc0pYHlOcpQMB9IBKoQlTpa/hhAHAOuBFesCrxeuhBdtvZ8HBb343FbjVf6gUvJ7XZ0oVCNYc3oQNL8T4eYgiEv9U7wo64=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYSPR03MB7524.apcprd03.prod.outlook.com (2603:1096:400:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 02:20:45 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8cad:9f8b:a761:21d4]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8cad:9f8b:a761:21d4%6]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 02:20:44 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH v4 1/2] drm/mediatek: Add ability to support dynamic
 connector selection
Thread-Topic: [PATCH v4 1/2] drm/mediatek: Add ability to support dynamic
 connector selection
Thread-Index: AQHZlKyymUqxj9EJsUCcvuhrRhByhK+pScGAgASAKIA=
Date:   Fri, 7 Jul 2023 02:20:44 +0000
Message-ID: <1d72c987b4ff546f3905d7f2572cf38ca58e2ad9.camel@mediatek.com>
References: <20230601171513.8533-1-jason-jh.lin@mediatek.com>
         <20230601171513.8533-2-jason-jh.lin@mediatek.com>
         <8486b59895cc12817db1b21dffea925c13b4a006.camel@mediatek.com>
In-Reply-To: <8486b59895cc12817db1b21dffea925c13b4a006.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYSPR03MB7524:EE_
x-ms-office365-filtering-correlation-id: bc58698c-cc46-4504-ee4b-08db7e90c4f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0vRHV4UDGA3rvob/eNHs+xVrPfGVIidKrrKomum66oqSwQZ8h93XWc5FvVA1Tp+RjlRGJWemfkVcgzT+l1imrp3GFnDPLxBr3JteGzoazxKDQn6znREaItvexSvjKsnMCcmDGYcjUZQ5YLqPsEFLz6RpmYNkKplR6A5sG8FBuzwRw3Phs/FpJOMn7GGxwzCA4M/Nire0kCXQKEe84YgBNnDpl0PWCGIOC+fq2aV1Y4fNtD8cPYK8Dy+pId+qSuijFFbIGjO1bVQfIDp5/nkySE3OIhwc+1vDCxjKVmhU3xwrKQpwzMpIWI3n8hz7wAsOpk/QifgTWEU8D5P2N6BqZLJLtbemtf6lhURK6jN6uQff6qwvNS0BvcSDtLV9RIQHSUiss53KXtIe/PevKDj+cP+im2qAO1NZeZjAHdKPWlvfBJ2/ExAqfxRTFFmpjxT9AbZujetkf9W4LuZUAvTgZ0Z3vfWWivOOlde90OYVTLxnEPY8xvTaArAclRgjeK09ox7FeSAaIXvDJvT7nI7wmjl/Bsbkf4mc6+J+WmsnVngSTuYpdE6spdNo353XERloOzUzcXkStDx8II/0jps2nLnJm40sV4dedvf8eABBQkmIAp0tAKq6s57svXhpc5vbtYkSH1LQm9WW+No1LHrpuRpjYN88geGOfVMB6H96QLI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(71200400001)(41300700001)(38100700002)(107886003)(6486002)(122000001)(2616005)(186003)(6506007)(26005)(6512007)(86362001)(54906003)(38070700005)(110136005)(478600001)(76116006)(316002)(36756003)(2906002)(85182001)(4326008)(91956017)(66446008)(66946007)(66476007)(64756008)(66556008)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDA2ZUJtNVFDajJqcW5qcFk1czZ3VlJQNWdRekdmSWtITE5XSi9Ma1NWZ0U1?=
 =?utf-8?B?VHBtYVA5TGZvWXRXUGNRYVcyZWl6a005Q3daMGtyaTRBK3pWWDM2bFVDcGdv?=
 =?utf-8?B?L2xvbGxZdmptanY1S2FMMDN1VkUwZEFwMVN3ZzU2dCtrVzNVV2ZpcXErWmdm?=
 =?utf-8?B?OUJDRnorWjBibGMrVUJKazZmMFFWK1lRR2VXcTF3RDBLbUNETDlpVGI5aHBJ?=
 =?utf-8?B?T3dualgvR3FIUVVaSWN3d0dvZjN2RnBHQStKN0tCeFVNNldISm42a1pTMmxQ?=
 =?utf-8?B?VjVmeUlCSHJndVh5OHNjVkZDSEhKUFE3N1dZNFQ4bzBIb3dsaFNTaG9jYzFQ?=
 =?utf-8?B?NEx4YnVHeTIvVUJPU3JJSVA0cGxoUVNzTkp3NGtOMmJBbUNKREo5ZStJaDhM?=
 =?utf-8?B?akNEK1NNMnI3UWJHQ0J1elU2Z3c3WnhUZUhiMi9zSmtVOUE4bG93bjhOWVdQ?=
 =?utf-8?B?dmdUdFErSGlzK1B1ckltMWZBYU4remdOZ2ZsbUl5SHpkczN4azdRVEJuTkF1?=
 =?utf-8?B?cGQ4dDV1dlRkVEpGVVVHOGkyRXBGK2V6R21OV0RKdEx6alVUYlRvS2cwbktP?=
 =?utf-8?B?MDhWY1FOUGdSTVZ2WjE3S01xNHVQQXdzd2gxMk1KRkgvR1VVRHVkMEhacnNJ?=
 =?utf-8?B?dWhMb2Y5MkZHN3BCa0RWbW42Z2t6cTk2S3VUOVZFMTJXVDIxRmhYeTFMVEJ3?=
 =?utf-8?B?NmVhZHZTemJ1Y05zMEhtdUJUazFBM1RNeUJ6d2hmNHRtQ0JBcFdKcWZvM003?=
 =?utf-8?B?Q3RtLzdlWmsrM21MZ2NkbjBVbndhS3ZQbWRRQ0xMY0pqSW9FUzlOcGNqV2py?=
 =?utf-8?B?VzhXUjBOQU9icWRYUVlQSTEyaWcyeUJGL0s1TlpVRVlKelNGTTNTUkZmR3FV?=
 =?utf-8?B?QjZpNEZVT21IRlUvNW1BZTJxSklZRG8zcUR2T2Y4K2g3WUdEMEFxNE1rWHAv?=
 =?utf-8?B?cHNPRS9saVVnZXVjY2puQTg4ZFFWMG83cGZ0RHdER0Iwck5xSTdZNWd5N0dT?=
 =?utf-8?B?TWJWVnU3VmJxajJkekVudFVqSGRGNWJ3MWduSmJaNVVrS1pUZ0hZLzFIdFQ5?=
 =?utf-8?B?T3lQT3RjY3lIWjVBTHhWRkEvdkVTQ1F5dEs2MHBQU1pwTlcwZHhXRThrQlh5?=
 =?utf-8?B?WG9rNVd3R0ZmRGJ5R2huRVVGVmp3d0dzMCtmVGUwU2IvNXlRTk5xSDgveStn?=
 =?utf-8?B?dEsxcFFHTVhINUFlNmd2T0JYbzlMc21Qa2FzOTZ4dDJ4VTg3SDJ5ZnhleFcz?=
 =?utf-8?B?bngveXJ6MUZmM1p0ck9rSjdEQ0duazZiRHE1SHFlNG55RHhlM3VoaUNuNldG?=
 =?utf-8?B?OW5QN0dybnpmbTExNlNmcmVPb0gyZUsyMTJObDY4MzUzdmloMFRHVDUyaXpD?=
 =?utf-8?B?a0ZDa1pPaEVlRVhsSWNybFo0S2xWVUREYjRYSEMxT0dLY2tSYVRvUzRlRGc0?=
 =?utf-8?B?cEgxVFprWkZabGxPVzNweHlWelVZYWN1dkNibUQ5bFRVS2hiU1prb3FGNko1?=
 =?utf-8?B?NW03UDFUdEhhcUNYZkkwdzJjb2pMcnVIWHNyaXVUak1rVVBreVI5bTZvZ3dV?=
 =?utf-8?B?bXArQktyTXN2TGxvUEF1QkdOSmsrN2FGekI0UXh3cHE0SmZwN0IwVC9RN1BK?=
 =?utf-8?B?Yy96YnJ1Q3loUHp2eUR6ZS9kV20rTDNKU0VEOUpqbklidVEwVVFlNGhLOG1t?=
 =?utf-8?B?S1k2Z3c0aFZTMUdpN0hKazY4dXB1dWI0a21nV1R1SEcxSzEzK1R5NGJqaDA4?=
 =?utf-8?B?cStXZ0RQcDFKNG5aN1cyYjlaZzdZbzBiQXpEeTloWWVvV3BRenhjMHZRczNV?=
 =?utf-8?B?RWhkTDJFTDFpelAyUmsxTVNhdGpXUG5SMTR4YjNUR25XaEZiMzI5a2U5dDJ1?=
 =?utf-8?B?c2VCdU1UYmEzcVRXdHkvSlBDMFJadW1vc0ovT1ozamJ3cDF6bE16eUNheVVn?=
 =?utf-8?B?U1FYRWtncCt1bUtxRFJXaVl1dVhodUNtcWwyTDB2Z3ZZK2ZWS1RIbTRMc0RN?=
 =?utf-8?B?RDR6cTA5ekNEaVhzYjlWUlhBdE9VR2R3ci9lRmtzT1pVTVNlSHR0KytlZGh5?=
 =?utf-8?B?SzZTYzVKMDdkWHRSMHBIZ2oydFZ2ZmI3ZHBVeEVTUlJiNjluc0l3QzFxcVp1?=
 =?utf-8?B?ZGpSTnNzZitQK2NOR1ZiVzF5M2RpV0o0eG44SjU3TWVzMGFtMzZ5dTBmTTZL?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A69C3EC698388F4F90FB30A372720B26@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc58698c-cc46-4504-ee4b-08db7e90c4f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 02:20:44.7588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6G7aOEWlFy3hjqZfX5ChqsVbOtbLsLazcN4o9gca3GyTW0N8CpQ2RKucPOETs41CMqnrvGHI20+GqBBPF68YrYBOl7bBwIbXYoMTsUxYvwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7524
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFR1ZSwgMjAyMy0wNy0wNCBh
dCAwNTozNiArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIEZyaSwgMjAyMy0wNi0wMiBhdCAwMToxNSArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IDEuIE1vdmUgb3V0cHV0IGRybSBjb25uZWN0b3IgZnJvbSBlYWNoIGRkcF9wYXRoIGFy
cmF5IHRvIGNvbm5lY3Rvcg0KPiA+IGFycmF5Lg0KPiA+IDIuIEFkZCBkeW5hbWljIHNlbGVjdCBh
dmFpbGFibGUgY29ubmVjdG9yIGZsb3cgaW4gY3J0YyBjcmVhdGUgYW5kDQo+ID4gZW5hYmxlLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE5hbmN5IExpbiA8bmFuY3kubGluQG1lZGlhdGVrLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYXRoYW4gTHUgPG5hdGhhbi5sdUBtZWRpYXRlay5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsu
Y29tPg0KPiA+IC0tLQ0KPiA+IA0KPiANCj4gW3NuaXBdDQo+IA0KPiA+IA0KPiA+ICsNCj4gPiAg
aW50IG10a19kZHBfY29tcF9nZXRfaWQoc3RydWN0IGRldmljZV9ub2RlICpub2RlLA0KPiA+ICAJ
CQllbnVtIG10a19kZHBfY29tcF90eXBlIGNvbXBfdHlwZSk7DQo+ID4gIHVuc2lnbmVkIGludCBt
dGtfZHJtX2ZpbmRfcG9zc2libGVfY3J0Y19ieV9jb21wKHN0cnVjdCBkcm1fZGV2aWNlDQo+ID4g
KmRybSwNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZHJ2LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ID4g
aW5kZXggNmRjYjRiYTI0NjZjLi4wNDEyYTgyYzFlZDAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiA+IEBAIC0xODUsNyArMTg1LDE0IEBAIHN0YXRp
YyBjb25zdCB1bnNpZ25lZCBpbnQNCj4gPiBtdDgxODhfbXRrX2RkcF9tYWluW10NCj4gPiA9IHsN
Cj4gPiAgCUREUF9DT01QT05FTlRfR0FNTUEsDQo+ID4gIAlERFBfQ09NUE9ORU5UX1BPU1RNQVNL
MCwNCj4gPiAgCUREUF9DT01QT05FTlRfRElUSEVSMCwNCj4gPiAtCUREUF9DT01QT05FTlRfRFBf
SU5URjAsDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3QgdW5zaWduZWQgaW50IG10
ODE4OF9tdGtfZGRwX21haW5fcm91dGVzXzBbXSA9IHsNCj4gDQo+IE9ubHkgb25lIGNvbXBvbmVu
dCBpbiByb3V0ZSwgc28gaXQncyBub3QgbmVjZXNzYXJ5IHRvIHVzZSBhcnJheSB0bw0KPiBzdG9y
ZSByb3V0ZS4NCj4gDQo+IFJlZ2FyZHMsDQo+IENLDQoNCk9LLCBJJ2xsIHVzZSBhcnJheSBpbiBb
UEFUQ0ggMi8yXS4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IA0KPiA+ICsJRERQX0NP
TVBPTkVOVF9EUF9JTlRGMA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVj
dCBtdGtfZHJtX3JvdXRlIG10ODE4OF9tdGtfZGRwX21haW5fcm91dGVzW10gPSB7DQo+ID4gKwl7
MCwgQVJSQVlfU0laRShtdDgxODhfbXRrX2RkcF9tYWluX3JvdXRlc18wKSwNCj4gPiBtdDgxODhf
bXRrX2RkcF9tYWluX3JvdXRlc18wfSwNCj4gPiAgfTsNCj4gPiAgDQo=
