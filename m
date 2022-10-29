Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC3611EC2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 02:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJ2Ann (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 20:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2Anl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 20:43:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C837180AF9;
        Fri, 28 Oct 2022 17:43:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d24so6220636pls.4;
        Fri, 28 Oct 2022 17:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=emP2KuZFwj43eFZPPui8vytef4MIQe1Qy4avTg2orQg=;
        b=jL/I05N9IZ4Mufeh10+xFyT6RfOPoytViWgMLC/woi3Ch5bYYBbbIoVsLZxPpuGB6E
         oFkR0UqOo/t/UlSzX0qxVeFbL0XVkLxVh/NF4PFn/FgdsjBPZlyXpBZPHydb0aQMDJn0
         mGzuhrtOcScBvmPjkcGPwdcLpDMdgV8p5LhkqR2rJN9JMtW00AaxJx4KClQPw3sCbuRS
         WXs+tu1qUcRh4vGXiknLEg0uC3RpQf15HGFlnhSAcKTz/Ub3eI+uzYjrnZNEdjy7C680
         PK5oJtjkRpYdWG6bHVLeDrEID/9fH8UG7smKr16CJb08jP9kII/Tdn0vUqDZLQZoEE2c
         V0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emP2KuZFwj43eFZPPui8vytef4MIQe1Qy4avTg2orQg=;
        b=Tn80kVz+ahLxt7pLmZtbz+2u1rEGf14cUn5S9O4s0DjQxMu38oq39TlWZq+BXPKIn9
         e08CAZbexzHfAiv8tgnrSzL63rIirkyZiFzEyboGJoUgy5Nvj8afNJfEMjUUHFyTisJf
         r4GIJDfbYNLy+Xb7BmdWplZ54/2zw3QCFxDBz32ltZi1OLuTYrdzwDsm0MzCBED5ANed
         XHixBhEDXyp4q10U9c49slpgFVALNaMBxQSqlX54hqJnpJYFgwJfCrVCx+DEsYDrTtsO
         s+5x3K8YDhptdJrfOumZ2BjzrNpVQiEdwI5W20bW8Lu2p/9bdCaBkWGYkUesf+0cu0h8
         Islg==
X-Gm-Message-State: ACrzQf24Ak9mM+3lf3LyLZcvWreFJ0zvwe0cSkz91NWf1pQkniqzloVq
        bRZpmvdIQ4m40yUG5Xt7TYkRxlGJzXEhGcHT
X-Google-Smtp-Source: AMsMyM64/WABEHWKiRZHSiSa7EhGnCTWdeRCZzpmdY8svnnd1cYqe59ICTB7Kf3PEvSIaWXs/GTFkg==
X-Received: by 2002:a17:902:f791:b0:17c:c1dd:a3b5 with SMTP id q17-20020a170902f79100b0017cc1dda3b5mr1751822pln.141.1667004219965;
        Fri, 28 Oct 2022 17:43:39 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902900200b0017f9db0236asm62880plp.82.2022.10.28.17.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 17:43:39 -0700 (PDT)
Date:   Sat, 29 Oct 2022 13:43:30 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Grigory Vasilyev <h0tc0d3@gmail.com>,
        Claudio Suarez <cssk@net-c.es>,
        Slark Xiao <slark_xiao@163.com>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [next] drm/amdgpu: Replace one-element array with
 flexible-array member
Message-ID: <Y1x3MtRJ8ckXxlJn@mail.google.com>
References: <Y1tkWdwPUp+UdpM0@mail.google.com>
 <04e37ee1-53b0-97ab-d6d7-a39edfbdc2ea@amd.com>
 <202210280855.9DF8E4D72@keescook>
 <1052fba8-11ac-cec8-92e7-b994266c6970@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1052fba8-11ac-cec8-92e7-b994266c6970@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 07:33:17PM +0200, Christian König wrote:
> Am 28.10.22 um 18:36 schrieb Kees Cook:
> 
> > All that said, converting away from them can be tricky, and I think such
> > conversions need to explicitly show how they were checked for binary
> > differences[2].
> 
> Oh, that's a great idea! Yes, if this can be guaranteed then the change is
> obviously perfectly ok.
> 
> > 
> > Paulo, can you please check for deltas and report your findings in the
> > commit log? Note that add struct_size() use in the same patch may result
> > in binary differences, so for more complex cases, you may want to split
> > the 1-element conversion from the struct_size() conversions.
> > 
> > -Kees

Noted. I will reporting my findings on commit logs from now onwards. 

Given that I split the if-ternary to avoid checking "fake_edid_record->ucFakeEDIDLength"
twice then (for the current patch), yes, there will be changes to *.o|ko files.

Knowing that Christian would feel more confident with no binary changes
at this point, I will send a different patch aiming solely on the
replacement of 1-elem array without incurring binary changes.

--
Paulo A.

