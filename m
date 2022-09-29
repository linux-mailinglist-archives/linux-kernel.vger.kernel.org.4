Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2CD5EEB04
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiI2Bet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiI2BeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:34:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E809F11E5EC;
        Wed, 28 Sep 2022 18:34:24 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x1so13178180plv.5;
        Wed, 28 Sep 2022 18:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NZxJcimCXLVWvl+T+yH2DTD79AYos60dAJ+wLL/AOns=;
        b=T3lUt1qgENC+2DKuD+zvICEpG19ijUbIICzufyC3DJ4sci671Lz6qquPCPDh7cm96z
         caviaG+FExIvKJVFOW01C10vQhu3VOSpQrkoL2FBvL9wewG5jP9T3zuibTu3Ihuhq/XD
         bRQL2CNew6ieAjPm1rrWnqyiTTTvvdnsw9PsiK0jsEuAKBDfrIcM7dpazVd0xoWuo8sE
         1GgVcJ+fuowF4GX8iYMhiTcL4Kq8opLn/fGOzFgnbWNYla1358+bhDDKjEp3magtnKwb
         yB65ubuGzZJiEQGw8v644A9+yYDjLmqt0o8TrQq8xyVCeD29d+E6INPlW0KU1lKUOTEZ
         tOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NZxJcimCXLVWvl+T+yH2DTD79AYos60dAJ+wLL/AOns=;
        b=CeMfTxxwuImzEupi4c1Zg3QFVEOVPeMaVW0iZKBlhoMfpfkt3hCAWknJimHRZNoarl
         DO6J0tzYxW3ux2huR1y8ougFPk+93K2R7P5yOVM2FuVMisGfDg0arUKIP/fdPL4hFZuL
         3YhSKLAHJCPoRSRJSAs94IVv6d0RriiAZyqTPi1w33G9xGUdfMt2Cmw8cd1+z8x4MEvh
         Zv4RxG+qlKBNCvOB1Ie6RTrEjAn+gRGahdOnZ1ZUEGpTp4YNLqRhNSsUxU0xA1cSeONA
         dCcxG9PcnWb753pfC6Fmn3n2boZJKh7hxeiujsKo90geFBTlVHGwgTZNqdH5dxBv1QSw
         HoBw==
X-Gm-Message-State: ACrzQf1FxFyb85WBYa3txFBebkcid18/XFCdjpPOYKJGESHUBiDWzMdt
        d3cxMfA2yKj1iTDNkIpnjMA=
X-Google-Smtp-Source: AMsMyM74d6NE2XzzWC0POoflHjXzdlavoKR8s/vtRHmBRvghpsj9JJpbJ01AHZZJHLn5VVrQpduqhg==
X-Received: by 2002:a17:90b:2bd3:b0:203:1a03:6b1b with SMTP id ru19-20020a17090b2bd300b002031a036b1bmr941479pjb.58.1664415264251;
        Wed, 28 Sep 2022 18:34:24 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:637c:7f23:f348:a9e6])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090301cb00b00172ea8ff334sm4546657plh.7.2022.09.28.18.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 18:34:23 -0700 (PDT)
Date:   Wed, 28 Sep 2022 18:34:21 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Nate Yocom <nate@yocom.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        hadess@hadess.net, benjamin.tissoires@redhat.com
Subject: Re: [PATCH v6 0/5] Input: joystick: xpad: Add X-Box Adaptive
 Controller support
Message-ID: <YzT2HZjEOd/sg1oB@google.com>
References: <20220908173930.28940-1-nate@yocom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908173930.28940-1-nate@yocom.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 10:39:25AM -0700, Nate Yocom wrote:
> Adds support for the X-Box Adaptive Controller, which is protocol
> compatible with the XTYPE_XBOXONE support in the driver with two deltas:
> 
>  - The X-Box button sets 0x02 as its activation ID, where others set
>    0x01
>  - The controller has an additional Profile button with 4 active states,
>    which this change maps to an Axis control with 4 possible values
> 
> Patch series adds device to the supported table, adds support for the
> Profile button, and adds support for the X-Box button as distinct
> changes.
> 
> Signed-off-by: Nate Yocom <nate@yocom.org>
> 
> Nate Yocom (5):
>   Input: joystick: xpad: Add X-Box Adaptive support
>   Input: joystick: xpad: Add X-Box Adaptive XBox button
>   Input: joystick: xpad: Add ABS_PROFILE to uapi
>   Input: joystick: xpad: Add ABS_PROFILE to Docs
>   Input: joystick: xpad: Add X-Box Adaptive Profile button

Combined patches 3 and 4 and applied the lot, thank you.

-- 
Dmitry
