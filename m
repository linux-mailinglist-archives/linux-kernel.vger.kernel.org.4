Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A8F6E8FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjDTKWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjDTKVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:21:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55468421F;
        Thu, 20 Apr 2023 03:20:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K80P8P020806;
        Thu, 20 Apr 2023 10:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ox3y3yTqW7KErkc76WXBWWDEnNZTF9n+KQJz1xhXAMM=;
 b=vvmcIu1nEHwc/UFj79loq3Z9p9yLNqzYfLd6arDBAOpCv+nusZzf+GyqzAFvLWFWXtfl
 76rYg3R6cbwUL16aGN9PKIHVY1RO8HYXWav8JF6UEgw7ACgmOw/8wdG2ltwLiezo5n70
 pJmq8PoOGDzJzEoSwyQ2Y2Xxms7KWMf5K2SYcanE10uAO4dBsSSPGTSLWhTqp2X+y60O
 sHUd+zv4c/uI/61N6WQq7l72pj1zNPyHvz4dONphZ020RxtQ9r68YnS0GveCiH++mB9V
 1XllDje6PvKiFPNc9pBxcTe8CQJuYYJc/ddFCFei0KxspEfkUdQ3e2wbjlJVPDJZx6li aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykhu2dqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 10:20:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33K9L0NM011049;
        Thu, 20 Apr 2023 10:20:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc7k9ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 10:20:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWrqiDyeAlrJVyNoFfGFqM1znImRM6WT6W2B577EIkYuw+y5N2orCixcFikGrFcUHgTkSWlZhfgbHcqF2M/1dQUFAXm3vQMYyBFiLTS8J+Lh3ugcbTFwKlATt4lwLaACf0edm+Z6xn/4/Tv3aYaC5e8NDvtKRt96fD4x6B86elcYZwps8O9i/L6n/uTGOtP2RAHwOOYPHZKLXoVpN2y9JejwlhsCBKQA8jDHngGz8AwJm52Qh5b9z1idmbJmgYxn1lX6GJTZXrt/Na43M3ujnS5POi/xEWUSPBY/RKBDQJDzJnDV0QXFjArTp9H2aRdUCn8yktcoKBU2aN9PlTqMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ox3y3yTqW7KErkc76WXBWWDEnNZTF9n+KQJz1xhXAMM=;
 b=VVkkV1VFDuRNk2x4Q+ff0W3QuFEhoJCBO1Sp7QG6JcVYTfBRshPiNSdAzVoNrU32DZRQvdcTDKUM0QBFRVCnGgoNC1GJdceVg8zSSTpCY/dVp8iXNiJpktDzGCuiVIdPihgf85BAkwmrbMESJt2VrDAVz0hbFS36oAyDTZuJBRgwcFGoIELxr2xgP/+RqKzAHf+sn9FgjwCXtdvmXuHIjR2jacwIlk+SpLcda7QIMOEYICF+Wj5CxLODmYv7JiUPaCiWtik9PzbOg5E2+xdWwrQcNMTzAMp6Vgm/EC/1RYIW2hctqDt0oWrOPXCe66HniNN00W2CO7FwdS0sBmFOAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ox3y3yTqW7KErkc76WXBWWDEnNZTF9n+KQJz1xhXAMM=;
 b=R2DY/UltgcTYp2zNjE8YlMPmFAY1TIn1f6Su4EW8skearI0pc1GjI7ShqTCbxZe8sUjjKu4TtFLV9t9ROlusid0r0/cK2PqQ6I4RGSIYBuDYedQSLW/eCdG4XAidM8vtBLLOiM/Pfnk9T3pusGaSbVuCN9jGvnUUBeo+301c7p8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7278.namprd10.prod.outlook.com (2603:10b6:8:d8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Thu, 20 Apr 2023 10:20:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 10:20:30 +0000
Message-ID: <aa86ac49-ffb4-7a4d-8333-bcf3a9b99140@oracle.com>
Date:   Thu, 20 Apr 2023 11:20:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] scsi: ufs: mcq: Limit the amount of inflight requests
Content-Language: en-US
To:     Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20230420101116.173-1-avri.altman@wdc.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230420101116.173-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0217.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 225cad2e-506c-4b44-6df3-08db4188de18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TI/gUBnccH3Vlmpp/5YLzNjaO0Mum9Li8cDWkh6MyanBUaY+3z80KWsbHWHUbfb5PhoKHQhGcESZK0xt1aisZucnOaVAnbqchp2qzmJjioiYzCUI6RrbjCCnynawXANbCziVYbT/EEL30SV0Ot/+jleeb+hCMM4n2okXqzPE/Iie2LeXz3ZAAywJPkDNLxin1zoG+ovcmiiN7kifvIQPShFivZL4VfAyYU26/zQ7PGI2Ybj++awcwtLG4d/jOUYQS6v1uTdVAxMWE9m3P12aAhANhvMUJ775YlfcZUWqG3ggy0XZ2fYyNVj0C6An2deBQdHVJ+cDV+Wezf7naiMmk9LBsjxAoXBKDw4M4u+Pwoadtjlcv7WWv18l2edb/uvU5pNurOsR+Qejb0nGhnnUdEPQjL5qezZOP+DsiXWXe44inmt/6IC/7Re+WbJ8MO608r//4ABSPswAKtYCazv4WCEm2AA1jR6pUUJipVd8in/TVhwKW7PUqpACracKlsiAGaJSqOf9eHdMeeO0R1m0BDQiilNeYVRnMFmMwhAZ4g7FPlX7pc0KAOTF6kCmKkjB0nrcDbn4ka7VIcQ4bNndh+505EgQqgIA+Ydtp/C6XL1vhFNiFYQfQfw7gyaG+K/VVcQyCfg7JGTi+XAzvKF6dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(4326008)(2616005)(66556008)(316002)(83380400001)(66946007)(110136005)(6666004)(66476007)(38100700002)(36916002)(6486002)(478600001)(6636002)(54906003)(8936002)(41300700001)(26005)(8676002)(86362001)(2906002)(5660300002)(53546011)(6506007)(31686004)(6512007)(186003)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azc1TWtFMHkvVGNJb3JHNHJVZUJqWXJ5TTVVWVVqVkEzeS9EWHZ3RlZId1Zl?=
 =?utf-8?B?bWJQWkljUWhVSjZFaUVKS2drYzYwRTRuZzV1SlFmZDREOGVQb2hGNUNkZWpB?=
 =?utf-8?B?TDFZSmNLaC9teGdqN1Y5Rnp5M2k0Smt0VlNJYlRwMjF4YTdqREx1YlRKWHg2?=
 =?utf-8?B?OUFiTmFzaEFlc3poV2RvQVhWbld6bW9tL0V5NWZTQ0JOMW9ETVl4OTRjdm5U?=
 =?utf-8?B?UXZkL2FiV09ISHVqOTV2WGlvVHhQY0tDN2thV25xN0wrTzBzUVc0MDk0Y0RW?=
 =?utf-8?B?UDJvYUN5UEo0Q0djYzBHWnBkbHY1akx4WGxWUEE5M01EMkVVMEpqQ2JGWGJR?=
 =?utf-8?B?WlFmd0NLOElKRFN5dWhJM25qeEdrTG5NV01mVkpCeWFRdG1YeFZLcXIrTmNj?=
 =?utf-8?B?MmZTSnc4S1B4SVlDS3MxWEJ2K3NZb1FvSHluS3lvNWN4aUpTT3p4RWhzOTZT?=
 =?utf-8?B?Z3Z4SXkrdVNEUzFvd2tTMWpCaklIS0VxYUViOHN0K2dUcVVUU0p5OVFyeXQ5?=
 =?utf-8?B?Qy80VzU3RGJ6ZEQwRHNhYTNXVERWaHZIaVZhZ3hhR3J1RGNLV1ptZEdabXJJ?=
 =?utf-8?B?QnZvUFdUeVFFZ3BRTHBuTWpqMDZ2TDMvSjdod0ZxODBlNmYwWXV2aVlKWUp0?=
 =?utf-8?B?Mm9ZL3ZGUzdzTVZGQzRWdFJYVWxya1o4c3E4VlRMNFdCVzlxQlFoWFJJa3p0?=
 =?utf-8?B?NFlqdFR4N3dXZkE1WlJKVS9RYTZhQmNKNWhpMmNmdGRqSnhuQ2FUNURtNzY2?=
 =?utf-8?B?ay9WdVBHTDZ6dWdhcXNvYk95aXlkZGw0RVowZzkyUHhWeGhGK0xLMk1CZ25N?=
 =?utf-8?B?aUtRTGNaU0JHZU5BUXAwUGVwRk9LaG1hM1AyczcvV0ZnSWFzQXhRL0tQNjM4?=
 =?utf-8?B?dkYxdlhlN0RCdGJVR1k3eml5RzQ5dXVSd2g2SUpIUVBsdU9BNkhnd3QrVVB2?=
 =?utf-8?B?OCtTRms2Y01FWmJrTm00c2VKMml4OEVsbkJodWpoKzJIVHMzdDNEK216Y0R5?=
 =?utf-8?B?TmRZYTE5dWQ1L3VLVjNHaC9MSXNEaDlXeXA1cllhTW9HNWlQV3o4d2VYUU5q?=
 =?utf-8?B?TnBEM0Jtc2lzMUN1UHFQVW5YWU05dHoyU0pwNTA5bnVNQTFGM2xmZklvdVR1?=
 =?utf-8?B?QlBSTmt4MDdTMUV2S3ZFS3hRNW04TDVmeHdGS0g1bzNqWStsaVVSbTE5VHQz?=
 =?utf-8?B?TG5TMVlXVVVxeno0Wk1lZ3lvRC9xQkdST2VxalVscW9VOTNmUmlMQll2Ymtt?=
 =?utf-8?B?RXRSZ1hDWnJHTlByeFlQUnJsYzF1VjgwZHlIRWhxdmdmc3VRdTkza3Z6azNn?=
 =?utf-8?B?Z3RXTTd5WFkwcjhmd0lEaVU4b21GeDhXcVBPVFUweE5yM2RGaUZlcmpEb2RP?=
 =?utf-8?B?SWduc3p5eGduK0d6ZUpvZGN6dDc0bVBoRmZxdUgzcWxYbzBUZVBLT0lKMUNy?=
 =?utf-8?B?UDJQNUFtOGRiRFF6OGExSUZCdXNqbnlPRjB3YWsrU3gxZTdCSHpuNFpUUkxj?=
 =?utf-8?B?czZXOFlLWnlBbmRQWC8zSWhxdVVQWVozUU9GUjFKT2UzUi92YUtzNzhkR0Vj?=
 =?utf-8?B?Q2pVek14ODR5U2NaVzBaTzV0UTVJM0Q2Y2dQZDJHaitGZWZjWjBMSzY5RVJR?=
 =?utf-8?B?T1dMa3U0eUJ0V0cxTEJpSUo3VmUwc0lIVmJqWkY3TUsxeDJqQ0dEWmxEa2pm?=
 =?utf-8?B?QXdjMlovK3ZqdVNEMWQ2VDZScGlIaWtCcHcyd2FyckFnaVhJUmFCRFF6OTBB?=
 =?utf-8?B?a2gxY3c3aVNTN2JhRUZSOG1zbWV3R3dKeUE5MEM5UjRrSm1QYkN2K0FvUmRi?=
 =?utf-8?B?T3JJbTg4ZS9RYWp6SFVUc016WlpvZkRKcGZHYzVTdG41emtpMHRucUl4UzM4?=
 =?utf-8?B?SjZZYmhhZ1QyNlZCTC9BUEpyVnR3WkFFN0I5MURXeGRNUTdJVC85aUtkV2Er?=
 =?utf-8?B?Wnp0L3lhSndjckc1MGZRUnlqa05KUUdFMzlWL3JIaFhFd3owdHU0SnlPeHNK?=
 =?utf-8?B?UTcweG8yTzZ6REh5RFlRY1IyQXhKUUpKQ3UzcnczQi9hY2hqd0g5dVhnWVQ4?=
 =?utf-8?B?U3JDcERCbjQxUXBKaVJXTGdqTVZPZ1FKeFlMVVJQeFF1N05senBWaXJlNXpB?=
 =?utf-8?Q?tPMP/bZlUShvtNu7WBrXPsl3E?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qpKI9J//c7zm83eObxt/vy1e2iBgBEovRP6lyt4bPtuDJHsvUnzzV/FJ9lnCRaQKJYnnfwLespG64naVaBDNpfC4t5yfyhHYXCFOntKLLX2U4JD07td3Pn0F6t8UjDKhVatPhF+QhjJmZbKg98iA9ta4WexAbNG6PG9L8rI0qA6vFKbuNczr+ouC7bqEqh1qFbMgavTnt4Go287ooVuDfhFxsjzOO0Ux4zrX7OzIgVFha84boH+u7boo8Ad4B2X0bsV8Ln9fy2g1U5YEw6FLsxzm3o/iGoUBK6Q45BkQ8F4WX1viZMcIaEzLCqqIK9cgfCXH5yzDY4xMbgn0XUGseQZcwivc0FvZF8AFdNVd3nWo4iTzEWlVGf85Bj/MBWahryLTHQssqGD1aJEIKZRLh+1pPyafHlfSZYUt/e7kbX3+qSymomnYcThfbYmDcA3SJxqZruxQZZqPLQxDAKjlgLW0jUpUt0n0LFF243S/AXz9bUQY35/xCab1pbL9N9WHqKdkdJE/ZQwth9j83mVzrirSADYLJHA5mtLFZChf8uToMubo9MsM0st3fsbKBmTL/qPCIVGr4IQEGg+4Tba0uQ9dl/ez3R2Vwbrekq4OjQq4fG6houswHiMq1jxHWJglXo1Ew0iPYBoVnEXv/pSeWfAv0ivzAIEEDM06CJr+yefHo5P8IlKH6YY0SEnH9joW8GIF+UJgpVzvoReOts9mkLNNOaD4b/SlPYoifzusVXua+ku2rZSsKPrZla9yHJi9lPW4KWtbMQMs6hHZHNgbbKh86iMSjXnSyUvq35R2HlcGRZzWamStoqtitHwY0t6/2PS+2LJOhahhoM2CdX26wT3DEGiRKfVZtpdjo7FGLtq+bMgTvrwGIyGo1iFgbwlHoyhX/avsjT/YP1N8KcDQHg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 225cad2e-506c-4b44-6df3-08db4188de18
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 10:20:30.3289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vh+HWxzDaP/zyQqx3QR8BJJPAFxpMceFTRUsGGoUvMwdO24XJvQ8wwyTV+IWzxtVAaYoARp5JX6PMZOqUdX7og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_06,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200083
X-Proofpoint-GUID: I0uArLAeHMYvGidL7l84x5dnNAz7nwdC
X-Proofpoint-ORIG-GUID: I0uArLAeHMYvGidL7l84x5dnNAz7nwdC
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 11:11, Avri Altman wrote:
> in UFS, each request is designated via the triplet <iid, lun, task tag>.
> 
> In UFS4.0 the Initiator ID field is 8 bits wide, comprised of the
> EXT_IID and IID fields. Together with the task tag (single byte), they
> limit the driver's hw queues capacity.
> 
> The purpose of this patch is to document the ufs spec restrictions.
> practically, it impose no functional change because a) the current hw
> supports much less (merely 64 requests), and b) since shost->host_tagset
> is set - then the number of inflight IOs is limited by just the HW queue
> depth.
> 

I don't know why effectively it has no change, as it seems to me to be 
checking and failing something valid which could happen.

If it really cannot happen, then we generally don't add what is 
effectively dead code just to provide practical illustrations of the 
spec. And it is misleading to others who may use your driver as a reference.

A code comment would be a better choice, if anything, IMHO.

Thanks,
John

> ---
> v2 -> v3:
> fix smatch warnings (Dan Carpenter)
> elaborate commit log (John Garry)
> 
> v1 -> v2:
> Attend Johannes's and Bart's comments

This is the wrong place for these

> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>   drivers/ufs/core/ufshcd.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 03c47f9a2750..9cebec6be35c 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8468,6 +8468,12 @@ static int ufshcd_alloc_mcq(struct ufs_hba *hba)
>   	if (ret)
>   		goto err;
>   
> +	if (hba->nutrs * hba->nr_hw_queues > SZ_64K - 1) {
> +		dev_info(hba->dev, "there can be at most 64K inflight requests\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
>   	/*
>   	 * Previously allocated memory for nutrs may not be enough in MCQ mode.
>   	 * Number of supported tags in MCQ mode may be larger than SDB mode.

