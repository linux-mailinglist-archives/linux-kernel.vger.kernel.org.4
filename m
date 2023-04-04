Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C7A6D68DD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjDDQaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbjDDQaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:30:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EC04699
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:30:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l12so33428729wrm.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680625807;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4JapEkf/UT9+KWLrxkEtmxGD1gUOAOOQVFLyzKKIc8=;
        b=Z+fCacJ8PpEfPD1lGzf+YS9NIJl7aTWfjQfFyHjysRF7Pd2RHn0S2P/zKFwyX+bIIj
         7TXeu7pbkWsw6JoLT9cuY/IheNiaG7nA+KIjcIzugpmXx4SJ3hHrSvNkbOfv775JT7+u
         wtNLPw8TiXZtsQ37cBPe4Ef9cqKZvpF7H80UI/qBLZS1Ajmqeg/wfJh5IJEDA03NFelX
         +RY1bopAsuzkcUMDgOsEPsL8YsAXXLLjBzXLgFa/gGXIP1j+KBCny0z2wvaLFNG9gVCZ
         jIXQUHt6sVjgEurNhaWE65iBSrlh6ROxMpXo59WfVmUY8cqbRPJsbEiCVJr1RWYWtxnL
         Au6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625807;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4JapEkf/UT9+KWLrxkEtmxGD1gUOAOOQVFLyzKKIc8=;
        b=cUCEOtLGiTkdGpjEhGCA6GYGVDl2oGNaRMQK0gxYkKhbRoW+XdtOWqehuGk30pjuo7
         hG+4K3qP7db6cRE+Q81541mh8SWi0xRn4TgmvUsmxULaM9xlVQwLuSnj7zPD0dIW3jh+
         R3b2TocrTVST3p61+ziqON0oORKFjoMj3XDH5sSz/oj2P4N4MnaFXHZrKMl/OqKowdtQ
         fjEbpxiATCu9vlPrqzPNT2uFral3+3IGpsAUDsPGPMhnQ3W28evqAhjMXk+lWKwgMix/
         F93FK53rcO9cUkaL7sgR+ouaQkDvSrTpKyPPNJmuFx0gG7B+weXD6i/5d0gtI+EDQZsv
         uOzw==
X-Gm-Message-State: AAQBX9c6b8g7wW4htGx9/I0lg95d1Pov7EoW4KnNbftTMQrDFfrE5FOI
        vAxFkbQRO0h/l0oCKXAcrawlyQ==
X-Google-Smtp-Source: AKy350ZoiVI7akDEh1OhkqF9VC8rPnE07T8s4AvG4xojXwVhdyFwAyaiaP0bKaAkpCu/gp6xU3CEoQ==
X-Received: by 2002:a5d:44cd:0:b0:2c7:c9e:2c41 with SMTP id z13-20020a5d44cd000000b002c70c9e2c41mr2170876wrr.57.1680625806717;
        Tue, 04 Apr 2023 09:30:06 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id o7-20020adfe807000000b002e4cd2ec5c7sm12694528wrm.86.2023.04.04.09.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:30:06 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v3 0/3] Cleanup Mediatek pinctrl device tree binding
