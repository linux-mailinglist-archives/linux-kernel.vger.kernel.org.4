Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675765F62A5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiJFI3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJFI3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:29:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E43101DA;
        Thu,  6 Oct 2022 01:29:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29686GNQ017448;
        Thu, 6 Oct 2022 08:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0TDHEx4w9TvdZ7mkqNVbaAOoWqnF8u6ZmNejRYw9YHc=;
 b=MZm07CKQoB1Bo0LTpjBpv3/WVD7D7MMBhqfxmQ8gWtOzsYFQgI+63tMOWzdGG6e9dtxk
 oUvNibdGELstHmCCjepMhr54agFDyR8FBwmwCW9w2g7zVSnjqOrHOtuE65uosyAls9RG
 cRS88mVvJxZLgMYa/ldC985Ng4EVCAShWwxr6l2n40aFhIg1olzfCpRSkGAhJ3uoIRJE
 KS1wCmxz42vWFXy0IONjM7ZtwUYCtYs77RgrVkYG+mZsSvYWTKR1DF//o4Mm6vGPOqNv
 mKZe3oJN9fDZeby/dUrfoeI2B/Lzng+RZu6ivqbncwzotkdnFWGdB24qLQwYIgxRDqJf MQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxc523t7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Oct 2022 08:29:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29676vgI037540;
        Thu, 6 Oct 2022 08:29:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc05vgm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Oct 2022 08:29:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VptS3em8r4sStmhjOXguyeMbueWnqkOOXkjdSxK3+VWxXRSvGN36Zpwu7DceloxYf0UlHp/+/5wctRbtaxIT0o82vgSBM3TIaLMtE3LVzX99K/wpWocXp9iDIh4YpvHcAsAnpky849pSENgNYofnYU2E69w9X+63etjM/ADgyXUgw80dFsLIXcVtTKuVP+asbVaJr+Fx2MROByB5MPgJJMxmzOP+RKT0Lh/Iq8Nc3wheVSyr++2P9P2tRG02AffkBcOjr1wljAtbkArMKp6l7h/9qiBdnjvbNWrN87A19Ieaoo09QKMr/LQIqoEVg4+WB1qoHgCZiP5k4k/NnXGvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TDHEx4w9TvdZ7mkqNVbaAOoWqnF8u6ZmNejRYw9YHc=;
 b=QEDYCZaoz+IuQA5f0J3C8sr8NFVWACklnhQpoF/JqZqnT0c6prMlex12wmgUtRGGkQZBtDRuJBs43E+TmrCAX1SXbrd83D/IthI7pR4swDU9uqObqyS/kUmgX6V9tRs7yS8gRvJ3Q3Rz5CTJStYFEtfYcfjtOaX2PWL/30mXIRd47ZsmZSa5/YUJfVlH+hXpP/6ozwG+7k6DZHqEWSUxKxm4jFEC2Q2iiEA8S2g9LN+JjDQITvtQQBbBwyaRf8BbKLR/qh8wS6dcNmr0CGZ/oBrycXeA9ysyMAWxEIoduqUt2tFgbCKigVTY9/nKwoUcf68i+ThoRGYDnsNa6ncQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TDHEx4w9TvdZ7mkqNVbaAOoWqnF8u6ZmNejRYw9YHc=;
 b=RfgNffFrvuWTMkASuM570YR0alLZUn36mI2hLOZ73K/ftzFyPFtbkJBnN+NcIwiGffnIlg70/brTQv67STVU4gRnDqfOr7ONpVeECdWoOobjMrQRU4I4OQTSK6/6PW2YS2fBc13L5Z4lvexetCHiPL9qRqmlwDA1GMsaSZ91MWc=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SJ0PR10MB4767.namprd10.prod.outlook.com (2603:10b6:a03:2d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 08:29:41 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::4c04:3c29:4a50:d882]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::4c04:3c29:4a50:d882%5]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 08:29:41 +0000
Message-ID: <7354132e-c09b-ac41-add5-116b79bc1a4a@oracle.com>
Date:   Thu, 6 Oct 2022 10:29:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [GIT PULL] LSM patches for v6.1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
 <87sfk3mim9.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
