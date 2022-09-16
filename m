Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF625BA742
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiIPHMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIPHMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:12:01 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525ED30F77
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:12:00 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G5pkh5020031;
        Fri, 16 Sep 2022 03:11:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jm8x5m248-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 03:11:56 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28G775At005312;
        Fri, 16 Sep 2022 03:11:56 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jm8x5m243-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 03:11:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XynM5ya2AmA47fAKdv0ZAR4vb30AYSJVnWrDtxFHE93FSi2gc2SvdZ+DzYoRVqSG11Fq3eb0O83VDfdgP4UQSQt+Ut/YSK/25Sz0WeegMN0Z00sqt5gl62MSeJG51m6TLHUxB3aEk6/9o1r/byCHCdWUaOdVVVLvRt46iogabH7q/rM4b2nJ+UFzCdYiPSMHkzgRjBiJmPuKaCS+/4yJULlRHzcihsn51KZnOOJel3VfN9zdiKI970R8Xwp348F27EYa9KZ7iHO+c/gd8hLR+MW4DpQMiKkmHWkqyCEO7vYw5h1VttBTLu5jL++5z+OsvxlC1XfWtB5XVXaDMolomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkgfBMRiS4ubXMvnrDfQNXapUNj7a08Q+BJXbe9Pwp8=;
 b=UZnL4uj2FAJA50rN3Xcy3E90kHg/kslE/s/z//ZPl+Qp/i6xfprBrLy6c+mGA4cyM8vItvTNVro7SDSgj4ch+mlp8CrhX7HOuOLDXvtX/fi6vru5JapMwD08GR23N8KIxSASVukpkI5BHSpvbHGZEgg/2WlnLCOFA0fc/cTbrD7L1mywTN7eIDuDpjYXLFUjqEe2Fup1W/r2d8iA6qXUJ1M0KqTn04YKh5e5oDvssPtGzKYIjVlbeaLjtkwb9i1u0VZ1beAPPejhHJq9Msyj8qghHvJjqGAfUBWARo2U7Ph/9qL+kUeiufcyT1UgX/MnUHMzU0MC4h0JaOxfgEWhjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkgfBMRiS4ubXMvnrDfQNXapUNj7a08Q+BJXbe9Pwp8=;
 b=E9ZIakJygX1SGUm2AmkYZWX4xh7g/oX4VDfL8AqG0Cr7ZGm4AbP3czBBFYTZ++fwFqjUhsviRFuYA94et6dwJrlHKUXTCz/DEzEYfN7RKT5GmocRLx+CYmDCKghPW/NsT0M34i7gXcLDC9WyfAQgJOArA4JrbSCVTj8iLYv7bEM=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by CH0PR03MB6115.namprd03.prod.outlook.com (2603:10b6:610:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Fri, 16 Sep
 2022 07:11:54 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::5472:9c22:a31a:2d4a]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::5472:9c22:a31a:2d4a%7]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 07:11:54 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC:     "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [jic23-iio:testing 149/150] drivers/iio/dac/ad5593r.c:87
 ad5593r_gpio_read() error: uninitialized symbol 'val'.
Thread-Topic: [jic23-iio:testing 149/150] drivers/iio/dac/ad5593r.c:87
 ad5593r_gpio_read() error: uninitialized symbol 'val'.
Thread-Index: AQHYyZllGwG13peD5U2AjjCO3xWkAq3hoyOg
Date:   Fri, 16 Sep 2022 07:11:54 +0000
Message-ID: <SJ0PR03MB6778F73D1F3C08012C6B277299489@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <202209160614.IE7ciPMN-lkp@intel.com>
In-Reply-To: <202209160614.IE7ciPMN-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZDYwZTEwNDYtMzU4ZS0xMWVkLWI2YjAtYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XGQ2MGUxMDQ4LTM1OGUtMTFlZC1iNmIwLWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMjYzMCIgdD0iMTMzMDc3ODU5MT?=
 =?iso-8859-1?Q?IxMzU3ODI1IiBoPSJKNnNUeVNsS09Od1B5QUdOUUpRQ3owemdLN1k9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUFCNUdXWW04bllBWHcyVU9GZ3h3L29mRFpRNFdESEQrZ0RBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVg1bDJLd0FBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|CH0PR03MB6115:EE_
