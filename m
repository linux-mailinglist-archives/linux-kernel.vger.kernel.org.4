Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DED616317
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiKBMyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKBMx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:53:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F291BE8F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 05:53:58 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y203so2181253pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sz/uTvOc0gNmc74MGKA7yKeLqyFqD/joiI1SxwVZLms=;
        b=QPdi/N4K5dyZqaYEUPuN9znsrKWsfwh430NiiDRtLqBi68OaRPBOl96baYFkKsMkW1
         MIV+la4+jbn7eO2JQcTLj1zwSYJb4vcWrd3nicT4aGNBMWvfnXdFlfpuri9yfU6ubTIx
         LV6UoHd+XtwFQ26ci3dm7rIF/3I6LSKXypVlaASscdUXkVE5BCs3xch9xcwYBpWGNGQy
         eTqjccvNYTtd8MenSpHX38ShXMZdSnl0juF/vyuZft+SjjOuxKZF6703U6qQiMfYyAiY
         PZy0PyXYm20turCTicXMm7npZ1kg4dbru1HZomSQvnn0QRKDA3AhYFwCzuxwXSMwrIA0
         ucPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sz/uTvOc0gNmc74MGKA7yKeLqyFqD/joiI1SxwVZLms=;
        b=AGjZY5UGW8tKzGTFPy5PjHEytFNMd9v6UgTUA/9V7Gyciu1Nuuc0Ad11MjNrmMSkmr
         QumO7/+kwUdgEWKoVZ/BqonhQMm3clenzalpduoqPQW8O9KjyE6CkfAJOh+Cos5pCdTv
         pTylH5LWMtd2ih67v/Gtkabl7S/5HCa8JanCKuSbGtU9jzgFeDVbfUQDy5XaIwTyG/Mn
         Cx6ZZEQR7qmZBTEOorsXGoDha9r1JFQQLn6lv79/bsbPJl3eZ6Amy3VhQwfVggTq2hdN
         utivGvyLMJc4gi7gbNP/zSzPYMaX9V3ppSuyCLABwCyEELMthC0/+A3z6Oi5SB+eFaaV
         9nHQ==
X-Gm-Message-State: ACrzQf2lfEcHyNc9P/crjHMaqtWcrZXJRA+YqZJbe8T2Ks65t4xPf0+Z
        BPWBaN/ThQvSnxjfBQx5gGbd5FzYjlEwvNR7qFU=
X-Google-Smtp-Source: AMsMyM61U4kP/AwEmx8Ns6pmnpFl496NGTJPCi6lwLLzFsCz6P1xbep001BwiJUJhMONLwJUM07ev4VRsIE6EmmBRTg=
X-Received: by 2002:a63:1058:0:b0:44f:a1cb:7eec with SMTP id
 24-20020a631058000000b0044fa1cb7eecmr22145975pgq.117.1667393637418; Wed, 02
 Nov 2022 05:53:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:662c:b0:46:197b:656c with HTTP; Wed, 2 Nov 2022
 05:53:56 -0700 (PDT)
Reply-To: rihabmanyang1993@gmail.com
From:   Rihab Manyang <omardiakhate751@gmail.com>
Date:   Wed, 2 Nov 2022 12:53:56 +0000
Message-ID: <CAAs2n97EyR3k29iVguxQoczvTjWeSjC00wTF0g+BD9inBzwh1Q@mail.gmail.com>
Subject: HI DEAR..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:432 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [omardiakhate751[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rihabmanyang1993[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [omardiakhate751[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
My name is Rihab Manyang,i am here to search for a business partner and
friend who will help me to invest my fund in his country.
