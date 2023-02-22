Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFCC69F40C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjBVMJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjBVMJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:09:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6FF83D5;
        Wed, 22 Feb 2023 04:08:34 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8xZtD014955;
        Wed, 22 Feb 2023 12:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=TdKXT4GFPxhlVMKWacj9l5vfgjURXzpxFg8ADeL14/g=;
 b=d7GbUdz/iRnFvkpmfXYF0eYvXG6z/ehpcUE/OJgzPuEUfuShLRTXvcfsuYYkgav6mmHA
 EAZKPYhLbpjbKBE4al8jAnRS13mbn2bzWdvMXksfZ3M+XxQKrWOdM3pwZtumFQ1djB/P
 oFMmx8etkNUZE7bNy92hENFk8dSYpP12ALnj8OhuukgvzqxYsqbsgIuX8PPdeSEgXV96
 2WWpYa9Tc0xxn5fFblOcdS79+dZQjYque5HzGS59Tw7Z+I6NetDtq4H/R0Y70dlG0MnS
 hHSXKzJ7gJQ4bX9JeE6da+JG+gSjwSy58HbOdx+x5cFB9lWXfq/0NQ4qN0QFEzr4n1iH dQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnkbqng5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:08:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MC6Obv000505;
        Wed, 22 Feb 2023 12:08:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46fnpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:08:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anLdeYe1iQCxaB1U3Mf0TWfxwxnQTNKARZL5tF7XtlGNI5XemnVV92ya++TlG2UDb8ygbg3ZiQ9Ss2bGtmsK9zgvtMdB+LTe+WmxacH2GNgwcnjim4tdp9m9wv8AqdrqFIRpRpNtB0wx8JKfaFhzrGhTb+H7H3QCuQFUKX1EVK5CTu/RDjElfglsNMf8YyCfaCHzoSbnpHmXlSsL3/kvrxU1PsJA/q+b/bEaJfJoidt7z9vs5MPDhOHep9oK8iIo1SNfwn/2F2YImbf5uO+0KQ3SjLxJQKGbZrF7OtXuxKiT3tUfqCbpqS5cea4dJ8BaAS3lRdq3Ryueg99yfCUXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdKXT4GFPxhlVMKWacj9l5vfgjURXzpxFg8ADeL14/g=;
 b=e2lRsOaSXiAyGEg9fGc0RwJG5DWyPR5Qw6/SyMX8gDNeC/F8njQC/3I/YMD4Ny93rde1CpdvaU1Mp4VIloZLLmYK8vU14e8x18Wve9qzuEw2WpOqaSbKIwUsF3vnHId9IO8C0SeEFkb9+va8LfbJ696Lso5XyTA8SDXQULzhDNH0/oZFURDimD8a42flyd78PUpdtLPqrTzyBd54Sq7yZOlXOXpt1wh0WcdrdavP7sI6zcvOC0SrmYEW87PTGgOLVzFc17+VtKQRgdYGmUTw4vuq5NRQOgzBHg4D8k8N6cD+L0+b5fquq1uhSkVAf2HTzB9L1jfQnEAYt4jbj0OMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdKXT4GFPxhlVMKWacj9l5vfgjURXzpxFg8ADeL14/g=;
 b=YlkReCSc6QVCCpzAkfqM2YjAhJnrqUDB24sZpP2WeMrRDrvH2Dl4nYVjcE0Yt1qvJrGKpE6pnDOZ2hU2YDlLiuD7p4kXH09Wsk+1kXLqyAlyDYW80RSFQWheQq6Ory6fILY9lC9nDs6ur1HlpoYzx3zzDvgcHw/i9uLjJH+4NPs=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH8PR10MB6647.namprd10.prod.outlook.com (2603:10b6:510:221::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.16; Wed, 22 Feb
 2023 12:08:18 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:08:18 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, elena.zannoni@oracle.com
Subject: Re: [PATCH modules-next v10 00/13] kallsyms: reliable
 symbol->address lookup with /proc/kallmodsyms
References: <20221205163157.269335-1-nick.alcock@oracle.com>
        <Y8b8TOJzd/RZXR8z@bombadil.infradead.org>
        <87r0uy3hkw.fsf@esperi.org.uk> <87bkm22y6e.fsf@esperi.org.uk>
        <Y/U8MuL24OZzbIIp@bombadil.infradead.org>
Emacs:  because Hell was full.
Date:   Wed, 22 Feb 2023 12:08:12 +0000
In-Reply-To: <Y/U8MuL24OZzbIIp@bombadil.infradead.org> (Luis Chamberlain's
        message of "Tue, 21 Feb 2023 13:48:34 -0800")
Message-ID: <87edqhsy1f.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0252.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::24) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH8PR10MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 06960536-ec4e-441e-fae7-08db14cd7bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NaJlhVhC/OG3cT2sp6Q/9J6tbLfG38HbciLCkD7AcK3xPU5YkIu8j846MPxP5sHW5JUs6FzUG4Yl05Tp5MXPYUTM1uGcuTRMujktErSHnuTj0eNnax04oD9fLsZtyH4V1mXuMmtquP3CTzt55BC6+M9AW/WOfnSbU7d4cbCmDgtr0iGcxtrS39wkbURpqi79lHASZPzlIU1UcQUL9b6P/7YEChtoX4c8x8NjehZMvIxT071NH3jlABOIJVqlFBfJL1aXAeJe2N+zD8rZIoZLQ3Z1cvOiAwswxns2z7Yt6eH7ZFdCuACEefUKG6kcJAmTUv8QU8IwmRiTVSo8qC1lZTOpHIscHnlU0kk1a1OGE9fRSG6SFYrqEpPIS95uHSNtMdPbvfERlbeX8TZoT+jv8+B4cZa58fO3Pm1dvhZIRNlxA9l5FSkjsGYctiXMo31PfHFAtIWibfHWcCc1heJWE9AWTJI9AcvCbQsAYNzxwJvMC46RN7c1pH4w22g5JXV1ICS035JaNfnX12mEOTE1LQYgIsv1fy2fwrbVxt2C7dhcCXnFazaqZndWljwfceu7k0JJ3zEqhsDVyfS6QJy5R3sJNKcpEDiZgq0gq12wSlz/+SYqJwHW4QFIVQxx6Ygg2lWrTcUuFHJLj8zoctT/wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199018)(6506007)(186003)(38100700002)(6512007)(9686003)(6666004)(107886003)(2906002)(83380400001)(316002)(41300700001)(6486002)(478600001)(8936002)(44832011)(5660300002)(66946007)(8676002)(6916009)(4326008)(66556008)(66476007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OucIm7bg8ZJ5DIIldwoxLG8aotigiUb2P9XxTKYHABu9XvyTqszBjlBVZM7A?=
 =?us-ascii?Q?ROM2Z9GBaNQKmH4uEa1TpYT59c9tCorgABmzSnXgIhn/C7Rj8OFul6o9z91i?=
 =?us-ascii?Q?WavyAbBFGm4SdmnPS4H5Eov9LRvK2Bv89m/fMjtV5tJSnhjLniZnKUei3o9u?=
 =?us-ascii?Q?G/l/wIH16Cmx4RnekO+TrV+ctQHmMI5sGNSHlKh88JRdl6zuEnAWfc/X8n4S?=
 =?us-ascii?Q?R/bzXxbDGWiW2YvQUp13Mit5PDKxR/rzJ9RTrNStM31Qvd7VQS7a/IrxgZox?=
 =?us-ascii?Q?lwye3oCY9FV8u+VcwGjsNTPMszT/tzzdKMkigyKm01FHFTZMaLJ9o1a+ukaI?=
 =?us-ascii?Q?yTVc8E1o9WyClcpe+1dQ6ZNQXv1dHmFjWlwebbyjPlSbWkO3p2loS8FF94I8?=
 =?us-ascii?Q?f9Bk9KQi7a8vlEd2I3+wwgmW1BdVUJ/1VOHjpSd69RuzZdzByPHQ5mM5sH3F?=
 =?us-ascii?Q?ZDttecieqOigb8ANrri2Pcx6/AQlYDVCwIWS75E05Tbh3ZYtNOhHe5fesni5?=
 =?us-ascii?Q?Yu0MNx32X0wIv4ZP8l61AQ8iOxzMPos5NzRxQgcY0LcMXV3rhWJcbALMXFno?=
 =?us-ascii?Q?R5Fkr324qM1b7oyvuAkBk+hLBpegsmD1+5TcJDcWry/M2j7CDeWYkfJkdI6O?=
 =?us-ascii?Q?uxJGesdQaBP3YsRtxtF7L48eqYXfmhJxAv9KWH8l4cmYxE658riDiwEU83MZ?=
 =?us-ascii?Q?CdXrtbKUvsa+D6Z1ZLyd6Qkt/bPXvB2SW4cMAj0Epgv6SLuuOFa6pPJi86UE?=
 =?us-ascii?Q?4fjUAzl/HpJHpN+snTyuE5ehK9Ot/GCmKnoLTQKw8BQwktFYLITeqKDCh3BB?=
 =?us-ascii?Q?fh0yQSsaoUJ37ogk6Yi/phqu/37sR9lkAcczHzsA/CJGBnbqU95Ta72hKCxj?=
 =?us-ascii?Q?R0HdWFy+jQ3I4XSNrRECgw4cqpIWWU691HpQOngAs4/QvbxPz1zUkDJWL/a4?=
 =?us-ascii?Q?T7E0OodprG2zHGY53qA1BOPs/Kp+cIh4LkT2R32pWlrcI3SbHxM+wMJQ5ePZ?=
 =?us-ascii?Q?emPB9btyxYUulAFwzk+sj/dEXho1BhbFDmn7bLfGuLfNLAYXaJRJJjot06xm?=
 =?us-ascii?Q?9R65flYPuMtjgZsxCCJfBJT6arzJ71DHO584xVwx1bH6wvyq9W2CPPofarr7?=
 =?us-ascii?Q?viY+n0pn87xtzoWI2tYyZnHkmIZ4miYSFan9RHRh8NFrYrd1KX9tDuJXsW+O?=
 =?us-ascii?Q?iYT4Gq0UDnes/11bPGO3Zhz9ThDwqBv9tmMTva+nWx2LRLdQEk8iM4E5bGpi?=
 =?us-ascii?Q?xbPvuBMDmo7kV0gCOFqPsQcLzPn0Ymcv85vC/vyg3oKl5Dfa6E676YhTr3Jp?=
 =?us-ascii?Q?P/geX/YV1l+tP4UFVRejpxtfzoLP/DcFyghnqpqFr+/i4D3dSbPJp+bbXR3w?=
 =?us-ascii?Q?te2EbaSMUhd2sfD3+l502FdCsnCUXJAPZbcCYk8W9NExudx6koOxPXvhV8HF?=
 =?us-ascii?Q?glx4tW51urUjYwAMPZZU8Rad/xeaC8u1i1BVdbO2LZGYwLf7MCAdgyi0OMl3?=
 =?us-ascii?Q?XaNTvX5IQlvEJAyq4oSb8QgtyRfWjMwcYfhGDL6xBVUZWGXLmCGacWBGkn6d?=
 =?us-ascii?Q?W1ckwTOBEJHJm7GvxyZc57rkbNm19HlioAvWHP8zU96kBJDY88yVGkDSc4CB?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FNsIVjzpZKbDZgkDgxx8cnXEzuPA9fzmj/P6rQeBEZDVIkPVCMX4DLCLnFSXeuBUDjUp5PZfIAjcw0l6+TE9V1A7EYg4GxsuUmQJ5UGgk54Y6xh3IdgYnW0J+kM1nRwZyo1b0tNe1OuFCavPVyuvux2sEFaqMKzhOjvV/tqytg+P+BmPH57NYOOyHHFdpFdWc5k3DWlaue9a/8h4UBujC0OIrLyRlv6baPTdQv4tF0Gb3h3vKrQItzJdJBgcHL3+N8ZH7srhsRsIMUnrp3awsVcuqq6seI7Bb5oGF3l3yikx+aFByYOmCEOMZTFkbsBPy5/hyksDSSa4nU/4BBA8qPBjQXRDeKQvtYooSCUnOfnzjmfMHAKk2Re7lVTjNYDvbnzJEdCVi1+vEBHOalj7L99c+hvDpFFiAdNbmsjsxw1tH+cbKjJO8fslLTN/kqLXHdrxjtgt1KwS82f1jpvgEo6vCe1zYgAq7nbtjdkvhetJdlXuZuRAa/PDZonFgTbl+3lo0qTIXdffyYQoklIz5yKJ+0ktR8gmKdeRpXKjtBA9WLBtmcKtMn4ZEnzguxiJI/ArNa8nTr8hZczDrDjTWoJPXlaHrdMsnnKvXWw764zj+Fh6/Slswt4Z6t3bAso8hNAclrBh74OrUNJpjPVru6lLYClp1NjfkjIxNMblcSgbTQ5regVW5uq0q22FgXvw9HvNDT0Tpf1Ifs6j55FHDaTIRpcl4McEW3bB3zxr9PUAGAd2Om8yfq8RPIDJJJ6qqzB67BdStdyl0UCSlniXq8BY/biVL/vZLgP/9RKUmmw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06960536-ec4e-441e-fae7-08db14cd7bbe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:08:18.1752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qE18yuXzo0anGGLq4NmnamVDgao9VJ5/evvfstsmx8rMMv88yxoL/9ZwVCpHkfdze9sN7c6Sdf7QhgDxWcEjXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=820 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220107
X-Proofpoint-GUID: UwxfXv2hAQy2hOLN7t7gdnLpaPIcS2P9
X-Proofpoint-ORIG-GUID: UwxfXv2hAQy2hOLN7t7gdnLpaPIcS2P9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Feb 2023, Luis Chamberlain stated:

> On Thu, Feb 09, 2023 at 11:53:29PM +0000, Nick Alcock wrote:
>> [most people trimmed from the Cc: list for this procedural question]
>> 
>> On 9 Feb 2023, Nick Alcock outgrape:
>> > I am going to split this whole series into:
>> >
>> > 1. A series of patches (123 of them at present) Cc:ed to subsystem
>> > maintainers as well as you, to comment out the MODULE_LICENSE usage.
>> > These patches will have Suggested-by you. This series is rebased against
>> > the latest modules-next and revalidated, and is ready to be mailed out;
>> > will do so shortly.
>> 
>> One quick question: if/when you're happy with this series, are you
>> planning to take it yourself via modules-next?
>
> It seems some maintainers are already taking patches in, so let's see
> what folks take in, then if there are not takers I can just take what is
> not merged on linux-next through modules-next.
> 
> So try to get them into each subsystem tree, and around rc3 send the
> ones that are not merged and I'll just take them into modules-next.

Sounds good! I can trivially regenerate a new patch series containing
only the still-missing bits without needing to do anything like track
who took things, because nearly all of this is automated anyway.

... at least I can if I can figure out where all the subsystem trees
that people took them into are (not everyone might mention when they
take one). I might miss a few, but I suspect that's not a problem:
taking the same commit by two different routes does not constitute a
conflict, at least on its own.
