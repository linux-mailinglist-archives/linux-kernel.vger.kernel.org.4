Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DACD6078F4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiJUN4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJUN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:56:30 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ED72690B1;
        Fri, 21 Oct 2022 06:56:28 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LC2aV5009694;
        Fri, 21 Oct 2022 09:56:05 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3kb20ph4cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 09:56:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRkG8AJkh75dS4Gm8J7dRvMztQuKcnfBBW9G1W1YVscvpACoBDfc+1ei/jrJeZuGmtbG9mxKi2h6UqPFv+p5azM6Zfu9uQoP5EO0eCYL+jrH92t0hkcNnhwQMV6EeMWx9SWqkoQy8SqB9L0tWXDt/oNqSyIGeDB98/E+mleQQVsQNQt1AaEf6+1/3eEfRvA/+pDfDOjymg5hYAzrQp4gWD3xe2lmporGrm9m5xwW2Rnm09i156PRjjVMDnSKnz4gVJ56XR3flCQl1vgrC4gW/aM1/50lTlkVjszGxvWTgQUyCkk9kTGRrHaZbB5qF+N6m6RF8oYX6NjHPU7EPFNVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLQhGgSyHtYRGC2IPtlntJLssKTHB1UTAelBuDvEg24=;
 b=X+1m1lzH14IeAAiXazK5v9c0eMMtylW6LU1SOgamO2BCp5fwShJwMLiYSUyfAZnwIO3SxtADVfQcIG9Psj2Q3y0NZGIKEBGfqlhVX/XsT8+Dag5T53e20HxtyHbSy6UMRld1ZOwN822rSK7VtEdSWlSmy+zbgMQcL7F7TX5Hmkv7c6CzbQ2vK63/yLXflOqvCcUD6YOz6nPkW22OIeNJFgEp1S6Vj8vjlyJjC7etqil+WcPoHEansYF8VQnIWNyM0ZHXEzBkhzzOHi0LmSFvMTCJ76hXxNcmtml9ifNqj7DAg0ty/IqpwRrgQYAzwRGENDxrYdqG/SBuN2h/YzNI0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLQhGgSyHtYRGC2IPtlntJLssKTHB1UTAelBuDvEg24=;
 b=CjCO7yydorbxCHi3kFObEl6BnO8NWKdp9R6gY4ygq1z1tR70O8uX2fGPRM2c8kt0J3qVO1d63aWEmVXN6ETSxVXSWJ/2971CjCnngUUNbKby7eKeUltSe6oWKkQ39f9OAIkO7duVt4ggd1g/oxbtCdzTMduy1BIwsZLJzNlMvrw=
