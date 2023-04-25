Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA106ED9F9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 03:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjDYBoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 21:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjDYBoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 21:44:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EB13591
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 18:44:07 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P0hv9q031084;
        Tue, 25 Apr 2023 01:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=WC/skD1rgVbzUfhVhPewweD/L1ZsoG1wkyYxaWJ4ChA=;
 b=LKGV+ZQP3/Idxw0LNYitquZyZYefCXpC1zLOyGZ7+1T2Dyfbp5YrZGD3YUl22kGr5s/1
 CA/JFrKcm/rn7qWQ1O9b0gYJrUEwX43fkRQDafvRDJDcPbYu7C2rf78pLR665sYrBUB7
 +kKO2USDWmhMRAEtiDAWVvofKjPMq7EHDD+UVoyoj/M5JXaWu3D/qSsbrr3OQhlfh20m
 FCqQwVkO/pBdZLx3euvDsawV86WFZmZ5KPr0EbVSdv+aMTFZGHvDLrmEypYrNzzpS/C9
 LPFM15uOUFaYTkmD+9eDBEHNfK+Tck8LXSX53VssdfHJgMNEs1Ki7Q5j8HcRnotbQW2h tQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47mcv8gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 01:43:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33P0wFaQ008660;
        Tue, 25 Apr 2023 01:43:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q46161j3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 01:43:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1WH+pmoyIwgUyybmyfYDTWDqLvX7aV5JnMH0Sr9UR6aXx/LXaR6yPK1RIFlUAnZJboquJV2MinGKpmwMiw7vrXEri0J2T5HVgLLR4ccpFpnzPEoogZL5vtEdJ559pVo91HifOnkTk5c9osoXG0/eTityuJnLIoRiBZv3z/oV7ac0x+NdNwnsKNgxP9c1KGXc7fY8RNYQjW4GMFTErfQgdtlLo+r8Gx34XmFImkr5gHoJ8gpq3rF0fqYrUVSCgUxlAs6icVygf3OAkL0uAOKc1OUqtxL8tsv0rQW/IPoLNKMQxBGXH3zbkTL9bcpzUuoXIXCoZ1+b1fJej0E53LX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WC/skD1rgVbzUfhVhPewweD/L1ZsoG1wkyYxaWJ4ChA=;
 b=MTmL6LEowrZnqnjZy4lwnN1OBQlkxCZkiWY0VuqcvJSCxDvMBpXW9+H3GbsOF4PEceNm9E6KDRju2tlw8PFyWqRfm7AFjHCKgTBq2JQ5GE80ozfdbUp/xe4hG27HjQ2mPSGLIezIXn56+r8Itdejg8lPr5q3+7BHSFt1BnwCyKt7lWZ+m5BAKsXWBCsx4nDqOHNN5ZxrsiRkSK4YI2sWMwQGJb1H4pUrJTI6fEczjWZr9aucbIpvZA3fx07QGB1w0cAaABRegJKY1DxC1YjPtO5IVZJM1rPjkpbwVPsZ410+SvsyCHHXcMRLN8suqmY+pc1gt5IXVBM494fUTAxW8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC/skD1rgVbzUfhVhPewweD/L1ZsoG1wkyYxaWJ4ChA=;
 b=vRGZ58T1TU3O97jXOB8WTKwUBYi3UptwyNU5r8WdhP/qZR+qpTwULpcbh09TItGfGnyz1mOxQ1/LQEm282DYPbspR5FNXQezSAeXbkZV50TsvEztmBb6SuIPc9CnZIzr986w3clf5MvqLlr2ZnJSpuO77jf4/F0B5zf9yE2a8Uo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6620.namprd10.prod.outlook.com (2603:10b6:806:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.31; Tue, 25 Apr
 2023 01:43:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 01:43:32 +0000
Date:   Mon, 24 Apr 2023 21:43:28 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/3] Revert "android: binder: stop saving a pointer
 to the VMA"
