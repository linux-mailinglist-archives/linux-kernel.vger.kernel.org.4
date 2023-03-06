Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA126ACD82
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCFTE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjCFTEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:04:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B1219B4;
        Mon,  6 Mar 2023 11:04:49 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326GweoN018546;
        Mon, 6 Mar 2023 17:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=athDG0ii40dbiAOBzQSObc/DVFrdeX1htQmxdrJ5B9M=;
 b=Sv9GqHOWshPPJQcBj0MQHg3FBxoi8jDmN1DGdcPKgkywd1cVkY1QhzL/8FQlDYwwI/0D
 VAp3+Cd59gN1oJ0qCZy0JDyr7Sr25e1Z1k8oXB31aN0lQOCeO06ABX6oit+kpeF92CiI
 ha7MKq/H3ucf2nkG1gD2G8UAMdzF4CwvJviUtVb1hUzaPu8/Thlj8+cUTNo/0T5m++bg
 scJmkDF8qDcS2U0qZslAjhgkcbdkpom/x7qQyRodspGvtInALrMA5ERiPamNrYHmyK0X
 X1wJ2Cj8wudkkwbD9+Qegs4XnK1THyVA/n7apMd9SIxG8+1BxPZDz7jQmCaPwLTY3p2i BA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415hugb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 17:13:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326HAP3x008836;
        Mon, 6 Mar 2023 17:13:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u2ghmwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 17:13:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4dX6+fhWkWh3ETO1KCXQtc9s56DVoOHFT+aKE+crOAicBXuJeP8QFC25jf9KmtRh9xgyaD/OnatwnrpV5rlsv8nVcDmzWC7eTbe5SXAdfwDQBlGns8Oop1SxikoqJsJOKaQXEe4hxTAXuOjRevW+uFCa2S3ikokCnFmGl/bt6LC06kQ1G9PpJ9jtz8aRBO8saqgOX8XT6IkiaetXMmqoixujlDxvsayxSqzqqe2/DuTO1i6D93yZoyTDWtw27ubObYlF+62EsQA/uYARrYMKhO4yLw1/lERrNtjy1TBKzAEeQEnVFZ/LnVqD0+h083CSCLkrLPyvjSmscdx70udjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=athDG0ii40dbiAOBzQSObc/DVFrdeX1htQmxdrJ5B9M=;
 b=M4XTyZZn5CNvswcqX9Ai5DtEmpiotZWhOHrWZH2rx01Yhw4h5irpb1qWb9tIhOpiQMr0p7Ev1Vf2SXXpxKW1VZkdKADbjF/wvUDM/IE9Xjm+XskhQj+LxX0G7bfbrQe5ARA12Eidvb3bmlAfycduqJAU5iyAPTqCK1vEBtfeiXptU2UUjRXXWUt+m3sg9tLpzJK1EM51ntoSOL4ISmcvQi+ux0AUq5Ep3OAKRPh3R6vPTrZ03X2zducooNAT0jPWGNKfKp3kV95g4HwhCsPeB99tzA4zPY8w5MtGfON6xupw8paD3Vew/6HjEJWPjKpRQvYSoW+EiUw6pDvZqJ6Eww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=athDG0ii40dbiAOBzQSObc/DVFrdeX1htQmxdrJ5B9M=;
 b=qvXhWBuuX6JJ8T3IIxdqcP9nAEF43GmFNGXYS/k9aCJXQXaMUN0xTnZDvHVk+2KmoIIznkSOdm0toXM96yDLDPC/p4E74fC619GEf9L32xjukGM0KsKGYIDNJf3L4iVxtzBp1tWEbsSlRLMnLsg3lBQjqOrMSpStwCp4bOglbtg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CY8PR10MB6468.namprd10.prod.outlook.com (2603:10b6:930:60::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Mon, 6 Mar
 2023 17:13:10 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 17:13:10 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 15/27] memory: tegra: remove MODULE_LICENSE in non-modules
