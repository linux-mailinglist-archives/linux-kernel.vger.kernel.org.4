Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D20E6341EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiKVQxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiKVQxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:53:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0696011835;
        Tue, 22 Nov 2022 08:53:30 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMFpEOo000582;
        Tue, 22 Nov 2022 16:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XZqQ2JsitzRTpgyDKkcU3wCB9Q+QDP2GLv31NLcxE0A=;
 b=PSse2l+PUzq3BG969KNe7ut+BbaeW52kZIAXc0OiirtwtJ4ZY86W2jpzu9CaswGchx+h
 0T1H+ZlzD+NNuaW0FIfWTvx6odYQ5cZFElj51mkrjS2xhDOK+nyypW9qoea319eF9NCt
 Rdxj2pOn7sMlIZpozavkxXVMQ5W4bIPNZklETKSv3AMet/HmNlF5HyNX8hwwUEioj3OY
 Y82bjH+NaxITnginbOjzOGdOOfrZyQ0rLFcGRmewhlbwXfPsAWv6izrnw3uuWrKpxnzw
 +4j3q66neYkAuWG+FV/+RrGRD6GasvmH6KVMDcHvC69Jv7s7CagtAte9tguGXNOWk2HH lw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m0gas32nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 16:53:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AMFdlZj008314;
        Tue, 22 Nov 2022 16:53:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk54q81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 16:53:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIlxDuavHzsQcHwd2x+mH52NEKY6RIZjla0LKc51lGyfPKpx6v5qlla5X856XyNY2iCDWpxUuGFkIiBScxrc21GXrEpdY0jxpaxsNpi7eIOPzQZO4Qhq2piRzZWqTHh+ncc7Fy6/XlbIFiVSWG/FrNx+e0i+zElzxpSssoRG3kozs2/LbEdcy/fiCOJm2/9sncXjmEKnOzCs9qiaRFgy9xz30ivlUQrUWZDPxyIYhCdxJy9CPLs2chq7ivwg0Mr9gp3/x8882P9oGhmU/qy+/U8jPgY/z1A1mP2vXvtEna9dqwade/i/W0pnDQMH1ohjCs4aTyqx0nGOmKXMuMpwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZqQ2JsitzRTpgyDKkcU3wCB9Q+QDP2GLv31NLcxE0A=;
 b=LCeZOfWIpooGjnUmLNe1OXsWq1vV83c9+a97m9maAncSggSFl9ylF0IwFluR4NJmYREfXLcqk//lN7S3WnDcA+Ro2Sp0Sq41bJOq3q3p3LcD0ljbBtybZQVm6Ru8QXTiKbQXsnJEthUsopSValLJnnIIkzFnMOs4/VrwQP5Di/6xUuCi5oIOng54e8VgMZd419WcymzATUctreZUZL6Uc9Wam+Tfx+hArzC1Y/e3elJGOFarEn1ncdRzLKqi0WywLCXhNHMIARzeC7a1tjnr7qliid+evPr0mtZTn3fIuwPVAMk83LQ3OO0gIFVCGGmIgv2k+iTEjsa7ul9HYv73Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZqQ2JsitzRTpgyDKkcU3wCB9Q+QDP2GLv31NLcxE0A=;
 b=i92I0oxe0zV/tmrMAw3fd8iPpYFn8pWoNmnnoBjmlhEh60hrqs1FyX4Io4OxjTMqHauvG6eAAZZkn6XeA/sT2tmczpOyfsaXM21/OhV6ewpEZ20ncBnJBIFfaegA/BUQvJdyjhC6QUIsgrcwAkmUXlcWxuMT6IWC20sb3VElGks=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BLAPR10MB5202.namprd10.prod.outlook.com (2603:10b6:208:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 16:53:13 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 16:53:13 +0000
Message-ID: <418c7f6f-0bc3-45bb-2abf-e866df6f4b62@oracle.com>
Date:   Tue, 22 Nov 2022 10:53:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com
References: <20221108014414.3510940-1-haowenchao@huawei.com>
 <ad54a5dc-b18f-e0e6-4391-1214e5729562@oracle.com>
 <89692b2b-90f7-e8e8-fa77-f14dbe996b72@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <89692b2b-90f7-e8e8-fa77-f14dbe996b72@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0010.namprd16.prod.outlook.com
 (2603:10b6:610:50::20) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|BLAPR10MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c96b5e-9b59-42a0-5bcb-08daccaa0b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqYCQOhm9utZ6pI7BDPWWV7Gjtu1hoeBnhpZFq2eQLPuRCAtgZuLU/NcBBQjJ+6CBmpzLJDymHAEcaW++a+GcfndAsxT+r1NHhlHVYJHxhQDzCnZKp1fOxr0W2fhx3pLGEuwaVdirzoya2GCWu2eU/T5s6YUI4lhDqtIWav2luSinT5VA5BScF732xdgDnLpKqRJKm3MWIaqFPefZ6o1uHG+RMSg+BN40twgD2x6K52k8Gbn/MF59o9OrylwI02BIcdB+Qq/DEEGQZj+NhhuAsr5L80phVQnTGQGw6kd/qYp5xH/mgEb1ZSMCDHF3TXlkroMyICwZMDDDQM2pz7+ChqNBPdx54wnhgLkZ27iQS2HEgZAGT8X0GHnsmW8yEPBWalJsiPukDD359SSMf4dWjEsHU0d85RBqNSUbjj+9b/xH8u3XprIBrWISul9TLvq4YlADgD8gUrE70iR/XW/KZlwmJVxVeL9IxM88H32qxD9jwjDrb6ETxveYnS6WM3IAGro1iH08aOrwvrqUarUy/uZVNdOPSx8U7FrnptqQ8oWHri3go7adCSRDvouaEZ3lcXN7tXz7rloOhRc+8uUbJecW+tvq6W1Ulr+NFwm7co4twaDiNgzQgpH2Sy2hNwCE0OQgSvNsrfKkvW0qBR+qB6FlGUUfkgcULqctIdQzi2M/h9SNwWQjCLvPlYMxPREXYPcTo6bjnSc5hPwZxvAC/CFfRUFVhH0MbPrdf8k0ok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(38100700002)(86362001)(6506007)(8676002)(31696002)(53546011)(26005)(186003)(5660300002)(316002)(6512007)(6486002)(66946007)(110136005)(478600001)(66476007)(4326008)(2616005)(83380400001)(8936002)(66556008)(2906002)(41300700001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGN1MHA1NDlnNUo4dFZySG13N0VFd0JNeU1PWFlmRGV5NFl4RDNzWFVSNGsz?=
 =?utf-8?B?V2FvM1NESXV5RGlMcFFGd2FFeTFOdjBQZ09OZ2RaVlVxV0VLdmpIVlBvNVhz?=
 =?utf-8?B?WmJ3VGp5UzVKTWRrM1lObG9YenA3U1hhbUZoR1hmSGlRa0pGbHFoaVQvcVNB?=
 =?utf-8?B?cHNWdDJHSmsySGh6QmJOWlA5WlV4d2VnYlVyVENON2pYcVJOakNpek1FcVg3?=
 =?utf-8?B?bnQ1SUhiS0VvUTczc2JXeDhyK1BNb3ZGZVE3cGZ3RnlseE5aYmtZUnp6bjFJ?=
 =?utf-8?B?Q3dVQmVWY1d1eVd6UVJyMTN2ZTFjOUJ1YjQydXRzKzNha3BwQ0pNVG82MTY0?=
 =?utf-8?B?d2pZZ2Q2T3lTTE1GNURaenI2VEQzZ3cyTERIczlFRUZLSmNrZGJaOEtpaEJ2?=
 =?utf-8?B?VkdpVWR0V3FNNUROOUNFcEZwUDNpWDFNenFNZ0U4SjRNT0ZnL2RlallEMEZ5?=
 =?utf-8?B?Rjl2VCtaZ1YvQWJrZEVxQloreGN5RjlWUE9SQmdQRTBUZWEzcnJ0T2ZQOG5K?=
 =?utf-8?B?QkdPTS9lVTgraWk5TEFBL0I5WWlTTktWV0FjNW50M0hWWWsvT3lGYmV2cWxj?=
 =?utf-8?B?N2ttdTl5WWtZK0FuSHFtMyt5UE1IZU9ZdmhQV1UyQm11TkdkOEFNN0hWYzYz?=
 =?utf-8?B?RW1Sbm42elBYNXkyMWI4MjMrMDRZSDVPWFB2TDl6RzVJQ20rZEw1ZEFyTFFL?=
 =?utf-8?B?VTBNRlBsUHF5TjZ1eTRXM1FkZHNnQXhCVE4yb3RVS1RCdmhCT2Y1ZnVHaGJ1?=
 =?utf-8?B?Z1FkTE15eUl6eEMxOFc2QlFHYWMycmNQSnJaS3g4bU5tczZQeE50aWdoRGF6?=
 =?utf-8?B?NEJMdVZnNTJnem5LZFRuOG9aTFBoK3UzT0l0cmFURlc5VTB6S0RHeTk1QlB6?=
 =?utf-8?B?bXN6NnlwaHlHZFVhQ2oxeFc4ZkF2UEhrcndQSWVXcmFrVmVQVXAwa3dLbHJ5?=
 =?utf-8?B?NHhvU2dab09GR0tVeHFKd0FQTXcwanFQemJZQ2NqQlh4NnFuSUZQSEN5TjNj?=
 =?utf-8?B?OUZ2YzhOVXp1aDdXME95YVk2cWI2eUtzY3o0NC9ueW53UitZcmc2aUNxOTZ3?=
 =?utf-8?B?NGdSR0kwMGNBSTVnNVdFWEhjS2wzb3daU3dvZU5DcVFtejVua2lvcHBkbnh0?=
 =?utf-8?B?b3hTTHBnbGNlY0lLSzRWbjlST2RtTzRCZlk5UEZqTFJ6VldYQk1ieFIrb2Iw?=
 =?utf-8?B?ZGw1K0xkN0FIT2lXZzVwUnR6aEZFck9RVGJyeEs4WW9mQUNlZU5JSktOakJP?=
 =?utf-8?B?VXVtQUxwR3VhUTlhVUFCN211NEdycFp2TFBycDNOSFBpc3lzdUQrTzl4dDFS?=
 =?utf-8?B?VEdnVGVWdVZVL1lPMmg5S0Naa2hQNEZ2ekNldHRZSTVPa201L0ZYVkJPTjhM?=
 =?utf-8?B?RDNSSFVCc3p0aGwzdldLQ2FxOEZVd29oUHNqbmFCeWRsVFdoUG5VSDVGQjgv?=
 =?utf-8?B?Ulc1eHpTUWJGMDM5QTBHOEY5MG1HemltTG96VVlUSi9xVHZqNUwrZitBdzFz?=
 =?utf-8?B?WXJ1RzVsakRCYjJMYjYwTlpYU3FuNE5BQ2EwZldQY3JjVm5sbjJaVmpPcXVx?=
 =?utf-8?B?NTdaejJkT01HWVg5VzZwZ2h2cC80blVqWGtFY3IvZTVMYlNIQVphaHR5bk44?=
 =?utf-8?B?WVFmYnJXZlZEMkk2SkpLWXRlU0FqZjNmQ0N4L1B4ekpCeVRJakZkenRhZjhB?=
 =?utf-8?B?bmpiTTRiakxEQTZkOHk0Ky9NMHVOdE0yY0V4Wk0rRkJ4cE9RQTYyc3k2RDBs?=
 =?utf-8?B?bWlwNG02WWdUTmZza3BkQlpER2dWYm14aHJNeW9KeVZUWUZLMlFyNUZ6eDMr?=
 =?utf-8?B?T3owdTJ3ZzZHSlNTdWt5ZFNsNzNSTVRLYUwvVW43ZEpqd0tTekMzZEF1d2pm?=
 =?utf-8?B?ZXo2SVliaENqVmRWOHNkd2hMZDdraTkrWkc4OFNxSk1wQXpnYnRINlFPUXp0?=
 =?utf-8?B?R09hZjlvTHVyYkFSRDJ2bnFXbUpkK1hhSU1OeXVOazdTbWM0OVE2bXJURzRX?=
 =?utf-8?B?RXU4S3Jnd2ZGc2QreldEYVQ1enlhWE92SWJEZ2FKYjRoWEZXWE10QVpmSTIy?=
 =?utf-8?B?ckpUTVlISjNkcllqdFF1ZCtVMUpySjhFRjFuN3JaWStxYzd2dUl6TU0ySlVu?=
 =?utf-8?B?WmxQWTV5TTlQMlNTbnNNbjZBQ0s4Y1A3TnMwVUhKTU5tdTdjS0VDeWdqaHJR?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bXNiR0RSTjNTazVxMlZtZ1kzWHRrN3JuUnFGR0pESTZpK0Q2OFpZVE9rSkRY?=
 =?utf-8?B?QVROV0hEdFEzUnoxV1JWZVFwT3BoNlRGRVR2ZmRHYU42cnlkeFRiVm1xN2ZL?=
 =?utf-8?B?aHBjZHRIVHB1ODNWMU5NM2MrYldjZUpFWmZxNGFRcDEycjRUMmd5UHdUMGRD?=
 =?utf-8?B?QlhGNXNYV2p3c2xRZ2RrZWVISThSZkxJVHFtc0xIcVRhM28zbUx2ODB4M09T?=
 =?utf-8?B?eGZRYTBzUjRkNDFzVmlXd2doVlJoaUNwelpVR0NMemU1ZzNHY2NyYllvd2lo?=
 =?utf-8?B?elJSKytsUDk5ZjB4RndsNDFnUXV0TjJ6Q09vNEIrQmdCSFpIWlIyMzlDUm50?=
 =?utf-8?B?WTY3OUZRdkRKMzRacGdkcVlweWViTGt0eXBuZXZBQ3QxKytpcXhRVE9iTXNK?=
 =?utf-8?B?bkI1eWxpek1vWVlxOVhKcStPM1UvUisvNm5UOTVBeWVTZmVaWGZZV0w4dzFV?=
 =?utf-8?B?aldPVDRBTkRGdGJQY1YxWU83SXRZM2YrKzBDMGdjYUJPRE9paUE1WE9HWlhn?=
 =?utf-8?B?RVdhVFMzaE9zMXVJUmhsbDlXcTRocnQrQVp5QnN0Rzc0U1dDL0lZV0VId3lq?=
 =?utf-8?B?R1ZMT0p6ZHhHZFV2djlvRkhtYXpyait4eGhobXpnVFdOYTRFWjJFQ1ZpKzRa?=
 =?utf-8?B?REJna3hSN2VjbUlzUEN1TU9rZzVRZ3NacXVuTmJPRGt2UzF3clRPWmIxd0JN?=
 =?utf-8?B?ZWRiNjd6ejJvTmRRTlF3RW41RFh0RGZuZ2EyRlBxTG5MVEpUSWQ3Q0Zhclpk?=
 =?utf-8?B?L0RVWFRCOG5MdDJXOFFmM1FlZG9RMC9XRXNiOEI5a1NjWTIyR25Sd21UMjB4?=
 =?utf-8?B?YlYxWmJyNzhPaklyMzdMa2h1WWgvZGpsWFdTN0dUeWttRHN5Q2NGY0x1dm9u?=
 =?utf-8?B?M1huM3E5K2lzYVBtS25XU0NLak94d0QrM0twekFES25TY0JlNUkyQmZ1c3Q1?=
 =?utf-8?B?OEZpYXdlM0IwUE9CbXMreEgwTUVyTjhQelhoTE1HRURrQ1poYVFMdDNnd1Zx?=
 =?utf-8?B?RDJ6OXp3QURDQXdNdGZyajZHSjdFVnRLOHU3WjlyZ0VGYW9Xam9CQlh4UjUy?=
 =?utf-8?B?aFZuNStxRjVFb3p5WmtCZnpTUG9TRmRKanNWSzVsZ2ZhMC9jQmppcUhic05M?=
 =?utf-8?B?T2hvNUp3VkhEVlhIRFA2UHNTWHZ4bEhTc1F0emdqeU9aUW1Na2JjSXMzR0hy?=
 =?utf-8?B?cDI0U2hpZE5zdjlsOUFteko5Y3JxaGg5Z0w1VFJqdHBVdE91R0RqZDFrSkdy?=
 =?utf-8?B?TjA2K3ZPeE5IUHQ5ZGh6U3FqY3RWVVYycllvMm9CYXpSTlVCekdYYmdwaENB?=
 =?utf-8?Q?rP0M9WkAkz0IemdDiJqYtOJMDx8yFIG5zf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c96b5e-9b59-42a0-5bcb-08daccaa0b39
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 16:53:13.2723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OHI73ZP+yyZa3F99q+6JrdpMqaM8Y5AmEd+yicmkKV4AkJ4lk0GTMwlRNpvTbBW8hbmWtL6AtS6JVcU1tu4vTqFdi8WYXwweNbDRLjMFAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_11,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220129
X-Proofpoint-GUID: 8FeN-jtbYWGmubyyR_It4rJwD3OKttHV
X-Proofpoint-ORIG-GUID: 8FeN-jtbYWGmubyyR_It4rJwD3OKttHV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 8:17 AM, Wenchao Hao wrote:
> And the function looks like following after change:
> 
> static void __iscsi_unbind_session(struct work_struct *work)
> {
> 	struct iscsi_cls_session *session =
> 			container_of(work, struct iscsi_cls_session,
> 				     unbind_work);
> 	struct Scsi_Host *shost = iscsi_session_to_shost(session);
> 	struct iscsi_cls_host *ihost = shost->shost_data;
> 	unsigned long flags;
> 	unsigned int target_id;
> 
> 	ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");
> 
> 	/* Prevent new scans and make sure scanning is not in progress */
> 	mutex_lock(&ihost->mutex);
> 	spin_lock_irqsave(&session->lock, flags);
> 	if (session->target_state != ISCSI_SESSION_TARGET_SCANNED) {

What was the reason for not checking for ALLOCATED and freeing the ida
in that case?

> 		spin_unlock_irqrestore(&session->lock, flags);
> 		mutex_unlock(&ihost->mutex);
> 		ISCSI_DBG_TRANS_SESSION(session, "Skipping target unbinding: Session is %s.\n",
> 					iscsi_session_target_state_name[session->target_state]);
> 		return;
> 	}
> 	target_id = session->target_id;
> 	session->target_id = ISCSI_MAX_TARGET;
> 	session->target_state = ISCSI_SESSION_TARGET_UNBINDING;
> 	spin_unlock_irqrestore(&session->lock, flags);
> 	mutex_unlock(&ihost->mutex);
> 
> 	scsi_remove_target(&session->dev);
> 
> 	spin_lock_irqsave(&session->lock, flags);
> 	session->target_state = ISCSI_SESSION_TARGET_UNBOUND;
> 	spin_unlock_irqrestore(&session->lock, flags);
> 
> 	if (session->ida_used)
> 		ida_free(&iscsi_sess_ida, target_id);
> 
> 	iscsi_session_event(session, ISCSI_KEVENT_UNBIND_SESSION);
> 	ISCSI_DBG_TRANS_SESSION(session, "Completed target removal\n");
> }
> 
> 
> 

