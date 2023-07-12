Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A5E750B84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjGLO5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjGLO5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:57:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A9819BE;
        Wed, 12 Jul 2023 07:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=StVhosqjQMYv0ZshIKprVX9ygBpNqy+bhfO5eQ6rmxY=; b=Se3kptrBwtSU1KXt3hRwbpQIT0
        G7zanPOjdZym2S4mAwXVxLpJ7eLi2bJfXPDvPlNGi9CUYMQXJGOz8xEMUQbc4hbIJNL+hIG76AIQM
        x/sKZe7BrubR7DpwAWto2eQvGjrLjickWgVPJX5noMXdTakfPZcoGcJL3B4mNUzfFhIWLLTLfxs3n
        k+0iKB9UqOqHKtOUuVXT1ZxIhNsEdLUEOmyAZL/GGYOun1vganeBMMXJAieyQ14XgWuNXZ5G92Fhy
        Ztj6Q5MxUfzU8Iz8834O14TMSddc8XlafNIbTijT0ZBQBqLgAGgpYvohV5W/ACwzx401lQH4Yjveh
        CtOw9Emw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJbHh-000Fwy-1e;
        Wed, 12 Jul 2023 14:57:41 +0000
Message-ID: <6d712362-a0f9-7395-fbc0-e6a51eee9bcb@infradead.org>
Date:   Wed, 12 Jul 2023 07:57:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 7/7] MAINTAINERS: Added maintainer details
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, clin@suse.com,
        conor+dt@kernel.org, pierre.gondois@arm.com, ping.bai@nxp.com,
        xiaoning.wang@nxp.com, wei.fang@nxp.com, peng.fan@nxp.com,
        haibo.chen@nxp.com, festevam@gmail.com, linux-imx@nxp.com,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-8-pankaj.gupta@nxp.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230712121219.2654234-8-pankaj.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/12/23 05:12, Pankaj Gupta wrote:
> MAINTAINERS: Added maintainer details for se-fw driver.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdfe8ecc..654c1628417d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13620,6 +13620,16 @@ F:	mm/
>  F:	tools/mm/
>  F:	tools/testing/selftests/mm/
>  

Nope, this is not in alphabetical order. The MAINTAINERS file
is to be kept in alphabetical order.

> +NXP EDGELOCK(SECURE) ENCLAVE FIRMWARE DRIVER
> +M:	Pankaj Gupta <pankaj.gupta@nxp.com>
> +R:	NXP Linux Team <linux-imx@nxp.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
> +F:	drivers/firmware/imx/ele*.*
> +F:	drivers/firmware/imx/se*.*
> +F:	include/linux/firmware/imx/ele*.*
> +
>  MEMORY TECHNOLOGY DEVICES (MTD)
>  M:	Miquel Raynal <miquel.raynal@bootlin.com>
>  M:	Richard Weinberger <richard@nod.at>

-- 
~Randy
