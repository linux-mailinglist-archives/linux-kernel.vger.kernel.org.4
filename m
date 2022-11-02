Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5315861603F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiKBJwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBJwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:52:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA8D1AF36;
        Wed,  2 Nov 2022 02:52:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A28J4OL004208;
        Wed, 2 Nov 2022 09:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zsXoiZKJ+BvQ1JF4GudBWw7+P03EqpP2RneR4fxD4z4=;
 b=gm/SBs70Zgo3aZjhFJZuzmW23eJndwXOGSuGlKjX6EEkO4rdA5x5xNe1AwhvyobpDuLj
 Ddg7C8v5lwCFsqmKSxXZj7RKtzFrGagPOk4/u7vO65zhbCop6othfyhmhFDRVuc6lTFX
 AnYU7dolkuNqIK7fEgalakK1SwyQ9mrll4Wcui+QjF6EtAimgggLicR7aLzmArx0lUE+
 qebGGtU1DUBso+TOaIiPedPGIzjuIT5xVPL6yJIeKFA4CBia+SzLw38mqHzhPfFu11Ik
 FNBhfit00TNHCYPJrUmFJP2NxcXGvrxTV2eEbsCxCFFmTbRAWqIaBWOEC0VBuXrWSFSl XQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts198g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 09:52:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A29537T037480;
        Wed, 2 Nov 2022 09:52:10 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmbn9ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 09:52:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGtu8F0wJpldpAzWSH6Jq/hesu2KSNWQ23FCP/jUKt0KupxbcgRePv55S+w/xuM8zGuAGH82oyupRSES5vWcxrnPxr0IRaHuJDFcKR2egxegIji+6zzs7Pt4maF4kIwH0wyLqqEa3QVcX2oMadtY9ce9+8j0WMPEUUKtvu/dk51P1ajkPDxFzo6cR/PESP7hcqsh7Ft1ANyjezjqP3zFxQk5z4DiY8W8FEweFunseBCtwDvGssI4Nf+JOvvXZHfo1mX+YLScM9UpxbR2+7+zNdVtmoFaUkSaiVBxjhj0l5VWcxLWi9qn/5f2BS3jo311N9+F5CvYr5HQ1AiUOrotkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsXoiZKJ+BvQ1JF4GudBWw7+P03EqpP2RneR4fxD4z4=;
 b=ZLa2/FEgeEnsfq7gf0HZDDUCfd+VwVM/nOVvdoZ88eFPWQp87Z+SDW7vuelwmNpQp4D2I1nlPSaIl4sFzsPt4UFWk6BTcWjh5ZE0f/bv+HOR4YmhFNuloSzR5mYs9cwELxGT+TmJHlBPXzyZ4Yr3eI4SdyOPBv0xSCJWSPj/fqro63ueC74ypCCBLFPYzal1zKMYvfKmZIF/vWNiZfL6ry3ExBmSsUGUhYjhWMURpHvasR7+zMlnZUGEu/QFLdzrlbxUy0DbxlIunpH8ZmxeHfPhCMxW8PPseiOWW/wJzmRI+HPagSXs2ROPVWDA2oN5Kl3Kg6ijI4yErjXyVeyd8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsXoiZKJ+BvQ1JF4GudBWw7+P03EqpP2RneR4fxD4z4=;
 b=YdQ/DQ1oHKjvMV1mNYL7+KoMAX9fXCMLy9kTZFN0Fz7ee7ZSshNibHtIre8jApyXRMG0oS7GTAoVJCzHlm1+I3RkclXNafDgBYMWYy7SGR+aP+YXutVjgaV82p1WTqjV1B2hLFO0DYTUQ7nucHsc2JfgbS3ceLZutZ5akzO99Jc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5157.namprd10.prod.outlook.com (2603:10b6:408:121::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 09:52:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b%4]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 09:52:08 +0000
