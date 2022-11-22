Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F6F63380B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiKVJL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbiKVJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:11:11 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E5747328;
        Tue, 22 Nov 2022 01:11:05 -0800 (PST)
X-UUID: c9381a0673cc484c8278ae669c120352-20221122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6+96Q8psJYVIeljpELblA1FMCSM0J34u4SXnL1Nfl00=;
        b=UibYWugfj9lEYKiC3wGMuyo2m2z3uZCD9m7OalVT0QAv5+OH6HWvFySo0pOxFXu3aiGM2G9OFqVUv5YS8o0Yd01Vx1xvzoLJ8MnA9ezUY8T0J0OCkwqG7bGUIXl0eRsQVPrYSglxvtM/lu2HzaRWChrA1cN7X7ygMlqMocZxrXg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:08a92332-0328-4048-8151-1075daa0f092,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.12,REQID:08a92332-0328-4048-8151-1075daa0f092,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:62cd327,CLOUDID:b717f8f8-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:221122171102F1LO1VOS,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c9381a0673cc484c8278ae669c120352-20221122
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <elvis.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1220766719; Tue, 22 Nov 2022 17:11:00 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 22 Nov 2022 17:10:59 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 22 Nov 2022 17:10:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZHf8ZehRnz/SDWixqZ3iKHdBtE7zYt6T14i8xjcmSjEE8esrdDFnKYL4SA1OotYXd6d4m8snCF85GWF8tFDf2FO8j6USvlV/KGyNXGUQQuEUxO3tePVzyP6vLzrsTUxWOIBeev/N9f/CBydK9CLRyullL1PJf7Q4akI+tu9Q6yabD4fyYe4zytrMkXd5Cxv9L6cYGynRzin7x66SLgYiL/GVzF39qFgbM9tEYxBrDQf68VuR6rLUzeuLsvIyEI512C8wfAdcy05dEaolJqpxgiA5/MLer6TQ4OVoyjdrsmWS7XJX1zfkBK55svE4sZpkIoDDU/u7LBpSv5kBmzARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+96Q8psJYVIeljpELblA1FMCSM0J34u4SXnL1Nfl00=;
 b=Mr3/xExP4YSO+d+3+pbpP6UoXhOpN0xB9S6vy0TQQBr+ARfLovxpV49gn4BQlDiAIsxz7rcLP6P20/jz1vppCOHWKVvJe4zCNR6KrOEJkaImE5M5VpSYX9hfK11el1ZIDJ3kaATi4mxnytNKvsi5Sz06NdvE6FMiuubraMUms0UzymVZ/hbhxrJZSQ2mYSR3tbDOJJIvkU/I7onYSHTkROunPH90Huk3yRXozIsE9QMpvhhot5Gng6vGTCj6dojymCAG17hXEUJ2dzuGXHhBs7tAjGR2Erod4x2mkFxO6RFwWtyBw30ZyzrsT4UOJZ5bBdyVeR1z9p/yamN8MucnLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+96Q8psJYVIeljpELblA1FMCSM0J34u4SXnL1Nfl00=;
 b=ohcbMSROQx0lih96+Nf17GpvOcyLJmCUQkU77llZqbplIwp7iUaP6MpXc8IWD4kMqveaPhpZrhv+c1C7l8fXpghdhZft6ioZAtsrh1Yi+7YXCNn6c5vzjuendJuF7y0KAUJjnOrhtTRjS4ANnPMwi8UDej+2WfSM6+fqbsyKWX4=
