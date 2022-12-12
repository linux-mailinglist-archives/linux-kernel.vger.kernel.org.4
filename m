Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6BB64A811
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiLLTXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiLLTXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:23:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7898D25F9;
        Mon, 12 Dec 2022 11:23:13 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGwnoW029937;
        Mon, 12 Dec 2022 19:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=GM2NEf/BwxRtSdiXdrX8yCCQobTndNwQl8Lw34JThMw=;
 b=AvhVaDLY5UOaBbZ21IjpSaO/AP5RtTa6wf2skr+wY4vwdoRBgXWu9ilkQBhv/C+s8Wo/
 bb4ycP0gwMmQiRQYbS+XXCexP01e7iC7wCwdgDvCsk8auCSLQwMxFb8mEsQMsBhXypYV
 KUm6NuHFskJE4wGjXjjFLr+3JmqA8JlACSfLHefXcNx/MweXJHqX7MDcXKEuLhyI1nEi
 hBuCVfADPsi229v7SXxC+lxRQdtzhuk1WjSzxTZJlei1LAKrCPH9+3o0/Oy8tHSAFYl6
 O00B+gLG1nbEc5qX5hHkfwdu0BM+g4PjtFB5Yr8Tu8Wh4YGiogxzUm0Nx7+64Fhl3J9B Hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcj093n5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 19:22:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCJ8QXi031795;
        Mon, 12 Dec 2022 19:22:03 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj4gsat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 19:22:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYWzVl5BErxDJApHlmWysdkht+3ex04pfpPmuB1VppEeI6ZlpWiaKCO7pzKuNyGbfiqehVr6mu6vnKmNyT3crBxF2moemfUmfPbel+w/vqn5FG8sMD4xyIF6m2axdFNIttAz1W4hsKm/IDVJBH0tpDI4tuVAddq7tHog03RaRu63IUO6A0TzZy6Dxz1jAcpqXO21wggUkJvIhmBQZ1jNCg+YqyUUEOXsIaSX0jPjocCSIDf37Myz0JuQjFD/PYTtaxjoL+LcvQcNbRvN/GXMY3XZfcgzEDHqp8ZlvkLgAjwQSPMKODKbxMBvVQQcAYQU8K3xmfm5OMxUk8XGrigK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GM2NEf/BwxRtSdiXdrX8yCCQobTndNwQl8Lw34JThMw=;
 b=BSKBGsjFHISS+wCj7KPV07qGn7EkpL4AWjs7ff/1qmbmdY5m/ZU5/PMR6xZ/pgMfOdd9tSRcJGUgdVGBdZ+fo8EWSEDuKLGWQXO8WdVLIiUQTBBP+0q8y2J3Ow0BI7OtGC317Reb5qhNlSgbc2yXx8IGhgbeWYzxC1NyTXcW+KQWdq1Zhq2l+mfPOSe6B1RZGHuemzilK73DJyepsrp6BRODI3HDVsOzPifcvJaqFcPlY7F+c+rQ/gk6vWWlu2DHqk/1EwfyAFWnxcSzWA5tlsUaduN7KPp6WE5VHkjgnEqgrOeKhYHvSO1uSjoF8KSwD4C16fFRgNfLH8vhz6P8Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GM2NEf/BwxRtSdiXdrX8yCCQobTndNwQl8Lw34JThMw=;
 b=EMsyIdhheQoPouhoqzCYUYTAOtvT1RscgTRL8rvnHK8esrl0a0+CNMwyyJczXcNRwux72cxrO00JwrwrCAS1Nci/tCxhOxHTGL9pC57GnQK0rVjy6d8jD8ht1YyZsOkM/DG9eHRCM6JCPvqhyf47bvrGCLnDeq6oUSLv2EE1pKs=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SN4PR10MB5640.namprd10.prod.outlook.com (2603:10b6:806:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 19:22:01 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::6a6a:2552:ef79:e2ec]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::6a6a:2552:ef79:e2ec%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 19:22:01 +0000
Date:   Mon, 12 Dec 2022 14:21:57 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/2] padata: Mark padata_work_init() as __ref
Message-ID: <20221212192157.plxiyyinfhieyzbt@parnassus.localdomain>
References: <20221207191657.2852229-1-nathan@kernel.org>
 <20221207191657.2852229-2-nathan@kernel.org>
 <CAK7LNARoxqSzjpM0twcssMkf9X_PppzqtUo_opq=CX+zixma8g@mail.gmail.com>
 <Y5dfPgNF8E2EpNCM@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5dfPgNF8E2EpNCM@dev-arch.thelio-3990X>
