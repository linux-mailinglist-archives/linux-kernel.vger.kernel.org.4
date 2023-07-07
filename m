Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427F174B2E1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjGGOOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjGGOOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:14:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04CD1B6;
        Fri,  7 Jul 2023 07:14:37 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367Cx7iZ028459;
        Fri, 7 Jul 2023 14:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=4inM93zbVDqaoOALbgtDff3iGmFaG/2nvyzPKWSQfUo=;
 b=DDMbTz5V5Ruw9+Il234nPh6sSIQmj8Qyb4rEFqKiVIKmtOH+NpjCJNrdL3oPjHanfN6b
 sGrKKfvfWEWHzl0Kjnoc6HdUbf4uTSwotN4w6AOV+pcAOrgZZeTrRB/wzcnGY73BR9sg
 hLUDGxpia2HWEuCb4Fpc8/jsnqsLl0IgNdu6tukT0OTITS7FLpz+6OoL1bT8k5YpeYL5
 +4gU5TXGupYR74fe7QW4EMYgMZky175xMF/pvzOggRW2CdqsHzvP6QwS40szXteXVVmm
 OJyq4vxSHKjiAVjqoeHfvqWLjjMIlZUl5LwV+kHUG4Tqm843iM2DZ6N4/go0so0HFidx Rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpjaq08ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 14:14:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367DuETh013596;
        Fri, 7 Jul 2023 14:14:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8h3pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 14:14:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KncPMIRXrILqQSyfy1Uh9iNmWns7kFGfB/9dB5zl4r7WqKiH4IAOvzodKq/+RFzwmpyzQSGN7gcFAf5qWuuxPLb5ByCi97uhrg6vAtDBj8dBgMISoP2XAfWV3qK+366M7uOLgT3g3p97Mrafi+0yX3EeGagGunvAsb6KsKudevUDTx+Xp5MRqOpijUmYxxzn5O8BOT4Vk+2FC27YzFClQIABewjJ9p2wpooiU0eNL2oOZUxqbVxY0hwIApLP/nzhrirr5Vo40YDOIu7yxdyg2KRpmr617cE0M7ZJuoZoaNuE9lRZTB9GjNkDkY9rcPoWwili7OQiXdf96m6Ch+98Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4inM93zbVDqaoOALbgtDff3iGmFaG/2nvyzPKWSQfUo=;
 b=GArmwOYAI9HooGvhcWm4p8hZbRG7jgR5GtXWnwnuhyzYluJf/eylghwPKpeaBEwczwrmX9RkI7J2zhiWVFCPwZ4kcAmNtLOvz8mxTjVYHtEwTBur6m4Popv3FLadLUzvuh/qnuoyzG7p6vcyhZL0G9CEbptBKaJnxuTgxAO2rAZip5uIxAwHThzw/LJ84nZ7rQ0bEQSTTCHTmLgLkCWYMTdATSh2YvXhUbo5sdCXqQGEoe753MyqnnX6Yu8p729vBbR1gA2YZq10NwuxGLBdoHg5P6lgkiVbpZj5bLXHBHLQMBD04BE5BveN4ks/HxznbxP5/BvYSkClpnB2ZX64Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4inM93zbVDqaoOALbgtDff3iGmFaG/2nvyzPKWSQfUo=;
 b=dOok7KpVAINPByjbF0dB4YwUUjGAl53+pJl3wIZ3sFLVuXF3/QR7NvcVUkUMYN3esQNv0YHvEmUQgFleK57Kqj/61yZQ3KUddwygYF704eKYsRrhQcCDwt2S2lmESBmGUert6xet6A7VA+g0CQtARCfd5SmvBq9h2x478beq+mY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN0PR10MB5982.namprd10.prod.outlook.com (2603:10b6:208:3ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 14:14:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 14:14:07 +0000
Date:   Fri, 7 Jul 2023 10:14:04 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     davem@davemloft.net, david@fries.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, zbr@ioremap.net,
        brauner@kernel.org, johannes@sipsolutions.net,
        ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org,
        socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 4/6] connector/cn_proc: Performance improvements
