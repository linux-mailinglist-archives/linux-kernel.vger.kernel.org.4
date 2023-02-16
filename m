Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDCC6990E0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjBPKQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBPKQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:16:09 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2134.outbound.protection.outlook.com [40.107.22.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CA6518DB;
        Thu, 16 Feb 2023 02:15:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCXMC/UvtHxtmkXlP3bk9IRQ6TOvzEs4El4K7O0CaxNPwKxugYsx3NSymtsQezey844L7pvVCH38EHGP051OciUBCZ5+9CSDQIpNMLo6IdlY0nIa8zKUcwIMbiGAgB4YJGmBGwlTfZW9TVQviQuAEjlgcJv2kH9NKVBIUuqhfWdbhmIV02LG/znajTVfuglTgpP3ibxc7KXSkFtBi63M0YhsVzuy9p3KWrie5tIn3v0mxXA+DKWCc/3exY0wwvOutPdFa4xiJuXD1ac1NLlQVTe1cKrW7VMOeux7OSoC+5/EDPqTOTuIWHNlXnkRw5tI0LFWwlJdHmjitM2qf3MhGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irBYu6S4A228jiXL1L1B8vhYtqDqfzcJCtA2ZcDTUH8=;
 b=dAdDS026atsG4EpiHLa3bl2nkxJi3T+uw0RgDHVv/ZktffHN8pBON3Rja1DKU1y8NHXrW3H5KV90w9FK6MT31y1cpKK3ZLIS1lCPgJ5zNfZfDDEVRe6H9iGY0+65gVN4s/NkVOmAAz1vgTxIDbKy1v6dza9KXxE1xWlgUsjpz5ewmLT7X3qpE6MHOW9pOnZj5Ebl64CLHF1k0H8aG/sfYu1Ntwt7P77pH2yKK+COeHGp+ECQM8MvM83shperb6meXP3v6lU7xkvexwq5a5Lbf18yFOt32m3PWlAdowi8Wf+OVUXfQLoqNtGVb7YL+2aswQdgIcKMKf/0OocQ1PGRLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irBYu6S4A228jiXL1L1B8vhYtqDqfzcJCtA2ZcDTUH8=;
 b=TAPQQYqB+j5fMbvNfa5mg79mLDCTnQD39F/KNFta2gESk9bgFWPYaa0GVhA8BT8MGNxs91ZcVoQrgt4v6O3QgRbF2vvN5Z9xQx9A8xfwOg78Fg0p1dG5ZvrhjelXc55rQ36sofDTwq/toa3gDO/5lCrHN3sK1pMsh2dzT8w4hlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU2PR10MB7814.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 10:15:57 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863%4]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 10:15:56 +0000
