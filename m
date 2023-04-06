Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8576D94E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbjDFLSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbjDFLSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:18:11 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Apr 2023 04:18:09 PDT
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39824EC;
        Thu,  6 Apr 2023 04:18:09 -0700 (PDT)
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
        by mx08-0063e101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336A0G4N030839;
        Thu, 6 Apr 2023 11:22:25 +0100
Received: from ind01-max-obe.outbound.protection.outlook.com (mail-maxind01lp2171.outbound.protection.outlook.com [104.47.74.171])
        by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3pp9v0k1xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 11:22:25 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O550XE+a7YawjZJMLo/BzJpUQ96WWhH9BakoWeY6t2cpzvYL4jOvN2eJqfeksJ5BQJqT2LTyL6dEEAS7z70MlfjQtz1lyL9wfAyv7HyexevINZaMRq7IsvYayf0fXytZIuFOq4KXL4pRiDfBeBDURhZBhyjWtkio3ZkE84rzDOHlHcIqH3/zcFYmqTu7CF6Pk8jvVNkqVEQwbcRMsFwwkWrBtHtvVxGeds8eWHkSsdKQMWsW20P55zS0u8jq8rswYEMQzEcxbf4zgf8BngXHIyP4Gdo4vvFUqg+uNmR0hTFpVi/ZbnTi3AMdEMJVJgZ+N5/sPxWLFJYuuKIOFexC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPcoOC+n2CUwQAFphWgINmOek+38iaG0yEJzoTVLLmU=;
 b=WV36bbZrOgllfR/E/1+LcfytIxJtGrfKAGVBFHPbiYdDNG9Ag/54/dlz3gbOuaVnO0ZKHBwwsJpmS2BV7nrDQkjp/PhRvLbXxK70uVeObnjgPW9WrF4PqX5AONTRNdqsjQNOO9Y99INXInAn8VUFGAXsUAwcJCZe/8miGw+VAN0ImH5aHxCKllDcgk6YFA59wmkOTmFiMhqk+ABMx/Pk/F0TayjFnH3G5wbRMPOYPRRgYYvOfVAAoih/jJIhazSXpmAgPwGNxZa8/HQV4MPA8dsv1vY/3vqYoHKe2U42HcwhQYhMVBh4rVXTtAvtmtjiv6J1VfhkWKgrLeCAVMgvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPcoOC+n2CUwQAFphWgINmOek+38iaG0yEJzoTVLLmU=;
 b=TwU7qBRdb7UeZr0Q6tiUCI7jCLBbDHWqGw/EGyXagocgxnVc9glQKUEjNcj8xXNPIvh7o3h3htNo4GQu6hIAFJl8UO/Xosp0w3UhUv9BX6iU5LNvqDKRnpkGg/yoyewQa3p5W8SSsJXunMEHU/cPA0/8pLTFNHqdKRrJHbxHiIs=
Received: from MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:37::10)
 by PN3PR01MB7647.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 10:22:20 +0000
Received: from MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::527d:d71c:fe10:7e23]) by MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::527d:d71c:fe10:7e23%8]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 10:22:20 +0000
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
        Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
