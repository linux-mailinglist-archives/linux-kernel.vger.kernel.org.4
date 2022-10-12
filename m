Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1500D5FC922
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJLQWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiJLQWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:22:31 -0400
Received: from smtp.cesky-hosting.cz (smtp.cesky-hosting.cz [IPv6:2a00:1ed0:2:0:1:5bef:c8ee:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EEEF41BD;
        Wed, 12 Oct 2022 09:22:20 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at smtp.cesky-hosting.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=elrest.cz;
        s=rampa2-202208; t=1665591105;
        bh=8s1G8rPHpjsGwXW21PDH+LArXdE+rGVYILQiiIoRimM=;
        h=From:To:Cc:Subject:Date:From;
        b=MO4Ux6aFNuqJav5oplzpooNe6j5JMfeKDGxAPDlfqb59IpGFsO+wgUNJMsA1MGClE
         AqWUNlKNb5SbUr5n2TvVTwfLKrVTCU+C0IvoLlQD8WxcwblZiO9Bd+rCXi6JMku5Jf
         BHFzbceVjSDjVc3RpbfU19xQGvHQvV8U94RwuQ4ZQZRmgmCIy8Cw2fpjV52/H0niP/
         yEHorwV64O3T12duthfIIIadla5bWdlW9wh/+p0klTeiMTRJ3lOc3dQ5NAOmidmvNA
         uaCc+rQRrIFIN7VemH61IctRJL52Kdoromccdo5YhdkH0S7fZ/BN8++WWDWNSh0xg/
         71z9kN93tt9cw==
Received: from localhost.localdomain (unknown [5.181.92.50])
        (Authenticated sender: tomas.marek@elrest.cz)
        by smtp.cesky-hosting.cz (Postfix) with ESMTPSA id 70E75E6A;
        Wed, 12 Oct 2022 18:11:42 +0200 (CEST)
From:   Tomas Marek <tomas.marek@elrest.cz>
To:     mpm@selenic.com, herbert@gondor.apana.org.au
Cc:     mcoquelin.stm32@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        alexandre.torgue@foss.st.com, oleg.karfich@wago.com,
        Tomas Marek <tomas.marek@elrest.cz>
Subject: [PATCH 0/2] hwrng: stm32 - improve performance
Date:   Wed, 12 Oct 2022 18:09:22 +0200
Message-Id: <20221012160924.12226-1-tomas.marek@elrest.cz>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix issues in the STM32 TRNG driver to improve performance.

Tomas Marek (2):
  hwrng: stm32 - fix number of returned bytes on read
  hwrng: stm32 - fix read of the last word

 drivers/char/hw_random/stm32-rng.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.17.1

