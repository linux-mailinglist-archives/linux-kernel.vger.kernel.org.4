Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E8D625B87
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiKKNwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiKKNwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:52:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7904821E22;
        Fri, 11 Nov 2022 05:52:29 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABDijUw026352;
        Fri, 11 Nov 2022 13:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=haHuZpdKvHkojenHross7LviVGwZQJ21CNfZyMd01cY=;
 b=aQMmkIBkDL+bp2U5XMNMwy8z4mlUmt9xKHKWHCD7zGjY2N/VKbIzyc2gkJhvDTGAOIwp
 jBx1vX8VctKG5KA7GXf7VzKpvwUFcrrJl7Che5x1uqUknXeoqWnku9WzNlusLSI2gzST
 5a0o9RIVoLGhfPqof+piEPrH5e6B1QV6kb8I6CjxCbiziGL3W6cI2G4rEUzfyLTQ0Wpc
 VwNPxegBi90B4HnDoLyl3aPkVv7eflEgDfNTkStp7EmYNP6K9/yjFs495kI1EmptG1tN
 K3TANSto4fHNpMPLZcHJUaI/Qx92G4Rw3/YEGz+PcQrXiVy1ZmERkFcK5QbWB8atO9yG GA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksqj180hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 13:52:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABDWhD6011772;
        Fri, 11 Nov 2022 13:47:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctgmv1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 13:47:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeVToHIgnpIrw6gA+TNELGjO99go7twpZE1KajMeZn14qd4W5LfyM/wLe9Ih3mz8/bcDldvIZnvksDMsaP0uXlX2kfVJC0ZqarTFZcEtoiBqmxZSgNUqUXFYYDodxbz3hJtJpgsbY+3kS6eNQhV8aIBKjXaH09TT04SQN4XYjvfWmEh75FbfitUFmMji/pN5rK2M1o+bnJcdWn0eyriZpy2Gbt1IZWRBzIDpRT46iNm/m8Xf4w/vYMqlQUEjZRk/yYavqC989zF3jMwvYfNjFX6TjSmWnpxUBQzXpEIVWq8jI8gItGAsHEUKzZ1NjT5zz2ilCI2IYGrqloGlw4OcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haHuZpdKvHkojenHross7LviVGwZQJ21CNfZyMd01cY=;
 b=HCgGmPex9x6mgeU1zcG5Ib/k9WqNML8oEj0/a49NcwxauMmad5Z7oA3E4uoqrGqQX+vYsU8HND8l03hGKAokbEbr0DCxgtsM5KSUE2KmKAO/i8L+e30Gofxvqm9HW99Vt+vMUV5EfxeLmmgqshSaGJILjzvcDndZyQsKH7E0aecnd3rDaEV38VivTeKshx1YKn8CVaIZouBMH0uREtja4UKQl7U7/7Q3yFaKMaD81RenQwZ0yJbT5XDc4wBSoNpi9dRTc7mplXxFGk++Th26O8Er5Bfgdx74ik4LB0wLy+LXe8o0XgynP9vRexJHwq5gzrKg2nBNIZr04qkwBNRcUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haHuZpdKvHkojenHross7LviVGwZQJ21CNfZyMd01cY=;
 b=R1dqE7hiAxqZ+WJLiRdsm8wmr3jxfJFm0LnaxajvLtcOUsJG2fvbGta+XMHmpYT9Nd5WrG4pJ2+NkJ6jkdRBWYjiUjXHN0jD0/kNocHU5rH1fa2ZInOTn1w5gqo0Dl3fjoJKHle3TVZxI6pX8kT6Z2AB7YLRtQfpElMD3+bkl78=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SJ0PR10MB4557.namprd10.prod.outlook.com (2603:10b6:a03:2d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Fri, 11 Nov
 2022 13:47:18 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2%3]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 13:47:18 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: Re: [PATCH v9 2/8] kbuild: add modules_thick.builtin
References: <20221109134132.9052-1-nick.alcock@oracle.com>
        <20221109134132.9052-3-nick.alcock@oracle.com>
        <Y2x22mKtaZvC7ZSk@bombadil.infradead.org>
Emacs:  indefensible, reprehensible, and fully extensible.
Date:   Fri, 11 Nov 2022 13:47:03 +0000
In-Reply-To: <Y2x22mKtaZvC7ZSk@bombadil.infradead.org> (Luis Chamberlain's
        message of "Wed, 9 Nov 2022 19:58:18 -0800")
