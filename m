Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F155D5E668B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiIVPNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiIVPNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:13:18 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB921EC40
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:13:17 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id y9so7015118qvo.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=S7C0B6vxSjxDd3hnNOITirYE7tAARUBoAA+E03gPdFZBBLOPG+2XNGwbtTHvPvF66g
         1gANSTx9B1oqIEvnDcd0NsI4RXrynmtZxS+79/M3U6XerBNnNqUeZcOaG2NQNELXUlfw
         HXhBTeTbWf9r1HhA20Nqd8z+lJYkagKaSbkaBIzUrkZojkjvWZzkyn18FWlbNUoaAHUb
         km2XSTMUXTeHdxOiKnQv4rZho+3yncsynkNp2GzI5OOED1yEyXbWwyXlThqzFAlDUsfN
         N0MrfCS+x2+Dv72T2QZ5OkuDT1xczQ3JenwfpaXo8UK8XQPrK6MK2KqpV4MfbNYSKvQu
         hF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=3Rk/JpPm0zcE3IONMMd2L2GA/CKP9ii+iyhluFiu6DHuqE0nxD7LO1uSfPQIufqCiU
         uizXiMrCFBenkS11WqG9xCuttU24dnspfAzeVlk2t2VmUsJFfDIemkYC2OSPwMZOeJtM
         HJXSz4rBMfqv8chfVzk+apzvU/8EFfs1OIbBpDuTj61GxFVuGd8xyC1+9Ia5TX0L5kUr
         72njsrpvirfAMNQkOvirgx/jZeEOg7Da31CmXrzbGm0hiqxlcML9fEQECV855Qk4djbn
         URa0LVNLKLZvJDMYwm3v8rb2jG/cpAw6b1vxwVNFaNi5AzLNVtq2zsmd6q5SG2qD+/AL
         +z4w==
X-Gm-Message-State: ACrzQf2xIElONx8PMdJvH+zue2Rvygi6iY/CscVyPM8h6uWeiT55WIef
        cpUZtzboy6Nu2ClDJ6Njmh0R4wWne//Ei+vZ7AI=
X-Google-Smtp-Source: AMsMyM5QzdnmYuEFD7/48zox5QYKB4qwcvD2SS8ErxNa8gpbVetG0HsB+vlT6wQ1o19XOsNv3tpK3WbVFw1O85n93lI=
X-Received: by 2002:a0c:f153:0:b0:4aa:9ff2:5f7f with SMTP id
 y19-20020a0cf153000000b004aa9ff25f7fmr3082969qvl.60.1663859596295; Thu, 22
 Sep 2022 08:13:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:246c:0:0:0:0 with HTTP; Thu, 22 Sep 2022 08:13:15
 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <tracywi178@gmail.com>
Date:   Thu, 22 Sep 2022 08:13:15 -0700
Message-ID: <CAAxj-_gdHrhNcaVCRd_m0DkTNLBkWZYURPxAdXMhEV+nYefwqQ@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f2a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tracywi178[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tracywi178[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
