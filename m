Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1980665D232
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjADMQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjADMP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:15:59 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E5411151
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 04:15:55 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id m129so28826647vsc.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 04:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RUY5y6zLuR5cWqeaKguClMSYR6J/UjlVX1mPxUIDiqs=;
        b=VJmLCb73UryNuQbimr+CbNAQyBR7W4yGvyxJvyca8oDYvWVnVqj7g5bHUTN+kxCSqc
         M6J5m4XgBf1sk+dTvoAU7kZ1UGKnRYcbHKwWWAiSylFKzDL9AvRUMuX41zUuYfiOBQt8
         V+gbQmCWzQaN1FoOm8Rk+sSHWLB8Mw37LriXHhPp0pyv1AzBjWqqw2YXYqArPHATvAUt
         7uw6BA9hAHu+IUt4BQM/Iv0SrdL95Qj2YjPaXiZ2QqMMcsU/9zaAliVp6E6dUfAsWEmf
         v5MWVFAq7jOmXc9qPJjvooQFevpcsoWnMQvWx+ODemG+r4SHxzPc4nhaAaj8tTDgduQn
         jETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUY5y6zLuR5cWqeaKguClMSYR6J/UjlVX1mPxUIDiqs=;
        b=d7Jt9BHdqrui8Cu1QMSgVZk5/6xuk3qkbNr8Hv3xu/hjSU327tfUIgGcqA5iAp6Hrw
         5jqWDZSiETBg2j6XTA66kFvSOTOUB/h8ynCYoz1JqaGz75uza4ysSRqfwvm8wcR0H2Ze
         BW8W9vojNIAUImYoazzsau40RnCoiN+6PSicaFjQw4nNCuVn/CkHQot2yZJELa78zAid
         +XgFiEvnGI33btKxk16xzKsEWAdib/LoQbCasgMau57QwT5MJ/wDuWJ6h7wF40XhwcUW
         ZvmZpZXwdDIVhmugwzXtB3wz1H8qxJv/ZlHenWkgqyTxXgnGWm7KgsihVkI/nKpA8Ij5
         oiow==
X-Gm-Message-State: AFqh2ko4hSBOVk0dZ+uWV1tNHYysNE99PDZlUJTJu/3C+Kf50FiM06rg
        1yZH0ECZWj0imx6VF7hzFiibENzDoWvfk4cJ0qg=
X-Google-Smtp-Source: AMrXdXs9Z6fy+tJM59MPMF0s8+Akct7I6gaT4gfcJFl0WIQDXbDv2TweXy/eYx9EaCLAbg4Zvcs+/VGDDKhatSS8Bfs=
X-Received: by 2002:a67:5c03:0:b0:3ce:a7c5:3757 with SMTP id
 q3-20020a675c03000000b003cea7c53757mr587901vsb.63.1672834554496; Wed, 04 Jan
 2023 04:15:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9f:2d84:0:0:0:0:0 with HTTP; Wed, 4 Jan 2023 04:15:54 -0800 (PST)
Reply-To: garryfoundation2022@gmail.com
From:   Garry Myles <oluyedeblessing4@gmail.com>
Date:   Wed, 4 Jan 2023 15:15:54 +0300
Message-ID: <CAGHbOor6dJX1ws5Ji0MQYHOHZdAji7MraVGYpVYHXbgqs4W8Kw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e30 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7088]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [oluyedeblessing4[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [garryfoundation2022[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [oluyedeblessing4[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Guten Tag
Sie haben eine Spende von 2.000.000,00 =E2=82=AC von der GARRY CHARITY FOUN=
DATION.
Bitte kontaktieren Sie uns =C3=BCber: garryfoundation2022@gmail.com f=C3=BC=
r
weitere Informationen dar=C3=BCber, wie Sie diese Spende in Anspruch nehmen
k=C3=B6nnen.

mit freundlichen Gr=C3=BC=C3=9Fen
Garry Myles
