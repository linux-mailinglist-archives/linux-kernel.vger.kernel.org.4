Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ADE65287F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 22:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiLTVkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 16:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLTVkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 16:40:32 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0153113CEF;
        Tue, 20 Dec 2022 13:40:31 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j4so20691558lfk.0;
        Tue, 20 Dec 2022 13:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i0QJJAJHs8AlHPv1GFzIrByGID5+G91GQ7RiYN+XzJE=;
        b=AGyI0rZkXfrzcC3mDk9Ocmgo5FfL5qYohqfDty0IGt1mIpDzR+ADBd/5jdkkEIYucf
         fdivCrsy66dXu745ocmIYzzv726M4VbxrH+iIX98exDpvwE0xg0fP4LZOwEN0HUN1RQB
         P1pknZ7u3+ZZ47CmR+Fbci/fvn882uWfnawSIfdeRnSUef2f1hCQ0NToip4Q74f6wx1G
         Aqq+XY15pMIbZZjJhBKOtQ+ZQSKrEhTvriuEkJTg+IeY6KQgvKgW/Pqfm/+SoxkLNBaw
         KuwrecRR7kMH8ZwKcLOUWdX+L+1jY78K9zgg50J94by/ZZt0CXnKc12dTO49GFIgErx0
         h34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0QJJAJHs8AlHPv1GFzIrByGID5+G91GQ7RiYN+XzJE=;
        b=ZKNtiRg1Wkj7gRkP17+AIzhebiQfIgVuViR1nVIMM0r1BKd50oKutbO7A6lBWtb8Uv
         klDrxRYWfuoWHfw8PoaWQ1h+LzI6rFc8qo+2jpfRcHF1xdKVn0i7nrW7m6gIRJuJ1zp/
         0Din3UGuo90iSXr3lksEN/c+ePQpzWssQdNTh+9x+7jXvkQ0ROSHkTae+qjzI4kDj4KS
         crJEyQQOWD4Nu0Of5ShX18HUzrn8rH8D6XCLRZzM8/OnZZrrbtUcRx+a067APJhXamCU
         xJc+gbpk6MVxEQz6KX+HupKbXy3eCJ9opop2OU5agUj4Wwty5GTzrN5/lV/o+LppmpFQ
         wxyw==
X-Gm-Message-State: ANoB5pmWemCm5X2v20hJzrmNzjebZCYZY8MPUuy3xvacYiHTMgzkRBBD
        tR3KnWgi5kATFiQZadu5M4c=
X-Google-Smtp-Source: AA0mqf7UCX9LfU9mAdsWfz+Q/qhvUuQxl0BkWSutbWvnPYHqlJ49tXMn0MPeBrgSGHjYxfib5jXyig==
X-Received: by 2002:a05:6512:682:b0:4a4:68b8:f4db with SMTP id t2-20020a056512068200b004a468b8f4dbmr19035562lfe.33.1671572429262;
        Tue, 20 Dec 2022 13:40:29 -0800 (PST)
Received: from [192.168.2.145] (109-252-113-89.nat.spd-mgts.ru. [109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id v24-20020ac25618000000b004b549ad99adsm1598785lfd.304.2022.12.20.13.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 13:40:28 -0800 (PST)
Message-ID: <30e6b040-aa82-f6a3-1ff6-baa2c0dcb0e2@gmail.com>
Date:   Wed, 21 Dec 2022 00:40:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 21/21] staging: media: tegra-video: add tegra20 variant
Content-Language: en-US
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
References: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
 <20221128152336.133953-22-luca.ceresoli@bootlin.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20221128152336.133953-22-luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.11.2022 18:23, Luca Ceresoli пишет:
> +static int tegra20_channel_capture_frame(struct tegra_vi_channel *chan,
> +					 struct tegra_channel_buffer *buf)
> +{
> +	u32 value;
> +	int err;
> +
> +	chan->next_out_sp_idx++;
> +
> +	tegra20_channel_vi_buffer_setup(chan, buf);
> +
> +	tegra20_vi_write(chan, TEGRA_VI_CAMERA_CONTROL, VI_CAMERA_CONTROL_VIP_ENABLE);
> +
> +	/* Wait for syncpt counter to reach frame start event threshold */
> +	err = host1x_syncpt_wait(chan->out_sp, chan->next_out_sp_idx,
> +				 TEGRA_VI_SYNCPT_WAIT_TIMEOUT, &value);

You're not using the "value" variable, it should be NULL.

The "chan->out_sp" looks redundant, it duplicates the chan->mw_ack_sp.
AFAICS from the doc, T20 has two VI channels, and thus, two mw_ack_sp,
like T210.

