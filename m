Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA126F6169
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjECWne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjECWn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:43:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6369193C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 15:42:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Holfk017443;
        Wed, 3 May 2023 22:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=bKJ02U1bUFpGiRLgIB+zj/k4wi8clNbcfvgzbpYe4ak=;
 b=NAwxeY3vk1Phq1OCgxYWduiIaCUWMo+5MW/Ued6gUYFiIXMG6xNiMbuj72MuuN7Xuotm
 wXf7ro8Re7I6WEOXATiMVo7d6bkh1IFom+oAmDzQMDi9n9YONrb8csmGdBEu8S3Z6RZU
 Ux+vBU6bIe0uiRNb5RmT1wqTmpcg5pKk3XRg9rAtrBUargQJbXcJtefM79+jZ+zyosgU
 zHZgHOO/NWnjtTqBYdjjkNSR+cpGiY6OIBM0MLeo+afc43Max6EjjgOuvaDEIle6YVVS
 2SwgQZ/G6nq8pmuI8NRSyEUbj8S9WhyFgOPWQALhUJw0iFvHzMrT2tDp8GOoIDTerinA +A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4ardva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 22:42:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343LgGhG024871;
        Wed, 3 May 2023 22:42:07 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7y5wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 22:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPrY5ExJYQc+nIYMAKPfXBE4kliQkUp6+yN3ZxVwT80xR57i4EGISkO3r3V+myxtnkVX5QoXYuK5STNv9xUzb8q4HRl9ZXFhARK1FDug0N+Cf1pusAMP6qPHzoTW/74VJNWHzHmyiXzfNSBGNe1s0jA0E7eX7fT2dcnHnjZVAAX1KROUT3D0uvtD9+vvXwPb3NfGCHA3pNS+IW1pJYMljBeHTwDvsVSTCQsG/20/cbo9voXFEqc8Y5wwtyAVmmRd8Z3JCI7m3jkQmcND/VL8UFDLYW2S9jxwClxCtqqyDeOclR10/KPJ0eiNoIJtDNB3e+CZUPHkB/t8ysUREtIP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKJ02U1bUFpGiRLgIB+zj/k4wi8clNbcfvgzbpYe4ak=;
 b=bBT0cGXu1BF1o4gE75lMpiuyAOMDeKKMznfc0iY7ZG8fQ8a+/Gs9CGy5K9BVsaCAp8SbCxagkZRKELO8ElsDhHR0oJEhae7a6OTz0ejL29pwp71KDDsn2TonHmPxUzLvobgYjXsqV0L6uUhnVoe+A2+EvWIk1R6GzkgYW0dd399EC+SSPiAhYKp2imbyzyYu16KeNAFhzQIUVba3Yei9TaAH8nvXPzAjrD9ZMi09ZSgY+CmxWV/W9ficEvyqG21LbJrhWIz3+4yf3RoIKEfLjMPM4lxTUS1K3j/zHQ3Y6EGWbNvf0jUqyAVZc48isay4nnogi6DiVJQnfASR3lz5xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKJ02U1bUFpGiRLgIB+zj/k4wi8clNbcfvgzbpYe4ak=;
 b=HfJMRDHcxcawu8qfpCKLv+Z7neT6DcR/iuS123g/jJhs5Yfd3t72TOEpNwzuAWHtYSdVcSwe796yhS/EfhwUMuqEw8+x/DYl7faxt+oX2ojRp2WkYBwxaE57i5CHZ7UGKhabW38tJ29fsVGAgspekdXDJw+nnsmUzW0dg6hb/yM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6846.namprd10.prod.outlook.com (2603:10b6:8:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 22:42:03 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 22:42:03 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v22 4/8] crash: memory and CPU hotplug sysfs attributes
