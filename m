Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52377698F44
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBPJF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBPJF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:05:57 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2134.outbound.protection.outlook.com [40.107.6.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28463B3F8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:05:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G90sOjAtD3Uk8ouJPCXS4eKHunUY/iF6VevrDBQlkLE1sUjAbnXWa+fIBZ4by2cjHut0GHY2OJlqdfaHV8VBMss860A4RKzLBbTtyU9IRWrG/j3t1r/XGbYdgG+EPEeaVyfUM0c3rntsqR9aYf5RU7YuqXK116NyodgyuNYZ9XEVZiXeFFbKqt5q2yTO/Y/4rzDfb6eLiCx25s+pF8xSHnc4RLKE9Q+7xr61uMCVftlpeJQurT0oJpobKAz0JTtG0NCudK8cELG9s49Ej6GaFhY1I+9VSRQdX9Dydt+efO58Jumqq+0ARfc8uwjchvFHxhT+UqKYV6qCfEmdIi3Ixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjQMPTroOlkMqjGm692Nkrqd43VTbWtb/Nt4XK3JFDI=;
 b=dlpS84xFnuZgOHb9OA4LFnBHptCdLLPDOWk8S11XhYEi9MB65y4Jhe5J1FNFBPBDd5f5V3RDcEHswebGYiDC7Mj8fcJaG8no6VNgQWKXkEQWLuBGn96a/XkapJ7P6ksYUE/3W5xLSTjh2FLJRD0Fxclz8kzO+h5lKVBA/x6z/vF3d166sijl1M71zmlhZiSchRgD6ObF2ynJ/LqUPuBd4OkVB1T0m0ioPr1MgcvIV93iOwBNIjpr6OJZrQ2fsePc5hjmI2QVRIsR7bFkgZMcwyhMcQKONRCMH/Q9gqsKVgj+WRtQTQNU1GO45q7TNj3UR1wEFsk7gODLUlXMeAPPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjQMPTroOlkMqjGm692Nkrqd43VTbWtb/Nt4XK3JFDI=;
 b=canPWEg+Ww6WcrgKUF1c5VE6DHz3Va7DIW+DrNVQcuXudycZckOdElZkJl814jEqf60NrN6i0VGGqKlDLDAWmHm/BJwhWWbhUmf80ELbLras2l7F7iTuxFIOC8aMmlfVna3FVLA3mQWahlDhq1jsZmpBPzEtvR6cpMh9ceidOAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS2PR10MB7761.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:644::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 09:05:51 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863%4]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 09:05:51 +0000