Received: from DM8PR03MB6247.namprd03.prod.outlook.com (2603:10b6:8:3b::6) by
 PH0PR03MB5767.namprd03.prod.outlook.com (2603:10b6:510:42::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.35; Fri, 21 Oct 2022 13:56:02 +0000
Received: from DM8PR03MB6247.namprd03.prod.outlook.com
 ([fe80::17cf:8070:5f0f:8b37]) by DM8PR03MB6247.namprd03.prod.outlook.com
 ([fe80::17cf:8070:5f0f:8b37%7]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 13:56:02 +0000
From:   "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: RE: [PATCH 2/2] dt-bindings: rtc: add bindings for max313xx RTCs
Thread-Topic: [PATCH 2/2] dt-bindings: rtc: add bindings for max313xx RTCs
Thread-Index: AQHY48BZbMpT/SjNa0SzYqltq8qQ864XyjkAgADySLCAAA2cAIAACL6ggAALAwCAAALLwA==
Date:   Fri, 21 Oct 2022 13:56:02 +0000
Message-ID: <DM8PR03MB6247E7E2C830482CE3F7D8BA962D9@DM8PR03MB6247.namprd03.prod.outlook.com>
References: <20221019133910.282-1-Ibrahim.Tilki@analog.com>
 <20221019133910.282-2-Ibrahim.Tilki@analog.com> <Y1G6FIvS6WD57GXW@mail.local>
 <DM8PR03MB62477670C186E6CC5308B600962D9@DM8PR03MB6247.namprd03.prod.outlook.com>
 <Y1KQvPAwh7NC0wbA@mail.local>
 <DM8PR03MB6247691C7AD890FA486A5955962D9@DM8PR03MB6247.namprd03.prod.outlook.com>
 <c573ae8d-f2ee-403f-e096-eec4b31c682f@linaro.org>
In-Reply-To: <c573ae8d-f2ee-403f-e096-eec4b31c682f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYVdKeVlXaHBiUzUwYVd4cmFWeGhjSEJrWVhSaFhISnZZVzFwYm1kY01E?=
 =?utf-8?B?bGtPRFE1WWpZdE16SmtNeTAwWVRRd0xUZzFaV1V0Tm1JNE5HSmhNamxsTXpW?=
 =?utf-8?B?aVhHMXpaM05jYlhObkxURTJObVprTlRBMkxUVXhORGd0TVRGbFpDMDRaVFl6?=
 =?utf-8?B?TFRkallqSTNaRGN5TXpGaFlseGhiV1V0ZEdWemRGd3hOalptWkRVd055MDFN?=
 =?utf-8?B?VFE0TFRFeFpXUXRPR1UyTXkwM1kySXlOMlEzTWpNeFlXSmliMlI1TG5SNGRD?=
 =?utf-8?B?SWdjM285SWpNeE9UQWlJSFE5SWpFek16RXdPRE0wTVRVNE56WXlNelU0T1NJ?=
 =?utf-8?B?Z2FEMGlaR3BUVjNobFUwWkxaRXRYVHpjNVQzRkVSbFpUTVZJMWVrZEZQU0ln?=
 =?utf-8?B?YVdROUlpSWdZbXc5SWpBaUlHSnZQU0l4SWlCamFUMGlZMEZCUVVGRlVraFZN?=
 =?utf-8?B?VkpUVWxWR1RrTm5WVUZCUlc5RFFVRkRiSFoyYWxsV1QxaFpRVmczTTFGaVUy?=
 =?utf-8?B?Rm9TRXhPWm5aa1FuUktjVVZqY3pCRVFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVoQlFVRkJSR0ZCVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVVZCUVZGQlFrRkJRVUZZTld3eVMzZEJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGS05FRkJRVUpvUVVkUlFXRlJRbVpCU0UxQldsRkNha0ZJVlVGalow?=
 =?utf-8?B?SnNRVVk0UVdOQlFubEJSemhCWVdkQ2JFRkhUVUZrUVVKNlFVWTRRVnBuUW1o?=
 =?utf-8?B?QlIzZEJZM2RDYkVGR09FRmFaMEoyUVVoTlFXRlJRakJCUjJ0QlpHZENiRUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZuUVVGQlFVRkJibWRCUVVGSFJVRmFRVUp3UVVZNFFXTjNRbXhC?=
 =?utf-8?B?UjAxQlpGRkNlVUZIVlVGWWQwSjNRVWhKUVdKM1FuRkJSMVZCV1hkQ01FRklU?=
 =?utf-8?B?VUZZZDBJd1FVZHJRVnBSUW5sQlJFVkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVZGQlFVRkJRVUZCUVVGRFFVRkJRVUZCUTJWQlFVRkJXVkZDYTBGSGEw?=
 =?utf-8?B?RllkMEo2UVVkVlFWbDNRakZCU0VsQldsRkNaa0ZJUVVGalowSjJRVWR2UVZw?=
 =?utf-8?B?UlFtcEJTRkZCWTNkQ1prRklVVUZoVVVKc1FVaEpRVTFuUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVSkJRVUZCUVVGQlFVRkJTVUZCUVVGQlFVRTlQU0l2?=
 =?utf-8?Q?PjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR03MB6247:EE_|PH0PR03MB5767:EE_
x-ms-office365-filtering-correlation-id: bcb9cbd1-e15d-4f03-d635-08dab36bfd9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 79p8A+KJw+OhUAyzAR0+QYPq0gm38a0Xhii672g3qufsfVNAAIUGh8s37xOKPLMJ76Y46hIO1j7BdK9JaF/Aj5eNSjt22bR0AAbb591sLCE/5mSgpbPwtg/l98j2fQcD2rLpOvE2Xp+tjb6m1ZR1LBuwjHLH4Qv+QmLVmgMipK7N6VlkwG2Fj5M2HAmC++gH7Z8s6KgjmFt6lZDKpzrhNy2C6oKwAh33I13R65VYtWsTVa2XDJbkD9tR8rH9rZ+C3CsYHeIPhiLFsUKZaCscn8mungf17lxy8VPxhLgHbUtFvrZNhrBgTGmkd24gzvIbf4Ji+Ddy6FZkeh5GYk9VcjxPrPIk3wHpoxHTmPOLn+gRZ2fqHfPeL7qYXs2FuW5N3KcyzbzO/vICWpZL7ThdtoSzj1hs5+1ik5GVMutXubFJAIc9CNOeW0SNNOO5BDEpdeQdjLdPGZ3DBgRCiDdKDVmrFnqov83PC5KdE31s2QrZ/zWg9pt+PrbbwhDa/+M91SlzPldM6nlyUZ2x8HgbbDBBklAOERpNLoVq7X/CQy8t0NPDn16rVao/HusnNQLCszvXZtC5V6zzA0RIFIYMyzbUHTr/Co+C4HeIYVcthW3b1v2PlPOXPnI2ZQEhsAJZL+xCPcP1YY2hz2hFPVcWs7129+hNUtqz8U8E88wbWqWVGSLYjfFQUBJyod1W8wyiX7G48vLaI08R9mcasoYM777pcAxfXLM9XJ9NUUdMWJOvcjVQu47fDcxhWy1smDo14ydNaqDIyTisJBcz/xsj5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6247.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199015)(38070700005)(4326008)(110136005)(122000001)(107886003)(66446008)(66476007)(8676002)(53546011)(76116006)(66556008)(66946007)(316002)(64756008)(54906003)(7696005)(6506007)(86362001)(55016003)(83380400001)(5660300002)(52536014)(186003)(8936002)(26005)(9686003)(41300700001)(2906002)(33656002)(478600001)(7416002)(38100700002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlRxMFFsekFzYjU5SjV5blF3bXRlMnh3b1psU0VXMWQxY2Rsb0ZJdGlKRkRx?=
 =?utf-8?B?MTY2TzNhaTR3aFdZdnY0MXJZaUwvS2FZNHp4Q2hqaVNqS2xsVGVrS0ZvS2hC?=
 =?utf-8?B?K3lSNE1rdVNNR2FCUXNKUGJJd2pZbjhEQWI5VS9hQVBRbGZKaWpPQk5TNjZ3?=
 =?utf-8?B?VEFrSy8xVkZmSHdER3RhUlQwNE9oM2xodlJQZU9zQXhObk9OQWhmS1JldXBP?=
 =?utf-8?B?UURjUWpFNTFHT3REaXFrQ1pmNnVKWlZFMk5Ub1VJcEpkczdwdTZxM1lhbEp3?=
 =?utf-8?B?UVpETmRMNkFEWDVPT0VwMWMvRlUyQ21GVmxPRDNabEN0UnUxd1NCQUxvKzVE?=
 =?utf-8?B?YVlmdVdpcE5kdWZrNUZCUjROREJFU0h1czlGaWh0OXlKSGVXV3UvaFA3QVRl?=
 =?utf-8?B?czJ2dUM5Q1ViemdNRVgyVFVoME5pVnhieXdQNGU0eGdnc3J0RDhVMWdhd0NH?=
 =?utf-8?B?aTVaQ1N1Q0FMY1NhRmFtS2Y4Ly9FeFR6M2ZJTkZaNEpIY1d0WGt2cFJ2bUtX?=
 =?utf-8?B?dUFPclBpMm9YRFR4eG1OeCtBL0NIckowTTk1UzVaWTVjVGU0d3YyL0tIUHpO?=
 =?utf-8?B?NSs3TVFtWG9BeUpITGNINVZoVUR3RnBQLzhjbnBFc0I1TExvR0FtT2pHRDFI?=
 =?utf-8?B?azdIVExyNjNjMlVVQ2pYRTdQSlAzVzBvL3NHL1dzZGEzaEtlWmNRZU1QZ0Ex?=
 =?utf-8?B?YmNYR3J5dlRudmpJWFJNNTFkVFhTa2pQalVFOTJoWENHTWpPV1JFWkVxRksx?=
 =?utf-8?B?STBLbzl5bDZlODFWSHRSSU1Dc2ZpeGNGc25SQ3ZxN252bGI1RnJtWGJCTUhB?=
 =?utf-8?B?dUh6ZlFjUFpRelkyeEVYNTNENjQ0RnJ3Wm1nbk1lblplaEhsbGROOEIrWEJV?=
 =?utf-8?B?NmRBWFFmUGh1UGMyT3Q5L05mKzZnZXRJNWRxRCs1REsraDM3MFF1cVRnV2Q0?=
 =?utf-8?B?bGJtWnFmQ000ZzFBVDkvUDBvdGljak1kZ2YvakcwYzA5Ull5K1VpWTdQL282?=
 =?utf-8?B?VFlzUUNvRzA2cjJPbENaZmVDcGVzcmlRNERrUXdja1p4OE9xb1VEUmNFZm9J?=
 =?utf-8?B?UlBNOC9EZytWR0VDZlFjaUJPYUdVcWZVczBvL3hycEt4eWFmbVFMZFlBcXRX?=
 =?utf-8?B?eHlXb3lOSGUvMzhhcVBycm9oL0V1a254MXdYRm9lQWFIajhIVEtaWUhGMnBs?=
 =?utf-8?B?c2h6aGZacllHU2h2djE4SThMWitDdTQxOFFaY25vYmpRTFF3UnVzVjJMTGlP?=
 =?utf-8?B?ZzdjWGxtSFdnZXVVOGVrK29LbmErYnBmU1FiaVp3UzlpWVR4dmtvSjhuTW9q?=
 =?utf-8?B?UTl0eU5FWGF1WWtzNlZPeWNyaTBMd1RmUHJSd0ZXeUdMR01PZEVFTk1CWkZY?=
 =?utf-8?B?TzBRYWVxa0NySUkzekF6T0xOakppQ0d3WXZlOFRNR2FqN2RXRWpxaE53aENB?=
 =?utf-8?B?TXVGWVo3UFFhVTJNakxpTGl1aUlVVENtdjR4WFFXdFA5TmZCT0NsbG9lU29C?=
 =?utf-8?B?NnhPVEgzRkdidkd0aWlUdnFWck1SRnZZOGRNN2REN3BDK0FWdGxqZmd3TlVD?=
 =?utf-8?B?ekJPbDJoWVJ3TnkrU0ZKZFpMQXl0NnFZeFVxVjR5K0dEMnNzNDFkSURmM0pK?=
 =?utf-8?B?RHpVU2V2WHgxK29vV3ZYNDg5WTFFc0E1UmNqUWxta0k3TXZKNzhhdG9wL3lU?=
 =?utf-8?B?RTc1cGZCaUdKSjZaUk9YZVVGMisyTTUzeHBxZElKZzJ6d2RBMW9QbnlheEdj?=
 =?utf-8?B?K1d0OTc2U2hTYTBqQUcwWkZwck1ER0Y4ZjI1RFBsN2JrS1VJbVhYblhrTksv?=
 =?utf-8?B?VHBPY2dSL05Qdm10REdoQVVMSTBsS1pIQVV2NjI2dWRLcDBjYURYamZacldp?=
 =?utf-8?B?ZnlKcHRENlhRSmZpdEFYTzA2NXFyalZzb245RHhWa2ducDYvcm1UTjlTbjFU?=
 =?utf-8?B?RVBEZE5SRm84bEl5YXlxR0t2RE5xalI0V1hEcTB1NkR2Yk80cjk0RERxRTlG?=
 =?utf-8?B?UHJoenhPQkhORUdTNHZtcjJOdFVUV0k3Nmc0R3dUWmxOZHFHZjMzODEwZk9t?=
 =?utf-8?B?QzBpVnBvOEQ4UFIvNjlpUzBjSnI1ZkU0NThWdEg3YmdtVERYTEVPalp2MkNJ?=
 =?utf-8?Q?Ik3WQVesPudo4jXuZKp4aaXoD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6247.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb9cbd1-e15d-4f03-d635-08dab36bfd9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 13:56:02.3858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1PEaKC2sPnuOkVprxCSYPIVf1JT8tU5N3FdelhqbY+emWXlBLniWyghfZG8cIurSg7c6rpASmcx7LRD41K5IP5mGXoAhDO0bR5+3V+Udr1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5767
X-Proofpoint-GUID: _DKX4LExOr7bPw8tSn1uOa3Pj56hSkBa
X-Proofpoint-ORIG-GUID: _DKX4LExOr7bPw8tSn1uOa3Pj56hSkBa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=871 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210083
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAyMS8xMC8yMDIyIDA5OjA1LCBUaWxraSwgSWJyYWhpbSB3cm90ZToNCj4gPj4gT24gMjEv
MTAvMjAyMiAxMTo0NDoxMiswMDAwLCBUaWxraSwgSWJyYWhpbSB3cm90ZToNCj4gPj4+Pj4gKyAg
aW50ZXJydXB0LW5hbWVzOg0KPiA+Pj4+PiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4+Pj4+ICsg
ICAgICBOYW1lIG9mIHRoZSBpbnRlcnJ1cHQgcGluIG9mIHRoZSBSVEMgdXNlZCBmb3IgSVJRLiBO
b3QgcmVxdWlyZWQgZm9yDQo+ID4+Pj4+ICsgICAgICBSVENzIHRoYXQgb25seSBoYXZlIHNpbmds
ZSBpbnRlcnJ1cHQgcGluIGF2YWlsYWJsZS4gU29tZSBvZiB0aGUgUlRDcw0KPiA+Pj4+PiArICAg
ICAgc2hhcmUgaW50ZXJydXB0IHBpbnMgd2l0aCBjbG9jayBpbnB1dC9vdXRwdXQgcGlucy4NCj4g
Pj4+Pj4gKyAgICBtaW5JdGVtczogMQ0KPiA+Pj4+PiArICAgIGl0ZW1zOg0KPiA+Pj4+PiArICAg
ICAgLSBlbnVtOiBbSU5UQSwgSU5UQl0NCj4gPj4+Pj4gKyAgICAgIC0gZW51bTogW0lOVEEsIElO
VEJdDQo+ID4+Pj4+ICsNCj4gPj4+Pg0KPiA+Pj4+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyByaWdo
dCwgd2hhdCB0aGlzIGlzIGRvaW5nIGlzIGVzc2VudGlhbGx5IA0KPiA+Pj4+IHBpbm11eGluZyBp
bnRlcnJ1cHRzIHZlcnN1cyBjbG9ja3MuIFdoYXQgaGFwcGVucyBpZiB5b3Ugd2FudCBJTlRCIA0K
PiA+Pj4+IGJ1dCB0aGlzIGdvZXMgZGlyZWN0bHkgdG8gYSBQTUlDIGluc3RlYWQgb2YgdGhlIFNv
Qz8NCj4gPj4+PiBJdCBpcyBub3Qgc29tZXRoaW5nIHlvdSBjYW4gZXhwcmVzcyB3aXRoIHlvdXIg
Y3VycmVudCBiaW5kaW5ncy4NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IFdoeSB3b3VsZCBhIHVzZXIg
d2FudCBJTlRCIHdoZW4gaXQgaXMgbm90IGNvbm5lY3RlZCB0byBTb0M/DQo+ID4+PiBVc2VyIGNh
biBzcGVjaWZ5IG5vbmUsIGVpdGhlciBvbmUgb3IgYm90aCBvZiB0aGUgaW50ZXJydXB0IHBpbnMu
DQo+ID4+PiBJIGRvbid0IHNlZSB3aGF0IHRoZSBwcm9ibGVtIGhlcmUgaXMuDQo+ID4+Pg0KPiA+
Pg0KPiA+PiB0aGUgaW50ZXJydXB0IHBpbiBtYXkgYmUgY29ubmVjdGVkIHRvIGEgUE1JQyB0aGF0
IGlzIGFibGUgdG8gc3RhcnQgb3IgDQo+ID4+IHdha2UgdXAgdGhlIHBsYXRmb3JtLiBJbiB0aGF0
IGNhc2UsIHRoZSB1c2VyIHdvdWxkIG5vdCBoYXZlIGFueSANCj4gPj4gaW50ZXJydXB0LW5hbWVz
IGFuZCB5b3VyIGRyaXZlciB3aWxsIGZhaWwgdG8gbXV4IHRoZSBpbnRlcnJ1cHQgb24gSU5UQi4N
Cj4gPj4gUGxlYXNlIGZpeC4NCj4gPiANCj4gPiBJbnRlcnJ1cHQgbXV4aW5nIGRlcGVuZHMgb24g
dGhlIGNsb2NrIGNvbmZpZ3VyYXRpb24sIG5vdCB0aGUgaW50ZXJydXB0LW5hbWVzIHByb3BlcnR5
Lg0KPiA+IERldmljZXMgZG9uJ3Qgc3VwcG9ydCBtdXhpbmcgdGhlIGFsYXJtIGludGVycnVwdCBp
bmRlcGVuZGVudGx5Lg0KPiA+IA0KPiA+IEZvciBleGFtcGxlIGluIHRoZSBjYXNlIG9mIG1heDMx
MzI5LCBhbGFybSBpbnRlcnJ1cHQgaXMgbXV4ZWQgaW50byBJTlRBIGJ5IGRlZmF1bHQuDQo+ID4g
QWxhcm0gaW50ZXJydXB0IGlzIG11eGVkIGludG8gSU5UQiBwaW4gaWYgYW5kIG9ubHkgaWYgY2xr
aW4gaXMgDQo+ID4gZW5hYmxlZC5cDQo+IA0KPiBKdXN0IHRvIGJlIHN1cmU6IGFyZSB5b3Ugbm93
IGRlc2NyaWJpbmcgaGFyZHdhcmUgb3IgTGludXggZHJpdmVyIGJlaGF2aW9yPw0KPiANCg0KVGhh
dCBpcyBoYXJkd2FyZSBiZWhhdmlvci4NCg0KQmVsb3cgaXMgSW50ZXJydXB0IE1vZGVzIFRhYmxl
IGZyb20gbWF4MzEzMjkgZGF0YXNoZWV0Og0KKy0tLS0tLS0tKy0tLS0tLS0tLSstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0rDQp8IEVOQ0xLTyB8IEVOQ0xLSU4gfCAgICAgICAgICAgICAgIElO
VEEvQ0xLSU4gICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBJTlRCL0NMS09VVCAgICAg
ICAgICAgICAgIHwNCistLS0tLS0tLSstLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tKw0KfCAgICAgIDAgfCAgICAgICAwIHwgSU5UQTogQWxhcm0xLCBUaW1lciwgUEZBSUwsIERJ
TiAgICAgICAgICB8IElOVEI6IEFsYXJtMiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQp8
ICAgICAgMCB8ICAgICAgIDEgfCBDTEtJTiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgSU5UQjogQWxhcm0xLCBBbGFybTIsIFRpbWVyLCBQRkFJTCwgRElOIHwNCnwgICAgICAx
IHwgICAgICAgMCB8IElOVEE6IEFsYXJtMSwgQWxhcm0yLCBUaW1lciwgUEZBSUwsIERJTiAgfCBD
TEtPVVQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KfCAgICAgIDEgfCAgICAg
ICAxIHwgQ0xLSU4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IENMS09VVCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQorLS0tLS0tLS0rLS0tLS0tLS0tKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCg0KPiA+IA0KPiA+IFRoaXMgbWVhbnMgdGhhdCBp
ZiBhIHVzZXIgd2FudHMgdGhlIGFsYXJtIGludGVycnVwdCBvbiBJTlRCIHBpbiwgdGhleSANCj4g
PiBoYXZlIHRvIHByb3ZpZGUgYSBjbG9jayBpbnB1dCB0aHJvdWdoICJjbG9ja3MiIHByb3BlcnR5
LiBJZiB0aGF0IGlzIA0KPiA+IHRoZSBjYXNlLCB0aGV5IGNhbiBwcm92aWRlIGFuIGludGVycnVw
dCBmb3IgSU5UQiBwaW4sIG90aGVyd2lzZSB0aGUgYWxhcm0gZmVhdHVyZSBvZiB0aGUgcnRjIGdl
dHMgZGlzYWJsZWQuDQo+ID4gDQo+ID4gU2lkZSBub3RlOiBTb21lIGRldmljZXMgaGF2ZSAyIEFs
YXJtcyBidXQgQWxhcm0yIGRvZXMgbm90IGhhdmUgYSANCj4gPiByZWdpc3RlciBmb3IgbWF0Y2hp
bmcgInNlY29uZHMiIHNvIG9ubHkgQWxhcm0xIGlzIHVzZWQgYnkgdGhlIGRyaXZlci4NCg0KDQpS
ZWdhcmRzLA0KSWJyYWhpbQ0K
