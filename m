Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49096640CDE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiLBSNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbiLBSNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:13:42 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEA4E802E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:13:41 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cm20so5678622pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 10:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=td4xci5diB4fq00DG+7VzeBznbBu3BTL2nUPPpTbtak=;
        b=znwv0rWJ35Zi5rd78lBnOWAQjqe71CNHUDvpy9+X6MQkTVdLvFe1vt80DYaX0q60gZ
         tLDjuYOEIZLjchfjdb/gv0Wi3N8fnWmHVp9Lu/u2jyc4xTeTD1ypkp2d+F0FlU4UltgZ
         4HwpCwGKxIELgDtemo5W5GifjlJwAK5wTa3BrRJ2hWdU3YCtDB40axA52e9WNfZHio9T
         ZIW5PXoL1Phr0KeqvXZBONGDEBAi6V2NhLi1JgwoLgWTfloruPYHNHqRGiLUmwVKDUIh
         yxKQzKVD+5KY4WCL/LkdM8K3vPOvro2Edv/AZWQRzYMXsBj0lM4gr220L2f1mQ6cTps4
         OXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td4xci5diB4fq00DG+7VzeBznbBu3BTL2nUPPpTbtak=;
        b=qgC9tyazEtbV4er5Ew8qKjGIGzt31rwk3iJxiwyAuDmRQ7fN2brL9MO/TSbatbpWt0
         Ix/qKwiqlgpl2tIR0zq7Obgfixilw0m0txTXgtxaU4TTsab1LIoyGYYxIrqyUQ6aHtJl
         tnYgdjzkM+4IA7hG4UdJoaCt+rRuVOI1eEB81YbrXk4kOkfS8x+Wti7RHv4OKKa5d37j
         RtlXRiqqyK+1gXDrKriWE1TqyayAYR2AxxH2TVwc+9sKt9FmBeZv+omKrQxG+68WfF+W
         S6pV2iAnOBLJz9/ARuCDR7sqFb+3s8rZVSheII60xZs4zXZURc+fXvV49vZWluWlnYT/
         BlqQ==
X-Gm-Message-State: ANoB5pkZfJRJhtwW2w/uBNg7SBpXk2eKZj8UzgyEL9p7f6n2wtX1rtzK
        Tp3cUK4440mJy9UT4/G/9kutcQ==
X-Google-Smtp-Source: AA0mqf43J8lPrptpkCkbq/DYOD09yooJAY9HJ+V6haZEp7urNBCX5HoHqSVnhtgTwlX3obMkTG3ztQ==
X-Received: by 2002:a17:902:e3ca:b0:189:a11e:9994 with SMTP id r10-20020a170902e3ca00b00189a11e9994mr17778649ple.54.1670004820918;
        Fri, 02 Dec 2022 10:13:40 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id w80-20020a627b53000000b0056d73ef41fdsm5396669pfc.75.2022.12.02.10.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:13:40 -0800 (PST)
Date:   Fri, 02 Dec 2022 10:13:40 -0800 (PST)
X-Google-Original-Date: Fri, 02 Dec 2022 10:13:30 PST (-0800)
Subject:     Re: [PATCH v2 8/8] RISC-V: defconfig: Enable CONFIG_SERIAL_8250_DW
In-Reply-To: <Y4o+5ayW0vHcmvo6@spud>
CC:     hal.feng@starfivetech.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ben.dooks@sifive.com, tglx@linutronix.de,
        Marc Zyngier <maz@kernel.org>, sboyd@kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        linus.walleij@linaro.org, emil.renner.berthing@canonical.com,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-2ff22bb7-a48a-4434-b498-1f928e75cd01@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Dec 2022 10:07:33 PST (-0800), Conor Dooley wrote:
> On Fri, Dec 02, 2022 at 10:00:35AM -0800, Palmer Dabbelt wrote:
>> On Thu, 17 Nov 2022 17:17:14 PST (-0800), hal.feng@starfivetech.com wrote:
>> > Add CONFIG_SERIAL_8250_DW=y, which is a necessary option for
>> > StarFive JH7110 and JH7100 SoCs to boot with serial ports.
>> > 
>> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> > ---
>> >  arch/riscv/configs/defconfig | 1 +
>> >  1 file changed, 1 insertion(+)
>> > 
>> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
>> > index 05fd5fcf24f9..a23d022974ad 100644
>> > --- a/arch/riscv/configs/defconfig
>> > +++ b/arch/riscv/configs/defconfig
>> > @@ -122,6 +122,7 @@ CONFIG_MICROSEMI_PHY=y
>> >  CONFIG_INPUT_MOUSEDEV=y
>> >  CONFIG_SERIAL_8250=y
>> >  CONFIG_SERIAL_8250_CONSOLE=y
>> > +CONFIG_SERIAL_8250_DW=y
>> >  CONFIG_SERIAL_OF_PLATFORM=y
>> >  CONFIG_VIRTIO_CONSOLE=y
>> >  CONFIG_HW_RANDOM=y
>> 
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> Hey Palmer, could you take this as v6.2 material instead of Acking it
> please? It applies to the jh7100 stuff that's already in-tree.

Ya, no problem.  Just this patch, or the whole series?
