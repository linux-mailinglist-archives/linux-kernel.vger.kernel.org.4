Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00518655904
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 08:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLXHti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 02:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 02:49:36 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802E818381;
        Fri, 23 Dec 2022 23:49:35 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so10625893pjj.2;
        Fri, 23 Dec 2022 23:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnbK1C3tAl/B2kMzA6I4NYD3A/jljt/Z9ocUnpOLO+Q=;
        b=DPFd27v9ZneQw/vC3dnJwX9CYcmbAofwuES94tzew+/v7LODNWUsv7o6ZDkeJt4l0u
         KYxynWfxj4X2jAxvhrkJmBTvuFZHdAvgKQ6yaVyb0NjUX0Y0babzUU3mCFgwJWKBfe80
         yqW3B62PJHCZzrAYLd+gpWKI+IfaCO8K2Zb8u12X2QoWxHfpur4kHGQWW7SrSRb3Fzbp
         MT54pj1IDct1IFUe+IkjKL18+7yu/PJJsnAyfKcDUcriwD8o7HZo/JUmAvD6tnEO/OyF
         kpZcd0hwN49KM8JXPy0Pt20vHJ7Q2yEtnnFel2wVgDM0bmUnKUp6ogL/icXAZgEea2eu
         UtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lnbK1C3tAl/B2kMzA6I4NYD3A/jljt/Z9ocUnpOLO+Q=;
        b=dorcXju7n58lSInZ3PduYNW7pJzLzvIzbI6aHMmXgxsDjP5Mt4Sc4rgXDZsUN6TYos
         IEUtIKZqG2oU49Qszz0Cm9Zt9GzKKeQp8aF1PrRwaZ3QME2/55UcY3cvA5ocPe3Q3fUb
         Z5MBaHZislT9fHKGjOqB9ZY2uH2p8EIj8LESaP6+w3CEqwG/dEduWg3Vyylkb2wa3t3E
         gN+CSIpNSv5lV3E5exVHG3NkFdEhhddyNYREm6xjxcyS9ryvLAjk6a16b1TjcQ44IANl
         2AgMhfEEBXP8p6KNctnPEk+W1Y2mj1IrNcfbXOgjH2ZkFzg+8wsbXOpeZy0NyrX6oRoP
         OMEg==
X-Gm-Message-State: AFqh2kr8N4Upjt7wqd3ReLaiIinYWobPaJ9b2kp5yszdiJnL0LETf30T
        AIjZSkg7srWM6X/wkH7KvwqkZoYufIZ7U4YN
X-Google-Smtp-Source: AMrXdXv0WhnfodhW7VqymWGEUW62ifeHh96+2bdq8+w12z/ycCj0c6SVfBg0bcDKLNVFzcR4KErb7w==
X-Received: by 2002:a17:902:ee41:b0:189:8f0c:d314 with SMTP id 1-20020a170902ee4100b001898f0cd314mr13892493plo.39.1671868175087;
        Fri, 23 Dec 2022 23:49:35 -0800 (PST)
Received: from [192.168.122.138] ([49.36.41.210])
        by smtp.gmail.com with ESMTPSA id c16-20020a170903235000b0016d773aae60sm3534002plh.19.2022.12.23.23.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 23:49:34 -0800 (PST)
Message-ID: <940462e95c8eea934b8823aa189dbddece6bee95.camel@gmail.com>
Subject: Re: [git pull] Input updates for v6.1-rc5 #forregzbot
From:   Aman Dhoot <amandhoot12@gmail.com>
To:     regressions@leemhuis.info
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 24 Dec 2022 13:19:31 +0530
In-Reply-To: <343bc8a5-a426-8f6a-70b9-3877f53c003f@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If I use synaptics touchpad in legacy PS/2 mode.keyboard and touchpad
stop working randomly because of TLP, if I uninstall tlp it resolves
the keyboard touchpad stops working randomly issue. But I see good
battery life in my system using tlp by switching touchpad from legacy
PS/2 mode to RMI mode resolves the problem. this way i can use tlp and
keyboard touchpad works without any problem.

In my dmesg log I don't have msg "psmouse serio1: synaptics: SMbus
companion is not ready yet".

