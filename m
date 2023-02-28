Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07FF6A62CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjB1WtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjB1WtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:49:17 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E554360BD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:49:11 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SH3x3h021197;
        Tue, 28 Feb 2023 22:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=tM1esT3GCoPfIlpqSD8h8Y8pAnxxcKArxIwrxMMa/Eo=;
 b=mwsTO9p8AV4Y7yP6yVpV64najdr4FUp/CPcxMCSUQ5YtTJ8GecvQ3DOO/fZ80vp0CAv+
 ukM8mm0XkqRAIwzDQl8HLgsQEEDvTDN9VnsuKCX0gr3L8+3bzP+CttBqp0qWc9snjU1O
 WhMuDwrNyTk2oxD8WziNuyI4d4B8k1wMRaoHSKs3Goy2rOps0eXPZWhczigVocFnrCAR
 vJGovBdHt3aL9bDc6ntZF8BrSHB8JEI2SLydYb/5fZ6/pAmfVt+Iji8pG/RLqdEZlgty
 PzySKPQPuSn4q4azCJi91nYgMiEhGsyrIzh5hJLizcynrkCkWjcvIzpIT4oNSAqbcjJE aA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb7wqncd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 22:48:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SLhUgi031538;
        Tue, 28 Feb 2023 22:48:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8seahp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 22:48:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YT9NMWyZaCaTrwcrZVLuiGHRyFSQYRi1oYKckagAGVYfen/3CPQWaMWDtkCD2EROWjfgBXDIMrBK+7pkWbzZAQ5VqfJjRX4JJlAWonSFR2Cv9aCECbNJ/6zTKCfJrcFA42LuIYR4/mL3V9q1tFC1DxDULF8oBno5Wt2gk3p86U/nmBDZJKz+q8VDy9rWwGeptnOno/m5M/ADmrpXCVSFkKBn2sxxrIgZSZsoYU/7yJS3W2T2K93k5qM5NSDTy8cknKcRIo+aDMiF7NBeWi5ey8WdmcTsCauqBSaoH+2h0vQl8IWiQYB566baHUDoajuEQQFGp1J1imT0PoIUmfBEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tM1esT3GCoPfIlpqSD8h8Y8pAnxxcKArxIwrxMMa/Eo=;
 b=m+hQi41rUf7/z2qOWM9v7/6HGoBN6U6Jm/ee47BKzwVKpJtcLNKLNKuOizixV95t1NfP3qPCi518WXun/zSeSNBskJ3Dsz05BrQ8e7G58ZDlbU9emgtlnMqdFPk2on7YiNIta088SWazu6vrMyrUDcjfL95xUOje+KhSS0DWgeao8rAOP2dw+boL5v1FGyuGHNMnq921fU8goyXY80VishtJSvdGqwwoN0AiiOFLmWQ2bZcAYVnU+NnfiQdomvfYpYLVDxRZZ5CLmTXW841ZSwR4z2LT4eXlQ1FmExB/uDP7qra8auYQM2Jm2tVBCxh7lVne1j5fguN8o1EAek+hpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tM1esT3GCoPfIlpqSD8h8Y8pAnxxcKArxIwrxMMa/Eo=;
 b=wwEMlV4eI6JLirrROeXnKVoBwVU951jZf5oo01Z3cUDN0QOtTs0UgeCpSTs6bi/RMYk//p6UuRpi1K3Bfyf/f9wTfzAxrqi7bcp4hL+YLsFNUggjU2nXrEtXrQF3njt5YeDN/ESnnDofFzV8ThPCE1WW76Rmwr2HfNeoKy3fgmY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA3PR10MB7041.namprd10.prod.outlook.com (2603:10b6:806:314::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Tue, 28 Feb
 2023 22:48:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%7]) with mapi id 15.20.6156.016; Tue, 28 Feb 2023
 22:48:21 +0000
