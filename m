Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E161F6C0F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjCTKsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjCTKsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:48:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C632D26CE3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:45:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l12so9840210wrm.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679309057;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MGEZCQ150WLMwboCRH3jhHI9TWpdx3QCBwHBAGlQva8=;
        b=n2/0i2L0Dz4SRvTTNgGnznlHXJo0b4MZGU5NGLIgSNHRwOAHRjImLnm+6DrTRGFq93
         gokQPiOIeusC9nZf4aiHUwrXexNyFRkSTDZVoHVdeMstDOfau8kJEBQ/5tA99KbYedgD
         Y5sRh8B/PNF8Mr3SS/w2o4bD8Ld5lVNwYhEKo1QeZSaRNhzy6AsPUMWjXrFUOVRjX2bt
         KODRrfw7su6HFPR7Lei+5Td41sl6u+tI3T5Q403vrfkLlg/G0mb9IMVv/n5SFu6BllQi
         qWsRe506okSNSdx8NWAqW2u6dRNAMOUSDf89e1gn1dhoVa9OlQX8fWsheVGdFTEtv1Jo
         zZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679309057;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGEZCQ150WLMwboCRH3jhHI9TWpdx3QCBwHBAGlQva8=;
        b=U3+yXdAEQelJCCVVMSBzvv47LUaW69bTqrCHUFCqxA+yLQof3d2AYn/+yX9IywvQEq
         ljjAfsJhDxq2L2Ki0Aw7RnZSNMAFV746/N303EaOtR3hpQX7kXLWfi9a8cS+8MX6Kzhk
         AqHDN2lnWfdFtAyKENf1cI5QBa1RAxGNyU8co4PthrdIRMlvlwTzBwfb5x5H0PxnjyLJ
         xyeGTBvODY/mi1Hf1DU4XkSOwgwoN7tlQHnA4ltSi2RSsfzWpb45XeYn6mLOmyW5HkJJ
         ji2MuiznAHmOJmpg3ICkxy7hQtTLquuTRilji9t8KB80PJsoXW/E8QTszNssnJuQXjpW
         mkXA==
X-Gm-Message-State: AO0yUKXnvTSaCJP3vNN3kTOhTwaH6H4WtB1hOL4dw7kQr1s5v0l5EVcr
        lD1YA3q5zqldbJLgtjxjJDN3HA==
X-Google-Smtp-Source: AK7set8ws1fvI/lQ/aLItuJCYxfZJ340DRxEnPFrM8z3p+AXst2wtKtiztvyfSGEkh6pYlpHvg2pgQ==
X-Received: by 2002:a05:6000:1144:b0:2c7:a3c:5bd6 with SMTP id d4-20020a056000114400b002c70a3c5bd6mr13422741wrx.52.1679309056890;
        Mon, 20 Mar 2023 03:44:16 -0700 (PDT)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id c15-20020adffb0f000000b002c6e8cb612fsm8537741wrr.92.2023.03.20.03.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:44:16 -0700 (PDT)
Message-ID: <afc44c13-0863-d1de-df03-30b83f5a015a@linaro.org>
Date:   Mon, 20 Mar 2023 11:44:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: nwl-dsi: fix packet read ISR handling
Content-Language: en-US
To:     Kevin Groeneveld <kgroeneveld@lenbrook.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230318223621.4239-1-kgroeneveld@lenbrook.com>
Organization: Linaro Developer Services
In-Reply-To: <20230318223621.4239-1-kgroeneveld@lenbrook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/03/2023 23:36, Kevin Groeneveld wrote:
> In some cases the NWL_DSI_RX_PKT_PAYLOAD_DATA_RCVD interrupt flag is not
> set along with NWL_DSI_RX_PKT_HDR_RCVD when the initial interrupt fires.
> Since the NWL_DSI_RX_PKT_PAYLOAD_DATA_RCVD_MASK was not set then the ISR
> does not fire again when NWL_DSI_RX_PKT_PAYLOAD_DATA_RCVD is finally set
> and the read times out.
> 
> Also the read packet handling checks for NWL_DSI_DPHY_DIRECTION which is
> not always set when the ISR for reading the payload runs. Instead it seems
> better to check xfer->direction is DSI_PACKET_RECEIVE (more similar to the
> send packet case).
> 
> The above two changes were required to perform a successful DCS read from
> a display with a Chipone ICNL9707 driver IC.
> 
> Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>


Thanks for the patch, can you provide a Fixes tag ?

Neil

> ---
>   drivers/gpu/drm/bridge/nwl-dsi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index 6dc2a4e191d7..241568a17f60 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -334,6 +334,7 @@ static int nwl_dsi_init_interrupts(struct nwl_dsi *dsi)
>   {
>   	u32 irq_enable = ~(u32)(NWL_DSI_TX_PKT_DONE_MASK |
>   				NWL_DSI_RX_PKT_HDR_RCVD_MASK |
> +				NWL_DSI_RX_PKT_PAYLOAD_DATA_RCVD_MASK |
>   				NWL_DSI_TX_FIFO_OVFLW_MASK |
>   				NWL_DSI_HS_TX_TIMEOUT_MASK);
>   
> @@ -489,7 +490,7 @@ static void nwl_dsi_finish_transmission(struct nwl_dsi *dsi, u32 status)
>   	    status & NWL_DSI_TX_PKT_DONE) {
>   		xfer->status = xfer->tx_len;
>   		end_packet = true;
> -	} else if (status & NWL_DSI_DPHY_DIRECTION &&
> +	} else if (xfer->direction == DSI_PACKET_RECEIVE &&
>   		   ((status & (NWL_DSI_RX_PKT_HDR_RCVD |
>   			       NWL_DSI_RX_PKT_PAYLOAD_DATA_RCVD)))) {
>   		end_packet = nwl_dsi_read_packet(dsi, status);

