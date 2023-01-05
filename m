Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B4C65EF90
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjAEPBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAEPA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:00:59 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325DF50F4A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:00:58 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 192so40343412ybt.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 07:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JT2Gt7y/M3YLHVCyMzZwNsFe1p6EOvnpVpu2gl496w=;
        b=gm+Qa5lH4CXxHP+puF7OfioQocA1kUEEhV5VtVTSlvhKAy8H9LP2zL0I4KNzkC5ypi
         wpj/YAi3q/O2YY9PWrP/+rs0jQrGPhgI33PVx51+eLGiUB9syC+cSCA4dXLuPJCxYcYI
         wRXe3dZ/XuXGghOFvF0WYfVOWiVP65RXH+wa79q4AJYuFjPEbr5cx3wLnwLgv3XskIkp
         z66wGwatGg6TpDzOkyfNNYvXsdTynW+18Cl1Q0DTmCTgDK5HtZpXliuoxw4j4enUusVS
         9hfk7Ces0x0MzeUST+lrXno6TxSL6YJip3ZaVjJAtqzr2zmr92YcWLeIUlG+HcHOTcAA
         fQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JT2Gt7y/M3YLHVCyMzZwNsFe1p6EOvnpVpu2gl496w=;
        b=viRrGe4W707yHYs2y9MUB+hZW8cnNNIuaYSWIWa4zXpL6QiubihCDtpC57HrQnwGJa
         5y9usyZmulplf/LhzYxCuoKOCIllYUlXXPqIdgARDRa8Ib2vJWt9kxu+CAxJLNBrU6Tg
         wcsurpBrLoG02FpkCUczt9IzRs+nQGYul9V/h2dX3ELMKudNAHit6MHfFnDkzXp8aCfb
         p8ubQUyfIEhe/yFHjP4QLgtYyIsi7UC7zCzV53roVyXAIpPBlGdfaki/cgXpuek0sRMJ
         oaXsAvNAuyWVzkRunvK9q3yNIKhebYhm/aqflhiaBfPxmr54Oe+W9349hs+kqzBNfNRA
         j1aw==
X-Gm-Message-State: AFqh2krjKbbAMjgZuEESwVR8xp+ZGs93yRufZUy3gVESXvuSulmhCNCP
        dsouf+Wsce1mBXksaX1qSHdP2eB+XMze0d4hjX8=
X-Google-Smtp-Source: AMrXdXtJxHAxofkfpex8ul/LImkG10Ceq7Y0iNch1oseg0msZcQTS0OLGqqOmBgVK3g3z3DQ5gE7fZVvqNvAjOyqukE=
X-Received: by 2002:a25:bbc2:0:b0:7af:fbd6:9349 with SMTP id
 c2-20020a25bbc2000000b007affbd69349mr794651ybk.315.1672930857226; Thu, 05 Jan
 2023 07:00:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:a213:b0:321:7f6:ad55 with HTTP; Thu, 5 Jan 2023
 07:00:56 -0800 (PST)
Reply-To: westernuniontransfer277@gmail.com
From:   Western Union Agent <akakpo037@gmail.com>
Date:   Thu, 5 Jan 2023 07:00:56 -0800
Message-ID: <CA+ctXwpTJZKrU7iUWiYDWQbpy0bkRj9N3tZyXRjv==UGkwYWCQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b31 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6495]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [akakpo037[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [westernuniontransfer277[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [akakpo037[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
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

Good day dear,

This is to let you know that your payment is ready now, but we need
your details now so we can complete your transfer today without
no error, so please try to send us your information now
so we can continue.

We hope to confirm your information now.

Cheers,
Western Union Agent.
