Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872186ED13A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjDXPXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjDXPXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:23:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCC219D;
        Mon, 24 Apr 2023 08:23:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OBYdRA031321;
        Mon, 24 Apr 2023 15:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ufT8tTHPlDFI8Qp7N/TJSP8CRwkqOa4bFb1EnO/a/o0=;
 b=mo21SoJvtaScyqSGRhZbbt/bxL3acNrMCfsU2Qtz4xiaY7sBRbK+6PrX35b0JfG6YGQi
 yY2iMTSIroC+rbzAcJFiL1zDP78fzBP1gE520xE8V9st743IIsSLeI2CeUAGEbgQY8Yo
 mFTzLcEwEQHLduh1lDEj18ND4XFIwvp3eL0fGRwSGBvTjy1py9HgTLMmte10pB+RlBDw
 vWYkuDCt/R2GV+PR65uF7cviQq5EnJZ7z4QV89lQ7nijftAXGtOFa/73h4vILpMnKZM/
 kt1MQCMe7rPdBVT6Gb8RFDGC/DZ3n1g5SBRaPIeXKe8fXujSt6gss2v04BoYXNWx+IRk Jw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47fak6en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Apr 2023 15:23:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33OEXEWC007340;
        Mon, 24 Apr 2023 15:23:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q46156n69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Apr 2023 15:23:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoRwTx9uARgzru3zqQj94JTjp0n6Hkgf8ivAzXZBOuwFMaqQ9R5t7eMqmSkbGqq3Y9nv3LT4Wf3cxubyEiwlXxvFOkyY9LEOPe4j7PNFYwrjpIXuB607AtuD0pAR0DgGviva1x58j718HMb0vvm0YtobQkB9p5kdpDiDQKSO60+I5L5frOqTMguW1FmBZ980gAjVYvyIopEog9hPiupkTsrh9et3Cg3VCL3UtqbB3kZBFMuLf+PY0ZxMgAfSF9lk0yEd0jEMdIGsC1itui+ChMQg0aApIyqLuVmTRmcwUwdgHbCM+zrgCrbenLk0N34CqX3vnIkWCh5+E1fRBSPugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufT8tTHPlDFI8Qp7N/TJSP8CRwkqOa4bFb1EnO/a/o0=;
 b=BU9tmj65IYV4upLy2xzDxm3hTFZI+D6iheeItb4R1h7EPvh+F8ma0OeQVHcE9ouP07JceoRuqdOLVOX5ou+vmA+NhDVGFqQKbecNT5fgrzP5USmmPmZimDjdZdTgxjC2eSw/9blWFjkXr3gSYfo/xFV0v3O1NRGwsvRK/pY/Z6PqQnuWt6llXbMJ0Rv8vzEIEtcE/wahw/ZaOtZSxffYe/d0yLWea8Mq08eeOxNZJcGnGCKTOzDTZS6sP+CO4ZdEqM769rAcnBtD95ilPTgvJbGoY7mhWHOFk32E75MTTeMfHmgblsJWp8LFDU1o0Ox0kSHQuokpMfLwb20pP2eVeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufT8tTHPlDFI8Qp7N/TJSP8CRwkqOa4bFb1EnO/a/o0=;
 b=LBDYkU9sSL7H3bvG+tkcrJXyMIfwPNlBW/9WVDhC9n0aMCPu4wd/7BM94j3EKXvFNC93Q4XjYbBcrp5yu2Seh22lNFQy4opt+i++mBkFhF1qUTfMGwZgZJQO8KAz/0aiFuV6GXImsS2Ms8bE2iAhmUNJ56crouV94hgCM79jCkw=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MW4PR10MB6509.namprd10.prod.outlook.com (2603:10b6:303:21b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 24 Apr
 2023 15:22:45 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::264c:5118:2153:91ef]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::264c:5118:2153:91ef%11]) with mapi id 15.20.6319.033; Mon, 24 Apr
 2023 15:22:44 +0000
Message-ID: <a3db8aab-8d30-d470-5eeb-a2cb4195a122@oracle.com>
Date:   Mon, 24 Apr 2023 10:22:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] scsi: qedi: qedi_main.c: modify the code flow in
 'qedi_alloc_global_queues'
