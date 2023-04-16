Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FA66E3C2E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 23:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjDPVd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 17:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPVd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 17:33:56 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631AD1FEF;
        Sun, 16 Apr 2023 14:33:55 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r9so5040698iot.6;
        Sun, 16 Apr 2023 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681680835; x=1684272835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gy3kFSOdkDvzSy0w35GiiIQBcHUHIwrasUl9Oa3Jx8=;
        b=errXwELZEzPDIHRC2szYREDSwC1VyoYlgifGrauB7RuTnJPXpvbGOzJYqBOaJL+Gf4
         uZvB4KJVyOUi3CUXKJujK7QBLFVXMsb42kOdXDESoIwscK9MJWDWb5fypfSi9qoni5Kp
         w1ibolryRpAW1U7LOSuNE32a1yx8fVQbR+5Kw0AVD9UfvYBLS6NAUMps/E1JBuvucRnR
         XCs4RUdap7VlBcqtTpXUol4+dqog/ZQEpfnxEDUwZFCNe85thK8K2+k7GL7fYTnRi+hz
         NSfbaH+WamWmPQKR3Lx0IoGpzeSK7fKmEetvFNuxLIbP6y+5GgXkDWTu+Zhlh0l15YLb
         17BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681680835; x=1684272835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gy3kFSOdkDvzSy0w35GiiIQBcHUHIwrasUl9Oa3Jx8=;
        b=ERMrlIuW4KkBhcdjW3Q2xqs5+UDEIA5XyPP6/lCGxRRbP9Fn0nv+30aB6p/bgOzoVx
         jnMOZwcLzkR0GINz05MuUcGzhm7kXsF7umjowjqb/WttcaVnvZ94mVok86un5mAo9eWN
         bELJbQXLk5daaPAMW0gtp7Hsk6SHnfc2VTxUxzOesk5tFXhb8FGKONWdXsMQ/0pOCBtb
         CENOPRikdRq8OWC9AHm1UNocF2QdZm6F1rm3eMF/cOhTjrpopO8R2FaoyO3+uS2+SauI
         CAjiZ+j1cYbuTbzgeThMgblo6t1WF3jD54g6V/U4AZxcA8G1Woan8Ni2+xsfYjOyZ62q
         2msw==
X-Gm-Message-State: AAQBX9fAOSsMgY/0zeh+BKFR3yJ1Rn8xrUGFlu3RAjSQ/46aMN2iRzfS
        xT50tRru6fFrOwmrcqMugRDRhGgNUVE=
X-Google-Smtp-Source: AKy350ZNWi0kZ8/te/K1qqoQvEOEoH2Mq1PWoxohXBZvSFupT5upL+8B/xmOtXXPNlWrJ4iwWAzzsw==
X-Received: by 2002:a6b:e506:0:b0:760:ea10:757 with SMTP id y6-20020a6be506000000b00760ea100757mr2756166ioc.20.1681680834744;
        Sun, 16 Apr 2023 14:33:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s2-20020a6bdc02000000b007587774bec7sm2674930ioc.54.2023.04.16.14.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 14:33:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 14:33:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Aquastream XT
Message-ID: <4edb2285-904f-4dee-8bf8-7fdf42b2b7ce@roeck-us.net>
References: <20230416181702.9892-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416181702.9892-1-savicaleksa83@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 08:17:01PM +0200, Aleksa Savic wrote:
> Extend aquacomputer_d5next driver to expose various hardware sensors of the
> Aquacomputer Aquastream XT watercooling pump, which communicates
> through a proprietary USB HID protocol. Implemented by Leonard Anderweit
> [1] [2].
> 
> Coolant temp, fan IC and external temp sensor readings are available, along
> with speed and voltage of both the pump and optionally connected fan.
> It also exposes pump current.
> 
> Additionally, serial number and firmware version are exposed through
> debugfs.
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/46
> [2] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/49
> 
> Originally-from: Leonard Anderweit <leonard.anderweit@gmail.com>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter
