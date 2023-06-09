Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6D172A373
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjFITxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjFITx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:53:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373E91730
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:53:26 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359I8KO1014614;
        Fri, 9 Jun 2023 19:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aITBQ17I0zqZBNc3wochm3jRnZ5L8RCos62Epte3dAs=;
 b=mMtR2WDc0/vU8BHEUGcd6v+4Roz7GYs9ymEG7p1Y9Tc97G362QNyoOttrAsNXDkr4Ydh
 dN7ryZQQUSuT5Fk1iUsYrDXQxGPtHncP6oEx87v2AX7Rif8RJnCTttHolv/cpXgkXTDc
 miGrWQLvZCgm0g/BFTmiwtOO+ntSlZ7CZRTIFMSlGXuuvcsicDxq6kVfJDL/GWNxrTXt
 hLHyWspXFfWq6EHLOciJ67rgKI55t5vpVFZdGXULNF6q+R3t8840GRoxJK4vOy9eT/Rf
 O8wdsnSpkKhMUx7awWF67l9ldBMwU6kRZTFKmn5MXsxtARmMmsKF500O+jyM1Py0Xx2J qg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u7fww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 19:53:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 359J6B6x015981;
        Fri, 9 Jun 2023 19:53:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6ptxgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 19:53:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIVK/MD+vdBG4iu8C8M2s0bN7GySbNT1N8jHy4oCd/9nFugbQI4UJ2hYExNbphKNUwuhovOjGcGvo7FtoDE3SZ959SUz+IIl5/iQh7QMbro0UbZ0RdjAwFBHypOlC89hLB4UaOfeeckx4bIH22hqxPo+CvVPIWtjZE5Kce/7IQylES7QcSGRiwXv3lWCYohg6+3eOKsnaokjL8if0ce9554erEn+zOhsb43pFu9DyvSZDcZH+lI/lHrfsddxZGwlH50wS6bq4WDOgxeJQ6chuO/lQo6Tvvo3R6xVFycIVnonSCpGwee7l3Aoym0hBb4EzFCX6bVHLKS6DXk5tAR90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aITBQ17I0zqZBNc3wochm3jRnZ5L8RCos62Epte3dAs=;
 b=IdZB3tA+DWNgnUw2G5WLHuStHWYVrL1RvYs/+4bWbeuQ0ex5LSzny7kzr8cIPifrKn2FYBTj5YHVXBxbUK6GEcek61zBQJlZoZa+McskLBvPgX7WHp6yZaVKSfzJTLylVKWtJaJmOs+XHzEqRhojRSaXMuJfs31m7Yq9eNCPI7ZDlp8vaF9SNKHLDLsNMx4zAjC+Znwu2AHDWXdd3vUCOk+Ee5+aIUotAnm6liVjPEkq6hJ0EQbrh27EowdfOFwWx8EZoUdDY9QDu/SYunNc1mBEIfLqYqcm5HV4oACmr5ftPNejhBrZVJw+xL6lZdVL1/+ZxR+IQpXXowN3elJyEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aITBQ17I0zqZBNc3wochm3jRnZ5L8RCos62Epte3dAs=;
 b=gFo/UGON75KMnI54Qh+Fp02AIZeRpfbBvoUaaSVWv2+cQmGPdcQ3qWUj+y2okurd8bI/b9DZvEPYpg123K7APCF3CIKwp0T3StjLty8DKxD+FGaR0oONc1mow4mf/56vEPe27l+QqjkClmlmn+TEErjPaheUaNTpAu1wmkEiDpY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB5546.namprd10.prod.outlook.com (2603:10b6:510:d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 19:53:01 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 19:53:01 +0000
Message-ID: <b3faab36-370c-1635-3ccf-33d51f53859c@oracle.com>
Date:   Fri, 9 Jun 2023 12:52:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] mm/hugetlb: add wrapper functions for interactions
 with page cache
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, david@redhat.com,
        nphamcs@gmail.com, jthoughton@google.com
References: <20230609194947.37196-1-sidhartha.kumar@oracle.com>
 <20230609194947.37196-3-sidhartha.kumar@oracle.com>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230609194947.37196-3-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:a03:54::37) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB5546:EE_
