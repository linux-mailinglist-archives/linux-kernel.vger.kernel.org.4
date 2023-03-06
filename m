Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEC66AC7D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCFQZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjCFQZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:25:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB0339CE7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:24:14 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326Cx8M5009619;
        Mon, 6 Mar 2023 16:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=5RR+nmTV8tgATzAsxhlutWv9tznrbgyvKV40fB48SPI=;
 b=uVpXP1yMGBLYwdpVljgziZpud8eqbULPdQXNfMMmKm8+fW/+MuvuHIZ4vPPfzzgsgYEg
 j/8YAIPBzKwMDUGmqjx5xaiw7/C9g0bZl6DLg2DVm8x/AU6hTPPdIKDj3M0h2+WIBUeg
 /hgzfFnzJd3upVlrk3eHWkK6ukB2h8v+ySvh8b8tD9xIjcOCu2J3H1nY7ft0dMRpPLNP
 mcDdAo3HAm4qrFE4ubC/FUijkupWH7zeSjPcR1TpPx0u1k19uMda1mQRbc5J++zpiP+Q
 Y9++qCouMv17eOggXsFtS3KdAVu1xJcdnDq+MzUzScrXxKYBy/2bz1w/UslwRckQxXpm Ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4161u9pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 16:22:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326FJ6EJ037036;
        Mon, 6 Mar 2023 16:22:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4txd75uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 16:22:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DL1rZrlAFp/y98cCHE2bQG1df0lvy1LVQA+KDsny+ZEDN7UfPAc+xXCclohB74bCp3ltFzQ4Vz3l4fGxgCGSpdF6cUbY0+E/5j0yDZRc+qqXZ166XIU7xQvN61HLDN67rJws9Fatsg9sWUgOepJQvK1iUf1luvSEZ2mtzMbEdnrqQDCZ1JoBjlJ24M0vTqPwtrAqf0i/2yONLz+IxJUjWktuid5vFJc8HJha/N/Jn1P6ewt+N8AEov9bV6+pCGzocFdOEEu3RVG4GzwcFzUNwJGrGffXbfaw6VO6vQ1i8Jyw9ZeoNyusdF9sEPSz6u7jURhByPIK9L+UVBe3NsQdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RR+nmTV8tgATzAsxhlutWv9tznrbgyvKV40fB48SPI=;
 b=JpgMxpRWrI8pby1FyyXeFblvy9leroWzL8dfrESz6egDphmdc0UE+4FNXfRtz1/BWdqB23kKI9kvfOH2diUN+uhopYbuFbicd31u5Hh39XGbsTdgKW47hwmMzkVg9lInEy8lWsuKBdlk3Ab0UDuVLIijsnO+dViPMn1AiG0PZ6Ycd2UCN87/3JU0XPIjojB2kOGyZj2SkAxOvQNVCX/PUg4nE7xkHK0HeGf0EOP6RWf4mliEU+7eMwJRPTOMtXCqaeG+f/gDbPfhY/OIK2EnVGVgl2lqDF6Id8ws6q2/lutp0KriuZa7z/lvCrOTSH3AZi+5m/oF1q0ofhXT2nW7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RR+nmTV8tgATzAsxhlutWv9tznrbgyvKV40fB48SPI=;
 b=d2PQ22JyN67p7w6t3e1Cm4kII/SGiiR5mwjLJv+rJ1adHkVcHUK0oPe1aycO8jGETT2TGwQ8ojD2v3oqnqbh2ZHoH79gwsSufA4tRrQ12nvvBFKXOqqUky/oOfDwPfJQOqbEL4LL3vHxthaBqjO1BzlxzeWwItU77nwi6v7kCDY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB6530.namprd10.prod.outlook.com (2603:10b6:510:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 16:22:43 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%8]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 16:22:43 +0000
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
Subject: [PATCH v19 2/7] crash: add generic infrastructure for crash hotplug support
Date:   Mon,  6 Mar 2023 11:22:23 -0500
Message-Id: <20230306162228.8277-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306162228.8277-1-eric.devolder@oracle.com>
References: <20230306162228.8277-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0477.namprd03.prod.outlook.com
 (2603:10b6:408:139::32) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: b20e1063-2285-49d4-eca4-08db1e5f03b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uf97XHhmlcu4mqDKMXWS5lX+60YzikqPd3vTricm9TyRTwFam4J0biZh/Ir6zfJS0SZfWt6Bkm6c9xlKOaoff+S7w99VB8RvfpQf0atDgJuhvmPKUZZfPTe6rIYhI+nNAH/rgke289b/gl5+D/pJj/q5P2tg/YnddP1EqZl4MIbTcSffGwFmw2BIAX77qoSDjd6MskNezRVmNdKLygUv/cVDAJ7RCM/ipq5ndRoZjampZ6AnVpDdz5zSFGsB8BsDLSzWQOoiv4Mmy8NkYO5gHnG5g1HUdwuzsKR7gXmXZsy/vryg0wjHcSAspY2jC8uZYSzGHMHJ0eLHN/+agWRyOlVj3qQ0e1FSEUr07U3a0jFTf8vXmg+iIFrSoMase1En+VfWcX5PtEVteKV2SioDPlyanhCTdiXZyuMJclRey/wK9esop1HaXxQWskLJqah3Zii5zuaaEy3iylf/IRDBeFv2tDNVr9j79tFNBfUGdccb1tVJtu41bmQ0jNv75hF/VZTx2AZXPoOO3Tht0WCv4ttG2zpyrtex60AJ03yamrWeqrvsboepzeVaFYGlKAEOpk05HkI3y43e2UZNJFTVa8pjyOQC2C0ehhqYchas/lbKOaah0T/Jjohbeh0h3fOprj3FnEePa8l4E8XHP0RNiUbJLChxkFqI16Nm2e9SwD/gITyivsXtFfsytUfSX9Pt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199018)(66946007)(66476007)(5660300002)(4326008)(66556008)(41300700001)(7416002)(8936002)(8676002)(86362001)(36756003)(6486002)(478600001)(1076003)(6512007)(186003)(26005)(107886003)(6506007)(6666004)(2616005)(2906002)(316002)(38100700002)(83380400001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/1yNF6iZZ7ADMWFmJYeNR4cE0Xf+FZUrHJeg6CGCYSk/6I02TS5c8cwGHuD9?=
 =?us-ascii?Q?Stj/fxsvl37e86G9C7uXjrY3VoEV8bsBuwg7kEiDhzJtQpHrczs5JqmsPeLF?=
 =?us-ascii?Q?pqLKmYAQtWbHbQo+mcEZ1oPWZcQw00RCt/RuolRZdG2dP6tZA95HraavBquu?=
 =?us-ascii?Q?jvx2AVoqQdPO50+17XkmkNaXMmwEPp1nSlDFpzOe/w7MkM9K6r+Ph0YP/3FF?=
 =?us-ascii?Q?IpEUmnXI3HYN/0YFwZwew7CVV0NBhV67IIgVQ6MhQztm8g2PFbnJHvKiNWfS?=
 =?us-ascii?Q?w7z7zqFKo0aUm1FmYVKZ4gUFmVpnFLykJKeb0yMJS3mQWfDTW++dZoNwr5dq?=
 =?us-ascii?Q?of2WpRsnMTP/awhCq3iBw0lL/qbc2O70cu6pUp9RaORmqqCWYfiqIn3fePkG?=
 =?us-ascii?Q?IbXY7zGzRzp3TmgEtPY+EF4+4qwja31zOtmbCCuNGMaswVJyt6Qt5v+FsLcm?=
 =?us-ascii?Q?rtruWAIDT/PcBYkw2RFs+M/yFN+cNzKVd4OP9e2tlPDFzXIfvKpv3w3ATN2d?=
 =?us-ascii?Q?oMSBoaSJ+K25SvUjFQDPKn5IDGuvEryKoN/MWURMSfF/gHKXSC7efRc7FaG9?=
 =?us-ascii?Q?O+RRwaokdIGAhCzFs8SlZuNCEbR1px3JWjPv9kNuXFJBoS9oc7wlTyPhlqk0?=
 =?us-ascii?Q?wPFnFHkN4IJkMxx/yjmcqmlE12MdubCpCMNxw0iZPUyrhkTHJ5F9qXIUYLuj?=
 =?us-ascii?Q?RT+QgX3Ma37Rb961s3jnRjKTV7nFEfwlgPswcQiwr2cy83qcwe3AHBZIjJ+u?=
 =?us-ascii?Q?KYyzdrLa6Y0GA6cgXbQbfCVXalJJmABTPEaBSf53JdgtIfQvDrL0x7IlyRr0?=
 =?us-ascii?Q?gMO4jRElfCBROn/2MlLUhijf8VXrxpZSqgjPRR9gUS22gJs35vp6PXy378XG?=
 =?us-ascii?Q?pKDkMn+nuKi8HYQmZ7YUukMAiIzWky6qoBg6ge4WsxDoYUTbynXBXqL0XyUo?=
 =?us-ascii?Q?0+mW+gnZLgdd9c39F64jI/6FYi/RkCycZTkOVMRv0Vpo2fJixMBlggeG1tOz?=
 =?us-ascii?Q?YEpDXqu7C9LKTgBS9qWMAoAOyL047+lB0EiytIEAl5uXfNaFcCL0+FS/UsF0?=
 =?us-ascii?Q?HOzRqGwkZzHW5mBvm5MOSPfGcaKvJNo0I/gJ4HjdbRB7qflro2i7SzxeoPPx?=
 =?us-ascii?Q?asLhpCrA/9dSDSpOk1F3hxN2tJXbpSe72o82/TBHy09u/Whb/LH9O0+gQeog?=
 =?us-ascii?Q?XdO8mtki8X5W6qeZhSS+YEYepqxs3ut11hzYUoGBu85uLm8oJCDRypSwNGUh?=
 =?us-ascii?Q?NYCQeYtgV5Z7qHrof+PpxSGcxj8OltcHeU8qhWfX9fJ9YlYBfxJYC9TmgLmO?=
 =?us-ascii?Q?cOIRukIxxGTW+oir2pZ+J92fcyyC2mVMzwpyl3KEtr3UDaNEqVyL1N2zhTTB?=
 =?us-ascii?Q?gJ87SRlKbkln7+ENwSgeu5smywpxHV41QhIpBkhPPHYw8Od1BLRZ8B/ip5Eu?=
 =?us-ascii?Q?fLSKAXxWXy19KfwZOTNL/PuH+LXI94VUwtXAISJqpNqZeTPCY3OLb1v0/xFK?=
 =?us-ascii?Q?9kTuygQ9bJUqpowCflOd1Uh1ef4SDnEcxWrGWvZN/YuICjI2Sos2F5go5SzJ?=
 =?us-ascii?Q?rFiGULKLydRavmO6vJfZwHTq9hdzXYdh1Pl81MkQkUAXXTfzzSPbMCUkRljd?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pK0idrH0q4a8u1SKpOTBlPxmwO5v+gr/jkIwDkdZa0tOH4HKmpETJfaD11yg?=
 =?us-ascii?Q?2x0x1oltmQYQDfLy9WYdHRL4F1Rml9U++e22eFU7dNBsH+1kdKRBNxxlI58m?=
 =?us-ascii?Q?r1kAt9nA2t5sdV9g5DgUov8EcuXoFAOBdzIXKaFMV3z7zV1UxchEPEVC5iqL?=
 =?us-ascii?Q?bjJEkI+FIM6eEoQICc8BEbgC+0MJQ7UNaEU/88R1VwWKVQbLO14wNDoYqx34?=
 =?us-ascii?Q?55C9JmGlU1m8yh/SGYxBo2oV4d8ZSigTAxUuZK2qJbw6+imzfkyuTBgxeF/D?=
 =?us-ascii?Q?eP4tynfoFZ5sfU3wtGgeQJ1870iznH32vqdQ/YlLFkxsokjUrdRmvY9x18pi?=
 =?us-ascii?Q?+fre7XYByEF+5G+U358kP1y9Y5P19GdjVyobZJPejmk1wiVErLmzsKAlILgB?=
 =?us-ascii?Q?oL0BEVSUUc1z2yCJpNxubdSIjBoHaIgdH7i1xkJjr63Rl7XjSSAaztm+o9bU?=
 =?us-ascii?Q?uVpcbe8ZpVxLQ1krTZWu6kwRCFuvORlMrJ7LWLbJXujhBHRcGb9C3Wg1qhFI?=
 =?us-ascii?Q?PpH5svPoShbopNgH8wDyuhD9barA9ZbZvrnJisnaBudosUz1oSBApGaeEJy9?=
 =?us-ascii?Q?4oYzll9McwCF1D984DY2tEHmVvYBzQy98BzL5R7FdMjIxq7szImgMUWOrwNv?=
 =?us-ascii?Q?xh5STZoPwSyoQOFN00XykSm7Tla+f+I5pKeHXfphMMhOTdV4WmbEXPEcfEMY?=
 =?us-ascii?Q?IP0z2xi8d5ViIjjvUOAK1D0C9i/j8KObF4hILpNZqYhp5/7X+6FZoym8Ge6A?=
 =?us-ascii?Q?Q4JILteq3un+xjyhWjDXiRk4W3iTldm2rzJdk94F8odyu4a5EYTSOL5dRnBg?=
 =?us-ascii?Q?FDvW314mVM5quGvMS8dJ3BH4xF/jt9mnkg5wSOK9kh5dcaD3tyzuWpdIJH8l?=
 =?us-ascii?Q?iyGS1qZQ81AytSN1jVmPx9r+Hibe80imuhkkYUU41Kx0xZIXIAX/kNQGDLLG?=
 =?us-ascii?Q?Q3cG+ncWmI13gIPzVF768ReZXqYiWoD/YApYrsLu88TjomwYv3HPbLje7RRY?=
 =?us-ascii?Q?SGy4HRtYJeuD2NUyxdlK9vrNltyTuQze438muGn4R9iTQljp+yzdCWmKrZC8?=
 =?us-ascii?Q?PpGCyq5wjzhgJi0zAco1m5RWE1B5Kvnf+hyItuHZ96pkrqyPiVD/E6I03kL5?=
 =?us-ascii?Q?v1HzoIcWUQJqnfRXaxB1CkoaQ4YurxjjgWs+fBYJCao4mFIQIDsvp2E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20e1063-2285-49d4-eca4-08db1e5f03b5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 16:22:43.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76tKrDMlIVp6E4l5TWsPJOCCIn5FYGt+uwoZsv44kg8RV05xRbFiW+AIB9y7hWkni0IQtuXyrXg37WKJVRnlKLT+TMu7DvYIE6iAj1DABCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_10,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060144
X-Proofpoint-GUID: hH7Yrzb8k6Y9HokLVbQm2WCLwI0MsFJ6
X-Proofpoint-ORIG-GUID: hH7Yrzb8k6Y9HokLVbQm2WCLwI0MsFJ6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support crash hotplug, a mechanism is needed to update the crash
elfcorehdr upon CPU or memory changes (eg. hot un/plug or off/
onlining). The crash elfcorehdr describes the CPUs and memory to
be written into the vmcore.

To track CPU changes, callbacks are registered with the cpuhp
mechanism via cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN). The
crash hotplug elfcorehdr update has no explicit ordering requirement
(relative to other cpuhp states), so meets the criteria for
utilizing CPUHP_BP_PREPARE_DYN. CPUHP_BP_PREPARE_DYN is a dynamic
state and avoids the need to introduce a new state for crash
hotplug. Also, this is the last state in the PREPARE group, just
prior to the STARTING group, which is very close to the CPU
starting up in a plug/online situation, or stopping in a unplug/
offline situation. This minimizes the window of time during an
actual plug/online or unplug/offline situation in which the
elfcorehdr would be inaccurate. Note that for a CPU being unplugged
or offlined, the CPU will still be present in the list of CPUs
generated by crash_prepare_elf64_headers(). However, there is no
need to explicitly omit the CPU, see the discussion in the patch
'crash: change crash_prepare_elf64_headers() to
for_each_possible_cpu()'.

