Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3728B67D85C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjAZW2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjAZW2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:28:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F3B11148
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:28:04 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QITDG7002033;
        Thu, 26 Jan 2023 22:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=aDkew8Yk190DJ8NQzfUpfEUpAQT2MpVlByqDo+wf/Rk=;
 b=AJ45TCLPqA5T4txrksFnYZt8oPkDGV5OGNvcldEW0AOXH4T0o6XgtGMUpQqZEpOCuLxZ
 STqauEo9McANZyGO/gfTGwXELRipFI3MXL6TiaScBoY6rzW5ISm4hz9iWjlxWelYDPQp
 7nkmCy6U/uddrjk7Dn+PhE2Zltx/TRSvhmMjyEVham5oP83i3no4B/uCv4vWi5s3MwfA
 Jfgp8HaG2ngzkwv4px+Ow7A3HIE9rtH5W2ZCri9uuKcRDy2ZrTu26XanB+RmOtN7cttW
 Rtga94bazcMHVxZ9BJDjB6TnztdgNL1cLIsIcuGx37xHb40YLHEWeq5SLCGjwUTA6Mt/ Ag== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87xabjay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 22:27:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30QLHpOJ010576;
        Thu, 26 Jan 2023 22:27:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g8fm1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 22:27:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ee+cwm+r5RTHVR/zR1csPtXggOthsVZwr9apYrEL2JXeStY22Td+tskwWU9qsXLdlzawH5kykdwsyfOLjTRv65XVi8PYIZ56GiWPKpx9ziBWen3KmMx4zYguUW4/y/XZDaVZ4gVlLNgXpBjqDK2/+R87PsT95J8CjQDcfQtt2OBgeChD1APu/h+ZpVuRfqHQhGJ5E7A3DAjah4XaNESKRsb1t8/vb60APjdW8DLLt/IHkDUZ1yWFIm90HpW1r8FXKfbKegvrhgHIEtomXpQVPqATtOhkqcWOsFYiuPuLXgjK++G+YddtCMAJlKyc7iPTtc5J55Mmayxzq9qwvOauZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDkew8Yk190DJ8NQzfUpfEUpAQT2MpVlByqDo+wf/Rk=;
 b=UfznKrAygckbgt9cWsAvvLo2zzizFxr+Ic0zwHYLyimqG1wYpxkqn/TAK3Sts/2ZoIHrERVpCzofnvNT7tUgPghkEl/sm7wo6e2Yf7ICjzHG16iRLPNb9w8L4Im2NXOOV/33NTJhn10JAvLutIRSHW7mUW1wwssCAFRjcj4gkkL2+uCEvBQCzsu1xOP5LQloeOfbxrXb2smROerFMY+l2ILo0iTSy3NyLx+It5ac9Iwvw/Avs6Wq+55eY7sZ0KAhcYk4SIznjoPir+XYTVmfxZZfgjwgc7G6s9O6Nr8CV1DezHriSxpLK11GdTX8KHG938fe6oOMH3mJJpoDjL2Asg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDkew8Yk190DJ8NQzfUpfEUpAQT2MpVlByqDo+wf/Rk=;
 b=UHT8eyOJERwMIb3hblbkLjVyWsikmEth3pthBh24a7lq7ok2TiSqCfQ5yAyDe1ebzp2pU7XKvNki8ybf2ANNFsQi9M9crJGvWJ51fyu2scrSajc8gjI/dJhZM3FMPcjDFgOyIMwVKC08L9otbq5IwQuKOBlNZyz7NF0ITb/TqNc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN6PR10MB7443.namprd10.prod.outlook.com (2603:10b6:208:46f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Thu, 26 Jan
 2023 22:27:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%9]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 22:27:26 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 0/2] Fixes for hugetlb mapcount at most 1 for shared PMDs
