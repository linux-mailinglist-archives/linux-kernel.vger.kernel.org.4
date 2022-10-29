Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBFD61240E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJ2Ozb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJ2OzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:55:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50EB20F7E;
        Sat, 29 Oct 2022 07:55:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k4so596245wri.9;
        Sat, 29 Oct 2022 07:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz5TY/LtkLWNd5ySUogpHG94P5HHBB7Mk5dPpz+NcdA=;
        b=IWk7W49jd16h4QCOdKnC2dqhR81Zwa7m7wflpedDLqja8GppdvSwxvODl0MneU14dn
         93D92I5s08ScbNXyXU9ZXA2HKjlHu4q2vZQ4AcAIX4P2MOEEWjelDNYuHlPfV3OlzKuw
         2fYy9Q48rngw015jWwdTplLkvmsWKu65WF36F74he+vD47Mc+ruD5dWiVuUszIXpVoKC
         UaFOWdU7F34sbPW9syMRddHiDF5VXoZ2RobfmfReufnRYyRc2wiAoYv2IB36k6Ksfmtm
         ySWAK/v3NaN6FaVqYxLMsCW/dYuVKiRcyE+k51xsWVQg/9MJ3nyJZVmh4y7MiAtXSm/X
         GYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz5TY/LtkLWNd5ySUogpHG94P5HHBB7Mk5dPpz+NcdA=;
        b=NYL2wjslOaWof6mH2/eoWOcxf+yDgo/JsIPFCIdGcXuRXdPa4vqB6QT9VDS0CW3An/
         c0e3AlnJDVS4a80EqgkjwWlDukirDejDQVxjRSqEoK2BMgX8G6nc2abptoUrHP1X6DeI
         OEdeL3z9lTcPhxIV+BPiE4b2xkzS4Kc6lx2sklbsTgrRsqVaRStClCZZIuh4zmVWVhje
         gYT5mq0WzKxx2+0lNnuVcZ4BBm/Z+1+vathtoCLs/I24p4m+JfXIfmNLQD6LpX7xkmSl
         gHUlr2DwvK9KnVFNGhZvGOkbbLjWT9gAIizNPJW4HXx+FwUJQVYiDcRyGiezvDAr7+EO
         olqA==
X-Gm-Message-State: ACrzQf3jrA3lbofN1lkXYl/68XmTchyfd4bAnX0HTZQHb9FVrhQ3QjVx
        F3gXmU0tRR/gHrdGcQnActY=
X-Google-Smtp-Source: AMsMyM6Uw3Qv74zlCkQOCLMvFSfGFSH0JnLnK/yjUbnQWdCgHYz3QQtSa8EKFBnqGEHnCHic3EAu3g==
X-Received: by 2002:a5d:61c9:0:b0:236:781a:8d7e with SMTP id q9-20020a5d61c9000000b00236781a8d7emr2572305wrv.576.1667055314058;
        Sat, 29 Oct 2022 07:55:14 -0700 (PDT)
Received: from elementary ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id t12-20020adff60c000000b002366ded5864sm1644157wrp.116.2022.10.29.07.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 07:55:13 -0700 (PDT)
Date:   Sat, 29 Oct 2022 16:55:11 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Mia Kanashi <chad@redpilled.dev>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        pobrn@protonmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Grosse <andig.mail@t-online.de>
Subject: Re: [PATCH v2] HID: uclogic: Add support for XP-PEN Deco LW
Message-ID: <20221029145511.GA7941@elementary>
References: <20221028082348.22386-1-jose.exposito89@gmail.com>
 <ED1CBF63-A70C-44FF-9F0B-80090EB347EA@redpilled.dev>
 <20221029075832.GA8790@elementary>
 <21CA0A00-1B9F-4E97-B942-A3B7CAA2B52E@redpilled.dev>
 <C7FD0EC0-899A-4D29-8363-D2FAD8E89BBD@redpilled.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7FD0EC0-899A-4D29-8363-D2FAD8E89BBD@redpilled.dev>
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, Oct 29, 2022 at 04:55:21PM +0300, Mia Kanashi wrote:
> >>[1] Actually it should be set to discharging until this gets merged:
> >>    https://lore.kernel.org/linux-input/20221028181849.23157-1-jose.exposito89@gmail.com/T/
> >
> >But i also currently applied this ^ patch, i will try testing without it and then report.
> 
> Tested without it, same issue.
> So yeah it seems that hid-input driver can set supply status to discharging before setting a battery capacity? 

Very good catch. I managed to reproduce it using the USB dongle. I
didn't notice it before because I was running upower after connecting
the device, which isn't fast enough. However, using watch as you
suggested makes the issue pretty noticeable.

The problem is that the battery is fetched when the USB dongle is
connected. However, the tablet might not be paired at that point.

To explain it with the actual code:


  if (dev->battery_status != HID_BATTERY_REPORTED &&
      !dev->battery_avoid_query) {
	value = hidinput_query_battery_capacity(dev);
                ^ Here the battery is fetched, but because the tabled
                  is not paired and this function returns garbage
	if (value < 0)
		return value;

	dev->battery_capacity = value;
	dev->battery_status = HID_BATTERY_QUERIED;
                            ^ Now the battery is set as queried
  }

  if (dev->battery_status == HID_BATTERY_UNKNOWN)
	val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
  else
	val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
                    ^ And therefore the battery is reported


Thankfully, there is already a flag (battery_avoid_query) used to solve
the same issue on stylus. The battery percentage is unknown until the
stylus is in proximity.

So I guess I could use the same flag to avoid this problem.

I'll add a fix in a second revision of this patch.

Thanks!!
