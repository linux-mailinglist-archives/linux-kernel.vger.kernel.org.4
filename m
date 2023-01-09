Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D14D66331F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbjAIVgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237998AbjAIVfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:35:33 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD57560E1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:34:35 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id n63so5212266iod.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OfVSdDVOS9780zsdf8R+dkGcr8yzVl06GcKWsbR1DEc=;
        b=OWuDkEsJUUEF/a3bF7v6PWjBf7SSomQjoG58ol67HZNKuAt+/FaCSt1B1qQZdRrSAe
         MJXDBJZlFUzauB6uJcl+YNQKT59Pqx7d2ZQ00ZT8dHwiA/0Jp/PDX4+ELqqyISJ1MBio
         59QrfGjNlZ59+0/m4jaSzs6W61qSA2uIh1IjOZtV0yTlW5YFbViBH3d79jwIGw0tCbTV
         CUMd19VvZIQVig4r0Hi/CiAUoCUFxMprNMOxr+5OFmJ9hiOHUAGreLJD5oeZ9Fft/P8t
         99nwEke0xWg6c2fOdeNmm/xLkNWBEjHgb76aH5JUblXw4bfDRnCsU/rph6gZmcdoZ0Pl
         zP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfVSdDVOS9780zsdf8R+dkGcr8yzVl06GcKWsbR1DEc=;
        b=Dd0pqEs+J0kT82GjXBt/55rxtK4whgmn2yQIAjSWty6xLB2GkuxHYfbACFo00Cve9k
         YYqO54PcsbLRjpBSdrkv2PG8bFhnmYp3pTcWV6zUdMweM+tRkKQOJblMOJ/2q2WOIEeA
         A5fZW93tXmTf10KopIOED8QB6gJUtOSNlL2hTfxsY+eE69UcJX5CxbB5ZFksah4fLpTn
         xhRgGyBIl9bO9AiuOv6vwM/p8L7iVWnaWiRzFmsTK+p4H0Yr52NbgB11usFuvGSBckvm
         rLUjUh2NSIG7mxmXaLZPHyg6JTw4Kb6+SdV9LufwsetFuiT6554mVLte4OXilD8eyWJJ
         skEg==
X-Gm-Message-State: AFqh2krNVhe0wuWX+LurubogWzqZ8DM4ECS+hacWgv9CkfSnHM0xhNHC
        pNcrmF834ZCNq7daQp2BMvZ51Q==
X-Google-Smtp-Source: AMrXdXs9Rro9BMGQQf3u+WoQxaXEuT6LwOhLg0LrwboxDwqJTLccq+3lMGeciJLN1+p0713P37aE2A==
X-Received: by 2002:a5e:970c:0:b0:6df:f777:ba81 with SMTP id w12-20020a5e970c000000b006dff777ba81mr44330363ioj.3.1673300075308;
        Mon, 09 Jan 2023 13:34:35 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id i19-20020a0566022c9300b006e2d21ab686sm3562792iow.38.2023.01.09.13.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 13:34:34 -0800 (PST)
Message-ID: <942f20cc-87d3-d014-1527-8d3d3e1ae44b@linaro.org>
Date:   Mon, 9 Jan 2023 15:34:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 07/28] mailbox: Allow direct registration to a channel
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-8-quic_eberman@quicinc.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20221219225850.2397345-8-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/22 4:58 PM, Elliot Berman wrote:
> Support virtual mailbox controllers and clients which are not platform
> devices or come from the devicetree by allowing them to match client to
> channel via some other mechanism.

The new function behaves very much like mbox_request_channel()
did before.

The new function differs from omap_mbox_request_channel() in that
it can change the if chan->txdone_method is TXDONE_BY_POLL, it
is changed to TXDONE_BY_ACK if the client's knows_txdone field is
set.  Is this OK?  Why?

It also assumes chan->mbox->ops->startup us non-null (though that
isn't really a problem).

> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   drivers/mailbox/mailbox.c      | 96 ++++++++++++++++++++++++----------
>   drivers/mailbox/omap-mailbox.c | 18 ++-----
>   drivers/mailbox/pcc.c          | 18 ++-----
>   include/linux/mailbox_client.h |  1 +
>   4 files changed, 76 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 4229b9b5da98..adf36c05fa43 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -317,6 +317,71 @@ int mbox_flush(struct mbox_chan *chan, unsigned long timeout)
>   }
>   EXPORT_SYMBOL_GPL(mbox_flush);
>   
> +static int __mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)

There should be an unbind_client() call.  At a minimum, you are
calling try_module_get(), and the matching module_put() call
would belong there.  And even though one might just call
module_put() elsewhere for this, it would be cleaner to have
a function that similarly encapsulates the shutdown call
as well.

					-Alex

