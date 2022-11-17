Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C97262E64D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbiKQVFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240611AbiKQVEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:04:48 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0F98E28C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:04:05 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x2so4418020edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xzQ4zGogKT9ijjeuPZRu45C01o05MgA7QTyTUv9Fiqs=;
        b=7/xMAYbNXpDCRv94jbVuGuNRABSL0yvog+ebnjOvSBptbGaY9ek0+tdOFiZ5smY2sV
         XNf5OosNV7TSHYNO0XppadNopkfNUt3jTfDM0JTxsVczupAAHRD8qTiCN0EO6YM2SPDb
         GFnaAxOA/fRs7XLhVuwyAsgHemKhKoCg5knNn0OrdLGSpoDnKcB8rrSWjoZZjJPLVk1m
         epdk0IAlXvevdUiCUgLt4WYUUS73+QS2aVqDwpOHlEWpk9UnHuYY3aQuhRUg7TJCsx3b
         HzLNCn/wyituGdovbvGUOrKwaS6mZQKzjFMRoRe9KveL0FFhqoLwEHbuMy7XFUFdg+Q4
         Kmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzQ4zGogKT9ijjeuPZRu45C01o05MgA7QTyTUv9Fiqs=;
        b=j4oWpaKs4betqatEvSVoHcWaVb9UI1an1R7wA0Ev7gRoHVlH33ygTNbKBMgE/eCGcZ
         vGJZCX4U6WZCsrme4DEQTx6SyAXv2CtDt9ncZQJXBJifxdD5u+ueDGVUvmRPVSrl4Kf9
         eYqPnGHyi6rUCDQG36owS1fe0/bzTfDuokSmV4Geo5W41xQPC2em25w1wBOd7C3ud4mv
         11znA8zrLfXizbbceVBRn4fB/ssAqxenObNr2ewM4OnJggp5nyhgdYlZLEAWNn93Wbgx
         klTUbNnT2uGzChgo+5V0lY9b15m5lGDnD8tcxmrjAZI93Eam1gnnvjzZdUDsriRuhNEH
         qglg==
X-Gm-Message-State: ANoB5pmCe4wNy4YsIGENTi9Z5PaxiVH5nsINthhD8lOsc/Yr/D6PQvh2
        qA2j60f0PaQMb8UZZbYYtwTffg==
X-Google-Smtp-Source: AA0mqf4XjTgdWKhwU9xml63us080tOvJFlhGJvQ3RLSKnwNDWGozAB4URcX/BIyfRoK6yTwayay4/Q==
X-Received: by 2002:a05:6402:b6d:b0:468:eee7:324c with SMTP id cb13-20020a0564020b6d00b00468eee7324cmr2936483edb.119.1668719043959;
        Thu, 17 Nov 2022 13:04:03 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7cc8f000000b00461c6e8453dsm970807edt.23.2022.11.17.13.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:04:03 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogiocchino.delregno@collabora.com
Subject: [PATCH v3 0/7] Add minimal MT8365 and MT8365-EVK support
Date:   Thu, 17 Nov 2022 22:03:49 +0100
Message-Id: <20221117210356.3178578-1-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds minimal support for the MediaTek 8365 SOC and the EVK reference
board, allowing the board to boot to initramfs with serial port I/O.

v3:
  - Remove a number of components that are not yet supported (they will
    come back alongside the corresponding drivers)
  - Address issues found by dt_binding_check (mostly fixing pinctrl
    bindings)
  - Address issues pointed out in comments
  - Reorder patches

v2:
  - Add missing dt-bindings documentation
  - Small cleanups addressing issues in v1 pointed out by Krzysztof Kozlowski


