Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E66764D1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiLNVrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLNVrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:47:03 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1672BB38
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:47:02 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BELhrhm009263;
        Wed, 14 Dec 2022 21:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : references : from : subject : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=WCVQxcn5xfuG2qoVHLb5zOS1maUjNeo6BQXYosGStl4=;
 b=OFskkryq1K/LyMw51Ud6tax6GlFmWdYhC+lHyws8svRCdwGNKuSghiN5hZfLRDjpAvdn
 JQzKhx4Bt7ctNRX1uA4YOe8NuTrLLWDATT90+g0sGJ4SF1bTJ8JB6PXkUP3R+Uuov+yA
 RRAH5U6UxK/QnC2x+IFfqV7NEUpqQK8yS18A7UjauJ0I/89+o0wjoFlQeNMgsq1FQxom
 4ivfehbdnykgkftgGcdbX43jDmpA665OYkCKUbEvITMR7jGjry1HuZ/cJh5wK1FVzv98
 1Cjq6hEbf8C1+mCpN/z+WKhFaCdbF5PzXx6v1MYrjFgLjHwOlg+fLEavWrzK6MgtnQAr VA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyex3gj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 21:46:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BEKTFdN025311;
        Wed, 14 Dec 2022 21:46:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyemya08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 21:46:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WY3ZTrMzZkI8UP2IDroRQBUl57Xm8GW76lISTzTQt4KZPaXDsusTiCVAR+WT/o8IgmV7VCtJBQrN3wcPnwxbaKmfcFZErHKyrdur0fxxSOJqH7JgyGLYreP4uJzwipoZkvv+NJxBeUyB5fiDTPSbmFVaNrbD+pa6tSedoxvOMviso7doqd7bfMmXRP91RYn5wpezk6OWRAcLCYkOYpRNgQ9Ai5dKtq+luAN2h2XP5Zac5NotU7mEYRcf/CzxqiMXbdF5jPVYkzFJNGOYAmwsMH9uX6XOTc63uBLggKOiyVwzh0ebaygpiBe33NAEvnvfYKi6EQ+QTSDxBOpDtkdyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCVQxcn5xfuG2qoVHLb5zOS1maUjNeo6BQXYosGStl4=;
 b=jidfQfCnNYs3pK7W71p1yE+aRylvbrnJf3PJX2KSbs38DLk4sDyT9zfd2RZueAsL9Y6kP7mFhDRE3rTxk+koClx8m9vSW1qFioGj9M5e6P6lbAplD1RFWwDKaM2EO6o3Cke6lMcwRDlU6wirGjHHIZIwZjGuDNXUwKZNQK3zD7hseMyHLE5Ls/VpFd6rj7tET9FdeyNRifpsw38emzF7PbaTZcDDx1GPp7t0KPxKyXxbHqOR8UqM3q6tLAUFeymgyUtMpZJEFviW5l3aUanLzsQg+9YOMhug5G9/uZqDBbJOR2k7A1YyQpRNxTlHOJ4o/GEPOQFBouUO9iD4E4jTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCVQxcn5xfuG2qoVHLb5zOS1maUjNeo6BQXYosGStl4=;
 b=HOsYoZxjGuacLR6YKfLF2POXRpE9CeZYrjxfKPIC8Fa6ESNrNlqYwlAqL+qzPUp05YWdtjMOIkozi+qh94a7EUhSOyh4ezFQ0uwuulVaj5fxhzQRT6tusN9aEhSC/S0dFBdN0UvT7VQ3/tKrO24La/l3bsRZF+5nO7FZ6WKZDyc=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CH3PR10MB6689.namprd10.prod.outlook.com (2603:10b6:610:153::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 21:46:19 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::909f:fa34:2dac:11c5]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::909f:fa34:2dac:11c5%7]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 21:46:18 +0000
Message-ID: <0835453d-9617-48d5-b2dc-77a2ac298bad@oracle.com>
Date:   Wed, 14 Dec 2022 16:46:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Content-Language: en-US
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
References: <20221208163650.GA3225@templeofstupid.com>
 <1e6c1b08-d573-fba9-61fd-d40a74427d46@oracle.com>
 <20221212155730.GA1973@templeofstupid.com>
 <20221212160524.GB1973@templeofstupid.com>
 <d1a2b785-edc7-b7da-d2f2-123d1555022e@oracle.com>
 <20221212220959.GB1935@templeofstupid.com>
 <9dfe87f0-fc95-6c28-6695-62f1f5403df6@oracle.com>
 <20221214180147.GA1953@templeofstupid.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH linux-next v2] x86/xen/time: prefer tsc as clocksource
 when it is invariant