Date:   Tue, 28 Feb 2023 14:48:18 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/46] hugetlb: split PTE markers when doing HGM walks
Message-ID: <Y/6EsomcdMDl8Ffh@monkey>
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-15-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218002819.1486479-15-jthoughton@google.com>
X-ClientProxiedBy: MW4PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:303:8f::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA3PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1bfad1-9327-42ad-67b9-08db19dde48c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S68/Fh+1i6ARvIg3QQg5AlBXb5IMdKctXj5veWsA9MQdGQZRYw92GZVMnYPrsRHBT5hPDsaKpoJufkOiccGM3cDeINBMlcuCTDWUDK2CbnFKeLH8e+NfeEnEc/WiynGUpC1UCDJo0mreVYK9gYhhgRPzb/O3cavcgKkM0WZlfxztWwKIC9y+WSPgdGIcSNK8A8P9IJLFpy2TwmIGiGOUEicOXnGPvxd1ytCPr9qtj8+Ab87ZqGrmtTIC5pwCIIe2iTXAHgF+0CMsGuRxGhF9Eh6NBNCg4pvuFeemnn6Mnv1Lk8iQD/8PDMugb4l9i0wWIyYPiMiH2CJXHL1KPFX8Ocl1pdVF4RvfBI0T/E+OGdchI2bUyuUozEYvy9vvkTTVmVh/1WPGerayz/J9fsuBuYZ2Ib2nDg6F7/rL7DO0WcbygeKba9RS6C5oo5qEuNF8uHyLQaxZGXmshiLTkj0aSH3ISdOv+dg5b0ktK5bbYxeKxFgBPUJZsVaMyvaJBfrK6lHIqRXq/4LIBpc2YZBnZYxcBpXxikM88+M/YhtTgKrjFYPOq7g6wv0oZOfMoaBNVhOyJ+JvUkniFaXf/5EqhrBpCG9z8fSFD8L0O1im79kZJRQMxfxkT/e2FHz9awsAy1R0+Aq7wsiRJbSKLYpOyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199018)(66899018)(86362001)(7416002)(66476007)(66556008)(41300700001)(4326008)(66946007)(8936002)(8676002)(5660300002)(2906002)(44832011)(6916009)(38100700002)(6666004)(6486002)(478600001)(54906003)(316002)(33716001)(186003)(9686003)(53546011)(6506007)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cxh/JOZGERdPAAXRcjUYz6G+61fhTu2muHCkGIQfnBCyqUiat2hpempyyunT?=
 =?us-ascii?Q?p9X+9T6U4Pq2uI/IuN3ZKccmbfcNk46V39wp51JbIqVAtEarNYtnXGijFR8U?=
 =?us-ascii?Q?2eS9UAyCTLd+zMi8KYASwgSJAKpl+cWshzx0Xj9cNueFtAXbpq6l3iKjR+F1?=
 =?us-ascii?Q?eaVyMzCiRzdzKMZumakkuN/rsn2GONX1q90v2woxPSjSPLOI6Mh0Dxp9+X8y?=
 =?us-ascii?Q?zIOZLcpapo+YeUjZ7j13NOvlyqESyEnghJJJPEXo5RwNn9X/ixzRNzVfEhTA?=
 =?us-ascii?Q?RHuPAAy4RvQpbLSqoL/SrxIncarCOq0feY3gU1ZJ59PKB31bAXuv1dgW7zrd?=
 =?us-ascii?Q?OT8asenCmPoKcD7r51KvpxBpieibdQ+vJNmhyHe1/jmYuC2ILfYCmpr1Gwg7?=
 =?us-ascii?Q?NrgVU/CF/2/M97f8ZmB5chFV7bC8QZNhXQepv1xVLUYPSVBgLKKq1uf0ec7A?=
 =?us-ascii?Q?IiI0S1F1feLabmZ2VaUtJ6laMPrqNKbePZuMBwHWeaar57ESpTUN3emHG9cY?=
 =?us-ascii?Q?FFe6JXckUj2BdOh+GNG3fmo0AQCv9Gr2SQiU4ii5ERoWk2ODx+1xc8m6VUEk?=
 =?us-ascii?Q?4hCa7nRcz9ozamnpZdZsk+Rschiqc3qR32zIM2MIfcGbk0S+bo0U9FOoKkZe?=
 =?us-ascii?Q?lfrtKEgft2kRbXV7CkMmGVY/8RIvAASQnR6oNNo+zdNgVBOrhWhaM/6Zz7/3?=
 =?us-ascii?Q?jbV0td5HTFifv6qqiUHhB++RmhkwhSshRDZJ+qL96JK8BcIdXptXvJriet0j?=
 =?us-ascii?Q?Uq7Xy5+nQMmc7OIdcfI/bUF9IbmUJ47r9Z2GWVjVzZmv29yiEwnzxrh44TuN?=
 =?us-ascii?Q?G1zG5jzcOd4ZX/NpULXeO6TfsdYrb3hgM/2FQh11iWvP0LvUTp/FfhYn6OFi?=
 =?us-ascii?Q?hZ8JB/1QedK7SrmzDEXeR/rQhXPdsvge+RpqnbEf5BESLS38MKtXTr3nYEbk?=
 =?us-ascii?Q?v+qOYNRx99aIaZ5PKB+Gj8SumUiYdi9B6XsoD3TZ4ZeoDDihViL+ieyId6tG?=
 =?us-ascii?Q?FzEIBkuoPMhY86awUkSjyWdCHGO6AyaHatIsbAhz/o7gsZwm20a+UNKQqJju?=
 =?us-ascii?Q?j2/2OZQTAOogmrwandCOoMcxEwDjXN5ezreyGvKuW/baZk6SbecgaCl4pRBM?=
 =?us-ascii?Q?zJRO0uXM4GCofRlfhMKUR2WzvJY3kOHWTVYgP88EuWo3KWBuRD6PKSSPcr4x?=
 =?us-ascii?Q?ttN0/2g6sEVLJUBCkc9q/eWsDqvSCT4LWCBbLp7fjwJiQliM8BWjgdDgX9eY?=
 =?us-ascii?Q?eGTjMIejsh2N8j6YOq0f/p7McT7kmNFPNyMBcoh9+tS51OrrMegzNIjWZ+YL?=
 =?us-ascii?Q?kt2HbFxrDnTb8LAguG9bDtPgRY/a3UKGB1DrnMWXxFLPC2HF6leDPCvNXl92?=
 =?us-ascii?Q?xp/uryx8S7LR5cXLAWj8Xeu+26+KM9AGyEIiMFXDImhWgkbVhNa2qGtzax2M?=
 =?us-ascii?Q?yycniUadZXZqpPfgf6fpjkJyQh76OUhgZtCYhygXB4OyAystTSbCTmnvssU7?=
 =?us-ascii?Q?fz7qNQNEdr53/JdJMRaBkd2S2G0YK+0dItb+v8/oreZ4k2QXdPPDaNHHeSHO?=
 =?us-ascii?Q?ze2ClponKpa34nsEGNVYu3JkR9DJGePSWkQqerBQPAdmuwQ0Trgfzg2bmKGO?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NMqVmQmV7nWNX+CJ0Vc4/7QDO24Ogl4qrrWoOHTpOJ5AVA6jgNVEQYFfHLcN?=
 =?us-ascii?Q?5/H+wDMYpt5KO/nZjaWoprnNH32A3ikbih3qgKbxIHevIPa2iicInxmg5O55?=
 =?us-ascii?Q?HZDzRrMxP4pADFG0DfnjQLuxEH546xLCJrfMI6xexSJhbjYVvxSRAivKWJgj?=
 =?us-ascii?Q?dzTl5jGW+dT/iIGr5OI93xXOP0z3LIEDSTbvoNTz4n45YuygW0CB6Xqp5Xux?=
 =?us-ascii?Q?0zVAnaZNm76qM6xrvIpbsR3kHSp9UdWC6oXE/+eLK3qRFONXptRfyq7gbm1S?=
 =?us-ascii?Q?YNWgOZh4ITodgEztQ5GXLkmX4+VrBQ9aB/E6ToFXIyHup583tmPXYoYtGJ35?=
 =?us-ascii?Q?pmUfVDEHsGyEl831bp3ra7/PwAAeDG3WduYjIhdX4P6NhZuaqfeWh8jXzbYW?=
 =?us-ascii?Q?ZqrwFIOa4ZrI8+FiB+mbgLoyA22hkg4vOzw9ei4ue/0ewNRns7rKsLKH1/yx?=
 =?us-ascii?Q?FbWp+ru9HHmaWzH2eL76Jt1hyOZwPWiN/C2UmSdwLbEnQy7Ijpx4+RaJ59Pd?=
 =?us-ascii?Q?FxW+WSKrE4UliWSHquiOVvA4nn5kWIy0X8vbq2eMjSfcR2cfQAUZgFyTMZ3g?=
 =?us-ascii?Q?s8CUDWImSNmSp9Y35lIK1W7IcZFtYRq9i+zRBrlPTjhU3e7v2eZC2lvvWdpP?=
 =?us-ascii?Q?O8fseEFdgnw9VUwGeS8ghuwQzDnADvnOtjqsIgU/pheuJlCk0g7PiCNe1l/z?=
 =?us-ascii?Q?1BS8IJqpXJ2SwoukAMdTS8wRfcUuFP2ly86zk3IAafUJO4GQ2qD+58Clau33?=
 =?us-ascii?Q?v6PoNIuuv+wfEfL0MpBI25OQJzrZ7o1OQXn+4BXsoUMIbhhMuDXYjV8m/MgF?=
 =?us-ascii?Q?ZJuc8teoeK4TJqODObAAxhPi0YU06tDcFOWlRx7lPO4VyHdHVCzm1q2LIvsD?=
 =?us-ascii?Q?mIpobd0A5yiec28EyEOUyejxHx68NYnqhUCCroGcok3dwGEe3OqAgHUt9u8A?=
 =?us-ascii?Q?rt3/wmNKTs/RXfMIL2XOoiijPKgHuoyIhUQ9oKuxUdZgAHNRcZUzab8HRlth?=
 =?us-ascii?Q?dsZw4BVvkLC3sj4WGkwLLJeMCFwVVJa8TLI4betyYSTV0/n5ncwHT7GANrwW?=
 =?us-ascii?Q?kISlbCBOGRog2ib2yVulS6SjDnU6nw4/08ViYzm1LN829KcZQPxjnGuw5xSg?=
 =?us-ascii?Q?Dz8dcQeWDgI4LmXjyhLBgVxfu30xTorDKQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1bfad1-9327-42ad-67b9-08db19dde48c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 22:48:21.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VMoxTaADyKySFKvPlpI53iuCRXbnabhf3YlsM/rBSSnQ5Wz6Ci8ntCV6i99Su6JjfyqWtAAPwsbhVJgvS5pfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280184
