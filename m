Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030A861DA68
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 13:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKEMl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 08:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKEMlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 08:41:25 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CC517A96
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 05:41:23 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v3so6576236pgh.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 05:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=Gk3yZkhSi6kYo66CMsVzsZ0alEOX+al83gx6YdeteiBBVjnxsZU2QYCBC9VEJIM00v
         7svSVfAQgB1OM9CBG8BxLa08CIzx6fcyotbWwuEhNcwqsJrImasLjO0ZErwH5N90I1ug
         IrNm1s5GhU4Xr8el/rUqm7iupqfXdmiOM+R9kNzO5fjRcjAbEXcvgt6TJ0ToasJKqnJY
         Y4d9qY7dbLGefEmvDJGs/MNc7mxd9n8/qewVAPQmesAb0mrKhotmtmN/XYbqf7AdrtbF
         kFgNysecpcLwtQw6LYiZljopkaNO4EQGd6aqfJAeKWQJEz56eaSKP9dw+VLpMjTOmd4h
         5J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=XnTD+PxBrXJfwrHBprVfAX262ofBm78+cNlEq12Kx5jWs3tR77gFx2ZS2zWVuvXqW5
         UaqNXc3HQ/m2VLmEYC+681AriUvhEE28LAkeMj+MPr1CfyQdwJh/ya0d9WRZQN6DP4D0
         mWgFwuyAnm+cI36BtPAF8CG9rbMYHO9eGLB7oY3TopVA2aL55RRobUBal9AhMFuhtXfj
         v6RAQWHNId9wkt1B5uoOF7Q8Tmzbu3ke8thvxMIAeL/i3kTlpJka7v21qT6ILIzBs14M
         0mi02gtuLXjNJjxXKekZZoNvrLMGRNq0bbVQZNefeJCYxT9CW2m1GZ21nkc1RQ6dwd7R
         YBjA==
X-Gm-Message-State: ACrzQf0ZvWrFefD8uvJREMwGzOT9mNzLGbhPrw7ayNTCiYH0d9VZ+uN6
        nc7fm76tSW2HPMfZ2/yFMmbQNqGrkxN6B3vZ0nA=
X-Google-Smtp-Source: AMsMyM6kqzCzfrqLK3vl++KQvCb19Cm4GHRD1oroff3O19iaI2ZQYJSFxfKBngBvdZ4dnpcv1Jd81oVv9D3tC3u9PN8=
X-Received: by 2002:a63:6a87:0:b0:46f:8fcc:de1a with SMTP id
 f129-20020a636a87000000b0046f8fccde1amr30833900pgc.429.1667652083204; Sat, 05
 Nov 2022 05:41:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:548c:b0:a4:6bf8:6067 with HTTP; Sat, 5 Nov 2022
 05:41:22 -0700 (PDT)
Reply-To: stefanopessia755@hotmail.com
From:   Stefano Pessina <dkunitedfrontselfhelpgroup@gmail.com>
Date:   Sat, 5 Nov 2022 15:41:22 +0300
Message-ID: <CAJ0kvzVeqEoSzfpKLssYZf+=zhBcTAcb039NU_ZkRbhX-Nt-EA@mail.gmail.com>
Subject: Geldspende
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Die Summe von 500.000,00 =E2=82=AC wurde Ihnen von STEFANO PESSINA gespende=
t.
Bitte kontaktieren Sie uns f=C3=BCr weitere Informationen =C3=BCber
stefanopessia755@hotmail.com
