Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7506FD9A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbjEJIkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbjEJIjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:39:36 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE1C525A;
        Wed, 10 May 2023 01:39:23 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 177DD847C6;
        Wed, 10 May 2023 10:39:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683707956;
        bh=ifV6kOtOMr+sW9m20a/mbeO1rcuLTDom9mda73HleZI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lhBoFhPJeXxrx90BbiZsNvhUQeDDGECz/iU3QHXyifnhUU3xeqgxKmwgCeHkmrbvd
         EMIw4gUNNyyoh6kAhE6iLjG5lNIhHZJFFfTbdKJYpUr2hO4J1xM7zB2o5Mqf8BZu45
         9k8hRO7ufutX4rgnxBEDTi2IQn6jzuRz15dwz62hfUG3bXEcuITMBY+rzjOkiBa/T+
         44cyXo6Ocgh49jcxzZpvCjq0HQlu53Uic3waYETyai+dy1zSsdCcxwoOT0pd8mKF9p
         NjvvJ6eA2+548Nn+2TT6A+U6StrBSXJ+MD/SVksfSSXz5sWCe98xVAQWXHryN9E1Cl
         2uMaX/FohbOkg==
Message-ID: <f848adde-895e-18d5-0e9a-a29de24ae861@denx.de>
Date:   Wed, 10 May 2023 10:39:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: fsl: Enumerate Emtop SOM
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        krzysztof.kozlowski@linaro.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230510083311.3692416-1-himanshu.bhavani@siliconsignals.io>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230510083311.3692416-1-himanshu.bhavani@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/23 10:33, Himanshu Bhavani wrote:
> Add entries to the list of imx8mm boards denoting
> the Emtop SOM from Emtop.
> 
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> ---
>   Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 442ce8f4d675..06eb2c790f90 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -884,6 +884,7 @@ properties:
>                 - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
>                 - boundary,imx8mm-nitrogen8mm  # i.MX8MM Nitrogen Board
>                 - dmo,imx8mm-data-modul-edm-sbc # i.MX8MM eDM SBC
> +              - emtop,imx8mm-emtop          # i.MX8MM Emtop SoM

The pictures I could find via internet search engine make it look like 
the name of the SoM is

SOM-IMX8MMLPD4

or similar. That silkscreen label is right below the EMTOP logo.

Can you please check that on your module ?
