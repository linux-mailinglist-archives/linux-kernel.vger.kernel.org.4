Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5566F7F11
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjEEI2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjEEI2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:28:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A55019D4F;
        Fri,  5 May 2023 01:27:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3456XkcQ015245;
        Fri, 5 May 2023 08:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VCit5VPexSlnJILBgl14Fe4l+3XFF7fl6/NiFWPIPmA=;
 b=U6lGQU3ZcfpJpNsM0PLbqp0dxoAGasiXhnWexNQzp4G0DiZMRNuQcjXN6f9/VomuaLao
 23a+pmGOPVFlbp0vM+FA07GBsEgvskvfCqo+iZRi207MVdJW9aKLwRVOxlnT9FMfvmDC
 BGr9W1i9CqjJKDsWuzkT4p/qg7HtgMI21sR4/cCwOa5DDpnIg3PSf64eeZWZR2tOV7ad
 zz/TKuyUXYJL6dDF5K8f74I0Qr6UT17vrAKNrilQIxIxnJLbeO98TcAg+39Z8O2H7MM7
 ULv+rIXUdjTl84qb7SaLkjckYFFSy6mAigQaX8VDgSJ5ZTDfCfN4oPLWWpftKj9JjMQ1 qQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8snec4wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 08:25:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3457juGd009841;
        Fri, 5 May 2023 08:25:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa3dwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 08:25:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfEUyk/kK2rlrvQXsoqmX4mR/usdXwGHb1P87Vu8lURuwBM40Iv2qJUhfVHMLsJaMc10QTfhHfUUTCCXQw9TxNbZAgY4fvVWkCXH4LSVQnGmqGbt5pb2Mh0KiPO8CzQ5XfTpQC3o0MsvCLfp9MMCqW2H6O4yoeJiAEn51r9FDhvW9DkXuOHbYt0syomwflxD4vwQat7mHqRTISewlCFGnfXjBs2qbk15oCzeQbMZ1izJy6eAj/XeytRncPFe2EOwvuNoChHiTBZfu+iFfvh9aAJXCwrA7bDOeU7GH82oSVMP7IlnH9FdBV81XsqjfapZb1l8vp7rx1cu0m72XKdwyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCit5VPexSlnJILBgl14Fe4l+3XFF7fl6/NiFWPIPmA=;
 b=lcYz2KcBtajY2RfgdugAf0SQSVf0hj5Etih+ZBHQ49F91CDWH0ji1FYzSD8AA6AteJaukGm0xwYi3eATp9qFVlYEwq9iqLhzdGRPg6rfJGpVnwLCEIhdp8Jf4462YXgwxSw1XSD26mltHwcvvj5M5mD5RVNwqxUq3h5Ql1LHHUuBJOFNO6MPgZyJt0tPQGbVyhNyjflMl0Ky4pi5SFJ/1c6NOMkSd37eMBJwSRwOWGQV3aNmIaXPtGSi7agDRVAbtQhbVcyZMHfJOvhPEt8tR1SHjGGQFzGSfkYvS4OoX8i3mloNWaNhA+s3ulmLgVLoyGK32E4KHtj9NPFTS4F3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCit5VPexSlnJILBgl14Fe4l+3XFF7fl6/NiFWPIPmA=;
 b=MlgAcayCzf2Hfq5/AAAiJnLJROzKgw+UHhV3qoideZ6GHXIAAVu3I1IC5KTwLmwTnPPnXSzRJsu+uRiabZ1bBCEDRuDjOcYLmEjo9wKUFKrBUEbi4OJ9NilRMv5CumlSKBJYS5aq9I0sIaVMUFehYoco4QTovYdO/db8SFj5ROA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5188.namprd10.prod.outlook.com (2603:10b6:208:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 08:25:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 08:25:52 +0000
Message-ID: <b13c9445-39c5-f207-d5d0-d6c86eee54ae@oracle.com>
Date:   Fri, 5 May 2023 09:25:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ata: libata-scsi: Fix get identity data failed
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>,
        Xingui Yang <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20230505025712.19438-1-yangxingui@huawei.com>
 <291f1d97-9195-45ac-8e12-058f5c797277@kernel.org>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <291f1d97-9195-45ac-8e12-058f5c797277@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0544.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e88806-fb63-4015-53a2-08db4d4256ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8nZMvX/xt2LQR+3tKA+fnWrST8MWSq/J2OljvqnzAA79iSwIqW3m2vcnVFOhdxVYzA9gYrEz4em/0RLto4M4ZS6Ri7OXaXtSgag5DbFoQ/JYII8SP1GdR6I0ZdA4A7ndiVd8OM0gvE46Mfg3Pg+5hU00KggvRBVVWC4lMdoAExmAdqY5pwmC08Dw3yqKii0AXj1c0cBnTfxTRGkioJJHK7jsHFtjV9TFPI6iB1w7YG+4bmks7u7J8ejsfXw8OxiZBholRm/w7y6f1nQkQ6IT3hZLLHT8CVlb+w1TPdu5YhpRrqo5CX0vy1CmPkUyEkhVwYOvaTO7cg3nEt2AlQohI4JmA8tCvBBfnme8ETj+mR+Ay6CG/z+u0unsk87a5FDWlga4uyz7i6niertg8EpBrtVkxq5uzh9mHk3vSlZgs0I7Y4bh9KuZkeDvHOxvM66sPVIyoZ1WEkX9meVSf5B3sBiZLtoVedaM/Wt6Ulg91/5MPv9+2aYsW9FBjAFpNBGRj0+PDjsj3xVIrC89lZSGvuLRWCPxzYLfwCmuXRt5X8iyDYJbk3lnuUhgPa+1RXIC2X69odurfrXckwR6Ieynisdxtj+mW+opHiimfWeJoeQ1iaVpEHzABm9rW0H4+oiOjbKu1zutSzlXAXdt2foFhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(31696002)(86362001)(36756003)(110136005)(316002)(4326008)(66476007)(66946007)(36916002)(66556008)(6486002)(478600001)(6666004)(41300700001)(5660300002)(8676002)(8936002)(2906002)(38100700002)(186003)(2616005)(53546011)(6506007)(6512007)(26005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2gxUjJMZlF4ZjZnU2E2Y01jb2pta2J0ZmphWkJNSTZVSEFZOUhWdExNV0ZT?=
 =?utf-8?B?d1RxOHJheVQwRGdUVy9pZWtLR0RkMDdObGpaOTNuc29RMUFwa2V5Z2xZK1p5?=
 =?utf-8?B?MVhTQ3JqenVLekcrYVlCVE1wZkNGTlpVbnZ1Q25ya2lFK2ZCT1dwSjFwYkVZ?=
 =?utf-8?B?T3pINDVXdWcrc3hwT1I4VXBJSnpVUS9mcHNWWnFRNTU4QWlKb2xhRGF4TW9R?=
 =?utf-8?B?czgya1R2WWdVOXZLd3lsTlRvVGt4TmU0aWJQMWMwN1lJaWFoa3ZUMFlXQnUy?=
 =?utf-8?B?Z1FQY3Z2TWJIakdhcWgza2RSQjRBL0trSUFISENGVlFXcTYrbDVPV21SY08v?=
 =?utf-8?B?Q1FKN3JsVll1MXZmNjJEcm5oTTlySjBRRDZFU3dVbUVUa0N6cnJwbmJzWCtl?=
 =?utf-8?B?NUMyUkxXcmUvdzVQOFdJUWR0djByMUhIcWkwYVdtVUFXT3FmMjRPWDhDTHJs?=
 =?utf-8?B?RE14YlgwWjFuTUtjSkQrZ3BCMHdUa040RjlpUmtlVk45K1BwZlBJb29LYWpD?=
 =?utf-8?B?aDJDSTlJL2kyVWFLNGNZcUtsbmdCb3pZanB3cjNwRUFpVlV1MUpKTUtLVWlB?=
 =?utf-8?B?Qk0ya3dNNHFTSno5ZFNHTW5nS2Q2eS8zUkVpbXBpVlhmZWFpRXZ3WHAyK1A5?=
 =?utf-8?B?RXFnQVJvR3ZVMnVwcXNmcjl6Vms0VnZQc2xGQXNhaUZ0eW9IeVpjWmxDVGZz?=
 =?utf-8?B?YTBYNTRJbC9JOHpuTDVEQWgzOHdDVnV4bm13ejROMllOSXlYVDlRTGpQWnp4?=
 =?utf-8?B?NTJJaDZiZm9LS3BRKzdlNzlnbzdMNU1ndUdUR0ZjZTJNekNOUTNzUjEzWjZY?=
 =?utf-8?B?dGZlUkVmRWN0bGJQV2tGTDIrS2kvVjRhMHVxVzdJNTg1czlHRjFUYml3a3Qr?=
 =?utf-8?B?aGU5YkVQblI5RFVxbldWVjhjandFeDkzLzNLZGNnV2tPeE5UaGZPQTRxYVdZ?=
 =?utf-8?B?T2ZZeXZXdUh0bEJFZ3RlMHhKNkxnUlpPS21BNWp2RmdDMTBGRmVUcHNmTysy?=
 =?utf-8?B?aTcwVW9LNkV4bWJwNUh5bWRMS28yTFMzdDZIZzVCVi80Z0MvSktEVkNMWmg4?=
 =?utf-8?B?a2Rwd0pacHI4M0VPNm1hV3ZNSnFXUVFoUGN6M1FpMWtWQWY4eDlqUmpTQjVv?=
 =?utf-8?B?UFFLdndWK0FvUGlRWHJsZkFJVTN2U0JMcENFT3E1dDQ3SDNUeUNNQWRYUGhK?=
 =?utf-8?B?RjRHaUFpc2lEMFdTMFErekR0ektxUzBrcUQ3Q01CeDFhRHhPMEZEZFp5T0Nm?=
 =?utf-8?B?a3o3cjRuM0tPbVJMTUpHaGpUZWo2MVYxRHYybEcyRmczRG1ING9OVk9mWlhZ?=
 =?utf-8?B?NjFHN2w5OFp6Z2xWL0s4aHRKTGFPaklYWWE3U3FabGhzMUI2ckRNWjh3N0hy?=
 =?utf-8?B?YUwzZklkb3VjNVczc0NNU21JUTh3Y0MxTnpyckR1dkVuWHNUL2JSbXNQeEpX?=
 =?utf-8?B?eE9jRm9iRnQxWElzaTlnUWV1RXVEc0NnK2RiUkoxRDY5ZFRnb2UyN05GMXc4?=
 =?utf-8?B?UkJ0QjIrWmYwcEpKNzdQemp5dVI2SVlNSFJVdElOeTVoOHlDN1pIb2N2bEUz?=
 =?utf-8?B?K3cwWWdQUStvK0E1YWRaSlBBSEhsTU9RaW9oU0s3cUU4R3RBaFl0N1h5SHFF?=
 =?utf-8?B?dVpRZi93ckN2aysySnBRbmlpNklRejYvUkNoUkltcFBQS3o4RGJFUVd0bTJD?=
 =?utf-8?B?bVBwaG9JL0w1dVhGaStTZUVQZnl6RlN5TjFlR09QNCtmNTRYbk5rL2NjcW9V?=
 =?utf-8?B?djF2ZWhtZEVuKzZwbTdGVlpvSVFCQnB5NnBJRzBkWWFQSEdneU43WWZvRlYx?=
 =?utf-8?B?YU4zTmZFaUlTNU1BZjI0OEhidDhCb1VGNkN4MjcvWDNsWVJNQ3d2WDM1a2Jw?=
 =?utf-8?B?c1RaUGdHTERYVHdyWTJSSDlYcExzUHVsU0xhM0JaZXJabVVuWEI3Q2tmME9w?=
 =?utf-8?B?YjRLMlVLbXBadEVxSlhIWTgzVFlKQmZ4LzR4MlhWRzFVdTNrMVRLeUlTY2kx?=
 =?utf-8?B?cjk5Q0F6bmFFNk1rcmlyZjdXSmg0VXhIZWdtUndBeC8ydmNySWY5V3VUSFJC?=
 =?utf-8?B?cThNMTYyd0IzQ3cvQi92U2N2NmxEVW94dFBFdzQ0WEk4TTM1Y3FBNTQ2TUhC?=
 =?utf-8?Q?eOfxtAndFNZTvdBQ8pLk8tdjS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bnZDWHBkOWlBdEk4ZnBSb2k5OUl2T0l0UnNYeVNYS1N0TW55ZVJnSURwb2JH?=
 =?utf-8?B?S0ozRWNvWmdFMXFzVnd1dHc5YWZlMDRua1ZreXB1WDZHYk1KWjd2WWZleUw3?=
 =?utf-8?B?a25hRW16TVJ4N28vaTBzNFpJUnpqZzZDaDlCMkpZSXlUOGxycElEVUUvbUZC?=
 =?utf-8?B?eURYQURjWWtMMVkzUGxSYU13cjlUNVdzNzBBTTdSYTlKY0NkQnZnQ1lRc2Ji?=
 =?utf-8?B?Vlc3NDl1dEtkL1VjSkFLaVlNVkZkOFNFWDY5V0Z5dFhxbjY5QVRkSklna01l?=
 =?utf-8?B?Ky82V1FyVkVJcVkzZ2c2SE8vVUFDMmttU2Rwa3lCWWJ5cTJQcmFKTEIydkVS?=
 =?utf-8?B?eU5ZUWhCZGlkK2k5MkIzSjN3blhXSFhVKzVYYWtsMDQ4SDBxa1NuVHZqRXls?=
 =?utf-8?B?VlI4R084Q2dBYmhlQUlsZXpZdllJZ0FFa3FST1AzK1dCUjZRSk9YTVZWbnA3?=
 =?utf-8?B?WGRWSkdrdE8zemp3TXNLY2szZStLcXlMQWhybTJOeXVQWHZHeVE3TDJ2emxW?=
 =?utf-8?B?M1IyWXh1b0dyUm9tZ1RjWU8wVS9na21qUFNjUHRibTVRMjFudVVBU0RnZE5L?=
 =?utf-8?B?QVdYRG11MGJpYjBoSkdsYndycEtsTTd3Qmg5MzgzS05uMnhZbVhTVUNERXVC?=
 =?utf-8?B?MWQzYkJ4T0VDQzgwY3FuWlJaWE43TW9FRVFTRGtuQ3p2NUtib1V0aTVkSkFT?=
 =?utf-8?B?dDA3RVppWHJMRlVGTXd4N1pQZEJRUUVnNDAvaG5Vd1g3Ty96MUxrNlQvK2pa?=
 =?utf-8?B?VmE0ZWJKRVZ3ampsbGFIOUF5cVZDV0Nvem93RmlwMVNaS0JVbFhNRzVWc3Rl?=
 =?utf-8?B?MmFabm4ycmJOckkzMVlOeVp1MERwbHRuSXF5TnZORUdWUkdmRDJ2KzV0KzIz?=
 =?utf-8?B?TldIa0JJWkdiMm9JdCtmcWtHRzYyNFFhajAwdjZNM0FpMTNDTUFDNVlRTlp5?=
 =?utf-8?B?L2oyUnVaS2NHcXlVWjliMVdLZjh4L1pZNEYyMGRESXp3TmJNY09ESGRkSllh?=
 =?utf-8?B?Z25kZXZ2QWhTSituMFJoYTFxNERxeTQwYzJhR05FRzZZcWxDR25FY2JJY2o2?=
 =?utf-8?B?VDRLOEhHZDNlemlRS1pOejluUVByKzNKc00xTGpPTWtrYW5jb2Y4cllsV0FK?=
 =?utf-8?B?WEpCT1JvdS9yem5JMDhlMlIvUFJhTUdJQS9Ga0cxWXRLOU94aHpsbklIMUdK?=
 =?utf-8?B?RW43SHQ0K2tMUFVRdVBLbmhDditua3hZM0FFMWY4S0NUS0l2MFZXYXNiaDQr?=
 =?utf-8?Q?dOXdbuxszrX8TgF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e88806-fb63-4015-53a2-08db4d4256ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:25:52.3199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSzFb4LUAFS1dTWd3QEfOF0PiHfDE7oskLlGFeGMgfRJONZ7n0G1MDmua70NPKfADivnDjMqI21s33WGOd2MHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050070
X-Proofpoint-GUID: Of7D4JrgPKLtwFV-OXhJGyStE7NLKqRJ
X-Proofpoint-ORIG-GUID: Of7D4JrgPKLtwFV-OXhJGyStE7NLKqRJ
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 09:17, Damien Le Moal wrote:
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -26,6 +26,7 @@
>>   #include <scsi/scsi_device.h>
>>   #include <scsi/scsi_tcq.h>
>>   #include <scsi/scsi_transport.h>
>> +#include <scsi/libsas.h>

hmmm... is it really acceptable that libata is referencing libsas? I 
didn't think that it would be. libsas uses libata, not the other way around.

>>   #include <linux/libata.h>
>>   #include <linux/hdreg.h>
>>   #include <linux/uaccess.h>
>> @@ -2745,10 +2746,17 @@ static struct ata_device *__ata_scsi_find_dev(struct ata_port *ap,
>>    *	Associated ATA device, or %NULL if not found.
>>    */
>>   struct ata_device *
>> -ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev)
> Why drop the const ?
> 
>> +ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev)
>>   {
>> -	struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
>> +	struct ata_device *dev;
>> +
>> +	if (ap->flags & ATA_FLAG_SAS_HOST) {

And this is SAS host. Not necessarily libsas (even though with ipr 
libata usage gone, it would be the only user).

>> +		struct domain_device *ddev = sdev_to_domain_dev(scsidev);
>> +
>> +		return sas_to_ata_dev(ddev);
> Do you really need the ddev variable ? Also, this really should be a libsas
> helper. I beleive this pattern is repeated in several places in libsas, so that
> would nicely clean things up.
>
Thanks,
John