X-MS-Office365-Filtering-Correlation-Id: 9173e5e3-40da-48f2-b48d-08db69232187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLyq1PjXZmgmQaYZAsZA89a24nwt1cJqIhxg51Ksk04lVwplA8iGye3ZrBx5Fbe+Xyvk0QH/g8gyR+Q5G/4NM4ra7qgWC/7Q6iJIraRWq4Y5DkG9Zc9Mwz7Z6RPtKNxiaWqzsd3AVZwLaEuKyHr/blvlnjh3gijCFYNVvC2kpXYSEiboCSh7nkSCOdOug5IqHlSdjWM/MojCIf/9lOD2tvQTbZwxQSkmgTSGGdEAT2UHLAxzRSksNX0McsFTloS/m8zQHKK9vBOrySJgQOpAvwcDQGDjWsWVwrUSRSdy14RNe/DMg0oan9gF3I+NPtltYkoBq6u2DANb2Yb42DRF4S23Ng0rnHg/A/4bF19fyXtyj5p4Tq24MqLD5ulGl/7NRmcVtf6yLel5wKj9AfumixdKtR3+6PeGfWGXz5u5SYtqD6KYXbo+KORcLlBXThil928hDLDG1/6sdI2SiqsF0Q0pBB2uITh+a3E52dQXjIlR3HPhUoNvhVNVDld/smgFUIGi/R1bPzQlnSZQ5eW3vXtn5tzjfjrE94zHBuOu/TUCS73rRnubDRhqN9i85MLQ1aBv/iYiYNHNPkFNTeYSU+iGUGCv1JZPpx/i7H87KGqNP6wlv6ZGRMMzecWTrZib/e18BV72aBhSU7yOQqCyag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199021)(36756003)(66899021)(2906002)(31696002)(478600001)(86362001)(38100700002)(41300700001)(8676002)(5660300002)(8936002)(44832011)(66476007)(4326008)(66556008)(66946007)(83380400001)(31686004)(6506007)(6512007)(2616005)(53546011)(186003)(316002)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVFR2lkUEgxa3VJYkRTVjZlbEZFYVFWT1pLMklKa09RZDVpU0YySEdRMlBL?=
 =?utf-8?B?b3lBTlYwTlhRTFV6aDE0SitXNmlnNk1SOUMvNU9vMjhoZ2F4NThYYVN6YmxF?=
 =?utf-8?B?L2I2K2lQR0JEazIxamg5Ynk1ZWRzUm4xTWpUM0p5QUgwN3puY0dhUENhdVAy?=
 =?utf-8?B?RExzN2s3MmFlTUJ1eXM0a0d5WkxuWmxBdmFmaHNvVG5jQzAwNE9EUVBLWWh2?=
 =?utf-8?B?WEEvVDZta3dFbm8vaGIrcDk4alhTMUEvNks2NUpwUzM2V2dvbzBCbExNZUoz?=
 =?utf-8?B?OVRieHdHSlFsRXNoK3VwWm0reExQaUZxQzV3QmYxSEpOcGhYTnRzeU55NjNJ?=
 =?utf-8?B?eTh6SGp2amFWdlVLVURDd0hSR1pnQ2EzVGlRN3NsbVVpeis3T3lxK2JOdTd0?=
 =?utf-8?B?dzNNUzlCR1lUV2cvRi9FRGhLYkZLc1FDbWNhTkMrUHJNQjVPU3M2a2REdk8r?=
 =?utf-8?B?aTFDdG9JYnZ2UkErYml6eVQzVmhXcjVJU3Nnb0ZtenhnbjZQdFNheTROK1dN?=
 =?utf-8?B?VFc5a0NFNWNwNTE2Z1FLTGJkYUpOZTR2ZlR4cXdBRUdVUUtiQWkwZloxRnho?=
 =?utf-8?B?eWlWb29vWmY4d3FHelVURzN6NEI0U0FoMFVRMXlxd29ia3IwUXZtVE1uZHV1?=
 =?utf-8?B?WWVvNk5ieUg1TlFGdW43ZlJSb0YwdGF4UjZWUGJ6bzhxNDJiMTA4RzVDN1ZV?=
 =?utf-8?B?bkN4WkluMURCYTFxREIvelVKRk50VUVUcEN4cFcxaU9yQjZIUkxISkVrMDdE?=
 =?utf-8?B?elY1RzZlU05obkZzTGtDWmVlcnE3RG1wNWFGVkJqeFB5d0ZCTXVDYVZCaDlu?=
 =?utf-8?B?N24wdTdEeTNkQWY4b2QvZWdWUUZza0ovL0lobDRlSVduTXRaNnFaUTJmRDhH?=
 =?utf-8?B?b1dxT2Vka2tlblJNa0krU09id3czbXhDWmw1WWxHRVgyejd6RDdhR3NRQ0s3?=
 =?utf-8?B?TDVJL0xtcnpQSU1taFBYN0RCam9vMGg5MExhMUI2b3hXV3VsNCtaTzNwbFk1?=
 =?utf-8?B?WFJQdHZUMFRvOW9WN0gzc3ZOQ20rQ3ZzUGp2dXpLR2d3UHlxdjd3bDNyTWxz?=
 =?utf-8?B?aFl2UkxiTkY1MVFvcWxQYXFTeFNQeU5RSjRkWVV6MkFHZTFieUpIc2VCeE1n?=
 =?utf-8?B?WmpVc2VjSm1QRFRyc0VMMG9HSG5sZVpya1NNcWoycm1aek12K2wrYURmN25v?=
 =?utf-8?B?Uzd2NkdiYU5RT0VPcW5UTktnckdRNStYeC9PcVNyaHRaSTRIZkpqRWg4Z3JR?=
 =?utf-8?B?Nlg2bjNSUkFrOEpyK1IxSVEvUGxjNkU3NkxKdlNHMzVKeDA0b2YvM0RXTFFm?=
 =?utf-8?B?YVMzSXhSbVQ1YVhUcTRoOG9mR2QzbWVOWGZRbWQ1MVAySGlHNmlEVGJEZVkz?=
 =?utf-8?B?aEwvbzRqWUxTSE1ob3RGelp6NkxVamlzZ0x2QXgzb2JzM3FXMlo4UmZFM1lW?=
 =?utf-8?B?YnpzeWo1QlNzaWI4RFYwcHFyczhhOGZHZzJITXk2WE9YVy9sMVBXMFlCK1Mv?=
 =?utf-8?B?TUhYaDViODlWV3F3dDVqc0plRmkzY1IwMmpaM3hDV3crcnZLckNpaHgrNVJh?=
 =?utf-8?B?ME5ac3QzYmtyTC9zbzNKYVB4MGE2aGJ1WFVRWlFMTUJpVHNWdTF0a3lRTXBp?=
 =?utf-8?B?RzRiTW9GSUF4VllZSk8wbFArSlZLNWpyRXpYbEJ2T1dMdUpRdzBXU0hJMHhX?=
 =?utf-8?B?b2p4Y1lNc2tPVVkwYzR3Q3NINjNlOWdsbDlkclpDNWgwc0VCZ3lIK0RxemxC?=
 =?utf-8?B?QU1JZzBoV3o1Y2wzcFVnVkVxRXZvb3hzdi84VDJJRG0yZnhibDFmQ2htRnUy?=
 =?utf-8?B?UURUK0h6NVUvRlVRejBFYWRmQ0xqN3J5U2duUVU1M0M3SUZOWU1RYjRtUWo0?=
 =?utf-8?B?ZUpibjlzVXkxcnkwckE2eVVxREZLS3FTNEtmV0w5R1lsTTJMMk8xVFdzQk84?=
 =?utf-8?B?OWI1cFFHMzI5aWxyQlpFTThvZzk0aUQySENwTlpKQW9SdnVlNm90WlFUQWhE?=
 =?utf-8?B?blQwQnBoQ0xCWGpDSFpHNDFWeHNmdHhEMnZvbTFWTkZDMmM2eE11d1hIeGhv?=
 =?utf-8?B?elJ2TzlpbzRVcmczQUxoOS8xT3NCa2RUSjFZeXd4M01nWXVIVjU2Y1lXd1Bh?=
 =?utf-8?B?OFB5NTVTOENjcHZGWEpVbjcwaWdNZWxwOVlSOTdEaUVpK0pEMytkRUJZdzlP?=
 =?utf-8?Q?z5MDE6eaWRkJmIfbzMWLMwo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ektOZnQ2SDc0WkQzVkJCTzBWYXhTMTRHRFJ4dVVjYWJjVUZudlRjTGpqRGlv?=
 =?utf-8?B?eGkyb0dJSTVERkNPcEFLRnRNbjNzQXdvWWZ2M2dSeS8zSUtsdVdGZjRuOHR1?=
 =?utf-8?B?bk91eW4xNmI2RnJPNXRubTZTNVE1NUFPbXJtZDdIRytUL1M2UTF4b0JLQkRZ?=
 =?utf-8?B?K3lRd05NdmhWMXR2bmdXWHZJdHUzOG1SaW9LSWhSbnVNaDBRUW8wR2MydFFu?=
 =?utf-8?B?Mm9QVnY5aDFiTU9ubEk3NGdvYnRpT2h2bGNJZng4VjB3SHI1NGlXNEJ6SnJC?=
 =?utf-8?B?UW5SM0ExbWZZUDJYWXBUcG1rOU5BdGMyQnlYYjUrRlM0MUxWNmViNlNFdGxV?=
 =?utf-8?B?QU9rMHppZzNvcU1xZnhIQnJSejFVejlITzJULy9YSXdUZlZRYnNMbHp6N0hu?=
 =?utf-8?B?aDBRNnNjMDV6RmFCMXJ0STYrUUpSbUxxZXNXUjFVbFJJRlFVdnRYMThZbXhV?=
 =?utf-8?B?bzNXWGtHM1lIdWV3OGdOZEtlc3hzakJRVWVDajdDWFBMTTAxZUN2RGwyL0tG?=
 =?utf-8?B?cVZuaG8xWWlSVGs3eEc2VDl1aUEveWpvZnRSdUV1endsbEllYWhxUzdhQjUw?=
 =?utf-8?B?TitWU2gyY0phc0F1SXNDaG9aRUNOSnRlVjRZNkJQRy95dW5TRlR3VnV6K2xO?=
 =?utf-8?B?OEREMmVaaU5QdjM0Vk94L1RaWjBTZS9hT0RPWWJRa3N5UlFhMTg0QnBvTVds?=
 =?utf-8?B?eTE1ZHk2NEUrV2hhZDBGQm5DaFRwdDVGMHQyWDBHRnJIVDhGWVBhbmp5Q3Uz?=
 =?utf-8?B?WlhrdWhxU2lzd2J2Y3FPRnNETFJXTVprQ3pXK1JDL0FsOStVWEJMY05mc3RE?=
 =?utf-8?B?U29xUUdOTXg0cjBXbHk2bWt4Q0VMWE9WQm5YdjhPaVlkUW5xSFRHdTlpVHJ3?=
 =?utf-8?B?bTZGS3p2OHBjRDl4cXc1UE9RY0g3MEMvMXgyemROUUNlUFdHbWdjT3hrcmgy?=
 =?utf-8?B?TXNlaG95eXhJdWJJMHRFMXRyRFlJMFRlTHZkQ2lHWDVrUWE0c0swcksxb3ZP?=
 =?utf-8?B?VUhJUm8yRkxQWmVIMGZCazkxZmFKaGZlQTVES2FNUERQL3ZubEN3blU1Qnpr?=
 =?utf-8?B?VE5ESHM1K1RJT05EanV6TzMwZENUc3VVbjVGcTFLTEFmbWNHdCtMdGl2anpu?=
 =?utf-8?B?UUwxT3JSeUgxcEpRM0s5L3gzbEJEc1VIcE84OHlzZk5xUjEvVG5TOGlwS0ph?=
 =?utf-8?B?UXljcXlZWWF6VXpVVVRJeTlKbll4cnBPWDZ1NkJDeWJ2VjZrT3MyL2xtNlFC?=
 =?utf-8?B?WmROcFB2UlI4SXMvcGJ5VDZneFkyMTNtYnByaHo0OGpFUkZyU1N5dFNROXdo?=
 =?utf-8?Q?z05sSevKX2unF97HZU9HufA0/7PjmA++zg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9173e5e3-40da-48f2-b48d-08db69232187
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 19:53:01.1436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9X5xe/gYfgXICU8gRXFA8BznFSI6SEs3aswE2IjgP5YzlDmP7wUahF208/srdThQtd4vscPLgcrmOtqscLUV2ieaH+8s2/KVugs+rzsVxbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5546
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_14,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090166
X-Proofpoint-GUID: _0U4aod0AAOEcdUASFmq-IfQOeGiDBqz
X-Proofpoint-ORIG-GUID: _0U4aod0AAOEcdUASFmq-IfQOeGiDBqz
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/23 12:49 PM, Sidhartha Kumar wrote:
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Sorry, I missed adding the commit message to this. It should be:

Add filemap_lock_hugetlb_folio() which is wraps __filemap_get_folio()
and passes in a linear page index. hugetlb_add_to_page_cache() is modified
to also compute a linear page index before calling into page cache code.

linear_page_index() is modified to perform the computation on hugetlb
so we can use it in the page cache wrappers.

> ---
>   fs/hugetlbfs/inode.c    | 14 +++++++-------
>   include/linux/hugetlb.h | 21 +++++++++++++++++++--
>   include/linux/pagemap.h |  2 --
>   mm/hugetlb.c            | 22 +++++++++++++---------
>   4 files changed, 39 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 90361a922cec7..90d27a8af4b6a 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -617,20 +617,19 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>   	struct hstate *h = hstate_inode(inode);
>   	struct address_space *mapping = &inode->i_data;
>   	const pgoff_t start = lstart >> huge_page_shift(h);
> -	const pgoff_t end = lend >> huge_page_shift(h);
>   	struct folio_batch fbatch;
>   	pgoff_t next, index;
>   	int i, freed = 0;
>   	bool truncate_op = (lend == LLONG_MAX);
>   
>   	folio_batch_init(&fbatch);
> -	next = start;
> -	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
> +	next = lstart;
> +	while (filemap_get_folios(mapping, &next, lend - 1, &fbatch)) {
>   		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
>   			struct folio *folio = fbatch.folios[i];
>   			u32 hash = 0;
>   
> -			index = folio->index;
> +			index = (folio->index) >> huge_page_shift(h);
>   			hash = hugetlb_fault_mutex_hash(mapping, index);
>   			mutex_lock(&hugetlb_fault_mutex_table[hash]);
>   
> @@ -693,10 +692,11 @@ static void hugetlbfs_zero_partial_page(struct hstate *h,
>   					loff_t start,
>   					loff_t end)
>   {
> -	pgoff_t idx = start >> huge_page_shift(h);
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma = find_vma(mm, start);
>   	struct folio *folio;
>   
> -	folio = filemap_lock_folio(mapping, idx);
> +	folio = filemap_lock_hugetlb_folio(vma, start);
>   	if (IS_ERR(folio))
>   		return;
>   
> @@ -868,7 +868,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>   		}
>   		clear_huge_page(&folio->page, addr, pages_per_huge_page(h));
>   		__folio_mark_uptodate(folio);
> -		error = hugetlb_add_to_page_cache(folio, mapping, index);
> +		error = hugetlb_add_to_page_cache(folio, &pseudo_vma, mapping, addr);
>   		if (unlikely(error)) {
>   			restore_reserve_on_error(h, &pseudo_vma, addr, folio);
>   			folio_put(folio);
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 21f942025fecd..55f90e051b7a2 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -727,8 +727,8 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
>   				nodemask_t *nmask, gfp_t gfp_mask);
>   struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
>   				unsigned long address);
> -int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
> -			pgoff_t idx);
> +int hugetlb_add_to_page_cache(struct folio *folio, struct vm_area_struct *vma,
> +				struct address_space *mapping, unsigned long address);
>   void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
>   				unsigned long address, struct folio *folio);
>   
> @@ -755,6 +755,16 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
>   	return folio->_hugetlb_subpool;
>   }
>   
> +/* Wrapper function for __filemap_get_folio*/
> +static inline struct folio *filemap_lock_hugetlb_folio(struct vm_area_struct *vma,
> +						unsigned long address)
> +{
> +	struct address_space *mapping = vma->vm_file->f_mapping;
> +
> +	pgoff_t idx = linear_page_index(vma, address);
> +	return __filemap_get_folio(mapping, idx, FGP_LOCK, 0);
> +}
> +
>   static inline void hugetlb_set_folio_subpool(struct folio *folio,
>   					struct hugepage_subpool *subpool)
>   {
> @@ -1021,6 +1031,13 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
>   	return NULL;
>   }
>   
> +/* Wrapper function for __filemap_get_folio*/
> +static inline struct folio *filemap_lock_hugetlb_folio(struct vm_area_struct *vma,
> +						unsigned long address)
> +{
> +	return NULL;
> +}
> +
>   static inline int isolate_or_dissolve_huge_page(struct page *page,
>   						struct list_head *list)
>   {
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 17c414fc2136e..ae8f36966d7b3 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -860,8 +860,6 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
>   					unsigned long address)
>   {
>   	pgoff_t pgoff;
> -	if (unlikely(is_vm_hugetlb_page(vma)))
> -		return linear_hugepage_index(vma, address);
>   	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
>   	pgoff += vma->vm_pgoff;
>   	return pgoff;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index dfa412d8cb300..824d6d215a161 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -951,7 +951,7 @@ static long region_count(struct resv_map *resv, long f, long t)
>   
>   /*
>    * Convert the address within this vma to the page offset within
> - * the mapping, in pagecache page units; huge pages here.
> + * the mapping, in huge page units here.
>    */
>   static pgoff_t vma_hugecache_offset(struct hstate *h,
>   			struct vm_area_struct *vma, unsigned long address)
> @@ -5730,7 +5730,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
>   			struct vm_area_struct *vma, unsigned long address)
>   {
>   	struct address_space *mapping = vma->vm_file->f_mapping;
> -	pgoff_t idx = vma_hugecache_offset(h, vma, address);
> +	pgoff_t idx = linear_page_index(vma, address);
>   	bool present;
>   
>   	rcu_read_lock();
> @@ -5740,13 +5740,16 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
>   	return present;
>   }
>   
> -int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
> -			   pgoff_t idx)
> +int hugetlb_add_to_page_cache(struct folio *folio,
> +			struct vm_area_struct *vma,
> +			struct address_space *mapping,
> +			unsigned long address)
>   {
>   	struct inode *inode = mapping->host;
>   	struct hstate *h = hstate_inode(inode);
>   	int err;
>   
> +	pgoff_t idx = linear_page_index(vma, address);
>   	__folio_set_locked(folio);
>   	err = __filemap_add_folio(mapping, folio, idx, GFP_KERNEL, NULL);
>   
> @@ -5854,7 +5857,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>   	 * before we get page_table_lock.
>   	 */
>   	new_folio = false;
> -	folio = filemap_lock_folio(mapping, idx);
> +
> +	folio = filemap_lock_hugetlb_folio(vma, address);
>   	if (IS_ERR(folio)) {
>   		size = i_size_read(mapping->host) >> huge_page_shift(h);
>   		if (idx >= size)
> @@ -5913,7 +5917,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>   		new_folio = true;
>   
>   		if (vma->vm_flags & VM_MAYSHARE) {
> -			int err = hugetlb_add_to_page_cache(folio, mapping, idx);
> +			int err = hugetlb_add_to_page_cache(folio, vma, mapping, address);
>   			if (err) {
>   				/*
>   				 * err can't be -EEXIST which implies someone
> @@ -6145,7 +6149,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   		/* Just decrements count, does not deallocate */
>   		vma_end_reservation(h, vma, haddr);
>   
> -		pagecache_folio = filemap_lock_folio(mapping, idx);
> +		pagecache_folio = filemap_lock_hugetlb_folio(vma, address);
>   		if (IS_ERR(pagecache_folio))
>   			pagecache_folio = NULL;
>   	}
> @@ -6258,7 +6262,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>   
>   	if (is_continue) {
>   		ret = -EFAULT;
> -		folio = filemap_lock_folio(mapping, idx);
> +		folio = filemap_lock_hugetlb_folio(dst_vma, dst_addr);
>   		if (IS_ERR(folio))
>   			goto out;
>   		folio_in_pagecache = true;
> @@ -6350,7 +6354,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>   		 * hugetlb_fault_mutex_table that here must be hold by
>   		 * the caller.
>   		 */
> -		ret = hugetlb_add_to_page_cache(folio, mapping, idx);
> +		ret = hugetlb_add_to_page_cache(folio, dst_vma, mapping, dst_addr);
>   		if (ret)
>   			goto out_release_nounlock;
>   		folio_in_pagecache = true;

