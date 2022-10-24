Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03AE60B943
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiJXUHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiJXUGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:06:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF6714BB77
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:26:35 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OIA3JC010321;
        Mon, 24 Oct 2022 18:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ftkkngj1v9d9h3eDDHK5ewaUUjH/WmTRk0hRG6IsGmg=;
 b=JRX+Q9s3W7mfH9UzXB6/Z7/yYlZpyqF/of6XMp3hTM3whBmu3Sbfb68xln4V/lUGcDHo
 ITNNQR3QkwFF0G3ZE7IZYIWnXGWPpKcSTwIu9LlEa5qcY0LO2yF1fLDfWTK0bJnF+PJY
 9+vdjjThp/z28Lt/diHA/RkH6rL++5OTMtb3dLBaLfpDoIROTqJ8PEDRdkiANFyY1bsE
 rm4sApSMtJKbTmF0DLLEl3i9bQnVCQIgvOJVuUhUnmx433YoyhrgrbzfMaxa3zcj8bVT
 s57TkveGu3uB7Q0a0QWkulFEWFMGNhyHHbpajrvzgRi8CwWHvn6Na5gkGsluUmS3OG1H UQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a2vgh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 18:25:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OGc3sk017267;
        Mon, 24 Oct 2022 18:25:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y43msf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 18:25:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzayqv4jzmqRMozHg5LHQlWIAO8FxEfTZIc2P6BnyyIfur8RLKtD5CHAOGrujrp0rEqt+HFpUT+q5L3xeY3rdf6XCWV+jpfW+mOUit1uH2dZGa8CkC4DrwcRMKX3VVILxxi6Z6+zMpmLVareFNxwgSBHqRKqHH3xiGOsVkpJGPxJOCkzmyZDIZF0lQIE5IyqanSkm/INnTXlMxIgrcpuxmapDI+xzSsv+4YNM8l35kZexsqZQKYJSpxVZtQsMliAQr37OEdqBJ6z2rHgNv4ottUpg+JhiWCfLQUeYSROU3g6UfwiuwXMppjM1EeU8uXn15g1rHBG4GO0sglLlCPRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftkkngj1v9d9h3eDDHK5ewaUUjH/WmTRk0hRG6IsGmg=;
 b=mChaLQQTuW3JQgdqWWC30tyoixcE6FkidGDuPBh/w4uDbNg017GC09tcROg8M/g0eRe7ECsZMEsgWcI08dTOdTm5gOBXTOZsbrhsSTmO/V6ds9oKebrPEFn2snebIrPUgItEaC7h5ZBqSVBu7q+rqpf7nUD310NQNXi5vpWQinSLk4XiDvSJOAMruhIy89SnTZ5TXtA2k3bgJJKPMHjW1j7gn2NLaeky06NE22iJu7go7v5QJTkwgZal2C30fiBCF4Kjojwu0E/ePmfbNJpCXJ6NUQCdm6sm+l9kl1IlgMeq+w7P57c9wTpMR+Hw7L/TYZmD733E1J4TV77mOxpZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftkkngj1v9d9h3eDDHK5ewaUUjH/WmTRk0hRG6IsGmg=;
 b=fCEAZKFxuNi/nJRJY0mLDtFOJP9BHG4f/ofjLlBkvPNE0IF5jHrHWG4R/27PGEeHanMUiQzuVizblZpfQBiMlHy7CmkOSySsSnjudpuWa4BKgu6bIFAdAYrh7+AQgIMyzI25CsYVJoAaFXJeCUu5X7r501wh5CfYM87u33uLWh0=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by CY8PR10MB6730.namprd10.prod.outlook.com (2603:10b6:930:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Mon, 24 Oct
 2022 18:25:37 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4cb8:f380:67:fe9e]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4cb8:f380:67:fe9e%4]) with mapi id 15.20.5723.033; Mon, 24 Oct 2022
 18:25:36 +0000
Message-ID: <e392155b-5c96-11a5-df32-6670139223da@oracle.com>
Date:   Mon, 24 Oct 2022 13:25:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH v4 3/5] locking/rwsem: Change waiter->hanodff_set to a
 handoff_state enum
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>,
        Jack Vogel <jack.vogel@oracle.com>,
        Jorge Lopez <jorge.jo.lopez@oracle.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        John Donnelly <john.p.donnelly@oracle.com>
