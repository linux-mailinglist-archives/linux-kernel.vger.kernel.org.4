Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF578614154
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJaXH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiJaXHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:07:53 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2415013F20;
        Mon, 31 Oct 2022 16:07:52 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-13ba9a4430cso15091286fac.11;
        Mon, 31 Oct 2022 16:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIKNfIS9DJZ+OreDnkhjQEbBfQ5lKHnR+23wu5eNP+4=;
        b=CFRw2KUOfNI618M5wfGr3VzUsoE6+rWut09ICvW0xZsQBJAlb5iRyuOIVZyW+cxhPN
         FiLdQd+HvwAGMBpFpKXdwkY3UgbdJU8qQlttbtfn0+pDpMzG4GHywbVRKilsOiPyrXxn
         jcjICLAvDvkydW2h6PGFJWcSFhkyv2KSUz/YaFzZlaNzZFV56/mIRyP7ZTnwk64y4n9q
         Lv/zcPwIMiaDw5ylE2aXisFQ4lVq5UAkb7fCyQ0f6vcACiTcAaNvyZCiGr2a/snQEkUu
         PHpymBsb+z8NIseqAyoBNWRvJ+pKanJFHgU007rivRmdTB0G5MNZ1TIjvu+SQCf5/HGt
         az/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIKNfIS9DJZ+OreDnkhjQEbBfQ5lKHnR+23wu5eNP+4=;
        b=t+qEwnuRrhoym90w4n/gcE5eRuGc8zcLNze4nyfJkLZiYF6Qfsd9sF8kI+oM6ZJBhl
         12XMqIIS7x+c0lIzyAERBCiMp3lnVQ8WosGHDq459ztqczKyBgmvqj4mek6bf9g6RtJc
         luhwrbomJRMAIjn6gXTdZQVmQC+afpSEl8TFTTrE4ROZ/8+wFNAIgm6FdyNuwq5AVCVW
         bgoiqPfY2CvhdFTzBk3yUUT47EFZdoQ5nmIwssuc9PQqVosgohQE40JZLVZlkGd0e/Tg
         57LGn0B9hB94HtImH/LjrrAnDS/IbMsIGwtVuZUxBrsgFuUHMIqNbIWHvBbxXMKRbyJs
         J97w==
X-Gm-Message-State: ACrzQf1XHRYRlm/9U6h27NpCGzUpjZspJ8/3VQ5J4DdfY8l/e8QApfE6
        L0clN/PjizgiJRvesJXS4Ec=
X-Google-Smtp-Source: AMsMyM4jMrEtQxRZyChRGb9EEzYfviGe38pgCfAYpjEgP7S2SnvOLdFtOazIJKW1VuMSGW3gIp9RUQ==
X-Received: by 2002:a05:6870:5894:b0:131:b25b:413e with SMTP id be20-20020a056870589400b00131b25b413emr18653062oab.192.1667257671404;
        Mon, 31 Oct 2022 16:07:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a13-20020a4ad5cd000000b0049427725e62sm2844817oot.19.2022.10.31.16.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:07:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 31 Oct 2022 16:07:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>, linux-rtc@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] rtc: cros-ec: Limit RTC alarm range if needed
Message-ID: <20221031230749.GB2082109@roeck-us.net>
References: <20221029005400.2712577-1-linux@roeck-us.net>
 <Y2ABnbBGSJGM3gSS@mail.local>
 <20221031181913.GA3841664@roeck-us.net>
 <Y2BIv21U7lpN0z23@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2BIv21U7lpN0z23@mail.local>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:14:23PM +0100, Alexandre Belloni wrote:
