Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5064862CD7D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiKPWR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiKPWRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:17:55 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00B059FC2;
        Wed, 16 Nov 2022 14:17:53 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A6B01240008;
        Wed, 16 Nov 2022 22:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668637071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RI1LvePrb+R7TFdEOddF/nsaOprjMV2xUscy58JV8Vg=;
        b=Wug5GmIcVtrQNgWPhOq0mdJ8DIz6YYfWOpJCS90OLxs2HChw+NRzzGEfsKBsYR4iCssxOp
        dWAo6GyKl66zIw7m2HZ+Rqckdg4u8jbyaSE4mij0YJirahN+KxHdw46P4r2urWVTq3kDmv
        WotgcFvLd2lwsXWIYwrZzLzegUVVEYbT0B8vcp2+D7JtZr2MMfy1olcBYpei/XJfqkuwh0
        rL2GKX0eV/5KmNs36uFvpI3nfM22LU/nqKaKYN8xp7EhasAQNqM3B7uUsi5ftnvZKkPlJH
        HrKzpmtiJWEWEh/R3UKug2COYWtAvXtnwEk+Lgd706wVndvE51O8DAbJPoea4w==
Date:   Wed, 16 Nov 2022 23:17:49 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Riwen Lu <luriwen@hotmail.com>, a.zummo@towertech.it
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v1] rtc/rtc-efi: Add wakeup support
Message-ID: <166863698279.2504707.17372142903256716884.b4-ty@bootlin.com>
References: <TYWP286MB260191455377CEBD2336557EB1659@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYWP286MB260191455377CEBD2336557EB1659@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022 15:01:09 +0800, Riwen Lu wrote:
> From: Riwen Lu <luriwen@kylinos.cn>
> 
> Add wakeup support for rtc-efi, so we can wakeup from S3/S4/S5 through
> rtcwake.
> 
> 

Applied, thanks!

[1/1] rtc/rtc-efi: Add wakeup support
      commit: eec79501cce6e8965e92174760c6a9e92d78a038

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
