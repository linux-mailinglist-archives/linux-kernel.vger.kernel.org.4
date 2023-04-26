Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B526EED04
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 06:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbjDZEmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 00:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbjDZEmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 00:42:50 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B49B2702
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 21:42:48 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id 006d021491bc7-5476a2780a0so2806981eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 21:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682484168; x=1685076168;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEkw1KmmzfmMdZjy2G/k2kJ9Rp06l3CUoffIihDDUro=;
        b=ahJMIWTh5hWsknwjxsHnHQo9L9VjzYcn1k/0nU23PU9uEZU8NalnBK3f9aVgzZCo5r
         +p006FX/ZwqMvKSjA6VHEj3uIqzR993g9P1CrFK9Fivzgwmca8kxjeyWkyvWkLEi20By
         rct6ZAMuikhMKj/3DXx5AKfXigvurLbq4PilgTtzLaX/aYV2jyLFb01f0/lE77UE8BOc
         ML+1/nS9zkVDTQXcJNJoyM+er+SvJwqMhIgEhQBdEjVaUbzrCEWRuqiCz7c6sMP2L2E+
         MlXEZJFcfRL02s5L4RO1N8I6SOXxlWfGIeqLuoo5V3O7DfHscz5K73m9EKR1oRzUmK1z
         5l7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682484168; x=1685076168;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEkw1KmmzfmMdZjy2G/k2kJ9Rp06l3CUoffIihDDUro=;
        b=EvyDZ0pTxK5X21uh1MIpi3zYfBa7NYSq53Vdo69ZpGg6n43U2APKrfDJaTjNRly6e+
         2PW5RCFT557/vNKkE4PKMKgukP+OeCLNJYHzAxvown6Sw3ItXMCTWQos+ctuRE9ZGfJE
         wC6rZ2e8auEYJak2RIam8kUGktigcqeWCgwmdpym0/+r6b0ElqKRArI/YIP28sJwzDba
         m7Bsfkp4Fg+bZWIi2xMNcMBh2XbOAIJMdBKa82smwlwrTeIC1G7cXQoGR3IW4Ppe6xy2
         N1u1Ikdnz1MN9zN/LFyh0qDHUVjrXGYYpq3+1yupKNNp3PS6uPulFTU1/1HIn3OJt8G8
         YESw==
X-Gm-Message-State: AAQBX9cQiEzJFonxEllZQ1G7mVOD+Lyf1FwCztZR5q2K9N0+8kVaLK3b
        CdNNSxIxl+VeIuFB0q0DUD13X9ARM9KzLFoXbyA=
X-Google-Smtp-Source: AKy350bOLIyI+w9KrBjo8wnTDAYvlhBLAGs13pccFIMH9r8rI9git9fbIly8hLQTWzX3A/fyOGsGfQkHlyrIgnqmVnc=
X-Received: by 2002:a05:6808:1885:b0:38b:6c2c:3168 with SMTP id
 bi5-20020a056808188500b0038b6c2c3168mr10879839oib.35.1682484167861; Tue, 25
 Apr 2023 21:42:47 -0700 (PDT)
MIME-Version: 1.0
Sender: mrs.nicolemarois555@gmail.com
Received: by 2002:a05:6850:190d:b0:472:4a8e:9aa6 with HTTP; Tue, 25 Apr 2023
 21:42:47 -0700 (PDT)
From:   AVA SMITH <avasmith1181@gmail.com>
Date:   Wed, 26 Apr 2023 04:42:47 +0000
X-Google-Sender-Auth: oLN8TkQTeeK3qe33xEXBWukGFxo
Message-ID: <CANiD9SJaRynGGmJb2Z8thdK8fg7qLtPr09Js5yoCTSpw2g-c1Q@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
My name is Dr Ava Smith,a medical doctor from United States.I have
Dual citizenship which is English and French.I will share more details
about me as soon as i get a response from you.

Thanks
Ava
