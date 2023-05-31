Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610E8718EFE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 01:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjEaXQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 19:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjEaXQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 19:16:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6062697
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:16:06 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJvOwc031546;
        Wed, 31 May 2023 23:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WX2PKRSRx/NhzAG+Jqa9ChMGkplIiQqRVE1XqU+1hV4=;
 b=RhMUBpGn0pZYf/dhIaeeT89MKZ7eGwK5frYqrDkODbzYnMHec6veBOdcIJttSBa/WSNs
 SVqO+KGp1tvhFVYC6cFYnintIeyYPtr7d8IWDcnU0aVoJ38ms+0IVqeURbYZGj0iJl1n
 utq3HwAB+1qzODG/cMqUTEeGmTBDuIFowSWBx9LRRzOz4olhPlNTD/chY9V/fkacIccN
 xBFSzMyNMRq622Hn8qWWma8UQDOUXDylsDcV6puwRueJ05KhcNlDw3ej4ku5bZ154ov+
 upgMrKTxiZ0NedkG6PVHEosrJcNit9Sk7T8ZvPnZIcq1VyOa15dIXH9WM3ZRaVyZxBgH +g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhj4y8bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 23:14:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VLkEom030185;
        Wed, 31 May 2023 23:14:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a73h9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 23:14:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnwfDBBb7Et2jAx2RoyqyeOrRRBlhCCGHnjO6a/R/x/MxiLmRBqCtzgpYqba+eWFIdHU8mLA00qgd7FgtA7l7KFNuo4q8G4OUWP365cJGaQErkp86k6EuQ72f75tXrsqMi957psm+5U8eOHSwAufOCURjNpc+EZuzp2tJiiYUaX0faWWmxV9eNwUOqV/T4UP1YKWoCzfBzZUakhYuPKI4Ei5rgIZW5a0/Lge/ePQo3P1EP+NCAB/cJmr2ofpnu/h2AI5h6hMZEIjDBq1PDmeh/88xkKitmlMqOj4dlaQPMLq57isF0xLmv5OlgAbRHcgx5qTeDk+jv79MVMxE0b/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX2PKRSRx/NhzAG+Jqa9ChMGkplIiQqRVE1XqU+1hV4=;
 b=mj5XQQm1pCo2AsxrxliGav5YTXN91EUS/nuekT10VDjaoaeE6MWuq0WIYVT1yQp1XFe+K+jgVFaB6ciO473q6gUhQKS3f6Ebmz1+pL5Z9NOB8HzHOwZzEJWTBr1Ga1u+to2Ll6UP5Qlr1n5Vw9VuZwlUPGS2d38Dzwj1TUUhby20dJxypKdkCivZSN+jpa3Y7RUENfy2e0fLhf1UhRffYN/0X2tRkx5mxkLIzyF+f9lC98pgU3gsXruQebml4Cm8hc7Ai+qbo/qU6IyTjKTMPYRcsS90MHUcJZj2a1xw3neGUfzpOirTxyutcg/x+16IPYqacLW5WQWm+J5LGLasOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX2PKRSRx/NhzAG+Jqa9ChMGkplIiQqRVE1XqU+1hV4=;
 b=QKS8RVyzxDarNV1ZsfSmYIoOPuBv6hMOoTDwD74tzgQDKo3uOnSVmkaPcBIMw9Nkp/rL5PMSjKYIAgj0WbJ3HGnLCr08AqZX7r5DBAJf82CxTfRUoH0X2hKj12dS3SFC+1UOEHMQHRGVLAAIdkEZyRqQNmUwebZVK2z2prrG8Yo=
