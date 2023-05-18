Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F141708AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjERVxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjERVxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:53:24 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB4AE45
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:53:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-510b7b6ef59so4591311a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684446800; x=1687038800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qUdGRBk8vkDEobXj1EEFFYDM3is2980EC0ozS+Cp5k=;
        b=oGOiWl3eafEZNtkAxlNu0Ri88x6pP1PCK0tJuHezLVblMIMoMAdhDVbHVzdxn8P76D
         g103pcp7IbsSDYNFkzjtgOkJGUZ1h8xn73rNhDgt/7ITfGPEzNLEQflxDvHHnYiQk4KQ
         3bpHglTm7Fji3yc79EfffygaCbKvRVkoFftYOCiVwESMqankT59PQhvP6wQBa7U4fx/A
         6dx4meldQvv8J79HBMV2hp/Jhpx1B/L6oCbiV7/h2l5LLsbrJnwhPfuaRP4hoyjmWHV7
         sPv1MpnYMdiUn7wHQs1XNScjnd7+KpLZYRcj1NIuAVmc9ZFCL0JfrCZwlT9p0ubC7Xgp
         QkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684446800; x=1687038800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qUdGRBk8vkDEobXj1EEFFYDM3is2980EC0ozS+Cp5k=;
        b=CZ3GAtlcZunuT+Lv9momDN64fOxox/06+dCT2jiq1UvZBQ5/z5yYepuhH86LXmZOH1
         3UokDlKuQx2vDpyEwr/ArtH9BiKjucMI0YemBTfiNtlu0PNBibGHCU8ZFaqLGHfGOWZy
         jTO3MkwkBWJr6f7snxvNUcks88jlIAO+VQWBE4Ny8m3E675iSeGByaupZyhs4HczcNDf
         xu5plaMfvj4rblAP8IE7gp6DXRD1R4beqEKvcF3bfm10d1/rk8fqtdqZTWrVx5xZ9nNy
         kT5qC+4rTZFBtHl/wluOSiVJVXy8ZOyed7NDtxdJUT5KIbVfq7WyXM1hxaDt3PuMbK4j
         4h4Q==
X-Gm-Message-State: AC+VfDwouJT33m3rhmAU8icu41mDI1EcZxPO3nQ+1iGG3YROOgzZ8qmy
        pKuR9H4eNAAHkcrITXdtZAC/jw==
X-Google-Smtp-Source: ACHHUZ7Qx/gcLb3K/TWelLEgbLceq0aW8BwxYRRxwSO4G7YN+d8KHh42qlnibN4VEcDHwY04ZLM0KA==
X-Received: by 2002:a05:6402:1492:b0:510:d1e6:56ab with SMTP id e18-20020a056402149200b00510d1e656abmr5911851edv.4.1684446800670;
        Thu, 18 May 2023 14:53:20 -0700 (PDT)
Received: from Lat-5310.. ([87.116.165.75])
        by smtp.gmail.com with ESMTPSA id l25-20020aa7c319000000b0050bd9d3ddf3sm989822edq.42.2023.05.18.14.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:53:19 -0700 (PDT)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH 0/1] media: camss: fix VFE bpl_alignment for sdm845 and sm8250
Date:   Fri, 19 May 2023 00:52:34 +0300
Message-Id: <20230518215235.1668871-1-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to capture an image from SGRBG10_1X10/3280x2464 camera sensor on db845c
board (sdm845), and from SRGGB10_1X10/3280x2464 camera sensor on RB5 (qrb5165 /
sm8250). The captured frames contained incorrect image.

These formats are 4100 bytes per line. 4100 aligned by 8 is 4104. 4100 aligned
by 16 is 4112.

After looking at the frame data captured with the current bpl_alignment value
of 8 bytes, it becomes clear that the lines are not 4104 bytes long, but are
actually 4112 bytes long. That is the current bpl_alignment value is set
incorrectly.

With bpl_alignment set to 8 bytes (the value currently used by the camss
driver):
* on db845c capturing may stall after a few frames are captured OK
* the captured frames are corrupted:
  As the actual stride is 8 bytes more than expected, the 2nd line
  has 8 bytes from the 1st line tail in the beginning, and the actual
  data in the 2nd line are offset by these 8 bytes; the 3d line data
  are offset by 16 bytes etc. When the offset reaches the line length,
  one line starts with 0 offset again, the next line gets 8-byte offset
  etc. This results in "chainsaw shift" of lines in the captured image
  and messed up colours. Also a small part from the end of the actual frame
  (8 bytes times frame height) is not captured as it doesn't fit into the
  allocated buffer.
* "arm-smmu: Unhandled context fault" messages in dmesg output

Changing bpl_alignment to 16 bytes fixed all these issues:
* no capture stalls on db845c
* correct image in the captured frames
* "arm-smmu: Unhandled context fault" messages are gone

I've also used the patch
https://lore.kernel.org/lkml/20230503075340.45755-1-y.oudjana@protonmail.com/
as without it the camss driver is broken in media_tree - yavta fails with
error 22 (invalid argument).

Here is an example console log from db845c with bpl_alignment=8 (stride 4104):
-----8<-----
$ yavta -B capture-mplane --capture=5 -n 5 -I -f SGRBG10P -s 3280x2464 --file=ov8856-SGRBG10-3280x2464-#.bin /dev/video6
Device /dev/video6 opened.
Device `Qualcomm Camera Subsystem' on `platform:acb3000.camss' (driver 'qcom-camss') supports video, capture, with mplanes.
Video format set: SGRBG10P (41416770) 3280x2464 field none, 1 planes:
 * Stride 4104, buffer size 10112256
Video format: SGRBG10P (41416770) 3280x2464 field none, 1 planes:
 * Stride 4104, buffer size 10112256
5 buffers requested.
length: 1 offset: 4098861152 timestamp type/source: mono/EoF
Buffer 0/0 mapped at address 0xffffa305b000. 
<snip>
length: 1 offset: 4098861152 timestamp type/source: mono/EoF
Buffer 4/0 mapped at address 0xffffa09c7000.
0 (0) [-] none 0 10112256 B 818.593063 818.594398 8.942 fps ts mono/EoF
1 (1) [-] none 1 10112256 B 818.661186 818.662596 14.679 fps ts mono/EoF
2 (2) [-] none 2 10112256 B 818.727812 818.729342 15.009 fps ts mono/EoF
3 (3) [-] none 3 10112256 B 818.781710 818.794871 18.554 fps ts mono/EoF
<stalls after 4 of 5 frames captured>
^C
$
-----8<-----

The corresponding part of dmesg output:
-----8<-----
[  658.608956] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0xff9a5000, fsynr=0x3c0013, cbfrsynra=0x810, cb=14
[  658.676875] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0xfd9a5000, fsynr=0x3c0013, cbfrsynra=0x810, cb=14
[  658.743863] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0xfc9a5000, fsynr=0x3c0013, cbfrsynra=0x810, cb=14
[  658.810016] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0xfb9a5000, fsynr=0x3c0013, cbfrsynra=0x810, cb=14
### several seconds after Ctrl-C is pressed at the console:
[  670.950533] qcom-camss acb3000.camss: VFE idle timeout - resetting
-----8<-----

Andrey Konovalov (1):
  media: camss: set VFE bpl_alignment to 16 for sdm845 and sm8250

 drivers/media/platform/qcom/camss/camss-vfe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.34.1

