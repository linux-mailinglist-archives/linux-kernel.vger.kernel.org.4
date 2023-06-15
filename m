Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780A07318CA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjFOMSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbjFOMSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:18:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE622962
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:16:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FBETOm028784;
        Thu, 15 Jun 2023 12:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vTrbw4wAVBBn6crFAJhhSuUAd4DLo/sVjr6S9clYs1s=;
 b=OGPlhW+o0Zc44MBzYbVQBLjXFIPCen+ofrvT+K59UXJwQy964HRxjhHKpSxYRGScyPOm
 BTvP7BuKDlyEo37Z96hqd9rJzo0oj+maI4RshwRZ5llSVM9w36HCAfwuKZyYoZBh5f7U
 WtunDT/YnZwSQJOdDKtSJe1LZP3bDxIXg5+Bz/FYEqk1bqsKTl9XjCG0cdSuOqk1rTpe
 gkYG+EwW9v7rjT6LER46Hv0Q2SpO2h3ciD1mH6OAkkHMJ/IUyMZ0z1tHH4MmgPPu7u3i
 QAQQKrKfkQzhN1cRcGzlUBYMDiRPJTNu1PEtlXKMi6c5N2BmXcKndQQt7ZjN9QFthB+w 4w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2asssj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 12:15:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FBXrxE011441;
        Thu, 15 Jun 2023 12:15:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6vfgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 12:15:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiytQVLMPh+kIgCwJnBOG5diMLJQsNZyEg09bAUJQwyhqcBYkHOqfpYI1lKaosKqN6dwerdjncekuctSShTM5kIkkB1WHNUSK+AkNM9+hS/Z0imZKLuX2cdWsSXxmrqe0qkiUQvl2RqXZ6mIa7v1me3pcDBWGCaQu6VUyPvTXE2/yNseZtTSfBG94ukuLN4M7bPCbPtFS329+MTOTLhcGNWkPp1SxwxBjvzPhGI4GJ5YmQLVjIcHjFo1GL3Rs9AaMqMe7LTqcWyhbNy9EMDrSIXJCEyvLtzJygR26u7rWOO3zEVhHg4iskRChj7MFncBxjWfSE7tEQmT8UskhHjAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTrbw4wAVBBn6crFAJhhSuUAd4DLo/sVjr6S9clYs1s=;
 b=hB1KAYjcAoqxQ1u7NrQEqubUrj4uEd0o8pfFM2ZBZpcxGJ2cZHR4Y2tTDEHusexyBfUlOUNw03IKDtNbL0PTvAJxwxLxK16t5xS3wBMYv+788T562arvZl/50N4VTWNw2ByCT3nQKETdbUM3r+LjzJzIyAj/4rokL3o/+YUfUjf7m99mMO8Aja5k61gBh86DJ5df2uxExqjru609MiGeVua7Q/8ISRX0dfTfL+jY3L7DOkiaABuYApS90QgXB1hgfgKV4iJ8Lcz92IwmnTL0+xlakgXOYOSwfmf+iURpvwcRtTXFWuZTppqbxQlmoZ0JDuHuBJrm5OVL0H+Wc5WsbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTrbw4wAVBBn6crFAJhhSuUAd4DLo/sVjr6S9clYs1s=;
 b=TNGAnn4JFNpCeqHVuRc130b7W0CnrUpsfCjtAjAOXR3vjth+v8cz0P7cf9iWm5obnBfqnoF3xWc9VJFUqhbiCizOriqEjd4bLe5+CMmTI6kYxwRrR1SKTYlHds036jK9XI8cGGXg3qojuVbircy+emulIvlAATKQPkaW7jQcGj8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6440.namprd10.prod.outlook.com (2603:10b6:303:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Thu, 15 Jun
 2023 12:15:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6500.026; Thu, 15 Jun 2023
 12:15:12 +0000
Message-ID: <f17ab40c-d5c6-e31b-7877-7452b612505c@oracle.com>
Date:   Thu, 15 Jun 2023 13:15:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
To:     Robin Murphy <robin.murphy@arm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
 <ZDk83vpIarQ9jWa7@8bytes.org> <20230613105850.30172085@kernel.org>
 <4f9184c5-e6a2-08da-f44a-3000b6cdfe35@oracle.com>
 <198a73b0-d7c0-57d6-5ef9-4e9dddb6365b@arm.com>
 <568df53c-41a7-94d7-6662-f8f7c72e5178@oracle.com>
 <99c1e8ab-a064-c770-072f-23ef9e9abb82@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <99c1e8ab-a064-c770-072f-23ef9e9abb82@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0149.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d04ed31-1826-4d4e-dc7b-08db6d9a2b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCkXFpLRUrHJC+t+pOOe88ZB813+mc81Ljw8o8Fm3mxy70nHKxOmcayJliPd90rHE2dGykDemdIVCc36f1HTXQiupzQFdxOHffGjbGNVVv/IcfoYyCZW3Nwu7+BtRUin4S8K+GkKhNlGugitmiGa1/07avTZejqRSeWMyB/nBDxKcoLry8m8gBGBSuK3SbX4RE8A8K/UTDw0A009ePqxgz6tMC6Eai4TrTBYnixkpTecnhUJZ+btAVFIK2Enq4xibG8be1dJ2A8pcd9Ri5SmMA1okTkcXlQYHCOrQhkpjmrJ0FKf5dZW0fsg+M/tkPtwZTbFF4A/w+P0XIUqZHcI/D4Ahx2OfG4wZVAU8BcIXM0Ez0OAyyvHzUg2ciGm/5MpgjRu/relY+t9gTLRA2Ff7PWhOfVWp59KrCYvwwdnqAKV/ta5VdP4MQ/ZSsV2rHm3/YaernPThEv2wJjXy9tx3Qao7juPkX1bRdLAMp5NLk9uxhT1vqnAHTjHY79u0uQ3gi/C3JM2kS/tytkZ3kyj7XIHsxpjlwWwQPrnLiugARs2xln+l+eCYup0Sh8kvc4LbW+7DbFptByaPo1Vg1mZI3iiBmVLN9HbIa/Eb9aqb08dy3GNr8AFr8GAgRevSGKBlAeXZAz5Po6PF/eTXdb6Zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(6486002)(86362001)(31696002)(38100700002)(36756003)(478600001)(6666004)(110136005)(8936002)(966005)(36916002)(8676002)(5660300002)(66556008)(4326008)(66946007)(66476007)(41300700001)(316002)(2906002)(31686004)(2616005)(6512007)(6506007)(26005)(53546011)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlZzZVlYdnlVUTZBNVZDcmYxUTk2cjFMUEViZlNHMEJoNVdzTHZ3SW0xQXZC?=
 =?utf-8?B?TXdlcjNZamVCQTJmYURwdjFZZzlJWjlEa1RPV25PZ1NpbXl1ZzJnZkoySGRl?=
 =?utf-8?B?OHpjVzVDdk5wYkpLV3hUejN0V1d6alpPNFJ0UEpjK0VqeFFoRTBBM2l5Qmhr?=
 =?utf-8?B?N2k2VHIvV1QyZ3hKOVlWalVMS2szaVRFRFhYRWRMc1ZqVDM3Z0MrYWRCb0xZ?=
 =?utf-8?B?T0ZacFVrT1Eva3oycUxlRVBFTnpBdXlWeHdCeHVSd2NOeHh0bTRveEc5NVZ6?=
 =?utf-8?B?ME0yd0w3dTVlMlh3N0QweFVmUVVDejY3M2JGd3Z6c1FaeXFFTEJQbFVtQ0lu?=
 =?utf-8?B?M0hUSHpRUWIveFNhSGxlTTdCdlA5L1ErSE55TVB3MHpqZGNoL2plbjkyTFdM?=
 =?utf-8?B?U0JIVFRKY0JkdVh6NVRXT2FVaE9xRDFybUM5VGkxcGRzQSsxZVAzL2V6Mm5I?=
 =?utf-8?B?cVA3UTlpMnM4d1NhaDFZZkxtdm5RZ3RYNVRGbWwwdXZyTXJpZjB1MEZteisv?=
 =?utf-8?B?R1JaMWk3aEc4bWtudVNpRWM0cllkS3htLzZmUzNCRGdyQXBRNGNsL3c3MVdm?=
 =?utf-8?B?RG5ONlpLcUdwanlBeU5TQ1lZUlNTL2F5THpHWVQvM1krYnFyK2NUSjgvSERH?=
 =?utf-8?B?U3ZObDRjeXBGMk83bG41cy9PSTJiYUljVHR1UGtUVTBvbHdqRjlDdmNvbXZJ?=
 =?utf-8?B?cDJNWDMzSkpJd3pQNC9tbmVkM2UwTHNtanZnR2E4VWpYT3FacDhhSTRlNU53?=
 =?utf-8?B?Z1JEZU9JSXFnYkFvWFgrYnA3SzJYWlIzdFhrWXQxa0h1U003eW9IM1ZDMFpF?=
 =?utf-8?B?amhkUVdFUjFOaU1ZWGgyTFVGYjh0bldHRUMrdkdzNVpaYVQrRlc5cEtGQjVR?=
 =?utf-8?B?Y3J5blhVby9abmN6THhsZUNVNjNUdWRXRE1IOWNLdjlubmhiMytMeG0ybG9r?=
 =?utf-8?B?dDRzV0ExZEpwa0JnYUFCQjdUUjVacGdSc01jVWlSVVNqNmUvaWs3NCtHbkVO?=
 =?utf-8?B?d3QwWG1US1l2WFMvaURWVDY5Z1FuTFFnNWdDL1ZyQmNnelFSNWU1R2VKdmV0?=
 =?utf-8?B?ajV3UVA0V3NCd0RCWERGMnJkSVhBcnh5UkRoaGU2WEhqayt6RUo2OW1TQlhN?=
 =?utf-8?B?RlRIY21WdmZTR1crR0p0aDhjd3RjZ1hMb3IyTUNKQlh6K3FBdzN3RlkxeGUy?=
 =?utf-8?B?VURKMVJUeWVRNUR0S1A5Zi9BcFpJNFNsL1pTYlVDdi9DaTB4WTZDUG1OYVFj?=
 =?utf-8?B?SFNYOTdNblo0NnNFZEJTNHhsbkhUSm9mMTcxY1E5UkU3NXgybEVLOTNVTDlV?=
 =?utf-8?B?V1laRHlCRm80d3k5NHQwSGpnNDhnSUdJdzI2Ulhabm51czQrN0hXei80YlFN?=
 =?utf-8?B?VEhpRXgvRUg0d3pTQnFsb2ZmNGZaN2NqUUdtREMydmZoK1piOWZkSWoyY3No?=
 =?utf-8?B?d3krdTV0cGpEWVB5UlJ1TWtkZWF3M1VsbldabkFnY0xUOXg4enJsWGVuM3Z5?=
 =?utf-8?B?QWZTRU0vSHRzZ3p4NXZZaVdsOXB1Y3lLbVEwQTQ2bTN0bElqaEZQNFNrQWJ0?=
 =?utf-8?B?bDZqM0ZKSlpYRWdXWmx5ZVVkWlloZmlXOHZKWnV4TUxQM3FpQkJmRlFHQzRk?=
 =?utf-8?B?eWg4NXE0MThrZDlsdW16elNLUEMrK3lxQU9nRThQRjlUc0dDYUFKNGh5WFpn?=
 =?utf-8?B?cGpQczRPSHBzajRteHp6eWtsZDNwRWp6eGFLc2FybUtMb3J5eVhuUTNoSXhJ?=
 =?utf-8?B?OEYwOGN1K3lueWVPRGxHb3FGZjExbUZIUk4xb3ZMVE02U2xjOHN0c3dpQnBk?=
 =?utf-8?B?UnFDT0xOc3JNL2orTDdlYVo1ZTlPNWRuVmJMSTBQVWc1Qk9Bd1gwTm9VN2JS?=
 =?utf-8?B?TG5RZG9SVkFYT2tXdVlPbWJ4ZWg2Y2xZUWtMRWEvQUxLb3BDMmFUT0hOTlh1?=
 =?utf-8?B?N3FQYzVPMlZaaktHYnY1ckxua1p1cWZyelYweC9tK3grNVkzaWJSRitsbkJS?=
 =?utf-8?B?djhLT0V5cDFQdDY1VXRJb21kcXdBWGdNdG01ZlU2VkdmekNWNEExbVNFODkv?=
 =?utf-8?B?RThWMVJvK0NpQWJXS2YwZGRtL0c3MGFYSGRLdVlZZTVZUHdGMzgrcGpEZjRS?=
 =?utf-8?B?N3dOM3l3MFhQU0xEUmhmNGtlRjJDbVFONWZwZlQ1SDVudURxZWlUTlYvMWF5?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YTlWSFpMeWZQN1NZckk3aUtiY3czKzdWSkxoZVpMZTN1c29BL3p6Mk5oN1Av?=
 =?utf-8?B?MDJud2dBbEc1aFZXWXdyOUtTa1k5TU1zUjZsQ21MTFIzTTNiZTNTSkNTKzFu?=
 =?utf-8?B?aU1FQllwTmZDOHdxa3dhcDNoYzdheW8rbnh4NC9XamtObEJZRk9PT0RoMmZB?=
 =?utf-8?B?ZG1KUlZIRDE4a1RCMVI2c0hDK0RvTlNZaThUUmM5NWdPeHN5UU9YdWNPcGxD?=
 =?utf-8?B?S3FwNXEvK0VzWFpMMTRVaEc3VEhRRzlzcmxpaGVoWU1XNmJNeUl3c0VMVmdx?=
 =?utf-8?B?Q01lK0RqV0ZVaEVJMURqWk5qWElmOCs1dW45WjZ3WDRLOE5Eb0w0NGc4aGlD?=
 =?utf-8?B?dGY4VGR6eitaaVFqSlBnWFFlU3dDcVRYRnpFVjEzaU1ya0c4dGZBN3kvUEVi?=
 =?utf-8?B?WFdyUFlTZVJPTXBUZ2Q4cVh0cm1pbkdBV3RFbWdEY2I3SXhtai9kc3NDaDVx?=
 =?utf-8?B?cVZUQzdZQUNQY3FMeDNlUm9QUVRaTG56SStwY2ZxcjducHVWaTFHeTl3ckxS?=
 =?utf-8?B?TS9HRjViQW1JTmRFaVordUdRdTFZU3M1ZzFtOFJjTjZyaVBSNURyV0plL2Ur?=
 =?utf-8?B?cVNaZnJXdmJQeGhoYVRLeXN3OVI4MmtQNTVlRzFMUHR1cWNreitPZDJEK0NB?=
 =?utf-8?B?VXhTTFZHVyt0bFpNV3A3V0dXOHFFclNUc2RScElUVGtzR3VvZTZuaFB5VzIv?=
 =?utf-8?B?ZVB1STJHb2o4QmkyOUJPRzY2dlR3S1kzWC90Z3I2NWRjTXBHeFJTWFBCa2ww?=
 =?utf-8?B?MDgwUDdHQkgydlBwWUQ2ZHZud05heEcyQ3JCVGptUkNKbmp4bkU4OEw3dCty?=
 =?utf-8?B?YXZDakVGNXBlL1VxSUk2QS9WNWsrS1doN3FVaGxQT3l1dVNQcWJHdDF0WG5q?=
 =?utf-8?B?UDhSeHVSUTluZ240TjVyWTFNZklVQThTUmM1VG1aTGhlVmc5WUVuQkVucTJM?=
 =?utf-8?B?QjFXVytzU0t4N2I2L0J5Yk5vSUlvYjdSYnFlR1pyZ0dNT3ZEYzJHYWxub1Zm?=
 =?utf-8?B?UHFJcmQwQlk1V0krWVBzRE1sYjZUQmpkd1RhTndJcnlsa3NxblVJM2MzNnFU?=
 =?utf-8?B?YlhRaGZtR3FWTG9ReGVjWDF2bmZIc2xXS3dsT3VvUzducldyYzF2SVR0YzRQ?=
 =?utf-8?B?NEZwUUlUbUJ5cTNIZksxQ29BMHlkVCs2bDNwVHJpSnJ1ZVZGQldXbG93RkJ6?=
 =?utf-8?B?c0c1aEFGVEV0L2tnNFYxVklKQ0ZaOXVrWmttZ1J2YmlRbkx2UUJXdUFlQVEv?=
 =?utf-8?Q?LFwSNMoajid1Bfi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d04ed31-1826-4d4e-dc7b-08db6d9a2b07
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 12:15:11.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoI6/9ySs6ctd+WaJFE+IINZpGCoihaveoHODnWADVZhsKJwyGBfU0EMEAyjDXwaJPPdZAC1Q3UTHx4WH28l/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_08,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=892 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150107
X-Proofpoint-ORIG-GUID: rRAJWizuLCXN_dar15hdKKP0QsXPx103
X-Proofpoint-GUID: rRAJWizuLCXN_dar15hdKKP0QsXPx103
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 12:41, Robin Murphy wrote:
>>
>> Sure, not the same problem.
>>
>> However when we switched storage drivers to use dma_opt_mapping_size() 
>> then performance is similar to iommu.forcedac=1 - that's what I found, 
>> anyway.
>>
>> This tells me that that even though IOVA allocator performance is poor 
>> when the 32b space fills, it was those large IOVAs which don't fit in 
>> the rcache which were the major contributor to hogging the CPU in the 
>> allocator.
> 
> The root cause is that every time the last usable 32-bit IOVA is 
> allocated, the *next* PCI caller to hit the rbtree for a SAC allocation 
> is burdened with walking the whole 32-bit subtree to determine that it's 
> full again and re-set max32_alloc_size. That's the overhead that 
> forcedac avoids.
> 

Sure

> In the storage case with larger buffers, dma_opt_mapping_size() also 
> means you spend less time in the rbtree, but because you're inherently 
> hitting it less often at all, since most allocations can now hopefully 
> be fulfilled by the caches.

Sure

> That's obviously moot when the mappings are 
> already small enough to be cached and the only reason for hitting the 
> rbtree is overflow/underflow in the depot because the working set is 
> sufficiently large and the allocation pattern sufficiently "bursty".

After a bit of checking, this is same issue 
https://lore.kernel.org/linux-iommu/20230329181407.3eed7378@kernel.org/, 
and indeed we would always be using rcache'able-sized mappings.

So you think that we are reaching the depot full issue when we start to 
free depot magazines in __iova_rcache_insert(), right? From my 
experience in storage testing, it takes a long time to get to this state.

Thanks,
John
