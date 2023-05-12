Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FCA6FFE28
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbjELAvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjELAvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 20:51:49 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7532D74;
        Thu, 11 May 2023 17:51:48 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-517ca8972c5so1443182a12.0;
        Thu, 11 May 2023 17:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683852708; x=1686444708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSvXlr6Dx/DDUPBEvkh2YmJaTsZTpG10bnm/L/vSKLA=;
        b=JjlYWl7VB84ikfJ/EuBoHo5EMHUq2l/JkAEq/7N3Vr/3krEQJTL0WBuqnL6jjXTQZN
         AJ/IWvO/7FCI1Kb+g14p/0ELEylbsBv6kfE4VWOUmxf5vB8FaYcCJCO+osmm1NfIEz79
         mPwp+/6Z+efO/bMekQz9fdOtHT4EycIZ/sEWd0lwF623qK0q6AHIeRalF4bBgbwgnXeX
         ON/aK8EAic8vZNbgsLCMuzU8Vrn90if8q46VrHVVcQltNzXBjvM4CjcCpEpiH9rPKFAn
         ohAXqrQzkA2pzgb9tNkkwi9yuqIdFvKDmuVlIDmvmpcArewMYC4Gs4rfBb0wCHwzjAKk
         xlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683852708; x=1686444708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSvXlr6Dx/DDUPBEvkh2YmJaTsZTpG10bnm/L/vSKLA=;
        b=UbFhyiTqREyGS32ViA6GM3fCWSLNjciwGZRj9ihzMWM/jp6+YnWr3o9Yn/wzTPTWT2
         KLgI8bZRP7/LanRLxmq8kNCYCmJ7wNj/C1t3vV/FGnk6q/5DVvBrOvC82DJhXZPYx0bS
         2wvyH6g+kl1SD5OF7hfKmc16xLKeLEwKbpkA4AwMFQzHt13h0XRpDRpqLJZ3Oh+ZdFvm
         Glj/AgLRoZMJ38lxTjXxAT6Uv4hf5Ep5VYuXAFN5KQUBT4uVP4Oe1QL3AtHzVGXDdcYf
         6RWamjseMpB0w06Fe0rFEVjXy6fIho6sWU1J35YUNNLFOjDHudLs6Zm9Mi1l1Mt3qmki
         N3Dg==
X-Gm-Message-State: AC+VfDyUXAkonJaXdqsK80b4t/w69QfbNt7PKTBSm5o8Wz2gouPrDHl4
        QVwjB/1JGkUp69/RLhPvGNG65JnQmT7NvKUYej8=
X-Google-Smtp-Source: ACHHUZ4CAJaVmP2fHTenrbQJ++d3wBkxIKpL9Dv81o4C7wJVz1VX+jKrdgJ/3CJR1KPEiuOorZeNIqSx29pj5cD0BYI=
X-Received: by 2002:a17:903:2343:b0:1ac:656f:a68d with SMTP id
 c3-20020a170903234300b001ac656fa68dmr22470107plh.4.1683852708064; Thu, 11 May
 2023 17:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230511135632.78344-1-bstruempfel@ultratronik.de>
 <20230511231317.158214-1-bstruempfel@ultratronik.de> <20230511231317.158214-2-bstruempfel@ultratronik.de>
In-Reply-To: <20230511231317.158214-2-bstruempfel@ultratronik.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 11 May 2023 21:51:36 -0300
Message-ID: <CAOMZO5DMw-ETS_ZZSTvksPZPi41w85x4o-VE8jHebDFJc14HTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] spi: dt-bindings: Introduce spi-mosi-idle-low flag
To:     Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     bstruempfel@ultratronik.de, andy.shevchenko@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 8:14=E2=80=AFPM Boerge Struempfel
<boerge.struempfel@gmail.com> wrote:
>
> Some spi controller switch the mosi line to high, whenever they are
> idle. This may not be desired in all use cases. For example neopixel
> leds can get confused and flicker due to misinterpreting the idle state.
> Therefore, we introduce a new spi-mode bit, with which the idle behaviour
> can be overwritten on a per device basis.
>
> Signed-off-by: Boerge Struempfel <bstruempfel@ultratronik.de>

Please run checkpatch on all the patches.

The following issue reported by checkpatch needs to be fixed:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Boerge
Struempfel <boerge.struempfel@gmail.com>' !=3D 'Signed-off-by: Boerge
Struempfel <bstruempfel@ultratronik.de>'
