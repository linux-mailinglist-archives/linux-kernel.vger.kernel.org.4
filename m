Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3025F6CBCAB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjC1Kjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjC1Kjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:39:42 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F1E618A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:39:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t10so47534853edd.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679999980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Rp6VZo9LId3BX033N14P3CvaNIPCBV06I8wC19k9S4=;
        b=IC1gzxtz1oG3wkhY1SGJbyjAopyj4+cuFnb6DHovrkLVwPC1n1MvhFVfj8xQqN/eSi
         HX9zgt4WbUeZ+GH9dt6RSV3kvCUJ5Z9E8yZqMVTQA2SboqnfBbCTQ/y2DN3J4Xi7bUK4
         GXiwVHhyCwe5x3l5KDdJZTSs/E99IoeSe3bQzuidTMNWLEIRZz75LuI1vu/56D1rNR4M
         Jd0do6CLI4JHT5D0en0S+4RaX9rPRfv7eqnUq/KLlblUmhaRkHjl3wBI91j2KQuONyf+
         3yng0iLbssqZrH0x7HqeMoHjrxAg1GDn93TcV1Zf2uqi0S/0jhHToGMYBfPHkvv+g/33
         26qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679999980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Rp6VZo9LId3BX033N14P3CvaNIPCBV06I8wC19k9S4=;
        b=PSQEOUdX8k22lfblCTAnPL8jUFOgIKLPaUU6GTrzj1GvJseyAl+Mlfpzr8XLfVKMA3
         MdvxSUfstSaTMGPCbS+vQEXzqLkakrGs+eXZg/jvhhYEK/7DPR/JhVWwAhQsYNhEeuhT
         McQV4UcfcysPdsqhVtai0/AedWMts2mgA/lYTxjWiveX1cTXxx/2BcAfxL1gSeZEqj2P
         KlmOm+EWIANcBNatT7GCTl5JRN/1DJw0tlWc7pDph9TGiJGF3DpJD+qeGlvpQ6eyqXyX
         S7PjOCNTCdjqYm1618B+rRI1vVe+jh3cufJUPbtc+PYFug+yNhbPUEHOoHj8seuarlhk
         wauA==
X-Gm-Message-State: AAQBX9eHDxr5pbNBlpaTK4QECNSMu7JF2FRVpL4LwiTlVgjYRYddFXzn
        jQ9yJDtbeHr7MxRsklHgwGv1jw==
X-Google-Smtp-Source: AKy350aeR+l2QHShByGShBsM2Crvf40sRkJF4PZYF6Y+FbeRMaArabxY1QQn39ltc8XEMe8dPD7unA==
X-Received: by 2002:a17:906:bcec:b0:926:8992:4310 with SMTP id op12-20020a170906bcec00b0092689924310mr16185642ejb.38.1679999949968;
        Tue, 28 Mar 2023 03:39:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id k19-20020a1709063fd300b00928de86245fsm15118289ejj.135.2023.03.28.03.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 03:39:09 -0700 (PDT)
Message-ID: <2dc9dc13-62e0-2b2a-b235-bc6e21d64dbc@linaro.org>
Date:   Tue, 28 Mar 2023 12:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 1/5] dt-bindings: mfd: Add the Lantiq PEF2256 E1/T1/J1
 framer
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230328092645.634375-1-herve.codina@bootlin.com>
 <20230328092645.634375-2-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328092645.634375-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 11:26, Herve Codina wrote:
> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/mfd/lantiq,pef2256.yaml          | 267 ++++++++++++++++++
>  1 file changed, 267 insertions(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

