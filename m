Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E4E6A0CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjBWPcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjBWPcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:32:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6A41992;
        Thu, 23 Feb 2023 07:32:30 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NAG4Wx029685;
        Thu, 23 Feb 2023 15:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=3P80V3rOrRDNBOBQN1FW82JEIEHvWdeNvZe153bi9Mk=;
 b=F1APjCiWE6Hv3l8V5vbCzQps0Ke1zONEGLxPm8ka/mCh671Src3DL+UDQvCZUR3PFW1L
 XrmMiL+G4A6EN/Bqnwh5ctujQWSmqu+88xUACticLlDs9e9nVsyH5NbBwJ9LTMJHbRZs
 l+67/pP67nRtuZ74j/RHcT3MWK5wJLMpmHxrFqSEyVtFHYTiOpI7z774+bsvofZt6O+Q
 976Tbip3Fvykavh6z11ZjonkcuCXlZPz/aDDxY2xGRdJbzer6+rM50eNHXwgAXX+TSld
 04ToDko7zX3geG64UhJOrqS2qNEedTe2Mot7f/stWseuvRbKvh2CCwGGQ2Al4JzNMy66 4g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnkbtr17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 15:31:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31NFAsLD025870;
        Thu, 23 Feb 2023 15:31:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4867nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 15:31:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpffxVYdBsO6end6mupE8wFSFNaHOy0Y+BrpANKXRDPlUph7qVLPRywB0MVHTVfJ0p/bZcHQazI1FSxFhg4pdmoTtVvzB+htW3NOoIaIuqDXQVuZfwGYEa6oQIIm9KT6z75Fqi8W6gHUV0RlipB+mTB2Jp2WnXrISuFkhYvPOZqtO120zK9FsVtdoFzEORfoB6QSSuccOi5j4k1dWpf6NDgDzLqWR7wpuAnXjVSt4nZcZEOmJjY4sc0nRmbOYm9SK1LaUuDuomJw9H9azE/QxyoydMi0OFxqGAXV1dfZwya+fQnogEZICn92YcDgwJTaFA0Fr2/USbsgP5/xipL1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3P80V3rOrRDNBOBQN1FW82JEIEHvWdeNvZe153bi9Mk=;
 b=PgzHXqaBCoINUPaxRLA2yTYMo8mrPLj+gvRFe28sFAwr1tLKdeuwGnTU6CvmvLjZc9i7g3n+aLFeK/hIh0YHcraebeaimkT/gYfvkTQVPLuAmauF044DElmTBLhVQe1Kmqrf2xsE8+uLjc6jN8eXo+LUAw47/O2GUUlydS0B1Uh3+TTO/8v1RC7x1V/i6fkHZKqgCOA5VooJ1HJG1w1hCIr/Vs3RVY/Sz0Twv+n2CYdF41vmMZGzIzrgo2XO6l1ZX1ZOKdM5pLc7lZuEgPoBLt4g/dDIF7YbRSVKLrbJp2tAMX2V0D29KOAvy5sheUSJNRxVmKMKOcMpDl7Y0IYAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P80V3rOrRDNBOBQN1FW82JEIEHvWdeNvZe153bi9Mk=;
 b=P21//6PtAggVnhBD/QZ+7SlZQKd8hn5j+kODCKt4riQpwUFTHT8ywsSQRG+qZTSilVGz9CoCluVo56KVtwsLjFczWTS63FP18ho+8Z/9yqlSSS9du1TuwEGZNtolUUkV+O7819RmhGvGOswE0V7/XoJIzW0kdFKu5kSyypbrkmg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SN4PR10MB5656.namprd10.prod.outlook.com (2603:10b6:806:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 15:31:56 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 15:31:56 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev
Subject: Re: [PATCH 21/27] kbuild, dma-mapping: benchmark: remove
 MODULE_LICENSE in non-modules
References: <20230222121453.91915-1-nick.alcock@oracle.com>
        <20230222121453.91915-22-nick.alcock@oracle.com>
        <20230222144856.GA14220@lst.de>
        <Y/acoc6MDKNnrG+g@bombadil.infradead.org>
Emacs:  anything free is worth what you paid for it.
Date:   Thu, 23 Feb 2023 15:31:50 +0000
In-Reply-To: <Y/acoc6MDKNnrG+g@bombadil.infradead.org> (Luis Chamberlain's
        message of "Wed, 22 Feb 2023 14:52:17 -0800")
