Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C563731566
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241171AbjFOKdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbjFOKdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:33:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFC2271F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:33:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f7e7fc9fe6so18487995e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686825178; x=1689417178;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PCpFLEWYvWLDytc9gU8Y+bjbd9ePeC2D5V0yD7+j5Ow=;
        b=vwIUEj4W43za4xgWB6zObu+m2cnlNw120vJAmUeS3VJEFwXAkapfiNpfOcUWrvU2YG
         kHX27ayFUuP4XQ4Zer3Kw5nugDB4SLWmKsTLXHc+45l+4ZLqptUMU/oizGERccoVH/op
         XxYuks1AVMbLrmuBKInVYZ2n3NFqJabLOqPBktDEO/VnJu042JLdpeipVPRSRy3wmeTu
         WfHzwYzMmHeCw9fOQxlTEM9fUtjuXmx0gs1uxKcASPAp+qagt1DnbAG8o4Lfao7TxTwA
         B3TGMiABxz0/nprAcEjFisvE9YndQSqiaCKzujhWtYiDNRmdMhJw2wB82meqY3CE8VAH
         PRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686825179; x=1689417179;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCpFLEWYvWLDytc9gU8Y+bjbd9ePeC2D5V0yD7+j5Ow=;
        b=XrF5+juFiZHAIPpr5L3xf3Uvwuo4tcVsHCVqbUgCnOh+h38FsPdBEGmMnwILuEo5cm
         3RWNhaNx54KLuNdB1kp1koDQqFbyE2TQ0oAquvATCJ6JsMl3ZwerApMDe2fUDQxbRKZB
         Fu5rcKsTUwl1ZRhrKDzilDY07CRrqzXsLgop5koi3KqCSc6oFTTubISNZ/vTsFOF3cuV
         0AcXr5FUQOYbgovdBvtn6c5bQtqdk0cPVyLWTCnHSxUrqPv63uSn2hlxVnIni9n8M8bM
         sArLKvpjZSAtFe9eFsU/hUbvtOAV+hCi91FjX1At5dHgM9R0OxAqlnxbo928OTOc9vvx
         dzXQ==
X-Gm-Message-State: AC+VfDzDLDAyImFcN6oZyBgPfv9EXhkUWhlGLcpKaE7SuUnjB1wSPNPD
        XOXuvXunP843nAMUmV84wQ8rRA==
X-Google-Smtp-Source: ACHHUZ6f1nH1pQxVq4vKQge5WhoLy+ScXIBUh5Bh4zigMWWr4IGB6L7N/0G2x7r3wNT0PA1BAKUaQQ==
X-Received: by 2002:a1c:f718:0:b0:3f7:7210:4f52 with SMTP id v24-20020a1cf718000000b003f772104f52mr12791850wmh.39.1686825178632;
        Thu, 15 Jun 2023 03:32:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b003f17848673fsm20072088wmj.27.2023.06.15.03.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:32:58 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/2] typec: add support for the ON Semiconductor
 nb7vpq904m Type-C Linear Redriver
