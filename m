Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8D62F260
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241547AbiKRKT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241596AbiKRKTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:19:21 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76BC91501;
        Fri, 18 Nov 2022 02:19:11 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AI9KKXT026679;
        Fri, 18 Nov 2022 05:19:07 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kx0p7jbw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 05:19:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGXCbwJYdb1DZrFuXiR5E96bVB3Gb0w/qNot+vH4G+aVo4npqCe0FMWegYxM+4gHiAAqxkNUxDgn20gtkg/efk7sUHwQo9o9U+pwZh79DNJkjb1uZ04fXlVOb12uzRRo4Ze7N3klQGwBSR7/m91Prq7zP9Ktn7Nt/dBAYyOzaZgCDIGF+likwZJjr+LxjTJdv58E4r4aYj9Ef2DqU2qHF1YLVNJuR+tPsP5Nt5FJB5z5KUoATuAiXYIpfZP7IhwsSqXXWxAXx+dVQ9tsBroRCpHxtUlGyVXmojnc4G8TOaVal+dg/OHJyRwkRA6QhKpMWwmXvAXXJfMoUD+txSpdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d93reM6YEX+MXgb2e/zd6tY5GhjpF27Z1YTQcMyvnkY=;
 b=dwrfzaCXuIZ2W/+p7tOWIH5nckdkkRQJSeFZPg6pHvjQRCRousUGn7XQUDId5azuz6jIQphqOnRkGtIgWG5Mn6/hyxWrw0PetrqdBNb8pmH9WRparNs7YlAEE159D1K3lAl+I034s+1jwBoEvXjUl7iAgvSWsCWgEcZGBaU0c+HlH87ulyMojBKVBkumYHzorPfuULoQBNRc10pRMiBglPbhBeJmHgz/wMZLex5Rn5iRDE4jt8mkwvxddk8VEejbHFYJ3lmQPOtfcPteD2O8s8olgElUivKWdIbc1/aBZW6p0LbWcnMgKAtTTbYsIGsx6pbk0UDV2pUAKmV3pM7fDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d93reM6YEX+MXgb2e/zd6tY5GhjpF27Z1YTQcMyvnkY=;
 b=3NJxHibameNa7VkcMdj67R7LcgEyQpxBnG693YvS7VwdY+xMcSmIdOw52WKgMT4SrzmG/q2I+9ww5ReYd3Yj8To1KR21xCMzkxzgChBmmEfSgThX8sDizT49t5Ul6kJ999ZonnpsKA9zOlVOWhcJNiiOkdG01hnEwbKdAHfner0=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 10:19:05 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::a07b:a2c6:abe1:c35e]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::a07b:a2c6:abe1:c35e%7]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 10:19:05 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>
