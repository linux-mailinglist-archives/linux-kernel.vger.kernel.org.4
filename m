Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362CD61EEA1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiKGJTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiKGJTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:19:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5466477;
        Mon,  7 Nov 2022 01:19:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ACB960F46;
        Mon,  7 Nov 2022 09:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2455C433D6;
        Mon,  7 Nov 2022 09:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667812783;
        bh=6Nx7JDwmY/apf1WMX6YISTNpp3UAtiSL9C8XwycAYTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lO0/lhqbioWDTQ/5vtK84wlT34ZgObkWs9sKdEuTkY8BNneqaclvfW3i3qsuPEXyp
         bMl6PpxFyQU1l8pfYzdAthVgWTQVgd1CUFOuom31C2owGUBUbctk9cmQRQHwv/o6Wj
         +Cdh7jISPD2SWN4GZfCuaoIIvUFrFZ5pVw0un7uhoygpZLLfMx2C75dwYMDpFBQObW
         UMMXML2+UoRUX1Fujk1WhMTrGBlMX45qcOEFuc5IxIvixDO0aBwE3q3J7ZYPVYty9H
         g8ZPR9if40EI8Dx9dZaJhGZQRcMbR2olZ7MejPt72Z9j55X+gOOVnshEJEHU0Ul3kN
         r+LCCU5RQBkpw==
Date:   Mon, 7 Nov 2022 09:19:36 +0000
From:   Lee Jones <lee@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: backlight: qcom-wled: Add PMI8950
 compatible
Message-ID: <Y2jNqChLjixM9grL@google.com>
References: <20221101161801.1058969-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101161801.1058969-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Nov 2022, Luca Weiss wrote:

> Document the compatible for the wled block found in PMI8950.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes since v2:
> * New patch
> 
>  Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
