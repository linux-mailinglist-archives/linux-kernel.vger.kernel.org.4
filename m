Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DFC686DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBASaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBASaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:30:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444B42BEF0;
        Wed,  1 Feb 2023 10:30:22 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311Hwort012244;
        Wed, 1 Feb 2023 18:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=HP55g50lOVvAEC1nVDoErMpMBD+pIIG1ta2lf4MKC/U=;
 b=Y1w597PHmO+gM36CP9tItRPNy+cRocQag7oAHIdGqOId2r5xwpl0GkHqoMpVdz9hAzFv
 LbXeZDjcoZLrZMnh/ikV5WK3goKX0nC0Z4TM0nqzCvYgwZ6xF0Z36koESIkhL6UZv71s
 OR6D/Hpz9fhwRprtHxQjnVnRtkqFMkjvX2/OPNFESwlMeNJaEFDq810nhuPV5wMTZSIE
 rH1snRZ++gabxyW68MMBHOYlnvN+qEdFhri6DBh6+wV+2QWP3fzjUAiEtszHKi9SJpRW
 39f8GRVgGa1F9q9bmPq04VIWnjZF2tqeQzgB7vNxd6IzAShB3AsBagZUxOJfGvmY0bhh pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfkfe1fas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 18:29:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 311IGAxV036014;
        Wed, 1 Feb 2023 18:29:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct57we6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 18:29:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4nh9mDzosACxVxB6JqTR2zkXxdBEMhEww7z8m4hPrLX83g2hsAWn2FylUgMovrSQEPmqJx9RJ6VptONR7Rs2xwBEJQboCPeFWSxSTDo6oXaknYBYEbcmMTloqJ7G2lEfLELMbZxbX3ZY7dwElEaEop7X53nHhCpizWP/G1D9CyXGWT2BtjphVeU4wplzTgwdsT45ZwGXXg+kU97Io2bDxoL81QYGT3B5fTFYdkzHbhDON7z6cEwV8d5fVQ7mShtdRzSkLxWfgZeaRHDMOLwuI5a4E6ISH2o0qsQrKpaMOKKZoweKONKC+fANMMlNBJHLy+wBNi/jjXgr8tYLqBzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HP55g50lOVvAEC1nVDoErMpMBD+pIIG1ta2lf4MKC/U=;
 b=cu7kjBvLQk+KNQ/V1hhZNnNxoCajLeuuSQjMoTw3Rkc8fW3QjMfexn45MCyKjdfIMaSvkYnjPWLDNg36QV4HbudLE42VgJpdoaFHo9n6CSS3NQh8QaQhzy906SqrfX4FNXzdeVmscdfcPVGTQmk+xlEm8B6dyOi3DMCdf3198LngggmXNbBl4gP8B+qbLcq7YhOSyBBKy/sY+dDMFE4iuSG+CBuylELW/QpqBcVe0jhUHRBNfnlPlQGVDfK2P8b08eyWlucus3FYZZQ5dE+45zLOxl88q9FAQ8vP6xXzjrx4Jvx7TIM0LJPaqtQ3Bl7Xaa/TZpcF0OIlaaHxz8tLvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP55g50lOVvAEC1nVDoErMpMBD+pIIG1ta2lf4MKC/U=;
 b=MLQXF9e2Se2aBf/epxs7bmRYmJKCeq7ZLBYuDzlhmtqKRBTXuGVsFTKqRa3SP/8e3ZDkVJ50H34ifzgAqGiCtyWLjXZ3hfCGHf7pvuE8mai828I4B/MN2IXPsL21cWIbadUsC4pW48I8/i/7aX//iDv4uyWE7ANC93nyJv2cU7M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB4918.namprd10.prod.outlook.com (2603:10b6:408:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 18:29:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb%8]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 18:29:37 +0000
