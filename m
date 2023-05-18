Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163727084CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjERPWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjERPWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:22:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3C6101
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:21:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IF9Vcp003895;
        Thu, 18 May 2023 15:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QWhdU8TfH2e5tIr0m0Ntm5+3uHaBn0uEojyr6L0WeDk=;
 b=MAfvyJgB+t9sRGEJ2K9V2WsSXH6ZEjTrir1Ub3gqiCqHuDvEtlMKbYqReWAgmOCW63uU
 Zj+Gm//Rxo5v9R4MlwZjTomjyI4CyqLbjFCk6/U/452cXqHUSflIXjD4tFATMX1l7SU3
 xjzb3fPmc6tZg1rX4y46JXVAdS6p9MaWifT5f+fOL5V85+2f+mnDq9jHibEy3OI1UBGZ
 Ry8KCKAqL8UM/B5//7wJnSloz+1bvIsgURm0qC7atShhwgAHz5uQkL11SOqGNKauqFJm
 K1O67hN9bwvNka+T9AhX5J4xEtRdUCt2JU//hI3/vYpfdP6I/VAqXEMXKMBmhsP8PfKD NA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33v06c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 15:21:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IEsAQv025051;
        Thu, 18 May 2023 15:21:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106wr8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 15:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZllnN3ncqLZGU7rnLJb0O+BnzMNt+FF93IuZQmqec/0oY1o93zBA6M450Kjr1wgp7+Vitbv35CIS/sGu3CGFEh1Ry/sW50NKx27TWfznUbTFy6MisEXMCz3Gq1STRkzNA572ekQz2mQ2miLQQ0nWaTvUM0gC93SlNgB/FizkpWk4LTihkVuY/Lip4P/BP6MZUmYc4nlghAE+u2K+BCQIvhoSJKouXoP31H4WRR49/eMmhPBZ5m9F78JtfoAXk4W0CcJdoRjezOK6hkH+c5pSIrul7upbH/goj7XGlD/5ArliFxjI1ORk4xJ3qhr4yJplQ7JuepETBWkmI5OjXKyoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWhdU8TfH2e5tIr0m0Ntm5+3uHaBn0uEojyr6L0WeDk=;
 b=HJbwiEJAy/D5rzUTihh/F+743HotiTCO10LTglqzJsAKs7i39jaxAz57X3Uh10KVsQXPbU5joBGmEmGouzbI9HdrFfRZ3sk3YlrSJYvZds/PKND9DPZf18qA3HuPr+f30geva2rS0VlgKLqFMWs2k+tamFiP1EVbVx4+MeaVYFwKuQZXM1fsejD40cOUzeVjRK9prHVBf2NF9L3bUfpB/JAr/elOd5acdeubzt120M0saS9lJJdDLSaXin2+JQPT0NPp7A88bEWO7HxdN2RetWzXZtPzya/Ee8t5mFHfNaYAuxNTxiBgdRAzrwF3pHGTgybW1bQVxhapAT4gonzvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWhdU8TfH2e5tIr0m0Ntm5+3uHaBn0uEojyr6L0WeDk=;
 b=trpT1VycUrtnb1y5rzNn/F1YquM7aC53KbFLm25gcJpRhCCOsXcllSjvpp4+JUQMVTy8h1opsAmTlfBaTtZK0/1BFln4hxZxtt3JYSh8GIJE1aHFrHctqgHSIRLTjpVGRdV7hG4k+AcZLGsel9vogGBNiJx4+Mu8qkEqL9uEaRA=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB5894.namprd10.prod.outlook.com (2603:10b6:510:14b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 15:21:41 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 15:21:41 +0000
Message-ID: <ab7d07ba-5dc3-95c0-aa7c-c2575d03f429@oracle.com>
Date:   Thu, 18 May 2023 10:21:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if
 SIGNAL_GROUP_EXIT/group_exec_task is set
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-2-michael.christie@oracle.com>
 <87ednei9is.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <87ednei9is.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::29) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 05827fcd-9c8a-4f22-9af9-08db57b394dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+1jPJs2WQFiGJuEcihluRY9Cds3/CcWp3v/GdnOI5pUwSI15CDQKTgBPFhywbslg1L7g74qdUB0KKYPaZBZMrYXgvUbSx8izUefRlWU+bXua5p3epDx3mEk/2wyr5NEEPNlpntyzUWAwd2cl87FxyVCTlHDcFUMp1TAon+T25Jn7sJjILQvVvRK70x96axxWSt5BIhK9RYlNCzZYAFIb2T+tiNJU32rGKnvhNHniruaRck/36N4WMVKE6kWDzMZqVkDAnfwGjnWBIkSRE9OetXlOARfmtCft2llx9yVX+qVQOXl5xmaZ39J5zqMUeovlrDs++MNJ76OHMljmExWi8DD/JZHzT1ooplpp66AYP3EMnFYQtdMb5wVpMbHACadbT4SiimGKIt8Vd2HNHdfdY88+6SAxoPQgQgLS7+iA9k0wt+PrVaLsPv73a9jPzviwIlbANSbia9sb7w4oHLwgbandtYrQo81dJnoDLZLoa0EqTnmNk9fmP8wZVp8qoqWHRcu13gn+zVVxNpxYdRB+1DsZ1UJbpX/BlmRe/oxmDAA+tfiDtOU9EFtTwp0IVszy4ATp4+OGB48mZ6ytX0IC/a/dgdoqFjI1rPxEqiomAcr7Lh6kWUCTu+ZOZafspjGqveOhYclqJGW7Pn++qJ9lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(186003)(83380400001)(6486002)(478600001)(2616005)(26005)(6512007)(53546011)(6506007)(2906002)(5660300002)(8936002)(8676002)(4326008)(7416002)(31696002)(36756003)(38100700002)(6916009)(41300700001)(66556008)(66946007)(66476007)(316002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3JTQ2QwNzNmeURzNHBGRFZySW9YOWU3cjBkTW9ISC82NytkNmdweDRJNTZh?=
 =?utf-8?B?ZFd4c0Q4SjY1UEE5ZnZtZnh5a0l1bm0xYWRsUUdVVzEza2s2MFRFYnpRcXBL?=
 =?utf-8?B?a0dFZi9OMFlvWklwYnBJZVM4VHBiQVZ5UThkanhrdFVQYVRISm1NR1h6NTVi?=
 =?utf-8?B?SFBraG9yM0pQT1htMkZ4em1Ub25NMG40OG95cStmVDY2NVlNOEFvZk5hTWZw?=
 =?utf-8?B?UWc4alpPZjBpYUVYRklwZDN6SGFjb296YjQ1eHo2encxTFYyNFBPMEh0c28v?=
 =?utf-8?B?RzZieEdFUTNzWXVZSUxRUktyTkZjSndLRGduOXBoMzg3WlAwclhPTzhGNU1W?=
 =?utf-8?B?ckYxbG5ybGViUGFBVHd2bmR0cDJrRmtDSlRwajk5blMzeGo0alVZbUVnV1dp?=
 =?utf-8?B?dTdibXVBaTNhdVlVT1BiZVIzWHVCdVZhRlAvRGpiRGNaWUVZK0ZueUV4VTFy?=
 =?utf-8?B?WTRpbzVyODRnUU1ZVHNvODFzZjRQSWNkWVhrd21MTHRqWkhLeG5ueTluVENp?=
 =?utf-8?B?UVpEN1pMN1phdHRtMVhrWjhyU1JubjNqVnNremFudnh6eFVEcTlYZXg0YUJX?=
 =?utf-8?B?STQzR1Z6aG45ZFdFckQwcDU4NnBXV2JPT3lxZ2pzdXZuVUFxcTl5YW8rZHJo?=
 =?utf-8?B?bGkrVFpEVUc4bjZRWGlqNG10TnlPdnpndWwvNEtLWXRXZ2hiZnRJdDNYRmsy?=
 =?utf-8?B?SGdobUNQMUU2STVXU1RGMHQyTWxudEFYTU5iYWl6djc4eHhxbGVSRzAxU1hx?=
 =?utf-8?B?M29lRnppZ2hJa1MyekR0clVsMXdKMkIzYndvTG5SaHh1NnVZUk5RK3VGZ1M2?=
 =?utf-8?B?Y3Azbm5ZZUhBZ1R3RHVsWXhHNmg0djNDYU03OElGM0VLZzlvUjBHb1c4NUVL?=
 =?utf-8?B?VGVjZ0FkWndoaXJEQmZVYVUvTkQ5V2xZQzRDZVdsbmJKSUFscGhJOW4xR1JH?=
 =?utf-8?B?ZUJJY0VUTzQyRlFiaWlwL0w4VGtRbjJPeFJaNDBneWxndFVnZ0wzNzlzYWY5?=
 =?utf-8?B?NjgxWkh2UHFvblgvZGRlZi90QnQ1bnFndHdQNXFDcWwyMm9IcGN4amh5ZVBh?=
 =?utf-8?B?azRhRG01VDNaL1V2QWxxa0lIQXRSWkFZYlpmVXR3cTdPdWtXUFBOT0NhbWxR?=
 =?utf-8?B?ZVBQNmdoSW1GVE1GeHVKcy9hWVZoM2Z3Vy9zaitIeERJdHduai8xUzBNY01W?=
 =?utf-8?B?U1lJRVZuL1c2clc5NkhEUlRhTmNBWjR5TnNqUGYxbUJWWk85TXhBWitES2pS?=
 =?utf-8?B?MjFEZEVoelVhZXlBaEwwTDlrZjlMZlM2UEk4U3FzSkZHNGpFazYvcEVPR3Er?=
 =?utf-8?B?Y1ozZVd6YXZsZUVyb2p3dGtCVTFnSkxNUEtpSkNxUC9hSnE4UXFmbHU2dzdl?=
 =?utf-8?B?RGZFL2E3clZ2VjZaWGczY1grcjg1ZjBrd0s4TWVSUE5HamdJcTltNkJoVUxE?=
 =?utf-8?B?WlRObWQ0Q0xQUjlWR2hKRmkvV2o5UE1pU2hZMTgycTJTOFlFeHY5UG1FUGQ2?=
 =?utf-8?B?S2l6YkZNbi9BR3N4eEI2dGhsamMxVGNwVWwrOHN6SWZpMjIvanJjVERRZlZM?=
 =?utf-8?B?aHZncnFSZzRlWm1QWTBtZStYZ3c0NHRjMHBJeGNDL293eHBqUWxPY3ZwdmhX?=
 =?utf-8?B?TG90bVpjc3F4WkFOOGpCYzVjQUZnaWhLUE5qazN3bml1WHZlSkxpU0hWakNs?=
 =?utf-8?B?eFFoaWZ2VllabnRtZHIzZUMrVkk0bm02WWZyZlBRTkJ2RGQzSFJRem9zRkND?=
 =?utf-8?B?cGNCa0FHenhjSGNWeWhZZC9wNGY1S01GTXo1RFBZdElJMjV4M0d6a29LUWdl?=
 =?utf-8?B?NWtBbEsrL3QrR2ZXQ28rQmh4MUF1amJkOVErQVBZdkd6MEtSNFdTMjZ6Zm8y?=
 =?utf-8?B?ME1LTWREZjVmL2V5L0ZhajhxcGtFWFRpRU9aYkx5ZXMxTVhCZEpNRWFmcmdZ?=
 =?utf-8?B?eUtnUjcwQ3R4RlV2akQwUWlsVlp6ZzRQemd3c2VIR1BtNmozdktDVU5iZVJQ?=
 =?utf-8?B?eVNTcXRjV3dqMlZjS0ZRSktVOHFZc0VwTmNPZXRMZmhQd29vc2doYkp4Ry9p?=
 =?utf-8?B?d0laNUU1NUhhT1BZOXFMcFBwVmhaVFA5bThqVndVMzNqN0dqSVBrMHFCQ1BP?=
 =?utf-8?B?cEszVHRDZmxjNU0wS2xrem9Bd3JZWkVER3JZQ0N6VG1wb21DeEc1K0F6OUpk?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a1FpZ1JXVTJQUmNvbDQxN1FHR1pNVkVIYkp5emFCVE5Kc011R3VyejRkZGhT?=
 =?utf-8?B?RHFCUzJpTFlnRlhHQUZ0NStXNjY5Q29kVkErckdxNmtaeUVGaGlkdEM5MWh6?=
 =?utf-8?B?ejJ3WTU0dkp1b1BNT0QwZS9Tc1pLdGFUWVV0UUhoeUwxRDJTRS9YenlPSjFC?=
 =?utf-8?B?Uk5UUmdJeE5ISVU4WXhpaUVsYXV2VjUvR1FKN3ZzUnNJZzVaZzBBbUpRNGxY?=
 =?utf-8?B?QzQ5MWR5ejUzOS96YU41aW10bFhUVzRtMjh2T0d4WXdnL0RUcHBsazhGbURR?=
 =?utf-8?B?RlpGZzQwRE1CTWVOZXZFN0ZmRE0xOEtOMXFFTUNoVVJ6d3M0QzFWVUYwU2lV?=
 =?utf-8?B?L2RaM1E1SHhqQTI1NGJXSExGU24zUEpBUUJkSHZNYkNWS3RrQUhqMVZ0V2t3?=
 =?utf-8?B?SW1qTXpOak1haE9YRitNcXZNSXBvd0x3M1RsOUdzZVFGUjJCRXgxWVJ6d05U?=
 =?utf-8?B?dS9OUnh5bk9xNHdPQXBUV05STDZGUXl0b3B1OFk3cC9wTXNtdkNtL0VzQm85?=
 =?utf-8?B?eVlsdzdxK3Z2eEJXSFFoczZnb0R3MDlxdldHK0h0bjMrSENHT0JYVk9FY25X?=
 =?utf-8?B?dlp4U3J2SW54VW44ZHJHOWdyeHFOZ0xsZWZMcVFxQ0NGaHVvUGdIU05SZXNH?=
 =?utf-8?B?bzh1ck9GYjBuUGlmSHVoeTVzYzA5T0wyZU9CU0hyeDBFYUhMcVJSUEF4L0dC?=
 =?utf-8?B?bFUzNnE4TlNCVjhnTEVMMGh0MDBFckQ5K3hpQk40cURRRXdzMHFSYzB0ZGpy?=
 =?utf-8?B?aUFVTlBUTGQ0eHFDOG9xN0NMTEhhWXZRdk5BY3laRjZqZXZjOFU5R21ad0RZ?=
 =?utf-8?B?bEZTak5DOFhmZGxnK3NyUmpGVnBVRHJOUHJPYjdLenc4Y3U0SEZLbnNkeWNP?=
 =?utf-8?B?R3ozYjEyYmFIclFvVTBpelVQQUwvaW5mL2N4M2RyUTVaVk5mR2Z6Q1BydFFJ?=
 =?utf-8?B?RVZiUGk0ZjFva1F3UWxHR1Znc042OElDYmw5N0N0RWMya2hoMURwUHBZREdQ?=
 =?utf-8?B?WWp6Z1FTS2tjbTIwcjJuWDNSQWkxcDdobTlRckhtU01QM2lOQkNkYkdLR1hB?=
 =?utf-8?B?ZXR2T1NOczQ0aWpESW9xY1RQOGZIUFlsa2JpRUEwYnpYV1Q0bEJNaG1BeGsz?=
 =?utf-8?B?bTk3SCtZWGxJUHZGSmJxQlRNNU5mdHNMSFI3Nk14V20zMTVSUUF6T1ZrdVNu?=
 =?utf-8?B?VFBqYTRLd09jbjliRFQ3TXJKdkpGandWQkl0Q29IT2k5VzBNamVnem9SMCtz?=
 =?utf-8?B?ZUJCVjVpSUx3RzZtUTZSbWRaVWNCSndKaitld2Jqc0lOQmtKMlU0eG1BOGF2?=
 =?utf-8?B?Z3BnK08zYU8vcjNiaDlxWHhEMDJCR3ZQTDRFcS9MYnBFbFlZTWlNTnlyOWgw?=
 =?utf-8?B?Z0duQUhEUGdENXpXZnYyYzJwbEllendhK1NXSkNUSUFGV2M5V0ZlS05teTJG?=
 =?utf-8?Q?GbCajPKM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05827fcd-9c8a-4f22-9af9-08db57b394dd
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 15:21:41.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNKRqEPlokXF6WamxGsu+0t/SGXXNIujNCJA+dM3DAgk8cKMygHl6rTAGveFECBRy2t2xCXLpFvecYQINmtFRl6qmkA86t1TvBCSmfo86AU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5894
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=515 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180124
X-Proofpoint-GUID: bDB4a4vlIqNoaMyD-e7zZQi0c7yzVTQo
X-Proofpoint-ORIG-GUID: bDB4a4vlIqNoaMyD-e7zZQi0c7yzVTQo
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 10:49 PM, Eric W. Biederman wrote:
> 
> Long story short.
> 
> In the patch below the first hunk is a noop.
> 
> The code you are bypassing was added to ensure that process termination
> (aka SIGKILL) is processed before any other signals.  Other than signal
> processing order there are not any substantive differences in the two
> code paths.  With all signals except SIGSTOP == 19 and SIGKILL == 9
> blocked SIGKILL should always be processed before SIGSTOP.
> 
> Can you try patch with just the last hunk that does
> s/PF_IO_WORKER/PF_USER_WORKER/ and see if that is enough?
> 

If I just have the last hunk and then we get SIGKILL what happens is
in code like:

vhost_worker()

	schedule()
	if (has IO)
		handle_IO()

The schedule() calls will hit the signal_pending_state check for
signal_pending or __fatal_signal_pending and so instead of waiting
for whatever wake_up call we normally waited for we tend to just
return immediately. If you just run Qemu (the parent of the vhost_task)
and send SIGKILL then sometimes the vhost_task just spins and it
would look like the task has taken over the CPU (this is what I hit
when I tested Linus's patch).

With the first hunk of the patch, we will end up dequeuing the SIGKILL
and clearing TIF_SIGPENDING, so the vhost_task can still do some work
before it exits.

In the other patches we do:

if (get_signal(ksig))
	start_exit_cleanup_by_stopping_newIO()
	flush running IO()
	exit()

But to do the flush running IO() part of this I need to wait for it so
that's why I wanted to be able to dequeue the SIGKILL and clear the
TIF_SIGPENDING bit.

Or I don't need this specifically. In patch 0/8 I said I knew you guys
would not like it :) If I just have a:

if (fatal_signal())
	clear_fatal_signal()

then it would work for me.
