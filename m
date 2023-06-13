Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBF672E898
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjFMQgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFMQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:36:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6CFA1;
        Tue, 13 Jun 2023 09:36:41 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DFx323031477;
        Tue, 13 Jun 2023 16:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ag6kHYAnf07weo5sirUtm6wUoxTqUqYrsap/jgiafjk=;
 b=xYYVq1XVJlscP238q/wwBiG0MYMQtHWjDNmVY6SPevEYbZVgpCuoceNH7mR3My3D8beF
 60ZCjNY9u3iGcAJrhYymlnhoWXTeKqTVJfHUXaJYEC7dKRmZfYTagDtPob5UkzK8xC49
 v8uF+fC7B91osZNi7bcxtmuDTs2ZXZ6bRaakQTo3LpIpWjqWvTmpwfsig19k38pAlwl9
 jFQtFCc77TdCLrHfpFumJaolncNtz9cv8UrjmVX95MEaxtCrX6LWOec+KwPVdXF8ofIF
 BkdRDxTKrCfVBsPi9+JXEshJmiLm3vKScQM6ZMT4UCOQTUA9bofvfNTAXMwEHUEFderD Og== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bnsfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 16:36:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35DFQI7I008955;
        Tue, 13 Jun 2023 16:36:19 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm4p21p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 16:36:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNXzncXkTYCZ6Dckit+JNMHFuEkAFZ/waE/3uLEyxw6DWn18jt953vC+imHpikW+frmn7jMEt7C8vQGePdlB+ufiF1dfM+PunCNdvpyRuKGAV3hmIFuqCx1Z+5NEa9Urua4U5yDx/iPisGnTRRaVaL6ObDams6UQePcfLLh5dCupip2QVKFQfPagBXn1fU1LfHQYcNqZaHlLyHFCql/eFs7PsDm05oRSgEFtM4OKgC3n9uneimdn4zzUdgJp28Omn9IV7WL7uTVr9knNqYNMW4Uh6rT/6W2Firal+/WBiI2eVNl3ILm/14PV2abl7t34Z1i7H3nCfy+yBQ94NKMYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag6kHYAnf07weo5sirUtm6wUoxTqUqYrsap/jgiafjk=;
 b=cu2kZ8AuZgrmPnNBWacPpoPTkQSlKVXbosGM9gCd3QJ+UQr65pILYC+qguYyP1nVjxHVFQgXU3GskTseQv99DR5BVHAFRbgP+XEsiebUY14ut1SrQOcWuJgkKt0ifjzUEGPejMrdzeD9U+pg7VOP5hHstNauUoPvfi4vvU9hC+T2aIIXzB2kDznioURexWo0xO0269mEkmalT4nh5Z50ttWvliiTmjdfQkxLISF/6tZodgnDW0K19R6NP6iyzYNLVLOFqutE7qabDZan4zl8PcYLE5IwUZwWUSHZ1zERCiYt7NpZrUN/xzDnrsKVdvSFofbomeWs5h9yQgRW6EBxpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag6kHYAnf07weo5sirUtm6wUoxTqUqYrsap/jgiafjk=;
 b=mMuiWlRvBcIaTujzSnjBTS4WfBxQlUunN2iUK1kolnxuKIiaLC2ADQ++NlQJWmuqHq3v0dix1nlbr8SIQxJQ+OinV/kciPhBaz2CLILv6S6uYxL6jlb++mMc1v8UU9Ls4y+uXGhncy8KE6neGGQpGXMqLwRQbdPNxIHamAAPnhA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB6958.namprd10.prod.outlook.com (2603:10b6:510:28c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 16:36:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 16:36:13 +0000
Message-ID: <079d7920-2030-2e00-a833-5ec6d450f7dc@oracle.com>
Date:   Tue, 13 Jun 2023 17:36:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
From:   John Garry <john.g.garry@oracle.com>
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1685438374-33287-3-git-send-email-renyu.zj@linux.alibaba.com>
 <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com>
 <452e724b-2a2c-52fd-274b-60db7a7f730e@linux.alibaba.com>
 <c4b2fca8-602d-9c76-90a7-3eafd92da8bc@oracle.com>
 <76fcb062-61a8-5f90-b39d-b5fb6da35652@linux.alibaba.com>
 <5f38ef6c-8c50-5df9-19dd-c3c9fe590452@oracle.com>
 <e4be7189-a1ba-7758-bff3-e7b8d8ff1419@linux.alibaba.com>
 <892f57c7-8ce2-634c-26f3-4d4ab8b2f2ce@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <892f57c7-8ce2-634c-26f3-4d4ab8b2f2ce@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0242.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: cd929bab-c6f8-4130-c174-08db6c2c4d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTL9moypAQzCOk9LEzp+qjc92oTXMUyPBTulN4pBDMM09M6U9360ZaCfzTw+4aZbuy2aSncsDlPWyy/RJfGxXOHDOz+oxBAj1o7L7YgbPKsv7ikQWxMSJOJU0YNDwyzw6wAyOjnK0NHZEkqBb1veUxMg4c2HcmZkDdP3GtihdAjWpOwz/f8uVPzB0NiDHkSLlDQG9wjQ1P3q2AcUG6uBej9RJofSbtU23DNF/i/L+vmBpezIdyJwhP4ywhHQ9HhxoRaolr4+fAWxU/2JdS8qYnyzYfFr4RaOXxeVR42/LHGH2tuG2q0BrvLaFtGaFSJ0UVQxfW88npu5sqYvjp0UKIbGICAK2skZ2doltV3uCUdpWMTv57M6ed1fyJ3jNpZmHT6oLDtH/5ka2407S0MXuq9DgAx3A4HsXQgro/MMYGnAPmvqppBKfsExOYKLkJ7LOlnB+qbPP8FxdIaQsSoFnMSJV64ASPnFAcpLJs4XPKq4vRD0x7ZFl9reiQaM051x0CyRo5Vy/V0gNLYXl8NlSJXiIdrn9yGdsEeKgmqkgCVSZO3FgOO8ABgxiENPj6CyNHRt7lkkGtZQBqVY1QNRTF8XJxxYZJqPXzg0DtM/49E+QnWjuIrS95CNUKOgM06KxHZ/CAVdpaCUWLu4bAXIsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(110136005)(5660300002)(54906003)(31686004)(4326008)(66556008)(66946007)(8936002)(316002)(8676002)(41300700001)(7416002)(4744005)(186003)(2906002)(66476007)(478600001)(6666004)(36916002)(6486002)(53546011)(6512007)(6506007)(26005)(2616005)(36756003)(86362001)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzduMXN5WW43dDhldW90OFMrQ0ZaZmhIUXRnU1BqNjJiSzdSb2I2T1JVVVBW?=
 =?utf-8?B?UldYMnh4dzBOVDVRWEZ0cTJUQnFwVXJiOWRJdTdReEdIRGxjQXRZVXhnMlVQ?=
 =?utf-8?B?azVoemhWSHZEQkNQY29iTEdTNDByQ20xQzI1SFhMNnFEMmZOYU5hZm82cHBN?=
 =?utf-8?B?Y2JvRFFrTTJ6SmdVckYxMjFkQWxQYmhsbnE1akJwSEJsSWZYajJqczZKeEFW?=
 =?utf-8?B?OWNNWitOV01oYUJTdVA2RERzTTNQM0FXSWVoQmlmK3BzMlJHdXNlYmllemk4?=
 =?utf-8?B?NXBwWlBMeXY4S0VoSmV6ckd0YVZOSDlMeHVKenZmdDdwRmdQMXpZMUIyOXND?=
 =?utf-8?B?SWU4dHR1clQxRlF5dU5HZmRMaDQrZ1RsVVRsaFlBSFpiV04xSGlHcUpHOVJ3?=
 =?utf-8?B?cU5YK0JJdmFEM2dQUmVSY0RNdjNmQzVmTEdadkovODNTZUtvQjZFdTFsaE5k?=
 =?utf-8?B?S2RITUpPaGM3VHFCbU5yTHRvcWhPdnB5WUNBM0wxUXhScEUwam1DekRGc2xC?=
 =?utf-8?B?SUVMbG9wc3RxL2diUXo1R3FJSkhPakdTWFN0UWlxd0ZNRHcranlWb0t5Q050?=
 =?utf-8?B?MWVabjVJN25EdFc4b3NjUFQvaWU0TG5XWkppWlZxbmJPcFdTM2o2dVdYT1Qv?=
 =?utf-8?B?TDkvK3ZjaVBCSWM0T3pRYmlOS2tEZDlmSmNSSmVRWlpEeXcyV1BkMlBQS05s?=
 =?utf-8?B?YkpBTGxHTXU4bGRlTVkxUXBzSmE5cDlyQlpWMW41YmJYaFFPYkNyQ01vZ3F4?=
 =?utf-8?B?V2FoRnJFVUVQSG9jZDR0eFR1TFBnN3dlU0g2TFlWaWNjdW1kZXRZdzhPcy9z?=
 =?utf-8?B?TklPWGpPaWxwWnk5YllEWEZKMDdEVjZtbHpSVWx2UEoyZWxOKy9ON1pGQWor?=
 =?utf-8?B?bnpkdmJPVkV2cEdxK1I3bnRPZ0crUlZpQzEzWXZmQlFUSG5KMWZQV3B1bmRH?=
 =?utf-8?B?TFRZbVNiNHFOREpJOWhFTmRFcm5TdktGNXI2N3FPRmtJMzRocndzVkxTY0ZS?=
 =?utf-8?B?a25QWEFIeGpwdkYxOGlIdEFzVkJQRXZlelphZFFRMXQwQldscXA3d3c5aEpp?=
 =?utf-8?B?MkhlLzVvOTdyWnpIYzVzTEtuWS9USG5pcC9hcmQvTnhneStWWEJQTmVQSk81?=
 =?utf-8?B?VkZ5RDBFQXo5aFJqMytwZmY4LytYVURQZ0h6ejY3WFZDdTNHMmd2SnJISTZv?=
 =?utf-8?B?dytGQTFZQnowWkJiSkd5V0QzSm5HN2UwNVVnZ0l6M2JWSzlmSDFWSjVTY0JH?=
 =?utf-8?B?RmI4UTNWWWxMU2IyV3EyVncyTmU0a3QzQ2wrWkE0dy9Md0pWNjdHWHdlb2F1?=
 =?utf-8?B?YnE2aVNQWWxydzdmWG9ib3JHZTVXclB0UStneGVTSStnMlZGR29QMEk5YlRl?=
 =?utf-8?B?MVo4Nm1qQlFnV0NxUStkZmZpMHRFMUJFait6djBaV3p1SlVXemo5WVV3Zmhx?=
 =?utf-8?B?T2VZMzdVTHhoUldRWnZmZWpvNHhSSDBTcGtER3ZEcTAvWHFNZkFHNnFlNUFx?=
 =?utf-8?B?VCtNa0FycTg1Z3lEbjcySTM1MDA1cFB6RHdMWEp1aElDQjNTaUlkSmZ0QUtu?=
 =?utf-8?B?N0NCUlJHTGd3TFMzZmRMelM5LzMremtFWXVmZUxsK2dFcVJGUmdwYU5xa1BQ?=
 =?utf-8?B?WCtyVHoxZjB4ZDNDcjZlZTNaa2c4YTBrbFFGbmRQMXE1VXFIZnoyRGg4cGV5?=
 =?utf-8?B?YlBmWkNZeWtFZDBURWc5eXpxSkJ4NDJjMm01QWY5MU5GVHU3ZG0raU01QjMx?=
 =?utf-8?B?aFZlcWQvS3FUTUJrMVorQUFjU0NDdWtZVGxLQWpINWJNclpYS1BRajhTZTVi?=
 =?utf-8?B?a0gwUmVQNWlYNXFJdWgzMXFKN0tBMWMybXhwaFNxQzgyMzNxM0x0ZTd6djl1?=
 =?utf-8?B?ZytEU0pSTC9JY25veUxaZXBtbmFRSzJtVkFLVFFQai9LNGtsditsWkd2K3Uy?=
 =?utf-8?B?QWZRaWRVT09LVDdCK1VUbnFySHA3SDdXOXdhQ245MU9DTWlpWDlOaXVraklx?=
 =?utf-8?B?amlIbm5zdUg3aXZzM2FvRTZSTXpOMjNsc0tGOUgwWURpTFowSUxGeUJ3SzdY?=
 =?utf-8?B?aXRidTRrZnNXSWNnVmZ4Z3pjUTkyTzJ4MytPWTBRNVBSaGswZVZaWmpVSlVV?=
 =?utf-8?Q?u/AgnlTSjTg0g1qi1/GW5qx5w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cHRUVTBoSW1UY3VKc3JwbUpvejg1Z3BObktuQ2oveDNlU3FKcjlrVXJ6RjJL?=
 =?utf-8?B?a2FCK1Ryb092bVA3S1EwWGlVVXlRSnRrY0k3UnRmbVdyTldUdkRjN091eWZM?=
 =?utf-8?B?UTNWNzJsWmYyVENleEp5WWNSNHlzMmFyNlJTMGlvTGpYMHY0NzQvZ2V3Mm9Y?=
 =?utf-8?B?WHJhNjVPOVdnaVZydjRoYjJsQk5JWnQzL0I2eHRhallJVHI2R1FLUTF6Q1Jz?=
 =?utf-8?B?WDV1cHoycGNlc1FleUVqd2JiYTEwN0xIb1RROGlPalpOdHNWVlkwZjRsSmNY?=
 =?utf-8?B?MW9Oc0Y4b0VhckROTFlVeVhtUmlBWnJXdjl6UTNmZGt1LzhVdFd5MTBxSG9y?=
 =?utf-8?B?RDN6TC9UdW9VTFMzMXE3NTFZUlJVZkpYUW1GRjZxTVlrWExMbWZmQ2puUFJk?=
 =?utf-8?B?SUdLeWlPdUJZRVlYbElMZ3c5bW5XamtaanhXVnhIRmlFcUlEODZOS0xLSVJr?=
 =?utf-8?B?eUN3T05NTU9UdHZJaHVsd1dxNHBUYXhXeGp5L0E1SE5rcU1QbGpaUTBySVpT?=
 =?utf-8?B?QndjdnVwYi81OVdLVit2cHpwYWl2UWsyejBLZldzM0xzb3NCVVdoTGxhQjJS?=
 =?utf-8?B?RUFyd3g2VkhkbVlYbWhNNWp6NmVRMEgrOS8vYXNzOTBuaFNya2JSMmJVWGNi?=
 =?utf-8?B?cEVDdGNQbUNYbGdNLzk4QTJoeHFmdm9vU0xDWE1xek5CYTkvVEt1d0ZMOWVM?=
 =?utf-8?B?SVo4YThuUWJlTC9QWE5GKzNHeTVYREdWTDFsY2JPbmpZenFvT01PZkZ4NFRY?=
 =?utf-8?B?WlY3bEliWmVJaFpuUDdQdlNTY0JKWGdITjUyWEx4MG5qYjJKUnNMYjNTMmR6?=
 =?utf-8?B?VVdQZm1OQWFUbXhyMTFSdTFYMEhTWE1XczlKdnZWWHpDZnNVcDNKYmY2bjA3?=
 =?utf-8?B?MCtFd3lWSmFtK0RudGJ4ekV1Tlcxd3pUU1d4L0NrV2J2eFFaOTRXOHh6RFJB?=
 =?utf-8?B?d2ZDaTRHTVRQUEpJTWx1UXhndkNXRVFKd0hWUDRiYW5mSlRsNVhNVk0wbXNB?=
 =?utf-8?B?Qzl1bXJqTjc4KzViZHZpWnZrNW9TQjNxUVhnWENQd0xEdzI1aUoreWpTWnlF?=
 =?utf-8?B?Q2tzNjlFWG9KKzNhK1R6bXhKenpLZjlKUGx6M2FqTXoxY0NkcUNqMlZGYXlh?=
 =?utf-8?B?QTFSV2lZZy9paXdwVDhFRlhlNTFTMjg5bTNURHRoZFRrRVBsRGJ3NkxKMUtX?=
 =?utf-8?B?czVVOVVpQXlNQ2lkN3lIMUJ1amFuVnA0OW5iYUlYRzdobjJ0UjJpNTFMMDMz?=
 =?utf-8?B?dmkvUGRYWVJTbFdKaUpOOTBzem9hWTdnSEJZZ2UrUUwzU0pPTmVicmVYMVFw?=
 =?utf-8?B?MW9VSEVVeGs5dW5rM085TkM3RnY1dk5RRUtwcFZpMTFJMFlwUU4wSEdUbE0v?=
 =?utf-8?B?NVlUd2hkakFJYTlQcGZTOXZpZ1FtWFZSQ0JTMGV2R3ljOFhRQ3psaWRLNW1l?=
 =?utf-8?B?akR6ZkNGQlc3bFZQd3pBTzVUcjZvOVlTNWNoSGkrT3J5SDBUbEZKZThmRDRJ?=
 =?utf-8?Q?9EaY4k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd929bab-c6f8-4130-c174-08db6c2c4d1b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 16:36:13.3399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owoiXGidJhPJsHx/CNmJLMwBLCyulhBzOql+7Lf6UXs5pFAoNjvYRL+VnGxEOCx5QPf0xievFlGHTkW48IORdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130146
X-Proofpoint-ORIG-GUID: 103fLtfRT_rBPZ1O-PQQ_qjvCdq1MBYu
X-Proofpoint-GUID: 103fLtfRT_rBPZ1O-PQQ_qjvCdq1MBYu
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 19:15, John Garry wrote:
> On 08/06/2023 10:44, Jing Zhang wrote:
>>> Unit is the format of the event_source device name. We should match 
>>> based on that as well as compat. I need to check the code again to 
>>> understand how that is done... it has changed a good bit in 3 years.
>>>
>> This situation only happens on uncore metric. I happened to write 
>> wrong Unit, but the metric still matches.
>>
> 
> I'm just double checking this now. I think any possible fix should be 
> easy enough for current code but may be tricky for backport with lots of 
> metric code changes.

I also have code to re-work sys event metric support such that we don't 
require "compat" or "Unit" values for a metric when the metric is 
described in terms of event aliases. That code is 2 years old, so may 
take a bit of time to rebase. I'll look to do that now.

Thanks,
John


