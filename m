Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2A9611774
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiJ1QXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJ1QWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:22:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C686A1DC816;
        Fri, 28 Oct 2022 09:22:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SEjWW8030137;
        Fri, 28 Oct 2022 16:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=8YJLhi7gI3v6i9QZknaF9uO+U7de8FrzMeEk5/i2jrY=;
 b=cT0bRsRCkLh2cFm5QZzbvE7ngFwk35/8ZeyfxdBt4ZqCFftLxyhiH5bLbDszN41YQcDl
 Fb99OE+T3LbRvDmwTNrdxmpcHpsgBC3WVlgl+CgVniLv/gLUaWPLIdYYWOqcBMmKGpW/
 GoZ9390lvmtWK+HBvGqY8q0GRLxP+ZaKVB+jZHgqaoemAwXuxMr5gR/+xg2rmj9HcGqW
 pldhSF8YiFufAqW5SO5nUBRNGLAWArLTV+ipdg9e/rq55FjS23gUp34N7GVvwBBR1xHT
 14vFRE39/++QgrHzfPvU+F8MW0N/1nVbAhL2ekOdPx3mJEL4AOgtnu0eK5nz06d72tTD 5g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawrwhjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 16:22:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SE7Mh0017470;
        Fri, 28 Oct 2022 16:22:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaghqnwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 16:22:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDiItAz2jvtbtJo9bNRKbXi1KcnN1j/DV6UifCFEVkzpFIEfR5Jx/gNwPgXZ5MzR3V1QuMRYpQEETMvXkQ0ZmCeVPa+sJmJWp+IhLz7QeNt/ddmx12Drbbg65p3y2lyd1ejUcaH7FR+hijErl7MvMi+ThXkgiNWVILHsDwseL34D+LDe4EY03pptLgjwbCfoWz0YO5KlbVjUqe3niJyMH+X3EDUFze4waUB1Twc3BeRpwp2hF6MYCFt5l4WXShaPH8W69qKIRMr6ck8Q2qiIShULEyWb2dPqvYUbT2ihxNtSmsK637t+37swZ5xWM6RnuKhRhmAMvgkxnz2vTi3PYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YJLhi7gI3v6i9QZknaF9uO+U7de8FrzMeEk5/i2jrY=;
 b=HMO8dSbZv03O5LdP//9zTz8GmJalfNJobZe/JMTFsCAunf9c9dCTSb/6NhdCVx1i5yLseNKwTaac41FIXxjJc4dlIA+4rF58NQQT7vJGSxD2Ac1nACtFZDkBek+gLCkhngBZ6fhf8kq0ueq5uEtaBjJ1ArPN5GKJKUKSKcrM6kBXSihNb1eHIFzUEj3mEH+T4hAsOcvT4jzu/5mY3Yy1rNRD/4gg9UPXRjSHxKl+Q+Qq/Gup+P8ooNJhPjeDxirFuwBwTQ8p76srxGQ/DL5XZl33qqmjoM2oG4m/+NaE11UAMd2FJ1UTH5mPg6cORZGphyoi3QhQSf+8HfdPG1jmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YJLhi7gI3v6i9QZknaF9uO+U7de8FrzMeEk5/i2jrY=;
 b=GGd98zJ+Ooy3QTf2QOiDvuI7Oc+AKSoBTtBy9nczm1jgkyR0zo93DoGshmLAQWioOdL1l9LSw8KHNEcGbKVCcxupYftX+nrfeR3ShzEmP90r1UDRsTd5A1gZbONOMQTtWzj0Jxo5yXuXyFlwFx/AUSiQa0a8NbTZOJrAowAqL04=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by CH3PR10MB6689.namprd10.prod.outlook.com (2603:10b6:610:153::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 16:22:40 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e%9]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 16:22:40 +0000
Date:   Fri, 28 Oct 2022 12:22:36 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] padata: make padata_free_shell() to respect pd's
 ->refcnt
Message-ID: <20221028162236.5hvgga57bhfsdwmo@parnassus.localdomain>
References: <20221019083708.27138-1-nstange@suse.de>
 <20221019083708.27138-3-nstange@suse.de>
 <20221028143546.3xc6rnfkfcml373c@parnassus.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028143546.3xc6rnfkfcml373c@parnassus.localdomain>
