Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068B8693381
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBKUH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBKUH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:07:26 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E74719694;
        Sat, 11 Feb 2023 12:07:25 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a10so8269791edu.9;
        Sat, 11 Feb 2023 12:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kG8SI5lk4Wq0dbZT4Ec7NosqXm61vMmy3hObpjA2IZc=;
        b=k5+0Knye7J7VX4D81XzhGiZ+9tChr3///NJ4MrDKP4U+5wdIltqlQGXlbWXlAg7t3L
         MER1ujRwcUHzDXwF9jGmpsoKvitNhBT+2ZZSNCHHHovLLakV+YGkqwGqpbjaYpwa4gxE
         g7FNbfHHjaQ/kLDqhd1Kvq/NuP13bXmUAwQrg35L5NI1dLsm/R/zlw730AlHGpzJhF7G
         L3fwVhZXQc/eMebVEhrfJeMkbpSYXePTy1O+2bFC18s1gDqe7MYedgUR/GowO68mvScd
         RD6s76F7mqR3ruj8dnRq0fdYTq+XeBdD4991weGMkVWSfsJ5Hv6rFOd95DZriyc4tcz2
         eNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kG8SI5lk4Wq0dbZT4Ec7NosqXm61vMmy3hObpjA2IZc=;
        b=GUZWYZk+FFx2JusJcZnYfEBRQXQUREJKFebUtnl/L9nGcFvNHZd5FjqtDp9jK6bPtv
         QKo+yEVUEI/VM9wPq2iHc1NGfA9D5CN3bryKbd1B8sOYZlrPg1mwp+kIbgy+nqeEjjWq
         n27No5pg+ybtZZGE6loyg0jafCdbnO8IqTuMq6fOeeExUS8sEnwYNtfg7uHhNPS+Z4sJ
         s3ReapiAdpmq1jEiYk8IAWN83LUHSjkSn5Mtg4ZRCLjBc+aLw469v3CHTJLTul731KNp
         fIqsB+NqH6OtsxHvS+DmPNjirJS5wy6Pw1tbcbGm23i01URA8nvlmIljUjkyP4VUV8yw
         I4cA==
X-Gm-Message-State: AO0yUKVT78Y6W6Z1IeaZpnzqdVz/4CQARGRAx4tv7VDLxskq5yxiiIXo
        wrGnY4jibUae2eHaZDj/CoH6W87ZC4VT4vlr0e3vc5RqUMs=
X-Google-Smtp-Source: AK7set9nS0fut9ZHNQz3fcL8p+lHgP7tH2A5aHREwYFWjxICRgHFV2ZrlN0YGwlc1x7JdnLrAVb8QDOc7T+rKG3O+i0=
X-Received: by 2002:a50:9f28:0:b0:4ac:b7c1:9109 with SMTP id
 b37-20020a509f28000000b004acb7c19109mr963146edf.6.1676146044196; Sat, 11 Feb
 2023 12:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20230210170721.1285914-1-christianshewitt@gmail.com> <20230210170721.1285914-2-christianshewitt@gmail.com>
In-Reply-To: <20230210170721.1285914-2-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Feb 2023 21:07:13 +0100
Message-ID: <CAFBinCBC1ES1waLyYjUyOyK_d3DzoUhnQ80_rT3SBrMsf6p3PQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: meson: gxbb-kii-pro: sort and tidy the dts
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ferass El Hafidi <vitali64pmemail@protonmail.com>
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

On Fri, Feb 10, 2023 at 6:07 PM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> Alpha-sort the nodes, move the default line in the LED node to where it's
> normally found, and remove excess spacing. No functional changes.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Ferass El Hafidi <vitali64pmemail@protonmail.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
