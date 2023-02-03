Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F124688CA7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 02:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjBCBlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 20:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjBCBk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:40:59 -0500
Received: from mo-csw.securemx.jp (mo-csw1115.securemx.jp [210.130.202.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB448716A;
        Thu,  2 Feb 2023 17:40:57 -0800 (PST)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 3131eOML027185; Fri, 3 Feb 2023 10:40:24 +0900
X-Iguazu-Qid: 2wGqiQJF1TiK3q4cqL
X-Iguazu-QSIG: v=2; s=0; t=1675388423; q=2wGqiQJF1TiK3q4cqL; m=VEUlXDcQFkQIRkwtKm+pMRjhrQZ655Nv4aIScfpLGfA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1111) id 3131eLm8009429
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 3 Feb 2023 10:40:22 +0900
X-SA-MID: 54298013
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKTYOeHlDc7Ybs1jRQcIO2V3gTBdr4JSrcQCpFDxPT1Q8itpXkn0Z1253uS0nwZ1GdDKomm1jhYZlvia7PW2cdVH5prWWrAEB0O6ccrCgs3JGL/BNnRcixo0M4ya3YEjaHWvJyelMkRfQN0vmALKfzQc7cm269xBoWqWsu5TkL+7w9Azptr3GnYHQ/ASiRiYI29HBCRt+sOmj+aJa//JQKGW6VSscl131qFgrDdVYuBRtcuLkuNQ+UO6KxWESvJ6o689ExvgKJHtrc+Acfvuhd4MAyJJcCo1zdP4FuhTHUS1QkyPAOHV6qxXv+Hs+gqdS2TrSpGAJ5NMbTntJhmV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzK63qMZUUHJdyn9z/MIUUuAsECQnj180oZq3ua9X7U=;
 b=OC+7Nn5WP3hG9wLO7Fi5yFUcbrBQdG3s66maLA7TDX+Ob31+r1W7VrvVObR7P0Fr+HviooCpozUd2gYxHWMR6Tswug5DbKKKS9IDL4gg0x2jML9KXcvz8caZsZHGMBSewauugSsedS0PR6QHFzHfI9d6DAp2V3QayRwvYyhdx66e1m9Wa8+KtAaoJ8zgSIUqeZu/9BUWVRh3nMLg5tEzCWRz2lX45ZXPqTDkIj6G0wV/0nqggT7nAHlva7NYyXnwtoujV8qNiTP/uAejRh3Xe/UnuMDFc7VW3vwJODFIwUNrGf4dYbYGUuBSfT9wqZDkL73pwGyVLKFi7l2N6Z6JBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <laurent.pinchart@ideasonboard.com>, <hverkuil@xs4all.nl>
CC:     <mchehab@kernel.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <rafael.j.wysocki@intel.com>, <broonie@kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 4/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver v4l2 controls handler
Thread-Topic: [PATCH v5 4/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver v4l2 controls handler
Thread-Index: AQHZJWPyWvms7kPPhkqGZVdtRfuKl66igHOAgA1w6tCAAIdngIAAMSqAgAvpijA=
Date:   Fri, 3 Feb 2023 01:35:12 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB6201A600BFB7FE02EAE819DD92D79@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-5-yuji2.ishikawa@toshiba.co.jp>
 <741cc02e-9d72-db59-171a-14bbd7925c7c@xs4all.nl>
 <TYAPR01MB6201386D11891171A984744792CF9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <7d1a375a-c3d1-0f8e-4d69-10dedacf6974@xs4all.nl>
 <Y9JlnRKXofXl0s87@pendragon.ideasonboard.com>
In-Reply-To: <Y9JlnRKXofXl0s87@pendragon.ideasonboard.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|OS7PR01MB11614:EE_
x-ms-office365-filtering-correlation-id: 93bc3a74-54ff-4ccc-1b8e-08db0586e4e6
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BBnTr0K55Y19R7bFaYieCm/wr9UyjR6VAQ5p/HQ/sFyAeVJQL88Vkz1e+oHTvRJnWfo0LeaNIY/A8rDx+B9hNPtyhLqUZJ9pdIURzCYY9+ggaBy1Kz4a/KS53jQRfv9f8puvs545n3j7LVs8ICUjQBxXR+1NXRCKezlCVZ2e2P0pQFdf2uTUFEoCuCEOpz+2qaFmJx5ywvQKbXHZcKGmN+9gU2VwuHWVt+OtjnHEL8vjHcjXS1KbIfndY9cUt+QN78amN5Rbf75xsjryWNTDB87w72KB57dfbSf00Og5v7o9ZDo3OPCk+6QBznwnfUBTE9jKFe83jNLsV8QolDnXOWUCPcQmRn6m22/BY8kuaknzUcHg70vlNL3+Ga5pPsoBt0xEUpTVQif17aRDAx3KF6x+UtAowV0JVu0Q8BadN5XXzPy/cm3Jdfzu5SlEr98MC5EFPg/ABmyijv48fz6ejD4xkosFmld7SIl36tgN3Y+2zOS928HFoDpJX0Gl1hVtY1JbNd78H94/cCQQS2wkXFKIuSZajknHTpZoIN2NXkLD7ng65cn7+1sYhFMJun8zr6Z/z8AMNhAb2LpWgDginZnVknI2lz4SNd1tZBb1yEKvMlXtC2c/FpRXc3uA/kP7YY4p8pxNKjN870fE5RwYW+su/DG6xqLvGL4Uv+Gw7SC38cEcr61b1xwAVzwTmjKo4+71lLmIakhIpQibAJ4dZcpiU9UdIZf9P4o5jkBRsAQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199018)(5660300002)(7416002)(966005)(41300700001)(2906002)(8936002)(316002)(4326008)(54906003)(76116006)(66556008)(110136005)(66946007)(66476007)(8676002)(66446008)(64756008)(71200400001)(7696005)(478600001)(6506007)(9686003)(33656002)(186003)(26005)(53546011)(55236004)(52536014)(55016003)(38070700005)(86362001)(122000001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGtoRmVHL09pekpxMXV4ZnFtM3FrOUJZOVFpSGJySnJ1L2FldUh0Z1RzakhJ?=
 =?utf-8?B?S2lWSzhLbDg5bS83NExTTXEydUV0ajFNTmVtTEVOSVkvdUthYTh3VjVwRVJL?=
 =?utf-8?B?WFJjSnJYMEZ2dzRBRGEvUyttUXg1YWdydzlhRGV3eUs2L2pRbHN0SXpONTBL?=
 =?utf-8?B?SHM3SGFkelRwN0xmVWFLYkE1WjRGS1ZDaDQxdkt2U21yRThpVEhWbHpJM2RJ?=
 =?utf-8?B?T01GQU91SFpBSnVQaXorNElxQXRwT05FYzQzbWZzdFM3ZU9DWllMQjUvWnhR?=
 =?utf-8?B?SjdkWGNlZmtMOFIzR0VVUkFNdnJwWk9ob1AzV1A0cmlJcnhkVGpMempucU1C?=
 =?utf-8?B?WDM2VDhFaURrMm9ZTkNLL0psR0piME0zREhhQ0ttU0ZRTWVvcW9sb0VSb2Uz?=
 =?utf-8?B?MlNvdmlzdytIem81MDdVSWdCQTlxT1gxMG5ZeWdFMFRLY2xwOS9qU2xWQmJh?=
 =?utf-8?B?b0JIRUF5Y1NTM1FkR0ZjWGV5MEx5N0VNNURmOGhjZ3hNVHYxdGxkTXh2eGNE?=
 =?utf-8?B?dkVTUWRmdDIwNFg0WkJMdFgxbEpkZWhSUmZrcjZyL2V2VHBXSW9PUTBGU0dP?=
 =?utf-8?B?VXUzOExjUkI4VTJTbUx6OU51Q3hCYnBWVlZkeTcwMFBWTi8zSEVZRjMzeEdC?=
 =?utf-8?B?SW0zc3UyaU5nVit4VWNRUVNDTkhzSWNyZnhzT3NXZ3l6czd0clh5dUVCd1BU?=
 =?utf-8?B?cFdnOUE0WURPSlhkM0JwWCt3eWMwbXZFcEhFMnFBTlpOZTIyREtSZW03Q1lu?=
 =?utf-8?B?bzNyck5xOHJzL2VZR29YdUtBZE9zdHA2NlZVaGt3cXdyVG5IeFRPREVvcWgw?=
 =?utf-8?B?bUhhT1I0djhVY0MrQ245blFNRWZPVy8zSGwwaSs4UWFyZFJwL3dDZ2svY1l3?=
 =?utf-8?B?c1lRRmwxUTVacXoyNi9TOG1mRGxnUGVValVYalZqcE1zOGVZRU9nb1B6dHBs?=
 =?utf-8?B?WlVhdjNueEVSMTZHblUrVmpFbTByc0w4WTBsNzZYcGgyRzJSSHFvejA5czV3?=
 =?utf-8?B?TkhhS3BUZWFPV09JbWJIQnNTdjIrb1NyM3dxTTQ2ZSszSmtmWURTVVpFS3NY?=
 =?utf-8?B?R0VodDZENUo4SlN3d3pRaVlsR3BiQUc4bXBEdWNwUUZZdUxTRyt5UmJzZ0Fa?=
 =?utf-8?B?ZHhmYXRlaUcvVzh0aDZXTkhHVHkyK0hVZi9wUk95ak1ibGNaZjJneEtFY2pL?=
 =?utf-8?B?Z0d3d1pTYzFwS0NpZy9UOTNzQzE4UzNIKytVVjE0dWl4M1JycG10ajJhYU1U?=
 =?utf-8?B?TFBTdGIwa045WXV0S2E0VGpHMEV0aWZQVFBHM2FrU2g0cHlVeEFTcXZFSGNX?=
 =?utf-8?B?R3pDaGlUMlo3dHd4SlVKTHNlTnY1TG83ZzJWQzZzS1VyUk5wNVRGenFvVnp0?=
 =?utf-8?B?L0pqa1dDN1pDNCtJd3p3dzY1OGt2S3k3Y2NKZVRNU2FNV3dvMS9YdjB0MlBB?=
 =?utf-8?B?aHR4cFNKcktLSk95czV0a0tmOWVIWi9lRFZ6a0NkazZpcmVBSWpGTnpZeW04?=
 =?utf-8?B?RnlLMHJnQUpqT1haTis5NE1QRzl2ZUdhRUVYczZ4aUlHWFlra1hET2xtcENY?=
 =?utf-8?B?bE5nTU1vbE5HemV1aUtXZ09oWTV5ZFRvVHhGanpRcUpjVmxaY056RkZheHFY?=
 =?utf-8?B?amdVdzFSaVVpL1haYW5DTE5kVmdjVWJFM09teFZ2WXpUR1JmaE5RYUJ5MzBl?=
 =?utf-8?B?bHg3V1ZkMklDQmRPWlZLc1Njd1dQdXVCblJ4Y0lJL3VzYWxiTTRQcFVmV3hT?=
 =?utf-8?B?WG1ERS8ybTFCenhBVmVwL085NHlSMXV4WXVUY3c5UmpPZlYybnBVTTR5R2oz?=
 =?utf-8?B?RWRpV1pZV3pqUG9HYmJXeXRLdTdZQW4zT0MvNjRuM3hRbExXdXQ5UXZ2WC9m?=
 =?utf-8?B?T2Z6c29nZTZnRHptbnNON0VjWlc0NjMxVFBOT1ltYWpUZ2FZQW4vbVl6TkRj?=
 =?utf-8?B?emxlQUZPYWZaWGRnb2FqVXlUaXpyckQxTVZiVHZJUzlXcEpHUHVyMGpBWjAr?=
 =?utf-8?B?TVgxbXd4YnFETFZiZk8yR0UxUkYyQ3l4cStJTmFWRFU1dHdrbkJoL3BFMldM?=
 =?utf-8?B?M20yRU1kS2x5MG9vcUZqSWtGRWk0QmlQNk9WdHpRSmVLTnNyUUw2OFdXVWxx?=
 =?utf-8?B?Ri8zR3BLeE5Ka1MxZE04U0RMZm1hRmUxZzFnOE53MDNQdTIybFpQMFpxKzFy?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bc3a74-54ff-4ccc-1b8e-08db0586e4e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 01:35:12.6630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVb+3gQd+uEr2efWTHBU5hWqS01PZOmR2hPEZ/D0UuHdz7+0ahbv7ogc99wv9zNGGBoXPX4SmLo+4Pljmfj7haza9QsinZNyObeVm+JTYv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11614
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhdXJlbnQgUGluY2hhcnQg
PGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEph
bnVhcnkgMjYsIDIwMjMgODozNiBQTQ0KPiBUbzogSGFucyBWZXJrdWlsIDxodmVya3VpbEB4czRh
bGwubmw+DQo+IENjOiBpc2hpa2F3YSB5dWppKOefs+W3nSDmgqDlj7gg4peL77yy77yk77yj4pah
77yh77yp77y077yj4peL77yl77yh6ZaLKQ0KPiA8eXVqaTIuaXNoaWthd2FAdG9zaGliYS5jby5q
cD47IG1jaGVoYWJAa2VybmVsLm9yZzsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+DQo+IOS/oea0
iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5j
by5qcD47DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5h
cm8ub3JnOw0KPiByYWZhZWwuai53eXNvY2tpQGludGVsLmNvbTsgYnJvb25pZUBrZXJuZWwub3Jn
OyBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA0LzZdIG1lZGlhOiBw
bGF0Zm9ybTogdmlzY29udGk6IEFkZCBUb3NoaWJhIFZpc2NvbnRpDQo+IFZpZGVvIElucHV0IElu
dGVyZmFjZSBkcml2ZXIgdjRsMiBjb250cm9scyBoYW5kbGVyDQo+IA0KPiBPbiBUaHUsIEphbiAy
NiwgMjAyMyBhdCAwOTozOTo1OUFNICswMTAwLCBIYW5zIFZlcmt1aWwgd3JvdGU6DQo+ID4gT24g
MjYvMDEvMjAyMyAwMTozOCwgeXVqaTIuaXNoaWthd2FAdG9zaGliYS5jby5qcCB3cm90ZToNCj4g
PiA+Pj4gKyNkZWZpbmUgVklTQ09OVElfVklJRl9EUENfVEFCTEVfU0laRSA4MTkyIHN0YXRpYyBp
bnQNCj4gPiA+Pj4gK3ZpaWZfbDFfc2V0X2RwYyhzdHJ1Y3QgdmlpZl9kZXZpY2UgKnZpaWZfZGV2
LCBzdHJ1Y3QNCj4gPiA+Pj4gK3ZpaWZfbDFfZHBjX2NvbmZpZw0KPiA+ID4+ICpsMV9kcGMpDQo+
ID4gPj4+ICt7DQo+ID4gPj4+ICsJdWludHB0cl90IHRhYmxlX2hfcGFkZHIgPSAwOw0KPiA+ID4+
PiArCXVpbnRwdHJfdCB0YWJsZV9tX3BhZGRyID0gMDsNCj4gPiA+Pj4gKwl1aW50cHRyX3QgdGFi
bGVfbF9wYWRkciA9IDA7DQo+ID4gPj4+ICsJdW5zaWduZWQgbG9uZyBpcnFmbGFnczsNCj4gPiA+
Pj4gKwlpbnQgcmV0Ow0KPiA+ID4+PiArDQo+ID4gPj4+ICsJaWYgKGwxX2RwYy0+dGFibGVfaF9h
ZGRyKSB7DQo+ID4gPj4+ICsJCWlmDQo+IChjb3B5X2Zyb21fdXNlcih2aWlmX2Rldi0+dGFibGVf
dmFkZHItPmRwY190YWJsZV9oLA0KPiA+ID4+PiArDQo+IHU2NF90b191c2VyX3B0cihsMV9kcGMt
PnRhYmxlX2hfYWRkciksDQo+ID4gPj4+ICsNCj4gVklTQ09OVElfVklJRl9EUENfVEFCTEVfU0la
RSkpDQo+ID4gPj4+ICsJCQlyZXR1cm4gLUVGQVVMVDsNCj4gPiA+Pg0KPiA+ID4+IE5BQ0shDQo+
ID4gPj4NCj4gPiA+PiBJIHRob3VnaHQgdGhvc2UgYWRkcmVzc2VzIGluIGEgc3RydWN0IHdlcmUg
aWZmeS4gVGhpcyBpcyBub3QNCj4gPiA+PiBzdXBwb3J0ZWQsIGl0IGJhc2ljYWxseSBieXBhc3Nl
cyB0aGUgd2hvbGUgY29udHJvbCBmcmFtZXdvcmsuDQo+ID4gPg0KPiA+ID4gSSB1bmRlcnN0YW5k
Lg0KPiA+ID4NCj4gPiA+PiBUaGUgd2F5IHRvIGRvIHRoaXMgaXMgdG8gY3JlYXRlIHNlcGFyYXRl
IGFycmF5IGNvbnRyb2xzIGZvciB0aGVzZSB0YWJsZXMuDQo+ID4gPj4gQW5kIHRhYmxlX2hfYWRk
ciBiZWNvbWVzIGEgc2ltcGxlIDAgb3IgMSB2YWx1ZSwgaW5kaWNhdGluZyB3aGV0aGVyDQo+ID4g
Pj4gdG8gdXNlIHRoZSB0YWJsZSBzZXQgYnkgdGhhdCBjb250cm9sLiBGb3Igc21hbGwgYXJyYXlz
IGl0IGlzIGFsc28NCj4gPiA+PiBhbiBvcHRpb24gdG8gZW1iZWQgdGhlbSBpbiB0aGUgY29udHJv
bCBzdHJ1Y3R1cmUuDQo+ID4gPg0KPiA+ID4gQXMgSSB3cm90ZSBpbiByZXBseSBmb3IgcGF0Y2gg
Mi82LCBJIHRob3VnaHQgZW1iZWRkaW5nIGlzIHRoZSBvbmx5IHNvbHV0aW9uLg0KPiA+ID4gVGhh
bmsgeW91IGZvciBnaXZpbmcgYW5vdGhlciBwbGFuOiBhZGRpbmcgY29udHJvbHMgZm9yIHRhYmxl
cy4NCj4gPiA+IFdoZW4gSSB1c2UgaW5kaXZpZHVhbCBjb250cm9scyBmb3IgdGFibGVzLCBhcmUg
dGhlcmUgc29tZSBvcmRlcmluZ3MgYmV0d2Vlbg0KPiBjb250cm9scz8NCj4gPiA+ICAtLSBzdWNo
IHRoYXQgY29udHJvbCBEUENfVEFCTEVfe0gsTSxMfSBzaG91bGQgYmUgY29uZmlndXJlZCBiZWZv
cmUNCj4gPiA+IFNFVF9EUEMNCj4gPg0KPiA+IFRoZXJlIGlzIG5vIG9yZGVyaW5nIGRlcGVuZGVu
Y3kuIEJ1dCB5b3UgY2FuIGNsdXN0ZXIgY29udHJvbHM6DQo+ID4NCj4gPiBodHRwczovL2xpbnV4
dHYub3JnL2Rvd25sb2Fkcy92NGwtZHZiLWFwaXMtbmV3L2RyaXZlci1hcGkvdjRsMi1jb250cm9s
DQo+ID4gcy5odG1sI2NvbnRyb2wtY2x1c3RlcnMNCj4gPg0KPiA+IFRoZSBpZGVhIGlzIHRoYXQg
dXNlcnNwYWNlIHNldHMgYWxsIHRoZSByZWxhdGVkIGNvbnRyb2xzIHdpdGggb25lDQo+ID4gVklE
SU9DX1NfRVhUX0NUUkxTIGlvY3RsLCBhbmQgdGhlbiBmb3IgdGhlIGNsdXN0ZXJlZCBjb250cm9s
cyB0aGUNCj4gPiBzX2N0cmwgY2FsbGJhY2sgaXMgY2FsbGVkIG9ubHkgb25jZS4NCj4gPg0KPiA+
IFlvdSBjYW4gYWxzbyBjaGVjayBpbiB0cnlfY3RybCBpZiB0aGUgY29udHJvbHMgaW4gYSBjbHVz
dGVyIGFyZSBzYW5lLiBFLmcuDQo+ID4gaWYgY29udHJvbCBBIGhhcyB2YWx1ZSAxLCBhbmQgdGhh
dCByZXF1aXJlcyB0aGF0IGNvbnRyb2wgQiBoYXMgYSB2YWx1ZQ0KPiA+ID49IDUsIHRoZW4gdHJ5
X2N0cmwgY2FuIHZlcmlmeSB0aGF0LiBOb3JtYWxseSBjb250cm9scyBhcmUgaW5kZXBlbmRlbnQN
Cj4gPiBmcm9tIG9uZSBhbm90aGVyLCBidXQgY2x1c3RlcmluZyB3aWxsIGxpbmsgdGhlbSB0b2dl
dGhlci4NCj4gPg0KPiA+IEl0J3MgcmVhbGx5IHdoYXQgeW91IHdhbnQgaGVyZS4gQSBnb29kIGV4
YW1wbGUgaXMgaGVyZToNCj4gPiBkcml2ZXJzL21lZGlhL2NvbW1vbi9jeDIzNDF4LmMgSXQncyB1
c2VkIGJ5IHNldmVyYWwgUENJIGRyaXZlcnMgdGhhdA0KPiA+IHVzZSB0aGlzIE1QRUcgY29kZWMg
Y2hpcHNldCwgYW5kIGl0IHVzZXMgY2x1c3RlcnMgYW5kIGFsc28gaW1wbGVtZW50cw0KPiB0cnlf
Y3RybC4NCj4gDQo+IEkgdGhpbmsgY29udHJvbHMgYXJlIHRoZSB3cm9uZyB0b29sIGZvciB0aGlz
IGpvYiB0aG91Z2guIFRoZSBJU1AgcmVxdWlyZXMgYSBsYXJnZQ0KPiBudW1iZXIgb2YgcGFyYW1l
dGVycywgd2hpY2ggd291bGQgSSB0aGluayBiZSBiZXR0ZXIgc3VpdGVkIHBhc3NlZCBhcyBhDQo+
IHBhcmFtZXRlcnMgYnVmZmVyIGxpa2UgdGhlIGlwdTMgYW5kIHJraXNwMSBkcml2ZXIgZG8gZm9y
IG1vc3Qgb2YgdGhlIGRhdGEuIFNvbWUNCj4gcGFyYW1ldGVycyBtYXkgc3RpbGwgbWFrZSBzZW5z
ZSBhcyBjb250cm9scyAocG9zc2libHkgbW9zdGx5IGZvciB0aGUgQ1NJMlJYDQo+IHBhcmFtZXRl
cnMpLCBidXQgSSBoYXZlbid0IGNoZWNrZWQgdGhhdCBpbiBkZXRhaWxzLg0KPiANCg0KSSdtIHRo
aW5raW5nIGFib3V0IHBhc3Npbmcgc29tZSBwYXJhbWV0ZXJzIChlc3BlY2lhbGx5IGxhcmdlIHRh
Ymxlcykgd2l0aCBzdHJlYW1pbmcgaW50ZXJmYWNlIChsaWtlIHJraXNwMS1wYXJhbSkuDQpIb3dl
dmVyIHRoaXMgY2hhbmdlIHNob3VsZCBiZSBkb25lIGNhcmVmdWxseSBiZWNhdXNlIDEpIEhXIGxp
bWl0YXRpb24gY2FuIGJlIGludm9sdmVkIGFuZCAyKSBkZXNpZ24gb2YgdXNlcmxhbmQgY2FuIGNo
YW5nZSBncmVhdGx5Lg0KU29tZSBvZiBteSBjb25jZXJucyBhcmU6DQoqIFNvbWUgcGFyYW1ldGVy
cyAoZS5nLiBMMUlTUF9JTlBVVF9NT0RFKSBzaG91bGQgYmUgc2V0IGJlZm9yZSBzdHJlYW1pbmcg
c3RhcnQuDQogIEFyZSBQYXJhbWV0ZXJzIHZpYSBzdHJlYW1pbmcgaW50ZXJmYWNlIGF2YWlsYWJs
ZSBiZWZvcmUgc3RyZWFtaW5nIHN0YXJ0Pw0KICBJIHN1cHBvc2UgdmIyX29wczo6YnVmX3F1ZXVl
KCkgd291bGQgYmUgY2FsbGVkIGZvciBpb2N0bChRQlVGKSwNCiAgYnV0IEknbSBub3QgZm9yIHN1
cmUgSSBjYW4gdXNlIHRoZSBjb250ZW50IHN0b3JlZCBpbiB2YjJfYnVmZmVyLg0KKiBEb2VzIHN0
cmVhbWluZyBpbnRlcmZhY2UgYWNjZXB0IG11bHRpcGxlIHBhdHRlcm5zIG9mIGRhdGEgbGF5b3V0
Pw0KICBJIHN1cHBvc2UgaXQgYWNjZXB0cyBvbmx5IG9uZSBkYXRhIGxheW91dCB3aGljaCBpbmNs
dWRlcyBhbGwgdGhlIHBvc3NpYmxlIHBhcmFtZXRlcnMgYW5kIGNvcnJlc3BvbmRpbmcgZW5hYmxl
L2Rpc2FibGUgZmxhZ3MuIFBlcmhhcHMsIGlkZWEgbGlrZSB1bmlvbiBjYW4gYmUgYXBwbGllZCB0
byBleGNsdXNpdmUgcGFyYW1ldGVycz8NCiogQ2FuIEkgY2FsbCBRQlVGIG9mIHBhcmFtZXRlciBi
dWZmZXIgbXVsdGlwbGUgdGltZXMgZm9yIGEgZnJhbWU/DQogIEkgc3VwcG9zZSBpdCBkZXBlbmRz
IG9uIGRyaXZlcidzIGltcGxlbWVudGF0aW9uIGJ1dCBtb3N0IG9mIHRoZSBkcml2ZXJzIGFzc3Vt
ZSBvbmUgUUJVRiBmb3IgYSBmcmFtZS4NCg0KSSBuZWVkIG1vcmUga25vd2xlZGdlIGhvdyB1c2Vy
bGFuZCB1c2UgZHJpdmVycy4gQXJjaGl0ZWN0dXJlIHNwZWNpZmljIGNvZGVzIGluIGxpYmNhbWVy
YSBtaWdodCBoZWxwIG1lPw0KDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IA0KPiBMYXVyZW50IFBpbmNo
YXJ0DQoNClJlZ2FyZHMsDQoNCll1amkgSXNoaWthd2ENCg==

