Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5597A738EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjFUSgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFUSgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:36:10 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F22D1A3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:36:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b505665e2fso49595305ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687372568; x=1689964568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv4JB0gu1t46wWDKme5hHKYn4mQ7fMkSefR1sSHYzzk=;
        b=fkAW0goZqDfFKzRrsSAey60tXh4zE3Pc14WQuukj6IXTzjSF1fd8mUFdYeNU9hraZM
         FXEQQWuMHkrnDFa5I+D5sNl75A11zv0D/WNWWdta/C53Yo5NnrDKFbfH+oeLPJiR4Krv
         NEz45vRYfhmjXGoG44yrpiQ5Kp34wYFsYt5HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687372568; x=1689964568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mv4JB0gu1t46wWDKme5hHKYn4mQ7fMkSefR1sSHYzzk=;
        b=PRuKEZ0gTUMO33eplzAT+RkjKTPr9CwmCIpby84XzjWr9cVCqHzNfZxStUgW2mh5EL
         AQlHJp2fZp9WtBW4aPjP0lKMX/j3aKy58BBFknvPN1JOr78/0lHrZs8hL9nY5FuO2nhP
         fOLgVV342BGKDmkJhPoxP5JcqfnDloizfvMMoW12x+L/o6LRIozMRA2Y3U9Reec/EClP
         PNxZAJpliK02qrNTvP8VZmc3mavylQpI5/zWGZblNXFH15AYix8EqJqXRpPJrPSKfzl7
         fncHcCAiyTKcpJGKV1UpNalvlkST36xCcy6e3rhhVhe4osdNQ8f9hRwB8g/R02jAGXeq
         vLuQ==
X-Gm-Message-State: AC+VfDyXK9q06zMCqOFBxzZxsfSs3UY8js71I/NRN5tZRghLVRBN+/fB
        DX/NAPI1/54btpyzr0a9C9sbzw==
X-Google-Smtp-Source: ACHHUZ6v9phQPqndguNv62PIby34GSSO1dsIssQyRdukILqo90/KIybQ23xd2PomQ8aU5EURTpY5Ng==
X-Received: by 2002:a17:902:f683:b0:1b4:5699:aac1 with SMTP id l3-20020a170902f68300b001b45699aac1mr22886759plg.12.1687372568099;
        Wed, 21 Jun 2023 11:36:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jo17-20020a170903055100b001b539640aa3sm3801612plb.283.2023.06.21.11.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:36:07 -0700 (PDT)
Date:   Wed, 21 Jun 2023 11:36:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Manthey, Norbert" <nmanthey@amazon.de>
Cc:     "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Stieger, Andreas" <astieger@amazon.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: Linux kernel Coverity model file
Message-ID: <202306211134.C301FEB6@keescook>
References: <ccca1437bf0885924619271a3f3ddd17af018149.camel@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccca1437bf0885924619271a3f3ddd17af018149.camel@amazon.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 01:44:01PM +0000, Manthey, Norbert wrote:
> some time ago you pointed me at the github copy of the Coverity model
> that is used for the Linux kernel analysis [1].

Hi!

> I investigated the effect of using this model, and compared defects
> reported with and without the model. Before I deep dive into
> modifications, I wanted to understand whether there is a more recent
> version (the current one is about 4 years old). I currently have no
> access to the public linux dashboard to directly check the effect
> there.
> 
> In case there is a more recent model file, can you please update the
> github repository?

This model file is current -- we haven't changed it in quite some time.

> In case I find additions, is the following a good procedure to share
> model updates? I would run an analysis on a defined Linux commit with
> the current model and the proposed additions, and would report the
> effect on the reported defects. Is there anything else I am missing?

Yes please! Either send a patch to the linux-hardening@vger.kernel.org
mailing list or send a PR to the github repo.

-Kees

> [1] https://github.com/kees/coverity-linux

-- 
Kees Cook
