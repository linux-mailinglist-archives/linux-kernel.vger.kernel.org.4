Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C523672A36C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjFITuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjFITub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:50:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41BC3A99
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:50:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359HcaOb019793;
        Fri, 9 Jun 2023 19:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=FkB+Ins4wpSolcjgK6Zg0fItOZcotwzlaN5ukWATyiE=;
 b=aBi1z62TXrbIKPfKSq9KQkKDYYH7c/qUGP3PitHIbje1ggvYFQ/4Z0SaX4JarvDoG7wB
 2cBgKWpnz4LdYCKcMx4J4KbrIwGxncuAqW2IRt3KZpjr46qsWr/sXLAm4ySnuoFhALYe
 3MdQGI0mIpOnEzhredr5bVTSoYp5TK/hERBJXC0koOoDCH9qWZFYAYs25rNCY913V7Ih
 YafEWDlOp8n74m8XdsGa493uxzSl4VKdnXc7lkLRKin1blfATIO0YYZyZVMfyUs0NXL/
 WmiqelqucBNVhuBVzm0tsQL+V/80dXpHVnCtp8Pnnoj9DbEa4lWaz4g9iZJ9HMsk21Cc Ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6sqm77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 19:49:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 359JjkT5036811;
        Fri, 9 Jun 2023 19:49:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6ntkm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 19:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFToqcxooM8IPgtfy97j9KMOpb5BjgGDDtupbJ34xHF43oDVGfV/5tjcjyFlwusyaXek+ku9EOYgtesy5cVbzMkRwDwMgNyencdzhqIduU3KbneMHUxo8cTdvHW+wlBV7OhgPDrU/W5kn8weMHDfNsoy4HUpYA/BST2P4MIMdLO10KOasLhamC+L7MXwmaBkOrVQokyaE19AnaJaCVpKLUXqibilKNi7cB1kEL9fNe75gXGGnGIP2Bld3fz1KzlWQsYRiO6T2AWpDphEOnsR00HCjLV8PrWdZLmUHy8czTYtIM2xODjSpAvsd49kr4ot4HwBznZAa34ptU7I19MQCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkB+Ins4wpSolcjgK6Zg0fItOZcotwzlaN5ukWATyiE=;
 b=Ypy2nO7TnXenyxqfcjdp7Xi/JjMmuXbDq5CPq0+Si7T4E7PRVhx3SWzdOjHppGIStdru0dH5SaaXjn6EsnhgQp4VmCJqpHn7HsuuhKzk+VnonPcFZi2y4cf978v6DhHlRzJbMAZe/8HKEkL3pieYcCUY66D+pN66Bhp463+Fbi4JxHZbCQgbr2N7zBe7EOVW202V4GpxNEnp/bD3NxwrGhc9LcFg0RQU/xx4YUHrPMfoPM8eUrhk+k4C9+ActHDrRnm/bIDCMuq81LkCD8B5TIUVjaGgbuyg1Oo68ezvDtBFSTUTh3OWBNhaSFcFOln8M2LiIcCjn0w+Jz4+H0xE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkB+Ins4wpSolcjgK6Zg0fItOZcotwzlaN5ukWATyiE=;
 b=hhd/RrVixVD4pPKlu2aywZGbnVTj6/mm2JOR8qpV7esJZBlfwUnQzROA41FEnk0cntfdBLDKjeYnOhtMUYmppJ9WzMY6rcPwFCiZ3oYWDzr13m0JFqWGBwULkZBu6J1e4aXV9Mqg3334GZelK+oFtZuCx96kqpjg0Irh+Y6vkS0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 19:49:53 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 19:49:52 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, david@redhat.com,
        nphamcs@gmail.com, jthoughton@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 0/2] change ->index to PAGE_SIZE for hugetlb pages
