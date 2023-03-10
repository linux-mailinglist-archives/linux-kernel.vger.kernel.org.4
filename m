Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2206B53CA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjCJWFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjCJWFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:05:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976DC106A1F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:04:01 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ALhqoj029136;
        Fri, 10 Mar 2023 22:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=3m8FWwybgWEViMTVNeZsK1ZRJSlE4UNrL6uWmcMtmcE=;
 b=K0ju5MiQ+h4jcL8sr4VKilT/yC7P4hcXqjakbwHlVYE++lXNHy09+L2NF0Tz4OEm1veR
 ty0Azo0G7Oe16aWxIqBSCkSM957zYSkb143J2lv1IZMAFtQE8CyIVuM/SDar7ZVCtfh0
 IOGLTiOadrfnUdTeq6f+QOEQP+v6XYxoSwpFe7Bf9fThJGnT+Ek2dv6UlG+YNcAfA2Cf
 Khd2vtNv2Ixa9HjbAyDtl4qIYjFF7ZIb4WNNwWlr3nPGvxfYYyCXlrXpOxbsA+vEc/+y
 FWsa2tbKpyOPhrKZCkZsZXPyT2drY2Tgsgs2XP2TV2RapyHY2aMbcYOHOvqHtJysNRq5 Kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415j6df3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 22:03:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32ALm9c8035033;
        Fri, 10 Mar 2023 22:03:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fubfdqs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 22:03:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S//5by31FZ4rZGWdXfs6j/leBUa7d1auEyYKA/obighP4TrZVthreVRYq+1s1l7LlMhtVirFCWoJ3ukicBFAV4W6qJ5zx9wGTouco+8ElLHgC1aGYT7258HGmnRkuOkITDWYPPmN3sa0aYALC1V3dmpSg7cIRpRGbgzrX8uFKQWukSYmxnBri6POqi2KcoKkWPz5cwrNNQUOCxvyQdFvdVaMd3SSePL+akiQK3driL7yDJnqIl5+QgrXLaeU9+VULnnkv8vuY6Fj9i9dNfcw5vHwmC/J9ZOWTBqaBQOImobAUVMFbFMlTYuU0y36dqoPhZE6beP5dXfR6E0oJLE6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3m8FWwybgWEViMTVNeZsK1ZRJSlE4UNrL6uWmcMtmcE=;
 b=gBUaiFx8i0vhegsvkOaRbWeNFKe2eFmnwA21H80CEpNCPu6XOsLGWQ0Ek/KQaz5hpKa0lLgI0Tnh7K9vpMuwLF0I1asBZG0H4Z7L+1VIZXhYoFdmdPVr2EfZi3locxwsvCWZ/30lDPTMI4NqQbjNtNg12i27V9yrguIyKLnua7l+rSJRjO+lgQPG+ER9mVLO3lR6lnd9whMHzd7RktgGX99XbzI2qi3YtPDX+6g7PNGsWc6aTSV4m7BuwVfItXX1op5ZnAVUnyAGo8TSxLAljVCGtcCfQ8nv8jqkGDdO8PB1BofliGPGl7YXhp8eq8FBQPhrtXuRxt02GIKjxI6S9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3m8FWwybgWEViMTVNeZsK1ZRJSlE4UNrL6uWmcMtmcE=;
 b=FXEJpFCnLwlX3zQ13LL2h0JORVu5eBG8/KsvjXYGSmxGeaBfYYUlhJvqdbw3pgQX0ENu7PpOMUockrKRt1BTSndY8bbjBOnIvZGBEzwAhzUQj0XEbjzKtjxC/B1RzpXfd0bUQTv57txVxVdSmxoV7J9oY3qn/svNGiDXcvX6sHQ=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CY8PR10MB6514.namprd10.prod.outlook.com (2603:10b6:930:5e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Fri, 10 Mar 2023 22:03:44 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 22:03:43 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 05/11] fork/vm: Move common PF_IO_WORKER behavior to new flag
