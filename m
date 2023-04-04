Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9157A6D6B2D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbjDDSFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjDDSEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:04:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F49C4EE5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:04:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334Dx8hT023727;
        Tue, 4 Apr 2023 18:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=lYriMtzpfqkZdPZegEeI0/rZvHhRrLX+P0vCUW73HKA=;
 b=yj/MFDsWsfDZetWGXrPbL6tBU3AhYvoJFQhbyT5FI8JGdHZHBL5VZuP78cRKH237WbAP
 jicfoU24ui9Zc1tpvtNvvmYsvaoUOVAuVVTFP4fDedE5s2GikJ1z6rlISI0TTgnnpJ89
 MWjSqrITyVRLFW4HugabYu6aAIUhXmehfQEB3hTYCZy1br3+HTE//ZFmFLGFF82pL5bq
 0yyz95BDvV2/FIyamOc0gbb5JoYbBUm0ET/jmR2JiXgsqvgo/GzN+/rKA2m9LGC5/r1A
 AfRHtLfvU6lJAweabi0zIyyyBWzoor/nt3m5C/GgE+XS+C03/OPZ3TRyR5L794J8lmwQ 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7txfxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:03:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334HYvii039569;
        Tue, 4 Apr 2023 18:03:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt26rm61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:03:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYMuK7Dx4NQrbc2DFxfdninhTu09QXqQH+nwogcawjj4hFdY8ePpuTXwqM4VNbPkdup9yXXNO4038cIdYptnbDsUsYdSTYhAz34NyclecjHc1G2uY+6DicNJH6Wixl2c7yBij/+6eE9uzsBiM//zmodSV8vsmhPbJik/nq5z9BaP+UQkG3qHiUebUgl8y/qCVvhtgfxs1cRaLLDa4L0Btb80W6kVzzRC/gUv9KPRd/irJs2beHRmXa6UgkQ4u9uf8ykGoDrnBBS1gcH0P6rlWSmb6OfA+RdDxtXsA3tuC/r8Q0ef9qzulVJnt/4c/rB6XHQAnDLL3coGxexPKioQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYriMtzpfqkZdPZegEeI0/rZvHhRrLX+P0vCUW73HKA=;
 b=m0ft0YxSkYFgEDsEvzKnQItEnGd9O5nGPBUx3z+NTVsQfsTy1sc5b1+fOg2Sm4o2nzzs6pTmD2XRDaneNI7vm4HKTA2h1p+bqlLYL41jkkzTp/fFt2AxLwFtFb+kk/inc3bB/CcA1g7QSz3qaPGqfBu8bQCwAz/hdlu+hDd/WpbsbQpXAGnZatFkUAjliFQ2iwFqaG27mkQK8oIqwnijsqc7J904+FI03tB0bN33eBfRPXVyv1+iksVsz5vnSdkDbnplIkADy2o+6ghtzzRFJC38ccCwvJv9pPZLnrwb3/HmRjSjS0kNvhYNDRevWuZadBZiI+9nHe0AFSlNzEAnvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYriMtzpfqkZdPZegEeI0/rZvHhRrLX+P0vCUW73HKA=;
 b=W4wEfpFrczhHIKzfKe6FfBsWnqj03t4GBP1mSe0voB3RVdlyMK21qxlQoQlwKnHtYgoikh9fA/aE/z6kqkRs9Q0nbWgwPg+bBvOjGas0NzVB6darvoC0VqSlNBpJvkVo19gx0EUx6g8hU1wUSkXvAWbB6i4XhfNuPlwsQLWsDCM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN0PR10MB5909.namprd10.prod.outlook.com (2603:10b6:208:3cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 18:03:52 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3%9]) with mapi id 15.20.6254.028; Tue, 4 Apr 2023
 18:03:52 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v21 2/7] crash: add generic infrastructure for crash hotplug support
