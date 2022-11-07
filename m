Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5255862025E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiKGWh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiKGWhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:37:24 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA7F17A9C;
        Mon,  7 Nov 2022 14:37:23 -0800 (PST)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7KWNq3028029;
        Mon, 7 Nov 2022 22:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=yy9cVGaKyD20oHziGJGbDYEQqI+ud6MuB7MO1J0sa10=;
 b=Cs4CBjSKRAjE9x5tWCl8/WjpjXmtSS3ZgDUvbrBos6cYTmAwbVhbFGCIWwkUp4FAwJMS
 ydDMskysBO6JUCMwt3jAjgn3in90xtLvfdlrzO208K6dMvMO0SLMPT0/uxogCG0L+A0w
 pk/nXK0cNUH1VFYun9kx4lnOpQTg+f/8rrS5gYPH3Do7Jdvc/jsrgm3mvP0Nv5vk/jRz
 KosuIhnooqjAK3un+XA96nfIsXjP3/QbG0TRYaOqX0D5bRsmal0WnheViMZC+gV0Iyu2
 3cD5pL4Swrvp2j5GYm3DZ5fBObolPO5CHYv71arBmFknhsJyxjTj+iq0z6kNeLG8kXHs KA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kq94xgs2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 22:36:53 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id E180380471E;
        Mon,  7 Nov 2022 22:36:52 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Nov 2022 10:36:52 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 7 Nov 2022 10:36:52 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Nov 2022 22:36:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g532hu+VUP9G8PrCwvMvvdCeRsRCxp6G1i49L14QNwK1jZeEBLXmcSBQmKy5SrM6s7n183Sl9ptF7CjLIjab6rI8T5iSXULZKQR+ysIyjhbD65GW6MD1X5FfGJBy+Oyk4fltywHogZgvCZPrYK3ntTzGISZ0vO3NjfA+ZntedIdYvsQUywod53QgfV7rD+OAEWeQZ9cpZuqg9ZIxXbaN2kKxs13ttW1CNPqNMH/+BYbS9L8pdvy9BLeQ8D/UZIbgDHgIBqfkAagBOY6MSxl3c8VU1YymsHs4tYNGD9LdFBSZRT+EJ9kXokB5YC4z3H1k6lnd+nLbJ1rayw1e9NaN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy9cVGaKyD20oHziGJGbDYEQqI+ud6MuB7MO1J0sa10=;
 b=IcxgyNsNnjbzbm6TQTdYjGQEftx1wQZsARrfjFdSHjOsxSOMUQ+9d8d4zJw8glXQl68NWT1iP171P+TgoC74+ceFyHoFMwo1BeGuyfHznhhy+dDIg2qu7m9eK6MQtr9LQ5JyNEo2KASxkjklaPkEdRkaXHH9wMHKZJLHUcTXYiGm4sroPYiQ4RwSLMUcLvWivA1RsGc9rp/4mfuK8CmBGsNb5BYczr0hvf7Q2KauCKOtTOBKAGIjxQBM+HGh1BSYfn7z+QftvS+5AEpyemrWegrLFFp8ohYipm9V8gyA3pptar7mciQrTwmX2leGR0+yK2Fz3V9HQpgLx+speUnE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW4PR84MB1682.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 22:36:48 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7949:4505:4974:ad5f]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7949:4505:4974:ad5f%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 22:36:48 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 3/6] dt-bindings: hwmon: Add hpe,gxp-fan-ctrl
Thread-Topic: [PATCH v1 3/6] dt-bindings: hwmon: Add hpe,gxp-fan-ctrl
Thread-Index: AQHY8IUEH8BHEDSFJkCt/7SN3E/8Qa4xtsSAgAH2dAA=
Date:   Mon, 7 Nov 2022 22:36:48 +0000
Message-ID: <236F9C0A-797D-41C6-B342-4C32DF28C426@hpe.com>
References: <20221104193657.105130-1-nick.hawkins@hpe.com>
 <20221104193657.105130-4-nick.hawkins@hpe.com>
 <1b90f86c-9c0f-225b-38b5-6f37a4eded69@linaro.org>
