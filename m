Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982286C9469
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 15:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjCZNEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 09:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjCZNEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 09:04:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34DE7DA7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 06:04:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r11so25318643edd.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 06:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679835877;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=71PnYgVAJ2sH+p9bYNHJSsZPBskJ4aq6i5nHdj4FDhc=;
        b=Up9CogP5nGGnCujW34cVEl/Pa4nLxSBnG4/hzI8wjgJlkGfHOBF6FQrcas2K7qzwDk
         pKw9TngDHaifeI7SGkpw1wWmDFzxtkco9FE6V2WzHHMqNy2h+SskbiHO0zWMjk5C6L8W
         mZjPGF7tjSSkltiN73oYbo44IgKS5s4A/2rluIYMf5bpp/Yv7MpQgCL2PtpVVFBkGwPC
         EJRmSZyZoxi+5xCsbdWc4V5/F+VxLWVAXMeOdD2tIxNFWf40kI7yQ9J3ugNY0cisBx1o
         uZF24KEzFVbn0Goj/C3da/OU6Lyt9MJCh8aG2xXnOEygasZKxgwkzsGvu2oRTakbNyvj
         ny/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679835877;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71PnYgVAJ2sH+p9bYNHJSsZPBskJ4aq6i5nHdj4FDhc=;
        b=Wj1pFc3dxYyXN08h64yNmwBpc6+KtCOZZVfPu6QctugElojW5gimlR/eK98aznfTD0
         wvRHKdo4OshQNjukS/UaEgPk0quoof3sa34svwJ0Vyl1/ntS/e760cZKLymgg7sdFoJr
         LU9Su8juLyjTzaafT7s4TS9pWyT9DHgKNIiw8mgC+2/KQsVbzddn6JYsp3RMmqC4ZKGb
         QvElasO6Eak/hZRD46hDMspM5GkFEcYA/pZHsHoUKqTA96pbNaXkNtYchbvCgAHK1QLz
         8F+kfOnu80HYyMkfGtUHrdxM6rm5PowAqjUMU5FM5Vb07/GVF2xgZxMYgOhM21Ha78ji
         geHA==
X-Gm-Message-State: AAQBX9eP0Nwe5oshJfxe9MVSDumhYJPRiMDp292Y/n4W0AWu0APOxqi6
        GvCzCrQGVUxQKktAFO6eughDjeqfSy1FvpUVpw==
X-Google-Smtp-Source: AKy350azag3SMl1zNlgUZNDb6xW6WaZZ+1tAAOn7fK/2u+h1DNWIt0KpVB692UqAJVjSNdPyBkQTNNewd0mn5pEboiA=
X-Received: by 2002:a17:906:e08c:b0:920:da8c:f7b0 with SMTP id
 gh12-20020a170906e08c00b00920da8cf7b0mr4253108ejb.6.1679835877332; Sun, 26
 Mar 2023 06:04:37 -0700 (PDT)
MIME-Version: 1.0
Reply-To: abusalam8070@gmail.com
Sender: odak33261@gmail.com
Received: by 2002:a05:6f02:a457:b0:48:d520:7825 with HTTP; Sun, 26 Mar 2023
 06:04:36 -0700 (PDT)
