Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1479D5E8888
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 07:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiIXF2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 01:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiIXF2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 01:28:22 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0FB14595F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 22:28:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id u69so2037598pgd.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 22:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=n9mIFFUz+T7uzqeFEnuohJ6a+X7KhoEOiIg4sADalFc=;
        b=DMo/kxxHl+Sb+Hj218OrIpHroTvFp5bVZW/blQ+vD2xPuKFvzWV2XfFMYZC1slpkHg
         RKrTtkaoAGI0KeDNQ12tSDjhEm+ho4NrFro1D2Di0rypfTv40/6Fqz49lkpFtSMKXW+b
         q8+2e6If6ow7WCVv3mHzBTuCjepy7Z4j64V4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=n9mIFFUz+T7uzqeFEnuohJ6a+X7KhoEOiIg4sADalFc=;
        b=QXdjR9wY1llJUhZRudLqyrEgnfe/DYjFACmcosSOhLrYgS5KFXTxYRY+w1Y1T4rvB3
         2mM/HR2hWTCWkvY7ZZWLg4boecwSYQMNCVrK2WtAmDozpTqTSuEREXr/nYGRMwhn11K8
         5Pv53XjilSQmB53eXS6KP3oqn3jUGGWP+7ji9WaSq11LIcFmLAqiSyIhPeNAqfTCPaJu
         Ud9+zl2tHJOAWXJdl3FJZsZlOYgiifUwCPXzPL8S/1R++9/jSI2Td1BhWQW3nu6XpU2g
         qEAD/BjJmwVVAYPU/58nHjyee+blAtU36Gu9rDYT2KaS7sl5TYwxJrZGGD/e+E9rozl9
         7rZQ==
X-Gm-Message-State: ACrzQf2ihdk7KCAn6QXiYJixA6tCrqy0JUY6Nbu6psRnAMeP1yULA5Py
        eqsnPpAoI62S4GNcpiLZBFFAOLKsa1Epzw==
X-Google-Smtp-Source: AMsMyM7aAuSih3DGaIHDIjGNOp3XiITsYugjJXNQV613GX2y2nc6YZcMCh4lpIlCsz/1lj5HVe6+Gw==
X-Received: by 2002:a63:470e:0:b0:438:a091:5a3b with SMTP id u14-20020a63470e000000b00438a0915a3bmr10499420pga.332.1663997300746;
        Fri, 23 Sep 2022 22:28:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y21-20020a626415000000b0053e607a6bf0sm7359583pfb.43.2022.09.23.22.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 22:28:20 -0700 (PDT)
Date:   Fri, 23 Sep 2022 22:28:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: 3w-xxxx: Replace one-element array with
 flexible-array member
Message-ID: <202209232227.7D348DF@keescook>
References: <YyyyvB30jnjRaw/F@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyyyvB30jnjRaw/F@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 02:08:44PM -0500, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct TAG_TW_New_Ioctl and refactor the rest of the code,
> accordingly.
> 
> Notice that, in multiple places, the subtraction of 1 from
> sizeof(TW_New_Ioctl) is removed, as this operation is now implicit
> after the flex-array transformation.

Doing a build before/after this patch results in no binary output
differences. Another 1-element array converted! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
