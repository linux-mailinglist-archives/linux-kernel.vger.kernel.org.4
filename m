Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE7F6E6D02
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjDRTjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjDRTjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:39:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E30C659B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:39:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u3so24090744ejj.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681846740; x=1684438740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M43/kQ95jci8zCNXbRDlZaa+f564NQzoQoFhL3xI5y8=;
        b=pIH5hDtJUCMANdD26eav3fmF9e2NRW3aA7SrCst1faFt4T67d/vYHEDI8OcRSHS95m
         no/1cJtbc61bKakJ04Om444WoVyAXiBXcT4/g0rtZc0qB/YzMW3M+CIskDtWV66PPOe3
         y9bGeAKljpE+tMajHR0pJ2mpGdcbuHvhavEZGzvztd8YgMgYnnjyTciINBtiGI7TZlFb
         TfXf6BL/Uo0oQEgSCZvjPwL/DdeIsbB+h8f0AW11belWysyad2lIKzKT0SbpOmb8gx+R
         Aw51P+TgktUy9IqZy0yyNt7uHorYMP8E7Au+Sad8C30joWNoRPqrLnNmIaphXNKUUC83
         JBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681846740; x=1684438740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M43/kQ95jci8zCNXbRDlZaa+f564NQzoQoFhL3xI5y8=;
        b=dQWbe31G55BxmBMTcHijOH9c1UlszgVyWYOTDXPUM2Fs6FVuq8rAbRkgC039WsDD+A
         S/S/VqzjlhPrwcy2Kyu7UzB6zg7HjQoRjTveicHftV0viUrVq97wHJLfM2XFYtxJxn9l
         +03UPKHD2CbhKQJl2SeQBHwN2vQgs2px82tAm1jy32p8Jd/lFjzwSuklXFdU6WWZAtB+
         kDEQRpWLbNFaOMiD3Y0aXcDDqOpnfQU6aZ8tN06EZuSU3qyIOsRieHajxzZRjjrU7PC6
         Ihrnw6+GqTfOyEjaMXpClzH2Gur89P46NXp/Gj/fYokfUe3VQFkIZgTRgwWpe0aXHTzd
         VH6g==
X-Gm-Message-State: AAQBX9fMWO9C81rkphsLPRQqLDHDWTpFdwnC8OIzUR6ZmQ/s/2VXK1VT
        R/yrpsHshQH53CvbUHknZBM=
X-Google-Smtp-Source: AKy350Z66t4j3cWYJbwZcBzrZu6T5OwU7z94uUH8rnGbXX/oEWbUnK5HDTQ1AmK0KlfKuWySjnwWSg==
X-Received: by 2002:a17:906:e2cd:b0:94a:6de2:ba9 with SMTP id gr13-20020a170906e2cd00b0094a6de20ba9mr11069629ejb.68.1681846740329;
        Tue, 18 Apr 2023 12:39:00 -0700 (PDT)
Received: from kernelhacking.kernelhacking.example.com (dslb-088-067-245-126.088.067.pools.vodafone-ip.de. [88.67.245.126])
        by smtp.gmail.com with ESMTPSA id d9-20020a17090648c900b0094f4f2db7e0sm4343891ejt.143.2023.04.18.12.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:39:00 -0700 (PDT)
Date:   Tue, 18 Apr 2023 21:38:57 +0200
From:   Luke Koch <lu.ale.koch@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     error27@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: wlan-ng: replace rate macros
Message-ID: <ZD7x0VWFedQSvA2P@kernelhacking.kernelhacking.example.com>
References: <ZD6OqBOp1ezQDgMu@kernelhacking.kernelhacking.example.com>
 <2023041809-wildfowl-winter-be08@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023041809-wildfowl-winter-be08@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:04:06PM +0200, Greg KH wrote:
> This patch implies that these structures are set but never actually read
> from, so why are they present at all?  Is this a structure that is on
> the wire/air or used somewhere else as an api to hardware?

I never looked that far as I was naively trying to just fix the
checkpatch warning. They seem to be part of MAC frames coming from the
hardware.

> I tried to unwind things in the driver, but couldn't figure it out, what
> happens if you just delete these fields, does the driver still work
> properly?

It compiles without issue when deleting these structs, but almost
certainly breaks the driver since it changes what the resulting message
looks like in memory. I assume the caller of the function uses the message for
something - otherwise setting all the message parameters wouldn't make any sense
at all - and changing the message like this would cause major problems.

The structs seem necessary, but changing how they are accessed to using
arrays shouldn't introduce any issues as resulting values as well as addresses
in relation to the message struct will be unchanged.

Best regards,

Luke Koch
