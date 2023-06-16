Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9948A73297F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbjFPIHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjFPIHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:07:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA25212B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:07:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977c8423dccso333884566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686902855; x=1689494855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E2D3uUdBgerQwcC/y3Nf8U05u3nrpXqViKkgZL68N70=;
        b=sPQOOHDmR/XTEFptr/jeMJl5AZFX7MeVAyWDCDRqMG5MrJ1lUDInmj1zarcAJixQ5M
         0DFgkdXAa/GZY9rPQpw3mLyqGOMiYmZHXf+YNjqEBS1lhvdNn58O1YdfbDf1hAox9NmW
         JmbHiLxv59lQT6a7S/ejUENh/SsJXvxdt9r6Lbp6RgVQ220Npzkj/sxZS72MXq/kwN46
         OIMJVCSnzkD5jK7xXFlXfsbn+/i17OIjIxX8MYw9bbavitsYZ/uTny8PGMgr/dJ+bgiR
         t4U+EKqKKi1HDX033VxMZhkyf+mWr80EXnBgyq+2FPztTDQ9ZoiObk1hJEtbMvf2jUCg
         5G+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686902855; x=1689494855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2D3uUdBgerQwcC/y3Nf8U05u3nrpXqViKkgZL68N70=;
        b=l+IecAauxYvX1/TOPe2qlxO6CKdXn2yzFc/ye/vXlN2QX4xRhaNi/1AEIM7WTCqI8C
         y2KYT98x3Z/QLJEILKWTvyHQ0DYRBCdqI5jCWKW3wGNPvU3fdziSQNr7SlD8XoHWOuj3
         s6edhSTTpzD16cM7N32G/gTz4EGI9R2C+sJrttQbnU7qz2KXhPoG6BDVJ6jEYrJKDn8M
         N1huej0ocNrgBqBAgOPG0JH8by8nkxszyhjJh9pVwqIrQ3jozq46wdWk/Rv+mCrgiE7V
         VibsfrpIpvd7aSWTdsH1jwJRU5IPF5qzd6zgl0VHjXYSxUUp9WdDD3UaMu5N5N/p57oy
         GDgA==
X-Gm-Message-State: AC+VfDyDDXDhClW5BbZmWc0fbmiUBnpdN863xuPYA0C5hl9J9Iab9/6w
        ZV9oLJI+eWW1b8rYLIhGnZ/Kug==
X-Google-Smtp-Source: ACHHUZ5fuviZiGwMVV38493IJyaxYzNur53hPODqxwhHxkTVBy6xeseAKFpS5q2Hc3Jh2QEaGcjBJA==
X-Received: by 2002:a17:907:6d25:b0:970:28c:f960 with SMTP id sa37-20020a1709076d2500b00970028cf960mr6277621ejc.17.1686902854787;
        Fri, 16 Jun 2023 01:07:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id br22-20020a170906d15600b0098652857e3asm299469ejb.154.2023.06.16.01.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 01:07:34 -0700 (PDT)
Message-ID: <643e6681-6ba7-e990-3e90-09071db904d2@linaro.org>
Date:   Fri, 16 Jun 2023 10:07:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 03/15] dt-bindings: display: mediatek: merge: Add
 compatible for MT8188
Content-Language: en-US
To:     =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
 <20230614073125.17958-4-shawn.sung@mediatek.com>
 <25816ad5-339c-e52f-adbb-686aa7977e9e@linaro.org>
 <61754861be70daa487b98475b246d8fed7e2dbd6.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <61754861be70daa487b98475b246d8fed7e2dbd6.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 07:29, Shawn Sung (宋孝謙) wrote:
> Hi Krzysztof,
> 
> Thanks for the reminder, because MT8188 is not related to MT8173,

How does it matter?

>  I’ll
> keep it as it is for now, however, I do find that MT8195 doesn’t exist
> in this dt-bindings which it should be, so there may be conflicts when
> this series is going to be merged.

Don't top post.

No, rebase on current next and implement my comment.

Best regards,
Krzysztof