Message-ID: <05cf6d61-987b-025d-b694-a58981226b97@oracle.com>
Date:   Wed, 2 Nov 2022 09:52:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     axboe@kernel.dk, jinpu.wang@cloud.ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, john.garry2@mail.dcu.ie
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
 <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
 <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
 <9a2f30cc-d0e9-b454-d7cd-1b0bd3cf0bb9@opensource.wdc.com>
 <0e60fab5-8a76-9b7e-08cf-fb791e01ae08@huawei.com>
 <71b56949-e4d7-fd94-c44a-867080b7a4fa@opensource.wdc.com>
 <b03b37a2-35dc-5218-7279-ae68678a47ff@huawei.com>
 <0e4994f7-f131-39b0-c876-f447b71566cd@opensource.wdc.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <0e4994f7-f131-39b0-c876-f447b71566cd@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0354.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: 230bc314-f8bf-4ddd-98f1-08dabcb7e80e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: naOcKIYigR40FALRtuUN+CeQEiMLlEGQOunk1TUyhfkT9CSI8lET6G5mFWiQm5kS2mAOwrWyXTuQZW3xIJPSPb4bdDhrO/aB46Tb9rS1VVmNHQ2MJ28yDTJnwIfWASMhhrIBMYBg91PM855q2cZgB70LeULyO6HqIhWlQYBFZYyn6Mw4xR3jSzV7biB4ko3Q/vl0Vh0e5Tk237qmch2+a8fYekqtOrSHLViVR+4zl/ag5xylzBs7V9RKh7iirbdWNqU5CkvsS3VJ6jBMEwAbnlBEZWBzLfLPKl9udZC6wO7woE+gqUsJ7OpTcbI07EppTZ3qRk7aXe/pWY/3Et0/IlybU78AbLM0knGHPKROEK3QKzauzt4yNLH3gV4VLi9sI7o2eGkURbb5y740/yb56CZl8cCM8QyYAVw3jjdmeJZRyHjCv1Tk5aIYVb2Ef/2m/qbw5CSXV3myj44uE/1SVQoO6pUc3TWVZm+trHreYuaFKIGzHhsJhLYWQBqt0dKjmhH6oIywryhIOXAa5/7xit6gRFZPSTnXl3pJYfHBGUzSfNWhJ0kxED2Qjgfv9kBFN7wdVgC7sWWxweHqfqP3tNreI8EytfjnNwOIZh5uqNIhWfGXIFuBv/BJRqc7YnZzp3CmHwDqJvW+o7vcAjOeY8cR025QGyYRlKNvv6hHM23Oy7QrzbPHNeArS++8moW7WlDH7e+0AilXrjBiCOd7c7+w6BYXmDBxAy981uXjpw1qAB8EPx6ypvhzm6Pw7IjWwfLZ/E+9qgLk9pGL6m2/rnRl/HMcFe6MQcmisRpmlyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(478600001)(66899015)(6486002)(2616005)(36916002)(66946007)(6506007)(186003)(8676002)(4326008)(2906002)(66476007)(66556008)(41300700001)(26005)(6512007)(5660300002)(7416002)(8936002)(86362001)(31696002)(83380400001)(31686004)(316002)(110136005)(6666004)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdRWFZXWURjVU8vR2hmNm12czZ0RkhVR21kc01oVmhqKzEyckhjbHhGSUJW?=
 =?utf-8?B?QTlJaURYR0x1ZVRDcUlDK2lxZWNwRS9VZjlzUDhvaFBOZnN0OE8rTW85RmxG?=
 =?utf-8?B?Y0xXUUNJaXVIZSthc0VKbWRJZTVoSEhDL3BCb29GTHdxWmpac1UyRUZBYUUr?=
 =?utf-8?B?aS91eUN6Z1hCaTNjeE55K1lqMHFxaWpqcFdoQUZaM1krUEpjVGtadFBzMkhS?=
 =?utf-8?B?dFFNYWJFS3FJbERhVzNZWEoxaTc5eEVMcmFoSE9BV0lZSmdsNjd1MUp4OTR0?=
 =?utf-8?B?aXYra0FQWXE1Vk8wWHRZTzFXdWxMZkV0TUJjZjNKZEVCMTVVcnJQRGdKcTMv?=
 =?utf-8?B?VkdpYVliSXJadnhOL2l3Y3NtSHMwdUc1bmpHcnJWQjdZd1VMMnVxOVVUOHNW?=
 =?utf-8?B?MTErMVJJUjZLUlRwR29zTTV4V2dSNHNSR21mQTBIL283OWp2TnpIbWt0OTk0?=
 =?utf-8?B?TFcvN2VGbmxsSGw2NnhKcVpNbkNDRW0xZEVlMnVoS0pPRzR1S3RFN2ZVbE1x?=
 =?utf-8?B?UHBvM2FzYkFpWW1zWENJY1haZHdUQVQ5M0srQUZlWXpLdlV0UFJ2YitDU0Q3?=
 =?utf-8?B?WktHTWs0bHFrR2tNREhFVUhZTGF6L1VpQ0ZyaFBxVE4rRWJjL3Q4Q3dXN2ZT?=
 =?utf-8?B?dXk4OGlham1VZmRzbm1DM3A5aVlYdjRrRkd3ZkE2cHN4bTBvR3JSTldZK3Vy?=
 =?utf-8?B?UlMwVE8wMEF0Q3pqWjltWkEzZXlYZm14dDlwWHlIL3ZkUXBmQ0xFcnpramQ3?=
 =?utf-8?B?cDVrWGxBd1FrZ0J4cnFNRGpoYldyeFh1K3crdzRTejFGZ20rSlhGQWZVaXlm?=
 =?utf-8?B?VTN1dUEyWmFCcFNGNkZYaUh4L3EvWm1Jb2Q5YmltTjFtUXdLWm5wN2xkUGpN?=
 =?utf-8?B?V1RuYlk4RVB2djVXQWlTL2RjUEs3ODZQRFVQcWx0clU3Z1pNSDRlSWRWSkZs?=
 =?utf-8?B?T1pZLy9ybGZFM09ORzdndXZ6dGVRLzNkNHlEM2ZlZHFqQll4Z1NrV2NUNzl0?=
 =?utf-8?B?SUQ5WHp2cTF6MlNqRWowV3ZHcTFxbGlqa056eUNYQTd6NHg4WjRzRVBMeVpu?=
 =?utf-8?B?bFQxVDMzQXgvcE0yRDdKMEwxODZmNWNFaUxZcnlsQ0lnNktPODhGVkU5S2tt?=
 =?utf-8?B?ZW43Vnp5emtyOEVaSjZXdHJIS0VyYzdMTGw2d3Bpek1ZMW9TZmxNamtDZnR5?=
 =?utf-8?B?OCtGVDJseU5VTVRUajBWdFYrdkttY09qaXJxTlBzVkFzK1plQ2lYeU9JOUhF?=
 =?utf-8?B?bjhrOGlpKytVeUd1c3N5dVhTbDFZeXdWUnYwVjNCcldPZnBhMDFoRnZkTDBo?=
 =?utf-8?B?S1U0UGVFcGh3ZG1yY2J1OU1kMWZ0RUkrdDJkUUZETVozTDd3N0RVd1phRVVG?=
 =?utf-8?B?MFpEN1RwOGJzQUtCNWEzdjV5bWM5L2RxdEsyRlZNQ3JaZTF0MHRaWHBSU2lx?=
 =?utf-8?B?c2NPWmUyUHpyb043TEtBaEozSlJFcTBBVnJtVC9YZFpoOCtKSndQWlFxZHJt?=
 =?utf-8?B?RjFNZmdNRTVybXpwL2Z6d0pCRXlYbndoTTNXVU8zdkdjWHBYRVowY2RXQ0Ra?=
 =?utf-8?B?eURVSEpoMXlmMkhQY2drUWJOcmhxcG9ONDhXQy83WVBMN1M2d2lNcGlTZWJN?=
 =?utf-8?B?dzdnL1ZyN0VpcThmS1BjRFJ1NWZGYzZKQWMzWkF5RHpqcXp1RTBncnR2bWlQ?=
 =?utf-8?B?VjhKRHVGV3l5S25NM1F5MlVBa04xV05xSG0vM1A2dGlTWjJHVFlES0dKd0pJ?=
 =?utf-8?B?ZU4zeVkvVjQ5UlhTbzBBWG9na3BDSDBabnZNWHdocmYvdi9BdHhjL1VhV015?=
 =?utf-8?B?ZHl6U2lFb1lMeUh3L09ZY3lMTkdvdEVIcGJqSVk4RFBFVjBjb1VZbi9RQWNl?=
 =?utf-8?B?TGtoOVpGdU5CVG1CTUdGMldnT2FpV1c5bU1UTUR3SDVMbm1ZOVBESVVObmxi?=
 =?utf-8?B?TllnV2ZKL05hSmVXTUZvTHNYSkFSb1B6Rm9ueS9jWUs0ZElxbU9ua2Z0cVRz?=
 =?utf-8?B?YkxNYk1aN1pDVWZ0OXpUQW9MSkZqUTlxK2VZbkhQVXAvYWlkcjdYOFl3T080?=
 =?utf-8?B?NkJ5NERrRERaY3U1VVVKNWRUc1RGLzk3M3F0anRCd20xRUd0czVwZnd6Y0E3?=
 =?utf-8?Q?7fNmp4EFbZpapIch7zIcTwi1j?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230bc314-f8bf-4ddd-98f1-08dabcb7e80e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 09:52:08.6685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iewYQ67poaO9aGVO5G0TdwKU/pT4SeGLx2jui4X1zp5qpx2ZF5o5A1gPmzcc0j6511om8PU8xmM5cJfgwQhJhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020059
