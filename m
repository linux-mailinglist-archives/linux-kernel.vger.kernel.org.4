Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7077765BFBD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbjACMSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjACMSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:18:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75563A0;
        Tue,  3 Jan 2023 04:18:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45F42B80E46;
        Tue,  3 Jan 2023 12:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CE7C433EF;
        Tue,  3 Jan 2023 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672748297;
        bh=Avbtatmn2oCDfdQYMRTRfQ5ZfoGXDNhE5Ig0SHUTj9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hlDOU0xL8Fuo3Ou6gLKN7HM3b7hvMkPkRF6RzGQzP7CamivRed4I9vdiIEViWuzCF
         OidBdzeUT6DcgMy6E6l0rpiPWQQAZ4FEss6tpW5TFjmV271+Os+CbniGZEDlOYFXmU
         x6TrduuG6B5n9R3HHZyOtywv6OBI07Yn9vP3SBeqyVnpx+pi6z7StAWz1oAEmH+p+K
         eBjYHtZH0ua/KrDAXxliIqEfvHdK7YOaP61gNO6pnCL7VSv38gSeTzT+6WYJH+hrC7
         Jgc8dGOWdIxDO/8jJ1u/WeX11pgBA7Z3Y+C7x5uB4MXRkwmiA0GHcOFKQV/nmLGjav
         vO5m+QTf7Xl0Q==
Date:   Tue, 3 Jan 2023 12:18:10 +0000
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: leds: spmi-flash-led: Add pm6150l
 compatible
Message-ID: <Y7QdAqZNpVFDbmlG@google.com>
References: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
 <20221209-fp4-pm6150l-flash-v1-1-531521eb2a72@fairphone.com>
 <Y6WiQKRI/YCbMBhA@google.com>
 <e1fb7474-d029-8004-709d-1d0b437f192d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1fb7474-d029-8004-709d-1d0b437f192d@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Dec 2022, Krzysztof Kozlowski wrote:

> On 23/12/2022 13:42, Lee Jones wrote:
> > On Fri, 09 Dec 2022, Luca Weiss wrote:
> > 
> >> Add the compatible for the flash-led block found on pm6150l PMIC.
> >>
> >> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >> ---
> >>  Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> > 
> > Who takes LED DT Bindings presently?
> 
> Preferably Pavel and/or you. Rob was taking only on exceptional cases.

Works for me.  That's the case from now on then, thank you.

-- 
Lee Jones [李琼斯]
