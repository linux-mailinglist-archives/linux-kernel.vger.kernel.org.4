Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF216D33E8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 22:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDAUuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 16:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDAUuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 16:50:17 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A096727020;
        Sat,  1 Apr 2023 13:50:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x3so102885162edb.10;
        Sat, 01 Apr 2023 13:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680382213;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgOZGBjMrNfEYOFT5qZhKEYrnCSxGGA+y6RDWbFUmcQ=;
        b=IAFFAmjeXyQmEa5Ly4hXquwBrGPwcV7jislsH8OSykhx2EAuqvqyTJecBGzIqy91Zl
         WRiG1N8jHGzAKrP/M2duHDGYtc/AY13kLwn/cFr4RV7lzKoHP0RtlpOaXSKxUwVwaTjN
         FKtkUZgtNl//UhS6om5Xch/dnV9BsNS+c2/8pP+WIdEi+/Kr1hLMDfkaM+aPNHTJ4T9h
         vBMtguWONPiH+/ON4HkV0IfLpdDkXNf+Y4AM2WUI2X0PQg0Z3yV3IsbDwZ0kvjt9Smy4
         vjs85DSLXyYqdnAnAxX918Sfah/Q3TedlSayum2eXLZkshUDa5WedlB9UIU70HqkVh3v
         NkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680382213;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgOZGBjMrNfEYOFT5qZhKEYrnCSxGGA+y6RDWbFUmcQ=;
        b=zMnNYVDTXo/S5WboGl7yUTiKCCoNgH07P/pNv7gQFraEwdQBLjaxTVcCiSIzcXJDIh
         O7LAufWAM6e/dgL6P+y97OlXTK+bgloFfaIsisAW2tmlUjARGMyUMWYkg7lR6CFsRVCP
         bI0nOr+hHjU5/sl7P209CtVOIRDNAbuB4s9X74Jps9c66cjuJcRg0y4sivMQvMu+epJq
         ofctX68vTZOaDpNv9f0skRBYRDm8jxAckTvIxApeb8cEHf8uKcE1VowqE4vohmqkFvkP
         QNF97No6+RDZPY/BgJIOJ/CGn41VgPBhwisgH2MqkJZ4gT1RTmSEca6lXK4gf4AKk267
         St2g==
X-Gm-Message-State: AAQBX9cosR8eHAEM7rOJi/5w7o2mgFaxrKAmDug65+wsXGk/0XTemfPj
        C0HJeQ5Z6yUUpza1gCCTkyo=
X-Google-Smtp-Source: AKy350a6XGOCGMuiiPDn0shWd3zKUNOozT4lgr0FASh6XfKT3uXOIVvH/st/0W2pnqXiMRQKKZ96sw==
X-Received: by 2002:a17:907:6da1:b0:947:ad38:6184 with SMTP id sb33-20020a1709076da100b00947ad386184mr6649516ejc.31.1680382213096;
        Sat, 01 Apr 2023 13:50:13 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bda6:2000:35bd:7a7:441f:cb1? (dynamic-2a01-0c23-bda6-2000-35bd-07a7-441f-0cb1.c23.pool.telefonica.de. [2a01:c23:bda6:2000:35bd:7a7:441f:cb1])
        by smtp.googlemail.com with ESMTPSA id w19-20020a170906d21300b00930894eb708sm2462440ejz.223.2023.04.01.13.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 13:50:12 -0700 (PDT)
Message-ID: <a49619b7-2340-2726-8c7e-df6ff0c1793a@gmail.com>
Date:   Sat, 1 Apr 2023 22:50:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Sarthak Garg <quic_sartgarg@quicinc.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_sachgupt@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Yann Gautier <yann.gautier@foss.st.com>,
        ChanWoo Lee <cw9316.lee@samsung.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Ye Bin <yebin10@huawei.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Yu Zhe <yuzhe@nfschina.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Brian Norris <briannorris@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        David Sterba <dsterba@suse.com>,
        John Garry <john.garry@huawei.com>
References: <20230401165723.19762-1-quic_sartgarg@quicinc.com>
 <20230401165723.19762-3-quic_sartgarg@quicinc.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH V1 2/2] mmc: core: Export core functions to let vendors
 use for their features
In-Reply-To: <20230401165723.19762-3-quic_sartgarg@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.2023 18:57, Sarthak Garg wrote:
> Export core functions to let vendors use for their internal features.
> 
Typically extensions to the core require at least one user. So you should
add your driver, that makes use of the changes, to the series.
And best explain what's special with your hardware so that it needs a core
extension whilst drivers for other hardware are fine with the core as-is.

> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> ---
>  drivers/mmc/core/core.c    |  6 ++++++
>  drivers/mmc/core/host.c    |  1 +
>  drivers/mmc/core/mmc.c     | 18 ++++++++++++------
>  drivers/mmc/core/mmc_ops.c |  1 +
>  drivers/mmc/core/queue.c   |  1 +
>  5 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 3d3e0ca52614..ed44b65f19e0 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -916,6 +916,7 @@ void mmc_set_clock(struct mmc_host *host, unsigned int hz)
>  	host->ios.clock = hz;
>  	mmc_set_ios(host);
>  }
> +EXPORT_SYMBOL_GPL(mmc_set_clock);
>  
>  int mmc_execute_tuning(struct mmc_card *card)
>  {
> @@ -950,6 +951,7 @@ int mmc_execute_tuning(struct mmc_card *card)
>  
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(mmc_execute_tuning);
>  
>  /*
>   * Change the bus mode (open drain/push-pull) of a host.
> @@ -959,6 +961,7 @@ void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode)
>  	host->ios.bus_mode = mode;
>  	mmc_set_ios(host);
>  }
> +EXPORT_SYMBOL_GPL(mmc_set_bus_mode);
>  
>  /*
>   * Change data bus width of a host.
> @@ -968,6 +971,7 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
>  	host->ios.bus_width = width;
>  	mmc_set_ios(host);
>  }
> +EXPORT_SYMBOL_GPL(mmc_set_bus_width);
>  
>  /*
>   * Set initial state after a power cycle or a hw_reset.
> @@ -1001,6 +1005,7 @@ void mmc_set_initial_state(struct mmc_host *host)
>  
>  	mmc_crypto_set_initial_state(host);
>  }
> +EXPORT_SYMBOL_GPL(mmc_set_initial_state);
>  
>  /**
>   * mmc_vdd_to_ocrbitnum - Convert a voltage to the OCR bit number
> @@ -1270,6 +1275,7 @@ void mmc_set_timing(struct mmc_host *host, unsigned int timing)
>  	host->ios.timing = timing;
>  	mmc_set_ios(host);
>  }
> +EXPORT_SYMBOL_GPL(mmc_set_timing);
>  
>  /*
>   * Select appropriate driver type for host.
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 76900f67c782..1c5eb1d9d585 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -166,6 +166,7 @@ void mmc_retune_hold(struct mmc_host *host)
>  		host->retune_now = 1;
>  	host->hold_retune += 1;
>  }
> +EXPORT_SYMBOL(mmc_retune_hold);
>  
>  void mmc_retune_release(struct mmc_host *host)
>  {
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 32386e4644df..b984a4f90535 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1002,7 +1002,7 @@ static void mmc_set_bus_speed(struct mmc_card *card)
>   * If the bus width is changed successfully, return the selected width value.
>   * Zero is returned instead of error value if the wide width is not supported.
>   */
> -static int mmc_select_bus_width(struct mmc_card *card)
> +int mmc_select_bus_width(struct mmc_card *card)
>  {
>  	static unsigned ext_csd_bits[] = {
>  		EXT_CSD_BUS_WIDTH_8,
> @@ -1067,11 +1067,12 @@ static int mmc_select_bus_width(struct mmc_card *card)
>  
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(mmc_select_bus_width);
>  
>  /*
>   * Switch to the high-speed mode
>   */
> -static int mmc_select_hs(struct mmc_card *card)
> +int mmc_select_hs(struct mmc_card *card)
>  {
>  	int err;
>  
> @@ -1085,11 +1086,12 @@ static int mmc_select_hs(struct mmc_card *card)
>  
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(mmc_select_hs);
>  
>  /*
>   * Activate wide bus and DDR if supported.
>   */
> -static int mmc_select_hs_ddr(struct mmc_card *card)
> +int mmc_select_hs_ddr(struct mmc_card *card)
>  {
>  	struct mmc_host *host = card->host;
>  	u32 bus_width, ext_csd_bits;
> @@ -1158,8 +1160,9 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>  
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(mmc_select_hs_ddr);
>  
> -static int mmc_select_hs400(struct mmc_card *card)
> +int mmc_select_hs400(struct mmc_card *card)
>  {
>  	struct mmc_host *host = card->host;
>  	unsigned int max_dtr;
> @@ -1253,6 +1256,7 @@ static int mmc_select_hs400(struct mmc_card *card)
>  	       __func__, err);
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(mmc_select_hs400);
>  
>  int mmc_hs200_to_hs400(struct mmc_card *card)
>  {
> @@ -1533,7 +1537,7 @@ static int mmc_select_hs200(struct mmc_card *card)
>  /*
>   * Activate High Speed, HS200 or HS400ES mode if supported.
>   */
> -static int mmc_select_timing(struct mmc_card *card)
> +int mmc_select_timing(struct mmc_card *card)
>  {
>  	int err = 0;
>  
> @@ -1568,12 +1572,13 @@ static int mmc_select_timing(struct mmc_card *card)
>  	mmc_set_bus_speed(card);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(mmc_select_timing);
>  
>  /*
>   * Execute tuning sequence to seek the proper bus operating
>   * conditions for HS200 and HS400, which sends CMD21 to the device.
>   */
> -static int mmc_hs200_tuning(struct mmc_card *card)
> +int mmc_hs200_tuning(struct mmc_card *card)
>  {
>  	struct mmc_host *host = card->host;
>  
> @@ -1588,6 +1593,7 @@ static int mmc_hs200_tuning(struct mmc_card *card)
>  
>  	return mmc_execute_tuning(card);
>  }
> +EXPORT_SYMBOL_GPL(mmc_hs200_tuning);
>  
>  /*
>   * Handle the detection and initialisation of a card.
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 3b3adbddf664..62c16dac9d62 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -118,6 +118,7 @@ int mmc_select_card(struct mmc_card *card)
>  
>  	return _mmc_select_card(card->host, card);
>  }
> +EXPORT_SYMBOL_GPL(mmc_select_card);
>  
>  int mmc_deselect_cards(struct mmc_host *host)
>  {
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index b396e3900717..2c710d736032 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -69,6 +69,7 @@ enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req)
>  
>  	return MMC_ISSUE_SYNC;
>  }
> +EXPORT_SYMBOL_GPL(mmc_issue_type);
>  
>  static void __mmc_cqe_recovery_notifier(struct mmc_queue *mq)
>  {

