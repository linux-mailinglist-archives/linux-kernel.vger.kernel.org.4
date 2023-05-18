Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E61B708BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjERW6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjERW6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:58:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F25103
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:58:16 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IIx5xM025244;
        Thu, 18 May 2023 22:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9Zb2CO0ly4z1FqsB8HwtzXprSMj+dbovRbG+rdDiIrE=;
 b=Towq3yGTP2pc48TaI7BW+uqLJyQZySraFNaSCe2b1enFkrYb6Sw301opZHk9esGlydWF
 u5JSShqnTzCBbpYiq1xSOH9/3hSZ6nIx8red6IbdhYIs/bDXEWhGjsE+uRP8nB2Vnklt
 SvPl6JQGvNg73Fod2NgJjQ7kr9n89xoEVIHjkFRP0od8fnRJynsBenN+cGwT3Rfsam5k
 ocdnPtWlAyCxsK4hGuhrXgQEvP82dpOvlKmL2//b0gZ4yb69r+wqPnOnzfb0/BJUk76/
 N9/XSeJCFk9NDb1SSviHwD9BVuSjKHY/LL8Pn5KXh0qKQDzsgtdoFKk6d9o/UgaR13wY qA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc9d0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 22:58:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IL2aDe025048;
        Thu, 18 May 2023 22:58:00 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107cffb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 22:58:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTSnJ77we0pKGi1c+cA8qWVhaZBY+3cKPXvv0M8JCsQsuEZs1eCfXYTVaspsnRV6i5ZGm5uagMSDTzPn0VCqM4206MstMQ8hsFOaWgQ/fstfkqKQoYuflxw4SeyAAIfa6ha6cGjXCBRfO028q6uRkyjDZ9g/gLLQgI3PGtm9rQfFKZ7nj5shZot6oyS7XboV4zcINkrCGUt3ZeqQBbUhfb2KtSd8sz9K6MVRiB03C82tF1vrAB9m2BJpom2vS+qBL8oBqi0d4xL+itBdT1ZKmwaNMQOUmkyLl00TlbIcL2C0Q6emNP4nm20eHhcBGa1kPfdofJuE7fGRu0T/WMYiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Zb2CO0ly4z1FqsB8HwtzXprSMj+dbovRbG+rdDiIrE=;
 b=Olk8QxHu3EvZgAZUHwAEn1d4AUQ/Mklh8MVqedK5s8bANOeiZhP3RKFzAP/sukSj5DOOiSmhkIVFwTw4VyvaxTobZZtvGexS9UE1Ama+4QBueRsggdImMsa/bIRDkxByVvwOiwoPufCQXSq+Z5dx2t8bC07vfYbOlYqKRDpVH/79DKug27tM8F/qeLPnK6xYpGsdnREeEGJCUX4PHj1aijBQdse7EamSsAop0mejHid0E4bTBC+OTTDk0LQCEoEMLK5YjfwaqX/uCr/VYKEC11F6EiYw6skOozB/Of6NL+eHNhOmX+/IYVu5xcHYn95WRXqHt+OSM3/mlKmgLYVc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Zb2CO0ly4z1FqsB8HwtzXprSMj+dbovRbG+rdDiIrE=;
 b=Mk0+u37iDqh2uwBugBmUOKEabLbgUiDWO65u83kb+rTHigfFUqbH+oKucJjEbscvqE2BgO1/CMMwqlhvZqf1aqR96cquc0dz8IhR7zqKUF8E1SltfKOICvSOpebOzBQNpYgUB1IMTkPOgQYwfN0+mM2dvNrvzK5nLQstRA2h9f0=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA3PR10MB6969.namprd10.prod.outlook.com (2603:10b6:806:316::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 22:57:58 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 22:57:58 +0000
Message-ID: <677200bd-4cd7-e0a5-eab0-46ee29128281@oracle.com>
Date:   Thu, 18 May 2023 17:57:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if
 SIGNAL_GROUP_EXIT/group_exec_task is set
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-2-michael.christie@oracle.com>
 <87ednei9is.fsf@email.froward.int.ebiederm.org>
 <ab7d07ba-5dc3-95c0-aa7c-c2575d03f429@oracle.com>
 <20230518162508.GB20779@redhat.com>
 <05236dee-59b7-f394-db3d-cbb4d4163ce8@oracle.com>
 <20230518170359.GC20779@redhat.com>
 <875y8ph4tj.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <875y8ph4tj.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:5:15b::35) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA3PR10MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a6c6b5-3aba-4d23-cbb6-08db57f352a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKN7ud4RuI4GzYhe6ewVeYLsEswudZSbS8Sot/XcrIDU9dZHkgvmjOYbXogcGrM3Qm0eEKPFqSsB6l2vnvTGweSOYOdIYXW8C7Ucz9uXS35U9qHIXZ4pPmKGce37z/GLynWO8QlxVmJE92OWipaUiAvsTjOFpSjrv8AzXjcBeh8yI5AbBABWozdkSYh4CBHIKsvKRqb8kmtm1u2VJuBfMdiInoT3U3/+KsyukCcaVoLj69/cHVLY6UMxsEP5HtFRtUev/xL3O6JsxnbyHEkwYQekskk+HCw1oP7DE+IN6BkF4HuHbSSPiO/jjERwe+f0md6yQh0jyMPgog9Xm944NvuzflYQMQ/FcskgQRH4t5Mt+e/39p7jHbrAVBSfs0zg5yfA38sPyLj76r1o67hVXgSSgYJYlA37InvQFFpVmhXsY3uTVudnw84cBq7ZDkadnZF3kG0K9iVv/Rq6B4WtrxGN4Q9Cj9Luo4t/HcOqFT98IffeZiw5+pzoE4STHsREfCJPSPeEqb+o9bZXikNhG4+K5z9zxBF+i/fM/w0OlEe4RW96w4Ry3kZCjHaceuu+mzVmWOmpvf5nNRRCFiURdOHsUbS9mBvMwngfk+K+vwCkZ3QRShXmH0peiZEjTE6aaUB/AgwALNYOKDtBVnl4XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(8936002)(8676002)(316002)(5660300002)(7416002)(83380400001)(53546011)(26005)(31696002)(86362001)(186003)(6512007)(2616005)(6506007)(38100700002)(41300700001)(6486002)(6666004)(66556008)(478600001)(4326008)(36756003)(66946007)(66476007)(110136005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUN3aTY5aDBqTXBKRCtFL1g0ODRkb3VTQjVZNkV1OStUWEVoUDRDbmIzYll1?=
 =?utf-8?B?QXlvaUM0NWxEOGpKSVc4WDlubm1UNTBXNTlrbGYzOEpaMU9GcTM1c3JGVEdY?=
 =?utf-8?B?OTNJOFphWkhVVDJYRW9ETDhlUXNRSjhqaHZ5UVlXSnhLVFZVOWIzb0MvZ2dq?=
 =?utf-8?B?KzBtVjk3N3pEVEd3cWxxK3crbWtRekQ4TnQ5UUpmNW5KWmR2Wi9jeVAwYTFO?=
 =?utf-8?B?dzVYVG9lZXk4bWdoK28zS05NQnJ4emNJZzlTb0N1Vnp2ZlBOUzVSeERBSGJn?=
 =?utf-8?B?U0E4TTNVYWVQOGhSaUpuZ2VCS0FBbTdVNjQ2NUZwVTlDeXlSeWJqZmdzWlQv?=
 =?utf-8?B?MmdXZ1FnZVZxcjkwSE9FQVJqd2t2YzNCTlB1OU5xZGV3aHRJZmhWNHBqMlRM?=
 =?utf-8?B?ejYvQjQzeURVaUo0TkNqRmkrQ0NOWmJIVmMyRDFhNG95Q0wrREN4Qmc2Y3VV?=
 =?utf-8?B?bnBqajBxcFBvVk5WSHE4T1dzbFg5OEFtUG8vNG9PaWFYWFFQc2puaWhZUUJi?=
 =?utf-8?B?cTFma1RST0E2RTlnZGpaSFNBanNzMUU0NFBMRUZNaDZHSTdrL1NTWVdDNzB1?=
 =?utf-8?B?WHpKUE9RMjV3NHBqeVI5RFVTUERVa1RlVFpFY0V4Y082Y0JldnF6N2JYNWFR?=
 =?utf-8?B?UWVnakhtYU5NUUgxeVlOUnUweXZxejQ2Q2dPd2VEK0VJUzd5L050MjQrY0xS?=
 =?utf-8?B?YlRoUGgvZzd6aXRIcjZ6RHFNSjVxWmhVSFozNmRZSWIxb1NsbXgyWm53bWFS?=
 =?utf-8?B?NWxndG13bDNXOUg2QnpRa0JVWFJnM0lpRWZaZmttRTFleGJRTHBFMUt5Y0Uv?=
 =?utf-8?B?aGRaS3ByVFFscU5wVWtydTZiK0NsWUdkcjBxY0xmSmxxcTFEQm0vVGMwSzFo?=
 =?utf-8?B?TFdhWlBuR0wxc00yUHI0bjRsV01OMWJHRGdidjNnRi9nTnlpdTBaVkFzUlFK?=
 =?utf-8?B?STNxaG40bVgrbjdjQ094L0l0am9nYld1Z0xmWlhHZ1B4ZmVUT3k5YnBxMFBy?=
 =?utf-8?B?SFVvUHZCWTdUMlhxaVRLNTZQTTIvRzlRVHF2RlZEY3NIdTV5MUhwdVpEdVRx?=
 =?utf-8?B?RHlCL2o4VUpNdHJxc3lEcmc3NysvZThQZU1SOFoxSlpBZTREd2cyZUZsMkJt?=
 =?utf-8?B?VzJoRXpYQzJKRkpkRS9aWHdNVHcxWVlwaW51Z1cwa0NYVDJRZUVTZGtTMGUy?=
 =?utf-8?B?U0xRUE1jcmNJS3NhMURzVkwxdm1mOWp3QVAxbVQ1eGxVdXNUTU9IYmcxeGR3?=
 =?utf-8?B?bGlKcVpHMjE1d0QyWkxlMTd2MVZZdjc5U3FIU1lvRmlOS3o1dlBVemZZOWF2?=
 =?utf-8?B?VmVieWpEK3FpeHY1bVk2a0tZT1AwaklnRXNPV3VOY0pFbEN6ZmpzS3N0UWxy?=
 =?utf-8?B?eStQMjFFKy9wVWRCaC9oSnR4bktZZkNnWGZyZVczOTdhUWtuenFyN0RZVXI3?=
 =?utf-8?B?aGFQMU8zNXRYMEVuakl1eDN5aG0vS2xuL1FCTmVpcnJNY0U5M3dMSm13N2J2?=
 =?utf-8?B?MlJVbDJsWm9zUkI3WWd5OTFBODRjd0tIR0tMeWE5eXZ1dWVZVTV1a01XOXFs?=
 =?utf-8?B?cGM5Tkk2aEhFVDBvZVAxRVk0K2VOTTU3aEZtQXpvZnlYY0ZkSjhNWm5GWEs2?=
 =?utf-8?B?cnphbHI5OXV1Qk1wM3hiYnRlZ0I4WkZoa2VqZzc3SFNXZUd0cnRhNm1Cd0dz?=
 =?utf-8?B?RWRJMnNSdG1XK3owaXZRMlBWeGtEbkEvdzN3KzNwcUlFbGVPVjFIUFFFN1R0?=
 =?utf-8?B?dUlqaENSUTVYQzFzZE1XWjlMZ0NIa0tWUytTMjVka3JoTVBnN0FsZXh2eFpm?=
 =?utf-8?B?Y0EyOFp1bkhaOE90dWhjNkRMSFI0YWNkUnZ4NkF3NGFtT29ka2UzbXFLSWcz?=
 =?utf-8?B?OGllWUQvajdGR2o3UkJ6a3NKSjdqWk0xdUprNzU5SXEyN2NkSGlkcU9ycmpU?=
 =?utf-8?B?N2VjUmRjRGFOVlozNUZwNkk5RlRDdjhFdGpjd0dEa2lEK2x2MXVwbWJDWGFl?=
 =?utf-8?B?MmRoc2FsODJDQzhHd2RxK0w4TjBCRC9RdHhsaEJ4cDhsTDJDaVdEOFljdWVp?=
 =?utf-8?B?UkM3RU9kMnNiRTcySjlnbjdiZllyMmJJUW10U2NCVlBySXFoSEJiekpJb0tH?=
 =?utf-8?B?WmxVZkY1RG1CclhSZTZZL3phSGllRi92cVYrdS9RaWRXbXhoaCt0ZVJjUU5t?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MnZXL1FsQmpYMGJXNVRVWE5VdCthZlBzVkJKUGQ5RTVzc3lKcFc3RWYxdEwy?=
 =?utf-8?B?b2pxcFZoNkdFNmxhWjlJZTZEdWsra25aZG1BRDl6dVhid1NlL3F1M3NuQXVR?=
 =?utf-8?B?MXpqeFZDaFRCYnlYZGpMMDNkVkZlbXZQcDB2RTlRb0VZUjNKSE1QZlJUeDFp?=
 =?utf-8?B?K1BGRy9uUGVHZ2tDaWk1TEhyNEd5ZEhSek92MFhRMkY0SkZCOWZFckpVeFc4?=
 =?utf-8?B?SmN0eUhvTGNmRUVsdXdHbktFTEFTeTlueC82UGFQZEdLZ3FNakkyMGpWUFZ6?=
 =?utf-8?B?MFR5UGFzcGQ4ZC84VzV6TFgxU01qeC96VGZPL2g2TmptWVRETjF0WEd1KzF3?=
 =?utf-8?B?VUtuVDVQU3dmNVUzRks4YWtrM1huS1Z6ZGpmc1gxTU1CeUMxY1BVeTNpVXhh?=
 =?utf-8?B?WlpSNHZGSHlvMHY4UFVjVUFyZkptTTF0eUthb0pLY2laL083SHVJM0pHRmU0?=
 =?utf-8?B?K0xYcklKYXFDTTEyNlVEdUltQXNwS0RCZThXTzk5MWFJbU5YS0hrN3VneTBs?=
 =?utf-8?B?enUvSTRFc3VKdHUrVEY4a05rQVdxQ1dHMkhaUmpBTjA5VXFPQ2NIQ2dRRGJY?=
 =?utf-8?B?WjRvZHFDRVlVcGd0QmVYeWlrdXFvVk5mUnUzS1RUL09ka2ZqZ0VkQWJiOHVi?=
 =?utf-8?B?OUlmY0FTaGlRSzhtWjV3b21lelp3b2FpWk9RWFUyTzRQODUweERTYjFlTDhq?=
 =?utf-8?B?WFNya3dJa05vYWE3RXcxeFNvRzNqdi9rdG84enBhWFZkR3M2dG81eDhINUpN?=
 =?utf-8?B?QnJRcGhMa0lGMUVXTmhQM1RiMjRadTB1UXUwNVhoN1Y4Z0c3UWNpeGNPMjVI?=
 =?utf-8?B?dm1HZnlER21vZTdqZlNwVHBsTTdXUmRPTWR4VDJZTmNFTjFZTzJsSDAwb3FI?=
 =?utf-8?B?QWpLZW8zYVdQVm04aGFwT1JVWm15YkNpNGNuMU82OEsxNE1BL1loUDUrbmpp?=
 =?utf-8?B?aVRoUTFldzJJTjFDM083RVBocE85RS9rTytNZkt4WkpjN3A3dmNUeE1pWEpm?=
 =?utf-8?B?WkthYkRPUG9DYnYvdVBZbm1NYmh3eTNWZys4aDFDQlYwZmx3MmRlejJWcG5B?=
 =?utf-8?B?OVV0UmE5SnQzcm5PbEZ1WlN2N2R4QUZYdjVkZGZQQjMwNnY0VGhhUWtQaVpP?=
 =?utf-8?B?bXlZMW1oQURTMEl4NDJVNE5qZUlQQlgzUUFseUE5c1E5WnFITW00RGlrS3dL?=
 =?utf-8?B?UWduQmVpa0hYUmI1T1htYUIyL1FRcFU3MlZLVlpvbjNPZTVza3A2VnpjWDd5?=
 =?utf-8?B?VWh2RWFycmtLMUhMV1JQOXpJSERTRmFlaXZibGF1bGxISGNkdVFEY3RaWHh6?=
 =?utf-8?B?VFdQdnlwb0VKdXdCUEgyelJmSlhVVkc0cXZCTnllQUlRUk1STjdSZk00cFpX?=
 =?utf-8?B?Qmdia2JmNDFqRTZYVXFPZkw4MWJza3prelNDb3VaRmVablR3Lys5dUdYaVRD?=
 =?utf-8?Q?n5f7b4wq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a6c6b5-3aba-4d23-cbb6-08db57f352a1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 22:57:57.9395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9rejW3kOUHJrDw6Okfzf1IIwJQqUs4zmOpuMDyjzxDYYrKjTgHfpFOGjGh/1vBSytQqk7mSPHptrzQYTAIImLnIhCkxqFm96ZSywLTuOr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180189
X-Proofpoint-ORIG-GUID: cAijM1hjTga3GkB6ZgWTyDM91PfaZiyR
X-Proofpoint-GUID: cAijM1hjTga3GkB6ZgWTyDM91PfaZiyR
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/23 1:28 PM, Eric W. Biederman wrote:
> Still the big issue seems to be the way get_signal is connected into
> these threads so that it keeps getting called.  Calling get_signal after
> a fatal signal has been returned happens nowhere else and even if we fix
> it today it is likely to lead to bugs in the future because whoever is
> testing and updating the code is unlikely they have a vhost test case
> the care about.
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8f6330f0e9ca..4d54718cad36 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -181,7 +181,9 @@ void recalc_sigpending_and_wake(struct task_struct *t)
>  
>  void recalc_sigpending(void)
>  {
> -       if (!recalc_sigpending_tsk(current) && !freezing(current))
> +       if ((!recalc_sigpending_tsk(current) && !freezing(current)) ||
> +           ((current->signal->flags & SIGNAL_GROUP_EXIT) &&
> +                   !__fatal_signal_pending(current)))
>                 clear_thread_flag(TIF_SIGPENDING);
>  
>  }
> @@ -1043,6 +1045,13 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
>                  * This signal will be fatal to the whole group.
>                  */
>                 if (!sig_kernel_coredump(sig)) {
> +                       /*
> +                        * The signal is being short circuit delivered
> +                        * don't it pending.
> +                        */
> +                       if (type != PIDTYPE_PID) {
> +                               sigdelset(&t->signal->shared_pending,  sig);
> +
>                         /*
>                          * Start a group exit and wake everybody up.
>                          * This way we don't have other threads
> 

If I change up your patch so the last part is moved down a bit to when we set t
like this:

diff --git a/kernel/signal.c b/kernel/signal.c
index 0ac48c96ab04..c976a80650db 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -181,9 +181,10 @@ void recalc_sigpending_and_wake(struct task_struct *t)
 
 void recalc_sigpending(void)
 {
-	if (!recalc_sigpending_tsk(current) && !freezing(current))
+	if ((!recalc_sigpending_tsk(current) && !freezing(current)) ||
+	    ((current->signal->flags & SIGNAL_GROUP_EXIT) &&
+	     !__fatal_signal_pending(current)))
 		clear_thread_flag(TIF_SIGPENDING);
-
 }
 EXPORT_SYMBOL(recalc_sigpending);
 
@@ -1053,6 +1054,17 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 			signal->group_exit_code = sig;
 			signal->group_stop_count = 0;
 			t = p;
+			/*
+			 * The signal is being short circuit delivered
+			 * don't it pending.
+			 */
+			if (type != PIDTYPE_PID) {
+				struct sigpending *pending;
+
+				pending = &t->signal->shared_pending;
+				sigdelset(&pending->signal, sig);
+			}
+
 			do {
 				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
 				sigaddset(&t->pending.signal, SIGKILL);


Then get_signal() works like how Oleg mentioned it should earlier.

For vhost I just need the code below which is just Linus's patch plus a call
to get_signal() in vhost_worker() and the PF_IO_WORKER->PF_USER_WORKER change.

Note that when we get SIGKILL, the vhost file_operations->release function is called via

            do_exit -> exit_files -> put_files_struct -> close_files

and so the vhost release function starts to flush IO and stop the worker/vhost
task. In vhost_worker() then we just handle those last completions for already
running IO. When  the vhost release function detects they are done it does
vhost_task_stop() and vhost_worker() returns and then vhost_task_fn() does do_exit().
So we don't return immediately when get_signal() returns non-zero.

So it works, but it sounds like you don't like vhost relying on the behavior,
and it's non standard to use get_signal() like we are. So I'm not sure how we
want to proceed.

Maybe the safest is to revert:

commit 6e890c5d5021ca7e69bbe203fde42447874d9a82
Author: Mike Christie <michael.christie@oracle.com>
Date:   Fri Mar 10 16:03:32 2023 -0600

    vhost: use vhost_tasks for worker threads

and retry this for the next kernel when we can do proper testing and more
code review?


diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a92af08e7864..1ba9e068b2ab 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -349,8 +349,16 @@ static int vhost_worker(void *data)
 		}
 
 		node = llist_del_all(&worker->work_list);
-		if (!node)
+		if (!node) {
 			schedule();
+			/*
+			 * When we get a SIGKILL our release function will
+			 * be called. That will stop new IOs from being queued
+			 * and check for outstanding cmd responses. It will then
+			 * call vhost_task_stop to exit us.
+			 */
+			vhost_task_get_signal();
+		}
 
 		node = llist_reverse_order(node);
 		/* make sure flag is seen after deletion */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 537cbf9a2ade..249a5ece9def 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -29,7 +29,7 @@ struct kernel_clone_args {
 	u32 io_thread:1;
 	u32 user_worker:1;
 	u32 no_files:1;
-	u32 ignore_signals:1;
+	u32 block_signals:1;
 	unsigned long stack;
 	unsigned long stack_size;
 	unsigned long tls;
diff --git a/include/linux/sched/vhost_task.h b/include/linux/sched/vhost_task.h
index 6123c10b99cf..79bf0ed4ded0 100644
--- a/include/linux/sched/vhost_task.h
+++ b/include/linux/sched/vhost_task.h
@@ -19,5 +19,6 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
 void vhost_task_start(struct vhost_task *vtsk);
 void vhost_task_stop(struct vhost_task *vtsk);
 bool vhost_task_should_stop(struct vhost_task *vtsk);
+void vhost_task_get_signal(void);
 
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..9e04ab5c3946 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2338,14 +2338,10 @@ __latent_entropy struct task_struct *copy_process(
 		p->flags |= PF_KTHREAD;
 	if (args->user_worker)
 		p->flags |= PF_USER_WORKER;
-	if (args->io_thread) {
-		/*
-		 * Mark us an IO worker, and block any signal that isn't
-		 * fatal or STOP
-		 */
+	if (args->io_thread)
 		p->flags |= PF_IO_WORKER;
+	if (args->block_signals)
 		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
-	}
 
 	if (args->name)
 		strscpy_pad(p->comm, args->name, sizeof(p->comm));
@@ -2517,9 +2513,6 @@ __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
-	if (args->ignore_signals)
-		ignore_signals(p);
-
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
@@ -2861,6 +2854,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.fn_arg		= arg,
 		.io_thread	= 1,
 		.user_worker	= 1,
+		.block_signals	= 1,
 	};
 
 	return copy_process(NULL, 0, node, &args);
diff --git a/kernel/signal.c b/kernel/signal.c
index 8f6330f0e9ca..0ac48c96ab04 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2861,11 +2861,11 @@ bool get_signal(struct ksignal *ksig)
 		}
 
 		/*
-		 * PF_IO_WORKER threads will catch and exit on fatal signals
+		 * PF_USER_WORKER threads will catch and exit on fatal signals
 		 * themselves. They have cleanup that must be performed, so
 		 * we cannot call do_exit() on their behalf.
 		 */
-		if (current->flags & PF_IO_WORKER)
+		if (current->flags & PF_USER_WORKER)
 			goto out;
 
 		/*
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index b7cbd66f889e..82467f450f0d 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -31,22 +31,13 @@ static int vhost_task_fn(void *data)
  */
 void vhost_task_stop(struct vhost_task *vtsk)
 {
-	pid_t pid = vtsk->task->pid;
-
 	set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
 	wake_up_process(vtsk->task);
 	/*
 	 * Make sure vhost_task_fn is no longer accessing the vhost_task before
-	 * freeing it below. If userspace crashed or exited without closing,
-	 * then the vhost_task->task could already be marked dead so
-	 * kernel_wait will return early.
+	 * freeing it below.
 	 */
 	wait_for_completion(&vtsk->exited);
-	/*
-	 * If we are just closing/removing a device and the parent process is
-	 * not exiting then reap the task.
-	 */
-	kernel_wait4(pid, NULL, __WCLONE, NULL);
 	kfree(vtsk);
 }
 EXPORT_SYMBOL_GPL(vhost_task_stop);
@@ -61,6 +52,25 @@ bool vhost_task_should_stop(struct vhost_task *vtsk)
 }
 EXPORT_SYMBOL_GPL(vhost_task_should_stop);
 
+/**
+ * vhost_task_get_signal - Check if there are pending signals
+ *
+ * This checks if there are signals and will handle freezes requests. For
+ * SIGKILL, out file_operations->release is already being called when we
+ * see the signal, so we let release call vhost_task_stop to tell the
+ * vhost_task to exit when it's done using the task.
+ */
+void vhost_task_get_signal(void)
+{
+	struct ksignal ksig;
+
+	if (!signal_pending(current))
+		return;
+
+	get_signal(&ksig);
+}
+EXPORT_SYMBOL_GPL(vhost_task_get_signal);
+
 /**
  * vhost_task_create - create a copy of a process to be used by the kernel
  * @fn: thread stack
@@ -75,13 +85,14 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
 				     const char *name)
 {
 	struct kernel_clone_args args = {
-		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM,
+		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM |
+				  CLONE_THREAD | CLONE_SIGHAND,
 		.exit_signal	= 0,
 		.fn		= vhost_task_fn,
 		.name		= name,
 		.user_worker	= 1,
 		.no_files	= 1,
-		.ignore_signals	= 1,
+		.block_signals	= 1,
 	};
 	struct vhost_task *vtsk;
 	struct task_struct *tsk;