In-Reply-To: <20221214180147.GA1953@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::28) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|CH3PR10MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: f013a2c3-e824-42c7-1304-08dade1ca14d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jCb5gZltI8xdGK5SuoQBWz7q6CwptXP13CZk+SFs+65UVkFG3i+SBzI+xBWxaFaYaeqsnHmc67CaVXwTQA+xgVBkaHGKDXdpMYsXNo8oPGUsN6osOwJVjRZlZiDAUl/t+1h7xRUH1N2qV+tyzJdGup5ZSE9InKdP3ePrgreca5jRuJaYbvQht0vDhcf8xIylNQ54lFwMYdi8gF0j/JMQmCq4BK3ZRucErGqnfWGFbtclVOXjRxZsfP7fQMyjshDxmmLKfkGC6fH1VeAhKoVihA2cm2AzGCJkqiyjQyq2W6cV+DCVH6sLl1w3oyP0JsnWPIMzUYX6t+wKr3QnkqbuWa8EX/K4wRsSUpBzL16/I5T7QWqxc4jrrUnltSZtvEIb1VKFEfkV7B1HdYvOKGRvMLQcXa9+ycb+x/Ukod1faNt6bXbwmCrOOrS1uUMKhmTSlekTshAJZutt43r4xwOkYcY3BI8vbk2Fm73X8QZ36s40fM5fXpEQUazwxu7RZq7VLqUw2Q0VDSeyFg0OO7mfrY0boTtUNBuVep+0n0+9ficgCF7ZgzuujqyPoBGhEJv8+aAbAMZGS4gA66dEZbf3wAZN5CN0FO0CuoKSp7CyUkoYs2hncQKNHATUp0MIUOJ61MZQFGlF5p6SpxTn1QHq4TMyTwowhfmP+Nd77+fkfNVI4p61IhkzMyGh3I6esPNmTva6yQnBA0QN3ZpmkfYJUG6+d+4AB2tejGI9oYIgSE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199015)(7416002)(316002)(31686004)(6916009)(2906002)(54906003)(6666004)(41300700001)(31696002)(66476007)(38100700002)(478600001)(2616005)(44832011)(6506007)(53546011)(36756003)(5660300002)(6486002)(8936002)(83380400001)(186003)(4326008)(86362001)(66946007)(66556008)(6512007)(26005)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEwzM1JtYVFaNHNZRlNab1U2dTZXSDB6aXJINnpnSEF3cVU0OTEvVjRwSGl5?=
 =?utf-8?B?KzlKZndFNjZndDhQVURrdmRXVHV4QjgwUW16cWFsS0hOVG9tSER5eUl1cW5q?=
 =?utf-8?B?MmdqV01JNHRRbDZkRFkvTklMN2RuWmNpcFJETzFTZTk3OHVwM3Q1MFJBNHlE?=
 =?utf-8?B?TjRlVkhicGY3TjlxWDdMNHljUG80ck1PMmE3NHFaY0xNbEIxd2E4a2lPMVRw?=
 =?utf-8?B?dmRiaE1Hb1NUeXpCbkxiZlc2Wk9GM1lFMXlBZ28vVmNRdnE5bWJoYnBBbkpm?=
 =?utf-8?B?SHVMYm1TbmZ1bHgrWUNjSWZJRDBVdS9hd2Eyc2xQeHFQREcxOGEvUDZWd2t1?=
 =?utf-8?B?YU8wd09vUjhjUjVrbGNZY2VicTA0TytiNW5RdkxQNTNRS1ZLM1d2Zmtadkw4?=
 =?utf-8?B?YUlpVmpqMldSeEZNWS84L1V6ZkJVakJ6SURyeW01MFZTbTMzM3hianFrNnQ3?=
 =?utf-8?B?YkE4bmg0NjYvaWljeE5yd0NDaHNOc1YrNUl6MDJkMVlDYkVJOFBock5xNTRp?=
 =?utf-8?B?L0ZTR05OV3pEaS9zTEJGSjNOQzBGNDlXcDJVbWc2djFublpnZy9ENE1kSmdY?=
 =?utf-8?B?eWNEWnVLKzA0TUt1Y0UyNVMxZnFxSmw2U1h4bERQOHhXV2xYTngvME1NQjNw?=
 =?utf-8?B?Y0p4eXNoLzBQcDF5dVZmVzl5ZFhKeHl6Nkw4MEdIdXhUVnN1cEY3OFZZRVQw?=
 =?utf-8?B?SzJMWXVIdENwTUptWFo1VTlLb3VxbnJWcWl2SU00UUZHQnlYRzRIamh2MDN6?=
 =?utf-8?B?S1BzN011WExwY1hHQkxadTlXc1FYY2piZ1ZhcE9XcEk5Y0ZYVWRmNHIrWlhy?=
 =?utf-8?B?R25Kci9May93ckZ2aEZpOG5SbWg5NDZDOVRBMVl4bkoxVk1TaFI4NGtpQjF1?=
 =?utf-8?B?TTVuTVJaYzI3WmxDSHJ0TEE2S094aTVIT1c1RFJ0N2xJWjhNb2xmcld3NStm?=
 =?utf-8?B?bkFBb3YvY3pzekpSOHFDMFRva0FGcWRhRlhWNXVHZlBCT0RzMWlnaGNlT3U0?=
 =?utf-8?B?RUttWGd0L1hGN2U5QTVLR1NpcHUvNFB2M0JwL1ZvMEtwTk9JT3ErQWtaV2FI?=
 =?utf-8?B?Zi92SGV0a1lySC9uSjc1dDZNcHh0V1VoZWZBWmJQMzEyeDRYM0cvZHRGVTRj?=
 =?utf-8?B?TnNCTkcrZkhWd1JzZDlzRUJWczNjVTV2YkRudURJQlh1TDZKdjBlUnltb2pm?=
 =?utf-8?B?TERxQ3J5b1QwTHc5OGM2T0JJWS9oUkh1OG9EWUJDV3FjS3RCK0pLaGMveEE0?=
 =?utf-8?B?Sy9ER1hlbWE0SHBxYzgxRVBjeGQ3RklreFNhRXYvTGNnRHUyUzNmL09VWTln?=
 =?utf-8?B?WGdGVEJISUJWK3NzMStFNjQzOFZQc2x3UmFsTjhCU0xaVXltU2U4MXBrNWc0?=
 =?utf-8?B?ZmpXUFFCMkxNRWlhZWlreGF2V0psQVJmK1FaUlVJVDdNV09hc2NTRHZJNkQv?=
 =?utf-8?B?NldnZWIySmxsUDhBN2VzOTdpM04xZjNJL1BXa1pUM0JGb2FiQkNwaUovdlRX?=
 =?utf-8?B?YnE2ODlFZU53YkhBV3FUMUtZRFRkSUZHZXprWXZwQ3hYU0lQUW9QZFpCRFJ4?=
 =?utf-8?B?czRZUThiQVk0cG44ZVBjS0JKVng2UVNjeHNaWi9iZnhOVXhxTHRneHowclgx?=
 =?utf-8?B?YlZFY3JoU3RlbjRad0NwY2J2WThoalBiZlRvTWxNVmlwUCtJdlJscW9hb0JO?=
 =?utf-8?B?aUlZcXBaaXhJNC9kbURzazRnbXpsRUl5WkE0MHRFbURTWDVZWUZwazFSR1Zh?=
 =?utf-8?B?QmEzOGYzSG8wRUU1TW5jbXpHdmY5QVdpNmhRbStWRnZYVUEvR3JScjdNVTJs?=
 =?utf-8?B?MEdkaU1pQ29KQVRNeVZXSzRtb0xRaXViSU8ra3lKVkpuTG1zK2F6OW9RRjZQ?=
 =?utf-8?B?MlhWR3VnYWZud29KWXRpTStqMUEwNVl0dmg2QkQwTWdGbGFrTXAyNmVsaTJD?=
 =?utf-8?B?bUlZTEZYaEZENTQ4M0gzbm8wUFJYT29BbEpXeEJrK21OdlJBOEU0WnY1alY1?=
 =?utf-8?B?eWdyNGpyYmRIdXU2SHNWUmtNektHbE9NRFRXMHVEVzFSaGRvYy8weWZwSzE0?=
 =?utf-8?B?T3VYTDRMWCtacWVDQWY1UjJYTFFkNUxZYWpYSFpUY3ZJOEJILy9rU1Z3dSs1?=
 =?utf-8?B?OWs1MjNhcUE3MG82eWFqYU81UzlJNGtYNktHNHdRQmdub2tUeDdVVUpFdmU0?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f013a2c3-e824-42c7-1304-08dade1ca14d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 21:46:18.8445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Is+ggaZk+pUlODXOrTH6N9mokkGVccpSInxMjOzfgYcRSvtXHlCN6eb5MRJfHB4npqp73IrYxqOBgBoR+zqXc7MF4sCc8bly9QV8k/453kU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_11,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140177
