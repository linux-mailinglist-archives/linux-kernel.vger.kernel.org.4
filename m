Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7826F35EB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjEASj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEASj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:39:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0F11700
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 11:39:54 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341HNwGt014500;
        Mon, 1 May 2023 18:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PUciHKk5sopbGTQXwbPpOYAfTyb6mIwDngZnNVm8zks=;
 b=ZxVePz72orG7CHZKIxpL8Za/AES6XtC+UNS9RORkQTj8nJCqEk93pYy2T44SwET7j3wp
 tQJJb+Vz7O7dxkVNHWkgiUBj8GTQe/8FpY8uL7mxQHtnPbGZMyHS9SUQDqAsyN/gPtqE
 RyrGZUxb0G5j88BrNWhCUYbVIQPO8L4pNu+j46ScAfP63HM1R3DeIMXNYgItigs4M2pX
 5Psp2ALSN2ytHhl1eaRZB8ceGOC47sS4YLVxyhx1ucJsCO8KdrdFPI+HOZzE336jxCOz
 2vnGQB5Q/hx7ZnoOng/Kw9XGYw3xP/XufSkmPWBcKaq48BEveJyDWqzhv5Ftppx8EEX9 mw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9ctyp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 18:34:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 341Hpg4G017827;
        Mon, 1 May 2023 18:34:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp4rqc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 18:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IG2NQ0uaEsNdX6Kjh8NDWkq7q3A5mFNo2wRNbdoPmOv5lk6DW3eL668jtSGlUxe1IRvKYabxZqmwAnNVVUjogByJUhmEZJGWjHRysRtjfjCmGKfQTADsEBZ5iEnWrJ/gPzXITSBtA7AX06knpxG1iixob/Gbr67pBbAm09yKSxiyahgJMmt0EDmm24eO1KmW6243yOocVMAZZNYEJ4AUOQ08KvDvoM3MB8MM23gYl96lUUEp6KZ77TZcM+bCH4r8VHmKDCdsepBqRx9moEB/vSgNajrw1p+4OUudmp0UnZwDkM8mxMfaPv4bYrV1X+6NiHuA8Qyryw5Lc7xvsxb7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUciHKk5sopbGTQXwbPpOYAfTyb6mIwDngZnNVm8zks=;
 b=LGSZ4nM39fkWvzxM3ix47G3S8xv2uFxdaCjLV7abszI70b8ShXv/bOQ4cXWI0geCUuPHgMqgLj+Py2oSmIZr0cSwlZWZlKHZcNHQdK0k4D7RG3O00muz/czosn2+vA2ve5W/hSy+rf6TXhEZfNHQHsBcSZAx++OKCJ7SGeV3EMwGTo8iwmnisRfKPu/LtP8AAbnsoJa6+ytVoEihhyhdtdwQxBLIDs97WsivBVAlF5Bm2mQpq9YkZMNwQTeUs2aBOTBworPO8IFl1nWqfBbMzStXLhl54YRV0M+bxIJ4CYdCedqPTc44Jz3urG1ZgBK8Ipj9ARAGAAnY2jLOfs4jdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUciHKk5sopbGTQXwbPpOYAfTyb6mIwDngZnNVm8zks=;
 b=XVyljraJjgyUU8+EB18xe6fzuIQy2c+SopLzlVgLpZreTVc7eT58txt2okYg5cpT8yZWS9jVg2VnrrGyYao+zgsfVSN5Yli4tQfo1sordyda9db7hd/jTcL7lIzYqYjMkQKxq6cXHeqA9FTP3rAeJObbMG8LmFORA0GoX0kPoEo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA1PR10MB5844.namprd10.prod.outlook.com (2603:10b6:806:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.26; Mon, 1 May
 2023 18:34:23 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6340.024; Mon, 1 May 2023
 18:34:22 +0000
Message-ID: <b4c5348d-c8a1-2923-6d91-d10c359adbd1@oracle.com>
Date:   Mon, 1 May 2023 13:33:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v21 5/7] x86/crash: add x86 crash hotplug support
Content-Language: en-US
To:     Hari Bathini <hbathini@linux.ibm.com>, Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <20230404180326.6890-6-eric.devolder@oracle.com>
 <da95e01d-24bd-676b-3a48-bafda1b36cda@linux.ibm.com>
 <ZEo3NK/9Nkc7ctrc@bhe.users.ipa.redhat.com>
 <409c8253-49b9-6993-f79e-8e6203ce4b31@linux.ibm.com>
 <ZEuQ/hxmZey+eFZs@MiWiFi-R3L-srv>
 <97d18ae8-468d-cff5-0a32-4f07b050899e@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <97d18ae8-468d-cff5-0a32-4f07b050899e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0684.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::17) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SA1PR10MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 297304b5-e03f-4a5d-c8bc-08db4a72aee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /eddW3MzNVjY3IMwXxqhxo1okmMoFCXljmvbYdNXndXsI9hZYlwTMa8Ypd5kObMJ70JXUueV75fPngCrYUd26XDTuSYRjLrl9MCne0OObCUdW5AbzCp2yR6EDN3LDaOH/cTh6j12TMGNMvSg58Bki59HSXblM9vFqksf2CcVvBXdeF+xkASvE9hSTQgNBDDt1nkZdHUFCpTOBUdykYPxj2KBcv1fbTQscg9x/7ZSS5Tdaz0nCKJWYdQmKIboU+94eht8zo6GQuZ92dK35NtuJssiMUtd+hHyumaddbDI3DMifecaEexnYQvyZmM18mOxz/+FOGBUw99Fx2fquV22sw1Ge231fa6m79fRztxvr7b63VelPn5HAfAixDWCZFpNPBEH2Hx8OR02zR4el4Djtf0vF6hDROLkf+ZfBotgUQBe+62Mxg9CAQQF1Qr8uivqe9RUvRkhJ/bWpKNZZvWv+OQGF8J6uX4UrwnPnLf+5VH7CknQEEEV+2052jSxcWLDcptTK7Iu+8jeuN9bqnMFMNiv8XjhRIaWSyCFI1b+kwvklcSyra/qTnCDCLwXAgZh6hL1kY4P0bMjwoiVsgy0byY+iYPGJPW1uAozdpH3zn+hTa/HzZ7js7PCWq1ty56UZYM03q73sRGvm2QBx3n2ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(31686004)(316002)(2616005)(53546011)(6512007)(4326008)(6506007)(8936002)(7416002)(8676002)(31696002)(86362001)(5660300002)(186003)(478600001)(66946007)(26005)(110136005)(83380400001)(41300700001)(2906002)(36756003)(107886003)(38100700002)(66556008)(6486002)(966005)(66476007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHA5cEZpcWhxY2pTNEFteG11ZVB2NkpreDdZWnhJRFNoRUwwRVF1OFo1dnQz?=
 =?utf-8?B?K0VWN0JCZDZzRjJDWmk0SHZoVnp6dXdWSHM4MkhqbzdMRDZJczNiK1Z1Qy9r?=
 =?utf-8?B?MEQ5S211c2ZtZUI4MmZrSDR1KzJwMFJ3UTNJOGR2MmdQeDBhSzFkc2c2Zk5H?=
 =?utf-8?B?Q21uRTRhTWtSazFGMDBrQ0xjcmhqZGw4VGJnWnYxMUlNMHJmMTg4SjhBejBh?=
 =?utf-8?B?OUQ2ditDQXhodEZZTmR5UVNHYTVKWHJBTTZQYVF1b005Q3ViMll4aGNjQk1w?=
 =?utf-8?B?cDBKOWQrRmRVYjNwSjBqcGxHVkw1MWJzUklrNGVrRm1POHJFVlVELzJQelN1?=
 =?utf-8?B?WnFma0dFRVBRZ2lzQjJUcGtTUmVZN1NYNC9lM0dIaFYwcmd3TTBaRXE2V0o0?=
 =?utf-8?B?dHh0QVJRZlhvbzM4YjRGYVFGM2dGQnBDQldHMXBHdE5kZWh5SnUyb1MzZVdQ?=
 =?utf-8?B?bkhRR3Jadk5MUm9ieDh3bkRkTUdvQkJjK05aOTc5dXIxWVhFc1hYZHhMNndO?=
 =?utf-8?B?OGh0dEdVb3hmUVUvSEZscGRpRkhUZWk2TGNUQVFINlc0STNaeDdtVllGbGZQ?=
 =?utf-8?B?bzl1bHptSGtjb0JOUGRsQitvOC82MjI3QXdiMi9BS2IrTEhjUS8zSmR5eXhW?=
 =?utf-8?B?Skd5YVBlcHJZb0FYRVhTaE9WZjN5bHczejNOaUZNUVloRG8zUUFmL1NKQjVv?=
 =?utf-8?B?SnpUeHV2dmYxMUpvWW5mWFpDU2tlNW1oY3JmNzArZ0Nsc0UvOGlvblB4Ym5h?=
 =?utf-8?B?cjlPbWtPdTVUNnVibmdoS05XTTJSb1dPYUI4T1d4RG5vQnpEZUZvN2tINlRT?=
 =?utf-8?B?M3RTQ1B1V0dqOEE5RnpIQXg4STVCQWU4OGZ5VFVkaVhEZWFrVTgreDA4ZjJa?=
 =?utf-8?B?b1pISEE0a0dZb3VSYnVYeHFoU1F6YmJpcUh2dTRPM2FUR1JEN29KSlp5S1NK?=
 =?utf-8?B?M3M0RkpqS00xaE5xNVFvZ2ZwNFpRQ1pKMG5uRmdFajV0Sk5kWG53ZVU1WHdi?=
 =?utf-8?B?aXpXalpPanV0TDNhcytjWFJ3YzMwYnMrdW4zV0xrcnB0T2UvSE5qak5KeWZV?=
 =?utf-8?B?bDB0Smd0aCthZ0tONWx3d2lqazlpd3VYWldPRElDaCtaMFdSWDc4c0d4NXFM?=
 =?utf-8?B?VUs0cjJmbHFxME1xVGRlMHNlZm5wZTZiTlZHVjB6aUdTclZSMTNEY2NheXVw?=
 =?utf-8?B?aDZjcENZZGdwMTZOTHllaldYME1ZdzFmYWVhMVpVemRtcDdZM3NEVEZzcng0?=
 =?utf-8?B?VzNqdEJTdjBub1RPL2F0ZVNIU2h6QmcwWHppWVc0M1pVamkwK1VJOVpEendS?=
 =?utf-8?B?dFY5OC9UcTZoeU15akFkem9YQjlRS3l1bWRmRlllK3hlVWY0RktwU3RPU1Iz?=
 =?utf-8?B?WUpIL0ZEUjNqOG5EMVZsSEFNR2FqMGpqNG4wZk5DSTJxWjB4OFRod05iYnRm?=
 =?utf-8?B?dG1uQmRwMU9ibDNwYklYWlpPSXVoRk5kaGs2WWllUlVXUGlnMytYb2phdzE1?=
 =?utf-8?B?L24xaG91dVBBM3RyK2V2RjVyRER5UHgvU1cxTXljNkkrY20vZ3FsQ0VhNkIy?=
 =?utf-8?B?RWNMM2ZzOHhqWENzV28rMTBDclowQUtvZ1l5cHY5alFIRnJYUzhnZWJtbEM2?=
 =?utf-8?B?VnB5SlZFUy9KT1l3Y0prbFpHejU2bDFhQUkxV2Uyc2RiQ3ZwWm9Gb1l0U1p3?=
 =?utf-8?B?RHgzMzlXaWZhaXBGZ09BaGxheEFsTXp1cTRHaWZ6TURmc2luVDE4UUlqdlVG?=
 =?utf-8?B?eC9RRVlHcitxMjFTRjdRM09IdjlndjBLMmZMN2RjUHNCMjBxOGQ4dUpKT29n?=
 =?utf-8?B?RFBaaVJqNk9SZUxuQjdrZEFhd1AraXFTanlsenFHZXpvNjJQZXNQQmg1Y0F5?=
 =?utf-8?B?WUpKWU81eHFDbmRHS2xBVjJ1TG5nTnJHK3p2L1pFMkI0aHV3c2N3bEVxRkd3?=
 =?utf-8?B?VkQrRGtidUE0Q3V3dkE2OTJ6clhidUEwZ0RYTUtyeC9scWRCczlaYWZmemJY?=
 =?utf-8?B?MzhrNTlPUFhERTFMYUsremExdEx0YmtWMVVPdjRGZzdiTWhxNUxkeHpIckRU?=
 =?utf-8?B?VU9ONkU2bSszejBDZ293VWFkZHlvNXE1TFpaTDFMSG80YWlkVDRBM1NESXQ1?=
 =?utf-8?Q?ltbKd/dpsGNB0ich08ld6Pg+1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TUJKN28xVlJFKzlwbUl3ZmhpdWlERjNOK0tQSFZOUlNoeDdXTkQwMXlSVGx6?=
 =?utf-8?B?aDYvbHcvRGxjR1YrVWhnakNtOXU4bkx5bERaZlI3VHpLT0Y1ZzJIYzBycWhv?=
 =?utf-8?B?cWh4bEZiSjNBTDIxZStTUDBUQnFVZ2ZTd21mZ1BEUmVnYzV0akh5YTRtZ0h5?=
 =?utf-8?B?SmRBYmZ3WWVJVHVsK1RiQ3dCLzQ4cWQ3TGNnM1d4SDNXRDFBSFZTekdvUTk4?=
 =?utf-8?B?dGhVZGtUSC9ZWFJXNnB1UEdpZHRsZ1F2ZVFVVGs5ZmV6dG5PU1RCeFh3Q1Vv?=
 =?utf-8?B?L2F3NFErVW9iVHQvbHk5V0JvSE1aRElRWms0SEREZXhVa1Y4aXJQSFJGSE1B?=
 =?utf-8?B?amplVmtQTnZJQjZZRGdxZjV2elFXekZaKzUyQXRKbUQ2M3crRENhdFBZVTdn?=
 =?utf-8?B?ellacXJoaVNybTQxZUh2YzErTFE5YVlKQW0wSlIrZElkN281NmNVVHJyZGty?=
 =?utf-8?B?SXZlWlJXOURid1REMXRhVTFhWFFWVnFJL0hkdTZtWlNkVXhjbVNxSVcxOXN2?=
 =?utf-8?B?dVdSNmoyN21NNXpEK2w3c3VVNndRRGlId2gzc3lUem5mNXpsM2xpYk5yUmVy?=
 =?utf-8?B?enNaN1daOVl0U0ZyelZycVF4VXhQaVltTFNLUW96THFrOUluMkhDMlZGSlNC?=
 =?utf-8?B?M28rZ2JvUWdJQlFRa2RQUEd0dUFDSUVHMGdkejNpVWY3NnB0bllOT1hJRWd5?=
 =?utf-8?B?TGFlSjRvbnA2RzBEbGFkQmlUUWRNbk9maDJiajBML3V4eG9HOGFUWkNrc05X?=
 =?utf-8?B?Z3kvalFJVWcweTYvcUYzSVlLaGVwQlRDLzN1ZnlPcUJiL21BMnRFV1BRc1d5?=
 =?utf-8?B?V2Y5WTQ3YXVPN0psWldxTFc4WjNqRGJKcktzeU1wTEhSMFVYYU9lTWRBTzBi?=
 =?utf-8?B?cWpJUnI4Rk4yMXFIeTJDbE9CSjBwT0tYRzFzNXl2SGV6ZGY0amdPQ3JkRk96?=
 =?utf-8?B?dGc4TTdFbzAvcDNMRWQvNEpPZ0VmR1Y5VW82ZWdRUnJoN3duMmRObDdWNWNx?=
 =?utf-8?B?QVBGbE1jTHhmL25FeS9KVEkvSW5YcXBrRmlvS3RMYVdBSENUTXRWcnlGUDhF?=
 =?utf-8?B?RUZTL0FVUDhlTC9vdlFJTUtwVVMvdjM0ZzVWdlVmVjMvQ0FxVGxsMkpIQkE0?=
 =?utf-8?B?ZmRuUFRvRW1KM2NlZ1Nzbm1xeEcwbERvNStMVW45cVIxVFhHTFI4UzRHOER6?=
 =?utf-8?B?NXp0QmI4ZUgxTWJoQ2JnT0JDNGRsTFlWRzB1K2U4RjhSRFdYSElJUmZUMzFH?=
 =?utf-8?B?dDdHendDTUJDcjF3T3ppczlZMUxtbXFiVGNiVVZ3UzBvUURKWDNic0hOYVgv?=
 =?utf-8?B?Z0RabW9sWms4VktuYjdTczkxR0UyaHRQTmRoWW5mUDNhcHVpckx3b2dMdFlj?=
 =?utf-8?B?NzJlQjJPQlFZY01FTlhlaGM2STZ2NGI1SWJUZkx0WEZadGYzQitQTlo1VU80?=
 =?utf-8?B?dDBOKzVzWEUzbW9XNmM2c2lDK3BKOVNOT0VGVkExSk9FZ2ViczR4OVpPeHM5?=
 =?utf-8?B?QWc4cWZranpaMGtDVUJJTzlVZEZHMEdxWVNSOTNyOG91QWd3R1JVWDVVSW9F?=
 =?utf-8?Q?xCl5I9VWT7vBkFss+POa0wA28=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297304b5-e03f-4a5d-c8bc-08db4a72aee9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 18:34:22.8662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHv7RLmPx8mPdApSSl4HHb9X1/1GQn4yBWM1QWBksijz2VFhVkP3GCqg9YJGZ8e0dQeeHLr4adjRHf53K1dA2iP8pd2C2PsuboPUGt/+4Pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5844
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_11,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010152
X-Proofpoint-GUID: AAsiutRZy5QT-yVB_VmZwFivokAFNEWw
X-Proofpoint-ORIG-GUID: AAsiutRZy5QT-yVB_VmZwFivokAFNEWw
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/23 13:31, Hari Bathini wrote:
> 
> On 28/04/23 2:55 pm, Baoquan He wrote:
>> On 04/27/23 at 10:26pm, Hari Bathini wrote:
>>> On 27/04/23 2:19 pm, Baoquan He wrote:
>>>> On 04/27/23 at 12:39pm, Hari Bathini wrote:
>>>>> Hi Eric,
>>>>>
>>>>> On 04/04/23 11:33 pm, Eric DeVolder wrote:
>>>>>> When CPU or memory is hot un/plugged, or off/onlined, the crash
>>>>>> elfcorehdr, which describes the CPUs and memory in the system,
>>>>>> must also be updated.
>>>>>>
>>>>>> The segment containing the elfcorehdr is identified at run-time
>>>>>> in crash_core:crash_handle_hotplug_event(), which works for both
>>>>>> the kexec_load() and kexec_file_load() syscalls. A new elfcorehdr
>>>>>> is generated from the available CPUs and memory into a buffer,
>>>>>> and then installed over the top of the existing elfcorehdr.
>>>>>>
>>>>>> In the patch 'kexec: exclude elfcorehdr from the segment digest'
>>>>>> the need to update purgatory due to the change in elfcorehdr was
>>>>>> eliminated.  As a result, no changes to purgatory or boot_params
>>>>>> (as the elfcorehdr= kernel command line parameter pointer
>>>>>> remains unchanged and correct) are needed, just elfcorehdr.
>>>>>>
>>>>>> To accommodate a growing number of resources via hotplug, the
>>>>>> elfcorehdr segment must be sufficiently large enough to accommodate
>>>>>> changes, see the CRASH_MAX_MEMORY_RANGES description. This is used
>>>>>> only on the kexec_file_load() syscall; for kexec_load() userspace
>>>>>> will need to size the segment similarly.
>>>>>>
>>>>>> To accommodate kexec_load() syscall in the absence of
>>>>>
>>>>> Firstly, thanks! This series is a nice improvement to kdump support
>>>>> in hotplug environment.
Thank you!

>>>>>
>>>>> One concern though is that this change assumes corresponding support
>>>>> in kexec-tools. Without that support kexec_load would fail to boot
>>>>> with digest verification failure, iiuc.

Yes, you've correctly identified that if a hotplug change occurs following kexec_load
(made with kexec-tools unaltered for hotplug), then a subsequent panic would in fact
fail the purgatory digest verification, and  kdump would not happen.

>>>>
>>>> Eric has posted patchset to modify kexec_tools to support that, please
>>>> see the link Eric pasted in the cover letter.
>>>>
>>>> http://lists.infradead.org/pipermail/kexec/2022-October/026032.html
>>>
>>> Right, Baoquan.
>>>
>>> I did see that and if I read the code correctly, without that patchset
>>> kexec_load would fail. Not with an explicit error that hotplug support
>>> is missing or such but it would simply fail to boot into capture kernel
>>> with digest verification failure.
This is correct.

>>>
>>> My suggestion was to avoid that userspace tool breakage for older
>>> kexec-tools version by introducing a new kexec flag that can tell
>>> kernel that kexec-tools is ready to use this in-kernel update support.
>>> So, if kexec_load happens without the flag, avoid doing an in-kernel
>>> update on hotplug. I hope that clears the confusion.
>>
>> Yeah, sounds like a good idea. It may be extended in later patch.
> 
> Fixing it in this series itself would be a cleaner way, I guess.

You're suggestion of using a flag makes alot of sense; it is an indication
to the kernel that it is valid/okay to modify the kexec_load elfcorehdr.
Only kexec-tools that understands this (meaning the elfcorehdr buffer is
appropriately sized *and* excludes the elfcorehdr from the purgatory check)
would set that flag.

The roll-out of this feature needs to be coordinated, no doubt. There are three
pieces to this puzzle: this kernel series, the udev rule changes, and the changes
to kexec-tools for kexec_load.

I consider the udev rule changes critical to making this feature work efficiently.
I also think that deploying the udev rules immediately is doable since nothing
references them, yet; they would be NOPs. And they would be in place when the
kernel and/or kexec-tool changes deploy.

However, your point about supporting kexec_load with and without this new flag
means the sysfs nodes upon which the udev rule change rely need to be a bit
smarter now. (I'm assuming these udev rules will be generally accepted as-is,
as they are simple and efficient.)

The sysfs crash_hotplug nodes need to take into account kexec_file_load vs
(kexec_load && new_flag). Generally speaking these crash_hotplug sysfs nodes we
want to be 1 going forward, but where kexec_load/kexec-tools is older and/or no new_flag,
it needs to be 0. In this way the udev rules can remain as proposed and work properly
for kexec_file_load and both flavors of kexec_load.

Good catch! I'll post v22 soon.

Eric

> 
> Thanks
> Hari
