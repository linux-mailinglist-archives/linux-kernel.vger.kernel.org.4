Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0F467758F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 08:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjAWHYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 02:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjAWHYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 02:24:06 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE66883EC
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 23:23:50 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i65so8129933pfc.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 23:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m6tKnmsJto8KD4J43SeQBXNxHSRMZg2BEAm8vOemlMs=;
        b=imgatys2gOwj1+CmS5nKJZghqisUaHWlguo9LLcyM/LU0uLMA0+3QMNsLoikalaKia
         2dAv4UawkBfT33PRvgi8dSWWh3WCz34fxmOUi2ZX8ccTbl+IShNiNwhDK1mCJAnbss5P
         sd6bXgSSRWz9+bNiA1/1QYGFVwJzekmDj29iDsJvKkTkpMTUh6r+8MsKxt5AuIyobm3w
         zvSLo3DwqPwwdavVKlzq4VJJdVTi0TDRds8jqAFsM1gK2vlxBsrU8l+cSmnyoFxDRu/Q
         ceTN3oFu7yE5BpzEgaVhqI+XE76y9Owzv6edMpMrUbdXaSZAmVrpoomT06Cy5B+2+72Q
         Ud6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6tKnmsJto8KD4J43SeQBXNxHSRMZg2BEAm8vOemlMs=;
        b=Mv4IUtnpqdfgxWm37Y1Pq2lJ+0+2Oaw2ZmJJYWAy0QJ3m7XpbnROTH32Es0quIur16
         7nmSRVu+AitRPFkqwa0QFAamrwYcVLJMuoDgEn0DcRiCK61b9rZuA/5nHWFMRKH+ShQY
         IkVAFnniq2aWw4GOVhzKtfhAtQOoQinQOERXl+hFtlgEPeSO6/i5M0DSRmXuI7IT90p1
         LrNk6HElgHg5NZ7BHCeAIAqqp5UBxdtDv7z8mrLdnw11K4zcMsxRCPLHy6Z+uD/R7aal
         KVO33eyM+UjgixOL9av3RwHB2euaQNM1IMufHscd6hCYJRB7GjyOEcuKQufosOy4e6/l
         HFng==
X-Gm-Message-State: AFqh2kp4AgijVzVx34SBUwul0XnzY+Q6wQoqfvOyIVnY9j2Q7XOsnsTA
        KCxg12UBP+SaeL/wlRBGQ1Df
X-Google-Smtp-Source: AMrXdXtSmM5/wlX9Cp8Nl4+aTYcH4xyLP/uQeYZbZVprkpOr08XwZgbhvSRkp3J35n0JnC6l+Vu0dA==
X-Received: by 2002:a62:1507:0:b0:581:6069:5c00 with SMTP id 7-20020a621507000000b0058160695c00mr24893986pfv.28.1674458630223;
        Sun, 22 Jan 2023 23:23:50 -0800 (PST)
Received: from thinkpad ([117.193.209.99])
        by smtp.gmail.com with ESMTPSA id z13-20020aa79e4d000000b0058bc1a13ffcsm17005111pfq.25.2023.01.22.23.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 23:23:48 -0800 (PST)
Date:   Mon, 23 Jan 2023 12:53:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] MHI EP fixes and improvements
Message-ID: <20230123072341.GA14294@thinkpad>
References: <20221228161704.255268-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221228161704.255268-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 09:46:58PM +0530, Manivannan Sadhasivam wrote:
> This series fixes several issues on the MHI EP stack and also improves
> the suspend and resume functionality.
> 

Applied to mhi-next!

Thanks,
Mani

> Thanks,
> Mani
> 
> Manivannan Sadhasivam (6):
>   bus: mhi: ep: Power up/down MHI stack during MHI RESET
>   bus: mhi: ep: Check if the channel is supported by the controller
>   bus: mhi: ep: Only send -ENOTCONN status if client driver is available
>   bus: mhi: ep: Fix the debug message for MHI_PKT_TYPE_RESET_CHAN_CMD
>     cmd
>   bus: mhi: ep: Move chan->lock to the start of processing queued ch
>     ring
>   bus: mhi: ep: Save channel state locally during suspend and resume
> 
>  drivers/bus/mhi/ep/main.c | 79 +++++++++++++++++++++------------------
>  1 file changed, 42 insertions(+), 37 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
