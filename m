Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6867372D0D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbjFLUmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237693AbjFLUlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:41:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D328F1BDC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:41:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKNsrk003017;
        Mon, 12 Jun 2023 20:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=812rbvUohctb//QCwvvGnF0ZAjJWMAJsWaUHeAI/wzk=;
 b=qu22SbUYuWQbJHvbECpb/95O76fEQC/uEly3dhXBDuAjtSVxWTBGEBh2jd200k0Opplp
 KMbp1Z8ZI79H0LhrzmBP63ioxwSD/p9iH3p4JrF9ViTMJqihV6lEgV5l3mFLShKqOqDY
 czHkNh3ZQqSCHtDOE38u03g+mQlGHiueOQL8YpNpD04PVvv+jp4I1KVCV5ydZFmqwqau
 LNhHdJpaA2vJ9XkSeAcvyfF4WqlgdDY6QUPcUs1hUR18ZtL4XBSyJD1Gg4MVgVaswS0P
 2TMkH1LwCnfqJYp48PWy+973+Q0tdigHSJmZyrP73cuuSnADy+Tr0QvorZHXN5QTtJKi /Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdktpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKR0p4021624;
        Mon, 12 Jun 2023 20:40:52 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm39c65-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKF6wY6ILXkMeTmyyaIeRFt4uwDmOpChldnHhNPODbbasXE9NAtNvHOCEPyLKn9ESteBLSwiLP7YhoKa1+nO6eBWyM76Y1A8sWxEkELRrBnl61T8dEhuQaPyd7cggxE8vzoLCdWjw/ld8zuoeaO0+g4zT1jmTwtCPsIxVqVMD2FT1RT6Wsb66uB1v7ndQ2bDDLFyweILPbnVdB4RGomiQ33USiatuLMMnv9E+fLvQKrUmxkF0xZfojyVqlmaUh3e8fGfvbgMUSiYy65Wmm1aQly9wHlY+QU4AJ/rTpIvJYL1JQa5umWD0H57wifE2MR91P9AMV9R12Tts/i8gPkzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=812rbvUohctb//QCwvvGnF0ZAjJWMAJsWaUHeAI/wzk=;
 b=VgjtiyCqSc8DIXK0EldBzPHYt4q29NvT4XQ3rtQmijusqOi4rYXBR/9vtKB4RGLREUnrSkxOUttrqkfnXxhz/7nyMN9iF1aqGTGTEPAGjzcbJo3F3r/f8Wkl5IlQPc0ONmlqwk539uEg/ldr/YXn1JrI8wlppxY22brnhnl1Dv5mO8iLdtT7tTZdtyuPnzOZWcqcTNOE+9DREy0sJXvtT3kYxN1fp2ywlGM42QhJIUJckJEpjczQUIpgfveiumJxVUpZwL70YtC/M6i06k+nvyJfCmw/MTgEkY2bTfHvtZ0AznSKDZd4YweohfOhtvwr9mNmmTUBe+T8aV+597pg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=812rbvUohctb//QCwvvGnF0ZAjJWMAJsWaUHeAI/wzk=;
 b=X7U0VqMyocJ6a+bcXxXYOdz0qx63aLqJiu9Yleeqtzj8sSDdF+spwVh6zhOlO+G/XhmeyNzoETK1+XrN56PIR8bIa3T1GgwQbzHXNVFC7Hji4gccKuxnWc9mGBLmymk/hW0sFgbUgBFaVSOwGYQ9FHrnJYdv6XXsIY8uuSL3Ibs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 20:40:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:40:42 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 16/16] mm/mmap: Change vma iteration order in do_vmi_align_munmap()
