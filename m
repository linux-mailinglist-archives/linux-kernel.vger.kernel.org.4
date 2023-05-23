Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84D70E441
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbjEWR4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbjEWR4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:56:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690F5119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:56:02 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHtiqO003481;
        Tue, 23 May 2023 17:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=JPqBRTwMF5K9fet2RVsP7VHwBwl5+3VWF2K7lUEEQSk=;
 b=PPJjLqLTx9+yRi5LD23rdHP7y3oE7xOZFVaMWfqGOrtzPmqsMOmiCognJvEi1FW+/Z7l
 37jBFVtVv5gpSD3O40DeXAzCu89WxUdPZ3UIUVxwhmLwEX9E882yLEBeKw6x4j4ChhOi
 P0s9Q3j0e/mtoR6zGiPSGKfXD9dqfPdF1ZTE35BsvIzu5vLwXGvG/8XeVzhplYtxu5sE
 H/kjhT7HiX4Qy1YRhETH2Dmyy6KUMabcMSL7sHCScY/O8cj7Tc24jgnBxPZQmXN5vEMn
 uvgGC31e2ugJlyimwWIHfRrTl0nCw0ET2Kwcrp7fKTjGF1W5wOUR7JUiTGrL18AQmmaE zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp5bntjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:55:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHNKcL028926;
        Tue, 23 May 2023 17:55:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2b6bux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:55:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlpXQFpe/muFnPzPYWMXOdXKpDybdG6wgMJzBaUNH8bK5YuZw0W2PeEMnBYuMQenAF2GlSlsPGafbOBAxABHpdhElLki1WfKONhDL6vCmdqxSMI8PhzlolgYxBHgxX3yEHoKE2B7SqfprHDh0Ws+FLPj3DIg0VOic6QGpQUx87HD7bkrI11OYSxHzUaHaRok051dqW7A+zfOroqu9SbfI0rI0EmCgwu5rOdgAiD0OhD/BnEhTdZLXAs9kOVYIBBw54I31JWA97gRT8yWr5WQ9sK59VwrWzZKcXRU6ixe+jwHtfeLxUgqPD24fFRCIAyUPnMd/vqeLlAWNnZaE3CzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPqBRTwMF5K9fet2RVsP7VHwBwl5+3VWF2K7lUEEQSk=;
 b=FPWN/nuv8Ry9IvYOCdNrIi5UF7AtlDM67EbjAVi9aezf4Fkq6ufu0EFLjWjVKKfjJ0BgTXHtTtISN9pnthIMlYVaBqLRA3PDEedHAC42LjK8PMmAkStfezprajepnzF8V8w/55lS9ffQhJrGOgIYFa4ADosy1Aqb212/PCG2JJnAlpotI5ltSLA5yVb2GpbuuVVTRTmGKrXwbOpWG0AG8zsEAPB4CJcbTXc4Uv+ZZcM5jcP4IQH0FeinKEmlrPK8ygRE4vbIRXwhwQlej341v/+eAj3klUIQYAUVH6vBNAClDDLUvxgzF4eyjQQoLX2xzVvoBydJluAO6mUZV/9axw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPqBRTwMF5K9fet2RVsP7VHwBwl5+3VWF2K7lUEEQSk=;
 b=Rzq1GzMAZc7QaGao6KuwVLx97mh40RFA3cTzAqN3YNOMLIqTeEsPkY6hNPqvchneQjhMa3LWNsDeaaOplRrZULujPz0k+Y+yACnwHb6cbYaig34bhRHpX38QidAzLQP9G5ssbwWU22kFSk0cd63Ulv7HB9EdglXXLQkporV//Tg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 17:55:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 17:55:41 +0000
Date:   Tue, 23 May 2023 13:55:38 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 07/10] maple_tree: Add comments and some minor
 cleanups to mas_wr_append()
Message-ID: <20230523175538.etpthyoq3oqtslbo@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
 <20230522050656.96215-8-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522050656.96215-8-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: d7524661-c981-4a8a-bff5-08db5bb6ec2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjQQ3BjR+fm2gbD9AdDOiuat8iuFZMLheKjCmHSxWsDZFISjSYP5wsRwXWqb2HCN7pBx+8cGbe0JDRVf03eH2ymhNrdsD8LbIqcEI/mjSpKNPEJeYVo+c827FAY01M9vOeM17alSqdA3z+oU2rL1J7HeYpul4T7BdMFX5lsQqqp3XukGn8fOSeFLEkXpxVzrlv34Riek0LTbn8TlxQsUeF/BD+rJ210NgNhophC9F3mAgJeFb7csh/b0PHsK9gIfW/bN/SHOImo5sraJIr2ZAwfeabr4Rpv/qLZ7nfirpNhZpL6UXBlIDbeDglGXA466GU/0CzRVlh/kzC+JYkqcrR+xjfTK25XZ14A5xq2cedcr5wqLh+UuqwwGJU/YpFA6mOmPDZtnN3SRNEvmAWuQKUHy4Pc1y1wZA/qVmh5bYm46o9yZadMb0DGbHW4Jk55RA53R5fs8Zf9GaYeBr560qYACtW224Swj3YW+3Cou0GkqUZzv7AQkksaBSlkEY9ijoScIFo/Fto1fycU0cFKw3aChOGIj96JUjsFoYJM+wTcfQxe9c5T0SE0zHCFgYDJC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(2906002)(5660300002)(8676002)(8936002)(41300700001)(316002)(66556008)(66476007)(66946007)(4326008)(478600001)(6916009)(6486002)(6666004)(6512007)(6506007)(1076003)(9686003)(26005)(38100700002)(86362001)(33716001)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D/yu6ngORBZ/Z6M/3d1hh+qbWKxxYu5MGZnGF6pW5UBPEbM2ajeZtUktH7nk?=
 =?us-ascii?Q?eybiLCDqyuD9MeGimY1oNWGSQceq77HGBhJLGJWs3z/HR6HvFuinkwDm3stP?=
 =?us-ascii?Q?ChkmdNVl8XJUjXCd3BCXOszemTLoTmdtwYhGznXz1Z6OLGR6Z8q8ozKdNHmb?=
 =?us-ascii?Q?K0imoGv0fXR/E6qtI8Q+rX9DlPUV1eTHbPPB0NdK1DwC5IO/9kLWHmvtzfcQ?=
 =?us-ascii?Q?XMmmcBzRnJdHjCiUHvNwa9iV2GZbL3kDaqTQ7/+Yl2QIOF30ykaJT4Zryrmy?=
 =?us-ascii?Q?t5E+G/tpaI3kJVJxT6UpOOhbqH8JbXAUqx1q5xHVoKP9mnBNy/+ddbnXSN63?=
 =?us-ascii?Q?Jk1vG0hzd3obm9qPaqrvphspIkU0fYxiOv/WNlTTXL7mFnSszsgiHZBIZ831?=
 =?us-ascii?Q?WmaNBWsF2jckpXZk5N0Jucs2LbaNaD3ldLnRkQtv1ZDhHpZWbq6IXpOfGZg7?=
 =?us-ascii?Q?qHOvNx7MeVFjEeH/RS0cr3/wfpq6QEIva9Q2IimFb0m58uOtmJARV5QxqXBR?=
 =?us-ascii?Q?Or9m8kLphRRr0KX/1vNHukUdKBggdZFCi74racgW6+B2azZ4tVe8QHorNZTz?=
 =?us-ascii?Q?igwqWRVZgi1HY1788bwzLxO6KysJhEciHRjQMKRlDH+1Sv+BN0S83rrZWs2K?=
 =?us-ascii?Q?K8NTSO9LyUCe34v/6P8PSvPch0umipTHbNgFqjcEpDKANovdWN4bVJIFUoBU?=
 =?us-ascii?Q?+3S/1bWw0hhMVAVZ8eHwvJfhwnUcZW3Iy4TzBYSBomMu4gnlp3oVAWzmwYai?=
 =?us-ascii?Q?hYk3SGV5PxT1CnCdfI+gnkOVgVSPHa8FJVw8Zf0NjJBhh0GFViIk2+paar8x?=
 =?us-ascii?Q?dYH8uRi4qFsRzkpeCv2hO0ov2WfcGCKveJdB6iod1lTTM1R79KLoygsR+NYw?=
 =?us-ascii?Q?u2x6ZMXN0zI09nez2HqhPNcnl4O5bEWT3H/pMb4MaXFOh8baheJCI5y+eXj4?=
 =?us-ascii?Q?HocjvEnxIMB1nXGLMqap9kzgqhNrsQnlQ1/iKUeCFLIb78JJ8wse1iqWNVAS?=
 =?us-ascii?Q?wiVL5bknm8Z2JXjLe8nPnkyqPZFPek14wS0JuwIHvBF4zTw8PoH5Y0c8hOsY?=
 =?us-ascii?Q?Ii2HBIDSeFeGcZWXZG3z51ZcZ0X8lt+SHVs35xe3DpER1yG9l7EnFpg+j/Nm?=
 =?us-ascii?Q?vs8nsD7LVzePt6mFpRXD5tGJ/tnCt/R1Ai1dFbAGIydoZ4044PwK3Ba9Da5U?=
 =?us-ascii?Q?lUnPfisO4EbihqJ8UNyH4eBCt3Est/2lb3IBLnkKTDtz6FLBmEwtSTVfvsmF?=
 =?us-ascii?Q?sjMW3+IXUcGJHsDRqCKNHvLgY8UMSKk2zpGFxxQ0qartQSpXipMiovlA/F7I?=
 =?us-ascii?Q?e6eNfkaep75960knPNZ17MCkvzpMCJo/bbsJqLJH4Wxd936nybHZGpasliYD?=
 =?us-ascii?Q?rI8S+LQHIXoD1AZtLMSlVrrVLYxapndC+XV9lsS0FQwjKsWWf+n36pxd3VdL?=
 =?us-ascii?Q?uhoC/IUflXplhFXcGWIP8oHXvC3YyeOAHRJzLV4LbdaiVlv1XGOq/dcb4jDP?=
 =?us-ascii?Q?TQhceyrOCNXsipirL/tJOic0DDuAr2zusgQwRktEGW4zEortiG6nmKtyILva?=
 =?us-ascii?Q?HuH/3jPGNmUYUEgk0kc1wZMc0F1Se9X33UsVtmE0Jt6S55cAz8gY/sY3Jzps?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dJdq9Ijlo1+9hO1el1oJ+Q9tlVjS1Q061BcDHS0zws9cZim4HcBTQnolYIU7?=
 =?us-ascii?Q?Y6tg+llQnMu2+Yz3UfCEq8SOwlzHwCLPw0ZVyWWpSL8zzWS/V7Aqu2Ir+Ddx?=
 =?us-ascii?Q?pkPa74M8nx6fYsHOdXvXb3l5Z8vULjNLr0D8bFMmAojzY31rosUG8sVJ+QDd?=
 =?us-ascii?Q?K6TMZ8jy2pxvkx2PjGhNc7h4TTHI7Y0nx8Y3aB5V5mIzHFU7j9s8M5cWA9dK?=
 =?us-ascii?Q?4OLZlmO7GieuAlhSmAcUJ2YExX+nBsgucwbNXwE2DPfFbVkS7dbOHTHvaPqt?=
 =?us-ascii?Q?tEmMHr943CwYSm456N8gMqge3CxYgetF0FJ4+aQX/aTWt/N/tx+RyOydrs2R?=
 =?us-ascii?Q?4fPPAytJhuDNtc37rHKvOIi/istgam/9toVBV3lzqQpsAkF1WnBf0/1zuBph?=
 =?us-ascii?Q?66ut/LdYy5HSyUJ6zuZUKm1OPlnozxWEa8NWI1DAtg1ntk7Qwv9qVATJcyEs?=
 =?us-ascii?Q?PJ1FMSOPojNMgxADvyxc+st/I4mJf5N4sRubAwiN6fNb0KzUn0pXk57J8ZS6?=
 =?us-ascii?Q?S75CNX5/zIMfOD/hgqIawaWuoiCmV+ZIUg4O/JQsmvAOq082NSKEPkNAubpV?=
 =?us-ascii?Q?fTe0uBNRb0eDyJAvKgQAhdSJiNIrMX4+y/jlAszwIUMFnJ043c2F+8smFxyB?=
 =?us-ascii?Q?3h9X9xWtqT8qcdNGCkBGtxkONcLr3poPx4M2TJ7JXm7Gq5yzhNlMSiYSDUvk?=
 =?us-ascii?Q?ho7L7rNewm2suI3Bap9X6Tp7rZ5lDfHVkL8JgXJjik4m+hcikeSnQ9IkeNds?=
 =?us-ascii?Q?6gcwD1aL0QQ7ra+5PKZKQ6maEF7c8xLWimiCu1YxO/pS1QH9oY6J90+PI9bR?=
 =?us-ascii?Q?SzI+gJb31S3ePdULmJX6kPKSUlWGJWFX/bou0ojZiRG2JUJqi/lIEB0rcCRj?=
 =?us-ascii?Q?lru/3O+9VGjErMXyWXR54SGRwitUwG5bm0ONNUd0GgGF1fILcnuz0znAzSgw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7524661-c981-4a8a-bff5-08db5bb6ec2b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 17:55:40.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3AemTqvoAFf4gtm4OxchD0Q/LhaVnUpI0WssSJdjFCGudmnS75b5JlL0Qx1uNr+TKQlA/SnDDZMxAAmqn4aGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_11,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230144
