Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A4D704C96
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjEPLnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjEPLnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:43:32 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2121.outbound.protection.outlook.com [40.107.105.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455B45582;
        Tue, 16 May 2023 04:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5lXcWwqE+7narN/RQR2ABm6KuTZilm3kNEstLJHJ4eV+ZztARYOgi42XoPvfKeCLx464Evhn8eSqO0LmPjr2HJYr0BqPykUICNsT8kT8ceiwMami2RyZiEVkX5cDfT3oTVkFnefz1KcDSTgAEy95Y5KbjqBBOOHcNsATv8eBFHB3UtyhhfQ1Tyo9mv3uIe2aOUEQ1YQhBcApFDCaqprz/BMjUXnUpy4Tjj5NCvy2FgpyIx4MS+bSxNrdVoV7FBgbbMh1h1aWPJPX6hi7wtELPhO5Spkv/2FhfqjxMym78IIYjo63QbBZLPkXtV5uqcIRdS6nVuNPObGIpE0agOzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K11vaygDjDk2uVERRUKq0MuPPwoT5ciVb2e+YJzc/7I=;
 b=YdCJrMbth0AkwuR/m1KOqwQEm8a+LwDGa+V36UBDgq3Tb99Qjt9j1lr8um+iMOBH+I29GozQSn+idDypQPJe917fmgWSBtQS/xwQssHwnxgemwbvrcS9SKftZtkskXZRboUZLDNl5uBqhlKhJIaXcWhgK5rSsw6XGA7r79fNm+b0EgU4BawfraMsx08ADOi3fBEBITbKF+HjLU8CUzAkuP/HyMGpuM2LPRmTqbkRwNxEqp9gdMJe/0asXk1SJVGUvzdanEKZHuNAwMWtcNXXu9s+q0RNGC8L2mp7/f9y2Yv/Bnduy+f/pZ3j1c424v9LXrR3N2V8+WegWbAnK2lkNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K11vaygDjDk2uVERRUKq0MuPPwoT5ciVb2e+YJzc/7I=;
 b=QZpRoMqywoeFCbySme2o7/6eae2bGBPJPb3u4nHqkcCekmoyLIaTrlO3l83KtO85sjR5BFyOfje6dvbmUxv/fLEERZ04dxOAujxQVizqdaW7CSig8O/aWRJknJuHs/uYfIXYn8cUM9MNACtpfkBjJ+ffcMG8JfFFNwQSv1yxISM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAXPR10MB5662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:245::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 11:43:26 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8edd:b6b0:d2dd:ee12]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8edd:b6b0:d2dd:ee12%7]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 11:43:26 +0000
