Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4150652EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiLUJno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiLUJng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:43:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECBE1EEEB;
        Wed, 21 Dec 2022 01:43:34 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL9WPsR011086;
        Wed, 21 Dec 2022 09:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cP7C9trSn6+Q/W5Nqf5G2qG9chsEYcA5kOC/cZPbCIc=;
 b=T/9S8anfM0wSspMqnC6xBlFIjQqX8ZPOcwoPDgSVb4rJWvhl6wuhc5XrDBWOgMglkUDn
 BVUcNNkm1u0ws+CpzDFgFBcmuDHRyXRkKdPiKxzG3bMSyvlkgNLnakKv+NbAq9fi14nQ
 wEfio/pHSC+rzdtddtYEVKcXUY3xPlIqju76Yh0QG8t4AoHiqQfRPaBJF2BkxaecpZkv
 U81QJvlY6BVV0DeAhDSgrKd9EucGvlh/UKN7/92RLf+LaTBgqluRmMYsc0HvXD28OewF
 hKt11PmRCJduj0ihsPUhu3jduRVgKIhJ+EDS+3CscmOs9Y0gBFZ/6fTcR9qZvrefnJi3 Xg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tn0dq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 09:40:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BL8wogG009669;
        Wed, 21 Dec 2022 09:40:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47cq4xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 09:40:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FopP24jSfQggrygEyPtUczzBr6PZLsq/FXE4ilhHKKnTkmsFzQJFLKIlbXSsOojpD6yVECXikabHo1R+pKBnXPfuZrjAQYqvFbugjvtzpe7rYSRr3+WKqs5hF1xQKRGpsvC5pttVFpDM1DhrMPTXmEMkOlXn9109yoqkwGKDpzRPTtHLgyknlRt0vwVvGBQasI0gE39affAhYLEcOOsyVdIidrxLqHwSOcTaIUneZOSJOERK6ayDwcvM2SX8K7XvaPjhCF64vB3ftFRROpm9ueyXnxjCMvaInJaorsj6Rc3fLmX3UcuLzXhFY0WaY3tnI28OFqhOWZUlgvA+YDJCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP7C9trSn6+Q/W5Nqf5G2qG9chsEYcA5kOC/cZPbCIc=;
 b=OPRfEPEOpscZrIqj+5dKLPAceKVlbvc6tbc7X1Nt02Pqjss5kMYcxzUmSg+6wqLCHbnHd040tjQlC9hnjL1wD+2l55bxfeiVpweFrt+PSk7rDjqfamaqWtpvp2kaxq8zvUx1EPT5qH10z1G3Kr6xk37YRG/g/Vodzx6js45IKkLGT+UbJnF7EtvVVrU7W0ABOyq5zLR/0sZ9G/11km9NQS5bJHlEZ874y9/UlDodeNbUf7Vh5YU1xtx3yJC7k05J8wfbr2jnr0PAeHaqeyY+q/q+X0dlQuUiKHQzsmIZh7bqmQW3eju+5ZaxIQ7d82Fi7A3medx47z+YdzTDkefIKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP7C9trSn6+Q/W5Nqf5G2qG9chsEYcA5kOC/cZPbCIc=;
 b=ej2s7AdUZEs96sBBvD8H1ozKry2sEiYyxuUqjzhzK2ZOfdPcDuznk2vWw3Wh0nl/6HdQ1QC/E0CdPIM0cHK3MFXspBdpob+8J9kxPXn9/SjLfiba3tN9mZpKfUHX6PXC2wjgl/mBhpS88Z2LA0eET2owxu0wHlwraaFNmcKND5w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6679.namprd10.prod.outlook.com (2603:10b6:303:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 09:40:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%6]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 09:40:49 +0000
Message-ID: <ad3804e6-37f8-aa43-19f6-2ef30c0ccca1@oracle.com>
Date:   Wed, 21 Dec 2022 09:40:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V2] scsi: libsas: Directly kick-off EH when ATA device
 fell off
