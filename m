Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C317196B9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjFAJVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjFAJVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:21:32 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2D597
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:21:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6094cb2ebso6296385e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 02:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685611289; x=1688203289;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FcxAvJgkKrQIlZsFDeDW+ZrkzVmM8rkabiZ/3MtwMOc=;
        b=bisGZrxTZWGmCZHyPxJwgcrhsBGDdrS5J9/fjuP/QBuH4CNRJ9vt30DpDg9d8gJ7f+
         Qf/pGmZE1dDJZoqVGi9hyBfeMxiRnZnAu43DznuTSqMgXz5mrF8NgBUOCEFHh6j4k+MB
         kupUUumTBs5rmIRnrh4QQlIZ4Vsflrk1uFAjDvNP5y2hq6odKH1EwzbvGc6jvbQmOQyd
         WIipuAl4g58eD0rUNaQdMH1Q0cCdhUhpydgfXI7aHXplxOqYcxEh9avLVf4ek5cjFDuJ
         IyssETzD0MurSFHAvp+03kJgMmbDH7AvdMd9bkcILWDckYymYTb4cCoKwkRCvMU9mm2A
         lO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685611289; x=1688203289;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FcxAvJgkKrQIlZsFDeDW+ZrkzVmM8rkabiZ/3MtwMOc=;
        b=GiZxpKw/WmXadRS+9lZUttaMtGY1uqAq77HH/pqcUNNYTuHxiMLQlHbTuOR/kAvLA1
         YVGxkQFNKgUUxZ/oZyfZlOJG6IhXRLVEP9y189bvCFmODJgAU5f/o53U7bt4mvLhUUi2
         Fp7xeT6BpIiBGC/gMifo9vn2P4erlHqntMSxH5hzGBsSWP8V11gBLoDFijh97RcZnVIZ
         hDHhoCf/jV1djV7CpeoIcRUsvaNati2iWe+8HWJ2qF6mQUrVu43a8WTPrL3odkp1sFel
         9f4E+j3rrCD6p9zNnbE/uKYhYwNV+KtuObehqRYxBTE2yVUVIadu4LsogwvsmdWz2d6J
         G41w==
X-Gm-Message-State: AC+VfDxwSoB2t+Tk4Gzjugl/C8oR0Iulz06HhN3WVh1lboEKAYKUBzzR
        w+q8RivftUtYEAjUwRwBgnpmTQ==
X-Google-Smtp-Source: ACHHUZ4OUSH3HsUAFs6mwDJHFADiMWqLjdwk37CctJ+J6vWnPA/xWSyLGL74scdwoG2MqG8ykLtviA==
X-Received: by 2002:a1c:7506:0:b0:3f1:bb10:c865 with SMTP id o6-20020a1c7506000000b003f1bb10c865mr1603329wmc.38.1685611289044;
        Thu, 01 Jun 2023 02:21:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id a2-20020a1cf002000000b003f3157988f8sm1671572wmb.26.2023.06.01.02.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:21:28 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] typec: add support for the ON Semiconductor nb7vpq904m
 Type-C Linear Redriver
Date:   Thu, 01 Jun 2023 11:21:11 +0200
Message-Id: <20230601-topic-sm8x50-upstream-redriver-v1-0-6ad21094ff6f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAdjeGQC/x2NywqDMBAAf0X23IUk1lD6K6WHPLZ1QWPYVRHEf
 2/oceYwc4KSMCk8uxOEdlZeSgN76yCNoXwJOTcGZ1xvvLG4LpUT6vw4BoNb1VUozCiUhXcS9OS
 8pZyHFO/QIjEoYZRQ0tgyZZumJqvQh4//9fW+rh+vlhFLhQAAAA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Gj9gL2fn4aulvReDmQHIXohrLQK9BRznPeqnK27sFAo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeGMW8sEJeQr6aBMdPo49JiweSYCF4uGlGNMQVEUE
 s5JnHDyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHhjFgAKCRB33NvayMhJ0ZkYD/
 wKhk3Yy5kxZTWf9Wl0g2yyxNz3WFHTNtakQuruG2y5IstBIOGpUd4lHEuIvqxH3UDB0xwLWp+mweVN
 PaZwABNWAhjjcMPb0jFeVrNqT4PCV0y5QvC6qJyaX4ueetvpKRPaK3+zwjzs5CKZ7nq7p42WtjYVfj
 7x4nMxw5Slno234d/dJPqurfb/wpTayMLOkoDnetGFjmheQNVcR43BiIcQYNqSwA+oNoE5hWWcEt9r
 JggcrhUGSJGuSRXoLx5OotKF2wKOx0ruIXFxdGpT5aVfr/AVkMYQKkupGt1VnooPuxzYyiMD2fb02l
 nqfHJ9RZhSa/rqT3FgmYkH+WsJy329fDRpVHZqm019GXozQ9qSaK7ke2LB4OMNfL8c0RGKRRtJvdOG
 kgqvn8LzR4xuiAz7UtVR/M37ldpKW89+bs/i38GdiUIIV+kzWpJa0B5j5rpR/ddfe321i5j6C1B5j5
 /GzuVXCad4dh+wdYfQRqm/J9bo6ULl2qwb9UqtOfNRbwLeDS0wqeds3SEOP0kV6T0dhkqWP7giE2AN
 /eSGt570KSfTjsA1EW44JiLTu/fR80ghjGj/0OdCak/1Ek9gNA8cyZOwTjchxpR9l69SoF/Crld/zU
 Gi6AhWET6PrklPACudpCgS37Xk1bzz99GMkV3e+zKJ52vGbLjxNTXFurbLDg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the ON Semiconductor NB7VPQ904M Type-C USB SuperSpeed
and DisplayPort ALT Mode Linear Redriver chip found on some devices
with a Type-C port.

The redriver compensates ultra High-Speeed DisplayPort and USB
Super Speed signal integrity losses mainly due to PCB & transmission
cables.

The redriver doesn't support SuperSpeed lines swapping, but
can support Type-C SBU lines swapping.

Support is designed as a Type-C Switch and Mux, and can propagate
orientation settings to the source endpoint, which is usually
a Super Speed PHY which does the data lanes swapping.

Bindings are added first and can handle the fact data lanes pairs
can be swapped on the PCB.

Compile-time dependencies:
- svid removal at [1]

[1] https://lore.kernel.org/all/20230526131434.46920-1-heikki.krogerus@linux.intel.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Dmitry Baryshkov (1):
      usb: typec: add support for the nb7vpq904m Type-C Linear Redriver

Neil Armstrong (1):
      dt-bindings: usb: add ON Semiconductor nb7vpq904m Type-C Linear Redriver bindings

 .../devicetree/bindings/usb/onnn,nb7vpq904m.yaml   | 141 ++++++
 drivers/usb/typec/mux/Kconfig                      |   8 +
 drivers/usb/typec/mux/Makefile                     |   1 +
 drivers/usb/typec/mux/nb7vpq904m.c                 | 526 +++++++++++++++++++++
 4 files changed, 676 insertions(+)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230601-topic-sm8x50-upstream-redriver-6e261edd5cb4

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

