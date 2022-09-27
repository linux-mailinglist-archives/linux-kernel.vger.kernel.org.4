Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D9A5EBCAD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiI0IEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiI0IDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:03:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F37B4E8A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:58:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R6OrEt022666;
        Tue, 27 Sep 2022 07:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=UwzAxx0owZltyeqqEaGz/a2cU5Qjs2gxar5Wd6wCWv8=;
 b=TCbHDWis0sK2yMrHtGLDtmF06HAT55/EIWOwVpVPkuOkGZNsdBDnuDCnaI+BDoFG797A
 0sTFAyY4cTUENhr75EhDdmQVZPevOyCFlDTFiT/Q9wFScfuZYLeFNKDTAljgxGpKWmpr
 WMANPl8RVlne9svzIGnNcFfhI7juPKbyI2BAvBF0s+Ue6UIPcmKRkXW9wqTgmhnCZe4l
 a17/uudoq79bal1jc7bJmKqMUAbinqxjtb+OefbcYZYinGUnNthSiu3zyA5wTpRkNoFe
 8FGiooR2+72qjDfcDMYKg8WfAn9KvbhxtfkHJ2MLPUsedQzfV0j/AGOSgKUZ7NDywrDQ rg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsteswwng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 07:57:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28R4xBQY019931;
        Tue, 27 Sep 2022 07:57:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpve0pg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 07:57:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmYJQ8+lYiCprofiMnXJli9S+LMoAIje7YrrHHB+KkWudLSwW2jFhhW4RWWNsxgO/htacLz3fu/6qQkp69Wn48qIkCOQFSvWHhcI7i+6TlYiSWmJ+Qdf/MzKay+O6J//pezYP3vvwPIxBG3wZRQQ2dUS1uZ26LmcQN04OHGmhPgxWoSBMTSCADxbcia/3qPk+JVdc9FAj5L76B1i0tKYZiWCahAawQ+usTnl7baOlRTrXI0Tuj2jgXq/+Bs0MsZJM+KSLU12zKBFeKieRmzGyy3Ije41Zx47ftdkagZMgGdJQFUH/1AIDdjypGKRuD/knJHj7z2uhqZiCFSMTirDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwzAxx0owZltyeqqEaGz/a2cU5Qjs2gxar5Wd6wCWv8=;
 b=mepAbgKN74KCyM7CuXA1kRQeXYyWxZJvV3l3BwBaidaRqMlSSFDbthDKdmNDGr+mPOkJz6gK94JBfMpeTxRonMlQTUF99+tqipRd3I6vxMdH4tWI4QUW7pXrZb7CI9mqCSF0iopAUmvmgngAWjuEDS9gjVRpOoE9+osoVoBzlkj0DeBDEi3AAQNBNFEiUignXLYfQCv6cLwZhMC3CTN9/WUB3mBYHXr9dy8HAKdmZvr3EsF639phU6CEiAY8McIeFMOc6dHHiFVAU2VSey9tMxOsjj/dnL2SeDBozCQPuDoMtgVZcvblJYeno3SzQ0xvfLNAI96QKPrtl2UhyrRHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwzAxx0owZltyeqqEaGz/a2cU5Qjs2gxar5Wd6wCWv8=;
 b=Lv1aMxST7vEmK1mbU/R716Ggq5bmlEeLLpbBIQKKM+PIRQqiVovRyb3i1RZbA+m+pMbd5orttdagmBbUsdyC0GzuEpkIhLyPpLAoqMTLlpzH4lrSM17Fsluz3tdBFSxkyySPb0BKRT7QAZjZHBFj2bYCc+qs2h8AX0lqKuX9An0=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by PH7PR10MB6154.namprd10.prod.outlook.com
 (2603:10b6:510:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 07:57:48 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::25b8:540b:9e72:ca93]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::25b8:540b:9e72:ca93%3]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 07:57:47 +0000
Date:   Tue, 27 Sep 2022 10:57:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     xkernel.wang@foxmail.com
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: rtl8712: fix potential memory leak in
 _r8712_init_xmit_priv()
