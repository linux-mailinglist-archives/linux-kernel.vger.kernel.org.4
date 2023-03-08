Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1916F6B0EF7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCHQlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCHQlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:41:09 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE16B9BD9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:41:07 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s11so68189447edy.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 08:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678293666;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NR2EkNwfwtVEfrRZ3fVamjvEt+j2TqxAkf/ocJWmL6M=;
        b=Tnw471y2jeH7umY4abP5CiPjzoWItBVfFLew3YZgsyGVGYvCOa+9gUBG95XJRWtEL0
         7zmk5hxi7eVI8vAld9xJnhp1N2Q2YHAquCjzDEQwQ6YQ+JSO2GFVwJdj9d0VNBfTnw3z
         VbLEa2/YdT02a9VgMVPxb46QHSDG/EPWl5jWqkb6hIgmWaDKol0mIHE6kDvoHRlCTcwJ
         VStMALITXaXWXXfQH5XueL54F8RZaOWv9xVJguSmzqFarYw+bEjXOcOCrPjijG6HsMdC
         RpRgcH+94B1GL+UqVTPt5+BzRdv78e2TK9bYEwqtvwOqOuZQo+Dk71Vj6vOawRdeqA1U
         X6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678293666;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NR2EkNwfwtVEfrRZ3fVamjvEt+j2TqxAkf/ocJWmL6M=;
        b=viMYGyqTOPSWl3eVH98oYYv215MFhnpSEKG9R4zUPWqiafJY3ungquuNWLpnRULEzM
         1COpDwmdSK3jYtTBYnMiYoX32wateFdp8UB54oDtoCONpZtlJhB4wT8Z+Kh7ShdkcFxw
         fzqnR7ODhsL0VBLBZdPlChPqdbaH1dPYsUlwVmTBr+DpOiYRYwYySCCaJTj6cBtAV/9V
         iO0d2vnSaDTPnWRc7Vu5zkNC5SQr4Dml6y3cjYys3qVuO8Y9YQYLgKzAqDLQsuMXg4am
         SJdcQmO7xjZQOU5wMJqlQHxAJ3TFLeoffE8L9mhP7pvrTdwWsxOfxVTo9HOtg3kfkprn
         BOxw==
X-Gm-Message-State: AO0yUKVJGPrPeB+GFRRc727HAm1CVst33N1YRiVckRq7cDGz4v6pV/0h
        dRgd7Q1klKbybOpecEZBiUtwJesjWOp0/sFajsU=
X-Google-Smtp-Source: AK7set/iAfwWDsYs2dP5n/UUW6JpSL9zCY7ePHsmB3l71Bie+UFo1ogsyJb7oGypkcn6jS3+u0R2sy7iPTetnLTUNzk=
X-Received: by 2002:a17:906:f46:b0:87b:db53:2d7d with SMTP id
 h6-20020a1709060f4600b0087bdb532d7dmr9606287ejj.1.1678293666285; Wed, 08 Mar
 2023 08:41:06 -0800 (PST)
MIME-Version: 1.0
Sender: mr.mostafa.ahmed899@gmail.com
Received: by 2002:a17:906:478f:b0:8e0:d6fe:532d with HTTP; Wed, 8 Mar 2023
 08:41:05 -0800 (PST)
From:   Miss Amanda Kipkalya <amandakipk@gmail.com>
Date:   Wed, 8 Mar 2023 17:41:05 +0100
X-Google-Sender-Auth: TxOFYGxmUhzAZ8fLyORbsD3-05M
Message-ID: <CAMBkNG0nH7zjYh68_Xa7O7iwiYx+fE4mvetoA7JBDt2G2t=GCQ@mail.gmail.com>
Subject: Re: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greeting's,

How are you doing I hope all is well. My name is Miss Amanda Kipkalya
Kones, I am 24 years old, I am a girl. I decided to extend my regards
to you because I have the Mind you could be a good person, I think,
and there are good people who can appreciate the value of friendship
because my mind convinced me that you may be the true person to help
me out in this my present condition i am now in a refugee camp in
Burkina Faso.

please reply me for more confidential discussions may be like that we
can become best friends in future sorry for my pictures i will enclose
it in my next mail and more about me when i hear from you okay i am
living now in a refugee camp, here is my WhatsApp number +226 55641872
and you can also call me direct call on the phone number as well, and
here is my privet email Address ( amandakipk@gmail.com )

Warmest regards i will be waiting to hear from you,
Yours,
Miss Amanda Kipkalya Kones.
