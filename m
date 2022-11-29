Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E23963CB33
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbiK2WvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbiK2WvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:51:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3CD70DED
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:51:11 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATMDe6p030080;
        Tue, 29 Nov 2022 22:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=HiiG3J/GVSoLp28/YcrN8mjUJVKd0uyNf+t/IRvxyY0=;
 b=BhDMfG1H0BcD6o5oS443dVhTbSYNb7gEHPSWW4rDxgDThL6S6uGfD0DzyDtgLb5qqhks
 WweCm+Q/SIklVu1b7ediXgTyDgXB2xGB8QWxU9nuXVN3/8iS8ap1vRLOemFO2+EWTf+l
 NlCqFKE/aP2qQLGAq7dS3CsvsrN1sydkMb+hblQBmCAJi0Y7azJZkx9ANSKuk9mTSciH
 0lX3kDaecw6KFdyDsVcEe1mQ66yPpU9pQZJ8i2DY4Jevq70QwSR0r2k7+QO9LHcAKrz0
 tDp1Ixqm0yPOFcQ4tAVC2VxOWTxX9H7hG/2bNGisjpE3PoOsz668SWRIoVzXdEXK5X3T 0g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3adt8g2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATLF0FG027905;
        Tue, 29 Nov 2022 22:50:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m39881gmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lk9uL+imiJ4hBF+hUMhqcfvWUdDGNi7gZoQiSnvzv50VgJ5dN63TXahHDxkNFvmeAnyW5/JqkJ8S+vA9G9ogHL2pXXB4D28ECtLlNpe5hUx6NtZt1wIDGbyEqlvrQVO8uYKkR2XJSe0QdjMW86HOPI990+p223eMjApaliza+gG2a0gC7FC4IbqGX5T1QlQYSzJvUNUY49CDaDW21x4ZiAAz6GOIKqOsiyxOuedmTaPRtwPy8T/ieVN7nUbvkJ5iIzDwY+IhW/MapOj75FTSacteXP5+OjBQSMEDNlFelM6dVWGvmQNh1gVCiXPa+WwH4UWNmGWOMiCvQ96uFN06IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiiG3J/GVSoLp28/YcrN8mjUJVKd0uyNf+t/IRvxyY0=;
 b=lxLCJFIOMuIa8vFJrnx1faUmF5c005uf2hYCf2WJRG2xqSNK5XdVlpzTJu8CWryBdgNhiuIcWPEK+n91JEcJHMNbtcZ9/1FnUuFvuCSdEe134O2QE3pHIU598F6O5FlYdw8+jWoUEL/wrej23LGe865BCIEG/DBrpDQFqK5g04fv6nkV49S2O/F70VP29nIUdbQWnWSTnD6OicHkDII9ARZ4AjMG5gnybUhwN/Hlf8LQedX9ngMyxzoqk8Ob5DO5DlVOF1QDFPwKCi2ZpO+iP8qjUOcZSBsMVFq67GpA+41NuJ2VCh0MLsOMmKeaqGY1/OW3fOGQCd8PAwLnJpX/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiiG3J/GVSoLp28/YcrN8mjUJVKd0uyNf+t/IRvxyY0=;
 b=RbH7F5YUDONfl2MhrPkM8zJZGwXjrtfC/Sx5QDplykprX1yJXdkzeInwNwT5MTwIk2wzVBw92si6tZLiPLI0SNHWqxxLr4nuPCv5aXpxIP9l+39Vjvt46ueKUM6B17qq7Oj2SVlKq2kBf6yPanUYICFZftOUALcOCs6vbeoeOMk=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CO6PR10MB5586.namprd10.prod.outlook.com (2603:10b6:303:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 22:50:43 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 22:50:43 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com, david@redhat.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v5 00/10] convert core hugetlb functions to folios
