Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F556D35C2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 08:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjDBGNZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Apr 2023 02:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDBGNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 02:13:22 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FED1D86D
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 23:13:20 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id y4so105448892edo.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 23:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680415999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zav6H2f6j8aOZ1vAy2MUTnnZzBeuhe5sWiReBikCE2k=;
        b=NrHSbESbY9XUwA3OpmqGWJ9/jSjYEwPiQP1pLlIA77r5ydF8AzWKkFsWw5PYzXxpps
         gq3n9JNfCKcLMhnZb0dAjO1C5UswHGmFnjhy7nRhWa06DuQY5FnCstG0OmFVy6hxjlNR
         5+pL6vaDO4oZQhMupLupmv9tfeTrrK2BJ3JanEPfo1Y96yK1AzwDUUmNdLUhjyAiS7ah
         us2Fjn/onu3eBDb3Q5tTUJ8E8P3bU1w46z7U/EWSCyTs/k+4TwJm2K9vCbvbDBIm4OtZ
         GnBrmIfnd6ki3AHr1PDJk9I1XTdByuruOoMmFHWd3pD2ndYGWBK1LRUJ+wUk+u1WXWOx
         075A==
X-Gm-Message-State: AAQBX9ega6PKb5b2U+UEZSgN/L9HcjA+pkIca1OUBD8fdPlY457W/JjB
        ycpqe2HZDtr2/OaghxACu12l+c2YJuruvg==
X-Google-Smtp-Source: AKy350b2IpYJuTjtNygpK8f+aIEhOPj2RIoIY+Rdx7uNBpgNGyyNCVyE+waZ3VYAwNgYU0U6bnN/dg==
X-Received: by 2002:a17:906:a3c4:b0:906:3373:cfe9 with SMTP id ca4-20020a170906a3c400b009063373cfe9mr34163291ejb.10.1680415998756;
        Sat, 01 Apr 2023 23:13:18 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id q19-20020a170906145300b0093e5baadfe6sm2830755ejc.204.2023.04.01.23.13.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 23:13:18 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id m2so26208038wrh.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 23:13:18 -0700 (PDT)
X-Received: by 2002:a5d:591c:0:b0:2ca:4533:5d6a with SMTP id
 v28-20020a5d591c000000b002ca45335d6amr6560075wrd.7.1680415998031; Sat, 01 Apr
 2023 23:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230401001850.4988-1-andre.przywara@arm.com> <20230401001850.4988-4-andre.przywara@arm.com>
In-Reply-To: <20230401001850.4988-4-andre.przywara@arm.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 2 Apr 2023 14:13:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v64nm8pNK2bQ3fv=ZRFjc2sOGs7bRgekSZk=Gb5zcT=bPQ@mail.gmail.com>
Message-ID: <CAGb2v64nm8pNK2bQ3fv=ZRFjc2sOGs7bRgekSZk=Gb5zcT=bPQ@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] regulator: axp20x: Add support for AXP313a variant
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 1, 2023 at 8:19 AM Andre Przywara <andre.przywara@arm.com> wrote:
>
> From: Martin Botka <martin.botka@somainline.org>
>
> The AXP313a is your typical I2C controlled PMIC, although in a lighter
> fashion compared to the other X-Powers PMICs: it has only three DCDC
> rails, three LDOs, and no battery charging support.
>
> The AXP313a datasheet does not describe a register to change the DCDC
> switching frequency, and talks of it being fixed at 3 MHz. Check that
> the property allowing to change that frequency is absent from the DT,
> and bail out otherwise.
>
> The third LDO, RTCLDO, is fixed, and cannot even be turned on or off,
> programmatically. On top of that, its voltage is customisable (either
> 1.8V or 3.3V), which we cannot describe easily using the existing
> regulator wrapper functions. This should be fixed properly, using
> regulator-{min,max}-microvolt in the DT, but this requires more changes
> to the code. As some other PMICs (AXP2xx, AXP803) seem to paper over the
> same problem as well, we follow suit here and pretend it's a fixed 1.8V
> regulator. A proper fix can follow later. The BSP code seems to ignore
> this regulator altogether.
>
> Describe the AXP313A's voltage settings and switch registers, how the
> voltages are encoded, and connect this to the MFD device via its
> regulator ID.
>
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
