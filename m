Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A06468A310
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjBCTcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjBCTcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:32:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDDB1C594
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 11:32:46 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313HnjYq021215;
        Fri, 3 Feb 2023 19:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VQ/7juLVEDQKVHrZgEeI1QFro7ZosEx6TFdjYQ0cpk4=;
 b=obbZ5rj2AiERv/KJNcy5Vf2dzQESkpc9E9dNNNVOlKfklD+q/oaqiLEykEaQ6t1wVp6J
 lCh4sgeIlPtfvOSWAiEwT1ei+GM15bfoy+aytHQRU3B7GAHZcPQ4ktDUIZMtaDpczT9O
 YwkFMxPAMTxdImKXptl2ZUkluPdMzYb43X7MVob1yyORNP3ML5Kc3nV25jcyz3P5ud8P
 kkP6WbCB+aZIvctMYzoigIhEDKQ3O0BzaNlLZXHN9J2HGU5vIBORVZh+n3lgQ35LGGZ3
 czSB0B/NTZYt7/DHOhJsz6mdaQ//bGKb6OooPxpkFI3GIJFdwJNQ8YF6uaXX74F2+7Cf JA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfkd1xwrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 19:32:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 313J2xrv034242;
        Fri, 3 Feb 2023 19:32:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5hkaaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 19:32:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi9ADMh8FRN5LE5t4iqltWiI8oRt6gaV+FZ8ZZk1cS6v8UvtCBfOOEri4Yi791MTVZjDkp1iAXz5d6hzlB9dh1QJOXlNT44KMKAz3jVvpG46wLq0imrieke89JRoTWmuCIoLY4S7bYHaAzaClHDCimgDKl1p0dru1qKxKHGEJ1KHG2R0U+WwgRPw+w/jZZ+Anc/fur9ytiKc3Y59JmKLrrWkqcA9X2fdai9BFRSJOpRYs6YZC3Z08CsKLhMr38I/ByK+zMm8E07bEvIMAAtrY9H4pTBPRaVNRUEVayY8X2HSEzXeo7iO9ZME/QQniyUsu+gV6ijZoUqVkbNs9smUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ/7juLVEDQKVHrZgEeI1QFro7ZosEx6TFdjYQ0cpk4=;
 b=iG7Drr0BIUqruS+lNt5sf3Xr0OoSdOL1PkmEKHgRnROzlPHHPkyCXAw8xN8y/NHLgvKcYwvFZPfCLv1VRk4DjOpFdqEy4wZTVp96tsfu+en6XBrZV/YmVriNtPh5mc++oZKVHsriEbQzDRdYPoyQPbXx7tCB4iMZHr6wUdYPxRexlBmoH6sc45PMXnKrM7DGOeOtVNTGNRkQEhnrF1kBkwanHWhAZZLQewB4+xhOJuuhCZk7yiy2d76LhqLe0+iVkScMFk5XADUeKPSgcoejNHEK5qPHvId+tPvoO0U/YKDvQ9LVwrMTdS2mTdTP7TG+eF/ZbNoKXIgXrT9F1lWizw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ/7juLVEDQKVHrZgEeI1QFro7ZosEx6TFdjYQ0cpk4=;
 b=PFURvW8v63oxKhfsyTx+oWPK0zJ2NJAutZIrAe/k366FfUk7HvvR4jzvv+ntrPFSMzE73WkagdyGH62uHN94azthRR2egXEgNsBg0X/Pz71Bjwa26M2ZIEBrnHKK455W5W4AAUi9cEtRHSvvWxBICOxl2PlAJW63ZXVF0rbXO04=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.9; Fri, 3 Feb
 2023 19:32:37 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%6]) with mapi id 15.20.6086.009; Fri, 3 Feb 2023
 19:32:37 +0000
