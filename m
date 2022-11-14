Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB4B628603
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbiKNQuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbiKNQua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:50:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8546F2FC18;
        Mon, 14 Nov 2022 08:49:33 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEEi3IY007214;
        Mon, 14 Nov 2022 16:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=dDqsHqKJXW1sxIwZUJo+DoS7kIo7vNGjsJiK4zXxCxY=;
 b=e1My7gyBG0pM1qr+fUgivF45OXpUgPg1QWmGG7R9HAc2M+rKnL3GZAplKFnOMTVkIf4Q
 xlru7z+u4bKzZG0OmqXkwMtyHyNudT1XUtebn9lwaGNocgNnqQFaBSAwbfS5BztvEuM6
 G/e11nEOou6tLQYe79Ue6TN+8LpjKfHP/1IaEgnQJw1vrYnIYYmHmnwUxL+ZS/QR60YF
 toILlqvO9R2ePG0GiHRD3RuiaVi8KWpmMZbGwjB5Q0wmnnAG9FSJ4IgmWNv4Y3YXFfwU
 Lj2+sBocZCQwpPyUF4T5u0EhKZLap5chKl+Pj21HVWa/57hd8Mf6lLFwNKR0VauXKQS8 Jg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ku1dbah02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 16:49:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AEGOLr7019263;
        Mon, 14 Nov 2022 16:49:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x4cm8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 16:49:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AR8p2mWTQ78aw+h7ZOPUunniZGpV5ZWIo/Rppwjxa+f0XNukKtJvaxfqFgZ/jW7aKvkPOMI3NdXXnNZCkKF9Ts6HBqqM64BiIYb6DUsecLz57DYY2Ayk/zAf4HdVsXNyEmmZFZIwnNK5u+Ko3arPQii5hFyUsra9f9hJroJWcpRnlsVvWgeLtJA1TIkuKMxmMUVMa9p1Wk3hsifNjONWhCS73QpQNoG4u3K81qbIBCA2inzaYnl0DH4AmeRALNbZKXdN7nxaKQhFaFypDApp66YjNA+HS0nWu22h3OMaA2xMzAWtrrpkVf7u7OB17bTxCFK5PAuRySAeZB+hwNa5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDqsHqKJXW1sxIwZUJo+DoS7kIo7vNGjsJiK4zXxCxY=;
 b=how4KleDFIY3ZuYxyYVYleBpfuKkf4L8qNTKYpZMR0wCgKK8G3p1rJkmUSOTpOW5hxLL6hBe1hAyKGy00Nw2T1utxfVG95QUYtvpS7Ygxg5Ch29Ca/F/TgUzymzmKrHIfbsmRCezK9CQfxRvsAW0n9DuDGxrKFgfZ5Yk2umu2tHQ8Sp0PKvmTpq8tHhupDVvUPJKvVXUxaIWF+H1DaxpySBduuVH3Vl4zs1cSI8YUY2DnytZ8LDsbiBtx7kOvvy73ls896ngswbExkjTxvFu8CaCbwOORo7zT9Flq/bKh9KUkWo7vMbh9HNYSsUUKaA+5pPGz9AJ2btbBxoQ760dUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDqsHqKJXW1sxIwZUJo+DoS7kIo7vNGjsJiK4zXxCxY=;
 b=xTzxLKeFgoG100xXEOejRwd0BOkKoI0St4ITxPMxp6OcC+u5HsdPD3+KpXrZlfvl/uCxQOpwvLIX+LLUYrtcH7ukZe8NdYLJCQ1XY0rys0DV6mnRITU23YUUSPTgtvw/htgNsn5zAKKPgu7gLcvrQF8VLPk1XPaRUa4/PBONgms=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA1PR10MB5688.namprd10.prod.outlook.com (2603:10b6:806:23e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 16:49:02 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2%3]) with mapi id 15.20.5791.027; Mon, 14 Nov 2022
 16:49:02 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     masahiroy@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, thunder.leizhen@huawei.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v9 3/8] kbuild: generate an address ranges map at
 vmlinux link time
References: <20221109134132.9052-1-nick.alcock@oracle.com>
        <20221109134132.9052-4-nick.alcock@oracle.com>
        <Y3BeTbHxj9OmmmIY@bombadil.infradead.org>
Emacs:  because extension languages should come with the editor built in.
Date:   Mon, 14 Nov 2022 16:48:57 +0000
In-Reply-To: <Y3BeTbHxj9OmmmIY@bombadil.infradead.org> (Luis Chamberlain's
        message of "Sat, 12 Nov 2022 19:02:37 -0800")
Message-ID: <87v8nhv5vq.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0018.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA1PR10MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 782a97eb-59c6-46cb-1405-08dac6602227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fx5C35SnUHr1FrpLZ7ZEKzaM+cFFnMo9HLFafLp7bIhPnjz57wSxPvECD6+nIipPFEQa1ow/snbA6zbp+8xKg+YZv7McQansPJilnWAaakybzP+gvF9vWmtRb4TvQDkMKbNmmCQTsVLvu0JFpzOc+foc66yh8PEzNnOegdMqNsi8tUh0lae2ep+fiPaAYmL/bByz72IPOUDzgfAgXUr9K8nrNmae31GO0uDx0FlXPAqQhDdtyYzDvnrvfkAThpyso5sRmhhoWySMlp0gQK6pV4k43pgR+GQTvKHDx8KegEO7oMzYZVXqRMAlxolgOdZ8hDk7+96twVRy6H5mcggatxqy3xvYe7DenuCUMBQYjKaGG2ST0/Zp7KvwoY90sVWi2Qn19rOnvqW4nIaP6bSr0TRJVxcp77kMM3eSULDMihcf9HxO9ntUR2v8Gy2a3gJTN7H25+hjCf0SeMl7V0yEzhKVU1iQ2mroh5FQM+jnwK7mXnLWZnJs72iiZlZ0kKqVKpnVriVYxkUD2zIQer9+n60XlH0OWkWR0U9CFG7nbJUJH2vxmhxqLRHu+tqfLzerN+HsUUFlZs2Ffw6e9DN2sgP/33HaMqIJ1pA8VBCbmaWJbVmo+PXQYIicw8dFKzwTAJXbyMc2lHJF80pBOut8m4W3RJHMSJs+SO5v+8t8HRBYL9TF0Ukbmkf2XaEnDBWM2qfpZv+svGyHmaCgbODe/L6BCEsBLbBdzB5dkU7+GYEyfocSujNGmB+YE1a6cuM5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199015)(2906002)(44832011)(36756003)(8936002)(41300700001)(6666004)(6512007)(5660300002)(86362001)(478600001)(9686003)(6506007)(6486002)(186003)(4326008)(66946007)(66476007)(8676002)(66556008)(83380400001)(38100700002)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vJHK1RuznTybxZI2CCtWc46XoLCNiBi8Rc2M+53GgLyFbN/TgSLQKKWko1R3?=
 =?us-ascii?Q?ALJcz0j0qKdhLYUR/jInP+jjl5ymAK8RWKyIEB1UqVA1kvj5b3gF0JUZF5p2?=
 =?us-ascii?Q?WQI4fVNB+UHa+TZWYt1N0nNNKypdc+P3ee6rAjFQOb8CEbKwQ/vf5pY/XjAp?=
 =?us-ascii?Q?GdXGC3H9DUAKzjiWBRoB5AwtJpiBzUYgtVedpSAqT8md0tx/7gA0tYp+ymcr?=
 =?us-ascii?Q?mdpAJQwZxW0sB4oeqBWHfk1fmUcG0ZjvtLx1TAhqRVWAfMabY09yJXC2xUff?=
 =?us-ascii?Q?vnM4/b/ZqAnzGzpn1ln3yeSzK1IC9z0aPxn7YELKR8pTmAhWfoEreYjaFjVV?=
 =?us-ascii?Q?r/LUvYF6NcSR2JehNolYdi1GHNozoS13VQ25t3Ve1ZVDlaT8ZprY12M+Zg33?=
 =?us-ascii?Q?ulh83EeEUZrX+mlCtmoZpdEPyozdNLSxpzb3rKnbVdlQJYx10AXSycD5ywFU?=
 =?us-ascii?Q?OQvYN0JADBAxTo76qs+E9kWQF53rUx+8lYvCCxuDqizGJJ4JZ7XYEolTlwmJ?=
 =?us-ascii?Q?u/UTE2QwtiXNaDBBKYMiVG8NIkNvx89d9MeW8EPKvWE446OrqJNhE0AmUe/V?=
 =?us-ascii?Q?iEIV2uhYXq74u+/WCWKhboC939YfNCTZ/GieLdLpMqad5K19tGSM1RPZlP1F?=
 =?us-ascii?Q?uKITddkWYSGwjOcP1hm1M9o/fEPfFB5q3JUbVJY4fujcXKM/JRCXf5ALh+e9?=
 =?us-ascii?Q?YxWSnpagPP/fDtjN2SsonMyB6IAMlK4Y+wI1cYKQS2ryfH45iZDRmaIGfzIs?=
 =?us-ascii?Q?o4DU/C6/EE4l1CG3E3rIOfM7FkDRRABYmGpw3C6O1wjXXdScay4hGMpodNZl?=
 =?us-ascii?Q?uWM5oxFra82+SeWzQx9HSqy9+AiESqrksakTwJeHjCR/hbhJmBCGvjtUepXI?=
 =?us-ascii?Q?pcjN6kL8e+EQSuEFoNid61P9c/IQkaUTz3Zxl7bmtw+9WY+H6VvTVeXtOB32?=
 =?us-ascii?Q?zMlb6O86vb98mVf7hwv1ZhLOriI5O5pLQrJkc82B3NhjQQa3sJDZOhgaYzNd?=
 =?us-ascii?Q?dj5RvhBZpk3o16vq6HtuwYNsqEyeZJgjWtIy1TMVMOYSo5obfp4yJe+fD/9i?=
 =?us-ascii?Q?HbqHLiUKvtMYvr7bEpFSqtLqdJ/ukAM+VsmzwpJQowat7JaioSiZmKnL55Ek?=
 =?us-ascii?Q?it5stE7iRZyMvNsLp22gLdj/b57pKxYQFX3kvugTY+3AfDycEuuBW7MHcoPp?=
 =?us-ascii?Q?SC9alIcy3YAE/QGpx/0Bu26xh3KgQFopKcaBq/MPQhTt5FauvmKB1Z9miWWV?=
 =?us-ascii?Q?KpKskPVDgHh3x23iIOR0SQMRbJWM9rxUaSe3Ae0+kfvbGBpAXArLk/9KP2L5?=
 =?us-ascii?Q?ZVv+TKwwoxSJDkCsRrSZlFNvIMBdBmUoD9SZboepOKrmIEHcrx+Mnje9onRD?=
 =?us-ascii?Q?PNsez8d7pyC6yT8gdse1IcXM8LeP+oIRW6m51HBnVb4qAHm6P4R2IdyRQdSc?=
 =?us-ascii?Q?WqZiA1maSfrpFVkLNsL8sy5/t4azm2pldya8zo72n5GZcOYPIXCVkfQBIWBC?=
 =?us-ascii?Q?Jo9IZWFcQsG/LTKkQcJFM8m0PYrifP/XMqw4WiTDiyTRLMT7kQ1JVGONyMvY?=
 =?us-ascii?Q?i/r4C+/SVDCMagB0LGGAjU8Ta70rVbxZgwP8SOnsSw9Sm5g7p1VE79v3AEPL?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yzD8Z5TMVqjoj9LD4+OjTUEobJh+DUfmQ/5x47ZBpqRrUuHDJBjWQKRGKybw?=
 =?us-ascii?Q?UsLoo6AtNRYrT5bnMdSExNJ6/hxgLZzz/exaXExKcEoapeB5qnLrNo+CelX+?=
 =?us-ascii?Q?SOun/K4hofqfdAJz8MiCucxW+70VGZwtEcQeNDyvXvUFB+FRDociY1x7SQN5?=
 =?us-ascii?Q?5kouT2H7xYsWjzgtkDFQgtUyRXqo2Fgwlk5aAN91tfa5crmT1IbFFjNKQSiz?=
 =?us-ascii?Q?mJ0CbN+tU+g6o7y/iWaY9ltkgpPf8Tyr9Cq0Zt04ur8RIzX6yObykec5pm5E?=
 =?us-ascii?Q?3yxIw4y3tMXSbhrom8RUiYL5p8GtPolRKMoxzfRKYzeNS7BnaSTaTVzx0IPT?=
 =?us-ascii?Q?webx+Xc0aXgejvmhitdH6S6Oo2KBqfs1jqAfR7ssK5UU8R/QcqzE27ywIgiW?=
 =?us-ascii?Q?eZDLkVm+2L8gsB1t18Fm5EubvZRzPB1j/fng8cuI6BljlZiK5koOlzdLAec5?=
 =?us-ascii?Q?oKTNHswJRBJFVpkfozalcuzLaSPsneRcl95+cAZawyRKSK6+OrSiIdptfQu7?=
 =?us-ascii?Q?YuqBHq9S/E6vEUQgN7Ak629Ga2gM2S+p9bSwFaQJHlGbUt2FAgHaS41nOrOw?=
 =?us-ascii?Q?6iGnUxZ+ZmXzXce3Sfq8Cd+Uy6doYuOF/3t5z0jIJnJyVRumgO9JU7jnpZeZ?=
 =?us-ascii?Q?GfzF5Fgigp+TOgOLo29HOPCUL8UHSUWe8Elhva4T3ioZxC9eVX3JN83Tn2n1?=
 =?us-ascii?Q?l25TMq09aBSZbbkp53cm72cgNGrz6SzK3g6qZEEY3fD2n9LbZmTx5W4bcldB?=
 =?us-ascii?Q?iJUfGuxgyoowjEsne8IBtnGamoDc0Q6+jG4XMdRCRbykfFCi8C5LdnFIWfbu?=
 =?us-ascii?Q?ZbB8mYV5AUIcUZx/YxtyOVmt+bSYdS6azMnrC3ds1WyFzE5fHo9TPPIsPMqF?=
 =?us-ascii?Q?ZvA8EVE/nv4TZGWm2OfhVPcQwnZoiwqt8uO+mD8C26EfM3UoGWY0/Rn/kgzp?=
 =?us-ascii?Q?ZCW7LBfKK13eOPBOAFAUTOg78wH02q29YQ3zDM1EVmRCfZ5xa6mT+kgTZifQ?=
 =?us-ascii?Q?pshg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782a97eb-59c6-46cb-1405-08dac6602227
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 16:49:02.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbbxQAKBxjN+CF7pszSpd/E07oJmbyReU+VzglHlb7t70sQtdGuSvbQSNpVSzJuP+zJSboRFcCJFN0rxrHpaBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=494 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211140120
X-Proofpoint-ORIG-GUID: zG1nKXzWBFwxKtEY8yf6yS20D2tXfqhb
X-Proofpoint-GUID: zG1nKXzWBFwxKtEY8yf6yS20D2tXfqhb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Added Steve Rostedt to Cc:]

