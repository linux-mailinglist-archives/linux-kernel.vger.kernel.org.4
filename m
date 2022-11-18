Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5135262F008
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiKRIsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241617AbiKRIsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:48:09 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA686EB7F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:47:37 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w14so8193869wru.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8yesRaMT9U9EPQtxhglkNQFwFn6THQr7croFXK/hL0=;
        b=BQCPMqEU+tav4fAKLNTDSFamkeKMJ7PyFG/eqNkTaVocPgGaeu/o81Az+aFS4rY3vQ
         FSBHdHxuoVzNV8GkFNUgw/AR27/L+I4vy3cWFcFJOWSAStt4QKCZYPyZXAJPi1CykqiD
         U59wQtAxRyrvoK5ogzqb6KRiW8Tg9Qn8RocmZa8+qB7rvfsJ1eO8wNjiiPNlJgUcvTt4
         F6sI5myF3P0JhBD/CCq51HPwdfp3T4vqc4s9zl0fs6QFjgeeLQWhwXwyyq6eGU5mMlFM
         89lg8x7T+j2fx2JVpyoXh2jWLvMQk+eEzX6QhIunNZhiM1i24r+U2KLW+T6/RZL31P7g
         a74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8yesRaMT9U9EPQtxhglkNQFwFn6THQr7croFXK/hL0=;
        b=Qy55ykaN9mCZlxq4Qzc5iDpBwLFSgH7N9p/oRC0j6qFgwSwK8plHP4ad50i56JcyHb
         1LqA4ByApr+SlDW5rICbM4F+IPHbgNaIULnJQusmwJgYXpmTT/Yy1G6HqNy2Y9la1TTT
         pyiMhurdU2gWWA0xduG+Tn1v7OZlu+/7WERam8KdHLtaAWiwoXmsbz4NPgkRXJyevHVJ
         qZiT9GJ8FOlPhOERq6tE8dm0Fuc8dGuQQUReyuVD4XoS7uTrhcF5tj6tcctnmKUhUhD/
         InwBf1tsE+Yyqib+/wy1xWnAVUhqbZw8DRk7mxqpXq8cZX7Va1fpynLgYLzEiuWmVf+s
         D5Zg==
X-Gm-Message-State: ANoB5pn5GYkLSt6OXV/GzVO55P+kD4Yw+cb1PnlvNycuOr4UbYmGLqGr
        WOPkGM5iEoZ8EKcssfUHbEM2UFczFBeZ3A==
X-Google-Smtp-Source: AA0mqf52m/asu+x56hmdWbfjzZRDrKndKiYuCi/TRdN/w1uQoxQ6QJzkkUQKyRh1mtaHb/YpPt64AA==
X-Received: by 2002:a5d:4d09:0:b0:235:e330:71ba with SMTP id z9-20020a5d4d09000000b00235e33071bamr3673651wrt.213.1668761255990;
        Fri, 18 Nov 2022 00:47:35 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id fn25-20020a05600c689900b003cf78aafdd7sm3687144wmb.39.2022.11.18.00.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:47:35 -0800 (PST)
Date:   Fri, 18 Nov 2022 11:47:32 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        kieran.bingham@ideasonboard.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Umang Jain <umang.jain@ideasonboard.com>,
        Ray Jui <rjui@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 0/3] vc04_services: Promote bool usage
Message-ID: <Y3dGpMLmXxFicE0e@kadam>
References: <20221117160015.344528-1-umang.jain@ideasonboard.com>
 <dd05ca8a-c60c-a56f-66e6-9892cb933315@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd05ca8a-c60c-a56f-66e6-9892cb933315@i2se.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 07:11:41PM +0100, Stefan Wahren wrote:
> Hi Dave,
> 
> Am 17.11.22 um 17:00 schrieb Umang Jain:
> > In commit 7967656ffbfa ("coding-style: Clarify the expectations around
> > bool") the check to dis-allow bool structure members was removed from
> > checkpatch.pl. It promotes bool structure members to store boolean
> > values. This enhances code readability.
> > 
> > Umang Jain (3):
> >    Revert "staging: mmal-vchiq: Avoid use of bool in structures"
> >    vc04_services: mmal-vchiq: Use bool for vchiq_mmal_component.in_use
> >    vc04_services: bcm2835-camera: Use bool values for
> >      mmal_fmt.remove_padding
> > 
> >   .../bcm2835-camera/bcm2835-camera.c           | 30 +++++++++----------
> >   .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 18 +++++------
> >   .../vc04_services/vchiq-mmal/mmal-vchiq.h     |  6 ++--
> could you please check these changes to be safe? I'm not sure that the
> affected declarations are really internal. I'm afraid this might affect
> firmware or userspace.

The structs have a bunch of kernel pointers in them so hopefully they
are internal.  Otherwise we have a different sort of problem.

regards,
dan carpenter

