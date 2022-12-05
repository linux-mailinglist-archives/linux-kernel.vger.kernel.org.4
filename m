Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF18642CF7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiLEQe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiLEQds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:33:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F219B1FCC2;
        Mon,  5 Dec 2022 08:33:33 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5FlDQl018571;
        Mon, 5 Dec 2022 16:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ESW/Yjf5FS3Id/vgv6YbnhM53BV7oX8cqgIBpuTM/+g=;
 b=eAPOTHRh7+u9UPebQAYjy22A0NWQLop4Fqh0A44O9UI13n+3FB9UcQjr9KLLrK/3J811
 jMZJhGYUGa5FvF6kgg2IR28JNW78V39EXEP7O0OHDUz5JwhYR0oSxtioPo/IgvfGuwyX
 0kPb3SudcAUnJJSYGreoej+gCsVv17LiBXpHG72NoLr7UX36vUozMKz+HKoRfPWRD3VW
 zTVr9f/lJdOLEIOwOYKojzWHBdSHDQxlR9Aavr0sUGdQ+xtrLU4ZxUtCQ69cmkCujm/U
 OsxjSudBGUU9XUA9tZpjHekCb4sHyTU6F0zaynLAOix6jhJQotfh7eV/VLqDSJvDA31y Vw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7yb3c9t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:33:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5GQu6r027839;
        Mon, 5 Dec 2022 16:33:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ua9dpwh-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjNfAk9Kupf/ZeWwMx91jpmCUjUTpQ7gESkzocHV0CCAPAnK7B1B8qqy3AlNCk//+vGkD2RV2Xo9G6s28eNsYtSVFfmilcEFlHoLfUrps3X5mVpcSJ6QHaOhgWXMvJ+CFdUBov1Ju8bpRVJ5BD1ajBHmVUDrfIjI93TaPMg8tUMyITeNNbWB2hr6tWXWigh5Jg5rgbzABbLP5sUwtOqDgvtcX2vFkPs6RH78p+dZcim4gBzBN34wvbZ8pjvHZFnR5xUYa5wNEKV+xy28nfg/+XWo1zaV95uhcBWK0IxHLgb2HM136Tf4LNoSZqHMmrxfY0q+zesPPpe0iRCkt70THw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESW/Yjf5FS3Id/vgv6YbnhM53BV7oX8cqgIBpuTM/+g=;
 b=jFMiviVceju27bD3fT3t4DaegeiNT6uH8OfqvlDNXmEeUGI3HWBzxghxudtoknuq1LhO/WwSJUV8Zhu3dR9ZYdfNMIVSHbewOHkHNMuah+CbmhZL27r+Xh+QAPfNmR+3pUwC4x3sIH3/+tozuduiUJDWc2loaYEppv0bCZye/NlOmkV6b0b6CFBG/IgbkEakRD7BEuJucIDBFP1R725AWS36ixoRbwYSw5qRVJdMNEvADG3q/rwHeb5y9HpvYirEtYLv8SDdQ2wDO/fbNW38r7RhFDXhq9KNYk3rh9ZaAT1tWT5SG6KNu1HYY2fNYGOV4QkcyK87ZXz3WOD9KO3PFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESW/Yjf5FS3Id/vgv6YbnhM53BV7oX8cqgIBpuTM/+g=;
 b=SSSzK9NA9QNfv8f3msbsE+Fsvj6gbBlXCpZmdURn2wh5npywv5NYszHZX/jYm3N3DtTuIaUTI2IN6DAGN+kAPZ7jyaBfQXfKqfOarddztj2VppxeJN/ARnQkdOZ9vnqaq6AC/yyJSWyagOOZITBt02NwXK2ZHj0q00GlJ5C2HP0=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB5721.namprd10.prod.outlook.com (2603:10b6:510:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 16:33:22 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 16:33:22 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v10 13/13] perf: proof-of-concept kallmodsyms support
