Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D678667764C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjAWIae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjAWIad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:30:33 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 00:30:29 PST
Received: from smtpcmd11117.aruba.it (smtpcmd11117.aruba.it [62.149.156.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599C2166E5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:30:29 -0800 (PST)
Received: from [172.16.17.150] ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id JsCfp894mYFVnJsCipUjUN; Mon, 23 Jan 2023 09:29:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1674462566; bh=xlyxRs91fHlvhk25Z/68AHZ54GgijSKXrCndtXQ3UbE=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=ceoe9QPCWhamOYURZHEO+e+I3ggriWJQOZc8fGmMnGoVi4ck8iS4fE4FZO7yItu4g
         cTd70F7JMrRb7SCSceEpYpzNnn+lZDNU9q7BBTna8P5u+jLDXcohEHPKtIBeZsfmz5
         BfTGUqHCYE8yz2+2quzEPaBTuE8mKKDvP1l9YxvyQGjUEpvB0TkG+pWrEdofXnTZhf
         G/K2jE5E3ChArODvoo6xnLjBoFwkNYoaazXQv2ac6Tfv4qV70nzOg5ZifEgUhw/JqD
         0SDk4CRBI2DiqPImjz1Vf8HQizI88CfTAHTTwUCdR/YahB140+pTpfLe41Wtr2672A
         Vs+xZH3P8P6FA==
Message-ID: <74c917ce-a67c-7b4a-023b-2f2f4fb365b5@brickedbrain.com>
Date:   Mon, 23 Jan 2023 09:27:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] Input: ads7846 - don't report pressure for ads7845
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luca Ellero <l.ellero@asem.it>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230120124544.5993-1-l.ellero@asem.it>
 <20230120124544.5993-2-l.ellero@asem.it>
 <Y8qwQM2zLbboTeth@smile.fi.intel.com>
Content-Language: en-GB
From:   Luca Ellero <luca.ellero@brickedbrain.com>
In-Reply-To: <Y8qwQM2zLbboTeth@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGPXj3m9bIXrKwAe/xERyDyaqs2d45ItinerVE866Da41LDsJoVcq2eO4TM0mmbBdqvSGiWbDY3z+0NTu1GJQhy5T0C/2c5bRiUkutNb/hrebP2I016p
 EaiFchE/z+EL/gQMbr4MrabSmf4PfK+auRAHnTLJ7QpXYknHryhNAX0UYKFe8732iswU/LSJIH+GykCYe0FY1CX7gTdddQuD6iLEuyjLlcS/CvaCaqu0VbS1
 vmHLCOZ76yKrRfXAV4r3xsXlsx0uUjW9UVUR4/qjaKhB0kIe7P+tqaLF6+anqQukI12Jo3VjdTer8KI+IDpaO85eOQBBVhz+HnEtuUM1oj2nqavutHxa8Fgz
 gUNt0fsi84l5dkd3H/zEtQKs7cre8asDiJsf9iB0vpyJe4KfOpbAxb0tj+XTGvPfIUrBKBoVT676hG4LARcO9v5jrMrzsCeLd8jiixaebC60oJxSpMtwIi8z
 /G5S3PQBmb3JEQzJadJb0bOIec4tewpm6GTwOxeru2Njui+iqZOCbIS1RKVaIaWEnoG4ajuNC3ZYi8qAx7DT9ob9fnzKu9e/3vJIDCP4JznWYhVPKIo41lh7
 JlQ=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 16:16, Andy Shevchenko wrote:
> On Fri, Jan 20, 2023 at 01:45:42PM +0100, Luca Ellero wrote:
>> ADS7845 doesn't support pressure.
>> This patch avoids the following error reported by libinput-list-devices:
> 
> s/This patch avoids/Avoid/
> 
> (This rule is written in Submitting Patches documentation.)
> 
>> "ADS7845 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE".
> 
> Do you need a Fixes tag?
> 

Hi Andy,
thank you for your reply.
I haven't found a specific bug report to apply to this patches.
Could you kindly provide a "Fixes:" tag that I can apply?

It's more like this driver has never been tested with ADS7845.
Maybe the patches should be considered as a new implementation instead 
than a bug fix?


Thanks
Regards
Luca Ellero




-- 
Luca Ellero

E-mail: luca.ellero@brickedbrain.com
Internet: www.brickedbrain.com


