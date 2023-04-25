Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9066EE583
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjDYQR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbjDYQRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:17:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0EC17A0E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:17:24 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFxAcF006066;
        Tue, 25 Apr 2023 16:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=fEzzXo6xVKZWI9R+Jm487mruUwqB/rjNvl3AW9mKHPI=;
 b=rxFqq2JqNRElPhbzGSu7wDAcTHQIyINu2SuP4SnpnyXVh8C0jjphFq5VOYEXCdhf9IIx
 R5HRdPW/AAYYq3Mwf5I7B03HKT4XpJ8sN5UfIyTBQKJQQ9omKCauitLB4urHSqCpJgGh
 lU/eBnzWgTfbZyn5ck4qpnuRUpx78n0VqNak0+Q965RfGJqtmqZX+U1mFI5neN4INd+F
 bRuXpy41lzwMehDv0Lxfo/M3MGuH1yEcoetAOmAAwKsygMfQkbWZqVR8gMF4li/xECyI
 P3tQuMS0FFW8a5bMjaCAgVTNet6WH/xoMnL8zlRm521NI4zuaNBmQrtUiuYkiKou4ChE Hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q476twx3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:16:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PEve3K006656;
        Tue, 25 Apr 2023 16:16:38 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616pmdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:16:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcaZ8D3bJ6HhDdKDtb9wU6iZ6W7mL9Z2viVMblBGdFcjhIzmVV7zyQstW+Q5BaP8njAoOT/YPch8KZ0kb7mz5GvsW/saQ6gN6srPYANEQI3GlhnG88HclRMLfo2I6c6LPhWmpuOfnQoyPYFkOJWSHZuJ+P/U2iFCXAAzqFE9B2QEhrsjP9MBTsU8rtmTFzj9CthcCpTmcWYFOLRreta5/Oh4JexCrH9QGprlu9EWba2bwBbjIkW2HooOOGjWx1w8tO7u7pXCZ/B7Pi1JJ32qAGJUj5ReDrBBaxNhKiZau+uj/rWv7PM6g44nYehmVkwHbSd0n6u7FWqdfZk9Cp91Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEzzXo6xVKZWI9R+Jm487mruUwqB/rjNvl3AW9mKHPI=;
 b=IX2yj90tQA+Zazpcq540zCe7Gh46btBMsXvCMOLumy9EFbNubndsdPzJ3Wxs2+XUMpTrbw5HT18zouYmkE3V6Ck7iU2s9VJjzVRQ0m7SwxE+AeZZKZrnbaX8vFg+ku8b+l5Kbe9hFDAfvKDLrce8NhEWnTo7IdMjvV1dlZiPP6tyere4+XyTNYnBNApss1DaGgrHQ5yl1wQYVV6uzux2Hq726REqGbASbjm3p0GGha7jw2SEdGMHP5qhVPV57HPY0ADXY4eWTUJe7ZxXmP8vhCJPwXeCXWwyoPyS1Ts48pJbT4qEajto6BmVfdfmI1B0d9xT9ltQGbnmyIrhke6tzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEzzXo6xVKZWI9R+Jm487mruUwqB/rjNvl3AW9mKHPI=;
 b=edmGKZWg8hctcqagoajDtS2Vc1CwCf5GwdRGJktLEzLrKuSK6Om5q/ADPXGvLzUsxFMFOOeewzhmQvi4n8gwhhWL2YN/7cmBHz9FugUcMENpj2MhzaJytHu3S2YHygXP6cg/yx+6UVZeBj1p/+GcaVNT5y9L0zexe/Suez2Zp28=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN6PR10MB7541.namprd10.prod.outlook.com (2603:10b6:208:46e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 16:16:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 16:16:36 +0000
Date:   Tue, 25 Apr 2023 12:16:33 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 5/9] maple_tree: Remove an if statement that cannot be
 true