Date:   Tue, 29 Nov 2022 14:50:29 -0800
Message-Id: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:610:76::17) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CO6PR10MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 13051708-8fe0-4ac2-536a-08dad25c2528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JuVQa6f8uAGkn3MYZO9Mg7eml236//flKN76Ds0m86KCOhPFVucSRDi3RfMLWYDLiZWs5suUni86TcMza41eNeUlZIz53Md6W6J0oL+zExya+vTZNZYnNYfxU2HmpaED3Hr6TisotS416vL/5Wbthx4NKTSw523a/GMObv97eaAP2C42ga/ourMINe46Hk3TY9hz8MCz0uWcQ/jFDvM+2+atCu/Gu4IS/W6ewEZPRylFAn4iWl3V01rD6q8LpQ6O58XiYEwXIAZ9Yj/viSEnoFb+abx49OSgyOUcjmjrj5yS+rAJdlzw7Ozc/2rxZum0ln0SxdiApgE7hA2R0cHw/JNwo1oL9AOSS8EW3+zangTD8cBS7pPIeR5hFKMphRC7fCd1lkToFy2k3wWe/41IJPcX5wh7W9Ab6yYPN5U3Rh6EHDelBvJCJ2PNjvrduHzfwrXnyQ7sKCFXd7kmBg6iNnimQEdu/H+gfbBTiwjHw28cMW73Eswv1Sa7UGL/LXFWXWiBfBoy+bCbDPAGZt+aGrvfsTXgps4VmvEfVS4ZM33WzLdUeY5z8hy5Jp28U2CVe4VAWoG3ewE/4SP797GSmktanhbeexoIPit4zBayOdFARaubRCJXA0dqaQGakmAl3L7xgTAv0uxyF2mZjvLgPfK3P1UajaxdBaEk/ZT3MP8t/7vM3bRAOpeh8NWX8gYUt8+ORtanfyM/tH6hMh7BMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(66899015)(2906002)(2616005)(6486002)(966005)(186003)(41300700001)(1076003)(478600001)(36756003)(6512007)(86362001)(26005)(7416002)(83380400001)(38100700002)(6506007)(8676002)(66556008)(66476007)(4326008)(6666004)(107886003)(44832011)(316002)(66946007)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BM6bWlZWyzXNM19r9OVsk4BQXnVZL+kbVu5M/5G0DKZGUA7cb1dl8+VK7Nua?=
 =?us-ascii?Q?/QUsj0p+QQj4SeuVHI0Lft7wEiixg1EAO6AyAjtYVGg8Y29hzmu5/ewOgLFE?=
 =?us-ascii?Q?yGuFBGe84Ou4ib07RthuHrCq+vNRXmPeT1U7/VXWdFN+bLqxGalcu3GdlR7D?=
 =?us-ascii?Q?h2aUxY8b1pC4e3fCdQzXr2gkJbulhaRnSprQDelTLy1EZO+0wzt58p37+PLO?=
 =?us-ascii?Q?U/jJYtdYKDPK9pGbz+bbNTmnqtoiVgL8kINCUDhIimQLxwX+84exB2YtW4Mu?=
 =?us-ascii?Q?HR94tZdie3bUWg89ikA/RRpCZ4FKfmZ9kM/63o9e18O8GwwWeA1xr3QvzGsx?=
 =?us-ascii?Q?2mY9ddF/fMk00/P4omupptYFjP6HM9JHQnaAb2yIVOiyTMHUnh7ioB+zoOxc?=
 =?us-ascii?Q?+WoFQW2CUgFko/jU/eqffEfwMmc7E+2el1rXC7L0wT9SSnqPd539ufE4ioLI?=
 =?us-ascii?Q?HeIxOJ2xRlFvunBl3nr4wuofin4zxvYU2G+UnCVe9fBv7q4ZVQZ82SL7+mgH?=
 =?us-ascii?Q?IUtwgy9myE1Cj3kSxLMrxLb8o4dXImdK8YeXphZX0upyoOoTbjLTLvI7EiZK?=
 =?us-ascii?Q?6G2vjZXmVkE6dcnKEWfw6OoWjproD8tSo8kxZX+DFcSLmRD6cEmt5P3J0jwh?=
 =?us-ascii?Q?JWHK0Rvwvew9JqKd9LIwA4RJltZrrDS4uLv8aP1YBA4kIaEkmCeMhKKjAgpS?=
 =?us-ascii?Q?g5DUA6Am9y9eWjNeX8f3mZWt2PJE6ydumWsJOuLMgRpqd6JzFADGEbDouqfV?=
 =?us-ascii?Q?n7JtqKnh19vSgh7NMW1qzf0hciC0YFseGLVjdb+gU4w3npWDjTI4mbYT1EBQ?=
 =?us-ascii?Q?cneWyMpRctrE7plDMKVGTcYqsLJEA7OtVGxCra4cpevIjcfZVOaeithKl7hR?=
 =?us-ascii?Q?VP6jFgEw3WVgZYBUkqmWjfbEv4YrBUe2UPttcBbmvWup4H8W0mGAtGH8EJmC?=
 =?us-ascii?Q?7uNQ1QQgzyXpPOU/5Tfn8u49LEvZskVWQiNAP+5M4flu2mlwXWMjrYwt4N78?=
 =?us-ascii?Q?iYNzXOv3oQmcC2F0au0lf1C4PxefJQIuFntfmx4gK/+9IejM80T+rfxS0Sby?=
 =?us-ascii?Q?+ms0dk1Q4hgfNnmEy49k3qc/h9TDt43NU28M67IhclreRpC4BHVq/nZAVlZH?=
 =?us-ascii?Q?A6jp37mTjCOiEXX36mR9F6q56uVnop7aEKqlxWhUPK5SIBwMbVQ00L9tAMyO?=
 =?us-ascii?Q?FcHRAxzo1HSzI7CuVMy30JQt4lzbhuO1CLWgN7/7h8yDHoyI/+24xD2WgxQC?=
 =?us-ascii?Q?2RH4zBAYfjMOMaz21OXuu29fkKPkNeuNM3IsdwI299/RUNDl744KByRvoNvY?=
 =?us-ascii?Q?+LHsbPwpDIzoX+iXccmbDHG3xr0OMBGNNzDivf0kiG6aZMYIjbiHg1lMiYOY?=
 =?us-ascii?Q?P9wmmchjNAKSQ2vgUaEeE13G/+20L8YqGNtFqRZ+rb724cQFLrgGecQ32Wqu?=
 =?us-ascii?Q?r/SIN2lthPDGlW8nRTsgy5BRijbjBpczbzgoGmTZmup1QfaO5lB3oaL8YVqi?=
 =?us-ascii?Q?UxYBoHCAxiMlaOSgnboaDGaRaAyXJGkP4XjiejolkWsNVDh0Vww7Ja2dUMpW?=
 =?us-ascii?Q?mE+8p8YgU7nbCUkf1NwPs06Aiy7WcSLty6m29yiu6leGhKED2qwpt/bBBEMI?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pHI6m6+gmEL7h+51W160PgF5vUgilMhXxOsbY+tBAigBplxtFy9VtamSLCDP?=
 =?us-ascii?Q?ExJ7edsxnrTyxz0lwcbSxdIcwmSMJOckgX9wuMOH67A+Jsqs1S0S9xKr1CQ0?=
 =?us-ascii?Q?OQ+/MmQOYujXFQ7GPIaR0G/Imy5Xe35nLBURgtk8vYZz7yxmmwFZVjl/S+7i?=
 =?us-ascii?Q?1ONbbqU+Vn8AZR+/IpP/w6lbo5IHn6JtMyfWczLmV3yIxbItKXKBT/KNgJKx?=
 =?us-ascii?Q?NnCM2dT1a1c2UbA8mYFD/CNMNz9hjuOkNXwBsx6N+VFZWYlb7OE1LSWlAVgu?=
 =?us-ascii?Q?XO9LqufxssTfv6Y6ixjuntjMxtxQyOuNT6KSlGTqAr4NZy1q/j42VGGUQtne?=
 =?us-ascii?Q?sxKQSOdUnZlRyQtHRXHFL0S0JpYw4MnYvuajvQ7M89SenjTiT4obXG7oz4tq?=
 =?us-ascii?Q?+8GR/ivoPJ824DhuetN83tHHlNG3UhGo8QRpsDicvDnRU6dLnyD4e9D+MNhw?=
 =?us-ascii?Q?/PstKcKwOaOd3nPVpfvWuWZyTD87G/bjplGoct1t+Tz7SAduTmuxmLcsVj28?=
 =?us-ascii?Q?hnBHgaa3Na/c9nfrT6R8lKgwcZaTFycCuzNvtA/MJcna7sDbE1/vKcPdsA4g?=
 =?us-ascii?Q?v9JcaHjidAdwHvkJW6yBS8mZCjulbmupKf4UC/lPtfC//8rCCK9VLyPw7nOT?=
 =?us-ascii?Q?5Dq2ciztb73xrKURK57OisMxd8qQHBRIbWSYERiShvRbt5xgjRsrDMIzUiOu?=
 =?us-ascii?Q?Nd1/8eWNsSCGJXfPKo3zxoSuufwY1hsKhPfSAjfugEJF5Mw48hRZtIVB+Irb?=
 =?us-ascii?Q?WfdRXyvPoW67DbeGQqzMVOENCECfQVBKBAw4tbsMVz6TSyDiAelKjt/RFuza?=
 =?us-ascii?Q?W+uJGjXKgERTeMMWU2pCmiJE5d7upZiPyRx2HTToWDjrMWQkI+ig+x2pRabL?=
 =?us-ascii?Q?P6HvJ6y2EjG4STsk/Mwei3vf2zl0BIa9PFO2hv0604InnWWxXqT6U22weENg?=
 =?us-ascii?Q?amG66w7Mv4mtG9AcWzNt3/jqwsUargFvDyQLdzfDqf4GroUKI9f/PRau5rYF?=
 =?us-ascii?Q?YK9pK0PIqk5zSAkRw6QOcsg3tubwHlLKDcXnaU58BY6JfcBVoAyPxCw7rtKE?=
 =?us-ascii?Q?aUZXJEmrjrL4RPo/LvklGpHpxd8XOES3vQ+DDc1pvC2H8WFUlTw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13051708-8fe0-4ac2-536a-08dad25c2528
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 22:50:42.9507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCjz3OxyuHlx8PbSIsNIJVqtPQYklzwF90+PR/TdxMNpvibHhLTgNiA1m0IfCoYFF+U+1q5YeSWY91Raq5Yuhd8iu4H5MlOEiHWZLoO4hhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_13,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290137
X-Proofpoint-ORIG-GUID: fm3GYYD92o_Ps7zkhT21VltKmBZIRht5
X-Proofpoint-GUID: fm3GYYD92o_Ps7zkhT21VltKmBZIRht5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

