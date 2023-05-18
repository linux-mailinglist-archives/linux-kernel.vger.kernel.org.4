Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE66708ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjERVu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjERVuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:50:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461C410C6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:50:23 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IIwplP018288;
        Thu, 18 May 2023 21:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tq/k4I+CewsfeVbxNBdPiDEp9qrHMd4Z4z4S8Ujro00=;
 b=GCPLHELQ0btcIgxzPTqJtAIMXKX9snVfIzrq/dj8z88MBsQ4ZN5gJhEJF7CrTxQpKiaZ
 6QGDc5vktO9sdEw/Xj5gcAbPGKFau1PDmJKYVYVMTgve1hT+ipXI8KFF8ijszh4FDQcf
 NmqDuMn4eWkew80c45aLw1n0IK1URRZYDwH3uGa+/FpNG3ISlAhyeTZL/48xy9hRXvrU
 /bRlK4RszoRlTmNyh/lQZvsYFeZxTS2zvEOa4ycZ3EnzhmnxbqgVPBYA87jFAkHL8BUv
 VtSezTaJG2cyfmJMxLk+eqBTbQH2rrabTEDujZyyvXO9K5snKVms+ITych2zXJVegD/+ AQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdscf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 21:49:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IJs57I033964;
        Thu, 18 May 2023 21:49:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107th3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 21:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNAFeNVyHXGUco/7tLIEqAml//sPSe+pKGgmMWVTjH/3OmEHTSb7mH64XJnZRlqNraVFAIvduUVINVMWXVXZ4ARe5rJt4OoXT/y6tP76q2IG6OuW63Aq2VFotxPcAMp/Y4B2LaryT7JgQvWXhm/762TJOU23iWB18uCOpVcwCvcCnl7DFcVUx2PWtApbHInBRoHbFPRfSSdl2H/NR6lnZsGXSvnYGDqL5B1MJ13wW6t/2e1W0EgCek7QND3cKEmrCwuL5SLW5I+kAIKzsfSTQv+R6Guhu+X90KuHOQ0S3DouoPH5Gzn/ptpOk3ZDxtPKbyb3hdWQIIfjYh0TWnfDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq/k4I+CewsfeVbxNBdPiDEp9qrHMd4Z4z4S8Ujro00=;
 b=B8JuK1iiVc6Wwzk1pb02DI1nlUAkhQSFmd5tJ/tAGwG9r+t4+jhPHAxAM0unQT5gePIgt7yE+DtBUkmUypB4bMIc8VzKBjA+1PUU5M3EVkbMeNagKya2vA7IWEgWedE9VlHP9EhrnWinOID4F38uPX8A/mZkmNW544AAZ8UyP12gzxTInDtC4oY6m9SCna5218fQ0iz05F6C+sXKdJIJZbG4Owvw4VeaTnYCav0R04rQtwn6ltGPKVkkZir2MFufo9va00CQUfHQLM8odWlo/JRHR/MomwAjD3ebsn4eYb5eISfLhp8StnpEsAvANbXMRoNE8YSFDswE3PoK0aDY4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq/k4I+CewsfeVbxNBdPiDEp9qrHMd4Z4z4S8Ujro00=;
 b=YfjLZj8yZY1jyHm/unToO5taNLVnS55rcfhLut9R+4hsL2ryv75XP+3J9PgSoVNDgGRY4HoJlpFVO7DechHAAeXQwfwdi4JLIh3xeuGLlC765bp6yprN9kOPxwfW/Ya9iL8oovRq0SxzQhBdYaHI5eORNMkchqa9P5XVa6wI27A=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by IA1PR10MB6145.namprd10.prod.outlook.com (2603:10b6:208:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Thu, 18 May
 2023 21:49:48 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 21:49:46 +0000
Message-ID: <71cdf8cc-a640-ec06-fca5-ed4d948c4880@oracle.com>
Date:   Thu, 18 May 2023 14:49:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 2/2] mm, hwpoison: When copy-on-write hits poison, take
 page offline
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221021200120.175753-1-tony.luck@intel.com>
 <20221031201029.102123-1-tony.luck@intel.com>
 <20221031201029.102123-3-tony.luck@intel.com>
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <20221031201029.102123-3-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|IA1PR10MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c1d3e7-32f0-459a-cb70-08db57e9cb89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1yNtlvyDEHI+Ftl71LiuribZPecamaNk7VMLHoTqC9thUTckT1WaBcf9kR9lEitUy+idR1jtJqQBfJfwdLwCSTypoWr15dxJSsSQCL/uJ29HgImr7SUpVJI8rji18f12G2EL3fG3zQdsalQCj0VTOiGpjRiImOknvetDAvhOPOn3+c0JaSVb2T0bOOE27EM3EWFso11MHkNOSKUmw3Bpo0WwBtSsJ6xPoj5dj3hVpqzM6v00K2C+FqS76WypgewDeyPvmbMhyoPq34leD0oQls0vbBj9x8GfG3JZHA1Cz0PkZzyc8P1uKSTUNAgJeaCzVp1U3A1uJclvZkKIS86EHPcIEURqbnEaF1GYoHVsQtOo7ZTzJaq0J4651Ar/JbYqf/8krEAhO6hmEgMJwcHEs847bR+mPGZkYMRIwV+uce7ooHQXsntKGPbtWcQ0jZhSJgqz+g/ivKRzxbHNAg3x62/DWiYuvl3jbV+JNPPR20+RtC5JD3tO/1rZSjYGu9jROjCLX+XMCSyAL0ggOamZ3LKPh87YkqJ5fPUdv483Yi8kSQmsORd5yEB7CbUlqpKrC+p5Sn1ga4eDKhS2nCwsxBhCWs5whfMMRZUC1BFxKSuAdgdCuVm/wNAOIjiVEPBG06g78TrKpCOz/m9uzXzbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(31686004)(4326008)(66476007)(66556008)(66946007)(110136005)(316002)(86362001)(6486002)(54906003)(36756003)(478600001)(83380400001)(186003)(6506007)(6512007)(2616005)(53546011)(26005)(2906002)(5660300002)(41300700001)(8936002)(8676002)(7416002)(31696002)(44832011)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkJUWnp1dnJkdDJFK3BUeUxnaEhiV0ZEZ0NpRmFpbDhKalcyK1V5WjVvdE5l?=
 =?utf-8?B?Y3c1dmpxeE9BOXZRQ01XYSs3eEkvK1kxYUxOR2UyaVU1cWZOQjFJd0JwSTZL?=
 =?utf-8?B?bThaVXdESVVMNHhCV2tNVktJRWUrRDhITVZVdXlCdnJja0JKMktZNlNxUEpM?=
 =?utf-8?B?K2pmQkhnQjRSc2ZMcEl1bThna2xjZzNhcmdRNHVESFZtWnFCYTI4Mm5JK1Ay?=
 =?utf-8?B?ZGxqbWFSdklZOWhPeUViYm8yNTU2RHI4WU9OYlB1NHdqY0kxQ2YzamxVemhK?=
 =?utf-8?B?T2VUWDlZVU5oMU5PZG5XeXZxbmNXZGxFbk55aGd5MTNNRCs5a2daa1lrMVYy?=
 =?utf-8?B?MXV5Y3lRSzB2aUdBMzNhSVJOaVdzWmRWb2RUQURUeHh6N25vdElTRE0xdjFG?=
 =?utf-8?B?N3VPVXVrM0Yyc3Y1N0xhNjdEaGNPM1ByYWVVWUVCcDdGblZaYXJGZkl4Ny9M?=
 =?utf-8?B?S3Vwd2NZbHdHYzRoNEdMTlR4ekVZTWlDbGVqSThmNmdkSkRNcFBoVFcyNmxa?=
 =?utf-8?B?ZEFrZzlpU0Z0cVNTWUhiQVY4L3E5d3g2Mm5vaEpkZVNCRm5SaWZZUGk4K3Jh?=
 =?utf-8?B?WXUwR3RrSEdtK0k5b3kwbyszWjRUWDFRWmt1dXlRbXlvVFNRNlh2c1NjdFo3?=
 =?utf-8?B?STJqcHVxZFZPWVU0a3JiSzlnWDh5b1hHUVNKS2s4ZE9mNHhMYUcwcjZLU1lt?=
 =?utf-8?B?d3RqMjUxeFk5aG84bVhHR1ZORzJVVGFET0VsaE1SUlZlZHNDTStrSlRTeFV2?=
 =?utf-8?B?T0VrUk9NWDh5T055Ump6UndOL2R6L3lMWndPT2lHMjByOUF1RWxkN0NwZEM5?=
 =?utf-8?B?WHo4em02QlpaSFFwUkNtd3lxV1JPejl3eWNkek4wT1NDOExaYjU0eFNjV3BW?=
 =?utf-8?B?OURlQXA1RlkxRExIajFiRzc1RHM4RVQvU3RHOExadmxTcGdLQmdPOVlHckVk?=
 =?utf-8?B?UzZxNFBOcXVaallCdzNhOEEwUU5IV1hjOG52MVdLWmtLM1JMUHM0OWpWSFI1?=
 =?utf-8?B?ejNob2YvUTZaQlNtNEVOVktVNi9RcUNCSHNDSllxN2xhQ2d1V1NwV1N1bVBv?=
 =?utf-8?B?STNpNTBCclRKL3QrNE5UZGlJUlB2OFNCUklVTndMUFFUbTRibEpSaVlReGdR?=
 =?utf-8?B?ZmpCYmQzckdSWmVSTmdOcXJvSG84N2NlRjJVdFZwb1F6RjFiVXlGUXBva2F2?=
 =?utf-8?B?MGhOSVQ0RE80OU1MZGpOUFhJWjhxK20wR2lLbTMyK0kyTnU2VDhYaGkrTVpD?=
 =?utf-8?B?WjhkT3pjWFNBbkI4am16TFJJRDRxWXlHdmVtSUNHMFJOdmR4L3ptamE0aGZF?=
 =?utf-8?B?MjVxQ0FjZFFiSlBjcnBnS2JoSXRBcURma1dvTHlGSk5zall5WVQzdFljS2o2?=
 =?utf-8?B?c1MwUW12M0kxWGJOVGVMQXBzQWxaZUZqL1J6VHdKdVNvRGxyNzMxUEdQN084?=
 =?utf-8?B?WVJqTk5rdFhXdy9WT3MvTDBBdnA5UWN6UXFMU2t0eGtrZTI4dGQvWkZRcTdr?=
 =?utf-8?B?WjgzUEQrVTBmaVFvaUVtRXNVUHVNeGZHT3NQVnN1K0JOeGxvbkYyREovejNZ?=
 =?utf-8?B?ZXYxWEZFTkdjY1JRRkI2OHorNFdPV1djL3RMQ2kwNkcxcmlqS25GRm91amRO?=
 =?utf-8?B?MVUwNmVuNjhKSTBZc1JLaDVuREloTXI5blJmOTJQWUdBZnlxN2hCMUdtMzVn?=
 =?utf-8?B?REx6bnlxRU91VExsaFBSVk8vZ2VOODBSNngyaWZvK04zYU92aUR5VTgyY2k4?=
 =?utf-8?B?MUZXVlZvRUJBN2oya1FWSFVjMTcyQlNQYnhjUTJJN0F6RFVjcDVuVFN2cnht?=
 =?utf-8?B?QTl5RUxRUnM0NUpHWnhNeHNQQStMYjRHNm4yOTFpYTd2dkRWdm9SaUZKbWJ4?=
 =?utf-8?B?bHNUT1pyK2xaak9ocTEzNVNxY1hWSjMzbzA0Qk00bEZWQWpWazZkUnNpNkdv?=
 =?utf-8?B?bzBKU09qTWhwaTE0TWFCT2twRmxnTlMydGVrV0JNRE5ZYldNSW10MjdpUWh4?=
 =?utf-8?B?dndWQVBlNlJwYUpyU1ZLZ25OT3JZejVRNkU0V0gzeGJEdGNsSHliTGEwTEd3?=
 =?utf-8?B?RTJMbVNoZFFLTU5rNnlYNnpvelBwSURtMVRjc0d0eDcyN3Z2MWRBNW55NmNC?=
 =?utf-8?Q?VJeYDXhvCGneZ4z6r/oSVWGNa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?M3pFczc3Z0VmTWxrTmZQMGlqbzh6VXpTVkJMZVBiQThWOUI4NXZHODE2Z0t2?=
 =?utf-8?B?Q3pkY2xiSjFLVFgwSktEeFI3OUxhN0RoSWROcnVNeHp6ZW1rdnJLTmFoZ0Fj?=
 =?utf-8?B?bk5CZHFWN1hUbVhra0pkYjRuSHYyK1FVSDZtdHJGem9Od1lCYmlxb1h1blov?=
 =?utf-8?B?MURYNlZlQ1orMFA5Yk1xZVpQRk13VG54VUUvVENrVDlFM2xtZGM1TFhlaFMz?=
 =?utf-8?B?Y00vYjRqNjQ0NDBJNUFEMjlXOW1wNTYrOUVGRysza20xQWpFMHdkaWVZdUcv?=
 =?utf-8?B?NHBIVU5EQnBrR0ZQSXlvekVKVitodXJBMUpUUVBKeDllL3RGMkxlaldZSkI0?=
 =?utf-8?B?bHI5NS9nZy9yQm9ic3VMRUhacnQ4V2ZnTkI4d3ZkRzAwZTdVdE9RcGhYZlN6?=
 =?utf-8?B?aHo1T2JMSXVtdzU5cFpQeHh3VkpMc2I0aGJGRFdtcFVoM3l1RFVPblQ2WHpw?=
 =?utf-8?B?Q1JuZi9acUt5V1k2cWR2ZHpWZHkyU2ZMUlJoVlgvNkRCcXo1SnFIWFRScG1I?=
 =?utf-8?B?d3lGY2xQako5MnEyUS81NWM2Mm9mb21QUlV1QUd0YzlDYjdMVURpTC9pVHNv?=
 =?utf-8?B?WVBad2VVTWpTeWxYZUZncUc1N1hvUzQyWkxTQzl1N3J1SzdzbWlORFFMWUVu?=
 =?utf-8?B?WlRmV1ZCUGJFMVVKTnBjMjVBclRzOHV1eG5HYXNJeUE0cGNHUmczcTNuTlAy?=
 =?utf-8?B?NnlMaERQS2M2SmRmeVpxZ3hRNEI5VmhqY2lYUjJEVE5jT0ZvRzVXbE81MzlR?=
 =?utf-8?B?eHhxTkpxRU9qeGRVcWVjaWJWdEQrUkZENVcyQ2s1USt0anlmR1UrUDFJYm1a?=
 =?utf-8?B?UHlEK0Z2MlBLSFV0L1BTdUlwL2dZQllHR2NWT2lPMmJSN0pvR1pwUXdQSzVp?=
 =?utf-8?B?TXJGc1cwUFRZbENRT3ZUb3F1NG8zZXFuV3JlWEZOT0pTZWJjS1Z0TTdCSXFu?=
 =?utf-8?B?L2NGdUxvbUlacmVxc1RJbE5PZlpuU2c2T08yZ01xSTkwSTJML3FVMGgyQmFW?=
 =?utf-8?B?RlAzT2MwWi9ER3g4dkEvcWkvb1FNS0J5Rlh6TVRFM0dkemJXUnlHZFVneS85?=
 =?utf-8?B?M3VXUi9uS0kvNmVKT3Q0WGY1Q0RDS001OGhjeW9UamhIdnZJWi9FcFQzTjRx?=
 =?utf-8?B?NFI2RllMSVRFSGFWRzFrM3JNbEpLL3RoNllFV2twYWZ0bkpDRHYzd3J1YUtQ?=
 =?utf-8?B?clA4d0Q0c3ZRSEJsVTlqUFE2VFpMWWJINStvdDFRbkcwRFhMMUxEZ2NTZGov?=
 =?utf-8?B?OWQ1WjhFZkJYb0FQUlFQTlo5dlRRY1pEbE9DaUV4Vlg3T2dNd3A0QUxUeFJu?=
 =?utf-8?B?bnNZZys3THJnK3Y2UmgzNkRhMXYwWUh4UmhhWkk3d09yRko0OHJ2azBJTmlu?=
 =?utf-8?B?eUNzZW9sNHR2SS9pZ2JVVlNZbkJkRVIwbmc5L041NVI1amx0MUNlQW5HODBH?=
 =?utf-8?B?VE1CRU1MYnJyZ01jVVRKc0R3SUUwcmNFL0ZzMVFnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c1d3e7-32f0-459a-cb70-08db57e9cb89
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 21:49:45.8965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WGU3UwVVjMihoZ73ECBD6ukH6a4P5qujlw6rqUm2J+wfu9VA7i0ZWGR+BkK35BHP2gTVQ8yjw4J2nPzW8qmEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180180
X-Proofpoint-GUID: 9N7DHbKS108OsDYfozw6h7VgVh5jO90Q
X-Proofpoint-ORIG-GUID: 9N7DHbKS108OsDYfozw6h7VgVh5jO90Q
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tony, Greg,

Does it make sense to include this patch series in the
5.15.y LTS kernel?  I just checked: it's not in 5.15.112.

Thanks!
-jane


On 10/31/2022 1:10 PM, Tony Luck wrote:
> Cannot call memory_failure() directly from the fault handler because
> mmap_lock (and others) are held.
> 
> It is important, but not urgent, to mark the source page as h/w poisoned
> and unmap it from other tasks.
> 
> Use memory_failure_queue() to request a call to memory_failure() for the
> page with the error.
> 
> Also provide a stub version for CONFIG_MEMORY_FAILURE=n
> 
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Message-Id: <20221021200120.175753-3-tony.luck@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>   include/linux/mm.h | 5 ++++-
>   mm/memory.c        | 4 +++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8bbcccbc5565..03ced659eb58 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3268,7 +3268,6 @@ enum mf_flags {
>   int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>   		      unsigned long count, int mf_flags);
>   extern int memory_failure(unsigned long pfn, int flags);
> -extern void memory_failure_queue(unsigned long pfn, int flags);
>   extern void memory_failure_queue_kick(int cpu);
>   extern int unpoison_memory(unsigned long pfn);
>   extern int sysctl_memory_failure_early_kill;
> @@ -3277,8 +3276,12 @@ extern void shake_page(struct page *p);
>   extern atomic_long_t num_poisoned_pages __read_mostly;
>   extern int soft_offline_page(unsigned long pfn, int flags);
>   #ifdef CONFIG_MEMORY_FAILURE
> +extern void memory_failure_queue(unsigned long pfn, int flags);
>   extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags);
>   #else
> +static inline void memory_failure_queue(unsigned long pfn, int flags)
> +{
> +}
>   static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>   {
>   	return 0;
> diff --git a/mm/memory.c b/mm/memory.c
> index b6056eef2f72..eae242351726 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2866,8 +2866,10 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
>   	unsigned long addr = vmf->address;
>   
>   	if (likely(src)) {
> -		if (copy_mc_user_highpage(dst, src, addr, vma))
> +		if (copy_mc_user_highpage(dst, src, addr, vma)) {
> +			memory_failure_queue(page_to_pfn(src), 0);
>   			return -EHWPOISON;
> +		}
>   		return 0;
>   	}
>   
