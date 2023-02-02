Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E216885B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjBBRrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjBBRrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:47:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C877C26855
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 09:47:16 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312HkldH022633;
        Thu, 2 Feb 2023 17:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=hoWV1YLjLRpEg7tkzryWIlGTXxLQU1GnhMcqpx84muM=;
 b=2VQ4ajAbOccfbQhOzVp5Erw4sxCHl9uoUFly/kOZLsjWbdLnxWQD5e+2HKyD2gUYZNeb
 LcQZ6wDVJbrcRQwRxJ7fd0W0vf79YQSX7rsg1jY8mktcKjVtw3+ZhX+lmUBTNXIpjQkd
 EFwW8SoW14eKNBM1Y/D8E8UbGPb9sRPVm6wT99MrBscU0nRSaTLxi1Z6dvLfrlOPBfWU
 j7aLVX3T2qtb4+WfDk3AHH8yvkdxof3rh3FEGNUFZgB7qGookUcWKZjgLH5RxejEZip8
 bDdvJbkrAaoPhZLH58lHSp9j7K67pyRrKKRKu6JHHGei1AMC/KCF3c9TN9xEBnYrm6p2 xA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfn9ykrpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 17:46:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312HkZ2r034241;
        Thu, 2 Feb 2023 17:46:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5fxn3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 17:46:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRImseePNAZ/YptdxDl9sI66+cO2P+VkqwMA9JKnb07fH7UmedFTMyEz34YgH7ZO8sSxulB0sV8TXGqomM3Diob8cfILoph5C+8DOrOGNL5v3IQvssLykg/UAIMok7aMySpMoYVlW4j8343AbxHzHpbMicCzd2P0FCLik9ZhMqXzKHh4+DzGuef+CgFsjZQJ6+ea+kiHZVDZH6GcocbMyvGnSNFuzV/fJsRKVqSGJcAuf4Z4VLT5w5Kwt+ciTA/MMw3XUyMtf/Jkh/8mQmQQOrH9c0Tw77rBX/6+8luPaGifP1lRZcaJRz3P2P9dr7ZPMZT2whodiLmJwX9i2RvcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoWV1YLjLRpEg7tkzryWIlGTXxLQU1GnhMcqpx84muM=;
 b=cpAsQ5tUMJblFKaeu/qc/SImdpplwIJ/FfQnrU0tINdfIRBRp2zZ3JRa5nyimYKBicMc5ViHAi/eH+mNfyvdjbCrdLLIkol1KXPykEoRYC5qCYbsVvAa64q+Ypyzaqm1jAZZBNUMN4SSFah9N3JFtonbLyGh/IJL7m61t+w6YypvVU82QWxBCTqCAd3gqYk7npFEWVml2/TabtRwl35RokquWiNspEBCsjTXJ/yB/fWb3SPfUbzjQfKhjlNFB2tNZm4HdvUGUFdVBr/+M8U1fhMHBnVfvMtdN9aMq1u3db/l0buRFNeWVxbduesDuDpl02QKpWckWVDfsr58F55bZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoWV1YLjLRpEg7tkzryWIlGTXxLQU1GnhMcqpx84muM=;
 b=pPdfv2FWrkUbvqK7e9nPc1Cvw9ZBPXIqj0O4b9LXPyu0bSo5n1yX/zk/HSx4OQ0fdTVIb/WWCxIrntDB1Wq61p2t2AeM0D47gviG7HTSw/fioiq862dBGKegHAE7+dBQMDdWPUqgZfKP+5Mn9eRofXgFBVz1b/HzTSxJXdRV2LE=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CY5PR10MB6214.namprd10.prod.outlook.com (2603:10b6:930:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 17:46:57 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::fb4f:8219:b8cc:7084]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::fb4f:8219:b8cc:7084%2]) with mapi id 15.20.6064.024; Thu, 2 Feb 2023
 17:46:57 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, urezki@gmail.com,
        lstoakes@gmail.com, willy@infradead.org, hch@infradead.org,
        error27@gmail.com, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v4 0/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