> +{
> +	struct device *dev = cl->dev;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (chan->cl || !try_module_get(chan->mbox->dev->driver->owner)) {
> +		dev_dbg(dev, "%s: mailbox not free\n", __func__);
> +		return -EBUSY;
> +	}
> +
> +	spin_lock_irqsave(&chan->lock, flags);
> +	chan->msg_free = 0;
> +	chan->msg_count = 0;
> +	chan->active_req = NULL;
> +	chan->cl = cl;
> +	init_completion(&chan->tx_complete);
> +
> +	if (chan->txdone_method	== TXDONE_BY_POLL && cl->knows_txdone)
> +		chan->txdone_method = TXDONE_BY_ACK;
> +
> +	spin_unlock_irqrestore(&chan->lock, flags);
> +
> +	if (chan->mbox->ops->startup) {
> +		ret = chan->mbox->ops->startup(chan);
> +
> +		if (ret) {
> +			dev_err(dev, "Unable to startup the chan (%d)\n", ret);
> +			mbox_free_channel(chan);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * mbox_bind_client - Request a mailbox channel.
> + * @chan: The mailbox channel to bind the client to.
> + * @cl: Identity of the client requesting the channel.
> + *
> + * The Client specifies its requirements and capabilities while asking for
> + * a mailbox channel. It can't be called from atomic context.
> + * The channel is exclusively allocated and can't be used by another
> + * client before the owner calls mbox_free_channel.
> + * After assignment, any packet received on this channel will be
> + * handed over to the client via the 'rx_callback'.
> + * The framework holds reference to the client, so the mbox_client
> + * structure shouldn't be modified until the mbox_free_channel returns.
> + *
> + * Return: 0 if the channel was assigned to the client successfully.
> + *         <0 for request failure.
> + */
> +int mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
> +{
> +	int ret;
> +
> +	mutex_lock(&con_mutex);
> +	ret = __mbox_bind_client(chan, cl);
> +	mutex_unlock(&con_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(mbox_bind_client);
> +
>   /**
>    * mbox_request_channel - Request a mailbox channel.
>    * @cl: Identity of the client requesting the channel.
> @@ -340,7 +405,6 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
>   	struct mbox_controller *mbox;
>   	struct of_phandle_args spec;
>   	struct mbox_chan *chan;
> -	unsigned long flags;
>   	int ret;
>   
>   	if (!dev || !dev->of_node) {
> @@ -372,33 +436,9 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
>   		return chan;
>   	}
>   
> -	if (chan->cl || !try_module_get(mbox->dev->driver->owner)) {
> -		dev_dbg(dev, "%s: mailbox not free\n", __func__);
> -		mutex_unlock(&con_mutex);
> -		return ERR_PTR(-EBUSY);
> -	}
> -
> -	spin_lock_irqsave(&chan->lock, flags);
> -	chan->msg_free = 0;
> -	chan->msg_count = 0;
> -	chan->active_req = NULL;
> -	chan->cl = cl;
> -	init_completion(&chan->tx_complete);
> -
> -	if (chan->txdone_method	== TXDONE_BY_POLL && cl->knows_txdone)
> -		chan->txdone_method = TXDONE_BY_ACK;
> -
> -	spin_unlock_irqrestore(&chan->lock, flags);
> -
> -	if (chan->mbox->ops->startup) {
> -		ret = chan->mbox->ops->startup(chan);
> -
> -		if (ret) {
> -			dev_err(dev, "Unable to startup the chan (%d)\n", ret);
> -			mbox_free_channel(chan);
> -			chan = ERR_PTR(ret);
> -		}
> -	}
> +	ret = __mbox_bind_client(chan, cl);
> +	if (ret)
> +		chan = ERR_PTR(ret);
>   
>   	mutex_unlock(&con_mutex);
>   	return chan;
> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
> index 098c82d87137..711a56ec8592 100644
> --- a/drivers/mailbox/omap-mailbox.c
> +++ b/drivers/mailbox/omap-mailbox.c
> @@ -441,21 +441,9 @@ struct mbox_chan *omap_mbox_request_channel(struct mbox_client *cl,
>   	if (!mbox || !mbox->chan)
>   		return ERR_PTR(-ENOENT);
>   
> -	chan = mbox->chan;
> -	spin_lock_irqsave(&chan->lock, flags);
> -	chan->msg_free = 0;
> -	chan->msg_count = 0;
> -	chan->active_req = NULL;
> -	chan->cl = cl;
> -	init_completion(&chan->tx_complete);
> -	spin_unlock_irqrestore(&chan->lock, flags);
> -
> -	ret = chan->mbox->ops->startup(chan);
> -	if (ret) {
> -		pr_err("Unable to startup the chan (%d)\n", ret);
> -		mbox_free_channel(chan);
> -		chan = ERR_PTR(ret);
> -	}
> +	ret = mbox_bind_client(mbox->chan, cl);
> +	if (ret)
> +		return ERR_PTR(ret);
>   
>   	return chan;
>   }
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 3c2bc0ca454c..f655be083369 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -283,7 +283,7 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   	struct pcc_chan_info *pchan;
>   	struct mbox_chan *chan;
>   	struct device *dev;
> -	unsigned long flags;
> +	int rc;
>   
>   	if (subspace_id < 0 || subspace_id >= pcc_chan_count)
>   		return ERR_PTR(-ENOENT);
> @@ -296,21 +296,11 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   	}
>   	dev = chan->mbox->dev;
>   
> -	spin_lock_irqsave(&chan->lock, flags);
> -	chan->msg_free = 0;
> -	chan->msg_count = 0;
> -	chan->active_req = NULL;
> -	chan->cl = cl;
> -	init_completion(&chan->tx_complete);
> -
> -	if (chan->txdone_method == TXDONE_BY_POLL && cl->knows_txdone)
> -		chan->txdone_method = TXDONE_BY_ACK;
> -
> -	spin_unlock_irqrestore(&chan->lock, flags);
> +	rc = mbox_bind_client(chan, cl);
> +	if (rc)
> +		return ERR_PTR(rc);
>   
>   	if (pchan->plat_irq > 0) {
> -		int rc;
> -
>   		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq, 0,
>   				      MBOX_IRQ_NAME, chan);
>   		if (unlikely(rc)) {
> diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
> index 65229a45590f..734694912ef7 100644
> --- a/include/linux/mailbox_client.h
> +++ b/include/linux/mailbox_client.h
> @@ -37,6 +37,7 @@ struct mbox_client {
>   	void (*tx_done)(struct mbox_client *cl, void *mssg, int r);
>   };
>   
> +int mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl);
>   struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
>   					      const char *name);
>   struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index);

