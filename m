Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB6D5F9EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJJMYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJJMYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:24:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0F2262F;
        Mon, 10 Oct 2022 05:24:12 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29AC4x8g023804;
        Mon, 10 Oct 2022 12:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=qrqmfIEn6/uU96BKgEGADuWgEc+bKhAtHPKT7u6aGJk=;
 b=jt01+Iztj0ymdM8TZ6r905g+qkeAf9St+GHkm5iHYxs/fzqB3nsJGczTUdPC7c5CQGhD
 yzroMJDKtFdfGNZ6cAG0Uz4x/htJvysjQ6io17q7kI46/olQ8g1inXEqta3iUIb4PU4V
 cLMaVGDEWmz5kNGg5VA6U31Go7XPL3yVFAt2JFAlHTFUqXJxK67K6fmi0ynN+2sTslcZ
 PQv5z77ME2+/qo9+kfyKjX5ap2kWbrMsvyI7iD3LSYAaHLOlSWUwx3f/BtjmMxFb9PyT
 w8+1XgHk2ZNa3lR2xKNK7lP6fEfaa+7n7VaIpRa7UPymXUTAssyONcZi7uKKUmPZPmYx /g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k2yt1bgp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 12:24:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29AATCO7003116;
        Mon, 10 Oct 2022 12:24:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn2kpqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 12:24:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaEnEq2iBOiYeZyYwuKBz53AyBdVjV8113fV19qbsnhH8KFtRXI7i1f2fglFwhkp1dXn65jWniTGPA+wbmDf0KynohGMqVNZnUkv9q+JI4tl21Ox+4tTdkLU6a7VLHSTMcyYzpWhZC1YBo3HAl4y6y4o1aHWV4IuiGPTk+3XZUUuGgwCxuEMlKTt/lxjZeS7ZQZEMBCC2+YqeJ56pM1ahSEC8Lp+0MIUvNbFu9cCdOFWQzTs7Ws32e1O0ZXQYGUt7GazcYwj0+5TF8FC0RzU8wnsC/nEnITURUxYmBrz6SO0wMbhA9EqcC/78bncudnN+MJ3UmHB4bsWi8qJ60+WrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrqmfIEn6/uU96BKgEGADuWgEc+bKhAtHPKT7u6aGJk=;
 b=cUpB+4I/O8h2N7jG9riLW1sUkxudtML8Ph0W7WoLOh/ZPt1s/nx2PZfmx7FgENNSx6TIfJeEVu8vqEOpsss99k/xMTn/nGlS65sj0ENJWJUFEruY5i93rHUmJg6bKUuOx8W3zq6d6tF/yi9ISsZCm/vdXCjgmO0QU3Qs02+JM1OHqaCUfPUjXcW+nHpg7vekkyZhz/QTmsgqvVP4rmbvHwbPmXIvVa81OjY4vHC4m88/aQYI7ea5HNgjA6cT9/ePsh5AZsmRBDUJdC0lvyBFAN6K3GWOlctU1/C9ZuFVUMchqlo+S+BB85aOsq165qjLMvSQ9HmyJiyaF1dzaueGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrqmfIEn6/uU96BKgEGADuWgEc+bKhAtHPKT7u6aGJk=;
 b=B/8Fuz7bR0em1+mCP73+Cq0uDpS69x7HBwrPvMyF3Unuab6ukd/p9Kb0yDaPPw7kPk/kHebCaJdNrrpvIZToVX1xXwsokhoKfz/rMLqiWpoT6JEvkRB7p9DbBUEFna1ZNx6p6EXtrPFgcan4HVjIz/eeT9YIPXvdFGXlT+E7vgY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4672.namprd10.prod.outlook.com
 (2603:10b6:a03:2af::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Mon, 10 Oct
 2022 12:24:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Mon, 10 Oct 2022
 12:24:04 +0000
Date:   Mon, 10 Oct 2022 15:23:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Vishal Bhakta <vbhakta@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D. Milne" <emilne@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: vmw_pvscsi: Fix an error handling path in
 pvscsi_probe()
Message-ID: <Y0QO3RLY+gD5i/jY@kadam>
References: <ed31652626b0d8133e90f6888ef2b56cbc46ee57.1665297058.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed31652626b0d8133e90f6888ef2b56cbc46ee57.1665297058.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: MR1P264CA0203.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|SJ0PR10MB4672:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe6346a-4150-437f-8b73-08daaaba51de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9uaJsMzDo1O40El2D/U8OlHMcb9n4d5Mgvwl469RBxcKvDwo/1a2soG2G85BC67o0cFpIq3pRoE8f8rBds/XgpM8QRTDP0rHaEqsNKr05lhXVfV0B1LitrKFYv8q4bzUUXVLTdLpf5aOQgs3fDrxIIhsZdc4udt624QFpDGYE9HKPMEMUTCaX7I9MexsRyOH7pegajeUQ+0f8NKhbexLHeozV/6DqzpCsaOaiSxhcADhR8XHxn2alSdYHaKHYN9HfjlZfu0OFTotunFbXMXsc/yTcUkzd7eS6Epv/lGnkLg6m3317RtbZD73v0pCLL/sHejAV3iU1JRYiE8slnZ0o7ytUoaTfRnkAiCwCe5QYqJWcdkku831sGmhg76DCWXqcpmnp+pbih+dXyxtgcJFaca2GbYaEcYDWQofRFS71ObRX3vra2zOWydM2quYouh4FN2tj4zYHmF/eDBhQ24iPX3QHTmax2pYCdc57Xb8fQ7T+nxdB5sCgaQdg6FiI/DSdQjpVcUFsFA7wh+Co7Q+j4wBCWvCX+ppVqz9YZMjE6xJMK8kv7PQydiIcKX7S3JsF8HTy1+1xubs4UgIR/FnLmREiXTmDPpCZK3JbSje3vRpj2/aVa0Tli0QDqoWBRSuZr0343AwpiUEfYYqmMybEbeyfhvQR6Q3TBKC3YJ5rTyuNUfZce6BMGd4Cjl5j0gcncrywdhN8eAzyrWMkUEMg4eVhIyrWMV8+p6F0b0bsTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199015)(6486002)(6916009)(316002)(4326008)(66946007)(8676002)(38100700002)(66556008)(186003)(66476007)(9686003)(6666004)(478600001)(6512007)(6506007)(26005)(83380400001)(33716001)(966005)(54906003)(86362001)(8936002)(5660300002)(7416002)(41300700001)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?85LtEWQXPvmLZrv2NhLlzuKHr0anoQtnn5c3PNwP8A2jW19Oi28mQY1FXzYp?=
 =?us-ascii?Q?ksJnvMcmOWs5j/xTYjFCg9vWSUb4Jb4PQGazgCHcXLpc1zZcAQqukj01sMZ8?=
 =?us-ascii?Q?iMZ5pMA7rziHr3uiA/eLTOxsEZQpW+kO2guEY5TlBDURjCHDUTAJdGuGfBhQ?=
 =?us-ascii?Q?ZE1/eiolo99esCDAu+bk7SjzoEcIPNzNB6MbxgdI5ZWuA2Zd369Zicq5JYHQ?=
 =?us-ascii?Q?wSJSlo2+iNvjhEGrHRhIi0oLqS5N28DmuTLzg0R1w7k4i+jMm+O7d+e2AoJT?=
 =?us-ascii?Q?sqOXcQwBYHRe25mN4tKlUIfGg5RnNMCc9H6hvKFo+k9Eq7WtceaVDNqpm4Nn?=
 =?us-ascii?Q?SKDFNYE94TZkqk9u0aIDfmceD7QYnjffefrRYDuy0cONWtwuzUx2DPSGPtPL?=
 =?us-ascii?Q?rREKVMt1q5ZrVaSiUehiLEYLgiJJySPFjB8i9C0eDSbkwzzxqUQnm+eJ46B4?=
 =?us-ascii?Q?KPYw4+8HfhIeRH7gwgtZ9KEQIKApBHDzUWLsPWLM+vv9elCxSIvhW+KmVO+o?=
 =?us-ascii?Q?4grWeeH3ZH4ZBmW0l+CEZHGesKRNYqneLI0rZVIhMf6kZ5kc8ZFmbTfzYubv?=
 =?us-ascii?Q?4OBGGYIybnyq9XlaO+e4NK5rs+YP/N7xI3ltInPga8g6PFXdzp+MIeDPCkiy?=
 =?us-ascii?Q?TRzAvxdY221B4l7K+pfs7uiEzEBdDWCv29I4UGq/McuYTuiLEe680fHWDmzK?=
 =?us-ascii?Q?FRQRirlYWlr85smrktxnCaj5Gg8/R4talG57PQe3ZTh9TGLtX9XRo9KkgKSE?=
 =?us-ascii?Q?grTwsH3M7gW/E6Ij+FoIQdzVUTR8QFKpsQhi7WNVlOdA7sJTxj+Z7nX3Iq5Y?=
 =?us-ascii?Q?Df4WYQacCwgclkzGxAGYUsqhm8AzI1utnaWd2eDp9k6y0A6G0NiAx9klI58P?=
 =?us-ascii?Q?YdJuIOwKjhsLe20/SPX7xnhhCyKnfC+MaLPWwRZjS241+iANigttPanIRA6L?=
 =?us-ascii?Q?vajDqLpr0z/7LIBrASGm17rtGDXD6T78Hrq4K0q+RW1jD13LVyDx1R4/Tarq?=
 =?us-ascii?Q?tpHVpE7/owZ3nmX6D1dIgVYBMnbQvcxY6dCF1lIVTJKgsAhNS9Va63XoIdBT?=
 =?us-ascii?Q?kUZgybHS1P+SUp+140t8BEUnRVx0Ba6853bYX0szB+Sbhd/GA+6VtA71W/Ma?=
 =?us-ascii?Q?vH5h3toTIQYnGGPyVT3LNmBA9JdXmhAd+CFUkt3JnSN8aXxX7QYAE0Ikwnnf?=
 =?us-ascii?Q?Ns5C1d+RJcv0nLcVrB9tBff40ESgDTLvn8s3qnO7HjijOeJIzaPghWpvZ0yP?=
 =?us-ascii?Q?vJMmwIUNCBLFhvmqe9eiCArYfznuwpHDjeusIruUtaP59RDk8WUXljMxFJv0?=
 =?us-ascii?Q?j5sYkKD8CzL8XFwqVSsXF9Z9W9G1KuD0Mq7zTblGHMTtbdpMcqUwpdtFGFN2?=
 =?us-ascii?Q?EII8voaZMFMd7GfW1o8OHaDWh8OgtuCM5B16v9JkOg34Dwjr6DqYHXijAzIC?=
 =?us-ascii?Q?dbGf2w3AJ1WoV0TNhmlqkG2B2WNEbVMbo3zir/wMe1Z9Ik4ve1jMLGLdQahg?=
 =?us-ascii?Q?8HuLaGim2NZq4DuOGUzhAJBpCBxSSpQipRf0l4CSzCycmlZ+KGX3G0m6MikN?=
 =?us-ascii?Q?fQLJyn6hOzo0o1oWfIiDje0jRZ3dZPrnnw0Uc3mfy7mXsh8mmp1apCv1aBOO?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe6346a-4150-437f-8b73-08daaaba51de
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 12:24:04.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ib68sEptP8GFFTUIV0Rxbycw6LmV45GBwjLnS/t5KXD3UzsMMfY6wC7Xg7fgoFhQ7cLeFdfzIpu0m7KQN8M5ihKqoWrHOVLKbPYoLMjo1vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_06,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100075
X-Proofpoint-GUID: n0HykGdsxSKSkmPaooaL_MPMo1lEfiE0
X-Proofpoint-ORIG-GUID: n0HykGdsxSKSkmPaooaL_MPMo1lEfiE0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 08:31:24AM +0200, Christophe JAILLET wrote:
> In all paths that end to "out_release_resources_and_disable", neither
> pci_alloc_irq_vectors() nor request_irq() have been called yet. So, there
> is no point in calling pvscsi_shutdown_intr() which undoes these calls.
> 
> Remove this erroneous call.
> 
> This should fix the bug report in [1].
> 
> [1]: https://lore.kernel.org/all/CAMhUBjnDdk7_bBzqgFhZ=xf-obJYMbsJf10wC_bsUeTzxXLK6A@mail.gmail.com/
> 
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Fixes: 02f425f811ce ("scsi: vmw_pscsi: Rearrange code to avoid multiple calls to free_irq during unload")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The Fixes: tag is maybe not optimal, the issue was there even before.
> But I think that this commit reference should help in case of backport
> (and it makes git-mail add Dan automagically in copy :) )

