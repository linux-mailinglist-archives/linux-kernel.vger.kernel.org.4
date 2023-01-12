Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9AF6679E5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjALPxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240593AbjALPwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:52:49 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FC625F6;
        Thu, 12 Jan 2023 07:41:04 -0800 (PST)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CFUTbL001447;
        Thu, 12 Jan 2023 15:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=6oTw16m7670nyUjoMVZCoR2dXoD6p8jYpFhDCcXFhR4=;
 b=RfplHlxukLBq+OlSEf+26q96A+eqsLmEBVr2YKsJucWzsHV/Ko4vJddHa5xYFa+Kd0YR
 bMFgqVkW8dme0cu/TUYVX1Fxwc4MQxIsDKTEG5DfYHZQYIlYsGX6JUp/nOWcKiTbRfDM
 8BaASkkuDfrrY4kA/7JT2dBvSBGUnPsFOS9CFbIkjqwzdLodfLCPJgFJ8fhDbGveIlwN
 YBhaL8vk8j9mrCttSbCCPupJiu8z9fBlCiWfY5Z/bMYvzGXIj99DjM9mFVoFzqMYCwCJ
 KhmYtCrW2KoSXEN7UET5uye2RBPaJvGERE53mNnkoQaXYcpI5NoF6fDljekkeMwd6bSj 8g== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3n2jke1e4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 15:40:27 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 2E504310D8;
        Thu, 12 Jan 2023 15:40:26 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 12 Jan 2023 03:40:25 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 12 Jan 2023 03:40:25 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 12 Jan 2023 03:40:25 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gs9nfEbzA89ABFdEDye3Wieg6CSORatP2J8upz6nt6uw+utspoRO3DQdZw6S8xhmm/vXqUS7pu80ev+ByPW5DOFQyqkPhT4QeeohUDnUKk/DUiuc5Ty0nz9JFM5buKApEeNAMOaD/hCRUOKracpJ7Z+ByEDsaRqEJnRKV9j0NCuh8aGzxL0XuiMYCyJlA0ME0zJ73da1XkU4FOeFDFwrbtXBnHmAhy0cRweoskVmAykGG0L70qSxcqmaYgdJ8AcPNJTDFRJRMiKzgWxFG7s5jrJ0HcnFixCspVPd34ug6uvRvtW1FBB5sCWOafO1f2OGkewxwHwn+6xQp4wDEyMPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oTw16m7670nyUjoMVZCoR2dXoD6p8jYpFhDCcXFhR4=;
 b=PkijTjwOK8LU+HBwGZn61MHZBqKyyjzI4k0uxjBAsHUvu9aqkChLGvCHYH30euk6s1uqkgAb3kbykHt1Vm2/lW0OixHXPvfVX7pLZTO85eijeRMGl2dlvzghYpjwntHpNd+Am7X8z+qz49ARssy5KnspGg4bNk0aH7XfqU3TSmK6s7wT90wWrTI0LSrHnFmPkM+rUjsZmVdylHgV4VdAjb5N83JP1DbRQwTGIvLQwOkJSTZEAbYYW4F2Wx0AglflzGDDIGn+wLSsQ33NC4ixHX8qfARqAmX17FWbFy819EZUo2bFN7y01Xcko+o9ArXjQqFQr3nqhUelgh6CAtu6gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW4PR84MB1393.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 15:40:23 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::de12:a5c2:5c71:6b87]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::de12:a5c2:5c71:6b87%6]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 15:40:23 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 3/5] ARM: dts: add GXP Support for fans and SPI
Thread-Topic: [PATCH v4 3/5] ARM: dts: add GXP Support for fans and SPI
Thread-Index: AQHZH7Ntz67eM5qHOEa31meIwV2aT66a49yA//+whoA=
Date:   Thu, 12 Jan 2023 15:40:23 +0000
Message-ID: <E2B35D8A-B8A6-40C1-8AC9-46E6C2CAE656@hpe.com>
References: <20230103203654.59322-1-nick.hawkins@hpe.com>
 <20230103203654.59322-4-nick.hawkins@hpe.com>
 <5ad677f3-2cbc-4ba0-bd48-2f832a72fb28@app.fastmail.com>
