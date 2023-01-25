Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802E067B7E1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbjAYRHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbjAYRG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:06:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F58F5AB56
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:06:33 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PFNj4w009521;
        Wed, 25 Jan 2023 17:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=k9Ou4eNZgNrqDC9CsktHGFmSHUS05/MDzuaI34nkS94=;
 b=kU9vQjFJ/qQYUDydbc6I8CvCgLX7PqEGdEh7pRKCxujMa6evhS3tAo4xqsx/vBkC47sN
 /uh8k96hVPKH3r/4gWXtInBJl2R46Zdo6YkqPDrO4vhEBiwfFnUyU/GtF8PGS/yf/utP
 rWxnF/72amaeB6tbF97J1ffhl4f4uDx3AulR34a9JLOfvS9dkmU7vVAg5YGc7MJuGeKb
 IF2nUW28UHDeUHfVlnxudJ/IMGKQsEQ/vUMYML/2HCon52h4m2JFQ7VAjgV9ca6G12ll
 3gdlcKjx0G26kP9MQyxa9kRTCBP/lvuDXgIyB51M/vaCOSIIiWJZoT4RbYgJ/B3XjsRu yQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n883c8jf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:06:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30PGGDHC019163;
        Wed, 25 Jan 2023 17:06:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gd5hn4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:06:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5D9QgTaoza/JRC/q9nOHq7vBJEeNn+PeQGQawEeFd8yBPuzsBZN01F+pMHImXtkgHIzlJz6HaWDPGIxa5KumVPaqHDJ/GFnEef06OTEPKdsAJ/PsFuQwujtSHMGCvVz4m+J0PIXjbG+Z3Z435Pz/BhW49FSnsRKn3HYzOEeeC6lAcp+ujsELD+slaaqZM9jtP5INuVhTKAkSoLvriYnsVY+CCeyDCWqcW7GuYYpxOPTlk28zkzLo2bHF35vJGYgESByDBdFzQ09a6ERfBPmGH0/YFEJahyRSJyJwnfHdiJDFz63XVztw4UZgHinPZJ2iNLpLTd3qIrmnGt+PEl0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9Ou4eNZgNrqDC9CsktHGFmSHUS05/MDzuaI34nkS94=;
 b=Uel6goyUaSBdF0FXFip4MAC4n4Z12kD1a4vxiFVr1HkARi792VPYdv4F1QJqsp9/0kMfzR6zEnq+ZmiFx02DTHwOfipjGBYaP+MrNCgntc6ceq1vI0QBD+mJIxHnk9vwq4Q29UGFkdJs4B6Cp7brtM8aS9HR8Y/u8EyQ8l9bohVDA41jLRHUheaY0LrqeCI27UYvNrG1DfeKdaageiYMxdT5ZBQ+2zxZ6L0XXdor5Htm3mP8CKoXZ0zpUBy4//L5xpd5MU94WWadT8KUdZNLNFj8xq77OGdSlbXkADwWwOBepWA7W2FrBm435zYV2XubhUOx881d3waKnAoWGm6gHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9Ou4eNZgNrqDC9CsktHGFmSHUS05/MDzuaI34nkS94=;
 b=LzEdZil+jLIpjwpykLEW+b2Af6MtTX8FBqy5VfJwZzEo+Jk/j/LdDcq94mdqAXQaV5/Asul6puc9qSLWeM2N/PiUxAFNWAR71oMj4d9KJpfhPJLO9avz2rHTST10v5LWNCJwjbnBOjnjmwZd1pPVdmaXIVeO8k+P2WXVQ35fG20=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by MN2PR10MB4384.namprd10.prod.outlook.com (2603:10b6:208:198::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Wed, 25 Jan
 2023 17:06:07 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6043.017; Wed, 25 Jan 2023
 17:06:07 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        gerald.schaefer@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 8/8] Documentation/mm: update hugetlbfs documentation to mention alloc_hugetlb_folio
