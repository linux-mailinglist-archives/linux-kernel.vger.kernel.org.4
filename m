Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40A55BC368
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiISHPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiISHPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:15:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B013DCB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:15:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y5so2479196wrh.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=2plq+508IwP99yeeN9I7nBd5E7QFpZWSFRVlBG2ZQCc=;
        b=OJatih4+BMj9XH1kCtBeYGBjCKLnY2LzQZdZ+RNIG6Yg6vaDng49xmJSQTYoRzhh8E
         YS828VCreVb2nQig4MMK34JNU+l3ljyCAH/me+o7F0QenBb0vJH3RwVH7m8+DVOC1+zc
         8J77fokokNLQyYIU2wumZpeFxv4ka1s+e0zRm8Pk7GiYFM75qp4BUlwEg8lAI7Of8fgR
         92pq4aPn6KUcsj0EUs23a2A1Ehe5GU+Ng89rGFbUI68gWl9bXuh1VRiVEkIMIAc0xO3r
         1eH2qrYLXaVowxfG1uMbPOjcyc91zePrj5Y/Lr9VONIT9L2ZyFAprYFrSGpSIHrFlkUo
         NnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=2plq+508IwP99yeeN9I7nBd5E7QFpZWSFRVlBG2ZQCc=;
        b=iVHQ3JYMTQNDyXHn3jZYdPeCKGj64gyl21dJBc6OmrHLSfYXpK3oyhiF4SPyJ5JmwF
         ADw+7ulBWX1o+Wam7N1YYcbS60FN6BC02EkgVQvMGtO8ZWCgXTx5xkSdr/IClw/zuM8V
         LN0awz+fLtSiW6BYZMaa1Oa1v40L+arpnjOCsb1EnBVxK0VB04qPzs+YmGAv420Iswjv
         x6c/I1vy32SgmYhNx2Y4LPjytcUqmoQXb7UnkE6PQj1tcqnyojxr1RsDdfi5X42lEA0k
         9ybRISc9+w5Kp2teEeCMtNnf/GPvyFNqBwaafoxSjuLKrnvG4xLG85LWsv6MCx9KnM7+
         pk/A==
X-Gm-Message-State: ACrzQf0XgCmsIX8F/Fs6TjPPCOAVJbhLkxfE8agBpY29qjKyHsLt0o/N
        gwWIshGZcN46aYdpVHwyhSI=
X-Google-Smtp-Source: AMsMyM56TUPeiPVZ/3uFddfRbrw9GBp0fJYmn4swWCAU6OVQ2TH7/QBUVdGnM+LDx0tZ+ag2RKSfJA==
X-Received: by 2002:a5d:64cf:0:b0:22a:b61d:875e with SMTP id f15-20020a5d64cf000000b0022ab61d875emr9382714wri.100.1663571740580;
        Mon, 19 Sep 2022 00:15:40 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d4bc3000000b0022ac12fff29sm12864564wrt.65.2022.09.19.00.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 00:15:40 -0700 (PDT)
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
Subject: [PATCH v4 0/3] KUnit tests for RGB888, XRGB2101010 and grayscale
Date:   Mon, 19 Sep 2022 09:15:28 +0200
Message-Id: <20220919071531.105124-1-jose.exposito89@gmail.com>
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
-- 
2.25.1