Message-ID: <20230425014328.d6vvimziv6je5xdg@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Carlos Llamas <cmllamas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        linux-mm@kvack.org
References: <20230424205548.1935192-1-cmllamas@google.com>
 <20230424205548.1935192-2-cmllamas@google.com>
 <20230424223419.6n2z72mocgmcj3aw@revolver>
 <ZEcMhOywwzsc6CN5@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEcMhOywwzsc6CN5@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT2PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: f7501f95-b9b8-4323-8194-08db452e7a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6UrkBWPPLgpV82q33s5c54ciTWR5jWbGfCSYSyxFkheo35VLppvApclbuKqLzZ1BQF3KZ1D+cJ9Sr2UBYpnPTSdEQnnMiuXtk4UJrtAYNxJfG58sf+an4QtG08jEje27y3YYNYKSLiYlRdhmQMy5gDapSR7RAR7J5WvXFm8KZqdMhw1CvJRGUS2x7JSZd7NppAg6XiOX0I7NyXLLBX0wb2GHSCJ3mFk7/sLw6bol75h1N/gRdNBl4UpY8wsrge1stmeYgWasICsuH0zw9dP2xhcvhisGJE9ihH1KEqVLgJ2nQCQiwC7Q/O6714UbHljgjs+SjR5HdjwSAFr8IXfKdIBh8nHP8wHLK8vHCcvIa934ulXf27AW9Js0u22cSXUy7ttFTXF44aWjwbsO0CS9z8xzaM3rExiw0KsRd73cr6U7D/mVnF9vlp09dnB5kzwdfVei+b7wrUZnVflXOho6/N4s5b3Gy8ED8M3J3BWbD63l8jGt1EqoO340uNzfzJyXdaoLvhi1IaoP5CZhExJGgHwcd86KaZ+02fUwcf2yHPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(2906002)(5660300002)(6512007)(26005)(6506007)(9686003)(1076003)(41300700001)(83380400001)(8936002)(8676002)(7416002)(38100700002)(316002)(66556008)(66476007)(66946007)(4326008)(6916009)(186003)(966005)(54906003)(86362001)(6666004)(33716001)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9oEJb4BlFPXSD6zwShgNPRqqLD0UHxnsSIgF09wOOYWKYs8agdfjE5Klu5HH?=
 =?us-ascii?Q?j3nLK50hpYOOZPLeOgUGt/7ETqPi2HENGfrnWQeW0j0XluBa1CSHNWCnzkCg?=
 =?us-ascii?Q?On+mvfn8colaSHQOaH/SZjli9f3KnbLpJ6ng3WMCxdphbcV3R7W3hKk5khqF?=
 =?us-ascii?Q?zbMn+fOL9auxqD+pAfcO65aE7Laj7dFdJ6F0vfeVd07ocqjIcU1pwLk1wp/x?=
 =?us-ascii?Q?joMHq8o42+QNDpd0emNj5bJU1vL/Re/5e3/KIZAO3X90ieTd65Q40pcUXCpr?=
 =?us-ascii?Q?HdGwOzo3RC+WBkBDf5FHWXAlgZmF0r5ElQguTeztONypsgmWCqm+8fCcSZ02?=
 =?us-ascii?Q?BcFYWk2HGZjIIcHbbXNkUz4AhriC/Y9azLN6NmtO0/5aaAlj8nUoEzhnoD6V?=
 =?us-ascii?Q?gdF7f+IAVsJ20FfitmpOHJbpJa6/rmoAgJNwsJJjokXoG+LTrEbMVT0PWcpQ?=
 =?us-ascii?Q?dQbg51IUaM54d4/GX27v3DmQ9rP4wBcd4vD//I0MMCSyIAPkkAUoR6n/eTns?=
 =?us-ascii?Q?Xsy2RoEHwdq31CrPOLo3t0bRBCh6ixe4TySBQImHYs1hZ6US2Huy3H8dw5Uq?=
 =?us-ascii?Q?7KmHZSjEQnW7WYmTXlM+GUxp95kr9rHoNnS39uAhSUdENUYK+EXiruSuuMBZ?=
 =?us-ascii?Q?337Xcw+lvCrAl0/oKTkVluYIRtRsBvtJBbo6eeeT/TRV6dzjRRMOVt7EaZpe?=
 =?us-ascii?Q?fUR2NpXV2XkDOkX8QVRrs93Ypc42T+Hybf7Sw9z/egMnPiqQAtD77oGn0tIr?=
 =?us-ascii?Q?AKePV7XvAZMaDA251iYyyDJ7Pt3pI1v5GTEEolyAXa7nZocSB65fOjbdURgx?=
 =?us-ascii?Q?uQ+FeKbCF/pHmGJWE0a30OOY3me/BYJGl1xrZSWtNhrxvTs2pD0IW0TCEsdw?=
 =?us-ascii?Q?ga8ZtugRXRSknfuelQTs+aKfAAYajtEaLTNMVy58Hg2zubCwemO5YJ6o17fR?=
 =?us-ascii?Q?0zberrs8HYRKv5kiF/HH8QrcXqPWyg7V5uAGCdSzA/Y3xkBfxEjLa+HinD6b?=
 =?us-ascii?Q?OgAI36HlNxEiKoOOdmUQ/hHYhsZGEJiS5fPCO9F3BKjnBz9aDRVXAkuHEbaU?=
 =?us-ascii?Q?+WIb49YstFYvnMDZeeDB7TL8JfERTU9Vng7RFqoRfep3k8G4BXtD99m9Amyl?=
 =?us-ascii?Q?T/0mobQkaijPKs+llCZmkSFSAP2n8HKPg9IppquDpqwVG5so9g7W7kCyyTTv?=
 =?us-ascii?Q?7EqpNTAFJu4OR1esrpe0JHK4sKmAY+MNPHrxxXQa9aoYWQgLZCAmoJn+uN1s?=
 =?us-ascii?Q?mu4KuRUQGYV321Hfa5GkaswrFeVyuw/O6B9+PNlBJVrjMcL/X/QjcDQHrF3Z?=
 =?us-ascii?Q?DbfIV96ScUckM9kmr6nIVJ9fshrohm3pWcnxHUeRyniF4In/FIofsgKsoJNd?=
 =?us-ascii?Q?oXI21A7qgaexe60v7hwmnM6lMNOWcCEsi2kSZAN6y/i8w1Cnm3QEScTClSEb?=
 =?us-ascii?Q?tqXq2ysE0OJ3bGAT9EINEI/pDv/fRwpWgL5yqt/slOByVDtzoGldQh6t+ZwD?=
 =?us-ascii?Q?SrheY6b2Hd3kVMwyur5ARedDVChNzsQYnlWyzqt4wvBpA6yY8nGq0c9s6d9n?=
 =?us-ascii?Q?mgHyOfeFV6UHf4qSS8j9mKysXTcfs4V+Dwe5PWKiMtCUzrzuKM6u4kKTL9M1?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xeuIEFVRb6BoQM66bbqIm8EWs+67aUfCeExKZ0de0LpYTWmZ3MKI/v8EpkO1?=
 =?us-ascii?Q?X3tWIN/jw2Xb4JyOfhGD5v8cU6071UETYX73CgJmfxyldnhRk56d974LED9c?=
 =?us-ascii?Q?7+2ySenGKAGIL+yBLfO2kwVK8R1n+JrGfwrHpWLxF/2Vqx8IQXh8VfR6jebq?=
 =?us-ascii?Q?pPDxOrZATNlHj8O3VvoIoAJGxwR3t8NUhd2VfXmhiJ1gdYcRzn+wiYdnRh7j?=
 =?us-ascii?Q?ghgUg0Cldo0DQL4ZOnw6zhYnYHj0aZL/KtNIaEV3on7FA+D0V/p4GQj/EPjL?=
 =?us-ascii?Q?tszwqZB+/YLpTXi46XwC/oCAk0nsty0CUh2H5/x+1lRV5l/Ei5IaEelDWDLE?=
 =?us-ascii?Q?NBfI0H1b4iWb9WtmPCg53EJvorPQLsY1YP3HO1EIqOxaVSAn3z/xb05XGjSv?=
 =?us-ascii?Q?xl7k3CRMwaDGHoSeJV5aD4FQvLAScwNSFCBI0mPFYPxtLljSj/msuFRATlsi?=
 =?us-ascii?Q?uGMDx/E+ooABm9GYB5yeftPhZyJD9MBS2n2yP85eEJFZ3LMvBasy9K9WLNn2?=
 =?us-ascii?Q?HhVPrp1mJHJZFbUiKtNfg5rUVMU7XRIEHN/P1CF5aFpneYgLXhjdXHdq5xPy?=
 =?us-ascii?Q?Km9rFRrKMujYtqcp48AAfhHWEBdOCpwbHNV96le9amrmlnt+t6FC2n7iwVVN?=
 =?us-ascii?Q?AHPxsTT2TT0ZX3pKV9iq6283aj7YQ50bR7gqoaTztAFugFjSbHEjNt/drzlv?=
 =?us-ascii?Q?Tpsqs9/IPktTLgcGHj+GQp/M7UWLyztbylWQ5AAkVWwBEzGJlNWA3vrexPiQ?=
 =?us-ascii?Q?f2qCDia/lTLY1I3vOAPN0MzsYXn+K0gT5B4cP+2zDK3Qks2z2fgOh81/qTo4?=
 =?us-ascii?Q?XTgH6kZsBLFZTXVMTu0HRNmTOGdRiuP5NGZk5x57Pfohe9Pt8uXKdC+DuqGh?=
 =?us-ascii?Q?x0WPdE3qjLfgDJ1SUPw24kOBLLVEdR6NgTscoQ1licb6RWtjOxJIIsRooftE?=
 =?us-ascii?Q?U2xxZtm+AN3Gw0bj0lH8ZNODGCS6sX4LyxcxgstV3bk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7501f95-b9b8-4323-8194-08db452e7a09
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 01:43:32.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tf3sE9VxuqZLVl4DWttFWerCwMOumHp+GiYlFLxmCyPdgcfjHsxlA/1ToArvqnsSsyQXY+hOaCBwOZqX6YQE+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_01,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=742 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250014
X-Proofpoint-GUID: rTtVeuJdpe_lAAozid4RgBm3BXQKDTC9
X-Proofpoint-ORIG-GUID: rTtVeuJdpe_lAAozid4RgBm3BXQKDTC9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Carlos Llamas <cmllamas@google.com> [230424 19:11]:
> O Mon, Apr 24, 2023 at 06:34:19PM -0400, Liam R. Howlett wrote:
> > Cc linux-mm
> > 
> > * Carlos Llamas <cmllamas@google.com> [230424 16:56]:
> > > This reverts commit a43cfc87caaf46710c8027a8c23b8a55f1078f19.
> > > 
> > > This patch fixed an issue reported by syzkaller in [1]. However, this
> > > turned out to be only a band-aid in binder. The root cause, as bisected
> > > by syzkaller, was fixed by commit 5789151e48ac ("mm/mmap: undo ->mmap()
> > > when mas_preallocate() fails"). We no longer need the patch for binder.
> > > 
> > > Reverting such patch allows us to have a lockless access to alloc->vma
> > > in specific cases where the mmap_lock is not required.
> > 
> > Can you elaborate on the situation where recording a VMA pointer and
> > later accessing it outside the mmap_lock is okay?
> 
> The specifics are in the third patch of this patchset but the gist of it
> is that during ->mmap() handler, binder will complete the initialization
> of the binder_alloc structure. With the last step of this process being
> the caching of the vma pointer. Since the ordering is protected with a
> barrier we can then check alloc->vma to determine if the initialization
> has been completed.
> 
> Since this check is part of the critical path for every single binder
> transaction, the performance plummeted when we started contending for
> the mmap_lock. In this particular case, binder doesn't actually use the
> vma.

So why does binder_update_page_range() take the mmap_read_lock then use
the cached vma in the reverted patch?

If you want to use it as a flag to see if the driver is initialized, why
not use the cached address != 0?

Or better yet,

>It only needs to know if the internal structure has been fully
> initialized and it is safe to use it.

This seems like a good reason to use your own rwsem.  This is,
essentially, rolling your own lock with
smp_store_release()/smp_load_acquire() and a pointer which should not be
cached.

> 
> FWIW, this had been the design for ~15 years. The original patch is
> this: https://git.kernel.org/torvalds/c/457b9a6f09f0
