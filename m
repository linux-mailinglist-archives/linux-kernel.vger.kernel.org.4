Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A095874B3FD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjGGPTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjGGPT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:19:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D555A2691
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:19:14 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367FFkZc018327;
        Fri, 7 Jul 2023 15:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=7fe8xiTMupvdcX7mGKnhWEiEIdqHUqRGKjIndYdAS/Q=;
 b=a6AKNP0sDh5ilrbvNeHroRpyElJIKyn0p5dlEt0yG/otybdHt8pP9SY9P9ez3ClFo2fx
 XqL86miAjcju+4Jf2pJrRMNMyh4wfh79vq+xWFAIO+qfIUp1jZIJ+64+3ozIFLSWxa/q
 B1ch54DeRqjXXTGqc7ygQk/G5vVpKOnETCLvkfx4fkerOCScJoYCeSwAzKWpvzP+7s2G
 EIIiSd7RUAhVUc07ukOrwsDoabc9ZvkwJ0XcMxxIOAXYlbEZ73Xk8YMVHC6V2E1/7VjD
 9tSvgAxyE5cxoIPEaCiQs/XNR9OOZEv3Jk5aTgGTu3sK6ViQfb7PznUkmcHt20nBYM+L jA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6cu84r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 15:18:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367E1JCD033435;
        Fri, 7 Jul 2023 15:18:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8rq82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 15:18:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjWRJMAJjrTZ/eOn+ARsJ7qn0NEZFqH7hitLuwXpdl+nD7vz3qdvJWBUn9WMW3Q5UO4xzu6V4ihW+NwN4T45NiE+omrRGHxcI4fCag+PwfCdG0W2uhZAyy7G+qLjaELh7xSdcq2hbXU5YujpFBmtir264jEmXEIbQpO/OmXsGLhKVSUIB8zNh8nqbi40DjJfgpEs1HHL64vQVv/GLjLHCYJ9q1Y5krQe2tyejH9zfqQmoZ73TKn21IwCZFCGu4IHkcFqmk1RqQTfkqC1UbvmqrGmLOoBS7LDAFA9Gr2DvcYsHb44hEL+aAhLtcHa6Xuz/myh9VVzKoFG/tfdH2UaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fe8xiTMupvdcX7mGKnhWEiEIdqHUqRGKjIndYdAS/Q=;
 b=WfkbfBpW9MCXHECBQCeVJVle6NFAZrCsYT6D9fGnpdfD9L4LSpkA3e+GHDPAHqblGUwXl0AiYVyaw9AxPF6gQO4YTNmXhVxD4Iw0B97mik1VE1kI3ywGHmBc36cez6KGVj+SuPnPkrTU7xZiPtsIERMAE0cADmAlneSBeqeCpq6/KXrxeoa7AJIjR/KX7WNAHOqqCvGSKRcXh55P26+RCKLR1IeNltZKOdovlu90pc421D9Yo41ASu4aFQe9NL3926O2Z01ddLivk1lga7S1ylvQvJtS+sFnjNhNWxO7dbtLE6Hd6BMpOH5aOSj9Du1Dri79O5gYRNwJpuOW+Wb6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fe8xiTMupvdcX7mGKnhWEiEIdqHUqRGKjIndYdAS/Q=;
 b=m+lQCmEA9lqKwzt97F1KFAUt1uCzkTEXxjAUXO6f61CsIlzINxfIlQe1FhKObZh7/cfhKJjtji1JHDYhhoWg50YPYOGTLNjDseNGiKvX8xYshty/roPV69ZCdySC/1AjWmUAfvBn206aDtheGd0sPgLY1YiUUCbY5Eq34ThSdOY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB7330.namprd10.prod.outlook.com (2603:10b6:610:12f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 15:18:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 15:18:39 +0000
Date:   Fri, 7 Jul 2023 11:18:36 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [RESEND PATCH 2/8] maple_tree: don't use MAPLE_ARANGE64_META_MAX
 to indicate no gap
Message-ID: <20230707151836.stxta46buk3qpuxr@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
 <20230707101057.29326-3-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707101057.29326-3-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0195.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c7346b-359d-4074-c7dc-08db7efd7105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L3j2rMjB3dwLBxYPYjQWtMrg9PVL/lCdFutCT+VyVeh6NEDprJ6IUD43tOoyX861kjA5CsQB3jgqr0f3qU0wutYUGshNswuM0x0UVb2TltPc70AAXcoX25uebCM230pOw29rECiB/D357NXTLWTi1jkJPUE+gCbOZjDQJpDeOjo/TM5n/yeVoTUINTwj9iOJuGNOWHC9Nzq/U0NGRKKWZ3ZzAMGYKdTKEb+193HUC3mmyKo/4ux8lDcaRyzG2ql+1HGpMYGDAVqvXLCMD+Eunic9A5RPK6BpGPdUggkTcXMyUOW5wNUEcVCkE437xsaOlwO2siEs7JKlXmKSHMAgpVLERRe8wUilTiY8OGRpgD90aGha8oAGgRkN8fKFTFtKFcclXF6ImtHo13YWBw+mOollLcaohYHedrE5I5OlFBjHeBDg4ilWwCBigRezxVWhsC48CQE/sRu90adimIFRbvU/aDSgVqZcbJU4a+l7AqE9l24t9FweNQaJT+SgvxL87xRV7dogpKKgtz99Q8QvltbM0OXNkF7/7tEhXX1eQkgqUUUu02o8EpMm2z2X8bdf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199021)(41300700001)(6486002)(5660300002)(316002)(2906002)(8936002)(8676002)(66556008)(6916009)(4326008)(66476007)(478600001)(33716001)(6666004)(6512007)(186003)(38100700002)(86362001)(66946007)(9686003)(26005)(83380400001)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qytZyX7hY1zk6pE3Fx8pTcSwQ6Y2FYZOcQSsDnvkXQEvMJZ/4LTrwJBH/8e1?=
 =?us-ascii?Q?oSZ5lzGmH5qlrvutOy0oxwR9hc18m3PidBeBmUfnT5mWKES8MOaxK2/mSvlS?=
 =?us-ascii?Q?f21U5FHUOjK6t0UNXhf7ny9UO1U9irdgfyuP9Z1ADI4lAXv1BS9Tv8GRROj+?=
 =?us-ascii?Q?XbyGchRTmnLG/aspTDr4tknbhBSomQD4aRsbOrraDIcMQ98k0B2NrFPkuV5V?=
 =?us-ascii?Q?e4K3NzA5LeKACV90VVCoVSciN6bwKsQvdMSVO8vG7aOW7QIvtP+IEQCN5XYo?=
 =?us-ascii?Q?2+fVduMCB8TfRLrAiYXta06bzUvfBmk60wMAk9piARd6FYfGwOQoL5szfCqd?=
 =?us-ascii?Q?rEcFHt4RpIuVVXpzQjoQ+90QXJOGIh0GEj2p52ZHk6YZY4QGo09py4JpKCm9?=
 =?us-ascii?Q?fk1uWCuuDLEUVR8ZjEMy4IUmg7y5ctdvrfpNcBVA7XnrxtnMcmrrMSBv9PHE?=
 =?us-ascii?Q?Be+PP2+Oyq9Na2UIs4KLdW4s6csq6NANbu4LISuhLFnb5VwlA6hsEXn8nir8?=
 =?us-ascii?Q?bt+/UhUfR2uXQEOwThETFO8cfCXNpvnUJWJDSVk/F1iioHg3eFgvGqXh90MA?=
 =?us-ascii?Q?oG65zJ6m+s9KJaz8hBYfZqAVgzDwA7HzOf/ysLSLe3RSLRIb4YC281ItjJxI?=
 =?us-ascii?Q?ZgBkU1FgEuTMUtJznmU+66YCHxnR2XdPpzZUBdhq83E4tlTPY5BiJBcDGote?=
 =?us-ascii?Q?kP6RRPR5a/m/wH/iyQmv8fZ2huD2aMMaGMG0zfi672/VkkYa2weU/1DMVPfc?=
 =?us-ascii?Q?jNqmZgfr9L8Pel2Fsl4wIL3mSQ/z7Nn/6cnJgyUZtLFrZa33tYajlmu0vnpj?=
 =?us-ascii?Q?scqovM4/T/e/cmvn2UDQaKEabTDAbNQrcmx6J5T8N8j/k+ZqiGoUCjUuPZ/W?=
 =?us-ascii?Q?ydUpPLXRcTltZ4d3Ws5eMqyGFY0B33YybvepVhBIvMdSI9xF5xPOWExxljCe?=
 =?us-ascii?Q?ukjsHX0KVkUDMl6EiEw9vY+/9oG+fHuWCQfhF+5K25qGePLi4yoqN4Wivx7W?=
 =?us-ascii?Q?yJK++G5il+l6OMQcb/hiB93dQJBaWxyKORxXS+dyjt/A/O7N1lLIEB7l/5N3?=
 =?us-ascii?Q?sfTwUz+Hl02NTPC78gsi6O4vU/1vQqJTOMvnYBegkV9BFJ/L5z5mZZUlymPV?=
 =?us-ascii?Q?f4sbyRPy7MPGe+0/kni6u9iGoYI71biTQLx02gXxEnOhLvJe+VRu6sJWmIJ7?=
 =?us-ascii?Q?730kJ+uODS1aUwAXfj0Dp6BGydwxkKIwWfm3IEFrB96/AZ5Llx0+KVn2SJl5?=
 =?us-ascii?Q?DhpFF7ACMOecvnTVquzsGlIhVwVhWS5QyJw8d5Ofp/BQ5Hk7XKuKDXLn4gnf?=
 =?us-ascii?Q?XRxOzp1rv7S/KZuUQ/W7lHez1bfio+oHn07dDHGcJnXOHCV8vDQO58KW5X4C?=
 =?us-ascii?Q?D25sE0bWGGjh1NtYMWz2uUHbDUHXuKb+FOLohsFJlp5QnuirZJbyXynetatc?=
 =?us-ascii?Q?fvq0sGur2+oxy2+vO/yfE8svB+Xjc0E8biRIqxh5YZRMG5g6Z14mp2fsoZOT?=
 =?us-ascii?Q?LDqtrMy0A2oOETINbnNI6avaMg3ZJA31Mvs5XDPO3aEPFDAR/qW4VHkJvOor?=
 =?us-ascii?Q?PB5pjCK/aSdS4PYc/FNp3xLZaXTuWKt0kxExuWmv5GGLxU0bNU8/NlovWFlJ?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LrDMVlUFSNns+RlKqiHfQvHIRGhCszpZeseh43nP6M3fJnUbNB2XhtZ6i+XO?=
 =?us-ascii?Q?4sUY+MbIWVj+FPrAvX+0jAOVD6DhOvKjBfPlEMV/CKBHHRCt29184TSIaR0v?=
 =?us-ascii?Q?KjnbrWDL4Gb6seEYwS9O0NNopLn1FPCTCgFMflGU/gtqY8aHwGHho/l6Gy7w?=
 =?us-ascii?Q?y9gZHQ1ioMay6W5UHdkczoEIZ+vb+yvmTzHUG91rq5h+66UuSXeEJDzRv9Lq?=
 =?us-ascii?Q?i4b8x6hZFbzu7+ZjluT8TdT59QJm3SRTDKy8Ccnwh5GJXpEzH3mBnUjVwK2y?=
 =?us-ascii?Q?iBvUBO6LsFUuGfDhBJUSoj/pSywroXvPiCmRF5IYDk8EtJyzwL1N/o+96oYz?=
 =?us-ascii?Q?R8vImI07t6OogfNUArCKoTjGdj0l70CrPzls89g4dmI17zXqGQKE0H1b23kW?=
 =?us-ascii?Q?iN7GD4GeCRiGSr8iJk/ILQPWtm9meap3yCAU6Cae57vgG7DNH9drO7gt2Xoa?=
 =?us-ascii?Q?+XLY4pGQVB7ih56g+/prWpimSbSO3KNcBz+nMc/rIpEpkWS8VoZWYrjCVlrl?=
 =?us-ascii?Q?LfpYPHlvymVMynvWPSqZA/AKr55ZD5HSYwSbfwJqorN/s7ksBRAMKuCWXuts?=
 =?us-ascii?Q?81qaZuMcYEnzd9qh+uBNK41X01kxjs911nyBQv3QKC04SbJHltuQNMtPnqWW?=
 =?us-ascii?Q?CneVQREwhjdYKq2La+pM4qAWF/PiEpmURtf69ovnpRQoBEvAXfbqX03tDUtC?=
 =?us-ascii?Q?3sjXcj/gPV27sdtPuQxCyfjmsLa5GMkFeLEubcLfndREndh5P3WHJtSkWJRZ?=
 =?us-ascii?Q?7FIem9ebQSRWoV9lt8kj0eRdNm9SPpN8yR263MVryzIsaIYkmEccKI3911nQ?=
 =?us-ascii?Q?ZX67DMRsmkabu5F1CfEhKnFuCNUWGdf6BGfK2weB9FOTQZFQnMdWj1mJ3P3N?=
 =?us-ascii?Q?wtzZOpmgtoVi9Z+1APXc5oohZNrX2elJ2vIu3OFioCuLIEZBqDDRTPp8RiFN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c7346b-359d-4074-c7dc-08db7efd7105
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:18:39.1897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lka5KMuaijTXn53myV+aCl1U5Z2OAhj6mmapxfL+h/82vyFM88vV8f/1B0PyBbINifN9d42qEftaTqe8nEWqEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070141
X-Proofpoint-GUID: ZtZ5Fx_IXPhp3SYdYOPKWu2MDPQIk-DO
X-Proofpoint-ORIG-GUID: ZtZ5Fx_IXPhp3SYdYOPKWu2MDPQIk-DO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230707 06:11]:
> Do not use a special offset to indicate that there is no gap. When there
> is no gap, offset can point to any valid slots because its gap is 0.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/maple_tree.h |  2 --
>  lib/maple_tree.c           | 13 ++-----------
>  2 files changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index e18ecbefc7f7..4e004d86c780 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -29,14 +29,12 @@
>  #define MAPLE_NODE_SLOTS	31	/* 256 bytes including ->parent */
>  #define MAPLE_RANGE64_SLOTS	16	/* 256 bytes */
>  #define MAPLE_ARANGE64_SLOTS	10	/* 240 bytes */
> -#define MAPLE_ARANGE64_META_MAX	15	/* Out of range for metadata */
>  #define MAPLE_ALLOC_SLOTS	(MAPLE_NODE_SLOTS - 1)
>  #else
>  /* 32bit sizes */
>  #define MAPLE_NODE_SLOTS	63	/* 256 bytes including ->parent */
>  #define MAPLE_RANGE64_SLOTS	32	/* 256 bytes */
>  #define MAPLE_ARANGE64_SLOTS	21	/* 240 bytes */
> -#define MAPLE_ARANGE64_META_MAX	31	/* Out of range for metadata */
>  #define MAPLE_ALLOC_SLOTS	(MAPLE_NODE_SLOTS - 2)
>  #endif /* defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64) */
>  
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index f55e59bd9122..6a8982146338 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1610,8 +1610,6 @@ ma_max_gap(struct maple_node *node, unsigned long *gaps, enum maple_type mt,
>   * mas_max_gap() - find the largest gap in a non-leaf node and set the slot.
>   * @mas: The maple state.
>   *
> - * If the metadata gap is set to MAPLE_ARANGE64_META_MAX, there is no gap.
> - *
>   * Return: The gap value.
>   */
>  static inline unsigned long mas_max_gap(struct ma_state *mas)
> @@ -1628,9 +1626,6 @@ static inline unsigned long mas_max_gap(struct ma_state *mas)
>  	node = mas_mn(mas);
>  	MAS_BUG_ON(mas, mt != maple_arange_64);
>  	offset = ma_meta_gap(node, mt);
> -	if (offset == MAPLE_ARANGE64_META_MAX)
> -		return 0;
> -
>  	gaps = ma_gaps(node, mt);
>  	return gaps[offset];
>  }
> @@ -1662,10 +1657,7 @@ static inline void mas_parent_gap(struct ma_state *mas, unsigned char offset,
>  ascend:
>  	MAS_BUG_ON(mas, pmt != maple_arange_64);
>  	meta_offset = ma_meta_gap(pnode, pmt);
> -	if (meta_offset == MAPLE_ARANGE64_META_MAX)
> -		meta_gap = 0;
> -	else
> -		meta_gap = pgaps[meta_offset];
> +	meta_gap = pgaps[meta_offset];
>  
>  	pgaps[offset] = new;
>  
> @@ -1678,7 +1670,6 @@ static inline void mas_parent_gap(struct ma_state *mas, unsigned char offset,
>  
>  		ma_set_meta_gap(pnode, pmt, offset);
>  	} else if (new < meta_gap) {
> -		meta_offset = 15;
>  		new = ma_max_gap(pnode, pgaps, pmt, &meta_offset);
>  		ma_set_meta_gap(pnode, pmt, meta_offset);
>  	}
> @@ -2076,7 +2067,7 @@ static inline void mab_mas_cp(struct maple_big_node *b_node,
>  	end = j - 1;
>  	if (likely(!ma_is_leaf(mt) && mt_is_alloc(mas->tree))) {
>  		unsigned long max_gap = 0;
> -		unsigned char offset = 15;
> +		unsigned char offset = 0;
>  
>  		gaps = ma_gaps(node, mt);
>  		do {
> -- 
> 2.20.1
> 
