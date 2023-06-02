Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D7C72037D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjFBNiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjFBNh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:37:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DF1137;
        Fri,  2 Jun 2023 06:37:58 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352D43tU008555;
        Fri, 2 Jun 2023 13:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3/un6fpqQXmSEvJ/T20wtdW5crwpDfIvmdAf2gDLzg4=;
 b=R9m3NtYsG+VEXut32Xa+N8AEIKtG1LPXIrz/E8c7cmveK75eLnkNEb8Y2hsxg9aY8jJp
 nUSBEjoq+MpHmrvz1NdAKF9IXrXDahHUc6zSysKEwN1M+Y3e+pfnQWH8UrcKLiT3+gnK
 6ZIixcP1wk1Vlio45Bd6sYxDKTTf1d8yDkmomRlAnDyEYuIdBrE8dv/z0/HrcVgBWLdi
 cJDFDk/ZKF6yKxMn3XWXc4Yq9aCEhRku6jAq+nKxWxITVe7jEtxHoUTZkoIbSqgW957q
 8xwDF9pKrU0naEaWFpTYw6Fuw1OjVbAL4P5OXjyC1ZfyWew6TLGgScIs5uZdCSnAboeK CQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjhb051-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 13:37:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 352CMH2l017268;
        Fri, 2 Jun 2023 13:37:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4yg890d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 13:37:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVnXL3PGVN8jc7i1bp26ye8qPFNxveLSuU/wJYcjO/B2lNrWooG7nAXTX6T7vVBI/l7ZXI6usEACmraxP4qilHFkFgJ0vuO4fPVZ/VnP99KGJly5+E3k0vKcN5L9E6XfqM2r/yrDpb2rGkeP+J6N9GXZI8V1S1fkMmIcjPpU0husVd/ttUqs/Kqueao2ZrSWOuwWD878UhWCQC0IJNCw4RVATsPiowPTo3PE5/Inm+sFqfgPWXjgtkTGE7KKPDprQdjCRJPHt7GvvdTMaxIS25XfUUQD05tXc9XbXSIKtb3T/HrDKjK/tUfB/GMrat0lUaUiifnteiwoEA5Ni3YptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/un6fpqQXmSEvJ/T20wtdW5crwpDfIvmdAf2gDLzg4=;
 b=WUHP/KELGCW7Q0zcmvXoRKoHQjTWzJiIo3K60A8tSGlVPjMBe58SntmyXsjjlgIb0Ghp9GZZB10PPg+4JD4i/76N/99/KI5DTwPS7znK4ZjdYCPfkDN86kAGNE9cx+qtAqSsWSHoFr1L9XmxeMazKPkeLxUs73W2sWGYIgzoil005EUQJ7nDWnWosldxG10AuBSvzS8ewm5B43AkU7w10hRIS8zmPfJtIrzBnuxm4BJGmGUJejaFWOxDQYdQWqkBmjdkKTuNx/TXck9uAogqCOeZlL+jJ45BDgbWmWs9Nsbz8aCHThlBZ95vbJMdhwcxYybboOJaI7mbA77hdv6fGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/un6fpqQXmSEvJ/T20wtdW5crwpDfIvmdAf2gDLzg4=;
 b=WfstVYOtPKnqe9uxjMVrepzhyHa7GykaYGS9KfFrC530ZA6RrFi53Is76TrRsQoM61mr//3RqMAnaPE6AxNCUkkMtArAYr0LAJaZOPWomWQ+qSVbAJa0p59W0PAN8AmC3LWzdov4vhXSf/oo0Nv1jnk9jSMauiYE9cwqzF/2Ykc=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SA2PR10MB4778.namprd10.prod.outlook.com (2603:10b6:806:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 13:37:20 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::cd78:868d:bb:1c47]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::cd78:868d:bb:1c47%4]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 13:37:20 +0000
Message-ID: <808fe90f-9171-54e6-2170-224d4048e333@oracle.com>
Date:   Fri, 2 Jun 2023 08:37:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] jfs: Use unsigned variable for length calculations
To:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Dave Chinner <dchinner@redhat.com>,
        jfs-discussion@lists.sourceforge.net,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>
References: <20230204183355.never.877-kees@kernel.org>
 <20230602-unnahbar-halbmarathon-22e48883e051@brauner>