On 13 Nov 2022, Luis Chamberlain stated:

> On Wed, Nov 09, 2022 at 01:41:27PM +0000, Nick Alcock wrote:
>> This emits a new file, .tmp_vmlinux.ranges, which maps address
>> range/size pairs in vmlinux to the object files which make them up,
>> e.g., in part:
>> 
>> 0x0000000000000000 0x30 arch/x86/kernel/cpu/common.o
>> 0x0000000000001000 0x1000 arch/x86/events/intel/ds.o
>> 0x0000000000002000 0x4000 arch/x86/kernel/irq_64.o
>> 0x0000000000006000 0x5000 arch/x86/kernel/process.o
>> 0x000000000000b000 0x1000 arch/x86/kernel/cpu/common.o
>> 0x000000000000c000 0x5000 arch/x86/mm/cpu_entry_area.o
>> 0x0000000000011000 0x10 arch/x86/kernel/espfix_64.o
>> 0x0000000000011010 0x2 arch/x86/kernel/cpu/common.o
>> [...]
>
> This does't say why we'd want this. So either you merge it with its
> first user or you explain here why anyone might find this useful.

Uh... the first user is later in this patch series? If you want each
commit to have a self-contained explanation, I could certainly note why
it's useful for said first user in this commit message (and adjust other
messages similarly), but I had previous complaints that commit log
messages and the cover letter were repeating points, so I was trying to
reduce that kind of thing.

-- 
NULL && (void)