> On 31/10/2022 11:19:13-0700, Guenter Roeck wrote:
> > On Mon, Oct 31, 2022 at 06:10:53PM +0100, Alexandre Belloni wrote:
> > > Hello,
> > > 
> > > On 28/10/2022 17:54:00-0700, Guenter Roeck wrote:
> > > > RTC chips on some older Chromebooks can only handle alarms less than 24
> > > > hours in the future. Attempts to set an alarm beyond that range fails.
> > > > The most severe impact of this limitation is that suspend requests fail
> > > > if alarmtimer_suspend() tries to set an alarm for more than 24 hours
> > > > in the future.
> > > > 
> > > > Try to set the real-time alarm to just below 24 hours if setting it to
> > > > a larger value fails to work around the problem. While not perfect, it
> > > > is better than just failing the call. A similar workaround is already
> > > > implemented in the rtc-tps6586x driver.
> > > 
> > > I'm not super convinced this is actually better than failing the call
> > > because your are implementing policy in the driver which is bad from a
> > > user point of view. It would be way better to return -ERANGE and let
> > > userspace select a better alarm time.
> > 
> > The failing call is from alarmtimer_suspend() which is called during suspend.
> > It is not from userspace, and userspace has no chance to intervene.
> > 
> > It is also not just one userspace application which could request a large
> > timeout, it is a variety of userspace applications, and not all of them are
> > written by Google. Some are Android applications. I don't see how it would be
> > realistic to expect all such applications to fix their code (if that is even
> > possible - there might be an application which called sleep(100000) or
> > something equivalent, which works just fine as long as the system is not
> > suspended.
> > 
> > > Do you have to know in advance which are the "older" chromebooks that
> > > are affected?
> > 
> > Not sure I understand the question. Technically we know, but the cros_ec
> > rtc driver doesn't know because the EC doesn't have an API to report the
> > maximum timeout to the Linux driver. Even if that existed, it would not
> > help because the rtc API only supports absolute maximum clock values,
> > not clock offsets relative to the current time. So ultimately there is no
> > means for an RTC driver to tell the maximum possible alarm timer offset to 
> > the RTC subsystem, and there is no means for a user such as
> > alarmtimer_suspend() to obtain the maximum time offset. Does that answer
> > your question ?
> 
> Yes, my question was missing a few words, sorry I wanted to know if you
> had *a way* to know.
> 

See below. It is doable, but there is no real good solution, or at least
I don't see one right now.

> > 
> > On a side note, I tried an alternate implementation by adding a retry into
> > alarmtimer_suspend(), where it would request a smaller timeout if the
> > requested timeout failed. I did not pursue/submit this since it seemed
> > hacky. To solve that problem, I'd rather discuss extending the RTC API
> > to provide a maximum offset to its users. Such a solution would probably
> > be desirable, but that it more longer term and would not solve the
> > immediate problem.
> 
> Yes, this is what I was aiming for. This is something that is indeed
> missing in the RTC API and that I already thought about. But indeed, it
> would be great to have a way to set the alarm range separately from the
> time keeping range. This would indeed have to be a range relative to the
> current time.
> 
> alarmtimer_suspend() can then get the allowed alarm range for the RTC,
> and set the alarm to max(alarm range, timer value) and loop until the
> timer has expired. Once we have this API, userspace can do the same.
> 
> I guess that ultimately, this doesn't help your driver unless you are
> wanting to wakeup all the chromebooks at least once a day regardless of
> their EC.

That is a no-go. It would reduce battery lifetime on all Chromebooks,
including those not affected by the problem (that is, almost all of them).

To implement reporting the maximum supported offset, I'd probably either
try to identify affected Chromebooks using devicetree information,
or by sending am alarm request > 24h in the future in the probe function
and setting the maximum offset just below 24h if that request fails.
We'd have to discuss the best approach internally.

Either case, that doesn't help with the short term problem that we
have to solve now and that can be backported to older kernels. It also
won't help userspace - userspace alarm requests, as Brian has pointed out,
are separate from limits supported by the RTC hardware. We can not change
the API for CLOCK_xxx_ALARM to userspace, and doing so would not make
sense anyway since it works just fine as long as the system isn't
suspended. Besides, changing alarmtimer_suspend() as you suggest above
would solve the problem for userspace, so I don't see a need for a
userspace API/ABI change unless I am missing something.

Thanks,
Guenter
