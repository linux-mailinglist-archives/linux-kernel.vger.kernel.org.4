Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F166B33BC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCJBiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCJBiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:38:13 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE95E8439;
        Thu,  9 Mar 2023 17:37:52 -0800 (PST)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32A0cbof026817;
        Thu, 9 Mar 2023 20:37:29 -0500
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3p7kgdtjfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 20:37:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVVc8PCm/2sWUx1VOq2KNAW+OHUIn+Q5/qvO3avK7IvFxWw2kfrSIEAMR1NE3dgZmBwr48Ro8JL+5vf7Pf0HQgT4cm2xtyrcsWIuIpnw7c4lrWOmMsh1dsIzLQwz41xviIY0pDf4/2Bomcca7CJRVLRpCS1mv56oO7+esPMkWc30+MmXUZX0SQQmEL25iszezjbz2iQnDQZIyayvlPLSkeZNh/3yX71kbWUh8XKvcaNGx+pHzV6JUAyoAw7DWaimuNZBsl7nsMBa0OfSEySVTzuSYFoVyRjgzbqulsXU0UHbZaduov8oThJxRC2nx0U9uMgeUtzZsxhF9q0Q8wMvEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYYkQezdPpDXo0ObUlB2ezllKsD4cJzqtX91OxL7vdo=;
 b=oLMHDCogzuEBuaAC0QNSEig0uFJRrPOCiOmxhMntvu+pKSaI34Vanq7o5eP1Ef0KDKsFn8o86U0uD4B8stIhVLuUSkarRlnQS/Cs8etWCVWA3faeZjUuCyHiR6GZhQMmR+T1XJr4WKWc0WLDkUFXNCltjNJ0GVI2oHlnw2wUhFOt9fGnFtPQQ1ppVdDnGDkB+iVnrNg4CiuAXxoBJs0tO0lQc0O40Ke/zibX7/93UwlgiQiXqmW9PPSnwoktMt3Cnxt3Q5ImXskKmX5eIT5Vp8d6Dd8zLdH64sHoVD/jQ0sWZDnnLsmVEPDolPdZIuNWcCCR12cwZ7TV6vUDZN6TTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYYkQezdPpDXo0ObUlB2ezllKsD4cJzqtX91OxL7vdo=;
 b=KJjLDfEmrPRr9hG15I0WxDF//OHuCBNGS+5E84E9qVUm/dz5qHQJwLVpfL5mmtIoKe0eXK9fr+2xVDd2Br8JiiAfTpNfN0B2EaqsIa7JPD1TvoBjEQUGHe3W5aFEwpIGNcZy/kEEFmTIi3FXrbA9QqSvvKaf3YzIybl4FI3Odkk=
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com (2603:10b6:a03:400::6)
 by SJ0PR03MB5855.namprd03.prod.outlook.com (2603:10b6:a03:2d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 01:37:27 +0000
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::546:72be:4164:dde7]) by SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::546:72be:4164:dde7%5]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 01:37:27 +0000
From:   "Lee, RyanS" <RyanS.Lee@analog.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
CC:     =?utf-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "herve.codina@bootlin.com" <herve.codina@bootlin.com>,
        "wangweidong.a@awinic.com" <wangweidong.a@awinic.com>,
        "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
        "ajye_huang@compal.corp-partner.google.com" 
        <ajye_huang@compal.corp-partner.google.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "povik+lin@cutebit.org" <povik+lin@cutebit.org>,
        "flatmax@flatmax.com" <flatmax@flatmax.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] ASoC: max98363: add soundwire amplifier driver
Thread-Topic: [PATCH 1/2] ASoC: max98363: add soundwire amplifier driver
Thread-Index: AQHZR+yFEci7+1f3Mki1DtKfFrzJwq7i7XCAgAApzQCAAAjpgIAABxAAgAA0YWCAAB2ogIAPmkxQ
Date:   Fri, 10 Mar 2023 01:37:27 +0000
Message-ID: <SJ0PR03MB6681558502B972EE6651FA2D8ABA9@SJ0PR03MB6681.namprd03.prod.outlook.com>
References: <20230224010814.504016-1-ryan.lee.analog@gmail.com>
 <0fb47fe7-719b-0773-fc14-3d62d7d33619@linux.intel.com>
 <Y/zsqjOWFKrpDtl8@sirena.org.uk>
 <d95d15f3-34c3-32df-1a50-0ebce35bf81f@linux.intel.com>
 <Y/z6EB+0beX2Ji2h@sirena.org.uk>
 <SJ0PR03MB66814E588528C771D7BEAB3D8AAF9@SJ0PR03MB6681.namprd03.prod.outlook.com>
 <5d78bbc6-340e-dea8-40c6-d065c7e7a878@linux.intel.com>
