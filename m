Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C3C700DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbjELRaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbjELRaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:30:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902C0E5D
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:30:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4awr021732;
        Fri, 12 May 2023 17:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=jVp/uLY3x2Q7IgeK+8wHOypSBOIChyrocgWvigGlGQk=;
 b=gnMrbCd9XBCYE7/zjF7REYgm/yI9AwOMSeGSz6YbfFhqwPy/GUKmHlUtJQvafZRr6VEm
 Kmxlx+bmcwjcmdEz7VP3ED7al8pEqqvBCsR/vvtUwnc8VCuijprp3+kGdYX8j/VLazfO
 T3vWN1oogbOMsUTCTVVxXJFvwdrN0vJqa9FMQFle0mjO195uPfHN57KNEy/VY0lgw+nQ
 j6Y1LsbKdT4LvEWgqWqVoz41JQ5cMZvsDwJ4zZ99dw/c6aGvplMJIc2bTUWTH21DA8CN
 Db4w5wfTKLaM5sbuuX9IDvBcTkY017FZ2pwRhXBf7voJV0R+ePzI9Z4cdGs8zD+a9xrI jA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77939tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 17:29:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CG4JQw011616;
        Fri, 12 May 2023 17:29:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf81555jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 17:29:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IftNorZjO83ZEQq/oCUqY+Q7vRrGxizZLk+o7h6+8KEBl75pRydYJvgk2w4cRFPPR7/TV6qK8Qh5TdPOvX686SinqYlyP1f6zGi2QX6XvzUY+H7cL+U34TRubHVxwSubjKktzqbA94aUztCrS0FY0QsZdtpGZobaiB2q9T+h25Dwu1yevtjI5IIOnaWXMDOokml7itpnhx7UbV76Vh1EXu1EK+YWYoNd+/waaYHC8zrPAFmQmEFcaWCRGvdr33AIm11uLvP7DYkM1Fo5BxSRXVt6rrXyIMZEoiMp33+QmsE9ipWX50ubhKx3q4qllo+p96q6oeuqj63RNURpCt9LOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVp/uLY3x2Q7IgeK+8wHOypSBOIChyrocgWvigGlGQk=;
 b=MJf23eur/x5GAXUC58GBgVRWQHNMuaYopHCHrrTd6xYZOYfLThUQib76LgOLKzTB8+yva3bF2cqkR4zVeRRy+8PB1HcDadPaewlRXzdqh3EEB+zVlTsQlnBFKpME3ljKKN+yQDMs0N3HA2zSTv7nwYEL5xOFu1w6Loeok5UCdhUWg564Pgvs3vJWu3V4MYV1FmzMuldo0pjiLL5FHzrJ2mQR3T0UNJntssapxWhJaHQHctV+UK/BT/tp4pFiPLioP5qGJdYlVbxdHPi+tTAJgk10FZcCXsGIYX9I9M4PNlde0tRMQ4deLwaMaEAdyNWS1UMxho2r/QSdPZ4T1COdrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVp/uLY3x2Q7IgeK+8wHOypSBOIChyrocgWvigGlGQk=;
 b=q6uW7h9g1hNJzQECafb2qwJ1HFDsYvWkGBhgFzCuJsS8dONpBGn8+htCrHmOOJ9ExnC/k0tVnHd4NPiqYDCRfUqJ2pPyZpUffqK/JiZdiVKyts99la99tbQZDu5iFvHwVGaqvkTNKOgHYpr6MfvOfCjB+YMcdCp7DTrAk1NRsSQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5759.namprd10.prod.outlook.com (2603:10b6:806:23d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 17:29:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 17:29:31 +0000
Date:   Fri, 12 May 2023 13:29:23 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 32/36] maple_tree: Clear up index and last setting in
 single entry tree
