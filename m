Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2CF738A45
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjFUP6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbjFUP6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:58:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67487E2;
        Wed, 21 Jun 2023 08:58:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-989d03eae11so167343566b.2;
        Wed, 21 Jun 2023 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687363125; x=1689955125;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fkqf0P4hP53fHDuWMIl+lIazGqAurWrABHgdRXnNRM8=;
        b=Iq4tgOlnHbDkozry1066t2fSyv0XhhDPM6sAwawV7e0zWFb/GHJX06sG9nj6iJ/qg9
         RhBfvPCgsfuKLcJ1aF48rq2tkRtPXTJRD7l/L4KyPKF1AvZnVMcm/sihdYFvF427Levx
         oQrtL9xf/CQg/+TMKk7cUBMIecBJypPnm/DgjiPnfHWaEHFtwfqEMsUeBvtvVyrpo/t0
         4tKA7zzyo5E7GitYiY6JxTOHwS98hvaH4gvfIWN5+RQEj8fUde16e4mM1j1k97rYaOAu
         btm5E7/WKtgqi+Yg7fpSc4yzKqROpAVeqEZzTYZvE+ToBthIwNGIJgFmUaRub8UTyHNB
         DNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687363125; x=1689955125;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fkqf0P4hP53fHDuWMIl+lIazGqAurWrABHgdRXnNRM8=;
        b=WDdCLlD3QjdR7oEm5N+0ADdfuDssKfVnlIzJkj4D47c7zJjksZuHfSIOG+Q6QEdW5o
         U/D66/PmUbVyWxRA1ZkGWLU+fzImhl7DiupQ9SK667qEjWO1cnKqsWqSZjT7MxsuBelr
         Kq1kHwT0TpLMxAQSKNM63zvbTK3zd18RbSObufpi2Ma35k8Xss0bqT7qQHwH8zFp+w0I
         0Xwi+0vcSAinUOsX8DwtGWoyGOHoQmO5UtkGotTpZTMJlfm5YBP/3Sd4R22F2zB+GESS
         Kpx38YkSe0jS3T3PJ5JqL7iuZkYTT0DYI1WRv1DJt7s8lx7IqULtgRex7jhgZj1U6gUQ
         Mi1A==
X-Gm-Message-State: AC+VfDyvR1CQVONE2FQ0dH8nhNQ1OyCmLxS0OV/7lEzq0CkkBofhVCm+
        W274WkD11551TlQgPOlvs+4=
X-Google-Smtp-Source: ACHHUZ4/fg1RHtDXDMWSO1/GyosQC8Hct5EcPmksND7zZyyUhHFBHs/92K+FRCuKw/WTGy2R2mFM6A==
X-Received: by 2002:a17:906:ef0c:b0:978:ab6b:afd4 with SMTP id f12-20020a170906ef0c00b00978ab6bafd4mr15173161ejs.43.1687363124687;
        Wed, 21 Jun 2023 08:58:44 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709060a1400b00977eec7b7e8sm3349316ejf.68.2023.06.21.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:58:44 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH v3 0/3] usb: misc: onboard_usb_hub: add support for Cypress
 HX3 USB 3.0 family
Date:   Wed, 21 Jun 2023 17:58:29 +0200
Message-Id: <20230620-hx3-v3-0-2acbc03ca949@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACUek2QC/22Nyw6CMBREf4V0bU3pLUVd+R/GRV/YRiymxQZD+
 Hcv7EhczmTOmZlkl4LL5FLNJLkSchgiBjhUxHgVH44Gi5lwxoFJzqifgBp9hkaLztpWElxqlR3
 VSUXjcRs/fY/lO7kuTJv6dsfsQx6H9N2eSr22e2mpKaOgpDhrEObU6Gt+BqtGdTTDi6yGwv9QH
 KlWqgYEUm0Ne2pZlh9mrSYO4wAAAA==
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This series adds support for the Cypress HX3 USB 3.0 family (2/3). For
now, it just contains the USB-related aspects and ignores the option to
connect it via i2c (3/3).

As the HX3 family operates with two power supplies, multiple power
supply support is implemented (1/3).

Thanks & best regards,
Benjamin

---
Changes in v3:
- 1/3: fix nits mentioned by Matthias
- Link to v2: https://lore.kernel.org/r/20230620-hx3-v2-0-76a53434c713@skidata.com

Changes in v2:
- don't re-order by VID/PID (thanks to Matthias)
- 1/3: replace (err != 0) with (err)
- Link to v1: https://lore.kernel.org/r/20230620-hx3-v1-0-3a649b34c85b@skidata.com

---
Benjamin Bara (3):
      usb: misc: onboard-hub: support multiple power supplies
      usb: misc: onboard-hub: add support for Cypress HX3 USB 3.0 family
      dt-bindings: usb: Add binding for Cypress HX3 USB 3.0 family

 .../devicetree/bindings/usb/cypress,hx3.yaml       | 77 ++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_hub.c                 | 42 +++++++++---
 drivers/usb/misc/onboard_usb_hub.h                 |  8 +++
 3 files changed, 119 insertions(+), 8 deletions(-)
---
base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
change-id: 20230620-hx3-cb935b4fdd76

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