Date:   Fri, 10 Mar 2023 16:03:26 -0600
Message-Id: <20230310220332.5309-6-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310220332.5309-1-michael.christie@oracle.com>
References: <20230310220332.5309-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:8:57::17) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CY8PR10MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 37dd8d1d-acb5-4aec-487c-08db21b35024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qa5G/AEqBIPOWSF0/eVBP5+ipV+TSk8n7cEkzQ3h5k8vWBtJ/CeZXGfBITj5UZoXY4vIH0eEI6Qk3LhuxnEQCrvYouNq+dN6wAMFplGu0ZOHFEUASUxuNwiA2uCIyOeN5G29A7RJI5yQ8CdIGmVPO47HkItUu4ml8klu9k0jBJFVfjQtxDcnVErkRF5Cpkl5gxAGaL3SdG7nll3A15th2KoZ2oR0KJ/CCADJd0GW2c1sYLVWE+ANsioVYMtA6UDW9EL8+HICkdeE5CCLZQkpVlbSfv6u8GbgFGba3DfKXKDaLtrRlTWEZYhRookINwAo3c/R29W6QBlI+4MAkl3420n/Gp7jmBm9rU7ow9B2eQ2X7XPpOoCSo5X62DrkTusEFv8HMY6ckuQeiWD0jlG9Ags+OCtjl7vYHdtZgKUb61x1TYBli+vo0cQtQM+avgfFiij6YPrYVo9MFnYlX+0xRb2/U4UmIp6KfPfUEB79C/u7nb6RIyK/Xf6q9YkQCVP5eYaBn0kJ2UxTjtVG4tKTLiv5FW5i2so8cfCExYxA7wPRqsC//SHLTHqAIhYW7ulQ53rmek/FEuzIMe569O1X6Nt47Ro3OFF1mYUuBU1nMWPQF7ELU0xVPkG3HCT7LkAfY27Hz+HQcERehhmK2lfCH3KDcD0dyMKxwMZhAFMopOjKjf/P/9p0VRJyRh3I2ukJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199018)(36756003)(6486002)(186003)(6512007)(66556008)(6666004)(2616005)(107886003)(1076003)(7416002)(83380400001)(26005)(8676002)(66946007)(4326008)(41300700001)(5660300002)(2906002)(66476007)(8936002)(478600001)(6506007)(86362001)(316002)(38100700002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?plYnWi5S/0bhldyuo51xnXyGBrORCNZXLFbMtbIq6NyEEgiJBzOZw0FHT0Q+?=
 =?us-ascii?Q?1OtgbE6fkRLIHYI9APLR0NaQ6Jo4HLzLedQyk4y+4a0cet7nGaWt1jCeFAWx?=
 =?us-ascii?Q?EN22AN+pxvI5UY+TeXTYfADVTzCSAGxQglerIe/n2IRTPNdfW2HROYYqGDPN?=
 =?us-ascii?Q?FywQIHsVcW+W785vsPy5ypSSTZzDN6E5Ragq11GBbNIFywv/xo5Y+ui5rH1/?=
 =?us-ascii?Q?HW250+VOuLNsv4/V+ZeVN/wLoZq14Z7sLHuwQbZliHcrMgm0CpjNZQ6SRYHd?=
 =?us-ascii?Q?LltSF0MpNV0vLMIcmWJBCAFbtdZF6J1WIvcMQl36+oYSj8NhHCgSKztv1l94?=
 =?us-ascii?Q?zrnC68hE0LYFMQ7LGv8GqVU2FUPjs7Gp227Z5TN5C8E8aeMkuVe8s8uJAId4?=
 =?us-ascii?Q?Nmcu92khF6S9DmUGR7u2h2C8FTg2+YypQPHhcSYtSxmfpH7rF6wI1D+f+H9/?=
 =?us-ascii?Q?Y3izo0/CCS821ROF7G74aHeoVkcwRltoiLGMZOkToLQ9lqcae/pO3gwAc3UH?=
 =?us-ascii?Q?3yC7ItDCht3A1WiIdkWCpObEXVl/dSKaCo2EtAHwv78HnFeWzEui6JA+2AMm?=
 =?us-ascii?Q?KElORpbPyyMgVMWI3SQ90EHSag+UxtJGIWo9JyRC+u/OznMxoamuDtf3yCLj?=
 =?us-ascii?Q?rChtdyr8jVvjk/4P8uICGABSOss8OgeWLXbyYTPmJtXkWBQWtVsO/sJAK7Cp?=
 =?us-ascii?Q?hIOmHgVBebHirj3d1eMVH3AShacVfYzg4+rCd4ZZbH5OYdXFg7e7W1RDizNj?=
 =?us-ascii?Q?hUgK06Vt9eC52A8sN2ENCkIG8QxiNH14WaSwh8zeztdiH7YxEmPKGAPBAjWH?=
 =?us-ascii?Q?3mK72kmGz0xuKm+3yy7xRDj3RNLIvQWunEZmkHuPbb2Ujo4BDAVZ5O8/34G6?=
 =?us-ascii?Q?gbscZenO/7GzQtmWTDADcJtxEs1Y2OT4Yo7vl0Xqta65MG30mcTPDY5UCUke?=
 =?us-ascii?Q?35g4hK2zwiCvRPDVkT6zvJTLRBN0HH9/Zt03uJx2iCIzed04e4FJO63hvG5n?=
 =?us-ascii?Q?rTXVdGa+mbCDjEEfBaaeMbBkcxCT3rn8EgAQoJFO5hp4mLzfNPi2EmJzP769?=
 =?us-ascii?Q?xP9WP+NYVPK/glU+rqSLwS6CLjxtyHKWA4FAcKer2aiZaTIuveMcKFZMfMBW?=
 =?us-ascii?Q?I3KR7YXqWO0OCKzPgMIBkIsv9ONM3ZmONZABX7AUf+rxJ4FzuKlVW2y+gQ2a?=
 =?us-ascii?Q?MHuKaJLAulhwwPtNWF6mKbwAUJDcZGHgcuwQ+orz2sJ3Bk1IldfBi316M6Rm?=
 =?us-ascii?Q?2UduKM+N7H5F8A7KIL+V8sYg3d4URcJYxVojH9sGhtTbP967UfVnn3zxLV6k?=
 =?us-ascii?Q?r6uF4RTHSf0Y7ehrTv/eqIgD8SMaYaCL1L/DIDW3FD5/x7KSezEp/TTaB33s?=
 =?us-ascii?Q?lm+2aJmuF/BH4tGWa3oq8rYnzugCffs20OnrHhIUlSpw1CptazaLcL3Yy9tW?=
 =?us-ascii?Q?QIvHUGTNW02VIBeJjSfq6K4yEM4PqRXSUWx8FsqEmEg4wyVxdmxN/CV3am1d?=
 =?us-ascii?Q?WJT6QXw18UkpX28wFSaggHQ0NWCerMNS5MV0h+3WooaWC6uTOKmaTGNHQC1z?=
 =?us-ascii?Q?fxVasZD6zTM0cw9//6qTiiHHG4RC09pRB0qfa5vqUTbmoK5iX/uNegRDCrFj?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?zXXTJAHQYJN1Suy++dGMQR2VQP6TusHeEgMoro7FABPGL7S6xfJGvTyaCBE8?=
 =?us-ascii?Q?irmxMCjrvyKdLI+fH1+wE2+vP0azY65NrogUTJus9F2/estT2cNrsQn7wGLI?=
 =?us-ascii?Q?TyHfX6fUclyn/VSCYbF/w/HjutC704RXFFoeEYj8OA6dC8ht8np1/FGOG26d?=
 =?us-ascii?Q?G2g2M9rYdXN/Uipwdpx01wV9ELGHO7xcYt086TXt3mKCWtToI26Dx08P3g8L?=
 =?us-ascii?Q?hsD5tLQJpDuWBiMzKldOQkfM1AFDhcdVDLH/0w2JoJN1DbFiyOjb3If+vNOY?=
 =?us-ascii?Q?7nLRYcSLQVpX/GwqKyUfaLqmvEMfRSf6IiP0EKNW2xX4SZTM+yNSuDVoXGx8?=
 =?us-ascii?Q?aqM2QhMnDnnKS2ka9PwsTfEUaCSbInGKT6fyW8gqDHBqrOOBMGCMESiP1cuy?=
 =?us-ascii?Q?BF77PReoUePoTdWBFwftxccfpWSBjK0ok49Xm5gTJlh0cbuQZnv8W2WFxEl0?=
 =?us-ascii?Q?c6IGd+EmenHi8HIJNiq1Evt0QW6GtFo1mghsb2FMfcKsKiYUyWrqRZ8PVcy4?=
 =?us-ascii?Q?WHEXZyLppn8m8N14M0jKf1Hkpjxqeh1bQHWntmIU3rrWWjs7sJTNL2VO4W3Z?=
 =?us-ascii?Q?V552COc3GI11SQDPJf/oHs4faTiT12Z+H4DDZC9zqndCoHomRvy3lwZb+8PH?=
 =?us-ascii?Q?lNrpnz8MBq7pnqMDJlpz2LfjpP701Hea5Uc8exRi0OYRnBuhYLn1LU3XMbY8?=
 =?us-ascii?Q?gclqFkYl8RkyrRRNY8HH/SjJYDEMN4FQn4rxi2SoC3IbzFf4Ewg1vN5MnCj0?=
 =?us-ascii?Q?jkAF5HdMu77bHugR7aLPBPYXLKFO+l43CbnLlgXxmId72Oqpcxtwshn/tDgj?=
 =?us-ascii?Q?ylJ+h8cwANdkiplpwz+aUXO85gymEKdeewXURttKQ2oSxKpA6ZfEh323kt/A?=
 =?us-ascii?Q?Wlv/K2QuwpryOLHt8ihNG4btzGY+9jeJ3lnQowzXhjaSvYwNmyQPSllpIMQi?=
 =?us-ascii?Q?qMrzgMakMJSw71WMfvNVhcDYkHrbd/t0ybbHSAtm+ylCLk2wDsQXgS24doyW?=
 =?us-ascii?Q?t8XZzQFMSNtAKZ5FdaWfUcUEfw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dd8d1d-acb5-4aec-487c-08db21b35024
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 22:03:43.1881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ownaPa07fGzhBSPeOCR/8rGzS0p1R/fIECbguWTIRoZPM93lHvickUDZpY8G7o2HyGMC/nrmBzJQbiilJGlhIW09WQNO4u31JskvKHnNuhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100176
X-Proofpoint-GUID: -m8s1-iiWfoHuUKKL3ibB7FqOMVbnxur
X-Proofpoint-ORIG-GUID: -m8s1-iiWfoHuUKKL3ibB7FqOMVbnxur
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new flag, PF_USER_WORKER, that's used for behavior common to
to both PF_IO_WORKER and users like vhost which will use a new helper
instead of create_io_thread because they require different behavior for
operations like signal handling.

