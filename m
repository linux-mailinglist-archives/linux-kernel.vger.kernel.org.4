Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41036FDFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjEJON2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbjEJON0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:13:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2091.outbound.protection.outlook.com [40.107.6.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE341D8
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:13:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcN0BGEkOb+HuZgp9SX1tZaUK8Id06SUSzWbbgIkqS3PHSqIq2XuYUrcloiAzasN9/X0Nbp5wlMEyjPdGucnl3lXbmYuepx+vx69zsAIJ8/4L+/Lb985CA2AkH0L6LX8O2SGNIVw61M7BovNb8LrlgMe2/Zj9nXJ4CzMSeAqkMUm3DHzqvqcQQ2099nVJ5hDEDfBS9CDtB/n0vrg79TLeBGw1RcHyBmS3S/03GZhZ6yxxw6EJAPlymt6D3HwR7muAYnRgF2RzTdTBmXIyihoIHzvUbwZITlIxKbIAFCcZWVeZzul7wC7woN2FAbU7IafDNZPPfc/fQtW2Qa9vdxndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaCtgl2KSx5YGwxA7eC5nDwYQ8H/9iI4ky+foMEv6oI=;
 b=glxHK01uWsr7LV8LfAgErKp/FXHCQiD4v/LjVdRAf8U8kGAQkmGvjJ8SIFUP2Arlbv0T/2VXDpJcRTnvKijtyHB1at6Mkay1VTTFQw18DBy1cLY8fBOiZKOiRmE20rD/rhoczdBUd5NFojxPl9GxGiwiHGcuTjbplGIoFsozVbqMYwlWyNCgXhnP7BHwLbMJVHAcY7IRs09oeMHycKzKjHFdDfk0DTdN0ay3+0Kf1lvySJjs8JXjumIkWK9oVmHhB9NkOgEWaW70iaj5gr1RlEykzmGN5YCGpbvGkVj/oz3f5hg57wEkfSn9sziJlFi6uuVcNglwI1y/9kPT956Law==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaCtgl2KSx5YGwxA7eC5nDwYQ8H/9iI4ky+foMEv6oI=;
 b=C1TMQHdxqUMghzRQP8lb661zrrUlVyKmc0bHTwfDTYtetJWImJJFMt8zXicQL/SRumT63rEXhvNmEJOgLa8OIs3NeydadNfA9Lp4ogOF+KIav4+dUhKM7OqyMIuXyaDw9PKng7vslDGLbD0aC79dfkzI6HmXaSeSqLG1RLVw3cQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS4PR10MB5765.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 14:13:22 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::280c:cfeb:c9df:35d6]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::280c:cfeb:c9df:35d6%3]) with mapi id 15.20.6387.018; Wed, 10 May 2023
 14:13:22 +0000
