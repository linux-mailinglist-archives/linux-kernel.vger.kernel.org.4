Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0C172EB29
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjFMSmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjFMSmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:42:12 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0765AE3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:42:12 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-46e7b3bbcb0so194342e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686681731; x=1689273731;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjwYyM3Hm9xb/8XntAdJCSU+B6JXV29ZPw0wEhFhLu4=;
        b=RkF8gqfmKny6z76kknibEX8NdL0C2ykXgfQR+/vZbMpUrU8g4IQTdBOs50cjNlTTCv
         JK0sI+yTQMPx0y+GAePxFMZEIJpm/qkTfxuhdkyarUGUWMGfA8ltVxk5Ou2lVne6DA9u
         nrN8xz3LAu4a0fkrNlQreY+CMsfhVJoZjd8XSg4r+ff0t9XlcXj+PVGqU1Oa1/FCjQXf
         IIk8RHR/R+Wq0SucEYnSN/EkTscAbp7G3wV+qdX31+2yqc8c1t/lT961k/WVU9Zu+nrZ
         EihmYnBPIe72O+Am20H/LwVz+9UTFPpDSTR8LbFgPUKNvtUCxKJFNAPhP2xwk3iFxHWX
         nfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686681731; x=1689273731;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjwYyM3Hm9xb/8XntAdJCSU+B6JXV29ZPw0wEhFhLu4=;
        b=GMmra36txAjWToDlrwAYqUCXqNgHktbAGWX139lk764E4jqgV0Gn10P98zfiNwtG0u
         rXL1c64qgn4RUA7mIUVWTQc4zK2UpGDMwLx/GWHTqzqC8sRoTDfTuykUq2k9QiJBdgMA
         K96/eaERupKYLNOdfLluDlAYLvUCt9NVSBlo1EFdn/BO2kQqTkX4LjSLORFREqP5rI0+
         5GMgd6SCTA/JAo7PYih6ZdosxT+fDXXrVX726/N+F179myiJjKJwDzJHeVDf93cUFVgr
         RDrwUN1eJ5zuVObb8bGFcSlmX10Py8DAZiGL6uncM4vi5aJ4kREGMJX+p9rbzp6hXe8o
         CrNg==
X-Gm-Message-State: AC+VfDyQuLjSsI0dXi2iXuELcXvHdTIF9YEnC5KXu5U2CprS1BWJinpR
        0eZ3qgmqbu7/7S4tWGIcjkr7dNy3fO74hcO0++w=
X-Google-Smtp-Source: ACHHUZ6DYSCKWakvR3CLCBPwhQi4u88KQYUIqxcyQoBMq/ej8QccEhR9o322pcQRbs0jXKHYfqgX6kHmNJBAxZ7AUnE=
X-Received: by 2002:a1f:4186:0:b0:461:efea:6a2 with SMTP id
 o128-20020a1f4186000000b00461efea06a2mr6809514vka.11.1686681730937; Tue, 13
 Jun 2023 11:42:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:9d46:0:b0:3d9:abf5:87d9 with HTTP; Tue, 13 Jun 2023
 11:42:10 -0700 (PDT)
Reply-To: carolynclarke214@gmail.com
From:   Carolyn Clarke <dhjdje814@gmail.com>
Date:   Tue, 13 Jun 2023 20:42:10 +0200
Message-ID: <CAPYcyYgBc3D85cWnYAcYxYU1hf-17HD58QPY6p3VVozhGCLv_w@mail.gmail.com>
Subject: LINKEDIN
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

I've a proposal that is in your name, reply back for more details,

Carolyn.
