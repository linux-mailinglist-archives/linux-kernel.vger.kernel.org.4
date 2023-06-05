Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD785722D06
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjFEQx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjFEQx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:53:26 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03544D9;
        Mon,  5 Jun 2023 09:53:24 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355G8Bjh013207;
        Mon, 5 Jun 2023 16:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=DqgmTjElAzCNxuQUwfS3Kd0tQXAQTtCpPACWULnTTuc=;
 b=YKWYnks5q7ZMveXF+mzOXhwRX5bzmkGSEQogSmF/68urRAbtOwnrORuFDzBd9W5LLCOo
 vVCFx6lku6/zvUC1K4hRwsPSvKf2i9p5Xmh3Y9YQG76Huu+Vsc+Bj3RnjECe7YfNfZNy
 5MWYQZswKvJC42KMfBdGoEF4IHZcZkea4ibi/Z8lzJ237OrLh38FA6OxYDHVKCg0Evox
 g+PEjUDxSCR+SOE2w4BJU63T/Wa4YJqfvCmkvgYEbnDlSaf55NZLRTuBRHsg/66xLN6w
 ednhYAW84+z6ACyIQbYl/X+VjGU4B4zf9OTa4bsbBNwIDw/2HP0cMozpbHowOnkdmRjN IQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3r1fyg242a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 16:52:59 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id A674D800195;
        Mon,  5 Jun 2023 16:52:58 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 5 Jun 2023 04:52:50 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Mon, 5 Jun 2023 04:52:50 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 5 Jun 2023 04:52:50 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaaC1vmUdigp/7SvPFvlhWKr9h3rXFF+8zcFQ9fQZGB+UuMAUjzXEp2Z2HYL4rWFjSaHgHwr7eeZYKdLrXJmphmndRlhjK00H5Aq3uSFSJQ0O5JrDd7XBULGpYPLXiOxVgyhMIMI3Cxagk1g/yL6UzjqqXSA+qv+B8lwKzeWA9cvUrItAaFog2+FUdyU+fT1KB9l4CPZCBRro8UaZ7yQUcktX+oSjON9jXpZttMlV2o1lXD0eB1cK5o9UbXWcFkS83RAR8vqCPdPu2tok4GcZOEV+fNslICpCzaOJYPzpXjFmsH5y+o1x8kq1J38g1nUylEd4Ci0DRI2cQTWwOsnfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqgmTjElAzCNxuQUwfS3Kd0tQXAQTtCpPACWULnTTuc=;
 b=AQoDvRXx9PXt5bd2S7G1aZ9wLnmXZC8jJ9EdMGqmhGUtMurNEv9MRjpOvlHwxFtz8sPXzhbSYZRRFQ5KwlPjDMMgaxgB01suqrfQp9ZdmP+RAUPmeFohlUNjfSskPxp9ZUyO6OKpN+MWI0Em07ZZSJ9MfBsG7/04tpDyGqXse+/GaH/asJkdJgJ7xdNTl6oDMxh9jteaWsgo1wvqzkrVevXVP4ArPwncy/bQWEFL1umaDu17CLGbyxx/rcBBiAzHFEPzVVhejwqYZFlioWnS8DIA9UuFLX8j8MbDPg6XINPSn+x77LqjNd9849pOo9cYZqp0ts8wO6eIb3Fw2Xyc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW5PR84MB1772.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Mon, 5 Jun
 2023 16:52:48 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 16:52:48 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v2 3/5] dt-bindings: hwmon: hpe,gxp-fanctrl: remove fn2
 and pl regs
Thread-Topic: [PATCH v2 3/5] dt-bindings: hwmon: hpe,gxp-fanctrl: remove fn2
 and pl regs
Thread-Index: AQHZk9PWOZXG2Bdm1kuv4PPPnYdx5a91g/kAgAbottA=
Date:   Mon, 5 Jun 2023 16:52:48 +0000
Message-ID: <DM4PR84MB1927707FA782DC565C22B8A2884DA@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230531151918.105223-1-nick.hawkins@hpe.com>
 <20230531151918.105223-4-nick.hawkins@hpe.com>
 <d2232369-c7e9-c572-8528-243800f0bc08@linaro.org>
