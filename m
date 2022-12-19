Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB45650F69
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiLSPzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiLSPzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:55:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79038C4E;
        Mon, 19 Dec 2022 07:55:34 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJDxSvm020236;
        Mon, 19 Dec 2022 15:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qaxwetYO5iJLb2qOhEU2zRrcldSDT3j7Mh97sbV+o7Q=;
 b=QyHyxOeWMmVOtexEDLM+t16URAumbqFrqoayRyLA3YD6IL8Lpb5DJH3Old6neNwBlRNj
 XCgA+gY6TBz6MV/ghv6u8SWL/RbbOBAc+m8LrOORVE082pIFHCGvKgpIrn3/YlorrWtC
 3M5WY21W3zAkmCsHJQA4cYR1v/uKPEx1JGKNFi8exowOO2UY1qnBPF5HmmvwzuZMLB/k
 TdLM8x92CbXaKOozfSASBI6LzJVj5HFnQl9tPbGIvFnsmrpmUF9UgD7uDE9rHZ7bYyOT
 KJhFod2+5+i2rF6n6g7npnYC0fHqFWVbsvgBAELdSzU7zbgX6ANdw4Ft32DGm9jgkScx dQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tnb751-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 15:55:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BJEwk81006575;
        Mon, 19 Dec 2022 15:55:09 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh473xcbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 15:55:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8lTptiLycZVq0ddUYSdrc/68u69CyCPH8JMtE7TUG3+qlisJVFOfxmExZ//E/G4oDVza3vmUDxyqiDfB8lMyRzHhdVsMjCJUR3fAVqxlFhm6KtzojX5cypr2iPUZzNyxG1Yazgoq1TQcKSkZ/AZp8oLjzmOgdgi6KlyZ6wf5YWzLf8BUUEEy9x6uEfInQa0IZ4jfeR01zlWuJQLWKT7VsccS0APbafCslY9fwylN2idAEDpC8u/1qGel0R2FE1KYR0rBrtn+JOPdiepPnlOsBJt3Xo0j21FycF0ck2xDFtgcufo/N3I7gXae9ykdbEBfba3OFW8kSuch+l/kcdVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaxwetYO5iJLb2qOhEU2zRrcldSDT3j7Mh97sbV+o7Q=;
 b=oYph+NzTq0BIxrGjuFswNzhBLYpqWSPevrTYAcCvjWU7NYs291l4RgrDnZgOk3AxDPMUPQVd1LMP5FV/n9wCtLcJUn1XuhtB1rGiAhaqLz9uDWStAlL2FPoUcdcK1gyM6ctoAo2V7ehw3VZu/saQGDxRu2PSunSDuskHsfcH50v/c3dCrssShxfKwicpGJ2Ri2HzTjwnDCxu0omz4VQhSKpWkvexSscHJ0HB4CsoJ/u0iSyXGO3k1L54gAuLQTpqYIIriu325Sk+fIaIr9YnDaqmFzuXmUuIgJCy4JISjVgOZCE5iJC2kGkrzKG7cJFD8ELQyIn0tk5FtcyHLNz3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaxwetYO5iJLb2qOhEU2zRrcldSDT3j7Mh97sbV+o7Q=;
 b=OwfC/YMO9cCV67bcyTpQ7Nt6s6J2WcuV/BLgDBGVYRvNaUWznfBUHEpVI3qAJ4jdI8lOI+ebYpHLGs340ydd/622fqUFaZCpGb7sNTF+D5ynOqqxbbhYd6NJgJ2Yb2R0rid9QfVkO8zppCLFGFDgIkcP9MEf3jKrY+orP3N2xEo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW5PR10MB5808.namprd10.prod.outlook.com (2603:10b6:303:19b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 15:55:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%6]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 15:55:06 +0000
Message-ID: <257dcd6c-2ffd-f518-9b13-c309348088d9@oracle.com>
Date:   Mon, 19 Dec 2022 15:55:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V2] scsi: libsas: Directly kick-off EH when ATA device
 fell off
