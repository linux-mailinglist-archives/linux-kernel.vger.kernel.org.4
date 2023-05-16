Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0296705AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjEPWjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjEPWiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:38:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A6D6199
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:38:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GK02YT032006;
        Tue, 16 May 2023 22:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=F8ZV3nnhyUX0XdRvHlH02sw9CbS0I1wNIQ1dCi05YRI=;
 b=Ez4ukBYMWc/360PnUmspWwPIUnh81ZS3FtaCBiXJt9Ztl5b262QcuIJuT+Xqz5FEaCn+
 TP2fWoR1P2z2lVGWb5B5oCPVD2rFXmLyhihQi5Fy18oAdxmfxTEQUiYENJ+tGk1JDS9I
 oPLgKu1hnzfxDRWGO5xk5s+WWDlwtBiZ4er5XGm0gi0zvHs+xNRr2kRTolOGy2bGwH9u
 /dHhFMFP2+YnfILnG90bj6T5OCPiU6GSysNntIh+etfJQUf/S80NjOcLEoMOHL5tjvyl
 67pJfjdUcwjpfVucV8fBbiHwJMTV5tJKvAeHIpAUi5HVjuafni6ZCyVicQrt6e/KVD6v Cg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2eb3ymf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 22:38:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GKcIlv023755;
        Tue, 16 May 2023 22:38:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10axvkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 22:38:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgJj8wOXEjnRBIX/J2O+39T9DsaMzglOadTBfl2bnu2R6kzyIcM09glp77luVxllp4iwoudrGnNn3EcCFsZVnBYuD4xbNeeTC7LEH0Gtl+v9uCYUIp4dtj9iXz5nQcF942hQjT1HLrXRNJ+SicYTqX2MEyw0KvYQppSjI2LaV1lQ6FaRuPYdayicfVVnUCZCrx8LRyGT9caOuPtiXNPpJd7Q9CLJV6gnYcagWj7X2RFoB/hSJBuknzrCTYslUTTqyWGjhgjmooeOqAGxiN3jcFbZyl08N+KYZaa+SHwLOY2NBLN/DTE2vUg5KTIvjBmXuyTav1GOBvW+ma/zOWMnpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8ZV3nnhyUX0XdRvHlH02sw9CbS0I1wNIQ1dCi05YRI=;
 b=g6t/KTWQPZL/OHz3vnYyp1AUSAyA1ETH9tnfoL1qW2lwA6mURrMBigUFsBkpOc4m9MTmQgMWk4QUZIsTex9UIe+oaDaXOfDYYTqZc5eGPOWFftfPFsqqe/73dZ7mUjhvgyUT8a6BGRm0ynqfEXvvk8W4H8h2AsRinkVxoGs94Ttt4OUIDGdoO4R+kKm2x8EuEJsio2nMlb/gYps13iTFA9IhTIcI78SkVkO14RJV5zhUhIkxdAHeK9JajEPQwgas/bS9f1qweZPmYhFJmsdvbW0uJc0BHXLHtWweBelEW220zdXUGVH3oID4JtS9m+NPb6OAxGqYkbTxK38n4JC4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8ZV3nnhyUX0XdRvHlH02sw9CbS0I1wNIQ1dCi05YRI=;
 b=IutUXo1esZtFtA2uSEHJ2TlwCRp7fdYWFaplzGdjZqsIbOq7KVN3Seq+Rppol9tnFofXjtNZWfds/5g+qIv5hI6D7xuJjMnLeUGeNNgB9vu8DL9nGoiGztP8HaUVcOLfIj3tuYkzmQMGBCcz0FFmk7n4mvq2NJ7GLfrcLTMSPWU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5845.namprd10.prod.outlook.com (2603:10b6:510:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 22:38:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 22:38:32 +0000
Date:   Tue, 16 May 2023 18:38:30 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] mm: userfaultfd: avoid passing an invalid range to
 vma_merge()
