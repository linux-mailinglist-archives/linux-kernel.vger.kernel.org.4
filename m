Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D766F3F12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjEBI0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEBI0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:26:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A22FE58;
        Tue,  2 May 2023 01:26:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24df6bbf765so2055230a91.0;
        Tue, 02 May 2023 01:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683015991; x=1685607991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NThf51HN0Hmw05qsD82aWWnprkGApsME6/ez9gbwYD4=;
        b=n8/iCIrvfM3Rw8xgWdhUOHvVhQBYT7UyRn4HPztbs65ck1gZ1UK76NurJZEocRb5N3
         u8MawCk+S/y6KUip1hIe/R5OBrSL+TPGD86QZ4J6LOkWMmhAZZ80kHCVl9CsWrVex8/E
         aWdKkV9+MswlpLUiDN5ayWNo/0pjjfN9e5OdYLjkYms+IA5xYhRnqbKtyTxnZOIp6ukx
         Ccrt91MjJ3np5M8A2zHvkopMcW6IMAzM5VHzplBVGDHANnhHnulrDqThZKSUa0/3NQDa
         KVwFTS2sLGDsoWX8/1V1/CMb6ymh8NBUE03tEc92HA/b2e5N/XCNPvlu+poiASlCHR1a
         rgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683015991; x=1685607991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NThf51HN0Hmw05qsD82aWWnprkGApsME6/ez9gbwYD4=;
        b=kP1zfEuRTXr7YH/oPYiPQKrUpcSr+qDxnjbXOQD++CZnNn4+k9Q0Fzlu4OqVzSw+ML
         kMsbK//NAtDfXhmsflsPlD8m5It7PgVxr4SL1gc+iGGbPagBuLwQYIGj/YTCggPTJgiI
         eIrdrxHl6LufZB3zbF7IwQNufPztWgn/nps8ZDhYeYcUEfv7Z96XOa4qMHAM03BengVR
         jGxXRe7bo8KtvskkbqIXJ56WxhuyMnKzVelRoBB+7mcL0Hns/6QKiplGkeiBZB7R2lX1
         C/70RO097XZFa5pefIuTqQvcsBr6UyqTwcfmC2Hj75v7wcS7qMXItuX+9jtpbXsE7zcb
         aB+w==
X-Gm-Message-State: AC+VfDwUXlfOR5wS2jPI0AgzAhVq1sN1NcNEM/gW5sFboLngNFtyJrAf
        OUC1KcSkR4B/EWVgsrf+O3y7Xe7NGU07UWfmGZFuNNH1BAA=
X-Google-Smtp-Source: ACHHUZ7iAMN0h55/KOpCIA2bWw9W1t85gvPwlR81xT1RPkW9VX5dLbL993keQOYZwQ17tfDsJPGXC6VqZYdornRJbQU=
X-Received: by 2002:a17:90a:a010:b0:249:6098:b068 with SMTP id
 q16-20020a17090aa01000b002496098b068mr17532296pjp.45.1683015990989; Tue, 02
 May 2023 01:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
In-Reply-To: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
From:   Vincent Legoll <vincent.legoll@gmail.com>
Date:   Tue, 2 May 2023 08:26:19 +0000
Message-ID: <CAEwRq=pKBWsiE1EVf8+k2tZeeEqBpZFgJPCnSN2M005ajbpdmA@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add RK3588 OTP memory support
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, May 1, 2023 at 8:44=E2=80=AFAM Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> This patch series adds OTP memory support for Rockchip RK3588 SoC,
> while also providing a few improvements to the existing rockchip-otp
> driver, in addition to converting the bindings to dt-schema.

I tested this on a QuartzPro64 dev board, I applied your series top of my t=
ree:
Collabora's rk3588-v6.3 + some DT patches to add support for the qp64 board=
.

Here is the output from the commands you told me to try:

# ls -1 /sys/bus/nvmem/devices/*/nvmem
/sys/bus/nvmem/devices/rockchip-otp0/nvmem

#  od -N 64 -A x -t x1z -v /sys/bus/nvmem/devices/rockchip-otp0/nvmem
000000 52 4b 35 88 91 fe 21 41 5a 43 39 36 00 00 00 00  >RK5...!AZC96....<
000010 00 00 00 00 0f 0b 0d 0a 0a 0c 25 0e 00 00 00 00  >..........%.....<
000020 00 00 00 00 00 00 00 00 08 0c 00 00 00 00 00 00  >................<
000030 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
000040

This is working as expected.

You can add my T-B, for the whole series:

Tested-by: Vincent Legoll <vincent.legoll@gmail.com>

Regards

--
Vincent Legoll
