Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D59373206A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 21:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjFOTiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 15:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjFOTiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:38:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B3C2953
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 12:38:08 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGJh0V001345;
        Thu, 15 Jun 2023 19:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : references : from : subject : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8/0ZMmb2IS1LTvLJrKGYHW1mfHRytLxU0PJ4reqOB2Q=;
 b=r1V5I00TKfBaAGSMXjyfnTEDjJd4FrRinLH9jQVLVmWDgstHrISnVhp8c/izbuLHAdSp
 4aNpZSqQb0vQEyr6izOLUL5FibfgCISArBNTj3mDt331wDmIZbnR8R8QV/lOU5VdeGuQ
 za1QGzRrMjQ+qUseXal/W9wS8BsZ9p4Fi/tNpSzdg4O+hx/t44Dre5J7/XtDtOe1Q8mi
 Vf+6QHzFkqpvE9BXB6Gro07XGsRaIJnpbcLWlZIGgbD1JB2aVuykOzBBkY0p/bfCXpRQ
 JylubfCHZYFFy/CaOyvoj6LAecZg6RJmjnyTesJj0vW+rVLttN1jaGKhXxKdFZGWvGKA Pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs22wem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 19:37:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FIEBg8012373;
        Thu, 15 Jun 2023 19:37:50 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmdn9yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 19:37:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJjLPaIH5+dBf+ZBsSERAqaM29HV+N+UAURTkBTpFximpMWm2kltbaPlqK2MAuJxYvK7ic8A+QpTr1VueKdrw10lVSRhYDqeTACAMF0/nmVKYEJN2UonhRkOsJisXRcfjncdZDR2DuwSnLuTDZltQdUTNO2oyI3JtRnDUx7OGtJmdVUBbmBHcmp+Z/8aczhpftPHcOk8zqiLSUR6LYkjhoO52ajEP8JiumC6ZsXhx6DnGwRswDf08+BPmiol5oLE5NEqoK5B2sQUB2u3xDDmwg3l+mwFeALaH1al1gmYnwLkCdlWR7XAqYUj4ONgb2iPB9whI17Ps5jOKgtFudkYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/0ZMmb2IS1LTvLJrKGYHW1mfHRytLxU0PJ4reqOB2Q=;
 b=KbucuDls8G3ryhoBGGvL1B2IaHKdM7AmpEfohw4sg9Y5qpe2LVkrNGg/TIJtE2s1wINg00KKf340gdTIFh4ZL9s+wy8I8J2E8ua8BmFkHEZiHkmzbPZ5lpsNLqqPSl60WGmyFbg6jMeOOnBEa5tAAWlGp8ZX/EzJeGYNulNvlAz/4O1cExjoC/hq9RGviTyxPj+6v4Is4H1MecMdtM+wAvnJ+ZlvO5l0PuXsCWg2x1GJG2bk9seM2F98gIZkj0w5ukHEDFpRSaGbVRnfqPyGcmr+WXQMrwAQ9xXXmgOWmf/Qs5XLxtFVD7ujXelohS5E6eXpWwAbL+pHAEeQY5X30Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/0ZMmb2IS1LTvLJrKGYHW1mfHRytLxU0PJ4reqOB2Q=;
 b=xpub/Qoh8tOHJOFd6fHQaApDZKtdtTdJhkOAr5tqIx6vmnm9HJF1jf/1IYhQY/Nw5ABDDR0eJJfzaX3kgh2zUPnRZwR9pLvcrXMv7zJFgUreAan5Aby6GYcFJgFRcM0PRcsGyt3dR5d1KR9EiJk/hfj/Ql1wL3IKfX7jaJVhVXI=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BN0PR10MB5014.namprd10.prod.outlook.com (2603:10b6:408:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 19:37:48 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::2bb9:5d2e:a65b:e731]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::2bb9:5d2e:a65b:e731%7]) with mapi id 15.20.6500.026; Thu, 15 Jun 2023
 19:37:48 +0000