Message-ID: <20230516223830.64ege7magdtx3zsr@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
References: <20230515193232.67552-1-lstoakes@gmail.com>
 <ZGKjvceDfpKMxtfb@x1n>
 <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
 <20abea10-5307-498b-b9df-8f0b2fed1701@lucifer.local>
 <ZGOcAOFOjx3XPGqO@x1n>
 <9739133c-3ee7-4e94-a6a8-783045a50ac6@lucifer.local>
 <ZGPn00ZqqQqdmk2e@x1n>
 <e90c2b38-805b-4df1-abdd-8ee460b12b72@lucifer.local>
 <ZGP4KSw/yD5ItTYu@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGP4KSw/yD5ItTYu@x1n>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 440fc629-1d88-471c-388c-08db565e4702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzKlNJYGhPttUhXDjbJ7QwnlbdHKFv3ozkdUwMM02+TdDHY2l70hQyYRkHtr3BSKm2Hl3BBEfyguxEtOYG13mIyVYq3McpZMKJdsG/8SxptuAkb1B8XdvUpvH/lN8XRfbLWgVXo7JhUA5E/l4fFskksTSgxaeiPIiUc0fNxU3H/le46Orb3/Zoq4JxH8hW1z1pfyxr4YgzaGC2fnUukPeYMVQw39X31eu/UjEubfHaw2PgxCaDBT1Gm/XwnDm/9tuS4B7njipJB07JI9MHiaOhpvEkOk15nCQNhUnyScrVOjZFSFipmyKfos3Po+4mBEc0AsSAxokg4wxnQqFZapO8iEOXk4w9BeQ/ZgmRk4IQD9knm5SOvjBY9DL27ZVFPvr1P7epEBdvOoFYzsD/yEwfl/xRcd9o4+uIFPGf6TneaDHAnEIX5kawoEauHqCpy2+peIKo3FGbNQC1vzJwH/dmbFfg3H7w/1UtkSBdwa4/Rppp1nxh0dbNNhFuscLFUQDTCKCs2pZIUktwk9PU8qYXDZ7gGOvJumQCMMowex3dCxqSIvznycGQ343mPbFHKCere8Z4qCP+6t56aDBVUrqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(66899021)(4326008)(478600001)(66556008)(66946007)(6916009)(66476007)(6486002)(316002)(86362001)(54906003)(966005)(1076003)(186003)(6512007)(26005)(6506007)(9686003)(83380400001)(8936002)(2906002)(5660300002)(8676002)(30864003)(33716001)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xcjVj5kw4jMvAVTNdeO7BakBnLyDdPwAy8YnpoOEh2BQB8XR/QcixcIO6UVw?=
 =?us-ascii?Q?Yp43dNuFs00g1ysZbXDDWiuy1sb4cjBuQvy/vJlYN/0rqfigMgF7yxx9WAkZ?=
 =?us-ascii?Q?6EtL+wr6LixMSmX3SZwPnL5ysBZxXu7GnTvtqD1Thls7S8OX27pMroo4+AqN?=
 =?us-ascii?Q?nipO97x2Di6Cs3CFRBxZe4Gi3X3en71Xi4mwnoAatPumEz+DVyke5UohVJyp?=
 =?us-ascii?Q?ecNlHw+X9GoPEQWVmgefcbb7B8aXDD5okquI826LAw5qfD6vGJcramLGM511?=
 =?us-ascii?Q?Yz0amA/2EBihdlOv59S35YbdSrzU2xB1094u7wlDZQrAPoFXkic4vzv3bTEb?=
 =?us-ascii?Q?FlGUQC13xHqmObWdw/b0HCezrGVqodEMzlPtwnAuQXbthJQMiyt8x5oC2Z9O?=
 =?us-ascii?Q?SDXJ+L4H63HkvGxQC/8dkjlRRFkb58LqGANftRiv4xrIGhHmT6wuHohcCs8N?=
 =?us-ascii?Q?CCfzy1PlBDGBmeWIVZ35nXWzKSyBJ3qGtBvhs6mKPSsAj/HBxciDFV3BlnA/?=
 =?us-ascii?Q?NX5qvHGp3I/I2YoBy6MOqMFw2WshRacaZgFAguTr8jaxJXvSyEDl10/yFvv4?=
 =?us-ascii?Q?n4CAmV3GxKCR4NisDx/xjmttkpvh4vEmH7AOVA99GxIlzePwqQkEONgYAENQ?=
 =?us-ascii?Q?MQTGmP2yJzS7fZ96RrKKrmydaSbc+j9Gx3+RQD0VNYPNZ5q1SvCa1O0J6FMQ?=
 =?us-ascii?Q?x7+aOcQTMwfbMKPiskXfsiI6jmZibUMVbxRFRT4HJndDF5ibkuLSSOrdJGKr?=
 =?us-ascii?Q?6+VLxpfISHpqQ6s3cUU1y5T9/XENYzcMKpgHjHwDISMj48PhvmTq8Ntl17E+?=
 =?us-ascii?Q?Tx6mJXek7xByDKBQzSGDAIn4Cs5xRv/VN8pazA4SCQqHVZy9L68M8xShB8si?=
 =?us-ascii?Q?g5eNBzTdSMwZSkaeessacR3JUUn8duHoLSXUn/GV0K8iTLeViNgg2BjJUt1m?=
 =?us-ascii?Q?SZisSbDsYd+jNiJ4rGvrGy7opL9yteIYLove0eG45f2Cs34pJQh6ONPyY7a6?=
 =?us-ascii?Q?o4pGbTPuW/Skv40scvSTHxk0mFV44r6lUQeDKPPKbOIjH0/x4Sc9Ke5Dei+1?=
 =?us-ascii?Q?dhFqfdwkxeFNzv+8U0SD31s57uveMNC+fU2lb4w4C4LldkcBreujzODdbE+B?=
 =?us-ascii?Q?DYyOnw8OymRwfBHBdlw2ZuF6lNegSStmMMLrw3LEMgsNKx35g0JwwEk16Rl6?=
 =?us-ascii?Q?0mNVnn1GOJ79TTmuTMmVoPOhRZa5D9mJnsnV8eRtJAdTP+FT53KPykIHxXmt?=
 =?us-ascii?Q?EevBf4yqfpHxvueFtaxuq8iBkZ2TGYQh7gwkwWQ3vVBaG+BIcYGwshpf9R8j?=
 =?us-ascii?Q?OS8vTkgBLRZ9tzI4e5eg7AfPOQQsl0mtGNeiIhBGzMm/0tzg81T/wp15iPWb?=
 =?us-ascii?Q?NVl7xk5VXcL5Df4G7ELgCwi+jurampuMrSSmBdZnTrrGaH8REZCKq5ivfzfN?=
 =?us-ascii?Q?oT0x55kF7cyAUmeB18WdgL6/qAYYeOO4VfTB35FqT+B7X3xMMx2Mbc6lB4fS?=
 =?us-ascii?Q?qtwT/5BEFt2qfZ1+xipNCSx/b8LgmtwGJS/FpwR+IWR30HS4pbl5chULQSHv?=
 =?us-ascii?Q?aFeRMMl7ASspVUbYtFWjdt0dXOeBMKz+aJ1pKhGODjo5gAuz0qQxEjqRKHP4?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6+X5/ra92taCGW3BkCBjhiKsFQeqyK3UPny6r5EZJJFQmYy5cDblj9Nq2oy4?=
 =?us-ascii?Q?9AFRERKLJI+Ujun8O5sWQ23EHDVIr1TTgU5H+YoqnsFN9aqJn7yHNIzCu3Mg?=
 =?us-ascii?Q?VLei0UWRf9i/DLRMw0GvHrYWjn/glNmQuAwtKAl7W2T79p7IFjAEOqA5b2yM?=
 =?us-ascii?Q?vctC1O4J8v1iNsbVkOHFtifO7FzoExlnCOnTm2KpuDJ6EUnAUbDejbCO4Fov?=
 =?us-ascii?Q?tzrQSmsmciD860z43vJy29jWmmPLeJR4ry4gdjWNUpLAJL/j+61kY2nBy1/N?=
 =?us-ascii?Q?waI2w67QK+rrjBhB0M95Z3Fo7dPHQKoBG0WLWz82hbRK+PLVg6xUScDsRGMH?=
 =?us-ascii?Q?au+TjliaV/PpkK3foz/DWRqDKYQYQl1O8M5yqf7VBPTEoiRw3SSLnxuVPYxI?=
 =?us-ascii?Q?y6HcTjNyPelbXUnb5Q/LZddreBqo33iAAnD2pkWhbRb0wVOQpnHMqxCuxhB4?=
 =?us-ascii?Q?ZS7qqPVhEmSjKzSQP37O0WoviqJLyF/Sa2rQks48ALBCG7UT21zb23C8ONQ/?=
 =?us-ascii?Q?IzNmOXq9N/epbp2TkrVNzdYIygVIuiL5nbVEXxtgJdBdUxx5WzN6wC5vSsBM?=
 =?us-ascii?Q?GROo+E79u+8XQuHH57bu8Ysb8hAK2DvvhdtakLyZ5UJBPykeLl7OE7mu7JnW?=
 =?us-ascii?Q?YWtBBva6GqolGW8xO1BM4e21Yhdxr2hLSKI0/ef1K82UThYN+16akg+bWSYh?=
 =?us-ascii?Q?cz1vZbaiIthXBYtrXhRPVwJlqz0ISe0l+xAsi3Sq9qWjoMlwH1/Tod6hxI6t?=
 =?us-ascii?Q?NgzfFWb0ZRc9CkpP9p9RrvN2KkZkhL9bZj/z16uz4exAmuB16PFIVerKxwbK?=
 =?us-ascii?Q?IR4sl9S1IrzUN3yAT5ny9n98mAhxJ13cb3Vs05V51Av2IUjKCpXlKPAR6lG3?=
 =?us-ascii?Q?JW288YYNIzPUaCl3LjFtYoNMtcyVnpzX9+vZpCh+joef3EnGJOCSvisgylPn?=
 =?us-ascii?Q?Asa/3qlrqb+miY/OJgBix0hwNRJ+Pi1WZ2tN7yWTDjaowbf8E1krjqkJZDia?=
 =?us-ascii?Q?lGcF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440fc629-1d88-471c-388c-08db565e4702
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 22:38:32.3956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yhlpy1hF5GOjZUv4376ZqptJVCoOGXC5ENTa1Y4DXhUz/FzxxCvr74gMMXMNBXIkDx3IDT81lkmEB3NszSBqjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5845
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_12,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160192
X-Proofpoint-GUID: oZtI7lcuyYo2Rb_KQSksYM0tOj8afeXf
X-Proofpoint-ORIG-GUID: oZtI7lcuyYo2Rb_KQSksYM0tOj8afeXf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Xu <peterx@redhat.com> [230516 17:40]:
> On Tue, May 16, 2023 at 10:01:06PM +0100, Lorenzo Stoakes wrote:
> > On Tue, May 16, 2023 at 04:30:11PM -0400, Peter Xu wrote:
> > > On Tue, May 16, 2023 at 08:25:13PM +0100, Lorenzo Stoakes wrote:
> > > > On Tue, May 16, 2023 at 11:06:40AM -0400, Peter Xu wrote:
> > > > > On Tue, May 16, 2023 at 12:07:11AM +0100, Lorenzo Stoakes wrote:
> > > > > > On Mon, May 15, 2023 at 11:04:27PM +0100, Lorenzo Stoakes wrote:
> > > > > > [snip]
> > > > > > > > Could you explain a bit why we don't need to merge in this case?
> > > > > > > >
> > > > > > > > I'm considering, for example, when we have:
> > > > > > > >
> > > > > > > >   vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)
> > > > > > > >
> > > > > > > > Then someone unregisters uffd on range (5-9), iiuc it should become:
> > > > > > > >
> > > > > > > >   vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)
> > > > > > > >
> > > > > > > > But if no merge here it's:
> > > > > > > >
> > > > > > > >   vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)
> > > > > > > >
> > > > > > > > Maybe I missed something?
> > > > > > > >
> > > > > > >
> > > > > > > There's something really, really wrong with this. It simply isn't valid to
> > > > > > > invoke vma_merge() over an existing VMA that != prev where you're not
> > > > > > > specifying addr = vma->vm_start, end == vma->vm_end.
> > > > > > >
> > > > > > > This seems like you're relying on:-
> > > > > > >
> > > > > > >   ***
> > > > > > > CCCCCNNNNN -> CCNNNNNNNN
> > > > >
> > > > > I had a closer look today, I still think this patch is not really the right
> > > > > one.  The split/merge order is something we use everywhere and I am not
> > > > > convinced it must change as drastic.  At least so far it still seems to me
> > > > > if we do with what current patch proposed we can have vma fragmentations.
> > > >
> > > > 'something we use everywhere' is not an argument (speak to Willy about
> > > > folios), vma_merge() expects valid input, relying on it _happening_ to be
> > >
> > > I still think it's an argument.
> > >
> > > I believe Matthew tried hard to justify he's correct in that aspect when
> > > changing "something we used everywhere". Blindly referencing it doesn't
> > > help much on a technical discussion.
> > >
> > > If we have similar code that handles similar things, IMHO you need a reason
> > > to modify one of them to not like the other.
> > >
> > > If you think what you proposed is better, please consider (1) justify why
> > > it's better, and then (2) also apply it to all the rest places where
> > > applicable.  Please refer to my reply to Liam on the other use cases of
> > > vma_merge().
> > >
> > > Said that, I apprecaite a lot on your assert patch that found this problem.
> > >
> > > > ok or to fail in ways that _happen_ not to cause big problems is not right.
> > > >
> > > > This is just further evidence that the vma_merge() interface is
> > > > fundamentally broken. Implicitly assuming you will only get a partial prev
> > > > overlap merge is far from intuitive.
> > > >
> > > > I am definitely going to try to do a series addressing vma_merge() horrors
> > > > because I feel like we need a generic means of doing this split/merge pattern.
> > >
> > > It'll be great if you can make it better.
> > >
> > > >
> > > > >
> > > > > I think I see what you meant, but here I think it's a legal case where we
> > > > > should have PPPP rather than CCCC (PPPPPNNNN --> PPNNNNNNNN).
> > > > >
> > > > > To be explicit, for register I think it _should_ be the case 0 where we
> > > > > cannot merge (note: the current code is indeed wrong though, see below):
> > > > >
> > > > >    ****
> > > > >   PPPPPPNNNNNN
> > > > >   cannot merge
> > > > >
> > > > > While for the unregister case here it's case 4:
> > > > >
> > > > >     ****
> > > > >   PPPPPPNNNNNN
> > > > >   might become
> > > > >   PPNNNNNNNNNN
> > > > >   case 4 below
> > > > >
> > > > > Here the problem is not that we need to do split then merge (I think it'll
> > > > > have the problem of vma defragmentation here), the problem is we simply
> > > > > passed in the wrong "prev" vma pointer, IMHO.  I've patches attached
> > > > > showing what I meant.
> > > >
> > > > Yeah if you do it with prev = vma this form should _probably_ work, that's
> > > > a good point. This _is_ a case (see https://ljs.io/vma_merge_cases.png for
> > > > nice diagram of cases btw :), like 5, where we actually do split and merge
> > > > at the same time.
> > >
> > > It's not something I came up with myself, it's just that I started looking
> > > back to see what people did and trying to understand why they did it.
> > > Normally people did things with good reasons.
> > >
> > 
> > Yup, it's an iffy pattern in each case. I can see why you chose to do it,
> > it's not a criticism of that, it's just that the incorrect (but
> > accidentally ok to be incorrect seemingly) input is made more obvious by
> > recent changes.
> > 
> > > So far it seems clearer at least to me to keep this pattern of "merge then
> > > split".  But I'm happy to be proven wrong anytime.
> > 
> > But you're not, you're doing a vma_merge() and (without it being clear)
> > hoping it does a merge AND SPLIT in case in an instance where that might be
> > required followed by you doing any further splits required.
> 
> I don't quite get the reason that you seem to keep saying this is
> "incorrect input" to vma_merge().  vma_merge() definitely includes splits
> too where it can, to be explicit, for case 4 & 5.
> 
> It seems to me what you're trying to explain is we shouldn't handle any
> split in vma_merge() so we should move cases 4 & 5 out of vma_merge().  If
> we split first then merge, cases 4 & 5 will become case 2 & 3 after split.

