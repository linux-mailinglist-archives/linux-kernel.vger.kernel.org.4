Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5A6742D91
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjF2TYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjF2TWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:22:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9683AAF;
        Thu, 29 Jun 2023 12:22:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ4N7P028140;
        Thu, 29 Jun 2023 19:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=o+McSM2gKtujfwRfyeOsaE02Y4bKTLqqTyQF/lTUOqg=;
 b=SXCD6SIq+GC5Wr3QCCnnUJfuWRpBHBEE124BRTipuigwD6U3vr+4WmCTgdtb/e3x1KmF
 2Ekn26yCN677tUxyCWSbLYW3YtHaFPtMvFp+89SPuh101z1OGNKpug3xfQgGgbT5CG9x
 TN34jd+PNEmeIaf9V6pUlKnhIayJHknNXZNj6DTqNyW1NFWqf4pXM1xOp1Cq7JvvfbmD
 ctvhcFyzor0BNlcHVVT5TgQ2y1hDt1uaFP/mAT/sUeeCX8Z8GzaiojsiwJ6+m6GjDivg
 M7+wPjQjrMZFQWKCxQS7LshlfFs7+1NJN/7XcUmjnTjj5JA1mHxvYomJguKm/6682htE cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrcadbd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TIUW08008581;
        Thu, 29 Jun 2023 19:21:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx7tsdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b39mfrWsiyBoKgUZTow4lAd/lfb+m5FCLxxoM9EdlauS4Au6FVUBOZRM/O+zdkWSdOqoXy8e12uF3PjSMVuAeoLF2QxgX22VVFubO0lTtUm7RP1FRW77L+0TjF5q4At33OedY7PiJQLR7nFoS2kHT7ul8cc4ZC35rR2NQsHY4xsdC28uRTKMnBsSRmR3cIUUN7eZBWzn7CPVUcSiDBXjKvxirkZRe0P3llLPx0z1pxLwgCk5BB1GflyHODCFFdZZTSfM/y5SzBfMFJL4JbCLps08tAA5/NJFobH3qH4H+IZWK9CVL6etgI1PEp1ZHTzNu37ny3TlB0Wd3yUdHsNkZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+McSM2gKtujfwRfyeOsaE02Y4bKTLqqTyQF/lTUOqg=;
 b=I4iuXGiAS8wpdBkH99iqJdT9su2jtkjFgXd4on4uoQA/I/CDUy852+w57xvWdNM2Dq/AifZmM1yAkEumLkJKZgEHvyjGBeYdfr+LXn0An3SPi8CO5eU7XSmkrBIR5HRsShGJAXp8MgXdNS87PpZqaZTymHiR4HBfXLwn9ZUM/uW3QYPZ5bdIXikgMrWYNxm59ZWApuZkdUzihG4kRBWs4Ny5eRWXs3j8TYcQAv9Sql+kNSz0d+3VG9VSmkqb/k27StAF9xmXlrBC+7qg+F82pGIkg4oEbcLE21u1f+/Ijzsh6Vu+a0jgiXdQjlHXb8qjXymfY8aSrT1Z5GyA2uRKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+McSM2gKtujfwRfyeOsaE02Y4bKTLqqTyQF/lTUOqg=;
 b=gh1vk7W6y9Y6McyqW5P4ULrlGHyri64jA/uIIWowIH7ffws1VK8S7KWIKHPSKvBIVNQz0t6837/Ppkqd/wMU+u1BRW2irMwNt9nFxUrfB+hbtsbVOSH7r3DfLHJDfA3FjkOtWwcrKoVkf85IHu3IPuvVrTyD9x1w3gDwzoUyS7c=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA1PR10MB7200.namprd10.prod.outlook.com (2603:10b6:208:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 29 Jun
 2023 19:21:55 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 19:21:55 +0000
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
Subject: [PATCH v25 10/10] x86/crash: optimize CPU changes
Date:   Thu, 29 Jun 2023 15:21:19 -0400
Message-Id: <20230629192119.6613-11-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230629192119.6613-1-eric.devolder@oracle.com>
References: <20230629192119.6613-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:5:333::24) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA1PR10MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ef87ca-37fa-40e7-4c46-08db78d619f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6gHXghPFYH/Xd8ZqPLcYbtXtFN4ag0z6id76cKNqClEfatOGeMP4U0yvxzxVnT8la4LoanTxKetfXWSLti5VYssD+Nk0sOqPOC5hmX/DN7u+lTjB+AoNpz7Xs4qCL3iuwdlMNrBJu9Hwsz0hBQ1HhHP1QdrToLg4Jr/xbc0ZIjVyGDWkE2PL7ASLZr01k9raB1dNtBommCJnl7ANIPBgopXW7oZu/aGq+9G8vIUy344lHl2n9xMpqDv155Vkm4NIPYFWJanCkmCoe1LnvtElq/jp1pJkjAZTy4WSRWTBeqa/abmYgox1BypyQYmgy/2XVIqsHqikVSPF+vPbJiIPJWfBirCBubtLieqR3unn8SA2mhkhS/XHKpJMwXy1Asxow3+ebtL2fbNQgoxUzSsONoiEq144wtf3qZM8WIq+jT9g1+fuUTAbZE+loM/TWJ0I08H+5lpVzzQnCMZKjiWD5weL0cKyGW0CQq/ENPnstTA4JjsNWvvysh6MXr9e29G2bVDOP39wCtVxqMnYqqeqSmr14xn+OXoUAL6UCwPRYaMXiy5MjwsA50pcKk7ERGd+mJo62pOYbLbq48eiPbZVJfWmNICfv55qSjuz/AQ4YZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(83380400001)(316002)(6666004)(8676002)(4326008)(8936002)(6486002)(41300700001)(36756003)(86362001)(38100700002)(921005)(2616005)(7416002)(7406005)(66556008)(6512007)(5660300002)(66946007)(66476007)(478600001)(2906002)(186003)(26005)(1076003)(107886003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ElkLGFe+myynGuJMWXC/KJK4/vhLF0NQhLnvhyEGb2JSJGgWjF0cDTtBW4Q5?=
 =?us-ascii?Q?yIA10xJRWDRx4CB6QuRr1M1ORSoGyd8JoQpgnHa90HBN4BQS2Se8oFRSBM5v?=
 =?us-ascii?Q?Fgpnji3dUrCcxKcwsphDNd7ImL5UKeaUG1ogLz0BI90jHofdmTFJdXxxxcJe?=
 =?us-ascii?Q?JNlWOzxepuXR6EJf695+aSTHLwpdPpf1yKSgo3Gf3xaRW0TR3LcQlJQcAuHk?=
 =?us-ascii?Q?g0kvHnyPHnv9keXtOOJWorbtOaSaigXRfifqwOs2QUsOMbC9JogW3DgxRwQT?=
 =?us-ascii?Q?1p0HR6vHMCJM/1mjUdk9BamyF50vUlBboPmjSB31Cj7LoDOV6ZghNR9acS1t?=
 =?us-ascii?Q?zqLHM3kK3W07RvqcnmgGrAs2+pF6DbQYJtpmDs79U6qV1yCc47Ho+jRKSQbr?=
 =?us-ascii?Q?GE+AsXl3auf2x74ZMhAI4Xb/mXzQ0+6BDQi9fv1qYpGm5jZUk8h/ACIQyGLb?=
 =?us-ascii?Q?H0ttyQq44WIBMCzuWor95VYkFr0MZO0aGmgvlEw9J3O7PHkkJJS7VrPw+AK5?=
 =?us-ascii?Q?WJrlQ1nWvhPHtsjUEx5Wr/QNSJyLgB/6BhgeCih8SCqqm5GW32jiPaasmYDN?=
 =?us-ascii?Q?ZzweaL/zaBwbY6XEGVx804vqMyQLQT8vBwLxHYM4wLI68GvDmUl1CPuqeqka?=
 =?us-ascii?Q?OBHJLo+0Gg/fyuk8ydeL1wB2DVICIZVG/GE3lK08mxjsR+vvZq+AsTvdS08q?=
 =?us-ascii?Q?WMccJN6GfumSarV41to2362gygb5CG78MKDtz3ODl0QvazWShX769zRmd2zv?=
 =?us-ascii?Q?+NHPBwrElMyuMF78EY7mxLMcotUGScOxmxbTT+Wwfj9qcl23zME2t9Va2/Te?=
 =?us-ascii?Q?q5oQXsT6KPqlrRxztukedlUMv95X1PBiCzC7BVI8jxzIaiGAOhMQodP1/VAF?=
 =?us-ascii?Q?cbT8ZrmXhSHbekMnAAk4afVvfCC3bO6cXYA4zgOKlxk4+HsDzWS20iS3z5kQ?=
 =?us-ascii?Q?0WaG4znTSP0OxdAw5EiJJcOzOyhx9RkhNjFf1JUedRg4vAAP23UkCch42St4?=
 =?us-ascii?Q?P7Oxp/lyMmMzIEaBFL0HakgQaEzCP5XLWqwx8pqlpGNPlVyZJDB2csbhP3zY?=
 =?us-ascii?Q?iHOoEyaZ3Kx88R0ddj+11ARHsZmzy3jqFjWyXAdBViKTxBAJXFdcMuUGlES1?=
 =?us-ascii?Q?FFjN/rA0oVflkSLR+yNAJi/TaXXiX02GFYt5xz3zAODtA+nqlxwzYXDnb1aA?=
 =?us-ascii?Q?5mDJdIuX5DPVM1Iys3iAsSHFV/HaaL5jD33L38vauh/aSH+W5zUS0CRVvGF8?=
 =?us-ascii?Q?H8xZVi0U2R4Yp4z+06hE12a4pC797Pwti4FPgz6XQOQYPiexagKy5Bk6ktIV?=
 =?us-ascii?Q?rfNARAojzBbM5lWL7vrgbcD02nHZv/EDQ5kCYlPD4+VffNbvUOSifdRDBbYq?=
 =?us-ascii?Q?n1BiKKGHscH5JeGSJ/rJvYGL0QJ9EJamFTlw2/YMzZle3UT1VyEKzHg72CGn?=
 =?us-ascii?Q?JSXElGK+mOzT0pdoSTgaVxCQ+k7WNDK72vWhLjII6JeANEBWo+kM2tXDF8+U?=
 =?us-ascii?Q?JtrtoxixA/Utdy9X7m0eKFAfhkFZkshWPC1Jtp8iyTJ1ghXR4zlY+riqSXH+?=
 =?us-ascii?Q?SeHhb1PM9GF20q/wiT1RrVJ5G/yXtAj4KeZXuLUqmoOVeDD7dUSYPrkVm/aX?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vs77kLxfzL6KhdTsPW0kR9ukfQQypWvt0yjOEWXNc8SdimouFmvscz73zvK6?=
 =?us-ascii?Q?m/pDc9LlH/wSQ+vtDy7uC8xIzXjAM+JIy09btGDd0s6xlcEU6NBemPHF8fY8?=
 =?us-ascii?Q?a1CFR8v0K3OM1uSusMDnwdbGAcWFCqNl2O1ZazvtFwqhmBFOdxDQJrC5ghH1?=
 =?us-ascii?Q?vbt3qQXA1i1yP5RUSI5qrWyEkPCBI9FlTbVTX3BHfJQeOF+4L/5KWb3NHGbN?=
 =?us-ascii?Q?cXsyb9I15PyqMQhiIQ4KmNmSXVTxoQaR3BY6405JbmpAIOvyEAI3IXHMH+qB?=
 =?us-ascii?Q?o90rS3kapxzLto1GlfkBQnG9HWGIaLQZCXcLmlC3tiiQmvafD+1HTNf+g99s?=
 =?us-ascii?Q?niN+b9oaAbRB2zJt88KeDEmN/9/xjc8G/OPxmvhcVi1F0r9Q+1Fu18V6B0ah?=
 =?us-ascii?Q?SKT+igs+g1piOUghYDdS9Iq6pmTwOebLyB3rdMZcKEkOWwWE8qoP8Gg/v8V5?=
 =?us-ascii?Q?YvdNV484ZgCHn+TCKouk7MmI0iQwfFLQziEuyQMHw4+6lMbHwG+zDYeKemEZ?=
 =?us-ascii?Q?cTtnGmYGIFQwriMTqqWeAYQg7v6Rfg9ruStPG+iRs+qaW4cR33c2W1uE0XSv?=
 =?us-ascii?Q?nnJLFxnlsTFmvhHdudyDAUvDPG/G43Oyk4iZD093y+Fe5/i/WeJ0OU2vqMFV?=
 =?us-ascii?Q?1Ix436isE3IGEuB/2MNPrZ+IMidTZ0ojrA1u7B1QCcqIeXP9Hinig45kY6JF?=
 =?us-ascii?Q?RSrDpWFwd8QQYkynIu+lyL/5pQTZg6ajdiEY9/SZCpHiaRQrG34jos4S3sMf?=
 =?us-ascii?Q?UfVkHfjqqOI+xc2d1QWHOYEWCXDXcFu9flMTP7knNjho3vwMT/3sKaSunUOe?=
 =?us-ascii?Q?9EdUYrtRFsSHg3O9mmRIW4z86g55Kcm5fL74tgPtkvapYiuU9l7kNop3Ght3?=
 =?us-ascii?Q?kcUE+2LrSoeIv4aiKutt8q5C3VoPWz0SetZiAxkKG6PpPH0hZEvUPun81LCa?=
 =?us-ascii?Q?sODeH/uw/i9iMM8ZSwlmd95++GzjE0zQV2dfK7EgcviGM78+N0xOJjqha2Tm?=
 =?us-ascii?Q?VO3xUYJDllBCfDwmg+601EZJqhFAfg76cpC40A/7EOmAQIRPBrPgaFlf8TJJ?=
 =?us-ascii?Q?5p/am1/AeNo8+c4XZ1RmxJezkJXbWEmLA7PRAC2EvchDtN1HZ/x1fGhRt0zS?=
 =?us-ascii?Q?jDR/WHgEAokZ3EMQi4D+bmRtkKl1ONw/VWdLsQYcDK2pLaPaI+MBHkKoq+6u?=
 =?us-ascii?Q?8ZC7b03R+xGsm2tTfpscanQM6U9gI0q/K8R5t3e2yMmSBr0T2o4yPU9//LQN?=
 =?us-ascii?Q?GlMnuMBnlmiOckb6wdDD08ak6u/7X36TgF8ewjKKfJBbuOjAUPjQcolmypJw?=
 =?us-ascii?Q?I3oX/CEwo6fQVWJY32qlxVtZ19Jafj0V57gcmhwdBdZUqPWGi6d196SlGGq9?=
 =?us-ascii?Q?sROqZPVDvzEfYpcGwzAeE4X6m0Kc6aY8kfu9RCMNREGPBEnX7Vx2Z//3r5mW?=
 =?us-ascii?Q?+mmt+zMAARs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ef87ca-37fa-40e7-4c46-08db78d619f1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 19:21:55.8211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88eaouyZHVU5G5qb1Y8PG5qklwlqUH8X9hhdllYsqUr2h4EyPYIo3CVf1HI/2PPBSNz6l9PKW/nN7zEsnHo7XvhEcIROLeb1nkYsUwRlaZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290174
X-Proofpoint-ORIG-GUID: oOwg7Q2ABizDAnmR-RvLuLaFm7hZSKuf
X-Proofpoint-GUID: oOwg7Q2ABizDAnmR-RvLuLaFm7hZSKuf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crash_prepare_elf64_headers() writes into the elfcorehdr an ELF
PT_NOTE for all possible CPUs. As such, subsequent changes to CPUs
(ie. hot un/plug, online/offline) do not need to rewrite the elfcorehdr.

The kimage->file_mode term covers kdump images loaded via the
kexec_file_load() syscall. Since crash_prepare_elf64_headers()
wrote the initial elfcorehdr, no update to the elfcorehdr is
needed for CPU changes.

The kimage->elfcorehdr_updated term covers kdump images loaded via
the kexec_load() syscall. At least one memory or CPU change must occur
to cause crash_prepare_elf64_headers() to rewrite the elfcorehdr.
Afterwards, no update to the elfcorehdr is needed for CPU changes.

This code is intentionally *NOT* hoisted into
crash_handle_hotplug_event() as it would prevent the arch-specific
handler from running for CPU changes. This would break PPC, for
example, which needs to update other information besides the
elfcorehdr, on CPU changes.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index caf22bcb61af..18d2a18d1073 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -467,6 +467,16 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
 	unsigned long mem, memsz;
 	unsigned long elfsz = 0;
 
+	/*
+	 * As crash_prepare_elf64_headers() has already described all
+	 * possible CPUs, there is no need to update the elfcorehdr
+	 * for additional CPU changes.
+	 */
+	if ((image->file_mode || image->elfcorehdr_updated) &&
+		((image->hp_action == KEXEC_CRASH_HP_ADD_CPU) ||
+		(image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)))
+		return;
+
 	/*
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
-- 
2.31.1

