Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2AE5FCC48
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiJLUoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiJLUnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:43:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF366BBF34
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:43:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id pq16so97540pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/XV5pr8QqFGjPs8+6LG6NFfr+//dPbYGj0pCHlYmCJo=;
        b=O3BbsgmKcyrP8JEZyCXj8RAZ2efDkDTDsgnsREnCkCP1sXwl0wl4OXjVLPkwgocarI
         Eh6eeUvtYyniV3TaJaml6MFIpbXpJUN8gPtZa8iJCHm/NfijSkyViAb/LQNR4N7SzCR7
         Qk5eBDdK86ktcQzBhwiC0Wk/sF1B6d5H0y4JAcTWOir5CtQACV8ajvzApP9Py+HuQ8TC
         D8r/e6GKsJaa54aKLq7l/cIOB+ammSdhY6RCGanZqpHED9m/+wsFboJRj/XVYJCpbsaS
         GMDPv/h7KMlE5vZCQ45ySUITpN3V1y21y3mPz5QXL9BBC3C8PuvCN8/I6BCLt/Wmr6Hq
         7agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XV5pr8QqFGjPs8+6LG6NFfr+//dPbYGj0pCHlYmCJo=;
        b=zroyzZUciNZh+27H4Q6fW2yWHiAikTnWSt8IdpHOluadbTaJaXJVt/OLqjb0mn1+9H
         OVkUQTkw6K4dX0XSHrAFgUjQAfnmsH1a3UqZ8mkQbLy5yTO3DLEhGw/KwD8akv7y+lXx
         UYXW+mf8F4eGjAPeIQXf0Bd7db0H20G3otE0CEK8tqwRPmRKe2u8BeOeIpDztjdllBJ4
         lCuIqmm4ITzbn4sWi7+9SHS+5+5iCENhLuPIKtJONgj3JQfgH1I86hgC0GjEBBsvUYlT
         3AXb2WolGzzQH7Rli8E8n8CdX4nmeyBd1Mctp/LxUic+wvrxpJ0c2yY59qUBk9wNsn6Y
         V0Ng==
X-Gm-Message-State: ACrzQf1gYVWQm1wppISOsas2IAxtzscldI0Udp9d0+CiZSRIdxMzbrbD
        2Q+ApVY/SHEHPttfVoLxjaEFv+ZtN5gzAA==
X-Google-Smtp-Source: AMsMyM7LKuK725wPc8GpTSojQ0O9922L8xMD/vZb34gAp6nqMYstaPxFfsYeAgOfShV9qxydWjJbGA==
X-Received: by 2002:a17:902:e1cd:b0:184:aa71:217d with SMTP id t13-20020a170902e1cd00b00184aa71217dmr3824714pla.77.1665607427224;
        Wed, 12 Oct 2022 13:43:47 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c18-20020a624e12000000b005626c3e5fdbsm288176pfb.143.2022.10.12.13.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 13:43:46 -0700 (PDT)
Date:   Wed, 12 Oct 2022 14:43:44 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Maria Yu <quic_aiquny@quicinc.com>
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_clew@quicinc.com
Subject: Re: [PATCH v4] remoteproc: core: do pm relax when in RPROC_OFFLINE
Message-ID: <20221012204344.GA1178915@p14s>
References: <128dc161-8949-1146-bf8b-310aa33c06a8@quicinc.com>
 <1663312351-28476-1-git-send-email-quic_aiquny@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663312351-28476-1-git-send-email-quic_aiquny@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please add what has changed from one version to another, either in a cover
letter or after the "Signed-off-by".  There are many examples on how to do that
on the mailing list.

On Fri, Sep 16, 2022 at 03:12:31PM +0800, Maria Yu wrote:
> RPROC_OFFLINE state indicate there is no recovery process
> is in progress and no chance to do the pm_relax.
> Because when recovering from crash, rproc->lock is held and
> state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
> and then unlock rproc->lock.

You are correct - because the lock is held rproc->state should be set to RPROC_RUNNING
when rproc_trigger_recovery() returns.  If that is not the case then something
went wrong.

Function rproc_stop() sets rproc->state to RPROC_OFFLINE just before returning,
so we know the remote processor was stopped.  Therefore if rproc->state is set
to RPROC_OFFLINE something went wrong in either request_firmware() or
rproc_start().  Either way the remote processor is offline and the system probably
in an unknown/unstable.  As such I don't see how calling pm_relax() can help
things along.  

I suggest spending time understanding what leads to the failure when recovering
from a crash and address that problem(s).

Thanks,
Mathieu


> When the state is in RPROC_OFFLINE it means separate request
> of rproc_stop was done and no need to hold the wakeup source
> in crash handler to recover any more.
> 
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index e5279ed9a8d7..6bc7b8b7d01e 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1956,6 +1956,17 @@ static void rproc_crash_handler_work(struct work_struct *work)
>  	if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
>  		/* handle only the first crash detected */
>  		mutex_unlock(&rproc->lock);
> +		/*
> +		 * RPROC_OFFLINE state indicate there is no recovery process
> +		 * is in progress and no chance to have pm_relax in place.
> +		 * Because when recovering from crash, rproc->lock is held and
> +		 * state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
> +		 * and then unlock rproc->lock.
> +		 * RPROC_OFFLINE is only an intermediate state in recovery
> +		 * process.
> +		 */
> +		if (rproc->state == RPROC_OFFLINE)
> +			pm_relax(rproc->dev.parent);
>  		return;
>  	}
>  
> -- 
> 2.7.4
> 
