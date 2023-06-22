Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872E7739449
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjFVBKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVBKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:10:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A993910F4;
        Wed, 21 Jun 2023 18:10:01 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LKFwsp030817;
        Thu, 22 Jun 2023 01:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=QAeToPgYMsMT/GjqoK+iW38tUJzbKupscB5oVEXfS7U=;
 b=q5yODYKec2qE3RdThkEI9TN4dVPNlT3zws3hlpJ1Z84BL8Xh9KmM7+h9uvaGg1Tug/sw
 Dqd6OmYoQJ7MME8mjNt2Pv1I3m6a0MMDIkuoahNGpFWuKxxp70PhZwuhZRnnkC6zvyjz
 yuW4njxwN9JQRKokW9cJXtT+6v906ZMy28pr2KXGQXdMlM2VHFWfcjt2lr7HiN4wEuJd
 pA404golx+lskg9uGvxlPJ2w6ZqWtmdh3gb5+C+kVaA6mszgnkHc0RIUCjCpIEu6lUj0
 eqNFM83uxbdQkD41zK/Q8Rz8xc2fOIFoZZ3hvZtaVJMqQYDhb8Sz1+eFCegbCKgygIIE tA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93e1gr6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 01:09:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LMUJuj008323;
        Thu, 22 Jun 2023 01:09:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r93972uqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 01:09:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQry4UFpZAJBbmqgjro2xEi8z1M25k7L50n3SPvIuKDn1j6na+ICWIhW+0PGMpLi37uwWMwk+q/H7Acrt7DaaQJ4HSq1FE9TdHA3zEU1NAqa5/bsWNcdNNvI7Pj/4tcFjrOB6jvYGZiKpg3LoTvDs1NwcsfJzYbRiG1q55JF10cGRRSOQNMQomy+apUgVLWezDE0NH0WUJqIh9d8YPxGneY4ANHel4LuWBsuot7gi0UGPJnBa/fB6kzBQO9qNnvrwZhRH4cyq5eIEjzexomfXnL4qNPRM/IE/6Mt4TdZvyPZYueaV4WHAIaZ3kY/Zqp5V2EI7ByOjZEARm4bHKd6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAeToPgYMsMT/GjqoK+iW38tUJzbKupscB5oVEXfS7U=;
 b=CifAkxAcuRBUQ+3M4eDRd8J7BD4HMZ3MvMkVq08htyBLX0KW8zqPW4tpFXB9rhNMsg59/nY052hoKqu9Ro0/RTkoeLYSMYV4zJk02Vf42+hMuFFhxEpiWRK52YSXRZuh9FX/C4AsdhfhlCYUq4O4QygM6nTJimg/M5BcShKyMltCT0BXdg9i/l0GDZ2FV/NxKthsusagvPRtxdQmNLc05GigISk5SxIwm3o6DHcFrYmwUzZyVV+YS+ax+YLDdcfnNkKHg4LTb3LEtxdJiNogev6WsIvx0flUfYJKQtUdxVQT2/aWzpdT0QJKjUE9rUZCiu7444TPlW9q+z9Nzh3HaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAeToPgYMsMT/GjqoK+iW38tUJzbKupscB5oVEXfS7U=;
 b=KRzAZbpJIbEBhZzl4/cgQ0so2DxrINW4H3ceN/UoSo141xQsvP9OW69K8CzbDZ0a+DNsoil3YnpSL1peGEAf+9ROhblokjbEzyI5HRMkLSDkZ8YRXbeZ4LmR/xEliwlcc9QBTiD+Ma1pyV95/jfXWPprYLlrftdGGI2yGBFw0w8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6554.namprd10.prod.outlook.com (2603:10b6:510:205::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 01:09:43 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 01:09:43 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Justin Tee <justin.tee@broadcom.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: lpfc: fix lpfc_name struct packing
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zg4sqp4j.fsf@ca-mkp.ca.oracle.com>
References: <20230616090705.2623408-1-arnd@kernel.org>
Date:   Wed, 21 Jun 2023 21:09:41 -0400
In-Reply-To: <20230616090705.2623408-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Fri, 16 Jun 2023 11:06:56 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0192.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 68dc3c92-f25e-419f-c6aa-08db72bd5c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lxT8CKWBwybT1hrD1rdxYW0IZRqyqS0sLgrNC3lXtokbW6KkmRw6TvNaXju1SJdfWITC8chM1O5Tp1q3NZsU6ZuE9is9iH3XFcpntskMa9cgXn8znF9TDFAMHV/lKb/q0KgvdsOANFHjHFrLhM/lyfuXo8pm5Z5g3O0iWY1O2dTCcOAm3tD4gHg0pScg64YexT3+2+zWDbg8eTFm2wq7F3aIGGH1crtmk6QV+gayaHJ7Tq46IwmxKb8prl69LEakiRZsmIwRRd5kAG71KPpU48wKR6CBlr/6V15UODGzzA/9So02fJO0ETmwPGRJ+xKMyLJfMjj1aHIiGxxMJ2DRj0lC+0YtEepXzywCIiN63puy/EFH5uImkvfd/nlSpDPqKqcGvaGLZOGAh9fsdORzCTMZMq53qFFwKW0OzdaDLG6+Sq/d4YZ4ybT3IQzLlSl7k0EWp4s/Ug52xDurC+XASPy4HXaF0CI98IybG7bEetkEb6fy4xwqOrZ5O3aUP45nPFrcn3Ku05ywWRWa5OtEKzfQE+yIB1W0iuqCREU34zmEoaXAygUxQ9vcGdcVi98S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(558084003)(66946007)(4326008)(6916009)(66476007)(66556008)(316002)(5660300002)(7416002)(8676002)(8936002)(41300700001)(2906002)(6486002)(54906003)(86362001)(478600001)(38100700002)(6506007)(6512007)(26005)(186003)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2gZ9c5tYqYXHRelDjnYPsOVq93VHgzF2H0BRq2XK17sIRFzTxA40I2sHEHHi?=
 =?us-ascii?Q?qZo1FyUTh+PQVXGsrtJcuZ2TbQf2TC9hsHq4XujnN9pa4jMn982W/4YR6RBw?=
 =?us-ascii?Q?dK7Uf40X1o0HBRcGHgyDXCZLTq8CaCr7WyM7S0vqo8sj7p3+BrkuzuJcKMY7?=
 =?us-ascii?Q?1UzwG2sxh0s0MVdukIxCak77c6pQZFEg6cGT9xFrBc72U2ujbMm1vS37jlVb?=
 =?us-ascii?Q?4VJY+HV6F4YUKe1c1v4f5V80oZZS3vLHc2KgcM8hChwwQhueNLPab+5opnD2?=
 =?us-ascii?Q?+K69Sk9xN8BL9sJy3Kuiw4UbrF3+h+bJ8chAlMap8+f70Si+Qod7E8COE/Pg?=
 =?us-ascii?Q?P7xGa225UYrx7EZ/9YNkbm5w3Nc1uLMRm9bKjjzjvaJcYiYZEm+JFKXQtUx7?=
 =?us-ascii?Q?/h9n0N5uG6oZrMgQQe+7pjiP369+TxRHCe+NHOMAr+LffPdk4i+MuYmO4Wsp?=
 =?us-ascii?Q?WP9mwWsCWQRZBa1XrM5zYN1EwRdCXuQAdND+czLsbGKEmWL0GGZRRZWiqswA?=
 =?us-ascii?Q?oeco812BN1UJdnJ2Rk0wpsbtkZOeeFXz5fhRJ4QYXmrsXklRQKwwnMx8NFqW?=
 =?us-ascii?Q?EZIDLrEpWrhtbgcqsSQrvvqNMASBGzZ0MkJQ24KLNnZnakMM7AeOSNN0mIUb?=
 =?us-ascii?Q?pKXbv0dnJ8rkiSNJ6u1fQodQU1mdxGGBiCVw1U2yWk60jO5ekzB+kxkDwRU6?=
 =?us-ascii?Q?umWTwOv0cjtgQrFbjKLiYN3gX68GDwMqFrCVxjWoyfPIl69Ox7RAnyHZu9xH?=
 =?us-ascii?Q?eqQwnqtLwCkYL6X8TvKggJzeMiM2ll/woMlLL5H91kYfHiNZOI2wyNuI1Q09?=
 =?us-ascii?Q?9DpCp+e9sRKSB8ndTZE7eh5fvNTNKbPuHNvQUMCmat7i86s2COK8P1FiX+Y7?=
 =?us-ascii?Q?9SqieKsHmB9oR5C/1bqxJaI92CyDBygtZwZP1LgYbNY6TOCcnixIsQt5R6I8?=
 =?us-ascii?Q?TZ2oqFq1M5ftOipsSf6TYjDu/fSc8vWpLFqbNSsyXMP+mve2iu6deX3ph4m5?=
 =?us-ascii?Q?9ierseQ+YYsOZZiQCx0w/r/h8JfX8ghtz3QxJIKTLth13zsGCaIPrUcoYgn6?=
 =?us-ascii?Q?Wy6V6LRYfUAdBMm8ETu7yI8a+Qox+v3Tu9EOLtjD+GCDXcl4xaVhHS/FF3CI?=
 =?us-ascii?Q?nunkgrhwLG88MjVYgWe8FPyhgCaikTOkwqBwZjHklj/t20R3AVtzYqvxKveN?=
 =?us-ascii?Q?22w6dPBUSxWq37rB3CtSgDPoQ7TWsLxmLMriQ7DRlUGwIFag6D+7SKUhmhcn?=
 =?us-ascii?Q?roBr4FPAMUELfGW6PL9La1D8zP6S4fMcv6Vwltw6U8bcDyP1tOkH4723XMOW?=
 =?us-ascii?Q?L32SBDF/zgUwZQNQrXSRXoFnv+Pbab4ZzTbRXcarAEbIT28Eicss9UXrEtJf?=
 =?us-ascii?Q?SfWIGLzPWeu1bq5UZY2WLmJ7IiZAObyUpiG7SybDrRUv+xeO26rtWD0qmAom?=
 =?us-ascii?Q?kKFKXywGdXeQQrDpQLvDyx+8OA5rGc4CK7yHQod3d1Gk1jX3f9kulAKYW+5n?=
 =?us-ascii?Q?zMx9fvVmuPwvnsVGDe/6xfn5g8JqUUAd677XbKgLpySxnYOWLSX7O4oRjfSK?=
 =?us-ascii?Q?pXVN4ME1qIPIZhDm71D6pwVhI4S21cknAEdT5zkFKMxJz8M4zk82DzgmEuLc?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?C0ZBj3DwEhW4uxLFesEhxoUuRq1fjtCxpIrE5a8PL+LxeCdZzJ4LSnQoR9i/?=
 =?us-ascii?Q?6h1SFU8w+IF4BxgCC0Z3LxR00J5UdI1+pdARG/EdLCAns4vZLblzTsOjwdRr?=
 =?us-ascii?Q?Kw3+W0+N/4Qoh6y2VHeUnpkFK4aRAJ+Q7ljjEF6EQLJ1Z6dIXvEc9Qa13M2l?=
 =?us-ascii?Q?5hlc2joT3ibxTOO79D8TVhmOhAcGiSIQfGF7sulnSemAXm9on0/OKBvbskf7?=
 =?us-ascii?Q?0pe3VkMO3ycaJ5AQu4rvY/Sfq5/n02iS9Ch37971iVImHyWEqrBNQH40VnRl?=
 =?us-ascii?Q?f1ROUp1qCN1SDLup2lAKo0QZ9YRCB4io3oWbCSK7i4T8Ag7T9hn9zjCgxo0M?=
 =?us-ascii?Q?AHGU5TmVH94WG/kKLwKDgaSlXmntfQDZsh4KkMgTkyw8Pigg7xrewN94b9c5?=
 =?us-ascii?Q?j6MBrEuGrktG6DBFaNuDad+xku+kKIjUQkbLzs5pTGxb3vRHKzIrkc4/g1j4?=
 =?us-ascii?Q?EnzZhjZxAdSLbbDi7rbKXh6wfzOQ0IsIGzwz3TsYmn4lhUIuqwtghPHjzTSs?=
 =?us-ascii?Q?yIf+vYU42K91H/CWhJo3PGudUm5zfGRgjLp9/eXkejq9hI1JBA4DaW0aG638?=
 =?us-ascii?Q?6uvTROIFpe2yr2wuFE93i62rTxS/4pJiiJvvUZqLfUzEY/WGl6dUKhLCTLzj?=
 =?us-ascii?Q?9OWeaEL4zAn5wluaLw9FavV/3tvI1sVLR87WxF7NGm65ZH/0ASjAIzR0Pxwj?=
 =?us-ascii?Q?Hab4YlrmjiXT+bHcRA+r2LbJc2RS+QuHzl9uxBh9QLtePv5mGdWaTHPuNbg+?=
 =?us-ascii?Q?k//dgKJLwWmufldGoAGqE8wk6hbyNT041z6+mQFZpIpIglQA0G3bPiu81l2N?=
 =?us-ascii?Q?46/FfDcHBtgITvQ9btZ45fRwyJcy/COhsfiLwprhHuvmJq00dz9MEB1udEE/?=
 =?us-ascii?Q?ByspvrwAjyn9kHW3d045hewJX/FTFT10r3fPE47XNfx7YV/JC85YQfncOkFF?=
 =?us-ascii?Q?K43eURrDBAI7vblrnzHhnzxuDkX7czpx3OnlwqL2BUoW9qi74tzk1hYYt7rl?=
 =?us-ascii?Q?/wRVm35FkGzwkrme6dI/1db6zw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68dc3c92-f25e-419f-c6aa-08db72bd5c94
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 01:09:43.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vkm8ADQYr6yRjWYbgqjJGWbGjBPC9+62zdzi/UoB/NTpsuuXSr1i414uCSegmlL+rZTnxNmvPjKUo6ZD6nj7z42WSTBff+v2wleBUs0lsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=991 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220006
X-Proofpoint-GUID: 9RlAAI_y7yoZqqgg9MWl5ub_FGIIL9tZ
X-Proofpoint-ORIG-GUID: 9RlAAI_y7yoZqqgg9MWl5ub_FGIIL9tZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> clang points out that the lpfc_name structure has an 8-byte alignement
> requirement on most architectures, but is embedded in a number of
> other structures that are forced to be only 1-byte aligned:

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
