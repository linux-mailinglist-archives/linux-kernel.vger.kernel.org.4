Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144915FCAD9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJLSpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJLSpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:45:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8EC2035F;
        Wed, 12 Oct 2022 11:45:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l1so17024300pld.13;
        Wed, 12 Oct 2022 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1QuByy3mBbuxnxi+ZelOO8l1V6nIE6lgljg4uEZ8zc=;
        b=mmW0qFQW8rEUgJkkXny1n/W8R9zqhrMWTMwaQYsSSo0pr1O5cxowLAUQAnr/mrMP3E
         vAWhOdcUf4J8qEqb8tsRloChymkmDwt9jm89mb4vFMsOa5QHJnU5SjCqYdYV+mAYyIIg
         NuJEqOpi1QK5uTsYRjTxrTrq7/S+3NHyHDHT2YtOFPD7EAGzAaUyPG9/osiANFtNAhMW
         S047/1HNZyZ7fLZZ+gmjR4J1ScYA11lNAJDLIcS2Qq08hZjeHszk1NTo5tem45GhFp4Q
         feZV/o4ye0v4KnaKCFSzNZrzWpzHw3klaLDbr7882bgcSUdRUSPr3J6/706Ut0J6UfyE
         V9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1QuByy3mBbuxnxi+ZelOO8l1V6nIE6lgljg4uEZ8zc=;
        b=HFRCihHyBPcJlIAIYq90ahyBkrBsWW62YVk2JvfYX37Wm7d+eHzsgiBE6V4iMRiH3w
         GbhQcVhQuix0Dr+4rSClv38e6ezqwjLEYJDBX9v8ZG7RcwH5AZl48MKtD7M4USBm3swE
         tqoeJc7hZY6pqsTPhX3cwUACTKRovD8QusXk7Rc2S62+C5WV6LPorSXGkOG+2vgDku4F
         T+Vjfg5aBR7Tb7nQAUwyT5i10H+gK3Q4nXcIWzjeIrfOZmQH/xiGvpmc9QzE02gZXtsi
         bfkbpK5wjsfG3akUNEWwDMqf3u2A3B+05ogM8t8kX8mrq/XEHCPSbCuYiMK5eG33Dh8N
         0Rdw==
X-Gm-Message-State: ACrzQf1SxdyVCKQKv3EsbDzQFfrl8oPEpbkzth3R9bf4FAvsyVJkfXrS
        0pFOEY9N16PR1EQNbXnlaRU=
X-Google-Smtp-Source: AMsMyM7JJXMal6i4KDxQk5AXM8OrkXhvd2rY0XhwetB/JNmiYl+IqjfWrjSPFyqe60y/8mYUuLz7fQ==
X-Received: by 2002:a17:902:d2cf:b0:17f:7b65:862f with SMTP id n15-20020a170902d2cf00b0017f7b65862fmr30482331plc.168.1665600305991;
        Wed, 12 Oct 2022 11:45:05 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d4c1:686c:5489:5df9])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090a668e00b0020aedddd3cesm1765941pjj.5.2022.10.12.11.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:45:05 -0700 (PDT)
Date:   Wed, 12 Oct 2022 11:45:02 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 4/7] gpiolib: of: add a quirk for reset line for Marvell
 NFC controller
Message-ID: <Y0cLLraNFVXtD2/k@google.com>
References: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
 <20221011-gpiolib-quirks-v1-4-e01d9d3e7b29@gmail.com>
 <Y0aW7vDxfNa/8bAk@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0aW7vDxfNa/8bAk@maple.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 11:29:02AM +0100, Daniel Thompson wrote:
> On Tue, Oct 11, 2022 at 03:19:32PM -0700, Dmitry Torokhov wrote:
> > The controller is using non-standard "reset-n-io" name for its reset
> > gpio property, whereas gpiod API expects "<name>-gpios". Add a quirk
> > so that gpiod API will still work on unmodified DTSes.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> How/when has/will the DT bindings documentation for this hardware be
> updated to describe the new bindings?
> 
> Delivering the quirks ahead of driver updates is great for avoiding
> merge conflicts but it also conceals the rename from reviewers so
> risks neglecting to update the bindings.

I was planning on sending binding updates once driver patches land.

> 
> Other than that:
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Thank you for your reviews!

-- 
Dmitry
