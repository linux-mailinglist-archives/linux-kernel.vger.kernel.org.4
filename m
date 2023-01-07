Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE626611B7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 21:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjAGU4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 15:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjAGU4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 15:56:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14E943E49
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 12:56:19 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 307H7Zdx026666;
        Sat, 7 Jan 2023 20:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=mFc/6L6FaLzrN+XYJG/Vee00C3EoGUjazPCaWX9RXrk=;
 b=w149vxJtcmIRaFx4nuE++hGsAJs3pEgAi5GKBrbCpS8o2FHClWiV5dtlGM0ztTk60vJ5
 GvvzKQpBW25asuLYIg/37yCb9OOKwOLtrvV08bCeZpbg07PQHfx7jQABNbap27W35Ngf
 nHvWY9Ece5l393suSS8Nt09dLb04MnxbpVhhMBQvPxvS2eW50gLVFz49Qcw2T9z4BFPy
 RZUk5z9oP0qRkgsssRQkGOD/2hA+0rNhDcuT6DtxRS62XHSyItT/SvgVzIkkzrLsOew+
 TBnn6Se5TcKK1C2LGcXagXYT09b7qspZLA96LXVZePFp9R4sXFFV1CaEHXMNlFkkx7iw HA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my6h4gbj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Jan 2023 20:55:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 307H0XdF013346;
        Sat, 7 Jan 2023 20:55:42 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy62ka4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Jan 2023 20:55:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dku0MqzIxdDP78/OmnmWkH8ek9gk7odetJ4u6aKUQ8u/wmUztWh6eH52qkdfrsSC5WivRpm8HPz4xf1blhXuQGbRDIVztkljfOq3yeNhOVPJNE/NI/oDaDoGLwWckwTvNmlj7gqq7yWWJe66GkgNcwZ53oy0TsdVBoi3sGc7elb9Ojr/EDbOtj9CqSmmj4LuPxfZJKH0zWnQMhctRA1x0uAMmr2kho0ZqrR1W76LoHIVt6WmXE4KAbLE7A7o/lPTqJNCqBHnatRwM7YL3Imgahd/KiHnvx4aco8GD5yvd+vjlQlhzO4qPN1rEVEJShL1t6IMWZ+IWaR1+TnimsPTDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFc/6L6FaLzrN+XYJG/Vee00C3EoGUjazPCaWX9RXrk=;
 b=S7jy1tVNKkkdguPCPbyhCPEFL+IbfBeHnEPDHOyBPUbc46bEf/bOPmpqPLsbjHKtqq/R95Va+FdVHcqFJlvLeLhVDBwiAFBNo74LzS25hf55WuIejUm3Nf9t40Z54gbm517rSZ4oh1siTLMpBOE3hZdaP2MHq412LzOhHcjGboYueXZwO0E5yhPATR5kcerqbhCSj4xYKkgGiiwhbqAphg8wcaNpqRovsdb0/Cx+BQcE9dAmlFG8XKKYENMapMn0ewO8Mqj9Q4Ja8yBzzht98UHLwqSf9iFmk8SCsg9g+5ztacF+B9GT7xtJPVl5JDDrIbq8FzcOIZ1sfU4RmFEYuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFc/6L6FaLzrN+XYJG/Vee00C3EoGUjazPCaWX9RXrk=;
 b=LS9QyCgYGdwCzOUkJxGH7W7lFCWtayN4kuh+LNfIWb4wLZeZ5M4Pz7FjJcktCuLCcEqL4EEjPKKOzk35jV8hFS4gg4iXgiy1oZoBgSBj8oPRRMI+f3fMeFGei75lJCoktR3OBZ2NzIFmR0FXRaPyVAsLxjo29XDWbX0LK4AZwgs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Sat, 7 Jan
 2023 20:55:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.5944.019; Sat, 7 Jan 2023
 20:55:40 +0000
Date:   Sat, 7 Jan 2023 12:55:37 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable 8/8] mm/hugetlb: convert
 demote_free_huge_page to folios
