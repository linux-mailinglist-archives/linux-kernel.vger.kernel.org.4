Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A8274A407
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGFS7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjGFS7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:59:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85024E70
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 11:59:15 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366HXvAS006862;
        Thu, 6 Jul 2023 18:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Drbw8nzpjPDywTDvDwUmHD1dK8rrLKTFnRtaN8QVWlU=;
 b=A0ngzkK1aC3MHtBQWxJYLsoV2VTu+So/NBdq2jqVuj/ICe3ICFZd2OemMhp9TUgKwMep
 UfNmutZif9jKuA0Shfo8sbWtRbKoA452f6KVPPeJLhzkGKW0I6BvhyvOsEkJTIXCDesQ
 MnO1mv1VAzK1MGq3wxIAJ/+tT/tmd8z/8QTnSsvOz95zjgf0Dmy73h/jyyZYYlTpYUoa
 vn2F4jWarCYaOHUos/IgoqxA62NZI9G+rZKrUVsX4x857IMG9ESzPMKwR0t0GmNjIveM
 9EK8I4Rmfd6OZFp1uW0VMYUAN4gXKGMTVeklC94/DQKK33qmyGS/5n5CAbQZw9cFSNtl mA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rp05bghju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 18:59:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 366IVjZ6010231;
        Thu, 6 Jul 2023 18:58:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak7f1yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 18:58:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIjlyMsllkdqS/IUD/PI+DZRceYA4atpBgpLr6QpOQBFhvHIowpAYPEpK4rNkRh22bpfZJDRhFOf6g2LdF/DeMgZTWonwLWM63sIj/2zkZwJVRShsje8YbWluk3TsBF3oaUSjq3YmcomCpcaAKzwmYXMfQTSdJDdgNMzN+4fwYz/gEMRaPudb6EorFwIJtc+j0IZBFBQXJG6kfaCh7PyBxmyEfAFjbLLkyEDC+g+83dGDxjewUWQHoLRfmBECOIPgaHpL/03Ytl9RgIuG2SnPDTk4CbyUrlq7dWTZl2p2kXuNy52OF42bDpGoTMTuYfiWhny6e2DlAhKLtLHIExtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Drbw8nzpjPDywTDvDwUmHD1dK8rrLKTFnRtaN8QVWlU=;
 b=LYbiMFIRqczQarIlRTMD6LKtqAEiqtVmCg+nCGdQYqP0GS3isEi0zQJoXRvMn2F1aNE9cwYTQV1Fr/AR6bNEtjEaNCRUS8ntyflXGoqvbxqZh9TwMqdSBBCV0pQkZ9c1YsuEJ1N+kL40suMiPp5O0Bu/8uY0G6D0ySxWP8JKVn9pfQ653W9rzvhrwBqsRjSZsk9+jZCTcikqr6PGmxJcFD9vFGUSJGv35/QAwQtAFyEopSEv9N03JKq2ap1inxt0krBVhevem2SS988WJwNlfl5uudTZe+19bJosJuegHBaLhfyatTHYPn6d+TUWuvXbcWq6AXS2lTrPPDJli8j7Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Drbw8nzpjPDywTDvDwUmHD1dK8rrLKTFnRtaN8QVWlU=;
 b=tGfcqCUhhjD8jrf+ElCfe9OhRWRLX6Dq2UK7x8MhvukWB/xA3cT1gt1VzE+R73rxcbNchKXhFvbrzC0b3FCjd+tfs4HAqzIx9/yLPz0e44izpMuSQb+fMcz6YkResPaTzRswYTZsl+7S0N9Yt+LE9eGNr9s/w0Mc+sGE50uzQpA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 18:58:53 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 18:58:53 +0000
