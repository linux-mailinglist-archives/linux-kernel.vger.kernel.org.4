Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6B9741E39
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjF2CXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjF2CXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:23:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26A52682;
        Wed, 28 Jun 2023 19:23:28 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T1rpsU012273;
        Thu, 29 Jun 2023 02:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ZAGaO+LoR/T+C8tHcgIyK8I24R/kttmGqipct6w5uF8=;
 b=Fti9c5ev9T1WCsR1HkFPz9d53kRW9O9zva/iyskaLUPsb5zfQ94hXrkDax/S8tm2W2RP
 wUopn0Et61qWNLaCQxAm+AW2OYC2nB58PQqEPtPUktbh/JNVQHrb66zvRASFrd4w9cQJ
 wUU7QaiCgh7Ou/LqnFPQJJGgtiLuyiA8lFVMY3JtleCl1OuZWBimR8xJf/DsTzZHmtI7
 OWG5JFZWx0DWUzVF0p0j3KF8AN1LeDmIX/8s7zW85MuFBBlqim4MZlUfeyjZcPby1kEj
 p/Fpf9T5SPPEzf6HC48w/A4FeZ+q7ZvdZdxA9oetT60xmZjNeoAUdQ+edUqjW/O0tSt3 YQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrhct6vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:23:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35T1R4nj008634;
        Thu, 29 Jun 2023 02:23:13 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx6u3w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:23:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLXaXCUGhzTbbm+sazEAFvdsEyLzxQSUQ3MaSjyp9DyZe/Fvdw+CgJgE3QTNvjg59StRPRSOQ3bU07HTJ6vtFPg6lPVExSDVQu1DBIsSB36TYOdpWx7YGvK78ycpxhSSql8vGU+8aR3NjCXEJ2hQVhb64iHkqWKxDs7OdKj0bz6Q8acUDHxRrja1kMYIzoF1X5tEwcoRIYEKGUb3hEW/TPEd4BzlIOT7ChQC3VkSInlHvdZdFMzBbPiap+7W//kgK+gIUrAoK+9qZrnJ977OQXSPRjZnbXB5Q9YQTuaus0OX4zw+9TtQdYwULOHXJK7sgjkdb7NPkDdNfxPjkslILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAGaO+LoR/T+C8tHcgIyK8I24R/kttmGqipct6w5uF8=;
 b=Ul7H60cnBNtVC1mhQJ1iyTGDVAKaWh2y5y7l14hyMM1yb3jE2Ppi1XnuQStNDioLJHVzsxt3J7UEodsodf2ecMfi7O49R8TG8KEuN9OUqzxbGa7EO7kdI4IfzHTKq5x3IFdo40wEn/hc92Oz/CDhw18ew0JFozQvTYGZA8r7WFfxKaljKKHVauV3J47zSm9K79TXJsLvP91ROwP2cz88bVhsFPcZhVi9qJgnUiUu0hfVBYQ+7fk8hEGC/38wSkKr9tJHPV7+dxpFP5b/MFlZYo44cP9MgxRWjgyDdBDUCj62ylYazIU80i3Fs3mxpszEkZ8IX8qC9EWX2yoO6kIl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAGaO+LoR/T+C8tHcgIyK8I24R/kttmGqipct6w5uF8=;
 b=x1jZEmwvsN6dVBZGEkFrPoNr8RbrX5xaRsT+QIJds+oLBf2NF8C6COBSGVn8YoUTerCNu/WV1ncTlX3LOPU+vEKCfgpAUM8+8STBiSc88P5fpwp749QUlCPOSzQBgwrUto7lDg8mQxUJ5+tPdR96V4jHeDZZbZey73arFol+FpY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BY5PR10MB4354.namprd10.prod.outlook.com (2603:10b6:a03:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 02:23:01 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 02:23:00 +0000
To:     Keoseong Park <keosung.park@samsung.com>
Cc:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "Arthur.Simchaev@wdc.com" <Arthur.Simchaev@wdc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ufs: Remove unused function declaration
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6qrnh1l.fsf@ca-mkp.ca.oracle.com>
References: <CGME20230627012931epcms2p76f458e0b2ce8a591b56bbcc6a2f1a3bb@epcms2p7>
        <20230627012931epcms2p76f458e0b2ce8a591b56bbcc6a2f1a3bb@epcms2p7>
Date:   Wed, 28 Jun 2023 22:22:54 -0400
In-Reply-To: <20230627012931epcms2p76f458e0b2ce8a591b56bbcc6a2f1a3bb@epcms2p7>
        (Keoseong Park's message of "Tue, 27 Jun 2023 10:29:31 +0900")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0692.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BY5PR10MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: d860f1ce-2f39-4387-0d3a-08db7847c2a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mE6l5skkYFofJ1iY2wZj/yIabbSHAzJyTuvDGYRVg1wzdR+1mDEsznuYtp06gFJKZG81g54/+cB/h8X+nZRUEXkzXQzWPkhM+LaWlXoLkAYbFYR9tEkJx46wN/tCE+mq0KtTwOjoT8gRnCd21cI5Oxd5yQKyHyQtCrj8z1rRAMky4CmgsMHkYLT47fePhNhVmghU/Z6iXHMSvomeGxbE47+0xTqI9Hi6IUA/2AC6J4kAxYbpeHzPtKBOjEGDYkptB3cQxfnAXaeEZL3IQBepoDXmP3S53+z9gRaCTa3jhfcnwoZKDoEC5wTta+T1h6s4DwwnDKGQMdD+8dxSaGSbTFJ8xb3HJjWCTOgxcBjjN6/ootygOP24JB4eWosqRrAynbkTL1QH6tA9sVKMyPFS+xBKOcRC4L/SxbUfW8d3vZx3Hq+HhfzUZqxK2F+k2UZCyixO/zqPhTdm1vbtyRm4gDuHKho+cZovK714/cRaWjVDSfUk0Aaw6fhfVtoitO/TqYCo8rrgZnvRXVdqUJFZ2nRH9vReaVUlI8mnxbF36fotSoZ4OYQ0DE9iuBqa6k84
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(26005)(54906003)(2906002)(36916002)(6486002)(6666004)(186003)(38100700002)(6506007)(86362001)(41300700001)(478600001)(66556008)(66476007)(316002)(6916009)(4326008)(558084003)(8936002)(66946007)(6512007)(7416002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gcJzRu1Xq4LB0As9oRj8Qw0yX9x4inlVk6aDb49In0wJzO6jabaJ+DI4eVOB?=
 =?us-ascii?Q?+FPqrT1Fqq1E6KnBa4ww6aGdKiPpUOrPoKTidvMUWC0M7UCZms9aGPbybabh?=
 =?us-ascii?Q?ybl/lDedgRqY+70XfB5UjLa5sdTfnqCZWmG7hr6rfCCkc96Mp1906jgb7syi?=
 =?us-ascii?Q?8gCAKWPo4Sym0tq+Mm14VNCgaOX69vzbGV2A8jmd3tULIGo/ANodzAYi+fDa?=
 =?us-ascii?Q?m70EsU9Z916TloU0IOe7DkPEQz/PL3mAyBT8pYsxGjG6cbcSrWqbJBfQI4wM?=
 =?us-ascii?Q?XAO0YizRnKJHAPBFGTKGEN2pSNkYyeaTufuyjLabAcf631WghIwW8uZn8ili?=
 =?us-ascii?Q?1qI8ZPunzlEDZiEuKNw75XIQ4DeJnga7n6+SKAG5kIhO46YnNqLonLhnpFEg?=
 =?us-ascii?Q?A6yrVv22xCcm/Ve+AArNhHyeWMuqOdTmmczuwKr/GfwN14sVREA6S97j0KYc?=
 =?us-ascii?Q?MUjWu0PFNx01PWUy8EO0YhrL1hwZVwCC7525bzPKqyX2i7kVWszvyNiwwpmt?=
 =?us-ascii?Q?ov/vrs10WHtIbYPozyetz+7Ixff0lj5Ps3brT++g0gqX3z/ideoYXP1AUaRo?=
 =?us-ascii?Q?CN7/OsdcKXC1govx2czIpY8mirQWlRWf1Jgkfc8B9tWl58d9YN2imZYKijZ3?=
 =?us-ascii?Q?K7WKljnhyDhT3JBKqZcIWW8YuejuTUtF7ZQDxTSvwoYJhTRGzs54XSarhiLf?=
 =?us-ascii?Q?rVa7joi64ufsiFl4gBC8cZr8ru0tlN5sis6LZBrBnQ+KJknHinS8CZW4Gu9V?=
 =?us-ascii?Q?C5R1qyKztpdr8CPaJQHwoVf2pBpil1HbiOh9kmCIh8QV39uzOGFzJKnjhehO?=
 =?us-ascii?Q?0BpEx4PVngFDB8bi1aTMU5WSMMueqOl9WbG0Ai9qu3sB1l66T5izl/SSD+gS?=
 =?us-ascii?Q?TrJu8mzRPENutA6qbiuSZDCXSlrWRaYXq2JJisUjBZjZmnFb0is83ec8PkCv?=
 =?us-ascii?Q?pVxJ3Lx463MdMm6PpTEeldrKuAxW3uuPruSGs3wYw2DEMMNPJFjXoeid6DAa?=
 =?us-ascii?Q?dPz7tCJdCsQDkvJQOW3YkfiyRpKw4Xa99QlSzdupV7MQ42hgjnopT/d36mxl?=
 =?us-ascii?Q?FW7x7Np3tpF4Nwv49JGcMd4TIsyBNwF++y2xizqd/P1+FdojKJoxXy4Jfg50?=
 =?us-ascii?Q?8lC00ZiPY4bmOP29JmCvR5KXXTcsJcDlNNxgC0+7UA9RZxeYaYxQK+CLrTrm?=
 =?us-ascii?Q?SrAtLEwQCCzy7K3nEV8pQXyTdIS4Y4PIU+Jw2e6Xo86f9aEQSwa8i2Grb9fa?=
 =?us-ascii?Q?5ByLpY2ilXmCmMzEWQZf5cbUTBJDRknm7xg+9Ksa0hCO5eyDwgeWYLxgcsgS?=
 =?us-ascii?Q?a6eBPzCETFZF8b+O8jIX1VR13aQ/icDZhDeSAj5zGIiK1sd5R1gXJkKBBKvY?=
 =?us-ascii?Q?ADM8lH1nt904MeTobI4qO/+hhSqV3wJvcgRi3fBcCIb2LnXXPiafyU26Ca4U?=
 =?us-ascii?Q?PMr7QMvaxUAMNsizd9UirHW1jCtmDzxHotEcsN78KaizdXMhi7hyJiQH0Skh?=
 =?us-ascii?Q?KzUF9JZrdrWP4HjGKV6lN6MjiNgG0JikgEv1DHz208cnB2DU5t3SjH6Ij7YP?=
 =?us-ascii?Q?sTz2KzlA2dJBhIHZn15zKtB5ICdMFbF5Vq6lkezdQCTAML3w9swvo+/DrRok?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LGEiPV1xnD3FwQZCKKparoL568xU8NwyvH46/EgoBMh/VTkls3Zv2DxFAkoU?=
 =?us-ascii?Q?gIQ3wHnzle2ZP1BT+YtSqN0Yp4vHJItnr6UtMmvzQWAVf0+/ScbvQJaUE6Ul?=
 =?us-ascii?Q?EeAaJn4BCHSU0909hQcLn0ktBI0ZrYp5aAJS717FpJuBAJmp9FgmLzD3ymoH?=
 =?us-ascii?Q?HxNdSDXsZhjntXOJaOvJsxnlqeQXjlSYONm+XwPUHszPbtpKP+PH2SL9xf2+?=
 =?us-ascii?Q?aseae7hvHQJGDNuTQNfVX2ldsRuXPsd2d2fSc9yN0lEDzlpkgOEMyGlidJO8?=
 =?us-ascii?Q?htwN886Wr09t0RF1jpdQWvYDiapoKaU/B376osihvqR0Zoic3BbrV0QsDv6b?=
 =?us-ascii?Q?m2UWtQssGot1Zm1BgKTFaNe7H9m/hPN5NCfaDJCpWSLY/PJzngQu20d7FKRL?=
 =?us-ascii?Q?V/PQy7fMGd80dxy1sRO2rnvfqYnxWzZgNSKrp7z4RqD2QSIOBQ8M0I9cGfKI?=
 =?us-ascii?Q?UhU1uZTBt/Vuz+XWGu8djmXAhhV2OyDAAyVoksDalXKFoKnQghIw03FRcJq3?=
 =?us-ascii?Q?amlJ9bQ4PdQwfbT3I0JL8mXqopuqQUYuxHNBP4lOlKdhD5FQj6VcFGgVuGFu?=
 =?us-ascii?Q?QIiKSDwztfaAaGUNiRpQCKId4MMsZAHc9kQAHUnWm8tpBOp0qffg9S6d8HXo?=
 =?us-ascii?Q?DKDe/7+PyjiY5UWbrSy9TNMVvG4Cmb01GmOWq8zWnsJkrmF23F651hMUtBbO?=
 =?us-ascii?Q?2xNgJ7LnyhxLOwLtGTyzmDhVJREZztQrMn+Wg5NS4UPY38xl9YkQVhsTHgDY?=
 =?us-ascii?Q?etr8T39uTKnKt0u5x72ZUggZYj4SsQzCL4zvXhN0fbV1cRNfPJbrZR1nJjBO?=
 =?us-ascii?Q?s0z2Yo1JIxeZB38flG89qHnIEwnCrRvtu8bN/CS1b6qPLCC3GW4PLUDz5ELh?=
 =?us-ascii?Q?8O9qQOkSe9QiBnaUISt2yjbU+ExWvZduzzJ0yC33YLVZozEi8lcRyzIK9W0S?=
 =?us-ascii?Q?ePwDhwsvBT4fBIkIP6zykNqidqENgcvKc0v6FTxS6CiCyJtsfs813mwq4P9g?=
 =?us-ascii?Q?nQI6bB9zOkUQPPv1DEvnAbnFNQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d860f1ce-2f39-4387-0d3a-08db7847c2a7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 02:23:00.7824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zR9EpAk+wc5ENJsqpzjRm4qQQDdPSqtl2Lb3IqoKiiVWEgFiiWdATaoUk4k/5oQ73+uMASK33YJUajsIVkYnk/ixLdX4rUFnGdYMpA3/C3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=887 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290019
X-Proofpoint-GUID: LqHwBby40R4NUJ2zGG8JIHClFj-jmphn
X-Proofpoint-ORIG-GUID: LqHwBby40R4NUJ2zGG8JIHClFj-jmphn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keoseong,

> Commit 2468da61ea09 ("scsi: ufs: core: mcq: Configure operation and
> runtime interface") added ufshcd_mcq_select_mcq_mode(), but it's not
> used anywhere. So remove it.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