Date:   Tue,  4 Apr 2023 14:03:21 -0400
Message-Id: <20230404180326.6890-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404180326.6890-1-eric.devolder@oracle.com>
References: <20230404180326.6890-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0010.eurprd04.prod.outlook.com
 (2603:10a6:208:122::23) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN0PR10MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9570c0-58c1-4e02-6ffe-08db3536f2ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKdCClmXREVgHA2opcejiqG2z+TyNSlqikNzaAPJCtiRp7SP8WmCkiLtIhzDbeXFpGxPaX9Rskrw7JvQ2JjpWmQGrJ7Z+WJKUZFr3go3s/AT0A04ovmWh/lwIW2imTjxE/GzHsLjVp/gho4bOgwUVAOhmTfl0iKjWlcaOgy8ItHan0BJwdTRXxUh6sPdaDb/Yg0rGDCD/Cfs8Fm4SJZfvs/X05p0KDFJNA1TIlkHH0jj6aXmhlRflII2b7L+W3vbMp+hA4go7SVvd1qUHEQp/y/0qCXiCqpHmsg5epFdvaHk1CjG9MX6SfGo8r9PTorCzCYlET9prQpvAbVjCiqdGpD/lT5hS1/LMDu5baOuf5sLNJcinfaEesa1+yBRDXNVLAiSrs2ElNkTk0PGNbMpLUP4u3dPdMUrj4YzgmtOJi3QH9kLF96zQklzGbna94h9yUy/b8LeoSBfF4+crokawu0KR/lBxbFIeujiVwN57jLxkxrElaBhvl49kMqIpRrhFMtX4OGLKVnwpdv70QoE8I3R9o96YJePxFBj1Sult4ttW+JH/5ydra2MnXvPzVmLLyUuyK4xVfGJdH/aR6ceFSc58FqwRFkTmqUuvKBRfGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(83380400001)(4326008)(8676002)(66946007)(316002)(66556008)(66476007)(86362001)(2906002)(41300700001)(478600001)(36756003)(38100700002)(2616005)(8936002)(6486002)(5660300002)(6512007)(7416002)(186003)(107886003)(6666004)(26005)(6506007)(1076003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uV/066FfoslGnLJY9GnlGFF5giYD6qHURYZqW6pOvhYox3xXbGF65yr0Z7eX?=
 =?us-ascii?Q?TVG98mkBjUC/2Z7So6A8Y4oXcDgV4gfHLN18/CecQryJ4W0bHjSqXXWxl7uC?=
 =?us-ascii?Q?ngb1dA1qOx3kgt6nR5oPxZCAuTHqvqLiKrKA7Rwh/yoR/TMi9vL6buXC+XxG?=
 =?us-ascii?Q?BWrIAj9IORgpMKrz+0u2PmQ/usn65w/2/hBn6kdZFAAqR0SDVXuGV/qhuenX?=
 =?us-ascii?Q?MgtI/FE47zf+ypUBnbIlYuNByvXxjpNfyI6k630BIqqCaVtRTjaFgPwnspfX?=
 =?us-ascii?Q?dsamygJ0htt8vjPWjrVAVWLISkFzZR3TnLFjK+ZVW4qI1BTHA2A5RfubQwCJ?=
 =?us-ascii?Q?WSDrYLeBShjzXjZb9zFleZZLmyQYyktnh2tG3hraKgshTmjkqtxQtZY5U7uI?=
 =?us-ascii?Q?CJQxbuFDYqVHpJICmF86n4bAqNxxp14xtwFeIUYle6vQNZCcfW6ooHyI1pwa?=
 =?us-ascii?Q?IEQMXUhL+L7P/jJnj96xdg7rqBC8ONs9k0mD72AzT/hXmbzRMyKgnHM70bLR?=
 =?us-ascii?Q?1W8M60NDob+E2RGLkSynTIyBw0xWXR1eHjKx/3MzrDzT7xsVKN7MMcWcIj5T?=
 =?us-ascii?Q?Nuc8DLvOZt1Jwmpl7Wk6KIyJHmHpSohPi5n07otZ6ILIO0Oe8l5wjZ4x9B2s?=
 =?us-ascii?Q?dTW86cNCA2WyggN13drmDK1n2Oa8O/kRVN7XtgDMvd1+adOplqe8FYLeqx1t?=
 =?us-ascii?Q?TgRrijhnkm/7WaPOKq4uXKcgphzZvcuykaQ+JKzQE5MmeZOdo4SaQ+Y0mLDA?=
 =?us-ascii?Q?LqgI0CNUTB1r7Cw9HtzNWH9/VHydZo1aOvFyN7WFGRr17bHU81QW4QD5qj1y?=
 =?us-ascii?Q?IHEGuSuPA0Bs2JFi0Kj9uiro/U7lz1I+aXhFPv7rxGNQnXb92n+VwFbK+4mI?=
 =?us-ascii?Q?bLMoNXyXmC0vrJWiS2LFqtqUVDz4Vk4fZDBJaH7lb0yy1Ly9EGvKbyQafhuI?=
 =?us-ascii?Q?NubDqOU8hjTdTYuM/qnm8O3TnApsCpw71MgmnT0EZjg4ehaxi8FJifZW9to0?=
 =?us-ascii?Q?CRTCJzahoWwop7QsLTBoxfe6v8X2gxGh/MgXPKdh9H6ZrXCKE1oYP03AUWeR?=
 =?us-ascii?Q?prBRQOEx9FMA9eDg+LL0LMmD0O6hZiDlkzSZqX7DxtbmSWZEZtZV89lleWQl?=
 =?us-ascii?Q?61KVZy7tvN5P7gKqL4EefHFs91X8vN96UABZzb3l/6rlktKjZJGT2O8W6IAF?=
 =?us-ascii?Q?CFHJReNa0M3lkWQxi6VN2PM59d6DaKwcoxe3on/Au9b0J4EMpLonA/iTEdLK?=
 =?us-ascii?Q?o6eBWnNb3lQf15ZFoacydFevm8LoV1H9UfbO0/kXP9l2WsPCASZLeyi7d5Jf?=
 =?us-ascii?Q?OHWyPuPdimKLZo10HFaY5PVIZjWXH/4x4va8oC3BYdlAi+BoeaOFPTtwtdQu?=
 =?us-ascii?Q?I0lgUcIUtDHpw1K727vYZgy8FJ+J9p2KZWNkUkON7jAIURS+lmrPnfM9C0s5?=
 =?us-ascii?Q?/mD4Eq7JpVmt/buMxm1RzV5XS8PIPy/jZ60AP4wcRzfugfTwM9GaR+rwNKIq?=
 =?us-ascii?Q?One95QrVEZG2dIg0ebtNw2LgdYeUO57FUdOVUE4dH7FpeJlzwUyRdy3QlGuK?=
 =?us-ascii?Q?YbMye1riUg+DtqKE1oi/zpxupV87MVBQHP/eycDBJAxYl2lOQRWtUg1lhvRP?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?p1PxMXwv/XyfrCOpJ348gc2q9dlRDiamw4ywJvSH/224C8/7mRDoXlikwmCq?=
 =?us-ascii?Q?M36lCSBoi/TMNq1GsRjD6YnDFBZm8Iw/07pakeNNnpb4hqc1DhqOQscGvQq/?=
 =?us-ascii?Q?FuA6WyHnYs1T7YH5IiE9uUT2QnmphiG34tMfQMirkGD5sUVMdGnL9rr10hnj?=
 =?us-ascii?Q?PBg9u14ZNE5AhkkwpiH4SO4hh94o0WpfUHKoUwXYSn7iJfuSgGQbdo7vdbAH?=
 =?us-ascii?Q?a5NUHU1LZ8oOMHCDOV4QkbtiLb5l0mbHnUWmIp1quew7NuvyWOxPp+vBq9WA?=
 =?us-ascii?Q?mljJWI24L4ZM6cxLJma5oV/jtKSMO9+oKMVUsllUbY/JFWfidPVBPrIKgf3O?=
 =?us-ascii?Q?3MXDaWFA5iXFgAL0N3g4O3+DzMYsBXFiAkqSOtiiR1CkyuwJwM+xSLgrK3I2?=
 =?us-ascii?Q?tBzNWiDc9F523PSfKAiprTl3omCtNL5EwIGqbL7Dt2MNz5BuoNyhvTXh6sP6?=
 =?us-ascii?Q?Cftc9K88qUshlwxiAOyTXDSrKcdiy9PlNjM3sNW/vFR0G0NJILSSfgpEmwB6?=
 =?us-ascii?Q?8UQPs3waj5nJ0gjkWUiJYLLD1aWPQT89ilsqNkjAYmpnvMMB4ZCz9wPMhuBl?=
 =?us-ascii?Q?oPI4c12dfFHe7UVyfdQqjuzvzOHjmAvSfiadQVDy25mAk0MFdpQD7GQhDYr2?=
 =?us-ascii?Q?pshfq2XwxEWOpouYUygsS5iFffZzHmgDPml+0QhDHNebkbxzTou/6P2anY2m?=
 =?us-ascii?Q?psa/A3MUcF6/5u5DkH+pn7l4bChMkjV/UtYfZ8GWa+w8qIFjbevRnQLYm0Tf?=
 =?us-ascii?Q?IbOOO1OHTWLxd7mI7SyJQKXKUH9T86FD13RSnRNjA02hu5Z6QgGku2GdlyvC?=
 =?us-ascii?Q?f9OVZEqACLd8t58EEcGX+8wfWYJ5lPR5WfRy/tE33xhJStO9xs93Nx3XW3af?=
 =?us-ascii?Q?TTClQ3QNNzdsOoEaFoDGUzTRXwKUIE+hxXR8H8A1pc1sHkDTyIeXzbNSJFLv?=
 =?us-ascii?Q?7RHvz+9Z75mRYXr7uclNImjgzlzsJo75V/vBJAAD4/J2PScRHcPIUsCgQkRb?=
 =?us-ascii?Q?20fUafEU9G3Lqs++TuGnoIOde2HVCS9i35zfZAx+QWRWOkBbLxiOIkfTp5L7?=
 =?us-ascii?Q?Qs5anfaXY0dpZ1oS3zILlz5B2zBRnT3YhiD/jpEVBRGDvDRfgC7XOMzafZbv?=
 =?us-ascii?Q?B388D813tcOFeuMobZPpCWbPhZbJJoFT9IAtTNVM2jXJO4eTOyeiiLk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9570c0-58c1-4e02-6ffe-08db3536f2ac
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 18:03:52.2579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W57+O2NWikDRpeMsTvPHjkW4tNkqxKVkXnWm3Kidb3pOyLb8iTjQtR3BcGi+Uq4hrsB/tJwd2tuDYPo/RlaoyQnhj5AeuIelq8VUtCnxst4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_09,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040165
X-Proofpoint-ORIG-GUID: xEOmv4uMrNNQBKKYnaU9d-SVYLt_hc43
X-Proofpoint-GUID: xEOmv4uMrNNQBKKYnaU9d-SVYLt_hc43
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support crash hotplug, a mechanism is needed to update the crash
elfcorehdr upon CPU or memory changes (eg. hot un/plug or off/
onlining). The crash elfcorehdr describes the CPUs and memory to
be written into the vmcore.

To track CPU changes, callbacks are registered with the cpuhp
mechanism via cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN). The
crash hotplug elfcorehdr update has no explicit ordering requirement
(relative to other cpuhp states), so meets the criteria for
utilizing CPUHP_BP_PREPARE_DYN. CPUHP_BP_PREPARE_DYN is a dynamic
state and avoids the need to introduce a new state for crash
hotplug. Also, this is the last state in the PREPARE group, just
prior to the STARTING group, which is very close to the CPU
starting up in a plug/online situation, or stopping in a unplug/
offline situation. This minimizes the window of time during an
actual plug/online or unplug/offline situation in which the
elfcorehdr would be inaccurate. Note that for a CPU being unplugged
or offlined, the CPU will still be present in the list of CPUs
generated by crash_prepare_elf64_headers(). However, there is no
need to explicitly omit the CPU, see the discussion in the patch
'crash: change crash_prepare_elf64_headers() to
for_each_possible_cpu()'.

