Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDED462C369
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiKPQGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiKPQGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:06:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A9F25C4D;
        Wed, 16 Nov 2022 08:06:33 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGF4G1H024082;
        Wed, 16 Nov 2022 16:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=tUNjPjRwBYG2KbpxMIQbSTvfTvzAACQ3ycFnbwHunMc=;
 b=TomQiDrwMl3iGBzHaHSXiSDeVvZ9vXB2XZJmWVVg1fKfBieMrotLdYkDF2dHzbN7LUvQ
 lLhmSblPatHLuVKUq6S73mI6TvFsaKNfnl5hYkiWM4g3JjW8rwgwT2pUnErYnExjRqCB
 ed8UYWwWCgP8mVbFNnnuZnPw+FROlhPUeaunADQhbLoF1pJfHnJFSZ/DHdadr0VUPaay
 BFiqt3vwLzeisPqOs/qwwQa+UcEOUiRBSm78IVlnwPwu3Grfv0zCOCWhQLhPJ+wGygVi
 LnLqU42PF1EpBgfEd9JRp/ZI9qmNdfo2VMeQ6RYwotGz/bT5wgOJmakuAPsrpltBTD74 PQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3ns5fsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 16:06:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGFUR8q027024;
        Wed, 16 Nov 2022 16:06:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x7km9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 16:06:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyABu6gOWYnMEwGxCp6Qn1PE1q/D/GW8hc8272nQgenhpHtmncfqSjbn2BIyPzjpS6JirqaaIOrlaChO5N3Rn24ku4dTN+N4NKJ/Rv0dQxOHW+xm+0tS6RC/gWlHk7eFxPXxpo9fjrzJfMWXF0qrIHdjvExg4eLDwkigh58+fQPulGk/UyTPSiriwQGfKmDJLdgTmHHrpSrjrrfuHsLnQbeERlZu2BeefVxOtemuL/RtkM+dQNIQcjI8CpT0tzGsHcaEV/820kQ+9hleZRJe27hiqkIPr12/SAEJUBKMu8G/nNwMeKacvh1gYJ8Z1W2rrFMFMGcB09eiO4/FccribA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUNjPjRwBYG2KbpxMIQbSTvfTvzAACQ3ycFnbwHunMc=;
 b=dOeVt6U86TkNV8gDgJsmmwL8aa88IqQ88gFGbDkYB6Z474EhIcF23FY28hF5y3KdXSCqkL1/+QJRuyfub9Uyhnj/0727bxhZfrT/J3Kn5BeigarmuZy1Xaa7w0dBMJro2Z5/CT81rkPgjbQTRWnABFosLu8RZY/3AUescdfPlebXRir9wlJjl+hvsZ67tPuAkal362TVHrxg/JH5LJofy1u0JhF+34dxLbJJNtQskIVIB1vZil2WJQZUPwo3fbq2fuSLHxSqZPFF9h2iSOGKsyqXdq9R2V9MjcNP7bpvIc8WczFig2kHr4culMGJnEy6SDnfJjosUSIJB/AlUkh1uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUNjPjRwBYG2KbpxMIQbSTvfTvzAACQ3ycFnbwHunMc=;
 b=m1LIltkuUsm0izCyLyag9eJ95dhKUIo6FZQoTpkuXU64zOqDAklIDEekmWfp+ZxKYlL1Idp7LErIXHijYGawlnDdRfVImOfHOFqAFSbvNZOVxcGW70wVH8nyEFXL4t3RkbOLkmFVonH3v4JOEYDm27AVFw2EY+Y0KRfO0Z5P7JE=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB6177.namprd10.prod.outlook.com (2603:10b6:510:1f3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 16:06:11 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2%3]) with mapi id 15.20.5791.027; Wed, 16 Nov 2022
 16:06:11 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     masahiroy@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, thunder.leizhen@huawei.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v9 3/8] kbuild: generate an address ranges map at
 vmlinux link time
References: <20221109134132.9052-1-nick.alcock@oracle.com>
        <20221109134132.9052-4-nick.alcock@oracle.com>
        <Y3BeTbHxj9OmmmIY@bombadil.infradead.org>
        <87v8nhv5vq.fsf@esperi.org.uk>
        <Y3QDIVy0c01Tie3L@bombadil.infradead.org>
