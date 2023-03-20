Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8536C1152
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCTL5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjCTL5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:57:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926E8233C0;
        Mon, 20 Mar 2023 04:57:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K97X5O019443;
        Mon, 20 Mar 2023 11:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=iErMxPP4INLWaoOzcXz8qHUn3DVFRYDwyM1OqLtuPf0=;
 b=X8pcFkJv3VYyehXy5o65Xd19PHrkQ+edMoaodOs6LiXcT10b2V4yafC6VjB8uNObA15d
 0OcqkxNkX98jncZttREtn6zSFqVqZn4ZnhElXO1liEqF2Oio5FwqOaSpxv37QEkHwV4S
 zLEuM5bLG8p3BpUXHsPPJeSogyPJIM6dUv6IfwD04zGf9rBe+yJIOdmVMuWRqQMJy2n3
 hGjMR+YHrFBbRUEagC29IxexKhfTVSuUuzBN4jTZ4PjvzTtQEMAQJIX5xTtqPqSWzJ9w
 +Y87pg1Gd2LqKnzCC6XdrcIEL0/CZlw7LpKE3RE1IvgYkXAKHcr1wq8YbBgC6AU1vnsz Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd433k940-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 11:57:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KAbCXe030718;
        Mon, 20 Mar 2023 11:57:06 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3peg5n67rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 11:57:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8zlrAQXwURaH6v9LGLwB/Zz2bsv+0Sx3MijLpVA0h0AxnOyodLJK6iQ3QxOz/bOjTRcM0r27xZ5hcaj3ysUb+W94KJOf4KlqHuJQxVqA+QDyGvXYmr5nSr9O8Am4sIu5lE3CYGbkoMNlB17Eq0Ugu3cHJCir2nYU12T9L3mafwIykhH/HVC1A6rgI2iP+SARg2FTLBvj6/k+TRnfFB96yM7tV2Gyw4a+4xvlors6f4P6Ntx5MdkNeD6irL/uz8jh8RNabmb1fiNCa/dM8nuO3cvSYeJqqJaHxUhtkDGa11mZsXGeeNS1FMBQlsqM24GRH7dPEjTuXGUnUf++ITnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iErMxPP4INLWaoOzcXz8qHUn3DVFRYDwyM1OqLtuPf0=;
 b=bNtJSvyVEtwq95fcWBOSPjbyz7WW0zHzHGbp2Np1/NYVGCqXXv46CRAPE2scIYmOAhF7QpV2Bqex2aucIbhNU7HQpqHBp21xz8pG9mINqsyhe23AUaml6TuV3h4COqqLcOQu4zmiaR2AYdoyUMXNgKE3Sbh/p9FjzimphyEFzCrMlJb4R6KR7wqfWxnvBpxM0iTErCvUtv194yUg+17pNkk7hoTDetQq7ZCEDQODEYBB0tPrbQprM2CX+ICZVavZD8AL5fTw/Yjz2eGGxd/oM+DktHKhlqCKFnb84rIai4Kue2UhqkeaIGu0KcpQ/4N2NgVDfFwSsFn8134WPlVPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iErMxPP4INLWaoOzcXz8qHUn3DVFRYDwyM1OqLtuPf0=;
 b=MCa8KPqRFeRAgZ4ETVZxH+OXQLGOOqM2IkuRnqWiKkhOxjDqD55rhKwoDEeAn4Y5C80ZOrRhv6xeACPhl45typte2avvLL+Ly9nj32gBfCrkMlUnl4v8JyBlkHy2eGsfWygQEZgXsBE3wO72xeN1rThoVWT5frtsFU7coWfXEQs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB5313.namprd10.prod.outlook.com (2603:10b6:208:331::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 11:57:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 11:57:04 +0000
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 0/3] blk-integrity: drop integrity_kobj from gendisk
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8ivtzrn.fsf@ca-mkp.ca.oracle.com>
References: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
Date:   Mon, 20 Mar 2023 07:56:58 -0400
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
        ("Thomas =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Sat, 18 Mar 2023
 17:36:22 +0000")
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::9) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BLAPR10MB5313:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e2451c-1a36-4e29-4276-08db293a38b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkpJmTeVrZ02GGu03PSFP20mjlF/b3Fg50X/lxI4+76p3ybtti853k3BPe07qf9/aNOlBZzTlfzbvJtXdW8ziYnB6O9vOSIesjCPtK95l0yE3IDsh+iZ7hZbsBBbILMjqoJFTaukKjXGoXr8orDx7NQreWv9W3RHMOT5NZjCQexBYYKCdQu7npCEI0U7rR34xl9aYjfd8Ap2rpKuwyFi3RAZIn347xr//my9TR1PtNZ9BmEzDem4xHqfkI4MDQq0UrR+kjmoVI/KHNrKVN7uBOnMz686vJaIB8nMc2dYDBqdtBl7Z02xp3HV/1n9b96AT3GMgpxKB0JSl6/8Ed5ODV5GDHY6fsXzkPj5JdSn1zzpNOIdZBh6WZd2cGODDO6LrEt3VvaN3IwQ226f7W+UqvQT1oiuCGboKlci+LMco+EPEHmU5uBsjWkDG8+Kk88IBWXC6silammlrcRdyp3gMY4Uz8oD+pKQ/giPP4I22zc28ky2lAIvm74Klh9Ypym1mip+uoAIirqpJCYXI0tHN2CQQtgPxflsujft7pJm0hiBVxdZdpvBmsPff2OoLz8GXOBdI0yO+qzq4ydrjBj9QqhnuTpKLPpFuLUwKojAtKCoH2yFUzIm8DM0bcN97BMf9TnKGkON8xygGY3PjERWlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199018)(316002)(86362001)(38100700002)(6916009)(4326008)(8676002)(66556008)(66476007)(66946007)(2906002)(8936002)(4744005)(41300700001)(5660300002)(478600001)(186003)(6666004)(26005)(6506007)(6512007)(6486002)(36916002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Gf2uPIrUZl18EYoSvpOSPgtj0uvL6wgrA0N6eHPvAzfVADaao0YiBEl9uKF?=
 =?us-ascii?Q?+e7WQqF0ssikhBilRHNJcBo5H5QhYPDpZztepngyKEOZ8l6iLLPikU0g3+Kw?=
 =?us-ascii?Q?zd8H4pnKX9Dd4zylUfkV2vFT5u/DO/fDu62yhmisLtOeydASJr/fDfcVMiJX?=
 =?us-ascii?Q?BfKtjlAvpajfY+PxzQnuv3IH/oQY2/92P2Vqngy2E/M3sdRdgs+8/WxRcnK2?=
 =?us-ascii?Q?sYPlo3hcABnPUuXiant26LZo7HBhFmaBJ8/kxbZ3zHJqvw8JzR6NoYSlKAmK?=
 =?us-ascii?Q?wUA8fYTM4InL47rqUgZ0tX/5ba296t7XkBvF8OSNeMK1MeylolJyVlvmVQU8?=
 =?us-ascii?Q?tjQUvmBp+dA2UepodESyPhmjXC4CXtfN5K2Zd2a4U6Ipt4YVrflZJGsKN6gH?=
 =?us-ascii?Q?9zVCS7idmyAUHtk85tChFawvZbKG/a/CMJV8lmT2zNT25nkHGP3Zr2dwwRu1?=
 =?us-ascii?Q?qdTreRJWe846myfaEpNxsJyqdvJA2I7suQg1D5tbT+YkkBZVQqkm7dq9kjtZ?=
 =?us-ascii?Q?rbCfEub9tXXO5A/oxrMKnKAMemNFr9VrfqHjPAFQEirSP584Hct6xGSODCeb?=
 =?us-ascii?Q?UL+bdZ6QbXR1mloITJz63MzianK+lAobXOB0wXTdbhQcOHmVRSh6G8P7mAO1?=
 =?us-ascii?Q?GYP2YMUmOibSAGWSLUOtjs8r2GCFMbLEFUe+bJ6Ggjhl8rWOXYClk2UHncDx?=
 =?us-ascii?Q?ths/8GQagKyl4h72zkAf+DfNGuJPccIoMNWFZZ1Xn/gqrhQPcUapgLsa/wNI?=
 =?us-ascii?Q?uCCxXIM8yEc5Je0gffNezsjuqtcUlN8b6FeXh6s15GGgf5eWyxYNJNL4RrFI?=
 =?us-ascii?Q?qVMSRctQAyt4J4UAThD/e6ji/zWFg1nniUQ+C03jpk2Zu5ag+bjNp1EN+JCY?=
 =?us-ascii?Q?c3JnDWyk7CnYvjCgl+Zb7qY7q7yXdwUq1I9RkU1XCh4Gh1NDCZwatjiz4Eqz?=
 =?us-ascii?Q?TJAu97+dEEF6oolni4OKWk4pgRJG3T76l7OGTQBQpKq01wHbldX55p0mVejH?=
 =?us-ascii?Q?wdVADFjncxbsOF8MAZLYJg+Qp4USLf2juZjs3jJANRN45goBqy3igwxcOWLL?=
 =?us-ascii?Q?PunIiWOJhKdw1HH/GvIzXyPCzehzRshoIby4Mq7e8YQxC1CIsnhuexYE8S6u?=
 =?us-ascii?Q?ZxuhucwCZ1M/i0cbI/JHUxZHLvir1aw8ETYoU+OrqdLw6oD955wFij90qtB9?=
 =?us-ascii?Q?JYJ3KZ3gBNC1fBH+BY8p93K9aVKk1wCIHgnLV00uRiMu4UevKZ4+BSmFlYBe?=
 =?us-ascii?Q?HtHfrXGEomlviJsA1+Y3IUQyiLiMLApvlJBv9Kqgy/VkvWW9N81xX7oh6K6t?=
 =?us-ascii?Q?DLPaE+3Wdq7JqPaxAe7ej7zTEhK9Q+i892ng+FK7Um7xvZNlkhahbDvBfyvf?=
 =?us-ascii?Q?2ge2nViJRO/4nkgwl0yKVwLwl6dRh6weS2Vk480UVp9s+m89Aq2oM6YraYwn?=
 =?us-ascii?Q?S/zLr0fk4qXrjcfQ/CSsCdmTb/XIVWGxvoV1rvgpkMMtJ4nXgqSkQZKdUzR0?=
 =?us-ascii?Q?X/twor2WR4cJ4Ff6ZSLcbEiM5bQaaSR9eBzw4x4Ci34WUoee2E61NsSQj6Gn?=
 =?us-ascii?Q?yO/dDhkqeLRxZo/SthJKGl2XTRFj6z5k2shYu4K+3MQLvjsDHSSIr3XU9b9W?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sciFM95GRYoVBGlOV5KFccoJPu2NewhFgj7rddgvBJ3KkbHkkXkfzaRZxo19eCuujh3Ci2ZtCPoMPdF+ocp53qpwdusRxIJYaVWgLDy9jxfRYFaQ3ix5RJE8iowzUZ+fCawFgyV+PiEJXkFiXMQZCo6hbB3+N3zjNJmtntiSEMt/nrBKVwfvpsaLLzEyycInJcjLRbSiWfv7QvScvhmpo87LBwQ+LWgGz0p+mKd4NF3MvXYkJsM/0S4mJSa9yluOilw6762MNw5sV37fiQKmxBwW5ce2nZxt/YicbC+LM/ItBHxA+X/n7iIBo9bfniaoNXbgDzwEsLHbs77GortBYATb4OdXjbXnrN91NP+xvBe+MhSSZbskjzhULLKBbMlSSvI3NRdKdKaSEB6FN1HFNp6KPr4MajF3r/9riYjiIpp5iNHLWKQE2TuC/eEa0DArZ8UAHZZ5lOqYu4ap4+Vy8eKFtCil2hlzR+tdov9k8GLYV4WmuO+qIKQJfiK1F95EOpQPfL6HzQef6uAXHGEqcH1AL9xbtK3fH2lzYrxy67p2FEaqTOMsbjs/+QwnXiixVg72PlQZgQE/JxmysU6VzgYAFmWGU/IS9i7eJw0jIsO6+zgWBvppbQYD3I49ajKHGtU3M17W0edG9uVmeKCeV5+U1LOZ17Tnp3Pnar08t3p+/LOkOEy2nxgf7TUa+xvD709M8TroZb7Ylvx+UWCR6RJe/VXRCs630nGWkcJTQqSsxPlhNpVHgI3zLgmy3UtvnMS0Vn/bS5Y3WTo4qGN7hDNUnRChdrz4enerOggBqcFcl3+AzWRJuEl7EWngLRg1jr+OntMTKqeuY8GwVTCaS1piRINv2md8zPoC2uOYhu+4fRZGRBMx0PUA80Fk499IB63j9MNFPsis8KnM35bO3dUDlNM4pyywDFRYlaHCp5s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e2451c-1a36-4e29-4276-08db293a38b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 11:57:04.2610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ll2rTmU1S62n+f2vsH9VcA6a1QG7hBG5ag1/Zzu1/BpXLtoEZF70ru23USfPKVFZbrYsc9gP3JRx064QEJuDJTHlc3k2NyeXddDrZdiNSWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_08,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200102
X-Proofpoint-ORIG-GUID: 0d7R76NWwy9YZoSYO4w6L1OmJXigStiQ
X-Proofpoint-GUID: 0d7R76NWwy9YZoSYO4w6L1OmJXigStiQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas,

> The embedded member integrity_kobj member of struct gendisk violates
> the assumption of the driver core that only one struct kobject should
> be embedded into another object and then manages its lifetime.
>
> As the integrity_kobj is only used to hold a few sysfs attributes it
> can be replaced by direct device_attributes and removed.

Looks good to me and passed a quick test on a couple of systems. Thanks
for cleaning this up!

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
