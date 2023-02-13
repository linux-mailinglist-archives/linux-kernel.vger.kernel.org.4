Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36DE695294
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjBMVCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjBMVCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:02:17 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DE293CD;
        Mon, 13 Feb 2023 13:02:12 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e17so6028412plg.12;
        Mon, 13 Feb 2023 13:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676322132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V1LTWYGtfUGQ65Y2ytMG5lRuorQHvhOWBPmJnIlpctg=;
        b=qMCjDPbpkSWkqDdonV6kp8npHrzrxqG/7DCylxhUND7QfEabEgNgYs14sCodwBVosV
         JQP+E6Ei8iEBHwQsycfo9zDtAz670O5qy6oKujnv37coa/fxE6n5NstOwIM54cAFRDrC
         JR5VjdML2Qxlgg9A/5FuPDd4FjgqD8im0lmzw+N/kvmFr2/9d8GT5NrNTcFY4jDmpZMX
         rXZq865wi3/8T5PwPX8tl689GRHLGM1W+CTgliuSVF6PhJBhUUctlRJ/TV4HgCu53W/P
         budwHGfein2xdtMqcYBIF8UJPE4VqTIDkOZQEo+kdBw6LpK+AdB9eqIohojJ5aKQrrN9
         hjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676322132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1LTWYGtfUGQ65Y2ytMG5lRuorQHvhOWBPmJnIlpctg=;
        b=T3xbQANfB5e6rD9h+g6EaNDuhWVTFhfnFiJRyw6yiez5QSAmUk4HAYuiXRiB2b51+l
         t5RHq+645218T4HDSy+oE3MXQgMe+MNYr4LU4qTtspFAzmDvPNn2uNSMO6nGeU8ZLYlw
         PYdjl0724dNOxLH8dGTDOYRha8n+GyVjf8zCMjewKcK0x3IqxZwjYrxg/+Oq6F88dnEQ
         Mh6Wxl+RN4Iqb/T3SLKveOewmV8PII/cqKQ8nQrWRGq9cgH+Fm8Zjy2UWfkI6EKYe1hE
         Rmf9EeiaN/G9tPpMZ+oPnLZT79FYptM2z2SIRmCd+E1xP7IBYkq29BBYrSrtPEUoAwTJ
         Ws1A==
X-Gm-Message-State: AO0yUKUhgrk6sUcVDOOI9sz86XvsLJYzc7o65jp/nwEcF19bmETp0KS+
        iz4kcv/7YTBeMWPT/5YHjyrxl1D9NdtPGKH300EOWLf1
X-Google-Smtp-Source: AK7set/z/xVSawK9QH24PE2E8cXWfzh0yEFCUhqWC/AbZS2DIrs3vKTBeK6J5TkYG8ijlE3WfNDwN63r1vBt8gTjT40=
X-Received: by 2002:a17:902:9a90:b0:199:527d:42c2 with SMTP id
 w16-20020a1709029a9000b00199527d42c2mr71999plp.18.1676322132381; Mon, 13 Feb
 2023 13:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20230213155833.1644366-1-frieder@fris.de> <20230213155833.1644366-7-frieder@fris.de>
 <20230213161548.ucaqpza65byyqvfo@pengutronix.de> <0a1b1338-1d0a-d794-0c1d-9611713eb6fd@kontron.de>
In-Reply-To: <0a1b1338-1d0a-d794-0c1d-9611713eb6fd@kontron.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 13 Feb 2023 18:02:01 -0300
Message-ID: <CAOMZO5Dw-239nG=+qaPbS-Q4kVHCmE9A2SLxiLkJj-dUkdJDrQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: imx8mm-kontron: Add support for reading
 SD_VSEL signal
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Thiery <heiko.thiery@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

On Mon, Feb 13, 2023 at 1:19 PM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:

> No, we don't mux the signal as GPIO. We still use the VSLECT mux option,
> but enable the SION bit, so we can read back the current state of the
> VSELECT signal via the GPIO.

Please include this explanation in the commit log.
