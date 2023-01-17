Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CB866D454
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjAQCeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbjAQCeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:34:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1743298DE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:23 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09DqI023597;
        Tue, 17 Jan 2023 02:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tjLh+gKE9O4Zm+oZwKNRnJ393ZMeCC/T8IueOFF39Ww=;
 b=OhvzvvTnJTW6WgEx3A2cNQTGz5JSdg6mSxKu1aKhS2kvAsWyFR7EQwxEnCKcP/oLIHG5
 JgAPZ7bL4BLcGg3L/RxFNCZQCfGCkdJdInBOWM2SLBtZw4vqROBrnPdf9ffHH+9ELpTf
 xGRRcgVnuCncUDk1wI63xPQ96jsTqi53NUETmQ07k9bfPw2zsPd41RMpFkXGnjHsqH2L
 Yn4DDglpNfHpYcW4xHfa8BZEmP+ZxvoL6vHfcYJpCr+Y/4TbYFwg50FLRvapO6oDYaKa
 XTojxXjDmQKLA++qWYYOpkQ47YLaDEj+vCoheGvw+b4hbWN6/a6GI3ojZwAK4L83Vx2k aQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3jtukq1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMM4rc028480;
        Tue, 17 Jan 2023 02:34:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfxkx-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbxMPf182Z0PjAwRiG+KpUo/7oDsJQLc4FExTa909YAI4NDRM2hUmqwDg5fKr8j1SwCPCP2MDLUE7l4/ABvvHFnT68zef5FUdUkaje0y6W1ad/s3hS92/DUQ7/3Aq9eZtE6tP1oqHxIqr0P3s+H8DCMiZAzKCaerGm1p1wkp2cNddSv9IqyxW4khfHJ1f1nNw+mFDuKF7AyjBrjiWamazEP69fHmLhxXi2GcuwLqyAtajShiZ0+6p2+ZlZFdnYCwqh8NOijR+LpckUjRt1AeT+geV+GeHY6dVxyKd/LEJbuLi2/1cVnCQkulvRK6D4yzLGa24Q4mGlUjUiPw0UrfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjLh+gKE9O4Zm+oZwKNRnJ393ZMeCC/T8IueOFF39Ww=;
 b=bW2BEipjx/AnbWT/6CyB4dhtc6Gv4WuB87ZR+DUTGZwDisui4FqLWY8MDo1N67k78WSbyXY498Fz4IpodIlM6/XDNwrSFXTaZ3XggzD78odTI7zpboeh6WVR+0fZoNoo46sgajpHNisiHFlQumG6r44EFmyWCM3u2onsDuy+xal23ndsPPdMBA0mK0GjdP2mhe/f1UXMeko0JF/AXVhvPxjDLwWZxFemWqIkMoB80CeAbcbsC5EA/p7eIVsj+i27RNjwdxgW4VP9XCcx3ieWkgkubxSaaKCfjdWqmL3AZOcSP5fRR94NeBPB1fpdu2XnKkmq8WKYnO1v697VWx+mpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjLh+gKE9O4Zm+oZwKNRnJ393ZMeCC/T8IueOFF39Ww=;
 b=BzOA4IcD8UFmNoIG20XvhS5O+OxuUAPQOjMIPygu6XLyXRS46tHa+k3+Qu9+GI2g3t7y7OUHJbs/xG2hXhDYnlK36ceGpMdCC3GWu8p5g/8X24Ezeh0Iw8F1aPxEpcUjoHNvfXxhZWGb7Lq+H8l8Kh1UuaF1AstKzyaTggFGrEo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        "syzbot+502859d610c661e56545@syzkaller.appspotmail.com" 
        <syzbot+502859d610c661e56545@syzkaller.appspotmail.com>
Subject: [PATCH v3 06/48] maple_tree: Fix mas_prev() and mas_find() state
 handling
Thread-Topic: [PATCH v3 06/48] maple_tree: Fix mas_prev() and mas_find() state
 handling
