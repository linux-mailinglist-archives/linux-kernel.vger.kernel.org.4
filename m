Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10860615D59
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiKBIHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBIHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:07:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3512E2714E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:07:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y16so23277571wrt.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnAnmSt8vCtHb/nQVL50lsBnUPTXAejosvygs/MYwlM=;
        b=JbNeyS5h0hTdXHTEb7GtydATNNK2dp6NYIPpTKEhsGCCGqDJ1VOzVi5bYnDXhOsnnE
         RkMCzgXtWadxivKomBKNZQDLjkhlBr+EV2PXAgM4i8Ttp9ELulBYULOd7WgcR2EKFJ3q
         lwFUelgcOyPgEK2xLpMLSJcM8c1UnOczpntr8cvDPJokixQlcD9liP/aZlOjLmuL31k5
         I/CfKMMeDqIBXcZCcNVsB6TsIIIz5DTmmKzj7FPb77twt99BDrO32X2x0aH73iHXGjmn
         BWQ+GvhBtrfKGI3W08tV9vFh06TIapQFk0XYV0uK0Yu0OBo4v+zaCv+fnpmfonY6T9cI
         ZG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnAnmSt8vCtHb/nQVL50lsBnUPTXAejosvygs/MYwlM=;
        b=bHMWZLC410HdV2qOEZYGIrI/6sAxC/t/LjOUHtJP9lzrauHdzI0SbNYHjIRHStQdBe
         C6ublAiIwzfcgbjTnEUo9kigQXOSgRg0U7hgJHsM5j064QstQXdVASNrkxlltNbDMuVw
         FckxZFIpYttfcIPQBrY8aytoAmn69TluHgrBQWQpdjQ6RW/625YZfGhcEkDI64MXXesO
         sIIz3ehG/RKAhwDQVMFGzBk9FIjXVVy1J2A/LwhG01It71aUsHUVKbjQ6D7m3aKuQ1AY
         Fp8YUfHGykttjlTvHIeNXcm6W1HWGCGYxZIyGf8PUnePmiYTl1hnVptQfeTWIhxcLrfT
         57Cw==
X-Gm-Message-State: ACrzQf3OiNDsJJm5Qfubsy95LCBAv5awLqebBhV1ATEvGf7Xk43xV515
        YhYruAfnwJ2lUK6KNB4QSkHP7A==
X-Google-Smtp-Source: AMsMyM4RNUVUAgKayw8H0HZe2yKGYqCfHwE8ipd798ULPS5HZa8qDEqlCcUfle9Oa157pW1r5tZTGA==
X-Received: by 2002:a05:6000:1849:b0:22e:6d62:cc9e with SMTP id c9-20020a056000184900b0022e6d62cc9emr14532034wri.323.1667376453768;
        Wed, 02 Nov 2022 01:07:33 -0700 (PDT)
Received: from [192.168.2.9] (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id bo29-20020a056000069d00b0022eafed36ebsm12384603wrb.73.2022.11.02.01.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 01:07:33 -0700 (PDT)
Message-ID: <5e62ea97-9a2e-b07d-375b-d029d941d520@mind.be>
Date:   Wed, 2 Nov 2022 09:07:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/3] ASoC: adau1372: fix mclk
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221028152626.109603-1-maarten.zanders@mind.be>
 <20221028152626.109603-2-maarten.zanders@mind.be>
 <SJ0PR03MB6778A0EB0CD15A3A917BFE4A99379@SJ0PR03MB6778.namprd03.prod.outlook.com>
Content-Language: en-US
From:   Maarten Zanders <maarten.zanders@mind.be>
In-Reply-To: <SJ0PR03MB6778A0EB0CD15A3A917BFE4A99379@SJ0PR03MB6778.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/31/22 12:20, Sa, Nuno wrote:
>
> I guess this needs a Fixes: tag?

Yes, you're right. I figured it'd be less relevant since we're fixing 
the initial commit, but that was wrong.

Did you get a chance to look at the fix itself?

Thanks!

