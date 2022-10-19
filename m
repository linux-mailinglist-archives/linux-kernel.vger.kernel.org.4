Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4044E60377A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 03:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJSBUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 21:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJSBU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 21:20:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC20DBC630
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 18:20:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id q9so36529181ejd.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 18:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=q2ct2IaP52qS/4bb8sgrxvkMuYncIYxIrW6dY2N/NU8=;
        b=COSNVYEdJI7+oIGyrQr8374OeogvM3MlIXQ/D9YhIBvUCGN0j1r5kcnG2HKdo4GJc/
         dvBmI6GiDKeaSLdOlRYnVf0od0TkzqHLkQgmrtojq1g/Yak6R8/EoVd3qVUcC8uLk/U4
         1+31iZOwApg5XnfjwRPRWKAwzeskGOTS7sMg8c2XZerGj6m4Tx/ZWYaGCUFg2MGHyv1X
         OlgXD7rik84xSqn8en59Des+GIC+HMs1Q2m5TEkLe8CZSsvNHcCMAlzzaoyc09CiTscH
         kgaRbp2tubvSF4gny03h9NXVgeoxAViHxUIhqnSfk9yqNiGPEp4m9jhVU75ykUx+mmy4
         AHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2ct2IaP52qS/4bb8sgrxvkMuYncIYxIrW6dY2N/NU8=;
        b=gkCjPpQOyj0ZITFXse0mLHPhsCHo+ndPhoQmO78C+AHCsASpbbXngn5vqePW+qpZOK
         dPyCDk1xVaI7kd2vdHmmiJRzbTHhlpS52tTz7MvwjZ117d4UlAb9JsWa+A8BkZS+Ic99
         h6DxsR+XKojEpcL7Kxnz2C/LZWZGYoYVUOkcy0qsYtTCYloADvFIz/QLvz7xoDie+9Oe
         W4bANYUnHAyWv0j7UzaNRrdNaIfyzJUO6zIWGXJ+hRIEldnfvaazukxx7W9/8N7ZN4yt
         sBG6Z/ETlDLBxSmN4oYjvfdDz6nmI3palzMxypo3li88T+YMKPoDZPzZLwY9PKIwJxqW
         oP9Q==
X-Gm-Message-State: ACrzQf0RIVG/xj2BhRT+zqoI+tBLto1ZKi7xRwzMIlc0RsTyPzfRDdsj
        gznssh+Tpv4JF91aNHyjveg=
X-Google-Smtp-Source: AMsMyM6BdNA8+z4lXSFUoebKOIRosFmoq2otzD2jWdhCDTw3eRMtcKebqA9hz9FR4VjlBDVDBkU12Q==
X-Received: by 2002:a17:907:2e0d:b0:78e:1d21:8001 with SMTP id ig13-20020a1709072e0d00b0078e1d218001mr4602332ejc.246.1666142425222;
        Tue, 18 Oct 2022 18:20:25 -0700 (PDT)
Received: from localhost (188.28.2.210.threembb.co.uk. [188.28.2.210])
        by smtp.gmail.com with ESMTPSA id d9-20020a170906370900b0073022b796a7sm8286838ejc.93.2022.10.18.18.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 18:20:23 -0700 (PDT)
References: <20221018230409.610538-1-aidanmacdonald.0x0@gmail.com>
 <87h700u2sr.wl-kuninori.morimoto.gx@renesas.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, spujar@nvidia.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ASoC: simple-card: Fix up checks for HW param fixups
Date:   Wed, 19 Oct 2022 02:19:37 +0100
In-reply-to: <87h700u2sr.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <xqJhkVSkypEjXLHM2nTiM6gHnxhl1J2B@localhost>
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


Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> writes:

> Hi Aidan
>
>> The "convert-xxx" properties only have an effect for DPCM DAI links.
>> A DAI link is only created as DPCM if the device tree requires it;
>> part of this involves checking for the use of "convert-xxx" properties.
>>
>> When the convert-sample-format property was added, the checks got out
>> of sync. A DAI link that specified only convert-sample-format but did
>> not pass any of the other DPCM checks would not go into DPCM mode and
>> the convert-sample-format property would be silently ignored.
>>
>> Fix this by adding a function to do the "convert-xxx" property checks,
>> instead of open-coding it in simple-card and audio-graph-card. And add
>> "convert-sample-format" to the check function so that DAI links using
>> it will be initialized correctly.
>>
>> Fixes: 047a05366f4b ("ASoC: simple-card-utils: Fixup DAI sample format")
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
> (snip)
>> +bool asoc_simple_convert_is_required(const struct asoc_simple_data *data);
>
> This is not a big deal, but "is_conert_required" is better for me :)
>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto

That sounds better, thanks. I'm sending patch v2 now.
- Aidan