Date:   Mon, 12 Jun 2023 16:39:53 -0400
Message-Id: <20230612203953.2093911-17-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0028.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: a22e2463-e62f-4ef2-f88b-08db6b854997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajrkXY7ufebPtkPAEKfKk2q7fe+eKjeiMiBluaMJkqRwFg2/jHyFQEudgZnpiEsohX+a/RLjr6gZqBFdLds8o2a49GIMM/e7t2Pgot6yEBCHw4En0+Jf8i0IB+x67sc19CWwIOoOte0r6Bm+AXNnxPxcjpqZSpzXklm2qUY9vEziln9hFtQwch2BbcrquWa5wvvFYiPB0Uvd2OfDn2x9gc+B3UAeY8wiN6NutWKcF7R6VtUFoxjFD31w5kUVOJOkcdO7E5LjAW8qVFLQFY1gauY7i0fQhLb6ePRSfwOZ1gCqd9CUZy2NsoYEda8rqRYznHnr1lnVhxuy2cx330c69pCTtpagN8ahPComkPQQ6m3EVXgYKy1ukPhp2h6oGJWOe+Fh485H+1JNFhc7rK6La1PXhiHsAmFenWV/A+53zidCNGnpnL2EPWWSVhtCMxQtOe6hQ+6sdTGhJsaC6rkkzDom25bzHrKr6fm6jLVGzU0iLLJMOH2n326pF+rN78QGQ5rjUGM/V+4K6PgGYwn9ce4KQgsicTqyGnqLcm853R6dSmP0o9w8F/BVpzj3z08k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199021)(36756003)(2906002)(86362001)(107886003)(6666004)(186003)(6486002)(83380400001)(6506007)(1076003)(6512007)(5660300002)(26005)(478600001)(54906003)(66946007)(316002)(66556008)(2616005)(4326008)(6916009)(66476007)(41300700001)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D5/K+elI/uoJuvGgIF53tKD+twjxB0jgcyIk/rnSLFBmEnLbkSWLHvB4FDLe?=
 =?us-ascii?Q?un5RaDFBejE338mudjVx6P9k0SheMktfOZkAzQTA8xBglQrA7VlPCF3VBhii?=
 =?us-ascii?Q?b3Q3gc6DqLt+pOiKEaXD4/5g3RA16vMrivSFUs8TfhMjMJ7ckTSLW1rqB1uJ?=
 =?us-ascii?Q?x9HN0tQThMyDJKy0i2vYleFxhEtu1G5o1fUM5qGu8NFx+5jAzPggfcPfXHo5?=
 =?us-ascii?Q?dPsDPSzRvRRU1NGv7SFHMO71N/7DzHm/oWkpepBBDnnrDf88t/PEpbG4A67Y?=
 =?us-ascii?Q?Wa9GdBNQnxZh/uAIZWGmQQLMyM4AP3jBIG5XR5Hes5phbiJTgohT0bWfR9CW?=
 =?us-ascii?Q?QjysPnS4SMmtjGvYqGVWqZYVK8wzjJZGs2W+iDx9Nmd0s0KsmAab2ZABxzHp?=
 =?us-ascii?Q?MXXK+Js6wIEVvf50xFb8v0zUS955UaV3NwHK7xBbGCqyuNg+sP09R4Sl/7Qn?=
 =?us-ascii?Q?aPJYxF/3MpDNuzDsrcG38hPfUBb6iIiBsItyfMG7DLAI1BXkTCNZSpZAzfXZ?=
 =?us-ascii?Q?WspBo1yndeCFA0R+6UPYsPse0YVZWM5P7PaPPzzgQscL4yOOFiT0StwMm2oO?=
 =?us-ascii?Q?Uv5Hrw5AQk6pmIk8bHFPSbiVl8ncJjgjsG4JMN5M5my3bd9gO6KwlW6Hsm6D?=
 =?us-ascii?Q?xK9yIUUl7ZjvDMDbDO+o8jz0wuflinqtVqP+USe18VkjL55m7cwbEgs0m3tO?=
 =?us-ascii?Q?kGtm9zQ8Y3WT3lNien/xU9dOq7E8NPGFwKAPSW6nwJ+k7hTGS/nssc0wUT6R?=
 =?us-ascii?Q?rGBnuTkLH5BT+kip/O+YAouB7MxspzA63fQPy/mg4yyLplEuYbdmun6zJaXE?=
 =?us-ascii?Q?4JK3QZ642fki7ot78dmeINOuazSMGbnEDaqGUeqRw0I5TfCZwe48LRxXqNUb?=
 =?us-ascii?Q?/qvyovNg9FChC++cWB0tmKJXSkLhp5YrX9dVLWcBfzpmSblFoNQZEBtKP8VC?=
 =?us-ascii?Q?Snj3vfXYYK4SgXyxPkacRVxRVpRAJm9JYBeIrv2Up+YmMuihKXyNtzpJ3Xqn?=
 =?us-ascii?Q?VMbBcBeTwNVAmXInm8NdMMSb3rwfEGbMKQAiz4h48bqlNq2Y+csAvI1WclwM?=
 =?us-ascii?Q?YUKJMiANW1Q5S8+CEOhwu5kdtsz+vk1l2TvGdFVdhmfQqJkKJE+/fkjZBzOH?=
 =?us-ascii?Q?HmibQF2wrwRD/Z5TNtfbELjMlvt5IgEAxg8UWo8p4vpsTqeq0RYmd7gwUBIz?=
 =?us-ascii?Q?ACRbYhD7lValJgpVlxpHc6x2jolpjgJzD1Hu8b6jlSGJVPKdDDFDK6ZxKECT?=
 =?us-ascii?Q?kscFqpFxBK+J3bG4x8Uu4qSyPBug3+xQFSiYmZscCBoPjiVYKOfES70ewy0m?=
 =?us-ascii?Q?GoYZQTCJFiMiporaNbpP64EV0q/JAF8HYGWlTn9KdVvTZcRmOuKrR4Orx+bK?=
 =?us-ascii?Q?iSVAT47xJn7mXCtmCICQ8BKXlvNzPlIQ+XA7xlI7XbJKKwvdXE6X2UA5u+0K?=
 =?us-ascii?Q?Fxf93AeWqc+TPj0dd27OtH8l4cRB+Xh50mWWb9+LnI01c1pmwCxNKkriDi6p?=
 =?us-ascii?Q?hOpo3E4nPGmiKqG7tVSZTeYvGQkIOtmALX43YhzWsL9VU1VP/AFwIZigJzbb?=
 =?us-ascii?Q?1tZqmMzBrclwwT/RC/MqePq1Q1FD1/ds34+cdjarVMqtThbAHZA+hDQcMUA5?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vK84EYEmglryW+1HqIjEEolSN579k6foMT7nd9jCjqgJB9GPb0/CdwutGlc4?=
 =?us-ascii?Q?eJeUZPsMqIHXlgtzRiUPhv29p0ulsn7L7HMMwb6yumVKTV9xqvGjbgkz08EB?=
 =?us-ascii?Q?18Wg1M7CGWKQKFt0TPMt19h/eg++wZXVimuhQai+zd4tJqR0rvwyUuPDPiSE?=
 =?us-ascii?Q?FjlVSlZps+mLfa3aXweMVo/iY6yPRBS43Mma8yehcXFK1QGikw8uZp33wMJz?=
 =?us-ascii?Q?ClvFJmGuShomPQ+vorNqqQZVRr3tCOHCn/+XnHnNetU2eCJcri8WgA6iCvVI?=
 =?us-ascii?Q?8VBWfjTYqAQdcaR6KRGIHGZmeomHv4Xg8TbIWazaKxz6Qw+cgmu3NlDcdysx?=
 =?us-ascii?Q?sIVnK6bpYPGAPKacEK7kPQZ+PlsGXL1Ek9M1/XYlmrm0mIHyzZ9oEldzOZNM?=
 =?us-ascii?Q?Xaix5vV0LnyqrGYIU1vZekqMOy/lL0YSv8/XSwXcwFfYtSWtARbxOoRF31iC?=
 =?us-ascii?Q?YRMK2MXUU3CbD5io+FFhXBcZvj74C+vqCdwoBFUVwD/FWYXDTHSRB5+l7uJl?=
 =?us-ascii?Q?JyHPVN/U83z24m1ffh2L8scm46WG1jxLZKZo0emwKXcK2ZIdQ15zH8JtJMN8?=
 =?us-ascii?Q?g2JuDqi0Wp7Bmd+JIgaiq4GeIpnIg5gxpN9mQMPKHfOimVRCMNANRMGqYwTJ?=
 =?us-ascii?Q?dw0xob2ViLCi3vj3H0F0lWnf8mgoDGchBL0rZTwA1mwdMKbBJQ7ZGd+ETKkW?=
 =?us-ascii?Q?r16nFi/JWiQfmu+aJNhFdiYwNSNTin/TBseWTEIg7DQZWy3bGZVA7PDpeNbx?=
 =?us-ascii?Q?OVt8xjCnpBD4v/DxAygWDej2c/bLTZtb3VCOSqZoxa9/uSGPFo/jheSSEvnJ?=
 =?us-ascii?Q?+KGjDevJzOl0CttmumGayJnGuVvbSD+Bf/ZnJZ26WskLHwowWcZBULlRWKBz?=
 =?us-ascii?Q?5wZ3VfgE6SZAwLQKTRyqHTMqXoKfOuGXelDHVzZjOvoStaJHmqeAyig+Phac?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22e2463-e62f-4ef2-f88b-08db6b854997
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:40:41.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLoFxd6rh+kklvruj3Dt3NVUMOV2tWLsgGfQSl0iA1Pan1LZlt5k5QO3UjD45KwODgwWiEp9hxC/RCP8w+4ZXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120176
X-Proofpoint-ORIG-GUID: -gCFoqguXGeI4YRTcMvAT156oovPWVtg
X-Proofpoint-GUID: -gCFoqguXGeI4YRTcMvAT156oovPWVtg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By delaying the setting of prev/next VMA until after the write of NULL,
the probability of the prev/next VMA already being in the CPU cache is
significantly increased, especially for larger munmap operations.  It
also means that prev/next will be loaded closer to when they are used.