Date:   Thu, 15 Jun 2023 12:32:53 +0200
Message-Id: <20230601-topic-sm8x50-upstream-redriver-v4-0-91d5820f3a03@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANXoimQC/5XOvY7CMBAE4FdBrvHJ3iRWQsV7IAr/bMhKwY7Ww
 QKhvDuG7nTNUc4U38xTZGTCLA67p2AslCnFGtr9TvjJxgtKCjULUNAoo7Rc00Je5mt/75S8LXl
 ltFfJGJgKsjQIRmMInXetqIizGaVjG/1UmXib51oujCPdP6unc80T5TXx43Oi6Hf7772ipZLGB
 tBqaMfRjMeZouX0k/gi3naB7zyoXgi2HxyA01798ZrvvKZ6Q9/7zigEPXS/vG3bXjqQssuCAQA
 A
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2469;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=wa/q9nQYQp6pCiDMhhuH7I5ZUdFjozrTmGzQV+njzjs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkiujYumlLetj505/dYBVJhUwGsKE+AOI/QpszIHk8
 O8MqTcmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIro2AAKCRB33NvayMhJ0SZED/
 9KAWu+lwbCCuWSEsd6323WWQ4BsXQqOhMoUxHHp45+FcASfsGNHcgCeOV5vDhvvFKlE1uef5NCBWo3
 K+VTC0RCr4rHOwQ5HuOjSQNzoHmaxGY1233VKwHbfrC90R9osNWWKnLUUCl2lnWeX7hFhy8DKZQCop
 jofr+V4hEtNn6bzScQjN6caqiWAL/QYHtaa+tlQskNkNVv2iRO1UxMGfBf0eE4vpV9gWwndGRBs1P/
 tcU6k09ESTxrZQ3DZnC7fvOnD6k09AHdxOzlSfL+Ij+MuZON8ACbmwARh17i1p0/QPYH3phOtt4thW
 RVPBQZdwGjh3XR6xICECex4fvlCrLcZLSB8gIm2oZjaoUdHx/MILlMoATiIOHWs0Fw+/7DFx+hvaF6
 jNhm2JvaGPdFCrDSmBFzXCLDNGv54EkgKPvfSvbEMM63lYkfqa4eSz2kXU5LOw2sTLA37Gz73LwY99
 iX30O3djOaZIpFkg4RkKnmKiayb6x0wLs5m8h/sDn8srkuBQIi55tTa7bmhBwADM18H6tsR/qJ8+cC
 TulbhTljmRoDA3X1UnsWCfrLds0VnvStpNvEJasi0qqPfvYbeTZcXR2L79cvkFj8BYgN38kNhlV8wA
 EBH/iZxpOzZWtcB9GQNwaGHKY97OsqEzr78WMeff4SsH44jns0veJLX6+Zzg==
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

Support is designed as a Type-C Switch and Retimer, and can propagate
orientation settings to the source endpoint, which is usually
a Super Speed PHY which does the data lanes swapping.

Bindings are added first and can handle the fact data lanes pairs
can be swapped on the PCB.

Compile-time dependencies:
- svid removal at [1]

[1] https://lore.kernel.org/all/20230526131434.46920-1-heikki.krogerus@linux.intel.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v4:
- Protect bridge setup with CONFIG_OF & CONFIG_DRM_PANEL_BRIDGE
- Link to v3: https://lore.kernel.org/r/20230601-topic-sm8x50-upstream-redriver-v3-0-988c560e2195@linaro.org

Changes in v3:
- Include bitfield.h
- Use correct -EOPNOTSUPP
- Correct nb7vpq904m_sw_set line wrapping
- Link to v2: https://lore.kernel.org/r/20230601-topic-sm8x50-upstream-redriver-v2-0-dda89b22b1c0@linaro.org

Changes in v2:
- Switch to "retimer" infrastructure
- Slight style fixups after switch to retimer
- Bindings updates (did not keep Reviewed-by tag for those reasons)
 - Update maintainer, was using Bjorn with invalid email
 - Fixed swapped lanes mapping
 - Switched to retimer-switch
 - Fixed i2c top node in example
- Link to v1: https://lore.kernel.org/r/20230601-topic-sm8x50-upstream-redriver-v1-0-6ad21094ff6f@linaro.org

---
Dmitry Baryshkov (1):
      usb: typec: add support for the nb7vpq904m Type-C Linear Redriver

Neil Armstrong (1):
      dt-bindings: usb: add ON Semiconductor nb7vpq904m Type-C Linear Redriver bindings

 .../devicetree/bindings/usb/onnn,nb7vpq904m.yaml   | 141 ++++++
 drivers/usb/typec/mux/Kconfig                      |   8 +
 drivers/usb/typec/mux/Makefile                     |   1 +
 drivers/usb/typec/mux/nb7vpq904m.c                 | 529 +++++++++++++++++++++
 4 files changed, 679 insertions(+)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230601-topic-sm8x50-upstream-redriver-6e261edd5cb4

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

