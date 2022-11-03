Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC776179B3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiKCJUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiKCJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:19:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5BCDFDD;
        Thu,  3 Nov 2022 02:19:19 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E63B766028F8;
        Thu,  3 Nov 2022 09:19:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667467158;
        bh=M5O9/BCrWTrkOySMMphlKg4mAjD2Nfo1FUdwjlTecWk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CncGJbw++/sDS5qmxAD4+iJ2XknKwtwxKT01wNdwIGnaX6LlNI9tChQ8S3Wle5Iqh
         y/Jgy/GTy0ZZqJ0oTFP3NyNCdvWKnW1Uckq8zXrigY5ep8h3Nja60dK2zsKQ2Onzmz
         JuMXfz/i26ZGrFDwXcq30uQwrfS1mAVG+qUYfu+HUJa4rksaB7ivdmlQ1QbMaIUDCQ
         EYY0zXzn9WvEdC6s4dK3dnhRtKTYqocRoci+mn3WDLdk1YxAdohefJMvxvLxn8bnZF
         mER16CqRSHK41KD36Qh/+ioNec47BjMqtkWh2SKxx5eiGa0GphJpf3iYEzrL1lgDII
         npWttR9BR5QiA==
Message-ID: <cbeb2bdc-4a36-1f9a-e28f-842773b6a161@collabora.com>
Date:   Thu, 3 Nov 2022 10:19:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] docs: dt: writing-schema: Document usage of CHECK_DTBS
 make flag
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Rob Herring <robh+dt@kernel.org>
Cc:     kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20221102214300.309347-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221102214300.309347-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/11/22 22:43, Nícolas F. R. A. Prado ha scritto:
> It is possible to run checks on a Devicetree by passing the CHECK_DTBS
> flag when building. This is a useful shortcut to the dtbs_check make
> target since it avoids checking unrelated Devicetrees, which can take
> some time and is unnecessary if no bindings were modified. Document it.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>  > ---
> 
>   Documentation/devicetree/bindings/writing-schema.rst | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
> index 4a381d20f2b4..55ad556472b4 100644
> --- a/Documentation/devicetree/bindings/writing-schema.rst
> +++ b/Documentation/devicetree/bindings/writing-schema.rst
> @@ -167,6 +167,13 @@ setting the ``DT_SCHEMA_FILES`` variable to a specific schema file or pattern.
>       make dt_binding_check DT_SCHEMA_FILES=/gpio/
>       make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
>   
> +Note that ``make dtbs_check`` will validate every DT source file that is

"Note that xxxx" looks a bit repeated... read:

Note that ``dtbs_check`` will skip any binding schema files with errors.
(etc etc)

Note that ``make dtbs_check`` will validate every DT source file ...
(etc etc)

Perhaps we can change the first paragraph saying
"In order to perform validation of DT source files, use..."
to something like:

In order to perform validation of all DT source files, use the ``dtbs_check``
target, or set the ``CHECK_DTBS`` variable to ``y`` when building specific DTs::

::

     make dtbs_check
     make CHECK_DTBS=y mediatek/mt8192-evb.dtb

Any opinion?

Cheers,
Angelo
