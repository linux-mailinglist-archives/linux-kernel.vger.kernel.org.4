Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E049573BC50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjFWQEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjFWQEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:04:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9697C270E;
        Fri, 23 Jun 2023 09:04:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NF6G3O001391;
        Fri, 23 Jun 2023 16:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=uq88Nbx/OIKJc6YCr+2JGWlH4/KJ6GDw4sUMkNPR01Y=;
 b=XWuI/fkelvs/MQwIpjsxTycmp1KlFYWLBU88yC7CgB/zI06wmQr9pjEd5r1FbX6lVqdD
 C6m4gMp1lB0NdF+HAFtIDypHxSusKE4JsTh2s1jc+C+qThrqVL9snddr5NM5v+y907Tq
 HRx2IJzHqg+uvkWopdxkfdqPyBhvAzN7msjfHActB9IZa/wWCW+UgyCbnrQuqNHQ7cge
 MV8XKC3AdP5I0aWrkR+FHP58mXCXi22LpY7EeajIrH8DEp1XlbtX/VBlfzpWaws3oWMk
 Gj/b8FfbXZvXJGKXnexF6p1QUS0SsUhxY7QO2+spqeZhqjI+PRzcSsoIuxEIZoDmLhHX vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93e1mefk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 16:03:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35NEx2Bl031572;
        Fri, 23 Jun 2023 16:03:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdc20fmwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 16:03:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOIPGsk3RX/14kF9CpwN2V+jVY3Rl/7LrdBa5L2vm8hLs+72ou2CpPy6pjj4XMNePRthBFaL4vfD6/fBd++vQIvJOqht+Ig7cqYBJDWqzGMJbuG7BGQQVeITsFH5fOyLqCTjZ3RE2X1USZmBl+qwlKMsY5N0/U4DPY3oit4nBjELmF5jN2eceZn+45pQSrh0SkUycdDiDO4R3JYm3nkGV2rx9dhY3EbRAoO5Z1iXYLDNIDgKEHnxVMpq4jCFWKWiSg4MKNlhd1BsMr5UgmgH/axW8AhRhJ/4j+NmpM6K4xP6LtEzcofWVBs1BKCRkWWmTfm8mvZKquH1l2fa4mBUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uq88Nbx/OIKJc6YCr+2JGWlH4/KJ6GDw4sUMkNPR01Y=;
 b=X6IBttGTSCvQ3EFb8iutXH9EoH6qNSIvzm7DxkyP2Twa4MEEvNmRNSn/V4ppj0v/YKOx6qFYjgFHzEEa6Td1IIQ3l5ogu/V/OS7N8+jXl2aF0vym7cGlk8ayG9pMjRcGJX/bqi8ff6zCTzCCvMqNZ1+M8Yin088r8qSCOgZykU2nhdZu8Z9TpxHnmBQSp6LBj0rv6XmRzRepCT0hdET6d2CklhOJVa44YB6fWhXqDW+6fmbZqOB8Bc2KzdREVURAq6OB+fP0W1DDfJmHeJDb32qwDbszSCPCIM/vqVFli5fpb7THY3eUYX56fLvIfEdfcFNL2p6bkoIqLBXBEO7SFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uq88Nbx/OIKJc6YCr+2JGWlH4/KJ6GDw4sUMkNPR01Y=;
 b=FV1xd6UfLSyEAEXAqlVSPVfUvCOyzYiEpAvNLCLTHsqcQtF6gcJjivA0zDSrXy+L8cyBn3QyQiAx02TyQ3a760qxyOwZVKbL04D8rwM/c2UzGWSF1zGU8tDWXTEiYGHt31pMlvcRyZiGx2Z0SkpVoh6A0ZPUTUL1XhcxOSfEGLE=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA1PR10MB6590.namprd10.prod.outlook.com (2603:10b6:806:2bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Fri, 23 Jun
 2023 16:03:51 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 16:03:51 +0000
Message-ID: <27fd3750-7b9c-9638-26d8-0df3f0e33b81@oracle.com>
Date:   Fri, 23 Jun 2023 11:03:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v4 11/15] iscsi: Use sendmsg(MSG_SPLICE_PAGES)
 rather than sendpage
To:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Dimitri KRAVTCHUK <dimitri.kravtchuk@oracle.com>
References: <20230623114425.2150536-1-dhowells@redhat.com>
 <20230623114425.2150536-12-dhowells@redhat.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230623114425.2150536-12-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:8:2a::27) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA1PR10MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a2e467-7ed3-4a0b-9aec-08db74036fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNTV1O7xqYOpxmJ4g2BF8tXebs8N69VD1m8AydvbQsiN7mz5athYxoSGiACOCVagf6pp77uu5AnHX6gtwaomqZhvLUdokzBFTGhp45bu2ybUp0FimSBBQ67HPBqLeS6/MC8VZX9d9RjobGVpZnPHQenmZITwarZM6EwnFQKD5GokYKPs9WS5cUg2XzBhFl1aABmwDLIASsrOmyjtIiVIsUU4/77Yq55GFLyI4ZQER1E+wwJc+1+S5J/5JoCaVB6b73cu8UN/jdU2pJaGe/Z+SCMnsYPseWxDn/t4BvSFtvDPHGqW++zA+Ct1bZrHNZta5+Comt7NfjbFjEbvQ2Tq+W3qet54nCDn6/6HgyrPAv77mgzGPi6MMPXz+ypMjCcVulyzUC1xKBP2cvwsTZtRfL1pXvQtXHtAZu6U+a1kxGsSPkkgSm9VEthmgHshWElE4Hsyxmqzrga52NT052xMuflO/Fq2yzBrhh3f/wtxUDRBIavHkBIRn4nAWajMX14Zk3eCyfN/ESd/4gOYCSUnOIBA0lLZBthmOi2m/DuMNBRXJyB6tJ7bDImurEuJrqyktGtKKShFCnsgh77tRb5JRd//Mq6OXbZYkjxt0D0DCmIFuvxcnFc+lXzfznyODmdY3QK21ncgQY5rqMh5QpdK7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(6486002)(478600001)(83380400001)(86362001)(31696002)(107886003)(66556008)(54906003)(66946007)(38100700002)(316002)(66476007)(53546011)(26005)(6506007)(6512007)(186003)(2616005)(4326008)(31686004)(8676002)(5660300002)(2906002)(7416002)(8936002)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW41Z0RVVE02OGNzdWJ0OEo2Tk1sMU1Td3pEUUJ0UytFS3cxM09lOFFSem5n?=
 =?utf-8?B?Z2Jid0M2OEc3bFIzL0N0NGROUUVDdkc3bDBsY1EvblU1MXFDWHFGQmlwUCt2?=
 =?utf-8?B?b2tFcFkzYXVjL3FFNVEvWjJKWG1ORGRmNDd6M2RRMEtaUnBHdCsyWmlVU2lE?=
 =?utf-8?B?RTVlTUdscE8rWTNZZ3dXN0J0QjE2dHo4bjhKVVZmZVN6S2lITUZtbU1yczA2?=
 =?utf-8?B?Wmg4eWZITCtOT0h2SHpnSTFhZlhvbGMwektndUtFRllUVnFxQmhXVWVISW83?=
 =?utf-8?B?ZnRGU0l2L3N0dEhCcmJpcTdqalRBZGVuZC9sTFVpZURpays5ZzNWVnNmOGpU?=
 =?utf-8?B?NldZR0pncS8yZ08xR3pGN1IvdWY1M2UraGZDU2Jja21WMUNSM2NuUVZ4VW5Y?=
 =?utf-8?B?dDJHS3JtYS9BUXc0TDVJY2xMT3o1aEZzWUpzS2dTU0FlNWluN0czQi9tVEU4?=
 =?utf-8?B?OG1xSjgwY0lJR1kvblVGcFFyUDN3b3VWbW02ZDc1UG1LL3ovdEJFNEZxVkhP?=
 =?utf-8?B?d29rVXg4dm1BT2ZzTmloUWdHMDQyVEpUdEtJa3NYRXdYNUQwUmVMY3JscjNz?=
 =?utf-8?B?ZUhBZkhsNXJhdTVnd0RXZHpDN2F3VkFXRWVNU2hObkd0cVhSZUlVR3hoVENS?=
 =?utf-8?B?MDIwWGxYblVWS2NWRUQxTFJWbFB0emR2SEtBYk80U2o3aTZzS2NFOXVoTVhk?=
 =?utf-8?B?Y1hGNTlqcWt1ZVZhdnQ5TnJrbXE2MUJSTlhsRjNSWnpHM05FM21aNjIyaktL?=
 =?utf-8?B?Vm5KeEI0ekJjbkFMeVpnZUxHK09CTmg3UVFMcW1aMHZ0MnNRZXVScU5FY2Qx?=
 =?utf-8?B?QU9lNGRnK0w3bUczanIyMTg1Y2hrSWIvWU11ZGdSQlhtazdseTYzbkRrTG1P?=
 =?utf-8?B?elBpZ1Rja3VBVjhsMHNsS1luQ1Y0RzcxZ0ZPN2RJZ0N1cEZhdGhIN0J6YVNx?=
 =?utf-8?B?MlhmM0k0VkhCNTZER05MLzZybzFTMnk0MEFvYkRhSEN5MStSMmoyMUxRZWpn?=
 =?utf-8?B?MUhIRW1ndVpueEtneEdOMFJ6N01zVGZxS1Voalc1cnoyckdBcyszbFkySllq?=
 =?utf-8?B?TDk2UTRvOGxXbkdRVjJiTk9pdjJyaE5mOEZMd2NMQVFCT3dvQXhsUUs4OGRO?=
 =?utf-8?B?SGhwbXJJUENmZDNQT3VrN3NCOTFqbTlSSFZQUWZpTExNandJNEZOTlErQm9K?=
 =?utf-8?B?bFdXa2pvU3Q1K0xRSDJJamZQNFhUblhIZmw2ZGNIeGVhU3dFUXZiTlZJRHNH?=
 =?utf-8?B?U0xzQkh5QmsyUThEbFM2aVBya0dNMXh2MXJ6MHN5WFY0TE4wbWg5dHVsdXdo?=
 =?utf-8?B?WU1GVHdaZlcvbU5mNVpoczZqOERGb0RMbGQ1azRDdWM3aHA2a1NjWHc0Snd5?=
 =?utf-8?B?SGUzdWNpVm5hc29BOHdlUDBDeGV6VGtGVllQbkFibFZFREdMdEVrWmpNOE9Q?=
 =?utf-8?B?dE1ieUNTa0Y3anRhOFBWemFKV1AybVp5YUl4NXN6UlFkVVZLUkF6QUJPcWQx?=
 =?utf-8?B?K1hKNk8xcGl0NlcxUlB2Zk45QlVqeWd6T1daYXJveUd6SDBUdEhTcFVqMENU?=
 =?utf-8?B?aVVlR0pkZHJlTFVPdGo2RVpsOWJPdE1rN2dHekQ5aTBpRlNiRkRCbHFPSHFh?=
 =?utf-8?B?Sis0ZmZvOHBkRWxuTGRYMytVeW1ZSkVuWGswaWlBd0pMSzA1Umxaa1dQMWZj?=
 =?utf-8?B?ajN6K0tsRjM0cTFORmNwbjdOb3lhNnhRVkFBalE2UVVLR0pmVkFaYkN1ZEFz?=
 =?utf-8?B?NnJrWENHSy80WktMYkFwZlhkZkQvSU5IWVg2KzRDVTdJa01wQlVEL0puUWZG?=
 =?utf-8?B?cDFzYzFoTkU1WG9pb1hYa01Rckp4SkE3dG51SGoyNUMwZkVyQjh0eWtpNmhQ?=
 =?utf-8?B?UjdhZGllcEwyM1gxMWpLU0djdkp0L2liSytzY25oVTdFZnd0cEx6RTFnZWpF?=
 =?utf-8?B?Q1R6YnJHdWdBM3E5MzhFbXFIcW9aaUE1aWM4dUI0ODhReWVSTWxBOWFOTXBr?=
 =?utf-8?B?WXBJSDBYMHd1emdRMHNVb0I4TVJvSnVzajJROVJLSHVzWmRsNkZIUmxDcjlr?=
 =?utf-8?B?eDMzVCsxc2lTcFhpd3BlNXRVeVdZdUNoNkRrTllOZ0NnYldMYnNzdVlOZEdy?=
 =?utf-8?B?c3QwM2xmVUF0SjhWV0dsRmp4Z2lpVHNvbkR4dTZyY3hMcUptN1AzTDl0d29w?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U0NYV284V3N4TWV1VWsrcDd2S3FaOU9pRWViMXpMaSttZ244VkZVSzRkS0dv?=
 =?utf-8?B?WXdsZTFqSXVTS254d1dPVi9PK0VSOUhYWEJtZ2NCSHg0akVFcG9qTURadk9U?=
 =?utf-8?B?Z0lROG9yYWJYUDJBTWdaWEFVb2VqYmVGNE1VczJGOVJUcWdYaHR1YWxycGtq?=
 =?utf-8?B?c1A2NzRSTVczOVB0N1kxZ0hsVWJJRENrNXBjTlN3bXV4a3M1eDBwbnhIWEo4?=
 =?utf-8?B?WjByTnNJNDlRT2x0RldrMmgzRUtWSGI2R21TeXlrUzNkMWJtcTMveVRPWktn?=
 =?utf-8?B?MmZrM1F6Tmg1UTZtdzhram81Mi8vMi9udGJrT0t0RHNhSWorUlFabWs0Qjlx?=
 =?utf-8?B?cnV5RExTWkxZbXhubGVhUDlScWEzOHdFRzZuQUNoUEhPVXowZ3ZVSTZCZ0lF?=
 =?utf-8?B?NTFVQlNUc1NCc2hHQjhDMmFVTWt4Uk5GaVhBNWNPNjZzN1ZESmJlWk9lbXJS?=
 =?utf-8?B?TXAyczBnbmFYbDBlV28vZnF4TnU1RWdFNEVBTDRPakpmQ1EwWC9vckhNVzBa?=
 =?utf-8?B?RTJvbkpHR2RvK054ZjM1bEczRngyREhRdXJxYytKMUlSRllzdEptd2ZEKy9J?=
 =?utf-8?B?OTZOSjA5QkUyYVd0QzJnRDdnZFV3OHA0OW5VWm15bGhDU0VDdndaV3F5VE1U?=
 =?utf-8?B?ZUpncENMM0UxVUNUM3p6QWx4c082UWhRRlM5eHJ1UllQemZGVnJRLy8yRXJW?=
 =?utf-8?B?SEs5Tno4YVAveTFpZG5GaWZjL2oxSkcwbVNmSno2M1VKTWcxYWdVaEFkSTVa?=
 =?utf-8?B?K2lMVEhuK3NNSTNnZmNJZEdwMlE5UHBjNmlHbHJmYmRKM3dhUnRJWm04T3Vk?=
 =?utf-8?B?ZGN2MmRYT0pVVEhQRTlCVjRQTlZaKzZiTHFldDN2T01lbktsZEFPL21NYUhV?=
 =?utf-8?B?ZVFEUWtBcnNSL0Z4MUNaYXRCb1VsNzdRZU44aDZmNnY5VENZZkMvSlhwVVh0?=
 =?utf-8?B?UFY5UWZFQWU2ZHJCR0FJZDZRR0R4aS9pcm9MWnhwTGttaDgxSnpyVlFGV3pm?=
 =?utf-8?B?TjNhUjMzblZsN216WVFJeWttL1dZOGNHRGo3cURRaTBMdmo3WDEvaFJhRS94?=
 =?utf-8?B?Vm1nOC9SOGVraE9OQURYdWlqUUtBVy9qdWNCeGUvTFRLNnBMSDZkdkY5eEFI?=
 =?utf-8?B?dXdvMWovSjNuTHR4Sm5lUkhySWo1MkN4MGxJcmdjN2lnT2UvT0lIb0pITDVv?=
 =?utf-8?B?MHBNNHhFTkJtRGhDWXRPRG02bU4wRTAwN3lBc0xJNzd6a2NWTzJidzRJdlFp?=
 =?utf-8?B?T3Yxd240VHBDNFpoWUdkakFTdmdVM2lPUnYwTmhaQ3VhWklsRmpNc0hPaWZx?=
 =?utf-8?B?QzVGZHVSMERGRnNTTHh3YXpNU0c4d2Q5QW9yNmVMMHpzWTFCWGErZUZqb09H?=
 =?utf-8?B?eG1HNFR4UnJTT1E2b2FlaG5WNmhlSGE2QW9ySzRscExaQ2g5WE5PRDRFUUhl?=
 =?utf-8?B?OHMvYkU2a1dEbFFmeXdCd0F1ZUdlS0ZuWi9HVzVtOU5qSTNES0g1WnVnZjlw?=
 =?utf-8?B?ejQ3VkF4dkZGd1d5L3RINXNYOUkyU1FqdHF6RzdYM3hSbGp4T1E4RmFzbkR0?=
 =?utf-8?B?R1VIZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a2e467-7ed3-4a0b-9aec-08db74036fec
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 16:03:51.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCvb3BIiEE6gWYQdE6Ux/1XBUEezYIvhIbE1v7HtGwp2ONCt/ke0w2b1KYDYLN5H306KvwmbuIwTJfb0j6REX6ky4fPwUaD+QhGboNUzzw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230143
X-Proofpoint-GUID: P5WB4_JcGiKRhUU-lMZU5u4eJsaw_OcP
X-Proofpoint-ORIG-GUID: P5WB4_JcGiKRhUU-lMZU5u4eJsaw_OcP
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/23 6:44 AM, David Howells wrote:
> Use sendmsg() with MSG_SPLICE_PAGES rather than sendpage.  This allows
> multiple pages and multipage folios to be passed through.
> 
> TODO: iscsit_fe_sendpage_sg() should perhaps set up a bio_vec array for the
> entire set of pages it's going to transfer plus two for the header and
> trailer and page fragments to hold the header and trailer - and then call
> sendmsg once for the entire message.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Lee Duncan <lduncan@suse.com>
> cc: Chris Leech <cleech@redhat.com>
> cc: Mike Christie <michael.christie@oracle.com>
> cc: Maurizio Lombardi <mlombard@redhat.com>
> cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: open-iscsi@googlegroups.com
> cc: linux-scsi@vger.kernel.org
> cc: target-devel@vger.kernel.org
> cc: netdev@vger.kernel.org
> ---
> 
> Notes:
>     ver #2)
>      - Wrap lines at 80.
> 
>  drivers/scsi/iscsi_tcp.c                 | 26 +++++++++---------------
>  drivers/scsi/iscsi_tcp.h                 |  2 --
>  drivers/target/iscsi/iscsi_target_util.c | 15 ++++++++------

When you send this again can you split it into 2 patches?

drivers/scsi/iscsi_tcp.* is one driver. It's similar to a NFS client and
it has a set of maintainers that you saw in the MAINTAINER file.

drivers/target/iscsi/iscsi_target_util.c is another driver which is similar
to a NFS server. Martin is the overall maintainer but it's a group effort
to review patches.

I've tested and reviewed the iscsi_tcp parts. You can add my:

Reviewed-by: Mike Christie <michael.christie@oracle.com>

For the iscsi_target_util.c part, I'm reviewing it now and hoping Maurizio
and/or Dimitry might review as well.

One question on the target part I had is about the TODO above. Is that
something you were going to do, or is it something you are asking the target
people to do?