To track memory changes, a notifier is registered to capture the
memblock MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The CPU callbacks and memory notifiers invoke crash_handle_hotplug_event()
which performs needed tasks and then dispatches the event to the
architecture specific arch_crash_handle_hotplug_event() to update the
elfcorehdr with the current state of CPUs and memory. During the
process, the kexec_lock is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 include/linux/crash_core.h |   9 +++
 include/linux/kexec.h      |  11 +++
 kernel/crash_core.c        | 142 +++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c        |   6 ++
 4 files changed, 168 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..e14345cc7a22 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,13 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_NONE			0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_CPU		2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_REMOVE_MEMORY		4
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 61443f8395f7..f9bd46fcbd5d 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -33,6 +33,7 @@ extern note_buf_t __percpu *crash_notes;
 #include <linux/compat.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/highmem.h>
 #include <asm/kexec.h>
 
 /* Verify architecture specific macros are defined */
@@ -368,6 +369,12 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	int hp_action;
+	int elfcorehdr_index;
+	bool elfcorehdr_updated;
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
@@ -498,6 +505,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 45d241aebe3d..0d87b796e5cf 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -11,6 +11,8 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/kexec.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -18,6 +20,7 @@
 #include <crypto/sha1.h>
 
 #include "kallsyms_internal.h"
