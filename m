Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543D9743F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjF3P70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjF3P7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:59:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBA83ABF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:59:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UEnFvK015084;
        Fri, 30 Jun 2023 15:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=V6njzENVbH1Ko6m5e7UwJlUWwzc4egZWfJg/UMWQZGY=;
 b=Al3Vuec5mQAM7uXSXdOFP6pJjMHQB+qhCW2j+lbb5ZoZRLkgdaJvl9+FUXA4hSd6lrqK
 iY7etNVLCBK0LzI0C359v4J5yHAUoNXoMLr24etwDEThrzN3vIrDEihGIsf7tWCOVgmZ
 0RiNtGO9UkYPy/gN8xoysfsRlgrAiHy31idABUR8xM70kNj2w8bK4ScwIdG2PqUGZhzx
 gCsxMChEgM2EhqgtcXXOyiTHqgwLDKkaZKIZhrHMDYpILnfd16ouENsRZ0k8MJA+aiLW
 bP0OQZIx0Z8r2je7dIFZ4dHcRGrL8iXu8W/2vDyB7qG4A87tjCg7BsnFl2gSCXex+LC6 rQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq319hhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 15:59:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35UF1E19038208;
        Fri, 30 Jun 2023 15:59:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxfjfyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 15:59:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/UEIFKddj4D5MW1hzfVOcl9f2N8qcrKToaY9LNKlEdMmwUXSyOouGXVNabu/Gn0rx3WNMkVwfEAUXwhhZl/H8tqaFem02dWJ0M06hvRXV5nxM2qFxB3H4j7kBZBIFwNlFaggk6TpoV/LTodzANNmj8XrxY2k3V6tZqmujnmjBqjyxUSOXRUk0HVBq23hwq3LzadFQmvVeD7iVSEJMm4RKRXx/usotq7lMVfbDfoe+UKvdP8G8ycE2buiWp2pCxVak4minsPmsiUt7/67xtDX4OFGwvvZDP/s2hDnHdRraOYMfVHNSuxUJGU9LoZxbJh62AEfLRDR6sYw0yizCBnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6njzENVbH1Ko6m5e7UwJlUWwzc4egZWfJg/UMWQZGY=;
 b=GFPIh6uxSkpi9wfUMMU6kULX+sENMUxvLHyxJxe52a3puTlyPcThIGU4tcWcZqNvnsTAodNb2+vR7s+q3RVbfZrlo/ZJ9JGMLyLnOVPMAZuv5g/9/BJLA7wo8tc750muWcCsbQXG30rM/OL4U2rJiGsspBQ5U3ySmzpboP9+2FA6JINKcDBRrGSbXp16EqGJtSZkRzBHiKNFrZbV72gzEdEdJHmrfzXAxq7l4qZzSrMUAh33STlQMKep4ILRQGKgibdraWRb53nF6jMUKXAkPbZiw1EDmlaZun5Z3dQP7dDFc3qPsCP3GJIt8dpn1oX+7V09pj3Geqi4oEO2hUhUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6njzENVbH1Ko6m5e7UwJlUWwzc4egZWfJg/UMWQZGY=;
 b=ecc0iNpABgurW6W+RN3dQIWFptMWyCbC5At908Vmov0E5SMMr4TAFebfVN1giDDOkYNTs981dMskl08HBaZ3lKfHxMz5ufPHQjNyCmLNutKzLuGTxnJBw7jkoW6vm2/biEctp5BKciiRQaWI8ml/ZaEzgEIp44b05OJzqJnwqCc=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB7267.namprd10.prod.outlook.com (2603:10b6:930:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 15:58:59 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 15:58:58 +0000
Message-ID: <6800d1d2-4378-f851-f2bd-5b8479358234@oracle.com>
Date:   Fri, 30 Jun 2023 11:58:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] mm: use a folio in fault_dirty_shared_page()
Content-Language: en-US
To:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20230630121310.165700-1-zhangpeng362@huawei.com>
 <20230630121310.165700-3-zhangpeng362@huawei.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230630121310.165700-3-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR14CA0017.namprd14.prod.outlook.com
 (2603:10b6:408:e3::22) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: d869af00-0c92-4e27-f5b9-08db7982ea31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8fl/JyEuyh3nv0wvIiVgqju+tTY6SPB4fzZaHr6dCyrjJhtBc27/fjrxh+r81q3Vn+f/q29VDNYO/mmTWd5tIg88ruKqA3QeVBSgXH2HVuGhCkenavr59Tg+p5lr3BEVZDI4ZYPrLReIKIRisTEGPeAPh5rsK5BrMV1wEzrUxPwj9dIr89roOLIbZBX77uU9loeNSpG51SoRi4On8E595rqfROjla8A2E0d6YQxVzR4e3aDSdHt5reBJiZHTxFQ08FqLqhpWhVIpsxGSjD/5ww3cAHpSDXPx6PeccKaBZx+VXsI8ePQRRvnNGTaERLMxHT7uRgrArn2RgEPGNdcbhGS1XlWk3Tgg6xfQXW/uwtdJcMUFB6YstgJeTbxG5OUDqygjRB6qntiDozajzr9gY+hF4RdPUFc8SL+8La+STbdOk77gtPnqV+uV1pNFUCJWki/4s9rnAkIUKxB0q+Wgt9xEOMY14zozn9xkPC5ved7hsnVOzsy3DMV2+aUcpiUZrbF2r+DqLP6Ngw1hrnHMmQYsLI0r5NlZLm6A1VCaGDQCIU6Qsy0crxP0ELdwXKfOgm7qL42TBhNUf4/QYnjv8g/3ud7cw98qYFrQcHCvjwe/VnaBQcAs50iUGpJd6cZvuRemto+uKh3y43p2liIXowezkUPTil4bjrZ/13nqXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(44832011)(5660300002)(31686004)(66946007)(66556008)(4326008)(66476007)(478600001)(316002)(36756003)(8936002)(8676002)(2906002)(6512007)(6666004)(26005)(41300700001)(31696002)(6486002)(186003)(53546011)(6506007)(86362001)(38100700002)(83380400001)(2616005)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UklpK00zNld5Z3V0R3pLVWxJMkNFWHdlazQzNXJiaEV0MllmOHMrY2gwd21o?=
 =?utf-8?B?d0RYU0N2aVJuSDBIdzVXbHhJS3lGWEJSTFJ1Q2ppZ2Q2Z2hQV1ZJWWpiWTdU?=
 =?utf-8?B?WmpBUlFINDZ4S29VR3dLTUswcFh0MTBLb2hpdDY1STh2b2JnVlBPMkhJeGZH?=
 =?utf-8?B?UWhQWmNiK3ZqWDR0VHRMWDY3ZnRqa2hsU0c1T0tHVFdQdjlyR3BRNjVYQXFH?=
 =?utf-8?B?cFA5L3k3WXdRKzR6NUxzSXA0L1NHSG9qT3JaYXR6ay85a085UHYwSU9hR1Zi?=
 =?utf-8?B?S2ZhTFg4VUZmNmdyNnhPRi9aQkt1MEdBVkFyOGxVVGVjeWgvNG9zUkx1dHZ3?=
 =?utf-8?B?cFNPRjFwTVZ5TjZTY3doOVZRR1l3Nk5YTmFRR1YyYzFheTlmN2VyWUI5bG4y?=
 =?utf-8?B?UzJCQ1ZDNjV0c2ladXhZWUxLR2lwSW9CSjJlY2VYZFFBcmVsM1RrMXkvcmMy?=
 =?utf-8?B?eU9YTGVOWTZaTTl6TldKV2ZnY3oxc3BsaTRSNVpSNnpLU3hBckFSSWdjMjVO?=
 =?utf-8?B?NWlLUFBMM3h6Q2tPL2xYSk1TclFaUVpQOUNVcjVRaWxWVnkxTUR2ZHhMMm55?=
 =?utf-8?B?QjVrUGVwekk2UDM0cEhWNWkrSG54TTJrSTRzaDZSdGRXZGM0SkRHdFNGdTk4?=
 =?utf-8?B?RjVKdWpvcHY2RUdHY1BIdFJhZ1paSFlqTmk0NitxcnlIM2dDM2xnMytVSnlT?=
 =?utf-8?B?OERlMzFPY213UFI4Rk1kR09CQkszNTg1Y2k5c0huMm5Wbk9od3NqUThxNnpl?=
 =?utf-8?B?TWFVeFBVK1hITGRyaFdKU2p6ZTRjN01xVUs5TDhnbWlSa3dJWU5MQWlSTWJh?=
 =?utf-8?B?WU1yK2NqUmU1VDByUE44NUZ2OHdjT2tqZGZZUm5PK2FZZW5nWUVRbDFsS0Uz?=
 =?utf-8?B?eXlDbXlCVHhEYkVtOFd2K2lCeXFpTkdPeWFlUzB0b2U0NjFYK2x0eDZtYmFF?=
 =?utf-8?B?WDc5cXFJcUZXU3JjWFRYQXlhaHVoNGVrTkgrSmNROTZhOUVNVXhmUzlnaHJ3?=
 =?utf-8?B?R0JCUEIreVZSajJzUkM4SUZ5NWFKM242MGtNWkJEL00vUDF1TkpFdFMyWnYv?=
 =?utf-8?B?clQ4YU13N2NaSU4wQmlVZk02MTdKZitCSUxxdFUyejNuRmM0SmNtbUE2b3Zj?=
 =?utf-8?B?ZW1KalpnT2JWWDN6YjhoMFE2eWZHMmNaWG5YRnExZ05wQm16NkhwVkhQNW8w?=
 =?utf-8?B?MHJmYTIwalF2ZjUrY1N3M0swYjB1aFNGdTJhTUpwQWNpNktWb1huUHF5RFpE?=
 =?utf-8?B?cWFIN1MwaEdPcFNRMzdvcHQ5dWFQeGRjKzQyQSsvMDFHdWIxdlJqMmlzWE5Q?=
 =?utf-8?B?eW5IWHI1TENQY1pkUGdRdzZDVmZRWUNLK1RhR3NnOE1TdW0vOW1CeXVtR0Ft?=
 =?utf-8?B?Y3dna213aG9HdzVJRUFyL2gwWGVDOFB2M1lDeXExcVJBSktpNFlYRTVCKzRR?=
 =?utf-8?B?U2pIcFBXUThnM0l6Z3FObDFqK2ZiZGF1NGxwRHZCSGtnVUZrb2h3OVprN3o3?=
 =?utf-8?B?SDBrZW43V3ZyQUZrZFJvUGx5ZHJDd29ZYmRsejB4WlMrNWhXblY0QjZxbzZQ?=
 =?utf-8?B?ZDJSdTZJVGl4bUVwSll0VUNvb05RaTd2N2NTVHpkWmpqMkt3NlYxaFJWSG5O?=
 =?utf-8?B?WDRpQjUzSTZFWVg5czVhL3lieEhwR2lPQld4aVErUk1qNmZpWVc4U2x6WUl1?=
 =?utf-8?B?REpvOUhBZFZMSFloRXArcjRkSGFOYTBjNmE3TW5tNjZ1TXQ2NmlOeTdOWTBR?=
 =?utf-8?B?WFFFRzVTaitBUmExY0FyTUt0ZWVhMDlyaXRhblFKSlJvbjE4Q2dyMm5jbUQy?=
 =?utf-8?B?aUVFbmJyQUxLYWlhRUJvalNmUVZxQU0waTdXeTVVcE9hRjNlUU5xMW1XTTRL?=
 =?utf-8?B?c1FUS3JTR3JwWlNteGRDcjJXUFFkS3FoOVllVHpqM3pHN1RDd25WRG9abmFG?=
 =?utf-8?B?eFovRm13dGdkMUZ6aVZ5THgzZVRFT3p0UDlkRy9oV0h5NUp1eXhqNDZ5UWNj?=
 =?utf-8?B?U25qQ295eldROURIZVhQSUNpdWFxMWNHeUMrRXo2eUxGc0d5WEZBU3dKVGE1?=
 =?utf-8?B?QkhPWnN6aU9GbzljbmxyS2t6L0hpMVdScjc2MUlnd3JqYzVRSU9sMmZHajQ3?=
 =?utf-8?B?S1pJcjZJbWtkRGVYVDhTdEFqZktaU0ozTFJoaDBzVmMxcy90VWlqdTR6R082?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: en2gH2ss4pvYOE6OaD+UUCsYfjHAtNvHImtHe7W1hju5pp9WR1aVeIPNORIZ3KVFoE0jkfreCVduBzq/SNDaNXeh2ScvjEZrDhWkMWceB0JbAQfqShWq/8pkcCTOoFC93lm/rO4Xelne8Vqz5oY6juysFJUfV6pD+KqnRiu3Aq3ViY4OkAgv/A8SkQzNswFIXamu7vYkcA8slQchjMnXHTvCoe3G8afLsg5LUo5ffTGbYaBZN31NpuFOBeoX7lcgxjQNi76OIND8BZLiLZ3rg/g/ms+xqf+Ui7JhPwSizfspeQ39oHgjEd8URurBebvSANXzG8shJs/2xEJJ934dJWufoofvu6i/qyGnl+rW4TeXOFupfrELcDD26ZkuDdSehzezjIMNivqNX3sgZn/f5WiF0jmp6xD4X1vP0VZXQSL17tZT65lG/9aSlcrtZ9EKgi0ruTx318YrDxaTDLGe0s62PYSJSP/rXd98ZMZVSxb5pnQQ+YDJgFtNnuFTJjrCyV0MR0GnbzLpyqKKxDC+19Q78JHXEYUcB4NDow1aJCY/Z+GMQp5xQbN70hokfDCutNpgoBQ3mf+IsK4OIwqxQ0XS29Xpvfeiekbxxixuk2hUxoL9IZyxMHX8obZXjMUBtrtgHedWnf6wwx9KWxoAin1/pi16yeOfncCTezg6Qv8amegvkRQNYmAygZ+oP9KFrvZ8tzEzzESQTu/r7W17LBWzhSNNytiiHdW/BFGBAruzLIDRwBuTZkB/hjrfkrGwXu5DOMknv25NL1fSNee0UAt1f1O9WctBBsPDU04QOJuElS9jCOHQoJNMVQWCuWaVNiDASTBX7VhDT15sEBk23GUvTZkHEON2eWaKepocIDLE2L8EPP+Z1h1uVy9+8GqiBE8LS7okrEPtr9rDcQmA942eawt/soh6nXKopVFbXSU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d869af00-0c92-4e27-f5b9-08db7982ea31
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 15:58:58.6511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgbhK3EyfrPjAWo/xpbR11RylGReYrYtJ0wA1kUqPb5JxHWg/OuUwgTh4rN5FqKDkRBJDDK73ANf6l/ONw/cr2HhYul1v0MpVD0iXfr9RmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7267
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_08,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300136
X-Proofpoint-ORIG-GUID: TBIbirUED-XRGbNt7RHCgp8m9-S-Br0f
X-Proofpoint-GUID: TBIbirUED-XRGbNt7RHCgp8m9-S-Br0f
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/23 5:13 AM, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> We can replace four implicit calls to compound_head() with one by using
> folio.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>   mm/memory.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 6921df44a99f..73b03706451c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2967,20 +2967,20 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct address_space *mapping;
> -	struct page *page = vmf->page;
> +	struct folio *folio = page_folio(vmf->page);
>   	bool dirtied;
>   	bool page_mkwrite = vma->vm_ops && vma->vm_ops->page_mkwrite;
>   
> -	dirtied = set_page_dirty(page);
> -	VM_BUG_ON_PAGE(PageAnon(page), page);
> +	dirtied = folio_mark_dirty(folio);
> +	VM_BUG_ON_FOLIO(folio_test_anon(folio), folio);
>   	/*
>   	 * Take a local copy of the address_space - page.mapping may be zeroed
>   	 * by truncate after unlock_page().   The address_space itself remains
>   	 * pinned by vma->vm_file's reference.  We rely on unlock_page()'s
>   	 * release semantics to prevent the compiler from undoing this copying.
>   	 */
> -	mapping = folio_raw_mapping(page_folio(page));
> -	unlock_page(page);
> +	mapping = folio_raw_mapping(folio);
> +	folio_unlock(folio);
>   
>   	if (!page_mkwrite)
>   		file_update_time(vma->vm_file);
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