Date:   Fri,  9 Jun 2023 12:49:45 -0700
Message-Id: <20230609194947.37196-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::31) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f732c52-34cb-4c96-64cd-08db6922b12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWVIGXDqSjTVgw9zJSEIY7A0JO7FICwlT3TLFrm3o/T9ovaegERsm14OWQflKW08i9NY7vsCFzxraYcQ+czJ/V1GuLLdoed2H6fKQzLWfPN7+aMGJDTllSC5xnBtDF3O2VsE1poexMfcNop7EPjdPYCRvXy13QOXJ0ewbCzy3gJT2dZ+7DTpFva7+9I54mzr76douiYDt73e9Zxadh5IJ9W1UHhWL5vQnwNVh7EEVPmUUN9G+1ox4OM0gAAnGTy//AkxS8QxNn6QECpEPkrik2R2LBItQpmcRK24WI4a6oYSjzvkTj+MWUOim+KvK5ibRcQF9ueC55vQh+MVpDnO91g1CXuyLVL+MRwmwyFMwBcFU5wF9UTUHhE5xHjJ3kAQQm1Ryc5hCwnrhbhFchIcXpGnIXw75Rei3IUcW+0WadE/CPyNn005VK6TzaYIkeiBzeWhhzzNfo17GVLigwJt1nv5MS5d2V/0w48STRzlksJ6Swcbj3bxfCAf78JReOSrAuB+y2Mh6rSTrCl9juE/J48XZTPqXjM6PmL0+UYoaU0LdU8jORzWHvuqqJpb7E8dyN8ESCdcJVD2PpqF/jhAng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(478600001)(66476007)(44832011)(8936002)(8676002)(66556008)(36756003)(5660300002)(2906002)(86362001)(4326008)(66946007)(316002)(1076003)(38100700002)(6506007)(41300700001)(2616005)(6512007)(107886003)(186003)(83380400001)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X4LiUaikuRMZPfeoY3uiFdQMJYk9l9rNoX/pH5l/hfDumkuRoXy5kwXX05PR?=
 =?us-ascii?Q?GZQUFOW9uwaYp1gL7LjcVOnfmYJmYbBXOKhQ9IPs4aaeeYZzoxk5aF518F18?=
 =?us-ascii?Q?Nkrjx0FZUICuhuvNyrz3rvaMIKU6OmPdFN2IToq051V3JUdtbI47yc2YWCkd?=
 =?us-ascii?Q?xUVfxBDkkI+f46ozihhh1Pzp8d6ZHK93cfM/xV+45FFcM8xCTcB//icrY4ne?=
 =?us-ascii?Q?FJyAbFAu8XVSbkA8gDRf5a987MafXDI85ZMGINDdSHeT8OzTQHG7Q+45DxOa?=
 =?us-ascii?Q?ck/7snmM0FbMr/V5VeOMDENpslAFRn9G5J7ByB/EI6v4gG64fGuKdohUjO0W?=
 =?us-ascii?Q?ISIG1aBeHcOA7ajgzrGK0bS5cNd508iaYBkjjlWG2f4B0tUWjFVKYOGSczU1?=
 =?us-ascii?Q?psAGWgLh27Nkg3LY1FqzS6P5UxBmxj1WK4ceuLGBnMYczcE/W0bnfQfvo+7T?=
 =?us-ascii?Q?tkGfVbK8M28dCsvpKNyniT6n9jiJp2VQWf1zpvJaM5SEJJEByir2o3htqksL?=
 =?us-ascii?Q?p7ucDxZFP7bieybaizTdgj36uMoVTQ8m/cUKlXwXHB0DjDUMuK4I6UHm8aGw?=
 =?us-ascii?Q?NEznFkyFoiloMpp+dwBasey6uwlC/d9mnfp+LBx/rlfSgrDZLDcjAJZfzf5E?=
 =?us-ascii?Q?uNlj084Ozkfn2ylrCTVGHfkmOTu10HYL/UYdyRTsl5iMZGl8L6zYkxlXcaBQ?=
 =?us-ascii?Q?paW6Eh1jGeblf6RJ6ReeOnNTmIrIbowgLbkaC6msLlmgKYAIyDxCWNi4uV2F?=
 =?us-ascii?Q?xOBeoa6FcvpaDtpteaVw5eFYqpjYuj4gCHEconiGCwuOoHuvfepwkj0t1x8W?=
 =?us-ascii?Q?rzJNG+d8uRg0DzW0n3vwSMAtOyMFfFq233SSdV9A+mlPRU9VP7YLSaTgzrco?=
 =?us-ascii?Q?o8X0+5z7WX58yBknLhEU2DQMzqRBqofDtyRh/B7AKI5S53TekXgJXe6VmdRK?=
 =?us-ascii?Q?dYh0jRayffm7K9Oi8GkwejBSJ24LxvjjBg4eFFDxdg3igQ44Rhte2VeL3owy?=
 =?us-ascii?Q?Z3e5me6npg+48EgRNA/PTsphcC+F8r/GcmYvtAkR7OpK6AKJF0pXHXzi8tXB?=
 =?us-ascii?Q?KTpJMkXyJvywY6/KuoWi3LkFIYDpoVmLOx2azkF5itpYEye0GnDipIdomN9T?=
 =?us-ascii?Q?1vrkUFVB8oMJHtIhFJgx+8tqAwSjN7K1YP7PM6iBhrzB1Kikd/rW7TdkudqT?=
 =?us-ascii?Q?WmJJme52UoOerw2+p+oCgyYg4TbTu6G7f7UgKGgGvop0KYAwuWv0HNrl5OCQ?=
 =?us-ascii?Q?YIf/3/A9tDSuCqkps4K1AClekcPdBWQEbe/cuTdtj4QnOkSOyWDbjEqXS4jv?=
 =?us-ascii?Q?pQzHNR+PyDyBqnoY+wuqY4edASNDt6q+jq8HVcborvwF8dui+cvgi7dtvrmm?=
 =?us-ascii?Q?3cfdT8OSmUjQi9+i8Oz3W1GdKIGj3FtcM6MpWf0GLq1P80uY2DwwOfuTOTcU?=
 =?us-ascii?Q?0RUAQjaWAqHU9F6rnRIyQN7gkUZOFUu+77dJZmMKUvsVk6mmBKHpT7bpfKVK?=
 =?us-ascii?Q?yvGFh/IVrdqxqflvm8iVZj8QjWfwMWhaXKozCoY2I+kG0oqtoRMcjb3w5FX+?=
 =?us-ascii?Q?ykRQMcU/QEmLvigPE42vmDo2ld4iNSJxl4mNtdp0EfdS0cc4CXZCCjwviZP5?=
 =?us-ascii?Q?R7s208AI+dRxCKT5nuPKx3k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZmEBFoYS9qjp22u9vvB71lw55LVBdjqPnujPynhf0V1nKEZch0wWRobcJK2V?=
 =?us-ascii?Q?X36hx+n8eg0fqvI44r7G9P9UWJQEq2EeGfiTjUvfqa3DDTBjf1bLoRm6/z/N?=
 =?us-ascii?Q?rEfXWwgaoJutwB5smRHcJzRsZUKIcOI7VhiFBtg5yutoCF0jXVBsxjA1A0Di?=
 =?us-ascii?Q?CxKKZQRsVzvojCzmmeii+T61r/1PNRa3gsRP18CFt5Z3SbS8/iqHBdn+UACV?=
 =?us-ascii?Q?sNy7EI1emF1mBvT18YLl1d+Q9iabMo0Za8VwEgIkr1p2IOzr13uRsnVtDWWw?=
 =?us-ascii?Q?q2EeC2XXsEqtZ1Eo3THozfi5mf7U4V57+MsONCSK4jirV+LgVOv4mR4HIeFG?=
 =?us-ascii?Q?psXgWCWwqIkyAvc0pR+hcTXI5WVB5/DLVMVpf3olFZ66CdQmWVS64JjsUUHA?=
 =?us-ascii?Q?Hj7AvCeowxWCbK6nlAWde1P40RjogWGkqKVQeqMxXt6GkNLhB3+e+t1p8pUi?=
 =?us-ascii?Q?SrLLiiVnHxru6uvwprYKzfz4Kxd8NkSz4xkotQQrnoY3NSL/ktdE7zQFp8Eq?=
 =?us-ascii?Q?RvnBheaqsvx9PEsUUcgtIoknPJYZwU/lCS3ZEpAaE9itk79wqMHJesWrLy/u?=
 =?us-ascii?Q?G8JZbm+8HsMR7AOgTUVq4BWXSw6dJ1172HTiQV3kt50ntbi0RL2djnLPqUo+?=
 =?us-ascii?Q?J1SjeADoE1YOuMcLgvEBSU8bkcN/V8hzihTy234kqX8mIQYjdniN8BvcAzBC?=
 =?us-ascii?Q?3vHHwHh9w2dfOJN+X6fbv4YfKDzMNvHO7xPaWg7NOoLs0rfx+0QFATcwdpid?=
 =?us-ascii?Q?+ngq6BLHFSzkNd0eC6evUvxhMCFI962OTP1fMZZPPmgnHTZLzQMeaEczltfP?=
 =?us-ascii?Q?fh2Wkkk/7GhKwMCvDGvqBxpGRIz1ZzKxDkOQjgjbb5amenZUJ5nkaS2Fx21V?=
 =?us-ascii?Q?PwSCT7WNQAt0OMfzZq1fhHbva2zH0Y/XbV6izgoyI16jxXL6noq/8p0kH/oM?=
 =?us-ascii?Q?SqgCLegTN6FXO3QAM5KoEqVnnrg/SmZ6LpeBmllgSAFyjGaR4lJri+RxLBPV?=
 =?us-ascii?Q?H0dv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f732c52-34cb-4c96-64cd-08db6922b12d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 19:49:52.8150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GT875Q4dUfb/svgnpn/Zm9Rt4/5smgWT2rrklZ3XbW2/6/mJw8roo6YkbqoMCch5vmv1u0MtZCWOSWlTAiWv/8AvXiGUwEA9U29pi4rRMtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_14,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090166
X-Proofpoint-GUID: ZVlOzIbMZ1xnYs35PbKzCb5rMgktPwQj
X-Proofpoint-ORIG-GUID: ZVlOzIbMZ1xnYs35PbKzCb5rMgktPwQj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



========================== OVERVIEW ========================================
This patchset attempts to implement a listed filemap TODO which is
changing hugetlb folios to have ->index in PAGE_SIZE. This simplifies many
functions within filemap.c as they have to special case hugetlb pages.
From the RFC v1[1], Mike pointed out that hugetlb will still have to maintain
a huge page sized index as it is used for the reservation map and the hash
function for the hugetlb mutex table.

This patchset adds new wrappers for hugetlb code to to interact with the
page cache. These wrappers calculate a linear page index as this is now
what the page cache expects for hugetlb pages.

From the discussion on HGM for hugetlb[3], there is a want to remove hugetlb
special casing throughout the core mm code. This series accomplishes
a part of this by shifting complexity from filemap.c to hugetlb.c. There
are still checks for hugetlb within the filemap code as cgroup accounting
and hugetlb accounting are special cased as well. 

=========================== PERFORMANCE =====================================
The time spent in hugetlb_add_to_page_cache() and __filemap_get_folio() was
tracked while running the LTP hugetlb testcases. The units are in nanoseconds.

