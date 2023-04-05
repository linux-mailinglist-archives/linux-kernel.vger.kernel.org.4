Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150396D83A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjDEQ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjDEQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:26:44 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A1C173C;
        Wed,  5 Apr 2023 09:26:31 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5B97C8003E;
        Wed,  5 Apr 2023 18:26:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1680711990;
        bh=MasDIk0i1VKzIO8h7LaFBm8cLhLTMLMuQl3cfPsFVF8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m9Xpdep3bvpQdlA/exhvi2G6IyPBqK39fKdSg495LIsod7OgGgns+/THwaIRiJAjy
         edbmVpw2y+W392HkggprhCXKAtuaThRRQ8bmniU4lhFuCvq5DU7F+Hyaz7cNrsylaK
         +58l28uf6b85SkxCMVecY9yIYFRQsGCVr11zW7Lk46+d5ssBnovRg2V8rQLWX9BIw4
         aMkaof98xqh9fDiDMn2mdCv9Q8GQ3dcN0+kejgZ4OdI1ag7lLfy8GStWD5tXip4Zur
         +Ymo0b4o6T5RHJ3aaneloDz7AFEZyNPwTpWXsFLSC1Axg+3yxKF6GONqm+HSz2Ksju
         X6iw4TX5VVFbQ==
Message-ID: <842f1d7f-29e5-d1c3-f949-322f3f954b68@denx.de>
Date:   Wed, 5 Apr 2023 18:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add Marantec maveo box as a
 DHCOR i.MX6ULL SoM based board
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel@dh-electronics.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230405160258.46998-1-cniedermaier@dh-electronics.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230405160258.46998-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 18:02, Christoph Niedermaier wrote:
> Add Marantec maveo box. The system is used to get a smart conntection
> to a door drive. The core of this system is a soldered i.MX6ULL DHCOR
> SoM from DH electronics.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> CC: Li Yang <leoyang.li@nxp.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: kernel@dh-electronics.com
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
>   Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index b175f2b1bd30..c95254c57571 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -717,6 +717,12 @@ properties:
>             - const: dh,imx6ull-dhcor-som
>             - const: fsl,imx6ull
>   
> +      - description: i.MX6ULL DHCOR SoM based Boards
> +        items:
> +          - const: dh,imx6ull-dhcor-maveo-box

This should be using Marantec vendor prefix, not "dh," prefix I think ?

You should add that to 
Documentation/devicetree/bindings/vendor-prefixes.yaml first, and then 
use it here.
