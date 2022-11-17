Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F6162E893
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbiKQWjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbiKQWjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:39:12 -0500
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB5B8DA4B;
        Thu, 17 Nov 2022 14:39:10 -0800 (PST)
Date:   Thu, 17 Nov 2022 22:39:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668724748; x=1668983948;
        bh=gWBsEHP+8dLHoXfYc95d09Xo3xz2BaOFXCljQcHLH/A=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=qDAGGL1JRa0p73hyKNfJLxJH41zn5VRBVnN5PeGhh8y+bFtADgi38Cmlffn1kkJkF
         moJPnpF+WczR8idYoulZl0usk7xfXOQABINy3XOBHtGy/ekwiEZaQ2bYpSv4qegImc
         f4Lo34IG6P9ybvtp6+5qmGMOErScyCKxWTrNTeIvDsLN1q4V1ZNrYJwmTk3EHppSom
         W37vmUL3lNuZKKg/qEK8/6AZ+2//1PY5j/ihVRM0AiXxonWCww6FKnEDkayhEGNgr6
         MBlTfwvI+A4uuS+2LCpNSNYP6B1c/1DCAgU7+j0dPvMQfeii0dNBNI5/AHre5wFxow
         eObpEDmL8lqFA==
To:     dmitry.torokhov@gmail.com
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     alistair@alistair23.me, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linmengbo0689@protonmail.com,
        linus.walleij@linaro.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/2] Input: cyttsp5 - add vddio regulator
Message-ID: <20221117223850.187999-1-linmengbo0689@protonmail.com>
In-Reply-To: <Y3ay6zgq7JiWDR/Z@google.com>
References: <20221117190507.87535-1-linmengbo0689@protonmail.com> <20221117190507.87535-3-linmengbo0689@protonmail.com> <Y3ay6zgq7JiWDR/Z@google.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> This needs binding update.=20

Please have a look at the binding update in
https://lore.kernel.org/all/20221117190507.87535-2-linmengbo0689@protonmail=
.com/
if you don't receive it.

Regards,
Lin