This has the consequence of needing to change the for_each() to a do {}
for_each() when writing to the side tree.

Since prev will be set later in the function, it is better to reverse
the splitting direction of the start VMA (modify the new_below argument
to __split_vma).

Using the vma_iter_prev_range() to walk back to the correct location in
the tree will, on the most part, mean walking within the CPU cache.
Usually, this is two steps vs a node reset and a tree re-walk.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index eaebcc8f60d2..429e314bd134 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2395,20 +2395,17 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
-		error = __split_vma(vmi, vma, start, 0);
+		error = __split_vma(vmi, vma, start, 1);
 		if (error)
 			goto start_split_failed;
-
-		vma = vma_iter_load(vmi);
 	}
 
-	prev = vma_prev(vmi);
-
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	for_each_vma_range(*vmi, next, end) {
+	next = vma;
+	do {
 		/* Does it split the end? */
 		if (next->vm_end > end) {
 			error = __split_vma(vmi, next, end, 0);
@@ -2440,13 +2437,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		BUG_ON(next->vm_start < start);
 		BUG_ON(next->vm_start > end);
 #endif
-	}
-
-	if (vma_iter_end(vmi) > end)
-		next = vma_iter_load(vmi);
-
-	if (!next)
-		next = vma_next(vmi);
+	} for_each_vma_range(*vmi, next, end);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
@@ -2467,12 +2458,18 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		BUG_ON(count != test_count);
 	}
 #endif
-	/* Point of no return */
-	vma_iter_set(vmi, start);
+	while (vma_iter_addr(vmi) > start)
+		vma_iter_prev_range(vmi);
+
 	if (vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL))
 		return -ENOMEM;
 
 	mm->map_count -= count;
+	prev = vma_iter_prev_range(vmi);
+	next = vma_next(vmi);
+	if (next)
+		vma_iter_prev_range(vmi);
+
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
 	 * VM_GROWSUP VMA. Such VMAs can change their size under
-- 
2.39.2

