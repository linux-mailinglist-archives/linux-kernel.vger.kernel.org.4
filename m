Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12490645D46
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLGPJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiLGPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:09:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC1A5BD63;
        Wed,  7 Dec 2022 07:09:30 -0800 (PST)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7AF116602BB9;
        Wed,  7 Dec 2022 15:09:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670425768;
        bh=4ObcAHwRV9dxMiI+YLG4qw8GWaJ1x1aWG49BDYqdCII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZhVypiyiGCAUah9pISXuQOnBvkRc5wJnYPkU1ma0YI4PoRIeQ6GdQG03A76BCpv3D
         tvEi393RzUtwjyqGe6hAxVjLcF1I+qcHMakeN2hHWQNc0rN3w0fukJYALVAsiX42lE
         xot0c1btURasXWLlX8BZ5Qm6w+G/E9+psUXnptW1kwguLtEY/2RPI9gtlDVvM8XCs9
         aGa5X3rN9Pkd3qM/zSXIMb+lU37DHNSMpLR4BW0TFaGU6qctpd5Q3+bTwSJTpwJF8a
         dWVGYDpiSr4LfOGyh8MFulAX5t3h8DLnLr9xY8zTBawjWLGt7czNph9x35B0PY5u4y
         w4hGB33sCYHuQ==
Date:   Wed, 7 Dec 2022 16:09:25 +0100
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@collabora.com, bob.beckett@collabora.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com,
        nas.chung@chipsnmedia.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 5/6] dt-bindings: media: wave5: add yaml devicetree
 bindings
Message-ID: <20221207150925.frotwpm3ukwwlnig@basti-XPS-13-9310>
References: <20221207121350.66217-1-sebastian.fricke@collabora.com>
 <20221207121350.66217-6-sebastian.fricke@collabora.com>
 <48d60bd0-4de1-4a5e-eca1-1f8a9303cce0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <48d60bd0-4de1-4a5e-eca1-1f8a9303cce0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof, 

On 07.12.2022 13:31, Krzysztof Kozlowski wrote:
>On 07/12/2022 13:13, Sebastian Fricke wrote:
>> From: Robert Beckett <bob.beckett@collabora.com>
>>
>> Add bindings for the wave5 chips&media codec driver
>>
>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>
>What's happening with this patch? Where is the changelog?

The changelog is located in the cover letter.
https://lore.kernel.org/linux-media/20221207121350.66217-1-sebastian.fricke@collabora.com/

>Why it is v11 and first time I see it?

You actually replied to V10:
https://lore.kernel.org/linux-media/20221023085341.s23qinjuw4qls3dn@basti-XPS-13-9310/

>And why it is v11 with basic mistakes and lack of testing?!?
>I would assume that v11 was already seen and tested...

Sorry I don't have a lot of experience with dt-bindings, thank you for
highlighting the issues, I will correct them. And I forgot to build the
documentation during my testing runs.
I took over the patch set from another contributor and as no one
complained about the dt-bindings for the last 10 versions, I concentrated
my energy on other problems.

>
>
>> ---
>>  .../devicetree/bindings/cnm,wave5.yml         | 72 +++++++++++++++++++
>>  1 file changed, 72 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/cnm,wave5.yml
>
>Wrong directory. It wasn't here at all before, so I am really confused
>how this could happen.

Thanks for the highlight.

I will move it to:
Documentation/devicetree/bindings/media/cnm,wave5.yml

>
>Subject: drop redundant pieces: yaml, devicetree and bindings.

I call it:

dt-bindings: media: chips-media: add wave5 bindings

in V12

Sincerely,
Sebastian Fricke

>
>
>>
>> diff --git a/Documentation/devicetree/bindings/cnm,wave5.yml b/Documentation/devicetree/bindings/cnm,wave5.yml
>> new file mode 100644
>> index 000000000000..01dddebb162e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cnm,wave5.yml
>> @@ -0,0 +1,72 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/wave5.yaml#
>
>You clearly did not test them before sending.
>
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Chips&Media Wave 5 Series multi-standard codec IP
>> +
>> +maintainers:
>> +  - Nas Chung <nas.chung@chipsnmedia.com>
>> +  - Robert Beckett <bob.beckett@collabora.com>
>> +  - Sebastian Fricke <sebastian.fricke@collabora.com>
>> +
>> +description: |-
>> +  The Chips&Media WAVE codec IP is a multi format video encoder/decoder
>> +
>> +properties:
>> +  compatible:
>> +    anyOf:
>
>Please start from example-schema or other recently approved bindings. No
>anyOf.
>
>> +      - items:
>
>No items...
>
>> +        - enum:
>> +            - cnm,cm511-vpu
>> +            - cnm,cm517-vpu
>> +            - cnm,cm521-vpu
>> +            - cnm,cm521c-vpu
>> +            - cnm,cm521c-dual-vpu
>
>What's the difference between this and one above?
>
>> +            - cnm,cm521e1-vpu
>> +            - cnm,cm537-vpu
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 1
>> +    maxItems: 4
>
>This has to be specific.
>
>> +
>> +  clock-names:
>> +    minItems: 1
>> +    maxItems: 4
>
>You need to list the names.
>
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  sram:
>
>Missing vendor prefix.
>
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: phandle pointing to the SRAM device node
>
>And what is it for? Why do you need SRAM?
>
>> +    maxItems: 1
>
>Drop
>
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    vpu: video-codec@12345678 {
>> +        compatible = "cnm,cm521-vpu";
>> +        reg = <0x12345678 0x1000>;
>> +        interrupts = <42>;
>> +        clocks = <&clks 42>;
>> +        clock-names = "vcodec";
>> +        sram = <&sram>;
>> +    };
>
>Best regards,
>Krzysztof
>