X-Proofpoint-GUID: hEs6TrJ5jdfTAnNgG1AP-SQTJhqOxYw0
X-Proofpoint-ORIG-GUID: hEs6TrJ5jdfTAnNgG1AP-SQTJhqOxYw0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/23 00:27, James Houghton wrote:
> Fix how UFFDIO_CONTINUE and UFFDIO_WRITEPROTECT interact in these two
> ways:
>  - UFFDIO_WRITEPROTECT no longer prevents a high-granularity
>    UFFDIO_CONTINUE.
>  - UFFD-WP PTE markers installed with UFFDIO_WRITEPROTECT will be
>    properly propagated when high-granularily UFFDIO_CONTINUEs are
>    performed.
> 
> Note: UFFDIO_WRITEPROTECT is not yet permitted at PAGE_SIZE granularity.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 810c05feb41f..f74183acc521 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c

Seems relatively straight forward,

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> @@ -506,6 +506,30 @@ static bool has_same_uncharge_info(struct file_region *rg,
>  #endif
>  }
>  
> +static void hugetlb_install_markers_pmd(pmd_t *pmdp, pte_marker marker)
> +{
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PMD; ++i)
> +		/*
> +		 * WRITE_ONCE not needed because the pud hasn't been
> +		 * installed yet.
> +		 */
> +		pmdp[i] = __pmd(pte_val(make_pte_marker(marker)));
> +}
> +
> +static void hugetlb_install_markers_pte(pte_t *ptep, pte_marker marker)
> +{
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PTE; ++i)
> +		/*
> +		 * WRITE_ONCE not needed because the pmd hasn't been
> +		 * installed yet.
> +		 */
> +		ptep[i] = make_pte_marker(marker);
> +}
> +
>  /*
>   * hugetlb_alloc_pmd -- Allocate or find a PMD beneath a PUD-level hpte.
>   *
> @@ -528,23 +552,32 @@ pmd_t *hugetlb_alloc_pmd(struct mm_struct *mm, struct hugetlb_pte *hpte,
>  	pmd_t *new;
>  	pud_t *pudp;
>  	pud_t pud;
> +	bool is_marker;
> +	pte_marker marker;
>  
>  	if (hpte->level != HUGETLB_LEVEL_PUD)
>  		return ERR_PTR(-EINVAL);
>  
>  	pudp = (pud_t *)hpte->ptep;
>  retry:
> +	is_marker = false;
>  	pud = READ_ONCE(*pudp);
>  	if (likely(pud_present(pud)))
>  		return unlikely(pud_leaf(pud))
>  			? ERR_PTR(-EEXIST)
>  			: pmd_offset(pudp, addr);
> -	else if (!pud_none(pud))
> +	else if (!pud_none(pud)) {
>  		/*
> -		 * Not present and not none means that a swap entry lives here,
> -		 * and we can't get rid of it.
> +		 * Not present and not none means that a swap entry lives here.
> +		 * If it's a PTE marker, we can deal with it. If it's another
> +		 * swap entry, we don't attempt to split it.
>  		 */
> -		return ERR_PTR(-EEXIST);
> +		is_marker = is_pte_marker(__pte(pud_val(pud)));
> +		if (!is_marker)
> +			return ERR_PTR(-EEXIST);
> +
> +		marker = pte_marker_get(pte_to_swp_entry(__pte(pud_val(pud))));
> +	}
>  
>  	new = pmd_alloc_one(mm, addr);
>  	if (!new)
> @@ -557,6 +590,13 @@ pmd_t *hugetlb_alloc_pmd(struct mm_struct *mm, struct hugetlb_pte *hpte,
>  		goto retry;
>  	}
>  
> +	/*
> +	 * Install markers before PUD to avoid races with other
> +	 * page tables walks.
> +	 */
> +	if (is_marker)
> +		hugetlb_install_markers_pmd(new, marker);
> +
>  	mm_inc_nr_pmds(mm);
>  	smp_wmb(); /* See comment in pmd_install() */
>  	pud_populate(mm, pudp, new);
> @@ -576,23 +616,32 @@ pte_t *hugetlb_alloc_pte(struct mm_struct *mm, struct hugetlb_pte *hpte,
>  	pgtable_t new;
>  	pmd_t *pmdp;
>  	pmd_t pmd;
> +	bool is_marker;
> +	pte_marker marker;
>  
>  	if (hpte->level != HUGETLB_LEVEL_PMD)
>  		return ERR_PTR(-EINVAL);
>  
>  	pmdp = (pmd_t *)hpte->ptep;
>  retry:
> +	is_marker = false;
>  	pmd = READ_ONCE(*pmdp);
>  	if (likely(pmd_present(pmd)))
>  		return unlikely(pmd_leaf(pmd))
>  			? ERR_PTR(-EEXIST)
>  			: pte_offset_kernel(pmdp, addr);
> -	else if (!pmd_none(pmd))
> +	else if (!pmd_none(pmd)) {
>  		/*
> -		 * Not present and not none means that a swap entry lives here,
> -		 * and we can't get rid of it.
> +		 * Not present and not none means that a swap entry lives here.
> +		 * If it's a PTE marker, we can deal with it. If it's another
> +		 * swap entry, we don't attempt to split it.
>  		 */
> -		return ERR_PTR(-EEXIST);
> +		is_marker = is_pte_marker(__pte(pmd_val(pmd)));
> +		if (!is_marker)
> +			return ERR_PTR(-EEXIST);
> +
> +		marker = pte_marker_get(pte_to_swp_entry(__pte(pmd_val(pmd))));
> +	}
>  
>  	/*
>  	 * With CONFIG_HIGHPTE, calling `pte_alloc_one` directly may result
> @@ -613,6 +662,9 @@ pte_t *hugetlb_alloc_pte(struct mm_struct *mm, struct hugetlb_pte *hpte,
>  		goto retry;
>  	}
>  
> +	if (is_marker)
> +		hugetlb_install_markers_pte(page_address(new), marker);
> +
>  	mm_inc_nr_ptes(mm);
>  	smp_wmb(); /* See comment in pmd_install() */
>  	pmd_populate(mm, pmdp, new);
> @@ -7384,7 +7436,12 @@ static int __hugetlb_hgm_walk(struct mm_struct *mm, struct vm_area_struct *vma,
>  		if (!pte_present(pte)) {
>  			if (!alloc)
>  				return 0;
> -			if (unlikely(!huge_pte_none(pte)))
> +			/*
> +			 * In hugetlb_alloc_pmd and hugetlb_alloc_pte,
> +			 * we split PTE markers, so we can tolerate
> +			 * PTE markers here.
> +			 */
> +			if (unlikely(!huge_pte_none_mostly(pte)))
>  				return -EEXIST;
>  		} else if (hugetlb_pte_present_leaf(hpte, pte))
>  			return 0;
> -- 
> 2.39.2.637.g21b0678d19-goog
> 
