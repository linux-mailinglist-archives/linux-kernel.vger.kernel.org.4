Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694AF6E6E73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjDRVkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjDRVkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:40:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01FD619E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:40:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IEwvWx016686;
        Tue, 18 Apr 2023 21:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=rVQUbRYCYCAK3R9s8VgIjVN5P3qO0LJZnA4P1oAJaE4=;
 b=koU+ME2vUsV3nCJaBtKHewfP84PtvwEXOsdr5fGwzziMMDgEKfT8w09ZKleTK6pEWRpT
 mGNBXcbwQ8WTWCurGwtD1UqeRt0E7+Dq4OJ157d8Fipt6i+GeMji756YfoMZnzJb7eIE
 Ku9wy9JkiE539fQF2tx6ClJSlICrS6ZOjBpJUkKtJqI8jfLFQV6ncGL/wonfL7Jq/0XU
 eqZtJucudXLowgyNn+bWvVsWb+5sOt8NJ3saE/euKPJnorJigpt1asj9gzkdCbwxLOOy
 fhZu3zUj4gxOx5Ay6jKLJk6WuLnTfOmYAwdHXNPw6IFo5PAaXf5D4bN2rQS0yPZYBlE7 Jw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjq46vhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 21:40:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33IKhHJt011247;
        Tue, 18 Apr 2023 21:40:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc5mrbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 21:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbmVoN5OsoliETbDvt08mvHgyCmBtXvb2dHGWzerD4I2YPlylP0VxcAVcGGjeaKjorm6oOR6z/PVDz9v92jqAD4kGepLtFW0pjRZ6JutcDZS5cRzf5vQHLiGDaws7aA3GiauyF2Bmw8fobg/2swomyXsM233MogxXWjhzZbHhsSV2Svq6ExLLOGYveh1qhEC8m3NlFQr9HbPnCV2KQu0IDeILxFVl4NMcjI7MoWKXE3YjYPdvNYPbbn+52yRoQ8OlZo/1JQoT/U/hNQnp0S9eo5ketWFv0hvKzYx0SfX1xEBnI1cUqE9zWvZJ2hqlG82RZNcik5ONkb4wRTMiyEaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVQUbRYCYCAK3R9s8VgIjVN5P3qO0LJZnA4P1oAJaE4=;
 b=oC5PEq/vO9r+EQOZJOFllnhgGmXs/PI7pbSZ7P8a9R7cs0+FXAq0bIRnWv93oCl1yIZMOma+3OZ/rBtbXNP/6PWKwoFTClpBXHKIXhAK0bxVZG4AGlEkmXIpL89Pjk8GbPnkQlVJUfH6h9kWiTAXz8cZxVoiqvQoYuYoNd2BhCNXIDgExvwSj1v5LxjwIEeOb0yvCNmPTXILUCdr0KbH1AtEfnIJy2ZdtCNWa8U50SsgQqAn8O+Zz9g7+gEwF76uxGp9ZZ+tvjZ10I2iRNPWbxnwTerPpbb+5WxQwWJYqSYUP1kzJJelo9RbxUJRxvK47GUVzgU/GOz7maQlnZPZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVQUbRYCYCAK3R9s8VgIjVN5P3qO0LJZnA4P1oAJaE4=;
 b=gUlbVm76IB7+YzdRAyOPgCeDgM9OV+gsqHbQOSu+KagYKDMpjFJFT9NTXEXXKXDEYKXTzXXxs0zduBr/i4Jyc1sAsPltpTMnCCqX3Ov5rGUyO+fr/tVu0j8TnI7cHbevC3w9NSjt5qDaRsPviWkzcKtV9A/KC+fHQbpP5091uBU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4438.namprd10.prod.outlook.com (2603:10b6:510:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 21:40:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 21:40:13 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Liam Howlett <liam.howlett@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH] mm: move 'mmap_min_addr' logic from callers into vm_unmapped_area()
