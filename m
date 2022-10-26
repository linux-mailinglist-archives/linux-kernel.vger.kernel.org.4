Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FBB60E404
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiJZPD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiJZPDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:03:24 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05302EB758
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:03:24 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f8so10724134qkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLZuzkEKYp97tAxDKW0D3/Gkrrsn7TLdMLIwN3unr6k=;
        b=l6iea6O/IfA+IU8rsKa/xzdX0TI+DG5gYzNw4EfcdDXMQWAIx3WzFHQ7WrucFjyiw2
         R6jbnPvM499FIYged2lfIzQbOAG28Fl2PeRw4xCeg1C/iLtTnQGVGlKNFJPn05JfE9J9
         Z06FwsPirlsVSXZegXXJNS+Pm2mvskZ4+PkpZaMCDb/EIYlp60NlunTlvBf18hSoP5Gv
         s6sNB2RJZRxFX9Cen0El2ParhFlnGry9Q/oOzcUNKlDzXqGp2Fu6fH4uYHzXHt4YfJdv
         sRn+uR6IoPiWHOpl3t9b0ZGI41ZInAYeE1ARtdmcHz8DiZ3mTj+YOdFcCQhHjBNe+gQZ
         TmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLZuzkEKYp97tAxDKW0D3/Gkrrsn7TLdMLIwN3unr6k=;
        b=qxx1JWHkDdi8Vvuf+CzUYGDWBxmAPUrB8pYhfyrFL6lct8GVRHKBM0WMBckTXegpaO
         4JdwbHTZNrQov3yqlYZBfVDVF6i0rIxXMWnflRBtaiWGWuInmM64TaA2T8RfDLt/4GX2
         hBlCfcYwJVLmvV0fWvMyANalDYRor/nPptxMxRpBx+ton34rtMCP4zfXuzFtLlQ8Twfz
         6tt+MQ6pL68EE/FOk4aJkZW+iSDALaVPjlAJQF9pFzxO0V5G0jx9Vhherz4LsPEW3qau
         TA8+3sv7ZD+W/6gfWX+ojwYkyQz5Tl6VhGe2tyLEdSGgreHy0wNtZlkprn0QvcoBmIKM
         gukw==
X-Gm-Message-State: ACrzQf3wHXwgk3ykrPgnqlTIgsmNKLysELitkv6+spoM+G9yanG9bCtN
        hUAaDQbQEsxGBo7cD7rQoUu/Dw==
X-Google-Smtp-Source: AMsMyM7rarxhxnKYKAQs4buid/BHIUQHXVqNLrmkLzuNgNzVpR0hobrza80y8f5pxap7RvookcNtbQ==
X-Received: by 2002:a05:620a:bc5:b0:6ce:bc87:9253 with SMTP id s5-20020a05620a0bc500b006cebc879253mr32009819qki.486.1666796603111;
        Wed, 26 Oct 2022 08:03:23 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id o8-20020ac87c48000000b003a4f22c6507sm554617qtv.48.2022.10.26.08.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 08:03:21 -0700 (PDT)
Message-ID: <874e74ae-86bb-7950-1615-36e1a326e177@linaro.org>
Date:   Wed, 26 Oct 2022 11:03:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 2/2] dt-bindings: ASoC: simple-card: Add
 system-clock-id property
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <20221022162742.21671-2-aidanmacdonald.0x0@gmail.com>
 <ef6a326b-5c61-988b-2ec2-cd8e233e5d28@linaro.org>
 <GMvEU8xVTkjIoQ518XWAaLkhldSZHlk7@localhost>
 <4ef59d94-d045-55fc-d531-c84e7edb8333@linaro.org>
 <hXRpArckbrXUelDdaJ3Y2SErmKiuycXt@localhost>
 <66c1a100-922e-4a33-e80c-fc80866acf03@linaro.org>
 <jZCUALhj8PoqVkuWdtLf8LnPAj1wDakF@localhost>
 <38205667-d36f-e7a9-21b0-2e8597a662ff@linaro.org>
 <qNdQQJRLFWJ6gNfwM73oJ8EH56Y5nWgd@localhost>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <qNdQQJRLFWJ6gNfwM73oJ8EH56Y5nWgd@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 10:48, Aidan MacDonald wrote:
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> 
>> And the remaining piece I don't get is that these are not bindings for
>> codec, but for sound audio card. You want to set "system-clock-id"
>> property for audio card, while putting clock from codec, which will be
>> used to pass back to the codec... so it is a property of the codec, not
>> of the audio card. IOW, NAU8821_CLK_* does not configure here the clock
>> of the system, but only, only clock of the codec.
> 
> The system clock is controlled at the DAI level, it's specific to one
> DAI on one component. The simple-card device node has sub-nodes for the
> DAI links, and each DAI link node has sub-nodes for the DAIs within the
> link. "system-clock-id" is a property on the DAI nodes, so it's not a
> card-level property, just one part of the overall card definition.
> 
> Since the clock ID is something defined by the codec it would naturally
> be a value defined by the codec, but the *configuration* of the codec is
> part of the sound card because it depends on how everything is connected
> together. If you used the same codec in a different machine it would
> have a different configuration.


OK, that sounds reasonable. Thank you for explaining this. You still
need to convince Mark :)

Best regards,
Krzysztof

