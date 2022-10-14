Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BAF5FE915
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJNGtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJNGtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:49:06 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F281849B0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 23:49:06 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id m128so1825320vka.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 23:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=eLtNIenXMfog8migQ0xFnwlGco5uZQkGjiJv0H+pOCdf/bjtC006C1RBOr/en7uBLa
         kB4u73ujB8f/2Tjpj6+YUHHDh2HASRyXyPkUnQkTsxIlk7EUIt7J/GX3LAIoa1TraXys
         OqsyD0Jh7MlndW3uNUDcf8KbtwImKVQHMJ9fmVDKihhNQqssWPzCLGQc1gUMeXZkhSkj
         W+jiuyFrab9j5ALRsNH68zDibK3U4h2qNDGXYIchJi8gR3e+PfnoJR80flVg9aLWJMoS
         24gAy36nyarH52vC+k7QIQw/9BQuXCYHJs24svPRL82447eLxo7ic34WMzissLz5f0BZ
         37/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=4huVkso5H99CXP9zMIKFR/WfJ1sBMFjQtxl7UqtLKH0Z2UPVcdsu1Eal6nruDsJD+w
         7LoMLwG0JTmcBm52tu/B6hUMMAdTBaBS3o0CN/fDFleDM1zpvRax2YnUDp1wC6Xo2n4r
         Itt6atQnHCgB88ivB6jZhFP6y2Kv0WJg1WyskuC7NUSQN5X4/ykFXSZ8TucnlwwLHS8L
         D67RPxReoO/fNXBfxdK+yXASnRGz9xNqkhf6sCn5wAv92CGVubM2mqHMELrr+47WBvfH
         gpNUiCfJneFkpuTj7DvhS/aWbN7JPaALskmfez8LeZxTCk9XoT9HHSZ5J/oHYhFy3Ksh
         229A==
X-Gm-Message-State: ACrzQf0I+1CGnydKy2Gg4d4NwzjKQKXXwEcjmumPEUA5YdT5r4MnfuI5
        V6omsLUOKlwN9vBal4Sx/5TOZrovKmAp0LiLAFE=
X-Google-Smtp-Source: AMsMyM4H4ovBz4VX+XD4cbGlGC0u7qbId72zBRZ4qLFzXc8N3lOEDGTNa3OnIomzUjydUMpqdm3a60+swmJsESSUD8s=
X-Received: by 2002:a1f:26cf:0:b0:3ab:bb9d:48fc with SMTP id
 m198-20020a1f26cf000000b003abbb9d48fcmr1813050vkm.22.1665730144531; Thu, 13
 Oct 2022 23:49:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6124:1f27:b0:31f:3a2c:27d8 with HTTP; Thu, 13 Oct 2022
 23:49:04 -0700 (PDT)
Reply-To: seyba_daniel@yahoo.com
From:   Seyba Daniel <nadineouedraogo646@gmail.com>
Date:   Fri, 14 Oct 2022 08:49:04 +0200
Message-ID: <CACGeQuv0-xatAUiD8X0Q1Bh-4JY-F3HJ03Yso1gm0-iO0ay_ag@mail.gmail.com>
Subject: Seyba Daniel
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am so sorry contacting you in this means especially when we have never
met before. I urgently seek your service to represent me in investing in
your region / country and you will be rewarded for your service without
affecting your present job with very little time invested in it.

My interest is in buying real estate, private schools or companies with
potentials for rapid growth in long terms.

So please confirm interest by responding back.

My dearest regards

Seyba Daniel
