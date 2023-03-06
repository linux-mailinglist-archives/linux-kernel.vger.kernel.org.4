Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F28B6AC7DC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjCFQ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjCFQZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:25:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EEA38B7C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:24:42 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326CxFvT031462;
        Mon, 6 Mar 2023 16:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=TMa2NJx33yIc4VOtYE8TqZmk60QFOgD8Z7Kqzm24ldY=;
 b=G5pi+9WnJnqHD6ZXpdoEf+pOOASWbl3NiQN2REyDkkOmXytYmB6EupjxmTRlSOtYZChq
 Fe/g/PjuhG7H4u+5e5iZaZqNai8TbtW/g/BHhrF9N6PiGPnXc8EG/OmZ1NxHthFKK0+P
 qwpNayO1e1qgDi5yHVHZWutv5Z6Q7Gfq9hfLkqiWRAVzcIX/CkDkBGmErGLcO30XYoCx
 +Q71FY/sQJeU1zXUHGQZhG5MmJeMSRZPVRCcyUGkdKQbp+FKXq0avPCqUEjM9wz0RfmY
 Nbu38m8gmwkApPH9ypXkYppishW4ea4aL0sxfRxJ939WviK6dZLLAp+2rB9g+fCGuWWi iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4180ua5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 16:23:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326G50X7026894;
        Mon, 6 Mar 2023 16:23:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u1dq6n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 16:23:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coLXWh+jLpuGw5ayQws+70TLdatPujd5jvb+yEboChoz6KqtJt+8Xd1zFp1Lxk/FxRmUoKaFi/E0T8YnUSVrCI7jHAWZyWcch8FvFGIrbZjrLBtrWc60DTJ/zca0qZXZ6OaLKURjwu4saGTHtEAmXxp8gcLIhBGc13/UWC0q4aJiZJtzA7X+eYVE/nuD8+/edtUgNUB/6HK6dNs9502OKXZzFfvNFjIm9n3ClfHsFDuzq7R2W3g58eA3vdZeclEAFPBW71goPaEXgu35c2IIZH0oK3/l2GXNOeiZpolnpP3CZUGfO64WCH2M5PMoVMQJh+bB2pMtBGxdf81l4S4uTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMa2NJx33yIc4VOtYE8TqZmk60QFOgD8Z7Kqzm24ldY=;
 b=BW6WSJ0k0Uzqbiq8VOwdSpQmHiy9Dk0HL39VjSZKTG2/bYk4uvN/Pn1YlbSAMCLYNmjXwd8+S9plciYQZEIZXaBoVPN6crnkbVAKiwcQNr86aCVKUEZT+rf3u+JFGlXVK4YLj3eVWLx9fZ9Tv7GrPAYb2PJijdwkpXDH4w8I4395TxFob2ZZq0dBup/dM4KchrB4lGSwQ7jXZal0GDg8I2Y5F8KFT/4Kh7+S/KRKFS7OES0ILNdr6q/aE1mUrgxA0Q71wlT9Pd1pZwyK8sEq9YB+i/CF58WdU4y50q6Zy+s0hWthuOYNOsloy9CG/iGfU4KA7N+/+FcZYqlncTNnsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMa2NJx33yIc4VOtYE8TqZmk60QFOgD8Z7Kqzm24ldY=;
 b=gTEI+YagtEL2JaITbebpn9YvNlrPmPl2wyew9m4hCyuw0kPolBny90twPuj6GgS37qj5GfvaKmJFfdCnEGrIuMqciytZfDB2xluSWja7FtZrRTl0xdza3gPzF3EBtqMxarlj9L+Z8L9/D2b3vBLN6CWVhnx7O1xsBfLjY8Umo3U=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB6530.namprd10.prod.outlook.com (2603:10b6:510:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 16:23:13 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%8]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 16:23:13 +0000
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
Subject: [PATCH v19 7/7] x86/crash: optimize cpu changes
Date:   Mon,  6 Mar 2023 11:22:28 -0500
Message-Id: <20230306162228.8277-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306162228.8277-1-eric.devolder@oracle.com>
References: <20230306162228.8277-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0076.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d214e3-49c5-4c58-dfe9-08db1e5f1530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9lW092tEuXsdOVAH5tctvxC6JfCADRJXCuuRAU0HGJGjgiuu6uhit6NsN7IpHz5mrCA9kYjRPL+R4hoav35k/drvUmW7EaoAMdYqJOiZfS/uFiA9+YOlFh+zFu9kHufchbfUYnyNenEeIqz0e7Rtq8S8cu6etgZbly0/opMOgNFQtHLftxncPlIwbWdZDxYjoOTOU2u7CU28pl/HXADhsuXgnknUoqOHyOeq1236J7YOzg5tdid8Z4HNenz8Ustv6o1aJVxPGcWe83qj9IDWvQcvPJsBMTqDC0mfH5RZNne55jvy7s5yaqW2YzRzzfeS1dnRIqzP9EO/KtioCbU6z2uLS8kCZkcNBaXNANctAv0YGFQKX+WtXWsqZzAVcCyq3AZOE5WflnpxpJxZYzsgiB4xWe6fZjtOVnHRf3a/hGZnTtZIf4kcAxmNL8G4uPMU9cQLCL2RFvO/hh5mwwTQvwK0Kqha701/7nZqIRUAiCMjHE0czNJGO4ozUOl6okNy6ArxU8NfsFneDiLeeZKukDpqiFuE3xUYmHqjsB1x5PgFryNW4gYc2bF8EO931PbeaUSRlhHSapO7zHEgDV9YjNEES7yjPmfgxjhnd9lqRTNn0Jr+oxP8PEKicGWHF2Kavp8Vd9pZVoUhiIvEkj1uug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199018)(66946007)(66476007)(5660300002)(4326008)(66556008)(41300700001)(7416002)(8936002)(8676002)(86362001)(36756003)(6486002)(478600001)(1076003)(6512007)(186003)(26005)(107886003)(6506007)(6666004)(2616005)(2906002)(316002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iXuTQr0+5Uw/Ms1EjhBNOYjAeNSYvHaZmA2jaTiUsfENsqaunp/1iVD6+kQJ?=
 =?us-ascii?Q?yWSA91sX2qHYZTprP69kfr3V28J6bu4qVhlWG1I1xURTy41KMDAwrFlv0bVU?=
 =?us-ascii?Q?Th/lUT+DG8S+LGXC3sId+amYNbEC1zG8aNa23ePeTFWqybvSzBcOC90XoE+r?=
 =?us-ascii?Q?zJaldCgoLQCcRo+/oymKAJX0Tvp/w41hWclcwfwi+7JKPSupCGEbWvNsLXsw?=
 =?us-ascii?Q?wKPQuCSoua5wVUohEoudPtediHcrQFKGSPm5nLSfSEP8InXSmLWYkGf5Jge5?=
 =?us-ascii?Q?Tv4d2EHdYHcpVuU5UeuODIlvUySI/BTjuj3+aCVvbezkLz824ooiyFRyqh+B?=
 =?us-ascii?Q?uTP/FPwydChPrO5d790ywQqUMcikyygnIcC4F26JVIykV6EsIR/nr15nF2VQ?=
 =?us-ascii?Q?BtSpN1NH6tcoMe9fL9BPFnIJxc2Da+VT2LOynN+4wkbyXanjGUCx9gkHA0uT?=
 =?us-ascii?Q?4LZDZhvUAnIGGTA12Z1lKZi7/pismtkExE9MhNKFgftX29S1c/HEnBb0MYWT?=
 =?us-ascii?Q?yqZEiT31QGmV6VkCAtasRYhH+9EZ9lhCclpIYUpFdigU4HFLHPJXs6cv+NZe?=
 =?us-ascii?Q?rmvV2tu3NuKDSBbW684D2Qtd0HanstHz0axJlCxaK++0RVQAaf1hqaj5K+s1?=
 =?us-ascii?Q?fCclgxb3+ZFZMLUzOG0ACAesmyufSTfv/NYI9ZW0CMhr6lQ+sqHiMYyTLSMd?=
 =?us-ascii?Q?9j+6lLZTKjOxk5MyWw1q62xUCQeWQPLuw4MyBWe48akK0IzTwGM0blDrE8mK?=
 =?us-ascii?Q?P/474JJ4vI6ZVNpZfKNml1hYbxGoyJFkTQ5HZVWFT2pEq148mrGoRoGYG5hJ?=
 =?us-ascii?Q?qBcANjiDOaE21bLHJzuegxkn28yq/x59QMWVEGYPT7Z10GnrK03pIrCR+vPk?=
 =?us-ascii?Q?cm2Qs4NlVRhRthzNVpToBs7I8L5QlhBZK/l3XnNlXvY5cJDIMrsUBDXlzpg3?=
 =?us-ascii?Q?0y9pGeBXZ8yMs6oSS4Zn4ExusP29j9Z48AcMiAVl4iAeHal1EhCybmO79kT9?=
 =?us-ascii?Q?DZYpW06zGpiRN1gM+U2z3MnSiCs018OLNqYt0e/h0w68tehIjBMGS9efCBEj?=
 =?us-ascii?Q?XYKnc/krnAGMOFYFjRoozlfp0Y3diWoxQSlkav4lEigbDw11N6DRD+oQkKM1?=
 =?us-ascii?Q?JbW90sVs0FmrNAncXw15ZjFymxIG6OdDwfCzP7a3Klngjc9thW9tOZoTObHt?=
 =?us-ascii?Q?SCMmzwPDCo8VFNwDFrfoJjUvz3uOlLuZRqf40ep30oHYiiaiO193mabhBdeZ?=
 =?us-ascii?Q?10QoGiQdWM/rNbDqXlJvetUlQXN2II2UnVIWHCDMKW7AnHgWm4QbeSFp3ZN1?=
 =?us-ascii?Q?tTiwGzrQyoz23E2rCuB6XVtrhtps65iVHDHwYJruAXpaAt15PKNr78k5sDCM?=
 =?us-ascii?Q?TklpEzp6jV6Pbnq5+9ON+7lXaZHxBZ3O0f2+PKnZSNfRVDP8gGU5RqWVR7Fz?=
 =?us-ascii?Q?opmyrEekqcKhbNKRJmO75xjWOCQAB/4S0DliAlSbjrCfxlr+Lnai/wvK17dJ?=
 =?us-ascii?Q?rvOgIgMgqPvRWij3H67R6b2PZj+xJX3Ve+DfkKsILxDgSiD7lMUK3MadLdB+?=
 =?us-ascii?Q?OQqXgJrZnF6t5oz3yXCKJDaHMtK+Sjf1EPrACGdF4PU4m3Hqah+lUu8bvJ9E?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EVMKuulZ/g0wuul/IXV7OUe+hHptEGg1KIk8t4gDbhZoajbgw4/yyKMPbyWC?=
 =?us-ascii?Q?o1ct/OztRvVB6HwBeNtoF+BOKKOQCeMec5qEqp0xj53hU8qvtRVxnXpWkLHw?=
 =?us-ascii?Q?uh3mL5jfx9lMJngQeikn8SIg7DYQv6eCPy/2czb881ipMcNBbLvZR7QZEBOP?=
 =?us-ascii?Q?Iiv2GeUZgIq3vgpBP8n9s8bBXMDuxlLwzZM90CTjVHDfMoeBbCpyAQ8sC6OJ?=
 =?us-ascii?Q?nwkZHx+Ea/iH4q7d/8iOzFEQkyU4r3s5vhQDH3/uWKf+Brh0GaIWt134tMA8?=
 =?us-ascii?Q?jWrot+9wkUyXNcDYO9r4hNwWGCb9QHeUMuODA+0yhWgOezJ0FmuVw52SlMgD?=
 =?us-ascii?Q?+E5PDXhbwPgzlSBIOfbGAMaonhKyIBYi2tXGs4it5loiHrlv32szoFFNpABD?=
 =?us-ascii?Q?JMjKFR8OmOT1m6u9XsviYcLc6b6qv/5ISMLPSKlPSmNlmawUKJrgFcMqkjLg?=
 =?us-ascii?Q?Z2ajugRyCCstLmL98m923HubB4yA4HNDB4VaxWHT01LPKaLhAUT8NCh2ZO+D?=
 =?us-ascii?Q?WBJ0ef7gMOmoe+ISLjeeudyd0yM0Qq9YLiAJ8/W8dEetCVEuWv2gs4ZzpsU3?=
 =?us-ascii?Q?0lTKBRDWnJXC/ouMMo3q2DmiCiWYkeqpH1nQ0JcIN2COE5lxtCNEUft6IOnv?=
 =?us-ascii?Q?YA9a8LvG9bkA5kg2u8xqODoQDwKOr5sUDHRGfrOaB4CQcIdHiCfrA1rM2F2F?=
 =?us-ascii?Q?GFs3M4gQEIkaRejKD3rCbL53FYHqM4r70II+x3NEu6JJpJ33/OMB84Z8YpP1?=
 =?us-ascii?Q?+mBR/LPhBBcTSRSq2rVh1VQZbvtL8g3JK78yCUguYi+lWzf+zabCW2FY+U9t?=
 =?us-ascii?Q?J/eDgjiFpyrVKC+TXRUEOVW5oUuXp23MupMc+B0Rnzsf0RB+3ICHztAczaMl?=
 =?us-ascii?Q?BTpPirST8erlMxJOsAL3IFHebCGP69GJTeHw7deO3MN7rKn7wwEKX5k4wFz2?=
 =?us-ascii?Q?DbAjrqcg+qH6VZjqdax0z+JSgho/9FJ39wwFzzwn5dy4kKCd9Kzl+6MCVhcq?=
 =?us-ascii?Q?Z/AzC3DcB8QdOQNTZqqguN1yjFmSq2K+8tBfe+Uc5m5B/WQdT2Zv3MqpmbOJ?=
 =?us-ascii?Q?OzQ8rNR9SA47PlFB0QcZDze7hHS4heyQ+7C7PUXZ3g4jZjOZjnEijXRSG6y3?=
 =?us-ascii?Q?5ingZV0zOOrcg0xwtwFTriZEXKKvtWDEaFvWyrNAO0hrDcFuQQV4cOs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d214e3-49c5-4c58-dfe9-08db1e5f1530
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 16:23:13.2276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fol9016Zr57xA03kCyhP8Prbljwit4J1TILAcMNHfZlqGh099HEs/vJeIZP2++ceaxDZd9v5pP7dRvKtz2YgdaRgcmbgcLy7fBO7dHLnpG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_10,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060145
X-Proofpoint-ORIG-GUID: 5ieTIlNYOlekrNhT-pNfW7FgT5wQo6KA
X-Proofpoint-GUID: 5ieTIlNYOlekrNhT-pNfW7FgT5wQo6KA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is dependent upon the patch 'crash: change
crash_prepare_elf64_headers() to for_each_possible_cpu()'. With that
patch, crash_prepare_elf64_headers() writes out an ELF cpu PT_NOTE
for all possible cpus, thus further cpu changes to the elfcorehdr
are not needed.

This change works for kexec_file_load() and kexec_load() syscalls.
For kexec_file_load(), crash_prepare_elf64_headers() is utilized
directly and thus all ELF cpu PT_NOTEs are in the elfcorehdr already.
This is the kimage->file_mode term.
For kexec_load() syscall, one cpu or memory change will cause the
elfcorehdr to be updated via crash_prepare_elf64_headers() and at
that point all ELF cpu PT_NOTEs are in the elfcorehdr. This is the
kimage->elfcorehdr_updated term.

This code is intentionally *NOT* hoisted into
crash_handle_hotplug_event() as it would prevent the arch-specific
handler from running for cpu changes. This would break PPC, for
example, which needs to update other information besides the
elfcorehdr, on cpu changes.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/crash.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c9aaec9de775..82ea2b1bdc61 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -471,6 +471,16 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
 	unsigned long mem, memsz;
 	unsigned long elfsz = 0;
 
+	/* As crash_prepare_elf64_headers() has already described all
+	 * possible cpus, there is no need to update the elfcorehdr
+	 * for additional cpu changes. This works for both kexec_load()
+	 * and kexec_file_load() syscalls.
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

