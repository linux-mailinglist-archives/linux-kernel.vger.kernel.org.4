Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394A361F390
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiKGMpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiKGMpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:45:00 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016B81B9FC;
        Mon,  7 Nov 2022 04:44:54 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7C3WcJ013598;
        Mon, 7 Nov 2022 12:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2zwbn8YvJimiiSa4u8jaU8kKFeTduYnibWVelKWOPeY=;
 b=O954ggi6wsxhWvylHx/d1pkAQJ9yuQRWlVplGZF1sfmJZGDFKlei3vCmDZ5pTwbNwSiO
 DSB4tS3DbRbHA4lliBYzmkib1wTniAk1OTsar8BCke7moqW1gfIwFaiXhodbQLWRxK/E
 DbZlCJQdO4hH1MOfTAqypiUDIxKLohsMzAWIeFV/Uj0aGi0pWuF8CQt5Jey2bR2n6xL5
 h8wullC4Y/azIEpdFJ1EiJQLb82PNQ5bx90vAdWiwivANC5AOBL8IKLDOm9nQFx4JROT
 E6VxQl76yrVCdm7tjk6asF9LvBGBBpWZ0ALF+th4VcHo1eWTIbLHfhSiFi/5Ija/G1wh PQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngkfusgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 12:44:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7AejkT007979;
        Mon, 7 Nov 2022 12:44:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctj8bd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 12:44:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEf/WJIdPw71LZxtvi8sP6VL2V9OZexEJ1nBqazwACk27ghduaWam+6TFhCqpuYlXvEwlX6zGrf0ZHrlSXLKMrlbO1yTNl+xIysTpkYlXpIGTHhlMGFUL8XJDEPIYDr3Pu4M9zs/wLPkfdwyPoWnIbGuXVis5m721fHa8ojThiRdv1tOJwhUsRAhhlgPiQFRVxklhxWlyEPc0WZoJX2eGx1VhxUF7icmYSY+7ahQuhJWxG86OaSLyU/YH4K/8gxlOj232+BhST1okPS6WaDq7rp7Q8PwOAd7RdY098U/Crcuj1U15kW0NRAcyfRtyr9rC3TpYEnV7DJXZ9vDlAPcZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zwbn8YvJimiiSa4u8jaU8kKFeTduYnibWVelKWOPeY=;
 b=DytK5hexOlik4ADls24Lb0fBfSFsgBeJR5rlx/ZeCmH813Ro3pWCIkOIbqkEi+Qyi+dwfYnC1qbcUv3I0j2Lc8NoHKOifF4XjhU2vv/WoEBfldBupdNzDVI2CgZski4CCb5SKMbvAXeFiKTStF7iEObcJ4qdLmjM2FsM7qs3VGoOocnQsL69lf2yHKBOL9Q/zurQsrIxMBKLvpiTkAAW/SHIcovgHwnDC9i/x70RiaTMYUkBGClOD2NK9381VbQhZKG7awx6G9mFYBMDiOZr0gQ49qA1zfK7CV///vWZFull+y2hysXMTvksobybazU834ZssTr2hmtU1V0PoWGbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zwbn8YvJimiiSa4u8jaU8kKFeTduYnibWVelKWOPeY=;
 b=MmQOu0Xq7hSV6LfvdJTHzMhU0ETAQorvX4AHB6m/F5zYXtO1ldltUZNhHQN332jOE/XSewkSUD8c9MUvtMXmsfcr95wZ5lYLQYlzkyiVK2XnTs0CUn6IColJqG3i6907QwjczuKP9U2NFU1zecUA8JGVWJsNoNpfhJxi7pDQHC8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 12:44:25 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 12:44:25 +0000
Message-ID: <6971d59e-2a72-2812-d289-53e61121f35a@oracle.com>
Date:   Mon, 7 Nov 2022 12:44:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [External] : Re: [PATCH] scsi: libsas: Check and update the link
 rate during discovery
Content-Language: en-US
To:     Yihang Li <liyihang9@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     bvanassche@acm.org, chenxiang66@hisilicon.com,
        daejun7.park@samsung.com, damien.lemoal@opensource.wdc.com,
        yanaijie@huawei.com, duoming@zju.edu.cn,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        prime.zeng@hisilicon.com, yangxingui@huawei.com,
        linuxarm@huawei.com
