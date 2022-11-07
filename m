Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89EE61EFF8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiKGKKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiKGKK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:10:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431032BC;
        Mon,  7 Nov 2022 02:10:25 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A78sWGj011373;
        Mon, 7 Nov 2022 10:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dUB98nHk4JJ9LEwFncGwFIYbMKQJRjs7I/gaPft08UQ=;
 b=HeGkinedqOJ1eXYBIlKdAbtzRHdA/ou8VLXUFeHp2e3tCaqpVD2sO/EU8DqEM2TeD+sL
 GeZTqjsjoPiepUe7y4zrp5dDzIyXhHFxUe/IFgaadfGD8XqeuvjQaOj8id3hlZ4n+9uc
 dZtQDaqkCTiJfzG4oMdEQE+S5+9Jl3LbgGs4I1UEjC/Hm0TlQvnTC1r8ZdVXvTO5bgzy
 E1/qlgbTJSsYMZa0qR6SnbF5sdM6JQ7Pu1SWrUwDe8P5UvviGfTavbDUB6Zx+/WhYwgK
 EOHsxbBqMy1lVXKJBwZ1WJuVj7VoEFtfKVubawKHVLJwAPMvLR/8nIm5vCehsDJQk+0j Ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngkfuf5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 10:10:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A77T1i5015210;
        Mon, 7 Nov 2022 10:10:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctavfuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 10:10:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+X739N679Peo6ShTnixa+Jhup/SuZRBmARFrbKnWrUdARxjeA0zAbqTmPDH/Bl2SCqTuraQFIdu7ujY6JOFxpa9MMMG+cwn3stfQ02bek1KXLB5PpS0w7s1cYJ6/vzmhSqqACo8Bft2Sixl7a1n+QUj4JAo7oQ2m4VPdoIuloU5dLgkctqbOdn16g3y2Ye+EQoT/xXZQCG04jMVDdDq5Wb+/ANLniTEOcZE8CNmUDtEK9J49Au3bBnbopbX4Fx8Ogd1AyglIQzsYrYAQKKlCf4MOries9DbuYwT9LsDgk6M3WyVNFN0epgQ3Eukkh/5yIDd3DSvHnZpxoIzRgPfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUB98nHk4JJ9LEwFncGwFIYbMKQJRjs7I/gaPft08UQ=;
 b=JTYuTmQU0ZucFtSbX8ndZ6e775DzRVo7iki/MFYaPr48NJddvPieprlI9yOdPNvOjC2c7yyd44x0xle5Y0cg6gbXxHLiJaiSNqWfkCACZT9IFh84Az35zfh91er1cbWqDq4kVXzcKq1kE8IwNqGGyQu26QddimZeZZPdJcuQLNVmZ5xPqXSiPqdg+ZHc1wKVysZFYdo8qrJRdjcV25kSqiBUQMFWW2/hGU8u1dXBcRaNkeiteWJHclE/P3tXUgL/AdtaP1nldsCfxNOjTSf6GkBDTFdFaOiuy1CkQLqmiw4SHOf3UZEceMVUOObWQGcPBqbtRX74Ay3QyOWOzd8NFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUB98nHk4JJ9LEwFncGwFIYbMKQJRjs7I/gaPft08UQ=;
 b=aM0zn4UfDXq13qQFcJtMygedpEihLMy8e21rJv2XCkM4u9yBhQSfgEg5Qnf/xPnHq0dm5PfCPLWjy/aNByyAyMqvpriJqsOmfrDWVOG2qBKOCQS9CjGi3PoyeUsrNT3nL+kHK+t1UOV4uL1yprdgoA6a1WloOki4521LV3F5yl4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4569.namprd10.prod.outlook.com (2603:10b6:806:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 10:10:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 10:10:00 +0000
Message-ID: <59947ba8-d1a1-2e50-6199-f3974221f8fb@oracle.com>
Date:   Mon, 7 Nov 2022 10:09:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH RFC v3 16/22] ata: libata-scsi: Allocate sdev early in
 port probe
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@cloud.ionos.com, bvanassche@acm.org, hch@lst.de,
        ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
 <1666693096-180008-17-git-send-email-john.garry@huawei.com>
 <6c0a4a75-786a-c946-57f2-c511bd765bcc@opensource.wdc.com>
 <d4535f4f-d9cf-30de-ce8c-9d8ee9c0decb@suse.de>
 <5417d401-6fb3-c1d7-58df-e24e0013cfb8@opensource.wdc.com>
 <331fffd7-b5db-9b4a-42ae-940a6b54a37f@suse.de>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <331fffd7-b5db-9b4a-42ae-940a6b54a37f@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4569:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4492c2-6cf1-4e15-2a78-08dac0a83adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfHzT5+oC2v5QplpKzSJsh6sNpTIDikB/hhc98MiD537gSLWhBLuWtwoa7iZcUFVdPQjvg0NM1wF6692ZD3ohtMgt6OaY5RB5l7NlQRKCMNqByjAL7p4yAOPc+YnxX/yhl+WKMvbh8xrAAsbauXw+nRYrQPi/5rC1xIaNDQ84dKQwcFiFY/cu4ir+//2PLKELIKXuhTYFklSlv/7qW3GAvVPftAB33txBN5JEqwFmYIBH5tpXeTNs+YtTh0Mx1+L01wTaGbVrtgZ9dJwarBuQ8oDU//Oh/TWjS2LZVSih/w4JPcjEZq3fHIlY5VrTk+0id26Ny8rFJrowrJNw4RiLqvYEHkIlQVi8Px6i3HcdqbAgV/QipvqX7/3n/B7g/XhhVgdDv/nhgwSknANq3hyGMw+QA+CQLsTNx8k9hmG8xmkuAn1q3stB4UpTs5KG8YWpV3PC+KdcgzdLdkYi8lKhJ/L/PXAeiTwcgERzwoGgPlMOp1c2BGl/C0QH199he92rKEoNLv6JdYoI7kyeK2ZnPvw2GVIxZAKoPUtkSu2F1qWnNziFrpz2Y+aHl1z1kiO7A+Dw+OpMCX2NviLbAbJQIKNbg6Ia3pOJ9vxBYh+CX0jwmwfYGsTbs8XHqTbNs9JMXlxh3u17uHe9dYfm2PeWy5KGN4pnywtbBeM7TmPQG+lciSKNqsh+rwQ0Msf3IMaos8N8c3+ag5LaBtXNxLZQLymoyHyrqQRtsvgy2p2MBkJKauB0aMWEP5Xq6qJE9/55Eoy4lbCXmP+T83boAEKJeSximv0FgQiOJbvk0Jrv12DngBDxxJCRsg53I9kWcpg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(31686004)(2906002)(41300700001)(110136005)(316002)(4326008)(8676002)(66476007)(66556008)(66946007)(478600001)(921005)(36756003)(38100700002)(6486002)(5660300002)(66899015)(7416002)(186003)(8936002)(26005)(6512007)(36916002)(31696002)(86362001)(2616005)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzE3cFBVMm04TlA5emR0RUhKdHRYNEYrbUh3VG00VXRkUzB1RFlDbDVpeDJy?=
 =?utf-8?B?TEEwUVZPSWxIUlJDbWJaYlZFTXRlL3BYVTRONVhqaWtHOUZXTVR6ekZlTnor?=
 =?utf-8?B?Skh0YTBsTnZkUXVDWDBCSHlVU2lkZytEcGJ0SzVuK2ptbGxTUG1OdnpiOEVo?=
 =?utf-8?B?Sk52YXo0K0dVWUt6YTNqamNySE1ETzBrbkgxVXNNa1RNRTBwRmFTQlJqS2ps?=
 =?utf-8?B?aXpjYkQ3MnFzMDFXcGFIeFFabFFyOEJIUU1UZnpSWUNIaWVESTArY0ZORVF6?=
 =?utf-8?B?MEFvcERNUmtvdG9kcG0xZVIycEVuSUZDeC9Pb3RsaWx5amIwMkpRNzVOTVcz?=
 =?utf-8?B?bng4dXRoU0JRNXoyK0pNL3daZzUzVkNsY2M3bkRBZVkzb3pPL3ovQ2JNZ2ho?=
 =?utf-8?B?NkV6MmNMb2pmeFM0b2VnK2luQzdIa2FrZG1iSEw2cFFkczBoT2pSNTkrc2NC?=
 =?utf-8?B?c3JYVHppeUpCOVp3Ums1dGJWREVzVjZKTGxKNmtrYjRPYVZzdytTaXBjTEF0?=
 =?utf-8?B?eFNMVVpydXQ0a1QyUkZ1aXJCeFRuYW1xL25GbFVyTVBBUzFZVzk5OFJPNWtt?=
 =?utf-8?B?TTlINkJITjlCOHJUemI2b1daSTgrS3ZDOC9MdkExOE1pelgxU2J4c2pUS0o5?=
 =?utf-8?B?L3I0RTVUTGh4UFFsYnAzRTV0Ly9JQUs4U3l0TVhHNUZyTVBOSE5Fd3FQcnMz?=
 =?utf-8?B?aTFMSnVMTnpXM3hVM2VGZW1Ram9pSXorbVBCbHRneXBpRVdCNy9VMHN2RGFE?=
 =?utf-8?B?Z1l0SWZIRUV3c2JSbFZ1RHZ3dno4b1BtNElCN21aaWk3ekFGcFNVT2w2a0Fk?=
 =?utf-8?B?UkM0THNHRU1ZTk9oYnovWnArK2hzQnB2Y2lEOWVzMXJObEIrK1pOSjFSNHFM?=
 =?utf-8?B?VVlyaUFITEZYVTRtNmN0aUo5TC9iNTVJWWFVL0E4VTUxT2ViS2k1d2FQOVB0?=
 =?utf-8?B?bTVmTFppUDRxTDFNMTU0MWtZWDI4Z2dWWEE5dGlZcEJzMDR3L0lIMGh5cVUx?=
 =?utf-8?B?cGo4WTUrbXdGWFdDVHJ4cDhEZ1pQSmZQeC9lQVlSMnFpemlmWXd1eFZUWWpR?=
 =?utf-8?B?czU5Q1VVb1VpNWdtcEhUM0dLOERPRzYvSmppODY0azVaS1IxSklMNmY2djJJ?=
 =?utf-8?B?dDI1c1ZKcG55MnpvK09JRjVGcUxMb1p4UHA2U1NFYW9pN0YvM083WXkwUWNP?=
 =?utf-8?B?S21jdjlvc3ArUHdLNTFOSXhvVnpKNSt1S2ZYSTI4RlJTRU1VMnMza0FpSTZn?=
 =?utf-8?B?SUpzQWxCcHBKMHk5L2thZ20rdVI4ZVhXWTBPeC9UMnJkVmJVQXY1UDRhWDZj?=
 =?utf-8?B?OTVJS2NURzE1L3Bjc1lLd0E4VWtpZ2pJMisyWndsQXozNjZJa05jOFRjRnBn?=
 =?utf-8?B?dHB5QkptWkJZUWR0QzZmSmRlMk5qUGhyT0JlQ2hweGtLK1VxQXdTQUpaOGZ0?=
 =?utf-8?B?RWYxZXJmZm8wZlVkWTJRSHlaN0V4MWFDYTRvcFBLdGQ2T0tqQU5XN1J6STlr?=
 =?utf-8?B?TlZsSDNlQTFEdmlWMVN3SDJQOHp2SEd2Mk02ajRJL0RJT2tCZ3NEaGNRVWto?=
 =?utf-8?B?N2lzM21yMklBUG5wM1k1eUJhbFFlS1RDU2tTcEIwM0I1UnZmZGM4d1BJYVJK?=
 =?utf-8?B?V0t3TGhIbHZsazM3M0dQUC9xUndSVlJOVGMyNjlpUTdvZ2pNR1NtOXErSXM5?=
 =?utf-8?B?UkluZ090VG9iR3Zmc0VhM2p0cjcxTHVENSsyeEdsTUd5UzZOQ2RaR2VZY1RZ?=
 =?utf-8?B?V0JpUkdnSDNJelFpdGtncEYxQmQ3Ym0raE5qYjNWVHJ5QnMwK01ZcVFpWFN4?=
 =?utf-8?B?QlQ1cjl6ZjNzV0dnbERVQjV0Y1VEdlRtblg3MFdHeXFXMWx4cDM4UUJxeW1Q?=
 =?utf-8?B?YThrYmxWUlMrRUUvOW5PVHByTkZJekV0ZHVDOE93WlhTVCtIM25VclJpUGQr?=
 =?utf-8?B?cFRrU1lhMXVOeGRHaHJGWkNoU1lSOXNWckhoNHlhQ1lqUEMzVVl0SE5PcXY1?=
 =?utf-8?B?b3JyWkJoL3RSL3BWWU9UYXlEZDNabzBaeWpuSSt4VWRqRjNoV2dLYnNrRTZE?=
 =?utf-8?B?cGhHWVhYd1p0alRrVzVjQVgveHozeHE1ekxLTGZ1alNKSnVQYVFwYnc4dVZt?=
 =?utf-8?Q?i1jJVz14mchxAAOwfnpgti6gh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4492c2-6cf1-4e15-2a78-08dac0a83adb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 10:10:00.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chfk1amrs6ACwIP+7uVg97mZzobnktpLoU9FdAKzWdGKI0ViFQc5bT6ufZWuXZ4gRh8KyDyxFr4TV1DfEK0cww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4569
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_02,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070085
X-Proofpoint-ORIG-GUID: CBfdR80vOKMQRPhPcoZutLmyFv8aruxy
X-Proofpoint-GUID: CBfdR80vOKMQRPhPcoZutLmyFv8aruxy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>>    @@ -4289,26 +4294,16 @@ void ata_scsi_scan_host(struct ata_port
>>>>> *ap, int sync)
>>>>>     repeat:

I've been trying to follow this thread, below, but got a bit lost ....

>>>>>        ata_for_each_link(link, ap, EDGE) {
>>>>>            ata_for_each_dev(dev, link, ENABLED) {
>>>>> -            struct scsi_device *sdev;
>>>>> +            struct Scsi_Host *shost = ap->scsi_host;
>>>>>                int channel = 0, id = 0;
>>>>>    -            if (dev->sdev)
>>>>> -                continue;
>>>>> -
>>>>>                if (ata_is_host_link(link))
>>>>>                    id = dev->devno;
>>>>>                else
>>>>>                    channel = link->pmp;
>>>>>    -            sdev = __scsi_add_device(ap->scsi_host, channel, 
>>>>> id, 0,
>>>>> -                         NULL);
>>>>> -            if (!IS_ERR(sdev)) {
>>>>> -                dev->sdev = sdev;
>>>>> -                ata_scsi_assign_ofnode(dev, ap);
>>>>
>>>> Is there something equivalent to what this function does inside
>>>> scsi_scan_target() ? I had a quick look but did not see anything...
>>>>

So are we discussing below whether we can have fixed channel, id, lun 
per ATA sdev per shost? If so, I don't think it would work as libsas 
uses dynamic target ids per host.

>>> Typically, the SCSI layer has two ways of scanning.
>>> One it the old-style serial scanning (originating in the old SCSI
>>> parallel model):
>>> The scanning code will blindly scan _all_ devices up to max_luns, and
>>> attach every device for which the scanning code returns 'OK'.
>>> The other one is to issue REPORT_LUNS and scan all LUNs returned there.
>>>
>>> Mapped to libata we would need to figure out a stable SCSI enumeration,
>>> given that we have PMP and slave devices to content with.
>>> To my knowledge we have ATA ports, each can have either a 'master' and
>>> 'slave' device, _or_ it be a PMP port when it can support up to 16
>>> devices, right?
>>
>> yes
>>
>>> Point being, master/slave and PMP are exclusive, right?
>>
>> Never heard of pmp with ide cable :)
>>
> See?
> 
>>> So we can make the master as LUN 0, and the slave as LUN 1.
>>
>> Yes, but isn't that a little wrong ? That would assume that the ata port
>> is the device and the ata devices the luns of that device. But beside
>> the "link busy" stuff that needs to be dealt with, master and slave are
>> independent devices, unlike LUNs. No ?
>> Well; technically, yes.
> 
> But we already enumerate the ata ports (which is typically done by the 
> hardware/PCI layer etc), and if we were try to model slave devices as 
> independent ports we would either have to insert a numbering (awkward) 
> or add a number at the en (even more awkward).
> 
> And the one key takeaway from the 'multiple actuators' discussion is 
> that LUNs _are_ independent (cf all the hoops they had to jump through 
> to define a command spanning several LUNs ...)(which, incidentally, we 
> could leverage here, too ...), and the target port really only serves as 
> an enumeration thingie to address the LUNs.
> 
> So we _could_ map the master device on LUN 0 and the slave device on LUN 
> 1 with no loss of functionality, _but_ enable a consistent SCSI enumeration

Thanks,
John