To track memory changes, a notifier is registered to capture the
memblock MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The CPU callbacks and memory notifiers invoke crash_handle_hotplug_event()
which performs needed tasks and then dispatches the event to the
architecture specific arch_crash_handle_hotplug_event() to update the
elfcorehdr with the current state of CPUs and memory. During the
process, the kexec_lock is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/crash_core.h |   9 +++
 include/linux/kexec.h      |  11 +++
 kernel/crash_core.c        | 138 +++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c        |   5 ++
 4 files changed, 163 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..e14345cc7a22 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,13 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_NONE			0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_CPU		2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_REMOVE_MEMORY		4
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 582ea213467a..2dcc4d65f5a9 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -33,6 +33,7 @@ extern note_buf_t __percpu *crash_notes;
 #include <linux/compat.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/highmem.h>
 #include <asm/kexec.h>
 
 /* Verify architecture specific macros are defined */
@@ -368,6 +369,12 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	int hp_action;
+	int elfcorehdr_index;
+	bool elfcorehdr_updated;
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
@@ -497,6 +504,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 8a439b6d723b..dba4b75f7541 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -11,6 +11,8 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/kexec.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -18,6 +20,7 @@
 #include <crypto/sha1.h>
 
 #include "kallsyms_internal.h"
+#include "kexec_internal.h"
 
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
@@ -697,3 +700,138 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+/*
+ * To accurately reflect hot un/plug changes of cpu and memory resources
+ * (including onling and offlining of those resources), the elfcorehdr
+ * (which is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories.
+ *
+ * In order to make changes to elfcorehdr, two conditions are needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources; the elfcorehdr memory size
+ * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ */
+static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	/* Obtain lock while changing crash information */
+	if (kexec_trylock()) {
+
+		/* Check kdump is loaded */
+		if (kexec_crash_image) {
+			struct kimage *image = kexec_crash_image;
+
+			if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+				hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+				pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
+			else
+				pr_debug("hp_action %u\n", hp_action);
+
+			/*
+			 * When the struct kimage is allocated, the elfcorehdr_index
+			 * is set to -1. Find the segment containing the elfcorehdr,
+			 * if not already found. This works for both the kexec_load
+			 * and kexec_file_load paths.
+			 */
+			if (image->elfcorehdr_index < 0) {
+				unsigned long mem;
+				unsigned char *ptr;
+				unsigned int n;
+
+				for (n = 0; n < image->nr_segments; n++) {
+					mem = image->segment[n].mem;
+					ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+					if (ptr) {
+						/* The segment containing elfcorehdr */
+						if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
+							image->elfcorehdr_index = (int)n;
+						}
+						kunmap_local(ptr);
+					}
+				}
+			}
+
+			if (image->elfcorehdr_index < 0) {
+				pr_err("unable to locate elfcorehdr segment");
+				goto out;
+			}
+
+			/* Needed in order for the segments to be updated */
+			arch_kexec_unprotect_crashkres();
+
+			/* Differentiate between normal load and hotplug update */
+			image->hp_action = hp_action;
+
+			/* Now invoke arch-specific update handler */
+			arch_crash_handle_hotplug_event(image);
+
+			/* No longer handling a hotplug event */
+			image->hp_action = KEXEC_CRASH_HP_NONE;
+			image->elfcorehdr_updated = true;
+
+			/* Change back to read-only */
+			arch_kexec_protect_crashkres();
+		}
+
+out:
+		/* Release lock now that update complete */
+		kexec_unlock();
+	}
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+
+	case MEM_OFFLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
+			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
+	}
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 969e8f52f7da..f2f9d41ce5df 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -276,6 +276,11 @@ struct kimage *do_kimage_alloc_init(void)
 	/* Initialize the list of unusable pages */
 	INIT_LIST_HEAD(&image->unusable_pages);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+    image->elfcorehdr_index = -1;
+    image->elfcorehdr_updated = false;
+#endif
+
 	return image;
 }
 
-- 
2.31.1