What a wonderful privilege it is to be CC'd on this...  #LOL

It's still not right...  The pvscsi_shutdown_intr() function undoes
pci_alloc_irq_vectors() and request_irq().  Those things need to be
done separately because they can fail separately.

The error handling in this function is not written in mirror order
format so that's part of the complication.  There isn't any reason
for the weird out_release_resources_and_disable label if we just did
the error handling in mirror format.

1) Move the scsi_host_put() so it mirrors the order how the host is
   allocated.
2) Split the pvscsi_shutdown_intr() function into free_irq() and
   pci_free_irq_vectors().
3) Do the ll_adapter_reset() after freeing the IRQs.  The reset is just
   writing to some registers.  It doesn't require any complicated
   resources to work.  Which is good because it sometimes happens before
   those resources were allocated.

This next is not something I changed, but just a comment and explanation,
the pvscsi_release_resources() is a magical free tons of stuff function.
I do not like those kinds of functions because they are prone to bugs and
difficult to read.  However in this case it seems to work so I have not
done anything to it.  If you're wondering where the pci_iomap() gets
unmapped it happens inside the pvscsi_release_resources() function.

I know it sucks to re-write patches.  If you want I can send this or if
you want you can send this with a Co-developed-by tag or whatever...  (I
don't really care).

regards,
dan carpenter

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index f88ecdb93a8a..f495c24fdeac 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -1396,7 +1396,7 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (i == DEVICE_COUNT_RESOURCE) {
 		printk(KERN_ERR
 		       "vmw_pvscsi: adapter has no suitable MMIO region\n");
-		goto out_release_resources_and_disable;
+		goto out_release_resources;
 	}
 
 	adapter->mmioBase = pci_iomap(pdev, i, PVSCSI_MEM_SPACE_SIZE);
@@ -1405,7 +1405,7 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		printk(KERN_ERR
 		       "vmw_pvscsi: can't iomap for BAR %d memsize %lu\n",
 		       i, PVSCSI_MEM_SPACE_SIZE);
-		goto out_release_resources_and_disable;
+		goto out_release_resources;
 	}
 
 	pci_set_master(pdev);