Message-ID: <d885941e-a22b-4bda-cf56-968e6d6dc069@oracle.com>
Date:   Wed, 1 Feb 2023 18:29:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 10/15] perf jevents: Generate metrics and events as
 separate tables
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
References: <20230126233645.200509-1-irogers@google.com>
 <20230126233645.200509-11-irogers@google.com>
 <8f53bb96-8213-12f1-f91c-7fb311e4c9a4@oracle.com>
 <CAP-5=fUTT1gh0xd-um7NSyg=XuayjWzF90W6Dp4=DOvwyGcmNw@mail.gmail.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fUTT1gh0xd-um7NSyg=XuayjWzF90W6Dp4=DOvwyGcmNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0314.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8bd2e9-bc33-44fd-c68b-08db04824656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S4zmZzYgwICS2sqFS2FaVPZwjCoehpjK8y2bDIoj34xsRDXfeer+sow0HUAMcaaGipTgiWs5316EoTd70s05K8kyYYRTePm5IMSY2A5R03pp9ok0virAHdIjy7OffJCdHSpwOBhyZjKwqB9Tj6UGzxPoD/A1p30kmnsoE+2cmrhGii+r7qywQvaI4jHcBq+c32ddChrIcWJ0bTNSHoBr+ty7S/CjhTvodkQUVnhi58lmnfBjFyNCW8663GMP1LiaEpDrrbvuD5f4eH2McDVddZ4id0X3zLil1LWbULfoBAZO392toWx31lqcIqXCj5kQv1/Zviq6Gb/ho3aNEfagHLUxdRhioZgxxCPyGSXHmRel8rCyTbIeqASCSRWxnI6dqFIiBfxERoBaG/QRB2jU1m5GeOUhdygCxEBAoyWovktVZumejPiq8QtmP6ViPhSJvXcuL96wdPem0gwh40f28HCk399bO5A0tjMqSGTYOmL8V/Btu8CLKK8ef+vhYmWdUe+Xk3v8GFw0757mAFyR0tK/PwgE66RlzXKNsbh9nYHmCeinYovNR86pQ1AABS1/WT/ShA+Z4MjJLHBUSWSSXlz3RdheyAm49eGvC/9KUhrxgzpnm1JjRoIEFtNy0yMjwDL66a7L9GEX0T2H02vTExXJ9OgHtmi1iAPgGoSV+MQAGUr5fUvRuIoVOJegtHEyEX6B9xxaDG8urZoymflf6qKFl1Pu4krCAMldR4Oc26E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199018)(2616005)(6666004)(54906003)(41300700001)(8936002)(6916009)(66946007)(66476007)(4326008)(316002)(8676002)(53546011)(36916002)(186003)(6512007)(6506007)(26005)(6486002)(478600001)(66556008)(31696002)(86362001)(36756003)(5660300002)(7406005)(2906002)(7416002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akx0SVdqL2graDBia1ZqMG5weE02NlpOUEcwMnF6UENzcW9qNDEyM0x0aGJJ?=
 =?utf-8?B?NTdUdXNrTVh1Q3p5MjV2ZEJjaFdVR1ZlU2t0d0MxeTluOERTODBpVFV0RnJZ?=
 =?utf-8?B?VktudWNlaXFtU0NwSGRBak5CRjR3aGR4dHgzbXA1anlBRHQ2SVZYOC83ZEJG?=
 =?utf-8?B?eU5BZnAyVFRwYWpSaHhUN0o0TXNGMytFeHgwRzNiWThITkdNRkg2NVorZWI0?=
 =?utf-8?B?OWRrNktTWEZnZWpvK2oraWcrTC8zSm5PVHQ2RnhBa2I5VElxY1p6NlV6dkh3?=
 =?utf-8?B?dC80MG1WVDBTb0lnMEJldkc3dEpveVowTFlrZ0dwS0ZHVlZQK1djdnU1ekxS?=
 =?utf-8?B?aDQxMEkwN2FBQXNTaUdwcmdHRXp4L3FaMWV3ZG94RHhBMWlYV2tLTWJoSzY0?=
 =?utf-8?B?SmtnZ0drWEpLcXRTaWxKek9OTmZYYlJYUWduOTgvaDNhaHh1Qmh4VFJpNVky?=
 =?utf-8?B?akhsWUlaQzZsZUpMM2JqWDlra2dZZno3SUVWRGs5bFRmZGtpeWI5cnRvNmFy?=
 =?utf-8?B?Qk1sc3IrQm5pUThHUE5IQ0ZwMUFRRmpiZkdqVU9sM284SlV5SEl2VlkvSUhn?=
 =?utf-8?B?T2pQa1ltdHFvZVo3Y0dnVkJlMXROblljVVNGSTV5cmlnSHFuaEY3cTNLWFpq?=
 =?utf-8?B?ZnpzWFFYSDFVcjlvaGtQczkyNGVqOVg5UjVJRXlkejRtclVIRXdhK2grSTN1?=
 =?utf-8?B?UlZWOFRPcGtuQWtubWZiRGtORGV3dHlnYXBIelpQRE4zRVpBdXlTWVY3eWhV?=
 =?utf-8?B?Z3RRU25oU29UYm0vcUZORHlxUVAxYytPY2pnSE9STjdEMzg3VWc3UVBaVnMx?=
 =?utf-8?B?U0hzc1p1VVJXUVJDRXZWTEJTTi9GUnJNUlVCNCtzTjNsWHh2a1hCODhCUXdF?=
 =?utf-8?B?RUN6cGdHU0VEblpNRXZ0UTA4bnVPY3k5RkVhOTR1U3pYcVVSaXI1UkNHUkFB?=
 =?utf-8?B?bFZiVVB5YkFqakEzZ0VRWWFkUW9RbzM1MmRxM2o0RHZ2aEFnKys5dmhYTnJB?=
 =?utf-8?B?MVFza2I2dGl2VU5mQVNwS3RyVVF2QjhzcHpUZ0pTREUvZDVHVmVMNysrZHNj?=
 =?utf-8?B?RlQwVTByZytMVURiZnRQeEZ6SHZrYTZyZVhVYjIybzNTZjAxMlVJb2RnampH?=
 =?utf-8?B?S1krcjV6UCtFL2NFQ1h3ck5DeThUYUtQanUxY1IzL2pYRnJ5WWtNRUNoVXNm?=
 =?utf-8?B?WS81Qm0vV3hHZnN4SytranNIdTF3cmIrOEJIZVZ2eHVvVjI0RmZvbGI5S1Jv?=
 =?utf-8?B?UWxESzRZVThzcVlsRmxMSVo4enNkdyt1ZWhpcWtuNVRiU3VRenB1ZCtMOWUr?=
 =?utf-8?B?bElQNTA5VVJrR2hMT1R5UTFaN0N2OGRrVy9JMjFpTWV4RUtFTnpIWEtIRUk2?=
 =?utf-8?B?aCthOVdsZDFlMnowWk5PQXJvMllJN2t2NlNFWWE2aTB1Zkp1WGxnS2FOU2hB?=
 =?utf-8?B?ZjRrMmc0WWdJYzczTm9UcGJ1VFFReVpkdkQ1dGZGcDdtcG5kVDRkU2NlRzJp?=
 =?utf-8?B?VVNmYVdsVnBzdi91NEVlWmoxdldrOEo3Smh3RHpiZm5YQ2kxSEZCeGx6WXhL?=
 =?utf-8?B?Qk45d1l3U2psUGpDMEZaQ0c4Uy9vNG8remF6Nld5Vkl4ZlFFdTZyby9YdENN?=
 =?utf-8?B?ak1sbU1CcUozQ1dud3p2T2dvQndBdityTVZISnlrK3Z4eXhzcWlvcnZwSEpM?=
 =?utf-8?B?UWJKeGM5RFFERjVqdGl6UnV1ZndMTWtlU1p2NklHSGZ6SU02YnR6cjJtVlUv?=
 =?utf-8?B?cmdjQkpGOWhEcURVRi9IdlZzNTVkYld0RjEvU21DZEZUMFIxWVphQkFuVEt1?=
 =?utf-8?B?NzVCR2ZWOXdwSUV1SGd1SkVzQjI4M1Awd3FTKzFCRjNCVzkrazdrbW8yREN0?=
 =?utf-8?B?TWp0YVpweUNLeGVTMXRkZ0JVNGY1UWFYZUtOemtGbEkwVTdoMXZEVTREMmdh?=
 =?utf-8?B?M2dHclJRSHJxanAzVXpIZnhRbFJWbzRjN0ZsaXptWkJ4NGlaWE5wWTN1YmRS?=
 =?utf-8?B?S2NZL0VOOTRlN0s5enkxZnpuZVRpOXNwdEt1dFBVYlNlUllUU2VFUDNRaWZu?=
 =?utf-8?B?UVBpYUtyeVdzc2hEeW1VTlhmclJiV0lmS3ppT3JTM3N5cVBVU21wdUNjdUZ0?=
 =?utf-8?B?Y3lRMzBWMHBjQTh6Nm5XQ2dEWmkrK0FTZ080Q3dmeSt2SVhuL29pY3E2eVJa?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TUU0RmhtVCtmVVh1UDRHekZwVHM3OW9hOHhPb3FpM2o1Tm12Y1pyL0VucmdW?=
 =?utf-8?B?eUdTR3BHeTRiZTZWTTNpWkgrdUEvSEszQnhhSVB6dWpVOWlsNlFURjhrOG1r?=
 =?utf-8?B?MkJFVStmUTY4b2VlVVdkZ2RXMnRmUGVNYllYa0J0Y1VZcGNkSDhtbTJGcFd0?=
 =?utf-8?B?YUxua1RRb01La0g0VUtPYzFBV0sxMmc3S2RUUVd2Q3VidGoxNHhQVVNNZGcy?=
 =?utf-8?B?dENXOFZwci9CWWF5V2hvRTNwcUpWQ2FDWmxUd3huSGVuYzl2aWVHNVYxYzM0?=
 =?utf-8?B?YlY5VGdQTzk3Tmx5MWNhTVVIMVAxSWFhUjNvNTlkMTMzQVVuSnpQM0lHbFZQ?=
 =?utf-8?B?eGRRa3lLTUZBTDRTMGQ0Ylk3cGZReHdlby8wTExCN3NsaytoVzdPY2N0YVdK?=
 =?utf-8?B?OGdTUmpBRzdLZzB4NXpBeFRaMzRWM3ZIeXNXalZxQVdUMHJaVkJpd1ZQRERF?=
 =?utf-8?B?SkIxZW5jMlRMTXV0R2FsUmtTdW1lRVZUbHZuTGtmeDhiQ0dHRldubkdxclJs?=
 =?utf-8?B?cTVmTlZHV2tNMUJuVXlSVk5KelRyTFFGTXZza2FMYXdtbUo1c21MVHRWRVhv?=
 =?utf-8?B?YXNkOSt5c0ZkNXhLQSt6bDJVMFJUbVFJNmZMRWQ5SGR2QzBqemRGYVJSbDdj?=
 =?utf-8?B?N3ZLWHc4UkdHRVpVMHdQNkMzL21iUEF3ekN3RjBjU2F4VUN0ZGVXZjYzdHRU?=
 =?utf-8?B?UlFaNUVxc3kwRi9RR1B4R2F3c0g0TlJTRkE1SEs4ajYrNzZLSkplVWJkaGtX?=
 =?utf-8?B?Mm10eURoUk1YODkzMU5jaGVDZzN1QzQyYVpFdDE2NDRoRk5RRFZCS3VoVFRm?=
 =?utf-8?B?U3U2RDc3U21JMTBmTHBJSlJpK091d25WaFRNek1xTHJNMVZpbVR1R1NzKzM4?=
 =?utf-8?B?cENuUWxtNWplYmZQNHBzYzE1OU1WZFZ5dXpyQXJFMm9jOU1uYkVsL0JmMlM3?=
 =?utf-8?B?S0huS0tQd2pRbkEvL0xVaEJyMHVabWVxLy9uZUU4WEdoUDJGdXI2S3gwWFZM?=
 =?utf-8?B?VWZScnZDcUR1OUt1eTI5UndndDNmVEgzdGRQWk5va3NZUk9WYkgwdFpjK3FQ?=
 =?utf-8?B?R1BpcEZZSmRNZWJOeWhvZ2FIYm5kWDNRWVNmdTdZZGorZTJoa0kzaWJBdXM5?=
 =?utf-8?B?NHZQaWIyUzV3Z2czOFJDL09kQ3ZuTmpNRVVqTHFIdWJrbnl4M01wVjZzcGxn?=
 =?utf-8?B?b1ZYOVgram1MNU10aWdNTWFxV3pTVWE0TFlXb1hIM3J2OE9yU1lXVWl6K0t4?=
 =?utf-8?B?QkJ4R0ZxODNMa3o2cXZtSEhUT3RVMFlBZ2Jxam1RTEI0ZFIyd1hXRkx4YzhR?=
 =?utf-8?B?Y0d6NTVxNlRyK2lzMW52by91UVNBOUFibDREN1krYzVSOVVmTUhiQkxLbkF3?=
 =?utf-8?B?M0UvUzdmZmZZRXZZMGYyNVREREI0ZGtPVXpHMXhXM3VnT040ZFNGTll6Wk95?=
 =?utf-8?B?SnBhR2xBb0srK2g4M1RPelR4OEZJL3BuQVhNZGhKTTcyd0d0a29ZcjdUSUlO?=
 =?utf-8?B?b0V3L3RLWHZqaUs1eGlzaFdWRjNhYmF0N1JGaEJYRHU5OHJUWFFXbld6aDdW?=
 =?utf-8?B?UWR1dEtpcnFsZkRUbFZHc0kxSmVMcGNjZitjNmpNbm9Bc01XUjVIQXljTjhz?=
 =?utf-8?B?ZEIxUFNZNEpCYVhsWlNOazZtODNEa01nTXNNS1NrSjZocDNsdXFoSkJKTUtK?=
 =?utf-8?Q?yW9NZlISMfZiXStfFCl0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8bd2e9-bc33-44fd-c68b-08db04824656
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 18:29:37.7752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0K9zGnh5ui57M9Sr5naVIua+okobmQam+vDv0so0jICnaDP0ydFS7mCmCPRc5PxoEqRnsNHqIyhdiMvtutsEtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302010158
X-Proofpoint-GUID: nPPCeD5Cx4CjYKU-WP5kj9RXF5CW3BGb
X-Proofpoint-ORIG-GUID: nPPCeD5Cx4CjYKU-WP5kj9RXF5CW3BGb
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 22:54, Ian Rogers wrote:
>> This is almost identical to generated perf_pmu__find_events_table(),
>> except we return a pmu_metrics_table * (instead of a pmu_events_table *)
>> and also return the metric table member (instead of event table). But
>> the definitions are:
>>
>> /* Struct used to make the PMU event table implementation opaque to
>> callers. */
>> struct pmu_events_table {
>>           const struct compact_pmu_event *entries;
>>           size_t length;
>> };
>>
>> /* Struct used to make the PMU metric table implementation opaque to
>> callers. */
>> struct pmu_metrics_table {
>>           const struct compact_pmu_event *entries;
>>           size_t length;
>> };
>>
>> Those structs are defined to be the same thing, so I am failing to see
>> the point in a) separate structure types b) why so much duplication
>>
>> As for b), I know that they are generated and the python code may be
>> simpler this way (is it?), but still...
> Agreed. The point is to separate the two tables for the typing at the
> API layer, internally the representation is the same. When we decode
> one we get a pmu_event and the other we get a pmu_metric, so we don't
> want to allow the tables to be switched - hence two types.

I do see the advantage of stronger types but it does seem a bit odd to 
achieve it like this.

Thanks,
John
