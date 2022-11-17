Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D2E62E3F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbiKQSRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbiKQSRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:17:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7D5B64;
        Thu, 17 Nov 2022 10:16:59 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHG9aLj014158;
        Thu, 17 Nov 2022 18:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7bbFgRz1YeIqB7xC65fxXxuWX+a9V+QR7L+tcZiXg2o=;
 b=xUtDaZwWWx1Dvrg5UEn5PT5VVOaKah8Gtn6OzQ3zBb7H1BfciWUSMHP5u/XTEE4LAaY6
 2l8lEsdqZwIJbnGk2aiu+8OzK9MAFf6XVYynFo8NmHm8XHCT8M9OXBLvCzP232JLP98y
 hWTrUlRvN3GQGlq3utnccrksbxqhVzY/0q1PmWgJZ99RgP2eB/hEOn8fSg4P8u9bkx0i
 m+dpOIAVVzqseuc4q28XKOzv23TFW+qlQW5Mhnuj+nL65mKgoQIhCOykXPv7wkw6V67c
 IHJDCEJsQVIRYPHkYttLY4/XqVbjY+tYo0ys8zC1uObNo+/vIvIRbcrxyx+JBCk5M1Y0 TA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3jssyhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:16:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHHJwdl004280;
        Thu, 17 Nov 2022 18:16:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x9ebfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqAi6UTy4syKOBta8oo3soz1knf8vr5DLZBUTRY9i1Xiy/kNrHtIjrBOMDOqMxVFjHdMUHsR3CtU1BlmQwAsdLdfrwFmw8l/Vh6n5gKkibT3+MvT3l/pUSOG5Qb6Ou8zRYOL5T9SuFYMDeYwf/XqYMWcWN5cDp81IuLRN4JG2NWHdQgSk+l43+BbZ1C1r4VRX0Xjo7lLCx1uFrXPZydHbpSeR5OzsVrGpUr3YCy+DXP0hU0eC6NHA/W+Fn+4QtIr7vi8CBpX6laGHNBGJtURNzVmXiXgVVDjrkrm2ovoYcpHTJa0Jvf/27LJ27d8WiN3Ol25T6HvAUBYd5LH/FNOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bbFgRz1YeIqB7xC65fxXxuWX+a9V+QR7L+tcZiXg2o=;
 b=FFYMDMIzK8WueivWMlx8RTYu+dJYR6v8cM+3vUO3xBmqkZ0oUs++8JQCLLodOhCzS8rTVRdBmUXRyEzje54iuL01aaVjMLZVhfEZ10GR7sWGNzHh+eECG8wDuAVd4w744sLN9bkkz+xQJ3Fg1u1HiBN17ZHex9PzpaxXK+S2MdEEKyk51lyxsvpTKiGM3JKnoStfGnLmkt9vYwRUQTIeRqVowh/gatkvdLVGfqsY2yIljcPalOC2LGiMpXLxO+7eJEaUcyt+ySHWoUiJ4b+zhuxGROxUy8hYagZTODLdD90HyIBlQ5VU/bkYgutkVA73paRe7YCZWyMH2z1kY3Y7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bbFgRz1YeIqB7xC65fxXxuWX+a9V+QR7L+tcZiXg2o=;
 b=JVI8zXIW4JabWUo/ws0D98b18kbwMXFvkbViS0HRF+NmO4P/xojbR3dssxO7CaJLG12CF3sJ/oDeUyBIdgqp90YYtUr8qiRl398Za378PYgvlzy04LXhi/2g87SgQJhm5BpXnhmyuMo8CNhTXC5FiV+lO5RGURhLPSgaW+pFXso=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB4844.namprd10.prod.outlook.com (2603:10b6:610:c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 18:16:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b%4]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 18:16:37 +0000
Message-ID: <259f8e47-bd58-c8dc-c3fd-12e8dd5d013d@oracle.com>
Date:   Thu, 17 Nov 2022 18:16:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [External] : Re: RFC Re: [PATCH v2] perf jevents: Parse metrics
 during conversion