Message-ID: <9f9d4f04-70d1-7d62-7d27-c76e80d2861f@prevas.dk>
Date:   Tue, 16 May 2023 13:43:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/3] spi: spi-imx: fix use of more than four chip selects
Content-Language: en-US, da
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mark Brown <broonie@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kevin Groeneveld <kgroeneveld@lenbrook.com>
References: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
 <706c591f-4800-1b96-52c0-37b5f6de7623@rasmusvillemoes.dk>
 <fd22bfc4-b019-4445-acc5-f7902a2386fe@sirena.org.uk>
 <9f403dd7-1ac8-bebe-1b24-bede61087bba@rasmusvillemoes.dk>
 <38eef5df-ca8d-41f1-93e7-e13c1d7b6232@sirena.org.uk>
 <a56c2cec-b10c-ec73-2179-6b92251a7419@rasmusvillemoes.dk>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <a56c2cec-b10c-ec73-2179-6b92251a7419@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0069.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::6)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAXPR10MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a51da3-5ef8-460a-e47e-08db5602c2ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IhwmSxbZhLd95dzHM9tgPqifu8cWAR/5OL4OACJM5YRdjiSI62400puOgsJQBCHYZflXdPj08Bu5OM1x53i66408ukRR+gH0w72O8NhwCpGNxgdQtYaOWQM9KnJOMF73pF7Uamn4gaHxhFqnK7fC7KZfeIF4NjyepE//QAB/r43qKyrSZ3voBd4ZKKGElZHcELr+jw+OYEjKG4VwPpog9FpDqYmPYWrszPFYiiRShoikvq3TCe3rDiybRO4Rua5mK7wIYV8vsUog0l2RctLiHgt3NYAwcdrXtE8VTf7FwN89EK3cWzEf9XES29mXm5uJcKGDtsyQsLoN57ZLWjTF0LuO3vDoXcAMCXzZkXbNjtOyvriqvRKM2uL42fOqciQ8BgTLamSDfY0lf+5g46y1gfzZ/XUmpBijEmR+rjtfC9DN8Gn3CgB36VWhj5xbN7/oWORFJecMoj3s7ZJrs+cn/d+KXyRDh5Z6VxRFES/IkO6LYze+2EhCcfcgKgwm3ozDCoPnq7ud2qY0Otv1VPs9UO8EJsCHZGK5ug+/xAc+sDdjSobNxVM6NV1mtumvTbdJ0ixx7E6oXF3Mr9tFmGq+T7Ot9nSkPMqfZSDxcFZNBSZJTpjuoSUgDofQHHw4OcXZOJ3AqJnDnrWp2S2zw5CF2c4A9kQDSTMKhdzIi3nwGbcHEQBXRzaHAAb9MAuS9KkD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39850400004)(136003)(451199021)(86362001)(186003)(31686004)(38350700002)(2906002)(6512007)(6506007)(26005)(31696002)(6666004)(52116002)(2616005)(83380400001)(6486002)(478600001)(8676002)(8976002)(8936002)(66946007)(110136005)(36756003)(54906003)(5660300002)(316002)(41300700001)(44832011)(66556008)(4326008)(7416002)(66476007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFQ4NGNlRlpFZU4za2tVcy85ZmVRYUZNWmhLM3VUZlJ1aE9QSVZ3RW9hR0ho?=
 =?utf-8?B?MGFNdkFNaFRGK1RZTWRTYWE2QVAwcHJpeUViaHUvcEhSa2tWb3dpVDA0aGUz?=
 =?utf-8?B?T3hCT0JjdWY2cEt4dEMzTzc5aW1mR2p1Umk1ekR4ZkV4c3paejYyVHJwTGFL?=
 =?utf-8?B?Q2l3emx3bytXa1FEcHp4c3k1Mm9BdUg3cFpENHBrVDdjM1lWaFA2TEMwRUxq?=
 =?utf-8?B?ZExuR1R4SkF2MXV1ZVlHdzEveEVGV20vMG1oQUdHYWlyMzV6VEdRU0V4djRC?=
 =?utf-8?B?Uk15b0NWb01XZ0RFU1BmQXRpLzhod3FiMEd5U2hOMExsUFM0R3A4VkVBOWJP?=
 =?utf-8?B?QVJZeWRNZ1Z4ZTluTXdoUVpmZFBQTjBaaFZpNkpjZ0hLeThyRWdpTlVBa0Y0?=
 =?utf-8?B?NlZhbGp2eHp4d29LSExLSGRrbGNZaGtxaldOaGlrNmxGdnFlenlicThtS3hY?=
 =?utf-8?B?QnE4VTAxQzhuUUVtdmY3eDRZc3c0NnlXKzIrQjd3ZEduUjErRk5xTytUWU1t?=
 =?utf-8?B?UXhNUmFMcmZZZDdQT3JKeUdyREt2WW5maVhUUEM4eHNBek0wdTRqL1hwcGo3?=
 =?utf-8?B?enNnVkc2NElGSkw1VUJwSnNpSm5wSHpGSzZqbjRoVUxBMU4yQXpPNE5vNis5?=
 =?utf-8?B?dCtnUWJoUDhtaWl5dVh4RGU3cUR6aUtGaFJDY3dIRCtFTEtjYVREbkN1dXBl?=
 =?utf-8?B?TjhRUldXR2tNeDlDMDg2TGlUdW1sdERzZXVGMEFMeVZtaGs2ZnNuTFU3akhH?=
 =?utf-8?B?ek84a05CZnNUbkozeHJFb0dpV2gya3FmazFJVFdVVWxSdXh4WVVvME5acExq?=
 =?utf-8?B?ZXFKeDFlWld1UU9LU2RmN01nbEFSazNPR1A2WEVMY3llTk9PRW1uQ3BWNHIr?=
 =?utf-8?B?a0FwQTBHWStJVHNwU0VxdC9uZ0FRdHhYN0dKU3NqR08zaHE0UjhsVmF5SjJL?=
 =?utf-8?B?OVJCZVE4MlZ6UFZqVTVadm5COEhpa29hU2pTL0EydDk4S2wvR3k3Y1N2ZlJC?=
 =?utf-8?B?ZE0vRmZxZ0pldnV4eGNpZXYrWDF5ZmlXMThhZ3dLNEdYNXRzL1dGT3YyMitT?=
 =?utf-8?B?QVlHQXJ2OGZaZ1N5VUZUb05lS3JyYWdPWGtDUXREYm9WbFA1QXZTRGlhbG1Y?=
 =?utf-8?B?OW9ZVEg4MSttZGYvdTdoT2pJKzVoRVNJTi9maHBBT3o1bUxxa3BkYzRQcFBH?=
 =?utf-8?B?N3VjdXY3TlZwcXo0SkV1K1ZtbFV1ZmhmSUtPc24zU0JrcGhLUjdCZUhWamFr?=
 =?utf-8?B?Z2tQb2NKY2FxR2gzc0xLaTBDWE16UjBCRWc2WEVpQ2tuUGVZREVsek1vQWxO?=
 =?utf-8?B?dzRzYXJCN01YMzZyYlcvck1aR0tTejVTVXMvaldEQlV2djlERWVZSjNkYjk2?=
 =?utf-8?B?REJDSzNxREdwVytnbmZoUU9rQ1UvV0xrWVY5MXBwN09BejJIWUFkeGk5eXVo?=
 =?utf-8?B?TEdLbnZlWTlIWWNzTUhEdTBWTEVMNE41Qzh3SlJKTHN5QkM4anBrV3dLMk5m?=
 =?utf-8?B?MFBYQm5IUEFhS0tNVVBpdkx1SHRWaXlIeDZPVGJEaW5zNmxjWFo5YWEzSUdU?=
 =?utf-8?B?SkxXbit5OWtza3NVS2tkNmNXVUFsMTY2NDd1cWNDTnRBYmFCWnloL0JqUVkw?=
 =?utf-8?B?ZDBIUU9oQjM2ZDZmUEMxYXRSSnIzblhKR0tLRnRkTVlBTC9rMTlTQzVzNFpl?=
 =?utf-8?B?Q1k2UnNqVEh5WmpOeGN3L0NuaFhNZ25qN2I2M0lSbWM1dC9nWFFkZStpckhG?=
 =?utf-8?B?VmJadVJoMU9PNXRqT0dYdmZWS1JlY3N5OFhORk8zdFRiK1VIalpMSTlUa1Mz?=
 =?utf-8?B?Y3d3dXRqZnJLeGUzQjMwQ3A2MG5HNEFwdmg1MVJ2RTNvQS8wMFpzdjBMNlVs?=
 =?utf-8?B?cExybEtVbS9JRnl3a244M1NqMDRVZXdPOUp3cUZ2MjNqNHMvZytDd0x1eG0v?=
 =?utf-8?B?RG5QeEV6S29ON0lraXhSOFo0bGRsWjBRTmVENVIreUdNaXM1TlpIUS92VHFX?=
 =?utf-8?B?bXBQcW81d3NuZ3JYSlNYcTR4dlRSUU1IU1UzZ0NXbmN1dFZhdmEySkpXRjdk?=
 =?utf-8?B?YUFuOXdCMEN0Skh0emFaRFZSU3NKa2VHYmNnWm5uTXloREtGbmp0eDFuemFE?=
 =?utf-8?B?aUtUbENaSmVKa0FDRDRvWEJ4RFhTQmpxc1EwQk1qRXdXZ2JzaXdJejFHMVlX?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a51da3-5ef8-460a-e47e-08db5602c2ff
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 11:43:26.6212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTM2i0RKqiq+b8ciFffHEzOIqBTVusOxGAYuVnKslcvrz1/YbI+E45cZVX44nfR6m2XJvXrPIpnLUc19OfRXgaWAFy/dYs13u6QLAg64LO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5662
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2023 15.23, Rasmus Villemoes wrote:

>>> It's not exactly a regression, because any chip_select >= 4 never
>>> actually worked, but what I'm saying is that 87c614175bbf also isn't a
>>> complete fix if one wants to support mixing native and gpio chip
>>> selects. For that, one really needs the unused_native_cs to be used for
>>> all gpio chip selects; in particular, one needs some unused native cs to
>>> exist. IOW, what my series tries to do.
>>
>> No, we only need one unused chip select to be available.
> 
> Which is exactly what I'm saying, so I think we're in agreement.
> 
> I.e., something like this 3-patch series is needed to actually support
> mixing native and gpio chip selects (having the core verify that there
> is an unused chip select available, and provide that in the
> ->unused_native_cs field in the spi_controller). I don't think there's
> any textual conflict with 87c614175bbf, and the masking done by
> 87c614175bbf doesn't hurt, but also becomes irrelevant if this series is
> applied, since we'd never pass any value > 3 to those macros.

So, what's the conclusion here? Will these three patches be applied, or
will we just live with the status as of next-20230516, namely that

* for up to four slaves, any combination of native and gpio chip select
works

* with more then four slaves, CSn and CS(n&3) must be be gpios for all n
>= 4

?

Rasmus

