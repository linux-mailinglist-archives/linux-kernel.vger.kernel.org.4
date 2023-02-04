Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B5A68A8D2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 08:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjBDHpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 02:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBDHpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 02:45:09 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC4017167;
        Fri,  3 Feb 2023 23:45:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a2so6129354wrd.6;
        Fri, 03 Feb 2023 23:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vi23fWS6AbqcC/EHm6LEeuRMdq+4C0t28dniBnsKSyw=;
        b=O+KhABVpghMPPtrq2guyS0hz4odNOKgTzu/oVSamAh00RRleZRSkGBbMR8qnVHABPh
         vUEP41OLdSVCNTauPunl6XFExN7dUCDuhMdE3Mi6GrQOB//+aVqpXAw3tVF7IGu23Wh5
         HEpLJV+kfdybfUHtYDh6+r+UKCt0wZ7jRhAthqpLiu2dITx7QdiIHumb7iPLIXT7+8Ur
         dYIpcxlhsyhwk9cD5FEJ41Cs68yRV/x0B/f31c56AjOvqh2mVBG7Ya0znc9QDdQWpP9x
         gdCNoxiJSB6r6iByCbRpFNjhYRh7DEHeCW6BJCcTaTj65c05p0iIWzqs6hoa/uOJKN6L
         +YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vi23fWS6AbqcC/EHm6LEeuRMdq+4C0t28dniBnsKSyw=;
        b=IsnhXtJ00WtkH0v7n70/NXHiDKhouGuQgSUBtzpPvyKi3tvd9O2y5QRccgUgEXkVMo
         KaStZSWv7LGG2tNLY0NZvvBuFhm4e+p29Xklxdo6IxaGbw9nzn4rp7WcyEvsDRx73eMu
         lwvz1xPYG9CRjxGvRJpcQi3c/WPiZo7xtRyJAvbHv2mGwPvjR9cVvp67si0aEyKmV1X/
         1pFz6PozO7V9jSLtI/arsavtr45rvNvyajT286jZDov5vxzoBjcGk14k6SyA20kz/BgB
         3j7dsWX5cLLEhX6tn4wpoiQugWMJNhKyBF3QCoY8LoxR4V574d5jJu354OzGOccPaVsG
         tGzA==
X-Gm-Message-State: AO0yUKXR6cmnLDtTmg07KpcR9XYikYb6InPYZh5QsROeuuBakKW0AkFj
        DM9+4R8i+8NijnTDr6hNPJw=
X-Google-Smtp-Source: AK7set+p5IYw4urrrNtzVH7M1FRDr9IFZf/VnXa0Kw4ejbTUTLwR8Ie8/Wq6AL1hY9oo3VORPd7BQQ==
X-Received: by 2002:adf:de8f:0:b0:2c3:db5b:7280 with SMTP id w15-20020adfde8f000000b002c3db5b7280mr2205110wrl.56.1675496706068;
        Fri, 03 Feb 2023 23:45:06 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b00267bcb1bbe5sm3735814wrt.56.2023.02.03.23.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 23:45:05 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 0/2] media: rc: add keymap and bindings for Beelink Mini MXIII remote
Date:   Sat,  4 Feb 2023 07:44:59 +0000
Message-Id: <20230204074501.3421910-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This series adds bindings and keymap for the Beelink Mini MXIII Android
STB device. This is a very simple remote with a real MUTE button (not a
mouse button remapped).

Changes since v1:
- Split bindings and keymap into separate patches

Christian Hewitt (2):
  dt-bindings: media: rc: add rc-beelink-mxiii
  media: rc: add Beelink Mini MXIII keymap

 .../devicetree/bindings/media/rc.yaml         |  1 +
 drivers/media/rc/keymaps/Makefile             |  1 +
 drivers/media/rc/keymaps/rc-beelink-mxiii.c   | 57 +++++++++++++++++++
 include/media/rc-map.h                        |  1 +
 4 files changed, 60 insertions(+)
 create mode 100644 drivers/media/rc/keymaps/rc-beelink-mxiii.c

-- 
2.34.1

