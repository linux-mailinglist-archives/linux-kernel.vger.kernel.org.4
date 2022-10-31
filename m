Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0C1613C23
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiJaR1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiJaR1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:27:21 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA3313CE9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:27:20 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id p127so13440874oih.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vZb9O7A86rz8+IQHhKdSDQNKGuKZTMRvSTbUELAFyhU=;
        b=h1hB9HuHXRa1HPSi5UWqu66ChcO14JgFV58gQFFQX0uGCmxmBQPIUWjMiptcWUFuAl
         m4VKpOgOt7PR04c0HXt2NPQaFSc8vb/KOgs5L6jVNV0HQtBHQfkPNrUDj90LNB6Mx1ke
         JjxSsHyxDjDrgv9+8dXAnfl/bHO3PAIDOm5AzjSQYgY9XWYJHQAw7XPXRfhs+JL7+YQc
         zzLPNuLLHy0XQfo45m9DNNkWo4OB08AdgHgQYP72jWetkd7XTFreQ4TaIYiP+yV0GEzc
         f2uOf4/BCjwsP6253nVGl8xVK6lujFOkGDS5DLgbFqaTZKpOxqDa8FkLy/57t15ihI+J
         8ogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZb9O7A86rz8+IQHhKdSDQNKGuKZTMRvSTbUELAFyhU=;
        b=H32xvrzvAG3r21XFj/ppC/W5WmHqtDPcSQ70n9GNNcIm3ahwsqwBw90fA3GjZezqEk
         bRcwSwGNv8mxBVYTL1cVg7gRyEmtydWAXWADE+IGvRMI/SAxgIay/3yZX7EB2KPUutI2
         kD6aKVSLd3JziP7e5SyssMtNgCruutOmT1WiY/7bod7orKlEVrXwap4CnNshayt/5vCr
         bwwGoxDNH76bIeXsTj7MfdyLWT2+dkZy1GkQ2oCG6DukdnO3FtIr2v1y+FnkSo3LNP5A
         UqmAq8KnKccQkyK3P35deRvv4th69Tx25MQ+22QNzT/r1cZ469I7yUzwCxZylL+0Arz+
         ZHUw==
X-Gm-Message-State: ACrzQf2vQRBJmYpigliLbePWobc5gtL6Nxl/rzTIsIbno50t+Hk8fbTT
        XRAIcsCPC+aStCiyiWVCf5clw8R399bwwI6OCiA=
X-Google-Smtp-Source: AMsMyM5zaFuIfJ74PrdQV9tjel2ST/eLXwCkMGirZyjbjam9sBQtYl97KJ6IndBO3adBVAnB9Y2sOTOJ3uKG+mI6n+k=
X-Received: by 2002:a05:6808:14d2:b0:354:c733:abd3 with SMTP id
 f18-20020a05680814d200b00354c733abd3mr7361828oiw.96.1667237240077; Mon, 31
 Oct 2022 10:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221031165834.GA10150@duo.ucw.cz> <Y2ABatgNLVAAjpSW@intel.com> <20221031171952.GA10666@duo.ucw.cz>
In-Reply-To: <20221031171952.GA10666@duo.ucw.cz>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 31 Oct 2022 13:27:08 -0400
Message-ID: <CADnq5_PBghDvCe2vbXFusOCCpzS5CgPg_9S3doXN7dkFWeLrFQ@mail.gmail.com>
Subject: Re: 6.1-rc: names of video outputs changed?
To:     Pavel Machek <pavel@ucw.cz>
Cc:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        airlied@redhat.com, dri-devel@lists.freedesktop.org,
        kernel list <linux-kernel@vger.kernel.org>
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

On Mon, Oct 31, 2022 at 1:19 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > I used to be able to do:
> > >
> > > pavel@duo:~$     xrandr --output HDMI1 --mode 1920x1080 --primary
> > > warning: output HDMI1 not found; ignoring
> > > pavel@duo:~$     xrandr --output VGA1 --mode 1280x1024 --below HDMI1
> > > warning: output VGA1 not found; ignoring
> > >
> > > ...but now I have to do:
> > >
> > > pavel@duo:~$     xrandr --output VGA-1 --mode 1280x1024 --below HDMI-1
> > > xrandr: cannot find crtc for output VGA-1
> > > pavel@duo:~$     xrandr --output LVDS-1 --off
> > > pavel@duo:~$     xrandr --output VGA-1 --mode 1280x1024 --below HDMI-1
> > >
> > > Notice the change from HDMI1 to HDMI-1. I believe that's new in 6.1 or
> > > so. Who did it and why? Hardware is thinkpad x220, and this breaks my
> > > scripts :-(.
> >
> > Are you sure you didn't just switch from intel ddx to modesetting ddx?
>
> How do I tell?

Check your xorg log.

Alex


>
> I don't think I did such changes recently. It is Debian 10.13 system
> (rather old) so I don't think it did update for me.
>
> Thanks and best regards,
>                                                                 Pavel
> --
> People of Russia, stop Putin before his war on Ukraine escalates.
