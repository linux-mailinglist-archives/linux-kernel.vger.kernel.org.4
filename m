Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D8363241F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiKUNoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKUNoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:44:00 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744C8248
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:43:59 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id kt23so28590056ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLuxvrtTwLpjQCdZkBOlAPtT4PuOt7o3XUb4SWGRYeY=;
        b=oZgQIeHI8fUBrBK0IzPI0CwS3tfHJMWbkpePnEknmN0uMPcNoktKEgea/9SyErC/lE
         EbTRiBHO8z5pMReDK3rs5PQOMXeczhBD58SuBvPE3yu6RuzsYP5iKlBHdtpCxAl2g29c
         SOMV79VAcEoEtpIyEv3weHtLQdZW0Lh6CyuOrdGvzEmzuHLHxdHEnWYGfxMqzUpUWp44
         PpfzZ2USaG3aNctWdH0ZdL2FfC2t+MU2wdhBhwR5X/pfBuXyHyjYzWr5EMRr2BdBi48D
         K6hXtmdOx1IYJYCpS4IzgvBRwTrxn54M15GWL38oipDDDGOqwN7av4yIPayTbsWTpB02
         +yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLuxvrtTwLpjQCdZkBOlAPtT4PuOt7o3XUb4SWGRYeY=;
        b=7esKdbk+gB55EmIM76qNmL1pth2lrTp0jn+69r3aDfzUCRfw/jh4Qi9BG3maznUPSJ
         EGs+rRWMoPtii6kTG+FL3MF11dXuphtN/2B28vfIIyFrRKd3o8/RU9X8DsEg+65VK311
         +R/l9C85JLOLUaGaE67eunujRiMnNWctQdGR4bKb7yEHlpTe33/jMACoHu2hrG/ZrWnF
         SxIV7wc96Do+C6HuA9QY4v90DaPvis/gq/GjPIYK9ls8Tt2/AWb0KSokGDOPvnln36gC
         ot1PssZwozrc3KC67BdMWEY7D1p0ch+h72hxzZ2REBjxkvjMc0ZFLBt+rdqI0LzotSU/
         IySQ==
X-Gm-Message-State: ANoB5pndPGr63ZZakL/RiEHgY6c0yxm5qmtL4Iff5EDgL1QYRGF4GWT2
        T/JATMfBBFaQqGkG9DmWblVAUtwlb4Ipj/OfMjY=
X-Google-Smtp-Source: AA0mqf5JclXnQrwMnS+iyAukB6nEVFSVgGfWvxLcPyclYgQmCIEjbRqa8INzQjrtzO8FDhcyRq2WTUOpU05Ib7Uqu7M=
X-Received: by 2002:a17:906:da0f:b0:7ad:95cf:726e with SMTP id
 fi15-20020a170906da0f00b007ad95cf726emr15780841ejb.60.1669038237931; Mon, 21
 Nov 2022 05:43:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6f02:905:b0:24:877f:7460 with HTTP; Mon, 21 Nov 2022
 05:43:57 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <rw36223@gmail.com>
Date:   Mon, 21 Nov 2022 13:43:57 +0000
Message-ID: <CABnv2bu7b6pNS+RdS98u0G6Zc4ZLndbFdw_EznJDWAhNdUxMog@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Friend,

I have an important message for you.

Sincerely,

Mr thaj xoa
Deputy Financial State Securities Commission (SSC)
Hanoi-Vietnam