In-Reply-To: <5d78bbc6-340e-dea8-40c6-d065c7e7a878@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jY214bFpURXpYR0Z3Y0dSaGRHRmNjbTloYldsdVoxd3dPV1E0TkRsaU5p?=
 =?utf-8?B?MHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dVek5XSmNiWE5uYzF4?=
 =?utf-8?B?dGMyY3RNV0kyWXpJMk9EUXRZbVZsTkMweE1XVmtMV0poWWpFdE56QXhZV0k0?=
 =?utf-8?B?TURkbFpHSTVYR0Z0WlMxMFpYTjBYREZpTm1NeU5qZzFMV0psWlRRdE1URmxa?=
 =?utf-8?B?QzFpWVdJeExUY3dNV0ZpT0RBM1pXUmlPV0p2WkhrdWRIaDBJaUJ6ZWowaU16?=
 =?utf-8?B?QTNOQ0lnZEQwaU1UTXpNakk0T0RVNE5EVTJNVFk0TnpnMUlpQm9QU0l5TVdo?=
 =?utf-8?B?WFdXUjVjelpVV1RZMU4zaHFORU5ZY25wMlNVbENVMWs5SWlCcFpEMGlJaUJp?=
 =?utf-8?B?YkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNTRlV4VWxOU1ZVWk9R?=
 =?utf-8?B?MmRWUVVGRmIwTkJRVUpTVjFKNlpUaEdURnBCWW5SdEszbzFha1YyTkhsMU1t?=
 =?utf-8?B?STNVRzFOVXk5cVNVUkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlNFRkJRVUZFWVVGUlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UlVGQlVVRkNRVUZCUVZGa2FXczFVVUZCUVVGQlFVRkJRVUZCUVVGQlFVbzBR?=
 =?utf-8?B?VUZCUW1oQlIxRkJZVkZDWmtGSVRVRmFVVUpxUVVoVlFXTm5RbXhCUmpoQlkw?=
 =?utf-8?B?RkNlVUZIT0VGaFowSnNRVWROUVdSQlFucEJSamhCV21kQ2FFRkhkMEZqZDBK?=
 =?utf-8?B?c1FVWTRRVnBuUW5aQlNFMUJZVkZDTUVGSGEwRmtaMEpzUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVGQlFVRkJRVUZCUVdk?=
 =?utf-8?B?QlFVRkJRVUZ1WjBGQlFVZEZRVnBCUW5CQlJqaEJZM2RDYkVGSFRVRmtVVUo1?=
 =?utf-8?B?UVVkVlFWaDNRbmRCU0VsQlluZENjVUZIVlVGWmQwSXdRVWhOUVZoM1FqQkJS?=
 =?utf-8?B?MnRCV2xGQ2VVRkVSVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlVVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVTkJRVUZCUVVGRFpVRkJRVUZaVVVKclFVZHJRVmgzUW5wQlIx?=
 =?utf-8?B?VkJXWGRDTVVGSVNVRmFVVUptUVVoQlFXTm5RblpCUjI5QldsRkNha0ZJVVVG?=
 =?utf-8?B?amQwSm1RVWhSUVdGUlFteEJTRWxCVFdkQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRa0ZCUVVGQlFVRkJRVUZKUVVGQlFVRkJRVDA5SWk4K1BDOXRaWFJo?=
 =?utf-8?B?UGc9PQ==?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6681:EE_|SJ0PR03MB5855:EE_