Message-ID: <37caab4e-c46c-0278-fa12-6c2934c85185@kontron.de>
Date:   Wed, 10 May 2023 16:13:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/1] regulator: pca9450: Fix BUCK2 enable_mask
Content-Language: en-US, de-DE
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     linux-kernel@vger.kernel.org
References: <20230510135718.2268529-1-alexander.stein@ew.tq-group.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20230510135718.2268529-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0007.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::19) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS4PR10MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d83e221-1b07-4bc3-d564-08db5160b668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fka//zTqeIpAoALPTTALGK1RieCda93VDdy3YG7we0JQS5/5zOiguWTYHNgTvWfkKdbiLpf4d1B6DDiJZOh6tz6ju1QJ1NjETsTUVY8zG2+p7hGIQD/S+69gRsvzyn8D7LbD6jk6mH4hQYmGMYrjisuGZVPB/Cbxkt5nRGhaltYg4K4UIwC0dQcQy3Z4Nmclf/D9iz6v2VgGTAf8Gf6BUancLiCC+Y10ycKdnkSPhd4a1e8st5kwznu53QxNdMapN0ENCR1Fp+KCZqD2Mu68bRRhQR1Vk3DGyV309REYnwBhBMAadjwv1KFFWVDYVrG3hpZi/JhcQHmihz1Sn07+hVGEktJgFWkUagx5G0qw5BMEWYO2R147TYyRWllJ+gDqABvW98gBpjVG0p60ePL6xnMJqo0lHJP1POyXkXYWFiy/tRnz8eawicLXJJjrB7iYAjMIpZsuC20ptYLLtdM4r8wYPtqkalx2UX8cdaE9BRdsrSabvW1jgB8PTe7J06ysU3K9RKsTthCuRZdqclQkl15bBqPKwTIC2be0rcm7KtrKLC+YrJf7m0ZAXIe9bZg/uL0B1bwbkRtKunKjN/VA5sNae0BMpgE8cvcS14IDDvB912yreU2x5EbUCfLw5U2oO4G1vbzLbB3nFJZ11hDVyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(38100700002)(31686004)(110136005)(316002)(53546011)(6506007)(26005)(6512007)(41300700001)(86362001)(5660300002)(31696002)(66476007)(4326008)(8676002)(66556008)(8936002)(66946007)(186003)(478600001)(44832011)(36756003)(2616005)(4744005)(2906002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUJRdFpLU3VGUFowSVozMnl4bjczUk9DSThLRXJZaUpaLzhsd3ZhQ0F3NDUy?=
 =?utf-8?B?b3YxNjdITnhmSWZ2YjZsczBoR0JMZ0VBR0tiVytXRTZTTjdqWlYvbVVPTXEr?=
 =?utf-8?B?cVlQK2kvQnBUU1Y2SmtsTDM4S0prV3hWVCs0ejNvZXhKTCs3SjRaVllXbVJU?=
 =?utf-8?B?Nm5ZRXdEVG10a2x2MWJENWhsa2wxcFo5bHdVaDUyVTJaa2RvMC9CSll4WDJY?=
 =?utf-8?B?ZTFsbkFmL3FveDFtL2FUckFqVEdiY0FrNE5GY2p4SzRJeHR5TVBNbVZkb3FE?=
 =?utf-8?B?V0YrM29jQXBNRGFmdEsrbFpTZ1pJbWNIZkZyVnlvOGdMVExIQ3M2Qm9leVVn?=
 =?utf-8?B?Yll6YVUrSlQxYnRUVUV0aWFUUHRtMnVjMWp2TkR1M0IxWk5JblNDZVRMVjU0?=
 =?utf-8?B?V0lUcUUxYWNMMTlTODkzK0wvREgyeDl2aGk4eFJ0STVJOGxpcG5GVHp6ZC9l?=
 =?utf-8?B?aUlDQWV3Q2g0R0xINUJ5WGh2TzJ3L09FUElpazFaMi8zeW84TFVtUHNhNTAx?=
 =?utf-8?B?UGVVRzhVMGJFbDFwR0lYdFQ1WnBHVkNSNVdDSk5DNUtoMzVKRERQaElDc2RB?=
 =?utf-8?B?VVpzZWEwUGFtOHByYkV4OVcyVTZIZndUM0g4QndUdFN3TjNxaEJrRCtUc0JF?=
 =?utf-8?B?SXAxRDZkYTB3dWsydDlISnl5WmpXY2x6cVQ5R1laeC9qOFl0Z21ZcEt3eDZx?=
 =?utf-8?B?Zk56eXpRQzBrL0NSZU5IZUlUSUp1dHhCOFVuQXlONlhBRXJLVmZpNnYzSXVw?=
 =?utf-8?B?aElrQ09ycXRNNElRanFTcUtRRjBwZzRPRFZBcjBiUjljY2xTQTFjWWZVU1BV?=
 =?utf-8?B?bHhSdnoxYlZxcjNDdk9GcTF1L1VNYnhocThvU2xpZ2JEL3pnLzcrUkRmTkpN?=
 =?utf-8?B?WlhvejRRcHJEME5tamxiVDE1aGFoRk5kcXFMRGFEVDc5L0ZCTE8ra1dtbUxt?=
 =?utf-8?B?YmdwM1d2M1hDT3RrSVhKdE1aV0ZoZnFJVzlDUVpHZTRZaFQ5WFlxc0xOM05Q?=
 =?utf-8?B?ejVjZDJJeGFlNE5vK1FvOURVMDFyLzVTNXdzMUhLL29sRHk1eUlROUlkYWtG?=
 =?utf-8?B?WjNJTlczL0g3Yzkydm1Md0FGdEgrdTlsOURlTkwyVVN5S0NBR05VUzk3cmFh?=
 =?utf-8?B?KzIvTG01bC9ES1p1SENQdXhNVkVBWVZBTHNwdmxkV0ZkRWh2R0NtelZrTkhh?=
 =?utf-8?B?REN3MkRYRG85MHMwRGVzQnJtaXFZTUZ1NWt0b25ldFZwaFBzMGRMcGZyeW8y?=
 =?utf-8?B?SFBGQkJYa2lMMkpZN2p3R0Nrb1dWZjJnVHhML0dnSnZDQjY4UStmbm4xekxo?=
 =?utf-8?B?bFEzYVRUY2dqb3lncGwxMVh2SGxTdnVteTMxUFd4OVpGOWpvSDdlWHFMRFVq?=
 =?utf-8?B?LzBjck14MUZxREtsYzA2YlB6cU1QQ2gxWGRsNStLbWtNNVpwTThJQUtyWEg1?=
 =?utf-8?B?WFlMOE5MdjIwbm96M3grMlNzdUE2QjdiNk4yaElCaERkNHIySkJBQ3NzUVNl?=
 =?utf-8?B?bGEzYVBOMDkxNmZLU2NINDNvL3hURFNEWS94Rkd3ajhKaDNzTUpMV3UvWXlW?=
 =?utf-8?B?b3BlK1djMEdRaUVPMVNYMUhoUlh4VDVXb2N4MXpLU25pb3hVUG5FcGN0MjBs?=
 =?utf-8?B?anEzbW9BRmJnVTZsVkZxV2g0aStlaUZWenpqNGgvK0xhUkM4bTBoRk83QnpG?=
 =?utf-8?B?b0JCbEdMNHR6WG8ycmtYbis3VjZydnd3TWwycE9zZ1d2TGpmTTlvT2NtRThT?=
 =?utf-8?B?MHdlMmV3MFNXSlFTa1lOQmdlK2M0NytKYTkvWnF4bjYyUS9JZnFvUS81d1Zh?=
 =?utf-8?B?OFdTTEhnalZLMlNhSTVTQlI2dW92T1pNOXlReVdjeTlkc0luTDR3UU43T3ZT?=
 =?utf-8?B?WEFlVE5jWFh5WTZtVHhQR0ZhWEpPeUFUaVdwWjFqMjF2QU5aRjkyZDRINHBx?=
 =?utf-8?B?NzVSUXpiMjJkdngyNEtLUjlVQ2ZibU1tdnZkTXR4MkRZQmJrOHJsNFkxM0N3?=
 =?utf-8?B?YnQ4cTUrTGZ6YXVDS3AyQWN0blVDa0M5bDBQVDJ0UGRyZXhzUjJzK2trZGRr?=
 =?utf-8?B?a0xxOEc4blQvYzZUTCtneTFKTUV3VmhZZ1pvLzNzckNMWFE1bFVVbHhPRGwz?=
 =?utf-8?B?OVh6RHVlaG1xZFlHUGdkTXMzcElTMHdzK2NCSGF6YXRpMzlaN2ZRRkh1RFlZ?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d83e221-1b07-4bc3-d564-08db5160b668
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:13:22.4772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PD80X4/ZFNfhGNMI+cmyqlZgHwnbVIbus6qywz0sJXZN/2GXlBS/b+pKsy7Rv8Tx4i63c2JwXLzEb/TKINzMBmx9sMtTtP1+vR6EPxdqrt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5765
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.05.23 15:57, Alexander Stein wrote:
> This fixes a copy & paste error.
> No functional change intended, BUCK1_ENMODE_MASK equals BUCK2_ENMODE_MASK.
> 
> Fixes: 0935ff5f1f0a ("regulator: pca9450: add pca9450 pmic driver")
> Originally-from: Robin Gong <yibin.gong@nxp.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