X-Proofpoint-GUID: urrtxwAO7cRU6tXHGc9ghJrZ0aGgVq0Q
X-Proofpoint-ORIG-GUID: urrtxwAO7cRU6tXHGc9ghJrZ0aGgVq0Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,

>>>>
>>>> Please also note that for AHCI, I make reserved depth =1, while for SAS
>>>> controllers it is greater. This means that in theory we could alloc > 1x
>>>> reserved command for SATA disk, but I don't think it matters.
>>> Yes, 1 is enough. However, is 1 reserved out of 32 total, meaning that
>>> the
>>> user can only use 31 tags ? or is it 32+1 reserved ? which we can do
>>> since
>>> when using the reserved request, we will not use a hw tag (all reserved
>>> requests will be non-ncq).
>>>
>>> The 32 + 1 scheme will work.
>>
>> Yes, 32 + 1 is what we want. I now think that there is a mistake in my
>> code in this series for ahci.
>>
>> So I think we need for ahci:
>>
>> can_queue = 33 >
> Hmm.. For ATA, can_queue should be only 32. nr_tags is going to be 33
> though as we include one tag for a reserved command. No ? (may be I
> misunderstand can_queue though).

Yes, we want nr_tags=33. But according to semantics of can_queue, it 
includes total of regular and reserved tags. This is because tag_set 
depth is total of regular and reserved tags, and we subtract reserved 
tags from total depth in blk_mq_init_bitmaps():

