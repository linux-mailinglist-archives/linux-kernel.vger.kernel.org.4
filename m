Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111015ECB85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiI0RsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiI0Rrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:47:46 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509A4152228
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:44:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so3058143pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=AbMFM0U1g4F1p6WLK/y1YrWC4NA9wHiAjkyVREWv3UI=;
        b=QOKrpnEGBPqCPXYUduXdmk17ZdEH6S2ZdZTKCNHICsm6I8IQ89KSTN8e1Xn/BTVv52
         XAece0Wy1YC21pSphYoGkOjfs+6DLkqLP1Y8gx4YC8OsPiB0wE72CvqiOSxlWFvprjkX
         +vrmS1s7s73EVOBixAA/Neq0f8FC5vgKktUyzy8B4Jec5RaLvHVDgZBG2oCwnAsIw1QT
         5JsomD8cv6kM8jDli0s7Hu/RT9opnq2E14rnRW97NihV2BjEmHzG1oS5CVHZcz+wiSCE
         pp6ka6yre3/vSzN7v7t8nEWwaU7S4bjZfsDLLzFLcr4JBqzSykBHBaBWCXCjdCd+sqlV
         C7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AbMFM0U1g4F1p6WLK/y1YrWC4NA9wHiAjkyVREWv3UI=;
        b=iBhwJP/AuhUVwv9HFCLF4gFal6//sXb0M/fC1SOAdd3thZpRvl4ud30KBsNbqf3y3+
         jZKI0gPRm4Ytc0kEBU9dKLgIIhJMFNHIewFuAtDHAjXnZxSZqX6sz9fTH91RotXFTAsq
         txtPLdYLSnOy1GxciJbHg5EHo4YvPbym4achbApQzLr1AtnkLVwy9eljwFnIpufR90LU
         MsTQKdggzabgoRd3nFBAEer4ZwvdovtFqJVhlttrA8gzE6Ve2rKYFpxvueJmMgGP7nSI
         OjcRLEHr7Y2ZkiUL2BUjOPDKU74ee/uzVmbgSRJcZ+zmUa4lJ0zaOuFeA2xk9yaytov8
         zx5g==
X-Gm-Message-State: ACrzQf326Km/2vo3NXguaJmhBhI4TJ8WzGkkOKfkhU2Tq3JTyRpWjPZJ
        aHeUoMnbGn5zOfJy9qncUFqhrw==
X-Google-Smtp-Source: AMsMyM5ZKlDSXdodURw4ueb+lTqhNV2eWD/LsRj24OoX3SiayP1IN4J9cOsGGbCkj3DFHckHdXKOeA==
X-Received: by 2002:a17:902:7294:b0:178:a2be:ac13 with SMTP id d20-20020a170902729400b00178a2beac13mr28095739pll.59.1664300682278;
        Tue, 27 Sep 2022 10:44:42 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t17-20020aa79471000000b0053ebe7ffddcsm2061028pfq.116.2022.09.27.10.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:44:40 -0700 (PDT)
Date:   Tue, 27 Sep 2022 11:44:38 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V7 2/2] remoteproc: support attach recovery after rproc
 crash
Message-ID: <20220927174438.GA2883698@p14s>
References: <20220705011527.2849057-1-peng.fan@oss.nxp.com>
 <20220705011527.2849057-3-peng.fan@oss.nxp.com>
 <20220926220610.GA2817947@p14s>
 <DU0PR04MB941767AEDD07DBA7E7FF9B6E88559@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <6aae3d16-0570-793d-4bf8-0a0fddb00be9@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aae3d16-0570-793d-4bf8-0a0fddb00be9@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:10:31AM +0200, Arnaud POULIQUEN wrote:
