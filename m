Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21F563CE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbiK3Dzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiK3Dzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:55:39 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A87169DC3;
        Tue, 29 Nov 2022 19:55:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBW1M9DxxqINHRWB/RVIcGnDR2WM3EJLthsOlrEvfTf6dvlFHHGW6uihJ51XCBeva6fwpUjB/pzPo+ch/JkppLYO4sy4PJ2oz/m2BKvCLzVnrH5d3Uz+PcNw3q+AovopqF3gvHN/o2e4oxlYmLK0CyX+nEfqrU2ErtDsKtZ8rKG1iSeFOL7hxboVIkYKLJNj8M3hzkRRrcXRjl+mNx89OFMHxDqnYO2qldkjPlHgGZlC2Rqs0cHgIbPlTIfhDTKPxh38L0V6QYHqUxQFseHPmGVMp2ugTDlhC1rP6baD9BxyAcqDTcdfsmej/bGJelyl1PRjpicJkBukAqdXnhXPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lf6QM+YZx9kSUULNN71o+yS5dydeyo4u5DGKtIASz9w=;
 b=CAuEBa6dkisB3zmejAIUVyejruDgdTjMbyzDmrTHgYBvpR7IVFfokF4QzJ+RcJqRHT6YjF3huG3GE/eXjvbANuMGUJGD6guZDxxST7DRsX5PuRyjvk+8eh3flohiJO9/zWF2G0ZNpPEKzzuxCuJzHmldci3L/6KS3phlxpf6WIIoUWMmFp5JXTnsF624QZItcP6hn29U6x0DCPGxwBwJAtliEb+UzEcfpztRyyr0OqqW3ThI05+Gimgl1o1HYYi3Jt27VyS0HTMZAVxF2Y1teU5e1wZ5iTIqnSgTsllRNe6D4/Jk4srZiorVUWkEYEVu9mFBJgQOO7hG94q48DqAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lf6QM+YZx9kSUULNN71o+yS5dydeyo4u5DGKtIASz9w=;
 b=LiqrIxAjwKqQbHcr5LHgF+JhoDBR0izfbimRuu58I8+ET/2Vdt5NrFWcsXvPsx9t7i7brFGiN5de5MOsq3oo3IWGz/Sy64OirdqRJkz5yhRoqkFmSj1olPN/tr665XI1IEAYCZyJCK3jJbkxSg0GOkYLJ1j8vctTFCqDmz0dvsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10)
 by AM9PR04MB7650.eurprd04.prod.outlook.com (2603:10a6:20b:281::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Wed, 30 Nov
 2022 03:55:35 +0000
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::3222:ed58:9b36:beee]) by AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::3222:ed58:9b36:beee%4]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 03:55:35 +0000
Message-ID: <cbe2baaf-5529-a9c8-b1d1-b22ef294a1e7@nxp.com>
Date:   Wed, 30 Nov 2022 09:25:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [EXT] Re: [PATCH v5 2/2] misc: nxp-sr1xx: UWB driver support for
 sr1xx series chip
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Rob Herring <robh+dt@kernel.org>
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        "Michael S. Tsirkin" <mst@redhat.com>, javier@javigon.com,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Jason Wang <jasowang@redhat.com>, sunilmut@microsoft.com,
        bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, ashish.deshpande@nxp.com,
        rvmanjumce@gmail.com
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
 <0b2da6f2-62f8-41a3-bf07-b6895a2dedee@www.fastmail.com>
 <cd397721-f549-5c65-2c65-35b09c3ea7f9@nxp.com>
 <ab5721fb-bb58-47f7-863f-a6c0ba3c5280@app.fastmail.com>
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
In-Reply-To: <ab5721fb-bb58-47f7-863f-a6c0ba3c5280@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To AM6PR04MB6407.eurprd04.prod.outlook.com
 (2603:10a6:20b:d9::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6407:EE_|AM9PR04MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 72245ffa-e021-4e2a-a912-08dad286bc67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rZ/E4lFkS7jPq9L308Ri+agdjDa3LyCI8N2GaeQHt0oiK0MSNlFK3jHG6bCNQ+hr2c3NIwykn8d8uCbVFR/gTFLNt1D0yOTWQgSgyfd+IF+O+mHewDRC8+PAfOsTjOsNtCDNQbVo0LZSLiBA/0kFX3ZOhyWwbaB1RmPQGlcjnScqNhsg59Q1v+HHj+fU/3wKpwAMs9uh88Ncl2nZaEPlbsu4DeT9mOb99DEl6lpa8COW9YfW/rC7d5hojK3Geyl6RBzsxK/CJ+/PX09Fc1t9Ooogy9ipnlOKtfN63dZueSa+PzwwCCM5p/0CGPe1Z8uc2s0i1TCIF/O0fMzzFyK/jTSRD3zm3J21J6S6/+UCYxg19xJbEZsEuNj7wm/F9JVnwNrJT1SPI3Sb1PT51mUUJI/Fa7FjD6AjnUq8/iIPG3jjWrkF2qlMs2rMAl3JkvrCA3EwUhiZ7gOnhxiGblY/KN0GciJEzH0mSQxxHTBDcpdn+A2mW1h4QJk4qRzSl9lYStXUIiAYT4wj/OkkQnmOPNyIPeDvlk4iT9ucND6nwInRWCt2eVt9IippHztFFbPtla0HHB9qbe6k7XAMlTihEV6c4eDMhtVixAX1y08UPW4eeQSYpwQmpArtpndH0b4q9S+HOMeLY/GqU5n+eD53vHgakvpjOaoSovpTYKwNVVODG1RZaDLPwp2GpsBf+C+vOj/7V18J6H0fY1Nj1ycVcRtu/wCP4uO3GA8u+JNGCgVNdnzwGqAoSvQoXcfhh0vcSF8DaizXaPOGfMIoXuOC/UJoIBS3cCnXr2sfUE2Cd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199015)(6486002)(186003)(7416002)(41300700001)(31686004)(478600001)(2616005)(54906003)(52116002)(110136005)(38100700002)(6512007)(6506007)(38350700002)(6666004)(26005)(316002)(55236004)(86362001)(66476007)(31696002)(66556008)(8676002)(4326008)(66946007)(8936002)(5660300002)(53546011)(36756003)(83380400001)(44832011)(2906002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THVkSFlQaERuQ1dCN2treFVZbENzVllsZjFXQWFESE9raktZSE1odGVzTmFT?=
 =?utf-8?B?bDBLZEp2b21VZk9NNEx1RytKT3RSN1IxbnFSSC9vd0RlWkk1WVJ0Z0FxTFlv?=
 =?utf-8?B?SVZhL2ZxTW5CcGdVWkZ0VjFWYTdwclY2TmE0dkZQdW5CeTNTTmdXZzhCOGxP?=
 =?utf-8?B?Y01vb2w0ZUt1ZDQwYnJvWUkxRzRGdm41TldZeEt6UWxkSGh1bzYzWDBzQTZ0?=
 =?utf-8?B?OGE0WFlOWGpPUWRSeXVPNlFIN0hIZFhFSE9rME5Bc1A1QVFFNGRZREZabUNv?=
 =?utf-8?B?b2pBUHpoMk84RE5HQWZwWWhSaDloVGJiVDZtRkdNWUZxckVDMjRLMzRhQmE5?=
 =?utf-8?B?d0hJREdodHlTSnVuMDZGT3dXL0NvdjZXak1HeWJKSmJwc0ErSGhMeCs5K0FQ?=
 =?utf-8?B?V0lrWWYvSjIwcGxydFlyeGl5b0dSMmdPS0YyZ3hWZzdrNGw4UHk4V25RNThZ?=
 =?utf-8?B?T2tyaXFGZHJ0QXpqVUZtWjZVSVM0QXZzbW0yUTRSY3VuSFlQdFB2bmp0YW16?=
 =?utf-8?B?SkJOcWNJS1B5RlFBeDIrYlBWNFFxMkdtRXMzbkxTTGVLN1RZdm1QZzZKNTNs?=
 =?utf-8?B?cktscXdhOW5XcFZPSWtqcWNIVW04aTFDdE4va3NQczRkMEhoSzZON2NJaUE4?=
 =?utf-8?B?NUJ1YmhINmVTNzBDQWRmTXJQOXRjMlQ5MUphbmdQUFlFdzN1NVhFOG1UMC9J?=
 =?utf-8?B?ZHBvRFZWOStSVlFmelNBeDdEcTRDZlJ3dm95eVkzMGNkMTFjWlZWSFM0TGRQ?=
 =?utf-8?B?eGhmVzZmaUNhQ2V5NHUzYTJmN2JkNk5EUHBhaHB4cUhMbjIwWjVYaFEydi8z?=
 =?utf-8?B?MkF4Z0dzL1VZS2VJazlpd0pKR1R3NVFkcUEvbGVURmZLbzVzMnhWNERkdkpn?=
 =?utf-8?B?a2g2aDlLTU1KSHdvNnhxemlpYjdqbjNGaWE0ZWtrd0E0bkdqakVIcm4rdWxX?=
 =?utf-8?B?ckVZcUNaN2E3NmRJdWdUMld1enpMZU55V0dja1V3c3JlY29aV3lNcU10c3JZ?=
 =?utf-8?B?Ny9IanRreS9MUzV5dTEyNTJ1ZjVYV0x2K3V4ck10aTVKVlA1Z2pPRkpYNklt?=
 =?utf-8?B?K2w1Z29IdGpuYXcxbUdDcERjaUVHc3B5bTFMMDZINk90a2xXSmE1TDlISlM0?=
 =?utf-8?B?M3NQZGhhUE1xVkFadWhUb3hOdkFWQS9LMkdmQ0xJRGUvcHpjUVFCYkNPM1Rm?=
 =?utf-8?B?WGxxZmcvZ3dMVlByOGVtd1JCaDM0eWIydkZrZS9sZzF1ZEhoNy96Vk9Qam54?=
 =?utf-8?B?KzJKdFMvbTk5eDBvcG1YV2N4dHA4Y2FGcU5RRVdCS05jVm8rMkhvL2srWUZM?=
 =?utf-8?B?TlZ0VDFEZzAwM3FWeXhjYXJUWS9QYkV1WDNjRWk1TlJVdXlVTkZwWEFuYVUy?=
 =?utf-8?B?bzcwZFhNODZkc3Y2RzM4ckNTUU42Z0VuMno1d3IvWktqdm5kd0R1WWJXT08r?=
 =?utf-8?B?MWZTL1YvTi91dENEVjdOOS9mT1RzbnBjeWJ2TWkvTXQ4R0lUMnM5c05CY0FP?=
 =?utf-8?B?R2M5VVM2Zi8zN2lMZ0dpUGVFSG45WDJwcVgyR1NBM2FBNm1aSzZzZVpOYnp5?=
 =?utf-8?B?Si9JQzhaNzVpKzZ0NUU3Ujg0SWRObUp5eTVrUHZBKzNZbGxjR1k3SGRpSFE2?=
 =?utf-8?B?QnNkdUtxMlRjVGVBanNwSUtlazNFZ1JlbTlFSUJ0R1Q2SG9nL051V093MUow?=
 =?utf-8?B?QWltYWlwRitEcEdoSGtSSS8yeFhvVlBVMXpBQmhsWXZFWG5BYWpZVGhROFlq?=
 =?utf-8?B?ZmZNU01GWlJGTmVYWnFXNjE4NGZOZGJ2c2ZLclUzenRVZWJqTkhZQkVuUnFp?=
 =?utf-8?B?SGNNWTNlME8wYVlvRFI4bE90Vnk2ekFFRDMwNUN4VzZCOU9uNnNlUG5PUnRK?=
 =?utf-8?B?N09OR3EvNWNNMnVIdzRnRzRBZWF0K2hFSC91WVQyTG5SbzNpVVp2UG9hbXpi?=
 =?utf-8?B?aHVPT0Zxb25NTjB1cEkrMzJWR1FGMnYzM0F0Z1l4aElyVWVlTnFpeXcwTGtU?=
 =?utf-8?B?UVQ5Q0M1TFZtRkVJZ09RZFl1dEVCOUs0SVJvMW95bGdJcFN6UThxaHByZHpG?=
 =?utf-8?B?Z2FERXpsc05vT2FybXg5M3hPS2FoZDFZdnBmNGh0aldVcE1xY0pyUHZzRXBU?=
 =?utf-8?B?VFNCVDhheVJEY2dYL21vSko4STJsaS8wTktvQ1pQNjNkTmNra2hIZXpUM2xa?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72245ffa-e021-4e2a-a912-08dad286bc67
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 03:55:35.7675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oQdk/SmfR/X0XI9VNjz1pmpbm7G8ZPhCOWktG/KFzF2463DcrhN1pWJI/QBUfgM8rChqIZ3CHqsnVlJnyHz37i8GVAIw+W6A8I68jMP0h8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7650
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/7/2022 7:41 PM, Arnd Bergmann wrote:
> Caution: EXT Email
>
> On Fri, Oct 7, 2022, at 4:04 PM, Manjunatha Venkatesh wrote:
>> sr1xx_dev_open(struct inode *inode, struct file *filp)
>>>> +{
>>>> +     struct sr1xx_dev *sr1xx_dev =
>>>> +         container_of(filp->private_data, struct sr1xx_dev, sr1xx_device);
>>>> +
>>>> +     filp->private_data = sr1xx_dev;
>>> This looks dangerous if the file gets opened more than once
>>> and filp->private_data can have two different values.
>> Do you suggest us to use mutex lock inside open api?
>
>>>> +
>>>> +     sr1xx_dev->spi = spi;
>>>> +     sr1xx_dev->sr1xx_device.minor = MISC_DYNAMIC_MINOR;
>>>> +     sr1xx_dev->sr1xx_device.name = "sr1xx";
>>>> +     sr1xx_dev->sr1xx_device.fops = &sr1xx_dev_fops;
>>>> +     sr1xx_dev->sr1xx_device.parent = &spi->dev;
>>>> +     sr1xx_dev->irq_gpio = desc_to_gpio(platform_data.gpiod_irq);
>>>> +     sr1xx_dev->ce_gpio = desc_to_gpio(platform_data.gpiod_ce);
>>>> +     sr1xx_dev->spi_handshake_gpio =
>>>> +         desc_to_gpio(platform_data.gpiod_spi_handshake);
>>> The temporary 'platform_data' structure seems useless here,
>>> just fold its members into the sr1xx_dev structure itself.
>>> No need to store both a gpio descriptor and a number, you
>>> can simplify this to always use the descriptor.
>> Just to keep separate function(sr1xx_hw_setup) for better readability
>> we have added intermediate platform_data structure.
> I'm fairly sure it adds nothing to readability if every reader has
> to wonder about why you have a platform_data structure here when
> the device was never used without devicetree.
Will fix this in the next patch submission.
>>>> +     sr1xx_dev->tx_buffer = kzalloc(SR1XX_TXBUF_SIZE, GFP_KERNEL);
>>>> +     sr1xx_dev->rx_buffer = kzalloc(SR1XX_RXBUF_SIZE, GFP_KERNEL);
>>>> +     if (!sr1xx_dev->tx_buffer) {
>>>> +             ret = -ENOMEM;
>>>> +             goto err_exit;
>>>> +     }
>>>> +     if (!sr1xx_dev->rx_buffer) {
>>>> +             ret = -ENOMEM;
>>>> +             goto err_exit;
>>>> +     }
>>>> +
>>>> +     sr1xx_dev->spi->irq = gpio_to_irq(sr1xx_dev->irq_gpio);
>>>> +     if (sr1xx_dev->spi->irq < 0) {
>>>> +             dev_err(&spi->dev, "gpio_to_irq request failed gpio = 0x%x\n",
>>>> +                     sr1xx_dev->irq_gpio);
>>>> +             goto err_exit;
>>>> +     }
>>> Instead of gpio_to_irq(), the DT binding should probably
>>> list the interrupt directly using the "interrupts" property
>>> pointing to the gpio controller. Since, we are configured this as generic GPIO in DT binding. So, we
>> are using gpio_to_irq() to use as IRQ pin.
> I meant you should change the binding first, and then adapt the
> code to match. Remove all references to gpio numbers from
> the code.
Will work on this suggestion and update in the next patch submission.
>      Arnd