In-Reply-To: <20230201091339.61761-1-bhe@redhat.com>
References: <20230201091339.61761-1-bhe@redhat.com>
Date:   Thu, 02 Feb 2023 09:47:02 -0800
Message-ID: <87357o7yeh.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:806:d3::33) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CY5PR10MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f29121-f14d-489f-f027-08db05457a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dT1huq3DAuvaZYCQnNTXM9eNCvtNtGokDkpsmru4e2XsqXI0YHP6kZgS/6HhwL3GDVlASXnILsrjFWbDJI/xEzMab6MrW7y4kJuz5asD6+R/92vMSVSU4r9raJmGVBAqjiRi0Jpv3DsnzNtn+Ub4VZedabm0xVUSNfYZYQoS8kgktcJsUnpsTJrxeRGg3HKKtJCPyGj3sBzAcbm6AqF/8IVOONLjws1lBV76bMQylEqt9T/d6KnXg3Dr/Hvcnd6E+ybTuNLdqdGF+acGXIFlUVcIzRNwsc7C4UjwmobJ6Ecn6gOctAwq+jRddgKRiC2fCo0BXwIwoCQ5wXGYVIMlE3PhrWTBj2fDBZ6g6P2jaJ4jvSLGx0dA17nuvzsmfqGFWpHsFjzlIIpKehyOPD1OSvjD36uTLBJAoyEvtV78tBaFE0tCGaOlTSnpNBQ7Y5coyPE2dEstoahQRg1c9aEL1oGAa/duRyk4MH8S56jScSffzJpnlBO5/o/cKu1vk+W9xpjgyo6xIQiSCXxXb9zhGjmw7E+PFyzlvlsV47tTP1XTN0Azz0XA2iUvPzwnTrdqpyfpsSLqMUvsMwGjHrXb04Vlq/deA1NB4XAQvSy4V18ySKG6NQIlnZoWBSXhqy44zjzlEykb3mFM7A9hXybeNwpwJkcbfKUuHdVGDceY2YwWZbjEVWGQwptQJWXe6/BqPkFv226Bgt0wAj1o3mbQtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199018)(83380400001)(6506007)(2906002)(36756003)(316002)(478600001)(38100700002)(6486002)(2616005)(966005)(6666004)(86362001)(5660300002)(8936002)(41300700001)(186003)(26005)(8676002)(6512007)(66476007)(66946007)(4326008)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LNQ/hNkHYUcctr2jfhIcqgcysgQEmwu/aWUDMWN/+/JJYec0uCJ01q5wEKas?=
 =?us-ascii?Q?M6i1qlw5UwQtuz1xZGkjSu8aNA9yeiklCvRXQfAqTFFRfA8eVy+bMc/4UmpJ?=
 =?us-ascii?Q?RafSqPxnDfTbBbvuYvnr4me/7RNzB6CbCaPpvnQ2EGAsse33bHzitYFm9adR?=
 =?us-ascii?Q?if4IGaU6Y5zoo8R64xmOl2B6eyB7u8wEuO14H/95Sej8JXTd+80IQtPc3chP?=
 =?us-ascii?Q?VKkbfXrTmlgfgFhW4d64CySoq6E8pwaH6XIkSa/XStzSlXPIJG1U54HT4j1l?=
 =?us-ascii?Q?Vjf9UTVZC7VjXassI0ybKncGvYlziH4X0voGKJEPwQXf3zg7Oj3W+628bu3E?=
 =?us-ascii?Q?hOZ4JC30vSkOeo/ssP9tRw2PwY7QLD0TEppyvjaly78w/rbiPzBo29MHqnCY?=
 =?us-ascii?Q?1CECRPx0HQ6kvA8W0V8vTSjEcgWYMBpsJCz7GPm70OYVx0yugMs5n74864aU?=
 =?us-ascii?Q?yx7ieIruI3STFv8RIXerrVFfQS8h/STlI5nhPUpF/g8kgZ6q6muoNJe3/ZAU?=
 =?us-ascii?Q?BnE9pNoI9WjvlKi8YpHmvSJ/pernNtxxTtrbhw8UrT4JL+0jcE8R10PJJg2G?=
 =?us-ascii?Q?2NIzji84Ks+7xY8CvdLLU5B1P/Z5791eKwtEzDhV1W4DVB++dChMlB4ZI2Vk?=
 =?us-ascii?Q?MKvQRCuz3zkj24qOhbLO2r2+Qx2SS4cJaVub460vVpLnWFb9qbDh2DbDpXK0?=
 =?us-ascii?Q?7J7izet01MbRTdP5n6tnpu4B3OVEHIR5vm1dvFahZSQdZtvXU9BzpPmuFGMU?=
 =?us-ascii?Q?F/GxD3Ax3rH/dExyB8UfOUDhTEOKKZnc1v2wJ00OpkiYj2yH55AfkfC1Yvcg?=
 =?us-ascii?Q?Zc4IHkpN9TBxzsfsBWEtzuy/NdRvqYz/b9OVd3dl5V7Xy5R0dkqcylgeb0r2?=
 =?us-ascii?Q?uTQC2b9TtW1tRj2Q1dzzSS3wYNblvhc6ChVDKGoS6aX7GesN+D/TaLnVwuZb?=
 =?us-ascii?Q?OAJxJLQvtdGFjYGlZPHoCD6lbBehi2VK80itk8rQDQQYYLzqte8q3ttCdqGt?=
 =?us-ascii?Q?rFZcKkrZLGlhLIurr1DRgiwJr5TxHvYFonxMlIdCLgGvv9iPRniFPILDqDlS?=
 =?us-ascii?Q?1qfaEuduCpW7RfqOBI5JE/gGzE4gUMW5NKDwO8vKrYtLoU8YEp+uVwNpdUZW?=
 =?us-ascii?Q?wqx/mL7u3t3k3hr0dslqfzqUTsejPrHs7JopfmpxvCLDsY6UnWg8oOYaa4dQ?=
 =?us-ascii?Q?wHKMQcVs926adtCVozu2WR59SUcOylLSzez9YbwHa4yszqwAf/Up3XUtZEmS?=
 =?us-ascii?Q?GBRrFWD6PB01FePSFseREdhusuH233D1srbEX+zF7muLG6UPGoxz7ThAPIim?=
 =?us-ascii?Q?btlNPebeAFkGLl5fU1Gu8Lb+gpgFWux2NV+GWM1G6qPUMmhqApgV/auyyPjh?=
 =?us-ascii?Q?td+8ssmab1awdtSMbxxb40PbRvG7sLQsCUJSY2dqoixMPSDuvH6sLnMRavMs?=
 =?us-ascii?Q?JaRepmIqqo4QV0jfhvMIYEvld/5JMkM9vNEJLDoqo03swREJH7lA1ebjGGe7?=
 =?us-ascii?Q?1srhxSkYfvN30Fo47erngwYCcnKuLsi0+ZVfzol0tGYb2wyrwZnx9vRBLJWj?=
 =?us-ascii?Q?dtd+tbvWUNQkAMzOfmwcxZFsJ0eoWSph9aSW1sxQD6QwR77el0POg/sEElTX?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?SI10kPIfyk9IhCventnkj+L/HCUHy1Xpw7ey/UZvSVHC76fzv2idXSIMlCkn?=
 =?us-ascii?Q?U3jk/Fjao2j6D2ZSxZ4I750dxibwzzAUuZvdW/vcTk0o46VH9kNrL+5q85gQ?=
 =?us-ascii?Q?6QApTWrEDLHQf8lRuKgPdBOCjNzlk3RsBHmDZ6Btmne9pp6GzzNVg+1yyG93?=
 =?us-ascii?Q?+fprH0ffD9CY/9XwvlKjxPVMKpBOItagsYPO172rf/ZfTv+1EsgXnFkDhBoj?=
 =?us-ascii?Q?YE1NWRZEEnPKs/j4WshClbACU20HNWZ03NlEA0j08pQ1sclM24m/gjS6+Lyv?=
 =?us-ascii?Q?gchNisFu7a/tvCzwwgD2STCgFIbbInye7DoH0/kHKM3SYKjdLnW+wQYzVovD?=
 =?us-ascii?Q?0cwyPuuuAugu+id37gGly2Q6c+midF7lmt88B3BLsiMaOY9cnvLyqsoBb5ay?=
 =?us-ascii?Q?qtikg/3M4ISXahrMnrXsGO3p5WYUgI3DZbk6yjqKuk58njZnPtgwMrB2FCKu?=
 =?us-ascii?Q?g9K7dk9JxOaj/KURongEBHoENpgaf2FuJEf7mwHG6NOloWOi6JcSnTcAGjvl?=
 =?us-ascii?Q?NTiDZPWSvkF7WQIZuJGGC1Z6fhHb6dnKJvRhgZ7v6aZWb+5Sxuoe+njJUhf/?=
 =?us-ascii?Q?6MVNQfkrmxC4Bj2jx4Cz9JM/bjJ7ixc+AEwdgQITOaa4X6Ss/V8yyfq/uw+e?=
 =?us-ascii?Q?gaqq3BXEagI9hKO7zpenEWZVJDCOuy3Ye7ITwnhGT8iIZ3Yq0rzGbi2KUEqg?=
 =?us-ascii?Q?zwB6HocbHJxIPLtMrAKIMX0qUctqCnDC6/jLPJuG5z6QDQ2G29eTBbSdbG+m?=
 =?us-ascii?Q?1E9dDm5iBU255bJQve4s/h2Qdvj0SYca+0fXzPD9HwNbA41idJkwn8NNIuZ8?=
 =?us-ascii?Q?5TFKWo2l1fuxXu5mlQz5EyXB13tBP/cqVbnoz7r9H2eRQD8n+aMqssK9Y5wh?=
 =?us-ascii?Q?G6gMge87kzqPwRUFSJEsnYyk3lUtnyDEjA92yU3lXFez+N5XGX8IipNOyYR4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f29121-f14d-489f-f027-08db05457a79
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 17:46:57.1719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTgr2c+Wd/zKBn+Di33hg7QvNn/YiTHdw7sDDJ+FayZ5whTqah8VqiUlOjSDG2ynIm08M5agAR8OcCt0yh+8ih0K/vd/Ql66YtOkt+cpZ4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_12,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020158
X-Proofpoint-ORIG-GUID: L3C7RWadLv7gv6A0yboRm3qhCnywOxpM
X-Proofpoint-GUID: L3C7RWadLv7gv6A0yboRm3qhCnywOxpM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:
> Problem:
> ***
> Stephen reported vread() will skip vm_map_ram areas when reading out
> /proc/kcore with drgn utility. Please see below link to get more
> details. 
>
>   /proc/kcore reads 0's for vmap_block
>   https://lore.kernel.org/all/87ilk6gos2.fsf@oracle.com/T/#u
>
> Root cause:
> ***
> The normal vmalloc API uses struct vmap_area to manage the virtual
> kernel area allocated, and associate a vm_struct to store more
> information and pass out. However, area reserved through vm_map_ram()
> interface doesn't allocate vm_struct to associate with. So the current
> code in vread() will skip the vm_map_ram area through 'if (!va->vm)'
> conditional checking.
>
> Solution:
> ***
> To mark the area reserved through vm_map_ram() interface, add field 'flags'
> into struct vmap_area. Bit 0 indicates this is vm_map_ram area created
> through vm_map_ram() interface, bit 1 marks out the type of vm_map_ram area
> which makes use of vmap_block to manage split regions via vb_alloc/free().
>
> And also add bitmap field 'used_map' into struct vmap_block to mark those
> further subdivided regions being used to differentiate with dirty and free
> regions in vmap_block.
>
> With the help of above vmap_area->flags and vmap_block->used_map, we can
> recognize and handle vm_map_ram areas successfully. All these are done
> in patch 1~3.
>
> Meanwhile, do some improvement on areas related to vm_map_ram areas in
> patch 4, 5. And also change area flag from VM_ALLOC to VM_IOREMAP in
> patch 6, 7 because this will show them as 'ioremap' in /proc/vmallocinfo,
> and exclude them from /proc/kcore.
>
> Testing
> ***
> Only did the basic testing on kvm guest, and run below commands to
> access kcore file to do statistics:
>
> 	makedumpfile --mem-usage /proc/kcore

Hi Baoquan,

Sorry I haven't commented with testing info or review on each revision:
I'm not really familiar with the details necessary for review. However,
it looks like this is getting close to ready, so I did another test:

[opc@stepbren-ol8-1 drgn_vmalloc_test]$ sudo insmod drgn_vmalloc_test.ko
[opc@stepbren-ol8-1 drgn_vmalloc_test]$ sudo dmesg | tail -n 5
[   20.763310] missing module BTF, cannot register kfuncs
[   20.840200] missing module BTF, cannot register kfuncs
[   91.475814] drgn_vmalloc_test: loading out-of-tree module taints kernel.
[   91.479913] drgn_vmalloc_test: module verification failed: signature and/or required key missing - tainting kernel
[   91.484926] drgn_vmalloc_test: 0xffffa51ac2d00000
[opc@stepbren-ol8-1 drgn_vmalloc_test]$ sudo drgn
drgn 0.0.22 (using Python 3.6.8, elfutils 0.186, with libkdumpfile)
For help, type help(drgn).
>>> import drgn
>>> from drgn import NULL, Object, cast, container_of, execscript, offsetof, reinterpret, sizeof
>>> from drgn.helpers.common import *
>>> from drgn.helpers.linux import *
warning: could not get debugging information for:
drgn_vmalloc_test (could not find module in depmod)
>>> prog.read(0xffffa51ac2d00000, 64)
b'\x00\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\t\x00\x00\x00\n\x00\x00\x00\x0b\x00\x00\x00\x0c\x00\x00\x00\r\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00'
>>>

So this definitely still resolves the originally reported issue. Feel
free to add, if you want:

Tested-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Thanks for all the work here,
Stephen

>
> Changelog
> ***
> v3->v4:
> - Fix typo in pach 2 catched by Lorenzo.
> - Add WARN_ON(flags == VMAP_BLOCK) in vread() to address Dan's concern
>   that VMAP_BLOCK could be set alone in vmap->flags.
> - Add checking on the returned value from xa_load() in vmap_ram_vread(),
>   Uladzislau commented on the risk of this place.
> - Fix a bug in s_show() which is changed in patch 5. The old change will
>   cause 'va->vm is NULL but the VMAP_RAM flag is not set' case wrongly
>   handled. Please see below link for details.
>   - https://lore.kernel.org/all/Y8aAmuUY9OxrYlLm@kili/T/#u
> - Add Uladzislau and Lorenzo's Reviewed-by.
>
> v2->v3:
> - Benefited from find_unlink_vmap_area() introduced by Uladzislau, do
>   not need to worry about the va->vm and va->flags reset during freeing.
> - Change to identify vm_map_area with VMAP_RAM in vmap->flags in
>   vread(). 
> - Rename the old vb_vread() to vmap_ram_vread().
> - Handle two kinds of vm_map_area area reading in vmap_ram_vread()
>   respectively. 
> - Fix bug of the while loop code block in vmap_block reading, found by
>   Lorenzo.
> - Improve conditional check related to vm_map_ram area, suggested by
>   Lorenzo.
>
> v1->v2:
> - Change alloc_vmap_area() to pass in va_flags so that we can pass and
>   set vmap_area->flags for vm_map_ram area. With this, no extra action
>   need be added to acquire vmap_area_lock when doing the vmap_area->flags
>   setting. Uladzislau reviewed v1 and pointed out the issue.
> - Improve vb_vread() to cover the case where reading is started from a
>   dirty or free region.
>
> RFC->v1:
> - Add a new field flags in vmap_area to mark vm_map_ram area. It cold be
>   risky reusing the vm union in vmap_area in RFC. I will consider
>   reusing the union in vmap_area to save memory later. Now just take the
>   simpler way to let's focus on resolving the main problem.
> - Add patch 4~7 for optimization.
>
> Baoquan He (7):
>   mm/vmalloc.c: add used_map into vmap_block to track space of
>     vmap_block
>   mm/vmalloc.c: add flags to mark vm_map_ram area
>   mm/vmalloc.c: allow vread() to read out vm_map_ram areas
>   mm/vmalloc: explicitly identify vm_map_ram area when shown in
>     /proc/vmcoreinfo
>   mm/vmalloc: skip the uninitilized vmalloc areas
>   powerpc: mm: add VM_IOREMAP flag to the vmalloc area
>   sh: mm: set VM_IOREMAP flag to the vmalloc area
>
>  arch/powerpc/kernel/pci_64.c |   2 +-
>  arch/sh/kernel/cpu/sh4/sq.c  |   2 +-
>  include/linux/vmalloc.h      |   1 +
>  mm/vmalloc.c                 | 126 ++++++++++++++++++++++++++++++-----
>  4 files changed, 111 insertions(+), 20 deletions(-)
>
> -- 
> 2.34.1
