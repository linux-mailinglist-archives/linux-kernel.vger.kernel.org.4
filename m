Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D88962B452
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiKPH4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKPH4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:56:33 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2130.outbound.protection.outlook.com [40.107.22.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E56120984
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:56:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYX04zuWYacxCms5gNjc1fKlLQ5C/mjjlRqv9T4XOXrwp+Q/8JCIKVgA5iu9cxzLj3H6NWt5qvycm+KAHqiq8PW17CUlqvB0NcIpXAli1KJZc99G3eZz/DsgXKLzC69xqYBX3Q8WjPduJ8rX1zA5eL6wHmbjNTiQmK4aFOQvhNqAvjDHVl2exkw+g91jhA0oTiy8+L+IAC92zua32qjiWLvGKNYwNInwI6y6/Z86AbuGulq6us2Uf/yyBUBL74KhM/NNuKAu9gzF+r0ywN86hsP+C+KLg0IGg/hHAmRrY+/gOV9Dpu21xC4agouftq4C0sKGIK6Q4TtZB+9hmJhtMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Nr/gC3du675qYeYMIKUDZ+fXOAWwJy7GWN/UE9xmHU=;
 b=Tr1lzJJNd4zmj86oPuhOkhQDMm2UBUzYKia/v2h81mdBlRW5Hr40SzxXOlX+3DD5DXZm2AK3vSGgfvSbJA4qlMOcq2Ne62IO3SIvtpJWWnyBrvNvyi1bibw7nLEnBvaPyl5IrzRT5XAtlQV1B0SfrKPDI2ozc+YmJ8VBN/+yIPOmgqKTDMANViNw5lYlkrXr131Bo9p3oy4YDzn2y405vtm18EC4gscO03Pc0Y6eKXxD9gWAID7ejKq+amOWtn1pLPgxnSVbnGheFXHitj6d4B0pjhAGeS7hoASu0WlmI0z9ngOczGidvYMOT+sGnUn+qIznJdMO4jv26RN5vq9VSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Nr/gC3du675qYeYMIKUDZ+fXOAWwJy7GWN/UE9xmHU=;
 b=dVk1gbkEhNHHDciFJiyQ/r3vcl9piC7sOI+gNg27BrAqkJXq6t4U3rNQILEJy6UoAdi3ValVLADnofa30jfmx+LSnx0G/JMbnYutdDnI9V7CvRv58SiqDI38XdK7FroaEs7+qzpZRArnB8KSHR8AU//5VW04aVcDmhESFFiH+eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by GVXPR10MB5838.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 07:56:27 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::732f:4316:a0be:bdbc]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::732f:4316:a0be:bdbc%4]) with mapi id 15.20.5813.013; Wed, 16 Nov 2022
 07:56:27 +0000
Message-ID: <ee196f9c-a3f6-05fe-83c8-c81fbd73acfa@prevas.dk>
Date:   Wed, 16 Nov 2022 08:56:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: scripts/config bug: can not enable CONFIG_FONT_MINI_4x6
Content-Language: en-US, da
To:     "Zhou, Jie2X" <jie2x.zhou@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Li, Philip" <philip.li@intel.com>
References: <CY4PR11MB13207C899E7C3FE22C1D3F2DC5079@CY4PR11MB1320.namprd11.prod.outlook.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CY4PR11MB13207C899E7C3FE22C1D3F2DC5079@CY4PR11MB1320.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0090.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::31) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB5266:EE_|GVXPR10MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ff09f5-17f4-442b-0525-08dac7a8106d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hyWlJ+JLpEjdt/9dDaVap+66+L7f60SNmgM0ZZE2So4kOLND16crO3WJSEQlA9846Fa5PaGn6Si8DNXyC/Fg22G9wlzLGX6o3QZ1Yupnh6nWawkMMcyK+h4zdEhN+xv3vM0l/QLCe2aFv35vCFSgFkcj8pju8FiwfBv8ENBjxi8hzzxLU+qllqhQgirRzICCmGXIa0YnTNsr0b5q5HXbvpQyBsxli9lETQONsv0SETBR+5cZ1FV07Bh9fbJljVDhj+ZBIbcHWN9d2W36LLK/tkVY8Vytg/KZsnY/YjlbCuucaIC0/DzcTcmG0KvYk9uV5sD6yr6IVAjntMPAnb8f/++AIIopyJAQHJ2q9qGsLNFH6N4SxGuQWzJAhNeGvolvV0MXTlYoYcQvDL3UlridVUz2AszpoOH0rOKjhtP6T7eSm9WB78q8RYaJQ4IcCA032j5aHq+Gs9tKB7VoHv36MxdONxOFiMx1pH9MtdADrM/bbh1OG15VwE6vw+opw4RO/n9SYkzzY88mwDHaI4FXPXK5ivNYpEVrkUyolY2vXQv9fONhlN4pX1+7MseKA+PZ+F2OeLKTwtcao/87go86pDcSIN5j5A6r7FvcLy8bBbYU/AobcXhRGk+7t3mugls0AXex7g33Qjla7EozHwsYerC2qOJnrJdGDAxw/89L1Y6HyHCpkyCSkyCUFUU/aI4GEVi4ZBRTTjWPO8qyhItSJwhMqYeMUs3vKmxv54ix/Lglnm7dPIbmo8cF3cht9JzX/wM0predutalzneq0SwpQtwvnql4inNqbVAloJgTIu32ANrnpgoGYfFT86O9pIw0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39850400004)(346002)(366004)(396003)(451199015)(36756003)(6506007)(186003)(110136005)(2906002)(2616005)(52116002)(316002)(38100700002)(478600001)(86362001)(31696002)(38350700002)(6512007)(26005)(6486002)(66556008)(8976002)(66946007)(66476007)(44832011)(8676002)(4326008)(4744005)(41300700001)(31686004)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejVaZEZPaWFqdHdHVEZTY29qQWF6cDRPQmJNSU1ydzI1Sno0MHJ4eDUrRUtY?=
 =?utf-8?B?b3BNNkJxUGRVek0rZ2labXRoVFpvUndadjlLWVZpOTBjR0JUc1A3OWJ0RHJB?=
 =?utf-8?B?V0luNUQvRnhJa2pMMHhJMDNuY3BsWlR0SzExa0ZVd3AxVWdHb2piWXJSTXhu?=
 =?utf-8?B?RlNQQ1lIQkNyRUt5b21nMXlFM0JOSHA5SDgwdEN5Q3cyRVpEWkxNcHovMVA5?=
 =?utf-8?B?SHdvK3JRbStRNmxPM3o5VmU0Mi9NWEk3OUNidVZhSWRTUHlJZ1dyQ29ZT2dB?=
 =?utf-8?B?ZlY5dDJyeXh2T3h0UjI4VWlOT0pOcGtWQVlUYitKNmtlNHpMU3pZZTA3Tk1j?=
 =?utf-8?B?TDdtUTluR2FzbVpSV0w2cnZmTzg5QWQvNnpqaWRWVjREL2RpblEyejhOSS9u?=
 =?utf-8?B?Wk96bTgvcUQwWEVlWEtaMHp5ZFh4VmJYckhNeUIvaHQ0dklkSm1NVnVDT0M3?=
 =?utf-8?B?TysydjM0azBLRDFaOFg4UjJpeHo5ODIvQVJaZjVCT0djUXNyQzAxQ1p1dVBJ?=
 =?utf-8?B?aEMvKzIrK01zR0lSaXZ2SFFrcmxsT052OU40U1BVcm5pcXBKNFJyd0NnUGVN?=
 =?utf-8?B?ZXpxd2JjclR6T1NNaUFxV3hib1E5YUpLd054RUs5OVIzd3ErUDUzdG9tODU4?=
 =?utf-8?B?cHh0L2VxZDN2aGNteTRRb0NCNmxtMmRFV2swT3FQeVJ0S094K2g1WXZCZnNT?=
 =?utf-8?B?Ky85K2lPVUFFQVpXUExYNTFWeS9US2M0K00zaFZtbnZMcDJiNEJPNXJwaGxn?=
 =?utf-8?B?RDdZU1IwY3FaM1FzQXVheHFqSmxoT0RhemhJWjNNRGx1WEVCZXBRQm1OMEV1?=
 =?utf-8?B?ckNwZGhOMVloSHpCNDhuL25vS0o5UUZqaGRqckFINVNDencyYVZEdXFmWDNh?=
 =?utf-8?B?VmFoK0F2a3B2dWZqNDBNc3ZSa1MwWFk4SndvajJtS1Z4RDVWU1ZNY1hwQ3BQ?=
 =?utf-8?B?MjhTTlBuRkZJQThIUlpEa2ZwOUJjQmRka3pOQk04U1J0VVJiRUpQbUVKK29t?=
 =?utf-8?B?SDVjOGJoNXkwQXpMcmU2MVlDR2hRa0NpR3RPQXY1TUhna1d4K1F2TWNncjFa?=
 =?utf-8?B?cThLTjNOZk0zK0thcndYRHI5bmdVNDZkeDJDbWYzTm9Ja05zSHJsZFVmc3d0?=
 =?utf-8?B?YVdoS2IvTG9WcG9pWmo2MDhjTXd3bi9TS2lsTFYyMy9BZ3FjZXRYL2dYNUQ4?=
 =?utf-8?B?SmlLSlBraWpoZFdRM0FoLzVFbHZYb2lnQnhOWjJUQmQ1UVhHbUEvNWJGelBV?=
 =?utf-8?B?b0d2ZnE0VWdDTDB4V1pXaksvNEdQRzJ4QzMyVG1ORUdZeWdYbC85ZTEyc053?=
 =?utf-8?B?aXdhQ0xlaDlOa1BtRW56aWY3dlgrWGpjVXMzWVNxTWNla2tjWUhEeHh6cEJ1?=
 =?utf-8?B?VndkWUVrci83L3lUTEl6K1QxemdodkZ5aVlLLyt6d0tIMFFtaks1T05EQWpI?=
 =?utf-8?B?MXYvenlKeGNULyt6QkJjRW1JVHBwVElKZm5xQWxMTDMxQkNhSlR0L3htVFor?=
 =?utf-8?B?Ym9MRTJwUXBBRDFWVjR1dUJVV1IwQkN3djd5NTVTWjNsOWxRWGppUy93dnFu?=
 =?utf-8?B?Q0RXQlBmYmhEK2hBOVZnVTY4QWxsaU9ZcEsvd2Z2ZTRyL1R4QVM0ZTlIWC83?=
 =?utf-8?B?WkJYRkovVWFvZmxQc2ZZVzQwYnVmU1loOGoxMGhxVVZUWTcvSGIwVXdkM0Mx?=
 =?utf-8?B?REx6TGgvZ3JQZlBNU2JEbnlXQzNGdGxGODl1RmpobTlvc3p6NXFjdU1pUDR3?=
 =?utf-8?B?eUhlUE1LaTlSNERDTXo3K0V3RmdkYjhMK3pOdWNsTmU2aUJGVFZiQWdHKzJQ?=
 =?utf-8?B?bGh5Z1lOSkhKNTJ6YW1QTU92T3MxYUo3WWtoL1o0WU11U0dFL05TbVlCaHV0?=
 =?utf-8?B?SDZkMWZNWnFpL2diQ1hpVjNWbCtFYUxWRktNRlhFcDhZQ2FYZUhRejhsdjJM?=
 =?utf-8?B?NWtzWkRlY1VWbmdHVXpqYUVRaWtHdHpwaEpmVnNjNkMwelFIL1dzSnFVb1A1?=
 =?utf-8?B?L3FPbzlMbG1GNGZZVW1XNU45Sk1YbUxsRWkzRG93NWNsRFVWMVJFeDNqWHZx?=
 =?utf-8?B?TlNjZmVVZzFSbndCZzlYandqWFBTMkk1dUlLZHVBQkcvYjgzT3h1Rm1FNXAz?=
 =?utf-8?B?eHVUK3grU2RjcGs1eGwrNFdKWDFYcFl6cisyTTVqZ0JtT0JkRDJLZ2VuMWtS?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ff09f5-17f4-442b-0525-08dac7a8106d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 07:56:27.1765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0n7+5IkEbXoh3BNBSiSCTdBw/TgX0Fpi1CJDIZK9/x8tKX5hX1+5LAH1FYibGYWJBYPtJQhSTJd7FA/sRqTvemmwNrDjfBeHdV4z84RnMYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5838
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 08.29, Zhou, Jie2X wrote:
> hi,
> 
> This is a kernel bug.
> ./scripts/config convert "CONFIG_FONT_MINI_4x6" to "CONFIG_FONT_MINI_4X6=y" in config.
> x->X, Lower case letters become upper case letters after process.
> After "make olddefconfig", CONFIG_FONT_MINI_4x6 is not set.
> 
> Add CONFIG_FONT_MINI_4x6=y to .config.
> After "make olddefconfig", CONFIG_FONT_MINI_4x6 is set.
> 

From the script you're invoking:

        if [ "$MUNGE_CASE" = "yes" ] ; then
                ARG="`echo $ARG | tr a-z A-Z`"
        fi
...
MUNGE_CASE=yes
while [ "$1" != "" ] ; do
...
        --keep-case|-k)
                MUNGE_CASE=no
                continue
                ;;

So perhaps use -k when using that script to enable one of the rare
config options that contains a lower-case letter.

Rasmus

