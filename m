Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A0F5BF023
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiITW37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiITW3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:29:52 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF6A12607;
        Tue, 20 Sep 2022 15:29:48 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id m16so2189954iln.9;
        Tue, 20 Sep 2022 15:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=3KBhCVJZhPS9T7QXRGs8a+mFqMOdqTGYPO/862BSLAc=;
        b=JalUw4sV3x2a7Nwd9oo9RlSV3WW5gL7ph7eMg9OtIDqp1KS8YDolTIIw3ovbdDqu3G
         A5/s+YRkHpLeBQ0b6dh3CNGPeAZjGgAV1OiEfSPwWpXQVPk/Hs+tX7DWBzsAjUa3aPN/
         q7HAD5DWw2F7Rc/NBBP4kbG7JhW7Y7OGFYtu/0SI20a/2K6vl9jBHIzj0K8blJT84eV4
         ihS6Fbm9Jfqz9hsmbFmq513t5d+nrVn/a+pHe7XmuYh4j+OqA5Dk7NZJBLerXZA42Ryk
         /AEsWSTtI+kf/1POp5+IVPpF+Qf1oIRnl6qY688wG8QjiEjXfThkDCoyqd0pVhM+7GsT
         AiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3KBhCVJZhPS9T7QXRGs8a+mFqMOdqTGYPO/862BSLAc=;
        b=UCdx4vSOQHY+XXf14VYtp6ymhZi+OUSiOvkAVwMhT2LF9kOW+8/g+K/WyNZdL9CyDs
         9yqCnOka2ytBbWYwfEx9EkWqq1gCBsVoYLFkW89FUAm2YZMGPNU2DXiW9wAWqIB8L3aT
         cbIqdJjm0z6KMInu4WfPMHEMsiqxRKjrJKbXO2XMyy0vJm1ck8xPWbA3svyoIB25Kik/
         nuTXneTT16POBnDe3/HRxtrgnBnMaQbbefRr/77h6KmlRQVJGi7Wmo9ZtBGDNBcy7w5e
         +PjqkDtuj1KmrKoVT863GN2ji3XyzJpb6b0S/SfjkQvpvZHhanwrXCDb9Es7ZT4qzBCX
         hBAw==
X-Gm-Message-State: ACrzQf2/seIp34lWRYIH0SjFCAnOqgdTmWJ7rWf0EUVbzfo18Ik7q8Xw
        eix5+SuQcAzDQ7Q///dX5sooLWsMLgw=
X-Google-Smtp-Source: AMsMyM5f6qNZj7M+d/nsdeu9XBVMXdBlxtG+C+iT34Vboy20KC4JoQ7/z2WAsKKJDC7ZBQk+jXlZtw==
X-Received: by 2002:a05:6e02:12e2:b0:2f1:c14a:8a9c with SMTP id l2-20020a056e0212e200b002f1c14a8a9cmr11091582iln.267.1663712987143;
        Tue, 20 Sep 2022 15:29:47 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::a533])
        by smtp.gmail.com with UTF8SMTPSA id m10-20020a02a14a000000b00346a98b0a76sm378450jah.77.2022.09.20.15.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 15:29:46 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v4 0/2] SDM670 Pin Control Driver
Date:   Tue, 20 Sep 2022 18:29:36 -0400
Message-Id: <20220920222939.150330-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:
 - constrain gpio-reserved-ranges to 1-75 items
 - proper indentation in dt-bindings example (actually tagged this time
   instead of an outdated commit)
 - remove unnecessary commit reference
 - rename complement_fw_reserved_gpios -> complement_fw_gpio_ranges

Changes since v2:
 - remove quotes from pinctrl.yaml# in dt-bindings
 - constrain gpio-reserved-ranges to 1-76 items (includes ufs_reset)
 - indentation in dt-bindings example
 - cite downstream kernel source
 - remove MODULE_AUTHOR (most imported pinctrl drivers don't have this)

Changes since v1:
 - add a field in msm_pinctrl_soc_data to accomodate the needs of the
   driver and device dts
 - apply changes made to existing tlmm dt documentation
 - add reserved gpios array
 - rename device tree compat string to qcom,sdm670-tlmm
 - remove dependency on ACPI
 - move MODULE_DEVICE_TABLE macro call up
 - add missing pins (fixes most of the debugfs problems)
 - move qup0_pins down
 - add whitespace between UFS_RESET macro and pins array

This patch series adds the driver for the Qualcomm Snapdragon 670 TLMM
(Top-Level Mode Multiplexer) and introduces a new field so that SDM670-
related device trees can reserve their own gpios.


