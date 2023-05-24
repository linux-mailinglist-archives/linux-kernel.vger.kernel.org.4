Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C27270F363
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjEXJrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjEXJrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:47:14 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2139.outbound.protection.outlook.com [40.107.8.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5528EFC;
        Wed, 24 May 2023 02:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkWRRqTXUEoUpJjxfvyPNt45mxJTTLXZjCsW9ux8LhFzKzIIudsLjBH2tSeKP7szc7Zn4ZcKaB1lx6En++vdIN6gmDkSa5s7MEtv4rjC58a3A+4L+FLSIoppaASDpya0CFuGQQgv7uwgpc+btuplsqB9GW/9iurJJYCQA5fF7bdtp1DF9n5CrU9NboaRWLQ0bnchllWyObGFf1ImIJqEUAn5vI9/Z7rOK4+EbYRpPEdc3IVrjMiV91+Eykw9DtElUPHwv73SPIt/D2Oz0UZ6cUwN7vSjsJHxo0ISajDRM8SyaBBRfcQUFZu3LQoYSu8/czMZY/rh6MpVs5k56BAcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiO7jT8i9xyNAL6yaWeMXW8PdajOcq4mqlej3RvAGbg=;
 b=bN9RCfYLraZpBTPlT7FobvX4ONOXcKnsXclf8TytCie6yXpz+uLdj0kYhepeim3dwLi2z+NkqHewiIcAWDfOMdozvUo0QaHPy+3E9KQF74SsKR2oudxxu71oaypn1VxR+EgrbHhWnM6Ai/Df3NqTEecARZj8g8v9TnKgt113yiGbi8+g5LIVbCDNRFCsVuq7RVbF8pS6cvbtcHaFrIv/Ek7U9ph4tJWr3zQluZmkEu/rXr78Nwf/+TYfnt8ISdiHxlMuSwDr0/OIrUxHn3jhIV5nxHoo88Rn2wU8/2WoYYfxyJ0BwFTcBCJpPbtfMVuMmGsApuL8a6oqgpdExNPgpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiO7jT8i9xyNAL6yaWeMXW8PdajOcq4mqlej3RvAGbg=;
 b=CSWieyh6JIVi2QBFlEQ5DDEi4LZpE04QupYm4JAS66ST7xDV28pzdg/X/82796vF4vIt+dzr7+tnm5BNGmdyUED/WfYEyiSrmrO0na4wEYCSrr1zk6o11j+RZ0MJuho+7GlPhpPuQc0h7VUoUq/d4yt707qkGe9GXeZU7HNs2NM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VI1PR10MB3645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 09:47:08 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fe53:f0e3:72f4:6c80]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fe53:f0e3:72f4:6c80%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 09:47:08 +0000
Message-ID: <8cc00e92-512a-f65e-ef4a-4ea859ee3e31@kontron.de>
Date:   Wed, 24 May 2023 11:47:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 2/5] spi: spi-imx: add support for SPI_MOSI_IDLE_LOW
 mode bit