Date:   Mon,  5 Dec 2022 16:31:57 +0000
Message-Id: <20221205163157.269335-14-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221205163157.269335-1-nick.alcock@oracle.com>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0042.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::30) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0de3a9-11cb-4d2b-ea31-08dad6de645c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ZuaS7o4syyHesY9W+rHAPGrYjaCwqvDaVWsyPDi2Xlgn89dA+K+q5ASNj/sg+MBICL1ND+XnCfcXXIPpGKHjv2x2gu8xB0dh+PackcGVnXgyGclztWEfJW/2tgnO/tYU/uehjyiRq40rSYg0le400H+9t5xwQ/v8ScN39e+CYzflU5jo8huyDg4sjrz4sglZ7QD+8heRRGpYMoQy+ha13HT4629y2+/Cy56ms//jsoenJr8/zvxBnY49vMsMeiLhVAHRtDsZ5uH4bS8aSYMBiHvbyD9/7O+uIsOzbq6Sb5HzutfrDDE28NCmW2qpLxJ8ARkOZypOlWaNQxm5hqW9+l3onujD+ujIMGwGTsyhSnICZNu6OqTmGcOFUJA2CD6gNeiBaFaTpiHghCQNEpQFCH0TAqeRw9vD7uI8wqWNfPN5pQY0hS3VfVDCTi5s1MRxzKjJgOT7f8kVL3bFQWKPwQBdg1MRCoNwcPPJ9TLZXek2N2H1b3MwjW0nZ85ZQ5p41VWhOlVk2TAbegbhXUT//Bz/3nfQtD59kX/4lAK/n/YhGCFp5ZXpHMla75AZ/SHB4qcbyt2HrrTmmZhMSl+JUPxPozP0eJWUojinuzuS6Djx0dMpIxpeD7aEMkKM8/J2LAr2vAQHEXly6TfrGClug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(316002)(6486002)(107886003)(478600001)(6666004)(6506007)(6512007)(66946007)(8676002)(4326008)(66476007)(66556008)(83380400001)(30864003)(8936002)(5660300002)(44832011)(186003)(41300700001)(2906002)(1076003)(36756003)(2616005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zfAlLWfbaAxtYmzNagh/Bdxp9Wm8MJhbsFKE7ArTvKJRN/Dko06dq4/vhgn/?=
 =?us-ascii?Q?iVxn0/1Sh1qAheQo41mMby1bwByL1UFlhIY1cMfoahZFoEIl/jue9k2CEhRT?=
 =?us-ascii?Q?PLfk6CK9TnS8mJ3MB8GQbRNduY9jSSBcMdP7pit+6rOcnB8qYW0A0O+UB40r?=
 =?us-ascii?Q?JY9PYXsuARGFDhB/RXQaMPsMvUeGK9tqTMoCZbkWD0exU4v5kdRbdbdpMchd?=
 =?us-ascii?Q?dGClLQCMvDBF+s6WbinnJhtaA3ASQxOvcoMZFX6gs+kUpDh0Qy+Qd7EMcJSL?=
 =?us-ascii?Q?mXurMGAalJNVBgstJqiUm0X3pNnUhRNUYwW/tQcbmS70q0P8TTmZkhfP53NM?=
 =?us-ascii?Q?61FkgkugnEVV15405k+OsB89/wcvivvBxG+HeBtNLKlaFM9VZf+Jd5dgUQIi?=
 =?us-ascii?Q?TX8Y//WdwFYnk82Nrxlh2jOzu8CPOMY0ei1shJSUQhaXYnnX9LnZUwzcutum?=
 =?us-ascii?Q?Ta0h6UEjEM+sBU0RMcFNDgQKcpHCD2sIaT4I2VIdUIOCqUypy6Wwua/ygXRw?=
 =?us-ascii?Q?DAnL6NL0YwsGaLepuMJsuiSvtOFTXrerx8EIGRk89+X/2x+h/Rc5ol61cXcM?=
 =?us-ascii?Q?hiobR2d5YSPeZna0H2ev3VFNklkCE9/NkBOWZkP0ThhnQ86YYa1rUyJKJq5u?=
 =?us-ascii?Q?0HU3052hN4CKoaPTpa6bX/5PlRV7fRXBbBFkgE8aB3fIH4QoB7vPPNFWIvdy?=
 =?us-ascii?Q?iv1i2CTTF3dtRi1p+I0vvbAG/xBpspswVOyYQg4tjgxJCZNJGE7eLbSFW+wF?=
 =?us-ascii?Q?e2U0xlKXvxX6KHW+5qwG24SfuDJxVsbU7zwm3ArGs8hypdVQm1/i75Fk7v95?=
 =?us-ascii?Q?SatBWspnhO+AIHZ8jeLh8rvotWzk2xWMlWEatjhZu30awybaMDNbRHV4HnP5?=
 =?us-ascii?Q?Q275izz2TRBMBnLKk2FWGJcz2tEyWtL0FGW5cnJSDcFs42S7cTjlu1G/+vXY?=
 =?us-ascii?Q?bW6hrgmVmOvYn9pFhU+E+5UeWCwSVX4O782emiBuSXET/j+c1HSA1GiR0xHl?=
 =?us-ascii?Q?kb3dgRdik3TOyeYZjju0J1oxsE02t1brhY5tGZaUmUj2FdGzY+dR0RhkOkh0?=
 =?us-ascii?Q?6ELoBuNbS1iCl5GbswOleX5ciXI1oPulmi6KfhRX05xPKFreUNrUwmAzkSCR?=
 =?us-ascii?Q?h9KHlRpLcE6FpBSkzwcniTXkW/96qNLYjnHUyO4FwvSOTbHOsrEmmQDxhTgK?=
 =?us-ascii?Q?gP8ynN7UNm3Grp2A8wlp+V2TRmiTj61mnbdK2vqLLq0qFBNHMX+K5KbNmRtY?=
 =?us-ascii?Q?6CJ8GEQX+m20S80Wlk8fGgmei09EoJ4W8ZvwxaEN7B2FvMAS1xmM680vr8lc?=
 =?us-ascii?Q?2/2JjJS8mmyTQAfZKSFkmXdEhSME1Uc1rpahNwbkNS0fTScyT1b/Vu1O2Vnm?=
 =?us-ascii?Q?exRQlU2Qiy1X3q5s7KqqnGzl2mdAKOiv0Zy7f8F3F22Ns85S0Kb3XQEgOQtK?=
 =?us-ascii?Q?+qcL459vgr0XhZ9m4RlZ+dGGQytlk7D3yuvPxvc7WNjUtBwna8e1SlQCsL6S?=
 =?us-ascii?Q?mniJjygy+ztw/3YXt4iPjnCHZmx88QZ69qQyZJI58ltLsBH5IsXhL2h3Imld?=
 =?us-ascii?Q?5Subrl5WCdajBAP6ejcVWKLh1w+67rni1ipcSDAr/gPtV2Lt9skyrDqiJrEe?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ics5MmndpIwnwPzKQZiirv4Z0rQ5DsKeULBKMnlk4DFz/X4ksG8kyPex9EW5?=
 =?us-ascii?Q?PtFUPf7IOtANWvKevc/auMi4/lQppUBJwWdm2CcyTlkSVHMgsLQjzmH7nHVm?=
 =?us-ascii?Q?ShQpRk97Nqgbn3o1IqaoIFnrHVAXOQQblEN1PRA55JV0TMN9cfFb02FYMpz8?=
 =?us-ascii?Q?ZA6S5DFywhbuh+LSsUohr7jgAVztUUsluv5nIyhEzCWIkQvLzQQdd22IDfkC?=
 =?us-ascii?Q?CqL4PcCjtpVj9/GB4b77SmuCc0Q37KLQrNf4PqkjBxLw+gXrEr6Zyzd7DNGA?=
 =?us-ascii?Q?fzP4QP75AYLaUXu0tpgoClkEbMkp+5pKgLH3rwDmq9mOS17vvALBM6aMBOQS?=
 =?us-ascii?Q?fjc+i9+h7ADqVe1I1DKdDrn8UEflwWgPhCmRRFKAkhyjW5wGkf0rJ4UULM2Q?=
 =?us-ascii?Q?62rvx5DPHYunBUNJujiBXEBt3h9oqXrrKNkoPfFSv6O1IJZvy+4cvXKbhhII?=
 =?us-ascii?Q?+EMdAYybEy/NW4b6whSmskOmpfb4SS1MWb3p7bTeWqhAWOt44hEl/YGiSe0c?=
 =?us-ascii?Q?F/g3kU4h+EIu7UhlEHvO1X6hDpQiS2TmcOciRLWf72JqxGcvbYYErbuuCfpo?=
 =?us-ascii?Q?7WyJm4ploDjalF/C4HMuKE8Z8AeHdTfvS1h6QhCsViC4T/1zbHwWk2QU3p8e?=
 =?us-ascii?Q?QOn36yDzVm+X6xXfBkWDTkLS+ndHJZDq8AP7Iq66eNneM3VwN4A9aiygfK4Z?=
 =?us-ascii?Q?G/aP4ZUBgP52wAr8ZY2wWall8UA256BXJawqV5aY2FgtOhySz3gKqhh5JmZi?=
 =?us-ascii?Q?Ny2kUoan2i7v4zB3gY3CZ4PSW9Tiytz/BHppU5m2YbYbHKLEREfXl0lI/hYL?=
 =?us-ascii?Q?TpexWAJweXNDkQooJRtOShcO7/+ZdtHmbwx9DKe0bWwOb2w8l12PZfhcNdKe?=
 =?us-ascii?Q?Z/d+LTc4N8luBqbDyJqqmE+fgmWXHNFDHOJ5uTzufmlMGKcEE6+UawKnlZJ2?=
 =?us-ascii?Q?mbVbJI1ABin1cbxHj/YuJaPApa0ln5OsMBRg3kBcsls=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0de3a9-11cb-4d2b-ea31-08dad6de645c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:33:08.3116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jebo8q5r+1vTGHZIDr9cRTWJZHpNJCtsF+hPETuEBYH6QNwwOcpECmsXmOdqQA7z3tHckr6yJiGk/RgiWb4kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050138
