Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DA8654978
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiLVXl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiLVXlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:41:52 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A8624F3C;
        Thu, 22 Dec 2022 15:41:51 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-14455716674so4283295fac.7;
        Thu, 22 Dec 2022 15:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zLVTDhQkhkkOhVaajrbRJWJyIpvSWPik4eDzrj93Eo=;
        b=VeRJmeuCpd+YvybCRDK5hCn9VxGaB2UyHLccBz5tXVRCduoovoONjzUw2/NhLV+pZ5
         XLWGVAkJbx2jkF+mJ/2dIJmuHePqxZKlFugMT5fFg6m87pGj0meUsZGYHeewSteZx+PD
         QnT6AWBeURXUQHQItU5JBLKdPuRNYSTU2624TnqeZSQF7YJNCTv5hVthqdNVofoswHxv
         7u+1NDixhKBX6BExD2p/Ud1LIPBtGvOnFyS3JiP/+bzP5plfxUMYVl1H4fMCKrF1UixC
         BliaJSAJDZlp+N6q3DsK59c4pWRiEH1XFzYGI3vUKzv3iHL3Xj01OQB4JdFmkLOXsxTk
         0giA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zLVTDhQkhkkOhVaajrbRJWJyIpvSWPik4eDzrj93Eo=;
        b=ZV6CjVpIracHqL+TnFcDPaBCKphYC6qHny3Q878mdxtPmbqPaCJrYjXC6yvhpboZEW
         Au5DZNofYtcRgI+gs+w32XhVe1IdFBkk+mSkxutoWRTXGcYxjrVb9fpDND3dGLIqL7Lw
         4uwKpEIsGsrLn9dzQe1UVjM3yggvQNZaoLMNRq/E9ZxzqZeix0gp11ovlINRY2LrXIai
         Dw7klJiyqFQ3IeXO3adIBaeNGUX4p681j1UyCQCwEsFn9vHwucZ8uXfIaUhd8x6WfQsd
         JXywZhjD2NjIA8/eSijcN7LWr9zQMML1NmVKs5cejOqyqTvHYsiW5MKUBjAXGNcQ0YNj
         y+4g==
X-Gm-Message-State: AFqh2krYUkBBTR2jXyaMvqlwjopTt7ZLzIxcgEelzYNKYICFO82GmXQZ
        kjiAxxBWBuy/iADzhe+YE6o=
X-Google-Smtp-Source: AMrXdXty65bPwZdolsRHLGbGuU6BUhDVw/GAZUX0Csf0dV6gHtH6s/Vk+AF9C9LTh/ILV9ECKdSeow==
X-Received: by 2002:a05:6870:2f01:b0:144:e6fb:b2b4 with SMTP id qj1-20020a0568702f0100b00144e6fbb2b4mr3504664oab.20.1671752511261;
        Thu, 22 Dec 2022 15:41:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z44-20020a056870c22c00b001375188dae9sm681952oae.16.2022.12.22.15.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 15:41:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 22 Dec 2022 15:41:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: drivers/hwmon/jc42.c:477 jc42_readable_reg() warn: always true
 condition '(reg >= 0) => (0-u32max >= 0)'
Message-ID: <20221222234148.GA2776378@roeck-us.net>
References: <202212222251.Xacx8c4D-lkp@intel.com>
 <CAFBinCAB0VuoKKm4YHv_zB1d1xN3nP0=-xg9EotiWMJ_vikc2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCAB0VuoKKm4YHv_zB1d1xN3nP0=-xg9EotiWMJ_vikc2w@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 10:20:13PM +0100, Martin Blumenstingl wrote:
> Hi Guenter et al.,
> 
> On Thu, Dec 22, 2022 at 3:36 PM kernel test robot <lkp@intel.com> wrote:
> [...]
> >    475  static bool jc42_readable_reg(struct device *dev, unsigned int reg)
> >    476  {
> >  > 477          return (reg >= JC42_REG_CAP && reg <= JC42_REG_DEVICEID) ||
> >    478                  reg == JC42_REG_SMBUS;
> The bot is right: we can omit "reg >= JC42_REG_CAP" as it's already
> covered by the fact that:
> - the reg variable is unsigned, which means the lower limit is zero
> - reg <= JC42_REG_DEVICEID covers the upper limit
> 
> Before I send a patch I'd like to hear if removal of "reg >=
> JC42_REG_CAP" makes sense to other people.
> 

The bot keeps complaining about it. Yes, it is technically unnecessary,
but I left it in on purpose to indicate that JC42_REG_CAP is the first
register and that it wasn't forgotten. Any modern C compiler notices
that the check is unnecessary and drops it, so there is no runtime penalty.

This is one of those situations where I'd like to have a means to tell
the checker to please stop complaining.

Guenter