Content-Language: en-US, de-DE
To:     Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     bstruempfel@ultratronik.de, andy.shevchenko@gmail.com,
        festevam@gmail.com, amit.kumar-mahapatra@amd.com,
        broonie@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230524091948.41779-1-boerge.struempfel@gmail.com>
 <20230524091948.41779-3-boerge.struempfel@gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20230524091948.41779-3-boerge.struempfel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::20) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|VI1PR10MB3645:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bac0e46-9548-458e-0af5-08db5c3bd722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +B6MFq1SQr9FH12wvdCuZRm3tQo33G/4nV3lsPt2AAT8NOMPu6enzEQjzWjhhj7/T5Uns8/Po9mT+4gKEBGaXTNlMbd7LAC0ZfbMt+cfyDXKsBX/WrWaevMP7HPKZfYSBY8e3dUAoK70IVlQ3zUzvXADDEbTqso23jt2HqeY+AjL0yPdtAV7fPcRRlQbSXhhE3qY4JjvJKZebJaafOJNazz4sTtNBQVppBTAxZ2mkvaYJ5yL3aZ8//bpsUsNQk9VvnNtSelLYnDJJv29Ez8rw8qa+UDBK1YE2PPuMQfv5NAFHuAxEIU2EV2EPVdFQ/pKDfVQgL3aoLRmZPZSSrKRK3Yq44FospiPEYgznNIp+HulUe53p2zvLe5e+lcfs18D8qwXkWRhGCfea7mMDSMDyJWUakpu3EmvjQ6WpgbcNTg7AthUYIcIUKl86jrbxDkC2AA3sJ1tFk6VJeb7ZHjMBkZFxH1wh+guNPsMKZRmQdwVbeVgQ3ZCG9CTV73St1bzF+DGbItNxPZeGrZZw3ry6MOd2mWoRxbVIPOrYzGCksJytdqGn1rySenUA2HeooeTfJNkPvLFKP8WCHnvqZztsgv6PDIN6ngLe4ZfdvvqtGwA6GvnO+mQeN7wVJ9b4c/F3SNKK/rDI5q9kyCmJD7VDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199021)(8936002)(8676002)(44832011)(5660300002)(7416002)(186003)(6512007)(6506007)(53546011)(2616005)(26005)(86362001)(31696002)(38100700002)(41300700001)(6666004)(6486002)(6916009)(966005)(66946007)(66556008)(66476007)(316002)(478600001)(4326008)(36756003)(54906003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmxPQzRFNUFJbzhmbTZua0JKaEhjWEhYeDB3dUZScmRETk5zYVdJam80Nm92?=
 =?utf-8?B?ZjZwLyt3eFZaZzljWDNqamdadzd5cXZOWTMvS0EwZDhFMWlQUkZSTnk0MThX?=
 =?utf-8?B?ZTFXblZ0dThObXBrV3NKTTB0aktqMUgwN3FFVFIyV0hwZmphb2luTGJibmcx?=
 =?utf-8?B?dHUxUkd0QjFuMXdCTFVhcmhsMjJ0TGZ4NGx6b0c5MTdCU0Njd0hQMFpDM1hE?=
 =?utf-8?B?SnhvSXBpejlNZWw5dzJURW0ySi9jUXlFcDdjQjhUbnlwZHNhMnVEZ0JCb21S?=
 =?utf-8?B?eHVmYklyV0ptT2o2THoza3VJWkN1TE5sRVdlam9RUUQ2SWNNVXNRZFY1NDcw?=
 =?utf-8?B?Z3QvS2JWUm1Ibk91ZnU2VFI3QS81ZmtUeWZuTitrZ2RmZkhRU0xqQ2h2ZDRG?=
 =?utf-8?B?dGxnaDlxMTZvTzNjQU9Ta3lOZy9iNmh6MWg5TkpJQlhkY2d5Qi9RbGZMTVN1?=
 =?utf-8?B?T2VjZVVVZ3k0a2dNbkZyZUdHRkoxaGF2amFDajUzOWZzdUZEVDloeGdQbU9P?=
 =?utf-8?B?WHRNYkFKTGFablRKdXNIT1l3VnBTaGoza0Q2b0p1d0hFZGFHS09TS01xazln?=
 =?utf-8?B?TkFIdmFlL3dXM0w4dlZMRk4yamJmbWowT0V2UmZmZkltblJUdnExWFpZSTE3?=
 =?utf-8?B?eHpvNlJETlA4OWg0YmpPOGFLdEJCVTZHYUd0VDIrV2JwYWtHMktOQ3l2cCtw?=
 =?utf-8?B?ek5SL2pHUmZubFpGb25kWUxGUEsyNlV0U214VFl3M0NGeC9UVkg5VGh1ODlo?=
 =?utf-8?B?c2JJdndsK0pZekptem55YXgvZGFRYklvdU9NYlNxQy81eC8wQlFkeFp6Nmdm?=
 =?utf-8?B?alI2TWg5cFo4aEVMUlZPZVNOelBENmcvdFlUNEZpUEZFS2tZaWNObXJ4SW44?=
 =?utf-8?B?dnh3ODgvZ1FqSDc5UGNlbzhkUFhVWDNtcXg2NGQ1ZE1aZE1LNVA3WDV4TUg5?=
 =?utf-8?B?RDVrdmZkUUxFc3ZJWmNpOEl3OUtkSFM3R1V0MGF1RUhaYXNBelhRSktFYzcz?=
 =?utf-8?B?SXlDS2NtL1F0RUxHMUJYTDcyYWJmVW85dEQ3b0ZWTWlTMDlyUjE3SnA1ZEFq?=
 =?utf-8?B?VXlTQklqTTN2bWZJU2NYWWxXR3V4L2tYWVFnVkdnN3UySTAzUnlkOGRGT3Jk?=
 =?utf-8?B?QVh2N3RHY1N0WDdtL25wNVlhTzFtTUFQazhVWVg1RzZzakczNEJwcVpWZ0w1?=
 =?utf-8?B?MUkySjlVbU05bnp0Wnoyd0hHdTdXTC9EUXI0d1hxamIySnVyV05QcTRmUmRj?=
 =?utf-8?B?NS9pb25sdVQ3VnB6WmZZR1NWM3VZdFlPUVVHbFR0azBhKzNzZGtGM25kaFlm?=
 =?utf-8?B?OWFmWnFOa21leWFyWGZwVVo0ZUpBYnpteXBROGl4SHZsODFYaXZoVnZIWDRx?=
 =?utf-8?B?cGZpRUlIbXVBZldIWW5yNHVTOFM5M3dobEhQblZQUFhDbVFFcFBGc0hKb1A5?=
 =?utf-8?B?ZXJ4S1Nod2hYVkFoK2VzN1hJN3daamxTN1VvNkNpRkwvaHV5RmlTVjVNdC9m?=
 =?utf-8?B?Z2s0VE5RK3dlb2pKUVp4dFNBZjk2N0FJWkxXTzBqMDZkaW04NW9hSmlZMnJV?=
 =?utf-8?B?c3NiY1dIekR4Zy90S3gxRkNBUCtiQ29nMDNsS3pBQkRqVVZtR3NjZG85Q2NW?=
 =?utf-8?B?SklTQjg2ZnJqTFNEb3cyVUduOXZjZGdETUE2Sy92dmo2Ni9VSUt6bkdmeGZP?=
 =?utf-8?B?YVlodUZDVndoR0ROWWo0UTIwK0VBVG9WMXlSeVQvS3lOaEUyaXZRSTNTaGJ4?=
 =?utf-8?B?amRENWVlRXBpbDBWM3RPWm9oZDJrSk9LQXpnUjZrbHkwSURRSE9SbngxVGgw?=
 =?utf-8?B?VlVWeTQzalp1TW10MXc3K2ZKcU80amdWMW5XcHYwRUxoZ09nc0RRYmlva1Fi?=
 =?utf-8?B?VkFXMGxraUI2bFAxV1hWYUI4a1QrL2lncVZsbkpsZkVVUGg1SStYTTFrek1E?=
 =?utf-8?B?RHEyMlRmdEVCdk1SZHFoYTRQN0E2a3FxYkZuU0ZZRVBmWm1tazJoeXk5NXcy?=
 =?utf-8?B?RmdWazZ0VVJwRlhRQlpmcEFBcnNmSXFYZlF6WlVBbmtHNThiK1BRZHpnNXRU?=
 =?utf-8?B?Q1VpWTBUR3ZvNUJpZTJIRGxnU3BOSGxLaWxhVFhSQU80MVZVem53Qm9PenRN?=
 =?utf-8?B?SFVXWjJvMXF3M3B5S0xROUttNnU4UllCMy9SeVpsWUZ3czhaSFNpNm5jYlBn?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bac0e46-9548-458e-0af5-08db5c3bd722
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 09:47:08.6771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IqhiOL7f/vtn3vTH5ovRtSGitcAfFY8NFtIkf0EI9mJtJzMvhAXsxUEy3rdAH4BCJRG5Kg6UAyIaI5UGgjpYGnIalJQf/k26jbdFJW+m6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3645
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.23 11:19, Boerge Struempfel wrote:
> By default, the spi-imx controller pulls the mosi line high, whenever it
> is idle. This behaviour can be inverted per CS by setting the
> corresponding DATA_CTL bit in the config register of the controller.
> 
> Also, since the controller mode-bits have to be touched anyways, the
> SPI_CPOL and SPI_CPHA are replaced by the combined SPI_MODE_X_MASK flag.
> 
> Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>

Thanks for working on this! We used a similar downstream patch for
driving NeoPixels with i.MX. I'm happy to see a proper upstream solution.

I also have this Python module [1] around for using spidev to drive the
LEDs. It would be nice to see support for SPI_MOSI_IDLE_LOW in py-spidev
[2] so we could use it there. Though the latter looks a bit like it is
not properly maintained anymore.

[1] https://github.com/fschrempf/py-neopixel-spidev
[2] https://github.com/doceme/py-spidev

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
