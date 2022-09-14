Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DB75B8E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiINRqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiINRqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:46:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70F45073C;
        Wed, 14 Sep 2022 10:46:17 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.23]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MYvPq-1olo7U1w2K-00UrpC; Wed, 14 Sep 2022 19:45:52 +0200
Message-ID: <50e8f1e8-806a-3599-7cbe-0c7d4bec1c51@i2se.com>
Date:   Wed, 14 Sep 2022 19:45:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/7] clk: bcm: rpi: Add a function to retrieve the
 maximum
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Emma Anholt <emma@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Dom Cobley <popcornmix@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220815-rpi-fix-4k-60-v1-0-c52bd642f7c6@cerno.tech>
 <20220815-rpi-fix-4k-60-v1-2-c52bd642f7c6@cerno.tech>
 <20220914155035.88E45C433C1@smtp.kernel.org>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220914155035.88E45C433C1@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NxmKp1sm3LkRo0gbQqolm+Ng3QYvTq0dE10k8LSTyFXI7uBvR9L
 s5hckFHebakOcs104ZCgvCrlEuj5OaMMMU8u91qxu8uzxCWhOMMTMgNT2pfVgqMCDU04tNv
 ETMcutviYd2PCqME3OrNDd36R08HkblW30gCreMY53J03iIVLxq0ijo+VmzN0cZj8yRCO40
 T14gwc7qvXjAc6/+hOENQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rG3TX5fH2yQ=:8p8gryIqThUfAmWQxp9+kE
 pKa4fgzl8w4DWbiVDsgkZxHhupxyqwRuqdz+RK6rF4hxFAnE7O6XFl5cvv12yM5PEez+B4lcv
 ZA9CfZ+0zoX3cV1y3vefN5TT7lDS87oYUd+61gPHxEThTLzoRsLntTjjffSxqJzIGozWLuHu8
 56uPS09N9Il5LnLtxZM51FirCbZxackYY7jU3JoBp+j9NuEAouI3Jgyt+HiENf8BRKSkNX9YU
 KlX92RDZnTEExYsoO1KhV7RTkQYbTJXzUQsARDJv55fak+LPFAsa4982pdWxDHzAu/0M/Cbgl
 LRZOczb5gKh/Cs8xS54ecj0jwZnzszQ2GkaCqfDba5PqhLhC3fcvqzG1JPqTo9uTTC9xPcW3n
 FXjE3GKicHiWUufpvqeqnsIhvnacxbHfHM8YNsSBTW9dOLN5iXc/WbCrHPtD70BKj+5JliOY/
 ZFbOwwd7pVIef2DzEzLpIFlrJZokgi1PJQtA5b/WGxcr78ioqiVu9fBDxKTt0b+K0aFZTPHBC
 wL2koBIsW+oZRIE75204Whm9H1y07++1zMdndLKkGaMl4OziLMZvrFh853THCl4/QnYuyKU4D
 U71C+JqX9Ba+y6nSZKw57WuQvKpJ0S/m5Mf9kL2rXyVDITfUwRz2DEQhjWRGTaQuCxiKN1n5V
 vcENMZWTUxkNUFWwyEYAnQY6jfDgwye7djPTxSQVJtuNCuxx5/UJE9S6cdLXW1atG5oNC5FLc
 ZKQ4817Bt0H4ZWSXMo3M2zpTRXb7ByAp10T8OjyUZuzDp2MG2s6HgFpYifmOCg6CcQqSkyPGE
 KJwLptFU2btO550BEZAs0+0/JI/lA==
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 14.09.22 um 17:50 schrieb Stephen Boyd:
> Quoting Maxime Ripard (2022-08-15 08:31:24)
>> @@ -254,6 +255,33 @@ static int raspberrypi_fw_dumb_determine_rate(struct clk_hw *hw,
>>          return 0;
>>   }
>>   
>> +unsigned long rpi_firmware_clk_get_max_rate(struct clk *clk)
>> +{
>> +       const struct raspberrypi_clk_data *data;
>> +       struct raspberrypi_clk *rpi;
>> +       struct clk_hw *hw;
>> +       u32 max_rate;
>> +       int ret;
>> +
>> +       if (!clk)
>> +               return 0;
>> +
>> +       hw =  __clk_get_hw(clk);
> Ideally we don't add more users of this API. I should document that :/
>
> It begs the question though, why do we need this API to take a 'struct
> clk'?  Can it simply hardcode the data->id value for the clk you care
> about and call rpi_firmware_property() directly (or some wrapper of it)?
>
> Furthermore, I wonder if even that part needs to be implemented.  Why
> not make a direct call to rpi_firmware_property() and get the max rate?
> All of that can live in the drm driver. Making it a generic API that
> takes a 'struct clk' means that it looks like any clk can be passed,
> when that isn't true. It would be better to restrict it to the one use
> case so that the scope of the problem doesn't grow. I understand that it
> duplicates a few lines of code, but that looks like a fair tradeoff vs.
> exposing an API that can be used for other clks in the future.
it would be nice to keep all the Rpi specific stuff out of the DRM 
driver, since there more users of it.
>
>> +       if (!hw)
>> +               return 0;
>> +
>> +       data = clk_hw_to_data(hw);
>> +       rpi = data->rpi;
>> +       ret = raspberrypi_clock_property(rpi->firmware, data,
>> +                                        RPI_FIRMWARE_GET_MAX_CLOCK_RATE,
>> +                                        &max_rate);
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
