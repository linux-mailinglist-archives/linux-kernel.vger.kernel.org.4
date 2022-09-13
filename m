Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462DC5B6B74
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiIMKNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiIMKNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:13:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D305C957
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:13:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DACmZT002728;
        Tue, 13 Sep 2022 10:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=IbHCwQg0bObas48uzt34ttX75Zorb0jU70zWrWsl2qU=;
 b=QZzbOxzo+DbsMpJEMxt/hSVfsbgom8pJGpafvtbR+ewY4MCsw+mF8DmwkSynh1E0Ht2H
 d/MrhltteC6McpNosTiKLxy1qESa8T/ripd1Nk09TO6mYT05rstXGm3uWzinvN4izr8b
 nF3hW/Rbve10J1fBOW35lv/5kNJu073ikwA0JgPwy+J3swS7sm4zlGIIaS6VVlKog0Pm
 PJdxtFP/KULpmWPtZcqbcHjGE51IfgbtnWfh2bzI0zfAo7xwuzCjP7rH404kP4LcTl+w
 ZkYnlmKpb5IRA0UQwaGvSS14qv1JxYAFFSm360oKdSjdZ4YFfdEE4BA+1qEbu9FS6Tdi zQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jghc2pc6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 10:13:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28D8TUQx034853;
        Tue, 13 Sep 2022 10:13:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jgh139u6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 10:13:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2lHH+u3HUXisRYWdnlRDKWtlqZgdqbNyrpa9pN5IfFAMDPqd7esyQqP9CIfGMnSH5PRsAzot1TBckASCGfUTOMVG9M091CmoH5usqJimpVHXW/RkDI05eDfY1xoFwLJSxXbQA8NCpmRSnWGJ0m4zpHr2BnQuNATX7oxzm1L0ohbkfKtzSjv2uqyQfrslIwU93EpCqfD2V7gYifGNWAvUaMmaJ0iAx80mXkVwfggSez0iICy3827wWv6FRTGJWaJwD7kZABEHV3gMjAPu6Kojpx9ok80b3Ba8K/uR1oWPmTNerppYBt9jAHVRSIh72nOPP3zAwSg5jUhLM2SEVGB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbHCwQg0bObas48uzt34ttX75Zorb0jU70zWrWsl2qU=;
 b=FZb0njsIZ69cNQfRjPC/40rh6eJ/7RpKg8fkk/UxAN/cC2q9uY7guSGel2lqB8Fcds5kZxqwjEltolibgauui6RC1yOrdDKvC3KAykEie5kp6F/J/67rRvHTMTdpifdtEghetTAoaiEeC3afuu9x6HgoncgjvHEJDPg6kgOrH9F/M13L2bbh9mSEJLDv7TSELmNSr6yVz9Z+P9Ju7FlkkYqdPqu1+Mpv6p0jHXqU1FtzuRYrhqyST8dRWqO6D5kg3442kZhWpVu1mzs2+7slE43L/KGbAgzNuiirk7Jm9I/LUH2CsInSEs9jxMbfzyqA9VV6y+fmfyGZOeOVY7jZ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbHCwQg0bObas48uzt34ttX75Zorb0jU70zWrWsl2qU=;
 b=wjZXujLfjL1cZ2MsKiiNrAgb08fdZGCotV3ZvgRIS4kcdU48Mp3aN5lgdtJzLB5YolVXA8oBBmYqXNxwcgVeN2DVFnNsJztIu1evHu59h8ENVwOqJPX6nn7zvv3f4gizQIMalgBCr5RKIuw7W4wgy5+zm1+eHNzVjNnUIROx0xI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4550.namprd10.prod.outlook.com
 (2603:10b6:510:34::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Tue, 13 Sep
 2022 10:13:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 10:13:09 +0000
Date:   Tue, 13 Sep 2022 13:12:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] staging: vt6655: Cleanup and rename function
 MACbSafeSoftwareReset
Message-ID: <YyBXp9x1LnBkku2g@kadam>
References: <cover.1662890990.git.philipp.g.hortmann@gmail.com>
 <540a684266610f7618b3ef6000d4699d065c8e6f.1662890990.git.philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <540a684266610f7618b3ef6000d4699d065c8e6f.1662890990.git.philipp.g.hortmann@gmail.com>
