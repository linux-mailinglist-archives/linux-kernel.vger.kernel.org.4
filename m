Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F206D1F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjCaLpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjCaLpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:45:31 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C0730ED
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 04:45:30 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id iw3so20975649plb.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 04:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680263130;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLA5i81PXZUm56suBeIwZHhuE8ug109yJCU2CiElHKQ=;
        b=TAwPrdAnzz+sP0s2kZO4JTpAgfBim56V5xiiSivaUrCUrlbyqgFw+rii+ylkzNolLL
         HD6m6q37Ra9C8leT8odW7DQhTORyMyP02s0wCjSJyb3vbfrMMk0/uExFXgqQLXmj3HEl
         abzn3bsJAoJoKui+FGLbXKdKHdaI5P2tYXOG1AhOePtWTYFN4Z8+jJjrxaVA+1nxdKF6
         ofvlwVujEec8133f2snHcILBojzdhwoqqpCRtB43jl6b0k8uesjPti8ENyIZmGzojTr0
         1Ie31AnRvM7zljPg/ejD97yBs4ka0Izv0AYF5e4V0ShR05q0ziBwkZ4pTH41gVaEVRst
         L1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680263130;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLA5i81PXZUm56suBeIwZHhuE8ug109yJCU2CiElHKQ=;
        b=CVu417V5+Vswb+m05Z968U00tIGWHhgwn40V38E5EEeLOgfvufUYpFVSNe6RYDTCbN
         IVMVFTek8aakmSBc/y+cPf5IK4q/IlFnIfzSbtbMRK70N2ih/vr+OEL6PC8VyuLWUsuO
         zzQY7JSnpAjFE7VUkDQSEMCWG7kG0ZbPJ/ZHyPUn6fTqmn2MZZ7eSKcf1WJjAuSvXrWh
         Q5bxjsZzXH64k+xaHUyHQS+hw6gOyZhe0bgn0jdlPmWDgNpGKD630AhFYO30fQFOiM05
         Sl3xhSZ6MN0dMUyxQxc1kriYvY0hznb/t7apKjJlks7B+Gl7/S+56lViIxtVV9NvdB3W
         ZhBA==
X-Gm-Message-State: AAQBX9dCjO+6lkpK1X3KP9zcIJfEM9lwMUjpGidtqRKAN302FnFjXqzQ
        nOTFjN9BA9wn6IWLrjxmPNUznssZWWOBbTLlIgo=
X-Google-Smtp-Source: AKy350YLM6Qf2oLCjcTESXAvAyloBt1rzbwI17JsiMuv8/pmvr5iKKh8jOwGfhe9w+KrRc6noC0neRxwnxmwu3T3xr0=
X-Received: by 2002:a17:902:ea07:b0:1a2:7d80:a160 with SMTP id
 s7-20020a170902ea0700b001a27d80a160mr2780029plg.9.1680263130223; Fri, 31 Mar
 2023 04:45:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:414e:b0:9f:acdd:d217 with HTTP; Fri, 31 Mar 2023
 04:45:28 -0700 (PDT)
Reply-To: samuelkelliner@gmail.com
From:   Samuel <saljeeranmofagovkw@gmail.com>
Date:   Fri, 31 Mar 2023 12:45:28 +0100
Message-ID: <CA+LF_-ne3OZ5aVAMVpy+MsGbqgMBJ7fSkPPnJgwpArSJ8bMAsA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
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
Thanks for your anticipated corporation.
Regards,
Samuel.
