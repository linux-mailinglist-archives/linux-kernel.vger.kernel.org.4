Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9B572037C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbjFBNg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjFBNgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:36:25 -0400
X-Greylist: delayed 1515 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Jun 2023 06:36:23 PDT
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17285E7;
        Fri,  2 Jun 2023 06:36:23 -0700 (PDT)
Date:   Fri, 02 Jun 2023 13:36:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1685712981; x=1685972181;
        bh=NRGchtLxh/pDAhu/N6OG7r6+gfYDUQwYJ2aFLIaPuIY=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=EpsRzqfTZ7tTBDhxdn2tRU+BMJOsq1jTIr+XYyx8unS64mMiLOn9dwUpGUbDBmWQN
         SmIZAlulH9zYkLxti1KbAxMxBrn/qHd1Reif1m0CLM0hJLkTYSaKjNLfax7KH512Mn
         z5J9gdYiPaLV9anarWYQUjJlreSzpZjGY4QdNLWMxMMUobLgaiWejKMQRx4PNJNcxR
         BEDtAkDhauXdapYtqL3MOXNFexlLzPE/5xyk/YJRiU9y0hUDLD/Cx2ztlVKcYByFbF
         kynY3YylfyL6whGd68YISyIPgGEcZCZUMJVBRdM951xQa1X050GyNfolwipOMckIUv
         W8IH7q+rPoeiQ==
To:     open list <linux-kernel@vger.kernel.org>
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        "open list : LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        "open list : OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Raymond Hackley <raymondhackley@protonmail.com>
Subject: [RESEND PATCH 0/2] leds: sgm3140: Add richtek,rt5033-led compatible
Message-ID: <20230602133533.260502-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richtek's rt5033-led has pin configurations similar to sgm3140.
Add it to the compatible list.