Message-ID: <08357576-145d-2e84-c6ba-b48583bc6bf2@oracle.com>
Date:   Thu, 15 Jun 2023 15:37:42 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
References: <20230615123959.12298-1-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH] x86/xen: set default memory type for pv guests to WB
In-Reply-To: <20230615123959.12298-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:a03:100::38) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|BN0PR10MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: e6104249-d8c2-46e2-05f2-08db6dd7ffb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80Kpg6Tzohv8RleQzx5VTMv1KPr9ASXpDD1R6wmdxJaeJc1tNnJU+LLIRMM7Vn3QvpJqcgqeUhOZByyFJXye0ZcNr7A7/6TyYDjIKOL9bzzTMl2WkqyVeOy8c4SLZPqrGdeWndqRn2OcumRij7SSn3KYrgYhIZmIx2ljsytgwRdtTUnAc6eZOiOL81V48tg/Ux16Plv9HYYLkeFx1rsmigpLcjSGJFfTX7WWDOxJkQnkSt3Cp0quuRX8wnlyhlf67kDdd4TPRvv9U+gFwP6/V8U4nm609cYTAUcxJYu2m4JD1A1semlfRbd3IzRpu8Y0EJX8MPdeFLC4Fgyypb6AVEIIOl59dwep1vF+3AFHT8ZMXk0TFezL1nRB7R2orKwheyjkBXXaeCkWB+LbJnZRV8pGFuYb9V3UxvuODEk/h4IXmUgx83WZsZ41d8edJM7sSU6vLY49bg/oYiVzjngdhr+eznF/vAYB3vdzHK7FjAbCwWX5LRDnaiRLOwDVpfYbBA4Y53P1VEmJcx+q84jhJ07/wSYr1IRccQ55coojdH7OgtzY++RvW1UaOkimNlRbg1piYS/5QN4AmXlE9n1PAnpg5mQAwxlyfs7PX9JfQkKALOXwOqUfuZYIEmdgSCZ+gz28+cDOhjiIcfKdvSH/9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(36756003)(558084003)(86362001)(38100700002)(478600001)(41300700001)(8676002)(6486002)(8936002)(4326008)(31686004)(31696002)(54906003)(6666004)(316002)(5660300002)(44832011)(6506007)(53546011)(6512007)(186003)(26005)(2906002)(2616005)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW9tbi8zNlFacWt5UU83OVVleVFsa1YvZVRQT254V0tieXVBaHlSaFBzRDVu?=
 =?utf-8?B?UjVBMFJ5TmNiV2ZKSHg3NlFxWmxyN0JCYVdjckU1Q1QreksxRUU5SUFKWE81?=
 =?utf-8?B?SURwTCszcCtuek0yOUFzMXVLY0RJNGVuM0ZaMTdBbklRK25yc3phR1JLY3JR?=
 =?utf-8?B?Z0FiZTFNZlhLaGVWWndDZmdLU1pBdWlUYmZ2d3A1QzlsT3NrbFNrUW5RaHNj?=
 =?utf-8?B?cVZudjlFZlFndFIxakdLWEs4TWpGTnVLY1Q1T0VRQ2ZURzRUeDlWU1hQM3da?=
 =?utf-8?B?MDUvM2tNM1lhUTh5NTBYRUFNOSs2M2JUN0V2dFNDeWF3SG9DaW13UFZoeUVD?=
 =?utf-8?B?TlJsWUgrbktEcUdvUS8vODYxdm5WTk90SkNuVWcrYnBUdEwvY2pydjRKUXJs?=
 =?utf-8?B?MERUTmxjMUxMVkhRRmxZc3BmVUFVMFFUaVBOK0toRUE1MFpkcHNkRlIxeXVR?=
 =?utf-8?B?UkZIcVJjT045c2JYajMzelY5Ym9SMHNNMGFTdlpMeEk3TFlTb09ncDVaVEFq?=
 =?utf-8?B?SDVvZVpzcFZBZDcrOXM4M1RPN3Y5akhPd0NERG41anY2UXZLSGxpbFVGbDJu?=
 =?utf-8?B?c0xXSi9NY0gyc2M1cFQxcW1hcFlnaDZubVA3QXpLV01NaStKTjY3UUhGalk0?=
 =?utf-8?B?RUlTczVaaThndUNIODhxdGRINEIxNnpwUkR3YzJ5OHNkMG9LZjF5Q2pjdkhw?=
 =?utf-8?B?K3NEUXdGK1NaVFpnY2o5dUxNWTRkMEJ2cmlJaWNvd3FQcTRoMyt5VjYzQmJx?=
 =?utf-8?B?bzNzbTZ6Z0w4cTBpNkZNSm9rcTN2eXpyR21zSUR4VGJmUEZsOU1hSWNQNEVp?=
 =?utf-8?B?RkwzWDVoNTVvdXMrU1p6M1cxcHVGc0Rucm5lZ3dSOUs5YUJXOWpnR3Z1RStw?=
 =?utf-8?B?NzFueWtGUjZ2a0RZa0pFSkxnbG5xUHRJTCt6dTRDRWxBV3Iyd0NpanlvSVdm?=
 =?utf-8?B?R01ySnV2VXhNdGw5Znd2djRFT2N5U3FpRGIyL2J0NU9RaWU2M3JvUHYxaHlD?=
 =?utf-8?B?eG0wd2lQVkJHUjdVUXBSbnU1aGlCQ2ZtRlIrVjhwSGR0blE3N3RoeGZqWVpH?=
 =?utf-8?B?dU1VSElmdDJOWXc1aUIrbXhWQzBvUW1XOE1rN0dKSVA1dUZuTXBjUnkvSlhu?=
 =?utf-8?B?a3VjWk1mQ3E1TElZWlRsVmJRaUFTNGtmMjRadzBFM2pVV0FmU1lzcmxnSG5U?=
 =?utf-8?B?SVJxc0cybmtKcjZtWFlKRk1vWmpIeU9nbkFRVlZDZG1qSVRIWWpMaHFHdTAx?=
 =?utf-8?B?a2p0SHdNV0ozQWhVb3gybWlsR2dFRCtTTXNNaVRML01zVVNOemNVaEhpMG5i?=
 =?utf-8?B?NUFlKzAxY0JqNmlwZ2R1NWpteHM0WDNOeXBMV0twSUw3NWdkOWdoeVZmTk4v?=
 =?utf-8?B?WmN1dVZYSjFTOFpnYW5BOWZEQ0tQYm9LZzZzbWVhZzRRaEM4RWJIWUhJNDZS?=
 =?utf-8?B?ZWJuWG9PcklCWk9PVHVnTHY5WCtWNVpVcUx5MXB0UGZ1c1pTSjlYYXZhdUVN?=
 =?utf-8?B?Vk1RWXdMbWdoeGdVZFFpb0ROUk85OFJNK0QxWEtBdUtrVXY1S24rcjdjNHdW?=
 =?utf-8?B?bE1oejRzZU5nUlJZSjdBZHUrVXd4WTkyVllmd0RUTzkxay9tRi9kVHFPVDdZ?=
 =?utf-8?B?LzNpYmNvR0lMMGNNYUpPUWhHMWNKdzRDK2ovenJsV1J0Q1FQQksybTFJS09n?=
 =?utf-8?B?dlNrUTNmQXRXSGhSeDMvZUVnVDJxYVRzL2F3ZWxuSWxnS1VLc2cvVWRuTEV4?=
 =?utf-8?B?VFFhWE94aVl4RGR6Y29sYllEcW5Oby9HVkduNkJmU2dyYW50ZzFSZnpvTjU5?=
 =?utf-8?B?dUROalFuUldDV0Y1dkJBSWEyU3daM3FqSUxGZ29Xc1NMTlJhNHBZRE0rOXo4?=
 =?utf-8?B?WXFncVdSNmRLU3lINXJCZk9xNXA5UDVHYVJzbHJKbXVqQUQwK2JQc3gwUnJZ?=
 =?utf-8?B?T0oyWEV4VnoyMEFibXl5T3lBQlBzWEc1Y1lhbTVublovbmJRVlJhbVh1c3lW?=
 =?utf-8?B?NnU4ak1WV3lNVWo2K1p0RU80cUxlOHhUYXJuWEFXbE8xcGJsZTE4M0tyQjNt?=
 =?utf-8?B?MEdzaVB0aUhjWVdEdVNndHF5Tkp2NUdxTzlvak4vWDd2S2lwemsyaUhrcHBS?=
 =?utf-8?B?ZEp1VWpKRTc4SzZIWWtsaFIrSG9RRVNmZWt4WXZNeU41bEdjSU53RGc2bUxq?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NVFrRXdJZVZuWURkeEhVaXcyVElxTTZPelI5bHJ2Vmtuc1lDbXpMNVUvbEpr?=
 =?utf-8?B?K3prL2luZHBZY1pmRXVwTHJzSGFkbE1JbzhnazduTmJQckI2RnJQU1hHUmkz?=
 =?utf-8?B?Ym84NFJVZENZbUwyaXlHSno4VS9yZFNZd0dQK2dTSlJkczdxYzhpR0RJakVz?=
 =?utf-8?B?YWpxdXlJZUxYUkYyUWczTS9pV3hmdUZkYjdjT01XdGZ1QzA2UGJvWXYrZW1T?=
 =?utf-8?B?Vkk5a0ZMY3AzUUFVTXJ0S1Z3K2VHNVhoLzl1VXV3RDR1LzY3YTA2VjhqUGlU?=
 =?utf-8?B?b1NkdXlaUktCMTRIazhrZVRZMzlacDErZkdKTVlpZEJKZEVseklSUGk1R1NC?=
 =?utf-8?B?UCtjc0NuQkhlWlphREpUY0tqQlNUWDJNemtnT2JXeHREZEJwRlNmRTdtRzIv?=
 =?utf-8?B?Vm4vZkwyemdUMkwxODhmckN3RzBpNlpRR1JMMzBJc3lPZG1KalVpd2lCb1BT?=
 =?utf-8?B?VlJVV1dlSGhESGlFTHNDU0taK1ZYMkNUQzNiVWdiQkRjbnNTTlgrZEt5QWVC?=
 =?utf-8?B?d0N5L25EMzJKOHZZUm1vNXB6M21yK1ZaVWorYmc4WEl5RDBCNnlpclB3ZWhY?=
 =?utf-8?B?VkpmbkVMRktXclRvSVZ5cDZnY3g2WWljMnNlVUo1TkpjRVpwekZxZTd1bFhx?=
 =?utf-8?B?UVhad1RzV2JmSldrcGx1bG1FenlwOXllV2JVSk1CdkhDTmlDZTBhMVgxV3Z1?=
 =?utf-8?B?M05wcW5UMjN0OUgvNmpSSm9Wb2pDYUpRWWJCOWhqblZRK2dTNHdVeWFqNHRL?=
 =?utf-8?B?cXhVRVVFcGFwYnhGbWFDNTNQWXJEN3ZpQ1diS0pneDkwVVIyOTdNQTRXY2U4?=
 =?utf-8?B?ODJ3d3doOVBsVTdqYzIvMTBuVjV0ejJkNGo0QjFhT2pqVndJQ3cySmNtNVZi?=
 =?utf-8?B?V0VuUXhldHc5OGNCcDVzc0lSWXRCdS9rUTNmRnBqVGxObDVVcTF6RHBnRXgz?=
 =?utf-8?B?dFJINXNHQ29RNWFqUzZoMUVRVzR1NUFPcTlaQ3lQZkZrUUFuaEpVVkllT1Bi?=
 =?utf-8?B?WkMwQVBEYmMvUzROd1IvVE02YTl4cXUrSStjWlh5bHRuZzNsTWhpU0pEVm1W?=
 =?utf-8?B?QW1yYy94N2kvVWQzNGtKaE9iMDcyTHBTMlVlSElWZFM2TGhCWGZPUy81elYr?=
 =?utf-8?B?bzBXSnFVRlZMdW10TzJRalZQL0ZlVERMT0FMY3l6ZHI4UlllYldQcjYzM2kr?=
 =?utf-8?B?RktuWkQ0cytua3FXNXZRWWRCVFN3WnBzT2hQVGQyYjRJeHFUSmY4TVY5ZzJR?=
 =?utf-8?B?cytRNHIvVzNhQi9XdHlmcDF1R0RZbDFJdlQzYlByeFFOL21XZjNaYjlTdXhw?=
 =?utf-8?B?eXg4Ym1QOGlXUWo5QzkvbUN4cjV4bjhOMVZ5Mkt4azQ1cVFlMTVvQUdjSndN?=
 =?utf-8?B?V3pSTEd1Qy9CY0E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6104249-d8c2-46e2-05f2-08db6dd7ffb0
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 19:37:48.0356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cvo5+LA8zJ2gCcy+b2ka51xKuN6n0I0bQsYyCvK1fP/xlEsNiFCAfTWNLZpKYgqdWaHzDeGUtvCN6O6lhI0Cl1w59bJ9fM4PTTQp+2sjWQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5014
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_15,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150168
X-Proofpoint-GUID: 3vhSqbEoVm6EUa-NnR9WuqFOzrKTiZib
X-Proofpoint-ORIG-GUID: 3vhSqbEoVm6EUa-NnR9WuqFOzrKTiZib
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/23 8:39 AM, Juergen Gross wrote:
> When running as an unprivileged PV-guest under Xen (not dom0), the
> default MTRR memory type should be write-back.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
