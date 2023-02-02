Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ADC6875AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjBBGMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBBGMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:12:19 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D2F79087;
        Wed,  1 Feb 2023 22:12:16 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d3so833461plr.10;
        Wed, 01 Feb 2023 22:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IUIP0fw66doFn+dv5RvnNvvUzAvr+HD+564gvAt+awo=;
        b=nUO9Kefi2AeThuG/Kf/GGtt7L9cGtwUrY07b0uG76Y84395DGJ1nZVrzMz4RwMZ792
         vzuooVe3dY5u+gwwzBLezKHB7ZEDh8DxJUjN5C7xOmaKv3DOrYbxb8JFX0SLg5fld6kT
         Fsd07LLy6Nuz++KXyvYAHCpFyAuuHJZkMvj3MHVcWeaKzOVIKzLaKNuNHWUDe2a/0Hkt
         QKO8b4hXiUDAAwQRJUvic3iDkfSw05L6xJKroSeuZ9NRfrOD5Wc1WWIqtmHeyk4Ny/Ia
         KwWtTgIWVNQ0VMW8UZZ2JHP3FpkvbjlfkTgmwpRFDeaHJGpCqX7t+SguOp6ZqDENAD4j
         7ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUIP0fw66doFn+dv5RvnNvvUzAvr+HD+564gvAt+awo=;
        b=FvAibwgypjs2m6FEyqNcVJLZDFcwpnU65UiVsAN6eP+YzAtMCIAgZrCvOe4lAfs1z0
         MaAUnjW8y6qhMDlzW2COKweH8vq4iseA+MMfMsMcWcaeZWhDrrBvrGRF6Nd2yMy/uYw+
         W4TKRwMwisl0XrL5zW/0yG/9bH76xL23iiJL1sN/NTb3hUhCjV+JdqkT1Hxbb2ev6Mps
         rzPf9dUoLhvMMv2s7rsVFKn43AAFBvUfjQGVjupY9gLbvBhAljw62Anpt1l/tx2PBgow
         Z42TF7K/UCnXo9vpTej5F+b3hE2BfuxpE8XeUbyHtOyqgcC27FuYUNVO8PO65j95nbtY
         4hnA==
X-Gm-Message-State: AO0yUKX47DTfb16ueJiSlQx1pb9IdRUHf2+fMGxi3U1j2T8WCT+Z/Avo
        yGAViSRHfq3DSSFTHWTty6c=
X-Google-Smtp-Source: AK7set8Cq0dPcfmbVC4q1irk1VK4i/KDC/2M6PBO5VIklez1XJYvTsx+M1IU3uvqw11SKUFyLsjS1A==
X-Received: by 2002:a17:90b:4f8f:b0:22c:8686:5f04 with SMTP id qe15-20020a17090b4f8f00b0022c86865f04mr5473200pjb.15.1675318335890;
        Wed, 01 Feb 2023 22:12:15 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6b75:4990:9ed8:d8dc])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090a390e00b0021952b5e9bcsm2329633pjb.53.2023.02.01.22.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 22:12:15 -0800 (PST)
Date:   Wed, 1 Feb 2023 22:12:12 -0800
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Zack Rusin <zackr@vmware.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Banack <banackm@vmware.com>
Subject: Re: Suspend with ps2 keyboard/mice
Message-ID: <Y9tUPM/UV1quMebq@google.com>
References: <6d7b3cda248c7ca14d6fb3c8fbd49345306ae46e.camel@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d7b3cda248c7ca14d6fb3c8fbd49345306ae46e.camel@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zack,

On Thu, Feb 02, 2023 at 03:23:34AM +0000, Zack Rusin wrote:
> Hi, Dmitry.
> 
> We've been scratching our heads about:
> a1cec0617738 ("Input: psmouse - properly reset mouse on shutdown/suspend")
> because we're having trouble seeing how it can work with suspend on ps2. We were
> planning to wait another 4 years to get to a 20 year anniversary of that patch but
> we figured 16 is probably good enough.

Heh, yeah, it's been a while.

> 
> So the kernels i8042 module specifically calls device_set_wakeup_enable only on the
> keyboard port. Then because of the a1cec0617738 psbase leaves the mouse enabled on
> suspend which, in case of a mouse move/click right before the suspend makes sure
> Linux will never wake up. 
> 
> That's because the dataport will be effectively latched to the mouse (mouse irq
> wasn't serviced in the guest) and it won't be possible to deliver a keyboard
> interrupt anymore, and mouse interrupts won't wake Linux.
> 
> Our suggestion would be to simply remove the:
> ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE);
> added in a1cec0617738 . I don't have access to HP nx7400 from 2007 but it seems like
> that code breaks every other well formed ps/2 controller with suspend/wakeup.
> 
> I think the ps2 mouse has to be disabled on suspend in order to be able to get the
> keyboard interrupts required to wake up. Otherwise if the mouse is supposed to be
> really enabled (but mouse irq's will be ignored), then how does the PS/2 controller
> decide whether to return mouse or keyboard data when they do the data port read?

IIRC the reason we leave mouse enabled is because firmware on multiple
devices was unhappy if the mouse was disabled on suspend. It was not
only nx7400, but others as well. I am not sure if newer generation
devices exhibit the same problem or not.

Regarding inability to deliver keyboard interrupt: I am not sure why you
are saying that Embedded Controller (EC) can not raise IRQ1 and IRQ12
together. Also, they do not have to be wakeup sources, I think on some
designs these signals were wired to other pins as well, and those were
actually configured to wake up the AP.

Both mouse and keyboard data are coming from the same data port, so it
really up to the Embedded Controller to figure out what data it wants to
send first, and Linux is using the same interrupt handler for both IRQ1
and IRQ12, and can dispatch data as needed. But you do not need to read
the data to wake up the system. You just need EC to actually signal
interrupt that is configured as a wakeup source.

I think you should look into how you implement EC and make sure it does
not get stuck.

Thanks.

-- 
Dmitry