References: <20221024174418.796468-1-longman@redhat.com>
 <20221024174418.796468-4-longman@redhat.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20221024174418.796468-4-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0073.namprd07.prod.outlook.com
 (2603:10b6:4:ad::38) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4722:EE_|CY8PR10MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: cd00a244-5c5c-44e3-08e1-08dab5ed2576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPB9HMiYDhgPgXAhOWeEAd9xccNAAV2CQzO82EWmyKFiUO1aPPvTvfJAi72AzFYi/GnEtDhJCAoVSN35Pp7kIM5dkTtzyKwh446CPDGQcvx7m8t1+t3M9vSzR1WS3tT7gkGjf4aG1eq31PBiSmBJ50Agzp7zp3gi6o6Pb4CBWsB3sVQB39cU+dLm+M9yoW5EJIW1GGVBHDaKkg9jLfoveraFpj3D3cbW2wwYP+WVUB4yiduV+gVZSld7nGrpzgbLTvgFQQY8PwwUPR0/dzyYSsnSHT84LCxzvJOIPewEEuOTyDQuWfT2FEAb9rVBRE2SQIxwi6BuvTultj4sJ4Sc0YzqW9v5zwI2h/FnbD7puZ14stdVVVxy4GKc9CJ0r3C929w9vboClZc2wrvJbI5dfkVdK6+UFxJLmSdREJA9/TfjSkY+0GtQQDERnhqfki2JzIir/2BeSJHcVMNQ54VQnwMEtdD/Wl6ZFLpSkVLakFiDIusEtxEZ1c3QzEfvrPLKT+FOAy+sB+xAW+LVssSpexoNdjWgrwqfKYyXOBsnVtfcmcC6UuldGJ1KzuPw3t0bQRvsGIYhOn2EJxx9fkH7LOA4EAVuQPtI39oe1M3cwEDaZuv4QW83YZ1puNQmRSfFeIPxfF89yLjol8BsG75Jjzqyl0dRvvghrB2pC5KlcgxF5a2wKM/XJMMeJ6SA1ZfTMUgrL3kYNuh26mMpBYRckIDQOc2OIYuKXUzT93NJOf2S8zKIUftbdjoOxWWOBC+37hszlkhv0sbnnkNff0Xm3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(2616005)(186003)(83380400001)(41300700001)(38100700002)(4326008)(8676002)(66946007)(8936002)(66476007)(66556008)(5660300002)(2906002)(316002)(86362001)(31696002)(54906003)(110136005)(107886003)(6666004)(478600001)(6512007)(9686003)(53546011)(6506007)(36756003)(26005)(6486002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFVEbjlhOCtPL2YyMGlGMTF0Vy9lSXJXRWsrZ0VOMTBTZ3EyZlNQNlpoakN3?=
 =?utf-8?B?MDdQV1pZdXZhTWpVaVhZc1dybndFVUpRT25Zb0E0c1FJdmdaajJBeXowOVM0?=
 =?utf-8?B?eTBMdE5jUDJ3SmJEMWZ5emcreWRXZ21WODNFN3NkU2JEaWlOa1ZzaHZwZGQ5?=
 =?utf-8?B?QjlvdzZvUDA2bTNvaE1QWFpvR2NQbU1NZWZXWU8rWUI5Vy9EQ3VYNGVaUW11?=
 =?utf-8?B?dm05cHhTU0IweFA5SkppTGxlbGc5YkpwY1g0bGw1aXBoZWpVS1pGQUlOaVVB?=
 =?utf-8?B?dHNXTCtibGhpS3VRcWprdW1jakJRSlBMV3J6elRWRStRL3ByWWVvUWFzUUQx?=
 =?utf-8?B?U3VEM0ZOeGRVajhzZnpOM2svSXZhVmExSDVSM2pweXZDRERFWGlCQjZPeStN?=
 =?utf-8?B?bnBMOTdQblVwQW5IQ1JHNE5FZ1dyeW5aeVN4Z1JwclA3UzNqSUFOdE9tWUZs?=
 =?utf-8?B?NFZUWlpjd2VLT0xtRjdxVUg5R0pWVDVrQm1kK1NLdDJpSk15VzV1SjhmR2Mr?=
 =?utf-8?B?Q3FyN0YzUW1KUkJwd216cFRkQzZ6ODVIbG5nVy9hMHFmUkxBTXdrVzlhT0JL?=
 =?utf-8?B?RWd1OTlhRUdxUjNjNlo0Vm90M21WL0RxRVNzVHZtaGNEQWwwaHVFZHV5Mlhl?=
 =?utf-8?B?UFIxU1dlWllhbnV1SytpS3pxOWhDRGl1REw4cml6MDAyVDJYci9rK1FreG45?=
 =?utf-8?B?SXZvVkhiSVNHSWhlZUlRUkl2VmxubDhqbG5KTXkvcmxEdFFMVkJPTWt0eFph?=
 =?utf-8?B?alc2SEp2bGdHS2YySFJDTzVjMUtzK3lmSEh5QTB0WEdaQ1VvaE5DeXoyUzRO?=
 =?utf-8?B?cXdwOVVvRVJSUzZmQi90a2F6WkNXU01UZVZjUzJxak5mWlk0VEs2NDREVUJj?=
 =?utf-8?B?aTFqQXpQTEVGSUx1aHBwYzlyQ2lWR1ppc0ZwbTBrejJFbVVIZEVQVnFrMmFw?=
 =?utf-8?B?ZGRic2xvL0Q0NE5MYzErcS9uNFl3dGpFVkN2ZnJKSzlTK0VjZjN1Z0RJcS9R?=
 =?utf-8?B?aDJ5RjhFUmdJQklad0dHUm1EclFyTFdjbVV0RVBIM0REV1hRcVhyTHhZR1JN?=
 =?utf-8?B?Y0RWeVN6YzNtMThxd0JRcWhxMjA5WnZnMm1xQXVpd3lYSWh0RTJTUklNMDNS?=
 =?utf-8?B?NHFNUzZzNTkyekdYUnU1WkhKR3FVRWxFWGF3KytUMDY3d3E5NGw4STJvTFRL?=
 =?utf-8?B?VmtIbEllaXpuSndNM3pISTdNcHJtc0pDWDVROG4ybXh2dlM2TTVTNDNuSlc2?=
 =?utf-8?B?Q3VxQ2VBZ3hpWk9nT0JYVWJUWDhoRjE3cVVlZlQ3YUI2Y1FNUDk0Vk1tcTZT?=
 =?utf-8?B?bjJxVGJhbURTSTJ0MGVSS21PRHlFc3dTNHJsdmhza1ZyekN1SUFlazNmSFA4?=
 =?utf-8?B?dmx6Y2xCVHJsek9IeXFLWnNxS1dwY25oaFdHYlBkNlJXTGU4dWZNc0tZaUZQ?=
 =?utf-8?B?Yk1OUDdZS0xSSG5Ub0FGQTQ0OFU1RzZXNFA5OUNFeGFXTDdVWGphQ2F5YXUy?=
 =?utf-8?B?WUZoL2gzdzZBYSswZElFRWFCMnE2bFhmcVB2SzVmcjMwbmh5dEFVdks2UXFz?=
 =?utf-8?B?YitjdGlueEJCRDhCakJXekd0M2cyYnNKbFNVaXB6bWJTL3lUWG9XcFk4bjdj?=
 =?utf-8?B?QlMxVmxLRFpjUHpqTTN1eTUzY0h6RVE4VVFUbHpDRlR4T2tCSmp3QjgrdmpD?=
 =?utf-8?B?TG1FS0NZMC83UkxKWVl5KzN4VWpQd05mYVRsR0NYc0lCazIxeDJKR1RSL2Zr?=
 =?utf-8?B?MC9JaytrZ3ZITFIrZnVLVlczN3NOVGR3Tk5xdUgvMnF5VlVPUTErd2lxR21N?=
 =?utf-8?B?c1k1MUN5N2xPVTB2elVON3RrRUFCU3pXVHZFMXY1Y2JjU1piOTVLL3pleERK?=
 =?utf-8?B?Zldra0R3SlhtV0Z4aVAwVzFQY1VLZkFCei9ScXoyTnBsYW5EdGdydEJWNnRt?=
 =?utf-8?B?MnlSTnF5a1haZnppOTdQSk5vVjNuK2xMWFVjSWhRcVU3OEhWT2RvSzB4Y0Np?=
 =?utf-8?B?Vk13M1JQR0lPZVk4ZUV4LzloVDNsdXpMNXJEc2RSVHBYT0Fxc0w3MDcrSGk4?=
 =?utf-8?B?MlhhSlRkejRGSFErNlhabDk3TmVBUFdnc1RPQTdiL01zbHlGRDlDbjkvYzV6?=
 =?utf-8?B?blFRNk94YW4vZEZoT2VDRFh0b0hWS2dKTVRoZ0R5NGxnZkVmb3FOWXNhaXhK?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd00a244-5c5c-44e3-08e1-08dab5ed2576
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 18:25:36.8434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oN5WMG0mI56j0lPzMFUI8/FlNu+9C0xUtPtpeHym0jC78oz9hUKrv0ywf089cjw6ssqt+TSY9k1hcM3qatuRa5xfmB9fvClQvcRz5x7ERI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_05,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210240110
X-Proofpoint-GUID: Ym6O9JTHvXGoEokdHg0y14aYQQLrvmg5
X-Proofpoint-ORIG-GUID: Ym6O9JTHvXGoEokdHg0y14aYQQLrvmg5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 12:44 PM, Waiman Long wrote:
> Change the boolean waiter->handoff_set to an enum type so that we can
> have more states in some later patches. Also use READ_ONCE() outside
> wait_lock critical sections for read and WRITE_ONCE() inside wait_lock
> critical sections for write for proper synchronization. There is no
> functional change.

Hi,

Do we need


Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more 
consistent")

Fixes: 91d2a812dfb9 ("locking/rwsem: Make handoff writer optimistically 
spin on owner")

Cc: stable@vger.kernel.org


clauses added to patches 3,4,5 so they are all picked up in one series ?

Thank you,

John.



> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/locking/rwsem.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index c68d76fc8c68..a8bfc905637a 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -338,12 +338,17 @@ enum rwsem_waiter_type {
>   	RWSEM_WAITING_FOR_READ
>   };
>   
> +enum rwsem_handoff_state {
> +	HANDOFF_NONE = 0,
> +	HANDOFF_REQUESTED,
> +};
> +
>   struct rwsem_waiter {
>   	struct list_head list;
>   	struct task_struct *task;
>   	enum rwsem_waiter_type type;
> +	enum rwsem_handoff_state handoff_state;
>   	unsigned long timeout;
> -	bool handoff_set;
>   };
>   #define rwsem_first_waiter(sem) \
>   	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
> @@ -470,7 +475,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>   					adjustment -= RWSEM_FLAG_HANDOFF;
>   					lockevent_inc(rwsem_rlock_handoff);
>   				}
> -				waiter->handoff_set = true;
> +				WRITE_ONCE(waiter->handoff_state, HANDOFF_REQUESTED);
>   			}
>   
>   			atomic_long_add(-adjustment, &sem->count);
> @@ -622,7 +627,7 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   			 * waiter is the one that set it. Otherwisee, we
>   			 * still try to acquire the rwsem.
>   			 */
> -			if (first->handoff_set && (waiter != first))
> +			if (first->handoff_state && (waiter != first))
>   				return false;
>   		}
>   
> @@ -650,11 +655,11 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   
>   	/*
>   	 * We have either acquired the lock with handoff bit cleared or set
> -	 * the handoff bit. Only the first waiter can have its handoff_set
> +	 * the handoff bit. Only the first waiter can have its handoff_state
>   	 * set here to enable optimistic spinning in slowpath loop.
>   	 */
>   	if (new & RWSEM_FLAG_HANDOFF) {
> -		first->handoff_set = true;
> +		WRITE_ONCE(first->handoff_state, HANDOFF_REQUESTED);
>   		lockevent_inc(rwsem_wlock_handoff);
>   		return false;
>   	}
> @@ -1043,7 +1048,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>   	waiter.task = current;
>   	waiter.type = RWSEM_WAITING_FOR_READ;
>   	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
> -	waiter.handoff_set = false;
> +	waiter.handoff_state = HANDOFF_NONE;
>   
>   	raw_spin_lock_irq(&sem->wait_lock);
>   	if (list_empty(&sem->wait_list)) {
> @@ -1131,7 +1136,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>   	waiter.task = current;
>   	waiter.type = RWSEM_WAITING_FOR_WRITE;
>   	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
> -	waiter.handoff_set = false;
> +	waiter.handoff_state = HANDOFF_NONE;
>   
>   	raw_spin_lock_irq(&sem->wait_lock);
>   	rwsem_add_waiter(sem, &waiter);
> @@ -1176,7 +1181,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>   		 * In this case, we attempt to acquire the lock again
>   		 * without sleeping.
>   		 */
> -		if (waiter.handoff_set) {
> +		if (READ_ONCE(waiter.handoff_state)) {
>   			enum owner_state owner_state;
>   
>   			preempt_disable();

