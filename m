Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A8E6C110A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjCTLmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjCTLmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:42:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F80449B;
        Mon, 20 Mar 2023 04:42:12 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K97ei9008241;
        Mon, 20 Mar 2023 11:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uXRCDmo2CByeNnUG6A2sB/+8kXXCSnNU3JTvDXn+MBg=;
 b=tKdXlluswd/JJ5fySK0v5SLJPSIeknvX+ZCsJVAKnZrb/05PbZVnAV4yIcomqYE4nDPx
 JSYGtLBoLSl04fcFsQTVoM5p+9G/LsMfbxSrJcL5tfUbDkoTXvRQ45ScCQ+QQqaDUxew
 bAvM09herhtIQpihm+HxjCD3544TuE8PTcCrXzkDkn2sZGZ483Ggi/4FBvsdJyZ8yCur
 N0G8tV736GKC3x9zwd1ic1v4N+EcksKWm3LCbUl5I1CqLeX7PJ4OvIK4g4DCfCLOVD3r
 Mj77HVN1K/Y1GgzB4hcrwwhp51I3p+69rlwbnP67KU3PHe/A+AUQehkqm9s+lhrz6qAm pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd4wt36hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 11:42:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KAbJhe014391;
        Mon, 20 Mar 2023 11:41:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r45ndd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 11:41:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahE+XppD3fnaaeu7SE5XDvEev1VJRlwjaslTFpBFZAh1ebj8MdP1965XpMeLrK1nxmrkhs8laayLGpvAuYbthlFZzl8yDwRdaHigoKJzWVUzVuoO3YY5QU3ifkgscbJSEn9kq5mJHVWXO4d6BQj2QCrowS9CUt8VU9LhcxYV0j9rJaBbhQOQ4qS8ZRi1UQA/AbyXFw+hH1XsxWssZpifGYUVGbiz4rvvPefmyXR6sAVl/Z7e8s54Y4ICq4t3diRKGKLNA+JCafiQr6+OBtjY29FUSGZn+Df2GHA3EM6OXjGuEBXkObP4gQlhyOcpPLdqfaB+DO+sGJOIogUCjeNuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXRCDmo2CByeNnUG6A2sB/+8kXXCSnNU3JTvDXn+MBg=;
 b=Wr8sGwpsX7SDTl6YlmZQhXTM4ouewdlwcNm72ITWQe1QqyhC1NDB0A+yzGvNNVf6esspmU4QruMbC6v6+ipAQUPLrrQFS9hdELN62zfScqtAn+m7AVmfBsWLeyV4pAsTxTcC43psEjvk0TfVQ+4EbLXza81VxNLARNPd9suwNQ7YvsKzKQFjNer+GtVLV4CM/afDNWmLLChsTMN63ol0ZrAGpYa0dci6WwpQUi9Shg+JQJchtea3d9zyIUyyjhiz7F0nT8p58b5XQk2LwH8CHG8Xpx185LwlHr9NOIEhO6KtLoFocsKgBK5uLxdsQbEd08B9vAbMQH0EDWn9rQn2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXRCDmo2CByeNnUG6A2sB/+8kXXCSnNU3JTvDXn+MBg=;
 b=ueliRu+SRnLGthHpewAdveSi7WwRdZVksmCNx5IjdWpUeZEca/vmivjymjHb5TeTtjx6DCpz3NutlQgpGKWhPD3XuvQdKJ8CtMe4mr0APZrDRVXVDqmLzo8f1R0PScRiwhfY63RxKWQNEXN4PueAwDtMEL9QLpfDX3ycmKu56/4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6130.namprd10.prod.outlook.com (2603:10b6:510:1f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Mon, 20 Mar
 2023 11:41:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 11:41:52 +0000
Message-ID: <92a2d9c4-cc7a-6a26-07ea-b49ecdc920cc@oracle.com>
Date:   Mon, 20 Mar 2023 11:41:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RESEND v2 09/11] scsi: scsi_debug: Drop
 sdebug_dev_info.num_in_q
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com
References: <202303201334.18b30edc-oliver.sang@intel.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <202303201334.18b30edc-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0026.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::36) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e3b0c6-bdf7-4412-5ff0-08db29381935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KqCpkhjKjytBJzFtf/FZLaGK+/gNBJwyD7pEKoh84bbnVDvVDbWSMIPn6lUYLbRechfHxXAJwxeCOqg+k1omo6meHv3cgp36OUbcVuAcLZFyV+23GjZxFJN5helZm65hCSzNnb/FnaUWJhpsBBqe0IF/QtTaJpw+rzVbWx0X+fxHBeTXJ1ZmqnTtzXsISEykI1byakjIw0G18v/vFnc0zbisYDFNwNE9idwchw9ykLsygfS4n7/rIF8VL4pXcDp4OOirJ0IDaHWHcouPORHAUDFJWrfGLFsk4twEaFLNaULk+jHf6U0W+WKAvzK4CVvF3ctybWsNMp+XwIhTXmsX785YmVNcL4+frUvjnmP00SikvxZUXcT7NQwcWVLl9jr4vRbS8Cxr/jyKBqiJA/Ew0BbaaRIKwX92jhK6YvwvJWKlXuCbIOBOCxHFfGfGTRelSyv8l4TBd+N9WEe124KLf7DcRWMmfeO9/SOnyGAJtJn3StgTkP6IchjKc6kYvZ0Rx+fojTAYzU8WjpebjyJdu9fGupKrzownbggsvho5vZlrF0URoQWFc3Hjp2fIwqL8/pU/1Ne23cAyJhc+s6z03sP6sW3xlNvj3Nvg4w8ruJjIAwcUqIjJndAmF3EMjpVIsBqq6QDyA182Eg+/Ou1Gdr28lyxkeZojCCbOG9YPXiQMxfI3PD6CqdF1zEWydEeU/gfsL0uk0Jzl3i42YsTX/iSzIgHNvUZ69B3xy5TYRq23iGOqJyFRbFwRDqG9HUsF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199018)(5660300002)(66946007)(6916009)(8936002)(66476007)(186003)(8676002)(478600001)(36916002)(966005)(4326008)(6486002)(316002)(66556008)(41300700001)(31686004)(31696002)(26005)(84970400001)(6512007)(53546011)(2616005)(6506007)(83380400001)(38100700002)(2906002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djlicnhXQjVtZVpDbE1HemtyYnR4WCtqOUFGdUt2aGtFbjZoV3Jlai9oQW5r?=
 =?utf-8?B?bEU0ZHRqK1hsV3JacmY2eUtLM0NBSGIzYVRwS3Ria0dpV01MN2xQNGFRcHp3?=
 =?utf-8?B?S0IxSFRab2dpQ2MyeFFMSmYrZGJNMzhLeG83eFh1V3crSUJZeW1WekZvSmIr?=
 =?utf-8?B?RGZ1VDVVQVBNWkxrTFBZRFV1TnQ1c0NiTnFqcWRrOHpENTdudnllR0s3ZStU?=
 =?utf-8?B?cTdPdlFBK0ZObmFkNzlvMVlKc0IwTWphUjNjcDh4UXEzTFhHcG5DNW10c09w?=
 =?utf-8?B?YmZhY29CcG80eXgvbEQrMDR5ZVBoM2pFZWljZFlvZXJsRmVUVmFIRVJaUk9j?=
 =?utf-8?B?SklweWwzb3F0enhPZ0RBYUlKWUd4OWJnaWNTNXZvY2VxQkNXNFZHUkZWOHAy?=
 =?utf-8?B?NEVNK3BFQkMrNFJhM0ZsTGtBd2t6VjZWWUJ0Q1YzZGN4S1BIQUx2MUo2Z045?=
 =?utf-8?B?emttRlo4NUxxRjlvZmVGSTU0RTAwV1F3MlM4RjBPanVsbThoZVFuUjZqaUlZ?=
 =?utf-8?B?aW1ubjJmanQ2ZC9tNkhzbll0OGtGWnI5ZzFlR0xKR291TnJYZmFPbjFYUmov?=
 =?utf-8?B?WVdKS2U4UEcyajR6V20yYzdJTG5Ra0JPNXFHQWluME8rL1orbk9yc0VySDBh?=
 =?utf-8?B?Mk1BRENyVndkLytRdlFpbjVQL2FXUEs2b2xRTU41eFFzN2R0VGY1NklKcXhK?=
 =?utf-8?B?dE9rNXlodFBhOTdCUmE2TUFWd2l2eGozbnl3UWlFR21HSXlXQ01YUTBkYUNV?=
 =?utf-8?B?VTNPTnZLUFhubVVKcjJ0d1pWTW5KNnltZ1NjUWdXV3R3V1BPK3F5cSt4OW5J?=
 =?utf-8?B?WXFFNk04Sk80L0ZxRjRvSEQ4cjMyMk93L3JxSkRWZ2VVZ1IvS3NacXlnb1oz?=
 =?utf-8?B?emNaTitFTVJKbkZHUWVKL2pxeVNreW1vRTRrL1YwU0JuckdTQmdjaGZkNW5O?=
 =?utf-8?B?Sml4WXE1TXJadi8wSmJLdGh6VVY3dm5KUFh2clN2NFpGQ05NT2lZY1NRUjg3?=
 =?utf-8?B?WHBhMGtHbUtqKzBRUnlPRzN1UjN0OU9xeVU3SVJxb3BiQmFPZThEOTlEOEVE?=
 =?utf-8?B?RGpOQnFMakE1T1NWTWtDQ1dOQ3FZTUN6dkdWcjRSYkFjSDFpSHdoUGwrVmQ3?=
 =?utf-8?B?MExicHYzMjJTSVdoTUUxUStwWUdXd3JrNmh0ajMwUW45M0VPZHdtbUJpRktU?=
 =?utf-8?B?VnI3dzVoTWg0eGJsUGVkNG0rcVZRSnhsQkU5YkxTeml0VTVMUitvZ3JmVWJq?=
 =?utf-8?B?YjJvZVlqU0prREZiY3FId3dkajFNV2JYcUwwNVJRYlVxSFFGZUpDVk11T0U4?=
 =?utf-8?B?Qjh0SnZTZXpIZDA3Y3lEUEcyN29sbXFFK3VIb0VjVzNCdk1DcDk3MEpPamMy?=
 =?utf-8?B?eHpaUUlETzFXSzI2M05sUnlZRXU1TUFsMGlqZGgrb1FqdCtySGZadzEzcnhG?=
 =?utf-8?B?emltV0x2a0kxSnBXVmFXMFFnTXowaXUreW5wRWI5MjQ2RDlJeFpESlhZYUZP?=
 =?utf-8?B?c0NLV1pxQnk5T2VMUGZHcGtQZlF2aXBIVEdBUnF5OFQwUzlhbW0xTkR6Rlhw?=
 =?utf-8?B?YjU5RFhmSFJxRVYvNVh6VnJVKzRXb0pna1BoTHpib3RaVzh1cllNV09KdUkx?=
 =?utf-8?B?SDM2UkF0dTBDc1hkYXpEdFBvTzJoOEZPcnlXMVFNaVBHQWJVd3Z6YmpUYVEr?=
 =?utf-8?B?VEpDTnFycWVhODVPNndjM295d005ckl1aHl6T3FKNWlzMUxBQlJRYkViZ2Rs?=
 =?utf-8?B?c0dIYWlnOXlaMWNYQUFpeFhUVnE2eTBzOEJhbjhlZmJ6MURlYkFyUzRUbStO?=
 =?utf-8?B?OStXSm1VVVVKWk9nNFBJOGhFMkkrbTBNQzF6aTM2YkZGNXRISmxZSjZDS1Uz?=
 =?utf-8?B?RTVmYVJQaFRjY2tEUFpON1QwNGgrMGVRSHkzdWlObk4yVkYveXFXVTZZb0k3?=
 =?utf-8?B?aWNTSTZuMWlnQmdjUzNOVWVLTDBTSVJVekRNSHZzN1hHVTc5Q2YwcFVnQU4v?=
 =?utf-8?B?TkZidDhpMkZFOEdPV0dvbzhpMUFaTDdzMzVoSUFEL1p3cGdFMVFNNTZLQWVz?=
 =?utf-8?B?elZEQUN5d3dlRDRkYU9SaS9LT216WmE5V3o2amJXbmJ2a3JuQWVVdzVnc1Fz?=
 =?utf-8?B?MnM0d3EvSkg4c0lQSU9YTkxRbFpkcXhaOW1JUTFJSk1ody9uWWZSVXErZ09m?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BmyWPlVw6q0txQ3aB+3IQF29+OYEQgY9YWcwK8XerbxkNqNU8R03ZAAJpbmtoLImTFBGx9k2R9HG+nWmzJ5c2Ml5zkuPvU5p3ao1AD7UlcVX5tnvHxnXJ6umaqXzxRP7zzPTH384KO0/BDlRvQpwW5oEP+yxXmJJ0eiRPM7/lKJQ5/uGij2H1JQ1lJ1jEWIQ4wxPkovljeZPTUxFC9v7gajkikHSanBAJPoa9wfIWvipSx8yTzA5qrxxs/5BsTh0JhrLBLqw5mBZG7FI/F3fo0L4kBzkz6mf9ZSPwB8sK6S/l2saMgSCCdEHIDyWdrHPgVewb6E1ykaP6FAET5A1ybLuGbznysdF4ClArqgkrHF6FYX3f1mciItllaLNIav8Dbup8VQ9B/nRqNuRdvW+bk1FL8Z5DLcsSg4jlp8Mi162xDQ4i3Y7V4vbrAsbx4FlA227jBQ/FyRMlPJ9/NGjoMgNKUbRbwnQVmUOkHiSQfJsw6TsEnmmjHNnE848RyNxFdxPVHZjG2wqh9t0UHTeeblgHcOViU6I3rBcBWK+KMobz/M9lx6ptZWvUtWnM3XDzSKOqpj8JqB93QU2WH9I47Em1FByfiw2Oxg5QJQLQG5QB5xalqPU+ItYFcaxVvy6l3e6q7A+aYEYPsU/toOkMPRU+r3ckAW5rbav2AxwLStRk5sfHpNqUhssrTHoT6fJUt+8w4S8CJoY1joCvl42GbuTQnDz+BHANZLh/etzEkMGtwSrj9fgSitu/3DK8dPoPKg5Fo4cyzZcm4ddBncD7MU9f8nyR6+FFiTkOTYq9s3Avh3l11mdnCLpg3b77T+OQgjfFNQtnan5KxVpxrZfN/GOKAufEak32yux+qAJ0kGy/9q9iurnk5qzdgvNupmvxZfF8F/QD/qKljsL9soX+yw2LSsIqTCVoTtdI32IrkU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e3b0c6-bdf7-4412-5ff0-08db29381935
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 11:41:52.3391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCQS9U2zpDwXCqG440jDRjraQ2NPSRvZSALmrK11AXLKKpJi0S0RtPdoC6a5/ITNrn3uSmxuZCAtKyC/JgYzkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_08,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200099
X-Proofpoint-GUID: n-tl2jFob84X4nbEd3P22m5ylrWpoIB1
X-Proofpoint-ORIG-GUID: n-tl2jFob84X4nbEd3P22m5ylrWpoIB1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 05:31, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed blktests.scsi/004.fail due to commit (built with gcc-11):
> 
> commit: 76fe86662c283bf322ac1e032c46ddaa0da5cb16 ("[PATCH RESEND v2 09/11] scsi: scsi_debug: Drop sdebug_dev_info.num_in_q")
> url: https://github.com/intel-lab-lkp/linux/commits/John-Garry/scsi-scsi_debug-Don-t-hold-driver-host-struct-pointer-in-host-hostdata/20230313-173528
> base: https://git.kernel.org/cgit/linux/kernel/git/mkp/scsi.git for-next
> patch link: https://lore.kernel.org/all/20230313093114.1498305-10-john.g.garry@oracle.com/
> patch subject: [PATCH RESEND v2 09/11] scsi: scsi_debug: Drop sdebug_dev_info.num_in_q
> 
> in testcase: blktests
> version: blktests-x86_64-e3f2ca5-1_20230228
> with following parameters:
> 
> 	disk: 1HDD
> 	test: scsi-group-02
> 
> 
> 
> on test machine: 16 threads 1 sockets Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz (Broadwell-DE) with 48G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202303201334.18b30edc-oliver.sang@intel.com
> 
> 
> 2023-03-18 00:18:58 sed "s:^:scsi/:" /lkp/benchmarks/blktests/tests/scsi-group-02
> 2023-03-18 00:18:58 ./check scsi/004 scsi/005
> scsi/004 (ensure repeated TASK SET FULL results in EIO on timing out command)
> scsi/004 (ensure repeated TASK SET FULL results in EIO on timing out command) [failed]
>      runtime    ...  1.467s
>      --- tests/scsi/004.out	2023-02-28 16:52:49.000000000 +0000
>      +++ /lkp/benchmarks/blktests/results/nodev/scsi/004.out.bad	2023-03-18 00:19:00.232079954 +0000
>      @@ -1,3 +1,2 @@
>       Running scsi/004
>      -Input/output error
>       Test complete
> 

I'll check this now.

> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          sudo bin/lkp install job.yaml           # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>          sudo bin/lkp run generated-yaml-file
> 
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 