To:     Jason Yan <yanaijie@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, hare@suse.com, hch@lst.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20221216100327.7386-1-yangxingui@huawei.com>
 <565fcf28-ec53-8d74-00a3-94be8e5b60e4@oracle.com>
 <60ace19e-d029-f14d-9aac-d5cef83b5b64@huawei.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <60ace19e-d029-f14d-9aac-d5cef83b5b64@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR05CA0125.eurprd05.prod.outlook.com
 (2603:10a6:207:2::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW5PR10MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: decd8cfd-f2a3-45c1-062a-08dae1d9660b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sg9qmgCDeE1RDr2U0nZ08nW8NVbhsRpOnxeFrZ41MM1s/4D+Oci6TBHWk5UDLcZG1zFVKZY+WTmC92RoChGb+W61tkW8Xj5H71DQoDzU7jhTC0k+4NcyDwh65jp5Z5iuYkKPBjVxFTTaYTy6yB44Gt3Pg4/j5OHbcTlI05Awh/kwK3JoUjh1CyQx15+be97QdNWg6ssjEJqwMVGvvkNF28XOIpbiU8tdAbCa8BG7VdjuX+Xt9eZEpW8rPs0OXlBZjyDR6j+xOTNdSErewPDWQYjkVPx1BS3hfG2VJ/PnnFHDvGc+zp0NS7SKBKvX2PygN9Y5BOStJjRi6gzgqK0kW3fGfvU1CIRgnha5fKyJJ3yB54o2xy5MQmA2f6bkv5LPpLAD3o2i+9OmojlXT9k6Z2AiGl+FtdWK4ix+KPzYDTyvHrEJzJpeheoqYqkJxO27WztVwJUzSkjxvlYklfw4vjhspesihOCxDw05iyCDPKq8rQaP7Pr1NUFB419b27GuImIhhgzFpYitEeuvOPQcq6Si/kTigFplnOiNMIw1k+6PoHFxT1kRaBJe7irpdfa+X2XOTXItABiI6kKgg7dL5HMzFSZMrYec25vGl7eNtSQR9tp/ygqSgNWqDA+zhgFCJQsBJSa7dn3L2bOnm1vIUk5D8EHI2uhBBZzeUGLwkeXKHMY0G/SI2URNIkBh5zJV/z6aBL1PHKv9pS4iu2cQtMQSzkhtJKkcZnAXj6G6R3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199015)(41300700001)(8936002)(66476007)(5660300002)(4326008)(31696002)(66946007)(66556008)(86362001)(7416002)(8676002)(316002)(2906002)(110136005)(6506007)(53546011)(6512007)(186003)(26005)(38100700002)(36916002)(6666004)(36756003)(31686004)(83380400001)(2616005)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmZmWEhqQktaaWNTQ3hsTm1wc1NvZFF0d1FTWDl0UHRyNjJwRkdmUWZVQ1Va?=
 =?utf-8?B?dmVzdDVCczQ4RUhvZFJmbFoxRkJIZldNWDBrVmxvUFVaOWt0em4rVmZkMEdJ?=
 =?utf-8?B?aTJMbXM4RUN3Wk4wMDg4N3BFVEc2dWZGQnJHSHZPUjlUaEx1OEJKNXNRMm0w?=
 =?utf-8?B?M3o0VlhzUDM4SkNBdFY3L214clRDaFU1YlJHTSswRlhZKy9CQzlvb2xrRmVR?=
 =?utf-8?B?YnZzLzVST2d3VzRYOW8rRXJvaW1CQVNyT1cyRzBlSTVxSjFiZTZ1aXNCdGYx?=
 =?utf-8?B?NFRtcXFBajFsSzR5WklyZFlTOHJZWHpWSVdndUkyb0VWT0RrVVRNWkkwZjVH?=
 =?utf-8?B?c3lOS2xZMEJLVnBCazFvbXhpcjdodWNVSWZZZFRpbFY2WVNmbDQyS0E1bkJS?=
 =?utf-8?B?L3RVT3hNNWI4Vkxob3QzUENYTm8xdWtsbGJoV3FTU1QxV0QxN05RdTBHYWNy?=
 =?utf-8?B?OWpFT3hTcWRDazhrVnUyTGx3emV6cGVrVnIrYzE4OGUvMHFLUkN1V1RDSm9w?=
 =?utf-8?B?NGtuNC9vVkl4dEdRMjV5eEJIU2FJOEVRN0lPZDNSZzRsWWt2T1ZIbWZWU3BW?=
 =?utf-8?B?aGhpd01xaTRZUDV3TFk4MmNRUzN1N2J4S1NOOHpKU1VLUUR0WFkzN0JrNlNj?=
 =?utf-8?B?VzNwakdhYTFlT3RmTUs0RS9GNUd3TVRMbUs0SmFHdG82YW5ZRXY3U0o5K0hU?=
 =?utf-8?B?WEovRlZhSG9QemFkM1A3dXZUd1d1dnhyT0JmNXFXUjVYbW5Uc21JTGVhQUNE?=
 =?utf-8?B?Q0Z0M01tNUJDUzMzcXVpZCtHekdYZFNvWEZ4T3d4V1FSNnJ0N3RPYW1GYS9T?=
 =?utf-8?B?M293bHlodUk4bXNkYnRURlROZWN1WkowTFM5SytjNEg2QnoveFQzazBpNjR4?=
 =?utf-8?B?UXdjNEozZ2xVUTl1MHB5Y0dJTk8rMGlTcUlTVjV5UHhkNzk0R2J2QzZ1TGdH?=
 =?utf-8?B?MmVkaXo5UEcyRzJMVEk3V3JvNVhOb3pOa0ZoditwamRjbWpFU3JVTGpVSUJn?=
 =?utf-8?B?Q0tLZXlpQkdmVkI4eEpiMXNUUGZqRFFLVHA1QmZWcDRKbUdSVWZ4dXFmQU1U?=
 =?utf-8?B?TVJtdG8vVFJWWktUU3ZxWEQ0UlNoRjJ3anRiVGhWSi9ZZlN5SGM4K1RIbkM1?=
 =?utf-8?B?ZG9CM2Eya3ZCYmRrazNkejd2Wk9xQmZwWVUrdHhpQUdxRlhSaDUzdzlUV3Uz?=
 =?utf-8?B?QnRMdTRmeUFEVHFNaVRQdStkSm1FMHpNNjFScGsxV2h6aC96c09acFpiNTA0?=
 =?utf-8?B?Rm10WUtnQVlLYmI5aGhLamp0b0hISUc5VDhsNDFCVGJ0VWJ6N0hiMEJmcmtJ?=
 =?utf-8?B?VXIwanV6dzJXeWlEOEloRXlzcEE4eElHKzdMOVFrWUpqRGhORUtSQy95TTVa?=
 =?utf-8?B?bnJ4bVRxNGhBT3pNTUtXVGFSZDliaC9RTDRCVDJtSzFVMXl6VGdueTh5eUxs?=
 =?utf-8?B?MENCaHJOQW1JRHJvbUJzckNabEQyeHhmSDN0Z2pzOE8yMW51aUljQ2FXaThB?=
 =?utf-8?B?RUFSSHVZdzFDNmk1akQ0MDYrUm9ocDcyK0gxVkluRjRHVzB0b1lxTVFwdWlt?=
 =?utf-8?B?UTBzcDJjM3pUQ01DTjM4T0ovdGZ6eXJXNlhoWWNiTjEwdno3b1NHdzQ4K09K?=
 =?utf-8?B?Q2lta3lOR21IckxJSXBqZ1haSklPQWdpRUk0eVdhU1F0My95V0NRN1pmaVFz?=
 =?utf-8?B?aFczS0VUbFBEdWZjdit0cVd4anZiYWhMNGJkbmNSNzNSTlB3UzJWRUltL0Q3?=
 =?utf-8?B?dHdrc09kZld4dXlBL3ljNzRnTVN5MEd5amsrRDJKeTg5NzQzRk9yZmFnclZV?=
 =?utf-8?B?VHE2YnFzMXJDT0xIRmNJTW5jZkRBdDl5ZUJwc1JHOHRqNUlBb0JHMHpaaHVQ?=
 =?utf-8?B?MldlcnZtQk5XRm1vVnRrWWpVc2FQS2FsODY3alVudXBsTEZ3NTBwVlU0MnpO?=
 =?utf-8?B?aEhSTWhwMHMyV1YwV0M5U0p2UmtuSHdDaWtnL0I0K21zVUlERzhRSkh5YzBu?=
 =?utf-8?B?aGhxWGFJZDNrZEJIbGJ6MXV6Z212OEdIVGtVNkpHc014RHYzU2FhRnJrd2c0?=
 =?utf-8?B?OFRlOHV1Zml6SEtLUFlDZ1phTzBESXU0WXB5ajI2bkdDZVpQaytoc2k2Z21s?=
 =?utf-8?Q?OMAiLFPwvMpPteRY+aSMFncy3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decd8cfd-f2a3-45c1-062a-08dae1d9660b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 15:55:06.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SApKQk3/u3+SiSjKxDw+UJCXWdA8aFtMQFLxAmQtGFA52xVhA4EMbQbWoHz8ZH8bNnQkoaG5DGlXBEa/bXi/eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=949
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190141
X-Proofpoint-ORIG-GUID: HPyW_WJW3USVGSUKVt7SUtZXQy_2tiuh
X-Proofpoint-GUID: HPyW_WJW3USVGSUKVt7SUtZXQy_2tiuh
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 15:28, Jason Yan wrote:
>>> +    if (test_bit(SAS_DEV_GONE, &dev->state) && dev_is_sata(dev))
>>> +        sas_ata_device_link_abort(dev, false);
>>
>> Firstly, I think that there is a bug in sas_ata_device_link_abort() -> 
>> ata_link_abort() code in that the host lock in not grabbed, as the 
>> comment in ata_port_abort() mentions. Having said that, libsas had 
>> already some dodgy host locking usage - specifically dropping the lock 
>> for the queuing path (that's something else to be fixed up ... I think 
> 
> Taking big locks in queuing path is not a good idea. This will bring 
> down performance.

But it is expected that ata_qc_issue() should be called with that the 
host lock grabbed (and keep it).

I think that the reason libsas drops the lock is because some LLDD 
queuecommand CBs calls task_done() in some error paths. If we kept the 
lock held, then we could have a deadlock, for example:

sas_ata_qc_issue (has lock) -> lldd_execute_task() = 
pm8001_queue_command() -> task_done() = sas_ata_task_done() -> grab host 
lock => deadlock.

Thanks,
John
