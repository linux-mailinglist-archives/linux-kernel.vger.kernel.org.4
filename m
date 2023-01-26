Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565C567C5FC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbjAZIhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbjAZIhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:37:34 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEB6F752
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:37:02 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qx13so3045156ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unima-ac-id.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBBydtjTCNoLHoaikk4MVmH3r+okeVfzKA/E+1BXIiM=;
        b=Xj+TlIvminVgPO+AeZFLF7lcFcCJSnMuFCYEPS7SeL/bRTl2MuK+a8hjXeZn+pTpyR
         1t4sODlmb6TkwVvItyiSslhBIl21T0SD1zixUwxPB+JjAcj5ZTKq+/tS4orpR5sy2k3k
         LpHBpZzrWReag5ZGuTG9gUeSpuxioPc3mYJ1lTQ3D8kOOSrWeQfxRIOPtPAsN91+ws1t
         mTD6BtHK2CNnXMXft6tLRROOUAJ/JWCeffx/LAsAy2FZKcN8bsEBgiOzSjHmgww4k3Wb
         /05zdEaGcdWiGcnC2t+9DpSNJy9/nZGZ1hlt9BFw0btXfTzMmxm1xityVn4f5pBFmTLd
         IRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBBydtjTCNoLHoaikk4MVmH3r+okeVfzKA/E+1BXIiM=;
        b=qGJBx72avE6L+PqQ8EihEM3R1l4opN2E/H16Ai9GrArpM2TMwlW/RZTtvpa41BJ6lm
         e+mTS/YhFh+sezqqubl88XY+A+OeSRX6Q2u9xJXFnpxuee3T/LCtwm8HD3X9a9I20AWC
         qtiFE6hBzpvnIoovOT1bBBGKaC2CiLy5//SGNdKbi6Z6NP6w9XUqtgC6867z5qVlTQOk
         E/nfxM8rnTuI1YZUVxQAhqL6xqsH4vBvdh6IV4Tp/hqrCuiCvGN8mnHLN4V/sAOTTVlG
         24VGbz9+M6g/fonXKj9OwbRrqrx9GE6cJynNKTgFYpSo+uTE8PB158V6IWyWqHOqq89X
         6z3Q==
X-Gm-Message-State: AFqh2kpRFkSDpOROdnCTPGOUk0LND4q7a2eZYnxsoyaAF9j8bJuHnRQu
        fuYv866AQnwFyM0F656DPLKa1910bgGK8yWiLz8QjTGbo9gXeMTC
X-Google-Smtp-Source: AMrXdXsGS6M/3El9uoS1esLLXJ7cwNHYPgqiSMc5X7rE9NmkLqA8dtFa2xt2CLrfFzQfhllSTfCt877AO7EQnRr2cEI=
X-Received: by 2002:a17:907:c787:b0:873:1b57:b27e with SMTP id
 tz7-20020a170907c78700b008731b57b27emr4734096ejc.206.1674722173915; Thu, 26
 Jan 2023 00:36:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:82c5:0:0:0:0 with HTTP; Thu, 26 Jan 2023 00:36:13
 -0800 (PST)
Reply-To: lisaarobet@gmail.com
From:   Lisa <herdylio@unima.ac.id>
Date:   Thu, 26 Jan 2023 08:36:13 +0000
Message-ID: <CAJZsAooK5GEZQxjzmHabwcP6XN7CTZps+TKX_Sjcpw0Fd-b0Zg@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear

How are you doing today?
Please tell me do you receive my Request?