Content-Language: en-US
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0050.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::14) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SJ0PR10MB4767:EE_
X-MS-Office365-Filtering-Correlation-Id: f49825d2-1531-4991-efc8-08daa774ea17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRUXlXkEAzqpkNBfVKDfOTlIZlSYSqI/HTizqag9PJjLFeVtgkCqHILQa6GqllGqXKE5UP7I9n5t+aAIbel5pOL1SvLhm8OUwRxPjibPXP9EZUqw33c2LjnZ6+KTzSj+3UBuRBVZiOUUHkx3+CggA/s5EZTD7ka8SrGoLTDnGbyOQwAHjoaXD77GQv42WadBYHqp2MMkksHnIcqCt10f5D7t6VWL9fecGPEdPp3024Q9zhKbe0LVXGAH9+E+Ma/xgHq607Po6EV0Ni/gwZN1fyS6yCtzmFoORyfzJG4yDibTRMYpOiaCrBHBM3bLVfdapz4vfhYnthsihNfYQogTnRMTYrufFs+liURj93iCDfUHTjiCDYwr012r3+jFIwycUyHHmyw7TGFuFDpX77LQyRCE4spB6m7RskFBbR6+ODW/uWd+q9B2ZvljzozqH6Kz+u3KR1E4bS51MHyU8eP/j0DZBwnJYUdCw56e5/0aOVEF8y3v7LPJWTE8LjRO/nahHtK9100MgRp+NG4sD6AJlpt/rzRlWaD7paQc0tiZJC30o/ApPKl27Uhn187szH1yQ3Gu0MMI/zec2iHZoyMmThbig0+Z+7959LRhx7q9i0s8qHffcH54+tfcr6xYZy9dCGilbboUGd0kCkWoFTFrJTK+mVgpMKY4Rdu8OeDqRUOAzaSff/5xH9nTUNC9nJRaINSQkbjy9c2sUP8RacYMbLa2mrDAOuRtBhABgFmWlvYwrwi3r7KQd7bpwQlzfkjONCz7xraKJ5k8Q/UKv3NAXR9sWocTFk9X4LI9gdrB7J1dy0xU7ayRrE9JJrTmGNe0zBc8oI+Hk7zY5/tu08QC404+ljmsge1xp1NShML72zc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199015)(4744005)(31686004)(316002)(4326008)(8676002)(66946007)(66476007)(66556008)(110136005)(5660300002)(6486002)(478600001)(36756003)(966005)(31696002)(38100700002)(26005)(41300700001)(53546011)(6512007)(2906002)(6506007)(6666004)(83380400001)(86362001)(8936002)(186003)(2616005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWNZVlZvQ3VjZXpRa1UvR0JSOXBIZE1lM0d2TGs4ODRTV1MyV25xdXV1aWdU?=
 =?utf-8?B?T0ZvVlRjQlhNUjY5REpnVFlJdEdvMnVaclFDUkp6amo0QktvQTYzS002RzF5?=
 =?utf-8?B?K2Z2NWZFRnJvYklndUlYdldhc25ORnZ5M0thbzdZdXJBaUdQOVN6N3UwY2pH?=
 =?utf-8?B?cGlBZDVLL1ZSOWNkVzNxMmNadzFpc3FGUjhXNGFUTnpIeC83OENHaFF3K1ZF?=
 =?utf-8?B?bHRFNG9BbytPdDZSQW5hTkxtcDlaRFBxS2t0TWZtc1hLWUtYUHBRdm5XU1hU?=
 =?utf-8?B?MzlETHVWY0FHWUd3Mm9aN2ovVjIxcFJVSEhEck04aWlSd0JjM1pwNE1zMm9v?=
 =?utf-8?B?NmdQNldkbUI2aDNxd0lXdEYrVWNycFNjazRrbTR1SW0xQVJqRmowVlpqY2xp?=
 =?utf-8?B?MDVVQzZjemxYL3VrZXNUd2VYelFXTEpMd0gwdkZpeHQwUkdqcUwvSmkrOHNL?=
 =?utf-8?B?dXdURlF1NmtNL3JpL014d2YzWnI4MVVRa2dPMHJCYmJUMXBaMEFhNjhkT3Bn?=
 =?utf-8?B?NmRySDlTS0YyZFQrckIwUDFiUkt4a1ZxZW9BNkE1cGkvQUVwTG1CdUlDWXRE?=
 =?utf-8?B?bHovU1VYT0N6OUpBdzY3Z2JDZDRIT2xMUGpITXB0SG5qRlhkbExvVDQ4blZ2?=
 =?utf-8?B?QmNaVlBKNEdTTi93NFUyZTlYVWxsaEtCcHQ2NHc5WVRlZVduQWhnMVkySTVm?=
 =?utf-8?B?OFJacktKUXptdm5WSGVzYjdMM2dFODFibnViSklmOUp6NDAzRWpBRmpER01X?=
 =?utf-8?B?cVhXai9OTjJQZkovSVJmVnh2ZU4wK3EyN1BoUGt5bm0waUYweW91SHV0VlJp?=
 =?utf-8?B?aHBGYzhXZXlQeE1CV1B1Q2ptRm05NTBMN3hiZENuRTg2ZFRrR0JDWm96ZHRB?=
 =?utf-8?B?ZmM5NzN0bEprdWRqWTFnczNwRTd5VDlrM2RZSXdrUEZjWXpTdnNnREpNbExI?=
 =?utf-8?B?QjlLYTRKVmFCcDZBNUkwSlgxdDBsZ2FYS05ocXh4dHl6dnN0S0l2YWZJbVhD?=
 =?utf-8?B?OUthb25kS2liL0dRNlVmWm1HaVdxalYxUnpLbk5wNWZmVXVkQ2s5VzZZSU13?=
 =?utf-8?B?ZGg0UWRWU3ZOWVNKM1JjRzNmNXQrdEQ2RlhrZ1JRTHV0cVkyTm5WNmFiYVhw?=
 =?utf-8?B?TTlBT3lkOXp2SEZvRWZqMzcrckFUMVltWHRReFNqdnlKZENRazRscWlSMWVM?=
 =?utf-8?B?Mm1waUplUnVydFZSMFlwSUlhRTFNTkhaTkFxMGhySWRscDZzSWJybDQ4RDNO?=
 =?utf-8?B?NzdFRE9CWWxmZmdacitsd0tjSjhtdzhjVDFyejRRK2N5V09sbkJPRFB0YjBX?=
 =?utf-8?B?aStrbHV5WEFmTjdUQk5pK1NnbWovY2c3czFvS3JMTWc3aUdwSDh5THB0ckVF?=
 =?utf-8?B?bTVHQ25lakYxYnFQQStoRWJCMzVwU0tpOG9sWjBXTHBxLzJYVG83QXc5UWtM?=
 =?utf-8?B?aU9Pa3V3aTNHSXhxQ0ZjTjVkQjh2VlhoMkVseWNOdG5RNHJ5eXVBYWNpdHlZ?=
 =?utf-8?B?YUg0VWUwWHVYTDcxSFN1Mm1WQklBajdTK242eUNEbS9wK0g5S3dEZlB3ZTh4?=
 =?utf-8?B?K0dZVVZRSDBiTjlLSXVQRDhDSlZRdzVyaytxQ0dkSWNmV0NRS3FnZUdzMmZN?=
 =?utf-8?B?MTFWOGQ1MlEwSzNQSzU2QXNqdEhDRHdja0F4R04yMHRnTmtBVUFhcVNQSE1C?=
 =?utf-8?B?OGdORUtyckFyWjFXM2lKWnhoTkx6QzY0Sm9CR3UwNHhsVDhMdUZKNDBVbDRk?=
 =?utf-8?B?TEZnVjBYOW04UUpKT0s1T05wNEJvdExPUThmSnBlVmtvRWoxSEhkOUx4K2x3?=
 =?utf-8?B?L1RSUXNuQ2gvY094emFFMnIraVczemUwVk45NjhYOFhXeHpzOG5USGR3blY1?=
 =?utf-8?B?Q0daa1MrUGNaSjJTaEVEY1NxTmtnc2R0TG4zSk5pWUhyTjR5RWdsRS95dEph?=
 =?utf-8?B?RzcyYjM0eU1RMEI4Yy81eUdqUk45UEQzRTVJbis0K0tuS0UvSXVUTmhxRmwx?=
 =?utf-8?B?azJaYnhzS3gxUEg1UmFvWHF2aVFiQ3lRU2NWcnVkL0FhY2dGNjIwc0pobC9h?=
 =?utf-8?B?R01VR1kwUXljMk1oblUrcFBnRVZNaUx3TkpYdGxMQkhaSER1cXluR0tIWnkz?=
 =?utf-8?B?WU56Z24xajJhNmNjSm9vNDFMOXYwN0lOczdHSm1RVSsxaUR3eDRlZVBwb3ZG?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aGtWSjJDdEEvQWRJeWU5citXTWRHWEQ2WWltT0Fsa0xiNGNIQzdDTE51U0pj?=
 =?utf-8?B?RUhaUXIvZWVtME1wd0U4QWNnYnhNMEJrV3IwZDFsVzFES05oMHRUSU1NcjA0?=
 =?utf-8?B?ZVNkYVVQVEYydEpDNzkxTnhrVWF6SUx4OXNwSngyZXJTTVFodkdSajY2RG1a?=
 =?utf-8?B?RE1SNDYxanMreTR0UG9zSG96enBWdFFza3ZmWGc0bTVGUG9hQUplSHNaVVR0?=
 =?utf-8?B?TkpwejlOZ1JXT1V6TWZuOFgwYWxjbkw3Yk9tQ2t4ZHJUeTZ3blM3b3h2Q0dq?=
 =?utf-8?B?WTlCQUJPWHJuZGc4VDNmYlhLdDNBVnNUWGtTb2ZRZG10VmRmTCtNRDFnTGFy?=
 =?utf-8?B?a3FPQ2Nqdm9NeFBjSitZWHhzR1o2VXRsalNvUm5hcU1tVkVTMTZZbTdwZGdJ?=
 =?utf-8?B?NnpnRk03alNnajNDeUJGQ1pwamtMMldCQTZxQzN3N3F3cUZLbVc2Q2RSVzlo?=
 =?utf-8?B?Z2I3TXRGUGtpaXlsNjRXUncvMHQrbmpVYWx6TTRXaVppREYxdStZaG01dkJq?=
 =?utf-8?B?eXFaNHRqS0k1ZnRpaVRoTzJ0MW9KZWNRVDV0MWlZOWh0amFSSE1RR3hxTFhj?=
 =?utf-8?B?NVBscVdrOWVIMUFwMDBWWVJnOFE1L3h4Nkw5ZjNuZEhrcjlTdkpIQlY1UTUx?=
 =?utf-8?B?SkFmSjYrWGZUd0FxcjMvOEwyWUNhejZEUU1hTDVCWm5ubG9Za0dtOXN5RTFW?=
 =?utf-8?B?YWVSeUtUblVRRlhjQXA1am02NjRHNC9ydURZTWE3aWYvZVJ0cHRjMEovUXo1?=
 =?utf-8?B?dWVsY2E2K09CYmlvU3ZDbGxiN0xWUk9xRzUwQVVwYjl2UHdtRVJkK3Npckk2?=
 =?utf-8?B?QldCTU50K2VkNmdhNWpKeE1ZeWpJRjQ3bzhWNWtzOGdoYktmWmxGekZwVGFH?=
 =?utf-8?B?SHVvNkkvekFpQlRlZEJJUVArL0MwdVdwY2xwUnhnV2g5K083Z0VuazRZM2Zj?=
 =?utf-8?B?aE1jdXRKNjRkNkhaZ29aUjlLVUh0MThzaTRwVGRpRVRzcUdrUlhzSCt2aFAv?=
 =?utf-8?B?eWRwSURCMnE2bGpJUDkrbDZHQ1hIZ0FkTDU4aEtDUVFXbVNHV05NZzcrS1dQ?=
 =?utf-8?B?aFF3NUlXUmNWNUhkWGN0WW1ldnlMNlArbzlTcDVIWWVNQkkxaFZuUnR1UThz?=
 =?utf-8?B?YlJaeFRaQWJpV0hMdS9ZaHFuaUdmdFBYdmZ4MVdhaFNOQzlpWEdGWVF1SXd0?=
 =?utf-8?B?SkMvOTEyai9rR0t4UlRsTUxzalFDUG5jUkRUbVlyTzJ4MENqZVVUZm1aR0RX?=
 =?utf-8?Q?4rWMwqPDN4NDJOX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49825d2-1531-4991-efc8-08daa774ea17
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 08:29:41.5108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZqmHCvxVIJg0tr/GFcVdIUg+6Dyii/GVLtEuE5xolmwmJ7y24CQ7gFeRGwPcUOExwXo0kQnuMND4oFGQDtkT7Jxu3YbUSeLF060Z52b2fM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210060050
X-Proofpoint-GUID: h_bWBxGFM9b0KzqJ59T8fhDf7Cyczg3l
X-Proofpoint-ORIG-GUID: h_bWBxGFM9b0KzqJ59T8fhDf7Cyczg3l
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/4/22 22:55, Linus Torvalds wrote:
> And I think you are in denial about how many problems the
> user-namespace stuff has caused.
> 
> Distros are literally turning it off entirely because the whole "let
> users create their own namespace" has *NOT* been a great success.

[...]

> I'm not saying that an LSM is the only place to do it, but I don't
> think there have been any better suggestions either.

I had posted a patch here for restricting module loading requests from
user namespaces as a way to reduce attack surface:

v2: 
https://lore.kernel.org/all/20220815082753.6088-1-vegard.nossum@oracle.com/

v1: 
https://lore.kernel.org/all/20220809185229.28417-1-vegard.nossum@oracle.com/

I'll respond to Serge's comment on the v2 thread.


Vegard