Received: from SG2PR03MB3228.apcprd03.prod.outlook.com (2603:1096:4:d::22) by
 TYZPR03MB5790.apcprd03.prod.outlook.com (2603:1096:400:75::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Tue, 22 Nov 2022 09:10:56 +0000
Received: from SG2PR03MB3228.apcprd03.prod.outlook.com
 ([fe80::2cfd:6603:7f27:9fe3]) by SG2PR03MB3228.apcprd03.prod.outlook.com
 ([fe80::2cfd:6603:7f27:9fe3%5]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 09:10:56 +0000
From:   =?utf-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: gce: add gce header file for mt8188
Thread-Topic: [PATCH v3 1/2] dt-bindings: gce: add gce header file for mt8188
Thread-Index: AQHY8CGITSDRLd+kw0aBh1bJxQKbsK4xtJ0AgAGgbwCAF29WAA==
Date:   Tue, 22 Nov 2022 09:10:55 +0000
Message-ID: <5ad6c51677e1476d08ae6de6bd5021384a689b31.camel@mediatek.com>
References: <20221104074443.26172-1-Elvis.Wang@mediatek.com>
         <20221104074443.26172-2-Elvis.Wang@mediatek.com>
         <bdb46b7c-6e08-26cf-491d-ca68d36f29af@linaro.org>
         <fcec5536-6ba8-9cac-2001-710a7170df70@gmail.com>
In-Reply-To: <fcec5536-6ba8-9cac-2001-710a7170df70@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3228:EE_|TYZPR03MB5790:EE_
x-ms-office365-filtering-correlation-id: 2428c7ac-1536-460c-c628-08dacc6976b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wo2UJhRiSjHXkmSxLQf3w7HLWEWkViOvW4tk+Z5Rrq4dgwilQtPB/EA8WqwF7+AfsHL4D4mm0bFDpBsdWTLUfDn2wMkziyWJFObYzymJ1T6WKCvfc4mnkw5FpghTYXOr/0ADY0ra7QxcHlxSqtzwyVCxheTSpn6/jUbocvPntbpg8asfyPxhxy0V8/b6nVi8BILpHDM4nuAhCG3YEATWa1nNUdoqVag4s5UF9RmxlpqnzKBH1mvcNMHk+VNRywf2aF1lKclKX7zLTIDHIosXeA/vcZSwoHPneoWAdutO1ALQTtKMHF35HDkLnuDuaPqfrWBY3FBWBjdPxRn2o0BnSH9kCQyTmvmYGr7RzEFEDbrYgH0+JEeWYg5CMXYPLS3Z8ugP3+M35Dn8rC/bB8BbDYww4vBd1ViAfR0BDP7q/IutsYrfWwdMjVXhsDuDYTulpDmi1T8ql+PTICxlGkNCYgjt/5vfGQQxGR2bLFyZ10UT9Zb02T1Rd8QuuWXbXEECzmB+sZL7ogaRhzbmjLfZLdqqF0eZy4De/mCsUtz/R9kgz002xBGDuDRwjEOw3F6vS6276M80t3QYRcPU8OQBPrH6lLo0JgiFUXQ/zbcRAvIyLcabjBGP/OlhOa6xf3V/03rIDfWHEi7spHoEBswkrVwtFN3FOiTZPmAIt2cD//IfuPw2b9ofEeTMBTv1iAMQGU1v8zRrfv71Dt+Q7sNHtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3228.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199015)(2906002)(66899015)(2616005)(76116006)(91956017)(66946007)(53546011)(41300700001)(36756003)(85182001)(86362001)(66556008)(4326008)(66446008)(38070700005)(122000001)(110136005)(6506007)(54906003)(83380400001)(38100700002)(5660300002)(8936002)(6486002)(107886003)(8676002)(64756008)(66476007)(186003)(6512007)(478600001)(316002)(71200400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0p0L1FwZ0wvS1lxQkhlSjF5VTBsLzJTNi9wWHdPUnhsSDJBTWZTODBOeTJB?=
 =?utf-8?B?blpqSnI2a0x0UkZlZWx0MitZbU5KdVBOMW96U2lxcjVHQkVwWUFWV0JIRW1x?=
 =?utf-8?B?SU5sR095aVY5UGU5cmE3anByd1RUVkd3eFZTdCtCVjN4UjJwQnZJbkxMaTFP?=
 =?utf-8?B?Y3VBanRaUDVlYUxwcGg5MlRnQzNzcjZMR2x4VDBGN04rdzZjMDdvNDNEcCsv?=
 =?utf-8?B?ZEdYYng2Z20wbkwrMGg5QnlHQy80OXF6YVZ4aHQwbURnYTlwQkh3aUtKb2FM?=
 =?utf-8?B?ODhzeGluczJmVW1FQkdNY2dORk0wSnJkdml3YUN4Z2NrdUZNM1lvS3RucE1v?=
 =?utf-8?B?ZUxnNTY0K2d0bzdEVU0xSjZpOUdHYVVNQmJDdnp6YkpEYmtYWDh3b3pXd3pU?=
 =?utf-8?B?eVNYUkhDUnRnVksrRU01RC9wUFhBSlhuL3BjNDVYSndiNVliQU5pb2kvOWdw?=
 =?utf-8?B?RGN4WnVOYUEzRzZGcXVxTXB3NmQydVJMUE94SFk1cjZUbzBPcGdQUnB1QWYx?=
 =?utf-8?B?blRjbEp5YzREclJaNEZVKzMyOWRMZ1g0ZFV4QlBTeGoxaWk5YStpd2htMmNu?=
 =?utf-8?B?N21mZnFWWExBbkdmbEJOZU8xSVZpYzBMTWxxNHdDUGRGdmJVQ29SdHNKMEho?=
 =?utf-8?B?dTRXQ0Q3S1QrNUlTRk1DTk1MblBnWFVPcGdOS2lQa0ltTFFxdC9oSFFIdlBS?=
 =?utf-8?B?dkJsYlMrR2dVZ0trekpNZHBRN21HWDdTVnNzWUZQaVo0RU93V2lQcURZTi9p?=
 =?utf-8?B?QTdrNk1UMlVSM1A2SGJ4R2c0dy9uaCtXVDRWTm9uL2RxMTZ0OXozWVRyalV6?=
 =?utf-8?B?TzJ6OUxZTjVBczRhc24wY0Q4OXlSM0dlN1lPb1VjeFYwUlU5Wk1lMUhkaGZm?=
 =?utf-8?B?YWx5TjRMMjZFdXJYemhDeUNLRFo4OWIvQll6SDFrUDMwNHBYa0FWeExrcUMw?=
 =?utf-8?B?dEhiaTdiR1BwNVZMYVhubjk5Zm56M0JBT1A4Vm5XMFNEVTZKNk5Mb2x3eTlR?=
 =?utf-8?B?bnRFYU4yV3FGWnBiL2IwTXkzUnovaFQxKy9kcnZWR0FydHBKbHl2bmdueUxL?=
 =?utf-8?B?bkdIYjljRi9Fb0RoSVVBZVdRZVJ3OWIyUWFZNjBaT2RZTEJ4ZDZvRUNSYVhG?=
 =?utf-8?B?aUk1eUNqazRBaEh6QlY0VTZYVHBMeG5IMUFSQWtQZExFYnBIL2xjVm1uZVhw?=
 =?utf-8?B?MTdJcjhMT1BHUVZadzlldmd3M09xZDg1RU1GbzF1TmVkT0lhN0ZpL3dpZW5C?=
 =?utf-8?B?SWNmclpCeEp0dU5KZHlrT2JDekl1a2RqaXIyK2QyRHdvZVJYRkJ2dnIzbTh3?=
 =?utf-8?B?NXBPUkY5bVUvV3dpOVNBZ2lSMzN4dXlMSTlHK09QQXYyaWRhd2lCOU9YTmxr?=
 =?utf-8?B?OE03SnU3MUZUY2xLcll1U1Y4YlJuQmFXc0tCdWFpUFI2L1VjY0xvdk5KaWQ5?=
 =?utf-8?B?WTQ1aTg2SlVsSHNlcWNVWGdqbFY4dWhHeFNzZHRJOFBtL1RWYWZDYUJJRFNP?=
 =?utf-8?B?MEhtd0ppSlRYSXppN2c3UHluUHpuN0RRT3ZyRmV5b1JacEs3bTF2aU5jWi9m?=
 =?utf-8?B?cW03L1pVdlJVTnhEMEtWRk5SZmtqb2ZBQlpldnhrU3gwUXdvTU8xQjU2cmtB?=
 =?utf-8?B?UzFJUkpTVEx4M3ZsT0N1WFF5Vm9PZzFkL0xtM3FSd1E5aUM3UEs0a25Idjkr?=
 =?utf-8?B?OGI3VDdkYytEMTFDN0JxRjB0Z05lcVowRlI1YitWc3RXcFVaZUJRRVpxRE93?=
 =?utf-8?B?MTEzT0VrenppM2JnY29kRDgxbTRkQTZwbUljSGlmb2gzTHMxKzRsd2MvWXEw?=
 =?utf-8?B?MGJIWTNLU2pXaDVuQlVrTzV3Yzdwa2hleC9xN3FWZE9YNEhKeXl1ZXRYZDVS?=
 =?utf-8?B?K0luMWE4aklZdm1rVDhScmM0ZFFLU2VCSzRVWVhoZE9QWmp1UFdxbFZkaVFE?=
 =?utf-8?B?aWVWM0RIb0xOdG9yY0JKeGJtZzJTQ1c3WDlWeGtHaTIyMlp6KzhUd3M5dEI5?=
 =?utf-8?B?UVdYNmh5dm9vT3MxSm9Vclp6WVBUeE8xT05RNGxLZ2JvcUVPcllwL3ZDVzVG?=
 =?utf-8?B?UnVTWVhaNEE5bTVxdWZCSWwySkNYbUdpY3hDRjZ6bm4xMDJyMjZEcDlWdW1a?=
 =?utf-8?B?aUROTlJmeVlrRkoxcURoMlIrYmFXY3FKeVdiazFkV0VoMlZVY3FXQ2VFQTUw?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A9ACBF9D2F02344927C0D78367E41F7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3228.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2428c7ac-1536-460c-c628-08dacc6976b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 09:10:56.1315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jzi2B7f40XEkO5alH7lAHOkfLRLklLZO3jJ8/ve4ywJ3xAW48wyKaUnMn5SfpFaET8+m5VuM5b+yl7cYb4cTsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5790
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTA3IGF0IDEyOjE4ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMDYvMTEvMjAyMiAxMToyNywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToN
Cj4gPiBPbiAwNC8xMS8yMDIyIDA4OjQ0LCBFbHZpcy5XYW5nIHdyb3RlOg0KPiA+ID4gRnJvbTog
RWx2aXMgV2FuZyA8RWx2aXMuV2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiANCj4gPiA+IGFkZCBn
Y2UgaGVhZGVyIGZpbGUgdG8gZGVmaW5lIHRoZSBnY2UgdGhyZWFkIHByaW9yaXR5LCBnY2Ugc3Vi
c3lzDQo+ID4gPiBpZCwNCj4gPiA+IGV2ZW50IGFuZCBjb25zdGFudCBmb3IgbXQ4MTg4Lg0KPiA+
ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFbHZpcyBXYW5nIDxFbHZpcy5XYW5nQG1lZGlhdGVr
LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gVGhhbmtzIGZvciB0aGUgcmV2aWV3cywgSSBoYXZlIHJl
bW92ZWQgdGhlIGluY29ycmVjdCByZXZpZXdlZA0KPiA+ID4gbWVzc2FnZS4NCj4gPiA+IC0tLQ0K
PiA+ID4gICBpbmNsdWRlL2R0LWJpbmRpbmdzL2djZS9tZWRpYXRlayxtdDgxODgtZ2NlLmggfCA5
NjYNCj4gPiA+ICsrKysrKysrKysrKysrKysrKw0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgOTY2
IGluc2VydGlvbnMoKykNCj4gPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmlu
ZGluZ3MvZ2NlL21lZGlhdGVrLG10ODE4OC0NCj4gPiA+IGdjZS5oDQo+ID4gPiANCj4gPiA+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2djZS9tZWRpYXRlayxtdDgxODgtZ2NlLmgN
Cj4gPiA+IGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9nY2UvbWVkaWF0ZWssbXQ4MTg4LWdjZS5oDQo+
ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5lMmUy
YzU2MDE2YTENCj4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ICsrKyBiL2luY2x1ZGUvZHQtYmlu
ZGluZ3MvZ2NlL21lZGlhdGVrLG10ODE4OC1nY2UuaA0KPiA+IA0KPiA+IA0KPiA+IFdoYXQgaXMg
YSAiZ2NlIiBzdWJzeXN0ZW0gb3IgdHlwZSBvZiBoYXJkd2FyZT8gV2h5IGRvIHlvdSBwdXQNCj4g
PiBoZWFkZXJzIGluDQo+ID4gImdjZSI/DQo+ID4gDQo+IA0KPiBZZXMsIEkgdGhpbmsgd2Ugc2hv
dWxkIG1vdmUgYWxsIGhlYWRlciBmaWxlcyBmcm9tIHRoZSBnY2UgZm9sZGVyIGludG8NCj4gdGhl
IA0KPiBtYWlsYm94IGZvbGRlci4NCj4gDQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQoNClRoZXJl
IGFyZSBzdGlsbCBhIGxvdCBvZiBoZWFkZXIgZmlsZXMgdW5kcmUgZ2NlLiBJZiBhbGwgb2YgdGhl
bSBhcmUNCm1vdmVkLCBpdCB3aWxsIGFsc28gaW52b2x2ZSB0aGUgbW9kaWZpY2F0aW9uIG9mIHlh
bWwgYW5kIGNvcnJlc3BvbmRpbmcNCnByb2plY3QgZHRzIGZpbGVzLCB3aGljaCByZXF1aXJlcyBt
b3JlIGVmZm9ydC4gQ2FuIHdlIGRlYWwgd2l0aCB0aGUNCjgxODggcGFydCBmaXJzdD8NCg0KQmVz
dCByZWdhcmRzLA0KRWx2aXMNCg0KPiANCj4gPiBEb24ndCBjb250aW51ZSB0aGlzIHBhdHRlcm4u
IE1lZGlhdGVrIGRldmljZXMgZG8gbm90IGdldCBzcGVjaWZpYw0KPiA+IGZvbGRlcnMuLi4NCj4g
PiANCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gS3J6eXN6dG9mDQo+ID4gDQo=