Emacs:  why choose between a word processor and a Lisp interpreter when you
 could have neither instead?
Date:   Wed, 16 Nov 2022 16:06:06 +0000
In-Reply-To: <Y3QDIVy0c01Tie3L@bombadil.infradead.org> (Luis Chamberlain's
        message of "Tue, 15 Nov 2022 13:22:41 -0800")
Message-ID: <871qq2vq8h.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: a14f5fcc-d99b-4bcd-43a9-08dac7ec7ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0lPxHa9BWTdzR2Dg8RPQW0Rm6syoBWkw9POkdGZgdewueO7/XMnVc8ANWvkiwU/Y6OrgElxyFpS8GzWnZOenYPt4dGGNjHXRpwzN7UOEsg2UVlmISYxzlyR9fTgVsCU/it/resdswq+EMhy1TF82rBxfS2gYIa6pYDBm9x0I5eme2zsUPYFeh/Cc7PaBNerCOJJ33p5x0BRhah3mKLsj0+Nt0Y7kSyVgCPlSb4IoDh86ltn14FKuB9ddZBA67S5AyCP3WTtN57RiQeHcT1pJYOpQeiTpDRdWi0qA9Z6zWlHrhsc/m/ly6cZFD53t05MvsTHnev1n6GLpQLFiOibHSzDuYRQwmWv3aBvjMqZqxavNrEJCX5JtV/2wFwdF1b0VyEWSWQYo+TUX7wiW0DmFk+PvhQQTsZyuSrmkK90npE+jBOAxD0Hr83q7A+oWu84UIN5TIw6xPbAVrlkx6mIslzmHkhGcTBQ0F8LYBSprwfTxB9LX+As5ugkSVue06No6zBJdpI4DY6IY7hxHOMebERTBS2kih6mf8MwZHCNvWf24zVzdj6+VKsM90YhQBG9TtVAAOFRGzd91gPoFcDRiol54O92lRLzuDzYwNozF8C/yM80eX6gqtu9hnqvcuDHY86f2u9FJxkeiCDFEdkmBbylRbtVokhM8w3XU+178Ose1EZlf8wda7Y7fuAhDrvwDL6sCP+o5UO4pc75S6XE+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199015)(86362001)(36756003)(38100700002)(6506007)(6916009)(316002)(44832011)(6486002)(478600001)(6666004)(5660300002)(8936002)(186003)(83380400001)(2906002)(6512007)(66946007)(4326008)(9686003)(66556008)(41300700001)(8676002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wUBMnzjB7eDRottIIPisBmvqFlBqUL7h9/s5eK0ibtg4IjUiRTXj7Ys+u8nV?=
 =?us-ascii?Q?W/jqdnkAVXXXxrv5TsbAw+h9Aro7Xod+AmCl33faGT2QYIvNoE2EMAmPKLcM?=
 =?us-ascii?Q?+nlyB2gF2+GHB1KyL6szRLTTpIpDlPiJnd7h4b1J1S6EqMJIqiVCKTMoBb5K?=
 =?us-ascii?Q?iwQarw/gZKYqBC9+tZ870q7ZlXlVhWlblt6h7Rka0+0YNnc5UNkiv4qHa9Vu?=
 =?us-ascii?Q?YUmNztCHA6/jGdRXAZQ9pMm9XflhIh9CNDGVvmFEIhOWD8U8NVn2wX91YHr8?=
 =?us-ascii?Q?sxLeHmOCMlCz3VSnzHP9kIxri2gVtFhJIq/HJPrQUFzE+hySrzEm5jMPWj+K?=
 =?us-ascii?Q?CYi05pJPMmnWfFSQcq2+PgrHC/QwcJDcQncpMsb+NdrmU3h5ukqduwdYqx2u?=
 =?us-ascii?Q?UYNmwPKYFVLF7DZVQGfSF8qwDSWYetqYUc+GrYe9S7e5eI2b9MTdbhmtiMqJ?=
 =?us-ascii?Q?2h8dl/MMYqPAYnm1ap+9ahzlnymEgakFRAmvm1RxVlDrT2rY3/vOC0MZ1JJ8?=
 =?us-ascii?Q?S8VzchqlqKTveNL0G66IxzujEXKxBiz/QAC/d5S8h5XpBaF0I7eoBJQLzBjn?=
 =?us-ascii?Q?mrd9TV9QWGVrbOGekTP00bwxKGIbwmbmfg8KFUkFHKSslXBG/CpSpZb8X5mn?=
 =?us-ascii?Q?l66QjYqxeIpS2aorU/70ERRuisswQBahhYQ4S1hmbayPVLV8krqNXuLITf/F?=
 =?us-ascii?Q?0fYZtlIKHj11s49yWrUcne2pOU+LyxiyLr3H8ljopZ93C3UjHWnAz/sfHIDl?=
 =?us-ascii?Q?pB1rynIp9kpRjRtiGMVcIW7gF8v4rlKi79K7eOxwizIzKWhN8CljfebP+Ycx?=
 =?us-ascii?Q?rPFbx+hJJs3zU6dwjTSWxAcsgIrK0OPt42rRpJN3M+JPHwR2zT4xaxc4/95W?=
 =?us-ascii?Q?owm0ULppbZe5lvCJC6t+jSG4U6LzdtdOAQD+2KhlVDttfV9PbeV7DracUZjT?=
 =?us-ascii?Q?e+qzgPhqaGvlnmEmWucEu9/WWEKgueT9IUP4Q2pPe133/CQAOZVJBEastWVe?=
 =?us-ascii?Q?rQ+/tGgr9P1H49Oe+B4L/9AX+xr3jDKeEkuPkQ6kIsG5oFz9FAyMuOMNLqN7?=
 =?us-ascii?Q?8JDWrrOBL9HEHKsUU3ZQgmMEbAaIYPG4+7XtQmgNyaMe0jpVe3qztaISrH2e?=
 =?us-ascii?Q?P08dReuOaOi/H9qLV8AinrqpG/ZykhVtlyXC8nxShTyQV+IRaD7ZPe7VGdAj?=
 =?us-ascii?Q?HxcvLQp8TqDcVqIJnuXn1phJE4wG3QX4B1Q+eJbuhPtmNe3lzFz67UzeSv6k?=
 =?us-ascii?Q?VfeLI2C0rZHsRZEvTg8ACNRdpsyx3VdK04i3sHigxnUXVpLj4EJtY7XISwVo?=
 =?us-ascii?Q?HSbm3po6ejMVQfIvroaldTqdfTWvOr91EBm4azTlbL54TeMOkp44q3JRyIXC?=
 =?us-ascii?Q?xrzDlOD8CXO/IVs8KcuhnZxOgDoJqJGz+LiO197X4VXDfegInnJbbDbRwveU?=
 =?us-ascii?Q?wFnPHTbbCxKqLlJUipNieY7OjdqlNik9YshXlC6S8xqhGMskrcz4dR88wp4s?=
 =?us-ascii?Q?M2JiFxvn4ioKE3wbbx18Z/a9MCMm6IFn8oAQiaw26NPSZZ2yD33jTZzDT+qv?=
 =?us-ascii?Q?pK8Bm3kOOQv/nPym3UDJHRjv55m7F4NubURNj6pwUW+vh31TlO8T9LJZvOiU?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pl5ma0ayzNnXlvWIORqrIwcMf9+xNDZj07Y/TULSGE6q6eP744+qdcK54Sma?=
 =?us-ascii?Q?mVfTC4Gzo11XG8KOVrKjv6FRRX0sA32YWVGHmrLYGAHbjDA8bUxLuv4cC/8k?=
 =?us-ascii?Q?Iydkg7uIqdimQtCM18RrcxXjaOnYqVWhWGceSnXvSr1OkQjLamOAlq42ikU/?=
 =?us-ascii?Q?GkpQlflh6y8yKAc/7oLxnOBJeWlTQ209J9lGGTAzyPC2WtFmJ+7yhtCovCYm?=
 =?us-ascii?Q?wS41uIZjzYgLDowKanpBCoQSOnuQ4ynor7garL+21+ISGgLRjtbJlhftzjfH?=
 =?us-ascii?Q?1IWHT3/t9GguhKkjXuQnKEXOn64gOFamy4ERrvXTe5MRKeCrJMjWNqDhC5or?=
 =?us-ascii?Q?OTPK3iW2SrC1xYSQBFDpITAw4+9iQrW2xRweoWQxa7RexmtuodSreoNs/Zib?=
 =?us-ascii?Q?eE/rHDLTK+8a3l6CURJnrYLIds/EIiqtQMNn5Bvv5b38LoUPqZnXjGDO2KUY?=
 =?us-ascii?Q?0JXtKji5n2klaIl5U3D/UpzOt8+4Es11y4cd38xZUhtLsvv3oq8C9zFRRGUt?=
 =?us-ascii?Q?5+gZd2hnej2qTM+cNhHuNa9sTNfOLRiiGWJ0QWZL4ilb1tK2PSOrq4Vi1yMk?=
 =?us-ascii?Q?O3rSeaf6rcZxAcg9+G/zCOf3GmCIxgjX4cpKSqPEFwzpmPA3V7ISBG+6FlTh?=
 =?us-ascii?Q?uFsvYtbcKq/JpZ8bTz0IcPG0BzP/ILcGkOt0+6wZ6jCZPe6BU3Me7LLIOpXw?=
 =?us-ascii?Q?iikVzoZFfbaJDdGIMR6YW9w56exrkssJFdHehs0Ym9GzZhEVd83UhC5AQUMn?=
 =?us-ascii?Q?aW5kvMQuVZ/fBQrXBJcoTPB6ZqKg1u8i5hHv/Xg9ZmsoYL7STUJlBemH2tAz?=
 =?us-ascii?Q?i6JQ1ALicK/JooyY/7AV2FAnZ9xc+ITO2ZhGSNsZ4mLnyTlgIadpWzzzvBFu?=
 =?us-ascii?Q?Fr2cPBOCmZnPzQLhaJXo4XILtMAZZ4zB3mzNedLImE4MxU8JS9HBjlTfev4n?=
 =?us-ascii?Q?TDT6j4e4ma5DnJz9npIaH+ACBJAhrnxehAfAIa3gUlQ/KPGao0UVTBaUZrc1?=
 =?us-ascii?Q?T3Pm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14f5fcc-d99b-4bcd-43a9-08dac7ec7ac0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 16:06:11.2913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8Wmpdeqi6UTlpI5GLfTp84s40MrvftVESnjf4JmKZeJIH6nLV3VQF6ebFvG7rfA513NfjSOCPVpp2km/VNvJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=310 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160112
X-Proofpoint-GUID: cIK96hoJz8mV8AzYFaEjfvGYOULDhvD6
X-Proofpoint-ORIG-GUID: cIK96hoJz8mV8AzYFaEjfvGYOULDhvD6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 2022, Luis Chamberlain verbalised:

> On Mon, Nov 14, 2022 at 04:48:57PM +0000, Nick Alcock wrote:
>> [Added Steve Rostedt to Cc:]
>> 
>> On 13 Nov 2022, Luis Chamberlain stated:
>> > This does't say why we'd want this. So either you merge it with its
>> > first user or you explain here why anyone might find this useful.
>> 
>> Uh... the first user is later in this patch series? If you want each
>> commit to have a self-contained explanation, I could certainly note why
>> it's useful for said first user in this commit message (and adjust other
>> messages similarly), but I had previous complaints that commit log
>> messages and the cover letter were repeating points, so I was trying to
>> reduce that kind of thing.
>
> Commit logs should be self contained. The reason for *why* we want to
> add ranges should go here, not the cover letter. You can be terse in the
> cover letter over the general solution.

Ah, OK, my apologies: I was writing things precisely backwards then
(rationale in the cover letter, self-contained-but-no-rationale in the
individual patches then tying it together in the user at the end).
Whoops!

I'll rephrase as you suggest in the next round.

(And I'll definitely rephrase the cover letter again -- I tried to add a
decent rationale in there but from the sounds of things comprehensively
failed this time. Sorry!)

-- 
NULL && (void)
