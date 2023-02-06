Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BAC68BB0B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjBFLMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBFLMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:12:41 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B891EBC8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:12:40 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id d66so12204011vsd.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx0rL/jZPMLeHFNkdGq3B0lHEAtTAwxRwYVBdLrzGf4=;
        b=RpSQ3qkKIePil2cxOGelPztIhxlANWmbbwU9RhBul5avvUPj+q0M4uLMEDT1sHKyEz
         mjG/rfEWMAlTbf8tcDgE3qtg1IZh5leZoM6yiEzP+c3SziJCoQzPCVrZT7H7+zBMiFqf
         B7aDf+yrPUXxtDA7GvjM0Qk87Haq0JB4MmbXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dx0rL/jZPMLeHFNkdGq3B0lHEAtTAwxRwYVBdLrzGf4=;
        b=FdsxFu8MtETxrMYRqFvjaqMQMikM2hskysMWWhd7/GZdNf4owjWu6By58o853RSusJ
         IWBoR0J1E0n7cX2FNpu9Oi1XV+3ap+tk/PnIPMuoTxx4sT19dPlSUbAeHflyjhwcS0Dh
         lG2xnUdtH3k3658G/S7LcKj/wT5BXIcoiLRxznD0CP5Qyssh4lh+VmcYbglhPWT7r6WP
         Mp8PHVHVtNzvZ1eZOvHRaAid6QoyIeKwfVvZ2wlippW15Pg/RrbesGHaTsyBarPurAXh
         YbJzbUvE2QpX7H8y1pjgMNelwI4O1CQ0OUGHbr0sPsI7uOUUF93m2fiysI8AUZHajAFQ
         ZpXA==
X-Gm-Message-State: AO0yUKVmyOgz/Y1zlSE+m66tll0odCvtL8HfyYjKUPESGeET4RsjjkHD
        90os1VGWGvqXVL7nLrWme3bA5fRe5PJbRjJL/bhM4w==
X-Google-Smtp-Source: AK7set9deAUpwZvkISTP2kzU9X7LTaqj94p/drhOTgA6z/VsK90cwJfx1qsalSnu41+dWRZbIWESyD/aiCDW4pwFflw=
X-Received: by 2002:a05:6102:322a:b0:3fe:ae88:d22 with SMTP id
 x10-20020a056102322a00b003feae880d22mr2920661vsf.65.1675681959294; Mon, 06
 Feb 2023 03:12:39 -0800 (PST)
MIME-Version: 1.0
References: <20230206091109.1324-1-moudy.ho@mediatek.com> <20230206091109.1324-3-moudy.ho@mediatek.com>
In-Reply-To: <20230206091109.1324-3-moudy.ho@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 6 Feb 2023 19:12:28 +0800
Message-ID: <CAGXv+5G+VSV=NLF9-+Z88JR+Cr6t=RGweZ88DA6VJN7-aoAqVg@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] arm64: dts: mediatek: mt8195: add MMSYS
 configuration for VPPSYS
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 5:11 PM Moudy Ho <moudy.ho@mediatek.com> wrote:
>
> From: "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
>
> With the change of the MMSYS binding file for MT8195, the compatible
> name of VPPSYS in dts need to be fixed to match the definition.
>
> Signed-off-by: Roy-CW.Yeh <roy-cw.yeh@mediatek.com>
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
