Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0833D74B3FE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjGGPTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjGGPTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:19:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A920B2691
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:19:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367FFvtH024835;
        Fri, 7 Jul 2023 15:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=G9lNPmXPLXBvrUrvOQyKgMu5bR7gPLsLFaVnJH/ZzoI=;
 b=CUw/4wdIWkRXfBuYR2YYOty7fN71XgFs1sPBAgJvD4mQ+O6hsfRTdnI784ApvlfLpnnx
 P1ABibLjuVIl6C93m2vjV5YyujYJm3IUYKBgrOtSGJH7H6T8OvYf/F1pEqDfn0YmNRhe
 KHEJh3hPeSZzeHYeJAvVP9Cimr1QJ7NluLOKsq7xVvu2ceQzyiTXQYlhkRx4ToD/9n/z
 kONiQqpVfNkdsgFYCIQzdx/q8ltUX+eIhjgHN0v/fiE7x3buwJWboUp737Ch/wsf9TUP
 Ju3Ccm3AFsIsWsK0DLm/Cs/i81qaArgkmJASD/bZqe71mfaqiWKRJddPxkfo+w4kYF6O Ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpk6ug9sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 15:19:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367DrG9r010253;
        Fri, 7 Jul 2023 15:19:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8j7hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 15:19:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFoLKkZSTUfwcWCldWCLpHxEJ6tM0dWoePt5SlY6nbR/RnUQPeLb6SWAmuGK0QQm23BtD29SVFOoWIdNw1A1NuAkF/8kBvPuUfD4FdMHoJwvRZDiapd8HkikJdwxnUJR2z8MUMuh5zTbWSb/bEH68e2enLgyej9FFDtZRO5iTqmt+O2EZhvp5gEh2amR0jc3mCHSSCTyPmXddTWHUQs42255dos91qCEhv5XuRoV12PHS+UMA+LExL9GPGNK2MVYwleqEYVVC04UWH1CQHTnMslCqTyM62Ur8OMYURbvnngNPUjr+cNLGuUlDOh4fe0BeMffXu0zjEkAfB0LJ0jx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9lNPmXPLXBvrUrvOQyKgMu5bR7gPLsLFaVnJH/ZzoI=;
 b=eMBGmHJX+zffjBSmiJZWQZawYzhjP2J1pLVS9QZNuba9lq0ptlihHLFJXSG97bji9tA/kUiS7J9uryAaEKDTY5uQ/BaG4yIENP32RgXOSe3RYbrIrBpm/ed8xt40d4YH9eG8vQIKI5sTsiCFZxL9kkAGT9c2WP0jtgf9xg9l3H5Uh6O0dQaEbMdItrhN9KVAv2wyWMtvN/NftMFQkuyZSk9F/1nNPdivR/ktOvroZHrrPxZuC8ODR1GPAqaHN0+bdAm2zH6OwcBphg7boFkQkN7/hQB8CNY35CyuW+WhwukZUgVxwxOfw3ea7Q7dL+UmJsUKOnKxX+7UfpDUECqAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9lNPmXPLXBvrUrvOQyKgMu5bR7gPLsLFaVnJH/ZzoI=;
 b=hrZxAINO2XYE5n0OXH5blvQzewxahOu7WGBjOnKgp1cei8IUZ828Usk8BzpUOQLHCzbtGDfyE9gD9rFinSr/NeLrbZ+/40CM9ITxloKWoPlmKkzGb8J/UoOptyoYzDz1NBl+bj0anqEmYmLLc/2ctWoBm3EcvwUpajrc89m9MU8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6918.namprd10.prod.outlook.com (2603:10b6:8:136::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 15:19:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 15:19:12 +0000
Date:   Fri, 7 Jul 2023 11:19:08 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [RESEND PATCH 7/8] maple_tree: replace mas_logical_pivot() with
 mas_safe_pivot()
Message-ID: <20230707151908.ypq3mlqqgyven2xa@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
 <20230707101057.29326-8-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707101057.29326-8-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0040.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 314b8d98-6e33-4c9f-38b1-08db7efd84b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aylmYlZIsHbNcVUqHYYU79KI0Y8SXoxjKBKoyR4ZrWwXJAumUbQT3InWcFdzxTOFXBYvQoWTSFU0uV5LqWc9klye5L1Vc1IGse/CkqxeNilTHvcbng1orOgAN9jh9d4W8e0+gEGw6ZZjIIsdLPSHA2Kd6zwrQDkAi2qrWQoZD4tnibCNCIdLkmP5RXkbhZpLXdD0uhe90f7lUeIOxpMEnavKGbC05EpRXmVKbN7McYSuVd7m48SC30/NI7cLh5lHFd5kPsw4pvq5YS/YNsTDy2lsEgBDEcSKkWSn2CdI99BwHxbKoDxUYrMEgeb0cz4AOrIz+q+HeI2trRo1dCQJh2TFvBxmhrqrnlV5fXh+r5o0biqP/GNq5YpTLwQoMF1DbOOm2YUXiXLhdwxumSzXeNcbgVgSqtDVxF7Ei6bbPoVS+GKP2l23RC82MFMi/2pasfQugbDwY6sPCkWlfWbWXbCLKSMgckJuT+q5azfxmMUy35vuG9jYKGDfZkqjf7neGP9jCe2lxLQXNZlA5r9hAR0vxiePCWfEaYgcf3AmKuGmeK0MDbPjrrrw0uGbKFyr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(6512007)(41300700001)(2906002)(6486002)(33716001)(83380400001)(38100700002)(186003)(1076003)(6666004)(26005)(9686003)(6506007)(86362001)(66476007)(66946007)(478600001)(6916009)(66556008)(8676002)(8936002)(4326008)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v6Ac0rhC9aILWslsHAao20ajetXozHBnOBIdcUbzzMK0zvKe3HORRTqXC0GG?=
 =?us-ascii?Q?CZbjt3Qg/H6bh+h2T7qCAG2dsPiBvrhC3lpZQpXMwEwEvglp0zYFC1bbDuRv?=
 =?us-ascii?Q?qEtRX9QtpqMhQ3X2vZxIayEseL4aRpWDpZhB1abfoNj1E+FoXhv3G2IE1Rqn?=
 =?us-ascii?Q?G7CdhutIIW2v+DT0GbhOg+B4DqFcsUJyn/U4PNO5DQ9oR0yvt1lwlcRWbRCs?=
 =?us-ascii?Q?jqyxpmHYJTRgxkRQnK+5dNoBKkqwn0iZwiacoimNc1dqNJOg9BRKH8MwfmAE?=
 =?us-ascii?Q?CUKlHaRymeeyu91Isyv9QLQqPS2BjXS7qnygSL1JNCSq0RlVG4hFFw0MRzG6?=
 =?us-ascii?Q?6Gu+AsCFZX46PVYKruNFUBSJ+XVCmFU+M6MJ6IrGtv7JvT7jOT6dhFehxILb?=
 =?us-ascii?Q?Zknkc8CaZBhueeeInMZ1xkeozNtWn+Hh0/FHpLqxnk8bq7RHgTyrMuX0t3+y?=
 =?us-ascii?Q?mikSy5K052Am4GbRobDUqJ028CUqxcsW7pkqqDgTwjFDtVTwC+lRYrM8tyRQ?=
 =?us-ascii?Q?xJKb+TiFG+wg5dGcUSZpPWhMCxAPXYB5CunhlpMWg3866X4q/ixphsfLHHEB?=
 =?us-ascii?Q?gdwbdY4SifxTseXFVZRVPTZ/Ie0MtMXcjDQcGBgU1hQha8ykL6I+9hgqlFE4?=
 =?us-ascii?Q?pG+rWIbjWM9TwBKHqSOtQHlkt4GGwUeSwooWxBtmpVaOIAf40ABYXi6Q3b5F?=
 =?us-ascii?Q?tBxof+n+FEw9rxJVHQC38cnA/+xsIO4qKfihgWR0slZ4l9IJtj0HJha380Xp?=
 =?us-ascii?Q?v4o9mOi8l7dtIBkNOSn3uUtDU86AthLjvqK6IifGwaIDJwSeQgvv0tzHv29M?=
 =?us-ascii?Q?44aQtRVXsRK7dnGnuTWWJIGx5VrK+DfeRc+LEFGTYFp2DxtuufBcVwJwZydD?=
 =?us-ascii?Q?A5GQxfGnisDr1kMagXaIBkM3ctj9H7UyahRzQITjjKKwbv9fMySLYTSlDyAC?=
 =?us-ascii?Q?zj6Uy1yVj+WqzqFNCzetdlO1C/RHlw7uWBldWE8T9Y1yddHNZBEpqIMoI5YP?=
 =?us-ascii?Q?fTC94LnF5iJViPU0hmain2F/i6KJYfz0nEUNgkQhR+P6xBYvNk0VG1uVIL+T?=
 =?us-ascii?Q?tlqJhl39SrmiKlbezOI26ynn/VEbwpxudGVh4fFx3l6jM5M/sut6CwumDMHZ?=
 =?us-ascii?Q?mXgf2nm456xeOTU4O5xIigg+P7lXSVkN3RSoiZhK7Kb6TEAX59MOALEKitt+?=
 =?us-ascii?Q?OXxXQhTjvwtXRqJv+1ifYr/eYBAlsCX+Da9PNgzxb8k+5gAsmVs3aDSq3G6K?=
 =?us-ascii?Q?g800f/c044bimn2N6Vko9G0kkBjt7+0Jmva4beDW2snr3Zc6Gc1N5qmLUcYd?=
 =?us-ascii?Q?VfWqNY/mn4JPBtbLa0xpMMXNXADKOl3gN2EKFQM03zCDcRzKobheX81ZCt7y?=
 =?us-ascii?Q?aUT2z040BdetBu2PBRoAjsXWSw58az5A6ssH0+0A+zvwBLmNN+2dByRl2DWw?=
 =?us-ascii?Q?O0zYptPtwJtcl9P+HGla/ZHuwHVHf3+J9VayNOWUpQLX276UbMhNYgIfYDWF?=
 =?us-ascii?Q?0IGuoPfJT2avgYhRu8AO1xLkJqVJCgZ/XSbEeNO0FCNUEZSYwjpU9KgaMKtK?=
 =?us-ascii?Q?9dkbxXZZpkCmomc6bAV5RCXiM7pvm6cZ/bq+qwVO0ULbnm1PE3oMl1Jxh+Hw?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?zaEvtw1Fn+1cW652JsIfNbNOAOHOneW+D5mca50PF8xU4+BxQOk/4HuGp+8v?=
 =?us-ascii?Q?r1nlxDQQuXC1NMJFlJcraZhj3qEsQ5yNfD5PXZHZGcvRKmNmKIar6NeR5Bsi?=
 =?us-ascii?Q?+UqV+0AiULlHzMSZONULVxv7OXyRWA6tAlcCjIexUYiJ2geUbvqVynexklGq?=
 =?us-ascii?Q?ZEOaGDCB6iJQVkNsJq9CLP0oxT0CHllNwtH4bYcEkRaICvN0ni3G9wnA/utK?=
 =?us-ascii?Q?MA22uEfHRZnQnmKs5olDNiyk1hPKn6NIfb9i4sN1jCjQncjWOBHFiWVMrZ2v?=
 =?us-ascii?Q?qrxuWgWPHQrsAbZreoc6reqQD7vywKzzgCLuhfeDHCKSbvInyONiJLc2G+Je?=
 =?us-ascii?Q?5h+B7rCZzCFhKiFEBJ1U+35QO25NarXQFR0nIQYPDXgUf7r3ztC+oAAzvb4/?=
 =?us-ascii?Q?8mE4peBCSTBqjLgODI1WQn9yR6gGUnJbruStauOvy+Cjy23WPtyOId/Oz4cn?=
 =?us-ascii?Q?hBvPT66Rw+wo0wHxcV+awSUiayhYFuaIFy1e4NC2LZPxmhH/4lncGUzSl8iE?=
 =?us-ascii?Q?iLEs7bIq3HQk+j9tKIELlefvypFxxwtshv262RWP1FB2Et7TsRVsAAE34SrX?=
 =?us-ascii?Q?H+b8WJKjBb1n0W1+jzeN+kp0FAcB+RGOGfldsxQ0NB0IDERzE4j6cJ1gHZ3n?=
 =?us-ascii?Q?z9m5AEoKja/mO+zqZ1hfitcEJzI5gIX6BBcvbJDacJVZW7QsOU+mayRfJT5O?=
 =?us-ascii?Q?DVoklNT1Lm66rmeUjWbyWu7fxjSl86Uwk6FNVgRUn+DA7X3DkyydjKF/RlSI?=
 =?us-ascii?Q?1H3ou9pI8gpBgMF9g74BgGdfUAL7Q5IuzzTkEwWsrVVuB3j2yZyIb6XGkjxO?=
 =?us-ascii?Q?pW9GF13wiAwEp92/l0wsem9wT9omNTq/3yXlYvEhDhJC49dMQbNw5ezMwFc9?=
 =?us-ascii?Q?t3RHEt5Xxhhdv+n9S2sIYRkevk1dd29j5ajQZ7xFhBF4E8FrMwNUSkiJG4pP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314b8d98-6e33-4c9f-38b1-08db7efd84b3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:19:12.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9sgUp3Yql2JJ21WVQ1B5N2ZD7kNbGdjObozH092rpRvYwYpwsxIo6uibyo0+F/pkDK+gyuaEyzfG4sFSuGIFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070141
X-Proofpoint-ORIG-GUID: O46G_MXpuBEDcoeIUfdDdBQSzlKdPvid
X-Proofpoint-GUID: O46G_MXpuBEDcoeIUfdDdBQSzlKdPvid
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230707 06:11]:
> Replace mas_logical_pivot() with mas_safe_pivot() and drop
> mas_logical_pivot() since it won't be used anymore. We can do this since
> now all nodes will have node limit pivot (if it is not full node).
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 33 +++------------------------------
>  1 file changed, 3 insertions(+), 30 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 3aede7deaa26..8c08bfdc99cf 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -728,33 +728,6 @@ mas_safe_min(struct ma_state *mas, unsigned long *pivots, unsigned char offset)
>  	return mas->min;
>  }
>  
> -/*
> - * mas_logical_pivot() - Get the logical pivot of a given offset.
> - * @mas: The maple state
> - * @pivots: The pointer to the maple node pivots
> - * @offset: The offset into the pivot array
> - * @type: The maple node type
> - *
> - * When there is no value at a pivot (beyond the end of the data), then the
> - * pivot is actually @mas->max.
> - *
> - * Return: the logical pivot of a given @offset.
> - */
> -static inline unsigned long
> -mas_logical_pivot(struct ma_state *mas, unsigned long *pivots,
> -		  unsigned char offset, enum maple_type type)
> -{
> -	unsigned long lpiv = mas_safe_pivot(mas, pivots, offset, type);
> -
> -	if (likely(lpiv))
> -		return lpiv;
> -
> -	if (likely(offset))
> -		return mas->max;
> -
> -	return lpiv;
> -}
> -
>  /*
>   * mte_set_pivot() - Set a pivot to a value in an encoded maple node.
>   * @mn: The encoded maple node
> @@ -2202,7 +2175,7 @@ static noinline_for_kasan void mas_store_b_node(struct ma_wr_state *wr_mas,
>  		goto b_end;
>  
>  	/* Handle new range ending before old range ends */
> -	piv = mas_logical_pivot(mas, wr_mas->pivots, offset_end, wr_mas->type);
> +	piv = mas_safe_pivot(mas, wr_mas->pivots, offset_end, wr_mas->type);
>  	if (piv > mas->last) {
>  		if (piv == ULONG_MAX)
>  			mas_bulk_rebalance(mas, b_node->b_end, wr_mas->type);
> @@ -4934,7 +4907,7 @@ static inline bool mas_anode_descend(struct ma_state *mas, unsigned long size)
>  	min = mas_safe_min(mas, pivots, offset);
>  	data_end = ma_data_end(node, type, pivots, mas->max);
>  	for (; offset <= data_end; offset++) {
> -		pivot = mas_logical_pivot(mas, pivots, offset, type);
> +		pivot = mas_safe_pivot(mas, pivots, offset, type);
>  
>  		/* Not within lower bounds */
>  		if (mas->index > pivot)
> @@ -7007,7 +6980,7 @@ static void mas_validate_gaps(struct ma_state *mas)
>  
>  	gaps = ma_gaps(node, mt);
>  	for (i = 0; i < mt_slot_count(mte); i++) {
> -		p_end = mas_logical_pivot(mas, pivots, i, mt);
> +		p_end = mas_safe_pivot(mas, pivots, i, mt);
>  
>  		if (!gaps) {
>  			if (!mas_get_slot(mas, i))
> -- 
> 2.20.1
> 
> 
