Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0283D5E8B3B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 11:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiIXJyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 05:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiIXJyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 05:54:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF97EDFD4;
        Sat, 24 Sep 2022 02:54:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z6so3379638wrq.1;
        Sat, 24 Sep 2022 02:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Ni2PDD1NFXkbmz8UnUvfBD8YcER96pHHvaQvpBK+Slw=;
        b=C3LDPsx9R+xX0AZJpXGXFWB6l4L58kc6usbJgacH5EJHK9hLe/l8Vn3mVvqrybicF5
         L7J2KFnPL45Mv4TsvGxSIMe5vc4O778jucBNuHpp+wTs+MM7lqbaW5r4MkagLA7RNG8h
         0UD6IVYXnn7qHnar5qmVkCLpVtX7fGeWHOVq8TJi+yBF5HFMUJ/4lOniszRu6zo8DeTC
         SxtJYqqIKpNgu4LTQwn2UJxjQcjmfYcKaos0tXZ9uWimOdxvpTBJVsnNLWeOm9dx+Gb9
         DfaPOqt14cV8OpYl9DQ/B5KFxShpb5uv7wq8qghvph40sxCNASHBA2FDfDDBVuFnwHfA
         OMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Ni2PDD1NFXkbmz8UnUvfBD8YcER96pHHvaQvpBK+Slw=;
        b=JPosYCZgmkjJE5j17b4SrcIQckbOcOxcfaoeRdYIj7cb+7ntJUrDM4bJRGnENidDqE
         Iy51wj2ZLPyw3hVo8guTtil3ZAYeYNaSAbkKQSnNSjRQj+50U9aq9i03TfFJsZdTXB9b
         8b0/B8wLefk5RGhcCYhyX3v9SxYBA5fqsK25wG/fEU9q6C3sZEpwmHrZM+91wAS7DRC/
         1un0UEbNX+dIO8o6j4W3i8EU+jJdofzwkjRqaiLZrJ9esM9nC/DWTvdVJqXx1vHFNkME
         7GQhaJLg/TYKQ45c6yMZ22yn2l5Oaa/fDfddweu9z9kmyuW44qtvgehKd6iMy4S4gS5d
         j6aA==
X-Gm-Message-State: ACrzQf2oqd99Yr8c0XiBSYIH/Xg0l6HtYE50Zs3w0VlupklItHm2QZpi
        bk0RL4SrHh2pVfkcjoTr560iZ4IHRpc=
X-Google-Smtp-Source: AMsMyM55dTUIfOl6q8oqV+C7winYsaRumaB+IsGSqPRT75hUo3eho1ftDLthetry1gBpKcjMMX+ufA==
X-Received: by 2002:a05:6000:2c5:b0:22b:c77:7690 with SMTP id o5-20020a05600002c500b0022b0c777690mr7678715wry.563.1664013272265;
        Sat, 24 Sep 2022 02:54:32 -0700 (PDT)
Received: from localhost.localdomain ([5.25.100.2])
        by smtp.gmail.com with ESMTPSA id c2-20020a7bc2a2000000b003a844885f88sm4776835wmk.22.2022.09.24.02.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 02:54:31 -0700 (PDT)
From:   Kerem Karabay <kekrby@gmail.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kekrby <kekrby@gmail.com>
Subject: [PATCH v2 0/2] Version 2 of hid-apple fixes
Date:   Sat, 24 Sep 2022 12:53:04 +0300
Message-Id: <20220924095306.8852-1-kekrby@gmail.com>
X-Mailer: git-send-email 2.37.2
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

From: kekrby <kekrby@gmail.com>

Hi all,

This patch series is an updated version of this one:
https://lore.kernel.org/all/20220910094354.12359-2-kekrby@gmail.com/.

# Changes since v1:

- Fixed loading the module with the `swap_fn_leftctrl` option set to 1,
  which would make the Fn key cease to function. (Setting the option
  after loading the module still worked, which is why the bug was not
  caught while testing.)

Kerem Karabay (2):
  HID: apple: fix key translations where multiple quirks attempt to
    translate the same key and the ones that depend on other
    translations
  HID: apple: enable APPLE_ISO_TILDE_QUIRK for the keyboards of Macs
    with the T2 chip

 drivers/hid/hid-apple.c | 118 ++++++++++++++++++----------------------
 1 file changed, 52 insertions(+), 66 deletions(-)

-- 
2.37.2

