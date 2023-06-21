Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6487390A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjFUUUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFUUUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:20:14 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1AE1994;
        Wed, 21 Jun 2023 13:20:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-977e0fbd742so839822566b.2;
        Wed, 21 Jun 2023 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687378811; x=1689970811;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PPriLeqoIUC4+DYyJRF0S9LrISjaNy3IoPoIqRrfYQA=;
        b=CvyMhe3ec2CrQDY/3+HxoKU06H/PTx4lkd6eIscljVINGZbhH812nw2wqMHG2BjgZi
         XcjuGuSm79nAkQEO7+WVcQi3zTrzr3/PvaNBXMYxf5rk2x6LxUrK9E4QkuYp5/v4gLuL
         xTMWZyeMzgLN8xkh7VjWsNBZx8fJRthECBN5uNNKkBx7UvlqQFS/JutPAGERPoSz2sxJ
         7PlsMD7IzPniNISjyd1cQOfNleIJCxJu27F2EI0seg2XvWHZzp5BTCoVJcmAXAh0xSx7
         l311nJ6oQBe03ndfDUSrj4x07bdooM+Xzv0kJtikGOA2Plmk6Gb4damz/sY8aSuDsTvI
         QGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687378811; x=1689970811;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPriLeqoIUC4+DYyJRF0S9LrISjaNy3IoPoIqRrfYQA=;
        b=GgMXp6PH1dULFgFcQaqWbd7WNCfkn3mutGjJ95J3iz2pLznVJLPWV2AzkCv859czEo
         cXydIQMtU7dBzcQUg6Pvhr1clvaIrT5Q6JP2Ynj6ihvMaBGj5AdcLQFySTYgYgsoaeSO
         vRszzbt42ooEX0Zj0SlehFK0j2OEmNqaDWFzYMQgvBn/gd40IwbhUaX+lBAnVJE2P7lq
         +H9RGdRPArmYn3cKy98gnQ0jQtqDwsp3Y+AU5EyMK2552d1vBoJVM9ZsrMMcduk+ap1b
         G7h33xfF458uGfsB0qYJAG0sowm5OJD6zNNxTj64OaVVQ0/uqyh/oqUqJmLpoP1KUt5d
         TmtA==
X-Gm-Message-State: AC+VfDwVldEa2gJ3szBFMmXGaDyppVKFL9HeC81s69IOH9eKRxdU0tEB
        1a3GoN4gODA7OToiB5HtcIftSgQAwiw=
X-Google-Smtp-Source: ACHHUZ5Y5G+jSCFppfNLGJSb+Na2sy3rIfgjOzms0f+PQDfHxVbr6Ld34RNQaYNUjy9k0d7OVBa9JQ==
X-Received: by 2002:a05:6402:2048:b0:51b:dd90:b1bc with SMTP id bc8-20020a056402204800b0051bdd90b1bcmr1612803edb.22.1687378810836;
        Wed, 21 Jun 2023 13:20:10 -0700 (PDT)
Received: from shift.daheim (p200300d5ff294300aaa159fffeeb01f1.dip0.t-ipconnect.de. [2003:d5:ff29:4300:aaa1:59ff:feeb:1f1])
        by smtp.gmail.com with ESMTPSA id g25-20020a056402181900b00515c8024cb9sm3055816edy.55.2023.06.21.13.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:20:10 -0700 (PDT)
