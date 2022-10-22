Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092A9608E7E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiJVQ2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJVQ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:27:58 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C6B13588F;
        Sat, 22 Oct 2022 09:27:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n12so9269525wrp.10;
        Sat, 22 Oct 2022 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3LZtQhmhTtG0av/Vhn5L+1eJ4O3uKOFFREHllICaQw=;
        b=qwKBPuGa1JTF0Lz0r3+ZjdptUqdyXE/Rvkl5x/B8w7r8FeSm49MVyLrsinFqRgQXxy
         lOopTc/54bAT4biIxpZeI9MX7D5PBJ5AmXFxsVd+1BhbGqA8dm/hfy2CkPuQOHG8wf8V
         G8gwFY3mKrO+ib6aO1EE+60Ar2bFZ5GwSichX1192pkD8BP5JfUdlq6viMFDBcCRpzrX
         HZpgAfszR4MTEn98go/JcL0rE+5JQ/5yJSl2O0qzufwxN1Ihy0Do7Me5izt2XRi2QW/y
         mLidQEuvuK0ABThySmoD6VEQ2X7sWRCGRyp8ngN9uPUnw2rt+5u3xNKjGMSMB9x/7qdE
         gaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3LZtQhmhTtG0av/Vhn5L+1eJ4O3uKOFFREHllICaQw=;
        b=EKP0yjFSlzTjLnRRuJ1DwtHgGZ7gsdgNQISppfVFWRZxZJcm+zcvmZ/a6dGCBFjSXr
         ETB64kPTEBXuLOV6sWUwgCITQw3WPyuxaLRWYt0RFd+y1634tvci8nOeZ5f0kLOR55Pz
         q9743pcp9k6PN331oQV0OfnBTx9Cw4RajditONiDV+sSYOhF6fdFBQ0/t3aa4FOnzWCz
         s6BSnptw1hC+lFpvP/eJWSCKiGhxc1tz2EBgkLs0gtuCaedYYkdgI83wU9fnPI2UxRkH
         NHhVT88PvpFJOwwl7zbAVnC32YVSfkoRcyVHmvSgF4e7m1Fr111h3xVU0vQSwxpwwsXw
         f8Rw==
X-Gm-Message-State: ACrzQf3+nD9IG38xcynUUuqCizY+VH/AC5/S8lqlNFh6GvLLtdLFmMgl
        UGus3EvRUgypNFt0AwxM6hY=
X-Google-Smtp-Source: AMsMyM4uW22MGCD0X1eioOOK6RWgjhEs5hH/6KkJcF4htf1J5Ex31+YCsFIIq8V4G3w0t6GQBzlXXw==
X-Received: by 2002:a5d:6da1:0:b0:231:c189:e077 with SMTP id u1-20020a5d6da1000000b00231c189e077mr16103020wrs.114.1666456076553;
        Sat, 22 Oct 2022 09:27:56 -0700 (PDT)
Received: from localhost (94.197.3.61.threembb.co.uk. [94.197.3.61])
        by smtp.gmail.com with ESMTPSA id be5-20020a05600c1e8500b003a531c7aa66sm6141184wmb.1.2022.10.22.09.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 09:27:56 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kuninori.morimoto.gx@renesas.com
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] dt-bindings: ASoC: simple-card: Add system-clock-id property
Date:   Sat, 22 Oct 2022 17:27:42 +0100
Message-Id: <20221022162742.21671-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
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

This is a new per-DAI property used to specify the clock ID argument
to snd_soc_dai_set_sysclk().

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 Documentation/devicetree/bindings/sound/simple-card.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
index ed19899bc94b..cb7774e235d0 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
@@ -57,6 +57,12 @@ definitions:
       single fixed sampling rate.
     $ref: /schemas/types.yaml#/definitions/flag
 
+  system-clock-id:
+    description: |
+      Specify the clock ID used for setting the DAI system clock.
+      Defaults to 0 if unspecified.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
   mclk-fs:
     description: |
       Multiplication factor between stream rate and codec mclk.
@@ -145,6 +151,8 @@ definitions:
         $ref: "#/definitions/system-clock-direction-out"
       system-clock-fixed:
         $ref: "#/definitions/system-clock-fixed"
+      system-clock-id:
+        $ref: "#/definitions/system-clock-id"
     required:
       - sound-dai
 
-- 
2.38.1

