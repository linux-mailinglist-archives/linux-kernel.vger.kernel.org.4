Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388DA5FC03E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 07:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJLF4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 01:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJLF4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 01:56:48 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33819D509;
        Tue, 11 Oct 2022 22:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1665554190; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=kHyfkaFSXKsIudi2PPUrBUlpRFpJt9ZBIp6EYH64gahYd1XqU2tCJZf+4ZNIT8Lb0O8uGjzo/P6RVl152jek0pC70dE5EkCAEDIH44QUV3mNI4hyGSTaF14eC5lQvrKJMLWAZ4OpDfXSDqPjNmlnlybo4VLtuoyI9sbKNOwvmRo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1665554190; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=3OPT6La0yyILaQA8ZiMW97xZB2rAbOV4OPtV+1MiTW4=; 
        b=njfa9XpGf9e1G28hMDxqsNWACJk3tx3++JtvlVOKmQ75QoGdh4tjPrTey/urCoyE+u0WhT5ohxetNm4cQDNc9oJSopmY4o8bBpPltqFeaGHp84ITUpRKxLnasla1h/RyakYO9dK8FP/uJ9MrvIGfHYZjlZyCfYjDzFUyCeBb7UI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665554190;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=3OPT6La0yyILaQA8ZiMW97xZB2rAbOV4OPtV+1MiTW4=;
        b=hWtVFDuqhL8JStrPc9R/YcdW9F3/nTi3x1goeoutyVTNhgDfSgd/2a6ZyA0jgVCA
        aVoBJPI5qXDme41nYxJquX7MB3meoxGpPlJWJKLtWtFsVKRWJ1jmvB0Aod8TPMXpkNy
        soqsfCpdDWfJHNlTbZaAfv6z1S45QJ9ncVOTDQYY=
Received: from edelgard.fodlan.icenowy.me (112.94.102.144 [112.94.102.144]) by mx.zohomail.com
        with SMTPS id 1665554187702589.1497638513014; Tue, 11 Oct 2022 22:56:27 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 01/10] mailmap: update Icenowy Zheng's mail address
Date:   Wed, 12 Oct 2022 13:55:53 +0800
Message-Id: <20221012055602.1544944-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221012055602.1544944-1-uwu@icenowy.me>
References: <20221012055602.1544944-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the SMTP provider adopted by AOSC applied some more restricted
rate limit that is not suitable for sending kernel patches, I switched
to a mailbox hosted on my own domain name now. In addition, there's a
single commit that is pushed to the mainline kernel tree during my
internship at Sipeed the last year.

Map two AOSC mail addresses (both aosc.io and aosc.xyz domain names) and
a defunct Sipeed mail address to the new mail address.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
No changes since v1.

 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 380378e2db36..59b7130c3d1b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -168,6 +168,9 @@ Henrik Rydberg <rydberg@bitmath.org>
 Herbert Xu <herbert@gondor.apana.org.au>
 Huacai Chen <chenhuacai@kernel.org> <chenhc@lemote.com>
 Huacai Chen <chenhuacai@kernel.org> <chenhuacai@loongson.cn>
+Icenowy Zheng <uwu@icenowy.me> <icenowy@aosc.io>
+Icenowy Zheng <uwu@icenowy.me> <icenowy@aosc.xyz>
+Icenowy Zheng <uwu@icenowy.me> <icenowy@sipeed.com>
 Jacob Shin <Jacob.Shin@amd.com>
 Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@google.com>
 Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk.kim@samsung.com>
-- 
2.37.1

