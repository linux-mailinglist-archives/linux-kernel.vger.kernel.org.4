Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6793B72F2FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242347AbjFNDSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbjFNDSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:18:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368B1198;
        Tue, 13 Jun 2023 20:18:35 -0700 (PDT)
X-UUID: 2215ca2e0a6211eeb20a276fd37b9834-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=B8mW9jmqtSp7e9EVL1vLsoaXX1wvIbs/k15jZBqk/tc=;
        b=FndiNauh1ERvVy+uyRcQ8fkJ8weuSX3Yl7Rm9VTNRjxlwMy0IwM2Xq765Y4K7TVZdEIptJWxmc9m79dFVRdN1SaC9J+Ttd7TlAjqX6/TWwLUuqXie7nx6m3JIod/2L8Fdii28BM3YUjCpmXJlKrpA9RLbVJSm3B3wMZ02pwV65g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:9e3dbada-2c80-4e73-9258-a44a88caf809,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:cb9a4e1,CLOUDID:01b05a3e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2215ca2e0a6211eeb20a276fd37b9834-20230614
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 776880965; Wed, 14 Jun 2023 11:18:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 11:18:27 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 11:18:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZjBxAAH+HIxk61ZyE8ilGQzUVmTYn/qXYQkcIeLRD8XNy8xTURW6ULJsTyFgqFYlsnzu2BXwAZcobKzDFdMn4fLz8H1oKUCD4ZrSG7yK64F7MHGo9NR0B7F4mEPit3Y0nf5JOW6YPbfDveMiLRdp6AfcDps8FPqmVP42A9CVGW4I+DtxdMzlnEpyevKZ6CTzrkKiupWIauRH0ERYs2ABOPoa7zbiLV9ia3xYjEzKveYH1exhP7XhLE1ytQiF1UevK2xxmNxz6awJgLuP+Pt2NhGwcFzkt5ZgqDAlL45+C4lh6MNxFuKAscjell7Itc0mjKZSPnNdvclPRVUME1KOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8mW9jmqtSp7e9EVL1vLsoaXX1wvIbs/k15jZBqk/tc=;
 b=WmwvRgDpjH5VIYqqAz9xXxA80tu/TZcCGrsPiPoHQmXaH5JJWG8NZAe+cPkGyfxKq474L+tHQHrvdygAgYC1QnLPPY32Ecr0Wo6I86zSwg5xsdr/nlLczWeqiNVAw3gNsYGQeRmfsbj+L8ghDewLW86NmujK7ASisf92GcLzYg5gVnUPYGquDtfM+orsyaUg3s7mdteivj7zSYKB7RQLgJ1jhMr3slTVVmfn3GLVlTNvhLYmVWVtnQrnOuTAzOyuWDmn71cG5ZDMI/Sg10o3vKygSKsP/OGYW1fooIFMATpNQBNQiikT5bBMJeOj2ZyHxyNae9DUHNyaWwq9HYZ68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8mW9jmqtSp7e9EVL1vLsoaXX1wvIbs/k15jZBqk/tc=;
 b=rfBvjMbaUEAcEScYATD8/FKOHJANVO7qZN35OtXZcXdQpE9tNiKpk+SzcFjijervqU7ZuvdoFAdusIvLV5gM5ky9OU2S9GoPD4UBNt9OIfeg49jv/XFnq5pZHb00rjwVgQmtXgVbFiwX7CEpjZKbBPV+EUhJpvU6c4D9/r4wTB8=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by PSAPR03MB5496.apcprd03.prod.outlook.com (2603:1096:301:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 03:17:24 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::cf4d:1ca0:d375:a32d]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::cf4d:1ca0:d375:a32d%3]) with mapi id 15.20.6455.043; Wed, 14 Jun 2023
 03:17:24 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt79xx-afe: add audio afe
 document
Thread-Topic: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt79xx-afe: add audio
 afe document
Thread-Index: AQHZnRwwFFXmmj8e60u4F1KEKx4v7q+IblCAgAE08IA=
Date:   Wed, 14 Jun 2023 03:17:24 +0000
Message-ID: <14913cbb87981eed6f8b72f9e659ed3e25958320.camel@mediatek.com>
References: <20230612105250.15441-1-maso.huang@mediatek.com>
         <20230612105250.15441-8-maso.huang@mediatek.com>
         <d9cd1ff3-b537-1481-9453-5b3683d30fed@kernel.org>
