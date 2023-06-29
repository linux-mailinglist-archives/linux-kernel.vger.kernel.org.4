Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A01742D83
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjF2TXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjF2TWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:22:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AC21FE4;
        Thu, 29 Jun 2023 12:22:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ3vBT020435;
        Thu, 29 Jun 2023 19:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=urxPOYUpKOMkti7IfS40b4Ht/WYOtVRmEjh+rUcS9T4=;
 b=ZNMyRp9q/8gDTzO4v8/4vIvAZOWWZUMbFcALTzgfbxzRZ82SNxO50TYZFS8+89jEXIR9
 QAkwPRMvU7ZeeWP8nrwMyCSLc304ksoS8eNAFuwX2yHS1GNZJ+/m9wwYPH8QgyawWT1p
 1g046aJJi+tlxe+S+fzH3+pOQ4N5WdaKc1b0OAqIFjSLE/QNqqAYZuOjlA4jNCYNdoAM
 PAiPj9Nb8AYx5CxhbhX3+S8dOyUEy1vaWSTVUNDQRS2YCrmew4URMJRO5TxvWi8epFJR
 BaZgL2FKp/5BT/ydIlBs52PBqzgzoAP45Yt8fJuoTCJns9CGXz3u6GvP1U27r+g+BpY6 fA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq93dp8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJEaIf038200;
        Thu, 29 Jun 2023 19:21:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxebtdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUwjT/zbZPCupgWcwRawcYhIY363hb7DhROYktrjeZ69gNlfbwYrDW5nxD6jLDOf/zL6LhJXJ2IqCGc9wkyixb1052LkO7WBhbHC/f7pt9N5rIkMPCLXMcLCqkF6l/ELcUCQ2bW4w2niLanMG6bzgrcefhVQD/GjJfbMHa8XI5tan8jOsl/KonKh26LE6ODL0/ezN56u2TfnlYzxAUHgWxSjMXiS+lwlWnd1EHQ5mYNkMBD4aN1bMvpMlHe8YiBE7AwTn4ttigkJd/uMOaLD0shUaHY+iASr9XBhUJZt/eOfpC4/+H4KY8CUVUE6jPfhHgRTC6cTYQ19LH8k8r/y6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urxPOYUpKOMkti7IfS40b4Ht/WYOtVRmEjh+rUcS9T4=;
 b=OYcHZK8/j6Wm1SX+Cc6AWUP5BoMw/P7TP9SIbbF2+pGOmcUHYUmNGuIVex7qab9RGok7a2UZI3fDEc1JQyPkwKPvacwl7G2P0tFMtpuwR4WF1gszlpvAXhS/y7FqbtUS6yMpJw/+VIcIpexH92qU4ovLB6/T5e+KVURi2WCUKUXWlymsi5EpJEAA9c9vNeJY6Dus88Yv1jDXZHQhpPPKGrdoxhYiOiT5kF/xIlpbqPGjBQ8vQ2vrl4uh246w1QeHmEErOyUDY+DwKsTQ90GiTP67cyYxlpLTeOvvJspdA4RuHGTqeU+5LovEEGxI82R6aGjdG5Pan5tzac5iAD+9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urxPOYUpKOMkti7IfS40b4Ht/WYOtVRmEjh+rUcS9T4=;
 b=YDZDQMDRsnZJFYm130OuXsX/f6DZ7FeKAE1TszUtLzgYmHVx0DrSNQByJE0Gb3VJPTjre70YdYlBuUCKiFyzdr9R4moAHKx7274/Va39lDvc5y8fq9XmpKJL8W43dlof7MGERYJ6WCFOAByxWkKsSc26aP8xcf4Wp1ufn0MVS6E=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA1PR10MB7200.namprd10.prod.outlook.com (2603:10b6:208:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 29 Jun
 2023 19:21:29 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 19:21:29 +0000
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
Subject: [PATCH v25 01/10] drivers/base: refactor cpu.c to use .is_visible()
Date:   Thu, 29 Jun 2023 15:21:10 -0400
Message-Id: <20230629192119.6613-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230629192119.6613-1-eric.devolder@oracle.com>
References: <20230629192119.6613-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:a03:338::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA1PR10MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b946e2-4b0d-4c1c-8a9c-08db78d60a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkZGzm7x/AFc6nlOCJhwDWWtl9fLwGEHMBaFtZdxbt67T9Yz6I87PA677Q2jWdSw9k8qdqPpHn+2pPOf57CwiICpy+BHUVIPomaMSZAYmHnps9NDiobdqgkwtOdcJWZxlxExBNgKIF5KXCho8TeLFxPH+pLuD9N34BlcnS1x/I8kAB3hScnPaHQi64mwdkmqgggdQnrT/1C7E07dGRLYPik0rawBNx0jr4e+NJ7AsuB3Pv9MxGc9gJvZWPrFN+meXi81rSn1xu9fUPVHMMLnrSgBHo9W0TkWq3WphTRGuIbb9no8GEPKDAeB0oysISjfbYcz849eO9ykhO59SgLMikzhDbkc00iVSh3T1ye/rBsqYjijLyYrpx0j1CNkr11IOc0JLOq8xeI0K87TMQYcbBYRHZnz0cVVCVhd+vI5bvZPcjMrHSDptLC4OS/sM58Fjq0ICFT1dAaWBvDaADF8NRCDELEvbg9P1I2kFcoa3wBErhQwH6yZuoJa39Hzw01+rxdhl2/of8re6tnOkg7Zfgoo/OlrGXKWLcQ72RPyhmQUe5ZPZl8woFnY1yZOq956Z2XfjFyMIIK55E+r4Z3THQzhbpshhXauBjyxkNWfKZ7Hab8rmrrnmrUK1qXn8ImV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(83380400001)(316002)(6666004)(8676002)(4326008)(8936002)(6486002)(41300700001)(36756003)(86362001)(38100700002)(921005)(2616005)(7416002)(7406005)(66556008)(6512007)(5660300002)(66946007)(66476007)(478600001)(2906002)(186003)(26005)(1076003)(107886003)(6506007)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IDm+CkZaKzbIqI/jIyDImGy1teqsUAfgzXlTQ0hCPQzUv9ZS7w07lOaOsdNx?=
 =?us-ascii?Q?Dbd0m50Wk36V+GJScdqXCY7MtXwb4raF0PDKgpVsEAYczKTBOsDNSO4Evnr8?=
 =?us-ascii?Q?Zl7H2TFQVEA8GSldH+BQa4w4WXvnh6jVEOJoJr6Iyt4l+qBlSwzJTTqHThvE?=
 =?us-ascii?Q?S+FJLml0ZoqYo1BZeWBrCChjzU8/cFYaX0D+whS+E3Mq+LcpUCmrO3j1jVS3?=
 =?us-ascii?Q?wHHW6qofuaM0u0WrJRKfGLxB/j1ja2TxcU2QhrVpQcxlu/7p+wM7AAWqEKiu?=
 =?us-ascii?Q?Pi2ncKrGgG938gFJF8p0iWlKjsZ9lOyue+1Gui5ZCcwK9pIE2/mILWZpZytu?=
 =?us-ascii?Q?ZaKwo24F67VBGONyUwvq053Ce08w8v+4HeLW+0njvuqB1ZF8CmG1YzgeUXpp?=
 =?us-ascii?Q?os4kUdaotNclBJVAbzFu6mZdOgQGkqSwWfINwdA8Nd+OTQmdHELWPDKkj9ee?=
 =?us-ascii?Q?Hl0yNBa2NB+rjJcmVZT4B9mN2seoNATBJPrWFFIiez4GtqQ40+yssb0H5xRD?=
 =?us-ascii?Q?xOfhDWZuz58BAeJ6A1J6s8iCD/oI1iuhoU7OCj0qX44hIOBuwWSYVUiy0Kg9?=
 =?us-ascii?Q?tz5Z69UAlUwWHNWEFYgmnCpsMKkFpYbNnpDvYov3l3i5U3otgHKE9KeznsqH?=
 =?us-ascii?Q?NKFUb7HRr7iEVKNVe7g8GnyRIOLOzihAriky0d82rJnt8FF4Jt7MUr1kHxER?=
 =?us-ascii?Q?AckRIa4uBLRe6yVqlHEMgK8dmustdeRLCsEPc1/NOd/LGf8ZKfV0W0Acx6a0?=
 =?us-ascii?Q?2SNrUAdfMnRRVJyh4Jv8t5a821zQ+AEjDUkTV2onvXGKQUk+4RL9p8Y8tjNG?=
 =?us-ascii?Q?rPWwjOyfpuCm3iZzY8bN5OOjKSeuCAEfNLkiEKAA2TdMf/KmGfhojh4WGKLe?=
 =?us-ascii?Q?qf6Ee9yZxIm/k3fqCiHRYOfYoX514jguorOI+o3xuUAQmL03cvWZeAOK6FTR?=
 =?us-ascii?Q?aj+Wqo0qVk/Jl3r2vzp2NuW8BDFfp/0an4JcghJr8yLOiUHDDB2IDw9CCc59?=
 =?us-ascii?Q?aOgCU8P/Ugt6wRpvVaPZBLvcXLwyJOOxqP/KwJ17krtgxT7OO3mWCdX/Zmo+?=
 =?us-ascii?Q?uTKJ3HR16D5sCO1TnK9RS+DEUY3OTNRl3wK6Eap5vqYIoKsfkpc16dRZq9Gb?=
 =?us-ascii?Q?qEr5TRZAup38qtSSRN2S/n6w1bFGOqK8Vd0VGMBY9GAHveAPjIrmhh7bkYDV?=
 =?us-ascii?Q?JzigqAsiZYqoLP6f5z2zulcNVB5c4aoB2zL8r9ampQ6WojOcjZ7lYejxD3a2?=
 =?us-ascii?Q?7DcaqNzk1r8a3MiXNa+6MO1lrT9r48NmZa4DqAYeP8g7qwzvy7bQZXVvQrdy?=
 =?us-ascii?Q?1W5WPUdQKVWHEEyBnGuI+1z90dJ2RHyzOsGeh7fD2gJ4Yz9+T1CTdB/n0Ed3?=
 =?us-ascii?Q?N3JKd2wvatEwMx3Zb0zm6Q+E87HsrSFOPNI6MMyvUumfvPzSoND7Bqi66PA9?=
 =?us-ascii?Q?N1CT02FDN/58bH4w9vkbj+ZM7TqY/BCIlwbIQj45MMmBWOiYWd390+ASW9rK?=
 =?us-ascii?Q?SN6ipW/dh/JiMvXbeNaBw3zSAtbZkUygPGyFYlnYbE0zGfNlT1pXrq3iEB7U?=
 =?us-ascii?Q?eP17U1h4C7fFPiknJhtmqrVf9xOajTnKCuak+Ak8gE6WQhuA8QTxInp3EwNu?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5ex2OVBw2Db6u6tJJ03/h00TY8hbjKr+98pLbeX9KV0yUkl/+DHjQHyAWB/K?=
 =?us-ascii?Q?2SygsFsk2xS/R3SqJ2YcbgKFnwLMnpnm1t0ATlP+/KhnmLeJtepzA4sraY5b?=
 =?us-ascii?Q?8FfzmpsD3ODRIdZBsQotlTje2QkWXGfisEsEoJx/73sfOr+v+qxwguWJMpfJ?=
 =?us-ascii?Q?jOjojHxSnRTLLsZPTEXmhv0KJXmj5cMkCmd/R6UmJiSAzSOr30J6X8lEF6n1?=
 =?us-ascii?Q?h47mpgvj17H1Iw6BHnoVbLKez2wSMKz96ELxPn8hNdxT1AlKuSfqefo6y1bv?=
 =?us-ascii?Q?L8mGTgroB5RMgsPxvzKX4yoCh8Uc1+cEarhXL7K/IZs6VVMK4dk7QcVpxAsA?=
 =?us-ascii?Q?yyM0q8/h40xCxAM0wAiKJQhEBSOi17alpucAtK3yGAYqCwJ4iC8g3sBvAhGG?=
 =?us-ascii?Q?6wfUrSSRGGHOmA1SfVC4kXDMxe0tng43YFuNrC4X1IgSy4Pw/h3364p986/Q?=
 =?us-ascii?Q?SJKMliV9If+j3zW1l1ALUajnYb3muORemkO6J2oEZD4zZ+XfR/1FRH9Cbmh5?=
 =?us-ascii?Q?/ox5QBnAY/lI2UnrbrxuRAcHlHdZJE7RCGerw2yS3iZqoqt0Y/3ripFTRHly?=
 =?us-ascii?Q?2LlJlVa4keGyPuQtx7JObGY/E9PxJZ076YvbVZ0+bbc6+o99qw4kyKYrqT5u?=
 =?us-ascii?Q?Ljw7/uk7WOQJgI1xpHfKjBG3OjUlFLXUChAXCYpOdVvinhB9zh8DZe8EdHwv?=
 =?us-ascii?Q?s2ya3SJfMxJRe+hDOWRdvvv8FCLBqEN0mNFl1p9Vi1n6kJP/KBbBC+tfR2J8?=
 =?us-ascii?Q?oh+6o4RX0RohOnfTw3VdJAWhDX3cmN/lST/EUxdmqMLvXeArHts6I7Y0e0bA?=
 =?us-ascii?Q?g43atA2zOwORm7vb+RBDhS3KPpHLLXRnwhk8Pj1dJfdSZwFniQLiggR/RXZ7?=
 =?us-ascii?Q?DYm/hLhO4TovF1CAyeFrAzsTyLkzi1QbVEt3e0uogI5uSib0bmieeXdB2Fow?=
 =?us-ascii?Q?NuVqFbKiwh8qHnru+C7ytmznmk4vZdQTBPPBfXep08QsE+xc9dtb1pf1XkNZ?=
 =?us-ascii?Q?VUogVrxEma6bOEykio6njxS2DuriWfKQmtAQEPAU0N6LLvjJWQTWd9kt+/tH?=
 =?us-ascii?Q?KAz98+03PUcijohJFaMn6oSVdXlaI7tz0etEJ0gs6/ojfx19ot9Z4vUxmI4N?=
 =?us-ascii?Q?vLuxLPmsQ3RWKHFH9ipjCukuXSUHnLbMuBXToisYy85Fpk4tUtmiPNdA3SF2?=
 =?us-ascii?Q?aQjbbYYX6QqzhGe3EW2DSECvqDTLtccoirMOmDx/2KIZl32RBtW0vcY2CQ09?=
 =?us-ascii?Q?6Dwu8i635XueA6L7rPqQU0guWpkKzi/zwWpSXUib5IXC3cLDoox0KXGtGI2J?=
 =?us-ascii?Q?fdatlP6GNudfZmGOiIfWzbrjxUHPZIK067K6C79vAKr6YD4T3raOthvhHciN?=
 =?us-ascii?Q?HMz7zjrvNqU+sAM639qmkBgg9ToZv3jBjoZL9zpuCeQajpfSrXLqno3aXsuN?=
 =?us-ascii?Q?XlOzdkxtvHo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b946e2-4b0d-4c1c-8a9c-08db78d60a39
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 19:21:29.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lomf7q1lbeS+029FjTUf8qhPRfh9W+En2qmsby28qcVEtUWjTw/QHtz7cf+xnuISEj+2uGAK0iqo1OqWNY11SqyxWGl2ty6osSGqhKM6g1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290174
X-Proofpoint-ORIG-GUID: 61ICmdlgMU9EblougI-RUJy8afwawlQx
X-Proofpoint-GUID: 61ICmdlgMU9EblougI-RUJy8afwawlQx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman requested that this file use the .is_visible()
method instead of #ifdefs for the attributes in cpu.c.

 static struct attribute *cpu_root_attrs[] = {
 #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
    &dev_attr_probe.attr,
    &dev_attr_release.attr,
 #endif
    &cpu_attrs[0].attr.attr,
    &cpu_attrs[1].attr.attr,
    &cpu_attrs[2].attr.attr,
    &dev_attr_kernel_max.attr,
    &dev_attr_offline.attr,
    &dev_attr_isolated.attr,
 #ifdef CONFIG_NO_HZ_FULL
    &dev_attr_nohz_full.attr,
 #endif
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
    &dev_attr_modalias.attr,
 #endif
    NULL
 };

To that end:
 - the .is_visible() method is implemented, and IS_ENABLED(), rather
   than #ifdef, is used to determine the visibility of the attribute.
 - the DEVICE_ATTR() attributes are moved outside of #ifdefs, so that
   those structs are always present for the cpu_root_attrs[].
 - the function body of the callback functions are now wrapped with
   IS_ENABLED(); as the callback function must exist now that the
   attribute is always compiled-in (though not necessarily visible).

No functionality change intended.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 drivers/base/cpu.c   | 125 +++++++++++++++++++++++++++----------------
 include/linux/tick.h |   2 +-
 2 files changed, 81 insertions(+), 46 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index c1815b9dae68..2455cbcebc87 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -82,24 +82,27 @@ void unregister_cpu(struct cpu *cpu)
 	per_cpu(cpu_sys_devices, logical_cpu) = NULL;
 	return;
 }
