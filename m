Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7641E6C12A9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjCTNG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCTNG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:06:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730BB1B2C9;
        Mon, 20 Mar 2023 06:06:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K97HBG001680;
        Mon, 20 Mar 2023 10:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=AbhVmEQq23dQcYQQq0cHG8HW8BtqMMxXGFGk0XdPi38=;
 b=EyKe5JyXkrxcrm3UvIzJS5j/5eqzgma6osXNTHQBD9uD3C7bVEoBh9Wn1LXbcnqf+wDL
 bvUYqTAQfO09pPXbP4R5+h36dZOIC6EG4OhOMTsIwGsh9AZjB3Ie1+WtTvzrE95m9a2y
 ZganaGcc9AfSqCek+rL7MkiJZ6VxodCFSuVlQr5j/g6l9NpffmxQg2vIAxB2FTSBdEEO
 Siw33iyqfuXtyptNOwZWyaVWcd2NjARpyfsucEb74F1pwIILgKrZqpqLuwnzzJdoC5GZ
 O2xgCyrbB35ofe1KW803qtwYNqxyA5kZnZAooBdE0Ap68bva+WnFE0nqyrHDTpiz6SQq Gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56au039-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 10:40:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KAbDdo030875;
        Mon, 20 Mar 2023 10:40:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3peg5n3wds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 10:40:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/7lXH3DnSxxrk18poyoKzHCCX62TA9NGeXPzRGyfQ7JHlRjT6XQVmNiIvHu/NqaKHN2vfQcIVgTRP1VCN41vaiUH8w1m+uX0fITtuev2/snqZgiHYp7H2u7m0pDTxVNX+Bqt+FYHAy1Zpu1qlW4dF4zCHAjSG2PcutsgrT6sITJ00FNJNmz8eoA7vTo3HSnxrVkYH1PSP/MBeXAzI1lAUHz4uVRUxmXbg/+SI6FVYU8BvBTLauHfU5NC8utnMT7S02MMPOcQm7NspYV76BPewwnrnSa1ks5UsdkbVbCGYjpnAaimcbdsV5HXlqiDuPg9kj0FkjO5+zhQULhW3y98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbhVmEQq23dQcYQQq0cHG8HW8BtqMMxXGFGk0XdPi38=;
 b=J0nubgX+68E863rjsUc2YX/4is7WrSVUkQ8MyFynx6U5iAey0IYCqUydp9IfaAAYwTkEhkvjzudhbKm9Nphpeb87qyBst0g+8+31e341/+SyDpzDQbTR4hyZqLof8zBwE3ksIdhmZIbIs+ozE5/0h8L5zWujqk1qEX8SvlXk2X/TwdeIY/UWDH/bPfzOlVNESn13tMFvX3Nuj84HFtJ5Y/2dVKfnzoueTK+S6TJyPEvdfj+pag1LS7sFqJiOqxoKjw+OXVGZqhqPaht5/vSyzDJyq74MzEnlPk4HZyMx12sDvTqf8nbwxOp3FkoY8T/6MJgWGVOaU7IYscD7GPjlNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbhVmEQq23dQcYQQq0cHG8HW8BtqMMxXGFGk0XdPi38=;
 b=SoritgYQAId7ZXk4IOy26b4q61UuqTmSLzIGJnrPTtzzEXb67FEiWnFa6Y+UAMhQZFAcyGigP4ozkU5nbvJPerkXqSzqaVEslLaQJUv6SpKugEnc7becYixvTi+WghSv02zCvLtJIVMAerhZtbgTVJqJ+KZHJ7Vh+KhFM+YUg4E=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SJ0PR10MB4816.namprd10.prod.outlook.com (2603:10b6:a03:2d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 10:40:29 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 10:40:25 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Lee Jones <lee@kernel.org>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Subject: Re: [PATCH 10/27] leds: remove MODULE_LICENSE in non-modules
References: <20230224150811.80316-1-nick.alcock@oracle.com>
        <20230224150811.80316-11-nick.alcock@oracle.com>
        <20230303105341.GC2420672@google.com>
Emacs:  the answer to the world surplus of CPU cycles.
Date:   Mon, 20 Mar 2023 10:40:24 +0000
In-Reply-To: <20230303105341.GC2420672@google.com> (Lee Jones's message of
        "Fri, 3 Mar 2023 10:53:41 +0000")
Message-ID: <87zg87u2nb.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0652.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::13) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SJ0PR10MB4816:EE_
X-MS-Office365-Filtering-Correlation-Id: 64026a83-02a4-44c2-07eb-08db292f83af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZPpI1uAcm8dRHkvMGWL74FaFlaMuLToWW4HZClYp8IAIBZqb+Q/1fQgsXgwKkO7YsaQCTAW9tidWmPzWSaUqWJ8QIQpMrqR/1BbfLxtvl66JXrzoDdvyt8sBDp2iGHUUCFEkPc8oxWNOGXlKbT+78dElh5bpzLiqokuzatxnIBSVmgAPk/Pche5JDWAGBQuM05qSGnNPGje30FFbVGIoejUmlOaNKnlRFCU6vN2858AhZRWRyazR6Lg3rfeOs3+kwxsszqjXPRcEyLsbXO6sgIeqT33iOy2JranOxI4ZECTjM9LhD/JYGKyt8e/M3h5EOeywRFugVW+OmlHbH4hHBMbLG8SGE0CSKbzQxbie2tWvdbXz1Y1jLbbCJR0yDl0UyGP0LDudA2dxoOCWUhnsFjMdNCyJU6uxxm9eN7M758XPgtxX994ZyBgqJYLktWlc5NuvcdFoI8oYlkOC4xvoQonaST0EGCPLVcKWdSjm6OhWSBzHejQl8vckM+8Yn/X5BygoOMhHHIKoJT5z6EL/3AXpXGU1DXUljFu+CRgU/sYx+Tzjgai9bwXYXqfB/sX0JmlG+t2Cqva6PMwJ4XnGQeDQGNhRmr/TOQRWFKV6XRSOLweSn3AJrkb9lUCCvXXhMy+yyp8aq0fTUt9xnSI12CD4/v/xJnPCa4YHp8QF8s5L4SzBNRncusBt7yE8Ftp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199018)(38100700002)(66946007)(66556008)(66476007)(6916009)(4326008)(8676002)(41300700001)(316002)(54906003)(478600001)(8936002)(5660300002)(6486002)(2906002)(86362001)(83380400001)(44832011)(6506007)(6512007)(36756003)(9686003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nBQXVXIpMHoJBBAisw8N6LFLmF4kTbX7aBzhiLbY6jCpbsg4WnfmHrDxU4hD?=
 =?us-ascii?Q?TUhh/12iapWehp+NVqet50gHnJwBVs1ZSfaA4CXQL9keawtjdr3fU48zUf3N?=
 =?us-ascii?Q?PTy7CTxI4zT8Fh3K5LkRTPyd4KXSrR3EzJxQ7LQ3taFlQnlu2KQKv1w93BrS?=
 =?us-ascii?Q?YfVGQ4FATERkxbGdVaQBFfCBzKDtEEu6TCTiOnd3BJRXPOsWW+DTGBJx7rXC?=
 =?us-ascii?Q?izjD1XQPMqPl5ciKMt8/O9rHh1MAb5aJ5dn5IVMol6EAQs3Ff/VW64aoAXe/?=
 =?us-ascii?Q?4JNxkEvcpmsgzmKxSaYGfGIFtU+Gg8moUJLydDQrQ0D6jE3d8cHI5plGNYIG?=
 =?us-ascii?Q?KucSKuYOgOCoIpMHUQcjBKgarEdDdrdQ1JuWjeRCnQ/up3MdU8FW61SrVPMY?=
 =?us-ascii?Q?eWb7X9kZMZ820dgELnVhzDtxJVITBe5u4KSef3VCfPGeQ6SUg9o5W+OmLGgf?=
 =?us-ascii?Q?1BBsyfmrOQVQrSntsvMD1pXeOuLZ9Mdr5u+yXYKvKPb468gUcVfkHpEEeP+r?=
 =?us-ascii?Q?mxQt7VvMB59miXwXfP94M99jgqYI2AbdGrMpidfQshlU+XgqpJfmURU2Gu1y?=
 =?us-ascii?Q?G1rXPA7UYn3KqENByzrwbEgFkrYFaIAPtFyoI1u6Em34yg6i6kDCm7BJzGMH?=
 =?us-ascii?Q?X8mu8ew99j+hccken+qKVFQr1O0yfDpXaRlRiEogBaIlDaj6zoKzWMgu5XvZ?=
 =?us-ascii?Q?AHsSRiMrwz8PGBzrA1A1KVm8OZRpjzQwr4OIi+BQu3iOXu/nbsj7Jsla6HQU?=
 =?us-ascii?Q?B81yCM3wUNi4yM3RJA+3MYEAEEmNaJSSdTH3EYGsl7mqLy45H5IAdNPNts2v?=
 =?us-ascii?Q?+bVnGrdOGp6pvOVx/ObZ94dljy5Vo6YEbqawlqpSxT3+Yh1Nk2wwZs6FFXiq?=
 =?us-ascii?Q?uj2lOr6gGSmk6xe2TNeZuW8htmMGUu7Y5gnJccAS3Kojm9V8rA05ANCZGVbu?=
 =?us-ascii?Q?LfM9tGHZl/A3YwTwp3dMNqUk0E7fmbJ06SsqZYjnqQCpSpaZO79BVbt5njTH?=
 =?us-ascii?Q?AXvGlytVbu0aeh2KbGyUvkxMcYh4NrVorAY2f+mgIslpe3feZVtXCA7/vFVj?=
 =?us-ascii?Q?xgNwWoEg/Oaxbj2i+OsRW8QxJ+LTVQ+MxuYdq7MQhY1et36RGAmCkioH4MXV?=
 =?us-ascii?Q?jUHB3Rxux0Lsw+z++ygllz/jMsvltXOW/FIUBFe15/zpLCnNBUbc0kV8jcyP?=
 =?us-ascii?Q?v7tM2s9u+/OwPtYlXk8PwPVNRsRfelDjZzsgBezH/lX0fqnqqMWLY2MIFZi0?=
 =?us-ascii?Q?o2z4Jt8/rvAbOu24PBlRMX5njs0HjykhUOaV1LTN3cjhBT7iOkQgFojYbYvs?=
 =?us-ascii?Q?RuGvqC0SEhsDswoB2ESeU3DDh1zNo8Rp+VFVOZwZlzTM4Z9sBJIaT+bhA2qJ?=
 =?us-ascii?Q?LuOMI/j4LT61jx4EDQXjbszOueAOePt7qNtwo9/zAq4CT+mSdirOHsvD0TqQ?=
 =?us-ascii?Q?A4xieLaSoyzQa5aA4J5lweXZo2pAATGsrJNUFr4y8UtzeolDRq6vdjr0BNQg?=
 =?us-ascii?Q?H6dzJQxgXEWwZ6Qwu88XfVh6KG61aluUGolLoJqxec0Dfeb8JRAjZgPHyaqu?=
 =?us-ascii?Q?HD3qz1A/tD8Lmt1mB2JHLBfo0b3TvKF4MAwwQTKCmQvNmkRCYbKkZ2un6Wtm?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dgcntK2A+ZXrU9dYuVIyNXi7Pl8pe1svxCqm1pmGyYA4xEd3jHVOlsr7+svdflXBXzQfptn0Ielp+DjCa/wseIIu9K1eA0mj2dzvSYUcTrIP6Tk9jUR08kuPzjCyPuneLwIdb2SCOtxnldTP4jcUxW65FEn3vctc6Fmb43xJSLnKt2Y4FNgQlt+xffq0A+24M9p/DNrZ7tKUm1x3RPD5eM1RyWcykQq+UpQlJZRhlrW0JmCw31S2OyemPo9bKz6ihx9N0APX49mXHit3QtW/LuDIADHLX2ueSvZiquVxPx9EWc/IgSbZKIiDE6PvHVTjioMxlBYfw9OOPC4lgheQDlYVHT0pKyq3gwo1SCEuKTHkR8CniPEbZjb5cQkCRLCH3wbhS0eBhWHlN/HXQlN6fHP2lxwZggFWrGjn1jSiEpKdiMBxzGIk5HhICZ+y8523cBrtdivRjAt+BBlBplgxbbeJjq+wZ+xBQazo4+xU/OzrCQ1z5BABm+688xTZwNKrLVJWsiv0nyOmXaM0nonxtXqThs1Nwt0x0Q0RMDSyY0abegka+NdCvzUmljiGkY5e9qxvU+q3/OyRZfW+3h3wkJqXhzsSpVftsI6PdONyN6reKkwZX8EPQ9+ydRO4qbaaIYKWtS1GPl6k1zWUxTGGBNWrWCv+FilCpoNn+0+hlfW7NVLzPIiOpXzxinVIJwfAyhM/dOfIqXAvnM6yhJGSzb/qcP4REIgFlkguY+Dx3PGMQaR+Skv2y8p8AqRMmP3b6H6LMVqj9dWIh+W+4xYrl+VHbnkI5fOAnO8zBQ/xXyeStjfX3CU2x4EUSJrF9ZZp9cYDNBOzvdOb9qUrp/ZQlQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64026a83-02a4-44c2-07eb-08db292f83af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 10:40:25.3795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5xpFUaJGOyJg6fN0LXnq1+OkTNrLMCd+PTRCYP+LqtfZWRtA07l1wfjsqjBbogES0eljItmt6UV5dtAkJrHRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4816
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_06,2023-03-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200090
X-Proofpoint-ORIG-GUID: txlXQfp3f1l_1TfsFEwfc6i1651D79xn
X-Proofpoint-GUID: txlXQfp3f1l_1TfsFEwfc6i1651D79xn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Mar 2023, Lee Jones uttered the following:

> On Fri, 24 Feb 2023, Nick Alcock wrote:
>
>> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
>> are used to identify modules. As a consequence, uses of the macro
>> in non-modules will cause modprobe to misidentify their containing
>> object file as a module when it is not (false positives), and modprobe
>> might succeed rather than failing with a suitable error message.
>> 
>> So remove it in the files in this commit, none of which can be built as
>> modules.
>> 
>> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
>> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: linux-modules@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Lee Jones <lee@kernel.org>
>> Cc: linux-leds@vger.kernel.org
>> ---
>>  drivers/leds/leds-asic3.c | 1 -
>>  1 file changed, 1 deletion(-)
>
> Mention the driver in the subject line please.

Sorry, the prefix-generation is all automated: we use whatever prefix is
most commonly used by all affected drivers in the subsystem and shared
by all of them. In this case, that was simply 'leds', apparently because
almost all things affecting this driver were treewide.

... which probably explains why the driver was removed in January and is
gone in -next, so I guess this one will go away shortly regardless.
