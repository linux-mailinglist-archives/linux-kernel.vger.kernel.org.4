Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E1B660F8C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjAGOnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAGOnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:43:14 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D62574F0
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 06:43:13 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so9656456ejc.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 06:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LgTeE/ilKFXjW4rpM0/pwB/gOCs1EJ+FHjaXKd4NQ38=;
        b=KE/rQcdLtQ44b7xN2W6AEUpSpkLL0Z9ZprvxYW8/FDw3xsA7kcwgtsYheilWpAyPAs
         iIbiLdcPNIqbcBCqbeUUcsGVoR0F0GedkHyJAOtFx9MwSB1yAri72jQF99/3ZU2JCrDE
         X/2nZ5UcDT8HaVNRLG7Ldns/PUdV6cjuSD2kFHF3wHLQogZHRzW2J+/dOGbS0pTUscBE
         i76EkIguxJTul6LjcJ57TTzKiSP4vBK/9/G2pBhmMRmNpBdKasXHZlD2KkHGsFvDPmZh
         aeNfVhAs+doLXqbf0K6qkWz3jQwRuTC5Dr/PsDlw0DHUC82zJe+cMb+ypl7LxXkl2eEk
         lFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgTeE/ilKFXjW4rpM0/pwB/gOCs1EJ+FHjaXKd4NQ38=;
        b=DNi0rKAI/5Rvh5hGkogTTGDEmx9yfx0L2bJAeeT2Sli7bGBMNyJ9dEokhqON/qiDJs
         Bw/pkvwVbSHlWXC5W/wHqAW5OMF6Y0LNjZIgBLROAke8JvmFa4SL9v8OIrivCNfqB2T1
         0PHUiCDjI9s+3qxltq7UdnXivAKAbaoqzeBWwkCRyzOVdLU/F5hGj3tVtwypD1ht2wHl
         PlzWr7xYcGak5xdIMRL0d8z2wRCNoFRiydVL6/MlthMLyHDGPpoywZM9kt4BnL8FfIRM
         cko9l6etDjvWCmgNNvpzlS2jFGAH1QTqMYEtiNOm4plFemJK3WknRLzx/jZOpmD4tEQV
         OHoA==
X-Gm-Message-State: AFqh2koUNf6F35sZu4eOH4eMCyK7EqO93zmVGzTaKf9yOXDK9UxkrQnQ
        ajWraZ2DlDlS4csBTP7uqeGJ+9RcNZEW6UdZPtrxRekS
X-Google-Smtp-Source: AMrXdXtlGS/h/hAKOjzFrOA6KACDNtzJaabe/2jpHBvPxZHHBbI6qQafMU2aYnRNbfaMmWSroGrl+Ld4jb7vNoFLtRs=
X-Received: by 2002:a17:907:82af:b0:84d:b4b:d97d with SMTP id
 mr47-20020a17090782af00b0084d0b4bd97dmr724380ejc.481.1673102591858; Sat, 07
 Jan 2023 06:43:11 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2209260132340.29493@angie.orcam.me.uk> <alpine.DEB.2.21.2301060111330.54090@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2301060111330.54090@angie.orcam.me.uk>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 7 Jan 2023 14:42:35 +0000
Message-ID: <CADVatmOArD_fSU4cG__DZ2HUqH9m3hf=+aOoYUqQjY31Sfb9qQ@mail.gmail.com>
Subject: Re: [PATCH][PATCH] parport_pc: Limit the number of PCI BAR pairs to 2
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2023 at 01:12, Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Wed, 16 Nov 2022, Maciej W. Rozycki wrote:
>
> > Decrease the number of PCI BAR pair slots allocated for port subdrivers
> > from 4 to 2 as none wants more than 2 at this time, reducing the memory
> > footprint a little.  No functional change.
>
>  Ping for:
> <https://lore.kernel.org/lkml/alpine.DEB.2.21.2209260132340.29493@angie.orcam.me.uk/>.

Sorry for the delay. Had to dig out my hardwares for the other series.
This and the other series
looks ok. Will test tonight and I will send it to Greg.


-- 
Regards
Sudip
