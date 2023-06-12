Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D3A72D310
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjFLVQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbjFLVOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:14:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4CD3589;
        Mon, 12 Jun 2023 14:08:32 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKOQJ8002213;
        Mon, 12 Jun 2023 21:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=kqZzUcUI7g9GrNNQb568EFpHtig8R3NmjYR2Lpu3gEg=;
 b=cz9NaVXhhRYZ08GL5/YRc3xVj75mpl4HzUEXUsCgrxRR+Yuwy+zHZIIbC/6qkXctPKEe
 313X9W0ktxxwVERAQLLkTwW32EkRu2ZUKf4qXtTypk8qKy+8+UXtTq0X1jHgoSYT5arE
 EoMTcyUuGuXoMNus8MNzPcwDcj0nUJ/nASZZpEMgVw7gc6NHe6m5Xi9PPnqnWS3Gg90Q
 wtYGU7vqk93ETTwzdvzueGW5re2rWWmyX/Z5bogRJZf8OT/Kx1W2Nm061O96JBbIoOBE
 Nlr6wh12ZBiWMIWPT82SfxcWnVOb6WapvyYeLfb6Juy3dIqwFHTZIHAmd3N7X/sKdCZ7 xA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hqukwq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:07:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKVfDD017798;
        Mon, 12 Jun 2023 21:07:53 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3204k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:07:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1YuPK4TsG4sor7f6ffFLJ1G3F4zz95OydWiERlrIbH0TltZK9HRABjmOAivJqszHPaURT8XZ4mMoZq9LFqkuukxzhow6sWbLWhOQTUA42xLYNhi2i50OIqPJwVN4Z3h936g0w579j2juU5GpaSIO2hAnjdUPm4Per5wNcYi6y/FqhIKvBR1hfs5NIOI0V/DMZD7+YNQrDmh/9GrIMGifZzmxi/7NI+QxVGrYnT4Gs51S55hmQzr//URzLBQOJTon2tsa2cq25GyXNTenksj3UKkNzRn2AEkFUf4eTu2e7hcWLUEnyYrc0gmNBMenfS4Fc4Vu4gGOtUPAieX05kS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqZzUcUI7g9GrNNQb568EFpHtig8R3NmjYR2Lpu3gEg=;
 b=CrAkWG2iFK34rxmxGDoBUXdsUT5GePQQXME/tUghJxW1j2dX7LlPPFV6+LaN8NGPbfPpgLpaX7gsQXgAF7D+7c38Sxu7zcwW81mYoXj45HDf/iuhKruu2/Nxx3vF4Gw2zEvxkYIQg+aM1gDJBiGUPzoK7K8JNeR7cPec3NL3LnnB3dYhYzUv1oTQtguw7kZ540KYylbVig2m/XZ8+EnGxUY0SqqnnI2Ks28nyqVMrZBpDKOC/98BoeEpsM4LvLKnK21Td5wcTMSjafv3dEPF2hkFpy5b4KX9tK+h+mAAu4ngZrGTy40K/bHcGeTN7phlZq3NogriPJrMQe9FfwxPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqZzUcUI7g9GrNNQb568EFpHtig8R3NmjYR2Lpu3gEg=;
 b=C9bNmRoh9MeMeBUe8vtribzHoGCtxwmxZOEI0cc4qT9dV88rzEWCXo+NyJBqOsfLy8MlmPwJIesV2JoEAJDkIx6vyQc7JXNLYiEhPq/b2j89cCNTXuNYA2b/y0t+LiOi0bzDa/EOFat4A9GHD4pEWt4EbR5tJwQRX2oQEm/CSSA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH8PR10MB6410.namprd10.prod.outlook.com (2603:10b6:510:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Mon, 12 Jun
 2023 21:07:50 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:07:50 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v23 7/8] crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