To:     Jason Yan <yanaijie@huawei.com>,
        yangxingui <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, hare@suse.com, hch@lst.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20221216100327.7386-1-yangxingui@huawei.com>
 <565fcf28-ec53-8d74-00a3-94be8e5b60e4@oracle.com>
 <f15c142c-669d-6bc7-f9b9-c05cc3df1542@huawei.com>
 <9b8da72d-f251-9c1b-0727-28254d7007c3@oracle.com>
 <fe4ed9f7-4032-f1e2-d6c0-6a7bc99ec3b1@huawei.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <fe4ed9f7-4032-f1e2-d6c0-6a7bc99ec3b1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0411.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6fa0de-9405-45b3-da65-08dae337715a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRXJHdGzquaF7ltg770JN8fpw9uH+WWnDqixDQIiNDVoRafoZBRuWPhWixXN4hCNG/LJYkZa7cNvrolqCOyeVc+fNr92bG4bJWgU1RRRPNy959IVAiQatCGbEe0YrZ1VvRSBzm/j1RQwlj+nPqQrVxXCnLHQBgHju6Z6GBHZ3sQw6tpyLxsvRozuHzHESpVWXDcBRzU3rdxK/kVwbX5rJmYH4QO7LWvirAj/VNf/g8R7LvKg/ccYvztpKKPMDaMecDLz75GhK6LCCbJRJLMDVpq7mcWMMwwUl1JoDL9zgsC/USOn7RNNvAtzEXKx+JBBExUV53tLhyisygXFCiIcDG6bWwZiZxRnxA1BVnzgWM9Pn/V4CHNwp1v4wxK7JKpY3JRZrwgEdmzATo4TG0mhTW2bJ5Y7PxVf0hKgV5p976DO5ZX4/dYG78O73AsYKJhhDoesFi899Q1gC8onk3OJlE0dv+RYp+ynoxpmObhEcZMzcG1k7sORoqkJiH2Dpav8Py27dmauKFK7vdRHCLnSIkmK6FbTgUjRWA75dibKciXvB48uNmGbboDd9cMlhTMG2VaefPFEQ4NfYkvgFuDJeoQbYdFzzxJJLkgrbPl7rLTTA+9I7u52SiRXmKuZw3Ss6Hr89pLHaKXVqrXifrIHSU7qynNVznSLuCFKODT3H5cgL2PGHDRr0fgOysBeSqntmeZVtFNde6aM1ai7DBQH/XD2gPceatnJE5HHbHnHoss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(2906002)(53546011)(6506007)(36916002)(316002)(7416002)(6486002)(478600001)(110136005)(38100700002)(4326008)(8676002)(66556008)(36756003)(66946007)(86362001)(66476007)(2616005)(31696002)(31686004)(83380400001)(66899015)(6666004)(8936002)(6512007)(5660300002)(186003)(26005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDlHcXBaa3RnUGdSMUt2MUpZVng0V0JDL3JBNHBQSFhFL0FTYit4MDVkY1pK?=
 =?utf-8?B?U1JTN1FZNTdjcFl3WnNVejJBTXZGVUNTRkQwSGRzSVJVSnB0dlRIeTZMTk4r?=
 =?utf-8?B?VzE1aTJab1QzYWQ1NCtFUEc0NUFTV1VkQXhySkk5SndNbitpK0FSTnNmZkhX?=
 =?utf-8?B?WURINldzeThZcUxESUg5RjljYVhkajA3OTdBUzJ3TTY0aGtUekVYRUtaamky?=
 =?utf-8?B?NXpjWDROVitvUEpJakVUMkpad24wdkZnelZpbkM1Y2hLWHlvQlpCdlI4UjdU?=
 =?utf-8?B?MGx5TStlWWd5SnZMdktkbDlSdjhKYzdzaUV5UE00Vk9rY1BvT3Bxb1hoQzYy?=
 =?utf-8?B?bW1sSDBOUWdIVjRkMXJtdm4vTnNPcE5aYllKdHdrWnowcGlSdlB6Q2srS0VJ?=
 =?utf-8?B?WWZxSW5VemR0ajB5M0VmMUxHV0loVHpUUUxPMDdXeExCNjZkZnJVdzY4RDZ1?=
 =?utf-8?B?anJpaTRTc29hQm1CaHJMRlFvUWUrYmFlMkdJN0hKVi9YNk9wTWx3TTJUem9W?=
 =?utf-8?B?d2dvb2psWUxmbnVINlU2M0JLL29lRmRNQXpzQVBSRlFZaXplM0FBeS81YXl0?=
 =?utf-8?B?MDI1amhTTkIxTURJZFBwd3FTb0tqRXBJTDhsZG56U1JSK2VBekdaQjFyZUdJ?=
 =?utf-8?B?UlE4RXUzZkdkd1hmalMzbFFVNzBNSDJJTVliVEFlS0oxWVdKV3l4Unk3R0F3?=
 =?utf-8?B?amRacE5ORGtOK2RIWlVnK3BYVjQ2eHJjY3pnUVpkNkhhdk80Umt5aHBCdmxC?=
 =?utf-8?B?aGZuNmY5ZUFscVQ2b1JZU3cyVGZLOG1zRVVrVzR3dkFiMkx6ajZTRHUyYXlC?=
 =?utf-8?B?T0hhdTBSRXRmQ3k2ZU5QZEwrcnJlZE4vbTg0b0w3aXBYTHB5NlprbzFpMlRB?=
 =?utf-8?B?dll2b3RpUDBOMTVoQU5BQlVTb0hOdEd2b1ZLNjUrZHdpWVVDUkpyYU5oa1Jr?=
 =?utf-8?B?UHVWTDVnY09TSU1mMHVuT3VRNGkyM210YzhVcnJpVzAzYmwzay9YRUZYNklT?=
 =?utf-8?B?cW14dGRoczdIS1hLZ05lWHU0cGZtMzNCSW1RQmlRcDBBT0xmRE5sRHZMZjNN?=
 =?utf-8?B?VnFjNWJqNDM0R1A5OEZIeTNxVDY2OTFuKzNoWXNZRm1Bbk1rdFpvZ3IxYUkz?=
 =?utf-8?B?VDVodUZYT1FUelpNTnZnM3haSEdEUGdocXN6b3FVNGRsNU9oQ3FDaklZR1Ew?=
 =?utf-8?B?b09FTTZBNk1nVjZMY0pQbTVrNUFIMkg3bFo0Um1GTmgwMzQwdnVCd3pMVUxx?=
 =?utf-8?B?RUpBMHl6U0VaSEpwWGt5VWUvOWx6cTNjYmNXc01xb1dXQ2t3RVNxNUwyMkx4?=
 =?utf-8?B?eW03azJYb3F1RlZkZ081TGhqMC9BTnNES2Q3R1c3b0JmNjFlODUzR0RXMUU3?=
 =?utf-8?B?MTJHa2UvajdTeUdCSDhidjFuZXRlb1hHd1dReGQ3MHkvQUtuZy9ZVC9LMHk3?=
 =?utf-8?B?eWN5TTRSWituRlRwdlpoeWNMWmFoaWx4bFN3MXY4Wm9rd09QSVhQN3lnQVFB?=
 =?utf-8?B?VHFRSFF3d0FCejVIbVFoRW5qd0IrdGZtOWhTSXdwN0dqN3FRQW5keXl5ZTh5?=
 =?utf-8?B?L3ZvU1BVcFRWSldrWFl0a2FxdytxT0ZLQWtKUW1KRk92RGJ5dk1HbGpncG9U?=
 =?utf-8?B?ajNKcjZaSDFzWnY0OXRtS01CcW1RRGpxOTBuN0h3TVJVM3pOMkk1ZWNwK04w?=
 =?utf-8?B?UWQ4SlpSTTQwMUtpdGp1Ni9Eam5teUE2QTZaSTI1dTN4OTlZL0MzT2NZYzhm?=
 =?utf-8?B?NnhvU01zQ2lFbEdDbWpvQnJQTmp2dTF6UHdmbFh4ZHQ1OThXc0RUWlFPZStN?=
 =?utf-8?B?bVBMaWYxY0ZKL0xDR0F0Y1VtQnB5S09tdWd6ZlRzQzNOTmcrR002RFNKOXdr?=
 =?utf-8?B?YVE0QmZRclljR3pzU2pjZWJ3VEhhZTR1M3JyaGhrMXUwLzVyQmQ0S3pvaTY0?=
 =?utf-8?B?cTc5amFad214YmZTMDhDOVJvZm1TY3B4MnJZTWNWVU1VM21wRWRYcXc1SzZz?=
 =?utf-8?B?UVB6NHVlQjNITzJ2Ulk5NzdVLzZVTjAyUzgwU2JTRG1WUjZ1QnlRbFkwNExi?=
 =?utf-8?B?bGJsSllSOXJKRnpkdTRWallmWEV6bUNpcERGN3FubmI3Sm9vdmtrckh6ckJI?=
 =?utf-8?B?RkJQbkhZMFdrMmZSRXdiNWlCSDBma1FTTGtsUzdraUdhU2JKSjZwbG5tc3Fu?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6fa0de-9405-45b3-da65-08dae337715a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 09:40:49.2707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHxeV7ogC5KilcPQf9wUkcIfQtkuIazAwDjWJbVZkKHdWtBqB0hAI+FHNy9cPDlpRrKUoJ+hDUWCeDx1zW5tkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_04,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=890 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212210076
X-Proofpoint-ORIG-GUID: GZI_XEkqX_2lfmP2Cp6LNBV1l_wiQuxi
X-Proofpoint-GUID: GZI_XEkqX_2lfmP2Cp6LNBV1l_wiQuxi
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 09:49, Jason Yan wrote:
> 
> Itering tagset in libsas is odd.

Itering with block layer APIs is just a method to deal with each active 
IO. However, libsas should not be aborting IO directly. It may provide 
helper routines, but the LLDD should be dealing with aborting IO.

 >
 > The question is, shall we implement the aborting from the driver side,
 > such as what sas_ata_device_link_abort() do. Or shall we implement the
 > aborting from the upper side(scsi middle layer or block layer), such as
 > trigger block layer time out handler immediately after we found device
 > is gone?

As mentioned, aborting each IO should be the job of the LLDD. However, 
just making the IO timeout will lead to EH kicking in earlier, and EH 
will do usual per-IO handling in sas_eh_handle_sas_errors() that would 
happen when the IO timesout normally - so what are we really gaining 
here? Just EH kicks in earlier. But we still have the problem of all 
other per-host IO being blocked while EH is active.

Thanks,
John
