Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8867128E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243524AbjEZOqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbjEZOqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:46:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8762E10CB;
        Fri, 26 May 2023 07:45:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QEZ0WC014784;
        Fri, 26 May 2023 14:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rFKKd8GKAjS7g0ULY0ZtA4BZNasssrib1nOm/owsh4E=;
 b=qPAwb2ezcs4m8aMTHWWxCPHxTPuv6dAOGaZnc41RhW6dtWt88p34CTJdy09r3AwQl2y9
 OMRoP9I5a+BofvgSj8Lx5VxmKU5Jdy0pDtQkaGvqkCBwYrRdX86eK0W3m4y3LlzN1kXi
 cTPY6qDmP4sRR6gMsfqDfdFCrW7UyUWq9G2oEj/nXGcuBnDRSLUS0MdKdZ8okndjFffW
 jy0K+3HMbJGpmdZZb2Xgm21Apcjj0ML6VABAip/qscxZhFCs8JbDO5K22Zapz/TUNeVh
 RFyhzH8WMrzI5w/kLoOcamjjHQoWox/SpRgNkssDnqTz1OFhIol1hZxOjTGP70pEmtSd Hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qtxn800ps-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 May 2023 14:44:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34QDQwI3024388;
        Fri, 26 May 2023 14:40:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8yk7cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 May 2023 14:40:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLTZsFI+L7582hPjjr4IEGNua8SuVZ/nakzN1HeiSbWDjdtuNeFdwkmhrWCYNE59yfyD9HugewgXYKRrxQGyB5FRkybeq7Et6t0M1yTtRI/X/Lhvumtzg9Kc6LMbETGCZVjvUxV2nMJ/9A99BufMmjpfj3+5gbqTTkLuOTkLFStEuB9grpFSSAt53LFUnrDUbVSyXsH2gnUKl4NVVrixxofm5iGqM4hbvXmfEDsXpEU2fqJuS5G+HSWVSYx2P6g5YBtHRMEr8mtBfO0XJ6440e9PW8FzSt5eBUrY6GJVPWRt2XpzZL+NVTOdC0u8Aa6YS/rUrLWC+ewz0J1/YOQvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFKKd8GKAjS7g0ULY0ZtA4BZNasssrib1nOm/owsh4E=;
 b=OBs35UhY5Xu4oq9XgX64PgnVxCs0IqhjsPq1Zhi3vBUmuwevINafmJbjv5EVEGK/eGQj5WNkLX8G/gp8rPNTHy8FJf0eX34xCQkYWfrKSbIYfC/yqDjZD/GRGYjnOl20GS0IRsQqKUumF1+L1m8EFyPk3IQNi6pUvHEhBhMKI/91BNbxCWQdO8Yhy46SZ6DlvjwZNlp7mPKNWJ4e80RzqIjhyv6DCPJdzsrPphqhsWYTX9c6eBvY6+UP9lNhRrEQGHgTyt612Y/xVpnMvihtdqVQx2mIVjZWF0ftO3pa55uVmpYCaKbLrRxV8zF1T0F8x9RMrag3QUM2wt/NLhaqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFKKd8GKAjS7g0ULY0ZtA4BZNasssrib1nOm/owsh4E=;
 b=ng1LALRv6OQ5ZHX8/s/xcBKaQ4TfExk79m/RXXcANCsstwMMU73mmY3AmwJLaL6VT3h06SufO1EL3i30ssfaocxFS244iWMhR7T7mdmYMP1Yk1XcsWmoKVjyMp2qcmgAMC/ymfDoQHR1xP2bW1WK356XkCMWNTvaHnNUwzvaf54=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM4PR10MB6254.namprd10.prod.outlook.com (2603:10b6:8:8f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.29; Fri, 26 May 2023 14:40:18 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace%6]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 14:40:18 +0000