Date:   Mon, 12 Jun 2023 17:07:11 -0400
Message-Id: <20230612210712.683175-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612210712.683175-1-eric.devolder@oracle.com>
References: <20230612210712.683175-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS0PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:8:191::6) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH8PR10MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: aacf6494-9c28-4064-2cf9-08db6b89144e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nM0l6jGA4v7bF3GFnIfy+reDFIAFDLduWM8lZOmpqjupjB1jBZf7xZYECtli+jrZDn4G6KgNDUckQIGLYbC9CP652Ca0yAX1SCDRo+LfEqYdAAtC/DPL6HZQbYFweiB6eOrQyJZH7YXYhkEaENU7dqR3hAlebcn3swhC1CSZgeN0+5eLvZtCIHLhPrOJYhvrzf8GIwN4LOM3PHeV/1MiQKJW6RYeT8SolJ94mGSQ3YP4SnJ1ny2NNnSvCMFwlZmDG2PbrT0QnqcRV1KJRu6zTtwl0/YjV92tOLMH7n4Ciyh68LQgnlIzLnsS0PrVlpyKei2naI1hDoKpWMotIvv3lfX1eeIc4IB0mIW0lx+RgIU9tTmkLt5SoL0rxTT2TKSlaYttzESX9WfZk3mavWwgi/qypVCIJVfhyYE21bC5V4trnawUNY/YC72d/xhCH0FgtUgzKvNzQs22DfBSi3lUAK4c6vUtpS59JCdURct9G51cYkihx/nv2c8GfYvRRH61wtUtkVgMS0Vqc9jyTcBi4aoUYq+F1e/Y4DQJcNDm5k5TKWBrUp+iSMO4yW3g/kII5btJkyQG1CKZAgYNj/XjB3IQBIw+xQtgVI2DtbJCX74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(66556008)(66946007)(8936002)(36756003)(5660300002)(8676002)(4326008)(6666004)(66476007)(478600001)(6486002)(41300700001)(316002)(38100700002)(921005)(107886003)(7416002)(6512007)(186003)(26005)(1076003)(7406005)(2616005)(6506007)(83380400001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lvgnFFHA3/dZ17Xy1atKIxC4l75yMWKVP0G2/N68JSZE55Gly0nZhie0arLJ?=
 =?us-ascii?Q?N/tJQeolXizchsy3RPJFtV5kEqs/obxj9lfgZBaI5wXxVDA2DlOC5t+yJN+J?=
 =?us-ascii?Q?Y2lutzlflxjsyywEwEUkJtZ5QCxmWKkpS0crFvutP6Ywwnv17NS6QI96KP3k?=
 =?us-ascii?Q?Zf7hKGEmaQO6txuosMLoR+Q7i5sREsolyBoaa7ZLCSGoRoKUdT7T06DBMyQ1?=
 =?us-ascii?Q?G4SavIygTPK2NqdW9jNCn4JHsvcrKPKvr9I56Epp5072F3HX1sM8KiNDlvvr?=
 =?us-ascii?Q?WV96Gw4DT7jV2ZhzJ+XiP3UhdHq6HfUZRQvvpkY4tOmiTuIq+3C+r0LvMJDU?=
 =?us-ascii?Q?CvF8VS0RxaUSkqIl9YbqJsgF39X5KmMfYG+8dVAwhyTrSv57M/BN6VaKl+4X?=
 =?us-ascii?Q?hseA+9a+9pVv2B3Lq8blHeq2+7OrpvGS/nz8d37qtbVPcYC0I2gcuzAuSLaz?=
 =?us-ascii?Q?gUGDE1UWukG4arQCrjiy698aYS9Vkr1ZB4Ri3vO4w8mv4f6qDjNK7Ae0BFH8?=
 =?us-ascii?Q?y0zW8cTzilBBWyv5dNHztDuEsCUDR81rklTBbh47skw/ETJInQwcIJqlkuRy?=
 =?us-ascii?Q?LkYG5dd3+z9fmEfGEoYcETv/odlFdR9cnC1K053aEeBZgUKadFo3nQ1YVVH8?=
 =?us-ascii?Q?ZRzow1aPPy1YdTJCjkzFXgQ1J4WN3dsypt6O+hPkV+n/LljM+bSUyp68UCUQ?=
 =?us-ascii?Q?fnljGQVfUBLWajD2XTeUWEPmSV1nR8eBEze39esWNrpyRAAk6KYDU54AFl+T?=
 =?us-ascii?Q?iVb6Jv3LWZwHGVhDd7H28aB+mNlXAhwnIkklUthWiuUwgwnEtPJlsTqpujYr?=
 =?us-ascii?Q?/hh4XIoM8DDAKqyHAMJyB+Y2ZFkgEhgX7zHAfKWkRGX6gsawrWUlwU6GViyI?=
 =?us-ascii?Q?3/lD4WmNpo9Kdett9Y79D+OhrjtRkyozN5qc4CnPUVc4XGBHHK4k0j4G9XO6?=
 =?us-ascii?Q?V8nbTP6+xGs6E256WBnKfN2oNGc6smThQzFymVDDSfLlkLe2l65bXhxbDgwX?=
 =?us-ascii?Q?qRiPr7HkExOfBKZRrNcvvfbXKkXyy8DCkSieds0RReCN5UBt1ODWIboKsB4r?=
 =?us-ascii?Q?2d+C2dE9vmj1i9xkZYgxNMCJfnOdoI1g9+vKin0Zfw0R9NP4KKexNNvnqdxg?=
 =?us-ascii?Q?3szmHjLwzuDVPQ+9OPpf4HzF+ijYBeHxJTqxLCpyQcrT5YHFw/xUuezmspE3?=
 =?us-ascii?Q?YHgYLwNPfVJLMM8L9/dvHftuMcMZd5jUCJ3i3RLcoPGwWHF62b6+gndX3s79?=
 =?us-ascii?Q?GeuKC5DrkMl4OQ1rFr/ycKRjMWQfiiaXDNw/AxTuTh28tcEQOkxBDXJXmoRK?=
 =?us-ascii?Q?pcTnen3sXdUNzbMpF7PXGOaDGkH5UUeAb+R/yx7Wt0+38pnri7VgkGzr0KAO?=
 =?us-ascii?Q?k0gXo+HQ//Nu1/vP3Dbeszxp6hznzRg2MdGhpHU0YXrz7A6QqbgrqLlAMU61?=
 =?us-ascii?Q?K9yylQCTm0LZV3tqZBv1RJIGPQ7exe5PHHuxhLZ5hf9f8FwleiQl25tz2aSz?=
 =?us-ascii?Q?B6p2KILJ7034wzOn3FllZ02UeBhlJ/qPcC9AjwjsleOEsJil7sUySrk4/bjb?=
 =?us-ascii?Q?Xbyl+i0XCfMzTP2gnOqIOShc9su9oNWLKZ5ldcc4CbH79cvYxZMzOY7nkJ/H?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?F1/vrFJmbvRguK3Z6r6fNzlJmMzNXeJSz1NAjK5GERz9jBp2AElRaOrARcI3?=
 =?us-ascii?Q?xlAVKmaaUq+/zhbiX6xQreDHjFG2w8bdIOYchK99vTXu+NW2kb78ITLSydAV?=
 =?us-ascii?Q?XH6Q2t2nX+SLq6UWaAVb3iFNAhbOBBqKBPI0iFfjv7KktEh3a3x+If+jKhM5?=
 =?us-ascii?Q?c+3mUCO34e6/0/4EDRhDt2H6MUUjnUAx84rhBvFMftaF1K23C7ZagBDE9fjG?=
 =?us-ascii?Q?8AYcJ678Uhy4+m0KvmldODNuB484t7Ll5pll8ZOtQlqrgpanFGqwevjBMY1I?=
 =?us-ascii?Q?4dS8t4IDs0j5uxJ17uA9BcK9XEQcbLQlG9EX81wd9F16psZKXPyYLAazV2pi?=
 =?us-ascii?Q?kxwzr9NqZrtlylmPJ3lcX5d3Qcvhf4UxII2OLcRKJ79rtmOJb/Xej0M0D65T?=
 =?us-ascii?Q?uth0qy6wQGWgSgISLWc+PQDQIs4V6bSpH7zRajR/W8sOD+/rX1w23iceNS1c?=
 =?us-ascii?Q?MmkIB0zK0/n3PlcS+1upUQklaui50P7Ob0TkdwJzyawncL1IKCruWOqg/zR2?=
 =?us-ascii?Q?6kevbXTAIn5cugQvEz3MnNLp+9h//ESatZ/LZ1J5SoqnxAx5RNbzXYTZKv4W?=
 =?us-ascii?Q?GeKdTKRV0OCdXtZBNXynqjm/Gewz0CfkmRDGFuy508tSv4AVW4whQ20F835k?=
 =?us-ascii?Q?OiyV5v74aMdEYmLbjE/VGPlgQ+KTHlpyHpPd7CfExxaJ2+v8EO0P4rqwKzD8?=
 =?us-ascii?Q?nRMk3ub0wia9Dy08PMUFsAlQDbVceGnjl0woiSwyJrrldFsREykg0cC1HpiD?=
 =?us-ascii?Q?mfLIr2gDDKdB4Up/5u4DB4t6eLHd5GzmXNUeIiIALoPy4/fokscACIWeFV9n?=
 =?us-ascii?Q?ARFmZCdPK0tM30LXro5ooqPiII+KRXATb4wEwSbqcOtniAGeR8iuAV54MzGy?=
 =?us-ascii?Q?qci1pUCyGFHeIafOSGrprLlXGfGz31/fZunazUpFg2+5jAZAFD7vyicVDQrt?=
 =?us-ascii?Q?VGqGfvPMXxlatxVf16TiWsuYAXb1uBIU2LO4zdza2p/fUKfQDOJea4J6k2l4?=
 =?us-ascii?Q?SWWaWYG2H07ws4Mnw9+WftWPhoyydD4kxUhps0bSBbWIwOKC9YZTjm4OvgOw?=
 =?us-ascii?Q?1QDg4arclXB+39DWZM3jVuO7dOTV8QKbhIHD61iv8/P25et/957T25hcZ0qH?=
 =?us-ascii?Q?tnnB2bs8M20wCoH8q1PXpX4WslMGJgm8zNtWZSqSKIDoyvKpt1SDnS4RJWRt?=
 =?us-ascii?Q?Dj3oMvpveuDHu7nrWjkl+TbKRP05EzvYhdwkujbkB55mWv23qFPjz0K+29D1?=
 =?us-ascii?Q?9zOgm6mSXh/okyE7AEGaAR33UYwbvGxNoz/SIN1QgbFizd81K5ZCb05I1mQu?=
 =?us-ascii?Q?IsdJuKAZguzgk+b0/TgRUZXgpiNj8QUZkj8NqOLXOJCpQnsZGE5lt3A4QFV2?=
 =?us-ascii?Q?UN4gFD/dWrlcOXDG4x3bQwK8bgb33k5++zyAZtr//O4UuebQufvqu43k2jDe?=
 =?us-ascii?Q?DDTIuMvzexc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacf6494-9c28-4064-2cf9-08db6b89144e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 21:07:49.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2wJJL9CQAWC8ZcAc4USXQM/NDeW+133IuD3YB//PIib0d98CU1n+bJUCPMoq+7h1a+BR9VKzk/Z3PyjlwBX2KoKHMD2F8znZKBRd6/KThY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120180
X-Proofpoint-ORIG-GUID: 10FEtue46Nhi5D7w3FUnppHggSbevxaZ
X-Proofpoint-GUID: 10FEtue46Nhi5D7w3FUnppHggSbevxaZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function crash_prepare_elf64_headers() generates the elfcorehdr
which describes the CPUs and memory in the system for the crash kernel.
In particular, it writes out ELF PT_NOTEs for memory regions and the
CPUs in the system.

With respect to the CPUs, the current implementation utilizes
for_each_present_cpu() which means that as CPUs are added and removed,
the elfcorehdr must again be updated to reflect the new set of CPUs.

The reasoning behind the move to use for_each_possible_cpu(), is:

- At kernel boot time, all percpu crash_notes are allocated for all
  possible CPUs; that is, crash_notes are not allocated dynamically
  when CPUs are plugged/unplugged. Thus the crash_notes for each
  possible CPU are always available.

- The crash_prepare_elf64_headers() creates an ELF PT_NOTE per CPU.
  Changing to for_each_possible_cpu() is valid as the crash_notes
  pointed to by each CPU PT_NOTE are present and always valid.

Furthermore, examining a common crash processing path of:

 kernel panic -> crash kernel -> makedumpfile -> 'crash' analyzer
           elfcorehdr      /proc/vmcore     vmcore

reveals how the ELF CPU PT_NOTEs are utilized:

- Upon panic, each CPU is sent an IPI and shuts itself down, recording
 its state in its crash_notes. When all CPUs are shutdown, the
 crash kernel is launched with a pointer to the elfcorehdr.

- The crash kernel via linux/fs/proc/vmcore.c does not examine or
 use the contents of the PT_NOTEs, it exposes them via /proc/vmcore.

- The makedumpfile utility uses /proc/vmcore and reads the CPU
 PT_NOTEs to craft a nr_cpus variable, which is reported in a
 header but otherwise generally unused. Makedumpfile creates the
 vmcore.

- The 'crash' dump analyzer does not appear to reference the CPU
 PT_NOTEs. Instead it looks-up the cpu_[possible|present|onlin]_mask
 symbols and directly examines those structure contents from vmcore
 memory. From that information it is able to determine which CPUs
 are present and online, and locate the corresponding crash_notes.
 Said differently, it appears that 'crash' analyzer does not rely
 on the ELF PT_NOTEs for CPUs; rather it obtains the information
 directly via kernel symbols and the memory within the vmcore.

(There maybe other vmcore generating and analysis tools that do use
these PT_NOTEs, but 'makedumpfile' and 'crash' seems to be the most
common solution.)

This results in the benefit of having all CPUs described in the
elfcorehdr, and therefore reducing the need to re-generate the
elfcorehdr on CPU changes, at the small expense of an additional
56 bytes per PT_NOTE for not-present-but-possible CPUs.

On systems where kexec_file_load() syscall is utilized, all the above
is valid. On systems where kexec_load() syscall is utilized, there
may be the need for the elfcorehdr to be regenerated once. The reason
being that some archs only populate the 'present' CPUs from the
/sys/devices/system/cpus entries, which the userspace 'kexec' utility
uses to generate the userspace-supplied elfcorehdr. In this situation,
one memory or CPU change will rewrite the elfcorehdr via the
crash_prepare_elf64_headers() function and now all possible CPUs will
be described, just as with kexec_file_load() syscall.

Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index fa918176d46d..7378b501fada 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -364,8 +364,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
 	ehdr->e_phentsize = sizeof(Elf64_Phdr);
 
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
+	/* Prepare one phdr of type PT_NOTE for each possible CPU */
+	for_each_possible_cpu(cpu) {
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.31.1

