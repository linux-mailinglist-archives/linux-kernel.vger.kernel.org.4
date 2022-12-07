Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2835645162
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiLGBnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiLGBnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:43:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A30532C6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:43:33 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6LKmhJ003004;
        Wed, 7 Dec 2022 01:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=qCZ/rl1dSjciR2lDFhUglen15jLBUafpTa9zJ3Bwgp0=;
 b=hUNrUknNtpDRP4szkXUBWM2cp5u5im9wJ30IyMfakdA2arU/Ar0ISxKKVy+OMU5PsIto
 b4M2rsu+Q6mCalMUyEBSY8dTDl2v4l5MM54bU88mqlGg8YMxOW7hw3c4QspbABnZ+DP/
 eZofHWaZVhygOo19kZ6CJU32yD1HwsnHn0Fibo9SkD4EzDsBAcfCmsXGP5S7lW2fU7km
 /qxOSeiUagZgPowPntvOaT+o2X0xgI+QBYay6tSPHTePNIr8MzO7qtQlXo74UQNaNBLP
 jK40RyPb/tE6rig9TRIjg9OdAG23DbcPgAyUtZ3A6Gx57mwgaCZljtNQJWxqkKWsBy3o ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ydjhpuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 01:43:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B6NwpEg032422;
        Wed, 7 Dec 2022 01:43:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7vj73d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 01:43:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grDpJrnoAgPt7Kw7jqihJbYmnbXVwANC6SosrxPpwDpKTUbbxe0aQCrFggjTPRXlovN/0C5nZW05sonWTZPBaHm52PmiMDlMBG0sv36DVGudAkPaW8BF8abZdMS6mEt7ks3+NTD/oI7p933aeCiEMBhz7ZbBdFuJNT4M/PjxWhSRuuuK7eFzPTsLOnER4YRVLcKo9WAGwGFZY1fCui64cIkcSJys1BiwzFfN6tBZhIxo3rgEO29JtzI+6kjsvmqBXBqfaR8DdFfS6hYEoX/EW9x2cw90NxQo7fsfFCkdZaACq7aAwDiqfDRxtUz7YVObwYvyw+tGaPa5Wab1zZnGbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCZ/rl1dSjciR2lDFhUglen15jLBUafpTa9zJ3Bwgp0=;
 b=nf7axclpn9TUi6iOcxOvMZ92QK1XoJZfW6bESYlC6YsmftZ6YFvL41vJBLQKJ5/Y8mEhIsjPTe790T6XKdBeO4WByKh2jiWL4BhYauouzkJZTDMv7u0MAN+tAZTO9jgiHkoayLGh46nsgoFmwGvBt4MTVKDdo/7gFXv58+XYAeuf+BvRm9Qfb9KURjry1xXzUzCogWa/cyhcm7H2dmT3ohZSWOV9zX+1LFOsGm8fTVuVDPVZxKJXqQ6bpJBodLd9bS4aHZNBVJ+UlKtRc98g4plWFGP6HSpe6Nb2EFHSP5xmK7DbXfNwIF2MiXQCpl3HxJ4kPXLFnp0RygbfrbqVyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCZ/rl1dSjciR2lDFhUglen15jLBUafpTa9zJ3Bwgp0=;
 b=Qm8GhDZ1K6bZMCMAQ3slcjiXOZxEYy9oOZAcrgArkkqrlxd80UrmMh+EJyCy7aIL3gHFJccsQO++b7EsRqUGhi8YAOO6zDyA1ZCfdoN9fVcWIhCbsOOwuzYKjQQr8E6HGwSldZ0HGze6t2bBvQxOcO4UWWvXniKsMzxilcsHhvU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB6711.namprd10.prod.outlook.com (2603:10b6:208:418::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 01:43:13 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 01:43:13 +0000
Date:   Tue, 6 Dec 2022 17:43:09 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        hughd@google.com, tsahu@linux.ibm.com, jhubbard@nvidia.com,
        david@redhat.com
Subject: Re: [PATCH mm-unstable v5 04/10] mm/hugetlb: convert
 remove_hugetlb_page() to folios
Message-ID: <Y4/vrUJ8asJiYKkx@monkey>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-5-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129225039.82257-5-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR04CA0384.namprd04.prod.outlook.com
 (2603:10b6:303:81::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b709a9-0dd3-4271-3c74-08dad7f46719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5AOuwC9BNifv7RYb4zwfZ8gcv4faacHrrYKUTo06KXNYnL22O4W7/evgsw+Zu2iZNzUPnA7oU94BHMfpBhnVYisC14GXAJhw/W5/yWgGiNu8POHea84otIrM4S+d5s/v4uk1awZFMJss2JDvYeGaYS+tpbEoW5UnHWpM34n6p/Cn/9E+7zo37q0k0G9SUiz0vVA9a2C9HTRAnQU7PncSJmnsoxM3BO9J0fZRZUctYUeafYY8ZDN68a+BwupyiXaak3pvanWUYWWuucaEq/EKy9jTEZ7aOrZzwspfoMymyHJfbd47WXJ923Iok0qHk3aq/bQy1c8+ID+BByrwxk/0PH13JIuDgSj+OgfYs0k1+ZHaSQp4a3oqDroWr/UQM1SHXhRKt/t1/WwgypxidlX1gRFKAxB1BRe3S7Fn8O8yLLZl7pn2Q5qAIJVKnGy5g+2U45SVlarjN1mhMjjDWLbQRQf6A3LuO6oWftu0WpDNdZpfH1vMTfeyv608Vykds0tfCEBVhQp0buD5tvELAVFkuEV0ouaXaXjp9PUja3gCVI70prqplYXzT/WEzK9AS41PHtJ3rP+/ldpIyg24d0ggC93FOI2qs+eh0zkKa1zaYKwGAxnByIiCc1gOviFNgno3Y/wqtx1dCQ4yIApc7BujA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(26005)(8936002)(6512007)(53546011)(9686003)(186003)(6862004)(33716001)(6666004)(6486002)(478600001)(5660300002)(7416002)(6636002)(38100700002)(4744005)(83380400001)(44832011)(41300700001)(66946007)(2906002)(6506007)(86362001)(66556008)(66476007)(8676002)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X05Vl8W4qsJMixyQNXfhXHvZ1NHKPJ6SfoyWshISXypv7mj4rG/GpaIwdikX?=
 =?us-ascii?Q?0ewvktowK/f1nMIFCisVd37cRA/GtfNIzvpNUXvss/krg6bMLoC7G+C79Q5o?=
 =?us-ascii?Q?3Nbo26wvySP2dQooptMhBZgB1yNonc1CmcatMAs9mIWwsTPbX83sXrTIyM3P?=
 =?us-ascii?Q?2XaMyj6ZP2plygOM9qyWgu78G86BC4/1i8YJYYT9dJPDPCRuDqktQ3/3p+/3?=
 =?us-ascii?Q?wUCmA5X6iXJb4PD0BiYdPf0V5uFyYLbnvaCa2j/CpIuPIMlT2w0yaL+xuA4S?=
 =?us-ascii?Q?JEv7CWL8FH4vQygk9hJjgkDmEU94S2rn10/IdC/WrIN2be/Uj2GYzPfNeXik?=
 =?us-ascii?Q?rF6taKScyOYhJqwW/anSMy176/HLPaJNO2xi8o2M+rCwJO9t3nw8rGQUChf+?=
 =?us-ascii?Q?QzoXBdc1tf2prXeLIdJRvrlLOAyOGVCI1+aC/mzgzGnbNh+l48jDW7uDqqvb?=
 =?us-ascii?Q?EOxkzR9k7eFMS7VfMEHHJ0zsxXa+0pwmwKlm+aik0/ctNRsQn4sy0nMqIEs2?=
 =?us-ascii?Q?aNtPv3eCMkGaC2bFLNYnuunAH45C0lcr08KFjTAFZQ/fECfX2vmVi3YaOFkW?=
 =?us-ascii?Q?IpFpOv0KvKyrFP06PHfqu28KOuVMr7w/wqRLoHbmZ3eI37OSMhNRfU7LMFWb?=
 =?us-ascii?Q?OFeQD3ntsFfU4LLIg4CQDnHmtgiX2aFK7hNxq1EFGVcQF5+AW5wBDEvalWHP?=
 =?us-ascii?Q?lIyidEkvtuKtib/DVBXRLHsJRJjpVmD5NvnEpqzhXFnW6m8yoJihY0MWBDtZ?=
 =?us-ascii?Q?hAengg430lptVfABdGmz6gXTFvdXQj0zl744tFaHP2vFzc9oIa60ei0SAC9/?=
 =?us-ascii?Q?Cs8Ed03EgYmROOBLo8cU/HTOqxapYM2sw4DuFW0kOZvwwCd/5ZE4mZDTRoJE?=
 =?us-ascii?Q?SDYVdGGI9kk4XBbNzqph5gGcQP2qfw0EGxrFyFzSuR7g2bDJsyzRxRj1mwqL?=
 =?us-ascii?Q?4sh5sr6hbkotgAoycqsNY5T9yplfB/wYKUl6/xipL80HM9I0qtr2zO1sILNc?=
 =?us-ascii?Q?n8rMgK/N92EdTt/b8EngGgcs8RO/tw6tly6zv9gM79LgdbWzWxSHBHavMxLS?=
 =?us-ascii?Q?VrTzABK1wcsuYm6LkW6YyvW7COD809VidtPpOCAg4MQqoep2TQKns7w65m+T?=
 =?us-ascii?Q?l/z+XsocmgbTh1nh96iDw1lnk/xqrul0zE5X/83HsR3S9Esxvg1u2bYJWqAc?=
 =?us-ascii?Q?hlADlCx4QOEXV6vbEVa/PPHweemJCXMD4+ZZp4nr5f11K55UcibsezpIqTH0?=
 =?us-ascii?Q?cjkTJMncAonDk9s2DLItHkP9AzwWSiSWLcnXeQot9wH5BjD0xVf5OPue1cVF?=
 =?us-ascii?Q?30ceaZ004rEed4xzWk/IVNFdwEebIcDyy/USA3WsnRqe3nOdwrTiQbXr7vmC?=
 =?us-ascii?Q?NBPjcXEfr+4DmoL7X+tEH7M0nsnwMtiXeNrrawe9rakpA28G4foA/cL+f3IK?=
 =?us-ascii?Q?+SrDyQNl29vTZg704KViweNh9AryjFl6j3tzsMF7AmYLlD2bOWmhERJQjAYl?=
 =?us-ascii?Q?RJ6SSsvNBo2lTvL/A909PzgzwuxtBLlwOx0qYnq6v3xghtJT+dC8Vdsdp6d/?=
 =?us-ascii?Q?oViFWe6PJtaAqENZWx8+IrV7fFziUpHtlcTmGGyphGIF9BFTTqubsQdsJkDB?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?c5lley/pckd24ElyWt3XcCuUpmeN+MuaqfvyrsCXfQtx6ZipEoNRihINnXub?=
 =?us-ascii?Q?gFGXQSvTHPW3v61tuCAAdnpoWJgB5tFdiE+3W4NtIYDGDo0hAm6QerQL1Tbu?=
 =?us-ascii?Q?N1kECMv41G8fx/RDKoKZQRlWs1sAFzIaCCMvAkqQziGtKTpBSXfY6VE95r3E?=
 =?us-ascii?Q?TDWbpZz/NjpF1SCLoZ20EMiMDP3mScPN1kClOvVcELJ3aRwcUNLPbiwBSvd2?=
 =?us-ascii?Q?OXECktD6hNtP0+GfQ9kzfbSN2XIM5AJy4TEN2m91tbHCnz2GjVkAMNN4CkuP?=
 =?us-ascii?Q?39Gol47mniK/lfA0KheHJsXN4jRR5w1fRNXJUp1C1RP/o74VTuMoAaDIut6B?=
 =?us-ascii?Q?xp44OjD5tjrZ8jJ57wXn/SbC6nV7ZoIK9FzGK3aRYP7c2TEAr5oxmSPoPFwW?=
 =?us-ascii?Q?v4uCt003GuCR0steKd74NjnPieCpoF6R/umy/xwJtCzcMPNKpF+Jn+53HNxy?=
 =?us-ascii?Q?A8KnXKOQhSUMVlE4AG1cWXXEfs952tb80JXwrq9BVQNJ5yOxeCv8sjzbwKBY?=
 =?us-ascii?Q?+e8vtZq9/z+b+OpjIsfTystMCYMdzMW90yUQIOQ5Ypt0PrqRzKzcU5bGE+u+?=
 =?us-ascii?Q?dOvLPlqPNe66vrVT4v2PCHc6RgGFkmcU5IDqjA3e4RviVFRPilV10JnTvhl3?=
 =?us-ascii?Q?CevfENe8XaNyJy59wgEPflGbI0eXOCo3+rqqXA4ewfThrL1Dx1LuzLmbXUmL?=
 =?us-ascii?Q?QUzmfLNJnvTF/k5HVIiUaHveD6AVSzjVy9tDArj5AlmmCQIlHUToPyL2+21h?=
 =?us-ascii?Q?4h0vIAFyLot3SB6tKfwDJtbPPFuktYK4l38M0cbY6r6JiaJu1PDwfSf58gKe?=
 =?us-ascii?Q?2Wdf+uSbjf/xbw0YB+Jj0l3MOmTH4AU8t4uefkzy0XOTZyCQzZho47i9AAgb?=
 =?us-ascii?Q?vH8C5PRhiMfnEce6h6/AdPkhljbPHcAg4dxDNtLc9/KSS0Zae4TYHKNUPdO+?=
 =?us-ascii?Q?3Hs0drLY7RoM3/V3j8QrXUQ+1ynylmmqmcv/bVQ7vhXY1S/YJqePejCS6Oc+?=
 =?us-ascii?Q?Y7q2xA78JmafdoDRHpTRAPxPipLZAQnB8GJdGHVaFteknHwbqzm8GNhazrai?=
 =?us-ascii?Q?rQcT/8qaafT9EVL0WDEATjebPC2FVJ84rfoLfQdpaZCZ5xpOQgQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b709a9-0dd3-4271-3c74-08dad7f46719
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 01:43:12.9764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HS0ox5aP58ki+hvmSFKW1H4g+oiKFByB1Ren9v55U1ZA+v94WFhTh76dst+nv1pvHe2msPRkJ8HuNzCkm+5KRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6711
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212070009
X-Proofpoint-ORIG-GUID: szuvUiLMhJAv03curSXDR_Kpe7iSKXqk
X-Proofpoint-GUID: szuvUiLMhJAv03curSXDR_Kpe7iSKXqk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 14:50, Sidhartha Kumar wrote:
> Removes page_folio() call by converting callers to directly pass a folio
> into __remove_hugetlb_page().
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/hugetlb.c | 48 +++++++++++++++++++++++++-----------------------
>  1 file changed, 25 insertions(+), 23 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