Date:   Wed,  3 May 2023 18:41:41 -0400
Message-Id: <20230503224145.7405-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503224145.7405-1-eric.devolder@oracle.com>
References: <20230503224145.7405-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::38) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: e72f9e1e-bdf5-4986-6e95-08db4c279d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pB5ZLcB2VkceIKO3Z3FM+ZuEhBYesRJGzFeKemYBRilQEl1JDB0VrJAbECleczx2GkmCNcdouXeu4Xgeyv+/qhrT1l1yTnG4UQToKiHpRRk6j5gRi3MhlFvlO1q+/Eji4P26kQzzNkwwVEdZc5piWPMybcMD3k6Boq+VJoYGKXKRYveqR0R0N/YbDbHH2qY6GwSZFVFG3vUYLzHVKsMvjIoBUgcjRk1jNSulJja3php6XbuBEy6kmKfv03K+7gQ2rac0eliKk5rVhZaSjL/Va7FeRhdtyAgdjeERdljHLej8YEzGrz3LCQIzrTCI4xpxy7OpVY9tjR6rtcPjTmvhKsh/6+o3JR4lx8HHQWc0TtHHXwoUYnic1Cu6Fs5NGs9iTKagk3IkHBjydafOqcKBET70QzPTqVjZplzC6mvDHZEEUTjVAZ1Eivd1NA3qpuUswoqhMIRfVTdp21YpZQ060RCXOgFnDm5+mj2vOhAtyXwnVfTp7P1yuu63XJbi+HrKjTjukWN53RcoCwCuSIEr/kINgKFqgWmKin61dJ0XbA+q+P0Hm+8fZUEFbxcRj20z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(1076003)(6512007)(316002)(6506007)(26005)(186003)(4326008)(66556008)(66476007)(66946007)(86362001)(5660300002)(478600001)(7416002)(107886003)(36756003)(6486002)(6666004)(38100700002)(8936002)(8676002)(83380400001)(2616005)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pqOmdwhRrm/CHT7CADxvjb+g2nk9mZ1iseM8UkMbMRGgkRj0K6wc7G5Z5+WC?=
 =?us-ascii?Q?pEYwaNQiQRyxMdnt4u4jOF0Efnv4KYbaQp09kBwKEH7jgGzTEIrB9NsRoCF0?=
 =?us-ascii?Q?LFxxMZnec/NlSErmF8Fcq7AY7NDyDfA7GO0yhmmWUVm+Y8wbXAjD02L6fw7Q?=
 =?us-ascii?Q?H23pt4gIZWhuip2q0fw1nwNekER8J472bAkbqgwAPZyZJOGU/qqMx5gTBWQo?=
 =?us-ascii?Q?kvByLPqvxZUYupbkuX0b4b9TqH9lpGxU2VBb3qqZ/M+ie1IAJmPvXqS2W7GX?=
 =?us-ascii?Q?mlgn9sghKkWlaR4aItdYeADzFs3M7JZkfyVdmRM84Ec7caDqPYQwIIBh1P8Y?=
 =?us-ascii?Q?SlvlK3aoqAxUHjKvyjj4kLOwSu7GiN4OGWW5C8veQdZFJr/+VMqJfR6gKulr?=
 =?us-ascii?Q?z2SFwK2MquJziYHarNmZE3uRW8QGFs6o7ZcqIj1hop+Kl0P0Il+azoVpcJnq?=
 =?us-ascii?Q?GMDn54E1QCWk6mL60+tmbA9onro5wGMorHIz6nHgHQgNapaaGYHLmZFXQTP/?=
 =?us-ascii?Q?7CnNVJu9FgBeuoo7v9uULtifNqOaQIljjrXBNXYzEZt+Lc7+oz6fwpkqZix6?=
 =?us-ascii?Q?0jHv8SSN3tKgDg56sK4KiPgfQf2RSzYLpDUG3/D15AvF2w8vN/VPoCLqcaWi?=
 =?us-ascii?Q?s+P9v7xxdcXhD6pPP1Jb1FNxrfyv6mTRfvx+MSK0hh959MCkZ2rCg1SIGKvW?=
 =?us-ascii?Q?Lrzm9qoQx7yOwCjCKnQpmgmtUYEA9zD9ktOLv1Lp5XEJwwcGzrcPw1kmufpJ?=
 =?us-ascii?Q?CZmdRTd2DAz2MxxWdW+HkbrlbCQiMtLrrY2SQeF1CyzPKU3fHWhRsK104AXG?=
 =?us-ascii?Q?PBe9IxebE7vYrHZO3kLHD0WeNLccanbbeT1b6V7NXkdqF2WKOq+mlCM91uKJ?=
 =?us-ascii?Q?/tPSvbPGJ5LOciZdhjGcplLgROsPBJEEO2xEnPM04UwYb6KrggbfjAD83S+x?=
 =?us-ascii?Q?YaQgl32HGbXQ6ce/bJGXx4mhJRFsm2NON/3ZwalLUse+it3q3iPlJ+2f188/?=
 =?us-ascii?Q?nA61xWOd8ogMS0zOYFzHj1m3OXJK18vAww5tpRhhfPm/De+U5H0Eb3t9VcBf?=
 =?us-ascii?Q?QQqILHImZ3nubiY54cUcInDk3DIMIUD+jd6HX3qsdCuweEh0zqvmoZOwnS5S?=
 =?us-ascii?Q?z1MH4gJ33GOyyUJVyQzrV1y61tsOY+7Jq3C9MRIyJreH6DS7BeTATbKgU4nV?=
 =?us-ascii?Q?yuSI/dolFZgBdDaJJmJYVPfqr7SEEu5bICNs0nAQStkaM57wRwDu9I805N3s?=
 =?us-ascii?Q?aULVkQz7BYp2T5LcwRG8CiTiHxT5E5ncii34J+hSS2PwmfSh3BCnGd+1lRJD?=
 =?us-ascii?Q?QIytXEGdlr8KN5jOMFqYYqjcqdtFKwXDUgICuCD8y9FDxAEPA/J9uMd6MXe1?=
 =?us-ascii?Q?9i/s+D4weOqGvkZR50C8yZBHzlP9I0LAyK/P9PhZnNz0xgJeV491Z/UAol7G?=
 =?us-ascii?Q?UJgxOerdKVFbIAKlO5nHJWNuaj0noE6T5ttYZFaRJKtaxqeYI7q8diCZU0fT?=
 =?us-ascii?Q?JUEThOio5lE9/BsTyGc2diJMwpPc2C6LNqYpLy5ehbBBxyODr1aFI5691/DS?=
 =?us-ascii?Q?oGrkKGVaXRNAWoGKgk52W+leVPuPv4weXQR0rbfipNEvwYMugzqc8I8u/O/2?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Rt4ekntpEngIpxF62dTX4jfmhEf6NqST0mmHxv7GQBSOIG6eVagrnWG74gjG?=
 =?us-ascii?Q?jFJiDmycNPD+a7uPR4Bdh0SM75ujXhbrzL6SERHo+jk3CbKvqevVV1s3+JfN?=
 =?us-ascii?Q?FzyMCDkHLEdV6lSmjkJRxOAcXx2h2Hg4QwQOtkTxbH4Wg6RMsw4Nf+pxUkmg?=
 =?us-ascii?Q?E+Ja1BxDq0FCHfiVawUBP5iTv9U8QgXbxQkEfGFzojfHmJx0evaBI2EqFVLp?=
 =?us-ascii?Q?S7phouQfvehSTOzFkoxm7ROrL8cdF4GzXBNNK/yUDnhLWFRyR9BSv4cHO5c+?=
 =?us-ascii?Q?5niD1D3oA/Bc8TWojVA7XKc1RADZfAPkyyNEXalDmgR1rQ8+aA54YA4Jt59S?=
 =?us-ascii?Q?itn8xlhl5uzwAMyFWHvIuLas5X5imzx7MGHcqd6IYj8CF1CtnfxsKfSc2eLI?=
 =?us-ascii?Q?jIFcoEVDIrPyOH1WdAB3NWIX3cMknAV9Bwk4nNnxrXQZ2+WmuLc6++qVUGXS?=
 =?us-ascii?Q?hWc8a32MQBlx7mJDQXA+JMIgwHYimmTpSka5oqWatN1jAsw/1GSZHemX03jL?=
 =?us-ascii?Q?pfO/8VL/xUrkWG9B4M8ZjrgzZuO7xYGZwsUyJBSc1rwhZbiv9m6BGWQkwBrW?=
 =?us-ascii?Q?uHEbvZPcxIA+GZeNwPwjGKQApmpiiIpEU+rgmhCve8yJk9yXBWptJ3io0N4J?=
 =?us-ascii?Q?6Gl/S1ykDHXutvztoa/SFK1UyO9ulAtEmxE4W6kyCOIyhecRZRO2nALKWkRi?=
 =?us-ascii?Q?59KEkv5szWHEGjwu9HwHYIWDbiM3hVVJQ+pTXXZUngq4thgxjuLFPWt8LI+h?=
 =?us-ascii?Q?GnntCwRSD3Ys52lmHr7uolPVKyiXbIcUfuAZeE3BvkQVMgF9qxBgih5lsIWt?=
 =?us-ascii?Q?BCOHdNBgAm3Tf8zHCgHA6aGVoe6M/U87syV+bHHCUUxnrct8DlunNGYdg4l2?=
 =?us-ascii?Q?U1ue1wvNyXxT4EH3+mJ/67IWHzrz7cJx/qm5fp/WkLz3BwZVyjLPUHYO0kGP?=
 =?us-ascii?Q?M2aqBaNioYvkkpH4uINM3X3NJ2tSuE46iJbnjQSfuf8HJqBvOlWdeneHPnWk?=
 =?us-ascii?Q?9JgL8/mWijjyfU6cjyzrgbIyfYc7FhJWrUT/PqEvFQco8/hn0vRdcVdkzD/Y?=
 =?us-ascii?Q?+ohax+zXS3K1oMD+Cp7TS/Okb/qxkzrq6I2ZrIH0ezDGWNY/l3KZN1whsCtL?=
 =?us-ascii?Q?Qu6ndo/7Z7alxI1ZtWPlJ1EFsKckqm5w2joljQu2G5MhC3vIwLp+/y8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72f9e1e-bdf5-4986-6e95-08db4c279d45
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 22:42:03.1079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+tXAh5m+q1YXby606ZQv4nZ/zR6YsRvYTCiQUt7gzsYpXF5EiRWGOuleHyike0cKNj2Jc4/OAXG0c54cDcLoLCKv3V6O9ulryY3qVKkayw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030195
X-Proofpoint-GUID: xx5uyqdO2KMql-xU8UOP7mEmyrK7u4hK
X-Proofpoint-ORIG-GUID: xx5uyqdO2KMql-xU8UOP7mEmyrK7u4hK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces the crash_hotplug attribute for memory and CPUs
for use by userspace.  This change directly facilitates the udev
rule for managing userspace re-loading of the crash kernel upon
hot un/plug changes.

