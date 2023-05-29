Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45A27145DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjE2ICj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjE2ICf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:02:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFFEA7;
        Mon, 29 May 2023 01:02:33 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 79C1C6605961;
        Mon, 29 May 2023 09:02:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685347352;
        bh=A4ZNREQoh5/KC7x7Aai+h2epscmtPk1u6BBSzcPw1yE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dX6SHWyOxgUzPCOpqEMFwfU+oDrE2Q9SSL6ricQ3zd7lGcaD3r9IwZdbfbjLB40Ik
         Sp4UqpDoKXrblE28lnsvwltd+8w2d1o57AMCrzERi6Zr3wrjVGUhC+zN5y5Tpk1kD6
         eOpc8OW1TZ+ytBLa4U0aLa/o2vJCU+gXldjU5EoOJB8mUwz08lgUMnRqyw811AxiRX
         k4EIiiMVX3rQP1iElyi+w4xNvoFcIfxZAzWHGN+5I1x9LAg0ZCUnAp+6f3dN5rJ7BN
         X6qv/9KC+Oc3PFU/EKQzH+OcXUw0LAmu+4wh/6fRoIt/mkdD5khf6bc9v01SLa+C3B
         fLDu65wLzWeSg==
Message-ID: <f4a9e090-3712-200e-bd09-70090c9cccbc@collabora.com>
Date:   Mon, 29 May 2023 10:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt8173-elm: remove panel model
 number in DT
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        Pin-yen Lin <treapking@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20230526100801.16310-1-uwu@icenowy.me>
 <CAD=FV=UxrFVZXn+dtgamttTVopWMSVbxYsHCGG_tS+3OTXbHiw@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAD=FV=UxrFVZXn+dtgamttTVopWMSVbxYsHCGG_tS+3OTXbHiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/05/23 16:24, Doug Anderson ha scritto:
> Hi,
> 
> On Fri, May 26, 2023 at 3:09 AM Icenowy Zheng <uwu@icenowy.me> wrote:
>>
>> Currently a specific panel number is used in the Elm DTSI, which is
>> corresponded to a 12" panel. However, according to the official Chrome
>> OS devices document, Elm refers to Acer Chromebook R13, which, as the
>> name specifies, uses a 13.3" panel, which comes with EDID information.
>>
>> As the kernel currently prioritizes the hardcoded timing parameters
>> matched with the panel number compatible, a wrong timing will be applied
>> to the 13.3" panel on Acer Chromebook R13, which leads to blank display.
>>
>> Because the Elm DTSI is shared with Hana board, and Hana corresponds to
>> multiple devices from 11" to 14", a certain panel model number shouldn't
>> be present, and driving the panel according to its EDID information is
>> necessary.
>>
>> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> We went through a bunch of back-and-forth here but in the end in the
> ChromeOS tree we have "edp-panel" as the "compatible" here in the
> ChromeOS 5.15 tree and this makes sense.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> ...in theory one would wish for a "Fixes" tag, but I think in previous
> discussions it was decided that it was too complicated. Hardcoding the
> other compatible string has always been technically wrong, but I guess
> it worked at some point in time. The more correct way (as you're doing
> here) needs the DP AUX bus support and the generic eDP panels, both of
> which are significantly newer than the elm dts. So I guess leaving no
> "Fixes" tag is OK, or perhaps you could do the somewhat weak:
> 
> Fixes: c2d94f72140a ("arm64: dts: mediatek: mt8173-elm: Move display
> to ps8640 auxiliary bus")

I remember I didn't change the compatible to panel-edp because it didn't
work at that time, but it does now... I'm not sure what actually fixed that
and if the commit(s) was/were backported to that suggested point, so I
would leave the Fixes tag out, as that may break older kernels.

Anyway, for this commit:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
