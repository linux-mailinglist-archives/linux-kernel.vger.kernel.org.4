Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24436013AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJQQlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJQQlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:41:10 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4871B11A28;
        Mon, 17 Oct 2022 09:41:09 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e15so9558679iof.2;
        Mon, 17 Oct 2022 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DamKCJLW3tTsBfqwD9kkmTLCFeiTbmAoAgz1S7Xzwdg=;
        b=Qws+pPvptHePuA+pLf2zNgfIGhd+UWEUmyc8kUih72SDW79Mxp6WWHvQozTh/kzdot
         4od3cmUCxn5kimNpXZWMJ1gGczdITAKjJlW6g/j3uPMUCnwJT4xnUbSrVRwN0aHRt/MM
         JTosRObKCJVAno5bV2sKPQIjih4lf8BaBLl7ZskzQd62inc117lcV83IETPjKog4KAYa
         LZWTm2uY+XnZXWTXUtbLCD4QuQbn6j7pRzU6ugwaydKGbtf/S5h1gFxjIZ1oMRlnmYXG
         DSW5ThxGzwM5AmYdyIhb4g0f88brQqK/UnznImvNZUuwo7mbbJ7CthZVqjoF6LpkXiXN
         0jmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DamKCJLW3tTsBfqwD9kkmTLCFeiTbmAoAgz1S7Xzwdg=;
        b=wGi4OCULD5GaQMC7wfX9QoLyCCHj6B5IexBXx0KGX1krc/va+sQXi0FeccYxi/T439
         RJkK8oEKSG7j8xnWj7X2Ghdk+8AYg2qy9PQFpO1gSRqtI9ldNnZEC5eTaYFRpBoqfXgH
         QQ67UIeqMzNhCJEM69yzk94ViB2VCUDnseTPHZoObw2Usww3bHZVnvxeVTUPGKTDT5vk
         w3K2J4nIAmBqXh94A6RdjvgXNpBHuVXZzEdpg8z0QJEKBz/uM4QeVjBeazMhCyLT48fg
         RrVXOBgxTqpivuffgXKHjJRfrzJSlJ7xEMXYeri9ww14wFSjWRf2cpl7EYDp0sNiz3Qw
         fKJw==
X-Gm-Message-State: ACrzQf3tbeOOPRUHjk7b2FiD+h4R0rmVX/095xVJ0e+mQ63qRQNfvG79
        awdlLPikg1xqkZN9l/m4xM5mk8w7JvaChMfrA5dGyycbCI3wvAyi
X-Google-Smtp-Source: AMsMyM5s0ew/RC0GUG4fMHPyD21cXwutfLOdm5rcHDG4Bc8YDkiqY0racuaH+pRMKltAuJL0QtBdRiRuB59ixhpuuUM=
X-Received: by 2002:a05:6638:3c45:b0:363:afb2:3269 with SMTP id
 bg5-20020a0566383c4500b00363afb23269mr5546294jab.215.1666024868675; Mon, 17
 Oct 2022 09:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221016150110.3020451-1-lis8215@gmail.com> <20221016150110.3020451-2-lis8215@gmail.com>
 <K44WJR.2LW3IFMAMTV73@crapouillou.net>
In-Reply-To: <K44WJR.2LW3IFMAMTV73@crapouillou.net>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Mon, 17 Oct 2022 19:40:57 +0300
Message-ID: <CAKNVLfax=BGULaq62tSGyVOkR8vC5yvd71ovPHxq4zJqykoKrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] MIPS: ingenic: add new machine type MACH_JZ4755
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D0=BD, 17 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 12:10, Paul Cercue=
il <paul@crapouillou.net>:
> I see why you include it, but you do not need to have the MACH_JZ4755
> symbol defined anywhere for the "default MACH_JZ4755" to work, it will
> just default to false until the patchset that adds JZ4755 support is
> merged in the MIPS tree.

Thank you for the clarification, Paul.
Will be done in the next version.
