Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6787565F6E5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbjAEWgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjAEWgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:36:42 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3C711A1A;
        Thu,  5 Jan 2023 14:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672958194; bh=ukn1auDFnOTAdSQTXWGrQhun8HPJ+zFOlPpBVDKojko=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=U/s+uDCPsN1kxGle/rgyWmXFbonaWRppg9EmbzH23oUy2fSxDLGMNEDPYRxv3tr3q
         T3GNM0gykKURTMG4t+/uXWRVuE10oXRyL0IPb5f1bIMEepihBqAtToO5avWf7OhhNy
         JsKJLjbOL9/ETCpkwM/Mz8OKOWaIeKZCUY8bP0eehnGlKYBUcj++NQAr6xae5K1PUx
         S3kCtQl6EeMlO569VrQVyaP1ZG19ul8sGHc8/U2iXJ6wG6n1BNHbvgLDg5Fpc+xPkZ
         enF6uQmEZBQGloRumfI3nZXqR6irxHqzdfhv5jhDtiz6dToJjfCP5QuT4uWrVNbZPp
         OIyT6AV8mLXpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Jn-1oZoFH1cX3-00e6qY; Thu, 05
 Jan 2023 23:36:34 +0100
Subject: Re: [PATCH 0/3] Convert to *_with_info() API
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230105141911.8040-1-W_Armin@gmx.de>
 <20230105145757.GB2405273@roeck-us.net>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <e1d2e82f-05d2-bb8b-b6ab-b7d1d0657a12@gmx.de>
Date:   Thu, 5 Jan 2023 23:36:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20230105145757.GB2405273@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:FlX/MIehNNE9xSDavkPRA9NxxuTOmPEZ14sqr3v6rS7Gg5byw8v
 cwCfLwGLpJ5sjtdqbVO9jbAbCQa3QMPOBEn+2ylGes5O3C97ry5/BQOmeicMzKxU7hkBQ8G
 IaDu0T0MYrwRpfMlllVoAiVvzLL1CbitnugFKmWPWhmLpLn12pH5UEsdop/BFfzKuePUFqB
 P4/mDqUF36jouTU2lMJMA==
UI-OutboundReport: notjunk:1;M01:P0:4VfXxxxxw34=;GoeJmzR7BB8k59++t4oIVa9bsYe
 dWKZv5otulxPTePF5P6jgokBjRTf1EApVp+z/HaRJ38AXn18CJ4EoMOCzwkJbqjOvf8pey/8o
 Pd+hlThNGDJSshVd1UNnjJjGoGQ0Gaj8z1dFcSuoIas1+/feMmFUsp73wcFogapg6/mFjCh8F
 /NjSb/mGgrsGiPwPIFFpXq96P+K1qwH6oAjYk4zQ23+c6Bow/SVIIZBAu5ktjflJTLpemOb74
 VExxP9dHUJotUxI/+TfFV/08FktFlM8jdcQhoRhtJqESqhtsubtkf1dK8ec0VAY8F7FpN77Mp
 zV8pzmuVLVMgYydH8EvoBt8aTBsICFJKwNaFw+/NN8nXftTE5ppS46HGAj4tW1d2hzD1iqUxu
 NFJxnDkheeC35dfMGBRW95dlflXu9NFr+01PT/arJW3bAP/xh1fOHQ3mT3cKWb3JmXXADRque
 WEqdl85C94zzpnyHy9e0nS+t9+P4QNQc27ochd3QuL0N9i/vv2D2TKXXx3Whi/zohIVCPsGeH
 HEKq82SCPwihWBWhBjYT+2hI2OmmOb4FRyHVa5Ub9fCYe7Ol6Ip0Red/FhK8gru2siMJ1lcw1
 9ZvHAHU56E3spElDmZ0j5DZzdbc3o1ezlCgRY6hHZ3MiqXB2DzpC2SwpW9kNgtzv2nxGSGea5
 9HEJ6BPYg5rvCO7kp84mZjgVr/c56O2sBI515c5XgtQDFc7d1hF03zG55r6i572T57rhIFLmw
 9gEPoaSTix3qBUMZIgbqrsAVmZATixIdyiTpPhmI66SCasJodL0lzLfhgGZLp+oMOEK/LN2Vh
 8C7Lsr0mr4yNdzqRajPjfCMzZxMAFTNFGZOkZoId7AcP7+zk1nRNHATcs+Ngj9v9Jh2/qTRSl
 PnobWLEwM607f+4jN27BTWawLH8n2rKdXWOwIWgMz7IJM6oOVa/WRRZNq80Cv5Un67jc/vcWu
 siRLxfkxt8GS1k/Ah9rt7X0btxQ=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.01.23 um 15:57 schrieb Guenter Roeck:

> On Thu, Jan 05, 2023 at 03:19:08PM +0100, Armin Wolf wrote:
>> This patch series converts the ftsteutates driver to the *_with_info()
>> API, reducing module size by ~30%.
>> The first patch does the actual conversion, while the second patch deals
>> with the nonstandard fanX_source attributes, which are being replaced
>> with the standard pwmX_auto_channels_temp attributes. The last patch
>> adds support for fanX_fault attributes.
>>
>> All patches where tested on a Fujitsu DS3401-B1.
>>
> This is the second time in less than two weeks that I get a follow-up
> version of a patch series, unversioned and without change log.
>
> That makes me wonder - is that just coincidence or is someone promoting
> that ?
>
> Guenter

My fault, i thought that with all other patches of the previous series being merged
and the single remaining patch being significantly changed, it would be more appropriate
to create a new series.

I will send the patches as a follow-up series of the previous patch series then.

Armin Wolf

>> Armin Wolf (3):
>>    hwmon: (ftsteutates) Convert to devm_hwmon_device_register_with_info()
>>    hwmon: (ftsteutates) Replace fanX_source with pwmX_auto_channels_temp
>>    hwmon: (ftsteutates) Add support for fanX_fault attributes
>>
>>   Documentation/hwmon/ftsteutates.rst |   5 +
>>   drivers/hwmon/ftsteutates.c         | 550 +++++++++++-----------------
>>   2 files changed, 210 insertions(+), 345 deletions(-)
>>
>> --
>> 2.30.2
>>
