Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BF5639B40
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 15:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiK0OJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 09:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiK0OJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 09:09:18 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAB2DEA0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:09:17 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id v128so8242032vsb.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lf0lCR+u8PMB9vsCy2CzoVh2AzQlmbXa7mTITxhx7k0=;
        b=QyPOxBsoCLas21O8mm4jA0ooFasaUWbhAxHQ844zg2pD/h6ONWY2Wnhu4bndHi2cPp
         GEb4LXFPyBq8H0XqG85QdoxuK7gydpxY+bix8fIIrR1EC42ZFLs/0S9ElavNxwrQbE2n
         CyNNoMsMJG9mBKSPujKN8V4yAABpYSWb2AIEHuonYrdp0Yo7gleHLNIi3TnMD/+YIE2O
         0w0razDrOR2gO38Aq8Z6zHj796+Lh6YTgdDBL3/rwG6KcKMxM8UU+wwLzZO5eIJjHRkE
         8QfKZ7dHGAqX5UKmrB52xe5vDKXDUEmmnNaTiqk6YKVDoNXkoNqF3G53ESGpaABLtUCY
         ij3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lf0lCR+u8PMB9vsCy2CzoVh2AzQlmbXa7mTITxhx7k0=;
        b=I8PypBIefR86FGglTXu/g1rO5f74ZsZHel0wfxYSWAZDvIoa1cP2iUcEioRy07c5Ez
         DjyNdfdL2tIHhV7q3YBs+KPSUWfS9UfIC5hFOTxIdAei/TudQ+sFojADF/70qe6p89U/
         TxVcX7PSJLI+DNCQFh1zYONdBsQ02Ier4Qli1xc66VyVZEcp25HdE/lRN0ioTSZnmUZ2
         JCO9cB7oCokFHknb1li5lZbuULeTS5RASG1v75o0iiHaL0Z52TOhz4yWbnMuLs75owc4
         uKlrqx/glmntENaZrimsS5y2ak7U+M9ovHfOPtTnvSTkI+HAvi5yjpOewjjR7lhr+170
         UxKQ==
X-Gm-Message-State: ANoB5pmytRN2wvlnj+IgMzOey2H8dtzRsbLLRfeOTmWMwK/KBYACMp2H
        Qz5mkUAWeJt+d//tlXpu9xzzmgsV+a7mBHdDVKQ=
X-Google-Smtp-Source: AA0mqf7m7R4j8Ec5IHe7jRYDQex6DG1K7PQJcL9DbFZsQWXaflgICwfdUQE/VdvYPTkhuKQdhtZ2EoQ/6UEWT0Ugrnk=
X-Received: by 2002:a05:6102:3664:b0:3aa:31b0:b4cb with SMTP id
 bg4-20020a056102366400b003aa31b0b4cbmr28795502vsb.6.1669558156905; Sun, 27
 Nov 2022 06:09:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:7a43:0:0:0:0:0 with HTTP; Sun, 27 Nov 2022 06:09:16
 -0800 (PST)
Reply-To: n1a1t@yahoo.com
From:   Lucinda <marcy8153@gmail.com>
Date:   Sun, 27 Nov 2022 15:09:16 +0100
Message-ID: <CAK8LRUoEdB4TUzUGA__-ewmfiM9GbqCiRnbb=93O-03dZCb-Kw@mail.gmail.com>
Subject: Hello Dear
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

Good Day
with all due respect I ask for your permission to have a talk with you
of something very important and urgent.
