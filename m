Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE6A6D0051
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjC3J4u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 05:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjC3J4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:56:43 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106557EDF;
        Thu, 30 Mar 2023 02:56:34 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id p203so22693900ybb.13;
        Thu, 30 Mar 2023 02:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680170193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KJg02eNLPE8a3Rhgt2rU5aLTNAuPmbB5Y1zPg7loDs=;
        b=quKyQIx4RlXvwwcrrjL302uIQ+FbvaEGCM0UIxbCR3o4P52snOCZF5ORoj7veq5SHE
         keeom+bLcpRyFf70J8SLes07WCNY3owVsBtAp2Qam8O6/E/9HbeM+vmp+0lZEe5RnLeY
         KXEbFAXK+WEGxlMlBWMdcm3AWvrSJBHldzifJr1M/3hUJ+/rl+EIx3KMxvCl08oFPr9s
         Jmhg98FC3cATvfhbbP5VW2bwMGYG5Q15/oUw5YPd4c7Zd4ScfcC02jx/EZzfuj1TTQgJ
         lN/PlyTEAxtokPFgoaav9x5uPpCZRzegltgOf/yv+EhYLcGjTjPwh6a97/pJy02Apl22
         Lbbg==
X-Gm-Message-State: AAQBX9ehs/ZW5Ag3v7DXAHeG9IhS5uQPXAhpiQo4/zo56OVneqQyF0Xv
        i0ipP1EhjmpYEqpYlF+rq+OUDThmDyg0sw==
X-Google-Smtp-Source: AKy350ZMyRTu06ORPwgNVQZ4p6pJTn7I2gW7wFuPqzif2rtdw/IPFivUUWn1JbCHSeR341o8b8xALQ==
X-Received: by 2002:a25:f609:0:b0:b68:129b:6127 with SMTP id t9-20020a25f609000000b00b68129b6127mr22134987ybd.50.1680170193700;
        Thu, 30 Mar 2023 02:56:33 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id 22-20020a250316000000b00b7767ca7464sm4021690ybd.1.2023.03.30.02.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 02:56:33 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id n125so22709627ybg.7;
        Thu, 30 Mar 2023 02:56:33 -0700 (PDT)
X-Received: by 2002:a05:6902:154e:b0:b77:d2db:5f8f with SMTP id
 r14-20020a056902154e00b00b77d2db5f8fmr14607217ybu.12.1680170192917; Thu, 30
 Mar 2023 02:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230317123314.145121-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230317123314.145121-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230317123314.145121-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Mar 2023 11:56:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVLb4SWr_5A7m2z5hOMoUtxrts5-8GedaF68ejV+aM+aA@mail.gmail.com>
Message-ID: <CAMuHMdVLb4SWr_5A7m2z5hOMoUtxrts5-8GedaF68ejV+aM+aA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: renesas: rzg2l-smarc: Enable CRU, CSI support
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Mar 17, 2023 at 1:37 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable CRU, CSI on RZ/G2L SMARC EVK and tie the CSI to OV5645 sensor
> using Device Tree overlay. rz-smarc-cru-csi-ov5645.dtsi is created so
> that RZ/G2L alike EVKs can make use of it.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi

> +       ov5645_fixed_clk: osc25250_clk {

Please no underscores in device nodes.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.4, with the above fixed,
and with the includes moved.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
