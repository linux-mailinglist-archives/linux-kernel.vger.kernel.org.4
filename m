Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18146558BE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 07:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiLXGtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 01:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiLXGtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 01:49:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8902A1AA31;
        Fri, 23 Dec 2022 22:49:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D4F4B81CD9;
        Sat, 24 Dec 2022 06:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734A0C433D2;
        Sat, 24 Dec 2022 06:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671864544;
        bh=TDbwSX+RZR85hFNOXP679l8Ts/uVY1WswfG1Rm5eWpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NILFU/aF5VNT1SOEMGiPNn1U/V5SmGstafo839scVcFjKX+SLxbR3Pgy3usDkVyM+
         w3bHMlHzM4YnhAL0fQXqUoDIMLQ/i2+OO7scNTfxlyShzATTa/xgvFBDgkqQN2cwa4
         O04xzRtAMjFVVDbLrmJD7ShDnnRA2t1TPbVWl4Oo=
Date:   Sat, 24 Dec 2022 07:48:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com, tiwai@suse.com,
        robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [RFC PATCH 05/14] sound: usb: Export USB SND APIs for modules
Message-ID: <Y6ag20C20gVFGE5F@kroah.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-6-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223233200.26089-6-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 03:31:51PM -0800, Wesley Cheng wrote:
> +EXPORT_SYMBOL(snd_usb_autoresume);

EXPORT_SYMBOL_GPL()?  I have to ask...

Same for the other ones here.

> +EXPORT_SYMBOL(find_format);

That is not a valid global symbol name to use, you know better than
this...

thanks,

greg k-h
