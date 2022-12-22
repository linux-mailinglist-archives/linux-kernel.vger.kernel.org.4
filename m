Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01369654451
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiLVP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbiLVP11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:27:27 -0500
X-Greylist: delayed 174 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Dec 2022 07:27:26 PST
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D05065E8;
        Thu, 22 Dec 2022 07:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1671722665;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=SxW45KTnLVIUUtB58HOiMPr3gJUSP+a3USQoYmqm660=;
    b=ZdynYWx1d5lNzCF7wuaAEBEZhKVYdg/qTLCLWyN4nWAKVT8+A3bmtLvUZGpDBZ7SE7
    VS8BSTnGM24tKW/GFRvToNePN26aR8b2500LyR+v8D8hO186FmjwjVWiJNeS+I5bOYmN
    SMFNFqiGT+Xtnystihs4R7C151S8efhYS8YH1jJO9LX1sESDgMPFHzu8UdPdhHDFI2D3
    dlH2ROaZjI4fEfDFrPQx2Jep9Y9RrSfxCP3GDKFQigiSHOKYKRbyp/JRCnjnxorvhstg
    lL26aunMiQNOTi0Kmfq6GGkMtJp8fIRFJECMLURHRIe7LneY/xKWkSlsoOxNDAVuoK+p
    5Mpg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWyvDI"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Yce349yBMFONKEU
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 22 Dec 2022 16:24:23 +0100 (CET)
Date:   Thu, 22 Dec 2022 16:24:15 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     wangweidong.a@awinic.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
        peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, james.schulman@cirrus.com,
        flatmax@flatmax.com, ryan.lee.analog@gmail.com,
        jonathan.albrieux@gmail.com, tanureal@opensource.cirrus.com,
        povik+lin@cutebit.org, 13691752556@139.com,
        cezary.rojewski@intel.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        liweilei@awinic.com, zhaolei@awinic.com, yijiangtao@awinic.com,
        zhangjianming@awinic.com, duanyibo@awinic.com
Subject: Re: [PATCH V7 5/5] ASoC: dt-bindings: Add schema for "awinic,aw883xx"
Message-ID: <Y6R2nziLaN3OyEo6@gerhold.net>
References: <20221222123431.106425-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222123431.106425-1-wangweidong.a@awinic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 08:34:31PM +0800, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Add a DT schema for describing Awinic AW883xx audio amplifiers. They are
> controlled using I2C.
> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  .../bindings/sound/awinic,aw883xx.yaml        | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml b/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
> new file mode 100644
> index 000000000000..af4e0e27f8f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/awinic,aw883xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Awinic AW883xx Smart Audio Amplifier
> +
> +maintainers:
> +  - Stephan Gerhold <stephan@gerhold.net>

Please add yourself as maintainer, not other people you found in similar
DT schema files. I have no idea how this hardware works. :)

Thanks,
Stephan
