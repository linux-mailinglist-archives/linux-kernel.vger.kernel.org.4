Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F136745FA5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGCPQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGCPQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:16:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9695FD;
        Mon,  3 Jul 2023 08:15:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363EndPJ001646;
        Mon, 3 Jul 2023 15:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wczIYwJn2tWJ5P/yiFQ+TVg78QhFRctrlvv4X042TL4=;
 b=JpMC8G3Yk+24aCxyONiCfGuvxGcRXdqSBxGdkv5Tel38tp6W0mb7G/YEaoOO0ae2wi3n
 P7q4MEoNictAQQn6rcYPtNfb0jgs7GuYlxTvT6JEkEl63EMF9WPboCJVCe7uR6htoyrd
 uaeMOk4oCCMQ+gsYUHIe3kvs7nPyBFYAHW0V1p5y+tH3z6AcWKlWpPfYh83EoWW4UdeP
 JbRYd5Pm6DrKPz8TKe3gSZ1hLy1O5Pi2Hsigj89Wu0qW6imSClzrvkvxnItL3/A2OfUK
 4YrWiE/iyiAh/yqBk/egooAszpxqwgtgOZPSeRgK+XUA/j+sVNqwVzpiwnY7ogZP5TxC fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjbrtawqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 15:15:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363FEGxC010621;
        Mon, 3 Jul 2023 15:15:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak3fd0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 15:15:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COUApGWPf2c5elxvnOL77INJhGl+IOg6RSKSAzi6rDh3MHNyLDIvdlrFq19oBKr41NlGbOKk8BtdrFKpMgyr2OWt0/KMrG9dZLdTmE+wmdrMhDLG9sbSEEKybwEy0UVcx/Ad+M+0xcoWmW2a8HquBgHCfuVsIHqarrXcv2FG7iTjj5YyUdzeJXNqoNYo0b/2AJWatWPyvZvkNOSqKxBsUIExESqavc7+Eg242SfNlXqS/Nf/GpHxj7Q81+ID0vPgjcBFD6r1O+gd/zYzNEykwOGCkCDkVF9EabTbhpS/amCIihZvwb/eUbmXUCouaxHRXHALXhGDl0BRZ5kNEl1Q2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wczIYwJn2tWJ5P/yiFQ+TVg78QhFRctrlvv4X042TL4=;
 b=gXaDyxcFqT/AyyAsJIV8Z3ZT7WP8Z9hp0T+Aga5WTqbSUN/mb9vmZNsRniN8X75SN/xrojnN1thjojfomJcsFWG3PH7crEvBIKlLVvlgfzl4TR8ySTkZa0pdT8zTtMtt4OhgVPj68b+vySbblNDFobITKkXbGFj9Mq8CieFji8LniIKx0MtgCdv7iH8CEsA1nEaLFrY/WNAB3/bgWLQN5yAIw6fQ2/daLpZF4+kluJUKUDb7s3IMvf4+SWravC4GklVsijEdztLIQN3RjPKd/REtwSbBkceM1MtAHML3gAIvIbO2n37o3KsEVYFFhprqkZ2CQ5Pw804fiRyVG16q4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wczIYwJn2tWJ5P/yiFQ+TVg78QhFRctrlvv4X042TL4=;
 b=gaMT9b4l++kbmfBUnNrqE07Kys1kqTFCKqGQ+VbXVLC1hbsAiyDuzrEIDkU+kPgyOF+5tvJvoT+N/rhud3IoLIEPeI+Iq0cJPC3Anz/HgqlHA9df1VgDBrfpKinfHPEia6gRIe99Efk2BcFdHfFymF/6FhlCrg8DH3UqawkY9xE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6347.namprd10.prod.outlook.com (2603:10b6:303:1eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 15:15:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Mon, 3 Jul 2023
 15:15:31 +0000
Message-ID: <d59b6e7c-cead-24d4-a9cb-6552b3154d84@oracle.com>
Date:   Mon, 3 Jul 2023 16:15:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC 4/9] perf jevents: Add sys_events_find_events_table()
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-5-john.g.garry@oracle.com>
 <CAP-5=fXa24_LEiyni0Ncyfa5hKwC1GE6y-zi2u8M98M9SwHX+g@mail.gmail.com>
 <CAP-5=fUs=u3PKYP3mVDdzNB8+=GAHaEXG3SGfWJpMELYYqO_hA@mail.gmail.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fUs=u3PKYP3mVDdzNB8+=GAHaEXG3SGfWJpMELYYqO_hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0259.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: f649a14c-2482-4c93-63b4-08db7bd85758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jF+lTUXjhjFDZfkwLN7W2Pb4C1UWRYMyxr7syfY0Eyq/AoKs2LXl3RIWlWiTBWzau4f8K1/1VHLI57j+/uaxldSyV1b1ekAJ+0aDPUGZPX4uXEShOIL01WsDpUU/LtdYuanElVd6AeEjbUxIVg8v5W+AjUujvqxjenErQxJwbjdQDNGMmP23ckaykgUst5ajK5brVYAhYPFmJAVfIhWI5wi5ZbPE0+sQaYITu9uV7aeGkpcuMzMNfWoNdhl1ZJ7hUhH03yemroUeqdiwRWN8VDNJe/7WmIqHIBbpijXNlpft6bJxmB5/swO0zk5vMsVY4l84dfe0zhsBRjdkypCtzURsemCBWt6hPthiDTXNh7vibvAGCnlZ/dPq/FvMm9sAgT0dxZtTYc3rMRodJF7n4iuWMJQAd3RwQIWK8UqZbUn1wd+k0e+Sr1DHiY4ynpi4NA/vG5dhkSEIPBmPVJwElu5JVFUplGzNB9kvY1a712yZ3eEMPx17h86KrEu3q/wo81HkHp4ibEFpqDsCPv0PGm9Gh0uJMK2iMMrkOzDQBTyFK6mO6qbQeAzjVT206R2C+DJSEpecDmEpUqF2v/Mpb41TaOWtBTHLTh53idCz96gLQyFaMIE2SHtrF7nKIBBn1i/FN15gohiPW/QrZZSQbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(6506007)(66556008)(6916009)(66946007)(4326008)(66476007)(478600001)(41300700001)(38100700002)(316002)(2616005)(186003)(53546011)(6512007)(26005)(966005)(2906002)(7416002)(5660300002)(31686004)(6486002)(84970400001)(86362001)(36916002)(31696002)(8936002)(36756003)(6666004)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGxVSkhVZVlUdlZlZG1YR090aEZQZHoyZmJIK0FyYXBOK2tIR2YrYmFIV2JU?=
 =?utf-8?B?ejUyTTVpSW12WHFLRXErZE1vdS9lZmpzMkRTSFFPbXB5OEgxQTAwRXc4UU53?=
 =?utf-8?B?S3pGOGlYQTQ3U2srYzRzNGUrTFNZTk00ekcxODBQRzFWczlJVzdnc1h1U1U3?=
 =?utf-8?B?N3JxTmVzMVZaZXUzdkFPTmdpWHVHQVNyZ05CV2hLM1puamFEbmhlU3p2eUlq?=
 =?utf-8?B?eVNQQi8zVVdBbHVaTzM4NVlINXRZaGhkY2YrMS9xTXg1NzlvRUZZOVowaDc2?=
 =?utf-8?B?dkVQZ1NHQzBTRFIwQ0FDdi9XZ3hlY2t6TzFwSTEvWWJFcXd5RUc1K1BzRFhh?=
 =?utf-8?B?WTYwc2MxcjMwMzFXMDB1YzE2cEs1V2cyK1BOSTJyaHA2Q3FsSWxNUkRzbGk0?=
 =?utf-8?B?ZTNjY0ozR0U4dk5PVXd0akI4SjBVa2JNcDBXRGxoRm9VNW54TWNQS1ZCQjFt?=
 =?utf-8?B?L0VJVEtNRjlmOU9kamlKYVQ0RmJVYTA0WUV2L3l6ejhobXFkcGNBNHlZOVk4?=
 =?utf-8?B?UDFFcUNldEZQUDNsNXhSUXJkc1lqNnBEQno5K1lhSWRZaXZGT2kyaWRNRDBU?=
 =?utf-8?B?TzliU1RVMjZlQWxvQTBRblhZSVJqVjJKQnZBNzVSQ25xY1NnRjRBQXV4M0E5?=
 =?utf-8?B?Wmw3NjFQWlFCMmtrcGdrR0s3UHkwTi9qWFJqb2Q1cFp1NzJPYm1zSG1WM3VK?=
 =?utf-8?B?RmtLZ1lEVnRudWtuRGx1cHFqWGRBYTdGdCt2UW56bER4U0sxNTZZZnJlVy9s?=
 =?utf-8?B?dUc5cjhYQmxDL2RyM1hDNzdtU3Q0TE8vOVh3L1ZSK3UrRmo2MTFLYVdjaisz?=
 =?utf-8?B?cllpZHp5ZFpjWS91aXhmamNZaittcmhFdFRtTTlrWU1qZkNTVjZkaHExY2N6?=
 =?utf-8?B?NlJyVmNBVitJWHllZGJ3cW51ZTZtSkpjYlhlbzlKQ2FSM0VjUEFqQ1RpRzBw?=
 =?utf-8?B?MGVoZklLajFuWVZ5V3AzUGpkb1JrbUVnNzVORndGQVBBYWd3M3BoQlJsRlNE?=
 =?utf-8?B?VkRKZkx0MzlYN1BDMThoUk96YVQ2WjZsWGw1UWhBQjZRR09VRmdoeGR5REZo?=
 =?utf-8?B?ZkxzVU9GSnN6dWYyeXcwMzk0Z1ZiaE5DMlRjSUxFdGlJR3I5WGszWkRqWVN3?=
 =?utf-8?B?WXFScGtaU09UTGhEVWFReGdvNUIzTWhQTFBhN2NrQm03emEvc0gzUTVHbnF6?=
 =?utf-8?B?Yytub1c5L0svMDF0TzNaWDFydTR2bHFGQkUrRysvd1FVYzdIbDVLdjcrYWlW?=
 =?utf-8?B?akVtOVBZTndjb3A3Z1I0bklXTU5DZHBRbi81bGliTDdCbU1oMmtiYWZMRUJG?=
 =?utf-8?B?SXkxa3dKREgrSE9tRTlYV1pZckpPRC8wOXBkemRUU084Rm11dWtFNTAvWk9M?=
 =?utf-8?B?N2g3eHByZmlZY2ZNYi8wVS94UVE0Vk92NzZTSS9lUUxXS3dnRi9MSy9XSDE2?=
 =?utf-8?B?bVVweHJXRFYveEphekt2Z0FYamE1bmg5Zno1cG4zb2JmSVBaUFJCa2t3cFFn?=
 =?utf-8?B?YWt4ZmNsNUg2a3RVU28wUzN0OFl3YmwzTHVYbWJ3ZWlxaGt2SWZ2czM5WnRh?=
 =?utf-8?B?blJYd3hDc0I3U2k0MGZWZC9zYzZpcEFCS2lpKzJDR3FxZkpYdk9sdGlJTGZK?=
 =?utf-8?B?OHV5RGprYW84UENkbjRLRGxwWkNIZDJPZk5ERCtockZBMWc2d2x3NUFKK0Vl?=
 =?utf-8?B?OUN5NjRnU2VCL1pFVkI4QS9HTzNBNnBEYVR4cWtLUXY3Rnk1ZTJjOWdPUXkx?=
 =?utf-8?B?QmMwT0JHWHlvOXd6R3pycDVTeXl0ZGhadlBXbHJaanVaTUVFalZockZKUE0y?=
 =?utf-8?B?UDRIKzQrbDlleDlwWlJlNjZEU0tyNitic2xxZy9OOVM3a1B0aVk2ODh5UVRF?=
 =?utf-8?B?M2t0UFR1Qlp0ZVpITG50U0lyaVlrdmY2eFBVMkxIZWZ5YkVUMVdSUjBZd1dY?=
 =?utf-8?B?ei9XaitvazIyUjhmL1VydGxuc1NNM1hZOWtHS0RPL3h4UlRMN1FKU3RUOHBl?=
 =?utf-8?B?VXh1azdIV0JlS2J6QWxuVGYwbE5aMXkrSWFubzNkaUYwdWh2T2p4MmRNTVNQ?=
 =?utf-8?B?UUo5Rm5md3ZVaVpDaExwR01BblpHTnhhTU5KN2RLQjZnRG1tb3pqOHdjY1c1?=
 =?utf-8?Q?4Zm4riI55JC8b+a+j5v7Dr2Zq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZkhEdXpma1pZYXlrczMyTDVvd1pod2pjVFNVRnFPa1hjai9zQmJWbWt6Zjhm?=
 =?utf-8?B?RHM1ejdtcWJ5Yk12c29JeU1xNm8vRzM0MytYOFI3cHMrM1N0TGJRQ2x0UXNq?=
 =?utf-8?B?TXYvUVRsajM4NUNpVkZ6SUNudEI3cnc1N3FFSVlTbk5jTmMvWDNZMXhRVzRm?=
 =?utf-8?B?OHZKcnIxNWxyZWhHWHU0TFlXSHlvS0xkc0hRUytNc0VUbm9uc3owdU5IZGZG?=
 =?utf-8?B?QkxBNVJKTExNWFB6S3RpZ0FGY0d5b2ZJUmRRUnNHaitxT2hKdy9WU3h3ZFhw?=
 =?utf-8?B?SHJ6WmlTUUdqRnlMSm1uZktMWnR3Z0Z1RnNlRTA5ZTFiNloybTBvWVJMeWFo?=
 =?utf-8?B?TGJFNzhWS2VGdEpmclFEYnZNcWZscHZoYVFRSlJkREwvLzQ0UUFwNE93cmlC?=
 =?utf-8?B?dzlKeW5lR1R2WXg0VDVYb0dqMHFWMEt4eit6enJGNUM5WnhBQWRFaUFIdjRB?=
 =?utf-8?B?NzhrNVNkOXpsV0xtdE1sUzdLRGUyWCtpb3JVbzJxNEpuT1JjcitTcU5tV0tn?=
 =?utf-8?B?Z1FsNmlRbUU4d1NnOG9WTEFJcjhYK2IwNnhTUTdrM1ZuY0ZQU08rV1RtUEtJ?=
 =?utf-8?B?b2xUR1oxQWdkeXhDQVVCN1ZIT0NjK2xQZlVlSUJRdXpoZHBXbUVrdVJuanlx?=
 =?utf-8?B?cGNzeVIraUJZbERPcCtiWnNhMUwwRmxnZzhOZG9BL0w0RzFBTVpFMWt0NEdL?=
 =?utf-8?B?SVNkK2ZLNHVJL2ZLdFArRkVaN0Y0WVBhYzRWTndpSEdXMEJCYnBIYjBVRGY2?=
 =?utf-8?B?N2ZwU2RyM2pET0o5Ymd3T2lOSGNaeTdQNDlpbi9TWWh6MDhWNUtXc0JuRGRV?=
 =?utf-8?B?enJCSERvbHBxUkJnM3NocUlWUEpKT3JCbnJhZ2R3eG9kN01MbUJ4bFk3YVU1?=
 =?utf-8?B?bzVwMW5nK1hNckgxTEVvNUx5NTlkaFh2Q0ZMbnl0K0ZjWDR6T1FKVFZNOXVu?=
 =?utf-8?B?ek9HRGxaZEdIQk9qeERpWnduUmxZN0hPSndiWFo1Ky9pQjNwMzc0Um1EWDRH?=
 =?utf-8?B?bWI3eGsvTDdyeTlQM0toSVg0Y1hlUTZCUWUwWFFBY0F1WnhzVmNNOXU0VG0x?=
 =?utf-8?B?Z09jRG1Yck9POWpvQWpSb0RHR3pmMVQrVHdDZmhGVUQrQm1OK1BKay9uL2xW?=
 =?utf-8?B?OStsSHZzcklJM3hzOEVxN0U3VWQzcktxK2F4QzNVL3p6UFJzZ3UwY3lNTU44?=
 =?utf-8?B?MjdkeTBQUEhqaUFIMWxxZUoxWlNacVd6WWwwTXhpaHN0OVB2TCtkV2RMVm1u?=
 =?utf-8?B?aXlzbXNmQThCTnp1aEc0WEVuYmtSbTh5T0dMLzE4YnJuNzYrRVdqbzhDYmJB?=
 =?utf-8?B?U1Fsb2ozTGllRGNZTUhyYmJ1ZWJBSGJYdWVzMHhGU0VCQTF6L1lvQmpVanFI?=
 =?utf-8?B?REJ6TjN2UFFzZnc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f649a14c-2482-4c93-63b4-08db7bd85758
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 15:15:31.3704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cydI5mJ/1W9JrBqfxPMpwcz7j5WIqRF5C2wdD6Fznlr8CTcX7R7cMLiuVDSODdMP5RpUAzELH5lxpCVD5kVUhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030138
X-Proofpoint-GUID: sUiB1Ube6QdLKmcQ4f5D5gjOJ1mN7vsh
X-Proofpoint-ORIG-GUID: sUiB1Ube6QdLKmcQ4f5D5gjOJ1mN7vsh
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 21:16, Ian Rogers wrote:
> On Fri, Jun 30, 2023 at 12:00 PM Ian Rogers<irogers@google.com>  wrote:
>> On Wed, Jun 28, 2023 at 3:30 AM John Garry<john.g.garry@oracle.com>  wrote:
>>> Add a function to get the events table associated with a metric table for
>>> struct pmu_sys_events.
>>>
>>> We could also use something like:
>>> struct pmu_sys_events *sys = container_of(metrics, struct pmu_sys_events,
>>>                                                  metric_table);
>>>
>>> to lookup struct pmu_sys_events, but that relies on the user always passing
>>> a sys events metric struct pointer, so this way is safer, but slower.

Hi Ian,

>> If an event is specific to a particular PMU, shouldn't the metric name
>> the PMU with the event?

I am working on the basis - which I think is quite sane in case of sys 
events - that event names are unique to a PMU type.

> For example:
>>
>> MetricName: "IPC",
>> MetricExpr: "instructions / cycles",
>>
>> Here instructions and cycles can wildcard match on BIG.little/hybrid
>> systems and so we get an IPC metric for each PMU - although, I suspect
>> this isn't currently quite working. We can also, and currently, do:
>>
>> MetricName: "IPC",
>> MetricExpr: "cpu_atom@instructions@ / cpu_atom@cycles@",
>> ...
>> MetricName: "IPC",
>> MetricExpr: "cpu_core@instructions@ / cpu_core@cycles@",

I did not know that it was possible to state that an event is for a 
specific PMU type in this fashion - is this feature new? Does it work 
only for known terms, like cycles and instructions?

>> The @ is used to avoid parsing confusion with / meaning divide. The
>> PMUs for the events are explicitly listed here. We could say the PMU
>> is implied but then it gets complex for uncore events, for metrics
>> that mix core and uncore events.

So this works ok for IPC and CPU PMUs as we want the same event for many 
PMU types and naturally it would have the same name.

I am still not sure that sys event metrics need to specify a PMU.

> So looking at the later patches, they are making it so the PMU doesn't
> need to be specified,

Right, as we assume that we use uniquely named events. Having non-unique 
event names seems to create problems.

> so I think it is the same issue as here. My
> thought was that the PMU would always be required for metrics like
> memory bandwidth per million instructions, ie >1 PMU.

We treat these sys PMUs as standalone, and it makes no sense (currently) 
to have a metric which contains events for multiple PMU types as we 
don't know if the system is created with those PMUs, and, if it is, what 
topology etc.

> I know this
> makes the metrics longer, I've tried to avoid writing json metrics and
> have used Python to write them in my own work:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/metric.py?h=perf-tools-next*n411__;Iw!!ACWV5N9M2RV99hQ!PE_9BEFVCr25fA9OHzfEDuT-MncA5pnPf5C3eTqYnXGKG9Q2OItrEIiEYz1T366HjAayQmYtZ6N6WxPJBCI$  

Thanks
John

