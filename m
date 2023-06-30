Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2BD744352
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjF3Ujb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjF3Uj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:39:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CCC3AA4;
        Fri, 30 Jun 2023 13:39:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UIxLQ0020422;
        Fri, 30 Jun 2023 20:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=I/HiidgF395Ny2sfpJSq105jEJjfTpRvRzaSNYQkaZI=;
 b=0TZmhvQfKQ3yE+3e4d30P+DZBJ9efh+huxBmmZ3nxgtbkogGN2y8luhMxwkQ0eLYU0dR
 7XJqx7Gg7kIvXVsnLipKEydzzKncyulBr4MpF1DWgUjQ+pViKTzTG03BbmuK0ik+8hH1
 Sg6sKACHfs8xjPiVZP7IRt2j3dJ4GDMHfXtcO37u+H5tyQuZFTWAr1r7ZknA20hThCYV
 259g83QgMjThTE+HKADYEZMRexUsoc+IeglrzC/EXTThulcFqbYsxqhE6u/RAgYA4HNc
 Cxg7nMvVNmNskvr9mtPklwTzIosIztSr1zTrnzIfG8XDNZv4SR8uv5TwnoVBMzk1ZBfp kA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40eg4pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 20:39:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35UJ4ViM008768;
        Fri, 30 Jun 2023 20:39:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx9c4s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 20:39:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnXZ4dU12327PDNNreX3pUtbElwLiiPTIsGdKtQbn1K/MDExQ6wKOZAQDxrdjS/CRr/SfaYLtDMWULnv3dMcE5UvATLtrU712WuWdVb+VgDFDnbl2MpDVykE1k3QtO/g/uIT+I0jX8REQBPOhkXeZuBl3qS8kGFwFERaIqWWyMgcJXwAl0SWG0oxxnXOUFJNwQBfo45gxv7tPx+nl6/nt3PagAcou0/1OZ0RMXDIXL55E1ML2vGTn+/uU7luyIutKaIkoC2ys2FLvYsHKCOUMNILJG4ZGENczhZAHzJHi7/+yNmT/rPgma1VQShr4lIaQiZRUw02D8Zff1xtw6EsUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/HiidgF395Ny2sfpJSq105jEJjfTpRvRzaSNYQkaZI=;
 b=FuLIS8NLPyNCmEBRecqM6iFgt9y6hmYTFBFylZsdkpR+xoUbWyJ5oy4Xd16sPZmB4CGysooOrILH1a9dXteU92aGQrh5I8k9iUbGeu2jfBayXazG6sFuDOpZlZMFPHHONmACSWJyvrcGz6ENZZ6LRDjys70jEomcv6dmHrxAmlAjtkg1+HlxgOzZUfXS3OSNv44d1mu8jW+yFiiP/BECKa79XcZbI/bsADV8y3cyOl+iwZPspEdwc5TsuFvZAGZZphHTN8nckTHA6Gw54dwC3vEPBxCxzHOe3D+8xvBikcQEOxOmwXF6/fOUL2DlesCcbmz3TWh0r/V9dBkOZi4jLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/HiidgF395Ny2sfpJSq105jEJjfTpRvRzaSNYQkaZI=;
 b=whbeNEupJJ+RryZTKOhrXjLYkH+EMHJYCgUFQ069xRKqstjbpUyEMrmoenG5F/BThrCUDxpzUPlK7/xXpfuDTMwZnNthLiaB7DyVZm4ebCWoQ+mnpHSABrfdcFuEl3ddHcYafDPSESkYCBHTEvljs9tyEsIUhAPJLp5gBQpSNr8=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by MN0PR10MB6005.namprd10.prod.outlook.com (2603:10b6:208:3cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 20:39:06 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::ec9b:ef74:851b:6aa9]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::ec9b:ef74:851b:6aa9%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 20:39:06 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "david@fries.net" <david@fries.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "zbr@ioremap.net" <zbr@ioremap.net>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
        "petrm@nvidia.com" <petrm@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 2/6] netlink: Add new netlink_release function