+#endif /* CONFIG_HOTPLUG_CPU */
 
-#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 static ssize_t cpu_probe_store(struct device *dev,
 			       struct device_attribute *attr,
 			       const char *buf,
 			       size_t count)
 {
-	ssize_t cnt;
-	int ret;
+	if (IS_ENABLED(CONFIG_ARCH_CPU_PROBE_RELEASE)) {
+		ssize_t cnt;
+		int ret;
 
-	ret = lock_device_hotplug_sysfs();
-	if (ret)
-		return ret;
+		ret = lock_device_hotplug_sysfs();
+		if (ret)
+			return ret;
 
-	cnt = arch_cpu_probe(buf, count);
+		cnt = arch_cpu_probe(buf, count);
 
-	unlock_device_hotplug();
-	return cnt;
+		unlock_device_hotplug();
+		return cnt;
+	}
+	return 0;
 }
 
 static ssize_t cpu_release_store(struct device *dev,
@@ -107,23 +110,24 @@ static ssize_t cpu_release_store(struct device *dev,
 				 const char *buf,
 				 size_t count)
 {
-	ssize_t cnt;
-	int ret;
+	if (IS_ENABLED(CONFIG_ARCH_CPU_PROBE_RELEASE)) {
+		ssize_t cnt;
+		int ret;
 
-	ret = lock_device_hotplug_sysfs();
-	if (ret)
-		return ret;
+		ret = lock_device_hotplug_sysfs();
+		if (ret)
+			return ret;
 
-	cnt = arch_cpu_release(buf, count);
+		cnt = arch_cpu_release(buf, count);
 
-	unlock_device_hotplug();
-	return cnt;
+		unlock_device_hotplug();
+		return cnt;
+	}
+	return 0;
 }
 
 static DEVICE_ATTR(probe, S_IWUSR, NULL, cpu_probe_store);
 static DEVICE_ATTR(release, S_IWUSR, NULL, cpu_release_store);
-#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
-#endif /* CONFIG_HOTPLUG_CPU */
 
 #ifdef CONFIG_KEXEC
 #include <linux/kexec.h>
@@ -273,14 +277,14 @@ static ssize_t print_cpus_isolated(struct device *dev,
 }
 static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
 
-#ifdef CONFIG_NO_HZ_FULL
 static ssize_t print_cpus_nohz_full(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
+	return 0;
 }
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
-#endif
 
 static void cpu_device_release(struct device *dev)
 {
@@ -301,30 +305,32 @@ static void cpu_device_release(struct device *dev)
 	 */
 }
 
-#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 static ssize_t print_cpu_modalias(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
 	int len = 0;
-	u32 i;
-
-	len += sysfs_emit_at(buf, len,
-			     "cpu:type:" CPU_FEATURE_TYPEFMT ":feature:",
-			     CPU_FEATURE_TYPEVAL);
-
-	for (i = 0; i < MAX_CPU_FEATURES; i++)
-		if (cpu_have_feature(i)) {
-			if (len + sizeof(",XXXX\n") >= PAGE_SIZE) {
-				WARN(1, "CPU features overflow page\n");
-				break;
+	if (IS_ENABLED(CONFIG_GENERIC_CPU_AUTOPROBE)) {
+		u32 i;
+
+		len += sysfs_emit_at(buf, len,
+					"cpu:type:" CPU_FEATURE_TYPEFMT ":feature:",
+					CPU_FEATURE_TYPEVAL);
+
+		for (i = 0; i < MAX_CPU_FEATURES; i++)
+			if (cpu_have_feature(i)) {
+				if (len + sizeof(",XXXX\n") >= PAGE_SIZE) {
+					WARN(1, "CPU features overflow page\n");
+					break;
+				}
+				len += sysfs_emit_at(buf, len, ",%04X", i);
 			}
-			len += sysfs_emit_at(buf, len, ",%04X", i);
-		}
-	len += sysfs_emit_at(buf, len, "\n");
+		len += sysfs_emit_at(buf, len, "\n");
+	}
 	return len;
 }
 
+#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 static int cpu_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
@@ -451,32 +457,61 @@ struct device *cpu_device_create(struct device *parent, void *drvdata,
 }
 EXPORT_SYMBOL_GPL(cpu_device_create);
 
-#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 static DEVICE_ATTR(modalias, 0444, print_cpu_modalias, NULL);
-#endif
 
 static struct attribute *cpu_root_attrs[] = {
-#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 	&dev_attr_probe.attr,
 	&dev_attr_release.attr,
-#endif
 	&cpu_attrs[0].attr.attr,
 	&cpu_attrs[1].attr.attr,
 	&cpu_attrs[2].attr.attr,
 	&dev_attr_kernel_max.attr,
 	&dev_attr_offline.attr,
 	&dev_attr_isolated.attr,
-#ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
-#endif
-#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	&dev_attr_modalias.attr,
-#endif
 	NULL
 };
 
+static umode_t
+cpu_root_attr_is_visible(struct kobject *kobj,
+			       struct attribute *attr, int unused)
+{
+	umode_t mode = attr->mode;
+
+	if (IS_ENABLED(CONFIG_ARCH_CPU_PROBE_RELEASE)) {
+		if (attr == &dev_attr_probe.attr)
+			return mode;
+		if (attr == &dev_attr_release.attr)
+			return mode;
+	}
+	if (attr == &cpu_attrs[0].attr.attr)
+		return mode;
+	if (attr == &cpu_attrs[1].attr.attr)
+		return mode;
+	if (attr == &cpu_attrs[2].attr.attr)
+		return mode;
+	if (attr == &dev_attr_kernel_max.attr)
+		return mode;
+	if (attr == &dev_attr_offline.attr)
+		return mode;
+	if (attr == &dev_attr_isolated.attr)
+		return mode;
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
+		if (attr == &dev_attr_nohz_full.attr)
+			return mode;
+	}
+	if (IS_ENABLED(CONFIG_GENERIC_CPU_AUTOPROBE)) {
+		if (attr == &dev_attr_modalias.attr)
+			return mode;
+	}
+
+	return 0;
+}
+
 static const struct attribute_group cpu_root_attr_group = {
 	.attrs = cpu_root_attrs,
+	.is_visible = cpu_root_attr_is_visible,
 };
 
 static const struct attribute_group *cpu_root_attr_groups[] = {
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 9459fef5b857..a05fdd4b21f4 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -174,9 +174,9 @@ static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 static inline void tick_nohz_idle_stop_tick_protected(void) { }
 #endif /* !CONFIG_NO_HZ_COMMON */
 
+extern cpumask_var_t tick_nohz_full_mask;
 #ifdef CONFIG_NO_HZ_FULL
 extern bool tick_nohz_full_running;
-extern cpumask_var_t tick_nohz_full_mask;
 
 static inline bool tick_nohz_full_enabled(void)
 {
-- 
2.31.1

