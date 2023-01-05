Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A16265E2FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 03:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjAECii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 21:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjAECig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 21:38:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77E02F792;
        Wed,  4 Jan 2023 18:38:34 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304MDwwP008873;
        Thu, 5 Jan 2023 02:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=CKk0gRE0IMMi5D8m7lacmyc6ESQqVhqiRCXl0WHz1s8=;
 b=r0gVJLyW1ixpsEwpSdtEl6fSHuNjq2we+W2VyauWK1dw1Pud1dmgSR//okkhzygz+PPv
 d2VxHzEICksPp3ciQrpfIopLiNF9KDKrCxTL6LrInXhct6HZCB9rvVzI41wgNLIKFetO
 xIuoKPkG5HalnW+50rzjEBslG8QTsjXLxZHY5fsTD6fNKwXD47iUbqz1v8ENQYQSk3BZ
 KJo7BgfHyq0xV8gmKmDpf0lRD58WS8prjQ01nxTYXZ9uM3yQJiNYc2MSd9FuPSXYWAEE
 guf65fM1BqR3/w7P1gqgvAcd+uZmCIiSomU86lz7mLB+QWdgx90K1PBjcKek5xSQKJm+ sg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcpt7y5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 02:38:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3051HMjo031254;
        Thu, 5 Jan 2023 02:38:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwg37abcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 02:38:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cO54f0E/JcQAcWnjQbEoA2Et7rhFilXA1Uvt9dhM4pGyC0qViAf1TjvFVXC44XQvN35V+ZD/Muet/ibpCiuLq4QscarC8ZlVCD9y2rj2KdQsYDJffEupVzerspn4orw52QUOPoDLqiijsxUxCzDds7KREfqX3I41OVKcL/CdiS9Z57NkNHU/q5TmqHcuAcuTj1msZRcGxBT6oTz0z41LzmDqXUVV7jB8HoIyI/G/fk0fxfAgy14zildlA2f/VbRG7ywKBmfUznYBjdhe0Ig5u2zkfAP5vwQnCSwBjoEKMM7iSp+f/rM1JNi2aufc8BJ2bM8oh9ObDpR4Wwi2tzoqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKk0gRE0IMMi5D8m7lacmyc6ESQqVhqiRCXl0WHz1s8=;
 b=WpEqYz7VS5Z2PA6qBqTI9S29xmfXxjyeEMaSKY1f4QpU91PFhDey/rrZRvEoNBL8RD8eXUsYJ1eZts8NzW8Bvd4IS77pdx3PqhygGZFmB7101DVD0RcyePnzizO8GDb+JXB8t9gjassQR4iK+fDhUlIf+oCKBPqdSJZ+HBmTHR1xcUw+sZhniAo1lvVLR5So+AQ9IJSMO/N8wBwcYG1ZKqxa/cKxbSyrjxv4aGDhrCghWzze6vh946O64lIJhKTDa+Y5bOF0nEIgGI+CBNx72+oGtBgpxomJ5msjpbkjEa1gZ0HYC2bW3pGmJYtLlJCVmr+P6A5Swxv9wLYsHb2nng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKk0gRE0IMMi5D8m7lacmyc6ESQqVhqiRCXl0WHz1s8=;
 b=eMp/6JaFhe8nPyQQwXZzWeCBJSA4O8IGsppjIYGTyw9jzhROXn0Nu1hvjufR8Eztqs77gP+K3Zycik7qbKyCLlNgnaG1Y/W6up3LUJwz4RUuaqTL1CuyJqVwX93EqnkN0H5WFH1o60a4VY0O2O9SanCAS65aFe4hFErO064sDMs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN7PR10MB6307.namprd10.prod.outlook.com (2603:10b6:806:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 02:37:59 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22%2]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 02:37:59 +0000
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        jejb@linux.ibm.com, andersson@kernel.org, vkoul@kernel.org,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org
Subject: Re: [PATCH v5 00/23] ufs: qcom: Add HS-G4 support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r0w91zbw.fsf@ca-mkp.ca.oracle.com>
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
        <yq17cy84gqc.fsf@ca-mkp.ca.oracle.com>
        <20230102084707.GA16638@thinkpad>
