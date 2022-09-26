Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076565E9BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiIZIJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbiIZIIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:08:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA4E316
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:08:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c192-20020a1c35c9000000b003b51339d350so4545258wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=bM94JXTwoxg3mZXJqopeDPFgq+t13ym1AVWz3fY3lAg=;
        b=gLaUgQB7xW1C1Xo+Dbbw2TpgFeOjXOEhKxPe1E7MyeFknYZFutpCqD5Q8JqqRaCSgd
         Hl5e4ehqKzCSgFwdnLAvWFnJv2KS2cADvNqTSbKCAc8N0IY1k5VqxCvEyiiCfeXDrPey
         pjoZ5wxyzzUzhJuYPdWtJarK7q68R5qcRBFe0R3dyTqHa4aPiIqCly3ECubMQ4AQP2lR
         vH9avtdJD4gysIjXSggH0JMQTG+nCy7E1SH2lK/Vl4VALjJ6HM6vdquqkMdhlZXkF+o+
         2zhUTtO347oRfyvpn6ZvcFALoNR6f4zp9JKHgd14fchcfLAKYobjWcgr0pU6SIgDutys
         p16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=bM94JXTwoxg3mZXJqopeDPFgq+t13ym1AVWz3fY3lAg=;
        b=uL88SCVWgVPxzy5PbMiLlZBESxQUmYdiQM4rJZj2fz6ITVqdxFQQLX1JLA4RHMMZSK
         IA9bab6WBcVR6Nti1X5FmLjbTCggZARPef64d0GdG1saxphuEylKaYeNuP+ZOwcUjx0F
         JDOAjTqgrchykRHJVi0mnlfg1T4GBpK8zjvN4lxxVusijXbu0qo1OcNzgAQ7sgIErBcB
         OTvqjodXyAyiwsVEtCHUsg58mb8Ef5xHmckq74eB+wBgzVQwtH/aysc7teSeFKbhPp2q
         TbFlB5hxYjG3KrSENlqKpdlTPRQFJ7kNUivxb/LS7OC0zPyfmV3LDUj/02HXZgXrrxMb
         2D6w==
X-Gm-Message-State: ACrzQf0fVY43UaRMRnpTTESGQl2x2wlrD5kCP6Fb0QYOVWX8tZrTKGG0
        +c8L8uxtkQ5n4a8j3DY07PM=
X-Google-Smtp-Source: AMsMyM7HeA3RU2O6rzTcJbHTwzScGNhpifcczC2uWjK1Y6uSxGvQWCKlANRNCiUeQOW6ul4nZjrjnA==
X-Received: by 2002:a05:600c:5488:b0:3b5:634:731 with SMTP id iv8-20020a05600c548800b003b506340731mr12226196wmb.188.1664179726652;
        Mon, 26 Sep 2022 01:08:46 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d6642000000b0022ac61ebb14sm13421078wrw.22.2022.09.26.01.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 01:08:46 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, geert@linux-m68k.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v5 0/3] KUnit tests for RGB888, XRGB2101010 and grayscale
Date:   Mon, 26 Sep 2022 10:08:34 +0200
Message-Id: <20220926080837.65734-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This series is a follow up on my work adding KUnit test to the XRGB8888
conversion functions. This time RGB888, XRGB2101010 and gray8 are added.

Best wishes,
Jose

v1 -> v2:

    Tested-by: Maíra Canal <mairacanal@riseup.net>
    Reviewed-by: David Gow <davidgow@google.com>

v2 -> v3:

    Export symbol drm_fb_xrgb8888_to_xrgb2101010()

v3 -> v4:

    Rebased on top of Maíra's prefix renaming work:
    https://lore.kernel.org/dri-devel/20220911191756.203118-1-mairacanal@riseup.net/T/

v4 -> v5:

    Acked-by: Maxime Ripard <maxime@cerno.tech>
    Remove reduntant "_test" suffix
    Sort test alphabetically

José Expósito (3):
  drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb888()
  drm/format-helper: Add KUnit tests for
    drm_fb_xrgb8888_to_xrgb2101010()
  drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_gray8()

 drivers/gpu/drm/drm_format_helper.c           |   1 +
 .../gpu/drm/tests/drm_format_helper_test.c    | 190 ++++++++++++++++++
 2 files changed, 191 insertions(+)


