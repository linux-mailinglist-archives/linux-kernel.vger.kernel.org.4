Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456E06D26D0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjCaRjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjCaRjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:39:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334A5F779
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:39:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l12so23198831wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680284354;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gku3WqCXL8jtCOkhxTxIv+f+mV0YZMt8NBkxJPbbls=;
        b=3QTbfLbY/h37CSPq/kZacyHAAHcHzWjomoaAGiBSO9/7zmmsp9uzEnhWuVLynxSCzo
         FrXzSxKXtVbic3O4gIbtKLzhBINFPJwDKqzQ6MrgwwTkaNvmk8Xf6zqcHm6nuwKs3Ctu
         N6+s4QNCR/G2REsINFejqtnwxLbvvPo6xm4C9K3a03UIOtPzNa1Roj9YN8rJmatVyrpo
         CpWs7OQhS9oQHzugb4Q9yi2PX5T+WYxFtMWzjVAUNmX/JPOSiG+gVorPjcj7bN9uD6HY
         5W7J7Kqtamyq16vuPh5xBGbEDlenlLt4+aDzMx0adrpRweOSPU7DnDKC+3HgNQxvEsP1
         oV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680284354;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gku3WqCXL8jtCOkhxTxIv+f+mV0YZMt8NBkxJPbbls=;
        b=xObP2AkQN/KwgYQgTnYt+JT6He7JDZ5TG9RLWIrQTbeRjZkErAN+CoiJ6KsqI8Cz2U
         o+Y3trxSDXgCAWo0CMQ2yDJ5IOKNiYIlHg3h1dHYHEKYezR0s7tNzOvrwIMgLXEf9IAn
         wmCc9BdU27FOmX+WgWnBpTtbP2T/wcpr3cUjMcHjX0zBj3mtIEj8j7OQbafh5o9Gc400
         SjPFWRVadhrRqSAZ1QBXDaRfZdy+YCNeSIPu2k7T8FU/fywdyCh/377cnCauS00DcM4C
         JIsoYeMLJOJ2BGSFQNgn6jJUyNa6pXWSKCZNUmPZwfC9+/dBg3sNdEp2JQ/h41rFu0Jl
         k8hA==
X-Gm-Message-State: AAQBX9ebWps9lEh+hZEpylkx14Hm42+WptTcuXEVvdamOj3n+Yea5lHK
        sPhvE2twzEC6z3EG/b/HDkawvg==
X-Google-Smtp-Source: AKy350Yew0GXPvS8KCRlzsw4CGrZLmLXYTX50Vz2INKAr0R16PRplJOTqMjtA/u6fHFCax0UfX2dZg==
X-Received: by 2002:a5d:6b4b:0:b0:2dc:2431:67d0 with SMTP id x11-20020a5d6b4b000000b002dc243167d0mr21570490wrw.19.1680284354663;
        Fri, 31 Mar 2023 10:39:14 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id o5-20020adfcf05000000b002c592535839sm2733550wrj.17.2023.03.31.10.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:39:14 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 0/2] Cleanup Mediatek pinctrl device tree binding
Date:   Fri, 31 Mar 2023 19:38:58 +0200
Message-Id: <20230327-cleanup-pinctrl-binding-v2-0-f21fbcc3016e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALIaJ2QC/4WOwQ7CIBAFf8Vwdm0LiujJ/zAegC7tJhUI1Mam6
 b9LvRuP85I3mYVlTISZXXcLSzhRpuAL8P2O2V77DoHawozXXNSCn8EOqP0rQiRvxzSAId+S70D
 V8qiVU8ZJxcrb6Ixgkva23/6vWE3yICDZphpDJFs9RyXkqfrh2xQxoaP3N+7+KNxTHkOav61Ts
 63/s6YGajDyckLB8eg43oyeBzIJDzY82WNd1w8eBA+SBAEAAA==
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=abFoXlAdYBElssUUK3ytRFD/kuTvFa6mt+xUmikwoXo=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkJxrBrmACDFTBwfeXO4FOXsae1zXEjlbNcQk2W1Ul
 J+/qpRGJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCcawQAKCRArRkmdfjHURReKD/
 4tIbrADlmxKAJLhNOlh2lQjWW410UBYdho2DqDP3rdpmw4dfli5sqfB2EQqt7dKtfxga1OL/wVdiIm
 a5DO1mJ8KPJcM14YKwFB5A1mfLppUjAlgXtl74KYZr//6wuQb+QxUrm01hNEu3EKof5lCEJIGJmeKy
 YF6dkoCZM9hViBilRM1S9hvocXb8Azw5hbbgwqebPmwxvVAo3G6hlFBbWyTFvnjA9wtVTDm9oliIQV
 K0futyUqZDzefYlrgGEfyrZaPYhUhEGTA0cprOeBlwkTXaXLNOxyzOePuMCzhMTfbkgIElwaQolgYl
 P6Vo3e5seGqkUG31TpEL93jA9zgS85CEgevEXLJrLFcpnVOWjrCYS+KukzmWYrv9uQbU2RZznMHCCz
 CWHBSzj2MjLZNom6WSwzV3nxOmQf+gKzDz2PECGIuGCUnrRbK7bl/Cy5m9SWGF7oyJwYKJdoDUUcJV
 OY+hFVX2LSWc7ebPHJBRsxb6nzUKbx7sNf/9n6UQRteX4bdhE4WCgw0WgPYMC0a0DgAYGD+JR35nhF
 /tR/W7LxS+42RejEwb6rfxo2WUHAD/QFENRt10g9oVnpVH4oZzTY1aM1AQGlxxVAtN+One6Uj3XNMj
 +bME9jPllXttQp/Gdd+EIp5QMFORiHaz7ktomF8vcClqJD/Xho2+LRYjQ6rg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate properties which shall not exist, leaked upstream from downstream
kernels, there's no reason to use them. Here the deprecated properties and
the generic properties which will replace them:

- mediatek,drive-strength-adv => drive-strength-microamp
- mediatek,pull-up-adv        => bias-pull-up
- mediatek,pull-down-adv      => bias-pull-down

Thanks AngeloGioacchino Del Regno to reported it. [1]

[1]: https://lore.kernel.org/all/6e08d78f-ef4c-b228-f7d2-d63767ea87b8@collabora.com/

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v2:
- Change the bias-pull enum values to match with other Mediatek SoC.
  That allows to use MTK generic define and be compliant with the MTK
  common pinctrl driver.
- Link to v1: https://lore.kernel.org/r/20230327-cleanup-pinctrl-binding-v1-0-b695e32e4f2e@baylibre.com

---
Alexandre Mergnat (2):
      dt-bindings: pinctrl: mediatek: deprecate custom drive strength property
      dt-bindings: pinctrl: mediatek: deprecate custom bias pull properties for mt8365

 .../bindings/pinctrl/mediatek,mt8183-pinctrl.yaml  |  8 +++--
 .../bindings/pinctrl/mediatek,mt8365-pinctrl.yaml  | 38 +++++++++++++++++++---
 2 files changed, 39 insertions(+), 7 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230327-cleanup-pinctrl-binding-8064a8f8bf68

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

