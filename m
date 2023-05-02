Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC376F45F3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbjEBOV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbjEBOV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:21:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8270AE9;
        Tue,  2 May 2023 07:21:56 -0700 (PDT)
Received: from [192.168.1.131] ([89.1.213.9]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MFshF-1q1pl938Xv-00HMw8; Tue, 02 May 2023 16:21:36 +0200
Message-ID: <d25cb52e-568c-637e-2708-e5d5d8b43b73@mweigand.net>
Date:   Tue, 2 May 2023 16:21:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 6/6] Input: cyttsp5 - implement proper sleep and wakeup
 procedures
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
References: <20230501113010.891786-1-mweigand@mweigand.net>
 <20230501113010.891786-7-mweigand@mweigand.net> <ZFBXvz17jDhEPI6c@google.com>
From:   Maximilian Weigand <mweigand@mweigand.net>
In-Reply-To: <ZFBXvz17jDhEPI6c@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:k4ULv17YXMKTOkv6rlSNa1PjfF/ZPiL5SEta1j2EQ9eWxP9Ayvk
 ZbeeVxNbJaaeatLJDIHAoDPUzZFRarKWFCvF8xBYgrdVzut5xoZqj2P836URrnb/6Pjb31y
 NqEoBIMTdgJayqqLqBhOszUafQXY7gN6gqrKo6CLXzhSmiTUfbVUlNgsuFcJX2tFEeYJt5x
 +BqFgU8671+OTk0vCutZw==
UI-OutboundReport: notjunk:1;M01:P0:7h04iMSCeOE=;3W+iz5QPr9D5XEnfuIce8D5mr4l
 OW9KIWFyf+vQRozEthO6X6GHsHDDFJ0kfgWFaVelTth1DYBIk9FmEneVwVA4AXtp7H9OrIFOi
 r6568X7M8UvkR0rWK7HJJ7TesGdcbx2qgcmHL3wrUIdWExCsMn+FZcQCswn0J1g7e9y8Xa7Zv
 nUTQFYUqkCEqStFhH8jL/9fUewdpAg+gWAbPp1rP6M1Aaooel/cY+E11VyosC94Fq4QASp170
 eWkmvmmxG1W8UZo5e3ZsSTQVdsoXmmnEztP4GeQrE3SbqqWJdo/XQgfPDHZMvKcYLWMq8+Zxl
 M2XUPEs1TJvRER1ruDqbznTyTUblS7/3h+dX8V1Uv568nDoh1GISk+LUnEo9PU2SkG41tTSta
 ecYGH0WoIJNySUsrxb1Lvi53Sh1N2g7SyR2y7URQtqAjkjC8tidVhGjvii5jagKft/+obZAsr
 vC5bfGsuTZ71ugobcRtpa3G+e1juzhjIQWOU17SxLtwdnzukk4iOgg2QhcM1kUzmM+ILNUss5
 y3gkHA5J8nwMrHZ/o/KQUOPi7+XPvYk+jXle871MSikIptZ1SASu5EqYK4lnBfB6pREl2nMf7
 052WmXxCh6i3SFIjuC3DJCUEc09AE0tk7X9vwF8uE7ih6HopTboQs9Ca/qgmvmdTnacQDuNQj
 8jkC6XfyVwkEVRICA1N7kyhca5bLbeDjW+KrXwLF1Q==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02.05.23 02:22, Dmitry Torokhov wrote:
> On Mon, May 01, 2023 at 01:30:10PM +0200, Maximilian Weigand wrote:
>>  struct cyttsp5 {
>>  	struct device *dev;
>>  	struct completion cmd_done;
>> +	struct completion cmd_command_done;
> 
> Why do we need separate comletion? Do you observe some additional
> traffic from the controller when powering it off and on?

I checked and indeed there is no overlap in the different command types,
so one completion will work. I will reformat correspondingly.

>> +static int __maybe_unused cyttsp5_suspend(struct device *dev)
>> +{
>> +	struct cyttsp5 *ts = dev_get_drvdata(dev);
>> +
>> +	if (!ts->is_wakeup_source)
> 
> I believe the idiomatic way to check this is to call
> device_may_wakeup().

Thanks for pointing that out. I will fix that, too.

Thanks for the feedback and best regards

Maximilian
