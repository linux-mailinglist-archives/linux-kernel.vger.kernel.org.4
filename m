Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7147030DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242034AbjEOPCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241803AbjEOPBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:01:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4702D45
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:01:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FDKnhn009559;
        Mon, 15 May 2023 15:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=hBd+qpYudSztnkGhftp/Layyd1dD9srKQ/KAL+5hgx8=;
 b=sGvaNR3g6+inRITefcQEkS/qnzbHqaiWtx2bEKD6ciRqEELKz+Gg/DAW2ZD7naTqgrCZ
 Ys1YH2RDuJlk6saA2ukSs3HGfBtyPGe9EZTlQ6bbDxZKLE3ipGkZ/W4BXRUfKYlz1ntf
 zwXSqAI584aYIMj6ZN4InNWDqnD4dTYGa+kLbtiLu/MkUPXyGY4luWpgZ9yGhI4+kgJi
 rZFVKpgcmTmPaSEsHNwM0Uzntgf7Zg+Q973+lSu8Glme9/lMIjT3XxPOP7MCLu1SbXVA
 oTP95yyiwxveqmZNuUwyQ622cI55G7Hfe0rFDnT6BMXSaGg45Jj9Tyz2YRBGpxkz9ch3 WA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye04px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 15:00:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FDaPOd029441;
        Mon, 15 May 2023 15:00:27 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj102shbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 15:00:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M81YLLifgOs4myRm7zl/Nvr+LgviOM7GYSJ3woDcU1/Utvz1R1fPGU63T3fQCQFaMNvX+nX/Zq4CWN7+P5tMaQ5UozPhacb99Vnf1uwN/3sKNfl7zKUIvLRcrPTe0XCGw5vQveQFNCBsl/UuJfCf9fQOMtthwF0WvHA5L9yivPzm+vfY3S+h+qe2/JAxi2y9TehypXX6WodgbSxDi2LXjzfth9OvSOnPmoP+49ukwsTMGnPGe6+pT5t9+4HqzmVG0LHyfXjsTinw9I0otXy0cziGImJbf75W6UUEt68FQ2SqSSST1QEmp/ve4+ezTUA78MzzhtmMbFa4RkFm5OejIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBd+qpYudSztnkGhftp/Layyd1dD9srKQ/KAL+5hgx8=;
 b=Kj6SsesPACtJeqBzRIU9OuR7OvyKZ5HRa8smNJY15RG1n6LOcjpJ2yxCIKC+Z7ObXahl9d2GKFh3svo2MgXiFKkIumnrlAtcgvYxwqg/L2oylW/Zze+FkRqnVLBmsTAczQarxWmvKhX73BG/0QNUdVFylAohzTObBLX3cWnQISgrtP0tTP02XH7uAp+TVoYLnO6Yi13WDeujwFjbJn9FmO/Cj4sjU2HRgX5i0Y4MX4tkB1Iu5E/sXYBv+EE+uFUopRLu24IYV00vzwONsh3LT3Zkf87dPQBKhoDlRPkGUkJ3dlhthgvWEZOQrP4PwuVlSTWpFzBpHmZmTfcMAD8wsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBd+qpYudSztnkGhftp/Layyd1dD9srKQ/KAL+5hgx8=;
 b=r15HgWgi6QEK9KXn12NGpOKQcpHBu107b0D+Qx9lSls1dTJgcC+Oyb/u8tkwtcMPaYou7zemVbaqMGTHFFXbHn0iMZUgnC+Jk7UG4szAhOpDCyCelBMn31OQeuEBiOZ86qnYywzehJ4d/VrISvXsljJwdfBBCUEebr8OQWM6Y+Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6088.namprd10.prod.outlook.com (2603:10b6:8:8a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18; Mon, 15 May 2023 15:00:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:00:24 +0000
Date:   Mon, 15 May 2023 11:00:22 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 03/10] maple_tree: Remove __must_hold() which does not
 work
