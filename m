Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93833607052
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJUGr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJUGrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:47:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9E1242CAF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:47:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5OieU012724;
        Fri, 21 Oct 2022 06:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=6hKG2KqTnTud9V9LvgscRjsffi64dBQ91yNsXurffcE=;
 b=lYBV+4VoVm9xhQN06OuAvbadCV4C3mxjsy5BpBYRG+240zYWoDxbDVOq3yRTfpeLr7c3
 1cpKgOBvoX4c2r6pODb2H/AUo7uhkkrh6DqBUFnjFMyRBkzdIuZq95Fs4NYc+rZbPobB
 0XqeBLOVhImS5khLW2ULYbECkpScGst9U0c10KHvhLcIZZG4Ni4KqT7sjMmu77zV5wbA
 vQezJrmxFCxa6jZmQLO3KqdndZG4dd7J9OBTCVKB90CUhpIgiMPktqKlhHRbm/1Nedu1
 ctdx/EAYCUT9DZ2mDAnlYWsxx+E8omQoChs8Z8pdK9OdmmYa6FNOyQXLy4eqE4YwT2J9 9w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtr46v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 06:46:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5Daa8007137;
        Fri, 21 Oct 2022 06:46:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hrdjm4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 06:46:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGNZsh2LTd7xR9ZrQz0NjC6fwxBZrSZm8ZMMT+1++vDwC3G55motMF8wChLJh/myhVdpfwhPtBWx7jFK9N5Tx/YnzhNivQZfvf3zp+RbXVbTM9OG2WtPPnGXYpvFYWmKwQM8T4dqAgmCBLgyhAzVGEcUhnjh5mO3rR9hHAhp6G2i39MmsyvHvU2Z+OTDOHnuIMW5vwJVx6eAV036GqxTmeVtKjWSVaddXMf4YLnLSTsuEeXjnSlbl8qWLXl+wTElHUJQtUxh7fEaxXq3t1xRM+U/YhH4SCNH2pJsUH9XMNtf4jkQfRTra6ErGXZopvx1mLdcslEOMK7hQ2kECMrS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hKG2KqTnTud9V9LvgscRjsffi64dBQ91yNsXurffcE=;
 b=hMwReJxSzz8TRuyFn7CNHJa+yx25dJSbOlQ4aIKBkOO61ddc+M/IYTRIsagCgLcYZfSWIYyB2KSF6uPTCoXdjlq/H0RyqHZtu4N7Vj6AYKpQST51+mA0a2fOECZHW4f0z3mms70NjsIJAIcLIjRsL/VZQ6qB2GhPQXJsV4m37YEjzoy0rlmdU7SDl59yvptIaZWiKW5l8QrnlOKMfLgWlM1eFGooobk2qzaf5W6HIVIyXE+F2S93iu5svZhRE+uxKVdrUf6LQO7F7n73bQx8avJmQGCN/VQYQ883LCz+w/8Kt87lJLQkbQSQT71jDLOfL0URGaPe/l4mCDYY8Q3NPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hKG2KqTnTud9V9LvgscRjsffi64dBQ91yNsXurffcE=;
 b=q89NzoNgAnH80CpqDag25EdaFXIWUmfe+DWOPj2WKi5TWLq6ioLFO9k3BelaTu+fl3nBMr5SpdeHfaAIX/IdEBlvh/c1Fbwta0CWh9vWtBqo7cirQ9I4PUb9MzhKkYlKEHes3K6xEkA+Uy9HwrOIkWUtjC4GqniUj4cSpO3QEjY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB4973.namprd10.prod.outlook.com
 (2603:10b6:5:38d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 06:46:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Fri, 21 Oct 2022
 06:46:54 +0000
Date:   Fri, 21 Oct 2022 09:46:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>, Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/xen: silence smatch warning in pmu_msr_chk_emulated()
Message-ID: <Y1JAUj2gPSQv6esQ@kadam>
References: <20221020113759.17402-1-jgross@suse.com>
 <47668d94-6b55-2894-fa6d-82b1f17312bf@suse.com>
 <26bae6db-0e17-2b54-4046-0e85b26f6401@suse.com>
 <7fad3782-daf5-654c-f89d-e4dfb92bbf8f@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fad3782-daf5-654c-f89d-e4dfb92bbf8f@oracle.com>
X-ClientProxiedBy: JNAP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|DS7PR10MB4973:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e022d3-d041-4a79-96bc-08dab3300a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hcWECTk8psI8+Zy8H6My4nbI+ZcX5tZvA39s2t9I5cqG0cKflul1t8cMTPr6cSmEKIxGf65t18BGZ0Y0mYnqt7UPwqGRAxAUNaq+8COoXzb2a7UdqhZu9qq2wILHLTMSd1gPA522I2Y+hCpXnW/Xq3T8kq1HqaOuhbmape9E3q9+zs78Tjg6srImgu2VeGRiBfLt76aTpxFVaojK5eGpUupZXSafnrpUtiM+a91JGB6UJXtyw/u5dpxfDsK1eDU2Z2ygAaY/dXoAu5jn0R0d8i263fGSZw2SdTu0HqS5B6eFh8CeJTxYozZ8PkKKhFewNycul5LqohlKUGeEfcOg1OzDm3qtKJ+uQLRrEVYdlF7rHW9Vkzq0GpAHaE1C7UMuwgOIMDggAPjjxrq4M8OSoESU5LLAc+kJfynPXzmfbxaqfc7548p4DFIj2C1U10LfyjHLuPPn5Xd6UKlfzlVp8ThNhxHQL6kfdvujQcSl9N3Z6GVrho3iwEoWa2Qg6YOo82bBWzeRl5lqla4iBrFawLL0n7UlBJqDkosyQ309cceMD/dgWpaS1Zm4J005a0rwb32SU63zmjEVCb901j7loGcKy9Jrqocw1c0orudMYyXvy7VHQ0YjJdIw004n/axhny3Sxdq9rMo980A4qvSEd6FJ9ZAYZjhCaT78BizmPBs82QZZ/ChgzuI3+8/7A1I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199015)(6506007)(478600001)(4326008)(41300700001)(6666004)(66556008)(5660300002)(66946007)(316002)(66476007)(44832011)(8676002)(2906002)(6486002)(26005)(6512007)(9686003)(53546011)(186003)(38100700002)(83380400001)(86362001)(6862004)(8936002)(7416002)(33716001)(54906003)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xpl6xn2GPW6jug3GTFR8hGCfEN6q0ROVuEWEn6hzkllxmfIzerHA25cVj0Bg?=
 =?us-ascii?Q?VjH/vDjXIZQs66uystJgbX2vxpxef0+V/4ykSKwHQyVQ8Gx1pzASIHWo0UlJ?=
 =?us-ascii?Q?1lp+cSjDXWvv5Xm0VZZLQG/GUy1YxyRVbYAiRs6ggoMtKY5NA2L33xyBkpaZ?=
 =?us-ascii?Q?r41A2SBJQxZ4d9QAk4KqFwBQjt6WfejkS6SFA7cBc1jZbHdzZh/JpI+RcjI2?=
 =?us-ascii?Q?UOqRMIWcfUY1H9Rts7RkRLKXjlPofUBGqbliL5cXSAeJrAXK+XpiTq3jfjsi?=
 =?us-ascii?Q?EmdvdI2GjMnnUpLRNZBdZqJwb+5D2ZpGBnTfFLCqewvdcb+DkkXBNQ8zrJso?=
 =?us-ascii?Q?2zfm44Jo05WQQmICeqOlWzLd4x9jP2aUCt3UtQvx1KXX8mE/zyzUrI+sWxDw?=
 =?us-ascii?Q?3JjFy+OtInNmmjMrvyzgw5ZEqUiyk6xAnGoe51dADGxBjMMFLftul4SgYYKi?=
 =?us-ascii?Q?myh8TtyW8/zhSBGgehLDprlm2raDbK+7rq0wJtF8dDFLTkgYjXUa5dq/vVuM?=
 =?us-ascii?Q?NdE4heEH3iJfVxrJSpAsU3OYIkfUmWnGX4MLBAnorJHRz46B5Rgd1ze+6/f4?=
 =?us-ascii?Q?vL4Ux+gDUiG3uejrjZGN3UgaMuKQ1rRVr96L8zBtMmvH/k/3Pe0utj6vp2mA?=
 =?us-ascii?Q?ABYSsfffq/vkw4RU3e4Q0UPeoIcOovrp4XMTlGZ6oMGq+d8WvS7pUOn/B6Vl?=
 =?us-ascii?Q?DXwJY0DHI9vwIC7X2mneOnqJyPTKVKNt1VazOA22Dl8rCgzmj+H/uUBCiYKd?=
 =?us-ascii?Q?ZDCtdiQOB6sS8iklQHpwCdzSuxq0J1A+MpChimuukzsJWbzMFazxAea3yd17?=
 =?us-ascii?Q?+qG+Tc1VGcmjShImjyoI0yHFnvNE62KM10XKeCgMd53/yT1O06Z3b/QsQ5cT?=
 =?us-ascii?Q?Zr2M5jdglYLLU2xT2xnjWYtT/IQYTicag4i6yKLEtQ0xMpVyNe3NDbLdyNUS?=
 =?us-ascii?Q?X+ZtdhuujmKSVypV3rBbbqejuIBseYWOzt20GGFTxLX4bgE2u6rVzJQLuPvs?=
 =?us-ascii?Q?HTnfDbV7KqioLqGnyz8Ph+E6qmb3W7sgVKjZOMjNWnz7854ANr5vvc4/dcvq?=
 =?us-ascii?Q?7do3W+Rl1I/u7FszKJWnY/XXiA+B1IiN24sdXPnMzSENON2xYsIeiywEeFkA?=
 =?us-ascii?Q?R6WinN+OH1ZvBPCzhYnVrcXYUUOXGZ+McAs6UowFFdH+L5GNwyHU73Pq0fFK?=
 =?us-ascii?Q?QS/LWZ55j41on8ig1I6P2spC5GQxSrSif7JyQWRaSlvk/R5SUeeCSRpHA8xK?=
 =?us-ascii?Q?51T7AisWZfc7JSMMo9pVFOU0NEUYjcOvPr0kQ4nvgx6U1bL63dRgBTxxsBhV?=
 =?us-ascii?Q?0pdIEACHQoR3UoHprFOjZl6PNzSO22y57omxv75pnaoNu04Tck47PO7LpFEr?=
 =?us-ascii?Q?5SVDefW95yUSzI/bmPt8InvEgFxB75Hg1XcRo5FX0cuRifULJEanHlUPgfxs?=
 =?us-ascii?Q?vXvCc1GWM7WHsEt0Z7FTNljlGcHbq5jC9bGSqP/1MCfd4IFHJSjChyd4vJ4b?=
 =?us-ascii?Q?HBBWBz+DuyCWU2Z5YldbnlizY6ATONFwlaGVXNsvD1SOlOo2mpaZrfLWNaLs?=
 =?us-ascii?Q?pFTFqnTfXCnW6vCt6I8Gs6qzK6tipNaulIUXF039jBY3MMBJ4OszuwA/FArd?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e022d3-d041-4a79-96bc-08dab3300a41
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 06:46:54.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJva7RV6icfEVWOYyv6o+5SkosDAYgaiOlv5mEEoyuh6vJ5shPU+mrvLaKLQVoPDr5wzZlMpgxuHyDLMiPW6pJJt4fiPNNihA25IX7JW43Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_01,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210039
X-Proofpoint-ORIG-GUID: lWUr-6OeCEpUV5LmE2Sj5fp7xhUYx1ev
X-Proofpoint-GUID: lWUr-6OeCEpUV5LmE2Sj5fp7xhUYx1ev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:22:17AM -0400, Boris Ostrovsky wrote:
> 
> On 10/20/22 9:34 AM, Juergen Gross wrote:
> > On 20.10.22 15:16, Jan Beulich wrote:
> > > On 20.10.2022 13:37, Juergen Gross wrote:
> > > > Commit 8714f7bcd3c2 ("xen/pv: add fault recovery control to pmu msr
> > > > accesses") introduced code resulting in a warning issued by the smatch
> > > > static checker, claiming to use an uninitialized variable.
> > > > 
> > > > This is a false positive, but work around the warning nevertheless.
> > > 
> > > The risk of introducing a problem might be quite low here, but in general
> > > it exists: With the adjustment you remove any chance of the compiler
> > > spotting a missing initialization before use. And I'm not convinced using
> > > 0 in such a case would actually be ending up sufficiently benign.
> > 
> > Hmm, an alternative would be to initialize it to -1 and add a test for the
> > index to be >= 0 before using it.
> > 
> > Or to live with the smash warning with the chance, that a compiler might be
> > warning for the same reason in the future.
> 
> 
> Is smatch complaining about both variables or just index?

Just "index".

> There are two cases in is_intel_pmu_msr() where it returns true but
> index is not set so perhaps that's what bothers smatch?

Yep.  The "index" variable *is* undefined when it's passed so Smatch
is correct in what it's saying.  But it's is not used on that path
inside the function so it's harmless.

> It shold not complain if is_intel_pmu_msr() returns false.

Correct.

I kind of like the patch.  We generally say "fix the checker and don't
silence the warning" but in this case I feel like the checker is doing
the best possible thing and I'm not going to fix it.  Trying to silence
this warning in Smatch would come with some real downsides.

regards,
dan carpenter

