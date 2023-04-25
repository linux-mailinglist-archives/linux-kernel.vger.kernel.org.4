Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5A56EE52B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbjDYQBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjDYQBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:01:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD6ECC1F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:01:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFx3Na004508;
        Tue, 25 Apr 2023 16:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=DCuBt1l4MrQXXO7Mxl1bl55trvOilNOXnb97lJpiG+4=;
 b=nErK5hurFCYq7HYGytCPrlf/+FvpBmHjiTSw7jfP+ZZxTHhzUJD7mbHmhU7Ms/1/ugEx
 EPo/HGFwSl7yqU3Tj/wKnVn/Fy6+xz8lEVeBPAXbZy6F03N/Zn+HpKhIgIZnG0q9db0V
 WaUorjRBZJUI5MRkgAjB59Ycv1rIe1xQi5xghBjUouX6+CZ4yE3zdTE36kVKIgK02zhU
 GJ59S2gX5dCHL7aHCCWf33c1a4GW27xQOEzQkRqAK6eIqkZ2izqoQlO3duvV6OBLAnXk
 o8M62GRk/wOWv7uDPbg5T/M8/PXzfkpgnBpC/AVIFXpes91JYtZZfWwmhajcNjwQOj30 kA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460d5sh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:00:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFrTSo013539;
        Tue, 25 Apr 2023 16:00:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616dfbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:00:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sx5DX7S0AakFtam8aIHneEDfCu0oI+CN2Vnpa/jGk+13J0L/NbWRQHvNUHTNTMIy7kYdZXZjS5C0+34bJBlFBcIXF/riz2FXE1gHs86KNnTs+It80he13ioF7FdOw9hRgtL+rc/QLzizdpZ/9cI3zsSfYbf9VIzr0wiaZ2HK4gJ57tUz4vblH9muspiDWt2aqHbZNagudwYHEvEI6LxFLGPRNcMWHlkFw9postq/LzpgOg9OK9i+iMcCH7WRz1ZZ3jV4/VG0o85rRCrfodcDKNhrtTVpSWjLMthau15beTDXc+zPcpCDEmnIdb05qszvln17PoFUTwwdM/FPGx4LvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCuBt1l4MrQXXO7Mxl1bl55trvOilNOXnb97lJpiG+4=;
 b=cJKfqtQLR06i0ZrAIiRgWgvPRMizvM82Fd6mFQw0GJzRdeRSrMweym8s7luUGPWqx9XBjqIDyFzf4wAbYAYmY4r5V8Yd51gpPu8l4QMoRCaWSQzo2LtPov2DgD7/Tie6vLsyREMQkuMPck0udaxEsybdr5N7GMq+LfsXjRfN0hX7W3ePmgTcDCSpBQc0gG7goDDyZQVSIB9eXCsOuzr9m31uR/PJ5Tuc4DijAeJTtgkGpQ7WFSinLrG+nT7HBOuMTQCrzxZrIg5WIgc1Zb3Us1O9tzzzwy0+/o0m75PxUk3xJfwLhU/BYwhU1MDbrdegsWRqH5CBG2JIpWn/P4B01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCuBt1l4MrQXXO7Mxl1bl55trvOilNOXnb97lJpiG+4=;
 b=FMrbkMh0B7/uYf7RbJeYG6efFj3tyEANBXDohQWWBCpRyVVYOhnRRjs00ZauxyCTfLTrW/YDELQ2RovitMW705km802UGYT57sKylGrfX3bRIAHoCQvDSZRQJkwaiFPIRgtgvM9AUaR0QnFroVvvKsXdJxklWfYAOCkb5gfjTm4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6340.namprd10.prod.outlook.com (2603:10b6:510:1cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 16:00:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 16:00:33 +0000
Date:   Tue, 25 Apr 2023 12:00:30 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 2/9] maple_tree: Make maple state reusable after
 mas_empty_area()