x-ms-office365-filtering-correlation-id: 67714058-eca7-4709-52b0-08db2108017c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +HmvIblRMJ8UjptSZhfgCeuwCGVkirkmfl628QVQK8Cnho0Fd9BQ6UpSFS6WNjIlWVtfU1CozQyawY2HgQ8aUu6fJLpSuxCR1GMpSg7Zbni4tK+HOunNVl802cpuyzWjZ7GrUxKcq72c6Mb8R/iXtnVJTZKSgA7ItNQ2X352n4kJfbmh4GGaCC3ge1o24LepCytHPZKxoKfHxDf66jLUJLCT4KyuqAAWgyE2pHcw1jbJGGTX+aUwukp8hyRa4XWDsrD0agPyl5mhubNJBSF/sYH+jgf7fv99CE2xkTOaiChboxMd9YPQDmHe3Hzt3LIBrNyQ+nWw8ZcL+JZtnS3vrYZWcsAGWr3gEXb5J01/9janzHXTrJaQazVWj4vLk5vMBvTpnA9l9+RwKlFqgwbrFflBQznpConQi1r1DGPAttaw3zm2fQ+OmdHMowlWv5Ud/ijmE8uyOvkpKCL3vCT2PXmZTkl9Q7Owa3R5COdFa00C2tsHJ2lcfF7sJa27uXnWSSbXVg/GsiA1+lrOIXe1lkI+h5vQseXY4EbIEzjivtF/uY8pko3YMScULjfTWcYwGTOpogzpvOLce3s9RtLRV5IXPrn9i5/Wj77tcI8D7qdpj6zXT5IZGGNuzs4q63MJ2BUcoZeBTP3g7Y6EpLzfgPS2jBH+xCg5i1kncMhoG2rtJTn5GXIgvigzPyrpwymzyEBKYm9tihqEYmMeW5KCCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6681.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199018)(66556008)(66946007)(76116006)(8676002)(4326008)(41300700001)(110136005)(64756008)(66446008)(83380400001)(66476007)(66899018)(316002)(54906003)(38070700005)(122000001)(38100700002)(8936002)(52536014)(2906002)(7696005)(33656002)(186003)(7416002)(5660300002)(478600001)(86362001)(71200400001)(9686003)(6506007)(26005)(55016003)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rkpwandhcy9xeFBZK3hSS2EwcmJQM2JVdFE0Z3U5RmJHZGd2Q0tXdUU5VzRB?=
 =?utf-8?B?aHNXSitUakIxSFZUUTFKM0VrV1JMQStKd05rVmRBazZIU0UwTEl0a1A4cjJ4?=
 =?utf-8?B?a3hYc05FNTE3RlptTVkvNlkyYkNTQzJjQkdCU1dIcXg4SUUyQ2lTa0xPVFN3?=
 =?utf-8?B?VXBORHA4YklMancxR21ZL2t2YzNmOVNSUW9UMHpnY3ZrTzdlNmJGUWZjTjJV?=
 =?utf-8?B?WFFEUkR6dFhIamphM043SHNMR21PWWp3M0JpRXMwQVRGSGVVY1JMSDJ5TVBD?=
 =?utf-8?B?UldCd0ppRWFXVjI0R08yV0QvVUVnelJjY0x3Z0dnazVhMUhaWkhuQ2kwRWdV?=
 =?utf-8?B?dy9XTHhNRm9oK0lQMHlsQ0pYdzdvL1JZRVF4QmNWbklkVTUvUzZ3YWZkSS9o?=
 =?utf-8?B?UXBHcStiOElHZjVXTm94aWtONk16NXBZK1ZVM21jTThOclEzRnpZQi9pRFlD?=
 =?utf-8?B?b3Q5bSs3UXhZbi80aE5WWnlWMlZzSVBSRlN2elpQeEg3M1lFdVp3bnlIamRS?=
 =?utf-8?B?UkE5aFdjRWd2UlBLV3FLaHJHajRGMkZOYzlpU1gzL3FzaldrR044b2dUQ1NI?=
 =?utf-8?B?aWREKzUwWnU0T3Axd1RTcEpLOHVGcmVIUnZtdkNoSm0ycFlZc3E4eEJHQlYy?=
 =?utf-8?B?UVlXeGl3UWlqNzczaTBXbkRtUlViaEFNdDhFM0UwVCtwQm91WWJBYW9nTDJY?=
 =?utf-8?B?MmpkRGYxdUI3REJCWFFNTEliVzhpMDlyNTAvNDB4c3Q2eTVBK2dTSXRacXN0?=
 =?utf-8?B?aUptaHUzcUQ0ZGNDeldaUUYxYkI3bVY0VXRMbXNrSE5nY2dDcFlxVVNGcW00?=
 =?utf-8?B?MWtCS0pCQ0wyeXVYMUJFSnlKeDVYZDlVU1VmQk9qQ1ZFb2Y2Q1ZGY3B1N0t3?=
 =?utf-8?B?UTNrSm1RUkVmNE5KQ2l6cHpnYzJJYjFWbERLWnpDNmx3akhVMTY4UXpnUGZT?=
 =?utf-8?B?b1pEeDNLR2VRV1d2ZzdMY1JLZU1aMlE0TUpCazdoTElBYmY3bUdaYlREQmRB?=
 =?utf-8?B?bWxKRERaeTBkU0pNejJvaEhBMGRPdDdvekxyRVRTL3Zmekw3V3JwNW5LeHhW?=
 =?utf-8?B?Y0k1OUhGbkVrK21uejdyNzMzMklDa2d0L2VPeUZ2NEdXQkRxN1pDOWZvdC9j?=
 =?utf-8?B?SzdZVEpicSs5SFEvaVdMc1N1aFdJek1kOEl2N1VMRlAveVk0OWdVTFMxaitj?=
 =?utf-8?B?a2tFZ3paNmRHNlJmWnM0LzRyYzY0NUNRVjVrQkY1bGRKUC84M0x4Tm1FWGtt?=
 =?utf-8?B?NGpGNmd5K2IyVFRXcjdBdEhSYVMydmdpREF2V2RQWWZBVS9yc084QTErdjlB?=
 =?utf-8?B?d0NSeTJxb0JSOVZHc1M5cXNRM2hGWStRdDIvUHdESGxWNHBRam1XRmh0ZXBW?=
 =?utf-8?B?WGE2dHpxajEvNDAyamZwM0pxRFk4dkNiaklwR1c5NVA3b24wWGU5WWc0OEQv?=
 =?utf-8?B?UHNSR1JuTUh0TmNWeTdsZjV6UXVpbjBEbTNLZUhGclp4Z3EzQVFpRmxDTU9H?=
 =?utf-8?B?VFlzQ2FHaVJ5QStCc2dIS01lc1QvNmFTYlllSitkZ251M0ZTL2E4NmFReStG?=
 =?utf-8?B?WTVmQWVjK3QwM2lCcXNHa2xvWVFJM3NuWEd2R09XM3FkUk9MSUpGdVM1K2Rt?=
 =?utf-8?B?eS9JSDZDbGFSMHVzR1N1M05wcnZ0WDRDY1NYTW81Z2JDZW1DNGNncWhKTVg3?=
 =?utf-8?B?SUlPSThtMUlJelRkV2pOVTVUNjRhQ3NFeWN0VitQZW96WmhCc0dVZ1F3TUR5?=
 =?utf-8?B?QUFHZWdaTkZ2SEVLWGZDMmNpdkpGbm9rN0dqS0xFZ1dETU5HVDIzS05wQzNn?=
 =?utf-8?B?MllCaW9YdXR0ajI5ZHVRM2ZLT1grUWY5SkdGWlZaWWsvNk52Qk9QMmxBRHVo?=
 =?utf-8?B?Tk1OMzFYRkNVU25oZHRGUk1Lb083ckFocHBhdC9RWGNoZU1OK0llN3liRGN3?=
 =?utf-8?B?NjhKRjVhTnVxdDZBNHVNVmhTejdibXY4SXVaRll5eDRhbWJYTDduTDUyZmZT?=
 =?utf-8?B?RENjQ3BzVkp2NmtCcnZnUUFtU3ZjM3ZVS2dMb1M2U2RVRW54TXhXZHpvc0JC?=
 =?utf-8?B?dFYrc0VXRm1Za2EwMW0yWnNNZ1BFcTNSUjQ0dHJwdVY4VWtJVUdTYkF3MDI0?=
 =?utf-8?Q?k49NHZvEdtnUWw4SFaJQEPDmQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67714058-eca7-4709-52b0-08db2108017c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 01:37:27.1280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dxk9yox+h+0lc0wkiaL+56Lxpvk6CzgndU0g6GH2/CExnmMVzXF0izmjmVpL29JSGC2+uN2DXhX06Vem1icYwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5855
