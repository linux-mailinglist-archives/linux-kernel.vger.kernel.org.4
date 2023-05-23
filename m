Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6922170DC48
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbjEWMQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbjEWMQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:16:43 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2107.outbound.protection.outlook.com [40.107.104.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C26D119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AI+h8JV7aSTjyLTM9V0fIuWBoGtvQFhkJgAohyWIkHnA7lZAuhISV4h1Nk6CI2wFN9Lha8lm/gUyTTjNxMlz8MK4z2qasVT7b+U/yQspM3DJI22Oz2oyA5bC+0saA4C9ygsnCZT/XtePx4JWMyY8W+QhoM6GlbOnM/kYKeVpYr5zKfypLpB2uBEisUuwYMGDOW0N7J/zI23uE8hD2dtZvT5vEibFQCYUEZfW/N4oBCQFhNk90qi1wG4KmL9NdalB58LkM4hvidSUmXUAuv3CC/3ArTC7tpqwlc4x7QqZvz9iu+Tw25T5Czf2XDmeprqEA08/65fjKDtV23QTjSsglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXpi8/LTfJdckCQ0mnbJmac7cwDQ4PnD65DTSXYObKM=;
 b=X78D8L2PmdkoZJTnj3zuQOriGTJ19esU7gnQ6qHgnNTgPBjEePDj3iJ1XwVc/v/czb3Acw/N65U0Ls6pS55+ULEAhHyQsp924sj7I5b+0/TdV3h+wX9rRBwG3UViTLmBt7NltwzihE80JIyGOq1NY6280XF259R6pSbWg+GCiLFJ64fX3c0yQBKTnPSIpvFeAeo5XTxYKDfxrHRPiIb0Ld3tTWuuXBYwf+KCNHPjm9E5/IQEwv7Vh9sIGdpjFoIX1QdMIcBv3vBKZTjsBZU9BWkqW5BacXLzKmYVrN9L7mOxaKtpxcyOnohkFN9k1wvWE6zgXaLDGOzIXhyW4H90rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXpi8/LTfJdckCQ0mnbJmac7cwDQ4PnD65DTSXYObKM=;
 b=Ybbaq8jfbtq+PlKWQN3XJJIfaHcjCaCPIMuAce5AH/IOS14fOnppeHlF2ASpAIa9Ck6IRJhI2VUAaFJMEg7kh7DuBjm+RdFenvNllFn/+dCWokDn8cN2wuwV+86/fT8nvgzk3VI0H5IBCtVCvD8P4/Sj4KDQeNPhk0zjix2PQms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com (2603:10a6:803:ab::28)
 by DU0PR02MB10042.eurprd02.prod.outlook.com (2603:10a6:10:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Tue, 23 May
 2023 12:16:33 +0000
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::b703:24c6:975a:bf84]) by VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::b703:24c6:975a:bf84%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 12:16:32 +0000
Message-ID: <9b872036-42ce-2d08-2e98-12bf0abf7095@axentia.se>
Date:   Tue, 23 May 2023 14:16:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: sv-SE
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Dinan Gunawardena <dinan.gunawardena@netronome.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH] bitfield: suggest using bitwise OR when combining bitfields
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0108.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:9::9)
 To VI1PR02MB4445.eurprd02.prod.outlook.com (2603:10a6:803:ab::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR02MB4445:EE_|DU0PR02MB10042:EE_
X-MS-Office365-Filtering-Correlation-Id: c39eba5f-f4e2-4cdd-7ecc-08db5b878baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHqBQG/U6iK5aqQ7JpppOidDroO8Yvz6jc40OnfHhjJN7D+N7ngYSadjBI/YtDsXhQdpWcvnxTKwGfDHRsoc9yAxci1wSz8DvPZ8xlTvz80kt9Of9HFx5FlZG0XmnAXPQEkS80XjlXdosBPGeqHGDwz1Fyd3jyyhFmIyOegMg79Q4wlVQF4+LDIHUmwSQL7R0yf+Arvekt7hD06x+1CpnSYYdVagIF3t8vh+PoopgfnkQiux7Ctw00J6gvujah+J2y2SrQDC+AKB1JPf9AvXOpzI+alwQrLdamnodWqXB0ugOka60i+Q6X2SsUD4JjkWr1jDDNozy88QSBfhresnBOoAehSE3Syqf6GQhWmx0b6JiBVAm7r2MW6N6HznpSFFil8wZ8lGRew0ItOeW5MwxTnJk+CBvPJux36Hm2w6c1/N438MSyGGpWfVh/0AUlqTluKFeE/OslunHH4AXLFQ/M8mg2fS2Ksbfn4Bw9ckvk3uE656KZ76sebUdi7q7+K1zYRpTqmU16C6x/FT50HYUZ94zmIRMF7f763OaWsdDCdSMdi0TRsZuWKWJ8yeA32RV9YmeoQ7kGDGcF5pybQNDsNUj/V+QEWdnjPHQ1ABow8a4WB+NawB95Rj5STVK2mFrc9RybeOzbIadb+byeiV5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB4445.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(366004)(346002)(396003)(136003)(376002)(451199021)(31686004)(2906002)(8676002)(83380400001)(5660300002)(8936002)(41300700001)(66556008)(66476007)(66946007)(6916009)(4326008)(54906003)(316002)(478600001)(6486002)(36756003)(86362001)(26005)(2616005)(31696002)(186003)(6512007)(6506007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkVaUHZKdHIxTmdWYzBDRm9tWjFxaEkxWDMycThXNnJlanRhdktyc1R2L1Iy?=
 =?utf-8?B?NXkvSzcvZkkwRzB4R2pGSFJrNXhNRlYyU2dJMXg4b3dvNHBwUldDVm10UTE2?=
 =?utf-8?B?YzNDN3l5bFFpUlNpY3Y3NXVRR2FjL1RyUXY4RFhFa1FaakVoZEFobEd4b0oz?=
 =?utf-8?B?ZXF1SVM5bWtXS24vTEdHM3pTK21JQ2hSQ1EwREl5bTJDR1JrVnI4L1BZUnkv?=
 =?utf-8?B?OHI5bXJZUlowaFdpZWM4bDVYR0ZxWFpIc0luSTFQTEZ6Qzl4V3VPbDVRVXl1?=
 =?utf-8?B?aTZQZWhEQUY3Ti9jdlJGZnNvSHZKaGZjZWVGU1BSUC9qYk05eTZPNG50U2tv?=
 =?utf-8?B?bVoxUGliaC9OYmVEdWNxTkROR3VQeUl0T21lUDVCQVl0SWpZTkFmbUd0MUZo?=
 =?utf-8?B?U1AzRW55WW5aSzY1MEZsWEJJeHpyR0FkUXhITHloN3QxaTZpQURUMTFpL0NB?=
 =?utf-8?B?Rlh3eXpiaTlFYThPNW5PTWRXa28weStXZHhBODVvcnFTTURsamFCVVBEbXdj?=
 =?utf-8?B?a09NblBEZ1U4UDV1UkV3MzZqMkxjS05JK3d1L2lrL2ZVVjM0RDh6bHdjaUtJ?=
 =?utf-8?B?Z2RwbWpDdSs0RkdJdXdPMEhoak1zSU9mMEdWaXZucDh2NU5iNVBFVjQ3Lzhj?=
 =?utf-8?B?aEJyU2haY01ZUm9za013cTgrZGFVajFXUUZqTkxUTWtaSHRhVUtySlo5Qjly?=
 =?utf-8?B?K3dlNk85MjNxZFpNRUlicmQ2M0ZTV053YjJFTnE0RUFoWlBXY2FyVHp2Vkp5?=
 =?utf-8?B?YnhHdEM1Z0VpSGlJeUxhQWtmUHFxUU9UMkFrZnlsTFR1SDR4dFg0VjAyaEJE?=
 =?utf-8?B?TzNBYVhQempnSWxhcHh2NjdBazNpVEZVYVMyYmpBRi9QekZLZFFteU1qYTUx?=
 =?utf-8?B?QWhEMVdLTFNXWmdqQmsrL0szRUtGQXdPdnhZUGdRdDNrdXJDQ0FKY0dUczBT?=
 =?utf-8?B?NUR4VTlpMU5Dd3JxYnU0Mzd0dkQ4UDVTdmtJeEdKNnVwc3lWMnVKWlBoRFBX?=
 =?utf-8?B?MXorWDZMVXczVGdtQWE5cEVkZnZ2eEh5Y1YrY0xIWWZwbUU1MFJZbGtpMUhi?=
 =?utf-8?B?ZS93QmZrK2UxRlR1bkhsQ2tGWUFBK1JBMnFUWXZBeWNGaDJ1VTBFUkZEY1Nh?=
 =?utf-8?B?M0pVakg3aXdSVzR2MTBOa21Xb3AyUXNrUVB2ald0N0Jtc1lmZHNCS3VyTC8v?=
 =?utf-8?B?VVpzTE1mZ2tIUVBjdm1LTVdzNCtSbWYyYUJBcFRUQ0tJTXFhT0VDRUN5dWZR?=
 =?utf-8?B?Y05hdkluQkxMZTJCTVByYjhmQ2lyYXQzeTFkVzhSMXZoNVJEdFh5ZTlPU3VG?=
 =?utf-8?B?WG1lS2RuTzY0SzR0Qk1PTHRlSk5JY0VGL2t2VnB6VXdYdnI2UXp3L3NmeHJT?=
 =?utf-8?B?b3pveVAwUTY5Y2dTd0srd3lvMGhkQ2tYTERnTG54TWxtdXdKT0NWM3kwV2Nr?=
 =?utf-8?B?cjBlUWV6SjA0N2s4V2ZzaUg5ZHNVTXhLeUZXTFU2bmxhaFVIMmdRN0pMNWsw?=
 =?utf-8?B?bDh6RXJaa3dXTVlCeXlyUG96VnBTUnpPZC9ja1NzVm1xRnppK3p5NkRwamQx?=
 =?utf-8?B?aytVL05LQzdrTVY1a1hvUFBiaExEMFE2VVZMckxKL1hoSnpjVzZaaEpqZVM3?=
 =?utf-8?B?Tlk1V1pxYzVQdEpTVjZ1UndLRU1jTDdwclhreTBtanpLTFoyc1BtM0ZKQzk2?=
 =?utf-8?B?LzhHZUVkdVJld1ZYRnlYN2dtNkhjeUI2L2Y5NlZtclRPY3FUeGFaMnNDaTAz?=
 =?utf-8?B?eCtHT1I5a3Nmd1BDRk12YXM3MDFETlIrdFFIWFBqbXJhQy9kdXYyeXRmMm4x?=
 =?utf-8?B?MFp6MDV4VWszSHJGUjYwbXptOFo3YU9oYjBlRzVqeEs4Nkl4NTVBcXZ1Y3A1?=
 =?utf-8?B?aFprOUdLRXF4SjU5dXJ2TVpRcTltRzl5S0oxazU0OGdRN3FoS2xpb3d2amUr?=
 =?utf-8?B?QzVndi9mcHhzTStHMEF6dUlmOGFQK0ExMTlOc3J3dmhWTmtIV2dIYk5JOTA2?=
 =?utf-8?B?SGNVUmdXLzZNb2NrNyt3S2pqVGNrdUNWak9ScFRjUmZ0aGVlaHI0QkRyTlhi?=
 =?utf-8?B?VkxBdkhON2tjQW9IOTgwZEpPdHlJeDREc2dzNldLQzFvYTBXTkFqSStuT0RR?=
 =?utf-8?Q?cwsiYfFh+OeqEti6rryL2xULG?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c39eba5f-f4e2-4cdd-7ecc-08db5b878baf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4445.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 12:16:32.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4obz8hsVbUA26ImGa/v8YrVgHAr2oOkb+jcJZEnjIuOexYk5VEpCxWsKLFgNkdKh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB10042
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Logical OR fails to deliver the desired result. Most of the time.

Fixes: 3e9b3112ec74 ("add basic register-field manipulation macros")
Fixes: e2192de59e45 ("bitfield: add FIELD_PREP_CONST()")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 include/linux/bitfield.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index ebfa12f69501..d70fc96585e2 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -107,7 +107,7 @@
  * @_val:  value to put in the field
  *
  * FIELD_PREP() masks and shifts up the value.  The result should
- * be combined with other fields of the bitfield using logical OR.
+ * be combined with other fields of the bitfield using bitwise OR.
  */
 #define FIELD_PREP(_mask, _val)						\
 	({								\
@@ -123,7 +123,7 @@
  * @_val:  value to put in the field
  *
  * FIELD_PREP_CONST() masks and shifts up the value.  The result should
- * be combined with other fields of the bitfield using logical OR.
+ * be combined with other fields of the bitfield using bitwise OR.
  *
  * Unlike FIELD_PREP() this is a constant expression and can therefore
  * be used in initializers. Error checking is less comfortable for this
-- 
2.20.1


