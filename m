Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DCC6EB9D7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 17:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjDVPIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 11:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDVPIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 11:08:00 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5A41BD5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 08:07:59 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3e8b3aed55bso14228571cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682176078; x=1684768078;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=erFp56Ie2bRUOP1XPGhmrfwDSL7hQPHA6pRkl74yo1kzeNZCVpiTpEHZN1YHwTYGnH
         A36gqtXzT4SamMR9Qsijtp9Oa9f/fs/4tN3KEF6StYB0O6QDMyG3vgVl9Wb1AXVEg6Zs
         NqCRC7Vnvgan9c2NM8E83A4J7BD4PVTK/ogRlq4jf2+kr7t1Y7NCcYY5yyQMijIAXD01
         5VVCnl630Ro9v0gUPlWJY/kn4IJU/w65pB2kaD9EjSdL2usGoGVrIJjf3tZqvhwW8dtR
         AKwrozOan3ooSB90qTXwAoKPe9jbtmGwtm2Rqk1hzGZhKWY9d1FRDqZh+X5DB3Elx1SF
         t7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682176078; x=1684768078;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=jAf9sKW3eqXNlqedt07DSHAF53hKYWPzlho+RdER9kvnAXe+2FzojKuh3zbYIDFUhA
         lgwVj8Mr76NWOSfUFY0RKNWzpsfuLnw+jn1UTQ6rSY8iI75sARaqstnZAPNUm8MeeDDV
         kT2zECRRx2J7vcd/b5DCoWB5Ib52yNZ9USrgk668zKuUOJKRMvbgPj3gpUGopZ5MTf4t
         aFDU4HH+nwl3OpBuQJMn2jPA6X2zRZ5PDWh2P+DhjHsM4uPZ7jKaJUkE2tuUHI7PaGvB
         K+FguuQNYVkWROWifddei2FjDsV7TGuHF52A7fhJMjohVMAT+NLwNgdslnaI25PZ5UyN
         ZaEQ==
X-Gm-Message-State: AAQBX9fNsSMjt+FN7Vii8T7CG07t1NXsGvyZgKbo+N/BWzFb2QL9qQoj
        Z0HQYOGzbQ1pY1RVrjy7gKGx2RJLUOt590ZMdETmHviD8uc=
X-Google-Smtp-Source: AKy350ZmVlk7LQbfPY1lXE43xY7GAe0IJt1TNa72Kv3KMaVlj0+gUqeA0dy+A4cW5e4mQd7SF3b0SuDEiukt4en+SPI=
X-Received: by 2002:a05:622a:54f:b0:3e3:98b5:69a1 with SMTP id
 m15-20020a05622a054f00b003e398b569a1mr13589297qtx.46.1682176077644; Sat, 22
 Apr 2023 08:07:57 -0700 (PDT)
MIME-Version: 1.0
Sender: fataoouedraogo65@gmail.com
Received: by 2002:a05:622a:3d1:b0:3ef:3fe7:ba74 with HTTP; Sat, 22 Apr 2023
 08:07:56 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Sat, 22 Apr 2023 08:07:56 -0700
X-Google-Sender-Auth: -xUdxM_TaJIFu8EULljaEcw6gIg
Message-ID: <CALAg1jR-dXR-thdXCuuuu-9PLzHMdKpNbashpUxgW33JpfAQpg@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
