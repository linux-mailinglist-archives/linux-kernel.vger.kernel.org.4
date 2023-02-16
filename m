Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB49E699CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 20:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBPTVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 14:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBPTVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 14:21:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110158A42;
        Thu, 16 Feb 2023 11:21:09 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GIxBIt029524;
        Thu, 16 Feb 2023 19:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=rGd+aLW4wwBO7FLOsN3tauX0nO7C+pR1xf3bvnWmMOU=;
 b=W3DlwUc2Cu2trIKtawneUs0dAffrn9lJ1Pg7N61zt0OCRNxL2HnApCI8IZt6EH/vhOKj
 q+52DQZ4IzIUlD+Qv+gm7dK7VADnIww1qcBPZy1jXquUYoHFwq0QmvCP7ehVcYlpJe1n
 R1QqcnQXno6tdQ+xn6xWGVdIzuslwfOi2Am4X3Hi+etlLDG7Px5rsq75rBZGoDNElGPA
 4HXeqkTOS6IoIv2Cc9eYANP/jOVs5JgG/Yvwj/bP1C7UCC95sLNLZ8yLNcywiVeGU+4Z
 8WoKOpSbS5HXsNTzkplC0cNyv+R3sORmmkDWYx+MVJ9wNOBk3Ao+VtFy0pDF7zONCGws Jw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t3m2wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 19:21:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31GHq6hZ013889;
        Thu, 16 Feb 2023 19:21:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f8shh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 19:21:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcG9RYkE5LTefJA/tRHqmpTKQMLZMAiTNqvYl3CRbBA9tMMurW2pNWwVlu20K0QZn9k+PnEOc4z+Ejij4TwfwGENB1jZr6I+pw17naLHaj/Byn93Q7JS1prhcaTlAPWfw7PVaQ7wsJjaGDrk6psIaJ1B6ffNs7n2ca7btKBwPZj4eU0pTPECiUaqaRiAPzETmMyiYeMTu2ZDVNcTPMDdfRqN9g4FowQkt29BB6SZCccYOrb5C5NhkTRdzFquQwgbR0Os+P+bbZxDo9Q820XUUrFiQlXQ7XughD8+yTU0EbpDpWHrWdb+0c6yG6n1AXdda5rVr2xg5rpjocBOz80mNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGd+aLW4wwBO7FLOsN3tauX0nO7C+pR1xf3bvnWmMOU=;
 b=hEUB6GH2GRGcMMSITGRCXcKktc08ka9xv3sohBTDwJ00rqpE9iW9IwPJkXhBlBVJao9J3LHAbOoKMxXN4GbuKWV7jyJAAlIqpyYZ/RPpUeYEgxoioXWOKs8f/tWtCrdqF9UKRzj+OKtOK4cr7bKK2N7iY6Y9fUlOu3NdURfXIB2U7q7gooGkGNLiKUlzF6+H5vP4KlpSBqfBAGZ5OfniRmS4FA+DlqH39TJtF/Y+Dm8H6KproPAzB+dZNg1fZIiwZoyJlRRIV9B6wRrzphZ0hlQLTwu/ePuK3JbojgRpZx4jz3WZEDAqfskoKdh6gbg12eq5Ud3HMuzgpGhcpFyiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGd+aLW4wwBO7FLOsN3tauX0nO7C+pR1xf3bvnWmMOU=;
 b=mvP4D2p6dz+NdU1LEJP4LqKuX9qQVYEVxBrChf3G/FCId/5MvgksPTseN5IYVHpj7+ZJk4AmiLGQUmkGGIOUI+a3v3kOi8aC13XeXlTW1CY3DaoJHNmLXukv/akIjim4PoguwOZPdhUOFl0HtPKstwP4kNfSskf00alxi3n1L+E=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DS7PR10MB5087.namprd10.prod.outlook.com (2603:10b6:5:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Thu, 16 Feb
 2023 19:21:02 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Thu, 16 Feb 2023
 19:21:02 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] MODULE_LICENSE removals, first tranche
References: <20230216174333.GA3313434@bhelgaas>
Emacs:  the answer to the world surplus of CPU cycles.
Date:   Thu, 16 Feb 2023 19:20:56 +0000
In-Reply-To: <20230216174333.GA3313434@bhelgaas> (Bjorn Helgaas's message of
        "Thu, 16 Feb 2023 11:43:33 -0600")
