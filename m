Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695185F56E6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJEO6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiJEO5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:57:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC7B644A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 07:57:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b4so19404208wrs.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=s+CLRBFlSL1ov10J+uevk8iYtEx5Lrr8EaQpxu9a9Lw=;
        b=4z/dLjviSn7zfqdTN/An5N64z93GP96nvU8QRIvaYA7odlZMjwUHVN6eNxxdrMPrTF
         zOsLFff+wqUSKIPA4wuRlkMFxK2E4/RZZH9F1mFy9dD6+/rPQa2MeZYYHiTcGggS7YEv
         ctp693yr5qI6oa4Njx1ye4WdADunUaSaFrKpT8nCZW/C0wW3ZPBFJBPPkk5orqKrpYXc
         7PAgEciHcSO9UJrDjUY8VY7Irn/eA0r1la8im9xFi96VbTvxoCVGkEM+BnSfeVMcR6nG
         ayGpTe52F8676sFV6owNJ07xum0tjvkJ+IAvWh+BA7vXRJTiVZxxvzzKwW98bhJkJrIl
         UQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=s+CLRBFlSL1ov10J+uevk8iYtEx5Lrr8EaQpxu9a9Lw=;
        b=rA7zt7lZIszJ0TGwWuuqfZA/zWFH65taqg4JtlkJyMpK5Z4utat8V6uRF3zoE3wl19
         11KuyYr7X5bIcKbSKARFZhYhG667/zkF6+nLBKKw7CIMeNyvR6YU45qOkrqzwt9FogeK
         bhcZ6c6iytU1nQbEQGTVDaSAFHszW9CL6U+1DCoEwmDI+aVQmzh0XwYsWpIYkypZcVFG
         LusAJUoBpCv/48OyGB3uXx/eNSh7UrRIcFMS3e694YjwqO4CRw1gveTizF1pBUWZyWuj
         kX3QiqpkT2Bu22AhoK33P7zHdEecEvYb1hsEsYkLJkf93wKTIa+HAwhqBUtZTzAKn/k7
         JAug==
X-Gm-Message-State: ACrzQf2uEeOaRDXqP9QxqJ/zpWYB5IZuk8tg4VEuNRnYVcJRM6PqdKhj
        EW+f7Tuit8Ru0ZKhN7cBCUD4ng==
X-Google-Smtp-Source: AMsMyM4K9uNjIUEU5oRVePb9o4GJMjsAIa3NMyBDwIbvtm4ZY+x3YXOjJGnKtkk8Wpa5pBXt11tq4Q==
X-Received: by 2002:a05:6000:144c:b0:22b:dda:eeb0 with SMTP id v12-20020a056000144c00b0022b0ddaeeb0mr73656wrx.335.1664981862771;
        Wed, 05 Oct 2022 07:57:42 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id k38-20020a05600c1ca600b003a3170a7af9sm2313758wms.4.2022.10.05.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:57:42 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 05 Oct 2022 16:57:22 +0200
Subject: [PATCH v2 2/5] dt-bindings: input: mtk-pmic-keys: add binding for MT6357
 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v2-2-f17ba2d2d0a9@baylibre.com>
References: <20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com>
To:     Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=868; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=Vrvq5OBgHsKlbdllLY5D49KrDviTWoLwSjjxQY9UWKQ=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjPZti3Z21O1HcABDeF3kwXbl2TleR4abbscroKfXG
 a0kzo7OJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCYz2bYgAKCRArRkmdfjHURTjmEA
 Ce29Lt9aj+iS11MB92BXYIkIumWqKh5Zn/Ghtco3wKqQz9pd/vOJFQeU2eNpiXVAn+cmwKck3z8JC4
 NhVWR4kkGpcauGXddoiXuJQQZiGVBfDlCx1f6y8x+mCdMLlPTNyT1VTuidevjBFJdzm1TcGQ3gaI2l
 PMIueAByEfHYIOLCEeOFz2RKzMPco2Q7PMJlMKyAx4MsgX35IhE2m7U7tP+pjsSuoHWavHcyUO1THZ
 pdAGj4CyESudF54PZxIKbVWxmJAi6CbUPjEnl6rrBxhQHuC+K+cwHnpYjZBxdYVyK4Xf+Mx5ElaSx0
 C6dgmUEiir3yya5qO7g7zULwYYX3nn+e3jB9/UgdLxa9qxDmZHKYyLd6AxBzhVMEmYY6FaZhiBGI00
 hJvcAmw0Dp1+4D9Z1S7ISfl7DTfH5Qeno/5sIJDEtRsSDZqOuWwRnOhChPe+0TKicwfDm0RcvqHkUh
 a0Jn8pKpd7HiLbrpYc1DAkWP79iBMx1VzppNf2MDiaRhmBAuW7N5V+P+c1iwcS3BV15h9lMS89ZknK
 WU5C1jvMa6A2V6pGigCQyDM6GxVvvyWwpG5TfTZPh0ETl4SkweipjpPCUR+zc3vM8EzdVyOqGSOP43
 3Up2YYYxH0GxqjyLHtgSzpU56en4HPZysFTQ/EbHy42Sm70bsBmSO4zwSt1w==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add binding documentation for the PMIC keys on MT6357.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index 2f72ec418415..037c3ae9f1c3 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -26,6 +26,7 @@ properties:
     enum:
       - mediatek,mt6323-keys
       - mediatek,mt6331-keys
+      - mediatek,mt6357-keys
       - mediatek,mt6358-keys
       - mediatek,mt6397-keys
 

-- 
b4 0.10.1
