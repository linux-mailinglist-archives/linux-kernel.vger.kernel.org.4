Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1082F634DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbiKWCYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbiKWCYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:24:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D70DB85E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 18:23:54 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AN26wBa029814;
        Wed, 23 Nov 2022 02:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=t3ZJaQkZqhxEdczvibdXSDnCvGsj1Mj6fcFADJSKbBs=;
 b=JX/oLvZxnh4ckWoxEyXLOdGv+/95IvVbq0JGjifMxG0RDFVNYPKkHTkYVrYiaxLQPlW9
 /h82DOgkdwmlobIfGARabN4bA+v3Ydy3UPTxmGaBIychbjTWNV6MMJKKj0qvWmBSqRuC
 4DAa0395endmLB5LZTwkuixzFS5UDDRiR/tJbLdCR/y/ioHpHmqSxP1CVyAHbQlzMfBA
 DYYbimMGWwJ3SWX5WXK9qKGiCZtpmguZiz/jC0gg6M2CiNIxWvYDp5rvn/2e9izBLaV0
 QeZswXdBj0RG98KW4td5/elwU7pUxfwNeO/AKkKASCSL4G5p78VHDPwSdDjjbsEx7ZlI 7A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m15ww0hfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 02:21:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AN0Us6W002229;
        Wed, 23 Nov 2022 02:21:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkd1ggb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 02:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUEcxkDBLVVOQ7Di73q/KYA/KGWTnFfQO37+6+ZVVcUZ0Q+FehdEebit4Ga+T4Jt/X2JX3QOEYvf1ovxaq9sWOun4qQ9aIpF93Lp+Sgn+agYfJy6fGKunLMJe4NoWffB6ViD8AbCboyx8DgCNBthnRLwQ5wLbLBia5h3cjdNKUa0n9/SHFYuNa+QGJfuJ/rzCOrBfMla48F1d9n6jjUlOO/z0M2HkwfwaaYlGNMvT+ba0lsbJeMTiu+G/Boi8Jbqzwtz+BikmPoLxIar2ewebG3mQ+ZmO8Tk/2ZcGVMDCzIJa2ZphYmKZZIGwyKZfHqVBf5BEytWi2ifJN8GT2gU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3ZJaQkZqhxEdczvibdXSDnCvGsj1Mj6fcFADJSKbBs=;
 b=CnOph7eZG3fgjgDE69LGbuLBHCa9l/RXgT8PshiSWM6d6C+bkDe3Awy6AuraJjR6DtBC6kZxIQcB823kh5BlSip4AJ296Z7gaFWoHJG2x0P6vPnylmi+9QYoRbemmN3Dr6XcZq4TjAccpOe/adO8sxIuTHeiY5Ev/SvsEUij//2FCAeZDT+ldYwuc1fsOejWrsPEbngGFQFHjRdy0O28W4eAUUZQ3hA1UeGYcWRjmLTv4T0lXgOe0r/8R4kbBSodcp34+3GFl62ECWdiash/7QHIih8ijm6sNHhTCMPyXAj6TBDXhYsm9ZcrlabVNYyMVyfk/2irft8bh6ha4Eo5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3ZJaQkZqhxEdczvibdXSDnCvGsj1Mj6fcFADJSKbBs=;
 b=Qh2yjHgODyMbD5YdGb9NNUPReTmvuaZzOzxYdf7whmZFwk5HRbHGDXZRPxmH3GSQgOaUIydqK43+/MywqJSkqq3IuVHaLlAKmfUDZhCDlEbVElLoBSl4N9LQ7jjGwRGeCqqoP6fOe64IrCnl7DxBY4h3DFPnun1vJdtBmXcgJI4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA0PR10MB6915.namprd10.prod.outlook.com (2603:10b6:208:431::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 02:21:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 02:21:30 +0000
Date:   Tue, 22 Nov 2022 18:21:27 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v10 0/3] fix hugetlb MADV_DONTNEED vma_lock handling
Message-ID: <Y32DpyzMmwzwG5Ak@monkey>
References: <20221114235507.294320-1-mike.kravetz@oracle.com>
 <20221122180755.86a7a0b68932226b7d40dad6@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122180755.86a7a0b68932226b7d40dad6@linux-foundation.org>