Message-ID: <YzKs6BYl4lr9eU35@kadam>
References: <tencent_F11EC221954CFE8F406298A3732539562809@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F11EC221954CFE8F406298A3732539562809@qq.com>
X-ClientProxiedBy: JNXP275CA0011.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::23)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2358:EE_|PH7PR10MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b6ebdc-ada1-45c1-6a9e-08daa05df46f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQzu6r59giVmfGpQAjfGnGk1an4UA3RnZ/Jd7LraGkgmV200w6sJCYtK0ajKIbjmVhaRJOrmbjDI7y029SHkZy1GhoHblZ33KA1bNVKc0bGPdUq3ihMPee56izQIHmWdav2qMlbXP+RuZNny5h24WYlqzCRdXyF75tKLN0mIX/ZRN2g1i9nmg4Iigp/252NAqpERspxnXU9ENCh/W7DPNerBqkac0oWYk/taRvwjRzukfDCEUFonF8S9ex9dstc/E19lIQH674EysFpG/KKIP+/xJWQDJKXfDqBUeZg1g7Rmrnt6ESNwmR9mZ6Jp9X1QCjN/IsVDGBfkJzJ+o33WEz01/BtSMLQWmMKczDwO+NBs+/Kg9ug2+v4wM1Y/nSLig7lMAAS5M5Z97z04MIMAKSfX0Q4tgpldB0+4U/NKcNHZrjtZenIBckFVNkGF9uCVJ2xCbNivxFo/lrTD/U0RAOWWMUBq9a/3PEXyMwEab6g0uWuZcO68Q33stybNVVHF6ItJ7K7qQfjZyF6f1kVXU+mArBbIjmzeGb7tpTDojJKHIhXiE1jtoPGJE4ddV5tmsnRCP0Ch37yG4CAYtjkU0qUl3uNd1wloAyn48xDjTEpZg2YY1giMDR8GKYBsg4W2H8tGcIEdi3u8ej85XdQ9sB00BmyqrZkpmZdOZFkDDGhfjLk5OsfciTtGaBQ5GQPBhpQ07js1PGwvCfOjxUnTGiFF08/y7+HAfuJTem43jgfcoOYwUFGWiPFCjQrVQYsBfj6ooGRAaTCwK9QsHK6WpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(38100700002)(8936002)(41300700001)(186003)(5660300002)(44832011)(316002)(6916009)(86362001)(2906002)(6486002)(478600001)(26005)(9686003)(6506007)(6666004)(6512007)(66556008)(66946007)(33716001)(8676002)(66476007)(4326008)(48020200002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xy/vo5NXFSrmChBJsNFFG6L6jWGEZU7QRGx0MfKV+b5qWoHE/6WXDGCEV/JO?=
 =?us-ascii?Q?/PsZL1uudL7g1P/FBmBZMPA7vkG7NDd/ZdeFDRKRRfRD1mdBoyy/o6b1Da1W?=
 =?us-ascii?Q?LxkAuHGL6tfnVJNChbN8SxuBFNBh2Y1rsNOrN7SmyWCw0xPnqSfhW66k78bL?=
 =?us-ascii?Q?cAFM3a8KzMONi6mUqFFaq4tHU/6UuJ8QtQFBT0VrRibn+Jcug0bBuLExN2C6?=
 =?us-ascii?Q?T4Z9yMYbPbgxq0JMfX7nJXfDW0JYEYqdH18bhNp0x011xACmEtqnHpy9oZqW?=
 =?us-ascii?Q?IGydPlfG3gu+s7xeNeD7dmmVeVrYLZ5dgeradzSCabwBXhZeI4hHmzMovnBg?=
 =?us-ascii?Q?Z8ObVaJce5Cn4Qnep6lE3bRuvgvn71OWtekgI51Qi3tvQ8SGBY+ODu7GFyEV?=
 =?us-ascii?Q?Cj7+irSlstGtwtGW4E9mZX3KGZxpLmU4WHGFsvyIrSWAxNKYupvRjztYUZT+?=
 =?us-ascii?Q?4J1JnRDeBubz65FaSD1RAxJLBNmcTuI1h5w30kmpq8I2tJeM2QMgBZGrATaS?=
 =?us-ascii?Q?nXG0ADqfkyJe8/8EKKMBCTsBWW4+2gusX0uc2OIKMraGd2xfZp8ylnoK0I9M?=
 =?us-ascii?Q?9fSvdeKe775S3icBvyhCdokWC2SdapXYuHzMJJNH8KsDAeaiYDRXfkG7LK7B?=
 =?us-ascii?Q?WqI7+TuCLdAGr+KMty1ZEUfbOUdehGh/2Cgq6B9mjaaFyeRPsKxkW3m6jvYk?=
 =?us-ascii?Q?gRqxIpyEMOVen41eb6mhehgZl/+ApU9w9ESobMwDTV7otIJbP12NnofHyWm8?=
 =?us-ascii?Q?oNH6KNoPoTTyi1bZBf11ZmrGT59tsPpO1on4opVOp+W+yEfG0IsOqi23XSVi?=
 =?us-ascii?Q?zWn+7SKCUhxuRwrE1G3M5An3JX7QMQFdcILkKjdUjIscoW/Q08wNe/4gDIdp?=
 =?us-ascii?Q?p5ooL+nx/l18Mu2rhRucMZRxQJSH7Qjla6nivwFW1BphEQlhaKr3/MOFqmv5?=
 =?us-ascii?Q?JMf2vZS9fu2zH7IUglxjzGmfI64gL+mkNf1HZIj47FIr6EkfjHo+t/tMb7qL?=
 =?us-ascii?Q?+nOxKwwtY7QJYzJtZe9Qzt5ie0zGuYkRltimJ0qlIUxsypdjAblawC7A3ws6?=
 =?us-ascii?Q?8JkH3c/Y6IgYzzq+9q8ZUbnQ1EZjheZNsCl2koJ9DGERSqMEtPbHyp+tuIMk?=
 =?us-ascii?Q?zJYhI0mXXGOWtKoVBzHdA0yBoVS7OhkXCTx2ge1sO769Hr73NWMVtH9cJcCo?=
 =?us-ascii?Q?1B1fUTaSdVQohba4I0kRx65oEFRyXq+hh9dWzXnojt9EUexx65AeyuwiKFjW?=
 =?us-ascii?Q?dXuOPK0PFDvjvD6LccawfOoLt6yFFf7JcXdpNYrfTalj68G4QVXXMx9k/GYJ?=
 =?us-ascii?Q?OKVMmejkGAlK5mwzXZ8Z41ZWQGnZxUjKN24FqeAhw5KQu4xG39gKxn27XhDf?=
 =?us-ascii?Q?bu4SLxto8diEpfq4v6QW4SGZxUzwNedSMtUP3CAQ0Vpj8q0EatzzHZcTsNuL?=
 =?us-ascii?Q?SKH8RR//3OPK9HMxLb3NY3jGzQ7iGCCuuCTG+P2vloMFHnsFfJnH43qM4mr0?=
 =?us-ascii?Q?ckGAxDZqotHKJwMGk1qlM12t4P5S5r8qbFT5r2StiRF+9V90DYNDVly71Hbv?=
 =?us-ascii?Q?wjwBALDZXVLT8vu9I2SohHav4SOL43VrolTa1ufx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b6ebdc-ada1-45c1-6a9e-08daa05df46f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 07:57:47.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoINvrWnXKQIFuM6P+7CbNNT5wMY7Txy4C3gLlsDnntjsHvRkatHbhVex1mUr5WW9dfx3JkLoL4/bI8WedlfyPNQVKi3tlsVPHVV8Z0GPSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=852 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270046
X-Proofpoint-GUID: xQcscyn2HE-emQ3aTYKpUOEDLQk6B0wL
X-Proofpoint-ORIG-GUID: xQcscyn2HE-emQ3aTYKpUOEDLQk6B0wL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 03:06:05PM +0800, xkernel.wang@foxmail.com wrote:
> diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
> index 090345b..dcf3f76 100644
> --- a/drivers/staging/rtl8712/rtl871x_xmit.c
> +++ b/drivers/staging/rtl8712/rtl871x_xmit.c
> @@ -117,11 +117,8 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
>  	_init_queue(&pxmitpriv->pending_xmitbuf_queue);
>  	pxmitpriv->pallocated_xmitbuf =
>  		kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4, GFP_ATOMIC);
> -	if (!pxmitpriv->pallocated_xmitbuf) {
> -		kfree(pxmitpriv->pallocated_frame_buf);
> -		pxmitpriv->pallocated_frame_buf = NULL;
> -		return -ENOMEM;
> -	}
> +	if (!pxmitpriv->pallocated_xmitbuf)
> +		goto free_frame_buf;
>  	pxmitpriv->pxmitbuf = pxmitpriv->pallocated_xmitbuf + 4 -
>  			      ((addr_t)(pxmitpriv->pallocated_xmitbuf) & 3);
>  	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
> @@ -130,12 +127,14 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
>  		pxmitbuf->pallocated_buf =
>  			kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ, GFP_ATOMIC);
>  		if (!pxmitbuf->pallocated_buf)
> -			return -ENOMEM;
> +			goto free_xmitbuf;
>  		pxmitbuf->pbuf = pxmitbuf->pallocated_buf + XMITBUF_ALIGN_SZ -
>  				 ((addr_t) (pxmitbuf->pallocated_buf) &
>  				 (XMITBUF_ALIGN_SZ - 1));
> -		if (r8712_xmit_resource_alloc(padapter, pxmitbuf))
> -			return -ENOMEM;
> +		if (r8712_xmit_resource_alloc(padapter, pxmitbuf)) {
> +			kfree(pxmitbuf->pallocated_buf);
> +			goto free_xmitbuf;
> +		}
>  		list_add_tail(&pxmitbuf->list,
>  				 &(pxmitpriv->free_xmitbuf_queue.queue));


pxmitbuf points to somewhere in the middle of pxmitpriv->pallocated_xmitbuf.
We add it to the list here.

>  		pxmitbuf++;
> @@ -146,6 +145,18 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
>  	init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
>  	tasklet_setup(&pxmitpriv->xmit_tasklet, r8712_xmit_bh);
>  	return 0;
> +
> +free_xmitbuf:
> +	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
> +	while (i--) {
> +		r8712_xmit_resource_free(padapter, pxmitbuf);
> +		kfree(pxmitbuf->pallocated_buf);
> +		pxmitbuf++;
> +	}
> +	kfree(pxmitpriv->pallocated_xmitbuf);

But then we free pxmitpriv->pallocated_xmitbuf here but it the memory
is still on the list.  So that means there will be a use after free
eventually.

regards,
dan carpenter

