Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C305FFCA2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 01:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJOXef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 19:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJOXeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 19:34:31 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D36625DF
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 16:34:24 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id p127so8030588oih.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPQelZHWBax8evlJitFJezC2LMaDni97t0+7jQuxYBI=;
        b=HOrXZaMALQvNg42ExZNKSVde7MtDk23foFTZBE9YpthRYiIX85Sv2QBKRqQChKTcvn
         8FVlW42HHGxgCv7Dm0TI8Z0ua1sjQwGpw7ZBBc2Qp6oOSSQjjW3YpPM8iiqxL7E0P5MQ
         HdK3C17/7t1lkcMpheZTiYHP5fAOUDMplxFQjDm/qhzcxy3N/kyB7X4YinQuPujtsSPk
         thMljsu+4laXO/oeXLb6w4UoJvbnm9feoAbIPMZ4vcGtGy0E5WbN95cfc91Hhocz81gY
         DmVjrgPFTvOdIBOzavtLGiOw+RD3GB4zvzQtv70r9niAqFIfYjNdJDybJ4ueQnSMVfh6
         sXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPQelZHWBax8evlJitFJezC2LMaDni97t0+7jQuxYBI=;
        b=HUGq5nKwBH7x6CvXmwAFJ8V0uvco5a1d8/kD70jLA+58nldjTzL5/MNPN4ceQZBZ3r
         wrk5GM/GZPV6qgZnktgQFp+xW6Qi4pj9F1UKvAXZ1izvczHzR/goMSxty8MkTYTAF1Ew
         8RMu6vZXSqYK11LiCtnZIR6lyvxeMpoTBQ3Jgvp8utppEqc+bjTKj5eohhUis7S2XCMF
         dWkeYaYf8+fq7FnRP3+O/TSkGSprdoYwk/2+YGuVlTTy85sUL+8ZD5rcFkY1lxERgClw
         HZYmtB0uZQCNqqcSUiKvNBfkQQIJFV9sEKxohvB3wc5Ay6Ro6pR8cAQvW7djcCIPCsnc
         U5wg==
X-Gm-Message-State: ACrzQf343T4OdRHu3BH451oXZMZmpbVMrJN8VrAFByk6Ut0PS+wqZMMW
        A+TcyqpKs0ZFWcVli2vF9M0=
X-Google-Smtp-Source: AMsMyM7WBa77EYTPszdGxQxNIvpLW3jDSEXTtR17wU4RbToiz0BGZnJfbXq9V1NOG4WnlvAk5Vj9yg==
X-Received: by 2002:a05:6808:bcd:b0:353:d856:64db with SMTP id o13-20020a0568080bcd00b00353d85664dbmr2005727oik.168.1665876863699;
        Sat, 15 Oct 2022 16:34:23 -0700 (PDT)
Received: from bebop.lan (2603-8080-2704-6601-b457-170a-9e05-cc6d.res6.spectrum.com. [2603:8080:2704:6601:b457:170a:9e05:cc6d])
        by smtp.gmail.com with ESMTPSA id w3-20020a4adec3000000b004808e0d8467sm2653858oou.2.2022.10.15.16.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 16:34:23 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH 2/2] sound: dice: Add support for Firestudio Mobile
Date:   Sat, 15 Oct 2022 18:33:30 -0500
Message-Id: <20221015233330.8679-3-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221015233330.8679-1-thirtythreeforty@gmail.com>
References: <20221015233330.8679-1-thirtythreeforty@gmail.com>
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

