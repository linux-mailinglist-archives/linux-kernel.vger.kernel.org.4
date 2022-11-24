Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A4E636FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiKXB1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 20:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKXB1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:27:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9201580E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:27:08 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AO0jgCK006341;
        Thu, 24 Nov 2022 01:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=aRniqfNgrep21Cu+exxSh9cVI0SoKyl0BBhhwCFRmiU=;
 b=LoInQF0RFYrerbUJrMlw+YG+mdsQWis30HLy+0W7Rl6RNB1AjCrjqYrfN5fNEB6F4UwM
 /g7xmSgqDkZxs2AlR79vTPvDZdDYB8l1cNuizyIaqxvFCjg9SlfEXi1LGximpTTfQqPZ
 awA/jYQTRRJ7Dj0hWyrDMjKNEljlHrR67LB7SgCTUB6Q68VOIw39fibRU3Y2SVVw2LdY
 CkNotpV7i5LzJ/RQO3HxbacJ6PgonVbBGlDC6nttgRmI0Wdadzc/aL5BGkqHUbD8s31a
 jUpsp2NR7ZBas1tlAqASurikTvdrFS8H5jJLgRFLy6fGsIbSnqYP9BC0uId0syogrKd7 ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1nd89g4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Nov 2022 01:27:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AO0TOih010770;
        Thu, 24 Nov 2022 01:27:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkdvhnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Nov 2022 01:27:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLl4m6RHVy9xgqm4pHqhnS/4W0Vjz1D6eoEFz9TBjoQEmehgjg31izc4SZaj/NuioUWnj0JUpWHmmL0z6Ss6q9hJwcM9bSrJeYb2WZ0Whvu/B1LfVDOpX2DpgT7GX9Vn3NFE5c1kDxh7Ujiu/CAhnh3P1Zx9r60Vw09oxLkiAG6j6Mfv9e2FNTvV/YfkvinftJJOfxHlPLOykdbvYI7gDB7RGQjgX1LFwLm2VwsTXq/BXv8Q/rIt2DSifyKkkKg1PZ6hgiQg0OOy7rYrBjuf9pw2/Q4B2VbPDprfxKd6bjfbCoY/k84SvQqGsAcKLLeZuhhgESgVUEqPRdeZ/+5LFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRniqfNgrep21Cu+exxSh9cVI0SoKyl0BBhhwCFRmiU=;
 b=Rx85RbbX8G2lUtT9dA7Tj4YsEfmoudlR5go2/fJrD/lOqtczTvFPBlnlQoBurFnJIT4vTW1Z69evXAjZwMA2sLFlg7jHy2G8mpSEpPEajAgoSn7FNny4AfAuhZPnAahhqFGk95GnlsD6ATEMlRf9NNkbEbvaYLkAmTmW3AqHa6ZJhuyQcRxddPsEeLiR1F+aNqBIVr9a2J5ST9MshUzZcDxmIkBqY8F+nHpNw0yil6ywgLsk1Q2fPjApyR33+pZsE+/TervgPYA+htevPW47S4gYZopOD8714d9z8Wpyr2k9q5BDDKxysrFrhfwrJ/lsGqDSzhDEUx3BdogQqI20SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRniqfNgrep21Cu+exxSh9cVI0SoKyl0BBhhwCFRmiU=;
 b=UqFAxzb5zwFd7gcI36X7JqsaYtFxS6BJOjogu7fjDuDdQvVG+3JUrtZUjEbu2Yx+rCYMsDnLKVP5V6952l4YmEEbQfT5aysKFDAcMxZX9M+5zg1IPjr0ZHQgrweTSakbHzaH9vZ2VBssFcyMrWqm7ZmNtPchQhqoYPiF3Otoo+g=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH2PR10MB4342.namprd10.prod.outlook.com (2603:10b6:610:a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Thu, 24 Nov
 2022 01:27:02 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::d1e:40c4:40e3:e7b5]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::d1e:40c4:40e3:e7b5%2]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 01:27:02 +0000
Message-ID: <7ff3e8e6-58f8-5d8b-fad2-3fbccfe28762@oracle.com>
Date:   Wed, 23 Nov 2022 17:26:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] vdpa: merge functionally duplicated dev_features
 attributes
