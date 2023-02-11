Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B440693377
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjBKUFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjBKUFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:05:49 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F50718B10;
        Sat, 11 Feb 2023 12:05:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id fi26so8277100edb.7;
        Sat, 11 Feb 2023 12:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KzDSfUuHoNboS5QzLEHJDCgvHam8ZLPZmhS8geBp4Dk=;
        b=kdX2lmhKxfR/ZMgxVpRW62qTK4BVDwB9SKRoEdGRQ3HzHWex/WAfUuaM0Z8VrWHskM
         wt0DVN0FTRsYfOr8KA3IqKlWpIpzPx2b+3upOe4/nn5WOfLk32KVVA5Ox6ZLS9EPV5EA
         W8wuLB8mw9lAqhGSEdE2OZUh3VwmAyEyaN7kPkcs5FQ5F+8CzaHWkrml3Z28FR4fmmvc
         LIKwdIGRsIMwZKcm6Y7jMWXg2vpb9aNBmkiSuIB/BR9h4QkQG13r66fnsZRTDPM3J1pi
         sGo1qL9c7wy3xlMNysL80YNUENI/Ix5qry4s3IZ/6TkjuhH5czuWtPUDwUZ40eA/qM01
         1t9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KzDSfUuHoNboS5QzLEHJDCgvHam8ZLPZmhS8geBp4Dk=;
        b=FqE3obi99uH/E+tH81fzKhKCWdSKmwOxcFmwam5NH/cEPG68QtJZoG9VbvFcE4V2RF
         G4IqIMG91rcQZJBD9McTpBwbwqFiJCjrSXBfdq9blNABZr+aUGx2qIdDKuzLRCAqCazz
         QR5rKYa56QSE4ICcxT8ZwurySDPnVxjrUJBaBaa/u7/DJG5TShzT9WcjfFM5TWkSdhya
         VIP+7tLjzBBcpGYTeZSXCWGTPC8AsicmMTdt7XUag3idHVoKWltHJfXN8wPeU3SBxezf
         ZAluU/J1Nuyr1fC6U5PAo5XrBI9yDJk//bDhXAP3iSBGnNRgs1E50cKTgQe5Nl6kW3cF
         z3/g==
X-Gm-Message-State: AO0yUKWKMlWus0Uk1azgJ3mgtFeXyAgVDuNFchMbpwt2f4p/MeT2Tfpc
        dgy1cIYQFyq7PCgapURBrNq6v1upiYTiYZboEx8=
X-Google-Smtp-Source: AK7set+TBgxHZk/FJCszd+S4lVDv55G9LzI1GuUXh9/iIBefxgoFcd90YDIzCQJeclA6A6UWN2PrAtDe0oYRV7VvRMY=
X-Received: by 2002:a50:ce59:0:b0:4ac:b8e1:7410 with SMTP id
 k25-20020a50ce59000000b004acb8e17410mr866928edj.6.1676145946715; Sat, 11 Feb
 2023 12:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
 <20230207-b4-amlogic-bindings-fixups-v2-v1-7-93b7e50286e7@linaro.org>
In-Reply-To: <20230207-b4-amlogic-bindings-fixups-v2-v1-7-93b7e50286e7@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Feb 2023 21:05:35 +0100
Message-ID: <CAFBinCAJvw=N=KBcmbkLfg10brEwDN1sgSeofqxaDJ0AfydUAg@mail.gmail.com>
Subject: Re: [PATCH 7/8] arm64: dts: amlogic: meson-sm1: use correct enable-gpios
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Yuntian Zhang <yt@radxa.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Tue, Feb 7, 2023 at 4:08 PM Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Replace enable-gpio by enable-gpios to match the bindings.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