Message-ID: <87edqpv2lj.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0317.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::16) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DS7PR10MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3f133d-9fd9-4808-1d58-08db1052f128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OsqHpPpC8iy+Z0RpY7cXee2dvTTm3mUVHPS+0WiiCDZ8gaCZb3Z1bznqkeM+urVAoWMZ7xSwDzCuAKEPhn403eavg9+UoBYT9ydUYAwURm/pg/muX8kloycOAV2qXSKEzzRFHI2x9yZkEwBF2iYKw3MvtCH4UTB3vHnCfY0TzprY5TITToE2HhP4NGo5SIkuVxJdUNK6vubt3OjzZDEiQ8kW8hV2hN+e9LbHP+MOPGjbObAUlZ1jn5CDktmtKjaTwHl/nhq+B75lDOAVxMq5JCHg0lzRFnnXi1xIlLTx4EDVfddhPTufeprgx3PSNhkVfGWU3BQtRaX4GswNjEQE24PnUP8vdkXPBYJ7+oQ4xSp1i1CoSpVdl81NWi8wV/x20sceDiPkzIs6N293tBEe/V5ISIJV24+CaBjbwNnP0Bpj+RIRbXJ4QGqzij9v2UCzJbd6s27sdat43GUVHJXuVDB1BYXSq3wgIfqA9CJP6YuiQxnv0WUQEyDki6eSHsxVTB+ohfudrjOan28tK/Wbpv1gtOXSSE0w3TO+lJp7hrhYG+PQiS2nRnWEGMcSHzshCPlOdmK9+aSXogzGruskWnmF27D9Ljgy9oDFUkqGOJe6ueEwYly3erCn4RvEr45iId2nXy4sBXKixNY14YbShA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199018)(86362001)(2906002)(44832011)(36756003)(478600001)(6486002)(6666004)(6506007)(6512007)(9686003)(186003)(38100700002)(4744005)(41300700001)(6916009)(4326008)(8936002)(5660300002)(66556008)(8676002)(66476007)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FgDVZtviGo/lmVGwFG0B7nUf8YH+RJwt1c5Kxx4Ba1C9Dx6YhcGypZ3gTKwy?=
 =?us-ascii?Q?yTkP09D4EFXDOD2Hy7Hp9YMy7UTawym/95usQoCbo0ewyeUw1jybeUPAmQzu?=
 =?us-ascii?Q?/thZwzOdMnH4S/TqLFRGF/qr0Pc9nRRnR+g5jJNioCXsGVfc867e2vc3KChO?=
 =?us-ascii?Q?eud4ZMV6aj0alXQKE8g71mmHxgLkBgY7phh8LTeRAF/M40z7zIPzeT5WpTO+?=
 =?us-ascii?Q?p46SyrbqONhrX61zS578KVn0PxNWv5bP0fERr/zjSN0Qmf0wvCJwoqAG0qvU?=
 =?us-ascii?Q?4z3SGdNOYGUGmFkKUcsf0VuL1S9kc6KumShyGpq0UNkoSEy7O2Eu8SHZJq77?=
 =?us-ascii?Q?IZujWY1LRpsxdKNw3Jgy8oOm9Siq5AhOMmyoNnnWS2id1dPWjnOfdASLDrVO?=
 =?us-ascii?Q?qpUnqMtteTWyLRjy0PZtAJplccYcTqaqCatvovqsq+J6gMW7lEe2RbMPSR/N?=
 =?us-ascii?Q?E6x795ZbpeFTi5KLw5EFwQmosyOZx8Gv+P3umez8xNBEG68m7K48gIe+gohx?=
 =?us-ascii?Q?RZoLiUnGMxa3OBe1AozVssFeNYzc0xo0WMgHZ7cFpQ4xDN/WNn/DMvDr1OjI?=
 =?us-ascii?Q?u6KnoIcL3z1yfKLJSZLWxnaMKSiU6RVWDElYoQKIKMjHR+T5AKSphOieBc0M?=
 =?us-ascii?Q?ypqF1kBA3ImpPjFn9J+7o8N9GYdwijqxfteNUa3MSLdKsK92XzjymbT0NLJO?=
 =?us-ascii?Q?SVV7e2XzfZrmFQ4mWOX8PfXW/zonYS6CC6lsESNqgfUPEXcyoAciFU/szf0u?=
 =?us-ascii?Q?R2nhpO0K35CAPX4pvP8RKKnRA++km3j2I2oPxKvAY690vw9F4gcoSmR57cGN?=
 =?us-ascii?Q?iDNPppq8cJKapArb7CI7O1z/vbeuq6R53zQ1/Nbp51zBamZ303TKyaeqpLaD?=
 =?us-ascii?Q?SC8W2M5SkgQYb2FBmoCjmCrptDa9Q+CsPTQ9s/G0sgZHTexSOMKZR9Tai4iO?=
 =?us-ascii?Q?YEKWBFrzx8oeEwYuc/r2ml4YcmnWSz4RzYdH2QqUeM/znttfV8iEU1zivaLS?=
 =?us-ascii?Q?OXdaP1nlOhDj+0GZ+QWDyBdev0/qP1qOXwVZ0QaO+bvLLxlCvy0tIwAXjjIz?=
 =?us-ascii?Q?a7tb1142Ny1Y/Kd5hW22JDz20uxq7c0tkaH09h8/UDLAJ1cSf2XPKn4j+M7z?=
 =?us-ascii?Q?FgjGzIG4zwurICKeCCHWdOnU7cUvhNpyhGxr0DqH2xl7SQRMgK6I6bjeGfyO?=
 =?us-ascii?Q?74LVJO01suPRt+g+TRmxm+ETIxYIFVMFjxMbt/2hJFyolDye3tX/pHhReFM0?=
 =?us-ascii?Q?gH9/18h+W20oLwVn12yAiVXbaPphjgrzNX98+AjaXyPkj08tdFsjV1P+D33b?=
 =?us-ascii?Q?2u0uN4ZTGXvU3MfVDXy5mgLnJtbTLpG3wzvPPaxgbrAN5k2/GhbJioLDdLD7?=
 =?us-ascii?Q?AqnJR4o9+WeVf0grnEcAX1tm0UgpX9ZT+zdPNagQQGnFHDreeAtNNZ6ElOAL?=
 =?us-ascii?Q?pF3mFnNuVSHCU7bDsbXLmlEMauPI0Y8u2pgupisfDUV5QszHfilRq9PZEM5l?=
 =?us-ascii?Q?/2YYKiiRgLT62Ig1joH22FBJbgribHhMAQMUfpLapd4v9gX8Tu2cI/z/c4bb?=
 =?us-ascii?Q?wx9gVSHESE8y5mhsX1zFVT7OJKa/rgkO5thXAG4Pkw9c5jNu8pi8slKutRfK?=
 =?us-ascii?Q?PzKRWoaO7njqRgF06IRkRbE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ae4uw9uWM0sTqI4D9vtJapJHw3JNniiJce61v0b8eHrBYhEH7lrEeQ4D3iaTuTDALTk2vMSn9nh3XH7xA6bdCI+AHdFyKoUhwdVX4xmZZs5RVHNHcgXi5wlAlGYlHUGTqbNZ4elLa9jW8bWX33PCcJoRVQLxyMLZ1GwRvE6zKJ+7xWSH6e/AR8Olwrdn1j0DIV6MrBWDsJYzZRERF2qAwlFApAYnH6t0AwNNt+69wJhHkwWp4M+tOBxnYCQv5xXSVvkw4HixOpJZ6imrIkceqAsXZqfX3sHNS7NRzTYHlCFCG0lXcypABl9FwyJNrig6r2yVKdqBoFZ1h8cKNr+872Prka4CE0MxMQFlrOtynFNwfFpI4BJGHoF05bS0I3bNIFPcgYf7TEMkyFZxEO0oPDS1ukb12KsA6mEoZGdc5TsgUbw7vfp0bnYkJ37pKdWxIdoiladxq8DMJG1l8AkuUge5j1KV6FccNBkrS0fvRV8d25zkvz9Npzd7fmJU2rbGV0nLOmtvuhH+zk0kh237wY8XAGJYv6f21S0HmTeaXN8ePiZ8NyG4SA4ojBx21VBEvWS7XAhzkUcSmf/oAAKrH4BpxSbs/vOgOVCTInL/+JvKB3G8PWNMvZOa7b52D2hepIHXYeUTKeubkeIRV0v7GQZB06xbWMAuWsv225h8vzA+sBt0wZAKOC/HBJ6+bcFg/v//wzJw4M9EVKQirqH/kQj79iG6wS9fbuXjqd0QUoWmIsKpgdZWX2LVRMVkffxJ5l1mQjjuMa/HRCdMlufcRk8ZcBbjOaxEfWYZMwqXiPU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3f133d-9fd9-4808-1d58-08db1052f128
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 19:21:02.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSTrCoJRmgg/mmXMv4f+yP8vsyxaWAbeFLD3r08/F9IoXCkeEEciBXoxIkX73eJeMCE41tw+of4jGORJOx1Suw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_15,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=840 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160166
X-Proofpoint-GUID: QfmR68CXoJh_HIQlptxZTE5TSaSG_H3H
X-Proofpoint-ORIG-GUID: QfmR68CXoJh_HIQlptxZTE5TSaSG_H3H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: slashed]

On 16 Feb 2023, Bjorn Helgaas said:

> [+cc PCI folks, who got the patches but not this cover letter, and
> participants from the v1 posting]

Oh I'm sorry! I think I need to arrange to augment the cover letter with
Cc:s too, to add all the mailing lists to it. This is extra-hard if (as
here) I'm splitting up the original patch series into pieces...

... or just try to do without a cover letter, and put all the stuff
which should be in the cover letter into the bit after the commit log
text. That might be simpler, since I could just stuff it unconditionally
into every mail without alteration.

-- 
NULL && (void)