Message-ID: <872b0c40-651e-6989-cd4c-8ca7f655dc79@oracle.com>
Date:   Fri, 26 May 2023 15:39:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] kallsyms: remove unused arch_get_kallsym() helper
To:     Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Song Liu <song@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, linux-modules@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230517131820.936553-1-arnd@kernel.org>
 <ZG2bfsr+LwrxqsUX@bombadil.infradead.org>
 <a3d01d39-3d45-4fdc-8f73-b6c33bcae24b@app.fastmail.com>
 <ZG27pExhUqFpGexM@bombadil.infradead.org>
 <CAPhsuW4ZksuhhXqDNrb4fPqQFVgW+cfpNLGHOWoLoYWjCKZGpA@mail.gmail.com>
 <ZHAmYSclm+5QlLcM@bombadil.infradead.org>
 <2591bdc4-a198-446c-8bfe-37ea39c51964@app.fastmail.com>
Content-Language: en-GB
From:   Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <2591bdc4-a198-446c-8bfe-37ea39c51964@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0507.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM4PR10MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: e3863cf7-fbf8-4fb3-515d-08db5df7200f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HyhPJGuczq35VzinyfEf7jjSBjKhX6H69owLC3jBS/gW+l67fnjoenbxD23WIih5cea553p0SsCfrbrcK0NtBCLJc9PC2F6vUTYDrM6jiwy6lALcm3xCvqx+bfOZu+KXQNnscnUa+9Kbc4DiTbfI1I5xC+LSYM6gtXvOPEnK6VGdJYReHh9FA3AnCIHBHM+9XB7hlUnhDeshbOdtDfj7XA99vCCWZ0utW4pvKUeEXU5yshW9NShqLdMWNz4bmzfDboFgMUmtalaQgw7HHjdN4PaTWRb2WINSFnCWg6LVMu4d5WCr4GGl5BMuz7A7LidTXsOFB2EvJKwqFhhHY0DgKN5PHzcNPHERJJnWFyt7h2os0gb3vja+u+2qfbr9SdXx+3KR5cn3aYpQQZxwpPmpWh0owCAqqZjgGpfJUotX/hoqvcoDaum9tP0cY0p8lwKgkwQlFSpdW5s2k9QOm7djyniCD3Oj4Pdrs7eS7rSmVH+yZpC3ZyVcrITFYDzXmuZlDhqKkHwnHu3foPagE8KvO0rTnUBX8xGZiB/Vom8sY0ik6BLSKrrbrx+5D3qYJ4Q5/m7zNj3Mm2KBvUSw9Rz3C89T3hwM+Za0Bne3X8mImkfVxMUg0NTcl68GwCzMMDpaMEM19nx6kXTvhewpxygnBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(86362001)(110136005)(54906003)(83380400001)(2616005)(478600001)(31696002)(186003)(66946007)(66556008)(66476007)(4326008)(31686004)(2906002)(38100700002)(316002)(6512007)(6506007)(6666004)(53546011)(6486002)(44832011)(41300700001)(7416002)(5660300002)(8936002)(36756003)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1p0K1MyWDFHS2NQaDZpUEErV0lGZHk3VUxhWjhSMFhLUTdVc3BLQXRNN1Fv?=
 =?utf-8?B?bEprZTMzREd1Sk5nQWlaRGNFc3haaDkxSmhtZC9UN2tmdklEZ2svOXA5bjN2?=
 =?utf-8?B?UHhiaWVpVXU1bkI1T3BmTzVDZUtxdFZyNHhPbnkyOUJ2Wm9wb1luaDhEWkZL?=
 =?utf-8?B?SGQvMitMUTdkNVZwUTFDNHIyVnovZFdqajhUSEV5MWhueUZ1b01nMnAxUWVr?=
 =?utf-8?B?clUvWG83RndpaGVKZlU2MExFR3ZjS1laYTR2SHJKNVdEZkRWNkZlV1NWTWI1?=
 =?utf-8?B?WkdUcklrVjQyVVZoZlpVQnBJTytQOC9kZ3ZmeEl6Q2FQb2wwQ09GeDI0dGow?=
 =?utf-8?B?Vys3K3lBcUJrczhvTHN5L3RiVzgvMW8yWVdMREtzRWJWbWpZb2dIZ25SamVa?=
 =?utf-8?B?eWdSaFVveFdYdU9VYWRLMEkvUVYvOHROdmNCZi9wdzB5a1JTdHUyREpMdkpy?=
 =?utf-8?B?MnB5dnBMTDRSaWZkd0VxT00xZm5iL3AvME5NcDFDREhUY0NMV1JNQUQrc2hO?=
 =?utf-8?B?NVozNklDcmk3VWhUWU9CUkxKNVBSb3QreHg1cTFqT2JrSXpFOEp5em5sSFRY?=
 =?utf-8?B?ZThGNHpTdXBXNldLVmpBb2ZJdm9MUDB4eGl3K3p5MmV4a2lISWRBbm5oUFZl?=
 =?utf-8?B?Y3ZtaDVxYUxJdW9KZFd4eitOcmV5SVhsRDN3dDZUeGJaRUdKSVZiQ2F6aU9K?=
 =?utf-8?B?aDBhWWphQVY3ZFBNN2xpaDl4NjFpeEVweExZcFE5c0UyTllBOXNocW9uZVdv?=
 =?utf-8?B?d2FHVE1RZllJdUMrekhJYXVhSkIxVnZ6YWhKZXB1ZDhLS2h4ek1Nc0FGNFlG?=
 =?utf-8?B?aFUwV1RkWHJhc2ZSekc3Umw0bU5EVFU2U3ZnWWtIK0JSNFZIV0VzWlVpVCts?=
 =?utf-8?B?eWRsakdxNSt5dGk5NEtzTlBmbWsxM2szL3htQ0JOc2QwT0c3eTNyWUZEeWQ5?=
 =?utf-8?B?WDZOc2x4OWlkNy9oK1Y3dWpVdGNKcUFaQVFYVHE3bitEL0pXTlRoMWhCbEpE?=
 =?utf-8?B?L3VUUkNoQkF5RVk2L3p3am9yQzhIbEZXVXh6b3FLY0dteHNibVlkOWpjSEhG?=
 =?utf-8?B?MVBtQkVMc2daVnpYZUFrMG9CeXZDV211Q3NXNm9TNGRadld2b0VGYi9PM0R4?=
 =?utf-8?B?NHA0NVEvTUptYjA3UDUzcnhiSUZuUFprSlNhcWRYeERDdTFkTzB0MlI4L1Zw?=
 =?utf-8?B?WjFORWU1NU1UM0s5S0ZhVmg0RjNZcmJQZ2xHb0ZoMEw4Nnp6cXZEYTVmMkgw?=
 =?utf-8?B?N21TSkw0dDFXRW96bmo0NVkzUUpGRDNLamJDcHE0Zlh3TkVISGx6SGlxS3NW?=
 =?utf-8?B?cWlxY1pHdEdiREpER3BkM0NFL0Q1TDFWRFlNWVRtSHRoRURGS1VWWlZQbXZG?=
 =?utf-8?B?TXNKUDZPRVF5T1hGdDVrTit2clZMeTNqdjExMS9oVEt3RVVQVjFDTmFXRkNF?=
 =?utf-8?B?dTU1dnRDN3hsREtCTWhMK1lMSy9FVzk4YU94NzFOYnJGbFpHRmE3S20rR1M5?=
 =?utf-8?B?ZHNjYWxGUnBnOHFteXZ0bnduNVFtL0ZqSjlFSTlrOXV1S2ZvYjNUdEkzR0R2?=
 =?utf-8?B?VlplWXZYTkdCa0NKQWpIL0ZYVkVMclNLcGJaVmk0WkpvVm9jdURiRFRYWGdY?=
 =?utf-8?B?dmJLREhMNXIzeFg2QjB6R0I4S1lPa3RBQUx1dTBuYTVCaXdZejk4ZVR5dlFX?=
 =?utf-8?B?MzR4N2hoYVhaUFJmWDdIcXBWZUo3NFpEZ1lIWjliaXE0cGFjUmJzQ0FXWmp4?=
 =?utf-8?B?b1ZGUEI2Y285Z05yVnIyQXhWZSs1Z25Ob01GalhadDFqMXJ4aFl4bjlOSUww?=
 =?utf-8?B?RjRRanY3ZWpLWHAwZFRUU3FlZG81YkpPMUFpaTg2Zkoxd1JubnhUN25tL2hi?=
 =?utf-8?B?V25lcE5KYXV0UUdUTWFmbFg0WHIxNW1hbDlRNWRaS29QSjdXZUpPbEFlRkwy?=
 =?utf-8?B?bE03dTB5OSszVzdXSHhCQVJFWEJDNlFWc0t2eHNvVGdyanloTkdhbFFVRHox?=
 =?utf-8?B?cVdPMS85ZDBVVTljd2M3eWRjUFJtTW1zd1VWVmx1Q05WWC90RXhqU2hNakxY?=
 =?utf-8?B?cFRWRDlUMjE0TytJVlliM2h4Mno3aWkzd3hFYXhDd2NJK2xmWXVxU3lSWVMv?=
 =?utf-8?B?Umg2YmhqY3NEOXVxUG0wVWE5OVdLZVdUbllDWVE4RjJGOUZTUlAvZ2crRno3?=
 =?utf-8?Q?aKBsPUIcyf6ZFNg/PMq5Rmw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L2Y3ZlVabkVtenp0V1E2ODg2ZTBhS1lxbnlqbHBwY0FPTHcxazFsMzRKSUdo?=
 =?utf-8?B?Z0o2QUZvbmhYVTFaYjJ2Y1hjb1VBNlJRaHd4N0V1eHVvSzJ3VXUxd0NmU2RN?=
 =?utf-8?B?bzN6SlA1c0VZNTFVWEY2UEZHQktEaGI3TUEralBBQTBrRGlEdEFmd1ZSdFlB?=
 =?utf-8?B?WjFkRVRqcUg1Z08yRlNEby85Wjl6SWRrSEZXSmtXRFg2dTY1R0hpRlFvZzc0?=
 =?utf-8?B?cmtZSkJoYkt6eFRjeThFOFZ4TjdlV0lEakhuUkVaZFc1aTBZOFNBdW4vNFFJ?=
 =?utf-8?B?R3o2cUQxdzZKQUVWTzk4TnliMHhJV0FIajEvYlM1QmNES0oyaWRGRTVRdEg4?=
 =?utf-8?B?SE16NTViM2NQRmowZ1dVdlV6SWZDY3FYRlNvd0xNOE5Uekk2d2o3cmhabTVO?=
 =?utf-8?B?Q1RSc3dRTnlTTG93cDRWRlZqdnRWbHh0TzExblh1SzBiUWEvYS9idGl5OTE1?=
 =?utf-8?B?QngzNUlUOHY5cTRlcWdNNXZSN2Vaemt0RUNDVWx3dFA3NlVlVkFTK3lIeWR0?=
 =?utf-8?B?U09OeDBYQWRVSXBnNitZcFp1M3E5RjJZajkxMG5ZaWc3TWxRczFDUElJclFI?=
 =?utf-8?B?SUVBakF6Wnp4SEdDR3FkNEg3VXVFRzNjQ3lsdmk3ZEczTGJlbWp5L3JnT1RU?=
 =?utf-8?B?OUgybnJva1ZyNXVmNGxPL0F2bWFiNFFDcmVzcVJPL0NWeEtTV3hTdW9ZQVNS?=
 =?utf-8?B?clMxVkw4Rysxc3dTNTlwY0ovemFBcGdyaU1zeXR4QVpuUllFaFRVUmEwdzJk?=
 =?utf-8?B?NUlRTEphMDlyWXdXU0lkNldYVVRsN01KYXF2N0FXVGprUjdISVFTb3RGQkVX?=
 =?utf-8?B?eHpTbDBoYVpVcnV1Y3luQ2ExckFsNGRzbTdxMEhZRC8wQy91d2J3LzdvNURF?=
 =?utf-8?B?REpMbDFKR3FuL0NjOHJTOUtZWVhKTmlkSE9XU2NsTitVaFZEcUNSbkN4bEpY?=
 =?utf-8?B?dmhRbnJXUjRvdUF3dnBTRE1Fd2wxcmsrOExzRUlNVm92RGl5aWpnNHFqb2t5?=
 =?utf-8?B?NFBwa0dNdXhZaFZKOXpQUEoxbFViY3VSTVN2RnlRRnJsRnp5V0R4QlRpa2s0?=
 =?utf-8?B?bU1nVHV0aWxuejNFM0ZUNnFxNWh5WG1IdC9HTG1XRkRueVpWWDRqZVRQdFp0?=
 =?utf-8?B?M1Bnak1pczdsRXdUR0NEYlZNZG5lUmI4ZGlhaTczS1dDZHUyTXpPOGtSaWQy?=
 =?utf-8?B?cHgrdlg2NW9hUm5CS3B3YnhDV0NzYm9IWkoxRGR2QVVtblJ0aXN1dXVuZ2Ex?=
 =?utf-8?B?VVVqczBFeTBmN2VRd0hRQWJBWE5wcnl3Z0NIOWlEZDV0cGZwWkR5a280TVU3?=
 =?utf-8?Q?U9hL/dRGrv62ErUZ5FNxZ5QXd3olB5MUDT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3863cf7-fbf8-4fb3-515d-08db5df7200f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:40:18.1449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ll68MvpoYVaPVGnraVe3hDozu4LnntLhIkCF+f9aiwIoCpcYTee0MGO2pBIgal+qXMpJ/Xv5tKEUao8/zsr2WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_05,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305260123
