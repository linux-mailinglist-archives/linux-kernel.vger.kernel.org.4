Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C302272D311
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjFLVQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbjFLVOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:14:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1474830E5;
        Mon, 12 Jun 2023 14:08:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKNkQ4016721;
        Mon, 12 Jun 2023 21:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=o+McSM2gKtujfwRfyeOsaE02Y4bKTLqqTyQF/lTUOqg=;
 b=te//8EfwaxyOP4yaZY+uGeiOca9qf/cEL4XFcPKdnhor+KjR5nWahzXxp0crSaQ9MNBk
 OnMPqCptjxnQkd1RCmDxve98HoI21YvW5VW138TLi5wBVZwsy3BOOMIUqw4wISKQi4aG
 dG41Z2eMaS6mStjfwWYxo1yIhtw0sDWJuJUwJGRvWVGhBK4BDhChXyAIWxkXttYU4xe9
 FcfLJWWt5s/J9f6RR/pEkPWIxozr/IBDV7GzfIRqYMykrk1G2RyzqT8eycvzL3A6TPQD
 ucM+UP+Ps2gMb0Lgm7h77tkayiKhlUWIWG2avtMRKgwsxhB4DXg5sKwHXlh67ii90iFd /Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy3bwb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:07:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKL4O3008399;
        Mon, 12 Jun 2023 21:07:55 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm9j9ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:07:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4c9gIwWDjlbSrCFcIONNYd5GNSE7s4j0nz7PspCOsqqGcdxerwuC+FggVu8Z4lAkc99U3vI7qY1O/uyO3OG/WYJIYLNXW0hP41UGKpZg5tkuSKQEKagBWS1jupFLH3pTQfTS7KVYXhgMZevoBZyHY1mYurLcFm4hqSaCd03Ju4yQ6AR3sftPy//vjNudyw+lJPojDzpjCy4nkjF0QIfCcBZQZ5hU6Rey+ZJmJ68QoMJWkUIvxxZYadiY3eUihUvthBKAVh8zZ8n5A7aDUCrk5zOKv+VZHGzYooXZ7EX/hHwOoOwMAgMtoAgaUfIkTAz71T55QTcBTOgjvdHlzdcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+McSM2gKtujfwRfyeOsaE02Y4bKTLqqTyQF/lTUOqg=;
 b=BTgPgUuuweWlf5I/xRZnzerAfTeju00pG8+uR+U/YRe+rdJGyDk2N2DyvUCOPXIkbpL1FE6Hq5QrNUIm2+Qo3QhaanT3ulSdG+g6LyyOaCA7P/stYsJIcbyKG6jHjkq8pKBZ+y1L98255zHKknTq0ECtOvWeHugxrOxHgOH1/R2CMNdsxMlX72ML0HDx2BcUdciXaO8knLZyGj4WgjMvA8SrZgGc77iBwudLi/sQplg59VFG3tevPLP5LwEcyimbBHWnfcy3oxUh8Dw6PEHJ91LpcDWlJtoDw8EPLxSAV0vG9jaQKKBY75zSMJeN1FABVV8ZIyp1UY14cSExCDDPHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+McSM2gKtujfwRfyeOsaE02Y4bKTLqqTyQF/lTUOqg=;
 b=ax8AnOO5U6T/IkcLs9OE6iMfwQRtJfkEQRm4iYWshhElw7WPdeVrVfCk+wkeVHeMgLYM/LyNsMCViqTJOFz9TZ8IdX4ATIY+IRdNnY+BfhAiN6vmOzRzNnu4e60aNzqPZgSb+3+X8OkTlZboXcUJUl0TtVz5z5o9n7YObTp3KPc=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH8PR10MB6410.namprd10.prod.outlook.com (2603:10b6:510:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Mon, 12 Jun
 2023 21:07:52 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:07:52 +0000
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
Subject: [PATCH v23 8/8] x86/crash: optimize CPU changes
Date:   Mon, 12 Jun 2023 17:07:12 -0400
Message-Id: <20230612210712.683175-9-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612210712.683175-1-eric.devolder@oracle.com>
References: <20230612210712.683175-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS0PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:8:191::8) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH8PR10MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: edfb1e0c-0efa-4531-541e-08db6b8915ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aw7Kf4U2RBOZYHalfqCdYLfcbGcJ58ZjXAJRhWHUcYUDz+/k4/GHFWhTTprDgUUIgYMhx8X/Wsk18GYlN1ZpateN6ipylM1VI0rL9+aZBDx4qAUWs0uKFrN4kUCI2ZCCg4Wgl1o5s6tKabUlTjURAYqquW7RVtjhVQCgX99TjcAz0WwLJebmSJ3Ubq0kxTR1CfygsVZy2PikKS7SpEGNyyNjvLoC2Q9FGbD1/otZ/sh/m746K1oI3jfWEo8FOsM3INs7zOLi0+OQrVSA5JCRR9Zq7iNyI2ILmErmHKznOf93uCyYMbji8Oey+stYAJkko92zuwuhsxveOuA2q9d/R99vi7RFqXdXhhW7Kcu3F9XTx47c6etSv/NG3IiSfC3ZZFRxjs5KU2ReRN72PwVUTyNgFyBn+EZhy7NG/f8fgjjswkfVfOjTd/SRG99gsw/o9a66C7LCyWDzZ3TKpxBgBGcx7sWwMQnjYdF5fyv2nwdpWDhs0ZOcpXINfCODCqzMRiXJ3B0dsWXUD4AyKyfyyoPW6ie/tNubNPfbV4PBS+rjtFO403Ho8gIbvdKrsn2tb7L+g5HJC7IrvrR/S9Q8zo5bdmFfjh1lCtO6bsv4k8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(66556008)(66946007)(8936002)(36756003)(5660300002)(8676002)(4326008)(6666004)(66476007)(478600001)(6486002)(41300700001)(316002)(38100700002)(921005)(107886003)(7416002)(6512007)(186003)(26005)(1076003)(7406005)(2616005)(6506007)(83380400001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H/GrEbwrvRIG1hpph9pkHYoLzpMWE/87wpHjeAC+ewkSrpyr924CxEfEi92l?=
 =?us-ascii?Q?SSVSJHnKkuGimfnYHbokWM8EtaLdxMIjyIKxJRN5OcT7AAJOkodI1of/cybM?=
 =?us-ascii?Q?sGzAg5zBAFDMxzYFvEeBwZEHNWOBzYMj1IcxGWE2tdwY4TpFpwFtBhP73bil?=
 =?us-ascii?Q?EIbDmtQbfebinXbzNWyD7rillY3CMGxmPm3PzIWk9CU/5K2Cq+BLvjT0yfaw?=
 =?us-ascii?Q?nEPxfHo64MzmuH6UWQlxRBt6xoxq1V4wTpUZ2E7EHDNrgiBfLP/3jLpRRnKP?=
 =?us-ascii?Q?BqXdweJVvQT0zd0XRS4Gv5IniRapH7BDYFBH/UTvaaE6aX5r5Fn1WCIdH/sf?=
 =?us-ascii?Q?bLgssZUjSbQH3829FWfi0r+h6zGOKvN5sLQeF4EmN9iOgJNVh1QcMuE2Os5G?=
 =?us-ascii?Q?gg4xDj7YjsIaRGoRNbxUjjNPmUHqZ/BUmM2kowHFrPOFvVZLYezfjGSdML6b?=
 =?us-ascii?Q?vnSjoK9DIGKkm+S3/gM5mQ2e8xwVQHBxCct3q4xeiTBl4iFynr4MqlYTc+UO?=
 =?us-ascii?Q?EokIvH45A5xU7sHzBsPYwcyPh61opyPZ4M06zcr8rxucQJg34/2Uv3DyOGFw?=
 =?us-ascii?Q?WVTmxu6kE9xyhv2B45h6faSZ8q/VrqZjM0QasUKU59pztbiP21aUvlxF3pnY?=
 =?us-ascii?Q?KiabVF8BqjZEWs7Ar80ZQdZspdVxzNCD2gbNLQU+1+mQXx7UW+FhLTBaxKWy?=
 =?us-ascii?Q?36HGdsiRYlzYEB7I/92F0xUeblJpjfWbZyPmmcxMI2Ww00JKowZbAMDzNdSl?=
 =?us-ascii?Q?qZs+71MBea5TxL4gPRiQtODt2MP1PRj9sSTAxPb4volK/u9WCGnkVTuuJRHB?=
 =?us-ascii?Q?w9ES/fmesd5+8qY1TTImkpFgrQ7ikIfCil6bPBlN56vWibu+OrzyrB7jW+m3?=
 =?us-ascii?Q?D1ASk5wEWqYm1W76btqehEBbq4eyXCJ8g1Y75MyelzMzr0JvpX6qszTa6/P6?=
 =?us-ascii?Q?Pfp7RK2MQGbmAGrV3nveRs/uozlxoU6B2ccW3v2Hu4JlbbPYb2MCCvzciLK7?=
 =?us-ascii?Q?Ur+yTGWZt0sLe+xD1pCSWI53w0YchV4V7P0ChOu+mdnNjBRzV75QUkmu2cUD?=
 =?us-ascii?Q?e7NhpX3vyd4HsgY1hDu8Y25CMhC2SZSG6SOe98s5V0FeQBALbKOxL6wGW0Xq?=
 =?us-ascii?Q?53pSALZ9gdCuB4WoDZxlyJizCLg2qBTHScAR9kl20lihbGT8dFyr3W9zn3xc?=
 =?us-ascii?Q?7xVK4f2+SZnS3rBU3N7/i+XImYSwzUU5QKb4szrxAkupM8asFYxzpsN+owc8?=
 =?us-ascii?Q?rH0KH1fkjNghLp1Lz+A3LKw+E/JftrKxx8rVjWPcc4uJc1uJj71u8KVJFJF6?=
 =?us-ascii?Q?G5glUl69umtrbiGpmIhTdAnANNypPkOuCYcmvTgAZmasaMrW3b4u6A453VQD?=
 =?us-ascii?Q?j0QMrNTUn4qQ3Nw7VBGnRW1M4s/OUQ/YoQSM5dvv+gWiWgNgXggSg1R+mGin?=
 =?us-ascii?Q?1Q8TQ37GfKIc69zaHa8e4DrFZXdBqkGjmJswpmljo86tTdwXpmwxcMoDgGLL?=
 =?us-ascii?Q?GijwsTT4Vc0H9/l8qC2AzwLo6y6viwsuz6205fXfKkxsvBk1KkvLKoq8BbpP?=
 =?us-ascii?Q?vpgmMU0G+t2AxpgnQ+kYNCufCsyMh8fZAdhcqFAqVPkHEB3SI64acqvNokY7?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?MZpOJzC8vD8zCb0B3f7kg6I2nH4yFjUBtQnz+kWhQY9MeQXKZsIGlA1M/9+H?=
 =?us-ascii?Q?9lVsxlAUtRV+UX3m5Gy21loNcXFgLY6Wn1Jm4Zz2xz7qqs5IMVJlPxLrvDKo?=
 =?us-ascii?Q?3jC3dZ79Xquzlt75VbFB4TLp9AVPIXrRAyP1hmU56ox4sJ3nUaaBybizTLae?=
 =?us-ascii?Q?0XYH5gi1fhkyMIce48M0yTG1wEcM+JRUHqhL30pJ4xQCCjCkpAdx9zofVsW5?=
 =?us-ascii?Q?CzWf6odpLesMJq4rY6c9R9Kp20FDce31g/X0ItR8ZXJhCCqbtg0jfuQjcIs6?=
 =?us-ascii?Q?2yLMRY0Wczx80i+M92f3xX4Y8a70oMVobt8X687lRPt1l3UVEcNP4M4s5VB8?=
 =?us-ascii?Q?MufJov/IVDAwc64JCfpfSDFxKyWGkemMbtFxPVAVbsUEhEhOAPKpksFlBTz0?=
 =?us-ascii?Q?1szi67PMzy2eAiHCumdZF4y5/gQnsFYMyfJYgQnvlRu1SXxxGkSy1LTYwn30?=
 =?us-ascii?Q?kfRewKgIjGPm1O83G4DdXBZWxmqwD4UhgQodeHVH4V5T9Fohgd0tkBgFVxZy?=
 =?us-ascii?Q?UfyVHiWLfeI91bCCgYI3yISNT/6DAMLujYvtzpKTy2HyV/HyFcOb83ewHA7t?=
 =?us-ascii?Q?gJjPIOLlcSEA/A799g0QWEJz76R8DSxncEAg6XbeyJh2UlJ/fm2xbtSoVrbn?=
 =?us-ascii?Q?K1FeE8GTop1nJ6tWvskYItoCK1ZjTSMu9WpZ9Jc7amuhzK4m97b/pki9GnuL?=
 =?us-ascii?Q?BxVoxcZL1fPpKq6s6SMwErvN85W94xlhYADVxeOsAv09oPc2vyST4VRt21pV?=
 =?us-ascii?Q?rOJYgvfJ1cVeB23kDQaFqnn1h3IChomfwMLCJmEVpWH38h83SpYv7/Ln8ale?=
 =?us-ascii?Q?eUqywtkTg7gVPqGygLeirGzCK5ychQ6GRScPuBAglQD1VHfksunugo07Vvlh?=
 =?us-ascii?Q?+QzGQfNZtzFwAig8JcyOV82C1bsj03So3o1sbxpUl5hVFwQ5gr334ghVdNvn?=
 =?us-ascii?Q?MAPt1BDPQO+BLVFn6hNVec5qKLXfPcytOeMrRttLFTJlaS0Nl0T8PuCnbL9u?=
 =?us-ascii?Q?BpJzo/6pKvog5581xfddkkw3xZ468j6rLSZLjPSGIFkjXopWG3cKF5Ya/tyq?=
 =?us-ascii?Q?z1zdTxeWx77Phjh+jiqzAS/uk3+W3/4CU+W3Zphqg8C6b6Tag1+0UsHTTqnp?=
 =?us-ascii?Q?eLqo20W3WChu+ce2l329gqImmRhAYUsIJFAy0V9Rwp4+auJQnKQyN5qFbq6o?=
 =?us-ascii?Q?TviAKrD1IAXDrsSykjYLsGWzXTz0+HH3n/6q/iqZFxPyYOkDGA2H+9PANJPs?=
 =?us-ascii?Q?pWoQcD7oQruHatBqp87s+rkdCMg+f5dtVfZlG+fwSJ6ccj+1TvwiGB5gd43h?=
 =?us-ascii?Q?62TCEaTXY9YnQGv6tvRdn9+i4zMQTLASHhEyT9b05jMxbOIjvOwOtuEa6bEm?=
 =?us-ascii?Q?S4HuFup7rQyVsn+PdV6mgPkT3l65Lavr0bnJQIoKfoHASzq3rRFAYqHSn1LR?=
 =?us-ascii?Q?0e+gODy8uOU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfb1e0c-0efa-4531-541e-08db6b8915ef
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 21:07:52.7321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kERe+G3banCgkzlGp8aNdX8NZD+Lv74Vtm2oubtsL1Yd01htrwKmPgXSGYZzJ7pLXVEwks7MqNYBbWWO3NoZZwvwVB1TJuvamAtON/5WQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120180
X-Proofpoint-GUID: ZsF877mBckACUNC3VPrdpzLiNXxHTu7P
X-Proofpoint-ORIG-GUID: ZsF877mBckACUNC3VPrdpzLiNXxHTu7P
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