============== OVERVIEW ===========================
Now that many hugetlb helper functions that deal with hugetlb specific
flags[1] and hugetlb cgroups[2] are converted to folios, higher level
allocation, prep, and freeing functions within hugetlb can also be
converted to operate in folios.

Patch 1 of this series implements the wrapper functions around setting
the compound destructor and compound order for a folio. Besides the user
added in patch 1, patch 2 and patch 9 also use these helper functions.

Patches 2-10 convert the higher level hugetlb functions to folios.

============== TESTING ===========================
LTP:
	Ran 10 back to back rounds of the LTP hugetlb test suite.

Gigantic Huge Pages:
	Test allocation and freeing via hugeadm commands:
		hugeadm --pool-pages-min 1GB:10
		hugeadm --pool-pages-min 1GB:0

Demote:
	Demote 1 1GB hugepages to 512 2MB hugepages
		echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
		echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
		cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
			# 512
		cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
			# 0

Rebased on 10/29/2022 mm-unstable

[1] https://lore.kernel.org/lkml/20220922154207.1575343-1-sidhartha.kumar@oracle.com/
[2] https://lore.kernel.org/linux-mm/20221101223059.460937-1-sidhartha.kumar@oracle.com/

v1 -> v2:
	- fix conflict with "mm,thp,rmap: simplify compound page mapcount handling"
