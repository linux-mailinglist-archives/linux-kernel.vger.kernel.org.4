Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C92655202
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbiLWPZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbiLWPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:25:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF3FBC04;
        Fri, 23 Dec 2022 07:25:23 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id co23so4875047wrb.4;
        Fri, 23 Dec 2022 07:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I02zLCc3L9Vr4Pgf+3/wKwOrK6n4hccBX4ktlYit2UY=;
        b=c4m4X9M/xPPNj/v8+Kkf5y5+5BSX4GZSZ2151sK2+8N+AEWubxmGRYPTrRLPrHKElv
         e3720UnRSAhwxH7PGsgPDAqmEm+A8uZcvWt19GfXhy0ZCjkZyG5V834cyKAL/EyMSiwn
         FRShKo9mDwO2MF/lxe6pUFP8z8QpE5mZfjXidStD8FXbA//Wsm9XHewUxgfOFso9EJ01
         7o7LXeAuxs5ClqlWHoKIEKEDgAMf/QZekAHdn0vh4XMjbY0+LKrpDBq/FqZbH45YCTZd
         /N4X9FuPGcF6vKF+tWQ5xCsy5RrVKS7S72SrHz0f07vUuWTe9uOZMcisYIX4w2vgTylq
         V7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I02zLCc3L9Vr4Pgf+3/wKwOrK6n4hccBX4ktlYit2UY=;
        b=BMoM0cSKvgMAZZGiqo8r35yCi1PkRY2ExncNPmIsjetQ7HM4EwRhSIXZfm3cveVqHk
         0ZIFxJVZVwjk60wqDyG0+1E4ga1By65loqQu5vddRINRBtLC3IGJ2Hh17rTvVJwI1VkD
         HORwwSF93D/J0kCSgDd7voK08X5PlJHQv3TUFFALNjUXXIRIn7PT8aHAiHCmz2OTvMHS
         JVsOHEmC9nohVvRjwAdlW6CDsN52YVYN2t38JnKO0qvpk4ZXPy4tzgZKit7FjLzDmSc2
         7XmrU3ghlgYAtp/I+mFxBQzuY1RI305Bzl+sumFEHBuNf9beL/q+k1VStzGJ1OcyXWAe
         RjFQ==
X-Gm-Message-State: AFqh2kqxS8sgiY7s2/ImASIfvzBBknaquNaIerBrz6n8hbmVSuLWQl5C
        AgGrQBfnALR4Nly5BrUwC14=
X-Google-Smtp-Source: AMrXdXtuhXBuZ5KqjB11un5Uda/BfZM3z+g/fpqt+KxkiSy1KgNZR1aeMy4s9hQ0phETTkGG2JhVBQ==
X-Received: by 2002:adf:f04d:0:b0:268:2ab2:baa4 with SMTP id t13-20020adff04d000000b002682ab2baa4mr6416249wro.54.1671809122439;
        Fri, 23 Dec 2022 07:25:22 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d558d000000b00241e5b917d0sm4013973wrv.36.2022.12.23.07.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 07:25:21 -0800 (PST)
Date:   Fri, 23 Dec 2022 18:25:18 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 5/7] vc04_services: vchiq_arm: Drop VCHIQ_RETRY usage
 on disconnect
Message-ID: <Y6XIXuccQD1RuBty@kadam>
References: <20221219115725.11992-1-umang.jain@ideasonboard.com>
 <20221219115725.11992-6-umang.jain@ideasonboard.com>
 <8fcbdf54-98ae-6a06-ecaf-591a43b863a1@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fcbdf54-98ae-6a06-ecaf-591a43b863a1@i2se.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 12:07:56PM +0100, Stefan Wahren wrote:
> Hi Umang,
> 
> Am 19.12.22 um 12:57 schrieb Umang Jain:
> > Drop the usage of VCHIQ_RETRY when the vchiq has connection status
> > VCHIQ_CONNSTATE_DISCONNECTED. Disconnected status will not be valid to
> > carry on a retry, replace the VCHIQ_RETRY with -ENOTCONN.
> > 
> > This patch removes the usage of vCHIQ_RETRY completely and act as
> > intermediatory to address the TODO item:
> > 	* Get rid of custom function return values
> > for vc04_services/interface.
> > 
> > Fixes: 71bad7f08641 ("staging: add bcm2708 vchiq driver")
> please drop this fixes tag since this commit doesn't fix a real issue and
> also shouldn't be applied to stable.

I asked Umang to add the Fixes tag based on the patch description and
based on that it seemed like a behavior change just from looking at
the patch.

But actually you are right that the fixes tag is not required.

The vchiq_send_remote_use() function is never called (dead code).  The
vchiq_send_remote_use_active() function now returns a mix of custom
error codes and negative error codes.  (Ugly).  The caller only tests
for VCHIQ_SUCCESS so this code does not change behavior.  I really feel
like the commit description needs to be clearer on this.

The fixes tag is not really about stable.  Stable uses the tag, but the
fixes tag is appropriate whenever there is a bug fix.

regards,
dan carpenter