X-Proofpoint-ORIG-GUID: ysPx_bxN8igwFCy-w5fSvQjfM9uuV8MH
X-Proofpoint-GUID: ysPx_bxN8igwFCy-w5fSvQjfM9uuV8MH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_14,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 mlxlogscore=853 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100007
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaWVycmUtTG91aXMgQm9zc2Fy
dCA8cGllcnJlLWxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25kYXks
IEZlYnJ1YXJ5IDI3LCAyMDIzIDM6MzggUE0NCj4gVG86IExlZSwgUnlhblMgPFJ5YW5TLkxlZUBh
bmFsb2cuY29tPjsgTWFyayBCcm93bg0KPiA8YnJvb25pZUBrZXJuZWwub3JnPg0KPiBDYzog4oCc
UnlhbiA8cnlhbi5sZWUuYW5hbG9nQGdtYWlsLmNvbT47IGxnaXJkd29vZEBnbWFpbC5jb207DQo+
IHRpd2FpQHN1c2UuY29tOyBrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc7IHJmQG9wZW5z
b3VyY2UuY2lycnVzLmNvbTsNCj4gY2tlZXBheEBvcGVuc291cmNlLmNpcnJ1cy5jb207IGhlcnZl
LmNvZGluYUBib290bGluLmNvbTsNCj4gd2FuZ3dlaWRvbmcuYUBhd2luaWMuY29tOyBqYW1lcy5z
Y2h1bG1hbkBjaXJydXMuY29tOw0KPiBhanllX2h1YW5nQGNvbXBhbC5jb3JwLXBhcnRuZXIuZ29v
Z2xlLmNvbTsgc2h1bWluZ2ZAcmVhbHRlay5jb207DQo+IHBvdmlrK2xpbkBjdXRlYml0Lm9yZzsg
ZmxhdG1heEBmbGF0bWF4LmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gYWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBBU29DOiBtYXg5
ODM2MzogYWRkIHNvdW5kd2lyZSBhbXBsaWZpZXIgZHJpdmVyDQo+IA0KPiBbRXh0ZXJuYWxdDQo+
IA0KPiANCj4gPj4+IFB1dCBkaWZmZXJlbnRseSwgU291bmRXaXJlIGNvZGVjIGRyaXZlcnMgc2hv
dWxkIG9ubHkgZGVhbCB3aXRoDQo+ID4+PiBub24tc3RhbmRhcmQgdmVuZG9yLXNwZWNpZmljIHJl
Z2lzdGVycy4NCj4gPj4NCj4gPj4gT0ssIGl0J2QgYmUgZ29vZCB0byBiZSBjbGVhciBhYm91dCB3
aGF0IHRoZSBpc3N1ZSBpcyB3aGVuIHJldmlld2luZyB0aGluZ3MuDQo+ID4+IFRoZSByZWdpc3Rl
cnMgKmFyZSogaW4gdGhlIGRldmljZSdzIHJlZ2lzdGVyIG1hcCBidXQgdGhlIGRyaXZlcg0KPiA+
PiBzaG91bGRuJ3QgYmUgcmVmZXJlbmNpbmcgdGhlbSBhdCBhbGwgYW5kIHNob3VsZCBpbnN0ZWFk
IGJlIGdvaW5nIHZpYQ0KPiA+PiB0aGUgU291bmRXaXJlIGNvcmUgZm9yIGFueXRoaW5nIGluIHRo
ZXJlLg0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgY29tbWVudC4NCj4gPiBUaGUgb25seSByZWFz
b24gSSBhZGRlZCBzdGFuZGFyZCBTb3VuZFdpcmUgcmVnaXN0ZXJzIHRvIHRoZSBhbXAgZHJpdmVy
DQo+ID4gaXMgdG8gY2hlY2sgdGhlIHZhbHVlcyBmb3IgdGhlIGRlYnVnZ2luZyBwdXJwb3NlIGJl
Y2F1c2UgdGhlc2UNCj4gPiByZWdpc3RlcnMgdmFsdWVzIGFyZSBpbXBvcnRhbnQgdG8gdW5kZXJz
dGFuZCB0aGUgZGV2aWNlIHN0YXR1cywgYnV0IGl0DQo+ID4gaXMgbm90IHZpc2libGUgZnJvbSB0
aGUgcmVnbWFwIGRlYnVnZnMgaWYgdGhvc2UgcmVnaXN0ZXJzIGFyZSBub3QgaW5jbHVkZWQNCj4g
b24gdGhlIHJlZ21hcCB0YWJsZSBvZiB0aGUgZHJpdmVyLg0KPiA+IFRoZSBkcml2ZXIgbmV2ZXIg
Y29udHJvbHMgdGhlIHN0YW5kYXJkIFNvdW5kV2lyZSByZWdpc3RlcnMgYnkgaXRzZWxmLg0KPiA+
IERvIHlvdSByZWNvbW1lbmQgcmVtb3ZpbmcgdGhlIHN0YW5kYXJkIFNvdW5kV2lyZSByZWdpc3Rl
cnMgZnJvbSB0aGUNCj4gPiBkcml2ZXIgb3Iga2VlcGluZyBpdCBub24tdm9sYXRpbGU/DQo+ID4g
KFRoZSByZWdfZGVmYXVsdCB2YWx1ZXMgaW4gdGhlIHRhYmxlIGFyZSBhbGwgYW1wIHJlc2V0IHZh
bHVlcyBhbmQNCj4gPiB0aG9zZSByZWdpc3RlcnMgYXJlIHRyZWF0ZWQgYXMgdm9sYXRpbGUuIEkg
c2hhbGwgY2xlYXIgJ3VuaXF1ZSBJRCcNCj4gPiBmaWVsZCBiZWNhdXNlIGl0IGlzIGRldGVybWlu
ZWQgYnkgdGhlIGhhcmR3YXJlIHBpbiBjb25uZWN0aW9uLikNCj4gDQo+IFdlIGFscmVhZHkgaGF2
ZSBkZWJ1Z2ZzIHN1cHBvcnQgZm9yIHRob3NlIHJlZ2lzdGVycywgc2VlDQo+IHNkd19zbGF2ZV9y
ZWdfc2hvdygpIGluIGRyaXZlcnMvc291bmR3aXJlL2RlYnVnZnMuYw0KPiANCj4gSXQncyBub3Qg
dGhlIHNhbWUgZmlsZSBhcyByZWdtYXAgZGVidWdmcyBidXQgdGhlIGluZm9ybWF0aW9uIGlzIGFs
cmVhZHkgdGhlcmUsDQo+IHNlZSBlLmcuIGFuIGV4YW1wbGUgb24gdGhlIFNPRiBDSSBkZXZpY2Vz
Og0KPiANCj4gY2QgL3N5cy9rZXJuZWwvZGVidWcvc291bmR3aXJlL21hc3Rlci0wLTEvc2R3OjE6
MDI1ZDowNzAwOjAwDQo+IG1vcmUgcmVnaXN0ZXJzDQo+IA0KPiBSZWdpc3RlciAgVmFsdWUNCj4g
DQo+IERQMA0KPiAgIDAJIDANCj4gICAxCSAwDQo+ICAgMgkgMA0KPiAgIDMJIDANCj4gICA0CSAw
DQo+ICAgNQkgMQ0KPiBCYW5rMA0KPiAgMjAJIDANCj4gIDIyCSAwDQo+ICAyMwkgMA0KPiAgMjQJ
IDANCj4gIDI1CSAwDQo+ICAyNgkgMA0KPiAgMjcJWFgNCj4gIDI4CVhYDQo+IEJhbmsxDQo+ICAz
MAkgMA0KPiAgMzIJIDANCj4gIDMzCSAwDQo+ICAzNAkgMA0KPiAgMzUJIDANCj4gIDM2CSAwDQo+
ICAzNwlYWA0KPiAgMzgJWFgNCj4gDQo+IFNDUA0KPiAgNDAJIDANCj4gIDQxCSA3DQo+ICA0Mgkg
MA0KPiAgNDMJIDANCj4gIDQ0CTIwDQo+ICA0NQkgOQ0KPiAgNDYJIDQNCj4gIDQ3CVhYDQo+ICA0
OAlYWA0KPiAgNDkJWFgNCj4gIDRhCVhYDQo+ICA0YglYWA0KPiAgNTAJMTANCj4gIDUxCSAyDQo+
ICA1Mgk1ZA0KPiAgNTMJIDcNCj4gIDU0CSAwDQo+ICA1NQkgMA0KPiANCj4gRFAxDQo+IDEwMAkg
MA0KPiAxMDEJIDANCj4gMTAyCSAwDQoNClRoYW5rIHlvdSBmb3IgdGhlIHVzZWZ1bCBpbmZvcm1h
dGlvbi4gVGhlbiwgdGhlcmUgaXMgbm8gcmVhc29uIHRvIGtlZXANCnN0YW5kYXJkIHJlZ2lzdGVy
cyBpbiB0aGUgZHJpdmVyLiBJIHNoYWxsIHJlbW92ZSBzdGFuZCByZWdpc3RlcnMgZnJvbQ0KdGhl
IGFtcCByZWdpc3RlciBtYXAuDQo=