From:   John Garry <john.g.garry@oracle.com>
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20221012164244.3027730-1-irogers@google.com>
 <CAP-5=fW5+boUZqJV6-6VVa2bOcTrErHU3K5Fz-Z54j8uq_kfdw@mail.gmail.com>
 <Y21Hdoc8KsvNMbTQ@kernel.org>
 <CAP-5=fXbjk31SvZNVzo5x0uDnVndw7Z=BFPah9Dgx=AULkTPaA@mail.gmail.com>
 <f3e704f9-988c-e01f-eb40-13aa405e2857@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <f3e704f9-988c-e01f-eb40-13aa405e2857@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0112.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB4844:EE_
X-MS-Office365-Filtering-Correlation-Id: 53078536-5fb2-4d25-8052-08dac8c7dded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GeSALU8NZBERFx3907nt/FkuyYOfGRvoCv6girRS1xsgJ089wReHY+xapkGIVVcS0wukR5pY4GJHbfrfBoiLxTCeeiSP97gLxEUa5QAVAnLjrNIsaVvMBseNL+bueJrRIZPVzMEwLUQxL3AKPQuZWhO5DnWV4MCWPmf9t0y05d3CjDwH8bqZR+AekWG12H6Rbbj8ZOXVtb6BkQuCbWUlFKOcPI3lQLXtuWaYyGMY7oZX4Nmwd7Ge2HC93tlU6R38aMiGdrvZW94bfGsAKIKDcVNlQFUteW27K7r9tDjKcWNQjKUbDkId3LmdCk21zlRDFcQc66hGiIkIKrM/vjPqKVbkxgCJ8t+mDMyZs1sZdyT4t2Y1ngBbXECVoyon0NvkujysQpz36NlSmDtABuClqgf50kKwWm/kIPhzxMEhXMoqWntrAXGmGMng6lewFEm/3G3aEVur0BdOo1xXpMKLgle2D+jKHTt4BrVR+MXK2dAkJALSMJ7x3EDR0oDnHFAIuGNpG7qRkCFnbLSUUJy2bG9u1jGJnPKTeVJQ54HTB4fsSpGZS9MiOjEY+6ZlveKD9tXOEmh4J49KgdGFxDgGQHIU/d8qhgukoKt3u3PeHjFfIuy4D7+mMkl8SGua5xe5NMfRopItHMOcKaIFl7NAxkbQ5z21+KIR7Lyw61RKV17JnBjHhD9Mt/eCEHRREdEZL2sLGpXg3kIVpHpc2ycB5JeoJ6wvsF16WIyAjpUdiiE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(31696002)(86362001)(36756003)(186003)(41300700001)(2616005)(66946007)(66476007)(8676002)(66556008)(4326008)(5660300002)(7416002)(478600001)(6666004)(6486002)(316002)(8936002)(36916002)(38100700002)(6512007)(6506007)(54906003)(53546011)(110136005)(26005)(83380400001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDFnbGFaMGlpVVdZK005bnNIRDh3Z3h6OWJiWHhuM2ZqWTYxYXNuM2tacWN1?=
 =?utf-8?B?cndFUjU5TDJ6R0pmbkk5RGQ3RWowd1k3c3BQd1hxbWowRjF3Rjh1WE5Vd2hn?=
 =?utf-8?B?OHVPa21Na3UwU2JiVnBGZEdDQ3BnbVp4ODZHMXo4UENFM0Fpdk01eEZsV2FO?=
 =?utf-8?B?anZPM0tNbFJkZm9WNlU1U1h5ZExEQTF3OXhuOHhQQ2IzNXlDYWZ0UGUwN0RK?=
 =?utf-8?B?M0pwNlQ4YS95dWg5QUp3ejNaek9xS0FLeFZPRFVYM0p1Y2FKSThtQmJHQVJL?=
 =?utf-8?B?bEFwclhaSlFUREZNUDlLNDFHQU1xZ3BtVlAxdUtHOFNJOXBtQkJlcUZmUmc5?=
 =?utf-8?B?VXZnK3ZpcDVNN3g0VlFSb0RJN1QwVmQ5cWlGZ3NNdXZtNkhvMjUzaWRSYXlT?=
 =?utf-8?B?dWlVS2RTNFYzR2xWNHp1WUlGc3hqVCtKalU4eG03TmRRQTdKcVRyNlkwQWZQ?=
 =?utf-8?B?cVRBbFJZRWNxRWdId1ZpUmNpL2JMWEpJYW5scGpwZXlpb0ZnL0tDNlhHMDhS?=
 =?utf-8?B?VmdKSzEyUFJpbkM3UGZyaHZBUmdDRklwdzUxS0wwMFNpUHdaMExwUzFnQUxT?=
 =?utf-8?B?dmd4R0E3UEFWZWVqaGJNWjBUM083clorVGhveUU2SzQ0bnhRTXNneXRBN0JL?=
 =?utf-8?B?UTRrOGsxb3JqMm8wWFVOL3FzTHU0USs3N29COXFia2Uyb2x1bUFrSUMxQU8w?=
 =?utf-8?B?bnNYejlxTEJSL3pUZzVsUUZ3TllOZDhmcUVUZGVaU3dHQTF4QUhwdzhvTTJz?=
 =?utf-8?B?U0lqWFMydlkrQjdVUzFLZjVidnljQzRncmYxQTlrcFAvczh5WVdHVk84OGNN?=
 =?utf-8?B?UVl2djJHOHBzd09QeGYreHVRNjdlSDVXTHl0akZyellTZ25PZ0ppc1BEbTRh?=
 =?utf-8?B?ZUNjaHVKRGRQVUpIYlowTG5ici9LTGQvQ0xIMHBhSmNNci8wdVZrV0FEWGxq?=
 =?utf-8?B?YUVHeGxBQTUyekNFelAvckZ1Y2YyK3YrTDMrNXVyTmphNzVUQzB3MG9pSHgx?=
 =?utf-8?B?eUZpWnlCaWtnSk93cEhUMFNKZzZTdjFXQVh6VTR5ZE56QmExL3NNcEMyNkhT?=
 =?utf-8?B?bUcvK2w0UDFqbDdDQmJ1Z0NlRXJYT3dLYnJ1eWM4VXJZWWJDeEZZbDhDd25H?=
 =?utf-8?B?RUpZNW1tc2xkeEZQT013VWJRUmNHZFkvRjVVdFA2L1crZ3J0RWZHNTM1TmZD?=
 =?utf-8?B?am5vc0t6Y2sxMDdpNWNhQkhtU0VpS093S3d0a2NEZmE1ZXF0TDFheEVDZURS?=
 =?utf-8?B?RWlNUWJGdEQwWkJzbEV4QlM2LzJIWm9JTDhOM3IybU0yZG8wMGJGa2RieGM0?=
 =?utf-8?B?QUpqNEJYdXNDbTMzN2RVZWl4MWFpL1E5aUVOMzJCZ2lBWms0MytHTFd1dFRy?=
 =?utf-8?B?T2lNU24wVUYvcm1MS1VkNXlDQy9MUDFaMlpYYUs5NzJBZ1N2eEcyeFY4bitl?=
 =?utf-8?B?cjdxWWNTRGYxR2NMWHl6S3FrTGxTTjBrdzYxeTJxc2k1ME5qYlNGZHZsNlpS?=
 =?utf-8?B?emxyZWlCems0ZDFFbG8rVFFPcS9YRmpTQUlQZzFJS2xOU01qNUQ5U2VRN3Fh?=
 =?utf-8?B?bTNZWm9uZUdQZjR0NWZRckpmTTIxVFlwZWYxelZaRUZKR2dZWlRXRW5rZEY3?=
 =?utf-8?B?VTR0NWsraUxDR0VjeWdQNDJQLzZkaFpYaFBBblA1emFKay9EeUNENHl2Rk16?=
 =?utf-8?B?bnZIb2EweDNod0thQ3JyNXp5ak1CakY5dXpBQ1FoVkkvei9MZVJKd3VPay82?=
 =?utf-8?B?eUdXQmUvTllPZUpDcVYzU2FDZjBFOGJhYklnWXRDVDExVlF1dVBqY0s3bHhS?=
 =?utf-8?B?VXJnMkMzOHFUT2JzdkhmSVBUQkdLZVlhN1VZZnp3REZ3SXRadlhUTlRaUEU0?=
 =?utf-8?B?Q1lUUytzUTBrV0FHdzBYZHRidkx5elJIbkZmK21zWjN5bWszUGh6dkhOeFpn?=
 =?utf-8?B?dU1tS3ovbzRqY3JkL3A1bng4ZWdyaXZmcFhXNlFVdU9kR0FJSEFOazNIVzFF?=
 =?utf-8?B?ZDd1dW9uYUYzMWVGZkNScnlycGpmbFprNnIxMzk0QkZoS295enR1cXhRL09F?=
 =?utf-8?B?b2d2SFdCaDBjMlh1ajRCZytvcTFSaFJrYitSQ1hJNEl3Smo4VlZraW1iSnA2?=
 =?utf-8?Q?IxkiGEm0dDSkAK8S4it4oZcvK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Ni9aTUtJWmxEMTZJdjJTdDVFMmpMamVHVXN5SnVDSCtHVmUxeElWWlJ2VEtH?=
 =?utf-8?B?K3QvSHVzNHRIa0t0WnJ5UTBYb0FxWlMwL3RqcUtLVUFlQllqdm9ZT1kydEpz?=
 =?utf-8?B?VFM4UDJBcFJyZ3RyeEwyd3dVNmF6N0VTRmx4cXdvc0xxci9UY01Ta00zcEIx?=
 =?utf-8?B?Q1ZNa1dNaGo2MkY1TG9BOTNyY0RvRGxsMmc2Nk5wbXBIYzNkQjFBRTZ0cnpt?=
 =?utf-8?B?OEl5RkNmU1kzM3JxT2htUm4zU1lYS0xPcjBvL0xxZGdYNVJZTzhCMFIrR3Vi?=
 =?utf-8?B?aGRjNlN6c0JkbVVKRmFOdFVhYlhqKy9QQ1ZCVkx3K0xUeGFFRHNaT3RORXJx?=
 =?utf-8?B?T2RMeE0ydFNlVTJIMEVzd1JrSjVNUmRSRnJQVW9SQTJrazRTVFpjTEc5SXNs?=
 =?utf-8?B?Ny92RkNWcUtaQllKRHUwM2lLeXo0TW5qWS9vOUhMWkc5VXdXU3lTT0kvMXpO?=
 =?utf-8?B?SUd3L0RkanhFU0trQm81WmFvam1yNFhXdGdqSjJSZENHSXEyTUx1Z2MxeFRS?=
 =?utf-8?B?TlJNVEtaa0lIU1N5bEhNbW16L0JGNnNzWVZOSk1lVXV2M0oxdmNNdkJkc1VP?=
 =?utf-8?B?bE9ET3Z0UWJpcEZmWTBjSzd2YVpORWI4elpyRE9yb0VLb3JqdUZXc01kN2xK?=
 =?utf-8?B?NEZHVndkNHhzWEl4TG9sc0FEbG4xT2ZtZjBnUFp4SEl2d04xQ1FlaVBEdmVH?=
 =?utf-8?B?aENlSGc0eC9tYTB3TngyYWE0aUdXbjlDY3dBcUNLKzUxVWtKbjFJRHllcFdI?=
 =?utf-8?B?REQybkk4OENNV2lmK0hPNjU1Z2pSNi9EdXNpMlp0RGlPdFQxd0ZGTXJYaG5O?=
 =?utf-8?B?WlVNaXdlZFdRUXRGWkkzK09oRUFLUnJoNHk0UVgvNU1sYjducTVhekpYVkYw?=
 =?utf-8?B?aG56ZGMxRkFCaEpsQXhQWDNXOFZXL3VGOVc5bXVYc2NwQ1dvMzJGS2RIOEkx?=
 =?utf-8?B?QW1tSEVhdDdPU3ZmbVRFb1dyREtzUU54WjVYZVkxa2tRNk83MXJNYnU3eW5N?=
 =?utf-8?B?K28wSXRyaWFOWE1jOEVxbVRzNHU3WGFpTzVWVkZXOU9hTXh6b01LOXhsSkcv?=
 =?utf-8?B?SEdEUUxna0RHTUVodlprL3dQYkZjY09LdFVKT0I3ZDhjT0VWbzBHYjlYekF6?=
 =?utf-8?B?bEkweVlnaklXODRxNXd0ZXpYN21mMjhpTDRSQSswOHdSZVo3WFpDcTIwWUND?=
 =?utf-8?B?eTFlSjUrbjRlQkhCTmVTMUFTOTB5ZktVbGw3NUtkWURaOUVmYjFDeFM0cFR2?=
 =?utf-8?B?VkE5cGJ4WWZyZkhSdnF0dlFGdzRYZFlpQXg1V0hrWnUvYkZMbmFiQXY1eUJO?=
 =?utf-8?B?UnVBZWNDenVmOVE3enA1Q0djdFFXQ0dHaEFGUFVBTlUrekU3SWxOV2hZcEsw?=
 =?utf-8?B?KzlacnUrdDV4ZWZRY2c4TkFPQjRZaW1Objh2MU1KK0pNOFhtM0IrT0g0YUVo?=
 =?utf-8?B?TndoWjBuYjNGYnB6ZWoxc2FyeVNhU3JnRDhVcFVndElsSkZXMVcxVnYxTzZB?=
 =?utf-8?B?REdibmxTcTRFNm5hemx2RFc0Yng2bWxySlJFUWo1R29QamFxOEtjd1dvV1Ni?=
 =?utf-8?B?RkZ2QT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53078536-5fb2-4d25-8052-08dac8c7dded
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 18:16:37.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jxi2eIET5kfKvTatEf6O3CLrOSqdV3eJyNHqqvL+28pt1mZh2hnzpcRRZ6nvKZrerIAc3rGa3RDiRGSYDnSRnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4844
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170132
X-Proofpoint-ORIG-GUID: pDdtTi6VcUdd04uXPjkhWOTUb8Baan0m
X-Proofpoint-GUID: pDdtTi6VcUdd04uXPjkhWOTUb8Baan0m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 17:35, John Garry wrote:
> On 15/11/2022 17:26, Ian Rogers wrote:
>> On Thu, Nov 10, 2022 at 10:48 AM Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>>>
>>> Em Fri, Oct 28, 2022 at 10:57:02AM -0700, Ian Rogers escreveu:
>>>> On Wed, Oct 12, 2022 at 9:42 AM Ian Rogers <irogers@google.com> wrote:
>>>>>
>>>>> Currently the 'MetricExpr' json value is passed from the json
>>>>> file to the pmu-events.c. This change introduces an expression
>>>>> tree that is parsed into. The parsing is done largely by using
>>>>> operator overloading and python's 'eval' function. Two advantages
>>>>> in doing this are:
>>>>>
>>>>> 1) Broken metrics fail at compile time rather than relying on
>>>>>     `perf test` to detect. `perf test` remains relevant for checking
>>>>>     event encoding and actual metric use.
>>>>>
>>>>> 2) The conversion to a string from the tree can minimize the
>>>>>     metric's string size, for example, preferring 1e6 over 1000000
>>>>>     and removing unnecessary whitespace. On x86 this reduces the
>>>>>     string size by 2,823bytes (0.06%).
>>>>>
>>>>> In future changes it would be possible to programmatically
>>>>> generate the json expressions (a single line of text and so a
>>>>> pain to write manually) for an architecture using the expression
>>>>> tree. This could avoid copy-pasting metrics for all architecture
>>>>> variants.
>>>>>
>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>
>>>> Ping, PTAL.
>>>
>>> That would be really nice if people working with JSON, metrics, could
>>> take a look at Ian's work and test it with their files, volunteers?
>>
>> Perhaps John could help?
> 
> I'll have a look soon. I have to admit that I have not been tracking the 
> jevents changes as close as before.

At least I can try to test it... so we support python 3.6 and later, right?

I have 3.6 and acme perf/core generated pmu-events.c is ok for me, but 
this patch causes an error:

   GEN     pmu-events/pmu-events.c
  PERF_VERSION = 6.1.rc3.g39b7ecfa5b4a
  GEN     perf-archive
  GEN     perf-iostat
Traceback (most recent call last):
  File "pmu-events/jevents.py", line 7, in <module>
    import metric
  File "/home/john/kernel-dev2/tools/perf/pmu-events/metric.py", line 
399, in <module>
    class MetricGroup:
  File "/home/john/kernel-dev2/tools/perf/pmu-events/metric.py", line 
408, in MetricGroup
    'MetricGroup']]):
TypeError: 'type' object is not subscriptable
make[3]: *** [pmu-events/Build:26: pmu-events/pmu-events.c] Error 1
make[2]: *** [Makefile.perf:672: pmu-events/pmu-events-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....


Any idea?

Thanks,
John