Date:   Tue, 18 Apr 2023 17:40:09 -0400
Message-Id: <20230418214009.1142926-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0463.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: 553dc5aa-97e6-49f4-c559-08db40557df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GudTBU6F1hiDuCP2DXImc1hQDscPPy87ftwC+bgINEupwp6ouTXSJxHoHJLYSst4WNpv927wRoKs+MB6fprBNHKvyZCgtrQ01e5SskDz6BRnjE7DtF8F6rRAhmu3u75aL6+cAzoz0GwC/RIMLXr7mGTlYYxLvNb3gxtKCf2AF2nQ8X06AmQbL4jdOvtsb/blhfB/bs3Wav7XJNTltyeiXP4Czgvo64R3ujRUFtkotE/Hk16tvS78u0nVtMp7F3MO4VKjsFiH9to+L0YWjSHqGD1YGmEyPpecJdL84NH0CkZG3NDNu/IzBA8BRcN7RE0B3Vs9TmAdbu4paH7co85Q0TM/T6AVpwDGtFT/BDsIMcVlcWHTYeIL/I0uS+XEJxP1EUKtVCWWb/6z4CvlbMDChKv5QAaknGJHneq6473Vcvz3g9Eroeyi7kOwrwDTp3jUxuxfIvHbbNyvGxyecBA09VUYxbqRGLY6BvVhBfgkAxhuKt0FDV9xppldpp+EH3dmenoGnn9d7lC9zOMjNmhnm+stkY/hNrSa8QhfkD9nqSkam+QFVeQjdLuwMXBiXcmE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(2616005)(6512007)(54906003)(26005)(107886003)(1076003)(6506007)(478600001)(186003)(66946007)(66476007)(66556008)(316002)(83380400001)(6486002)(6666004)(4326008)(6916009)(41300700001)(8676002)(8936002)(2906002)(5660300002)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yH5Llnleb16ypO2rUodDERkWehKadn+7Iif9OtBPwXwhdD19etQgprV9JZrF?=
 =?us-ascii?Q?2PEJIDihiBmX2NOjG8S17ep+eNseiKuL0asco1BoZ2zSbBOvctLYrvukOMbE?=
 =?us-ascii?Q?sTADO1CAq4otmdvB/RBZjsqpMDUc35MWYssmi3b1zwX64jvo3+Cl4y6oSMcZ?=
 =?us-ascii?Q?+TRw3uBmXBGNyXkP7iiPT9LhJfBKYoTWWquHemZGXQa4qKAg5hhr0nu/+TkG?=
 =?us-ascii?Q?vDj2rqJPjDcf2pIRwvIF+QwVWO2ng2HXDRMUHg+G22SZgcnxh7WlstChlnUX?=
 =?us-ascii?Q?KX32wNLhm2u5N/GOjqIyX7nR4NfGmiHdu6Z45ddcRTZpF/eYu1vHNRGf+keb?=
 =?us-ascii?Q?OdQGkAp97MTSW8O9NB4Uu+45S5/Qvu6wEzb2KOElmAfzijYmIOhCiAFHWD2G?=
 =?us-ascii?Q?jAr3c9h6Z8FGY2UgdNccRRQ5lTJOOo9rZTQSeO8elBsDfsD/s/o0OlShQIvE?=
 =?us-ascii?Q?v3wo1WW543Gle/EuwIZtbDV2UaDQoyCJSbPx10n+TlfloA9O4tWGA8Lfu1O1?=
 =?us-ascii?Q?wbUxRrL+w7ZVK6xVSQRCrHiwEFmZx0mpk9buaehGymhd9sExv/e83MQUeCrG?=
 =?us-ascii?Q?hhKUX7DeRISnyQicG+3Qy74nv+Jgg/0w81fM5znK1lx6FidwOATZoRRFKgvz?=
 =?us-ascii?Q?4lsq4u5LvXadlDUQV45Vu0Y9HsckOYdrauXBuEEgxXsc2Fz5VlbEDVXjF/Wu?=
 =?us-ascii?Q?AqCo0p+jjV8ivIE7MtfIymOGfo1MtTAbsl2RK8IvtEOOK54QHB67aN6T3t9r?=
 =?us-ascii?Q?DCS5Vck9+VsRRoqB7t/3k0dynqNcxEbxIkSop+y1Sd8nmC77U2MdbV1RsTbx?=
 =?us-ascii?Q?iQvUPFVwzHZmIzzN48Zuhcxtwv8SnaZCwfDZ9NGb9TnqFfGxGcF2FgXQ68g4?=
 =?us-ascii?Q?vyvYe6xmjSnAVu9wMEhGqtkQRwWAlPN2M3WlqAojwt3wGQEfO7A5hKUHprA8?=
 =?us-ascii?Q?kjBwq55dJED4iiUzv4U0JKrm7SYd5ecIS4VrLWBm+yvumRQqVFmoXpE5ScdV?=
 =?us-ascii?Q?xvuDwiBWAMXRoet4VoYPSfFoo3eTZkaNKtZsaiAx5LVzoeWppXH4rfIL5wbP?=
 =?us-ascii?Q?N9UFIVdiCE8MA0xHoDbOL+Hlb1+D2bWv2a16nFQoGBFEGzAQxIMVs7hzZt5d?=
 =?us-ascii?Q?ijrsPHzJQ2+NTcynP+UykyvxwpDFRspD6y9jALf6TGDAsY/L5p8BApJ4EXFy?=
 =?us-ascii?Q?OIEuO/uE6+mla1z2CSXiA8KNMSIXt9PtQxOUpSiFs3lTZ2saZxbpTbBUDKZf?=
 =?us-ascii?Q?W7vez50zTj1FR5mPRbIXDHkmL7u09AANxDDQptfC98WLGKVM2/uWvgZxZJap?=
 =?us-ascii?Q?kcFbCslbNJr68n+tHbUiFLIYogczoPFR/lQEXtArCX19EtRTspZEMSbTc+P4?=
 =?us-ascii?Q?7gLt0+Nt+4+Ag/c0gFF1GPBUDUgwExf51ZCKHK3sGC0pXybUgxqDkic3gZf8?=
 =?us-ascii?Q?FRU0dwZBE9IXQf1GnVfY6OvYL/EG4omIrlBV+eh3Ra2uUUP5mQLz/dPU/OxZ?=
 =?us-ascii?Q?2Q/Ri4dNxiV2wdi1YawM7HMBAb8KEucOQk5jQet6q41V0TbkKxeAXrUduwk/?=
 =?us-ascii?Q?KyK/h4OdhVMfRl9+QgNPgg/jYCiHcc0sc6tGtmK37SKUnd1CwuXOY+CfOPsG?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nPkSN+NVF8wz24Qn48WhXbJ43Y0ax0Jsvm8hnZ5WNntqHXpMDCT94W+9JRcc?=
 =?us-ascii?Q?MzhL7M+XJPJGjxJMFTqonVx0Ri3Bl/6bwM6qepEtAmz7BLU7FFkeRj4Y1qqG?=
 =?us-ascii?Q?gt32iPHp7mIv9a3OuiONfx/OiuY/KSwVKTFdIQAZ9Z53PUUILvflT5yy4gO5?=
 =?us-ascii?Q?tIySGQuKYL2ahw6l9p6NGxV0pj+MvZlW0nGoMZF9nU89lv1X4uXqfBRJDE25?=
 =?us-ascii?Q?q1CldAjz2NDu0xCb75f23LLBS5eBFA6h2rih39Xmbx7IaWzcld+J/KMrhym8?=
 =?us-ascii?Q?Fxd5gGHF4ygSBzyhk7pKfD7mMbv/GmwjtY6pVh6Wsga2Gb9M4kDY78msWqUI?=
 =?us-ascii?Q?u4b/qdf1UsA+yLlDYneo5WolCWOTmXqwCNjGItds/QyW2OoZrJH9cBGiq13b?=
 =?us-ascii?Q?GVcIYeX1NkvgrGWNFhrGBhTyACYtIJ9cSI3yGAjxmfRkDtj/KdzgAsL4RWSu?=
 =?us-ascii?Q?jVqspnYkTNRz4Q5XjkvZq7my34wn5/ZMQXECrgGlSB9bafwLbGs1BQu7xtjQ?=
 =?us-ascii?Q?ErnLgvXaG7XlYHQWKIUJ6lL4HyFOFpLBVrhJuQHq6zoVJ3rdD76KsBG4ZsO1?=
 =?us-ascii?Q?/7zvWYVZMeGMhKuAKtH5hCwRWkYGAUokcnpNarESDA+rRKsunu681O2c6oHj?=
 =?us-ascii?Q?T/weCgYqfO+8vJMrJSxrZtUuhUvIvEAMZBvvq5DZpgx44uIodHtUHX4F8ZrG?=
 =?us-ascii?Q?xnmFVfQJfDiCVX6r5i+H76ntnXavx+RqQiIgfTRZeNsRnpsxvlqxPMbT5Zfb?=
 =?us-ascii?Q?HeUjQLcHzvb70ZyAOGNX2PULO7DtorhLDFrMQKuol/46EFiexzekAoRd85V2?=
 =?us-ascii?Q?/X7cjDNRvK8350GiJg2qlmA1OQQbK7ldqBkQGfzRvA0eAZhm5y+0B57/7B4j?=
 =?us-ascii?Q?TiswOIp7rp9TdjlpAPjz5zJTox1zEdeypYhWzym877UZBj5v/3n6T5dTrcv8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553dc5aa-97e6-49f4-c559-08db40557df1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 21:40:13.5061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ba2+5l8z/QSGOhZv+ygzL2We4iDsUxTT1Vx44gyjyogrV/jBEzQMDPEU6j1Nb9TpaKCh2HYo9jCVli3O78CE/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4438
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_15,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=970 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180180
X-Proofpoint-GUID: tnXQ0znTzUNwuB8laneIozw5R6gh-FN4
X-Proofpoint-ORIG-GUID: tnXQ0znTzUNwuB8laneIozw5R6gh-FN4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

