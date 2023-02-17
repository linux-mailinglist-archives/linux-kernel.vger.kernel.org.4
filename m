Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5E69AA52
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjBQL3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBQL3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:29:12 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43F9627C6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:29:11 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z10so654713ljq.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XojccRYQ3011ah7si5AMINb0QDSJoaYY4S/gS49bAfQ=;
        b=d9mmn2OTk/EYtKzs7v+DxSB16T2vfV1NHmLvqLgwPlTjquDNsqHxuK9jF+FCcA3mzX
         TVVnqmft78I2uOrHGtz9iRydl7/plZR7+p3rmH3sxdPO2xRmoDq7F7myhOImySzgsVwW
         1/pHz1+rlJCXAQUtfCfU7fO96u5pBWQpe0QZlTslSOG1mOAQj5T+NsI0V+h7tr2iY5aI
         o7jsWKVRdlFMGalH3/XPeJDrKOztWKndZvsr50XsG8Fk+9i0y3TL+7ZVgvq9OjcQmGqy
         52Nv4TF6l4CBk9qeuFmF/J2Fg9suV8zo6oxj5nsMmIw3+bbWTFG8YXnfH/vqaQ5Ty2IT
         t1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XojccRYQ3011ah7si5AMINb0QDSJoaYY4S/gS49bAfQ=;
        b=JMSAA15if8akSFOUT06ga4e3qsE+H/7XElMqaEpYYfY4vwWk/byzVVk2SgE1fBe++G
         MtgYmvufAiRAAww7uuD5z/WgMtHJdoN9htqt/P6jERp1FL3VCd58f+rIVR5gNJLqzOQq
         eQVF8OrI3yMTqSb3mT4AAgMVbw+S46f/8o5EaehFi50sAePxGObEaASFsjIKQwxIGDK5
         lgWTDoMKO4BVfAFxtrVLe4uykI6hllNixOsvJbPdaX5mLbKdL9xLXBLwgtz5rRnr987W
         8GjrcesQaZhReybdHeqPKUkjPBKEYkgxEbxnsy9KNCZImerkitxZegOLFzOm78byaWdv
         rHbQ==
X-Gm-Message-State: AO0yUKWnxULR3p7hc4rtjnzf7Mkrv6hFz1nvzaniPdVRtsewVAhLLKNk
        30FfMzAs+h5m2T6o+XjnAoNZfQ==
X-Google-Smtp-Source: AK7set8CH5VWqiM0itp6QaTpj2Bh8G3+5JJvzXf3luR0pRoB2Zg+dd8f+V3RhYdbkKYMW0hGX0LJwg==
X-Received: by 2002:a05:651c:1548:b0:293:806:dd74 with SMTP id y8-20020a05651c154800b002930806dd74mr141142ljp.46.1676633350142;
        Fri, 17 Feb 2023 03:29:10 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id t6-20020a2e9546000000b00267232d0652sm564505ljh.46.2023.02.17.03.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:29:09 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Add support for Lenovo NT36523W BOE panel
Date:   Fri, 17 Feb 2023 12:29:06 +0100
Message-Id: <20230217-topic-lenovo-panel-v1-0-9d7ee1602089@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAJl72MC/x2NQQqDMBAAvyJ77oImUoNfKT0k6VoXwiYkVQTx7
 y49zsAwJzSqTA3m7oRKOzfOojA8Ooirly8hf5TB9Mb2ZpjwlwtHTCR5z1i8UMLRxacNbiS7ONA
 w+EYYqpe4aipbSipLpYWP/+n1vq4bpXMJJnkAAAA=
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676633349; l=770;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DdW0OelSNZcoEzI5MdU1ai/Q4yYiDtAFZdvB/j6upxg=;
 b=T3zW0WVtkxl28K80ifzKQaqjIZZ9dQHy/VIGnPSWYviFs0++ssUuborzX7qPinLQ5gL07tIzVH8w
 QwaApCdBBAHjHdL1+zvyDiUtAtB9AnMR0WFGMJxmUsof9LU9HACd
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver and bindings for the NT+BOE display panel found on Lenovo
Tab P11 devices.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: display/panel: Add Lenovo NT36523W BOE panel
      gpu/drm/panel: Add Lenovo NT36523W BOE panel

 .../display/panel/lenovo,nt36523w-boe-j606.yaml    |  60 ++
 drivers/gpu/drm/panel/Kconfig                      |  12 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-lenovo-nt36523w-boe.c  | 751 +++++++++++++++++++++
 4 files changed, 824 insertions(+)
---
base-commit: c068f40300a0eaa34f7105d137a5560b86951aa9
change-id: 20230217-topic-lenovo-panel-48c63b84e3f8

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

