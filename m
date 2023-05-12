Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D821700EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbjELSVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbjELSVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:21:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557E42107
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:21:18 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF49ur010131;
        Fri, 12 May 2023 18:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=IbTSmdyb2l0AxI/fykNQrwHeQXPrfhWT/toCcPlgTno=;
 b=QAOdXg37f4GBTgiAeSVKP6cEwbjesNzy7udfNzTbeH4PcSS0i3a6VbilAZDCTPGtrTO2
 C7QCSvGU7cRszMOgUi0EfWaGyqN/mdGm2WJgR42ywl3GH2Zjl8q6mIiWllKowPrMxOzJ
 HUVY8L/umM7CKPo+djQDmv5/Sdqhd4Z0wTPf0NEWtbR3ME7/2jcWujZwBF/S9c2s+s/Q
 dsCa5DZQ2NTKcRjS7xR4wq3PoRuVt+WFn71bP/sjSYfcXVowkUhAZsi0+Z1B6CFHci6x
 1uyWDCXAiDWy37DQ78Q2EA2swIQLwPIKdYyp+HC5gCmNnPYvG3N0EN+W7yJ08zrXhZgZ +A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf776ubes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CI1u01011967;
        Fri, 12 May 2023 18:21:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8156ycp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNYnTdBr8nzBAhgaBblOifiLrtycQu+WxDM7ZBYPitbzRIuzaaIgzW+ycCpOIoc4Ps4XrjhZnAwxPxA0KU+9TEzfWW8K02N6PUT3xPEr8+Fvzh8twlbrUWEL7wc1VrJn3noJ+TFZmXGflxepgLULeoFM0OPhSbfoIVMOm0nOZqRI4AqPXF/RXpUnCsUL4zziREDBYXGogYmp6+i1yLj0BOePao4lfjUd6StPaQq+94WqWSVeDaL2hfcf2/8iighA6C747YDYgqNmEoL3doZOtijbSLSO7Op0ENPlUKODMF6OMr8ewViMbsCBw0lTd+M/Ah3IrbvUWJmalSx8b/x6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbTSmdyb2l0AxI/fykNQrwHeQXPrfhWT/toCcPlgTno=;
 b=YU5noCsCKFYBEO3gm0uLuAVn7Rpy9B/dV5Irg1fGniR1k3uIjP3JQvy8ODu8b8wZvw29XizxxEPfZucbz7wEMZGPnHtRJxR1Vrxjg8VGX6xT6rD2HSdeuTrUKRTtgGq7XwGwTLWbzfb/JkUox1ilaEDZ76UUE5CRXboIxq41UvdH2ICIX280UV02JvH/HwwyxT7z52TEkkViV972sYdgvxSBX0neh/J9E0Q1ilnYyK/Rhf1O8CQFCX2KPQZKfkcT0UyuBR4u+na7rqwL513yhLIrqkDdfkrZyaUjj3mkZuQONyQsWyIa9b7rH1eEMQJmeKzxYL4yQoY0xAuZOVpRYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbTSmdyb2l0AxI/fykNQrwHeQXPrfhWT/toCcPlgTno=;
 b=PrUcnbI+DB9qiYhykSvKmHdkmaRaLTBrlVsOFQ3jyFZA9oyD5jvQ/s95p9KtOLoTuYSpqzHrX7KEvIqyhwu9aIaRe3ewvsRhhtCYesIYjCEhP2qo0D9kJZIZoURlCRkNscqVnyFI6js12u3rWNm923c7JBBP42X5oEgfiqe5Euc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 12 May
 2023 18:21:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:08 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 07/35] maple_tree: Convert BUG_ON() to MT_BUG_ON()