Received: from BYAPR10MB2438.namprd10.prod.outlook.com (2603:10b6:a02:aa::22)
 by SN7PR10MB6668.namprd10.prod.outlook.com (2603:10b6:806:29a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 23:14:16 +0000
Received: from BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::625c:3dc5:8229:d2a]) by BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::625c:3dc5:8229:d2a%3]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 23:14:16 +0000
Message-ID: <66d7eda2-c136-1245-b433-784264b31683@oracle.com>
Date:   Wed, 31 May 2023 16:14:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC v3 00/21] Preserved-over-Kexec RAM
Content-Language: en-US
To:     "Gowans, James" <jgowans@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "jason.zeng@intel.com" <jason.zeng@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "lei.l.li@intel.com" <lei.l.li@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mgalaxy@akamai.com" <mgalaxy@akamai.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "fam.zheng@bytedance.com" <fam.zheng@bytedance.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "yuleixzhang@tencent.com" <yuleixzhang@tencent.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
 <a4f62a8e1b0f43db005cc1117c06c00e6c0c85ff.camel@amazon.com>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <a4f62a8e1b0f43db005cc1117c06c00e6c0c85ff.camel@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0032.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::45) To BYAPR10MB2438.namprd10.prod.outlook.com
 (2603:10b6:a02:aa::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2438:EE_|SN7PR10MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bd37c7-5bda-41c1-d908-08db622cc14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JurhNfD+59Sn4IPMTAcYp14Euuup057joh/I4JiCRaXwJpQ4twzpR+UagAmNbNJyefUC6wxZDDDxSat9FUSL+ZeSA8L53/8irOBuURKRceRrsq5QgqUvkTaoHV3OhinUSBRWecG3NU1Y3Dyt0MQl1HQL7gV1SCO1enFQ8zzDXKYwO8lNvgsCIvDhgQOpVLSuDqD2RFC0u0/MMwYb46DhsIqO7zH1AA8l6qibrOJYWej76fAhZHOl7iFWsrJJpbyzyHDDfYAI2RlWWgyRHV7HfqCe67tAJ+8nLgVqkAZXFLoE//n39llH0+VirVEUDu8tp6vYs2wj7q25P4stv39qQgAzjiNoyRq09JqhtM4fqsYaRJOCzixkC6CmiZXQFqjW5qSrFAJWZTVl9IdUVEC0CvFM6otHFT+dHFz7f3kfDoXDyMOwvRphwwW2KeXx9ovF1pw/tynZk7+sqV3i9DZc17Y+HlSH2GsEcURIhWf0Xy74SEup5IF6jD3luXiYP4BzpfKWc8bwj6KLjI3xCivRL5RrHnfCYeHW2xVaNMlpWvghKPSomBCfjm1L0QXceMwbtsNLkZkJPV7mtCZYgA00HIr+7Zt4mTEg3stvw+xUP7t9pDwKnCvHct7Ga+UwgVu07SgXJXucJ7LA+YfWNRqsgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2438.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(186003)(2906002)(31686004)(6512007)(53546011)(6506007)(2616005)(5660300002)(110136005)(54906003)(478600001)(38100700002)(8936002)(8676002)(26005)(83380400001)(966005)(6486002)(44832011)(31696002)(86362001)(41300700001)(6666004)(316002)(7416002)(36756003)(66476007)(66946007)(66556008)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFdaaFgrNGg1aXV2Qnkyc09EZnlQM3FmSy9Ja0N0ZG04VW82bndNcWMxZU56?=
 =?utf-8?B?YU5lZ1pZcENCNTg1VFBJYm5vWTlGSzlka2JnS0lRV0xxWkJFOGNmbVZOL2lt?=
 =?utf-8?B?VzNhOVpFS3M0MUxpU2JDSEM3cmduNXBMVVlCaUdaSitHR0ZRTlVweUprS004?=
 =?utf-8?B?QlJXditVNkxhSk9RbXJzc3B0ZUdPcHVwU05tSDVuRUNwdDF5bGpaTmNDU2ZR?=
 =?utf-8?B?OVhONkw3Ukh6bDlEUldTZmx2TkliOVh4UzVFOGtMUTNYUUx4NnEwTThEd1Mx?=
 =?utf-8?B?Y3doajVYUDRVL0dmY2ZUaStObW0vOVFHMlphc2E0SVZTMDUwdDd0NnlwUk03?=
 =?utf-8?B?N1ZnT1dQU1FJQ3pGM1E3ZmlyQ2tJSnplVXBQb1BsZEgzaHEzVDdESWF0Mmhh?=
 =?utf-8?B?ZUFxVVl1aE9xcW9iOHJkYmtTdGxhMVh4RndEUFNJMUJweS96R2dNUVpuRjYw?=
 =?utf-8?B?eWZpSHlMaEhnL2dsV1JvUXBIODlmaFZCaEhMeEJmeW14OUh2ejVyOTZwK3Ro?=
 =?utf-8?B?TFZheUZ4QnVjSkxrY3NhYzRtRjdFNGNmQzUxeTZ3TVpqQ3ZqbUtwcEs1OFVw?=
 =?utf-8?B?M3VqdlNaT2ZjQURiYy9vSUZtTnlTZUVsM2pRejVBSnJSaWcxbnRUMEh4Q3BS?=
 =?utf-8?B?dUI0WmZmNnR2S0YzN2M4QTN0UWFqY0p0dHprbnVJOWJCR3ZSYkpjSWFjN0xa?=
 =?utf-8?B?MU1ScC9USHdzVy9CK0lBQkFQN0dPdzZSMGVCeGRCeVVGYU8zRzlXRUxYOEpB?=
 =?utf-8?B?Z0JBaENCUytIbCt5NVpyYzl6WG0zdk0vRU5NS0RnOW5lVitkczdjejNhSkhk?=
 =?utf-8?B?Z3JuWk5MS3A4UGVnWEVPQThabkxjUUduQkpLR0R1RGpOZFhXYktQQ3JZejJL?=
 =?utf-8?B?Qy9pYnMyYUVvRVBFa1VzSUp1czVibmMwSXlrUm9HdXV2U25LL2lQS1BsL0ls?=
 =?utf-8?B?WG5TTWxUOXpNTW1uWnMwS1o4SmlYWm5oZ1Vtd2plK01rRnJlVDFhK1I5UFlM?=
 =?utf-8?B?SFBETjhoNGhWejM4TUpGZUxaZ0M0b1MwZzNrclV1S00zeDRuU25BUEM3cWw3?=
 =?utf-8?B?MUtxUGx4OFJsL2p3SVlNN3JXdzRGcDkwenV3eTN1WDZpMVBjMW5aNUJRMEgz?=
 =?utf-8?B?VnpmaEhmV2laaklxZ1d1QllsSzIvUkNSMjMzVlVUbDhQSHFSU1o5RThzTGpz?=
 =?utf-8?B?YjNpNkdDT2E0QkU1YUFNcUQ5UnAwVThIZWZuNGFtbnI0cWpyQTZzdXZGRG5C?=
 =?utf-8?B?SnJiOHhqWXNSM21ET1QxWXJCc0gyeGw1aFhMNG5laEVXL05yRVhxWEhsdEE1?=
 =?utf-8?B?eFpGSyttOHNtaUNVRUtWRGhpK0Q2RnF1TTQwb1FrcEt0N2FTVUdqVjRsQlIw?=
 =?utf-8?B?ZGFmdHltRDlqR3BpaGlnSW1jVzVxUk5MS3N1RENZTGRyUzBkUGtRTlQ2UWxs?=
 =?utf-8?B?SU0ySDRhcXhHK3JxcEVQODNiZkdUc0hCRW9XT3lMVjRXNEZCM2piYkozekxi?=
 =?utf-8?B?cmFBdG1YN1JyY1JhQzEzNFdmV29sR1MzTXI1aVdNcmhKbDF6Y1dlSGZHTGFo?=
 =?utf-8?B?L1A2TzlNQzhPVjFSWmlUTFpFVjNoM3lnbENGQTFVWWxlNHVwWFU2RERvd3lH?=
 =?utf-8?B?QmRBMVpQb2dGTEFTVmJPK3M3NXdpL1dURDFVeFZDUlJRTHArRWtDUitvWUNY?=
 =?utf-8?B?bUU2Z0lpc3BxVFRMNy9zcGhtd1BVSmVrK1VmcGVGKzV4ckg1NVJlUlJpbm85?=
 =?utf-8?B?aXBVOUVrM1l4dzd1cE96M1NadC9rU3RoQ1lyV3UzMmgyelZZOTlSSWVpdUdW?=
 =?utf-8?B?d0dVSWg2V0NtZ2FhZmR3bDVGMGtCMEZKMFMrUVNKdnl6OFltSmdYNncvcHhM?=
 =?utf-8?B?M0ZmRzVFS2xBeFlmVlBOKzA1dW1IcjQ5V0VMNm5mb1BMTmlMVEJzWk1IcEFw?=
 =?utf-8?B?dHJCbllVN3lhd1pQejNRc05nTVBwY01BNE5XYTNEMndBRDA1YzVwTUFqS0Ev?=
 =?utf-8?B?M1htNFkxU0dXMkNNOHpIMEIzdWFLUnZzYmx3VHNkeG1GSDhSc2FFTTlJeXJm?=
 =?utf-8?B?aGNTUDR5NWI0UGc4eDU2NGRrbzVwWTdVaC93bElZSkMzc0c1N3RmaU1JNTZZ?=
 =?utf-8?B?aFRGNDV1MVVURVJtQm1uRzF1ekVzRHozcUs5L29lRFJqa3ZVS3ZKclVieEFt?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U0J3MTdFUFlzbVhtNWtpQW1NNlB6dUxBZHVlcHZmSEM3NzErUXovY1UvWGJh?=
 =?utf-8?B?cDJOS2JKY3Y5K1VqZHlQbHNEdjNDcTIwRWpLdnVNa295Y1RXNXJNdU1mdUlP?=
 =?utf-8?B?amlCcXg4Q1RjajI4bElwYll3SUFZZkhMWExtMWF2K0xqWWorNGgwR2VGODJ5?=
 =?utf-8?B?OCtiS3QrL1FLMUpBMzlEV3hQTktHNWF5My9wTjlxZ2RieC90M1dLVitFVEY5?=
 =?utf-8?B?L3o5Qys4Zk5jZFl1aWNoemdiazgrYktzc2xzV1dpaU9sbjBkb2FXVjQ3RDh5?=
 =?utf-8?B?Q0tiaUlCdndtQ293anYvck12bS9CblJnNk1DUFVtOWZtRDJKQ2ViYlN0ZStY?=
 =?utf-8?B?VXVobDdXdExlWk5UZWQ5Y1RzbVE3NjM5Y2VFSXZENENuSkxybVVmYXZOc01n?=
 =?utf-8?B?N0JXNTd2QzZ2M0htM1BwMmNhWGZ4aFZIZTc2S3BWVFFRdlNENUNvZSsxOUFR?=
 =?utf-8?B?U3BxNks3QmZhbVh1T1NMdVVDMHJ3akRqN2I5WVpDeGxDbHRDVGVmejFNTnkv?=
 =?utf-8?B?VVFKandBcnZjNkJEVG4vNStDa0tlRjVkeVVVRExnTGlnRS9sQmY0Nm81T3VI?=
 =?utf-8?B?dnd5RzFJNmtVVHRpMytUS09ONTFwY0luSzRWMmk0eUdJWGF0NmFBTWFzNHBW?=
 =?utf-8?B?bEZpTndFcjZrSzRkYlJWWXd6bGhCaCt5Z0Qrd0xRUFZhSkd0V1ltRnJGSzNI?=
 =?utf-8?B?Q0VjcDlhY1hhOHMwRk00ME1GVjlJaDlHb2JFUXAxRlZCR2RHeWw0ekllTlJD?=
 =?utf-8?B?OTNGN3phckxGa3FGZ3o0OVlqVHd6bnNuK1RHY3ZpSGU0OWNQb1lzSTBGY3Nz?=
 =?utf-8?B?SEI0TWV1UDVwMlZsdzBGSEFxbEZSb0haZWhpbVVhZUt6ZTRFNjh4QnZKa004?=
 =?utf-8?B?cE1tU0RoSjhFVU83ZkZqTDhZVW4yQldzVnFGZnVyU0xscW5QSUtCdEgzOERo?=
 =?utf-8?B?bkNrQ1JvenJNb0M2RnM0L0MyaCs1MHE0UG13VWhUOTh6RXY4M1M1VXp0bTV3?=
 =?utf-8?B?WHRielV1dGxHZ2ZnRWFYZVpTdWt5QzVjYkVLUG8yeFRvNlRpanIvQTZFcW03?=
 =?utf-8?B?eXo0N2xLOXRnaXJ3K0RDRWhaSllxMEdkNzFudXFFdU9zSWJTS2xiLy9NbnVm?=
 =?utf-8?B?dGFtd0hUdG1naE9Ec3JSYUFBa0ZlYUwvVzlmNVpQOGdpWnFpVFQ2UVF6bjJ1?=
 =?utf-8?B?Y0M4ZzFEK0VjMk9HWE9oTUg0UzhRbjJDbk5ONFlEaSt1NUhBc0dneCs3S2Zu?=
 =?utf-8?B?eGJvZ0NzWGR1UUV0bFNNaS9YTGc2dW5zeXFRdEpxdnl3U2RZbG1ZSCs3VDdn?=
 =?utf-8?B?SlFTbVZIeGdZbVhONkpxcjlkSE02MFJBMUoyZDAxbzE4VzFNNk5CMjMwWGx1?=
 =?utf-8?B?bkZGNjh1SUVQM2FRa1AxUjJ6T1N5OGFkSkc4MFVTQVM2bFg0L0xrNGQvV2lY?=
 =?utf-8?B?dS9tMnFqMG9pSitnWVhTS2JmeEc0TDR0UEJOUldTaXNvTGlBOVo3emRJRThl?=
 =?utf-8?B?WDdSY1dsU0dxdFdtelFZNysyeUEwVDViRVpkWXNBWlF0aklycEZaeStiWlNU?=
 =?utf-8?B?cHVWbDhQOU51ZjJtOEpyMkVwblhVNHUyQmFvQ2hMK2NoandpQ21DeEtsR2lq?=
 =?utf-8?B?RW1qVWxMdzdTRy9yV1VhUm9vd3BOMW02ZWZqaFdlUVBMcTI1UVc1S29ENmdj?=
 =?utf-8?B?bmhRMVZZTHVLdWwzOWtzQzdBd1EzSU5NRzlOWisvSmhtUXVyTUljVjJjdGFR?=
 =?utf-8?B?NlZqVXc0UDNZbHYvTDFRRjh3TTUrQ2ZjRTNEdEMyV0R4VVovTUFPU2xmVytJ?=
 =?utf-8?B?cEtJVi9adDZCNU85ZnRkZ1BSaHlvTjc4aUN0cVJGNU1wbDNJS0JZNUJsYXVO?=
 =?utf-8?B?eFhDL0tsb1F3RS91d0IrUHpiaXBYdUdtcEdlVEhSVEp5OFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bd37c7-5bda-41c1-d908-08db622cc14a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2438.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 23:14:16.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9eErIANVhetKT6MA8FxIMwxK2EkEOLJH45On0XH74Qzxz77boPcXSTAYKTnBfR1DhVFmnw4Y/LaCkKJd6eVInPdDtFrdYbx5gbeiKC2SNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_17,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310196
X-Proofpoint-GUID: nI8VlTFoya7Ymtab0R7xJQNTFevS5Rq-
X-Proofpoint-ORIG-GUID: nI8VlTFoya7Ymtab0R7xJQNTFevS5Rq-
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/26/23 6:57 AM, Gowans, James wrote:
> On Wed, 2023-04-26 at 17:08 -0700, Anthony Yznaga wrote:
>> Sending out this RFC in part to guage community interest.
>> This patchset implements preserved-over-kexec memory storage or PKRAM as a
>> method for saving memory pages of the currently executing kernel so that
>> they may be restored after kexec into a new kernel. The patches are adapted
>> from an RFC patchset sent out in 2013 by Vladimir Davydov [1]. They
>> introduce the PKRAM kernel API.
>>
>> One use case for PKRAM is preserving guest memory and/or auxillary
>> supporting data (e.g. iommu data) across kexec to support reboot of the
>> host with minimal disruption to the guest.
> Hi Anthony,

Hi James,


Thank you for looking at this.

>
> Thanks for re-posting this - I'm been wanting to re-kindle the discussion
> on preserving memory across kexec for a while now.
>
> There are a few aspects at play in this space of memory management
> designed specifically for the virtualisation and live update (kexec) use-
> case which I think we should consider:
>
> 1. Preserving userspace-accessible memory across kexec: this is what pkram
> addresses.
>
> 2. Preserving kernel state: This would include memory required for kexec
> with DMA passthrough devices, like IOMMU root page and page tables, DMA-
> able buffers for drivers, etc. Also certain structures for improved kernel
> boot performance after kexec, like a PCI device cache, clock LPJ and
> possible others, sort of what Xen breadcrumbs [0] achieves. The pkram RFC
> indicates that this should be possible, though IMO this could be more
> straight forward to do with a new filesystem with first-class support for
> kernel persistence via something like inode types for kernel data.

PKRAM as it is now can preserve kernel data by streaming bytes to a
PKRAM object, but the data must be location independent since the data
is stored in allocated 4k pages rather than being preserved in place
This really isn't usable for things like page tables or memory expected
not to move because of DMA, etc.

One issue with preserving non-relocatable, regular memory that is not
partitioned from the kernel is the risk that a kexec kernel has already
been loaded and that its pre-computed destination where it will be copied
to on reboot will overwrite the preserved memory. Either some way of
re-processing the kexec kernel to load somewhere else would be needed,
or kexec load would need to be restricted from loading where memory

might be preserved. Plusses for a partitioning approach.


>
> 3. Ensuring huge/gigantic memory allocations: to improve the TLB perf of
> 2-stage translations it's beneficial to allocate guest memory in large
> contiguous blocks, preferably PUD-level blocks for multi-GiB guests. If
> the buddy allocator is used this may be a challenge both from an
> implementation and a fragmentation perspective, and it may be desirable to
> have stronger guarantees about allocation sizes.
Agreed that guaranteeing large blocks and fragmentation are issues for
PKRAM.  One possible avenue to address this could be to support preserving

hugetlb pages.


>
> 4. Removing struct page overhead: When doing the huge/gigantic
> allocations, in generally it won't be necessary to have 4 KiB struct
> pages. This is something with dmemfs [1, 2] tries to achieve by using a
> large chunk of reserved memory and managing that by a new filesystem.
Has using DAX been considered? Not familiar with dmemfs but it sounds

functionally similar.


>
> 5. More "advanced" memory management APIs/ioctls for virtualisation: Being
> able to support things like DMA-driven post-copy live migration, memory
> oversubscription, carving out chunks of memory from a VM to launch side-
> car VMs, more fine-grain control of IOMMU or MMU permissions, etc. This
> may be easier to achieve with a new filesystem, rather than coupling to
> tempfs semantics and ioctls.
>
> Overall, with the above in mind, my take is that we may have a smoother
> path to implement a more comprehensive solution by going the route of a
> new purpose-built file system on top of reserved memory. Sort of like
> dmemfs with persistence and specifically support for kernel persistence.
>
> Does my take here make sense?
Yes, I believe so. There are some serious issues with PKRAM to address
before it could be truly viable (fragmentation, relocation, etc), so

a memory partitioning approach might be the way to go.


>
> I'm hoping to put together an RFC for something like the above (dmemfs
> with persistence) soon, focusing on how the IOMMU persistence will work.
> This is an important differentiating factor to cover in the RFC, IMO.

Great! I'll keep an eye out for it.


Anthony


>
>> PKRAM provides a flexible way
>> for doing this without requiring that the amount of memory used by a fixed
>> size created a prior.
> AFAICT the main down-side of what I'm suggesting here compared to pkram,
> is that as you say here: pkram doesn't require the up-front reserving of
> memory - allocations from the global shared pool are dynamic. I'm on the
> fence as to whether this is actually a desirable property though. Carving
> out a large chunk of system memory as reserved memory for a persisted
> filesystem (as I'm suggesting) has the advantages of removing struct page
> overhead, providing better guarantees about huge/gigantic page
> allocations, and probably makes the kexec restore path simpler and more
> self contained.
>
> I think there's an argument to be made that having a clearly-defined large
> range of memory which is persisted, and the rest is normal "ephemeral"
> kernel memory may be preferable.
>
> Keen to hear your (and others) thoughts!
>
> JG
>
> [0] http://david.woodhou.se/live-update-handover.pdf
> [1] https://lwn.net/Articles/839216/
> [2] https://lkml.org/lkml/2020/12/7/342