Message-ID: <20230707141404.6ssug4qrxo4xbwai@revolver>
References: <20230704001136.2301645-1-anjali.k.kulkarni@oracle.com>
 <20230704001136.2301645-5-anjali.k.kulkarni@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704001136.2301645-5-anjali.k.kulkarni@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0489.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN0PR10MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f779ce-3e46-409e-c22f-08db7ef46d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xui9HKiLHwT8/n2VBU6ogmnPSpoxMxX9OY/xgKhJaohQRd6uihuDd4FK5MrbJr8mThB22hvzLqoB7VwcW1tt8ZxdyF6ri5atVWt1wH5Ukn1P9E9FKs8KtqMccbKZQn4MUG4ByEB9tluO8CfzinLuiz32Qnygk4SnZPm1PH9tRp7/YfgOxvnkAALvaTa/QukYbCzmtE6fGrO3iI8N3MJreTr9m/jKnJw7xatCsZkA4ywhErj/7KrDtQE/w8LXiCd1LXL27Gf16K96LgrDm3FZWiDsuP/994fws9SZd7gYh4+OOAUjJQMNyHvkloGLMOoq7KAFim5RnoINOeAQbqN63Brwuqr937pvuT3c+j/MjnFhr+bGKFR6ohdogZRNxrPHt70uVL+gcui8jTnQstECh2SV3B5gjIQwStV6IqH8+oFCMgbGVvpBsfOcNSNA9hnL1S5rLWNgAELcdWr/E4Wl3LwwZKSYLhDQaDqs11ji9KkXD1dSYf7P87ddyVrKRt286zZ/bwXJBS7bw23flTkg8ZseSyZ4eU2T3xEIwpVNxiljdZvRLb2ie1hntr3EBP2Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199021)(5660300002)(2906002)(33716001)(86362001)(7416002)(6862004)(9686003)(6512007)(478600001)(83380400001)(186003)(6506007)(26005)(1076003)(6486002)(4326008)(66556008)(316002)(66476007)(38100700002)(41300700001)(6636002)(66946007)(8936002)(8676002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PXp4i2zWZfNT955CNaE5EI+mPqRekwtjciUExM63hQ8FmVCa4b/OZth20UxS?=
 =?us-ascii?Q?6ouPxUNkfblCERO2boxjx0nHO7sVgav28lW/v7uwY0+f1efAbAvFZ4xP9+DK?=
 =?us-ascii?Q?2vxWxmqHeMH1IXbx2jG1AJnM5T+qn0tKX54qKpypMU2y1Y8cy4W8U4CwNhd5?=
 =?us-ascii?Q?vssILaqG693tOzTA+yKH4B8ZELu3kLO9jy1Qxp+RAmKjXLEhb2tc86QMISwm?=
 =?us-ascii?Q?B2dEhllXmg+INfXonGU/lULtPFnL+jFkB0n6hCoAs0FlTM+jWPc7zvyPj1B1?=
 =?us-ascii?Q?6wHLXaA4Vn7w8wV0jvwgIhgOwIDkYBnMA94PbmAkS7PaXuaYAhDRW1qxwOKr?=
 =?us-ascii?Q?TPCiv+frzZieGdpQxl0U0THTU+LDGBBdAIi9zOS6NzCFLOhTNbuEwhxVCmVM?=
 =?us-ascii?Q?pT4pmL6Ul0KI1w6Yj6qNaweTCt9k4D5G98ZCU3X7+sd5bCSMfycGuIjcvf1l?=
 =?us-ascii?Q?T0OIQU7i+w7TwJn+kKuoHbxuBNMlAStEVloI/Mha/uviB+gULZbxQlQbErT+?=
 =?us-ascii?Q?yLTcbIg/7/eylUBCc7WmCaysOFB34sQESOBY9LLGvc5trpJek+UKI4xka6uj?=
 =?us-ascii?Q?Ow/8XdGeBjiogEYjgFfYWSS8qwoPpJms/kyB7DvU6W95ZyTHcEbI5ZDnH0rK?=
 =?us-ascii?Q?KM7kDm6cUbyFUXrtpHQfQT21GmMsySCIKMwEjBFSE9KcA5wW91NWI0AptWXp?=
 =?us-ascii?Q?uiywjTb5EJBRhRDUpcIqPoYDJuYKqMmBziA0wQMlfqqqy3Mhsrm54KNJkvVg?=
 =?us-ascii?Q?pWVIFW+aLRqS2V/DePcswhDM41bYxT4ByK7ACCLgANdtT71QBmPmSZCNXSbd?=
 =?us-ascii?Q?KuIVPMssm/iMWplOhnnowht9YbQMvkiG91ZAzpQTMYF+JUM2fHA02K7iOw2m?=
 =?us-ascii?Q?kEV+8uMs6RzZ6QRJGheS1iJSNrf+W1NPta6Ek0A3x0BIa4g3I14MR+AUY3iU?=
 =?us-ascii?Q?qZomwDA43KMeOwjSRxEwsGnV2mHwpK1hf7MWZ2H6eKAHsACay8iz3TNuwbAs?=
 =?us-ascii?Q?pixHOyYDnS5J3PyEtJGQtRCHTj3ENHTYo12w5UhdQX70zL29L7AINT1D7fZQ?=
 =?us-ascii?Q?luNH40l/M7eAAKvPJkdqTJ57MTHiS+Gbcj/H08OT9lilBVR9+r3xERWM0DmM?=
 =?us-ascii?Q?iikJM+6d9zpjhxgWhABXQWg4Tb1l0DABu9xxb+WZaQUz3TVu+4zplXVW45ap?=
 =?us-ascii?Q?6jWPtWxe0jIh6lFmfDiqwk6ep93y1ywJOKiOicv9feVm8mWz7ecRAFOG1dD1?=
 =?us-ascii?Q?FxPTwtjaAnNTTQ0LZvvd+CktaLT2lnPhfG2ACIPcet8jzexSbRqVObHvCOli?=
 =?us-ascii?Q?5bzurk+V5/mz7YoaHu8J0dYbRPTKckyxHoM729hx2nkp0o/U2WeUKoaDaj2U?=
 =?us-ascii?Q?MOtcedZwEw61POonmlAVNvFFA3NNC0igt2Q56jYJ5L0uG7laZuCcJIqSakOu?=
 =?us-ascii?Q?1jjqmQkqq/HvC8kn3WAGsa/Bzuz6uDQnPzL6uM5dHpu3u31e9i6XrWIaPvaq?=
 =?us-ascii?Q?L+qyTxqq1vjOsUrcRMo14G5Bp0PcnzThK+QwZwcpCdHTWqVMTKh+Smi3qrmm?=
 =?us-ascii?Q?TgZAiEtny2qgXTgrsWrR1/UeQAiAFLInByjRJHtVf5hg6Ziso6WflKCtCeh8?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8Qu4v+e+I65DnnCWliWK5mKm2DANWrfj0SQH3ouWkpSNGMsZIC5MA5ZjDamJ?=
 =?us-ascii?Q?hq/YhYQc07GGIdrVr54igRX4Zjf0Su3KESN8CCbnQnZ6qMvhhTS9Yi9edP8M?=
 =?us-ascii?Q?/mZSwGBQo2LIy7utdyT25GLX0JpzMPVC09rzQtrH0/BFcOvgbql+Sncq0bCV?=
 =?us-ascii?Q?vGSfL4v68pfnk1NYbCQJoojqtEj56U+3BJcHdAUVf98FuEhk07I+HW8a+gKr?=
 =?us-ascii?Q?2H/m+Jhf1YnLBr7m2Dm+WexxbET0xTeVRA5/eH9J6YCH3avYze4l7Qiw20VN?=
 =?us-ascii?Q?DbPdhLU+dTz9wFgoTnF4+VbzuduQwbWnp8pt78YJLchh8T0YY+rl7LuShERs?=
 =?us-ascii?Q?UXbXOI/rZUas4PL+XzKzFHHwIL55lFyaelLy+r4PREVsiYZfNOjXvfGXjgP8?=
 =?us-ascii?Q?+wBRLTWabrGiXKUg6fCFZco0i4PGeOrMWYHO1x+3BevVnOGSVTTS7JwEU6gB?=
 =?us-ascii?Q?1opx2AYQjjf9Lb3RdBJ0LUgiDZHeopscO6u6Sxaq/iGuBk/ygAU5sTxA1bnn?=
 =?us-ascii?Q?lP+q84orGnSzRIF1zVvFPpyo4XA3eoiXsu4I0tQ5vIFmZ2ZdGJEhXwKUlXHW?=
 =?us-ascii?Q?qAoMm/pHZ58GDq07y+IuO+Fie1GigFqEYFjGFr+UvJkHsUqkh0jB15ttzlzU?=
 =?us-ascii?Q?dXWy8xHstPMBbUVIg70wIajMj9mYGdGXFU5UfdPgy5wHdQY86nB/SeYpuIt5?=
 =?us-ascii?Q?rdjaNroWhAZTQQmJOZdRpjcQ7Af54LI1cN0rXJm4S8vvKmT28BlH0HVcxxKT?=
 =?us-ascii?Q?1+tzl09ivZAxoTSK4LPWPwE0f9UqGUsDI2qh8z7ixO3eYVT0aolfUgQF1L57?=
 =?us-ascii?Q?92AE/4g0gQhXzgqeitAXb4FhyTD/8EGblLaXyPhtN7IbV6bvqPxF/zX8PNgK?=
 =?us-ascii?Q?O4wE1SlMM2hA5SnJ4pcxw/PDFb+XKNBDSjL0Alx/EKCZdyXvx49i2LGmOsl1?=
 =?us-ascii?Q?PEAm8N5Kd9sT8j36FqGgIBDGNL/YDh50jiUWacHWUFPOd0z/GpWYW943I3rN?=
 =?us-ascii?Q?sSn5qr6HXqwRr5sMTIllyLRUUnmmL8KqFZZ8D46mH3v9S0VFs1guvTVtUHgm?=
 =?us-ascii?Q?e/4vH9AStTxBEM/UKrYmJyxAJbmsnmy62RIK5NumJDRgXM56wRk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f779ce-3e46-409e-c22f-08db7ef46d76
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 14:14:07.7880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTvIh3BzwtuvFJy4mk+BMiEiQQkky2rylDWMk4KLtuUNwPDzaHkWf23e18t04aKfWiREeaLoniybK8ySQn0gfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070132
X-Proofpoint-GUID: uereA6lAI79i2y05eVI1Ws-uJodLeXvS
X-Proofpoint-ORIG-GUID: uereA6lAI79i2y05eVI1Ws-uJodLeXvS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [691231 23:00]:
> This patch adds the capability to filter messages sent by the proc
> connector on the event type supplied in the message from the client
> to the connector. The client can register to listen for an event type
> given in struct proc_input.
> 
> This event based filteting will greatly enhance performance - handling
> 8K exits takes about 70ms, whereas 8K-forks + 8K-exits takes about 150ms
> & handling 8K-forks + 8K-exits + 8K-execs takes 200ms. There are currently
> 9 different types of events, and we need to listen to all of them. Also,
> measuring the time using pidfds for monitoring 8K process exits took
> much longer - 200ms, as compared to 70ms using only exit notifications of
> proc connector.
> 
> We also add a new event type - PROC_EVENT_NONZERO_EXIT, which is
> only sent by kernel to a listening application when any process exiting,
> has a non-zero exit status. This will help the clients like Oracle DB,
> where a monitoring process wants notfications for non-zero process exits
> so it can cleanup after them.
> 
> This kind of a new event could also be useful to other applications like
> Google's lmkd daemon, which needs a killed process's exit notification.
> 
> The patch takes care that existing clients using old mechanism of not
> sending the event type work without any changes.
> 
> cn_filter function checks to see if the event type being notified via
> proc connector matches the event type requested by client, before
> sending(matches) or dropping(does not match) a packet.
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  drivers/connector/cn_proc.c  | 62 ++++++++++++++++++++++++++++++++----
>  include/uapi/linux/cn_proc.h | 19 +++++++++++
>  2 files changed, 75 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index 1ba288ed2bf7..dfc84d44f804 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -50,21 +50,45 @@ static DEFINE_PER_CPU(struct local_event, local_event) = {
>  
>  static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
>  {
> +	__u32 what, exit_code, *ptr;
>  	enum proc_cn_mcast_op mc_op;
> +	uintptr_t val;
>  
> -	if (!dsk)
> +	if (!dsk || !data)
>  		return 0;
>  
> +	ptr = (__u32 *)data;
> +	what = *ptr++;
> +	exit_code = *ptr;
> +	val = ((struct proc_input *)(dsk->sk_user_data))->event_type;
>  	mc_op = ((struct proc_input *)(dsk->sk_user_data))->mcast_op;
>  
>  	if (mc_op == PROC_CN_MCAST_IGNORE)
>  		return 1;
>  
> -	return 0;
> +	if ((__u32)val == PROC_EVENT_ALL)
> +		return 0;
> +
> +	/*
> +	 * Drop packet if we have to report only non-zero exit status
> +	 * (PROC_EVENT_NONZERO_EXIT) and exit status is 0
> +	 */
> +	if (((__u32)val & PROC_EVENT_NONZERO_EXIT) &&
> +	    (what == PROC_EVENT_EXIT)) {
> +		if (exit_code)
> +			return 0;
> +	}
> +
> +	if ((__u32)val & what)
> +		return 0;
> +
> +	return 1;
>  }
>  
>  static inline void send_msg(struct cn_msg *msg)
>  {
> +	__u32 filter_data[2];
> +
>  	local_lock(&local_event.lock);
>  
>  	msg->seq = __this_cpu_inc_return(local_event.count) - 1;
> @@ -76,8 +100,16 @@ static inline void send_msg(struct cn_msg *msg)
>  	 *
>  	 * If cn_netlink_send() fails, the data is not sent.
>  	 */
> +	filter_data[0] = ((struct proc_event *)msg->data)->what;
> +	if (filter_data[0] == PROC_EVENT_EXIT) {
> +		filter_data[1] =
> +		((struct proc_event *)msg->data)->event_data.exit.exit_code;
> +	} else {
> +		filter_data[1] = 0;
> +	}
> +
>  	cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
> -			     cn_filter, NULL);
> +			     cn_filter, (void *)filter_data);
>  
>  	local_unlock(&local_event.lock);
>  }
> @@ -357,12 +389,15 @@ static void cn_proc_ack(int err, int rcvd_seq, int rcvd_ack)
>  
>  /**
>   * cn_proc_mcast_ctl
> - * @data: message sent from userspace via the connector
> + * @msg: message sent from userspace via the connector
> + * @nsp: NETLINK_CB of the client's socket buffer
>   */
>  static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  			      struct netlink_skb_parms *nsp)
>  {
>  	enum proc_cn_mcast_op mc_op = 0, prev_mc_op = 0;
> +	struct proc_input *pinput = NULL;
> +	enum proc_cn_event ev_type = 0;
>  	int err = 0, initial = 0;
>  	struct sock *sk = NULL;
>  
> @@ -381,10 +416,21 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  		goto out;
>  	}
>  
> -	if (msg->len == sizeof(mc_op))
> +	if (msg->len == sizeof(*pinput)) {
> +		pinput = (struct proc_input *)msg->data;
> +		mc_op = pinput->mcast_op;
> +		ev_type = pinput->event_type;
> +	} else if (msg->len == sizeof(mc_op)) {
>  		mc_op = *((enum proc_cn_mcast_op *)msg->data);
> -	else
> +		ev_type = PROC_EVENT_ALL;
> +	} else {
>  		return;
> +	}
> +
> +	ev_type = valid_event((enum proc_cn_event)ev_type);
> +
> +	if (ev_type == PROC_EVENT_NONE)
> +		ev_type = PROC_EVENT_ALL;
>  
>  	if (nsp->sk) {
>  		sk = nsp->sk;
> @@ -400,6 +446,8 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  			prev_mc_op =
>  			((struct proc_input *)(sk->sk_user_data))->mcast_op;
>  		}
> +		((struct proc_input *)(sk->sk_user_data))->event_type =
> +			ev_type;
>  		((struct proc_input *)(sk->sk_user_data))->mcast_op = mc_op;
>  	}
>  
> @@ -411,6 +459,8 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  	case PROC_CN_MCAST_IGNORE:
>  		if (!initial && (prev_mc_op != PROC_CN_MCAST_IGNORE))
>  			atomic_dec(&proc_event_num_listeners);
> +		((struct proc_input *)(sk->sk_user_data))->event_type =
> +			PROC_EVENT_NONE;
>  		break;
>  	default:
>  		err = EINVAL;
> diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
> index 6a06fb424313..f2afb7cc4926 100644
> --- a/include/uapi/linux/cn_proc.h
> +++ b/include/uapi/linux/cn_proc.h
> @@ -30,6 +30,15 @@ enum proc_cn_mcast_op {
>  	PROC_CN_MCAST_IGNORE = 2
>  };
>  
> +#define PROC_EVENT_ALL (PROC_EVENT_FORK | PROC_EVENT_EXEC | PROC_EVENT_UID |  \
> +			PROC_EVENT_GID | PROC_EVENT_SID | PROC_EVENT_PTRACE | \
> +			PROC_EVENT_COMM | PROC_EVENT_NONZERO_EXIT |           \
> +			PROC_EVENT_COREDUMP | PROC_EVENT_EXIT)
> +
> +/*
> + * If you add an entry in proc_cn_event, make sure you add it in
> + * PROC_EVENT_ALL above as well.
> + */
>  enum proc_cn_event {
>  	/* Use successive bits so the enums can be used to record
>  	 * sets of events as well
> @@ -45,15 +54,25 @@ enum proc_cn_event {
>  	/* "next" should be 0x00000400 */
>  	/* "last" is the last process event: exit,
>  	 * while "next to last" is coredumping event
> +	 * before that is report only if process dies
> +	 * with non-zero exit status
>  	 */
> +	PROC_EVENT_NONZERO_EXIT = 0x20000000,
>  	PROC_EVENT_COREDUMP = 0x40000000,
>  	PROC_EVENT_EXIT = 0x80000000
>  };
>  
>  struct proc_input {
>  	enum proc_cn_mcast_op mcast_op;
> +	enum proc_cn_event event_type;
>  };
>  
> +static inline enum proc_cn_event valid_event(enum proc_cn_event ev_type)
> +{
> +	ev_type &= PROC_EVENT_ALL;
> +	return ev_type;
> +}
> +
>  /*
>   * From the user's point of view, the process
>   * ID is the thread group ID and thread ID is the internal
> -- 
> 2.41.0
> 
