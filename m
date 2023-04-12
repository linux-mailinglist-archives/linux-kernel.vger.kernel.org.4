Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374DD6E01C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDLWWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDLWWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:22:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAC85FE0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 15:22:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CJTXle000842;
        Wed, 12 Apr 2023 22:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=IxHj4W3CEXwOPgxL3oHe7M79QboszHu+J1hNk6P0cFU=;
 b=hITuIXZK7rOf0803AN30BRZQk/mUkqO1yeKax/Fv0emeRR6fil1YXn3Ffn/pS6zSntEY
 4mq/Jr4Z5VcIS9ZGWSGjs8APcbZnwVbwE8cMuE4nX2WBezVrI7zxBkrOZ1xBsOdjQWJE
 P5tQagzrHBTqc4zxcGKbvIt8k6t8LDUdgli86/F+HNAuT/CYTErMw6nHPMTH90GpU2JR
 ayxHJMXilpnTW3uOoumE91dLkEnoPLu4N07h2unMBCDkS8Amze9mkm0JGIzsYhwcdlbf
 ZN4Cudsj0iJnV4of5p+b0LT1h6bJLbo3SsdfwYrRZluNNQx56XtGIQ4KWZxiSXHWlyke VQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0hc9jbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 22:21:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33CKgEBL039646;
        Wed, 12 Apr 2023 22:21:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puwbqs3ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 22:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfRwiLIBUXQmkvvke13jaWvRuT9ucypK4dN0/axil8QbT3nSMFVqYgqn98oV/yVD5F0doAdiLEQjwvBa3Bi0HqCfvtDoBhH15ubqZI3r3TCY6FnBZL8dlL2Sqp3xbUgrbhAusqBMw8gPYCioQvMOltZMTTer9l5x1FzO2jQ6+ZtjYRr2NtfbXuaIY29kYbF8afrtjbVozkoKv6spwDWGOkyr6adrdVaPgEOUYSso63jY1sMN22PLLFsAYLq3OSTkCpcMqEtCUrF+aSQ8HMBQkEUxkZQetjMICzqLREZeBcWcG+VURoecFHxAxP0Q5/Ar4OyuSrP9o834U5OAIlr9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxHj4W3CEXwOPgxL3oHe7M79QboszHu+J1hNk6P0cFU=;
 b=JgelqtkgTMpVYy6tXm5VPJNjBTaY+TUFnVgrqS4AZTlEZpIqbu0DYC8A1qAL+yOaKRyIYqPnpHBJR/vRj9wKk67nN8HJxIoQ5rgK35wtlrYadKV5tenx0wi9zSJiRBobTN/bHON7z/PhhZcde/xzBO35ZAgaux2KYbZ5sL9cNANSbrjwyEn5i23eKZVRbvCYm3Uq3KGlp+AteAl/GvfdkDIE+HB8wRwxS5RgPnBfQ3K7h/Zh/q1Hjfj6tMXuWNu9IR+95S5ELwTZ8Q3/ZHNbFUh+dRVu8oOZc/Hs3lPKM9Qzn61kw1Bdr3jiuyo3baL3UbqNV181LvLe2hUT2VAr/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxHj4W3CEXwOPgxL3oHe7M79QboszHu+J1hNk6P0cFU=;
 b=h7vcLZzrlU6SmhEzG/NkpbUV0m8BoPv+m6EzsnV7p89Dd7YnvP+wqpOeuTQK+CeHM32d/xhzkBlJK6xbeDALMgGWcXfLEwBgG43Oy8w0AHknDKlxK8fEiCsVtv3fLBd5E4FxkMFwQyYRqvEJ5vNMJuxnsXqMoHgzABvgcQP6LJ0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4264.namprd10.prod.outlook.com (2603:10b6:610:aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 22:21:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 22:21:41 +0000
Date:   Wed, 12 Apr 2023 15:21:38 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Tony Luck <tony.luck@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: hwpoison: support recovery from HugePage
 copy-on-write faults
Message-ID: <20230412222138.GB4759@monkey>
References: <20230411092741.780679-1-liushixin2@huawei.com>
 <20230412181350.GA22818@monkey>
 <20230412145718.0bcb7dd98112a3010711ad0b@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412145718.0bcb7dd98112a3010711ad0b@linux-foundation.org>
X-ClientProxiedBy: MW4P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fff0d72-eee1-4c83-889b-08db3ba44a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMbKoF1B2OAF1j+M7QIGeWBaZsVpKSjIV/xXrqjethrQqELapGUYhy0TfnvPklzFd+sQ6aDBLNmuRhtMfyZ3KQYYLk0uBoJ674Y16/bGD79+RIZNKWBrEvG5HH2cRp8CRyAuzQVwYuYdD6QhLcobyMufnQPm/hhH0RUBFZ+1IrvFjxc4hafdsLj3QY7tLa5Spx5qrFE7YQrDJQ7WRhwmR3fIzcs+3eNUBsJ+ulV+5T9gN3DGeD3AalC8PUlBKurR6gjqSi48zx3GI1Jo90bkPPf3icsCNU2n1RqzI0PYkm2cXUR0+kjIaRjx6+cg/JG9K3ogvI82dOXbWWMbgaq9nBkkOTHc5XjPbFckd4vvpR9tj/Zwm48sPkJCDcxSyeZZwObW9phaZ4N6GhTbCAT3UGb0kFopPjGlX8Kw9vGUZAh9NwRIbaE0QweB8xhsqXqonhSnH+ksSrsUqGJq4HqIOJwV+cNtsnoQUiRZr/1WfBqr7bzZ1HInb6N+qWYZVPwmRCGrcXZ8GkTAkNYkXqTt5ZYUTBnJ+lu/ud0fyGvZcDqb9cAScgr6Ueqc9WYWKE4C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(2906002)(54906003)(478600001)(26005)(8936002)(6486002)(38100700002)(44832011)(9686003)(6506007)(6512007)(53546011)(1076003)(83380400001)(186003)(5660300002)(86362001)(66476007)(8676002)(66946007)(6916009)(33656002)(4326008)(66556008)(33716001)(316002)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3IGKg1f6vzZuGFBY/+5ADLoaY1tbRQOYCjN+IEXmnSnaLmjo66gEs3Gq0twI?=
 =?us-ascii?Q?7EhWQiJv5xcWx7sUe7qjCBxP/g+khJFK26tj3G+CzjbH2h4QN8hv6sJ1rDDG?=
 =?us-ascii?Q?g0hkrM6mMYh4+8cN4zSPlHOYdjzJhFBcUxLVyFLF4w38nP6E5z4SaYovGF6y?=
 =?us-ascii?Q?Y2zOsGGGEDJzP42FgWJCpuI7QfkCwnTt/JJUw72V9idnqHO6NgRX8G3Q4/us?=
 =?us-ascii?Q?UYcEiF6c1Yf3B30mzdP7OKdlcUjZKb1pguLdbBBv/EIpr2DX3xPWCWr7z7+R?=
 =?us-ascii?Q?8JVp75DQA6AV1BmFHeRoniU9ocskVoFpPVgMsSj2NnMLXzUXsMjk4YqDgNR+?=
 =?us-ascii?Q?h1Zo+V0eatE7K6aMufBqzCABA0PSZG7Y2LgqxcgmVr2Tj93lubslOCRj+sJK?=
 =?us-ascii?Q?crBNbQp1ECFPAH0rznYoW0vxwVRheDw1dCvIl+U77f4i7vS7gzMpfpTZJC3U?=
 =?us-ascii?Q?qA9nJj7APMaYhrAj1vzAC8EPKXQdj6MBnzR7DOrKcsHRkhkdFp0HFAoME0wP?=
 =?us-ascii?Q?7ykcSx6FMStd2lNCbtpc6H3jCwNehX2qYiVBrErxxXR9lcTXnOvgM/gO9s4E?=
 =?us-ascii?Q?/9VzEMmqv1NRd7FdmnQ3x9f2rP4Uj2xiuWaz+kbQtBB9YvYZWMaRNj1xUFuN?=
 =?us-ascii?Q?OrGyWVJWJEy5dcekTIpdM1uE4XQ8kFSkQ487FC13ZhT2L7BCPkIWkm44Tc8B?=
 =?us-ascii?Q?X6A71qHWLGUawE5nBpT3NNMiSFdDjRKRjQcD6w+x0PA+U5QIDz9vA40hbW3V?=
 =?us-ascii?Q?8zNQZn+JMMfIJ++5yZ/PJ5t848bm/pwOzkieAIT+2i3nPRkOZkK92I7qQn4H?=
 =?us-ascii?Q?20TrVZItTAl/SGENzaSZlfFHF2o/Hd2jVJbEm9Ssup41DqZLuElHV+m6a6fH?=
 =?us-ascii?Q?gaboCvGsnqTyD4e9PRgYK070Lm8V6HLHQ0GVA3mWMvzcNWCqDhYASIWqMs7r?=
 =?us-ascii?Q?icqY7s50hhxYiI0xm2VCJg0ku583HTx3/W8BOhcMhcRFtI+INZqHQgSATyY/?=
 =?us-ascii?Q?oLa9EpJUvPgO0avanWz7Jfwpf0k8HrP8QLLZFJVHQdmUoohEUcL06KUBUHtY?=
 =?us-ascii?Q?6yRork0+8KZP8hNRozJiXctnktK9jrK5fSBcxG+o1xhazQGTgmOXnynPcAIN?=
 =?us-ascii?Q?/XoQwHuBrpjrGY1+Rw42T+6fz9Jq7CWz6tgJ7Q08eMbgXpO02iedu6GMNPHI?=
 =?us-ascii?Q?hEDMy2bsFkhxZSvD+vqLpClu+OvgBhhWOtnUwv8R9Iqj9CMJmHecEJjYYU6w?=
 =?us-ascii?Q?IXTksg6Y8MlWgEabZ1fMzpz+P8xfLZZ2w7+NsGeaElp2AqeHeudVTzZ9ma7W?=
 =?us-ascii?Q?xYTP6hkA4olcGbfhtRDdZOZXEkLNDYaYOTPoXrlYgCYGPdXiN9jF+AJBydeu?=
 =?us-ascii?Q?AVD2cbnF51tFSUaQQ18pixmqTu0HaB83/0cFxc/s9b2nWq/24OwBn0p4efIu?=
 =?us-ascii?Q?VaAh8gqpAVbWx1tb5IVSg+SLk90T2JF3oDvwee0CmMs2ez0DEn1O031UReux?=
 =?us-ascii?Q?LJHzWPM1EmABNtuH7tL+AHp11i2HOInj97VyJLUr2Xj1vz9wybDyBhqUyMZm?=
 =?us-ascii?Q?92LaHWp9KDWmx3QM08m6x1ZJ9HJKtcOcsTYiMUU1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NVugaNU+ButKmeBL+d4wagMZSipJft8SXuELku+P+14UqtZA7lp6lGBCCRHg?=
 =?us-ascii?Q?7yFLCRoOCuqsfXwUu00B6IVn3wzmWr3AhrZpTYRD0OnAz8ED3CDlQgdh105Y?=
 =?us-ascii?Q?hO8SqXDWS7Dr1t8ybb0WV0EPUe4+8dzhXXxhVls18iD2WCtCybw5ENXh8l4c?=
 =?us-ascii?Q?Iduo5+4JehFWf2rinZzifoUBh+83wYW05P4cMABAmGGCj6Y8VjpmY6OsCZaY?=
 =?us-ascii?Q?MTnjFIG1uam8qaEBDcGR7Kyd58CUaLz0EJ23kS48dR6L3dQqNjH5pCLRIyjO?=
 =?us-ascii?Q?zpOrJx8zLK9CyBXX5WPxkJO5mbjt48c4p4Xq2iPbo2FFmy3eobmxrF5WLTX/?=
 =?us-ascii?Q?bb67h0g0kxtTgPnFwnC0gUnWU/gU6yu2ISpL/CAP7v5eWAbFeuGfiiWYwxTs?=
 =?us-ascii?Q?CXnOdBKQreJnFkdz0yz6++mj4Q2SjbZodeoj1wBzb+voOtmVmUj1D2yu/Q+0?=
 =?us-ascii?Q?3J0FAtI/wwwDWfAlWWcHgCuBmGztOgpj4wYvPpbjpeUAiL1y6vsjnDvYEPW9?=
 =?us-ascii?Q?e0OxhBo316cfpDIsTlacZYZkzBvQ+qkjXlbyyF3I4335LDQ9Ry59kLyDUdyg?=
 =?us-ascii?Q?xe7gAjb1IujugkMoLxAo74cIQdZgrtj4KdZ23KSv0lgHh+pD/F7nCcwkNYQW?=
 =?us-ascii?Q?BNODcM3/l6x/Ue09RyHMhWvKt8pv8+KEubXAoim4xsSYLtZeUsqa8yQ14SY0?=
 =?us-ascii?Q?1jBQXeOp7itWc29v/OCoDYnexD0vTQ7S1h5oYsGzLroHBe20Heu/2NbVid2g?=
 =?us-ascii?Q?vto2tqSkNff3N7LLLS8DC77hvVwPlCReJ1H7QCivQXI5nmeMpKSL86PCRYpX?=
 =?us-ascii?Q?JZYRQJxOZ0ltOO1nbihkqHQKW97r0h8vZazNi/C8JZ/ajan+uv+5Jd9wcovn?=
 =?us-ascii?Q?vchSmENl6mOw8W0hLSxG+IqFj4TieXYcOBYg6TKkpE7pdm7bN0XxhDXShZbj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fff0d72-eee1-4c83-889b-08db3ba44a4c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 22:21:41.2832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8MCuxscxDpLVgSwHCd8A/pPj8LG2a0so1WR/SUeUjGoyzcguZT/n7Vvx7yl+XuwX+8uJqdRx58LT/3YTO/Pcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4264
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_12,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120190
X-Proofpoint-GUID: K1riuzRMnx5_sQ_A1JSLUGFHZGb9lrGz
X-Proofpoint-ORIG-GUID: K1riuzRMnx5_sQ_A1JSLUGFHZGb9lrGz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/23 14:57, Andrew Morton wrote:
> On Wed, 12 Apr 2023 11:13:50 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> > On 04/11/23 17:27, Liu Shixin wrote:
> > > Patch a873dfe1032a ("mm, hwpoison: try to recover from copy-on write faults")
> > > introduced a new copy_user_highpage_mc() function, and fix the kernel crash
> > > when the kernel is copying a normal page as the result of a copy-on-write
> > > fault and runs into an uncorrectable error. But it doesn't work for HugeTLB.
> > 
> > Andrew asked about user-visible effects.  Perhaps, a better way of
> > stating this in the commit message might be:
> > 
> > Commit a873dfe1032a ("mm, hwpoison: try to recover from copy-on write
> > faults") introduced the routine copy_user_highpage_mc() to gracefully
> > handle copying of user pages with uncorrectable errors.  Previously,
> > such copies would result in a kernel crash.  hugetlb has separate code
> > paths for copy-on-write and does not benefit from the changes made in
> > commit a873dfe1032a.

I was just going to suggest adding the line,

Hence, copy-on-write of hugetlb user pages with uncorrectable errors            
will result in a kernel crash as was the case with 'normal' pages before        
commit a873dfe1032a.

However, I'm guessing it might be more clear if we start with the
runtime effects.  Something like:

copy-on-write of hugetlb user pages with uncorrectable errors will result
in a kernel crash.  This is because the copy is performed in kernel mode
and in general we can not handle accessing memory with such errors while
in kernel mode.  Commit a873dfe1032a ("mm, hwpoison: try to recover from
copy-on write faults") introduced the routine copy_user_highpage_mc() to
gracefully handle copying of user pages with uncorrectable errors.  However,
the separate hugetlb copy-on-write code paths were not modified as part
of commit a873dfe1032a.

> > 
> > Modify hugetlb copy-on-write code paths to use copy_mc_user_highpage()
> > so that they can also gracefully handle uncorrectable errors in user
> > pages.  This involves changing the hugetlb specific routine
> > ?copy_user_folio()? from type void to int so that it can return an error.
> > Modify the hugetlb userfaultfd code in the same way so that it can return
> > -EHWPOISON if it encounters an uncorrectable error.
> 
> Thanks, but...  what are the runtime effects?  What does hugetlb
> presently do when encountering these uncorrectable error?

-- 
Mike Kravetz
