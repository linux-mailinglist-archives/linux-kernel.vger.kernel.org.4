Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3ACD6327C9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiKUPWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiKUPWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:22:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49203BD2;
        Mon, 21 Nov 2022 07:21:26 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALEgTUp030869;
        Mon, 21 Nov 2022 15:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=YKTZ3r1sfJellpfD45Lbbe6yp3B4k9IYqfFmpTRb7ZQ=;
 b=rCYHFrjdBIo1NhoZ9vme5Cp/KuS8TwII+6CJQ3j5xOeqE54QJ8TUea7sS0XHlNmaWIhD
 ZwBAsEExowt6RBX1ljL2xHM5cOZZXKOOBPioOXps5/kdbSOeNnC3YdS5Gkv4BBLJFWoM
 lw0uD/33LQX6nqjVLYIAlaAoaf4qSBlAL3mNJ1igffyuomlaPBLw95knrpuHjG0o6TjK
 Zsi3Fzb+kWp9FdiKZSFyJjsq4Pz/4gCK/oXfB4k0ui2aldYS1nQZrqxghJL0x9fANLwC
 +hfm+Z0PVYi9GFbCBS1nmBbGwmCj5yn+yQCE1poM8fAQiuSqvZXggLh5zWbDEol52GWa oA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxr99mxfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 15:21:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALDmEMf008232;
        Mon, 21 Nov 2022 15:21:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk3bkf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 15:21:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cz0W790xGMA5rr8ajzIHuf2cU3FHlayhk12K142zDpv4QjZWfivdbqaovZsX42lkpv0HmmiBX0sJ9WqA0BHOQgcd66LZD8vrQ8wy0nxgLXjswR0ziQ7DFrOC4ZqzDowQFi0KP53pTXp4fCh7fDpx8Gn4zAkNaT1dYl1ZWrkIsu6X19nxyKy/Ptz/HHEY2pIyyQOQJnSbCK113H6txvdxckAKb7fZBoMthXFou2JuBtwEBAuef9b/A3evFKsKPE951qD4vAgaF7U6WLlVCm+mJnK0tsGZGzrtSDwRKCTrGYB4wIGfXwYoh4k++eZsmlKHwsEJKRAspCMRLgN9RhUvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKTZ3r1sfJellpfD45Lbbe6yp3B4k9IYqfFmpTRb7ZQ=;
 b=nUPP55Ajfd1C4fbFg+dUSP7fBDfpoqtEyXS6ylrkMe4XIUP5w0QWY/FPNhiU7vFwCzsQk63TxyAvNoCiDh7oQCsZFnf9F3WuSqSBw+NP0ENlGEzDjUftzSijYcqevtIXoRJiz7B83de99al0I8DCGE8BvM8yjOGryyWC4fVGLib9Rdntp9u6fLnw/L/pVvneWokPEsrsjNmg+4zIxxRlLeApiZ37xNJ/zeE8Jumlrcr4zXezPs5x/5AnNQSGTa5tgmHHbvJJh6Jed9Ej4utifJtVRG1PH1Xii417QOiQqqQmuUqPphMEqP3zcG72YsDOiXCGBUfPtIZhhTLbKM8SJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKTZ3r1sfJellpfD45Lbbe6yp3B4k9IYqfFmpTRb7ZQ=;
 b=PyGEt/Ui/NbX4zrSmAK9htxQSRw9Wko0YdzRPtIrYxxN+YAQtaO8Ieg/ks1+hwC0R1tOHwLq72DAtiRZDy4IgY/T1w9u6BN/wwJNx0TPbWcem0RLMUhqogT93nkiyMqzmHrC5MtoHtBs49sNSwfV0tZcMdSbf1fFFvcmxmtAKic=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BN0PR10MB5126.namprd10.prod.outlook.com (2603:10b6:408:129::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 15:21:15 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6696:2164:2057:4b25]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6696:2164:2057:4b25%3]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 15:21:15 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v9 2/8] kbuild: add modules_thick.builtin
References: <20221109134132.9052-1-nick.alcock@oracle.com>
        <20221109134132.9052-3-nick.alcock@oracle.com>
        <Y2x22mKtaZvC7ZSk@bombadil.infradead.org>
        <87h6z5wqlk.fsf@esperi.org.uk>
        <Y25mXAGty35I5lQx@bombadil.infradead.org>
        <87iljhv321.fsf@esperi.org.uk>
        <Y3QC0OIbZgSmvAxT@bombadil.infradead.org>
Emacs:  freely redistributable; void where prohibited by law.
Date:   Mon, 21 Nov 2022 15:21:10 +0000
In-Reply-To: <Y3QC0OIbZgSmvAxT@bombadil.infradead.org> (Luis Chamberlain's
        message of "Tue, 15 Nov 2022 13:21:20 -0800")
