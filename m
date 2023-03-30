Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F086D0691
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjC3N0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjC3N0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:26:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B27FB45E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:25:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id e21so19594695ljn.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680182753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mV0+oh+l7u4kJ6illcn1TzgHR8FXz7lNfEJu+cV2b3M=;
        b=WZutxXbLCKTfXpxWNnSBlKxEjdN2v4d/BhD+EheqeQ8WcwjMKG25yVyhjOaqq1BrOE
         yTLTDCEqavIImpTELh2zzMb91KKpvmTQ/5KL2snNGExuvq0RxHGjOqmznhHsA1kZPCFo
         QQz2RrBSGp2hzBLAl4/URFLI40NM5gUYkpoE78nrqwtQuAkqlzacwGg0V0kN4TM1CM4a
         EX1Y72eM1bq4CvNqW8+1sARHxVxGmZdFXpn/7zFALQ5+yHTbpn+rrJ4zE3itkh0j3d3i
         e+RrIwaNq//4IG8QVodfA5Yn6br9KbetilGHiQULfrCTvnkNH1ITKRHC3RFFiqm5cvwA
         PZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680182753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mV0+oh+l7u4kJ6illcn1TzgHR8FXz7lNfEJu+cV2b3M=;
        b=4CHTU2nwQyDXofGxePe0qt/KtQjA91QSRWI8mWZ/LiZqlbyD3T5BFERyisvRIs9n1S
         SU/BhYL+RvOblBblVo4ZCUrVG/mEjTJz2Iks9XQ2I9g/sAPovE8cMO6t78L8t24QwB6p
         jvVF0BRuT/A2fw7MQ5KXPmrqfeViK0wLA6LYLN+a9DMCHq/4ACwD7eb9GlZ+/71uJaWJ
         oR4ENObtPh7rPAZjy5sdw8qftoOCAuHoagIwpxGvGQsniPcGyCxjKPcTlUfxED1Ymmb4
         ZFzYcVDfBc8gLhxE/ERYzRGKmFCGl0SMHmSte2fb8zdJWLnbXyY/VPLWVbF/4q7FEpqS
         LBRQ==
X-Gm-Message-State: AAQBX9eG0ViA0/9V1EsfOwcuJe4COI02A0VefWNAVKLkm0TmwEs/MVD1
        +BuecBPwhS8lzmN8LO/U2tXofg==
X-Google-Smtp-Source: AKy350bBOfZplRWkTpeeT0ceEob3PTLeDFq8qkKToR90OcxrWk/VYqw3HmYPvoJjrh1ldTiwtdfHog==
X-Received: by 2002:a2e:9ecb:0:b0:298:a7a7:47e with SMTP id h11-20020a2e9ecb000000b00298a7a7047emr7111926ljk.19.1680182753253;
        Thu, 30 Mar 2023 06:25:53 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v6-20020a2e9f46000000b002a6062f4a60sm1101270ljk.53.2023.03.30.06.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 06:25:52 -0700 (PDT)
Message-ID: <cfa5904e-8ae4-6d39-ed4e-35d1b55e2b04@linaro.org>
Date:   Thu, 30 Mar 2023 15:25:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 06/12] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-7-ychuang570808@gmail.com>
 <CAL_JsqKrrWyOKGUAaT-8r-nKvtS5f_gHAhE5=XaXuGtuYC2gCw@mail.gmail.com>
 <a497eb9c-8279-d4e9-3b8d-537ffa1f7522@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a497eb9c-8279-d4e9-3b8d-537ffa1f7522@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2023 12:41, Jacky Huang wrote:
> Dear Rob,
> 
> 
> On 2023/3/29 下午 09:07, Rob Herring wrote:
>> On Mon, Mar 27, 2023 at 9:19 PM Jacky Huang <ychuang570808@gmail.com> wrote:
>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>
>>> Rename the bindings/arm/npcm directory as nuvoton.
>>> Add binding for ARMv8 based Nuvotn SoCs and platform boards.
>>> Add initial bindings for ma35d1 series development boards.
>>>
>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>> ---
>>>   .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
>>>   .../nuvoton,npcm-gcr.yaml}                    |  2 +-
>>>   .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
>>>   3 files changed, 32 insertions(+), 2 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
>>>   rename Documentation/devicetree/bindings/arm/{npcm/nuvoton,gcr.yaml => nuvoton/nuvoton,npcm-gcr.yaml} (93%)
>> Since you are moving it, this one should be moved to bindings/soc/nuvoton/
>>
>>>   rename Documentation/devicetree/bindings/arm/{npcm/npcm.yaml => nuvoton/nuvoton,npcm.yaml} (93%)
> 
> OK, I will move "Documentation/devicetree/bindings/arm/npcm" to
> "Documentation/devicetree/bindings/soc/nuvoton".

To clarify - Rob asked *this one*. Not all.



Best regards,
Krzysztof

