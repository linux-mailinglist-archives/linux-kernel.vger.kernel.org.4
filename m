Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2974069F446
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjBVMR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjBVMQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:16:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07893A877;
        Wed, 22 Feb 2023 04:15:46 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8xHjv021535;
        Wed, 22 Feb 2023 12:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ptKJ3FUvFm+ZButrDM1UJTxpeLlBMMQ9k4v0GuxW248=;
 b=1nz2H/y/+tH1pt7b5hHtOavHhma/FaIEatDxm5CNJCHsZkjsWMXq89EOgDvSuYREp+Tx
 YjMXlz2C8N7xaRtXWXMtMYUsgMWWMerp7/I/d6mJHd0AxpI28hwpk36jly5YqE1NWG4c
 ECExIgizcJBsVkFo+lCxWsIWGda2PepyYWtjXSlfh/OnQBNeCFksyYCcT4LgapdakcFs
 vROpsSEUi3GxSeM1+NkXnybApcSJsek1v0crhc9IKzLUjYTrxg9v6o1OffIL6EgonsuL
 0dpF17FswTJFHwhs4631D9VwNbHkSsofnQAC74qZsRUJyKd4myJSSG+L3q23lmozJgja +Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnf3fq5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31M9tcYj027246;
        Wed, 22 Feb 2023 12:15:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46qybb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9Ry026fddLuG1GM/DIx37uSc7u61DWtD76PlK0Hx1FqU98q6X8aGNx5hXxJumQXADww1Qx2zetYed1LyXl0QUJ5iSa90Aen/wNyN2SJ0vvCZg+az6cW1M8W9vZK8RTXpd7uNkZwfOugHq1RVml5JaAZsImFIGdXueZ8Zg5jU1HY9Ph0WvmBONJivlTvkVDSEe+KZJZEizX+J7Ys0tiAjALwjkIs5vF9EFwk5+FRJdziTU87sF7CMSiWKoWtUU86T9hmZmF1PwUGqlPg/6tgVUANttgF5Ctil5EPjw69tXnqo4iTPaAVvBR13GVw+zKQ1th56oY4W1HCOgzLb9QAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptKJ3FUvFm+ZButrDM1UJTxpeLlBMMQ9k4v0GuxW248=;
 b=ZYHc0R/jvH5HN6w30WkxeOdouwSvLxgmL9VHk4V0XtWFrTkXQZibI9M7JPH3t2MU7zX6VfiSlLRVeH2aRCRgKWRgHrujuVyeylcBW5aVtOMhBaPQ93rox8ko9OWczWEIRYVTF3fkKYD41TfS++FitxKpwGUURdgqmyy7Jt7biQhrmU2cFaLKDp/bZp6GznhSLX86JR4iPohV9ZXzhgafRjH5Z+SePurUIkqik/kWkeQC8B6gSH9fVv3aS0i/pfBEHbuHvQmIb9gSGMqCyKSQJnJLB0j5U4XSe5v1BKlkF9h1m1CYsv2q8wcdmwoVS0PcXFqPt+9cm1mVv1q1v2hYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptKJ3FUvFm+ZButrDM1UJTxpeLlBMMQ9k4v0GuxW248=;
 b=eOo7QVZR1l3wEonUF0YnSri5oIlR4yy6zE1LqXGOeosIy/puZD32DjsynB4+U/DOgWNjdVsH9ZZ79V4TX7MWXI3Hq0c811n8sl4Ztu6Rqg4DyS1hmP6vT/E6wZygFfEbrVBm9eTt1RtuO/Vd8HhqSumZY4rnZlkCPZ350hDj3jI=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH8PR10MB6412.namprd10.prod.outlook.com (2603:10b6:510:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Wed, 22 Feb
 2023 12:15:33 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:15:33 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH 06/27] kbuild, pinctrl: bcm: ns: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:32 +0000
