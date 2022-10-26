Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AF560E8FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiJZT1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbiJZT1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:27:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A65F8768D;
        Wed, 26 Oct 2022 12:27:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k8so19477532wrh.1;
        Wed, 26 Oct 2022 12:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=GGmY+Tp0PCWgfcXh6CFFXtUnB9FaG+fCvf/13WVSk0w=;
        b=WF0x0DYfw1EI99+cBa5oo2iwSMWXe2cHrN+NQTQWWhx3YAjYadG+nCo8pOKXeTv6ER
         kdsVNLpzsIugaP0uY9u7cxWLIVrzKRylGKo7jIJapbyRzJ0Q/iP97n+E7mTBOuhIlrIm
         R5ZyuDLHloa6t6WmBeaW+xVELUsisof0vhNXv0JcDoHQzOEkuyaKKHklOnM+YQIA8jy5
         kw/ipuY32LTF6BEUgZhvBpVkihdst96J4YFyq13kpH6GtITdEq/8KlcYcoLPRdDihg8B
         kRuTklblvwf0eTIwWgirSPMx2ZD4Yb2A7qCWaYkjdcHMaGAxOqi4ZFW2tpRIB+VNcUwd
         s8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGmY+Tp0PCWgfcXh6CFFXtUnB9FaG+fCvf/13WVSk0w=;
        b=5mil4Dy+QjjsULtyZZ/45o3HPvOEDMj2uu+dJJ6Xh5btlMu2D0cK219aNu19FwYgzP
         KHyjkNk7e2D9ZrECuHtPoZEyYX2GxVSU2EiA6IoomQIY5sRr+QQPMGvZn5vcjGhh6UF+
         1dfjijeh9LlNggmIeAWuWHVE/ERkM/mPu06n7OMrcDkQZY7ki3rlf1bx7w0I5FAcZPgY
         upZbGPAxziIlCSEDraOhnbhWINAEcQ4HC04JT8FM1O9kxrjyHvxdcp1FHkgxD4UMT84q
         2w5tpJAVlgC4VUXgJA1Bu3VRkqntEhUh1pbBa+rzpJd/dEJ2K8sHBx7pb6F27sDXkspf
         uuDA==
X-Gm-Message-State: ACrzQf3yrNWg6MVjfBJdskDH7g9L6vxi3zyyHsNntZXu4a5RlQ4mWrsE
        vV7mV9yR6xGRYVMqJIqPFnA=
X-Google-Smtp-Source: AMsMyM7vylDfJxSJa8D8rTUC1YTGqz2fYScD5Gm+yB1SSIakSHtk+3ViLyMzAIt8dcdPdH+0SDGKaQ==
X-Received: by 2002:a5d:4b51:0:b0:236:88a2:267f with SMTP id w17-20020a5d4b51000000b0023688a2267fmr4789242wrs.461.1666812427161;
        Wed, 26 Oct 2022 12:27:07 -0700 (PDT)
Received: from localhost (188.28.0.84.threembb.co.uk. [188.28.0.84])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b003b95ed78275sm3082902wmq.20.2022.10.26.12.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:27:06 -0700 (PDT)
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
 <874e74ae-86bb-7950-1615-36e1a326e177@linaro.org>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: ASoC: simple-card: Add
 system-clock-id property
In-reply-to: <874e74ae-86bb-7950-1615-36e1a326e177@linaro.org>
Date:   Wed, 26 Oct 2022 20:27:07 +0100
Message-ID: <PkzdCCuz9l2wB7cV6ioHPIEYBXflo86N@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 26/10/2022 10:48, Aidan MacDonald wrote:
>>
>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
>>
>>> And the remaining piece I don't get is that these are not bindings for
>>> codec, but for sound audio card. You want to set "system-clock-id"
>>> property for audio card, while putting clock from codec, which will be
>>> used to pass back to the codec... so it is a property of the codec, not
>>> of the audio card. IOW, NAU8821_CLK_* does not configure here the clock
>>> of the system, but only, only clock of the codec.
>>
>> The system clock is controlled at the DAI level, it's specific to one
>> DAI on one component. The simple-card device node has sub-nodes for the
>> DAI links, and each DAI link node has sub-nodes for the DAIs within the
>> link. "system-clock-id" is a property on the DAI nodes, so it's not a
>> card-level property, just one part of the overall card definition.
>>
>> Since the clock ID is something defined by the codec it would naturally
>> be a value defined by the codec, but the *configuration* of the codec is
>> part of the sound card because it depends on how everything is connected
>> together. If you used the same codec in a different machine it would
>> have a different configuration.
>
> OK, that sounds reasonable. Thank you for explaining this. You still
> need to convince Mark :)

No problem, thanks for bearing with all my explanations! Mark raised
some good points, and I have to agree with him. This could create too
many future issues, and the problem might be better solved with the
clock API -- but unfortunately that's not yet feasible.

Regards,
Aidan