Message-ID: <5cd93eb4-ba09-d50f-71d1-940cb8aae73c@oracle.com>
Date:   Thu, 6 Jul 2023 11:58:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/4] mm/memory: convert wp_page_shared() to use folios
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, zhangpeng362@huawei.com
References: <20230706163847.403202-1-sidhartha.kumar@oracle.com>
 <20230706163847.403202-2-sidhartha.kumar@oracle.com>
 <ZKb+dimvau+g6TEC@casper.infradead.org>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <ZKb+dimvau+g6TEC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::14) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: b296c4ae-cc35-4e76-e3e2-08db7e530aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Si4sV0plSKWNPqz/V0D0JVuZWZQ3IhmOLWowZ5iJF682eWVaBNPjfCw6uQQ9iuttPszpoJACHfSLS2TSB5XT2ODWqske50q7NHr0c4OdSzxoj++G9Q7xBJHn76kWYmv2Pw99CqA8kX0F3Vvm8btagt86NvC+FAZ3yhp96gzsnmeQ/8c3VPk2k5/pdnLwG2l7Cr62khjycYwy+cZTuo5E+VufpwavaazmtJem0Xh1R8PFYjtPjVcp4Au9xNqyRiFiAux75MowcHw9hVOo3SgRxTVMsgpFN4qzkxBtfzPZ//JdDA7IZcvtsz8xnWMv4grfWpAgkHScoh1pg5JvpJYmv1kA+07l/GQzqW+E0KzN09P8if193Lh2olBr78Y5yfJKBH31qB8A49x0VkoV9nV4IYhETEayyZYSP8eSUBD6Yy4ogwnD2ic08pgWnaFkZlvDSkJsT4l9G3YVFViheeX9DVzcKeInYxvB6QND0NXk5jlhABWtu4Z7nbsE5COgvvDyiJ9dBDaUEpR0Be769bduQauI2ZbmCgyP00SuS5w2FrAGQW/4ilvkWUuYhTktGHFlHQIRTxCiJAmowZr7Ads6noP1Ro9vaYqkZ6C6wIrY7zcuwDiuIygszGj3+7oLCeIGGckMCvDELzbP2DNW8IqbKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(2616005)(6666004)(6512007)(478600001)(6486002)(53546011)(186003)(6506007)(2906002)(4744005)(66476007)(5660300002)(38100700002)(41300700001)(66556008)(4326008)(8936002)(8676002)(6916009)(66946007)(316002)(44832011)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3BaRHowVVJwZHFoUlR4VU00TFNrK3Z4TS9KNlA5SlZNZGhheUtnY0ljRVlh?=
 =?utf-8?B?MVZzK3ZhRGQvVGQ0ZUh3TWl6NE93UUEvL1RsOWpENEx2NWUyTHlsWmQ2Q2to?=
 =?utf-8?B?Y3FlL00xQnhnTzBrTjl6VldyRGh3K0hBL1NCRk5ibmtheWlBOTNiWjBacVlG?=
 =?utf-8?B?ZWtXNGZFQVA4Y1BHSTZXKzRwN1NSRGY3OXNlMmErTDNyY1QyeFY4cnMyMlE2?=
 =?utf-8?B?Y256OFcwemlZaVZuNHIxd29hRHNxek1GK2w1OXMzckRLOWlqaExybUNNYVBO?=
 =?utf-8?B?UGd4OTdSNmNCYjE4NDg2NzRHOUlUbnpyRUp1OVlVSG8wdEFXOE1ZekR0Rmh1?=
 =?utf-8?B?bE53UDhmVytTYjNtK0xEY21JYUJrT1lUVDh1eUF4L1hKVlF3STBkV3cydVY4?=
 =?utf-8?B?Q0VyS0hlMGI3ZEw0cUNDMXhKZWlvYzNBZTJ4L2JCek1TelVidUJxMUg0YnRz?=
 =?utf-8?B?R2hoWFR4c1ZKbHJ2TXQ1aHY4SytJNTViYk9RaC9JMElpSzBNbGhwcUZYaXha?=
 =?utf-8?B?SERDdk8xWGVwQXEvbUF5QWRVOW9qZWVQOUlHd3o3RzJabkEwT3BNK1hPUW9Z?=
 =?utf-8?B?RTI5N25DRXdQVEIwK0VzTDY4N0gxUUFGbmVaMmdsZ25ON3NHMWF4NFZrbWhX?=
 =?utf-8?B?ZWt3ZHArSVR6RURKYlhXQ1hEUkp6S203S0JwQ2ZhaWxzbTh0MzlCdlhnSkhw?=
 =?utf-8?B?NHVnUE15MEFkd0JVT0VSOWhBVEVoRDFrUlkxcDZwU1VuUmxaSWx2czFwOFNU?=
 =?utf-8?B?UktqTnZZRXVGV0xMTy9YMm1Sd0pWQXlSZGdwTE9JemN6aXlYSnN2Q2ZFNENW?=
 =?utf-8?B?YkV4WC8rS1lGbGU2K0RQenZlWE92REh5bWxtS0lDQTZlM3ZFeVJaOG9UOUhm?=
 =?utf-8?B?WFBCd0VXeGRQaS92cmpIcDNORjBtL2wxSjJGUFNHUnprdEZYY2xyK0IraFNa?=
 =?utf-8?B?MVo1L3BnRGYzVGFsNk40SWh6U0x0SW9NTkhDcXBvN051R1lzeW1ET3V0ZFlO?=
 =?utf-8?B?VnVycHFibXE4ZWRIOHlKT0kwZTJUUkJwbENRdFEvTGV5RFVBYnJCekc3d004?=
 =?utf-8?B?VWJncjVLQ2t3YmlFbXUwT2dDNENuTHRmTGVSa3NlcUN5TUlJZTFWa1JqeVlw?=
 =?utf-8?B?ZStFNm11MndEajFMaHdJV3RIbkpnQ1ZyN3ZOZkdVeXdDKzhDS091YVEzTUEr?=
 =?utf-8?B?UXM3QStKQVhtUXBUS2dXZmxDdWtDWUYvL3liZXlBdURYOVFkUUF2NURoR3VH?=
 =?utf-8?B?VFpYN2llV1FnRTV0MFFSTGs0cEN3SUpxNHNHRFlORTNibFk1WUN4K0txcnNT?=
 =?utf-8?B?cVJScytxSWZJc055Uy9lVEo1b0dycFdodS9rV2YwTTV3dFh2RTdvYXRQa2xD?=
 =?utf-8?B?S1BuWDI2S2VSQjMzZE1FZitLRHZscGFPdkIyNWIrd013d2h3aWVuOUpHVm94?=
 =?utf-8?B?MkZRK3YzQ1p4TFVXRm5TYm94Sk55RUZmVytqaDVQTEdRMTBuV0pkbW9FWEIx?=
 =?utf-8?B?MGRKQUdab25Qc01adEFDV0t1SHdtOEhXdGFoK2QxT0hvOXJHOHpHOS8vcnd6?=
 =?utf-8?B?d3lSeENRR3htMU82OTJ5RVNPQ0U0QVRYR2ZCL1hwME9wMGxhN3BMTzAwekdF?=
 =?utf-8?B?Q2FiZG4yMWxYOHhIVnFUZmJwa1NhMWppNmtRUWhYaTJzWExVclZMUkRNVE83?=
 =?utf-8?B?Z1I4dWZHbWtMU0oxbzd4cUNHZ1A4M3YwNDNVVVdscnBOcVZId1l1TjVRYURL?=
 =?utf-8?B?TC9rWnRyTTI0UjRBbWtIRnZUaENNc1ZMbzRHNzRwUWJtNGh2bXh3bWpKZ3dp?=
 =?utf-8?B?SmMzdEt4dUo2Q3hWSXRpdDRTOGVyR29KUkpqWVZUdkVDdFErM1VYbUY1Ri83?=
 =?utf-8?B?US9IM09yWVlEUVpDTDRPNVZUZDVZWDBhUkF3U0krWkZzNmFwOXdMeGxDMkhI?=
 =?utf-8?B?clFuZ2VJb0dpdlRncVk0OUxuRXRzb001cXZHaG1uZ0dYSk1aNEsxWVNOSnFi?=
 =?utf-8?B?SEVNTE9MSklLL1VIbDRsSk9yZUMwenpTVEFMN3o3cGVBWnNlYjMxZmFJZXBF?=
 =?utf-8?B?dXRMaWdQcWpqK09xc2o1RW1ZZ2VZY0VVYy91V2JaMmVvQ3J5ZzJXL0lJZU1o?=
 =?utf-8?B?MHZvL2RqT1cwTUg1Y2E3SHlGSVhKT0Zlb29oK0tFV3c4ck1vL0pEb010Sklp?=
 =?utf-8?B?QTNMcE5rVloxaDcrTllJS2xMaFdMa241Z01jS09lVi94R2RwWkNHU3FvZTh5?=
 =?utf-8?B?WTFsWUtZQXhrbURuVkMzMzJOMXd3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 02pOvtnmlbmYRxaFEhWcY9I2it04AcHg2pRaMwmoRJQa6u7z7r53dOrSBEOX6LPh6l3WVhsQYgkVAorVoeLxliH6xw//W64qYeEFKF5Acrej/TSKCRMWMdTDc6b45FULjDEEuQhqaMRP3vQpLmrgNFFAEx583Y473ztC9aJFCwhF/+C68e/yv8kmMPyygfRu6ggTCd2yFWZuklOoCjLg4kDzrK3qYAkm1STDk2Ut7JFKUWwDqOxUVncYdaWosUO52pV60PSVc61iZ+ISfv2BUaITcYODpEbhkpkh6uFC6ai/eXPxPFQUygRhhe0Ao7hZzYHnMqTmjNjq+DWugDXAmpme2tYFCYTW53U8KdpGIKnTk4k9+idZ/7dJDvC7V+KeL1FS8Ut5tTH24odPaIv5YloI1/+3gEwOgt9KZG6c8Nia7UrBIP8WhDXqvQTmOY9ybEmN4iUqvmgUIlh97JRaJySerI2bHcY/PZv5VrR0QD6q7Kmy3zqK0h7Uvt35lzjnyVUBurl//0B00lVP+n29izfRqQgw9VcH3npuC/EuplRxGgNRRcJBl9p09bouaiEFb/FUjtrv6kRDwf+43R7Ne9EwsyvdeBBV9j4hQXRwN4Nq/QeyySIVqY3RUs98Xax0JuhKYBR9bf25wqyM2hBug1XGIm65rvLvuCO94/mPFHpxKu9HUoLw90i0fPaeKIAJ4C3m/md6LKahv061v8VzYHNJaXVL6syhpHInxFfa4aQYfKLTtjAn8ekaiVtPyRIDKjtR3r2yeJ/HNAHC7uhj8QaGUE+GSNd4+CYdP9KbKzRTRD6Id86gEyAVFNoH0JNMrxxiA7plhHSz1oFZoTBfJ67mLupQCGoZunuC5bKWtP/K7pdmRqOZl/RDD8AOkz5g7W6pHr2trN4FvItmcAn+Xw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b296c4ae-cc35-4e76-e3e2-08db7e530aef
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:58:53.6235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwSmNQLsOxPZJeWjQHTO9kKb/rcCwaR+0DWMzTRBemXpBovdcxv1rbnOAL61FeAq3AuIVYDsZyken3lE+y1SpxFfqpaqpbkpaCRtqMEF+bA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_13,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=982 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060169
X-Proofpoint-GUID: GaO0j7sQkfop15G8cxVCYNdLj6I5ts2n
X-Proofpoint-ORIG-GUID: GaO0j7sQkfop15G8cxVCYNdLj6I5ts2n
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/23 10:48 AM, Matthew Wilcox wrote:
> On Thu, Jul 06, 2023 at 09:38:45AM -0700, Sidhartha Kumar wrote:
>> Saves six implicit calls to compound_head().
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks for the review throughout the revisions.

Sidhartha Kumar