x-ms-office365-filtering-correlation-id: 575940d2-500b-4caf-0254-08da97b2bc2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 706GWOLF+p9fAajQLDT0p2Np2ISUdrz5zjfsgjRQpst7NQLuxaRVsYBm30xSMy1E/acXJWuoprLP99zxZDYhN+7AwQBGo9QFE9NbNq8Glf97JmDbduqMm0H5NV8JyxCN1MK9ulW7R4tW1nuiFfu7UyEVLlRXQAt7Q4iWY29QGrCaCg1ggfGcRJ2Pd46w9Hev1kzNs4AhMysWBCiRX8NbuQ6hARnEJCqOc4vVMb8Q6WtegytQQ/ghieR/7SmYV6ex5jJijBnY4UQxbMEEEpIk4QLvHRCtsyeb1+5k7GvM/Z+f9nMwt9NhO27ktsePxrFKh7jcvF5T8LSgPk87NDDKBUoMmAToJvk1oX1875dmGQslRI40B4MAg84vtmoubHDxl/h9WsjDitDrHNzQwcYmixzzZ8djssLCLxplziNpVj+I0y88n8QUIKmdHZWf7rfPKMIKCyVxbdCN2KT2xVi4Jwg6oG20/tXvqxqixrD/5d/yZqfu/6avOtE5bwDMbS+SK0xEqCgbvxCb21gkDsLjXl7IkqlnET37gQGxPStkeppUyo0plKLu6PMugWzpeEX6pL8gOdRuZUYbgcDHLHEiu6ZR6uGQUC9MfcD/1gZAINu64pzRIHsiek5mta4YHuJpiGYhyjomm5UbVfAOnwjLUdqLiTuDGHgmaz2ceRsifcPW7z9Iy5jm6xaXNKUNIlvaZe6ZYmT8sQSx6aVN0lg5OYyXFt1S4srs/fGZjt2TEr5trCjR4IVTRLbGV/oSaDqsy76o/URNWNlfT+AirD1RKWykz3Qe1YByws9qYyZAnN8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199015)(86362001)(316002)(6636002)(33656002)(38070700005)(2906002)(5660300002)(52536014)(66946007)(122000001)(38100700002)(8936002)(66446008)(64756008)(66556008)(66476007)(7696005)(966005)(478600001)(41300700001)(110136005)(54906003)(8676002)(4326008)(53546011)(6506007)(186003)(9686003)(76116006)(26005)(55016003)(71200400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pINq9tGeH4J9oNOca+AzJMf6FrWPGEyqnJwCeyOBVkTPET6d411cT6YOfD?=
 =?iso-8859-1?Q?gMEOvXt1kJea0O9Vg+bojUKcFNJNxG19LObP8zZZYSVrfBAqhzZd/r0fFY?=
 =?iso-8859-1?Q?A9QFfLvySCDVwzG3mE0CN6/0T/uNpwmhtJz0dAylCa+4Wb0HivNwUoqV/v?=
 =?iso-8859-1?Q?n2QnNwnGJlZIksKuF8OXdXvHhAlqKe3EhROceNdYhl2F3bbDHsKDaXXB7o?=
 =?iso-8859-1?Q?iJJc0t+9X/RSdPsbeLZMyu997XOoJEKKo56ZvZX+/fbxdp8QLOHijgGvn+?=
 =?iso-8859-1?Q?qT4uASSCWF2FwgInqrGT/U9KfCCErkD8XHqxdz7mouEaQqcw2Q6hdX6dl2?=
 =?iso-8859-1?Q?u1zUfuXMBOFDy6hUNbm5QtlX2nmI1LnzJZz6pxyKtyMiesy4HRd933qGTX?=
 =?iso-8859-1?Q?vJBKWvRyA+b72dNuwo7Hphy1UAzUVGmr46iJXkKZkpuPBlD4bETEsoWw9b?=
 =?iso-8859-1?Q?1xqO5Vj5XlgO/GCYPoVCMaXpuHfknf+qXzqBt08JoaPzjTHountlNZ7rvu?=
 =?iso-8859-1?Q?7J9/NbIMU3zARLHYJq0mdy9OhHJGIul+nYJTmQRcPMI9ITYC5SIbGBoOJC?=
 =?iso-8859-1?Q?NMdEKOXaGdUx3XM2NKpec7Oqb1o+ePQd+3lS/SGdR/+FjymcmNDgMHsP4O?=
 =?iso-8859-1?Q?SXmOqzbSd8PaZ/uVYpnXYqsa7gZbCSbkiEpFMlqgd65t/HjQhW55LJOm6K?=
 =?iso-8859-1?Q?NubXWO4bK59KAOyyCakVGrvuZ9zIAq7GYGhNWpbtXSyaokUUFF8AZi7wED?=
 =?iso-8859-1?Q?XBJdRR6BZRiok8vLvEyiGKYHS3LM+ONkeCZF+aB0fi2LYFEcC9h+FRHlfH?=
 =?iso-8859-1?Q?VRQGq7Cw5wFbVc2dB/CrnAUcME9y8QBNrVPxjOwuo0B1qmtX+3WrFl+Tq5?=
 =?iso-8859-1?Q?eUYgEXVfTSBk68okbD5K97n/PKSTmJvw8ynusHLLuKeZCQl3zpY0+qHQhJ?=
 =?iso-8859-1?Q?JBQ9N88zz9nj0FsxHaw6AUOslGaV0soKl1IlhdsPhuXHt+a2SpH4wVQtmK?=
 =?iso-8859-1?Q?mkAGLiYr5h2lY/w2DzPRJRCmdKVkfyvkw9z15dEpBQS7sr1gH4GlZoZtEz?=
 =?iso-8859-1?Q?dL/v5VZZwdORO+gHiqKqAgosm24xzUHulTfDsxv5sVEsC/HqpKq4Gvg7aK?=
 =?iso-8859-1?Q?16eLvxhvlmOkMZ9ZXAQ5HXk++NGvEn1bfGSWtD4rSPAQpD73Qi1Fdvd/Fw?=
 =?iso-8859-1?Q?pQmjkY/BYeFhNjVuSk+msq+Qkdb2xTCMIu2R6+DmeOhNjzFxvrqKwHu/qC?=
 =?iso-8859-1?Q?qfsA28Zef8fkMo9C5bg5dEMchEfJN7h996++U3JyA5jPk0VT7AltYeSMcT?=
 =?iso-8859-1?Q?s4BzZbEGnDnz/bTtm6WXrdKJ5yVG7JrRYYW72YtZlEdJSf24AkpewooEMv?=
 =?iso-8859-1?Q?ZurrMI8WhcY4+fcA6DxwsiFsi5IfjriUzGQcHkBLO9FjIVJW8KngaCwrce?=
 =?iso-8859-1?Q?PAkdSytI+H2kE92pwHZ8/I9zC/JZjT6Vy0sBt0wYhiDSCEMsXAH6Mk5ENd?=
 =?iso-8859-1?Q?0k1NQnhgBmW9qL+DUluCLGbWcNj7H53pqvkrKIEL7JwnZCl5ZNTI7JDqVs?=
 =?iso-8859-1?Q?IzoJYUbsCMPDxozJk+JnCohLpPW4y/hV/d+Qxd+GqbELFroeDuJrAozMIL?=
 =?iso-8859-1?Q?L13RCnz77c3I2NYgLHLEtkOKEQU2Pf2UQW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575940d2-500b-4caf-0254-08da97b2bc2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 07:11:54.3204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfnHfyvyXblJ6BovzLMgcnzPyXkWIEjaimQN5+14efWtnZRsFmuxkGoyOwRMoawX/Il7+JiEx7WUbwZqJDKj2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6115
X-Proofpoint-GUID: SR3NuREI5iQMn5ddXQUeQtx6_S7q_9GG
X-Proofpoint-ORIG-GUID: AuoHfhAZrAnH3gV14SHEtvA-fMK2YwCU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_02,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209160052
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Friday, September 16, 2022 8:56 AM
> To: kbuild@lists.01.org; Hennerich, Michael
> <Michael.Hennerich@analog.com>
> Cc: lkp@intel.com; kbuild-all@lists.01.org; linux-kernel@vger.kernel.org;
> Jonathan Cameron <Jonathan.Cameron@huawei.com>; Sa, Nuno
> <Nuno.Sa@analog.com>
> Subject: [jic23-iio:testing 149/150] drivers/iio/dac/ad5593r.c:87
> ad5593r_gpio_read() error: uninitialized symbol 'val'.
>=20
> [External]
>=20
> tree:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/g
> it/jic23/iio.git__;!!A3Ni8CS0y2Y!94Jf_eIoy5zwbmsSRdWgugxbqkbgHFd0A88T
> z4SKRufGLX24YYSEzKlB13AXeYzsBWzd5HW-SqPpIzc8hvh-6w$   testing
> head:   62a6e699f4669b2c51f408273756f93b21c9f1a1
> commit: 53b6e3b2164c5807669fbf6b3df0e1494b4d03b8 [149/150] iio: dac:
> ad5593r: Fix i2c read protocol requirements
> config: x86_64-randconfig-m001
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
>=20
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> smatch warnings:
> drivers/iio/dac/ad5593r.c:87 ad5593r_gpio_read() error: uninitialized sym=
bol
> 'val'.
>=20
> vim +/val +87 drivers/iio/dac/ad5593r.c
>=20
> 56ca9db862bf3d7 Paul Cercueil     2016-04-05  79  static int
> ad5593r_gpio_read(struct ad5592r_state *st, u8 *value)
> 56ca9db862bf3d7 Paul Cercueil     2016-04-05  80  {
> 56ca9db862bf3d7 Paul Cercueil     2016-04-05  81  	struct i2c_client *i2c=
 =3D
> to_i2c_client(st->dev);
> 53b6e3b2164c580 Michael Hennerich 2022-09-13  82  	u16 val;
> 53b6e3b2164c580 Michael Hennerich 2022-09-13  83  	int ret;
> 56ca9db862bf3d7 Paul Cercueil     2016-04-05  84
> 53b6e3b2164c580 Michael Hennerich 2022-09-13  85  	ret =3D
> ad5593r_read_word(i2c, AD5593R_MODE_GPIO_READBACK, &val);
> 56ca9db862bf3d7 Paul Cercueil     2016-04-05  86
> 56ca9db862bf3d7 Paul Cercueil     2016-04-05 @87  	*value =3D (u8) val;
>=20
>=20
> In the original code the error checking prevented reading uninitialized
> variables.  It's not really a problem, because ad5593r_read_word() can't
> actually fail but, you know?  Technically the checker is correct.

Hmm, in theory, it can if one of the i2c functions (for some reason) return=
 error.
Not sure how to handle this... Given this is still in the testing branch sh=
ould I
just re-spin another version of the series? Jonathan?

- Nuno S=E1
