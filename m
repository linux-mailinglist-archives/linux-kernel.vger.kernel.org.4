Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D609270F340
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjEXJnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjEXJme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:42:34 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFE91AC
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:42:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30a8dc89c33so370908f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684921343; x=1687513343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uquqzdaQrX19mRcDaISNYnvybT61v+KWR57K049I3LE=;
        b=tbd5wy+zY49KmvFoEOTGhwI2WTzhH/ZG4gdY0YXn0J7AOdR19LraPxtn2dqPjSxQeB
         cttppn4t0lhjRfAkzCCrcq0WUr5A/h6TuY9/Zh4DFLCKKACzshfQRClpz8NaeOPl8+0m
         ahH0OhDr5Fzkxh2oofpYDe4BL2e0abA1TVJPgsijUA2OP03c1TFmfkb9R74XpvAmXMfa
         BiDEi7lKfX9y5Urud29LjwHRJ4vfEoLqjiztM0SERfh8mOarXjC2G37GzI5TTft5bg7X
         x/4PYVGtOzk5SQ2tlFGpusKI4RuyaWt9D3LUllKMSKW2ygm0Pm4A4LdpnZH0C0IwXS1+
         4jqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684921343; x=1687513343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uquqzdaQrX19mRcDaISNYnvybT61v+KWR57K049I3LE=;
        b=E8/GT989P4lZD2p0bPP8He6STLb+TbbV9N5VuM0xGjLdoev6ygSeIu9b3sld+TiWHs
         0YiFzjw3nHMuNQgPN5HQmKjFCzCrDco7Zk0tf5braE7jkJH3Stj0+UJ//NmUA6yoGoQH
         EcbPCx20Y+TzNVVbMMQxNdQa2iMBS9QoyP29ynLFnH0le74Bv9SmDIZmJOUntu3rBjRb
         Oj+oBCfAbmlwndKU+JkLZEBDvrtkZhrmKpZg05MVBMczkvsEKcZkK3RA0AjbG09cXBFX
         QxQ3g69wqdnQmhDbwMjBZ1rkYYOZtKUiwwWy/CJbO5rMClIb4+6okS+BzDg8x8vh1Tsr
         qVSg==
X-Gm-Message-State: AC+VfDzlsfxmtUMOICkj3BpZGml+k3QPc8OfnTPKaQfwdNBrs3XSaSLP
        zcT7r2giIEudFW5eIOQuaElSVA==
X-Google-Smtp-Source: ACHHUZ43MZZ5VeJjBY2a3hiOrD3vVjpcAeqRjxRgjQJAYQB8sz7zPSthTGL6T8eT1JMOWEOGzu5Xdg==
X-Received: by 2002:a5d:4650:0:b0:307:8e1b:6cc7 with SMTP id j16-20020a5d4650000000b003078e1b6cc7mr13307619wrs.67.1684921343466;
        Wed, 24 May 2023 02:42:23 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id f5-20020a5d4dc5000000b0030644bdefd8sm13900529wru.52.2023.05.24.02.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 02:42:22 -0700 (PDT)
Message-ID: <af7b7d4f-d7ab-b5ef-e639-9a8b13de54ee@linaro.org>
Date:   Wed, 24 May 2023 10:42:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] ASoC: codecs: wsa883x: do not set can_multi_write
 flag
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
References: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
 <00283665-e44f-457b-b2c9-1acf59d1cbd8@sirena.org.uk>
 <c37b88ae-7f54-3c07-666f-010a5fd84bd1@linaro.org>
 <d94e734c-e816-4b3f-9fb3-a6589063c05a@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <d94e734c-e816-4b3f-9fb3-a6589063c05a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/05/2023 09:57, Mark Brown wrote:
> On Wed, May 24, 2023 at 09:51:00AM +0100, Srinivas Kandagatla wrote:
>> On 23/05/2023 17:55, Mark Brown wrote:
> 
>>> Does the CODEC support mulitple writes?  If so it seems better to leave
> 
>> No, the codec itself does not support multi-write. All the codec register
>> level interface is via SoundWire Bus. which also does not support with the
>> existing code.
> 
> I'm unclear, is this a limitation of the hardware or of the current
> Soundwire code?

Its both.

Codec itself does not have any private write callback to support this 
and AFAIU Qualcomm Soundwire controller does not have any such hw 
facility to program multi-registers for device at one shot.


Also to note, the current state of code soundwire regmap write callback 
assumes that the request to write will always have base address at the 
start followed by register values. This is not true for multi-register 
writes which comes in address-value-padding pairs.


Am confused on the multi_write feature and looking at regmap bus level 
write callback.

Is write callback used for both Bulk writes and multi-writes?

Is multi-write feature of regmap bus or device?



--srini
