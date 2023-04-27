Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4236F07EF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244071AbjD0PIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjD0PIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:08:44 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695982726;
        Thu, 27 Apr 2023 08:08:42 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33REt7UU031183;
        Thu, 27 Apr 2023 15:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=o8AZ9L2jm5PdfYOn7TZnKyrmAxDkUtZMCazDE6MztZI=;
 b=U31xPPeC3s6lTyaPMHkO3zKxPvPpQk/NI18ybAS3cmwEbmSY2gMc4Qa2eUTMTiYpW4qQ
 Os5lZI2Dl/CjI9+va7oz8PBaQszTAOaaOdYK6/9ahqJ8PTbexntshwYNjVfctKmUsDeF
 Y7hTJ2WO0GCT3HVCneaapGlA5b3n7e1Ee5hol8foYhpkVrhVPe9DNgUCO8yCAhqQclyO
 /fvTlhoUUNNy2eLE0m1XNcBAUi9Vmdy3hFfnISi9lXWie8BlOBaj5KKLmfLW1ULntcTO
 prp4KKEQwZKTpcRWClMUOIbOlrie0teqXaMXrMTy/VgbqOgfGw9ysiUL1GDYcTSlZiv6 sw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3q7t33s3ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 15:08:18 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 1B96614792;
        Thu, 27 Apr 2023 15:08:15 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Apr 2023 03:08:05 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 27 Apr 2023 03:08:05 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Apr 2023 03:08:05 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgyzSrLIdWIZ49OsOncnCicIPqEl2Ij9uOBWmo/1N1EY/wSH5RkrMs+9UkSgTgLg+UIURkDhcdo1aVALoD9+2Bz1uKzc1BqRO/tYqB8UM51GXQe7rH7Yfn9P6UdPsEhtCxMOzLpEYPdtFKYix8EXzMjYizzUVb7ThUndf7RptlCuhK45EPhykw43z+bdACFA02IGjKnC6BAZAtfo5fX54jgMytVeo4Zec76e5WWPP7sqCUOUR1HNhYoDRneDFnsaUWcAAIyMDyq+11pcsod6WIv8eKyHcwXA7bAtNXpeSwIac0nbllCpN8jy2EbDBILeMtzPfCMTcom7dBJEmSZHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8AZ9L2jm5PdfYOn7TZnKyrmAxDkUtZMCazDE6MztZI=;
 b=NdNtMr+VNYapCmVJ0MepGTi9GX3fzWXYJBGOYOWaxxF33XSqxdwP4/PzDDX1rwK79CfyuW1pl6xdrh/WMmlsKivBCABUSsj3NZFnbzSKwVzLrwdzpCcsE6efW1dhCv7QcLD5LiuimhYdTz2sj9g45xxbCYW+723vG9HvhW0pKQRGsYT3q8V3ZS3sKxzdwQFtN5if0WVLMuCa96yhmMpLYHHeR86KsdzudHvuYZhplg8azmJxejRUXQYUb4A6HJ6O05xUzi6tTU4WbmRqQorC3coW3zu7n0Fj4+CbDBQVoYV7NxKV35BkUlPaUKhprhQb+a+C/J1++1w1AMeiRdPd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 PH0PR84MB1357.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:16f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 15:08:04 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682%7]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 15:08:04 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 7/9] ARM: dts: gxp: add psu, i2c, gpio
Thread-Topic: [PATCH v1 7/9] ARM: dts: gxp: add psu, i2c, gpio
Thread-Index: AQHZcgrrR28CTAo/eEiqZEPrZ4YKIq8xUY+AgA36W/A=
Date:   Thu, 27 Apr 2023 15:08:04 +0000
Message-ID: <DM4PR84MB19278972DE4FA16FFB9C4B77886A9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
 <20230418152824.110823-8-nick.hawkins@hpe.com>
 <7ec079fb-3ead-258b-2cf7-2d613808dd4e@linaro.org>
