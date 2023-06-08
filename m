Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF3B7274AA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjFHB6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjFHB6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:58:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF79269E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:58:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30ad8f33f1aso54612f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 18:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686189524; x=1688781524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cRJnMgKD4iqcv9KJAujGpltfqotgoZBdf/3JPdpJjwU=;
        b=j9wFPduXwqtAZk7dIwOA0oUkTsdh1KLHpJ3YrpfEyJLGFmFNLgTZV8MnKPY77dbhmq
         kRwRmMDRtdZHEE8Oaj4oirAhHdXK3+6KY1qfkCS5TM9bjrgJSYUJgow96mZRcFaMQowv
         DYiyYeJFA5etk7MpYzln+T2qMiLpDiIJy85TZP02JOHKtXaRbzxURRogz3kJQj1eOBOR
         qx1h4luZax5lczwn1P6BtqvtsS0EPIPANy/jo/vvnDzJ4z/1ckI08yvO8twrHm8GmNGo
         XAUt78kJq32TXg+VoAAKzkLrF9EZuOFHqxhMXOrBaYIS4ZaTgyhDRmSqB3wKqZ1ESDLm
         Wcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686189524; x=1688781524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRJnMgKD4iqcv9KJAujGpltfqotgoZBdf/3JPdpJjwU=;
        b=BY02dIN3Zd4d42x7SgLMPf8MuAjo8TE3RdpL7JxhG39m6C+2iMrfNbhVEodbhH9kpN
         fIK6Oj3HXC21sBSbCnrI3soj9dTRVyk2QWdqLk2VOYx7sU8HiSv/DGm+zClDV61U5n47
         XO6tkUTbY+UMBbpJI5jFDviP3Khzyj8WhKl9noRq9VRUqepvGAz86uufVOEyirV6yPMk
         O8+v14IejcOT8c/zl4NS2wJ8PcBU/z3B0mtjIDpPjRI+8M3isjcpud4pCsnacWCWmiaT
         zuen3kCUXKOZrvtcFUS4uyrOUk2ULrcfhTc+iH4uIlTD4UPPdzHFJb+EJrSTUxzJmSlB
         RSDA==
X-Gm-Message-State: AC+VfDz4Bi2HanMWq9ukyKKtkgFUneNwAxbvWOFgivnl0ZhPn0ghcYUD
        aFwYuCDo2vFLVYRNFbpx9sxnaLbogXLLmqXx7ubJGw==
X-Google-Smtp-Source: ACHHUZ6TM1tVXOCRbk4cTkvrLmHevWLYSdpPmPm/z5Yja7R4xC/Xos7kpM9PZY03EE20Zu5OarVHcueXep6VbJuzRSI=
X-Received: by 2002:a5d:53cd:0:b0:307:86fb:dae2 with SMTP id
 a13-20020a5d53cd000000b0030786fbdae2mr5395027wrw.67.1686189524528; Wed, 07
 Jun 2023 18:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230605215529.195045-1-royluo@google.com> <2023060734-survey-shady-f025@gregkh>
 <CA+zupgy1WCh8Z6cKo1No5k4PcsFFpEDBXW-rTZVih7bfASAZDA@mail.gmail.com>
In-Reply-To: <CA+zupgy1WCh8Z6cKo1No5k4PcsFFpEDBXW-rTZVih7bfASAZDA@mail.gmail.com>
From:   Roy Luo <royluo@google.com>
Date:   Wed, 7 Jun 2023 18:58:08 -0700
Message-ID: <CA+zupgymZusMgecUyD8f2-AnoT3OR_O_wjy6uTxjZgSv9BLHLw@mail.gmail.com>
Subject: Re: [PATCH v3] usb: core: add sysfs entry for usb device state
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     raychi@google.com, badhri@google.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bastien Nocera <hadess@hadess.net>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -160,6 +160,16 @@ static ssize_t connect_type_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(connect_type);
> >
> > +static ssize_t state_show(struct device *dev,
> > +                       struct device_attribute *attr, char *buf)
> > +{
> > +     struct usb_port *port_dev = to_usb_port(dev);
> > +     enum usb_device_state state = READ_ONCE(port_dev->state);
> > +
> > +     return sprintf(buf, "%s\n", usb_state_string(state));
>
> I thought checkpatch would warn you that you should be using
> sysfs_emit() here, wonder why it didn't.
>
> thanks,
>
> greg k-h

I was using sprintf() instead of sysfs_emit() because I randomly referred
to one of the nearby attributes. Looks like there are still many attributes in
port.c that uses sprintf(), any reason why we didn't replace them?
If not, I'm happy to do a clean-up so that others don't make the same mistake
as I did :D

Regards,
Roy