Date:   Wed, 25 Jan 2023 09:05:37 -0800
Message-Id: <20230125170537.96973-9-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
References: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:a03:54::16) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|MN2PR10MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 82001441-0492-40be-a7a6-08dafef67331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJq8bQSJGDYZDqAVZnw1hx7Q3gdFLya899ow5Nl+QJenlujPH1TQubjOetPfSMElnJ4gbzTecTVh16gHFoJb33FK/6vnq0wiVMAjN/IBN3FYDwTx0GMro5LzcFEEKv+maxj95t7szfAQK5no4K4yjqdEQxOrqliNr5jEwpVuj4iJydPcqdAgVFJGFPYNV645k/soVn9dXG8zBNYOgpP6vLL025kBUm8iE1+8CZ9s5Z+TU1kvZN1IZ2OpJifWHAq9wdW4+UptqE3vmcNipuerO//OUR/DVlELYLQhj+tas0ktHC7NV831RrPcGS83PUlBMyBMVbKiD35/9FYNsXJrx+13i7Svbh+kTqYZtw++3HSDpi2mtbzNhTXYH4OJjtEydbPccAf+NsVoRZ6CChROe8NRvcRnPX+QvR9H/nTQ4rdpMhjOw4ocMUuqpHHzsQb9xnLF052loArwBoDOLGDVYPSa8A5t6gErqy68MB1d/0DB9y3Mq3QNMh+GnVqiyKooeErXtaNMKOIoG4xydRFqEBNOjC8cZ7SXcCa4K3v6Ta7pKjGJPqViXMJRf2KVSizvrxmUde6Mmzl2OwkkvUedWuPK09KJ4tdJCDfLcsDNl18G5Ja789lRxj4R7he0DeM0ylhVOmIoEZGuZMHYe0XuGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(186003)(26005)(6512007)(38100700002)(66946007)(66476007)(66556008)(8676002)(83380400001)(4326008)(8936002)(15650500001)(41300700001)(2906002)(44832011)(107886003)(6486002)(478600001)(5660300002)(6666004)(2616005)(1076003)(6506007)(66574015)(316002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekMxYWM5MHdBempOSEtsemlBWXNrT1ZVS212K0U5RUlPUkhrWDU1Unp4blRy?=
 =?utf-8?B?N1dSejRPYnc5TlBNaGhYdUNZOUNJWHFXak1pakRoajRSV1lvN0VNT0NoZU9r?=
 =?utf-8?B?QW9wU213SkV1OUVDbkRvZk9UTWhMckw1Um1yVlZ0aG1Mc2QzSVVHeXloOTU2?=
 =?utf-8?B?dXViNG8zOGpJem1welovcUtOZFNzVDQxRUs3WHVMeUk4blNiZkFvZG0rT3R1?=
 =?utf-8?B?WElaUU9yZk5SVGhNM3I4V2NyZDVWZ1R6U3FLZWlaenVaRHJOZ2F5T3QzMWVh?=
 =?utf-8?B?YVlDWk1WVHE4dEY4YkdKdUlEL2hZNVcxWkh5L3pLR1RWRUw4bWxDVjlpbVRs?=
 =?utf-8?B?Z1BKU3R5V0Myc0JzN29Hd1ZIK0VpTjRFczZrRTBjRkxEanVUSUgzdjdCR1Bj?=
 =?utf-8?B?YnhmbTRnV051MnR4YnVHY2JOTHVoMk11eEhsVmxJT3VkdXYrMUszSUROcGlW?=
 =?utf-8?B?Mmc4UXEyeEJKRGwwLzF0cGd4V3piQ3o2S1M2V0VwNWJEY0UwTisrT3gzdjNP?=
 =?utf-8?B?eFBPdHQ0TEJnbVpFdllmbGI3ZzJ6Y29ZMWY1dEp6S21zeVAyc1lhT2hmQkFI?=
 =?utf-8?B?SXI1U2xpM0JVS21LaVZzbGFrTFlFNElyZFBIR0p3K3JDbm5IWnN4ZmlReXg4?=
 =?utf-8?B?VnZ2REwvWEVaRjd5V0hWR3d1QmZHa1laeVVmMVF6c2kwelF2RDlrSnJKSlJJ?=
 =?utf-8?B?TnlSbXB2dVYzTnlQdjB2Y0ZUZm5VY1lGTXIwVG5Td0s4SUFRcGNiZ0d3Zjcx?=
 =?utf-8?B?Tktwb1RuSjB2aDJOWHk3UmhpUGpyaTE0ZDZBRisvSmdBSDBnRGtBbkoyN2pP?=
 =?utf-8?B?N25lMURuQ21QRHVvSXd0YytnaTFza2thb2pFaWZIam9lSXFJOEFUSDdOY1pL?=
 =?utf-8?B?aEJ3a0JhZlovS090cHdaeXhiTU1objdSbHE4NDk3ZHRwMjBZdm14c2RoVW1H?=
 =?utf-8?B?bEFSQ2t2NjdEQ2VsTjBkL0ZRTG1xL3lZZnN2RWFjY3FjSlZsVGlDSmw4VG5m?=
 =?utf-8?B?Q282a1BHeW95c1diUGZRSmUvN0ZTOUM4Tmpmd0ZVNXc3S0lJZ3dHbndnc3VY?=
 =?utf-8?B?L2x3ZXNObm9XTzVFZGlsdTF1L0JIZHRMcm5HYTRzNmpSUGV3c0V5VnpVc2VO?=
 =?utf-8?B?ZnFydCtjMVN3ZHBsS3ZCSEd4Zk1Gb3BzeEx2RWVveXpKUVYxckxvdUVISmxm?=
 =?utf-8?B?L0R0K0M2T2N0K2k3S2lna0w5VW9HN1FqTHdlZ25RcEZseEgrOEZ0amRvdEJ4?=
 =?utf-8?B?S0tyVEVDSDNTeVdDK3VHQlgwRVlvMXlFWW1yQU9DQjlPTktjQi81Z0RKOFYz?=
 =?utf-8?B?UmR3Yi9RY2dVZ0FqMUhsSGdJb0RxWitzWWV1Mkg4U2xTM0Zhdzd0QVFGSUZX?=
 =?utf-8?B?ZDhLZjE5aVRoOXNEQ1FCeWRZY3pQaUxTRytDOWJzY1h4cVI3eEdZVVI1blZD?=
 =?utf-8?B?cFE2N01nc3ljL1VXMHgvVmFtYmZFTVdBQktURXI3dnY4QjZsK0hwejRKVHNz?=
 =?utf-8?B?Z094TFVZSnMyUWorSk05N0JtbmVUVW5VdGhhTGNZaVYxNWg0d05CMXdxTExY?=
 =?utf-8?B?a1l4REVYSVFidHpjRlJwaXF4QTNRY3hiWWFzREd3SmNLUm5HeGtsWXBEamp0?=
 =?utf-8?B?TXdmQlAydDFWQ1djY2Z0cm1LSWtWSGtJbllKZFZYQ25EQ1Q0M0FaQXBleFJG?=
 =?utf-8?B?OEFHSk4wQkhTT0RoU3N2WFZrMWp6Uy9wN3N6VmFWZUgxdlA1WDVZK0tRSyti?=
 =?utf-8?B?dVpkbGVVcXY1eXMyOUE4U21Ha0RudkhvOGJYa3FiN1d0RndtRGhFL2RhNVR0?=
 =?utf-8?B?ckp2MVE4aDdEUDhxdFE4SHNGbkkrQi9OaVJHV0dRZG00dEVzSExnU3hWR21H?=
 =?utf-8?B?K2VJSjVEZ1lKSUNDTFpLcmpqaytPR2hTdXQwb05tTnozYjY3ajEzNmZjVWd6?=
 =?utf-8?B?eUJXRGpmNlU4dzEvK1NIL0w1SktJZkxuZ0o0SzZVSUp1NG1aeGR3YzkrTUpM?=
 =?utf-8?B?b1A3OFRtY0Q1UGJCTE45WjB3b0d6TlkzWitXYUdCWk9mSHZhYnFtSDBoaEhr?=
 =?utf-8?B?SFNXeStXMWpDMTlnTFk1VFRvUVphWWpDN0lCV3d6aGIvNzdJckRiUmhxT292?=
 =?utf-8?B?dDVta2NJdGV1aUd2MWZtWXQrbmJab1Bqd1ZPV0ZCZS9WK0JtWGJHTjE0cHFD?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L21EZUhEVDF1d0pHQXpXaWQyeTAvVU0yQVExSDU0VWxhS0dabUJuYWRrNUNj?=
 =?utf-8?B?VDlHdzBtK1lkZDFvTmlFaFo1RElraG9NRU5kVkcrNVRQcmRtdDZ0Mk00b2NB?=
 =?utf-8?B?akR3d2hRTmlEOW9Hd3BQQUszdXJ3ZEhWbEw5NW9HMWtzdGFwb0RPVmVYU0ph?=
 =?utf-8?B?Ly9CRXBDOUxEam1vZkFxY2hLZSt2R2dML1p4WGVMdlJYTjNaY0hLRnptelZL?=
 =?utf-8?B?Y2JBeDdISkQ3MU9qN2JGVTZmcnk4ZHdmRUxnSlNxTXFrK2F1eThKOFd5UDhQ?=
 =?utf-8?B?N25JWk1tSkFGd2lnWlFQTEtOZDNZUGFqcU5LcFFjdU5qUVhtR0YrbG1rU2or?=
 =?utf-8?B?RUZhWk1FR28rYmZicFBVZ1FQQUVQa3lvVUJLQVR5Y2t4NVpOMmJmdUxCN0JG?=
 =?utf-8?B?VXZua3R5ZTBvMmZ5NmJ2REwwVDVBY1ltMGszZENvOWhwZTY3Wmp2dnJtVmhI?=
 =?utf-8?B?bWt1NjlmbmJYa0NqeHJ4MlhMaVAydVlkb1VCSCt2c3NMRXJTc09JL0xhZXhX?=
 =?utf-8?B?ZXl2NWhOOGMvN3NVOFBwa0w1WkZubXNWbytSSEZjTy8xUmNIREhERTVsTDRw?=
 =?utf-8?B?VkF3S3RZd3pyajY5N1FxQXlUK3BLQ3M5RC9FMzdmNGVUdHVDVkVUZW9xRS9N?=
 =?utf-8?B?MExhb2FjUVhJcEdjRUcyUzB3YzJXMGJxbnpPRVRvaTBSa3I0eDdVMmpBa2Rp?=
 =?utf-8?B?RUROL0FFZlFMb2tiamRmTWNIYWZyaTFDYnhNVkpFQkhQTUNBMmZ2cUlEN2tD?=
 =?utf-8?B?dnY4dDZmMWorZk93eldQSndHU1ZoYW9EMXkvalROdU1lemNkendweHJtYUha?=
 =?utf-8?B?Q2Y1Y2FmTUs5dFd0c2xKaExqcEwzUWNqRXdxQWc5SmpDS2t2MTBGc1lFRUNR?=
 =?utf-8?B?MVZGT2pFMjYwZU92d2ZxTmRlM0RyZGlxZ25QZWRZTGdkbENPN1BiUDZvbmJQ?=
 =?utf-8?B?VUVTbHg5dmxndzNMdlVVMW9vQWwwZHRQVXpmS0dPd1lkQmMxYmxaN3k4WVU0?=
 =?utf-8?B?a3QybEVFSFlRS0NyUFZmOGtseXJ1bU0yN0hDdi9IdWpIWlEwb0Z5T1lHYmdk?=
 =?utf-8?B?Vmo3K3pCdlFScmxkRHMwdDd4VDd5VE91ZDQyY0R1bFhrdEtTQnpqTWs3R0xi?=
 =?utf-8?B?ZTFZNDNNOFdYbDJ4SEtYejdJNEsxYlZqVHgzVWU0ZHdsOTdWY21sOWlqUHJC?=
 =?utf-8?B?djRVeFBWNktqYUpucU9HTlZkRnA1V1JGVWtNalVDcDVxWDFBU0F1amIzTzVq?=
 =?utf-8?B?NEJucm5OMWc0RjJHLy9pbUtMaU5UdjFsa3pZeWdFQWVGT04wNnYvVjVoU2I3?=
 =?utf-8?Q?B7N+nQVmFvBas=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82001441-0492-40be-a7a6-08dafef67331
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:06:07.6244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smKWXfr8g+q7OiBlK7jcb7duTZFN0GKvLR98pehHC4Y/N/QVP8Upd5tUI0zSB1K3BtlhAg50BmmKIZ77LoKzFC4dO82ARlygJsQGh9vjJbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_11,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250152
X-Proofpoint-ORIG-GUID: Vlw7kiCJ9H6_bVndrEOg8GZCmStiFpAX
X-Proofpoint-GUID: Vlw7kiCJ9H6_bVndrEOg8GZCmStiFpAX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 Documentation/mm/hugetlbfs_reserv.rst         | 21 ++++++++++---------
 .../zh_CN/mm/hugetlbfs_reserv.rst             | 14 ++++++-------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/Documentation/mm/hugetlbfs_reserv.rst b/Documentation/mm/hugetlbfs_reserv.rst
index f143954e0d05..611728c49bff 100644
--- a/Documentation/mm/hugetlbfs_reserv.rst
+++ b/Documentation/mm/hugetlbfs_reserv.rst
@@ -181,14 +181,14 @@ Consuming Reservations/Allocating a Huge Page
 
 Reservations are consumed when huge pages associated with the reservations
 are allocated and instantiated in the corresponding mapping.  The allocation
-is performed within the routine alloc_huge_page()::
+is performed within the routine alloc_hugetlb_folio()::
 
-	struct page *alloc_huge_page(struct vm_area_struct *vma,
+	struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				     unsigned long addr, int avoid_reserve)
 
-alloc_huge_page is passed a VMA pointer and a virtual address, so it can
+alloc_hugetlb_folio is passed a VMA pointer and a virtual address, so it can
 consult the reservation map to determine if a reservation exists.  In addition,
-alloc_huge_page takes the argument avoid_reserve which indicates reserves
+alloc_hugetlb_folio takes the argument avoid_reserve which indicates reserves
 should not be used even if it appears they have been set aside for the
 specified address.  The avoid_reserve argument is most often used in the case
 of Copy on Write and Page Migration where additional copies of an existing
@@ -208,7 +208,8 @@ a reservation for the allocation.  After determining whether a reservation
 exists and can be used for the allocation, the routine dequeue_huge_page_vma()
 is called.  This routine takes two arguments related to reservations:
 