Date:   Wed, 04 Jan 2023 21:37:56 -0500
In-Reply-To: <20230102084707.GA16638@thinkpad> (Manivannan Sadhasivam's
        message of "Mon, 2 Jan 2023 14:17:07 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:806:6e::11) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN7PR10MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe95b1e-f60a-449d-864a-08daeec5dbb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MCYyRSknsra3QFRnAf/7nstr6EudeZ5Drx8PwlHikMagicyakO4aN8BL4L5PmhPTW9kwvVq0fpMrSMRPhi0guqtIwK81ZzAy2w4VDyPpnbUvPaM23ijBeIXd5ZV4ZfKjUw1tYv6OnLoj5T0Qt3riQ3rvRifFNsrgYy230e9ylwvm6cP11OXpVwSZV80mD/C0Yu2kz9QZ5b54FVNFDvmeGnCzgb1J+AnI5FFVJ0mbVFbMhBOMhwLe7i5tKIyjZQIFsLkAjDRJW/wRuVFdc1RDf7G2N8KI6JEU3m4ChUkCXOD0nM/hwUwnEBDLgzb4yNwrlpFaG/9hVPATcjpn2d6zErRR6I1X+FusI5LCmfWTIQmjUSONbYEA/wILufzOLgxgfiOcLUMZixBIrRfgx+ko7P2htynvITGol3yFBA6uz+OeX6sWxEbnaTzhGXBEN5X3sRlnqc7Xbbm1YvcTjYbBmjCnDyQtsMQNo+W/LMhF0i8AowxYGAgR9Wt0I3IYiNcc1CSPx7ZQXs+SKjnDjTPftN+dcJZDarvqaqpqljrashzBz3/+z2WMqRlP5GYy1CScHDWs+uu6f/ZvwHTK7M6jYrfeqMDeIa8/00p7pRwLsTM7KCyfi+7FHa6F5+wL90IPuOoGKwb6djySxPSpPEpxYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(86362001)(38100700002)(2906002)(8936002)(5660300002)(4744005)(7416002)(41300700001)(478600001)(6666004)(186003)(8676002)(6512007)(6506007)(26005)(4326008)(316002)(66476007)(6916009)(66946007)(36916002)(6486002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZRgxGYz+UeS3u5Q6Q7Yig7QAJNxXcoMlMmTPo5hVUN4rWucn7lXuFlijsMvk?=
 =?us-ascii?Q?R9Z+UZmT6yurPIjaT/d69wbS+8aHdshIESCpR/phRTDwftXQdN+sVxCojag1?=
 =?us-ascii?Q?pwlzPpOx9dq0Kdxmrbo/kbvHKQRLjWkmi88omX02SrGKOD6GpsTaHkDTQwRp?=
 =?us-ascii?Q?ghDJ8VCu3s8b89PclaM5EbLshTFW65Z71aIPfn8AtL9M2LlCKOvk2b7UXjt4?=
 =?us-ascii?Q?PTQZRsv3u8g8Ju6FxlVRQtSsD+KYsRLnw2fh04TTtstbH0IOCcyrMrmK1bRP?=
 =?us-ascii?Q?+WFEqqJk67+1oVZo+4rHzlDKn4A3qgq1u9iKUcCCdjtzWkmUnGygGD6zHBts?=
 =?us-ascii?Q?pWML8QfavBkdAX1dHQQt7d9rS/WOvx5MLk3PZarueuWQ0I8rNVtdKxuHPKAq?=
 =?us-ascii?Q?FdSb7u61FFZOmM1p7JgMEUgRUkCIpDjMmm2FfK3VgmN3Sl6usy7yHp243czG?=
 =?us-ascii?Q?+v0cCNd5ajiRUw+xd3ozvBtBOTLQ3dgR7ocwrzI3AXrWck7Co6j0z+pLqiKb?=
 =?us-ascii?Q?8NKH1IxBYpSeX5MWifmvOlL+G9kL7vh9w/PVOK3fasHSLWIb22HN+QFEOyYv?=
 =?us-ascii?Q?YaiDeBe7TyGg3kREouPoXejusKSVWqw+AaNllrO33SS5zn9krXbfM5d/rstk?=
 =?us-ascii?Q?uFeWRU48gCASht+VoopMdjDQFOT0BLk/Rcv8CjZRGQM2yMZMpfWOwcIR6an3?=
 =?us-ascii?Q?zA68CMrurpiyqha1yMdz1O4Q4yvQ7smekcHdWnFa9mSpEj074QAfK3QsG1Ke?=
 =?us-ascii?Q?KanLIwKb/nG3Oy0bbw+8AYhINL2UfdwSsOPfEu7xN0JMYwWueiC6Pby5z35n?=
 =?us-ascii?Q?OmNUIOBSHN4C4y/3stladBZT8yS7NGsmiZEFW8O9kDbUqXi5K/O0jUA0V6vt?=
 =?us-ascii?Q?3UPu2NnFZylKi72M+hHE1rxsmb2C2bblPRiU6vVN+F5xty/XkfXBkClvJ0wM?=
 =?us-ascii?Q?8NoApS/ggoDus1lzVdVTotpz9cCzmsV3Dy8IxPOEmqQIz1uyyUtMHWs3mTbP?=
 =?us-ascii?Q?+Z9qQY4q/Gp17C4W1FAWFqOe/4uHF6oVPnhtAzqODuXox/ZWss7kJqLuKmxt?=
 =?us-ascii?Q?ZYuDQYbAUNEIFSjBl7gv/Gr4qT9rPoPYmPDpac9cOrVm2TBw7TGDRf6XRFB+?=
 =?us-ascii?Q?B7SKT+JUUygq6xTRHtdVHF9RzYKtnekZFzu7W+rgSt7AOCMNG+Q4DYojUES9?=
 =?us-ascii?Q?4GZ2+3Wlpj1X0SsuOUeWI8Vy0XgG4aVfQAGU7qtZHRlWDELT7BzZHLBl6qxN?=
 =?us-ascii?Q?N/HPobBmz131mYBpi3srti1ZBE05fI7qbsbx0bHDJAebYKe80XjZfkeRg+I2?=
 =?us-ascii?Q?y8QQyixuZU9QeVNMWLMURKgSW90op4id3SUU9S/D+l++HeIUAxiENe9gmCx/?=
 =?us-ascii?Q?pHf7l+ijltaoQDazBhoAMcnIBFZEPu9tJdEzHM/OsBMMN+wIjSzoTUgyQRfZ?=
 =?us-ascii?Q?dVQ2X2k7z5W23HMyTiQNhF2pXwdfq6zca4abPK5A4Y6LWt6SV/f103VSC6ic?=
 =?us-ascii?Q?wdDyEGrymD4Cv+V0PrbhkYUWTZ5SwYH3H/bLCgJVUE4vNYaoHAOPD8RFjJXh?=
 =?us-ascii?Q?QEH21tCUEKtLhrH9Cv4brwUh+o4jVMm1QZK4ZO9x1RQQZuvlQ+eCtLr433Ot?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Ein2NJJ3UVS7XNHp8GpoOemdP9b6VpKOhhOg0gyz99AMwTyhGUE4ql+A4e/d?=
 =?us-ascii?Q?hZrSJKwvpb2KAykx1WVN0XUa5F7Yhhvx/apcTD9C7AFc2PIp++3Yl8+JbsKx?=
 =?us-ascii?Q?DdLE4Gtu3Y7s20iQZ+Zn0Qi496U+hH1xzroogvzsCHEykxms6GZuNFkIbtF7?=
 =?us-ascii?Q?8sMsXSpBrFN4clg1bZKu+m+xy+L63zWp4J2tcPWWrzC5jOMhQ3If1kPdojMi?=
 =?us-ascii?Q?Uovk9DJxZLXyW543p5eUHkQrxxKrywoQTmTPzZBuNsx7+utD/GaRMb0yGmwT?=
 =?us-ascii?Q?a+cI8lbG4mXKQHVG5LPlkETRydmBRAwnwo+ZosO5dgvjTOKTOJe6XXZJKJrj?=
 =?us-ascii?Q?gZz6siBbn2tUYxtKeJvB70e3oIYadx7Lb5Ulp/PLKK9FtIPAQY4eSVi73yqA?=
 =?us-ascii?Q?bN6Yl0FUssKuHIZAa7tfSZgEZA4o1eRZ4h2bUtpoII+X9klfONPBzEFmaaqM?=
 =?us-ascii?Q?urxJpNz4RXCzUmb2ZIyY2O/DBL/Pes36JPxN4zIErVLuZ1VIWyX9R36TU1dM?=
 =?us-ascii?Q?u2xGHOsEbSgpptChDbdafqQ6AHaZHmIjawFfph5UQlV993VSG7Xjmn4xaw8D?=
 =?us-ascii?Q?yMhcvWPdIT2UH9Q+BOAMhlJcT88UIQ0KdZqLarjLhHnJ09fVjRhGzlBafKqg?=
 =?us-ascii?Q?+vHaD1VC0n0RMm9qgoSbXeY0S6/gpAH5/VgTv6PwyJUKt55RRIHjr+6MxwO4?=
 =?us-ascii?Q?t9EYpTuEF1kxiI7KWxLtQMnDmWVLfjTSomiC48eRMWmZuqo2Ko+wmckHXLur?=
 =?us-ascii?Q?QzG6ksLtHYR9ehD52HzR9VpTYy6LCnjX58KAXY0zm/M324nRTPDePONbbvEt?=
 =?us-ascii?Q?N9TSHRA+VlvYz0917zW6Ami2U1vrvzigyvUHxkpAw+8Wi6UaGxXTPDit+od/?=
 =?us-ascii?Q?k7JvdTGPybMeHaP+1KGyH4Tlz+ZpSyspSWbpsP5Dnhm15nQhKuICfnmtFLj8?=
 =?us-ascii?Q?fyweHXX8jwvr0C77RK/vp6x6uFIw9n8R//EPzhRUF5z3w/5uX9K/dnMEvN3y?=
 =?us-ascii?Q?VVfDKfx77VvLjSCUV3SwmBpMxb91nmvQkmnejYk7HtqvvKjIscmMdb+LB5Xi?=
 =?us-ascii?Q?fpFVcfSkaZSrnvhsj9EjHNSQmhTAmfd0oGkUfdwrnmWYXZVzSBXLIlU/WkbR?=
 =?us-ascii?Q?1nf+sf9VhYIH9soZxVvfyXefG6Lip+DaGzXUCuQ0C2A/SCgB+J16TEEPDEZG?=
 =?us-ascii?Q?nGbOqoD+uMNck56FgkGcD6au/w8GFm6UBITNf4fw/hjofK5BH7vKySTfDHqY?=
 =?us-ascii?Q?iJ4RugnJcFsVwggFj4K6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe95b1e-f60a-449d-864a-08daeec5dbb3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 02:37:59.0321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WlaYR5ecmijwqcMukNWolAsRt5Qke6RVG8Qrxz2nrQd9XERQaTbajNw/XmwLYa1zaeQUmWga9w7oGkDNbhkf/9ozfXGdxB/45UlWkJKEm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=974
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050020
X-Proofpoint-ORIG-GUID: 7iP5En6R_iCWmPKmwA4RDOoj9vi_ZhpL
X-Proofpoint-GUID: 7iP5En6R_iCWmPKmwA4RDOoj9vi_ZhpL
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

>> >   scsi: ufs: core: Add reinit_notify() callback
>> >   scsi: ufs: core: Add support for reinitializing the UFS device
>> 
>> I would like to see some reviews of the proposed core changes.
>> 
>
> Both patches are reviewed by Bart now.

Series applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