Message-ID: <20230515150022.ecplwnx2ca3p3w5s@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-4-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515131757.60035-4-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f87f84-a6c3-48fd-dbaf-08db55551c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: om5UH77a6yBQCxKRJfSsOZBP5VJqZ4f0hRSHj+Ui0IZE2Ja83nuT4Q7KgokwagrCkLWB6wxJNfMBUzRTV+/qCy4hWDlIV4QdnyCGR2twwQ7HJQZv5Y7bYEK3V/1XOlLrxXlrh6be0MI3pveLMaOFIlXEFZQOOLsxL15rD9XuDZDDXHU1kae9rTm0B9bCc/7tcdxy5b/ZXEBFk+RXk0YgK3XbgQ8bW2ywnyt1iwvJj/MMKLFYzTRk/TPyreUoR2ImZAwIQ4nL1EF3xitfieJneZbnPJdOMzDOjrewglkGgGumLz41GMnTqCINXAWPh7VIRgV77VpXP4b1X4ahxHIndZgiX5IpLq4czzKrld5nT/2ibuuKT3KCtcBBWoT8XVvXLin5NBMnP6XI2QruHLyeMD5CjkueRrz2hMnptGaHfYFK6o5AOH06M59FBjzLZ/ofEF2DidrDGP2ZLR/Dxvk/avXZBgjWPLCU5Fh9+Y4V++GoLt+apspZT0fXlNyZdPg2aZEkSF7ebJ5q4/s2NcDou13YxyIRQY5Rhe/BVfD2hQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(33716001)(86362001)(1076003)(966005)(26005)(6486002)(6512007)(478600001)(9686003)(83380400001)(6506007)(38100700002)(186003)(316002)(66476007)(66946007)(6916009)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6EFZUgU2qgeGYuoljvlO9k3tOtpl4ZnpW64DRg9ESq385/H6rCLjkP4zl9KJ?=
 =?us-ascii?Q?AtykNNjcdXZ75vNc5Eiy5/+50BGmH+5ivtO7MHD+1v1W2AegO0uU8wjCJ1GE?=
 =?us-ascii?Q?eGbWzPouJeLZBVhbs+QewuIm4+8vlFfsbM7gO46ohBPIzZCSYU2KCOh6vkqQ?=
 =?us-ascii?Q?2A1otD3+siCeB9+U+X6XAOkqpzEu+2P3qTsKpvVXEgLz7lTiCvChdKEAS9hh?=
 =?us-ascii?Q?9IzKhYu1TH6C158Qqppry7Pgbjwa7ac+tB9/fvTByHp3L2cWYHAX55Z4LSab?=
 =?us-ascii?Q?RZ+KleftNqrs8UZTiiAn+KLkVCRFCY3108TBQwBFz0eCscotOY0923CEPvrR?=
 =?us-ascii?Q?2IGq/gnEXY4kA1mghaPDAUALolrAzQnWTFQWRShVBsP8NdgaKuanPXhCqIjB?=
 =?us-ascii?Q?s29g+eUDjlFPXBY92j6LiIXhJSQR2BCvCtChSivjD57dKPp9Ypjy7+u/mqm9?=
 =?us-ascii?Q?nus25V+xvcGmW9vBn+pMgW+T4ZlJYiu+xfyVQIMWaHFUCljzkO2Njhs3LSB3?=
 =?us-ascii?Q?UymrgZRUG6p2rT/n/PjlbOSVUuhttiievCvo/8dAszMP9+IBO9zZKZM29l1x?=
 =?us-ascii?Q?WknxOM8o3g+9YztLOe171erhl0NDljXFqeG3St9dm9/ePzP6V6Mwyfxbtj+u?=
 =?us-ascii?Q?RNArccMxGvyT/l2vWzaktgCw5nZA/j3DBb1sYgCYzSwcfPDVser9gM5iZeL1?=
 =?us-ascii?Q?IOolB4rApVR7fNRWWC8wwca4nfsYoVxVv2bWOQMOhILDiY0hZTgsP/5KYSvp?=
 =?us-ascii?Q?7k19yfuCiXmlDXioEkafFc2CxnffsaE3MqZRPgRpXx8qq/MMwlUdfh/XTZLl?=
 =?us-ascii?Q?S8iSUmGmbzCWe3vOSeOjgplgKbmxTOow3tT4+eCeKvF+mVDvvtA8MiKFXyyC?=
 =?us-ascii?Q?9QIkDz48XynG4ajLe3s+n6hXVTG9t7+JVcSmCiREYBtcyNoXruUkpytxpd9X?=
 =?us-ascii?Q?UCvWF9lA4S4tW2YevuwKSVtC0V0W70t3/G6Z3BNp7sE78mbEuuDoq9omcgLT?=
 =?us-ascii?Q?PCw4I5WITz4zIOcL2v2tasU0yLmzermMyTED3WL9y1d2vMDCF12DlqnoI4Tl?=
 =?us-ascii?Q?ofdPzF6ygHrWiau8mcoApCtuYnNvBDygHrlgIgiJNsVurFshKCHAYr9jxtkl?=
 =?us-ascii?Q?B3D/FKow6Wrsl3lS324AGofxOqRf+hbOZ0iZcxWvesQiISzqOAjsaFfLnzpN?=
 =?us-ascii?Q?a5d7CYQ/c/jsuICsEmJqkcus1LEkiAbYBRL8FBSwlILryIYpx7sYJy++Vwqe?=
 =?us-ascii?Q?4ZwfJfraE0rjhKZbsjNdNyWppcKGZd4WIpHMeGUwYoo3ISc/qoAy0NFsUCkv?=
 =?us-ascii?Q?ezVse1G+q6tiRaPqtTwrRAQ9rTHkltuPanryYOAguuwMUpMR0nRDHauzR8l5?=
 =?us-ascii?Q?F7h3/JSALdBuMIq7lIlcnebMQKpXAwv29KEYZyFEOvw5ncgzK8m1HAlsXsCW?=
 =?us-ascii?Q?KctPR6OYYonqvcdNodqEtCoe8lvrn0i+fDqICdn6/szBXek8HbHHPFvQfZ5T?=
 =?us-ascii?Q?bLQliHLPeZ/yYVoJqLviv6z/PocExAtxDtFzGx9gbWPmM0tXBBdUKPSeuqYp?=
 =?us-ascii?Q?ZzMX2Yrso9hGlb2GpZoXii0OddcEYxNQVyxVmEACTACfJr5hk1+koDq1IqZk?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CL7xxMcsMAMw7Kreg21RGxxaQkX7EHfaSF3HNMPjtf2gxOSyayjeYBb6fXde?=
 =?us-ascii?Q?qKA2InFs0EFhbu009Jh+f4QhK59kUZsh2xsR3Eamk/HtXvgZvt5kId8jNvtw?=
 =?us-ascii?Q?FN7GvR+G1FTrcgcHwtLStj5tl5A6NetnzkFD/v5ujz2hI4Ux5rKhk5ysgN5P?=
 =?us-ascii?Q?12rl1hC1v1L5BhiAK6z5UWlY5FEFZ3AgWlfKPUeCN68riIfdCG6V7/g1EhHJ?=
 =?us-ascii?Q?8IfS+scCTIBRD4lhYK+jun0ZpvXTypyRLonBxX6LYTbCJ24CZgO5iRQ8kA9C?=
 =?us-ascii?Q?/I6Yz8nWnO6fshuH1zqMnTdjccVBpaB4EeQtPWrjcI0jEoet/mXpiwMMq/GA?=
 =?us-ascii?Q?2shnPUJwP3eREXWlM8kHhvQhT6l/pQ8Kfewl/blHUOkkQIkSXp3fl6kl4FnV?=
 =?us-ascii?Q?Dz77Vq6RVXP/DpBIMK+ncCD91k/8mB7QTfSXuEBYPbxQIuWZS6PlzPIxKgCo?=
 =?us-ascii?Q?jvmECdiCl7w+/MpxZSEbRXuCLBprfbzD3gcPVq7obBjFJUVGTIO4SbMqsc9Z?=
 =?us-ascii?Q?a9xg+7zmqCk7O/HkJ5j8qpomifpuERXN8dtZPlpv+/BDzqlDMhXqVJRHbyt/?=
 =?us-ascii?Q?Dl7wJNO0e7egRY6K+llA1WWNuHKbLjZfiPs20vUup2P39un3E1VEzg7GB3QB?=
 =?us-ascii?Q?zJo2+/nBgHByKXgLWMsjYSk7mZohyGRXGQWGuJBS493PVTkHYv1JlyJVpsZ0?=
 =?us-ascii?Q?E8gPxJHVQfrjPJNjy/GpHfcnDiKxFeVyxcPIuFpN1Cm81HY7iEWd4ThskPxv?=
 =?us-ascii?Q?93lDZ2Xo082+iWFCkCIFfZQmOsXHi0xxPWoAYoDTO4pMyGmZm5gvEu35N0H/?=
 =?us-ascii?Q?YHE7XkKR2YEY2Q5rG9a9BZVPSc4wq+qhRpAoR4iSVGBQTOlgY+TDb//DSZTm?=
 =?us-ascii?Q?FKcJPpL93KqN0QDy5NgZEcp7DYUrHw4DaGQPV6jHC+CFyd7pJyDnpeowX5sD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f87f84-a6c3-48fd-dbaf-08db55551c9b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:00:24.5034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuzYrtiLxHKnkJM0fork2wIHUq438QpTbCaMw2K/iEtwHrB84TPmAsdQeSCsG85uBYa2ezgWiNI/FJBNKPTD8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150123