X-ClientProxiedBy: MN2PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:208:e8::43) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|CH3PR10MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5e92e5-7b9b-4150-cac3-08dab900a274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zWS6BN2N5lW6Dy3o3YjjHehh2eIitwIZExLGYlzQhtIU4n4qn2pXm1NHkYZLJVqscevjBhzQYQdK9tkLeGR43HBPfVIcS8FUYtKBGLWz/zVPk1G4bHdf5GIt6tY6FxKPtWO046AklgxaY/lapgA1RGnm9L6Ynsuk9eckp+GNkyWZ4rZBur8O5MGM7iziGQiCYDO7o0jrYCdOUvtLctf7HPP7hcafcdsa3erT15+C8mkS2CtZ2mbnffJjHMx+kBxsRITCJBUxOS5rawS6RHk4LsmQSrtCtcaBhGTNJIodoWTHA+w2BKZQEbRjCzv8IACHkpwLS4tlaM1HMmKnap2WaMwUtktMD/Yljlm2tI5YLBNtq/uzKsV35lVZqtTmvGYWPfJV4TEVIyXZDIBqtNEqiMHYvWPtS3QiweIUHTwieSHgKjeUkVQg206CEwvU1+PReJPEJ9EVKyGeF+itlaGLbBnurnUE/ry7mImL07EO1ndAPaw6qH31ytngP/PVHEKtuR+K7MLgG97YWWfHD6BUAQtA1PU5IGOvjn/MhN0bKWlfnuOMFXYNo6LhM3oqrWs7E8j257uNnoIKkLr9I45KU01i50aDnJxZj0JIlizrLQY/7ul4TAeQOe2OeymR+i/gjoJipaRrhY0wxTW5Z7uXsbOnCzqrr0YuL1kLiiuGVY6IwC2liTKhHR9JzeaYdhfbANaBfoO4Ub/cr+FNCYWQqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199015)(478600001)(9686003)(6666004)(6512007)(26005)(83380400001)(6506007)(1076003)(186003)(2906002)(6486002)(66476007)(316002)(4744005)(6916009)(54906003)(8936002)(66556008)(5660300002)(66946007)(4326008)(8676002)(41300700001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8aMU5I/2Rcw2bmht9bM2Lj0R0zJKnhTK4MGDb/iPtMUYKeq24fD8pSF/aX34?=
 =?us-ascii?Q?7USOC1FdpwmPuO8rJUYILDc1VCpLahcN2xroavT9560mBBkdHK5Q+R/E3ywr?=
 =?us-ascii?Q?RFbywsiWdK5c4T5lbcsyGy/s3AhmWGt/FI25OfVlFsP+Px9VgoRbKGjOa6cT?=
 =?us-ascii?Q?G00w7qutKnMWp/48WRuRUc4p+iTjs7/nwtw3p8EI4602uqyO3/h6ejfve2Ri?=
 =?us-ascii?Q?8gKCVAFhiilvALsgRRKN456wexZtNDnKtYuwYAxTLHLbR63lyYTd2wqiPDHi?=
 =?us-ascii?Q?wMnbJIRB7QpdndT4Bm7Zlykiv3OgksIuBuhI83h2hap1HpFzV809nB1Bz07s?=
 =?us-ascii?Q?JlK9TrIxSe9lUUSSCtiJ86lXMxveinwB51oKe1sX4YdGVuFW59djTILJo7vt?=
 =?us-ascii?Q?R2CbY6/i4GkgpIYXDzSNJcvntQgSVg134GtOAiFDxLamwqtLSjSnDsPP6Faa?=
 =?us-ascii?Q?XbB5vdR0jDvM+9rZizYjZcAgQj1tVoFYQLqjWECpu1cKiLrpfEi8P/g9RK0U?=
 =?us-ascii?Q?RGQF7nxQhWgILEgxqGdiTq+2cU+98r05cqnEQbSBI9air9mMvaqJjobS3xxl?=
 =?us-ascii?Q?/SvhGj8UKaLwYpqSLoYP0L3hkcNA43yRE5xfiDRck7SbW+B3yhILjCP6Dtnt?=
 =?us-ascii?Q?+jPK5/B/wTsXQ9qDiKqyki1psEBoPOlmEDGNDLVcc/lG6tE4Kb1MQg5Mb792?=
 =?us-ascii?Q?KFO2nfB6y+oDme4cehygd9ROPU5l877Wpv73WyFIP/Mc836k9TFP1BT1kOBA?=
 =?us-ascii?Q?uoVJydgmxbPmvoAKOhcFyEu0STJ7GEBSdZDRaiZ3pHgYl5l5CCwM4vocwk28?=
 =?us-ascii?Q?vSsJGZGHEJ/29L+3SjfvzsQcuAXQgIZGNsbzs48+cimFsSk9yFQhjvMO3IVX?=
 =?us-ascii?Q?ugkB2qkQ38GgUk7doHcKYjeGQlsMJlyLn52pI/jgTHPltI+1gstidMBi1v5B?=
 =?us-ascii?Q?HtyD/fwxln6m4fkepdD+ObpC2ZKksJRU9aiP7deRyRtHVns3fdk7vUqcW7wv?=
 =?us-ascii?Q?1c0gfvKsJyErwbNPYznH3T+mf+yOVlMdJ8KMejVkYqixGQmbVOaqxp+0FPPb?=
 =?us-ascii?Q?4TSxT/YmDLtPNgJ8zJWG/CmzLMgNoHq5/7OIdRab1AaV7Dd+nIQJxhW9zk5M?=
 =?us-ascii?Q?rqdziOMaHYqBzscdVeQlWzOVa/jsV2OrwLJJg29s41byo6pCsF4/5jmq+nj+?=
 =?us-ascii?Q?VGfDAKQ44+Znhh5ubgZIQFkgdlvcr7YiOdSSbu9dnQCuBqmKaNYK5ghCME2U?=
 =?us-ascii?Q?D+G2rTY0SB6JdSfWangLrmr4VUFWd377Px9GrozY2rRm3JqGN5gpTrJe0X7t?=
 =?us-ascii?Q?vawTj/D6Ui8T4j8SPIpwXKHNIurFrifZN1UFCkYEkYzDtnz5e+XQY1bHoK20?=
 =?us-ascii?Q?ftp8Tl/A8NvEPchRsN4EnbhgagWJDISKd4Pud35d4UHYfJj+ADJhWiAdQi6Z?=
 =?us-ascii?Q?sriQB9byISfbP6enEHsXCSe/r/YAqlfpJb2MnVP6NQRRxfSsC/K7qokeVE2B?=
 =?us-ascii?Q?5XIlOGJaqNJgItqURCPz0r6TpjqbxXzQe7KQvhkurFilrYZzeLtOqOw/5euw?=
 =?us-ascii?Q?H31lvVH5EWnKkcmsI+JUgJHJifI/w+Xf+WaXFM29p/GSK5xEsP0lPmfuXI4x?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5e92e5-7b9b-4150-cac3-08dab900a274
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 16:22:40.3985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNr1GRuIUlIFZceAgxC3poGG3sZCGbKUILs0cxbV0qDjicAuEjSofm7QxHzGKGXvCU+A1W/t1MmR039OhBv5LEhrs3j2tciHpbHn5MpIwjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=631 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280102
X-Proofpoint-ORIG-GUID: fxwBLdul1dM86Lxk6gcqBdF4k4sjV66N
X-Proofpoint-GUID: fxwBLdul1dM86Lxk6gcqBdF4k4sjV66N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:35:49AM -0400, Daniel Jordan wrote:
> On Wed, Oct 19, 2022 at 10:37:05AM +0200, Nicolai Stange wrote:
> > Fixes: 07928d9bfc81 ("padata: Remove broken queue flushing")
> 
> It looks like this issue goes back to the first padata commit.  For
> instance, pd->refcnt goes to zero after the last _priv is serialized,
> padata_free is called in another task, and a particularly sluggish
> padata_reorder call touches pd after.
> 
> So wouldn't it be
> 
> Fixes: 16295bec6398 ("padata: Generic parallelization/serialization interface")
> 
> ?

I guess not, by my own logic from 2/5.  I think it might be

Fixes: d46a5ac7a7e2 ("padata: Use a timer to handle remaining objects in the reorder queues")
