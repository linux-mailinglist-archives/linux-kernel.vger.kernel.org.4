Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0783467D79E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjAZVVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjAZVVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:21:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AE671656;
        Thu, 26 Jan 2023 13:21:12 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QISuHQ028453;
        Thu, 26 Jan 2023 21:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=7DnbSB2UCepJyVbTai6FQsE72K9zGjJF4rakIWRbikY=;
 b=wQ5GK7boxuV65lXSBlP41Nzn7fwro/MGlfBTerg8tM8g2Iu927eulHNezvIkHqS81Vcw
 pkIhy39plvf2B2+DDAJZg1uemRtraXhBXpX6gm2lDIIog1UQfC6FfT2GTF6zv7Xci8yP
 l11VfgVtX6UjiG171s0xMphZbRPnRRlqlreiyQSDRLUWE7G1jX20vqPxawhM0t2Jz99W
 DL4/DY2ZGtA2eFKlWlUkMlP6HFL48abKxce+kczhyINzCwx0+WHmJ5OaSqGFVn3bz0bj
 SVWjyZS2EqRYtu1PcrFMrj3TddF8M/OeO5Bwn/6Wuv8h+Hs5qQiFZqr9WdUxtAwDehOC Tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n883cbjh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 21:21:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30QKs41G037505;
        Thu, 26 Jan 2023 21:21:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g7wyf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 21:21:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZELC6ZePp6i3KzHX2K42i3inQ3SYd324/a1BIxkMZFV1t80oT/5bV1Y/qEEid32Xq2dC0Pi6BdLL4BwQ2xEA8ztA/YDeoawyknJVePeozqz2TSsWmkoQ+tXEVP/pKwocOYTUQwd8mGnKP1vj0QhGy9wl2elDeiYal1ElMsMwSw6iIyDycPTQ6zkjuOSRKQzjOo5ZXmRY727yVYNdfQoGiV/cMXjPINS9rKtx8rr3O/bHFNhg4YsavBW4RP5DAcne5uUlG6SDN0giUkHiZIirapWuSbvFZ7vybpdmQg+YRtKwZpLoJLJP6tjFby2FWLit1tyct1vcFn0VoZdHqWXlwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DnbSB2UCepJyVbTai6FQsE72K9zGjJF4rakIWRbikY=;
 b=kgbRV6+7v6JYfxXnF4rcKL/VSFNX3IvyjkOp6Oi1wkuI0nrBp+qQtIP1loLZVJXm+7y/7M3SbLLw2Ql4BpD9+OczOwtSFHR1QP8bZHQ0u/gIBx92VyCFzcdRwKYAcUebyzVmP7AF59YYbgDy/547chrg8my23ZtGn60sMiZGl9oCK+xI7dmpnaoGnlz8+HNxy7/FKmfFU7lvVKIs5CPQfjtI73E6Va96SdVSxF1gAywZ6hEX34ScAIe3/QB+LX301Yk8OwJqUTLW0ZK3W0ONJgnK/COwzEhn/JoluzvKsMeLrAm4m1CEo3wP6IiBJEyhYn+VDJUruRaWdG46fhLUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DnbSB2UCepJyVbTai6FQsE72K9zGjJF4rakIWRbikY=;
 b=LK8XPF83c2oU9bp8jV54OVXhsTeeddgUPe72L7KtkXgUyj/WpxurO7fdL6zKOZepSDnGKlv++z+l3MT4ud+Wcy+hTgwPrStDTqgSqM2EZkuVTeOTtQbwG/+xDJPpVCoyUTif9lIuFu570QAePKUbsXvA+ntP7AzI2m7TizQJuYk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA0PR10MB6700.namprd10.prod.outlook.com (2603:10b6:208:440::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Thu, 26 Jan
 2023 21:20:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.017; Thu, 26 Jan 2023
 21:20:58 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-next@vger.kernel.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ipc/shm: Introduce new do_vma_munmap() to munmap
Date:   Thu, 26 Jan 2023 16:20:49 -0500
Message-Id: <20230126212049.980501-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA0PR10MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: e24140ad-a025-4a5e-cf45-08daffe337bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VmGFu2Ewv+j9RCQ040+m5eeajcixg1Jf0PVZYglCS0RSCh8iIMIvuCj87scBjOACuxxey/QgJX4zHnT3UGcmkTBm4nIW0YfYQsr9nqcqp51MxNwayY6nVt4YafGGF6Z9u5GmagPrSUbR70Hl3irZ3GSbtvYnQx76JCHA3srXuy8v54lEGBU8KN/gvmcgF/k24/yG5GeciemUwWlN0mcJTN6QBy6habKxFLdWrZLTw6AKCDImSAD0Vt2TjZGIBMjhmJlp9/a/HpyO3aA4cmae1u3ejvqs9BJajLgu8rwfXwLZB9kbhhJbLSWfN0Du1evaQEBKpVjyBoAQZfViNYOqE6/+fkCDqr3y6yRYIMKQzddIbKYQbcVywtFlzSI3E452iyKoFid1pzlZagH3FJVduXL9QHooYMoMyVBLRgSQyJLuJqQJKWUmnjRJrKLOD1fbyjLbnA5+LbCoseB+Zco3BP4Q0KqYr7muqIVtWz8D047dswNLzh+8J8yn590TdbiNEx1ZKGCUEnSOzwLGo3DNENpt2aSE5/oZ+uyylyayUzw9alufq//BCy/08wu8lyeWh4gEafDPtQpGsMSyucJfppLvKQ+RKvb4/hiE0x8jXtAMSqjXpl+kqslQ1jq6dn/xcd6H2cRLDsc+lOHt9HrlbMVyFI7XqhHIP9BTrOWJm2eRDNoikl0x853nx1ZDKkd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199018)(5660300002)(8936002)(4326008)(8676002)(83380400001)(41300700001)(86362001)(36756003)(38100700002)(2906002)(66476007)(6486002)(478600001)(966005)(1076003)(2616005)(26005)(186003)(6512007)(6506007)(316002)(6666004)(54906003)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MkWmwNhI383V7R/NcQDfUf0PExloyQc6lEiPM01shTCRBR0B+pAodKzZLQpr?=
 =?us-ascii?Q?BK+RS8ZC/JRjkGiF7HJN/HMauyveSvDbhC3m9ple9rmSMUY9sKCzXvTUdImi?=
 =?us-ascii?Q?d9G9wkB4aAYGHs2w4gcjBMrFUjQhpyuHZDoYV1rD+qzz6wzNGL5dUDLtT19m?=
 =?us-ascii?Q?rF6sJpQmOkHmoCZ0KCVSA4Q9ZZ4kSX4AFRz6E8UPZUOZUYFztjUpcSNo3HnR?=
 =?us-ascii?Q?n+n1R086hqHvUu/c384RvEd28uioZXIxOIey/6shTCDF9ftrcwJ8+w8Nkbi2?=
 =?us-ascii?Q?peXnQAC6yIuncUStVsrKBhuxM6lGwh+FhTLCIpu++U9YqrbjvHk9kcOUBvHr?=
 =?us-ascii?Q?JzoRkjlooQH+JqlwtV+wpvPBxPhj7zYY+b/OS+BRfxRXW4EKhdZk2ShTuyIR?=
 =?us-ascii?Q?pv4DHGslLiBqWvp3zuriq5skFJ39069G0JNFdkm6YojQBNAnhdaV96IINqyt?=
 =?us-ascii?Q?v4slSnNwMBCZ281Bxc4VHfDFp5xtbK9g8tFahLWxiUJSmR8lnH9qAp8SuXKE?=
 =?us-ascii?Q?NlTt9qyPV1vs+KhUsBjY3tadiS0IS27nK4FYag36cHiHCZxRr+g2NQE6Cvkx?=
 =?us-ascii?Q?ngvoRcpIR5WTgKLUIgax2IeFQcq+uwHzVlPJA+YXqeK/6MUTa1wBazhuM+W/?=
 =?us-ascii?Q?BfiT+gOHI6TgRXowGYbVHHG+GRjEldXCcvWeKR/0jerbag8iE0WglGp9TSBd?=
 =?us-ascii?Q?TvfwwLMLKknr2fXee8cwsWUb/BDPWejIsut57KbzmPU6xNe/eRLfxYgfwhcK?=
 =?us-ascii?Q?n+62NxBH90mc4/SNZWiF/0aJSEIyxsS3Hcb+rkYab1xgo5aJTwYG1V7CzFfN?=
 =?us-ascii?Q?EwwvJUdHMbSfnEC90liFVXCo1dYQ6ScodlZiA3HJ/gk3Q/rwzrp0oPYx/uVp?=
 =?us-ascii?Q?LCh6g2vj1Q2uZVDUQfKILAO/MLO2NmwyoRGfI58JxIpl+uqJHsQ1bDqSJvnK?=
 =?us-ascii?Q?2tB8dTnNuGyhuGu0JxSfxtS/fYIXM+JohOspw7teZRWZ2zlkYRcHsEbQd/CE?=
 =?us-ascii?Q?oHyBeWnKaCmbHX7L6QttwpjXLSlinVQWDnqrv0kM1SIhRDhRVvghCE4OfRRJ?=
 =?us-ascii?Q?NMZtICkfWHQOhy/CY8enql7cEmvRMujFL0W1UOWKB3+a5bznVhUQHtjWlEiC?=
 =?us-ascii?Q?unQivREWZ6FaHYve6JQ7l/JSCWl0S0/AFcXRxBn/QoGEPkzpmRvXklhVoJKr?=
 =?us-ascii?Q?F3T0h5oXy6i/47iLm0VR/GqBYzr6//OZT2c+5g2rdBX+yn947j87Vz58b9Rz?=
 =?us-ascii?Q?tAPuKi2Q7h3X4PQK4P/ZWIoGK/mQMcFVwl/6rSKz+YXVbfHjmgKv/U7JDoa6?=
 =?us-ascii?Q?sxD51Kdk0w754p9v6RQJ0baBhwr+nWA9c7vScNlXd3WBfTceuht4JaMjNel8?=
 =?us-ascii?Q?4zbZTwRD3Stk+ZvMflakgnWlXYmvkrOVSVJT9cbP9O3EUiYP36zrUBXGEiKl?=
 =?us-ascii?Q?y5C5H8wnw6cUo1FKbuk7FaZQ4xytck0AUFEqxCJyk8lsKu1uUzow27rY6PHV?=
 =?us-ascii?Q?vu0VuvB+S9ocn3ANVrK/bZ2t7W8V7+2yBCXWFDUfc1O0Xgii9jVE3iXOwdhX?=
 =?us-ascii?Q?amFHQ/B0GD/y6PM3Zdh2pS2bzlYaGXSQnrIJ0kAIq3pe7iUpWUoPfGwZQ1lZ?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?MPkeBvX2FSQ/AQONGXgoBnvNqBrcxdaSgm63HUCkbcIrqPodxbCqYyIt9Cvq?=
 =?us-ascii?Q?BNpver+izb5/AvoVQj7H/B7kQnRSYxKalDqQMra0I2FvhNutak7+7RhSfBdi?=
 =?us-ascii?Q?e79GUrXVfNMYUZ5gKChiWem85SR/O3Bv77sfesRzFAv8Crhmxyi4IfbtN7Pw?=
 =?us-ascii?Q?6PCiiXqptSVYbdmwekZbTW64Rxi0nhJZOfVfYBO0oCM59b4B9sPaqG4/+rSZ?=
 =?us-ascii?Q?QDjDAq/5ZhhQCcRCmOVhos6YiK826F61inV+gqF8SdGmVdcHYuY82KMOcpoa?=
 =?us-ascii?Q?WGJUo0gEjBExBlK/RCnTzZTVC4Tlu/X8v914FON/REtteSLkgzpRLkwd1J1W?=
 =?us-ascii?Q?a7ELrPW7Zndb3KY2AHGC4EfarIJFz2NGCRtdpjSn4hFat+FOPHoLW6nkWiOv?=
 =?us-ascii?Q?D4InCEHHQLrz1ZrkBOxdckAfF3+32vDL/nAgSD2NRA0OJ9TYcPHOtNFQTotQ?=
 =?us-ascii?Q?BXzq0NEB+VCsO3ZbYU3A7I30HM9CR2O9+h4bEKzkZvpsaz/zUVdW3PTJwb6Q?=
 =?us-ascii?Q?EIjwpjBOfVWM1w+v+g8KfeVMoqJ0CempCbI1ZEaxyEOzIo3PceXTvN7gc/PH?=
 =?us-ascii?Q?aaBflz8vTVQN4E1lYQNTE5SIKNLlo9Ax0GcivFUfZkWA1o0OeZRiDqsLJweg?=
 =?us-ascii?Q?4oqWlWAfxwpW81hUwxWd/YNc5HF3y84TyC97XHaJ/f5IDxpZEfUaUc4F4Uar?=
 =?us-ascii?Q?GBwP42QWjdIcan3IMTU3JdJXDLafip4qES4aChJT0IY9Upx7DnU0NvW78w2K?=
 =?us-ascii?Q?GF6fvP5q9Gky9E5+932dUdyhjonnPdab0XoC9XQLOowiQkEhRt85FFRaWRsT?=
 =?us-ascii?Q?4/pvLgXvXGXgyML92Vl5wzVBcgSPBfQklmcxkLh8InOZmhu3kAYj+wnspueU?=
 =?us-ascii?Q?1xxwCGk37w8xXDdc+RFCckKRlbYGFQYTMbdmljp3OKaLZjRvxzRid64c/4vo?=
 =?us-ascii?Q?Mb92HmMiAnlybG4TFxA8Dw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24140ad-a025-4a5e-cf45-08daffe337bd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 21:20:58.5129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6GEklBUUS2RWj+KbqPNi14udjStmvhiI8LaPIQLHGPGiIrXAotwj1mD+0LUJ7+tZv6vBKE0xqP8WW9cRQSWsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260200
X-Proofpoint-ORIG-GUID: tPcvGqeZAtQt_k9lE6DNLDphvDOdTqmA
X-Proofpoint-GUID: tPcvGqeZAtQt_k9lE6DNLDphvDOdTqmA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shm already has the vma iterator in position for a write.
do_vmi_munmap() searches for the correct position and aligns the write,
so it is not the right function to use in this case.

The shm VMA tree modification is similar to the brk munmap situation,
the vma iterator is in position and the VMA is already known.  This
patch generalizes the brk munmap function do_brk_munmap() to be used for
any other callers with the vma iterator already in position to munmap a
VMA.

Reported-by: Sven Schnelle <svens@linux.ibm.com>
Link: https://lore.kernel.org/linux-mm/yt9dh6wec21a.fsf@linux.ibm.com/
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h |  3 +++
 ipc/shm.c          | 11 ++++++-----
 mm/mmap.c          | 38 ++++++++++++++++++--------------------
 3 files changed, 27 insertions(+), 25 deletions(-)

Andrew,

This can be placed after ("ipc/shm: use the vma iterator for munmap
calls").  The patches should be merged, but the information in the
change log is worth keeping.

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8498584c5f16..29abd0ca97d9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2922,6 +2922,9 @@ extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
 
 #ifdef CONFIG_MMU
+extern int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+			 unsigned long start, unsigned long end,
+			 struct list_head *uf, bool downgrade);
 extern int __mm_populate(unsigned long addr, unsigned long len,
 			 int ignore_errors);
 static inline void mm_populate(unsigned long addr, unsigned long len)
diff --git a/ipc/shm.c b/ipc/shm.c
index 1c6a6b319a49..60e45e7045d4 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1786,8 +1786,8 @@ long ksys_shmdt(char __user *shmaddr)
 			 */
 			file = vma->vm_file;
 			size = i_size_read(file_inode(vma->vm_file));
-			do_vmi_munmap(&vmi, mm, vma->vm_start,
-			      vma->vm_end - vma->vm_start, NULL, false);
+			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
+				      NULL, false);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1810,9 +1810,10 @@ long ksys_shmdt(char __user *shmaddr)
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops == &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE == vma->vm_pgoff) &&
-		    (vma->vm_file == file))
-			do_vmi_munmap(&vmi, mm, vma->vm_start,
-			      vma->vm_end - vma->vm_start, NULL, false);
+		    (vma->vm_file == file)) {
+			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
+				      NULL, false);
+		}
 
 		vma = vma_next(&vmi);
 	}
diff --git a/mm/mmap.c b/mm/mmap.c
index 894017841d5d..408e9cc47333 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -180,9 +180,6 @@ static int check_brk_limits(unsigned long addr, unsigned long len)
 
 	return mlock_future_check(current->mm, current->mm->def_flags, len);
 }
-static int do_brk_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
-			 unsigned long newbrk, unsigned long oldbrk,
-			 struct list_head *uf);
 static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *brkvma,
 		unsigned long addr, unsigned long request, unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
@@ -236,7 +233,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 
 	/*
 	 * Always allow shrinking brk.
-	 * do_brk_munmap() may downgrade mmap_lock to read.
+	 * do_vma_munmap() may downgrade mmap_lock to read.
 	 */
 	if (brk <= mm->brk) {
 		int ret;
@@ -248,11 +245,11 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
 		 * mm->brk must be protected by write mmap_lock.
-		 * do_brk_munmap() may downgrade the lock,  so update it
-		 * before calling do_brk_munmap().
+		 * do_vma_munmap() may downgrade the lock,  so update it
+		 * before calling do_vma_munmap().
 		 */
 		mm->brk = brk;
-		ret = do_brk_munmap(&vmi, brkvma, newbrk, oldbrk, &uf);
+		ret = do_vma_munmap(&vmi, brkvma, newbrk, oldbrk, &uf, true);
 		if (ret == 1)  {
 			downgraded = true;
 			goto success;
@@ -2951,26 +2948,27 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 }
 
 /*
- * brk_munmap() - Unmap a full or partial vma.
- * @vmi: The vma iterator
- * @vma: The vma to be modified
- * @newbrk: the start of the address to unmap
- * @oldbrk: The end of the address to unmap
+ * do_vma_munmap() - Unmap a full or partial vma.
+ * @vmi: The vma iterator pointing at the vma
+ * @vma: The first vma to be munmapped
+ * @start: the start of the address to unmap
+ * @end: The end of the address to unmap
  * @uf: The userfaultfd list_head
+ * @downgrade: Attempt to downgrade or not
  *
- * Returns: 1 on success.
- * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lock if
- * possible.
+ * Returns: 0 on success and not downgraded, 1 on success and downgraded.
+ * unmaps a VMA mapping when the vma iterator is already in position.
+ * Does not handle alignment.
  */
-static int do_brk_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
-			 unsigned long newbrk, unsigned long oldbrk,
-			 struct list_head *uf)
+int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		  unsigned long start, unsigned long end,
+		  struct list_head *uf, bool downgrade)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	int ret;
 
-	arch_unmap(mm, newbrk, oldbrk);
-	ret = do_vmi_align_munmap(vmi, vma, mm, newbrk, oldbrk, uf, true);
+	arch_unmap(mm, start, end);
+	ret = do_vmi_align_munmap(vmi, vma, mm, start, end, uf, downgrade);
 	validate_mm_mt(mm);
 	return ret;
 }
-- 
2.39.0