Subject: [PATCH 0/5] Add support for Blaize BLZP1600 SoC
Thread-Topic: [PATCH 0/5] Add support for Blaize BLZP1600 SoC
Thread-Index: AQHZaHGrXEnng/cLckC9Sl+p+VJ2OA==
Date:   Thu, 6 Apr 2023 10:22:19 +0000
Message-ID: <20230406102149.729726-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB6906:EE_|PN3PR01MB7647:EE_
x-ms-office365-filtering-correlation-id: 4636e976-85e2-4f1b-14d8-08db3688cdd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wSgGjiSY93ijJ+R5g0Ml+SRKzRy+791FDVobpzb4rl8qwsGsCwOJofOllxyajAIDgBjzkxAtfrStv7sdaba4UlwvEAuzj/hxg/9uyI6LjT57eSm1RJg9/tocmRv46G0Uo4ZzogxRMtSgI/7qzChQxH9Md53+jNILwpuMR6Ity1lzigou5vxrv/PI2LUp6OMhLON0W1/zFjPGtjSJJqlWC/XYqOdbSQL/90IR43l8v+QAZxG6xkMnPTAG8Cs9TjgpmroGfD6wCc2A4eN3L9uMkhz4B3CUCLivPRPGQwiR8t1sdPx9As3SeX8IlUT6O4W7oUlRrZ/4Z0SnTT2B15TtlfZQgbZvXnwMapxVVMi7PmQHuq25PdYDe+9h3tSC8OkwadUZ7Plg+qi/IwbH66yja8mSRxoQ5MR7va6jpZD1gGEmoVb52V3o0hxY2raCHGfIL5mRVb4cBKq5kE4g2xY9Q40Hp9VjADTreTCKB60C0R9hvO/EXcAua8DzhOtZpr3PjSVJVrQ/Ua859WVXbLTRgmucDVokTk5Cdq/VTa68ACZudxkmePlNSig4+BFebJfJhwT0VHaxY/YKjX9JxHwn7JPS1x63QNpPgBB0c1dzPtqYZffiITthlQWnkol1ZpxH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39840400004)(366004)(451199021)(6486002)(4326008)(91956017)(110136005)(54906003)(66446008)(64756008)(76116006)(66946007)(66556008)(316002)(8676002)(36756003)(66476007)(122000001)(6506007)(83380400001)(6512007)(107886003)(2616005)(186003)(26005)(1076003)(38100700002)(5660300002)(41300700001)(71200400001)(478600001)(8936002)(38070700005)(86362001)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DBgzFdedntDDIY+vt6SvXqmdhJfGWwhGKLTIgJuY7DtRQIMPTKTbWvaxUC?=
 =?iso-8859-1?Q?yLe8LB30wrzuarrXkuqH+PFG2cAd2yLB6mOPUxkQd5uUZuBFzVbp/cJuft?=
 =?iso-8859-1?Q?gg/OB+UKAD6Fhfvb420Dj4Ju1dT1/ayy+Vhx9pM56ZEJpWwDyHWjmR72qm?=
 =?iso-8859-1?Q?jVwB6xHTwBlo8b0sYXBSJVfdwC1DwCfU1pKreLzO7o0pb5WIM0E9nqJ+vE?=
 =?iso-8859-1?Q?ATa1CI2urOOfqwDi6Pc/opIfkezBU6aeH4I1JPuSh86iFIogPo3WQwKKS3?=
 =?iso-8859-1?Q?qG6p9OuxIegyHFiWIVBhqdjB6WR8svOXVEtOHbiRO+8k/mVE1lRcJM8DFY?=
 =?iso-8859-1?Q?1nBGYvdW//xQEytD/UBBMM2pkXnvU/aLFXC0gp3AhT4C4eZQorFzlpwsoN?=
 =?iso-8859-1?Q?SVarv5b13WeLiNG3K3uNj4/kmjfdBhFcOCghkNZfbOSwZSw6afpxW8v3ky?=
 =?iso-8859-1?Q?gazyZsye8lVX+afoRacqkT7SCmn3qmKyvi7vo0tKMrlmIG5n91AZukI5xs?=
 =?iso-8859-1?Q?UpsvON9wKnxRvI4+/daHpwuG7V+gTyompNcE/Ku9LBhlSBliDIUfSt7qkO?=
 =?iso-8859-1?Q?eRYrBWt0VnTrCXC6AzG2DYeT4CEBjqKg3afa0LdS6rTEUuree/jsKtRJk9?=
 =?iso-8859-1?Q?eSWOAxZgxrajDq2YFKs+C+1N4CZl4GwHRTvmg/zaW9Sll02FtK3dkP3+1J?=
 =?iso-8859-1?Q?uiD1GzYm1rjoSD/jNDM2xAk0Iqb3N0hakna/xzfiKSeNLUuH8E264oMC2a?=
 =?iso-8859-1?Q?KFCmPuBZj/Jf+b9cnZ+o9/lkHhC3emcNgNa3aTRw2PKC4tEpDooMyhEkth?=
 =?iso-8859-1?Q?ThhUhN2TpKCQIze+HCLbwfR5VpB+hjxYevnDYVEDFtV6lJ339q/mvKuUqp?=
 =?iso-8859-1?Q?8J8TCJg8MN+ftZvidbv2fO1XRHH0r/YEy9aGhv5tEH3Nc447kLTddKozgQ?=
 =?iso-8859-1?Q?dYZGzex5PcakPMNjurOg2MHBa2l6jWqmGzKxJEruAoj2C9yGXdIMVBmBMr?=
 =?iso-8859-1?Q?xRP8GPEJX8NGjCkn9yGNfuhE8BG7GVbOGHfkOAozGmFTXkqCMtPPYFEeL2?=
 =?iso-8859-1?Q?NcsVPLAEOx9NathZJVjokqtA0FtOt2a6vQhOPkTpqi0u+sW6VKykC8xc+7?=
 =?iso-8859-1?Q?TtSzm2YpzM+h3raNQty5/5QOoxZR1Z/LSMcTw+M23XnNqjfRgzQlHaDsVc?=
 =?iso-8859-1?Q?C9YgMU4CD+Y6nZjCH0lOg3zXxvQqQtKKiCsjD9VhxcWp+3rGFk+kLsVdrp?=
 =?iso-8859-1?Q?rgEQhO2+O1JJ/+iEayzV79j4/VAkN4zvR2Ef5+GQgcDMv/hKABtF+Oq9Us?=
 =?iso-8859-1?Q?+ERU910E3b6h5Vad6lmVdIw1tY1ZakWZoFd2XlWQzpoctYQ6WnguUknG4q?=
 =?iso-8859-1?Q?xgrY/GtIFwpN6ziRX9jt13YsoiGNbUdIi85BS9VBWASTrhILrnZeNTSxpo?=
 =?iso-8859-1?Q?wh4aC0X2xEg45k5prVmQBEo8n/8usdQKpM04t88WgvwlOGpnMSXfCXjHx+?=
 =?iso-8859-1?Q?SpzuHkI4kKaBr6AQuVVGGtWnMsLDRLFZ5neDaqehzvYvbz1VVFw1Cvgd4e?=
 =?iso-8859-1?Q?nfq7qUbRtCEbDiGFQrsIJzC/mEB8+DXMk+mkUsq/ddNgOMDrpDJFcROXKN?=
 =?iso-8859-1?Q?zCAf/vi1JMksSCaJb1AMD/qkDFAF6bK9AlOiuHRRMf3FxQH2zK+voN/A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4636e976-85e2-4f1b-14d8-08db3688cdd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 10:22:19.9072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QqSbYZT5nbtO5RNEnXdUjWMkzOrEhnNpzU5jojZxS9k4voZyfF9E9KTcV2MrbDSt4zZXs2Aj/RfGGjv2pLhaY8kD19Hvc47F/UeosV6Mat0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7647
