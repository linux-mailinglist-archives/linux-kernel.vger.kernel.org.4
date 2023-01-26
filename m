Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8F267C5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbjAZIfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjAZIe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:34:56 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E302F6C10C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:34:14 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t18so983107wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlqKECMrN5ozKYgnpBSVs1svty0s1OqnEzEGJQmggnk=;
        b=F9+ov4mncbiNtHgLPztkYJ4XH8nsjAvNgkanwZuNh10EX5zuoi756weIdsxKMLGJgj
         xtLXLXWr7k6np6eXfCdVdBSrEK1jbru/hPzALeCbGZmwTswYLkYeKvWJMpFD0XyZfYkz
         nblGty+oTnk7J3QTi0Cai6jB7XGu+CggxNktAFa4wiHK5Ie134MFt3JpNENKzKLI7TDa
         bgA84SV3BvWciZ5I1z5tEx98gfX1cfeGdI23QAzV+hILWzzyE4UonQsDYu3dl069zEqT
         OFJXW0HPVtDQ1aiTNuKZe25e0B6kxma07EkP99B2lnoEAKVZ1pF+cbXtdJmcGc91Uedd
         +myQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlqKECMrN5ozKYgnpBSVs1svty0s1OqnEzEGJQmggnk=;
        b=GHEjr2wsZQ4SnGqfJ1lOvaPpiHeduvyFL/gDErO4xiEeIbfi2tq5kk2PkfvnL+gZWh
         yasec94uqPXfeT5t38k85koX/P/cBwuLuSofZBo/J720Id8hGpz77xKZ8femAi6FoKyn
         MtMYJwI9ukXHDdC/4MObjOTyVEM7oYVbJxf9x3YZCRSl/n5XtHBdUNaLidcOB18aCI+l
         zEZSuKSvOmKVcCvgdaaX1AUpcgKBqA1IEdc3hxuxAmSqjUL44O6oEE1Pc+PohGtw+tTJ
         gtCW2ZsPLknJ8z34TrUt8Xsir50QVAtdB1/CxxAJiYP/q5GtwFxfAomb7uR6Jims7Ihh
         siIw==
X-Gm-Message-State: AO0yUKVWK873sydhbJZRXQslur5v9f//iLaUv5urs/xh/oY8k6Pfh8JV
        1gunEfqsuk3NyUQs7vhHK1UWOw==
X-Google-Smtp-Source: AK7set+xHB6a7B1HespUte5I/SZh/YUocrutxsx/3SykXNry9Wqg5Bt6sYFifeuZxs9o029TLj8Mvg==
X-Received: by 2002:a05:6000:104a:b0:2bf:ae18:34dd with SMTP id c10-20020a056000104a00b002bfae1834ddmr8506123wrx.56.1674722040060;
        Thu, 26 Jan 2023 00:34:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c328a00b003d9a86a13bfsm757709wmp.28.2023.01.26.00.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 00:33:59 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230124-b4-amlogic-bindings-fixups-v1-0-44351528957e@linaro.org>
References: <20230124-b4-amlogic-bindings-fixups-v1-0-44351528957e@linaro.org>
Subject: Re: [PATCH 00/14] arm64: meson: bunch of DT fixes
Message-Id: <167472203923.456104.10228308469675767029.b4-ty@linaro.org>
Date:   Thu, 26 Jan 2023 09:33:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 24 Jan 2023 11:34:21 +0100, Neil Armstrong wrote:
> This is a bunch of fixes against the current applied and reviewed bindings.
> 
> It takes in account the following bindings conversions:
> [1] https://lore.kernel.org/r/20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org
> [2] https://lore.kernel.org/r/20230124091602.44027-1-krzysztof.kozlowski@linaro.org
> 
> Remaining fixes will require a complete TXT to dt-schema transition.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.3/arm64-dt)

[01/14] arm64: dts: amlogic: meson-gx: fix SCPI clock dvfs node name
        https://git.kernel.org/amlogic/c/127f79212b07c5d9a6657a87e3eafdd889335814
[02/14] arm64: dts: amlogic: meson-axg: fix SCPI clock dvfs node name
        https://git.kernel.org/amlogic/c/5b7069d72f03c92a0ab919725017394ebce03a81
[03/14] arm64: dts: amlogic: meson-gx: add missing SCPI sensors compatible
        https://git.kernel.org/amlogic/c/2ff650051493d5bdb6dd09d4c2850bb37db6be31
[04/14] arm64: dts: amlogic: meson-axg-jethome-jethub-j1xx: fix supply name of USB controller node
        https://git.kernel.org/amlogic/c/a69cb1042cea840bc7b60fea1c26a6b259e68bf2
[05/14] arm64: dts: amlogic: meson-gxl-s905d-sml5442tw: drop invalid clock-names property
        https://git.kernel.org/amlogic/c/e3bd275ccbacf5eb18eaa311cea39f8bf8655feb
[06/14] arm64: dts: amlogic: meson-gx: add missing unit address to rng node name
        https://git.kernel.org/amlogic/c/61ff70708b98a85516eccb3755084ac97b42cf48
[07/14] arm64: dts: amlogic: meson-gxl-s905w-jethome-jethub-j80: fix invalid rtc node name
        https://git.kernel.org/amlogic/c/11172a97c092eaeb0a65c6434df0fc73f886a495
[08/14] arm64: dts: amlogic: meson-axg-jethome-jethub-j1xx: fix invalid rtc node name
        https://git.kernel.org/amlogic/c/956f52025c5dd92c80c12e31c99c854086a6fc55
[09/14] arm64: dts: amlogic: meson-gxl: add missing unit address to eth-phy-mux node name
        https://git.kernel.org/amlogic/c/d19189f70ba596798ea49166d2d1ef36a8df5289
[10/14] arm64: dts: amlogic: meson-gx-libretech-pc: fix update button name
        https://git.kernel.org/amlogic/c/6bb506ed36968207a8832f0143ebc127f0770eef
[11/14] arm64: dts: amlogic: meson-sm1-bananapi-m5: fix adc keys node names
        https://git.kernel.org/amlogic/c/d519a73332b6c3d14e15f8fd20d7c6f29ed13d41
[12/14] arm64: dts: amlogic: meson-gxl-s905d-phicomm-n1: fix led node name
        https://git.kernel.org/amlogic/c/eee64d8fbbdaab72bbab3e462f3a7b742d20c8c2
[13/14] arm64: dts: amlogic: meson-gxbb-kii-pro: fix led node name
        https://git.kernel.org/amlogic/c/afdef3b188c934f79ad4b0a7bd8c692742f9b5af
[14/14] arm64: dts: amlogic: meson-g12b-odroid-go-ultra: fix rk818 pmic properties
        https://git.kernel.org/amlogic/c/ce9999722656f2433af9029571bc2b99448dda74

These changes has been applied on the intermediate git tree [1].

The v6.3/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

