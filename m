Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1A772E7AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbjFMP4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjFMP4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:56:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70B61AD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:56:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-65292f79456so4337636b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686671808; x=1689263808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lm83ENN7P26mz8SroVi/kReZQaeZTD5r+fv7IA/VbbU=;
        b=OcI6+OEjvGF5Vg7TnVZ1fPbCaBV3YkbNc1/qzP/41NzjDStS0TLzUooa+3bzeuYU+M
         uhxFMZHirWOIT+oJEsZEsY1V5saMy8ZS0pejxV4SbXGQuWqw9lGt0EwMrswDlL78TLTZ
         ZEXHFvMgE2TEYB9Q7niWu2bACmA4oGClN9c1Xxjgo2W4kwl73/sKN7EfSsA+dYnxYV+/
         F9sRGgZEAL08qO99IdgsYmR2eWDhO1IfrHxgd7XCYSdwuclhx4D70JSOyt6iiJY06fsA
         96Uhpt3b11q5A95sep70SXE3p7NxQIm1Nse7Z6kVC1XMRHx9HNO72eiQqnHy1GRK5jk/
         O7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686671808; x=1689263808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm83ENN7P26mz8SroVi/kReZQaeZTD5r+fv7IA/VbbU=;
        b=M+cWdv2pbZ9Rz7n8drBjlxlrewrQZOkDkTXovZUZi3Jmgi5o0NHNk8ea1Y0Z3ZHxrY
         K5gwGhYoqreVErPbrsXL5fOwOWpxEDRmxK8dLJnN57agbR95PKs1LTbyb1h8hkINc1Kd
         0+S8SPB1kk+JQh6OsibV1dFTpd3Md9Lk6IbdDgMYaUjqJM/SRFsavFOs5ZuALgCwSuil
         SEW4SK1YTcuEgnucmWtbLHQOE4DDwPE5JPpK0OSIqqBc6qd373w5IJqOT6IJM2zhpeLO
         EJd9O+zhjmssugFmtA9ZhUTI4jH85NtlpLZC0zITCFJCQvvZPYBWlhT2oZAUC1ae/+yS
         RNsQ==
X-Gm-Message-State: AC+VfDzN38TcYPI92bHyPydMSPCwj0afbNswbJHpJcTOibdyoBren/sD
        FzB6GaldcyVI+mYEBb9MCUc=
X-Google-Smtp-Source: ACHHUZ4Jrl5CU4kc2B5lBFHU2ztnTPo2MjVbPd481iEIl7vEUTFWpS5CwLQ7HIkBZPyb8EBuEc0AJQ==
X-Received: by 2002:a05:6a00:2195:b0:65c:9e3e:889b with SMTP id h21-20020a056a00219500b0065c9e3e889bmr13293515pfi.6.1686671808312;
        Tue, 13 Jun 2023 08:56:48 -0700 (PDT)
Received: from redkillpc ([49.207.203.99])
        by smtp.gmail.com with ESMTPSA id e21-20020a62aa15000000b0065014c15a57sm8863891pff.35.2023.06.13.08.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:56:47 -0700 (PDT)
Date:   Tue, 13 Jun 2023 21:26:41 +0530
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org, error27@gmail.com, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev
Subject: Re: [PATCH v4 3/3] axis-fifo: cleanup space issues with fops struct
Message-ID: <ZIiRueq6pSOC27PN@redkillpc>
References: <ZHHE/H2p4Go/Igc/@redkillpc>
 <20230527115101.47569-1-prathubaronia2011@gmail.com>
 <20230527115101.47569-3-prathubaronia2011@gmail.com>
 <20230527223111.jidik3ffcsxdkenb@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230527223111.jidik3ffcsxdkenb@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 12:31:11AM +0200, Uwe Kleine-König wrote:
> Note this is only subjectively better. IMHO with just a single space
> this is perfectly readable. Aligning the = might look nice, but it's
> also annoying at times. When you add another member (e.g.
> .iterate_shared) you either add a line that doesn't match all others, or
> you have to touch all other lines of that struct which (objectively?)
> hurts readability of that patch. Also for generated patches this kind of
> alignment yields extra work. (See for example
> https://lore.kernel.org/lkml/20230525205840.734432-1-u.kleine-koenig@pengutronix.de/
> which required semi-manual fixup to keep the alignment after coccinelle
> generated the patch.)
> 
Agreed, that this would create more troubles than benefits.

> If you still think this is a good idea, I'd ask you to stick to one
> style for the whole file. e.g. axis_fifo_driver uses inconsistent
> and different indention.
> 
> A thing that IMHO is more useful to change here, is the name fops; I'd
> suggest something like axis_fifo_fops (and also use prefixes for some
> other symbols like "get_dts_property"). In 6.4-rc1 my ctags file knows
> about 64 different places that define something called "fops".
> 
Agreed. Upon further walkthrough I think this driver requires a lot of cleanup
so I will leave that cleanup for another dedicated patch series for now.

Prathu