X-ClientProxiedBy: JNAP275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH0PR10MB4550:EE_
X-MS-Office365-Filtering-Correlation-Id: 404df514-0ae4-44a2-fbe9-08da95708ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CbdBaYIrEU0vAfgA0NSVBNXPlcvCcHHOxGRZlghz+A84tO4tPb3AfvPTn9FXCDB+HpmFU+XM/bgJx839mVPLrMPLjpcwnzegsw1ru3dFEFgdJ1vwdAt4prpXK5DGp7Fdj5cBMPyNjKbPMyn1vF6QzKvJuobwl8WNWl4J1gwB+19Yg3StsdzQIfynAy0cj5v/GfxMz6VX0Zbl2KHskMBYa0NS98lYNRyzZCN5e9vsIcOTagdUxRviKHLXVx2CUPHneJFLWs+2SbIRgmRZ+so9tvX01WZSATidS36hzeZLiRTPgZuh9+/G8rGPloPlCoQvoNejOJZwL0+aXgZR9xLIL9oKKaKip1/Es76wKzHcxq0owWiZVvBXTGhGqsjyq2VgCoY0SOEgkDZm50ypSrSctwr+TNXood34ilIXuiQDWwCkNlekXmkYZGltUVh5F/MPd3i291E/65y1Dwnwid8o5dS/n4Jt0AD++SFf0FOjMOg7evUYr7oKgpLTUZBCRA7BfYjW7kp9hsnjspqtBEkVQ6hkHNKEZJuMmrr1tdUcNxnjiRTeyuUcQ+yvqEUEHcg7jTXukuv1P8TuRUkOwL38jVoFtyfBeVii0e69kSHEzKXID+evHt4znMhsi7f4bCxdY34SFpZMOejmwthCvXej8YRDzeKQ5MPqODe19nya3x52uDzrm2ZJ6XARavJqhSQUz+MMetGftyQzvOc9z/nBOqBX+F90XQs4KlMSY+Kbohk39DMTOVWGvzxPrDxpPPiu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(7916004)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199015)(66946007)(2906002)(8676002)(66476007)(6486002)(6916009)(86362001)(66556008)(4326008)(316002)(6512007)(38100700002)(83380400001)(5660300002)(6506007)(8936002)(186003)(6666004)(478600001)(26005)(9686003)(33716001)(54906003)(44832011)(41300700001)(145603002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gc73hUrGW9bXurmZ579p7iQEBzoAKI7ndEAx+zbh7cfezBG+ktDMl83LSQ4K?=
 =?us-ascii?Q?Iar8BGQOfG7I2Z1Q8YOcDXLHzX6+cwB88avjLW8XTRDDt0NyGZD5rMWqpkC7?=
 =?us-ascii?Q?Sht25VI7Fq3t2texOaEY38WXV1sr59et/sQmfmAq25z3FPNz15CjGardhrp/?=
 =?us-ascii?Q?CMwj7KmAxEBNALio722M77+uDz6afDsIYhDWV+Px3NAr324e6u0ePKDb7rUK?=
 =?us-ascii?Q?NuwaOw3qcFj8PxktMuZLd1zgqV18Pl8yrMyRM3oQxBKnqSm1PYYlisdDTZaM?=
 =?us-ascii?Q?Tf3JS0Hu8e3rX78mhskoLQMCor1ShvTY2kxgluvN8vJwPm/O7sl4w8zufqxu?=
 =?us-ascii?Q?WDrmLMhHxeX5vJ+vzhEB+531ohgMZ3mP+MH9hXD40Aq268sqbAFBnYOI8sQ8?=
 =?us-ascii?Q?W6kCp1hgHGUYK+YFbv8Qk3snhc3ylk5FRtSrzCAcuRQxMs6WNNosxB+e9p0U?=
 =?us-ascii?Q?CjMgQ1N7jMdjqFs1J/PET8BX6esVmKhg+cAky+m+2lHVgbnRfTilZgYKLzUi?=
 =?us-ascii?Q?60QZWxH5rCULupFkXA8qAADyiXClWBh9et7yz3udGU9xEh1suL499Y9BNG3g?=
 =?us-ascii?Q?KRSL70hdQy/IEIHFUALDO6tkXeIWsIdMfneTDjsc0x+zlvbd/UbQEpcu1YyY?=
 =?us-ascii?Q?yKi1GIEF4cuHkD6qAe70xeA6VmB/FU4HCFuYOM1NAoNaADGEb+RfLnNYvmXq?=
 =?us-ascii?Q?potGHjpFSpab/CmBTsxbFsBSFkCREeCbQGbW6zDgBfQ+ACCTf/q0jwNhjtS0?=
 =?us-ascii?Q?xg0J7IaFy27Y2WlKHcICQ8hLi6evMmAjTs8at2KrUdkcKSc+vZQnHXWdwecH?=
 =?us-ascii?Q?d72GmB0+BN8kZQBzAr6jj5Sf8ZsJbgDl51zGRR7KE3dmbyQXSzjOrzUgMLey?=
 =?us-ascii?Q?4CeCHwlgtWOBQjQdgVN6I7QK0gH/JHbIZoWhZjmrirlIg9NV1oQlqg5i6Zcm?=
 =?us-ascii?Q?vAjE5YHz4keq1p8HQ+WjuAXwqFHvMgUzCzwMkbkOF1Qz17yDjlfHeFeYeupt?=
 =?us-ascii?Q?CKFrI/4SbagsjwNbkZKX7GDN8HH445D735XX15RGB1ucw4E5W4l7kkMatwJQ?=
 =?us-ascii?Q?Wp3kMGWBgU1mfA0ik+AvMma5ACSlheoo0v2jYMbkA6x4cce0IvYTS1cMDtKU?=
 =?us-ascii?Q?CrRYbVPkMLR0q2aKJ/PzwHxz+QHLCCpzxrLIykS/A8GdvTQxVWcpJJg3gqXf?=
 =?us-ascii?Q?ScdZd4RsoY5R+lKWAXOaS0ewJpK9FYS2IfLG04iLy9xrjVjMChMKEVcvaOs1?=
 =?us-ascii?Q?BZ/h6pA0s97VnYnb2kvDIHwuekKSSXLmi2AFgSG+wGm2Wt6nuAPo4p4J45Ep?=
 =?us-ascii?Q?yCYWKwL0Ay7FNKHVSm70iNd7krzmNlRVYH8C8jucFzzOGGHAJfAAG3zWmeL+?=
 =?us-ascii?Q?zJix+gvsm6ezsyCFj5Hz4n7M0O5/it0OYMbgPSH+8seGfRfqcUz0D0TwKyam?=
 =?us-ascii?Q?E8Kl8ejSYrBxUZ56fNjdVA05YsKg7QcykgeYX/hihLJMcRBkckWUzNMnDzrV?=
 =?us-ascii?Q?e8MbDcuvIiP0dsBISxlI9SLxrMM9U50arMWnGMF0gXzeUM1Wi/HPUNndo7/j?=
 =?us-ascii?Q?8zKX2aMwAHAveX8lHeiuZhCbFGAYI9KHyCX8Q2od7fqSCtdIBT/XjH3IaUtk?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404df514-0ae4-44a2-fbe9-08da95708ec7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 10:13:09.3661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gwCojduqZT+9oPB3GX/qw8cUZotQpsTFZursPDWshmDNQICSp+mX2+i4w53qHHNJPydiFTIchO/9TrBTH+JOZ7JDDhzcpdTxlu+90E+ZLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4550
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_03,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209130045
X-Proofpoint-ORIG-GUID: 5wISrQe3F9VsFLSxOsl4FZdFTyaDoAvJ
X-Proofpoint-GUID: 5wISrQe3F9VsFLSxOsl4FZdFTyaDoAvJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 12:46:04PM +0200, Philipp Hortmann wrote:
> Rename function MACbSafeSoftwareReset to vt6655_mac_save_soft_reset and
> abyTmpRegData to tmp_reg_data to avoid CamelCase which is not accepted by
> checkpatch.pl. Remove return value bRetVal as it is unused by the calling
> functions.

Please don't mix this kind of stuff into a patch like this.

> Remove unnecessary declaration of function and make function
> static. Change declaration of tmp_reg_data to shorten code.

When I'm reviewing rename patches I have a script where I call
`rename_rev.pl -a` and it just parses the patch and outputs:

RENAMES:
abyTmpRegData => tmp_reg_data
MACbSafeSoftwareReset => vt6655_mac_save_soft_reset

I don't invest much time in thinking about the new names.  The review
takes me about 5 seconds.

Then once you start marking the functions as static then that's slightly
a headache because now I have to look at that part by hand.  But
whatever, you can kind of sell that as one thing.

But then when you mix ignoring the error codes in as well it's a big
headache.  At first I thought it was because MACbSoftwareReset() always
returns true, so I pulled up that code and that's not true.  So then I
am annoyed.  And I pull up the commit message to see what's going on
and sure enough that change is burried in the middle of the paragraph.

Don't do that.  Just do the renames.  Then change all the functions in
one file to static at once.  Then make the function void in a separate
patch.

The other thing is that making functions static is not at all
controversial.  So long as it builds we will always accept those
patches.

Renaming variables is not super controversial.  Sometimes people quarrel
about the new name.  For example, I don't like a tmp variable which has
a long name like "tmp_reg_data".  Just call it either "tmp" or
"reg_data".  Not both.  Don't write an essay.

But making functions void is sort of controversial...  It's probably the
right thing in this context.  But what I'm saying is don't mix things
which different controversial levels, because it means that someone is
going to complain.  I would have ignored the "tmp_reg_data" thing
except now I'm already complaining about stuff I may as well mention it.

regards,
dan carpenter