Content-Language: en-US
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20230602-unnahbar-halbmarathon-22e48883e051@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:610:11a::23) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|SA2PR10MB4778:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c6e7cd-a561-4ea8-8caf-08db636e7d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: js2veQM+WgkquxpKCkEerEljvK+krbyX9VHsjq3H7rqUfXIyQxY8eY1ZsMcp83yJ9gNehQ9yx8eezGf1Em4TRjqKcDvPku72YwKj/gZTtgsNWZuc89Rg7itgoO69hXhVlPKlymiKf24C/nQ6b5nkQSj1eqZ8cEJbhgJszf664smTHag0bxSGNNW1lwKOP01dZIwnZMx9n6ZliFbzaV+HAVD2Kjo9SC/zOBEV1FKDU8BHpef/pX4x+O1xMcmNdondJiAd8Kv7fUP8QAfCqpd07LQ/BINyDrLloNOAMhBNRCZUU0Lq2yCKHos8EyliUiN3/KR90xjN2lAiti7F+REv+mwSu/Lp3dYepaT4ZA3X/dFp0SFAM+QpB0PXceP1FMKzRSwImIH+sTa28ESprlG22nKbzy0DDvN3Xw/97q55+2+5DLbcdP0dAkYp7u5Vi+brb2DDilN7UJmCT4yWzT2zE/eecNqg0PRXtydwCLR1LlJQpaSAzhql81YMkkU9yr/LfzMNr9WQeL23EByfLBd6zW4CqSGG6zLUacui+q1dbpka2lj0GSlf7TZICqHxtK8XOepW7n2K7R/044SXdpAhz2JcGjhsK4GJENkdiA045hqoxMILiAkxzB49ahceQOJs+NEMH7A9alHsnF1bBIRXJdVxnQff3x2Z7JjMBYNe8hA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199021)(54906003)(5660300002)(8936002)(8676002)(2906002)(66556008)(110136005)(66476007)(4326008)(66946007)(41300700001)(31686004)(316002)(44832011)(478600001)(6486002)(6666004)(6506007)(6512007)(26005)(186003)(966005)(36756003)(83380400001)(86362001)(2616005)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3M5S05zZjRhT1N5WFVSTGpDeFZ5dHdGMnhmSmF4ZGlUOUI4NU1ZUkx0eFB1?=
 =?utf-8?B?SHBGK0xPaUdRaGtPRzRFa0FvbmwvZkwyL2gzNVBBUXNMd1NJbUp6ak1teGFq?=
 =?utf-8?B?dS80OTFEaWErbmFzZU5Sc1kwQXpQR2lMeWhHS2tHdTQ3YWkwR1Qya1pleGkx?=
 =?utf-8?B?YWpMQnBsUXNvSjBQeXFLb3hMNEpiM0xYS2RZZXdLMEYxWW9oRnRRM1NpcDJL?=
 =?utf-8?B?TkJuNHZBa2xFMW9PREdXNFBzYndZWjAxd1UyQTR0ZUplTjFRNWx4SS8weUxZ?=
 =?utf-8?B?QmJScEZtRyt5UjZYYzFya2lMUWQwSjVrZTdENXFNWThSVWlxMWpkOU9CTktH?=
 =?utf-8?B?UExNeW9JT0t5cjFKMjI1R3I3TTE4OEhqVG9tdzRGWjl4eGZINGowVFBBVEV1?=
 =?utf-8?B?a3pkWE5LTkk0bWJPSCtnOW9tZUlZTkExMElzd3gzbkZ1MHhMN3c3V24xYUpF?=
 =?utf-8?B?M1N4MGZUWERDMk8yMDk1RUJxMVE3WkxlUGRtNTA0YjN2RlJXa0IxVGlSd1Vi?=
 =?utf-8?B?Nm85R0Z1K2p3NFFZNHlQcjMyYlg5OGpEVDhEcldzMHNoblpUWnpHTTNSMHBl?=
 =?utf-8?B?WnIvMkJyZ1Y3c21RN0c0K2pZRGppa0w3b005c3pQQUlWN2l6eHBOaDMwMWNr?=
 =?utf-8?B?WStQSEpjMUsyOFNPVm4xNzd0MWFHQzd2RGtpRFI0dUE4TGFUVmkwbVh1UW9W?=
 =?utf-8?B?YXNrVU5ZcndvTWxJOEJLdVRaK0VHSHVYZGpBV3NTdGNSRU5vZDFrK1E2eGhY?=
 =?utf-8?B?bE1heG9rbVZyK2lIVUVzYjFEYlh5OFNYVTkvQ29ZMUwzczFJdTdLVEZLdE84?=
 =?utf-8?B?aEVMYXNGR05ibE51NEoraC9FUDBZcC9nanpxbVdlZ3NyUGFGUVpVQzlRL1dw?=
 =?utf-8?B?NGozeUJZdWNkdEJJdjlsd0ZqRzgxQy81WDVZcndocEcrVldVZ2Z1VmFtUmRt?=
 =?utf-8?B?ZnFiMHRTb1dqMENHTExzVVRLZURSeFRTdEVEWlh4SFlaZXNHTHBmWk1wS3Vl?=
 =?utf-8?B?NU9KSnBkQ3pJd21JMGdHeUlSREtpME4yK1FJRFhsNVYwamNPcXVXWGhBUXlG?=
 =?utf-8?B?STE0ZytQekJVTzVwclBMQ1ducVJMUW55Qys5K0JxSVE1QlYxS3RxZldhZlZE?=
 =?utf-8?B?ZFZrUFB5VzJlZUxjaDU4eEFQd3lpY01TSVhhRTh6UlRYVW9sd0NSU04wemhT?=
 =?utf-8?B?MzJka0N2NHhJQU5oaGh3dW9XRDRKV0xlaGEzZktOVTZvZ0ZIV2djbWt6YWhL?=
 =?utf-8?B?czdNRlRZWC9OR1Q2cTluUXJIVVBxRFM4MFhVeVF0Wnc1ZTdxVThRVnJCMkN6?=
 =?utf-8?B?RmNnYWVYWFJOS1llT244ejZVbGoxV0xDQ3hPRlA5MVdaRXdweDR2bVFoQlhu?=
 =?utf-8?B?akdFNFV2cWhQdWhSRTAyazhqSkhvdHY1T2xuTWRIdGdUZzFoTVpnZ0QzemYr?=
 =?utf-8?B?Ny9BVDNFbXQ2NmRvU21iclkxeDhwY2xiVHlOMmppbEY1Ykw1SnQ2RFpWZzVG?=
 =?utf-8?B?VkcvNllndExHTU1sUjVzZGJpd2dZWjQ2akF0NHBCV2I3SVhGOTBlR3l4cmIy?=
 =?utf-8?B?TWpKK1o3UlhPZllyWWpDOExFZ0M4dFUzNzVUbE01ZDRQZ1BaMVowM1gwVHM2?=
 =?utf-8?B?TUlFZDBGNE5xd0kxcS9LNlhTVEg4WmVYY1BHTXo1MEcrUFFjd05rVkVhK3hP?=
 =?utf-8?B?akxTaDRJQ3R3V2FPWkozVlRsOTVhOEFTdWo4cUQ5dG9sRi8yNmhSQ3VqdGht?=
 =?utf-8?B?dGhZZlJSUjRVcEtvRVdEdTBBTFlJNU9COGYvTEhmWlhuTkdlYjZxTmhaaTNO?=
 =?utf-8?B?eUF1ZWZtZ09xN3N0WG5kdmxjb1F5RllEUmdONU12ZnY0S1VWNmoyZExZVWly?=
 =?utf-8?B?T3Q2eVJTT25tMWxKM1VzZ09vMjE2VlZJOVlaM1dGVjdRMXdmUFlBeGtvQmpL?=
 =?utf-8?B?aUYreDVEQW1sMHpEcGo0TlFlTVgzUmdDOFhUdlRPcHhJR1BRNFc0UUNYWnd0?=
 =?utf-8?B?M21PeDVKanNRSXRNTHVFWElmN1NMbnkwK05SU2VXaTJGdmVIY3A5WmtKc05O?=
 =?utf-8?B?VjIyclhlOENZMzhtQXJDUkZzSWE4eUdZZVprTi9SZDZhVlhOYkdkalRqaWsz?=
 =?utf-8?B?bFFZcjdaR1JvMEtQbVlxNnVtQnQyUGYrK2hYVXcyZFc5dytvdDRPOGVlWDJE?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QndyZVdySXozdnRZOG1hOXQ3Qm02TTM3Yms3cVZnMkwxRFNIRThaQkF0enRj?=
 =?utf-8?B?NVZMTHc5dHNsNXkxWG1ZR3FCMVV5VlJBU21ZQzB2eVgwdE1aTUwvNjBPeU1S?=
 =?utf-8?B?cXRhd2RLUmM4S0d1Q2M2cmZEdDhqcTlQN0ZGWW50dVZCdWRTclNvdTI3NHBv?=
 =?utf-8?B?cjJSRkJGRllVaklEUWFSUFlGWjRiV1p0d1ZnVXdFN2o4UU1mOHRmZHZoemVS?=
 =?utf-8?B?a2NmK0dOTWVDMU9leFBEWHFMdXdKMDdGUjNRVlE1UWVNVUhDN2J5UnR6ZFNq?=
 =?utf-8?B?QjZrOWR0eVdPQWVXMndwQzhYWVZhbkdKV3pMUmdIVGRDbzRDWXc5TW5BeWhS?=
 =?utf-8?B?Unk1eW10Qy9HdmlQR3hvUDhEVHg4MkZ5NDdkSitGOUhDRkVvdnZheng4STlw?=
 =?utf-8?B?ZUdGSzFjK3g2NWZ2UnRGUGRYeVpZU0NnZS9zNnlmNGpkNkpBbjA0NllWSE5F?=
 =?utf-8?B?bHNaVkVFdStaVHpjalVGaDQ0OHh0NW5CYUJTY1Mzdmdiam9MZ0s0c2F4bHpL?=
 =?utf-8?B?OXJVNW1lNUQ0d1RtWW0rOHRsTlhieVdCejR2dUVoZFF6RUZZTmhJSmYvNnZC?=
 =?utf-8?B?dXdMODhsbDBxN0tUSW5XVTRDZkZvcGNBOUMrTUNYSlA1cHNPdFp3M2o4K1RJ?=
 =?utf-8?B?SHBJUFpicWxZZFhQeDd2bHM5bmZmMThkcmFsc2RVVDlUbHkxTnFpSzVDeEdW?=
 =?utf-8?B?dFdUMmNTN05Ca2FacWxZZkF0c3lyS0dQejRLRTlDMUxLa1JqMjBKdlRmK0Ry?=
 =?utf-8?B?Y2hFcStjcGdTbnBYMGYrMnY3RE94VFdvWXhWZ3VpQnhCNlJXUjdFYVpqNnRv?=
 =?utf-8?B?OER3czRPNExQN1ZkV3JkU2VqVkc3RlhlczlRZmgzWkh1YzNhK2M3bDF1UXQ0?=
 =?utf-8?B?ZU8vUENQWG1QdkhzdkJ1UktJVnd5M3BJK2F3MERHUURXOEFvUDRoYURqbHFa?=
 =?utf-8?B?YjhpZjMxTGJoL2VCTTV6dWE0SHNLM25adTFBRnMreDZtQVMvVWhxZjNvRTlJ?=
 =?utf-8?B?bVJEWnlGbW1MS3dKQXNmKzU1QndIZ3U3Nml6SUtKdXVONmxlYnpKdTZJakFB?=
 =?utf-8?B?QmlOcThjaTI2RDBSVHBtNnArcElVdE94OVExU29rMU5FUmJyd0gvcWhqQ0Fi?=
 =?utf-8?B?Y1B5MHZ4NTBxeVpBS1lWQUd6bExqamZFaEV6eFRHRmdMQytXMFJuTTdtZjQv?=
 =?utf-8?B?UC9NY0ZHV1RtYUVqRXJVamNuY1ZheWd3ZHlJTlhVdllDTjFJMlEwSFpJWkJx?=
 =?utf-8?Q?2ChkAmb/xYK/rz1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c6e7cd-a561-4ea8-8caf-08db636e7d12
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 13:37:20.2078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqkAqZurZO+d1Qfcp8NszNLXYKyVMnhFcIfQYNsr2eN/M3YQI7kw/jKfYiVSU0eUz+T0Qfn2AnL3G6BjYYlgol0pZgOdblpB9JYwicnwq/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_10,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020102
X-Proofpoint-GUID: uBYz-N4oRK3ZCnyd1nwrzBl5X4atpVvC
X-Proofpoint-ORIG-GUID: uBYz-N4oRK3ZCnyd1nwrzBl5X4atpVvC
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize to all of you for letting this one go so long.

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

On 6/2/23 3:32AM, Christian Brauner wrote:
> On Sat, 04 Feb 2023 10:33:56 -0800, Kees Cook wrote:
>> To avoid confusing the compiler about possible negative sizes, switch
>> "ssize" which can never be negative from int to u32.  Seen with GCC 13:
>>
>> ../fs/jfs/namei.c: In function 'jfs_symlink': ../include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' pointer overflow between offset 0 and size [-2147483648, -1]
>> [-Warray-bounds=]
>>     57 | #define __underlying_memcpy     __builtin_memcpy
>>        |                                 ^
>> ...
>> ../fs/jfs/namei.c:950:17: note: in expansion of macro 'memcpy'
>>    950 |                 memcpy(ip->i_link, name, ssize);
>>        |                 ^~~~~~
>>
>> [...]
> 
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
> 
> [1/1] jfs: Use unsigned variable for length calculations
>        https://git.kernel.org/vfs/vfs/c/2d6e1895d440
