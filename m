Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1006B9CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjCNR15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCNR1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:27:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C059A2241
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:27:53 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EFNpmG017817;
        Tue, 14 Mar 2023 17:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=4J6MyjVsbZHmLIGkcEN4B5HmAuDSoBUJCaVm+EoeJDQ=;
 b=ll5Gkkg0tCVO/PSvxe+r6VGA10kU9RR1hh0uSoDaAcdbng02RR1Yp4lhnwsST1OCxk3k
 PTohWlzpk6cIL/17Pw+vFYbnBi+RpQDqmdmlWnJC+Di0R0QVYBFpywX0v270wo1QVsZO
 R8ntvjnBoVuQiE04IzjqrlKUTZBpIvWK+06Gh4lgfJHUuEmYpbI20Lm4DPNPpXYSKSqE
 O9Wq9f7KNntOvMH+y3tsMTzzUP4L29BmwH9BfPYqoLBOGdyr/1c+cbLP4TurKEABg3D7
 d2WlXyZP8//7vK0PJsA3SnDmKSblmYARGf+siYbkMM1pOw1sb98td5xg/1BQN8v0Db+X xQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hpcy2ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 17:27:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32EHOHfC033330;
        Tue, 14 Mar 2023 17:27:31 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g36drrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 17:27:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ky8f9818gP+jmZuhk0Hdytoi+440vjk/vM6+AutVTQvFJGcJpQu0AHD1tJzjzZfUM5X6UfO+MS3d0qVn3eALMAbOgUmF0SCccfixPA9BnT3u1eN25wK0Av3m4PkXtSmCk5Qo4GIhzZiJkNaoSZFZbbGAnePd+8Q/je2hWc9Syrg2ZEcgdgIlKKAZviI5+UXQZFXnWUzy1FSMDzupHAi4CQaU8Y7ACXCupWhsqQjZg+rAYSaeI/CCaPGz3MBnbn/0p3Y/39bDl7O158ILzFEuuAAp2Vtj9qW/1Dhln1RPfhEzGt/JUH6Q7dSw16eiMcwHghWmSZClXIzK+SmSNBTunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J6MyjVsbZHmLIGkcEN4B5HmAuDSoBUJCaVm+EoeJDQ=;
 b=RREBQhdxpEOEJ3AkJULpr/oLgUrwi7lL3X1oDEVxqAMZHn1o/zo6i4x49oUFg8uOdVI4q5ENDGvOcsZ0BNXcRiNu4BRJCcHC51MhjIcyNZOl5ITypySsYVyRyDJQuRxx70ahZrp9r+Jhu93du1L9m6/EhKHitIpZdOXpLh8QY/ReWdDifNN8kA6Qp4UiuMKGPlRxhgR94IQoHPTfVmHI3Vl8RL/gvVuhRlJ39ZOZ25nROeyV9m6bo77VGAwFPYWrQ8Or3u8RTHHaxFdhC4JS26ZHTyVHz371+AEKWCvxtUA06KM3GQhlfAlr4natKnAc2mD/QyL35Pj7IO0SeMhTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J6MyjVsbZHmLIGkcEN4B5HmAuDSoBUJCaVm+EoeJDQ=;
 b=jWasXy97T4DzdyzPIj3C607SSLuEqZ+jPvRNbLUYmO+U65lcgb2Bu5WTDGplfaPFxFPKLkOiC1IHvQV2P05jel+tRn8FUQ0iRBHt7IaIz6kY4Fro0MGPWoazn3H2lkhsBBxvrHZ1kgDqPIYZgWlX81hhikYzMiu+EPLHaX1Z5cs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB4267.namprd10.prod.outlook.com (2603:10b6:5:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 17:27:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 17:27:28 +0000
Date:   Tue, 14 Mar 2023 10:27:25 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        osalvador@suse.de, vbabka@suse.cz, william.lam@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: compaction: fix the possible deadlock when
 isolating hugetlb pages
Message-ID: <20230314172725.GA4769@monkey>
References: <1bc1c955b03603c4e14f56dfbbef9f637f18dbbd.1678703534.git.baolin.wang@linux.alibaba.com>
 <a24a86fbae09711e61dc4424aa7aebff718e9995.1678703534.git.baolin.wang@linux.alibaba.com>
 <20230313170838.GA3044@monkey>
 <db50d82c-07f1-6a87-6960-7810c54f8093@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db50d82c-07f1-6a87-6960-7810c54f8093@linux.alibaba.com>
X-ClientProxiedBy: MW4PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:303:85::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM6PR10MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d3ac0e-981f-4cc0-f992-08db24b16280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HhPom1tQO3P8GCNTUaya2SaPmjBNJsF1SzXGAHF/FssmXcQ/H6r+m9fQ8oyw9ayOK4uwvxX2E2Kv48KWyJyY75AQO6GnVDSPz/DvUzm/tYzx598+DQ/0MHb9OSvcXqOiFQTcDZT8KdIUDLC29C6RSzuT6i7JaUb8k+NGBj3JU8t2WSs/Bqy+6WM1V+gUVfAlZN3DKN8hE1QdRVxLBh05dxXXuPHGIpds9tr991NdwdjYqPmvUt7Q77rWfndsqvD3/8ytq/djo2eUDMVr3vksEWKiy949AnPM0X1JNXm8Sos7Uf9cRapNcK2/oPy5xMNkNBJk+55J8B2j8n2ErPbJjKoY3uBMJ5CJAvj+nzO4WLnfioc1PBHdr0hECeS9EgSzT6kvlV+TQsqBbhchREwdHkA18Y+5dH4QfnwayjyM1lizc5tRTmILk4SuZJI114hJOlXmaXXjm6Is5yKhfZDu3XojGFzJS29AC8K2Bqw12q935kzW1aObamgirWQiEHjqFTFog9un5sKTZ9/GoESFZOAijrhciOTuGyNKeQbHp7A1E4gqAvVU3ehb6mdoaxX/hctYmAbK22b7pcwXw4S0aH3J1Ctm+3yJxngYsd7FQDn8C5wbN1YkWDrNoZPkaSpAxefzkMUlpfAUgvfNKAqtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199018)(38100700002)(6666004)(316002)(33656002)(86362001)(53546011)(83380400001)(186003)(1076003)(6512007)(6506007)(26005)(9686003)(33716001)(5660300002)(478600001)(6486002)(2906002)(41300700001)(66556008)(4744005)(44832011)(8936002)(6916009)(4326008)(8676002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rOowb9mhhv/lRjSShOdMZwt722afUUUizWHfo1kLyfT50dUfESgXpjeoM7OO?=
 =?us-ascii?Q?woe3+cxiShfinilPJSqEqeWtpHRd5+ggAcCLj3Kp+RvW/JlAR0PPPfcS7dZw?=
 =?us-ascii?Q?O0YTCwQ+Hlp+dtum/U9NmruGmotkEIGepDb0BWAdsPfB3xaBKuKpODJidNVD?=
 =?us-ascii?Q?50MGUiOTfy/zLnXQgGHiH/O9aEwuKjEif4hb0pKyVJV7eb+63ZPmg5m5QKpM?=
 =?us-ascii?Q?icGa5ZTzfrCsq/wo7fdocZhsrZDsgUgaxrF5mtesKn3Xdk0T3Uig0W/mdY1b?=
 =?us-ascii?Q?hXKHFIkHF4xvImitOkcQVP62QFPZ1mxD9yIsQVApzWMA5mivUjvKA84N0NMO?=
 =?us-ascii?Q?8FqbM6MJukvlwp74JaAt26/HGGxk+D0agqQ6E3pgtmsMR346bwSOApUzQRL9?=
 =?us-ascii?Q?JihdSdepSCAEK27+cpVjsy5qjIIt4D1s2R7hJ3XySkdFPwa4QVZOlVqwjwkB?=
 =?us-ascii?Q?qjKHL+X32EKciHBa/A546UoQPnPnqkts55I2/o4GASoGSxVEkH8K0yHsW9I9?=
 =?us-ascii?Q?dSR4imMgQbvQePN+qrmjUjJ1lG+0rpGV0azlj4hxw/g3iCgWSqJ+FhqujPQJ?=
 =?us-ascii?Q?oFvl9m9E1fW9EUyANKxhpBdjj1edKof/oIxSNbwM4zESX/H6SpFpeOo0jtD9?=
 =?us-ascii?Q?FDmbprZmq8exg5LTYffUw8t/LPYM5/Y7lyKTWN6VFH/kvEbz8JKVLIhEh9OP?=
 =?us-ascii?Q?OvqJWXpe58z+q0jW0Adki+BU4g4ClZtPY9uQK7RMgwQ4gpCu/dDox6F+A9cI?=
 =?us-ascii?Q?DiL+G6lpjzgIv1yaTCd+wSsRZz5+Xio3HwSc9yBem+C4GpEWxl14Wtwzmdb3?=
 =?us-ascii?Q?k6bPn6PAmxuxFfxAuNCX0jbe7ps0A5oVAbmoZ7+5IDP2Ypyr63AjlQ0OOvw+?=
 =?us-ascii?Q?5K3N+JzQgpNxbnvnIEBWfgKvAhNm9k+hwFVWlrOx2E5YDbmtxyCaHg9HkjAA?=
 =?us-ascii?Q?NGwe/wtqUH862krDzD4Dd7IxF5H1MnMh9mIrAy58pvwxrohxvRdaVCjAHsFx?=
 =?us-ascii?Q?qXFlo9geRKJ9k3qyZ6tYSrvCsD7LI0I258v3DFxyQIFvv+Uobo1pW/oAuSh7?=
 =?us-ascii?Q?WoAbaG1/xjOQPzfMVTFQS2S1H19mXwZ+TfF0mmBFJNiCpF/rR2mD1HL/9dhP?=
 =?us-ascii?Q?ohh85K+gdgAumuHaQWZM9mC0l4lh4Db20q7HRjUh2rgthW5LYfzalJPaff/k?=
 =?us-ascii?Q?lrst+9UzArIOge9PHx3D3XHcZe9Gku2vxtknKCdC96acaz3HP9+ZwwN+/dtd?=
 =?us-ascii?Q?Ulbn722WIHIX75Obfgme4Qvirnr5J5k+XL1mFVb5Qn7cGKQDIxfVT0W6pKjl?=
 =?us-ascii?Q?YmGZzab3qPJHH/bHnRa3LNkcoIkEcwm8yS5JoJJPluL0xz5HFoWbujNgq/M/?=
 =?us-ascii?Q?9mGNWM1c0QY57jJ7DxuO4AkfFN0JU7T+2xp/XrLG2exqRnd6qna/qBWX0iXP?=
 =?us-ascii?Q?d912ZbnuETxRMBvgWe2Op2g++GU6Os14wOrNxZVXxnGahE8mIXYdLQndqrlc?=
 =?us-ascii?Q?ql6dk3DcpzEGP7tSZimDkPEE4SVfw9XITvCJ4fVUoylTrf5uQlJET0KzUYhi?=
 =?us-ascii?Q?PNSRiJK6dK+XvjxKEB+GcrM9SUkkzhqpTamhj09vuM+OO+PJMO9aiMcQx51n?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GZWS181C1ecNdGTZgG9yd3RXWZbwZ3rMcV9H0tHxgKK9a1YLgwflDEJoCcuZ?=
 =?us-ascii?Q?wbYWQgpOqY2q1xq4jTwes0japP9mn9STZC5elgtj3+Y5ROaqHmbxpNKiYvFC?=
 =?us-ascii?Q?WuKuk/cy7tIkQEhNGqCvPhQyl2UArl2k4KKwhn3FfWcsMd61RKbIZt2nkPd5?=
 =?us-ascii?Q?YOxS82dr/zRxFU/LlLkBMMd4Qfkw4bIQKIeHKoSll2yK2ZtEoM5d4NwlFX+q?=
 =?us-ascii?Q?3Nb1QeMJM2iH/Dmfhrkcx46NRWeFm0KqI9As0fdyU42xxiD/0KmpLT3awWbq?=
 =?us-ascii?Q?vARK3CHOUISt5OsZ6pMSMt/Ajbcr/2hj0mx351GdkYhc0fo7rxm6b+NnYE1O?=
 =?us-ascii?Q?afrqTCk/KkqG2xm6fVG1V3s939mLrgyKGV08BMdjmil255c2lUNItRHzuahu?=
 =?us-ascii?Q?qDOI7rtIqSbk8OY18ur07/MfYV2vw2P6PeP0T/fplv7F+6lxeGEiL3nwvpnK?=
 =?us-ascii?Q?aOHbSCe6djYz+7gO/xkIhPGS2y+uByz+Qe+cv2KkcRFPnIvR+RumhFMXN6qR?=
 =?us-ascii?Q?G4bDac13Lbpcl3U7m0y7/6F72SuvKCLA/eMaTvdc+AF8M55U1T+SiTCFGh5d?=
 =?us-ascii?Q?cXImAj/7uj1lIcPqobv1i028aiCRQ98y1bi/Z750uK08ZOt6HQfyyXLSMZze?=
 =?us-ascii?Q?5iTyIF2zZF13utWB9WLdvIIDEkWguxDYt68gTDtlC+K4rJy0q73tsx8RL8eT?=
 =?us-ascii?Q?YnhhkS8bFZEXGJjhxvpkeW9k0UDhwO9OqCHeS106Mu2g3CTv/gZ62I3QlwbM?=
 =?us-ascii?Q?g1xgaCfyolbUqoxWdZUuTbeNQQN/lFHBnDjjEfeNfP/AQVFpjz6BycnsjOB+?=
 =?us-ascii?Q?dp9IJyZbCVKfrVkqJGOPVFDwv4MjfTEOdmTpmDqyhUWGJ9tOIVgd9I0TQb7c?=
 =?us-ascii?Q?voKChRDPgkNG0O3KddPU0OSoq/qgCvSNXPMbaLojVDHbgG5WGzstg77JKQqG?=
 =?us-ascii?Q?vQJ9DZKkhGf1KtvWiNSuhd6w7zZSp3stHeZ1inUIXGZR5kthPs4uGK18vVLm?=
 =?us-ascii?Q?b3IAMoY68iezgh4IOivqu79r/w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d3ac0e-981f-4cc0-f992-08db24b16280
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 17:27:28.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5GG9q20P1MaidsYY/bkMhEf0rFDLaONyTHP+oEY9qac95BULzxINfTpAGfGmFsXIReiF6EtluAgT+tkZxRWpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4267
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_10,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140143
X-Proofpoint-ORIG-GUID: RJGBseoUJoljLLHqhJ6_cgvQ1yj9Uhvl
X-Proofpoint-GUID: RJGBseoUJoljLLHqhJ6_cgvQ1yj9Uhvl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14/23 12:11, Baolin Wang wrote:
> On 3/14/2023 1:08 AM, Mike Kravetz wrote:
> > On 03/13/23 18:37, Baolin Wang wrote:
> > 
> > It would seem that the pfn of a hugetlb page would always be a multiple of
> > COMPACT_CLUSTER_MAX so we would drop the lock.  However, I am not sure if
> > that is ALWAYS true and would prefer something like the code you suggested.
> 
> Well, this is not always true, suppose the CONT-PTE hugetlb on ARM arch,
> which contains 16 contiguous normal pages.
> 

Right.  I keep forgetting about the CONT-* page sizes on arm :(

In any case, I think explicitly dropping the lock as you have done is a
good idea.

Feel free to add,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
