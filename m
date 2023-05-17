Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722F3707059
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjEQSBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjEQSBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:01:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2946268A;
        Wed, 17 May 2023 11:01:39 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HE4CP5032044;
        Wed, 17 May 2023 18:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=NIYN8GnqmMjusHwAxPK6WNxXNwKLeaKXQ9O8rHsphvg=;
 b=VtOsatk4aoCpSHEV7fy4evK5ryH0kqcwfcmxmoGonK0+QOyc0MvY6NwSo0QrD0Z4Jf9G
 BgyCQKpUn4yU0BMPuv8XFXoaLY7FLLTDZLS2NVreeeOYruav0oYaJOnoX3rOqvM9T2Nj
 EnpDGW7HWg97zbIa3MAZBpYDCBpIIkTFb7z2Q+ZqSfJbP6rnq/hwNzBias6vloDtBgXC
 OGns399ojxHVbMQRS9tHvLJOSZ3OuJHO9D8p1QaZXACtDTfkvmtpysKp5tvP5Y4VdxL5
 i0CdLOHXuUG5IQMNP2y8VqK2biWDpPi4wfWGdr1UbVMJiKO+dfoKII9EqXj1E9HIm+DA Yg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdpjnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 18:01:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HH8vnY024999;
        Wed, 17 May 2023 18:01:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj105rjfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 18:01:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mv+wJ8MOmgwa6tzyEqJYSCkzkmtA+ejc8cyOLGFI8pmSN70Jj+k1PKR/VENLykr5GxLNH896CvqIFe/NLe825+/KtYnjDVEQp42ZorBm9zt1qFUzKeYl7Xfhk0oFdFZ8GkC3SoZ1NdUVfaYefhAHNTfUj55nnM26Mn9dFxJ96RgMHRQyYLJxAu+fCQG1Fbr5NuSntXa8IAg/pcfWa3iJSOMEh7bUFWxdoFqhDwUobh9O5bhPl143rk1SUa4YecrANlRZYb3iRsKIBBnGR8qWuSDcvSGpl/aySzoZR+OqkPY0BsrFhVOhZbS5akJ3CS73gN6/2Fhv3n+sKM6Iuha5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIYN8GnqmMjusHwAxPK6WNxXNwKLeaKXQ9O8rHsphvg=;
 b=c//3BTT4ThbkSk1Ow8L3Z2iRKDMHX/9HHCQZf6GAeTJD/dex5DwKzTOPzw5artJpb3v7FK9rhMS7PSDdwHWS89miqGO/uY8UHDXH9oKCedK0ocegUT4N7i0sQ4VifeUP2r6tofgXx4TBMbdcwF2NBIBbOrDZrz4U51AGzCokQ6lcBsFt+pwIERNR8nMz1O/flXSfiNkQPMJRBzfipIwuH1GRWoVWOCVTzSPWURLrEWkPwlbhXzzbg8PHKLh4tS/SKLLXdZKZfoyQOalG3dz9o6vPukxbZEpjemr/rUPxdieVZMf2slONFYEJrRcsTBJc0r1w6RvdzRuqB+44Vjp70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIYN8GnqmMjusHwAxPK6WNxXNwKLeaKXQ9O8rHsphvg=;
 b=jGbbtWyqYMZJr9Cy3e5nCvYbY2XhqAJC4wCRNOmGrUGUIITa6wunSBFT4jOchewyykS4uURo286u8rM2Rj9tMq0ZLK8ohLq1XuxekM8si0pUl/ke2mnl5elBjrCw/mw+R+4PPOqk4/IDurPx0drYGKzEBfle+RIIuDzd89Zf1KM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ2PR10MB7040.namprd10.prod.outlook.com (2603:10b6:a03:4c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 18:01:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 18:01:05 +0000
Date:   Wed, 17 May 2023 14:01:01 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/uffd: Fix vma operation where start addr cuts
 part of vma
Message-ID: <20230517180101.ejsybjiicge7qp5s@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-stable <stable@vger.kernel.org>
References: <20230517150408.3411044-1-peterx@redhat.com>
 <20230517150408.3411044-2-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517150408.3411044-2-peterx@redhat.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ2PR10MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 97bacda0-5aa6-4841-9114-08db5700aee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06UPqZw9thYb+JktJhtFjzyth+IFg9vtOQGR25yKd2da5jnmhrqgTVE+WtQXb2jIpnPZKHxOv6VIt2qz6t0TDQBLc14etsIsRnwT+ZdB/n70RidS9KmQ+qJkxyhahVX1HgVWxUX1IEebz1wes5t51IkB8SVvOYEV2fRbnOc8v6fMvri6eb6K6ud4ogU/asucnR4jdditwETXF9uFUnFPqBtYSHxMRtN8RiRg13aB2N/ONdHdy9LjEenceHBOJUiby/BqXmwg0zuPHArG6mqjuFGrorZbftOWo8axLYqmF2RIDbUsvqGv8lrpvEEyTNLKi15jqp2Fi0+H5FqGJcMIIyVlqjktsqd8KiioYwnQHspVpDDlI5KME4+KP6Q9C/iFsL+vqvsS59RMwvAdpL5H1runlMCW0Dy4fEhD1LaLoMMtP4j/QdCBX79D2TuFIRyY7lDbyi3SWtpd1hk2XXsOh55FgzM8DAA0TUIhOYqTpM1x1TWvBwUa1ie9vJPtPpG9BJDr+VceaiZ9zpr3CYtDXytsZZAlQDz7KtCxll2cvAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(83380400001)(966005)(6486002)(54906003)(478600001)(6666004)(6512007)(6506007)(26005)(186003)(1076003)(9686003)(8936002)(7416002)(5660300002)(8676002)(41300700001)(6916009)(66556008)(4326008)(38100700002)(66476007)(2906002)(66946007)(86362001)(316002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6FTWIKOzZcz4BY2FBY31LxbRnSObTj+DpPjaA8lz/EyFybdnSjTCZw2orBkh?=
 =?us-ascii?Q?UsVZeFXwuFhrp2+PlPZsq4GtEAOvniR+3TqwwXNDoBwDnjx1dSylFfupfRLR?=
 =?us-ascii?Q?4QEgipn/t6ZXQSUQyg1SYfOe9bVbA91qoGc/zT5pf8/DXv2SLL6x3itm+37I?=
 =?us-ascii?Q?Gg3/YzEQ7jzCI2j0MR7N3I5zIE7gA/zSiXa1YW7sElzxoVVhKDoRIMcs0zhB?=
 =?us-ascii?Q?jMSW/Mj3GYOXB0COI1bwiw+eB9Z7/yyC6ZpEJyfRVqA0ethaAVPu/6vpAqBo?=
 =?us-ascii?Q?FnzJVjs9IQJiuJT4xBVWPjS0p+94wH1BxyvnmkWcBGggRXq7kTAoeZ87jW1t?=
 =?us-ascii?Q?g6oakHt2fJkZI2AiBuUhlN8tGwgolzl5vb6Sfi+b6wr8IyAVKmuGXwVlkMEI?=
 =?us-ascii?Q?jEGIYciV+3/PpN8XmciFz+yCfSUP/MGZsDO888pgq7DNIp+RnA9XKVPvuAWm?=
 =?us-ascii?Q?W9qLFD4s6XFMzLyZRH3FG+HbaUY9kkGLOE3F1UNh6JMcp8pVR1UVyUJS/DhA?=
 =?us-ascii?Q?uRL4jW2tI6KgWS/I5Shk5p8tPL3MfpQNcwGLPkPs9MBrzgArVMLyeKTpdfMe?=
 =?us-ascii?Q?m6BE1hBMeUamwpsqJ7vxZRxn/b+cgGnHHmziW+XaPUDYQLQwJLCSxYSoogZZ?=
 =?us-ascii?Q?rgh84jID+LLGIenAPjqIhJz6GqPldwaj9Ybd1htoDrQcD6IfEeSx4AL6cfe1?=
 =?us-ascii?Q?1CSbeMiONoumJ+92mxW1uiprnpKoGB5uly05wAmeU9dJg8RQtXafiEPlwxCk?=
 =?us-ascii?Q?tc7qD0aOxDYPxYAA5+GIV5Q1wsstbIiV8wBF3eA7kBgD4F2J2Cfj5VExDcPB?=
 =?us-ascii?Q?r6lE3RMmYAS8PqgS8Met6KPafeh8QSL5rApsBSOcK+HBNsu4ZJx4DLYIzwxx?=
 =?us-ascii?Q?SzTs0fSarxw1GWYuhWdPwq2nqtAuF4QSZe0obGuhkcGBl1ZT/SuQnTNrnVtr?=
 =?us-ascii?Q?ZCyvlUTrzTknk472yFoCFFY2S8HrOX92xRVSqEme8CWtAQS/5Yqg1T/kq7s0?=
 =?us-ascii?Q?viR77PJGEZ7uiXJNBJJVQMvSOug5ck0Jf8KBHgWAhEhuaq2MCHVI42t8JD9h?=
 =?us-ascii?Q?c1DTKKTjUudpvhJ6+HwFwGLHisoXh74W90nPmTM9YIzTwg5dZPykoB+wyToa?=
 =?us-ascii?Q?BEc106IDv8O99A7eamyaZfGS3GGfXtGVcVOmfQXHk9eQvmWEp62tNa7S7BEC?=
 =?us-ascii?Q?te0zk713MOcHmi9MzJHXobi9OfoAkyg43FTzw3QduoLGdmAjKax9DXUODMuR?=
 =?us-ascii?Q?/1Wd4kTIuOK9QGNhtGJCfkdErGbyXx+4/5XWwI8w2YaYhZCEj5nmqoIdWWdg?=
 =?us-ascii?Q?upndFN7iCWDWR2+cSxu6NtbTA98pQEqe4fb/3s+HraiH8OE5+YMgF+eT76cu?=
 =?us-ascii?Q?/Zkw/RuR3jEkX7f4EQvA1V/cKGVz0pjbk7Ws6KJL8UHLFpAZpJn6dNGBP69h?=
 =?us-ascii?Q?Z3MmTXSKqPZc0q/j2zz1BN/3EYFTGHVdPofGpRbGgcfgB4R2xBl06ur6eipM?=
 =?us-ascii?Q?Icw0zCTqekn8IZY80VBC6bcS3smQIQBcKg3VICuZyxm0TUTCUbO9Q23Wwaw1?=
 =?us-ascii?Q?3IblX7HhJU2VyRVGtilXTcvyLqX6Vps9qvF04xlYReFUUPQkm3LhzHmIk/IX?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+Tl5R1mHt2Zq91qArHouTRQ57zbmzOjG7Me8NpQnE7mgaKi7kddYMhYen890?=
 =?us-ascii?Q?e88LVezjtORMR8i8touZU0Kk63AekClMFUC/VLbplpyyWWC647jOmnnLBFiC?=
 =?us-ascii?Q?kGcUJCGCLQgbNF9HDqwiFOZvcciHmjPmQhULM1uZow6TTMPcraTt/sJWlPG0?=
 =?us-ascii?Q?9Hrk/sIW5HpFGl8BaZoBRidrGrNHF8v3yjrHrMDZUHYmvUz51xYE3fL93l+C?=
 =?us-ascii?Q?NqApl0+PGcC0r9B9O8/T6GQGYfMNML3Y8zw8DX5y9lWSSulMCKKsAKpVKEF6?=
 =?us-ascii?Q?LGgp48J3mxUNsgGzvYflFqfNS7ESd+v/+orpymhGbGxqvqhPpehMNmETp1CF?=
 =?us-ascii?Q?zEm61fn2bzbFGAGPPwx1wCrKBXzcMBmf50YBfOXGpkt36vd/orvEilkXHcOB?=
 =?us-ascii?Q?+6OhypkO2i5Efr4XYfCdFVCLpYC9lNLVntwN9ixTyIujbZ+e0QG3kfcZuUzY?=
 =?us-ascii?Q?/igxkbBd9XckLFXwEWL7yLb6w6QEU+MVhJbK5aGLfPAmSh+sUoGeN0DBodoo?=
 =?us-ascii?Q?Rwri2kLDk6btR2Dg0kR7a5ehTkZBlYRYoy/W25SFxfRB8Vz9MPNqwMDpPWKx?=
 =?us-ascii?Q?u0lplkeqhRrCiANHY+f3Za79KiS1oIL+dWYJZdmmjrP3VxfbKOhjyh3N3aeE?=
 =?us-ascii?Q?wIFmzXXB3qexKsRivJ84Rj8sO8LGU2WZhFrE9AluxU6LtGsrvKP3BvJ71L6H?=
 =?us-ascii?Q?aJJAT0nrCv+6UwH54sU4EAozi9sjfXTpz29FgcNcJ+Ru4IQSvKdLxNwnOR+9?=
 =?us-ascii?Q?lV0QHNnMifQfnzfUrgn+qjmbarozKmbacatnCkxJfgH8O9cnn0Zs6PnC9RjD?=
 =?us-ascii?Q?Tx6L/1b9As+uHHe8ItdKCsi9nKuTkeFXINOkKjzoS0Hx2Z1nJooLaq0qPJ3R?=
 =?us-ascii?Q?DANqdAv3jBLqZgtHX0WMiUbM8zjFwys4A/7fUCbqif+Hcv1frx0LEEpP1Tb4?=
 =?us-ascii?Q?8XJZ6lZs17K2wMDfHT1A4LpMKUwVJHmbox87W9QY5s6HoVaeFwri3CE+New9?=
 =?us-ascii?Q?KEUn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bacda0-5aa6-4841-9114-08db5700aee0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 18:01:05.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHGja8FkCvLyeCv4lgBp5AOJnRDneBrY8g1Q01T4Ec4W9pa7vsHVdqcQqFoU9ksWufxbluOY7c1DRMiYrorjYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_03,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=702 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170148
X-Proofpoint-GUID: Tx6om0l92V1i8D_9nXjlOjdNmmrvduS4
X-Proofpoint-ORIG-GUID: Tx6om0l92V1i8D_9nXjlOjdNmmrvduS4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Xu <peterx@redhat.com> [230517 11:04]:
> It seems vma merging with uffd paths is broken with either
> register/unregister, where right now we can feed wrong parameters to
> vma_merge() and it's found by recent patch which moved asserts upwards in
> vma_merge() by Lorenzo Stoakes:
> 
> https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> 
> The problem is in the current code base we didn't fixup "prev" for the case
> where "start" address can be within the "prev" vma section.  In that case
> we should have "prev" points to the current vma rather than the previous
> one when feeding to vma_merge().
> 
> This patch will eliminate the report and make sure vma_merge() calls will
> become legal again.
> 
> One thing to mention is that the "Fixes: 29417d292bd0" below is there only
> to help explain where the warning can start to trigger, the real commit to
> fix should be 69dbe6daf104.  Commit 29417d292bd0 helps us to identify the
> issue, but unfortunately we may want to keep it in Fixes too just to ease
> kernel backporters for easier tracking.
> 
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Fixes: 29417d292bd0 ("mm/mmap/vma_merge: always check invariants")
> Fixes: 69dbe6daf104 ("userfaultfd: use maple tree iterator to iterate VMAs")
> Closes: https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> Cc: linux-stable <stable@vger.kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  fs/userfaultfd.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 0fd96d6e39ce..17c8c345dac4 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1459,6 +1459,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  
>  	vma_iter_set(&vmi, start);
>  	prev = vma_prev(&vmi);
> +	if (vma->vm_start < start)
> +		prev = vma;
>  
>  	ret = 0;
>  	for_each_vma_range(vmi, vma, end) {
> @@ -1625,6 +1627,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  
>  	vma_iter_set(&vmi, start);
>  	prev = vma_prev(&vmi);
> +	if (vma->vm_start < start)
> +		prev = vma;
> +
>  	ret = 0;
>  	for_each_vma_range(vmi, vma, end) {
>  		cond_resched();
> -- 
> 2.39.1
> 