References: <20230224150811.80316-1-nick.alcock@oracle.com>
        <20230224150811.80316-16-nick.alcock@oracle.com>
        <c6f39365-e840-d782-8ec0-e34ec3681b98@linaro.org>
        <acc27e8f-73ce-39ee-3666-461f5c72d39d@linaro.org>
Emacs:  the answer to the world surplus of CPU cycles.
Date:   Mon, 06 Mar 2023 17:13:06 +0000
In-Reply-To: <acc27e8f-73ce-39ee-3666-461f5c72d39d@linaro.org> (Krzysztof
        Kozlowski's message of "Mon, 6 Mar 2023 16:45:31 +0100")
Message-ID: <87h6ux7qhp.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0491.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::16) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CY8PR10MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 48863e4d-b45a-4002-7b58-08db1e661004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jEowmeT1Gt3DTtONWlAowNh57zg6EMxkpDRBA8U+4alZE6RnuycxSQ2YsVWuRTXJSKiW4vrL2BEP/7bGBn7U3ZvE/8PSxfG515ZcejtsCuBofTIP1ztQHfVJIABqiz4BnhTSEoQgVPsxw/41Dqp6N+2LklTsVpjutLtCs2uF+XESzA2ZsQc51TVrzbEeEguyzl4ivTrfb0sXKb3leRYoAUH1U57ROPs5LtDxLqquUUYZbeHdwVsSbNi/dZoF/hM7GlaqIt16rN/CC3GNQzbs/Mn2Y70BJ6llTkaNksBWYnp+ColdtclpphyVh8fe9RZ2yFJhZIsE/6ZdprlsRXni3nYzvbxA7pFKwmGZrRTWdXVCFDU7enNvPAJ0tCBlLMUagXSgEynKhVTELpHWfWH/9DyQ2GSDvCJO8XWJk12Fb2ns325iNCEB1NtBvUJAZJzxBe8ERWzkMHr8uabEbdT2zib97ypgV1YeSJX8Z4AH8WaSN6RMHU27t0waWpm+HMu2RSKcOPZGbEbh55tt5IEBzmE9sRwp0eJrr+5ZCy2rCb2PzRnRAOkWU9+a61a/ek55KagGFBDgFwfJSoqeUZzOTU+qqGy930QX5fJ1caDt/39ilLY2Q4nCH6dak6sYpOxYgOIwysfDkiK9jH23EGhFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199018)(6666004)(186003)(9686003)(38100700002)(6486002)(478600001)(66946007)(4326008)(6916009)(8676002)(66556008)(66476007)(54906003)(83380400001)(53546011)(316002)(6512007)(6506007)(41300700001)(8936002)(5660300002)(44832011)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o0WTZrQjNqxy8FCm93DypZms3hS6e4lj8wNes32wpn+iSnsgSFUVKRRKR8nf?=
 =?us-ascii?Q?3kXxtlUrkV2FS2+gGAiF0I3nxzB1SdIHTXIDUS3/9EwBumvHGSBicBmlnRjU?=
 =?us-ascii?Q?FkaS8HuYYkE4+FEaVoSEVP7Z5ZsL3X5/FfngeIjqAAZ3pmZreGgSQgefvWO8?=
 =?us-ascii?Q?ZiJj7ILHgTRh1p6F3DRsZ4lcrgD9358Mw8uRoA8545y7eDPw0FewyJz5HwNs?=
 =?us-ascii?Q?MCnNHkg832Fkwz91/005uCo9SUViFE8Sr3T7sG03UgFZD8lC52J75Xe4Tkl6?=
 =?us-ascii?Q?xeJio3Re9zJkrE/ZVw63EuMAJqJgx7nyN0955U/hnTdcCiY3i+f75y4DqUR7?=
 =?us-ascii?Q?w+vKDe+v4ubCPHCnqo1znKa+nTQLUaEqI5JhiJ7ffP5NtA89EGA9r2zHvJRc?=
 =?us-ascii?Q?HQ4jkdcREvu/8fQtEziGaszZ5+MbogM1XkNTOAgyZjl+Rd2h+P9BQlpMXIRo?=
 =?us-ascii?Q?MxTnVWFow6pnvjy32Sl/Wg0J+ihJRt720p6tDzk7N2p6yzB314bzoNOr1P+t?=
 =?us-ascii?Q?fLs93g82au93Rl5Byr5nQsDf5H7VIv37UcavJoM+V5GsRRn7SEslYqigC3Pu?=
 =?us-ascii?Q?/vMHoJTZf9N2vTwqLvYoQTVCwsLDqUF1a05kYLy7wMffsYagrkB0f7xsf/+F?=
 =?us-ascii?Q?F9KRYX+u8nQC5j1nccovmrwKVabrOpYwl28wrTTnudWdDQ63VcASWX2ajP9C?=
 =?us-ascii?Q?v0/ItRkJDMQOz2UyceIt78tjhSXWsgRoilg7zsF1+yHFVf7rzlMS+bdVZJ/p?=
 =?us-ascii?Q?+LjlG1BZLGgDxrrfr8qNmUG0SpPO22mf5wAI/u175LKawL7VlgDF+/bgiUw9?=
 =?us-ascii?Q?kFpu3LXwZL2kHldUjuCDHHDyFMDYokLZqIgwrulZzhp8VQIldLfhpHREBS8p?=
 =?us-ascii?Q?DcBZfFy5pA+jgRzJo+2yoef5o+1so8KCzauvQijdpDjoY9KkUTGStHAiOaHh?=
 =?us-ascii?Q?oP6V1C7P0KfDCEdG92QmWRYeXrAaPnHne+hE26AKQy2RTwhiqcSU+KVyTC5R?=
 =?us-ascii?Q?a3I4e5yKCmpZAdFQKyhDLgW21/6/hyBdaH6oTWZSkFqeuQ+B7MYOmanC3GpV?=
 =?us-ascii?Q?rJzLbjUcrFZ8cSJ0/mTq/iA5MfKnmYUIG9tYUxAxJcV6xmYUN8RZgvnU5mfO?=
 =?us-ascii?Q?9oBOsBjIr0j4XmTjDNVqFgTzz1Oe8iav95BU2jDdZ7PWAUL89bgHbf9crRbs?=
 =?us-ascii?Q?Xk+14tqdvTHAWSgG5qxPeUIp/BmDcWiE/vI0/Btpm61LsN80b1EI5i8a8Qh0?=
 =?us-ascii?Q?DAeH4vE9MIKuzXaSHvf1k6JK+qLXEJLhE8JOC0gnwVGiwQ2zOnwtRaqJA0Dh?=
 =?us-ascii?Q?4SkDbsucwmmpICROFoxz8QD94GkqiBSZHImlG6A3CGSDXWV4uTn/m5o7v87s?=
 =?us-ascii?Q?1asNdJbsz2DOHnecgIoFXQlh3xcj43AYcOybFKmWQoV/z8+7QSnJJYwq9Dfi?=
 =?us-ascii?Q?Yxdh9lw3WTS8ECQBOXr6XvFBcOqb6xWtn7ndvC200S7olbo68YVcW/cG9rhR?=
 =?us-ascii?Q?ah2ZKeNhisbkK7Nh6T2Z8QmXnCEbyMeZSamrwcKdfL/WgST4iVMYtuxKbZad?=
 =?us-ascii?Q?o4tzE3u/iXc8Q7b1lJ/B+d96MwwEvtcs1vvPb/sHH7x9jUn/ej7HW/UwiqtC?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KHGluWR9fKnu2q0pqEqkfEoqZan7+/J588HeZowqRLUC00GdFiquLjeuB4jtUb7m/+XdA2BBHRcs0BB9Dje0ofXcemEx/Z8N+3mcyKPQGeXFFvIcBNyhvBc56BPhtY+a0MQ5ywRvuvv+UT/b36h40ywEHm2KW3fFY0NOu8Eau2GDsRs3UIUOHslJgBhmcWH0QN+Ww+IsHd4ZwrdhxMNSpSbHc0IpOU4ssPCb0XvD6kbuhb0pGjkRoXwOTMJMnbDa/MCAC7t+MwGGkyKlGmlBWSuuo1Sp3GxxDuCCgzkKAKsewZehyx3XG0EneYbNYz4vtJXtGyKbc9DJJsrJ5xzAWcL7Nkk+ViZSX8g8Lh1h7V2ecwOeWurMTfJ+79bXH8+k2EMe2BVTRRAGLCWhk+Zp+IWrPw69G4RGALvYFl4KFLZ4czx2rysVwySwT4zb2aBStAQxHWzCwvkzsaxctRGGnYxNQES8SfYLunPDw+FbiJ+X8P1eeXbWlxKec0w03fNX5JhGA/klHNvLKiSLJh4fzNW9JlSjuTPJfhFH+p6EaAefeK2/g85drmIjaWH4dAocXsrjlo5nO+669P/vExVoTFS/RZq/O8gziicj8jclkxXBhr2ptZgOD0PZ2YMDFwSr9b7b95fP4OALuldsZfyAq37xWk5/dw9Zfz80m3Sl3STuafDt8PtbAS8st2zQWG1AZKwzf6DYpEfVO1On5+ZqtVw+enxLevc2BsGAxJS3ByJyMdWT2G32JXqAd9sARqKjMSyoSy2+G1sm58Zy78Bi0KZmerhvMy2tYSEqBTivkISdCPkNpdALWa02v+/2j3PlLYYAAy1YzNKA8e86zt+aXscPfRLYj5KfOCNbrHLWVGdVmykEn00EWAtzQVUJjwtjortho6qtejMwLx93o2HcyA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48863e4d-b45a-4002-7b58-08db1e661004
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 17:13:10.8065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7Q2ScH3x/4QBhEXj5Nmi+3RZXmVhQ1nda2ACwOPWhoA6Gp3pvh3gy6Q17HPnGb03B5qhjQLTbLgPjofS0RtfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6468
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_10,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=786 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060153
X-Proofpoint-GUID: G3D3GXejIZZUsYj95IpmxUeARq1Lq6CK
X-Proofpoint-ORIG-GUID: G3D3GXejIZZUsYj95IpmxUeARq1Lq6CK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Mar 2023, Krzysztof Kozlowski told this:

> On 06/03/2023 15:30, Krzysztof Kozlowski wrote:
>> On 24/02/2023 16:07, Nick Alcock wrote:
>>> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>>> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
>>> are used to identify modules. As a consequence, uses of the macro
>>> in non-modules will cause modprobe to misidentify their containing
>>> object file as a module when it is not (false positives), and modprobe
>>> might succeed rather than failing with a suitable error message.
>>>
>>> So remove it in the files in this commit, none of which can be built as
>>> modules.
>> 
>> Applied as well. Squashed with next one. Same subject messes with b4, so
>> prefix should be corrected if these were to stay as separate patches.
>
> And all dropped. Run checkpatch before sending patches.

So... which of the 27 patches n this series is being dropped? It would
also be nice to know what the checkpatch problems were, because all I
can see from checkpatch is one error per patch, an apparent false
positive:

ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 8b41fc4454e3 ("kbuild: create modules.builtin without Makefile.modbuiltin or tristate.conf")'

The commit message says:

> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations

... which unless I am seeing things is precisely what checkpatch.pl is
asking for. Perhaps it can't handle wrapped lines, but not wrapping a
git commit log line *also* (correctly) elicits a checkpatch error...