Message-ID: <87sfics595.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::23) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BN0PR10MB5126:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca6591e-a060-49fc-fc97-08dacbd4080f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6fKymWHTjzSyTxIf1jv1ktmUruczS+YTrktQgXbQyFWV7xB2kd2CeuHhTGJQGoQhvF/JEXjvL3T7vk5Q5FBFgSkFeADUVtEK8XIipG7gdyHnLswBD6q6g7LdRFM4qTthOoEKE6kFXbAUCuIUwNUpOJ+4xCsLihNBd88x8gY6glG1kMBmQPmrAlNp0nGmHLvmwnuQQdGH4QBBB8WAJ9UAVp0aqdgwdaj+izMWVPds2Vhg/3jWvANIGkUIonwlIkWhGTS8WTs98mFuw72R1RRUC8ehr0UJmqsmq1EjS5JvoQtZMBqtOmmCZldE8ZuXergWJEtVjGSG1cYShDZl/2zWDH5xjuK9SoVuprRJczzMMauTeCGA4TlS9ue2YWtScBBdwilAkVsDui6Bcisg2xfCeUBCOZagt8C5AtPXVDYW25LT0hRVNaoCAQ36ZjKJmd53wXWGX0oEJVVAWisNCEjwv4cE5nxoiIMqonL8lK5jmg1Gp47POdFePhn4s5Eijmfldkjjf9Y0bR4QH+9pcs1e7Kj6RaQmf7yPRF7ZPIxlgwqLUq/Gf6EupzufcP5r93BJqqY5tG9+1+duSBWtcY6bACTBwL7hE6CoKBV+dgnaVJ9wDoV2zpgbV37w1IDaCQMf3t5LtsPSeRUxZvbF5HrVJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199015)(6512007)(9686003)(186003)(83380400001)(38100700002)(44832011)(2906002)(5660300002)(6506007)(6486002)(54906003)(6916009)(66556008)(478600001)(4326008)(6666004)(8676002)(66476007)(8936002)(41300700001)(316002)(66946007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?olKNZPIGJydXFTZgRbwvMKTa5QjZT9Wo6/W09xA8l07FwRCTiJxUKeBi6c9S?=
 =?us-ascii?Q?NN9PapwX/6QS9f5OqMSlSWkjOn+EN+vQLoJl3Lc/TDRemXeykSsJtU+uU8rO?=
 =?us-ascii?Q?KvozM8qvUS8HIAowncEqdQk8XsUQfOUdK9Omjj88XIaw5C7jgOwbXmSckfhG?=
 =?us-ascii?Q?Fib7X2Qm1o7LeDUQojzadnaAl47W11TYyF4FaytxsHwBcE59/k/1YcVAuD5L?=
 =?us-ascii?Q?TWV3Piwxe1z/nPwJUwvBTxSuQ0xWKuJTTdWKKE3O7LhpQl6QWiGDpNOTXkWb?=
 =?us-ascii?Q?wYxjztVL0puJ7UFlOWLWsYGSZA07ftEO0D+67SvvyGZvzMwpV5pLWLfjars1?=
 =?us-ascii?Q?hsjHDfpqj70BMtGbt7mNtvwcj90KiSyZ0uzJ2cwL9VmQt6Ek18r3FygoNsMY?=
 =?us-ascii?Q?qAI85AaCHTiRWVeJd2/VU+ISZ5s0qQcUXd0zQMsG8jyzNXf63Myd8BoPEzFj?=
 =?us-ascii?Q?SMLAOeafEJFaAAaxcHiD8r+QIzuQgHxogahfg0YT9GLmLNCNJ/6J8O9BqM0e?=
 =?us-ascii?Q?oNubyXjI2AyQJZJy4rmyq8J1DvAxA4ktCJ1bIaKwVZeeqwBICldP1CP04+OF?=
 =?us-ascii?Q?FD2bP/NmO5oWtMoF60G+FlXv1/7v4CGn6MSWT0BddKldNq8h1k9MwQ3rQ2XC?=
 =?us-ascii?Q?Rgl/pPZd9QIhcxZV2cYxeqR9u343rO2JN/XCUKCKcs3/aXkwvHi5A3e+JDDm?=
 =?us-ascii?Q?kKBR9ymr1ATfTWk+mRCleOmIhfFwBdaNz2JCQzCoK30PxdZf48CVFPUQzyQm?=
 =?us-ascii?Q?vJ45/ARICcW55n10IoNDjKgZ47bsqv3VJOUiYfphXl1EPT75fEEj8kxgFcjt?=
 =?us-ascii?Q?O17+tqbcxTTjviMsQV+9CU4jHQncmogBCdqrSxDb6e2UercJJBtO3Pa8TFtu?=
 =?us-ascii?Q?swXA3AUaT1962WmnODnZ0clOtQCl73fp8WWAd9RnWOpXwJhbWKONIG5stBqw?=
 =?us-ascii?Q?8m3hNjikYMD0+wUrScwxMY5z+AFXfsA+ddE91mijVIYCxDutJp5KwWQ6NpiY?=
 =?us-ascii?Q?3AvQGQ7+z5/WFfItfBLtwd6qWwBhpEi2xr+tJ22vwQFpHk2OFF0aPxyo+H4j?=
 =?us-ascii?Q?g/0ENh36DAoN3jS4YMMsCgzHeik2W5n/TcHUMBKEzSERrRSwQVEguwKUiq4B?=
 =?us-ascii?Q?XNT3scBv9L+lD5Ao/4AqUXmJ1/sw5MBta4iPcH2zW6PkcCixcCT5/7+lBuLf?=
 =?us-ascii?Q?n5p6o2IAZgqvU1/1f4efWGJ1pGGxgX3wp+2vmqMGAXwQXxF3NRC5EJBWP51y?=
 =?us-ascii?Q?ksw3QHJ/MGHYSqT9BRBxonVpzQFJSfWMqr1U31lQejQee3g/ud5ljH54mz1/?=
 =?us-ascii?Q?qjVpWw8K8fqmuteH/pcfxgCdNOJC0ng1jjNMOcVz3+VjzO6CuzWxdHBQBQwy?=
 =?us-ascii?Q?dvKXbR4o6/7mxMaGcYBK+9mV3e6hOR388m7fWr9K0PvTTsgOhtRm44EAB0r+?=
 =?us-ascii?Q?dfsPZtoM6AnSDWvaYWqUFbEEjE/YGt0X7tD4TRGYQCToDj27uL63O6RHY/wO?=
 =?us-ascii?Q?mh7ekhuvFL0EfWmzjFSeulCxwinyVisgeXmgg8YJOv+i48PUlWC8ooT+sYtc?=
 =?us-ascii?Q?bgcuyZFqrlr63OfNgms0HNoodYMuiK4rIwIt3T2s+d0MkPIPZKmotw7dUMWd?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1jonGo/UcYmQvaI93ePr+93p95Iw4F4shTu0cJSC8SWO+wkRsV9lEOdDK8oX?=
 =?us-ascii?Q?IWz2u/i5RY5gLXSas0X8jlyYS/4apMwTrxegH/6J0DeFrYcCU4vygSW8rd00?=
 =?us-ascii?Q?YB8utVCyJKvVcNjZtnafOlbNXu+RETWaVJmSAzewRnYgAtvK609p+ujT3IeR?=
 =?us-ascii?Q?Y+cpqG2chFmBtTsG4N2K4Bi/8zRk11TV4SpJwAYrb8606vWHu5yw23jfy61e?=
 =?us-ascii?Q?tXJi6Xi2Gg66N7OYOCEgz05xrgjADKobbkytOhwxr9P9dHNmbmtRhioZrJSK?=
 =?us-ascii?Q?dEJDbhSkeYXZLLS4ceHPz4HU/hpHwhTvSvBfKcaEcQRYgsFTs5uPVMMs1/bO?=
 =?us-ascii?Q?qIC8z6qgGIgpFJ1Qjrhqr/6dGBenlCoaAScWZiSpxopPvmxuLwD4nOUREPi3?=
 =?us-ascii?Q?jIzmUUgmofg+nVje6278oq3hSkGNbx1ayOv8xlpqGcXbmfabLur7FCnERNWH?=
 =?us-ascii?Q?qWthNHyDk5ef5HM03ES6Xe0Cr7/jQGYgN8pYJ1X46MB/0HUz6sgaeM/ThDz9?=
 =?us-ascii?Q?smsJRSdq9cjOZVy+kZzwZ79WnjnswXHTRl+/6x4iJVxiH6NEjhd44U0QK42j?=
 =?us-ascii?Q?Lfrv9jEidMy/fGRlCjiwuXH+TTTsQYkTmqOkUsybG8OHQoLo9aSH4c9/znJH?=
 =?us-ascii?Q?+qPthpsai0+S8oK0fcjp/n0FUayzm9SGMjG8+oNZFbhI2V8cGuPFvw9xXx+/?=
 =?us-ascii?Q?bPscAxItWTEsozDe80kjsr2/ZJbyFntyCWcJVpboFaKhJuRDuWzLBn2h/F2r?=
 =?us-ascii?Q?cmCLvUx7voVCt67kb03XToyg5lTIZZYNla8NXJnirbeC0XtzkGwbGyPxldwn?=
 =?us-ascii?Q?X7roJu5kVqqDHKz51rsZBwHcKGaZPmFo9INwxK+3RhK25wNo3qpong8zEriG?=
 =?us-ascii?Q?HQsuqiKCiU/8gl/qDUYSARdyKBn0Ol37uv5Hx21GGPxJ5ydFVbUM2Nwze0d3?=
 =?us-ascii?Q?MHSfPJGwApYfwPlmsg0oQdyuI5yV1CXBOw8+8TnK/rk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca6591e-a060-49fc-fc97-08dacbd4080f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 15:21:15.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CEpsQo5/fAd/5014L1tNdy+jgXPTp0wvLy13jf2+BR3UrXYHk3hzP1ZJeVoywmEYwEXw4IfUYXqVCFWHBYUJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210119
X-Proofpoint-GUID: xtWY-PvJUoF3_DaYvnEn3KdEApsU7fqh
X-Proofpoint-ORIG-GUID: xtWY-PvJUoF3_DaYvnEn3KdEApsU7fqh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 2022, Luis Chamberlain uttered the following:

> On Mon, Nov 14, 2022 at 05:49:58PM +0000, Nick Alcock wrote:
>> On 11 Nov 2022, Luis Chamberlain outgrape:
>> 
>> > On Fri, Nov 11, 2022 at 01:47:03PM +0000, Nick Alcock wrote:
>> >> +arch/x86/crypto/libblake2s-x86_64.o: arch/x86/crypto/blake2s-core.o arch/x86/crypto/blake2s-glue.o
>> >> 
>> >> But...
>> >> 
>> >> obj-$(CONFIG_CRYPTO_BLAKE2S_X86) += libblake2s-x86_64.o
>> >> libblake2s-x86_64-y := blake2s-core.o blake2s-glue.o
>> >> 
>> >> config CRYPTO_BLAKE2S_X86
>> >>         bool "Hash functions: BLAKE2s (SSSE3/AVX-512)"
>> >> 
>> >> This cannot be built as a module.
>> >
>> > mcgrof@fulton ~/linux (git::modules-next)$ git grep MODULE_LICENSE arch/x86/crypto/blake2s-*
>> > arch/x86/crypto/blake2s-glue.c:MODULE_LICENSE("GPL v2");
>> >
>> > Try removing that.
>> 
>> OK, that works!
>> 
>> So if we're using the presence of MODULE_LICENSE to indicate that
>> something is potentially modular, I guess this means I need to do a
>> sweep through the kernel and find everywhere that cites a MODULE_LICENSE
>> and cannot be built as a module before this will say things are modules
>> that really are.
>
> Yes, make allyesconfig builds + a verifier for tristate would be nice.
> scripts/kconfig/streamline_config.pl has an iterator over kconfig files
> and also objects which you might find useful.
>
> At build time such a thing could nag about issues like the above.

OK, I've got enough of this working now that weird edge cases are
popping out and it's starting to become fun rather than frustrating!

Some of them are bugs in the tristate-checker side of things, e.g. in
net/bridge/Makefile we see

bridge-$(subst m,y,$(CONFIG_BRIDGE_NETFILTER)) += br_nf_core.o

and my code is tripping over because while it runs
CONFIG_BRIDGE_NETFILTER comes from tristate.conf and has an uppercase
value. This sort of thing is rare (a dozen cases at most across the
tree) and easily fixable in the individual makefiles as part of the
tristate checker commit, so I'll just do that.

But some are I think obscure bugs in the new machinery. e.g. in
security/keys/encrypted-keys/Makefile we have this wonderfully crazy
thing:

masterkey-$(CONFIG_TRUSTED_KEYS)-$(CONFIG_ENCRYPTED_KEYS) := masterkey_trusted.o

This produces things that look like masterkey-y-y, which does not match
$(modname)-y. I'll come up with a more complete list shortly (a make
allyesconfig is spinning now). We can probably hack around these by also
expanding $(modname)-y-y etc, for as many steps out as it seems people
are actually doing in the tree right now. I can submit a patch that does
that if you like. (If there's a less gross and fragile approach, I'd be
happy to do that instead.)


One question: do you think it's worthwhile me submitting patches to
de-MODULE_* things that need it? It looks like I need to tear all the
MODULE_ lines out before the .modinfo section goes away and this gives
accurate results. This isn't actually deleting copyright lines, but it's
making me a bit worried anyway: it feels morally equivalent somehow.

Is it actually considered OK to just delete MODULE_LICENSE,
MODULE_AUTHOR etc for non-modules when they were written by someone
else? (Commenting them out, leaving them as documentation, is presumably
less likely to anger people but might be considered ugly.)