Message-ID: <e2dd81dc-d146-d7b3-1f59-a80606517e1a@kontron.de>
Date:   Thu, 16 Feb 2023 10:05:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 4/6] regulator: Add operation to let drivers select vsel
 register
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Frieder Schrempf <frieder@fris.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-5-frieder@fris.de> <Y+v31bkMWxPEVqrT@sirena.org.uk>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <Y+v31bkMWxPEVqrT@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0022.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS2PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aff3b6b-3091-4062-9212-08db0ffd00a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tW6K/DMvCvHzcX438VXzurSVfsOIc61i1Jzm8Gcw3xBI2k/4PWUWhnQ8GGb/INB1zOeJjAF0+bdwGizw7uU2D+X5tiENDTDDJvVmAi372ZKgi0NE/C3QGdEyvM9RUmIDHzf49lugYih35v0tjGpFrhWyFYnZz4H0IQ77jaPZfd6sTRLM1aAZVUgN6QbR9J1bRvzIuE0ARau1bwHHBgE1p3DZVCMABqe6IepNgwe0ywuBWUzaDPmxdoV4EhD7D0Fz5HmGq0AQvBzXWAs/5QEsg3JlqZrRam5YXvlGLrD3x432oPPN994RdXspcHc07fzzVVueE1dNLz7cTITNbm6pKRspqfDDBwBbZxl1O/8wWvj0iHpqhmOvGCIXrsO1rLHdE3wjUbtjlfd9JBgKOh+aPqmy0/F5SPMjbzDDuK05dypJ8rYosLGFLkEcQVUz9ghCH9tALsdz2froWwmyzyYHoes4A+Q/Urq8gu1MMjyMsQ0aVROoqbSS3ztl50kGZXtMdgtGzc+9MiQy+qlcYjwDkb8TpNdSHp+6Dxa9i70c75fvvPCWeq+ErYCNa35dm6TOyVDHdW+NFoqwNifo9EyLQRmyNK6gc9FsGV+Sa7ghuz7izyyV7PchaIVBGkJm1D2tMnkXJfL05Q0x9dQ8r+8vZMkQeRfyfxva1pEZ4adVCMGfWw3y7Yr6rB4Q/UTKi+4vNsStKJbaMUBJbZipKWb/8ggAs3m2kdYLE+RPjI/UIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199018)(31686004)(38100700002)(2906002)(36756003)(6486002)(6512007)(478600001)(2616005)(186003)(86362001)(53546011)(6506007)(83380400001)(31696002)(41300700001)(44832011)(5660300002)(8936002)(110136005)(66476007)(4326008)(66556008)(66946007)(316002)(54906003)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUNNeCtsam00WGsyYmpJQnVYM0NPNUQ0S0tmbENqSkZNamtjUTF6dG44ckRh?=
 =?utf-8?B?TWcyeWIyYnBhV1liVDR3NS9oUDVUckwwVUFvT25EOVpOOEk5clFDWUw0aGVh?=
 =?utf-8?B?Y2Q1WVdPZ0VrWVZlZVl4ZmRDNUlrZmljUWV5cm9NRjdzdDNYK29GMEhaaGZU?=
 =?utf-8?B?VVZvSCs5NkFLbUdJYTZLK2NwMUZOWW15bjl5VitsSEswd3J5ZTNDZXlFQXBk?=
 =?utf-8?B?a25Jd2w3bUlJWEZ5ci9vVTdZOHJ0dEZEcDZWcHdmUUtjU0lWdTRVWTlWRFgw?=
 =?utf-8?B?RTYzcFUyd0RyNm1pRTE1c3c5Q29vb0dPZm9pOXNJZkpZd0NuVTZUczVsaDRR?=
 =?utf-8?B?VlZsUVpkMlJEZFFzY1pvNmduZEx2V2VWa2VQN0t4NzVvRDNoaEtjNXpwTnNh?=
 =?utf-8?B?cHZCUFJ0UHVpMjZVZHR1cjlRSk15RUplQUNvTWJRRjlQQmxoMnBZaFJEQWIy?=
 =?utf-8?B?bDZzd3VBVTJ6ZzF2UjJXcWZYYmFLaTNwZmo4MjMzSFJTV1J0dkxwQmJPenA1?=
 =?utf-8?B?NFJPOS9KanBHaDhySk90SkI0T09nVFd4UzYrVzFTclBWS01UdHJBTENLUDJ5?=
 =?utf-8?B?U0dhckZ3VjFsblErUzdka256Wm1PUlJOQjBGb3ZBbjRmZldMV0wrNWEwcDd3?=
 =?utf-8?B?NXdnd0dtVWxWaDNOeDdMMWpEU1ZIdkxpZlFNMDk5QkVWNTVhM1NTc2xPVlZN?=
 =?utf-8?B?T29TYUIxV1FpZnBFMURNWUlSSGowei9oNHlGRmlkTkI5YzdGOGxDUHBnWFZS?=
 =?utf-8?B?bGd0dFNyc0poRURXMG13NENYY2ZRV2MyK2pndTQ2dGc4alp0Q0dvSkZoa3FY?=
 =?utf-8?B?TE1YRXN2Nkg1dlgveVNkdHdoWFNXMkJDU3FxejVUYVRsT2RHc0s4R0pScXJr?=
 =?utf-8?B?RlNkanp4eDBDYXU2bGR2MnlvT2FmWjRpdkFTdFdzSnp5TFFvM3RSdU5hY3Uv?=
 =?utf-8?B?Qi9xT2NOb25NWDVML1I1VjVwNGgydHQzWHp1ZGNqZzErTk40dkg4ZWxHWUNk?=
 =?utf-8?B?ZHo0RHdrVy9yZTB3b3VXN0lHeXBWQVhla3MyamVXVnVZOWRPR3FGblBiZFBx?=
 =?utf-8?B?dDl3djVrSk1JNDdCM1NHMGx4Um9Fbkg0RTZnd1ZzQmpyTE41S3ozc0dpZzJU?=
 =?utf-8?B?Y0NWSURTdHBRNzBFbXJFdzV3Tk9FRDJHQ2E2YkJ1WE5KNUtnM3oxYWZEOVNN?=
 =?utf-8?B?dk1LdUJNUVdRL3g2bXZ5NXd2OTVldEQweURXQ2lFZzJNU0ZNb0FjN0QvQm4v?=
 =?utf-8?B?TXVGMjNaS1VjbHlzdGRrTDliNThpQTd2ZVBSLzAzWTRnQko5a1dQSStnMWRk?=
 =?utf-8?B?TlBaVlo0M3pWWTFBVmRBdmlTcUN4ZTR0ZHZ1akovUHArb1hvdDk0SVBUSldF?=
 =?utf-8?B?M0ZraSs4a1FSR2QyM1BCVDJleEpyL2VtZ0tiSk1XSkJrSVdYTHBMNFdPQXAz?=
 =?utf-8?B?Qzk4Ty9BR2plWHFRZHd2VDZKbTRYbFNzVnVIS1hpMDE4NWF2SnhsRnlWdDhO?=
 =?utf-8?B?VlRmVTgvNVNTYW4zWHhwZkFRZWVydXZadzVpWURnNEw3bGdOdk1vZDQ0WVl2?=
 =?utf-8?B?UHZTRU0wWlNDM3Y2dW9hNGl4KzFrS1Q4MktXUE5QZWdrWE9DeFZMeVh2ZzUz?=
 =?utf-8?B?WWEyR3g2YVdVUVlBeFl1U2d4cVVoNWMyOGhBUDhEdlRPRjdHaGZaU2c4Zkxm?=
 =?utf-8?B?cm5vdzVQaVRnMEpzZ3oxT0haWUhVSUlMMC8vWmIwbkF3NWdKUk81RVJNTkZ1?=
 =?utf-8?B?by9Fa0hsekw4Y3FUMEZrbFZIY3kwcVFJQjJVRU1NTDhISmxENzl4ZHZud3Jz?=
 =?utf-8?B?ZFdzUVp1VXFGWWJLM3RhOWRlaHB1d3ZFSWVzcFlHMVNkbnJaYlUzeTJkUzZr?=
 =?utf-8?B?L0tMTjUvTnUzQWlBajBIMjc5bUNFTVpjWW0vcUxlQlhidUZLaE43eWdVSEMw?=
 =?utf-8?B?YXJEU3NsTTNUKzhZK3VSQU5ZdGh1cENmMjFVTktCRm5DYlloVXpzWGJKTXNn?=
 =?utf-8?B?TmNqWUZpNkcwVHdDeXloS3pkNTV3SnpHWVJKbTB5RFY1KzVyZmFCN3ZGTDhv?=
 =?utf-8?B?WkJDaHZ0eHU5MGJyN2tobm1QWEdxNStwZXEzZkJ5enZCWmM0endJSVRyWng2?=
 =?utf-8?B?NlluRzNiczA2dXRqdGRuRkRya1ZOQzJLVWJPY2ZVY09CN1EyZ0g3Y21PMzRl?=
 =?utf-8?Q?YzV8DONo6zdeC8i2Z7QHeZcv/AZCj2hTVd5QLkc3m2WC?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aff3b6b-3091-4062-9212-08db0ffd00a3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 09:05:51.6169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGcbVPDAxTiaQKKU0pv2sC+/2MfuzmLPCARPO/blZ2dYzzC+VYCifh8SASnln/6XdWTk1cNw96TVt5p3oXpzdVJVkmiyor5LxKrbj7+1znI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7761
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 14.02.23 22:06, Mark Brown wrote:
> On Mon, Feb 13, 2023 at 04:58:22PM +0100, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> There are regulators that use multiple registers for storing the
>> voltage. Add a get_reg_voltage_sel member to struct regulator_ops in
>> order to let drivers register a function that returns the currently
>> used register.
>>
>> The pca9450 driver will be a user of this as the LDO5 regulator of
>> that chip uses two different control registers depending on the
>> state of an external signal.
> 
> Aside from the build warnings the bots reported it's not clear to
> me that it's better to do this than it is to just have these
> drivers implement appropriate ops directly - there's probably
> going to be cases when it's a different bitfield in the same
> register, and by the time you've implemented the op so things
> aren't completely data driven I'm not sure how much you win by
> reusing the register read/write.

Thanks for the feedback. Makes sense to me, I can do that.

Just to be sure: you are suggesting to to leave the core untouched, use
the existing [get/set]_voltage() ops in the driver and reimplement the
logic of regulator_[get/set]_voltage_sel_regmap() there, right?

Thanks
Frieder
