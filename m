Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50F6603A96
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJSHYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJSHYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:24:10 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED4E786F0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:24:07 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a10so27527107wrm.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pO5JseBz8j296HTsa3kKnD9/F7eh1kiGFetG6YGNQSM=;
        b=A/dTZiZGo87ELII687rFcq19EVEWe04nVPcMeBcmzA9KkKv8+iQGGIr3k4oPKMQkqK
         KnCnooJ7BEGW2zyS6gsC0AwJ8f7t3hSWDzRBD8KDfaRSJhL+Ou/aNNq2l0FHqutjgboE
         v2uiYoPrLAC88MPy5iiLVceaAFVZ81yzdfP0BwQdFyPAw9NqwC9hvHv4LMx04/gc28v1
         nMxBEMdkmU+li7gSQXHOV71y1PB3hT6eZAPUpXwR0VCJ+F6GJraRC5X2DrZ3RpuPsMqA
         2gOCqy7JPIVVjII+brkNwo77xieGLstZOEOFhC1DAGdlfcujziYCTVHkQuobSOv9sVkV
         394w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pO5JseBz8j296HTsa3kKnD9/F7eh1kiGFetG6YGNQSM=;
        b=LPxoKEqfqlugjEkU/M2pfPApi2lZaEkCuAgx0a2BB5XRxYj1h1C79ZCWH+Hf0934VK
         YLWO2daazkTjOpWTXEpJPAw0y3gUCC1tJ2r90A/PgOBjRfYGnCnlpfrSArRCFz7wA8Tf
         1tIk2i0kx/t+LvdpqvwsjRQui4X+ltp523SxCK1R3xah/qdauxLej89HSq5bOX/Xv4Mp
         TwTBSwYsK5jMLT7qXCXsg6pVtHSW3lpDPdYrOm21WoUT4291X8sF/P68n3X83kMkOQBz
         4W1a3DvyOsZ2B71WW4pq/FwW10ieD9jCopb3BMCgRb7fuRb5aiBsXeQWCZoWftq3MQRc
         2m/w==
X-Gm-Message-State: ACrzQf3Kl1ZTrMkmC4clsZNDEBQyyjTNxdHgcBG7fZmV/NG1fGv2QmhK
        Pt4qQn4GVOLk0HaDcxSANIZtZxEVQjI3ltG+
X-Google-Smtp-Source: AMsMyM41BG7VmonFRVjNhVfV/BEj8FDJYM2MMC9XYIyg52OWiE/yTm381JfFpSAthVXGpTfwKDZ6bQ==
X-Received: by 2002:a05:6000:1102:b0:22e:529:a43d with SMTP id z2-20020a056000110200b0022e0529a43dmr4122710wrw.412.1666164244704;
        Wed, 19 Oct 2022 00:24:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b15b:4b56:592a:c397? ([2a01:e0a:982:cbb0:b15b:4b56:592a:c397])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d44c9000000b0022917d58603sm12975630wrr.32.2022.10.19.00.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 00:24:04 -0700 (PDT)
Message-ID: <c0f22ea5-b094-d477-e6e4-c509945587e9@linaro.org>
Date:   Wed, 19 Oct 2022 09:24:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: meson: Enable active coling using gpio-fan on
 Odroid N2/N2+
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221018195122.8877-1-linux.amoon@gmail.com>
 <CAFBinCCqXBk9Xq0k=NA3zGi8spwyPQN7dMVWcjE+pXkXYf+FKQ@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAFBinCCqXBk9Xq0k=NA3zGi8spwyPQN7dMVWcjE+pXkXYf+FKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/10/2022 23:16, Martin Blumenstingl wrote:
> Hello Anand,
> 
> On Tue, Oct 18, 2022 at 9:53 PM Anand Moon <linux.amoon@gmail.com> wrote:
>>
>> Odroid N2/N2+ support active cooling via gpio-fan controller.
>> Add fan controls and tip point for cpu and ddr thermal sensor
>> on this boards.
> In the schematics for board rev 0.6 [0] I cannot find any information
> about a fan connector.
> The schematics for board rev 0.3 [1] on the other hand document a PWM
> based fan connector on page 16.

It seems the fan connector is on page 41 on rev 0.6 and it seems to be the same.

> So now I am not sure whether your patch only applies to certain board
> revisions, the schematics are incorrect, etc.
> 
> Can you please provide some details about the fan connector on
> Odroid-N2/N2+ and which hardware revisions are supported (and which
> aren't) by your patch?
> 
> 
> Thank you!
> Martin
> 
> 
> [0] https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.6_20210121.pdf
> [1] https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.3_20190117.pdf

Neil