From:   "Mr. Abu Salam" <abu4870630@gmail.com>
Date:   Sun, 26 Mar 2023 13:04:36 +0000
X-Google-Sender-Auth: E4aOoDFK_8MGySTAHtb-vYgf_2s
Message-ID: <CADZqTUkS0nhEj4a_oxSs97fvpwPdbQv+0CcbjCOJEXJWf3QRtg@mail.gmail.com>
Subject: REPLY URGENTLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52d listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [odak33261[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [abu4870630[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abusalam8070[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.1 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhcsKgRnJpZW5kLA0KDQpNecKgbmFtZcKgaXPCoE1yLsKgQWJ1wqBTYWxhbS7CoEnCoGFtwqB3
b3JraW5nwqB3aXRowqBvbmXCoG9mwqB0aGXCoHByaW1lwqBiYW5rc8KgaW4NCkJ1cmtpbmHCoEZh
c28uwqBIZXJlwqBpbsKgdGhpc8KgYmFua8KgZXhpc3RlZMKgYWRvcm1hbnTCoGFjY291bnRmb3LC
oG1hbnkNCnllYXJzLMKgd2hpY2jCoGJlbG9uZ2VkwqB0b8Kgb25lwqBvZsKgb3VywqBsYXRlwqBm
b3JlaWduwqBjdXN0b21lcnMuwqBUaGXCoGFtb3VudA0KaW7CoHRoaXPCoGFjY291bnTCoHN0YW5k
c8KgYXTCoCQxMywzMDAsMDAwLjAwIChUaGlydGVlbsKgTWlsbGlvbsKgVGhyZWUNCkh1bmRyZWTC
oFRob3VzYW5kwqBVU8KgRG9sbGFycykuDQoNCknCoHdhbnTCoGHCoGZvcmVpZ27CoGFjY291bnTC
oHdoZXJlwqB0aGXCoGJhbmvCoHdpbGzCoHRyYW5zZmVywqB0aGlzwqBmdW5kLsKgSQ0Ka25vd8Kg
eW91wqB3b3VsZMKgYmXCoHN1cnByaXNlZMKgdG/CoHJlYWR0aGlzwqBtZXNzYWdlLGVzcGVjaWFs
bHnCoGZyb21zb21lb25lDQpyZWxhdGl2ZWx5wqB1bmtub3duwqB0b8KgeW91LsKgQnV0LMKgZG/C
oG5vdMKgd29ycnnCoHlvdXJzZWxmwqBzb8KgbXVjaC7CoFRoaXPCoGlzDQphwqBnZW51aW5lLMKg
cmlza8KgZnJlZcKgYW5kwqBsZWdhbMKgYnVzaW5lc3PCoHRyYW5zYWN0aW9uLsKgQWxswqBkZXRh
aWxzwqBzaGFsbA0KYmXCoHNlbnTCoHRvwqB5b3XCoG9uY2XCoEnCoHJlY2VpdmXCoHlvdXLCoGtp
bmTCoHJlc3BvbnNlLg0KDQpJwqB3YXPCoHZlcnnCoGZvcnR1bmF0ZcKgdG/CoGNvbWXCoGFjcm9z
c8KgdGhlwqBkZWNlYXNlZMKgY3VzdG9tZXInc8Kgc2VjdXJpdHkNCmZpbGXCoGR1cmluZ8KgZG9j
dW1lbnRhdGlvbsKgb2bCoG9sZMKgYW5kwqBhYmFuZG9uZWQgY3VzdG9tZXInc8KgZmlsZXPCoGZv
csKgYW4NCm9mZmljaWFswqBkb2N1bWVudGF0aW9uwqBhbmTCoGF1ZGl0wqBvZsKgdGhlwqB5ZWFy
wqAyMDIyLg0KDQpJZsKgeW91wqBhcmXCoHJlYWxsecKgc3VyZcKgb2bCoHlvdXLCoHNpbmNlcml0
eSzCoHRydXN0d29ydGhpbmVzcywNCmFjY291bnRhYmlsaXR5wqBhbmTCoGNvbmZpZGVudGlhbGl0
ecKgb3ZlcsKgdGhpc8KgdHJhbnNhY3Rpb24swqByZXBsecKgYmFjaw0KdG/CoG1lIHVyZ2VudGx5
wqB0aHJvdWdowqBtecKgcHJpdmF0ZcKgZW1haWzCoGFkZHJlc3M6DQphYnVzYWxhbTgwNzBAZ21h
aWwuY29tDQoNCkJlc3TCoHJlZ2FyZHMuDQpNci7CoEFidcKgU2FsYW0NCg==
