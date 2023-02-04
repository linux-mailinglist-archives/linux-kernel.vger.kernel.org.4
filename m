Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52A468AA7A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjBDODu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbjBDODo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:03:44 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EA92684F
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 06:03:44 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id m1so6380284vst.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 06:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BguGZ5Jy2ipVi1im+D1eowkfAWy2JwDuoaoZn4G7t+g=;
        b=H12LwX7z2ceBO+UJopvDlDim3QakOVa0IA1dRWt5kkUIpoz2ss4rJ2asF1tiFC8PCp
         9PRzoGU1D9eKSxd1wAMhyaIQulFWm5gjeRN5MDIvtXmbwx9cULzMvXjHOU0SDbNPKO9T
         NoY70IayGo1xBjgzHw5fLFzDIZfQcZzTqnryH2Jk6DmVJD6MlLYfGs0staoyxN7lWm6t
         pLNBuB1btFdhO9HCxOJOJVlIY819uwBxOBITTdHXZuWU2SONx2yVZsnFOilRIvRGEInE
         0ezfw4JyK7UFhcu6kyAQE3Ufp+EvUKd+Qcv0IICopUl8m9EUw6vhW/3H1nm/n5LRWOHf
         PkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BguGZ5Jy2ipVi1im+D1eowkfAWy2JwDuoaoZn4G7t+g=;
        b=iD8vG0nHP8y3r314Sffx0e0wAvNNtBcKDZOxz9O2DMZW8eCc8GAE+OZQCwM5qLhhOy
         945klYgly/17NFb18Cu2DxA+0Rrr68axgoeZHnTDODLVWxBXF3hlrOmH8eytkEXYDAjs
         Y/9LOr8ygDpBAR7vJEE1Rt67QGZUXelEVt+ecyzyz+XOZEYWtoTy64rRvarJ7X+WRCr9
         rAufyleRDeG1VTekVpk/Xor6kq2BD6ZS6OcHNUJkShSf6XW+Q774MNQlCj8H2AhRnDKa
         VOMVVQRDCdy3AvsoiYqCt/w+MxqstloaiaezngVa8oijYlBfhOp8PxJKhhxfCADUP41J
         2phA==
X-Gm-Message-State: AO0yUKVIXAkam4Rt8FtnHcdJGohV0GETDnRwodUUvQKY+Bx3qo5QSTe8
        1D11s7e+7pgpO+QapXFjYAvFxbbo2u93CqCjzis=
X-Google-Smtp-Source: AK7set/lplbgxsoDk3/D9XjhSSl4C/dmZUndLgtiRoEL77yPCyidlp4LTTX7AiSphXv5AG4uS7kEcGw2+u0sYGwMFko=
X-Received: by 2002:a05:6102:22ca:b0:3fa:6af6:fddd with SMTP id
 a10-20020a05610222ca00b003fa6af6fdddmr1779643vsh.70.1675519423260; Sat, 04
 Feb 2023 06:03:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:612c:15a4:b0:37f:9ad6:a2dc with HTTP; Sat, 4 Feb 2023
 06:03:42 -0800 (PST)
Reply-To: jse756113@gmail.com
From:   John Sevian <sb8766198@gmail.com>
Date:   Sat, 4 Feb 2023 06:03:42 -0800
Message-ID: <CALhHHansFke7PPaatp1qcuNW90izrVKnMfGG=TAS++JJ_Tr=fw@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e36 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jse756113[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sb8766198[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sb8766198[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My name is John Sevian,

Please I'm sorry if this email is offensive, I paid and used google
adverts to send this across for interested individuals or companies.I
just decided to also share through emailing.I am a financial
consultant, I have a client ,she has funds available in UK banks for
loans and investment with low interest repayment.

Please reply if you are interested.
Regards,John.
