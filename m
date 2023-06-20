Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA23A736698
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjFTIrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjFTIrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:47:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE93E72
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:47:34 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b543f7e53aso26911705ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687250854; x=1689842854;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueeNmXLgL8Q8VXtOUJoTlXmDP/YXd6DJFqwljM7wRQM=;
        b=Ic/41i0FlfukxsO9jI/sHBRNDRWp7XSspAmnMbjKp5MOGJlUtlyGbtr0Bzm363IrEW
         7or/WVL8CZGHo1zUyY7BltSiYVmFdT0eeYw+xwhWO7+ztexN1Tcya/sD10o0bQDM0UPY
         n+xWxFL6R/eXbsBwYrxUjLaxhTthBBVeLv8+EeX+wss/7jtl4C+diF3GSu8Jok4katir
         jMgW2HxO9xlLRKrdB0CMtJQSt7fZ71ClqUwFbavF69MlGFa67GWJhesnwu0ea4V5Db4J
         humLyJYqGfLvd+zbv6hDy70JYUSNtc2lKrTCTLUEptW9AKPwdZPKiKKwuOxhfwVwY2+1
         2UOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687250854; x=1689842854;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueeNmXLgL8Q8VXtOUJoTlXmDP/YXd6DJFqwljM7wRQM=;
        b=DYZa3ALrMwINyPss2YAp2QealHyBNm5E8SnjVjD2l1ANBuZux2S4NOiNFVsVzejU6b
         Hq73Hv6ic0aE9W6lzkECCYc1Uh2Xr7Sv6G+JEOhrabo6K0XSF5xeB65DcqZYWhPEFbvV
         8lsjk6aiJ+GUc/3dRecR30IY9YzujZHHEAAC/n8ezXYp9RqkVAwEjWU+TgLfLe7b17E9
         xkA4d+IkcaTrhnH2Zz557M7Fs/Y08dWZA4BfLO88T7N0xoTVSF+V+S7a6YX7ryN6+D5q
         uN5g3bzskk3LMEB0pcEx6W4QrIYgvg1Xhd2dS9d9Bg8DK2qNPzyUgTBWobJBfmn9EaM9
         rz+A==
X-Gm-Message-State: AC+VfDwkpbPeXA8TyITCi0epCI+GEfZRL8lt+GKwAkur34CGOtqYmcgn
        +VP3kMT4XhN+/XArS9vafxKk845PVSsqpsy/1Ic=
X-Google-Smtp-Source: ACHHUZ64iB6C0WRn8v04ak9qofqiohe5OLjT0SQDwlfuIr4ICzTiRxlf5a0qgFd/IzVVvRUZvwEIUGFeaovOL4cVGWI=
X-Received: by 2002:a17:902:bf07:b0:1ac:451d:34a with SMTP id
 bi7-20020a170902bf0700b001ac451d034amr10864773plb.33.1687250853891; Tue, 20
 Jun 2023 01:47:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:b7c8:b0:1b0:4c70:d690 with HTTP; Tue, 20 Jun 2023
 01:47:33 -0700 (PDT)
Reply-To: zongokatyh@gmail.com
From:   kathryn zongo <mrkhamoriyaad@gmail.com>
Date:   Tue, 20 Jun 2023 08:47:33 +0000
Message-ID: <CAPe-WvBj5hY430XWTcKZ7UpXbTezLqKsdBsCMzknM8rQH3ifqw@mail.gmail.com>
Subject: Your swift response is highly needed!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear Nice to meet you, Am Miss kathryn zongo, very sorry for the
informal manner in which this letter is reaching you as it was
necessitated by my urgent need to get your response.
I came across your email from my personal search and I decided to
contact you and I've something very important which I would like to
discuss with you and I would appreciate

 if you respond back to me through my email address as to tell you
more about me with my
photos, my private email as fellows (zongokatyh@gmail.com)

Thanks
Miss kathryn zongo