Message-ID: <20230512172923.eqiq34bcotbcro6b@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
 <20230505174204.2665599-33-Liam.Howlett@oracle.com>
 <5ca5da7f-1b17-b22b-58c4-eae41443e334@bytedance.com>
 <20230512155427.dyoymejdgnitfkcu@revolver>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230512155427.dyoymejdgnitfkcu@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0355.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2910b1-e6d3-4794-2e0a-08db530e7254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhV2Zc1SsngKuj8/vBEmCvz1ForiyyO1OUxK09KHGKxtzFa1aogom3nZbWGGPE2P0rAw1GG/ZOPAkCZ9Nbd9wMc0rS9lqYJ7Xzi7C2NNSarqu3xdHefknKE7VydVPCDecnmNdX5OWAMJZcGtdqdZm7aLzT64XxNDMJgIPLslC822RY3uOL8+0gKqrL//mZ4YYkCXzmyJ48zz2T9iR67QKMnLnMDfPYM4y2j8/FLQtLiIl+TTdL2k7MF39urEV6nYu58vdow3BSl/OjtIPRLy3B/XabKK/qHR8DwqMoIroJtQPSCB/HQo1Yhm5v51KgwX+w5WJo+Ov6ExkXlz5WhatxRzRoEZhfGkOMUYBdNficGP01x0xpxgkKCHK/5rfMyWXtulZ5dpwBhIV5JxIe2KogDyNAJfv8ibJE+Xoi3txUumPuRRaxkQocDxHtQX1LwIXrXwrKsTfXaS6aXHgOkviaAOsqebW37WAZos20HAGDLl9i8qReOK3NLckWQZIF278Cqbk1IbVR+5Y9pcqd4JDvQ0Vfj/JPbAe/ielBqG5Gi2824KtXy0+ga0KMHo0Tet
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(83380400001)(2906002)(6512007)(6666004)(66946007)(9686003)(41300700001)(316002)(66556008)(66476007)(186003)(110136005)(5660300002)(6506007)(478600001)(6486002)(26005)(1076003)(8676002)(8936002)(33716001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUpCMWVFN2Q4NERuV2RUKzIzRmpER2Z5SmZtOWw4R2tQUzB5SjFjQzROQ0Z1?=
 =?utf-8?B?WlJ4YkliTzNyWHpaWWJKQmJEd3k5SnU0V3J6ZVB4bk5wRG02K3RqS3d6cEd5?=
 =?utf-8?B?Smhpa0hIQ0VmRFIxTHM3UGZWRlVHanZOWHZFK1Y4WkNmMlRCVXhNT1JqSVdo?=
 =?utf-8?B?RFFGNlNnWU9KQ0ttOVArSjNNYmFicmhJVkhsZnh6MFR0QjEwRUpldTkrMTI0?=
 =?utf-8?B?TDM1M1d1ODNjVlAwTHNqRFpwblo2MlZueTZQZDZIYWxCeDY4eGVkcFlPTHVQ?=
 =?utf-8?B?bk9VZ3dWbGRqOXZIOHNVVDJuTEgvWXdKd1BTUFJ1ajg0MXRhZjdjeC9DRTRL?=
 =?utf-8?B?QUY0NGh2TndZY1YzMThMeVJOV01wRmlCMFJlSkM5ZDJYNHVQL3JTYVNmVGJU?=
 =?utf-8?B?VDZ2RlNqLy90RktIbWVQYXFSaHU2eUloVVRkSkVHOTRsNDYyMHhTVk9xeWlT?=
 =?utf-8?B?M0dEdmk1bVBoQ0dENVVTZVlqVm1PUFJJTFNmZEE1U0REZ3hINWFQM2wyNlVX?=
 =?utf-8?B?VG1PVEIwL1Y0a1dZUFJkd2w1T2ZmQXN0UFh1eVVSNnY3SUsxNUNHUU9HdnR3?=
 =?utf-8?B?d2xiaVpNak1KUzhWOTNYZnRZRkdtOFdndHBYeW9jR3hpdVdjRCszaFBOWGNP?=
 =?utf-8?B?RGZnanh5bUNvYmJFT3dML0ZhdXZ4WlkrQndveGNoSkF5SElRc0tsSjRHWDNn?=
 =?utf-8?B?TGhVajRiNEM2RjFCc0VKMEpKdW1SblBzSWlvZ0JtTnFYZkpycmdFYS9BK1lN?=
 =?utf-8?B?WU5lc0k1R3AzZ1YxOGcvN21sNGdlVXVUUDJ6M1lkQzZ2WkpzVitMcC9sVGlM?=
 =?utf-8?B?cVNTRUdxajV2SHQyUTluOC9ZcUFsVUdwaVoxdkI1WlR5RDFFMW5CSnVKRkFl?=
 =?utf-8?B?NUQvTWtHM004dWkwdE1SU2VINzcwVE9McXFJMHkxc1FvZU1HNGs5RXZERU1Q?=
 =?utf-8?B?STVjdzFhcEE1d3UwQm44bTlNWkVaYStCcHFQQ1RRaEZ3RG9lYURXQ0V6M2dH?=
 =?utf-8?B?aTlDLzVNc0VZTXlmcThoWUlVcCs0elFmSnVnZHVldGoyTlZLdHhhNjlJUnVy?=
 =?utf-8?B?eG9GdUNLdE1XZ1BHZGdWM2dQbC90NVpxaFRFS1VpSXJXSUFsNll3bENXdkVm?=
 =?utf-8?B?VTRvUS8xcktLU1V5bWtGcHpIcjNuNm9sN2JZc3Fob2ZXRFV5eW5ldHJkdUp3?=
 =?utf-8?B?bEE4QjhxcTExUnFnSXZIZThsRi9DVllxMzdjcUsweUQ3T0FLVzhjMkJLaFd6?=
 =?utf-8?B?U3NNL0VBeEN5YkhQNzNHQWh1RTlQbzhPMnBMRDVSdUZwdXJNQklYSjVHSE4z?=
 =?utf-8?B?REFsVkNMY3p6YWFsclVOYW9sSzlSanNqV1RBR0p6RFUvTWVYYUZJdEJiTEJj?=
 =?utf-8?B?Y0w2YTNZN2RPMWdWRlI5R0IvaDA4Tm5rb01YdmFhc0c1UE8rb3BENkFuTW5I?=
 =?utf-8?B?L1BWTG1xMVo4OTZNSjlBUEVIL09YeE1Fay9DWGxRNWpCRWNwQnhXY3lXYW1W?=
 =?utf-8?B?SVBrakZyeFRxM21CWGlEVFpXb1Zva04zVGkySkhUc2Z3S0NobDVIQVRSdnFQ?=
 =?utf-8?B?YmYrTjlnMU82eU4vRHY0WmhrTnQ4aStETzhCM3dPNm93cmNLRGdFa3dBUWE4?=
 =?utf-8?B?VVcxd3RGcFhsUEZldzBwNU9SUnJXT2hlRmltODlaQzRXMU5zcDRlMlVTdGVq?=
 =?utf-8?B?cG51bmRFYURVbjU1WitpMnFtQmpFQjhFdUdqNCtMVTlrR2ttWFhCUzZXbC9p?=
 =?utf-8?B?S05NOWFsZi9MdmJDMzBpSWN6YUJ2ZGI2ZW1OUGw2ZHRLQU1MY1RNcFkrVlBK?=
 =?utf-8?B?WGVWeFpmK3U0dk1ESWcwMlZsTnB4NWkyWUJKU1Z6YUY5eElVUVYySWZWQWJh?=
 =?utf-8?B?cWs0a212TGZEVnFPb0VlNzVYWldlSXpvKzZTMDRveHhIc043SXF2NW12Sm5D?=
 =?utf-8?B?dERaa0JWNVdwZ0NzdkFQWU1Vbnc0U1EvZmtoRDVKaHlEL283WXFCR29iT2FW?=
 =?utf-8?B?MDdZY1hOcUxuS3ZrT2p2ZCsvNGJpdEVaZGVGOW55eXQ1RldKS2dKaEFyMy8r?=
 =?utf-8?B?aE80ai9CRWsyL2hhSG5JcnNWTDUxTVd0Y1Jrc01LaEYwL1d1TGhsTjVMN0VC?=
 =?utf-8?B?bU1qZktycm9UTHZsY3ZRZTdkV1ZENityR1dyZU1hQUt6eHU2MDZZRlptMWV2?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S3JLM3kreS9La1F3bWtQTmloRmRZeXkyNExFVlpYLzRWRmIxM3hwQ3duaVVy?=
 =?utf-8?B?S0hZbnhMK25pNDlMZlZnWGloam01ZEJBSHd0aDJpVHI2Z3NVRnBVVzdWWkxY?=
 =?utf-8?B?b01YUXY2SWVoSlJ4SHhkRUZmQVFlbUJEazRlUUszZDdGWlVKbU0yMjJndkx3?=
 =?utf-8?B?TmR0eXArUTdqNThEbFBiTUdEbWNpK29aUWdCVDJIVVdzNmJWbTJHeEVRLzFv?=
 =?utf-8?B?Um90U0hrZTFvTGVLb3dOcHNQT3hBS2c2SmdNUWhwc1REUm1OUGt2UURGTm9X?=
 =?utf-8?B?NGJMQjdmL25xaFJBQkluZlExU2N4bXNvZUs4amhjdzc3ZlhtNGd0MTJWSnEw?=
 =?utf-8?B?REF3RUgrVUh0cXYrK0pMU1BPSitYUk9zaFlER2RISWZrTzIzZjNXNVNPdTRa?=
 =?utf-8?B?VDBXeTducVdIU1U4di82cjJLSXlKdzRwUUVhS0dxZGVENExISHpCVFZNVjFx?=
 =?utf-8?B?WWNwVHJkQkpONXczNEZrKzBRck56L3E1NnhXSlcwOVYvV0pYOVBXQXV0bEZZ?=
 =?utf-8?B?b0h5QXRJc2xBYVhDVDdqR0QrdGRiamlrYzk5YlIzV1R4dFkweHlQLy9GeTMr?=
 =?utf-8?B?QURNMEs0YzJmSWJKUnluYmJvQXRyWkFuOURuYkllQWh2eHBVQTBNU3VUVk5E?=
 =?utf-8?B?OWVldjBoVElGVTZKT3ZINHJtYnNMalVpU29vaDZDbWdnYzV1TGFORGFUZ1N0?=
 =?utf-8?B?UFBoRysydkd5ZjV3aTdKNkl5T2FLUmhzYmJoKzdEN3UvR3VQMk9ncHhwQnBG?=
 =?utf-8?B?K0dkWENMWUVleEFaZnRZcnpvekoyRjRyNFhOTzQ3Rm92elN0RDFsTXZhUGZR?=
 =?utf-8?B?a2d1WFN1WVJIZ2RhQ3A5S3puSk90SVA3RWlaWFBaT2ZuMEluWUtjYXRmd3ZY?=
 =?utf-8?B?OU5xNGUzM3FHNk9PRUZ6ZWdtdXJOdzNJdEtTV2JnY1dtV0FKNlZJaWpLTElV?=
 =?utf-8?B?K0tOdkZibkdURHVDSmtsUDd0eERpanF1ZDkvWVVNV0wyTkEvTytGaXhyK08y?=
 =?utf-8?B?SDh1VWdxK2huRm4yMTRJMCtUT3FmMFlVQUZXK295aC9MZlBOZlIyWTFmeGc3?=
 =?utf-8?B?YktOamNVSDh5ZVc1WW9yYTQ4VjVOZGJzSnB5bnlpWHZCSi94alQ4M0p6MHh0?=
 =?utf-8?B?MGtxL3l0MnR2cmx1dG1pbVJvcTBaaTBRY0hLcmFKdVMrcWJoRC9mc0s4R1Y0?=
 =?utf-8?B?Z0J6VnVEckx6bEJsaUJlSHo1cm9sb0tHZ2JjMFZvR203OGNXWE5ISVZ4bXp6?=
 =?utf-8?Q?+rUZwjE6CwZI2js?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2910b1-e6d3-4794-2e0a-08db530e7254
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 17:29:31.8223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GP4QGZQqufWqeJcd16mcZ9U6ehwPfHpYYIg0Kg/zoldZuK7v+NMPgtaXoXRsQE+dYC8teNfJaqjLpPYXXbmBOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120146
X-Proofpoint-GUID: xtToKKKXRJGTBaGZNXjQZZNL5jFci8ZB
X-Proofpoint-ORIG-GUID: xtToKKKXRJGTBaGZNXjQZZNL5jFci8ZB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230512 11:54]:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230509 08:39]:
> >=20
> >=20
> > =E5=9C=A8 2023/5/6 01:42, Liam R. Howlett =E5=86=99=E9=81=93:
> > > When there is a single entry tree (range of 0-0 pointing to an entry)=
,
> > > then ensure the limit is either 0-0 or 1-oo, depending on where the u=
ser
> > > walks.  Ensure the correct node setting as well; either MAS_ROOT or
> > > MAS_NONE.
> > >=20
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > ---
> > >   lib/maple_tree.c | 21 +++++++++++----------
> > >   1 file changed, 11 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index f060c71965c0d..914399519cf54 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -5022,24 +5022,25 @@ void *mas_walk(struct ma_state *mas)
> > >   {
> > >   	void *entry;
> > > +	if (mas_is_none(mas) || mas_is_paused(mas))
> > if (mas_is_none(mas) || mas_is_paused(mas) || mas_is_ptr(mas))
> > > +		mas->node =3D MAS_START;
> >=20
> > Hi, Liam
> > There is an issue that it cannot pass the user space test program
> > with this patchset.
> > I tested it based on 47cba14ce6fc4(linux-next/master).
> >=20
> > The reason is that mas_walk() does not handle the state that mas is
> > root. The root cause is that mas_start() only handles the start state,
> > and returns NULL for the root state. When encountering the root state,
> > we can reset to start so that it is handled in mas_start().
>=20
> Thanks.  I'll have a look and adjust v3.

This was introduced with the fix for the race condition between v1 and
v2.

It is probably best to reset to MAS_START instead of the potential stale
data.


>=20
> >=20
> > log:
> > BUG at check_state_handling:3076 (1)
> > maple_tree(0x55d6a9838ca0) flags 1, height 0 root 0x1234500
> > 0: 0x1234500
> > Pass: 453406336 Run:453406337
> > maple: ../../../lib/test_maple_tree.c:3076: check_state_handling: Asser=
tion
> > `0' failed.
> > Aborted (core dumped)
> > >   retry:
> > >   	entry =3D mas_state_walk(mas);
> > > -	if (mas_is_start(mas))
> > > +	if (mas_is_start(mas)) {
> > >   		goto retry;
> > > -
> > > -	if (mas_is_ptr(mas)) {
> > > +	} else if (mas_is_none(mas)) {
> > > +		mas->index =3D 0;
> > > +		mas->last =3D ULONG_MAX;
> > > +	} else if (mas_is_ptr(mas)) {
> > >   		if (!mas->index) {
> > >   			mas->last =3D 0;
> > > -		} else {
> > > -			mas->index =3D 1;
> > > -			mas->last =3D ULONG_MAX;
> > > +			return entry;
> > >   		}
> > > -		return entry;
> > > -	}
> > > -	if (mas_is_none(mas)) {
> > > -		mas->index =3D 0;
> > > +		mas->index =3D 1;
> > >   		mas->last =3D ULONG_MAX;
> > > +		mas->node =3D MAS_NONE;
> > > +		return NULL;
> > >   	}
> > >   	return entry;