In-Reply-To: <5ad677f3-2cbc-4ba0-bd48-2f832a72fb28@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.69.23010700
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|MW4PR84MB1393:EE_
x-ms-office365-filtering-correlation-id: c8165237-145c-4daf-5bb7-08daf4b351e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O0BBfsusZZ0Qu+lfij8WjWMB8GoGRfCHL1wIInqdXT0vz0CXXvZmjNUpLg/P2Sh+HV7EbLzsdcYg21YU4rmXWcQFzY3QEcl2Pfg/j8D5j96PsMCqRLOXw2+7FcQtnsllJObCXr/+vemgmincSrR1ZpArnvpW/Z7p09rELotcHKDSpsOsBn8Qi7w734p3hfTAtEM6+dliVk/cw9i5WZ0RIHvNaoUNsJHGSrkyBeCNYwTDz5sYk9GJvX49Jz19D7lTzs/goxd9CBCyDWN1Ce+/fYRdt0FRTurm53+aGlFSs8Zny7+dwzN8o0+PHkUFmqDcZR0foJqhPub0vBH1gCDy4Ge9OyVnc6bTsdWFP07K4S9RD0Q5+XNys0Yv4u25/GK20/2iSoUJbPaRLVauerNENapHCaqHlWBamaIg4becPvwvmBNJ+ue6CFNNVjY7kgC9OgmcQIcELCVcRF7kPezYXX6On9ctvc7Y+vEZ94jrhWxGQdNZAh3p+38E3I/MjJ+6T+7xzgJ6l79Pn4LYndeVKzAXJIPMtxjTPoBLEAhqvgcwnhPEtuQHgHRgghBFtcphZOUbNBUoSK2kMvAXc79RBgc8HHdrw2HBzzvw4sMftT761wvBYa39NFhkf7LppngJteSEfJOk3dhiC0CJSYdHZYnsTr8WdSumKe+abI+ViBuYw8gKMbUS1qKbAi/HI7RKXYjnRyb3uBrREG2gOEGxPLwAi9BjLQDXTOA/R2XZoS0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(186003)(33656002)(7416002)(2616005)(316002)(6512007)(478600001)(38070700005)(6486002)(5660300002)(71200400001)(36756003)(76116006)(41300700001)(91956017)(8676002)(66476007)(54906003)(66946007)(6916009)(66556008)(66446008)(64756008)(4326008)(83380400001)(86362001)(8936002)(6506007)(122000001)(38100700002)(82960400001)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Si82MHVSak0yQ2N3cWJuc0U2b3RpNGFIblNjdEthYkI1UTZoUGFJSkRiU2xT?=
 =?utf-8?B?d2xKaFo3anVzNnc4cTVqU3JEcFpoQ1FTLy9xV2xObExYS2Z2Zjk2VHBHMWRL?=
 =?utf-8?B?NFVTNmNYOG1wYWJYUGNFWFl5bzJQR05uZ2c0bmFBV0FYZVAva3g3TVNCaW1v?=
 =?utf-8?B?Nk5Ub2lDdDFUcWhYaUd3Sk95S2JpbFRWZXpWeVU1QmtnaXo2K0VlaFZvZldE?=
 =?utf-8?B?YjBsVnZ5cmFVSXp4cHBZS2g1blhsSktIcXB5THA1Mmo0enovTHpJWEh3SUVs?=
 =?utf-8?B?ZDExUDMxZUsyZEdjNEMyVGg4Z3F4ZW9ES2tKNFpsTTNweFNUMnM5ZElua1JE?=
 =?utf-8?B?ejdZZUZiN1ZGN04vRVUraTNwcC84Mlpydk8zL1VYMUxhejJ5dUoyRVEwTW42?=
 =?utf-8?B?bW0yZE01QVdPbW5aVmJScVVsVmNPejlFajVYU09MY2kzTExER0VIN3JWWkdO?=
 =?utf-8?B?SUtQeDZuUUNTVmxyb0M5MHFLdWlsSGg1cjcxczMvN2YxWUVENzdpZVoraThL?=
 =?utf-8?B?azZXdXJsLzI2MWxPL3NubWJ4bFpPblBhelZEeUhOTUdZWXlZalBPazc0UUZW?=
 =?utf-8?B?cnlsS0pvdzVWVTdNai95TklRbjJGZHJnaFQ3RUdiYUpiMSt5Qm9JZUJHMVVO?=
 =?utf-8?B?M2F3a2hIZ3A2ZzlGTmlpNmJYT1gzTy8rZ3diQ1cwVFo2aHRJV1QvajI1WjU0?=
 =?utf-8?B?S3RNTjBrZG90Qjdra0VwY2VTRzhzSjlYeU1TSU9KRnZNVU53Mm1LQlZwS1N5?=
 =?utf-8?B?M3U3OEtMQ3ZrVzN0UndzYktiN1ZpYkZuLzZxeUpDRXJ6TG9zTTlXbDhxa29H?=
 =?utf-8?B?Q3owVHl1Q2d2ZmRqaWZKbktTVktWRnVFYWlxRmpzMUNGd2Ivek5aQjRjeFlh?=
 =?utf-8?B?SC9XZ3pmcU4xWjFiQXdNU0lwb3ZzUkF1V0R3WFFhdnhSOFA0endPaTBST3BY?=
 =?utf-8?B?MklBeWFYU3NhVUlHYlA2cElLS29lMVl6OTdyVWNOWGpYUjloblZsTHFQUFNo?=
 =?utf-8?B?U1YrUDZvSldUSDliOXAwKzBVWXpKSEZ2RGhpZVhYdTFVaWdSdzBhWHhucVRv?=
 =?utf-8?B?Q1B4RDVrRVc4NC9HTWl1aGNCendhOXJNeHdKWDZrcG5PZ1AzZTc2K1l1N2ls?=
 =?utf-8?B?bUxvUi9HZ3BuQ3pRblFYQzZwS3dKb2RxQUlFL1VObjM1VTVCcDVQUVJHQi9W?=
 =?utf-8?B?REpPai83STloTno4eGNhTHJIQ0FhVGYvallpZVBZVUk1VGhLQWdDNkZGSFNI?=
 =?utf-8?B?YWk2d2dveExGRnQ3dEJ4d3FQQnU4OFpBa0U0L1JyczVmMDZLcGVlUTBSWmto?=
 =?utf-8?B?VGVSUnNpOVhicDVyY3hGSEZLK3lBaEwvRHpNYmhiK2hLNHRNOXdDdk00a0pC?=
 =?utf-8?B?cGhRS1NXWUNMSmRMZUFkQ3pXYk1WcExSR2NKL1U0UmIwZmVhR2h5bTg4dE9l?=
 =?utf-8?B?clpFb0hFTkVmNVpDbE0rTENBTmtKZDFReU1uUjh4THNLN2R2dHBldzdua1NB?=
 =?utf-8?B?OWphcjZhTFdXUWRuQXNMWlMzQWZzYWxGVyt1RW13YWh4NWZJRHNNVm9CWVUv?=
 =?utf-8?B?N0lUTWtDQzNOcElUaUdkcnE4V2pMZnErMzhBR1RFZUFVV2MrS2tKcWFGNUhS?=
 =?utf-8?B?QTgyQUR3azhlNGUwT1ZGTVRram5pSUY0bjM5WFYwblFrTzBReUgzaXUxckht?=
 =?utf-8?B?b01vbXdneHdxT3NuN2Fpd25IWnJTRnZTSDYwUlRUc2FkWk1xc05mQVgrY0Za?=
 =?utf-8?B?d0tQZ09FRDFNVU5INTJ2OEhIejNnM0d3cjUrQU0yVjVoYjM1eVhPN1Vldmhi?=
 =?utf-8?B?ZG1zM1hYWngxcGdMa0J2V1VSTDNTOStWbmtwaG9GYW14ZUQwR3I3NmJiUU1r?=
 =?utf-8?B?TStVS01QWGMxT0NjaitOOTVKYk84cmJhTXhHbGFYTlRnNTlSMHB1Y2hyKzFZ?=
 =?utf-8?B?MkViUk1yRHQrNHcwTUpLVUljd1NFa2k4WTBWbTJvTUw5S2l4dC9sUmpXRjls?=
 =?utf-8?B?ZmcwbFF4RjVIcStyaDVjZVB5WDRHWHBlaFI5bVBwWnl1VjBFa3h1TVNPLzRk?=
 =?utf-8?B?em9xY3h2dDNtelY5ZjhSL0FoYitMd01uZTB6MkN1RzZlRUdrK1htMXRyS3ll?=
 =?utf-8?B?Mi9TMzV2a3lCb0lpQnFtN01xcFRtaDUwTGZ5bjFOYU0vV1I5dW1lRVFGTGVL?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63D21C31FC5055438E03E5DA4F2C3200@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c8165237-145c-4daf-5bb7-08daf4b351e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 15:40:23.6186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIUCVw0jQp9CV6yJ4QPNb19AfzUkNX//mxvVU6HLXikbewMBcPXS2cWez1kfE0i5prtOBUrC2EbLSEdaFg/wXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1393
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: QzNgV6H_pqT0iH1_vrBS3LKRzmJE3KE8
X-Proofpoint-ORIG-GUID: QzNgV6H_pqT0iH1_vrBS3LKRzmJE3KE8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=785 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120113
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7vyANCj4gPiAtIGFoYkBjMDAwMDAwMCB7DQo+ID4gKyBhaGJAODAwMDAwMDAgew0KPiA+
IGNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+ID4gI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+
ID4gI3NpemUtY2VsbHMgPSA8MT47DQo+ID4gLSByYW5nZXMgPSA8MHgwIDB4YzAwMDAwMDAgMHgz
MDAwMDAwMD47DQo+ID4gKyByYW5nZXMgPSA8MHgwIDB4ODAwMDAwMDAgMHhmMDAwMDAwPiwgLyog
MHg4MDAwMDAwMCAtIDB4OGYwMDAwMDAgKi8NCj4gPiArIDwweDQwMDAwMDAwIDB4YzAwMDAwMDAg
MHg3ZmZmZmZmZj47IC8qIDB4YzAwMDAwMDAgLSAweGZmZmZmZmZmICovDQoNCg0KPiBJJ20gYSBi
aXQgY29uZnVzZWQgYnkgdGhlIGNoYW5nZSBpbiB0aGUgbWFwcGluZ3M6IGFyZSB5b3UNCj4gc3Vy
ZSB0aGlzIGFsbCB0aGUgc2FtZSBhaGIgYnVzIGFuZCBub3QgdHdvIHNlcGFyYXRlIGJ1c2VzPw0K
DQpZZXMgdGhpcyBpcyB0aGUgc2FtZSBidXMsIGhvd2V2ZXIgd2UgYXJlIG5vdCBpbmNsdWRpbmcg
YWxsIG9mDQppdCBhcyBpdCBtYXBzIHNvbWUgaG9zdCByZWdpc3RlcnMgdGhhdCB3ZSBkbyBub3Qg
d2FudCB0byBhY2Nlc3MNCmF0IHRoaXMgdGltZS4gDQoNCj4gVGhlIGNvbW1lbnQgZm9yIHRoZSBz
ZWNvbmQgcmFuZ2UgbG9va3Mgd3JvbmcgdG8gbWUsIGFzDQo+IHlvdSBkZWZpbmUgYSAyR0IgKG1p
bnVzIG9uZSBieXRlKSBzaXplZCBtYXBwaW5nIGJ1dCB0aGUNCj4gY29tbWVudCBvbmx5IGxpc3Rz
IGEgMUdCIChpbmNsdWRpbmcgdGhlIGxhc3QgYnl0ZSkgbWFwcGluZy4NCg0KDQo+IEkgd291bGQg
ZXhwZWN0IHRoYXQgdGhlIG9yaWdpbmFsIDB4MzAwMDAwMDAgKGluY2x1ZGluZyB0aGUNCj4gbGFz
dCBieXRlKSB3YXMgY29ycmVjdCBoZXJlLg0KDQpZZXMgdGhpcyB3YXMgaW5jb3JyZWN0LCBJIGJl
bGlldmUgaXQgc2hvdWxkIGJlOg0KDQpyYW5nZXMgPSA8MHgwIDB4ODAwMDAwMDAgMHhmMDAwMDAw
PiwgLyogMHg4MDAwMDAwMCAtIDB4OGYwMDAwMDAgKi8NCiAgICAgICAgICAgICAgICA8MHg0MDAw
MDAwMCAweGMwMDAwMDAwIDB4M2ZmZmZmZmY+OyAvKiAweGMwMDAwMDAwIC0gMHhmZmZmZmZmZiAq
Lw0KDQpJIHdpbGwgY3JlYXRlIGEgdjUgdmVyc2lvbiBvZiB0aGlzIHBhdGNoc2V0IHdpdGgganVz
dCB0aGlzIGFuZCB0aGUNCmRlZmNvbmZpZyBmb3IgeW91ciByZXZpZXcuDQoNCj4gPiAtIHZpYzE6
IGludGVycnVwdC1jb250cm9sbGVyQDgwZjAwMDAwIHsNCj4gPiArIHZpYzE6IGludGVycnVwdC1j
b250cm9sbGVyQGYwMDAwMCB7IC8qIDB4ODBmMDAwMDAgKi8NCg0KDQo+IFRoaXMgaXMgbm90IHRo
ZSBzYW1lIGFkZHJlc3MgYXMgYmVmb3JlLiBJJ20gYWxzbyBub3Qgc3VyZSB0aGUNCj4gY29tbWVu
dCBpcyBoZWxwZnVsIGhlcmUuDQoNCk15IHVuZGVyc3RhbmRpbmcgd2FzIHRoYXQgdGhlIHBoeXNp
Y2FsIGFkZHJlc3Mgd291bGQgYmUgdGhlDQoweDgwMDAwMDAwIGZyb20gdGhlIGZpcnN0IHJhbmdl
IHBsdXMgdGhlIDB4ZjAwMDAwIHRvIGJlDQoweDgwZjAwMDAwPw0KDQpUaGFuayB5b3UsDQoNCi1O
aWNrIEhhd2tpbnMNCg0KDQoNCg==