Instead of having callers care about the mmap_min_addr logic for the
lowest valid mapping address (and some of them getting it wrong), just
move the logic into vm_unmapped_area() itself.  One less thing for
various architecture cases (and generic helpers) to worry about.

We should really try to make much more of this be common code, but baby
steps..

Without this, vm_unmapped_area() could return an address below
mmap_min_addr (because some caller forgot about that).  That then causes
the mmap machinery to think it has found a workable address, but then
later security_mmap_addr(addr) is unhappy about it and the mmap()
returns with a nonsensical error (EPERM).

The proper action is to either return ENOMEM (if the virtual address
space is exhausted), or try to find another address (ie do a bottom-up
search for free addresses after the top-down one failed).

See commit 2afc745f3e30 ("mm: ensure get_unmapped_area() returns higher
address than mmap_min_addr"), which fixed this for one call site (the
generic arch_get_unmapped_area_topdown() fallback) but left other cases
alone.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/s390/mm/hugetlbpage.c |  2 +-
 arch/s390/mm/mmap.c        |  2 +-
 fs/hugetlbfs/inode.c       |  2 +-
 mm/mmap.c                  | 19 +++++++++++++------
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index c299a18273ff..c718f2a0de94 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -273,7 +273,7 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	info.low_limit = PAGE_SIZE;
 	info.high_limit = current->mm->mmap_base;
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 3327c47bc181..fc9a7dc26c5e 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -136,7 +136,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	info.low_limit = PAGE_SIZE;
 	info.high_limit = mm->mmap_base;
 	if (filp || (flags & MAP_SHARED))
 		info.align_mask = MMAP_ALIGN_MASK << PAGE_SHIFT;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 702d79639c0d..ecfdfb2529a3 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -208,7 +208,7 @@ hugetlb_get_unmapped_area_topdown(struct file *file, unsigned long addr,
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	info.low_limit = PAGE_SIZE;
 	info.high_limit = arch_get_mmap_base(addr, current->mm->mmap_base);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
diff --git a/mm/mmap.c b/mm/mmap.c
index 790cc62c0038..c0977a98a91c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1547,7 +1547,8 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
  */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	unsigned long length, gap, low_limit;
+	unsigned long length, gap;
+	unsigned long low_limit, high_limit;
 	struct vm_area_struct *tmp;
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
@@ -1558,8 +1559,11 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 		return -ENOMEM;
 
 	low_limit = info->low_limit;
+	if (low_limit < mmap_min_addr)
+		low_limit = mmap_min_addr;
+	high_limit = info->high_limit;
 retry:
-	if (mas_empty_area(&mas, low_limit, info->high_limit - 1, length))
+	if (mas_empty_area(&mas, low_limit, high_limit - 1, length))
 		return -ENOMEM;
 
 	gap = mas.index;
@@ -1595,7 +1599,8 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
  */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 {
-	unsigned long length, gap, high_limit, gap_end;
+	unsigned long length, gap, gap_end;
+	unsigned long low_limit, high_limit;
 	struct vm_area_struct *tmp;
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
@@ -1604,10 +1609,12 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	if (length < info->length)
 		return -ENOMEM;
 
+	low_limit = info->low_limit;
+	if (low_limit < mmap_min_addr)
+		low_limit = mmap_min_addr;
 	high_limit = info->high_limit;
 retry:
-	if (mas_empty_area_rev(&mas, info->low_limit, high_limit - 1,
-				length))
+	if (mas_empty_area_rev(&mas, low_limit, high_limit - 1, length))
 		return -ENOMEM;
 
 	gap = mas.last + 1 - info->length;
@@ -1742,7 +1749,7 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	info.low_limit = PAGE_SIZE;
 	info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
 	info.align_mask = 0;
 	info.align_offset = 0;
-- 
2.39.2

