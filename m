Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E175E62FB8F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241968AbiKRR0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbiKRR0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:26:09 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077829150C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:26:09 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ud5so14695389ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NV08U6xHPyg0UaSVwP6PfcZOSsUP/5GZvrfcRdYDLS0=;
        b=lBa8PRc7BGxEmXsVGVuHecMAlZ41oysW90dh3ZlB7//RXOu2DJs4spnom3Xm3vTprH
         bYzodfr5s3w/II3G1U+jgtsT9sijkICX0s8eRo7+PUzUUMdC52ZhqGW3AiqLGpLwal/l
         DVyEiHmt4YVmhV3FGR0RtDgyHlUDCMVLnNZO0Db61ToiIhnnncZv1YizGPRs3OUjOP/D
         Sc+0zuRhA8ODeCMcN8IMEw+y3E6railg7P6pOLsLBcAJsAFGxtgPsmtOlVablo09Vc5G
         psBaR7DdyISjAXlScHRJsu321ygf7zPq3n3VI7Xmls0Wq0xylE3y0RlwLW3qmrl9QHX5
         Q+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NV08U6xHPyg0UaSVwP6PfcZOSsUP/5GZvrfcRdYDLS0=;
        b=5DNUE22AUGTB+0BJOzIcbV2PzYxqsSwj/r0wRb6+3qbClmDCyK2eAvsIpqZNrWsWlK
         TeBq4hPvkWrJRN9ICOXcRT9PMYRayljcpR76/KIuxL7/fxOO3x5CTdJffo0Tkw1DGUuF
         SmpG44VSW84t5SAL/C9LRNjwJoHEyIeNv+VCG0tJuP/60/zsHEZD51Lt/x2gLPhEDOev
         rRfymS0tdYq8kGhdnk4ErrrHWUvb8iNa3wlHgEcJ5A0q3UegDZjqbGtQsRCtftElH5ud
         fiorl0SjEfM0aB/lHjTHXT79eLyPPNSa68cAszMizLSi5aWQXhfAGreTbBW+9DP2dhVV
         NYPA==
X-Gm-Message-State: ANoB5pmlV1Lb1K9K/eeomzXvmc0AgO+uZhqZxGQymMUJgT+B3bDVbf3n
        UrSzxMVDy0e2uFhLPz2JRrYfsi1zw67d9Vwu9QWHgw==
X-Google-Smtp-Source: AA0mqf5aD7hFWVL+UyV9oM42wn1EyVwXowkgyqanrBYNAi9JFhTpJCrA59g3ARNLkMBmxP9WaaQK+1JuwEpkydtHdZ4=
X-Received: by 2002:a17:907:378:b0:7ad:db82:d071 with SMTP id
 rs24-20020a170907037800b007addb82d071mr7124611ejb.200.1668792367597; Fri, 18
 Nov 2022 09:26:07 -0800 (PST)
MIME-Version: 1.0
References: <20221117160015.344528-1-umang.jain@ideasonboard.com> <dd05ca8a-c60c-a56f-66e6-9892cb933315@i2se.com>
In-Reply-To: <dd05ca8a-c60c-a56f-66e6-9892cb933315@i2se.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 18 Nov 2022 17:25:52 +0000
Message-ID: <CAPY8ntBDkme2nuYMAsMtkycbjnQ8CR2CU70EWPiS_R4KyoQySw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vc04_services: Promote bool usage
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     kieran.bingham@ideasonboard.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Umang Jain <umang.jain@ideasonboard.com>,
        Ray Jui <rjui@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dan Carpenter <error27@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan

On Thu, 17 Nov 2022 at 18:11, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
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

No problem. These are totally safe.
As I've commented on the v2 patch, if it were in the mmal-msg*.h files
then I'd be more concerned as those are matching the firmware
structures, but these are just internal state.

  Dave

> >   3 files changed, 27 insertions(+), 27 deletions(-)
> >
