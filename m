Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572D474065E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjF0WJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjF0WJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:09:07 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD4C1BD5;
        Tue, 27 Jun 2023 15:09:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666fb8b1bc8so4947931b3a.1;
        Tue, 27 Jun 2023 15:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687903745; x=1690495745;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tA3a6AQHrEenGtzOB2eYBghaGi3TiCA+RGOHLwGqL1Q=;
        b=kiM9a7bnlsNHBZxD+dqKn33nrCtUMHAZzngTxsabk4vgvS55sFPxikliizQ4Gz36q2
         XCYE52wKJolfC/VI8tFrvknMYrYFJQlG4R/Tsd5N5PYcid7Gk/h9iUXHNUfvU9DMEtnp
         X9TsycWY/4pVRq6CRnNUTzMcEl1k7smMw5V4ENKahUPL3nlsYBByJzaqb2ek+HKnloLV
         QILnk2kDREZAoV+gTLfYyE2R/OrVabY+7loThrzweziF6P1VrH/Mm9P97PdE23L5QeWW
         KGmAhkrLDeRxXxqYpnJEQLUBI907BY26jzNVa5wcG/we6acPjD25Xfy1DhabEovCbMkZ
         LQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687903745; x=1690495745;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tA3a6AQHrEenGtzOB2eYBghaGi3TiCA+RGOHLwGqL1Q=;
        b=W6ntRZBNACIiJwFdGeEx7HNm0C63LZU35syQPHsnYBAH78ZPC64YrIIEroj0b1095F
         ol8A1UYVjcsI5B26J2GfipT/06gu0LJC/0/k+PLABOXKkNjxOdSIaftwc06JYl9zmno1
         G867LSKNnCrA7ygiYrs7AAaUCbJxIAxGQTCXWTIxIAqMthpd01qWyvodGMi8tyWLIXoX
         JW9OG2kX3EgHlRNL04EfgqJKQPZwALJx9lDVQI7dh1Ed/Q/q4i/NAToeH5MjqPljU0wT
         yoxUmwp/T7v82fvvGDN+X2j+oWi6+NiPGK4omwjuUmVJVTth6FeEQR+ex3FFhnXW6mC8
         dCWw==
X-Gm-Message-State: AC+VfDwGIMzERJmvs78I5lsAJwGhG/J1iboa41NvfB7X0+J0Pbq3tO3b
        kQS++pQ8W6xIWLS76EnrFQc=
X-Google-Smtp-Source: ACHHUZ5ep2ahFLcsl/z9kgo33yS4UwwJE7J8o2GhInyKKpuJbTjoYWG8SYfSxOYvXw3wIvHqj4+R8w==
X-Received: by 2002:a05:6a00:3928:b0:64d:46b2:9a58 with SMTP id fh40-20020a056a00392800b0064d46b29a58mr40233682pfb.26.1687903744681;
        Tue, 27 Jun 2023 15:09:04 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:eb71:7977:cb6e:6d32])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78d58000000b0064ff855751fsm5832856pfe.4.2023.06.27.15.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 15:09:04 -0700 (PDT)
Date:   Tue, 27 Jun 2023 15:09:01 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Eray =?iso-8859-1?Q?Or=E7unus?= <erayorcunus@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: input: fix mapping for camera access keys
Message-ID: <ZJtd/fMXRUgq20TW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9f4211bf7f81 ("HID: add mapping for camera access keys") added
mapping for the camera access keys, but unfortunately used wrong usage
codes for them. HUTRR72[1] specifies that camera access controls use 0x76,
0x077 and 0x78 usages in the consumer control page. Previously mapped 0xd5,
0xd6 and 0xd7 usages are actually defined in HUTRR64[2] as game recording
controls.

[1] https://www.usb.org/sites/default/files/hutrr72_-_usages_to_control_camera_access_0.pdf
[2] https://www.usb.org/sites/default/files/hutrr64b_-_game_recording_controllers_0.pdf

Fixes: 9f4211bf7f81 ("HID: add mapping for camera access keys")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-input.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 7fc967964dd8..d7b5ace90bd8 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1085,6 +1085,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x074: map_key_clear(KEY_BRIGHTNESS_MAX);		break;
 		case 0x075: map_key_clear(KEY_BRIGHTNESS_AUTO);		break;
 
+		case 0x076: map_key_clear(KEY_CAMERA_ACCESS_ENABLE);	break;
+		case 0x077: map_key_clear(KEY_CAMERA_ACCESS_DISABLE);	break;
+		case 0x078: map_key_clear(KEY_CAMERA_ACCESS_TOGGLE);	break;
+
 		case 0x079: map_key_clear(KEY_KBDILLUMUP);	break;
 		case 0x07a: map_key_clear(KEY_KBDILLUMDOWN);	break;
 		case 0x07c: map_key_clear(KEY_KBDILLUMTOGGLE);	break;
@@ -1131,9 +1135,6 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x0cd: map_key_clear(KEY_PLAYPAUSE);	break;
 		case 0x0cf: map_key_clear(KEY_VOICECOMMAND);	break;
 
-		case 0x0d5: map_key_clear(KEY_CAMERA_ACCESS_ENABLE);		break;
-		case 0x0d6: map_key_clear(KEY_CAMERA_ACCESS_DISABLE);		break;
-		case 0x0d7: map_key_clear(KEY_CAMERA_ACCESS_TOGGLE);		break;
 		case 0x0d8: map_key_clear(KEY_DICTATE);		break;
 		case 0x0d9: map_key_clear(KEY_EMOJI_PICKER);	break;
 
-- 
2.41.0.178.g377b9f9a00-goog


-- 
Dmitry
