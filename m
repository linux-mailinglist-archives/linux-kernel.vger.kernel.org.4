Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E412E675EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjATUTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjATUTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:19:46 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C0C15C87;
        Fri, 20 Jan 2023 12:19:43 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D641B851E6;
        Fri, 20 Jan 2023 21:19:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1674245981;
        bh=v5AOm9XLy9ZP+mr27J1UwycJewxzF+LwaqfxtMsHc+k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Spz4L6H9toBJpQ4c6p1Isw1Fto/fI8bTGEcIYCfKntE/a5xrUINWMJc5JaxcG/hQ1
         GNBIOMvwIQZN1acuwnuJaZGY+nkWIWat06TqZpaU1CYSYp4iw0aje6PWd9kQpV1iy4
         b7xhLXlEotlbhLCIZTFcr9qGvbvafJm+Raj+HKkq1xCt4CY7wiogBhXaUfH40PzK9l
         xlG/qCoVkmJG0V1stkuTz2eaFQWOUZAb1whLPRO8op7iRn7oTQPFCeslFKgnX7LHku
         7cdqHPnBriqHwOnozALRT7rJQaKYSFZaa6DE715pnY6akf12mi9sIot+HXH3d5R3WL
         dIDhqsHw3xtcg==
Message-ID: <4a3cc3ce-ada3-842e-5afa-c89653f537a6@denx.de>
Date:   Fri, 20 Jan 2023 21:07:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V4 1/4] dt-bindings: arm: fsl: Add PDK2, PicoITX and DRC02
 boards for the DHCOM i.MX6ULL SoM
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel@dh-electronics.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230120184731.11215-1-cniedermaier@dh-electronics.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230120184731.11215-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 19:47, Christoph Niedermaier wrote:
> Add DH electronics DHCOM PDK2, PicoITX and DRC02 boards
> for the DHCOM i.MX6ULL SoM.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>