In-Reply-To: <d2232369-c7e9-c572-8528-243800f0bc08@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|MW5PR84MB1772:EE_
x-ms-office365-filtering-correlation-id: 17064c0a-17b0-4fd1-41ea-08db65e54af0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3lVFDrEAZ6hme37itKb2E4u68XAK3oYhuZdZ+7dQEhwiI4TlGZPb8+uWVcx5IENpiD+lf5GmwarKzf8LEi/695D6+qqsIqKEJu8d6VnijjD9BYVY/KHIEH2Db8dOEnZemUuESqrA6qbGKAezndjRZ/G4UED/XAEZKUHFlh7Tb2sucdCY6djr0krno4NTZGHFTRmWjMCMWPa1bkerbZBu0ZIiIbdxFIZ1YuEah+vTTV0S8Hqna0LYtg4hznQDxD9htDcnmy54uF2p8Rk/bsppLa2uIUOA1oJtp0Zg1VsOVaUSVXZI5N+s/hcOLhXPSlcIdk0bCa+3+akzRJAjTpnjqfbORuYhl0nnRvQJ4EH7THWTWQ5/LR5KDmAMpeqAu1lTd5R77RrqomYyhFLR1VVU6JzoKlQ/Eup2SpQ/jgnGOhPiyd+B0/006hjNtZwLITRbEuM0UrG+ERwD5zDG1y2Dksm1QV/gQQeKHkxy4gHy0CIeE+XtABn+XIKQjonXIjDVzWTfWmF28S99jxjXJZNzDig0v17BsRfbgkQX0PQ4O7Ke97HqyZca0dq+06pOIfQwyYc0gQXOoHs/isk1bv6S2kukydUOqigzQEa+53r23hVv4XnLK7B9Am6nHlQYZXER
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199021)(38070700005)(86362001)(33656002)(55016003)(122000001)(38100700002)(82960400001)(478600001)(71200400001)(54906003)(110136005)(4744005)(7696005)(8676002)(8936002)(4326008)(52536014)(2906002)(7416002)(5660300002)(76116006)(66476007)(66946007)(66446008)(64756008)(66556008)(316002)(41300700001)(186003)(83380400001)(26005)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWJxM2c2bysrcmxTZHVSQzNKWE9VeEZHb2gyY0o1WXVpaTFXZFluUTBlV2FG?=
 =?utf-8?B?cGJCbER5OVpIaWI2VGQzOXptQjJWUGNtOUJYM2gzdzR5M25PMHUvWVYyOTFG?=
 =?utf-8?B?N2RJMDRBOUlXS09TeUJXOFJjN2FDOHZYYW1hRkYrQmZuV1pVTDJIS01ES2tQ?=
 =?utf-8?B?RUFQQjdTOStQa3VSejJNZEJoeVJzS1BTR3phRm9HNUxxVk9aOEVkazQ1dDZm?=
 =?utf-8?B?b0VET2VnWXBwY2dLdWFwNVNWc2kzdXV4OW8rRFUrek81SFN4MWg5UGZTb1dQ?=
 =?utf-8?B?dW9aWkNuUllQc0xJNTZqOXVPdTV1TVRYeExCMXU4MUxudkQzazF5RURUUXBB?=
 =?utf-8?B?WnRwRlAzUlRqbEhFYStFQXFtN1ZCZk5DaVZBbERFcUhPUFBDTVVXc2FldEts?=
 =?utf-8?B?d1pwb0JZcEw3U0wwbHhMeDhWZjR5eXFINzhjeUQzTk4vTjh6K2ovLzdPcHlH?=
 =?utf-8?B?S0RQa1JDUXNlSVM4cGFCU2VrZTFyN2FQeGZGeCtEUkZZbHlRREhMdURxTmw5?=
 =?utf-8?B?QWVwcENGSE94bitmcFI5UmlDbjAzNGF6Y2tkWTB6bm0vbURVZzcvdlYwR29V?=
 =?utf-8?B?b3pZWVFjYjVUMjdPUVpxMnBCZFVRdDBvYWx4YlZoV09na01NZGM3L1lPbkpX?=
 =?utf-8?B?NTFjQTZ3OXdKczR0WHpnWHZBMjVFL25XQXdQSVcycHQ5cENyVnNla1g5Q1NP?=
 =?utf-8?B?SUhHSDMxdVV5RlVic1dVYk15RGlrcTViS0I5TFR6UFNUR3dHcHAvQnRXTU5q?=
 =?utf-8?B?enYyS0JDUGhVOWViNW9XNzlsYS9FYWVTNTBabTNnZDRUbnpCR2NsT0tmQ0pr?=
 =?utf-8?B?MEJxRGRIU0NFb01zUm43N0wwYTdjQ1V6alppTS9YRXZybDREeENUOFhqMTVo?=
 =?utf-8?B?Qmk4ejFNdFErTU9tVlpCMFBNNVpJck5ocktGTER4VzJaMVIvR2t3K2xDeFh5?=
 =?utf-8?B?amRucWdBK1ZwNnVnSXJuSXQ2TlhkNXBtVE0yTEVzNjNYNFRuSzJrRTVYTUhp?=
 =?utf-8?B?QXM5Qk9Wc1gyR0JNT0NuSlJtdURVVExlZjVWSnJLb1d0cUwvSGdtdXRacW8v?=
 =?utf-8?B?QWMxdkVWV2FWUXJvQ1RINEcvOUNjOW1tZXVuNEtZaC9Eang0NzY0SlpHYkZp?=
 =?utf-8?B?NFlmNHNDYWU1dUZDaHVwNmhDVUlFN3ZiTU1IRmhZWUhuL1FYUHRLclR3RnFF?=
 =?utf-8?B?enc2NkNsNk9GZmRtWWdkbWFvZEFwUytmRGZuaDI4akg3em9mWWcrZVZsblg5?=
 =?utf-8?B?SnIyYW9QVzdXQTVBTzJBNEVUR3RWUDNPdjRsOG02N3hUMGpqY1p1TmlYSklH?=
 =?utf-8?B?TTM5ZXE2ZUMzcDVtdFRDSHR4U1FXRTYyS29GZUkxblVRNHFmN05yRTdPQkNz?=
 =?utf-8?B?NWVwY0dPSDFsS1cxRVhraERoWjlBRXg4UmllR0ZONmwyKytsTHhGR0N5VjI5?=
 =?utf-8?B?b2tUR2xLTUthQVdKWDdmcVFZQmsvU1RRa1c4akNoY29YLzFGN21mTlpROER4?=
 =?utf-8?B?L2x1S1Ixd2JsbDMzWTBFVldzTnpzSWZwRlcvYW1UV0c1TE9WbEVaUHlCbExt?=
 =?utf-8?B?Y3Q0TDR5cDRSWlY3VUVaYTMyLy9EWTM4K3VnV0dXblZWSjRNY0VtZk1JU3VB?=
 =?utf-8?B?Uk5rbDZFYVFyUERxU3UwZC9QS1QweDUxM25FSmZnR3Jhakd4cGdQOGM3RTYy?=
 =?utf-8?B?WEJLYzUvcGphMWlBNkpwcGxIRGJHWnhEMXBYcVZxZjFTeTZ4YnIvWldrbDVy?=
 =?utf-8?B?eGprak9rU2R2OFgwbDNFb1VqWTdFeVJPaWx0dElsU2VCa3doSnc3STNyNlRl?=
 =?utf-8?B?RjNZWTF6Nk1HRHMxM0pydDM3NmRGL0JlQU9WdEIzMUdpNlZHMG01TkJNR0ts?=
 =?utf-8?B?Qkh0TURycnFMalJrWUF1a1cxS0xEdXZid283MXk2SzVLS3dHN2luSUtUZDVJ?=
 =?utf-8?B?QjU1S3FEcExabGlrYzIxYkdPbmNObCsweWs0SmVOa0pjQ01GTU9Xb0JrQTk4?=
 =?utf-8?B?SkF6aDVGL2xrY2RuRlpjd2J3YUxRQ2J6YStPN1k0Ym1QV3JSRTN2ZmJjZytC?=
 =?utf-8?B?Ym1tKytLbG12WjcybkVOdWc5ckxVZnN4STYzb3ZhYmhkR3IzTHNRSE9oTmlw?=
 =?utf-8?Q?QwUjTJuSR9QDi//kUQ7w+gkqH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 17064c0a-17b0-4fd1-41ea-08db65e54af0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 16:52:48.2165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EuJarh+wA44kygpOF8f0psgT+fEqPijacrbQdBzy6C4Rnwryv+qtGxk2T+8FQJ/mVBzhG6PGJ06HSYIcGGRCMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1772
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: QXxqHZiSDsiikJEj9Ev3QwY_osDTiuKX
X-Proofpoint-ORIG-GUID: QXxqHZiSDsiikJEj9Ev3QwY_osDTiuKX
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_31,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=608 phishscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050144
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFJlbW92ZSB0aGUgZm4yIHJlZ2lzdGVyIGFuZCBwbCByZWdpc3RlciByZWZlcmVuY2VzIGFz
IHRoZXNlIG1lbW9yeSBhcmVhcw0KPiA+IGFyZSBub3cgY29uc3VtZWQgYnkgdGhlIEdYUCBHUElP
IGRyaXZlci4gVGhlIGZhbiBkcml2ZXIgbm93IGdhdGhlcnMgZmFuDQo+ID4gaW5mb3JtYXRpb24g
ZnJvbSBHUElPIGRyaXZlci4NCg0KPiBIb3cgaXMgaXQgZXhwcmVzc2VkIGluIGJpbmRpbmdzPyBJ
IGRvbid0IHNlZSBpdC4NCg0KR3JlZXRpbmdzIEtyenlzenRvZiwNCg0KVGhhbmtzIGZvciB0aGUg
ZmVlZGJhY2suIEp1c3QgdG8gY29uZmlybTogSXMgdGhpcyBjb21tZW50IHJlZmVycmluZyB0byB0
aGUNCmNvbnRlbnQgb2YgdGhlIHBhdGNoIGRlc2NyaXB0aW9uPyBGb3IgdGhlIHRoaXJkIHZlcnNp
b24gSSB3YW50IHRvIG1ha2Ugc3VyZQ0KSSBhZGRyZXNzIHlvdXIgY29uY2Vybi4NCg0KSW4gdGhl
IHRoaXJkIHZlcnNpb24gSSB3aWxsIGJlIG1vZGlmeWluZyB0aGUgZGVzY3JpcHRpb24gb25jZSBt
b3JlIGFzIEkgd2lsbA0Kbm8gbG9uZ2VyIHJldHJpZXZlIGRhdGEgZnJvbSB0aGUgR1BJTyBkcml2
ZXIuIEhlcmUgaXMgdGhlIG5ldyBhdHRlbXB0Og0KDQpkdC1iaW5kaW5nczogaHdtb246IGhwZSxn
eHAtZmFuLWN0cmw6IHJlbW92ZSBmbjIgYW5kIHBsIHJlZ2lzdGVyIHJlZmVyZW5jZXMNCg0KUmVk
dWNlIHRoZSBocGUsZ3hwLWZhbi1jdHJsIHJlZ2lzdGVyIHJlZmVyZW5jZXMgZnJvbSAzIHRvIDEu
IFRoZSBmdW5jdGlvbjINCihmbjIpIGFuZCBwcm9ncmFtbWFibGUgbG9naWMgKHBsKSByZWZlcmVu
Y2VzIGFyZSByZW1vdmVkLiBUaGUgcHVycG9zZQ0Kb2YgcmVtb3ZhbCBiZWluZyB0aGVpciBmdW5j
dGlvbmFsaXR5IHdpbGwgYmUgY29uc3VtZWQgYnkgYSBuZXcgR1BJTw0KZHJpdmVyLg0KDQpUaGFu
ayB5b3UgZm9yIHRoZSBhc3Npc3RhbmNlLA0KDQotTmljayBIYXdraW5zDQo=