X-Proofpoint-ORIG-GUID: Mb9dEIPWeB1EptX5FLXucruXpxhuWppi
X-Proofpoint-GUID: Mb9dEIPWeB1EptX5FLXucruXpxhuWppi
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2023 07:41, Arnd Bergmann wrote:
> On Fri, May 26, 2023, at 05:24, Luis Chamberlain wrote:
>> On Thu, May 25, 2023 at 06:45:35PM -0700, Song Liu wrote:
>>> On Wed, May 24, 2023 at 12:24 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>>
>>> This change broke compilation of BPF selftests in modules-next
>>> branch:
>>>
>>> progs/bpf_iter_ksym.c:62:13: error: no member named 'pos_arch_end' in
>>> 'struct kallsym_iter'
>>>         if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
>>>              ~~~~  ^
>>> progs/bpf_iter_ksym.c:62:35: error: no member named 'pos_arch_end' in
>>> 'struct kallsym_iter'
>>>         if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
>>>                                    ~~~~  ^
>>>
>>> I haven't looked into the proper fix for it yet.
>>
>> A quick attempt:
>>
>> Arnd, can you verify?
>>
>> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c 
>> b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
>> index 5ddcc46fd886..521267818f4d 100644
>> --- a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
>> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
>> @@ -59,9 +59,7 @@ int dump_ksym(struct bpf_iter__ksym *ctx)
>>  	} else {
>>  		BPF_SEQ_PRINTF(seq, "0x%llx %c %s ", value, type, iter->name);
>>  	}
>> -	if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
>> -		BPF_SEQ_PRINTF(seq, "CORE ");
>> -	else if (!iter->pos_mod_end || iter->pos_mod_end > iter->pos)
>> +	if (!iter->pos_mod_end || iter->pos_mod_end > iter->pos)
>>  		BPF_SEQ_PRINTF(seq, "MOD ");
>>  	else if (!iter->pos_ftrace_mod_end || iter->pos_ftrace_mod_end > 
>> iter->pos)
>>  		BPF_SEQ_PRINTF(seq, "FTRACE_MOD ");
> 
> This looks correct to me, but I'm still failing to cross-build
> the selftests on my randconfig build setup, so I can't confirm that
> this avoids the build failure, and I don't understand the code well
> enough to be sure.
>

Thanks for the fix! The change above works ; maybe having
anything less than iter->pos_mod_end marked as a "CORE/MOD " symbol
might be worth tweaking, but that's a minor thing.

before:

  CLNG-BPF [test_maps] bpf_iter_ksym.bpf.o
progs/bpf_iter_ksym.c:62:13: error: no member named 'pos_arch_end' in
'struct kallsym_iter'
        if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
             ~~~~  ^
progs/bpf_iter_ksym.c:62:35: error: no member named 'pos_arch_end' in
'struct kallsym_iter'
        if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
                                   ~~~~  ^
2 errors generated.

after the above is applied, bpf selftests build and iter ksym test
passes:

$ sudo ./test_progs -t bpf_iter
...
#12/37   bpf_iter/ksym:OK
...
Summary: 3/39 PASSED, 0 SKIPPED, 0 FAILED

Feel free to add a

Tested-by: Alan Maguire <alan.maguire@oracle.com>

...if needed.

Thanks!

Alan