Received: from localhost ([127.0.0.1])
        by shift.daheim with esmtp (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1qC4JF-000CR1-36;
        Wed, 21 Jun 2023 22:20:09 +0200
Message-ID: <03b73c54-5500-0b8b-c45e-b57320cc6bb8@gmail.com>
Date:   Wed, 21 Jun 2023 22:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Christian Lamparter <chunkeey@gmail.com>
Subject: Re: [PATCH] usb: host: xhci: parameterize Renesas delay/retry
To:     Anne Macedo <retpolanne@posteo.net>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230618224656.2476-2-retpolanne@posteo.net>
 <f4b0f337-c530-8c4f-dc22-cfaf834dd5f0@gmail.com>
 <5a057964ae1e26ed934035c183bf2967@posteo.net>
Content-Language: de-DE
In-Reply-To: <5a057964ae1e26ed934035c183bf2967@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/23 12:12, Anne Macedo wrote:
> On 19.06.2023 10:19, Christian Lamparter wrote:
>> On 6/19/23 00:46, Anne Macedo wrote:
>>> Cards based on Renesas uPD720202 have their firmware downloaded during
>>> boot by xhci-pci. At this step, the status of the firmware is read and
>>> it takes a while for this read to happen (up to a few seconds). The
>>> macros RENESAS_RETRY and RENESAS_DELAY are used to retry reading this
>>> status byte from PCI a few times. If it can't read the status byte in
>>> RENESAS_RETRY tries, it times out.
>>>
>>> However, since this may vary from card to card, these retry and delay
>>> values need to be tweaked. In order to avoid having to patch the code to
>>> change these values, CONFIG_USB_XHCI_PCI_RENESAS_RETRY and
>>> CONFIG_USB_XHCI_PCI_RENESAS_DELAY are introduced.
>>>
>>> If applied, this patch helps to fix errors such as:
>>>
>>> ROM Download Step 34 failed at position 136 bytes
>>> Firmware Download Step 2 failed at position 8 bytes with (-110)
>>>
>>> while loading xhci-pci when using these cards.
>>>
>>> This error in particular has been noticed by this e-mail [1].
>>>
>>> [1] https://lore.kernel.org/lkml/20190626070658.GP2962@vkoul-mobl/
>>
>> Can you tell me on what hardware (is it something older, with maybe
>> a Synopsys/Designware PCIe host controller?) do you experience these
>> errors and what delay+retry values are you configuring in order to
>> get your DUT up an running?
> 
> It's a PH61 Rev 1.2 board with the Renesas uPD720201 host controller.
> I'm using 10 as the delay and 6000 as the retry.

Oh? Is this an old MSI PH61 mainboard or is this an add-in pcie card
(found something on amazon with that name and rev too)?

If it's an add-in pcie card, could it be that the EEPROM chip on it
is (getting) a bit wonky? Or do you have a really fast machine?
(Latest crop of i7/i9 Alder/Raptor Lake or Ryzen 5000/7000 Series)

>> From what I can tell, the quoted [1] link to Vinod's mail was just
>> an update during development. This was v3 of the patch series back
>> then (and it went on to v10 I think, so this wasn't an issue with
>> what's in the kernel right now).
>>
> 
> I see. That was the only reference I found to the timeout error I was
> seeing, so that's why I decided to tweak these retry+delay values.
> 
>> Note: If you are interested I still got the "uPD720201/uPD720202 User's
>> Manual" back then from Renesas site. (Nowadays they want you to
>> register or something.). This document was the base for the code and
>> maybe there's something in there you can quote to extend the
>> retries/delays.
> 
> Definitely interested! I did find a .pdf on Google though, I can check it.

There's also Renesas loader code floating around on github.

>>
>> (From what I vaguely remember. Most of the transfer was fast and
>> no retries where necessary, but some register write took so long.
>> Vinod  also posted hints about a newer firmware for the
>> uPD720201/uPD720202. Have you tried that as well?)
> 
> I was using the upd72020x-fw AUR package on my Arch Linux build,
> if that's any relevant. However, it's quite old and I don't really know
> how it works. I missed these hints, sorry, could you point me to
> them?

Yes, I was talking about "K2026090.mem". I didn't know this version existed,
but Vinod knew about it:
https://patches.linaro.org/project/linux-arm-msm/patch/20200113084005.849071-5-vkoul@kernel.org/

Looking on google leads to startech.com and they have/had this as a product:
https://www.startech.com/en-de/cards-adapters/pciusb3s22

The K2026090.mem Firmware file is in the "[renesas upd72020x] firmware update.zip"
(see in the "RE202.A10" folder).

I don't know how it works with pcie cards that are supposed to have the firmware
stored on the EEPROM chip. In my case of the WNDR4700 - there is no extra chip and
the driver has to upload the firmware - I just have to put the file renamed as
renesas_usb_fw.mem into /lib/firmware/ and it works.

Regards,
Christian

