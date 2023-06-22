Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9569573992D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjFVIRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFVIRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:17:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E32B1A4;
        Thu, 22 Jun 2023 01:17:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso9019319a12.0;
        Thu, 22 Jun 2023 01:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687421850; x=1690013850;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0DzipTyigmcnKRgL/H9VZ7Sy0jmnx1tEYnZrj5BCUr0=;
        b=PVd1ZlViI8bWNdjN2EFJasH8vjw0PoHt7WcH9H1WIEipxwgfkg5g1YEEnuv0LflNHx
         itKw4Uk0AStwpJAeZwOlfcAnc0bu8g9EUQ0oOyVkj+oWAS8CHXRatfNbtA34IMVQnoAC
         ZEfjsK9Nqeb7cVr6sQVgLqndcAQ2s5li9ahAmftgM67wGSulESMnDiPxUIi3vR91H3te
         qNHoJQsaA9nlbsu7euuNWy7qQYNUijY44uWYW592rBFD3arIxZBl9JSgpCBCZ3jymom9
         BaKEn6626Lm3z6w/QW69dGneGrcv/uCokmBW9pNglEOx2xpoUsGiGurqMtrAbZjB/p3q
         r3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687421850; x=1690013850;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DzipTyigmcnKRgL/H9VZ7Sy0jmnx1tEYnZrj5BCUr0=;
        b=NolBxiedD+eKAzwwqCZAen+eP1WPS7U4q7PqVukzucLJed9DU+D/jOSMeJBMb0YbWs
         KqXaS3ZuppCaEEdA6lMG68Q27uSGdH9IVW2V/YduJG+S/0Z0Vm/VFAKIPxTfDOx/fUi1
         E6KkEHqEH1QyOje5OaOyVjv1+awn5r/Wdf+Xct0inLLVy45oJf5k74AmwjAmm6IfkW+g
         nv1qi7F4A91xG+NDCFZ7S6A/1cN5HVH322kUZ+buPIgBtbW5HPB19TZARG5OJLz7rrwD
         l0CcHV0NqC1zfG5cz+kTv+rhfx5cRNe9Mn7N7EsiiMFyccp1NZ8gqBhpM9f9bXlpV1gL
         mCSg==
X-Gm-Message-State: AC+VfDwbROV86fyFu7FMXOd6JdGbnRCmOC3mR+wKwDAlUfNmPSqWXGhi
        vXs9zGf45C/kc7IyykzVVGAX9T07ljY80g==
X-Google-Smtp-Source: ACHHUZ7aMGiAi/NZNM9AApAIVAiJYmqLtmFcCzNHMzaN6jcsbgNcTLj/SsuJd8p2qHUWi7jpIAq6uA==
X-Received: by 2002:aa7:cf19:0:b0:510:82b4:844d with SMTP id a25-20020aa7cf19000000b0051082b4844dmr13359681edy.2.1687421849635;
        Thu, 22 Jun 2023 01:17:29 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id k22-20020a056402049600b0051bc58b8dbcsm3577886edv.59.2023.06.22.01.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:17:29 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH v5 0/3] usb: misc: onboard_usb_hub: add support for Cypress
 HX3 USB 3.0 family
Date:   Thu, 22 Jun 2023 10:17:21 +0200
Message-Id: <20230620-hx3-v5-0-319c9c4c846f@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJEDlGQC/23OQY7CMAwF0KugrCcojZOUzop7IBa2E6YRTDtKo
 AKh3h3DjqHLb/l9+65qKjlV9b26q5KmXPM4SPBfK8U9Dj9J5yhZWWPBBGt0fwXN1IEnd4ixDUo
 2CWvSVHDgXnaHy+kkw7+SDvn6qt7tJfe5nsdye12amuf0vXRqtNGAwXUEjjeetvWYI55xzeOve
 jZMdkFZUW1AD05U28CnggUFoiwysQHGznWfyi0oJyr5QMAhUjD/Ppzn+QG+lnNVTwEAAA==
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
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
Changes in v5:
- 1/3: use ARRAY_SIZE(supply_names) for MAX_SUPPLIES
- Link to v4: https://lore.kernel.org/r/20230620-hx3-v4-0-e56b3c6db60b@skidata.com

Changes in v4:
- 1/3: set num_supplies=1 for the existing hubs
- 1/3: drop duplicate num_supplies in onboard_hub struct
- 1/3: clarify connection between supply_names and MAX_SUPPLIES
- Link to v3: https://lore.kernel.org/r/20230620-hx3-v3-0-2acbc03ca949@skidata.com

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
 drivers/usb/misc/onboard_usb_hub.c                 | 40 ++++++++---
 drivers/usb/misc/onboard_usb_hub.h                 | 14 ++++
 3 files changed, 123 insertions(+), 8 deletions(-)
---
base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
change-id: 20230620-hx3-cb935b4fdd76

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