base-commit: 961bcdf956a4645745407a5d919be8757549b062
prerequisite-patch-id: 605f4eb1bbdb8ed39cb2ebed95768d922486099f
prerequisite-patch-id: 3818f7fa7c81927c8a88607c4955a45d614ee69a
prerequisite-patch-id: 634952f085f249f2e18893a3f8344a2ff27c13ad
prerequisite-patch-id: fe7ea3dd385fe6c64d7c5c8d65ebe6f9c7ab047b
prerequisite-patch-id: c92ac7a03faee6e1000637928628e7fd127d0159
prerequisite-patch-id: f52fbd427e8730c62b5554f68713e6fa742ffcab
prerequisite-patch-id: 1a2dc68fd107316fd1d1bb91376fe19bdb039147
prerequisite-patch-id: d91c951338cfe9f06e8b8aa74856f6dc08ac8212
prerequisite-patch-id: 41a65e680affc8011670762aec58c373030ef4ea
prerequisite-patch-id: bbd5bf45c2185a9f2a551447247ce13f81df7c2a
prerequisite-patch-id: 9802d5e3291f150a9ceba345628bbf04be972aba
prerequisite-patch-id: 0bae228d241c6c5567c0b58fa4447a3bcb35d5f2
prerequisite-patch-id: e2ed4b2c89623279d2201a81259b49ce56c5bb38
prerequisite-patch-id: 57b3203672cf7617dc1d63d3eb1373e3b2b7ca34
prerequisite-patch-id: 85c127f8e3d55e4210a00d5c84e2c4f92e2e16ad
prerequisite-patch-id: cad729f2d039e636d2f3f937a9f26b1fb4455388
prerequisite-patch-id: c9e696a62ea5f2d4407914ff7a8371e285f33d55
prerequisite-patch-id: 08f30e5572d2e5a8153b563dd4d8fa0ece2cc575
prerequisite-patch-id: c7f7be4f8e90e5eb473a82c293a6b6a0f417e2ba
prerequisite-patch-id: b0c636c391f5d0ebb50a07222f3e41f48cab8c76
prerequisite-patch-id: 705cc9ff7eb3e3e2873cfdb68c2d2272fde38baf
prerequisite-patch-id: cfbe2b5cbfd69cf9f0b11c7c329cf8ec5a2ecff4
prerequisite-patch-id: e7df3b6bbfb6bb87efaf39e73f2e4ed1f83558af
prerequisite-patch-id: 554f79bc7984201131876865f5c1765c20f84ab5
prerequisite-patch-id: 3b848305159028d4b7e1dd9013050aba60f0ca41
prerequisite-patch-id: 9e9b33181259f59bf03f1fe9b3ef1d6160ae89d9
prerequisite-patch-id: 9aefed850bf64f9015299473087fadf015d246eb
prerequisite-patch-id: 3f886741cdfeff02432de1b0f5ed9d25a2847576
prerequisite-patch-id: 3e81b7138067f19ee34bd7a418c01444979ccab3
prerequisite-patch-id: 59d64b331417360de507c782fc7c33af1ac6dfc3
prerequisite-patch-id: 8b35c6be1c70eaabcd1644a38731139f5be3153a
prerequisite-patch-id: d0008bddf1653ff2452f349b018eaeb3bbcae698
prerequisite-patch-id: dc45c65927286ed6da022ffae1f861cd74efe89d
prerequisite-patch-id: 79665be026f637db6b4ab52cb6cebfb0406c5bb8
prerequisite-patch-id: df37cbcb0f8716cf806910c742bbca83574bee00
prerequisite-patch-id: ea87b84377d7878f9608166731cdbd5acfa0d44b
prerequisite-patch-id: 0158c508dd88a47c2a241a144c73b197bc84a533
prerequisite-patch-id: efbf15a64e673484a4d3187596f2c913e726ef1a
prerequisite-patch-id: 920ebf96ab5fda37dcabd5febf6d8b4123fa141b
prerequisite-patch-id: 8bb836f74b1a7fdc5352ad53eedaa763815a3e04
prerequisite-patch-id: 04c88d73e6c470f9e31864c0a5cd5b3307c54417
prerequisite-patch-id: 55cf446abf46692670cf6591fb3f012e6aeb256b
prerequisite-patch-id: f28093a62972e0106b15128241fd4946e0c25cd9
prerequisite-patch-id: e9c3e896c6d3d8199abca3a2d4f852ee6f8b6539
prerequisite-patch-id: 588661d6d23181fc73748ae49699990fb003d3ee
prerequisite-patch-id: 3edb549d3f36417d929da4be9a0da15c325c8ab7
prerequisite-patch-id: 7897a7b1e3ec3fd588dc4788bbff4bb399683b1e
prerequisite-patch-id: 05f5209e92385701c23665d7825c4d00a1abfd72
prerequisite-patch-id: 634075ca9541a14809bdef5df8c9240134773117
prerequisite-patch-id: 1cfe8abd19e3b8ab5d2ba30991ff5366dedf16db
prerequisite-patch-id: 831a7a6cf76aa3bd41af7764113c48749e40431d
-- 
2.25.1

