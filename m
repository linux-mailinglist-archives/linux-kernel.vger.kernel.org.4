Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246FF5FCBFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJLUZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJLUZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:25:35 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292C930F6F;
        Wed, 12 Oct 2022 13:25:34 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CHpoQo022723;
        Wed, 12 Oct 2022 20:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=EjLHqm7cG9JRukR9mEuRph9tB2fjEsuqgP7LPEqMCi8=;
 b=Tn7XVeYGLd3o1QVVe6Ef1GPol8kBnhYqpydlMZU/k/xFst5pC0UAo+XPvprcWvgjDjZk
 o+SnTpD8k34Nwy4Idlt1cXupisFb18MuFTKfcRr9x1xD+jmktsyMx5Uz4XGZQIJVqNsN
 xCBofIzpW6piGXh4e2Mutd76QCjjQ5JEGEAycFV2BIbLYBWir8QXASL65GUdFoXV8DJG
 IUz3DarF0Wp+tHDc02hb6Vh1Brr98mYtgbntB4A+bieKjhCuNYMHlWa9pFoEdd1i472/
 pgwBXfXLHEOOWk4OE+NDutTPQH00ia+QAqTPXQ0UhL2XmJZzdk9yiCGXpAO3vRQkXSao FA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k62bm12vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:25:24 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 108A1804705;
        Wed, 12 Oct 2022 20:25:24 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 12 Oct 2022 08:25:06 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 12 Oct 2022 08:25:06 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 12 Oct 2022 20:25:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htEgkB7khijoJjYoSfcFpSukG9GXCgu3PLV2AvWI0QngE/5UcPcdSDD4RrpiDBhw5R+JYb2mRQdq45dma5EvfCezwPq2CCPZzMnbU3vhoWzFsYCvnkNTDkA/Ar594MKEhuii/zapa9SRMRxgVPQnpFEhW9Abq2rm9A9SVvK7MZ+OL0yFTDznO4BvzxbIkNCUfm4eKMA9aIbXQdbTShCIC4TZ+cpNwHE4rWKdBlmIl0Fa8TZ/BCG2e6vHs5p+w/AFfah+9Xj5Knq8UEAsVL3AO07aGG4oIcAgUV7ATxaYM1DviyP1qM8PibIctXVyE1EHXsVPsuVdYsbFv11v52Q9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjLHqm7cG9JRukR9mEuRph9tB2fjEsuqgP7LPEqMCi8=;
 b=jPes0q0RlaTTziIEiN4xZTK9RxSCn+2M1z1sg5ueZRpfZr0NkW/gsk+DK6K+BNOF8LQMfjMb5oPxq+SOHie46gTyrPnhDxiq/byg5Yr71mmhzmPjNMXbuxhOoT8xy6YE98FiHwCYCsj2C3oid6QdJTBWMWvrB5imGWXa2ij5FNEIUpf8rMYstCcTQEzkVqkBMBDgpkA0nA4PZ0J4GNxHAGM1qxKkw5EoMqoRYhG6yrTQfHq0aLzW6AyPu2Thlo14Gd2PHuwcjNCpqbdVygQhUkFc4tyNTE2zxwwyrD2yHrrOjT/spP+MH73MH3R1QVG05Hf6pL/Ml93qEoiIykg/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW5PR84MB1499.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.22; Wed, 12 Oct 2022 20:25:00 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f4f4:4c43:9c7c:333c]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f4f4:4c43:9c7c:333c%9]) with mapi id 15.20.5709.022; Wed, 12 Oct 2022
 20:25:00 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 1/5] soc: hpe: add support for HPE GXP Programmable
 Register Driver
Thread-Topic: [PATCH v1 1/5] soc: hpe: add support for HPE GXP Programmable
 Register Driver
Thread-Index: AQHY3aMnKkEvP593bUil17wZCYqNa64Jnj6AgAGQ6WA=
Date:   Wed, 12 Oct 2022 20:25:00 +0000
Message-ID: <DM4PR84MB19276978EB630CF08833E5A488229@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
 <20221011185525.94210-2-nick.hawkins@hpe.com>
 <c6ab6116-5d92-132e-48fc-b731fd244d72@linaro.org>
