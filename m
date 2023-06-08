Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202AA7284F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjFHQ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbjFHQ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:29:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E211FDC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:29:03 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5162d2373cdso1436476a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686241741; x=1688833741;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dx4wceDFekjvHQM4pccArhhP8EnGfveOZfWbZuBe+f4=;
        b=Otqmw9EGJd5t1uv5fv8KZRxZePZr9DZNDWIh55VF/587TOI8kFdiE/QE6+ETULucEK
         p0tAH7ty9kWtVyNcOUQ3zz7AYF5XNdM6ZP6NTYMXZfjOrzEBtKz5y5fPaY3zKUI+O+Hh
         EYVKVx8f3CkCmFH3oN37RqsxJlf5Fj//JUv1yoFJnBLUt0+g5aK5fSeVLrJf60KSL0OA
         nhTf7KCM813C7YbALdL9ELTScqhQfmVHu6CWghvdtYLVrN+EwHq7GbhIiH2qYD5rzrR5
         V2GAecNjvvClofUTMkPvePEEt8m6fLmOGFWs4LMhhAnrl/K4KQy4Yo4b8lGPElNEY5oi
         /WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241741; x=1688833741;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dx4wceDFekjvHQM4pccArhhP8EnGfveOZfWbZuBe+f4=;
        b=fX3SXC1Pd7pAYHd+oOrLd5TenLlTMXNTn2JrLDoxACurNuW/HurcszSkq98UPkcChE
         VGbE529s6DK224hCMrmE881Az57M90DAxyeh+5c7DvrNK970PGsy1p1y02QiSV6fxJx2
         nnc4Y5K52igwB1ZC0WDb7l5HQmdubZ8HcYO4zD26ms5TldfE83U04JeD2UVLk2dGqMuZ
         58lC274KqM1OFACi4Vx7R4hm5vpBNYIJ0ZGebPFCEx3lAGC8OSfHaL1BBKriMS2s4Q+Z
         ChhZdGjz1pWevneBGsxqiZa7N2rR4CDPN7+3dLWtxuvQC2Dm/n5ireTm5vemCEEeq3Qo
         vdYg==
X-Gm-Message-State: AC+VfDwjyqO2K7MLX/BayBpFmoIGEwXvqD/yHuklbVWGAT3QAcRgn2Ep
        myzjsvwX0sSWt9cRARVstLUY2GUoABY=
X-Google-Smtp-Source: ACHHUZ58XomZ/FJB12G2xiLboOeaIJooEA/AyVgjnXFUz+JFy6MuLckqbWnzXxmmupqlqPf2AWUBUQ==
X-Received: by 2002:aa7:d986:0:b0:514:97dc:9d4e with SMTP id u6-20020aa7d986000000b0051497dc9d4emr8175409eds.7.1686241741138;
        Thu, 08 Jun 2023 09:29:01 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ba7-20020a0564021ac700b0050bc6983041sm716463edb.96.2023.06.08.09.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 09:29:00 -0700 (PDT)
Message-ID: <19bf714a-43f9-c30a-8197-91aaaf4a6e5d@gmail.com>
Date:   Thu, 8 Jun 2023 18:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 0/5] Fixes for Rockchip NAND controller driver
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie contains various fixes for the Rockchip NAND controller
driver that showed up while testing boot block writing.

Fixed are:
  Always copy hwecc PA data to/from oob_poi buffer in order to be able
  to read/write the various boot block layouts.
  Add option to safely probe the driver on a NAND with unknown data layout.
  Fix default timing.
  Fix oobfree layout.
  Add missing chip ID.

Johan Jonker (4):
  mtd: nand: raw: rockchip-nand-controller: copy hwecc PA data to
    oob_poi buffer
  mtd: nand: raw: rockchip-nand-controller: add skipbbt option
  mtd: nand: raw: rockchip-nand-controller: fix nand timing default
  mtd: nand: raw: rockchip-nand-controller: fix oobfree offset and
    description

Paweł Jarosz (1):
  mtd: nand: add support for the Sandisk SDTNQGAMA chip

 drivers/mtd/nand/raw/nand_ids.c               |  3 +
 .../mtd/nand/raw/rockchip-nand-controller.c   | 59 ++++++++++++-------
 2 files changed, 40 insertions(+), 22 deletions(-)

--
2.30.2

