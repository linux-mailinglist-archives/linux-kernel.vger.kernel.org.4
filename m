Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BC36237EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiKJAGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiKJAGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:06:05 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540B314D2E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 16:06:04 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso248406pjc.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 16:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sKYR/6cUdhX3Vuj9JNFsE4/716O2C/3zbc2aqPYZENk=;
        b=QLp7+rJ0Tkzgcpea/z23kXkYequIgUVduyyzLmIiEuGmxmF7waJaIjCh6aErPmQ+Q4
         QZAaU13ODIT9CEUDYrJC8mLJK9a+IvEKtKPnuyuUHQwl33QFViZqKYc1SLfrMOskM/d2
         EqUGZ4nk+rM3DU3FJfq3vPvyHmCCZLv607bwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKYR/6cUdhX3Vuj9JNFsE4/716O2C/3zbc2aqPYZENk=;
        b=z0pgwc8lrAC3Th9a4BKaVM19X+0RBR9tXkQ7Cx2tqwzQL7et91zj6yCfT8VYvVGNbi
         cJRRQd6Vm3d65xA04AlpDsFQuRc8T9f4QYCW0nHXvpvCakizDfW7Ezelwq2n3A9RIO+E
         fyWDrzd7tFmDWZf3eXRiLFwnFMVlpeMUn0nUdzHHv7lTQCHd4GkTb8bvsJJfnK5JF1DM
         sbGbf7kXyqDBuG/Ph/MEdyglxp02WjaVpxCXDAlm9+3Eva4ken/J57znaoeQTdH9EjYi
         0MTW6z9920HTnv7Yif/kd7CCx/AAHUsSrGBANRMLYLPlmf+DCp3PadSaFvA8sAYtdlL6
         4vdA==
X-Gm-Message-State: ACrzQf0B/QdjymGs+UwCVpG9t2q2lrFuEkXo/Ra3R1StDtgSdGrXyf18
        tbEt6W25oiQwxVbckk69RbbgXA==
X-Google-Smtp-Source: AMsMyM46DctUPTlq79VXfxk3/AsSMF5v31CBZUrvgexb04EO4OUvQOlgVyGTdd8OpQce07GxFWGIdg==
X-Received: by 2002:a17:902:9049:b0:180:7922:ce36 with SMTP id w9-20020a170902904900b001807922ce36mr64787021plz.30.1668038763826;
        Wed, 09 Nov 2022 16:06:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709027e8e00b001745662d568sm9608078pla.278.2022.11.09.16.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 16:06:03 -0800 (PST)
Date:   Wed, 9 Nov 2022 16:06:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/7] wifi: orinoco: Avoid clashing function prototypes
Message-ID: <202211091606.46B5DF22D7@keescook>
References: <cover.1667934775.git.gustavoars@kernel.org>
 <e564003608a1f2ad86283370ef816805c92b30f6.1667934775.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e564003608a1f2ad86283370ef816805c92b30f6.1667934775.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 02:21:24PM -0600, Gustavo A. R. Silva wrote:
> When built with Control Flow Integrity, function prototypes between
> caller and function declaration must match. These mismatches are visible
> at compile time with the new -Wcast-function-type-strict in Clang[1].
> 
> Fix a total of 43 warnings like these:
> 
> drivers/net/wireless/intersil/orinoco/wext.c:1379:27: warning: cast from 'int (*)(struct net_device *, struct iw_request_info *, struct iw_param *, char *)' to 'iw_handler' (aka 'int (*)(struct net_device *, struct iw_request_info *, union iwreq_data *, char *)') converts to incompatible function type [-Wcast-function-type-strict]
>         IW_HANDLER(SIOCGIWPOWER,        (iw_handler)orinoco_ioctl_getpower),
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The orinoco Wireless Extension handler callbacks (iw_handler) use a
> union for the data argument. Actually use the union and perform explicit
> member selection in the function body instead of having a function
> prototype mismatch. No significant binary differences were seen
> before/after changes.
> 
> These changes were made partly manually and partly with the help of
> Coccinelle.
> 
> Link: https://github.com/KSPP/linux/issues/234
> Link: https://reviews.llvm.org/D134831 [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
