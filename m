Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA576E0777
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDMHQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjDMHQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:16:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387765FFE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:16:15 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 191so3096541pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681370174; x=1683962174;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vYZbFMKxz28xz7A0mtS0bwU18hIvF65dG1fHNHuoAR0=;
        b=SjtAeurd6d5lokreAYId2Nm5VtiDKg9LZPUivcSXsBc1dnQ3kTnQb0KXTIprMz4TrK
         rpnkHVGYfScoPQ36Fbq9cotWUZyAv7Ri2ow7G0aUxf+VFl/2sNX/pay+EPqtpmUyv7MV
         DHsLjs/SXgBSH1bQ1EDdrnNy6xNTVR5vWVZwiz7yZWGPafhYqVXcwabnDqbxhCL2XQDV
         fn1H7XPRG+MhEmAfTMl+pQGD2DLR+cqBw7hlr2U+WL7/4fEGShb9f3kswFQnSqXcl2Em
         tcZgh/v1ckcqYLdNqyDGwCOGffGlaNsjcFJaXOEFv0oLV24GIJOeXs9u2RvoncTDCL8F
         3vHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681370174; x=1683962174;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYZbFMKxz28xz7A0mtS0bwU18hIvF65dG1fHNHuoAR0=;
        b=IKdD49/FlMGvgWeGFfhTl3rrPlqJx8vPi3EFuWw1ngefWro8BSad4LDiOtPtxhGDcY
         bjHa+dSFDI4VTC08UY0HQBgutPXUik2S+dPJnBLOdhmKGPolG5LExvK5OzWpNCjaeMKZ
         uhJBFuObGL8708VKvSmWeGNEEPLV+3udK94uYUkccfLVEbPFzwWgpKwHROr4z1/rpbxs
         +GhaS020PFEPZ+zPkx1KRI290+gWC5cN/vDdXvXuw6M64306JPpH330QLzBOdqPbbzIk
         TTdRW0K7GwfIYI057H0l0av/V6UgLa9vH2/BTW/4R9EUW6VBCnly6gEcehZwKoaOkXTZ
         gX0Q==
X-Gm-Message-State: AAQBX9dMOWv5n4Hycq1pUB20pmvZ7Yx/sq7DBB6TtHjwraGH3nMHRRh6
        enVXKQm7uMAStmXINmNtFfslbZYnNh8iuJxU/P8=
X-Google-Smtp-Source: AKy350b4qGnMTwOPVqwMMM80HP5/EeCHZnb7YO4fqdmidGhH/kuYs4kuNaVs1bLwUm60yHk/UqN8Q5LOOFOC2IyhzoM=
X-Received: by 2002:a63:5505:0:b0:519:a34:7380 with SMTP id
 j5-20020a635505000000b005190a347380mr189546pgb.10.1681370174567; Thu, 13 Apr
 2023 00:16:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:f708:b0:19e:2fbc:7dfd with HTTP; Thu, 13 Apr 2023
 00:16:13 -0700 (PDT)
From:   Aluminum Corporation of China Limited <onyeoma2426@gmail.com>
Date:   Thu, 13 Apr 2023 08:16:13 +0100
Message-ID: <CAA2bfVN1asJz+gi=0OJGCVV5sOff8afMPn2knM5eWPbMZHWm1w@mail.gmail.com>
Subject: Purchase Requirement
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Kindly confirm if your products are available for delivery as we are
interested to purchase from you.

Waiting for your confirmation.

Thanks