In-Reply-To: <d9cd1ff3-b537-1481-9453-5b3683d30fed@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|PSAPR03MB5496:EE_
x-ms-office365-filtering-correlation-id: 7fd04551-c198-4ea7-48f0-08db6c85dfc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7EiIBZhyBSFE5RZteXrsro6YxIANg8o4kv0GtwtYBtE8kikYzsLGP3SnJ9AsPViU0WBMnhhgBs1ZO5/6D70loN/pvuS0ltL8B60A11OQ58DpM5GNnv/gDOw2QvPV50bTfJrafWPS8KSzpVEw84zO0xy3AMnSeP7KiPOfnVvB8wFsDYo86pht3BrOcauiJWsQz6jdcZYzKHjCVAe6v/q8hTW3RQDHa+GgCZzdBYYMryucAn640arwJPklnYm4cd1j3Gxnvy60FRGBqby8Ek8uGxzAgTA5VYXfYURZXTrh32YV/IYaQ/ezBfnfpqAdgnLqd9qggucNJpxCKTXCM4zidlxSFlmZ1aKGuo2bEc4GELPFt5MyZBWGWGKo2Zjw4oFHeorKeWO7jxlwRPuac4gLfVScf7W+rce0B2Vo6k9BnWbmWYaSYQgzXvWlBRwxM3V9Qr77fmFevtP3YANeiIXk14HCzH22CIl0rKdlYbRKsU5caeccc+cKtAEcQrme2JDn95O+4ZuWhCS5IrlpGGdIn6muO1DNuE+HbHvoMxYJtV3W/v0k0hRppRBXe+ierGh6AywzPh4QUV5rgKEUO2DsyC3uJ/XW/F+Jyb73vSsL1bsU+vop2stCEhWe1Sq4mVP9CSaZoE0oC9xhVjoc/ggwhGufcfcTKzeBLWH+as9MrV8xJP8WTBFseYMuqCF9peVEqUQQTT0uwGJX9WksWUscig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199021)(83380400001)(7416002)(85182001)(64756008)(6636002)(91956017)(76116006)(66446008)(66946007)(110136005)(36756003)(316002)(5660300002)(6506007)(53546011)(26005)(6512007)(41300700001)(8676002)(8936002)(66476007)(86362001)(122000001)(38100700002)(66556008)(2906002)(921005)(38070700005)(478600001)(71200400001)(186003)(2616005)(966005)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG5WSTg0dXB2Vm04S3JtUTdaYm15eGxFSTNZUXl2eWlDMjRJZkxRVEpIWW9j?=
 =?utf-8?B?WmVSa1IyS2ZTZ3BobXlGTEJ3bUgwMzVYWXZqU2FSTmJmL09WMWh5R1M5aGFP?=
 =?utf-8?B?Q1NYWUgrc3ZhZG9LMzhjejMwYnNiK3R3QUE0d3RiOWJMZktUVE80cmw4QkZi?=
 =?utf-8?B?QmE5OWdYY2ltZ2VKREMzT2JMcVRLcWY5Rm9Qd1JNaWNRMm5IT21Qd0dOR2hj?=
 =?utf-8?B?M09QVXBSV3hLZldPV3pkNzdMZXMybUZLVEhMWVdrSmg4VzFLY3dUNWtRcys2?=
 =?utf-8?B?Ky9sMEpwdEsyZityN0JiNTdNT0FYbTdRbWd2S0taVzZ2QTZoR3BhSWtLZ3Zn?=
 =?utf-8?B?cy91VE5NellxM2VDNUxFdEo1VnM0WG9YKzJ1MjRpOHRZVitzbkRubUhtTnBS?=
 =?utf-8?B?TmpkUEREbldhOCtFVHAveWRDcEk3SzdmbXVzems2ZWpnZWtoM3Y1M0NmQnFX?=
 =?utf-8?B?eHkzQTROaUZoelZMRm8vZUZnQnBNa0JLSGlRWU00bWxJODM0aHJYN3E3aVZm?=
 =?utf-8?B?SWh3R05tdFpJUmJreXAyTld5SlVaTTA5NHBvZ0cvbHFHdTN5Y0NKa3N0dldp?=
 =?utf-8?B?STZDOWV5eVZMT3ovb3BuZXp4UVJJYUdIMjBweHJNY1R2Yk9sWlgyQnB1S0Uw?=
 =?utf-8?B?M0NpMnVxRFZCbW11RzFKY3EyK1kxUFFqM2daYzFPekQ5b1Z1YWIweFltVmRp?=
 =?utf-8?B?Vmtwckhld0UrRWlmai9CUU1wTGZscHVaYkZGTS85Rlp1QVVLOVBZcFVhdy9r?=
 =?utf-8?B?MjFiK09HT2ZtSnQrWURzbElueTlnbFR5RXpHYytJemJRbjZCcFVkdS9GeU92?=
 =?utf-8?B?dTkwUDFSdG9yQk5JODQ1aWMvMHl2c0YyUVF3WGVxaWM2OHc5bGMwTDM1QWNh?=
 =?utf-8?B?cUdzVk1UcEJnZU5LMTB6Y3FXckF4KzlwcFZtaWtEeE5vU1pzUzJ3N28yZk5n?=
 =?utf-8?B?SUJseW9ETDZzbm5kb2FJdXZLbXFxUFVzQ1VKUGltL2wwVWNGSWVyZE1sUy9v?=
 =?utf-8?B?TU94bml4TXFmOXR0T2JGZVlWMVpIdHoxdUhYdWpRZHQranh3MFk3eU1tYnd4?=
 =?utf-8?B?RVM4bnVHcWlTUkM2dWYxR1R0d2lGdGhwaklIOHR5c0lLSlo0RFhNdFNjUkUz?=
 =?utf-8?B?dTVocm8xTWMrTXdOU0FJRE5yZzhBWFpSYnpweVdzNnhUZXcvL0RnR0ZkaUxQ?=
 =?utf-8?B?dGQ4UFNLbjJyZU5CYmdtNW5MZC9VWjIySUpDUEIveDB4N29ZZldGUWdrL0NJ?=
 =?utf-8?B?djZkYXpqcWw4bHZhekhZRDlCbGRxSmFkTmdsdVNsT0R2bStHRGQ5Wk0wT2dk?=
 =?utf-8?B?YmFnNnMzMFZKaDdZYWdWVnZrb0pQdktiazNDQm5oYjVyR3V3eitKMGdaMDVv?=
 =?utf-8?B?V05OT3BnUEpIb1hvem9Sb0Y2ZWZmZUptb1l0SmU0U2xJc2Z0QUJEcE02WG1k?=
 =?utf-8?B?VnoxQXJPTmRnRlFQU2N3enNEelJZSlZHMnpabllXQU5ZeElzL0cvaWQyejdy?=
 =?utf-8?B?SEFIZUdoelBobUdKeTJXL0ZBTDlDdFlyeURNVXEyeHl2V294bkFEVnRxWkY0?=
 =?utf-8?B?UEZ2SWM3aTB1TWt6T2haVVRKSmZ3STJlUCt5RFFRU3hXYTNVcWdobXpEVDhP?=
 =?utf-8?B?UXphVng2eHliS2htYzVBdzA3ZjVDaU1LRUF3NXFJTjl6aGozQ2RuZGNrbUxo?=
 =?utf-8?B?QThva0hBbzMzeDFHRCtxZXlkZ1FmTmlaVTJ6c1FwZytncnk2cHgyakJjTUww?=
 =?utf-8?B?Y2R5QTVKTUxjQ040dTRIMDVhQVRhYS9qZXNxNlJYWnA5Wkw0MlFtTVhZY2RY?=
 =?utf-8?B?LzMzQ3h5eFNYeEplWWhmK3QwSVoybDljeGtpaEtTQ2k0YTRkOTVnSmlGS1N6?=
 =?utf-8?B?MmF5QWFkSjM1N3Q1Y3hSaWJodU1KWnRZOWt0c0diTkM0QTQ4dlZLZG9HZ0RQ?=
 =?utf-8?B?R3Q3S2plSkgraXhCdExaSnoyZTdVR3Y2bXRUbE15QXhUQ1ZTUngyRGZ0ajVD?=
 =?utf-8?B?aUF3VXVXb01TQk9sLzZrc082ZWFQWFFpdXUyWXdpbSt6eG92STZKV2FJVkFh?=
 =?utf-8?B?NEJUa2tRZmY3WHdrUndBc2dHOHJVa2tQeStlL3NGNWlveTNkL3ZjYW1uWFZo?=
 =?utf-8?B?QTlhVjZkVEYzQ21VSEx0dXdhT0haS1hyZm9sUm9NeUovQlBtTlY1UW1Cak9r?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1839820A5E9B2043924A868FAF5B8ED3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd04551-c198-4ea7-48f0-08db6c85dfc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 03:17:24.3587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXu7TPYpqVbirYgkinT9qJACojYLZXFku9B1A/SVCpsao4ZIIHn7QjtDRFCvSKkHqoLjFnG32r9I9JXIEoOTTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5496
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDEwOjUxICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIA0KPiBPbiAxMi8wNi8yMDIzIDEyOjUyLCBNYXNvIEh1bmFn
IHdyb3RlOg0KPiA+IEZyb206IE1hc28gSHVhbmcgPG1hc28uaHVhbmdAbWVkaWF0ZWsuY29tPg0K
PiA+IA0KPiA+IEFkZCBtdDc5eHggYXVkaW8gYWZlIGRvY3VtZW50Lg0KPiANCj4gUGxlYXNlIHVz
ZSBzY3JpcHRzL2dldF9tYWludGFpbmVycy5wbCB0byBnZXQgYSBsaXN0IG9mIG5lY2Vzc2FyeQ0K
PiBwZW9wbGUNCj4gYW5kIGxpc3RzIHRvIENDLiAgSXQgbWlnaHQgaGFwcGVuLCB0aGF0IGNvbW1h
bmQgd2hlbiBydW4gb24gYW4gb2xkZXINCj4ga2VybmVsLCBnaXZlcyB5b3Ugb3V0ZGF0ZWQgZW50
cmllcy4gIFRoZXJlZm9yZSBwbGVhc2UgYmUgc3VyZSB5b3UNCj4gYmFzZQ0KPiB5b3VyIHBhdGNo
ZXMgb24gcmVjZW50IExpbnV4IGtlcm5lbC4NCj4gDQoNCkhpIEtyenlzenRpZiwgDQoNClRoYW5r
cyBmb3IgeW91ciByZXZpZXcuIEFuZCBzb3JyeSBmb3IgbWlzc2luZyBzb21lIG5lY2Vzc2FyeQ0K
bWFpbnRhaW5lcnMuDQpXaGF0J3MgeW91ciBzdWdnZXN0aW9uLCByZXNlbmQgdGhlc2UgcGF0Y2hl
cyBhZ2FpbiB3aXRoIHRoZW0sIG9yIGFkZA0KdGhlbSBiYWNrIGluIHYyIHBhdGNoPw0KDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFzbyBIdWFuZyA8bWFzby5odWFuZ0BtZWRpYXRlay5jb20+
DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDc5eHgtYWZlLnlh
bWwgICB8IDEwMg0KPiArKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEw
MiBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ3OXh4LWFmZS55YW1sDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdA0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b3VuZC9tZWRpYXRlayxtdDc5eHgtYWZlLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ3OXh4LWFmZS55YW1sDQo+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjExZWYxY2ZkZjQ5Yg0KPiA+IC0t
LSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c291bmQvbWVkaWF0ZWssbXQ3OXh4LQ0KPiBhZmUueWFtbA0KPiA+IEBAIC0wLDAgKzEsMTAyIEBA
DQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTIt
Q2xhdXNlKQ0KPiA+ICslWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2Rldmlj
ZXRyZWUub3JnL3NjaGVtYXMvc291bmQvbWVkaWF0ZWssbXQ3OXh4LWFmZS55YW1sIw0KPiA+ICsk
c2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4g
PiArDQo+ID4gK3RpdGxlOiBNZWRpYVRlayBBRkUgUENNIGNvbnRyb2xsZXIgZm9yIE1UNzl4eA0K
PiANCj4gNzlYWCBzb3VuZHMgd2VpcmQuIEFyZSB5b3Ugc3VyZSB5b3UgYXJlIG5vdCB1c2luZyB3
aWxkY2FyZHMgKHdoaWNoDQo+IGFyZQ0KPiBub3QgYWxsb3dlZCk/DQo+IA0KDQpXZSB3b3VsZCBs
aWtlIHRvIHVzZSBtdDc5eHggZm9yIG10Nzk4Ni9tdDc5ODEvbXQ3OTg4IHNlcmllcy4NCk9yIGlz
IGl0IGJldHRlciB0byBqdXN0IHVzZSBtdDc5ODYgZm9yIHRoaXMgc2VyaWVzPw0KDQo+ID4gKw0K
PiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIE1hc28gSHVhbmcgPG1hc28uaHVhbmdAbWVkaWF0
ZWsuY29tPg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+
ICsgICAgb25lT2Y6DQo+ID4gKyAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10Nzl4eC1hZmUNCj4g
PiArICAgICAgLSBpdGVtczoNCj4gPiArICAgICAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAg
ICAgICAtIG1lZGlhdGVrLG10Nzk4MS1hZmUNCj4gPiArICAgICAgICAgICAgICAtIG1lZGlhdGVr
LG10Nzk4Ni1hZmUNCj4gPiArICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10Nzk4OC1hZmUNCj4g
PiArICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10Nzl4eC1hZmUNCj4gDQo+IEkgYWxyZWFk
eSBzYXcgQUZFLCB3aHkgaXQgY2Fubm90IGJlIHBhcnQgb2YgZXhpc3RpbmcgYmluZGluZ3M/DQo+
IA0KPiBUaGlzIGxpc3QgaXMgb2RkLiA3OXh4LCA3OTgxPyBTbyBpdCBpcyB3aWxkY2FyZD8NCj4g
DQoNClllcywgaXQgaXMgd2lsZGNhcmQgZm9yIG10Nzk4Ni9tdDc5ODEvbXQ3OTg4IHNlcmllcy4N
CklzIGl0IGJldHRlciB0byBqdXN0IHVzZSBtdDc5ODYgZm9yIHRoaXMgc2VyaWVzPyANCg0KPiA+
ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBpbnRl
cnJ1cHRzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2tzOg0KPiA+
ICsgICAgbWluSXRlbXM6IDUNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0
aW9uOiBhdWRpbyBidXMgY2xvY2sNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogYXVkaW8gMjZN
IGNsb2NrDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IGF1ZGlvIGludGJ1cyBjbG9jaw0KPiA+
ICsgICAgICAtIGRlc2NyaXB0aW9uOiBhdWRpbyBob3BwaW5nIGNsb2NrDQo+ID4gKyAgICAgIC0g
ZGVzY3JpcHRpb246IGF1ZGlvIHBsbCBjbG9jaw0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBt
dXggZm9yIHBjbV9tY2sNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogYXVkaW8gaTJzL3BjbSBt
Y2sNCj4gPiArDQo+ID4gKyAgY2xvY2stbmFtZXM6DQo+ID4gKyAgICBtaW5JdGVtczogNQ0KPiA+
ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gY29uc3Q6IGF1ZF9idXNfY2sNCj4gPiArICAgICAg
LSBjb25zdDogYXVkXzI2bV9jaw0KPiA+ICsgICAgICAtIGNvbnN0OiBhdWRfbF9jaw0KPiA+ICsg
ICAgICAtIGNvbnN0OiBhdWRfYXVkX2NrDQo+ID4gKyAgICAgIC0gY29uc3Q6IGF1ZF9lZzJfY2sN
Cj4gPiArICAgICAgLSBjb25zdDogYXVkX3NlbA0KPiA+ICsgICAgICAtIGNvbnN0OiBhdWRfaTJz
X20NCj4gDQo+IFdoeSB0aGlzIGlzIHZhcmlhYmxlPw0KPiANCg0KbXQ3OTg2L210Nzk4MS9tdDc5
ODggbmVlZCBkaWZmZXJlbnQgbnVtYmVycyBvZiBjbG9jay4NCm10Nzk4NiBuZWVkcyBmaXJzdCBm
aXZlIGNsb2Nrcy4NCm10Nzk4MSBuZWVkcyBmaXJzdCBzaXggY2xvY2tzLg0KbXQ3OTg4IG5lZWRz
IGFsbCBzZXZlbiBjbG9ja3MuDQoNCg0KPiA+ICsNCj4gPiArICBhc3NpZ25lZC1jbG9ja3M6DQo+
ID4gKyAgICBtaW5JdGVtczogMw0KPiA+ICsgICAgbWF4SXRlbXM6IDQNCj4gDQo+IERyb3AgYXNz
aWduZWQtY2xvY2tzDQo+IA0KPiANCg0KT0ssIEknbGwgZHJvcCBpdCBpbiBuZXh0IHBhdGNoLg0K
DQo+ID4gKw0KPiA+ICsgIGFzc2lnbmVkLWNsb2NrLXBhcmVudHM6DQo+ID4gKyAgICBtaW5JdGVt
czogMw0KPiA+ICsgICAgbWF4SXRlbXM6IDQNCj4gDQo+IERyb3ANCj4gDQo+IA0KDQpPSywgSSds
bCBkcm9wIGl0IGluIG5leHQgcGF0Y2guDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6
dG9mDQo+IA0KDQpCZXN0IHJlZ2FyZHMsDQpNYXNvDQoNCg==
