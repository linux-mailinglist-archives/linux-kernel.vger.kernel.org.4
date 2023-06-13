Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EED72E2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242389AbjFMMTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242379AbjFMMSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:18:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1255F10C6;
        Tue, 13 Jun 2023 05:18:20 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65S7H004041;
        Tue, 13 Jun 2023 12:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QW4A5LZRx9JubaXptDvWNSERfJDMZNk8F8nvd1scE6o=;
 b=xlozbFL43dphGWqXgZb763rCqcDcDscutG0GZu1uEbK6iwb+5ONJjI+Ltb0qhm65F5sR
 /arOwWzqEoTTxF8ppIfcwf+gnQjoB3L6VmHxMWxWVRT4Cn2PFgq/n9Qrvu9jH2G89Pjc
 vlH7HGfq0xRFgE9z/uDdEtaMM+b/yI3GcqHhZJVSxhLQOu6HMGTxMNCBc98MzdHKEAAD
 VEFas3/PRvDOa4wq48AOphBvi+s+JKg0zlrKZj4swHJOzxzFKT0qUko7Towde2GyDwnr
 ym5nHSLj4zzVS1l/crbGrDha8xD577tbFeu0/cqbz+6E2YGbtMO6aXjhAR13wyMDCeMz 7A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d51yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 12:16:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35DBMtgr017794;
        Tue, 13 Jun 2023 12:16:55 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3tk3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 12:16:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPT5/aXiNnzqal4KBr1QwSoyzz7OX+YDAGGG260LQrL8geWcF0cLosATAHjpwmzS55PU4ImhMCtOsNe5eVYjF0UzkJhfpA0QR2QIlWfdLBMyvKeuRLETgGOwPO06K+L2y5gCtprEgNAqrWnB9AU8iXZhUr4k16eB/6XWufNaIIDN10CSNl6YuAG0VLPNfgTjzITehAXHAEfqZcfvLva0MVPmjRqJydNy8+sZP4NR0+VBVC9EJBdamguHRVKI4fVIaRzD0wVH8EXGP/hs+PgM+OsrPF3oH87TC/nfHZt039xy9WnzS2thoNNQgjeDL5O8RpdcayTHgYReqqyOdFDUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QW4A5LZRx9JubaXptDvWNSERfJDMZNk8F8nvd1scE6o=;
 b=RcaALPgLYzZOpTLTMA+DiV57YGBIhWJTLc8rwwvG7SAIzgdlA0SA7cOOprEPnYOwsgKBRwVFZicIWBegUbXZMrY4rLXVgND1x9RYgyeHxBtEWzWVhALGRooTy/8I6U1hxRnd+agjzOTXQUV4WAy7sE0lDpsR5fqjVLKWzbSnC75GHotZ5KH8ZKx+tk4KBxSHQDNJAy0eksZC1OIr/CIjCiMyopyOu1lvwOZoWm0sK5jw8UvPmgZiolgskMvH6w2USX58J+CsF71SU+rNWRkwmh9RNn3PzQ9XABXdENQXiy9RpOcQeYSUVO0FPcCREOMxQV6QcMxrGOupAgkFW+g6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QW4A5LZRx9JubaXptDvWNSERfJDMZNk8F8nvd1scE6o=;
 b=MP/cIkyH2/12hWiHWgsMETecxf1XeKLcWz2tp5UCq0496kmIA5+6WdyhJfE9xApsHzj0VMXTE9kcJNShQD6Lib+t1ja7Ha9eOcxDqOMBf4GueXl1Viq66av1DpUhqxIW/eAPoeTewP8RNTl5TQUsoVAOBOwmyNvF+kMrnyIPS8M=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CH3PR10MB7434.namprd10.prod.outlook.com (2603:10b6:610:15b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 12:16:53 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 12:16:52 +0000
Message-ID: <5dfd31e0-df08-780d-45db-8dacf224528a@oracle.com>
Date:   Tue, 13 Jun 2023 17:46:39 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 5.4 00/45] 5.4.247-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230612101654.644983109@linuxfoundation.org>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230612101654.644983109@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CH3PR10MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1ce9d9-e7d6-43b1-e0d8-08db6c081236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpPLFpolYdqb/AF30NCGRe0h4a94RwQGyMmUVDOWKqoeIHb5Pr1ZcV1iLbZ4s/e8BD9D1lhA0dgTXu+YpBwXxD4GBLBsgguuW9TZ+tfSLc5md+vJNijCuqDdFS596IgoGY4w/EQSD5gkaQjcYZa80TITfetkNXxgueuYyNPecdlHkxLwd7OgVYpHg/5av5gv4ifd5QED1e1+oQG1KeeS2wRGYWSy0iADlWzetgA3TbwmktYztjnFhnNxMbKCRMo+OyxL42n6CIr/75ASgfn7QcDLoNcFtzvdbCXSlmk5vf9pk1Z6SeMYOz9dpYkF9WtOm0HyRJorvlT79uBzSVHu11DBwJYt4ZVHED6VvxUSp4l15K53KCLRimaEgl+mNfIOOkmoWo1ZioLE/bo9TZSprSlRbgFMWeYqEWVZdoLtiPN4XbXEvvGjULiKihtlHGscmSTH55uOSJ1BCgYTSEInJCEnQyEU523ElUQbkdMPaPbd6yzFKoomunvefFcIis8bhn5LYFjPzZb6FtsmdQGdQuqSrKxHJsUjslvm7iwlSKaSJl08EquN82PgbBhpR5D0LbI0Rz8DkIHBNlpK4WLwqvAdSzjMLgkY+20AsCnnXb5JehApnMovGEw5lbQ2bKPU+Pbj0135My8CwopcQx9vgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(5660300002)(7416002)(8676002)(8936002)(4744005)(2906002)(31686004)(66946007)(66556008)(66476007)(6486002)(6666004)(966005)(4326008)(107886003)(26005)(6506007)(6512007)(41300700001)(53546011)(316002)(186003)(2616005)(478600001)(86362001)(38100700002)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE8rMnFEOUtPQkNWTmIyYm1hdlQrSWRab2ZzUUdicTAxck4wRk5oS0RJUzZ1?=
 =?utf-8?B?NmtJaG1uelkxV1NtK3VaMDJtb251Y2t4OTFnNHNrd3VuaDZUa0VCS2xsek1z?=
 =?utf-8?B?Y0tiWjVScWozeGlOejdKall6aGhtUFowaU5ER2pQNDJYZlU3eUh3MU80UHhj?=
 =?utf-8?B?VlpFeko4YWRjRnpSMmovakxyNkdpOFVBTlM0TFExWWVQb1RZUld5TXYwZ28y?=
 =?utf-8?B?QW5BOTFXRkdTZEMzOTE1NVZuY0J3OE1LRVNGUzcwRXhaTThhcFJ3bCtGRnBi?=
 =?utf-8?B?eEZUV3YyVGdyMEQ5aCszVU5nMDNGUVVHYzdkemxuR1BYME1LVjdqYWI1SkEx?=
 =?utf-8?B?UTl6K0VzNGZjQ0lXM2F1bDJHZ1FkSjJ1WDBYT3JCZ3pBVlhkY1VIUVV1NnJi?=
 =?utf-8?B?cFcrUkd4WkpIMTlJelkwRTJMZEV5SWJ2R21ZVFpVbkM1RldqTDFpSG4zWTJI?=
 =?utf-8?B?bVZtWkdONVhmOEVrdmJ6djVWVDgvVjZLelNEbVYwTkk3eGQ2NTdWV3lPLzU5?=
 =?utf-8?B?aGo5blFsOU41cEcvT0ZGVVdsRTdFNnJacjNGbmtNYk4zRml2S3c2QlNMWFVz?=
 =?utf-8?B?N3dZbnE3VHk5dWZFc1plNmhKRklrakVheWc2d054QXdlU0xYYWlMZlA4RDEx?=
 =?utf-8?B?SUJZOWZieEdVcElPNlB0VHZHRUd2ZDRqd0RVc1M1ekJxWFNFVEhtTTR5Z0Fo?=
 =?utf-8?B?STJvV0xUSHFXdGd1WmxVb2Y4OTlRYXVNd3dTRVV3MW9rTDNLeTBRblhJN2lx?=
 =?utf-8?B?Ky9wNVpzMWlmOXJ2UC9NWTROS2l4RWljS3ZPSGVTdWdORHZneHRBQy9DZ25V?=
 =?utf-8?B?bUFjNUJpMVZlVzFQQldGNFlrcGR0THUvZ3g1U0tsREJ6MkpDY213dXd2ejNG?=
 =?utf-8?B?cHpZWjhlTGdLTlpwblgybzlJem44NllSOHk0SVVhNlYySjFLT3VQVnV4a3ln?=
 =?utf-8?B?SW9OZmkvWFd1ek5sMHpoY3kwWTFtbmlDYnFPSUhyQ1J0U2RjT2tjaUR2UEsr?=
 =?utf-8?B?UUd0bHhWMXBMRjRPWGxEdXh5cDZvS1lWT0FlYURDRDhlR29EV1pDYUhVQmlQ?=
 =?utf-8?B?bWVlSzc1TlVsenMxQVdob0xNQjZ3eEdHc0pJeFJWdjBQTzJpVlplanNBd1RF?=
 =?utf-8?B?MHB5MjVYRHFKL2xoVUxlekZUaGxZRzlMeXovUnFFUG52cjZWL1p0ODA2MjYx?=
 =?utf-8?B?NkJuTU1pbWhRb1JHSGxnWGFyY2VCdlJFemZwYnlvYjY0TUdEdFdpNHgrakJo?=
 =?utf-8?B?alBvUDMxeVZ5Qm5BdzFSK2p3VTZkVXRQQk13VGZWcUZ5aWk3TiswejBwakZ0?=
 =?utf-8?B?Qkc0d1lvKy8rblp5RTdVSlFWZUZJektVbStOdlRFbnByVW1xazRIUlpodjhL?=
 =?utf-8?B?Z3RrdVVmQU4rUGNYMmxvc0dPSFR1NGk1clh5NXVJdzA3VHR6M1gyR3p6NSs4?=
 =?utf-8?B?eFp0QWRhTU90eXh5Y1EwK3BlMjVLZTdHejFoNEZic05NaGs2RjlTR2syK0VH?=
 =?utf-8?B?eWRLRzB4eWJVN1ZjZXRFNzNWc2FicVRpQlg1VEY3N0p0Ylg3SVBkdHJkRnVS?=
 =?utf-8?B?NGx6QldJNnlwenRRU1FoL1BZYm1WV3YzZXBxWW1PSlVGclZiVksyNzJCdTFZ?=
 =?utf-8?B?bWVJczZycklQeXFHWnd0ZzNaZVgvL1MwbEljUWM3T3g0eFE3NFMwZTUrNmp2?=
 =?utf-8?B?YUdaV3JqK2FuRHg3Y1hVOEFzUlVFck1LMjdxeEJjZTJPQ2xPVlJ4YnR5T3or?=
 =?utf-8?B?bDl5OE45a2g0MFBRak5pOEkyY0tLaEtaaWhHZGgyN1YyTEZWQ1d3V1kvcnhw?=
 =?utf-8?B?ZHVzM1NpMjZmUldkY2VEMTRIN1p5R3dJbSswUkZJeWFtRTk5VHdpd0FPeCtC?=
 =?utf-8?B?RU9BdllnTWIzMDJuUzhTQzdabUhLcW9Cd1YxSk9lSTNMb1BLNlEyZjRNR3pF?=
 =?utf-8?B?THV5V2FUcGhNd1JXVWMzM0lqcEphT1B6dXM0ZnhhQ1R3TFF0VTlCOS9hL3dW?=
 =?utf-8?B?VW4zNmxUelBkSkNFVkk5MEgyeUhhT3R4VnFVWEgvVC9Lb25aWmk3U29NMTBG?=
 =?utf-8?B?UEMyY1dJVHVLbWZxOG5RZXBkbHk5dHVHOGFJelVoOGxodHg2TUR5SlhCZ1h1?=
 =?utf-8?B?eGxrWUUzNVQva1BNam04VkxQT3grU2ZWNnZkc3pKcndpbm10TTllRzVhSGd5?=
 =?utf-8?Q?dqaG1NaCWY3m7fW2rpl8PFc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QzZYY1dQenVFVnNNZUlyMFV1YkptZ1pRSUZxc3pZek42NXpJZE9FL2txdkda?=
 =?utf-8?B?RzJHcHFGd1B5cGdyc1Nydk9Sek8yanNtdmt5OUNVS01UYWFmQ3hFcjdNUXRT?=
 =?utf-8?B?WEdnalFocjNHSUx2K2cvWVhtTXYyYkFvS0w2R3ordWxOOWJQalBEejVNM3oz?=
 =?utf-8?B?VnRUNm1xRnl2cHdVcUZzeXpQWWNkM0V3YlR4bUNKTWZSVDlZTEVSMWtZMmNI?=
 =?utf-8?B?eUJNNDVpTHdqMENDUjFWS2NGRzlNQk0xWnpyUjJRSnlNenFqc2p3a0hzbTlx?=
 =?utf-8?B?VThHVmFvL09zenZKNlYyay8ybTdBUTFKdnkvcVF5cUhIeHBYd00zS0ZKZ0kv?=
 =?utf-8?B?TkpQNUZFbW00NDRyUFkwOUhJZndmclc4UEdJRk13M2R4VGRKZGR3ZUF4eC9L?=
 =?utf-8?B?VUVsNXc1VHNmRk1xZUN3aldjdWkveWNrNVQrenZHQ2hwSHNqOXBqdTdtd1dV?=
 =?utf-8?B?ZTVlcHgrbkgzY1FOcjI5MUI0aWFQOFlpQ285Wk1KOEUzQm1obmwyM1BocUtH?=
 =?utf-8?B?YzY0WG11NmZ0YWRDOE5adFo1ZHlhSFVndVkzVVB1M2NMK1NJSjh5Y3hVOGo5?=
 =?utf-8?B?bGVydDViYVdPTHF0OVNnTnVMUlcvRjNlTksvMGV1VCtycEF5Q3hJOGdmaC84?=
 =?utf-8?B?bS9tV25ZV0dmMXkzQkk1ZGZCQnVTMjQwaXhnNlhCVDVxZW1ZVlhiK2xUcGxh?=
 =?utf-8?B?TFFiOXRhcTFZK003ZnlhNllNSndtaFM0Ym9pOEczVDdvOUVodlRRQVNIN3Jt?=
 =?utf-8?B?VnBPRTYrc3cvRTZQdGZneVQ0Z2JGWS9nRVpKQ3QvZjFtdDdpNmVKbHdtdndY?=
 =?utf-8?B?bUpSTE82QS80WWFOK3pEU2QrWnM4eTh1WkNITVpFcU1mWWQ3R0pzam94T1Yx?=
 =?utf-8?B?bUNtZW1xRmR2ampxWVlOZDVSaW1ZdmNULzluYVZkeFhQaFZ3UURxYTdtRGkz?=
 =?utf-8?B?NWtPSlJqQzZ6SUtnQXl3bEg5Uy9yS0o2eGhXV1pKT2ZQOVhBYTRGQVlCWjV1?=
 =?utf-8?B?NEdVL28xTktsRU1WY1luYTVNQ1RCbnUvU3Z0Zyt6R1pzSnZOV09VQ0swWkx5?=
 =?utf-8?B?dVZ2ZXEzcFU2VitlWXVRT3RuS0VEL0h3c1NMSHVLaFd5cGpCRGRoRjhvWTVh?=
 =?utf-8?B?M2hoK1h2SmpzdGs3RHpKMkxNR1VwWDVwa2htdCtWaGR1Mm5kMmY1NTFxTXhH?=
 =?utf-8?B?eTlmSHB3Und6Qmhya3h2cy9UOUZHbWJ5bWJUQ2g4bEJGVFVxbjlDeWZxM210?=
 =?utf-8?B?V3JqREVPRFdRYW9PMy9tRjdBZDVrdWRRWUJmYmJHM2lIRnEwdFdUSFE2QTBC?=
 =?utf-8?B?ZzZ1Q0xhRnl3djh4bTFtZ0xoRE1CNDNIM3BMM3BRZFFEZHROMkFPd0RhdUdE?=
 =?utf-8?B?ZU80S0RwcU4yQmVSR3U5ditpb2x6L0NmSzA3cXhMRG1xR3VaZ0NjYmp4Qitv?=
 =?utf-8?B?NGY5VXYyb3VXMVFPWHFjSU8xTE85QnNNbXZUandZWXpyUzlaM3Y5RnhneWto?=
 =?utf-8?B?Nkk0Zjc0UnBSNHovQm1jam1UQWhBeThSTGVlck1mby82d2JuaGc4ZUFGTEZs?=
 =?utf-8?Q?8I6DcMYQZ4kmI75Vqd1m+mlUenAmFrzIGQGyUWbmaGCGuI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1ce9d9-e7d6-43b1-e0d8-08db6c081236
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 12:16:52.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4txKL3587p6qiIZRWxBe4JOwjGh8Yxy7Gbc3BEybK231YlCVAQR5xumBswQOgDgMP/5gGpJYZcUgdW0ghuXTActfS9dqZ8vNoTWbswp56MxK4DnfZ8ZQHcw9jZAXna4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130108
X-Proofpoint-ORIG-GUID: 4aY_LzhJzM1GltyafG4oh65Xd3UdpYP5
X-Proofpoint-GUID: 4aY_LzhJzM1GltyafG4oh65Xd3UdpYP5
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 12/06/23 3:55 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.247 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.247-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> 