Message-ID: <a497f7d7-51c9-849a-49a3-0a509476e4f3@oracle.com>
Date:   Fri, 3 Feb 2023 11:32:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 5/7] vdpa: validate device feature provisioning against
 supported class
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, parav@nvidia.com, elic@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-6-git-send-email-si-wei.liu@oracle.com>
 <20230203025523-mutt-send-email-mst@kernel.org>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230203025523-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::26) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH0PR10MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f78dff-74f0-454c-c361-08db061d680b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wug7GryiwqTIIXDUuSzQYfOer0CjOgCY0Uqa8NeuRd51FnpmxfVT2x6q7e8enOo8lsaONa+Wc1Zibav591eC94LmjfDzdtVLBatJywd52o3Dks1MlbpOcaTD3bNfcGtozqFrDi1mv+XahD8RZLC9OOFuwLR6a/oKcAxpUPVS+87PuGeMXaHrrlTFRaUh7+ImrGO9aUKwz8cCww4h27cwPAEqJ+t/iEZPadncKBrU33yZwZS+Cl7ByNQHlXOQD58JCbu5VvO4nl2/KGvRDCidUAvVe8mAMaSdWiboPEv/pj+1dhen6JreSJGGKONOOKpK+YrZWVTNv9I3CVJcY6jgOxwP49mWdjOpXvlgKaMt19ACXssj9PMFqgkkIr3AaEkbcfHwvD119Of+HQ69zshJmYg/LjmmrosM/hMajU/Avbb1HanG5YJ8LvPR788MsGaMj78x/6RugTsODFIjjqmF22AtvhmZVmD8sR7aRBW6qi7drs9/7W5O4MfzjP2GN3Z9impi1k6+pOB6s7sARW+PYsIw+KfKKH51a+xeHsQ6Rz4/Cw/9sQ/UYj14oFR58VCMV2SyVQTyYzPlb74as+QBnzP5RpgeU657sG+IhppeKwo2kR71DYttm3YY3sEn51FT33M6GgeNazlQRldXLzDfNBe8f5u07xUso+bS2FHS4TbVILeQJxgaYnZ1OimdVxsdHasMvV81boRPdlwHstXIPqCWv2EuRQFNXir02M9ZfBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199018)(31696002)(36756003)(86362001)(38100700002)(41300700001)(8676002)(66476007)(8936002)(5660300002)(4326008)(316002)(66946007)(66556008)(6916009)(15650500001)(2906002)(83380400001)(478600001)(6486002)(2616005)(53546011)(186003)(6666004)(6506007)(26005)(6512007)(36916002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N01uY1NmSGpKV05KWDlWZEhtVWtEY2FHWkgwOXNxREw1eXY4MnVVUEVhOTBr?=
 =?utf-8?B?dlByZUwvd1hqb2ZLOGhIT1NJd3ZBRFFrTUNxWG5rcklmdml4V2IyYUZHTUMx?=
 =?utf-8?B?dy9wUyt5YWpJMFFrYWxpUWVoSHA1QVA0clF0b28vV2JFcDNQcTUydG5HNDkx?=
 =?utf-8?B?MStyY2RmMFVDdDk1dWhLNlhoNTBlTG5OUlNVdTlYMGFLWFdhQ25BMUZleXVr?=
 =?utf-8?B?UHZHMzcwaDREaGxmRjNjSWdVbExXc0FycEtvdDhhOXhjK0VqMEN3SEc2Ync1?=
 =?utf-8?B?cG56ci9aTGRQaXFscDVpUFpuT0hzRHk2QVJzcmJsSlhueHNpOTVyVmdLYU4x?=
 =?utf-8?B?SHpDM1ZQRHJYMDFDOVpXVTlxVVpWd2dIcDlmRzNhOXB4d1ViNUJUR3NRd3dJ?=
 =?utf-8?B?N05uVmQ0WjZyazU2YjlyR201bzF1dW1WdFN3eWhuNVJZVUIra1BOQ0RJeEdS?=
 =?utf-8?B?V09oNnA1Qjd2QXFVdi84YTA2TTJ2OUZXU3htYWZWdThDZm9Ba04yZHdwSUlU?=
 =?utf-8?B?QUF2OGgxendScCtudEpWTU5xS01nMGZPcFFYL014RHF6NURrNlZ4dFlXS3FE?=
 =?utf-8?B?Ti96U0hBM1VXSVdBc3o2N3BnNGhTWlNWZTQ1aFBKcVoxZDd2eE1kSm1ROWY1?=
 =?utf-8?B?ck01OFczWGk0QllDSHpMSzBNYytTVm1aMWNEaXhhV3FFNmJVREw5N1FsRFBa?=
 =?utf-8?B?b0lBampzMmJyM251RVdMc0FlMEFqeEhyOCtjMEs3NkpHZmNqMTZhMGNIU1Fs?=
 =?utf-8?B?T2pWRzhqMzlEWmN4RjhiU2poYWpMbHZPckwwbHBqV2MvZEc5cDVnaEF4aVVH?=
 =?utf-8?B?OEZHdGdrWWtabGw1bjhBSE5TaHZkYWlyc0JCOGhGYWlGcHo4VFVxcTY2alJi?=
 =?utf-8?B?MytiVVh1UUlWd3FZbGtoTVFISnZXcS9YaWRQbzAvZ29Tbis0Mko5SXg3MEo1?=
 =?utf-8?B?NzNsKzJPUGtVVDROOE9PVmVHNDk2RGMwU1RLYjFTeWdwelFPZ1FvMXQyQy9L?=
 =?utf-8?B?bmxkTXBENmRUWFduYjBVTWJKTUJuOTFtcEVJNG1sNmc0QTk1RXd3ZXlPK3di?=
 =?utf-8?B?ZGVJMGtCU2VnSDlxbEZLdEp0U1ZVaFhGTmErUHN3aFBVZEQxS0NBcmIxWnlI?=
 =?utf-8?B?czR2WkhUYVppclFWYnZzelo3cFRtSXo2SmY3cjhXd2pOSCtRSitGUHRzS3NL?=
 =?utf-8?B?YXFYUXNjNVhGSHFsQXN5SENEQmdpOVZhaG04Si9WdlFrUjlpZmdjNzlZYVBS?=
 =?utf-8?B?dG4rbGsxd3F0cXdON09DbXU4bFdBV2NMTWtrNm9ma1pLeVM5NTRnSzNOVDVu?=
 =?utf-8?B?Q3k5aE02UjJmMFVWZ0NWbWZ1aTByTkF3eDBFelhWSktYQk1TT0NOeWpwdGVt?=
 =?utf-8?B?VzJQZzJmSmh1aGNJc25lcElTaTcvb1QzRlBJOHByQnRyT05Jdm91SnJGemw1?=
 =?utf-8?B?eDlZM3NDVS9zRkwrc2ZiODg3ZjAzRHJpMmIxZ1B6YSs5RkRTb2JjNk5vaTk2?=
 =?utf-8?B?aUk3UDRPWG15TldJN0JzWTdzV0ZNaU1ZSERHclh0S3JwSlZvTVdsQU53U3Nr?=
 =?utf-8?B?T2RRSE1Kd2I2dXNkWVJaR3RKQW53TW00UVU5Z3lSbUNVclNOTHhkSE5tRGE3?=
 =?utf-8?B?Q3V3UXptM05ndmYzbDRHQkJBMHRDU0hHRCt5a1JSZEhkL1c4Z0pNQkV6dTJM?=
 =?utf-8?B?VnZTZVl6WnY0TUVhbllXZytPVkNYdm85bi9UVlFVU1NzcjY5dS9EY2Y5Q0NY?=
 =?utf-8?B?UmdWNS9vanByNVJBN0pMckdBbnZXQmpvUHYzQ0pmZVVmVmlCS0dKZmJpUjEz?=
 =?utf-8?B?eC9KdFJuMmJ5VWJsYzdTRU9ZSDJDMkxKNjYrOUU4dzlhR1k3UytvZmZZWGFK?=
 =?utf-8?B?c1V3QjBadnVST2E0aEppa01DZU9HUXloU3dIdm1STTZNamIvOHBINjhpcDVw?=
 =?utf-8?B?MTlpWGhCZ095MHh1YVdkTVhlbjJSK3RIVDAvWkhPNjAvYnJqK0ltdFRBZVJQ?=
 =?utf-8?B?a1FPN0FNSERNeVMrWjVhcEloM2orbTFnZURsbUx4WmhCb0lYM3RaLy9oa3NP?=
 =?utf-8?B?R015Q2NMaWRLb1lYZXN2ak9adEhMQnJiNHhTOGtZaUpRdTJOT0I0OUhyY0Ro?=
 =?utf-8?Q?hhMBvcpYJkoD8/KANcvMlk4IC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6GsAgwMVugyd4SLAweReVd1zuH/LckxW6WmL6XqfmSZ3MIxUDIZIMFgZbeYQ0ycpBGQCScP+o/iQVZgZv5v45ZculUrX0LTGp7TZ0LoQMTIq3+cdGMMUiYMc7AG6Lo/+LqXY6u+r3IjHQAFzjRyxSw++F91TgvtHsPY20JKb2EjN4YEqwUicWxDLBbaGdLzlhOLHSHbdBjmYyKrCy6FIyAahBfHhXvQAzn4OCt6aFbQX7JNRu8AD5nKzC5QTCIjYK70KkYLVgb9NoroZ7ajuMy5T1t+EJa3RDMZrPjaJHXwV5dB9C4nflwj8aqPSNMORB0fbcuYNHOkRWcWY3/Pp7SOzpA2uOuJoP06r6Eku3JLNA6J4k1ko2g0XS8L9jyztS8jZz3/fnupr0h2zwr5MiOGfLlBu+PQCFJ8VBk78FknqZYBt5oHVb9Wh+xGiCA2DKzCn9Vf+pfVKeOTsu7zoIIpBnXoHh50TVBVI08t3adP9agOLE9/CcCJU18y7zCEk9sgnvw7i4NlD4weHEq0rWqCePqN+8jnaWEhPnVjfJuHGzczcmrUaOwlY5LjhW4ZZh09GgYYTf1JMMDTQzWM0g5WlITKbggwbAIhydJoZf3kc80/HllM8cLFAgOSUf3tMrGDDpC4ZWlEJmIrpjyCVvKS2vJpoP79iIJu02Flw3Z1de6RmcRqv2vx9ghqakH3HVAzAKlIgvlND+C+J+2ueMpS8RuNKUJAZRmydUFOxRzf3K7ewYh7HBgpne1in6rjzoCtt3RIbW304ms4DowmUXA4NnKLN7rSp/qRMExWBTGpOLcLYaXsjd6a4qfEWxwV9EWH5prAo/VF1fQsqWcHdSIdnWqaZp0q2NkhFFhZj8n2UD4CPpAEGnAEnxargYHPki9JDrLm97rQUZG+5P17xCw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f78dff-74f0-454c-c361-08db061d680b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:32:37.4364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiWb003fdzugyEOzgnVNERoCN9HUmChFvJft/elYAEhF2USVyQDGd7+2q8ie+MunXnpx2ZwHPUkawtDKTizrDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_19,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030178
X-Proofpoint-GUID: 4j7_wcXG4YVjjePRa3JzSqOac-h33A0q
X-Proofpoint-ORIG-GUID: 4j7_wcXG4YVjjePRa3JzSqOac-h33A0q
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2023 12:09 AM, Michael S. Tsirkin wrote:
> On Tue, Jan 31, 2023 at 03:22:23PM -0800, Si-Wei Liu wrote:
>> Today when device features are explicitly provisioned, the features
>> user supplied may contain device class specific features that are
>> not supported by the parent managment device. On the other hand,
>> when parent managment device supports more than one class, the
>> device features to provision may be ambiguous if none of the class
>> specific attributes is provided at the same time. Validate these
>> cases and prompt appropriate user errors accordingly.
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   drivers/vdpa/vdpa.c | 51 ++++++++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 42 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> index 1eba978..35a72d6 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -460,12 +460,30 @@ static int vdpa_nl_mgmtdev_handle_fill(struct sk_buff *msg, const struct vdpa_mg
>>   	return 0;
>>   }
>>   
>> +static u64 vdpa_mgmtdev_get_classes(const struct vdpa_mgmt_dev *mdev,
>> +				    unsigned int *nclasses)
> given max value is apparently 64 how important is it that it's unsigned?
> Just make it an int.
Not sure I understand what you really meant/want. I consider making 
unsigned is a (good) habit of keeping data type consistent to ensure 
non-negative value is returned so callers run free of worry for false 
complaint from (dumb) static code analyzer, and the next caller can 
promptly interpret possible range of return value just from the function 
prototype without having to dig into internals implemented by another 
author. If your intent is to limit the range I can certainly make it an 
unsigned char or u8, otherwise I don't get why you think int is better 
than unsigned int. Does it not conform to the coding standard documented 
somewhere?

> Also I'd return u64 through a pointer too for consistency.
Here the intent is to make the class bitmask number mandatory to return, 
while the number of classes returned can be optional. If there's future 
need to optionally return bitmask, the code can be revisited for sure. 
For now I'd just keep it this way for simplicity and readability.

>> +{
>> +	u64 supported_classes = 0;
>> +	unsigned int n = 0;
>> +	int i = 0;
>> +
>> +	while (mdev->id_table[i].device) {
>> +		if (mdev->id_table[i].device <= 63) {
>> +			supported_classes |= BIT_ULL(mdev->id_table[i].device);
>> +			n++;
>> +		}
>> +		i++;
>> +	}
>
> Better as a for loop. I know you are just moving code if you
> want to make it very clear it's a refactoring split
> as a separate patch, but ok anyway.
I can make it a for loop. Generally if just moving code people tend to 
keep the original code as-is without refactoring too much (separate 
patch needed). But for this simple rewrite it might be okay, it's your call.

Thanks,
-Siwei

>
>> +	if (nclasses)
>> +		*nclasses = n;
>> +
>> +	return supported_classes;
>> +}
>> +
>>   static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *msg,
>>   			     u32 portid, u32 seq, int flags)
>>   {
>> -	u64 supported_classes = 0;
>>   	void *hdr;
>> -	int i = 0;
>>   	int err;
>>   
>>   	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags, VDPA_CMD_MGMTDEV_NEW);
>> @@ -475,14 +493,9 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>>   	if (err)
>>   		goto msg_err;
>>   
>> -	while (mdev->id_table[i].device) {
>> -		if (mdev->id_table[i].device <= 63)
>> -			supported_classes |= BIT_ULL(mdev->id_table[i].device);
>> -		i++;
>> -	}
>> -
>>   	if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
>> -			      supported_classes, VDPA_ATTR_UNSPEC)) {
>> +			      vdpa_mgmtdev_get_classes(mdev, NULL),
>> +			      VDPA_ATTR_UNSPEC)) {
>>   		err = -EMSGSIZE;
>>   		goto msg_err;
>>   	}
>> @@ -571,8 +584,10 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>>   	struct vdpa_dev_set_config config = {};
>>   	struct nlattr **nl_attrs = info->attrs;
>>   	struct vdpa_mgmt_dev *mdev;
>> +	unsigned int ncls = 0;
>>   	const u8 *macaddr;
>>   	const char *name;
>> +	u64 classes;
>>   	int err = 0;
>>   
>>   	if (!info->attrs[VDPA_ATTR_DEV_NAME])
>> @@ -649,6 +664,24 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>>   		goto err;
>>   	}
>>   
>> +	classes = vdpa_mgmtdev_get_classes(mdev, &ncls);
>> +	if (config.mask & VDPA_DEV_NET_ATTRS_MASK &&
>> +	    !(classes & BIT_ULL(VIRTIO_ID_NET))) {
>> +		NL_SET_ERR_MSG_MOD(info->extack,
>> +				   "Network class attributes provided on unsupported management device");
>> +		err = -EINVAL;
>> +		goto err;
>> +	}
>> +	if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
>> +	    config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
>> +	    classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
>> +	    config.device_features & VIRTIO_DEVICE_F_MASK) {
>> +		NL_SET_ERR_MSG_MOD(info->extack,
>> +				   "Management device supports multi-class while device features specified are ambiguous");
>> +		err = -EINVAL;
>> +		goto err;
>> +	}
>> +
>>   	err = mdev->ops->dev_add(mdev, name, &config);
>>   err:
>>   	up_write(&vdpa_dev_lock);
>> -- 
>> 1.8.3.1