This device is of the same vintage as the already-supported FireStudio,
but with a reduced input (10) and output (6) count.  Add a configuration
block for it.

	$ crpp < /sys/bus/firewire/devices/fw1/config_rom
	               ROM header and bus information block
	               ---------------------------------------------------
	400  0404bc6a  bus_info_length 4, crc_length 4, crc 48234
	404  31333934  bus_name "1394"
	408  e0008102  irmc 1, cmc 1, isc 1, bmc 0, cyc_clk_acc 0, max_rec 8 (512)
	40c  000a9204  company_id 000a92     | Presonus Corporation
	410  047da647  device_id 04047da647  | EUI-64 000a9204047da647

	               root directory
	               ---------------------------------------------------
	414  0006147f  directory_length 6, crc 5247
	418  03000a92  vendor: Presonus Corporation
	41c  8100000a  --> descriptor leaf at 444
	420  17000011  model
	424  8100000e  --> descriptor leaf at 45c
	428  0c0087c0  node capabilities per IEEE 1394
	42c  d1000001  --> unit directory at 430

	               unit directory at 430
	               ---------------------------------------------------
	430  00048030  directory_length 4, crc 32816
	434  12000a92  specifier id: Presonus Corporation
	438  13000001  version
	43c  17000011  model
	440  8100000f  --> descriptor leaf at 47c

	               descriptor leaf at 444
	               ---------------------------------------------------
	444  00057914  leaf_length 5, crc 30996
	448  00000000  textual descriptor
	44c  00000000  minimal ASCII
	450  50726553  "PreS"
	454  6f6e7573  "onus"
	458  00000000

	               descriptor leaf at 45c
	               ---------------------------------------------------
	45c  000792a9  leaf_length 7, crc 37545
	460  00000000  textual descriptor
	464  00000000  minimal ASCII
	468  46495245  "FIRE"
	46c  53545544  "STUD"
	470  494f5f4d  "IO_M"
	474  4f42494c  "OBIL"
	478  45000000  "E"

	               descriptor leaf at 47c
	               ---------------------------------------------------
	47c  000792a9  leaf_length 7, crc 37545
	480  00000000  textual descriptor
	484  00000000  minimal ASCII
	488  46495245  "FIRE"
	48c  53545544  "STUD"
	490  494f5f4d  "IO_M"
	494  4f42494c  "OBIL"
	498  45000000  "E"

Tested-by: George Hilliard <thirtythreeforty@gmail.com>
Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 sound/firewire/dice/dice-presonus.c | 7 +++++++
 sound/firewire/dice/dice.c          | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/sound/firewire/dice/dice-presonus.c b/sound/firewire/dice/dice-presonus.c
index c85178e64667..8b62495846f1 100644
--- a/sound/firewire/dice/dice-presonus.c
+++ b/sound/firewire/dice/dice-presonus.c
@@ -17,6 +17,12 @@ static const struct dice_presonus_spec dice_presonus_firestudio = {
 	.has_midi = true,
 };
 
+static const struct dice_presonus_spec dice_presonus_firestudio_mobile = {
+	.tx_pcm_chs = {{10, 10, 0}, {0, 0, 0} },
+	.rx_pcm_chs = {{ 6,  6, 0}, {0, 0, 0} },
+	.has_midi = true,
+};
+
 int snd_dice_detect_presonus_formats(struct snd_dice *dice)
 {
 	static const struct {
@@ -24,6 +30,7 @@ int snd_dice_detect_presonus_formats(struct snd_dice *dice)
 		const struct dice_presonus_spec *spec;
 	} *entry, entries[] = {
 		{0x000008, &dice_presonus_firestudio},
+		{0x000011, &dice_presonus_firestudio_mobile},
 	};
 	struct fw_csr_iterator it;
 	int key, val, model_id;
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index f75902bc8e74..f31ea2bb7766 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -374,6 +374,14 @@ static const struct ieee1394_device_id dice_id_table[] = {
 		.model_id	= 0x000008,
 		.driver_data	= (kernel_ulong_t)snd_dice_detect_presonus_formats,
 	},
+	// Presonus FireStudio Mobile.
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_PRESONUS,
+		.model_id	= 0x000011,
+		.driver_data	= (kernel_ulong_t)snd_dice_detect_presonus_formats,
+	},
 	// Lexicon I-ONYX FW810S.
 	{
 		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
-- 
2.38.0