The common behavior PF_USER_WORKER covers is the vm reclaim handling.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/sched.h      | 2 +-
 include/linux/sched/task.h | 1 +
 kernel/fork.c              | 3 +++
 mm/vmscan.c                | 4 ++--
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 853d08f7562b..2ca9269332c1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1723,7 +1723,7 @@ extern struct pid *cad_pid;
 #define PF_MEMALLOC		0x00000800	/* Allocating memory */
 #define PF_NPROC_EXCEEDED	0x00001000	/* set_user() noticed that RLIMIT_NPROC was exceeded */
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
-#define PF__HOLE__00004000	0x00004000
+#define PF_USER_WORKER		0x00004000	/* Kernel thread cloned from userspace thread */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
 #define PF__HOLE__00010000	0x00010000
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 268c77a42155..2950e83d5382 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -27,6 +27,7 @@ struct kernel_clone_args {
 	int exit_signal;
 	u32 kthread:1;
 	u32 io_thread:1;
+	u32 user_worker:1;
 	unsigned long stack;
 	unsigned long stack_size;
 	unsigned long tls;
diff --git a/kernel/fork.c b/kernel/fork.c
index cb8f85c88c75..0dec38276363 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2100,6 +2100,8 @@ static __latent_entropy struct task_struct *copy_process(
 	p->flags &= ~PF_KTHREAD;
 	if (args->kthread)
 		p->flags |= PF_KTHREAD;
+	if (args->user_worker)
+		p->flags |= PF_USER_WORKER;
 	if (args->io_thread) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
@@ -2627,6 +2629,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.fn		= fn,
 		.fn_arg		= arg,
 		.io_thread	= 1,
+		.user_worker	= 1,
 	};
 
 	return copy_process(NULL, 0, node, &args);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bf3eedf0209c..86c27b08041e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1141,12 +1141,12 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 	DEFINE_WAIT(wait);
 
 	/*
-	 * Do not throttle IO workers, kthreads other than kswapd or
+	 * Do not throttle user workers, kthreads other than kswapd or
 	 * workqueues. They may be required for reclaim to make
 	 * forward progress (e.g. journalling workqueues or kthreads).
 	 */
 	if (!current_is_kswapd() &&
-	    current->flags & (PF_IO_WORKER|PF_KTHREAD)) {
+	    current->flags & (PF_USER_WORKER|PF_KTHREAD)) {
 		cond_resched();
 		return;
 	}
-- 
2.25.1

