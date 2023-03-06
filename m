Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16196AC931
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCFRF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCFRFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:05:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ED741B44;
        Mon,  6 Mar 2023 09:05:15 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326Gwm4q000602;
        Mon, 6 Mar 2023 17:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=vLmm0aXXjffzDvD5zXW3QdcU42GbOpyZYLtE9luqVrs=;
 b=sxcYG7dbvvWtOACgxasRIfATiEG30F7hyprafqMua2a1MzSLEri7wHkeUhnCEIQMDPPW
 hqOMt5EJMKyeigHg9J2/XX7P4w+buouFSITv9IPo66CjEkMqPPrPE5rJh9q8kAJXZNXy
 wXALfPcQpLdui/EeHVIwzh9OXImkGnBuurDZjVxYzskRPrg3/EX78RNXLAJKTqe7QftU
 ag0ICA+CZqbPvS85h5pr39BuU9UakkjHdAdSsOBwA7cfFibt2BjGqgB7QTH3zUog9SLU
 Cqp8Wpx5MXjD+JTxksoxXDgP4xNw6XqlkOLxMlhtoulu5PaeZ/xCkvZsOOPTApIrlNej lQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4180udn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 17:05:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326G048Z037009;
        Mon, 6 Mar 2023 17:05:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4txd91pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 17:05:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1eJqDYQaOs/MgP3CkgBgdkROfkyl/V7aST0/2CYArFYR1RJN5w5mnojRUZ9cJrFB3Y2eB0TEQkmQhZ2RsiIi7oKr3viNQ75vb1q7XRrkN0LG87KiD3ESLNfEx6FeAEKBMwp6jndbTuiPAPkau+Vr0ALX/XaBxKmxI6mfIMFNGf8j/v691EVGdalGz8cdU63J902VOqV8ixsw38fiAiTi+OBNWXg82H+aSakJQ0p0rJkuuE1GS3ukIcTCa+FsZNowkkXAqwsuL7ddahmNlMYgOCWNLxRK+OY7smSmRaBrz9GZcLOe95tFUc82gBwRMdVZUh82T3DKSGvQcN4bI/l0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLmm0aXXjffzDvD5zXW3QdcU42GbOpyZYLtE9luqVrs=;
 b=C0+rRVFbk8GNmEhwAFcQrs6cdu3bgi5duf3XYOe1HLDkjCJaDkzYGZkObc7icr+JGTLr11G1Hzm/ujqLxNNdBTH4jwvFUUuctEyt3WMhTlEyBWR9IAjERGq6S1IE6HSuX54JEk1bKA5vmQHfG7mw5YiZ4dd8TX9zdAchOfzMf3r9Oo2f+2EyefHIHnfAHbQ4CmCQK/1yv9FppFIC93tMdGPuc1tPLnLkEs1iLttWwofYWes9uI7IxxQWhTSn11P6eD/K5xJiq82hDKG5JqF0ER486VK1J6Wa7ymnnrIgYu/gcZozWT/WZIGtcxH0WQbC4JYVAn46/5zHfekE10+CPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLmm0aXXjffzDvD5zXW3QdcU42GbOpyZYLtE9luqVrs=;
 b=Xba7CEBaRSxthl+9Q1Bl+33bbo2ZxCqNltK6RpZE4OT2wVn/tqGLlyKm22pinu6Z2Ku6gcdk18Eguqqr6N2KNazR0jyYUhYqfM2fONGW+j0U5mTccRtD1sAdQCeb8FMgyLcaNp6LirkwxLB2iSzhASxIsAUjuJE5ku20v3mRhm4=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA1PR10MB6589.namprd10.prod.outlook.com (2603:10b6:806:2bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.26; Mon, 6 Mar
 2023 17:05:00 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 17:05:00 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Shevchenko <andy@kernel.org>, mcgrof@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Subject: Re: [PATCH 04/27] mfd: intel_soc_pmic_crc: remove MODULE_LICENSE in
 non-modules
References: <20230224150811.80316-1-nick.alcock@oracle.com>
        <20230224150811.80316-5-nick.alcock@oracle.com>
        <Y/joT9FM5Q8Fz7Hw@smile.fi.intel.com>
        <20230303110155.GD2420672@google.com>
Emacs:  the Swiss Army of Editors.
Date:   Mon, 06 Mar 2023 17:04:55 +0000
In-Reply-To: <20230303110155.GD2420672@google.com> (Lee Jones's message of
        "Fri, 3 Mar 2023 11:01:55 +0000")
Message-ID: <87lek97qvc.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0252.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::23) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA1PR10MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: 95fd963b-f919-411c-a5ed-08db1e64eb94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LblDXfsVAbrMhak50qX8yOvZU+PvkGg5jni9ugRhtC5a6QbqJrqyAQ3vRLtYFqPM6vxTphlkRV5GiBJ7TP8bLhR1A0VesopmuEmaO1+eruW14R54JSzbolsUpa85cHAtijC+wJR85ygUS6XF49JdmXNyG0tzjl37hqFgSd7kDjF1fLAsbGONLvTu2uHWBspKaX73jXCATPH/SsgEdYjKOhJIGhpUG/1sXlUfHFOiBKWO6DXQGuiJvgZQfuEMjbcthtSKFiJ3f5rfV0gPaLc1H0gJc3ZAiMeSylWNkIliaCNe1kHEePzscCg8cdWshC7DsNt0h02CykKVofNSj4zIX86zyU7PA5Glg9yzUMXLWUmv4zAZ90yY3htzy/+35f9H7oWI191GdRgOR+S5HVF9CD3VwOKA9Y/3YDBRUMBoZ0pvDAir3GQLQlPW3OSiVjPDm73LYqc5Cp6iR1gbMsJedBbRQtPCckendOufz2pNrAuFzJJO7oI1ygcntwVaWuOnxu+uYkXb7K/VrYDljinVvibLee03xFmCakzXLThs1k9TRtxp6v9HGKdmXUYsY/ld/tzkeJulPwAFKYd6JiWWMeO5g1v3GmS3OGyTsH1POfGJfo6XUvEvdOezyUB9ym0j+nEYdZXj1ActOW1EE//aRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199018)(66946007)(66556008)(4326008)(6916009)(8676002)(54906003)(316002)(41300700001)(5660300002)(8936002)(2906002)(66476007)(83380400001)(86362001)(38100700002)(478600001)(36756003)(6486002)(44832011)(9686003)(6666004)(6506007)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YSRIcg3yqSqf9gH7GQ4qTSG9eHmZ+4GpBEysMtxqw2ZiX1/x892a/oN1iOlO?=
 =?us-ascii?Q?NjArUMX4ntRNXc/VmU7dNtkXyWMt6AApTSmm3yDROMZ5GtKvLQSyYkq3wf00?=
 =?us-ascii?Q?ozpklebvHI58cCJEIQFjrAjGRp9cd3kOvNvlrdoe7lEf0Vgqaaau/w8yB498?=
 =?us-ascii?Q?KNePvozrgh9JtO5VX/PdW0r5ylDmz30epNW0gYpKk0uVnM3TwpvUPyVRA6vP?=
 =?us-ascii?Q?8KJX+V6PFrTPuWiRzqkP+JEgkSscKqQEB97itKdnHzZWqtVmNR90tk0TAwMm?=
 =?us-ascii?Q?SfMcC0qz9pzuRJ71CXY+Z4t1e+9JVYI4EnWKG3TwWifaMjl7WMze7ad7cy+9?=
 =?us-ascii?Q?L6UGkcvWHWseslkLVhcC6Iq5pAdy7SEkqkhoCrXrmXX1msjBrr9xW0cke47D?=
 =?us-ascii?Q?Hkv+wsT8FDjCQqcW1poNN1za55OtmjRajgQzQDhLpPXAArNXn+g2B/QUACH7?=
 =?us-ascii?Q?ZyQvOMdRJjs94WK2BxRMt8XjTtlgcpAZBM4ims0Kjjin7oCu4hcgi5Ewqfcr?=
 =?us-ascii?Q?MRnlZEGymYXG3GI4zuOmTlPR9HHmcClZNRwdW7T9jjqN11MsIplJGpQossUZ?=
 =?us-ascii?Q?L6sp92S6nsyWBo98XIQJHPDJ33/yWCaj6Dmho9InW41/C7bo8wCZUKZFH84Z?=
 =?us-ascii?Q?8Ir5nvgIxDwzFvEmtl0l2LYlpk5dFjfrIynJ084W7DLQFIDVcjC7FO7IkB19?=
 =?us-ascii?Q?T6VthWpPWjisyqQnFYziZ4efT9wQdfHNPJTvD7S8qs8B7VIkdhv5FoDSn/hf?=
 =?us-ascii?Q?PJ9748gWJGTeXcNYlxTfBE/+wKGN0ANu0V0eyHrLUaAsB+s5pZ7CetOhAnj6?=
 =?us-ascii?Q?eC4hECLuN5/HFdGtbasqVKwaPm41Nr+wclDmQDO//T6+CqEvU6P5le/L6y/K?=
 =?us-ascii?Q?9dZGXdVBeKF62CekI+It7WOG/YPztH8XE9urwG3EjR+AHeM8nJLXRzIW5TM2?=
 =?us-ascii?Q?c26lTXq2JU1SxV+3nD/dH+P1KdJLv0HP/3H3MJW8nG8Dgb5nkgXm/SmGtxW9?=
 =?us-ascii?Q?C8dzhcp+1yWKvs4NGvXB3aktiXenR+3ECnh9mdDLQ9LEb0iv2UlToUoZR/qj?=
 =?us-ascii?Q?o/bm4YKUGy3qdGtn8ASadvDg+eK3qmcHHQKAQtC+ysWUyda4CRlU2FXtrsSV?=
 =?us-ascii?Q?Z9tj5Motye3CFP3Cyk8RrwgRyxr6GMERdhcqzlzZRkZE58PLla8HWwAaMKZG?=
 =?us-ascii?Q?Ved9GbiTqirthXImdsUAKgOSxBsJUmqTDh8kuebd1a7COx4UtJEGW7FcQ+Dh?=
 =?us-ascii?Q?pDpvNfpeE7XDGKSmxN5HfXgxE9pfLbhT8LneKcKqaIeBMjqrONl8jlk+aY0Y?=
 =?us-ascii?Q?OFH9+g8LitRJN+ej7gH4PBO7TT9fNYYUi5qjCssfaMkhEWMvCa7Dbdz4eMAP?=
 =?us-ascii?Q?T9ES3HlXPf+GyLlfxFyg5cauetzoXxumM5tp48L+Kdg47QSqjhC++3Q9m012?=
 =?us-ascii?Q?ykGoqfbOmJAcY2AVgxCOa2TMo+I6qLvO/ctp19x8EAZSD1LJtM1SSUAsdSTH?=
 =?us-ascii?Q?L4VNGCNKM2q5LEb9KZ5RyxxCQZCxCZlr/AlhcLR+V6OXq1yEQ+odmZvF7XXi?=
 =?us-ascii?Q?udDakxbdgndFgpTik1hDlHLS6a2Jwa8/vh6M5v9tigndeOnUUsiy390AejNB?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YB1Z3bFCSXhvEuc5Lc68dVav07Rqv9WVYFL51XK8XmcEs6auPTKO1oeLJN7wdBmGY5EqIsvkpaDQO7XniJTmeyIgCAlDkAdHiBDVegFXN6bV1rK88Cl7WBpbt8HQsbXQAcd4CgWdOd7MUKW91L09NFUktrthbekH/7eSJ6gOLopVKgUYRt6k+x8oYlAEVB7POk/tXIpsNYZjX3bYpaDuG7jxx/Ul2N0REU7c55M0S6fdNjhf31vERXftFivuEKwPfp283+864SGRZckkUfsIHpRCZXXgE9RggYtnjFQEvRV6gRWM3DFkM5SzYysI1jOJqFJhQWoR9kOUZchuI8uzidlnEqi4eIB+h3GJPbC2x2HkT9E3gZZlJwDFEJFvUD4lC8k8chfhM765oAWZnkr7A+8kocL6oktU7F0z1svwnBCyskRSoUU3lj0uB8TbEX0wzUH839TOAKItpsW62GedKThcK986zfUqXZmNyqH/sK4hOolWRemsR8jVh+TCl/LSWBj2YOHyzkx1ptgEDPgy+nBnWYZF8C0xxHfTMOA8rxv1OJB23Og8zh6CYXr1Wg2D2fliSi8HVNqIi6Tf6FoYg8jvPDkk8ao2NkTZlq299WZhxl4BpoptTUKyZPwWpPM2nMhGYWZ5ABxvii3qjYvrd7R5j8MXRhcdakrqXUaeZ/em+5+gV0dGVA7n8L4UZpH3mB1w8P8FjnLvBm3yca9o/lRWr/XK+lRDHKwlXy64FwVNrTxPpP+bae7J0XkVsqQfgwiNeG+PPeOwrt6ndXPesi7qCY6kXMs4s/s+MXZ+r52OFU4j+Q8f3wRnQxAdiXLy
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fd963b-f919-411c-a5ed-08db1e64eb94
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 17:05:00.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3IoHkgyLBTAOshy+V/R0yR9LXl5UmbUIgH/Z2QjdUNh4hEg/Gi0Ne2t0iWAXiMe+iS6JvuESBrnqaQ3w2Mrlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_10,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060151
X-Proofpoint-ORIG-GUID: ixnNvs6fwVjzFPnoKh5CtbwSNTSgsb16
X-Proofpoint-GUID: ixnNvs6fwVjzFPnoKh5CtbwSNTSgsb16
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Mar 2023, Lee Jones spake thusly:

> On Fri, 24 Feb 2023, Andy Shevchenko wrote:
>
>> On Fri, Feb 24, 2023 at 03:07:48PM +0000, Nick Alcock wrote:
>> > Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>> > Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
>> > are used to identify modules. As a consequence, uses of the macro
>> > in non-modules will cause modprobe to misidentify their containing
>> > object file as a module when it is not (false positives), and modprobe
>> > might succeed rather than failing with a suitable error message.
>> > 
>> > So remove it in the files in this commit, none of which can be built as
>> > modules.
>> > 
>> > Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
>> > Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
>> 
>> > Cc: Luis Chamberlain <mcgrof@kernel.org>
>> > Cc: linux-modules@vger.kernel.org
>> > Cc: linux-kernel@vger.kernel.org
>> > Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
>> > Cc: Andy Shevchenko <andy@kernel.org>
>> > Cc: Lee Jones <lee@kernel.org>
>> 
>> Please, use --cc parameter instead of polluting commit message.
>
> I personally use this a lot.  It's better for scripting.

Yeah.

If this is generally annoying I guess I can rejig things to use --cc-cmd
instead, somehow, but it was very convenient because it meant the
machinery which split up the commits could also compute the Cc list at
the same time without having to record it separately, but I assumed it
was routinely done from the number of Cc: trailers already in the kernel
tree...
