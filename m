Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A822571F256
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjFASr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFASr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:47:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA80184;
        Thu,  1 Jun 2023 11:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ADE5648F4;
        Thu,  1 Jun 2023 18:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E71C433D2;
        Thu,  1 Jun 2023 18:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685645276;
        bh=fVjc52DgTmVCguGiqHepclOHP4NJQnP3xLsnGWkh1PE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=slZrOVS0E3fquNv6gBY+gyixBQRylb9m65A7tMUpHHn0fPj77WHxR+imKa9hdRZyx
         1NNH/S+y68N8uJ/r5tDPQJKsr5aQbpz17+L4l2OgI/NApZxK2SHr0vDjem62FdjOlm
         Hgw8ClLUdDGpAKpYwGgIQN5tSOogD1NlHsYwAeFgJKhTHQRX2lqTtgBLuw96/Ko87f
         1Fw+kC622B/yV0D3Szl5OrxldbgyYTO9fQdIQuMsl1w/P7Tv9E8O3/0kc6mJJSuPJo
         Td/uxxE5mhAjnfgYagsVryqQMfv0gz+OSmkMGiLioPgb9EbSu5Fk+JTmHg5e1rKXZX
         bXJZ9e79UbVIg==
Date:   Thu, 1 Jun 2023 19:47:52 +0100
From:   Lee Jones <lee@kernel.org>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@sberdevices.ru,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: leds: add binding for aw200xx
Message-ID: <20230601184752.GJ449117@google.com>
References: <20230519130403.212479-1-mmkurbanov@sberdevices.ru>
 <20230519130403.212479-2-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519130403.212479-2-mmkurbanov@sberdevices.ru>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023, Martin Kurbanov wrote:

> Add YAML devicetree binding for AWINIC AW20036/AW20052/AW20074
> led driver.
> 
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/leds/awinic,aw200xx.yaml         | 126 ++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml

Applied, thanks

-- 
Lee Jones [李琼斯]