Thread-Index: AQHZKhwuhhwaScj4WkyQ7od226ZJ7g==
Date:   Tue, 17 Jan 2023 02:34:11 +0000
Message-ID: <20230117023335.1690727-7-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: 4c402420-eafe-4a97-6ade-08daf83351ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4+lP0slDIw4J8GK3Oy8nhQp/3euop0ts15d7S/4CBMGB/XRWWVL0CU2dmnB6Xbwhe1a1xXQgcKSv40RbzGZR3Vzfc82Gac583ynmxWQW1pyUYplM6S3A6fd/PnWu47bZ4FF1dHefiO8lTA216sO5iDW4Mfg3xJjAiR0gFRtp3OhevfgIPCNs63IHLxzn2CVq2SNRKlqkSD4VEhjVJduTQHhgFe0JxqA8Ygs7xN5omtopBb1jK8e9SGTOL9U/Os600vEUZrtMNyu/cityp3JxLkez2LeLJD9+yE5pog8ZtTk7BxLEZe4l4UbvjfZp2AcHFKgCtIkEsnynGWtcz+B9abBTVlfpfclewKz1uAhodEJb0Bi2Q3D4RO1i5iMwK4IMbUpodCjfGMGowPh4tyt3BMzdcv493yZubhipuP+oUy+dih9V0rjmMyVMoiEBAxWoDABwSJTwBL+mYYFnaGYMJizMR86zdZBkYHuBeuuxWg3NUdoPwfui201OQ1N2wvxk+RbYe8Kwgpt3zCu/lgCq9hLRk8Yb1NspTNqL1qgprIwECd8QCg4qkAoQpp3+LAiupPEp8c62kSlVTNHmGbYpF907ppc03LMHCE5+0tDaiw/gW3ti28/ZumamDxCq3XmUoxD+Opo5gHXA0pfm6Fjf9MOSzO+dcrGGO9gxC8wLqlXfc+1lKPYGyRMV4+1jk2B5VwKyJA49KkvZgcuS6bUZgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dnX3Im8B3eYYEGkKdnI8FqtRFyT++nvzU3scVwLh50ThnJ+caSrlewgKag?=
 =?iso-8859-1?Q?83uYmnibz7wYTauxjsFAwk/ZZsKCiH4nuap8jsmm3Fmzr6cXjCnVpMpI62?=
 =?iso-8859-1?Q?GhN/URX07EswsNbjEoKuUUtSu3ntIJUR8SoUussED1ai84nbFEsG97hjeJ?=
 =?iso-8859-1?Q?wJcES6pykl3wB4u6Kms/zGOSqG6EyaYu1auUeshVCJ6G934tgnOdcpO7wO?=
 =?iso-8859-1?Q?gfw00wntS5epgPghlXM8oiW98tYDGpxIj+l/hinsbnvELSiXeFAA+EP7U9?=
 =?iso-8859-1?Q?JTrbyzBGoEZhqttt3IeonZrPksbKB81KgIb81pWYazHk8LKi1GlRF4WcgY?=
 =?iso-8859-1?Q?5gYdDxGD5XmwlDcLRNwXaMtM3p1P/x1We2nz5CPz4TyOhLLp9Lbqa9Ii96?=
 =?iso-8859-1?Q?KuzXxS8RIxRPRNYVSEHnOCm7xQb69UQIgG0cCGHnhsRabmdhtmnf/W/Hsv?=
 =?iso-8859-1?Q?Yb3LoNkWpnL5d/c24cE/BNL6gBNZKqf6YryhZM5HbKl/HN2OGB+gAAx5Zs?=
 =?iso-8859-1?Q?wVJ8Y/3Fm0YkZoSI/hZCnTGpUjUrmULDycntnj8DmHiW9+6iaqDu3kF6+x?=
 =?iso-8859-1?Q?mR0V7kmkidN421tZvKjQWmyCAEAeaSQG1yN0lEv/UKB+sRxr21/LYJf0Kj?=
 =?iso-8859-1?Q?k7cW9BQwPY6rPSw03oE+s9ZKILMfHmKDtElzNz8FOAd2bRWhTLJngsXKuw?=
 =?iso-8859-1?Q?ac1a/7CA0M4j10kKnT+sVJhWZmyloQImH3+P1FMYBfdealy+OjPmlGy6d+?=
 =?iso-8859-1?Q?vsOhpLAqHSc5F2VRfZioMIBJmhGEOgTz1eEMAVPoSDFoHhaZ+azoUrpUYo?=
 =?iso-8859-1?Q?GwX7EFL8K+W3ga4wXzMUVTDyofB41uAoP1CMPa7sn8lqIEFM9CT2yX9BmD?=
 =?iso-8859-1?Q?RjFy/r30fyr3CD92Vpkqu9+eHdVGmyNwk9ddz6SjcVNu9utbaltafIaoH4?=
 =?iso-8859-1?Q?v7I2uy9ygwxqkzbXj7/2mM9Mr3hrPPgCOqikrL8cgvMiI87ukaGu6G56HH?=
 =?iso-8859-1?Q?uCp32Nz2euBJVbZ4HZ0bEcrtN13ZZ4iBmvTTn+W+KmDOysGF02kffaUk+R?=
 =?iso-8859-1?Q?t1ZHxC41L6f3a7tJeChKftunwt45OQre2tkUq/btcM2fYUpodvjIw8Wz0E?=
 =?iso-8859-1?Q?xHhHCD636rWfF4sdeBlwfloN6RKdWvHAYQvVDUrZY6Z9lQsELspbD38Efm?=
 =?iso-8859-1?Q?AOjH6h6WmxR8h8mtk8A49LZ50T5qwz6Ko8/M3WueVjxyEAlcmcniQDfjqy?=
 =?iso-8859-1?Q?oC9Lh1UMa0kMIN/5Ok2scB7ifnegGksXMEC4xvVvNiYyujIfGZaCn/a+AQ?=
 =?iso-8859-1?Q?RZNyXo6U6xLK19xdxqEaaG02C7/U8qEJatO1nNtMsGc1sdprEWmvn4zKVi?=
 =?iso-8859-1?Q?4rhRkLGYAiACbWLXu7+XHVrNOqY6qxRd/X7rEqDqrcVEWrMF8uZc5kdCvK?=
 =?iso-8859-1?Q?eTKc3uzPxEF3807/gKiJmrHW37C2xfE5nVqFb2mLoymfdTzqkw2NUMOiKU?=
 =?iso-8859-1?Q?3TjpbKCLzwSe1r6mEl/G3Ayaz4xLSO+/Y0IC6AQvj5pPVIeGoxGIaVkKn3?=
 =?iso-8859-1?Q?at2eIwnqdZiY5rG6EQlzFMk/yarASdXY8+kNS7OhEN4EEz2zjMPYzC+tCz?=
 =?iso-8859-1?Q?31Bu8ozxcOR0bxfEW5Uj6Xe64tvbKUYr1rGincEsJ6GBJoLPZnywWxuA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?nsH1Dh38pmDE6pnw7M9QkGS6UfoWU52yBcXJ1U4rE89RVqsMKK+EWRmf8A?=
 =?iso-8859-1?Q?BkdIN9MIl6u+HKhroHStuut0CGzdHEKkZEOi9D8TJDXcrtqO86OXSSFUE4?=
 =?iso-8859-1?Q?eYAgonaVhdB4oJwzdWj6XPJzWqT1sLjXRR1ehTtXnXl/SAjb+OdK1HUNW+?=
 =?iso-8859-1?Q?If69/YqsEJxWLelI2eb2+Hl0jizdNiN/4bXNjGbb+Bb+iNYvhlEHnJXcce?=
 =?iso-8859-1?Q?FHjMcKGkR5foueXEN2BhjjBLC7zI6b8wtRa9FgmbUn/mkD7LMH2FciSeuK?=
 =?iso-8859-1?Q?QmpATlbDVnXKD1W5vjcvqkuK26UIAh7oAGumZLBEqf3FxOekPM1ehjDkF9?=
 =?iso-8859-1?Q?8Lt//9mCuRtd0PZCPjF6KUxSyigVxVMTVoPz5HCSTWJcAOF5qZv4s1oZlI?=
 =?iso-8859-1?Q?JZEJbYRr+oywZwiz1poAoEyM4eJ6546JvE20Na2TF5PSzc6QBRf9uW1bnx?=
 =?iso-8859-1?Q?Sg5cGl4JugbIHM4yHK88uvzzX06VYdRVZoXfx+PwJ0UPlllNheKKoumPaM?=
 =?iso-8859-1?Q?YC182QfYM9Wr8O4mo5eHGXhEzPQdLbzdnFq2M9BMk1xNehfNUifzr7+t1K?=
 =?iso-8859-1?Q?/XEIuRw25gqWK8/V6xs2V+nStntNJIBBPUrqa6U/fmhMOXX/wekWQ4Bfzk?=
 =?iso-8859-1?Q?xKe9awyekaT/7BWNdFAhrYkuR6PMYiv2zHL6BCJqH0RoFecIqiwi5J0THs?=
 =?iso-8859-1?Q?gYDxDejfhhWBYuub3ZPo+5Ybl/5CzBOe0U0wb3MsoZyX6LMmPdkORWy2jd?=
 =?iso-8859-1?Q?vSN+lf8VU7pCP5iyuj9MEwak5evKydQ5hAJc9JDqvEgoby9GUsIud8rUxT?=
 =?iso-8859-1?Q?DET75RIe6xudOx6b82U7J0y9hhk3yYd3sgYt5ZZ1oXL3r6JfYqXBXob1Oa?=
 =?iso-8859-1?Q?wGF/p56C9H/nK/qGW9H0pM+QuQc/FFZUFy0wpOVuPiz8I5TCdxLpwerdhh?=
 =?iso-8859-1?Q?ot73AjgU59Q8BXoYTW1mkpuci9uxzvtakhwPbYaeva9jQgvKrv52vA=3D?=
 =?iso-8859-1?Q?=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c402420-eafe-4a97-6ade-08daf83351ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:11.6252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9RSzkMvLTalfRq7TZux+GLKxxhBN8ObIyl1ijR4tNSPSypsgqnSiIXmxSyw4XPfghU0DfDTN/I8IcZ7v8QHjmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: yXOBaWhdFaTLFJZBqvnT34pH18fXcRan