X-Proofpoint-ORIG-GUID: POZJEwmWLamAmJDwRH2CSvf4nERC9JKn
X-Proofpoint-GUID: POZJEwmWLamAmJDwRH2CSvf4nERC9JKn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is only very partial: it adds support to 'perf kallsyms', allowing
you to say, e.g.

% ./perf kallsyms __scsi_device_lookup
__scsi_device_lookup: scsi_mod (built-in) 0xffffffff9b901de0-0xffffffff9b901e30 (0xffffffff9b901de0-0xffffffff9b901e30)

and get told that this is in a built-in module.  We also handle symbols
that are in multiple modules at once:

% ./perf kallsyms lio_set_fecparam
lio_set_fecparam: liquidio, liquidio_vf (built-in) 0xffffffff9b934da0-0xffffffff9b934e10 (0xffffffff9b934da0-0xffffffff9b934e10)

We do this the simplistic way, by augmenting symbols with a module array
field, the members of which are atoms in a new machine.modules red-black
tree (structured the same, and managed with the same code, as the
existing transient tree that is used to compare /proc/modules against
each other).

kallsyms symbols no longer carry a [module name] around with them that
needs cutting off whenever it's used (all users that relied on this
adjusted, I hope) but instead have that name hived off into the
per-symbol module array, with a new 'built_in' field to tell users
whether this is a built-in module or not.  Since we cannot use the
presence of '[' to detect modules any more, we do it at kallmodsyms read
time by spotting _end and considering it to denote the end of the core
kernel and the start of the modular range.  (I *think* this works on all
arches.)

