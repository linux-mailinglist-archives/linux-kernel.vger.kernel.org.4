Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE446DED23
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDLIBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDLIBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1345BB6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F6F962F0C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2B0C433D2;
        Wed, 12 Apr 2023 08:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681286478;
        bh=w+fDHyGA2Dx4oxvOT8Xypp7j8bq//woB4d7hUqvw0wM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=DXjoKmjeo/8qDoEBcA/LmoTNuFI7f/8M5ZckdmqoHa0Fx2s7YwhSK96dC6NePLX6s
         C/clA+Rt88k4rosxKJ+mzUm8LwMbbeoa5hRbdoT2x6+5LyyRhzMxqXV+tyYt/lqpar
         bUY6ytc/sb9S3/XzoWhRW4SGpOYqsH+tngSCL5gowBWK3blaqPyLiYx/0gDQWbFsay
         bODCfTT79AFGbHxfb88BxICeAK3jmZ5+WwHNjpva3OuWRkPaWo3k+xiZO9vZwuNE65
         uFDGxT8KofmCRXMylNzOkwm65Atacim4/3DehkUY5HPlJpM0+2GTXUcRKXcvYPXlGa
         dTZ+6JLZCPufQ==
Message-ID: <c7274fe2-27ed-25fc-fde5-eb6c136a73f3@kernel.org>
Date:   Wed, 12 Apr 2023 10:01:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [NXP ELE-MUAP 1/7] doc: device tree binding addition for ele MU
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gaurav.jain@nxp.com,
        sahil.malhotra@nxp.com, aisheng.dong@nxp.com, V.Sethi@nxp.com
References: <20230411162536.30604-1-pankaj.gupta@nxp.com>
 <20230411162536.30604-2-pankaj.gupta@nxp.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230411162536.30604-2-pankaj.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 18:25, Pankaj Gupta wrote:
> Documentation update with addition of new device tree
> for NXP ele-mu (Edgelock Enclave Message Unit), driver.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,ele_mu.yaml    | 90 +++++++++++++++++++
>  .../devicetree/bindings/mailbox/fsl,muap.txt  | 89 ++++++++++++++++++

I have troubles understanding what this patch is about. And to whom. You
missed several mailing lists, wrong subject prefix, bindings in TXT are
not accepted.

Maybe it is not for Linux kernel, then it is fine. If this was for Linux
kernel, then just NAK. Please follow Linux kernel submission process.

Best regards,
Krzysztof

