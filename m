Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2F96EE15C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjDYLwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjDYLwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:52:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF5D5592
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:52:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2f7c281a015so3424735f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682423535; x=1685015535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ynfAkeFX9c4haFlIH8rjLILNLDWXZve/Fuy+x2osLE=;
        b=udOp2foTMQVRgEFYvPui0UXPktfpmgf9DnmHlYw28zFZpUt4aRefOBlXkfsJSNS1Rv
         m7vNfkWjflKoLxkvDrs2qvRd4hxhXnUu5tOuNjtDFxG/C5hdyExewyNfldOgEe8eGZGz
         WjTjQKqOTXd9HU3tBla6kSCcCkBkXayQNNOvajSISxhHsQ+PDm+mxipncRwkTL25ZWXW
         FD6FmNW2LhM8HXyrG3SC7kakHbzutytO1dACL8Q7tOi77/OzHhMLu6X8Fk1Vp+R3w2bA
         E23sOM0BpsOTRt7EVnrHjFhLU9J690tU9u9GZc72oBCzWUWGUe1UNPLuu2B7EJG4pvmW
         QhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682423535; x=1685015535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ynfAkeFX9c4haFlIH8rjLILNLDWXZve/Fuy+x2osLE=;
        b=PPVpy0wAshxb8VX4nSdH2EHquvuq3tdR2hi+r926gHOaDUZkF0EU887TZOb4m1CeO7
         j9oK8Hdbsfd2JSV0CF9VE2pWVcaxqps0j2m0CcpHw940lsZeR7rcHk1IIhnWkbomwzx3
         s2yWgmM2QTvYk0wQblD/5O3rjn7+ocV+YX5tR/FcN0crLAKLQxVmyOh63tgDBsSI5SPO
         iOVc2vtPI6JUInOpQGA0dhosTjL63whyJfNEOwTwhwHzZ0j9qph3LNZz1iJqKzY6BEJ7
         E/NuVb56eIb46CIAlH8FJaclbYHb+jlMobE2wiAoAIpReoxSir3y4iYiDxJjLyR6Dyvw
         GfFA==
X-Gm-Message-State: AAQBX9ebYLnrdRvx72bcPrSIJ5hH9MA1bgYphNAvGhmqvgk7B1GSQAc8
        QH4qKPut2RDAqE6QH4v2imAgvg==
X-Google-Smtp-Source: AKy350YKmxiieIO+e/m8YrSHDxSa31rJy03V8/Gu3qee+b4TvG7KAopUN9dSLHD5NOyEXf8np1sQbA==
X-Received: by 2002:a5d:6d4d:0:b0:2ef:c0cf:c72b with SMTP id k13-20020a5d6d4d000000b002efc0cfc72bmr12109033wri.29.1682423534889;
        Tue, 25 Apr 2023 04:52:14 -0700 (PDT)
Received: from [10.101.1.6] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a18-20020a056000101200b002e61e002943sm12948461wrx.116.2023.04.25.04.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 04:52:14 -0700 (PDT)
Message-ID: <5657cc31-b547-a48f-d090-68ca240a4076@baylibre.com>
Date:   Tue, 25 Apr 2023 13:52:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/4] arm64: dts: mediatek: cherry: Enable PCI-Express
 ports for WiFi
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com>
 <20230424112523.1436926-5-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230424112523.1436926-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 13:25, AngeloGioacchino Del Regno wrote:
> On the Cherry platform, a MT7621 WiFi+Bluetooth combo is connected
> over PCI-Express (for WiFi) and USB (for BT): enable the PCIe ports
> to enable enumerating this chip.
> 
> Signed-off-by: AngeloGioacchino Del Regno<angelogioacchino.delregno@collabora.com>
> Tested-by: Chen-Yu Tsai<wenst@chromium.org>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

Regards,
Alexandre

