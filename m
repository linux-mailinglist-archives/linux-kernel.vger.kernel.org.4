Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C92367A7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbjAYAZg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Jan 2023 19:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjAYAZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:25:32 -0500
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25D550879
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:24:50 -0800 (PST)
Received: by mail-pg1-f172.google.com with SMTP id d10so12372074pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gsxQDYJ637mVBncELdhv1LGROnJJn7ORrONb7PiHKCc=;
        b=zNLVQX3uETQUId+A1w0dInqcfsKftArcF3KOxHgNabeChZo3fWRb2CxfZamSoEYcfe
         yx4oz+m6tK3ahjTrNue0eEu7Fsk6CEfrmxoQTeGVuhcsyohgrzOz4uP6kQyjQg5cKa93
         Da4Pjo3nJlxPbZs0NNyNWIgI0+RosyKDhe2bILp1diqun4id6Kbr64l1ZgZt8ddHQgEc
         +Z1FSbGr1I4LzDrhv2TKuxVsaE3OmWxsrie0h8F+QZqn5LDgqwbD+Y/i8bMI/agK1Ff/
         H/UQqoZ4iiCH648lDBLkn1hoVhIY09Y1pcDYBhjLMLXmr5o4/YXhIPGga0ZYotA/Absp
         6LqA==
X-Gm-Message-State: AFqh2kr+1IIIb+UBBlvSJLH3cmrBpCKnaI9ccjMvZ5tqPIoBNlZbXu0U
        Oco92R5g25CdMuTr1zV2/7vRjg==
X-Google-Smtp-Source: AMrXdXvMasxXa5cS8AxFhZik43b2HxYo623z8Gih3oj35j/s73J/68oDQhdvnDxZluU+a6gJZxOL2A==
X-Received: by 2002:aa7:8204:0:b0:58b:9473:7ae0 with SMTP id k4-20020aa78204000000b0058b94737ae0mr30892444pfi.32.1674606232659;
        Tue, 24 Jan 2023 16:23:52 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a28-20020aa78e9c000000b0058193135f6bsm2202152pfr.84.2023.01.24.16.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 16:23:51 -0800 (PST)
From:   Kevin Hilman <khilman@kernel.org>
To:     Bernhard =?utf-8?Q?Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, lee@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        daniel.lezcano@linaro.org, chunfeng.yun@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, nfraprado@collabora.com,
        andrew@lunn.ch, gtk3@inbox.ru, sean.wang@mediatek.com,
        zhiyong.tao@mediatek.com
Subject: Re: [PATCH v8 0/9] Add minimal MT8365 and MT8365-EVK support
In-Reply-To: <20230123163833.1007181-1-bero@baylibre.com>
References: <20230123163833.1007181-1-bero@baylibre.com>
Date:   Tue, 24 Jan 2023 16:23:47 -0800
Message-ID: <7hr0vjh370.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkränzer <bero@baylibre.com> writes:

> v8:
>   - Add binding descriptions for mediatek,mt8365-systimer and
>     mediatek,mt8365-uart
>   - Specify ranges with parameters for u3phy

Built this series on top of v6.2-rc1 and boot tested on mt8365-evk board
locally.

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
