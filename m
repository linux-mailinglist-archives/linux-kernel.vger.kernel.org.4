Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F168F6C1046
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCTLH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCTLHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:07:05 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2442940F5;
        Mon, 20 Mar 2023 04:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRj1vUZGlNRWq4+0VXG0aieyw/wegWH2p//8PrvCSzM0rydEtQW6H1wTpcQUK1icKOU8FplTDgO36UxHM0WujxmG+SjEz0vZYv/410kVAuNNE4rj1P1FGA+/I1pHJ9TriMfTwSPyErgnLDtjDJ2DGLn0MnzcF81hviWK22qEj/DBWlxbygrF+9HMf8ewUDMHQGPZRNmuQhNI8ctgvsjzM8NoaK2SWIPMiR4rmKKJS/dDRlNhMfqE1wg1LUMPjuOaBBdVZv2ZbWof0fMZ7tRR3gQRsR8lfJOkCls+nC18SNjnj+LONC6ttyp4aML161oo+DIy1YSlnx483fwDVdCXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kcbb4a/IsVRVJo+5NTrWcRHMTGLy1dUkBg3gYU6+hGA=;
 b=eZbauk/JJ+F6HyCbpXV66mdu+9Pbli9gA1p4QONBDmVJruWseWsPODBrsgpwRDEHqgMZvOR8xDWUI/oAQLERWv5bvmJZigYoEWg/w52Ve9/47jk+DCR4MK5pfGRROGBmWld2AvncII8TkWkkdowxX/alj16QT0ArPKtzxuWMCn4jrIxYzK4Ahild7StSZ7DBTfZpnKUNcBaqNK6Ao7gUDeILW2z4ycJMWWoYVQTHKy3ebiPI57MHnAO+Dm/mvgPmSxyhlUJbDwyhfKCbOQvjVFOjsphnb3rddYy9epjrJY8uc9RpOr+4QeflbGzFGQey7XbRqFYie9mQurA+SK9v8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kcbb4a/IsVRVJo+5NTrWcRHMTGLy1dUkBg3gYU6+hGA=;
 b=rZiSK5xYjP3hFKW/DlRYOc4pF9xqxs+pvslkd67x0rr6aOdEOzoyvKlWUy0qRMOwmGZX5/6/+tJny5IOJ/DxQFsNZgmHucB7s3fjGQIxsJF1XzeJ8k9fIC0dkHUWMViltqH73GZf80p31mcekuBfBnnmIr3XdPNfeRGC6A4D5jo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9410.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 11:02:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 11:02:06 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH linux-next] dt-bindings: usb: snps,dwc3: correct i.MX8MQ
 support
Thread-Topic: [PATCH linux-next] dt-bindings: usb: snps,dwc3: correct i.MX8MQ
 support
Thread-Index: AQHZWs/6lJ7epjxGPkeRDAwzZgO0X68DPJiAgABD8SA=
Date:   Mon, 20 Mar 2023 11:02:06 +0000
Message-ID: <DU0PR04MB9417D88E67200F4A74C5CF4888809@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230320020714.955800-1-peng.fan@oss.nxp.com>
 <8efe78d3-ff50-1970-3a90-28bab4992bad@linaro.org>