X-ClientProxiedBy: BLAPR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:208:329::11) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SN4PR10MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cec425f-5966-46a7-88a3-08dadc76250c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61m3fnhXlL+8G5ehUhRXzr1d4Z8zPlveM8blROQt71FLODC6pYdxBhg2baAVpRkLndJx/4r5w2LYT0+NYJiCWrYQ4+ZN8MeHa2e2BwbsEAdaB+KuqgkP34gXZMAid9WNBEgrt450DdknALqEjWeouBL2M6b0O2/3VI+9+zrwLQZld5Qh/VBL/WEpfA/TeEjq+LCyMPwgnDTdfxsPo3dEvGFWGyRhAs+tHkzi9AITR8m5GYyfrPgA4E///5vqZZ37TCB/Bet6LN3uSDsgmsprvHK6Txgckcb2ruA0MC2GWcmF5RC6RbOFCjiBd9JMRN2n9WzXu1W1PRN3lqBrPHUrwh877/wicBZIVQoguu3D2bjy3WDAJpOX8E7rEsBpv+eVXXiMC0jZ1GG+bxWcsWz/w5wIqO2al9ULKZc8lhW69BDnoav5vIGGzGiHe4Zgwm4Xshdkdcjb+biopn5tpkh7nVjehBZkPdKxEBJZLl9LhZyB6eLtVSRCQYGIvuIB3FWDFD+VIPXO1f9HMIyHcoOcqP6ctAwYbmOxlGMtGQdNg7rIQiiGcZ3rrZ9FDRRNZyTynig9g5kBE6d7MQ0R9nzI5u/aLFD9QDirYVi+h5Cu+fNEK1gGn7otPY7mxCQLghRXMuCMiYQpMFRxU3Rib/inUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199015)(2906002)(3716004)(1076003)(316002)(6916009)(6512007)(6506007)(26005)(6666004)(9686003)(478600001)(6486002)(8936002)(83380400001)(7416002)(54906003)(186003)(66476007)(4326008)(8676002)(66946007)(66556008)(5660300002)(38100700002)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T5EhOsQG4v5jQ05HvCn2Mlq70hQ0Dh0975wRcGJf6NHIGp+YmIRVAU4Evqce?=
 =?us-ascii?Q?1YPxEhcol0K3i6TmfPWjcXFUjArMLBGGBObfdEzIhfbaW4CNx9zavA6qrfeW?=
 =?us-ascii?Q?jwFYmlyyyFrxKRQ6VsxjVbkPDXaW/N9t9nwALOxXlY6hfgG9jtvpg84ZqJBo?=
 =?us-ascii?Q?uNlFt83clx7exESsCIDHVRek3EcyRaBqwu8Q0G5T4epMQdskPP3d5Krcp0Gt?=
 =?us-ascii?Q?btvijtme2JlO8Fi/vlFMy5rXYv6ryzDfsEHUW1RKSmLvr+JE9uhR2SRl7QJH?=
 =?us-ascii?Q?CDD8c9De7+zsR6Qoluw5sA7eIFvMpTykLWAxbz/52yW8XCqN0IX7wBX3kd+u?=
 =?us-ascii?Q?+Wr761CBIuh1YLTXdtK0f1XJ3uwjRoYn2D6TVRvZPlCo6bR0KgkAMEg1n5LY?=
 =?us-ascii?Q?xtaxCZOq0U49jaTr9sezDVGD8ep6QSEpRq7gqf2sHlcMXJsM4vU0OeCKofcT?=
 =?us-ascii?Q?DDcOKL+yLlfF9e8c8BhRNMLo5P3x3I6q8PzYljvtlGGMoWrZUCXUPjDmyLxs?=
 =?us-ascii?Q?/oNBhVFymOKPniApMYwAuaa07P1ZJMHozJg8o00dJM9qThziVbyG2/zYB35M?=
 =?us-ascii?Q?jLvk/ZGpzII1jX93r61NeQN70liLgx8T3S+Oruw7wY2Qp3Ix76kW+vdMf/v0?=
 =?us-ascii?Q?F2BB6tC2y1pq1v65N25RjMHzk+26TJZYJlmZBVQ09vXGNcZ2A5UIqWViywo7?=
 =?us-ascii?Q?zvG9hIi983gAXXaRaWvz1WsOKp9Fp9ttG7HXI8iLtibqfhODyka/Qrp8oIHC?=
 =?us-ascii?Q?3DV2/fC1Mf0kf2h4xDoHk7gzXX5x/Yzg0LMNQjL2KBuvJDLI1uLCTLngoinJ?=
 =?us-ascii?Q?72PiV110yzlrW54QqgvC9MYUBb+aZibDMvLvZsropIlTKqoY2S5+wof6hJx5?=
 =?us-ascii?Q?fHxxROfugaGTj7TsMYvxRJxz9VNCCcwSXulSE2lNH9hCRWbUCHjNB1gUYAea?=
 =?us-ascii?Q?VkNzy7fZfJvLPyWWMlNX2lX7U1iHYLcUolZ8HAl6tSeaeA25fAkD2sWhfNZf?=
 =?us-ascii?Q?fhmdF7aydCUY5Fl0oAaL74rCd8wWdo8Y50svPzKEyJ9pG0LfWXTQcSpIli1o?=
 =?us-ascii?Q?2zPfeDvei6/zpfB/PRsrK2TYBVFxX/pK7gb/qxT/BWlMkcl9D4L2wqJ2D5SB?=
 =?us-ascii?Q?vCF6wu2yixAzQy0Fq0/tucaZpdEGXWwPH6FT5zNy4DlwpAPaS4ZApYK3WeJv?=
 =?us-ascii?Q?/f6Cu/M4kESLXb1IcBx3VoBpLhtDOPnqpsNyJ85wVakXE8gnhkT886+QHQd6?=
 =?us-ascii?Q?GduuBONoBEiNfO5a3JKeBMUGz5r4yw7lXO3YKC8nBIscFL+7OmpzuRx2meVk?=
 =?us-ascii?Q?5Sfpgs3QZ9ZE4BKfmIDzaRRuaW1viJ3rsa9PqN1bRmJmdqQYxauNtmcH2fjz?=
 =?us-ascii?Q?BBBENsGYkAoDcVKbsNdPSB3zUV4caD29sDTLXpST4qdOeqgeZt1S8bTnkucJ?=
 =?us-ascii?Q?ZnUMk8G+aX7N47y7Glh8/g300hRXqRuMvDM9w3RbFyTWuILMB4QijAdRASuj?=
 =?us-ascii?Q?asb5X5+TiysUC2xzDU7FJpu8C2vPHpOtjhMlDsBjqechuxs8wFX5dNs/RzMq?=
 =?us-ascii?Q?PCVU/OC7ymHeohLuowpDC48VCAgz+7H65rlnQDvZAaCQ1pDzCbvxm05rSl3d?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cec425f-5966-46a7-88a3-08dadc76250c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 19:22:01.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lX48pU8+DI+aihN/+Hop6djpmRAlq38TWZHdBGsrDhvUha8te8Uov1uWEwAS66kUagVNh+SRYuvrXnH/wOJWnaN9/9SWlY7uMeIiYPlTf7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120173
