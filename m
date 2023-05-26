Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC77B712C02
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbjEZRnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbjEZRnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:43:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E831C9
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:43:51 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25345ca8748so1095706a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685123030; x=1687715030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hg9Y1Zeqm2LukQubiT8t4V/vqubtiFOiCTgTYUMaUVs=;
        b=lta3MXHxjS1c7AJAUPLUOeHcr5x4Zo3I0sh7vWvpASJEc8uOh/eMfflNOlqqurTpiC
         y1tn4GMr/aIo9mLeE/wroXnkfagYh0cxm5KsTTxf2BD+1Xlltby4ztTCm4k6kClJA5qo
         sIYWv8PJerV3mljMW1vWIqC1jQcttRocREL9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685123030; x=1687715030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hg9Y1Zeqm2LukQubiT8t4V/vqubtiFOiCTgTYUMaUVs=;
        b=JpGDAv4xaZ7wfeQkIjrpgEsxcucgzaot63nnw632F2c0Twt6mFO/zzXttt6L42cD2A
         fIBeGPZAnO0Hn71Fi6GU4xeWva+t7BqFBzgwNCFogopuGLu4AoixVvKtvBBUFHUQ/hAv
         /a0lXJs/fEuPR/hxCADxOqrjFF/3P2GekCis6CGPZpPeoJgdFQGgsPA5irtx9mMZyR8T
         E5fE3vw2v5z2E+ZH4AH8NsC2LL0+XPIfT093ZSmNIpfdQ2eUiaZX5P3PjheTzaZEdYAX
         ztSS2pjaZcK4rSF0XxNCJPyzabeSpB2ojLr7EYsGPLFHmewC8EoOtreKA0MTyefYU9es
         j8qQ==
X-Gm-Message-State: AC+VfDwhsk6dPG9hTYe25qCwgFri4qnp05ylGPa0KG00Qb1YDW8rlvDy
        1f2SeZVoRvJ0GX+5Zn72ccvdlw==
X-Google-Smtp-Source: ACHHUZ7/7bJzxKpXODcLcQHpGpV/j9si5r5SwPI1mqbMjnGFBZlzEi+VmgCEu3f6lGaHSTOA1ark4A==
X-Received: by 2002:a17:90a:55c9:b0:253:27b4:cd4d with SMTP id o9-20020a17090a55c900b0025327b4cd4dmr2849789pjm.27.1685123030618;
        Fri, 26 May 2023 10:43:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 127-20020a630385000000b0051b5d0fe708sm3074081pgd.43.2023.05.26.10.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:43:50 -0700 (PDT)
Date:   Fri, 26 May 2023 10:43:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] media: pci: cx18-av-vbi: Replace one-element array
 with flexible-array member
Message-ID: <202305261043.A86E75BD5B@keescook>
References: <ZG1YVji9thTLWeRm@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG1YVji9thTLWeRm@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 06:20:38PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in struct vbi_anc_data.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
