Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7C070FF74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 22:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjEXUty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 16:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEXUtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 16:49:53 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D8110B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 13:49:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso1444379e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 13:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684961390; x=1687553390;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhCcbiMDeimZgRsX8GeS67PO3y/8MJ5nVThqdM2u2S8=;
        b=a6183VQoSnm61M8xRWx9/75KYWUsFX46HC+7vufK9YfLfomSLuEY2LDasUTwVv6wBI
         mYNg6RruGwEPtNteV/tYs28bn+oySMN9zUeLT5hFZDj0YqYxfX+SLj6Tig3o41tS3vse
         7Lsv1EED+ki0LYidxA+7QAiVpjJzK32Y8oPf1IHw80WuTVwRiqu7xfgqu/mU/f/aBcSk
         1J0XuRPqP2wSZ6ylTcSWkvRjEYRi4XiC5yevJieVN/fUz06IaqNSAxy+Ay6jTBGMkJOU
         YYTJakJo+TQJBPbjWRHNCVOkCCp36U7RKckRZFXj1GIX7k1OaiIYXLioPZ9v7CZIWYjh
         9jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684961390; x=1687553390;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhCcbiMDeimZgRsX8GeS67PO3y/8MJ5nVThqdM2u2S8=;
        b=Eb9o6kRWDZaQTZxaz304Ka+I3FC5kAGdu5PUt70RXRALMelsjTNAJZ9fW6tQlLH3pJ
         Nu8clGIZnIeocCskssP6o2K2J0VAzkxJhhD99A7NNXFKAKBz1dwtqjFKuEgM3V9crEWi
         lrV9O1pzURXXSrzFOWiVCpoiX+vjDXDKT2LS1hLG1bbqfkCGuIz2tUkHi8lfUGSfKUQ6
         1P9ofF+ZqBADg9CGg2kKhXz6AKjLD7hKoKU5bWkqUmrM2gXIpprFVcauYUKoVDvJtOpq
         RrVzf+8ShAOpAM9hS8GgjKYRcN/CLoHAzA9SlrS7VJBXxgZDQMyaxozfvG6BQbm+ZqY/
         y8vw==
X-Gm-Message-State: AC+VfDxXXzK3C4k6g2i7kRlWjPk63NbdMk7jPqVeUYFAqIbn5BD/3/bt
        tSK8LAjKvBCPG4j3Cn7H5bn32qeT+80kGA9bk6M=
X-Google-Smtp-Source: ACHHUZ7DU/8bhXhtrcw7t5vMw2s4J8znp+eYxzusiHyLIP7/3/tMmWgVtCv0tT64e96JtJNp9LjKMLUHclLR0JvLPX8=
X-Received: by 2002:ac2:47fc:0:b0:4f4:b47d:5c07 with SMTP id
 b28-20020ac247fc000000b004f4b47d5c07mr2629800lfp.46.1684961390122; Wed, 24
 May 2023 13:49:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:4254:b0:258:f5f3:a127 with HTTP; Wed, 24 May 2023
 13:49:49 -0700 (PDT)
Reply-To: samuelkelliner@gmail.com
From:   Sam <gerrypricebigbustours@gmail.com>
Date:   Wed, 24 May 2023 21:49:49 +0100
Message-ID: <CALN4VLGcCcwoOhqTNH8=Jmkp-+PjN91-nMEH7HOgqrCAxGP0-A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,BODY_SINGLE_WORD,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I am aware that the Internet has become very unsafe, but
considering the situation I have no option than to seek for foreign
partnership through this medium.I will not disclose my Identity until
I am fully convinced you are the right person for this business deal.
I have access to very vital information that can be used to move a
huge amount of money to a secured account outside United Kingdom. Full
details/modalities will be disclosed on your expression of Interest to
partner with me. I am open for negotiation importantly the funds to be
transferred have nothing to do with drugs, terrorism or Money
laundering.

Regards,
