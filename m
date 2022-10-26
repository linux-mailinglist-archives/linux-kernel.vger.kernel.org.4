Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC7560E410
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiJZPFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiJZPFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:05:18 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA58A7A9E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:05:16 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a5so10718451qkl.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+Yian3XJfjwAtTtvdKaogB3HiRKzCGm7a/+W1PG+Bs=;
        b=Ol7qYit5i8e0FB2o5UVEvowECPm2l3afA/NKhZBEFTqA3cRqK2OswutA/C8AYW2tQc
         IDCbMbPg04VX0hxosA7JgNk5JLi58Yxv6iJ9Fr2viWNfMeqE6JN4d2D07kf5TSPKZjqb
         rLl6b1MOzmRd+YKi+Wq3IkZ/OqzDiCFW7k4m+KbRmQkakweDhIjhGjsc+cnZXQTZf17o
         5X490R3cQofow4QefVKFYCg77XoJuKhFqN2A8vCPsDuK1Hu736zRaae3CL7uN4u3SwYe
         5kQepm1PShNfxh2p52i44FfFhwqw4Wt1+D3pFFoUzHF5z+w1gGygk4MEKBWhsfi36k6n
         TE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+Yian3XJfjwAtTtvdKaogB3HiRKzCGm7a/+W1PG+Bs=;
        b=05LuTYGhtJ6oqGsG+3QPtihTSTIz2kWp2f8I3UhG+50G3qpriPLD4JjHZkwZav8JZI
         96y1AZsxP1a1nsfAT08d2V913nsGDL9iTuiyLlpN764QYfHEs+B4SHFeYctj4TYqvnRL
         E1PgJHDcg+J33sxR7U/mwOO5eTJg9IW7M1mXWaig3rLh4XhOI/Ac0HEkjKhTDSbGaxM9
         yO4oy6HfHlauTWHHSPOgteabVPs9gcRUlIeFFmtbzvO+IesYyqhtQbf9L2xewPLh4Neg
         Zilnk+Wp7D0CeQm3GaEZHD6x+IKX51p6JTOGdZS39/1TkmjGHTRnwTlxQPACNfstHh5e
         oOIQ==
X-Gm-Message-State: ACrzQf1pgBU2vPX/7ITY7LGT0hMbvkiE/BKkk9+a7bOLuNTSq4fYLs1e
        MHm8E6WLwfuLhnZoWaqyEYdASA==
X-Google-Smtp-Source: AMsMyM6foj2gIjI2u8y7Jp2aKeXtSR0X0hJfnW9nxP5T5NjKIqKcVT7s6ReMcs7TNopkLjjkoQj4kQ==
X-Received: by 2002:a05:620a:4398:b0:6ee:be9f:435c with SMTP id a24-20020a05620a439800b006eebe9f435cmr31093108qkp.35.1666796715759;
        Wed, 26 Oct 2022 08:05:15 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a0ed600b006b61b2cb1d2sm3944483qkm.46.2022.10.26.08.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 08:05:14 -0700 (PDT)
Message-ID: <ac24732b-a7bd-59fb-4178-b225bc0b17c0@linaro.org>
Date:   Wed, 26 Oct 2022 11:05:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 2/2] dt-bindings: ASoC: simple-card: Add
 system-clock-id property
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kuninori.morimoto.gx@renesas.com
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <20221022162742.21671-2-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221022162742.21671-2-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2022 12:27, Aidan MacDonald wrote:
> This is a new per-DAI property used to specify the clock ID argument
> to snd_soc_dai_set_sysclk().
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/simple-card.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)

My concerns were addressed, so:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

