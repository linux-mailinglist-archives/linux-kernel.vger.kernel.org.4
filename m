Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB9C64BA17
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbiLMQog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiLMQoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:44:19 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A7922BE5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:44:01 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id 128so15182950vsz.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwuIivs2bXND3SDhAV+zSYDmApbibgZQPxXCRZ6VkeU=;
        b=aAMSgSq0G+oMYHvnF/Nk1xrXceihkYrSUgLNhaNw6+Kn3upwRvl6BvD+WkVzHUMsZg
         ceYrK0tc7tIXOwVEbgY/TfiH9FP6hQ9cAbXaXfug44zssQAyVrCqOuL4DlK8mTvtWuY+
         92ag7Els2Ye9OflrDJWQ7ANSlAbogxz5nUZnZPJUhsbtewimzzErTJIHR4iDpAq8hEPA
         2XDYdlvGHEXravIl9uVVXLt+n0AOwgcNL7nEaUbaeghDDVjgKOXjlaIOF7PU7s/to2rQ
         iMZ1FeyYZfJ0ayTeJXRkf1Y8m95ZoZiEI7MTM2ElXh65WGLTknKJiqOIuXLE9PkKzdDx
         fKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwuIivs2bXND3SDhAV+zSYDmApbibgZQPxXCRZ6VkeU=;
        b=jajRSxA5vdTtJ9LdV/USKVYKFXQvWPXusKK2x89c9HWo7t/IJYr6n7UsWXbWv1oViK
         AbI623G3PV6V5XQHA4PNn7VuERBUo87lc6HgTa/ljhDmYjL8nlPGEd+/4m4Ms8w02cAg
         wIngDv4ZBFHO08ChHEIrWJS9U6om0bB9tQcfHqKROjLu9j0mTDlpjJCKwZfOzDALOqgW
         wBSg/FgnXSZPSUivXruIIcK4HMWuFG8FXQnCK4MuKB8Fw1LH8dX62lwSqlR3wVigupv1
         O+pPBvosbLXCRfLVGeC+rT8N71odRGs2YP86qOlJHrD4p0AUBPoqN3VfhqQyKdIDl23I
         gDSA==
X-Gm-Message-State: ANoB5pkCNmnmXp2sS2VE0P80AUI7OwjVmBq0nf8xwXMkjzzUX63rA4OH
        +NfPSPvGji8yGbuFghcDSpvpgHBOzPZxaEB38t0=
X-Google-Smtp-Source: AA0mqf4WEqXf2ALC9Af8PE5VE+V2+OtW/sG4pvi/9+rzd35535AXVpGV0SHIQ0zsxckbYKplW1H9vqsgVfHrFCSJ4CM=
X-Received: by 2002:a67:f4d6:0:b0:3b2:fa7a:566a with SMTP id
 s22-20020a67f4d6000000b003b2fa7a566amr5567237vsn.3.1670949840206; Tue, 13 Dec
 2022 08:44:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:560e:0:0:0:0:0 with HTTP; Tue, 13 Dec 2022 08:43:59
 -0800 (PST)
Reply-To: canyeu298@gmail.com
From:   Can yeu <garyjoseph23a@gmail.com>
Date:   Tue, 13 Dec 2022 17:43:59 +0100
Message-ID: <CA+rZMKxBQcu1iSFBYsfdhBUD2zP=+08wy=LR0RR-7ouOvQJe3w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Friend,

I have an important message which i want to discuss with you.

Your Faithfully

Mrs Can Yeu
