Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353A7743871
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjF3JgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjF3JgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:36:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A432D5B;
        Fri, 30 Jun 2023 02:36:02 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U74kWN031050;
        Fri, 30 Jun 2023 09:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=KNBkLozXVoT3sml4d4efDiDJM1RCkgKGfdY7dNTJhz4=;
 b=YJQ5ghwM1O47k5nRNzYn8wbFlS9bwCJc/VQBXJJ7Lob9CpjpFeXAvLw6RSZgoTHtVwo3
 dUnvHT3F0q1I2X0kCA6vcb4wxEbYN7oaNUkkXp9fMzehZ4NEAVP5VLfJNCIPJUJT9GvC
 F/qTD1FKooivTZ6PIdSvxhYfHMGwll8GuG6Wvd3UOt5dOW5arwc5Oh0Px5KYonDeXkYE
 drIcnijUJKpxpwLM95L9xgLSlQKodX+zhezzwM972BVJdDo0qFNZ47j1wLfS1dcxxU/w
 tCkK0aJmJo0A+YrfhnBplGXhFWyHMUzVtCm3O0Am7iTltsqfesKldpJ+r3fdcpO+0jDg 5A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdqufn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 09:35:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35U85Dre038223;
        Fri, 30 Jun 2023 09:35:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxf5as4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 09:35:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSaOlUXHI5/BgMdfnsy4A8/ghNBeqbiOpUyOXOf42Ci7ihqSa4tqV1nFppsQKTaHfjSYfzBjHjW/IXcjX7CQ7Rc5Q9EKTEmpirfJon5RIeSu8vS1zdCJlTshRiJBfddiuIC5G6YETSzr6CmicBnCcPUp8gGmtgwdRI91A2I3yD2lzlGXyhSsxrVzxst0BysYYU+CJqSVjDkchngUDdpd1OGnMkt+Qj4JzTh3l6Om9YVhpP7IWyuxsEyd2RfJFnh5cUUgURttGpZ+RIXy+ZubEgO9CCeeCyfHOHL+btpqLOUJGFKeDbHq6X+o1qZFQ7ByH5dAfPTp38BnGsoXh28BrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNBkLozXVoT3sml4d4efDiDJM1RCkgKGfdY7dNTJhz4=;
 b=GV9LCl9WM26bWqKjd3vZKMH7a6hX0wCeCpWOJN5ezCLrNsTg9MNqoZA3E8SFwpMavmrki5wpU7lgMedNEEpfWRuv0Vbt1mNmd0Sv6P/yn6Y3MtnKaGZ57ZEZ9bLnFvhR5NcVibTFWtoeSdGSB82wZk/ccwE2v7/fOkB9zzOFK89v4fNRLwfBcW8xusJi/DNi1zGg3MnaXKovpRILa9VN4r5rorl66NOUYNyM9ECO2/4kPmW69ISfSM+59n8Fru7bOZQ7qmdQ3weA7BM3NyvRk7EzjXwapO1F60BZDfkX0zKfx7e434EcUWlBxiWiI/WwYasi/khH6lj8DwXYJ1U+xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNBkLozXVoT3sml4d4efDiDJM1RCkgKGfdY7dNTJhz4=;
 b=UFn6wvwqlak5MAXnERIBveDy3d7y6IXyRHmS2/80KtttLApNuAUBlSuFPxtnKd1hWyA6/OFQlgAb2BOilt/ZXrWCHou1GcK4Z9vGw02RoS5q2ep1L6TS2Hdw6glXD9GK0s1Gy/3JGvEy1DqfAGcGOT+pfZ5Texbh0YXhahei400=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB6325.namprd10.prod.outlook.com (2603:10b6:a03:44a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 09:35:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Fri, 30 Jun 2023
 09:35:07 +0000
Message-ID: <9aef5f82-fa76-dbb5-59a0-47f2e85f8bda@oracle.com>
Date:   Fri, 30 Jun 2023 10:35:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC 0/9] perf tool: sys event metric support re-write
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     acme@kernel.org, irogers@google.com, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <CAM9d7ciBWjNHOfouNKSFy2q88Cs4-6F8EjGqGpFdwb6QTShaew@mail.gmail.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAM9d7ciBWjNHOfouNKSFy2q88Cs4-6F8EjGqGpFdwb6QTShaew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0056.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: ee49efbb-7c7a-4ce6-cf18-08db794d4a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wP91BVKlSqlDxPK7zL+IFITR2/1tkN9Mci5KrRZ3z9O+xesZ+iksTPNynRQS8OoYpPTQl5qPwr+zvVzgVsb60H+UO/coLQGoHUbTVF1Cgag4GtPM1y2ta0xIBPCrCdWOsIv5LhMUBx4/IA8aM8Ce0wQbJRibV8viUlN00dps0R0zuUvyo2/rG46a3rmlzBDLQrgf4PWCYEqo/eq109rDyyhzuWyzyIszesieqYp0ciDqgP1Kc2o/pGoHLV3HDAm3ac5qvR66tiB3Fn+IQShWnHl9nk6+6rdfSMdh8bpQfxa0aWS4/exiw+Z+LzaQFhUSSR8F1eEnkhQkyaCClVrJDilXxZ816aiaUllxngAKNCt6JoUOY9GsymD/Ttu3r3e2kWavUKqnjNSIx9yQlWjWn6epeG4aRlwrMp9WXiRrxxJ4g+AqXFR2SUQp36/VFCU69ecQ7Zoa/vSp5wT3h8zNAvAVWcpWIlm8weMLgtQvb+Ler98HpeZSfVhZORD9FpZWnEufOdOwUwumF4OBM011TwgzGBrawAPxclnRY2YR8jT/Y84OsAfOhfdknL3xiATLPeldI6EETt+OA5dzksUzFcKh8fiXEak7xw/4et10F4hLagdlK6fiyLCg8vl5mSlvvJ2T8yzpiQnJWbOQqB9eXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(2616005)(2906002)(4744005)(38100700002)(36756003)(8936002)(8676002)(5660300002)(86362001)(31686004)(6512007)(41300700001)(66946007)(66556008)(66476007)(6916009)(4326008)(6666004)(316002)(6486002)(36916002)(478600001)(186003)(31696002)(6506007)(7416002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1pWRjZkL0JJYVB6MXRJTWt4K0pjMVJpYnl5OFUzbzZnOWhoUDRxQys5ZWlJ?=
 =?utf-8?B?QndXUW9WbEMrdWx5SmRId1R0WlhIRERyZVlubkJoOVlENTVBY0EvL3IwaGFo?=
 =?utf-8?B?cGNOOU5qUlY3ZFBqZjVsQUVKMzU0V0diNGJudG05Y005Q1c5aEswL2wzS1hZ?=
 =?utf-8?B?LzJBWDNNV3RQUDc5Q3BBVFVWWTZIUitHeHEvZTdDRk5CYTBmL3FuRFJJRE4w?=
 =?utf-8?B?MEhZaVdYMDRHWW1pek95ZmZraW9acUdtMHMwNnl3Rms0ekU1QWJ6SGdQMGYx?=
 =?utf-8?B?MXJrY25sZDhSOXh2NTErd1ZqSmIvNFhjQnlpdVh0TUc4eDNqS2RwWXN5bjE4?=
 =?utf-8?B?YVlzNjVuaWpqV29pTGlzNnZubWtHWWhtK2RDdUswZlNHM0l1VGpJcXFiZkVC?=
 =?utf-8?B?K2tyOWZTMk1WRGkveVl5cnlMbGlzZlM3cnAxaEp5VDdxVGozODhqYkNSY1VF?=
 =?utf-8?B?Y0F4LzJXNTQzaXFNUW9xUzVZR2pEajI3Vmo3N1Q1eXJNZWl0TlRCN0ZNb25N?=
 =?utf-8?B?ZFRQUWpkS1dTNkYwYzByWmhudnJJenQ4ZzZlcmh4Y29QOUk5STZ3eGlVWklY?=
 =?utf-8?B?NDhYZm43eUVOZGVRWnBXVEZUTFQvWHl6S1dKSnFzSzJxMnMxV0NiYjJtaXVZ?=
 =?utf-8?B?emdDY09hc1o5QU14Zzh3c3g2U0VoVWN6ZHRxT0hhRHNHNndiNFR3RW1JYkhu?=
 =?utf-8?B?V2lveXhRR29TWVZKR0lSVDlXZjM1NkhraUd4Qk9CMkhleHY3dlphM2U3Z3gx?=
 =?utf-8?B?NUMvQnRtNkd4TE55ZXZkZXZkRURKZG9tOXdlbUlvdGRvYjgvVVI4aDkrUm94?=
 =?utf-8?B?NEZKWnhSbS8wTUt5NU0rQitob2IrS3NNUWoybEo1cFVoNGZ5RldoeVg2c2lH?=
 =?utf-8?B?WUhoM0hLTGtFUkhPTGduNTF1clR3MmhWV1NlQ3ZjdHlvL0Nqd3pEd2xjMWxv?=
 =?utf-8?B?RElUc3JZTGdyQXRtVDFwMHVOYlV2ZlZHNDBMaUJNVEU5NCs5QzJIVHZBSjJj?=
 =?utf-8?B?L2ZXdDdNclIxYXE1OWplRys1c1U3cjFEeE4zR1QvSTI3L2VmYm9FR25RME1Z?=
 =?utf-8?B?c3h6RDVYQy83OVNIblczUldNeEJ4K1ZsbEdZYklVNklRcTZvRnBQc0YxQ2pH?=
 =?utf-8?B?UElMYTVpNjhnMDY2ODlZeUFHRklMUStPenZjTTBVM1U0a2xTbFdSOEMrR0Za?=
 =?utf-8?B?Wk04bFcycXllVDBRbFNndUlXempVNTI0MWlHNFgzOWdpaENDWXdmK2l2SXYy?=
 =?utf-8?B?YWd6Z2krRjEzek1XaFo5VWdTdWZlTE53bzZoYXJ6U2h5MVdRZmVOY0grNDBv?=
 =?utf-8?B?K2dab09uQTNYQXZ5NmtYRmozZVEvTGZCemUwL3JRZGxLc2Zld002WnI4RXhU?=
 =?utf-8?B?QnJsYTZhdk42UWcxTnBKalZ6K0s0aTFOY2w0cjZjZWF4NU0wNHZ0WlNETzJn?=
 =?utf-8?B?anJ0M2pYNlZyc3llUkFob0pZcENxVVhlQ0l3S1dFZ2szakM5NEc0Sm9TRlNu?=
 =?utf-8?B?MlBmekc4aWZaSlQ2WDhudEQxQ0NqdU1CU21tZ2hoTDNZWkNYTUV5cStWWVVh?=
 =?utf-8?B?cVk4dTFWTDlNRFVJTXUvUGFRVlJHU3ZicjU1SU03NVhnYmdBZVBrTDdJNHpx?=
 =?utf-8?B?cVI1aHhkWUxZWDYyK1h4VUh0S1FzSFJXWG5BRWtrSVFZbFU0QkVneUREZnNj?=
 =?utf-8?B?Rmw2WmNUMG1vUEZLT2NpVnNkbk9Cek1VVEdON2VybjM0ODk3cjVqeHp4VWZt?=
 =?utf-8?B?THJPb3kvYXJzK1Z0Y0ZCNWFvbHlBQTVnZEdRMVhVK0dYMXBlR3ZVSnQ1bzc4?=
 =?utf-8?B?ZUNkdHc3NlhSSDVVR0kyS1pPZGZxTTZqdTl5R3UwS016elZVNm9lMy9ndG1j?=
 =?utf-8?B?dUhwUVBpT2tuSDBEcWY1ai8yY2RTVmtxeHRxRGZYS1N0YXdRME1SM3lENjNw?=
 =?utf-8?B?ckE3aW1VSE8vUzUzc2JvOC93N1BLWGsrL3BiMjZ1OVNxMm5xelY2TDJGTDBG?=
 =?utf-8?B?b3FEbVZ0Y0RzVi8xVWJ1VHJxZnJEOW9LYmpwN2pTYVlPcm1aaHdXaEJLeS8y?=
 =?utf-8?B?SEhaWUVIbTlYSWVPMGNyY2M5ZFFJL3Z4WmtIQ1FIUzRNazJtYWRiT05yUHJl?=
 =?utf-8?Q?FYjpGD5TAU4rKxO4oCvOFvCpd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N0VBakJGMU1wV2JSZ1hCZUtZR0ZuMVM2R3NxUFpaOW1ES2luSXYrVEhKSGZK?=
 =?utf-8?B?K0xISVR4OTV6cUFnOGpqU2p1Smc0a1F2MjNPK1lXRHVaenF0QUo1VVV2V1Nh?=
 =?utf-8?B?L0NQQ0NJRnRwZmx6aEQvTGFxc2d5Q3l6ZC9nNTZKdzZQMHpIUnZ0UGVSVGN6?=
 =?utf-8?B?bW1tZFkrOEhFZmtlVW9odi9hTk9rRndEcm53dUpodk9rYkFETzYwWVRwb1ho?=
 =?utf-8?B?cmJhblFIQjRxL08wL0p3eUZWZTBjNjF3Z2ZaZEtrQURCRXlpazJzbG1ESHdU?=
 =?utf-8?B?ZlZ6Tjd4M2RlSG1WUnBvMlBvYldySDBHQzBvNDFsL2I5dEJuMWdNWDBSTmxv?=
 =?utf-8?B?Q2FqclQwNVc0dnhzcmZsZnZXZnNrTTF4Y3AyMnE5Ri9hdWtPd0taa0pLMXc3?=
 =?utf-8?B?bGt4USt3SERkY2xYZjRyNTNqS05zWmIvRVh1VGdmMlZhL1hKNWZHTHVySW1R?=
 =?utf-8?B?ZlJqcnMvWTdpd0gwR0ZlSDcxd29wM3poNldubG9GZUpBeTlySEgvL0g3UVJo?=
 =?utf-8?B?cUZXQ21WMXM0QlpWMmdMWGwxK28wMGtOQUU2RStxdmFsNXYvTlhmRktUbU0r?=
 =?utf-8?B?M2IvN3lIdUNhZDhqWXQvS204QlNQd3BxU1hiU05zVnpkTFNhSVROV3N3ZFJz?=
 =?utf-8?B?TTZMdjltYzQ2cUQreDZKR2tRZEhNb0p3TVVWK092eUppRlVaaDkrWWNHZmh5?=
 =?utf-8?B?VmNlcW9ZVFVvZzJUakc1VkE0UTd0eC9IOEx0am10emFIeUFYSW9McmJYbnFq?=
 =?utf-8?B?cDk4OHJlT2F6eUd6WWsrQ0VLNmNTZ2h3WER3aXdBL0VGU1pFQlBkZVNiZit4?=
 =?utf-8?B?aHZRREhTZnV5VTdLNklIQjl2YXJnSnA1SzZ5MGlMODViQ0g2UGNzbjFpOEFO?=
 =?utf-8?B?dU9IdDRQMEJUL0VYRkFzc01GU29xSUNXSWVrTWtSemsvcStsSjdQcytWZllZ?=
 =?utf-8?B?VXRZV3h2MGE0MThYY1g2UXV3Wmg5QisveFhGaGMrOGZoaHFoeXRocW1ROXRZ?=
 =?utf-8?B?d0p1Z24vcVNCb1dGVkVFT1h5OVltME5lZ3dEYWgwOWhwM05hVngxN3EzWkww?=
 =?utf-8?B?TFVSa0o5ZmZaY3pPQWhxMXNzM2NxTXJhQ2w4V1k5V1doU0RxVy8zVXlrNDZX?=
 =?utf-8?B?cHZNSGRUQjQ5T083cm5YTktNblBRNzY3MnFCWVhRSWhaZ3cwcHBZOGlHUnEr?=
 =?utf-8?B?TWwzQ3lmOXlxMkxKMTdFdUZGalViS0UybEQyVGV2c05WK2g5emk1TDF1d2Nx?=
 =?utf-8?B?bzlzUi9QenFuK3JHN0RWcjczTlhsdXJ0Z3VnMkk5b0ZkcUFvK1JMOVJLeXFF?=
 =?utf-8?B?Qy9pTGJ6enYyWi9vTmdmRkxYY1d0cjRXUFlvQUtjdG54dG5VaHAyekR0QS9J?=
 =?utf-8?B?b2ZjSDZFQlk5aG5wUDVpcE1lZmZ5TzdhOUp0U0pEek1VSDJKb2s2WCtERXpz?=
 =?utf-8?B?TjVpR0hsK2pPbkUxSU5zWmlpMEtHRnZRU2hxOXdRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee49efbb-7c7a-4ce6-cf18-08db794d4a16
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:35:06.7513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNdi6WxLmOl4zufHrLakXyzOGpGJfTVNxmFZHf6F5u8S0c2dnmwgxJwIm5X55M+SJXaPIeOxpQgsrRv5Ab+FxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300080
X-Proofpoint-GUID: otGCCTE4w47iVKZsW3x3iyaoviinO24-
X-Proofpoint-ORIG-GUID: otGCCTE4w47iVKZsW3x3iyaoviinO24-
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>> Based on 82fe2e45cdb0 (acme/tmp.perf/core, acme/tmp.perf-tools-next, acme/perf/core, acme/perf-tools-next) perf pmus: Check if we can encode the PMU number in perf_event_attr.type
> 
> We moved to new repos from acme to perf/perf-tools and perf/perf-tools-next.
> You'd better rebase the series onto perf-tools-next (branch name is the same).

Is that in the MAINTAINERS file? I could not see it.

And I was hoping that Ian could first have a look, since this is just an 
RFC.

Cheers,
John
