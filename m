Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9375FDE09
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJMQNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJMQNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:13:22 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CA61382C0;
        Thu, 13 Oct 2022 09:13:21 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id cy15-20020a056830698f00b0065c530585afso320414otb.2;
        Thu, 13 Oct 2022 09:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bDreIWRzsR6jrvQkmaVxro1G4iBmu4ZMAyB7ovkP5pk=;
        b=3JCUVFmrcf8OCMEHwf22HzZWfCZsAn5HsX6u+sTxKGAIAlZFdviFRW/ozneNQ1FD+x
         1Ctb0hAbWoIRG4J9O/fXNFAFEM1BfvuEWgwJ8e8Ua6MzNsBpDgxtPFVeGSBEAQgT4kb7
         mu7vyngpvpWz5swymEWXXdAK+EuVACT9mH820lanflaaCH4XUJF+A1LFh3g5lnDL7z2Y
         eKJ4pO+BUaG0+/So1S7fMQrgzXEIP8x42iXtcEGlXOjhjCURMTR6xskQO2bwghXJvi0K
         tQtR8JXnfHPqRhWzpBZ7gA0kLQbdO+qRCoLDMTI1Gq58Hkk9dggQEp9+z0XMAC1TFLHc
         c9AA==
X-Gm-Message-State: ACrzQf2Wsb20hgde6SxGkj3mIQL+lVsAjCDsBTiq6B4SeU1Vgjhh/2xU
        Qgn59XbIiBd+VEFnsSjvMw==
X-Google-Smtp-Source: AMsMyM4s7hJ3dkhHBslh1BX/Q4zgzgsf9W3g91Nq4KzOpU3zRtcLEPIqpcjS8NIWCpRFbiidc/BbZQ==
X-Received: by 2002:a05:6830:16c7:b0:661:b465:6e1e with SMTP id l7-20020a05683016c700b00661b4656e1emr391867otr.124.1665677600949;
        Thu, 13 Oct 2022 09:13:20 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q8-20020a4ad548000000b00475d676d2d4sm2269356oos.16.2022.10.13.09.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 09:13:20 -0700 (PDT)
Received: (nullmailer pid 492565 invoked by uid 1000);
        Thu, 13 Oct 2022 16:13:22 -0000
Date:   Thu, 13 Oct 2022 11:13:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.1, take 1
Message-ID: <20221013161322.GA447023-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple of DT fixes. 

It's not just merging the code for MT6370 that's been a mess, but the 
bindings too with individual pieces picked up. But hey, it's 'just 
documentation', so no one cares.

Rob


The following changes since commit 49da070062390094112b423ba443ea193527b2e4:

  Merge tag 'memblock-v6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock (2022-10-11 20:48:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.1-1

for you to fetch changes up to 917c362b5f8a6e31ff35719b1bacfc1b76a1fd2f:

  MAINTAINERS: of: collapse overlay entry into main device tree entry (2022-10-13 10:58:09 -0500)

----------------------------------------------------------------
Devicetree fixes for v6.1-rc, part 1:

- Fixes for Mediatek MT6370 binding

- Merge the DT overlay maintainer entry to the main entry as Pantelis is
  not active and Frank is taking a step back

----------------------------------------------------------------
ChiaEn Wu (2):
      dt-bindings: leds: mt6370: Fix MT6370 LED indicator DT warning
      dt-bindings: mfd: mt6370: fix the interrupt order of the charger in the example

Frank Rowand (1):
      MAINTAINERS: of: collapse overlay entry into main device tree entry

 .../bindings/leds/mediatek,mt6370-indicator.yaml           |  5 ++---
 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml |  4 ++--
 MAINTAINERS                                                | 14 +++-----------
 3 files changed, 7 insertions(+), 16 deletions(-)
