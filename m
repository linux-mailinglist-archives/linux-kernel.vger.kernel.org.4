Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F90264D932
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiLOKCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiLOKBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:01:46 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AFD2A961;
        Thu, 15 Dec 2022 02:01:45 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id fu10so4801627qtb.0;
        Thu, 15 Dec 2022 02:01:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhtBCHHNjoXXg4T30Sb3fCu73wDFb0l1hMsSAjF0/fc=;
        b=I4RFIuWgbHzPtr412BtFDCfKDHQ8ZvNbodm5TTanssloIpgUoCf8VG5EysLabbDXOu
         PbH+aOxOZxDMinbn98lfCXnZcBc9MgDhURLo12ZsP9+DUjJJj+r5n0K8oVIu1yd1SHev
         u61TspyPTvhdeSOM7EBC+oQ6jdxlNhcErx9iQM2eMYTDV6S2ZPccBIqcs7JeKpyedXKi
         7xAGmYnUb3fm/f4D3HKrHqB9lcifEKToVC3I4DG2jplClsnc3sgN5SQWGXTJn5Cl8HGR
         s1hPQyLfvIihcd+LJi+AaDilOkwt6JtZnEdyHH+Q811FQf/5rMWQgH9Ii+twkqw+O5cS
         dzhg==
X-Gm-Message-State: ANoB5pk0u0fzhlcclAA3BmwZb6FJKIX1paNdsJJR/nYqYJKdji+yMU/r
        WhS3fZag5365g1XMeNh4PkbIUdNte5tEtQ==
X-Google-Smtp-Source: AA0mqf5IkZdrOBZF4otQcCnpnY6ghJ5HQxT2GUgozP8oMpULmRVMDD/FomiRwYpxQaQbgUY5SvSk6A==
X-Received: by 2002:a05:622a:488c:b0:3a7:ed31:a618 with SMTP id fc12-20020a05622a488c00b003a7ed31a618mr42865401qtb.7.1671098504492;
        Thu, 15 Dec 2022 02:01:44 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id l14-20020ac84cce000000b0038b684a1642sm3190217qtv.32.2022.12.15.02.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 02:01:43 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id d131so2896458ybh.4;
        Thu, 15 Dec 2022 02:01:43 -0800 (PST)
X-Received: by 2002:a25:7204:0:b0:6f0:9ff5:1151 with SMTP id
 n4-20020a257204000000b006f09ff51151mr66067110ybc.543.1671098503649; Thu, 15
 Dec 2022 02:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20221213133302.218955-1-herve.codina@bootlin.com> <20221213133302.218955-2-herve.codina@bootlin.com>
In-Reply-To: <20221213133302.218955-2-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Dec 2022 11:01:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV7x_-PGfOnHxuXhE-cqSKeugscTe4b_9-_tF2MsSJGPg@mail.gmail.com>
Message-ID: <CAMuHMdV7x_-PGfOnHxuXhE-cqSKeugscTe4b_9-_tF2MsSJGPg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: usb: add the Renesas RZ/N1 USBF controller
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 2:33 PM Herve Codina <herve.codina@bootlin.com> wrote:
> The Renesas RZ/N1 USBF controller is an USB2.0 device controller
> (UDC) available in the Renesas r9a06g032 SoC (RZ/N1 family).
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
