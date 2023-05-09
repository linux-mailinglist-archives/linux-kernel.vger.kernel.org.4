Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F396FCAE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjEIQN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjEIQNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:13:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801344EC8;
        Tue,  9 May 2023 09:13:37 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349EV7oc015007;
        Tue, 9 May 2023 16:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=v8Bm3nUdhdNWLiBspGFsV6eACWdMlnVoW78pjGUndhc=;
 b=SsJkzbo2DeB/kYWi5ah4AsfV7xiqgU+QBRWHh0sxZTd7cq46BghaiUwdBL/OyuCb58QH
 Ntjms9WEzK9dshSQtrMn14dJaI6pFSLxBw/hQhX020DZlCZ2T6i9ikX5ZKo2ePvMK1Xd
 05EhOmOLcAxUe7Jc4xOZZBVqG3/iuWyQ178rHV1fu+msPIY9aLROqNVaACQQxPReU402
 YFdl37rN642ilddbua/PqkPBXvtEc4gIkwWcki3WLLf+gRIa5tU0yNeN1/kUjjp3rKmi
 TbbR9/qc6WSiM0wsOFbd0E4u9eUcsYcQAPeS2kZCPouKVTtOXwmlYAvrN5Cr/5psmeTZ IA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77daa3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 16:13:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 349Er4km002134;
        Tue, 9 May 2023 16:13:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf81embfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 16:13:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JF7cSJ4pAdPzt4z2karAURJRqZ3ovOpwHjzU4rRNYoGrhpIHTxxalb64wVQLIQm3/Q1iF4nntc/WCHyUMFyIlk+HH/2LyvF+ccLToACMScRVy8z9uU33B5bsOb7tM2M23bcFcwr0MKs1C/bCljMkhhv3eIDAunkiOomVnnJNLFysu/lafjpXuSkVk+ZEkko3TY7LtvWQiBfRjLxBi5p41uYuyzZO4eHqDM30e+BoWL+6F/d7Og1AfC5e68rV+LtZ0B7LDZqm1zplBd4aOtzG7qwktkBooAXuJS/ZhdnCtjv0XAl4F1jR5McxaMNKr3GI8T4LvdR3toZofxLILIA0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8Bm3nUdhdNWLiBspGFsV6eACWdMlnVoW78pjGUndhc=;
 b=Sym++FElyZmX07B5aCuujqwpvEql3ZS/0wRARm8TzHY/PvNNxwWd5jfo0Ke10daDC73CB6vdZmRwwa8esu3x9VLfTXvWZVhpspmnm9ckOTTFnM3f4MIPKHuB32qIdN9g4ii3PnSxFr7SFk6bBpW8udX7pzvOf7uMKRd8pIzGqARtcvZ32eCccZXwsfoJ3r5mLHr3QOlhhpY9VJVRiYw3keq/7eRSjtp03dPF1Iz1EAWNOITIfuxI0CGmeWDwSYG7f7L+CyMG0xVFIDUrqBUY/MJ8XlsIz5m+kIn4PjTTvCR0kUWOLtUsK9a4gtGUQVujb4vJeiEgfDdNolPQC0916g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8Bm3nUdhdNWLiBspGFsV6eACWdMlnVoW78pjGUndhc=;
 b=Og1hVVr4IDeVdTcSUivr4/iSwPi/mbiwNZLa21aZmfgCwcULVk1ktxjflISS9Xkp0JwnB6QZsRa/zFTc/fzjmRuG1BmZpYKA91IFIF9AFpdxzKG66S5i4Pk2LzHIC3GE0IMSIt0lavGSrINV1QpSXClD37oozX2Ekyo6BQtV7ts=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by SA1PR10MB7633.namprd10.prod.outlook.com (2603:10b6:806:375::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 16:13:11 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c%5]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 16:13:11 +0000
Message-ID: <afeb0ced-e4e9-6039-893e-b50268c1c148@oracle.com>
Date:   Tue, 9 May 2023 09:13:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH V4 2/2] blktrace: allow access trace file in lockdown mode
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-block@vger.kernel.org,
        nathanl@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        konrad.wilk@oracle.com, joe.jin@oracle.com
