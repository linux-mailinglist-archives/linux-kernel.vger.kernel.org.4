Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6906EE543
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbjDYQI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbjDYQI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:08:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ECA170D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:08:55 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFxZfA016398;
        Tue, 25 Apr 2023 16:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=+zL9ZWQVi1ongCq7e8JyiAcNhGaVGbVJGFAy6OomUpQ=;
 b=KfUJqy7FV93hqUTssEdYrO89w6ZrrdGNG5XlVLrF8wmj76RrEN2jIUedekja/Qbil5X4
 jzr1r8t16QSF5kebgo/Z0W4SpDKtzY36LbKkCwmddxT6Qf2lgY47IHuHXWheBEjdcN5C
 pheoN1N33wcDeFNPVhEl38Orv5wbnT0pCts5ZhhDl2Z1XbttaUooe184rfTbIGsFCvQ7
 i+PVHwHfmlNYmUOZvy3RmIY0Q7SVenzW/H3BHs4RkCAknnX+KL7uZdU2jpUa93W1L7K3
 C6ymeNsq/v/0fhZK0Zwg+2POBzsYL0MkNSBWKxYPBpcPg9S5Fn0Q2d7/YHIx/TL0tvLr hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbnycp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:08:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFMgmY006697;
        Tue, 25 Apr 2023 16:08:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616p7rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:08:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPPwP67FpCL8AS63dC41gEdujgYQjEddbV2yXsRJES2NF4l7YQR5NJPYw7lLA8HPnD+hCUGR/lhXz2tpFANWHBYjVZuCZz5tHkVnsQ9OJ4+hkUuDf4hRizNOk0EQloKnx8j13h2lnkGjQLjX2qjhGqnzt/vhbzlafSrY2SDiTRq5J6G7N/EhdmqyuKokKg7RXYIZnGes2m03RuOveVqX6PdFKYH2S+T8Px69Tg6ZdNzxj88YHdOXwpAQUbls/weyO7J2yirE1iAGURodUuahL25qrVfsflyIGNI6faPDWZbOnQ/6+Y5Lma//g6htNCPT8Q8sKeBu379z34PRVOp09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zL9ZWQVi1ongCq7e8JyiAcNhGaVGbVJGFAy6OomUpQ=;
 b=FTuziPeXUQzlQ9RQvlqbkqJjuQST9Tb+G4lIhJvXSOEz+G99InrMGlUY0wfEQ4mWB/NZskvvjxKVK6Wk90WDE+RnRI4cA0LwLgqf5OrPVpmOyrawkW3xHDRwIu8y3uitv+gsMn6uujr2r4hSMcjpM+wv46D5JjI5+8+fxme64qgD6hse5i1v1uoaEoTnuj8/xXKWfdLTq6lmYegfYFHivWPNWRJMkn/dN/w/QvrFXtKr60sZQ72onlzm+4Z60AnF9glvYs+WVFCIDJ0Ik6tNH1/VTdrw3sFscW7za3yIXlogVZcQGo8jVhGzA64L2lOeMgdyZF7iE1ARWlJF9nRlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zL9ZWQVi1ongCq7e8JyiAcNhGaVGbVJGFAy6OomUpQ=;
 b=ofYxZAaPEmtqNtnk2O7u7KskUGCdtuzXVlZhpAOfDPHOZRt88h64YalaSLMTyg4Hi0qgAom4vppJOtuRtFGZlujI3g4Eji36nKL3KzkNSSfyyl3jca31ddD5b0JJXs6Q9WGJpPJdy/Saue+bFNua8wfSN4G5kTlJMmKX1SPR90E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5122.namprd10.prod.outlook.com (2603:10b6:208:328::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Tue, 25 Apr
 2023 16:08:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 16:08:18 +0000
Date:   Tue, 25 Apr 2023 12:08:15 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 3/9] maple_tree: Modify the allocation method of
 mtree_alloc_range/rrange()