X-Proofpoint-ORIG-GUID: sL6Xl4ItC2EVQUWDZgqiQRE9SUHAB3I5
X-Proofpoint-GUID: sL6Xl4ItC2EVQUWDZgqiQRE9SUHAB3I5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
> The arguments to __must_hold() seem to be wrong so they should not work,
> remove them.

This is for spase [1]. I'd like to keep them if they can be made
functional - maybe fix it to mas->tree->ma_lock? 

[1] https://www.kernel.org/doc/html/v6.1/dev-tools/sparse.html#using-sparse-for-lock-checking

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 49dfe81dfa1b6..43a25d3042c1b 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1752,7 +1752,6 @@ static inline void mas_adopt_children(struct ma_state *mas,
>   * leave the node (true) and handle the adoption and free elsewhere.
>   */
>  static inline void mas_replace(struct ma_state *mas, bool advanced)
> -	__must_hold(mas->tree->lock)
>  {
>  	struct maple_node *mn = mas_mn(mas);
>  	struct maple_enode *old_enode;
> @@ -1792,7 +1791,6 @@ static inline void mas_replace(struct ma_state *mas, bool advanced)
>   * @child: the maple state to store the child.
>   */
>  static inline bool mas_new_child(struct ma_state *mas, struct ma_state *child)
> -	__must_hold(mas->tree->lock)
>  {
>  	enum maple_type mt;
>  	unsigned char offset;
> @@ -6198,7 +6196,6 @@ EXPORT_SYMBOL_GPL(mas_erase);
>   * Return: true on allocation, false otherwise.
>   */
>  bool mas_nomem(struct ma_state *mas, gfp_t gfp)
> -	__must_hold(mas->tree->lock)
>  {
>  	if (likely(mas->node != MA_ERROR(-ENOMEM))) {
>  		mas_destroy(mas);
> -- 
> 2.20.1
> 