Message-ID: <Y7ncSXYzCmjzmS87@monkey>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-9-sidhartha.kumar@oracle.com>
 <Y7jGyH9Atv3sPjcZ@monkey>
 <Y7jLVJ9kvBFCUhNd@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7jLVJ9kvBFCUhNd@casper.infradead.org>
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH0PR10MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: de450557-f5a3-402a-01e2-08daf0f188fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NVdLKbXkyD5qUKhUOoZWk0NBlY7QTmN8snxOwX6K9Crbn4Ohe9qCItzlUvETKvnTkJUdEM7UWvn/1fVShyy7nomMZ+BMdLvCRdBid0AekwgxygbViiY/GISwTGVwc6JCE41kplkU2oLE+ZcChfquLBwQr0MrZU6cepUJaRMhzBqHiltr9QRp0TnOYdvQHU0u8dJ0NUIGsTNDzFfsHpBg4w0aEvkWED0Z3/F7DhYikeeFfg7dXjmuNOmUz1m0/gyPvPtZ1cmY3QhifB919VgPOpDkxwCW+ZptzvRHGg0PtYlIGk/ECDwvqz53JpuTScByCTEgi1rNuyRIaY+Zz2FYoyimcoHqINjnZdGfZmGuuDDFNtyQyr/FsXHbx3x8jyxe6PqkYPHCO/awcNpYcTzGmFKsGoRRaSA8A3rW7XCvvzxII+mS63s9s347DKOsaVx+HpKNNaaqxioQ/oyzZt5uknH82BFu8j5AdUK7AB98AsioknurH1fJomVQtPXrn4+sjWT6HDXNawZll2IgPRT190qKhZSpGHSYpgujxLaBFoRdTGh+SH1HIwsAC3VuIQDh+KIeF0SFAve0GtozfFAjSdXlsud3lapatkiZ4hXbhPMXGkOsipjDLuBzH+fFeDZTX3c4FAH8IL6tXfOrQix0aKby9Y2Bq3BpBUq44EzYvviHgIGsEh5sh7zWJlhT80Dq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(83380400001)(38100700002)(86362001)(2906002)(44832011)(41300700001)(5660300002)(8936002)(33716001)(6666004)(53546011)(6506007)(478600001)(9686003)(6512007)(186003)(26005)(6486002)(316002)(8676002)(6916009)(4326008)(66476007)(66556008)(66946007)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wXgGNbKE6mQCQYnQOEILFUt7642zo616Y9flV9nKO4DwraM+jeBSZsIPXXLx?=
 =?us-ascii?Q?kDeX/aY2mlok4l5ZRJ9am7vRqiwNLR9M7j8o+eMkJj1U7m0onwur9ztkt8aU?=
 =?us-ascii?Q?U6g3gDVlUsQYiWpmCMmPzvW/m+EPZ2CQ2c/P6bEk+ZvkTJ+N3meqkuzpxv9h?=
 =?us-ascii?Q?xC1uRnbObMIHv7aSW4lxUxQ1fuhZd8Y3AHuyiaYlEADjNJONQcLq4hF4L8kh?=
 =?us-ascii?Q?lRMGNFSzFAcy2DQE77mIcbP0TViyomTd1sp6WTKptmh6leksQeyuPuhNlRyg?=
 =?us-ascii?Q?r18R4h+4egV7Xf0i6e12P0AuCVJZ1AXAGxmHA8DzfP57GIWKz73XiGDZi6qa?=
 =?us-ascii?Q?pHRQ8g1tBCfrfJZwN4MQiZHdHMsJbPmq9caeSSJrZN16x3eR33Kc7ncdTiCW?=
 =?us-ascii?Q?Eh0eHxsuswz09porBQGAi/L3oN5A106O99CMnc4rE2N/cWCaY0LIcrU42x1v?=
 =?us-ascii?Q?6N0CQseFVXX4oi60RDHkDOf2rC5w/PVoH0vA1D1fNVTNaCC0BKuAWptnIAbc?=
 =?us-ascii?Q?lun4qdR3rNW1g7/tkS35NauqrlAcwCRfdKLBw40vFzdPpnOUhwy2g8SYJlHU?=
 =?us-ascii?Q?pEj2qMQ0sG68tZjZw7idDtnC+5vAB+LxZyybKJXciQAdLRQ0NMDKjAPuzd0m?=
 =?us-ascii?Q?PFeVl+EMuqokWL8HjhIVLDw8uGD7ZoOp8QLhqbnvaslpkvCUNJWvCpH1+Ec+?=
 =?us-ascii?Q?UWEPT2BNoh2ushcIhnWWVHmoXw11qV/UfF0rqUoO9Rpo1hR32L0zJVabhnXz?=
 =?us-ascii?Q?QGLUFZdWHVfnBHZtTO5ROIhWQwAojaTiSiUb8krwDdTn2K7fybADUcJUzchj?=
 =?us-ascii?Q?baoqiOmQPeXd0b3gbK9OQCuuF1MszkPpcuaGq2iNnZ65akzI7FlB57CJGnr5?=
 =?us-ascii?Q?iQayS8bhoG/dDWp3LXgqDsvCJcfVPB4GZEoRLzfv9kWhNyibmp7Sit3aPyi3?=
 =?us-ascii?Q?R+0rxTsrvZeSdcdJiGfIUmXzKfep1iZzpZ0aIVuN2hPb9tSeC3jGQBVufQeT?=
 =?us-ascii?Q?bkpavYcseVpgLRVL3xvPNKfbwkgcwFB884zuxxQjrbkz3rH1ksoMYaDA+q3r?=
 =?us-ascii?Q?GB9nOKErYpdBGt5eA43/HsiQoqeFKSeirG4/oiX30bcrClCeOES4bhacDZgr?=
 =?us-ascii?Q?5oczL7ZO+QStW+pn4wmaImIRVzKrCdtASuHeSucLw2do/kdFW4LESqb/4HZy?=
 =?us-ascii?Q?r70ZZdQ0b+rpLXiTc2fh6IAxUllpC3lLkL12ul3fe8lyJ+kGN+ymqrgo4G3M?=
 =?us-ascii?Q?TlBuXlNgDCQcPborjmHUbx7AlDtoQp+TKdSHgkbzN1CTsNrE0V5wouFZWvYB?=
 =?us-ascii?Q?jnJOUCo6Z76Zn/xf668/w+emdcwDALsZuwy3P3gkc69TVacRqe9UQgAoe5Sn?=
 =?us-ascii?Q?ouIrghd/FRdmid5N1sfMYNMkAX9CBTjJ28bX7PseI1NtGanxuds4U3bJaOPD?=
 =?us-ascii?Q?i1C0sqkkh6HR/2Z0CGsjifQdNoN1UfFNyG1fus+4eZK7xhojz9FgDHO+5pi5?=
 =?us-ascii?Q?YZSwCcENnnZYiqksnCGERI7IGztQBUi5+CmnU52BbdGfUvukqi0oMPOjqyxI?=
 =?us-ascii?Q?3fTkCgg8a4YHEky0DFCR0xMgTBj0xE9mYn+C8jj1Zst5B8PENcYwAsH59ohu?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?UTFud54HcnqOJP+Sro368Dxx7jjDjt/ntR4YtUwJWUcx11Rpf2NuIKJwX/fa?=
 =?us-ascii?Q?3cFQcxjni70D2vYL/vBBZMW5DRpFqInjRyJxP/mArqia2c0QFI8yltgVL0rA?=
 =?us-ascii?Q?W4SdwbK5xPqTRzYaHSwOYN1+jWS3DvP0xNWh/6MQUMI2qLi1CtttPgHPutcA?=
 =?us-ascii?Q?8sGo3St1/XZ8i8au4USR8IuM+k5n8TpRhzYIhU5NR7to1HyerAPP1cAqSs5W?=
 =?us-ascii?Q?IETiXksYC5t6+DbttyvPAPhvN+SEu3Rl/ZltV9/OcKxKZQJquiTQOSbeSL5y?=
 =?us-ascii?Q?KBhf4YCX/EgcJRdCgSB3efxgg1CQTSvlgTdMqCsAI4Yhu6duaABktYTMrdM4?=
 =?us-ascii?Q?z2IQKEl20e7Rg2roxNpxaIWSTpN3b1HwP9/tq7s4AB8gcyuMKme2wU0P0ido?=
 =?us-ascii?Q?6YkbzRal/8d4y88rT4UbV2144bJXYRYvOybZosBrn9mv02jYDSB1/qbcpsA2?=
 =?us-ascii?Q?CHr4oM2xoQgFiPzLNEz93q6v6TEER7Wn+rOJWtfnvoZEawgXiHI7HDiGn8aa?=
 =?us-ascii?Q?V1wcQxZTmlryqG+5W0W3Ve7gfMR8PSXaiMiCZPeCtLua3sN1C2xixF02NzZq?=
 =?us-ascii?Q?3LtG2cewO3KLovmNc9HKablyKRW3voZz+XYGO1thb9IIu06dxDy0mnvClaks?=
 =?us-ascii?Q?JdS0mODk31WGSxfNSkYgfgWRESQm4wH8l1a/CDhHSNkK+P0BEBL1Q+EbJ/3U?=
 =?us-ascii?Q?/swQ7KcAtynzPrGcgYdZiew4CbSP0ty2mvUGkpmcIIlEhiApidyem7weVe6N?=
 =?us-ascii?Q?0nItsMwToDZ7GJYX6XU74mzRJsFoM+AFmJi6Q5xH90zPrD6RX/nn8yszVz3X?=
 =?us-ascii?Q?mXBB7UuSueZqfaqlCe0x5bq2SmLXZ1G5FT3Pij9HTPOU7u5O4Ys9QsFY29ym?=
 =?us-ascii?Q?s1f3q+RYIVqHiC/sfmhfGkjHNpOS7rxztzz9wDL89AokqVg16Z424oTwZuX4?=
 =?us-ascii?Q?JLnriryxHBid+VVr9n8W6GSFONTnGHHWaunwuweXi5k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de450557-f5a3-402a-01e2-08daf0f188fb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2023 20:55:40.6969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xUQIMz9+RqwpdjdTybIQFkH/8mdrUF5/5y4fFbMcd9wREbsc7QZQay5P1HUCjNSB//bnKf/8SuFfAI1mmOR6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-07_11,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301070163
