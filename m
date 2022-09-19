Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CF95BC566
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiISJcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiISJb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:31:59 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27869140A2;
        Mon, 19 Sep 2022 02:31:59 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A12EB5C030A;
        Mon, 19 Sep 2022 05:31:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 19 Sep 2022 05:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1663579916; x=1663666316; bh=V0o7LEef+B
        ZuEidJK6a/jvVmiWZ9XRI7Dey6frbpCPk=; b=uS4UCKxajYjRcBSiGgj7YYfQgp
        7CV1pvuYtM22JSYUOoBecJOFPdcUwfEOmxkQHAqBG0hGgvMGJcw2g+WAe0Rze9YN
        ifKNitab6fe+/qGmKK0RjXn8cQMNFQ2j7+IcjZTPrR4/1/14H0OI2Si+nCYo11xl
        cudG4XPZVi+uMesbwiK1SXgcSsrQ7nfHogd/e8UiQEaT7yYdCvMV42VC8NdPQD4Q
        Vh++z4i3eL3+VJETP8Vh7JYbudlGzBsa+E8ZYDRnFNx4Fl+cIHNOIz5gvCL1Ojk/
        hpvXhCbymHebLhXvGdR6QSgqqrBIIonftKnOq+I0MxoJnfWYyL+fmvJ1mPJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663579916; x=1663666316; bh=V0o7LEef+BZuEidJK6a/jvVmiWZ9
        XRI7Dey6frbpCPk=; b=I2bfSFrcOnMc6+xYDDMwW8dye5KJa46GzTzKhBHM26a+
        lQcwJqJfrxMkN7hGy5qGDS8Yb7OW4ojzzqPaiodQ+O1UepGLM5jAo6E5Ig6ETqgb
        wz1QGaFzLQAMNuh8pAUazhZcTVBbyOUf9zal+7cDkQ2id3jCWBivEcW5CJZmmMRn
        oGOeFn0lLyM9P2fe1gxhZtPfOykcoG0jxXZLoByNC0+/5CZhT2YFa1NQhOLExKk9
        GHgZx6oxO3Qxd6TOHIYtRogGp7rseQOGyJbfLJrsAuZOJWx35yOAOzxkurDzqa+a
        nvxVI5jVQJYDRLHNybSCXuk7jdzG5DgUxYzQKLbnfg==
X-ME-Sender: <xms:DDcoY-N1INGZqGF6Omi4QOCScnI4OUQwoDnkh8hYkBrc49uphyYwmg>
    <xme:DDcoY88_9gNC2cPybmgl2wOlVlZ3vi8Y4EFLUN_DXmCEBMn-UUX4ORJRRUJ7mVve_
    eLkFq177DO-fw>
X-ME-Received: <xmr:DDcoY1R9YTmgAY0Klsoh4uhks_vOgQC5J7_GVh1hw4WWp5jJFcxNwNqMtcc2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvjedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekje
    euhfdtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:DDcoY-tAb6tZ_QcyeApGlk3lfl5DXtxruRqO_SN2g27UONvrJRnOkw>
    <xmx:DDcoY2eKmdGEqlu375C2KRf23PguPbIXx3Iz1O9MBNo9tgSPjJAXzQ>
    <xmx:DDcoYy0Uk5rA1eHMjxHFn4bzIUnwUsyKN0iasz9iiPCSFbsHcAb67w>
    <xmx:DDcoY3uZlR4e6DEivEyVIwRZ6mCdzZ9dgz8K-v8Lhqs-TskkiYqMTA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Sep 2022 05:31:55 -0400 (EDT)
Date:   Mon, 19 Sep 2022 11:32:24 +0200
From:   Greg KH <greg@kroah.com>
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        etremblay@distech-controls.com, l.sanfilippo@kunbus.com,
        u.kleine-koenig@pengutronix.de, robert.hancock@calian.com,
        ilpo.jarvinen@linux.intel.com, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, jirislaby@kernel.org
Subject: Re: [PATCH v1] drivers/tty/serial/8250: check the return value of
 clk_prepare_enable()
Message-ID: <Yyg3KKDCLaQUb2P0@kroah.com>
References: <20220919085455.1582310-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919085455.1582310-1-floridsleeves@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 01:54:55AM -0700, Li Zhong wrote:
> Check the return value of clk_prepare_enable() which could fail when
> cannot enable the clock.
> 
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_of.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index 1b461fba15a3..23e9b9e8c940 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -298,7 +298,8 @@ static int of_serial_resume(struct device *dev)
>  
>  	if (!uart_console(port) || console_suspend_enabled) {
>  		pm_runtime_get_sync(dev);
> -		clk_prepare_enable(info->clk);
> +		if (clk_prepare_enable(info->clk) < 0)
> +			dev_warn(dev, "can't enable clk.\n");

Again, you check but do nothing with the error :(