X-Proofpoint-GUID: SQVt8MfREvyAUmUVlbsTpM7yTqvTC2UW
X-Proofpoint-ORIG-GUID: SQVt8MfREvyAUmUVlbsTpM7yTqvTC2UW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230522 01:07]:
> Add comment for mas_wr_append(), move mas_update_gap() into
> mas_wr_append(), and other cleanups to make mas_wr_modify() cleaner.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 47 +++++++++++++++++++++++------------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 0550a07355d7..afbfdcdde5db 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4312,6 +4312,12 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
>  	return new_end;
>  }
>  
> +/*
> + * mas_wr_append: Attempt to append
> + * @wr_mas: the maple write state
> + *
> + * Return: True if appended, false otherwise
> + */
>  static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>  {
>  	unsigned char end = wr_mas->node_end;
> @@ -4319,34 +4325,30 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>  	struct ma_state *mas = wr_mas->mas;
>  	unsigned char node_pivots = mt_pivots[wr_mas->type];
>  
> -	if ((mas->index != wr_mas->r_min) && (mas->last == wr_mas->r_max)) {
> -		if (new_end < node_pivots)
> -			wr_mas->pivots[new_end] = wr_mas->pivots[end];
> +	if (mas->offset != wr_mas->node_end)
> +		return false;
>  
> -		if (new_end < node_pivots)
> -			ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
> +	if (new_end < node_pivots) {
> +		wr_mas->pivots[new_end] = wr_mas->pivots[end];
> +		ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
> +	}
>  
> +	if (mas->last == wr_mas->r_max) {
> +		/* Append to end of range */
>  		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->entry);
> -		mas->offset = new_end;
>  		wr_mas->pivots[end] = mas->index - 1;
> -
> -		return true;
> -	}
> -
> -	if ((mas->index == wr_mas->r_min) && (mas->last < wr_mas->r_max)) {
> -		if (new_end < node_pivots)
> -			wr_mas->pivots[new_end] = wr_mas->pivots[end];
> -
> +		mas->offset = new_end;
> +	} else {
> +		/* Append to start of range */
>  		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->content);
> -		if (new_end < node_pivots)
> -			ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
> -
>  		wr_mas->pivots[end] = mas->last;
>  		rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
> -		return true;
>  	}
>  
> -	return false;
> +	if (!wr_mas->content || !wr_mas->entry)
> +		mas_update_gap(mas);
> +
> +	return  true;
>  }
>  
>  /*
> @@ -4386,12 +4388,9 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  	if (new_end >= mt_slots[wr_mas->type])
>  		goto slow_path;
>  
> -	if (wr_mas->entry && (wr_mas->node_end < mt_slots[wr_mas->type] - 1) &&
> -	    (mas->offset == wr_mas->node_end) && mas_wr_append(wr_mas)) {
> -		if (!wr_mas->content || !wr_mas->entry)
> -			mas_update_gap(mas);
> +	/* Attempt to append */
> +	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
>  		return;
> -	}
>  
>  	if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
>  		return;
> -- 
> 2.20.1
> 
