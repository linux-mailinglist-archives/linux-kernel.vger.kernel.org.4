Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857B75BC9DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiISKuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiISKte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:49:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2719EA1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:43:36 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J9EIJm001796;
        Mon, 19 Sep 2022 10:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=akGoCOL+C58oYIohx49T/22UPzNV39teOpHVVEe8rdE=;
 b=T7K2YNKxMKRo5RvXZIW0jjJs2wgxghm1MsKXaGFtw0fHHrhxglQC/0Bm57tQZkutDQ+7
 i7pK41x/2CJOIOyelcv9GyW4S7w8CMZuHYXdRGExL92VeGIYVnexE7AWCVU4ek46ubhA
 vWul3mqel64hxh/MVsce7WgR71C84JSE7CXMWjRu6CnvUq1A9BkVZlq4Jz8wB8AWGCVN
 p7p5481soQEutIs8IUyC/XdBnoQF0dJlNOiKDL9f+cBSjy8KXJBXEHfItmamRelTBs6T
 3oGbznnOOsMYCjpkeMDco14c7apThax1Mh1rrFKABxMKSe6W9ZhmxzsV9OtDcdK3vpAz NA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68m3dwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 10:43:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28J83C7a010049;
        Mon, 19 Sep 2022 10:43:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39nxsef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 10:43:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOX2VfXseV21vHXyr+d+HgX8hZ1yAbhoxajlqvSem2DYC65DAvHHvws0wwC1IqiHcPPg0BNzgW9QBO3vMXzhLikTB8MXlHhtzmSxeIqHsk3u9yNob3mE8UjVpTv1lMNTDiFgXJ6SiUcRr7z4uCBuuVDAXTChcYbrVrWEAu1NrTQYYGtMapN6XtDmzA8T8dSDL2wrgkqN4kHlyd1LRcCONYHUigkxhOkXWrer6MRLBr3FxbougLCabqqRIgwzYZ/w6RQfI8iDC7sug6nL4dqwoHb0tlhzXysLpiNhos71LYDtPuAuRrU+kGuzm64GCI1Q7hPDTH+qGoEfMDmX23zRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akGoCOL+C58oYIohx49T/22UPzNV39teOpHVVEe8rdE=;
 b=dDd/1CGlUhKixRYabzveJdSa/Wwbck3STIuCfnf3KK5IHvbgF+faOgh6sjst2x6oAxrcXkrhBtYW0IzY2fWrHfCo+ShEmn69GAvTo8eBYJd5mB8+H+kKhXtmK+pwa+zHYt98VFuINlpI8Rnf5RO+OwlLbfFPDdQoju3oaIRU8zSy41khgVKRE+q9gwlvKWVBRFiDV7IOn4H28CVhTxzxZo0IDEf1oAquXjQfJ0kcdICCgVa7205Cb0gMqFLmCcvsoUIPGXVgRk1awDtGr5A+WaX6xAfxDdfRTkjsE88Tflw3V1Sbr8gfudnFHKC40uSVEfD/VDmu+fFqCW9nXlAklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akGoCOL+C58oYIohx49T/22UPzNV39teOpHVVEe8rdE=;
 b=o2ZootJWxE/KptJHcjykIt0Bt0B2q3bZ/0M/jd508AruJn3uyPEdyj0voWFb1PlkyxHswPkxO06ZjVcU4+zP+PDXSRjgro7EythhUDTfL8Kwv7ZMHQb3GNzg6bmLj4/38i5h6szInGPllqlPVxzvi0gpYPKk1CeNh1AUlv7JMRo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5903.namprd10.prod.outlook.com
 (2603:10b6:8:85::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 10:43:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.016; Mon, 19 Sep 2022
 10:43:13 +0000
Date:   Mon, 19 Sep 2022 13:42:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     eadavis@sina.com
Cc:     lkp@intel.com, almaz.alexandrovich@paragon-software.com,
        eadvis@sina.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzbot+c4d950787fd5553287b7@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [PATCH] fs/ntfs3: "add a boundary check for EA_FULL" lose right
 parenthesis
Message-ID: <YyhHowvgEarPqONR@kadam>
References: <202209121421.hVaJ6pLd-lkp@intel.com>
 <20220919051943.184810-1-eadavis@sina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919051943.184810-1-eadavis@sina.com>
X-ClientProxiedBy: JNAP275CA0062.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|DS7PR10MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: b6de28c4-2a98-41d6-071f-08da9a2bc05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1gjnatxe6lFzCWYRWx5Qb/U36wm1a+yY8j+x2BhEHmj+QViTA9ukzNj2Md4rzVBzEwLzfjV+JJ5a8yVzfyMVzgDqnJMXeang4rOAPjuK+86NS35vkqGU0R5/PPRBsRB0uKeZ/kIU5CP/1fuXd4cBW/ef3rDfyXdMZ8vtnW6PB7Q2fvz5ONy/Wom0CiDjO7BNkn2NnbsnQ+30Maa7OlgFAR+ET+Lx9gJ3JtvVVffakj5xupwepBA0hAeySLElUdjyvnPf5IOvy0R/4jprz99kIBu5G39afUi7j/osnEIfrPnymBjRGdeb4SLvWXKFCYy4ONw8BVGNOjGBzuafZ+7F3AkqUQfYeIQTv+h2+QHjT7N1Rj5HASofjPUsM/UcsWkV4ssJ1aPnS5Gg14j46coKrlpd3M7+Ym1ddiHzQAk19Jg/QA90T8sPFK40lxSgAj9JqHJaUFKupH/C27qZ5ftEKwcBZd9MjT+llqohee/FnpukAw87KdfUPAePfou5sK5PxX9u3R3BwMPEWVBrmxxG8ACnC3Yl6k23DEBil1T0UA2Nca0LziJRfZBWB+9d5wXV18+JAssHs5h0Rxo2nn83JYhtZO7U87dsdn3GtZ3QrqATKZxxAjYWUhMS3tUBBP36U6WISvT1W+YeIKdSaDSftfl2W32QfZJLImoVhZuTA9MPf/4WGqORa+V98ZzgDwwTQjObBTmFrHysx0HBv6ZuIWqJfLpFxB8/UelY1kw8gguSZBS17muv4FqZhKKHze6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(41300700001)(5660300002)(44832011)(8936002)(4744005)(7416002)(8676002)(2906002)(66946007)(66476007)(66556008)(4326008)(6916009)(38100700002)(316002)(6512007)(6666004)(9686003)(6506007)(26005)(6486002)(86362001)(186003)(966005)(478600001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9898h8L4o6Au+/f1gB8g/Bw01ecL+J1bjH+vZSyYBvyZbWXf7nZ/Xk0VyNZR?=
 =?us-ascii?Q?GxfDgm3Nv4cOZEp/cOtC6i+7ZgC2DyQcSqfh9i5QH5s2OC7s0Spg5tiXHb/K?=
 =?us-ascii?Q?WfvbZgR8GrideCVK4v8pY/wj2q9arqpZvsgdR7rE1lw3m8sDiqob6hqkKpg8?=
 =?us-ascii?Q?dpHAYL/4pfURxVTN0ZNqwWJug7/spTU0pWqdDVqtT77XGLId9U04hNf4dN0f?=
 =?us-ascii?Q?Ab2QRmMPp2ftIbiI75cySod6HkjdYuQztPtZGYwMyihLsQcZhhphwlqddqk7?=
 =?us-ascii?Q?qDPu0WR8NjDcdTwGMWD6ydJ2rZP7y37oVUxvcpKzpJQcMmK82Rw3Cxkek8At?=
 =?us-ascii?Q?9MFODAIjHis68139/YbPIiL8Mr81oLv95JiQyzN7LhJHpEcSbnjIkJV4Ue/N?=
 =?us-ascii?Q?/xoi2fQipU/rj7GTsMiNCVHXvt4916+ufA3jEMroYV1nZV/mMr9ZIPT9hbdf?=
 =?us-ascii?Q?SpAaOton6hvtZ4vo3i7PXg+3ds4Yhpo9NAoBcXu9Do5RPXxypJN3c39zL93f?=
 =?us-ascii?Q?fAjvVoJ+H6csfK/pn7bBBo0bWLvnAYDC/aYkYfSDm5J6vuP+6vZmcobCaKw+?=
 =?us-ascii?Q?d7Ba11N9RwQcmzM3/PkEiP01zXtAwdkbOVif7LyOo71cKFgyhiWlJaqbAkQh?=
 =?us-ascii?Q?9OU18dY/3CMpVwo7FmRqFAW1BcMvSD/ztnjysZYOiqxYluZICjHo+Ozw4hi6?=
 =?us-ascii?Q?Ph7mc1QXK2mnMsMh8Q1pWYy5pzB+e4iFKQ1imFzDOI6+cvkczVmp1WXguiuB?=
 =?us-ascii?Q?2Du8QBII8O4KGFUsMtlIAN+nGksO0tm2GLXG3U1JQnFWgDCyK6gWXBhMvhdF?=
 =?us-ascii?Q?5REU6FCk+4qDmpzg9GAtQbe/ociwVL8hmrsnA3tVHalieaxS/yLXOz4z7xpT?=
 =?us-ascii?Q?SrVtmvMKAST5WKja1h1jLEKSgvZN16NQ2p3Z+/IPhO/zqge01GSFg65rIec8?=
 =?us-ascii?Q?zrJDeSbQ3m7hYhpKFmybu4YajrQSo1pon9a6Z4Z4Hxfa/kZSSPDfx/rIzhKA?=
 =?us-ascii?Q?OBs+6i+6y1+9h+duOeug3X6OC97CRzRk2uUkr0y3spTtBg1KUdbLdHlDxClf?=
 =?us-ascii?Q?Wr0YYE0VtnZ4CvH93rWNULLwfKZhEaLE0Kd1kQP+MhaP3Vqu+xI3BfUY/Ijh?=
 =?us-ascii?Q?Qcmrv/K0Zk19J8Isct8RQSOJXObafBRbLp/YmgPzUQ4j8xr78BFXnFz+2VzS?=
 =?us-ascii?Q?8aMrsJxSfLMhyBy0BgFaUX9Hy2GbvpHWkwvqubdgRUWgM1F5yQ01U8BiNwY3?=
 =?us-ascii?Q?KCC+p5Bb6NWsyeKNDfINObZd9+ItVTyThfvoTcSDjKadF4Tx1wahssxpxCjZ?=
 =?us-ascii?Q?+6SkVA0c2ldGZ0u6D3o68hOJbp0vfAUw4HeYGwIBx5boYuN7A4R5oxcoSXZ8?=
 =?us-ascii?Q?6NHhP4ouOc5qQF8g5uO9Dh8+FgTENcaAK68trBT9rIcVRp5SoJtyk7ejH+zw?=
 =?us-ascii?Q?GsD7iv6FbvikDlWJ7+oHKCMOtjMtCDx9BzuiUmGd2kyzmnxq7VlfQg/C2Ibr?=
 =?us-ascii?Q?y+XZKlxO1+VTyoUslk9uFnvQpgCdxp1K2iAitroN4Hwe8MkbZAJiRw9O3qfe?=
 =?us-ascii?Q?0n35CaYMsWGzedIBr/yd3DtZg77phG5t9pJoeEKoyvluTRcTKkQ4Am+rntAp?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6de28c4-2a98-41d6-071f-08da9a2bc05d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 10:43:13.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elCsin8XItlfcFzgGyO2H83iJ/3SJOa4/w0UscI2ZvnayaTzpLZ9BMZgtUMPf5SvEYTyl663CY29qVEnx+9DMB7Xcj8SEdWTxS8Wg0YjuHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=638 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190071
X-Proofpoint-ORIG-GUID: 9iUlwiaemMReMSums3oyXeEn3vIqDrKq
X-Proofpoint-GUID: 9iUlwiaemMReMSums3oyXeEn3vIqDrKq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 01:19:43PM +0800, eadavis@sina.com wrote:
> From: Edward Adam Davis <eadavis@sina.com>
> 
> I have provided a new patch:
> https://lore.kernel.org/all/20220912065431.3043731-1-eadavis@sina.com
> It is a collection of the current patch and the previous one.
> 
> Signed-off-by: Edward Adam Davis <eadavis@sina.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: syzbot+c4d950787fd5553287b7@syzkaller.appspotmail.com

No need to send this email.  The correct thing was to send a v2 which
fixes the bug and you already did that.  However your v2 patch was
missing a list of changes.  "v2: don't break the build".

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

You will want to address the review comments I sent and send a v3 patch.

regards,
dan carpenter