We don't split in case 4 or 5 - we adjust the existing VMA limits.  We
don't actually handle any splits in vma_merge().  I think splitting
first would change 4 & 5 to 7 & 8?  2 & 3 would require a split and
munmap, right?

> My question would be: if it worked perfect in the past few years and it
> looks all good enough, why bother..

I suspect, but it's not clear (like all of this), that the other
arguments to vma_merge() is ruling out this potential hazard I thought
existed.

> 
> > 
> > But it's _not your fault_ that this is the standard approach, it's the
> > interface that's wrong absolutely.
> > 
> > To me doing this is quite a bit less clear than simply 'splitting so this
> > is mergable first then try to merge' but obviously this current patch does
> > not avoid the previously introduced fragmentation. However it does maintain
> > existing behaviour.
> > 
> > >
> > > >
> > > > Liam's raised some issues with the safety of your patches, let me look at
> > > > them when I get a chance, nasty headcold = brain less functional atm.
> > >
> > > Sure, no need to rush.
> > >
> > > >
> > > > I would say for now this fix resolves the issue in a way that should
> > > > emphatically avoid invalid input to vma_merge(), the fragmentation existed
> > > > before so this is not a new issue, so for the time being I think it's ok to
> > > > stay as-is.
> > >
> > > So far I would still suggest having uffd code the same as the rest if
> > > possible.
> > >
> > 
> > Absolutely, but in the immediate term, we are seeing VM_WARN_ON()'s here
> > and not from other callers (which is actually surprising).
> 
> Not surprising anymore to me, simply because the uffd path was the only one
> got overlooked when converting to maple in commit 69dbe6daf104, as Liam
> rightfully pointed out.
> 
> For example, mprotect() has similar handling when the start addr of the
> range can be in the middle of a vma, then in do_mprotect_pkey() there is:
> 
> 	prev = vma_prev(&vmi);
> 	if (start > vma->vm_start)
> 		prev = vma;
> 
> IMHO it's the same thing.
> 
> > 
> > Again, we absolutely do need an abstracted solution for the whole. And
> > that's something I'll try to work on!
> > 
> > > I think I'll wait for the other discussion to settle on patch 2 to see
> > > whether I should post a formal patchset.
> > 
> > My suggestion is that it's ok to proceed as-is, not because this is the
> > final change that should be applied, but rather because it resolves the
> > issue while maintaining existing behaviour.
> > 
> > I will be more than happy to see patches land after this one that replace
> > it if necessary but I think it's safe for this to land as a mainline fixup,
> > even if temporary, is all I am saying :)
> 
> I'd hope we can replace this patch with my patch 1 if possible because I
> _think_ this patch is still in hotfixes-unstable (while patch 2 doesn't
> need to copy stable in all cases).  Andrew may know better on how to
> proceed.
> 
> If this lands first, I'll probably propose a full revert otherwise as the
> 1st patch of the patchset to post, then make uffd the same as others.
> 
> Before that I'd like to know whether you agree that the new patch 1 (I'll
> fixup the vma_prev() side effect) could be a better solution than the
> current one, no matter whether we need a full revert or not.
> 
> Thanks,
> 
> > 
> > >
> > > >
> > > > >
> > > > > I checked the original commit from Andrea and I found that it _was_ correct:
> > > > >
> > > > > commit 86039bd3b4e6a1129318cbfed4e0a6e001656635
> > > > > Author: Andrea Arcangeli <aarcange@redhat.com>
> > > > > Date:   Fri Sep 4 15:46:31 2015 -0700
> > > > >
> > > > >     userfaultfd: add new syscall to provide memory externalization
> > > > >
> > > > > I had a feeling that it's broken during the recent rework on vma (or maybe
> > > > > even not that close), but I'm not yet sure and need to further check.
> > > > >
> > > > > > >
> > > > > > > By specifying parameters that are compatible with N even though you're only
> > > > > > > partially spanning C?
> > > > > > >
> > > > > > > This is crazy, and isn't how this should be used. vma_merge() is not
> > > > > > > supposed to do partial merges. If it works (presumably it does) this is not
> > > > > > > by design unless I've lost my mind and I (and others) have somehow not
> > > > > > > noticed this??
> > > > > > >
> > > > > > > I think you're right that now we'll end up with more fragmentation, but
> > > > > > > what you're suggesting is not how vma_merge() is supposed to work.
> > > > > > >
> > > > > > > As I said above, giving vma_merge() invalid parameters is very dangerous as
> > > > > > > you could end up merging over empty ranges in theory (and could otherwise
> > > > > > > have corruption).
> > > > > > >
> > > > > > > I guess we should probably be passing 0 to the last parameter in
> > > > > > > split_vma() here then to ensure we do a merge pass too. Will experiment
> > > > > > > with this.
> > > > > > >
> > > > > > > I'm confused as to how the remove from case 8 is not proceeding. I'll look
> > > > > > > into this some more...
> > > > > > >
> > > > > > > Happy to be corrected if I'm misconstruing this!
> > > > > > >
> > > > > >
> > > > > > OK, so I wrote a small program to do perform exactly this case [0] and it seems
> > > > > > that the outcome is the same before and after this patch - vma_merge() is
> > > > > > clearly rejecting the case 8 merge (phew!) and in both instances you end up with
> > > > > > 3 VMAs.
> > > > > >
> > > > > > So this patch doesn't change this behaviour and everything is as it was
> > > > > > before. Ideally we'd let it go for another pass, so maybe we should change the
> > > > > > split to add a new VMA _afterwards_. Will experiment with that, separately.
> > > > > >
> > > > > > But looks like the patch is good as it is.
> > > > > >
> > > > > > (if you notice something wrong with the repro, etc. do let me know!)
> > > > > >
> > > > > > [0]: https://gist.github.com/lorenzo-stoakes/a11a10f5f479e7a977fc456331266e0e
> > > > >
> > > > > I think your test case is fine, but... no, this is still not expected. The
> > > > > vma should just merge.
> > > > >
> > > > > So I have another closer look on this specific issue, it seems we have a
> > > > > long standing bug on pgoff calculation here when passing that to
> > > > > vma_merge().  I've got another patch attached to show what I meant.
> > > > >
> > > > > To summarize.. now I've got two patches attached:
> > > > >
> > > > > Patch 1 is something I'd like to propose to replace this patch that fixes
> > > > > incorrect use of vma_merge() so it should also eliminate the assertion
> > > > > being triggered (I still think this is a regression but I need to check
> > > > > which I will do later; I'm not super familiar with maple tree work, maybe
> > > > > you or Liam can quickly spot).
> > > > >
> > > > > Patch 2 fixes the long standing issue of vma not being able to merge in
> > > > > above case, and with patch 2 applied it should start merging all right.
> > > > >
> > > > > Please have a look, thanks.
> > > > >
> > > > > ---8<---
> > > > > From 6bc39028bba246394bb0bafdaeaab7b8dfd1694f Mon Sep 17 00:00:00 2001
> > > > > From: Peter Xu <peterx@redhat.com>
> > > > > Date: Tue, 16 May 2023 09:03:22 -0400
> > > > > Subject: [PATCH 1/2] mm/uffd: Fix vma operation where start addr cuts part of
> > > > >  vma
> > > > >
> > > > > It seems vma merging with uffd paths is broken with either
> > > > > register/unregister, where right now we can feed wrong parameters to
> > > > > vma_merge() and it's found by recent patch which moved asserts upwards in
> > > > > vma_merge():
> > > > >
> > > > > https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> > > > >
> > > > > The problem is in the current code base we didn't fixup "prev" for the case
> > > > > where "start" address can be within the "prev" vma section.  In that case
> > > > > we should have "prev" points to the current vma rather than the previous
> > > > > one when feeding to vma_merge().
> > > > >
> > > > > This will eliminate the report and make sure vma_merge() calls will become
> > > > > legal again.
> > > > >
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > ---
> > > > >  fs/userfaultfd.c | 27 +++++++++++++++++++++------
> > > > >  1 file changed, 21 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > > index 0fd96d6e39ce..7eb88bc74d00 100644
> > > > > --- a/fs/userfaultfd.c
> > > > > +++ b/fs/userfaultfd.c
> > > > > @@ -1458,10 +1458,17 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > > > >  	BUG_ON(!found);
> > > > >
> > > > >  	vma_iter_set(&vmi, start);
> > > > > -	prev = vma_prev(&vmi);
> > > > > +	vma = vma_find(&vmi, end);
> > > > > +	if (!vma)
> > > > > +		goto out_unlock;
> > > > > +
> > > > > +	if (vma->vm_start < start)
> > > > > +		prev = vma;
> > > > > +	else
> > > > > +		prev = vma_prev(&vmi);
> > > > >
> > > > >  	ret = 0;
> > > > > -	for_each_vma_range(vmi, vma, end) {
> > > > > +	do {
> > > > >  		cond_resched();
> > > > >
> > > > >  		BUG_ON(!vma_can_userfault(vma, vm_flags));
> > > > > @@ -1517,7 +1524,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > > > >  	skip:
> > > > >  		prev = vma;
> > > > >  		start = vma->vm_end;
> > > > > -	}
> > > > > +	} for_each_vma_range(vmi, vma, end);
> > > > >
> > > > >  out_unlock:
> > > > >  	mmap_write_unlock(mm);
> > > > > @@ -1624,9 +1631,17 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> > > > >  	BUG_ON(!found);
> > > > >
> > > > >  	vma_iter_set(&vmi, start);
> > > > > -	prev = vma_prev(&vmi);
> > > > > +	vma = vma_find(&vmi, end);
> > > > > +	if (!vma)
> > > > > +		goto out_unlock;
> > > > > +
> > > > > +	if (vma->vm_start < start)
> > > > > +		prev = vma;
> > > > > +	else
> > > > > +		prev = vma_prev(&vmi);
> > > > > +
> > > > >  	ret = 0;
> > > > > -	for_each_vma_range(vmi, vma, end) {
> > > > > +	do {
> > > > >  		cond_resched();
> > > > >
> > > > >  		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
> > > > > @@ -1692,7 +1707,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> > > > >  	skip:
> > > > >  		prev = vma;
> > > > >  		start = vma->vm_end;
> > > > > -	}
> > > > > +	} for_each_vma_range(vmi, vma, end);
> > > > >
> > > > >  out_unlock:
> > > > >  	mmap_write_unlock(mm);
> > > > > --
> > > > > 2.39.1
> > > > >
> > > > > From bf61f3c937e9e2ab96ab2bed0005cb7dc74db231 Mon Sep 17 00:00:00 2001
> > > > > From: Peter Xu <peterx@redhat.com>
> > > > > Date: Tue, 16 May 2023 09:39:38 -0400
> > > > > Subject: [PATCH 2/2] mm/uffd: Allow vma to merge as much as possible
> > > > >
> > > > > We used to not pass in the pgoff correctly when register/unregister uffd
> > > > > regions, it caused incorrect behavior on vma merging.
> > > > >
> > > > > For example, when we have:
> > > > >`
> > > > >   vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)
> > > > >
> > > > > Then someone unregisters uffd on range (5-9), it should become:
> > > > >
> > > > >   vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)
> > > > >
> > > > > But with current code it's:
> > > > >
> > > > >   vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)
> > > > >
> > > > > This patch allows such merge to happen correctly.
> > > > >
> > > > > This behavior seems to have existed since the 1st day of uffd, keep it just
> > > > > as a performance optmization and not copy stable.
> > > > >
> > > > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > > > Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > ---
> > > > >  fs/userfaultfd.c | 8 ++++++--
> > > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > > index 7eb88bc74d00..891048b4799f 100644
> > > > > --- a/fs/userfaultfd.c
> > > > > +++ b/fs/userfaultfd.c
> > > > > @@ -1332,6 +1332,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > > > >  	bool basic_ioctls;
> > > > >  	unsigned long start, end, vma_end;
> > > > >  	struct vma_iterator vmi;
> > > > > +	pgoff_t pgoff;
> > > > >
> > > > >  	user_uffdio_register = (struct uffdio_register __user *) arg;
> > > > >
> > > > > @@ -1489,8 +1490,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > > > >  		vma_end = min(end, vma->vm_end);
> > > > >
> > > > >  		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> > > > > +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > > > >  		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> > > > > -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> > > > > +				 vma->anon_vma, vma->vm_file, pgoff,
> > > > >  				 vma_policy(vma),
> > > > >  				 ((struct vm_userfaultfd_ctx){ ctx }),
> > > > >  				 anon_vma_name(vma));
> > > > > @@ -1570,6 +1572,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> > > > >  	unsigned long start, end, vma_end;
> > > > >  	const void __user *buf = (void __user *)arg;
> > > > >  	struct vma_iterator vmi;
> > > > > +	pgoff_t pgoff;
> > > > >
> > > > >  	ret = -EFAULT;
> > > > >  	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
> > > > > @@ -1677,8 +1680,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> > > > >  			uffd_wp_range(vma, start, vma_end - start, false);
> > > > >
> > > > >  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> > > > > +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > > > >  		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> > > > > -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> > > > > +				 vma->anon_vma, vma->vm_file, pgoff,
> > > > >  				 vma_policy(vma),
> > > > >  				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> > > > >  		if (prev) {
> > > > > --
> > > > > 2.39.1
> > > > > ---8<---
> > > > >
> > > > > --
> > > > > Peter Xu
> > > > >
> > > >
> > >
> > > --
> > > Peter Xu
> > >
> > >
> > 
> 
> -- 
> Peter Xu
> 
