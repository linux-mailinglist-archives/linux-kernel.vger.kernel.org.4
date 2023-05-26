Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954187120B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242220AbjEZHLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjEZHLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:11:17 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE78CF7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:11:12 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3f7f864525fso3982941cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685085072; x=1687677072;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=GCXnf2r6VsBKAI5L0UXQTx3ZKJRfqkFUtVgaZCZ2CBuA9HK0KOrSIJ5pvj5CvLDqs9
         tkcnlKafAkiN9WhXOpNLOuG0FuV/bApPY5uYKFeBoGqi/fk/lE3TEKe6UV9KbefjVo5o
         pWuV3AVF4gJBQpLBZhhlWlF8+6smXyB4jnkHY5gJUr2ZgWJI6gP0Bxo2pF6/V54KSJeX
         AhC/j6PTxvhbC4l7UAZbq4iEezmxsbY9FjsRxY7ECn44HNLUWp8tpYpIvnvOfnQ6g2Os
         qARSxPuruSN7i0j7mKjC6I71ElsWIvJm6wlN5eQrstiT4ijInR2mhjFBekQyJcWOG2wE
         kJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685085072; x=1687677072;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=W7hX5lotBOAP/rOHbP9cI7zJqxYLlS2xvc2db4Nb/ZDoYTAnoHlKod6aqoV78Yn5Ec
         0utGDn7pBv0lmR0b4D7P1Cw93JPUsQFM0G4psW1Fy/e1KgGF1lpz2GK/zyvGMAvmcdYT
         0CBsLKOJ270jHI0GCz6M3sTlYvn1NbxAzpTHcQqL5kCMoYs8REfa+gfMMGnuHd9hOl4v
         BNsu2mmMh7mgr56IAIWcahJkcDPb8nBF+OZe7R08z47+ZIuvoQL3Z2kDIcAysB+FaRZK
         fTsMstWt4OcxTkIpiH5b4+/GF057m7Lwdf2zre5IayIVgHYrsTa5pBUs3/0bW1uBPlYD
         JUOg==
X-Gm-Message-State: AC+VfDxLhIPWUbtzz+fVQFrmpcMj4ttD25B6rWCQ+OtYI2QOjbC26HVy
        rJMMxiTre6CAaTri8K3NQW6nz1Xlfk9ZSyFqJN8=
X-Google-Smtp-Source: ACHHUZ5z8fhXalYwExjOCENeg/xJ6mERyzrZ5AZUx+YFz/zZbvcPfCTFBvlXZRQxJz/T3JVMVjAd5l0E9EoL0e2npss=
X-Received: by 2002:a05:622a:1047:b0:3f6:b95e:f700 with SMTP id
 f7-20020a05622a104700b003f6b95ef700mr831582qte.57.1685085071759; Fri, 26 May
 2023 00:11:11 -0700 (PDT)
MIME-Version: 1.0
Sender: fataoouedraogo65@gmail.com
Received: by 2002:a05:622a:38e:b0:3f6:b025:c0b5 with HTTP; Fri, 26 May 2023
 00:11:11 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Fri, 26 May 2023 00:11:11 -0700
X-Google-Sender-Auth: Phwi4pSMI9VAOny-QmSnMBjhStU
Message-ID: <CALAg1jQtfNjaTimpKmUGnoBSqQ+o9YrkCZ63tdzWJ+Nsb79Jow@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
