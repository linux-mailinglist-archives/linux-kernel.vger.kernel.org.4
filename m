Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E3A60664B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJTQxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJTQxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:53:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39F71AE2B8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:53:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a6-20020a17090abe0600b0020d7c0c6650so4121184pjs.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=BI2PsI0VI9U4kWcutJFDWHLoQCzj5sx4mONhdLx5vH4Jgs1s4v1vc77Va+jVXKAzME
         YmNTydRbTPTR+/5k5BrCOKJAfmQNywNPxAtEq6KBiHdpfxFKq4lCh6J0n/rzA7b6XvNq
         s22vQMpSPFFXmE10htK1G7GFa4tid20mK786l/BeLivUN7ooV1BhNLbvd28gfwOs9hCZ
         3V/tF3blOC/6oXDELPuDARCmQ0JAq2ehpVP28kKgToft/FmNlxBp8rSjERDGtOMFE9Cg
         HHAfZP8X+xJkfohY6ZpR89IvUVSxAinnwR7+hUv2Je7Af9Ws6xvD/3ATZUIqW8S5UuA4
         +uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=NzzGtjdWhDfq+l6Y2H3pTjaaedmZ+PX0rz980uxAFCLEfu4x3vFelPWfW/gZDgEQqg
         r53foJy5uJYEdYSalaVZa6DxcUUJv6Lhc1255zF7NRsVRDpYc/Shhrj66FlOsrCy5agf
         RBtekCRyGItAzXlplLyhQLMkwBLN8p644mJ32v7h6q2Xh633YSVOL85LnetXj+0cO6vd
         Nkik0hb3nvsp0RDEt2wB+d/hOSKqvQfzTwqjU5OMo7TFuuIrC66UT/QcZi/NgbvxbOlO
         7MHcU0zT1O0BELVn6DzkBnS1b2yQUSsO0qdiMKd+spc1B0wrz6+a/eFL/ogQlSHzMdEc
         BMcQ==
X-Gm-Message-State: ACrzQf3UOCs3PgeRmo3LQCfhrIsNEsiM8diys7gGGcrRPRbUI8dYZm66
        j6aK2L6LpQr2f71EznxCUSay0UdsUH3LrZiK2Fw=
X-Google-Smtp-Source: AMsMyM5nxyBjElftk6Ar6jErfxmE8W4y439DQqJkpw9L6lIZnAQ0mIjZUemrlV8rXFO0/5vp2ddEnzYSFR81jOU8yDQ=
X-Received: by 2002:a17:90a:6484:b0:210:f17b:f465 with SMTP id
 h4-20020a17090a648400b00210f17bf465mr7358246pjj.241.1666284819118; Thu, 20
 Oct 2022 09:53:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a06:13f0:b0:57d:879e:4a67 with HTTP; Thu, 20 Oct 2022
 09:53:38 -0700 (PDT)
From:   mike williams <petyetgeta@gmail.com>
Date:   Thu, 20 Oct 2022 16:53:38 +0000
Message-ID: <CAK8YFDeR5xv42+SXB1AV2YjPBPBX11PLMK8U96_V2RzZw7z0_w@mail.gmail.com>
Subject: Hi ?????????????????????????????????
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


