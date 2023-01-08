Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C33A6618CB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 20:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjAHTnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 14:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbjAHTnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 14:43:07 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364E3657B;
        Sun,  8 Jan 2023 11:43:06 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id cf18so8954097ejb.5;
        Sun, 08 Jan 2023 11:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8y9U81icQc5CymJqCVNwmS2br5KE7MjRQmToRytln/U=;
        b=TeyAYieX6SiWKoHyEcjf8oabC/ITVVbpLSDqecBNKgMpfnMU+SXf7lJq0QFIjSnZp3
         okvL7+uUz69DfPUveXiluSx5hMuFvHlEVsg4UEXlF6qslEDN6B1icXt2x4jWoXm543ch
         kXLq3mfSJI8yAbyYBG1kej8gULczB7QPCZJQ2uIRYwJrhiZ5OPiuoFy+NyT+JLV5u7UB
         N2VTh3oITYNwZpz6jC9cYzPDmDbQ4cM2j1lJLC5ecWrVS/nv4UV7EzCE/+BWjBQU1Kzl
         PVIsPin/ObDqyKYPwq4ahWrfesB5IkVsPkFEQ0lL6zLu3yMUAcyfbPqT/x8P/AGfAnaS
         orew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8y9U81icQc5CymJqCVNwmS2br5KE7MjRQmToRytln/U=;
        b=nrnd0ItYzCVBsoXMrf60XFWTDVUyqnDMvuX++vN+Gm8joSiAGjBRV7flJJN9DuYRYM
         T7GKbrX6tyD5lLku9jyyxtIXsTwLX7C0S3dk3skyRI7X3821gxD6kMQBQTCsZmCKuGVc
         5zGoiQP/HZfxzp+mTGRD3LchjR5u5NSi7E8/eivObsq9E0FZteEco/1LiBWgyIL4Lomz
         RJCyIoSmKa+bNN2jEEq/WmlGgkF/5I1jolzgb9ucHGVztcOZXY21oEFzoRiwQNnbFASG
         gbMAMQnltDc6N9iUSUHJBt1EkTCBj6bdXcTGGH2A8eO5eSNs55RtShdRBxHjJl5VVXH7
         oaoQ==
X-Gm-Message-State: AFqh2kruh1LClCqCZcCVUGj37t+d1Qe1OdSrggNJa/y6cTlFbOp09B3B
        XJ4b6I3nhemlaH+t7LrVncc=
X-Google-Smtp-Source: AMrXdXtUsksWth0ExwrvDVj11kAs1zImOH59i8k04fs2sSx5LdUhMM+u3csRML6CgOjcKRMOA36L7A==
X-Received: by 2002:a17:907:cc1c:b0:84d:207d:c008 with SMTP id uo28-20020a170907cc1c00b0084d207dc008mr6065742ejc.69.1673206984840;
        Sun, 08 Jan 2023 11:43:04 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id q22-20020a17090676d600b0084d42b9819dsm952055ejn.28.2023.01.08.11.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 11:43:04 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] rtc: sun6i: Always export the internal oscillator
Date:   Sun, 08 Jan 2023 20:43:03 +0100
Message-ID: <2303942.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20221229215319.14145-1-samuel@sholland.org>
References: <20221229215319.14145-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Dne =C4=8Detrtek, 29. december 2022 ob 22:53:19 CET je Samuel Holland napis=
al(a):
> On all variants of the hardware, the internal oscillator is one possible
> parent for the AR100 clock. It needs to be exported so we can model that
> relationship correctly in the devicetree.
>=20
> Fixes: c56afc1844d6 ("rtc: sun6i: Expose internal oscillator through devi=
ce
> tree") Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


