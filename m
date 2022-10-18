Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495A4602195
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJRDB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiJRDBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:01:51 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20054.outbound.protection.outlook.com [40.107.2.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9EC7DF5A;
        Mon, 17 Oct 2022 20:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBlXozPow/SRVrIhde4HjU2R4XXRABy+zg1sko6mzhhOIx9Wd6GL9yuQMD+YeG5Lx3PLf02PS+bYtBwyzogABu8L5B0lsv46RpKzDCu414OrZpuYrn8oBYCZrl34g4AejAJ4zA38h2E1eQystSnYtg3/imZbuOmEyxU5VCgljdn+ThSb/vXWTI6eGsRA+zJf+fgh7quAwcAUpuKFBR2JLKVczhvUeZpKWuVH9/7u/iPJCHIKbhFiOMI2k2HOnsFeGEKWnze4w7gXl9kyiQwDioenvjVONQrZgxTs2USAvVnTGySN6OeOS/gJl1FS3Usa7RlnVz+LD088QQR7D4Eu8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtFBOXJMToFjOJkLU1IkNO5fJRWoh5Qvy87z1Bgy4Xk=;
 b=cKNRflrSNaYux2BufN8YirT94/b8HYflWPLyGsub9xKsPVm481M24GY9aIAL1pFZQyKHE2i/Gug4O/+7ph5fJypdFBtc0S6c5kAdZADDa99i65RCEOPH+Rb/OQBi/k49qHmX2gdDoVsirG4mAoKnA276laY/5JG9X7SyuWXpvVv8s6RHo9/r5gzuuhRfOffRyNMirOQ8i6Ttz+pgBKr+Ze6MhznagqdFQzXJAUyf1CrmcemYeFbQ10rvLEu4GL1ludwGHY/dKuwvG3uFElJjgKwCJ+Mm11vNwy4TRjH7uYEDPi7rhASplSgsUsOLQXUDTwUeOKh99avoI+XgfubmKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtFBOXJMToFjOJkLU1IkNO5fJRWoh5Qvy87z1Bgy4Xk=;
 b=LT15W3lgkbBnwSuKZDfo8ka5Xw4Qhncfq+5UYUHAklR5tlO/rSZSyezrJESq9AERDZ5BJD2v+UWp+3vZ39ZpLTNCdHrRQUJmH1TELzXh0qKMcJMTNCDNDLQW4vRhu0ItXI2oYmc3NSQb5rf+yHgHA0wr5FEbnAYgLTeT1stvHm0=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DB8PR04MB7178.eurprd04.prod.outlook.com (2603:10a6:10:12e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Tue, 18 Oct 2022 03:01:47 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27%3]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 03:01:47 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 4/5] ARM: dts: imxrt1050: remove mmc max-frequency
 property
Thread-Topic: [PATCH 4/5] ARM: dts: imxrt1050: remove mmc max-frequency
 property
Thread-Index: AQHY4oQGGNgoG1j5XUW2LOSZGIvgRa4TdDUg
Date:   Tue, 18 Oct 2022 03:01:47 +0000
Message-ID: <DB7PR04MB40100794ED12BA4224CD6B1B90289@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221017235602.86250-1-giulio.benetti@benettiengineering.com>
 <20221017235602.86250-4-giulio.benetti@benettiengineering.com>
