Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717F060C467
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiJYG6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiJYG6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:58:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2E2857F9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:58:02 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29P0xnsb032293;
        Tue, 25 Oct 2022 06:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=uaCVeoLotpNtFmLM0Z8YiHtaOP4u6QIs5Zk8iQEr+68=;
 b=TFERSRUZhfdGQZHTE8S2063tLjIxHe974ybINodQiNWW/8ZICL2faWCYZ9Zqng8dIh5P
 ezIHjfl3LiY4e3LimvmyRWwJDuZ6VY7iLsw6U3tESwSzp/JmMzuqsMu6nB90I/vMPbyX
 3fspD5CurX8XFHuKkrM0zlV1COYApRRpW8SuWOdzDBurekujoLn6/HVe9n6PmZkYwV5r
 SAULjFEQyhiwnefzP23ktOSjZxMXW4QO9GIJ3rlWn++ENSqt6HQd1bRtUC1lIM4dy3Yr
 e2Gl7DKqmu7pOPXmhlENNu6UDqL3jn0GBIN/QO1PmBQLgoXAp0W4NBbVZXJgksa5KQOZ 4g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc84t100w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 06:57:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29P60YbX012771;
        Tue, 25 Oct 2022 06:57:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y4bnwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 06:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyI6MXck4y4IUdFvE1GSc/jSnqIjCbEYLC8dO1CdzoVysTeT5ZrbNEqxlnHqsVOliRBkeaOyLplILW+wdPP2eKTf1n47uPyCq0BB2QBOiinDyDlK7NOTyyPJH2/7ZE7J9S65+MKgILbJgY4j7c2a3NToauz03bPZrO1FoZg+Zw4ho/vuaAiv2TzDnh5zcWjRLq8ZuH/WoeCQPLBDmuPLWlBe8cS0yety78jJkfnL49FtFSKsfH4Z3f+tbE3U5toMqtdcP0x69nCMUljewkgAmCxWq3+8Gcru8ZyePrWacsUmFNHIWZwtGeLvjXSB0Sw3xLj0cdtOxRegA4aAFOfpGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaCVeoLotpNtFmLM0Z8YiHtaOP4u6QIs5Zk8iQEr+68=;
 b=f1rR+nCb09wD2bpraVpskR4HiY8UomI2vVwjnoxosICvyvcMgE9s5oUnG5jMwCWsuiODxnBkx1oTT9noJpmIriSXswMlaOeLPaJLNMO7sftckfoobBDDUq9/eTQtMZfeOD2AoEqubseQMTNXQlDTtd7WMG2r8ray/zrc6uwSI6Hjrq+S6WF+HHWHJrPa8w6ixgv6vhMnkr1vpkMjJwhEEruZ8Jjq6gHgFJsIGvRs9t/gptXlVX6MaxHKbekk2wtwuA34zRzM9m7F1prh9wZLbmgGGzy8m3vWiZ82ylcHDuw1sR13/VzlaUXCkBx9QAMfO9cczYjyt1je4bZ1WVbW8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaCVeoLotpNtFmLM0Z8YiHtaOP4u6QIs5Zk8iQEr+68=;
 b=zLHTUtCzy5Db6M4BNfr0kMklVariDfWE8mUhfDxu8Tj6FrIZ/w/9eHpVm+SpZCen+00Gz930yxZ7VjpcGmDAOIY+gqWeEQ2+ChQBDxI5/SQhpM8j/TZIOd7gfBlo6JQTVZ9P7sAn/aAn1B7JEJfEim9E5oLwFbcnqNYmVdzmHTs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH8PR10MB6289.namprd10.prod.outlook.com
 (2603:10b6:510:1c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 06:57:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Tue, 25 Oct 2022
 06:57:49 +0000
Date:   Tue, 25 Oct 2022 09:57:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] staging: rtl8712: check for alloc fail in
 _r8712_init_recv_priv()
Message-ID: <Y1eI4kTRSwEG+G6g@kadam>
References: <cover.1666645510.git.namcaov@gmail.com>
 <ce12408f17f90b3b368d077a7321a2a252f52b72.1666645510.git.namcaov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce12408f17f90b3b368d077a7321a2a252f52b72.1666645510.git.namcaov@gmail.com>
