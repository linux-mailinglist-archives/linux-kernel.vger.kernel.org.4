Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF4A6B604E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 20:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjCKTp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 14:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKTpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 14:45:53 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279FA6C6A6;
        Sat, 11 Mar 2023 11:45:52 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y4so4295828edo.2;
        Sat, 11 Mar 2023 11:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678563950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zLCrQdyTnukTKt1Qc5hOUjsel2piCYiG6rXSPOyBxA=;
        b=kPlMtAaUgh8VRT077EHQqqXZp6AZu73vAaGQBT6ZYTPP1rcw7BRwZ9nrphosgEXV1+
         mQdKdVK/+3MmY/6k2dtZaF8cd+A+J7JvQ0U5xxz5wjGdq7uj/1IHWNXEcLbCn6KJVBpT
         kxSb+4f0ajGMiYarehtQQP5AA4P5pQQ5ORsAfWog+eadFrrtLSRKkD0vWf49UImvMjij
         GR7oMjIKpXhRZao4eurFmdi3hlboFm2Vv+/JLhOo15eL7D5WPa1syGCwzEPiZXTa717Z
         HNNnzxx21/cmVLfXNDEV6BbpOcuGydcr6J/JGU+QgdG+MSFIvVRjnDJ/46vIebz+aq/x
         3yUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678563950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zLCrQdyTnukTKt1Qc5hOUjsel2piCYiG6rXSPOyBxA=;
        b=v+TqSjpY9XI4Cwt2xYRQUlsYKqWV6oEPyW1KDcHX+pUTCTc/SLqKUgu2Dei5ZAtkpq
         EdbKG44i22SctFyU9IhViJe9fHa3DEwYzCH450NAuCrsTE1J1miMOt298Hy1Y+CZm1U3
         wn1TVU7EODV5zy0VVDq6VuTUQLQYKsgIWqo5uHhc7KE67oO8qeYL7hnhQb8L8/qt5Yzd
         FmxACSvDLmZPWFUoIsg6zVmOslBQVoSHcICc/BI/uCsvgmVT08Gd1JlwDzR6wAqX2xL2
         a+PNxPTdj+E+/qfiGx0jIyMLZFXaw6go/TnvKDfPxc/bhUQZf/56TN78SHCLIlJME60Q
         z/UA==
X-Gm-Message-State: AO0yUKU/UqTgK+hjTPRhKe9WJTiDK1ws7bh++qtT/vSEPZEgZkrHYETo
        uvOHD7dXL6pe1L9jQBYqE7r1tksDjrJ1bi3QOHQAFS/tyHARnw9q
X-Google-Smtp-Source: AK7set/GW4H9oVLyNF+MiokqtN3HHY5yUtJrDVEAVKHOWqYYLtObanyZW07sw7ehQIyDHn1O4BaXc+FDezJRVtIsreE=
X-Received: by 2002:a17:906:7cc6:b0:8b1:7682:3181 with SMTP id
 h6-20020a1709067cc600b008b176823181mr6185665ejp.9.1678563950540; Sat, 11 Mar
 2023 11:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20230214-fpwm-v9-0-364480b0e4bd@gmail.com> <20230311194254.lydmh23has2e3flj@pengutronix.de>
In-Reply-To: <20230311194254.lydmh23has2e3flj@pengutronix.de>
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
Date:   Sat, 11 Mar 2023 20:45:39 +0100
Message-ID: <CAMT+MTRgL2_nVHZapqeFPchY9vnVWKE651DHY3Prq10eaU1EKQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] Hi,
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sasha Finkelstein <7d578vix8hzw@opayq.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 at 20:43, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> apart from the subject this series is the same as the one sent slightly
> later.
That is correct, i screwed up the editing of the cover letter and caught it=
 only
after sending it. Please disregard this series and use the one sent later.
