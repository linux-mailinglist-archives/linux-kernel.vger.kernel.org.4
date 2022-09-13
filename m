Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307A85B6EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiIMN5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiIMN47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:56:59 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759C648E96
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:56:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bg5-20020a05600c3c8500b003a7b6ae4eb2so13442865wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=DBFNcpuxVAxISyr6RslPxKv7Y963vtWTyK62OGbBDBA=;
        b=FcDnB6eOC10icYwusSZIBrl5934ODlKUrRgvDEgTRIkf506UIbYtY0QyBSjgKEEO+D
         P3ixDCnAVljCEOmoFR+OHObKVNr3GhFAjhNFjatOYCacf0/CF72sTS0Xi4LM1Cq0NZhq
         3ltPANYTI8gIBS8EZa3mAYndK8GmC41S5OOto8PLXp8orAKG4n04qOqVDuV86CC+fGKW
         yKG6pb8/2HDXwVi4AFGfu2sOglnIxubS6YDOhUsSlZkyMoVpO11G2JM+K+F734L+EC/y
         hzi53+rbJd07oYVSFbt4sx9w0Bh/CCc9errSFZ12x4jEXqNRveqBSNRgn3USZnqQcAsQ
         fn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DBFNcpuxVAxISyr6RslPxKv7Y963vtWTyK62OGbBDBA=;
        b=wfb0joNeC2edK+X0BXXv2qsQ178TTAfVEI6VawOMDa23lwimkw++GfYpsebK+rxevX
         kCO0QybvXrg0S+il9XYhgZYJtz11D3LLFOWAac2hFxC1EJ9J20HTL/9SExnfa0LgqAgI
         /r7z/VbHAghqzlR1TW6jS04vd7y8ckHaMBfGkDH+RWkAToebqAZQVyQrmAvwrbcDnHQl
         Hdko+fprLn6zJA4MkeLr+ICmY2VQ3Z+3klvIQGuB385qeMz5pOWk8T6fJNazYzPF7x1k
         LRaqZXQgC/I/bvvKVzC+0ZJbdOwZsW2YjwzEVHQK2Ayq6hC151POT+vv/9xpgjTJazBS
         muvA==
X-Gm-Message-State: ACgBeo18cJodjp4CdASeP3VoDaC6VtoA/EnoKCkv+em9BzmxDYPmUQgV
        ohtkH1pOv3iA7OE6GXHO6tqIJQ==
X-Google-Smtp-Source: AA6agR5XauLIifCopCCiTYHVlA2rXmVC6tZlWV0o6gekcpBqqvQc8Cmis9/APlQuNtC5WtAd48D/uA==
X-Received: by 2002:a05:600c:524d:b0:3b4:8ad0:6d with SMTP id fc13-20020a05600c524d00b003b48ad0006dmr2643968wmb.194.1663077416090;
        Tue, 13 Sep 2022 06:56:56 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.67])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d5090000000b00228d8420f57sm10654173wrt.95.2022.09.13.06.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 06:56:55 -0700 (PDT)
Message-ID: <4e0487de-971c-7bb8-bdd6-7013a48ee4a6@linaro.org>
Date:   Tue, 13 Sep 2022 15:56:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [linux][PATCH v9 2/2] dts: arm: at91: Add SAMA5D3-EDS Board
Content-Language: en-US
To:     Claudiu.Beznea@microchip.com, Jerry.Ray@microchip.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220909163022.13022-1-jerry.ray@microchip.com>
 <20220909163022.13022-2-jerry.ray@microchip.com>
 <eeca0eef-e73e-847f-de54-1511dddff842@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <eeca0eef-e73e-847f-de54-1511dddff842@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 08:37, Claudiu.Beznea@microchip.com wrote:
> On 09.09.2022 19:30, Jerry Ray wrote:
>> The SAMA5D3-EDS board is an Ethernet Development Platform allowing for
>> evaluating many Microchip ethernet switch and PHY products.  Various
>> daughter cards can connect via an RGMII connector or an RMII connector.
>>
>> The EDS board is not intended for stand-alone use and has no ethernet
>> capabilities when no daughter board is connected.  As such, this device
>> tree is intended to be used with a DT overlay defining the add-on board.
>> To better ensure consistency, some items are defined here as a form of
>> documentation so that all add-on overlays will use the same terms.
>>
>> Link: https://www.microchip.com/en-us/development-tool/SAMA5D3-ETHERNET-DEVELOPMENT-SYSTEM
>> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
>> ---
>> v8->v9:
>>  - Changed node name from gpio to gpio-inputs
> 
> Why not gpio-keys as all other DTSes are doing? Anyway, I can change it
> while applying.

+1 even if these are not physical keys. If we ever run sed pattern, it
would make life easier... :)


Best regards,
Krzysztof