Message-ID: <20230425161633.6kg3h242lo4xwnhl@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
 <20230425110511.11680-6-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425110511.11680-6-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0010.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN6PR10MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 17104d3c-b7b1-45b6-ddaf-08db45a8715e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJrd7/uyXqtX48MRRVdiYs/Za7Ftuk45Yqtd159QDksWLrj8oZVw8BrUWYXo5X/rNKkexAqUfvkggcEFcfVVrZMTp6a22I2mPNlLMUB0rO6vHUNwhQfCLyRazRpmK9HnwXBfGr0fMOgojtPA+u5sP/K/SKz3KuJLrnEmgqDOeDTBeJXwYNPIYmRbv4E0JhIw/C2eXmN6S4MZAqP/UeolEkqLVLy6cWBBkOjDAAlvMSQnLcgY/HowIdYS2+7u+gfybH4lxZFLxi1N1oikXGKrltnucNkxgXK9Jx6DVuLZO0e6mytZuQTLLqgLoMEATGAAgYVqMYC/jnFtWmorXqLmlYSVCqMG+bLXpRSuP63jowiFx56qaboEapr6Xu5uLREvgENeQiJWlDPi9xvXX8JB4Lq4SgKc2Fj7ftBBtnvARZtRXqbaZhhSpsateyE/8JDQowsMwLU5F5dM5alGdHAaQl3ZayrarmSTNjm59NSkQsZO1r/e5415ER5T+mAz3mxT4/EWvHUdYXG2nFtee6sGisXJja0oVBh0WUAOSa1QuZpmSjiBLxy/1aup/Jm5DrO3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(9686003)(6506007)(1076003)(26005)(6512007)(83380400001)(33716001)(186003)(38100700002)(66946007)(86362001)(478600001)(6916009)(66556008)(66476007)(8676002)(8936002)(5660300002)(6486002)(41300700001)(2906002)(4744005)(4326008)(6666004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3w3IR0yhc5XeK8Fia4UxR58uywUkKUy+fkJwP0wkxt6uK3kqGMtm+GJ7wp5G?=
 =?us-ascii?Q?ABnuLvhJKCJ9LnvDeMWq+P7WF+4znOBDCIMSf/jX5dxxmbo2y8MatG94Wl0S?=
 =?us-ascii?Q?LaemO5i/Aeznxy4DusvaBWm4irpzQNANmbH1yVXnryBFyMI4apkiNoFwOdoD?=
 =?us-ascii?Q?EOyiBzfwaxRBLdgFvjfaH2OxIpH3zf3ak1C47s5k1pN2rtTMDS8NX1Xeqyqv?=
 =?us-ascii?Q?CVL6PmhSIJiQ8dRQOSYk2kqheZg9ASqTDe4FF13cvDkajbq1hYT4PZuzQ/kY?=
 =?us-ascii?Q?FIxO4u7DBcL/eCbR1yOncm6PAHMR1uBsBqiaMODL5FFOtwKhkG39MNN6z549?=
 =?us-ascii?Q?XJe6OzmW8s50dvFwh5TKKgtasS+WHtEkKLE9QelravImwt+IOIySCxe9LIel?=
 =?us-ascii?Q?cQvOJ+xl0YMUZE8AYggIDTyFHkOlpl+QDPbsD7XXJ1LKZDmD4t1ugbteeHy1?=
 =?us-ascii?Q?r92/J6Tj6T0x3vdPg8E0ZrwUrBJ/qWobHU4p7sA9113i1Gc99bxkfhxMSfxE?=
 =?us-ascii?Q?0YBG1f5ifBGbibJ0gTsFcs1f9jQmzihnRmU8ucK8qfyMXDIo03dbuOXPhFFe?=
 =?us-ascii?Q?wNle4V5Wdf0nIw6SSJTGEqCghxcAjXc/WwWZcjPgCNif1kt4LC/rBxb3vub5?=
 =?us-ascii?Q?pVReW9VsAz11TrBU4/daOMy+kupjAVkc5RgOIPvhhq0vy5oKzZdZrtM3NyOj?=
 =?us-ascii?Q?Ox0Yx5W6IDsctosuukO9adVeHAu6G/XEeZPHUOrOgnMjadOZ9u8Dq4JUROfa?=
 =?us-ascii?Q?/Z/EqzZYu6Ay8YTON7H7O1bxBOjmdz83a2i/10DpwSxHYe4jcjjGBXSnYpCL?=
 =?us-ascii?Q?dAVSxXUx5H9RPQ9bJLUHOWzzeWVJakDDT96TViHQeG+sG7VonxVsoXJX6tnG?=
 =?us-ascii?Q?WSzS5w12w9eQttQoCHk6yI8BWduNL2y9aD7L5KIJLfB9k6Ub7C5D4oZW1tk0?=
 =?us-ascii?Q?sfG911dGO2ioO7omPgUBg7r1BWJssKWJLEXsRtDVYMbabYqvhZrOwwXTeh4u?=
 =?us-ascii?Q?e8FaCOqCVspDWw/0j9K/mO4iu9vPbp5eElstnIfVTPhu0OgjPlWv615sWLBn?=
 =?us-ascii?Q?HpaR/JyaYUArxt7OY+ZZGh8fr0a71mJgdSA7dApFWEwE32Xa1awlk8/Q5p8Y?=
 =?us-ascii?Q?z9h4Mxxj2aj56mKVyJMAjZu0KQmtHzWnQUWvPOyG5C1lRSyJMY5yjkwKt+ZV?=
 =?us-ascii?Q?WBZ/Nvk8OOVBZ7qHXJEjVuLBNmzeFmnN4Uc4O2Le6kP9YuYEYYZ6uoiWd3TK?=
 =?us-ascii?Q?IlxCtilvtVVfqQblda3bgsossM6I7JfQEqmDlGpYhmB4VIIRtprYpN3HP+8P?=
 =?us-ascii?Q?MefxxujPYS1chrlMUrqS3pndQZzNgwfmw4eSw3aloY5n9xrgofPJmQJ3N/q7?=
 =?us-ascii?Q?u4Uy1B+TD+lW6CTwnfosRf20rAtdEiCFIGfOdoqsNcWImmGDEd9uU+96U9Tx?=
 =?us-ascii?Q?Us+QrtDUgyORpMgUyOnKvNbErxRZUPszxay8AGVNKNgTLCsJNXFZ58mWH/nh?=
 =?us-ascii?Q?ASBNUuIh9OYHBVH6ZLf14t7oAaSf/nvrJJJEFbOgTM2i4AjFD6ee8B7iOYQq?=
 =?us-ascii?Q?AlWnIhuJt31dWEoX+K5RFHhX76wmsq6uI3KUi4NeSm6gm+3JY6+mivahIfMZ?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YMRBG1xYKd1nDwBBaMnZL2OMD9qbkXU0bEMRPRGHuGjmP8YhxKIVcxoeE17z?=
 =?us-ascii?Q?N4T5BCpZCWVTU7zBfGFLUXSAWHjFEQNY3fR+Rbcl2Wrez0qfiGbpv7krZEyd?=
 =?us-ascii?Q?Zm9uJIcxm/yzUF1HPuasuAUFAYF8rxjqBmCYLr/ahHH6Z4JcPC1DzdVNdj/J?=
 =?us-ascii?Q?ij+KFluAhoazbeJzhKsMUfU3AdrlaGVHM2jGc+cAPKHQ/IGKehRk8WguypeZ?=
 =?us-ascii?Q?S2QAgjla3dYKM5NjWtIOuXHH3S/LwfPoPE9E+iP/dt/w5kTpklaUOJBSCITg?=
 =?us-ascii?Q?8uHEneE/VAZ5urTJdjVvLRPhXm4UsunCiaQKrKm7Jipn3owWDOWQAwDGhLBe?=
 =?us-ascii?Q?TbZLXWvlKfSVpXdXysq52Dn5Ds4TPH4rMO0qdOcwwZsVkbJZgap+7eXtjHUp?=
 =?us-ascii?Q?6PyiA7Ik0t/yUxpYBE6gbmVKJinQsHRHeMkpxDW7SQZTxyYFdcIPvzS3HVrH?=
 =?us-ascii?Q?vFS4DwrxbiJZEgVnG/2ag/yX6r3f1tIXb40FMSNBUUk2BoWXzQwKGbF2qrKr?=
 =?us-ascii?Q?+7oOu5xQ0n4H4wVAf5j77OjMn012n6yK49sNoP5Cf+5vpy8lk+VbyYd3UR5U?=
 =?us-ascii?Q?UApIkmFW1GvwSB74MiqI9/fcp7aZCq7i95frG7bZDwX5Z9F4btpAPHZiN7Hm?=
 =?us-ascii?Q?Hbqak1xF/fnqVOCKMQprbNxKZ2bkiN73QXfBi0IBQklCKpKkTD/AxFDWTR57?=
 =?us-ascii?Q?59WoZb4noBPBST/DPEyKZzz8gr05+TWMbunlI+rlKTQPraQxEX24qzI1sVJu?=
 =?us-ascii?Q?gKO19+UmajLembYd2G1hZq+8/xr6mQ+BRSng+e6wL97jkEYDMDlY2Ie2e54k?=
 =?us-ascii?Q?y9VRzFN+Nn61sqcaNBsPee+2KYysE6qQMOOFLdXClJmmTkcF49a9x3g4zuNk?=
 =?us-ascii?Q?AYLOTNUyheZDrN9ZbTOKYYdlCjmur+cFXHyzBZhwYS2WB/G6sfstlI7qc1xV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17104d3c-b7b1-45b6-ddaf-08db45a8715e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 16:16:36.2913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbe63s6oZhcpEDF55cs8NoSosr1Nh0E+QnM70Ei9UfT+v8UD4hVP+iixicjpurEgV7ipLzMmSXftKydCNDvSTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_07,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=918
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250146
X-Proofpoint-GUID: rxrLnmATcaEliHPjxipIi6LNwmY34vcr
X-Proofpoint-ORIG-GUID: rxrLnmATcaEliHPjxipIi6LNwmY34vcr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230425 07:05]:
> Because the commit 06e8fd999334b ("maple_tree: fix mas_empty_area() search")
> is merged, this if statement cannot be true, so delete it.

Please try to focus on what you did and not why you did the change.  You
did the change "Because of the commit..", but that's in the git history if
someone cares to find out.

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 294d4c8668323..7f4b2ce84ce61 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5084,9 +5084,6 @@ static inline bool mas_anode_descend(struct ma_state *mas, unsigned long size)
>  			return true;
>  		}
>  	}
> -
> -	if (mte_is_root(mas->node))
> -		found = true;
>  done:
>  	mas->offset = offset;
>  	return found;
> -- 
> 2.20.1
> 