@@ -1437,7 +1437,7 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	host = scsi_host_alloc(&pvscsi_template, sizeof(struct pvscsi_adapter));
 	if (!host) {
 		printk(KERN_ERR "vmw_pvscsi: failed to allocate host\n");
-		goto out_release_resources_and_disable;
+		goto out_release_resources;
 	}
 
 	/*
@@ -1468,7 +1468,7 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	error = pvscsi_allocate_rings(adapter);
 	if (error) {
 		printk(KERN_ERR "vmw_pvscsi: unable to allocate ring memory\n");
-		goto out_release_resources;
+		goto out_put_host;
 	}
 
 	/*
@@ -1524,14 +1524,14 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (error) {
 		printk(KERN_ERR
 		       "vmw_pvscsi: unable to request IRQ: %d\n", error);
-		goto out_reset_adapter;
+		goto out_free_irq_vectors;
 	}
 
 	error = scsi_add_host(host, &pdev->dev);
 	if (error) {
 		printk(KERN_ERR
 		       "vmw_pvscsi: scsi_add_host failed: %d\n", error);
-		goto out_reset_adapter;
+		goto out_free_irqs;
 	}
 
 	dev_info(&pdev->dev, "VMware PVSCSI rev %d host #%u\n",
@@ -1543,21 +1543,20 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	return 0;
 
+out_free_irqs:
+	free_irq(pci_irq_vector(adapter->dev, 0), adapter);
+out_free_irq_vectors:
+	pci_free_irq_vectors(adapter->dev);
 out_reset_adapter:
 	ll_adapter_reset(adapter);
+out_put_host:
+	scsi_host_put(host);
 out_release_resources:
-	pvscsi_shutdown_intr(adapter);
 	pvscsi_release_resources(adapter);
-	scsi_host_put(host);
 out_disable_device:
 	pci_disable_device(pdev);
 
 	return error;
-
-out_release_resources_and_disable:
-	pvscsi_shutdown_intr(adapter);
-	pvscsi_release_resources(adapter);
-	goto out_disable_device;
 }
 
 static void __pvscsi_shutdown(struct pvscsi_adapter *adapter)
