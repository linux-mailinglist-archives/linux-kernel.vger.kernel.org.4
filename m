Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C686034C9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiJRVRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiJRVRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:17:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53935C8200;
        Tue, 18 Oct 2022 14:16:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q9so35504943ejd.0;
        Tue, 18 Oct 2022 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KXajiJoegweNIUxGXxwigTCCYehMZ/VtbN0U3Syfum4=;
        b=GZtaHJXRtY4TsE2W9IQ+H+7BU6CqzCVwuyPye7+0TsJBArItUPGkbDrJOQzqBxvU9l
         T1FEefBlxI56uU2aGOXliZo7cSZ5jlxXwlFbyZISFaus7J95p09TiHIviL4jCv4tiMQX
         0d+Z9DBu3WLYcCLgafwyBwtalmM4o0DFlemKqpY0d9ebelLoJJn3cJ6bUcxajfipvLpf
         x9F4igE5KEZwDjpmy8OkHOz8+M+iPDOvS+j446gJIab01uTTMaq8psrndjyPI8z2+5f9
         5cgIz30aPqT2lg7ijAr9r8uVKMzPZjAataDTOtg+YC+JcKsensankooabq5mHrvvjiAJ
         /VTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXajiJoegweNIUxGXxwigTCCYehMZ/VtbN0U3Syfum4=;
        b=rPjh93+Ad7ra8LBnYQ/IDGOZHTbawG+WkcntW6lAQ1CvIwOGI1C0beu6cdsWPZccvi
         m9tgsgutBEKYCdewzmYCqLoIvrh9KoAGL+W8xpfheVkux8nJJvW0s/UOyUB3/M3hOTjZ
         JkZPzRe4a2XKvKoPT+gAlZV1VD8lJIcTn+cjlay+q/vf6UZxLeR4IF4fflgnnCyR+jxZ
         T2XKQp5oBb5qCjM3yZBCT7+yVO6UmLm5NtVeY0X6gR0B7ttg9ZboWQGdPZf0KCKYpNJM
         lSJCuAz8M9I+WBm68OrgxWm4xPZLFrhX8S51emEoxbZsbJHyoF3bHvNDvgUIsAcpt00l
         qXYw==
X-Gm-Message-State: ACrzQf3x5NBcGLAWNxy75daBUZB79liFiJJ5BhLQP8WYRkcf1Tl8yhAs
        gmDGf6P2TRUceKIIZLwZToDk3ixIJkLp9CaIMds=
X-Google-Smtp-Source: AMsMyM59CkxYBd3MHKQ+h6wmgMtZtQuYmtvfeRdv+9KWMvPa2MnVu7LorvjV3qm3NPxt48vIO8BXr3tC8yXz2NwjqLc=
X-Received: by 2002:a17:907:3c81:b0:77a:327a:815f with SMTP id
 gl1-20020a1709073c8100b0077a327a815fmr4116855ejc.422.1666127790470; Tue, 18
 Oct 2022 14:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221018195122.8877-1-linux.amoon@gmail.com>
In-Reply-To: <20221018195122.8877-1-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 18 Oct 2022 23:16:19 +0200
Message-ID: <CAFBinCCqXBk9Xq0k=NA3zGi8spwyPQN7dMVWcjE+pXkXYf+FKQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: Enable active coling using gpio-fan on
 Odroid N2/N2+
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

Hello Anand,

On Tue, Oct 18, 2022 at 9:53 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Odroid N2/N2+ support active cooling via gpio-fan controller.
> Add fan controls and tip point for cpu and ddr thermal sensor
> on this boards.
In the schematics for board rev 0.6 [0] I cannot find any information
about a fan connector.
The schematics for board rev 0.3 [1] on the other hand document a PWM
based fan connector on page 16.
So now I am not sure whether your patch only applies to certain board
revisions, the schematics are incorrect, etc.

Can you please provide some details about the fan connector on
Odroid-N2/N2+ and which hardware revisions are supported (and which
aren't) by your patch?


Thank you!
Martin


[0] https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.6_20210121.pdf
[1] https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.3_20190117.pdf
