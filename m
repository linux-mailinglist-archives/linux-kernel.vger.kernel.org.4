Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDDB6597F1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 13:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiL3MDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 07:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3MD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 07:03:29 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A23E1A072
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 04:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1672401630;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=9Z6rhz3xhVtCnOws5cJg8Yt7TrbTu3QnfEu/OT2wWIU=;
    b=dbV1dOEJ9YmY2tyq4gkAwd5Sox5nTsyoMAHJvFzLqaM3wogQ1qF0zUWZh6DAPlgJjQ
    9KyBEsmvz3dgLoDqC9bl3UvvA7cpiJ5GhzpxVNAlpTgi6RAAejZPEcxfDpLf9VM0o67k
    pluoLrO3p4Z9EJngTQb63+gasWG+YkuFbEcrb6e8SwHlJIFCjEAJGDNR80fFG391daJ4
    YnPip5jQZndXRELwq6+mm21/gnjv9gx5nXvbCLPB27jg9euh35xAuuNQJ7FMIfdepUhw
    vRhTBIRq7RFqtd0nnqizZkb5MZ1jOAPBxEpRbJmU/S/L8vuR6A6n10MODDxbFy0t6rTQ
    Mguw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWwfOntQ=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Yce349yBUC0PYxI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 30 Dec 2022 13:00:25 +0100 (CET)
Date:   Fri, 30 Dec 2022 13:00:19 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     wangweidong.a@awinic.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
        povik+lin@cutebit.org, pierre-louis.bossart@linux.intel.com,
        james.schulman@cirrus.com, flatmax@flatmax.com,
        cezary.rojewski@intel.com, srinivas.kandagatla@linaro.org,
        tanureal@opensource.cirrus.com, steve@sk2.org,
        zhuning0077@gmail.com, shumingf@realtek.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhaolei@awinic.com,
        liweilei@awinic.com, yijiangtao@awinic.com, duanyibo@awinic.com
Subject: Re: [PATCH V8 5/5] ASoC: dt-bindings: Add schema for "awinic,aw883xx"
Message-ID: <Y67S07ghnNTuJcWg@gerhold.net>
References: <20221230093454.190579-1-wangweidong.a@awinic.com>
 <20221230093454.190579-6-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230093454.190579-6-wangweidong.a@awinic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 05:34:54PM +0800, wangweidong.a@awinic.com wrote:
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
> index 000000000000..b677427ebcd1
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
> +  - Stephan Weidong Wang <wangweidong.a@awinic.com>

Is my first name still meant to be here?
You should probably drop the "Stephan" :)

Thanks,
Stephan
