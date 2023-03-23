Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476856C7321
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjCWWbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjCWWbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:31:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68E129141;
        Thu, 23 Mar 2023 15:31:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id ja10so245720plb.5;
        Thu, 23 Mar 2023 15:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679610694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVUtcmd+yNhrVHPf+Y/jgWa/EGmzMjYoIBwSg0pvSJ0=;
        b=L5/cEiIQ9C96QxutTraqylCLoIi4nFpCD1ty4Xx2Am5YDc/oyoZBRrkQ0DFbTEHzJG
         fKojxvGdQ5CCHIDlYol66Nk8OPPPxkue8gdRpFS+Ci4bA2TGtygs0VmWzK3PAbADT/hC
         9dCVWNzSODc+LXC3MFbQpN9GhhqxS5F/otsNj30bO8I0PCDhBbvZXc30L/VTd/NQxYWA
         mglka1SdxPm3msDC4prtbH16xoKpJB7UhV2ctiHjpVpTQNsQhQ6Dj16G1cEeR822NPJj
         FgLOd5uunJ5/J/1/Yszf23kjs4r4lq39IeRlHGNt5QXxqn96S62bzpAX1nneBt9EpFSo
         fPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679610694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVUtcmd+yNhrVHPf+Y/jgWa/EGmzMjYoIBwSg0pvSJ0=;
        b=HwxBvUcdTFUybuvbhs39SWxLlbsDX2OxcOfRgp6GfIpRc5LjWThI6Pb34AlOms8zyt
         qR4u3+qieLh0MvVn8Tf3wDgPQgRf+Pxp8SQkZ2ZKoDS8GEBYqKJBEX8dZF88SdnVK+iO
         +SiyosbZ9uCyVFdcUHrS6jQDxLeeP3OLT4ZvqBgx3+fbJZwalqUgWy7FobhuX8svpq3e
         0bL9imlD4dVLFGVNaHqZv4CENSZfYSCJj/Da1XzxoAcavVxRpRd2ttTEYxB0CUj6dCVD
         kJVAvS3NMcR6iZ1JO6eb8nhz9dz/AH2oeZS6FBW+Es2KG8+KxbrRrbRNidHiFZh8EQ+2
         8eYQ==
X-Gm-Message-State: AAQBX9cx2Lrt4vj/VHo1WAOMT+zQvWVaTJX2OGycldrBNq9KNJ10VDC0
        slT973ys8KWqbvtskpOKDgYOINlK1MCp4mRMiNs=
X-Google-Smtp-Source: AKy350ZUCQcGPoD3vmEKw7XjEVwd7sHAL61lYSxdtfUslYZc/Zh4OKJOrwFzNfp7wzl7bCwTa4jDteRpjqv92X6h2VQ=
X-Received: by 2002:a17:902:b581:b0:19f:a694:6d3f with SMTP id
 a1-20020a170902b58100b0019fa6946d3fmr174659pls.6.1679610694112; Thu, 23 Mar
 2023 15:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230321023136.57986-1-aford173@gmail.com>
In-Reply-To: <20230321023136.57986-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 23 Mar 2023 19:31:22 -0300
Message-ID: <CAOMZO5B9odY1-EnKcAi=TQgzb5mwnPRXDtCdGNj+t=3wOyeAjw@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] clk: imx: Improve imx8mm/imx8mn LCDIF clocks
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk@vger.kernel.org, aford@beaconembedded.com,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:31=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
>
> Both the i.MX8M Mini and Nano have a video_pll which can be used
> to source a clock which feeds the lcdif interface.  This interface
> currently fixes video_pll and divides down the clock feeding LCDIF.
> However, when connected to an HDMI bridge chip that supports a
> variety of video resolutions and refresh rates, the only settings
> that properly sync are ones that evenly divide from the video_pll_out
> clock.
>
> This series adds the ability for the clk-compolsite-8m to
> request a better parent clock rate if the proper clock flag is
> enable and sets that flag in the corresponding imx8mm and
> imx8mn video_pll clocks to increase the number of resolutions
> and refresh rates timings that the LCDIF can produce.
>
> This also has a side benefit of allowing the video-pll to run
> at a lower clock speed which can potentially save some power
> depending on the requested resolution and refresh rate.
>
> V2:  Split off the new imx8m_clk_hw_composite_flags definition
>      into its own patch and re-order to fix build error.
>
> Adam Ford (3):
>   clk: imx: composite-8m: Add support to determine_rate
>   clk: imx8mm: Let IMX8MM_CLK_LCDIF_PIXEL set parent rate
>   clk: imx: Let IMX8MN_CLK_DISP_PIXEL set parent rate

For the series:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Should drivers/clk/imx/clk-imx8mp.c also be adjusted in the same way?
