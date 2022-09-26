Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4DA5EB425
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiIZWGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIZWGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:06:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3044B499
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:06:14 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id b5so7757978pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UnO/3kkOs/CP235a1zfbUEKXqigkt8Jk8YNYN8ReTZk=;
        b=siW2fwC43Rm6oxJEyctzqHPIDMg5ocZe6Y0wrNYY98T9RM0bfKXv9vzcTLfDPUypwR
         +bjk6hZjC5sT3KENuiSJb70rjaKuYU1lzRI+bOYFAafyzE3HFrjwJv9hZMvG6AYfXIiP
         7BdbqXywpjJ4q/XZzB4fd9yJw9I41GwoGv7/Pk5Xstz4WK7qbX63BX7vgOs/srieo0u8
         SgFVWmYoAlfz/mOkYV79fuuXILSLJqSkwaLNAxnvkO0Hs+Hj8nYB+OkbbT8u3hmkrx55
         dtZqMw4MD7w2z6AxzcuMp1LShlCVareVm5ZViyE+WtLW5Rga897qYAI5jFlzfaKa08iL
         0jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UnO/3kkOs/CP235a1zfbUEKXqigkt8Jk8YNYN8ReTZk=;
        b=B5/U2pzElzWtthencQVMU03fHIokIGGuKunrGQXU/t2Hh9fjFlPIJifcNt4HcSKgEp
         sCluPZ/f8T1DtR0Tpo6zN/ZeQNbSzK7y5kg67I4r4pOLvlnKSX+0lCoYGSSMcCtT+YTa
         OP804MomrmFOs90Q0Ezbj/z2/08xTFMWHCJY+goa/6Gv0cTXmmW6v8RDVs6KgFiJYM0A
         r9nniA5L9nfqxbbp219m0ZGmfBKVQUTSjQzeIHk/w0QRvR6B71aM1F7krF1/q2wF1yvs
         YRhPLKVBXcCCbgz4cSJi7hLPxoA4OYqt3KsUJXSKS7+tLikvb4aHBnbU+ESrYNLnOlhv
         GaMw==
X-Gm-Message-State: ACrzQf2sdZw99/utdIUBwGX9GjS2cO6L+Cf5kXosxU8Ut9PJenAkuQin
        yWff4Xhl8D9hUoHKVAUWwHPdag==
X-Google-Smtp-Source: AMsMyM6Xzq30A4G87lqLkN+47hlMNOd5+rIsxCu3a/5o2rLuje1HrRWwjgby8ApwIP5LP/2ImHtlVA==
X-Received: by 2002:a63:5511:0:b0:439:12f6:fb9a with SMTP id j17-20020a635511000000b0043912f6fb9amr22589394pgb.197.1664229973834;
        Mon, 26 Sep 2022 15:06:13 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id o196-20020a62cdcd000000b0054ad9c6b70fsm12246pfg.8.2022.09.26.15.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:06:12 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:06:10 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, arnaud.pouliquen@foss.st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V7 2/2] remoteproc: support attach recovery after rproc
 crash
Message-ID: <20220926220610.GA2817947@p14s>
References: <20220705011527.2849057-1-peng.fan@oss.nxp.com>
 <20220705011527.2849057-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705011527.2849057-3-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 09:15:27AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Current logic only support main processor to stop/start the remote
> processor after crash. However to SoC, such as i.MX8QM/QXP, the
> remote processor could do attach recovery after crash and trigger watchdog
> to reboot itself. It does not need main processor to load image, or
> stop/start remote processor.
> 
> Introduce two functions: rproc_attach_recovery, rproc_boot_recovery
> for the two cases. Boot recovery is as before, let main processor to
> help recovery, while attach recovery is to recover itself without help.
> To attach recovery, we only do detach and attach.
> 
> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 62 +++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index ed374c8bf14a..ef5b9310bc83 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1884,6 +1884,45 @@ static int __rproc_detach(struct rproc *rproc)
>  	return 0;
>  }
>  
> +static int rproc_attach_recovery(struct rproc *rproc)
> +{
> +	int ret;
> +
> +	ret = __rproc_detach(rproc);
> +	if (ret)
> +		return ret;

I thought there was a specific reason to _not_ call rproc->ops->coredump() for
processors that have been attached to but looking at the STM32 and IMX_DSP now, it
would seem logical to do so.  Am I missing something?

And this set will need a rebase.

Thanks,
Mathieu

> +
> +	return __rproc_attach(rproc);
> +}
> +
> +static int rproc_boot_recovery(struct rproc *rproc)
> +{
> +	const struct firmware *firmware_p;
> +	struct device *dev = &rproc->dev;
> +	int ret;
> +
> +	ret = rproc_stop(rproc, true);
> +	if (ret)
> +		return ret;
> +
> +	/* generate coredump */
> +	rproc->ops->coredump(rproc);
> +
> +	/* load firmware */
> +	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> +	if (ret < 0) {
> +		dev_err(dev, "request_firmware failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* boot the remote processor up again */
> +	ret = rproc_start(rproc, firmware_p);
> +
> +	release_firmware(firmware_p);
> +
> +	return ret;
> +}
> +
>  /**
>   * rproc_trigger_recovery() - recover a remoteproc
>   * @rproc: the remote processor
> @@ -1898,7 +1937,6 @@ static int __rproc_detach(struct rproc *rproc)
>   */
>  int rproc_trigger_recovery(struct rproc *rproc)
>  {
> -	const struct firmware *firmware_p;
>  	struct device *dev = &rproc->dev;
>  	int ret;
>  
> @@ -1912,24 +1950,10 @@ int rproc_trigger_recovery(struct rproc *rproc)
>  
>  	dev_err(dev, "recovering %s\n", rproc->name);
>  
> -	ret = rproc_stop(rproc, true);
> -	if (ret)
> -		goto unlock_mutex;
> -
> -	/* generate coredump */
> -	rproc->ops->coredump(rproc);
> -
> -	/* load firmware */
> -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> -	if (ret < 0) {
> -		dev_err(dev, "request_firmware failed: %d\n", ret);
> -		goto unlock_mutex;
> -	}
> -
> -	/* boot the remote processor up again */
> -	ret = rproc_start(rproc, firmware_p);
> -
> -	release_firmware(firmware_p);
> +	if (rproc_has_feature(rproc, RPROC_FEAT_ATTACH_ON_RECOVERY))
> +		ret = rproc_attach_recovery(rproc);
> +	else
> +		ret = rproc_boot_recovery(rproc);
>  
>  unlock_mutex:
>  	mutex_unlock(&rproc->lock);
> -- 
> 2.25.1
> 
