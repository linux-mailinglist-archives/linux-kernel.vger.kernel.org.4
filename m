Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4292692400
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjBJRHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjBJRHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:07:30 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF96475F61;
        Fri, 10 Feb 2023 09:07:27 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so4553381wms.1;
        Fri, 10 Feb 2023 09:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xN769MyAqG+UwI1gs9zsgn//wHYrKGP6dIPoLYX1lbg=;
        b=ezlIwstR938P/WBu6L9tWuOgIKYTF++xSj7WmJEq7Cr2Ax6nPTtamhDVttKjR2UR57
         ZmYV7hdCM5Psuvu2kL/DFo7wl4JDTGY4i6ViW8CIbXZaTjqzKkKkUfa9Mh/TYn46eruN
         INrTvEKhK2Qzr9WsS3bEl1dFiuopDnF61lk7kFV3thvWxJ+v/P0poyPc9zfckpc/HnCB
         waQE2BeYrhnI10QZaNE2vqBBp2VFRLEg4IhMauIyLWTbdI3v3C1RngkNsHsXN5QBniej
         TpYxZXOB4SrUIVjYU1UYLwIMDOO4SirSOblmtBaN1dVfk4a3i+4r47wDBtb0hAK4Zajg
         o1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xN769MyAqG+UwI1gs9zsgn//wHYrKGP6dIPoLYX1lbg=;
        b=Rum8CTERTUoYumFv7r6NKuH5YARt6adlXlLihroRo5Ncw3RMGCdjqb/EWeEIXK02KM
         Xgra/Y8KKLh0fetXZv6l9nvfDPME1LsiCCJEaD5fCw5DRyWrquC8+Jpo4jTO2rojO2XG
         jzQrAYNceyj8Y+o0TWuOMbpkMCPBWDqoJIPRCKBv9KXiXK7gBnmvgCZix49JgeMXRnd0
         GkiWz5o6lR27/eWSur9VlFuG6m60iajDeLCgb3iOVpMgBArZ4VVRhAqSDWbFk0evux+G
         IshSyx8R+95JT64A91tEdb85vhnhL+Ixa2QcDAJ1172Wekh34mb4CMlyuj2HN9rnVSX+
         ZUrg==
X-Gm-Message-State: AO0yUKWduIl0jTvbnZEIQFs+yEuj3v8dHEx36nrnzv/4JBd8ryN5sFdE
        35l4LOk6RUcwofxDBGaSesw=
X-Google-Smtp-Source: AK7set/nC7TK4tPu/NvrJILGJR+kXrudhwCL+65OWuVeFN63PFM2TOZJGa9uWcdc++5EFRn76GQzLQ==
X-Received: by 2002:a05:600c:43c4:b0:3dc:5302:ad9 with SMTP id f4-20020a05600c43c400b003dc53020ad9mr17283356wmn.27.1676048846445;
        Fri, 10 Feb 2023 09:07:26 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x7-20020a05600c188700b003cffd3c3d6csm5351531wmp.12.2023.02.10.09.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:07:25 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 0/3] arm64: dts: meson: gxbb-kii-pro: device-tree updates
Date:   Fri, 10 Feb 2023 17:07:18 +0000
Message-Id: <20230210170721.1285914-1-christianshewitt@gmail.com>
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

First we sort nodes in the current dts and remove some blank lines. Then we
add the remaining bits needed for Bluetooth to work. And finally we add the
AIU audio card to have HDMI and S/PDIF audio output.

Changes since v1:

- Add reviews from Neil
- Drop unneded 'okay' from audio patch

Christian Hewitt (3):
  arm64: dts: meson: gxbb-kii-pro: sort and tidy the dts
  arm64: dts: meson: gxbb-kii-pro: complete the bluetooth node
  arm64: dts: meson: gxbb-kii-pro: add initial audio support

 .../boot/dts/amlogic/meson-gxbb-kii-pro.dts   | 83 ++++++++++++++++---
 1 file changed, 72 insertions(+), 11 deletions(-)

-- 
2.34.1

