Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BD36CC263
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjC1Oot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjC1Ooo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:44:44 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFD3D516;
        Tue, 28 Mar 2023 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=FkMbx78PMGGSWqEHv/xUPl1O7G/9oMV+PSDaOK7Uc9I=; b=Tv59EcaAY8f/VnS+Gkja/ofEtr
        r/DCX9G7feP6LIMUVBquq0bbJC5uoS12UPQrm6NkZZZenMA78ghWx2vElob7Rz/3HVtvT+Wp51b8J
        7TeOK+/GRmttuechxEzeksosFT9+7pjbqhAMZ4Dw1Fifz2XTQjCQGAteCZmIFPm3jWkx7vPsIgxKQ
        riaNOmTlR0ItgiKIx2IW4+R/GGFLMEUk7BUKXtf/YDVaKY6f6M1ND40dkFXgefF0lKDQspuom6X30
        JP3CGIySDgRNRPi61xf51ag1mkdlSwev67QUR3RNsfBI+NQN3MhG+QzFlQF59N2DyUjPnBsy0oKsn
        zCkz0bIw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1phAYq-0006ez-LR; Tue, 28 Mar 2023 16:44:32 +0200
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1phAYp-0009lf-MV; Tue, 28 Mar 2023 16:44:31 +0200
Message-ID: <17956263-2a2b-28dc-bc70-d891850f59dc@metafoo.de>
Date:   Tue, 28 Mar 2023 07:44:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <noname.nuno@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "Sahin, Okan" <Okan.Sahin@analog.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com> <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <ZCLi6MB/aHIf4lMr@smile.fi.intel.com>
 <cdd53e29ca3d8dbfdfa1a2520935e2bf9418313d.camel@gmail.com>
 <d2bed74b-9eb9-45af-8f45-ad2c2889024a@sirena.org.uk>
 <fc07de9af0b691fbd3a5915c8293f0c7ad4c4e06.camel@gmail.com>
 <ZCL7J5a7UZVayQVS@smile.fi.intel.com>
Content-Language: en-US
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <ZCL7J5a7UZVayQVS@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26857/Tue Mar 28 09:23:39 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 07:35, Andy Shevchenko wrote:
> On Tue, Mar 28, 2023 at 04:18:30PM +0200, Nuno Sá wrote:
>> On Tue, 2023-03-28 at 14:46 +0100, Mark Brown wrote:
>>> On Tue, Mar 28, 2023 at 03:26:44PM +0200, Nuno Sá wrote:
>>>
>>>> IIRC, regmap_read() is not really reentrant and it is used in the
>>>> IIO
>>>> driver on the sysfs interface. So, yeah, I think you need the
>>>> regmap
>>>> lock and better just leave the config as is. Yes, the lock is opt-
>>>> out
>>>> so let's not disable it :)
>>> All the regmap operations are fully thread safe.
>> Even if 'config->disable_locking' is set? I think that is what's being
>> discussed in here...
> In case the driver has its own lock to serialize IO how on earth the regmap
> lock is needed.
But the driver does not have its own lock.
