Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1C85EB41C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiIZWDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiIZWDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:03:22 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965C2F08BE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:02:51 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c198so7992234pfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=sY+KsQGJ1iMXAjOjVw1pliiFAMGcOcRpi6gEhOuADKk=;
        b=DO+VvjxJxYw+J2pvHRWSwWtB1yBY2Mmdi1qVoCpjU4583uJZ7ddrLTRMgrBgU5Kr4r
         hfyWz3zOBUs90gcBvcxgh9LQ1gMevCr740eCA6IikFBANPzNIAVjBSrxn5fO1FiaoEF+
         y6iwW1C25zRJpkYlRZY9DTiKVJJD3b2ICIxBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sY+KsQGJ1iMXAjOjVw1pliiFAMGcOcRpi6gEhOuADKk=;
        b=Ig+sXPw+PV27GU1Re5cuZtdYza0pdXEJm/1ha+vMpqWsVznmN6mxkGFtnSZEWLqGuJ
         FlxMtHSqLBx63FXN/xxv2at4dn2c6cig54iKuPS4ZM6JtFOKyDujnD+lUkt9s6/07oI/
         T6xXEGmlk9HZqEp59RzKsjsYEDoSJTSpGjP0YfKIhN4Vdqu8FMl66HDczWbZB/uZ3Ysj
         4h637kYPl1Ysxvtjiq+IpquoA8SvxkqVoHvH3UGFGRziRcdcjxlAu9aHGtJrd2jIGge2
         jJylfE/d1EoGzua1lgL7a49xRG7RADZM/T/7jxpp+Q5e1csjw+/T8mMz3JGNb1fMj6ld
         V+jQ==
X-Gm-Message-State: ACrzQf0KnAGvFwvic2NILXyCqyPxlwLU7pxA/oyRLPwED5SFWiodggeh
        0pw1+yL/d26h+aVJDrAdqI3acA==
X-Google-Smtp-Source: AMsMyM6KHWqc+jVfmWDxBXoMckoP74sAo+zxlN+Yx4P2g4UXs1rLUlsR6nrQowXKd+PlonUaXo8PnA==
X-Received: by 2002:a63:3e4a:0:b0:439:246d:e681 with SMTP id l71-20020a633e4a000000b00439246de681mr15812528pga.424.1664229770209;
        Mon, 26 Sep 2022 15:02:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j34-20020a635962000000b00439baadf1dbsm11144144pgm.41.2022.09.26.15.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:02:49 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:02:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>,
        Sean Tranchetti <quic_stranche@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: ethernet: rmnet: Replace zero-length array
 with DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261502.7DB9C7119@keescook>
References: <YzIei3tLO1IWtMjs@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIei3tLO1IWtMjs@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 04:50:03PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/221
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