-- avoid_reserve, this is the same value/argument passed to alloc_huge_page()
+- avoid_reserve, this is the same value/argument passed to
+  alloc_hugetlb_folio().
 - chg, even though this argument is of type long only the values 0 or 1 are
   passed to dequeue_huge_page_vma.  If the value is 0, it indicates a
   reservation exists (see the section "Memory Policy and Reservations" for
@@ -233,9 +234,9 @@ the scope reservations.  Even if a surplus page is allocated, the same
 reservation based adjustments as above will be made: SetPagePrivate(page) and
 resv_huge_pages--.
 
-After obtaining a new huge page, (page)->private is set to the value of
-the subpool associated with the page if it exists.  This will be used for
-subpool accounting when the page is freed.
+After obtaining a new hugetlb folio, (folio)->_hugetlb_subpool is set to the
+value of the subpool associated with the page if it exists.  This will be used
+for subpool accounting when the folio is freed.
 
 The routine vma_commit_reservation() is then called to adjust the reserve
 map based on the consumption of the reservation.  In general, this involves
@@ -246,8 +247,8 @@ was no reservation in a shared mapping or this was a private mapping a new
 entry must be created.
 
 It is possible that the reserve map could have been changed between the call
-to vma_needs_reservation() at the beginning of alloc_huge_page() and the
-call to vma_commit_reservation() after the page was allocated.  This would
+to vma_needs_reservation() at the beginning of alloc_hugetlb_folio() and the
+call to vma_commit_reservation() after the folio was allocated.  This would
 be possible if hugetlb_reserve_pages was called for the same page in a shared
 mapping.  In such cases, the reservation count and subpool free page count
 will be off by one.  This rare condition can be identified by comparing the
diff --git a/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst b/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
index 752e5696cd47..826a50c47389 100644
--- a/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
+++ b/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
@@ -142,14 +142,14 @@ HPAGE_RESV_OWNER标志被设置，以表明该VMA拥有预留。
 消耗预留/分配一个巨页
 ===========================
 
-当与预留相关的巨页在相应的映射中被分配和实例化时，预留就被消耗了。该分配是在函数alloc_huge_page()
+当与预留相关的巨页在相应的映射中被分配和实例化时，预留就被消耗了。该分配是在函数alloc_hugetlb_folio()
 中进行的::
 
-	struct page *alloc_huge_page(struct vm_area_struct *vma,
+	struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				     unsigned long addr, int avoid_reserve)
 
-alloc_huge_page被传递给一个VMA指针和一个虚拟地址，因此它可以查阅预留映射以确定是否存在预留。
-此外，alloc_huge_page需要一个参数avoid_reserve，该参数表示即使看起来已经为指定的地址预留了
+alloc_hugetlb_folio被传递给一个VMA指针和一个虚拟地址，因此它可以查阅预留映射以确定是否存在预留。
+此外，alloc_hugetlb_folio需要一个参数avoid_reserve，该参数表示即使看起来已经为指定的地址预留了
 预留，也不应该使用预留。avoid_reserve参数最常被用于写时拷贝和页面迁移的情况下，即现有页面的额
 外拷贝被分配。
 
@@ -162,7 +162,7 @@ vma_needs_reservation()返回的值通常为0或1。如果该地址存在预留
 确定预留是否存在并可用于分配后，调用dequeue_huge_page_vma()函数。这个函数需要两个与预留有关
 的参数：
 
-- avoid_reserve，这是传递给alloc_huge_page()的同一个值/参数。
+- avoid_reserve，这是传递给alloc_hugetlb_folio()的同一个值/参数。
 - chg，尽管这个参数的类型是long，但只有0或1的值被传递给dequeue_huge_page_vma。如果该值为0，
   则表明存在预留（关于可能的问题，请参见 “预留和内存策略” 一节）。如果值
   为1，则表示不存在预留，如果可能的话，必须从全局空闲池中取出该页。
@@ -179,7 +179,7 @@ free_huge_pages的值被递减。如果有一个与该页相关的预留，将
 的剩余巨页和超额分配的问题。即使分配了一个多余的页面，也会进行与上面一样的基于预留的调整:
 SetPagePrivate(page) 和 resv_huge_pages--.
 
-在获得一个新的巨页后，(page)->private被设置为与该页面相关的子池的值，如果它存在的话。当页
+在获得一个新的巨页后，(folio)->_hugetlb_subpool被设置为与该页面相关的子池的值，如果它存在的话。当页
 面被释放时，这将被用于子池的计数。
 
 然后调用函数vma_commit_reservation()，根据预留的消耗情况调整预留映射。一般来说，这涉及
@@ -199,7 +199,7 @@ SetPagePrivate(page)和resv_huge_pages-。
 已经存在，所以不做任何改变。然而，如果共享映射中没有预留，或者这是一个私有映射，则必须创建
 一个新的条目。
 
-在alloc_huge_page()开始调用vma_needs_reservation()和页面分配后调用
+在alloc_hugetlb_folio()开始调用vma_needs_reservation()和页面分配后调用
 vma_commit_reservation()之间，预留映射有可能被改变。如果hugetlb_reserve_pages在共
 享映射中为同一页面被调用，这将是可能的。在这种情况下，预留计数和子池空闲页计数会有一个偏差。
 这种罕见的情况可以通过比较vma_needs_reservation和vma_commit_reservation的返回值来
-- 
2.39.1