X-Proofpoint-GUID: ye8L6pcXau3Aj6IckuXspMInE39b2fc4
X-Proofpoint-ORIG-GUID: ye8L6pcXau3Aj6IckuXspMInE39b2fc4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/22 1:01 PM, Krister Johansen wrote:
> On Tue, Dec 13, 2022 at 04:25:32PM -0500, Boris Ostrovsky wrote:
>> On 12/12/22 5:09 PM, Krister Johansen wrote:
>>> On Mon, Dec 12, 2022 at 01:48:24PM -0500, Boris Ostrovsky wrote:
>>>> On 12/12/22 11:05 AM, Krister Johansen wrote:
>>>>> diff --git a/arch/x86/include/asm/xen/cpuid.h b/arch/x86/include/asm/xen/cpuid.h
>>>>> index 6daa9b0c8d11..d9d7432481e9 100644
>>>>> --- a/arch/x86/include/asm/xen/cpuid.h
>>>>> +++ b/arch/x86/include/asm/xen/cpuid.h
>>>>> @@ -88,6 +88,12 @@
>>>>>      *             EDX: shift amount for tsc->ns conversion
>>>>>      * Sub-leaf 2: EAX: host tsc frequency in kHz
>>>>>      */
>>>>> +#define XEN_CPUID_TSC_EMULATED       (1u << 0)
>>>>> +#define XEN_CPUID_HOST_TSC_RELIABLE  (1u << 1)
>>>>> +#define XEN_CPUID_RDTSCP_INSTR_AVAIL (1u << 2)
>>>>> +#define XEN_CPUID_TSC_MODE_DEFAULT   (0)
>>>>> +#define XEN_CPUID_TSC_MODE_EMULATE   (1u)
>>>>> +#define XEN_CPUID_TSC_MODE_NOEMULATE (2u)
>>>> This file is a copy of Xen public interface so this change should go to Xen first.
>>> Ok, should I split this into a separate patch on the linux side too?
>> Yes. Once the Xen patch has been accepted you will either submit the same patch for Linux or sync Linux file with Xen (if there are more differences).
> Thanks.  Based upon the feedback I received from you and Jan, I may try
> to shrink the check in xen_tsc_safe_clocksource() down a bit.  In that
> case, I may only need to refer to a single field in the leaf that
> provides this information.  In that case, are you alright with dropping
> the change to the header and referring to the value directly, or would
> you prefer that I proceed with adding these to the public API?