Message-ID: <20230425160815.mionpme7bmdequzb@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
 <20230425110511.11680-4-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425110511.11680-4-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0002.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: 820f5e42-8ea9-4ed7-d089-08db45a74885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KRrK06tu1zAqGfOFbbTcoesiXnXoHzwk4GP/Li3hyXf+CECpNhGXdrJR9LiymXcvvyuJJDQXq6l4OyzPOzOZWgQCc+B0l/UResjzN9QWmKMCV1ltBgM/Crp7fwka/kiWuw8yneymp4DGlTJiUFysrFfIdlyb7x/RrYEvKbejD7Dha+8tK6Gzkg3b91zirW9E7O5h02WywY4NQZm8DlwNNrXnZAZzGG6flXXfZqXebnxkQGSvTfNJ3sw2OdrHT2slsy0TbaSOiERyk1tEkrblyw727FkCE0uT66QAvOCTqZgn+GxG1DgYFKb9CT+jgWhQsLRBPSDSVIOd2jQiTM/wIJK1JxiDDz3/nffDRVEP0oKXCyWFvuCVYXM02lomhN3gr3hDcnjbusJlg4lmQX7hawUs733hqXuswundhT6C8x+ZJOdQaQ5R9apCG+OR87fH6V/x1uLYbGjf7cJnR5wOItUql7C+PN9FOwa4WL6hX1NvEU6ysSnVuc2JKkw6PuFnpygXAPjGL0huB0Wdp6s+1eosvpDrEX1or+UX6Ekby1g1O0daSBXH9E9WYisNyKws
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199021)(66899021)(33716001)(86362001)(478600001)(38100700002)(41300700001)(8936002)(8676002)(2906002)(6916009)(4326008)(66476007)(66556008)(316002)(66946007)(5660300002)(186003)(6512007)(6506007)(1076003)(26005)(9686003)(83380400001)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AiG9+mVbx04/IDnYsOnyXD2yU770RDEtI6xe6/R6yB9jCshMmGBdOreYTGJ9?=
 =?us-ascii?Q?Zds83BfP/ECJFTTi1ARWYtlOWMrvS8T2JYQe/lkn5SS4I9EVjwNIOpcsctPF?=
 =?us-ascii?Q?AoXtjKdL5YDPTh7HiyYVk6pcxoDZYssO1qQTHzGb7dMXQdyBs1zXkolzHSES?=
 =?us-ascii?Q?VhrZle1BNkY47O3pt+RXimH7RR1Cy3eEG/Af5ZYQs3AMerwNRJ+rkylVB0KR?=
 =?us-ascii?Q?6YaAcp1bBDDjkxM7Lrw3vCAg7YjCLOt/K8TC0SHfnULv40PbtSA7yPdjsbQo?=
 =?us-ascii?Q?4vGJM8dIqghQjY2eZxV1Uqx3u/tSKozqJxxa6mzwX63wBTh+SumvZ+ord94w?=
 =?us-ascii?Q?a+paGzgFRdo0XWFOHyNSdiQWpFZ/PxMe/16siGva6Tsy99YtF2om313BjnWW?=
 =?us-ascii?Q?EBmtTSunIBvJ2CWC3wMw883fZzHdZDNi/SbQY5+wbvNkt3Z4gWhoPDgOAdyV?=
 =?us-ascii?Q?2g3/FJIDnUg/LKzYVory409FLNst8j2BvhSGD9QefpiG52TnPKojWSaOEY06?=
 =?us-ascii?Q?qbFb0lzORxH1dfAV//q8tTEaEx8QaoZveWxGONYo7udapSj3ytTrJRcgtnpY?=
 =?us-ascii?Q?U3XXUEfLOGVBgUvkmj6ys+eWbEa1nFIA4Chouc1cVkPZ08KZmoxVnl9GplT5?=
 =?us-ascii?Q?zpwi08u7xVWj+KN31WLBfTRT3fPZDAYgU3fkgafptbz3hKvRD95KorgBxNvY?=
 =?us-ascii?Q?xdOnD1m7SrgHEFsNkXva/2KzAeN6gVYDJlPf2p0ZqVRQ8QtDFjYpx5UVN0tR?=
 =?us-ascii?Q?SUIKeG+TphJOVytSzZBmmAP+jo/32BV4u6pQVCHkmZDhYW6wM/mobtpvTT0I?=
 =?us-ascii?Q?2p5QgEOAjhPLoAsk9p9GXM9SZTGR7TR+PMKIlwiCUNb4/BkjCGa9w2cE+q2m?=
 =?us-ascii?Q?y5j565AOAroQtL7BFLYxbwTRi/6e4YN4VAYWqnKD4fQd1l0YxY58eQDJOAC4?=
 =?us-ascii?Q?UNqhemFgREuJ/Tz2zIZvd5rXlTRElYJOZs66v2ZWRE6I3gcB6L1MCT7E2Xnh?=
 =?us-ascii?Q?Ua4QM40IQchKzKA0FejVcKvH689XYlS7DbWJ+7YgJUJ8GEycJEyTTEPslPQk?=
 =?us-ascii?Q?BHqf7VdS9DXQ6NYEc1/eSsflRZz8WQrjQxPpggEzkvnQQsTCX6Ih49Z0epqe?=
 =?us-ascii?Q?XNbReVQiKcCSrzx0GVKk+NQvB1YIQqB4FSc8Ux8iIb6MvLijreOyFIA2xlZc?=
 =?us-ascii?Q?mwbaxFJ4VX2Pn2dOURCNu2pyLLtBtm3ItSqRMkPxWUZbGlEW+lM4aWuZy9D7?=
 =?us-ascii?Q?USE9aFKN21e24S6PC2Ua+FSr0+7cQB+V3bjUvWb6sr+oHIqtQik3GJ+qMvj5?=
 =?us-ascii?Q?nVfLc2gUYxz4f3psuwMvAtv6xLBwuDfTbRfzNNzpBTG0agxfvF2yuaBxCcwB?=
 =?us-ascii?Q?sD/pBHW78u6lxGs3TZCHopNdV4q/P19Y7p1VYxSHxUMvdfMW1reiRUg86IBP?=
 =?us-ascii?Q?ICYZwZBakpV0jrIxk5GbQnHOCO7/GJiQEmBOx3SUI/NLGhD7HC8aOGHqKmtY?=
 =?us-ascii?Q?G9amMIaDXbs3Y4JKkeqN5t5xBC8GfNEG6lmbE3UKEYGDTA/QI2qTQ++quAZR?=
 =?us-ascii?Q?tTqE+Zfn0hREqw7LdQKpvfxV82Tbl/f4G5o/5EFCEDRTlYVS72oYdtkJVvrF?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GwP/F/KhW+wqI8QjaZhFuR8LKtWLX378hNKrrvTBLFVskEETS3UZWXesd4O1?=
 =?us-ascii?Q?FbxMUEIMESmIBfdvw931eUz9+DW46jNRf60wTZYzMwJx6/0YZP79DgPbVARS?=
 =?us-ascii?Q?E7SmXNNtrJ/BLpeKu15nc5Wz2HfO32ivRFOPMOk2DtKVDcEacAxv92HggJQD?=
 =?us-ascii?Q?VT6Z+iuiiGIH7dA1BuEOylj+M/W1hBS9yaTEx+M77GjpCRUcdLAUFTmSfBGn?=
 =?us-ascii?Q?89X94JGHHd/8QGKY6eMK8NomjMBmFOU4WlhIbvTD3HPiWo92rtMA77d5Ck/6?=
 =?us-ascii?Q?91Lcuk6FbGlsfgiMRx8og7uBs52+Yu4WJ4yCtObU8cc5U8o3bEnJc3UmndMu?=
 =?us-ascii?Q?nJCwDXfdYFT/hLufocj9OwI72yQ3nNctUwJ2HotJ6LOSqd2qOksDpXyE8dfa?=
 =?us-ascii?Q?U4F/F+nBpLLLx4ljngXkJr7jDbQ5tqiBQx7i7ThVlvVrZ2VUDSu8kIK1XQH0?=
 =?us-ascii?Q?dIUq3bXfWxdM6CIL8XKej9wFA7WbRiCd6AVJZvXD+A0So/nbIur9iuENT4pv?=
 =?us-ascii?Q?oHFE3U8LwClzcRIkZfIbIxL75ww3NsLCmzo6nxP4ry/pn1Ef8v/TK1bY7zjU?=
 =?us-ascii?Q?VOQ8XF+CoinrE6cPjAq17CzIMTXmA6EZ8PcGAC5OWN1UWU9tXZgmsvgPH04a?=
 =?us-ascii?Q?EjCyRU05QFDzEquq1NIGbFEaJvpsov9ofRJnz3297B51+0hCoisopvjS8YHb?=
 =?us-ascii?Q?LoQns1w/UuFPqFMuqiNBPEyopZCxHFtowxypPUJllUBnqFJ7INUU+1M/Qxa9?=
 =?us-ascii?Q?NtJWQie46g1HTCNS9pccKdvH02FGh3TWl7bF/TmKYoS7zZ4KeJdifKk2S/xz?=
 =?us-ascii?Q?FInAqfGuAIEtXSikslbDeGBwMobEUVTPNAqilEzLtER7mnF08ITFjblylAIt?=
 =?us-ascii?Q?soHVVlcbeDObPN7wQqpD5npWIsXsFHxwAFj6Zw6jqg0kUAVS0k4Ozi5dCgG3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820f5e42-8ea9-4ed7-d089-08db45a74885
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 16:08:18.2722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ckut6D0GoeRr+1Gc7BS/Vf0I7Kt3beTOW843MtET0hsAn3tyHWlb3RQSFUcSwaUqzrCgMu8nLP/nargjto4JwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_07,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250146
X-Proofpoint-GUID: GPvsVoAEc50PmwvEl-LJSqAV_r--3Ly7
X-Proofpoint-ORIG-GUID: GPvsVoAEc50PmwvEl-LJSqAV_r--3Ly7
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
> Let mtree_alloc_range() and mtree_alloc_rrange() use mas_empty_area()
> and mas_empty_area_rev() respectively for allocation to reduce code
> redundancy. And after doing this, we don't need to maintain two logically
> identical codes to improve maintainability.
> 
> In fact, mtree_alloc_range/rrange() has some bugs. For example, when
> dealing with min equals to max (mas_empty_area/area_rev() has been fixed),
> the allocation will fail.
> There are still some other bugs in it, I saw it with my naked eyes, but
> I didn't test it, for example:
> When mtree_alloc_range()->mas_alloc()->mas_awalk(), we set mas.index = min,
> mas.last = max - size. However, mas_awalk() requires mas.index = min,
> mas.last = max, which may lead to allocation failures.