Date:   Tue, 04 Apr 2023 18:29:48 +0200
Message-Id: <20230327-cleanup-pinctrl-binding-v3-0-6f56d5c7a8de@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHxQLGQC/42Oy2rDMBBFfyVo3Yn1SFSlq/5H6UKajOIBRxaSI
 xqC/71yloXSLs+FezgPUakwVfG2e4hCjSvPqYN52QkcfboQ8Lmz0FIbafQr4EQ+3TJkTriUCQK
 nM6cLOGkP3kUXonWiv4OvBKH4hOP2v+Wh2b2BgmpY5sw4XBdn7HH4xbcpcqHIX8+4j8/OI9dlL
 vdna1Pb+ndWUyAh2NORjKZD1PQe/H3iUGiP81Vs2qb/qdJdFbWKAdFIZX+q1nX9BgNBjDpPAQA
 A
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2037; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=eKZr5omVCsYju6vcJ05uFu7hEJ9ODIzf7Yvw8lgbKMo=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkLFCN6bpzQlgZZBk2XVT33Zav25Nt3Wm0eLurukKG
 9x1xzgWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCxQjQAKCRArRkmdfjHURUIOEA
 CLpCFGeAVoWK6G6NgVYU3JTNmjXKIiQBBXX+TNNkh2ve+U3vQmk29RUNgra8P7BPoUQ+s/YrxNbrz+
 yFYMAEoMV3UsWm3NxnYPIMwhTPDISLgpfRIo87oqB4NvdqcwlwfxfP+fcnHmFJYpiu6iEtaNb5ADnr
 /WkidBWLOH/m5ShcQ8GsL4yp2lcPJ6QcL9N4H/c3n++b1/hO0v9oKccmj08gbu1KRVdpMXS026s5FP
 aQNhSAAbG/DY10+w0N50P+4Knw4w8DBOAxPwLt7FCXRBpWTX/QFjKqrQW4UEER5MdMVI9A2hdIL5lM
 jeag5+t1a11qvM1lb207hyT0SrY7xQ6+gvLn+aL/eQUQ7ZnjBkeVg/XCRVcbm3Ay+dsBwazUEbktPM
 sQWdDgJ/yhWA+VSTNlLj2EtVGu+RN+muXOPmyoBE0qQmdLL7SOePRpOWvvD1e6kr2kDsNuSC9qEv4V
 1jFEv2f9h77Za6TRKVH/DowBhO2ah1jifDYyw9Ich2QsjnHSyOUR1tBLcrGlr+OjUkBTluH6DnZ1yO
 TRsRg8Eu6ic/yZYMTc+MtWOWooIbqfsvVJByZYsTJ+qscyC2Edc3Zi4xbqGMaQhP/tHBk26auyZCEx
 wfKQNYLisYQNiCSvnj/Li0Tdsf0a/tbTgdo7U31omZ4IpSucoOSP/d8WnB1A==
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

Another commit has been added in v3 to make it easier to merge. [2]

Thanks AngeloGioacchino Del Regno to reported it. [1]

[1]: https://lore.kernel.org/all/6e08d78f-ef4c-b228-f7d2-d63767ea87b8@collabora.com/
[2]: https://lore.kernel.org/all/20230203-evk-board-support-v4-2-5cffe66a38c0@baylibre.com/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v3:
- Port another commit which modify the pinctrl from this serie [2].
- Rebased to linusw/linux-pinctrl as requested by the maintainer [3].
- Link to v2: https://lore.kernel.org/r/20230327-cleanup-pinctrl-binding-v2-0-f21fbcc3016e@baylibre.com

Changes in v2:
- Change the bias-pull enum values to match with other Mediatek SoC.
  That allows to use MTK generic define and be compliant with the MTK
  common pinctrl driver.
- Link to v1: https://lore.kernel.org/r/20230327-cleanup-pinctrl-binding-v1-0-b695e32e4f2e@baylibre.com

---
Alexandre Mergnat (3):
      dt-bindings: pinctrl: mediatek: deprecate custom drive strength property
      dt-bindings: pinctrl: mediatek: deprecate custom bias pull properties for mt8365
      dt-bindings: pinctrl: mediatek,mt8365-pinctrl: add drive strength property

 .../bindings/pinctrl/mediatek,mt8183-pinctrl.yaml  |  8 +++-
 .../bindings/pinctrl/mediatek,mt8365-pinctrl.yaml  | 43 +++++++++++++++++++---
 2 files changed, 43 insertions(+), 8 deletions(-)
---
base-commit: 743d3336029ffe2bb38e982a3b572ced243c6d43
change-id: 20230327-cleanup-pinctrl-binding-8064a8f8bf68

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

