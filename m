Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465445B5B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiILNZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiILNZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:25:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C38A2FFF8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 06:25:29 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CDEh2b009251;
        Mon, 12 Sep 2022 13:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=n06YiWBxUzkI57rZQjS5taU4OMvbNdBaGVtBB0mw6YE=;
 b=H3aghzkuDOxL+A5W6D44t9DqwCxBBPsqiDdwc9GuI1R7cUjgWx/D8VcCTm29yEt317dh
 F68fHEcCHj9ErTV+K3I8c+FwVtDi+qGcPgDBgbAdHPIUEDHtTh/dRE/mZS8dqARWAbPz
 nUJIxUrQGIIH2i7cju+p8tdr+/i6nDViTgRr3bZ6NQuY2L1R4A7wgeNkVMXH2QeXQ69I
 6LxysaF6i+2RGFKdupjLnlqpdRjiqEdMlG3Kn0MJMOgTH8yMwNKWCYwgG+/VIu6eYIlv
 Dmq+A677yO4aCan+WZQZJnlmAZMxDqJhv6lsOoSxnMqvGoFZLXKW4BjlgUw4+kg4gbD0 sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgk4tbecm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 13:25:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28CCEgtb016831;
        Mon, 12 Sep 2022 13:25:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jgh12hkqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 13:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQ4V3dI642EZ+UhSkLGe87lNOjue8n2XdlARwuGdfJ3SicmUkRPpOPS0MOg4X445okl+70BmcP8TwLQZGTxQYQLLIwrAHozyRMSbT6I4Z0rdiGT/NB3h+9C0bR6HfijUmA0N3FTl4sOwiDY5atjycctNtsPMM18ASdZEuicP5dVRyErwn/D41UvZbp5sA4c6W1KEn7qZLThcSzdwxch0MRiyrTpyoaYjqaFQejx+NDf6N9WMgM4HC4R/Jv7CQV+e8IRf1qme/deO9DCrvGZwASRnUogUqTBT/Ch4B/sH5Fp4SfSwts/0NP8ThNnUgnmc/5EQ/CQYqRs/ThNMkqXCaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n06YiWBxUzkI57rZQjS5taU4OMvbNdBaGVtBB0mw6YE=;
 b=bWcwm7fpTh0EPtYlervQBO35K6JG5MOZjl4CtkD50y4mX5OyU4+Fp5yY7XPXHPSvM2MxbgBHnx2ki52w2FCes21nZuMqlyumNtolKIWDCARo8V5pznQ6FLXlWz/aWwBWbY0X/FDJ4iwYZ1Z8J5peGX1Mv70lN+5tJ/K9OCf+imHnsvi7ifeobLwNdNFcdpGXMYwOJFRkQHsUnKUOepC53NeBqMS8wY7qeLhk66FxKdacivmbrTHfI6fqR72FKJqVFM0BzmTJYKSK+0jdXMI8B/NQGXT4Yd2/IiGztaJ50OFrmtfMGMMwivWjigvILWpAZasmawKiDuJTeLm+8BjM+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n06YiWBxUzkI57rZQjS5taU4OMvbNdBaGVtBB0mw6YE=;
 b=amOVC0wYxi42LerouaiFnldTi03vvOrH+Rvw3QnWivYJNC3U6tYncwwiMcPfn/dAjv1rJxUVOhrFkMySLLzDMPryqAHAxX9LpJOOHsd1H3RYkC1msLtMnbygTg5L+9jkrxtE4eo1GJ0RDB8jjkhySKzhwBO75ChBzh1f1REGtn0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA2PR10MB4763.namprd10.prod.outlook.com
 (2603:10b6:806:117::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 13:25:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 13:25:13 +0000
Date:   Mon, 12 Sep 2022 16:25:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nam Cao <namcaov@gmail.com>, Ji-Hun Kim <ji_hun.kim@samsung.com>
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vt6655: fix potential memory leak
Message-ID: <Yx8zLugepoJkJjHj@kadam>
References: <20220909141338.19343-1-namcaov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909141338.19343-1-namcaov@gmail.com>
X-ClientProxiedBy: MR2P264CA0106.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|SA2PR10MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: 1507b488-4902-470a-4772-08da94c2392d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QBR2xeexv4AMsvdhM/RwRANiHljXpZURTppCbtvMe9CjBTr6mbzNEzMRceVLbCi9L7sEIsf0yYg+V2nVIQgLJI8PL6srAyEBmAOFsdnhCwv5TeLkn9M1gzTmaQ3HRBEisXkXtUluD92KBntGC8EXhXAH40n8ASXmUpUhQjy9R/oxT8tYvjd9qFle651JBPXFiaruFKudeh3gSATKjysXKiLouuDE3+THBFv0h5FH1G8WEGs742UvbI92uR23QcsshknY3U4X3IkBk9wh7gGMqmHZ5lk/ULc2lqqJo+ccjYWEcPjfbTctgjdCzDoeZjgDYFLbkSwFaKhSguKef8pu8xni1CEhz++HyYXlUYKp0UgytFpm7x1Hcl9PbKwsdkz5sm6CzwB2wrROGHhXQdm+Nh4m4DWSSt6HEtc3Dr0nLPjcpOeN4ai9sM1QEthxw4AC82QUYSfdAp+ASKRGHIxsydFN388uFonk294xu9UHJwXCRu4CJVehJiJUpIi8y4hUkGuXxDOke1mBd+w8l5G4ENctK2TU4WCLxV7ffAlLh+mYEVj82g9VGvwUDC5WuHtBeIEfZKvcJybwO/+6nh9TDk2nZud7XAXkgIwCRvjmRvWKjzIyCTHAOcR5j3w9mRqhg3v8cVVk+VYXe8Xr2qmTQdQJgQqSbH2JEShtJssRpvCVdhPyNBXJjmlVkFkxmLXjqE3/gjhqnE51R6chVyLFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(39860400002)(136003)(396003)(376002)(346002)(38100700002)(83380400001)(86362001)(4326008)(66946007)(66556008)(66476007)(8676002)(316002)(2906002)(110136005)(5660300002)(8936002)(4744005)(44832011)(41300700001)(478600001)(6666004)(6512007)(6506007)(26005)(9686003)(6486002)(33716001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PsEduMj7p+HqbM1uMMh1orrLHoXsSCj5JxwTr0G7+IV3z3p9mI/+dAjyT7rx?=
 =?us-ascii?Q?w40qtrWyJI8/0/Po6VKcZMBpjLqj9uNucK8dydPtT4yF98VoKLVXV2CGHU4K?=
 =?us-ascii?Q?sTXtByiW11HGUvG9XHKfeFPtwenTRbiVxXSW4m/SrZBhyK8LLmAcC+40krDR?=
 =?us-ascii?Q?wNFpxu6aCYhTlSrDatiE6hmyjfIQAfYLHvSEV/65GuSJVBXnzoAANNXo6NP7?=
 =?us-ascii?Q?mCgYcYf4D9owy+yuEWkSj0GZGNSFBCVfSW0XIvmt4At3/ceg4k0GFE20DlMJ?=
 =?us-ascii?Q?sz1Tb14iQnFlXHMhRjicn9DTBFjeQsnqwGVj1u5ORtnkySMMfkeCHWZvBeiS?=
 =?us-ascii?Q?v5RlRxyTsy5uVsO9rAt2TfavsgwhhWQKaZmcKHvMaBA7DyOronOrwqzBViKl?=
 =?us-ascii?Q?hsdcI7AfiwjKSzr/O0bS/+WNpeosdWgZMJhV2RrVUM3r6RhT0+oh67nG6MS2?=
 =?us-ascii?Q?h/a3WWPqbcIZzFy9PFCsjU1jp27MYmEJ17j2EK8DoShCbOkHKR/6LiaE4JUC?=
 =?us-ascii?Q?U/xcjnFhl2ekVdip1znv3H7VDwES7+Vwlbny/mA97DQxUdgACA1FM0xJmUN8?=
 =?us-ascii?Q?DdfIjPrwatvn1VnmUAHRoA7VnDEQmp224U6iC7ZECJTZkLS/uOoz9EEcQtc/?=
 =?us-ascii?Q?LFEPysyIGA64WkASz9d/dnj+2/gR8ZHQqmJfkCVy2p8BuzvZXQrccdikmOCy?=
 =?us-ascii?Q?tXDCNUSL6LwtjuV8Bak2VKN1VJoODX4kOTzCuFdjM+Y+1NjDBE3O63RaxgJB?=
 =?us-ascii?Q?3ElpZSRWQjoYWB7+o0kAyX8b8TVba7lIZGup76itVAvD9rf0SOLxfF71D5iH?=
 =?us-ascii?Q?XuThq55MUNo6JrAnCOG703Zt/mLw0vldjD4x3MFrbPNir1KZoL5w8e/Ypn2Y?=
 =?us-ascii?Q?zi8mdANDCp7I0lWZucIBk7JHL0qbPitB8Daq+AUqMU7X6YJ81pOf8MPKW8KK?=
 =?us-ascii?Q?d6FCxhmKU/D8WbhGxCHj1cYPlnpouB+7Y7MNd5rh6jcrF/c5Bz0ZBXJaOxoR?=
 =?us-ascii?Q?cBt68kXKgTqEK9lHdoELhaXsf61U8F00qVbMs7m+SNJ57iE4w4VlLQdydmGk?=
 =?us-ascii?Q?APQA8ID7IaMZuAn4TkIU9mjhPQtumkIdrapBDos/xdctTK7bVZYPAKxHzF1i?=
 =?us-ascii?Q?bydeNf01+TAAmvsvOlGhF+WwYJrPgH5G+KC8sp5MiwIPosa3XM0/sSZpdXoP?=
 =?us-ascii?Q?CdILfts/24KZcCHpDy69GgeJP9r8jIRAlsCeLT51wDqyo2nVuHjH5HSq8nFu?=
 =?us-ascii?Q?ppJ2HLJ21gDfLrQDyHpfMtsUdIdHzYWoynFfJwLprbC93x58yDQvPAaNqH2x?=
 =?us-ascii?Q?jZ4a7c8s1fjTROB2maVwiJnb5V/9CwuIyoDevR7ZuwyPsQtGaTvxiOZ5d5ov?=
 =?us-ascii?Q?G+i8Du1muEAtD2Vq7Ufoluj7pNwOy7v4CCfPdW3Gk7jy/B/ihu+I7LrGzCAo?=
 =?us-ascii?Q?0mo9A27Br77fI/7eQuTs782lDq3PcO0Jtnw1RV6yNvvN7VilnX1c+ilh9YYy?=
 =?us-ascii?Q?hg9DiAYoMxl30Q7P8yDKq6Tgl7Sl0Sr3dyBUXtuQkeA0uHCTMxT08NUhGI1x?=
 =?us-ascii?Q?QdT+V6ed14twh2ORrD3r3qgNLuiOEniGhZ5vHjKH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1507b488-4902-470a-4772-08da94c2392d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 13:25:13.2993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e22FC1z6yWLirSQgKwW2SAIOvrWci5xnk+IKOzQb/S0NWjmbZcJphqQKh9bi88GRV3pTuRYcuDhU5Mvk8IE97I/MnWKM33gTYHaXOwM42g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_09,2022-09-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120045
X-Proofpoint-ORIG-GUID: YQu44G7rIgUfgOgMU52X1xw-VCrO-vwV
X-Proofpoint-GUID: YQu44G7rIgUfgOgMU52X1xw-VCrO-vwV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:13:39PM +0200, Nam Cao wrote:
> In function device_init_td0_ring, memory is allocated for member
> td_info of priv->apTD0Rings[i], with i increasing from 0. In case of
> allocation failure, the memory is freed in reversed order, with i
> decreasing to 0. However, the case i=0 is left out and thus memory is
> leaked.
> 
> Modify the memory freeing loop to include the case i=0.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>

Looks good.  Please add a Fixes tag, and CC all the people who were
involved with the original patch so they can review it.

Fixes: 5341ee0adb17 ("staging: vt6655: check for memory allocation failures")

I actually wrote that buggy code and Ji-Hun copied it from me, so my
bad.  Sorry!

regards,
dan carpenter

