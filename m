Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A65738CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjFURLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFURLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:11:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F51184;
        Wed, 21 Jun 2023 10:10:59 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDAqAT010110;
        Wed, 21 Jun 2023 17:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=E33sGTufE65zh3ZuiWmqJVbmotTWJUKkV+bbOLdraWA=;
 b=Byjzpjt8lQxKTDUBQoBz9Y68WTcF6hQOrhhJXudVQTQiE/Z37TVVtQD2goSaKu2nNIcU
 X10Xqul1UZRhM+gz1ZqL4I0+dbU1/clMcMyvT6rPBSyI4u5aPy5kpQN12cQR4p/j+gAU
 k71vWe0BDwc8FtECD0YhChfT5TBN8Q62u5K0Hmni5dkHHqsGYBb6NCdyXKBPqbUj4jx8
 fFS/COq7iiNT+ssCj7GjUgig/Ypi4I+q/T287DRDwb5TL2xXANlQkB783AKqj1te0l2Z
 GOtr/efBN4luPErDoNb2aYI4gOyDXLAWkaueD3V7+g+S8iBBNukifWmYRSzteyXGUiUs 9Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vcr5a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 17:10:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LGQSAS005987;
        Wed, 21 Jun 2023 17:10:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r93963pdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 17:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfXhrZXlacWXn459J0jwjFGTrK9iJWX1yb4NDwlJKSxcsaiAJGMoaul/ybr1NU9evtkdZqmmq6o/dZH79+G4RBv2wss2/KPbun84rnJvnvt8iQSgRQcbIt58r3aXuK3dSIYQqjHM9pploOC++Q5xuuiWyUy3hLqg9VRSIdhXtORTGYsLC3qALWig1BetQhyS+udrE3GtN0yiUwEwC/zuYde1Va5RMpTyLS7IAquZE2MYGmjfUPc6bmgfUG1OQXfnW0/IIfKx0GAio7sytiOkmrZ40sdzaqFhiUEjUd8JrYJyLvaEvD+TiaMwYojeBt/LWiN+VJalFiG1Vg9bUnl7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E33sGTufE65zh3ZuiWmqJVbmotTWJUKkV+bbOLdraWA=;
 b=igjml7X+GT98dVYGdgajFuD8ff8Q7lvTFwDttqrnWkaHUmU2gL2ICfySOEJGlHnyI0zMQ/uvZRuKy46EbfgZtG5KH6v9cFfYDPuMfOWwW+mhC3lB8oH2+mezWUUsSXFL3uSa1pp6ZhAHuumIyOQ8/bWby8xFJN27PgJTnvpAlq0ewb81WyEkC/U0zmw9lriwEwUh2k2vxBPkQ9IuM5qUjYubBUqHAPY9lF7ZIWoYQTJCa0HGaex5wtHFS8XSgBWY6ryNiAeGp5IE8gJtGTPDxcZGVruJl6or3i2NpusKtW6ub5jPKPd29cFV6OixZ5HV7bCsTzBY0G5ajgUEAiRuhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E33sGTufE65zh3ZuiWmqJVbmotTWJUKkV+bbOLdraWA=;
 b=fZTPeS9H3kOy6bD8jtf4JdhSYmP8eEj2YycFmcPFNSNkYnM3yGpMH1tnPoncBF9Tbjj4QGWpXTzg2mWoQK9Puz47OTkW0uWrtVA2OOuXQnRa+/sZb+c54GjRCgmRNMEkStz1qLMso8J5ayPgiINQKG99okU1c6g8kxXIsD2e99s=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by PH0PR10MB4598.namprd10.prod.outlook.com (2603:10b6:510:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 17:10:35 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 17:10:35 +0000
Message-ID: <76bb2e47-ce44-76ae-838e-53279047084d@oracle.com>
Date:   Wed, 21 Jun 2023 12:10:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] perf vendor events arm64: Add AmpereOne core pmu events
Content-Language: en-US
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
References: <20230427223220.1068356-1-ilkka@os.amperecomputing.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20230427223220.1068356-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:610:5a::15) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|PH0PR10MB4598:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e3e11c-78f8-4188-aa71-08db727a6d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LqstnlQTWohrK5ka4wgiU9pb7EZLTL60FnLxK7dkSUsLOPbJnReRp2fHZJKMw/A1qayc7NWtHCyZlBcNbXgLkGBAjEmH+Ny/dgimOyWIFuVYKfnOpGvqyUt8QdfDGUtEOQfkVJ0SC3GAkqK+xf16Uy8+aMAt3rEtudiWHWNUbMlKrSOUbwMNQU6e2HAq2PrepuN51r01yGydhOKNckmjw1b6j/SdtSoVFqj4K8yshHcRJbev/TrWkqPhGz0EOT1HY7+HYj+yD/7k5+eimPIS8vbtgn5FyvwRWaRoPMco2JySKcIxcX1mAsy/GUbzHIElSGJGoyfEwVD983tu1O9Z88dxwBR2CovgPGCC3G9g3Bde81ZnLtmVyG1Ul6D0lQwV9nHrfIR1yl74Z6iuckEwXQHTrmgL1/hD8EPSmlKTty9gDi3ep9kjrVLzzCvE0P7abZsRzPhEhMkAdajxmWKTs7j2FmoBMiIA59Qqc25hzfWSI900JcCelb3R9znNcDPSYFbvFM60djcHftLJN2rwWd/eRzd7hpMUOZjxX9FuFhrGeziUp9ASUYVHZd5D42SrRa/K62zGWFKlZDeJaHKIL7Mm8iXv3UbUJHzCATTFEkY9HT8RRYt/lNk+LikdFrrmu1G0NSXiL5eQVUV13x6jpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(478600001)(110136005)(6666004)(4326008)(54906003)(26005)(6506007)(6486002)(6512007)(2906002)(186003)(41300700001)(8936002)(66946007)(66476007)(8676002)(44832011)(5660300002)(7416002)(316002)(66556008)(38100700002)(36756003)(31696002)(86362001)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXVzb3hXdnJNT1ZaaU1mNEIyNGxMb1dnaG84eFpFbmg2TUVSYTU2VUEyeFox?=
 =?utf-8?B?K1owSlNvQ0pCdFRLTjAxYkFnUG5xNzk4YUUzajkzMWFRWlBWNktDOTZDcTlt?=
 =?utf-8?B?aytzRTBiYkRyakZCZXMyOU9QOThPbjhCWnNIcEtSZ0ptYnI2RFNxODFtdGFW?=
 =?utf-8?B?ZHpNOXREM2NraU9vZ3Jja3kvbVRMTStqVEZrOUM1YkdKQlE3akdNV0hPU0hQ?=
 =?utf-8?B?eVFCRStLOUVMbFBVMG1lZDA1MzJiWlBIdlRDVEJhaFl1WkdPejhKdG9Dc1FE?=
 =?utf-8?B?WENNaHdkcm1GTUx5blg3RyttVmhxUkYxWmxhaVV3UDVxNVJuSFhLWlEwUDBv?=
 =?utf-8?B?dFdKWnUrWTNxV0Ivb2hKUkZEM0NWLzhFc0xOTVR3QWVXQWxjUEVyWEtENG1Z?=
 =?utf-8?B?cGtaeTlnN3VKRGowOXhmaHB2bmZyNzNPNTdoekRMWHBCSlVUb2pwQlJSWDhO?=
 =?utf-8?B?Rjl5azhZMy9KWkNkRGJHUmZjWXJadkovZkpCL24zZzV3V0RGWjNJRXhjZ0J3?=
 =?utf-8?B?Tk1OUUdyUGZFNmZ2c1YyWE90aCs1aFR2bmd5Z3IwNnFLRDVUNEJsM1N6WWdT?=
 =?utf-8?B?SXB3dFZ4djA3NmFZMkFOa05UcmlvQkVSa00xVXlzRkF1dUZuU3VvSytiZHl0?=
 =?utf-8?B?bUxzWkFMZjlScE1qbWFoMDdmaXp4L0JObGM0TFBRWS9lWjl1S1VPUkNJdGFG?=
 =?utf-8?B?NlZvbHpNeVN0YzdvamNreFRhSGdzemF5ZGg1QWNkR3NrNmNLU0VVN1hmQ0FT?=
 =?utf-8?B?VEJMVGw5ODM2RlBubkhFcWh2UFIrMDlRdWErc2twZkM0aXRYTEp0UU9iRUc3?=
 =?utf-8?B?QnQ3UmtwdHpVYnlLbStnczRlUkV5M1B0S09HeWFFY204aEEyaHRSUUhJalhI?=
 =?utf-8?B?ZmRiTDFuMzE4VkJPak9GWnc1aEhEYmI5M0RmT2FNdXZTY3VQRVlnVWJrQVJJ?=
 =?utf-8?B?V2Vjc09vWjRGRWtaamtDOERYNXJ6ckJLKzRPeVFMenZSdkdSakxuSy9PZ2tN?=
 =?utf-8?B?S1h2M0FkcTZLaDJxZTNzUEQ4eUxWS0ppL3FyNVBXR3ZlM3ZsejF6YXFGL1BW?=
 =?utf-8?B?QUc4SG9tV3ptS1ltWVpvV0g4SFh4RktSdHZYWm1zOCtWbnN6TjhUZ2hFZ1kx?=
 =?utf-8?B?VFlDbDExWExnM3JVRUY1WlUwR1J5VkZXVGJwTXM5TjNwM056bjlxaEJwRW0v?=
 =?utf-8?B?U2UzRmFCckV6cXJZck5pcGtMZTdzQkRucFFCNmV1NVdFTmVjU01YYlVNK09H?=
 =?utf-8?B?ei9HNE1WcmdpMTBCMTQ2eTUydHlkb2xSSE54dE5qbkIwUDc3eU9zNlltaEV5?=
 =?utf-8?B?cEJ3ODZ0Y2dqNHFaay9LUmdEc3lxOXdXWXFNdXJVbE5IbVJ1SFlSdjd5Rys3?=
 =?utf-8?B?YVVOVTdjSjdWUzQreno4UklRZUNLMW9tMURxMUxjRE9mUmtKUm9GNGNGeUNM?=
 =?utf-8?B?WmV0WGZYTXRUdmgrS3UwMG1oRUM5ZGpQRVowUXlPMi9YUWZKTk02aCtES3hR?=
 =?utf-8?B?a2xDakpiSWJvYUFQMWNwcUQ3V2dRTDhiaVRRVG5QU014ZWxRa1llV29CYWJp?=
 =?utf-8?B?cyt1V3Q0bGI3aXNxczRNN0pHdzlhVXdDS2RVUjdSVzkycmxMeVR1cXU1MXFX?=
 =?utf-8?B?SHdoYXAxdU4zaDBVSGFGTkxCL3Y0N29JNW5vWkUxWWRsTEtkbnMycmhHU05s?=
 =?utf-8?B?cU8rR2JsNDBPMmhKM3phSkFyeVlOanE3K282MGJNU3ZtL0VsUmFoaWRNcVBh?=
 =?utf-8?B?WUhOQ0lQNHJTZitENXRPVGY0cll4dm5iM1I4NWlhSUt5bXZRQ1FYckFmbndY?=
 =?utf-8?B?clV1aFdkd3dxNnpWelFOZ0VWcFEycEs3ajRCRW9UZzUzTWZZdWx4M1BKdS9B?=
 =?utf-8?B?RGVycTFhRU43YU9jcVlUOGQyMnN0bFc0LzZaV3NGRWVmaTFCV2lCTWppR2E4?=
 =?utf-8?B?QlR4eS9pWTNDV3B5WmRKb3FxOTNVR2pGOGZZazRacGR3Rzg4S1VSZTc2RWo1?=
 =?utf-8?B?RHFkTW9SMEIraUJKakFsQ0tmT3FjbHlyNi9UdkRWcFJHdHNnUlJGbzc3VlZR?=
 =?utf-8?B?MzJETDFNT3NRck9CMmRnVjJkaDkzQktyR0JKOHRleFJtV3EwZEwyNVhhVmty?=
 =?utf-8?B?ZUYxdkVla1hhbENKeUZBL0haUGJMN2tOZC9YcW00QjhYeWsveEVTYWJsS2tF?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OWZCZ0tJYkZQVTNQQkkzSFV4aDdIekJTRkNoSTRYelQ4WGZFUFU5TEY4dzdt?=
 =?utf-8?B?MFhtUVFSU2hBUFpNLzJUUS9oR1Y1V0pWQitjOHJEeFNjOFdNY3FsNWxpZUxt?=
 =?utf-8?B?SG9aTjJxdGl5dEF5eUJKMjZKMFdWMExkRThzSURQRzEzaEN3aUE4WC9BQlVF?=
 =?utf-8?B?N2EyTkxCRDg5U3hIeURJR2FMOWFvelFHaTZPSkNOdHZLZEl1Yi8rUzRZZHZr?=
 =?utf-8?B?a2JyQkxXTmtDNldqMnZhOFRmQ2VmOElMREw2QngvblJWTFBqL0J2SkhkT2lE?=
 =?utf-8?B?aVN2dzY4eXFyODh1UklCQ0dnbnJheXlNSFZoUEJFb0JlOEZRa1Y3Z2U3QVZY?=
 =?utf-8?B?TVY3d2M2TmhvK1E0Q3BMTWtyMlluTTJIdUIydFo5ZllESFdYenFzYTJvaFpS?=
 =?utf-8?B?b0F2bGNkTlJCdE92Ty9VeElQczV0ZUZMaG1aWlF3aXpEZ3pHUEEva2tReU1i?=
 =?utf-8?B?WXUzaW1wVU1UNnlnQ0oyVGQrQzZqM0VtWmRBR2hIUUN4NVJyaGpWZWlYczZm?=
 =?utf-8?B?SEt1cFpxOTJyYk5qZFc3UTJzNUF1YXhCVDVKMDdxaWJGUEZiTmRnOVUzelBL?=
 =?utf-8?B?RExVeHN3Nk84M2gyNnp1SDlaOExnVVE4STBvVlMrMTVlNmdIckxtYzdoWkFH?=
 =?utf-8?B?U3VzQkJkaFI1K3VONTBlNFlVTGJHMjUrdkxwRk1ncHFlaHl5T1FVdEZsd0VE?=
 =?utf-8?B?REtXdUdneFZYV09Sa3RIejlqWXBHNkhBdG9UZnNGb2tiYy90N3IwZjd4cWxy?=
 =?utf-8?B?bUNyN25XZkRpQjJnemJ1UHU3NHVBWlVZV2JvaEFZVTV5RngvWE5WeEcvOGVD?=
 =?utf-8?B?ZWRPN1AxQXRIY0xyOFh1V2QrYVRnRXlQT20wd250Wm02N2kvUmFsOWdyRHJP?=
 =?utf-8?B?K1A4V2ZNTWpQU2hSYXptbWJZMG9aUy9LbWw2QWV5VEFFaXcwS25OMkFNaG9H?=
 =?utf-8?B?dk5xWUkwRGJzNXF4dUdUbnNaWkh1OUJTaU5OdkxtaUEydGI5MzZhWjhwN0hW?=
 =?utf-8?B?d0JmUHdKREZGWnRNRHNUeHhXYXVFOGFsNFpNV0xQYVlmWTJiVlhWOFRRaVFq?=
 =?utf-8?B?Ym80b3MvU2IwVDZZQWo5ZGhIUFhrWmpsbU9ieHRIOTNqOXlDOFMrS1F3TmJq?=
 =?utf-8?B?eDQrS3ZwOG1BOUJXMzdZejJ4bHFLRVlIcU9HYzFFcjVHcnd2UWwxNkNKSTNn?=
 =?utf-8?B?em5Mb0RBckFTckgzNDhUa0JEYnRCM3JzN3FEeG9yVWRQNkJ2WThJMGlzWGQ2?=
 =?utf-8?B?T3VvWnQwOVd4SkxvTjNZT00xOC96djMyN0ZOQlVPYnl6Qk45Nk5sNThVbXJu?=
 =?utf-8?B?RVBCOG1tRGt1Z0lOamQyVUlVRTdEL2ZFMWtmcG5HekRuRHNHcGROd0w1Y2dm?=
 =?utf-8?B?UUhOanp6K3NZQUhXOExxMjh6WXMvSzlLMXNJUDY2WjJCQlZzZ1pPczZDR2Q3?=
 =?utf-8?B?U05iNGZPM29LMTNhSTM0N2U2YWtPbW1GeWJiVGszbUx6azV2UjgvdVZ5R1h6?=
 =?utf-8?Q?qRvjvrvNJlycr8K446u4413JUW8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e3e11c-78f8-4188-aa71-08db727a6d7a
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 17:10:35.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9y+DXQ/JxsBYhmvro1VxyPaUr2neURm7lWG4vgN2QyVsy8VdePWI66kAb2g+OjPz6BSkmFvFNoPBoftVkXY5aWEfinokadte9n7gUuHR4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_10,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210144
X-Proofpoint-GUID: 1C_0rR0wUlNtvPoqZWDVJlYcuxvYhHHZ
X-Proofpoint-ORIG-GUID: 1C_0rR0wUlNtvPoqZWDVJlYcuxvYhHHZ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 5:32PM, Ilkka Koskinen wrote:
> Add JSON files for AmpereOne core PMU events.
> 
> Signed-off-by: Doug Rady <dcrady@os.amperecomputing.com>
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---

   CLIP

> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> new file mode 100644
> index 000000000000..fc0633054211
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> @@ -0,0 +1,104 @@
> +[
> +    {
> +        "ArchStdEvent": "L1D_CACHE_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_INVAL"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_REFILL_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_REFILL_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB_VICTIM"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB_CLEAN"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_INVAL"
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L1I_TLB_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB"
> +    },
> +    {
> +        "ArchStdEvent": "L1I_TLB"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L2I_TLB_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB"
> +    },
> +    {
> +        "ArchStdEvent": "L2I_TLB"
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_WALK"
> +    },
> +    {
> +        "ArchStdEvent": "ITLB_WALK"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_LMISS_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_LMISS"

L1D_CACHE_LMISS is not defined anywhere.

> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE_LMISS"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_LMISS_RD"
> +    }
> +]

