Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D85370ABD2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 02:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjEUAqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 20:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjEUAqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 20:46:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A0A106;
        Sat, 20 May 2023 17:46:40 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34KNOwsS031425;
        Sun, 21 May 2023 00:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=uJqRuMB8/loE7ZomuLhGuIi876qYLtolbxq7QIfLexQ=;
 b=kVf3nvSsn3QPwQMYa/dDGr1rl0UZMo/l/OW87FXVzuMnfmrjMdtpBpmVdYkVhj/AfRaj
 zpQifP9xUBbz2sGToNmBx8kJI7CDyqxTectMjO93VlOwjphmsOfoHM5pjO8rosuIXZdt
 DTRlnfwIcVtXT27PlgeyRbkeOONQpsLbbKMnUhb9VBKHE86KGsix6VCAE13E77qgAKoM
 oOZ+ghdwGuuGGmue11ZF5+8beGw0JLmBp2wDTv81c/uC5Hi8mosBuqtPrp02NUUTnufz
 pI5mw41+0mgmLZhkdrRR/8T10GaCTE7S8smR5Yu16bu1MSlns/5lkDtrCzuSlwDmYgl7 Tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpprtgqt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 May 2023 00:46:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34KMgcHw001420;
        Sun, 21 May 2023 00:46:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qpmn1ncce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 May 2023 00:46:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSY1VBc2aJMcKDH5NVrE66eHLLQPVJ24z9Uy61+HhAxuUihb6jBb60dtCcSVJAzsS+RenOJu4xygbtOSQHtn8caJYsbYLD2u0r+tMY2d+Gxq/mnvJCEYvQTuus997XW/UNuLFwGwQjXMETQPXeHUehW0LVHiKQVTvLtu0lkSG6RxexLGPEDw+g03J/ODSfqefYI04roSxBZ/I/5Y6wDqXApXobZdKr5MA6sY5NU/wxy2dOty+5MFkoMTpF7lRkbLUx4syEqvY+pw/xx4fxERbJm5RVZP6rcSlTcspYhWZsRlRflAxgnlxchIp8gNiUtflnslyDhzazMNNCNIH193Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJqRuMB8/loE7ZomuLhGuIi876qYLtolbxq7QIfLexQ=;
 b=WO3gJWHh5OUXFLeKnQBZiJgY9fa4T36lLxzJJiXzrO2A44CBdAgI9voLACj6PEW9GI9uyGwXXY2XS6jtPjB1ZUxYDY1hwZ4GN0HS50uksG9gL+aGvbOh3c6iJCcOaxYdpw1NwbfiNgi9+l7HDItKam3lxCwPkXdCn07nkibUBnLYwW7WGzNxl6H9noMPJKSVZD8UXkOE21fK0orfkfy/8Kuv6EZ9oTAm9TnDNl9W2VXq66oX7AUnHUeFqr5EqswEuVPBKRfUO/WwWH8h/PWxaKPHWDtZ6btXYunjfdf1ukM9lfl6obaCroMFZaBHXHiWnYj8BfZKpabY2NPj9roujA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJqRuMB8/loE7ZomuLhGuIi876qYLtolbxq7QIfLexQ=;
 b=ycln5mX5IVHb5oBDSW/zOtps2evxkyKxZavd7RlMtnTr99sCWzO4UHHbM5S9Jrj4u0fr9z+Fvcff38IMmRVDuq5DZDea+erYi8Nfy10qPF1giEjiDgPQDXc1FnIvMXC+vUdxYgVcO2DzKL4HnpiySK13so5Q4zSH2xzsg++MNWM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB6638.namprd10.prod.outlook.com (2603:10b6:806:2b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Sun, 21 May
 2023 00:46:33 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6411.026; Sun, 21 May 2023
 00:46:33 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qjaqzq8.fsf@ca-mkp.ca.oracle.com>
References: <20230511123432.5793-1-jgross@suse.com>
        <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
        <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
Date:   Sat, 20 May 2023 20:46:27 -0400
In-Reply-To: <6614f626-d174-03d0-0993-79e6f6169b71@suse.com> (Juergen Gross's
        message of "Wed, 17 May 2023 06:54:38 +0200")
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: 5babeace-4bb0-4605-edf0-08db5994d2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y8vxmKT0JNSNIoiuV4j9lgiTTaVlf6tp4IYK1ehOx6eRVI1kD+BOfqlZf9sCrZJNOcX5F09qS77YeakIiuFZLsvzljOMQb8ybuu0VKcYOanrqegzoRb8iBw8VVHGrG2UrDYwYwIp8Pcdjuq4uIiVinkgxFyVN16IplrTkoCSqSEHUIdnMqbl/AXQbaSIbvB2LNavMqoFBo+NpLSuMT/Ftm0BIkq09S82VdOCAT4ey/B4OQj7brS81ziq1kXsQNWyYEFJo+em9I4weMX60tgIpcZZmp9Pl1bhkyxIhS9/bcQyn6S3sw9SnaxP4ikeELpsdYVnjepUB4jqoVgaNFE3tGOtuOxMP4LdTbiY34i0Lc5QHIHxEfaVeNe8XRR7ClCFeEhEzZQ6egFJuCBcG+sdeHXPv23uOqrKiX0/N4tolZxB398jH3Lg0VeJDTX1X87h0oWsLJG4/YiEQSPHv66Y8cmAARVDPC/v1hRuvs90M2g7d3D0PZsAnycWJQKKnNencS+a5Pq9WYd+7iSu7GssY5JI9GdsEhooSJqHWSAv67/mZ8r5feV5pAgu815V69sG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(36916002)(6666004)(6486002)(54906003)(478600001)(6506007)(186003)(4744005)(2906002)(6512007)(26005)(41300700001)(8936002)(8676002)(38100700002)(6916009)(4326008)(66476007)(86362001)(66946007)(66556008)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RN7bSkPGRG7vc7Cc717ag3C6o0ilsieoyJFRA732Qdde1dO2WT/+06iGXIgc?=
 =?us-ascii?Q?M3r6nzd3kR/esUsBQ1Ts7yVirQQrpnXG6g7e7jq1/pu5Rf3FPYhK4IV3Zx4L?=
 =?us-ascii?Q?ySUg5Zhfu9AgMHMGXIZcyJbucQOXLl+XAvAFX1461434qyYFNc4X3wxuh4W5?=
 =?us-ascii?Q?8cTZD1VtjvZW/NwbqSZgc/bMVhEodZKyLoLW3OpNB8Cv2VlYx0Y2o4LIbYfM?=
 =?us-ascii?Q?P7nAP+wSAbOFMah9dItpVDnqioa9ywwduUIQSxw+GrKZBAbH7g97SKxzR/vH?=
 =?us-ascii?Q?AELBSUvvD9Fbh9IMoIYoO640XV3wJtceKXcNNofN7c6D5gAfyLlj4W0aJeG0?=
 =?us-ascii?Q?U1DpHAXuXCQbtgLzYgp85Fhfvq2M1Ait6uDDDk2e4aYUKq7uGRKlI6wCn0WB?=
 =?us-ascii?Q?dP2jiexhsqXGHN+SKP9UDkq401lzkLTXXqBrHdN5sMqdFP9ssMGgLWaYmvwM?=
 =?us-ascii?Q?86aodvR3i5I5725uicZJmau8i2a/xIFFB936yaaz4XWx05ZaOzoAVblIONQk?=
 =?us-ascii?Q?moW5lmga/G5ff4ooJcm9l1M7UNz0xeu3W07al1dboGlzTtcBRxySbbJbxJc9?=
 =?us-ascii?Q?8Ts6kXpEJwsrmk0phpXNZ8xPglAubHxhn/2IdU1MExlB55T7Ms/q5q1L2mHO?=
 =?us-ascii?Q?wH3RUFcJbzUBBfSN0vlSHe8X9uE7jeZeTroBpdQACNKO818uxlWd7Vtzvodq?=
 =?us-ascii?Q?afdeFqvxRz7nLcz0T0VGOrTl0nWn3a2v8HmZmp9cTJdxQ86KqS/Ese0Ip+Vh?=
 =?us-ascii?Q?qiAJ8MP67kDH4GBzJAO8ahKMzr4E4VIEkKoo7+Aa1UK+FqljSUfg3loHwkx2?=
 =?us-ascii?Q?4re9LnnV7lNs6rxwn1nZXy6FKEusbKvWaOKur//Vf+Bkzslcl6u6e0LWyqcU?=
 =?us-ascii?Q?HHoGNBiiGJXHgMwZ75rjQQUcbMt84OPj/BWqvlu0Bt4MVngIQ0BGwiEPTfmV?=
 =?us-ascii?Q?QNTLpJnsxXqSKwsWHGrLQhqZDS6BJEw/LmR0MFetoIo7N5nFKbNJJMLsUcwh?=
 =?us-ascii?Q?kYd4jRoHsk9o+jA3D8CfNgRBi5Vi/oI+m64NSotLen7dM4AvrjIjLd6S4XK6?=
 =?us-ascii?Q?MaXeHpkjpIyL8bHXJwybavJsClV7fHqmthk4it3IwxyT+Sa0lHH+xnGXimzG?=
 =?us-ascii?Q?+bb8zYEqQebAdSG2t4IjypRyouHlpQorU6WogByuAE2q4OWTJNTDJD28yNUD?=
 =?us-ascii?Q?A/UFDt9Gqk1xvsikW4BdK2fZsPR7gZ0F2q/d5nsMlgMtmyy32tTC2akX27ce?=
 =?us-ascii?Q?nN/1hf6K/pAIYW2/rqp7igBquIQ59ugeEXdXVDQo1y/tRTI/kb3ND/CrrJqO?=
 =?us-ascii?Q?8glMN64WPjkasff29dMLLU5Tj1GAV8ckDl9D20uCjnIw+qaMOMprZd7W1Jvq?=
 =?us-ascii?Q?wGUvabqhJ4/dNE4dVOhoqsNYcf2RUD5bKe+6FAwR9wcM9roq68VlDz1Dpa/6?=
 =?us-ascii?Q?NEOJy7TxNo4qjBbJCIATt3zmIRNcmFTCB6lzwJ0URNuf/CzcWiFBpgRi4Lcc?=
 =?us-ascii?Q?VbrDPBJ27QFvAP/oWOmO39N9CvhHtkd2XKTVc9wJMt64LCgcKf8JETHdkEzz?=
 =?us-ascii?Q?8N6PYqHvHrvjnwsZ7EpHvqcdcS4jOxkKuT+L8/zLLZ7t/63bTpO1CrmM72rQ?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +ZFh1jv7/2uD6cwNlBmL0wA4XQcxsjukpgpWsXX4LGMm0UFCCvQNMdlnToAuxu2j/EWjbr5PznhIb43LevRczxg8z9QmOT4KaxrTaH851mRXOlVeY+N9ND3EC/ZA+0h6IoJFSz30NXToXqINurYp5FCT3ugZISnRj/aYGAuZCCD0v4QDOC7JkH1oxWcRDJTzemNR6KTPzptVpT2QAXuzGyAqzhfqV2Ihs17NflH4gLY9Z0vrRLrlTytZiHj3AAixR9GDN1bzaGPw5V2AcgjI21NZxrhHUofD8wVqfsNNZ/tCWADHmuyi65VemdellOuLRuSq/ZFvILbSopoYk+hP4E+exE0Bm0QiI1SiG8nuEesxK0Vwr23NXI5+iVe5kl2hQric48J+nn8/a2PMJvn80phSxbQrxR880AkkqmCszmTGb0cS7G56Rhyzo/2Xo2eYuxn4/eBOBoxgoVBGd/i5PcXXWm+GJNS2kSIGSwfZ+lg7VQd5sK8Csu7ItGIy+eDWqg+9Fihqznw1sl2eK/+P5O5rEGgBPucJFYGiRr5GksTcaTogCKUUMsC1OfnjH4mYrERDrrXcLgNso/lIcXICUyHWR9DPhbedQAXWRHRNDWggW7oe+8y5QE1KGMD7wRh1J1cFy8skIv2mroCLbo5uY8v57j3xkm3fBD/3TzFYXzRWSr635nI3OURgNnmRgomwu5Udex/bSzPA7KyfijCRlhiKnUp9nBLbrdpxj8lgLuJXKyjSi/JJ+xdX/qrqXmBtWPJkodol76/7dN1zY3ALZQ0X821dvPGCWLhEfMuBF1CmRQYqOw8VVEirkdLr8xlY8hVd9VW7zicsVV/saRbu3w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5babeace-4bb0-4605-edf0-08db5994d2f1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2023 00:46:33.4344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAPIKb4HkaErfbi1jfdWXanpbnXHLGl+kbxCLNh9K68DLE/qTfSLAGsO1OY09kz2ZCJU68nwLEl3dn4XCTxJZBPgaigfXUxwvxgTnRtT4qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-20_16,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=574 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305210005
X-Proofpoint-GUID: 9x8K2YyzDUfbwfe9pKSIAeZ9mSxw8hGR
X-Proofpoint-ORIG-GUID: 9x8K2YyzDUfbwfe9pKSIAeZ9mSxw8hGR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Juergen,

>> Which callers? sd_spinup_disk() appears to do the right thing...
>> 
>
> Not really. It is calling media_not_present() directly after the call of
> scsi_execute_cmd() without checking the result.

My bad. I was looking at sd_check_events(), not sd_spinup_disk().

-- 
Martin K. Petersen	Oracle Linux Engineering