X-Proofpoint-ORIG-GUID: 9m9N5idqEi1EyABeWPndsCpgtdThyA3K
X-Proofpoint-GUID: 9m9N5idqEi1EyABeWPndsCpgtdThyA3K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/23 01:31, Matthew Wilcox wrote:
> On Fri, Jan 06, 2023 at 05:11:36PM -0800, Mike Kravetz wrote:
> > On 01/03/23 13:13, Sidhartha Kumar wrote:
> > > @@ -3477,15 +3477,15 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
> > >  	mutex_lock(&target_hstate->resize_lock);
> > >  	for (i = 0; i < pages_per_huge_page(h);
> > >  				i += pages_per_huge_page(target_hstate)) {
> > > -		subpage = nth_page(page, i);
> > > -		folio = page_folio(subpage);
> > > +		subpage = folio_page(folio, i);
> > > +		subfolio = page_folio(subpage);
> > 
> > No problems with the code, but I am not in love with the name subfolio.
> > I know it is patterned after 'subpage'.  For better or worse, the term
> > subpage is used throughout the kernel.  This would be the first usage of
> > the term 'subfolio'.
> > 
> > Matthew do you have any comments on the naming?  It is local to hugetlb,
> > but I would hate to see use of the term subfolio based on its introduction
> > here.
> 
> I'm really not a fan of it either.  I intended to dive into this patch
> and understand the function it's modifying, in the hopes of suggesting
> a better name and/or method.

At a high level, this routine is splitting a very large folio (1G for
example) into multiple large folios of a smaller size (512 2M folios for
example).  The loop is iterating through the very large folio at
increments of the smaller large folio.  subfolio (previously subpage) is
used to point to the smaller large folio within the loop.

-- 
Mike Kravetz