Please don't re-state code in your commit messages.

Try to focus on what you did, and not why.

ie: Aligned mtree_alloc_range() to use the same internal function as
mas_empty_area().

> 
> Right now no users are using these two functions so the bug won't trigger,
> but this might trigger in the future.
> 
> Also use mas_store_gfp() instead of mas_fill_gap() as I don't see any
> difference between them.

Yeah, evolution of the code converged on the same design.  Thanks for
seeing this.

> 
> After doing this, we no longer need the three functions
> mas_fill_gap(), mas_alloc(), and mas_rev_alloc().

Let's just drop mtree_alloc_range() and mtree_alloc_rrange() and
whatever else you found here.  They were planned to simplify the mmap
code allocations, but since there would need to be arch involvement
(coloring, etc) and alignment, etc; it is better to leave this job to
the mm code itself.

> 
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 45 ++++++++++++---------------------------------
>  1 file changed, 12 insertions(+), 33 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index aa55c914818a0..294d4c8668323 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -6362,32 +6362,20 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
>  {
>  	int ret = 0;
>  
> -	MA_STATE(mas, mt, min, max - size);
> +	MA_STATE(mas, mt, 0, 0);
>  	if (!mt_is_alloc(mt))
>  		return -EINVAL;
>  
>  	if (WARN_ON_ONCE(mt_is_reserved(entry)))
>  		return -EINVAL;
>  
> -	if (min > max)
> -		return -EINVAL;
> -
> -	if (max < size)
> -		return -EINVAL;
> -
> -	if (!size)
> -		return -EINVAL;
> -
>  	mtree_lock(mt);
> -retry:
> -	mas.offset = 0;
> -	mas.index = min;
> -	mas.last = max - size;
> -	ret = mas_alloc(&mas, entry, size, startp);
> -	if (mas_nomem(&mas, gfp))
> -		goto retry;
> -
> +	ret = mas_empty_area(&mas, min, max, size);
> +	if (!ret)
> +		ret = mas_store_gfp(&mas, entry, gfp);
>  	mtree_unlock(mt);
> +	if (!ret)
> +		*startp = mas.index;
>  	return ret;
>  }
>  EXPORT_SYMBOL(mtree_alloc_range);
> @@ -6398,29 +6386,20 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
>  {
>  	int ret = 0;
>  
> -	MA_STATE(mas, mt, min, max - size);
> +	MA_STATE(mas, mt, 0, 0);
>  	if (!mt_is_alloc(mt))
>  		return -EINVAL;
>  
>  	if (WARN_ON_ONCE(mt_is_reserved(entry)))
>  		return -EINVAL;
>  
> -	if (min >= max)
> -		return -EINVAL;
> -
> -	if (max < size - 1)
> -		return -EINVAL;
> -
> -	if (!size)
> -		return -EINVAL;
> -
>  	mtree_lock(mt);
> -retry:
> -	ret = mas_rev_alloc(&mas, min, max, entry, size, startp);
> -	if (mas_nomem(&mas, gfp))
> -		goto retry;
> -
> +	ret = mas_empty_area_rev(&mas, min, max, size);
> +	if (!ret)
> +		ret = mas_store_gfp(&mas, entry, gfp);
>  	mtree_unlock(mt);
> +	if (!ret)
> +		*startp = mas.index;
>  	return ret;
>  }
>  EXPORT_SYMBOL(mtree_alloc_rrange);
> -- 
> 2.20.1
> 
