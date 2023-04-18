Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA016E6C73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjDRS4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjDRS4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:56:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF2772B4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:56:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IExOH2015476;
        Tue, 18 Apr 2023 18:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=jqREY6rpyAHfcUE2QS8TYfxY9JBtxg13y/LmJg4gdYU=;
 b=1WbBVPbxnTl7540VX6A0ZLP5eLFzKsz9XP96mhWA7HQCwqPxXCz8WrMNrPuXsMJ6Cdpz
 pFfWkdwO9dLhO5f3xFeTkgz0nLGS1K09POMjZ62qLBD4yPsgVk+y4KJzVbeVdL5Axz1y
 dit5XGnY5T3SVuBOvCPPEnB449zZP8CoF2KCW942cGoYWjq1ra8dWdolR7XGWflnEIVv
 xa6bB0uKhOwmn8d8JrurzVYisCPQBm7MzrM4B9yAdyZ4gqjyPm9FOwyYzuFJQpsjEALT
 op+CTsWRkKMbiiD8l0Ws8qTE+ZYiLO990AFfP+tCTG3LcKu4JU6m6IvO3727DJ4pJej3 0g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjh1pjfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 18:56:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33IIrknL011419;
        Tue, 18 Apr 2023 18:56:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc5nx5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 18:56:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdJvW3UyBWXQDw1CH11LqW20eev/gtDKpclminsA6mKuj0+PFj3eUW8qBEYL7Pu7LMiExSCNBDmaHQWx0jZJDdGjNZsmMI0ih5D9J9OP0PgVhgM5yN9fXBLD/hgh6Xws+MdwIH8TS1LuvlDswvL1XAx5ZOEF6UYC0UiTbyWC79fzEXpG2J/QyWD4dhuXBeBAo2S1y08gFo+3ggRSfnE77UD/2r8ezBczvmbpAzs77Qe+cbhNShoMXDhi59ttRZq2Dw1XqCv0hzebS/srHTY+Wxjfvfm6UTdWeHx03b/cjbyUvXapVMI7wUhiB+QGSle/g58bj3KR1yMZLTnvkL107g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqREY6rpyAHfcUE2QS8TYfxY9JBtxg13y/LmJg4gdYU=;
 b=Ueg0PoSx+cAvXNAsVbOwSIN/M/AWRe3nYhR6Zj8iLVxzOlAVbS0eGj8Xqj7ERm+4o1sFmUJ1/FGtgyyywfikfR9uYvhq8watnzqVS6/JZfy9cwSE6Zg7MxG0sNsNoorW528akp9L1FEByITyBtzZrdyIqGiXQHorxF58BaRG0hjPw2NlqcqGkEQSKWXf8hor+A3Hdf4mimomDh7QDEHwP1IKNtU++rWBProa7M7wbPjsm4l2ljT4jZ+eAz3nX+ODJwWZI0x3WM6dkWyb9N8Ooc1KqE1lYZnJ/TI4AXCKCkgQI0pp5N2A3frchSCFWJ6OByqXByCEVoiilIroBEUhpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqREY6rpyAHfcUE2QS8TYfxY9JBtxg13y/LmJg4gdYU=;
 b=uWxEsYYEVPA2/EVLIE1ohyek2Nm8FsC5QwREkvTY3Tj8EhtLFn2KVmc+A1cl4q561uL1VBgjbH9+zraIrKr5l01zLHppFOZnFlmuJ2TgDh5nrs5rgWoX2AiDSdjn6vsej5Rf2gm1EfRU0SWa1EdxXDMEozPtdCadDWFdcQJId0s=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ1PR10MB6003.namprd10.prod.outlook.com (2603:10b6:a03:45e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 18:56:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 18:56:12 +0000
Date:   Tue, 18 Apr 2023 11:56:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tarun Sahu <tsahu@linux.ibm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        aneesh.kumar@linux.ibm.com, sidhartha.kumar@oracle.com,
        gerald.schaefer@linux.ibm.com, linux-kernel@vger.kernel.org,
        jaypatel@linux.ibm.com
Subject: Re: [PATCH] mm/folio: Avoid special handling for order value 0 in
 folio_set_order
Message-ID: <20230418185608.GA4907@monkey>
References: <20230414194832.973194-1-tsahu@linux.ibm.com>
 <ZDmzyag88pO1Kdk8@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDmzyag88pO1Kdk8@casper.infradead.org>
X-ClientProxiedBy: MW4PR04CA0213.namprd04.prod.outlook.com
 (2603:10b6:303:87::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ1PR10MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df69f3a-e348-4722-28ad-08db403e942b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nIi0jCxNdhBcTy7PFayca2U2rBZG3xN+qQcVGUv3izQ75XV75EkImZG3YFeiw2+WYt/M6l1Hdp2joG6XstOXbFxQlqfSOd7rAcOBQvwC3/5kqcBM3sZKNb6Ue+vG66p93rdS3S/ioRj681H6NX9si58CtlQ/M/ec7uxl3Mb31q8t0Lj8HEjrOOY2lgjfEBRahRNHzW74Eki5NP8LO7/UddCGvml2okOb/2Dq72dgA8xCFZXEcX43sLCsAfpNsxG7fDOJWHAtFzkgRlkuwIZpihFNHMjE+UzYMnn85qMQ9QGOpUqXHujGq7fmPG08f6kNqkeHl+ZLYNfoHcWIXGttXeWKApcTPlRhIY8OINFDjIm+D6eqGDVcTmUidu7dm+mvXSOQY+JQuo9L7WzWgOUzCVDFoxESmRbfkRjWaSCLH/7y+6dFUZl5tEvSqECK7uBDyAB0IKlAJSLqz4xigKeZEM0H7yL7HnJbD6jVhXX9NB8+brZ7JuH5SilAg9De57c3NlUc9KhUr6UoYp+g+sGV4vv9SBHHwIBlLGTL5r2kFHmClKxslNRSZVZLwqqLLqo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(9686003)(6506007)(86362001)(83380400001)(33716001)(6512007)(53546011)(1076003)(26005)(33656002)(186003)(2906002)(44832011)(5660300002)(6486002)(38100700002)(6666004)(8676002)(8936002)(66476007)(478600001)(41300700001)(316002)(66556008)(66946007)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G9Vifwkp2SHsHTBziw+uvJQIicBVYwR9KOYE0wUOwIGrH+E08bCXgKIlMueG?=
 =?us-ascii?Q?cU9B9Hvqk8bgFM8KPZaTedlYo4p3lf82pB1Cr4MPYd0Ztdl1819NlVidAR25?=
 =?us-ascii?Q?LWzJ9n9PhsxnRDEwhHpNUz0lIFk5JtMRueSpcpywmSRP5PzkuHXN1NdnnGe9?=
 =?us-ascii?Q?GtIHuGkqUQPB3bwTnPnQKxU0AYy6YM9uabG/OQLR52DGAGJ+IS+HEoO7uPPt?=
 =?us-ascii?Q?pnjee/Aq9k9be+Lp3uh7ZYRvDu0gA7UDm3A9tWgQYd3JiwxDoPL32S/xNuWv?=
 =?us-ascii?Q?u15mM7EcBk5yWVimeQFHvpJGPgfgoROvpav2EFB2+JHXwaDVIQWD+sx4W32L?=
 =?us-ascii?Q?HNGy6/MVYYVusRw5f0P6eLEnCHyDGVci8atS9ttwnPxUDoNwT/H96C+Wr02C?=
 =?us-ascii?Q?+EkZJhdZxR8KWG1+QlzyXhl/28x0f2cfTWc9OC/tMmqv9IzmG3p+QZRc2wKI?=
 =?us-ascii?Q?w7tLnMxLcoy8vLrSFlGxORK2vwLFbL4xROfAEJiDIfXZMj4JEwLKkq4bsACn?=
 =?us-ascii?Q?RkwCe5KoGgbq9jDLIIR71cdnGP5ArGqBPmp8Qrvjr3GtW840VT4Kp+dZ/955?=
 =?us-ascii?Q?jT1obd4DHRDFCcUSyH2xIAD7qQrOxewfBWYS/7u0skhhtlu3zuUg3z+mlEcq?=
 =?us-ascii?Q?VzIO1vAjezfilBoYhmZs1Lr9DIn0Zk6xsR8C6tq8H4TF8KJvvQ8oqV9Y94Xk?=
 =?us-ascii?Q?L3Cfj+6DGHmitRQvuBl90D1/zfgxi0L5sQpC09I/InDcz25tpT15S1A10fNs?=
 =?us-ascii?Q?IKsqao+LZp/CRPa7W0DOPtiXXzjKV4qNDl6/QiLdNcxv9f4P7fMWkrg8J4IZ?=
 =?us-ascii?Q?hLJ6gDAJb6uqnat4M4vWE/XgOD8l/WMz2vOEty5XsJRJsWVoPdNPCkVWSnlE?=
 =?us-ascii?Q?16akZi5n1JMP+RGRkal4XAkD3fSys5kNy3yQq6eUjnC/rx3+1sD8tYu7bOK1?=
 =?us-ascii?Q?cE7YR7KPmtwb5vvFAbtaUIgfILBnUYgevTrqF50W+aYKWLnqJ+8b1yuBP/oE?=
 =?us-ascii?Q?m3OJiQqZ4uQF9TgbkInO5ldcpq6beb5d00bUJt4cC2A5671p4LRUSX6iYT7C?=
 =?us-ascii?Q?Ba2Efyin3vMNSu5/RY5zOHjL3a/+E/MQFruq7wDHfPldbcVkfe7ihXfdN3uz?=
 =?us-ascii?Q?lOsXFaGaUGPzjD1/ZdomfTOA3YoLlDHK9NetcY9KrRhbJVaOQKDmkDBMPdzo?=
 =?us-ascii?Q?bnmyhynmRiPitZwdC8Fvzc8nARz68wPipO3x6m7e2+3ZBh/Tl2c+MptPTla2?=
 =?us-ascii?Q?Ui/EBcA38ACaz3qRWylEg2VxEVi8Sx6tIYzEt9zh/zmF8tWPnIZb137bSba0?=
 =?us-ascii?Q?pYca4b7P2+t3xINosAhkNSzQsUt1zQo4N+nmAfpN2GiegeBFTyY9qLCc8IUf?=
 =?us-ascii?Q?uZsKtwJj+AGh5nQVMXrw6HtXqoSyHb13jPFxSIUFEqWA6biwrxKHhpNLS6rU?=
 =?us-ascii?Q?yJuX4wJKq/rRU7Jhq8RIKz8CZvNIuuvj9IYhz9g7iw2ynrfU5eWaE3FAU+GZ?=
 =?us-ascii?Q?ld3qO61pt8AHOCiKeEl7jPIZ84xAhwMbY/LiX1360+cDWcSrZz2WY2OOpeBe?=
 =?us-ascii?Q?cesIfpVKfyL6Gyfydi+gHOQBFeQH659QoaL+b6lfbAX+1ajKdd1WDg6k911K?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?y7yTU0ff7CYOwZDW8dSrQXeGiMNLgMyXLKFH74e92ZOCTHSRh8rdfDVkDi7B?=
 =?us-ascii?Q?GJSeClMh1DnArms3rZhZHoVInbNGHitJLhsjQV//QtYQvdCy7WpA4nEjdtxy?=
 =?us-ascii?Q?ebWdjRQwGpycrJh5OCVg2gXNlphqLITcxP/FUWtgw2GpV073Zbwd4rN1p9ct?=
 =?us-ascii?Q?R+zXmfKvPIVyFsrhA6sMevIJSMsZXV3hJKwHqmRZ8IhknfYvx+h9gocTi8vd?=
 =?us-ascii?Q?rLzfNCxwaEVZ8dqJVTh7ors48z+yltKbgdhL+OIRw6R3kE85HGV/GAA5WUif?=
 =?us-ascii?Q?KLEWDptiJ3+lMoVKS5S1Rzx3EBMVU/QWRcYNUkyn4rMC/AGBGx+8VPUi7W5D?=
 =?us-ascii?Q?kwwZaNpQH+LLSgwNMn/mJY78kTlXGOkwTA6q73TZkeFfCHTHFs86X7+FPi3a?=
 =?us-ascii?Q?JNRgM9pFSyZLMjIKFeSFzNVQr8QJOLfhr/2zsXVSqO16LQszabjov6P9v9ZJ?=
 =?us-ascii?Q?Zu5c+d8elzy/7F5PtEQfYcI/LZ9iAmpgGwqeA18+3TK4s5mcN0yTP0JPhbFZ?=
 =?us-ascii?Q?Ud39KHIbxiBXH28twY4G/jplNhE6lCNxcGWZ9+Q2VLIwCYyCx6BFngW3gzeE?=
 =?us-ascii?Q?ZP0a9gGWAD9Xe10vHuhZY0lW7vEujeBar5oys6Tbke7/rRdHbI1tuemKTEw1?=
 =?us-ascii?Q?8pR+xVrlN2zpyxk9hKrO57LKKAkm9z6G2efRMTB3lpx5bQmwFenUvQ5rSOj6?=
 =?us-ascii?Q?pMSgRUozMW+/JThjpvDw0wd/117FKj0MfZvNBuOpXduoNDYT30tftg4lVM3Z?=
 =?us-ascii?Q?lc6LMap1ImVDyTyQyDLRZHWO1ZB1WK1A6Kwide8sUXcd9stNh3FvTLHY+KQT?=
 =?us-ascii?Q?OyYKOe5nSFK7BQh358530VMWMVoMZit0uDAN8ZRyAi4qIKVS2Gp3X5cSmb11?=
 =?us-ascii?Q?7vzr4EMeKkJ1Nf3F1AwehbVxrtUJNKgdje8+zyQOCeXkm37LXdNwmlYpply+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df69f3a-e348-4722-28ad-08db403e942b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 18:56:12.4129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIxD4RlQtF0KArpkEXXxMEx5OMr/o0yJXi98PvY1wnAGlL7DbLjjLKTY8Hjv9DMqwg5/YR2Li/cMDIJz4hZ+xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_13,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=889 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180155
X-Proofpoint-GUID: y0W6UbsOJWghT_LZReG3QxSapPYE88GM
X-Proofpoint-ORIG-GUID: y0W6UbsOJWghT_LZReG3QxSapPYE88GM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/23 21:12, Matthew Wilcox wrote:
> On Sat, Apr 15, 2023 at 01:18:32AM +0530, Tarun Sahu wrote:
> > folio_set_order(folio, 0); which is an abuse of folio_set_order as 0-order
> > folio does not have any tail page to set order.
> 
> I think you're missing the point of how folio_set_order() is used.
> When splitting a large folio, we need to zero out the folio_nr_pages
> in the tail, so it does have a tail page, and that tail page needs to
> be zeroed.  We even assert that there is a tail page:
> 
>         if (WARN_ON_ONCE(!folio_test_large(folio)))
>                 return;
> 
> Or maybe you need to explain yourself better.
> 
> > folio->_folio_nr_pages is
> > set to 0 for order 0 in folio_set_order. It is required because
> > _folio_nr_pages overlapped with page->mapping and leaving it non zero
> > caused "bad page" error while freeing gigantic hugepages. This was fixed in
> > Commit ba9c1201beaa ("mm/hugetlb: clear compound_nr before freeing gigantic
> > pages"). Also commit a01f43901cfb ("hugetlb: be sure to free demoted CMA
> > pages to CMA") now explicitly clear page->mapping and hence we won't see
> > the bad page error even if _folio_nr_pages remains unset. Also the order 0
> > folios are not supposed to call folio_set_order, So now we can get rid of
> > folio_set_order(folio, 0) from hugetlb code path to clear the confusion.
> 
> ... this is all very confusing.
> 
> > The patch also moves _folio_set_head and folio_set_order calls in
> > __prep_compound_gigantic_folio() such that we avoid clearing them in the
> > error path.
> 
> But don't we need those bits set while we operate on the folio to set it
> up?  It makes me nervous if we don't have those bits set because we can
> end up with speculative references that point to a head page while that
> page is not marked as a head page.  It may not be a problem, but I want
> to see some air-tight analysis of that.

I am fairly certain we are 'safe'.  Here is code before setting up the
pointer to the head page.

		 * In the case of demote, the ref count will be zero.
		 */
		if (!demote) {
			if (!page_ref_freeze(p, 1)) {
				pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
				goto out_error;
			}
		} else {
			VM_BUG_ON_PAGE(page_count(p), p);
		}
		if (i != 0)
			set_compound_head(p, &folio->page);

So, before setting the pointer to head page ref count will be zero.

I 'think' it would actually be better to move the calls to _folio_set_head and
folio_set_order in __prep_compound_gigantic_folio() as suggested here.  Why?
In the current code, the ref count on the 'head page' is still 1 (or more)
while those calls are made.  So, someone could take a speculative ref on the
page BEFORE the tail pages are set up.

TBH, I do not have much of an opinion about potential confusion surrounding
folio_set_compound_order(folio, 0).  IIUC, hugetlb gigantic page setup is the
only place outside the page allocation code that sets up compound pages/large
folios.  So, it is going to be a bit 'special'.  As mentioned,  when this was
originally discussed I suggested folio_clear_order().  I would be happy with
either.
-- 
Mike Kravetz