X-Proofpoint-ORIG-GUID: yXOBaWhdFaTLFJZBqvnT34pH18fXcRan
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

When mas_prev() does not find anything, set the state to MAS_NONE.

Handle the MAS_NONE in mas_find() like a MAS_START.

Reported-by: syzbot+502859d610c661e56545@syzkaller.appspotmail.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 03429149870c..667a4a46b024 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4855,7 +4855,7 @@ static inline void *mas_prev_entry(struct ma_state *m=
as, unsigned long min)
=20
 	if (mas->index < min) {
 		mas->index =3D mas->last =3D min;
-		mas_pause(mas);
+		mas->node =3D MAS_NONE;
 		return NULL;
 	}
 retry:
@@ -5924,6 +5924,7 @@ void *mas_prev(struct ma_state *mas, unsigned long mi=
n)
 	if (!mas->index) {
 		/* Nothing comes before 0 */
 		mas->last =3D 0;
+		mas->node =3D MAS_NONE;
 		return NULL;
 	}
=20
@@ -6014,6 +6015,9 @@ void *mas_find(struct ma_state *mas, unsigned long ma=
x)
 		mas->index =3D ++mas->last;
 	}
=20
+	if (unlikely(mas_is_none(mas)))
+		mas->node =3D MAS_START;
+
 	if (unlikely(mas_is_start(mas))) {
 		/* First run or continue */
 		void *entry;
--=20
2.35.1
