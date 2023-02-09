Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F77E690EF1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBIRM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBIRMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:12:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5158A60B88;
        Thu,  9 Feb 2023 09:12:52 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319Ghvea021899;
        Thu, 9 Feb 2023 17:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=TSUhDtVL2yMSJukKj0p5wj3hEDAvoQ6hPux2ZqtfhN4=;
 b=QqcJ7a3bRXWFMwj+y+0kJCqIZD3dY4n8BdnQYrLjZMbLFKnVOjwmD4gCMXQVykJi4miq
 o10zdlN2cpuOgZDC7pgb1ZQ0vD6hxh5oQQAOE+dfdH/mUAWDELD/d8N6BOABWmQ0xXWG
 Azc/FlURq+lUQmMtAEk1+CEzC6iusE/EuJVuqK5kgcY44eyP5CWJrFd/hAEIOkuFfKYD
 ptB76YxYRRwnvBQWJq589Y6BwYWxKY8KMMPWGBpx0Y3fNsSDBlimQJfvfw+3n1aKfB9d
 83sYbflfX+RHCvuX3V/7EEsyhV/sbT0NodIpjck0vN/MD+R7qnJyYiFspeiCc/HdOcH3 NQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe53ka7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 17:12:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 319GjGsf015194;
        Thu, 9 Feb 2023 17:12:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrbdmen7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 17:12:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTUK6f3JxPWHktLYOVYsc28erEKUhK/94MhXQgUJZAwiE0UBCYBHsr0euLc/caUuMH73mTZUY/wYjQBL30WdlmB0Obs2dHund9icPcHnvleTeFP2cBQ/vs/ruDAwSBRZAuPkumgsMNDPaJd2Axlk9axOrtfVOWIvLC6BeFteWuSHcFNb/bip2b5icj/MpUocqsOhGqFuaLIiaCd/OGlDGysDVt7xeo4QVzqH3b1s9cmRIKbb9bgTFE39sb6zLsjFzXuNqTTIZ5F3IknXhSrIUdac47FwfmQoSIhpTD0JTZA2tWCl1znWkIi8y4y85NFnUHfcpMWf2Dc6HIjli4SunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSUhDtVL2yMSJukKj0p5wj3hEDAvoQ6hPux2ZqtfhN4=;
 b=ir5qhJjZP4T+vYPL4DcgII9HjmM7xWiitYm0hPbNRln7ZIH5lNNv/DOJd6xwCs4rAKIYQHbfwIM835SG4dJ/fFo30Vd0YY8zddrEWhdlsZ/tEpNnKZPTweky9ywWJfj7Eh0I9O1QqRQBjPmtIX+he2a1kpjKrXh9EiLMH3lRozofghuUFuox40lwU21/P9cX6J+ANwF/8xPLgz85T/FfgbyJ9MkNCaP3b0jpTPb4252xTM+Wu9NI0MD1lO4vdX5SuTvxTnTpKrLjLUa0dmz19sONC+SjiHVESE06iQ1D5Z/K5M72M5ySqmgRwaIxv0b0RdbKmvLOnHzcDeOmwzpcSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSUhDtVL2yMSJukKj0p5wj3hEDAvoQ6hPux2ZqtfhN4=;
 b=zrWIUh4ZFVprEI+phPTSBX1NeSncLlFsHKe/PPHit23UTtlTsbsoOcmtOxOPdBDozPr7evNY0bW2DnsCbLCFRfKBkOWDUmSaIkWa9ew5sZL8PSeCm3JyzOoTTRpVqPxTh2CpXgebg/OFCoqCloGRdWqHDDGJ4t9rCp6kbr+p4/0=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB5729.namprd10.prod.outlook.com (2603:10b6:510:146::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 17:12:12 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 17:12:12 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Allen Webb <allenwebb@google.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Jeff Mahoney <jeffm@suse.com>, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Quentin Perret <qperret@google.com>, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, elena.zannoni@oracle.com
Subject: Re: [PATCH modules-next v10 00/13] kallsyms: reliable
 symbol->address lookup with /proc/kallmodsyms
References: <20221205163157.269335-1-nick.alcock@oracle.com>
        <Y8b8TOJzd/RZXR8z@bombadil.infradead.org>
Emacs:  the answer to the world surplus of CPU cycles.
Date:   Thu, 09 Feb 2023 16:54:23 +0000
In-Reply-To: <Y8b8TOJzd/RZXR8z@bombadil.infradead.org> (Luis Chamberlain's
        message of "Tue, 17 Jan 2023 11:51:40 -0800")
Message-ID: <87r0uy3hkw.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::18) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 9235215f-9e51-491b-1f50-08db0ac0c889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5L0Wb6CmhQfYM1N+zMsJvC0W2CUJrNFX6otwrp9K4shjpedWvjXSUmIqdjk9k++cFrMqIJJmduLK1RPkqjzPRovwODrssP0Yg4WihsDYqRvCGui2085vF0cSkN/pAWk6Nw1s8UrYJKqBgpg9u+gFuauSs2Npj0US9dWGFTOi1bzHpIO8nimOfsZSBLbb4CwtH45U9+zXXcK8kMST6QUsEB9GGS635V8d3Uaahq4K50ROGurHDRmgbjC2M2IpH1e17ToxKhlYeecMGOA2YOQWmGx/VCAwq2Q5IbBEMGGp0e1ZUeHWPb4RWwyCmFLBsWN/DOB9C/U3mDjvKkeR0/F3aT7CuxiMv9Wcafth5naFncY/91A8n9wVc51GCSxaZHJKsc9mb3d8aMuEEWBMp5MOVK81UHEDb2csMvxQavOrvbF0Vn5T786pPkZWafIcurCQsPlOrG5sfM0kAFUf4iFj+0m8mtMHxgPbRQNeUwZwRn5sdPEYAtQg9pn4rN9VPSP1+ekZrUATdjsHzyV5ix0Cg19G06vZ1kWasVoFnCOqU4KIUgvKk5EIvp7JcHeYb3Tpb1VdWAPb/9C3VDeMi1RLqhH25EObX3Pv3UKeu5aJ8d43AuhKER13ufumRI2I+47beMf17SsjwdXFHzq/hGY0JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199018)(107886003)(6666004)(2906002)(38100700002)(6506007)(6486002)(186003)(26005)(9686003)(478600001)(6512007)(44832011)(5660300002)(7416002)(8936002)(316002)(41300700001)(86362001)(83380400001)(54906003)(6916009)(66946007)(4326008)(8676002)(66476007)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yr3Q/HnEh9/SaVSq1HwQRYx4AlR/6Pzgne7KIc8H8A3QQ52M0GfFU0WfZo3X?=
 =?us-ascii?Q?9NRDCTZXC3PehTYmPA+QDO7qUmgZ8QRMAu6MOY5e6EI56NmHvm+139ZWBtKh?=
 =?us-ascii?Q?AOv1Oo6sQIi+07mSj0YOWsEtSpdEuCy5J63ZwhhgwBssy9OiwX/KqOKVAb43?=
 =?us-ascii?Q?0gMgORp8gyzfFK2oVjuEMTdK9gWsKOEZj5aXNxgxIPx7jYZJSLm7FFKvLaFV?=
 =?us-ascii?Q?Vufx8rCs+BZUPgZcfvJoQV32c5QHHoutBIh+DJN8ff3cVVSpJ3jPIerxOdBO?=
 =?us-ascii?Q?nnSe9Teblv1UT7GuT9g6qHAe6HJQMKAbWcy2blT9iYEexyEX55mI92eY4I47?=
 =?us-ascii?Q?HJe6lpXHb4vy/abO8qPOdYvvhiWl+8Y43LPdbn73X0+pnbs8AWpJ57n4vWMc?=
 =?us-ascii?Q?ZoBhszl+r0JWYHiVhjJ8XNZ6VnVJJZKBBc1kLdrGsRVo9iXUs5OuO9yusElo?=
 =?us-ascii?Q?JajQzraMBZF8uMlkFLg0LAOSVXbWVlmE3HOSBNSAiAhBEO6Rr+fERaZ+ANiC?=
 =?us-ascii?Q?jDiuiCCqiHUnGChtVBrhGZjdT/2KO3mw80AYnLHBHXNuYPBZg0z4lhK5povN?=
 =?us-ascii?Q?Lz5MHjIqA+b290KljsSOBfFtzVKVEzALAGZsOx3cQT4Xlb7ucNm728UvDHWY?=
 =?us-ascii?Q?NmW2bG082Ag0mS186o1XiaxjIh84bxOEKF8S5GcE5JNTkuQmbRlbSbL5Mxqk?=
 =?us-ascii?Q?ha35JJHI5FWf0sdw5CwhgTk8gHWxPJdy5OoK3Lm+3Vlvwznkxnv92l9TZ9uu?=
 =?us-ascii?Q?lmGje6QeDCoDLh0IW9N+MK8LG66RazzeDUX2WnKgfsPUsmH65KIqZTxKjbMG?=
 =?us-ascii?Q?TC94OIlsGV7LQzzXJQ31XsHEsGuk125nt+z/HL/HZPl2tHnT8RzM3/HF9Z0b?=
 =?us-ascii?Q?RlHy/b9fSSKy4h4uezWIwjIJS0jap6ywULdfbUXwqx7XgVnWf1WCgkVk6qPk?=
 =?us-ascii?Q?M3hh9eIhDXYFt/cEAu0JiRcX0zsKet2UUOrCX3gDDOahCc44w7PfZesdbBpp?=
 =?us-ascii?Q?F3nUjfl+IIxwfKt20X0xZT5uXakx5KFCXh6ifaC3JeFr1Lp+0XohnY1jGpV/?=
 =?us-ascii?Q?CynDVooYy7Mr90np/CQv6obt+IBPz6ODDOAmZV2ACuA6t15g8RZJ94X+Ks6J?=
 =?us-ascii?Q?Obl5ZBTyXDm+5pFF9423KcSmwYPP7TLU9CTYzKX9eotd44JXFcfY6Gh8JMaK?=
 =?us-ascii?Q?XMvtlqF3kYXroxTT6KOAH1Ttd7D6mLEz+MthRZ8sQIzsDDQ2tpENIglT3TvB?=
 =?us-ascii?Q?tVovyYNTV6dA11F/xxUefOdGy+COnTrea+bwrd/h8mVsd/69IUzoB4NplzLr?=
 =?us-ascii?Q?kInbU+PlPbwAES+rICBaAY0odF4O+ydnW9MxeWvUy78KNAeVDWE2ng6sW2AK?=
 =?us-ascii?Q?dVliilXIrOf/JA0NWb8PzE95egaHMU9IHEYkI4XvfFbRxraJBg+mXL+U57ZY?=
 =?us-ascii?Q?IO83TraHnzE8xAXgbzOiDu3tkF7bj1qFEcI1WJkuzGZZ/bL2xjyTpd+/1bsw?=
 =?us-ascii?Q?T+HKskPkQNwq/5tq05JAg3CAr4OtYlkETiQM2TesednMvG8FjA3RpRqWYBmq?=
 =?us-ascii?Q?aBOfNNv2OU8cmpXgwxBA89gBqSSc8QdM9WY0Tk47a0Ah3QvkWYhWuv63GfBm?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?uRztMohRZRRzxWD+wUbkjAuKxoE4Odjl3YuZ7/7p8z4AV++S8JlJ6KEGrvLW?=
 =?us-ascii?Q?2F3WysHGuR0LNgIpKzfaX1xqcrJ+WXXXCOL91Do0e77juppRRZMDGiP8tvXv?=
 =?us-ascii?Q?r354mZkaJg58Nbq5e4k0eI+zMz2eTBX0qoKEhTw0FgLtI+dcOrahGIXm/BEH?=
 =?us-ascii?Q?UVE+LWwMHGBF3owhQ3rp11eu4RFawRUyVxgg+cBDKohgPVsmPDYZfpN+vuZu?=
 =?us-ascii?Q?7gbGyswobeAtApuh/fWwENQS4in2MbuhgChgg2nJmCutlJlMo5A/CN0vQ15c?=
 =?us-ascii?Q?5mShIwKMmuagff4qCDq5P2EJ0/2BtVMr6LzEn2XOu3reYE18hHEuf7OJrf+X?=
 =?us-ascii?Q?982RYROMi9HJYhBNbdGvZGA5JuQRGNScquVdDuj756QLMPYQq9Axlc17Cd/K?=
 =?us-ascii?Q?bLL1wAKytGuJ3QExTOk1rkOJBJIDoXGwLtSjklklMK5hBVq+m70cp2UQT+ST?=
 =?us-ascii?Q?H19YXVcJPDCaMAu9NXp2ada19w873u+GtonqyVR/+PwAvCQ9ACR3BEkmEUwQ?=
 =?us-ascii?Q?Di/oBpwEV9RGFdmGnw9XXk2wrXv9xAxVAoRFcu2mBTYzQq47uNecwZe10be4?=
 =?us-ascii?Q?gS4HAdYYZ9S+JGcyu/CgxyLcX/YQgl9iOpoINf7As6Lnv1JUDTnEB/eUrdQo?=
 =?us-ascii?Q?pRGnFhfO20kR8j4/NvrNHlLrjzuHBQq7eYbA/1jSsovImjUEkTRK1x1FvzW3?=
 =?us-ascii?Q?laQbDC9lPhuz0LDi6FUtS3ULAPjhqNAK/BP66/iGRyFZW9B25FkGP7b5YTHo?=
 =?us-ascii?Q?50nUTciyrqiqUo/VzZirHjADn2xJs4esEK+MaQ48it1xi7Zec0fXLRnRl6fL?=
 =?us-ascii?Q?yvAxS5e/Jx7pHE8f2iu4V9VjKteaiKRHdrCAd2WMgIZfP2ZesZqESlFPbIOW?=
 =?us-ascii?Q?uajFf+kl4rElySwhiLIBYwEfVCyhAwhj07nUbMP7fGpCmpxEGfPrfICYXj9l?=
 =?us-ascii?Q?wX+NipXLMCJ8LN+u2s/nXcAJSs9lCVIrDPsMHLfQ2IynkMLJ5dtoI/z48qR3?=
 =?us-ascii?Q?y9ejGZLJ+ciRT9+vlNvUoh69zf+wC0fSMhYIaDSAPMTjyME=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9235215f-9e51-491b-1f50-08db0ac0c889
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 17:12:12.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNYedBfgPkFMh5TpyDx15AT1EG1qswkcqIMCXnfgykwrxc1WXMOdekPBiug6rhPimCMIc2p8eiZ6jR0vSOiR2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_13,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302090163
X-Proofpoint-ORIG-GUID: uLrX4aO532ZEqDlq3Yv4lOov5GC-m_xe
X-Proofpoint-GUID: uLrX4aO532ZEqDlq3Yv4lOov5GC-m_xe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jan 2023, Luis Chamberlain uttered the following:
[...]
> And please split out the driver conversions to remove module license per
> subsystem, and a new thread. The justification should be simple, commit
> 8b41fc4454e36fbf ("kbuild: create modules.builtin without Makefile.modbuiltin or
> tristate.conf") now relies on the module license tag to do simplify the
> build system. And as part of follow up work to that patch we want to
> correct false positives for modules.builtin where userspace may try to
> load a module which is built-in but such module can never be built in.
> You can add Suggested-by me to that set.

I understand what you are saying, and I have been working on this.

I am going to split this whole series into:

1. A series of patches (123 of them at present) Cc:ed to subsystem
maintainers as well as you, to comment out the MODULE_LICENSE usage.
These patches will have Suggested-by you. This series is rebased against
the latest modules-next and revalidated, and is ready to be mailed out;
will do so shortly.

2. A series of patches adding your new modules.builtin.objs and
kallmodsyms (with revised cover letter, etc, as you request). As part of
the second series I will make sure to involve the tracing maintainers
more and provide an example of usage with perf and hopefully ftrace.
(Note that the name "kallmodsym" is not something I am wedded to. We can
find a better one, if we can come up with one: it's more about
unambiguous symbol resolution now, and maximizing the number of module
names is largely a mechanism to accomplish that, so maybe /proc/ksym?)

This second series is not going out quite yet: I'm working on the perf
support now.

> The same applies to your other Makefile patch (except to the
> Suggested-by as I don't understand the goal there yet), I don't know what it is
> trying to do, but it should be a separate effort. You can feel free to
> Cc me on that too.

I have decided not to submit the tristate checker at this time, as it is
not essential and it made things too confused. The Makefile patch you
refer to and the tristate.conf reintroduction were only needed for the
checker, so are dropped, with nothing more than a reference to a branch
containing the checker in the kallmodsyms cover letter. (The checker
does need periodic rerunning to make sure that spurious MODULE_LICENSE
usages don't creep back in -- reintroductions seem to be running at
about one a month -- but that's easy to do ad-hoc and it doesn't need to
be upstream for that.)

> And lastly users. This cover letter should reflect clearly who are the
> new users who are dying for this feature, Cc them and hope to have them be
> actively engaged during review.

I do hope that adding some proof-of-concept usage of this in perf and
ftrace (emitting symbol names formatted like 'symbol@objname:module'
where possible rather than just unadorned symbols) might show the perf
and ftrace maintainers that this is not useless.

Thanks for your patience and feedback.
