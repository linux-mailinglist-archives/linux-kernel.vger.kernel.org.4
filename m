Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2677B6007AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiJQHZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJQHZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:25:37 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77BE5A2DD;
        Mon, 17 Oct 2022 00:25:36 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D3745320084E;
        Mon, 17 Oct 2022 03:25:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 17 Oct 2022 03:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665991535; x=1666077935; bh=L5G3bLzreC
        H3oUCt9+QvMdTXOUAOsrxsngh7C2K0tTg=; b=TORXiOZZgDgjkVaJ3LTQKd5YsA
        YmSOOsWtPZrGEh+sCf+VITfu0GE0HRqE75RSM0Lzgtpb+iBkbyqH7SPeEJz7eRg/
        VHV9Q/JT36NWEnqTdNumoGZdS2tQ2JC/RDKAj9JeYOcIv2pRIfLDA7RJ//ddx4+S
        O2nKvckFiVY8ViaVuv6BIVboDjYtU9MDSqmuE0MsB+ZgxkCEsz3yIcNYkP6MKGIF
        ZdlEi/rOcSyPUNe6deR+tNjQna/JrjRqoahTapJeuqpcX4RjCmHg3dyLexCtdS89
        GsnX6S9tpqxJV3M+O+dbZNaF8UZ0VD8BxgnXsyNPG8aZXcJlQBAD5HW4K9ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665991535; x=1666077935; bh=L5G3bLzreCH3oUCt9+QvMdTXOUAO
        srxsngh7C2K0tTg=; b=rJFVmCCnBgVNZf22MdJXVt7IqOwr1WEXMl8j0HBuEpTM
        ZANp4uJD9jFe6WV8MmVslOrAjIAbu/ueuna9IUdefSBIKGnDjB+57h+tFbtk63kx
        uRjTj5//O1MCzXM5FK2s0lK292nkNzWDRXycPcu54CSZT21vv9u6P+CzRxhaqZpt
        3JKzFHVRUvaPrsFKLK6RaJpSEJt6STM1muK+gB3IOy3R62AQ0SdCvQQSNRIF8aow
        aZiWct3SQtxrOUdZgV+Vp7JB3IKsiWNt6ToOaWzqniRQnpGqJZ7vt1Pq7LEUE1tP
        hJoVFYefVbLded4ZvtbjGtB5EN3bbbTdfzKBuwnMIw==
X-ME-Sender: <xms:bgNNYxjTE5DSyccdl9D8Y59xFq8Vrs7PXiQB_p8gsFWLkS8FycVA1Q>
    <xme:bgNNY2CNLtoibmIRdS3u2PquQFfFdMfkc7Lpi6fF1g5YCeoygFtnGhp2Dst7G5zd0
    8SJ9cGuek75YwZw_oU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekkedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffegffdutddvhefffeeltefhjeejgedvleffjeeigeeuteelvdettddulefg
    udfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:bgNNYxHKtkRqv8yPGPO73LilgdgzDcr9JEasMxEEK7hC1nzPMXSAKw>
    <xmx:bgNNY2S77sWo4tFLl8sj2HRwmIaFi15baxAE4I--4DgtXVnViUGZQg>
    <xmx:bgNNY-xldXfbXHnMsjEOqzA-2zvSSZlh9WXw1gLHzNfxYgpSfLrudQ>
    <xmx:bwNNY1qParKxg80KNqCzj1T_MBACF_12WF1HmOf7PRXR9i8IxrjtnQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D0285B60089; Mon, 17 Oct 2022 03:25:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <f8f803a8-ee36-4f32-8920-1fcf6b2265d1@app.fastmail.com>
In-Reply-To: <039075b210d78d2f4fdeb66b6826b8d2c2836088.1665931914.git.tonyhuang.sunplus@gmail.com>
References: <cover.1665931914.git.tonyhuang.sunplus@gmail.com>
 <039075b210d78d2f4fdeb66b6826b8d2c2836088.1665931914.git.tonyhuang.sunplus@gmail.com>
Date:   Mon, 17 Oct 2022 09:25:14 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Tony Huang" <tonyhuang.sunplus@gmail.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>, krzk+dt@kernel.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com
Subject: Re: [PATCH v10 2/2] mmc: Add mmc driver for Sunplus SP7021
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022, at 5:48 PM, Tony Huang wrote:
> This is a patch for mmc driver for Sunplus SP7021 SOC.
> Supports eMMC 4.41 DDR 104MB/s speed mode.
>
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>

Looks ok to me me overall.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Just one more thing I noticed:

> +#define SPMMC_TIMEOUT			500000
...
> +static inline int spmmc_wait_finish(struct spmmc_host *host)
> +{
> +	u32 state;
> +
> +	return readl_poll_timeout_atomic(host->base + SPMMC_SD_STATE_REG, 
> state,
> +					(state & SPMMC_SDSTATE_FINISH), 1, SPMMC_TIMEOUT);
> +}
> +
> +static inline int spmmc_wait_sdstatus(struct spmmc_host *host, 
> unsigned int status_bit)
> +{
> +	u32 status;
> +
> +	return readl_poll_timeout_atomic(host->base + SPMMC_SD_STATUS_REG, 
> status,
> +					(status & status_bit), 1, SPMMC_TIMEOUT);
> +}

500ms seems like an awfully long time for a busy-wait, I wonder if this
could be improved in some way. Is this always called from atomic context?

If not, any callers from non-atomic context could use
readl_poll_timeout() instead, or maybe there could be a shorter
timeout in atomic context, with a fallback to a non-atomic
workqueue if that times out, so only the MMC access will stall but
not the entire system.

The same problem does appear to be in dw_mmc.c and mtk-sd.c but not
in sdhci*.c, so I don't know if this is avoidable.

     Arnd
