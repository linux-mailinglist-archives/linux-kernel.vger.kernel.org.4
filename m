Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5783E6E8F94
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjDTKLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjDTKKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:10:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C68583D2;
        Thu, 20 Apr 2023 03:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C3A4646CD;
        Thu, 20 Apr 2023 10:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A866C4339C;
        Thu, 20 Apr 2023 10:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681985250;
        bh=53QLwZPPKzJH40ikLifxF/eEvsi/41eaVa72AdqOWj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fy54VTkK9JsIVbHK59MJW7TKmajmZH4XSyhXzKKmmdMJAkwMf7+2LFsx8+cuS+zbJ
         7jm45I/rRK+JeOw1WOpBhRn+2l/zonfj4h3LWrNE/4gWAcoYgFNbX+pX+LSRi0a4E3
         pxVhipwvhuM6EVsV/1XsVZnDCBOO0Is3sIpPGoDYZEVR3N/S9hhdvT6dDyB77nJq2V
         ZpTcrGn2g2SB0xQyi92qYmh6B3Hbr2cVrmtHXiEAifxGwGoXkpxKDzU6WmedfusJcn
         NRCXTVvdGbTzAZSKW26rgl6f/9dEvHOGYMnBJFtLGs+RKCS3vixvF9ligiFRW7HdGH
         +gDxtC8ucgW1w==
Date:   Thu, 20 Apr 2023 11:07:24 +0100
From:   Lee Jones <lee@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: leds-qcom-lpg: Add qcom,pmk8550-pwm
 compatible string
Message-ID: <20230420100724.GD9904@google.com>
References: <20230407223849.17623-1-quic_amelende@quicinc.com>
 <20230407223849.17623-2-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230407223849.17623-2-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Apr 2023, Anjelique Melendez wrote:

> Add qcom,pmk8550-pwm compatible string for the Qualcomm Technologies, Inc.
> PMK8550 PMIC which has two high resolution PWM channels.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