Full perf support probably requires syntactic additions to let you
specify (and show) translation unit names to disambiguate symbols
as needed. I'd implement this but I'm not sure what syntax people would
prefer... whatever the syntax is should probably be shared with ftrace
and friends as well, and maybe even the kernel oops backtrace printer.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v10: Mention in the commit log the need for syntactic enhancements
         to fully use kallmodsyms to disambiguate symbols.

 tools/perf/builtin-kallsyms.c |  35 +++++-
 tools/perf/util/event.c       |  14 ++-
 tools/perf/util/machine.c     |   6 +-
 tools/perf/util/machine.h     |   1 +
 tools/perf/util/symbol.c      | 207 +++++++++++++++++++++++++---------
 tools/perf/util/symbol.h      |  12 +-
 6 files changed, 211 insertions(+), 64 deletions(-)

diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
index c08ee81529e8..6bcec2522d2d 100644
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -35,10 +35,37 @@ static int __cmd_kallsyms(int argc, const char **argv)
 			continue;
 		}
 
-		printf("%s: %s %s %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "-%#" PRIx64")\n",
-			symbol->name, map->dso->short_name, map->dso->long_name,
-			map->unmap_ip(map, symbol->start), map->unmap_ip(map, symbol->end),
-			symbol->start, symbol->end);
+		if (!symbol->modules) {
+			printf("%s: %s %s %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "-%#" PRIx64")\n",
+			       symbol->name, map->dso->short_name, map->dso->long_name,
+			       map->unmap_ip(map, symbol->start), map->unmap_ip(map, symbol->end),
+			       symbol->start, symbol->end);
+		} else {
+			if (!symbol->built_in)
+				printf("%s: %s %s %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "-%#" PRIx64")\n",
+				       symbol->name, map->dso->short_name, map->dso->long_name,
+				       map->unmap_ip(map, symbol->start), map->unmap_ip(map, symbol->end),
+				       symbol->start, symbol->end);
+			else if (symbol->modules[1] == 0)
+				printf("%s: %s (built-in) %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "-%#" PRIx64")\n",
+				       symbol->name, symbol->modules[0], map->unmap_ip(map, symbol->start),
+				       map->unmap_ip(map, symbol->end), symbol->start, symbol->end);
+			else { /* Symbol in multiple modules at once  */
+				char **mod;
+
+				printf("%s: ", symbol->name);
+
+				for (mod = symbol->modules; *mod; mod++) {
+					if (mod != symbol->modules)
+						printf(", ");
+					printf("%s", *mod);
+				}
+
+				printf (" (built-in) %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "-%#" PRIx64")\n",
+				       map->unmap_ip(map, symbol->start), map->unmap_ip(map, symbol->end),
+					symbol->start, symbol->end);
+			}
+		}
 	}
 
 	machine__delete(machine);
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 1fa14598b916..a344b35f7e38 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -97,16 +97,28 @@ static int find_symbol_cb(void *arg, const char *name, char type,
 			  u64 start)
 {
 	struct process_symbol_args *args = arg;
+	char *chop, *tmp_alloc = NULL;
+	const char *tmp = name;
+
+	if ((chop = strchr(name, '\t')) != NULL) {
+		tmp_alloc = strndup(name, name - chop);
+		if (tmp_alloc == NULL)
+			return -ENOMEM;
+		tmp = tmp_alloc;
+	}
 
 	/*
 	 * Must be a function or at least an alias, as in PARISC64, where "_text" is
 	 * an 'A' to the same address as "_stext".
 	 */
 	if (!(kallsyms__is_function(type) ||
-	      type == 'A') || strcmp(name, args->name))
+	      type == 'A') || strcmp(tmp, args->name)) {
+		free(tmp_alloc);
 		return 0;
+	}
 
 	args->start = start;
