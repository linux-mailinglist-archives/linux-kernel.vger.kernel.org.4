Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EFC5EEAFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiI2Bdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbiI2Bdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:33:45 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A07211ADC3;
        Wed, 28 Sep 2022 18:33:43 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f193so167422pgc.0;
        Wed, 28 Sep 2022 18:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ZxQQLMUNaY7eMCarfGC4wOnU7JZ2k48wyRFxQNdExVs=;
        b=kCd2f6WlsfdYuM84nHXHWUYadYtZuAR1i1gDf59TYRQcNWRcDu9+/KnJg/Uk6cv0Iw
         MkhNOF2ITFL0bbWRHq+phwB5lVaaUtOgeQ5ix3EVwGsPzaT1f46UQdNxMwAYtZB75ARq
         s3CsEDUoHzQGInjkSqtuvSWiBX3ou9J8GHecBX9txhrQyX9afDNBZGgGswhZ9bV6IE33
         IH+ybP3J7Tq/CY9o90PjliIHiJ7iSfaiUbTRQqYZVsl8nDKJY+LY47HAW6qIUrpnfhjY
         gmS5YevMqwOEbBFJae427mshElrnatZCiXzXo+vlbTPRueBMPgWJoWsOIB2ia+I0knJb
         ZgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZxQQLMUNaY7eMCarfGC4wOnU7JZ2k48wyRFxQNdExVs=;
        b=HLAPycYYJ+PGpTO5uvqVXdGfOlQMaxBjwb5YZZwLVwYcsihFv0weuM7LvBm3E0qyMD
         6WdK98anWge//5TxjV7wgochXGX93umKGKQA3Yx9Cdfj2FgswLF6Gsiqc6ru9CsB8web
         u5QOuoKE+Z0JEjPip45fxtFmyDGcmmmZdMyiivXAzrPlC9AG85gCHhmBJrw15R1P6Fl6
         8/9oiB/ixDs2Ruyhf7fbaPkxovD8JY574Cc1hHVO6NaXBElXg9nrDg1epKZOvCZUx9Ew
         +kNGmKvQtkVpT+SW8EZjbEIWfSzRsr/4oHs7GXOW98s3cAeiZaCghpZ5zoRORrZuPTZH
         EJkQ==
X-Gm-Message-State: ACrzQf287Dnzl6LI98w8xOtWe65R2hN2Cg9L4iZT0J6lm1Wji0PCWws2
        Fnj0J/pEYxq6Zte63/o50Rc=
X-Google-Smtp-Source: AMsMyM6OYWGO3w4kbWcMFzFaX3GeeKCuUgKS2uXZqekStmNfKYTEM0OyTiyM7RPJvIZhUPDuYt4cXw==
X-Received: by 2002:aa7:9801:0:b0:553:1bfb:9669 with SMTP id e1-20020aa79801000000b005531bfb9669mr941313pfl.15.1664415222945;
        Wed, 28 Sep 2022 18:33:42 -0700 (PDT)
Received: from localhost.localdomain (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902ca0300b0016f85feae65sm4385587pld.87.2022.09.28.18.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 18:33:42 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 0/2] ARM: dts: aspeed: bletchley: Update Bletchley BMC devicetree
Date:   Thu, 29 Sep 2022 09:31:28 +0800
Message-Id: <20220929013130.1916525-1-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
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

Update Facebook Bletchley BMC devicetree base on Pre-PVT HW design.

Potin Lai (2):
  ARM: dts: aspeed: bletchley: update and fix gpio-line-names
  ARM: dts: aspeed: bletchley: enable emmc and ehci1

 .../boot/dts/aspeed-bmc-facebook-bletchley.dts   | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.31.1