Message-ID: <531dce76-2767-80be-ecd0-4b54e9ec2eea@kontron.de>
Date:   Thu, 16 Feb 2023 11:15:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 1/6] dt-bindings: regulator: pca9450: Document new usage
 of sd-vsel-gpios
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        Per-Daniel Olsson <perdo@axis.com>,
        Rickard x Andersson <rickaran@axis.com>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-2-frieder@fris.de>
 <20230215200213.GA467386-robh@kernel.org>
 <a32979ac-d272-0865-f453-c65d405814c8@denx.de>
 <CAL_JsqJ3o3Z+jLy-GBJW2i1h7=uN=fPEaC+YTU07P+LbEoq5Vg@mail.gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAL_JsqJ3o3Z+jLy-GBJW2i1h7=uN=fPEaC+YTU07P+LbEoq5Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::8) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU2PR10MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: db55ea9e-5cc5-43db-2473-08db1006cb25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HnD+F4UZ9Cp2iPSLMn8iroSxZQC9veybLfDQRX01cGtGGbXqnSqKDkXVdcHERIYP9WHYlZe+An3nRrXaQFMclHFtqHCfaiWRTUfyg0+TcQqxgaw/MAuN8aJCkSegYTZpF0CtnyLy+0jw6Rv3D4etrdt57j6Y/+4tpmTdAJJRMXf2pYu4MvhlAlhNUnFHkW2cOz0u3/2Ep/rqLg3lf6Z0Gjr1tcNF/0vkvdt0ttrAiKK6wRPnA9I0K8oMOBCwAI4RyVueqAFGpBo8E8FBj3Ig0Uz8l8cQSc1Y3Kdf7ypbUnFLwSdlUlvWYpxB8GnYRoV6A+60rguC8wc4UWNBPChKZAzNlRkwWJdD1H32gQZfgk2pkAMTU0u3o+20YLIPbuUjaLUmQnBfSi1soHwJencqQ6BFwg1sdy0oq81U/tL29MF23sBRVwCPO2GQhWX/yyHm+BCNKxO8ZP7wk2++L9QEZUD5/dv7MeyTg9f3KlR4Qc0VKwmcRHzRhWg3ORMscrzyXCUeE998Poriy5XoHL1KXnU4E8onXdJUE8FNEPM9NnTa+36uefaJ84+62qEASa7k6e60AS9QKMD/pji6KiBxlVEqsyd0l8E/PedHCZJViNZexbCVePa3qX1Z7hqKrAosFTAdK1JQBBt0Z9PhUhM4IvwhQcwfbojhh1y3zCZeSNLEqBanBHk83tUKahyGzVHp+at8L3iq0ksVF0unWobsZu2dRvpl0IMYRi95AS6LpEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199018)(8936002)(41300700001)(36756003)(5660300002)(44832011)(2906002)(7416002)(966005)(66946007)(4326008)(478600001)(66476007)(316002)(8676002)(66556008)(110136005)(6486002)(54906003)(38100700002)(31686004)(186003)(2616005)(53546011)(6506007)(6512007)(86362001)(31696002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDdRY0Z0V3FlL1FOcWF3azNqNjg4eGl2ZkFtaXk0MWJXT2lnbUVlazFLVE5l?=
 =?utf-8?B?RjhoekRpRWlSOTRuK2xRUG5UVXhWdzFGNWt4aEVFaXRBbHhNVEh0a1c0SHZk?=
 =?utf-8?B?aVhaVktPaUI0N0hKSlByNG5VdFVOUWhwdzVHOEVpUnp5NEd3Sk96d3VXNlBu?=
 =?utf-8?B?amE3WEUrZ3dibFJMQVlJYWlQU2Z3aEZNalRjWHJjd3VIWjd4OUpTSFZFeGFL?=
 =?utf-8?B?R2c3QStQZWdXSE5yMHhMWUVFeFlqZ3hlM21GNDczSCs3UFhFMXl0RmxKN3VK?=
 =?utf-8?B?VFRhVkhaSWc3VCthT1dkSVVnSTdJQmd2VmtzUmZuN1BHUCtWR2VKU2liR0Vx?=
 =?utf-8?B?dmNVNytUQ0hRUFhOSGhCOS9jNCs0K0NjOXczUXFRcFZuTVJDUVAvVW9WeGly?=
 =?utf-8?B?aVMrVnRxaFNiZ1JBN0FhbnRDL0MyVW1qcnpRMUllK2dWVGlreFQ3YjJMMEh3?=
 =?utf-8?B?MXN1N09Zc1Z5WkxSYmczeW5IQXhsVlp3V09FaHdIRWJZSmpEZTRuYWpTVjFF?=
 =?utf-8?B?V2VvT0NmTm14OXpGeSt4MndoM0UwS2x5U0hXempnY3RjQ0Q2VkxLdjdjd2J4?=
 =?utf-8?B?ajE2UlZyQmhiREJkK2M4KzMyRGJiU1JoU0xkbDZhdnhaRmJqUmR4cW1jWEV6?=
 =?utf-8?B?QzBZa2hIQyswbGJjTHVZeWZPdnM4a1V2NTByTlcyNXR5UGVXODBiQklMMXp3?=
 =?utf-8?B?ZGp6Y0d3VmNCS2RreE53WmFwYXR2eEZnbmV2RkRtaVVZM29VdWxkN3JKSGhJ?=
 =?utf-8?B?ZnV3ckZTRC91Y3JyTkdYalUzTFV5UHAwWTdZYkpSUlJrWnRRWnN3SVM5a1J0?=
 =?utf-8?B?NStQMjhnVThzWU5PS0NUSlNLOTFNL2ZYYk42Q1hJRmlNNVUza3pDWmhPM21m?=
 =?utf-8?B?U21yRTBZQzIxL2wzZXhrSkp4aUxVNW55RzJ4c0xTOGFUa09CbE1Xak1XS0xP?=
 =?utf-8?B?VmYwQnNEMG5EWklvdTBPMWR1YURIaTBIaThFTEs0Mk1RSENJSHI5cUNzT0dY?=
 =?utf-8?B?NHZ4cDY4K0NHK3I4Rk9yTHRUTE1LaVI5MFpxa2Zhbml3cTVFVndPaVBmWTF0?=
 =?utf-8?B?SEJZdk1UUjN3VFl2VnJxVm1taU5oMkVIcXNkQW5EMmRvcjFYQnNDcElCdHl4?=
 =?utf-8?B?ZWpWeG16cFl0SDdJY2pQVjJwQStIM1J2RFB3MFN3cjJ0YzhrSXZnVkNIdTRL?=
 =?utf-8?B?eGRCTkdWclRnZy9yQjFDWWpPZjVnQytMSE44eXJraHYzQ2g3amxDN3o5OHF6?=
 =?utf-8?B?YlNHTmpqclphM3drT2lUYm14bHV3anhMODd1anAxZUp4V21pOXNyaURQcXh6?=
 =?utf-8?B?SmU5U1Z2ZkxRZU9mYmlnd2JIWlA1dmJkUmVuUWgydjM3YUNOTGRhUXd5QU55?=
 =?utf-8?B?c3Y1dVQ1eVNka1JFbEpJTkZELzgrTE92TzRZZXBsUE9SYXdTRXQrdTVlQmlN?=
 =?utf-8?B?alVUc09vNXhFQm44R0J1QmRORVJYaStQdEFSQzNIbzFGK0psUUVqb050U09v?=
 =?utf-8?B?bmxEc1pkVkRBeXJHYVpTck5OMDV1ODh5MW9vbkM0N2hUL05VMFlqb2drN2Fs?=
 =?utf-8?B?YUhPR0ZNanl5N05DZGJkT205ck5pZDBIajhCNTBtQ1lTSk9ES3dGcVNyb1Nj?=
 =?utf-8?B?MXExem1lajlPMktYQ3VxTkVOODFZR2Jqb05oVzdsMDBRbHZ1RzdiVzZwcWZi?=
 =?utf-8?B?aUhGNVZOZTRLbzF0MjBuQUZ6eDNFNy9KZGMrYzVSRm9kT2JZRlhnWHVTMEtV?=
 =?utf-8?B?OWl0Nmt3OGppVjNvcDNkck9nMXpITUtEOWluZEx4eldER1RBWitZQ3FIamYv?=
 =?utf-8?B?T2ROd0JOMUcrbnc4NkxWeU9aR2xNOEZjTlhBQjRybzNTTEMvSUc2RURhcTBZ?=
 =?utf-8?B?eUxFU29Ea3FzNzdML1o0dHhsMGVYSkhlWEt0RXcxaUVqTmdnR2o5UC9hU0xH?=
 =?utf-8?B?SDJJeXp6Ym1DUWMxQ3lXV3JJN25oWDVSWkdmS3NFd2hrcjBObllnZXRnMXVT?=
 =?utf-8?B?TlcramlORi9LVXAvWldGcTVWTHhrUGNKMFRIRUo4NnUzWWZLRTFhR0RRanl4?=
 =?utf-8?B?c2RrNXVWR0pkOTVWcW5kU2dhYmxGZ3hxdFBOL0ErUlVSSXI2YlcwYUIxMWE0?=
 =?utf-8?B?SG5mUkt1Tm95YVFKMWVIL3czazJQVEk5K1J4bkRaUlE0TXhqRmNPcjJoWm1q?=
 =?utf-8?Q?BnjxJrq20lgxq3TvbMWRsaaAs0IBDzLrDaxi7YSdr9oG?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: db55ea9e-5cc5-43db-2473-08db1006cb25
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 10:15:56.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3elgFNQ6YWeylEou8Pm4UsUxWbq7xg0d3RqER5P6cido72HUq8nAaAuw7JKMtW2Mh01OBQzCKkJdCMCdw5hvyDnAtn193rAQ8u4O5ziA08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7814
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.23 03:30, Rob Herring wrote:
> On Wed, Feb 15, 2023 at 7:27 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 2/15/23 21:02, Rob Herring wrote:
>>> On Mon, Feb 13, 2023 at 04:58:19PM +0100, Frieder Schrempf wrote:
>>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>>
>>>> The sd-vsel-gpios property is abandoned in its current meaning as an
>>>> output. We now use it to specify an optional signal that can be
>>>> evaluated by the driver in order to retrieve the current status
>>>> of the SD_VSEL signal that is used to select the control register
>>>> of LDO5.
>>>>
>>>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>> ---
>>>>   .../regulator/nxp,pca9450-regulator.yaml      | 23 ++++++++++++++-----
>>>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
>>>> index 835b53302db8..c86534538a4e 100644
>>>> --- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
>>>> +++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
>>>> @@ -40,8 +40,24 @@ properties:
>>>>       description: |
>>>>         list of regulators provided by this controller
>>>>
>>>> +    properties:
>>>> +      LDO5:
>>>> +        type: object
>>>> +        $ref: regulator.yaml#
>>>> +        description:
>>>> +          Properties for single LDO5 regulator.
>>>> +
>>>> +        properties:
>>>> +          sd-vsel-gpios:
>>>
>>> It is a pin on the device, right? Then it belongs in the device node as
>>> it was.

Physically it's a pin on the PCA9450 chip. If you look at the block
diagram in the datasheet [1] (page 3) you can see though, that the
SD_VSEL signal is routed to the LD05 regulator block inside the chip.
This makes me think that the signal is best described inside the LDO5 node.

>>>
>>> Can't the direction of the signal tell you how it is used? Assuming the
>>> pin is bidirectional?
>>
>> The pin is input to the PMIC, it is unidirection, i.e.
>>
>> SoC(output)---->(input)PMIC
>>
>>> The binding should support any possible way the device is wired, not
>>> just what's been seen so far on some boards.
>>
>> The usage is always the above as far as I can tell.

There is only one usage that is likely to occur and that is the one we
describe here.

There are other ways to wire up the signal of course and in some
unlikely event a hardware engineer might have the idea to hard-wire the
SD_VSEL to a fixed level or wire it up to a SoC pin that doesn't have
the VSELECT mux option.

But I don't really see a good reason for covering these cases in the
binding/driver if there are good chances we won't ever need them.

> This patch is saying the opposite though. Something else drives the
> signal, but the signal is also routed to the SoC to sample the state.

SoC                                  PMIC
+-----------------------+           +-------------------+
|                       |           |                   |
|                       |           |                   |
|  GPIO <----------+    |           |                   |
|                  |    |    SD_VSEL|   +-------+       |
|  USHC_VSELECT -->+------------------->| LDO5  |       |
|                       |           |   +-------+       |
|                       |           |                   |
+-----------------------+           +-------------------+

This is how the setup looks like. The SD_VSEL on the PMIC is always an
input. It's driven by the SoC's VSELECT signal (controlled by the USDHC
controller) and we use the SION bit in the IOMUX to internally loop back
the signal in order to sample it using the GPIO.

[1] https://www.nxp.com/docs/en/data-sheet/PCA9450DS.pdf