To:     Peizhi Li <meetlpz@hust.edu.cn>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230422101626.1722235-1-meetlpz@hust.edu.cn>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230422101626.1722235-1-meetlpz@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:8:2a::25) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|MW4PR10MB6509:EE_
X-MS-Office365-Filtering-Correlation-Id: a6beb0d5-1ede-43d6-c925-08db44d7c04e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74mjYGjmPbu9QocRHxcLqIumMcEzrFxkEeEIZPuzPb72XGBoQk405R2ahZZRN+dfPiJdxwEjqeroreyjZ1O5LLMSxWaryMKi3kr/3yywfW8aD/d0KTv+D88XcWluz5OOUWfiUpZAb6MG8yYfqbu88zhQmjj5IVhvoswJ4GQWYxMrGrHBNeOVza9ISjZXX6ujIz2tWwpFIeLxM6rZV1ejUF3teDZkfJWZPweRzEt3+FFtfeXxbzxmtr+LoHN2RoVRZxEia+qxANNLr1zZe8XDcjwScZALMxuLjFNqnIr7X76GWvTYCS6fm1jounNosjwUAQEj3k3YwUnTsR/ed9lQARnKr+PDdpTEHyvq20mer8Z+4D4ouzx8EjBbeAnmCD2jupMS1ADgR+T2lqB2l8Y7/knifKTO3uc9c+v/4cYJEuOdVs9Ww81KsLYMHW8cnlOmlsIgD/1LsKItQAketvI5naJpJ2tPeg3HrJmNK30YqD1zl0Hw+NyB3IHMPS8soj4mvV1ncTPk0+415DaYkq6YWZg5Fo7AdDRt9Xyta4uwSAYHT/fQz4GYNsmjzQfLij6NV7Fuua4sewi7Q+V+zaOzPDs8nRPz/Sic9uNI3F8QDjNVHqr2cQP5z93rC1lTM2dAh5AtuUcfpkrpnfsMItSj1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(2616005)(83380400001)(6506007)(26005)(31696002)(53546011)(6512007)(186003)(36756003)(2906002)(86362001)(966005)(5660300002)(31686004)(7416002)(6486002)(38100700002)(8676002)(8936002)(54906003)(478600001)(110136005)(6636002)(4326008)(316002)(41300700001)(66476007)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkJacEtpMDFET24zV3FWNlVMMEpUNW9sNTI0NW5xYjFzalJVY3RYYjBRU1pn?=
 =?utf-8?B?cC9kUUt4V3QrZ0xhQUQvaVppRnp6V3Y4czRSZm1mZWN5cWdaVTA0aUpYSHR3?=
 =?utf-8?B?c2N3c3RJZE53a3EvWXNuUC9jVUg4M2d2NldlNnBma0F5TEI5K2hlRk5sbzNS?=
 =?utf-8?B?MHJmMFVnUTd6d3dhTVh3RGYwcXNobXU5QTVzVHNuWGgwcFhpdDhkTmsvY2NV?=
 =?utf-8?B?MlVQWVF2eWZQK1pVZzNVelVBM3dVbE9RWndoNEhhaDVPTmV0eUNEaFRuUHRM?=
 =?utf-8?B?WFlRL2FtTk5VT3ZPRUM4VzdJakxwOWdBMVYwb0paSldnRXpRWDBQeDlqQzdY?=
 =?utf-8?B?V2NJeUlXaXRTRWZIL0hqOU1RNVV5VmJCN3JuaW43ckY3SUd2cHZTM2hsUVZm?=
 =?utf-8?B?dFFORFhZYUNGQkJheGNPVXZOMjVwcll2Y3ZKcVVLZHlVWlE5K0F2dUJFSVd2?=
 =?utf-8?B?QWZ6WGZ4TU1HYzl2ZTljand6VFdnbit0a0FKVUFobHdPKzh5SVowRDZ5OG40?=
 =?utf-8?B?TDNrK0IxOGJFTm9vK3NlczJLMlVocTRocndyTzFyTkhBRUlEVTlHM3pIMzVw?=
 =?utf-8?B?UjZkZFFKV0MwNm1kTXJGTHVkZGZnZE95a284S1dNckg3d1hWR3dxZ2hDS3pF?=
 =?utf-8?B?Mnc0dnRkNlZySEkydlM5ZTdZVFltMkV1SEhGeDRCQ25MWXpldWdUTTh4WGxY?=
 =?utf-8?B?RHpvZWRiOVI2bFhxMjVFRmpFaThGbmJ1WXdCd1lLL2RGRENNRXEweEVQeFZL?=
 =?utf-8?B?QUgyTWdUbmxaTTBoL21EUzd3T2o1bUNiVFJtb0lPWDhtaVN5K1pFOEl6ODFZ?=
 =?utf-8?B?REx1OFdMNzVmU2daV2VkRkFub3dCWmQvS2RaTFpPeFVkNnBjRnNPT1FaUjJS?=
 =?utf-8?B?YXpVRDIwaFNXVjlRN1pGbUNKSmxQWkFFcTNRMGNzd0JKdVQ4Y1dNV0YrS3dE?=
 =?utf-8?B?MVlwN2RUUmFWTXFhckJjNXJRT2luV1d4bUp0TXkvU3B6RUh3VklPNW5mMzBN?=
 =?utf-8?B?ell2RXRYNVBGVmxRU29tTnpVb1JUdy93QXovNVd0QW1XcVJPTytOYSttMG92?=
 =?utf-8?B?cWtQWC9NVHk1eVpXVEdsZkVURlRtNzh5QXV0b2liWkJHNjg3UVN5TmpxaUJr?=
 =?utf-8?B?SkFiYjlvWW1Wd1JNQTZvSkdFQ0M5MC96SFFnZFRmT0tVZ0JkblBqTndCckFE?=
 =?utf-8?B?YnNhZThPNlpFL1Q0dVFkSW1DWW90L1hIMS9DSzZkNmxJNUhDQmJDTTJVL1pM?=
 =?utf-8?B?T2I1UFdZbGRFS2Y1NTZBcER0bFc3VkgwbDdGWENWOWE1M0w2WU12RmZtRUkz?=
 =?utf-8?B?ZnJ1UTlTOFdUS1E3bi9TVVpCMUJ5WjV5QitUMFNqb2UxN1d0SUNXNFFCV2xv?=
 =?utf-8?B?SUVHVnFXUjloQ3FxWVFHU2d0T1JXRDhkcEVWS1A2Rk1oWjl0cTg5UWhkUk1M?=
 =?utf-8?B?RU91WGp1Tk82TzRFTDBSVUhJMmJLOTFKTU5qOWNyUmt0NkkzN2J2OUFCYXd0?=
 =?utf-8?B?STlhTUJ0OHZQUDZ2b1ZKYkhqNEN3SmxEV2Y5N0lOcy9yM1pzQ0dlMGlvcUxO?=
 =?utf-8?B?UDMwUEVKK2h2WnA5bVJSRDZnN3VTcFVaWjdFWFgrc3hKa1A4VXlSZlFpaVll?=
 =?utf-8?B?SVUva3VJcVgxd1lKdlYrQmFkRjQyb0NUN084MWFCdktBSURRSU5DQnV1dkV6?=
 =?utf-8?B?T2JEV2RzREc3bjBYcDljeXRURy9hRlRCbWx1UkR3VFhwSzNoc0RKemRNczZQ?=
 =?utf-8?B?dXMyYVVnbFpiSEJGMzNwaEZlYkk3U3BqUWJXMGYzRHJ1cHQzWDhWNSthWUhO?=
 =?utf-8?B?QUI5Nld1d3hUTkMzTE42ajhTM1M2Sk9tdzdQVXZDSU5qUzRGY2RkVzBQQ0VD?=
 =?utf-8?B?WDJSRlAzRm1iUzZ5V2J6Vm9IdnRvNURoWk5MQzNhVHc1TytDSzNwN0NPSVND?=
 =?utf-8?B?UTNRQTBpUFk5WWIwZWxGUE96MnhHZWNuOGxJT3dLc1MxTmFZcW9qdnRXcDRT?=
 =?utf-8?B?elF4cisvUFV6dDBWZFg0b3ZrOWc0andZUnVpTUZyNTRVTkpnQXFlZ0ZoaU9P?=
 =?utf-8?B?RHp1MUg1U0xkb1ZFUmFWWTFKMmZpSFdMY3U4eVpEOG5GWHh5K1oxbGdieHpj?=
 =?utf-8?B?Q1hnU3Y5bVl4OXlZdmlHSlErZHN3NENBSG95UEppVXZHcEtsSWoxM0FKSURq?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WVNiYmVUQ28vVkVIV2JMSmM1R0pDSitERTlqRUdPNUdzVkk3ZG5lTTdibTZx?=
 =?utf-8?B?aVM4YlpKeGRES1RnUytLRE1RQmtGYVdaeWFLa0QwNEcyNE0zQ3hIMXFJMHpY?=
 =?utf-8?B?QnN4a1NJOFdyU0lWNWlPS0lxeVc5VnVCWkwzMXQ3L3gxTnNxSkZScU5Wczk4?=
 =?utf-8?B?YjlURDk2SmpGYXNnTElORi8yMmdhd0gwak1YNDhiVWNZRDlKclBTbE1jR1Np?=
 =?utf-8?B?ZVUrWmpzTUoydnpYK0Y0LzFyUXlWczNkMml4cTc0ZXl5alVuWitnU3BjTWZE?=
 =?utf-8?B?dFFQaFI5aEE4NlFpS0pkbUt1Z0JXVDd1RWJKWEtPOWZ0amJlRFVCcVkwbHBG?=
 =?utf-8?B?VlNHcEtoM0ZmT3ZoaVhsZFZSSkR6b0ZpdVhhdDduRzFXSkJFWEdqK3hwTGlE?=
 =?utf-8?B?TXFueXpmbklsQVJlTmQzbFJScElGZWtuYmVmNzZkMEhRbUdwQ0dkTksrTGVR?=
 =?utf-8?B?NGRsQzhja010aU9vQlo4bVpHb3BjNlp4RHBJM3Vtd1JuUHBRM3B2MnhJTkVh?=
 =?utf-8?B?ZnlrSkw5YzlCS0FLR3ZXVmR4UEtHZEYyb1FqRFZjMDJQaWpCRjI2a0htVVRx?=
 =?utf-8?B?aVZVNVk4UG01L3hlMkJlU0l2NGdvK2JwZDgrZnRuWmpqa1Q0QWVJL0ZPckk2?=
 =?utf-8?B?b24vNm82WHZzd0w2cmMxUWd0QVlhV2xmRnpGRUNIb2F6VGNPK0Z1bVpUZzRN?=
 =?utf-8?B?Uk1oR3MzRXZuQ1cyN05FM3lRd3c4eSszdFRSMkdzS1ZxOC9nd1A3VFE0c1lY?=
 =?utf-8?B?MDdObiswd1hGeE9yLzFxZTJTMXhORjl4cUJaYkQ4REh2Z252OG9tb1l1NGU0?=
 =?utf-8?B?cTRTTkxEc1h6d0IySjhIalpQNkdSSUx1QWtlKy9XS0VFUWpYTHJuWnAyREZT?=
 =?utf-8?B?QkZDMmZFMGc5MWhPeXZhMndjK3dVeUNnQ3VFb3I0c3U1MTVTMHYrZkJtd2tj?=
 =?utf-8?B?dlM3eExmWFN5QkgxWDJVbGtHeW5WM1dGa1ZLZXNES3V0TERNVU9QM2dJeWxs?=
 =?utf-8?B?bEdpOE4xMllpbnBuUEdwL1VSSSsyVEh3N2JJV2VZWXh1OGErM3BRQVY0VGsx?=
 =?utf-8?B?bGNUeGJuN2tkT2hQQ2dCUHEvTjZKUC9OK3ZGTUQzdm15V0dWNGZDUjJNVmgx?=
 =?utf-8?B?a25EdWhkQm11cHhYUEF6dkxRTWIrY29iSlNoK2tNcjlOTmIxSnE4M2JqR3F0?=
 =?utf-8?B?aEdoM0doSGpnQ1hwVU1xTXFvWWh2RTY0b1FDcjFhd0g5RmYxby9ZMnovN0Zu?=
 =?utf-8?Q?LjtSeC9cCTBqfJy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6beb0d5-1ede-43d6-c925-08db44d7c04e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 15:22:44.0792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPBwbnhyODx7yohKrPpR4KGNAK4y4VyiKJyXJI87JkfvHRxVLA+HORxHuVxBmSoTMXGqpoIckVtwSIjUi3RWY3Ou+Nss64kweH3nM5j/2xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6509
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_09,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304240139
X-Proofpoint-ORIG-GUID: QVWa34NKLYUaMIkbl_2B_qj65RVfE3yF
X-Proofpoint-GUID: QVWa34NKLYUaMIkbl_2B_qj65RVfE3yF
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/23 5:16 AM, Peizhi Li wrote:
> When goto the mem_alloc_failure, it will result in a null pointer 
> reference to variable 'gl' in function 'qedi_free_global_queues', 
> due to the 'qedi->global_queues' not being allocated.
> 
> Fix this by returning -EINVAL directly.
> 
> Signed-off-by: Peizhi Li <meetlpz@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> The issue is found by static analysis and remains untested. Meanwhile, 
> this patches is similar with qedf which Jinhong Zhu fixed already. 
> 
> https://lore.kernel.org/all/20230417135518.184595-1-jinhongzhu@hust.edu.cn/
>  drivers/scsi/qedi/qedi_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
> index f2ee49756df8..34f38e0f1c7d 100644
> --- a/drivers/scsi/qedi/qedi_main.c
> +++ b/drivers/scsi/qedi/qedi_main.c
> @@ -1637,8 +1637,7 @@ static int qedi_alloc_global_queues(struct qedi_ctx *qedi)
>  	 * addresses of our queues
>  	 */
>  	if (!qedi->p_cpuq) {
> -		status = -EINVAL;
> -		goto mem_alloc_failure;
> +		return -EINVAL;
>  	}
>  

The patch looks ok:

Reviewed-by: Mike Christie <michael.christie@oracle.com>

Looks like there is another issue in this code path though. If
qedi_alloc_global_queues fails in qedi_set_iscsi_pf_param the err_alloc_mem
goto just ends up returning, so the p_cpuq allocation a couple lines before
the qedi_set_iscsi_pf_param call will be leaked.

The __qedi_probe call to qedi_set_iscsi_pf_param just frees the iscsi host,
so it won't be freed via a qedi_free_iscsi_pf_param later. So, I think
qedi_set_iscsi_pf_param's err_alloc_mem goto handler should free the p_cpuq.