In-Reply-To: <8efe78d3-ff50-1970-3a90-28bab4992bad@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS4PR04MB9410:EE_
x-ms-office365-filtering-correlation-id: 7d089542-befa-4296-964b-08db29328b5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vu+Ju03M041XaS6mbQ8IrRTpmCqxhfd2QFr0kiFNFUPYcZcbSXiv2hWFpJiZImzYa9MYz6GzWNtPMVRdWYOrDf23hjm1eDDPSo9gceagWRnY/Y8qcSP27II8HE+8gfgPXeFP4IWsoPrfou1vaCpfWYdDFMGvUj3w+NsVk4RJdP7xUdDLlS5FQAUb76GHce7PsnejGwmTcjWNL2MtaJkk0HDfNR7UcBR8ignjRx5EyCYsxg/FJl+fEUcXPDSYVU+ECD1dX1WSUHEOTywal9jTs8ijnxhw5L79URx5URr3J/8zFqMZp62cfMN7zySCGG/h2Ksi8OeV7pNU8NAubv/jtEAAOwERQJ9zaDVbtNg3qSD1ujpEwajB4hqr6UZPBAW1kOnfby5L25IGO04aqfw4g0g7JN/fK5NrswD6B6/g8u/bD7WZFL4dek6lhRjbx3HqgKGhaXZre6moB8ys/xWNC9fHG8NqaaEQDCR5EYL0siYfzHclEHOhxNfCZzfKH3RNHiu33HsU1MdCIv7QOof+zafIB1wjcUsNhg4+9ORic4b6FtKsxMS84GWp4DJDBdu4b2l2JDYni+pzthG7wt1+eFWh+PsWRfTVPVO3k5XvTrgyIEzmfQfNAXFVaJw8FQYDSp5iE6Dvt+7pPUaRjG2fcMT0bG7XT69HNE+WedIwxH0IzV6XK/8mOP7+MHioAWYS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199018)(7696005)(186003)(478600001)(9686003)(26005)(966005)(83380400001)(6506007)(54906003)(53546011)(110136005)(6636002)(316002)(71200400001)(66446008)(66476007)(66556008)(8676002)(66946007)(76116006)(64756008)(4326008)(8936002)(44832011)(52536014)(7416002)(41300700001)(5660300002)(122000001)(38100700002)(2906002)(55016003)(86362001)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekg4emd1L2F1MG1LV3lIYVpabkt5Q0x4YmIwSGhwWjR0TGtTVmp6VXAzbVlB?=
 =?utf-8?B?ZFM1cER5Sk4wWWowL2pZYVlVM3FZVE1uYVp2cmRTNG5KbDA2UVgzaTR5L0Zz?=
 =?utf-8?B?Zk9zMDg0Q2dZQ1ZUVVBRMm1iRG5TNFRrMkdkZ2RFYldTRHdwUTBtVHNzSkZj?=
 =?utf-8?B?cHduYTFyOTFZU29EaUtlN09BcWlNZ0VET1lkbFh2OGVMZVdqMW1JV3YycTU2?=
 =?utf-8?B?L3hUMDBVL3diU2pqUWtsQm9ZaGVuelRsTXdWTG5vZjJHOFdUMDdHTENmQUZF?=
 =?utf-8?B?M0QvUUFBQWRvMStsSUU5cEVaVUh5OHNlTjQyMWNhamF4Ky96dzlXOGhOZmx6?=
 =?utf-8?B?bFNaWmg2Zk91a0VFOW1OemluaG1MMkhKNXRNNUIrTi9xRVI4aGZzMEJuNFQw?=
 =?utf-8?B?aVlncHJZcnI5a2JSejYzMWRQd3JQRlRBWXJhUGdaYk83U3hmREtqKzJLM3Zm?=
 =?utf-8?B?amJzaFdROWhSOTdDODJMZzhTYXpaWmFucTNKamwzekw1MTNQMWRmUk92Nzla?=
 =?utf-8?B?M2h4c3lmeWo0c2grMHdrcDRIam9NdEZ4VEFHeWwrVnUzNGg1Um5mb1pOa0w0?=
 =?utf-8?B?VUZiMVpDR2hsT3B0MTZ3UjdCa0NVR1BWT213NE1helRiYlVGNFIrSFN5aXVa?=
 =?utf-8?B?clVUbVNaTWRiQm1WRTFVYVJnY1R4bndZaEpPcHV6cm14MTRWRlBkQnBFTEps?=
 =?utf-8?B?eDFJQTZKS0dUOEtaVE91NGZhZkE4NU05ZXdJQWxDRU56TXJYYi9rWG8rUGhK?=
 =?utf-8?B?WkZra3ZRQzc0b28zb05DUnVFVDZONVNBaGNobFBNck9rZTg5TTJTa3kvV1Iy?=
 =?utf-8?B?VXp3ck5qbHhmYVlyc3hwV091eXAyNjQ1TTdFd0JoVE8vVzA3QTFvZjByTUw3?=
 =?utf-8?B?Z01kNS9LWVZMay9PVWcyRmJNK3pSSXRJeis2RkZDcFkxVnhoTnRDTzNuMTJ1?=
 =?utf-8?B?K3d6NXlZbG92Qm5Hd1BUVVA3cmxCK2FWWEVDR0lzUXlVdWtsai9iQ2pZai9U?=
 =?utf-8?B?NTFZNjZFT0NFcGV5eWpLRXRhNGxqdUlEbWt2M0FWNGlqTi9xY3htTTd6ankw?=
 =?utf-8?B?Z3RxVnY4RlRmbjMwTHUwOG51eHZ0bkloWXZoRGdxU0JXL2ZqZnc2eVF1M0Ur?=
 =?utf-8?B?WDJ0MkM4SjhtNXNZL1FaZmdDWmFQa01MNWRveUlrY2VxU3FSdHZwUkR1TDBu?=
 =?utf-8?B?L1J6YVY2ZDl4bThhTk5QdU0ySHNlYjNRbVU5WUxJZHQ0cXo2VTlzbFBiVkkz?=
 =?utf-8?B?b2g0ZjhIaEk3emZJb29VMGY0d0Izd2FFYjU3SVA2VThFVHZ0U1oxanpvK2hG?=
 =?utf-8?B?TnhtNFIvVWdrSW5mS05GVzk1NVZUZ0V0R1pFTUdQQkNYOHFvQ1U2OEZhTVEx?=
 =?utf-8?B?dkxHN1BmRGVqS00zM3V5M09IbDV4SXV3WFE1SmRpNldzeEw1YktPdG5YS0t0?=
 =?utf-8?B?YmxoTXEzeUFtOXN3MTlOVHlKZUsvSkpTLzdqanNLTXN0bWdUVnpkcTVyeDVE?=
 =?utf-8?B?L000b0c3RGhpTVhwS0FwbE03VFRsU2dmaWhhOXNYYTJIcy9teXAvcjlUZGh1?=
 =?utf-8?B?MUNzbHBhdldoUXZBYjJGS01sT0tSSGw3WSthczlyMTlQTkJDekVmVzBkbTRz?=
 =?utf-8?B?V1F3U0RxZ2dsdzZQNVlscmZ2emRNUldoZDNBSzRUTnVnS0tWN1NYYWZvckNN?=
 =?utf-8?B?dFJlMzM5cWx6TEhNS3orNklVL1ZERUt0MTJ6bE9qWHNHd2RYdTlKcjNkRk9n?=
 =?utf-8?B?OEZjRmZLbXFqU0lidVhHY0crZjR6RFFMamxGZTVCY0pqQ2dNTzBOL1hVWEZy?=
 =?utf-8?B?S0QrVHc1dGZpNFBxSXpTWDU2UzY0STl1cU5KNmsrbkpPdVZta0hpRGhoVFow?=
 =?utf-8?B?VlcxY3FrQUxwQnJuZHZhNm9jamFkNUpnK1hBQ0h2MVI1d3B5YndmQXZkdjVR?=
 =?utf-8?B?dHhGZ2hjL2lNeUlYSUxZTkgyaVV2cnl6bnhETzY5YXY5blBXS1M5dmhraW9Y?=
 =?utf-8?B?SW55WWRpYWRHVDdaQVFrbHJqUXc5RWExWTdOUUtWUGx2cDdPa3l4SFZhRTF0?=
 =?utf-8?B?cFpHVEp5ai82eDNKWWo0ME16Rk12cktDdlFBMEJzd3FyN3R1akdXMHZWTkZi?=
 =?utf-8?Q?QmXo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d089542-befa-4296-964b-08db29328b5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 11:02:06.5727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9t+xt1kv71St9yiQ6IzIkKinVNCq022ekkKVFOAFArP7EoMUgvQg9GO51hhU3xnBqcBRvc45N6gjwG8BSrG1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9410
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIGxpbnV4LW5leHRdIGR0LWJpbmRpbmdzOiB1c2I6IHNucHMs
ZHdjMzogY29ycmVjdA0KPiBpLk1YOE1RIHN1cHBvcnQNCj4gDQo+IE9uIDIwLzAzLzIwMjMgMDM6
MDcsIFBlbmcgRmFuIChPU1MpIHdyb3RlOg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBu
eHAuY29tPg0KPiA+DQo+ID4gVGhlIHByZXZpb3VzIGkuTVg4TVEgc3VwcG9ydCBicmVha3Mgcm9j
a2NoaXAsZHdjMyBzdXBwb3J0LCBzbyB1c2UNCj4gPiBzZWxlY3QgdG8gcmVzdHJpY3QgaS5NWDhN
USBzdXBwb3J0IGFuZCBhdm9pZCBicmVhayBvdGhlcnMuDQo+ID4NCj4gPiBGaXhlczogMzc1NGM0
MWM3Njg2ICgiZHQtYmluZGluZ3M6IHVzYjogc25wcyxkd2MzOiBzdXBwb3J0IGkuTVg4TVEiKQ0K
PiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0K
PiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Ivc25wcyxkd2MzLnlhbWwgICAgfCAyMSAr
KysrKysrKysrKystLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy91c2Ivc25wcyxkd2MzLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy91c2Ivc25wcyxkd2MzLnlhbWwNCj4gPiBpbmRleCAxNmM3ZDA2
YzkxNzIuLjYzNDdhNjc2OWVlMyAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvdXNiL3NucHMsZHdjMy55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbA0KPiA+IEBAIC0yOCwxNSAr
MjgsMjIgQEAgYWxsT2Y6DQo+ID4gICAgICBlbHNlOg0KPiA+ICAgICAgICAkcmVmOiB1c2IteGhj
aS55YW1sIw0KPiA+DQo+ID4gK3NlbGVjdDoNCj4gPiArICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAg
Y29tcGF0aWJsZToNCj4gPiArICAgICAgY29udGFpbnM6DQo+ID4gKyAgICAgICAgZW51bToNCj4g
PiArICAgICAgICAgIC0gZnNsLGlteDhtcS1kd2MzDQo+IA0KPiBBbmQgd2hhdCBhYm91dCBhbGwg
c25wcyxkd2MzIGRldmljZXMgdGhlcmUgKHdpdGhvdXQgc3BlY2lmaWMgY29tcGF0aWJsZSk/DQo+
IFByZXZpb3VzbHkgdGhleSB3ZXJlIHNlbGVjdGVkIGFuZCBub3cgdGhleSBhcmUgbm90Li4uIHNv
IHlvdSBqdXN0IGRpc2FibGVkDQo+IHNjaGVtYSBmb3IgYWxsIG9mIHRoZW0uDQpbUGVuZyBGYW5d
IA0KDQpJIGFtIG5vdCBzdXJlIGhvdyB0byBhZGRyZXNzOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsL0NBTF9Kc3ErbnJxVFg1TkQzPStrRlVtU3R4LStiPXFwRV9Xc0xfTGUtWVg4YzI4NS01
QUBtYWlsLmdtYWlsLmNvbS8NCg0KUm9iIHN1Z2dlc3RlZCB1c2Ugc2VsZWN0LCBidXQgSSBhbSBu
b3Qgc3VyZSBob3cgdG8gdXNlIGl0IGhlcmUuIFVzZQ0KYW4gZXh0cmEgeWFtbCBmaWxlIHdpdGgg
c2VsZWN0IG9yIGVsc2UuDQoNCj4gDQo+ID4gKyAgcmVxdWlyZWQ6DQo+ID4gKyAgICAtIGNvbXBh
dGlibGUNCj4gPiArDQo+ID4gIHByb3BlcnRpZXM6DQo+ID4gICAgY29tcGF0aWJsZToNCj4gPiAt
ICAgIG9uZU9mOg0KPiA+IC0gICAgICAtIGl0ZW1zOg0KPiA+IC0gICAgICAgICAgLSBjb25zdDog
ZnNsLGlteDhtcS1kd2MzDQo+IA0KPiBJIGRvbid0IHVuZGVyc3RhbmQgd2h5IHlvdSByZW1vdmUg
eW91ciBjb21wYXRpYmxlLg0KW1BlbmcgRmFuXSANCg0KTXkgbGFzdCBjaGFuZ2UgZHJvcHMgJ2Nv
bnRhaW5zJyBieSBtaXN0YWtlLCBhbmQgYnJlYWtzDQpyb2NrY2hpcCxkd2MzLCBzbyBqdXN0IGJy
aW5nIGJhY2sgdGhlIG9yaWdpbmFsIGNvbnRlbnQNCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