X-ClientProxiedBy: MW4PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:303:b4::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA0PR10MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 08de9202-c874-4c93-a792-08daccf96ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2MzxrkvuJl8Gccl5pZjAebtN1+OF8BDHS3z4HHNkLcm5KeHZZujHStk8vgptIPry6I/Z+JsHFr5VR1RsjM2A+4A6mh3/KmkYHwA0L52q4pweFkxPqe9STxP8yjHlPZ4Rk5qhFQkrZsM/dkSgLtNTw2PuQO4uw3bPXbajS4Mh+WFbs1hYfHmP14mf/PP0zIP4o71Pe1AVZhmh9BmrguuDihAzUSmmx3uB6yLSSNL/7m6E5wq16mjzc4MvXQhaBL6o3XhgickgX2za7sFVZDCRlYBje7EEkWy50gsjQPiKz1Cv0HlQjcjoiJ60xYYOOpEUZtB7ZndTHfD1ftCUTCES0u1OckOs6IIjlBO+Pnxp7/IrE0K2B9LYzVO1bQX09U/gwl9mzPRb0FPWapI2MvCohLEUafoduHr2YahUn1YV49AZu5L1PJNFK+yrb5Si01mlh8iWt91fmCyt/jUhLVAtbJe+tGoonox0VBP/5ruJji/0X43NehQOahwBaFMFoYQDTdCkZpLhobn4QPFPqIBbYgeiCiOsEx7v0pZSXUCcptZ8KhlxTg9fcHLLnly/JYgNdB6eSZv/PSqe42BVxxu0TFcm4CzahjTXy2E4B9gF8DdoVxtA/nB94cOL3gCt5UnI7c3ORHOkkWA9xfVH4Wjb3L+F27PTWA1R4c7JU9SsDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199015)(2906002)(86362001)(4744005)(478600001)(316002)(186003)(6506007)(44832011)(966005)(6512007)(9686003)(8936002)(5660300002)(6486002)(53546011)(26005)(7416002)(4326008)(66476007)(8676002)(66556008)(66946007)(38100700002)(6916009)(33716001)(54906003)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s10zkX2he8QRjsC98sN6Lp/N9iyWO8u8lbSwn98LHy3ekS0fyGmz7/oDznYM?=
 =?us-ascii?Q?l6DWKI+G+9A+Yc4GWKrEsu2dr+9KzTXF1S1tbtHevkXlad4CtTMxkHO5RiM4?=
 =?us-ascii?Q?8WPur/mw6yL91U4rGmtrXUrniAUXoEnfdTpt/xtBcQ/ly7CUbpUmnGXfgAGn?=
 =?us-ascii?Q?suOOmFkPPkCG2cFPoJPvciJItYhJ1yMz6nBBLgkEohDOfw5kswWJHO3rDiCR?=
 =?us-ascii?Q?LXkE1sI9+faH57omUE0XtZgiGMMRrAWeMQMKTAUzuM7jbc9KRg3KcAVokd3q?=
 =?us-ascii?Q?wd6ptsQx3LJ31U9NL07HMYsXKcSC9nh8lwPFPirxFmt2PAwBF3EalMOtIZWk?=
 =?us-ascii?Q?i8kWI5kL9b0RFViKFlMP0AtVstE2POuhECEpRBvd5gAwx2ls9/mbpajcDHxA?=
 =?us-ascii?Q?K8TpjQjNkF4WSMXN9+VCI36AGys3s5ihwiPLmh9VH9XLvXJMcy3Kb5zn2dOb?=
 =?us-ascii?Q?ZseGnpl9AQli9MWIkpaUkWYFXe+Yfx96tUOWqvGJdamKjYrrJpVx5dHF4QKZ?=
 =?us-ascii?Q?8vjfXK5MfCANay8rpag3pxoV7o8E65ruNVn/p/sWU2lladUbK+ClLwq8rXfO?=
 =?us-ascii?Q?hh9xP8PHiNilhQuWWLL/w9afOo6sC0WC4EBfk+jCzDO5VvQFZCzLyiDzqssj?=
 =?us-ascii?Q?rhc5fdLNNLDe4zQbtH59B/Wp+oyd3wj+Qsx9PQOdAcWqxHHLs4rAAy76SB+2?=
 =?us-ascii?Q?duz9zmBHpXC6ddgxM+f+6HXy8i0e8TGIZ9DhcF66yrTjpRPH4AN5fH1t3ijp?=
 =?us-ascii?Q?iafThhZmi8Yx6EXREv1hGC9oRXmZAZr5CAFtKICYs3oKU4G5QboNlIxJ4gkL?=
 =?us-ascii?Q?4SO1go+Dq+Eq1c3ieirug3XUStb/gK8zfP2kfZzcqoK5vLzMBGFDJ4MBwVq7?=
 =?us-ascii?Q?IWSPGSltUEuiCiXIX/TzamXuVTDMMssuD0DYV5ZDeV4bZHF8CrbcZzdWx9tU?=
 =?us-ascii?Q?MqjPC69YQHzLIzrakxGTilXTkaxZCm3nOesusZqj9mFgd6DvdA4/BZlY+Awt?=
 =?us-ascii?Q?IzYW5cWluOGoBAG35IvIc6D298EElvXqZYnt/KDDabucZOf364+H5CT27d2d?=
 =?us-ascii?Q?x1Y01BFQwuqm1dbVtfkNgEB2usMQuXOSCQESUlWze1QPZY9bLVgjhCNshBPu?=
 =?us-ascii?Q?015Cx0N/WljRYkNKSwUIiHeT5JxCtIThM7IXFQiTMzrQJcNrxYRFblNus8t/?=
 =?us-ascii?Q?ASjeP2JNbfsq0AZZIITsE4+8yu2uAq32A6lHfjaxyz2gNilsXR74SE27u5mg?=
 =?us-ascii?Q?YWMK6/MTYnW6tUajgN31TMCh8UwUSyy8lk5baM2EwgxL/hwrIpZLLO/2Z1DW?=
 =?us-ascii?Q?bEOX/TQowOW9erXZhDqSvD0cgglKo8ghvPj+qjHJKliTQ1q+fUEIsqeJcBJd?=
 =?us-ascii?Q?zb9J20r6WzIAYIoKysUhETR2w8vO3hSsNL9D+G7GDwLxMTiHybWMnT02Q2/3?=
 =?us-ascii?Q?L0pCaNSHcbYXaLNCQBYdIORYzLeCnM1F4V9YRCL/WN+F/NaXJHTETY05XeUz?=
 =?us-ascii?Q?lb5AdFDv7vknGk1fuHjMyCBMBtf7hi8JPKFY4o9njiwgaXkrU/dHHpncc2uB?=
 =?us-ascii?Q?IzjhlBrzLf/qVyVsyQSmlr1zhP7micjbwqj+tzp+jdMSKjP5xiKJnjdqu8ED?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?cPqRHsVtQLRzoS4EDnKwPNndUaJPr3F+66nvjdVkc0XtdHdfEQYMPDMbVtzI?=
 =?us-ascii?Q?Ua06ZEm287rQScuIW5s7HKRwM/Q8DS+NE7BStZ6knyThrJ+C1NVWK6JrPu3Z?=
 =?us-ascii?Q?h7oIdrhUBM8sSiPjxQUwn/frEQTutIosWA1g+CPsC1Cy4LNf9vSzv9ZiC+Ma?=
 =?us-ascii?Q?zOarhR0u2YweSdq2aArdg6U2HAU5SHaRWYHlDjFNJ3ExM3oiVM1/5eIRop7j?=
 =?us-ascii?Q?9YMhTc14WQdRX3AS/pqPxRy4B1rnN6oqVQHIbdGrCiDcHpiPBs6Bm36zdfL8?=
 =?us-ascii?Q?E28derOYwkP3ojy7Bphy8KlbGkP2dsxDlwvdC6ACMD8fS4qViuE9GTxnhFUE?=
 =?us-ascii?Q?P3LE7bPMs+6jOWudu9UnGGV/TPaTsmQpNF5QyUhhpuhxbe+yscm3pdwm1PrL?=
 =?us-ascii?Q?Ujm65bqQ+4n2o7LB6AabJbh1D08gn03aL2AOKCYwYJPVjDtp4TSgBGU3Leoq?=
 =?us-ascii?Q?afoUQD/ETYFEtzHqwv/w/V8jYET3pX9BqTZwhpXrYmxCoyo06n4CMz/4YR9z?=
 =?us-ascii?Q?1CFUdc1UWB7+vp6xTSpgzF4kEgDXt9mn+8MQysYomHsc6tNNS9qgBvDiKDrj?=
 =?us-ascii?Q?i/nmn3ihfYc2EiXF+fTbwJepBgrO6eXG4uunxIHWaAkOcOmdqIuqWiBj49LS?=
 =?us-ascii?Q?ii57Qjkm/arP+f7w5cEn9Mxmqti09eESyaSSy1UuhZkyWygMA47Q7QouFKTY?=
 =?us-ascii?Q?h8nQ/GXB6xItIeuHYxUvOWvAiwGm96g3rUILtIqTCFwrlLAUJmYmCOQOHts2?=
 =?us-ascii?Q?iml0HFx9lVxQSSl2QYMJWwKtQxHPMTQLsCyJWt26EJR0+khru/9w39K23Nxl?=
 =?us-ascii?Q?5vZ//8jzcuSP1eBU0LCLub47ZFIbETBsVfZnjrcv2i3X03W2zhWMg9ODZnzX?=
 =?us-ascii?Q?2qUKpQ5loZvMhDEQ/5l8gsNZSi74Hj+PFiSMIjEazLm0QDeAcdYtwY6X8OJx?=
 =?us-ascii?Q?mpA1N9bgYJPgwgIvsNeR8LF+6Zb05ZPRSeOzCRlkEsyjGe4U12YLYNP5FKfi?=
 =?us-ascii?Q?4xUk2HGG9QgsNn1sTsCB4EL3tU2EhN9zZnnvXbM4aD6XA0CpuOjzEqxn7mpe?=
 =?us-ascii?Q?YwXsgk5B/+1nmyFhxKK+/s4+tZpEXRqFejPDVLPCe7dthnmxdXA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08de9202-c874-4c93-a792-08daccf96ed6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 02:21:30.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvRi9YCXHQOYeGmHJd3qZHpSY+J0v0jbwp7j03Q55eACOzihkUAuY5zpnSNGmTVmtz/J75TAlw43Sw7Ikpo9Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230015
X-Proofpoint-GUID: De-HcySemg3MKl6Fft8GQGaD3jJgrMfm
X-Proofpoint-ORIG-GUID: De-HcySemg3MKl6Fft8GQGaD3jJgrMfm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 18:07, Andrew Morton wrote:
> Could this series be implicated in
> https://lkml.kernel.org/r/00000000000041a69905edf8c1e3@google.com?

If I am reading the report correctly, I would say that this series (at least
the first two patches) would address that issue.  The bot is running against
6.1-rcX and those patches have not yet been sent to the 6.1 stream.
-- 
Mike Kravetz
