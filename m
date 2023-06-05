Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3984722A11
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjFEO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjFEO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:58:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817FC8F;
        Mon,  5 Jun 2023 07:58:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355Bg6CU009521;
        Mon, 5 Jun 2023 14:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=dgGv8QEIdFezBM3kgu0g3lbupUEXEGZUsGBp2SFVS/E=;
 b=ONzrKtbUwEJGvWPKMukJ0iyQM8UowpQQaCMU4g2y4/h0drwojVzdOzltfiJtXNYXx2Cj
 DLrFILK7AM7Gd2FBSEORN0Rx2bLJAIHDKLwujq/LKk9eURXvE5aaCUfHIje/lC/gGJf8
 cXqX7RG8pQbq5nz/TyLPQGoDFSLmMvRxCXB4zcGkOzsWq7/ytdNKCfNgH+pHiToukVFo
 v42hbWPNHOg/RNnzVmspysyfyrndmi/+JFn9kU2PCjE97PCWeNhx2xSgoQ6pIuQGHsV2
 lySpuJzm3qX3l0U1IulPbLaxrTL8hxHo8RVojzGa4d/fS33K8I5t3A/Lbkpfttr2AImu WQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx5ek3ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jun 2023 14:58:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 355E4e1c011374;
        Mon, 5 Jun 2023 14:58:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tjy3err-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jun 2023 14:58:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKoVGJRxjSJMbSYHX/I0BaH4Dvn9vCHyvnuKTECqcnI+tvVtZ/BFl05ANaNcBJxHsuj5XT+/ujy/QYqFbzoE3//4mpqBAxYPpJ93LAtMvdQQziV+l/LXbN7hd3GfFdNqtRqDCotgxIfO1KxpbfrwUygz28XSn7YLJQktyWkW1IB4mvdYd46WT/An/RbNQ0ucL2zbjz7hgvjBi0FHwvHjtcv7RLCckI+va22RBeXwOEn2J83wMdhfwXiX1tDTortjq/fXEuFWh1vhPALJhZBrs7TOcQKRgpAXIuo2fP4BAL42IfWZtyENwJ+xiwlGTC1FIbP49LSysDGtotBOfVXBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgGv8QEIdFezBM3kgu0g3lbupUEXEGZUsGBp2SFVS/E=;
 b=E5sq6gpjx60ECR9R6PfE66Z1Py90sN5QAg4qMrMEiIoZqR7ax+zNKq0fG46n6qmyQxkDY4RL42cQ8J4qXwX0Gkh1K2wYzrkj+t51sYO2jWu8fbAKwdwi3m4MrgQ+5oNwQjvzMM2KCG/46eBVhn/mY5R9x8ZDa2qnjx+GF7tnq3SM94XQBaclP/aSfEFQYkbCWVkKA/1BYSiF24fdqHPR7Wkzwd5gsk6WD5o8Z8pANWshRUfMSst+BlOkdZoIi8ng9Tq7b7MPLnuks6Fe4mft/EKZlJ+FwSzRoiHFbVkJhlky8VPVBQDWvwobbgvFZ+CH/Ig5xZraZ9TM9qGchRcSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgGv8QEIdFezBM3kgu0g3lbupUEXEGZUsGBp2SFVS/E=;
 b=Luls0JBiFoW4zl12+kMslygarjQ3c/EMiMrmz3BALPfEoNO7IPlZZvx0Il9eK3i2HDIjSo49IYovWd1JyjMPlX4FZUQByNnlmVVJcU4/9oQ1BlST7VwGjr0LKFulsmjxbOqyl428y/d+oTtE6dbaV4uhKtCnctMrIo/exeXhlWk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4472.namprd10.prod.outlook.com (2603:10b6:510:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 14:57:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 14:57:59 +0000
Date:   Mon, 5 Jun 2023 10:57:56 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-ID: <20230605145756.6pl2l2hm7obtqxv4@revolver>
References: <20230605131034.3e795180@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605131034.3e795180@canb.auug.org.au>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9bc23c-81f4-4f46-1437-08db65d540ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZe1sXYboRx5efyhDgg74MBKFKgbHzQMjW3O64w7DC47XlN7CaWUMuJYu25yzFCahFz32xvZP/4T0ye4huzywlQbudzxI4ZCxVK56RPIsh7+jCmvcr7DegWCWJX24m00kBufogrNpPb932D51zEO6Yb6YW01QB0oICrj321CTnM31viUyLdQK7ZjGQXb6tDmEJ44axla4Xm131rYL0PSQGGT8Xqx/xw2dHnZcTzGKlwS7+p+GVWOOUB2WRk4GA/ai9AUPdV/VOCKxB0k58uv2ND4y2vH5r++Z7lbl1swRgSe/yQB8sRp4pBpelBzdSjvAHi7Kx1LTt5sMSsOMjjoIcYygbGC+7JCIpOkNI6l9gHdIWLHRnV33KvMQr4eu/rhQh0jaYmftPLGQJ2IOmRgt+40bpK8G4IcPe0cQabs2OTep0QPhb0z1Vl8RwuXjYESqIaSE+sgtvv0M0rIW+Q/N4pDeHZiVnLoeSJYJqe1PJeeFfoumf0HGBXYV1nKC2AGx2ECa6dnwOLoLDNiwfQFZNQRvxa1f++TLzGeOmGZas3GMo9WenmbUjB0yfE91Xkx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(54906003)(478600001)(8936002)(8676002)(4326008)(6916009)(66946007)(66556008)(66476007)(316002)(38100700002)(41300700001)(186003)(83380400001)(6666004)(6486002)(9686003)(6512007)(1076003)(26005)(6506007)(33716001)(86362001)(5660300002)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j22tFMfjswujqUFUf+uXdGFlQH2VtZM5VOgze7ft5pssXWmGdCzlEoWWg7WN?=
 =?us-ascii?Q?y8Bi3+b8QHByuv1ghU9Sb0ZjMEQvQeajdrUR0ooKWDAYgAxBtTlT0YhsId3f?=
 =?us-ascii?Q?8B6BLSV+Y/MRl0+GFiHbU46g0r02paQ9IHelBJ0CPesq7tywdVogW9iVyCbZ?=
 =?us-ascii?Q?Y4fx7H+9mo8/UFbjr325LHe2i0vDQpIQkTatJ2IXOxl/WN7QfH90ggeAlstL?=
 =?us-ascii?Q?/Aqc427gaNcMqVr9lsatb03Lx5PlyBt1NjJbxhfq3AzwEC9sJR4/OSmXJfaR?=
 =?us-ascii?Q?amxkpLIShzWqk88AfiunL8ZqL1K8lYcNw6eGt6d6kEhw75gpBsMAVntMdP9+?=
 =?us-ascii?Q?M9fvmbq/PmgO7Di0vH9H/w1Uxo9VgvYZwNnu9kZzQnjW3sMr0aufLGJQqZrg?=
 =?us-ascii?Q?WjyYgECgkpt+ALK9vwoS09BvPqZGMY8GYYeREJwXeuQNHLuUDcpXUjBOB6to?=
 =?us-ascii?Q?t58N4hKQGwOaXIG6EAPzw/i4aHY8qvh7ZV8cIz4KpcpuqFLUD0ELDmWKG9uq?=
 =?us-ascii?Q?MDQ69Dk7r427MFVMBFOPUpm2UNq1jsjGN3GYjZ0SR7z793yEIf1ue24jtp+L?=
 =?us-ascii?Q?V1ZjgmwdN4/+SOOQj9K1kR901my0azADrLxT/rs8CYd5u24t0SuWzygp0uiC?=
 =?us-ascii?Q?847igVZPp/xCzN0yTXX2Nyt2WR0Y0MuMImEvZDAq/gjR+fzLXwW+26jRE3Vy?=
 =?us-ascii?Q?3dpe3SWktJE9XwYqogVCHU/Mn5gcDp60NgVCgvvA6IO61r5i5H0P4+By9w79?=
 =?us-ascii?Q?9tsX5jRLC8g7ykycCsP9bHodb8YyfUhkCy2l5Samk2LUk6ettWVfmXHBSu7s?=
 =?us-ascii?Q?25W2LsI+a6Ay8JdUsPqgpqZuN0W8a/VGs1u5HUis5SiRm/TJMZ+sy+KuQesd?=
 =?us-ascii?Q?6cjruDVREkAC0T8iiYWbkfeTZTBeJz1kYjEOmJu6z1awkQgXtpteG/S9B6rn?=
 =?us-ascii?Q?waKK+o1hTer3bL1ecwHAcvFcfCH3ewabONbtz5eQglQEULxiUApztvtjIMvy?=
 =?us-ascii?Q?pEcLtbpVKdhnI0zabUHOm3gqLu4xvjLoi7faueXFLrRWDFu3g7h0nYA++HWj?=
 =?us-ascii?Q?Wngea1LC8K9jIMyKUtx7H3v3+qX+JFYWG3ixC9GE8Hk/GBPmPedYZpPcSA+3?=
 =?us-ascii?Q?nYALpLSQV7kD7R2KELRgPOPHr03tZi+hBtZ3cQweMRX0qul7/WQ7oFuQvvp2?=
 =?us-ascii?Q?21LIylt14/L5o1BJtcEKWV7pafWBSgFOWvoMqpZDqdGdPGJfabw4SA5GqXwb?=
 =?us-ascii?Q?O4RgjUj7wunTDrNRMHem5GiL3dqi/gEgkC4aprOSsB/7JU7NJGEhU5IiPwnk?=
 =?us-ascii?Q?hbOrm2dgWijGe220TeIZp3bU8oiBN4Lo5Lw9GRur4Fgs2jyDzLFixqaT02hw?=
 =?us-ascii?Q?JykAAtQIwsghyizJIrQWMbI0wMlXr18rFN8mdpA8vlbFjvMHE91vseKe0Xps?=
 =?us-ascii?Q?Dxrmes4w/9A6N5noi0YRthcMRblt/zdAzOCutAshKnx1Y/hCvvL9ymdGYJl0?=
 =?us-ascii?Q?vp4Ho+4ul1bVHYCpIfbziHIpeQenwOhuP8V3K1pVgC7rIQbNsLjdwr1W6ywA?=
 =?us-ascii?Q?ZC9s52u8mkZSgfraRplbmbsMmDzq3X4hvrDnYYYmbUFaqB6fcelZQGNJ+p9Z?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UQoVGM0uFTEsGfkOMf5UGxiOEG01K8oVVTIuxQHNjBFSN8SY82hbCNi8CoyrqHmbjVqH3f/+j0EeMUKO810tvrs+QWBjJRrojKtizk0v/YijxMQ8OTBGMeSI8wz92DQX7WsPZ+W20/x+kjAtRkDB9xTz2BKS2lJAp5zVYy5w2Wmwabo/nZyU6CYnX56dGhntX7jBWR8RPnjWVeyvs7Od2fukBI+p6AUiGJXdD1twKAV0FmBh7qD0QXhhxqdLgaTZm7Qbp9gksxSGvqUzRDbmYgm6Wb/R821r+SLxDFG3AtNl5/WnXuCAYXeST95ZBqSDh2j5g61HYZigYfPi8ME6PRyZ9TmJSVOfZullo4zV63mLUKmadbP953ee3D/PtIsEUC5M6nvqKXo/MzuLm901XRkA/mbWDtER/kNy78TnTFtl6HWndFWgVgs2H9KeaEQ4idLBYdCCUkMK3Ya5gY2iddauSzEKH7HRHdA3B7JNis0o61pTPm7++cfKnDue0WH8lT1AZHsslXwDlK17denhc5iml2BhbqrdvLvYz2B8dLo+YlitjvgKl+kPMPPR0dXV3v00kOtLQ4h3IG+utRfid6Bs/RAHgdN5q3v35vPpiVl8UPXyx1qDzwJ37sdsM1B+aL0+NdO9poOePSg6KrwrwHto9MKX3RFEeFm6FqgLYvTcfOUb/1aJ1IVpz72CPkmybTiOHG8lRF94TzqRWcpRJ8K4+6/yUlwP9t0iaSMyrX6D99XZskZrlJtHGV73JIsN+4ZyLF+g3KuM+2uGDFnjMV+bEoAloAeNdzgxc72aDj+89+6AYb19UPcjmnnH+Pn2d8zLzA6eUqaNxLwrGRvIQiR7wVqAbuaDmcplI+CIEMo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9bc23c-81f4-4f46-1437-08db65d540ac
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 14:57:59.1666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUpliCyj3rtPJzgBTKm79sUsX3jarPMsk9tmPy7CuW0mquHU+e1ZqV/+N0QaVxua8nxgyMc7APJJpAjpS5rfGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_30,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306050128
X-Proofpoint-ORIG-GUID: JQiHV9yynJHWnp_cMlxL5R5WyyQVGUMj
X-Proofpoint-GUID: JQiHV9yynJHWnp_cMlxL5R5WyyQVGUMj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [230604 23:10]:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> mm/memory.c:1705: warning: Excess function parameter 'mt' description in 'unmap_vmas'
> 
> Introduced by commit
> 
>   c57d0b88196f ("mm: change do_vmi_align_munmap() side tree index")

Thanks, I'll address this in v2.


Regards,
Liam
