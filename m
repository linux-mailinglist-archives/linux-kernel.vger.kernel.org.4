Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661E67152F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 03:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjE3BY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 21:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjE3BYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 21:24:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED393B0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 18:24:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34TLOOmq010252;
        Tue, 30 May 2023 01:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OAE6NJqMRVXqs95fA9YmcKeGS2QQB1NS7P5Y8lI5dzo=;
 b=X16kv7CtuJ0L8A6zTCPgWR97r70Z71qhIQNIKYPVKOrwSIZw/YQm6cD92JA1oBckbJWq
 Cxw5/8IYnxGM2HZ7SM/efi0XCnnc6rYWHuTaWNvxowD48Oc1ezeGEo3A5+f2kYlRjwuz
 LeBCrLUSuUArMXHUAU0GElNkUWN3Up2S2KK+Bvj1J4u2+Su6+PlLFAcfHyOulb24Ju0X
 UcdNNxNg8km2I28vAuMF4Z+iruyYkwT4yO18BR8OmMWUunATy/K0XSLkpbtDgCOzhNNS
 xwUw/wJQvC7kLr6fnmkwLZrv5wy9CWM6AhZawiRwp3HM4tAYD+4gVAAz7QSvclPMHj2p oQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmjhjqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 01:24:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34TNsoi1030013;
        Tue, 30 May 2023 01:24:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a3t8cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 01:24:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJ4uRGVL2WGpTPs459KktI5mkhd4rx41eIZCkfDVMlYahxcLda+Q0oWALU+BZ7oCxLlGNMQNzAi2gQyHqOikcUQGtg5Iq1y5rEpjkn8e0K2uhYtn7YP+qzaFeOTrjx6NERGuPdAwHkKmiskpNzlaXrS0kWms6YrukB2yLjVImuJcAFIwB+cxfbXX1HSpqFAY+W6yJnV+mxpODg4/epj/ZQF6wXwU3CooeNx9y4cEtepIH6UOsQUEnqfhyt/v3NPl7P/2WIll/Nf4ql198OaFK3ixPM5V3ocGvYNJ+BRAEzlsYMZxf7NpLNwazwEG6G0nf380GJecbGtaiB7UvkzVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAE6NJqMRVXqs95fA9YmcKeGS2QQB1NS7P5Y8lI5dzo=;
 b=bchlcuL98gB0JlUnyhIxw2ziENws0ZOavR7uZCVZBRjjVyLW1VsFIwnUKVdbnEF8t1gGn/HQWklV3atLyagNpuMeAficabAILQOQ3BNd4p+ujTUTpYktXhjQv7f/V0Xmbe8ve8rcC6Zluhiknh/ciABUrz8y4t2QvpBTGBv8zJZiqA5whFdHTuXgV351KxdylUylQG4IgCP73vAhZcLKcGoCGK++uFrvABpf7JwXthkThQhXwt5D423lob4Ql8aEFxn9tN5HsEN8NGg82Ck1cxvNjqk9bVKArR2xNi7yD6DxXqp1OxanT/U9AVkGIWoCFMyptm5jfVMzjJC8rBZoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAE6NJqMRVXqs95fA9YmcKeGS2QQB1NS7P5Y8lI5dzo=;
 b=imzPNLVO6rK90rnXOOlhC+C8pUCdJ1hbCZzp7C1QV72PCMdjaY7TDhUc35eW4HOneAh5hENMSIUIgH3zkThlySKxAlJvVbzlaAp2mY2Nqj1tZPpvFvc2QOv2UwCZOBBrW+UYh210DrkQBMwqR7KioJq3wPutNZP4P16qAhHrOOM=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DS0PR10MB6128.namprd10.prod.outlook.com (2603:10b6:8:c4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.22; Tue, 30 May 2023 01:24:07 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::226:5aa9:592c:5a91]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::226:5aa9:592c:5a91%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 01:24:07 +0000
Message-ID: <a29619cc-4195-75c4-e49a-0e4ab433cf53@oracle.com>
Date:   Tue, 30 May 2023 11:24:00 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [RESEND PATCH 2/2] smp: Reduce NMI traffic from CSD waiters to
 CSD destination.
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     peterz@infradead.org, jgross@suse.com, vschneid@redhat.com,
        yury.norov@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