Date:   Thu, 26 Jan 2023 14:27:19 -0800
Message-Id: <20230126222721.222195-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:303:dd::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MN6PR10MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 650852e6-2360-4564-0a37-08daffec8072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/BP05JsYWOMNqjciT3DoQBr3ShuEVJHLUGg1tIw66sYzMTD8ivlYOUV7s4STsQhZUEYs0ReK8CBeYgGTDoaj+OFZK2nWEHjyKiHNJm4YFOBrLJYNuoaoLzo4c6hnWQBrfMnE3VEi1GUP1ViEtkp1tXWgAYX4RJ6wYBy1lz2/+Ovk531gz/QoaIksvUygcEQoBK+UZzGgHvFkU8fFS7tzX9R3CYjwtzlp/V5Hv3du7wWj9fR8870dfpvoRdjlJfJ4wAu1QsFzf17AQmugawMWxOO6qTzY8rgy9aklA3rh9CsLNbEQf3omcN4czK4wnl2GWfYkc/rIldgUgOac9e/MHfVA/stjv2KJnoCLiAPjeFfLv/sCry9ctD8EYeHl7KUNMzoABf8JHVlAAEOBRQcA7AdQROuHTn+93EQ3Aoh2NkiGVb5V8/mDIGllEXQyyRzYNT7YkUzDgvikIs/dQ3vXOpJDmvNsZcSDjcqcunHIQWjL4wjkZl4HyOAgF3iNcyFcGJvx2F8FYiiIPCdW9OkY/4EqzVm5dpdSAFz2RHhh3QIYzz6u92yFR3mauRKHCpolrvmh+k8OpKdCw0FLyFkfEwjE91KD8dkW3Thr/5ZragcyHqwO8Ezf4g5AJYC2CWn//xxVUvb5Fb/COdgp1YhDEg2w2yD/UUt4pJsWRSJZqlL9kLyjQ8QV3wP5STKUgg4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199018)(36756003)(2906002)(54906003)(316002)(478600001)(86362001)(186003)(38100700002)(6506007)(1076003)(107886003)(4744005)(6512007)(2616005)(83380400001)(44832011)(26005)(6486002)(66556008)(7416002)(8676002)(66946007)(6666004)(66476007)(5660300002)(8936002)(4326008)(41300700001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AYZtaKLHai9S9UB5opBeT4rA4pYpwjOd3hu+yTxP79kdVWfgHx8qeMFvstg6?=
 =?us-ascii?Q?5IS07Yu6JRGaCwSsrkHWcLyQ0TtGx1G4+ff1hpu2M1j220vBT48qGiidrFaE?=
 =?us-ascii?Q?WrNfHpt3syYhs4m4wX74x9797KETKvR9qBDLs23kIUfOlHKLTBfWPpcDK9tG?=
 =?us-ascii?Q?fKZnLH2SKSJonx5VofcykLzNxhctmt++A2Z8wLqvoIVvBX86BBHXshsRbf3N?=
 =?us-ascii?Q?5e/URohyIQfiKHR+XKa336iqfsDdhrm2V36YJ5e1EmgGkv+wBxRr4T+hdjP0?=
 =?us-ascii?Q?zmxhDqsaS0TweKnWCqBRCjJ34Ib8oVS8ksAV3ltKMZ/hTolWNizw5QQLjQeT?=
 =?us-ascii?Q?8Utgi3HQHiw15DpR4m52PgwCA5oIuaT+AAxD1EoI0ensturD3gU/gPE+f4IV?=
 =?us-ascii?Q?hamW4OzeyZb1ZD53wM6og9RM0gh9auHrPxN0AYM9nL4utT3JcB+ULwTsn8TP?=
 =?us-ascii?Q?rKxTc9qrYiwZc8fOHrloYI+JQksC7x1lyuSrCQ0xdFI6xhPCpzqotkL7pQfC?=
 =?us-ascii?Q?M00rL7EhZT7CgCBmCePNE3KJ8bVluMgKsm9GDIE0zrd6BhfWwRW8jEXrmpbe?=
 =?us-ascii?Q?RvaryGU351kuJQTUn29opdm/Ur8shwVdDCm3drk6vdV8VI0NFgNbknp/afl/?=
 =?us-ascii?Q?S+tFY+sGZGrcitufoqZ4yq3pqi67phGcpnIWnt7eUmSjtWmTYsoJ1W58sBUu?=
 =?us-ascii?Q?Yb/QdI2XLHs1dQ38pFzAF8jcOPm229WupThAvm7YO9TQUFZADvqWsJyJT559?=
 =?us-ascii?Q?DmsuUnMXDgbbKkUEgvrJPi+jrnF753iBJDhU3LaYkirgSejbX++w0vUxvY/W?=
 =?us-ascii?Q?Yf2BfgdtxNWInLzFFpKp4hHXHqCe9hxzyE4DUT1dBLfrgSOb1LpBSNzDEZSp?=
 =?us-ascii?Q?PKxT35DjlvFph/RmPKpyj6dCVdz4y8BNwT4/7d4WNlk3kLRhMWRtrz1IERtM?=
 =?us-ascii?Q?Xp1PCoOYMq2Z9XZ2BX6oMq2eksTF/qqPpVLwljBOXEsuc3XXaFb5NBdgGAfO?=
 =?us-ascii?Q?dW5j3qgJ0/JfrafC1xL0MPnyIB2YEsry+tZd4WNgZnaYhFPgyFMvgB0OHewf?=
 =?us-ascii?Q?KTD9jDUMrlKpuj7KGN9DFF/IeqQBYYBxrSu+HOIPvSgVL+qQEaVHAXPp8NUF?=
 =?us-ascii?Q?msDHmmUfxwyrs8yICWOOZ95PqtxMVfPa2QM/lN0szUbx1JxkMOw6hruSJG/Q?=
 =?us-ascii?Q?o9PmGayZF6f6w4vwa+Svq/2ofvwZBSHsVwuqtDyCH2SG890obWtJbKnKNAGA?=
 =?us-ascii?Q?2RWZjlLdbDNiphMlnPibwG+PcO0XpEetwxrJXo2bbeebqA5uwq1fXOafeddQ?=
 =?us-ascii?Q?vlazMvOcvaTYGP7+x5hdpeiR3bR9jCJu3mGZd86rjR2k47PQ1HykXLS3XICl?=
 =?us-ascii?Q?287+zlpMq6j9l6x+7Q/dIMYi2cUlDeIgls++7tvphiVRkjDie+np2u3/0UOe?=
 =?us-ascii?Q?3SC6DEEzYMLoJ8N7EO49/jcC5hH+6gxYveiJXanIbJc8FZkdm5JBmJNIOTeD?=
 =?us-ascii?Q?IHVphis3V5FsD9JUYEZsTsi2m1cxlAzIJf04CsaEhFro7A3+oja2TGPk6ErH?=
 =?us-ascii?Q?F2fvSH2smO5vTrzNdJBCmW/8367unAVDTyvOK5jOBAFxU2ITM93ByGG2BHwY?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?esYhIy7p9i2+MRmiO5XyNSQ6qHGq9vFNMC+sXkRZHm+WL005zF/VRPrLC4/E?=
 =?us-ascii?Q?riu389URVnc7t7cKD46A6tjD+BQUhWQvfv1I/LjYCAupJ1ARVYQ4XZm36Upd?=
 =?us-ascii?Q?pDsFqT1CdDYo2XrEQ9VhFqv3tW06uxhZkTIlF4at5sZzdldfxjoavmJCEXln?=
 =?us-ascii?Q?QdjNr35qI9HqcO9KzJAYf0N6NZq6cMNQPVc44UL4Yjo6VKSMQwsF3av0bzOB?=
 =?us-ascii?Q?bbqYJk7fvp8B6mxVyCnqZSNnOXb8GFCImPzci1El+0Pg62ZWDf4QHG3r5TDd?=
 =?us-ascii?Q?c0gyJ/FUHLrpXb13Dm6jDCceVnpY3qGTqZ9rNTWeiWmO/uJKhPN23AoeQec4?=
 =?us-ascii?Q?TGQ//TM9pGRsxip9iB3exUqTv9W5lNtOmaxE0HRvjESauMyP1NThxu5jVE/u?=
 =?us-ascii?Q?Xqe+VM3h+05b8o6qzi2p2DbZf9hhmqAiQoqlSEHEIwL8AseoNQM/hSE2KT90?=
 =?us-ascii?Q?uZi20wvpRqjFgR7wJhLWOYEmADd8ATwFWH1LPc20clOazNI8XJzHAVSimBb5?=
 =?us-ascii?Q?yAMmIfTs2k2e86dvDW6JS0YC9mOUwhCV2suxZFhRBwCfdBe4TZkKiqiP4jcq?=
 =?us-ascii?Q?byEGrPBsuN+rlReTtAgwFkDK2M8N+cnes34rFcWZTawJWGIhN3NODU/bbA4g?=
 =?us-ascii?Q?uONZlIaBsEEtGf7UofwWqdgTIX4jOdVdnoEVdUsUtmR49U1GpzxMtFTK9Fc+?=
 =?us-ascii?Q?qp2padvcaHXLg0dunEZFprCf/908y9+3VLuCuwkICvugXX3u9mda3w5MRkH5?=
 =?us-ascii?Q?lijzwTHVE30J7p0prf04gqe9afi8pCr0dJlcmxd8oJJUKgE9iHvqyqfeSfE0?=
 =?us-ascii?Q?pFmMO63J51E1iZO7b43U34abxY+tuy4r3ROZbZ+K1Z+Z9qNOI1Dqqvp9WGO4?=
 =?us-ascii?Q?T0DRRF9lWgzxZ34IitxhCSmD+RfmoX+WgO8Z6ODHHeESKZr8Yb+8QeG3lpt6?=
 =?us-ascii?Q?evJG/w8vy4ET+6l858ZYCGhQxZjnN+VoU0vs56xcPSIQwcCUoANhs7z7nItX?=
 =?us-ascii?Q?vghCX9p1lqDy2wf1NpzJypnx87COZWFods4wdvlCg6wMFUGGZFaXspoPIa7M?=
 =?us-ascii?Q?pV0v4J8q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650852e6-2360-4564-0a37-08daffec8072
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 22:27:26.0074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TUhqUaTkpels8PyyBROWAV9NqS0AxqmxbsH7Oh7PLhDtMAfTJy/yFqt33d0a6qHKc/ZcDcS0z0vbQFfU466Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7443
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=962 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260209
X-Proofpoint-GUID: oXW5PFZtzOXmHkJwD4s9PD51YwTsWOof
X-Proofpoint-ORIG-GUID: oXW5PFZtzOXmHkJwD4s9PD51YwTsWOof
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This issue of mapcount in hugetlb pages referenced by shared PMDs was
discussed in [1].  The following two patches address user visible
behavior caused by this issue.

Patches apply to mm-stable as they can also target stable backports.

Ongoing folio conversions cause context conflicts in the second patch
when applied to mm-unstable/linux-next.  I can create separate patch(es)
if people agree with these.

[1] https://lore.kernel.org/linux-mm/Y9BF+OCdWnCSilEu@monkey/
Mike Kravetz (2):
  mm: hugetlb: proc: check for hugetlb shared PMD in /proc/PID/smaps
  migrate: hugetlb: Check for hugetlb shared PMD in node migration

 fs/proc/task_mmu.c      | 10 ++++++++--
 include/linux/hugetlb.h | 12 ++++++++++++
 mm/mempolicy.c          |  3 ++-
 3 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.39.1