References: <20221102100555.3537275-1-liyihang9@huawei.com>
 <90217102-8767-b077-2615-1a5e41b58660@oracle.com>
 <43f496c4-4808-bee2-5a67-93e1114f646a@huawei.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <43f496c4-4808-bee2-5a67-93e1114f646a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0335.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 3269227e-6d69-40c2-c2ad-08dac0bdcd36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJjujQ4kc9F+4lNd83vaZOmsy7lUdcplAnTbaUuiABszUntM7J4eMqO5TCmOAMPGG3ZrimWl2VquZJamyoJ74SIHwQ8aLmUD+0hk7X1g9VDhvrosS4lU/sE9PxY4ZOnT2g6Ne8tBqJ9waKFfMDG6R70WUMMLEuMxiLDW9vKo3EgfG1kyBocxJYhWYCcKk25AoyFxbp3nUtgls21RAwQY/a4ves91edzN8fHS7Y81hNFQshcXu+T8J8CGNzlUKpxj39fQyn6tiXu3wSGgyCQXnKubsPc+NxTHTTePNgE6M3CLNDo/jNoqGobjwh2MlK9HXPvKbsk89P/mtDrP6vCbUwrYERqEv08QnHwN2s0bGLnQYPsu6M0MRgdqKWXbVqtfLOeRNP2D4LZgS6tN+6aLcpkdfyOF8DPKwqUTgymzYkquza4AhDnB3EAXDelFNN3KPKtiSPxV/ZKLDU58Oo0x+EAk8z+t1jcnmOfkeCYndS4x1l8mSxLsvMyYqVaK3zefNDB2XDmIUNkMHVIeIyP1GUjKyl9ftPizDvL4C+e1srNc1JCce8bM+Pup7wA51uB67geLBQ9Tjd4bO66uXQ5bNV83ZiA3cDlI6HQZACUdymGOQlY7cUA373MyYrPTP+mNyMHIzwtcwU5GOmvbIj3TUbjq4pFAiZoSYMOrWF7X682ZV7t2cbdQHSmXvnJCpeLVYVi7u2OB+QWBkAhHp4se/oxu+M0hPVFNDmHYw7I0EEwLI0Sx2rDd6ZjzhPjFmSQ6bNMbv8WE4qHOqyjdOchM9yLakVZXr2SpB6WDg6KYyxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199015)(478600001)(6486002)(5660300002)(8936002)(41300700001)(4326008)(15650500001)(2906002)(7416002)(8676002)(66556008)(66946007)(66476007)(6636002)(316002)(83380400001)(38100700002)(86362001)(6666004)(31696002)(186003)(6506007)(26005)(36916002)(6512007)(2616005)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlpKaDlCaGUweU8xS1hGY2RQOHM0TUdmN2JONkZ1VVg4Y1B4ZU1wdERKbmVq?=
 =?utf-8?B?ZmtDclNqMkdoRDAwbk1ISVpZUnoxT0kyN3JUcE43M0JmUDB6VUpmUHlrK2l3?=
 =?utf-8?B?TWpSN1ZpSHlQOStRbzc5NzV4TlhzK3VjOGsvOW1hZDgwUGhVdUVzRXViNUg0?=
 =?utf-8?B?Zmd3TGk5S0pKSjFEZlRQSk82YTAreGFvd0xZWWQ0a2pJSVY0UDNhN1JFSUFl?=
 =?utf-8?B?V2d0d0d6THJybE1lSExNa0p1UnNqdytJOGE2OGg0S2Znd0lOQ3l2UllFZWlI?=
 =?utf-8?B?Y1hvWDZhUU04SUt2RFFMVGNkbHNZdUhtTTJJR29TUWRXcEJOWjRxdDNMNC8x?=
 =?utf-8?B?dzIrbFdWWEw3NmpGdlRMelE1QVMyamN1TjdVQWpveFExSEtrbUt2bEw0NDND?=
 =?utf-8?B?bDRMVW9udU55bVJQY1FJK3gzaXhtNkhUdkVZTituZktxcXZCRWs4N0VGdktP?=
 =?utf-8?B?dXJkbFZleEcxWGk1K1p0Mmh6MkVLZldzZzZzV3RFOWw2bWlOVlNLeC83MU1n?=
 =?utf-8?B?VkJON05hUmJTRmd4SXJObGk5TndlOFc5bTJUQXdTcWVxejJWZGtpTFZjYlBI?=
 =?utf-8?B?T0FQQkpYS3Vpa0R3Nnd0b0orS1F3RC82M005WjBSZmU3d2Q1ZnlxU2FuNjdX?=
 =?utf-8?B?eFlVQ2E0YmRXV1lKclBGZjk4RFNXOGQyOXFkbEtYZDVYWkZFaUV0bGtzTnF5?=
 =?utf-8?B?OGJKdDNhOUh2TW5sR2NWS2Fza2dVektwb0lQcXh5MTIvZmlXL0lMcU9CS0kv?=
 =?utf-8?B?ZTFWcjJERGhqdnNrSTV0eWRMcUJYb0h5cUM4UFlyQVZaWGUvUzBhNlNYdGVU?=
 =?utf-8?B?Qlo5Z3NxMVNEazVZM1BvVlRmRjZxR2lkNEw5dm1NK3QxSG1WZUptWlNUMWpy?=
 =?utf-8?B?MFlWdXg5OEl5K1M0clc3SE1ockRqWlY2anM0QStnWDQ4U1RUZVo5OWlKQkxT?=
 =?utf-8?B?MjNlT1FKOUdOcFg4eCtHU3VZSllyczJwcjZ5RWJQem9MNVpnM3B1ZE9wNjRy?=
 =?utf-8?B?SDdHY2lhQi9iemZlS2NKQkUyWjBMcXpJbFUwQlVyVnB6RHdvRWVTWVFiOU8v?=
 =?utf-8?B?M3hzTlNJZmJRYklTblppYWJULzBVQzBVVUNtUldOY0tQZ0wyVTQ2dklqQ3p2?=
 =?utf-8?B?enM4d1NiTTZLNTVmVmdyTHdUK1MvRkpMMi94SXZSZ3BsbHpPMEd3QTBFbHNp?=
 =?utf-8?B?U01paEt3SXBKYjBCaDRKd2wxcm9JTmlXc096cG9iYWE3dncxbkV5MkNmRVhM?=
 =?utf-8?B?WEIrMExuSFVQelZkNzVvNlNTaTJCdEVDOVNkaVRScnR2blplVzRLeWNNcGlZ?=
 =?utf-8?B?azVMZkVETnJlY0hoR1ZHS296dHlvbWFraGEwYjM3TnBaejRaQ2F0dkEya3lv?=
 =?utf-8?B?SVBrT055eStmTnpkY1V5SnFsVzJwVzlJQ1IvaWpGeXBJNVJZbU5mMlJ6N2U0?=
 =?utf-8?B?TkdMUFpGU20ySXJVWjRaeFhUa3FSNzlIRDhlaGpMTE1WUWRtaWxDSkxxTHJ1?=
 =?utf-8?B?MUJ6R3VSTGxZNUwrSW9tS2l5TTRUR2NpMTVjQnVoaS84ZDFNeFZuMkQyLzlR?=
 =?utf-8?B?SnQ3MlRrRXpiNjlCa2M2TFVET0YzN3NGUUUraUhoREtEMTN2aE1JcUFWZm50?=
 =?utf-8?B?L3B1QjdQd3FnWjU0UEVFOHJ2WmdrWXBCa080aUZBa0lXUHR3UVdXVXJqT2Jj?=
 =?utf-8?B?ZXc5M2tuNkdMSENaVXBNMGxpWnVtdjRQRXI2dzJsY3A2TlF2RzZ1VDlIdXd6?=
 =?utf-8?B?cE9qNHFXQ0VWL05wUk1VV243MzJXMTVEaFhuVFc1SFRvckFicmVvT0ZaV1hq?=
 =?utf-8?B?eXVqMkVTVm83VEZPVVhRTW5tN2xxSjNETURLaWxIK3U5a0ZNeTRsUjFtU2xF?=
 =?utf-8?B?aFVSMEp3VmpJcmRJcjF3U2tRY0V5NDRZVEdCTVBjVE1Yb0pPVWk4Nnc1V2hK?=
 =?utf-8?B?MFdWanRuVHlDVmJBQWpQWW5oZGhmMHJlc203bnEyT293c3hjSGxlZ090Qk9q?=
 =?utf-8?B?UTZFbmJOM1p3aFhuV3JXWlhlZkpub3ozbUtUUXFabzh6dGdTczNSeDNqbVZJ?=
 =?utf-8?B?OWJlK2tKVE5JODNwaFVnaVBWWk13Z0tRajVhTmp6WEZLMDR5aDRXRnBqQW5u?=
 =?utf-8?Q?LPe9lhtISGlWGQNhzgBtuJhlt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3269227e-6d69-40c2-c2ad-08dac0bdcd36
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 12:44:25.2179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVICqlMtFrCPh6DPEjvazDEKhXxmA7ztkVr//VkjE6TcllJdPJs+MoB/TSKTeThdZao1VOQBR77QRZgHy/5Y2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_05,2022-11-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070104
X-Proofpoint-ORIG-GUID: d2HaTSkUZ3Ez4AtnAbLvGn_Iy_IjjAiD
X-Proofpoint-GUID: d2HaTSkUZ3Ez4AtnAbLvGn_Iy_IjjAiD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>
>>> SATA disk which connected to expander PHY maybe reject IO request due to
>>> the connection setup error (OPEN_REJECT-CONNECTION RATE NOT SUPPORTED).
>>> The log as follows:
>>>
>>> [175712.419423] hisi_sas_v3_hw 0000:74:02.0: erroneous completion iptt=2985 task=00000000268357f1 dev id=10 exp 0x500e004aaaaaaa1f phy9 addr=500e004aaaaaaa09 CQ hdr: 0x102b 0xa0ba9 0x1000 0x20000 Error info: 0x200 0x0 0x0 0x0
>>>
>>> After analysis, it is concluded that: when one of the physical links
>>> connected on the wide port is re-established, the link rate of the port
>>> and expander device and the expander SATA PHY are not updated. As a
>>> result, the expander PHY attached to a SATA PHY is using link rate
>>> (6.0 Gbit) greater than the physical PHY link rate (3.0 Gbit).
>>
>> Please mention the SAS spec section in which min pathway is described.
> 
> Do you mean the original text of the SAS spec section needs to be added here?
> 