X-ClientProxiedBy: JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH8PR10MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: c6182b29-b36d-4bb3-106b-08dab6563acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QabulfYv5cYZ15qqr82O5wazhrc25d417GxofpR5EEWs1qjc1KX0gWLWe5Sle6fFOsDLENjjjlC5OK2x8S1uCnFo2E5dR0BIJAhd3T1AUa0edCAuVBbqS6zzuDaEqDHzra7P6erZF5H338HYy7UGO5TTpwQ2MkmAcNy77gErn+7fqvBcgU35iaqeBCZU7Tsvt5GDoasZNowdR8oM9aXN0xcoLWR2hngOIeZBhyO/f7qamPjOpXUdriE+phZYadu6XEzP0QuufoPR7qMU1y3dSUa7X2hvoIkYiNbxJmaFHdQorK7LG/3f0a67yLUPdbx2/2+CJCumtCApQHTF8yTOZn6IV9hj2UId3OOqGM43nk9Rmo+KBvQjuJjg6TaMndQXa791DU4lZ3WzAZOK3vYd3eqffyoMn9uI6BiHQJTrMVkdGb3g9P8MrLTx468L7RuvsV5IXuqj8hOYWXXrOxN7bk8jYUgk9F3vMzAp58A1HvcPw5kHMVRmEZQF4eDpicePaaMktnamUo6y1EchixNlmc5fqhc2VbFbKI7689GPVWIsjwfzmset+cc8QJcU2/SmGmoKcd8Lsj+2Lt8hGQl2Mt2sOS940WJsHSEB0CLQK64PJ7b4NqYXhplRxktUZy/WFA7BfVAPzhWsOBhFlC9Q/XAChAV+hrZ6v8psse6ls2/vwKBDOqcEu5HPi+cEp20VW9KhkYSH+uZJDifo0/jsdHy9VNkSRhmtHEG2gMsjWWiRA1Canlz8RYWEq3+q9VJd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199015)(186003)(2906002)(83380400001)(41300700001)(86362001)(26005)(9686003)(6512007)(6506007)(4326008)(8676002)(33716001)(54906003)(6916009)(66946007)(316002)(38100700002)(66556008)(5660300002)(66476007)(6486002)(44832011)(6666004)(478600001)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g2Fc8joXAgqPprn+byF8z3QN8yqbfNZbkeLiLNsvwNnt4ohNBrEwpLLR9nB5?=
 =?us-ascii?Q?xurXypoTZ1wNjld3lFhRxGbIGUlsnT25i7wOBfSL1MTElbZ/cneYnTkZP5qv?=
 =?us-ascii?Q?HnUD5U/EPL9IpClGvfb3IBoreloMvZuFXJJhu0p2WK5MsOJywk567TivHaYG?=
 =?us-ascii?Q?bwDTAgWWfbNyNnzZk9B2PKrIsVV+0ZzzJZQBUVBnI3d526QwPJmfKx+QWXov?=
 =?us-ascii?Q?h/k1S9hqvS0OOpXsjLhYZBqPA3suXc9e8DiNZfUqaHtcrV2mXGte9GcDfVqp?=
 =?us-ascii?Q?AtcnC0hq9wOMcSmJ0ww5zVxjdIZzstto9vBUt5kqKr7YCbGp71FaGHv/aVBV?=
 =?us-ascii?Q?V5kNOi3d51RGoU6mkMtO7SbEfvNEpl1kErgWbgdHEh3vQPhHWBYimjRls1Rd?=
 =?us-ascii?Q?l3I2nAlUAH+nC0ZTrTFZjD9N3HKi3XfGeCAL7A8mQnnj01wg1FmyeBHHSNcO?=
 =?us-ascii?Q?omqRdAWhtVhlrXzbLoznnl9GNNffvyR4TAv9GoC7zaypeHhV2y8E1pQ5yFgE?=
 =?us-ascii?Q?4DgGpGLfmNaNKk9OOYn1XzRcilXDHm2h4CaUom2XD6bAcVJxOiVwnVvlgCnd?=
 =?us-ascii?Q?S+SYbFVKnx5PXTYqJwJDE8IV2DWBOWFAn9JYY2ra2QWZDBID11s7yjCHh+/J?=
 =?us-ascii?Q?QBblsl1vE2g885AyFpru0SNad5s4ksuQtAoD1jeJkkGMkrU8l4WLFtOMuPqD?=
 =?us-ascii?Q?+BFKPpsLfE8tEuQ326HYl1cRnOpY2Xp6VWDjZkKexdZK3tLISh3Mysju1qhe?=
 =?us-ascii?Q?plcCNijEj65u1s1/JG5SeIcu8AgqPkX6+iOLrBikxZuGo2u3GVDeKkXQHRGY?=
 =?us-ascii?Q?VNMSJweMUFX6iiIkUTCSS0SaUX5Wguef3VUQrgDQWh/cNqJZHtkr9OoOFadG?=
 =?us-ascii?Q?X1Uv7qfcLsm4R2gPF6I7aeXLjXNUdXyscGZaKnwhynlmRIWgXA1J65A66IKX?=
 =?us-ascii?Q?oYKe9eYvTSTp5kzMgY7ol46F7HNDXfnKPHBIvN7ZBsBzB+LoNYhXBr0YLWLU?=
 =?us-ascii?Q?lIbFg/xTQxwGFP7WWl/esKawI+4hKYc/1GryIP5urHh59cdBpuLPkW6sEL5S?=
 =?us-ascii?Q?8PqsfYbG4nUlgZ71TU/mj+iScIgowoerHCbbwpzAFGZ0poHp0NnRY5o1pnA0?=
 =?us-ascii?Q?wu4CbrBhNvWcifFsM4Lm5UcWUx0fDM/x1Ts1IWH0lJdxDsNgPkmSHAoN+Aaw?=
 =?us-ascii?Q?j4kpvjHxLsBoKw6hHtgk7EniMQX1sMAVphGpBTUdeFCMNeBz5PXCIOXrp8dK?=
 =?us-ascii?Q?5qDIyG4tPGjVv2nOxhu7ekr9thR+88I8hCdTpcxKDCqrhh+8KE1z7N4iZlmB?=
 =?us-ascii?Q?74pePUOVOk1FllXRmbFkhS+pA/P+Ob5uORu8CZz50hY4IQFOdzDwvQDcuMDG?=
 =?us-ascii?Q?Ik6zTxbTNox+doJqNrugpcUu8TIiLHKC7APAZIPshlU4qzJggl6RTj5UOK9B?=
 =?us-ascii?Q?vKj3UKCzD+JoleJnQRh/pIBqA47xsJizyR5p07Kr1JHz1FmQ+gXV+XTmLhcY?=
 =?us-ascii?Q?MX6RfuqSYV6t8e8PGRrqaaMwGQgV4h1V62Dp8Sj7iiwpGRCMcxN65oGbbLls?=
 =?us-ascii?Q?m3QxtO66GpSpTgGNWvSeiLmHwq3dET6B7e9n3RMPwO5snjETPEAjzrt4AxuR?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6182b29-b36d-4bb3-106b-08dab6563acc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:57:49.8741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hd5Fu7kJo6viJgg3BHrvySlVH5xTY4HKu6+37z1M21+jZ90JGqsX8dFMkW/eMc5dh0/7xVorpAgK8CRFnuGzCc9RmVyVXdGadjo5k08CRq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6289
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_01,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=867 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250039
X-Proofpoint-ORIG-GUID: g6LuCB0MUixaEvZTijQJyxMUuRiM2Jpp
X-Proofpoint-GUID: g6LuCB0MUixaEvZTijQJyxMUuRiM2Jpp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 11:24:07PM +0200, Nam Cao wrote:
> The function _r8712_init_recv_priv() and also r8712_init_recv_priv()
> just returns silently if they fail to allocate memory. Change their
> return type to int and add necessary checks and handling if they return
> -ENOMEM
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  drivers/staging/rtl8712/os_intfs.c     |  3 ++-
>  drivers/staging/rtl8712/recv_osdep.h   |  8 ++++----
>  drivers/staging/rtl8712/rtl8712_recv.c |  7 ++++---
>  drivers/staging/rtl8712/rtl871x_recv.c | 13 +++++++++----
>  4 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
> index 003e97205124..47d7d998fa86 100644
> --- a/drivers/staging/rtl8712/os_intfs.c
> +++ b/drivers/staging/rtl8712/os_intfs.c
> @@ -309,7 +309,8 @@ int r8712_init_drv_sw(struct _adapter *padapter)
>  	if (ret)
>  		return ret;
>  	_r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
> -	_r8712_init_recv_priv(&padapter->recvpriv, padapter);
> +	ret = _r8712_init_recv_priv(&padapter->recvpriv, padapter);
> +		return ret;

If statement missing.

>  	memset((unsigned char *)&padapter->securitypriv, 0,
>  	       sizeof(struct security_priv));
>  	timer_setup(&padapter->securitypriv.tkip_timer,

regards,
dan carpenter
