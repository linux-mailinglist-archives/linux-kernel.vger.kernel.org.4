Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB6B659E49
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 00:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbiL3XaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 18:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbiL3XaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:30:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC331DDF2;
        Fri, 30 Dec 2022 15:30:06 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BUFxu6E008787;
        Fri, 30 Dec 2022 23:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=2jCYdEfpFU9mmaewZK/kwZaWy67J4ku0QV0+pd+/ack=;
 b=rzzxsCKCaR1FS8MXMMiW4/6fLnU5WCHt7lBtfu/H1o699usWIxB4H/lfIT63AuM4DlRQ
 Hvr5Drc+CljCpmMyVd9bV1cJy/ZaewR3nuGGDKqrBBtf34UxBEwMJ7CQQ3XAJeSNEbqz
 up/RKfnzOMilgy2APL5iBzBkuXfGU3dvpLd013uyVC6AI1REUNqM+HiCjDX/MOqa3g43
 wjpNK7F+aXROdLhCinRhJJAmHossmonpPnyiJgd8IkTa4JMyu5K3wGk1R3DhpQR4N5jt
 2MlqEnavNGmgdMJDJIddayDHe1uGIVjQEko6nbJcYLfTXTkzvonTtRnmzHRrkdgoDg+Y HQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mnrbb8qnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Dec 2022 23:29:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BUIsPHl018937;
        Fri, 30 Dec 2022 23:29:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mnqvf2y0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Dec 2022 23:29:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtWCucoMkonrx4T/HIvP3s5DpzKASZJh+Rhzn4VuUDVLrwG6M/NLloS9kZNlEH6WJ+zFujjHIBIwEpfYTSTb/9i7pdnh3/8FbNyFyWPHexpBlBrSfOmeLw/F86Awak97HmnKDy213AQ6TOLZCOaRqYWKIt9qSKsJTejRLQ/7lW2exqJZFt17nNGvvB0FIFf11jq+cwjyFrmEGXw3LB8ZBIffyxfuRlAOhpN9W0lZtYuHvMjvyTaCsVZzAveAZpfBDH9lm7FYtgNnoJvmhQ7Yn/q7x7beOBKnH602wBCWYM1fLTv4RR7oe4yuyP+nR1MK5QBdSgyLD6eDazZ500ExfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jCYdEfpFU9mmaewZK/kwZaWy67J4ku0QV0+pd+/ack=;
 b=iSXwbzuy2Eiv51a8NJZuelQwvnRxrucRYiD1LqJLhnMaIdtzlPeWn9tsDuvBO1TlUhYrsQ3/0I/DSIzXqcAWuI95lqDzsFqcO5l1+feZH2wbX8/dsWUXdsfE82J0huzcHNcingMEJcImnjTkDKrGZyy/Ucifh+yHuGsCmTtx8btoFsJXdb1alAq2QXssiYcZDcqq0n8Ltmz0srEsQMnSMUG4zcBPU71KvrrFwXe8UbEXIuLbdnqq+k7cs+V94B/4ulvnoi9nRvVXqU+vhg5zVsKOrJyHSokdO2KE1vVJCLzjAXoA4BYhaHFQrn+mQI9KfQlDuvpC0ac4CysKKp9XlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jCYdEfpFU9mmaewZK/kwZaWy67J4ku0QV0+pd+/ack=;
 b=B6yt8iM92hiUlvhBsANBWKt2PrUssRTrVFmrgeKQ+OAEsmphuQxUZlIaaprtCAOZx3HxBIVdCAG3NntGygGc/ljWWlIjGvInqTyDq9V3IgQUkSRuna2AyTQCqVwpQ7V+oEm69mws1NuY7TDo0Q0oYHpMwPfYaWZyV12n0LHw9b0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BY5PR10MB4116.namprd10.prod.outlook.com (2603:10b6:a03:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Fri, 30 Dec
 2022 23:29:28 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22%2]) with mapi id 15.20.5944.018; Fri, 30 Dec 2022
 23:29:27 +0000
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, dmitry.baryshkov@linaro.org,
        ahalaney@redhat.com, abel.vesa@linaro.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org
