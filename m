Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D051265AA18
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 14:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjAAN1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 08:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjAAN1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 08:27:06 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1F52AF0
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 05:27:05 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id i188so26078505vsi.8
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 05:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Pop34LBMHrA8kduJ+Es4SPUbQTvHs65X8OzC2YAcpI=;
        b=bu8OCetdAY3lfyxB3+/d7JqaY2sUTRzJZ7wO94lHNIT6EfBf3EqiIX0GeewUwhIBEi
         7eFxprOcePKdvBuI7SoSOzNe7Zp7+aIiRdxTQJ8/RfsH5xDltbaARF0NoCwaDBR0CN8/
         FYp0NzRlpw98cry45gCDrJtEJMXlHNgkSEpmNjCs9bb67a39/HbqyOwiLoviQoU4hl/I
         0hWr5GpLMjBdg4PPTA1B5IuPjX1Jh1m44lVRLXQNPe/Z+Rjzr9/xYPPkX+dsc1zVwJN4
         xH79C6xNw4CsB+8S5L7M9t8czdQ88t0db1luj63DqZQBkulSi52fl0DOd/LpOrrRZ5gK
         gdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Pop34LBMHrA8kduJ+Es4SPUbQTvHs65X8OzC2YAcpI=;
        b=yjXLaHEe4Wt0tZgW0U4eiXJEu6+fTMQtxGkSrnhlJMAzzgjSjuAzWjlZNP4GWEA7Rq
         CY3or9WoxtogtcgpASKVrK832ObZpg8Uul4D5h6iwDLemgo9wPlbpBafQCjuF6QyCeCE
         WpIWVz0xTvmJRPKkBOXCbsHZiF/7Y4bPEby6Nc25Rb2lFEoy3Tg2ijKOWpoKRB5Tqrqk
         ZhSAC+1VBzD04egUV9g5TnF3NhvUjy9o+8mIv9gqj/m82HbtsS2G26ayqF1KS5v+x7nZ
         DC11LHnEa+dXy6XEY0RVl8E9eg5BJeLiqt3jYHew9CQ9tgVayNO9fNXBrn+NHC4jhYJM
         K94w==
X-Gm-Message-State: AFqh2kqxcbXXCjWnMRQlIQFzXrvSmUL9KBOG1VyNArEDV/smHyFz96lg
        nYUDKqOYijh0O+3uBdg1Ia1xV1ZMs/QmO39+xgA=
X-Google-Smtp-Source: AMrXdXv3FCdbPPtzErw3lytFnU3WnfNjls/fKDTlUDX+RBu8Pdwl/LVKESvFxWK8rkitXY+OmHS6UEgEsf3zUqcwbDc=
X-Received: by 2002:a05:6102:95:b0:3c8:5251:ce04 with SMTP id
 t21-20020a056102009500b003c85251ce04mr2255925vsp.21.1672579624578; Sun, 01
 Jan 2023 05:27:04 -0800 (PST)
MIME-Version: 1.0
Sender: paigejohnson20009@gmail.com
Received: by 2002:ab0:4892:0:b0:4eb:8545:7a73 with HTTP; Sun, 1 Jan 2023
 05:27:04 -0800 (PST)
From:   Jennifer Wood <janniferwoodphillip@gmail.com>
Date:   Sun, 1 Jan 2023 13:27:04 +0000
X-Google-Sender-Auth: XIxIyh0cggteuHbXLBrFMbvSWE4
Message-ID: <CAC0fc83zqD8RXLx+wCy56VoyaV2G5fbp=Lp4ny9Xi1=k0k+2yg@mail.gmail.com>
Subject: Compliment of season,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compliment of season,

Dear friend,I am Jennifer Wood Philip from London, United Kingdom. I
want to find out if you received the previous message that I sent to
you last week.

Jennifer Wood Philip.
