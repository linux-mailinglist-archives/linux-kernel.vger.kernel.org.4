Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4939E665778
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjAKJaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbjAKJ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:28:50 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF08F57;
        Wed, 11 Jan 2023 01:28:36 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id tz12so35295230ejc.9;
        Wed, 11 Jan 2023 01:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GqVP0FevVzDRika8AgmvVadRKbtFlpNbmPvpvY1gzo=;
        b=cpRTXTgvZMWKjjIYEE10nJ/ZRmqx+KCGknPkTKRPVh544s/x2qUmao6dX0vmRQxx9o
         Qx5C6kvAxFn2nX9QUNk/fh/lBgk9tSQ5ScqPCmLS/XQKRB2tjj+TfyYTa/zQjOQLb4CI
         1OzqhDivPSsxTeRSoesgW/RlvAaB5Nk89pJMzgNy0I4PP2W+cvEAwQNYRLHAJL+tNMbu
         L07+fGh4WWAOBm105wsHSPwL47WWyjocutDZ0+uGMCv7MmuP+sFKU+NxK2VysMduMxxl
         OtAXmepOTbsLdMKiOezMHoWjZkcxvstPlnTWRiKsLDV40OcpZW608hElIMjwv+6CVg1e
         k0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GqVP0FevVzDRika8AgmvVadRKbtFlpNbmPvpvY1gzo=;
        b=XUkBuC+Uw0f4WCAOh9E+p3i8Ta5dJ2UeFXDbPBNI7/j0VcVCcY5yOO+h0PVgfhLu1X
         np5Ol6zE/8eHj/+G+wRJRhD9PpRGk61jJ7xRqjKgq/D5HPMDmRDj8+mjqFvdJjA/zdtO
         7MP9fYFVut2GgorKDM6cpTtqir/BJS/s5csYUUWC2IEk2qkm6gUPTM0A367uaXNoFdXO
         QVir7PCb2T88zUn4q/Y6xXM30BJqZVqCpbZH8N3srsvF1VfvC5cDlNGEaTwdUPI++QMc
         Pcqt6nCLSdX0kBLGcY1mXx4SAfSYRqGJNadoA5Ozp9WZySwfHMnAxPEycq3MPWnkaDyk
         RrLA==
X-Gm-Message-State: AFqh2krrvegT3Lfc6OphZsGdHhvEqh8k+tyOCvEipoEVLoKVvinM20Rr
        Etoz59jC0LEE6Eu2ObBD1pk=
X-Google-Smtp-Source: AMrXdXuHVYsMKMRFnaYPK+KtkCvSOS387jsdTlMgFAADLRBDZZizxcytk11kwQq8cECNnFv8X8ne4w==
X-Received: by 2002:a17:907:a4c5:b0:84c:f9b0:b54a with SMTP id vq5-20020a170907a4c500b0084cf9b0b54amr22983015ejc.58.1673429314842;
        Wed, 11 Jan 2023 01:28:34 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a47e:7f3e:6b25:bafb])
        by smtp.gmail.com with ESMTPSA id 14-20020a170906308e00b0084d3acda5fasm4473970ejv.189.2023.01.11.01.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:28:34 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/2] MAINTAINERS clean-up after Arnd's rework
Date:   Wed, 11 Jan 2023 10:28:26 +0100
Message-Id: <20230111092828.958-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Arnd,

please pick these two minor clean-up patches into your soc tree.

These patches apply on next-20230110.

Lukas

Lukas Bulwahn (2):
  MAINTAINERS: update file entries after arm multi-platform rework and
    mach-pxa removal
  MAINTAINERS: adjust SAMSUNG SOC CLOCK DRIVERS after s3c24xx support
    removal

 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.17.1