Thread-Topic: [PATCH v6 2/6] netlink: Add new netlink_release function
Thread-Index: AQHZnxnAVSNdqRlk20e9RoW+ctTleq+j4zEAgAAEbwA=
Date:   Fri, 30 Jun 2023 20:39:06 +0000
Message-ID: <61C9FA78-37BB-4178-B118-AC143988AE19@oracle.com>
References: <20230614234129.3264175-1-anjali.k.kulkarni@oracle.com>
 <20230614234129.3264175-3-anjali.k.kulkarni@oracle.com>
 <20230630202314.fprtrdvopjvr54me@revolver>
In-Reply-To: <20230630202314.fprtrdvopjvr54me@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|MN0PR10MB6005:EE_
x-ms-office365-filtering-correlation-id: 27ebc638-9f27-45f4-0d63-08db79aa0ca6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vMGheybXxi4guMq5wUwMM2TDfHeJYEKkz9BmsRvVlUEcCi9cdMDnKFmqxEG+X5dr9CyVZa3UrP7xoNZTe8fkukXlGNDrSPUzOdumvVBtkkW/soNHHbT8SQaxjwEFxbw1tFj39usbMYFsoGYB0wPLO1ZpMpUTlZ9lFMtzNCKaJQzu2b15TqHMNj8S8EOcCYbHlDgmUTzAsd5aMgj+IRWMROikJ4AcJdnekrvaHrhl4NI2y9TsAeCaiRPO4hoWvec1BRHYu2SYWO5XN40+/ilagTCX9fUejcZ5AiKO4aW+tnTott3sKdj/RTIasDw/dv9SfMUekO6kIQWv1JsLVp75tNzCtRu1YICpqfMSMH5HcYCcphCqRs3wyQrYBtNxe6Y2113iMMMA3ZZb4X/L73RZcb4Y/0oZ2s9MPbfZ6UTQVLTLBHwy+FAOwIMOO4+x1HISJ386YZPMGoKSklJPGUUqaHAOvf4R9q7+fvC9LO9COJnc0OCt16xVgfW8ei3NYvyQHccTYClobn9Sc1Gwu4DsW3ZxLVv8UPlJx9sEu3aRjVWFlpyUdpE+z79Q+LX77VxJxjvLIv+N82kaHVgf3HLQ764fCyyPeP1XjF6y8A4CE2pscSzOhAZCBmQ3l/sYYSFI+6TLtsq9PpBHXdbwxDyHmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(83380400001)(37006003)(54906003)(478600001)(6486002)(38070700005)(66946007)(2906002)(33656002)(186003)(26005)(71200400001)(66446008)(66476007)(6512007)(53546011)(64756008)(6506007)(66556008)(41300700001)(38100700002)(7416002)(5660300002)(76116006)(8676002)(6862004)(316002)(36756003)(8936002)(6636002)(91956017)(122000001)(4326008)(86362001)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G76Z5tBKo3Fnr6ixPOgfGxoENDtKyKG20ZDN3yUWcZuI1bAKAY5Cu0UinweN?=
 =?us-ascii?Q?QQEvpGDCkKNr9DdY6G5LHzHSHCur5TQaA1eOubbv1WdG6ag+AEPqaOw4nzhW?=
 =?us-ascii?Q?TL0tyZAHOO/qrS9DHzdtPzmHx5AvN6adTVbyBIyiTyIYii2m1K5ccWNa7ML4?=
 =?us-ascii?Q?5gOiPyCqMJH8JxoVdUM5N6VTQC6zd9Q3skVSvjLvYgWstDhCqKh5kNtS3fXW?=
 =?us-ascii?Q?+sQz1tnjDu14ZRTQ2mufDVgJWuuryBRaPN9dxpIehkPYmNnVmcun8W+WDAO9?=
 =?us-ascii?Q?g69jKNYCUkm+vMUTnAt9iM6UyksGoWEx4VYA+20ojXLs/Y0PxOotLzrkLJrY?=
 =?us-ascii?Q?BkbRHtlw4IevFvC3xs9Wel8SznetQvocarzNs6RjtboedTgYv6jt2Ui0+zvP?=
 =?us-ascii?Q?kCrA/cS/eObnOvdAfqD9VV5TzYmJBPulTDoVRayjw07yusiFONKUGZfWEcKa?=
 =?us-ascii?Q?4NanSrfa/6BG2E2X5Cw+N30tc8M0KJURZ7JZppViVANpvcN8LBDu+unV3S3L?=
 =?us-ascii?Q?oQcMhfT7bG1dg7u8Kg4egi1QHTPajLPOY9L8QS2x3ggzAU3z1CvbxhTQLFPK?=
 =?us-ascii?Q?GhYjqw3nKSHgcTp8QDKW3/R1lC4qWkllgb2e4lSJ5LVJexig3Y4hwMeBwKYm?=
 =?us-ascii?Q?OzEs6hDvJR1/oNaWEMM3TLuzMRnpZsMrlH8Yq1fpTZb+oI6lrKIXO18fxYJY?=
 =?us-ascii?Q?x8TBHHnuEZZbVebYJULYbgiMe9dzQYritwopTvIPBJ/rS4/Huqwxaoc2eMjo?=
 =?us-ascii?Q?oO8CvB+EXnbJw75CtwoAUtVw+19fhxY9OsI8KwyPPmEXqUAn8WJ7MrzGItL4?=
 =?us-ascii?Q?DhUL+uxGX8sr1f8a7ZArxftwW/2n8M1QOTGULUbDqhdlNqE5Hw5rlgzIPIwk?=
 =?us-ascii?Q?lib/oxH6f1eBk5Eq1WSH8XNc0UgtoCSSgkIqYBfgWeFUOXpNUC4zhgw8Ph7m?=
 =?us-ascii?Q?oo3nG9Tv0THwnDzuQkP+nH2hAW2AnVzZAgKzq0Hw2jyjWAi2HMUfgeULihVX?=
 =?us-ascii?Q?4br9+kYNR+BY7W6I2Ihmi6F5cMuaACXnJ9c1iW7ZsIGJxTt400JNmySweuth?=
 =?us-ascii?Q?MbwP+tOKB8jGbolkVdA8jSxPFqopFYxozOak2Ehf0KyDD0DC7Je4LMxsJohH?=
 =?us-ascii?Q?7SmabOQ2nDdNwI04CU++qHkDT6QyIWQrglgNY3jZ3qf4OQnCaE62kkgwL4Hk?=
 =?us-ascii?Q?uA/7I6CkGrxA7qHl4RXtEOrH9QfXgnqOhenHoGpdN1o3CvYNvonrkDZXmUC+?=
 =?us-ascii?Q?l4UL2wEw9OaD/nHP5N/qbWvbFDo3wtS18yhQvKoEa/A8JW84AQA216vQFKIH?=
 =?us-ascii?Q?6FPhgthOGV3El7OcQWDloQvo/uRu0z7vhE5Y2w+NR8izJQyyAWChQexQyZHD?=
 =?us-ascii?Q?x3Htjz2DLZwcsPanN9dD+TNQuMPSIRiyKi2ifgBelowrZm7ey0SQbO+wMZ9s?=
 =?us-ascii?Q?yNPr9DFQ7ENIP7Vw10FiXFS/x8+Xh77ZFZfVWZvsJ5ODLTVGwEDm5+Mqh0Sw?=
 =?us-ascii?Q?ko+FebeuGacxiXLDw9nvayR01bvFN8VIy125NVYjAbHjDxk78MhBWKbf3fNd?=
 =?us-ascii?Q?q437MsATBcxDI014FB9o+kDD7roLIiMuHeGUDSJJQr4eo032WCnKqc2Gn20U?=
 =?us-ascii?Q?NA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6D3A00F4D46F041967163E0E585D4EB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tgjNPNXKqfF/flzJ5MRnOQI93RecUVqhnxkJcIcdx/cvebtb+5Sklmgv9hBu?=
 =?us-ascii?Q?B7x2LqQTYNM2eIWAoYd+8+FiV5fWRuqR+NpOGCP4rC+jsiydc+0C0+8JCyvi?=
 =?us-ascii?Q?MBs/A2HUXSHmXEl+/g5mM6AGu85jCO6UG/OMxv6Na/D9xTNzbw7ZfjDgfN51?=
 =?us-ascii?Q?CrcLC2EUriiUYR2jdjJsSeLPd5eRq0QqKe+Ne6hNTjHe5nxegcqxMX1Gj8Vc?=
 =?us-ascii?Q?TJhIEc5aWvp86GHTY7dz6pyQDX/shKj3cP5qNxHmMr0eAhZjE5aE05uViyZq?=
 =?us-ascii?Q?jouWm5ZxqzsLfxPBh//+RVEXVdsHPU0gDIiSBylaRhazkXq2MZR+oEa7YTvu?=
 =?us-ascii?Q?2RsVNAwgJJU/WPZ7CWtEtcoS+MXwXCEBl9FwvlJgdK6DTI5a/96Nn6fNcyGb?=
 =?us-ascii?Q?RNLAXo+3uCR2xtFyTrNOnnwXMQWRq0FWYqppoaHkKKGvt0OzQwZ3fu3LfUUl?=
 =?us-ascii?Q?bGjI5ltUTVTzN4EUAFDDKNT4cvg+buKKoncj/j01KnmKJWLzyJ8m7c0wj3Ye?=
 =?us-ascii?Q?IND5CJfa7nJKAI4X4fBGnhT9fOYxzCpfj9r7D6sNhdTJt7qLBc2tS3bJz+ds?=
 =?us-ascii?Q?plgH9waoIopK2FlD+agezvi0lB35zEbQKc/uGrOsn9mXarOxFamUCtkwSx1U?=
 =?us-ascii?Q?YyjQUjowkgS1eB/lKYIOU1iNWtlUyBUq1rNeN6OWbz1yoP56hipNiYoxiqg+?=
 =?us-ascii?Q?gA7zgumsXNHIYZcdvxQH40vjKdx0LHj6ObBrk5ioz6v2THgZD8kHrz/zR09Q?=
 =?us-ascii?Q?C63rL0ed1V1iJZQ1q/toazW6vAdnajc8LWdGhLb4fpmtgAxxisVZeF7+HCnt?=
 =?us-ascii?Q?OE0g7CT3xEjrP6RuY2S1uTJYbj5N2/cy0OywnmWggkX8b4cfP0vAx98nelzA?=
 =?us-ascii?Q?PhP7XU7rJqe8cwqpk98SEOvDZl67HDwi1tFjMN87r66NzDkTDoDVSpg0Y9Kn?=
 =?us-ascii?Q?M0Gy28dC2FX9vN5MsfaFwrm3GDdf37MOetFNGZvhbiA055K7vnU94xgJnQoI?=
 =?us-ascii?Q?lIYqYfT3pLaO2a6O6tYzZRqx4hz5kXO0M16EPzxgXTAScO9nVmm8rVFoqWRe?=
 =?us-ascii?Q?JY31RTwl+zlujNt5iFB3ihE58tSAd/0rZmtRcBqm8TFfa2yYeWBNubzE9dlo?=
 =?us-ascii?Q?ezhlw3OamEViAeTXG6C+Rx7JrZwEDJscqIqPshmDmOWgYrqSONJQHG0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ebc638-9f27-45f4-0d63-08db79aa0ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 20:39:06.6068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XlXX1GNJz5B+d1HEzDt1tKMeKn0XK4tTMKyR7IOtMQOw/Hnjjqzgp+9i7FoXbJ9AsJxTLqSyW4aZZIVS6fHBLk1YGNb5gSFJv9v96rm+3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_12,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300180