+#include "kexec_internal.h"
 
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
@@ -697,3 +700,142 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+/*
+ * To accurately reflect hot un/plug changes of cpu and memory resources
+ * (including onling and offlining of those resources), the elfcorehdr
+ * (which is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories.
+ *
+ * In order to make changes to elfcorehdr, two conditions are needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources; the elfcorehdr memory size
+ * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ */
+static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	struct kimage *image;
+
+	/* Obtain lock while changing crash information */
+	if (!kexec_trylock()) {
+		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		return;
+	}
+
+	/* Check kdump is not loaded */
+	if (!kexec_crash_image)
+		goto out;
+
+	image = kexec_crash_image;
+
+	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
+	else
+		pr_debug("hp_action %u\n", hp_action);
+
+	/*
+	 * When the struct kimage is allocated, the elfcorehdr_index
+	 * is set to -1. Find the segment containing the elfcorehdr,
+	 * if not already found. This works for both the kexec_load
+	 * and kexec_file_load paths.
+	 */
+	if (image->elfcorehdr_index < 0) {
+		unsigned long mem;
+		unsigned char *ptr;
+		unsigned int n;
+
+		for (n = 0; n < image->nr_segments; n++) {
+			mem = image->segment[n].mem;
+			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+			if (ptr) {
+				/* The segment containing elfcorehdr */
+				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+					image->elfcorehdr_index = (int)n;
+				kunmap_local(ptr);
+			}
+		}
+	}
+
+	if (image->elfcorehdr_index < 0) {
+		pr_err("unable to locate elfcorehdr segment");
+		goto out;
+	}
+
+	/* Needed in order for the segments to be updated */
+	arch_kexec_unprotect_crashkres();
+
+	/* Differentiate between normal load and hotplug update */
+	image->hp_action = hp_action;
+
+	/* Now invoke arch-specific update handler */
+	arch_crash_handle_hotplug_event(image);
+
+	/* No longer handling a hotplug event */
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_updated = true;
+
+	/* Change back to read-only */
+	arch_kexec_protect_crashkres();
+
+out:
+	/* Release lock now that update complete */
+	kexec_unlock();
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+
+	case MEM_OFFLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
+			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
+	}
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3d578c6fefee..8296d019737c 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -277,6 +277,12 @@ struct kimage *do_kimage_alloc_init(void)
 	/* Initialize the list of unusable pages */
 	INIT_LIST_HEAD(&image->unusable_pages);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_index = -1;
+	image->elfcorehdr_updated = false;
+#endif
+
 	return image;
 }
 
-- 
2.31.1

