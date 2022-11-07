Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1308261FDEE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiKGSx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiKGSxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:53:25 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3004F324;
        Mon,  7 Nov 2022 10:53:22 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id d26so32603329eje.10;
        Mon, 07 Nov 2022 10:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHuTiv5pA7Z5U4slTvhn316jmXmIhRsedaLyw6JXUZ4=;
        b=clr5qcxN412LMBY5jD8myVaJv+L9wuRCNP9/q0SvA2z1598KF3UGP2J0C5iigZtfvU
         vsv4HdZQOZDvbKE3RlQzdHTq1ZGb9Faq4EHy0znY5f/iVgN3e9fDYzzUHgTJO7r6byWh
         ISWs+rkHvzbAF55lPkP+lRcKdgnz86eEG88bTWxS1JCtxRTqnRMThW0g7RLGiQNoqVyx
         I1btALmfkpTjFOJnzWeILL5B0NRLei1XjG98BnoblyGb7EyydcMcy7mIy2Nt5981xKnn
         xXIFyphzuW/cih7rzbt08H113TSopxOVWKECaB/4p/9Y28g4QivR/x8zv0hV+POJ4v/M
         LYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHuTiv5pA7Z5U4slTvhn316jmXmIhRsedaLyw6JXUZ4=;
        b=fDVaCR207JvR4rU2zzyO0Cbgj4FFQ84F4lveI8ab7F8OLeSQZxZ4f1hkTZD4F4IZ5E
         6kZNkagn1CpxeMRCS0kB2wP5+DYvpRtRUsuZtRM99lxkwV1UWn6Zq1TThWzTMx0JCevm
         Rc0RVeS20XRxCNzXW00H+5uPlv4WmczaLnkvR0eu6JZ0gp3rt9levYKXw6/wD+8iiwWL
         w4cSgERBa9KdrAJcsIufit1yqRl8FnIuFzOXde+pPU7njTNyb70SzCV2FfbbPAtDNTYS
         igH1AluD/uf0hQNsLRUa5/R3diz3kaCuKbmw2rbNiEtqR4+wMA17FSA92DILSlYb7Uss
         gmoA==
X-Gm-Message-State: ACrzQf12xdni9/4tk0Na7j7Vt/roxchlRKio/R80GEq7ik2rKHdHd2eP
        ac7yt1yvTr2barMLvwLKyIRHU8paot/G9w==
X-Google-Smtp-Source: AMsMyM7NOS2sIcUk455aW9lYACwFLShzitw0Ev5rmbRLgYjOyibIMT46vE6fi9XSb5TANamUkc0UXQ==
X-Received: by 2002:a17:907:74a:b0:77e:9455:b4e1 with SMTP id xc10-20020a170907074a00b0077e9455b4e1mr49239709ejb.462.1667847200786;
        Mon, 07 Nov 2022 10:53:20 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id u10-20020a056402110a00b0045b3853c4b7sm4624452edv.51.2022.11.07.10.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:53:20 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v6 5/5] riscv: dts: allwinner: d1: Add RGB LEDs to boards
Date:   Mon, 07 Nov 2022 19:53:19 +0100
Message-ID: <1806312.atdPhlSkOF@kista>
In-Reply-To: <20221107053247.1180-6-samuel@sholland.org>
References: <20221107053247.1180-1-samuel@sholland.org> <20221107053247.1180-6-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 07. november 2022 ob 06:32:46 CET je Samuel Holland 
napisal(a):
> Some D1-based boards feature an onboard RGB LED. Enable them.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