+	free(tmp_alloc);
 	return 1;
 }
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 76316e459c3d..2be5a3c1a267 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -173,7 +173,7 @@ struct machine *machine__new_kallsyms(void)
 	 *    ask for not using the kcore parsing code, once this one is fixed
 	 *    to create a map per module.
 	 */
-	if (machine && machine__load_kallsyms(machine, "/proc/kallsyms") <= 0) {
+	if (machine && machine__load_kallsyms(machine, "/proc/kallmodsyms") <= 0) {
 		machine__delete(machine);
 		machine = NULL;
 	}
@@ -237,6 +237,7 @@ void machine__exit(struct machine *machine)
 	zfree(&machine->mmap_name);
 	zfree(&machine->current_tid);
 	zfree(&machine->kallsyms_filename);
+	modules__delete_modules(&machine->modules);
 
 	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads *threads = &machine->threads[i];
@@ -1410,7 +1411,8 @@ int machines__create_kernel_maps(struct machines *machines, pid_t pid)
 int machine__load_kallsyms(struct machine *machine, const char *filename)
 {
 	struct map *map = machine__kernel_map(machine);
-	int ret = __dso__load_kallsyms(map->dso, filename, map, true);
+	int ret = __dso__load_kallsyms(map->dso, filename, map, &machine->modules,
+				       true);
 
 	if (ret > 0) {
 		dso__set_loaded(map->dso);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 74935dfaa937..393063840cd1 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -55,6 +55,7 @@ struct machine {
 	struct dsos	  dsos;
 	struct maps	  *kmaps;
 	struct map	  *vmlinux_map;
+	struct rb_root	  modules;
 	u64		  kernel_start;
 	pid_t		  *current_tid;
 	size_t		  current_tid_sz;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a3a165ae933a..aab7ffdd0573 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -41,10 +41,16 @@
 #include <symbol/kallsyms.h>
 #include <sys/utsname.h>
 
-static int dso__load_kernel_sym(struct dso *dso, struct map *map);
+static int dso__load_kernel_sym(struct dso *dso, struct map *map,
+				struct rb_root *modules);
 static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
 static bool symbol__is_idle(const char *name);
 
+static int read_proc_modules(const char *filename, struct rb_root *modules);
+static struct module_info *find_module(const char *name,
+				       struct rb_root *modules);
+static void add_module(struct module_info *mi, struct rb_root *modules);
+
 int vmlinux_path__nr_entries;
 char **vmlinux_path;
 
@@ -85,6 +91,12 @@ static enum dso_binary_type binary_type_symtab[] = {
 
 #define DSO_BINARY_TYPE__SYMTAB_CNT ARRAY_SIZE(binary_type_symtab)
 
+struct module_info {
+	struct rb_node rb_node;
+	char *name;
+	u64 start;
+};
+
 static bool symbol_type__filter(char symbol_type)
 {
 	symbol_type = toupper(symbol_type);
@@ -234,15 +246,10 @@ void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
 		 * kernel text segment and beginning of first module's text
 		 * segment is very big.  Therefore do not fill this gap and do
 		 * not assign it to the kernel dso map (kallsyms).
-		 *
-		 * In kallsyms, it determines module symbols using '[' character
-		 * like in:
-		 *   ffffffffc1937000 T hdmi_driver_init  [snd_hda_codec_hdmi]
 		 */
 		if (prev->end == prev->start) {
 			/* Last kernel/module symbol mapped to end of page */
-			if (is_kallsyms && (!strchr(prev->name, '[') !=
-					    !strchr(curr->name, '[')))
+			if (is_kallsyms && prev->built_in != curr->built_in)
 				prev->end = roundup(prev->end + 4096, 4096);
 			else
 				prev->end = curr->start;
@@ -301,6 +308,8 @@ struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *
 	sym->type    = type;
 	sym->binding = binding;
 	sym->namelen = namelen - 1;
+	sym->modules  = NULL;
+	sym->built_in = 0;
 
 	pr_debug4("%s: %s %#" PRIx64 "-%#" PRIx64 "\n",
 		  __func__, name, start, sym->end);
@@ -318,6 +327,7 @@ void symbol__delete(struct symbol *sym)
 			annotation__exit(notes);
 		}
 	}
+	free(sym->modules);
 	free(((void *)sym) - symbol_conf.priv_size);
 }
 
@@ -716,12 +726,37 @@ static bool symbol__is_idle(const char *name)
 	return strlist__has_entry(idle_symbols_list, name);
 }
 
-static int map__process_kallsym_symbol(void *arg, const char *name,
+struct process_kallsym_symbol_arg {
+	struct dso *dso;
+	struct rb_root *modules;
+	int seen_end;
+};
+
+static int map__process_kallsym_symbol(void *arg_, const char *name,
 				       char type, u64 start)
 {
 	struct symbol *sym;
-	struct dso *dso = arg;
+	struct process_kallsym_symbol_arg *arg = arg_;
+	struct dso *dso = arg->dso;
 	struct rb_root_cached *root = &dso->symbols;
+	struct rb_root *modules = arg->modules;
+	char *module;
+	const char *modulep;
+	int counting = 1;
+	size_t nmods = 0;
+	char **mods = NULL;
+	char **modp = NULL;
+
+	/*
+	 * Split off the modules part.
+	 */
+	if ((module = strchr(name, '\t')) != NULL) {
+		*module = 0;
+		module++;
+	}
+
+	if (strcmp(name, "_end") == 0)
+		arg->seen_end = 1;
 
 	if (!symbol_type__filter(type))
 		return 0;
@@ -731,18 +766,88 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 		return 0;
 
 	/*
-	 * module symbols are not sorted so we add all
-	 * symbols, setting length to 0, and rely on
-	 * symbols__fixup_end() to fix it up.
+	 * non-builtin module symbols are not sorted so we add all symbols,
+	 * setting length to 0, and rely on symbols__fixup_end() to fix it up.
 	 */
 	sym = symbol__new(start, 0, kallsyms2elf_binding(type), kallsyms2elf_type(type), name);
 	if (sym == NULL)
 		return -ENOMEM;
+
+	sym->built_in = !arg->seen_end;
+
+	/*
+	 * Pass over the modules list twice: once to count the number of
+	 * modules this symbol is part of and allocate an array to store their
+	 * names, then again to fill it out.
+	 *
+	 * Arguably inefficient, due to one allocation per built-in symbol, even
+	 * though many symbols will have the same mods array.  In practice,
+	 * it's just too small a waste to matter.  The module names are pointers
+	 * into the machine->modules rb-tree (lazily populated here).
+	 */
+
+fill:
+	modulep = module;
+	while (modulep && (modulep = strchr(modulep, '[')) != NULL) {
+		struct module_info *mi;
+		const char *end_bra = strchr(modulep, ']');
+
+		modulep++;
+		if (end_bra == NULL || end_bra <= modulep)
+			continue;
+
+		if (counting) {
+			nmods++;
+			continue;
+		}
+
+		/*
+		 * Fill-out phase.
+		 */
+
+		*modp = strndup(modulep, end_bra - modulep);
+		if (*modp == NULL) {
+			free(mods);
+			return -ENOMEM;
+		}
+
+		mi = find_module(*modp, modules);
+		if (!mi) {
+			mi = zalloc(sizeof(struct module_info));
+
+			if (!mi) {
+				free (mods);
+				free (*modp);
+				return -ENOMEM;
+			}
+			mi->name = *modp;
+		}
+		else {
+			free(*modp);
+			*modp = mi->name;
+		}
+
+		modp++;
+	}
+
+	if (counting && nmods > 0) {
+		mods = calloc(nmods + 1, sizeof (char *));
+		if (mods == NULL)
+			return -ENOMEM;
+		modp = mods;
+
+		counting = 0;
+		goto fill;
+	}
+
+	sym->modules = mods;
+
 	/*
 	 * We will pass the symbols to the filter later, in
-	 * map__split_kallsyms, when we have split the maps per module
+	 * map__split_kallsyms, when we have split the maps per
+	 * (non-built-in) module
 	 */
-	__symbols__insert(root, sym, !strchr(name, '['));
+	__symbols__insert(root, sym, !arg->seen_end);
 
 	return 0;
 }
@@ -752,9 +857,11 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
  * so that we can in the next step set the symbol ->end address and then
  * call kernel_maps__split_kallsyms.
  */
-static int dso__load_all_kallsyms(struct dso *dso, const char *filename)
+static int dso__load_all_kallsyms(struct dso *dso, const char *filename,
+	struct rb_root *modules)
 {
-	return kallsyms__parse(filename, dso, map__process_kallsym_symbol);
+	struct process_kallsym_symbol_arg arg = {dso, modules, 0};
+	return kallsyms__parse(filename, &arg, map__process_kallsym_symbol);
 }
 
 static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
@@ -766,22 +873,14 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	struct rb_root_cached *root = &dso->symbols;
 	struct rb_node *next = rb_first_cached(root);
 
-	if (!kmaps)
-		return -1;
-
 	*root = RB_ROOT_CACHED;
 
 	while (next) {
-		char *module;
-
 		pos = rb_entry(next, struct symbol, rb_node);
 		next = rb_next(&pos->rb_node);
 
 		rb_erase_cached(&pos->rb_node, &old_root);
 		RB_CLEAR_NODE(&pos->rb_node);
-		module = strchr(pos->name, '\t');
-		if (module)
-			*module = '\0';
 
 		curr_map = maps__find(kmaps, pos->start);
 
@@ -830,19 +929,19 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	x86_64 = machine__is(machine, "x86_64");
 
 	while (next) {
-		char *module;
-
 		pos = rb_entry(next, struct symbol, rb_node);
 		next = rb_next(&pos->rb_node);
 
-		module = strchr(pos->name, '\t');
-		if (module) {
+		if (!pos->built_in && pos->modules) {
 			if (!symbol_conf.use_modules)
 				goto discard_symbol;
 
-			*module++ = '\0';
-
-			if (strcmp(curr_map->dso->short_name, module)) {
+			/*
+			 * Non-built-in symbols can only be in one module at
+			 * once.
+			 */
+			assert(pos->modules[1] == NULL);
+			if (strcmp(curr_map->dso->short_name, pos->modules[0])) {
 				if (curr_map != initial_map &&
 				    dso->kernel == DSO_SPACE__KERNEL_GUEST &&
 				    machine__is_default_guest(machine)) {
@@ -856,12 +955,12 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 					dso__set_loaded(curr_map->dso);
 				}
 
-				curr_map = maps__find_by_name(kmaps, module);
+				curr_map = maps__find_by_name(kmaps, pos->modules[0]);
 				if (curr_map == NULL) {
 					pr_debug("%s/proc/{kallsyms,modules} "
 					         "inconsistency while looking "
 						 "for \"%s\" module!\n",
-						 machine->root_dir, module);
+						 machine->root_dir, pos->modules[0]);
 					curr_map = initial_map;
 					goto discard_symbol;
 				}
@@ -971,12 +1070,6 @@ bool symbol__restricted_filename(const char *filename,
 	return restricted;
 }
 
-struct module_info {
-	struct rb_node rb_node;
-	char *name;
-	u64 start;
-};
-
 static void add_module(struct module_info *mi, struct rb_root *modules)
 {
 	struct rb_node **p = &modules->rb_node;
@@ -995,7 +1088,7 @@ static void add_module(struct module_info *mi, struct rb_root *modules)
 	rb_insert_color(&mi->rb_node, modules);
 }
 
-static void delete_modules(struct rb_root *modules)
+void modules__delete_modules(struct rb_root *modules)
 {
 	struct module_info *mi;
 	struct rb_node *next = rb_first(modules);
@@ -1060,7 +1153,7 @@ static int read_proc_modules(const char *filename, struct rb_root *modules)
 		return -1;
 
 	if (modules__parse(filename, modules, __read_proc_modules)) {
-		delete_modules(modules);
+		modules__delete_modules(modules);
 		return -1;
 	}
 
@@ -1101,9 +1194,9 @@ int compare_proc_modules(const char *from, const char *to)
 	if (!from_node && !to_node)
 		ret = 0;
 
-	delete_modules(&to_modules);
+	modules__delete_modules(&to_modules);
 out_delete_from:
-	delete_modules(&from_modules);
+	modules__delete_modules(&from_modules);
 
 	return ret;
 }
@@ -1133,7 +1226,7 @@ static int do_validate_kcore_modules(const char *filename, struct maps *kmaps)
 		}
 	}
 out:
-	delete_modules(&modules);
+	modules__delete_modules(&modules);
 	return err;
 }
 
@@ -1467,18 +1560,20 @@ static int kallsyms__delta(struct kmap *kmap, const char *filename, u64 *delta)
 }
 
 int __dso__load_kallsyms(struct dso *dso, const char *filename,
-			 struct map *map, bool no_kcore)
+			 struct map *map, struct rb_root *modules,
+			 bool no_kcore)
 {
 	struct kmap *kmap = map__kmap(map);
 	u64 delta = 0;
 
-	if (symbol__restricted_filename(filename, "/proc/kallsyms"))
+	if (symbol__restricted_filename(filename, "/proc/kallsyms") &&
+	    symbol__restricted_filename(filename, "/proc/kallmodsyms"))
 		return -1;
 
 	if (!kmap || !kmap->kmaps)
 		return -1;
 
-	if (dso__load_all_kallsyms(dso, filename) < 0)
+	if (dso__load_all_kallsyms(dso, filename, modules) < 0)
 		return -1;
 
 	if (kallsyms__delta(kmap, filename, &delta))
@@ -1499,9 +1594,9 @@ int __dso__load_kallsyms(struct dso *dso, const char *filename,
 }
 
 int dso__load_kallsyms(struct dso *dso, const char *filename,
-		       struct map *map)
+		       struct map *map, struct rb_root *modules)
 {
-	return __dso__load_kallsyms(dso, filename, map, false);
+	return __dso__load_kallsyms(dso, filename, map, modules, false);
 }
 
 static int dso__load_perf_map(const char *map_path, struct dso *dso)
@@ -1814,12 +1909,13 @@ int dso__load(struct dso *dso, struct map *map)
 		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
 
 	if (dso->kernel && !kmod) {
+		machine = map__kmaps(map)->machine;
+
 		if (dso->kernel == DSO_SPACE__KERNEL)
-			ret = dso__load_kernel_sym(dso, map);
+			ret = dso__load_kernel_sym(dso, map, &machine->modules);
 		else if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
 			ret = dso__load_guest_kernel_sym(dso, map);
 
-		machine = map__kmaps(map)->machine;
 		if (machine__is(machine, "x86_64"))
 			machine__map_x86_64_entry_trampolines(machine, dso);
 		goto out;
@@ -2220,7 +2316,8 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 	return strdup(path);
 }
 
-static int dso__load_kernel_sym(struct dso *dso, struct map *map)
+static int dso__load_kernel_sym(struct dso *dso, struct map *map,
+				struct rb_root *modules)
 {
 	int err;
 	const char *kallsyms_filename = NULL;
@@ -2282,7 +2379,7 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 	kallsyms_filename = kallsyms_allocated_filename;
 
 do_kallsyms:
-	err = dso__load_kallsyms(dso, kallsyms_filename, map);
+	err = dso__load_kallsyms(dso, kallsyms_filename, map, modules);
 	if (err > 0)
 		pr_debug("Using %s for symbols\n", kallsyms_filename);
 	free(kallsyms_allocated_filename);
@@ -2323,11 +2420,11 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map)
 		if (!kallsyms_filename)
 			return -1;
 	} else {
-		sprintf(path, "%s/proc/kallsyms", machine->root_dir);
+		sprintf(path, "%s/proc/kallmodsyms", machine->root_dir);
 		kallsyms_filename = path;
 	}
 
-	err = dso__load_kallsyms(dso, kallsyms_filename, map);
+	err = dso__load_kallsyms(dso, kallsyms_filename, map, &machine->modules);
 	if (err > 0)
 		pr_debug("Using %s for symbols\n", kallsyms_filename);
 	if (err > 0 && !dso__is_kcore(dso)) {
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 0b893dcc8ea6..9ca218e09acf 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -66,6 +66,11 @@ struct symbol {
 	u8		annotate2:1;
 	/** Architecture specific. Unused except on PPC where it holds st_other. */
 	u8		arch_sym;
+	/** Null-terminated array of pointers to names of containing modules in the
+	    modules red-black tree.  May be NULL for none.  */
+	char		**modules;
+	/** Set if this symbol is built in to the core kernel.  */
+	int		built_in;
 	/** The name of length namelen associated with the symbol. */
 	char		name[];
 };
@@ -137,8 +142,9 @@ int dso__load_vmlinux(struct dso *dso, struct map *map,
 		      const char *vmlinux, bool vmlinux_allocated);
 int dso__load_vmlinux_path(struct dso *dso, struct map *map);
 int __dso__load_kallsyms(struct dso *dso, const char *filename, struct map *map,
-			 bool no_kcore);
-int dso__load_kallsyms(struct dso *dso, const char *filename, struct map *map);
+			 struct rb_root *modules, bool no_kcore);
+int dso__load_kallsyms(struct dso *dso, const char *filename, struct map *map,
+		       struct rb_root *modules);
 
 void dso__insert_symbol(struct dso *dso,
 			struct symbol *sym);
@@ -161,6 +167,8 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid);
 int modules__parse(const char *filename, void *arg,
 		   int (*process_module)(void *arg, const char *name,
 					 u64 start, u64 size));
+void modules__delete_modules(struct rb_root *modules);
+
 int filename__read_debuglink(const char *filename, char *debuglink,
 			     size_t size);
 
-- 
2.38.0.266.g481848f278

