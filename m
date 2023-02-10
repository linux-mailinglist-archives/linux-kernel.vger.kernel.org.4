Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4482691BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjBJJyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjBJJyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:54:04 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6E97289F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:54:02 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h16so4430982wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DT/YTaczEsqUTwtjEMUlyfX5CYHzpcISFyERcOWxQMk=;
        b=StafhWd9wRSyN57pB6OeyIV1oXxde2bom8ccd2vsCgV8Q03LXmkn7/f4XF6AmbWxHV
         p3CASxzY0nhkjAqxx5X8YBS23Tn9xwdtzKRFRlOnU6og/PMyd1QQi/9vzArUJqIlyNxW
         EGL1KqLtNNuuFw7TGAJawmQdS8QnfbWPvnUT7Qyfx0tABPOsn/rNwXzWyG5KS4mAXb8Q
         5UjUqffm5+ra6GjCADD2OB1wDu87xCcrCjipvzNNlgsf6tv3T9EN416nCIqsQgEzdVV+
         ueJB2J1YmXpBhdJ8tqEXQW0ubVscFdFwrtn+g7jUJXII7R6KWBxDTEQxTCxRqGhOSg9k
         ePlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DT/YTaczEsqUTwtjEMUlyfX5CYHzpcISFyERcOWxQMk=;
        b=FMYdCDLxsLxMVhDWTioe0uq5XMrIIX4KgY9LhJy/o51Z1wu+pq2fEu9PGhQuoKiTVP
         G+jHWXLUAQuufCiMeZrlaQZ6HThmHZOPZQCXbyjQRJoiv+2yky9nXtbpliv2Jx0ssy9f
         TCmcnoSlVJG2lnL5RNJo7KoNtUxgd72aGTVXlKrxNtWpTjd2JjGjztg0DaTnO3ZExeXz
         CXsLjDwdEXxSoAaNdRnbf25ij1PKzdiqXPSdg+M/byhiRFjhWliz9nXZnxgU197aqM4b
         3bDFviDxI7M0JNJ2PQ1Ykzmezwhmgrx0QgwTBbiXo+8JQ6doRCFVtjmoI5JQpp/zkXBE
         T6NQ==
X-Gm-Message-State: AO0yUKU+m3iB6itmr24V9ckRU/vYSFz+lif1eRpWNp/pPPlH2AzbXFSH
        aRByEVfutK6COpovtua3u7RWqg==
X-Google-Smtp-Source: AK7set/mQrAtmfuIVos3kekrVUbU1HQtOa2i/MpfcvN3fFMdpIOrhpCy8l3PlJuS/m6POCcQgb1QQw==
X-Received: by 2002:adf:f708:0:b0:2c5:3cd6:4fdf with SMTP id r8-20020adff708000000b002c53cd64fdfmr4413510wrp.39.1676022841466;
        Fri, 10 Feb 2023 01:54:01 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d4207000000b002c3ce97ec38sm3311518wrq.115.2023.02.10.01.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 01:54:01 -0800 (PST)
Message-ID: <c400735a-901c-5fb3-428c-81258ff99615@linaro.org>
Date:   Fri, 10 Feb 2023 10:53:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 3/3] ARM: dts: aspeed: Add device tree for Ufispace
 NCPLite BMC
Content-Language: en-US
To:     Jordan Chang <jordan.chang@ufispace.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
References: <20230210055451.72153-1-jordan.chang@ufispace.com>
 <20230210055451.72153-4-jordan.chang@ufispace.com>
 <4b735136-d9c0-cf01-e453-c8da31754a93@linaro.org>
 <CAJ3czeSeuPx1L-qkXFVLR+UQDyJHF_G4Z5MdoYSeLaifWNnn=A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJ3czeSeuPx1L-qkXFVLR+UQDyJHF_G4Z5MdoYSeLaifWNnn=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 10:21, Jordan Chang wrote:
> Hi Krzysztof,
> 
> On Fri, Feb 10, 2023 at 4:56 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> From where did you get my Ack? I don't recall it.
>>
> 
> I misunderstood the usage of acked-by, please ignore this email patch.
> Apology for the mistakes.
> Should I resend an email patch or it still works on the previous v2 email?


Please send v4 with correct tags (so tags present only for the patches I
gave them explicitly).

Best regards,
Krzysztof