Subject: RE: [PATCH v3 00/10] Add '__adis_enable_irq()'
Thread-Topic: [PATCH v3 00/10] Add '__adis_enable_irq()'
Thread-Index: AQHY+ygqNNA15+PT+EaU6gI4mRLz265EdnzA
Date:   Fri, 18 Nov 2022 10:19:05 +0000
Message-ID: <SJ0PR03MB6778AF1B1558319DB50D13E899099@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221118083118.9641-1-ramona.bolboaca@analog.com>
In-Reply-To: <20221118083118.9641-1-ramona.bolboaca@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNmM2NGRhOWUtNjcyYS0xMWVkLWI2YmItYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XDZjNjRkYTlmLTY3MmEtMTFlZC1iNmJiLWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMjE5MSIgdD0iMTMzMTMyNDAzND?=
 =?iso-8859-1?Q?M2NjYzNjM1IiBoPSJPbjZId2orcjQzT2NBSjFQNXo3MUpVdmFaMDQ9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJUcys4dU4vdllBUmtubXQzQkNISEpHU2VhM2NFSWNja0RBQUFB?=
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
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|SJ0PR03MB5757:EE_
x-ms-office365-filtering-correlation-id: 66eb0052-936f-4b76-43f7-08dac94e5258
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wV+R4n14cR1ZUMl6KWdxClMjYOySz1cNOs3mKDEk/IMKHWm4bXnjegg4aK19uuOz3CxLgw3WegPBFdQIWleD4Ce9vs6TwiAVVgeJ3PTliKiKV3MK59AjpxTJkRY+Xiu71Rm6B8BYbZUrnk3Hj1YFvei0dgU/Bsvi+SNcob/sqhqzbLMmC9eZLnYXdYmPX7k8b86+039WYVrN8hpK4uto0ugTy2nPvYaIif7A3+WiipgMbx85ddevp5fdQcNwM+kgaub/xFv/S7h5ykm/Dp1et8G7QHqFv1HKmwh5HN/2AjgVQJehli+q1/Ll3fERlyl+OJ+VINsSk0zhQG5IQCl+vA6zBnnn7Qo/Kx47t3PbmxVonnS19wDDMAw6UqNnIw0Hf+dKDUBzngInx5WaaWqqGvFXh/vaBtCjcl0BjN0lAxagGZ/Ei895P8y6prgZ+iQVJp3OYwrZVvul1DhNWmduzedWJl2fdii3tVu1to1FtrECd+gvk53F5OGU6YgN1lhy1Fc7yJg8NRMBXjimDEWHXCueYPSnwxWqaSmsL2ssZufGhTnTDKLzwwVPQXR1aNQUmUZIm4ylzM3aByd+ozzSAl3lkTUBAb3gD523RbFwhNgTEBvYv76rAsVGae+VE7EdG1o4dpSzQTuTf3PS8408YRvofw8WIUqbIMFTQOC8xgNvIqBjNyTgWIfTlU9n59/8q7Zf0keSNdAkcDVqiFlOjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199015)(83380400001)(52536014)(5660300002)(8936002)(186003)(41300700001)(2906002)(38070700005)(33656002)(86362001)(55016003)(38100700002)(122000001)(53546011)(6506007)(7696005)(71200400001)(110136005)(316002)(107886003)(9686003)(478600001)(26005)(76116006)(4326008)(66446008)(8676002)(66476007)(64756008)(66556008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cjprE9D0WI6yKpnHiCnYRmcHhTahAxHLwW26Vw/PDewna8myF5IYiucuzb?=
 =?iso-8859-1?Q?tmulEamIVSnJ4p9kUkcVRgHSuUBenRLD1uZ/ZKec/3KIBZJPhktQkkB8Ei?=
 =?iso-8859-1?Q?efiLPNjX0EMYCEYMeP2JbWrWZi/i9FbV/8Wlhptm8bnoSWvfiUweUzgsJk?=
 =?iso-8859-1?Q?mOszdDnMPVZbDezRLzokjeMx0UnZzYSRbWbkh4idY0Fn6+72F2jJ3OOde2?=
 =?iso-8859-1?Q?i0+LWcQdTR2Kfs0R2TSuh7yCxhGGkYNCh1Oznaq/91IIoBTDK8OSGnYsZM?=
 =?iso-8859-1?Q?QKgSlmYGrm5/QgcCpB496wMxxyK2K9NFQcC/vXcJhvjLvvmfmR7KvYE5Dd?=
 =?iso-8859-1?Q?lZT8v3hejrBhFuSYKxr58tlIg21ozTqB3NvCS1SOSiAMyJwxP77QZ5dEST?=
 =?iso-8859-1?Q?GZ5SH2J4fu/E2bYu6LwcMI6ngEtuuqUB7Ngbv6O4TnatfjiuyPdNnkulGN?=
 =?iso-8859-1?Q?oZjqxERVuiFNUPqsCcYiKoBnFMsg4bZduhsI+ReSFnUZjqmCIOoMXjPwu9?=
 =?iso-8859-1?Q?sBul21x6a2G5rNIEHsHC4ifsDmwUzbixPcAxUpHvd3YAY/QU4eM/Squ0+h?=
 =?iso-8859-1?Q?v6BUAAiRifYD75fy58cd7BxrRsQ3r25Pdk2cVrJGXSsUcM06tragFQLana?=
 =?iso-8859-1?Q?FXPHoUxfEJCQa/JuWyRLQIFLaDiSUVNoTHqr7shQrAq2bbtdRK9KuDeT6R?=
 =?iso-8859-1?Q?Guubp4gL9GBr2+ZCloJsw0wgN1pYpBntLiAV+Xr3pWMxQo5LqiGJsBGrZ/?=
 =?iso-8859-1?Q?MV7+w5ZKB8qBH8zl/fAP89pv+86JCgfR/f4sG4yXGR2sfHat+4ehQsCI6i?=
 =?iso-8859-1?Q?R9snvFt0u1vNKIQ3PqY5yRVglf6GhlnOFnYjmFC818I8bOBiFXBY6N37SC?=
 =?iso-8859-1?Q?1BhD5wjIN5Jg+N9uaI+rLtE8dCKcFYSnUOSBCX91DH3LjD3BSFts4sxJc6?=
 =?iso-8859-1?Q?QyTtjo9Cvfa79D07IpEH8V3Boe+GdBw4V6sxoltbN0wch2KFioZNfRhB8p?=
 =?iso-8859-1?Q?yLqWIJwTzbJcf2vct0xhrEaJrQwUIJqWj8PfADvu+YD4XKcQXge0+F6blP?=
 =?iso-8859-1?Q?5a3wj2UX54n5RG2OatCciEKxPcdJ65inyi8YFHaHdVqoo+yHCCFGH+N4iv?=
 =?iso-8859-1?Q?2gAI6nQm4+HlnAd0v8cKQLCYbSvSgecsCKCSWrfiWjLjuVLpM+AvbULWqs?=
 =?iso-8859-1?Q?enDudTjNTyW4vzJhdWLJAEzzHzZrIOCJEtQTK9CEHj13IeJIeWG5hRU6hH?=
 =?iso-8859-1?Q?PJZxMs5s07x4XaItNh+3XN0GHiWKWbGkltgBmAUriwthxwVEVM9m5SJXYR?=
 =?iso-8859-1?Q?CcD1Ve9NH27XuJ0uR5AUH9Bg/7APFSl7D4bCQJE2fuVSK5ZZVGvCeHiZKe?=
 =?iso-8859-1?Q?N+z+xf9d9AwQFN0WQavIz3D5wZns9FirDAUbrBC6KpKRNAx7swtZ/B50JJ?=
 =?iso-8859-1?Q?GXBRpG2VcYLvc8X6qeKZWZ0EZxcDwwPZsDM7EOuKfE5qjXWY1jSEKIGraF?=
 =?iso-8859-1?Q?fdbmQj+/YzeUGXuVyccPUmklEQ8Re74JrtBsCgtmXp+UJ5DGwCb59u6BBW?=
 =?iso-8859-1?Q?MfRxCNFDKXU8W2by+VlmuXvSkF9MrSmKCaIazmp/oz9hPHGhPT9E1pqiSE?=
 =?iso-8859-1?Q?Xs5D89u5YjyBMRR85K9Nh4LJ70ofja8z/I?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66eb0052-936f-4b76-43f7-08dac94e5258
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 10:19:05.2331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PUS2sYTBU1eqNwkajvcb/BbrdJ2is1/2+AzDjmUWfl3YIJVmyoEh3bHjZH7wNvn9kaBscSEEea290ME4tBPfEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
X-Proofpoint-ORIG-GUID: 2mk-FyAGz1jV7pWSyJtaVrOIQMQoLVBr
X-Proofpoint-GUID: 2mk-FyAGz1jV7pWSyJtaVrOIQMQoLVBr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=892
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180061
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ramona Bolboaca <ramona.bolboaca@analog.com>
> Sent: Friday, November 18, 2022 9:31 AM
> To: jic23@kernel.org; Sa, Nuno <Nuno.Sa@analog.com>; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Bolboaca, Ramona <Ramona.Bolboaca@analog.com>
> Subject: [PATCH v3 00/10] Add '__adis_enable_irq()'
>=20
> Added implementation for '__adis_enable_irq()' and called it instead of
> 'adis_enable_irq()' inside '__adis_initial_startup()'.
> Replaced 'adis_initial_startup()' calls in probe, with its unlocked
> variant.
> changes in v3:
>  new patches: 1,2
>  changed commit message for patches 2-9
>=20
> Ramona Bolboaca (10):
>   iio: adis: add '__adis_enable_irq()' implementation
>   iio: adis: Call '__adis_enable_irq()' in '__adis_initial_startup()'
>   iio: accel: adis16201: Call '__adis_initial_startup()' in probe
>   iio: accel: adis16209: Call '__adis_initial_startup()' in probe
>   iio: gyro: adis16136: Call '__adis_initial_startup()' in probe
>   iio: gyro: adis16260: Call '__adis_initial_startup()' in probe
>   iio: imu: adis16400: Call '__adis_initial_startup()' in probe
>   staging: iio: accel: adis16203: Call '__adis_initial_startup()'
>   staging: iio: accel: adis16240: Call '__adis_initial_startup()'
>   iio: imu: adis: Remove adis_initial_startup function
>=20
>  drivers/iio/accel/adis16201.c         |  2 +-
>  drivers/iio/accel/adis16209.c         |  2 +-
>  drivers/iio/gyro/adis16136.c          |  2 +-
>  drivers/iio/gyro/adis16260.c          |  2 +-
>  drivers/iio/imu/adis.c                | 28 ++++++++++-----------------
>  drivers/iio/imu/adis16400.c           |  2 +-
>  drivers/staging/iio/accel/adis16203.c |  2 +-
>  drivers/staging/iio/accel/adis16240.c |  2 +-
>  include/linux/iio/imu/adis.h          | 16 +++++++--------
>  9 files changed, 24 insertions(+), 34 deletions(-)
>=20

I would squash patch 1 & 2 as we need to backport them both
and adding ''__adis_enable_irq()' is a direct consequence of fixing the
deadlock. Other than that:

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

