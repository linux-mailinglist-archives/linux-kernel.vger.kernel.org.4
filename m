Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA716FE891
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 02:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbjEKAZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 20:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEKAZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 20:25:08 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38BC558D;
        Wed, 10 May 2023 17:25:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64115eef620so54107901b3a.1;
        Wed, 10 May 2023 17:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683764706; x=1686356706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NiIAKS0VeNTa0Mpe7u/4NIaUrufb6wO/HHXswmRGRIQ=;
        b=D6ZVr8L5gm2c6Qrq+kA00eiTsg5rBpmsfXi9fenQ0gNlZZ8pjMcDY5F0LcGwVe5m1c
         ZlNY1pTqDOh/Sdf3JJHuwU2SqXmTUiXD4tznuUwPnzXOq+wlmAJTMX/s+ETnP39OKyPA
         MW1R4sgwYXh4euC0Qy4GDOcS2yIPoXJDSIxSqJh0YglohoKveKeZLF/qYDesMD/cJ/WO
         iEQU1gfl3UM8uA6u0Wv2sawFK/cw0P5kunYnDN1IuuwJZPUQv2SSmModvt329ibayPth
         pcLChR3avq77eEklPDgP7Sk7KLIodNJWal96Kf6qohTgQZ28DMvwL3+NypmWANhL4j3D
         Q+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683764706; x=1686356706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiIAKS0VeNTa0Mpe7u/4NIaUrufb6wO/HHXswmRGRIQ=;
        b=iL/hF//28QbcL/zovAMQZqzzl9nBpeocZtejrvYaravh4j/GsxIdlkVaJV53UEIZLY
         AHBz/XRkEY45unQulPem8Iy8IDF0FIndRnycn7wt2PBOfsECrEc8ygET/8P55ThuMzZK
         ztYmzCcIzrXvNliqNqlS5DznDUnFPSypKOJsvGO07dqP9ud4TIUzDs9LKYzFDSZ/jtqo
         I9M64t4o5+8JYYtcTmxNBF7H/0ZT2BojQgnp2TFhL2zhxznl9Af/GBZjVjaBpAhbWUSJ
         jVa0b9+jRo8cGPUdiCdZIB5sX0fY74zwB2YK1Zcda1oH2zP5NFF0VluyOePY9fUZSozs
         fBjw==
X-Gm-Message-State: AC+VfDyRNAZj+nt9M/g9TbEADn4Vth/sqXUX2fjJdsU8tpIWQN08bGYh
        zXC2bp00vs0vx72I6KsjhqQ=
X-Google-Smtp-Source: ACHHUZ4xdFMjnxzjvjJ1Fd7ldfzzLJIyyYXtJr+gghVAO38rUN0DBRdC8d6E6cSW+9qzfZpLdHvkeA==
X-Received: by 2002:a17:902:ea0e:b0:1ac:7d8a:35a with SMTP id s14-20020a170902ea0e00b001ac7d8a035amr14529498plg.12.1683764705845;
        Wed, 10 May 2023 17:25:05 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:84a:ed9c:4024:c347])
        by smtp.gmail.com with ESMTPSA id jn22-20020a170903051600b001a80ad9c599sm4386641plb.294.2023.05.10.17.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 17:25:05 -0700 (PDT)
Date:   Wed, 10 May 2023 17:25:02 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: google: Don't use devm for hid_hw_stop()
Message-ID: <ZFw13uv7/q5jsLWE@google.com>
References: <20230505232417.1377393-1-swboyd@chromium.org>
 <ZFWZ785FRHDii/+5@google.com>
 <CAE-0n521MhmdWjEb0-xwnPLQz07bMCGyXokZ3L87azYcw6_C_Q@mail.gmail.com>
 <ZFv9aKZlZbfK1cVr@google.com>
 <CAE-0n52bv1-VaQikOV6hdFmuRyPBX6YV7MT=2+xrpReJecrgbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n52bv1-VaQikOV6hdFmuRyPBX6YV7MT=2+xrpReJecrgbQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 01:50:01PM -0700, Stephen Boyd wrote:
> Quoting Dmitry Torokhov (2023-05-10 13:24:08)
> > On Wed, May 10, 2023 at 11:51:31AM -0700, Stephen Boyd wrote:
> > > Quoting Dmitry Torokhov (2023-05-05 17:06:07)
> > > > On Fri, May 05, 2023 at 04:24:16PM -0700, Stephen Boyd wrote:
> > > > >
> > > > ...
> > > > > Unfortunately, the hid google hammer driver hand rolls a devm function
> > > > > to call hid_hw_stop() when the driver is unbound and implements an
> > > > > hid_driver::remove() function. The driver core doesn't call the devm
> > > > > release functions until _after_ the bus unbinds the driver, so the order
> > > > > of operations is like this:
> > > >
> > > > Excellent analysis, but the problem is not limited to the hammer driver
> > > > (potentially) and shalt be dealt with appropriately, at the HID bus
> > > > level.
> > >
> > > Thanks. I thought of the bus level approach as well, but I was trying to
> > > keep the fix isolated to the driver that had the problem. I'd like to
> > > get the fix into the stable kernel, as this fixes a regression
> > > introduced by commit d950db3f80a8 ("HID: google: switch to devm when
> > > registering keyboard backlight LED") in v5.18.
> > >
> > > Is the bus level approach going to be acceptable as a stable backport?
> >
> > Sure, why not given the kind of stuff flowing into stable kernels. At
> > least this would be fixing real issue that can be triggered with a real
> > device.
> 
> Hmm, ok. I was worried it would be too much "new code" vs. fixing
> something.
> 
> > >
> > > This got me thinking that maybe both of these approaches are wrong.
> > > Maybe the call to hid_close_report() should be removed from
> > > hid_device_remove() instead.
> > >
> > > The device is being removed from the bus when hid_device_remove() is
> > > called, but it hasn't been released yet. Other devices like the hidinput
> > > device are referencing the hdev device because they set the hdev as
> > > their parent. Basically, child devices are still bound to some sort of
> > > driver or subsystem when the parent hdev is unbound from its driver,
> > > leading to a state where the child drivers could still access the hdev
> > > while it is being destroyed. If we remove the hid_close_report() call
> > > from this function it will eventually be called by hid_device_release()
> > > when the last reference to the device is dropped, i.e. when the child
> > > devices all get destroyed. In the case of hid-google-hammer, that would
> > > be when hid_hw_stop() is called from the devm release function by driver
> > > core.
> > >
> > > The benefit of this approach is that we don't allocate a devres group
> > > for all the hid devices when only two drivers need it. The possible
> > > downside is that we keep the report around while the device exists but
> > > has no driver bound to it.
> > >
> > > Here's a totally untested patch for that.
> > >
> > > ---8<----
> > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > index 22623eb4f72f..93905e200cae 100644
> > > --- a/drivers/hid/hid-core.c
> > > +++ b/drivers/hid/hid-core.c
> > > @@ -1211,8 +1211,8 @@ int hid_open_report(struct hid_device *device)
> > >               hid_parser_reserved
> > >       };
> > >
> > > -     if (WARN_ON(device->status & HID_STAT_PARSED))
> > > -             return -EBUSY;
> > > +     if (device->status & HID_STAT_PARSED)
> > > +             hid_close_report(device);
> > >
> > >       start = device->dev_rdesc;
> > >       if (WARN_ON(!start))
> > > @@ -2662,7 +2662,6 @@ static void hid_device_remove(struct device *dev)
> > >                       hdrv->remove(hdev);
> > >               else /* default remove */
> > >                       hid_hw_stop(hdev);
> > > -             hid_close_report(hdev);
> > >               hdev->driver = NULL;
> > >       }
> >
> > This will probably work, but it I consider this still being fragile as
> > at some point we might want to add some more unwinding, and we'll run
> > into this issue again. I would feel much safer if the order of release
> > followed (inversely) order of allocations more closely.
> >
> 
> Sorry, I'm not following here. How is it fragile? Are you saying that if
> we want to add devm calls into the bus layer itself the order of release
> won't be inverse of allocation/creation?

What I was trying to say is that later someone else might be tempted to
add more traditional-style resources and non-devm-unwinding for them.
Having an explicit devres groups gives exact point when driver-allocated resources
are released, and makes patch authors take it into consideration.

If everything is devm-controlled then we do not need a separate devres
group.

Thanks.

-- 
Dmitry