Message-Id: <20230222121453.91915-7-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0242.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH8PR10MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 577d36f0-d040-4864-004b-08db14ce7f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tP+lrAoSsAmAWRgD9RP/0qkyl7B+eQG4DFoziqRIw7IYM0ph6Rx8FEG1BJ2YXgNRBpT7VlJdf4nnIALGfh/P7clNZVr54A9JfolMgbM6HLSRBDeTbuLfe3fpkbA7egLs9FfJwhNgy4OY1Whs8kkqt+KeeMCzNEbxk52xA4NVbjMOqvDV4+v1xRljApdERy3q4451xxrrOEOcO8NJ21pMPTxSiN0HD5vIxiHUYURykBUy0JtjKLXR+/LmKBGraI4QNxeNaZzVgXNCcv6yorogZN/YNxfynvWx0pma7z2waE1tAFIpUJfgEuIkJ7w4y3afGmytYFNpYuOTT14NtlLerSXOn6thTyW6YbvhtCj/0/6Zeic9Smrlrl5NcjuaygY9BpgcwrzWyy0EcudXuPwyR4EjSrU+YYkeE9JDyg9H/b2+nd3fdZRAO/n/vxP0vmEBNJG4+JOCwjxcTdX4lPC/EKSPTucHS3DzzG73i9JnV8QlhbygFSG0Jf7cgF1E50z+vOrcwUphO+dc5Q/UrwGjZOzka6KzlSUBr8dJHq0zCtaJOQPMekKNY7tXMvKMfSPKmWz0eNXj8cYPbik+xPJQzfNIPsTuaoTumy7UZKNYSWkxLe443cG1+aoE1BPV4RXYfz1zsOGM5M0uekvTOr8kZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(478600001)(86362001)(54906003)(2616005)(6512007)(4326008)(316002)(6486002)(1076003)(6506007)(186003)(44832011)(36756003)(5660300002)(8676002)(38100700002)(66556008)(66946007)(41300700001)(66476007)(8936002)(83380400001)(6916009)(2906002)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NktvWnRnNGtRQ3Rjclc3eWVwd3Avdk9kaVp6N1RYME1SOGpHY25tZUNyek0y?=
 =?utf-8?B?TTlweDdKQm9NR05UYkRPa1N5Sm9EeVhFR3Zwblk1UG92L0hxY2MwY3FkOGV5?=
 =?utf-8?B?cjFKaVdlNDBLRHdOaEwvQkNDdVF1b1FQdW1QOW1YbDNibVVvcWFFSWJkY1ZY?=
 =?utf-8?B?enpScFUrYXN5dG9PTllrMmNSUm0wTzZpSlFId1hsZnBUdjVjckk5Q2FGSGha?=
 =?utf-8?B?bVlQT3h1N2NzSVJ5bTBteVN4S1dta0hTNkFpNkVMY2piK2E0WFNtNmpFK1hP?=
 =?utf-8?B?SVFJQ3hvTVVRZHJwY0NvTldZTldhN2grazkzc245bEdQOGpYcG1zeVp1WHo1?=
 =?utf-8?B?K0RSSnpJSHowMXVTWWdDcjR2R21TZm1DTklRcXNSRzdIbVRhcU9sSERBQ3lh?=
 =?utf-8?B?bWRCRmIyNFY4Z2ZlZEg0bXdqaGRuV3NMUzhrcVVXN0srb2x2VHZCN0F3VFIy?=
 =?utf-8?B?UlFDZ2U0NTNTbEdPalBOK1FGZitPRmZYSWdJMmNLNHZJNTdHT2lEUlYvb3py?=
 =?utf-8?B?WG56Wnhva2JtMXNKWTk1aitTZ2JLWFhQMzB4ZjdOR3RkWVJIa2hpYTJTUFJm?=
 =?utf-8?B?dEtLZEdYblNOU1NFZnROOFd0TnlNdjA4ZmUzRXdGOVNsVE5ORDdpZGJOVmFP?=
 =?utf-8?B?VUQ2eDF4c216bHBzUVd1SGlTTTdQandUY3RYZE9Dd0xQazU5d0pFbTRyK1ZT?=
 =?utf-8?B?U0doM2tzS0J0K1ZrNTZtZ285aFQ1ZWJybUV5L2tEN1c2YUdVK3ZBbFFvQXZO?=
 =?utf-8?B?T2Q4WWhvajR2YXBOZ1BrNVA1NUs4QnNvZWo0cithUk9sN0Z2bDlFbEd4WUhJ?=
 =?utf-8?B?cC9ncEQxZXJJcUZTZkZDRHp3Y2wrVnU3WGMwekZKSWpwU2p3ekZ4L2NXQU1G?=
 =?utf-8?B?ODJaMEdLaHZuZWxZanJTNE9lNTVSaUQ3Sm1hbFZMUU9LMnFLd3dVWjRqaERO?=
 =?utf-8?B?RVY0aEpSNW9JWjhUaVNQTGdSSmRvYVd1cEpjVFROeTdNdUpPcXJOUmx5ajNZ?=
 =?utf-8?B?T0pld1ZpUEJ6clpzM0h3M3d5OE84c0FZM2ptdHI1dXBYL1hvOXZjOE9EK2tp?=
 =?utf-8?B?RWpmRzFWdHVQYnhpZVpGbDVieEQwY2tjTk5NOUY5S3ZIZjAzOUtPdEsxb3VJ?=
 =?utf-8?B?R3ltUnRUaVFycXllRVpJVDA5L1RtbWVxQW92ZkNtbXEwOXYySjNneW1XTUVu?=
 =?utf-8?B?TmhwRDh6K3VFcFd1QXJqVklQcGk3SjlrWGx6ZWpnWDNxSW9NNjdLcTgxUGcr?=
 =?utf-8?B?TGdDYjNPam9naUpZc04xOTU0dmFsMHdKVHVpbTlVbEtNbTJ0bm4zWTlBMjVn?=
 =?utf-8?B?d3lWZ2xoaTNyN1g4aVNXRmZlRGd4Z2xPWVdibzc1VGZkTHBoc1hwblhIRG4z?=
 =?utf-8?B?S3E2TS9WR2Q5cHZmMi96MDAzY2hIUEcxSDUrRERyelZpbGR6SDU0dlppenh6?=
 =?utf-8?B?eVFKYUZkbzFaNzVvSlN5QmZLd2hEWWVJa0JSUVBxTkhnaG5YQ1FXMExGYTJO?=
 =?utf-8?B?Vm81VWdaQkg5YURHQzRhMW1NWXJRNTRiWE92UStsMWFFQnFsckR0MUFCNzFr?=
 =?utf-8?B?Mm1UM29Cem5tWnozMXdlODhXa1dXZ3NXYXV1bFhzWGZJZGZIaCtqZXRDWlY3?=
 =?utf-8?B?Q1kzNzV1WTZSVzlJZ2RJZzYxMUx5RjBncWduRHhkTi80aDZwU3ZlTG1NTWVX?=
 =?utf-8?B?eEVKZ0JyZUVUNjBpWWRCNEJlUE9XOEQwUWp4N05mRUxIOTBVODVvM2tWTk5O?=
 =?utf-8?B?bitZbWZSbUxGbzk4bml6eldXWFh3RFJWa2xNdE8xeW9SWFB4eTAzZTFNUnNE?=
 =?utf-8?B?QTAxK0VQbGZ0TGtYeEdPTzdWTE10dXJUT2pLdm14SCtjQytiUjdBZ3FyRWlV?=
 =?utf-8?B?eXhZVmFyZnlIVTFpN1JoWWxHcExBZ0d3b05mKzlTNUt2WUp6d1V1TERsbHpn?=
 =?utf-8?B?RmFVcXRLa3pkb1VtQnc0R29YMGNIR2JZNDJlT1Q5b1FYcjJ1ZjR5clc4ZWtV?=
 =?utf-8?B?ZEFBS2JvWTkwbithS1kraEJ2WU4wU1hrRGtHT0swbFJNR2J1ZFpvcURBcVFD?=
 =?utf-8?B?ZUJmbVdLalNtWHZ0MkxjUDBhUHgwaDNMMGRqYkROQThjeGlGdEQvK1grTzM4?=
 =?utf-8?B?LzFUZHhETnlMQ255Zk1ZcCs1VUFKQzhaRE9VZlh3V2lQeVAzKzdsVytiOTZH?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?R0RGUzJKWHcrb0h0aUs3OGQ0MlVXWUdwdE5WeWNEcGNqbldrM3lPSjF2Skxn?=
 =?utf-8?B?enoxOUMrVjlxWEpLOFdROGxDMFRTemduUGpFUHhXd3dJaEFRSG9Bc3E3Mi9J?=
 =?utf-8?B?aE53YzRoRU9hbFhlZnYrd05Jdm1pVlhseEozUEhBZ2hlb2tSYTJpVU9VZ1Ba?=
 =?utf-8?B?R0tWYWVNSks1dklBbUFmYmw1TUZxOU1MRnB3cXBYZzJRUlRFUTdYbUdXbzVB?=
 =?utf-8?B?bWFjUVU5bWRFQXUra1U3cVB6U01XRnJyS1ZlR0MrS0JiNmF1RXJRRXFKVm9O?=
 =?utf-8?B?YXlNbWROMG9hdU54UWxlbjcvNUVtSkwwS0haYkNOMTRmbHJ5QzdTdDQ1Y1Nj?=
 =?utf-8?B?V0JHdHkyWU9JU1EwSnRwaEkzYUQ2eUlZZ0l5VlBzQkFCZWc1cDgybW1DcHR4?=
 =?utf-8?B?T1pOTEZScXArSElLdERLUzd5YytGcFVkcGVTeG5KOXUvdjU5Z0NXZHY5QjVK?=
 =?utf-8?B?ZmJkZGhJWitXRDVIQkhxUEovRmNSb0NlSGFaS095bjNLRVpIcnpJek4xZysz?=
 =?utf-8?B?VWVtbWJ1YTdjM202N1JTUk5IUGI2V3hlclhHVkQ3UmRHOG9LWWp2V1dlempX?=
 =?utf-8?B?MFpGaitYVnRkaEtHeHkrRUEwQkQzZUVudUZyYWhpY1Y3eWYzNXY0bmY3aVVU?=
 =?utf-8?B?T2d0OGsrd3hoNHpwUkVQa2ZNYkN3YkZ1VHd2ME5KanZQM0dQem9pTmlrRnl5?=
 =?utf-8?B?dnBjSGFvM0VZRGZQN1dUZmQvL2ZhVUllZ0JCcjNoSmFLTGkxMndqQndsaTda?=
 =?utf-8?B?OUNHRmVoQWs5MW1qaVBhL2lYaVc4OEZBSkViM1pkVjRRK3JGOHAxeFNvSk0x?=
 =?utf-8?B?dlNWMlZwTzgzUjJaMVpSTjNuRElkekxPVTI0S29nYXJOSXcxSjlPRk9KTUJ2?=
 =?utf-8?B?ZXEyYjFJSWR5bWZ1QnV2bGozN2s1ZDFGTVdMUWorWk4yWEx6MlBjWVFVdEJ1?=
 =?utf-8?B?RnpOc3d6L2hOMzNzWGJOSWtmUnBDbnZBV2ExNHlOMGRhOUZQNmVaZjdya2hj?=
 =?utf-8?B?OWpza2Y5Vkl6Vm5KWmR5djNrYkVrcFhZZTRndTdOOUFva3BHQXVrb2cyYlZl?=
 =?utf-8?B?b0NqZ2k0VitQbCszZHBoNlJPYlhzU0NsNElFSjNQd0ZvZ1dFVnMzcC9PaXZu?=
 =?utf-8?B?RjJoNDVTaUE3b2VFaTBjTk5EL1VnWVZGcGRaUGRHM3BoMG9mdEEyYUVJYnpx?=
 =?utf-8?B?azRoVFU5YVpTWDlseFJSZHJPS3p1SmwwR1hiM0tNdnYzeFBRYTUvTGlGUW9H?=
 =?utf-8?Q?wQTNUlOuR8+69J3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577d36f0-d040-4864-004b-08db14ce7f46
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:15:33.5263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWX4ouwyURZoNcoFRNMmzEfZUprl/B6hc6/8XHTog8/6zSkPbxyiQOTbs/0apiZsTyD0LIZgfdnw8UYN2/BjCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220108
X-Proofpoint-GUID: Tq2CQZnHv5UVRFQXNNR4eObfDzYYkx4P
X-Proofpoint-ORIG-GUID: Tq2CQZnHv5UVRFQXNNR4eObfDzYYkx4P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-gpio@vger.kernel.org
---
 drivers/pinctrl/bcm/pinctrl-ns.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-ns.c b/drivers/pinctrl/bcm/pinctrl-ns.c
index 465cc96814a1..f80630a74d34 100644
--- a/drivers/pinctrl/bcm/pinctrl-ns.c
+++ b/drivers/pinctrl/bcm/pinctrl-ns.c
@@ -299,5 +299,4 @@ static struct platform_driver ns_pinctrl_driver = {
 module_platform_driver(ns_pinctrl_driver);
 
 MODULE_AUTHOR("Rafał Miłecki");
-MODULE_LICENSE("GPL v2");
 MODULE_DEVICE_TABLE(of, ns_pinctrl_of_match_table);
-- 
2.39.1.268.g9de2f9a303

