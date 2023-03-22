Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AEE6C47C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCVKhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCVKhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:37:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E7452F57
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:37:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so5933576wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679481449;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKYLrq+5xwL1z16Mh5XU//Z6+05o9hLc+yFcwb23nzw=;
        b=nIplk97TeH7s+5D3Rmts/MtAbjzzuACevDUBrI+1Pdu1oDIiCu1a8mnlmYZNS2VOQc
         Abcg1Pvjf6oLCbxA138GEtQnf7olIWuJWd8gnlK0+E7WWMMZ0a1TPuEEIOvfnG86dEwI
         dL/W/TJqhn9qlVbYV6hX2Q57FnhlurwWngY2qBZuHYu/kvRmm6TVGqIK2MqGDar1aIRa
         NSN2bLSz6R/K/3MfDVlnu5q/4RKAOLll1S3+7XFJ6NATqdkY3HnRwCoY6Y6EaMkXWbDr
         geRakNa2tT0nP1slz+QHeuWYHboy6dznMuBOKrgbUIZDROsJoFCId8wtmRhpzh0oGTI/
         2xJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679481449;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKYLrq+5xwL1z16Mh5XU//Z6+05o9hLc+yFcwb23nzw=;
        b=VzRuz+zt1SOg8tJ2gVI31aZMtFA4wyPoRXz5FoQryT3kehU4eoMPAhzG+PzpFfq6SS
         Q7Q5kvCr1pHqX33dKDmB4OYDa8+YVQDJ5BRFwsiCEIvJ/qJrNdTvE9Tkx7UbCKZhuM8U
         KiIOjs+CuikD6VN7oNDn7DX2jiI9TbMsQheN1Avtq2wSRHpnTmjAcn4KXfWYBqsMDpjt
         Fl1aZeAYnRv9CXqHR4wN9joDOHtsG/Wa1Ed+620rzSL7hHy4GhYrZ7wGpayPlF+T9FFL
         F3sf3qh7BezKGXIbe+s/AA97QLIoUNAuh6lbJR+HKbqMEBAH5iEGZRUeV53KQb+0MQjl
         cEsg==
X-Gm-Message-State: AO0yUKUAFfTUeBU0nY2iEm9yucCqz317mYxG8Hcw3ouQQ0GipKzilgZg
        KZgGcr2lsZAymJs5BW1sVhXQkA==
X-Google-Smtp-Source: AK7set80COadYMouirUYRTlnim/M4RpQYkRgCOJPyehYwC9cBwlz7KywIEwJcQneN0x0XeiFZfMJnQ==
X-Received: by 2002:a7b:c845:0:b0:3ed:df74:bac7 with SMTP id c5-20020a7bc845000000b003eddf74bac7mr4640727wml.21.1679481448726;
        Wed, 22 Mar 2023 03:37:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id z23-20020a7bc7d7000000b003ee1b2ab9a0sm6116422wmk.11.2023.03.22.03.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:37:28 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230321171213.2808460-1-martin.blumenstingl@googlemail.com>
References: <20230321171213.2808460-1-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v1 0/3] ARM: dts: Enable WiFi and Bluetooth support on
 MXIII-Plus
Message-Id: <167948144797.3811038.2142379553878713661.b4-ty@linaro.org>
Date:   Wed, 22 Mar 2023 11:37:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 21 Mar 2023 18:12:10 +0100, Martin Blumenstingl wrote:
> MXIII-Plus comes with a Ampak AP6330 Bluetooth and WiFi combo chip.
> The 32kHz clock is provided by the SoC and is enabled by simply using
> the correct pin mux.
> Also this is the first board which uses the SDXC_A for connecting to
> the SDIO chip.
> 
> Other than the two new pin muxes this is just a matter of describing
> the hardware in meson8m2-mxiii-plus.dts.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.4/arm-dt)

[1/3] ARM: dts: meson8: add the xtal_32k_out pin
      https://git.kernel.org/amlogic/c/4ca4a633205fb372882de3e6e93a0a3584298249
[2/3] ARM: dts: meson8: add the SDXC_A pins
      https://git.kernel.org/amlogic/c/ef8474d50a37ab5f2f2f60e179d749b4273470de
[3/3] ARM: dts: meson8m2: mxiii-plus: Enable Bluetooth and WiFi support
      https://git.kernel.org/amlogic/c/8446b84c894f7441f8bf4410f9638e38dcb29c49

These changes has been applied on the intermediate git tree [1].

The v6.4/arm-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil

