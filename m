Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DD5714FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjE2Tr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjE2Tr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:47:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35EFD9
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 12:47:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34TDO1Jo021164;
        Mon, 29 May 2023 19:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jES4nyRd/pNAeJ/nS5I6Z4+hS+ulpoB0AGrUMUsSq5w=;
 b=a2zoT0Gy3wWuqf0n+krpWecEL6Oc497ycAivQ1kPYT4LuOpOlSTC7IJB0P2JpxyROOzD
 LTyokvbYQM479j4VRNcCWq8ZGRGXLYC/hIcAUMmoq/xgc9LKaNRDwwhPNS9evbDsu+pY
 DPmbIWlMCio6657KF5Y+nttA/Has2eiGiEjbjtz+yuDKDei4sLGdIB3lETwUlMz7z1wI
 lnX626zUwrUIZb3ycCldLDkFHMHJ4lSpa8sQVaBzdsEoy23yQSx9bgC0CjoGO/xKPO73
 sYmblhYPkvgXD5ljqaHQKH/Zj33ewMy/1NTPrdSypG3u4ZmAYOR3A7YSMnk/Pe4vC5PR rw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb91d12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 May 2023 19:47:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34TJkvog000353;
        Mon, 29 May 2023 19:47:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8q7bvke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 May 2023 19:47:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOnIt37qydCQk3kmAj1TzPn97WMVtuHsUUo2h2tRFgUi/5nGP+JTR/Ppo0SeI+i2XCEZ4eX09FBUi/3DBAkiZFmYH+d0TB7HP0FYu0cIcUzv9NrhYOwYuWRTvo7alxX5IP+60NZZL9OU7LsL4gNUs1Ob9Fw5K3KU6kG+lsrVQfla2x4+DhwmyoVDYI2YwL39KFhOmBCFSyK+YucHfCwOghpxxXsTnifcvMmpeZMVs5DfatZQLGEGmfOYA2EF8F2sSr8awpzfvHuc09+rUZklqjgGyngLWvGwAn2+Ng2Mifv8y5cVMzxgkZUphxIpk4AN4sDgqqao2ZxyALq9iFzkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jES4nyRd/pNAeJ/nS5I6Z4+hS+ulpoB0AGrUMUsSq5w=;
 b=IrEz3GGOQd7lU6UezYwB0O5L/Fq/Uhrr5H2ENvtSj8f0bLI/lrmO3qmxdQ6iJWtvMD6xhyH+5nn9Asjn6l8SEvqbSKRMwMjza3PhUN5mjmFxlsV7k0coohIojOOQ11lDu/BuZnhANW2BPjFT8qSCZCpitIYqd0L2m8FxXzVfC8lGt/v2/rEbULEMsEQjCvvkbow75ZCHpqUEwcBr3myJEd+LZ9Wg/Tgw7ac1w2Jgup5EWei1kzQwPZe14YCMny8J7szYhY0o7mbdzkrW6c3D0RW8txK0F/FlwrYiuLwjWdq6FCTOLTLKljNJI/7ADyB1Jtk4yMNAJKS5eeM6YDh1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jES4nyRd/pNAeJ/nS5I6Z4+hS+ulpoB0AGrUMUsSq5w=;
 b=BwXilcGk3duWGtKi79wphy0XMv33vdhctzcmAKvl8yk74dRswTzOkSQvoBulDndpDtLm4g1CaghuE7OG1QEQBUK9i+zAv/LWDAl2AFApcR/qiiFIT0Chh7uc1eoAntsP9nib5HtsslaWSiH2llYe+e26J2AkdV6kXO0w1Ug/R3A=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH0PR10MB5241.namprd10.prod.outlook.com (2603:10b6:610:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 19:46:59 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 19:46:59 +0000
Message-ID: <723ac1ba-31d2-92fe-4010-42d8cd70d5df@oracle.com>
Date:   Mon, 29 May 2023 14:46:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Content-Language: en-US
From:   michael.christie@oracle.com
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230524141022.GA19091@redhat.com>
 <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com>
 <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
 <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
 <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
 <20230529111859.GA15193@redhat.com>
 <022f4de6-9eae-0a94-0f55-b84be4982fc3@oracle.com>
 <20230529174646.GB15193@redhat.com>
 <ff1bce1a-62d8-1b2e-4560-1ce1ffc209bc@oracle.com>
In-Reply-To: <ff1bce1a-62d8-1b2e-4560-1ce1ffc209bc@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:610:11a::21) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH0PR10MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: e2393ed8-9ca7-4fb0-a497-08db607d7791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PieCuCwxZK5UQHTSn5ikobUsgvrhFzIXFeVze9Eh/zbYKYZVEM7EBAOSLlQGrddX6XsrCI6Q6ztojyL3LAd4de21qUU0Dq4f5q1myQsrLW/AlxTmoDpVG2rViSdCikhuG/Dbtc0gbTtWjLhljC7Ff0y6ja/4vGtCkcD14koV/dxlorZa6pd3mEb5ppPOqqMMFZzDYHrNGY0vxot8KuEWfCh66ZcpOipO94eCz0W6oim86uN2XXkipbSkJHVOJvSUCmISVoM6YcPk5vp2BDIU6zx9JXdXF7LWLeJGpL+q9UGMSwgfIzdEor9T8NZmrI6pr3+KuZ5y6Xmr+C2feiZVfnHPcGb/+bqr/97KtrCJZ6BCo61cjAPghXXkbSrPXQ9+duYlt8lbmyZaERrk4HH/GyZB+COZ0uInw2qpZKs0LOftxiqHT/tbW1Q8ktNrMsv4DSLKgJYnNZBQlT54e5YVixGkweo8HSq7GorTsdsUMs38jDBeVVukXTfrqL4bC5DrY0Ch5V/NgIZumh5lHOOJNSdcf3yE3v/ORB5q7AA/TJzctYeJiIwwWcN6h96WF6iRBvK+5uLpAUlnkmE0vUQCDG41qlcrSdYcjmIvaQv5ZSfjj0Zr2ZXoIGRrnuEUPhbt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(31686004)(478600001)(38100700002)(2616005)(83380400001)(66556008)(66476007)(66946007)(54906003)(31696002)(86362001)(4326008)(6916009)(2906002)(6506007)(9686003)(53546011)(6486002)(186003)(26005)(6512007)(316002)(36756003)(41300700001)(7416002)(5660300002)(8676002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3VUMFNjSHhhWWptaG1lUldCTHlha1VTNndCRUZaM3pMSm9TWk1KeG9VNmNu?=
 =?utf-8?B?S1BNbmxJazNIaXlrZFZsYTJnd082T2xuZjQzMWliNnREbjNUd1drVHZMZWd6?=
 =?utf-8?B?K2Y4Z3E5QlA2d0pmTTFvV1JlNDF5UTVSeGhNa0FoNUZLT3RYbWNjcjNBV0E0?=
 =?utf-8?B?bS9vbTBTTTVHaVcwUjlPQ2dWcEhkdmhZZ1pqWWFWeityb0pCQ3VMTmVZOWh3?=
 =?utf-8?B?d0ozbm5yQ09vSUM5WHhtdXYrRy9UbXROTTVQbWJBRHlGNGEzZmtDTGIyRm9D?=
 =?utf-8?B?R3h6SE9Yc0gvNXZHY2hzU0RETWtObnFKNFVmaUVoR2hXQlZ1eDR4TGFTZ00v?=
 =?utf-8?B?ZDFyZ1Y3NzdvbERqTTFzYjB1dm5LdThJTzNNY3ppc1dvZHJKTS9yTHZMVmhp?=
 =?utf-8?B?aTBMZXVuREJtYUxIS1ZZV2ZMT2VXbjEwSGY2TTZQUjNPTzZDNUdkc3p3Rm82?=
 =?utf-8?B?WDZiVFhNeG4zVnkrWFBjeitFeEdtY3RWbG5XVDI4SEFLeEk3bzRtVEw3ekNU?=
 =?utf-8?B?b28rMm9UaFpVdFR5OEJqeFZ3UkFSUGJmTzRtQncvSTVzdkhUNUpTbVNGQzlC?=
 =?utf-8?B?cTVIUVBtekRvUFZBbVZBLzdiZUNxd09WQlFsRkpOVTJJTlRuQ2puckJHY2ov?=
 =?utf-8?B?eXhIZ2daMzFpaVZEejM1UTA4RXI1M3RvQ1VYNExtcnY2VWpIeGNQdlBqUlly?=
 =?utf-8?B?WjcvY2RhL01mNTlJZndnakJMelZVWDlCTGJWUk95ZkF1R3ZTSzI1R0I0VGJM?=
 =?utf-8?B?c3VPZkp3VVRnaG1JWE9ReEkrS3M3cXdWMWU3YVIyYndQMXRYSXRTMXVpMHN0?=
 =?utf-8?B?UEFRZ2pqb2NwWXdncGx2QWc0cnJoK0liVXFvQWIwWWhOLzVBS3hMSjl2VU5a?=
 =?utf-8?B?M1dKUnpPb1QyN1BKTnFhN2ZDYlVjd04vRTl1bXpFTzQ5UnBDMk9nMjAwQUlk?=
 =?utf-8?B?dkN1dFVvMFdRZkdCbDR3L2RoSHVma1FvUFJwTjgxVXY5UndoS3VKTmVzWXkr?=
 =?utf-8?B?NzFyQjBQaThxaUZ2YUdZRkwxTEhmZDZRa1NRbklUaWVGVHJteFVyd2dEWTFi?=
 =?utf-8?B?VGI5aGhQSU84RHZ0amFSOUs3dFRIUXBSWE83eUswZURUMmVQM3lyRjJHTVR1?=
 =?utf-8?B?Njk1M0hwNDlnSnNnV3FaVjhKNGVZZUZoWTNEK01rampxQ2lUV1J5MHZxUWNW?=
 =?utf-8?B?Q2hlVzlXcEE0K3FVZFdGWXNpaFMwcFlnbjZQSURsWDN6S3hrMG1DdVZQV3JO?=
 =?utf-8?B?aVZzU0lRdlJwWDBJTlREaW1LUE8vb2tuQktmWW5Tc25BV3dwcjRRS3J5blE2?=
 =?utf-8?B?YkFnS3VTeHdaYWZwNGVHak1XaGpGZEVNNlpZM1FKL0FGcVRZUCtUWGYrTm9U?=
 =?utf-8?B?bGxrWXJaTGVRV0lPOE8yMmFJcnRkb3huaVcrYUpnSk1mK24wWk9EU0tQdXk4?=
 =?utf-8?B?cXNGcW0waDhWczBIYU5RQUhVZ2gvYkZVNEVBSmh5RUF0S0RQc2Y4Rk5teThC?=
 =?utf-8?B?VzFZNWU3RHlUQWdNR1Z5WTg4UFlvcUhzdi9BSzFnMzVsTkIxU25ITWh5RWx1?=
 =?utf-8?B?TzByU2g3aFRSUnBBY0VNc1BjL25WaGd6OXY2ejhvTld6cFI3dVNQSmJEZlBy?=
 =?utf-8?B?ZzVvQ0JhN3ZYSHQ0dkVaWE5HSGZraWxWR3AzK3pZVTdFTVU1c3Z5M1lhRmxp?=
 =?utf-8?B?RHNxc3BVZGtETXJSVzdaUm9iK09ESnlES1BLVUI0cG1GaXFLSlBnb2Z5dUwx?=
 =?utf-8?B?OFNDeDFCMkNkRi9iZnBnNmczWWlkNHFYWUlZdnlwWmNOYTRCUWVwVFFjY1NF?=
 =?utf-8?B?Y0VxM1Z4VzdQeVhmV0pGWXJEQkY0ZmdmRUMxd0Nvd2trb1VGOTFBY1pXUmpV?=
 =?utf-8?B?NnZjcnNkNnhaRnFTZFBvTEJldHVaUUN4U205TlRpVlVJZWluTEE2TENpZ3Fq?=
 =?utf-8?B?STREVW5JZEdxUE5Telh5MFR1bzZXTkVBc1B0RE4yZ0dYWjdIalF1TDJNWGdB?=
 =?utf-8?B?NXo4ZlpmamlVcjRuTHpHQkdZT1VzUkVuQnJIM1dQVHdEK2NtZlFrZ3Y2RTZD?=
 =?utf-8?B?TGc3b3BNZkFnc1hCT3BiSm9sR2phQmM4aUk3ZHRVa2liY094R1BRd2xhS0Nu?=
 =?utf-8?B?MDRMVmdaQ2szN2JIVFNXamZ1UThzSlJBN2ttOTR0NHU2TXJOR2w3T01IaU9Z?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Yis3R0tQWGtJWUNrNlp1aVpTUDB6QzRTTG9NaTRrZ3M5bjlXTEhZd0kwZmZt?=
 =?utf-8?B?RFhtL3V1TmtuV0xGNG9wdHgvanE4bUdlYXhvMzdUNjV3NG4rM3hHNXBsaXhr?=
 =?utf-8?B?RndBdEFLbUNOeVVpRm11dnoyNUR2VXNWcUQ5QzBiMm5pWEdvQjcvV1h4am5Z?=
 =?utf-8?B?cVZ4LzNjY2hPdFV1Mk5pVWIxYkNqc1FZeUhyT2x1Mk5RT3B6UG00UHBqWGlt?=
 =?utf-8?B?QTkxNUxrMzFwSXhZa1g3MnZxcjFTNUwzTWRXY3FwalhmUHFHays5WFlIWjgy?=
 =?utf-8?B?L2pOS1BLUUc2anNNdVkzS1hZUFM0eVNhQzVUK3NhSE9NYmNtWllLNWFGRkFM?=
 =?utf-8?B?eTlVMUQ0cC81SHBjS2NlbFpNbjUxMXgrWm1sdTNPOXl5TkR5MWtkejNBTk95?=
 =?utf-8?B?aUlaMkpjZ3JBc3had1lBN291YjFEOWMyVXdwdEdEaUlxckIwVURONXVTRWk4?=
 =?utf-8?B?ajVlU1lOS2xDM3ExRHBHV1cweE9UQjNIU2E4VnVDQ0ZOQ2lOeCtjcW1tdE5R?=
 =?utf-8?B?OHAzWWdUcGlPNkVLSysvM1B6bG41VkM4d2NhUG9nMDYrQXRVOVBwY3dIVXBy?=
 =?utf-8?B?SzdWTklBbkhVVWRwU0xNMVhXYTdGUUJlN01QcFYzZXI5Z0czdWw2T2lveFB0?=
 =?utf-8?B?bzlWSTM5MXpJcGgrK1RoUkxINlA2SVZGWHNvMHJQc2lJRCs2U2ZWVy9reXNT?=
 =?utf-8?B?UnZhSWx6YUxMQ2VVdzlmREgveFg5ZXRXUTJ5aUR6Q1dyMEVwZllwK2M3WHBZ?=
 =?utf-8?B?NVpMRGVnUWVmSnVvLzlyTU43K1pxRjdTa2ZQREE5UzNMODhPWVRXSEp0eGRi?=
 =?utf-8?B?T0p4eEF2cTkrTk91ekNUVTFrYlNoZWNQdnlWTW5RUElqTXozdk5BUjBCY2Nu?=
 =?utf-8?B?VEhSUTQyaVRsTUJYeGdEWDcvcklSSWFmQ1VDOTVXT2Y2ajdNNmdySitLK2tS?=
 =?utf-8?B?WVJ0NlBOSnQ5RzJMcnNzb3R6bmMrTFZvWEp1d2haaE1iM3crcThBS3ZHSHJx?=
 =?utf-8?B?K0htWS9ZRzZvRWtvT1dwblBwUGwwQllOZ0RJN2IxN1R6SVh0bmM4YldkaC9Q?=
 =?utf-8?B?K25vUUhqWWRLWlk4MU1aTFFCci83QWFTcVNOeTc4U3RaMlBvYlc4VlAxbENY?=
 =?utf-8?B?bTBxdGR0OHJpYWFJbWhCaFU2SWdzUTBZY3NNb01HQk51Ty9ka1AraUhsNkNk?=
 =?utf-8?B?K0duT1pwNWdzc052TWJoMDhsaEYzU0NPY05sbUp0WU01bG9kbUxBMU0yeU5x?=
 =?utf-8?B?ZDdmMjJ0UWVHQTUxbVdQRHlrUnR5d3NHU28wT2dsN3l3aS9GZFdIaXBQRmJu?=
 =?utf-8?B?MzZGeklncnd3VXFFRk1MK0ZvT2tEanV2TXc5Y0ttajFpYUVOZVo5dEh4RWJE?=
 =?utf-8?B?dVJKMkYveDgzelExYmlDMk1tbVU5cHlPbGZEczdGbjFvdURPK0RNMnhyZVY4?=
 =?utf-8?Q?fP9nOIGv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2393ed8-9ca7-4fb0-a497-08db607d7791
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 19:46:59.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IpLmcVqCf2QXoUfiVKAXAaRW4Bl+L2vGo2ujFZA0S9mX5FOn+noVtTgzzcdcjwtmjmB6gzu0MR3j2nguRIktx2Ww9GB7H5z3bH1ZUv2yW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_10,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305290165
X-Proofpoint-GUID: MYzlDSzXcfrIxu2PvcSHijKxexTilKPz
X-Proofpoint-ORIG-GUID: MYzlDSzXcfrIxu2PvcSHijKxexTilKPz
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 2:35 PM, Mike Christie wrote:
>> Hmm... If we you CLONE_THREAD the exiting vhost_worker() will auto-reap itself,
> Oh wait, are you saying that when we get auto-reaped then we would do the last
> fput and call the file_operations->release function right? We actually set
> task_struct->files = NULL for the vhost_task task_struct, so I think we call
> release a little sooner than you think.
> 
> vhost_task_create() sets kernel_clone_args->no_files, so the vhost_task task_struc
> that gets created works like kthreads where it doesn't do a CLONE_FILES and it
> doesn't do a dup_fd.
> 
> So when we do de_thread() -> zap_other_threads(), that will kill all the threads
> in the group right? So when they exit, it will call our release function since
> we don't have refcount on ourself.
> 

Just to make sure I'm on the same page now.

In the past thread when were discussing the patch below and you guys were saying
that it doesn't really ignore SIGKILL because we will hit the
SIGNAL_GROUP_EXIT/group_exec_task checks and the parent is going to exit, it was
on purpose.

Instead of a signal to tell me when do exit, I was using the parent exiting and doing
the last fput on the vhost device's file which calls our release function. That then
allowed the vhost code to use the vhost_task to handle the outstanding IOs and then
do vhost_task_should_stop to tell the vhost_task to exit when the oustanding IO
had completed.

On the vhost side of things it's really nice, because all the shutdown paths work
the same and we don't need rcu/locking in the main IO path to handle the vhost_task
exiting while we are using it.


diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 537cbf9a2ade..e0f5ac90a228 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -29,7 +29,6 @@ struct kernel_clone_args {
 	u32 io_thread:1;
 	u32 user_worker:1;
 	u32 no_files:1;
-	u32 ignore_signals:1;
 	unsigned long stack;
 	unsigned long stack_size;
 	unsigned long tls;
diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..fd2970b598b2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2336,8 +2336,15 @@ __latent_entropy struct task_struct *copy_process(
 	p->flags &= ~PF_KTHREAD;
 	if (args->kthread)
 		p->flags |= PF_KTHREAD;
-	if (args->user_worker)
+	if (args->user_worker) {
+		/*
+		 * User worker are similar to io_threads but they do not
+		 * support signals and cleanup is driven via another kernel
+		 * interface so even SIGKILL is blocked.
+		 */
 		p->flags |= PF_USER_WORKER;
+		siginitsetinv(&p->blocked, 0);
+	}
 	if (args->io_thread) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
@@ -2517,8 +2524,8 @@ __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
-	if (args->ignore_signals)
-		ignore_signals(p);
+	if (args->user_worker)
+		p->flags |= PF_NOFREEZE;
 
 	stackleak_task_init(p);
 
@@ -2860,7 +2867,6 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.fn		= fn,
 		.fn_arg		= arg,
 		.io_thread	= 1,
-		.user_worker	= 1,
 	};
 
 	return copy_process(NULL, 0, node, &args);
diff --git a/kernel/signal.c b/kernel/signal.c
index 8f6330f0e9ca..bc7e26072437 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -995,6 +995,19 @@ static inline bool wants_signal(int sig, struct task_struct *p)
 	return task_curr(p) || !task_sigpending(p);
 }
 
+static void try_set_pending_sigkill(struct task_struct *t)
+{
+	/*
+	 * User workers don't support signals and their exit is driven through
+	 * their kernel layer, so by default block even SIGKILL.
+	 */
+	if (sigismember(&t->blocked, SIGKILL))
+		return;
+
+	sigaddset(&t->pending.signal, SIGKILL);
+	signal_wake_up(t, 1);
+}
+
 static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 {
 	struct signal_struct *signal = p->signal;
@@ -1055,8 +1068,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 			t = p;
 			do {
 				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-				sigaddset(&t->pending.signal, SIGKILL);
-				signal_wake_up(t, 1);
+				try_set_pending_sigkill(t);
 			} while_each_thread(p, t);
 			return;
 		}
@@ -1373,8 +1385,7 @@ int zap_other_threads(struct task_struct *p)
 		/* Don't bother with already dead threads */
 		if (t->exit_state)
 			continue;
-		sigaddset(&t->pending.signal, SIGKILL);
-		signal_wake_up(t, 1);
+		try_set_pending_sigkill(t);
 	}
 
 	return count;
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index b7cbd66f889e..2d8d3ebaec4d 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -75,13 +75,13 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
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
 	};
 	struct vhost_task *vtsk;
 	struct task_struct *tsk;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d257916f39e5..255a2147e5c1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1207,12 +1207,12 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 	DEFINE_WAIT(wait);
 
 	/*
-	 * Do not throttle user workers, kthreads other than kswapd or
+	 * Do not throttle IO/user workers, kthreads other than kswapd or
 	 * workqueues. They may be required for reclaim to make
 	 * forward progress (e.g. journalling workqueues or kthreads).
 	 */
 	if (!current_is_kswapd() &&
-	    current->flags & (PF_USER_WORKER|PF_KTHREAD)) {
+	    current->flags & (PF_USER_WORKER|PF_IO_WORKER|PF_KTHREAD)) {
 		cond_resched();
 		return;
 	}