In-Reply-To: <1b90f86c-9c0f-225b-38b5-6f37a4eded69@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.66.22102801
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|MW4PR84MB1682:EE_
x-ms-office365-filtering-correlation-id: 9a4beafd-1982-4d55-3aea-08dac1108ee0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jOkQQYipdjCNYYJQCvWIwI29VhtyPa2XtGoBJSx03flGag2mirJ1hN/pE4nRUXQ3SUCUhy2/9m2T6RpbuGzdt3eW5PSNOui+zplFF/fNF4ToUuiVdR8/8QBB0gOGaEvCfcskubfrBHTx7BDCqqtpLXxcb32ztCQUUUXDtvTPqjMp1bMCbIBzFVYCIzq+cZfCrAYImX52dQBpHQds8K/bRJKv3IT8NiqdXNiSpqb4f+Uev6wNtCgn8k8OG05qcUt4lTOSWpHPrEz2gQ0wUd4gT8j5PiC95O6FoEfO+S5IAUiF6nn0HGUG4y2XMmAlNn9cMUCDGB7rn8wKhKnz1wJ15WNPNKxt/HVgOGtZOumZewLk57on+yy02qIVU7sMK9kC3gyJkCXG5wNbP1+8HP2YWu8DVKsGKeZjoEnutPjI7bMxdvoLDWmdNYi65/ht1ex7aAyLscwilci89sdla3btAFp44viXFvEVm5s0dUjFe6fuCUE961Nz19afK/ueli8cyenL0pgw4hQN3AXNss9dcsTtBzCpZMA/n8beFtxnGK9reVvZjQJnKZbKxKM0fZfpP4UXAArcNTUo13YCTuXvFyEqqEuQCJZ7fP4aTXoF6bamRtwdydZ9f0Cg06+5KjZW3uqQ0zrYJvFrXmgzvTV8T7FACYB4hlBUdAv8HxEu4hzYV7E5t+zEMR/oKxybfrskMaBmeNG5OGN6ilZoiw2qMnNJo4PU8/YIu4IWm97vnW50Bu9Ixrq+I7krRMYD5JqWeFZfPMP+FyiOOq8e6Cka8z9EmIUuNkpfQSyeLEtGqvqcEw/cQ9Ou3Vn+yzxn5ZOmBbyG3/G+eeUZLgHkN0ig6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199015)(2616005)(186003)(6512007)(38100700002)(6506007)(122000001)(26005)(83380400001)(2906002)(7416002)(8676002)(110136005)(316002)(478600001)(6486002)(71200400001)(966005)(41300700001)(5660300002)(8936002)(91956017)(76116006)(66446008)(66556008)(64756008)(66946007)(66476007)(33656002)(36756003)(38070700005)(921005)(82960400001)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkNIRFYxbkxCZTVHL1E5Sjd6NVRic3FNVjdXRW5YN2oxWXd1Q2N0cnlhOUwv?=
 =?utf-8?B?OFp6TElreCttL2V6M3lydnBBRVNCSndiQ2hsekI0QUZWMGVteDFGUEtpdkRH?=
 =?utf-8?B?d0o1RmFaa3dVbk5CcXlpUG9aamFXSTZDdmdLMnA4NGhJY21RWUJEUmFCMTN1?=
 =?utf-8?B?Mm4yT3FVSEhaakZSQmxSVFZPUjNXeE00dEVhOFFOWVdzVlNFUFo5N0x4VC9Z?=
 =?utf-8?B?ZGVqUlJCcm1zUWJ4SzlQMWpubFFuUDVNdVhDdjd0MDRVOGtueVZLWmZUL09T?=
 =?utf-8?B?MTl1QjRJZWFQcDU3Ry9peFlHdFBxR2lSeENqS3ZtQ24rcUQwREtXS0dTUjVu?=
 =?utf-8?B?YzQ5SXNtNlZoYlpLdWFranZFRE9zRVhHUFplOTZ6VXArLzRzZEVuNWY3THBF?=
 =?utf-8?B?cnVWbzdzZHNvSU11eEpYaWNYREFvL1V4VFY2ckkwMEJIVG1Gb2ZvcWp1dW5w?=
 =?utf-8?B?M09zUFYyVFRERW5pSWlmc3VTaG0zU29uVG03eWxySzZ1ZEJIWVZXNHRYQ0Fs?=
 =?utf-8?B?WUMvZ0dyYlhlQWZTVElVblppdW5JSlNLVUh3MStsOHBvWkRCOVhnRnlXZW50?=
 =?utf-8?B?VHN0cFNvbXV2Q1VEc3IwdnByUC9QdGJnSnVzcXlkQWE1VkxXZU9HSUVrWm5y?=
 =?utf-8?B?TWM3WFNENmFxWXVRMVlDQjlESVh3UjBYZmNuaU1DYjJlWjFNRk5UWGJGRUU2?=
 =?utf-8?B?b0UvcVh6UzFtejRIQXVnVVc3RUg5bytsaUlGbS95WTl1anduckZ5eUNKZExj?=
 =?utf-8?B?cU84YlJXZGQ4MDRNdThXY3IvSXZRZ3hnQ0JtandPVUpkRUtOanpQeW5GVXEv?=
 =?utf-8?B?U3F3dXBWS3BhSmhWUldQM29Ec1REUGpSbnhVZTJlekg1YWU1dytIbVlRdko1?=
 =?utf-8?B?ejZRRXFwZjRwNDdSY003Zm94aWFjNjMwUTBSVkVqdmt6UnVDeHE5V2c1NWVs?=
 =?utf-8?B?T0hVSWJvZnJwVVl2YjBXVHE1MmZTajJNcDJHLzlIOGZtMXlnSWdNejZmaGx6?=
 =?utf-8?B?T1o4VHNka2tCakhPcVFFSktvTHlCQmZ3dUJveCtBZkxhKzdzUndFMkNvRFhi?=
 =?utf-8?B?U3JqN2x5Q0c3YjltWDBiSzJ4YWNlM2Z5WWJZdzRrMG91em52VWpsaVY0YjMv?=
 =?utf-8?B?dit1ck96S3dnUGtJdnlhcHJxWHVpdGRyVUlWRzR5K1dWU3JHK0ZlUkdmUmF4?=
 =?utf-8?B?cE5ob09xeEZnNVlKUGFkaW5PaVV3RzNheVZqTEY1cWY0VGhSU01PUUJ1MnZH?=
 =?utf-8?B?eVpTQm5pWjN3TjQ0TVk2SnFyblM4aXJJRUJGUXc2VERGUmVJUGhzSmhoaStx?=
 =?utf-8?B?VnVubnRYQmQ5MHU0b0lSVk1WM2kyNEVuY3BJWjZQdkQ5a0pLc25VdndVY1N3?=
 =?utf-8?B?b1B2VXdPc1F0bmtONS9PU0hScDhQTzNUd3JkdURjWDBYeDFoYlJ1U1VUdmVK?=
 =?utf-8?B?L2xHVXVmMHVNdmJ5Nm5OL0paVTcyeldlbitLUXF3c2t4enNKb3dKbnYyOHBr?=
 =?utf-8?B?WnJJOXRGTWVVb1E1YUpDNHplSjNEMnBTOFVScktvTWlkUCtlTmJIWGFlVXFa?=
 =?utf-8?B?amxsYndkSjVjY1NTamlLbXY0VlkvSEN3SmtBUlh3ZWZrOCtzTVpCS1YzYllM?=
 =?utf-8?B?YjRIUHBRMjRLb1NyQThvb3ovZ0lCc1pNczIwSEZCeHpNeFV1M2RDYjI3dzhS?=
 =?utf-8?B?Sm9zMDJTSWc2OWxPTElzL2pBaW80SjhPVXhudXd6enNTNEM5SngzVTBXY1Y1?=
 =?utf-8?B?bFBlWlRxNmVZb3hLdkFJK0g0T0VhUDJvV3JFVktIdFg4T2pJcDY3eHBWenhl?=
 =?utf-8?B?YUpvOE5JZW1OYWJjK0NNOXQ2QnQ3TDBOZmVWcklNWGxkNVRhOEZBbzE1T0lB?=
 =?utf-8?B?Z0tqK0ptQ3lXWUdNWnR4Snp1ME5jekRHdEtSWWp3M1JlZ25Camlya1RMNEVJ?=
 =?utf-8?B?S2VuRWkxQmx1THZodGFybnRoR3B3dmMyeGlmZVo3RmZXWm1TVEtCS1pOckFN?=
 =?utf-8?B?SUN4QzhDd0VpR0tBcmUvRUN1VnFCYVZ5SlV4ZFBHTWs5ZysvSm9aQy95dExy?=
 =?utf-8?B?VkJYZFFYaVdrMWxQV2V4MEw1UVJXdFdWRUVrcmZuWDlqcmtTVXRJQ2wzRFZw?=
 =?utf-8?B?b3JkRWRFbWZZSHBJWVJaWm5VM3d6STBZQlFRby9VQ3RWNWhQcER2MlhLUGtm?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5720AA577A5E04A8CF196A473BBF3B0@NAMPRD84.PROD.OUTLOOK.COM>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4beafd-1982-4d55-3aea-08dac1108ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 22:36:48.6887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66vgEjhtUea1Q6xa0D3I1eGlryO+CzxNAqrGscBNol9izmHXm5MoHb6G9HAaGjkomRWT6BZ/mPw6WLDuQYkyRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1682
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 2a9BHeMtAM5NMWJmidN3yqibN5IVNZoR
X-Proofpoint-ORIG-GUID: 2a9BHeMtAM5NMWJmidN3yqibN5IVNZoR
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211070170
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQogICAgPiA+IFRoaXMgcHJvdmlkZXMgdGhlIGJhc2UgcmVnaXN0ZXJzIGFkZHJlc3MsIHByb2dy
YW1tYWJsZSBsb2dpYyByZWdpc3RlcnMNCiAgICA+ID4gYWRkcmVzcywgYW5kIHRoZSBmdW5jdGlv
biAyIHJlZ2lzdGVycyB0byBhbGxvdyBjb250cm9sIGFjY2VzcyBvZiB0aGUgSFBFDQogICAgPiA+
IGZhbnMgb24gdGhlIEdYUCBTb0MuDQoNCiAgICA+IFdoYXQgaXMgIlRoaXMiPyBJZiAiVGhpcyBw
YXRjaCIsIHRoZW4gZHJvcCBpdC4NCiAgICA+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xp
bnV4L3Y1LjE3LjEvc291cmNlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNo
ZXMucnN0I0w5NQ0KDQogICAgPiBJZiAiVGhpcyBoYXJkd2FyZSIgdGhlbiBwbGVhc2UgaW5zdGVh
ZCBkZXNjcmliZSB0aGUgaGFyZHdhcmUsIG5vdCBpdA0KICAgIGNvbXBvbmVudHMuIFdoYXQgYXJl
IGl0cyBmZWF0dXJlcz8gSWYgaXQgY29udHJvbHMgdGhlIGZhbiwgdGhlbiB3aHkNCiAgICB0aGVy
ZSBhcmUgbm8gUFdNLXJlbGF0ZWQgY2VsbHM/IEhvdyBkbyB5b3Ugc2V0IHRoZSBzcGVlZD8NCg0K
R3JlZXRpbmdzIEtyenlzenRvZiwNCg0KICAgIFRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNrLiBU
aGUgaW50ZW50aW9uIHdhcyB0aGlzIGJpbmRpbmcuLiBob3dldmVyLCB0aGF0IHdhcyBhbiBlcnJv
ciBvbiBteSBwYXJ0LCBhbmQgSSB3aWxsIGNvcnJlY3QgaXQgdG8gcmVmbGVjdCB0aGUgaGFyZHdh
cmUgc2l0dWF0aW9uIG9mIHRoZSBHWFAgd2l0aCB0aGUgZmFuIGNvbnRyb2xsZXIgYW5kIGhvdyBl
YWNoIG9mIHRoZSBtYXBwZWQgcmVnaXN0ZXJzIHByb3ZpZGUgY29udHJvbCB0byB0aGUgc3lzdGVt
LiBUbyBhbnN3ZXIgeW91ciBxdWVzdGlvbnM6IFRoZSBmYW5zIHNwZWVkcyBhcmUgY29udHJvbGxl
ZCB0aHJvdWdoIGFuIGV4dGVybmFsIENQTEQgZGV2aWNlIHdoaWNoIHdlIHByb3ZpZGUgYSBQV00g
dmFsdWUgKDAtMjU1KSB1c2luZyB0aGUgImJhc2UiIHJlZ2lzdGVyIHRvIHRoZSBDSUYgaW50ZXJm
YWNlLiBUaGlzIGludGVyZmFjZSBwcm92aWRlcyBhY2Nlc3MgdG8gdGhlIENQTEQuIFRoZSBDUExE
IHRoZW4gZHJpdmVzIHRoZSBmYW4uIFRoZSBDUExEIGNhbiBnZW5lcmF0ZSB1cCB0byA4IHVuaXF1
ZSBkaWZmZXJlbnQgUFdNcyB0byBtdWx0aXBsZSBmYW5zLiBUaGUgQ1BMRCBtb25pdG9ycyB0aGUg
ZmFucyBhbmQgcmVwb3J0cyB0aGUgc3RhdHVzIGJhY2sgdG8gdGhlIFNvQyB0aHJvdWdoIHRoZSBD
SUYgaW50ZXJmYWNlIHRvIHRoZSAicGxyZWcgYmFzZSIuIFRoZSBwbHJlZyBpbmNsdWRlcyB0aGUg
aW5zdGFsbGF0aW9uLCBmYWlsZWQsIGFuZCBpZGVudGlmaWNhdGlvbiBzdGF0dXNlcy4gVGhlIGZ1
bmN0aW9uIDIgcmVnaXN0ZXIgYmFzZSBpcyB1c2VkIHRvIGNoZWNrIHRoZSBwb3dlciBzdGF0ZSBv
ZiB0aGUgc3lzdGVtIGFzIHRoYXQgaW5mbHVlbmNlcyB0aGUgUFdNIHZhbHVlcyByZWFkIGJhY2su
DQoNCkFzIHRoZSBQV00gZ2VuZXJhdGlvbiBoYXBwZW5zIG91dHNpZGUgdGhlIFNvQyBkbyB3ZSBz
dGlsbCBuZWVkIHB3bS1jZWxscz8gSWYgc28sIHNob3VsZCB3ZSBoYXZlIGEgY3VzdG9tIGNvbXBh
dGlibGUgZm9yIHRoYXQ/DQoNClRoYW5rcywNCg0KLU5pY2sNCg0KDQo=
