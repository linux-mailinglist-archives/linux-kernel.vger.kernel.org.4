Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658BB6032A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiJRSlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiJRSlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:41:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A120B8E0FC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:41:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n12so25019743wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KpfXUFViuIt4e2+RvXXZ8qTb4VtGQNRCWM5xeBYb/mg=;
        b=XFSkDEazc4jnp7BL3qoZcI2oeCIEuoa4F9q0dwcAk0EkB7TdzZ8KJHZuL711m2G9Yb
         YCTj8RNkGuT7NZWf7iOlg0yl4Dz6vy9OPHeqB0Zj9efBRkPqHv5lnkbCDZ8tuM9gNxEt
         V6FC32+C40CsrvnwX0fsTHRNg6Mox3MJkJ3uhtFVK0YEXvsYrQaYMwrns15ltGm4MBZY
         DNgnUJSQYgunZvmeqt6NcTLDo7MWFcSH5+tjAMrSFElMjLxgw0lBiiAMazIlOC/HQlmP
         uIMJCwKKIpdrGW+6X74/iWiAM9aTgmBU4iBo9Q1vD83fmDEeH+ffewXpWwW3GaTYrbqg
         ixmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpfXUFViuIt4e2+RvXXZ8qTb4VtGQNRCWM5xeBYb/mg=;
        b=UGuNKY2UZBR6cL+nLNhAbfHy1IB0WUYA8sQ7rf/dKNuhii2gW01RFKI9A/vf3EJYLj
         Tytiu+ZH7zbnbSOxbRXtpCe4cgmeycU9/Ikh4sLNeAeHPySoAW7r3m0C/q1hXfEhgDn4
         eUEw53Y5vuqolG08CT2QZE4Lv9Iv1WT45CKH/UuiH7uo8tgTS9sXax6mROm0CqTYr1Sb
         yht9/MkcU4qbrMBQdgN7msdJ8B5oq95nQTA2bRXP9+PUoM3TlRfDlOpOcSvEWOTVU1wH
         5DqEsv4O4BJS+AwCLnh5S9NjFIM4pA39ZZQyp3L8pa44PzLfq5XW74s2udQN4SgKFSS2
         q8EQ==
X-Gm-Message-State: ACrzQf0gAW0GulMUHmG7Mx1CtE+C1J+qC3KfBNpHzJ0aV436tl/oAOcV
        W0xxpAddoFxo4KTUIdajsb8=
X-Google-Smtp-Source: AMsMyM4aC6J1wVvxcX3+VIaUwbES7PXfNJd5JezXkYPLaWqKqTmVK/m3Gy3Q0MQS0lbUuzbJvG8T9w==
X-Received: by 2002:adf:f943:0:b0:232:ce6b:40d4 with SMTP id q3-20020adff943000000b00232ce6b40d4mr2938406wrr.453.1666118489078;
        Tue, 18 Oct 2022 11:41:29 -0700 (PDT)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id az25-20020a05600c601900b003b497138093sm14766660wmb.47.2022.10.18.11.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:41:28 -0700 (PDT)
Date:   Tue, 18 Oct 2022 19:41:27 +0100
From:   Qais Yousef <qsyousef@gmail.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, qais.yousef@arm.com
Subject: Re: [PATCH] mailmap: Update email for Qais Yousef
Message-ID: <20221018184127.5xyign4cqr5zwhhb@airbuntu>
References: <20221014141016.539625-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221014141016.539625-1-qyousef@layalina.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 15:10, Qais Yousef wrote:
> Update my email address for old entry and add a new entry for my
> contribution while working with arm to continue support that work.
> 
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---

ACK

>  .mailmap | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 380378e2db36..bd51ecdb4cd1 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -353,7 +353,8 @@ Peter Oruba <peter@oruba.de>
>  Pratyush Anand <pratyush.anand@gmail.com> <pratyush.anand@st.com>
>  Praveen BP <praveenbp@ti.com>
>  Punit Agrawal <punitagrawal@gmail.com> <punit.agrawal@arm.com>
> -Qais Yousef <qsyousef@gmail.com> <qais.yousef@imgtec.com>
> +Qais Yousef <qyousef@layalina.io> <qais.yousef@imgtec.com>
> +Qais Yousef <qyousef@layalina.io> <qais.yousef@arm.com>
>  Quentin Monnet <quentin@isovalent.com> <quentin.monnet@netronome.com>
>  Quentin Perret <qperret@qperret.net> <quentin.perret@arm.com>
>  Rafael J. Wysocki <rjw@rjwysocki.net> <rjw@sisk.pl>
> -- 
> 2.25.1
> 