It would certainly be appreciated if you updated the header files but it's up to maintainers to decide whether it's required.


>>>>> +static int __init xen_tsc_safe_clocksource(void)
>>>>> +{
>>>>> +	u32 eax, ebx, ecx, edx;
>>>>> +
>>>>> +	if (!(xen_hvm_domain() || xen_pvh_domain()))
>>>>> +		return 0;
>>>>> +
>>>>> +	if (!(boot_cpu_has(X86_FEATURE_CONSTANT_TSC)))
>>>>> +		return 0;
>>>>> +
>>>>> +	if (!(boot_cpu_has(X86_FEATURE_NONSTOP_TSC)))
>>>>> +		return 0;
>>>>> +
>>>>> +	if (check_tsc_unstable())
>>>>> +		return 0;
>>>>> +
>>>>> +	cpuid(xen_cpuid_base() + 3, &eax, &ebx, &ecx, &edx);
>>>>> +
>>>>> +	if (eax & XEN_CPUID_TSC_EMULATED)
>>>>> +		return 0;
>>>>> +
>>>>> +	if (ebx != XEN_CPUID_TSC_MODE_NOEMULATE)
>>>>> +		return 0;
>>>> Why is the last test needed?
>>> I was under the impression that if the mode was 0 (default) it would be
>>> possible for the tsc to become emulated in the future, perhaps after a
>>> migration.  The presence of the tsc_mode noemulate meant that we could
>>> count on the falseneess of the XEN_CPUID_TSC_EMULATED check remaining
>>> constant.
>> This will filter out most modern processors with TSC scaling support where in default mode we don't intercept RDTCS after migration. But I don't think we have proper interface to determine this so we don't have much choice but to indeed make this check.
> Yes, if this remains a single boot-time check, I'm not sure that knowing
> whether the processor supports tsc scaling helps us.  If tsc_mode is
> default, there's always a possibility of the tsc becoming emulated later
> on as part of migration, correct?


If the processor supports TSC scaling I don't think it's possible (it can happen in theory) but if it doesn't and you migrate to a CPU running at different frequency then yes, hypervisor will start emulating RDTSC.


>
> The other thing that might be possible here is to add a background
> timer that periodically checks if the tsc is still not emulated, and if
> it suddenly becomes so, change the rating again to prefer the xen
> clocksource.  I had written this off initially as an impractical
> solution, since it seemed like a lot more mechanism and because it meant
> the performance characteristics of the system would change without user
> intervention.  However, if this seems like a good idea, I'm not opposed
> to giving it a try.


I don't think we should do it. Having the kernel suddenly change clocksource will probably be somewhat of a surprise to users.


-boris

