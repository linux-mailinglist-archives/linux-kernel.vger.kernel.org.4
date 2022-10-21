Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4424D608250
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 01:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJUX4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 19:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiJUX4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 19:56:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421A027A331
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 16:56:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so4466979pjl.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 16:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hje6EunuDP9DWrr4JWS+s1TvFNrmcjCoVRAOx7KVGQM=;
        b=dBg0CFvHgnRgrexxiZSFWh2X8imSNKC3VNq/j//udYbbkGWXUpNncKdqFMPE3k4PI0
         XtO32Yt+PUiJx7Dy27blJAdYQNWby7GQUkh3UDIioePM2+6OaubxmOk6iAIFOSoiE8c9
         Rj924dJmmtH6NUMrh2M0DiOf0jgVvydTBzikg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hje6EunuDP9DWrr4JWS+s1TvFNrmcjCoVRAOx7KVGQM=;
        b=Z9BuRoPKYEO6Y/aaCzGpj+6g9N2/oI+A8OoDG9kFLkmfaWhl8povO5ZG3XGPNNqkbU
         jKXoUCN3UY08VoeBMr8pjOw8HvQt01E9qgHzCWyloK1O2tPnaSNsiKo5apKdmIrB2Rnp
         ZnUJYr+VFecdmlv0xBGVp7jDcTCeTSHgTxzSiHfrdMiF4fdfvFa2wVeAvFqkOEvCF8wN
         W6e9VFSgLyxoeRW4IDgBx7/Dws/kiL80W21OcUVtY11T7Qb335O45F5CI/F/ctohijzj
         74iJhobUNgoqAzBQ7s6oKS60R57sszL0dKT9YSAy3LdVRC7uXG9e3xfRTNN0F57PLfgd
         ipow==
X-Gm-Message-State: ACrzQf0+ScJBda3Y4ngNWzUJvAwpzCA1BSjMuehZteqiXGnC9dDFaSl/
        lFE/CT/x6ZTSJW8QN5UIqeIsSw==
X-Google-Smtp-Source: AMsMyM5Q1MTfnEBurUhOFMrLXVK5esqpwye/o8J+A0FG/i7JxIXrEJMoif6NsZI1zn0Ejurz2JVIHQ==
X-Received: by 2002:a17:90b:17c7:b0:20b:7cb:9397 with SMTP id me7-20020a17090b17c700b0020b07cb9397mr55874802pjb.191.1666396590505;
        Fri, 21 Oct 2022 16:56:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e17-20020aa798d1000000b00562ea6eeeb2sm16130061pfm.93.2022.10.21.16.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 16:56:29 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:56:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [PATCH 2/2] x86: Improve formatting of user_regset arrays
Message-ID: <202210211656.734DBC81@keescook>
References: <20221021221803.10910-1-rick.p.edgecombe@intel.com>
 <20221021221803.10910-3-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021221803.10910-3-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 03:18:03PM -0700, Rick Edgecombe wrote:
> Back in 2018, Ingo Molnar suggested[0] to improve the formatting of the
> struct user_regset arrays. They have multiple member initializations per
> line and some lines exceed 100 chars. Reformat them like he suggested.
> 
> [0] https://lore.kernel.org/lkml/20180711102035.GB8574@gmail.com/
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
