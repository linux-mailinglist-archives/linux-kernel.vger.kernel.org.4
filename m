Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE146D94EE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbjDFLSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbjDFLSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:18:25 -0400
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C578A4B;
        Thu,  6 Apr 2023 04:18:20 -0700 (PDT)
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
        by mx08-0063e101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3369uhLA020839;
        Thu, 6 Apr 2023 11:22:31 +0100
Received: from ind01-max-obe.outbound.protection.outlook.com (mail-maxind01lp2171.outbound.protection.outlook.com [104.47.74.171])
        by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3pp9xuk2dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 11:22:31 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P02k+QOotJGE+GphPTxoRWw7A2bxka0fhp0bSA0T6hu9jG1FGllpvb1zA14ID5PCeYRBkOBKxf83FHMX96nPRy5tFlzagqvJU017WMRPdlxeK/5oBkR5B9mBjV4ZUdPTocyzoYYk9/CeE12OTt2bdNCPFmA+YpM/bs629uhmuYtgbZxB13ZcjoYIqMQrQU5DeQ31RsNdYb/BkO3Y9NxchOVKA4n3GE9rJ/OLlAjCg35SpH+0WWE4GZv6LrCS1ANiR26W5mLsGsIcjDYP1jViirJd01E+QdGygfeVRD/8ZlmxMRrW9aXsxYKeXCQMsGvtIOtgWeNILeFS8YZpORB4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EukNdCgB0K0FwUMY0CCR1k+Kcv7Me22mUhFKXwKeS0Y=;
 b=ltgiYoRcbSLbpO2h8e4z+zgKXUBJGE2x2ggBpv19lWKdcLcvC+sq7uteTFPaHYjlSiqV9YMd7uWUETOqSdClLrVH8uH1lQunPH+yxa3v8pUIhqFHcAX04bCRYApDGp6BxHAbdQsVCrvVBBrNxi0c8QyiK+U97CSepDZofWXIONVJ/iklR3tLXye5QUShs3A7BeYgFTMgU0UecihqA4J3/El8Ols6QuNcGk4FH3UNBUoaaw63Gb5NMCvvhDZkRfEMe1FhvnHf998UC79VsAJ1aM1htTt054VZept0abCo9Skj6HTOzq+nygwoFP/mT4b99A8SJpYEqTMy3o1LzeO3mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EukNdCgB0K0FwUMY0CCR1k+Kcv7Me22mUhFKXwKeS0Y=;
 b=Fu1syYov3AyWKwoz5nE9cbnQQVI5oTt/sI9bt93Vqv+jnVe3h8a0bkXjXyE859RQpMZuEvvy0ZShwbOmvDYq9JJyumUQpMFbp4KPNXtRNaiygVk1eSj3FPSTAH1MHcn3xmJRkoOKLk1QSZ8BbjGRmQbjjoxNeXbAst8rqHmMbUo=
Received: from MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:37::10)
 by PN3PR01MB7647.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 10:22:26 +0000
