Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243A5743E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjF3PCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjF3PCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:02:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E300D171E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:02:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc0981755so18661875e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688137354; x=1690729354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XkW0ju1DfGLdkGmFEpNKOeGgt/oTLnPR/vBNsWYtTw=;
        b=T+6sWpEWNaNvJCk70tUnQ7ziTP17oZtBYhn3Ywf4K4FPwXvc2KrTIHPNt8VLVIKgKQ
         JAwKb6mpFuTWw1Qy8wNENmKMue7fvogPzhBbL3CRtSyikw5CgcSzW03pNACvI3tl/qwp
         CM+FQKK3skDeb8Ms/oTxZ+Wm2I85CwpVP9ysZIjX5fr4q6vkgKy2OR1fTtFpERYbemk1
         6Cgv2uyfryFhbl688BTDMAwTtgB9o6RGG/TtcPAl/z0FVR1k1Rs3GSwpNLDQkDKah111
         9IjdHNE3TDjsZlhjNLcgmnwtNwDIggMOWtxXMSZkgYBsoW5VWhK2mXkT7i+unaDb2feV
         PI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688137354; x=1690729354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XkW0ju1DfGLdkGmFEpNKOeGgt/oTLnPR/vBNsWYtTw=;
        b=hZZmZV06kvfwhEpxEtqLg2orrW9BS8inZLZDLLmQNE5F3zIYj1ugmvqyDWOnFp+3K6
         cYsyV7yESheoxT92B0VTDDvep2WYkaxpCIQwYqw7fRAOzKynupdxi+dc4Kzx7PHtDRJq
         ET4X9ICE9eXMbmaA8QJU0KN32/DVOgLr97ZyxQaIKlOjFLCs4kz3vWnBuCX2woX7ae8t
         AmXf+0yju0pBmkDWRA2/UcFwRo3BBF7tXTFZoMPKkw2CTzA4/TJCqH9D5wm5WA9y1d9V
         p2Nv0H6idyxSQCxktSkruDu5523zwuNmgZxiUk+90PoKz9kfBiOKBU/F+sHpdP9LUhgX
         Jyhg==
X-Gm-Message-State: AC+VfDzLbzJY4DxMMLqwMnmSstf1Lx+3S5egjoxvhy3gD4ERBh29tayb
        n7EewszFRBWPTP1bGWwQ5C5Zgg==
X-Google-Smtp-Source: ACHHUZ6fO6EpxJ+iOICbEV1K5cvBhUyJ6l4rYRLUp1Lmucz+u3sm9qi9CAw4KbgZjDOgQ5K3ugspEw==
X-Received: by 2002:a05:600c:ac6:b0:3fb:b3aa:1c88 with SMTP id c6-20020a05600c0ac600b003fbb3aa1c88mr2169011wmr.26.1688137354397;
        Fri, 30 Jun 2023 08:02:34 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id u12-20020a05600c00cc00b003fbc681c8d1sm1900627wmm.36.2023.06.30.08.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 08:02:33 -0700 (PDT)
Message-ID: <07881d30-cec6-5885-ecb6-fbfaea88f3c1@linaro.org>
Date:   Fri, 30 Jun 2023 16:02:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] ASoC: codecs: wcd938x/wcd934x: loglevel fix and
 cleanups
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230630142717.5314-1-johan+linaro@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230630142717.5314-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/06/2023 15:27, Johan Hovold wrote:
> When investigating a race in the wcd938x driver I noticed that the MBHC
> impedance measurements where printed at error loglevel which is clearly
> wrong.
> 
> Fix that, and clean up the logging somewhat by using dev_printk() and
> addressing some style issues.
> 
> Included are also two patches that drop the bogus inline keywords from
> the functions involved.
> 
> Johan
> 
> 
> Johan Hovold (5):
>    ASoC: codecs: wcd938x: fix mbhc impedance loglevel
>    ASoC: codecs: wcd938x: drop inline keywords
>    ASoC: codecs: wcd938x: use dev_printk() for impedance logging
>    ASoC: codecs: wcd934x: demote impedance printk loglevel
>    ASoC: codecs: wcd934x: drop inline keywords
> 

lgtm,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini


>   sound/soc/codecs/wcd934x.c |  8 ++++----
>   sound/soc/codecs/wcd938x.c | 17 +++++++++--------
>   2 files changed, 13 insertions(+), 12 deletions(-)
> 
