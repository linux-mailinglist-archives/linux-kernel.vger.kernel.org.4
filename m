Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C3160CBEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiJYMey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiJYMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:34:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB8211A97A;
        Tue, 25 Oct 2022 05:34:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29P9A2GV021680;
        Tue, 25 Oct 2022 12:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=f6sunfq8n225qH8D/vy0veweBmx79LQrthHlmetz6b4=;
 b=EDBQFadOU1vGzqrjbMVM8ep/0YwM65n9xELpduYM2Tcjh97QXOfLmpjZly3/cK+EKF3a
 jRCXGtfVBXSdbNNRZofNeVa6ME2bxfvZwRhZGBy/0vvAwnbaSrwwx1VCEnpHRk0cNdNp
 driCQbRc21tQJupd9aaujZk5O0+ib2i/SdpnMyq4NzqiIhCJw9QUhJwYhpEgVwfeUia9
 Yt3CV/9+OtVSMkt2EAiHTnU8fL4eHQMdQxg/Xcp4fjr9O2YRbFlHUZ9G4UXGan5FSWSS
 k7ATzmaukdx9l6UmivXrjG4g85Md22W0ll7R4C4uefvyNpMZflW49KNLcmIzIKZqZ7A7 RA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc939bv1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 12:34:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29PCOjJ4017267;
        Tue, 25 Oct 2022 12:34:36 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y4u82k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 12:34:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgsZvXs0BYduDaooqtkjtMwW0M8a6Kmo7e3smY83+4aUTnBp1t2dDmnwyKZ4O6/1imFzQ1DVBxUhxbunuiABzUs94H+r5Dow8MLGyKJyONb7cppbxwE+f/kpbmrXEuwwLVWQ2uZ5l3arUKt+hHLL6SqxyxDlxbKZHWMk3OtDIb65CYexDqeymAdN8MRSF+xU3tOqSTgHOiwLYUqny+26od/MJZrI+VzQEpqiHIxzozpYlxqRsBnPagsBpvqxwRXa+XrBUz/pn8XgcofDww6SVHOKUiNCHe6rvir6KstpYOVJjTkUEF9kXjADY1ufySXxEq+OEQLLk9IirPJsHzpvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6sunfq8n225qH8D/vy0veweBmx79LQrthHlmetz6b4=;
 b=aYtsDsEF7fnVlslvaf8d1ISLvEEv+JW4ApImUy8MBytr53xLAQViIRPWTuC/kOTabs40cMbQWAAtLL+Ss8YrEdv63bo4zpIX32v3WPz7dr7SKXI9kpH3rabaNRoFd8C3QEVbp+rGppyKld81qwl+DOkPNahofL2yn0q1u4UIypidsTgYGxYzGiBENlghv4+cZ6cJyjx4h+BwCsawb9EwlpcgF0u7dX8LBj7s5FbN78V1YXIwNt8nsXVTCi0zhZNCqfH2y5W04mRRGuWl588rslUFPjbXL5tLzD9hS/4tpk2Sbc6SKEALz3HVNyyYpwYIH/p4yfwcQIS4Ah1+azm15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6sunfq8n225qH8D/vy0veweBmx79LQrthHlmetz6b4=;
 b=eabH3ffVWqq32DULg5wbIf5CRNK2FoCiZlFEAVrBXjB5daVo1xNp9fV8bJEv8PONbk76u6QKG3N3j4OOYOkIGLVH3Av6MxUoa1L/+yrMhp8E3KvBW/RryrKx9vmYLvmAEvcZyu8iE4ku1yL6wvOQiTX5uXDY6wf6Wh31fMarhUk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5029.namprd10.prod.outlook.com
 (2603:10b6:408:115::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 12:34:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Tue, 25 Oct 2022
 12:34:34 +0000
Date:   Tue, 25 Oct 2022 15:34:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192e: remove bogus ssid character sign
 test
Message-ID: <Y1fXzQIz7nta7aE8@kadam>
References: <Y1e+SmS3O2ZaPVoe@kroah.com>
 <20221025122150.583617-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025122150.583617-1-Jason@zx2c4.com>
X-ClientProxiedBy: JNXP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|BN0PR10MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: 57501ffd-5421-4354-8474-08dab6854574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8MT3hI72lqS2z+YqT7e3rGDrMqu/vF59EYlftwGyH4gljgD/MHDUQVntOubjY8zbjwQ+NuTRcW2+DgblNPYD6dtgaugxI9/LXXLVfN2Va42MHoGf24qLFU2tOFeUDCm9BYmUhUXEzm2nXaUh9W1F2SxdEh4p1xlg0+hyKMwSYS4ImXdvKTrQOfYiq6eZOIWRYZDbFdlcJvTA1cbL5FrdmyUtnAfcHDqUk2TCfTxGAzn34K+7dNAz5rQpFz+vsC/0ZC2oQwi8fGM5ASL363uVcwvoO0q4+uff/hcJSnB63Dl2fRfonaz4xUp/9r+pK6MrGM1Awu8O3yx8Zmk94tRgafmBffjLfR7dl2jBzc2+CkH4B1Cw9E+QdxA5kJemVkp7wfClZQ2BgJP8jbh+kKuNdBcIKOXh6kgsIug8APOn08R+hO95nFJV8m6rD7WQcLk+EMEG6GlvzrGFHH/gu3xYL5G1Po4FcxtIXqEZq/5y1FcxBwrDicAKrLMXWQ2WwIocBbh9edWqLTYnI3rmf/vSgQndEeiKkMIr7s1PGkMCV6Tm7YyLA8LZ+su5RPbw+RYZflu1JH2/1m+uGLweXO4vBOQzJg/2XvKmMMshg+ru4YvxYXlRAaxCACjsC0uYpGkXIvMVPe/qMplc6oJRVN+6S5ee8NsC82OPkZyE3WUtYU+ykkiXt8zNpqarnThkL9LNJbIlihWYUIhkd4lhzcCAfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199015)(2906002)(6512007)(6666004)(8936002)(9686003)(33716001)(44832011)(5660300002)(86362001)(4744005)(41300700001)(26005)(316002)(186003)(6916009)(6486002)(4326008)(66556008)(478600001)(66476007)(66946007)(6506007)(38100700002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C9Ebnp3qcF7g1CaU8GaRSLzdBW+Zb/vDz+mIUUjtc990urEvpoIwJ3LGRvI4?=
 =?us-ascii?Q?SSS3BUMe0YfYpzRVPTEraie4KpPCg/Iys6c8VOi5Qnoon2pIxLRs/34CzSEa?=
 =?us-ascii?Q?mdwGa5uv8VduqRjI8I8bV1GOgMXeV8M7Z1C+PLhf6hOFvt1GncBkO8S2OEyD?=
 =?us-ascii?Q?cQbe7ubA5GQk34pmCBwf9XffTalD6kKH6VTqQ/NM2WZsuwUj0fkjwxk6S8l/?=
 =?us-ascii?Q?WpQt8JiFdyeDKQXVXlhoq98cCjxr1An7AWi0IZ2MYTrHxL2P0LxADyaxXi3a?=
 =?us-ascii?Q?s9RTJ+L1eQWn3keSBQX90eDXo2A4rAPPSA0G/Q2Fz8FP3w6IMO2QMWBB2I5C?=
 =?us-ascii?Q?hlnjll/ClwjllNNgmofIOL1MZYLX3HQtVNkl0BhpIcl8yW0ZGziJaSyjM2pP?=
 =?us-ascii?Q?KtdTtbLdKyH1yYRWh6qt5ryCacNei9B+HCz5JK1kwgOYn/LFn5k3+BQ+gmkt?=
 =?us-ascii?Q?Z8Aw/HUv/Iac2YF1yQDlgEF1arpVovZ+keXukYzKtOHda25If/wzXoLcPAdz?=
 =?us-ascii?Q?uhZW/p5QIqXVd+ezSbO1IKZT56YAj1DkFyDYP+Lms+cgnY1SYKGN3mHAJHE5?=
 =?us-ascii?Q?caWnpBqziS4lT+yq523BtSZxC70YGRnboEF4T02RWPCnG0Pmp74c/lrKs8wx?=
 =?us-ascii?Q?6pHxW6bn6a7zGPYTTee/WqQQjlEs7JpmZcPCuWHlThMIewrDPs5DEdHWcKW1?=
 =?us-ascii?Q?OR4YMNJ42UiaAdEFPoDsz/nfEHZ9bWGl9jk+3gqwCHoaoQhipnNQEMdD8hHm?=
 =?us-ascii?Q?HuRebtQhZRSpfdDmAWfNSSfs7FJCoGcLECo5Xo329OapY6T65sXgRZ6fhMjb?=
 =?us-ascii?Q?dCCQX689cQcI+Ii60SMIzlOJVQp7AkxO7PnG/nZqV25VE/aTBm4k3qbqROQn?=
 =?us-ascii?Q?tND7Uww57KhJCL20yojm6dU89T2oljPzC7OEQeBtV1s6/nOdICbP/191GbO1?=
 =?us-ascii?Q?xwRf5kQmYTLc+SvV/epNkJw/q2NK/5en2M5/Adw9jDFGM7DhwfvJReCwmE5a?=
 =?us-ascii?Q?ELLKfvxcg+lyD0AY8io/ZE89HkcOBT3PdfgpcB4RjCLkVqBS4rHGSgKyxD7d?=
 =?us-ascii?Q?2Fi0MUTD6Wbp5h49Sv+6gfm7dcy0gNM8SAmIKQRjDpHAQSqQiTUfu8jbFdnx?=
 =?us-ascii?Q?fg/xUL/73z9Me47g6/OXhjg99FKXFIi56qlfX9ZnKwHtrerGHmHK1nltQ0RT?=
 =?us-ascii?Q?cL2YgwDWZslcSk1CqVA/WPZI18luCJuVLozPEFWyZcmXD1Hy8zs+nLtvnTYN?=
 =?us-ascii?Q?D549Fkn+NjUZSriIsgHaTXqMmAb5ajD/kaeg6oax+i3t40Rq89dxRuNMm0sa?=
 =?us-ascii?Q?eTCxXMwTNUC3w+3NZ+h02plGtSOuo4pv5qS8sslqnHeRUEXsmo6gsaux5IJe?=
 =?us-ascii?Q?GW8fPxM1Zj0Ql5gQ4mMJQU4gsFbarqwSxUlThno0dUvpVCwKC+nNvG6gHpGL?=
 =?us-ascii?Q?dZxSVpZPBrLFNvz5XV4jQBN3YDAP3r0ZicRjQi7uU859MOFfUB31f9HGnd0Q?=
 =?us-ascii?Q?uU8V8eVPcPrJT4GFyxBOcTmLyOypd5m5rGeG+jBEtMaJcHEM15TCqvN2EUsM?=
 =?us-ascii?Q?GkwnyzyTFGo516c2sNLGqZMNe8sxUmcEikIizBjFghwxuobMYLqi5Jq0SZwk?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57501ffd-5421-4354-8474-08dab6854574
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 12:34:33.9765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfBI+tlbwcX/Zk0KmeqLJomnIHw/2NaYyNGuiADn/BZBo4TVIaeGchixyAGDM30w4X0tt3ygGOsc2e7SMRdzYpKLM+GJwAl0woL//hzGR64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5029
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_06,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210250072
X-Proofpoint-GUID: 4U1mmXViZWabIupgSNu_NYSGHlE_d3aw
X-Proofpoint-ORIG-GUID: 4U1mmXViZWabIupgSNu_NYSGHlE_d3aw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 02:21:50PM +0200, Jason A. Donenfeld wrote:
> This error triggers on some architectures with unsigned `char` types:
> 
> drivers/staging/rtl8192e/rtllib_softmac_wx.c:459 rtllib_wx_set_essid() warn: impossible condition '(extra[i] < 0) => (0-255 < 0)'
> 
> But actually, the entire test is bogus, as ssids don't have any sign
> validity rules like that. So just remove this check look all together.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v1->v2:
> - Remove ssid sign test entirely rather than casting to `s8 *`.

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

