Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49F36DD7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDKK17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjDKK1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:27:55 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0C313A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:27:54 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w19so5060478oiv.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681208874;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qr1B0YLHtlPfuVF1isNa30fHO51jM0otPP8Nkg4q54=;
        b=nMsqOOJtJo9GiZlsBnmas9ZkqM/sxF2BJzcH71Z4yvmRfBaxAFO0kQH6248eMPW/YM
         xd5bw1mk/nNTs2hSbF/iHW+KimvRHq8xsIbTsbJcqKI4SJR5fG1CG26gWey+zZhBHZaK
         ju2WjLIEm7fKAkzvDuIkl/Aa0xIxsiqHNKac5yZzYxLw03AgnJ5lLMbfdj7kT21hLvEy
         i4K6y6PjGFG7UTUtVulLtG/NXDWFQrrtbjmEY7fXprZWTuahF1e//toIvkF84ZEQknVN
         vRRe23f7fNVqagmt58jKaSZ/GGY9b6O+ui9fhjJVABpcladgdg8sE6gpMMt35LMr0GaO
         N7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681208874;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qr1B0YLHtlPfuVF1isNa30fHO51jM0otPP8Nkg4q54=;
        b=0ZCDuTkp6BtQgEid4yyEZ/5E3anUKXx6rqhDqBuzWZU3wtRcpulmpkjRMVu+aQGUk6
         +JwDKlgHthrG5/CpcfXMlvHqoVe7FPQ3W59EaH/FEroQWf3IwrmdV0IP2p90QdAtfMRP
         bYXLpkWMVSLFpzAbzvc3cbeXucxZ7m32zuwP3D+XIUixaxUm5ceZIqvNdh9qB6lBgciB
         T5qMddh541CN7XwL1l2IR1mRKVLDCJZbjOGMIUlbsP9+Ytx7DOiW05iyYwTrT/GZsee3
         oPrwGeuwP9t7ibiHFmnKoZwmR+xOs+5fUeLuyv19hqvRaTO3ZY2oxm6KQUa8QHm2bTQ2
         Mhfw==
X-Gm-Message-State: AAQBX9eF35RR0+m1fDCX1H3bW7OXNRkCKvBkdf42jvwOPMLQRnNxqqZw
        Z5O65eZ4jCsVyhHuxR9PQ6snpH+OvF/EjySm0tY=
X-Google-Smtp-Source: AKy350ab8kmcbnyFIcIvPp6VHaaDjCgvDNTjWH+QwCYxt7RP63WeJK3gWhvO0Pv86/LoZYaABpBxUF8WDkjvEmoTjBM=
X-Received: by 2002:a05:6808:68a:b0:38b:3d56:a72f with SMTP id
 k10-20020a056808068a00b0038b3d56a72fmr3877327oig.3.1681208873376; Tue, 11 Apr
 2023 03:27:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:491c:b0:112:b93d:d5c4 with HTTP; Tue, 11 Apr 2023
 03:27:52 -0700 (PDT)
Reply-To: samuelkelliner@gmail.com
From:   Samuel <dinarauzchinatrade@gmail.com>
Date:   Tue, 11 Apr 2023 11:27:52 +0100
Message-ID: <CANFTDjk=z7aFZy-xac2--u_yTrzad6VGhpLnUm-DdJ_otJ41Pg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
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
Samuel.