Received: from MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::527d:d71c:fe10:7e23]) by MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::527d:d71c:fe10:7e23%8]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 10:22:26 +0000
From:   Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "soc@kernel.org" <soc@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>
Subject: [PATCH 1/5] dt-bindings: Add Blaize vendor prefix
Thread-Topic: [PATCH 1/5] dt-bindings: Add Blaize vendor prefix
Thread-Index: AQHZaHGvkh1vWgwIC0CIt8LRPvPU5g==
Date:   Thu, 6 Apr 2023 10:22:26 +0000
Message-ID: <20230406102149.729726-2-nikolaos.pasaloukos@blaize.com>
References: <20230406102149.729726-1-nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20230406102149.729726-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB6906:EE_|PN3PR01MB7647:EE_
x-ms-office365-filtering-correlation-id: 9f6fe143-6eed-4f1b-0184-08db3688d1e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IyswbPkohsCayNf7Hn7Nl+hxnE55gdbQmkPSaTXVLpjtf935rflg/4U0FtVhHr+wp1L9SVhfuWHOraf03W6S6LeJtE6vMppQTqT13Po6sXPBGOT30F1NJ/g8fxI/ravANEMcxGHRleR3QAloNzaxDZIkT3DviPcRVPJHbgl6C+mCNr7RcEsIYdC9qqnDmrftJM4DBGOimPNSpYqrAY87Kqak0xK6NkzmlTYlQ/bWNGlkPTEYV4ncCgjq0PbE2cSno5NyRUQnSbhv6HeBenhdPW4n3e/1fkNiSITXhIXw7kKEijpV9LnZc8ehW31EjF3PuLonCm5weyw137qKKs17hMcCpugmEPd4y8H1EBlz5OwHUJTrcAgV4JKkXC6zG1E0w+7L6V4Mftn2ATayeg6CCN961QUPJPkg66w25X05/qRNTUnzxkCpRT4b9/edVgC3XZ7JQQygtiCB2lm1jUq3Vw2JFp6iLK03S/jcS8ixV5u9m6/0+kG4mQtx6B+rChxT0G3GAU3QJH/TVvndc6TgtWKW5h+Rvgmw1mA8KMZSwN6fCxR2UpU3MZrWS8sDttXKnHLZzQ8xARejiNGo40YQgr7qdSUXvyAJpB8yJ9JQXMA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39840400004)(366004)(451199021)(6486002)(4326008)(91956017)(110136005)(54906003)(66446008)(64756008)(76116006)(66946007)(66556008)(316002)(8676002)(36756003)(66476007)(122000001)(6506007)(6512007)(107886003)(2616005)(186003)(26005)(1076003)(38100700002)(5660300002)(41300700001)(71200400001)(478600001)(8936002)(38070700005)(86362001)(4744005)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nNSUFn0ws2hPZmHq/pGcdB0GbixxhGb8t7pv424gKVj3kIZ/vvM8e0tjsN?=
 =?iso-8859-1?Q?9qRM7o58+5hp2A/tL0hry9SJYsLZhlbZQUEkkhveS307LMkjTqckI28GWk?=
 =?iso-8859-1?Q?/Cj/LYJycbkyRst7oVQuzYfhQ+Jmxf8acW4qxFBeBh4aU0FkNZbActRjRx?=
 =?iso-8859-1?Q?piYO0kw/dRIcJt2OBPtYBCA0CJRIr/y9tEeL2nE2xCHPtxFcl3ctLBlzeK?=
 =?iso-8859-1?Q?C56d5cqR0cuLy98E9OzzSAyZjpWxLAiSC6rF215uui6kLYIvs+amoruuxw?=
 =?iso-8859-1?Q?kOyUzsiOb8measiIjg12wRNVPnd9y+CMsqJatAjf0K1G99NuUV2ioI/cR9?=
 =?iso-8859-1?Q?52t80wfzL0vewi5EmLh7tx3cTxGzMCPDyWUyDht6Ovsb/xeC77GQlz5KMg?=
 =?iso-8859-1?Q?WrcKjHDGGWv/0fTWrHPh0YvIq+VIGxuMIYz6duvn+M7bFRs95oteLFNo9U?=
 =?iso-8859-1?Q?m/iH4+SPABS8Nh8YnC4zZgURHJebEoPd8ZrYq7huZr8tjRsacGHZ+MkfI5?=
 =?iso-8859-1?Q?itHf1z6tAjURSfHKoH5xEdFBrvVt3ze+c+ofF4VPNg7pBPW9lrt64zzNxk?=
 =?iso-8859-1?Q?7t32NzDhOtbacPZ9QgP1J97mV3TrPWZutkvvOjxDiYmeBXpg/efh5t5jrS?=
 =?iso-8859-1?Q?yAt+tR+BCpPvv4T1pyAySEVFuLyQ+xsOW90TlaVJuK8EGZs0LLn3gI0qJw?=
 =?iso-8859-1?Q?1bAbczVe9lIATbkjvmUQBDwHDzCMEsogAeh5Mtipd7Omk0XJrAN0aPpmls?=
 =?iso-8859-1?Q?Tp5b146O0zX/8hjxVO4OGFDUK0wJkJ8TGCjfJkiGbyzNiomqNF6tKg5/hS?=
 =?iso-8859-1?Q?q7Exv4aepFpx/ZLdtHV/r6T/gMtRyb4GL16KgqtwxiE7wHXA1GNH4Ty/Ui?=
 =?iso-8859-1?Q?XJE019L1Mt/dPM+E472ctyTfWGceFVfuys+k6NiB2oTgWyGL61tx+5NJKf?=
 =?iso-8859-1?Q?LI7jtZUukrrSJDA7HzHCCIOiT3oXbfizYAOxqnIcD225aM1s8/cALa2oyz?=
 =?iso-8859-1?Q?pnccWK6abxfpe5PuuiTVJZPbbemTT6rz9tKTA1swHOjhDqUq3dfWUMqmC8?=
 =?iso-8859-1?Q?mzTFfuhgxjrRIWDOL/LI0zqmC3H8rHK/3cP68v1Bs0aL3az3sQ1xGRzGGB?=
 =?iso-8859-1?Q?HPKukNDSgNMxKb26VaSGFbgcXk/IO0Q0iZc54MN0viivhzG68RdCIgO8wC?=
 =?iso-8859-1?Q?1fkJ/SOOTZ5bWXpgN/f/nJQvlmm8vrko5zH8oP6RhSPNJU01sMo9r0+kLc?=
 =?iso-8859-1?Q?olkND6Oninkv6MtUpxRbS1Ew7kaLVfo8X0melBYrQuxuj5wli1fr/vveMC?=
 =?iso-8859-1?Q?ytgT4CGZMZgSXjLz7DgFZOnCYjOLvWae0ilX66TBwX284ijdaQs1GHAt3K?=
 =?iso-8859-1?Q?VtkXsuaEX/SNepYZ8gf/OkTLeo3S6nFBclwtShP4nFDxuA/jiUtxbTEH2C?=
 =?iso-8859-1?Q?gUXnT9zXDdRliDeqNaldQtDLBpGycVecNbxrXH7nVWqLRDduEk4ivLsgoT?=
 =?iso-8859-1?Q?FjYRXZVFDTGIJC1UuprR0O5gtTMsuL2sv7eEnvbteGPklTREJ+8vA6gc5t?=
 =?iso-8859-1?Q?H+ypyQFAaQ2M4dYeubMx6sLHO6a3Yrjczc0BN3DxISZU+iVpRtDu9N+lI8?=
 =?iso-8859-1?Q?Y+GLtgWZ9c4YrVnOmb62fVAeTVuV323Gs/eevyoYUeOZuy4raVlUGlgg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6fe143-6eed-4f1b-0184-08db3688d1e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 10:22:26.7417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D06ewWnj8SGXcavuQJZEf447OtCjsHTxnLHAhGnxs0UaUnIFuki9gvVqwc7A8SuiEXQVxDnNn/d1W9fZLlXbvySsighVaLUDY7gUNIaywrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7647
X-Proofpoint-GUID: cr5GyNI8NljRNiOn8s-SR7OoPgQD7GS7
X-Proofpoint-ORIG-GUID: cr5GyNI8NljRNiOn8s-SR7OoPgQD7GS7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_04,2023-04-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=698
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060090
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blaize, Inc. (www.blaize.com) is a SoC manufacturer with integrated
programmable Graph-Streaming-Processors for AI and ML.

Co-developed-by: James Cowgill <james.cowgill@blaize.com>
Signed-off-by: James Cowgill <james.cowgill@blaize.com>
Co-developed-by: Matt Redfearn <matt.redfearn@blaize.com>
Signed-off-by: Matt Redfearn <matt.redfearn@blaize.com>
Co-developed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index 70ffb3780621..21a91f3b9e27 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -190,6 +190,8 @@ patternProperties:
     description: Beckhoff Automation GmbH & Co. KG
   "^bitmain,.*":
     description: Bitmain Technologies
+  "^blaize,.*":
+    description: Blaize, Inc.
   "^blutek,.*":
     description: BluTek Power
   "^boe,.*":
--=20
2.25.1