In-Reply-To: <7ec079fb-3ead-258b-2cf7-2d613808dd4e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|PH0PR84MB1357:EE_
x-ms-office365-filtering-correlation-id: 42e37af1-35f1-4fef-2d58-08db47313343
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8QQ/kOTbtD4+drQMw+KEmhyIvVrRCyp+87bVPaTVsl/UoCyoflyQ/imoGwHQ0BvOPAHfHcrjOXAbqnyg+Uu9auD5eu7U4A47yWgexFdH0Yt6zneP4KXFJGABLIalsc/jjXmOVoUktTgoNNKhEDIU0+CMSTeVCgn0FV9xdLnUnjedhp2C3+mY3NRqBth+9i/ba6z/T6OULdmnkphK3FJSfrh1ibdmLF00eI0jSZrV9TJBQmf2shMojwYbCOOusY/kGnGp7YCrmJZ6Kd7ZyDGJ3Q3Ez+61qXzUDl5x3DjMl6KSi90gToSt95+HuNH+XJvE+CeGX60Drbd5DpqeoQV0hpdmcRRt0BkCKyjLMvcosZ1Gdc1IgvIcDPw3CHPCXzXzqGmycUVbtLwvUYupWVL0FAdVBOXb7FEmq7pDImXnPHr5h24i80VJILzD0vWdjQeHjiVAXM+izDpXjet5+X6BOx9rpPY/2w8KHnPI7Vu4xIu3BwbglOnddZck37SrFfOCMtjViQxz0KaNRcOJdWrxACAUqsiKG0Hr2SSDzhxoNDNsR5mR6zxVTV4Mt9g1UxNg87EmlwynwhJ+DrMdpEcASlUH0Rz5Gzdfv/GoV0Qaflfu21xNZvzez4RVXxm1r0EG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199021)(26005)(55236004)(6506007)(9686003)(186003)(55016003)(110136005)(2906002)(38070700005)(478600001)(8936002)(8676002)(38100700002)(316002)(41300700001)(921005)(122000001)(82960400001)(52536014)(7416002)(66946007)(76116006)(5660300002)(66476007)(83380400001)(66556008)(64756008)(66446008)(33656002)(966005)(7696005)(71200400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3JYNmpTVVhEZERObXFodEhDRjk5U2hENmVjNG94YW9QS0hwbUpmcGFUZXVL?=
 =?utf-8?B?aXFQZVdtKzFFdDdvKy9nWG1pMkhFeGlHSkhxWG5FcVlUTkdIcDA2cUw3WFV0?=
 =?utf-8?B?RFpQazExWmQyN1kvL2cyeCtCMWowWnJETHBYclptU2sreXBXSS9TaHA5TGF6?=
 =?utf-8?B?VUJvVEFaU1B5ZnZ2T2xkTi8zV0VFTFBHVlAyVFJ1clN4SDAza2FLMVhzeVdk?=
 =?utf-8?B?SEpCbEtQMm1sc2xrYUo4VUlublJ2OEVpNmhPWU9NNXdadU5vdmhYbkxXcDY2?=
 =?utf-8?B?OVZBY2w0Y2RPa0tldkM0YmJ4VDZsVHhNZDM4ODgzSFhZOE1ua1pGd2txWDdI?=
 =?utf-8?B?bkRFZWtOTXpjUitlSTB0ZmRERWtzd25YY0RCa09RODcvMXpXOW9TRnVkZ2Vh?=
 =?utf-8?B?czNGTUVVUkVkcS9TeFIwT1lTZHQ4OFFSVHVHQmVkYzlBUkNRejhyc2FlcVVs?=
 =?utf-8?B?ck1UNlkzMGw3Ky80dlAvelRxbzBxZXkyZmc5WENick9lWjM3cHNSY0tQUEpU?=
 =?utf-8?B?ZUM4ME5OSUMvcXoyUlBRQUZXK2VXQ0tZU1hJZjczVFc4WE9MMXJVVUpMRDh6?=
 =?utf-8?B?ZXlPTTh6WmVub3ZYL3htTjl1N0U0VVhLSnFuNTUraVFrZ0g3Yi91Uld2cnAw?=
 =?utf-8?B?RTBVRGdWeUFjWmRaRDNNM1ZkbFlNdlpwMTNXMEhCOXh6Rk9SU2xKSEc1VHBh?=
 =?utf-8?B?VURQYm14T0pUQU1aRE1qSm5SOVExUnN4ZXhIejViU2RqZWh0TFpWR0ZwZHAx?=
 =?utf-8?B?RHRWZjdLL09Yd0RoSEN2aXFhVG9EaFhYRVptaUlnU2pTQ3ozbGprODhuZU5p?=
 =?utf-8?B?TG5Cc0ZhNzJKTnl6dGVZU1dnQ3o5N3VpQlpDcHJhYVdnTGVEWkhFb094U08x?=
 =?utf-8?B?R2VVYXY0RHBNa0ZpS2VXN2V6OUs0U01ranVUWHJNSjVRYkkxNWUxWGRFQk9W?=
 =?utf-8?B?L1c2VTZhSzVvaE1BeTFqTjd6a0JOUHJRYWFGWGZSRExweUxMTE8veHVVc2hM?=
 =?utf-8?B?M1dKNnRGc2dYMlJVaTlNdnRueStvSW5KNUpFYTlaTy9jSVRGWFpPZjZHbmhB?=
 =?utf-8?B?ZHNGcWI5VldwbzFlcVEwRXJpLzlpUFlJMU9YcUVHcDVLcElNQzcreHo5dDY0?=
 =?utf-8?B?bEZsZlltMVBCQlVjN0hMTG94VGpjTUxlR0FKU2txeUpjZWorMEtKRlp2UzY3?=
 =?utf-8?B?QjVBd3o0d1hQb3ZReVBqVG0rcllpRFNYbWF0ZXBaUk5XWDIzaUZjaEVrdUc0?=
 =?utf-8?B?MFFvVk5vOTRlbGZBMzJpUm5TY0dyd3RKMDNSUnlrcTdib0NvYkNGdE82WUdM?=
 =?utf-8?B?Y0syblhxM3Q2TzQ3Qk1kazJId1FVVG1JbHFvZDZsN3pSenNjb2kzeS9zTmhQ?=
 =?utf-8?B?aWcxZ09nUkE1ZjlsaFlzYzUzUTB2anowMHlwSVVyVlBxWjVmWGpoS0VwdmdL?=
 =?utf-8?B?UGxVU1lTSVQ2aHJKdm1oWkQwVzA3dm5nODRtcm5hamlDSytmeW1peW9xK2Vi?=
 =?utf-8?B?ZHRvWnN1ZWUwcVE4bjNpSVpueElNNVY0ZW04MzE2eXJtWXNqUWt6a0lPTTlz?=
 =?utf-8?B?UFh3T1VVSzcxRXpNbXp2QUdlNklFU2Q2dlV6MDRCdlhBaGFVSzI0bmxNM3ln?=
 =?utf-8?B?VkNGU1pnYWxNTDdOZUVsVTZWeU8wRFVTcElrb2oxRjkvQXhROCtIeXdXVDBC?=
 =?utf-8?B?UmpNc3FORVNlU1JHS0F3aG1Vd0FxSFhtVGdSN0JBYWVzR0NWZjU2M0lqSDhp?=
 =?utf-8?B?ZWg0OVZyTUlnZjVXSzd6ZStXNmEwVTVjclVua1Z6K1plYWcwdWhHcHhSLytX?=
 =?utf-8?B?eHpWWVdWZStvcjNHVzVCcVhmVlhPTHdSclc0dTkyK3QvbXk5MWlhWkhkVXNG?=
 =?utf-8?B?VjQxTkM2QzQ5bFR6SUhIWU9NeWZXZFN2Sm9xYlV5WnpvQWlLamQvZ3Jrc0kv?=
 =?utf-8?B?MUJZYTIvUmxpZmFqUWpIajRiQUt5TG5uaGhZTHlVUDU1aEJtSklua1o5TW1z?=
 =?utf-8?B?K1A0TjhCU1VQdVNKemlZSG43aXpQL3BzZjgvM1V4L3ppUUs2anNSNGFOckR0?=
 =?utf-8?B?SExQYy9CajBLT2JKRCtqQ1JmbHdFdENvWk5wOG1rcnR5V0hHU1Bibkc3eFdv?=
 =?utf-8?Q?041IrUzgRwyMXWgZx6X/D23Nw?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e37af1-35f1-4fef-2d58-08db47313343
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 15:08:04.1841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TmBnUdjvKGzHf44PSnFL6/LwiXE5HSHvD4flapCvAIvnnbqJMJTLb40aPc7Ukcn0AHCCU4rHNb/SJ0elPYdOyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1357
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 8sGuLbE3tIKAHd7df8PJtNF56tdTxFv9
X-Proofpoint-GUID: 8sGuLbE3tIKAHd7df8PJtNF56tdTxFv9
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304270132
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBZb3UgbmVlZCB0byBiZXR0ZXIgb3JnYW5pemUgeW91ciBjaGFuZ2VzIGFuZCBzcGxpdCBzb21l
IHJlZmFjdG9yaW5ncw0KPiBmcm9tIG5ldyBkZXZpY2VzLiBJIGRvbid0IHVuZGVyc3RhbmQgd2h5
IGVmZjAwMDAgYmVjb21lcyA0ZWZmMDAwMCAtDQo+IHdoZXRoZXIgdGhpcyBpcyBhIGJ1ZyBiZWlu
ZyBmaXhlZCwgaW5jb3JyZWN0IGRlc2lnbiBldGMuIENvbW1pdCBtc2cganVzdA0KPiBzYXlzICJ0
byBiZSBjb3JyZWN0Iiwgc28gdGhpcyBpcyB3YXMgYSBidWcuIEJ1Z2ZpeGVzIGNhbm5vdCBtaXhl
ZCB3aXRoDQo+IG5ldyBmZWF0dXJlcy9jb2RlL3JlZmFjdG9yaW5ncy4gQW55d2F5IHRoaXMgaXMg
dmVyeSB2YWd1ZS4gRXhwbGFpbiB3aGF0DQo+IGlzIG5vdCBjb3JyZWN0LCB3aHkgaXQgaGFzIHRv
IGJlIGZpeGVkLg0KDQpUaGFuayB5b3UgZm9yIGFsbCBvZiB0aGUgZmVlZGJhY2sgeW91IGhhdmUg
cHJvdmlkZWQgS3J6eXN6dG9mLA0KDQpJdCBpbmRlZWQgaXMgYSBidWcgdGhhdCB3YXMgaW50cm9k
dWNlZCBlYXJseSBvbi4gSSBhdHRlbXB0ZWQNCnByZXZpb3VzbHkgdG8gY29ycmVjdCB0aGlzIGlz
c3VlIHNlcGFyYXRlbHkgaGVyZToNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMw
MTMwMjIwMDU2LjE0MzQ5LTItbmljay5oYXdraW5zQGhwZS5jb20vDQoNCkkgc2VlIHRob3VnaCB0
aGF0IEkgaGF2ZSBtYWRlIHNvbWUgb2YgdGhlIG1pc3Rha2VzIHlvdSBtZW50aW9uZWQgYWJvdmUu
DQpJIHdpbGwgcmVzdWJtaXQuDQoNCj4gPiArCQkJZ3BpbzogZ3Bpb0AwIHsNCj4gPiArCQkJCWNv
bXBhdGlibGUgPSAiaHBlLGd4cC1ncGlvIjsNCj4gPiArCQkJCXJlZyA9IDwweDAgMHg0MDA+LCA8
MHgyMDAwNDYgMHgxPiwgPDB4MjAwMDcwIDB4MDg+LA0KPiA+ICsJCQkJPDB4NDAwMDY0IDB4ODA+
LCA8MHg1MTAwMDMwZiAweDE+Ow0KDQo+IFRoaXMgbG9va3MgcmFuZG9tbHkgaW5kZW50ZWQuLi4N
Cg0KQWx0aG91Z2ggdGhlIGRlc2lnbiBpcyBsaWtlbHkgdG8gY2hhbmdlIEkgd2lsbCB1c2UgYSBm
b3JtYXQgc2ltaWxhciB0bw0KZ3Bpby1saW5lLW5hbWVzIHlvdSBtZW50aW9uZWQgcHJldmlvdXNs
eS4NCg0KVGhhbmtzLA0KDQotTmljayBIYXdraW5zDQo=