X-Proofpoint-ORIG-GUID: -FJt74ccbIDvoiWpTmb-FpWXQRqdHelZ
X-Proofpoint-GUID: -FJt74ccbIDvoiWpTmb-FpWXQRqdHelZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_04,2023-04-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1011 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=498 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060090
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds basic support for the Blaize BLZP1600 SoC.
This SoC contains two cores of Cortex-A53 CPUs, one Blaize
Graph Streaming Processor (GSP) and several other IPs.

Nikolaos Pasaloukos (5):
  dt-bindings: Add Blaize vendor prefix
  dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
  dt-bindings: reset: Add binding constants for BLZP1600
  dt-bindings: clock: Add binding constants for BLZP1600
  arm64: Add initial support for Blaize BLZP1600 CB2

 .../devicetree/bindings/arm/blaize.yaml       |  28 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/Kconfig.platforms                  |   5 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/blaize/Makefile           |   2 +
 .../dts/blaize/blaize-blzp1600-som-cb.dtsi    | 217 +++++
 .../dts/blaize/blaize-blzp1600-som-cb2.dts    | 103 ++
 .../boot/dts/blaize/blaize-blzp1600-som.dtsi  | 104 ++
 .../boot/dts/blaize/blaize-blzp1600.dtsi      | 894 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 .../dt-bindings/clock/blaize,blzp1600-clk.h   |  67 ++
 .../dt-bindings/reset/blaize,blzp1600-reset.h |  76 ++
 12 files changed, 1500 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/blaize.yaml
 create mode 100644 arch/arm64/boot/dts/blaize/Makefile
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb.dtsi
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb2.dts
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi
 create mode 100644 include/dt-bindings/clock/blaize,blzp1600-clk.h
 create mode 100644 include/dt-bindings/reset/blaize,blzp1600-reset.h

--=20
2.25.1