> Hi,
> 
> On 9/27/22 05:03, Peng Fan wrote:
> > Hi Mathieu,
> > 
> >> Subject: Re: [PATCH V7 2/2] remoteproc: support attach recovery after rproc
> >> crash
> >>
> >> On Tue, Jul 05, 2022 at 09:15:27AM +0800, Peng Fan (OSS) wrote:
> >>> From: Peng Fan <peng.fan@nxp.com>
> >>>
> >>> Current logic only support main processor to stop/start the remote
> >>> processor after crash. However to SoC, such as i.MX8QM/QXP, the remote
> >>> processor could do attach recovery after crash and trigger watchdog to
> >>> reboot itself. It does not need main processor to load image, or
> >>> stop/start remote processor.
> >>>
> >>> Introduce two functions: rproc_attach_recovery, rproc_boot_recovery
> >>> for the two cases. Boot recovery is as before, let main processor to
> >>> help recovery, while attach recovery is to recover itself without help.
> >>> To attach recovery, we only do detach and attach.
> >>>
> >>> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >>> ---
> >>>  drivers/remoteproc/remoteproc_core.c | 62
> >>> +++++++++++++++++++---------
> >>>  1 file changed, 43 insertions(+), 19 deletions(-)
> >>>
> >>> diff --git a/drivers/remoteproc/remoteproc_core.c
> >>> b/drivers/remoteproc/remoteproc_core.c
> >>> index ed374c8bf14a..ef5b9310bc83 100644
> >>> --- a/drivers/remoteproc/remoteproc_core.c
> >>> +++ b/drivers/remoteproc/remoteproc_core.c
> >>> @@ -1884,6 +1884,45 @@ static int __rproc_detach(struct rproc *rproc)
> >>>  	return 0;
> >>>  }
> >>>
> >>> +static int rproc_attach_recovery(struct rproc *rproc) {
> >>> +	int ret;
> >>> +
> >>> +	ret = __rproc_detach(rproc);
> >>> +	if (ret)
> >>> +		return ret;
> >>
> >> I thought there was a specific reason to _not_ call rproc->ops->coredump()
> >> for processors that have been attached to but looking at the STM32 and
> >> IMX_DSP now, it would seem logical to do so.  Am I missing something?
> > 
> > ATTACH RECOVERY is to support recovery without help from Linux,
> > 
> > STM32 and IMX_DSP, both require linux to load image and start remote
> > core. So the two cases should not enable feature:
> > RPROC_FEAT_ATTACH_ON_RECOVERY
> > 
> > Also considering the recovery is out of linux control, actually when linux
> > start dump, remote core may already recovered. 
> 
> I asked myself the same question. Indeed how to manage a core dump if the
> remote processor restarts autonomously.
> The answer doesn't seem obvious because it seems to be platform specific.
> 
> For time being on STM32 we consider that the remoteproc memory can be corrupted
> so we don't plan to enable the feature by default even if the hardware allows it.
> 
> If we implement it, I would see 2 use cases:
> - no core dump, the remote processor restart autonomously (need to manage the
> VIRTIO_CONFIG_S_NEEDS_RESET in resource table vdev for resynchronization)
> - core dump and the Linux stm32 driver handle the reset of the remote
> processor core to be able to perform the core dump (no firmware loading)
> 
> What about dealing with the coredump in a separate thread, based on a concrete
> use case/need?

Definitely, we can deal with that later.

Peng - please send me a rebase as quickly as possible.

> 
> Regards,
> Arnaud
>  
> > 
> >>
> >> And this set will need a rebase.
> > 
> > I'll do the rebase and send V8 if the upper explanation could eliminate
> > your concern.
> > 
> > Thanks,
> > Peng.
> > 
> >>
> >> Thanks,
> >> Mathieu
> >>
> >>> +
> >>> +	return __rproc_attach(rproc);
> >>> +}
> >>> +
> >>> +static int rproc_boot_recovery(struct rproc *rproc) {
> >>> +	const struct firmware *firmware_p;
> >>> +	struct device *dev = &rproc->dev;
> >>> +	int ret;
> >>> +
> >>> +	ret = rproc_stop(rproc, true);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	/* generate coredump */
> >>> +	rproc->ops->coredump(rproc);
> >>> +
> >>> +	/* load firmware */
> >>> +	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> >>> +	if (ret < 0) {
> >>> +		dev_err(dev, "request_firmware failed: %d\n", ret);
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	/* boot the remote processor up again */
> >>> +	ret = rproc_start(rproc, firmware_p);
> >>> +
> >>> +	release_firmware(firmware_p);
> >>> +
> >>> +	return ret;
> >>> +}
> >>> +
> >>>  /**
> >>>   * rproc_trigger_recovery() - recover a remoteproc
> >>>   * @rproc: the remote processor
> >>> @@ -1898,7 +1937,6 @@ static int __rproc_detach(struct rproc *rproc)
> >>>   */
> >>>  int rproc_trigger_recovery(struct rproc *rproc)  {
> >>> -	const struct firmware *firmware_p;
> >>>  	struct device *dev = &rproc->dev;
> >>>  	int ret;
> >>>
> >>> @@ -1912,24 +1950,10 @@ int rproc_trigger_recovery(struct rproc
> >>> *rproc)
> >>>
> >>>  	dev_err(dev, "recovering %s\n", rproc->name);
> >>>
> >>> -	ret = rproc_stop(rproc, true);
> >>> -	if (ret)
> >>> -		goto unlock_mutex;
> >>> -
> >>> -	/* generate coredump */
> >>> -	rproc->ops->coredump(rproc);
> >>> -
> >>> -	/* load firmware */
> >>> -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> >>> -	if (ret < 0) {
> >>> -		dev_err(dev, "request_firmware failed: %d\n", ret);
> >>> -		goto unlock_mutex;
> >>> -	}
> >>> -
> >>> -	/* boot the remote processor up again */
> >>> -	ret = rproc_start(rproc, firmware_p);
> >>> -
> >>> -	release_firmware(firmware_p);
> >>> +	if (rproc_has_feature(rproc, RPROC_FEAT_ATTACH_ON_RECOVERY))
> >>> +		ret = rproc_attach_recovery(rproc);
> >>> +	else
> >>> +		ret = rproc_boot_recovery(rproc);
> >>>
> >>>  unlock_mutex:
> >>>  	mutex_unlock(&rproc->lock);
> >>> --
> >>> 2.25.1
> >>>
