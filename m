Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EAB6B070E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCHM1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjCHM1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:27:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C7BBAD3E;
        Wed,  8 Mar 2023 04:27:28 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3288E0pO010415;
        Wed, 8 Mar 2023 12:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=wOrYb5bgi8BBLJqmXqVoPAEsgmNHI3uO0IS0khsONoQ=;
 b=0NG2Pnw2edSZOsywGyVmzKgtKJk9XUcdMYoBTSxQuG3LvO2kHzB4XsM5+y4Cz03hWg+t
 jyIW/putH86wAfxnEGWzoh2JtCFY+pZvc9wK/lKcVCFhKtcIkM+LeAPbsYzJNMYb82zf
 WeSLrmmuRFrhjpD9w059KehqQZUKUxK/O99uXAHpj3AJOXuO0yNyFBA7UcejHnzgksZ5
 Vb4nQBEi1t8EsWhJ/fQyTfSB+chAVI5Bou+/S38zTSD94xWRfxX13lHTcFLATw0Ecyp0
 v5zd/qBttr8BgFHqX+lR8nxmqoN/kre/WocY+7Pe7cze0UHuktehyB6S+qhmmtMZDu7p dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417cfy1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 12:27:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328AiKfi021718;
        Wed, 8 Mar 2023 12:27:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fr8nup0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 12:27:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TK3ZvLXBYTgi3ECyCkRD6b4UZ8ybba/P6Wsu63aeT/JaJGIY9MitzsSKRzzW7eJaRd/MiBiRAmPupDuKZM/SHYrT8aNbheYGzylWkmuQhrIMlzR2XCQCMKJhlhbagbWoRMzgDdq92e/QQqH0T3K6QYnIYpY7eH7J6gxqx/evzKpBptDyOMr86QPqK/wnv3BNDn7bppuWE97/LHc94UG5Hvk6ugVYkbxYCdIWv7dHqQTwdsTJjVInfeLKtp5z0OHCvhReNwd9krDYq+g2R8I0O/mwjPyp+NQ2NWzUZhkB8vuMsYlVt7TGq2sMbR7wXHxM7+Kg9v97QaHne395FpI/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOrYb5bgi8BBLJqmXqVoPAEsgmNHI3uO0IS0khsONoQ=;
 b=lysR448oLhU5zod88H5c7o69dWsDersSpL5HHMlv3JlwBi9vIzu1r5dGlgfOC+93TaZck+MB1oyAR79a2z9FGhoC1Lpf6g1QPSrgmkvdDhJqpcDXVWt20XybdtmptjdrQvvHDL41noiwfZ8njcR6j7IEm9Zt31Ly65aeJ0mK/KfsdB3G/7mTDdVuldmXDDORoXKx6IMNsKWo3GGvjFboabey9cd3ag1HBXYpt7imDZHpG/PEuK7udeQI7OODUs3v0Ip0FE5ECQJrTlo++d+mT8fXWnWRsvTaVvN8WIkM2+dSWNyKh7xUHiOQuZu8Bhfa4I58RubTAGgKpZegKe7heg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOrYb5bgi8BBLJqmXqVoPAEsgmNHI3uO0IS0khsONoQ=;
 b=te+e6wC6XQiTBsLvRsfU2TRGPmwV02/vyH3hTHozpcRflpgABj22SV9kZu5jbePslrgM+EWduXUgleRsf6JjODAVUByakarW1FYREV8xbR49+LSQMbcxBGzUDQvdz0XAy5Iy6uJvYi6wZ0ADvHYpnTV88oikDcA+AboOITDLVIg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH8PR10MB6551.namprd10.prod.outlook.com (2603:10b6:510:225::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 12:27:09 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 12:27:09 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     michal.simek@xilinx.com
Cc:     Michal Simek <michal.simek@amd.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] firmware: xilinx: nvmem: zynqmp: make modular
Date:   Wed,  8 Mar 2023 12:27:02 +0000
Message-Id: <20230308122703.114549-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0334.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::15) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH8PR10MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c73992-6ae7-405d-7897-08db1fd06fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QscgloKnkSNyRSySJYFLvyOPpx4Xp+5lc5QsfahDlqpnfM5wbfwwT4FTsJp2xz3ZCKm+qoaboI2sBwnQhl2StL2B54B6GsjE06yQqO9/F/czoODEXeU3caF45Qtf+1oJ9+rPrQzlf6WafeCrkQT4/priQraq3iLcykMryxR25STMQGifPkPUuGe0xiDAH9g07QcXItg1QbzU6xf2ADEGi0MHudXuYeO98eM6LSuRjXOpHnbskIFx+NEeFON8bhzUeR4flcLKdgrPdvoaEy1wnm+0tTff+Ov8311OUjUdT98LH9Gmb8aUAaV8unb3/4tmDIuuOvpExrB5ZNb7BmFec51gHXaElO0qt875hFTpUPdr9BY7EmsmjCAs300EAIpq+riEUpD70dMS9ylu1E2HJ/tATVeJGYjPtOFlXPEQv4ud6JpxlMNtEvNMn5J0OclKdWjfGWVj/W77/BeD3m3BzfTqeF548ON8qExTJZoTcMwkccYdzNUKmyf0TJz5XG4mBShRyBzL0vaSRcgIjsv57FnnJmsHh8FE+3+P/tTMbsTjg7kylCH5BPtjmATcCXWZ74WxEsfPlpi5b7C75+hcovfbWilk9pr+tVJAcAYR5nUX/kS3VjsxQS6YlcTrjE4BgZhGeDATuKJxY/7JPkUUAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199018)(66476007)(66946007)(66556008)(316002)(54906003)(2616005)(186003)(5660300002)(8676002)(86362001)(36756003)(6916009)(4326008)(2906002)(8936002)(44832011)(41300700001)(1076003)(6506007)(6666004)(6486002)(478600001)(38100700002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1zfMcoKwAUKIpDWcypW2Srb8Pos1LAaFZY1e2GdIElWdG9FH4UABZN5MF4iU?=
 =?us-ascii?Q?rJFaPMiWDZ/DbzmXr/8QBL0lHIXMpxcEEUlWedCzKFmHqgopSjAA8HiuQkuQ?=
 =?us-ascii?Q?yXBrwUiA5U8rNDdK/t8b5gpNOoMQcKNr2nmUVJC1zs6VUBl+nBtkmi8r5EG+?=
 =?us-ascii?Q?SHirnfxRyaV7gCZyanWV5MULSs+rWj7nj4aZLBHyDGIW1on9/Ytq7dtkGzgG?=
 =?us-ascii?Q?eGB5ftFNNJ2ayy0itmqMVVM2O37NQT/hY7jd18NjLpry7JYU1393FR+bYAl+?=
 =?us-ascii?Q?qSk47yZ+uxjNAy4H2VufOeorRCr57xUwKH8tiLermOvVNWb++nFqje/fem7+?=
 =?us-ascii?Q?xHBT+NRzsGpjDHPX6bZ0GsBgavM51WFOT3K5C9rSgpcjJ3gBQOCCJ6fRT6dd?=
 =?us-ascii?Q?yJ6aTI4Qd13yqZoJf1EFFoSPKsBlS3mg2cI0bwENX+95CIGBl2iuI1HT5NYE?=
 =?us-ascii?Q?Jf9j/cZlaPeZTFdkdCMWnqo4h0teNaHI8b3OQJksXzS46c0rD9SIlrayZA7f?=
 =?us-ascii?Q?l1xLtTgq5h25xSrRXm+pvN6OgSJEDXdc9ot54WmFmmPEN0iY2P9W95evgWzT?=
 =?us-ascii?Q?+UEw92+J6XErG0jYj55NYecXAdoIr6lvhS9dPAs4BbmWqY/cm+L5Kw4/0WbN?=
 =?us-ascii?Q?VZOr4yPHDV58btgMqy1WuaRAgF0oyJCAlBlvt2pU1UiLMpHghKc1PIryWPSC?=
 =?us-ascii?Q?NERJConE0Pc39VVe7Zl7qxGv2UYx/ymXXkEuuzJRIVqretWnYjq3VE9k9I+j?=
 =?us-ascii?Q?j68ZPSi+yBfYpT4T5DfDaHpeq7Tw7L/nKbVhNJnLrx1fRZKIcygGh7PH5Jn4?=
 =?us-ascii?Q?NKPzkw/Z/pW701EQDrFGVjJ4Z8BJArlCaNHdudLtTc5lGEo9PjpZg1amePDP?=
 =?us-ascii?Q?DS+lMX0ac5M/GbY0UCj1dMU4+3rNgPsHvfx0MSzehs872QcpUm4UgQMpXbOo?=
 =?us-ascii?Q?6DTgg4e08GX0Q2xmJ/ocDkpBzRUxUK6uQ4VhwkuC9vPqJlPlWAdAHktlM3FF?=
 =?us-ascii?Q?U0v7z39Wr7Zt8Yduurokri7nUZovWRa8jvzb0ZFOrvFV1TkyscyCYR0CldJF?=
 =?us-ascii?Q?S+2RemjbVXDbyMl87GX+W1NJS5R8CdDxlWPqysZWnHTYM+PHwEopYEAOGL9q?=
 =?us-ascii?Q?ZOqokbqVIbm7k9F8URMCpbZx1+RkzHW2ocdqbVMtbvhwSaWWpXtUp9+0euWJ?=
 =?us-ascii?Q?XOJbeNXDvPAnykPNaHFafzA+I7bmbstW44nZw7czNIpSfvZMTlUU4uLmPOgR?=
 =?us-ascii?Q?iXURPwuKKk7wOhRQ4JtZTUcpBYQN2+uve82rjZ7ZXVJPS8x602N/9HAcCXwR?=
 =?us-ascii?Q?fy4GVAXPXYwWsINwwn04gawmShKNbcb3YE4Htf5+pU6o8G7PjgullsFBdg8w?=
 =?us-ascii?Q?xD7RDJeT64xB4LDsDTlUAZYytI/TKYTeCTXhVFlSWkqcdfuyo8dSFQBSdMQX?=
 =?us-ascii?Q?2TddoGvPgoWWGLQbMlXBrIfCAB8xxXH2v3njrYL8wi2Y8pj+7PYim0ieR/tA?=
 =?us-ascii?Q?+JPwbuYbcx0T6zGpTlFev1g76d92XzU6Xh0mdW+XISbutW9w7HTFoawvjWBi?=
 =?us-ascii?Q?+Rnl+2dMiKGixp6STrEqilqkuaRIONV3ZXpHqKWIibT8haO17Cx9/O8Haee7?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?s8tPiRXU3TbuH9WQhszdxdeg6JwmLXH1KAwk6V+WOfKkUHsLW6g6BqekmD1P?=
 =?us-ascii?Q?gP26GWCDf673PpdG44WfDlzf3QA3mkc10B+U+Tn2Uixk8V83xcdndho6g4IB?=
 =?us-ascii?Q?Zn6Z7743Ocr4XaSk6tA0XQsoWGJk7eUaRLm0evYB5ZMQbhdWr7E76IH6ip1B?=
 =?us-ascii?Q?OMAhGYstZNOeXAY5SehGwQuCLIAtXs4gx1TxlfDS+jYCVgMvWvqf+Jj3k6I1?=
 =?us-ascii?Q?FPupn98zFmqdSKRaFZSbAvsPXeCMMW7V+ARKTpWkuI57skE6ZSnDKf6K4pyj?=
 =?us-ascii?Q?HnH7F9CpAVZaRg3K/hgLkLCuZaRGANr6d+7qA43WIx45+Pg6+66C0mosYtmP?=
 =?us-ascii?Q?Gcxb7sCl6GOrDmfRvUq3PvmVx6lpWZuoiMhvCJbXgEIP79DvTjVOyLDBYUlx?=
 =?us-ascii?Q?vGiei85SD8Qs4XvLGxQnqVi3LVim6k8nc+61aCl1E9xfiUH0pWM60YFhcTAy?=
 =?us-ascii?Q?RPjtWdDenF3RURGv+odzqraujpz9zsmQbRhocuL4KaLsjR0g2xFmosU7SYza?=
 =?us-ascii?Q?3PQDUrPE7qK6zkR9UbCLPrLj+mcUVlCF0xv3lRzvgdmgqkBF153AGTiuNUiq?=
 =?us-ascii?Q?dQSaJSKe81mDvxtRqFGgks8Gg6OBx+45ad3hW0IZpC8tSTDQWldthS3C+lcF?=
 =?us-ascii?Q?tc6msD9FDuEvwfbRWnp+QAtlT+Qql0h87dywNQSyp4/zeLGHDRyGjrnM3MZB?=
 =?us-ascii?Q?gyFLLd8XrXls5o5SbsGDOttNwAyQBtUWFTkFHTis0ED/DdI68U+StBmKCpJs?=
 =?us-ascii?Q?Oequ/TJyVBt3u5WB3wLzJsT+d2R8QeOSGdXmSKOwJF0l0wW7zkabTTnWgIiG?=
 =?us-ascii?Q?N2+u6XrKTD1NvikeldqZ5wJXr1pNDUWkw7D7GPqSa2fxb7kqcU2IfZ515v2T?=
 =?us-ascii?Q?eyCOHHimwSxnJ0MA0Hq3LJth3QCnkrT30rwgOA2MwjzljjSarbR1Z3jS2le2?=
 =?us-ascii?Q?zWPfHptkO8jSjKpins5okw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c73992-6ae7-405d-7897-08db1fd06fd5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 12:27:09.3914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtnxSlmNI1DolwURCS4qYJJ7Bqrq7wxVdKG51+Fb7sZD9ax84xOvPgNHO0eNhCV/1r+7AsxWKhIhzIG5MLOcpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080107
X-Proofpoint-GUID: ZgZb3a-1gdKi9GvyaxqwSsKVS3zB0ZUS
X-Proofpoint-ORIG-GUID: ZgZb3a-1gdKi9GvyaxqwSsKVS3zB0ZUS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver has a MODULE_LICENSE but is not tristate so cannot be
built as a module, unlike all its peers: make it modular to match.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Michal Simek <michal.simek@amd.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/nvmem/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

How's this?  (This supplants the previous patch, obviously.)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 6dec38805041b..3b3832f4dfad1 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -368,7 +368,7 @@ config NVMEM_VF610_OCOTP
 	  be called nvmem-vf610-ocotp.
 
 config NVMEM_ZYNQMP
-	bool "Xilinx ZYNQMP SoC nvmem firmware support"
+	tristate "Xilinx ZYNQMP SoC nvmem firmware support"
 	depends on ARCH_ZYNQMP
 	help
 	  This is a driver to access hardware related data like
-- 
2.39.1.268.g9de2f9a303