Message-ID: <20230425160030.z7hhmcglbpfq2ob2@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
 <20230425110511.11680-3-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425110511.11680-3-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH8PR10MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1a03fb-576c-4c70-b37f-08db45a633b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rsMb6Xq/GsfvJXM2ZwvVl43o6OvEkTApF6R8gmjd8/KXyXOzinIIW6I99kfVixX34DubA1ciM8+motrjGaJtqsw3MBCkFrOEkvlHK/F9zgCltxaU81vLu0+MCdYDY6GydptVbkiwYnpIQnJg8f3tiO0mFe+nT1Xh/8oCKNYyLyFBys61Y9AbtIqAzFVYAjOKZxYLVAYwVPS25KFKU+PunNtiyGsU9tcT+paIDTckc6yXsgN0d5lwDkKV6vAYCgj62ky4I4BU33+5lfW4ly7xFIwnGhEVOuRZjINahzSLHm9oGCQAfj/oc8bIc91UNoiwN9jFPvzZ0QoEQ1dMb2iNLoGEA9cTJBLy9NliUW9aFwqmNjAylYpXYkuisXodO+bM0F23qYb5wISEaUwyQdb/CN9tnZNeLjXe5aWfjORxGrTjp0O4Sl9PGGKgfyp1Bd/MZbIAJg+qSOm1rwZ0kNxrvtXr5OGbmNfOxMBy+aOOE/boApNOHSWjaisNxnHqMvTfvrtz5GK2FRz/SpdJJzj9gjzK4fgPgYcfe/XdhcIV9Vn4mqQglvleB7ctu1SNUk6c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(8676002)(8936002)(478600001)(66476007)(66556008)(6916009)(66946007)(4326008)(316002)(41300700001)(2906002)(38100700002)(5660300002)(86362001)(33716001)(186003)(26005)(6506007)(9686003)(6512007)(1076003)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?836XsvnNaeCSSfLQh9i7e6y8ZNSoWMVXcN6w1WrRy7FjAZ0iQnhax+DMD2Ks?=
 =?us-ascii?Q?9YOgvh+1AI9ZHzvBS9XuHs0EZa4jkNDftGCnV1uGg3jURc8jADqik1ohExuv?=
 =?us-ascii?Q?iHG2jGBbrFxj0LqJ1f2OR1J5yBpHL92iJIOtcmSNp4xkdIU0PD7H57hzN34o?=
 =?us-ascii?Q?4JNM5WwndZkudRWdkRQTWzwyL2Kr/O/U4GbsRV2CU55icp+GmMLpiBkkqoUj?=
 =?us-ascii?Q?RvjO5hdSJ9XCIJyzKntRkgqeutsYOZq1R+B9qVTkx3HdSSLzvBt8AaZSE2EI?=
 =?us-ascii?Q?O0eunqxJSzXKRRMtqyNOcmauIl67FWl2ZpC80IZobgwcBkcma9MyR6c7xkUM?=
 =?us-ascii?Q?M6Ik/xuMFHh1xq5p+aH528bBc3OCSl2QybSXnxJPQaTD0QRM1VNgXVseNCmN?=
 =?us-ascii?Q?tOSug/1UX/Rnkge0jMuArToSzFz1SMWE6VGvSMcJZ42pcg+zjZawUyhQkzC1?=
 =?us-ascii?Q?FxabxAiX67oJiLA3j2a/y8Ye9Pm1f1Y94+irYYikka/EHlqiFCHCqDC+jw1N?=
 =?us-ascii?Q?KILuTZH1XUanFADsa6lrxdGN29SxPvL9axa6SgwJsKl7V2YajHbVBAEq75cX?=
 =?us-ascii?Q?eHWcs9dIo4pgnLnQucDnZcmejgJgbbao0Z10wBX9cKzV0XUmkEN9QI/8NV3Q?=
 =?us-ascii?Q?Z89GxGz516Vj9RWkOZA1XIS3B3Pi75wsDOGV+YsV6ucgGybME50GmIGWjgZS?=
 =?us-ascii?Q?D+CeN70rxfk84d57t7QoT/laTgBIxOa2DbhQIVzqBMiC8olOs0dhItoj/+kZ?=
 =?us-ascii?Q?Oy6JT/SZpNDojAdjJxHk8lJHUuDtJJc3jyuBTqR3y1XfXPRQzBYFAtSLC+kS?=
 =?us-ascii?Q?kHQpn5epj8m91Ni05CIvy3vpu1gKAG1a9jC+kQx3o7efwa+Q4JGwbFm5ymXd?=
 =?us-ascii?Q?VxMnleJM/wmypf+h0QFEY1I77+Em3zW0Jnw8PyNy5zV0ne2XC3SJVcfenPHY?=
 =?us-ascii?Q?YbpngYrYGH9yQCOKCA8Qs+gzxEqE6GJIgUgY/xioSBXqEbsLSJLGJy6YDIfI?=
 =?us-ascii?Q?2mOZjJEwAu2oEgseBmM2+uwBFfmJhQjAarNwm7z0SGnn/xqX5wNU/SCFk38M?=
 =?us-ascii?Q?486IaMm2uqNagTSqMLykQAItsp59bWwathnkYX8qz2P7Q2y2srCx2pUhDUK+?=
 =?us-ascii?Q?oQsKG0YVZ8cBid0Y3YBtw+8cZRu3rGGmGnVoStaoPoYVP7I9gP9FMyOPwmK1?=
 =?us-ascii?Q?6NaMN1AcbaDtbfXShrf9g4OPDkQWSEHzLC143GSr/CFASfAk9mE2QldYXZgn?=
 =?us-ascii?Q?PhXXlbbI3GVnBV9qfCbbz0PB7m0PhzkfeAMUlhpfaul+5yodlEH5k8Qvth0z?=
 =?us-ascii?Q?aUhBD7rAG3e7YHx1CnolPCRfdOkYnYn3gnCicl6eArLmsBN1O4t4cSL3clqw?=
 =?us-ascii?Q?RyNf2oGmFIAu+fybWVFn2cMZ2H+cQ5Fg7Pz+i0kPbFNO6VGUfyA+kNqnQu4k?=
 =?us-ascii?Q?x7Ldz9WWl0JVXg2oY6KfFBwBlVdtTL6NKC2wtdZCrWolPa9KNIGCUdpecKLr?=
 =?us-ascii?Q?FelZlGgnQtftMbun18H1L+fmn5055Im+GJjIp5xfh3jWRPF2VTCMKDeFZMUy?=
 =?us-ascii?Q?Pp00mpHt+NbXZv9eXFRsVXob5OLhLMtBiORBfyTwbuXGwqOeKdRrdl5q71Re?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?d8MLuIkocoZxTmNA+lUCBkxjNERmPiXynN1bGe6giqR0q5qFL4vap1FzliwD?=
 =?us-ascii?Q?100KM78nVxfCJrihAwl3QWTM9ZtnrcGFQHhYBMuyFMVMjTI8AMn5R4jd1lSW?=
 =?us-ascii?Q?uF/iRp25ewl2G/z5UCd3Bi2XFb6BsVxJ5pqp7snhsAOXeFgtMxQrQ/XxbLG8?=
 =?us-ascii?Q?XVUudEqMvX90HHW7rXjdpyG8tFU8C31JguOMse69DvWtlmM1O1iBGtFpfgnI?=
 =?us-ascii?Q?Z17jujIdEstfiUNqXtM0EHA7VXaUEJB8X70sTarMlcN50mypd+6szMlXxkWP?=
 =?us-ascii?Q?532yvmAUfMc4rLRJH0/PN8gxmhpUP+4vFdJOPIRLyMjLFNazX1bc02CkPrxn?=
 =?us-ascii?Q?wHvQPiS1oJXJLhpGJBx27VAaCkZrxFxzGafBtpoAujYcVwbnxoUF3sV/KQPv?=
 =?us-ascii?Q?uoxY8feBwMOpKNcFXTB2SHqmSxUkCMNuVMSO9ivqdaUfcpk9SI1ebhKtMpi+?=
 =?us-ascii?Q?6tX2IWBzoYxFMIc5KfkZSGn0k2roxc88I2C/6luKZDWWiUI938HX/VGMD0Ea?=
 =?us-ascii?Q?i0rtqxBIxd0Xh+AvyqNbxXVTpN2iRS6i8R8GHidrPzWYOeZn7bgmaoouFh7U?=
 =?us-ascii?Q?5/22kWPPyzv8d3lNIL7QrIEKM7Z8o2ukaKehpSh8T8QNW/pgrMdnfrkqT4Tq?=
 =?us-ascii?Q?65e6aYJmnvUPkXa14JqIGBfijmSRl32+AGEwE2zLMa7bVFB1q0GLiOwnVbWF?=
 =?us-ascii?Q?Xb+7jRcBJbmAccppZTlacThZD2DjNSHpnp0JtMJ9xI+0f9LwSwRLSeZgHm7u?=
 =?us-ascii?Q?TQYNmOpfrywqFRQHaHYxZI/1hX8mrJOnolggQYFQzlBPSUpsAVXtrGvREfZ7?=
 =?us-ascii?Q?LWExpGq46E0QR7imwsPoZIkUWF4Cr6/LFNJ7MNl81epvHvSL/iaDJj0U6nE0?=
 =?us-ascii?Q?uFjgpGFoSsnr7NuBbuMvJck7Vg/oWkAmam0l8WbnBFoVZ9wZg/eAmXBqgGQX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1a03fb-576c-4c70-b37f-08db45a633b4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 16:00:33.9236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8W5X9gmHxT45DzF6HsnXNjE/19kaoLH8h6MBB38dAuUkTmI+L869rgOuEJyFsCGaQSu20dsFe1ym7JwU0d3+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6340
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_07,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=803 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250144
X-Proofpoint-GUID: xX-_QfSYBfJ7Rk5e3cOfHd1Xhz0ArXxM
X-Proofpoint-ORIG-GUID: xX-_QfSYBfJ7Rk5e3cOfHd1Xhz0ArXxM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230425 07:05]:
> Make mas->min and mas->max point to a node range instead of a leaf entry
> range. This allows mas to still be usable after mas_empty_area() returns.
> This currently has no user impact because no one use mas after
> mas_empty_area() now.
> 
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 72099b4b32169..aa55c914818a0 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5320,14 +5320,7 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
>  
>  	mt = mte_node_type(mas->node);
>  	pivots = ma_pivots(mas_mn(mas), mt);
> -	if (offset)
> -		mas->min = pivots[offset - 1] + 1;
> -
> -	if (offset < mt_pivots[mt])
> -		mas->max = pivots[offset];
> -
> -	if (mas->index < mas->min)
> -		mas->index = mas->min;
> +	mas->index = max(mas->index, mas_safe_min(mas, pivots, offset));

It is better to have a few extra lines of code than a complex statement
combined into one line.  Things tend to get missed this way.

>  
>  	mas->last = mas->index + size - 1;
>  	return 0;
> -- 
> 2.20.1
> 
