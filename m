Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E260A6724B3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjARRTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjARRS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:18:57 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0999F4AA5B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:18:55 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id u8so17377116ilg.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kUweEJsz1I+VstJe9YX0p17oDZgJR4Ui31/RYAe6tw=;
        b=FmE67VsAO0nj0Y4Qun6+he/g7nukglQR4r0mw+iUu2AfdP7RFN1Ut6i2nObVZJHCw+
         +DWRgzY9EgGEGKlXdejzp4ViO8lK/92r6ZSIpio58q5PfPfcGN75NBt5QP5OfniCWW3C
         uo+Yxz3hnS+frF2Ota62uYi+xnd9FpkdoPsDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kUweEJsz1I+VstJe9YX0p17oDZgJR4Ui31/RYAe6tw=;
        b=cehlJLyOjHqnOt2O1gZC/vVdQvCKXYx/UtUdAD4h+4AP0muIgPWYNzLnUSpOZo6toA
         ktglgeuf86CRtjdyAaUXTwbaqs/T9OeKVlItsMEEx4fK4GX6HBRlRx9j8qthHLXf9PHK
         O6/np+pkpkq0lht43ivvl6sHagTkeQbUjGewClEEFuHuOS/vHfYMgv9y1b4p88wbBSkw
         vfs2exX+5znK2vnB3VwWCYKRB6pHzgsq1BhgpYVM15wU0G/hHUas/qss2o46PauA42OR
         tusPfQwmu4VQEyBxYQ4zb96N15wTTiiEWs6ez18QuggNnGAryroTYgn3ub0OG6dMP2jB
         VlXQ==
X-Gm-Message-State: AFqh2kqcvIWePVXSduFblYk3IlkjPP3L3sYvhyaTunBLK1FH/CwSMk/o
        G/l6FqXVZN4E+BzMYKsFaInaWQ==
X-Google-Smtp-Source: AMrXdXsHSHwWMRi7BEYSROOq8YpKIH8Ioxk083DipSTSjeRYtjmqTkFnhcMejKTCDWCDR0eCkrlO0g==
X-Received: by 2002:a05:6e02:de6:b0:30e:f36a:f24e with SMTP id m6-20020a056e020de600b0030ef36af24emr5125952ilj.11.1674062334964;
        Wed, 18 Jan 2023 09:18:54 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id m3-20020a923f03000000b00300b9b7d594sm10059003ila.20.2023.01.18.09.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 09:18:54 -0800 (PST)
Date:   Wed, 18 Jan 2023 17:18:53 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] usb: misc: onboard_usb_hub: add Genesys Logic
 GL852G hub support
Message-ID: <Y8gp/Q9kpFLjQSiv@google.com>
References: <20230118044418.875-1-linux.amoon@gmail.com>
 <20230118044418.875-5-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230118044418.875-5-linux.amoon@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 04:44:12AM +0000, Anand Moon wrote:
> Genesys Logic GL852G is a 4-port USB 2.0 STT hub that has a reset pin to
> toggle and a 5.0V core supply exported though an integrated LDO is
> available for powering it.
> 
> Add the support for this hub, for controlling the reset pin and the core
> power supply.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Acked-by: Matthias Kaehlcke <mka@chromium.org>