Content-Language: en-US
To:     mst@redhat.com
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1665422823-18364-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvpApmF6TFVi8jD-YTYTcYN=zUyvrsxHL8Rts6vQC9EAQ@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvpApmF6TFVi8jD-YTYTcYN=zUyvrsxHL8Rts6vQC9EAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0107.namprd12.prod.outlook.com
 (2603:10b6:802:21::42) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH2PR10MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6ca16e-8273-4e32-830d-08dacdbafbfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6inJolTNsq3k1hBiF9AR5G7/J2rsA4CKfvd0OFpTa+IWktAd2kolUv3aFxnki179PjQfspiBPOpYYvnwIYmawHw40BUAwro/LDI1CzV8zEY/BTXF3Q48n8Pwt20f9pjspQg8Uyx1KUitIVflAIDPJiqYu3xtRZ4SX8oV0DBIrixzYTKOlx/4IfkKgEnqfYvqmytMhQK8weViA0VBqEV4uET9d/A83CvkGv+HwG85MLhctbuqgWSjV1V3mq4AN/VvN146wD6C20DUuCO974BzBKF1Q5tbbKxlFl3JWzlhrj4vwoOTs8pv3Ox66Ree3xLeRzbtsaO0+h9x+VRcE8TIycwEnhV+BlbCLlP3i11lKbpCCkqgsHe40nCFdz/iiOK3eA55+lTGOAvi4YnxbsNH5xzAGU3LjPnnKmncG+gQ/jd0WakXxkSV+uh38vl8s2Ikjtz8Fft8EjVEXj2sExVRElxlWY3HBOqcqF7RRoVFNdisyodgtBZJCJflAV49JZ3KlZARhhyk0qmLElUTP2wxhzGJgn87f7EljCx1607GpfhVEuyhqAHLcVlXts0Rr4MjDPHWMn218o8J2pSgRGEaG582pZUxkuZ9gwvIomQHmUrhHTKGxXeFLZyNov79l2s0ZrYt0DXOXjE2HNS4gQLIkrOtAU0xtkMqfXNpJBAv7hYJIUMhsoSCKex7EDQkm2DaD3caGN5EWOq/xHjPRRwIL5/fWY0q7isljOoT8HKR6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(36756003)(31686004)(86362001)(31696002)(5660300002)(2906002)(186003)(2616005)(83380400001)(6512007)(26005)(38100700002)(53546011)(478600001)(6666004)(36916002)(8936002)(6486002)(41300700001)(6916009)(4326008)(6506007)(66946007)(66556008)(8676002)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjRKZ1JoTkVmQ1Q5TXJwYjhSSUV4NXVZSUpLOS84ZTByQ3NLRlIyMEVEZ3RO?=
 =?utf-8?B?Y21heXlQT3NBSkxKNkZlbHk0bU5zQjFoOUZuKzdCOVJoVVg0TmcwenllTG1T?=
 =?utf-8?B?c2RnMy93WTkva3lJbVk4VFpQenJiSS9SeEFsYjM5NDA1alZOSUlhdGlxaHdO?=
 =?utf-8?B?ZkN0bnNPVjJNS1pnQXBLcVRqbTY2S0hkKzY3WDlYMDdKdEZUVmJob3M3QUNw?=
 =?utf-8?B?cS9xWU1tRzdUL29UNjQxdjJBN3J2cG1XRlR5WHJ0S3I5OHVlMHFWVFVCS0c3?=
 =?utf-8?B?a0FlYk0yaWVoY0ZwQXhta1JDOTRtUG5GRkxkYVF6VjMxTUFXazZtK0Zja3ps?=
 =?utf-8?B?T1AwUXVQVXpjUXBIUnB1Wjkwbi9tdzYwYWlOYmFvYWFwZnNWM1AxNHUwTUxy?=
 =?utf-8?B?SUZOTEMvcGs0bXRuL1ZZQlEvZSt1clV1YWdXc2FpYlN3Vlp5Zlg1bGZCTGgx?=
 =?utf-8?B?N0xlOXRDbXBWN0tyWFR3MTR4bDJDeHNWdE9XT0FlOGZLM210OVFHV3JhZWNu?=
 =?utf-8?B?b0ZCZjFVZTJjK2hNd0xXRlpLUGVwbndtS2VXcGFNWVMrVzhwWm5IbGFZdHd3?=
 =?utf-8?B?WTlRTGx6V3dYbXNBbGxBRVZabDc3UG00R3ZNd1ZEUGhEbXZSRG83aEZlVUdP?=
 =?utf-8?B?bDNXWFZFV0QwMTdEbEVhRU9UNVFkRjhLaDI1c3BsTFZTcVlTeUlVUWQrUmlj?=
 =?utf-8?B?NGxqQ0hDTitBQnN4V1pFbithWTI3RlVXY0xKR29ZM3JiNGt3L0cvYWhyenY5?=
 =?utf-8?B?aHVJVm9KNHM5RGRtSDAzc1dFQzJlMHU3Q2hoMmw5OXBXMU16dnFabVowbnNK?=
 =?utf-8?B?YVF0Rkt6dlQ4cmhXYWdrR0RTMjZNTnlNdy9PK29qeXVaWkd1S0Q4NmtqUGVJ?=
 =?utf-8?B?ZWtscWQ2ZmNSdFhKQ2xmZlhXcEU4ckFWeDM0a1pJSGNMU1p6b21lcld1R1lt?=
 =?utf-8?B?NUhWOW9KUkxaaW1tOHovS1dtYWFHQjBYTGwrL0NkeEY4andRYk1adHdiczdS?=
 =?utf-8?B?RHZNYUtJZGdEUi8rM3ZXaExSTjZsVFZOeTNCVUZnVCtvRzhoVS9LSng5SGJF?=
 =?utf-8?B?cTh2ZytXTkJ5a1QxTVFUUk5jb3p3a0U0bjh3UEZxMG9OWDJHMEJHYXFYT2J3?=
 =?utf-8?B?M1ZQVDdrQjUzRnpUeURyZFRWVTIxa1cvZlRMaGNLemVFYnlqRC9ub1gvYVFq?=
 =?utf-8?B?UWt2S29TQmVqdjJpTzRHVzM0ZWNsN25rSDhHbmpDT3hGMWdhUWQ0WjZPdXRH?=
 =?utf-8?B?dHZRSWh5SGFrNVhNTVB1d2syRVc5cXFrblV2TFlqY0VTKzZpSldSemE0WUts?=
 =?utf-8?B?RTlwUlpaZU5Cbkc2aFJxRnB3WHJhWDhoYzFhQS9sNjJUYkNVcHU3eVRQNzFJ?=
 =?utf-8?B?L0ZNYmF2aURDbXFmakFtc0U2bDZvY1ZYdld6MlhFV2dnckF1UFVOS3NUbGov?=
 =?utf-8?B?Mm5Db2dkTjFMUkFyU2NkNmp3b1R4WU45YWJueDRWS0JRdEJFemtvbDUwM3dm?=
 =?utf-8?B?cHJtY3p2b3AyMkVVWVVhWGV6dnBQN2JMR2FxSWRzY244OTFQelhaTGtYeDht?=
 =?utf-8?B?YlcxdmUzeUxKOW1WMHdMNzBzTGs1SEJ4a0F6eXBieGlQOVNuRE4vM0x4SDEr?=
 =?utf-8?B?YmRlOTUrbnozYjRsTDNHTTRLekdEalNqOS9aWnEycjlnR3NNY2Rkc2VqN1cx?=
 =?utf-8?B?V2gydlF6YjVKNmt4di8rSnd2aGs2SFZleTgxVmRyTGZNaytJZmF0SkNia04r?=
 =?utf-8?B?aUt5RkNpR0M4N3hIdFdkT0V6cjZsd1pnaWhvTEpjTGRkMitUN2xsSnJXNlpM?=
 =?utf-8?B?WFlGaXdnUlhIUHUwN3NCL3BNNk1rUXhBcWtFckVDNGt1VWp0NUZCdG44RWJ2?=
 =?utf-8?B?OW9PN3dpbGlVUGIyMXBUWk1RWGhxcXN1U3JlT1NpYmdibC9UZFR6ZHNialA5?=
 =?utf-8?B?bzI2Nnp6Z0tLM0FYK3NuQ00yLzlWQ0Izd3lKbjh0TTVTN0NmdUdGUHNJYldt?=
 =?utf-8?B?eklFVGNzKys5TlorRzRzd215MDd3ZlUxYUFrVUxrS1Z1YTBsOUNuemlldUZY?=
 =?utf-8?B?WStKR2x6WHBhbm5sckRvdDl0OXVtTitCYnkwU2FTVGsxd202RStOY2NmYTh6?=
 =?utf-8?Q?8qh7R7IvS7nmsQlJ4JLyA5UlZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kGOF/p5uniflyDBI8NiQzmCgSSA0050fnI4v/X2/Z5b+D5icOaImI0FkCD4tnU/xBhlbtHOTaEHMolO7Sboq5sUhxG0HJwx2FSIMxBWDpBMFNcb5Ue8wjHTuOvY2n44i04MB8p3uP4D/W/4v3eor+ffVzAvsdX5wkpbIj6cGGn1EGP5zXOx6XSpnRgstj3edjuK/DUjcVChfs746e02i8AuL6nvhA3A3/HNph5uKFiPFCJWfu7PpXWfX4zpxk9HUbeB/C0C3uAQwtkUL6AENs2s9UC2JHt4o76q7MEJNCK8JE3E4ynKzc8eNipV6nCx9P0e/4NwJ/jB3d7nRJ8mHKg3QP/TuMiVf7bzwZAWb1mJl/Gwen2TWHUUCl15iOFyI0laVTAEQLq8fpAuWjQcaRQ7ryxKtTbq7qmLbt1ICi/UFEOhhrT6MZtrHffRDPlDacy9BZKSskWpYeryJKUYIJYoidst7+0lZ67FJk3qR80UHmenzkkWiNL5ZKV4LTO6hA4PAMDvZUhd+Tu+Vtgsw+WNwepz8n/lARe3cAYnO6G5vEuPiWR5yv29syZOSAma0PB9b57GFVjY1I4FHkYMAuWpZPIgnJjoWw7AHxkFO6PzQcL/cfHRaVGiOFbbXbKqUvUSu2rVRIPon+KiJO1eotd+ulz3DYPt1+yFWD7i35q3pB04YvWEwLxjJs3yu3J/eMX+3Vls+LwtHmR0JdBphKfw0N2cq0HE2ju68/zB9npzkPjPMlU0mW5xdxRlo/n786Twq49j1Xi5cKQEOhfEMwAiMEh0BOWUVqA4HM9NusXGfSPduBG3v+TOSo1tiZSp6edOqmJPhQokTjN/xmXNRV6aoEbJcoPCmI/M0ODBFm59qa9WAjtV0HuhEK5D1BG3M/2PToB6QFL+lCyQCfYuZ8Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6ca16e-8273-4e32-830d-08dacdbafbfe
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 01:27:02.0476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekHXqG30UYagruMFk3XQyg9yIwgOXppFKBU7ABFbm2F2y7OJKSzb9qZe2NFIXfJe5kO2uNikZ6sMJUDwh1qf6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_01,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211240009
X-Proofpoint-GUID: _DQrRUcrB7QfAd-D8djchB3Wo5tJOCUP
X-Proofpoint-ORIG-GUID: _DQrRUcrB7QfAd-D8djchB3Wo5tJOCUP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping with friendly reminder...