For memory, this changeset introduces the crash_hotplug attribute
to the /sys/devices/system/memory directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/memory/memory81
  looking at device '/devices/system/memory/memory81':
    KERNEL=="memory81"
    SUBSYSTEM=="memory"
    DRIVER==""
    ATTR{online}=="1"
    ATTR{phys_device}=="0"
    ATTR{phys_index}=="00000051"
    ATTR{removable}=="1"
    ATTR{state}=="online"
    ATTR{valid_zones}=="Movable"

  looking at parent device '/devices/system/memory':
    KERNELS=="memory"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{auto_online_blocks}=="offline"
    ATTRS{block_size_bytes}=="8000000"
    ATTRS{crash_hotplug}=="1"

For CPUs, this changeset introduces the crash_hotplug attribute
to the /sys/devices/system/cpu directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
  looking at device '/devices/system/cpu/cpu0':
    KERNEL=="cpu0"
    SUBSYSTEM=="cpu"
    DRIVER=="processor"
    ATTR{crash_notes}=="277c38600"
    ATTR{crash_notes_size}=="368"
    ATTR{online}=="1"

  looking at parent device '/devices/system/cpu':
    KERNELS=="cpu"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{crash_hotplug}=="1"
    ATTRS{isolated}==""
    ATTRS{kernel_max}=="8191"
    ATTRS{nohz_full}=="  (null)"
    ATTRS{offline}=="4-7"
    ATTRS{online}=="0-3"
    ATTRS{possible}=="0-7"
    ATTRS{present}=="0-3"

