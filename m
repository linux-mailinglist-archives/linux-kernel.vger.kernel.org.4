Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC74F6AF4FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjCGTVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjCGTVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:21:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A59A64B6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 11:05:14 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327Hwu7S002996;
        Tue, 7 Mar 2023 19:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=PoMOrQSupKrTBaG3UL8R92bO5Gm9CRpsY7navHNZl2E=;
 b=YZsAg2yDQoFVoEZUXV8wXn7xLWpeNAiMVRHYT9r2lHNp88r2BTkz2W3X6fzvupJxeQ7G
 XlznNJ4gBTfN06/c+CG0vCF8O40yW07u3XFbSeVjOJ+yPKIQGpn/qKA1S5PRHFud7WaY
 8xtHhqFjdktY9BSjEyQd8ozaSOtNUqdbBwcmhSzxDGyE4Quq7mbFRmtnghRgewGrgZS2
 zjKsW/kupNmFzPYqNjEC1ni4p0oLuaYrjrglUEcGJQQ8EUUDTMuMY66P1ROoI6TwbTCY
 j3vqrWIgeKL3AC3RgL2lRPQ2hzho3fHHgjVC3uQwJJPjMRT4OcD/OFa9m/nwSjOfgRoS IQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p418xxd8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 19:02:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 327IPD1o019267;
        Tue, 7 Mar 2023 19:02:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4turqnfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 19:02:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbpr0b7NN4S7HxlNlJxRw09XbGlBzSZp2uBM8uwDPycOEvGd9qkxz3lNQvKq2RRGFTu3fCx0Y4VAfDhzwN0cjvaqu/mijQ1oLK32ikfDQzR7U3c7kjzSMXHz8HPO1GUmV+lbq4xMjoz0vGv7OHt52jguboH2yVIRrj/CLDmGH3wzyTrmPBU3f5ARWuhOUwVQuCafEMoUs3/q0mUjrfruoWI0lYL+19jEqqoO88oxNjsQHonANoBBs27wetXoY4idKcYqNPnYWMq1EtH1XfLJZieY05uwNoZ3aMV9jPZ1f9clhB7ZggbH6coR8XeoCzNjm9exaUKuXuyGOI70doKoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoMOrQSupKrTBaG3UL8R92bO5Gm9CRpsY7navHNZl2E=;
 b=lHSF1l6fv0ifcOR6kzwFD+aC5fvwtUBBTgS+J3PWnK7qGqORwZeQsaP5eFzg9PHaTAcQgEaGgaltjhnDijAFTckJdf63dfJTRRYTx+9YrPvdNtEzMc3J6iBRv/JGgDqoftLo9jhaToRs5Ci5UWWUSNeTfI+ASS95LPTlbw+BnJIpP0uWpUO13KvL9axo92fP7fqGXCCwnrNu2qmvXOiCYSOS6Rg0UxydIQHUT9I5W83M1xxdTetewPPRFnZwe5lsQPLcDT7pStGBzLVkyp6HKPxLLbBx6jNP3AzkHzM3IChLP7iXS87SSlCyTAgKv1WFRGF5N8Nl9WIjFhB0Y9SbvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoMOrQSupKrTBaG3UL8R92bO5Gm9CRpsY7navHNZl2E=;
 b=b+MN3EnBW6yos6QzAC1wYJKv8QEf+IPr2PjGuWYlF5+P62fp9CDaAPWDHudEJv6S5WMGqgEQSDmw69u9vUzsnCCOp9XkwOPFlPRIgJwlwQaj42m6y2Nu9QdocYiPUZok3PqmDOUndaKBT8+9+ttSG1xHX3k60Juh2ZSUx+PqiW0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW5PR10MB5667.namprd10.prod.outlook.com (2603:10b6:303:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 19:02:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 19:02:36 +0000
Date:   Tue, 7 Mar 2023 11:02:33 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
Subject: Re: THP backed thread stacks
Message-ID: <20230307190233.GA5892@monkey>
References: <20230306235730.GA31451@monkey>
 <278ec047-4c5d-ab71-de36-094dbed4067c@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <278ec047-4c5d-ab71-de36-094dbed4067c@redhat.com>
X-ClientProxiedBy: MW4PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:303:6b::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW5PR10MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: c70a7c0f-aa11-45cc-f797-08db1f3e83be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BvLqcP8Y7na+gta0nlC3brDrU9XZxUQqHsvOeRcKNG7pKAiIA2U8I3vrquuZfnmdLdsgTkVmymr1pznMxsnXvhjYev6K93jnTVmSo/R9bzjLetW9qUnkm9i6G5+UDSE95iDjC1F/witHrD7MoFMbnn+tBTI1XLDTxRcrBxxuAXrvs6Cm5F8KIBCEmOcMzKj1j+VKhZIY4DpOVhjkEcAuEH7Ov3A2vXQyo4i5tBxOO7QZb3zkmHj2yY4jr7XhGPnlJ1mUOaRokPTJL4BkZlNlrWiqbyNWzJq4Rb1lCtxlDkskAGhdbkhugDTer+O7ghzSbzg6zsreIrv+WTd14oRY7Pgvod1TmSsl6Qk7ylnlA2/84HCJy57wWWjsyQE//LuABlFiHMJHlK1LL2JBv0DRwdSUkPCA12kvOynRwu667Ep05l39v7ZjhI/Rtdt4ydUy9JQv7qWaIXpOFEfVRE1ZjrQwDb1r+itZ52HNSUfKqli3u0JFZ4yPAjuYAb9e4C13qetGn57bEApuHjKE3mhph0irx+QrQRvc/eKsbg5i8IjzKRdpon15QEKMluxaXkgjvejiCBb3/OHsTuuaiexQ8FX/ginbCwl3Zsyf9TpWv6UGRTSPVxpARZdRoK24srZSVRifZqRd7+c7FNzXTWWu7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199018)(44832011)(66476007)(66946007)(66556008)(6916009)(4326008)(8676002)(83380400001)(9686003)(86362001)(3480700007)(33716001)(38100700002)(186003)(26005)(478600001)(316002)(6666004)(6486002)(33656002)(1076003)(53546011)(6506007)(6512007)(8936002)(66899018)(5660300002)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tifNjJViLPpbpECEh2BKhkx0grjBSfCqYo1U592h32HqP7S3sZyJ9ZKp7WBN?=
 =?us-ascii?Q?jbOmxjkEQDpfJKsTY3OlzZBhq0sSIGk9wttD1Guwd+wNpfdUa86qYsKtpnV/?=
 =?us-ascii?Q?lJMkWyyWBE8eKb+youKb+2oAUSwm0opXuY3DFt13hIVqZm7PuIvBszwqb/IR?=
 =?us-ascii?Q?s6bM30KlbAL8rKbJBGCRuJv54ZEt916z1rTJ9oRA4HeVQ9JrPXugXuSt4BEg?=
 =?us-ascii?Q?KJNtdb6Od2kRBI3fEg8AJPqsVZ3T+PLO7c/L2KTu2MI6H0aeC/idxh3DlrVe?=
 =?us-ascii?Q?vXob0sJ0tO/v6HXjQ5djlrASBjR2BBSAuztnQ+oyVO884R/GTzvH1KAANUME?=
 =?us-ascii?Q?uxyreoEOH1bL0ygx8NCtkcI5mJSATd8Y8cm9UgXXAefCd+mgRGVvTIuafA6O?=
 =?us-ascii?Q?73SZZKhAK6X0BeQ4ATB3GBjcS+1nQCRQwnnyoM70gmPy5eHgcwuwfuudyHfe?=
 =?us-ascii?Q?+YU8BQOUtQ+eqsDPEDRrTremTHAetkvDGBxXeSSm1+9UfjuZ5hexyUdrqHBR?=
 =?us-ascii?Q?EgQefNwbUkKA+2Mdz/T3FnGsgNaUPEb5wH46Dze6DPEQqdzE5R0+DGJtwYAe?=
 =?us-ascii?Q?lReVB8CGjoP0dCTjLIR9y3LeuGUnvBE5aj8MovU/0MuNygdbcgaV6V5ZW9g6?=
 =?us-ascii?Q?sxVVSZ3qsjTnjmW6P2wQywtFTxuH6H6Q9qt+Py4+pamwiG5iW8yUFk/iMVfa?=
 =?us-ascii?Q?VYbEVtKbxYr1EpjM4BeQzMulGC0U/VcuqbcHwRTjdgT6KZrViXMZIsnz1qYs?=
 =?us-ascii?Q?e31Fs0HDEym5EufJAyfzHhUXlrxOUmD9aEAjggY5atMoi74a5xZc6AsN+T3n?=
 =?us-ascii?Q?nPnxNSN3Xga5DnNuurk7FgRH+bLzDCL7TfHYcsbMXu4095HuO0nFy3B70yi6?=
 =?us-ascii?Q?F/kZHKUMKNiXLWkxFwE0J6DqjmItQDUnz1IoV1ZBrFYzOwOZ6PaYNv0prrzn?=
 =?us-ascii?Q?BfjVR2qPWq/cGJ2rlTz2q+jZXWCJgR0r8eawdhL1HjV3DwJVfEDr4cbh72F9?=
 =?us-ascii?Q?7fymWyebR3jzzpCx+jGcXCqb4lB5USca57u6KuNlROOa14zwjq/OKgm+kwhm?=
 =?us-ascii?Q?v43AtcBryviKS5wV5ifTF3mWAmQ89L8qv2hhC2s/AffmXSOXBeX0Xw3PzXTd?=
 =?us-ascii?Q?Osig4vssZvNQQ7dUrEohj48LKo3A+HznM9nU3RyHVQtGymxk/NqdfbPZq0s4?=
 =?us-ascii?Q?PfLIsd6ZgJpEbkgT4WPWMItzXifhuzHKb/0gdSTyAa1gcMgng8VxjthITisA?=
 =?us-ascii?Q?dkJNE2bBk2hEBLEmszZIADU7NzgA8vXBM7p8sudDB3+8DE0sMjyb9vpxkLMs?=
 =?us-ascii?Q?B2CpMuchdu+E0qFNbZWty+iq/AQLmvexO1jwzoXfLak0Cvkma/wVAjbz/jaI?=
 =?us-ascii?Q?SkUo2oollX7EgjrdCIb+WqDRsiQQPyE9Kjlu0tf3BUn2NUTVZWT8B1471mus?=
 =?us-ascii?Q?oTNzNgy7UN9j7T/ZHeuSW05s8QFy8dVHBarz+ULzGUssp+0/rdcfD8VObG8T?=
 =?us-ascii?Q?WHhrz8lhb1HwtdzB5mLW9wboNrWDEN7iQu2sTYfiuU+Iui3yi22Bq8R3PQ2F?=
 =?us-ascii?Q?k5jfJXWTrx7QeUWqHJBIRX9nrOTeLSe9oT1dEzF5Oz+Ya3q91sjG5UqvAFl1?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aueEezSQbF4iGf9hohUxcRMS50QxCp0FNQ/xoFJBi4D0q/iYzzkFkeHJ59C5QA+XK0FFSMA+uSa2s3HB2Tkcl8CekyEz1UHra36PEDMQ09sevB1iby9+u4EA1BPfSkaHuADAKYLgc7vqPuGHjOiXrK8YHqgXggBX6/1jKWG5yG9SrnHtv79tH+HtHtI53aAJAHi7/dN5rBeXkHlxKDyIWZIEz3foO0B7+zJ1M0Uo/kG5vVh3oPJ813t9/KM3ditI/OMKqOr7OXBbISI5cbYLcGxSaTjIwxl30JBLVRUfXzBTo39oh5ZsOV0p5TFxKC8Qybx05bFpQnYG1UuFkunW0aGvm7zQqWfGFZpiByJLdRNrl1IiWa8shtI8vL3eB6z84lK/Pty80/c4feIrDFklgLBft4AjS+mqj9KMHa6q0+Wc6E00Ox8JXM81No8v5AbcIEKhLwUdy1+McQVm21QjnHnjtwg+PK5ylbI36OhJORlipXwcQ+CiyH6KCIY9jjJsW9cRNakfjzWfOig45SBohkTyGrkVrnzWA404bfFdjdmYoNX6hmMWH9bdZt+z2AcTGnvolGMrQUpee9XKxOZSdW5/lSFTs/vfxsInvcGv4qgaxqoeOJOUbrRs6X2Yi2rtP9VolfWdBTUBfify2sZroM74JjHpdre3wZCPlplWLOU0XRX1Se0a+FyH1RnaMWK4org+QXFN5s/kSnmP7PCcnr4Lrf6T7IV8DVJk4A4QV3Eq/negKk94VRQ77ka2sWQnRwHcBpX5P/eL2ciz5iaZDHL+5o4tn8AXJsO2xWg/4VkK3TQiRTS+721RWHdY2vOy68Aum58gG42nvYfX6zjoMwAD4SF5G1AiEQ9oZYHMsQU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70a7c0f-aa11-45cc-f797-08db1f3e83be
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 19:02:36.3227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fbBNvr86p3jlkr4wBjpVzF8JbrpknPUWlh8EtI3ZAC5N8R1dh7hcrgm2lmShPG6qByZzW+UdHeJNjWmYysnJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_14,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070168
X-Proofpoint-GUID: bVAZjYXwzEHLJiPUIeaGPEFCZLztJtsA
X-Proofpoint-ORIG-GUID: bVAZjYXwzEHLJiPUIeaGPEFCZLztJtsA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/23 11:10, David Hildenbrand wrote:
> On 07.03.23 00:57, Mike Kravetz wrote:
> > One of our product teams recently experienced 'memory bloat' in their
> > environment.  The application in this environment is the JVM which
> > creates hundreds of threads.  Threads are ultimately created via
> > pthread_create which also creates the thread stacks.  pthread attributes
> > are modified so that stacks are 2MB in size.  It just so happens that
> > due to allocation patterns, all their stacks are at 2MB boundaries.
> 
> Is this also related to a recent change, where we try to always align at PMD
> boundaries now, such that this gets more likely?

Nope, it happens on a kernel without this change.

> commit f35b5d7d676e59e401690b678cd3cfec5e785c23
> Author: Rik van Riel <riel@surriel.com>
> Date:   Tue Aug 9 14:24:57 2022 -0400
> 
>     mm: align larger anonymous mappings on THP boundaries
> 
> 
> As a side note, I even heard of complains about memory bloat when switching
> from 4k -> 64k page size with many threads ...

It seems like the 'answer' is to have applications explicitly opt out of
THP if they know it is detrimental for some reason.  In this case, it
makes sense to opt out for thread stacks that are known to be 2MB at most.
Unfortunately, this means the application would need to replicate stack
creation (including guard pages) as well as cleanup that is done in
libpthread/glibc.
-- 
Mike Kravetz