6.4.0-rc5
@hugetlb_add_to_page_cache:                                                                                                                                                                                                     
[512, 1K)           7518 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|                                                                                                                                   
[1K, 2K)             158 |@                                                   |                                                                                                                                   
[2K, 4K)              30 |                                                    |                                                                                                                                   
[4K, 8K)               6 |                                                    |                                                                                                                                   
[8K, 16K)              9 |                                                    | 


6.4.0-rc5 + this patch series
@hugetlb_add_to_page_cache:                                                                                                                                                                                                     
[512, 1K)           6400 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|                                                                                                                                   
[1K, 2K)            1230 |@@@@@@@@@                                           |                                                                                                                                   
[2K, 4K)              55 |                                                    |                                                                                                                                   
[4K, 8K)              16 |                                                    |                                                                                                                                   
[8K, 16K)             19 |                                                    |                                                                                                                                   
[16K, 32K)             1 |     

6.4.0-rc5
@__filemap_get_folio:                                                                                                                                                                                                    
[256, 512)         11292 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|                                                                                                                                   
[512, 1K)           4615 |@@@@@@@@@@@@@@@@@@@@@                               |                                                                                                                                   
[1K, 2K)             960 |@@@@                                                |                                                                                                                                   
[2K, 4K)             188 |                                                    |                                                                                                                                   
[4K, 8K)              68 |                                                    |                                                                                                                                   
[8K, 16K)             14 |                                                    |                                                                                                                                   
[16K, 32K)             4 |                                                    |                                                                                                                                                                                                                                                                
[2G, 4G)               4 |                                                    |

6.4.0-rc5 + this patch series
@__filemap_get_folio:                                                                                                                                                                                                    
[128, 256)             4 |                                                    |                                                                                                                                   
[256, 512)         11068 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|                                                                                                                                   
[512, 1K)           3334 |@@@@@@@@@@@@@@@                                     |                                                                                                                                   
[1K, 2K)             559 |@@                                                  |                                                                                                                                   
[2K, 4K)             112 |                                                    |                                                                                                                                   
[4K, 8K)              42 |                                                    |                                                                                                                                   
[8K, 16K)              7 |                                                    |                                                                                                                                   
[16K, 32K)             2 |                                                    |                                                                                                                                   
[2G, 4G)               3 |                                                    |

This performance characteristics are similar after the patch with slightly more
latency in hugetlb_add_to_page_cache() seen by the increase of events within the
[1K, 2K) bucket. Please let me know if I should test more functions for performance
impact.

=========================== TESTING ==========================================
This series passes the LTP hugetlb test cases.

RFC v2[2]-> v1:
  -cleanup code style

RFC v1 -> v2
  -change direction of series to maintain both huge and base page size index
   rather than try to get rid of all references to a huge page sized index.

rebased on 06/09/2023 mm-unstable

[1]:https://lore.kernel.org/lkml/20230425012721.GA6696@monkey/T/
[2]:https://lore.kernel.org/linux-mm/20230519220142.212051-1-sidhartha.kumar@oracle.com/T/
[3]:https://lore.kernel.org/linux-mm/a49e7ec8-735d-5a81-1744-cb887389a559@google.com/T/#r78a847a834671a9a7095c9458d9a1737015e7d0b

Sidhartha Kumar (2):
  mm/filemap: remove hugetlb special casing in filemap.c
  mm/hugetlb: add wrapper functions for interactions with page cache

 fs/hugetlbfs/inode.c    | 14 +++++++-------
 include/linux/hugetlb.h | 21 +++++++++++++++++++--
 include/linux/pagemap.h |  8 --------
 mm/filemap.c            | 36 +++++++++++-------------------------
 mm/hugetlb.c            | 22 +++++++++++++---------
 5 files changed, 50 insertions(+), 51 deletions(-)

-- 
2.40.1

