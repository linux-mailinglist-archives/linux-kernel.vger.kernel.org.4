Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543A3615831
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiKBCq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiKBCqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:46:55 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBEF2127C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:46:53 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b185so15196437pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 19:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hoE+WEBAOsuiYt/PTXWjfiF1Vpl25jsrqLqs6qRhex4=;
        b=FFz8PZLezwTcUHm1/JjLbEJ2PnfcBuk9zIDzB0YVBEnTAhRk42awxAgarOcOOMh8aT
         9pp+ZPj0CfYtKB0vvrmRZr4SA77gpLecOAwApmOxVtHaTl5gG1VLj1D4vAMOnpfpzeLH
         Amx9nyUwx29SFBuhD7JySgA1xbA2inbMEm+DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoE+WEBAOsuiYt/PTXWjfiF1Vpl25jsrqLqs6qRhex4=;
        b=61Bdzq8lFZrtDdyix2HAhxIUNNwl3bcj5k5lPwP+8B43gB8GShamXM6FDwfwEIbKKm
         HNWyK8TT7rP2U2OIQWI+LuyaTNLGhd2gqK3h/WmXhWrvAALGGj7zciOHU4mb828+v1k1
         Egito7POBpluR5BIPwgBCVAke4Lep5+C6guNzZDu8Lddfg6RFU/XHkyqkdWIYkUbFVRy
         CL/AX9SBs2pkQ4CGOr11J9bXMkoZYjNqeT/bkF7FS/2VXZjYBeTX4UEpr/v72i5Hj5dJ
         u41s2sG2GnMdOgjhI6jnQ+D1JyhETRr7Fi7fiv3T3vVnTbrObmo3ux1ykhU3XM/Ahngz
         l84w==
X-Gm-Message-State: ACrzQf2/cwKKJzk16k7AEM+Hd15RO8EVZ+/fYgn6JWn+eo/naCeIXQg4
        0AjFHhzkjBuu8nXlZoCrNItzZA==
X-Google-Smtp-Source: AMsMyM5Vh5Z0D0PjNfR9wH0EUw0jjOjW4Cn4P6WLzHpTK2ejg+loeg3CeqSftHPu8g1fvEGeQu9vPQ==
X-Received: by 2002:a65:6d8a:0:b0:43c:9fcc:cb24 with SMTP id bc10-20020a656d8a000000b0043c9fcccb24mr19911349pgb.477.1667357212734;
        Tue, 01 Nov 2022 19:46:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jd21-20020a170903261500b001714e7608fdsm7000949plb.256.2022.11.01.19.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 19:46:52 -0700 (PDT)
Date:   Tue, 1 Nov 2022 19:46:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tty: Allow TIOCSTI to be disabled
Message-ID: <202211011946.F7B4C690@keescook>
References: <20221022182828.give.717-kees@kernel.org>
 <202211011915.02EDB6377@keescook>
 <Y2HWJUuir8E33GkP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2HWJUuir8E33GkP@kroah.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 03:29:57AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 01, 2022 at 07:15:43PM -0700, Kees Cook wrote:
> > On Sat, Oct 22, 2022 at 11:29:47AM -0700, Kees Cook wrote:
> > > This is so very long over-due. We just need to do this and put an end
> > > to this legacy operation.
> > 
> > thread ping. Should I carry this in my hardening tree instead?
> 
> I can take it in my tree, I have a bunch of tty/serial patches to go
> through this week, give me a few more days please.

Sounds good; thanks for the update!

-- 
Kees Cook