In-Reply-To: <c6ab6116-5d92-132e-48fc-b731fd244d72@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|MW5PR84MB1499:EE_
x-ms-office365-filtering-correlation-id: d398b094-e3b7-4e24-0fe0-08daac8fd693
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nAGIcEDMn2NyMoUYnkj4vZg/OmW3VzRgO87rUc8oKTfmzj65hr3PNrdwNujy/GFttq4bJjE5r9P7IfPQ8Yfhek8vAvqlHebjHDBpARUOyu+1yEwBz1K0PhjAXhcxyqFnBtbuHyT95bKOWmu9udFAmDpZmMGwvCsO9nZZbNbH97ayKPDHUHVl744BTuRu36kOSIImPFz3/eHu+7zlCmhMxJ7TtqMUR+e0MVptq5QG7Eg/rWRhglE3yhOmeutPTtWaBp84iOM0/8/VRX6rxDSgHtKBUxAzWMotUe9RTbglbg2teNEmCokvbg5Et+7C9J1HhXyldzqCUdXaEeJu3UpexEim4GESZ5Nb2zZqx0qro5lfUAT3sm9vNs9CbmSxcJXt3s0seCkHMfNic+ksGBsUgq+6UKA7DFY7TGYZJWvsApQkn7VhPWaB/VkhFe8koO31RW1UkzIpQ3WBTqQEDRXs6zr40KykFJH7Tg+CiXOksW7p7Xqk8XltHHW1iHZ2L3HihnJoeRX1aluc4a+CLnumiuz+0wc32oHIRX9kUh9UHBOkL4SmiIFWcaqyo6ggHjgC5i/ttNPcD/ATZGd1iGf24X1yH9a1b7cRbzPvr3PiygxgSVG8gs0Q3ce626/8WG5lcNZFvSwhP0MudnNX3yoHRWrGgn2Jqbut4BFG0I093OysgFElrr4fDdz9hjMiSgksoqyYDQdvRqadrv7+/i5MUsVVnnLTANedBvI/z7IqXsjpBw+au5Fjjnqt01/darxsT8oK8Plc0+fAXlCL+x1KgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199015)(316002)(55016003)(82960400001)(54906003)(6916009)(8936002)(33656002)(186003)(122000001)(9686003)(26005)(52536014)(5660300002)(2906002)(8676002)(4326008)(66476007)(66446008)(64756008)(7696005)(38100700002)(76116006)(66946007)(6506007)(55236004)(66556008)(41300700001)(71200400001)(38070700005)(83380400001)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUF0bFBoUUk0U054VkpHcFJEbVA4K1k4MXJ4d2J5UjRJMjZ3eU5YeXI4L2dq?=
 =?utf-8?B?bUduM0ttMGRkVStWYklFRE1oVWRVQmpodkhsZGdCMkp1LzNqMXRBMzBURkVz?=
 =?utf-8?B?eXhkSWYvSnRwOHlYb0EwcUpLYVRhaGZkVHhRbENMRDEyQlNMdU9UVXd6M3VM?=
 =?utf-8?B?dlNRUUJRRHYyd2t3SzJ2WHUzeDM4eWo1RU5STlZBeEVrdSthc3Y1R3ovWG9v?=
 =?utf-8?B?ZHJGcldVQWNBSDR4K3J3bituUkgyYWVzQzZWUytRNXBrLy9hTWI0UWNQYVlR?=
 =?utf-8?B?R05jV090T2ZzV0g0OG9na2JmaTFsdEdTMzlDamp0c2NJazhMM3czTzVCSHFx?=
 =?utf-8?B?b1hiMFhSM0xkNnNrMjFHeGFaWWlBUDh2TlJiazdEUHE0MUQyUnl0U3JoVHFM?=
 =?utf-8?B?R2htc2gwWlNuZ29QY3EyK29FQXI5Yi9PdzZTbjROVCt5Nnd5Y2YyaC9rRk9X?=
 =?utf-8?B?bThSeHdRVTVGOTNId1FRUkNtR1dsSGV1cVRrNmgwL25DQTBCc0dpY0JMQUM0?=
 =?utf-8?B?QXRCUXZjSkIvNFNyNHRzeldDWTVWYnUwVEc5SVAwQzF2NExGM0tPVWlaSlgy?=
 =?utf-8?B?UlVFT2tnTWU4RmU1bGZnRzNzdUpMM0JDakZyVEcyckZLVHNyN0J4QVNFTC9j?=
 =?utf-8?B?MnA5MUNzYkNNcmpQRGkwWURldVJMc2h5RDRsU1BsV0FLUTdUMzBHcnBYT0Ix?=
 =?utf-8?B?eGQ0VC90aWZTZWxscjJ6Vmt4bWZ1ZmRpNm9EOHo1SEU2b2tyU3NDTWR3UjNO?=
 =?utf-8?B?bG9aQ2NvRGVyQTF4NDQ3cXFYZ204azRSRVlFMks0Vms0bUczeFJmVThrWlp0?=
 =?utf-8?B?ckJ4NlpTT3RkS05pYnpNclNzYUUyd3VSR2ZmZmkrR1MwV21IOE0vUnlic1oz?=
 =?utf-8?B?RWVWUXBYbmlKWFFpWFRLYVd3WldjSmR2WDZkcDhFd3Z3bkhFaUsyaVVweGRJ?=
 =?utf-8?B?dWZNMjlTbm5mRzBSUkxZUWwwNktYL2M1RTUvUTE4MHJzdUI2blhmbDN1a1dN?=
 =?utf-8?B?YjRsSzh3K29Tbnhvc2pUUGVoWDY2VHcwRy8rZWdPWlp3RGwyOEtWWFJWWE9N?=
 =?utf-8?B?ZDBGdnI0b2FYK1Q2cWlCbVRLdG9STDdxSzNwUnNUMVdOZThIallDNkRBZGl5?=
 =?utf-8?B?SkhISjNyMVFYeHhoWGt0djY1Y3ljT2ozbVZlNEJ2aUNPZTVtY0Nic3NGVGM0?=
 =?utf-8?B?YldEak93dS96dkxVbGx0YXlMSnFOOG91ejc3c2JQZzZHRkxGOTZOUnpnMkN5?=
 =?utf-8?B?cXFrMDl1UTVjR25JVExCZ2E3cWNzeGYvbXZOamE3Q0FYMUUxTm4xWTBOM1RT?=
 =?utf-8?B?OUZCd2VDWVh5dG1QdmxRQ1JFZXJ1OURrSXZsazlsR1FpcVJpd0tNVzVqd095?=
 =?utf-8?B?ZUpRTkZGL1VFQ3lxOWZjZjh0QzNPZjJEdlRxTVd1S1U3ZU9RdGFPZTZvMDdL?=
 =?utf-8?B?RWUzb0NBREtJTEszOVRscTFpS3BjcXVQNFZKbjArcXA2bDI0WWgxVWE5S0xr?=
 =?utf-8?B?QXFjRStCUGhERURZOHAxUExnaXNHQkdnc0Rjc2JrMS9mL0xFRVdwcWRLQUFZ?=
 =?utf-8?B?aGtRNnloYmZidTQ5Z1RpYlYzZURuWG5CZlp2UWRNaC9vd1pSNmhsb0hoY2JR?=
 =?utf-8?B?SGZvbVdRZXpoc1lZUDlVcHp1YW14WVVqcjVhazEyWGhrUzVTRmoydEh3L0pB?=
 =?utf-8?B?Y1poN2xWTUNqYmh4MzRKWnVjaUtVcjRDYVVRT2EwL3VpNnlDRWphVjhjYVor?=
 =?utf-8?B?SFR6WVE3Q0cyNlgyWDI2eVE4VXpKUzB4Y1Uwc08vWW5obVhhSDB4V1hrYlpr?=
 =?utf-8?B?TlFvWmQ0VUUzS2c0dHpza0xNb3gxZ0VDTysvMGRKTDJiemdZQnYyRUNRaGJw?=
 =?utf-8?B?cGlrQnZXaU1xazJWN3JnUi96TDJ1a1p1NDJGdEFRS1IxYzd0TGF4NGc0QlRP?=
 =?utf-8?B?Qzk0ZVkrZXoyS0t6aEZrWU1kc2cyZk05YmFmRXhBbWdodGxlcWd3ZForSCtC?=
 =?utf-8?B?eldRaFlrZEo4aElvUElpM1NwUzIwaWVDWHE1SVhrY1ZzU290SVVqRDQvRWhJ?=
 =?utf-8?B?T0wyaDN4Q2VRS0FLN0lsSGtOOTYyNm0wbVNranRNZWY0a3FBbTNTZ0R6QVFn?=
 =?utf-8?Q?JIbat9DwNjs6FOKHRAUwzbJ3a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d398b094-e3b7-4e24-0fe0-08daac8fd693
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 20:25:00.6453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Euk0+G/5TBoeonc/wPVCvpkTWq0pKzgmgENuXy/tYbOZR1ybnlkzDmKxnUwk88teSfayah5sSF6dKrTHg9T7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1499
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: xgVKOoj-X1DhE3xwahR2ZN9XXek3lpmC
X-Proofpoint-ORIG-GUID: xgVKOoj-X1DhE3xwahR2ZN9XXek3lpmC
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_09,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=988
 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210120130
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R3JlZXRpbmdzIEtyeXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjayEgSSBoYXZlIHNl
dmVyYWwgcXVlc3Rpb25zIGJlbG93Og0KDQo+ID4gKw0KPiA+ICtzdGF0aWMgc3NpemVfdCBzZXJ2
ZXJfaWRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCANCj4gPiArZGV2aWNlX2F0dHJp
YnV0ZSAqYXR0ciwgY2hhciAqYnVmKSB7DQo+ID4gKwlzdHJ1Y3QgZ3hwX3BscmVnX2RydmRhdGEg
KmRydmRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiArCWludCB2YWx1ZV91cHBlcjsN
Cj4gPiArCWludCB2YWx1ZV9sb3dlcjsNCj4gPiArCXNzaXplX3QgcmV0Ow0KPiA+ICsJdTMyIHRy
YW5zX29mZnNldDsNCj4gPiArCXUzMiB0cmFuc19zaGlmdDsNCj4gPiArDQo+ID4gKwkvKiByZWFk
IHVwcGVyIGZpcnN0ICovDQo+ID4gKwlhZGRyZXNzX3RyYW5zbGF0aW9uKGRydmRhdGEtPnNlcnZl
cl9pZC51cHBlcltCWVRFXSwNCj4gPiArCQkJICAgICZ0cmFuc19vZmZzZXQsDQo+ID4gKwkJCSAg
ICAmdHJhbnNfc2hpZnQpOw0KPiA+ICsJcmVnbWFwX3JlYWQoZHJ2ZGF0YS0+cGxyZWdfbWFwLCB0
cmFuc19vZmZzZXQsICZ2YWx1ZV91cHBlcik7DQo+ID4gKwl2YWx1ZV91cHBlciA9IHZhbHVlX3Vw
cGVyID4+IHRyYW5zX3NoaWZ0Ow0KPiA+ICsJdmFsdWVfdXBwZXIgPSB2YWx1ZV91cHBlciAmIGRy
dmRhdGEtPnNlcnZlcl9pZC51cHBlcltNQVNLXTsNCj4gPiArDQo+ID4gKwkvKiByZWFkIGxvd2Vy
IGxhc3QgKi8NCj4gPiArCWFkZHJlc3NfdHJhbnNsYXRpb24oZHJ2ZGF0YS0+c2VydmVyX2lkLmxv
d2VyW0JZVEVdLA0KPiA+ICsJCQkgICAgJnRyYW5zX29mZnNldCwNCj4gPiArCQkJICAgICZ0cmFu
c19zaGlmdCk7DQo+ID4gKwlyZWdtYXBfcmVhZChkcnZkYXRhLT5wbHJlZ19tYXAsIHRyYW5zX29m
ZnNldCwgJnZhbHVlX2xvd2VyKTsNCj4gPiArCXZhbHVlX2xvd2VyID0gdmFsdWVfbG93ZXIgPj4g
dHJhbnNfc2hpZnQ7DQo+ID4gKwl2YWx1ZV9sb3dlciA9IHZhbHVlX2xvd2VyICYgZHJ2ZGF0YS0+
c2VydmVyX2lkLmxvd2VyW01BU0tdOw0KPiA+ICsNCj4gPiArCXJldCA9IHNwcmludGYoYnVmLCAi
MHglMDR4IiwgdmFsdWVfdXBwZXIgfCB2YWx1ZV9sb3dlcik7DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIERFVklDRV9BVFRSX1JPKHNlcnZlcl9p
ZCk7DQoNCj4gTWlzc2luZyBzeXNmcyBkb2N1bWVudGF0aW9uLg0KDQpDYW4geW91IHBvaW50IG1l
IGF0IHRoZSBwcm9wZXIgbG9jYXRpb24gLyBkb2N1bWVudGF0aW9uIGZvciBkb2N1bWVudGluZyBz
eXNmcz8gVGhhbmtzIQ0KDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDw9IE1BU0s7IGkrKykgew0KPiA+
ICsJCWlmIChvZl9wcm9wZXJ0eV9yZWFkX3UzMl9pbmRleChucCwgImdycDUiLCBpLA0KPiA+ICsJ
CQkJCSAgICAgICAmZHJ2ZGF0YS0+Z3JwX2ludHJfZmxhZ3MuZ3JwNVtpXSkpIHsNCj4gPiArCQkJ
ZGV2X2VycigmcGRldi0+ZGV2LA0KPiA+ICsJCQkJImdycDVpbnRzZmxhZ3MgaXMgbWlzc2luZyBp
dHMgJ2dycDUnIHByb3BlcnR5IGluZGV4ICVkXG4iLCBpKTsNCj4gPiArCQkJcmV0dXJuIC1FTk9E
RVY7DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCW5wID0gb2ZfZ2V0X2NoaWxkX2J5
X25hbWUocGRldi0+ZGV2Lm9mX25vZGUsICJwd3JidG4iKTsNCj4gPiArCWlmICghbnApIHsNCj4g
PiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICIlcE9GIGlzIG1pc3NpbmcgaXRzICdwd3JidG4nIG5v
ZGVcbiIsIG5wKTsNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiArCX0NCj4gPiArDQo+ID4g
Kwlmb3IgKGkgPSAwOyBpIDw9IFZBTFVFOyBpKyspIHsNCj4gPiArCQlpZiAob2ZfcHJvcGVydHlf
cmVhZF91MzJfaW5kZXgobnAsICJsYXRjaCIsIGksIA0KPiA+ICsmZHJ2ZGF0YS0+cHdyYnRuLmxh
dGNoW2ldKSkgew0KDQo+IFVuZG9jdW1lbnRlZCBwcm9wZXJ0aWVzLiBOQUsuDQoNCklmIGVhY2gg
Y2hpbGQgbm9kZSBvZiBocGUsZ3hwLXBscmVnIHdlcmUgZG9jdW1lbnRlZCB3aXRoIHRoZWlyIHJl
c3BlY3RpdmUgcHJvcGVydGllcyB3b3VsZCB0aGlzIGJlIGFjY2VwdGFibGU/DQoNClN1Y2ggYXM6
DQpGYW4tMSB7DQoJQ29tcGF0aWJsZT0iaHBlLGd4cC1wbHJlZy1mYW4iOw0KCWlkID0gPDB4Mjc+
Ow0KCWJpdCA9IDwweDAxPjsNCglmYWlsID0gPDB4MjQ+Ow0KCWluc3QgPSA8MHgyMj47DQp9Ow0K
CQ0KDQo+ID4gKwkJCWRldl9lcnIoJnBkZXYtPmRldiwgInB3cmJ0biBpcyBtaXNzaW5nIGl0cyAn
bGF0Y2gnIHByb3BlcnR5IGluZGV4ICVkXG4iLCBpKTsNCj4gPiArCQkJcmV0dXJuIC1FTk9ERVY7
DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWRydmRhdGEtPmdwaW9fY2hpcCA9IHBs
cmVnX2NoaXA7DQo+ID4gKwlkcnZkYXRhLT5ncGlvX2NoaXAubmdwaW8gPSAxMDA7DQo+ID4gKwlk
cnZkYXRhLT5ncGlvX2NoaXAucGFyZW50ID0gJnBkZXYtPmRldjsNCj4gPiArDQo+ID4gKwlnaXJx
ID0gJmRydmRhdGEtPmdwaW9fY2hpcC5pcnE7DQo+ID4gKwlnaXJxLT5jaGlwID0gJmd4cF9ncGlv
X2lycWNoaXA7DQo+ID4gKwkvKiBUaGlzIHdpbGwgbGV0IHVzIGhhbmRsZSB0aGUgcGFyZW50IElS
USBpbiB0aGUgZHJpdmVyICovDQo+ID4gKwlnaXJxLT5wYXJlbnRfaGFuZGxlciA9IE5VTEw7DQo+
ID4gKwlnaXJxLT5udW1fcGFyZW50cyA9IDA7DQo+ID4gKwlnaXJxLT5wYXJlbnRzID0gTlVMTDsN
Cj4gPiArCWdpcnEtPmRlZmF1bHRfdHlwZSA9IElSUV9UWVBFX05PTkU7DQo+ID4gKwlnaXJxLT5o
YW5kbGVyID0gaGFuZGxlX2VkZ2VfaXJxOw0KPiA+ICsJLyogU2V0IHVwIGludGVycnVwdCBmcm9t
IFBMUkVHIEdyb3VwIDUgTWFzayAqLw0KDQo+IFBsZWFzZSByZWFkIExpbnV4IGNvZGluZyBzdHls
ZS4gVGhlcmUgaXMgYSBjaGFwdGVyIGFib3V0IHNpemUgb2YgZnVuY3Rpb25zLiBSZWFkIGl0LiBB
Y3R1YWxseSwgcmVhZCB0aGUgcmVzdCBhcyB3ZWxsLi4uIEl0J3Mgb2sgaWYNCnByb2JlKCkgZ3Jv
d3MgYWJvdmUgb3VyIGxpbWl0LCBidXQgdGhpcyBpcyBodWdlLiBSZWFsbHkgdG9vIGJpZy4NCg0K
SSB3aWxsIGRvIHRoaXMgYW5kIHdvcmsgb24gYnJlYWtpbmcgdXAgdGhpcyBjb2RlIGludG8gc21h
bGxlciBmdW5jdGlvbnMuDQoNClRoYW5rcywNCg0KLU5pY2sgSGF3a2lucw0K
