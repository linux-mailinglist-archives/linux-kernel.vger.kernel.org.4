Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59B76A1B28
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBXLKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjBXLJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:09:44 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E125830EB;
        Fri, 24 Feb 2023 03:08:54 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id h16so53535290edz.10;
        Fri, 24 Feb 2023 03:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WNMaV7WgelnPDajGIIjEuoHp/ErryWU67TwpipK+OSM=;
        b=oDuL7Ue9xH8ZoBiA5tN3w6IubU7+wQ4QnW4617I0HaxulfV2N13io+A6bRzXhBEZQl
         7mMO+lp7ZppdXTw50/Q54r4ccPFfdiGB+2HZpfJpwEWLjxAZ8CGUpcE3A3Xp6/rONF/4
         gfRhGvKefnWeRtZBQxLqnasfk4Q3rZaAPq6v2FnBfJnSuP0RGmiPr9p59TIZwaNEmS4L
         mf1JevvOczqi1Wxf7MnTqMyWF0zhXuixPw8FQxbpfxdMFEtX22SDYjYjrJxkZjT7bPFP
         MtSZwWxdC0V0idELKfYRFexjad3um+WfUdbyRBFHI0hxat1jwBlg2EG3lMBm+XP6mUeD
         bPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNMaV7WgelnPDajGIIjEuoHp/ErryWU67TwpipK+OSM=;
        b=CffK6SUN5OYR9IaQSJR0tLSCAlvVhwYU3f0Yrbi7qA54XCNADMf3k7AV19b/jpAliA
         +EFMrqbU+aXhM+UczJ5mDnEV0fhv5LuTO7ePa8uB9TpXRnGHUpMWLEJnWlMDCsqR4QuP
         bhzIH2WJGfJ3N0Zz77UfTD5i2dlxUZdoXOJMysiMZz7h7REbKIS/JBPHjVBfEVCov7hF
         CmdXsT0K86C/DqDSxrbClnjh781ZW1twu8fEY5AVQjvLYpUD9cxWAR5xa1+4XPbPt/HB
         YwjE9DvnZUn0qOyksUj4DXwGlfAFmsTrcLbF5Mt7sb2Hs6eDVoPQ3OoUZCm/Hp6rIUqr
         BfKA==
X-Gm-Message-State: AO0yUKXywtL1PeGBb+7mqMF57AwY6w3Dxb+boKqSshKxLt1nLp5jLh7O
        t3671lNRKsElpMIe5CqalZ4gSXNPCkiVx88iDjk=
X-Google-Smtp-Source: AK7set/mimyM80YxsFoZxkhOgklb1+pkk/5rW4IWn20z4RKP/YfJqx8WEPI4Y56SKGrPc7yIrLZhMgLzLSVoksJ3Of4=
X-Received: by 2002:a50:8a92:0:b0:4ae:e606:432f with SMTP id
 j18-20020a508a92000000b004aee606432fmr8210069edj.0.1677236933400; Fri, 24 Feb
 2023 03:08:53 -0800 (PST)
MIME-Version: 1.0
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
 <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com> <e26318db-77b1-4876-8a40-f707d11b5857@app.fastmail.com>
In-Reply-To: <e26318db-77b1-4876-8a40-f707d11b5857@app.fastmail.com>
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
Date:   Fri, 24 Feb 2023 12:08:42 +0100
Message-ID: <CAMT+MTQ0bZiGpEFK9w3zncB-ZcCLY_tp1d5Wc0MJUMjWqc61jA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] dt-bindings: input: touchscreen: Add Z2
 controller bindings.
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>, Henrik Rydberg <rydberg@bitmath.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 at 12:04, Sven Peter <sven@svenpeter.dev> wrote:
> Now that I thought about this again after the brief discussion we already had:
> Do we even need to specify the device name? Is there any reason we can't just
> always use something like "Apple Z2 TouchBar"?
A similar protocol is used for primary touchscreen on idevices, which
need different
userspace handling. This is to make the driver potentially useful for
people who run
linux on checkra1n-able devices.
