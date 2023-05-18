Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B827B708B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjERWSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjERWSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:18:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE87CE50
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:18:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IIx1VI029786;
        Thu, 18 May 2023 22:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=wdgf0gkw8G8jKrdHzrElNcK9t2uuTzyHqoXtihsBkn8=;
 b=1m1VcLmu5VtfAiVcnuBtcQlnRzsYRjfcKyqZoBQBxiP+cuBEsdBTJwh2HdFufDzHjTIW
 g5xbobwNce4aOfzsNVd4m3xdo8M7VwsSVv8afQ9yTNpBuQZ45VUycOB1HJDTnPMXTwh+
 3Wt6ZGxWyiDjJ1kgmyx3D42IUg2m3gcZBOE3qVI/MF7oxwTQva+e+uCaquIt3Kw06rku
 12oHBCimKrHNul9EqrDq0qOTx2WN8rmvWiUnFSnXiRu6EdgYUFdnibDHf+J7Fq8m8XGK
 WjOGEb5uEefEh5uVTFllbgp3sb2Ak4gpKGQ6icKUIO3Ar51oGr5aywGiezTMHoENYHmo Pg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwpkmf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 22:18:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34ILbDPp033921;
        Thu, 18 May 2023 22:18:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107u7bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 22:18:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mt430/CbxSFzMQQpTrcS+LuAjAfmcLn1wldhx7WZq2J5fXqMmyd7MfoViKMT7vvhHBIYtE1+KuuxwxFF2tnE2O+DO0g/CB2F/ggRXWc7BlcR0lcMCa/O0R8HfCQOv/gxFF1lD3E9yjosO/AQhMaJJav7A/u538bfhiOiDJlnelj0SxZkqVTl4Aeim8uauKBAkVkuG3Y9CRAjN1o8PzuwK81qCGfhDkZ/RZ5TObTiqKwrmbHaBlPsTXcYsvQM0g3dMLbAWuIh9YmuA54uMFoRIK5+Xg9EzL1zrm6o+dUWAIRF8cxJOHNba6KZYuJ4wwHURUZkGj5TWhgEmJDHZYmKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdgf0gkw8G8jKrdHzrElNcK9t2uuTzyHqoXtihsBkn8=;
 b=Yz5eW1lld3TsFehkHIQmeTvcVWmv7jKUWRGQ5KZSfdE0I3DfEJhEhnbZgwj0PoP/+uG5PcmLMVNFbuCWqr/sZYBuz81IkjzKq7q0LNt/ERqpSRtQoLR8k4bg3YZj0nuJ23A45e5pPRAT9PWQ0eFEXSUrRr1KKklU84ZJnXJRRy/nx2gcHh9L26R8KVaGoai1J5HsaHLCAC2pYiVORjhFbgepMrtwu6cQRPJI3EGUfLv5tQ46t2RqlBvJgb76PmAl+Xciryw5HsUqx7r7arWH7g3CJXLc7+DicwXpjex4pr0VOZNv6qJ27/FIsbz0rw6aOXK8no7+B8HmCGb7e6d4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdgf0gkw8G8jKrdHzrElNcK9t2uuTzyHqoXtihsBkn8=;
 b=eTVmmEIkmYNU3Av07JAKdz8KA5w6/FGaRrNyLQWmwOryFf/IQ/Im37CBCXzu8+BeFgQIHgp3dvo3UWWe2ZtEQuNsPrXJCaOLVrXWlSVIpKXJsPezCpPeXGMuu5Tj65Tky+r3EeolriUNOikORZitgsHO2abDCcmwSbc2DdHwe/I=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5300.namprd10.prod.outlook.com (2603:10b6:208:334::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 22:18:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 22:18:10 +0000
Date:   Thu, 18 May 2023 15:18:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     songmuchun@bytedance.com, naoya.horiguchi@nec.com,
        shy828301@gmail.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v1 2/3] hugetlbfs: improve read HWPOISON hugepage
Message-ID: <20230518221808.GC4029@monkey>
References: <20230517160948.811355-1-jiaqiyan@google.com>
 <20230517160948.811355-3-jiaqiyan@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517160948.811355-3-jiaqiyan@google.com>
