Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA446F6288
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 03:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjEDBCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 21:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDBB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 21:01:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFE1124;
        Wed,  3 May 2023 18:01:58 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F093E6603050;
        Thu,  4 May 2023 02:01:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683162117;
        bh=QIc5SJMWqFHScIbXxCJ80FSyeGnnxhBPq9Nglpv16dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GoF7tKks+0r9w3slMFA52UCUjtZji0S1Ro4Z+f0NOCspw0LEGjEyhfuXwdqEPPBpf
         SobHoYAenMMDr2lVWHc79h7Uf2s2Y9HldVbYu5Aaq2bamlRXs6Uh/3MFwABByfekwj
         WdOuqPQS27hMEc8e9LxER0LliWjfJqcBfs3OafA0RYS7WeRuiD3bPwHE9a2+JM7Ozq
         G+kKuTi09O1TfRRAg51BcdpAFUD4iIJ0T+BL2s+X9pnpRGM8JabIsTIBurfXQMlojG
         jb/rCJ5LASS2Wnxqnrw81mZycTqW4tNO5FuvREGs1fRkx+2ABLIYgdirnRcu+g7gIq
         3EETfeDuWI7KA==
Date:   Wed, 3 May 2023 21:01:51 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     bchihi@baylibre.com
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Subject: Re: [PATCH v2 5/5] thermal/drivers/mediatek/lvts_thermal: Update
 calibration data documentation
Message-ID: <b120f52a-38c4-4f06-86d5-503a67bb1dab@notapiano>
References: <20230425133052.199767-1-bchihi@baylibre.com>
 <20230425133052.199767-6-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230425133052.199767-6-bchihi@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 03:30:52PM +0200, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Update LVTS calibration data documentation for mt8192 and mt8195.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 59 ++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 8df7b4c72a658..3df4989f9902b 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -531,30 +531,57 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
>   * The efuse blob values follows the sensor enumeration per thermal
>   * controller. The decoding of the stream is as follow:
>   *
> - * stream index map for MCU Domain :
> + * MT8195 :
> + * Stream index map for MCU Domain mt8195 :
>   *
> - * <-----mcu-tc#0-----> <-----sensor#0-----> <-----sensor#1----->
> - *  0x01 | 0x02 | 0x03 | 0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09
> + * <-----sensor#0-----> <-----sensor#1----->
> + *  0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09

I don't think you need to remove the controller calibration data from this
comment, even though you don't use it in the code. Could come in handy in the
future.

>   *
[..]
> + * MT8192 :
> + * Stream index map for MCU Domain mt8192 :
> + *
> + * <--------sensor#0---------> <--------sensor#1--------->
> + *  0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09 | 0x0A | 0x0B

Each sensor data is 3 bytes long, just like for MT8195. The fourth byte contains
the controller calibration data, but it is spread across these fourth bytes. I'd
just leave these bytes undocumented for now since they're not currently used.

So,

  + * <-----sensor#0----->        <-----sensor#1----->       
  + *  0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09 | 0x0A | 0x0B

etc.

With that fixed,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