Date:   Fri, 12 May 2023 14:20:08 -0400
Message-Id: <20230512182036.359030-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0054.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: a11e5227-4c75-4db0-4d1a-08db5315a7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svDDzUviA9jiD4YRSMP2vgvOJOo3L4uxxS+LAQuzZRVJKQdaRcCeiJ+Gkol7fpoS6GKgWF6ynbHZooiQ0a6aiW2itB7SPLPq5wy1/fTgeVcgCS3+bJ54k27SG50RZn3nwi+CI3gxhlvHu8oBLIOGFzNmCYSJhsdxi+UPrUD+ROkA0Zr3hJ1YuJmSph/WH+C3A5TzyUksyx5FPAmI3QnIKS4AEOBb1eniqJbhuyuJMq53kOyvovx5060MRmnroRk9xhZlhzWMpdASeGsTP9c+myZA5p7gI1IgnQJ1Xp6Fm0DKEl2v7t0/NF87cspsvP8P+zRoJ2fISoxU3QWydJwVKRc4dUa5r+pOu42XDNknFMRdua9M7/1AgrDQuFnKXPhQXog7tK1VCyq4wxI58e3PMe+N3WCJjAEtP7IzzuHBsoBEmwoOTzgDb1O+36kbI8/2M7LkIloh1BKhVepx7oD5YO7rnb0vSAnxFmGuVAqVnizbhh00+jnn2XcTnRgNG3XwjLNl9ThTleHYeHleo0XhlzzN97p8/KTmGiJqYn+V3PeyZWLwtL66i06sY7XKkUDA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(4744005)(2906002)(6486002)(66946007)(41300700001)(316002)(66556008)(8676002)(5660300002)(36756003)(4326008)(8936002)(66476007)(6916009)(107886003)(54906003)(1076003)(86362001)(26005)(6512007)(186003)(83380400001)(6506007)(2616005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0zLqa9tFZz6hMEsqdkIfTvkRph2UfU+WrTTzLfenE23/hHmwelNFZKmustua?=
 =?us-ascii?Q?wljhTTbb9Kq37l+zLrAEYHCrDblsIhWWwts73OluyzjKiRif2p+N3w/RA1qo?=
 =?us-ascii?Q?T/6Dpxx5xZJed/Iwku6FHs7ml8QCgnSvCKBd569hLbrIg+XggGCseDtPmbcn?=
 =?us-ascii?Q?ED039h17JKWyMqhG79ZCY75fLdwCA2de3+C2Ur2/r57gKRovyaf4J1VXzv8I?=
 =?us-ascii?Q?8Y/oTRC5PhfdjCjJUsaRsTINcKFSl89TLbC02KFU6bkv1AEl6J6SkyhZWzCM?=
 =?us-ascii?Q?iGUAFOlckk+zgVkEyS4rTSlRAJWjtz0HGDTelFxS145zMs2zGvj1qVXi/yPa?=
 =?us-ascii?Q?LFWaFOUoJhausUVyw4m5+WjiUR3FqXf5k5jGygyjnVta2iQIsTFqXTIpTXks?=
 =?us-ascii?Q?lvZh2zw2lihR3mZbmKF1nB+ta1y25XyjhLRT26AUDns72mHjstrBVpP2cZ6b?=
 =?us-ascii?Q?0aIcKIpRMd4lkaLVNPGIRhBneTUve/hIAo04dtFJ1zja7j8rzQxsMk/AOPwa?=
 =?us-ascii?Q?ennvCt6J0ZBxOHiQ6kejLrz7a3iZqgKWx9x160XgQpd8T7eIHJ47NGUHpIfO?=
 =?us-ascii?Q?wZ8i3o3JRH0gbTJt9nv6lV6WBz9aXOvFS++U/+tjEIVwL8YyGz0cihqEnha1?=
 =?us-ascii?Q?FspX07WC1f5zjPpRiUWmP1fmKBFZUFeAnsRqdoSSzebAsOFsPQme6Nd2hb7g?=
 =?us-ascii?Q?CvxuWizl/Y+4amL8Gr73iQL/RKgdzdHxwjfqqFh+f/A8Sj6K1aRmUfHbYJ97?=
 =?us-ascii?Q?2UsgLTKPFzeIHy4ZsuQcwZ6f1j3o8ho330csLP+7L/IgGs67y8RvAMdJSUNu?=
 =?us-ascii?Q?8mw7KSuJ/zTgEJlYtYHj0E2Oh5ZCqUPJSoTld+mUPjIeRRYWQerBtvtG6bn/?=
 =?us-ascii?Q?W5JPcv5TV3JLasI9oH23xQGYF0UV9U/56fIDBkXjoFMDcW+Yb9JvqJh0HeJX?=
 =?us-ascii?Q?An9RqtznY2sOFxcbmIXgmIvcvgxaDedJJSCDR3UO4hdObvHCIqqS3QDyUScS?=
 =?us-ascii?Q?Zkif11Hr16qeB+Mgf4qh9tLqls/K3AWFn9FR7HSQpNRBeSqgVwNNYjO5zHKS?=
 =?us-ascii?Q?R/G5K8+O94I0qFzCEG2+fQBOu1x6oKf19FH4yC7m50S8kUL/QNFNhwkoJg1Z?=
 =?us-ascii?Q?7Tgs/zcBIuLIORTGQ4F7TVfjbgXArEOge4YTlJZ1isSePfuHd6RBLr8nXJKS?=
 =?us-ascii?Q?LQEOMVLVSdbDYN0bYMZYdd2QHNsxnAk7ayMgIfIiZUW60JJ0LdNYocV1ceOa?=
 =?us-ascii?Q?6lwgZdmMPX7FTIeAq+APYJfxqosmwJrTV3l6xke/ikrIve6QS7abbYg233oU?=
 =?us-ascii?Q?YT+Hb39cNyALk4kfI8KcR7kVCRgMnfKPky1Az3plN4lgzIo5GtzrFjXo3eQ1?=
 =?us-ascii?Q?e7HSg+IODYQTEJW04b5eLo64IzimbDb1ci3hzU/Hnaxe1Epw2jmjUjFUeHfL?=
 =?us-ascii?Q?bGJFLIMzavFNkNFpriegqDbkt/wrheTPFM4seq/dkjYaxciYnR79xtle5b1d?=
 =?us-ascii?Q?jMi2Sx6VEmpNuiUPJiCb++fC2HdDVgPCtmNCHUwbt+ylC+Zt1xHybrboadCN?=
 =?us-ascii?Q?oOkCH/zr/Q+nLqqWgaFIeGRpYI/3dKCODMKo8El6AdU0sBf6fLrEbhwqpM7U?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TnrjR7/09/HKtUOFvq71srYBPlJyAiSnAJTZTV6VAg/Zy966r881qHDmQDQ1Ra3ZarwMsia4ZuwyYp2gBruvJc2Dqy7EUr02U4LByxsFXzy3biROlOIbF1DQVsVLzGhU/yPhTWJk7RtwsqHrtjKn/SMvy7QLXa5yDQCxjaHN1qFWtjI4/igdRQ4NpZhigRkcW0DgQLqG3TdrT90EupmnmnJjr3asj5t94n6rtrQdP2jS599NxmT5tqguWNVBMdKHOrAD7dKxBwlrWqAcgGfIYHSM3b0bJhKLjwge0IH46uXo28+93m/whXNdTKq13gAPZ3Eb6UGncYaxd/QLnLHrWYmaXTTWsa23zMjSdvNEPunkout6qhuw+rC2a1QK0Ok+Ek3dTzO8AV7WDvHokf8hGmU4c1Q/L5Yp6UkRw0aVHAvd9PzHKKE77mNglwIS568TMart4t980O0PiZ0BPoNsxMO2J/En4NezOrDh4YPCbhTrdNhVjfEq1XezicB18XB3WljiIWnggf1SPgG3Z4wD64DHFH0Wq9r0Wc3fIBrRGuxQQ55FeY1+ACxD7zL1Ibl9IIDgNjpA2gSDMXZw/U1hRphiR3pnfUFz/8gv068zmncE0wn16gSdScsMBTlh1i+Oh9ehgsn2Io5bcQwalY/kAETSHTTmFrkIyVN0UsyDxIx4S6ff1lBT4abpoyL2sMDQvPhzHYEqT5ket2hnrBNKIQWcx/sK9Pm56TE7pz9X65lIgH1Kaxs22ACk4sBE1iuRDo5QbBGfp2T0mXOYOHY6x6OzJuqkHT1Y7MVfwNLhbPO3H6+gW9jf55PrKo/wY++sw/+0CcaP88kXF9Yh0hAUK5Swq32NUDYGoZYqJIJbq9PSluDWT7nbIlXH5CmbgqX4vnzdodOz+oe54AlHUeNz6A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11e5227-4c75-4db0-4d1a-08db5315a7fe
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:08.1807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKrTb7HzdISz1RjpJdixR6StIHEN4lWczQBJDpppVw+zuHkDg4wDohw8+Qlzvh+5RspAw9syWmf4YwKqFUegug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-ORIG-GUID: -cUnafGcZVnpOm6nlQnqMrH-SGJqaIHm
X-Proofpoint-GUID: -cUnafGcZVnpOm6nlQnqMrH-SGJqaIHm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use MT_BUG_ON() to get more information when running with
MAPLE_TREE_DEBUG enabled.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a28b021f740f1..c3ce2bc594123 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -194,7 +194,7 @@ static void mas_set_height(struct ma_state *mas)
 	unsigned int new_flags = mas->tree->ma_flags;
 
 	new_flags &= ~MT_FLAGS_HEIGHT_MASK;
-	BUG_ON(mas->depth > MAPLE_HEIGHT_MAX);
+	MT_BUG_ON(mas->tree, mas->depth > MAPLE_HEIGHT_MAX);
 	new_flags |= mas->depth << MT_FLAGS_HEIGHT_OFFSET;
 	mas->tree->ma_flags = new_flags;
 }
-- 
2.39.2