References: <20230508223124.1438167-1-imran.f.khan@oracle.com>
 <20230508223124.1438167-3-imran.f.khan@oracle.com>
 <c0ca0c9f-a93b-4159-a7cc-b73eeac3fdc2@paulmck-laptop>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <c0ca0c9f-a93b-4159-a7cc-b73eeac3fdc2@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0067.ausprd01.prod.outlook.com
 (2603:10c6:10:ea::18) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|DS0PR10MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8f55b7-37c5-45d4-0b26-08db60ac9039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ew73PvtjQFAZJRPlwZyUBQODJR9Rap3jalNbUQign5ElmbH4Mqkjn7/wzchVZV5ZYFn8MnMEnrnVnpb3VEoWwqiwKjCxMRWCahP4Pkujj7Ob346C4uD/CiAqdw6IW0aUpIGtJ666lwm7OPGdHKDvUOlTTwq6LNkJgNF+Zh6EN/CX0hlwoNYP+drgTF/zOTmNcndu17lhm2jWFsc0RfOQBhiFmg845wTyDIt+SIUrBN+yWR9vgfwzusIwLenp/+3L+RM/+LkrxIZFPif0XmoJxkUCt3ewKueEY3G1MGwA1hG0QP5Hz7Xm78KrP26Iry2WH+9N5OLg+96wc4RBuB8FxqDZYdSrTw2nOxGcrKY43ZMDKwewOwHE9AVFb2bigF+7HSIrZBicEn8BLMJRoKYOcrZlMzxjAdHn1CPPJKDTh7UofKtCEwIByg8LGXNdCPfCZvb1mCpySyIR3In25h6IwjJDj0KfpXl+7Bd1Cl+8+lDDheVaCKLkimS74Ka2TjaNowz+yeIeWTKoNf7jjEOxRR477IH+OBviw+TokFYu3g2nGInmTs5muVqJTWocecxlpZCKNKMaNKuxY7H1LkZFgXevBu30fCklzF4cH9g0YFyRao2qHp3PCRkAPrFidAUtINfXYiP5KxmUM3AZw+g6Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199021)(31696002)(6486002)(86362001)(41300700001)(966005)(4326008)(6916009)(6666004)(316002)(36756003)(66476007)(66556008)(66946007)(2616005)(5660300002)(186003)(2906002)(53546011)(31686004)(6512007)(6506007)(26005)(83380400001)(38100700002)(8936002)(478600001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVnSXUrTi9EQmh3VlRuRVB6ekdaZGFQK2Y0RktKN3VIU08rM28vb0VqOXNy?=
 =?utf-8?B?N29VZnJDbVNpSFFIODMwMDlFS0NWSzdPc1NHS1J2OGpKano2ckxYZE5wNlhn?=
 =?utf-8?B?UjlzaDJPTkRmUyswM0VBVkwwTjlhdThvNFBtNnNxb0orQXZXbThPd0RxNURy?=
 =?utf-8?B?NUNFWDJYWXNkTTlhTDdhZ3RGdEVZU0Z0UzQyRG1PQlp2Q3ZvSXpXYjJPZVBV?=
 =?utf-8?B?STd2TVZ3SGk3MEVEZGRlOXIzRGl2d3R2MnZiQUJVbFJKa2huQUMyVHBYc2JE?=
 =?utf-8?B?YjdkbFo4QkMwQ3pEVlR0QThUUkUwN3Z0MVdOQkZxUmpJUnFPQ3BlUlhUZTlw?=
 =?utf-8?B?bndyazZtVzdIYWIwaGdtcFc4TGlxN2F5cmRDMWdnSUoyZkpYVE9LYjI3Z2Z5?=
 =?utf-8?B?ZGlsS1E3WVdmVVhIVUJGZklaamloVXk3OXlLNjhZdUpuUDc1dFFDSHV0VEsx?=
 =?utf-8?B?clRzUkdTeFMwODFXaFF6dzNKQVNDRmZJSEJLT2pSeFplTWx4Z1pIbHQyd2NE?=
 =?utf-8?B?aDl5elBuNDlCSWhBZENEcndGQlZvYVNJYVVreHdsOVdKa3FGVW5rRm8zTW5E?=
 =?utf-8?B?Um1VRWgzT2NpQWdWTXY0c1Z3V1Ixc20vclg3RHFEV2kvOTJNTWNLeHI2RU4v?=
 =?utf-8?B?ZlZHRkxxSFVhL04rOGYyQmJEOURDYVZIUXlTR3FYZ1lDc0NON0RGd21SaURx?=
 =?utf-8?B?MFdQOUI5dE93dGR5N01jTjVWKytHWTc2bGNGZ3dVWXlXK2JvdmRsS0ZCdDlZ?=
 =?utf-8?B?YUE1VjAyL0hrUUI3eEdWZm5zc0hLekhFNDNTRUpLZ3VURXN1eGV6elRCeFNk?=
 =?utf-8?B?QUdEZ0puZ2dyTUgvYzR4TXVSRSt1blAwcGNlQWQ2RlJHRlVjQ3VqdUtDeit4?=
 =?utf-8?B?OG5wanFYV3lLOWFoQVVnN25id1BzK3U1a3JGdytRMmNPOXZKK3k5ankrWDRt?=
 =?utf-8?B?djFacVVPaUkzdGhPa0RmOWZsVE9neGcyM2RCV1dwdTFYOTRxaDNwRzF6Ymk4?=
 =?utf-8?B?bWNUTE5VeWFnWVdrRVB5YUtBMkhyajJ5TC9qaEFEME1qVGY1YVlGYjREdHdu?=
 =?utf-8?B?QjVPVXIvU2xSSUZtQmxtaGFxcS9vRTFIS3dVNUd3Vzc2bXFOTGZnWG82VkVW?=
 =?utf-8?B?QXNBT0c0clV6WVZzU0Vvd1RVTjRqSmY2dUNkK2Z5TmxuazJCQXpKQ0IwOW8z?=
 =?utf-8?B?VklxRE1aby9jNzFiVGJ5ZXpkU1p1N1RqenF1MFowYjdFMjF3MXpYRVFKS1Ex?=
 =?utf-8?B?Nkc3cDYzZWlLVFZJZGxyZVR1T3paZkxwVGxCd2U1NXpzbFpsOTJWR3E3SVBk?=
 =?utf-8?B?V0NxVG9XWVZHcDUzQXQveFhjOExqSExISTJqUEV6TzdVbUt1MkNYV093OU53?=
 =?utf-8?B?VHRIMkh3V2kxL2J3cmp1NzBHcVk1d2NQSEhjZ3g3aHRHVW8yaExaQnU2R3hW?=
 =?utf-8?B?RzZ2UFE1YUxzNVFtSndwcW52TUovSkZHdXM5TTE5c3V3dnJSSmExbmpnYXFy?=
 =?utf-8?B?UjMyL1lqd09pTXZETjFMZlpmUTkwNjgrWWNkRjVlczdnV2tPUDlDd1ZQN2ZY?=
 =?utf-8?B?UFlUc0tEMW1iSVJKdkxjSTZlSVhoU0Vrai95NkhnWXdFM2IzSVZJa0JSVFdW?=
 =?utf-8?B?UEtJd2Vjd1NhallnMmVrQTNqWWoxcUx5aGhjSDRMT3JUb1dJOG5HMjI3NElK?=
 =?utf-8?B?bndNVm9tbUcxdGJaWUpJSDljdDV6R0xVYVQ0eUlsdTBoWWN4UG94VUFkb2JF?=
 =?utf-8?B?Uk55Z0NFQVF1VVdxRUw1Z2xyK1ppdlNoeEZTaVdVN0k4Vm9mYTdsS01MSU4z?=
 =?utf-8?B?aHE3ZmpVY0FhZVgyWEh4cjJkSjRJbGJycjVnN1VjYWRsWnRTbTBjNlZ5aDdR?=
 =?utf-8?B?M0RDcjJtS1V2bEF2cjdRV3RJeHVMMUY1WDhCVzkrQUh4OFhuMjNaaWJEOFE3?=
 =?utf-8?B?NVo5RFF5NHhSVjFGL2Y3VkZHZjZ5L016UEZVSldHRmExM2x5K25nRndqTmZU?=
 =?utf-8?B?OU9pWWs4K2JVTEF6OVNzcXRGM0diaUlTdVFxQmtEZksvc0x6VG1lK2JHdTVl?=
 =?utf-8?B?VW4rMHA1R3UzRHhMdTJwcndaMlZnMU9xMmNMcTJBeHJWKzlnRk1DZ3RZR3du?=
 =?utf-8?B?U3pJcjY4Z1dkalIyeHdoNlQvRS9mU3ZBc0t0VWpiVnNpWGhIb0xVeVJRVGJY?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a21ISTRKQmRkRG1McGNiS05ESFhxVXRoWGp3YWRvUW1ZbHc1WnlNem5hT1F1?=
 =?utf-8?B?ZmJTRDRTUEc4YjdVWnRKMklaV0RpdUtIRk5GVzUxbDR1b0ZWZlpqTGhMTkpE?=
 =?utf-8?B?VzVtWkQ3cXJYa0hoTVlMcEx6L0l2K1c0bUVRbHJCNnhtVy9JZnZ1aDI4T1Iv?=
 =?utf-8?B?dXVHMzhRdG5ydHMrdzB0ejBOZU5NandpU0RmYUgzZmlLY0JMZldpcmwyVE9z?=
 =?utf-8?B?S2ZBK2h2dHQ2WEpoOUxLZDIybWFaWTd2T1V2MzIvWVlERW5GTUNLTk9CdDAz?=
 =?utf-8?B?ZkRzMU9PSVY1ZjhiZ1Fsamo1Y2lQdXR3K0tYaGdibXBQVlhEUjBLNVZ6RlZW?=
 =?utf-8?B?Sk9yZFByUGZaOFkvWXdoUVhONUp0VG5nL3VPQzJlSjNKZEE2Yk9CRGpmQ2M4?=
 =?utf-8?B?dm82ZWlrY0IwWUdMWmhYdVZtbHJ6UjEva21QYWEzTnk2RUJoUmJoU1dmUHZz?=
 =?utf-8?B?a3FlRzBhZkdvd1JkaXlSZmZlM05aUm9paUVCTWlYMXFFVE5KS3Y2b3Jxa2hI?=
 =?utf-8?B?Vzc3Z0l0Y2VEckl0dk9vOTVzSmRYWWZjY0d6dHhBLzE2S0NpZnk0eUJBODdl?=
 =?utf-8?B?Y083eEdwVDROZ3VaZXdoYTVCWE1ORUt6RExuOS84WUtKZ01QdmZTWEQ1d1R6?=
 =?utf-8?B?VE11RVZiWm5URElWdG1Kd0FaQkcxRkVTb3o5RE91VkdHeWx2bnNpVG95ajVT?=
 =?utf-8?B?WHh5b0dkdWtZMFRDdGdtUmZsd2h1OFpyNmtZVXdZaHV3UHdhNU1OdmFGU05E?=
 =?utf-8?B?ejBMY1Z0QVlUclBKYjBISDEzYXRWT1IvMDVweGR6dmdZN1diN0JuN2EwbVRi?=
 =?utf-8?B?clVSR3VkUzVNdS9kVDJOUmVFUUoxUm9sbWpsbjJjOUFKYVk4R1Rxc3krOWpJ?=
 =?utf-8?B?c0FEWWgwWDBjSFFjRy9zK3BhNzNnN1laWUtqWkhXN0V0N1hCQzdRNVk5UGJK?=
 =?utf-8?B?bFpqSisxc1Nnc1lKN2RodHBGMk9obGpoSTFvNmY1TDdTc0ZRUkFrekxNSEF5?=
 =?utf-8?B?MkxTMDhybnl2cGN0L3FaUXF1cEN5bDNxVFg1c2F5Yndlempzb2dxQXlhY3VZ?=
 =?utf-8?B?L0lzNXA4R3lLcEd4djhrSVM4b3J0bkUrRTZINndBVmhSanlpaFVRQk5hQTQz?=
 =?utf-8?B?T1NSbWV4dXR5SW0vTStLWEZFZTZ6TzI1cFh6dUJlWTlwanhvZmlLMVpxT290?=
 =?utf-8?B?aTlZaHg3WStIT0ZhT2dxWkJTNExZaUlNdHBXR1RCT0JwRzA2U3AyRlhkRGpC?=
 =?utf-8?B?U1EvdTNZN3NpcWoxU0doMkxDYWk5c2ZtUkpFTzlnVWZER1VSd0ZRQ2RaOThp?=
 =?utf-8?Q?axTnA2QoV9eusBxotnRAfp+Rto6fWmm+3M?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8f55b7-37c5-45d4-0b26-08db60ac9039
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 01:24:07.6139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSpBVR8PQ4EcTnxcmF29YFy8O64ULwIWfErkTUvPkJI2XG1tJXeqI9Wes0PPkWWVZVinG/fACBtQiCre9xv1Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_14,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300009
X-Proofpoint-ORIG-GUID: jXSEi27pTCYz-hS_BkAgCmgtAn8R2uab
X-Proofpoint-GUID: jXSEi27pTCYz-hS_BkAgCmgtAn8R2uab
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

On 16/5/2023 10:09 pm, Paul E. McKenney wrote:
> On Tue, May 09, 2023 at 08:31:24AM +1000, Imran Khan wrote:
>> On systems with hundreds of CPUs, if few hundred or most of the CPUs
>> detect a CSD hang, then all of these waiters endup sending an NMI to
>> destination CPU to dump its backtrace.
>> Depending on the number of such NMIs, destination CPU can spent
>> a significant amount of time handling these NMIs and thus making
>> it more difficult for this CPU to address those pending CSDs timely.
>> In worst case it can happen that by the time destination CPU is done
>> handling all of the above mentioned backtrace NMIs, csd wait time
>> may have elapsed and all of the waiters start sending backtrace NMI
>> again and this behaviour continues in loop.
>>
>> To avoid the above mentioned scenario, issue backtrace NMI only from
>> first waiter. The other waiters to same CSD destination can make use
>> of backtrace obtained via fist waiter's NMI.
>>
>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 

Thanks a lot for reviewing this and [1]. Could you kindly let me know
if you plan to pick these in your tree, at some point of time.

Thanks,
Imran

[1]:
https://lore.kernel.org/all/088edfa0-c1b7-407f-8b20-caf0fecfbb79@paulmck-laptop/

>> ---
>>  kernel/smp.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/smp.c b/kernel/smp.c
>> index b7ccba677a0a0..a1cd21ea8b308 100644
>> --- a/kernel/smp.c
>> +++ b/kernel/smp.c
>> @@ -43,6 +43,8 @@ static DEFINE_PER_CPU_ALIGNED(struct call_function_data, cfd_data);
>>  
>>  static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
>>  
>> +static DEFINE_PER_CPU(atomic_t, trigger_backtrace) = ATOMIC_INIT(1);
>> +
>>  static void __flush_smp_call_function_queue(bool warn_cpu_offline);
>>  
>>  int smpcfd_prepare_cpu(unsigned int cpu)
>> @@ -242,7 +244,8 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
>>  			 *bug_id, !cpu_cur_csd ? "unresponsive" : "handling this request");
>>  	}
>>  	if (cpu >= 0) {
>> -		dump_cpu_task(cpu);
>> +		if (atomic_cmpxchg_acquire(&per_cpu(trigger_backtrace, cpu), 1, 0))
>> +			dump_cpu_task(cpu);
>>  		if (!cpu_cur_csd) {
>>  			pr_alert("csd: Re-sending CSD lock (#%d) IPI from CPU#%02d to CPU#%02d\n", *bug_id, raw_smp_processor_id(), cpu);
>>  			arch_send_call_function_single_ipi(cpu);
>> @@ -423,9 +426,14 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
>>  	struct llist_node *entry, *prev;
>>  	struct llist_head *head;
>>  	static bool warned;
>> +	atomic_t *tbt;
>>  
>>  	lockdep_assert_irqs_disabled();
>>  
>> +	/* Allow waiters to send backtrace NMI from here onwards */
>> +	tbt = this_cpu_ptr(&trigger_backtrace);
>> +	atomic_set_release(tbt, 1);
>> +
>>  	head = this_cpu_ptr(&call_single_queue);
>>  	entry = llist_del_all(head);
>>  	entry = llist_reverse_order(entry);
>> -- 
>> 2.34.1
>>
