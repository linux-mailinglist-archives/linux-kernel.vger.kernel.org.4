Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927BE659BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 20:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiL3Tn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 14:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiL3Tn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 14:43:26 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C38218397
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 11:43:25 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z12so17838593qtv.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 11:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQ56hL2pZJLjzLwQ/3T/CpWJ1q/WCG6zfqoO1PWUhok=;
        b=HXW5xZVrFNQn6IFmuRqi6c/kp3HPyFLuASeWLDiU8QYfKNe0PB/mjBPGkAHL/te/tV
         bBWgSkWD9gmsNaa+zkwE/9QtOh+a5Adpf/6Luy0rf53L4bYU/Rmc1pL8SmutXRZ00uKV
         Tzvsny/YYQUQxCkUPSmamin7F9umRRs1DgMCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQ56hL2pZJLjzLwQ/3T/CpWJ1q/WCG6zfqoO1PWUhok=;
        b=b/tQG6gNibZYKIAuRzJ2+HuCJcYSs6F3UD4DCozfm37ZUoVRVsYBZhX2XgzY2MrNd0
         nJQeRbyZ54p6w+dViJlopX+OtxbImAcSkHbzWIdElVpabEug9/lyHPYdILNhUZFa2nPc
         yZKySGDkYqnTn0OHL5ZtwMxu88J9Gd5ezSjmrmjKB3pLYARSsxp35H0hKwihJKKiLHGn
         XV0zDuBjkl1loxO+VR7GpWYORSfT4h7UK9G0MtCIGhfBnqbGNx8XEobiDbeWz7utkCLu
         5tgFRnwhz7qkncsMpn4sI3LAy0rN96x98VdWBFK+nSg/m+mRkBrfRsDV+Ibs0vn+o6fg
         Tp3g==
X-Gm-Message-State: AFqh2kpZgkNyGDchYy2DRZ4GnTr6zZE/opmJ2p7PG+RQlPpZFB3Lw+c5
        tI6LsL/qGzt1Xh2zVwKq/cR3R3UJ83HGhk3f
X-Google-Smtp-Source: AMrXdXsTGc0WfJQMaRCIykxiekLmWiY+P1A+X9GhjScPIhmDzH8z/Ze9m4Y3IaGbaR/M2jnTnXMS4w==
X-Received: by 2002:ac8:4f17:0:b0:3a6:95ff:ffd4 with SMTP id b23-20020ac84f17000000b003a695ffffd4mr44080186qte.52.1672429404740;
        Fri, 30 Dec 2022 11:43:24 -0800 (PST)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id bl41-20020a05620a1aa900b00702d1c6e7bbsm15500477qkb.130.2022.12.30.11.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 11:43:24 -0800 (PST)
Date:   Fri, 30 Dec 2022 14:43:22 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     corbet@lwn.net, Conor Dooley <conor.dooley@microchip.com>,
        broonie@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Documentation: process: Document suitability of
 Proton Mail for kernel development
Message-ID: <20221230194322.gonid4ld27jwjfw4@nitro.local>
References: <20221228000330.3971104-1-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221228000330.3971104-1-conor@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 12:03:31AM +0000, Conor Dooley wrote:
> +This affects mail sent from their web GUI, from other mail clients using their
> +mail "bridge", as well as patches sent using ``git send-email``.

I suggest a minor tweak to wording here:

    The automatic encryption feature is also enabled for mail sent via the
    Proton Mail Bridge, so this affects all outgoing messages, including
    patches sent with ``git send-email``.

> +Unless a way to disable this "feature" is introduced, Proton Mail is unsuited
> +to kernel development.

Reviewed-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

Thanks!

-K