Message-ID: <87h6z5wqlk.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0423.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SJ0PR10MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b146f5b-0b7d-4943-5ff8-08dac3eb3f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8nxOuFG+A7lC6BU3XP0SMlOZ7fkBLJK1NKt/CZayRJ8QS2LwAjKfOle7Fa7b9Q/2QFd7klHX56NbhLAQppqTNzEUwg9EDWUNxmV3B3dAk38f5oz4cvBnWACN5axyNoGOb03CqebBajmagJ5T75lBBZ/6KajnM0lOqSoGMTK6NN6+GA6pUn+BW5NLFkSMDraO8t4g6kdaqQXX5z665fRHJN1+LQDVfxz4hbicA7stAXZ5LO3+1vsKpVe7mQXTLs/VL331ROFEbsdWNyXSaVLCvzstbMoja+xYttDNdWp4w3tFMhf1UjYjjmyt6RrmiZ9oluzeXPPbBzhATVQCVjFUd76JRSspYRdDwzbjYe41SSMRFvkZJsiGRm19MLaOxuQfND041HWI0dgGXbu+CHMWI0/6Wi1JEdxhB7BC9SOZQZUgtl2rM84z31lin45qrQXb9MDJ6ERiOGwO5EdcBwMTfkwZj9jlnWhWOdPxoRNBm1hWZyCfcNuXwS+yOyDZGaPzKLy++2ByUdHox/TGc2H+8t7ZB8Ww6KG7VuZO8C7pBwoB/wsUz2T4zaNbckyHJm/ms/fenlgpDL0RcEaygQXbIK0oHfP35pr7hedjMGlzpiWMpkkpesHefjTCWEQvO2Bk8cycZViv3r0J2I/IiRHqbURTS/A1qFLJvlA435tATYcKAqd6tyfZEstTJIrRn/aou48gmF6gZ/5pPpHkYIG1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199015)(478600001)(8936002)(6666004)(5660300002)(86362001)(66476007)(66556008)(8676002)(6512007)(4326008)(36756003)(9686003)(6916009)(66946007)(41300700001)(6486002)(316002)(44832011)(38100700002)(2906002)(107886003)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pMHwE9xniI6FHCf8KiAkzTTzeYzbz6hq0gTB2yueleaxbDLbzHFeNuccs9CT?=
 =?us-ascii?Q?40cx4yWqHVnV1uiDbhn0+czpALWi5itVakNFJn2dwU7AXET7+I9BirstEA+c?=
 =?us-ascii?Q?K/PQGVOWNOWymXzyvSTQnmCszVoC5sZHC4SVUSDMLqw6jLGbtF6C9TGuvnL+?=
 =?us-ascii?Q?2N5W7WO/YG2JQJ2F6GikZ8xx72OPKEBeIWhbQmNpQ7EWyMYGIjOLPVrg0bus?=
 =?us-ascii?Q?Yl76Tr61w9lp5f8rkYyJMSQwZinOzdIPGJSytjg9HzPhoJoPbdapkFLD4wsq?=
 =?us-ascii?Q?3ZOtN/DwdWYY3nibY/TTUNlmzwTWBV2lBHKQy7jOdI218LRBL/1aOH7OV6N/?=
 =?us-ascii?Q?FrJyYT4uNEwYlmYgHbQ79mueAgnA2DqcWRvfJUtFCFuuLpY0mN/Kh9vRLiKQ?=
 =?us-ascii?Q?f1N6GWnmuI7lDswcfJhQfmfweommKTWYhAtmxr3XFduWXFiejptYaMIVLsqP?=
 =?us-ascii?Q?hblgVnP6ryTvEEaVGuFJuEerWgdPl8BP1TBE9AONOu6BEHqzZ48/4jVux1wj?=
 =?us-ascii?Q?pXGhu3PkYuzJFauaLCT9MRymQodRHLZqUsKZTykiim1kRdHLKT8e6tpVFbaj?=
 =?us-ascii?Q?5qvZY9wdUqR6fneP4yTkkVC5D2CoLLONx9YL3no6HsOtCO3o7JJ9MX0HsNNT?=
 =?us-ascii?Q?tsiIu29hrjL600i1S/SPFB618JLY63TnZvV0hg+FGGSH6TVjQUCYpB0oIwKV?=
 =?us-ascii?Q?b5U6jlwXvr+ajnMg+gfhNRhzxHEZQpNOC+JGlmHj7zPG0AkMURdhfIdLmZ3h?=
 =?us-ascii?Q?p1jlSNYMqiHk6xzybz42alrsBrFBs5Lwp5nS4UgbpRyUrkUqKd1pQCIicrUe?=
 =?us-ascii?Q?iFuExskGM0F4pVibX9QF0yJyEWwNYl5RuvpzNsSsTltC7R2Edvpx9q4pQr1B?=
 =?us-ascii?Q?TBjRkxYOUjImnWOQFvfZs6Uz7Dm6zvbRKgIQ45mSFoAwMrlyOc18BBW44mTn?=
 =?us-ascii?Q?oefgwolabI/GC/LxrzQTKD1nSzin/waYhBlYk98Q0OXWyzJe2BaDDXltjIz6?=
 =?us-ascii?Q?Gj2l5ihs5hUhcCAOf1O7iLZXWtEj9MukhuXQp8diN9HmVTTFYIy/IuCF0+7T?=
 =?us-ascii?Q?xjuVd1MGHxu0HhzHmlT8l78JMWqjuLTvqRhLwF3CDPLG9J+pwjyLav5zEOZF?=
 =?us-ascii?Q?eyKpvL2rGMP0/TUwHXoz++AIeWaKro4MNChlKCErTZNpWMwRYi+jWIulyfqc?=
 =?us-ascii?Q?cVY3jfBTBF/LfXou3NQRlNsgdvB6X/EFjnaX9ei0ts3oawRDOhoxrNBc0PC4?=
 =?us-ascii?Q?8W9IHTwdVh6kcHZ6/z2Me6GB/Naju7jKm4AK6xycxIac5U0HtaUuX9ShKOVl?=
 =?us-ascii?Q?YTY0swbCKrg0FCChZLuVnQ2gh5Wr8j8fr8YuboFxWEsFesEy92HRfUecB+8A?=
 =?us-ascii?Q?T1bb61Wgn1QOqHMvjT7RWArT7rkZa6VWjFuxcQ33t6xEpkZWDejOeqQ1KsTd?=
 =?us-ascii?Q?3TVxqb8GNRGhjmfaPAGsnNLPn4S3OW7qF93f/e8Kyv5wv8YEdcwi2w4PEf/a?=
 =?us-ascii?Q?gLNDRxcaTq7wJWpTORjg75CnU9ZW2ZBOiZBUE+vSid1Z+9B5xTIr6Fj13QKz?=
 =?us-ascii?Q?NwaEZaGfntbP/g8xGUrvZg84+ujT+viSyX1jvwm6pqixMZ8ug0Z6qMY/S9ea?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b146f5b-0b7d-4943-5ff8-08dac3eb3f90
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 13:47:18.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/p72Yt7IrEXjJfh84ff5uSsFFcJIm9FdQ7TQfHxRuhqPvOQXQUBQPJ2MTEuAjVDZJqirzbm7CYCAL2NAZ5k9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_08,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=957
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110092
X-Proofpoint-GUID: oclpAlM3LAAePBuwHj6zJ7lQ6eVtaSZO
X-Proofpoint-ORIG-GUID: oclpAlM3LAAePBuwHj6zJ7lQ6eVtaSZO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Nov 2022, Luis Chamberlain uttered the following:

> On Wed, Nov 09, 2022 at 01:41:26PM +0000, Nick Alcock wrote:
>> I am not wedded to the approach used to construct this file, but I don't
>> see any other way to do it despite spending a week or so trying to tie
>> it into Kbuild without using a separate Makefile.modbuiltin: unlike the
>> names of builtin modules (which are also recorded in the source files
>> themseves via MODULE_*() macros) the mapping from object file name to
>> built-in module name is not recorded anywhere but in the makefiles
>> themselves, so we have to at least reparse them with something to
>> indicate the builtin-ness of each module (i.e., tristate.conf) if we are
>> to figure out which modules are built-in and which are not.
>
> Please try this patch, unless I am not understanding perhaps we may be
> able to replace the first two patches with this one? It also seems
> to capture a bit more data than the modules_thick.builtin file.

Oh thank you! At first sight this looks really good. I had trouble
believing it could be that much simpler :)

...

But... it's not quite doing the same thing, so perhaps it can't be that
much simpler. Picking the first item that appears in my test build of
this but not in modules_thick.builtin:

+arch/x86/crypto/libblake2s-x86_64.o: arch/x86/crypto/blake2s-core.o arch/x86/crypto/blake2s-glue.o

But...

obj-$(CONFIG_CRYPTO_BLAKE2S_X86) += libblake2s-x86_64.o
libblake2s-x86_64-y := blake2s-core.o blake2s-glue.o

config CRYPTO_BLAKE2S_X86
        bool "Hash functions: BLAKE2s (SSSE3/AVX-512)"

This cannot be built as a module. The point of modules_thick.builtin was
not to capture things that can be built into the kernel or left
unconfigured entirely (though that is *also* a nice thing to capture,
and should probably be captured regardless) but to capture *those things
that can possibly be built as modules*, i.e. those things which are
tristates in Kbuild and might possibly get built into .ko's. That was
the whole reason we needed the tristate stuff in the first place, and
I'm still not sure how to do it without that.

(The reason: if your tracer or whatever has a distinct notation used by
users for things in named modules, then you'd usually like to keep that
notation the same if you choose to build something into the kernel that
might otherwise be a module. Things that cannot be built as modules
could just use the in-the-core-kernel notation unconditionally, because
there's no way they can ever be found anywhere else: and users are
likely to expect that. At least, when I broke it in DTrace years ago, I
got complaints!)

-- 
NULL && (void)
