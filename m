Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2D46A1E16
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjBXPJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBXPJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:09:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7541938B5B;
        Fri, 24 Feb 2023 07:09:03 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEn28e003371;
        Fri, 24 Feb 2023 15:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=CiEDBspRIilkMICfMhJGRQGGxt0SEiW0KpnT7xM6t0o=;
 b=uCzWUV68vrTpWTQK48jsvvGD/3bOuMNBcP1eehSoiFUezicwoy3O6EHR3ysiZUbPhl7+
 uz93QXJN/6mj6ByTtnzL5Jf79yPpguMJcqNAtfbCos95USJlLtT3ksGI6YphxaVE4wYT
 WOZ8NCcW/GRLJpcbuqBU7iy3lCT4OQm9X3c0BfMqmB9RJo6EShl9bn8x0B39KTUTEiOr
 mMA8gzonMN4oDUDRj+65hU7sLFi8S5Lqi41fCO70glAmGCiTQ/0RMO6s/mk3457cu3hr
 /PUTqFlEuC6O+dM6IheHPiY8Nh3xmyQra10oU7kJGGhqsAdCFhmX208lskG4mP9P+f6L tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnf3nb9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:08:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ODI1FY017898;
        Fri, 24 Feb 2023 15:08:55 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49v80m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:08:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWqeSUtEcGPsbk6+cyL+n1E/rVUKuq92yHH9r8NRNeZz/YcEtchajGDCpyCxZOItNaRjspZK2/YDeBjipiRGLb32gozC7mXZkY5Kox50y+4CGo2DtaqA66E3cirLIN5AmbevNIc9ppxXKGDyPprpXwIyHVSYNAV34hq3I8IunVIc8XGz97JALFwuGI3k0ohjCXjoJRA3Gir3Nkr9B9+TPEA08KtlEUogED6DYcvPr0AGHfDPvtw5p6XMMcCWFWfVqeLqOAFtwF65UZJ7DIsLhW3Y+uDvm4753pt/5jU99+1k+nQOoVTcqnYD1NXPTtBGXbSwZzq+EAfMQ9SmTxA4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiEDBspRIilkMICfMhJGRQGGxt0SEiW0KpnT7xM6t0o=;
 b=g896FT9tiu9cIj7l8BGR0bPd1Y01tQVJsFG2c305BR86+25rV7Lc4W6jLxTjw5RVDWum9D99vfRmncZCo7yXoUbtbcTBBnTAwp7TClF2wvISiWw0tiTyRRj2SUkaE6Gq6LwkN6W8/JviRSdIlbge9xwgHlySD1hQOjKxZJ0ujnmCgFSa//elrJ6Q34fKPq//4wzJ5lvA2R7+1yDfcT4hVVRNly/kN0yDp8wYJLIithtw17Bh1d7wEB0VsQJBBYsVGdmGY47fuEqFP1SO82WYK/djYRjE7Uc7kFpPIATUxPahbS0q5KnsYkjx1uTYUoBMDyFy90gdoFc1qwVl9VrJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiEDBspRIilkMICfMhJGRQGGxt0SEiW0KpnT7xM6t0o=;
 b=jW9O85b+n2UtR05v6j1JJB6D39wpGeoOvDtlPWmRju1s7R/+q2xMnRHbEfUX7gfGHmwIovstwB0iw9YcOqjECi6nwXRFq74QBVdu+DPmWe+6zdfyOOnLlC2qn45h5eI/dICZTp71RYW2Pg6GXL/pZ3lddtLKYs34O78eBu3zMBw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BN0PR10MB5303.namprd10.prod.outlook.com (2603:10b6:408:125::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:08:48 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:08:48 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH 05/27] cpufreq: intel_pstate: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:07:49 +0000