X-Proofpoint-ORIG-GUID: zN2aOl-uQ0bIH-qLgupeZt00uromifd2
X-Proofpoint-GUID: zN2aOl-uQ0bIH-qLgupeZt00uromifd2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 10:05:02AM -0700, Nathan Chancellor wrote:
> On Mon, Dec 12, 2022 at 10:07:24PM +0900, Masahiro Yamada wrote:
> > I am not sure if the compiler should do this level of optimization
> > because kernel/padata.c does not seem to be a special case.
> > Perhaps, we might be hit with more cases that need __ref annotation,
> > which is only required by LTO.
> 
> That's possible. I did only see this once instance in all my builds but
> allmodconfig + ThinLTO might not be too interesting of a case,
> since the sanitizers will be enabled, which makes optimization more
> difficult. I could try to enable ThinLTO with some distribution
> configurations to see if there are any more instances that crop up.

Yes, if there were many more instances of this problem it might be worth
thinking about an LTO-specific solution to fix it closer to the source.

> > One note is that, we could discard padata_work_init()
> > because (1) and (3) are both annotated as __init.
> > So, another way of fixing is
> >    static __always_inline void padata_work_init(...)
> > because the compiler would determine padata_work_init()
> > would be small enough if the caller and callee belonged to
> > the same section.
> > 
> > I do not have a strong opinion.

I'm right there with you.  :-)

> > Honestly, I do not know what the best approach would be to fix this.

Either approach works, either can include an explanatory comment.
__ref seems more targeted to the problem at hand.

> > If we go with the __ref annotation, I can pick this, but
> > at least can you add some comments?
> > 
> > 
> > include/linux/init.h says:
> > "optimally document why the __ref is needed and why it's OK"
> > 
> > 
> > I think this is the case that needs some comments
> > because LTO optimization looks too tricky to me.
> 
> Sure thing, I will send a v3 either Tuesday or Wednesday with an updated
> commit message and code comment if we end up going this route.

A nitpick, but as long as you're respinning, if we stay with this
approach, could you put __ref just before the function name?  init.h
says "The markers follow same syntax rules as __init / __initdata" and
for those it says "You should add __init immediately before the function
name" though there are plenty of places in the tree that don't do this.