With these sysfs attributes in place, it is possible to efficiently
instruct the udev rule to skip crash kernel reloading for kernels
configured with crash hotplug support.

For example, the following is the proposed udev rule change for RHEL
system 98-kexec.rules (as the first lines of the rule file):

 # The kernel updates the crash elfcorehdr for CPU and memory changes
 SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
 SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

When examined in the context of 98-kexec.rules, the above change
tests if crash_hotplug is set, and if so, it skips the userspace
initiated unload-then-reload of the crash kernel.

CPU and memory checks are separated in accordance with
CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
If an architecture supports, for example, memory hotplug but not
CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
attribute file will NOT be present. Thus the udev rule will skip
userspace processing of memory hot un/plug events, but the udev
rule will evaluate false for CPU events, thus allowing userspace to
process CPU hot un/plug events (ie the unload-then-reload of the kdump
capture kernel).

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
 Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
 drivers/base/cpu.c                             | 14 ++++++++++++++
 drivers/base/memory.c                          | 13 +++++++++++++
 include/linux/kexec.h                          |  8 ++++++++
 5 files changed, 61 insertions(+)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 1b02fe5807cc..eb99d79223a3 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -291,6 +291,14 @@ The following files are currently defined:
 		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
 		       kernel configuration option.
 ``uevent``	       read-write: generic udev file for device subsystems.
