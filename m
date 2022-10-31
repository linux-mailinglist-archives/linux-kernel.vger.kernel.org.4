Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F202613BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiJaRIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiJaRIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:08:44 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF6B12D08
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:08:41 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-13bd19c3b68so14102746fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C7QyndEJfzTQZtJYUGQNW9nMNPikJDsHRWnpG2pdH0A=;
        b=K6/WUZRjViIDQIAfkzMVEOUsDuPwr0JFtCcs7Ug3FFb9N7TNoka4TcO8no3Lo2ohtf
         XZrQnY3BvV+uUuxjPiOAigJTIn/6lj66lAodSA0TiLC2uYfkA1sC15HQa63t2xOI+62z
         CsMHqDobXYIGzAVqZ/BYOznKbkBGtEqSXPZvzFCYYnaY8d9iEwYv2SRVyUrljvKK/Dlj
         iWfOWpbvTGrQ2fTvqfL1AouIv0qPNtjkNz1lKYn2G1dqeSJVa0inw6UJxu6rHMgukY0B
         azFdAhGzRJ43KS2j6EYeCEhWLdbvNfJnFPpjgPOF7k1dmxzAx0cnzVvXEs6vcBFfXHtN
         FE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7QyndEJfzTQZtJYUGQNW9nMNPikJDsHRWnpG2pdH0A=;
        b=03PDGPD9Vfz8P0k6wXCk2aI3n5ULa3eV6UqcJfYnsxFcukNCj66aT7gGRMcepaNfS5
         L/eUa/q1DVYlySJlzSo516AIy5XSHgTYSc57/GgUhqBF7973ZRFqbancs/nAVBgpw4+r
         cMQj9cYwqPp/JK0TE8kXNm7A+6l4drlZVEeAJUnQO0nOibSZ3r85C9qjpLSqdM9b0nCq
         568axWv01Ds32V5rQ3nuDeWV8yDVZfEEqmIW0R0GPKulj7lUW+kxU3nN9rIarzsC9HDu
         UwJplA91CWxEoUaeQG+3+maUBlsitZqItWAggUyPJwxfLGPz4t31sdTX9fTVg3pTF/Q8
         F0DA==
X-Gm-Message-State: ACrzQf1TubVcb4SzRI7zpHmdX6b7R8ZC02Cq5TAEBXDv4ZeN0lFLq4Fk
        GvLkxxJK9gO4CACtf7xydm+nK0mShEKi6rBZJPvztplY
X-Google-Smtp-Source: AMsMyM5IY5vpz+/q6V8WNAJQ6H0ALrDJzjTwaVsyeomBJ9o8rzHrta9TQuJyRBS0P6+4ovIzDWQrwXwPeNTG6lrOfOs=
X-Received: by 2002:a05:6870:a116:b0:13a:f9de:6fd0 with SMTP id
 m22-20020a056870a11600b0013af9de6fd0mr17947325oae.46.1667236120523; Mon, 31
 Oct 2022 10:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221031165834.GA10150@duo.ucw.cz>
In-Reply-To: <20221031165834.GA10150@duo.ucw.cz>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 31 Oct 2022 13:08:28 -0400
Message-ID: <CADnq5_O0BotfaaMGz1oPiQno=g10DBygB2F6gfOuWd13M0C2LA@mail.gmail.com>
Subject: Re: 6.1-rc: names of video outputs changed?
To:     Pavel Machek <pavel@ucw.cz>
Cc:     airlied@redhat.com, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, kernel list <linux-kernel@vger.kernel.org>
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

Did you change which xorg DDX you are using?  E.g., between
xf86-video-modesetting and a xf86-video-[i915/radeon/amdgpu/etc.]?
They may have different naming conventions.

Alex

On Mon, Oct 31, 2022 at 1:04 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> I used to be able to do:
>
> pavel@duo:~$     xrandr --output HDMI1 --mode 1920x1080 --primary
> warning: output HDMI1 not found; ignoring
> pavel@duo:~$     xrandr --output VGA1 --mode 1280x1024 --below HDMI1
> warning: output VGA1 not found; ignoring
>
> ...but now I have to do:
>
> pavel@duo:~$     xrandr --output VGA-1 --mode 1280x1024 --below HDMI-1
> xrandr: cannot find crtc for output VGA-1
> pavel@duo:~$     xrandr --output LVDS-1 --off
> pavel@duo:~$     xrandr --output VGA-1 --mode 1280x1024 --below HDMI-1
>
> Notice the change from HDMI1 to HDMI-1. I believe that's new in 6.1 or
> so. Who did it and why? Hardware is thinkpad x220, and this breaks my
> scripts :-(.
>
> Best regards,
>                                                                 Pavel
> --
> People of Russia, stop Putin before his war on Ukraine escalates.