Could this simple patch be pulled to 6.1 as a follow-up fix before the 
release? Looks like the VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES to be 
removed had been pulled by iproute prematurely, though no actual 
userspace code is referencing it as yet. Actually it already hinders 
further vdpa tool development and iproute integration around 
VDPA_ATTR_DEV_FEATURES...

Thanks,
-Siwei

On 10/11/2022 8:07 PM, Jason Wang wrote:
> On Tue, Oct 11, 2022 at 2:32 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> We can merge VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES with
>> VDPA_ATTR_DEV_FEATURES which is functionally equivalent.
>> While at it, tweak the comment in header file to make
>> user provioned device features distinguished from those
>> supported by the parent mgmtdev device: the former of
>> which can be inherited as a whole from the latter, or
>> can be a subset of the latter if explicitly specified.
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
>> ---
>>   drivers/vdpa/vdpa.c       | 2 +-
>>   include/uapi/linux/vdpa.h | 4 +---
>>   2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> index febdc99..41ed563 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -855,7 +855,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>>
>>          features_device = vdev->config->get_device_features(vdev);
>>
>> -       if (nla_put_u64_64bit(msg, VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES, features_device,
>> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES, features_device,
>>                                VDPA_ATTR_PAD))
>>                  return -EMSGSIZE;
>>
>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>> index 9bd7923..54b649a 100644
>> --- a/include/uapi/linux/vdpa.h
>> +++ b/include/uapi/linux/vdpa.h
>> @@ -53,11 +53,9 @@ enum vdpa_attr {
>>          VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /* string */
>>          VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
>>
>> +       /* virtio features that are provisioned to the vDPA device */
>>          VDPA_ATTR_DEV_FEATURES,                 /* u64 */
>>
>> -       /* virtio features that are supported by the vDPA device */
>> -       VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,  /* u64 */
>> -
>>          /* new attributes must be added above here */
>>          VDPA_ATTR_MAX,
>>   };
>> --
>> 1.8.3.1
>>