In-Reply-To: <20221017235602.86250-4-giulio.benetti@benettiengineering.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|DB8PR04MB7178:EE_
x-ms-office365-filtering-correlation-id: d2fe3be6-88b2-4bb2-d78e-08dab0b51886
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x4DBfAnq5395XXHIiDz9f5SYt0sTF8i18+VhL1juhLv/w51W5JzJpvl/0qkWUxDhFcfdF+1i28s1ovkiWR/7agxy8GbZy9MBCZV1YvJ0GlO7IfcwJes03BV3AURNBGjGwKZr00xejyDHQjclXMtfdoupaJ+IkaBhvjvJf2b9oWm8j3FnFUrIBYMdTKtnVAXEmsCRmfYXe/nRE97bOzMhJDtuG4y4Gnw01RHXUmWRTtMur99DHw72F4NQoSfF6hAu0tF65OSvIHd9uQ6zEhmW9Sifvw1BYrtj7BS3aXYwy90yueYessprmPtxaDaeJdzsQG7bEMwwDPrAqL44BUbKoo6H3L86rgoNgw3eoCW4R0DYQJ2iquisvyIXZxvm7L7EPxU9FCGvf9gIwgChMR1XISCFjPvcWGkoJJEiFXV70WQD9gIkcpQJJr2rtp8h9R/hfbH/r8Q9+sEauxrql6l7WSNlIDbpFMJGkUSS3H/6x5zXpWLtCSmgnN9kjHZh4SLr2EmuxSj3FJbFs08ePtvQB2PYGywC9dkCfTD9Xqk28eGegBdG5NQb3jVRhp1I6HxyPuWQFfEhxi/CHKqzpM7i4cNF78jgaGR0bt6Pt6YBUzbDRe06VlHXXJH35fN8QoM77X/222JqnP8WcgaQ1gD01hnGUYVR4YtquDMz5pYbN7rsRz1tdJ4F7VKdQOHYYnO1gUkwDL0zOZRp/SJKSjtjsB2jrUa9RoGgv7jppNuQNTpZCCitUBM0sr4CWs2Mf8H9ysOrn+zul5vxi6VWioVXgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(26005)(9686003)(186003)(41300700001)(478600001)(38070700005)(2906002)(6506007)(33656002)(4326008)(52536014)(5660300002)(8936002)(86362001)(53546011)(38100700002)(7696005)(110136005)(122000001)(54906003)(316002)(71200400001)(8676002)(66946007)(66446008)(64756008)(83380400001)(76116006)(66556008)(66476007)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?emRrOXp1amdySStQTGZtajd5bVQza1pWRXhTOWEvN2x4dmpGK3B5dnYyRnBQ?=
 =?gb2312?B?cjk5cmZKcDl3VXpSTDVkbG9ZME5FTm5sTUlQeVcxNHloUEdJTEJxYnpkK2xP?=
 =?gb2312?B?UDczZENPWkoranBXRmM1Qm9tZjB4cTdLTFAzSVBhZkl2RFhFK3BrTW82MG5I?=
 =?gb2312?B?MGg3Vm1pUnhQSndxa2ZibU9hanBhZlRjbTBWU0t5eVFzVkdja2tuaVN3amFs?=
 =?gb2312?B?Q3N4RUFrNXA1WjZISU9qVzZHcGt3SGVmUFR0RTVZdmEvK1VHNDZ3T1ZBbVNl?=
 =?gb2312?B?VE9vcVZoWnFOM3pYRjZDMGpDNHFjaUQvNlBlUUZtVktLVUxYcGVEY3ppMVhk?=
 =?gb2312?B?QzE0c1FsT1hKTVZFZHpDbUQ1K2g3SWg3U21HZG9vMkl2UUxCdkVSdFFvb1ZN?=
 =?gb2312?B?KytEK2d0Z0lCQ1JaZFYwVDZvZGU3NHN5ZHE4SHl5NnR0aFNRelYwcTdZc0VG?=
 =?gb2312?B?a3J6UHRBaHhRVmNJSEJYYkJQaFFNL2Q4eGE0ZHd6ZS8wZnRKcHNoSWUyYlFY?=
 =?gb2312?B?UGJ0cGFtUnE5NmY1SlRHaTF3cllPSjJqV2lxN2lzUkRLSWJQZ2JubmhXSkQ5?=
 =?gb2312?B?dzlQYWlMVFpMcjdNaEx6VXFGL1hvWFJTaTZlS2xZVFFvSUVneXowUVJoYlRN?=
 =?gb2312?B?amkzRWl6dGRpZFZiNzFOeVNTQytqRFhxS3ZsVDZlZFJQVE03bytKd0RrUXhk?=
 =?gb2312?B?SG50elM5OU1QZ2sxVXpJVDRXY3VuWFF4bks1bk9FbEx1cjhrZkhFR1A5VWJF?=
 =?gb2312?B?SzV6bjNvRWpRa3d5V2w4M1NmUktRVkRLNWRVUk1nYVpVUCtKSW5ZUnh3YnRS?=
 =?gb2312?B?dDNEYzVMbEtKU0IzZHZKa2I1OWpqMkhxNU5xTStEeE5UZ0lHM2xtSHcwZDZP?=
 =?gb2312?B?ZHE4NjAxY1RlTTZuOTZRcjFkSUovN3cvNzRHMXpzTDJ2aTMyNjZRb0pKemRE?=
 =?gb2312?B?THFIQ21hOTlOODJkcjVLa0UrMmttb3VYbm1ONStTWncvNEV3TDVzVGlKOGNQ?=
 =?gb2312?B?VG9sbVNjUWVRTXFsTE5RMEhNK3JOYmh5bnRPaVFGdHpWQmthTHhmUVRYTW9J?=
 =?gb2312?B?elBORS9LK0p6WkVwUEpsejhJbG1IaFVqKzFCK0hLU0l4QWFZYXozK0hyVWQx?=
 =?gb2312?B?M2JmZ1lZcFNxay9oRnEvQ3AyQWFBRHF6cFdLQjJtMWltenRPY0J6M2JpT2Fo?=
 =?gb2312?B?d0djR3RaZ2RsZkZyd1dhQ0lQdGRlUm1wbDBrSCtJOW9ZS1JrSUdtemFnc1dO?=
 =?gb2312?B?bGNnMVB2cVQ3aWI5R3RrOHlMVG5VT21iNzB1R0RsL3FaMDBXcTFlNElSWWNv?=
 =?gb2312?B?REkzY2lXeEhqZTBUWTFBbzNra284TmVmVS9rQnh6WnUvN2p6ZW1la2k2dUV6?=
 =?gb2312?B?VWxkRW5CV0VzMUE0SDloQ1p4bnAwMmV4VVBZalF4d0FWYncxNXFkYlVMNExa?=
 =?gb2312?B?Wk81WkZjTXpvYUdySXhrd21XdDB4RnYxZm1hZ2gvQXprUElDb1B0QUFGaktt?=
 =?gb2312?B?LzZ0dWI4YmlIVytPNEc2MkZ4QVpLYkRiakZid3YrRkplUks3K2FLQ0pmS2xR?=
 =?gb2312?B?dFlnQ2E1UUJ0ZTJ0MkVDV2g3R2ttbGlydVk3eE9EUXRsZytRakE2V2N4SjVy?=
 =?gb2312?B?dmM0YTkzSGJBbWFvMVFpUGpuVVEydmExWTdidnBTamRxazRacUMwSnZzQXQx?=
 =?gb2312?B?OFNtVzhEeXVWZW5sOUVRNjJLS0lQaTJSdFR5VkNZU1NnbG1PUjVhTWpCMmc0?=
 =?gb2312?B?ZVBpeTRVZU9uV2pQTUlhdnRuL1doblRQWkZrOWpscTVXU1dsWUxBYU1IWlBp?=
 =?gb2312?B?b1lhd1Ewb2FJVHY0dmhHWi8yOWpqcUw2Z1lTY1FBcWQ2Zk8zSnc5MmttNld4?=
 =?gb2312?B?NmpueFVidEs3VkdTdXRrQmNhYkZKVExLRW82dm96eHFLYm9rd20rNXUwZjNp?=
 =?gb2312?B?WFpYRzRWWHR4RERMN0wwU2d5RmgydzlXbDc5ZDlQRFM5c1NWRkRDTWQ4UTZV?=
 =?gb2312?B?am43cXhrSy9oNG1sVXVUVCtIcC9Cb2FUQUZSVmpsQVo0azcwSXZFazVlYVRK?=
 =?gb2312?B?ZDVwcFJhNlNPVEJ2Q0pJSHcwdnp0eFVwSlNjcjNaY1J1TGw2SURNNDVxNzJt?=
 =?gb2312?Q?VNB7IJFXZmoFwGqvsbC4QGKHG?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fe3be6-88b2-4bb2-d78e-08dab0b51886
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 03:01:47.3093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2PxLYYIsq9V35rrKzE6mqIYdSfuQrZmBnW0pobGsyPW4C7VjcBKTGg+1Qg7qPFlFyZ7+Vj29AePYFgN/IU/eaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHaXVsaW8gQmVuZXR0aSA8Z2l1
bGlvLmJlbmV0dGlAYmVuZXR0aWVuZ2luZWVyaW5nLmNvbT4NCj4gU2VudDogMjAyMsTqMTDUwjE4
yNUgNzo1Ng0KPiBUbzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtbW1jQHZnZXIua2VybmVsLm9yZw0K
PiBDYzogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPjsgQm91Z2ggQ2hlbiA8aGFpYm8u
Y2hlbkBueHAuY29tPjsNCj4gQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
OyBVbGYgSGFuc3Nvbg0KPiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IEdpdWxpbyBCZW5ldHRp
DQo+IDxnaXVsaW8uYmVuZXR0aUBiZW5ldHRpZW5naW5lZXJpbmcuY29tPg0KPiBTdWJqZWN0OiBb
UEFUQ0ggNC81XSBBUk06IGR0czogaW14cnQxMDUwOiByZW1vdmUgbW1jIG1heC1mcmVxdWVuY3kN
Cj4gcHJvcGVydHkNCj4gDQo+IEFjY29yZGluZyB0byBpLk1YUlQxMDUwIFJlZmVyZW5jZSBNYW51
YWwgdXNkaGMgc3VwcG9ydHMgdXAgdG8gMjA4TWh6IGNsb2NrDQoNClBsZWFzZSBkb3VibGUgY2hl
Y2sgdGhpcy4gQXMgSSBrbm93LCB0aGUgaS5NWFJUMTA1MCBhbmQgaS5NWDYvNy84Lzkgc2VyaWVz
IHVzZSB0aGUgc2FtZSB1c2RoYyBJUCwgbWF5YmUgaW5jbHVkZSBzb21lIHNtYWxsIGRpZmZlcmVu
Y2UuDQpGb3IgdGhlIHVzZGhjIGluIGkuTVg2LzcvOC85LCBJIGNvbmZpcm1lZCB3aXRoIElDIHRl
YW0sIHRoZSBjYXJkIGNsb2NrIG91dHB1dCBmcm9tIHVzZGhjIGNhbid0IGJlIHVwcGVyIHRoYW4g
MjAwTUh6LCBvdGhlcndpc2UgbWF5YmUgbWVldCBzb21lIHN0YWJsZSByZWxhdGVkIGlzc3VlLg0K
U28gaGVyZSBJIHRoaW5rIHNob3VsZCBjaGFuZ2UgdG8gbGlrZSB0aGlzOg0KIG1heC1mcmVxdWVu
Y3kgPSA8MjAwMDAwMDAwPjsNCg0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4NCg0KDQo+IHNv
IGxldCdzIHJlbW92ZSBtYXgtZnJlcXVlbmN5IHByb3BlcnR5IGluIHRoZSAuZHRzaSBiYXNlIGZp
bGUgYW5kIGluIGNhc2UgYWRkDQo+IHRoYXQgcHJvcGVydHkgaW4gdGhlIGJvYXJkIHNwZWNpZmlj
IC5kdHMgZmlsZSBmb3IgYSBzcGVjaWZpYyBkZXZpY2UgY29ubmVjdGVkIHRvIGl0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogR2l1bGlvIEJlbmV0dGkgPGdpdWxpby5iZW5ldHRpQGJlbmV0dGllbmdp
bmVlcmluZy5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14cnQxMDUwLmR0c2kg
fCAxIC0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14cnQxMDUwLmR0c2kNCj4gYi9hcmNoL2FybS9ib290L2R0
cy9pbXhydDEwNTAuZHRzaQ0KPiBpbmRleCAxMTQ0NjVlNGRkZTYuLjBiNDRjYzRjZTZhZCAxMDA2
NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14cnQxMDUwLmR0c2kNCj4gKysrIGIvYXJj
aC9hcm0vYm9vdC9kdHMvaW14cnQxMDUwLmR0c2kNCj4gQEAgLTkzLDcgKzkzLDYgQEAgdXNkaGMx
OiBtbWNANDAyYzAwMDAgew0KPiAgCQkJYnVzLXdpZHRoID0gPDQ+Ow0KPiAgCQkJZnNsLHdwLWNv
bnRyb2xsZXI7DQo+ICAJCQluby0xLTgtdjsNCj4gLQkJCW1heC1mcmVxdWVuY3kgPSA8NDAwMDAw
MD47DQo+ICAJCQlmc2wsdHVuaW5nLXN0YXJ0LXRhcCA9IDwyMD47DQo+ICAJCQlmc2wsdHVuaW5n
LXN0ZXAgPSA8Mj47DQo+ICAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAtLQ0KPiAyLjM0LjEN
Cg0K
