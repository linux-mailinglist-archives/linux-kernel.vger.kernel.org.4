Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFAB6190A7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiKDGEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKDGEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:04:30 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F9425C2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 23:04:29 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x15so2528958qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 23:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=j5b9GJzBtekkE7yFtXxrwfdSnFiLUyeBirWgEHrY1DwsCmMNln0raTzRxoGjxR0vEG
         /uxcYigPDNuHCnpdjlCMIgM2n48VEgd9f1vOvLP7QtlQ6TZ60bKdG45TIRdnGWFrYvNx
         Cp55Gth/vM30nQcwiFTGNz/rn848q3Eb4Q4zOcHHfzU4yUla/g4Ad3fhG08vEfC5/R3h
         PPkXOTLacmBas/4TqbxS2EbsHUBC7HUkqW24VFIAAc/oUNQgb1e6AqTct7oO2A3z5CF9
         SDfCYWufECI8AAEV1C876JYV0w0fzKUncqX3+GY4OEtVI/MgHr71Oynl7CVhbajN2Mle
         apoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=5pzwACpUWM2/KOwFqnYh6Ul5m0dJFLtjN2kAzbeOTZKnM7TvKRZfM/cCy0EiMujME1
         Hzq2rgB8/bDbHajUCwsXaaFTkyU1BG2y2B0LTi8TEmDw+qziUCJJXlTKw7BYdIP6DxS+
         isJxX9BHgNnAkwhCDwUFXCo4jvhStSyVJRs8LXm5BVzIfE0dgvaScCLfusJbTQZl5cOP
         c16qVCVVZonXnE4iL9hR4IdMFGIGejZA4iBSoG23aJTatG0VDGmPoKOyZvP6dhKomeI1
         mfRpr6YlHzONU4cwx/W2OlktU5DObAqN/Y1uHvvg03GEs7158bQuuuWnVGn5XvqGYnmn
         EvKw==
X-Gm-Message-State: ACrzQf2cWOL7QMjn16JwHt3pvfAFCngg0snrNRvTlcuPZl/nlMG990ow
        Bc1vbZgoifMS66NCcG/Iwk7IrtaKcq9tH0p8Qs8=
X-Google-Smtp-Source: AMsMyM4d+3oHqwtyFW+7gNpseL+BTezKOejCwfVqbuHSnc4TnvWkrB9jZZGIql1DLTGZWP/QM8LeEdkETfs5XT/OIxU=
X-Received: by 2002:a05:622a:1194:b0:3a5:40c8:99a1 with SMTP id
 m20-20020a05622a119400b003a540c899a1mr13628866qtk.267.1667541868111; Thu, 03
 Nov 2022 23:04:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6200:5e0e:b0:49f:24a7:f1f7 with HTTP; Thu, 3 Nov 2022
 23:04:27 -0700 (PDT)
Reply-To: stefanopessia755@hotmail.com
From:   Stefano Pessina <nancyowuor33@gmail.com>
Date:   Fri, 4 Nov 2022 09:04:27 +0300
Message-ID: <CAN=GBp2sxHb16UOJrQWGG8HwWgM-xtD6Svz2cw0rojg4Fwu48Q@mail.gmail.com>
Subject: Geldspende
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:832 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5009]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nancyowuor33[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [stefanopessia755[at]hotmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [nancyowuor33[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Die Summe von 500.000,00 =E2=82=AC wurde Ihnen von STEFANO PESSINA gespende=
t.
Bitte kontaktieren Sie uns f=C3=BCr weitere Informationen =C3=BCber
stefanopessia755@hotmail.com