Message-Id: <20230224150811.80316-6-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0112.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::28) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BN0PR10MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: 083a87f1-81c5-47d0-5955-08db167907b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWUE+JabOhe3nDg4imzxOdWpVumajTsBKJ3FCUspIHmIDgmOAXe2zx1/E/OqleBD3E+F5Z3DMZ2JXWfe5h4BacZeNiyBgBYcYleiQNZbqP2nxFnVKbjNi6lr++PFRl2kvtlB9hRPUkZQRNjG/GwvXlwSoRBQlur7Oct48KEMW4/mGrHA1oaSHrtDpq3ff0/jXrrtHiMhelZe5NY/tQ0YB0iZvAnVsHnzJcSoNk6T3WrjI1MepgRuHWPeW7Q+UnGuITBVsT1ToB6BsP8z1EwTpOGWJtjbTynLRfT+HD8LqTbX9wtIfTX2g37fZ164XBfAoCiPuD8/QNrINiZaRsXPCqGl4xWGUEUSqX0ILmREX9DbXr4alL+z8P7I/76JAbdncN9Ey4vtUiM4L2FSwqMjL4mKst9vARshTjMoQSryi6rd7uplUJaKa1VIOQf4BIrE1sqWPQhwECmUF8yKoskTivk1lnImrjMUvdPVgihHNolLMESARHHxV1uwvImF87WuAB7ot5S3tHqp0NwtY1G25shwnsOVBjo2ctM2LJwGAlhPJK2G5JAUmYF+flS3x1C1/wpS4KFlISiqRhOzS4Gf5f5FyT1Y6SizRrE8uDp9YBzJHZqUUkiTS+ImmRxZ0MdUWtcB7ldt0jLHab9bByYKtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199018)(36756003)(6506007)(83380400001)(2616005)(1076003)(6512007)(186003)(8936002)(41300700001)(6916009)(4326008)(44832011)(8676002)(5660300002)(2906002)(6486002)(478600001)(66946007)(66556008)(66476007)(54906003)(316002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yCUXOqcyhVkO5E35QwnS4/KwqtWsT4Dja8mus+UnSe0MApwMbp4BgQdgH3sn?=
 =?us-ascii?Q?zFRhe9+oNUE3SFxGz4sslx0GwMVL+YNDZG8TNX6eZvDnAfsthVp/QnSgkYew?=
 =?us-ascii?Q?QWbHYolCdZvnc6Zln9g98cxom/hcsmT/uKfcnJW6PIP5iLm9M4EsK6YL9tQW?=
 =?us-ascii?Q?D967A1GTEJqKT7OkF58vbz3Ddww0//MmsVtG0c28+46jIqaZeJUbtx5yvpG7?=
 =?us-ascii?Q?D3cu7e5AznMETvN8oi4qFiZ8KRVqJvbH1Txv7tWzQH5Z193SoUcOU3vBYs6V?=
 =?us-ascii?Q?hD43idublY8apkcYtUbXQ6R0NcN0olfeW/QNq+bxW8VWx5rrreHIhlHA9JpW?=
 =?us-ascii?Q?RmqT4U8PlBrMUE0HmfGv2FJrilQzLFgCzcgGesSOp/aD3orj+U0oZ/bh/pty?=
 =?us-ascii?Q?/fqkoWpz46mfKYJ7PbAlqCVzXJJHK+kdWNxQlB/SKN8c7ONqM9QpIVl6KCnl?=
 =?us-ascii?Q?9au+k0oErZKYFl2M6ewpiei9KVB7vfgBt0fJROMZJTd0+Wr6inX7VdG7FdHY?=
 =?us-ascii?Q?XZpEijKbmZUdJclAfftwU1OVhg57WhiSbIV/0QI9LEs7xD2SuKWPp1q1v8pI?=
 =?us-ascii?Q?D6Qt7nUzBesFxeBh6/asmaMMu3ZwfyWgm9iyWa/GtP1Jx3+WaHPcUWzacf3y?=
 =?us-ascii?Q?YKhHxZcx35GA6q8f8AzLMoITmrFjgN8aOiuYSuvXZRLyTP2aUFdwmJzkzOAm?=
 =?us-ascii?Q?UFyjDuxHjJl+gOAtuYsaf/zW9HkzSiJejYxAKj1d+lU3jlk9yxGXwfhwDOOI?=
 =?us-ascii?Q?6/dLaaDqWInYC5UbOg/AwdlFf95QrZBT+3JN0slsUUlE9hYn3Uey2c65j0WF?=
 =?us-ascii?Q?fSaKDH60+JYZqKauZLAQI6k2II8mdRRjjRV28/NTecHBGnfbOG6TPYrM7gEk?=
 =?us-ascii?Q?zrptOsNJMnKbvV9WAbL8wk1AmnuhI8HjqWrrantLrYEllvML22hxPI7AQIww?=
 =?us-ascii?Q?+psWuBi/ntRSJUdoOD60MPYpsx/1c6QPLjVraubGdT0KD26H8QKaqXiCb+i/?=
 =?us-ascii?Q?ovI6XKpoJzKaf/0c/kNqKGeYIXjo6wFKC5VlgFjrtXOTBvGuf9NisyX55Oi/?=
 =?us-ascii?Q?bdx2OWqjzEggJnw2PIakcZeOastsbD7RxxTuXyArmpCpm82sT28D+uB0b121?=
 =?us-ascii?Q?60pdTvg1gLNXEBqYuVoILrLwuyTzg69pT8/XhpkNnUOxhn3SJxnJwcr6DnCj?=
 =?us-ascii?Q?/Z+bRglctWYph905qjFL8AHehH04UNh7K6gOEjpiWx6ZpKjTDgndApaT+2Mu?=
 =?us-ascii?Q?xgb20idj8ZFYapyXyN7iEfdqcgrrlrZ5ie0vcEWdGOePeUlUBebi0Uz57HEJ?=
 =?us-ascii?Q?js6O+G/CIu1EcmZT2ppSnl4T6Gt4n2wb3vphWBJeDY7xxGJ1MOsXn8+g0kxc?=
 =?us-ascii?Q?uHxkAdLT60l9k0SKprWpGzQG8zIbzOsx6imPovOLsG9Bgj8W1513y4tJ6uP9?=
 =?us-ascii?Q?GQToyQuxlQGPK4vbJiD3+6WIVp3o9lG9lGz3SOyW6eCfYX/tFPD1FF5sBvYg?=
 =?us-ascii?Q?PVe2DXks9P1rTOetdw5+l59ngtG8qSdwDHWceNFsnimoc99BgVnU7IUZU4Gk?=
 =?us-ascii?Q?F+TeEBjNZD6FYJUb5X7UEoZfwhif+2MILLZ1gv+MjzTqoscMZfRhUGkhQVEq?=
 =?us-ascii?Q?1nDtaZT7uIRMpyN1d8QjQZs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TdZJ1a8HiF8gNH7NR3pR4bHPBVoPhpYWb9X3CldaGAWQ1GiNVWkqVLi3H0jvvOWmlwPN5ZfVWNZDANwkxFDYPEMXZU2Fup+Pk+Ger121Eo+DkpfYjxvrxQZwMsbap+TrYOYEsuG9XsCrOvItnKUbdl/CK3FC4wfHMxVMZqFT+Nzu+O+R4U9qkpt96XknDC+zYEUkQMu0IFlMvtP9B7l+DqD3jN1hV3SXhiHcY+TFFXC7f8DoFL15DozQOJDGZ2ehvHoVfqBwoK23IjDrIUiagNmWDcmKKsrJ+ePwF29Kb8aoT8+f5XX80aSeZN4yIorg7EOEM77QL4WPWmWgtt4EiXvWcm/OHveTBLcKUVB3wjdYFBRNyrWU9vAHHdV+8H3EnBctBd/oISRPOCOUoxhg/5vx4vLcr7yoIjviDrKQ5UXsyCYPmGl5xNBrLTwUVoMvx9FjsY3Ee3Y/iwkblNKFhvciSTp9mTtRTcFJL3RUS27tGo2DLvHkTCimN5EsPqOgiydGPkdwObVgqnnbMC41wnqcXWlL81BSePacxsxI/nN7zyXTqopEFk8edKlpMyvGb8QGpOQQPs6fBv6XwWXOh+r5+01O9SMr5qr5UcnVRCLiN8PEjrXpRe1cwrjvDUJzvACHTQ5kNaKld/nyiLzxvApMZfddxYhQdnnFLo0JenCyvpVGbx+dssBLb63NNlF+VqhudhDFKHJ3OJr4lXpymdUnYB32Nsc7SbkAffn7sgYbTiWqwg69xMCFnuA1wGstnffPoHDl6CgNrxw89qW3U4PHOWXKLLvDrrlgFTWrrLt7MnrHGQQpzLGXAuiS+YPikSegUcC+p2eM+aTtfE2fXtO6br0ATipbcF5uH9TqTiEr1YaKqpvtpHZ1NT9bmOrjvo0w6EZmHI3bg6e7P5EWqw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083a87f1-81c5-47d0-5955-08db167907b5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:08:48.0146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wJP8DmCCZ6rPwtDhhxyF1mAeCEy8rLXge2OLpvBNG/j7jdKpPyp+EhotZxmEoouj2gbDfq8Qo/HGTuHQVsCtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240118
X-Proofpoint-GUID: fgRTT4lKkUIdruK1LvwDJJE0y0fmNyD0
X-Proofpoint-ORIG-GUID: fgRTT4lKkUIdruK1LvwDJJE0y0fmNyD0
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
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/cpufreq/intel_pstate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index fd73d6d2b808..0f3e1a1aab4c 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3530,4 +3530,3 @@ early_param("intel_pstate", intel_pstate_setup);
 
 MODULE_AUTHOR("Dirk Brandewie <dirk.j.brandewie@intel.com>");
 MODULE_DESCRIPTION("'intel_pstate' - P state driver Intel Core processors");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