X-ClientProxiedBy: MW4PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:303:8c::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a6ec242-671e-4fb9-ce80-08db57edc3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tddFqaBaYJU6SytqEpHWPCo5zDdEG4WdVGJBsXQ1h6ulNLn/RLwLMC6AxkyyOtiCFFg9qf6h0zXX0m4f1CWrNTtZPqaWj4gVSMD0IRwD9sAP2CulaPJjWLG4W/gpS9x6F1qvPwWgWm3iOG8nxdArbNhFgscREuctX9Myzn30Tf2nMHkCuZMYSPWoVcNTUOygrTxeALnyQCZhXiMY82GwpB/ADswBbUCvUWv/YmMsc4tGGpB8lY/xgPUMS136EnDPAlQBVn1XzF/vMH3KxUK/rRoUk06cLguMHfsp+88ieba9dE1q+E7scjGs+2Du/iXB0vzvovzWORS+jz5Lz61m3HYllvxBjCtbo3SLsLDYBS9MvitU5LkrMrNK7+R3+E9vh7HcyW74aq3jOQ2aM3d6XkrBBdo9jHM36RcB5HHTeixeiEtSZir50Zpn5wUXDk25akKbc3EOyjk9opnKi64cYgK22n1FaqXuD+JeJZwq1GO9cLdSgOfrtbO2zaGcpK8UYuDhVcaWwVnTPpM5aB79VrDhBnMLZeCIp+8CD8M6XT1NdzNPKJXlyDnzgvGSEYIx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(7416002)(8676002)(44832011)(8936002)(66556008)(66946007)(66476007)(83380400001)(33656002)(2906002)(316002)(6916009)(4326008)(5660300002)(478600001)(41300700001)(86362001)(6486002)(38100700002)(33716001)(26005)(1076003)(6512007)(53546011)(9686003)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DekL4ktPKAWZE9Pzm/24ZVqJogDONldeeY94Ooa4amiKA5ddFD8SajYpqhDD?=
 =?us-ascii?Q?Lee6qI5TVafyQiK/gIaZwi+ZrdzNoOj6tZbjikitfnvwmn/n9W8pU8YqFi8r?=
 =?us-ascii?Q?bG/VfqPUd1Po9liyH1//78V0IAdbDIUX/hJSUH2qxuOjM3WZ+vPq1SiI/5Jq?=
 =?us-ascii?Q?2IYAVUnBMrSr481n4WtbNQ3EYiaYjQqYhOMrApMNp5PNJXW/Yqw4BiADPGKz?=
 =?us-ascii?Q?WcUOmXpUg5S0PF7RoPvrpmgIKvyzgt7Vy0mToNq14qQAb+E/iJqU8VGX15Ig?=
 =?us-ascii?Q?E+2h3TDiof3lm0o/1xjoiRAajiiSv8ZrZHG/l+fnn2h8l7+Jx2cQ50muBJZU?=
 =?us-ascii?Q?tP2ltQQkGDVTaudZtVW3GoblpNlPzabuvi7LHVPqCwG/rvwEgThjCnOhCCtX?=
 =?us-ascii?Q?arOSpBqXBeuR4THoLdxBDFRle5v4Bt22kA6obgPxSiTw8qmzxd96g7yNIUM4?=
 =?us-ascii?Q?R6OLrgLjATiYmy2coWhFAmdS1Z/sLHlX8Oi25Yg/OHIDNyaSMilpPStw/Lz+?=
 =?us-ascii?Q?Tgzk81846kxr4G+YsMNMyk3cqB76I9qZuNtwwyZqEaZO+bSASn+OozF5jB+6?=
 =?us-ascii?Q?ySfKAZ5JvUXZ7ELk4II5yP1lAQojYLNvAxwrzI2z2RGqUJOdQnbdJBv9u+Lu?=
 =?us-ascii?Q?OTK1XWRLVFXlmK45eJMucMUxvOF0Y0QfgtTk4w5mHitvObIU1ojxkNeDWlAB?=
 =?us-ascii?Q?IdPS02I7XCHTpbRBaljmscBC3lvdvtnL2zmEatUkqgNSHNgh0bu1rYiKCcwv?=
 =?us-ascii?Q?m5Ib/PLWSIVogc0Au3vFaWxWt+P+G4VEbjJhIVr6lTTVEcxoMh7op2pmqY2l?=
 =?us-ascii?Q?n1m0AXKU8dJgxzIueDs6GkBQRTKwBrhjEipZkpvqi32C0I6d0TdEcStL+Dm/?=
 =?us-ascii?Q?ormrTdxd63H+dyENsYaiogwHXNPHfEC97Eb0TSHiHlSIPSZZ57IvA7jP+Xho?=
 =?us-ascii?Q?Cpivcyh/xbbz47tKvpQbBxWm4tvxK84CqDFsCrsAjS0htqKZY5tMA0q79Zpu?=
 =?us-ascii?Q?SMya0hRTyD0YmsgaXwYI7HgOTul7VdTblQE9UBOdG6xM3JQMF22rIG1FkXR8?=
 =?us-ascii?Q?aPGYpa75d/HsziITdbqHbt5T1HGweSZD98Xs+PeVlORI5qdJWk1GJ7L7d4FX?=
 =?us-ascii?Q?BWcIjR5fNndXHeyjNhFdXijqd3LrGu6nZKpzgXcp6QAh5MfqvDC3rVdbve9T?=
 =?us-ascii?Q?DIb41kCMMzpf53V07ICbDMZWc/ijf+339Ij+PinCNdcoCqQWZaftI1NBfSUn?=
 =?us-ascii?Q?6IxP9UL6G5vOBFgpMek41NMGXu0Cx1m+xGLAn99uypQDwrzCaCegiAX1Q2Hi?=
 =?us-ascii?Q?4vYHrnAOR7sfD94YiK16tSzjEpUxjgY0zwupepo273ngB7steGgD/AUCWIcg?=
 =?us-ascii?Q?/Y+HFcG0nEJjS9h1boHaOKVt0r0c2HRJxXJtBgVw14DVtJ/FFQmPTQuAFrYX?=
 =?us-ascii?Q?R6LHzRBZoXucOMADLpdgFStUrtWGwMXXKELtJoVbfX441KpRNsFeJPibdvqa?=
 =?us-ascii?Q?dY2J2wOXaZDlNzS8zhUaFag0TqgKEHvqO+int21EZOEHvPka2dg4DmmKqB5m?=
 =?us-ascii?Q?aiYbXSVKL0QnkTqP28z9TM46Y5HVimN47v7LYlxT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?w/8QVIwDc+yiCKzVXGD9NAFlWHsxCfBHllxCCGca26oHVcRfHFBq6TSx/eRn?=
 =?us-ascii?Q?M7UIFlRUn/bBK2uGNoCzgnUv5GXj2yHttAKPxlEBoUPoLc2lm4sXitv0/YJH?=
 =?us-ascii?Q?T/yaagocd95mtWOJi2j7N1pZMjz1Kb093SC5myEctyDBds9sW7c1q1EscSw6?=
 =?us-ascii?Q?DgWPN0epOvqN0Z1iotyOHn22bGAFwnNIXEkXrjoNlBQGwD++V4u2/yluSUxR?=
 =?us-ascii?Q?6hU44fyMTKVfjmNP8dHpzz9PMpCszeAd55qMSiilF1kUPlr9rBcYxgsa9d+/?=
 =?us-ascii?Q?bLUN8aQtlm7ULrr9ZajRXD4eO7qcFouN+WnykxnsqyOJ+TM2xGx6JGEwkNzs?=
 =?us-ascii?Q?tbQWO5WrCPfdPjdkbd8KPk5H+ahLi3qBKpGXri7hesdOWOfEWsb3lvAALWRI?=
 =?us-ascii?Q?yVN1OWGyVaYrssQhGELtpu3Xci7JAiBGy+CHfuZnspZma3v67kKymu4SNYd2?=
 =?us-ascii?Q?OB/oBNghJqxKL9+SQVawXMyLC/qcBXskPxeHdy0ClaUvE6qyMP5P45Jfpc7C?=
 =?us-ascii?Q?G4R8xARgcX05gkP1rPgm2q9E5lkDsHeYoY3Rnd3XOKTyyXFr6ZVnib/aMsrd?=
 =?us-ascii?Q?9HxB8ANraTcREhizTxCA6xrND6fUSlgIoVzd9hEQqnDC+iv2G/h9E/yXW0Xr?=
 =?us-ascii?Q?nyR7ITmw/0HX4N0UKJPTQvjJOtCU1zIVWD0pEJYgkqNQOkIyf+bWCZ/0LN1Q?=
 =?us-ascii?Q?5Iime5KURZDwKHWSnJo5ABOfdpw1ug3fMDfyO16UljErLsJyGf5hD579kLvK?=
 =?us-ascii?Q?h2hDe2pNB70STA+kVojW+KWq9SIgNCnQR2VHUUXbfz+dFEw4010Wp1sDyytT?=
 =?us-ascii?Q?8F/WmGJ26cjVn4pgvlq7DbizgTkzcqs/nfFq2yPl626zYekaV0iQle2JbbAD?=
 =?us-ascii?Q?nG9BASwbx07ctgISQ2wvpM0y4/SWP4Hj+pnhgjAExeaJPeIrbYdEqkvAvvR7?=
 =?us-ascii?Q?ILf+r6iewiDJubwyO8mfnWUwMPaM8Ebo5Zby1pHPrTY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6ec242-671e-4fb9-ce80-08db57edc3ce
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 22:18:10.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pc4IV/fafXq3rg0B0lP5kt9vUsF9ctegrXRWcIPuc9SxKmRIAnS9CowDFnwHDvGbOdMjhFMmXHWYlZPondheYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180184
X-Proofpoint-GUID: d4sM2yBmyMPMvuJaWJy6Cd_ZSZGgV0ma
X-Proofpoint-ORIG-GUID: d4sM2yBmyMPMvuJaWJy6Cd_ZSZGgV0ma
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/23 16:09, Jiaqi Yan wrote:
> When a hugepage contains HWPOISON pages, read() fails to read any byte
> of the hugepage and returns -EIO, although many bytes in the HWPOISON
> hugepage are readable.
> 
> Improve this by allowing hugetlbfs_read_iter returns as many bytes as
> possible. For a requested range [offset, offset + len) that contains
> HWPOISON page, return [offset, first HWPOISON page addr); the next read
> attempt will fail and return -EIO.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  fs/hugetlbfs/inode.c | 62 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 56 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index ecfdfb2529a3..1baa08ec679f 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -282,6 +282,46 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  }
>  #endif
>  
> +/*
> + * Someone wants to read @bytes from a HWPOISON hugetlb @page from @offset.
> + * Returns the maximum number of bytes one can read without touching the 1st raw
> + * HWPOISON subpage.
> + *
> + * The implementation borrows the iteration logic from copy_page_to_iter*.
> + */
> +static size_t adjust_range_hwpoison(struct page *page, size_t offset, size_t bytes)
> +{
> +	size_t n = 0;
> +	size_t res = 0;
> +	struct folio *folio = page_folio(page);
> +
> +	folio_lock(folio);

What is the reason for taking folio_lock?

> +
> +	/* First subpage to start the loop. */
> +	page += offset / PAGE_SIZE;
> +	offset %= PAGE_SIZE;
> +	while (1) {
> +		if (find_raw_hwp_page(folio, page) != NULL)
> +			break;
> +
> +		/* Safe to read n bytes without touching HWPOISON subpage. */
> +		n = min(bytes, (size_t)PAGE_SIZE - offset);
> +		res += n;
> +		bytes -= n;
> +		if (!bytes || !n)
> +			break;
> +		offset += n;
> +		if (offset == PAGE_SIZE) {
> +			page++;
> +			offset = 0;
> +		}
> +	}
> +
> +	folio_unlock(folio);
> +
> +	return res;
> +}
> +
>  /*
>   * Support for read() - Find the page attached to f_mapping and copy out the
>   * data. This provides functionality similar to filemap_read().
> @@ -300,7 +340,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  
>  	while (iov_iter_count(to)) {
>  		struct page *page;
> -		size_t nr, copied;
> +		size_t nr, copied, want;
>  
>  		/* nr is the maximum number of bytes to copy from this page */
>  		nr = huge_page_size(h);
> @@ -328,16 +368,26 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		} else {
>  			unlock_page(page);
>  
> -			if (PageHWPoison(page)) {
> -				put_page(page);
> -				retval = -EIO;
> -				break;
> +			if (!PageHWPoison(page))
> +				want = nr;
> +			else {
> +				/*
> +				 * Adjust how many bytes safe to read without
> +				 * touching the 1st raw HWPOISON subpage after
> +				 * offset.
> +				 */
> +				want = adjust_range_hwpoison(page, offset, nr);
> +				if (want == 0) {
> +					put_page(page);
> +					retval = -EIO;
> +					break;
> +				}
>  			}
>  
>  			/*
>  			 * We have the page, copy it to user space buffer.
>  			 */
> -			copied = copy_page_to_iter(page, offset, nr, to);
> +			copied = copy_page_to_iter(page, offset, want, to);
>  			put_page(page);
>  		}
>  		offset += copied;
> -- 
> 2.40.1.606.ga4b1b128d6-goog
> 

Code looks fine, just wondering about that folio_lock.
-- 
Mike Kravetz