References: <20230420215331.88326-1-junxiao.bi@oracle.com>
 <20230420215331.88326-2-junxiao.bi@oracle.com>
 <05b3eebd-7a3f-13d5-1fe9-8f4ab3080521@oracle.com>
 <30ab7555-8f36-cfb7-9101-0ebb92af3c2f@kernel.dk>
 <6300a33a-9d3d-42a2-d332-81e02d52d310@oracle.com>
 <CAHC9VhT2uCc5ePi+ung+rLaDiLCCCF=fjq8G+D3FJf0i4E8_hQ@mail.gmail.com>
 <f016d747-c01a-c46e-59a7-13d0d6306827@oracle.com>
 <CAHC9VhSCjuJZ122EqdDxzJTU1tGq5nU_3+11WGKZ-WHjzU2FBw@mail.gmail.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
In-Reply-To: <CAHC9VhSCjuJZ122EqdDxzJTU1tGq5nU_3+11WGKZ-WHjzU2FBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::20) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|SA1PR10MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: caf1ce2c-a93c-4670-f64b-08db50a84907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ce/EW2iOAqUVi9JlRngkbEz1bEQeRRR45+dlebauuL5rdtQ1E/VNoqq1RfZ22sDK41QnvulLyiYYXM+mKBoqsBdQTmNwFw75eiNsBtjrSfNnzMti1dG55cYWCe+s4cx5OLZ/bb09vo3nln3f3W1Oa3iYXdHk450ZIEN1r7rj7alLbmEAtBvDe2bCABXuEj7jCRhLeWFnyTRBnJVpjAxwE1ALq55pHbqm+09uLMSPGVW7lLMYtlZC6eJptz9ksVMwfhzbK22NaGspOEPPeNgYoXrckOF4CeqFAtBI/bFsn1KzClieJLOD214EI1AZ8Yyq/h1EPCon5VW88F+O6tjbv6Pfsi3Xv8AnL9ij30hjcYrFfEJUJdKmyZcqO9j6+rpKZvplZriqeUSEA//OJGDOmDvi3m6XSFnby4TzjcvjkzmggU34T8ZZHY01BSfybBWcqVSsy/DDdb9+a76nH6oR5Xdv2Qd507jeq9A1ANMX8J9ocGTHW5NG5noSW8kgPFKA8rDO0MX7UtE1+7xkovUe3nniNKNEZ6msajSNijyRbUVwVuHCiAKuTsvoIPzGH0Jlp8MsQhpgOpmD8BAa7AzHC9OiO+9qMUy25TDO1FrlGKT51V1aK7588Q4trqBbzxmBh4l6W1ie3JSPJakqrSDpaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(136003)(346002)(39860400002)(84040400005)(451199021)(6506007)(107886003)(26005)(6512007)(53546011)(6486002)(83380400001)(36756003)(2616005)(38100700002)(31696002)(86362001)(186003)(44832011)(316002)(8676002)(8936002)(41300700001)(478600001)(5660300002)(66476007)(66556008)(66946007)(6916009)(4326008)(31686004)(6666004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVBFWnNVM3hsQXFWNmRmMmdLU2NRckhjRTJvVU9ZWVZjSTZIQmtTL3lrbmJS?=
 =?utf-8?B?Y3RyUFRIZDdYblVHa3V3QU1yU3cvRWNmR0pub1VvcFhKdjFQVnZ0K2UrbzE3?=
 =?utf-8?B?T2lJQ1BsVU81SkFwOGhyclQ0ZUxMM3gxRmViR0d0c1ZnekFQWUJkaWxzc0s1?=
 =?utf-8?B?eHRKNU43Q0N6aEFjQS92SVNZdjNoS3UzYVVJU1dQaGdwdERPYnI1QUlyMTVD?=
 =?utf-8?B?V1VCcTVOWmYxOG5pSWlTUnJjTlVnZzVpV05DWXJyelVDZnh2aFN6eUdzdmgr?=
 =?utf-8?B?SG9hTTVwbDlPUW1IQ3Y4VGhVTGhKN3ZDOE1MYnVhbXJTdmxEa250UXlTRnQ5?=
 =?utf-8?B?ZXozMFN1a056WnpEZHNPN044cmRlcXl5dEpIaHhzOWJ5UGFrYlZYR3N3VjIx?=
 =?utf-8?B?TVRkK1llSkN0Qno1WHhxWHN1V3FMeEY3NXlBOFRaNHJKWmRmaEJsYmdaWjB1?=
 =?utf-8?B?MDZaR3RVSGFNWklvdHBWS1hYT2R5NjNtb3A4YzlsTzU0RFEwU3EzOForWmF2?=
 =?utf-8?B?dHA4K3ZEZnJlY2V1R0hWMldmRDBWa3puOFpsMEdtYmo5elRBcEFjWjFlcWdn?=
 =?utf-8?B?aWJLVVYrRzZ4Rmk5MW1UeDJhbzFzdWtmOHNpVGkyam5rUENRVm9tbHNmMnQw?=
 =?utf-8?B?K09NVnBwckNROXdWaFZnc0k1MVFMSWxkcFIremlJNVpEaGlCcUxpYjZWTXZi?=
 =?utf-8?B?cC9XTnI3bkVTK0YyL1dxOHAzLzMwTVpjU3JOTld4YTdOVlpLZ1p3WkE2NExC?=
 =?utf-8?B?ZkcyL1dkcVdIaGRxeGx5Q2NzeDlVaWMzMEJlaXE1dFNkRmFxb2pVdWNnR3RD?=
 =?utf-8?B?dWRXL2NqRjhvU3hoSk5rNDRUWnpNQnQ0TkpLaWJHeHpHWHV1bDAzajQxV2Ns?=
 =?utf-8?B?b1lYYlFTSnBEajRUSEFDOFpsY0pLcFMza0MxSElsTDBCRCtsL0dsRSt6by9l?=
 =?utf-8?B?T1Z6bFBUTm9SV2c0alh4cVd4eWdJdlRIYkRyd1VhdUFuTXRTZzhsYnpCaElE?=
 =?utf-8?B?MXFWODgyYVJJYjlRdEQrd2lWeFZ1V09ZTkxnNE45VGl1RUZ6YlNYWU9SNHZW?=
 =?utf-8?B?aTh1akJQc0VrVGRBZVFwY1MxZ09kMllwZG0yY0RDcDk1QlRGWmdxRGhRSnBh?=
 =?utf-8?B?ZmxDZFpyeVpiTmV3VU1rMFhBYmczMWFEbGZEb1R6REhwZlJZTHBHeThuUXUz?=
 =?utf-8?B?WmV6TzFqbkplV0ZER0V6SU8xcStZa1lrUDVhNDJjSEJ5Tk1wM1o3czFncG0w?=
 =?utf-8?B?YkU4S0RmeWQ5WklmU0VnYTNVU0hGMHhLRTQwMUQxdlJ2Q08wbzkvM2YvSTBa?=
 =?utf-8?B?UjRxcG83NC9jSEoxTjg1b21sT05iM251YlZJNTg3cTZaZk9JN28wWGt1b0Mw?=
 =?utf-8?B?WW1SRmYxQnZubnd2Wklzc0xpbWlPajExOE1tb2hxcUVBQXZiV0JoTTF0UWo2?=
 =?utf-8?B?OWU5Mm5XRENYWWN6OTE5TjJiV2h3Szl0enFCdWJUZG41dDlPemJHVC9QV3U1?=
 =?utf-8?B?dlBHN1NIQnhzQW9XdGtRY1k3dTJwaHZJb015ZmdaTi9GaEhCb2xUcnd4ZERa?=
 =?utf-8?B?U3JqU0RyaWNRNm8vUzBEVHVSN0pFMXJjaENDbXVNOXBRMWRuNTExMmt4eFln?=
 =?utf-8?B?ZFBqQm0zOTU0OUZrTmxlRmpBQ3VZbmhNaGNvanVOemQ5VGFnakFkRncva1No?=
 =?utf-8?B?K29DdEc2UnJxQnpVRXVrU1N0Q0U2YkkrcTF2NGgxTFdJZzZwRG1tbklsVTVH?=
 =?utf-8?B?bWJtdkJvWHQ1NC9ja2lXK1VjR1RIVTd6NzNIRmVwZEh0bHdQWFBmc3VYYnIv?=
 =?utf-8?B?RzQxcHlsYXRFS1BQRzhOS1FHSjRXRnlsQnJKNkVLNXVtd2F1WjdsYkc2SU1w?=
 =?utf-8?B?TnZzQVBvZTNHVjNrajRvSGF6b25ZTlVzODFDb2lwcFg0bVpkdWliYkxrVzBm?=
 =?utf-8?B?NlNwTlIrL2lqSnBKQThobXh4dHhNWk9zaW0yYzQ0aHNiVW9GbnNEeWkvRXRk?=
 =?utf-8?B?VERQck0wVWtobmpBVXhsMXVJV0ZVaU5vRS9zMWl2eEsvMjdHYjV4T091Nm1u?=
 =?utf-8?B?K2ZIN3Brc1diMXJ5Y0Y5ZTY2S3lQeFB1eDhUSnV0andpcy9sVDhORmRCbE5D?=
 =?utf-8?Q?o+l4qo8FkTqnbpSXDbjPQA5OY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oNsoO0S6Gx2/dYNTKYGMTpOxivdza5AnRwSiTRSo1B0nUUctOh/234tPqCuCKiDwaORF+JMnPq1ZdKWiXeR4qJ140j4Af0RVQf6jizxz0t52jIqDThfQwrBTeC6jt7bzDTj3R+62mhnD2HVaQUF9Y2RkaiFywA/KttuFb2RzBFQv9a5ZozZG6pC0r4PveC7xLjDda4V7J3SLS6KEgrnWGYOLWG+V0ccSpB9yK8GxjQK6ahWdO6oUhBPfBtIyNb535sI+cfF2OaWavMiG7aH/rtmVv7AzGwdTmCJekR1mNUQcaoL2NhJRSedxsoUfDKDNfgfvBbIGevHKsQKVshcXJfXRPLzxQMHC+RxJ3LxaFJHmkOs4FzP05Y24BUo0E8+IWjWH2rnGGZGYJXNp/wm6J3rTqQdsR5zxLwSyynF9/psprrJftpDKBdNFrKvYMFWjEwpgncoiPJ/r+qPNQ9vUodd3zL5YsO+ZXFQDKf1W/OfTtZzT/VlDRiXoyZakZvtGSYHEbrTO1XOE/Zs5k4gpexSDC2EeabVMx8Hv1l7LMAllqu19M6gsdVmSHBvWjYwRvPvBNrr0waL8JyKvscUiHK+Qgmf67dfICasGPWMJlrf+9ftFSJa+adpNG4mBPmGrU6pxnbTGw43N8ELT+zkY8qr3nkGgA/pWAcuRErj6j1FQ0sDPjAFNIWcPWgVuHGoFIY/Z24fA4rDpTe4903xuvLjBWSlTyftGL66TO1fLzBa4i1CY4LrfQeDgoFnTJiKFaL8YKGKWYIff6OuHzEfzhLOKSVLBFnycs2G7wSgTIWRbLb/NB2Qhg2r937QIOJS//ch1RPT09l6SdJ8caHdZ1fWwcPFL1yKuEFAxuabE8oKyp3d8+6EKW+LNf0GkE4nSSGZg7jvSgrcOXCZtrwrMa+2zzJFZtnf4aXeuIWlvZjw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf1ce2c-a93c-4670-f64b-08db50a84907
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 16:13:11.5826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJ54mFdloj68lhlJOC6juYzHQAAVV1Vd6ahD+14qGJqjaC4cGH4J3s18R1V3w4odHSfXOJY6vTZeN6OgxReS6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_09,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305090133
X-Proofpoint-ORIG-GUID: gFLoN9bxhhDsvAagHVMmebeHxOzMfK-6
X-Proofpoint-GUID: gFLoN9bxhhDsvAagHVMmebeHxOzMfK-6
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/23 2:46 PM, Paul Moore wrote:

> On Fri, Apr 28, 2023 at 6:41 PM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>> On 4/28/23 2:26 PM, Paul Moore wrote:
>>> On Wed, Apr 26, 2023 at 12:33 PM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>>>> Paul,  do you have any other concerns regarding blktrace? As Jens
>>>> mentioned, blktrace just exported IO metadata to Userspace, those were
>>>> not security sensitive information.
>>> I think this version of the patchset is much better, thanks for your
>>> patience.  I don't have any further concerns, and since the lockdown
>>> LSM doesn't have a dedicated maintainer I think you should be all set
>>> from my perspective.
>> Thanks a lot for the review.
>>
>>> Since there are no changes under security/, I'm assuming this will go
>>> in via the tracing tree?
>> Should I notify some specific maintainer or mail list for merging?
> When in doubt, the scripts/get_maintainer.pl tool in the kernel
> sources can be helpful.
>
> The results for the debugfs and relay files are fairly generic, but if
> you look at the results for the blktrace.c file you get a more
> reasonable list of maintainers and mailing lists.  I believe Jens has
> already commented on your patches at least once, I don't recall if the
> others have or not.  I see you've already CC'd the block mailing list,
> so that might be enough.
>
> Keep in mind that we are in the middle of a merge window so it is very
> possible this patch might not be merged in a working/next/etc. branch
> until after the merge window closes (every maintainer is a little bit
> different in this regard).

I didn't see the patches in the trace tree yet, maybe better to merge it 
through block tree since it's a blktrace fix.

Jens, can you help merge these two patches to your tree?

Thanks,

Junxiao.

>