int blk_mq_init_bitmaps(.., unsigned int queue_depth, unsigned int 
reserved, ..)
{
	unsigned int depth = queue_depth - reserved;
	...

	if (bt_alloc(bitmap_tags, depth, round_robin, node


So we want a change like this as well:

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index da7ee8bec165..cbcc337055a7 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -390,7 +390,7 @@ extern const struct attribute_group 
*ahci_sdev_groups[];
  */
#define AHCI_SHT(drv_name)                                             \
        __ATA_BASE_SHT(drv_name),                                       \
-       .can_queue              = AHCI_MAX_CMDS,                        \
+       .can_queue              = AHCI_MAX_CMDS + 1,                    \
        .sg_tablesize           = AHCI_MAX_SG,                          \
        .dma_boundary           = AHCI_DMA_BOUNDARY,                    \
        .shost_groups           = ahci_shost_groups,

I know it seems strange, but still 32 tags will only ever be available 
for non-internal commands (as it is today) and 1 for ata internal command.

> 
>> nr_reserved_cmds = 1
>>
>> while I only have can_queue = 32
> 
> Which seems right to me.
> 
>>
>> I need to check that again for ahci driver and AHCI SHT...
>>
>>> But for CDL command completion handling, we
>>> will need a NCQ command to do a read log, to avoid forcing a queue drain.
>>> For that to reliably work, we'll need a 31+1+1 setup...
>>>
>>
>> So is your idea to permanently reserve 1 more command from 32 commands ?
> 
> Yes. Command Duration Limits has this weird case were commands may be
> failed when exceeding their duration limit with a "good status" and
> "sense data available bit" set. This case was defined to avoid the queue
> stall that happens with any NCQ error. The way to handle this without
> relying on EH (as that would also cause a queue drain) is to issue an
> NCQ read log command to fetch the "sense data for successful NCQ
> commands" log, to retrieve the sense data for the completed command and
> check if it really failed or not. So we absolutely need a reserved
> command for this, Without a reserved command, it is a nightmare to
> support (tag reuse would be another solution, but it is horrible).
> 
>> Or re-use 1 from 32 (and still also have 1 separate internal command)?
> 
> I am not yet 100% sure if we can treat that internal NCQ read log like
> any other read/write request... If we can, then the 1-out-of-32
> reservation would not be needed. Need to revisit all the cases we need
> to take care of (because in the middle of this CDL completion handling,
> regular NCQ errors can happen, resulting in a drive reset that could
> wreck everything as we lose the sense data for the completed requests).
> 
> In any case, I think that we can deal with that extra reserved command
> on top of you current series. No need to worry about it for now I think.
> 

So are you saying that you are basing current CDL support on libata 
internally managing this extra reserved tag (and so do not need this 
SCSI midlayer reserved tag support yet)?

Thanks,
John