X-Proofpoint-GUID: 4EhJtKwrCP3JhYEg1igky961oOUrZ05p
X-Proofpoint-ORIG-GUID: 4EhJtKwrCP3JhYEg1igky961oOUrZ05p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 30, 2023, at 1:23 PM, Liam Howlett <liam.howlett@oracle.com> wrote=
:
>=20
> * Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [230614 19:41]:
>> A new function netlink_release is added in netlink_sock to store the
>> protocol's release function. This is called when the socket is deleted.
>> This can be supplied by the protocol via the release function in
>> netlink_kernel_cfg. This is being added for the NETLINK_CONNECTOR
>> protocol, so it can free it's data when socket is deleted.
>>=20
>> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
>> ---
>> include/linux/netlink.h | 1 +
>> net/netlink/af_netlink.c | 6 ++++++
>> net/netlink/af_netlink.h | 4 ++++
>> 3 files changed, 11 insertions(+)
>>=20
>> diff --git a/include/linux/netlink.h b/include/linux/netlink.h
>> index d73cfe5b6bc2..0db4ffe6186b 100644
>> --- a/include/linux/netlink.h
>> +++ b/include/linux/netlink.h
>> @@ -50,6 +50,7 @@ struct netlink_kernel_cfg {
>> 	struct mutex	*cb_mutex;
>> 	int		(*bind)(struct net *net, int group);
>> 	void		(*unbind)(struct net *net, int group);
>> +	void (*release) (struct sock *sk, unsigned long *groups);
>> };
>>=20
>> struct sock *__netlink_kernel_create(struct net *net, int unit,
>> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
>> index e75e5156e4ac..383c10c6e6e3 100644
>> --- a/net/netlink/af_netlink.c
>> +++ b/net/netlink/af_netlink.c
>> @@ -677,6 +677,7 @@ static int netlink_create(struct net *net, struct so=
cket *sock, int protocol,
>> 	struct netlink_sock *nlk;
>> 	int (*bind)(struct net *net, int group);
>> 	void (*unbind)(struct net *net, int group);
>> +	void (*release)(struct sock *sock, unsigned long *groups);
>> 	int err =3D 0;
>>=20
>> 	sock->state =3D SS_UNCONNECTED;
>> @@ -704,6 +705,7 @@ static int netlink_create(struct net *net, struct so=
cket *sock, int protocol,
>> 	cb_mutex =3D nl_table[protocol].cb_mutex;
>> 	bind =3D nl_table[protocol].bind;
>> 	unbind =3D nl_table[protocol].unbind;
>> +	release =3D nl_table[protocol].release;
>> 	netlink_unlock_table();
>>=20
>> 	if (err < 0)
>> @@ -719,6 +721,7 @@ static int netlink_create(struct net *net, struct so=
cket *sock, int protocol,
>> 	nlk->module =3D module;
>> 	nlk->netlink_bind =3D bind;
>> 	nlk->netlink_unbind =3D unbind;
>> +	nlk->netlink_release =3D release;
>> out:
>> 	return err;
>>=20
>> @@ -763,6 +766,8 @@ static int netlink_release(struct socket *sock)
>> 	 * OK. Socket is unlinked, any packets that arrive now
>> 	 * will be purged.
>> 	 */
>> +	if (nlk->netlink_release)
>> +		nlk->netlink_release(sk, nlk->groups);
>>=20
>> 	/* must not acquire netlink_table_lock in any way again before unbind
>> 	 * and notifying genetlink is done as otherwise it might deadlock
>> @@ -2091,6 +2096,7 @@ __netlink_kernel_create(struct net *net, int unit,=
 struct module *module,
>> 		if (cfg) {
>> 			nl_table[unit].bind =3D cfg->bind;
>> 			nl_table[unit].unbind =3D cfg->unbind;
>> +			nl_table[unit].release =3D cfg->release;
>> 			nl_table[unit].flags =3D cfg->flags;
>> 		}
>> 		nl_table[unit].registered =3D 1;
>> diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
>> index 90a3198a9b7f..cb2688aa347a 100644
>> --- a/net/netlink/af_netlink.h
>> +++ b/net/netlink/af_netlink.h
>> @@ -42,6 +42,8 @@ struct netlink_sock {
>> 	void			(*netlink_rcv)(struct sk_buff *skb);
>> 	int			(*netlink_bind)(struct net *net, int group);
>> 	void			(*netlink_unbind)(struct net *net, int group);
>> +	void			(*netlink_release)(struct sock *sk,
>> +						 unsigned long *groups);
>> 	struct module		*module;
>>=20
>> 	struct rhash_head	node;
>> @@ -64,6 +66,8 @@ struct netlink_table {
>> 	struct module		*module;
>> 	int			(*bind)(struct net *net, int group);
>> 	void			(*unbind)(struct net *net, int group);
>> +	void (*release)(struct sock *sk,=20
>=20
> The line above ends in a space.
>=20

Thanks, will fix in v7.

>> +					 unsigned long *groups);
>> 	int			registered;
>> };
>>=20
>> --=20
>> 2.41.0

