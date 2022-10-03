Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CD55F32BB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiJCPjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJCPj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:39:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5793A2A947
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:39:26 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u24so3025907plq.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date;
        bh=sBjMELHhs7ootP+M1ePzkemYasHrxvoQKWyxZ5SKdJc=;
        b=6TeHRYpKr4iA6ltAvmCjUEoPS1XHVEd06IoCPr9cBmfj4KcCCpxO4crfMKOV3j+ttD
         nSeOZOMohexUm4wDctC02d16DMakiBRtjI4eW7FpPc2+VsURaV8CZmi/Rv50Ju0O6bDZ
         mdJ6TzLmnXN/GWGyzbrtYytsMwPzUJ4T13JD1nY6dCnb/sWc4wLvd3XZoRV5ZBtrJSXZ
         NYuEIairpytFb3UeLbZhZryD3bGVjUZEKacG8YLZDJT1Z/e2blxmqYGhx6Od824QDPR1
         oAdtoO8RRJNF37qDOUwsRz2nYEHUq2YFqJ+davPWQhI4GkSOm08p1XzZO+oufH7CzHlN
         JmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date;
        bh=sBjMELHhs7ootP+M1ePzkemYasHrxvoQKWyxZ5SKdJc=;
        b=Rj1BBz+6gpMxOqMxFY/LET4NZVXV0Msrtr8r8vNaFgQiubSxTF2hyqcQIybjDWLPph
         TjhkdQY8p35XQU+RxJf0lr8Y4WsV748ZG9Xi7JeDxzEX3RCG6RbAu6Vzao+aWjRj6QdZ
         K+JMY6GNlS9BgiL49DpebaRhDsaEolUtWfoxjYlP9d9lbOS/pva4D11d/0zl65lSamhh
         b+J5M+CRF1p715aQAj1BBp6ru4iJ/BYq4sPpgN6vCBORR5ktoeAjZVdFWdz1BSVy0Mn6
         RRZzCd8V9ELog7evE+f/Wd1K0R4TzauFKgxFwsgue2e9quys7cf8Xa8oAWNgvyiBKqO7
         0jiw==
X-Gm-Message-State: ACrzQf1CzUVe8+RSsAK/9Hg9Drka12s9Z8XUX/iQbey1mstqNGS8DWtJ
        SZI/TUpzu54jWZkRi2FpfyjQ2mZyMgHkpgqHjYi0ug==
X-Google-Smtp-Source: AMsMyM67n5/JfkI+ezU4sEpOAQkHL4Lr8SNXTP6tBMjqPf4oPEqHcs7Y4we6Zo0o6qrkQaDBeTf58h4qBuFfOWQ+eNE=
X-Received: by 2002:a17:90b:2643:b0:205:bd0d:bdff with SMTP id
 pa3-20020a17090b264300b00205bd0dbdffmr12433645pjb.99.1664811565787; Mon, 03
 Oct 2022 08:39:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Oct 2022 17:39:25 +0200
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220919-v1-0-4844816c9808@baylibre.com> <20220919-v1-9-4844816c9808@baylibre.com>
 <5920ba96-886c-1195-656a-a98d7b1f6623@collabora.com>
In-Reply-To: <5920ba96-886c-1195-656a-a98d7b1f6623@collabora.com>
MIME-Version: 1.0
Date:   Mon, 3 Oct 2022 17:39:25 +0200
Message-ID: <CABnWg9vdYYgxPxMY=qm=JSd4ZV4hHB7g8M4he3GzUj6-rzmfQw@mail.gmail.com>
Subject: Re: [PATCH v1 09/17] drm/mediatek: hdmi: add connector flag
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 12:38, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>Il 19/09/22 18:56, Guillaume Ranquet ha scritto:
>> Add a flag to indicate support for an external connector
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
>> index 86653ebaacfd..30407603d693 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
>> @@ -199,20 +199,22 @@ int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi, struct platform_device *pdev,
>>   		goto put_device;
>>   	}
>>
>> -	remote = of_graph_get_remote_node(np, 1, 0);
>> -	if (!remote) {
>> -		ret = -EINVAL;
>> -		goto put_device;
>> -	}
>> -
>> -	if (!of_device_is_compatible(remote, "hdmi-connector")) {
>> -		hdmi->next_bridge = of_drm_find_bridge(remote);
>> -		if (!hdmi->next_bridge) {
>> -			dev_err(dev, "Waiting for external bridge\n");
>> -			of_node_put(remote);
>> -			ret = -EPROBE_DEFER;
>> +	if (hdmi->conf->has_connector) {
>
>If MT8195's DPI uses the internal HDMI->DP converter, I say that the external
>DP has HDMI input and DP output.
>Logically, you can't have a HDMI port that's connected to nothing.
>
>Please, rethink this change.
>
>Regards,
>Angelo

Hi Angelo,
Sorry for the late answer.

I have reworked this for V2, to use an hdmi connector device node to "bind"
both the hdmi and hdmi-ddc driver together as with "legacy" code.
So this patch is dropped in V2 (hopefully ready soon).

Just to make things clear, the hardware path on mt8195 is:
DPI1 -> HDMI Tx -> HDMI Phy
DP Intf1 -> DP Tx -> USB Type C Mux -> DP over USB-C

So there's no HDMI->DP converter involved.

Thx,
Guillaume.