Subject: Re: [PATCH v5 00/23] ufs: qcom: Add HS-G4 support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17cy84gqc.fsf@ca-mkp.ca.oracle.com>
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
Date:   Fri, 30 Dec 2022 18:29:24 -0500
In-Reply-To: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
        (Manivannan Sadhasivam's message of "Thu, 22 Dec 2022 19:39:38 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:806:20::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BY5PR10MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 6709ee7e-406f-404b-ff3e-08daeabdb17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TUE+Gow54+TjgLm8/0WaoNCZ9jRY56B7htv9XKZoSZNuiU2bsY5RIIhg49ErMRMeUwHr06gClTnCEBRvGJGVaNvHYLetNZN9dMb3xjgqVhgGG8pjP1IwQFj6dZxNZ7cTFqNb373YpmIZWIPeQxl2nnt+msN3+LPMik6I1xwt+JFd1urHeSYyGzpuIeloOXU8iYxd7C/KgUgn84GuPSSPVdpi9LnGAeTzKN9oWmkmPui3IhkdQb61F8JiJrvriRMt8cUZQKtRU3R2O19iYYCfmEQALMXiKCva+oJFRZsI4hh3hrh7LC2uS0efQj/AAtR/WlehzoBwaEU3ADKf4I1lPIgDygR52XXrtVoX9p3Pch5wJGrwcFGQhJWxrtH2vFlzZTXoEUYo+4plVPX33A/98EQ6By8wS+7iKZWBlBYycGI2JHHMYi9TFfB8fTBHXhr43AZNA2Sdhnxc82VJwPyHyVoydSCz+RdIWiyxAxFv+OTRNxchVDw0xL5pKdqShk+4XdUEQGrE6tr9/zjxjjYHC3PdVthdmdOMFO2Bm19SIILveQqFeWfs/ClV3q/aCK0k5GGy6CfgJK+7QyXNfoM/SAOmEruDMovE2C687RoekeXXcGZCFYiM445riTiotQxpTbewMpPmTXeP1RgdkHBfPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199015)(38100700002)(86362001)(558084003)(7416002)(5660300002)(66476007)(66556008)(4326008)(8676002)(2906002)(66946007)(8936002)(41300700001)(26005)(186003)(6512007)(6666004)(6506007)(6916009)(478600001)(316002)(36916002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zbPM8V2w3qZ5EB9WIYb1v6pHc/M+bZbmQ696uPcBJJPzHI8ou/YZrdSTruzE?=
 =?us-ascii?Q?zfNDQC8/jvLLHCTBnrMA4ZGfpTyJfnAjAoGMs2Zw4Y/GpH8gGbuxI2fQS57F?=
 =?us-ascii?Q?peMEp0bzbYxRzquZvtXV0BMFAgsQ1jexLec6hY6vZHQDjlau5MBPcwMqo8fZ?=
 =?us-ascii?Q?/F0tzFIJE6qEvhAha9lujOkA4gVsVdcR5ovgvteK3ZCtbvFnKtlZyz2rMego?=
 =?us-ascii?Q?q89c9GjMCiEw8Lx/d/uLuEFj6+tRrpQooidAVmr5LerrgMlr50G0na181waS?=
 =?us-ascii?Q?3FzE21VSJ/JHHzkqxSBQdKXzc5vOL9xCkf9mICaWh6hjHG12QJV3bphvZEXc?=
 =?us-ascii?Q?CZxWlWnBpiGLIQNKsTyLUP8l9Yh6HiDkxRAwu/hSI7xw/SlzyJ2tf4LxyiRk?=
 =?us-ascii?Q?FmxnrFzBdXxE01/H/j/sX8CPsj8iNHETrF4BQGNUSEU5jC2T90t2xdbPMH8r?=
 =?us-ascii?Q?arvlAQlBY6dJy1vOSmY0yhqLQ1YscqY2+45wFV1vrHP380Qp3lA04SX0lXy+?=
 =?us-ascii?Q?ZqE3j0QaTP6AMnBGveg5TtgYii5i2RG4/q6d7FiBBGCo+ca5lWuOcD6pptAR?=
 =?us-ascii?Q?oEamADk1rbJlQZ36xuWKbwyWqDc7g/NW+ygnDzZGu3dqndHpWFbuXpKGkAZO?=
 =?us-ascii?Q?s/ldYhzOERypsfp7J23teszhtLonMZGaZepgoaU4n9FY3ZIoglLM8vzV+buT?=
 =?us-ascii?Q?KxUmKcD8hQrvOxpn72WwtyWREAOla0riZE7APITbSjdBIBSpqnIqZZNh7bHp?=
 =?us-ascii?Q?gGJPtId5gusLaf+5tgmd69VUGM0nkXAiI+5KviVtF1xXuoiUQJnNKUguw+KX?=
 =?us-ascii?Q?nKoxCOxBCmrjVtXzHbQp7eVAx+ytAa237Ve5JQklurIyatC2orBg37t9Hm6D?=
 =?us-ascii?Q?/81aX0NH6KOniFNb/cBBFlq9xy7o5xYod6sDVTzPh8VQWHdJXg39BGcbDv/h?=
 =?us-ascii?Q?tCWZeC2MrKiIw8d/hAW496HpTazNpkDeh2WunY/LSm+SPYy0ntGQE44MqrR0?=
 =?us-ascii?Q?EEvAhkRO8szXO/cUAafzPJu69Vpon+GuN69FntrqXcI1+iQQtk1qq55dqKQc?=
 =?us-ascii?Q?6RXoGnILO7PRs+OVqMf02OPjJk5AsORj6KWEunkMiX4SFcCRMLdvGHkbc1u5?=
 =?us-ascii?Q?7YFfN3qcdOpSzB404z29n1QZEXOoupmK1aL0y83L5K1II3ZD1o9VCQzwxbbZ?=
 =?us-ascii?Q?lJSos2n8HR/GOBK36Da12gTQvLbQD1FszdSsPqIpzdMK2bvv8vGYSnDcyHXm?=
 =?us-ascii?Q?i6oGzuUx/eFWLZtalzmz/cLMvFy6iymWPe9AfVl6t9Zsl+TRf7zuW8kqPQGG?=
 =?us-ascii?Q?YAztomm6Z7ZSb/fiZG7t0Z145YBcHCeqv/lUaKT4d19S/aOFwoDCSa/YiZEC?=
 =?us-ascii?Q?Bu8Phy/q7qvrQkCH7mNdD+OfpCaVXjLCUVWEdcpL8KNOuvEOsEIxPu2lzXEv?=
 =?us-ascii?Q?HgEVJmv+wG473xG+HC+LjE2iHEmIjFs0ROiHTf7vflHCWcuStRZtGZAfjtWC?=
 =?us-ascii?Q?nXD0dsFezB85jUfUh/H1sTRbAYgEOorwVvyTa15ad5VpC6+I9x8N95Rpj2xV?=
 =?us-ascii?Q?VqGSG4Sy5xdpqzKpvpC4fss26RM5a/R6ODa4mfzt3hhYph4AMh9smwHVh0Gb?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6709ee7e-406f-404b-ff3e-08daeabdb17d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2022 23:29:27.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jk5xO+gagc6MiZ1jPIsbAsK47sYyJq8sPzQcjQnfEGyJI45INKnWDXMG8CDfyhjinlohEivwzRyvHWLApZfPhYQEWHCSh7i6bm8RS8Rxs2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-30_15,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=876 suspectscore=0
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212300209
X-Proofpoint-GUID: gzG_2ej6ZwQVd-auiFNx1EkUUF1_-TK8
X-Proofpoint-ORIG-GUID: gzG_2ej6ZwQVd-auiFNx1EkUUF1_-TK8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Manivannan,

>   scsi: ufs: core: Add reinit_notify() callback
>   scsi: ufs: core: Add support for reinitializing the UFS device

I would like to see some reviews of the proposed core changes.

-- 
Martin K. Petersen	Oracle Linux Engineering
