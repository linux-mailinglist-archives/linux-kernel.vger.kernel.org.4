Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE9660217C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiJRCyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiJRCx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:53:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7BC95E71
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:53:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so16057336pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQY3W7hRKh2A3mmRwaSR5zMANSUXerkDNjuNxhhUVMQ=;
        b=T4EstTAc8ZqL0hkcgqQE1JkVr/qcAw+Ir6jEvpi4OV2kvFODb5E7k4DmdGHwn/Fp1s
         azy0qiMEBS+g/92IdHzbDBBLUhPA6mrjfJtSaKq5JwE4igc6yOsJN3cpLxKmu4r5d36/
         0KlP4W6yEo1uhW846C/VuwvP62WJfHaq4Ojqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQY3W7hRKh2A3mmRwaSR5zMANSUXerkDNjuNxhhUVMQ=;
        b=LZMglYAD+/Yu/j4Vm0k4+INV8NCpgzRvjhldvuU7DUDgqgmo3+Zkz0NoyZ5+3tGkwU
         8j7cssPJkUCN3pVE9vcWmCntS+XeWE8rKvxXbpSFo97uzaGnibtqnFhsOgIwGFVyoQTx
         s8MnAwUea135F4iTQdsLF/a8o9bc+6n6vHa7LOa+D5TuFVVZSbQR9gIKGuA1Tso3hIKC
         sMw2jyv86goQxtQye8tDI1kMzWAeWpw9j3nF3GmjrfPlCP5plOdWuqIN7qUuiw0jXsA+
         L7HpIhSO70+26coigAzWfgUjOA/lYl0ZYsx3HdQAWmy2DwprHeBgnufQPqko9lrh0hr2
         98HQ==
X-Gm-Message-State: ACrzQf1h4c9osC8jtBUw5aQI6F/idT9uDlELcTaKB0yW3UV5mRHVx4GN
        CzUNsMW4PD7nCGgXizLHpv6nkA==
X-Google-Smtp-Source: AMsMyM4VySz82tfsQkg7rqBGDxZ2dolN0viseOzqMsyFFd9ok/rnzj8rF4XLPfUEnvJ8tOkZCB4PuA==
X-Received: by 2002:a17:90b:1644:b0:20b:1cb4:2c9a with SMTP id il4-20020a17090b164400b0020b1cb42c9amr38015024pjb.193.1666061635017;
        Mon, 17 Oct 2022 19:53:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l3-20020a654c43000000b0046ae818b626sm7034638pgr.30.2022.10.17.19.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:53:54 -0700 (PDT)
Date:   Mon, 17 Oct 2022 19:53:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 6/6][next] airo: Avoid clashing function prototypes
Message-ID: <202210171950.B5F2676D7F@keescook>
References: <cover.1666038048.git.gustavoars@kernel.org>
 <ab0047382e6fd20c694e4ca14de8ca2c2a0e19d0.1666038048.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0047382e6fd20c694e4ca14de8ca2c2a0e19d0.1666038048.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 03:36:20PM -0500, Gustavo A. R. Silva wrote:
> [...]
> @@ -6312,16 +6326,16 @@ static int airo_get_mode(struct net_device *dev,
>  	/* If not managed, assume it's ad-hoc */
>  	switch (local->config.opmode & MODE_CFG_MASK) {
>  		case MODE_STA_ESS:
> -			*uwrq = IW_MODE_INFRA;
> +			uwrq->mode = IW_MODE_INFRA;
>  			break;
>  		case MODE_AP:
> -			*uwrq = IW_MODE_MASTER;
> +			uwrq->mode = IW_MODE_MASTER;
>  			break;
>  		case MODE_AP_RPTR:
> -			*uwrq = IW_MODE_REPEAT;
> +			uwrq->mode = IW_MODE_REPEAT;
>  			break;
>  		default:
> -			*uwrq = IW_MODE_ADHOC;
> +			uwrq->mode = IW_MODE_ADHOC;
>  	}
>  
>  	return 0;

Sometimes you use the union directly, sometimes not. What was your
heuristic for that?

Regardless, looks good!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