v2 -> v3:
	- v2 contained wrong version of patch 1
v3 -> v4:
	- change instances of folio_{clear, set}_head() to __folio_{clear, set}_head()
	- rebase on top of hugetlb: Fix __prep_compound_gigantic_page page flag setting
v4 -> v5:
	- change comment with HPageVmemmapOptimized to hugetlb_vmemmap_optimized
	  per Tarun Sahu
	- fix Smatch warning in patch 10 by reorganizing alloc_pool_huge_page
	- fix NULL pointer dereference issue in patch 10 per John Hubbard
	- use NULL rather than 0 in patch 6 per David Hildenbrand

Sidhartha Kumar (10):
  mm: add folio dtor and order setter functions
  mm/hugetlb: convert destroy_compound_gigantic_page() to folios
  mm/hugetlb: convert dissolve_free_huge_page() to folios
  mm/hugetlb: convert remove_hugetlb_page() to folios
  mm/hugetlb: convert update_and_free_page() to folios
  mm/hugetlb: convert add_hugetlb_page() to folios and add
    hugetlb_cma_folio()
  mm/hugetlb: convert enqueue_huge_page() to folios
  mm/hugetlb: convert free_gigantic_page() to folios
  mm/hugetlb: convert hugetlb prep functions to folios
  mm/hugetlb: change hugetlb allocation functions to return a folio

 include/linux/mm.h |  16 ++
 mm/hugetlb.c       | 409 ++++++++++++++++++++++-----------------------
 2 files changed, 219 insertions(+), 206 deletions(-)

-- 
2.38.1

