Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B696265C9A7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 23:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbjACW2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 17:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbjACW2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 17:28:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072AC19C1C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 14:25:22 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303JnEwI002560;
        Tue, 3 Jan 2023 22:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=FsRXgnzO5AUwB3/nkbViM2poWP12RoxCGgyRVLvwzUE=;
 b=EMMVXpRDhXjdbmtk+iBA7CbkGU2uP7YwypaPJzAkmalL5u/+x2H+iwHHpXBjLsai1cym
 TQyYSqgnWZvAGoG6vY0rjry0TD/jhUND8UPWw086iDu6FM5n0wpq/dud8czQh8LVNYHj
 dn0Vo4G3khE7KJ9ukkkSiyQ5xRHEsVDFdqsyMyhRmTW+8L7wLU3taQNxAn3/l493lC6r
 WgQyLAmWj8FWgc5K4RJZ18IMBIVenZlClMswOhbdTg/TIXFlWif6f7jtyGSQop4HHbV2
 MVt9L6uis+h2xdGfrhaFG/G/3oeLXdWyO18WwalpadSwCv81pnCyq8fEvDX3FlRe1mtx hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya572r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 22:24:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303MO8GE021620;
        Tue, 3 Jan 2023 22:24:08 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mvw4f000m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 22:24:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJs8ckMO5rsUOEuF3G4pUp5poqJRHsV5jFszqj7LSx1ft3eX2bBuaWgdxkAuP1aLpSVPSZcfR9oTcsF/VudGH6fpNIOnL9sm3uhAdblqxJoPqW5xdhYM9xTuirEhQDtQQw9FecSo2Ets+wfY0lidRw5aeSiEiNyxtYP3OENbnW3oWwilYqACDrx1ySvLg0kABpDgI1DY8mPcBlyLgOAw3Z/QmFGriq5GIxB98UuOSu0uK/gyHtC6daCxHtpnU4FxpTm6QzRCwKf14tUTvdURGEGW6sjBY24/pbiHOsxWt6tqUYwbe3ZBndYoYth8WtjTesWb/6p7nSTQZNrzNfm8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsRXgnzO5AUwB3/nkbViM2poWP12RoxCGgyRVLvwzUE=;
 b=LWPlXZu6u25gE5IartFJvIHKw/oufZ5k0xj4SEaBJ3lHP1AUXc8GDxCNaA/mRvtbmhaQDBnMMiK66EPy/rw+2J2H5WR49t3CP3IysfX2FN5pwDxB6g4hVkymz7PGF7VRl8v2/uk/QJQGlH+zkDe8YQgZotNgLAmjb83Vjd6jLMI4GWZsmE9gDhbHKl0SeeoB+PejbSwGM0xxSpETxFb72n7VxODeTFXcFSmJOAmw1oeO6UQ/vMzOMZcUjeGiKSTjDTy+xKLWCLCqnq13CPoMxXsJqqomR7v/onCHcnJVOE4vhRfFrI8+6XrDVAwHBY1eYPFdMDwMVdEFWfiuDugVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsRXgnzO5AUwB3/nkbViM2poWP12RoxCGgyRVLvwzUE=;
 b=eUokuWsEZVziOsaR8Mt5NWUMqR/vHGO/JjsMwzbgc2M8GQNUjk2lmU0N+1F28Qs0lMTAJJ+Fl4PwP2ziZ5DRPmKe38d7h1RvuOVe3q5GWK8i38f36HVOYu6geuxK5hXG9CW3WmXouJz1TT9hHAnZeEQ6Qo2Ti3ZKXHFwP7SElIY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4427.namprd10.prod.outlook.com (2603:10b6:806:114::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 22:23:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 22:23:56 +0000
Date:   Tue, 3 Jan 2023 14:23:53 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlb: unshare some PMDs when splitting VMAs
Message-ID: <Y7Sq+Rs9cpSaHZSk@monkey>
References: <20230101230042.244286-1-jthoughton@google.com>
 <Y7SA839SDcpf+Ll0@monkey>
 <CADrL8HVeOkj0QH5VZZbRzybNE8CG-tEGFshnA+bG9nMgcWtBSg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HVeOkj0QH5VZZbRzybNE8CG-tEGFshnA+bG9nMgcWtBSg@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:303:8c::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: 6182dd10-4a92-449c-af9b-08daedd933d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZU8+L81TqvAazuFaGtru4xOyOomHYAYFe3VWjh8lHHyP8kaTHoGP4LmVn7SPZZYDdmoJoV/YUtspsmEZNnT45LekmEWVw9SXFNGzgvhlyvqdn7xfuePC1JHFrLvtMQmIchSsbHbPV38AFpGl7yHOktUVsDzAFLlOtkd7wSBtyp/OiMybPDjP3Hprrutt52CYwuXGCQDPvIMdXTPAWHkF1ryOKX3j3jNHKCPnXoGTUsKMQsYOJDJuM9npDA7sOnCckQ2rZ5Dvc6jfAVYevOFVOHpjpcnevPeHmVzDKhx0V4OjbfCL1d4cd7KcLFZhsjZ+V94Inle/ElcuZDWf3ZWjm9Jsyv6cxP3/AnfaMRONl0om/rIQdIRFVEHcp+dWdEofdDz2PVHfZK/TUN1l8RSYtzScDSb5o+dwLVpu6sdBNvHg8fzbOn/smlb2K//6IbQF6TC8dcXN/vxVx5mXoJ5ECh2OekJN7gQigE13qzXKvnWgV+2V1ABdNhbEO//8ameHJE7DWYAIvdNa2vBZ2jsoBPHFsCkAHNP5x/IAkxfGxIdbIyZtLvXOBarKpXp6YUsLU8bHSjd3ioWs2+ojJP/XDtpK0y7Se36KD42jvQaKpyO6JMpGDF5HncwPv7B9XM95owkB209JneANauvIcDBm9hVUIyhJzDEeAcWFO7QLY87YzSo3U+emfJfHro+J9rrzWvwMpBGPnJRJ025WxEntA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(83380400001)(6512007)(26005)(9686003)(53546011)(6666004)(33716001)(6506007)(86362001)(38100700002)(186003)(478600001)(41300700001)(8676002)(4326008)(66899015)(2906002)(5660300002)(8936002)(44832011)(6486002)(66556008)(66946007)(66476007)(316002)(54906003)(6916009)(22166009)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nkwGJSiqrWuIrOpJXpRL/UM1uaIyJwAlx1mMjrqQhAZOtq/9CxOGhufIbpcU?=
 =?us-ascii?Q?Fyy32JBlZaWTJhzouuMnGYqdDZ3yCi8PkM1cul6IPdO4bTzU0L7xDjCDlPS7?=
 =?us-ascii?Q?mM5XHCFqby6Qd8pgHIN2FDbhwAmkidUX8dBCghYURV8U7XDmBJ90DxNfp9ow?=
 =?us-ascii?Q?QLZIgkOl5nqyNGs9dr0y6rbTZmDI8AeGPl+lv4uuPJeyreE6VClJUtq9YUJX?=
 =?us-ascii?Q?FwrFMyqcQls53WuqQcAClMW1Ms6hva/QnprLHsStaAm34psV0vV62g/C5ved?=
 =?us-ascii?Q?JUw1YwKq8KvEFpwVFJciMLXj6XB8hw7WIieP4FhbsOZQcGoP2th4Q8HWp8Lu?=
 =?us-ascii?Q?qk5ooKwAxWVSmfm4TEKVOuuJFkQnv7QttMue286izG2Rq6yQy7SS/Yv7j0QU?=
 =?us-ascii?Q?KqH9a1eGUd9YMaSlhlSPdqOM1/TgOX+l2xylgZuBs5yv6x2pDwr6O2aoIM1u?=
 =?us-ascii?Q?cOwOSmOXbbhjfdGpSCwrh5uVe2PBG6yNv9hbKqR7EsClmKuJI+t1JP2KNwsK?=
 =?us-ascii?Q?rKI59IZKAGk7Dja6XsZHpqpzJGLapu6i9RgAn9mLxoqY1WG89Rx0XtwBf5Q1?=
 =?us-ascii?Q?/ieGqcl5TyYQ46WTFj90jSbJpJUcjWM7yP6XiwAyv6/FKIYSra+eAAE87WdP?=
 =?us-ascii?Q?XPx19Hr2xB++Ss5VNntmfOWcIqrXhAIQWtKFcl/IcaCp3aHXxj8PxAkt5t8W?=
 =?us-ascii?Q?Cf/+zF62faWbCYtRNx4kwww30SBjfxLLjK98wvP2wwMq2AdaGCC4GUuuGcdR?=
 =?us-ascii?Q?UI6wK3Dr2TmxZE7AtXlHQgHAAa3Sh6KcorIYhw/CS//GfkGb8jgwEyyT1+b0?=
 =?us-ascii?Q?GZF1O5X1nyrLJJhXmwEjIOPRTYnfOvi7ffpK+o5yzQNKKvw0n0jDrqA1t+fk?=
 =?us-ascii?Q?Iwj24C/NZACubN+MQGBpIDLZSLzjtRZYAOzANez/paz5/0h0sC+/wFr8Ure9?=
 =?us-ascii?Q?gmYaQF8UPqQZRmr8F8vhX5UR6heoEN+V2d+dFW2VpWVt5NfJF5ZuZQUL6eDM?=
 =?us-ascii?Q?JrKvexr4fhBDc0FFl3QRmtQTwZpsJEC8b/dEPJTpImQqcWwMf0WyH13QwO3h?=
 =?us-ascii?Q?e5abPB57UmLzL7G5CpPzTCUnxugE6zVFF/jGjv8lm8wGXrwYNMAi+E83iGDo?=
 =?us-ascii?Q?fTeRmopk5AppL79PH5ECSOJjQWtC/QPKW5n0PmbJajP9q8tpdPQaQYsU9TxE?=
 =?us-ascii?Q?W741E9BFd/LmdumLIajZhPs3Y5u5c9PspAKjilb2YKu9btSlziLCwnLHW1No?=
 =?us-ascii?Q?4icRERA+jmJWSJ1ZoWbClD8K2rK1wnQ9CkjC3Vctz6ji9R1QGj1UTllbbDOD?=
 =?us-ascii?Q?PkY2XmxdTHCRRbF7maPQXukKLpqxzF4aPJWHYguUQg74WaUijQPQfNvjUDpi?=
 =?us-ascii?Q?GqvlBwWNQXnq8+hgl8jzuskj0Eh4zSmMr//jpVm3IuzJYw+QJkEZJyeJPop6?=
 =?us-ascii?Q?efu5FLPOcOEANb6e8tCJTNWXdWJweB9ki9J7FyctDtUBYuvAJDs9y9gFOgK7?=
 =?us-ascii?Q?N1DIsrhrf36jGLPR6GcVuOT8dPZX5nPVwEpIqJPo+dYHNzNiHZcGOEmga2da?=
 =?us-ascii?Q?RqT1ECbt30vhTdvgDsPBRZfKLDDRANBDEY+SsurBVZBQRNzi0t9hXUIJaME/?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Nvr6wwKjf3SeuLnOIAYGStcoPoJ1pwJb+HrIR0Kh80k7obumbE+VjT8GGqFV?=
 =?us-ascii?Q?U+a0MlhzL/YXw3Df7BKeDuFA9gb7P9yW6lwmAcvw3AQ/bN2SLkQrCG63vtAl?=
 =?us-ascii?Q?bNpEKS1TQTvnjDtIlDSM4FroMLpLi6k8OoRw3TfjOvVfPtz9OAU1MElpEjkA?=
 =?us-ascii?Q?VjJovOqt+oa+tWCFsJNzpyPKIIjhB4dhWtdygLY2ob2R3K2/YU5B9JQqowhi?=
 =?us-ascii?Q?fmVZZPSbZDbtGVrnOW30+hJGnHzgH+3ti69o8ye0kP3n+MogNIquIwWNPU09?=
 =?us-ascii?Q?kGyCOWJOUrl6F0uA2cfGEoIfjhXHbAF7yHipsSAReuRC6aIorNb2XXfIHX6T?=
 =?us-ascii?Q?aYP3q2xkkz229wW1tDPlZrj40/XNDwfB2jf9hUBwxOy9+yOS63xMtA4Iyqhr?=
 =?us-ascii?Q?IsCAQs95hCssBCFlpEwS418HFPjRsjEmqSMYuHwpRifbP5ZM67bO85O/O/Or?=
 =?us-ascii?Q?qHhh5xL8O2Lbog0Fsdv3M3zHrl5niaE1DZqpubB28a0sJRJjVH7MjJO7FaMO?=
 =?us-ascii?Q?WNS3YY1EoLTuB6sm6CNEW6/1W3IWfN9+KJ5YJEEbU3/Vl75owzCWAmPNT02H?=
 =?us-ascii?Q?s2/LodfzrJYU5WSoiLja657/wJSzqm6kLeo6uCUEGdo7BYkDxUfi3a0uymKn?=
 =?us-ascii?Q?SpxpajsvAw8eo96CCkruY2TUHnDuemASiWb3pGDTuTseSJVc/b5NO/S6NgIQ?=
 =?us-ascii?Q?v/FhPFxrTZyqJNa1FR+0PT3nP1Ej4qi2YQPYghi611+GTdaSqsJE5VhBC/EQ?=
 =?us-ascii?Q?3Gow7WWRMh0tkzLYBr+nNaZ2EyhdD0Ma5GvI56No2IzyvZW4rofDHZCQsHas?=
 =?us-ascii?Q?sTB1xJz9OgMoSCy5EhnZB6V0DAD7Jk+UsZzxjfkXcVvPumr3v4GubW9LlQS9?=
 =?us-ascii?Q?53FWcSn6SgHuOuMfWXOqaLgJixX0z15YN/gj1MjSFyY7O8udrt7l3ItTZYA3?=
 =?us-ascii?Q?kWkWNGWp5jvaT7D88ZdEQQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6182dd10-4a92-449c-af9b-08daedd933d7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 22:23:56.3243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STiMMNRBF+1mE/1OfdKCYJypJb62KxTz1bmmfP1RqZR0sgLK7kYLxjEGmZODHdPL6uyoBl4pRMq80DTmXTOGwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=890 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030189
X-Proofpoint-ORIG-GUID: ykMAPm4PnImqHY9lv0q1gy9wSta0iAjd
X-Proofpoint-GUID: ykMAPm4PnImqHY9lv0q1gy9wSta0iAjd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/23 20:26, James Houghton wrote:
> > Thanks James.  I am just trying to determine if we may have any issues/bugs/
> > undesired behavior based on this today.  Consider the cases mentioned above:
> > mbind - I do not think this would cause any user visible issues.  mbind is
> >         only dealing with newly allocated pages.  We do not unshare as the
> >         result of a mbind call today.
> > madvise(MADV_DONTDUMP) - It looks like this results in a flag (VM_DONTDUMP)
> >         being set on the vma.  So, I do not believe sharing page tables
> >         would cause any user visible issue.
> >
> > One somewhat strange things about two vmas after split sharing a PMD is
> > that operations on one VMA can impact the other.  For example, suppose
> > A VMA split via mbind happens.  Then later, mprotect is done on one of
> > the VMAs in the range that is shared.  That would result in the area being
> > unshared in both VMAs.  So, the 'other' vma could see minor faults after
> > the mprotect.
> >
> > Just curious if you (or anyone) knows of a user visible issue caused by this
> > today.  Trying to determine if we need a Fixes: tag.
> 
> I think I've come up with one... :) It only took many many hours of
> staring at code to come up with:
> 
> 1. Fault in PUD_SIZE-aligned hugetlb mapping
> 2. fork() (to actually share the PMDs)
> Erm, I mean: mmap(), then fork(), then fault in both processes.
> 3. Split VMA with MADV_DONTDUMP
> 4. Register the lower piece of the newly split VMA with
> UFFDIO_REGISTER_MODE_WRITEPROTECT (this will call
> hugetlb_unshare_all_pmds, but it will not attempt to unshare in the
> unaligned bits now)
> 5. Now calling UFFDIO_WRITEPROTECT will drop into
> hugetlb_change_protection and succeed in unsharing. That will hit the
> WARN_ON_ONCE and *not write-protect anything*.
> 
> I'll see if I can confirm that this is indeed possible and send a
> repro if it is.

I think your analysis above is correct.  The key being the failure to unshare
in the non-PUD_SIZE vma after the split.

To me, the fact it was somewhat difficult to come up with this scenario is an
argument what we should just unshare at split time as you propose.  Who
knows what other issues may exist.

> 60dfaad65a ("mm/hugetlb: allow uffd wr-protect none ptes") is the
> commit that introduced the WARN_ON_ONCE; perhaps it's a good choice
> for a Fixes: tag (if above is indeed true).

If the key issue in your above scenario is indeed the failure of
hugetlb_unshare_all_pmds in the non-PUD_SIZE vma, then perhaps we tag?

6dfeaff93be1 ("hugetlb/userfaultfd: unshare all pmds for hugetlbfs when
register wp")

-- 
Mike Kravetz
