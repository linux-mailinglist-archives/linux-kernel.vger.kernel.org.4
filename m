Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22D16D76C7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbjDEIYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbjDEIYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:24:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675711FEC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:24:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id kc4so33730660plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 01:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680683042; x=1683275042;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41kW5fOWjdzzcQ6HaiOHsjJFnjWCo4jg2HDR0g9ZrRI=;
        b=hvPyGjTaqkAim64JERwI6jDwd9oKYUmwfQgATu2CpsI537P4wa8S+mWmEWztO9C3eX
         JAe/OaQLF6YYFmLz1LRTezQVEnA/GMRRP5kceCwIMh2viFwSaa3jDgEAKApHahGmaXlH
         cyjISWJ9FsPJH8IfMsSjzFW19Q1jrchas1W7nzk4H49B2qLkNMn9P6mpZsh5YrnfAozy
         cBR9rXP9HrRwwOsANQGkdNTq1YcfxWkRcoLQqmciB46F+taAsGk0XyeNaud8Cl7CHpUv
         1zGlTO+P79o9vwpMH5JbQkFUUIcnYhEILh0tf07JI52BLC+aPsdRvs77zNjjgZOHMlwM
         7P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680683042; x=1683275042;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41kW5fOWjdzzcQ6HaiOHsjJFnjWCo4jg2HDR0g9ZrRI=;
        b=mhp1UiadyBteBa2BvYuZGyLZQ6vPljABFH0x0w+uR6iexjp87XlUVLg3XtbbKSzWST
         T8I2IjO32LbhghzCPIeELpN9N+hhQJS4MnSCQmaafvVaH3MMwACk1+9a1UYnt3H5xT1x
         NGjcmrrqL+33zU23LE/Vse5xcHmWLvvWLbXwLMIz5lOXHPZpspwgyM1g8pMNlsx0MLvb
         /L3A5nqGdmbHE/TchRHfuiNGldlakcft4r/RREVERZF5W51jLdaSQiAIKpYsj7jetEDE
         yrPjrlSD65n3RWY3cVU4r8v0bz8UhJQOQyH/3yz1BSrZIFqg1bmYWmz7mFLzLa3oRCps
         SdVA==
X-Gm-Message-State: AAQBX9eY69jj9pDt3q7ReXFF6ssPg2zZYR5PpIuVkf3x7OA2d/vRMtKe
        JhlAA8XASiMnSHSewIano/st0QfsWp2mJVpslIM=
X-Google-Smtp-Source: AKy350Z57qv0on/viwWfb7uiYxg9JOqBDkixuNkHHVTrWsKTLutowT1MjPflmOF9tOi+cdt690427ULkg2WmcvwO8dk=
X-Received: by 2002:a17:902:6bc1:b0:1a1:f70c:c800 with SMTP id
 m1-20020a1709026bc100b001a1f70cc800mr2293985plt.8.1680683041767; Wed, 05 Apr
 2023 01:24:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:1119:b0:5f:a108:3ef7 with HTTP; Wed, 5 Apr 2023
 01:24:01 -0700 (PDT)
Reply-To: maddahhussain10@yahoo.com
From:   Maddah Hussain <abdwabbomaddah746@gmail.com>
Date:   Wed, 5 Apr 2023 09:24:01 +0100
Message-ID: <CAFC-3iemAZebeuFVSMMWXqy3ePePAsYnmkOWwVozdMZiAPz5+g@mail.gmail.com>
Subject: Why No Response Yet?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear,
I had sent you a mail but i don't think you received it that's why am
writing you again.It is important you get back to me as soon as you
can.
Maddah Hussain
