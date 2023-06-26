Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF0E73DA19
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjFZInl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjFZIni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:43:38 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2073.outbound.protection.outlook.com [40.107.241.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712661A4;
        Mon, 26 Jun 2023 01:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iH/Pfk6wFq+KcZYiPHk14vOjnbC+sknNxNNqi1uA9EFY0g44j8VlDjjJTxIi1Hz8BCeAzZQ74nBo1ERsVIoczNiB7Y6mwP7WSbWbAKtOi/x8ylTyWJAMv6Bco5pxf9fxa7OJ9OgFAJy9LEdaeM8yoj6kMc+ZbvJr7RCX2teeQcteHRGhKIPOmoUhx5qCAcUeEUECGB0CADfkUyRbkeL9p/ACL3STnT8agfEzfeJKy56ZaGufASNu4IfiTa9jjsnS/YN0DCimTtf1KgVEGGoyvcDOnFwGR/aEP1PRal8RgjwUIix24Txv6y9mY4umjjH8OBn4vRyfTKeKZBR1o1uC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFo8VVzVH3h6LVmjJtU0q2kx2fuylba1HgiyqKL53jo=;
 b=MgmC3nfJjlVm2s+ZuA0jNGBDiake7OP+oEP5CJNA/VkyFQwHPFoNcdeLybDvHTnDd1RSw18uztQfeMwOcn0VxloHju3g7qSFo5y3fCxpfYMBSg4kBh+atlw3tEofCoj99/sjFSYBt0OvaPEEt+fBcL3USkm07WmzSoK31Qd7UO43R5G43Etthlh/h7fxUPvxnE7kYcQcIuGOIlupXBNARcGrsX524ePwhGupMnp4NH6ja59uoEtcBRtDleFZZsPazk7LaGQvjqbSQ3jHmMg6Fep+HRKaJwr2Q1fvhkpMR/JWL1WHq+JAuL0ORc15SXCEHRcEKmL1RYrt8HLBiy/kyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFo8VVzVH3h6LVmjJtU0q2kx2fuylba1HgiyqKL53jo=;
 b=Guj5TCP+7ap0FTk8Wbebq6WjeQcVTDWY9DX/VxD7JKy+zoaxei/IVMmplkVW7piyYAtcDN1ylDYldmTQlW80bj4vPjm/4GKyin4B9C72mf+SekKdu5qRKqh9paeSuCVzIZSnBn7M8GK3U5Nbh8tbxTPBnnKHNsvbct+gV596jeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DU2PR04MB8503.eurprd04.prod.outlook.com (2603:10a6:10:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 08:43:34 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 08:43:34 +0000
Message-ID: <1a5ad5ae-f030-8baf-9719-fd433c80a6ba@oss.nxp.com>
Date:   Mon, 26 Jun 2023 11:43:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 03/13] net: phy: nxp-c45-tja11xx: add *_reg_field
 functions
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com
References: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
 <20230623074123.152931-4-radu-nicolae.pirea@oss.nxp.com>
 <ZJXzRzJy99d3v7FY@corigine.com>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ZJXzRzJy99d3v7FY@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0075.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::28) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DU2PR04MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 19180707-1d54-428b-2d08-08db76216c69
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wGtnymPDBApwE5Yqb8dd6J7F6vsFJQXoa2LdumYXcpD33+M70jlnHMuBX6W/ts69HfExJ28rE1yT6g5zaVg+xtH0QVlp0feAQMhjXASPEzy0WA9lICxU/Ba6HGcsT62Lb82ImBB6V++V1eLBzDN6MA5jwQirtROA+WrZfAmTyUxBzakWelukS+0MFtXXXnjJQ43YvASVahrxBvjdqOxyZbEl1qJyfRVUUk/KS9jrchT0PxoM6ZiAlumhArftUKNtZxdaT/DEuFvayfQ68G4DGJG1h1gGi2GXL/RWV9V8VnyS4tdLTHMGha453t5p4Ln9FSdJLQnv+9/XBQVzbYGNeHNX/VDz7miRbch8gy6mNkU6qCW1QpIUqraaWorYpMTCndoR3r6avnBBZ88HNMuFxUC5MBVTUAGywB2PWY/Cl9xEL94cLUAmOQuJNN2uCHTNSqAqlm8AHWtGoK9EfCC5pXzOakIUH1c9P7kK2OpQdDBuuzV6F4et1yG/+Cou4IRQlDizw7X0zHttcJy6Uk1MjgHeCN2expQytBhrlrLGZppGqa0HkXxoITLEDFOY4Ls4eukaZUZvsphyHRMvz3N8JKmk68we1l0rbcT4oouJanWmq9v6GQbl/dvsoVx2B8pn4Tkt/yhhHQQKXB26B1qCAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(2906002)(6486002)(6666004)(38100700002)(2616005)(83380400001)(6506007)(26005)(53546011)(186003)(31696002)(86362001)(41300700001)(478600001)(66946007)(66556008)(66476007)(316002)(6916009)(4326008)(8936002)(6512007)(7416002)(31686004)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cndNTzhWUXRPUkhzc0dGamUrdTM1RWszRzhYVUFLcUtsTUdodFNISkI4U0RT?=
 =?utf-8?B?UUN6WUVISlIvZFdqV0RNdU5qR0VzWmxSZVUvWi9venowUHFmTFk4dTNDMm5n?=
 =?utf-8?B?NjBTRG1taWJMeUZEKzYzN0Y5ZWlnUzBhU0xSSTRmd1RpKzVMUk5vZ3ZqOVht?=
 =?utf-8?B?WGlDL1JKcTk1OEhsa0N1bmtubXFqTGNUN04zWHNxdkhFcFRTN3JvK1Y1end3?=
 =?utf-8?B?RExtVGR5MHp3elFnUUZsRURZQ1VpRHpNK1FId281UFB1bGlCa1VQczQrVDg4?=
 =?utf-8?B?eUVZMVUyL01NNS9mN2FYRjU2dGhHazdhWTBpamNqZ2Z2ZzREem5TaFhxMkhU?=
 =?utf-8?B?b3Jvaml1L2dBSWRZOXBNclBZWm5OZlZPblFzYmM2M2pVd1JPUGJDM1pFTSt0?=
 =?utf-8?B?cnhCeXpmbFFuTE5lR0x5TndRRkJXQUlUOXBrRmxuZDU4SWhDdURFcDZvNjBO?=
 =?utf-8?B?MmJrMjlHMURoTUtTLzFqTUZEL0FjM3ZoYVVTOGRISkdPMWUzV3ZzYXc1Ui9n?=
 =?utf-8?B?U2dpSEVCUU9heGtBZ0VOU29jcmtMQnpHdTBrOXgvSi9RNmFKK3diMnhidmt2?=
 =?utf-8?B?LzA1RVZGYXgyeFJZdzFTdlVtL2FkdU52SVJLTllKRFRwWVBNR2FpRFlBK0ox?=
 =?utf-8?B?Rk44dTZ1dUJlcDczUGJuUzQ5RmdKRGxycXErSVdOL2tZUUdHNkJES2RlT2ha?=
 =?utf-8?B?M1hKMUFIWEhPQmtENVZ5ajBVOUJYUFNOMFNnOExNaE54dzdjanpIcjQwMmtM?=
 =?utf-8?B?SjZTTnBxK2RaYi9USk5tTXRSNm5KZzIzZ1V6bWV5cXQ3bzNwU3FxazVpVlNs?=
 =?utf-8?B?ZzBKZnkwTGJ5YkFCLzFPYWppMXJmTElnQnZMN2s4aHVPM2QyTGlzQWh1bmJT?=
 =?utf-8?B?aFpubVY5Rng3elRrdEIyL09lMU5mQnBsc2JSeGZKem1MdThXeWcydEtqSEZz?=
 =?utf-8?B?MEk1czZqTDFJTzhSd01tMlkzYzdOeVVUNjdIajVqdUsvTDVkMTdtOStsRnEx?=
 =?utf-8?B?NDVYTVBuWG5yeCtVTzlCVHhKdEpBRUZFWkJvWUd3dVl3Uzg4VTVTY3dHOHR0?=
 =?utf-8?B?a29UR3VEcVErSGh2djE1ZHdqTUtBZTgvYnpGM3pyem96Rll3OTlCbVpkbTBi?=
 =?utf-8?B?aHFnc3FKdEFmamZXeWt6SHBOcGdkSm1RZzQyR1EyTUowTlN0WFNCN0dpVEt6?=
 =?utf-8?B?ZUo5cmJWRk9lVzFSQnJ1VnJleFc1ZVVjbXR3UE5JZVdWSTB5MUpTQWdNdURH?=
 =?utf-8?B?bXZmZWVQVzhtUVBybmtXdXo4QVBtTnFDWGZhMU5XSEFVN05hRlFvSkpyaThp?=
 =?utf-8?B?Q2o2UDIzcTBINmxCWkxuQ3hzUUcyRW9KcnR6UTdpai9rc3FyYVRlbi9Hdi95?=
 =?utf-8?B?QncyWCtKZlhEeWlIeHl2QWRVbTRvMmZjSmJVdkMyNzFHYWk4VWQyMnpxM2tD?=
 =?utf-8?B?V2o2UVNIL2g1dm9iTlhCQVRvb1dtZ2g3V1pTQ3Ewem9JV3BlWUhOc3cxeENN?=
 =?utf-8?B?elJodDVQWUdTQmpsWWw0NzhHVUZwdGdyQ2xFVFhyZUtncDRPT082TkxUSFpX?=
 =?utf-8?B?bzhPUlhKQzQ3QklncHhYekIvaEhyRXZNRmF3NjBpeENSV2ZjTzFoUEhsdDRC?=
 =?utf-8?B?azA5aTZselUwdlJPVk9jc0djYlU3dEJ1dHRBNVoxS2xERmNBQmNFK0tLOFU3?=
 =?utf-8?B?NXoySk1EVFpGUVhacnJuL0xDSDg5TTZ4SlhZeVV1a001QTRKNjFuS090Ym1C?=
 =?utf-8?B?YWcvWTRDTXdUVG16QVBrK0hnblcyWDRlSzlPb3VpOHBvMlVjVVhyWEExcW82?=
 =?utf-8?B?SmJyalcyaDhyTHpUSUpOd3BFa3RLa0N0K3l5NmpYWHl6SU4rN2JqNUs2SlJ3?=
 =?utf-8?B?cU96OVViV3Bia1lqdGM4SDlhL21lUVVzdTd4TmRYZTdzODFBYXFRV3lMOHYx?=
 =?utf-8?B?d05GYmpnZ28yOEFJMmlnUFBsajV0YzVRTER2TmNRemdyb1FCWG5QVDRQb3gy?=
 =?utf-8?B?TlVJVFhIRURGZTJaNVpKVnI5VTZjZTBRT3lyMmdrT2ZjZTNlLzM2aytwVjBh?=
 =?utf-8?B?UzlxSFhqeXdBN0diOEErelloUVBzRjMvZ3QvWU54SVczTnpLbGZmeU40d1J6?=
 =?utf-8?B?UzlDZVZSendreHEyaGhKcGF2b0QrZG0wdk5FaHphSEljcE5laGpzS0hWdFFy?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19180707-1d54-428b-2d08-08db76216c69
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 08:43:34.0596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpFqxXJjDGhwChlgHvjA3pmAcwKv7TUYCq3JffEtAJRxBry3wZS5cml7wuudjHn71o4/tzopuYvOHsgkE0Zj4LnyE+SaGjJoUrhIAogefsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8503
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.2023 22:32, Simon Horman wrote:
> On Fri, Jun 23, 2023 at 10:41:13AM +0300, Radu Pirea (NXP OSS) wrote:
>> Between TJA1120 and TJA1103 the hardware was improved, but some register
>> addresses were changed and some bit fields were moved from one register
>> to another.
>>
>> To integrate more PHYs in the same driver with the same register fields,
>> but these register fields located in different registers at
>> different offsets, I introduced the nxp_c45_reg_field structure.
>>
>> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>> ---
>>   drivers/net/phy/nxp-c45-tja11xx.c | 82 +++++++++++++++++++++++++++++++
>>   1 file changed, 82 insertions(+)
>>
>> diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
>> index f1f15a1b6cfc..2664b3bfcb35 100644
>> --- a/drivers/net/phy/nxp-c45-tja11xx.c
>> +++ b/drivers/net/phy/nxp-c45-tja11xx.c
>> @@ -191,6 +191,21 @@ struct nxp_c45_skb_cb {
>>        unsigned int type;
>>   };
>>
>> +#define NXP_C45_REG_FIELD(_reg, _devad, _offset, _size)      \
>> +     ((struct nxp_c45_reg_field) {                   \
>> +             .reg = _reg,                            \
>> +             .devad =  _devad,                       \
>> +             .offset = _offset,                      \
>> +             .size = _size,                          \
>> +     })
>> +
>> +struct nxp_c45_reg_field {
>> +     u16 reg;
>> +     u8 devad;
>> +     u8 offset;
>> +     u8 size;
>> +};
>> +
>>   struct nxp_c45_hwts {
>>        u32     nsec;
>>        u32     sec;
>> @@ -225,6 +240,73 @@ struct nxp_c45_phy_stats {
>>        u16             mask;
>>   };
>>
>> +static int nxp_c45_read_reg_field(struct phy_device *phydev,
>> +                               const struct nxp_c45_reg_field *reg_field)
> 
> Hi Radu,
> 
> I think this is resolved in a latter patch in this series.
> But nxp_c45_read_reg_field is defined but not used.
> As is nxp_c45_set_reg_field and nxp_c45_clear_reg_field.
> 
> This causes an allmodconfig build to fail on x86_64 with GCC 12.3.0.
> 
> --
> pw-bot: changes-requested
> 

I will merge the commits 3 and 4.
Thank you.

-- 
Radu P.