Message-ID: <878rgopfdl.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::20) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SN4PR10MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: ab455667-e88e-4f10-089e-08db15b3189b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uquDQwC74OyYtsLnZaMs7IbtXRL/ctMEdoGAYKBPGdENAweChAwgWY9bRZsdkPg0EE/ZBcRVFKJ6/31LvlAW/WlNCHQHkUorv+2pqpCzaO6FTNuwGXrq3MhMW8eCSkTDL5KKIl8OBSbF8JFo1rVR1CqAt1gERYhb8hnYKmSiSlLCiE2velITvysoeoWtWcxhCSNAsyDjSXttxNOdRja0zootyTu5Fpwin6NVjfZIBrrUmq8IzxG9CBm75dEDeKMzDk6p5hN0FkgPucxb5BKnF4ifTf3MYKjnRrk5FuK6IDtQUrL4PxA2O50j9GAeB0LVUzAZBUjBqcV7zjFPjr6jM+0hBlxSduf88GTOh94HVa9Rtmh52+TxOqVUzZxCOQhKa7J0aOj70dYUAB/6D3FKeJY9qDUjR/hgFQ/amqO8ClsQGAttreoK2VgtHvSzZyxPXFeE4QjM7dD17wT2Jl8pMBei8UwfwefGm+S0OImW8JaE63FndotIpDx0G/Oa7NdG0NSRrE/XjiBpwwJErP6HYnZDDk6Cy/flDtWiTjg0W5YO8DnrJwezUtz5QPokdDkyvpMnR5ujP54q62NBvI8i/y7MK0x71yB4HQI8YqYD/eK3eEo11Smhb82dL6ry0Eqq2UOLXASANm4nGWqVJha5JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199018)(478600001)(186003)(6512007)(9686003)(66476007)(6486002)(83380400001)(54906003)(8676002)(4326008)(6916009)(6506007)(66556008)(6666004)(316002)(66946007)(8936002)(5660300002)(44832011)(2906002)(38100700002)(41300700001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bks/UCTzEA9TXGetGtPrJlWpX+pR7hvpAhx/Y6QnEWLVfOJpnzC91TUJeomF?=
 =?us-ascii?Q?h0v/C74ICQDNc0RtWEb51v8LtP39nR7ebfb3GptraHu9ES7qp5tMALxm7FSn?=
 =?us-ascii?Q?Y2KTNK+0EW6PQCx9SnTHEQn/pXmY1O9QnF8N1Yb5664sKjBydpaGTYXSpbFA?=
 =?us-ascii?Q?6X3isWOIODpeWAOwu5vWz6y07RIxWlVwFD3OSbkPzTRZ0scCZFE2wozRRfNi?=
 =?us-ascii?Q?Jxe8/buHNQdos8Rinv5pd9TFa8B7+tLjvqhUjikXaDPzsh3J3nh86ZXxnQ5P?=
 =?us-ascii?Q?lJvhWyGhAjUsohomvTZPy/06DDO43nWtS/ByvPwkbGUDVTfUyE3MvvDPJUWy?=
 =?us-ascii?Q?wk5MmdqkUvPryT5sN3COzLrlXDz8GqhTdN9fywruar15qWfN8dKXIuLryT1h?=
 =?us-ascii?Q?C/CNhfgWQalQTP5+IiySq6WP+ndojOuZcmDklfdO+Z6ZqX+UIdHm97B3wa63?=
 =?us-ascii?Q?oICvNlLEvwfH7gKD9NeyUzgOLxuW1bGNh42dmlEJa47yOIzV1oOclbsBahRm?=
 =?us-ascii?Q?ROaVD4QGk0qWvAvj+Tar5vROgKPFhHeytVpzvBj+TOBqrkQB1Ur9zReIt/BR?=
 =?us-ascii?Q?SNItg66U1hVdLHbXdNjfCkxovAIXAguRylrNvcD6f47mneInXYquCAXCZ0Vu?=
 =?us-ascii?Q?ghvpgiQV5NfIJH+lLej4RA4pl4PlTr7IlToAKGcyB+iJcB6JHWzESwdlN2Jn?=
 =?us-ascii?Q?oGoCTTavYBKgbyz8DuKWIS3lDegbABqhStER0PPsbh6GmDFI8Bjz+BXY5hgy?=
 =?us-ascii?Q?m4BcO3SjoGDPb8s+n3JIE+xoSZ0sIx1mnpYgb0QJTpgrOV2yvYaJxr42F4WN?=
 =?us-ascii?Q?yGGHZYmuv073080g/BHKrdjofcFXvKh1ogZxP8EcaCQalt1UrD/xaQMTr2vL?=
 =?us-ascii?Q?s0qN29XXvQR2Ey2CYi1xqlbfQEs+YsjUP4YhN2CXYxS/cx6w3UdZ/Y97MsAH?=
 =?us-ascii?Q?bA1BS9vGCRi3oH8C3A3fSg4W3hU13EyxFtIKf47+2ydcaTcXdEslIFHA1bZP?=
 =?us-ascii?Q?90ntbtrpu4jlyahnAEQ6B8aNUAnYqipia8WoV7ZnajVKHhaPGIH5sFYeWQw8?=
 =?us-ascii?Q?J7XQAEGe5QCfnS0KRbEGffZnnbXcDXG/U9kj8EmTeOsNxB+/HLHNAZgUC0y/?=
 =?us-ascii?Q?/j41vCXJvWH1SIKzfWhAmSvsxUgQ608KkZlp63s1GzdAi3ZqjEmP3nkAs+WJ?=
 =?us-ascii?Q?eLSfuMEaF4xuCxJhhNMq6UWAM3839Lf7qn1vQCXZe2UZrypoMQyVkZBj2KXR?=
 =?us-ascii?Q?twqZs5lvJ/MfR9CFaBf5e91/83Qo+/i3Sry0NCu2wZR4S7l2rSzRyUDT3asL?=
 =?us-ascii?Q?2ec4W4NuYIvQCeGysumvZgN2RQY4KNKHK0qO1oXLLq4ieXandxnf/m/WtiX5?=
 =?us-ascii?Q?1O6rC8wl1JsvTAFtcupaDKsZbS5EXFuFu5Oe12cs7VrJyFuZqu+IYDNb9HuP?=
 =?us-ascii?Q?ZsdpZz47yjqQ/SQKlTg0TlWcaSC350LZTmhzfnZhJBkAIv4SF/DaJPvogWJY?=
 =?us-ascii?Q?olhKL8f1pZnZwMn3/xatbVBV+rp82XHih8FR4P2c302lIPE451a4Tz2SbDNy?=
 =?us-ascii?Q?MOxjA2m9n3ddIhhTHQVOZruhCPZ2Lvkl1msg66PFeGXB2MtDfwzOo8F90iXI?=
 =?us-ascii?Q?aRSgSdAhjxv/9A1tofZmksI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4C/hiFwUMvBLzjklf1wvWOXU/dfo/v2u7bg1YPTFdmdgMH6abvz8gwxRHZJQ?=
 =?us-ascii?Q?j+hI4uBTp+a6KVlbqPoJrfXyNVA2m4N1tf0RhUkeolOh5Uwfv/UKfOLhMXiv?=
 =?us-ascii?Q?aRsXZu0hJBGlRyDFBndcINikN6frZvds+Epd7Zz+a40x5TGE5JZQbNY3IPKt?=
 =?us-ascii?Q?yyP/NFgnXJbVehQK85+Gw0k4JP4YSNucWi6LybWCY3YRe0beD7BKVDhGs8Vm?=
 =?us-ascii?Q?ZjvpEsxw5/O4JiBytBDzLWQaTYJISzTz0RKgjMl9SLnVKJnQYLIItSCsXZAM?=
 =?us-ascii?Q?+HSHuRZhiQ5knVVH3Ns2kv4HyC7C2kcq85/zIXXDyGGoTQwi8JCh/bic1i5t?=
 =?us-ascii?Q?pvdJGZWlDAEBLB72n8M7w5J7/fsaK6P9CxugW0AI6M4OQtOIIRkZkqfBkVvz?=
 =?us-ascii?Q?NCCKhxvoij9Ur9vyD3RA4oiT3Pa9/czdGFQJrTmFqb3Y8x9V76g9ZWH4t5FF?=
 =?us-ascii?Q?s4RNo9aLcxp0gcDQtyhzz43WdvdkhQkCU9in+DZRXkY+y/OBN+6PwWLMRYcQ?=
 =?us-ascii?Q?r3OA6sCQ5oZoDqnhg3OWkDoB0vK4ACLS8lfkxcH0BhKkS5NB4VhP7w9JiyMI?=
 =?us-ascii?Q?Er8GYX7icP/45uTsTzrVucOrRYDvWLcAQg0HIuQu/IVzHx16uIlzHIR1uAhH?=
 =?us-ascii?Q?0AnqyviTdvJD21b71ylVF8iHvd1vdwZ2wiXtLOWMka74ZMpeYSKp15PIskgB?=
 =?us-ascii?Q?v6d1yw8nSGh2lydkiwaE9QQNo667vJStK2930tA48j239jMCGTfPTJDAnlwf?=
 =?us-ascii?Q?yntbNdR8yk3QEq7b5ZzRZYz5lzQ+eKMEDtu4sIOH8bUbfhzcZWGepY+oQN5z?=
 =?us-ascii?Q?KmVmjimHyBFIlUzA8Z3giWMX/qC4k271waak65FqyrNEZrj/JlkoEJxWFF5p?=
 =?us-ascii?Q?JeVVgdHm+WGjs9sykONFVI5K71IT4Iw6+lNIX4N1yM7fqwQ6103Mphq5jD6n?=
 =?us-ascii?Q?/vlKdnMOctefmifABEkbKA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab455667-e88e-4f10-089e-08db15b3189b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 15:31:56.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYRwjTdtqQVOiwAMAMyFRwr+tz7bOa9eXeINKXS8z3uxZUTgVP2nD/UrikLmA3wiza9/sf3ypDPa5HIYTj4/Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_09,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230126
X-Proofpoint-GUID: 7l7pxPeZVDkOk_UL-kht9K9bIcb1G09F
X-Proofpoint-ORIG-GUID: 7l7pxPeZVDkOk_UL-kht9K9bIcb1G09F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Feb 2023, Luis Chamberlain spake thusly:

> On Wed, Feb 22, 2023 at 03:48:56PM +0100, Christoph Hellwig wrote:
>> Looks good:
>> 
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> 
>> On Wed, Feb 22, 2023 at 12:14:47PM +0000, Nick Alcock wrote:
>> > Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>> > Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
>> > are used to identify modules.
>> 
>> .. but this seems like a really odd design.  How is this going to
>> continue working once we can autogenerate the module license section
>> from the SPDX tags, which we eventually really should?
>
> Yes I totally agree we should. But I think we should take this by steps.
> First, we ensure we have only MODULE_LICENSE() macros upstream on things which
> are really possible modules, ie we remove the false positives. We then put a
> stop-gap script which can complain if it finds new usecases which are buggy.

(and we have such a script already, though it's not in-tree: I used it
to generate the list of affected files that make up this series. I'll
keep running it at least once per release cycle to identify regressions
in this area, and fix them as they come up.)

> Then we look for an optimal way to address the final step:
>
>  * remove all MODULE_LICENSE() and autogenerate them from SPDX

Ooh that would be nice!

> The difficulty in this will be that we want to upkeep existing build
> heuristics and avoid to have to traverse the tree twice (see details
> on commit 8b41fc4454e). I can't think of an easy way to do this that
> does not involve using kconfig tristate somehow.

Nor can I -- and more generally I can't figure out a way to get from the
Kconfig symbols to the source files that constitute them without
retraversing the tree, since the only place the relationship is recorded
is in makefiles, and those makefiles use a lot of make functionality
(including more or less arbitrary make functions).

(restating the underlying difficulty here in case, like me, you lost
 track of it over the last few months)

Of course the build process is doing that traversal anyway -- the
problem is that the only approach we have to get from tristate to a list
of modules-or-builtins involves emitting *different values* for CONFIG_
symbols (uppercase rather than lowercase) and then triggering on those
to do things -- and if you do that you can't simultaneously use those
CONFIG_ variables for their normal purpose.

We can't rename those variables for this purpose because we're depending
on makefiles all across the tree expanding them. I tried to arrange for
their expansion to have side effects (so that evaluating $(CONFIG_FOO)
produced both 'y' or 'm' and *also* did... *something* that produced an
object file list for our consumption) but that also doesn't work because
unfortunately the tristate determination code needs a *mapping* from
CONFIG_ variable value to the result of the variable expansion, and a
line like

foo-$(CONFIG_FOO) := x y z

doesn't let the expansion of CONFIG_FOO have any sort of access to the
result of the assignment to foo-y / foo-m, and after the assignment's
happened there's no way to tell that the $(foo-m) -> x y z mapping was
generated by the expansion of CONFIG_FOO in particlar. So multiple
evaluations (which means, in effect, multiple make invocations) seems to
be the only way.

I do hope Masahiro has some brilliant idea here. Mind you I'm not sure
I'm clever enough to have come up with the original Makefile.modbuiltin
scheme either...
