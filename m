Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8209667B627
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbjAYPoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjAYPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:44:31 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A7013D40
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:44:29 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r71so8634195iod.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3zF1nYdKBjRQNQSWjt/QvwgoiL4FcKiQgDKfvefh5Z8=;
        b=Xq0G9QW1eILGpknhueDfUZxU3Vcfc4JINwjduEYSlKIw1cIpuuTo9IVyEfG4aFXmPS
         9Cs3RRUzxtwJqM+beezdyLy00B9tIOQFz76B4LdrspIjjG3Tzpl/YaTOOFHy9naOsLlk
         +O3HPAOsckxiJcPS0/Jm8i9u9WtktHAnz3Gwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zF1nYdKBjRQNQSWjt/QvwgoiL4FcKiQgDKfvefh5Z8=;
        b=lPRdKlfwZevaIw88Eg68TvdVdqAYI/xR79O2e5AzgKe1poVC6WlBB3IESGAcS/cpeP
         yNO+ZMhEi8ukn6cWUabMCmGA2rLtOfEwKYUmB4tCAEXTXPATM9Gfy2dWb917mOy4ly3n
         R4+xpmpm7beamMGO6f8cA48u3iDmfnbfJtrTdUopUbDYthPKMvMFPu8xK17Ck0fyqPWo
         6cK1uPzBZiTNdtRbontiBKXnFCJheMnkagGEf4XpJH2zpbX8gt3S8K3bBu4I9WTN2VOy
         BSGwg4d+EJR0wp6O7u0Rw9fzSGAV56fMSXk96wpa1PGWzPt5VLb/u8tA+iZbCeDYxymo
         2Y/A==
X-Gm-Message-State: AFqh2kraFGSNhPHdaXDi/MvFo0DmkEKs2YEdg+MwarsC45INv0sqiMz7
        RCyVMAGi/a7YkEKVlA4+dxfkng==
X-Google-Smtp-Source: AMrXdXvSoZjz+RcbcmDhSg50QYw/IRuVEj7ADoH6P/0KOBHR5dcHSsPckWtdih/XI8Lr1rB2CZhzLA==
X-Received: by 2002:a5d:9e4d:0:b0:707:6808:45c0 with SMTP id i13-20020a5d9e4d000000b00707680845c0mr3770282ioi.1.1674661468519;
        Wed, 25 Jan 2023 07:44:28 -0800 (PST)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a4-20020a056602148400b00704d3db650bsm1538032iow.46.2023.01.25.07.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 07:44:27 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: leds: fix the following docu build warning
Date:   Wed, 25 Jan 2023 08:44:26 -0700
Message-Id: <20230125154426.12464-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add leds-qcom-lpg to Documentation/leds/index.rst to fix the following
doc build warning.

Documentation/leds/leds-qcom-lpg.rst: WARNING: document isn't included in any toctree

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/leds/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index e5d63b940045..b9ca081fac71 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -26,3 +26,4 @@ LEDs
    leds-lp55xx
    leds-mlxcpld
    leds-sc27xx
+   leds-qcom-lpg
-- 
2.34.1

