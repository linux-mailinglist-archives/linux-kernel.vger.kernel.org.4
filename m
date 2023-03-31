Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D6C6D2202
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjCaOEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCaOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:04:42 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE941167E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:04:41 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id n17so16196185uaj.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680271481;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RktWvVBNTil1bvC6t6jWMda4w2pKchpZgT2yc4wlDf8=;
        b=J5OPQyioRyog3UDyzWxXEYAjjQiUQ9UVTE/rfG+bkprIxpwlSks7EFWGF6Ztl2UQiX
         MF2VvR7uhwerNOKn/21UUbEBcyWBkeYQm0gZxUfsLJUfTrJbtRtp/nbNMSgg0xWtUz+J
         jAOi4bDutYf4/O1H54ya/DxL2DAnXWIRjggTwxkSBHy2JXjOAY0WHXOVkJCBTDz6ya0p
         qZqfO/Pmor684CqHAGMoF1mr7gMj+8lkBQc2HpTjJIjjyz4377RQkn2Uf+7PPy+1SRNJ
         puSL0IpZuBWICjNMbPoZkszq6V3bVFtKWwbffotzM1D6Cz953DDFqaax5l3FZxOyPXYz
         cfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680271481;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RktWvVBNTil1bvC6t6jWMda4w2pKchpZgT2yc4wlDf8=;
        b=EARhmy/BQIoPZGQDZcB7wuCYrVnO/vsUkV1FKUIWMMpy0WXzS6zcsiObRlDWqA672x
         pa96no/l1pxyD3WxOHP+LK1Ue6bJBuY7mD4v94M4atQVFncvOYiuxG8tuu0uG/e8fBST
         xPnu+UfJMFJHd5yxuH8Eh/xFMG0cS6ipzDYyr486lQg9DNdcQMsYa57mVAJhLfktYo+d
         KK7lPz8MLa/VbiOqCdcxTOD1WgWyyoIDh5eHydrLtxJ3Bg9OMfsoK4NS39oDT3QWurqz
         7ko/IjuFUi/doUZcfSA3PSWNKi7AmLxsjyoNBGy2vLEttSUYXuniSQov2dTkmT+g8OWP
         L2yA==
X-Gm-Message-State: AAQBX9ff48o8fV8M86C3/LoeB9msG7ghLpRdXDNpis7qANq5yFfcek3p
        RrHqtfsMlB/EuOYRWXVd7hu8RaFUvfKYlZpY4fg=
X-Google-Smtp-Source: AKy350a/hmgpPJcwoVnnMAA6MxMLI6AEoZL8uNJX9pGFYtRqflIIhGV4Wtth17/o5RmFElPq28sqcduf5wEN7TGYw4s=
X-Received: by 2002:a1f:2c14:0:b0:436:700f:3032 with SMTP id
 s20-20020a1f2c14000000b00436700f3032mr14772692vks.0.1680271479155; Fri, 31
 Mar 2023 07:04:39 -0700 (PDT)
MIME-Version: 1.0
Sender: abdulazbello5@gmail.com
Received: by 2002:a59:dc85:0:b0:3aa:5e47:843e with HTTP; Fri, 31 Mar 2023
 07:04:38 -0700 (PDT)
From:   Abdulah Aziz Bello <abdulahazizbello1@gmail.com>
Date:   Fri, 31 Mar 2023 16:04:38 +0200
X-Google-Sender-Auth: ra8AS6zfRfOt-C98FfwD_WCVjzc
Message-ID: <CADTBJhu1GvtXeDq8OcOpP0S436M1d_beaWKSNBk=X+yZiQ-S6g@mail.gmail.com>
Subject: TRUSTWORTHY IN THIS OPPORTUNITY IS VERY IMPORTANT.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, my good friend, without wasting any time, I will like to
introduce my humble self to you, my name is Mr. Abdulah Aziz Bello, a
banker, I have a deal I will like if you can be my international
partner, if you are interested return to me with your full name,
WhatsApp number and I will give you the full details and my
particulars to continue this deal.

Thanks,
Mr. Abdulah Aziz Bello.
