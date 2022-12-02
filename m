Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1D7640D0F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiLBSY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiLBSY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:24:56 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6F4D80C3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:24:54 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id k79so5641969pfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 10:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8xc1awsQJmhg6vB1XWcio8Inqx7vu6jIuLFBZEo1A8=;
        b=4pjhZUHY7jgCHHc1omjoQeudgyL8H37B7bpLBJViXZRNUyXte5mswTZNsWPwJMwAjy
         PJ3hAs+SRn5Bx0xeg0eCz63Rmapn7Bm6kBbO+h89LrI1GE6Y+wZ9Px1Ad+qGVQxqmNyD
         0/zbX6AkaNBUUIHJB81ysnzJZvB787eJqoj7ug4nQ/UiQ5SJNrLKeb2Tx60Jv9XWQnbW
         MajUTbGdYmwJdC7b1gJW94hpBqxtuRE2sA+AF81VP8RNtk7dYWl6YavNo6M/EPMc75Xi
         y81RHrOZYhfQGnH/LGhlSkIh1+HdjzjEI0fLCEl+qaI4wG5wZ2zcM9XzWsjGtFDYRbxi
         fqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8xc1awsQJmhg6vB1XWcio8Inqx7vu6jIuLFBZEo1A8=;
        b=XuM7esTNAVGW+S/QdMoyr5MMGKMUI6pDXdM13jAZumwTTIxPvoeLfuZL/q0JdzJR8w
         8RT+wR88pHxBAiasZb+W+/FniN/VUNHl7y7s/aQZrs9sl4yKADhvyc7MyPvUnTrsmINh
         MTUzkItwSMJJybFxQCG+9yZz/POzbX+lwHFzrEQ3puwR/6BINw4c7Wb0lvh+N85E1bAE
         voYqNeKnnpmu6KOJ+hSAb4CigjpsdeY/6+HmTOywg3ytew8llzZrMub39A9mZAJe6dwa
         KaYZ4YCEejBfHoenTzVn7WbRyqr93jTTxgCZTD56RM2mWabTHZJygnZXYaNlL29BUyc8
         /3XQ==
X-Gm-Message-State: ANoB5pmMWovlvmJcsvC93YElX3Jnv3Ra8SMRnk6mKeF9IAljFiEYuMBZ
        ZeF9+ciEDn+b6W8mzcDvoAKzUA==
X-Google-Smtp-Source: AA0mqf6Fh4zQrJYos5uGsnmHePnkUgEdVggdPbeQSMN5MDI6BNBsEsLWa93IQMcOp2Y0+0k9g3NPXQ==
X-Received: by 2002:aa7:87c7:0:b0:562:a27a:4a84 with SMTP id i7-20020aa787c7000000b00562a27a4a84mr55730090pfo.50.1670005494008;
        Fri, 02 Dec 2022 10:24:54 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090a31ca00b0021358bd24b9sm6933147pjf.21.2022.12.02.10.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:24:53 -0800 (PST)
Date:   Fri, 02 Dec 2022 10:24:53 -0800 (PST)
X-Google-Original-Date: Fri, 02 Dec 2022 10:24:44 PST (-0800)
Subject:     Re: [PATCH v2 8/8] RISC-V: defconfig: Enable CONFIG_SERIAL_8250_DW
In-Reply-To: <Y4pBbVQgcTmS7NLa@spud>
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
Message-ID: <mhng-a6f218e1-cfea-4681-bd66-14678510ed7c@palmer-ri-x1c9a>
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

On Fri, 02 Dec 2022 10:18:21 PST (-0800), Conor Dooley wrote:
> On Fri, Dec 02, 2022 at 10:13:40AM -0800, Palmer Dabbelt wrote:
>> On Fri, 02 Dec 2022 10:07:33 PST (-0800), Conor Dooley wrote:
>> > On Fri, Dec 02, 2022 at 10:00:35AM -0800, Palmer Dabbelt wrote:
>> > > On Thu, 17 Nov 2022 17:17:14 PST (-0800), hal.feng@starfivetech.com wrote:
>> > > > Add CONFIG_SERIAL_8250_DW=y, which is a necessary option for
>> > > > StarFive JH7110 and JH7100 SoCs to boot with serial ports.
>> > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> > > > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> > > > ---
>> > > >  arch/riscv/configs/defconfig | 1 +
>> > > >  1 file changed, 1 insertion(+)
>> > > > > diff --git a/arch/riscv/configs/defconfig
>> > > b/arch/riscv/configs/defconfig
>> > > > index 05fd5fcf24f9..a23d022974ad 100644
>> > > > --- a/arch/riscv/configs/defconfig
>> > > > +++ b/arch/riscv/configs/defconfig
>> > > > @@ -122,6 +122,7 @@ CONFIG_MICROSEMI_PHY=y
>> > > >  CONFIG_INPUT_MOUSEDEV=y
>> > > >  CONFIG_SERIAL_8250=y
>> > > >  CONFIG_SERIAL_8250_CONSOLE=y
>> > > > +CONFIG_SERIAL_8250_DW=y
>> > > >  CONFIG_SERIAL_OF_PLATFORM=y
>> > > >  CONFIG_VIRTIO_CONSOLE=y
>> > > >  CONFIG_HW_RANDOM=y
>> > > 
>> > > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>> > 
>> > Hey Palmer, could you take this as v6.2 material instead of Acking it
>> > please? It applies to the jh7100 stuff that's already in-tree.
>> 
>> Ya, no problem.  Just this patch, or the whole series?
>
> Just this one defconfig patch please, the rest is not ready.
> Sorry that that was not clear,

No problem.  It's staged, it'll end up on for-next when it builds (it's 
behind some other stuff right now).