I mean to at least mention the spec version and section number and title 
(in that spec version).

> Like this:
> 
> According to Serial Attached SCSI:
> If an STP initiator port discovers a SATA device behind an STP/SATA bridge with a physical link rate greater
> than the maximum connection rate supported by the pathway from the STP initiator port, the STP initiator port
> should use the SMP PHY CONTROL function (see 10.4.3.10) to set the MAXIMUM PHYSICAL LINK RATE field of
> the expander phy attached to the SATA device to the maximum connection rate supported by the pathway.

I think that this condition in the spec is a flaw. Or at least annoying.

> 
>>
>>>
>>> Therefore, add function sas_check_port_linkrate() to check whether the
>>> link rate of physical PHY which is connected to the wide port changes
>>> after the phy up occur, if the link rate of the newly established
>>> physical phy is lower than the link rate of the port, a smaller link rate
>>> value is transmitted to port->linkrate.
>>>
>>> Use the sas_update_linkrate_root_expander() function to update the root
>>> expander link rate. Traverse all expanders connected to the port, check
>>> and update expander PHYs that need to be updated and triggers revalidation.
>>
>> So are you saying that you want to lower the linkrate on all pathways to the SATA disk? In your example, that would be 3Gbps. If so, won't that affect the end-to-end linkrate of all other devices attached (and lower throughput drastically)?
> 
> Yes, this will lower performance drastically, but I consider the following two things:
> 
> a. Ensure that all disks work properly when the issue we discussed occurs.
> 
> b. When the user limits the linkrate to a lower level through the sysfs interface, the linkrate on all pathways to the SATA disk should be reduced.
> 
> [root@localhost phy-5:0]# lsscsi
> [5:0:0:0]    disk    HUAWEI   HWE32SS3008M001N 2774  /dev/sda
> [5:0:1:0]    disk    ATA      ST4000NM0035-1V4 TN03  /dev/sdb
> [5:0:12:0]   enclosu HUAWEI   Expander 12Gx16  131   -
> [root@localhost phy-5:0]# cat maximum_linkrate
> 12.0 Gbit
> [root@localhost phy-5:0]# cat minimum_linkrate
> 1.5 Gbit
> [root@localhost phy-5:0]# echo 1.5 Gbit > maximum_linkrate
> [root@localhost phy-5:0]# cat negotiated_linkrate
> 1.5 Gbit
> [root@localhost phy-5:0]# lsscsi
> [5:0:0:0]    disk    HUAWEI   HWE32SS3008M001N 2774  /dev/sda
> [5:0:12:0]   enclosu HUAWEI   Expander 12Gx16  131   -
> [5:0:13:0]   disk    ATA      ST4000NM0035-1V4 TN03  /dev/sdb
> [root@localhost phy-5:0]# cd ../phy-5\:0:1
> [root@localhost phy-5:0:1]# cat negotiated_linkrate

So do we reset the linkrate of the SATA-attached phy, right? Could that 
cause the disk to be lost and found again? If so, doesn't seem useful if 
that disk had a filesystem mounted...

> 1.5 Gbit
> 
> 

I just wonder if it is better to disable that phy altogether rather than 
drag every other pathway down to this lower linkrate:

a. that would be simpler than trying to maintain this min pathway
b. the condition that gives rise to issue is very rare (so don't need to 
burden libsas with supporting it according to the spec).

Thanks,
John
