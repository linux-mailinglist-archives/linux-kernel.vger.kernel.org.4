Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC39A70D854
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbjEWJDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjEWJDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:03:21 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859DCFF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:03:20 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba841216e92so10326390276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684832599; x=1687424599;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhCcbiMDeimZgRsX8GeS67PO3y/8MJ5nVThqdM2u2S8=;
        b=qn6Rc3FhBahuuMH4cnL5ysAgWCLTzSoyTKgtviwXLvoFkiq3/3/QPzuEZMW0hXVGXm
         EE4J5Ery/AY4xyaIoeWSbUapBRJRAmho4MhVdjKsMkFVMZ/xlb8/dwPol7464oL36izk
         PhfH7vuTHdL7BdX8lv7kZfmW/FfkEe19e1kOwNsajVChBYtRXkae8iBTsEyeZg0evZC4
         YRBaoiiAhTIVZtHpbE+FCZd14U9KLNoW8qWDiDz/ElSLsuU4os1tmZoUR1y+vT9zlZNA
         a5whujASlD1TqkMheswM2v1cHZZ4PVUDMoTFwRXyMIgkyiaPOqqI7Pzv3Ozk5KlI4hqe
         H8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684832599; x=1687424599;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhCcbiMDeimZgRsX8GeS67PO3y/8MJ5nVThqdM2u2S8=;
        b=e6R9zBwELpy5G7/B5hH1YSQdqpdGE23leSHWDkbqP/i5pxfBb/b9nNm1IGMzZkRNRu
         NJwOadvn3Zsrss01N88KEGBTWdp/PVOK0Kw719QJSHUypR/CFNKZdNGqp3zNy33WTZ7l
         PFOfNtWgZJyY/FBZxLR3MmxmLGwnMRKVbXwSwRnNapV5nkv+CmR1BnZ3pZSL062IH/SR
         CAYbZou5jQJ5IrrzKpKSbVo+jzG3nv7tIEnEdpeIUGua339efGnNeAUCpsDdIKcqNuHm
         iGQg6PSD8rC5hbvbhphuaIgANx9mr2ac/vt/iQ4xnQ4vUabH5NigcD8ZtDx4nstawOVj
         PJMg==
X-Gm-Message-State: AC+VfDzeFLkUMKtvKJv8pQC9n11dAe1mqyHArH1hEKIAPtNPapu9PqJh
        O7F9bBpfF9kyY1KsnKxkNfhkl5XkNUt7uNZV2ZM=
X-Google-Smtp-Source: ACHHUZ4ENtW8fcVr9C3W1V9EWZTVOqVlbq+qJL47jIVkrTF+wCox7F3hcYs5JJl6uwPsstLa7NDo9CCrk4aqbHjelzM=
X-Received: by 2002:a81:a107:0:b0:55a:c62:3a92 with SMTP id
 y7-20020a81a107000000b0055a0c623a92mr14543162ywg.29.1684832599666; Tue, 23
 May 2023 02:03:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:3292:b0:357:e2a6:822a with HTTP; Tue, 23 May 2023
 02:03:19 -0700 (PDT)
Reply-To: samuelkelliner@gmail.com
From:   Sam <vantry.wangedgewell@gmail.com>
Date:   Tue, 23 May 2023 10:03:19 +0100
Message-ID: <CALJR+mYY-X1miTXhssXR8hERXx4tWy4mmuetWRsNX6psj-ocSg@mail.gmail.com>
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
