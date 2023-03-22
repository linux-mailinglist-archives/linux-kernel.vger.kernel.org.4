Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FC36C58E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCVVk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCVVk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:40:57 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA372B60C;
        Wed, 22 Mar 2023 14:40:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQofMC3AKpuIXt6nFCzZl0RqgTyaZqCOs6cGmf2g7R3jC6azZio6sPRNk6J9Z/pu5RSy8JXAD83NTJKJe+nUdwg5LlQTOK/XDj0isf8xCeUXZuZl9tS7nBLkTfRQKxjEgeA4fDvNruEONCwqtR/c6b0FJcqYW92j3bq6gWNbit/98EBfbXmnde2+kcgT5OcMA7c5B7C/10cOkxAvHlULl9upd60vgCWGcR789T8jPXmYZMht7Sk8h/clsyn9K063zf9EMkMA0F1swJfkk8UhjId6iKFT1v6NUo81vL3vZuMFSVeKwBRjBLX3gjJUMHcqW4Hk/I5XQpVZWdqnslDFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vSrzYU7vSLP43qhuQ1ta9CftkoPZTyado4Lsf+9I8Y=;
 b=DQsaavI+ZZ21DMmXnlJSE4uBQs1IxYfQj9p1xf4Obc8jSJYp5Jrlo4twwhHxzmz6MBOLEPYCLAllHHsiUSoBFrZ9YK3zkrbSScX7+BasOPi+ig0BUbOp7pPIu27c/NBvEgQzHwjMyYD1hEurSv/azV54FoHvSIa0lqKfVhK7lDL+M654qpDIBFxWV1ip7+fVbg0AxnJ96cr3EdIOfdBrU4nK9qnJGkA99dn4+qePN/BtKcbztGWIFwjmFVVEa2jiXS/dDojO1eO2TqLX0vERrVLI656P40LMM7AWqDec16C3iOSx1MsN161UnlcDxFuruJHjKwcjgwT4O5MSWkGb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vSrzYU7vSLP43qhuQ1ta9CftkoPZTyado4Lsf+9I8Y=;
 b=ct8cIUhAWpQEwCqXzYx8f9CTuIvamV8ETwazkIXJ1/EZ++O8yDy9BNAU3a2fkLeoEID7DsVZ8Bj+PsNlflKe3StmHm+EdHlaxqsnrpn+KfY7PkTq6jCV+kTHy7tMh3DtbeAKFd4kPIzcdtXVaYqGdip/BcxZoQfE5ip0YEWlX9M=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9277.eurprd04.prod.outlook.com (2603:10a6:102:2b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 21:40:53 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 21:40:46 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [EXT] Re: [PATCH v3 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Topic: [EXT] Re: [PATCH v3 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Index: AQHZXAih0MCX1q8KWEWxpTpi/nrVFq8GaNGAgAByipCAAHgTAIAAAD6AgAABboCAAAA0kA==
Date:   Wed, 22 Mar 2023 21:40:45 +0000
Message-ID: <AM6PR04MB48383C58EF1D9CFD8F7C401E88869@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230321151951.2784286-1-Frank.Li@nxp.com>
 <20230321151951.2784286-2-Frank.Li@nxp.com>
 <1ce3bf91-6bef-b4c1-1ec9-3a345518efeb@linaro.org>
 <AM6PR04MB483828FC1083E3C98930DF6488869@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <b5d67af0-ed08-e243-2c0c-92f1f002e552@linaro.org>
 <AM6PR04MB483841E17BEEE4F9EC596DBA88869@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <835cda64-5d42-1ff3-aa8f-0802fe3d705f@linaro.org>
In-Reply-To: <835cda64-5d42-1ff3-aa8f-0802fe3d705f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|PAXPR04MB9277:EE_
x-ms-office365-filtering-correlation-id: 56610cf4-1cd2-4422-dc9b-08db2b1e1848
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UyPRZdNuHNMbvs2AavjDU7KlZzsWHC3TX25wObYFJGYnntvbiomGsL2hZhEgNCdw9RErT2asHohZy4CEgsdSp7WUF29lT+hFEo2/loI4CaXUbMaR8AF/F5GvRBxXgqSA8BbEiD3M0jtsGz8E/PHK5/L/Ft22iyUOZJxHw97SiImN0jJHvsR12ekoCvtwzUZLoFj4zVYZQgw3c363bGjlw35XxRasqcjOdIfaXE9S2pfH0eozUtOG8OCadtjvlp3fFR3nyu74j+ZJyzbeJz4He8Cpc/Ugktl5Tdw3NIbATpX3dLVhlzE9Ye7/1YdqPwQtILUIAKUkBWWEogxNcG84HZY5zUl0lrXjUNbXEZ2ELB/qr7oAsOndy/HQHHQJ9NepvAc2LpDC4iavQhVSsKA5l4FWFm1VhPWFHMc8tKNuVGnkC8021GmgEF3mIbM4IoW+XkAH1z/tjv6BW9ga91T5m+22jv1Ann4fh69clgg/uCWwzTC6HS30UgvcR+kIeafqHo3bgLW0n0ozKa7fHtkD9E81lAKno5UE2cnwQLAOlYHh2412UXnspQP9g+eLdAdBVKSbCl0ZBmrfV/o4mtL7HMJzewzdrRw4pdUwG9FfDeZQqm8RXeVnqHfnSbedhpRMUalxEk7FYJZkO0KzziMIi81ZkpIA1DXgphB+EcodFY9YTAdCR+8vm95f/ead0HGNkRQFTRhZ51x01xfNeR4dmv1IaaLsj7xxqi7/RPQ+yzg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199018)(8936002)(5660300002)(26005)(6506007)(52536014)(55236004)(53546011)(66446008)(478600001)(38070700005)(41300700001)(66946007)(55016003)(8676002)(66556008)(76116006)(64756008)(6916009)(66476007)(4326008)(7696005)(33656002)(83380400001)(71200400001)(186003)(122000001)(54906003)(38100700002)(44832011)(9686003)(316002)(2906002)(86362001)(7416002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek9ZSHZzcnJselI2NnNGbXBKaGRBNysvaFlVWlFHZHFpWS9GZzEyb3dkWVBU?=
 =?utf-8?B?SW42RUNXMFp2bytLaUZGOWttVVhBN2NNeDVWdFVjcThQSmd5VmRHYnN1VVR6?=
 =?utf-8?B?ZHdPejBjamJ6eFozSXNtVWdGMDF0ZzN0cU9HWmZFQ3l6bCtmNytES3EyVkk1?=
 =?utf-8?B?ZkwwNVErNDRDdjBYL0pVWmxHaS9CT251MW1KZTdBVWJYQmxjdXd0NHZZUkJx?=
 =?utf-8?B?Yy9oakwySDJESWVEanYybmkzeEZIUGhBVW5EYitjRkZFbXhGU1JTbnI2RXo0?=
 =?utf-8?B?MUpqd2FMM09QNXBzdkkzQ1MvdlhIWmJDWkNPQjlaSTlUNTBudUQrK1ZUNVJD?=
 =?utf-8?B?VVo2eUZQb0ZjaVhNU2RiTzc2RS8zazR1bWdRc21rWHFjd0NUNFFqbUFZQTJK?=
 =?utf-8?B?bkVXeUxiQ0N0UUFjZ3ZFLzFKb29JSWlDRU5WeCt3RjZrOTM2VXRlNER0T1hB?=
 =?utf-8?B?dkIvSVN5RS9Ebk9YUVJWaGViOEc2aXpjRDRuN2I4c2drT0dCQzFZMmdKWTRS?=
 =?utf-8?B?Vy9LVklNUldjKzBXcGFjTUJoYUVQOWo0SkI4TVVlNlg4TmVUSjRUTFNhdFJK?=
 =?utf-8?B?QXUvcG5vREdudFZndTREdGlVSGFLNFloc2JZVHlNTkhjcFpMM1hmclZQTUkw?=
 =?utf-8?B?bGptWGllSkpFUW1VRWRTVkpkbFZNbVQwdEJMWmNRTFNETk9DUk1uU1U3RE91?=
 =?utf-8?B?L3c0WGE4eEhkQ1ZKK0txR0RINU54ZE9vWnY5aGJQQk9NMjBXSXhZamVDYlQz?=
 =?utf-8?B?cDNodENDandTK3Q3M0U4YzF5UGFoRDA0Z21LRlRVS2gzNmlLVjVhOURtWXZ2?=
 =?utf-8?B?WElxdVA0R2pLcmhZbzRDejRseCs4VEhSTmNOYUNwSWFueFRZOXU0ZUhFVHBp?=
 =?utf-8?B?TWFQRHd6eDR3czkveUdXOHZXNCtrWDRoMy9FbDBIM2dGTU43L0dOSnJ3YUpK?=
 =?utf-8?B?WU8wRWFpMngwa2ozK1lONWE4czRSZkE0c25kdnNlbndGZHo1eCtrNTJ5Q1pV?=
 =?utf-8?B?dVg3ekpLZ0RNTUd1ZmxKS2U4QVl2UUVRd0E5bW0wbTZFbTRtTCtrMWQ5Vjk5?=
 =?utf-8?B?bytBRXdtWHpmY0FTcW9YejF2QWxUd055cy91Tzd5REJUckZPM0NxWXNCZTBZ?=
 =?utf-8?B?aHVLU1JwMDBDZWl5V2xwNUNDQ0RWRmEvNys1YS9CWlZvM0pkWjhTaVh5Z3ZI?=
 =?utf-8?B?MzZkL0lqcFp2dkY0dnJMeVFtaU50UjVxZC94YWpsWElDeUY1NVhXN0krNGRQ?=
 =?utf-8?B?ZWZ4OFVxYXNJdGJwc3hjWEs2VFBxd1grbm5MbXV4ZzBadlFPN3JMVlZPQXFL?=
 =?utf-8?B?Y1YxY0I1YkNMWUlRVHNHNGRPL3ZHcWc0c1hWV2VZYXU2QmNTYk5lR1ZSbGNW?=
 =?utf-8?B?NGFBck1uSWl0eHZUdTNyK0F4N29WYnI5bmtNRkgvSWZmUnBtVWh6NHFzZVYx?=
 =?utf-8?B?a1RpU3huQng2TGEwUHZEWTFRTThvM0dTS01HOVdhYnJad2prNncySGU4dHZm?=
 =?utf-8?B?ZTZySlYrQ1g0VXYySWxkcERFemt2WTkzWUJTbTZNNXNoYWZoNUtlV3cxQ3gw?=
 =?utf-8?B?UUdBSnFQdTYyTmFRQUFDWXpoMjZGNFhWUVE0bVpVcm50WHpETDBnTjVFUWJV?=
 =?utf-8?B?V1V4Mzd4aXl1R3FPL3hRYnhjWURyeExkRGZrZG0wQkRVMUhKaE1OR3RjemI4?=
 =?utf-8?B?NGVBQjhGZVRUUmp1YWtsL2VKdVNDTU45eUUrVXRSd2RwS3EySnVhMFc2TUFm?=
 =?utf-8?B?M0pVT0tCcEIzcXEyT21FRzlOeC9YRVlUdkVJdkUxbXpYS1h1SEZiTEhNR2Zr?=
 =?utf-8?B?bGhqRTJNaVhZTlRkVEo2YXpUbDFnbTM3TUhQRmRNU0o4VVNOWHAxQVZnVC91?=
 =?utf-8?B?WW9ibVROaTF2UEZXVndEa1BPUUVCVm0reEpENzF1MlFmaUFUN3FGTjlEdlRa?=
 =?utf-8?B?ZXFZNXNmR29ZZFVoZHplM3Izem9UTlpCc2FpUm9iQzNVS3ZUV3BBamNIQnUv?=
 =?utf-8?B?QXNMRjFpU2lPTVU5amZDR0xkaHE4bkMwSjNhdDljQkFtam0wWWZyU1cyZndU?=
 =?utf-8?B?bDZXWXU1NjU4UEl3RzhlVktRTnNiWmU1aFIvKzlmZzlGYXpJUkxXbnZBdk54?=
 =?utf-8?Q?3Du0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56610cf4-1cd2-4422-dc9b-08db2b1e1848
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 21:40:45.9186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2oFwbilFwpLCb5d/0BH/3wWIvGI79nrpJz6ZSF+TJe+Yu4+uxEVlzm6pLYF6Ttuzndri93l1/BQKXXdju5WzXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9277
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IE1hcmNoIDIyLCAyMDIzIDQ6MzggUE0NCj4gVG86IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29t
Pg0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGZlc3RldmFtQGdtYWlsLmNvbTsg
aW14QGxpc3RzLmxpbnV4LmRldjsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBrcnp5c3p0b2Yu
a296bG93c2tpK2R0QGxpbmFyby5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTog
W1BBVENIIHYzIDEvM10gZHQtYmluZGluZ3M6IHVzYjogY2Rucy1pbXg4cW06IGFkZA0KPiBpbXg4
cW0gY2RuczMgZ2x1ZSBiaW5kaW5ncw0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBP
biAyMi8wMy8yMDIzIDIyOjM2LCBGcmFuayBMaSB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGty
enlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBNYXJj
aCAyMiwgMjAyMyA0OjMyIFBNDQo+ID4+IFRvOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT4N
Cj4gPj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IGlteEBsaXN0cy5saW51eC5kZXY7DQo+ID4+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsga3J6
eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBsaW51eC1hcm0tDQo+ID4+IGtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgbGlu
dXgtDQo+ID4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsgcy5o
YXVlckBwZW5ndXRyb25peC5kZTsNCj4gPj4gc2hhd25ndW9Aa2VybmVsLm9yZw0KPiA+PiBTdWJq
ZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2MyAxLzNdIGR0LWJpbmRpbmdzOiB1c2I6IGNkbnMt
aW14OHFtOiBhZGQNCj4gPj4gaW14OHFtIGNkbnMzIGdsdWUgYmluZGluZ3MNCj4gPj4NCj4gPj4g
Q2F1dGlvbjogRVhUIEVtYWlsDQo+ID4+DQo+ID4+IE9uIDIyLzAzLzIwMjMgMTU6MzQsIEZyYW5r
IExpIHdyb3RlOg0KPiA+Pj4NCj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPj4+PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tp
QGxpbmFyby5vcmc+DQo+ID4+Pj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyMiwgMjAyMyAyOjMy
IEFNDQo+ID4+Pj4gVG86IEZyYW5rIExpIDxmcmFuay5saUBueHAuDQo+ID4+Pj4+ICsgICAgICAt
IGNvbnN0OiB1c2IzX2FjbGsNCj4gPj4+Pj4gKyAgICAgIC0gY29uc3Q6IHVzYjNfaXBnX2Nsaw0K
PiA+Pj4+PiArICAgICAgLSBjb25zdDogdXNiM19jb3JlX3BjbGsNCj4gPj4+Pj4gKw0KPiA+Pj4+
PiArICBhc3NpZ25lZC1jbG9ja3M6DQo+ID4+Pj4+ICsgICAgaXRlbXM6DQo+ID4+Pj4+ICsgICAg
ICAtIGRlc2NyaXB0aW9uOiBQaGFuZGxlIGFuZCBjbG9jayBzcGVjaWZvZXIgb2YNCj4gPj4+PiBJ
TVhfU0NfUE1fQ0xLX01TVF9CVVMuDQo+ID4+Pj4NCj4gPj4+PiBEcm9wIHVzZWxlc3MgcGllY2Vz
IHNvICJQaGFuZGxlIGFuZCBjbG9jayBzcGVjaWZvZXIgb2YgIiBhbmQgbmFtZSB0aGUNCj4gPj4+
PiBoYXJkd2FyZSwgbm90IHRoZSBzeW50YXguDQo+ID4+Pj4NCj4gPj4+Pj4gKw0KPiA+Pj4+PiAr
ICBhc3NpZ25lZC1jbG9jay1yYXRlczoNCj4gPj4+Pj4gKyAgICBpdGVtczoNCj4gPj4+Pj4gKyAg
ICAgIC0gZGVzY3JpcHRpb246IFNob3VsZCBiZSBpbiBSYW5nZSAxMDAgLSA2MDAgTWh6Lg0KPiA+
Pj4+DQo+ID4+Pj4gVGhhdCdzIGJldHRlciBidXQgSSBzdGlsbCBkbyBub3QgdW5kZXJzdGFuZCB3
aHkgZG8geW91IG5lZWQgaXQgaW4gdGhlDQo+ID4+Pj4gYmluZGluZ3MuIFlvdSBuZXZlciBhY3R1
YWxseSBhbnN3ZXJlZCB0aGlzIHF1ZXN0aW9uLg0KPiA+Pj4NCj4gPj4+IEkgYW0gbm90IHN1cmUg
MTAwJSBzdXJlIHRoZSByZWFzb24uDQo+ID4+PiBJIHRoaW5rIGRpZmZlcmVuY2Ugc3lzdGVtIHRh
cmdldCdzICBheGkgYnVzIGZyZXF1ZW5jeSBpcyBkaWZmZXJlbmNlLA0KPiA+Pj4gQW5kIGp1c3Qg
b25lIHRpbWUgd29yaywgbmVlZG4ndCBzb2Z0d2FyZSB0byBtYW5hZ2UgaXQuDQo+ID4+PiBGb2xs
b3dpbmcgb3RoZXIgZHJpdmVyJ3MgY29kZSBzdHlsZSBtYXkgYmUgYW5vdGhlciByZWFzb24uDQo+
ID4+DQo+ID4+IFRoYXQncyB0aGUgcmVhc29uIG9mIGhlYXZpbmcgaXQgaW4gRFRTLiBCdXQgSSBh
bSBhc2tpbmcgYWJvdXQgYmluZGluZ3MuDQo+ID4+IFlvdSBkbyB1bmRlcnN0YW5kIHlvdSBkZWZp
bmUgaGVyZSBpbnRlcmZhY2U/DQo+ID4NCj4gPiBJIGRlZmluZWQgaGVyZSBpcyBkZXNjcmlwdCBB
WEkgZnJlcXVlbmN5IGZvciB1c2IgY29udHJvbGxlci4gU3VwcG9zZWQNCj4gZGlmZmVyZW5jZQ0K
PiA+IFBsYXRmb3JtIHdpbGwgaGF2ZSBkaWZmZXJlbmNlIHdvcmtpbmcgZnJlcXVlbmN5Lg0KPiAN
Cj4gSSBkb24ndCB1bmRlcnN0YW5kIGhvdyBkb2VzIHRoaXMgYW5zd2VyIG15IGNvbmNlcm5zIG9m
IGhhdmluZyBpdCBpbiBEVA0KPiBiaW5kaW5ncy4gSWYgeW91IGRvIG5vdCBhZGQgaXQsIHlvdSAi
d2lsbCBoYXZlIGRpZmZlcmVuY2Ugd29ya2luZw0KPiBmcmVxdWVuY3kiLCBzbyB3aGF0J3MgdGhl
IHBvaW50Pw0KDQpGb3IgZXhhbXBsZTogaW14OHF4cCwgaXQgbmVlZCBzZXQgdG8gMjUwTWh6LCAg
aS5NWDhRTSBuZWVkIHNldCB0byAyMDBNaHouDQpNYXliZSBmdXR1cmUgY2hpcCBjYW4gc2V0IHRv
IDQwME1oei4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