+``crash_hotplug``      read-only: when changes to the system memory map
+		       occur due to hot un/plug of memory, this file contains
+		       '1' if the kernel updates the kdump capture kernel memory
+		       map itself (via elfcorehdr), or '0' if userspace must update
+		       the kdump capture kernel memory map.
+
+		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
+		       configuration option.
 ====================== =========================================================
 
 .. note::
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index f75778d37488..0c8dc3fe5f94 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -750,6 +750,24 @@ will receive all events. A script like::
 
 can process the event further.
 
+When changes to the CPUs in the system occur, the sysfs file
+/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
+updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
+or '0' if userspace must update the kdump capture kernel list of CPUs.
+
+The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
+option.
+
+To skip userspace processing of CPU hot un/plug events for kdump
+(ie the unload-then-reload to obtain a current list of CPUs), this sysfs
+file can be used in a udev rule as follows:
+
+ SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
+
+For a cpu hot un/plug event, if the architecture supports kernel updates
+of the elfcorehdr (which contains the list of CPUs), then the rule skips
+the unload-then-reload of the kdump capture kernel.
+
 Kernel Inline Documentations Reference
 ======================================
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index c1815b9dae68..06a0c22b37b8 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -282,6 +282,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+#include <linux/kexec.h>
+static ssize_t crash_hotplug_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	return sprintf(buf, "%d\n", crash_hotplug_cpu_support());
+}
+static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
+#endif
+
 static void cpu_device_release(struct device *dev)
 {
 	/*
@@ -469,6 +480,9 @@ static struct attribute *cpu_root_attrs[] = {
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+	&dev_attr_crash_hotplug.attr,
+#endif
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	&dev_attr_modalias.attr,
 #endif
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index b456ac213610..24b8ef4c830c 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -490,6 +490,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
 
 static DEVICE_ATTR_RW(auto_online_blocks);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+#include <linux/kexec.h>
+static ssize_t crash_hotplug_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", crash_hotplug_memory_support());
+}
+static DEVICE_ATTR_RO(crash_hotplug);
+#endif
+
 /*
  * Some architectures will have custom drivers to do this, and
  * will not need to do it from userspace.  The fake hot-add code
@@ -889,6 +899,9 @@ static struct attribute *memory_root_attrs[] = {
 
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
+#ifdef CONFIG_MEMORY_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 	NULL
 };
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index b9903dd48e24..6a8a724ac638 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -501,6 +501,14 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
 #endif
 
+#ifndef crash_hotplug_cpu_support
+static inline int crash_hotplug_cpu_support(void) { return 0; }
+#endif
+
+#ifndef crash_hotplug_memory_support
+static inline int crash_hotplug_memory_support(void) { return 0; }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
-- 
2.31.1

